-- Metric views for domain: finance | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable KPIs tracking outstanding liabilities, payment efficiency, discount capture, and aging exposure. Used by CFO, Treasury, and AP teams to manage cash outflows and supplier relationships."
  source: "`ecommerce_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "ap_status"
      expr: ap_status
      comment: "Current status of the AP record (e.g., Open, Paid, Disputed) — primary operational segmentation for AP aging and liability analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the payable (e.g., Current, 1-30 days, 31-60 days) — critical for cash flow forecasting and overdue liability management."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, Wire, Check) — used to analyze payment channel mix and associated costs."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g., Goods, Services, Logistics) — enables spend analysis by supplier category."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Memo, Recurring) — supports invoice mix analysis and process efficiency tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the payable — used for multi-currency exposure and FX risk analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables AP analysis segmented by operating entity."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable — supports year-over-year AP trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) of the payable — enables period-over-period AP liability tracking."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Agreed payment terms code (e.g., Net30, Net60) — used to assess compliance with negotiated terms and early payment discount eligibility."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/Invoice three-way match — key control indicator for AP processing quality and fraud prevention."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval workflow status — tracks bottlenecks in the AP approval pipeline."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date — used for cash flow scheduling and overdue liability identification."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the AP record was posted to the general ledger — used for period-close and accrual analysis."
  measures:
    - name: "total_gross_ap_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross accounts payable amount outstanding. Core liability metric used by CFO and Treasury to manage cash outflow obligations and working capital."
    - name: "total_net_ap_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net accounts payable amount after discounts and adjustments. Represents the actual cash obligation and is the primary AP balance metric for financial reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount embedded in AP invoices. Used by tax and finance teams to reconcile input VAT/GST and ensure accurate tax liability reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured from suppliers. Directly measures the financial benefit of proactive AP management and treasury efficiency."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments. Required for tax compliance reporting and reconciliation with tax authorities."
    - name: "total_base_currency_ap"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total AP balance expressed in base/functional currency after FX conversion. Enables consolidated multi-currency AP reporting for group-level financial statements."
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT accounts_payable_id)
      comment: "Number of distinct AP invoices. Used to track AP processing volume, benchmark team capacity, and identify invoice backlog trends."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Helps identify shifts in supplier invoice size, detect anomalies, and benchmark against prior periods."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN ap_status = 'Disputed' THEN accounts_payable_id END)
      comment: "Number of AP invoices currently in dispute. High dispute counts signal supplier relationship issues, process failures, or fraud risk requiring immediate management attention."
    - name: "overdue_ap_amount"
      expr: SUM(CASE WHEN days_past_due > '0' THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net AP amount that is past due. Critical cash management and supplier relationship metric — overdue payables risk supply disruption and penalty charges."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'Matched' THEN accounts_payable_id END)
      comment: "Number of invoices failing three-way match (PO/GR/Invoice). A key internal control metric — high failure rates indicate procurement process breakdowns or fraud exposure."
    - name: "recurring_invoice_amount"
      expr: SUM(CASE WHEN is_recurring = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total AP amount from recurring invoices (e.g., subscriptions, retainers). Enables committed spend forecasting and identification of auto-renewal obligations."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable KPIs tracking revenue collectability, aging exposure, write-off risk, and collection efficiency. Used by CFO, Revenue, and Collections teams to manage cash inflows and credit risk."
  source: "`ecommerce_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "ar_status"
      expr: ar_status
      comment: "Current status of the AR record (e.g., Open, Collected, Written Off) — primary segmentation for AR aging and collectability analysis."
    - name: "ar_type"
      expr: ar_type
      comment: "Type of AR record (e.g., Invoice, Credit Memo, Debit Memo) — used to distinguish revenue-generating receivables from adjustments."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the receivable (e.g., Current, 1-30, 31-60, 60+ days) — core metric for credit risk and collections prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the receivable — used for multi-currency AR exposure and FX risk analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables AR analysis segmented by operating entity."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the receivable — supports year-over-year AR trend and bad debt analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the receivable — enables period-close AR balance and collection rate tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or expected (e.g., Credit Card, Bank Transfer) — used to analyze collection channel effectiveness."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Agreed payment terms code — used to assess compliance with credit terms and identify customers exceeding agreed payment windows."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any dispute on the receivable — tracks disputed AR volume and resolution pipeline."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning/collections escalation level — indicates severity of collection effort and customer payment risk."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date — used for cash flow forecasting and overdue receivable identification."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued — used for DSO calculation and revenue recognition timing analysis."
    - name: "write_off_date"
      expr: write_off_date
      comment: "Date the receivable was written off — used for bad debt trend analysis and credit policy evaluation."
  measures:
    - name: "total_gross_ar_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross accounts receivable balance. Core revenue collectability metric used by CFO and Revenue teams to track outstanding customer obligations."
    - name: "total_open_ar_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (uncollected) AR balance. The primary working capital metric for AR — directly drives cash flow forecasting and collections prioritization."
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against AR invoices. Measures collections team effectiveness and actual cash inflow realization."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total AR written off as uncollectable. A critical credit risk and bad debt metric — rising write-offs signal deteriorating customer credit quality or collections failures."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo adjustments against AR. Tracks revenue reversals and customer dispute resolutions — high values may indicate product quality or billing accuracy issues."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts granted to customers. Measures the cost of accelerating cash collection through discount incentives."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices. Used for output VAT/GST reconciliation and tax liability reporting."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Number of distinct customers with outstanding AR. Measures credit exposure breadth — concentration in few customers signals elevated credit risk."
    - name: "overdue_ar_amount"
      expr: SUM(CASE WHEN days_past_due > '0' THEN CAST(open_amount AS DOUBLE) ELSE 0 END)
      comment: "Total open AR amount that is past due. The primary collections urgency metric — directly tied to cash flow risk and potential bad debt exposure."
    - name: "disputed_ar_amount"
      expr: SUM(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'Resolved' THEN CAST(open_amount AS DOUBLE) ELSE 0 END)
      comment: "Total AR amount currently under dispute. Tracks revenue at risk from customer disputes — high values require escalation to revenue assurance and customer success teams."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN write_off_amount > 0 THEN accounts_receivable_id END)
      comment: "Number of invoices with write-off activity. Tracks bad debt frequency — used alongside write-off amount to assess average write-off size and credit policy effectiveness."
    - name: "avg_open_ar_per_customer"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open AR balance per AR record. Benchmarks typical customer exposure and helps identify outlier accounts requiring targeted collections attention."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs tracking recognized revenue, deferred revenue, GMV-to-revenue conversion, and ASC 606/IFRS 15 compliance. Used by CFO, Revenue Accounting, and FP&A to manage revenue quality and timing."
  source: "`ecommerce_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the revenue recognition event (e.g., Recognized, Deferred, Pending) — primary segmentation for revenue pipeline analysis."
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of revenue recognition (e.g., Point-in-Time, Over-Time) — used to classify revenue streams by ASC 606/IFRS 15 performance obligation pattern."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognize revenue (e.g., Percentage Complete, Milestone) — enables analysis of revenue recognition methodology mix."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Business category of the revenue (e.g., Product Sales, Marketplace Fees, Subscription) — core dimension for revenue mix and growth analysis."
    - name: "principal_agent_indicator"
      expr: principal_agent_indicator
      comment: "Indicates whether revenue is recognized on a gross (principal) or net (agent) basis — critical for GMV vs. net revenue reporting and regulatory compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the revenue event — used for multi-currency revenue analysis and FX impact assessment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the recognition event — enables period-close revenue reporting and monthly/quarterly trend analysis."
    - name: "recognition_trigger"
      expr: recognition_trigger
      comment: "Business event that triggered revenue recognition (e.g., Delivery, Acceptance, Subscription Renewal) — used to analyze revenue trigger mix and timing patterns."
    - name: "recognition_period_start_date"
      expr: recognition_period_start_date
      comment: "Start date of the revenue recognition period — used for time-series revenue analysis and deferred revenue scheduling."
    - name: "recognition_period_end_date"
      expr: recognition_period_end_date
      comment: "End date of the revenue recognition period — used alongside start date for revenue spread and deferred balance analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Indicates whether the recognition event is subject to SOX controls — used for compliance reporting and audit scoping."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period per ASC 606/IFRS 15. The primary top-line revenue metric used by CFO, FP&A, and Board for financial performance assessment."
    - name: "total_net_recognized_revenue"
      expr: SUM(CAST(net_recognized_amount AS DOUBLE))
      comment: "Total net recognized revenue after refunds, adjustments, and variable consideration. Represents the highest-quality revenue figure for financial reporting and investor communications."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods (e.g., unearned subscription revenue). A key balance sheet liability metric and leading indicator of future revenue recognition."
    - name: "total_gmv"
      expr: SUM(CAST(gmv_amount AS DOUBLE))
      comment: "Total Gross Merchandise Value processed through the platform. The primary marketplace volume metric used by executives to assess platform scale and growth trajectory."
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total contracted transaction price across all performance obligations. Used to assess total revenue under contract vs. amount recognized — key for revenue backlog analysis."
    - name: "total_promotional_discount"
      expr: SUM(CAST(promotional_discount_amount AS DOUBLE))
      comment: "Total promotional discounts applied as variable consideration reductions. Measures the revenue impact of promotional activity and discount strategy effectiveness."
    - name: "total_refund_adjustment"
      expr: SUM(CAST(refund_adjustment_amount AS DOUBLE))
      comment: "Total refund and return adjustments reducing recognized revenue. High refund rates signal product quality, fulfillment, or customer satisfaction issues requiring executive attention."
    - name: "total_subscription_mrr"
      expr: SUM(CAST(subscription_mrr_amount AS DOUBLE))
      comment: "Total Monthly Recurring Revenue from subscription-based performance obligations. Core SaaS/subscription health metric used by CFO and investors to assess revenue predictability."
    - name: "total_variable_consideration_estimate"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total estimated variable consideration (e.g., rebates, penalties, bonuses) included in transaction price. Tracks revenue estimation risk and constraint application under ASC 606."
    - name: "avg_recognized_amount_per_event"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized revenue per recognition event. Benchmarks revenue event size and helps identify shifts in deal/transaction mix over time."
    - name: "constrained_recognition_count"
      expr: COUNT(CASE WHEN constraint_applied = TRUE THEN revenue_recognition_id END)
      comment: "Number of recognition events where variable consideration constraint was applied. Tracks revenue recognition conservatism and ASC 606 constraint application frequency — high counts may indicate elevated revenue estimation uncertainty."
    - name: "distinct_seller_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers generating recognized revenue. Measures marketplace revenue breadth — concentration risk is flagged when few sellers drive disproportionate revenue."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger KPIs tracking account balances, posting activity, and chart-of-accounts health. Used by Controllers, CFO, and Audit teams for financial close, balance sheet integrity, and compliance reporting."
  source: "`ecommerce_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "GL account type (e.g., Asset, Liability, Equity, Revenue, Expense) — primary dimension for financial statement classification and balance analysis."
    - name: "account_category"
      expr: account_category
      comment: "Detailed account category within the account type — enables granular P&L and balance sheet segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Status of the GL account (e.g., Active, Blocked, Archived) — used to monitor chart-of-accounts hygiene and identify inactive accounts with residual balances."
    - name: "financial_statement_section"
      expr: financial_statement_section
      comment: "Section of the financial statement where the account appears (e.g., Income Statement, Balance Sheet) — used for automated financial statement preparation."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables GL balance analysis segmented by operating entity for consolidation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the GL balance — supports year-over-year balance trend and budget vs. actual analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the GL balance — enables period-close balance reporting and monthly trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the GL account balance — used for multi-currency consolidation and FX impact analysis."
    - name: "chart_of_accounts_code"
      expr: chart_of_accounts_code
      comment: "Chart of accounts identifier — used to segment GL analysis by accounting framework or legal entity chart."
    - name: "normal_balance"
      expr: normal_balance
      comment: "Expected normal balance direction (Debit/Credit) — used to detect accounts with abnormal balance signs indicating posting errors."
    - name: "is_balance_sheet_relevant"
      expr: is_balance_sheet_relevant
      comment: "Indicates whether the account appears on the balance sheet — used to filter GL analysis to balance sheet vs. P&L accounts."
    - name: "is_reconciliation_account"
      expr: is_reconciliation_account
      comment: "Indicates whether the account is a reconciliation account (e.g., AR/AP control account) — used to scope reconciliation completeness checks."
  measures:
    - name: "total_account_balance_group_currency"
      expr: SUM(CAST(account_balance_gc AS DOUBLE))
      comment: "Total GL account balance in group/reporting currency. The primary consolidated balance metric used by Group Finance for financial statement preparation and consolidation."
    - name: "total_account_balance_local_currency"
      expr: SUM(CAST(account_balance_lc AS DOUBLE))
      comment: "Total GL account balance in local/functional currency. Used by entity-level controllers for statutory reporting and local GAAP compliance."
    - name: "distinct_active_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN general_ledger_id END)
      comment: "Number of active GL accounts in the chart of accounts. Tracks chart-of-accounts complexity — excessive account proliferation increases close effort and audit risk."
    - name: "posting_blocked_account_count"
      expr: COUNT(CASE WHEN is_posting_allowed = FALSE THEN general_ledger_id END)
      comment: "Number of GL accounts where posting is blocked. Monitors chart-of-accounts governance — blocked accounts with recent activity indicate control failures."
    - name: "avg_account_balance_group_currency"
      expr: AVG(CAST(account_balance_gc AS DOUBLE))
      comment: "Average GL account balance in group currency. Used to benchmark typical account balance size and identify outlier accounts requiring reconciliation attention."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry KPIs tracking posting volumes, amounts, reversal rates, and intercompany activity. Used by Controllers, Internal Audit, and CFO for financial close quality, SOX compliance, and anomaly detection."
  source: "`ecommerce_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., Invoice, Payment, Accrual, Reversal) — primary dimension for journal entry mix and close activity analysis."
    - name: "entry_type"
      expr: entry_type
      comment: "Classification of the journal entry (e.g., Manual, System-Generated, Recurring) — used to monitor manual journal entry volume, a key SOX control indicator."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g., Posted, Parked, Blocked) — used to track unposted entries that may affect period-close completeness."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables journal entry analysis segmented by operating entity."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry — supports year-over-year posting volume and amount trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry — enables period-close journal entry volume and amount tracking."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the journal entry was posted to the ledger — used for close timeline analysis and late-posting detection."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Indicates whether the journal entry is an intercompany transaction — used to scope intercompany elimination analysis and consolidation reconciliation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the journal entry has been reversed — used to track reversal rates as a financial close quality and error correction metric."
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Currency of the original transaction — used for multi-currency journal entry analysis and FX impact assessment."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Indicates whether the entry is a debit or credit — used for balance verification and anomaly detection in journal entry patterns."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all journal entries. Measures total financial activity posted to the ledger — a key indicator of business volume and close completeness."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total journal entry amount in local/functional currency. Used for entity-level financial reporting and local GAAP statutory accounts preparation."
    - name: "total_group_amount"
      expr: SUM(CAST(group_amount AS DOUBLE))
      comment: "Total journal entry amount in group reporting currency. Used for consolidated financial statement preparation and group-level performance reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries. Used for tax provision reconciliation and indirect tax compliance reporting."
    - name: "total_journal_entry_count"
      expr: COUNT(DISTINCT journal_entry_id)
      comment: "Total number of distinct journal entries posted. Tracks financial close activity volume — spikes in manual entries are a SOX red flag requiring audit scrutiny."
    - name: "manual_journal_entry_count"
      expr: COUNT(CASE WHEN entry_type = 'Manual' THEN journal_entry_id END)
      comment: "Number of manually created journal entries. A primary SOX control metric — high manual entry volumes increase fraud and error risk and trigger audit review."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of journal entries that have been reversed. Tracks financial close error correction frequency — high reversal rates indicate posting quality issues or process failures."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN is_intercompany = TRUE THEN journal_entry_id END)
      comment: "Number of intercompany journal entries. Used to scope intercompany reconciliation effort and monitor elimination completeness during group consolidation."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per journal entry. Benchmarks typical posting size — significant deviations from average may indicate unusual transactions requiring investigation."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax KPIs tracking tax liabilities, filing compliance, exemption rates, and marketplace facilitator obligations. Used by Tax, CFO, and Legal teams for indirect tax compliance, regulatory reporting, and audit defense."
  source: "`ecommerce_ecm`.`finance`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., VAT, GST, Sales Tax, Withholding Tax) — primary dimension for tax liability analysis by tax regime."
    - name: "tax_jurisdiction_level"
      expr: tax_jurisdiction_level
      comment: "Level of the tax jurisdiction (e.g., Federal, State, Local) — used to analyze tax exposure by jurisdiction tier."
    - name: "tax_jurisdiction_name"
      expr: tax_jurisdiction_name
      comment: "Name of the tax jurisdiction — enables geographic tax liability analysis and jurisdiction-level compliance tracking."
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the tax filing (e.g., Filed, Pending, Overdue) — critical compliance metric for identifying unfiled or overdue tax obligations."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Tax treatment applied to the transaction (e.g., Standard, Reduced, Zero-Rated, Exempt) — used to analyze tax treatment mix and validate exemption application."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables tax liability analysis segmented by operating entity."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax record — supports year-over-year tax liability trend and effective tax rate analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax record — enables period-level tax accrual and filing obligation tracking."
    - name: "is_marketplace_facilitator"
      expr: is_marketplace_facilitator
      comment: "Indicates whether the tax obligation arises from marketplace facilitator rules — critical for e-commerce platforms with state-level marketplace facilitator tax collection mandates."
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Indicates whether the transaction is tax-exempt — used to monitor exemption certificate coverage and validate exempt transaction rates."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of underlying transaction generating the tax record (e.g., Sale, Refund, Purchase) — used to segment tax analysis by transaction category."
    - name: "due_date"
      expr: due_date
      comment: "Tax payment due date — used for cash flow planning and overdue tax liability identification."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all tax records. The primary tax liability metric used by Tax and CFO for provision calculation, cash flow planning, and regulatory reporting."
    - name: "total_tax_amount_local_currency"
      expr: SUM(CAST(tax_amount_local_currency AS DOUBLE))
      comment: "Total tax amount in local currency. Used for statutory tax filing and local jurisdiction remittance calculations."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable base amount subject to tax. Used to calculate effective tax rates and validate tax calculation accuracy against expected rates."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net transaction amount after tax. Used for revenue and cost reconciliation against tax records."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across tax records. Used to monitor blended tax rate trends and detect anomalies in tax rate application that may indicate misconfiguration or fraud."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Overdue' THEN tax_record_id END)
      comment: "Number of tax filings that are overdue. A critical compliance risk metric — overdue filings expose the business to penalties, interest, and regulatory sanctions."
    - name: "exempt_transaction_count"
      expr: COUNT(CASE WHEN is_tax_exempt = TRUE THEN tax_record_id END)
      comment: "Number of tax-exempt transactions. Used to monitor exemption certificate coverage and validate that exempt transaction rates are within expected ranges for audit defense."
    - name: "marketplace_facilitator_tax_amount"
      expr: SUM(CASE WHEN is_marketplace_facilitator = TRUE THEN CAST(tax_amount AS DOUBLE) ELSE 0 END)
      comment: "Total tax collected under marketplace facilitator rules. Critical for e-commerce platforms — tracks state-mandated marketplace facilitator tax collection obligations and remittance compliance."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT tax_jurisdiction_code)
      comment: "Number of distinct tax jurisdictions with active tax records. Measures tax compliance complexity — high jurisdiction counts drive compliance cost and audit exposure."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center KPIs tracking budget allocation, spend capacity, and organizational cost structure. Used by FP&A, CFO, and Business Unit leaders for budget management, cost allocation, and financial planning."
  source: "`ecommerce_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category of the cost center (e.g., Production, Administration, Sales) — primary dimension for cost structure analysis by organizational function."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Operational status of the cost center (e.g., Active, Inactive, Blocked) — used to monitor cost center lifecycle and identify inactive centers with residual budget."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the cost center — enables cost analysis segmented by major organizational division."
    - name: "department"
      expr: department
      comment: "Department associated with the cost center — enables granular departmental cost tracking and budget variance analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables cost center analysis segmented by operating entity."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost center budget — supports year-over-year budget and cost trend analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the cost center — enables regional cost structure and budget allocation analysis."
    - name: "cost_allocation_method"
      expr: cost_allocation_method
      comment: "Method used to allocate costs from this center (e.g., Direct, Activity-Based) — used to analyze cost allocation methodology mix and its impact on product/service costing."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the cost center in the organizational hierarchy — used for roll-up budget analysis from granular to executive reporting levels."
    - name: "sox_relevant"
      expr: sox_relevant
      comment: "Indicates whether the cost center is in scope for SOX controls — used to scope financial control testing and compliance reporting."
  measures:
    - name: "total_annual_budget"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget allocated across cost centers. The primary budget capacity metric used by FP&A and CFO for resource allocation decisions and budget vs. actual variance analysis."
    - name: "avg_annual_budget_per_center"
      expr: AVG(CAST(annual_budget_amount AS DOUBLE))
      comment: "Average annual budget per cost center. Used to benchmark cost center funding levels and identify over- or under-resourced organizational units."
    - name: "active_cost_center_count"
      expr: COUNT(CASE WHEN cost_center_status = 'Active' THEN cost_center_id END)
      comment: "Number of active cost centers. Tracks organizational cost structure complexity — excessive cost center proliferation increases allocation overhead and reporting complexity."
    - name: "sox_relevant_center_count"
      expr: COUNT(CASE WHEN sox_relevant = TRUE THEN cost_center_id END)
      comment: "Number of cost centers in scope for SOX controls. Used by Internal Audit and Compliance to scope control testing effort and resource allocation for SOX compliance programs."
    - name: "total_budget_across_active_centers"
      expr: SUM(CASE WHEN cost_center_status = 'Active' THEN CAST(annual_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total annual budget allocated to active cost centers only. Provides a clean view of deployable budget excluding inactive or blocked centers — used for operational budget planning."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center KPIs tracking revenue and cost budgets, margin targets, take rates, and GMV-to-revenue conversion. Used by CFO, FP&A, and Business Unit leaders for profitability management and strategic planning."
  source: "`ecommerce_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category of the profit center (e.g., Product Line, Geography, Channel) — primary dimension for profitability analysis by business segment."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Operational status of the profit center (e.g., Active, Inactive) — used to scope profitability analysis to active business segments."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables profit center analysis segmented by operating entity."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the profit center — enables regional profitability and budget analysis."
    - name: "segment_type"
      expr: segment_type
      comment: "Business segment type of the profit center — used for segment-level profitability reporting required under IFRS 8/ASC 280."
    - name: "budget_fiscal_year"
      expr: budget_fiscal_year
      comment: "Fiscal year of the profit center budget — supports year-over-year budget and profitability trend analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied to the profit center — used to analyze revenue recognition methodology mix across business segments."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the profit center in the organizational hierarchy — used for roll-up profitability analysis from granular to executive reporting levels."
    - name: "sox_control_relevant"
      expr: sox_control_relevant
      comment: "Indicates whether the profit center is subject to SOX controls — used to scope financial control testing and compliance reporting."
  measures:
    - name: "total_annual_revenue_budget"
      expr: SUM(CAST(annual_revenue_budget AS DOUBLE))
      comment: "Total annual revenue budget across profit centers. The primary revenue planning metric used by CFO and FP&A for budget setting, target allocation, and budget vs. actual variance analysis."
    - name: "total_annual_cost_budget"
      expr: SUM(CAST(annual_cost_budget AS DOUBLE))
      comment: "Total annual cost budget across profit centers. Used alongside revenue budget to assess planned margin and resource allocation decisions at the segment level."
    - name: "avg_target_margin_pct"
      expr: AVG(CAST(target_margin_pct AS DOUBLE))
      comment: "Average target margin percentage across profit centers. Benchmarks profitability ambition across business segments — used by CFO and Board to assess margin strategy and set performance expectations."
    - name: "avg_take_rate_pct"
      expr: AVG(CAST(take_rate_pct AS DOUBLE))
      comment: "Average marketplace take rate percentage across profit centers. A critical e-commerce monetization metric — measures the platform's revenue capture as a percentage of GMV processed."
    - name: "avg_gmv_to_revenue_ratio"
      expr: AVG(CAST(gmv_to_revenue_ratio AS DOUBLE))
      comment: "Average GMV-to-revenue conversion ratio across profit centers. Measures how efficiently the platform converts gross merchandise volume into recognized net revenue — a key marketplace monetization efficiency metric."
    - name: "active_profit_center_count"
      expr: COUNT(CASE WHEN profit_center_status = 'Active' THEN profit_center_id END)
      comment: "Number of active profit centers. Tracks business segment complexity — used by FP&A to manage reporting granularity and ensure adequate segment coverage for strategic planning."
    - name: "total_budgeted_margin"
      expr: SUM(CAST(annual_revenue_budget AS DOUBLE) - CAST(annual_cost_budget AS DOUBLE))
      comment: "Total budgeted margin (revenue budget minus cost budget) across profit centers. The primary planned profitability metric used by CFO and Board for financial target-setting and performance evaluation."
$$;