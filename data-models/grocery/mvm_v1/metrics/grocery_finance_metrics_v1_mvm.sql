-- Metric views for domain: finance | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking supplier payment obligations, discount capture efficiency, tax exposure, and payment cycle performance for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g., Open, Posted, Cleared, Blocked) used to segment payables by processing stage."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., Standard, Credit Memo, Debit Memo) enabling analysis of payable composition."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the invoice, used to identify bottlenecks in the payables approval process."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used or designated for payment (e.g., ACH, Check, Wire) enabling cash flow and payment channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Vendor payment terms code (e.g., Net30, 2/10Net30) used to assess discount eligibility and cash management strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice, enabling multi-currency payables exposure analysis."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (PO/GR/Invoice) indicating whether the invoice has been validated against purchase order and goods receipt."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating why a payment is blocked, used to identify and resolve payment holds impacting supplier relationships."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction associated with the invoice for regional tax liability reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for time-series trending of payables volume and amounts."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Payment due date truncated to month for cash outflow forecasting and aging analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "GL posting date truncated to month for period-based financial close and accrual analysis."
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Flag indicating whether the invoice is subject to 1099 tax reporting, used for regulatory compliance tracking."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices in scope. Core payables exposure metric used by CFO and Treasury to manage cash obligations and working capital."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments. Used to assess actual cash outflow obligations and compare against budget."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability embedded in AP invoices. Critical for tax compliance reporting and jurisdictional tax exposure management."
    - name: "total_discount_available"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discount available across all invoices. Measures the maximum discount opportunity the business could capture through timely payment."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discount actually captured. Compared against total_discount_available to compute discount capture rate — a key working capital efficiency KPI."
    - name: "total_cleared_amount"
      expr: SUM(CAST(cleared_amount AS DOUBLE))
      comment: "Total amount cleared/paid against AP invoices. Used to track payment execution progress and reconcile open payables."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for payables throughput and operational capacity planning."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of invoices with an active payment block. High blocked invoice counts signal supplier relationship risk and potential late payment penalties."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN match_status <> 'MATCHED' THEN 1 END)
      comment: "Number of invoices that have not completed three-way match. Unmatched invoices represent processing risk and potential duplicate payment exposure."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount. Used to benchmark invoice size trends and detect anomalies in supplier billing patterns."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with invoices in scope. Used to assess supplier concentration risk and payables diversification."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics tracking wholesale customer billing, collections performance, dispute management, and write-off exposure for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AR invoice (e.g., Open, Paid, Disputed, Written-Off) for receivables aging and collections segmentation."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the AR invoice (e.g., Standard, Credit Memo) enabling receivables composition analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket (e.g., Current, 1-30, 31-60, 61-90, 90+) for receivables aging analysis and collections prioritization."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or expected for the invoice, enabling collections channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Customer payment terms code used to assess receivables risk and expected collection timing."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency in which the customer is billed, enabling multi-currency receivables exposure analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean flag indicating whether the invoice is under dispute. Used to segment disputed vs. clean receivables for collections strategy."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason code for invoice dispute, enabling root-cause analysis of billing quality issues."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level for overdue invoices, used to prioritize collections outreach."
    - name: "write_off_reason_code"
      expr: write_off_reason_code
      comment: "Reason code for invoice write-off, used to analyze bad debt drivers and credit policy effectiveness."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for time-series trending of AR billing volume and amounts."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Payment due date truncated to month for cash inflow forecasting and collections scheduling."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period start truncated to month for period-based revenue recognition analysis."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to wholesale customers. Top-line AR revenue metric used by Finance leadership to track billing volume and revenue recognition."
    - name: "total_net_receivable_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after discounts. Represents actual expected cash inflow from wholesale customers."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid outstanding balance across all AR invoices. Core liquidity metric for Treasury and CFO to manage cash flow and working capital."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected from customers. Used to measure collections effectiveness and cash conversion performance."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable. Key bad debt metric used by CFO and Credit Risk to evaluate credit policy and customer creditworthiness."
    - name: "total_discount_granted"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted to customers on AR invoices. Used to assess revenue leakage from customer discount programs."
    - name: "total_freight_billed"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges billed to customers. Used to assess freight cost recovery and logistics billing accuracy."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices. Used for tax compliance reporting and jurisdictional revenue analysis."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline billing volume metric for operational capacity and customer activity tracking."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. High dispute counts signal billing quality issues and customer satisfaction risk."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN write_off_amount > 0 THEN 1 END)
      comment: "Number of invoices with a write-off recorded. Used to track bad debt incidence and credit risk exposure."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per AR invoice. Used to benchmark receivables size and identify customers with disproportionately large open balances."
    - name: "distinct_wholesale_customer_count"
      expr: COUNT(DISTINCT wholesale_account_id)
      comment: "Number of distinct wholesale customers with active AR invoices. Used to assess customer concentration risk in receivables."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking planned vs. actual spend, variance analysis, and budget utilization across cost centers and profit centers for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Operating, Capital, Labor) enabling segmentation of financial plans by category."
    - name: "budget_category"
      expr: budget_category
      comment: "Business category of the budget line (e.g., Shrink, Marketing, Facilities) for granular spend analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., Draft, Approved, Closed) for governance and approval workflow tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated for multi-currency financial planning analysis."
    - name: "owner"
      expr: owner
      comment: "Business owner responsible for the budget, enabling accountability and ownership-based performance reporting."
    - name: "version"
      expr: version
      comment: "Budget version (e.g., Original, Revised, Forecast) enabling comparison across planning iterations."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Flag indicating whether the budget is subject to SOX internal controls, used for compliance reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Budget effective start date truncated to month for time-series budget planning analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Budget approval date truncated to month for governance cycle tracking."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Baseline financial plan metric used by Finance and business leaders to set spending expectations and resource allocation."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend recorded against budget. Core execution metric compared against planned amount to assess financial discipline."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount reflecting mid-period adjustments. Used to track how much the financial plan has changed from original targets."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (purchase orders, contracts) against budget. Used to forecast remaining available budget and prevent overspend."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total remaining available budget balance. Critical for spend authorization decisions and preventing budget overruns."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (planned minus actual). Negative variance signals overspend; positive signals underspend. Key metric for financial performance reviews."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across budget lines. Used to assess overall financial planning accuracy and identify departments with chronic over/underspend."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines in scope. Used to assess planning granularity and budget management complexity."
    - name: "overspent_budget_count"
      expr: COUNT(CASE WHEN actual_amount > planned_amount THEN 1 END)
      comment: "Number of budget lines where actual spend exceeds planned amount. Used to identify and escalate budget overruns requiring management intervention."
    - name: "avg_threshold_warning_pct"
      expr: AVG(CAST(threshold_warning_percentage AS DOUBLE))
      comment: "Average warning threshold percentage set across budgets. Used to calibrate budget alert sensitivity and governance controls."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital investment, depreciation, net book value, impairment, and asset lifecycle performance for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset classification (e.g., Buildings, Equipment, Vehicles, IT) for capital investment analysis by asset category."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the asset (e.g., Active, Retired, Disposed) for asset portfolio management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., Straight-Line, Declining Balance) for financial reporting and tax planning analysis."
    - name: "depreciation_key"
      expr: depreciation_key
      comment: "Depreciation key code used in the asset accounting system, enabling grouping by depreciation policy."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (e.g., Book, Tax, IFRS) enabling multi-ledger depreciation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the asset is recorded for multi-currency capital asset analysis."
    - name: "is_leased_asset"
      expr: is_leased_asset
      comment: "Flag indicating whether the asset is leased (vs. owned), used for lease vs. buy analysis and IFRS 16 compliance."
    - name: "tax_depreciation_method"
      expr: tax_depreciation_method
      comment: "Tax depreciation method applied, used for tax planning and deferred tax liability analysis."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Asset acquisition date truncated to month for capital expenditure trend analysis."
    - name: "capitalization_date_month"
      expr: DATE_TRUNC('month', capitalization_date)
      comment: "Asset capitalization date truncated to month for CapEx recognition timing analysis."
    - name: "disposal_date_month"
      expr: DATE_TRUNC('month', disposal_date)
      comment: "Asset disposal date truncated to month for asset retirement trend analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets. Core CapEx metric used by CFO and Finance to track gross capital investment in the business."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (acquisition cost minus accumulated depreciation). Key balance sheet metric representing the carrying value of capital assets."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all fixed assets. Used to assess asset age, replacement planning needs, and depreciation expense trends."
    - name: "total_current_period_depreciation"
      expr: SUM(CAST(current_period_depreciation AS DOUBLE))
      comment: "Total depreciation expense recorded in the current period. Used for P&L impact analysis and period-over-period depreciation trend monitoring."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded against fixed assets. Signals asset value deterioration and is a key indicator for store performance and capital reallocation decisions."
    - name: "total_disposal_gain_loss"
      expr: SUM(CAST(disposal_gain_loss AS DOUBLE))
      comment: "Total gain or loss on asset disposals. Used to evaluate asset disposal strategy and its impact on the income statement."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total cash proceeds received from asset disposals. Used to assess capital recovery from retired assets."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in scope. Baseline metric for asset portfolio size and capital asset management complexity."
    - name: "leased_asset_count"
      expr: COUNT(CASE WHEN is_leased_asset = TRUE THEN 1 END)
      comment: "Number of leased assets in the portfolio. Used for IFRS 16 / ASC 842 lease accounting compliance and lease vs. own strategy analysis."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of fixed assets in years. Used to assess asset age profile, replacement cycle planning, and depreciation schedule adequacy."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Used to benchmark asset value and identify asset classes with disproportionate carrying values."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_amount > 0 THEN 1 END)
      comment: "Number of assets with recorded impairment charges. Used to identify underperforming asset clusters and inform capital reallocation decisions."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics tracking disbursement volume, fee efficiency, automation rates, and payment channel performance for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g., Scheduled, In Progress, Completed, Failed) for payment execution monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (e.g., ACH, Wire, Check) for payment channel analysis and cost optimization."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was executed (e.g., Electronic, Manual) for automation and efficiency analysis."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g., Regular, Emergency, Reversal) for payment cycle classification and exception tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run for multi-currency disbursement analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the payment run was fully automated, used to track straight-through processing rates."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit that initiated the payment run, enabling disbursement analysis by organizational unit."
    - name: "approved_by"
      expr: approved_by
      comment: "Approver of the payment run for governance and segregation-of-duties compliance tracking."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_timestamp)
      comment: "Scheduled payment run date truncated to month for cash outflow forecasting and payment cycle trend analysis."
  measures:
    - name: "total_gross_disbursed"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount disbursed across all payment runs. Core cash outflow metric used by Treasury and CFO to manage liquidity and working capital."
    - name: "total_net_disbursed"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount disbursed after fees and deductions. Represents actual cash leaving the business and is used for bank reconciliation and cash position management."
    - name: "total_tax_disbursed"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount included in payment runs. Used for tax remittance tracking and compliance reporting."
    - name: "total_fees_incurred"
      expr: SUM(CAST(total_fees_amount AS DOUBLE))
      comment: "Total transaction fees incurred across payment runs. Used to optimize payment channel selection and reduce disbursement costs."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Baseline operational metric for payment processing volume and treasury workload."
    - name: "automated_run_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Number of fully automated payment runs. Used to track straight-through processing adoption and identify manual intervention rates."
    - name: "failed_run_count"
      expr: COUNT(CASE WHEN payment_run_status = 'FAILED' THEN 1 END)
      comment: "Number of payment runs that failed execution. High failure rates signal systemic payment processing issues requiring immediate remediation."
    - name: "avg_gross_amount_per_run"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross disbursement amount per payment run. Used to benchmark payment run size and detect anomalous disbursement patterns."
    - name: "avg_fees_per_run"
      expr: AVG(CAST(total_fees_amount AS DOUBLE))
      comment: "Average transaction fees per payment run. Used to monitor payment processing cost efficiency and negotiate better rates with banking partners."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers paid across payment runs. Used to assess payment concentration and supplier payment coverage."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volume, reversal rates, intercompany activity, and financial close quality for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g., Posted, Parked, Reversed) for GL close quality monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., SA, KR, DR) for transaction classification and audit trail analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry for multi-currency GL analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local reporting currency of the journal entry for functional currency analysis."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group (e.g., Leading Ledger, IFRS, Tax) enabling multi-GAAP financial reporting analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany journal entries, used for intercompany elimination and consolidation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the journal entry is a reversal, used to track accrual reversal rates and close quality."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the journal entry (e.g., SAP, POS, Payroll) for data lineage and reconciliation analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms associated with the journal entry for cash flow timing analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "GL posting date truncated to month for period-based financial close volume and trend analysis."
    - name: "document_date_month"
      expr: DATE_TRUNC('month', document_date)
      comment: "Document date truncated to month for transaction origination timing analysis."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Core GL activity metric used by Controllers to assess financial close workload and posting volume trends."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. High reversal counts may indicate accrual quality issues or manual correction activity requiring process improvement."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used for intercompany reconciliation, elimination tracking, and consolidation close management."
    - name: "parked_entry_count"
      expr: COUNT(CASE WHEN posting_status = 'PARKED' THEN 1 END)
      comment: "Number of journal entries in parked (unposted) status. High parked counts at period-end signal close risk and require escalation."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts with journal activity. Used to assess chart-of-accounts utilization and identify dormant or over-used accounts."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across journal entries. Used to monitor FX rate consistency and detect potential translation errors in multi-currency postings."
    - name: "distinct_legal_entity_count"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of distinct legal entities with journal activity. Used for consolidation scope validation and entity-level close monitoring."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account portfolio metrics tracking cash balances, overdraft exposure, account utilization, and treasury position for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g., Checking, Savings, Concentration) for treasury portfolio segmentation."
    - name: "account_purpose"
      expr: account_purpose
      comment: "Business purpose of the account (e.g., Payroll, Operating, Lockbox) for cash management and segregation analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (e.g., Active, Closed, Dormant) for account portfolio governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the bank account for multi-currency cash position analysis."
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the banking institution for bank concentration risk analysis."
    - name: "branch_country_code"
      expr: branch_country_code
      comment: "Country of the bank branch for geographic cash distribution analysis."
    - name: "branch_state"
      expr: branch_state
      comment: "State of the bank branch for regional treasury management analysis."
    - name: "zero_balance_indicator"
      expr: zero_balance_indicator
      comment: "Flag indicating zero-balance accounts used in cash concentration structures, for ZBA pool analysis."
    - name: "lockbox_indicator"
      expr: lockbox_indicator
      comment: "Flag indicating lockbox-enabled accounts used for accelerated receivables collection."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Frequency of bank statements (e.g., Daily, Weekly, Monthly) for reconciliation scheduling analysis."
    - name: "last_reconciliation_month"
      expr: DATE_TRUNC('month', last_reconciliation_date)
      comment: "Last reconciliation date truncated to month for identifying accounts with stale reconciliations."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current cash balance across all bank accounts. Core treasury metric used by CFO and Treasurer to monitor enterprise-wide cash position."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available (cleared) cash balance across all accounts. Used for liquidity management and same-day cash availability decisions."
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Total overdraft facility available across bank accounts. Used by Treasury to assess short-term borrowing capacity and liquidity buffer."
    - name: "bank_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts in the portfolio. Used for account rationalization initiatives and banking relationship management."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active bank accounts. Used to track account portfolio size and identify opportunities for account consolidation."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per bank account. Used to identify accounts with excess idle cash that could be swept into concentration accounts."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across bank accounts. Used by Treasury to optimize cash placement and maximize yield on operating balances."
    - name: "distinct_bank_count"
      expr: COUNT(DISTINCT bank_key)
      comment: "Number of distinct banking institutions in the portfolio. Used to assess bank concentration risk and rationalize banking relationships."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center master data metrics tracking store and business unit portfolio characteristics, same-store sales eligibility, and organizational structure for the grocery finance domain."
  source: "`grocery_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (e.g., Store, Distribution Center, Corporate) for organizational segmentation."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Current operational status of the profit center (e.g., Active, Closed, Remodeling) for portfolio health analysis."
    - name: "banner_code"
      expr: banner_code
      comment: "Retail banner associated with the profit center (e.g., flagship brand, discount banner) for brand-level financial performance analysis."
    - name: "market_code"
      expr: market_code
      comment: "Market or geographic cluster code for regional financial performance analysis."
    - name: "district_code"
      expr: district_code
      comment: "District code for district-level financial performance and management reporting."
    - name: "region_code"
      expr: region_code
      comment: "Region code for regional financial performance analysis and territory management."
    - name: "segment_code"
      expr: segment_code
      comment: "Business segment code for segment-level financial reporting and strategic analysis."
    - name: "same_store_sales_eligible_flag"
      expr: same_store_sales_eligible_flag
      comment: "Flag indicating whether the profit center qualifies for same-store sales (comp sales) reporting — a critical retail KPI for organic growth measurement."
    - name: "comp_sales_eligible_flag"
      expr: comp_sales_eligible_flag
      comment: "Flag indicating comp sales eligibility, used to define the comparable store base for like-for-like performance analysis."
    - name: "opening_date_year"
      expr: DATE_TRUNC('year', opening_date)
      comment: "Profit center opening date truncated to year for store vintage cohort analysis."
    - name: "remodel_date_year"
      expr: DATE_TRUNC('year', remodel_date)
      comment: "Most recent remodel date truncated to year for capital investment impact analysis."
  measures:
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Total number of profit centers in the portfolio. Used by Real Estate and Finance leadership to track store count, network size, and expansion progress."
    - name: "active_profit_center_count"
      expr: COUNT(CASE WHEN profit_center_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active profit centers. Core network health metric used by Operations and Finance to track the productive store base."
    - name: "comp_store_count"
      expr: COUNT(CASE WHEN same_store_sales_eligible_flag = TRUE THEN 1 END)
      comment: "Number of profit centers eligible for same-store sales (comp) reporting. Defines the comparable store base used in the most critical retail growth metric."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total retail square footage across profit centers. Used for sales-per-square-foot productivity analysis and real estate portfolio management."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average store size in square feet. Used to benchmark store format strategy and assess the impact of store size on financial performance."
    - name: "distinct_banner_count"
      expr: COUNT(DISTINCT banner_code)
      comment: "Number of distinct retail banners in the profit center portfolio. Used to assess brand portfolio complexity and multi-banner strategy effectiveness."
    - name: "distinct_market_count"
      expr: COUNT(DISTINCT market_code)
      comment: "Number of distinct markets with profit center presence. Used to assess geographic diversification and market penetration strategy."
$$;