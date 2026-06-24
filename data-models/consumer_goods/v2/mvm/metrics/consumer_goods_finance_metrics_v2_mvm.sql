-- Metric views for domain: finance | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics covering payable balances, payment performance, discount capture, and liability aging. Supports CFO-level cash management, working capital optimization, and vendor payment compliance reporting."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the AP invoice, enabling entity-level payables analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g., standard, credit memo) for categorizing payable obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency payables reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Vendor payment terms (e.g., Net 30, 2/10 Net 30) driving discount and due-date analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period payables trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly payables close and accrual reporting."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status of the invoice (matched, unmatched, exception) for procurement compliance."
    - name: "payment_block_flag"
      expr: payment_block_flag
      comment: "Indicates whether the invoice is blocked for payment, used to identify held payables."
    - name: "three_way_match_flag"
      expr: three_way_match_flag
      comment: "Indicates whether the invoice passed three-way match (PO, GR, invoice) for compliance tracking."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly payables volume and aging trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of invoice due date for cash outflow forecasting and liquidity planning."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date for period-accurate payables accrual reporting."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of AP invoices. Core payables liability measure used in working capital and cash flow forecasting."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments. Used for accurate cash outflow planning."
    - name: "total_outstanding_payables"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid outstanding AP balance. Critical CFO metric for current liability and liquidity management."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Measures actual cash disbursements to vendors."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value available on AP invoices. Baseline for early payment discount capture analysis."
    - name: "total_early_payment_discount_taken"
      expr: SUM(CAST(early_payment_discount_taken AS DOUBLE))
      comment: "Total early payment discounts actually captured. Measures treasury efficiency in leveraging vendor discount terms."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices. Required for tax liability reporting and VAT reconciliation."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for regulatory tax compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Used as denominator for per-invoice averages and processing volume KPIs."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently blocked for payment. Elevated counts signal process exceptions requiring resolution."
    - name: "three_way_matched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_flag = TRUE THEN 1 END)
      comment: "Number of invoices that passed three-way match. Measures procurement compliance and invoice quality."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Tracks vendor invoice size trends and detects anomalous invoice patterns."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(early_payment_discount_taken AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available early payment discounts actually captured. Key treasury efficiency KPI — low rates indicate missed savings opportunities."
    - name: "outstanding_payables_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross invoice value still outstanding. Measures AP clearance efficiency and liability concentration."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics covering disbursement volumes, discount utilization, payment timing, and cash outflow. Supports treasury, cash management, and vendor relationship KPIs."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level payment disbursement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash outflow reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency for FX-adjusted payment reporting."
    - name: "remittance_advice_sent"
      expr: remittance_advice_sent
      comment: "Indicates whether remittance advice was sent to the vendor, supporting vendor communication compliance."
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Boolean flag for remittance advice transmission, used to measure vendor notification compliance rate."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment execution for monthly cash disbursement trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting for period-accurate cash outflow reporting."
    - name: "clearing_date_month"
      expr: DATE_TRUNC('MONTH', clearing_date)
      comment: "Month of payment clearing for reconciliation and bank statement matching."
    - name: "approved_by"
      expr: approved_by
      comment: "Approver of the payment for authorization audit and segregation-of-duties compliance."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed to vendors. Primary cash outflow measure for treasury and liquidity management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts and deductions. Reflects actual cash leaving the organization."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local functional currency. Used for FX-neutral cash flow reporting."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early payment discounts captured on payments. Measures realized savings from prompt payment programs."
    - name: "total_discount_available_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value available at time of payment. Baseline for discount capture efficiency calculation."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Used for payment processing volume and throughput analysis."
    - name: "remittance_sent_count"
      expr: COUNT(CASE WHEN remittance_advice_sent_flag = TRUE THEN 1 END)
      comment: "Number of payments where remittance advice was sent. Measures vendor communication compliance."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment disbursement amount. Tracks payment size trends and detects outlier transactions."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_taken_amount AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available payment discounts actually captured. Key treasury efficiency KPI — directly impacts cost of goods and vendor economics."
    - name: "remittance_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remittance_advice_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments with remittance advice sent. Measures vendor communication process compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue recognition, collections performance, DSO drivers, dispute management, and write-off risk. Core domain for CFO, Revenue, and Collections leadership."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level receivables analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (standard, credit memo, debit memo) for receivables categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency receivables reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Customer payment terms driving DSO and collections strategy."
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "Aging bucket classification (e.g., 0-30, 31-60, 61-90, 90+ days) for receivables aging analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period AR trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR close and revenue recognition reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization associated with the invoice for channel and region-level AR analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel (e.g., direct, retail, e-commerce) for channel-level collections performance."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute. Used to segment disputed vs. clean receivables."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the invoice has been written off as uncollectible. Drives bad debt analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for monthly billing volume and revenue trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of invoice due date for cash inflow forecasting."
    - name: "billing_date_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month of billing for revenue recognition period alignment."
  measures:
    - name: "total_gross_ar_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed AR amount. Primary revenue and receivables volume measure for executive reporting."
    - name: "total_net_ar_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount after discounts and adjustments. Reflects collectible revenue base."
    - name: "total_outstanding_receivables"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid outstanding AR balance. Critical CFO metric for current asset and liquidity management."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance including all open items. Used for balance sheet AR reporting."
    - name: "total_collected_amount"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash collected against AR invoices. Measures collections effectiveness and cash conversion."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid by customers. Tracks cash inflow realization against billed revenue."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total AR written off as uncollectible. Key bad debt and credit risk KPI for CFO and credit management."
    - name: "total_dispute_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount on disputed invoices. Measures revenue leakage from customer deductions and chargebacks."
    - name: "total_trade_discount_amount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discount granted to customers. Measures net revenue impact of promotional and contractual discounts."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices. Required for tax liability and VAT reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices. Used as denominator for per-invoice averages and billing volume KPIs."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute. Elevated counts signal customer satisfaction or billing accuracy issues."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Number of invoices written off. Tracks bad debt incidence rate for credit risk management."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross billed amount collected. Primary collections effectiveness KPI — directly measures cash conversion efficiency."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross AR written off as bad debt. Key credit risk KPI — rising rates trigger credit policy review."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute. Measures billing quality and customer satisfaction — high rates indicate systemic billing or fulfillment issues."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Tracks revenue per transaction trends and customer order size patterns."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment receipt metrics covering cash application, deduction management, payment channel performance, and collections quality. Supports treasury, collections, and trade finance leadership."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level cash receipt analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash receipt reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency for FX-neutral cash receipt reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period cash receipt trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash application and collections close reporting."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions (e.g., pricing dispute, shortage, promotion) for deduction root-cause analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed. Used to identify payment quality and processing exceptions."
    - name: "overpayment_flag"
      expr: overpayment_flag
      comment: "Indicates customer overpayment. Used to track unapplied cash and customer liability management."
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Indicates partial payment received. Used to identify underpayment patterns and collections follow-up needs."
    - name: "short_payment_flag"
      expr: short_payment_flag
      comment: "Indicates short payment (paid less than invoiced). Key deduction and dispute management indicator."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for monthly cash inflow trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting for period-accurate cash receipt reporting."
  measures:
    - name: "total_payment_received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from customers. Primary cash inflow measure for treasury and revenue management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to open AR invoices. Measures cash application efficiency and unapplied cash reduction."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local functional currency. Used for FX-neutral cash inflow reporting."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deduction amount. Measures revenue leakage from chargebacks, shortages, and pricing disputes."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Measures cost of discount programs and customer payment behavior."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payment receipts. Used for cash application volume and processing throughput analysis."
    - name: "short_payment_count"
      expr: COUNT(CASE WHEN short_payment_flag = TRUE THEN 1 END)
      comment: "Number of short payments received. Elevated counts signal collections issues or systematic customer deduction behavior."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed payments. Measures payment processing quality and exception rate."
    - name: "overpayment_count"
      expr: COUNT(CASE WHEN overpayment_flag = TRUE THEN 1 END)
      comment: "Number of customer overpayments. Tracks unapplied cash liability and customer refund obligations."
    - name: "avg_payment_received"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average cash receipt per payment transaction. Tracks customer payment size trends."
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Deduction amount as a percentage of total payments received. Key trade finance KPI — high rates indicate revenue leakage from customer chargebacks."
    - name: "short_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN short_payment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that are short payments. Measures collections quality and customer payment compliance."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash successfully applied to open invoices. Measures cash application efficiency — low rates indicate unapplied cash backlog."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, reversal rates, intercompany activity, and financial close quality. Supports Controller, Audit, and SOX compliance leadership."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level journal entry analysis."
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g., SA, KR, DR) for categorizing GL postings by business process."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry for multi-currency GL analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period journal entry volume and financial close analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close quality and posting volume reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal entry for workflow compliance and authorization monitoring."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (posted, parked, held) for financial close completeness tracking."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the journal entry is a reversal. Used to measure reversal rate and close quality."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Indicates intercompany journal entries for elimination and consolidation analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Indicates SOX-controlled journal entries for audit and compliance monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting for monthly close volume and timing analysis."
    - name: "document_date_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of document date for accrual and period-accuracy analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entries. Measures gross GL activity volume for financial close monitoring."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entries. Paired with total debits for balance verification."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Measures financial close workload and GL activity volume."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal rates indicate close quality issues or error-prone processes."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_flag = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used for consolidation elimination completeness and intercompany reconciliation."
    - name: "sox_controlled_entry_count"
      expr: COUNT(CASE WHEN sox_control_flag = TRUE THEN 1 END)
      comment: "Number of SOX-controlled journal entries. Measures SOX compliance scope and audit trail completeness."
    - name: "avg_debit_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry. Tracks transaction size trends and detects anomalous large postings."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. Key financial close quality KPI — high rates signal systemic posting errors or accrual management issues."
    - name: "intercompany_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN intercompany_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are intercompany. Used to assess consolidation complexity and elimination workload."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL journal entry line-item metrics covering transaction-level debit/credit activity, tax postings, and cost object analysis. Supports detailed financial analysis, cost allocation review, and audit trail validation."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level GL line item analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency GL line analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency for FX-neutral GL reporting."
    - name: "cost_object_type"
      expr: cost_object_type
      comment: "Type of cost object (cost center, order, WBS) for cost allocation and controlling analysis."
    - name: "posting_key"
      expr: posting_key
      comment: "GL posting key indicating debit/credit and account type for transaction classification."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for manufacturing and supply chain cost analysis at the GL line level."
    - name: "segment_code"
      expr: segment_code
      comment: "Segment code for segment reporting and IFRS 8 / ASC 280 disclosure requirements."
    - name: "open_item_flag"
      expr: open_item_flag
      comment: "Indicates whether the GL line item is open (uncleared). Used for open item reconciliation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the line item is part of a reversal entry. Used for close quality analysis."
    - name: "baseline_date_month"
      expr: DATE_TRUNC('MONTH', baseline_date)
      comment: "Month of baseline date for payment terms and aging analysis at the line level."
    - name: "value_date_month"
      expr: DATE_TRUNC('MONTH', value_date)
      comment: "Month of value date for cash flow and bank reconciliation analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total GL line amount in transaction currency. Core measure for detailed financial activity analysis."
    - name: "total_company_code_currency_amount"
      expr: SUM(CAST(amount_company_code_currency AS DOUBLE))
      comment: "Total GL line amount in company code currency. Used for entity-level financial reporting in functional currency."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total GL line amount in group/consolidation currency. Required for consolidated financial statement preparation."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total GL line amount in local currency. Used for statutory and local GAAP reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at the GL line level. Required for tax provision and VAT return preparation."
    - name: "line_item_count"
      expr: COUNT(1)
      comment: "Total number of GL line items. Measures posting volume and financial close workload."
    - name: "open_item_count"
      expr: COUNT(CASE WHEN open_item_flag = TRUE THEN 1 END)
      comment: "Number of open (uncleared) GL line items. Elevated counts indicate reconciliation backlog and close risk."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal GL line items. Used to measure error correction volume and close quality."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Average GL line transaction amount. Used to detect anomalous large postings and benchmark transaction sizes."
    - name: "open_item_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN open_item_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GL line items that remain open. High rates signal reconciliation issues and financial close risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_cogs_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of Goods Sold allocation metrics covering manufacturing cost components, variance analysis, and cost per unit. Supports CFO, Supply Chain Finance, and Manufacturing leadership for margin and cost management."
  source: "`vibe_consumer_goods_v1`.`finance`.`cogs_allocation`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the COGS allocation for multi-currency cost reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period COGS trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly COGS close and cost accrual reporting."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for COGS allocation (e.g., machine hours, labor hours, units produced) for cost methodology analysis."
    - name: "allocation_period"
      expr: allocation_period
      comment: "Period of the COGS allocation for time-series cost analysis."
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance (e.g., price, quantity, efficiency) for root-cause cost analysis."
    - name: "variance_type"
      expr: variance_type
      comment: "Type of cost variance for detailed manufacturing variance reporting."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the cost allocation for financial close completeness tracking."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class of the material for inventory and COGS categorization."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of COGS allocation for monthly cost trend analysis."
  measures:
    - name: "total_cogs_amount"
      expr: SUM(CAST(total_cogs_amount AS DOUBLE))
      comment: "Total Cost of Goods Sold allocated. Primary cost measure for gross margin calculation and profitability analysis."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost component of COGS. Measures raw material spend impact on product cost."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total direct labor cost component of COGS. Measures workforce cost contribution to product cost."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost_amount AS DOUBLE))
      comment: "Total overhead cost component of COGS. Measures indirect manufacturing cost absorption."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost. Used for labor efficiency and workforce productivity analysis."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead cost. Measures capacity cost absorption and fixed cost leverage."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead cost. Measures volume-driven overhead and production efficiency."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost. Key input cost measure for procurement and supply chain cost management."
    - name: "total_packaging_cost"
      expr: SUM(CAST(packaging_cost AS DOUBLE))
      comment: "Total packaging cost. Measures packaging spend as a component of product cost in consumer goods."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight cost. Measures logistics cost impact on COGS and landed cost."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. standard). Key manufacturing finance KPI — large variances trigger cost investigation and standard cost review."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated via the COGS allocation process. Used to verify allocation completeness."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity produced in the allocation period. Used as denominator for unit cost calculations."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per unit produced. Core product profitability KPI — tracks manufacturing efficiency and cost trends."
    - name: "material_cost_pct_of_cogs"
      expr: ROUND(100.0 * SUM(CAST(material_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Material cost as a percentage of total COGS. Measures raw material intensity and input cost structure — critical for margin management in consumer goods."
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of total COGS. Measures manufacturing cost control effectiveness — high rates trigger standard cost review and operational investigation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard cost metrics covering cost estimate composition, variance from previous standards, and cost structure analysis by component. Supports Supply Chain Finance, Product Costing, and Manufacturing leadership."
  source: "`vibe_consumer_goods_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the standard cost estimate for multi-currency cost reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the standard cost for annual cost planning and comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the standard cost for period-level cost analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant for plant-level standard cost comparison and benchmarking."
    - name: "costing_status"
      expr: costing_status
      comment: "Status of the cost estimate (released, marked, saved) for cost planning completeness tracking."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the standard cost for financial close and cost roll-up readiness."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the standard cost estimate for governance and authorization compliance."
    - name: "costing_variant"
      expr: costing_variant
      comment: "Costing variant used (e.g., standard, modified standard) for cost methodology analysis."
    - name: "released_flag"
      expr: released_flag
      comment: "Indicates whether the standard cost has been released for use in valuation."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month from which the standard cost is valid for cost period analysis."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of standard cost release for cost planning cycle analysis."
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard cost across all cost estimates. Primary cost baseline measure for inventory valuation and margin planning."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of standard cost. Measures raw material cost baseline for procurement benchmarking."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of standard cost. Measures workforce cost baseline for manufacturing planning."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component of standard cost. Measures indirect cost absorption baseline."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor standard cost. Used for labor rate and efficiency variance baseline analysis."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead standard cost. Measures capacity cost baseline for absorption analysis."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead standard cost. Measures volume-driven cost baseline."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material standard cost. Key input cost baseline for procurement and supply chain planning."
    - name: "total_packaging_material_cost"
      expr: SUM(CAST(packaging_material_cost AS DOUBLE))
      comment: "Total packaging material standard cost. Measures packaging cost baseline — significant cost driver in consumer goods."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight standard cost. Measures logistics cost baseline for landed cost analysis."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total variance between current and previous standard cost. Measures cost inflation/deflation trends for pricing and margin planning."
    - name: "cost_estimate_count"
      expr: COUNT(1)
      comment: "Total number of standard cost estimates. Used to measure cost planning coverage and completeness."
    - name: "released_cost_estimate_count"
      expr: COUNT(CASE WHEN released_flag = TRUE THEN 1 END)
      comment: "Number of released standard cost estimates. Measures cost planning readiness for production and inventory valuation."
    - name: "avg_standard_cost_per_estimate"
      expr: AVG(CAST(total_standard_cost AS DOUBLE))
      comment: "Average standard cost per cost estimate. Tracks product cost level trends across the portfolio."
    - name: "material_cost_pct_of_standard"
      expr: ROUND(100.0 * SUM(CAST(material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_standard_cost AS DOUBLE)), 0), 2)
      comment: "Material cost as a percentage of total standard cost. Measures raw material intensity in the cost structure — critical for consumer goods margin management."
    - name: "cost_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN released_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of standard cost estimates that have been released. Measures cost planning completeness and readiness for production."
    - name: "avg_cost_variance_pct"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage vs. previous standard. Measures year-over-year cost inflation/deflation — drives pricing decisions and margin forecasting."
$$;