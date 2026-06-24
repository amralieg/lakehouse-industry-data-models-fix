-- Metric views for domain: finance | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_premium_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for premium revenue performance — earned premium, written premium, net earned premium, reinsurance ceded, and risk-adjusted revenue trends by line of business, market segment, and fiscal period. Core to CFO and actuarial steering."
  source: "`vibe_health_insurance_v1`.`finance`.`premium_revenue`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the premium revenue record for year-over-year trend analysis."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for intra-year premium revenue trending."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period label for period-close reporting."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) for revenue segmentation."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g., Individual, Small Group, Large Group) for premium revenue breakdown."
    - name: "is_capitated"
      expr: is_capitated
      comment: "Flag indicating whether the revenue record is capitation-based vs. premium-based."
    - name: "mlr_denominator_flag"
      expr: mlr_denominator_flag
      comment: "Flag indicating whether this revenue record is included in the MLR denominator for regulatory reporting."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether this record is subject to regulatory reporting requirements."
    - name: "revenue_date"
      expr: DATE_TRUNC('month', revenue_date)
      comment: "Revenue recognition date truncated to month for time-series analysis."
  measures:
    - name: "total_written_premium"
      expr: SUM(CAST(written_premium AS DOUBLE))
      comment: "Total written premium — the gross premium committed for the period. Key top-line revenue indicator for CFO and underwriting leadership."
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium AS DOUBLE))
      comment: "Total earned premium — premium recognized as revenue for the period. Core MLR denominator and financial reporting KPI."
    - name: "total_net_earned_premium"
      expr: SUM(CAST(net_earned_premium AS DOUBLE))
      comment: "Total net earned premium after reinsurance cessions. Reflects the organization's retained premium exposure."
    - name: "total_reinsurance_ceded_premium"
      expr: SUM(CAST(reinsurance_ceded_premium AS DOUBLE))
      comment: "Total premium ceded to reinsurers. Measures risk transfer cost and reinsurance program utilization."
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation payments made to providers under capitated arrangements. Key for value-based care financial tracking."
    - name: "total_unearned_premium_reserve"
      expr: SUM(CAST(unearned_premium_reserve AS DOUBLE))
      comment: "Total unearned premium reserve — liability for premiums collected but not yet earned. Critical for balance sheet accuracy."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across revenue records. Indicates the risk profile of the enrolled population relative to the market average."
    - name: "reinsurance_cession_rate"
      expr: ROUND(100.0 * SUM(CAST(reinsurance_ceded_premium AS DOUBLE)) / NULLIF(SUM(CAST(written_premium AS DOUBLE)), 0), 2)
      comment: "Percentage of written premium ceded to reinsurers. Measures reinsurance program scale and risk transfer efficiency."
    - name: "net_retention_rate"
      expr: ROUND(100.0 * SUM(CAST(net_earned_premium AS DOUBLE)) / NULLIF(SUM(CAST(earned_premium AS DOUBLE)), 0), 2)
      comment: "Percentage of earned premium retained after reinsurance. Measures net risk retention relative to gross exposure."
    - name: "premium_revenue_record_count"
      expr: COUNT(1)
      comment: "Count of premium revenue records for volume and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_mlr_financial_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio (MLR) financial KPIs — incurred claims, earned premium, quality improvement expenses, rebate liability, and MLR percentage by line of business, market segment, and reporting year. Directly drives ACA regulatory compliance and rebate obligations."
  source: "`vibe_health_insurance_v1`.`finance`.`mlr_financial_entry`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for MLR calculation — used for year-over-year regulatory compliance tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid) for MLR segmentation per ACA requirements."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) — MLR thresholds differ by segment."
    - name: "state_code"
      expr: state_code
      comment: "State code for state-level MLR reporting and rebate calculation."
    - name: "mlr_financial_entry_status"
      expr: mlr_financial_entry_status
      comment: "Status of the MLR financial entry (e.g., Draft, Submitted, Final) for workflow tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Regulatory submission status for MLR filing compliance monitoring."
    - name: "calculation_date"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "MLR calculation date truncated to month for trend analysis."
  measures:
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims amount — the numerator of the MLR calculation. Directly drives rebate obligations and regulatory compliance."
    - name: "total_earned_premium"
      expr: SUM(CAST(total_earned_premium AS DOUBLE))
      comment: "Total earned premium — the MLR denominator. Required for ACA MLR ratio computation."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement expenses — added to incurred claims in the MLR numerator per ACA rules."
    - name: "total_rebate_liability"
      expr: SUM(CAST(rebate_liability_amount AS DOUBLE))
      comment: "Total MLR rebate liability owed to members/employers when MLR falls below regulatory threshold. Key financial obligation metric."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across entries. Indicates whether the organization is meeting ACA minimum MLR thresholds."
    - name: "avg_minimum_mlr_threshold"
      expr: AVG(CAST(minimum_mlr_threshold AS DOUBLE))
      comment: "Average minimum MLR threshold applicable to the entries — used to assess compliance headroom."
    - name: "mlr_compliance_gap"
      expr: ROUND(AVG(CAST(mlr_percentage AS DOUBLE)) - AVG(CAST(minimum_mlr_threshold AS DOUBLE)), 4)
      comment: "Average gap between actual MLR percentage and the minimum regulatory threshold. Positive = compliant; negative = rebate trigger. Critical regulatory KPI."
    - name: "entries_below_threshold"
      expr: COUNT(CASE WHEN mlr_percentage < minimum_mlr_threshold THEN 1 END)
      comment: "Count of MLR entries where actual MLR is below the regulatory minimum — each represents a rebate obligation trigger."
    - name: "mlr_entry_count"
      expr: COUNT(1)
      comment: "Total count of MLR financial entries for coverage and completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_actuarial_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial reserve KPIs — reserve estimates, paid claims, LAE, total liability, and confidence intervals by reserve type, line of business, and development method. Essential for CFO, Chief Actuary, and regulatory solvency reporting."
  source: "`vibe_health_insurance_v1`.`finance`.`actuarial_reserve`"
  dimensions:
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of actuarial reserve (e.g., IBNR, IBNER, Unearned Premium) for reserve category analysis."
    - name: "reserve_period"
      expr: reserve_period
      comment: "Reserve period (e.g., Q1 2024) for period-over-period reserve development tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for reserve segmentation — required for statutory and GAAP reporting."
    - name: "product_type"
      expr: product_type
      comment: "Product type (e.g., HMO, PPO, PDP) for reserve analysis by product."
    - name: "development_method"
      expr: development_method
      comment: "Actuarial development method used (e.g., Chain Ladder, Bornhuetter-Ferguson) for methodology transparency."
    - name: "actuarial_reserve_status"
      expr: actuarial_reserve_status
      comment: "Status of the reserve record (e.g., Draft, Final, Approved) for workflow and audit tracking."
    - name: "mlr_flag"
      expr: mlr_flag
      comment: "Flag indicating whether this reserve is included in MLR calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency reserve reporting."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Reserve effective start date truncated to quarter for trend analysis."
  measures:
    - name: "total_reserve_estimate"
      expr: SUM(CAST(reserve_estimate_amount AS DOUBLE))
      comment: "Total actuarial reserve estimate — the central estimate of future claim liabilities. Core solvency and balance sheet KPI."
    - name: "total_liability"
      expr: SUM(CAST(total_liability_amount AS DOUBLE))
      comment: "Total liability amount including all reserve components. Key balance sheet and regulatory capital metric."
    - name: "total_paid_claims"
      expr: SUM(CAST(paid_claims_amount AS DOUBLE))
      comment: "Total paid claims amount used in reserve development. Measures actual claims experience vs. reserve estimates."
    - name: "total_paid_lae"
      expr: SUM(CAST(paid_lae_amount AS DOUBLE))
      comment: "Total paid loss adjustment expenses — administrative costs of settling claims included in reserve calculations."
    - name: "avg_confidence_interval_high"
      expr: AVG(CAST(confidence_interval_high AS DOUBLE))
      comment: "Average upper bound of the actuarial confidence interval — measures reserve adequacy risk at the high end."
    - name: "avg_confidence_interval_low"
      expr: AVG(CAST(confidence_interval_low AS DOUBLE))
      comment: "Average lower bound of the actuarial confidence interval — measures reserve adequacy risk at the low end."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to reserves — indicates population risk profile used in reserve development."
    - name: "reserve_development_ratio"
      expr: ROUND(SUM(CAST(reserve_estimate_amount AS DOUBLE)) / NULLIF(SUM(CAST(paid_claims_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of reserve estimate to paid claims — measures reserve adequacy relative to actual claims experience. Values significantly above 1.0 may indicate over-reserving."
    - name: "reserve_record_count"
      expr: COUNT(1)
      comment: "Count of actuarial reserve records for completeness and audit coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice KPIs — gross payables, net payables, tax, discounts, void rates, and approval cycle metrics by invoice type, line of business, and vendor. Drives AP efficiency, cash management, and vendor payment compliance."
  source: "`vibe_health_insurance_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g., Standard, Credit Memo, Prepayment) for payables categorization."
    - name: "ap_invoice_status"
      expr: ap_invoice_status
      comment: "Current status of the invoice (e.g., Pending, Approved, Paid, Void) for AP workflow monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice for internal controls and audit compliance."
    - name: "payment_status"
      expr: CAST(payment_status AS STRING)
      comment: "Payment status of the invoice for cash flow and aging analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the invoice for cost allocation and LOB P&L reporting."
    - name: "division_code"
      expr: division_code
      comment: "Division code for organizational cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency AP reporting."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating whether the invoice has been voided — used for AP integrity monitoring."
    - name: "gl_posting_flag"
      expr: gl_posting_flag
      comment: "Flag indicating whether the invoice has been posted to the general ledger."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for AP volume and aging trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Invoice due date truncated to month for cash flow forecasting."
  measures:
    - name: "total_gross_payables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount — top-line payables obligation. Core cash management and vendor spend KPI."
    - name: "total_net_payables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts and adjustments. Reflects actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices — required for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured on AP invoices. Measures AP efficiency and discount capture rate."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total count of AP invoices for volume and throughput analysis."
    - name: "void_invoice_count"
      expr: COUNT(CASE WHEN void_flag = TRUE THEN 1 END)
      comment: "Count of voided AP invoices — elevated void rates may indicate process errors or fraud risk."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AP invoices that were voided. High void rates signal AP process quality issues."
    - name: "unposted_invoice_count"
      expr: COUNT(CASE WHEN gl_posting_flag = FALSE THEN 1 END)
      comment: "Count of AP invoices not yet posted to the GL — measures period-close completeness risk."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross AP invoice amount — useful for detecting anomalous invoice sizes and vendor spend patterns."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payables captured as early payment discounts. Measures AP efficiency and working capital optimization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment KPIs — gross payments, net payments, discounts, tax, foreign currency exposure, and reconciliation status. Drives cash disbursement management, vendor payment compliance, and treasury operations."
  source: "`vibe_health_insurance_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "ap_payment_status"
      expr: CAST(ap_payment_status AS STRING)
      comment: "Payment status for AP disbursement workflow monitoring."
    - name: "payment_type"
      expr: CAST(payment_type AS STRING)
      comment: "Type of payment (e.g., Check, ACH, Wire) for payment channel analysis."
    - name: "payment_method"
      expr: CAST(payment_method AS STRING)
      comment: "Payment method for disbursement channel reporting."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for cost allocation and LOB cash flow reporting."
    - name: "division_code"
      expr: division_code
      comment: "Division code for organizational cash disbursement tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency payment reporting."
    - name: "is_foreign_currency"
      expr: is_foreign_currency
      comment: "Flag indicating foreign currency payments — drives FX exposure and hedging analysis."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating whether the payment has been bank-reconciled — critical for period-close accuracy."
    - name: "void_flag"
      expr: void_flag
      comment: "Flag indicating voided payments — elevated void rates signal disbursement process issues."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt payments for tax compliance reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month for cash disbursement trend analysis."
  measures:
    - name: "total_gross_payments"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP payments disbursed — primary cash outflow KPI for treasury and CFO reporting."
    - name: "total_net_payments"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP payments after discounts and tax adjustments. Reflects actual cash disbursed."
    - name: "total_tax_paid"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts paid on AP disbursements — required for tax compliance and 1099 reporting."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken — measures working capital optimization through prompt payment."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total count of AP payments for disbursement volume and throughput analysis."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Count of AP payments not yet bank-reconciled — measures period-close risk and treasury reconciliation backlog."
    - name: "unreconciled_payment_amount"
      expr: SUM(CASE WHEN is_reconciled = FALSE THEN gross_amount ELSE 0 END)
      comment: "Total gross amount of unreconciled AP payments — quantifies the financial exposure from outstanding reconciliation items."
    - name: "foreign_currency_payment_amount"
      expr: SUM(CASE WHEN is_foreign_currency = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total gross amount of foreign currency AP payments — measures FX exposure in the AP portfolio."
    - name: "void_payment_count"
      expr: COUNT(CASE WHEN void_flag = TRUE THEN 1 END)
      comment: "Count of voided AP payments — elevated counts indicate disbursement process errors or fraud risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross AP payment amount — used for anomaly detection and vendor payment pattern analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice KPIs — gross receivables, net receivables, unapplied amounts, write-offs, and collection performance by billing cycle, party type, and line of business. Drives revenue cycle management and cash collection efficiency."
  source: "`vibe_health_insurance_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "Current status of the AR invoice (e.g., Open, Paid, Overdue, Written Off) for receivables aging and collection management."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle (e.g., Monthly, Quarterly) for revenue cycle cadence analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for receivables aging and collections team prioritization."
    - name: "party_type"
      expr: party_type
      comment: "Type of billing party (e.g., Employer Group, Individual, Government) for receivables segmentation."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for AR segmentation and LOB revenue cycle reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency AR reporting."
    - name: "is_void"
      expr: is_void
      comment: "Flag indicating voided AR invoices — used for revenue integrity monitoring."
    - name: "is_written_off"
      expr: is_written_off
      comment: "Flag indicating written-off AR invoices — measures bad debt and collection failure rate."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for AR volume and aging trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Invoice due date truncated to month for cash flow forecasting and aging bucket analysis."
  measures:
    - name: "total_gross_receivables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR invoice amount — top-line receivables balance. Core revenue cycle and cash flow KPI."
    - name: "total_net_receivables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR invoice amount after discounts and adjustments. Reflects expected cash collections."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash on AR invoices — measures unmatched payments requiring cash application work."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices for tax liability and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices — measures revenue leakage from billing adjustments."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total count of AR invoices for billing volume and revenue cycle throughput analysis."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN is_written_off = TRUE THEN 1 END)
      comment: "Count of written-off AR invoices — measures bad debt incidence and collection failure."
    - name: "written_off_amount"
      expr: SUM(CASE WHEN is_written_off = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total gross amount written off — quantifies bad debt expense and collection program effectiveness."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_written_off = TRUE THEN gross_amount ELSE 0 END) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross AR written off as bad debt. High rates indicate collection program deficiencies or billing quality issues."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross AR that remains unapplied — measures cash application backlog and revenue recognition risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ar_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable cash receipt KPIs — total receipts, unapplied cash, reversals, foreign currency exposure, and receipt method mix. Drives cash collection performance, lockbox efficiency, and revenue cycle closure."
  source: "`vibe_health_insurance_v1`.`finance`.`ar_receipt`"
  dimensions:
    - name: "ar_receipt_status"
      expr: ar_receipt_status
      comment: "Status of the AR receipt (e.g., Applied, Unapplied, Reversed) for cash application workflow monitoring."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (e.g., Check, ACH, Wire, Lockbox) for payment channel analysis."
    - name: "party_type"
      expr: party_type
      comment: "Type of paying party (e.g., Employer, Individual, Government) for cash collection segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency cash receipt reporting."
    - name: "is_foreign_currency"
      expr: is_foreign_currency
      comment: "Flag indicating foreign currency receipts — drives FX exposure analysis."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating reversed receipts — elevated reversal rates signal payment processing issues."
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating locked receipts — used for period-close and audit integrity monitoring."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Receipt date truncated to month for cash collection trend analysis."
    - name: "deposit_date_month"
      expr: DATE_TRUNC('month', deposit_date)
      comment: "Deposit date truncated to month for bank deposit timing and float analysis."
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(receipt_amount AS DOUBLE))
      comment: "Total cash received — primary cash collection KPI for treasury and revenue cycle management."
    - name: "total_net_receipt_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receipt amount after discounts and adjustments. Reflects actual cash applied to AR."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash — measures cash application backlog and revenue recognition risk."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts taken on receipts — measures early payment discount utilization."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total count of AR receipts for cash collection volume and throughput analysis."
    - name: "reversed_receipt_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Count of reversed AR receipts — elevated counts indicate payment processing or banking errors."
    - name: "reversed_receipt_amount"
      expr: SUM(CASE WHEN is_reversed = TRUE THEN receipt_amount ELSE 0 END)
      comment: "Total amount of reversed receipts — quantifies cash collection reversals impacting net collections."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(receipt_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total receipts remaining unapplied — measures cash application efficiency and AR closure rate."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reversed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AR receipts that were reversed — high rates indicate payment processing quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry KPIs — total debits, credits, net amounts, intercompany volumes, posting status, and period-close completeness. Core financial reporting integrity and period-close management KPIs for Controller and CFO."
  source: "`vibe_health_insurance_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g., Standard, Adjusting, Reversing, Intercompany) for GL activity categorization."
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the journal entry (e.g., Draft, Posted, Reversed) for period-close workflow monitoring."
    - name: "posting_status"
      expr: posting_status
      comment: "GL posting status for period-close completeness and financial reporting readiness."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for internal controls and SOX compliance monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year GL activity analysis."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for period-close and monthly financial reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for period-close completeness tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for LOB P&L and cost allocation reporting."
    - name: "source_module"
      expr: source_module
      comment: "Source system module (e.g., Claims, Billing, Payroll) that generated the journal entry — for subledger reconciliation."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag indicating intercompany journal entries — used for elimination and consolidation analysis."
    - name: "is_budgeted"
      expr: is_budgeted
      comment: "Flag indicating whether the entry is budget-related for budget vs. actual variance analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entries — measures gross GL activity and financial transaction volume."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entries — paired with debits for GL balance verification."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net journal entry amount — measures net financial impact of GL activity for the period."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total count of journal entries — measures GL activity volume and period-close workload."
    - name: "unposted_entry_count"
      expr: COUNT(CASE WHEN posting_status != 'Posted' THEN 1 END)
      comment: "Count of journal entries not yet posted to the GL — measures period-close completeness risk."
    - name: "unapproved_entry_count"
      expr: COUNT(CASE WHEN approval_status != 'Approved' THEN 1 END)
      comment: "Count of journal entries pending approval — measures internal controls compliance and SOX risk."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN is_intercompany = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries — used for consolidation elimination completeness monitoring."
    - name: "intercompany_net_amount"
      expr: SUM(CASE WHEN is_intercompany = TRUE THEN net_amount ELSE 0 END)
      comment: "Total net amount of intercompany journal entries — measures intercompany balance exposure requiring elimination."
    - name: "debit_credit_balance_check"
      expr: ROUND(SUM(CAST(total_debit_amount AS DOUBLE)) - SUM(CAST(total_credit_amount AS DOUBLE)), 2)
      comment: "Difference between total debits and credits — should be zero for a balanced GL. Non-zero values indicate posting errors requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance KPIs — total budgeted amounts, actual variances, prior year comparisons, and budget utilization by department, division, and line of business. Drives financial planning, variance analysis, and resource allocation decisions."
  source: "`vibe_health_insurance_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Operating, Capital, Project) for budget category analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget (e.g., Draft, Approved, Active, Closed) for budget lifecycle monitoring."
    - name: "fiscal_year"
      expr: year
      comment: "Fiscal year of the budget for year-over-year planning and variance analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental budget allocation and variance reporting."
    - name: "division_code"
      expr: division_code
      comment: "Division code for divisional budget performance reporting."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for LOB budget allocation and P&L management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency budget reporting."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Budget effective start date truncated to year for annual budget cycle analysis."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(total_budgeted_amount AS DOUBLE))
      comment: "Total approved budget amount — primary financial planning KPI for CFO and department heads."
    - name: "total_adjusted_budget"
      expr: SUM(CAST(total_adjusted_amount AS DOUBLE))
      comment: "Total budget after mid-year adjustments — reflects current authorized spending authority."
    - name: "total_net_budget"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net budget amount after all adjustments — used for final budget vs. actual variance reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. budget) — primary financial performance indicator for management review."
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend — used for year-over-year budget growth and trend analysis."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Count of budget records for budget coverage and completeness monitoring."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average budget variance per budget record — identifies departments with systematic over/under-spending patterns."
    - name: "budget_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as a percentage of total budgeted amount — measures overall budget execution accuracy. Negative = over-budget; positive = under-budget."
    - name: "yoy_budget_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(total_budgeted_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(prior_year_actual_amount AS DOUBLE)), 0), 2)
      comment: "Year-over-year budget growth percentage vs. prior year actuals — measures financial planning ambition and cost trajectory."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation KPIs — reconciled balances, outstanding items, deposits in transit, unreconciled amounts, and reconciliation completion rates. Critical for treasury integrity, period-close accuracy, and fraud detection."
  source: "`vibe_health_insurance_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the bank reconciliation (e.g., In Progress, Completed, Approved) for period-close monitoring."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., Monthly, Weekly, Daily) for reconciliation cadence analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the reconciliation for internal controls and SOX compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency reconciliation reporting."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Flag indicating whether the reconciliation required adjustments — used for reconciliation quality monitoring."
    - name: "reconciliation_period_start"
      expr: DATE_TRUNC('month', reconciliation_period_start)
      comment: "Reconciliation period start date truncated to month for trend analysis."
  measures:
    - name: "total_bank_statement_balance"
      expr: SUM(CAST(bank_statement_balance AS DOUBLE))
      comment: "Total bank statement balance across reconciliations — measures total cash per bank records."
    - name: "total_gl_balance"
      expr: SUM(CAST(gl_balance AS DOUBLE))
      comment: "Total GL cash balance across reconciliations — paired with bank balance for reconciliation gap analysis."
    - name: "total_reconciled_balance"
      expr: SUM(CAST(reconciled_balance AS DOUBLE))
      comment: "Total reconciled cash balance — the agreed-upon balance after reconciling items. Core treasury KPI."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared — measures float and timing differences in cash position."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_amount AS DOUBLE))
      comment: "Total deposits in transit not yet reflected in bank statement — measures timing differences in cash receipts."
    - name: "total_unreconciled_items"
      expr: SUM(CAST(unreconciled_items_amount AS DOUBLE))
      comment: "Total amount of unreconciled items — measures reconciliation quality and potential fraud or error exposure."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total count of bank reconciliations for coverage and completeness monitoring."
    - name: "unreconciled_reconciliation_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Completed' THEN 1 END)
      comment: "Count of incomplete bank reconciliations — measures period-close risk and treasury backlog."
    - name: "gl_bank_variance"
      expr: ROUND(SUM(CAST(gl_balance AS DOUBLE)) - SUM(CAST(bank_statement_balance AS DOUBLE)), 2)
      comment: "Difference between GL balance and bank statement balance — should approach zero after reconciling items. Large variances indicate errors or fraud risk."
    - name: "reconciliation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bank reconciliations completed — measures period-close readiness and treasury operational efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_reinsurance_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance transaction KPIs — ceded premiums, ceded losses, recoveries, net amounts, and settlement status. Drives reinsurance program performance monitoring, risk transfer effectiveness, and SAP Schedule F compliance."
  source: "`vibe_health_insurance_v1`.`finance`.`reinsurance_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of reinsurance transaction (e.g., Cession, Assumption, Recovery) for reinsurance program analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the reinsurance transaction for settlement tracking and financial reporting."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the reinsurance transaction — measures reinsurance receivable collection performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency reinsurance reporting."
    - name: "is_ceded"
      expr: is_ceded
      comment: "Flag indicating ceded reinsurance transactions — used to separate ceded vs. assumed activity."
    - name: "is_assumed"
      expr: is_assumed
      comment: "Flag indicating assumed reinsurance transactions — measures reinsurance income from assumption activity."
    - name: "is_stop_loss"
      expr: is_stop_loss
      comment: "Flag indicating stop-loss reinsurance transactions — critical for catastrophic risk management reporting."
    - name: "sap_schedule_f_flag"
      expr: sap_schedule_f_flag
      comment: "Flag indicating transactions reportable on SAP Schedule F — required for statutory financial reporting."
    - name: "coverage_start_date_month"
      expr: DATE_TRUNC('month', coverage_start_date)
      comment: "Coverage start date truncated to month for reinsurance program timeline analysis."
  measures:
    - name: "total_ceded_premium"
      expr: SUM(CAST(ceded_premium_amount AS DOUBLE))
      comment: "Total premium ceded to reinsurers — measures reinsurance program cost and risk transfer scale."
    - name: "total_ceded_loss"
      expr: SUM(CAST(ceded_loss_amount AS DOUBLE))
      comment: "Total losses ceded to reinsurers — measures reinsurance recovery on claims. Key risk transfer effectiveness KPI."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total reinsurance recoveries received — measures actual cash recovered from reinsurers vs. ceded losses."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net reinsurance transaction amount — reflects net financial impact after cessions and recoveries."
    - name: "total_rbc_credit"
      expr: SUM(CAST(rbc_credit_amount AS DOUBLE))
      comment: "Total risk-based capital credit from reinsurance — measures regulatory capital relief from reinsurance program."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total count of reinsurance transactions for program volume and activity monitoring."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(ceded_loss_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of ceded losses actually recovered from reinsurers — measures reinsurance collection effectiveness."
    - name: "loss_ratio_on_ceded_business"
      expr: ROUND(100.0 * SUM(CAST(ceded_loss_amount AS DOUBLE)) / NULLIF(SUM(CAST(ceded_premium_amount AS DOUBLE)), 0), 2)
      comment: "Loss ratio on ceded reinsurance business — measures whether reinsurance is being utilized relative to premium ceded."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor on reinsurance transactions — measures population risk profile driving reinsurance utilization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_vbc_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care settlement KPIs — actual vs. benchmark expenditures, savings, shared savings percentages, quality scores, and settlement status. Drives VBC program performance evaluation and provider incentive management."
  source: "`vibe_health_insurance_v1`.`finance`.`vbc_settlement`"
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of VBC settlement (e.g., Shared Savings, Shared Risk, Capitation) for VBC program model analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Status of the VBC settlement (e.g., Pending, Final, Paid) for settlement lifecycle monitoring."
    - name: "is_shared_risk"
      expr: is_shared_risk
      comment: "Flag indicating shared risk arrangements — used to separate upside-only from two-sided risk models."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency VBC settlement reporting."
    - name: "performance_period_start"
      expr: DATE_TRUNC('year', performance_period_start)
      comment: "VBC performance period start date truncated to year for annual program cycle analysis."
  measures:
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure under VBC arrangements — measures realized cost of care for attributed populations."
    - name: "total_benchmark_expenditure"
      expr: SUM(CAST(benchmark_expenditure_amount AS DOUBLE))
      comment: "Total benchmark expenditure target — the expected cost of care used to calculate VBC savings or losses."
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total savings generated under VBC arrangements — primary VBC program performance KPI for CFO and CMO."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement payments to/from providers — measures actual financial impact of VBC program outcomes."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Total count of VBC settlements for program coverage and activity monitoring."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC settlements — measures clinical quality performance driving shared savings eligibility."
    - name: "avg_shared_savings_percentage"
      expr: AVG(CAST(shared_savings_percentage AS DOUBLE))
      comment: "Average shared savings percentage across VBC contracts — measures provider incentive generosity and program design."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to VBC settlements — measures population risk profile used in benchmark setting."
    - name: "savings_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_amount AS DOUBLE)), 0), 2)
      comment: "Savings as a percentage of benchmark expenditure — measures VBC program efficiency and cost reduction effectiveness."
    - name: "expenditure_vs_benchmark_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_amount AS DOUBLE)), 0), 2)
      comment: "Actual expenditure as a percentage of benchmark — values below 100% indicate savings; above 100% indicate losses. Core VBC performance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset KPIs — acquisition cost, accumulated depreciation, net book value, disposal proceeds, and asset utilization by category, depreciation method, and status. Drives capital asset management, depreciation planning, and balance sheet accuracy."
  source: "`vibe_health_insurance_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of fixed asset (e.g., IT Equipment, Furniture, Leasehold Improvements) for capital asset portfolio analysis."
    - name: "asset_status"
      expr: asset_status
      comment: "Status of the fixed asset (e.g., Active, Disposed, Fully Depreciated) for asset lifecycle management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (e.g., Straight-Line, Declining Balance) for depreciation policy analysis."
    - name: "asset_condition"
      expr: asset_condition
      comment: "Physical condition of the asset for maintenance planning and replacement forecasting."
    - name: "location_code"
      expr: location_code
      comment: "Location code for asset tracking and physical inventory management."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Asset acquisition date truncated to year for capital expenditure vintage analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets — measures gross capital investment. Core balance sheet and CapEx KPI."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures the portion of capital investment already expensed. Key for net book value and asset age analysis."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — the carrying value on the balance sheet after depreciation."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of fixed assets — used in depreciation calculations and disposal planning."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures capital recovery from asset sales and retirements."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total count of fixed assets for asset portfolio size and inventory completeness monitoring."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — measures average remaining asset value and portfolio age."
    - name: "depreciation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost already depreciated — measures asset age and replacement planning urgency. High percentages indicate aging asset base."
    - name: "disposal_gain_loss"
      expr: ROUND(SUM(CAST(disposal_proceeds AS DOUBLE)) - SUM(CAST(net_book_value AS DOUBLE)), 2)
      comment: "Estimated gain or loss on asset disposals (proceeds minus net book value) — measures capital recovery efficiency from asset disposals."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax filing KPIs — tax liability, estimated payments, final tax due, filing compliance rates, and amendment rates by tax type, jurisdiction, and legal entity. Drives tax compliance management and regulatory risk monitoring."
  source: "`vibe_health_insurance_v1`.`finance`.`tax_filing`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., Federal Income, State Premium, Payroll) for tax obligation categorization."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for regulatory reporting and compliance tracking."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction (state/federal) for multi-jurisdiction tax compliance monitoring."
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the tax filing (e.g., Filed, Pending, Overdue, Amended) for compliance deadline monitoring."
    - name: "filing_method"
      expr: filing_method
      comment: "Filing method (e.g., Electronic, Paper) for e-filing adoption and compliance efficiency analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for year-over-year tax liability trend analysis."
    - name: "is_amended"
      expr: is_amended
      comment: "Flag indicating amended tax filings — elevated amendment rates signal tax reporting quality issues."
    - name: "is_filed"
      expr: is_filed
      comment: "Flag indicating whether the tax filing has been submitted — used for compliance deadline monitoring."
    - name: "filing_date_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Filing date truncated to month for tax filing activity trend analysis."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability across all filings — primary tax obligation KPI for CFO and tax department."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — measures the revenue/income subject to taxation across all jurisdictions."
    - name: "total_estimated_payments"
      expr: SUM(CAST(estimated_payments_amount AS DOUBLE))
      comment: "Total estimated tax payments made — measures prepayment adequacy vs. final tax liability."
    - name: "total_final_tax_due"
      expr: SUM(CAST(final_tax_due_amount AS DOUBLE))
      comment: "Total final tax due after estimated payments — measures remaining tax payment obligations."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total tax payments made — measures actual cash outflow for tax obligations."
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Total count of tax filings for compliance coverage and workload monitoring."
    - name: "unfiled_count"
      expr: COUNT(CASE WHEN is_filed = FALSE THEN 1 END)
      comment: "Count of tax filings not yet submitted — measures compliance deadline risk and potential penalty exposure."
    - name: "amended_filing_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Count of amended tax filings — elevated counts indicate tax reporting quality issues or audit triggers."
    - name: "filing_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax filings submitted on time — core tax compliance KPI for regulatory risk management."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_liability_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable base — measures overall tax burden and planning effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial regulatory filing KPIs — tax liabilities, estimated payments, filing compliance, amendment rates, and submission timeliness by filing type, jurisdiction, and regulatory body. Drives regulatory compliance and penalty risk management."
  source: "`vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., Annual Statement, Premium Tax, MLR Report) for compliance categorization."
    - name: "filing_category"
      expr: filing_category
      comment: "Category of the regulatory filing for compliance program management."
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the regulatory filing (e.g., Draft, Submitted, Accepted, Rejected) for compliance deadline monitoring."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (e.g., CMS, State DOI, IRS) for multi-regulator compliance tracking."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code for state/federal regulatory filing compliance monitoring."
    - name: "filing_submission_method"
      expr: filing_submission_method
      comment: "Submission method (e.g., Electronic, Paper) for e-filing adoption tracking."
    - name: "filing_is_amended"
      expr: filing_is_amended
      comment: "Flag indicating amended regulatory filings — elevated amendment rates signal reporting quality issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency regulatory filing reporting."
    - name: "filing_period_start"
      expr: DATE_TRUNC('year', filing_period_start)
      comment: "Filing period start date truncated to year for annual regulatory compliance cycle analysis."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability reported in regulatory filings — measures financial obligation to regulatory bodies."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount reported — measures the financial base subject to regulatory taxation."
    - name: "total_estimated_payment"
      expr: SUM(CAST(estimated_payment_amount AS DOUBLE))
      comment: "Total estimated payments reported in regulatory filings — measures prepayment adequacy."
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Total count of regulatory filings for compliance coverage monitoring."
    - name: "amended_filing_count"
      expr: COUNT(CASE WHEN filing_is_amended = TRUE THEN 1 END)
      comment: "Count of amended regulatory filings — elevated counts indicate reporting quality issues or regulatory scrutiny."
    - name: "submitted_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Submitted' THEN 1 END)
      comment: "Count of submitted regulatory filings — measures compliance program execution."
    - name: "filing_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status IN ('Submitted', 'Accepted') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings successfully submitted — core compliance KPI for regulatory risk management."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings that required amendment — measures initial filing accuracy and regulatory audit risk."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_liability_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate on regulatory filings — measures overall regulatory tax burden by jurisdiction and filing type."
$$;