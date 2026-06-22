-- Metric views for domain: finance | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking vendor spend, outstanding liabilities, discount capture, and invoice processing efficiency. Core to cash management and vendor relationship oversight."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g., Open, Paid, Disputed, Cancelled)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., Standard, Credit Memo, Prepayment)."
    - name: "expense_category"
      expr: expense_category
      comment: "Business expense category for spend analysis and budget alignment."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the invoice, used to track bottlenecks in the payables process."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period in which the invoice was recorded, enabling period-over-period spend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual spend reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency spend analysis."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Due date truncated to month for cash flow forecasting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/Invoice three-way match, critical for procurement controls."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Baseline volume metric for payables workload and vendor activity."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes. Represents total vendor spend commitment."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Actual payables liability on the books."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices. Used for tax liability reporting and compliance."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid outstanding AP balance. Key cash flow and working capital metric."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Measures actual cash disbursements to vendors."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Measures effectiveness of discount capture strategy."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Benchmarks typical vendor transaction size and detects anomalies."
    - name: "outstanding_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total invoiced amount still outstanding. Measures AP clearance efficiency."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross spend captured as early-payment discounts. Directly impacts cost savings."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN 1 END)
      comment: "Number of invoices in disputed status. Elevated disputes signal vendor or process quality issues."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'Matched' AND three_way_match_status IS NOT NULL THEN 1 END)
      comment: "Count of invoices failing three-way match. Procurement control KPI — failures increase fraud and error risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics covering disbursement volumes, reversal rates, discount utilization, and payment timing. Supports treasury and cash management decisions."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the payment, used to identify bottlenecks in the payment authorization process."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for period cash flow analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual disbursement reporting."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Base (functional) currency of the payment for consolidated treasury reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed. Used to track payment error and correction rates."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month for cash disbursement trend analysis."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('month', gl_posting_date)
      comment: "GL posting date truncated to month for period-accurate financial reporting."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments processed. Baseline volume metric for payment operations."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed to vendors. Primary cash outflow metric."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and fees. Actual cash leaving the organization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts applied at payment time. Measures realized savings from prompt payment."
    - name: "total_bank_fee_amount"
      expr: SUM(CAST(bank_fee_amount AS DOUBLE))
      comment: "Total bank fees incurred on payments. Tracks transaction cost efficiency."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for tax compliance reporting."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment amount in base/functional currency. Enables consolidated multi-currency cash reporting."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed payments. High reversal rates indicate payment process quality issues."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were reversed. Key payment quality and controls KPI."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks typical disbursement size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue billed, collections performance, aging, and write-off risk. Critical for revenue recognition, cash flow, and credit management decisions."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., Open, Paid, Overdue, Written Off)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (e.g., Guest Folio, Corporate, Group, Event)."
    - name: "billing_entity_type"
      expr: billing_entity_type
      comment: "Type of billing entity (e.g., Individual, Corporate, Travel Agent) for receivables segmentation."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status for overdue invoices. Drives collections prioritization."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification (e.g., Current, 30-60, 60-90, 90+) for DSO and credit risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency receivables reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute. Disputed invoices delay cash collection."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the invoice has been written off as uncollectable."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for revenue billing trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Due date truncated to month for cash collection forecasting."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices. Baseline billing volume metric."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount billed to guests and corporate accounts. Primary revenue billing KPI."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid AR balance. Core working capital and cash flow metric."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected against AR invoices. Measures collections effectiveness."
    - name: "total_room_revenue_billed"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue billed on AR invoices. Tracks rooms revenue recognition."
    - name: "total_fnb_revenue_billed"
      expr: SUM(CAST(fnb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue billed on AR invoices. Tracks food and beverage revenue recognition."
    - name: "total_event_revenue_billed"
      expr: SUM(CAST(event_revenue_amount AS DOUBLE))
      comment: "Total event/banquet revenue billed on AR invoices. Tracks events revenue recognition."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on AR invoices. Required for tax remittance and compliance reporting."
    - name: "total_write_off_amount"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN outstanding_balance ELSE 0 END)
      comment: "Total amount written off as uncollectable. Measures bad debt exposure and credit risk."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount collected. Primary collections efficiency KPI."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices written off. Measures credit quality and collections failure rate."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed AR invoices. Disputes delay cash collection and signal billing quality issues."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice. Benchmarks typical receivable size for credit management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment receipt metrics covering cash collection volumes, refund rates, advance deposits, and exchange rate impacts. Supports revenue cycle and treasury management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "is_refund"
      expr: is_refund
      comment: "Indicates whether the payment is a refund. Refund volume is a guest satisfaction and revenue integrity signal."
    - name: "is_advance_deposit"
      expr: is_advance_deposit
      comment: "Indicates whether the payment is an advance deposit. Advance deposits represent committed future revenue."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Base currency for consolidated cash receipt reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment receipt date truncated to month for cash collection trend analysis."
    - name: "deposit_date_month"
      expr: DATE_TRUNC('month', deposit_date)
      comment: "Bank deposit date truncated to month for treasury reconciliation."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Settlement date truncated to month for cleared funds analysis."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payment receipts. Baseline cash collection volume metric."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash received from guests and corporate accounts. Primary revenue collection KPI."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after fees. Actual net cash received."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to AR invoices. Measures how effectively receipts are matched to open invoices."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash on account. High unapplied balances indicate cash application process gaps."
    - name: "total_transaction_fee"
      expr: SUM(CAST(transaction_fee AS DOUBLE))
      comment: "Total payment processing fees incurred. Tracks cost of payment acceptance."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total receipts in base/functional currency. Enables consolidated multi-currency cash reporting."
    - name: "refund_count"
      expr: COUNT(CASE WHEN is_refund = TRUE THEN 1 END)
      comment: "Number of refund transactions. Elevated refunds signal guest dissatisfaction or billing errors."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refund = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment transactions that are refunds. Key revenue integrity and guest satisfaction KPI."
    - name: "advance_deposit_amount"
      expr: SUM(CASE WHEN is_advance_deposit = TRUE THEN payment_amount ELSE 0 END)
      comment: "Total advance deposit receipts. Represents committed future revenue and reduces cancellation risk."
    - name: "unapplied_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash that remains unapplied to invoices. Measures cash application efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budget performance metrics covering budgeted vs. actuals for rooms, F&B, events, labor, and profitability KPIs. The single source of truth for budget analysis per VREQ-027 SSOT governance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and performance review."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget for monthly budget vs. actual analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency budget consolidation."
    - name: "version"
      expr: version
      comment: "Budget version (e.g., Original, Revised, Forecast) for version-controlled budget analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Budget effective start date truncated to month for timeline analysis."
  measures:
    - name: "total_budgeted_rooms_revenue"
      expr: SUM(CAST(budgeted_rooms_revenue AS DOUBLE))
      comment: "Total budgeted rooms revenue. Primary rooms revenue planning KPI."
    - name: "total_budgeted_fnb_revenue"
      expr: SUM(CAST(budgeted_fnb_revenue AS DOUBLE))
      comment: "Total budgeted F&B revenue. Key F&B planning and performance benchmark."
    - name: "total_budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Total budgeted events/banquet revenue. Events revenue planning benchmark."
    - name: "total_budgeted_total_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all streams. Top-line revenue planning KPI."
    - name: "total_budgeted_labor_expense"
      expr: SUM(CAST(budgeted_labor_expense AS DOUBLE))
      comment: "Total budgeted labor expense. Labor is typically the largest operating cost in hospitality."
    - name: "total_budgeted_operating_expense"
      expr: SUM(CAST(budgeted_operating_expense AS DOUBLE))
      comment: "Total budgeted operating expenses. Drives cost management and efficiency planning."
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted Gross Operating Profit. Primary profitability planning KPI for hotel operations."
    - name: "total_budgeted_ebitda"
      expr: SUM(CAST(budgeted_ebitda AS DOUBLE))
      comment: "Total budgeted EBITDA. Key investor and ownership profitability benchmark."
    - name: "avg_budgeted_adr"
      expr: AVG(CAST(budgeted_adr AS DOUBLE))
      comment: "Average budgeted ADR (Average Daily Rate). Core rooms revenue planning metric."
    - name: "avg_budgeted_revpar"
      expr: AVG(CAST(budgeted_revpar AS DOUBLE))
      comment: "Average budgeted RevPAR (Revenue Per Available Room). Primary hotel revenue efficiency planning KPI."
    - name: "avg_budgeted_occupancy_rate"
      expr: AVG(CAST(budgeted_occupancy_rate AS DOUBLE))
      comment: "Average budgeted occupancy rate. Foundational demand planning metric."
    - name: "avg_budgeted_goppar"
      expr: AVG(CAST(budgeted_goppar AS DOUBLE))
      comment: "Average budgeted GOPPAR (GOP Per Available Room). Measures profitability efficiency per available room."
    - name: "avg_budgeted_trevpar"
      expr: AVG(CAST(budgeted_trevpar AS DOUBLE))
      comment: "Average budgeted TRevPAR (Total Revenue Per Available Room). Captures full revenue productivity planning."
    - name: "total_budgeted_noi"
      expr: SUM(CAST(budgeted_noi AS DOUBLE))
      comment: "Total budgeted Net Operating Income. Key ownership and investor return planning metric."
    - name: "labor_expense_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(budgeted_labor_expense AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_total_revenue AS DOUBLE)), 0), 2)
      comment: "Budgeted labor expense as a percentage of total revenue. Benchmarks labor efficiency in planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, debit/credit balances, reversal rates, and intercompany activity. Supports financial close quality and audit readiness."
  source: "`vibe_travel_hospitality_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "GL posting status of the journal entry (e.g., Posted, Pending, Rejected)."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., Standard, Accrual, Reversal, Intercompany)."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for period-close analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual GL reporting."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Transaction currency for multi-currency GL analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flags intercompany journal entries for elimination and consolidation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversal entries. High reversal rates may indicate period-end accrual quality issues."
    - name: "capex_indicator"
      expr: capex_indicator
      comment: "Flags capital expenditure journal entries for CapEx tracking and asset capitalization."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for period-close volume and timing analysis."
  measures:
    - name: "total_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries. Baseline GL activity volume metric for close process monitoring."
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entries. Used to verify GL balance and detect anomalies."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entries. Must equal total debits for a balanced ledger."
    - name: "debit_credit_variance"
      expr: ROUND(SUM(CAST(debit_amount AS DOUBLE)) - SUM(CAST(credit_amount AS DOUBLE)), 2)
      comment: "Difference between total debits and credits. Should be zero; non-zero values indicate GL imbalance requiring immediate investigation."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. Tracks accrual reversal activity and period-end quality."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. High rates may indicate excessive accrual corrections."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Required for consolidation elimination analysis."
    - name: "capex_entry_count"
      expr: COUNT(CASE WHEN capex_indicator = TRUE THEN 1 END)
      comment: "Number of CapEx journal entries. Tracks capital expenditure activity for asset management."
    - name: "avg_debit_amount"
      expr: AVG(CAST(debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry. Benchmarks typical transaction size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_gl_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL batch processing metrics covering posting volumes, batch balance status, reversal activity, and period-close efficiency. Supports financial close management and audit controls."
  source: "`vibe_travel_hospitality_v1`.`finance`.`gl_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the GL batch (e.g., Open, Posted, Reversed, Error)."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of GL batch (e.g., Manual, Automated, Recurring, Intercompany)."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the batch for period-close volume analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the batch for annual GL activity reporting."
    - name: "source_module"
      expr: source_module
      comment: "Source system module that generated the batch (e.g., AP, AR, Payroll, Revenue). Identifies posting origins."
    - name: "is_balanced"
      expr: is_balanced
      comment: "Indicates whether the batch is in balance (debits = credits). Unbalanced batches block period close."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the batch is a recurring entry. Tracks automated vs. manual posting activity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the batch. Pending approvals delay period close."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for period-close timing analysis."
  measures:
    - name: "total_batch_count"
      expr: COUNT(1)
      comment: "Total number of GL batches. Baseline posting volume metric for close process monitoring."
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all GL batches. Measures total GL posting activity."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all GL batches. Must equal total debits for balanced books."
    - name: "total_control_total"
      expr: SUM(CAST(control_total AS DOUBLE))
      comment: "Sum of batch control totals. Used for batch-level reconciliation and audit trail."
    - name: "unbalanced_batch_count"
      expr: COUNT(CASE WHEN is_balanced = FALSE THEN 1 END)
      comment: "Number of unbalanced GL batches. Unbalanced batches are a critical financial close blocker."
    - name: "unbalanced_batch_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_balanced = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GL batches that are unbalanced. Key financial close quality KPI."
    - name: "pending_approval_batch_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of batches awaiting approval. Pending approvals are a period-close risk."
    - name: "avg_batch_debit_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average debit amount per GL batch. Benchmarks typical batch size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_management_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hotel management fee metrics covering base and incentive fee amounts, payment status, and reversal activity. Critical for HMA contract compliance and owner-operator financial relationship management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`management_fee`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the management fee for period-over-period fee trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the management fee for annual fee reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the management fee for multi-currency fee reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the management fee calculation. Unapproved fees delay owner distributions."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for fee calculation (e.g., Gross Revenue, GOP, Total Revenue). Determines fee structure type."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the fee record is a reversal. Reversals may indicate calculation disputes."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flags intercompany management fee transactions for consolidation elimination."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Indicates SOX-controlled fee transactions requiring enhanced audit documentation."
    - name: "calculation_date_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Fee calculation date truncated to month for trend analysis."
  measures:
    - name: "total_fee_count"
      expr: COUNT(1)
      comment: "Total number of management fee records. Baseline fee activity volume metric."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total management fee amount charged. Primary HMA contract financial performance KPI."
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net management fee after adjustments. Actual fee revenue recognized by the management company."
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total fee calculation basis amount (e.g., total revenue or GOP). Used to verify fee rate application."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total fee adjustments applied. Significant adjustments may indicate calculation disputes or corrections."
    - name: "avg_fee_rate_percentage"
      expr: AVG(CAST(fee_rate_percentage AS DOUBLE))
      comment: "Average management fee rate percentage. Benchmarks fee rates across properties and contracts."
    - name: "effective_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(basis_amount AS DOUBLE)), 0), 2)
      comment: "Effective management fee rate as net fee divided by basis amount. Validates contractual fee compliance."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed management fee entries. Reversals indicate fee disputes or calculation errors."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_owner_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Owner distribution metrics covering NOI, GOP, FFE reserve contributions, debt service, and distribution amounts. Core to ownership reporting and HMA performance test compliance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`owner_distribution`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the owner distribution (e.g., Calculated, Approved, Paid, Disputed)."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the distribution for period-over-period owner return analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the distribution for annual ownership return reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Distribution currency for multi-currency ownership reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the distribution is under dispute. Disputes delay owner payments and signal HMA conflicts."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Indicates SOX-controlled distribution records requiring enhanced audit documentation."
    - name: "period_start_date_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Distribution period start date truncated to month for trend analysis."
  measures:
    - name: "total_distribution_count"
      expr: COUNT(1)
      comment: "Total number of owner distribution records. Baseline distribution activity metric."
    - name: "total_distribution_amount"
      expr: SUM(CAST(distribution_amount AS DOUBLE))
      comment: "Total cash distributed to property owners. Primary ownership return KPI."
    - name: "total_gop_amount"
      expr: SUM(CAST(gop_amount AS DOUBLE))
      comment: "Total Gross Operating Profit across distribution periods. Core hotel profitability metric for owners."
    - name: "total_noi_amount"
      expr: SUM(CAST(noi_amount AS DOUBLE))
      comment: "Total Net Operating Income. Key ownership return and asset valuation metric."
    - name: "total_gross_revenue_amount"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across distribution periods. Top-line revenue metric for ownership reporting."
    - name: "total_ffe_reserve_contribution"
      expr: SUM(CAST(ffe_reserve_contribution_amount AS DOUBLE))
      comment: "Total FF&E reserve contributions. Tracks capital reserve funding for asset maintenance compliance."
    - name: "total_debt_service_amount"
      expr: SUM(CAST(debt_service_amount AS DOUBLE))
      comment: "Total debt service payments. Critical for debt coverage ratio and lender covenant compliance."
    - name: "total_base_management_fee"
      expr: SUM(CAST(base_management_fee_amount AS DOUBLE))
      comment: "Total base management fees deducted from owner distributions. Validates HMA fee compliance."
    - name: "total_incentive_management_fee"
      expr: SUM(CAST(incentive_management_fee_amount AS DOUBLE))
      comment: "Total incentive management fees paid. Measures operator performance-based compensation."
    - name: "gop_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gop_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "GOP as a percentage of gross revenue. Primary hotel operating efficiency KPI for ownership."
    - name: "noi_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(noi_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "NOI as a percentage of gross revenue. Measures net return to ownership after all operating costs."
    - name: "ffe_reserve_balance_avg"
      expr: AVG(CAST(ffe_reserve_balance AS DOUBLE))
      comment: "Average FF&E reserve balance. Tracks adequacy of capital reserves for property reinvestment."
    - name: "disputed_distribution_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed owner distributions. Disputes indicate HMA compliance or calculation conflicts."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering asset book values, depreciation, impairment, and disposal activity. Supports CapEx management, asset lifecycle decisions, and balance sheet accuracy."
  source: "`vibe_travel_hospitality_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the asset (e.g., Active, Disposed, Impaired, Under Construction)."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (e.g., FF&E, Building, Equipment, Technology) for portfolio analysis."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for depreciation schedule and financial reporting classification."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., Straight-Line, Declining Balance) for accounting policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Asset currency for multi-currency fixed asset reporting."
    - name: "ffe_reserve_eligible"
      expr: ffe_reserve_eligible
      comment: "Indicates whether the asset qualifies for FF&E reserve funding. Drives capital reserve planning."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flags assets with impairment indicators. Impaired assets require write-down and disclosure."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Asset acquisition year for vintage analysis and depreciation schedule management."
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets on the books. Baseline asset portfolio size metric."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of all fixed assets. Gross asset base for balance sheet reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets. Measures asset aging and book value erosion."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Primary balance sheet asset value metric."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized. Significant impairments impact profitability and asset valuations."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Measures asset monetization and capital recycling."
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain or loss on asset disposals. Impacts P&L and measures asset disposal efficiency."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset. Benchmarks typical asset value for portfolio management."
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost. Measures overall asset age and replacement urgency."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets with impairment indicators. Elevated counts signal asset quality deterioration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request metrics covering approval rates, requested vs. approved amounts, ROI, and project pipeline. Supports CapEx governance, PIP compliance, and investment prioritization."
  source: "`vibe_travel_hospitality_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the CapEx request (e.g., Submitted, Approved, Rejected, In Progress)."
    - name: "request_type"
      expr: request_type
      comment: "Type of CapEx request (e.g., PIP, Maintenance, Technology, Expansion) for portfolio analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category targeted by the CapEx request for spend category analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request (e.g., Critical, High, Medium, Low) for investment prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the CapEx request for multi-currency capital planning."
    - name: "is_multi_year_project"
      expr: is_multi_year_project
      comment: "Indicates multi-year CapEx projects requiring multi-period budget planning."
    - name: "sox_control_required"
      expr: sox_control_required
      comment: "Flags CapEx requests requiring SOX controls for compliance tracking."
    - name: "request_date_year"
      expr: DATE_TRUNC('year', request_date)
      comment: "CapEx request year for annual capital planning pipeline analysis."
  measures:
    - name: "total_request_count"
      expr: COUNT(1)
      comment: "Total number of CapEx requests. Baseline capital investment pipeline volume metric."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total capital expenditure requested. Measures total investment demand in the pipeline."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total capital expenditure approved. Measures committed capital investment."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CapEx requests approved. Measures capital allocation efficiency and governance rigor."
    - name: "approval_amount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(requested_amount AS DOUBLE)), 0), 2)
      comment: "Approved amount as a percentage of requested amount. Measures capital budget constraint severity."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average projected ROI across CapEx requests. Key investment quality and prioritization metric."
    - name: "avg_requested_amount"
      expr: AVG(CAST(requested_amount AS DOUBLE))
      comment: "Average CapEx request size. Benchmarks typical investment scale for portfolio management."
    - name: "multi_year_project_count"
      expr: COUNT(CASE WHEN is_multi_year_project = TRUE THEN 1 END)
      comment: "Number of multi-year CapEx projects. Drives multi-period capital budget planning requirements."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics covering tax liabilities, filing status, exemptions, and reversal activity. Supports tax compliance, regulatory filing, and audit readiness."
  source: "`vibe_travel_hospitality_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Tax filing status (e.g., Filed, Pending, Overdue) for compliance monitoring."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction for multi-jurisdiction tax liability analysis and regulatory reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax posting for period tax liability reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax posting for annual tax compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Tax posting currency for multi-currency tax reporting."
    - name: "exemption_indicator"
      expr: exemption_indicator
      comment: "Indicates tax-exempt transactions. Tracks exemption utilization and compliance."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed tax postings. Reversals may indicate tax calculation corrections."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document generating the tax posting (e.g., AR Invoice, AP Invoice, POS)."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Tax posting date truncated to month for period tax liability trend analysis."
  measures:
    - name: "total_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings. Baseline tax transaction volume metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted. Primary tax liability metric for compliance and remittance."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total taxable base amount. Used to verify effective tax rate calculations."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average effective tax rate across postings. Benchmarks tax burden and identifies rate anomalies."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(tax_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as total tax divided by total taxable base. Validates tax rate application accuracy."
    - name: "exempt_posting_count"
      expr: COUNT(CASE WHEN exemption_indicator = TRUE THEN 1 END)
      comment: "Number of tax-exempt postings. Tracks exemption volume for compliance audit purposes."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed tax postings. Reversals indicate tax calculation corrections requiring review."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue tax filings. Overdue filings create regulatory penalty risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_allocation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation run metrics covering allocated amounts, variance analysis, approval status, and automation rates. Supports management accounting, cost center performance, and period-close efficiency."
  source: "`vibe_travel_hospitality_v1`.`finance`.`allocation_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the allocation run (e.g., Pending, Completed, Failed, Reversed)."
    - name: "run_type"
      expr: run_type
      comment: "Type of allocation run (e.g., Actual, Budget, Forecast) for management accounting analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation methodology applied (e.g., Headcount, Revenue, Square Footage) for cost driver analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allocation run. Unapproved runs block period-close."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation run for period cost allocation analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation run for annual cost allocation reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation run for multi-currency cost reporting."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the allocation was automated. Automation rate measures process efficiency."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the allocation run was reversed. Reversals indicate allocation corrections."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('month', gl_posting_date)
      comment: "GL posting date truncated to month for period allocation timing analysis."
  measures:
    - name: "total_run_count"
      expr: COUNT(1)
      comment: "Total number of allocation runs. Baseline allocation activity volume metric."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated across all runs. Measures total cost redistribution activity."
    - name: "total_source_amount"
      expr: SUM(CAST(source_amount AS DOUBLE))
      comment: "Total source amount subject to allocation. Used to verify allocation completeness."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between source and allocated amounts. Significant variances indicate allocation rule gaps."
    - name: "allocation_completeness_pct"
      expr: ROUND(100.0 * SUM(CAST(allocated_amount AS DOUBLE)) / NULLIF(SUM(CAST(source_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of source amount successfully allocated. Measures allocation rule coverage and completeness."
    - name: "automated_run_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocation runs that are automated. Measures process automation maturity."
    - name: "reversal_run_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed allocation runs. Reversals indicate allocation errors requiring correction."
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average amount allocated per run. Benchmarks typical allocation size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics covering disbursement success rates, failed payments, processing fees, and reconciliation status. Supports treasury operations and vendor payment reliability."
  source: "`vibe_travel_hospitality_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g., Scheduled, Executing, Completed, Failed)."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g., Regular, Emergency, Reversal) for payment operations analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment run currency for multi-currency disbursement reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment run. Unreconciled runs indicate cash management gaps."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the payment run required approval. Tracks payment authorization controls."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Scheduled payment date truncated to month for cash flow planning."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('month', gl_posting_date)
      comment: "GL posting date truncated to month for period cash disbursement reporting."
  measures:
    - name: "total_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs. Baseline payment operations volume metric."
    - name: "total_disbursement_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount disbursed across all payment runs. Primary cash outflow metric."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursement after fees. Actual cash leaving the organization."
    - name: "total_successful_amount"
      expr: SUM(CAST(successful_amount AS DOUBLE))
      comment: "Total amount successfully disbursed. Measures payment execution effectiveness."
    - name: "total_failed_amount"
      expr: SUM(CAST(failed_amount AS DOUBLE))
      comment: "Total amount in failed payments. Failed payments create vendor relationship and cash management risks."
    - name: "total_processing_fee_amount"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total payment processing fees. Tracks cost of payment execution infrastructure."
    - name: "payment_success_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(successful_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total payment amount successfully disbursed. Key payment reliability KPI."
    - name: "avg_total_payment_count"
      expr: AVG(CAST(total_payment_count AS DOUBLE))
      comment: "Average number of payments per run. Benchmarks payment run scale for capacity planning."
    - name: "avg_failed_payment_count"
      expr: AVG(CAST(failed_payment_count AS DOUBLE))
      comment: "Average number of failed payments per run. Elevated failures indicate payment infrastructure issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_hma_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hotel Management Agreement contract metrics covering fee structures, contract terms, performance test flags, and renewal pipeline. Supports owner-operator relationship governance and HMA compliance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`hma_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the HMA contract (e.g., Active, Expired, Terminated, Under Negotiation)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of management agreement (e.g., Full Service, Limited Service, Franchise) for portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency HMA portfolio reporting."
    - name: "performance_test_flag"
      expr: performance_test_flag
      comment: "Indicates whether the contract includes a performance test clause. Performance test failures can trigger termination."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates whether the contract has renewal options. Drives contract pipeline and term planning."
    - name: "effective_date_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Contract effective year for portfolio vintage analysis."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('year', expiration_date)
      comment: "Contract expiration year for renewal pipeline management."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of HMA contracts. Baseline managed portfolio size metric."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of active HMA contracts. Measures current managed portfolio scope."
    - name: "avg_base_fee_percentage"
      expr: AVG(CAST(base_fee_percentage AS DOUBLE))
      comment: "Average base management fee percentage across contracts. Benchmarks fee competitiveness."
    - name: "avg_incentive_fee_percentage"
      expr: AVG(CAST(incentive_fee_percentage AS DOUBLE))
      comment: "Average incentive management fee percentage. Measures performance-based fee structure prevalence."
    - name: "avg_ffe_reserve_percentage"
      expr: AVG(CAST(ffe_reserve_percentage AS DOUBLE))
      comment: "Average FF&E reserve percentage across contracts. Benchmarks capital reserve requirements."
    - name: "total_minimum_annual_fee"
      expr: SUM(CAST(minimum_annual_fee_amount AS DOUBLE))
      comment: "Total minimum annual management fees across all contracts. Measures guaranteed fee revenue floor."
    - name: "performance_test_contract_count"
      expr: COUNT(CASE WHEN performance_test_flag = TRUE THEN 1 END)
      comment: "Number of contracts with performance test clauses. Tracks termination risk exposure in the portfolio."
    - name: "renewal_option_contract_count"
      expr: COUNT(CASE WHEN renewal_option_flag = TRUE THEN 1 END)
      comment: "Number of contracts with renewal options. Measures long-term contract pipeline stability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account metrics tracking cash positions, account balances, reconciliation status, and treasury management performance"
  source: "`vibe_travel_hospitality_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (e.g., active, closed, dormant)"
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g., checking, savings, money market, payroll)"
    - name: "account_purpose"
      expr: account_purpose
      comment: "Business purpose of the account (e.g., operating, payroll, reserve, escrow)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status of the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the account is denominated"
    - name: "is_primary_account"
      expr: is_primary_account
      comment: "Indicates whether this is the primary operating account"
    - name: "is_zero_balance_account"
      expr: is_zero_balance_account
      comment: "Indicates whether this is a zero-balance account (ZBA)"
    - name: "interest_bearing"
      expr: interest_bearing
      comment: "Indicates whether the account earns interest"
    - name: "electronic_banking_enabled"
      expr: electronic_banking_enabled
      comment: "Indicates whether electronic banking is enabled"
    - name: "positive_pay_enabled"
      expr: positive_pay_enabled
      comment: "Indicates whether positive pay fraud prevention is enabled"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all bank accounts"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available balance across all bank accounts"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance when accounts were established"
    - name: "total_last_statement_balance"
      expr: SUM(CAST(last_statement_balance AS DOUBLE))
      comment: "Total balance from most recent bank statements"
    - name: "total_minimum_balance_required"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Total minimum balance requirements across all accounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per bank account"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across interest-bearing accounts"
    - name: "active_account_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active bank accounts"
    - name: "reconciled_account_count"
      expr: SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END)
      comment: "Count of bank accounts that are fully reconciled"
    - name: "interest_bearing_account_count"
      expr: SUM(CASE WHEN interest_bearing = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts that earn interest"
    - name: "positive_pay_enabled_count"
      expr: SUM(CASE WHEN positive_pay_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with positive pay fraud prevention enabled"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line item metrics tracking planned spend, budget utilization, and variance analysis for financial planning and control"
  source: "`vibe_travel_hospitality_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital, project)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget line (e.g., labor, supplies, utilities, marketing)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the budget"
    - name: "department_code"
      expr: department_code
      comment: "Department code responsible for the budget line"
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget (e.g., original, revised, forecast)"
    - name: "locked_flag"
      expr: locked_flag
      comment: "Indicates whether the budget line is locked from further changes"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget across periods or entities"
  measures:
    - name: "total_budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all line items"
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend for comparison"
    - name: "yoy_budget_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(planned_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(prior_year_actual_amount AS DOUBLE)), 0), 2)
      comment: "Year-over-year budget growth percentage compared to prior year actuals"
    - name: "avg_planned_amount"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned amount per budget line"
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage for budget monitoring"
    - name: "approved_budget_line_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of budget lines that have been approved"
    - name: "locked_budget_line_count"
      expr: SUM(CASE WHEN locked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of budget lines locked from further changes"
$$;