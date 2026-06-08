-- Metric views for domain: finance | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable performance metrics for the port finance domain. Tracks outstanding balances, overdue exposure, write-off risk, and collection efficiency across shipping lines, vessels, and profit centres. Core KPI surface for credit risk management and cash flow forecasting."
  source: "`shipping_ports_ecm`.`finance`.`receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the receivable posting, used for year-over-year AR trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the receivable, enabling intra-year AR aging and collection cycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the receivable, supporting multi-currency AR exposure reporting."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the receivable (e.g. 0-30, 31-60, 61-90, 90+ days), the primary lens for credit risk management."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Current clearing/settlement status of the receivable (open, cleared, partially cleared), used to segment outstanding vs. settled balances."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the customer, used to benchmark actual collection against contractual terms."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the receivable is under dispute, enabling isolation of disputed AR from clean outstanding balances."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the receivable has been written off, used to track bad debt exposure."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area (e.g. container terminal, bulk terminal) associated with the receivable for segment-level AR analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of the receivable posting date, used for monthly AR flow and aging trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the receivable is due, used to project upcoming cash inflows and identify overdue clusters."
  measures:
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total open receivable balance outstanding. Primary AR exposure KPI used by CFO and treasury to manage working capital and liquidity."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount billed. Baseline for measuring collection efficiency against total billed revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of receivables. Required for VAT/GST compliance reporting and tax liability reconciliation."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total receivable amount in local functional currency. Used for statutory reporting and local currency cash flow management."
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total early-payment discounts granted on receivables. Tracks the cost of accelerating cash collection through discount incentives."
    - name: "disputed_receivable_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN receivable_id END)
      comment: "Number of receivables currently under dispute. High counts signal customer satisfaction or billing accuracy issues requiring intervention."
    - name: "disputed_outstanding_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding balance tied to disputed receivables. Quantifies the financial exposure locked in disputes, a key credit risk KPI."
    - name: "written_off_amount"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount written off as bad debt. Directly impacts P&L and is a key indicator of credit policy effectiveness."
    - name: "overdue_receivable_count"
      expr: COUNT(CASE WHEN clearing_status != 'CLEARED' AND due_date < CURRENT_DATE() THEN receivable_id END)
      comment: "Number of receivables past their due date and not yet cleared. Drives collections prioritisation and dunning actions."
    - name: "overdue_outstanding_amount"
      expr: SUM(CASE WHEN clearing_status != 'CLEARED' AND due_date < CURRENT_DATE() THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding balance on overdue receivables. Core KPI for collections teams and CFO liquidity risk reporting."
    - name: "total_receivable_count"
      expr: COUNT(receivable_id)
      comment: "Total number of receivable records. Baseline volume metric for AR workload and portfolio size assessment."
    - name: "avg_outstanding_per_receivable"
      expr: AVG(CAST(outstanding_amount AS DOUBLE))
      comment: "Average outstanding balance per receivable record. Indicates average invoice size and helps detect anomalous large exposures."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics for the port finance domain. Tracks payable volumes, outstanding liabilities, payment performance, discount capture, and tax exposure across vendors, expense categories, and fiscal periods. Core KPI surface for AP efficiency, cash management, and vendor payment compliance."
  source: "`shipping_ports_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AP invoice, used for year-over-year payables trend and budget variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the AP invoice, enabling monthly payables flow and cash outflow forecasting."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (e.g. open, paid, blocked, cancelled), the primary lens for AP workload and liability management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g. standard, credit memo, recurring), used to segment payables by nature for spend analysis."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the invoice (e.g. maintenance, fuel, labour), enabling cost category analysis and budget tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the AP invoice, supporting multi-currency payables exposure and FX risk reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or designated for the invoice (e.g. bank transfer, cheque), used for payment channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms on the invoice, used to benchmark actual payment timing against agreed terms."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the invoice is a recurring payable, enabling separation of fixed recurring costs from variable spend."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of the invoice date, used for monthly AP volume and spend trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the invoice is due, used for cash outflow forecasting and payment scheduling."
    - name: "payment_block"
      expr: payment_block
      comment: "Payment block reason on the invoice, used to identify and resolve blocked invoices that delay vendor payments."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount including tax. Primary payables liability KPI used by CFO and treasury for cash outflow planning."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount excluding tax. Used for expense reporting and budget variance analysis."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid AP balance outstanding. Core KPI for working capital management and vendor liability exposure."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Used to track payment throughput and cash disbursement volumes."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices. Required for input tax credit claims and VAT/GST compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured on AP invoices. Measures the financial benefit of prompt payment and discount optimisation."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from AP invoices. Required for tax authority remittance and vendor withholding compliance."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block IS NOT NULL AND payment_block != '' THEN ap_invoice_id END)
      comment: "Number of AP invoices with a payment block. High counts indicate process bottlenecks delaying vendor payments and risking supplier relationships."
    - name: "blocked_invoice_amount"
      expr: SUM(CASE WHEN payment_block IS NOT NULL AND payment_block != '' THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding amount on blocked AP invoices. Quantifies the financial exposure held up in blocked invoices, a key AP efficiency KPI."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN invoice_status != 'PAID' AND due_date < CURRENT_DATE() THEN ap_invoice_id END)
      comment: "Number of AP invoices past due date and unpaid. Drives urgency in payment processing and vendor relationship management."
    - name: "total_invoice_count"
      expr: COUNT(ap_invoice_id)
      comment: "Total number of AP invoices. Baseline volume metric for AP workload, processing capacity, and vendor activity."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per AP invoice. Indicates average transaction size and helps detect anomalous large payables."
    - name: "recurring_invoice_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN ap_invoice_id END)
      comment: "Number of recurring AP invoices. Quantifies fixed cost commitments and supports recurring cost forecasting."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics for the port finance domain. Tracks payment volumes, disbursement amounts, FX costs, bank charges, discount capture, and payment reversal rates. Core KPI surface for treasury operations, payment efficiency, and cash management."
  source: "`shipping_ports_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment, used for year-over-year cash disbursement trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the payment, enabling monthly cash outflow and payment run analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. posted, cleared, reversed), the primary lens for payment execution monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. bank transfer, cheque, EFT), used for payment channel efficiency and cost analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the payment was made, used for FX exposure and multi-currency cash management reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency of the payment entity, used for statutory cash flow reporting."
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of expenditure covered by the payment (e.g. capex, opex, maintenance), enabling spend category analysis."
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority level assigned to the payment run, used to analyse payment scheduling and urgency distribution."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed, used to track payment error rates and reversal exposure."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of the payment date, used for monthly cash disbursement trend and payment run frequency analysis."
    - name: "house_bank_code"
      expr: house_bank_code
      comment: "Bank used to execute the payment, enabling bank-level payment volume and charge analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary cash outflow KPI used by treasury for liquidity management and cash position reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and withholding tax. Reflects actual cash leaving the organisation."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local functional currency. Used for statutory cash flow reporting and local currency liquidity management."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments. Tracks transaction cost of payment execution; high values trigger bank fee renegotiation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured at payment execution. Measures treasury's success in optimising discount capture."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted at payment. Required for tax authority remittance reconciliation and compliance reporting."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN ap_payment_id END)
      comment: "Number of payments that were reversed. High reversal counts indicate payment processing errors, fraud risk, or vendor data quality issues."
    - name: "reversed_payment_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of reversed payments. Quantifies the financial impact of payment errors and the rework cost for treasury operations."
    - name: "total_payment_count"
      expr: COUNT(ap_payment_id)
      comment: "Total number of payment transactions executed. Baseline volume metric for payment run capacity and AP throughput."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to detect anomalous large payments and benchmark payment size distribution."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across payments. Used by treasury to monitor FX rate quality and hedging effectiveness."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for the port finance domain. Tracks posting volumes, reversal rates, intercompany activity, and workflow approval performance. Core KPI surface for financial close quality, audit readiness, and GL governance."
  source: "`shipping_ports_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry, used for year-over-year GL activity and close quality trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the journal entry, enabling monthly close volume and error rate analysis."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g. SA, KR, DR), used to segment GL postings by transaction nature."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g. posted, parked, held), used to track close completeness."
    - name: "workflow_approval_status"
      expr: workflow_approval_status
      comment: "Approval workflow status of the journal entry, used to identify bottlenecks in the financial close approval process."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates whether the journal entry is an intercompany transaction, used to segregate and reconcile intercompany eliminations."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the journal entry is a reversal, used to track error correction rates and GL quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry, used for multi-currency GL analysis and FX impact assessment."
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the journal entry (e.g. TOS, billing, payroll), used for sub-ledger reconciliation and data lineage."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of the journal entry posting date, used for monthly GL volume and close timing analysis."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group (e.g. leading ledger, IFRS, local GAAP) of the journal entry, used for multi-GAAP reporting analysis."
  measures:
    - name: "total_journal_entry_count"
      expr: COUNT(journal_entry_id)
      comment: "Total number of journal entries posted. Baseline GL activity volume metric used to assess financial close workload and system throughput."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of reversal journal entries. High reversal counts signal GL quality issues, posting errors, or accrual management problems requiring investigation."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of intercompany journal entries. Used to monitor intercompany transaction volumes and support elimination reconciliation at period close."
    - name: "parked_entry_count"
      expr: COUNT(CASE WHEN posting_status = 'PARKED' THEN journal_entry_id END)
      comment: "Number of parked (unposted) journal entries. Parked entries represent incomplete postings that must be resolved before period close."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN workflow_approval_status NOT IN ('APPROVED', 'POSTED') THEN journal_entry_id END)
      comment: "Number of journal entries pending workflow approval. High counts near period-end indicate close risk and approval bottlenecks."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across journal entries. Used to monitor FX rate consistency and detect anomalous rate applications."
    - name: "payment_blocked_entry_count"
      expr: COUNT(CASE WHEN payment_block_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of journal entries with a payment block. Identifies entries that will delay downstream payment processing."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger line-item metrics for the port finance domain. Tracks debit/credit volumes, tax amounts, reversal exposure, and transaction amounts at the most granular GL level. Core KPI surface for P&L analysis, balance sheet reconciliation, and cost allocation validation."
  source: "`shipping_ports_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area of the GL line item (e.g. container ops, bulk terminal), used for segment-level P&L and cost analysis."
    - name: "posting_key"
      expr: posting_key
      comment: "GL posting key indicating debit or credit nature of the line item, used for balance validation and transaction type analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the GL line item, used for tax category analysis and VAT/GST reporting."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the GL line item transaction, used for multi-currency balance analysis."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency of the GL line item, used for local statutory reporting and functional currency P&L."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the GL line item is a reversal, used to track error correction volumes at line level."
    - name: "segment_code"
      expr: segment_code
      comment: "Segment code of the GL line item, used for IFRS 8 segment reporting and segment-level profitability analysis."
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area (e.g. operations, administration, sales) of the GL line item, used for functional cost analysis."
    - name: "value_date_month"
      expr: DATE_TRUNC('month', value_date)
      comment: "Month of the value date on the GL line item, used for cash-basis reporting and value-date-based period analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-bearing GL line items (e.g. TEU, tonnes), used for volume-weighted cost analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across GL line items. Core P&L and balance sheet metric; debits represent expense recognition, asset increases, and liability decreases."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across GL line items. Core P&L and balance sheet metric; credits represent revenue recognition, liability increases, and asset decreases."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount in transaction currency across GL line items. Used for multi-currency P&L and FX exposure analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on GL line items. Required for tax provision calculation, VAT/GST reconciliation, and tax authority reporting."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on GL line items. Required for withholding tax remittance reconciliation and vendor tax compliance."
    - name: "net_debit_credit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net debit minus credit amount per GL line item. Indicates the net financial impact direction; used for balance validation and P&L net position analysis."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN journal_entry_line_id END)
      comment: "Number of reversed GL line items. High reversal line counts indicate posting quality issues and increase audit scrutiny risk."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity on GL line items (e.g. TEUs, tonnes, units). Used for volume-weighted cost analysis and operational cost-per-unit KPIs."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across GL line items. Used to monitor FX rate consistency and detect anomalous rate applications at line level."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual accounting metrics for the port finance domain. Tracks accrual volumes, amounts, settlement status, variance exposure, and reversal activity. Core KPI surface for period-end close quality, accrual accuracy, and financial statement reliability."
  source: "`shipping_ports_ecm`.`finance`.`accrual`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual, used for year-over-year accrual trend and close quality analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the accrual, enabling monthly accrual volume and accuracy analysis."
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g. revenue accrual, expense accrual, port dues accrual), used to segment accruals by nature."
    - name: "accrual_category"
      expr: accrual_category
      comment: "Category of the accrual (e.g. vessel services, container handling, infrastructure), used for cost category accrual analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual (e.g. pending, approved, rejected), used to track close readiness and approval bottlenecks."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the accrual (e.g. posted, unposted, reversed), used to monitor accrual completeness at period close."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the accrual (e.g. settled, unsettled, partially settled), used to track accrual resolution and balance sheet clean-up."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the accrual, used for multi-currency accrual exposure analysis."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area associated with the accrual, used for segment-level accrual analysis and cost allocation validation."
    - name: "accrual_date_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of the accrual date, used for monthly accrual flow and period-end accrual balance analysis."
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount posted. Primary accrual liability/asset KPI used by finance to assess period-end accrual exposure and balance sheet accuracy."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total accrual amount in local functional currency. Used for statutory reporting and local currency accrual balance management."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between accrued and actual amounts. High variance signals accrual estimation inaccuracy, impacting P&L reliability and audit risk."
    - name: "unsettled_accrual_amount"
      expr: SUM(CASE WHEN settlement_status != 'SETTLED' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of unsettled accruals. Represents the outstanding accrual balance that has not yet been matched to actual invoices or payments."
    - name: "pending_approval_accrual_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('APPROVED') THEN accrual_id END)
      comment: "Number of accruals pending approval. High counts near period-end indicate close risk and approval process bottlenecks."
    - name: "total_accrual_count"
      expr: COUNT(accrual_id)
      comment: "Total number of accrual records. Baseline volume metric for accrual workload and period-end close complexity."
    - name: "avg_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount per record. Used to detect anomalous large accruals and benchmark accrual size distribution."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to accruals. Used to monitor FX rate consistency in accrual postings and assess FX translation risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio metrics for the port finance domain. Tracks asset values, depreciation, net book value, impairment, and capital investment across asset classes, port locations, and cost centres. Core KPI surface for capital management, asset lifecycle decisions, and infrastructure investment planning."
  source: "`shipping_ports_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code (e.g. cranes, quay walls, IT equipment), the primary lens for capital asset portfolio analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Broader asset category (e.g. infrastructure, equipment, vehicles), used for high-level capital allocation analysis."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g. active, retired, under construction), used to track active asset base and retirement pipeline."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset (e.g. straight-line, declining balance), used for depreciation policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset valuation, used for multi-currency asset portfolio reporting."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source of the asset (e.g. own funds, grant, loan), used for capital funding mix analysis and grant utilisation tracking."
    - name: "is_leased"
      expr: is_leased
      comment: "Indicates whether the asset is leased (IFRS 16 right-of-use asset), used to segregate owned vs. leased asset portfolios."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area owning the asset, used for segment-level capital asset allocation and depreciation analysis."
    - name: "capitalization_date_year"
      expr: DATE_TRUNC('year', capitalization_date)
      comment: "Year of asset capitalisation, used for capital investment vintage analysis and asset age distribution."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year of asset acquisition, used for capital expenditure timing analysis and asset lifecycle management."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Primary capital investment KPI used by CFO and board to assess total capital deployed in port infrastructure."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (acquisition cost minus accumulated depreciation). Core balance sheet KPI for asset base valuation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets. Indicates the consumed economic value of the asset base and drives depreciation charge forecasting."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total residual value of fixed assets at end of useful life. Used in depreciation planning and asset disposal value estimation."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges on fixed assets. High impairment signals asset value deterioration, triggering strategic review of asset utilisation and replacement."
    - name: "total_revaluation_reserve"
      expr: SUM(CAST(revaluation_reserve AS DOUBLE))
      comment: "Total revaluation reserve on fixed assets. Tracks the cumulative upward revaluation of assets, relevant for IFRS fair value reporting."
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total government grants received for fixed assets. Tracks grant-funded capital investment and compliance with grant utilisation conditions."
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Used to assess insurance coverage adequacy relative to net book value and replacement cost."
    - name: "total_asset_count"
      expr: COUNT(fixed_asset_id)
      comment: "Total number of fixed assets in the portfolio. Baseline metric for asset base size and maintenance workload estimation."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of fixed assets in years. Used for depreciation planning, asset replacement scheduling, and capital expenditure forecasting."
    - name: "leased_asset_count"
      expr: COUNT(CASE WHEN is_leased = TRUE THEN fixed_asset_id END)
      comment: "Number of leased fixed assets (IFRS 16 right-of-use assets). Used to monitor lease portfolio size and IFRS 16 balance sheet impact."
    - name: "retired_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'RETIRED' THEN fixed_asset_id END)
      comment: "Number of retired fixed assets. Tracks asset retirement activity and supports capital replacement planning."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics for the port finance domain. Tracks allocated cost volumes, allocation basis quantities, reversal rates, and allocation accuracy across cost centres, profit centres, and terminals. Core KPI surface for overhead cost management, profitability analysis, and cost transparency."
  source: "`shipping_ports_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost allocation, used for year-over-year overhead allocation trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the cost allocation, enabling monthly overhead distribution and cost centre analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of cost allocation (e.g. direct, indirect, statistical), used to segment allocation methods and validate cost distribution logic."
    - name: "allocation_basis_type"
      expr: allocation_basis_type
      comment: "Basis used for the allocation (e.g. headcount, TEU volume, floor area), used to assess allocation driver appropriateness."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the cost allocation run (e.g. completed, pending, reversed), used to monitor allocation cycle completeness."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the allocation was reversed, used to track allocation error rates and reprocessing activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocated cost, used for multi-currency cost allocation analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the cost allocation, used for entity-level overhead cost analysis."
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area of the cost allocation, used for management accounting segment analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of the allocation posting date, used for monthly overhead distribution trend analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across cost centres and profit centres. Primary overhead distribution KPI used by finance to assess cost transparency and profitability accuracy."
    - name: "total_sender_original_cost"
      expr: SUM(CAST(sender_original_cost_amount AS DOUBLE))
      comment: "Total original cost in the sending cost centre before allocation. Used to validate that 100% of sender costs are distributed to receivers."
    - name: "total_allocation_basis_quantity"
      expr: SUM(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Total allocation basis quantity (e.g. total TEUs, total headcount) used as the allocation driver. Used to validate allocation driver volumes and assess driver accuracy."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage applied per allocation record. Used to detect skewed allocations and validate cost distribution fairness."
    - name: "reversed_allocation_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN cost_allocation_id END)
      comment: "Number of reversed cost allocations. High reversal counts indicate allocation rule errors or data quality issues requiring process improvement."
    - name: "reversed_allocation_amount"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of reversed cost allocations. Quantifies the financial impact of allocation errors and the rework burden on the controlling team."
    - name: "total_allocation_count"
      expr: COUNT(cost_allocation_id)
      comment: "Total number of cost allocation records. Baseline metric for allocation cycle complexity and controlling workload."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`finance_internal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal order (project/capex/opex order) metrics for the port finance domain. Tracks budget utilisation, cost commitments, budget overruns, and order lifecycle status across port locations, business areas, and order types. Core KPI surface for capital project control, cost management, and investment governance."
  source: "`shipping_ports_ecm`.`finance`.`internal_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of internal order (e.g. capex, maintenance, project), used to segment orders by investment nature."
    - name: "order_category"
      expr: order_category
      comment: "Category of the internal order (e.g. infrastructure, equipment, IT), used for capital category analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the internal order (e.g. open, technically complete, closed), used to track order lifecycle and close-out progress."
    - name: "business_area"
      expr: business_area
      comment: "Business area owning the internal order, used for segment-level capital spend and budget analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the internal order budget and costs, used for multi-currency capital project analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the internal order, used to analyse capital allocation by strategic priority."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Indicates whether the order is safety-critical, used to ensure safety-critical projects receive priority funding and are not delayed."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the order has environmental impact, used for ESG capital spend tracking and regulatory compliance reporting."
    - name: "order_type_category"
      expr: order_category
      comment: "Order category dimension for grouping capital spend by investment programme type."
    - name: "planned_start_date_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year of planned order start, used for capital investment pipeline and cash flow forecasting."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the internal order project (e.g. planning, execution, close-out), used for project lifecycle stage analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across internal orders. Primary capital authorisation KPI used by CFO and board to track total approved investment commitments."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred against internal orders. Core capital spend KPI used to track expenditure against approved budgets."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (purchase order / contract) amounts on internal orders. Represents future cash outflows already contractually committed."
    - name: "total_planning_budget"
      expr: SUM(CAST(planning_budget_amount AS DOUBLE))
      comment: "Total planning budget across internal orders. Used for early-stage capital planning and investment pipeline sizing."
    - name: "budget_utilisation_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) + CAST(committed_amount AS DOUBLE))
      comment: "Total budget utilised (actual costs plus commitments). Represents total budget consumed or obligated, the key metric for budget headroom management."
    - name: "budget_overrun_amount"
      expr: SUM(CASE WHEN (CAST(actual_cost_amount AS DOUBLE) + CAST(committed_amount AS DOUBLE)) > CAST(approved_budget_amount AS DOUBLE) THEN (CAST(actual_cost_amount AS DOUBLE) + CAST(committed_amount AS DOUBLE)) - CAST(approved_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget overrun amount across internal orders. Directly triggers executive intervention and budget reauthorisation processes."
    - name: "overrun_order_count"
      expr: COUNT(CASE WHEN (CAST(actual_cost_amount AS DOUBLE) + CAST(committed_amount AS DOUBLE)) > CAST(approved_budget_amount AS DOUBLE) THEN internal_order_id END)
      comment: "Number of internal orders in budget overrun. Used to prioritise project control interventions and escalate to investment governance committees."
    - name: "total_order_count"
      expr: COUNT(internal_order_id)
      comment: "Total number of internal orders. Baseline metric for capital project portfolio size and project management workload."
    - name: "safety_critical_order_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN internal_order_id END)
      comment: "Number of safety-critical internal orders. Used to ensure safety-critical investments are tracked separately and receive priority in budget allocation."
$$;