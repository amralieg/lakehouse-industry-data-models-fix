-- Metric views for domain: finance | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line financial performance metrics tracking allocated, committed, actual, and revised spend with variance analysis across campaigns, channels, and cost categories. Enables budget stewardship and spend governance decisions."
  source: "`advertising_ecm`.`finance`.`budget_line`"
  filter: is_active = TRUE
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Media or service channel type (e.g. Display, Search, Social) for budget segmentation."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost classification (e.g. Media, Production, Agency Fee) for spend categorisation."
    - name: "billing_category"
      expr: billing_category
      comment: "Billing classification used for client invoicing and revenue recognition alignment."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the budget line (e.g. Pending, Approved, Rejected)."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the budget line, enabling multi-currency analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the budget line is billable to the client."
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month in which the budget line was approved, for trend analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all active budget lines. Core budget envelope KPI used in financial planning reviews."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (purchase orders / IO commitments) against budget lines. Indicates financial obligation exposure."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend recorded against budget lines. Primary cost-tracking KPI for campaign financial management."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after change orders and re-forecasts. Reflects current approved budget envelope."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (allocated minus actual). Negative values indicate overspend; positive values indicate underspend."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage applied across budget lines. Informs agency margin and pricing strategy reviews."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines. Signals systemic over- or under-estimation in budget planning."
    - name: "count_budget_lines"
      expr: COUNT(1)
      comment: "Total number of active budget lines. Baseline volume metric for budget governance and workload assessment."
    - name: "count_approved_lines"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of budget lines in Approved status. Tracks approval pipeline throughput and governance compliance."
    - name: "count_overspent_lines"
      expr: COUNT(CASE WHEN variance_amount < 0 THEN 1 END)
      comment: "Number of budget lines where actual spend exceeds allocation. Flags financial risk requiring immediate management attention."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_client_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client invoice financial metrics covering billing performance, collections efficiency, outstanding receivables, and revenue cycle health. Critical for cash flow management and client financial relationship oversight."
  source: "`advertising_ecm`.`finance`.`client_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Sent, Paid, Disputed, Overdue)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice type (e.g. Media, Production, Retainer) for revenue stream analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the invoice, enabling multi-currency receivables analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified on the invoice (e.g. Wire, ACH, Check)."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) for DSO and collections analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued, for billing volume and revenue trend analysis."
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start date of the billing period covered by the invoice."
    - name: "billing_period_end_date"
      expr: billing_period_end_date
      comment: "End date of the billing period covered by the invoice."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross invoiced amount across all client invoices. Primary revenue billing KPI for financial reporting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected from clients. Measures cash collection performance against billed revenue."
    - name: "total_amount_outstanding"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total outstanding receivables balance. Critical cash flow and credit risk KPI monitored by CFO and finance leadership."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across invoices. Required for tax compliance reporting and reconciliation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted to clients. Informs pricing strategy and margin erosion analysis."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total invoice adjustments (credits, corrections). High values signal billing quality issues requiring process improvement."
    - name: "count_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline billing volume metric for capacity and revenue cycle planning."
    - name: "count_disputed_invoices"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of invoices with an active dispute. Elevated counts signal client satisfaction or billing accuracy issues."
    - name: "count_paid_invoices"
      expr: COUNT(CASE WHEN invoice_status = 'Paid' THEN 1 END)
      comment: "Number of fully paid invoices. Used to compute collection rate and assess billing cycle effectiveness."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value. Tracks deal size trends and informs revenue forecasting models."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance budget metrics providing a strategic view of budget allocation, approval, utilisation, and variance across campaigns, cost centres, and fiscal periods. Supports annual planning, re-forecasting, and budget governance."
  source: "`advertising_ecm`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of budget (e.g. Campaign, Overhead, Retainer) for portfolio-level financial analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (e.g. Media, Production, Agency Fee) for spend mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the budget (e.g. Draft, Approved, Locked)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for in-year budget tracking and re-forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency budget consolidation."
    - name: "lock_status"
      expr: lock_status
      comment: "Indicates whether the budget is locked (no further modifications permitted)."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the budget is effective, for temporal budget analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all finance budgets. Primary budget envelope KPI for executive financial planning."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total formally approved budget. Difference from allocated amount reveals pending approval exposure."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total spend recorded against budgets. Core budget utilisation KPI for financial stewardship."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining budget balance. Negative values indicate budget overruns requiring executive intervention."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance tolerance threshold set on budgets. Informs risk appetite and budget control policy calibration."
    - name: "count_budgets"
      expr: COUNT(1)
      comment: "Total number of finance budgets. Baseline volume for budget governance and portfolio complexity assessment."
    - name: "count_approved_budgets"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of budgets in Approved status. Tracks approval pipeline health and readiness for campaign execution."
    - name: "count_locked_budgets"
      expr: COUNT(CASE WHEN lock_status = TRUE THEN 1 END)
      comment: "Number of locked budgets. Indicates financial period close progress and budget freeze compliance."
    - name: "count_overrun_budgets"
      expr: COUNT(CASE WHEN remaining_amount < 0 THEN 1 END)
      comment: "Number of budgets where spend exceeds allocation. Critical risk indicator for financial governance reviews."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_media_cost_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media cost reconciliation metrics tracking planned vs. actual media spend, impression delivery accuracy, CPM variance, and dispute resolution. Enables vendor financial governance and media investment accountability."
  source: "`advertising_ecm`.`finance`.`media_cost_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status (e.g. Pending, Reconciled, Disputed) for workflow tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency media cost analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the reconciliation record has an active vendor dispute."
    - name: "make_good_flag"
      expr: make_good_flag
      comment: "Indicates whether a make-good (compensatory delivery) has been issued by the vendor."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Coded reason for cost or impression variance, enabling root-cause analysis of reconciliation discrepancies."
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start of the billing period for temporal media cost analysis."
    - name: "billing_period_end_date"
      expr: billing_period_end_date
      comment: "End of the billing period for temporal media cost analysis."
    - name: "third_party_verification_source"
      expr: third_party_verification_source
      comment: "Source of third-party verification (e.g. DoubleVerify, IAS) for media quality governance."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE))
      comment: "Total planned media cost across reconciliation records. Baseline for cost variance and budget adherence analysis."
    - name: "total_billed_cost"
      expr: SUM(CAST(billed_cost_amount AS DOUBLE))
      comment: "Total cost billed by vendors. Compared against planned cost to measure vendor billing accuracy."
    - name: "total_reconciled_amount"
      expr: SUM(CAST(reconciled_amount AS DOUBLE))
      comment: "Total amount formally reconciled and agreed between agency and vendor. Measures reconciliation completion."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (planned minus billed). Persistent positive or negative values indicate systemic planning or vendor billing issues."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impression volume. Denominator for delivery accuracy and CPM efficiency analysis."
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total impressions actually delivered by vendors. Core media delivery accountability KPI."
    - name: "total_impression_variance"
      expr: SUM(CAST(impression_variance AS DOUBLE))
      comment: "Total impression delivery shortfall or surplus. Negative values indicate under-delivery requiring make-good negotiation."
    - name: "total_make_good_impressions"
      expr: SUM(CAST(make_good_impressions AS DOUBLE))
      comment: "Total make-good impressions secured from vendors. Measures recovery of under-delivered media value."
    - name: "avg_actual_cpm"
      expr: AVG(CAST(actual_cpm AS DOUBLE))
      comment: "Average actual CPM paid across reconciled placements. Benchmarks media buying efficiency against planned CPM."
    - name: "avg_planned_cpm"
      expr: AVG(CAST(planned_cpm AS DOUBLE))
      comment: "Average planned CPM across reconciliation records. Reference rate for vendor negotiation and media planning accuracy."
    - name: "avg_cpm_variance"
      expr: AVG(CAST(cpm_variance AS DOUBLE))
      comment: "Average CPM variance (planned minus actual). Positive values indicate better-than-planned pricing; negative values indicate overpayment."
    - name: "avg_impression_variance_percentage"
      expr: AVG(CAST(impression_variance_percentage AS DOUBLE))
      comment: "Average impression delivery variance percentage. Tracks vendor delivery reliability across the media portfolio."
    - name: "count_reconciliation_records"
      expr: COUNT(1)
      comment: "Total number of reconciliation records. Baseline volume for reconciliation workload and process efficiency tracking."
    - name: "count_disputed_records"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of reconciliation records with active vendor disputes. Elevated counts signal vendor relationship or billing quality issues."
    - name: "count_make_good_records"
      expr: COUNT(CASE WHEN make_good_flag = TRUE THEN 1 END)
      comment: "Number of records with make-good arrangements. Indicates scale of vendor under-delivery and recovery negotiations."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_vendor_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor payable metrics covering outstanding liabilities, payment performance, discount capture, and dispute management. Supports accounts payable governance, cash flow planning, and vendor relationship management."
  source: "`advertising_ecm`.`finance`.`vendor_payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the payable (e.g. Pending, Paid, Overdue, Disputed)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or planned (e.g. Wire, ACH, Check) for cash management analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) for DPO and early payment discount analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the payable (e.g. Unreconciled, Reconciled) for AP close tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency payables analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable for annual AP and cash flow planning."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for in-year payables tracking and cash flow forecasting."
    - name: "sequential_liability_flag"
      expr: sequential_liability_flag
      comment: "Indicates sequential liability arrangement where agency pays vendor only after client payment is received."
    - name: "posting_date"
      expr: posting_date
      comment: "GL posting date of the payable for period-accurate financial reporting."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross vendor payable amount before discounts and taxes. Primary AP liability KPI for cash flow planning."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net vendor payable amount after discounts. Represents actual cash outflow obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of vendor payables. Required for tax compliance and VAT/GST reconciliation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures AP team effectiveness in optimising cash and discount capture."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for tax authority reporting and vendor remittance."
    - name: "count_payables"
      expr: COUNT(1)
      comment: "Total number of vendor payable records. Baseline AP volume metric for workload and process capacity planning."
    - name: "count_overdue_payables"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue vendor payables. Elevated counts risk vendor relationship damage and late payment penalties."
    - name: "count_disputed_payables"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of payables with an active dispute. Tracks vendor billing quality and AP dispute resolution workload."
    - name: "count_sequential_liability_payables"
      expr: COUNT(CASE WHEN sequential_liability_flag = TRUE THEN 1 END)
      comment: "Number of payables under sequential liability terms. Informs cash flow timing and client collection dependency analysis."
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payable amount per vendor invoice. Tracks vendor transaction size trends for AP process benchmarking."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics supporting ASC 606 / IFRS 15 compliance, deferred revenue management, and recognised revenue tracking across campaigns, service lines, and fiscal periods. Critical for accurate financial reporting and audit readiness."
  source: "`advertising_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current revenue recognition status (e.g. Pending, Recognised, Deferred, Reversed) for compliance tracking."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognise revenue (e.g. Percentage of Completion, Milestone, Straight-Line) for policy compliance."
    - name: "revenue_type"
      expr: revenue_type
      comment: "Type of revenue (e.g. Media Commission, Agency Fee, Production) for revenue stream analysis."
    - name: "service_line"
      expr: service_line
      comment: "Service line generating the revenue (e.g. Media, Creative, Strategy) for P&L attribution."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of revenue recognition for annual financial reporting and year-over-year comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly earnings reporting and board-level revenue tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue close and management reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue consolidation."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the revenue recognition record is currently active."
    - name: "recognition_start_date"
      expr: recognition_start_date
      comment: "Start date of the revenue recognition period for temporal revenue analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all revenue recognition records. Top-line revenue backlog KPI for executive financial planning."
    - name: "total_recognized_amount_to_date"
      expr: SUM(CAST(recognized_amount_to_date AS DOUBLE))
      comment: "Total revenue recognised to date. Core P&L revenue KPI for financial reporting and earnings disclosure."
    - name: "total_deferred_revenue_amount"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total deferred revenue balance (contracted but not yet earned). Balance sheet liability KPI for ASC 606 / IFRS 15 compliance."
    - name: "total_unbilled_revenue_amount"
      expr: SUM(CAST(unbilled_revenue_amount AS DOUBLE))
      comment: "Total unbilled revenue (earned but not yet invoiced). Tracks billing lag and working capital efficiency."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average percentage of completion across active revenue recognition records. Informs revenue run-rate forecasting and project delivery tracking."
    - name: "count_recognition_records"
      expr: COUNT(1)
      comment: "Total number of revenue recognition records. Baseline volume for revenue accounting workload and audit scope assessment."
    - name: "count_active_records"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active revenue recognition records. Measures active revenue portfolio size."
    - name: "count_fully_recognized_records"
      expr: COUNT(CASE WHEN recognition_status = 'Recognised' THEN 1 END)
      comment: "Number of fully recognised revenue records. Tracks revenue close completion rate for period-end reporting."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction metrics covering cash flow, payment method mix, reversal rates, withholding tax, and approval performance. Supports treasury management, cash forecasting, and payment operations governance."
  source: "`advertising_ecm`.`finance`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Pending, Cleared, Failed, Reversed) for cash flow tracking."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Vendor Payment, Client Receipt, Refund) for cash flow categorisation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. Wire, ACH, Check) for treasury and banking operations analysis."
    - name: "direction"
      expr: direction
      comment: "Payment direction (Inbound / Outbound) for net cash flow analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency cash flow analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual cash flow and treasury reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash flow close and management reporting."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Indicates whether the payment is a reversal of a prior transaction."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the payment (e.g. Pending, Approved, Rejected) for payment controls governance."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash flow trend analysis and treasury forecasting."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount in transaction currency. Primary cash flow volume KPI for treasury management."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional (reporting) currency. Enables consolidated cash flow reporting across currencies."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total payment discounts applied. Measures early payment discount capture and its impact on net cash outflow."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted across payments. Required for tax authority remittance and compliance reporting."
    - name: "count_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume for payment operations capacity and processing efficiency."
    - name: "count_reversal_payments"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of payment reversals. Elevated reversal rates signal payment processing errors or fraud risk requiring investigation."
    - name: "count_pending_approvals"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of payments awaiting approval. Tracks payment approval pipeline and potential cash flow delays."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction size. Informs treasury liquidity planning and payment batch optimisation."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across multi-currency payments. Supports FX exposure monitoring and hedging decisions."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line item metrics providing granular revenue, commission, discount, and tax analysis at the service and delivery level. Enables detailed billing accuracy reviews, commission management, and service line profitability analysis."
  source: "`advertising_ecm`.`finance`.`invoice_line`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the invoice line (e.g. Pending, Billed, Disputed, Credited)."
    - name: "service_category"
      expr: service_category
      comment: "Service category of the line item (e.g. Media, Creative, Strategy) for service line revenue analysis."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "Revenue recognition category for ASC 606 / IFRS 15 compliance and deferred revenue tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item (e.g. Impressions, Hours, Units) for pricing and yield analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency invoice line analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice line is under dispute."
    - name: "delivery_confirmed_flag"
      expr: delivery_confirmed_flag
      comment: "Indicates whether delivery of the service or media has been confirmed, enabling revenue recognition gating."
    - name: "service_start_date"
      expr: service_start_date
      comment: "Start date of the service period for temporal revenue analysis."
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Date on which revenue for this line is recognised for period-accurate financial reporting."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total pre-tax, pre-discount line amount. Core revenue billing KPI at the service line level."
    - name: "total_line_total"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total final line amount including all adjustments. Represents actual billed value per service line."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission earned across invoice lines. Key agency revenue and compensation KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at the line level. Measures pricing concession impact on net revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at the invoice line level. Required for tax compliance and reconciliation."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units billed. Enables yield and unit economics analysis (e.g. cost per impression, cost per hour)."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate billed across invoice lines. Benchmarks pricing against rate cards and market rates."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across invoice lines. Tracks commission rate consistency and contract compliance."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied. Monitors pricing discipline and margin erosion trends."
    - name: "count_invoice_lines"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Baseline billing granularity metric for revenue operations capacity planning."
    - name: "count_disputed_lines"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed invoice lines. Elevated counts indicate billing accuracy or delivery confirmation issues."
    - name: "count_delivery_confirmed_lines"
      expr: COUNT(CASE WHEN delivery_confirmed_flag = TRUE THEN 1 END)
      comment: "Number of lines with confirmed delivery. Measures revenue recognition readiness and billing completeness."
$$;