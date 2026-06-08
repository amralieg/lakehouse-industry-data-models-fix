-- Metric views for domain: billing | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice-level KPIs tracking revenue recognition, billing efficiency, outstanding receivables, and payment performance across all client billing activity."
  source: "`staffing_hr_ecm_v1`.`billing`.`invoice`"
  dimensions:
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model (e.g., time-and-materials, fixed-fee, direct-hire) used to segment revenue and margin analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., draft, sent, paid, disputed, void) for pipeline and aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) to analyze DSO drivers and cash flow risk."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Invoice delivery channel (e.g., email, portal, EDI) for operational efficiency benchmarking."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance for trend and seasonality analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month the billing period begins, used to align revenue to service delivery periods."
    - name: "is_void"
      expr: is_void
      comment: "Flag indicating whether the invoice has been voided, used to exclude or analyze void rates."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount billed to clients before discounts and taxes. Primary top-line revenue KPI."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Reflects actual recognized revenue obligation."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed across all invoices. Required for tax compliance and remittance reporting."
    - name: "total_discount_given"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices. Tracks pricing concessions and their revenue impact."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all open invoices. Core accounts receivable health KPI."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against invoices. Measures cash conversion effectiveness."
    - name: "total_spread_revenue"
      expr: SUM(CAST(spread_amount AS DOUBLE))
      comment: "Total spread (bill rate minus pay rate) billed. Represents gross staffing margin contribution."
    - name: "total_hours_billed"
      expr: SUM(CAST(total_hours_billed AS DOUBLE))
      comment: "Total billable hours invoiced to clients. Workforce utilization and revenue volume indicator."
    - name: "total_overtime_hours_billed"
      expr: SUM(CAST(overtime_hours_billed AS DOUBLE))
      comment: "Total overtime hours billed. Elevated OT signals workforce strain and margin compression risk."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Tracks deal size trends and client billing concentration."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput analysis."
    - name: "void_invoice_count"
      expr: COUNT(CASE WHEN is_void = TRUE THEN 1 END)
      comment: "Number of voided invoices. High void rates indicate billing errors, disputes, or process failures."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across invoices. Tracks pricing discipline and margin management."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross billed amount that has been collected. Core AR efficiency and cash conversion KPI."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing KPIs enabling granular margin, labor mix, and service-type analysis across all billable activity."
  source: "`staffing_hr_ecm_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model at the line level (e.g., hourly, fixed, per-diem) for revenue mix analysis."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing activity on the line (e.g., regular, overtime, expense, fee) for cost and revenue decomposition."
    - name: "worker_type"
      expr: worker_type
      comment: "Classification of the worker (e.g., W2 temp, 1099, direct hire) driving the billing line."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the invoice line (e.g., approved, disputed, voided) for billing quality monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line for multi-currency margin analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the line is billable to the client. Used to separate billable from non-billable activity."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Indicates whether the line is subject to tax. Supports tax liability and compliance reporting."
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of service delivery for aligning billing to workforce activity periods."
    - name: "pay_period_start_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month the pay period begins, used to reconcile billing with payroll cycles."
  measures:
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended billing amount (quantity × rate) across all lines. Primary line-level revenue measure."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts at the line level. Reflects actual revenue recognized per service line."
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars across all invoice lines. Core profitability KPI for staffing operations."
    - name: "total_burden_rate_amount"
      expr: SUM(CAST(burden_rate_amount AS DOUBLE))
      comment: "Total employer burden costs billed. Tracks cost-of-labor overhead impact on margin."
    - name: "total_spread_amount"
      expr: SUM(CAST(spread_amount AS DOUBLE))
      comment: "Total bill-pay spread at the line level. Granular margin contribution per service line."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at the line level for tax compliance and remittance tracking."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at the line level. Measures pricing concession impact on revenue."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units billed (hours, days, units) across all lines. Workforce volume and throughput indicator."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage at the line level. Tracks pricing consistency and margin discipline."
    - name: "avg_ot_multiplier"
      expr: AVG(CAST(ot_multiplier AS DOUBLE))
      comment: "Average overtime multiplier applied. Elevated averages signal OT-heavy engagements compressing margin."
    - name: "gross_margin_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of extended billing amount. Primary profitability efficiency KPI."
    - name: "billable_line_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Count of billable invoice lines. Measures productive billing volume versus total activity."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection and payment performance KPIs tracking payment velocity, method mix, reconciliation status, and overpayment risk."
  source: "`staffing_hr_ecm_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to remit payment (e.g., ACH, check, wire, credit card) for cash flow and processing cost analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., applied, unapplied, reversed, voided) for AR reconciliation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment. Unreconciled payments signal cash management risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash management reporting."
    - name: "channel"
      expr: channel
      comment: "Payment receipt channel (e.g., lockbox, online portal, manual) for process efficiency benchmarking."
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Indicates partial payment. High partial payment rates signal client cash flow stress or disputes."
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Indicates overpayment. Tracks liability exposure requiring refund or credit processing."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month payment was received for cash flow trend and seasonality analysis."
    - name: "deposit_month"
      expr: DATE_TRUNC('MONTH', deposit_date)
      comment: "Month payment was deposited. Lag between payment date and deposit date indicates processing delays."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received from clients. Primary cash collection volume KPI."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to invoices. Measures AR clearance effectiveness."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet applied to invoices. High unapplied balances indicate AR processing backlog."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by clients. Measures cost of accelerated cash collection programs."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received. Baseline volume metric for cash collection throughput."
    - name: "overpayment_count"
      expr: COUNT(CASE WHEN is_overpayment = TRUE THEN 1 END)
      comment: "Number of overpayments received. Tracks liability exposure and billing accuracy issues."
    - name: "partial_payment_count"
      expr: COUNT(CASE WHEN is_partial_payment = TRUE THEN 1 END)
      comment: "Number of partial payments. Elevated counts signal client financial stress or invoice disputes."
    - name: "unapplied_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total cash received that remains unapplied. High rates indicate AR processing inefficiency."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment size. Tracks client payment behavior and concentration risk."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute KPIs tracking dispute volume, financial exposure, resolution efficiency, and root cause patterns to reduce billing quality risk."
  source: "`staffing_hr_ecm_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, resolved, escalated, withdrawn) for pipeline management."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (e.g., rate error, hours discrepancy, duplicate invoice) for root cause analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification of the dispute. Drives process improvement and error reduction initiatives."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g., credit issued, rate adjusted, no action) for outcome analysis."
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model associated with the disputed invoice for model-level quality benchmarking."
    - name: "priority"
      expr: priority
      comment: "Dispute priority level (e.g., high, medium, low) for workload and escalation management."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the dispute was escalated. Escalated disputes signal systemic billing or relationship issues."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the dispute resolution SLA was breached. Tracks contractual compliance risk."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the dispute was opened for trend and volume analysis."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the dispute was resolved for cycle time and throughput analysis."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar value of amounts under dispute. Primary financial exposure KPI for billing quality."
    - name: "total_approved_credit_amount"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Total credit amount approved to resolve disputes. Measures financial concession cost of billing errors."
    - name: "total_disputed_hours"
      expr: SUM(CAST(disputed_hours AS DOUBLE))
      comment: "Total hours under dispute. Identifies timesheet accuracy and approval process failures."
    - name: "total_approved_hours"
      expr: SUM(CAST(approved_hours AS DOUBLE))
      comment: "Total hours approved through dispute resolution. Measures hours ultimately validated after challenge."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Baseline billing quality and client satisfaction indicator."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of disputes that were escalated. High escalation rates signal systemic billing or relationship failures."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes where resolution SLA was breached. Tracks contractual compliance and operational risk."
    - name: "credit_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount approved as credit. High rates indicate systemic billing errors requiring process correction."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that escalated. Key client relationship and billing quality health metric."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes where resolution SLA was breached. Contractual compliance and operational efficiency KPI."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Tracks severity trends and financial risk per incident."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo KPIs tracking billing correction volume, financial impact, application efficiency, and void-and-rebill activity."
  source: "`staffing_hr_ecm_v1`.`billing`.`credit_memo`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the credit memo (e.g., pending, approved, rejected) for workflow management."
    - name: "applied_status"
      expr: applied_status
      comment: "Application status of the credit memo (e.g., fully applied, partially applied, unapplied) for AR reconciliation."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the credit memo issuance. Identifies systemic billing error patterns requiring process correction."
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model associated with the credit memo for model-level quality analysis."
    - name: "is_void_and_rebill"
      expr: is_void_and_rebill
      comment: "Indicates void-and-rebill credits. High rates signal invoice accuracy failures requiring rework."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit memo for multi-currency financial reporting."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the credit memo was issued for trend and volume analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period the credit memo relates to, for aligning corrections to service delivery periods."
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total dollar value of credits issued to clients. Measures financial impact of billing corrections."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total credit amount applied against invoices. Tracks AR offset effectiveness."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total credit amount not yet applied. Unapplied credits represent unresolved client liabilities."
    - name: "total_tax_adjustment_amount"
      expr: SUM(CAST(tax_adjustment_amount AS DOUBLE))
      comment: "Total tax adjustments included in credit memos. Required for tax compliance and remittance reconciliation."
    - name: "total_credited_hours"
      expr: SUM(CAST(credited_hours AS DOUBLE))
      comment: "Total hours credited back to clients. Measures timesheet correction volume and billing accuracy."
    - name: "credit_memo_count"
      expr: COUNT(1)
      comment: "Total number of credit memos issued. Baseline billing quality and error correction volume KPI."
    - name: "void_and_rebill_count"
      expr: COUNT(CASE WHEN is_void_and_rebill = TRUE THEN 1 END)
      comment: "Number of void-and-rebill credit memos. High counts indicate invoice accuracy failures and rework cost."
    - name: "credit_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of issued credit amount that has been applied. Low rates indicate AR processing backlog."
    - name: "void_and_rebill_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_void_and_rebill = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit memos that are void-and-rebill. Key invoice quality and rework cost indicator."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit memo value. Tracks severity of billing corrections and client financial impact."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_collection_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections performance KPIs tracking outreach effectiveness, promise-to-pay conversion, write-off risk, and aging bucket distribution."
  source: "`staffing_hr_ecm_v1`.`billing`.`collection_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of collection action taken (e.g., call, email, legal notice) for outreach effectiveness analysis."
    - name: "collection_activity_status"
      expr: collection_activity_status
      comment: "Current status of the collection activity (e.g., open, resolved, escalated) for pipeline management."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (e.g., 0-30, 31-60, 61-90, 90+ days) for receivables risk stratification."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the collection effort. Higher levels indicate greater collection risk and cost."
    - name: "contact_method"
      expr: contact_method
      comment: "Method used to contact the client (e.g., phone, email, letter) for channel effectiveness benchmarking."
    - name: "outcome"
      expr: outcome
      comment: "Result of the collection activity (e.g., payment received, promise made, no response) for conversion analysis."
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Indicates whether legal action has been initiated. Tracks high-risk receivables requiring executive attention."
    - name: "write_off_recommended_flag"
      expr: write_off_recommended_flag
      comment: "Indicates accounts recommended for write-off. Tracks bad debt risk and reserve adequacy."
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of collection activity for trend and workload analysis."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance under active collection. Primary collections portfolio size KPI."
    - name: "total_payment_received_amount"
      expr: SUM(CAST(payment_received_amount AS DOUBLE))
      comment: "Total cash collected through collection activities. Measures collections team cash recovery effectiveness."
    - name: "total_promise_to_pay_amount"
      expr: SUM(CAST(promise_to_pay_amount AS DOUBLE))
      comment: "Total amount clients have committed to pay. Forward-looking cash flow indicator from collections pipeline."
    - name: "collection_activity_count"
      expr: COUNT(1)
      comment: "Total number of collection touchpoints. Measures collections team workload and outreach volume."
    - name: "legal_action_count"
      expr: COUNT(CASE WHEN legal_action_flag = TRUE THEN 1 END)
      comment: "Number of accounts with active legal action. Tracks high-risk receivables and associated legal cost exposure."
    - name: "write_off_recommended_count"
      expr: COUNT(CASE WHEN write_off_recommended_flag = TRUE THEN 1 END)
      comment: "Number of accounts recommended for write-off. Tracks bad debt pipeline and reserve requirement."
    - name: "credit_memo_issued_count"
      expr: COUNT(CASE WHEN credit_memo_issued_flag = TRUE THEN 1 END)
      comment: "Number of collection activities resulting in a credit memo. Measures dispute-driven credit concession volume."
    - name: "promise_to_pay_conversion_pct"
      expr: ROUND(100.0 * SUM(CAST(payment_received_amount AS DOUBLE)) / NULLIF(SUM(CAST(promise_to_pay_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of promised payment amounts actually received. Measures promise-to-pay reliability and collections effectiveness."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per collection activity. Tracks average account risk exposure."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_placement_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct hire and permanent placement fee KPIs tracking fee revenue, fall-off risk, guarantee exposure, and payment collection performance."
  source: "`staffing_hr_ecm_v1`.`billing`.`placement_fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of placement fee (e.g., direct hire, conversion, retained search) for revenue mix analysis."
    - name: "fee_basis"
      expr: fee_basis
      comment: "Basis for fee calculation (e.g., percentage of salary, flat fee) for pricing model analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the placement fee (e.g., invoiced, paid, disputed, written off)."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the placement fee. Tracks fee challenges and their financial resolution."
    - name: "is_fall_off"
      expr: is_fall_off
      comment: "Indicates whether the placement fell off (candidate left within guarantee period). Tracks revenue reversal risk."
    - name: "replacement_eligible"
      expr: replacement_eligible
      comment: "Indicates whether a fall-off is eligible for replacement. Tracks guarantee obligation exposure."
    - name: "split_fee_indicator"
      expr: split_fee_indicator
      comment: "Indicates a split fee arrangement between recruiters or offices. Tracks revenue sharing and commission allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the placement fee for multi-currency revenue reporting."
    - name: "fee_month"
      expr: DATE_TRUNC('MONTH', fee_date)
      comment: "Month the placement fee was earned for revenue trend and pipeline analysis."
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month revenue from the placement fee is recognized for financial reporting alignment."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total placement fee revenue earned. Primary direct hire revenue KPI."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total placement fee amount invoiced to clients. Tracks billing conversion of earned fees."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total placement fee cash collected. Measures cash conversion of direct hire revenue."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memos issued against placement fees. Measures fall-off and dispute financial impact."
    - name: "total_fee_adjustment_amount"
      expr: SUM(CAST(fee_adjustment_amount AS DOUBLE))
      comment: "Total fee adjustments applied. Tracks pricing corrections and negotiated concessions."
    - name: "total_candidate_annual_salary"
      expr: SUM(CAST(candidate_annual_salary AS DOUBLE))
      comment: "Total placed candidate salary base. Used to benchmark fee percentages and market competitiveness."
    - name: "placement_fee_count"
      expr: COUNT(1)
      comment: "Total number of placement fees. Baseline direct hire volume KPI."
    - name: "fall_off_count"
      expr: COUNT(CASE WHEN is_fall_off = TRUE THEN 1 END)
      comment: "Number of placements that fell off within the guarantee period. Tracks placement quality and revenue reversal risk."
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage charged on placements. Tracks pricing competitiveness and margin discipline."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average placement fee value. Tracks deal size trends and revenue per placement."
    - name: "fee_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced placement fees collected. Measures cash conversion effectiveness for direct hire revenue."
    - name: "fall_off_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fall_off = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of placements that fell off. Key placement quality and revenue stability KPI."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_bill_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill rate governance KPIs tracking rate levels, markup and margin performance, spread economics, and rate approval compliance across all client engagements."
  source: "`staffing_hr_ecm_v1`.`billing`.`bill_rate`"
  dimensions:
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model associated with the rate (e.g., hourly, per-diem, fixed) for rate structure analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of bill rate (e.g., standard, overtime, double-time, holiday) for rate mix and cost analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the bill rate (e.g., approved, pending, rejected) for rate governance compliance."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level associated with the rate for workforce tier pricing analysis."
    - name: "rate_source"
      expr: rate_source
      comment: "Origin of the rate (e.g., MSA, VMS, negotiated) for rate governance and contract compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bill rate for multi-currency pricing analysis."
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work is performed. Drives geographic rate benchmarking and wage compliance analysis."
    - name: "flsa_exempt"
      expr: flsa_exempt
      comment: "FLSA exemption status. Impacts overtime billing eligibility and compliance risk."
    - name: "burden_included"
      expr: burden_included
      comment: "Indicates whether employer burden is included in the bill rate. Affects true margin calculation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the bill rate became effective for rate trend and change analysis."
  measures:
    - name: "avg_bill_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bill rate amount. Tracks pricing levels and rate competitiveness across engagements."
    - name: "avg_pay_rate_amount"
      expr: AVG(CAST(pay_rate_amount AS DOUBLE))
      comment: "Average pay rate amount. Benchmarks labor cost levels against bill rates."
    - name: "avg_spread_amount"
      expr: AVG(CAST(spread_amount AS DOUBLE))
      comment: "Average bill-pay spread per rate record. Core margin economics indicator for staffing operations."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage. Tracks pricing discipline and margin management across client engagements."
    - name: "avg_gross_margin_percentage"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage at the rate level. Primary profitability governance KPI."
    - name: "avg_burden_rate_percentage"
      expr: AVG(CAST(burden_rate_percentage AS DOUBLE))
      comment: "Average employer burden rate percentage. Tracks labor cost overhead and its impact on net margin."
    - name: "avg_ot_bill_rate_amount"
      expr: AVG(CAST(ot_bill_rate_amount AS DOUBLE))
      comment: "Average overtime bill rate. Benchmarks OT pricing and its margin impact versus standard rates."
    - name: "avg_dt_bill_rate_amount"
      expr: AVG(CAST(dt_bill_rate_amount AS DOUBLE))
      comment: "Average double-time bill rate. Tracks premium rate levels for high-cost labor scenarios."
    - name: "bill_rate_count"
      expr: COUNT(1)
      comment: "Total number of active bill rate records. Tracks rate governance complexity and coverage."
    - name: "avg_per_diem_amount"
      expr: AVG(CAST(per_diem_amount AS DOUBLE))
      comment: "Average per diem allowance billed. Tracks travel and living cost pass-through levels."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate schedule governance KPIs tracking schedule coverage, margin parameters, OT/DT multiplier levels, and schedule lifecycle management."
  source: "`staffing_hr_ecm_v1`.`billing`.`billing_rate_schedule`"
  dimensions:
    - name: "billing_rate_schedule_status"
      expr: billing_rate_schedule_status
      comment: "Lifecycle status of the rate schedule (e.g., active, expired, superseded) for governance and coverage analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of rate schedule (e.g., standard, VMS, MSA-specific) for contract alignment analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency defined in the schedule (e.g., weekly, bi-weekly) for cash flow planning."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market the schedule applies to for regional pricing and margin benchmarking."
    - name: "skill_tier"
      expr: skill_tier
      comment: "Skill tier classification in the schedule for workforce pricing tier analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate schedule for multi-currency pricing governance."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rate schedule became effective for schedule lifecycle and renewal tracking."
  measures:
    - name: "avg_base_bill_rate"
      expr: AVG(CAST(base_bill_rate AS DOUBLE))
      comment: "Average base bill rate across schedules. Tracks market pricing levels and rate competitiveness."
    - name: "avg_base_pay_rate"
      expr: AVG(CAST(base_pay_rate AS DOUBLE))
      comment: "Average base pay rate across schedules. Benchmarks labor cost levels against billing rates."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across rate schedules. Tracks pricing discipline at the schedule level."
    - name: "avg_gross_margin_percentage"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage across schedules. Primary profitability governance KPI for rate schedule management."
    - name: "avg_ot_multiplier"
      expr: AVG(CAST(ot_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across schedules. Tracks OT cost structure and its margin impact."
    - name: "avg_dt_multiplier"
      expr: AVG(CAST(dt_multiplier AS DOUBLE))
      comment: "Average double-time multiplier. Tracks premium labor cost parameters in rate governance."
    - name: "avg_spread_amount"
      expr: AVG(CAST(spread_amount AS DOUBLE))
      comment: "Average spread amount defined in rate schedules. Tracks margin economics at the contract level."
    - name: "avg_per_diem_allowance"
      expr: AVG(CAST(per_diem_allowance AS DOUBLE))
      comment: "Average per diem allowance in rate schedules. Tracks travel cost pass-through levels."
    - name: "rate_schedule_count"
      expr: COUNT(1)
      comment: "Total number of rate schedules. Tracks rate governance complexity and contract coverage breadth."
    - name: "avg_conversion_fee_percentage"
      expr: AVG(CAST(conversion_fee_percentage AS DOUBLE))
      comment: "Average conversion fee percentage in rate schedules. Tracks temp-to-perm conversion revenue opportunity."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_expense_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expense billing KPIs tracking billable expense volume, markup economics, reimbursement patterns, and approval compliance for pass-through cost management."
  source: "`staffing_hr_ecm_v1`.`billing`.`expense_charge`"
  dimensions:
    - name: "expense_type"
      expr: expense_type
      comment: "Category of expense (e.g., travel, per diem, background check, training) for cost type analysis."
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model for the expense charge for revenue mix and margin analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expense charge (e.g., approved, pending, rejected) for compliance monitoring."
    - name: "charge_status"
      expr: charge_status
      comment: "Processing status of the expense charge (e.g., invoiced, paid, disputed) for AR management."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the expense is billable to the client. Separates client-billable from internal costs."
    - name: "is_reimbursable"
      expr: is_reimbursable
      comment: "Indicates whether the expense is reimbursable to the worker. Tracks worker reimbursement obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the expense charge for multi-currency cost reporting."
    - name: "expense_month"
      expr: DATE_TRUNC('MONTH', expense_date)
      comment: "Month the expense was incurred for trend and budget variance analysis."
  measures:
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense amount incurred. Tracks pass-through cost volume and budget adherence."
    - name: "total_billable_amount"
      expr: SUM(CAST(billable_amount AS DOUBLE))
      comment: "Total amount billable to clients. Measures expense revenue contribution."
    - name: "total_markup_amount"
      expr: SUM(CAST(markup_amount AS DOUBLE))
      comment: "Total markup earned on expense charges. Tracks margin contribution from expense billing."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on expense charges for compliance and remittance tracking."
    - name: "expense_charge_count"
      expr: COUNT(1)
      comment: "Total number of expense charges. Baseline volume metric for expense billing throughput."
    - name: "billable_expense_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable expense charges. Tracks client-billable expense volume versus total."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on expense charges. Tracks pricing discipline for pass-through cost billing."
    - name: "expense_markup_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(markup_amount AS DOUBLE)) / NULLIF(SUM(CAST(expense_amount AS DOUBLE)), 0), 2)
      comment: "Markup as a percentage of total expense amount. Measures margin yield on expense billing activity."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`billing_payment_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment application KPIs tracking AR clearance efficiency, early/late payment patterns, write-off activity, and reconciliation health."
  source: "`staffing_hr_ecm_v1`.`billing`.`payment_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the payment application (e.g., applied, reversed, pending) for AR reconciliation monitoring."
    - name: "application_type"
      expr: application_type
      comment: "Type of payment application (e.g., standard, credit memo, write-off) for cash application mix analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket at time of application. Tracks payment timing relative to invoice age."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the application. Unreconciled applications signal cash management risk."
    - name: "is_early_payment"
      expr: is_early_payment
      comment: "Indicates early payment. Tracks uptake of early payment discount programs."
    - name: "is_late_payment"
      expr: is_late_payment
      comment: "Indicates late payment. High late payment rates signal client credit risk and cash flow pressure."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates the application is associated with a dispute. Tracks disputed cash application complexity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment application for multi-currency AR reporting."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month the payment was applied for cash flow trend analysis."
  measures:
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices. Primary AR clearance volume KPI."
    - name: "total_net_applied_amount"
      expr: SUM(CAST(net_applied_amount AS DOUBLE))
      comment: "Total net amount applied after adjustments and discounts. Reflects true cash offset against AR."
    - name: "total_writeoff_amount"
      expr: SUM(CAST(writeoff_amount AS DOUBLE))
      comment: "Total amount written off through payment applications. Tracks bad debt realization and reserve adequacy."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts applied. Measures cost of accelerated cash collection programs."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments made during payment application. Tracks AR correction volume and accuracy."
    - name: "payment_application_count"
      expr: COUNT(1)
      comment: "Total number of payment applications. Baseline AR processing throughput metric."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN is_late_payment = TRUE THEN 1 END)
      comment: "Number of late payment applications. Tracks client payment behavior and credit risk."
    - name: "early_payment_count"
      expr: COUNT(CASE WHEN is_early_payment = TRUE THEN 1 END)
      comment: "Number of early payment applications. Measures effectiveness of early payment discount programs."
    - name: "late_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_payment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments received late. Key client credit risk and DSO driver KPI."
    - name: "writeoff_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(writeoff_amount AS DOUBLE)) / NULLIF(SUM(CAST(applied_amount AS DOUBLE)), 0), 2)
      comment: "Write-off amount as a percentage of total applied amount. Tracks bad debt severity and AR quality."
$$;