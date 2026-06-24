-- Metric views for domain: finance | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice KPIs measuring spend, discount capture, payment timeliness, and match compliance to steer working capital and vendor management decisions."
  source: "`vibe_healthcare_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Lifecycle status of the AP invoice (e.g., open, paid, void) used to track payables aging and exceptions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the invoice, used to monitor approval bottlenecks in the payables workflow."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (standard, credit memo, etc.) for spend categorization."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match outcome (PO/receipt/invoice) used to assess procurement control compliance."
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Currency of the invoice for multi-currency spend analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month bucket for trending payables volume and spend over time."
  measures:
    - name: "Invoice Count"
      expr: COUNT(1)
      comment: "Total number of AP invoices, baseline volume measure for payables workload."
    - name: "Total Invoice Amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total gross invoice spend, a core measure of organizational cash outflow obligations."
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoices, supporting tax reporting and recovery analysis."
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured, a working-capital optimization metric."
    - name: "Total Freight Amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost on invoices, supporting logistics cost monitoring."
    - name: "Average Invoice Amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice value, used to detect anomalous spend and benchmark vendor billing."
    - name: "Distinct Vendor Count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors billed, used for vendor consolidation and concentration analysis."
    - name: "PO Matched Invoice Count"
      expr: SUM(CASE WHEN po_match_indicator = true THEN 1 ELSE 0 END)
      comment: "Count of PO-matched invoices, supporting procurement-control compliance rate calculation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable disbursement KPIs measuring payment volume, discount realization, and reconciliation status to manage cash disbursement and treasury operations."
  source: "`vibe_healthcare_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (issued, cleared, void) for disbursement tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, ACH, wire) for analyzing electronic vs paper payment mix."
    - name: "payment_type"
      expr: payment_type
      comment: "Type/category of payment used to segment disbursement analysis."
    - name: "payment_reconciliation_status"
      expr: payment_reconciliation_status
      comment: "Reconciliation state of the payment, key to treasury and audit controls."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month bucket for trending disbursement volume and cash outflow."
  measures:
    - name: "Payment Count"
      expr: COUNT(1)
      comment: "Total number of AP payments, baseline disbursement volume metric."
    - name: "Total Payment Amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed to vendors, a core treasury cash-outflow KPI."
    - name: "Total Discount Taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts realized, measuring working-capital savings effectiveness."
    - name: "Average Payment Amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment size, used to detect outlier disbursements and benchmark payment runs."
    - name: "Electronic Payment Count"
      expr: SUM(CASE WHEN payment_method IN ('ACH','WIRE','EFT') THEN 1 ELSE 0 END)
      comment: "Count of electronic payments, supporting paper-to-electronic conversion rate tracking for efficiency."
    - name: "Distinct Vendor Count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors paid, used for disbursement concentration analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable account KPIs measuring outstanding balances, collections effectiveness, disputes, and write-offs to steer revenue cycle and collections strategy."
  source: "`vibe_healthcare_v1`.`finance`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of the AR account (active, closed, in collections) for collections segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of receivable account used to segment AR portfolio analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the receivable, central to AR aging and DSO analysis."
    - name: "debtor_type"
      expr: debtor_type
      comment: "Type of debtor (patient, payer, etc.) for receivable risk segmentation."
  measures:
    - name: "Account Count"
      expr: COUNT(1)
      comment: "Total number of AR accounts, baseline portfolio size metric."
    - name: "Total Current Balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding receivable balance, the core measure of cash tied up in AR."
    - name: "Total Original Balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original billed amount, used as denominator for collection-rate analysis."
    - name: "Total Payments Received"
      expr: SUM(CAST(total_payments_received AS DOUBLE))
      comment: "Total payments collected against accounts, a direct collections-effectiveness measure."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total receivables written off, a key revenue-leakage and bad-debt KPI."
    - name: "Disputed Account Count"
      expr: SUM(CASE WHEN dispute_flag = true THEN 1 ELSE 0 END)
      comment: "Count of accounts in dispute, signaling collections friction requiring intervention."
    - name: "Average Days Outstanding"
      expr: AVG(CAST(days_outstanding AS DOUBLE))
      comment: "Average days receivables remain outstanding, a proxy for DSO and collections velocity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating and capital budget KPIs measuring planned revenue, expense, capital, and FTE commitments to support financial planning and resource allocation decisions."
  source: "`vibe_healthcare_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital) for planning segmentation."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval/lifecycle status of the budget used to track planning cycle progress."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget for grouping planning analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for year-over-year planning comparison."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (operating, grant, donor) for restricted-fund planning."
  measures:
    - name: "Budget Count"
      expr: COUNT(1)
      comment: "Total number of budgets, baseline planning artifact count."
    - name: "Total Budgeted Revenue"
      expr: SUM(CAST(total_budgeted_revenue AS DOUBLE))
      comment: "Total planned revenue, a core financial planning target steering the business."
    - name: "Total Budgeted Expense"
      expr: SUM(CAST(total_budgeted_expense AS DOUBLE))
      comment: "Total planned expense, the principal cost-control planning measure."
    - name: "Total Budgeted Capital"
      expr: SUM(CAST(total_budgeted_capital AS DOUBLE))
      comment: "Total planned capital expenditure, steering capital allocation decisions."
    - name: "Total Budgeted Net Income"
      expr: SUM(CAST(budgeted_net_income AS DOUBLE))
      comment: "Total planned net income, the bottom-line financial target for the period."
    - name: "Total Budgeted FTE"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total planned full-time equivalents, the core workforce-investment planning measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry KPIs measuring posting volume, debit/credit totals, adjustments, and reversals to monitor general ledger integrity and close quality."
  source: "`vibe_healthcare_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Posting state of the journal entry (draft, posted) for close-process monitoring."
    - name: "journal_category"
      expr: journal_category
      comment: "Category of the journal entry for grouping GL activity analysis."
    - name: "journal_source"
      expr: journal_source
      comment: "Source system or origin of the entry, used to assess automation vs manual entry mix."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry for period-over-period GL trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month bucket for trending GL activity over time."
  measures:
    - name: "Journal Entry Count"
      expr: COUNT(1)
      comment: "Total number of journal entries, baseline GL activity volume."
    - name: "Total Debit Amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debits posted, used with credits to verify ledger balance integrity."
    - name: "Total Credit Amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credits posted, used with debits to verify ledger balance integrity."
    - name: "Reversal Entry Count"
      expr: SUM(CASE WHEN reversal_indicator = true THEN 1 ELSE 0 END)
      comment: "Count of reversal entries, a key indicator of error/rework rate in the GL."
    - name: "Manual Adjustment Count"
      expr: SUM(CASE WHEN adjustment_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of adjustment entries, supporting close-quality and control monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project KPIs measuring approved budget, committed and actual costs, variance, and expected returns to steer capital portfolio management."
  source: "`vibe_healthcare_v1`.`finance`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Status of the capital project (planning, active, complete) for portfolio tracking."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project lifecycle for delivery monitoring."
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project for portfolio segmentation."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority ranking of the project, used to align capital spend with strategic priorities."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the project, supporting restricted vs operating capital analysis."
  measures:
    - name: "Project Count"
      expr: COUNT(1)
      comment: "Total number of capital projects, baseline portfolio size."
    - name: "Total Approved Capital Budget"
      expr: SUM(CAST(approved_capital_budget AS DOUBLE))
      comment: "Total approved capital budget, the core capital-commitment planning measure."
    - name: "Total Committed Costs"
      expr: SUM(CAST(total_committed_costs AS DOUBLE))
      comment: "Total committed costs across projects, used to monitor capital budget consumption."
    - name: "Total Actual Costs"
      expr: SUM(CAST(total_actual_costs AS DOUBLE))
      comment: "Total actual capital spend, the principal measure of capital deployment."
    - name: "Total Variance Amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance across the capital portfolio, a key overrun-risk KPI."
    - name: "Total Expected Annual Revenue"
      expr: SUM(CAST(expected_annual_revenue AS DOUBLE))
      comment: "Total expected annual revenue from projects, supporting capital ROI prioritization."
    - name: "Average Variance Percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average percent variance to budget, a normalized capital-discipline indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset KPIs measuring acquisition cost, accumulated depreciation, net book value, and disposals to manage the asset base and capital lifecycle."
  source: "`vibe_healthcare_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Status of the asset (in service, disposed) for asset lifecycle tracking."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset for fixed-asset portfolio segmentation."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied, relevant to depreciation expense analysis."
    - name: "lease_type"
      expr: lease_type
      comment: "Lease classification, supporting owned vs leased asset analysis."
  measures:
    - name: "Asset Count"
      expr: COUNT(1)
      comment: "Total number of fixed assets, baseline asset-base size."
    - name: "Total Acquisition Cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of assets, the gross capital investment in the asset base."
    - name: "Total Accumulated Depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation, indicating aging of the asset base."
    - name: "Total Net Book Value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets, the carrying value steering replacement planning."
    - name: "Total Disposal Proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals, a measure of asset recovery value."
    - name: "FDA Regulated Asset Count"
      expr: SUM(CASE WHEN fda_regulated_indicator = true THEN 1 ELSE 0 END)
      comment: "Count of FDA-regulated assets, supporting compliance and biomedical equipment oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation KPIs measuring allocated amounts, adjustments, and source cost pools to steer overhead distribution and Medicare cost reporting accuracy."
  source: "`vibe_healthcare_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of cost allocation for grouping overhead distribution analysis."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for allocating costs, key to allocation methodology review."
    - name: "allocation_tier"
      expr: allocation_tier
      comment: "Step-down allocation tier, supporting Medicare cost-report stepdown analysis."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Allocation month bucket for trending overhead distribution over time."
  measures:
    - name: "Allocation Count"
      expr: COUNT(1)
      comment: "Total number of cost allocation records, baseline allocation activity volume."
    - name: "Total Allocated Amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across cost centers, the core overhead-distribution measure."
    - name: "Total Allocation Adjustment"
      expr: SUM(CAST(allocation_adjustment_amount AS DOUBLE))
      comment: "Total allocation adjustments, indicating rework/correction in the allocation process."
    - name: "Total Source Cost Pool"
      expr: SUM(CAST(source_cost_pool_amount AS DOUBLE))
      comment: "Total source cost pool amount, used as the basis for allocation-rate analysis."
    - name: "Medicare Reportable Count"
      expr: SUM(CASE WHEN is_medicare_reportable = true THEN 1 ELSE 0 END)
      comment: "Count of Medicare-reportable allocations, supporting CMS cost-report compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_financial_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period close KPIs measuring days to close, checklist completion, and open items to drive close-cycle efficiency and financial reporting timeliness."
  source: "`vibe_healthcare_v1`.`finance`.`financial_period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Current close status (open, soft close, hard close) for close-process tracking."
    - name: "close_type"
      expr: close_type
      comment: "Type of close (monthly, quarterly, annual) for close-cycle segmentation."
    - name: "close_efficiency_rating"
      expr: close_efficiency_rating
      comment: "Qualitative efficiency rating of the close, summarizing close performance."
  measures:
    - name: "Close Count"
      expr: COUNT(1)
      comment: "Total number of period close instances, baseline close activity volume."
    - name: "Average Days To Close"
      expr: AVG(CAST(days_to_close AS DOUBLE))
      comment: "Average days to complete the close, the core close-cycle efficiency KPI."
    - name: "Average Checklist Completion Percent"
      expr: AVG(CAST(close_checklist_completion_percentage AS DOUBLE))
      comment: "Average close checklist completion percent, measuring close-process discipline."
    - name: "Total Open Items"
      expr: SUM(CAST(open_items_count AS DOUBLE))
      comment: "Total open items across closes, signaling backlog requiring attention."
    - name: "Prior Period Adjustment Count"
      expr: SUM(CASE WHEN prior_period_adjustment_flag = true THEN 1 ELSE 0 END)
      comment: "Count of closes with prior-period adjustments, a financial-reporting quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_financial_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecast KPIs measuring projected revenue, expense, and net income to support rolling forecasting and strategic financial steering."
  source: "`vibe_healthcare_v1`.`finance`.`financial_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (draft, approved) for forecast-cycle tracking."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast for scenario segmentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast for year-over-year forecast comparison."
    - name: "scenario_description"
      expr: scenario_description
      comment: "Forecast scenario label (base, optimistic, pessimistic) for scenario analysis."
  measures:
    - name: "Forecast Count"
      expr: COUNT(1)
      comment: "Total number of forecasts, baseline forecast activity volume."
    - name: "Total Forecasted Revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total projected revenue, a core forward-looking financial-steering measure."
    - name: "Total Forecasted Expense"
      expr: SUM(CAST(total_forecasted_expense AS DOUBLE))
      comment: "Total projected expense, the principal forward-looking cost-control measure."
    - name: "Total Forecasted Net Income"
      expr: SUM(CAST(total_forecasted_net_income AS DOUBLE))
      comment: "Total projected net income, the bottom-line forecast target for leadership."
    - name: "Total Forecasted Operating Income"
      expr: SUM(CAST(total_forecasted_operating_income AS DOUBLE))
      comment: "Total projected operating income, isolating core-operations profitability outlook."
    - name: "Total Forecasted Capital Expenditure"
      expr: SUM(CAST(total_forecasted_capital_expenditure AS DOUBLE))
      comment: "Total projected capital spend, steering forward capital-allocation planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation KPIs measuring unreconciled variance, outstanding items, and exceptions to ensure cash-position integrity and treasury controls."
  source: "`vibe_healthcare_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation (in progress, completed) for treasury-control tracking."
    - name: "auto_reconciliation_flag"
      expr: auto_reconciliation_flag
      comment: "Whether reconciliation was automated, used for automation-rate analysis."
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Bank statement month bucket for trending reconciliation activity."
  measures:
    - name: "Reconciliation Count"
      expr: COUNT(1)
      comment: "Total number of bank reconciliations, baseline treasury-control volume."
    - name: "Total Unreconciled Variance"
      expr: SUM(CAST(unreconciled_variance AS DOUBLE))
      comment: "Total unreconciled variance, a critical cash-integrity and control-risk KPI."
    - name: "Total Outstanding Checks"
      expr: SUM(CAST(outstanding_checks_total AS DOUBLE))
      comment: "Total outstanding checks, supporting cash-position and float analysis."
    - name: "Total Deposits In Transit"
      expr: SUM(CAST(deposits_in_transit_total AS DOUBLE))
      comment: "Total deposits in transit, supporting cash-position reconciliation."
    - name: "Exception Reconciliation Count"
      expr: SUM(CASE WHEN exception_flag = true THEN 1 ELSE 0 END)
      comment: "Count of reconciliations flagged with exceptions, signaling control issues requiring action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction KPIs measuring transaction amounts, eliminations, and reconciliation variance to support consolidation and transfer-pricing compliance."
  source: "`vibe_healthcare_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the intercompany transaction for consolidation tracking."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction for segmentation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state, key to intercompany balance integrity at consolidation."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month bucket for trending intercompany activity."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions, baseline volume measure."
    - name: "Total Transaction Amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction value, the core consolidation-elimination measure."
    - name: "Total Reconciliation Variance"
      expr: SUM(CAST(reconciliation_variance_amount AS DOUBLE))
      comment: "Total intercompany reconciliation variance, a key consolidation-integrity risk KPI."
    - name: "Elimination Transaction Count"
      expr: SUM(CASE WHEN elimination_indicator = true THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged for elimination, supporting consolidation completeness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund KPIs measuring balances, endowment corpus, and restriction status to manage restricted and endowment fund stewardship."
  source: "`vibe_healthcare_v1`.`finance`.`fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (operating, endowment, restricted) for fund-portfolio segmentation."
    - name: "fund_status"
      expr: fund_status
      comment: "Status of the fund (active, closed) for fund-lifecycle tracking."
    - name: "fund_category"
      expr: fund_category
      comment: "Category of the fund for grouping fund-balance analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of donor restriction, central to restricted-fund compliance reporting."
  measures:
    - name: "Fund Count"
      expr: COUNT(1)
      comment: "Total number of funds, baseline fund-portfolio size."
    - name: "Total Fund Balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total fund balance across funds, the core measure of fund resources available."
    - name: "Total Endowment Corpus"
      expr: SUM(CAST(endowment_corpus_amount AS DOUBLE))
      comment: "Total endowment corpus, the protected principal steering spending-policy decisions."
    - name: "Restricted Fund Count"
      expr: SUM(CASE WHEN donor_restriction_indicator = true THEN 1 ELSE 0 END)
      comment: "Count of donor-restricted funds, supporting restricted-fund stewardship and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_donor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor KPIs measuring lifetime giving, affinity, and segment mix to steer philanthropy and development strategy."
  source: "`vibe_healthcare_v1`.`finance`.`donor`"
  dimensions:
    - name: "donor_status"
      expr: donor_status
      comment: "Status of the donor (active, lapsed) for donor-lifecycle segmentation."
    - name: "donor_type"
      expr: donor_type
      comment: "Type of donor (individual, corporate, foundation) for development segmentation."
    - name: "segment"
      expr: segment
      comment: "Donor segment for targeted solicitation strategy analysis."
    - name: "wealth_capacity_rating"
      expr: wealth_capacity_rating
      comment: "Wealth capacity rating used to prioritize major-gift cultivation."
  measures:
    - name: "Donor Count"
      expr: COUNT(1)
      comment: "Total number of donors, baseline donor-base size."
    - name: "Total Lifetime Giving"
      expr: SUM(CAST(lifetime_giving_amount AS DOUBLE))
      comment: "Total lifetime giving across donors, the core philanthropy-value measure."
    - name: "Average Affinity Score"
      expr: AVG(CAST(affinity_score AS DOUBLE))
      comment: "Average donor affinity score, a predictive indicator for development prioritization."
    - name: "Planned Giving Donor Count"
      expr: SUM(CASE WHEN planned_giving_flag = true THEN 1 ELSE 0 END)
      comment: "Count of donors with planned giving, supporting legacy-giving pipeline management."
    - name: "Matching Gift Eligible Count"
      expr: SUM(CASE WHEN matching_gift_eligible_flag = true THEN 1 ELSE 0 END)
      comment: "Count of matching-gift-eligible donors, identifying revenue-amplification opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable transaction KPIs measuring transaction amounts, write-offs, and reconciliation status to monitor receivable activity and collections posting."
  source: "`vibe_healthcare_v1`.`finance`.`ar_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of AR transaction (payment, adjustment, charge) for receivable activity segmentation."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting state of the transaction for AR ledger tracking."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket of the transaction for receivable aging analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month bucket for trending receivable activity over time."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Total number of AR transactions, baseline receivable activity volume."
    - name: "Total Transaction Amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total AR transaction value, the core measure of receivable posting activity."
    - name: "Total Functional Amount"
      expr: SUM(CAST(functional_amount AS DOUBLE))
      comment: "Total transaction amount in functional currency, supporting consolidated AR analysis."
    - name: "Reversal Transaction Count"
      expr: SUM(CASE WHEN reversal_flag = true THEN 1 ELSE 0 END)
      comment: "Count of reversed transactions, a rework/error indicator in receivable processing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_capital_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure metrics"
  source: "`vibe_healthcare_v1`.`finance`.`capital_expenditure`"
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