-- Metric views for domain: finance | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking institutional spending obligations, payment efficiency, and vendor liability exposure across cost centers, funds, and fiscal periods."
  source: "`education_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g., Approved, Pending, Paid, Disputed) used to segment payables pipeline."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice type (e.g., Standard, Credit Memo, Prepayment) for payables categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice, enabling monitoring of bottlenecks in the payables approval process."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated, supporting multi-currency payables analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment designated for the invoice (e.g., ACH, Check, Wire), used for cash management planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) driving due-date analysis and early-payment discount capture."
    - name: "program_code"
      expr: program_code
      comment: "Academic or administrative program code associated with the invoice for programmatic spend attribution."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of payables volume and spend over time."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice payment is due, enabling aging and cash-flow forecasting by period."
    - name: "form_1099_reportable_flag"
      expr: form_1099_reportable_flag
      comment: "Indicates whether the invoice amount is subject to IRS 1099 reporting, supporting tax compliance monitoring."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices. Core payables liability metric used by CFO and AP leadership to monitor institutional spending commitments."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_invoice_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments. Represents actual cash obligation and is the primary AP liability figure for financial reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across all AP invoices. Used by tax and compliance teams to monitor tax exposure and validate tax reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or contractual discounts available on AP invoices. Tracks discount capture opportunity for working capital optimization."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and shipping charges on AP invoices. Monitored to identify procurement logistics cost trends."
    - name: "total_form_1099_amount"
      expr: SUM(CAST(form_1099_amount AS DOUBLE))
      comment: "Total 1099-reportable payment amounts across AP invoices. Critical for IRS compliance and annual tax reporting obligations."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for AP workload, vendor activity, and period-over-period spend trend analysis."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoiced. Measures vendor concentration and diversity of the institution's supplier base."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_invoice_amount AS DOUBLE))
      comment: "Average net invoice amount per transaction. Benchmarks typical invoice size and detects anomalous high-value invoices requiring additional scrutiny."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN 1 END)
      comment: "Number of invoices currently in dispute status. Elevated dispute counts signal vendor relationship issues or receiving/matching process failures."
    - name: "on_hold_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'On Hold' THEN 1 END)
      comment: "Number of invoices placed on hold. Tracks AP processing bottlenecks and potential cash-flow disruptions from delayed payments."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment metrics tracking cash disbursements, payment efficiency, reconciliation status, and vendor payment patterns for institutional cash management."
  source: "`education_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AP payment (e.g., Cleared, Voided, Outstanding) for cash position and reconciliation monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the payment type (e.g., Regular, Prepayment, Refund) for disbursement categorization."
    - name: "payment_method"
      expr: payment_method
      comment: "Disbursement method (e.g., ACH, Check, Wire Transfer) used to analyze payment channel mix and associated processing costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash management and foreign exchange exposure analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment, critical for identifying unreconciled items and ensuring accurate cash reporting."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the payment for programmatic cash disbursement attribution."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment disbursement for cash flow trend analysis and period-over-period comparison."
    - name: "payment_source_system"
      expr: payment_source_system
      comment: "Source system that originated the payment, enabling reconciliation across ERP modules and legacy systems."
    - name: "remittance_advice_sent_indicator"
      expr: remittance_advice_sent_indicator
      comment: "Indicates whether remittance advice was sent to the vendor, supporting vendor communication compliance tracking."
    - name: "tax_reporting_indicator"
      expr: tax_reporting_indicator
      comment: "Flags payments subject to tax reporting requirements, supporting 1099 and other regulatory compliance workflows."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash disbursed via AP payments. Primary cash outflow metric used by treasury and CFO for liquidity management and cash forecasting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net cash disbursed after discounts taken. Represents actual cash outflow and is the authoritative figure for bank reconciliation and cash reporting."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts captured on AP payments. Measures working capital efficiency and the institution's ability to leverage vendor discount terms."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments issued. Baseline disbursement volume metric for AP operations, audit, and period-over-period trend analysis."
    - name: "distinct_vendor_payment_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors paid in the period. Measures breadth of vendor payment activity and supports vendor relationship management."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN void_date IS NOT NULL THEN 1 END)
      comment: "Number of payments that were voided. Elevated void rates indicate payment processing errors, fraud risk, or vendor disputes requiring investigation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per disbursement. Benchmarks typical payment size and flags anomalous large disbursements for review."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Number of payments not yet reconciled with bank statements. Unreconciled items represent financial reporting risk and must be resolved before period close."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics tracking revenue billed, collections performance, aging exposure, and write-off risk for the institution's receivables portfolio."
  source: "`education_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., Open, Paid, Overdue, Written Off) for receivables pipeline and collections monitoring."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the AR invoice type (e.g., Tuition, Sponsored Research, Facility Rental) for revenue stream segmentation."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the outstanding receivable (e.g., Current, 30-60 Days, 60-90 Days, 90+ Days) for collections prioritization and bad debt risk assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR invoice for multi-currency receivables management and foreign exchange exposure tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Designated payment method for the invoice, used to analyze collection channel effectiveness."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms on the invoice, enabling analysis of terms compliance and overdue risk by terms category."
    - name: "program_code"
      expr: program_code
      comment: "Academic or administrative program generating the receivable for programmatic revenue attribution."
    - name: "revenue_account_code"
      expr: revenue_account_code
      comment: "Revenue account code for the invoice, enabling revenue recognition analysis by account classification."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for billing volume trend analysis and revenue recognition timing."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address, supporting geographic analysis of receivables and international collections risk."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed across all AR invoices. Primary revenue billing metric used by CFO and revenue management to track institutional billing activity."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts. Represents expected cash collections and is the authoritative revenue figure for financial reporting."
    - name: "total_amount_outstanding"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total outstanding receivables balance. Core collections metric representing uncollected revenue and cash flow risk for treasury and collections management."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against AR invoices. Measures collections effectiveness and cash inflow realization against billed revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on AR invoices. Supports tax liability reporting and compliance with applicable tax regulations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices. Measures revenue leakage from discount policies and informs pricing strategy reviews."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline billing volume metric for revenue operations and period-over-period activity comparison."
    - name: "writeoff_invoice_count"
      expr: COUNT(CASE WHEN writeoff_date IS NOT NULL THEN 1 END)
      comment: "Number of invoices written off as uncollectible. Elevated write-off counts signal collections process failures or credit risk issues requiring policy intervention."
    - name: "avg_outstanding_amount"
      expr: AVG(CAST(amount_outstanding AS DOUBLE))
      comment: "Average outstanding balance per AR invoice. Benchmarks typical receivable size and identifies concentration risk in large outstanding balances."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Overdue' THEN 1 END)
      comment: "Number of invoices past their due date. Key collections KPI driving dunning actions and bad debt reserve adjustments."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_ar_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable cash receipt metrics tracking cash inflows, application efficiency, unapplied cash balances, and reconciliation status for institutional collections management."
  source: "`education_ecm`.`finance`.`ar_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the AR receipt (e.g., Applied, Unapplied, Reversed) for cash application pipeline monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Method by which cash was received (e.g., Check, ACH, Wire, Credit Card) for payment channel analysis and processing cost optimization."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was received (e.g., Online Portal, Lockbox, Counter) for collections channel effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt for multi-currency cash management and foreign exchange reconciliation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the receipt, critical for accurate cash reporting and period-close integrity."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the receipt for programmatic cash inflow attribution."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of cash receipt for cash inflow trend analysis and period-over-period collections comparison."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags receipts that have been reversed, enabling monitoring of reversal rates as an indicator of collections process quality."
    - name: "deposit_date_month"
      expr: DATE_TRUNC('MONTH', deposit_date)
      comment: "Month of bank deposit for cash deposit timing analysis and float management."
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(receipt_amount AS DOUBLE))
      comment: "Total cash received across all AR receipts. Primary cash inflow metric used by treasury and CFO for liquidity management and revenue realization tracking."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total cash applied to AR invoices. Measures collections effectiveness and the proportion of receipts successfully matched to outstanding receivables."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet applied to invoices. Unapplied cash represents a reconciliation risk and working capital inefficiency requiring prompt resolution."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted at time of receipt. Measures revenue concessions and informs collections policy and discount authorization reviews."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of cash receipts processed. Baseline collections volume metric for AR operations and period-over-period activity analysis."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of receipts that were reversed. High reversal rates indicate payment processing errors, returned checks, or fraud risk requiring investigation."
    - name: "avg_receipt_amount"
      expr: AVG(CAST(receipt_amount AS DOUBLE))
      comment: "Average cash receipt amount per transaction. Benchmarks typical payment size and identifies anomalous large receipts for treasury review."
    - name: "unreconciled_receipt_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Number of receipts not yet reconciled with bank statements. Unreconciled receipts represent financial reporting risk and must be resolved before period close."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking institutional budget allocation, expenditure against budget, available balances, encumbrances, and budget utilization across cost centers, funds, and programs."
  source: "`education_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., Approved, Draft, Closed) for budget lifecycle and governance monitoring."
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g., Operating, Capital, Grant, Salary) for budget category analysis and resource allocation review."
    - name: "budget_category"
      expr: budget_category
      comment: "Functional category of the budget line (e.g., Personnel, Supplies, Travel) for expenditure pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency budget management and reporting."
    - name: "is_restricted"
      expr: is_restricted
      comment: "Indicates whether the budget is restricted (e.g., grant-funded, donor-restricted) versus unrestricted, critical for compliance and fund usage monitoring."
    - name: "is_salary_budget"
      expr: is_salary_budget
      comment: "Flags salary budgets for workforce cost planning and compensation budget utilization analysis."
    - name: "approving_authority"
      expr: approving_authority
      comment: "Authority that approved the budget, enabling governance and delegation-of-authority compliance monitoring."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the budget period for temporal budget analysis and fiscal year planning."
    - name: "pool_code"
      expr: pool_code
      comment: "Budget pool code for pooled budget management and cross-unit resource allocation analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system from which the budget originated, supporting data lineage and multi-system budget consolidation."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total approved budget allocation. Primary budget planning metric used by CFO and budget officers to monitor institutional resource commitments and funding levels."
    - name: "total_actual_expenditure_amount"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual spending against budget. Core budget execution metric enabling variance analysis and spend-to-budget performance monitoring."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total remaining available budget balance. Measures unspent budget capacity and is critical for spend authorization and year-end budget management decisions."
    - name: "total_encumbrance_balance"
      expr: SUM(CAST(encumbrance_balance AS DOUBLE))
      comment: "Total encumbered (committed but not yet spent) budget. Encumbrances reduce available balance and represent future cash obligations for procurement and payroll."
    - name: "total_carry_forward_amount"
      expr: SUM(CAST(carry_forward_amount AS DOUBLE))
      comment: "Total budget carried forward from prior periods. Measures multi-year budget flexibility and informs year-end close and carryforward policy decisions."
    - name: "total_fte_count"
      expr: SUM(CAST(fte_count AS DOUBLE))
      comment: "Total FTE headcount budgeted across all budget lines. Workforce planning metric linking financial budgets to staffing levels for HR and finance alignment."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Baseline metric for budget portfolio size and complexity across the institution."
    - name: "avg_budget_utilization_rate"
      expr: AVG(CAST(actual_expenditure_amount AS DOUBLE) / NULLIF(CAST(budgeted_amount AS DOUBLE), 0))
      comment: "Average ratio of actual expenditure to budgeted amount per budget line. Measures budget execution efficiency; low utilization may indicate under-spending risk while high utilization signals potential overrun."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost (F&A) rate applied across budget lines. Monitors overhead recovery rates and informs grant budget negotiations and cost allocation policy."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting activity, debit/credit volumes, reversal rates, and journal processing efficiency for financial close and audit readiness."
  source: "`education_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "journal_type"
      expr: journal_type
      comment: "Type of journal entry (e.g., Standard, Adjusting, Closing, Reversing) for GL activity categorization and audit trail analysis."
    - name: "journal_category"
      expr: journal_category
      comment: "Business category of the journal entry (e.g., Payroll, Accounts Payable, Revenue) for transaction source analysis."
    - name: "journal_source"
      expr: journal_source
      comment: "System or process that originated the journal entry, enabling source-system reconciliation and automated vs. manual entry analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g., Posted, Unposted, Error) for period-close readiness monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the journal entry for multi-currency GL analysis and foreign exchange impact assessment."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags journal entries that are reversals, enabling reversal rate monitoring as an indicator of GL correction activity and process quality."
    - name: "encumbrance_indicator"
      expr: encumbrance_indicator
      comment: "Indicates whether the journal entry records an encumbrance (commitment) rather than an actual expenditure, for budget commitment tracking."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flags intercompany journal entries for elimination and consolidation analysis in multi-entity financial reporting."
    - name: "journal_date_month"
      expr: DATE_TRUNC('MONTH', journal_date)
      comment: "Month of the journal entry date for GL activity trend analysis and period-over-period comparison."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the journal entry for programmatic financial activity attribution."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all journal entries. Core GL activity metric used by controllers to monitor transaction volume and validate debit/credit balance integrity."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all journal entries. Paired with total debits to verify GL balance and detect out-of-balance conditions requiring correction."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline GL activity volume metric for period-close monitoring, audit sampling, and workload analysis."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversing journal entries. High reversal counts relative to total entries indicate GL correction activity and potential process quality issues."
    - name: "unposted_entry_count"
      expr: COUNT(CASE WHEN posting_status != 'Posted' THEN 1 END)
      comment: "Number of journal entries not yet posted to the GL. Unposted entries at period-end represent a financial close risk and must be resolved before reporting."
    - name: "avg_debit_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry. Benchmarks typical transaction size and flags anomalously large entries for controller review and fraud detection."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Monitors inter-entity transaction volume requiring elimination in consolidated financial statements."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_journal_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal line metrics providing granular transaction-level analysis of debits, credits, encumbrances, and indirect cost activity across ledger accounts, cost centers, and funds."
  source: "`education_ecm`.`finance`.`journal_line`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal line (e.g., Posted, Unposted, Error) for period-close readiness and GL integrity monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the journal line for governance and internal control compliance monitoring."
    - name: "encumbrance_indicator"
      expr: encumbrance_indicator
      comment: "Flags journal lines recording encumbrances (commitments) versus actual expenditures for budget commitment analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed journal lines for GL correction activity monitoring and audit trail analysis."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Transaction currency of the journal line for multi-currency GL analysis and foreign exchange impact assessment."
    - name: "program_code"
      expr: program_code
      comment: "Program code on the journal line for programmatic expenditure attribution and cost analysis."
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code classifying the nature of the transaction for functional expense analysis and NACUBO reporting."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment recorded on the journal line, enabling analysis of correction and reclassification activity."
    - name: "accounting_date_month"
      expr: DATE_TRUNC('MONTH', accounting_date)
      comment: "Month of the accounting date for GL transaction trend analysis and period-over-period comparison."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the journal line for data lineage, reconciliation, and sub-ledger-to-GL tie-out analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount at the journal line level. Granular GL activity metric enabling account-level expenditure analysis and sub-ledger reconciliation."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount at the journal line level. Paired with debits for account-level balance verification and revenue/liability analysis."
    - name: "total_functional_currency_debit"
      expr: SUM(CAST(functional_currency_debit_amount AS DOUBLE))
      comment: "Total debit amount converted to functional currency. Enables consistent cross-currency financial analysis and consolidated reporting."
    - name: "total_functional_currency_credit"
      expr: SUM(CAST(functional_currency_credit_amount AS DOUBLE))
      comment: "Total credit amount converted to functional currency. Supports consolidated financial reporting and foreign exchange impact analysis."
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Total number of journal lines. Baseline GL transaction volume metric for audit sampling, period-close monitoring, and system performance analysis."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost (F&A) rate applied at the journal line level. Monitors overhead recovery consistency across transactions and validates rate application compliance."
    - name: "total_statistical_amount"
      expr: SUM(CAST(statistical_amount AS DOUBLE))
      comment: "Total statistical amount recorded on journal lines. Statistical entries drive cost allocation calculations (e.g., square footage, headcount) and are critical for indirect cost pool distribution."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order metrics tracking procurement commitments, encumbrance levels, receipt and invoice matching performance, and vendor spend for institutional procurement governance."
  source: "`education_ecm`.`finance`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Open, Closed, Cancelled, Pending Approval) for procurement pipeline and commitment monitoring."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Contract) for procurement instrument analysis and policy compliance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO for procurement governance and delegation-of-authority compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency procurement analysis and foreign exchange exposure management."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with the vendor, enabling analysis of terms compliance and early-payment discount opportunities."
    - name: "program_code"
      expr: program_code
      comment: "Program code associated with the PO for programmatic procurement spend attribution."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method specified on the PO for logistics cost analysis and delivery performance monitoring."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was issued for procurement volume trend analysis and period-over-period comparison."
    - name: "fob_point"
      expr: fob_point
      comment: "FOB (Free on Board) point specifying when title and risk transfer, relevant for asset capitalization timing and insurance coverage."
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of purchase orders issued. Primary procurement commitment metric used by CFO and procurement leadership to monitor institutional spending commitments."
    - name: "total_po_amount_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total PO value including tax. Represents full financial commitment for budget encumbrance and cash flow planning purposes."
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered amount on open purchase orders. Encumbrances reduce available budget and represent future cash obligations critical for budget management."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced against purchase orders. Measures PO liquidation progress and identifies orders with significant uninvoiced balances."
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total amount received against purchase orders. Measures goods/services receipt progress and enables three-way match analysis for AP invoice approval."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on purchase orders. Supports tax liability planning and procurement tax compliance monitoring."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline procurement volume metric for workload analysis and period-over-period comparison."
    - name: "distinct_vendor_po_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with purchase orders. Measures vendor base breadth and supports vendor consolidation and strategic sourcing analysis."
    - name: "avg_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Benchmarks typical procurement transaction size and identifies anomalously large POs requiring additional approval scrutiny."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking institutional capital asset portfolio value, depreciation, net book value, and asset lifecycle status for capital management and GASB/FASB compliance reporting."
  source: "`education_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the fixed asset (e.g., Active, Disposed, Transferred) for asset portfolio management and reporting."
    - name: "asset_category"
      expr: asset_category
      comment: "Major category of the fixed asset (e.g., Equipment, Buildings, Land, Vehicles) for capital asset portfolio analysis and depreciation policy application."
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Subcategory of the fixed asset for granular capital asset classification and maintenance planning."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset (e.g., Straight-Line, Declining Balance) for financial reporting and tax compliance analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the asset acquisition (e.g., Federal Grant, Institutional, Donor Gift) for asset ownership and compliance tracking."
    - name: "gasb_classification"
      expr: gasb_classification
      comment: "GASB classification of the asset for government accounting standards compliance and external financial reporting."
    - name: "federal_property_indicator"
      expr: federal_property_indicator
      comment: "Flags federally-funded assets subject to federal property management regulations (2 CFR 200), critical for grant compliance and audit readiness."
    - name: "capitalization_threshold_met"
      expr: capitalization_threshold_met
      comment: "Indicates whether the asset meets the capitalization threshold, distinguishing capital assets from expensed items for balance sheet accuracy."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition for capital investment trend analysis and asset age distribution reporting."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (e.g., Sale, Scrap, Trade-In, Donation) for asset retirement analysis and proceeds tracking."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets. Primary capital asset valuation metric used by CFO and facilities management to monitor institutional capital investment."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets. Measures asset value consumption over time and is required for balance sheet presentation and GASB/FASB compliance."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (acquisition cost minus accumulated depreciation) of the asset portfolio. Core capital asset metric for balance sheet reporting and capital planning."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of fixed assets. Used in depreciation calculations and asset disposal planning to estimate residual value recovery."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds received from asset disposals. Measures capital recovery from asset retirements and informs gain/loss on disposal calculations for financial reporting."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in the portfolio. Baseline capital asset inventory metric for physical inventory management and audit compliance."
    - name: "federal_property_count"
      expr: COUNT(CASE WHEN federal_property_indicator = TRUE THEN 1 END)
      comment: "Number of federally-funded fixed assets. Critical for federal property management compliance under 2 CFR 200 and grant audit readiness."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Benchmarks asset value and identifies categories with significantly depreciated assets requiring replacement planning."
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(accumulated_depreciation AS DOUBLE) / NULLIF(CAST(acquisition_cost AS DOUBLE), 0))
      comment: "Average ratio of accumulated depreciation to acquisition cost per asset. Measures overall asset age and replacement urgency across the capital portfolio."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_grant_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant account metrics tracking sponsored research funding, cost-sharing commitments, indirect cost recovery, and grant portfolio health for research finance and compliance management."
  source: "`education_ecm`.`finance`.`grant_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the grant account (e.g., Active, Closed, Pending) for grant portfolio lifecycle monitoring."
    - name: "sponsor_type"
      expr: sponsor_type
      comment: "Type of sponsoring organization (e.g., Federal, State, Industry, Foundation) for grant portfolio composition analysis and funding source diversification."
    - name: "federal_award_indicator"
      expr: federal_award_indicator
      comment: "Flags federally-funded grant accounts subject to Uniform Guidance (2 CFR 200) compliance requirements."
    - name: "flow_through_indicator"
      expr: flow_through_indicator
      comment: "Indicates flow-through awards where the institution is a sub-recipient, requiring additional compliance monitoring and pass-through reporting."
    - name: "cost_sharing_required"
      expr: cost_sharing_required
      comment: "Flags grant accounts with mandatory cost-sharing commitments, requiring tracking of institutional contributions to meet award terms."
    - name: "prime_sponsor_indicator"
      expr: prime_sponsor_indicator
      comment: "Indicates whether the institution is the prime recipient (vs. sub-recipient), affecting compliance obligations and reporting requirements."
    - name: "fa_base_type"
      expr: fa_base_type
      comment: "Facilities and Administrative (F&A) cost base type (e.g., MTDC, TDC) determining how indirect costs are calculated on the award."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the grant account for multi-currency sponsored research financial management."
    - name: "account_setup_date_year"
      expr: DATE_TRUNC('YEAR', account_setup_date)
      comment: "Year the grant account was established for award vintage analysis and portfolio age distribution."
    - name: "current_budget_period_end_month"
      expr: DATE_TRUNC('MONTH', current_budget_period_end_date)
      comment: "Month the current budget period ends, enabling identification of grants approaching closeout and requiring financial action."
  measures:
    - name: "total_current_budget_period_amount"
      expr: SUM(CAST(current_budget_period_amount AS DOUBLE))
      comment: "Total budget available in the current award period across all grant accounts. Primary sponsored research funding metric used by research finance and VPR to monitor active award portfolio value."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total institutional cost-sharing committed across grant accounts. Measures the institution's financial commitment to sponsored projects and compliance with award cost-sharing requirements."
    - name: "grant_account_count"
      expr: COUNT(1)
      comment: "Total number of grant accounts. Baseline sponsored research portfolio size metric for research finance management and compliance monitoring."
    - name: "active_grant_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of currently active grant accounts. Measures the active sponsored research portfolio and drives compliance monitoring workload planning."
    - name: "federal_award_count"
      expr: COUNT(CASE WHEN federal_award_indicator = TRUE THEN 1 END)
      comment: "Number of federally-funded grant accounts. Federal awards carry the highest compliance burden (2 CFR 200, SEFA reporting) and require dedicated monitoring."
    - name: "avg_fa_rate"
      expr: AVG(CAST(fa_rate AS DOUBLE))
      comment: "Average F&A (indirect cost) rate applied across grant accounts. Monitors indirect cost recovery rates and informs rate negotiation strategy with federal cognizant agencies."
    - name: "avg_current_budget_period_amount"
      expr: AVG(CAST(current_budget_period_amount AS DOUBLE))
      comment: "Average award budget per grant account in the current period. Benchmarks typical award size and identifies the institution's grant portfolio concentration and diversification."
    - name: "cost_sharing_required_count"
      expr: COUNT(CASE WHEN cost_sharing_required = TRUE THEN 1 END)
      comment: "Number of grant accounts with mandatory cost-sharing requirements. Drives institutional cost-sharing tracking and compliance reporting obligations."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance fund metrics tracking fund balances, budget utilization, endowment principal, encumbrances, and spending rates across the institution's fund accounting structure for GASB/FASB net asset reporting."
  source: "`education_ecm`.`finance`.`finance_fund`"
  dimensions:
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g., Active, Closed, Pending) for fund portfolio lifecycle monitoring."
    - name: "fund_type"
      expr: fund_type
      comment: "Classification of the fund (e.g., Operating, Endowment, Restricted, Plant) for fund accounting category analysis and net asset classification."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification of the fund (e.g., Permanently Restricted, Temporarily Restricted, Unrestricted) for FASB net asset reporting and donor intent compliance."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "FASB net asset classification (e.g., Without Donor Restrictions, With Donor Restrictions) for financial statement presentation."
    - name: "reporting_category"
      expr: reporting_category
      comment: "Reporting category for external financial reporting alignment (e.g., NACUBO, IPEDS) enabling regulatory report preparation."
    - name: "carryforward_allowed"
      expr: carryforward_allowed
      comment: "Indicates whether unspent fund balances may be carried forward to the next fiscal year, affecting year-end budget management decisions."
    - name: "allow_deficit_spending"
      expr: allow_deficit_spending
      comment: "Flags funds that permit deficit spending, requiring enhanced monitoring to prevent unauthorized overdrafts."
    - name: "external_reporting_required"
      expr: external_reporting_required
      comment: "Indicates funds subject to external reporting requirements (e.g., federal, state, donor), driving compliance and disclosure obligations."
    - name: "establishment_date_year"
      expr: DATE_TRUNC('YEAR', establishment_date)
      comment: "Year the fund was established for fund portfolio age analysis and historical funding trend review."
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total current balance across all funds. Primary fund accounting metric used by CFO and treasury to monitor institutional liquidity and net asset position."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all funds. Measures total authorized spending capacity and is the foundation for budget-to-actual variance analysis."
    - name: "total_revenue_to_date"
      expr: SUM(CAST(revenue_to_date AS DOUBLE))
      comment: "Total revenue recognized to date across all funds. Tracks cumulative revenue realization against budget and prior-year benchmarks."
    - name: "total_expenditure_to_date"
      expr: SUM(CAST(expenditure_to_date AS DOUBLE))
      comment: "Total expenditures incurred to date across all funds. Core spending metric for budget execution monitoring and year-end projection analysis."
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered (committed but unspent) amounts across funds. Encumbrances reduce available balance and represent future cash obligations for procurement and payroll."
    - name: "total_endowment_principal"
      expr: SUM(CAST(endowment_principal AS DOUBLE))
      comment: "Total endowment principal across endowment funds. Measures the institution's permanent endowment corpus, a key indicator of long-term financial sustainability and donor stewardship."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of funds in the fund accounting structure. Baseline metric for fund portfolio complexity and administrative overhead."
    - name: "avg_spending_rate"
      expr: AVG(CAST(spending_rate AS DOUBLE))
      comment: "Average spending rate across funds. For endowment funds, the spending rate determines annual distributions; monitoring ensures compliance with spending policy and endowment preservation goals."
$$;