-- Metric views for domain: finance | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget performance metrics tracking approved funding, actual expenditure, variance, and burn rate across grants, cost centers, and fiscal periods for NGO program management."
  source: "`ngo_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current lifecycle status of the budget (e.g., Draft, Approved, Closed) for filtering active vs. historical budgets."
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g., Grant, Operational, Emergency) to segment financial performance by funding type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated, enabling multi-currency analysis."
    - name: "program_code"
      expr: program_code
      comment: "Program identifier linking the budget to a specific humanitarian or development program."
    - name: "budget_period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month-truncated budget period start date for time-series trending of budget performance."
    - name: "budget_period_end_date"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Month-truncated budget period end date for identifying upcoming budget expirations."
    - name: "approving_authority"
      expr: approving_authority
      comment: "Entity or individual who approved the budget, used for governance and accountability reporting."
    - name: "donor_reporting_frequency"
      expr: donor_reporting_frequency
      comment: "Frequency at which donor reports are required (e.g., Monthly, Quarterly), relevant for compliance dashboards."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount across all selected budgets. Core funding envelope metric used by finance leadership to assess organizational resource capacity."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure recorded against budgets. Compared against approved amounts to assess spending progress and grant compliance."
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Aggregate budget variance (approved minus actual). Negative values indicate over-expenditure; positive values indicate underspend risk for grant closeout."
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct program cost budget. Used to assess the proportion of funding allocated directly to beneficiary-facing activities."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost (overhead) budget. Monitored against NICRA rates and donor-imposed indirect cost caps."
    - name: "avg_burn_rate_percentage"
      expr: AVG(CAST(burn_rate_percentage AS DOUBLE))
      comment: "Average budget burn rate percentage across budgets. A key operational KPI — low burn rates signal underspend risk; high rates signal potential overrun."
    - name: "total_cost_share_requirement"
      expr: SUM(CAST(cost_share_requirement_amount AS DOUBLE))
      comment: "Total cost-share (matching funds) requirement across all budgets. Critical for donor compliance — failure to meet cost-share can trigger grant clawback."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Used as a denominator for average calculations and portfolio sizing."
    - name: "avg_icr_rate_applied"
      expr: AVG(CAST(icr_rate_applied AS DOUBLE))
      comment: "Average indirect cost recovery (ICR) rate applied across budgets. Compared against NICRA-negotiated rates to ensure compliance and maximize cost recovery."
    - name: "total_award_ceiling"
      expr: SUM(CAST(award_ceiling_amount AS DOUBLE))
      comment: "Total award ceiling across all grant budgets. Represents the maximum allowable expenditure under donor agreements — a hard compliance boundary."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_grant_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant-level budget performance metrics for tracking award utilization, cost-share fulfillment, indirect cost recovery, and multi-year grant management across the NGO portfolio."
  source: "`ngo_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the grant budget (e.g., Active, Closed, Under Review) for portfolio health monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the grant budget for multi-currency portfolio analysis."
  measures:
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct program costs budgeted under grants. Reflects the proportion of donor funding directed to program delivery."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect (overhead) costs budgeted under grants. Monitored against NICRA rates and donor caps to ensure compliance."
    - name: "grant_budget_count"
      expr: COUNT(1)
      comment: "Total number of grant budget records. Used for portfolio sizing and average calculations."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed general ledger transaction metrics tracking debits, credits, direct vs. indirect costs, and donor restriction compliance at the journal entry line level."
  source: "`ngo_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "functional_expense_category"
      expr: functional_expense_category
      comment: "Functional expense classification (e.g., Program Services, Management & General, Fundraising) per nonprofit accounting standards (ASC 958)."
    - name: "natural_account_classification"
      expr: natural_account_classification
      comment: "Natural account classification (e.g., Salaries, Supplies, Travel) for expense type analysis."
    - name: "donor_restriction_type"
      expr: donor_restriction_type
      comment: "Donor restriction classification (e.g., Unrestricted, Temporarily Restricted, Permanently Restricted) for net asset class reporting."
    - name: "program_code"
      expr: program_code
      comment: "Program code linking the transaction to a specific humanitarian program for program-level cost analysis."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Indicates whether the cost is a direct program cost (True) or indirect/overhead cost (False)."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Indicates whether the cost is allowable under the applicable donor agreement — critical for grant compliance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal entry line (e.g., Pending, Approved, Rejected) for financial control monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for time-series expenditure trending."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this line is a reversal entry, used to identify correcting transactions and assess data quality."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entry lines. Represents gross expenditure and asset increases — a foundational ledger metric."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entry lines. Represents revenue recognition, liability increases, and expense reversals."
    - name: "net_ledger_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net ledger impact (debits minus credits) per period. A balanced ledger should net to zero — deviations signal posting errors or unreconciled entries."
    - name: "total_direct_cost_amount"
      expr: SUM(CASE WHEN direct_cost_flag = TRUE THEN CAST(debit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total direct program cost expenditure. Used to calculate the program efficiency ratio and demonstrate mission-focused spending to donors."
    - name: "total_indirect_cost_amount"
      expr: SUM(CASE WHEN direct_cost_flag = FALSE THEN CAST(debit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total indirect (overhead) cost expenditure. Monitored against donor-imposed overhead caps and NICRA rates."
    - name: "total_unallowable_cost_amount"
      expr: SUM(CASE WHEN allowable_cost_flag = FALSE THEN CAST(debit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure flagged as unallowable under donor agreements. A critical compliance risk metric — unallowable costs must be removed from grant claims."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversal journal entry lines. High reversal counts indicate posting errors or late adjustments, signaling financial control weaknesses."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied across journal entry lines. Compared against NICRA-negotiated rates to ensure consistent application."
    - name: "journal_entry_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines. Used as a transaction volume baseline for audit sampling and workload analysis."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable metrics tracking invoice processing, payment timeliness, grant-eligible expenditure, and vendor payment compliance for NGO financial operations."
  source: "`ngo_ecm`.`finance`.`payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g., Pending, Paid, Overdue, Disputed) for cash flow and liability management."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., Wire Transfer, Check, EFT) for payment channel analysis and banking cost optimization."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status for financial control monitoring and bottleneck identification in the payables process."
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Currency of the invoice for multi-currency payables exposure analysis."
    - name: "is_grant_eligible"
      expr: is_grant_eligible
      comment: "Indicates whether the payable is eligible for grant reimbursement — critical for grant drawdown and donor reporting."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates whether the payable is charged to a restricted fund, requiring donor-specific compliance tracking."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO, goods receipt, invoice) — a key internal control indicator for procurement compliance."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month-truncated invoice date for time-series analysis of payables volume and aging."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month-truncated due date for cash flow forecasting and payment scheduling."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) for vendor relationship and cash management analysis."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all payables. Represents total vendor obligations — a key liability and cash flow planning metric."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and adjustments. The actual payment obligation used for cash flow forecasting."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payables amount in functional (reporting) currency. Enables consolidated financial reporting across multi-currency operations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Reflects treasury efficiency — maximizing discounts reduces program costs."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on payables. Monitored for VAT/tax exemption compliance — NGOs often qualify for tax exemptions that must be actively claimed."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Compliance metric for tax authority reporting obligations."
    - name: "grant_eligible_payable_amount"
      expr: SUM(CASE WHEN is_grant_eligible = TRUE THEN CAST(invoice_net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total payable amount eligible for grant reimbursement. Directly drives grant drawdown requests and donor financial reporting."
    - name: "disputed_payable_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of payables under dispute. High dispute counts signal vendor relationship issues or procurement process failures requiring management attention."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to payables. Used to assess foreign exchange exposure and the impact of currency fluctuations on program costs."
    - name: "payable_count"
      expr: COUNT(1)
      comment: "Total number of payable records. Used for processing volume benchmarking and AP team workload analysis."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_payable_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution metrics tracking disbursement volumes, grant-funded payments, indirect cost payments, and payment channel performance for NGO treasury operations."
  source: "`ngo_ecm`.`finance`.`payable_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Processed, Pending, Failed, Reversed) for cash disbursement monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment execution method (e.g., Wire, ACH, Check) for channel efficiency and banking cost analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment type (e.g., Vendor, Staff, Subaward) for expenditure category analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the payment was made for foreign exchange exposure analysis."
    - name: "is_grant_funded"
      expr: is_grant_funded
      comment: "Indicates whether the payment is funded by a grant, enabling grant-specific cash flow tracking."
    - name: "is_indirect_cost"
      expr: is_indirect_cost
      comment: "Indicates whether the payment represents an indirect (overhead) cost for cost structure analysis."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates whether the payment is from a restricted fund, requiring donor-specific compliance tracking."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month-truncated payment date for cash disbursement time-series analysis and liquidity planning."
    - name: "country_code"
      expr: country_code
      comment: "Country where the payment was made for geographic cash flow analysis and field office financial monitoring."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the payment for program-level expenditure tracking."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary cash outflow metric for treasury management and liquidity planning."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after withholding and discounts. Represents actual cash disbursed — the definitive treasury outflow metric."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments in functional (reporting) currency. Enables consolidated cash flow reporting across multi-currency field operations."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Compliance metric for tax authority remittance obligations."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Reflects treasury efficiency in optimizing payment timing to reduce program costs."
    - name: "grant_funded_payment_amount"
      expr: SUM(CASE WHEN is_grant_funded = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total payments funded by grants. Directly reconciled against grant drawdown requests and donor financial reports."
    - name: "indirect_cost_payment_amount"
      expr: SUM(CASE WHEN is_indirect_cost = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total indirect cost payments. Monitored against NICRA rates and donor overhead caps to ensure compliance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to payments. Used to quantify foreign exchange risk and the cost impact of currency fluctuations on field operations."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Used for processing volume benchmarking and treasury workload analysis."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable and grant drawdown metrics tracking outstanding donor invoices, collection performance, write-offs, and revenue recognition for NGO funding management."
  source: "`ngo_ecm`.`finance`.`receivable`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status (e.g., Current, Overdue, In Dispute, Written Off) for receivables aging and collection prioritization."
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Currency of the receivable invoice for multi-currency donor receivables analysis."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method by which payment is expected (e.g., Wire, Check, Grant Drawdown) for cash receipt forecasting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the receivable is under dispute — disputed receivables require escalation and may impact cash flow."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the receivable for program-level revenue tracking."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month-truncated invoice date for time-series revenue recognition and billing cycle analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month-truncated due date for cash collection forecasting and aging bucket analysis."
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month-truncated revenue recognition date for period-accurate revenue reporting per ASC 958."
    - name: "aging_days"
      expr: aging_days
      comment: "Aging bucket classification (e.g., 0-30, 31-60, 61-90, 90+) for receivables aging analysis and collection prioritization."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across all receivables. Represents gross revenue billed to donors and grantors — a top-line revenue metric."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance. Represents uncollected donor funding — a critical liquidity and cash flow risk metric."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receivables in functional (reporting) currency. Enables consolidated revenue reporting across multi-currency donor relationships."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total receivables written off as uncollectable. A key financial health indicator — high write-offs signal donor relationship or grant management failures."
    - name: "total_allowance_for_doubtful_accounts"
      expr: SUM(CAST(allowance_for_doubtful_accounts AS DOUBLE))
      comment: "Total allowance for doubtful accounts. Reflects management's estimate of uncollectable receivables — impacts net asset reporting."
    - name: "disputed_receivable_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(outstanding_balance AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding balance on disputed receivables. Disputed amounts represent at-risk revenue requiring active resolution."
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Total number of receivable records. Used for billing volume analysis and AR team workload benchmarking."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to receivables. Used to assess foreign exchange risk on donor receivables denominated in non-functional currencies."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_receivable_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor cash receipt metrics tracking actual fund inflows, grant drawdowns, matching gifts, and revenue recognition timing for NGO treasury and fundraising operations."
  source: "`ngo_ecm`.`finance`.`receivable_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt (e.g., Posted, Pending, Reversed) for cash receipt monitoring and reconciliation."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (e.g., Wire Transfer, Check, ACH) for cash channel analysis and banking efficiency."
    - name: "receipt_channel"
      expr: receipt_channel
      comment: "Channel through which the receipt was received (e.g., Online, Field Office, HQ) for fundraising channel performance analysis."
    - name: "receipt_currency_code"
      expr: receipt_currency_code
      comment: "Currency in which the receipt was received for foreign exchange and multi-currency cash management."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type (e.g., Unrestricted, Temporarily Restricted, Permanently Restricted) for net asset class cash flow reporting."
    - name: "is_matching_gift"
      expr: is_matching_gift
      comment: "Indicates whether the receipt is a matching gift, relevant for cost-share fulfillment tracking."
    - name: "is_refund"
      expr: is_refund
      comment: "Indicates whether the receipt is a refund, used to identify net vs. gross cash inflows."
    - name: "is_in_kind_conversion"
      expr: is_in_kind_conversion
      comment: "Indicates whether the receipt represents a monetized in-kind contribution, relevant for in-kind revenue reporting."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month-truncated receipt date for time-series cash inflow trending and liquidity planning."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the receipt (e.g., Reconciled, Unreconciled) for financial control monitoring."
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(receipt_amount AS DOUBLE))
      comment: "Total cash received from donors and grantors. The primary revenue inflow metric — directly reflects fundraising and grant drawdown performance."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receipts in functional (reporting) currency. Enables consolidated revenue reporting across multi-currency donor contributions."
    - name: "matching_gift_receipt_amount"
      expr: SUM(CASE WHEN is_matching_gift = TRUE THEN CAST(receipt_amount AS DOUBLE) ELSE 0 END)
      comment: "Total matching gift receipts. Directly contributes to cost-share fulfillment — a compliance metric for grants requiring matching contributions."
    - name: "refund_amount"
      expr: SUM(CASE WHEN is_refund = TRUE THEN CAST(receipt_amount AS DOUBLE) ELSE 0 END)
      comment: "Total refund amounts received. High refund volumes may indicate billing errors or donor disputes requiring investigation."
    - name: "unreconciled_receipt_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Number of receipts not yet reconciled to bank statements. Unreconciled receipts represent a financial control risk and audit exposure."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to receipts. Used to quantify foreign exchange gains/losses on multi-currency donor contributions."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of receipt transactions. Used for cash processing volume analysis and treasury workload benchmarking."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking how shared costs are distributed across programs, grants, and cost centers — critical for donor compliance, indirect cost recovery, and program cost accuracy."
  source: "`ngo_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs (e.g., Direct, Proportional, Square Footage) for allocation methodology governance."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g., Pending, Posted, Reversed) for allocation workflow monitoring."
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost being allocated (e.g., Personnel, Facilities, IT) for cost pool analysis."
    - name: "cost_pool"
      expr: cost_pool
      comment: "Cost pool from which the allocation originates (e.g., Management & General, Fundraising) for overhead distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-currency cost analysis."
    - name: "is_fa_cost"
      expr: is_fa_cost
      comment: "Indicates whether the cost is a Facilities & Administrative (F&A) cost, relevant for NICRA compliance and indirect cost recovery."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Indicates whether the allocation is to a restricted fund, requiring donor-specific compliance tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance status flag for the allocation — non-compliant allocations represent audit risk and potential grant disallowances."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month-truncated allocation date for time-series cost distribution analysis."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for the allocation calculation (e.g., FTE Count, Square Footage, Direct Cost) for methodology transparency."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost amount allocated across programs and grants. Represents the full scope of shared cost distribution — essential for accurate program cost reporting."
    - name: "fa_cost_allocated_amount"
      expr: SUM(CASE WHEN is_fa_cost = TRUE THEN CAST(allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total Facilities & Administrative (F&A) costs allocated. Monitored against NICRA rates to ensure indirect cost recovery compliance."
    - name: "restricted_fund_allocated_amount"
      expr: SUM(CASE WHEN is_restricted_fund = TRUE THEN CAST(allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total costs allocated to restricted funds. Restricted fund allocations require donor approval and compliance documentation."
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate applied across cost allocations. Compared against approved rates to detect unauthorized rate deviations."
    - name: "avg_allocation_basis_quantity"
      expr: AVG(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Average allocation basis quantity (e.g., average FTE count, average square footage). Used to validate that allocation drivers are reasonable and consistent."
    - name: "cost_allocation_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation transactions. Used for allocation process volume analysis and audit sampling."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund management metrics tracking fund balances, expenditure, commitment levels, match fulfillment, and compliance status across the NGO's restricted and unrestricted fund portfolio."
  source: "`ngo_ecm`.`finance`.`finance_fund`"
  dimensions:
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g., Active, Closed, Suspended) for portfolio health monitoring."
    - name: "fund_type"
      expr: fund_type
      comment: "Classification of the fund (e.g., Grant, Endowment, Operating, Emergency) for fund portfolio segmentation."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type (e.g., Unrestricted, Temporarily Restricted, Permanently Restricted) for net asset class reporting per ASC 958."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the fund is denominated for multi-currency fund management."
    - name: "donor_reporting_frequency"
      expr: donor_reporting_frequency
      comment: "Frequency of required donor reports (e.g., Monthly, Quarterly, Annual) for compliance calendar management."
    - name: "audit_required_flag"
      expr: audit_required_flag
      comment: "Indicates whether the fund requires an independent audit — high-risk funds requiring audit need enhanced monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the fund has active compliance requirements or flags, for compliance risk prioritization."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the fund for program-level financial analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated fund effective start date for fund lifecycle and portfolio evolution analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all funds. Represents the total financial resources planned for deployment — a top-line portfolio metric."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current fund balance. Represents available financial resources — a critical liquidity and solvency metric for NGO leadership."
    - name: "total_expended_amount"
      expr: SUM(CAST(expended_amount AS DOUBLE))
      comment: "Total amount expended from funds. Compared against budget to assess fund utilization and grant burn rate."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (encumbered) amount across funds. Represents future obligations already contracted — essential for accurate available balance calculation."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across funds. Used as the baseline for period-over-period fund balance change analysis."
    - name: "total_match_requirement"
      expr: SUM(CAST(match_requirement_percentage AS DOUBLE))
      comment: "Sum of match requirement percentages across funds. Aggregated to assess the total cost-share obligation burden across the fund portfolio."
    - name: "total_match_fulfilled_amount"
      expr: SUM(CAST(match_fulfilled_amount AS DOUBLE))
      comment: "Total cost-share/matching contribution fulfilled. Compared against match requirements to assess compliance with donor matching obligations."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across funds. Compared against NICRA-negotiated rates to ensure consistent and compliant overhead recovery."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of fund records. Used for portfolio sizing and fund management workload analysis."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required_flag = TRUE THEN 1 END)
      comment: "Number of funds requiring independent audit. Drives audit planning resource allocation and compliance calendar management."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account portfolio metrics tracking cash balances, overdraft exposure, interest-bearing accounts, and donor-restricted cash positions across the NGO's global banking network."
  source: "`ngo_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (e.g., Active, Closed, Dormant) for treasury portfolio management."
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g., Checking, Savings, Petty Cash) for cash management segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bank account for multi-currency cash position analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the bank account is held for geographic cash distribution and field office liquidity analysis."
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the banking institution for counterparty risk and banking relationship management."
    - name: "interest_bearing_flag"
      expr: interest_bearing_flag
      comment: "Indicates whether the account earns interest — relevant for treasury optimization and interest income tracking."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Indicates whether the account holds donor-restricted funds, requiring segregated cash management and compliance reporting."
    - name: "overdraft_protection_flag"
      expr: overdraft_protection_flag
      comment: "Indicates whether overdraft protection is in place — relevant for liquidity risk management."
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of bank reconciliation (e.g., Daily, Weekly, Monthly) for financial control assessment."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current cash balance across all bank accounts. The primary treasury liquidity metric — directly informs cash management and operational funding decisions."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available (unrestricted) cash balance. Represents immediately deployable funds — critical for emergency response and operational continuity."
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Total overdraft facility available across accounts. Represents contingency liquidity capacity for emergency cash needs."
    - name: "total_minimum_balance_requirement"
      expr: SUM(CAST(minimum_balance_requirement AS DOUBLE))
      comment: "Total minimum balance requirements across accounts. Represents cash that cannot be deployed — a constraint on operational liquidity."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across interest-bearing accounts. Used to optimize cash placement and maximize interest income on idle funds."
    - name: "donor_restricted_account_count"
      expr: COUNT(CASE WHEN donor_restriction_flag = TRUE THEN 1 END)
      comment: "Number of bank accounts holding donor-restricted funds. Restricted accounts require segregated management and compliance reporting."
    - name: "bank_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts in the portfolio. Used for banking relationship management and account rationalization analysis."
    - name: "total_signatory_threshold_amount"
      expr: SUM(CAST(signatory_threshold_amount AS DOUBLE))
      comment: "Total signatory threshold amounts across accounts. Reflects the aggregate value of transactions requiring dual authorization — a governance and fraud prevention metric."
$$;