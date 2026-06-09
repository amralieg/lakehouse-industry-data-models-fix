-- Metric views for domain: finance | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking vendor spend, outstanding liabilities, discount capture, and payment efficiency across expense categories and approval workflows."
  source: "`travel_hospitality_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the AP invoice (e.g., F&B supplies, maintenance, utilities) for spend analysis by category."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., Open, Paid, Disputed, Cancelled) for aging and workflow tracking."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Memo, Recurring) to segment payables by transaction type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice, used to identify bottlenecks in the AP approval process."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay the invoice (e.g., ACH, Wire, Check) for cash management and payment mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice was issued, enabling multi-currency spend analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the invoice is a recurring obligation, supporting fixed vs. variable cost analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO, receipt, invoice) — a key internal control indicator for procurement compliance."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of vendor spend over time."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due, used for cash flow forecasting and payment scheduling."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices. Represents total vendor spend commitment before discounts and taxes — a primary cost management KPI."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts. Used to measure actual cash outflow obligations to vendors."
    - name: "total_outstanding_payables"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total amount still outstanding across all AP invoices. A critical liquidity and working capital metric for treasury management."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount already paid to vendors. Used to track payment execution against total obligations."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or negotiated discounts captured. Measures procurement efficiency and vendor relationship value."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across AP invoices. Required for tax liability reporting and compliance."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for AP workload and vendor activity analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN 1 END)
      comment: "Number of invoices currently in dispute. Elevated dispute counts signal vendor relationship or procurement process issues requiring management attention."
    - name: "outstanding_payables_ratio"
      expr: ROUND(100.0 * SUM(CAST(outstanding_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total gross invoice value still outstanding. Measures AP clearance efficiency — high ratios indicate payment backlogs or cash flow constraints."
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross invoice value captured as discounts. Measures procurement team effectiveness in leveraging early-payment terms."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross value per AP invoice. Used to benchmark vendor invoice sizes and detect anomalous spend patterns."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics covering payment volumes, bank fees, foreign exchange costs, withholding tax, and reversal activity — key for cash management and payment operations."
  source: "`travel_hospitality_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, Wire, Check) for payment mix and cost-of-payment analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment transaction (e.g., Standard, Advance, Reversal) for payment classification."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Cleared, Pending, Reversed) for payment operations monitoring."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the payment was made, enabling FX exposure and multi-currency payment analysis."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Functional/base currency for the payment, used in currency translation and reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed. High reversal rates signal payment process quality issues."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payment, used to track payment authorization compliance."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment execution for cash outflow trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed to vendors. Primary cash outflow metric for treasury and AP management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments. Represents actual cash leaving the organization."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment value translated to base/functional currency. Used for consolidated financial reporting across multi-currency operations."
    - name: "total_bank_fees"
      expr: SUM(CAST(bank_fee_amount AS DOUBLE))
      comment: "Total bank fees incurred on AP payments. Measures cost of payment execution — a target for treasury optimization."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for tax compliance and vendor remittance reporting."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts taken at time of payment. Measures realized savings from prompt payment programs."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments processed. Baseline volume metric for payment operations capacity planning."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of payment reversals. Elevated reversal counts indicate payment errors, fraud risk, or vendor disputes requiring investigation."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were reversed. A key payment quality and control metric — high rates trigger process reviews."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to benchmark payment sizes and detect outliers or anomalous disbursements."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across payments. Used to monitor FX rate trends and hedging effectiveness."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue recognition, collections performance, aging, write-offs, and billing entity analysis — essential for revenue assurance and working capital management."
  source: "`travel_hospitality_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., Open, Paid, Overdue, Written-Off) for collections pipeline analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (e.g., Room, F&B, Event, Ancillary) for revenue stream segmentation."
    - name: "billing_entity_type"
      expr: billing_entity_type
      comment: "Type of billing entity (e.g., Individual, Corporate, Group) for receivables segmentation by customer class."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status (e.g., Current, In Collections, Legal) for receivables risk management."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification (e.g., 0-30, 31-60, 61-90, 90+ days) for DSO and collections prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency receivables analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the invoice for payment channel mix analysis."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the invoice has been written off. Used to track bad debt exposure."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute. Disputed invoices represent revenue at risk."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing entity for geographic receivables analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for revenue recognition trend analysis."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month revenue was recognized for period-accurate financial reporting."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed amount across all AR invoices. Primary top-line revenue billing metric for financial reporting."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all AR invoices. Core working capital and liquidity metric — directly impacts cash flow forecasting."
    - name: "total_collected_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected from AR invoices. Measures collections effectiveness against billed revenue."
    - name: "total_room_revenue_billed"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue billed via AR invoices. Key revenue stream metric for rooms division performance."
    - name: "total_fnb_revenue_billed"
      expr: SUM(CAST(fnb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue billed via AR invoices. Measures food and beverage revenue contribution to total billings."
    - name: "total_event_revenue_billed"
      expr: SUM(CAST(event_revenue_amount AS DOUBLE))
      comment: "Total event/meeting revenue billed via AR invoices. Tracks MICE (Meetings, Incentives, Conferences, Exhibitions) revenue performance."
    - name: "total_ancillary_revenue_billed"
      expr: SUM(CAST(ancillary_revenue_amount AS DOUBLE))
      comment: "Total ancillary revenue billed (spa, parking, etc.). Measures non-room revenue diversification."
    - name: "total_write_off_amount"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total invoice value written off as bad debt. A critical credit risk and revenue assurance metric — high write-offs signal collections failures."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to AR invoices. Measures revenue leakage from discounting practices."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices. Required for tax remittance compliance and reporting."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total billed amount that has been collected. Primary collections effectiveness KPI — low rates trigger collections escalation."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN write_off_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total billed revenue written off as bad debt. Measures credit risk exposure — a key metric for credit policy decisions."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of AR invoices currently under dispute. Elevated counts signal billing accuracy or guest satisfaction issues."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline volume metric for billing activity and revenue operations."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment receipt metrics covering cash collection volumes, payment channel mix, refund activity, transaction fees, and FX impact — critical for revenue assurance and treasury operations."
  source: "`travel_hospitality_ecm`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the guest or corporate account (e.g., Credit Card, Cash, Wire) for payment channel analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g., Front Desk, OTA, Direct) for channel revenue attribution."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Settled, Pending, Reversed) for payment operations monitoring."
    - name: "card_type"
      expr: card_type
      comment: "Card brand (e.g., Visa, Mastercard, Amex) for payment mix and interchange cost analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which payment was received for multi-currency revenue analysis."
    - name: "is_refund"
      expr: is_refund
      comment: "Indicates whether the payment is a refund. Refund volumes are a key guest satisfaction and revenue leakage indicator."
    - name: "is_advance_deposit"
      expr: is_advance_deposit
      comment: "Indicates whether the payment is an advance deposit. Advance deposits represent committed future revenue."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for cash collection trend analysis."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of payment settlement for cash flow timing analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount received from guests and corporate accounts. Primary cash inflow metric for revenue operations."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after transaction fees. Represents actual net cash received — used for net revenue reporting."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to AR invoices. Measures how effectively incoming payments are being matched and cleared against open receivables."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices. High unapplied balances indicate cash application backlog and reconciliation risk."
    - name: "total_transaction_fees"
      expr: SUM(CAST(transaction_fee AS DOUBLE))
      comment: "Total payment processing fees incurred. Measures cost of payment acceptance — a target for payment mix optimization."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment value in functional/base currency. Used for consolidated revenue reporting across multi-currency properties."
    - name: "total_refund_amount"
      expr: SUM(CASE WHEN is_refund = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount refunded to guests. Measures revenue reversals — high refund volumes signal service quality or billing issues."
    - name: "total_advance_deposit_amount"
      expr: SUM(CASE WHEN is_advance_deposit = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total advance deposits received. Represents committed future revenue and a key forward-looking cash flow indicator."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payments received. Baseline volume metric for payment operations and guest transaction activity."
    - name: "refund_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refund = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment transactions that are refunds. A key guest satisfaction and revenue integrity metric — high rates trigger service quality reviews."
    - name: "payment_application_rate"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received payments applied to invoices. Measures AR cash application efficiency — low rates indicate reconciliation backlogs."
    - name: "avg_transaction_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(transaction_fee AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Average transaction fee as a percentage of payment amount. Measures cost of payment acceptance — used to optimize payment method mix."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and performance metrics covering budgeted revenue, expense, profitability, and operational KPIs (ADR, RevPAR, occupancy, GOPPAR) — the primary financial planning and variance analysis layer."
  source: "`travel_hospitality_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Annual, Revised, Forecast) for budget version and scenario analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget (e.g., Revenue, Expense, Capital) for budget structure analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the budget (e.g., Draft, Approved, Locked) for governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency planning analysis."
    - name: "budget_version"
      expr: version
      comment: "Version identifier of the budget (e.g., v1, v2, Final) for tracking budget revisions over time."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget period begins, used for aligning budget to fiscal calendar."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the budget was approved, used for budget governance and approval cycle analysis."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total budgeted financial amount. Primary budget volume metric for financial planning and resource allocation decisions."
    - name: "total_budgeted_total_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all streams. The top-line revenue planning target used in quarterly business reviews and board reporting."
    - name: "total_budgeted_rooms_revenue"
      expr: SUM(CAST(budgeted_rooms_revenue AS DOUBLE))
      comment: "Total budgeted rooms revenue. Core revenue planning metric for the rooms division — the largest revenue stream in hospitality."
    - name: "total_budgeted_fnb_revenue"
      expr: SUM(CAST(budgeted_fnb_revenue AS DOUBLE))
      comment: "Total budgeted F&B revenue. Used to set performance targets for food and beverage operations."
    - name: "total_budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Total budgeted events/MICE revenue. Used to set group and event sales targets."
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted Gross Operating Profit. The primary profitability planning target — used in owner and management company performance reviews."
    - name: "total_budgeted_ebitda"
      expr: SUM(CAST(budgeted_ebitda AS DOUBLE))
      comment: "Total budgeted EBITDA. Key investor and ownership entity profitability target for capital allocation decisions."
    - name: "total_budgeted_noi"
      expr: SUM(CAST(budgeted_noi AS DOUBLE))
      comment: "Total budgeted Net Operating Income. Critical metric for ownership entities and lenders evaluating property financial performance."
    - name: "total_budgeted_operating_expense"
      expr: SUM(CAST(budgeted_operating_expense AS DOUBLE))
      comment: "Total budgeted operating expenses. Used to set cost targets and evaluate expense management performance."
    - name: "total_budgeted_labor_expense"
      expr: SUM(CAST(budgeted_labor_expense AS DOUBLE))
      comment: "Total budgeted labor expense. Labor is typically the largest operating cost in hospitality — a primary target for workforce planning."
    - name: "avg_budgeted_adr"
      expr: AVG(CAST(budgeted_adr AS DOUBLE))
      comment: "Average budgeted Average Daily Rate. The primary rooms revenue pricing target used in revenue management planning."
    - name: "avg_budgeted_revpar"
      expr: AVG(CAST(budgeted_revpar AS DOUBLE))
      comment: "Average budgeted RevPAR (Revenue Per Available Room). The industry-standard rooms revenue efficiency target for competitive benchmarking."
    - name: "avg_budgeted_goppar"
      expr: AVG(CAST(budgeted_goppar AS DOUBLE))
      comment: "Average budgeted GOPPAR (Gross Operating Profit Per Available Room). The primary total-hotel profitability efficiency target."
    - name: "avg_budgeted_occupancy_rate"
      expr: AVG(CAST(budgeted_occupancy_rate AS DOUBLE))
      comment: "Average budgeted occupancy rate. Core demand planning target used in revenue management and capacity planning."
    - name: "avg_budgeted_trevpar"
      expr: AVG(CAST(budgeted_trevpar AS DOUBLE))
      comment: "Average budgeted TRevPAR (Total Revenue Per Available Room). Measures total revenue efficiency including all revenue streams — a key total hotel performance target."
    - name: "avg_budgeted_cpor"
      expr: AVG(CAST(budgeted_cpor AS DOUBLE))
      comment: "Average budgeted Cost Per Occupied Room. Measures operational cost efficiency per occupied room — used to set housekeeping and rooms division cost targets."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Used to track budget planning activity and version proliferation."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-item metrics for granular spend planning, variance threshold management, and departmental budget allocation analysis — supports detailed financial planning and cost control."
  source: "`travel_hospitality_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget line (e.g., Revenue, Expense, Capital) for budget structure analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget line item for spend category analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with the budget line for departmental cost allocation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line for governance and workflow tracking."
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget this line belongs to for tracking planning iterations."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget to this line (e.g., Direct, Proportional) for cost allocation transparency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for multi-currency planning."
    - name: "locked_flag"
      expr: locked_flag
      comment: "Indicates whether the budget line is locked from further modification — a governance control indicator."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget line becomes effective for period-based planning analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all line items. Primary budget commitment metric for financial planning and resource allocation."
    - name: "total_prior_year_actual_amount"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend for budget lines. Used as the baseline for year-over-year budget variance analysis."
    - name: "budget_vs_prior_year_variance"
      expr: SUM((CAST(planned_amount AS DOUBLE)) - (CAST(prior_year_actual_amount AS DOUBLE)))
      comment: "Absolute variance between current budget plan and prior year actuals. Measures how aggressively the budget departs from historical performance."
    - name: "budget_vs_prior_year_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(planned_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(prior_year_actual_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between current budget and prior year actuals. Key planning quality metric — large deviations require justification in budget reviews."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage set for budget lines. Measures the tolerance bands established for budget monitoring and exception alerting."
    - name: "total_budget_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total planned quantity across budget lines. Used for volume-based budget planning (e.g., covers, room nights, headcount)."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across budget lines. Used to benchmark planned pricing assumptions against actuals."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items. Measures budget granularity and planning detail level."
    - name: "locked_line_count"
      expr: COUNT(CASE WHEN locked_flag = TRUE THEN 1 END)
      comment: "Number of locked budget lines. Measures budget finalization progress — high locked counts indicate budget is being closed for the period."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, debit/credit balances, intercompany activity, CapEx postings, and reversal rates — foundational for financial close quality and audit compliance."
  source: "`travel_hospitality_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the journal entry posting (e.g., Posted, Pending, Reversed) for financial close monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., Standard, Accrual, Reversal, Intercompany) for transaction classification."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the journal entry (e.g., PMS, POS, Payroll) for data lineage and reconciliation."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency of the journal entry for multi-currency ledger analysis."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Transaction currency of the journal entry for FX analysis."
    - name: "capex_indicator"
      expr: capex_indicator
      comment: "Indicates whether the journal entry relates to capital expenditure. Used to separate CapEx from OpEx in financial reporting."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates intercompany transactions requiring elimination in consolidated financial statements."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the journal entry is a reversal. High reversal rates signal close process quality issues."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of journal entry posting for period-based financial close analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount posted across journal entries. Used to verify ledger balance and measure transaction volume in the general ledger."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount posted across journal entries. Must equal total debits for a balanced ledger — imbalances trigger audit flags."
    - name: "net_debit_credit_balance"
      expr: SUM((CAST(debit_amount AS DOUBLE)) - (CAST(credit_amount AS DOUBLE)))
      comment: "Net difference between total debits and credits. Should be zero for a balanced ledger — non-zero values indicate posting errors requiring investigation."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Measures financial close activity volume and general ledger transaction throughput."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. Elevated reversal counts indicate close process errors or accrual management issues."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. A key financial close quality metric — high rates trigger process improvement reviews."
    - name: "capex_entry_count"
      expr: COUNT(CASE WHEN capex_indicator = TRUE THEN 1 END)
      comment: "Number of CapEx journal entries. Used to track capital investment activity and ensure proper CapEx vs. OpEx classification."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used to manage intercompany elimination in consolidated financial reporting."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across journal entries. Used to monitor FX translation assumptions in multi-currency ledgers."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_management_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hotel Management Agreement (HMA) fee metrics covering base and incentive fee amounts, fee rates, payment status, and reversal activity — critical for ownership entity reporting and HMA compliance monitoring."
  source: "`travel_hospitality_ecm`.`finance`.`management_fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of management fee (e.g., Base Management Fee, Incentive Management Fee) for fee structure analysis."
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the management fee (e.g., Calculated, Approved, Paid) for fee lifecycle tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the management fee for cash flow and collections monitoring."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis on which the fee is calculated (e.g., Total Revenue, GOP) for fee structure transparency."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the management fee for governance and HMA compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the management fee for multi-currency HMA analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates whether the fee is an intercompany transaction requiring elimination in consolidated statements."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the fee record is a reversal. Reversals may indicate fee disputes or HMA renegotiations."
    - name: "period_start_date_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month the fee period begins for trend analysis of management fee obligations over time."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total gross management fee amount. Primary metric for tracking management company compensation and HMA cost to ownership entities."
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net management fee after adjustments. Represents actual fee obligation — used in ownership entity financial reporting."
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total revenue or profit basis on which management fees are calculated. Used to verify fee calculation accuracy against HMA terms."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to management fees. Measures fee dispute resolutions and HMA amendment impacts."
    - name: "avg_fee_rate_percentage"
      expr: AVG(CAST(fee_rate_percentage AS DOUBLE))
      comment: "Average management fee rate percentage. Used to benchmark fee rates against HMA terms and industry norms."
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Total number of management fee records. Baseline metric for fee processing activity."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed management fee records. Reversals may indicate fee disputes or calculation errors requiring HMA review."
    - name: "effective_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(net_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(basis_amount AS DOUBLE)), 0), 2)
      comment: "Effective management fee rate as net fee divided by basis amount. Measures actual fee burden vs. contractual rate — deviations trigger HMA compliance review."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering asset book values, depreciation, impairment, disposal gains/losses, and CapEx pipeline — essential for property investment management and FF&E reserve planning."
  source: "`travel_hospitality_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset (e.g., FF&E, Building, Equipment) for asset portfolio analysis."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for depreciation and financial reporting classification."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g., Active, Disposed, Impaired) for asset lifecycle management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., Straight-Line, Declining Balance) for depreciation policy analysis."
    - name: "capex_approval_status"
      expr: capex_approval_status
      comment: "CapEx approval status for capital investment governance tracking."
    - name: "ffe_reserve_eligible"
      expr: ffe_reserve_eligible
      comment: "Indicates whether the asset is eligible for FF&E reserve funding — a key HMA and ownership entity planning dimension."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Indicates whether the asset has been identified as impaired. Impaired assets require write-downs affecting financial statements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset valuation for multi-currency asset reporting."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition for capital investment vintage analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets. Measures total capital invested in property assets — a key metric for ownership entity and lender reporting."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (cost minus accumulated depreciation). Represents the carrying value of the property asset base on the balance sheet."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all fixed assets. Measures the extent of asset aging and replacement need — drives FF&E reserve and PIP planning."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized on fixed assets. Impairment charges directly reduce profitability and signal asset value deterioration."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Used to track asset monetization and capital recycling activity."
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total net gain or loss on asset disposals. Impacts P&L and measures effectiveness of asset disposal decisions."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets on the register. Baseline metric for asset portfolio size and management complexity."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets identified as impaired. Elevated counts signal property condition issues or market value declines requiring management action."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Used to benchmark asset values and identify over/under-invested asset categories."
    - name: "depreciation_coverage_ratio"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost. Measures average asset age/utilization — high ratios indicate aging asset base requiring capital reinvestment."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics covering tax liabilities, effective tax rates, filing compliance, exemptions, and reversal activity — essential for tax compliance, regulatory reporting, and audit readiness."
  source: "`travel_hospitality_ecm`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., Sales Tax, Occupancy Tax, VAT, Service Charge) for tax liability analysis by tax category."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the posting for tax rate and jurisdiction analysis."
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction (state, county, city) for geographic tax liability analysis and multi-jurisdiction compliance."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code for tax authority reporting and remittance."
    - name: "filing_status"
      expr: filing_status
      comment: "Tax filing status (e.g., Filed, Pending, Overdue) for compliance monitoring and deadline management."
    - name: "exemption_indicator"
      expr: exemption_indicator
      comment: "Indicates whether the transaction is tax-exempt. Used to track exemption certificate compliance."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the tax posting is a reversal. Reversals may indicate amended returns or billing corrections."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document generating the tax posting (e.g., Invoice, POS Check, Reservation) for tax source analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of tax posting for period-based tax liability trend analysis."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month of tax filing for compliance calendar analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted. Primary tax liability metric for regulatory reporting and remittance planning."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total taxable base amount on which taxes are calculated. Used to verify tax calculation accuracy and effective rate analysis."
    - name: "effective_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(tax_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as total tax divided by taxable base. Measures actual tax burden vs. statutory rates — deviations trigger tax compliance reviews."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings. Baseline volume metric for tax transaction activity and compliance workload."
    - name: "exempt_posting_count"
      expr: COUNT(CASE WHEN exemption_indicator = TRUE THEN 1 END)
      comment: "Number of tax-exempt postings. Used to monitor exemption certificate compliance and audit exposure."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed tax postings. Elevated reversals may indicate billing errors or amended tax returns requiring investigation."
    - name: "exempt_amount"
      expr: SUM(CASE WHEN exemption_indicator = TRUE THEN CAST(tax_base_amount AS DOUBLE) ELSE 0 END)
      comment: "Total taxable base amount that was exempted from tax. Measures the scale of tax exemptions — a key audit and compliance risk indicator."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage applied across postings. Used to monitor rate consistency and detect incorrect rate applications."
$$;