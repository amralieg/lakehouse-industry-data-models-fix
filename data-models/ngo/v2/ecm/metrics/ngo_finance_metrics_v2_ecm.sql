-- Metric views for domain: finance | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget performance metrics for NGO program and grant budgets. Supports dual-framework reporting under both US GAAP (ASC 958, Form 990 functional expense) and IPSAS (IPSAS 24 budget reporting). Aligns with SAP/VISION budget modules used by UN agencies and eTools programme management. Enables CFO-level burn rate monitoring, variance analysis, and cost-share compliance tracking across awards and country offices."
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget, enabling year-over-year comparison and annual planning cycles."
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Current lifecycle status of the budget (draft, approved, closed). Drives workflow and reporting eligibility."
    - name: "budget_type"
      expr: CAST(budget_type AS STRING)
      comment: "Classification of budget type (operational, grant, project). Supports segmented financial analysis."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Budget period start month, used for time-series trending of budget allocations."
    - name: "period_end_date"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Budget period end month, used to identify expiring budgets and closeout planning."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing partner transfer modality (cash, direct, reimbursement). Critical for HACT compliance and UNICEF/UNDP programme finance reporting."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount across all budget records. Primary top-line budget figure for executive dashboards and donor reporting under ASC 958 / IPSAS 24."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure recorded against budgets. Core metric for burn rate analysis and financial accountability to donors and boards."
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Aggregate budget variance (approved minus actual). Negative values signal over-expenditure requiring immediate management action."
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct program cost budget. Used to assess program delivery investment versus indirect/overhead costs per ASC 958 functional expense classification."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost (overhead) budget. Compared against NICRA-negotiated rates to ensure compliance with US federal cost principles (2 CFR 200) and IPSAS."
    - name: "total_cost_share_requirement"
      expr: SUM(CAST(cost_share_requirement_amount AS DOUBLE))
      comment: "Total cost-share (match) requirement across all budgets. Tracks organizational obligation to co-fund programs as required by donor agreements."
    - name: "avg_burn_rate_percentage"
      expr: AVG(CAST(burn_rate_percentage AS DOUBLE))
      comment: "Average budget burn rate percentage across active budgets. A burn rate significantly above or below 100% at period-end triggers financial management intervention."
    - name: "avg_icr_rate_applied"
      expr: AVG(CAST(icr_rate_applied AS DOUBLE))
      comment: "Average indirect cost recovery (ICR) rate applied across budgets. Monitors consistency with negotiated NICRA rates and donor-specific overhead caps."
    - name: "total_award_ceiling"
      expr: SUM(CAST(award_ceiling_amount AS DOUBLE))
      comment: "Sum of award ceiling amounts across all budgets. Represents the maximum obligated funding envelope, critical for pipeline and liquidity planning."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Used as denominator for per-budget averages and to track portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget execution metrics enabling granular cost category analysis, cost-share tracking, and allowability compliance. Supports US GAAP functional expense reporting (ASC 958), IPSAS segment reporting, and donor budget narrative reconciliation. Used by grants managers and finance controllers in SAP/VISION and Integra environments."
  source: "`vibe_ngo_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "cost_type"
      expr: CAST(cost_type AS STRING)
      comment: "Cost type classification (direct, indirect, cost-share). Drives allowability and functional expense reporting."
    - name: "expense_category"
      expr: CAST(expense_category AS STRING)
      comment: "Expense category (personnel, travel, supplies, etc.). Core dimension for functional expense analysis under ASC 958 and IPSAS."
    - name: "donor_budget_category"
      expr: CAST(donor_budget_category AS STRING)
      comment: "Donor-defined budget category. Required for donor financial reporting and budget narrative compliance."
    - name: "budget_period_type"
      expr: CAST(budget_period_type AS STRING)
      comment: "Budget period type (annual, multi-year, quarterly). Supports period-based burn analysis."
    - name: "is_cost_share"
      expr: is_cost_share
      comment: "Flag indicating whether the line is a cost-share (match) contribution. Essential for tracking match fulfillment obligations."
    - name: "is_allowable"
      expr: is_allowable
      comment: "Flag indicating whether the cost is allowable under the applicable award terms and cost principles (2 CFR 200 / IPSAS)."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of budget line approval. Tracks approval pipeline velocity."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original budget line amounts before revisions. Baseline for measuring scope changes and budget modifications."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget line amounts after approved modifications. Current authorized spending envelope at line level."
    - name: "total_budget_revision_delta"
      expr: SUM(CAST(revised_amount AS DOUBLE) - CAST(original_amount AS DOUBLE))
      comment: "Net change from original to revised budget amounts. Quantifies the cumulative impact of budget modifications on the award."
    - name: "total_unit_cost_value"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(quantity AS DOUBLE))
      comment: "Total computed cost (unit cost × quantity) across budget lines. Cross-checks against approved line amounts for budget integrity."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied at budget line level. Monitors consistency with NICRA agreement rates across the portfolio."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average cost allocation percentage across shared cost lines. Supports equitable cost distribution analysis."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines. Used to assess budget complexity and as denominator for per-line averages."
    - name: "cost_share_line_count"
      expr: COUNT(CASE WHEN is_cost_share = TRUE THEN 1 END)
      comment: "Number of budget lines designated as cost-share. Tracks match commitment depth across the budget."
    - name: "unallowable_line_count"
      expr: COUNT(CASE WHEN is_allowable = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as unallowable. A non-zero value is a compliance risk requiring immediate review before donor submission."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget version lifecycle and revision tracking metrics. Monitors the frequency and magnitude of budget modifications, baseline vs. revised budget comparisons, and approval cycle times. Critical for grant compliance (prior approval thresholds under 2 CFR 200) and IPSAS budget amendment reporting. Supports SAP budget version management workflows."
  source: "`vibe_ngo_v1`.`finance`.`budget_version`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget version. Enables year-over-year revision frequency analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget version. Supports intra-year revision tracking."
    - name: "version_type"
      expr: version_type
      comment: "Type of budget version (baseline, amendment, reforecast). Distinguishes original budgets from donor-approved modifications."
    - name: "budget_version_status"
      expr: budget_version_status
      comment: "Current status of the budget version (draft, submitted, approved, locked). Drives workflow and audit trail."
    - name: "is_baseline"
      expr: is_baseline
      comment: "Flag indicating whether this is the original baseline budget. Used to isolate baseline vs. revised budget comparisons."
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating whether the budget version is locked from further modification. Locked versions represent the authoritative approved budget."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the budget version became effective. Used for time-series analysis of budget evolution."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget amount across all versions. Compared against baseline to quantify cumulative modification impact."
    - name: "total_revenue_budget"
      expr: SUM(CAST(revenue_budget_amount AS DOUBLE))
      comment: "Total revenue budget across versions. Tracks expected income against expenditure budgets for net position analysis."
    - name: "total_expense_budget"
      expr: SUM(CAST(expense_budget_amount AS DOUBLE))
      comment: "Total expense budget across versions. Primary expenditure authorization figure for financial management."
    - name: "budget_version_count"
      expr: COUNT(1)
      comment: "Total number of budget versions. High version counts signal frequent modifications, a risk indicator for grant compliance and donor relations."
    - name: "locked_version_count"
      expr: COUNT(CASE WHEN is_locked = TRUE THEN 1 END)
      comment: "Number of locked (finalized) budget versions. Ratio to total versions indicates budget stability."
    - name: "baseline_version_count"
      expr: COUNT(CASE WHEN is_baseline = TRUE THEN 1 END)
      comment: "Number of baseline budget versions. Should equal the number of distinct awards/programs; deviations indicate data quality issues."
    - name: "avg_total_budget_amount"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average total budget amount per version. Provides a per-version benchmark for portfolio sizing."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry volume and compliance metrics. Monitors posting activity, reversal rates, adjustment frequency, and inter-company transaction volumes. Supports audit readiness under US GAAP (ASC 958), IPSAS, and donor audit requirements. Relevant to SAP/VISION GL module and Integra ERP environments used by large INGOs."
  source: "`vibe_ngo_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (standard, reversal, adjustment, inter-company). Drives audit classification and review prioritization."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (posted, pending, reversed). Unposted entries represent unrecognized financial activity."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of journal posting. Enables monthly close activity analysis and period-end volume trending."
    - name: "document_date"
      expr: DATE_TRUNC('month', document_date)
      comment: "Month of the source document date. Compared to posting date to identify late postings."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Flag for adjustment journal entries. High adjustment rates may indicate systemic data quality or process issues."
    - name: "is_inter_company"
      expr: is_inter_company
      comment: "Flag for inter-company/inter-entity transactions. Critical for consolidation eliminations under IPSAS and US GAAP."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating the journal entry has a compliance concern. Drives audit follow-up and internal control review."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group (e.g., leading ledger, IPSAS ledger, donor ledger). Supports parallel accounting under multiple frameworks."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Volume indicator for close cycle workload and audit scope."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. High reversal rates signal posting errors or process breakdowns requiring control improvement."
    - name: "adjustment_entry_count"
      expr: COUNT(CASE WHEN is_adjustment = TRUE THEN 1 END)
      comment: "Number of adjustment journal entries. Tracks manual correction volume as a financial control quality indicator."
    - name: "compliance_flagged_entry_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of journal entries flagged for compliance review. Non-zero values require immediate investigation before period close."
    - name: "inter_company_entry_count"
      expr: COUNT(CASE WHEN is_inter_company = TRUE THEN 1 END)
      comment: "Number of inter-company journal entries. Used for consolidation reconciliation and elimination analysis."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across journal entries. Monitors currency translation consistency with UN operational rates and donor-required rates."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL line-level financial flow metrics providing the most granular view of debit/credit activity, cost allocation, and donor restriction compliance. Core data for trial balance, functional expense reporting (ASC 958 / IPSAS), and grant expenditure verification. Used in SAP/VISION line-item reporting and Integra ERP audit trails."
  source: "`vibe_ngo_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal line. Enables year-over-year expenditure comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal line. Supports monthly close and period-end financial reporting."
    - name: "functional_expense_category"
      expr: CAST(functional_expense_category AS STRING)
      comment: "Functional expense category (program services, management & general, fundraising). Required for ASC 958 Statement of Functional Expenses and Form 990 Part IX."
    - name: "donor_restriction_type"
      expr: donor_restriction_type
      comment: "Donor restriction type (unrestricted, temporarily restricted, permanently restricted). Drives net asset classification under ASC 958 and IPSAS 23."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Flag indicating whether the line is a direct program cost. Used to separate direct vs. indirect costs for NICRA base calculation."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Flag indicating cost allowability under applicable award terms. Unallowable costs must be excluded from grant expenditure reports."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of GL posting. Enables monthly expenditure trending and period-close analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal line. Unapproved lines represent unconfirmed financial activity."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal lines. One side of the double-entry ledger; must equal total credits for a balanced trial balance."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal lines. Must equal total debits; imbalance indicates a data integrity issue requiring immediate correction."
    - name: "net_expenditure_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net expenditure (debits minus credits) across journal lines. Represents net financial outflow for the selected dimension slice."
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines. Volume metric for audit scope and close cycle workload assessment."
    - name: "unallowable_cost_amount"
      expr: SUM(CASE WHEN allowable_cost_flag = FALSE THEN debit_amount ELSE 0 END)
      comment: "Total debit amount on lines flagged as unallowable. Must be zero on donor financial reports; any non-zero value is a compliance risk."
    - name: "indirect_cost_amount"
      expr: SUM(CASE WHEN direct_cost_flag = FALSE THEN debit_amount ELSE 0 END)
      comment: "Total indirect cost amount. Used to verify that indirect costs do not exceed NICRA-negotiated rates and donor overhead caps."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied at line level. Monitors rate consistency with negotiated NICRA agreements across the portfolio."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversal journal lines. Elevated reversal counts indicate posting quality issues requiring process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable aging, payment compliance, and vendor liability metrics. Monitors invoice processing cycle times, three-way match compliance, and outstanding liabilities. Supports cash flow management, vendor relationship health, and audit readiness under US GAAP and IPSAS. Relevant to SAP AP module and NGO procurement-to-pay workflows."
  source: "`vibe_ngo_v1`.`finance`.`payable`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status (pending, approved, disputed, paid). Drives AP workflow prioritization."
    - name: "payment_status"
      expr: CAST(payment_status AS STRING)
      comment: "Payment status of the payable (unpaid, partial, paid). Core dimension for AP aging and cash flow forecasting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (matched, unmatched, exception). Unmatched invoices represent a procurement control failure requiring resolution."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date. Enables monthly AP volume and liability trending."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month payment is due. Used for cash flow forecasting and identifying overdue payables."
    - name: "is_grant_eligible"
      expr: is_grant_eligible
      comment: "Flag indicating whether the payable is eligible for grant reimbursement. Critical for grant drawdown and donor financial reporting."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating the payable is funded from a restricted fund. Ensures restricted funds are used only for authorized purposes."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all payables. Represents total vendor liability before discounts and taxes."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice amount (after discounts). Actual cash obligation to vendors; key input for cash flow planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables. Monitors VAT/tax recoverability and compliance with host-country tax exemption agreements."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Tracks statutory withholding obligations in host countries."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in leveraging payment terms."
    - name: "payable_count"
      expr: COUNT(1)
      comment: "Total number of payable invoices. Volume metric for AP workload and vendor transaction frequency."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'MATCHED' THEN 1 END)
      comment: "Number of invoices not yet three-way matched. Unmatched invoices represent procurement control gaps and payment hold risks."
    - name: "grant_eligible_payable_amount"
      expr: SUM(CASE WHEN is_grant_eligible = TRUE THEN invoice_net_amount ELSE 0 END)
      comment: "Total net payable amount eligible for grant reimbursement. Directly informs grant drawdown requests and donor financial reports."
    - name: "avg_functional_currency_amount"
      expr: AVG(CAST(functional_currency_amount AS DOUBLE))
      comment: "Average payable amount in functional currency. Benchmarks typical invoice size for vendor and category analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payable_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution metrics tracking disbursement volumes, grant-funded payment flows, and indirect cost payment patterns. Supports cash management, grant drawdown reconciliation, and payment run performance analysis. Relevant to SAP payment program, UNICEF VISION payment processing, and NGO treasury operations."
  source: "`vibe_ngo_v1`.`finance`.`payable_payment`"
  dimensions:
    - name: "payment_type"
      expr: CAST(payment_type AS STRING)
      comment: "Type of payment (wire transfer, check, EFT, mobile money). Drives payment channel analysis and cost optimization."
    - name: "payment_status"
      expr: CAST(payment_status AS STRING)
      comment: "Status of the payment (pending, cleared, failed, reversed). Failed payments require immediate operational follow-up."
    - name: "payment_date"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment execution. Enables monthly disbursement trending and cash flow analysis."
    - name: "is_grant_funded"
      expr: is_grant_funded
      comment: "Flag indicating the payment is funded from a grant award. Segregates grant-funded disbursements for donor financial reporting."
    - name: "is_indirect_cost"
      expr: is_indirect_cost
      comment: "Flag indicating the payment covers indirect costs. Used to verify indirect cost payments against NICRA rate caps."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating payment from a restricted fund. Ensures restricted fund disbursements comply with donor-imposed restrictions."
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code associated with the payment. Enables activity-based cost analysis and program expenditure attribution."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary cash outflow metric for treasury and cash flow management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and withholding. Actual cash disbursed to vendors and partners."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted across payments. Tracks statutory withholding compliance in host countries."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in leveraging vendor payment terms."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency. Enables multi-currency portfolio analysis with a common currency baseline."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Volume metric for payment run efficiency and AP throughput."
    - name: "grant_funded_payment_amount"
      expr: SUM(CASE WHEN is_grant_funded = TRUE THEN payment_amount ELSE 0 END)
      comment: "Total payment amount funded from grants. Core metric for grant expenditure reporting and drawdown reconciliation."
    - name: "indirect_cost_payment_amount"
      expr: SUM(CASE WHEN is_indirect_cost = TRUE THEN payment_amount ELSE 0 END)
      comment: "Total indirect cost payments. Compared against NICRA-negotiated rate caps to ensure compliance with 2 CFR 200."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution performance and success rate metrics. Monitors batch payment processing efficiency, failure rates, and reconciliation status. Critical for treasury operations, vendor payment SLA compliance, and audit trail integrity. Supports SAP payment program analysis and NGO cash management dashboards."
  source: "`vibe_ngo_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (regular, emergency, payroll, grant disbursement). Enables run-type performance benchmarking."
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (scheduled, executing, completed, failed). Failed runs require immediate treasury intervention."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment run. Enables year-over-year payment volume and success rate comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment run. Supports period-end cash disbursement analysis."
    - name: "scheduled_date"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the payment run was scheduled. Used for payment calendar planning and cash flow forecasting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating a recurring payment run. Recurring runs represent standing obligations requiring periodic review."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment run. Unreconciled runs represent open items in the bank reconciliation."
  measures:
    - name: "total_payment_run_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount processed across all payment runs. Primary cash disbursement volume metric for treasury management."
    - name: "total_successful_amount"
      expr: SUM(CAST(successful_amount AS DOUBLE))
      comment: "Total amount successfully disbursed. Compared to total amount to compute payment success rate."
    - name: "total_failed_amount"
      expr: SUM(CAST(failed_amount AS DOUBLE))
      comment: "Total amount in failed payments. Failed amounts represent unmet vendor obligations requiring re-processing."
    - name: "total_payment_count"
      expr: SUM(CAST(total_payment_count AS DOUBLE))
      comment: "Total number of individual payments across all runs. Volume metric for payment processing capacity planning."
    - name: "total_successful_payment_count"
      expr: SUM(CAST(successful_payment_count AS DOUBLE))
      comment: "Total number of successfully processed payments. Numerator for payment success rate calculation."
    - name: "total_failed_payment_count"
      expr: SUM(CAST(failed_payment_count AS DOUBLE))
      comment: "Total number of failed payments. Elevated failure counts signal banking infrastructure or data quality issues."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Frequency metric for treasury workload and automation efficiency."
    - name: "avg_run_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount per payment run. Benchmarks typical run size for capacity planning and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging, collection performance, and revenue recognition metrics. Monitors outstanding donor receivables, grant drawdown balances, and write-off risk. Critical for liquidity management, donor relationship health, and revenue recognition under ASC 958 (conditional vs. unconditional contributions) and IPSAS 23 (non-exchange revenue). Supports SAP AR module and NGO grant management systems."
  source: "`vibe_ngo_v1`.`finance`.`receivable`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the receivable (current, overdue, in dispute, written off). Drives collection prioritization and bad debt provisioning."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice issuance. Enables monthly receivable origination trending."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month payment is due. Used for aging bucket analysis and cash flow forecasting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating the receivable is in dispute. Disputed receivables require active resolution to protect cash flow."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Method used to deliver the invoice (email, portal, mail). Supports invoice delivery optimization to reduce collection cycle times."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (wire, check, ACH). Enables payment channel analysis for treasury optimization."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across all receivables. Represents total expected cash inflows from donors and grant drawdowns."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance. Primary liquidity risk metric; high balances relative to cash reserves signal collection urgency."
    - name: "total_allowance_for_doubtful_accounts"
      expr: SUM(CAST(allowance_for_doubtful_accounts AS DOUBLE))
      comment: "Total allowance for doubtful accounts. Represents estimated uncollectible receivables; required for accurate net asset reporting under ASC 958 and IPSAS."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible. Tracks bad debt realization and informs future provisioning policy."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receivable amount in functional currency. Enables multi-currency portfolio analysis with a common currency baseline."
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Total number of receivable records. Volume metric for AR workload and donor billing frequency."
    - name: "disputed_receivable_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of receivables in dispute. Elevated dispute counts signal invoice quality or donor relationship issues requiring management attention."
    - name: "disputed_receivable_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN outstanding_balance ELSE 0 END)
      comment: "Total outstanding balance on disputed receivables. Quantifies the cash flow risk from unresolved billing disputes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_receivable_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash receipt and revenue recognition metrics tracking donor payment inflows, grant drawdown receipts, and matching gift activity. Supports ASC 958 revenue recognition (conditional vs. unconditional contributions), IPSAS 23 non-exchange revenue, and donor stewardship reporting. Critical for liquidity management and grant financial reporting in SAP/VISION and Salesforce Nonprofit Cloud environments."
  source: "`vibe_ngo_v1`.`finance`.`receivable_receipt`"
  dimensions:
    - name: "receipt_method"
      expr: receipt_method
      comment: "Payment method used by the donor/payer (wire, check, ACH, mobile money). Enables channel analysis and treasury optimization."
    - name: "receipt_channel"
      expr: receipt_channel
      comment: "Channel through which the receipt was received (online, in-person, bank transfer). Supports multi-channel fundraising and treasury analysis."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt (pending, posted, reconciled, reversed). Unposted receipts represent unrecognized revenue."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type (unrestricted, temporarily restricted, permanently restricted). Drives net asset classification under ASC 958 and IPSAS 23."
    - name: "deposit_date"
      expr: DATE_TRUNC('month', deposit_date)
      comment: "Month of bank deposit. Enables monthly cash inflow trending and bank reconciliation analysis."
    - name: "revenue_recognition_date"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month revenue was recognized. Tracks timing differences between cash receipt and revenue recognition under ASC 958 / IPSAS 23."
    - name: "is_matching_gift"
      expr: is_matching_gift
      comment: "Flag indicating a corporate matching gift receipt. Matching gifts represent leveraged fundraising value requiring separate tracking."
    - name: "is_refund"
      expr: is_refund
      comment: "Flag indicating a refund receipt. Refunds reduce net revenue and require separate disclosure in donor reports."
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(receipt_amount AS DOUBLE))
      comment: "Total cash received across all receipts. Primary revenue inflow metric for liquidity management and donor financial reporting."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receipt amount in functional currency. Enables multi-currency revenue analysis with a common currency baseline."
    - name: "matching_gift_receipt_amount"
      expr: SUM(CASE WHEN is_matching_gift = TRUE THEN receipt_amount ELSE 0 END)
      comment: "Total amount received as corporate matching gifts. Quantifies the fundraising leverage achieved through matching gift programs."
    - name: "refund_amount"
      expr: SUM(CASE WHEN is_refund = TRUE THEN receipt_amount ELSE 0 END)
      comment: "Total refund amounts processed. Refunds reduce net revenue and must be disclosed in donor and board financial reports."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of receipts processed. Volume metric for cash management workload and donor payment frequency."
    - name: "matching_gift_receipt_count"
      expr: COUNT(CASE WHEN is_matching_gift = TRUE THEN 1 END)
      comment: "Number of matching gift receipts. Tracks corporate matching gift program participation and leverage rate."
    - name: "avg_receipt_amount"
      expr: AVG(CAST(receipt_amount AS DOUBLE))
      comment: "Average receipt amount per transaction. Benchmarks typical donor payment size for portfolio segmentation and stewardship planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account portfolio health and liquidity metrics. Monitors account balances, overdraft exposure, interest-bearing account performance, and donor-restricted fund segregation. Critical for treasury management, cash flow planning, and compliance with donor fund segregation requirements. Supports SAP Treasury module and NGO banking relationship management."
  source: "`vibe_ngo_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (checking, savings, restricted, project). Drives treasury segmentation and fund restriction compliance."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (active, dormant, closed). Dormant accounts with balances require immediate treasury review."
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the banking institution. Enables counterparty concentration risk analysis across the banking portfolio."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Flag indicating the account holds donor-restricted funds. Restricted accounts require separate tracking and reporting to donors."
    - name: "interest_bearing_flag"
      expr: interest_bearing_flag
      comment: "Flag indicating the account earns interest. Interest on restricted funds may require donor notification or return under grant terms."
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of bank reconciliation (monthly, weekly, daily). Drives internal control assessment and audit readiness."
    - name: "last_reconciliation_date"
      expr: DATE_TRUNC('month', last_reconciliation_date)
      comment: "Month of last reconciliation. Accounts not reconciled within the expected frequency are a financial control risk."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all bank accounts. Primary liquidity metric for treasury management and cash flow planning."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available (unrestricted) balance across accounts. Represents immediately deployable cash for operational needs."
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Total overdraft facility available across accounts. Represents contingency liquidity buffer for operational continuity."
    - name: "total_interest_rate_weighted"
      expr: SUM(CAST(interest_rate AS DOUBLE) * CAST(current_balance AS DOUBLE))
      comment: "Interest-rate-weighted balance sum. Numerator for computing the weighted average interest rate across the banking portfolio."
    - name: "bank_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts. Portfolio size metric; excessive account proliferation increases treasury management complexity and audit risk."
    - name: "restricted_account_count"
      expr: COUNT(CASE WHEN donor_restriction_flag = TRUE THEN 1 END)
      comment: "Number of donor-restricted bank accounts. Tracks compliance with donor fund segregation requirements."
    - name: "total_minimum_balance_requirement"
      expr: SUM(CAST(minimum_balance_requirement AS DOUBLE))
      comment: "Total minimum balance requirements across all accounts. Represents locked liquidity that cannot be deployed for operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation completeness, variance, and compliance metrics. Monitors reconciliation timeliness, outstanding items, and variance resolution. A key internal control indicator for audit readiness under US GAAP, IPSAS, and donor audit requirements. Supports SAP bank reconciliation workflows and NGO financial control frameworks."
  source: "`vibe_ngo_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the bank reconciliation (in progress, completed, approved, exception). Exceptions require immediate finance team action."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reconciliation. Enables year-over-year reconciliation quality trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the reconciliation. Supports period-end close monitoring and reconciliation backlog analysis."
    - name: "reconciliation_date"
      expr: DATE_TRUNC('month', reconciliation_date)
      comment: "Month of reconciliation completion. Tracks timeliness of the monthly close process."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating a compliance concern on the reconciliation. Compliance-flagged reconciliations require escalation to finance leadership."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating the reconciliation covers a restricted fund account. Restricted fund reconciliations have heightened donor reporting obligations."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance (GL balance vs. bank statement). Non-zero aggregate variance signals unresolved reconciling items requiring investigation."
    - name: "total_outstanding_checks_amount"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared. Aged outstanding checks may indicate stale payments requiring vendor follow-up or void/reissue."
    - name: "total_outstanding_deposits_amount"
      expr: SUM(CAST(outstanding_deposits_amount AS DOUBLE))
      comment: "Total deposits in transit not yet reflected in bank statements. Tracks timing differences in cash receipt recognition."
    - name: "total_unrecorded_bank_charges"
      expr: SUM(CAST(unrecorded_bank_charges_amount AS DOUBLE))
      comment: "Total unrecorded bank charges identified during reconciliation. Represents GL adjustments required to match bank statements."
    - name: "total_unrecorded_bank_credits"
      expr: SUM(CAST(unrecorded_bank_credits_amount AS DOUBLE))
      comment: "Total unrecorded bank credits identified during reconciliation. Represents revenue or receipts not yet posted to the GL."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of bank reconciliations. Volume metric for finance team workload and reconciliation coverage."
    - name: "compliance_flagged_reconciliation_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of reconciliations with compliance flags. Non-zero values are audit risk indicators requiring immediate resolution."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average reconciliation variance per period. Trending upward average variance signals deteriorating financial control quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_grant_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant-specific budget performance metrics tracking award utilization, cost-share fulfillment, and indirect cost compliance. Supports donor financial reporting, grant closeout analysis, and NICRA rate compliance. Aligns with US GAAP (ASC 958), IPSAS, 2 CFR 200 cost principles, and UN agency grant management frameworks. Used in SAP Grants Management, eTools, and Integra environments."
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Current status of the grant budget (draft, submitted, approved, closed). Drives grant lifecycle management."
  measures:
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct program cost budget across grants. Used to assess program delivery investment and compute indirect cost ratios."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost (overhead) budget across grants. Compared against NICRA rates to ensure compliance with donor overhead caps."
    - name: "grant_budget_count"
      expr: COUNT(1)
      comment: "Total number of grant budgets. Portfolio size metric for grants management workload and award diversity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation accuracy, compliance, and indirect cost recovery metrics. Monitors allocation method consistency, NICRA base compliance, and restricted fund allocation integrity. Critical for 2 CFR 200 cost allocation plan compliance, IPSAS segment reporting, and donor audit defense. Supports SAP CO module and NGO cost allocation frameworks."
  source: "`vibe_ngo_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs (direct, proportional, headcount, square footage). Consistency of method is a key audit requirement under 2 CFR 200."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the cost allocation (pending, posted, reversed, approved). Unposted allocations represent unrecognized cost distributions."
    - name: "allocation_date"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of cost allocation. Enables monthly allocation volume trending and period-close analysis."
    - name: "is_fa_cost"
      expr: is_fa_cost
      comment: "Flag indicating a facilities and administrative (F&A) cost allocation. F&A costs are subject to NICRA rate caps and donor restrictions."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating allocation involves a restricted fund. Restricted fund allocations require donor authorization and audit documentation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating a compliance concern on the allocation. Compliance-flagged allocations require review before period close."
    - name: "cost_category"
      expr: CAST(cost_category AS STRING)
      comment: "Category of cost being allocated (personnel, occupancy, equipment). Supports functional expense analysis and NICRA base calculation."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated across all cost allocation records. Represents the full scope of shared cost distribution activity."
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate applied across cost allocations. Monitors rate consistency with approved cost allocation plans."
    - name: "avg_allocation_basis_quantity"
      expr: AVG(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Average allocation basis quantity (e.g., headcount, square footage). Tracks the statistical basis used for proportional allocations."
    - name: "cost_allocation_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation transactions. Volume metric for allocation workload and period-close complexity."
    - name: "compliance_flagged_allocation_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of cost allocations with compliance flags. Non-zero values are audit risk indicators requiring immediate resolution."
    - name: "fa_cost_allocated_amount"
      expr: SUM(CASE WHEN is_fa_cost = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total F&A (facilities and administrative) cost allocated. Compared against NICRA rate caps to ensure indirect cost compliance."
    - name: "restricted_fund_allocated_amount"
      expr: SUM(CASE WHEN is_restricted_fund = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total amount allocated from restricted funds. Tracks restricted fund utilization and compliance with donor-imposed restrictions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund portfolio health, restriction compliance, and audit readiness metrics. Monitors fund balances, commitment levels, match fulfillment, and audit requirements across the fund portfolio. Supports ASC 958 net asset classification (with/without donor restrictions), IPSAS fund accounting, and donor stewardship reporting. Core to SAP Fund Management and NGO restricted fund compliance frameworks."
  source: "`vibe_ngo_v1`.`finance`.`finance_fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (restricted, unrestricted, endowment, operating). Drives net asset classification under ASC 958 and IPSAS."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (active, closed, suspended). Closed funds with remaining balances require immediate treasury action."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type (purpose, time, perpetual). Determines allowable uses and reporting obligations."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the fund record. Enables year-over-year fund balance and utilization comparison."
    - name: "audit_required_flag"
      expr: audit_required_flag
      comment: "Flag indicating the fund requires a separate audit. Audit-required funds need dedicated financial statements and audit trail documentation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating a compliance concern on the fund. Compliance-flagged funds require escalation to finance leadership and legal."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the fund became effective. Used for fund cohort analysis and portfolio aging."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all funds. Represents the full authorized spending envelope of the fund portfolio."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all funds. Primary liquidity metric for fund portfolio management."
    - name: "total_expended_amount"
      expr: SUM(CAST(expended_amount AS DOUBLE))
      comment: "Total amount expended across all funds. Core metric for fund utilization and burn rate analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet expended) amount. Represents future cash outflows already contractually committed."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across funds. Used as baseline for period-over-period fund movement analysis."
    - name: "total_match_requirement"
      expr: SUM(CAST(budget_amount AS DOUBLE) * CAST(match_requirement_percentage AS DOUBLE) / 100.0)
      comment: "Total match (cost-share) requirement computed from budget amounts and match percentages. Tracks organizational co-funding obligations."
    - name: "total_match_fulfilled_amount"
      expr: SUM(CAST(match_fulfilled_amount AS DOUBLE))
      comment: "Total match requirement already fulfilled. Compared to total_match_requirement to assess cost-share compliance status."
    - name: "finance_fund_count"
      expr: COUNT(1)
      comment: "Total number of funds in the portfolio. Portfolio size metric for fund management complexity and audit scope."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required_flag = TRUE THEN 1 END)
      comment: "Number of funds requiring separate audits. Drives audit planning and resource allocation for the annual audit cycle."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across funds. Monitors portfolio-level overhead rate consistency with NICRA agreements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_nicra_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NICRA (Negotiated Indirect Cost Rate Agreement) rate portfolio metrics. Monitors active rates, rate components (F&A, fringe, administrative), and agreement lifecycle. Critical for 2 CFR 200 compliance, US federal grant cost recovery, and indirect cost budget planning. Supports NGO finance teams managing multiple NICRA agreements with different cognizant agencies (DHHS, DOD, USAID)."
  source: "`vibe_ngo_v1`.`finance`.`nicra_rate`"
  dimensions:
    - name: "rate_type"
      expr: CAST(rate_type AS STRING)
      comment: "Type of NICRA rate (predetermined, fixed, provisional, final). Rate type determines audit risk and carryforward adjustment obligations."
    - name: "rate_category"
      expr: CAST(rate_category AS STRING)
      comment: "Category of rate (F&A, fringe benefits, administrative). Enables component-level indirect cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year covered by the NICRA rate. Enables year-over-year rate trend analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the NICRA agreement (active, expired, under negotiation). Expired agreements without successors create grant billing risk."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the rate is currently active. Only active rates should be applied to grant budgets and expenditure reports."
    - name: "de_minimis_rate_flag"
      expr: de_minimis_rate_flag
      comment: "Flag indicating the organization is using the 10% de minimis rate under 2 CFR 200.414(f). De minimis organizations have simplified compliance but lower cost recovery."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the NICRA rate became effective. Used for rate lifecycle and negotiation cycle analysis."
  measures:
    - name: "avg_rate_percentage"
      expr: AVG(CAST(rate_percentage AS DOUBLE))
      comment: "Average NICRA indirect cost rate percentage across all rate records. Benchmarks the organization's overall indirect cost recovery rate."
    - name: "avg_facilities_rate"
      expr: AVG(CAST(facilities_rate AS DOUBLE))
      comment: "Average facilities component of the NICRA rate. Tracks the facilities cost recovery rate trend across negotiation cycles."
    - name: "avg_administrative_rate"
      expr: AVG(CAST(administrative_rate AS DOUBLE))
      comment: "Average administrative component of the NICRA rate. Monitors administrative overhead recovery rate trends."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate across NICRA agreements. Fringe rates directly impact personnel cost budgeting and grant financial planning."
    - name: "total_carryforward_adjustment"
      expr: SUM(CAST(carryforward_adjustment_amount AS DOUBLE))
      comment: "Total carryforward adjustment amounts across NICRA agreements. Carryforward adjustments represent over/under-recovery from prior years requiring settlement."
    - name: "nicra_rate_count"
      expr: COUNT(1)
      comment: "Total number of NICRA rate records. Tracks the complexity of the indirect cost rate portfolio."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active NICRA rates. Active rates are the only ones that should be applied to current grant budgets."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_exchange_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency exchange rate portfolio metrics monitoring rate volatility, UN operational rate usage, and donor-required rate compliance. Critical for multi-currency financial reporting under IPSAS (IAS 21 equivalent) and US GAAP (ASC 830), grant budget variance analysis due to FX movements, and UN agency operational rate management (UNORE). Supports SAP currency management and NGO treasury FX risk monitoring."
  source: "`vibe_ngo_v1`.`finance`.`exchange_rate`"
  dimensions:
    - name: "rate_type"
      expr: CAST(rate_type AS DOUBLE)
      comment: "Type of exchange rate (spot, average, UN operational, donor-required, budget). Different rate types serve different reporting frameworks."
    - name: "rate_status"
      expr: CAST(rate_status AS DOUBLE)
      comment: "Status of the exchange rate (active, expired, superseded). Only active rates should be applied to current financial transactions."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the exchange rate became effective. Enables monthly rate trend analysis and FX volatility monitoring."
    - name: "un_operational_rate_flag"
      expr: un_operational_rate_flag
      comment: "Flag indicating this is a UN operational rate (UNORE). UN agencies must use UNORE for all financial transactions per UN Financial Regulations."
    - name: "donor_required_rate_flag"
      expr: donor_required_rate_flag
      comment: "Flag indicating the rate is required by a specific donor. Donor-required rates may differ from market rates, creating FX variance in grant reporting."
    - name: "mid_market_rate_flag"
      expr: mid_market_rate_flag
      comment: "Flag indicating a mid-market (interbank) rate. Used as the benchmark for evaluating spread and rate quality."
    - name: "revaluation_rate_flag"
      expr: revaluation_rate_flag
      comment: "Flag indicating the rate is used for balance sheet revaluation. Revaluation rates drive FX gain/loss recognition under IPSAS and ASC 830."
  measures:
    - name: "avg_exchange_rate_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average exchange rate value across all rate records. Provides a portfolio-level view of currency translation rates."
    - name: "avg_spread_percentage"
      expr: AVG(CAST(spread_percentage AS DOUBLE))
      comment: "Average spread between applied rate and mid-market rate. High spreads represent implicit FX transaction costs impacting program budgets."
    - name: "avg_variance_from_prior_rate"
      expr: AVG(CAST(variance_from_prior_rate AS DOUBLE))
      comment: "Average rate change from the prior period rate. Tracks FX volatility that may require budget reforecasting or donor notification."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage change from prior rate. Percentage variance above donor-defined thresholds may trigger prior approval requirements."
    - name: "exchange_rate_count"
      expr: COUNT(1)
      comment: "Total number of exchange rate records. Portfolio size metric for currency management complexity."
    - name: "un_operational_rate_count"
      expr: COUNT(CASE WHEN un_operational_rate_flag = TRUE THEN 1 END)
      comment: "Number of UN operational rates in the portfolio. UN agencies must maintain current UNORE for all transacting currencies."
    - name: "donor_required_rate_count"
      expr: COUNT(CASE WHEN donor_required_rate_flag = TRUE THEN 1 END)
      comment: "Number of donor-required exchange rates. Donor-required rates create parallel accounting obligations and FX variance tracking requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_fiscal_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiscal period lifecycle and close management metrics. Monitors period open/close status, adjustment period activity, and year-end close readiness. Supports financial close management under US GAAP, IPSAS, and donor reporting calendars. Critical for period-end financial reporting, audit preparation, and SAP fiscal year variant management."
  source: "`vibe_ngo_v1`.`finance`.`fiscal_period`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the period. Enables year-level close status monitoring and annual reporting cycle management."
    - name: "period_type"
      expr: period_type
      comment: "Type of fiscal period (regular, adjustment, year-end). Adjustment periods require special audit attention and disclosure."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the fiscal period (open, closed, locked). Open periods after expected close dates signal financial control issues."
    - name: "quarter_number"
      expr: quarter_number
      comment: "Quarter number within the fiscal year. Enables quarterly financial performance analysis and donor quarterly reporting."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the period is currently active for posting. Multiple active periods simultaneously may indicate a control gap."
    - name: "is_adjustment_period"
      expr: is_adjustment_period
      comment: "Flag indicating an adjustment period (e.g., period 13 in SAP). Adjustment periods are used for year-end closing entries."
    - name: "is_year_end_period"
      expr: is_year_end_period
      comment: "Flag indicating the year-end closing period. Year-end periods require heightened audit scrutiny and board approval."
    - name: "audit_required_flag"
      expr: audit_required_flag
      comment: "Flag indicating the period requires audit procedures. Audit-required periods drive external auditor scheduling and documentation preparation."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Start month of the fiscal period. Used for period timeline visualization and close calendar management."
  measures:
    - name: "fiscal_period_count"
      expr: COUNT(1)
      comment: "Total number of fiscal periods. Used to verify the completeness of the fiscal calendar configuration."
    - name: "active_period_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active fiscal periods. More than one active period simultaneously is a financial control risk."
    - name: "adjustment_period_count"
      expr: COUNT(CASE WHEN is_adjustment_period = TRUE THEN 1 END)
      comment: "Number of adjustment periods. Tracks year-end adjustment period usage for audit documentation."
    - name: "audit_required_period_count"
      expr: COUNT(CASE WHEN audit_required_flag = TRUE THEN 1 END)
      comment: "Number of periods requiring audit procedures. Drives audit planning and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_fund_compliance_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund compliance status and waiver tracking metrics. Monitors compliance requirement fulfillment rates, waiver activity, and HACT (Harmonized Approach to Cash Transfers) compliance for UN agency implementing partner fund transfers. Critical for donor audit defense, UNICEF/UNDP HACT framework compliance, and organizational risk management. Supports eTools and VISION HACT module workflows."
  source: "`vibe_ngo_v1`.`finance`.`fund_compliance_tracking`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, pending, waived). Non-compliant funds represent active donor and audit risk."
    - name: "waiver_status"
      expr: waiver_status
      comment: "Status of any compliance waiver (requested, approved, denied, expired). Expired waivers without renewal create immediate compliance gaps."
    - name: "last_verification_date"
      expr: DATE_TRUNC('month', last_verification_date)
      comment: "Month of last compliance verification. Funds not verified within required frequency are a compliance risk."
    - name: "requirement_applicability_start_date"
      expr: DATE_TRUNC('year', requirement_applicability_start_date)
      comment: "Year the compliance requirement became applicable. Used for requirement cohort analysis and compliance burden trending."
  measures:
    - name: "compliance_tracking_count"
      expr: COUNT(1)
      comment: "Total number of fund compliance tracking records. Represents the scope of compliance monitoring obligations."
    - name: "non_compliant_fund_count"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Number of funds currently non-compliant with donor requirements. Non-zero values require immediate escalation to finance leadership and legal."
    - name: "waiver_approved_count"
      expr: COUNT(CASE WHEN waiver_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved compliance waivers. Tracks the extent of formal exceptions to standard compliance requirements."
    - name: "waiver_pending_count"
      expr: COUNT(CASE WHEN waiver_status = 'REQUESTED' THEN 1 END)
      comment: "Number of pending waiver requests. Pending waivers represent unresolved compliance gaps requiring donor engagement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank transaction flow and reconciliation metrics providing the most granular view of cash movements. Monitors transaction volumes, credit/debit flows, reconciliation status, and indirect cost transaction patterns. Supports bank reconciliation, cash flow analysis, and audit trail integrity under US GAAP, IPSAS, and donor audit requirements. Relevant to SAP bank statement processing and NGO treasury operations."
  source: "`vibe_ngo_v1`.`finance`.`bank_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of bank transaction (payment, receipt, transfer, fee, interest). Drives cash flow categorization and treasury analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (pending, cleared, reversed, disputed). Uncleared transactions represent timing differences in bank reconciliation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transaction (reconciled, unreconciled, exception). Unreconciled transactions are open items requiring resolution."
    - name: "transaction_date"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the bank transaction. Enables monthly cash flow trending and period-end reconciliation analysis."
    - name: "is_indirect_cost"
      expr: is_indirect_cost
      comment: "Flag indicating the transaction covers indirect costs. Used to verify indirect cost payments against NICRA rate caps."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating the transaction involves a restricted fund. Restricted fund transactions require donor authorization and audit documentation."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of fund restriction on the transaction. Drives compliance monitoring for donor-restricted cash flows."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all bank transactions. Gross cash flow volume metric for treasury management."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit (inflow) amount across bank transactions. Represents total cash received into bank accounts."
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit (outflow) amount across bank transactions. Represents total cash disbursed from bank accounts."
    - name: "net_cash_flow"
      expr: SUM(CAST(credit_amount AS DOUBLE) - CAST(debit_amount AS DOUBLE))
      comment: "Net cash flow (credits minus debits) across all transactions. Positive values indicate net cash inflow; negative values indicate net outflow."
    - name: "bank_transaction_count"
      expr: COUNT(1)
      comment: "Total number of bank transactions. Volume metric for treasury workload and bank statement processing complexity."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Number of unreconciled bank transactions. Elevated unreconciled counts signal bank reconciliation backlog and financial control risk."
    - name: "indirect_cost_transaction_amount"
      expr: SUM(CASE WHEN is_indirect_cost = TRUE THEN transaction_amount ELSE 0 END)
      comment: "Total transaction amount for indirect cost payments. Compared against NICRA rate caps to ensure indirect cost compliance."
    - name: "avg_running_balance"
      expr: AVG(CAST(running_balance AS DOUBLE))
      comment: "Average running balance across bank transactions. Tracks typical account balance levels for minimum balance compliance and liquidity planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center portfolio and budget utilization metrics. Monitors cost center budget consumption, indirect cost eligibility, and organizational hierarchy. Supports functional expense reporting under ASC 958, IPSAS segment reporting, and SAP Controlling (CO) module analysis. Enables CFO-level visibility into departmental cost performance and overhead management."
  source: "`vibe_ngo_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: CAST(cost_center_type AS STRING)
      comment: "Type of cost center (program, administrative, fundraising, shared services). Drives functional expense classification under ASC 958."
    - name: "cost_center_status"
      expr: CAST(cost_center_status AS STRING)
      comment: "Current status of the cost center (active, inactive, closed). Inactive cost centers with remaining budgets require treasury action."
    - name: "functional_expense_classification"
      expr: CAST(functional_expense_classification AS STRING)
      comment: "Functional expense classification (program services, M&G, fundraising). Required for ASC 958 Statement of Functional Expenses and Form 990."
    - name: "cost_center_category"
      expr: CAST(cost_center_category AS STRING)
      comment: "Category of the cost center (direct program, indirect, shared). Drives NICRA base calculation and cost allocation methodology."
    - name: "indirect_cost_eligible_flag"
      expr: indirect_cost_eligible_flag
      comment: "Flag indicating the cost center is eligible for indirect cost recovery. Drives NICRA base inclusion/exclusion decisions."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchical level of the cost center in the organizational structure. Enables roll-up reporting from project to program to organizational level."
    - name: "region"
      expr: region
      comment: "Geographic region of the cost center. Enables regional cost performance analysis and resource allocation decisions."
  measures:
    - name: "total_annual_budget_amount"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget across all cost centers. Represents the full authorized spending envelope at the cost center level."
    - name: "total_year_to_date_actual"
      expr: SUM(CAST(year_to_date_actual_amount AS DOUBLE))
      comment: "Total year-to-date actual expenditure across cost centers. Core metric for budget vs. actual performance monitoring."
    - name: "total_budget_variance"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE) - CAST(year_to_date_actual_amount AS DOUBLE))
      comment: "Total budget variance (budget minus actual) across cost centers. Negative values indicate over-expenditure requiring management action."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers. Portfolio size metric for organizational complexity and cost management scope."
    - name: "indirect_cost_eligible_center_count"
      expr: COUNT(CASE WHEN indirect_cost_eligible_flag = TRUE THEN 1 END)
      comment: "Number of cost centers eligible for indirect cost recovery. Determines the NICRA base and indirect cost recovery potential."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution and variance metrics for financial planning, grant compliance, and resource allocation decisions"
  source: "`vibe_ngo_v1`.`finance`.`budget`"
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