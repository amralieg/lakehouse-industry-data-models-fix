-- Metric views for domain: billing | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice-level KPIs covering billed revenue, collections performance, outstanding balances, write-offs, and e-billing adoption. Primary steering dashboard for billing leadership and CFO."
  source: "`legal_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Submitted, Paid, Disputed, Written-Off). Enables pipeline and aging analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. Standard, Proforma, Credit, Interim). Supports revenue mix analysis."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Billing arrangement governing the invoice (e.g. Hourly, Fixed Fee, Contingency, Retainer). Key dimension for profitability analysis by arrangement type."
    - name: "billing_office_code"
      expr: billing_office_code
      comment: "Office responsible for billing. Enables geographic and office-level revenue performance comparison."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance. Supports monthly revenue trend and seasonality analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month the billing period commenced. Enables period-over-period revenue comparison."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due. Supports cash flow forecasting and aging bucket analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency. Required for multi-currency revenue reporting and FX exposure analysis."
    - name: "is_electronic_billing"
      expr: is_electronic_billing
      comment: "Indicates whether the invoice was submitted via an e-billing portal. Tracks e-billing adoption rate."
    - name: "ebilling_submission_status"
      expr: ebilling_submission_status
      comment: "Status of the e-billing portal submission (e.g. Accepted, Rejected, Pending). Monitors e-billing throughput and rejection rates."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms on the invoice (e.g. Net 30, Net 60). Supports DSO and cash flow analysis."
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction applicable to the invoice. Required for tax compliance and jurisdictional revenue reporting."
  measures:
    - name: "total_invoiced_fees"
      expr: SUM(CAST(fees_amount AS DOUBLE))
      comment: "Total professional fees billed across all invoices. Primary revenue recognition KPI for the firm."
    - name: "total_invoiced_disbursements"
      expr: SUM(CAST(disbursements_amount AS DOUBLE))
      comment: "Total disbursements (expenses) billed to clients. Tracks cost recovery performance."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts and adjustments. Core top-line revenue metric."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on invoices. Required for tax liability reporting and compliance."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against invoices. Measures actual cash realisation vs. billed amounts."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all open invoices. Critical AR health and cash flow KPI."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total value written off on invoices. Measures revenue leakage and collection failure impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on invoices. Tracks pricing discipline and client concession exposure."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN 1 END)
      comment: "Number of invoices with an active dispute reason recorded. Tracks billing quality and client satisfaction risk."
    - name: "ebilling_rejected_invoice_count"
      expr: COUNT(CASE WHEN ebilling_submission_status = 'Rejected' THEN 1 END)
      comment: "Number of invoices rejected by e-billing portals. High rejection rates signal billing guideline compliance failures."
    - name: "avg_net_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per invoice. Tracks matter size and billing intensity trends over time."
    - name: "avg_outstanding_balance_per_invoice"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average unpaid balance per invoice. Supports collection prioritisation and DSO benchmarking."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_ar_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and collection performance KPIs. Provides the CFO and collections team with a real-time view of outstanding receivables, aging buckets, dispute exposure, and collection effectiveness."
  source: "`legal_ecm`.`billing`.`ar_balance`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection workflow status (e.g. Current, In Collections, Escalated, Written-Off). Primary dimension for AR triage and prioritisation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the client is billed (e.g. Monthly, Quarterly, On Completion). Supports cash flow pattern analysis."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Type of fee arrangement governing the receivable. Enables AR analysis by billing model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR balance. Required for multi-currency AR reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the balance is subject to a client dispute. Critical flag for AR risk segmentation."
    - name: "iolta_flag"
      expr: iolta_flag
      comment: "Indicates whether the balance is associated with an IOLTA trust account. Required for trust accounting compliance."
    - name: "matter_type_code"
      expr: matter_type_code
      comment: "Type of legal matter generating the receivable. Enables AR analysis by matter category."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the balance was due. Supports aging trend and cash flow forecasting."
    - name: "last_payment_date_month"
      expr: DATE_TRUNC('MONTH', last_payment_date)
      comment: "Month of the most recent payment received. Tracks payment recency for collection prioritisation."
  measures:
    - name: "total_current_ar_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all accounts. Primary AR health KPI for the CFO and collections leadership."
    - name: "total_bucket_0_30"
      expr: SUM(CAST(bucket_0_30_amount AS DOUBLE))
      comment: "Total AR balance aged 0–30 days. Represents current, low-risk receivables."
    - name: "total_bucket_31_60"
      expr: SUM(CAST(bucket_31_60_amount AS DOUBLE))
      comment: "Total AR balance aged 31–60 days. Early-stage aging requiring monitoring."
    - name: "total_bucket_61_90"
      expr: SUM(CAST(bucket_61_90_amount AS DOUBLE))
      comment: "Total AR balance aged 61–90 days. Elevated collection risk requiring active follow-up."
    - name: "total_bucket_over_90"
      expr: SUM(CAST(bucket_over_90_amount AS DOUBLE))
      comment: "Total AR balance aged over 90 days. High-risk receivables with significant write-off exposure."
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued AS DOUBLE))
      comment: "Total interest accrued on overdue balances. Tracks late payment penalty income and client relationship risk."
    - name: "total_payments_applied"
      expr: SUM(CAST(total_payments_applied AS DOUBLE))
      comment: "Total payments applied to AR balances. Measures cash collection effectiveness."
    - name: "total_credits_applied"
      expr: SUM(CAST(total_credits_applied AS DOUBLE))
      comment: "Total credit notes applied to AR balances. Tracks credit utilisation and billing adjustment volume."
    - name: "total_original_invoice_amount"
      expr: SUM(CAST(original_invoice_amount AS DOUBLE))
      comment: "Total original invoiced amount before payments and credits. Baseline for collection rate calculation."
    - name: "disputed_balance_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of AR balances currently under dispute. Tracks billing quality and client satisfaction risk."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding AR balance per account. Benchmarks collection exposure per client or matter."
    - name: "last_payment_avg_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average amount of the most recent payment received per AR record. Indicates typical payment behaviour and partial payment patterns."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timekeeper productivity, WIP generation, billing guideline compliance, and write-down KPIs. Foundational for realization rate analysis, resource utilisation, and profitability management."
  source: "`legal_ecm`.`billing`.`time_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Lifecycle status of the time entry (e.g. Draft, Submitted, Approved, Billed, Written-Off). Enables WIP pipeline analysis."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type governing the time entry. Supports realization analysis by billing model."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the time entry is billable to the client. Core dimension for utilisation and realization analysis."
    - name: "billing_guideline_compliant"
      expr: billing_guideline_compliant
      comment: "Indicates whether the time entry complies with applicable billing guidelines. Tracks compliance rate and e-billing rejection risk."
    - name: "no_charge"
      expr: no_charge
      comment: "Indicates time recorded as no-charge (pro bono or courtesy). Tracks non-revenue time investment."
    - name: "is_contingency"
      expr: is_contingency
      comment: "Indicates time recorded under a contingency fee arrangement. Supports contingency matter WIP tracking."
    - name: "lpp_protected"
      expr: lpp_protected
      comment: "Indicates the time entry is protected by legal professional privilege. Required for privilege log and compliance reporting."
    - name: "office_code"
      expr: office_code
      comment: "Office where the time was recorded. Enables office-level productivity and revenue contribution analysis."
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code classifying the legal work performed. Enables task-level cost and efficiency benchmarking."
    - name: "utbms_activity_code"
      expr: utbms_activity_code
      comment: "UTBMS activity code for the time entry. Supports granular activity-level billing analysis."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month the work was performed. Enables monthly WIP generation and productivity trend analysis."
    - name: "phase_code"
      expr: phase_code
      comment: "Matter phase code (e.g. Pleadings, Discovery, Trial). Supports phase-level cost and effort analysis."
    - name: "practice_group_code"
      expr: practice_group_code
      comment: "Practice group responsible for the work. Enables practice group profitability and utilisation benchmarking."
    - name: "pro_bono_category"
      expr: pro_bono_category
      comment: "Category of pro bono work. Tracks pro bono commitment and CSR reporting."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours recorded across all time entries. Baseline productivity and capacity utilisation metric."
    - name: "total_billable_hours"
      expr: SUM(CAST(billable_hours AS DOUBLE))
      comment: "Total billable hours recorded. Core realization and revenue generation KPI."
    - name: "total_wip_amount"
      expr: SUM(CAST(wip_amount AS DOUBLE))
      comment: "Total work-in-progress value at standard rates. Measures unbilled revenue pipeline and billing lag."
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total value written down on time entries before billing. Measures revenue leakage from rate and hour reductions."
    - name: "non_compliant_entry_count"
      expr: COUNT(CASE WHEN billing_guideline_compliant = FALSE THEN 1 END)
      comment: "Number of time entries that violate billing guidelines. High counts signal e-billing rejection risk and client relationship issues."
    - name: "billable_entry_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable time entries. Supports utilisation rate calculation and billing throughput analysis."
    - name: "total_entry_count"
      expr: COUNT(1)
      comment: "Total number of time entries recorded. Baseline volume metric for timekeeper activity monitoring."
    - name: "avg_billable_hours_per_entry"
      expr: AVG(CAST(billable_hours AS DOUBLE))
      comment: "Average billable hours per time entry. Tracks granularity of time recording and billing increment compliance."
    - name: "avg_wip_amount_per_entry"
      expr: AVG(CAST(wip_amount AS DOUBLE))
      comment: "Average WIP value per time entry. Benchmarks billing rate effectiveness and matter value density."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_wip_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-progress ledger KPIs covering WIP balance, aging, write-offs, and billing conversion. Enables leadership to monitor unbilled revenue pipeline, identify stale WIP, and drive billing velocity."
  source: "`legal_ecm`.`billing`.`wip_ledger`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Current status of the WIP entry (e.g. Open, Billed, Written-Off, On Hold). Primary dimension for WIP pipeline management."
    - name: "wip_type"
      expr: wip_type
      comment: "Type of WIP entry (e.g. Fee, Disbursement, Adjustment). Supports WIP composition analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the WIP entry (e.g. 0-30, 31-60, 61-90, 90+). Critical for identifying stale WIP and write-off risk."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the WIP entry is billable. Separates revenue-generating WIP from non-billable activity."
    - name: "is_contingency_accrual"
      expr: is_contingency_accrual
      comment: "Indicates WIP accrued under a contingency arrangement. Required for contingency matter financial reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the WIP entry. Required for multi-currency WIP reporting."
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code for the WIP entry. Enables task-level WIP analysis and billing guideline compliance."
    - name: "phase_code"
      expr: phase_code
      comment: "Matter phase associated with the WIP. Supports phase-level cost and WIP aging analysis."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month the work generating WIP was performed. Enables monthly WIP generation trend analysis."
    - name: "entry_date_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month the WIP entry was recorded. Supports billing lag and WIP conversion velocity analysis."
  measures:
    - name: "total_wip_amount"
      expr: SUM(CAST(wip_amount AS DOUBLE))
      comment: "Total WIP balance at billing rates. Primary unbilled revenue pipeline KPI for firm leadership."
    - name: "total_wip_firm_currency"
      expr: SUM(CAST(wip_amount_firm_currency AS DOUBLE))
      comment: "Total WIP balance converted to firm base currency. Required for consolidated financial reporting across currencies."
    - name: "total_standard_amount"
      expr: SUM(CAST(standard_amount AS DOUBLE))
      comment: "Total WIP at standard rack rates before any write-downs. Baseline for realization rate calculation."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total WIP written off. Measures revenue leakage from unbilled work that will never be recovered."
    - name: "total_write_up_down_amount"
      expr: SUM(CAST(write_up_down_amount AS DOUBLE))
      comment: "Net write-up or write-down adjustments on WIP entries. Tracks billing rate discipline and partner adjustment behaviour."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours represented in the WIP ledger. Supports WIP-to-hours ratio and billing rate analysis."
    - name: "wip_entry_count"
      expr: COUNT(1)
      comment: "Total number of WIP ledger entries. Baseline volume metric for billing pipeline monitoring."
    - name: "avg_wip_amount_per_entry"
      expr: AVG(CAST(wip_amount AS DOUBLE))
      comment: "Average WIP value per ledger entry. Benchmarks billing rate effectiveness and matter value density."
    - name: "avg_wip_age_days"
      expr: AVG(CAST(wip_age_days AS DOUBLE))
      comment: "Average age of WIP entries in days. Key indicator of billing velocity and stale WIP risk. Note: wip_age_days is stored as STRING and cast to DOUBLE for aggregation."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection KPIs covering payment volumes, methods, reversal rates, trust payments, and unapplied cash. Enables the CFO and collections team to monitor cash flow, payment behaviour, and allocation efficiency."
  source: "`legal_ecm`.`billing`.`billing_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Applied, Unapplied, Reversed, Pending). Primary dimension for payment pipeline analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the payment (e.g. Client Payment, Retainer Drawdown, Trust Transfer). Supports cash source analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. Wire Transfer, Cheque, ACH, Credit Card). Tracks payment channel mix and processing cost exposure."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type associated with the payment. Enables collection analysis by billing model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment. Required for multi-currency cash collection reporting."
    - name: "is_trust_payment"
      expr: is_trust_payment
      comment: "Indicates whether the payment originated from a trust account. Required for trust accounting compliance and IOLTA reporting."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Indicates whether the payment has been reversed. Tracks payment reversal rate and associated revenue risk."
    - name: "is_multi_matter"
      expr: is_multi_matter
      comment: "Indicates whether the payment spans multiple matters. Supports allocation complexity analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Method by which the payment was allocated (e.g. Auto, Manual, Partial). Tracks allocation efficiency and manual intervention rates."
    - name: "received_date_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the payment was received. Enables monthly cash collection trend and seasonality analysis."
    - name: "gl_period"
      expr: gl_period
      comment: "General ledger period for the payment. Required for period-accurate financial reporting."
  measures:
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total cash received from clients. Primary cash collection KPI for the CFO and collections leadership."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices. Measures effective cash allocation and AR reduction."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet allocated to invoices. Tracks unallocated cash liability and allocation backlog."
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayments received. Tracks client credit exposure and refund liability."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted at payment time. Measures early payment discount cost and pricing discipline."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amounts written off at payment processing. Tracks bad debt realisation and collection failure."
    - name: "total_wip_cleared_amount"
      expr: SUM(CAST(wip_cleared_amount AS DOUBLE))
      comment: "Total WIP cleared through payment. Measures billing-to-cash conversion effectiveness."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments converted to firm functional currency. Required for consolidated cash reporting across currencies."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments processed. Baseline volume metric for collections throughput monitoring."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of payments that have been reversed. High reversal rates indicate payment processing or client dispute issues."
    - name: "trust_payment_count"
      expr: COUNT(CASE WHEN is_trust_payment = TRUE THEN 1 END)
      comment: "Number of payments sourced from trust accounts. Required for trust accounting compliance monitoring."
    - name: "avg_received_amount"
      expr: AVG(CAST(received_amount AS DOUBLE))
      comment: "Average payment amount received. Benchmarks typical client payment size and supports cash flow forecasting."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off KPIs covering revenue leakage, write-off categories, approval patterns, and hours written off. Enables firm leadership to monitor bad debt exposure, partner write-off behaviour, and profitability erosion."
  source: "`legal_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write-off (e.g. Pending Approval, Approved, Reversed). Tracks write-off pipeline and approval backlog."
    - name: "write_off_type"
      expr: write_off_type
      comment: "Classification of the write-off (e.g. Bad Debt, Fee Reduction, Courtesy, Dispute Settlement). Enables root cause analysis of revenue leakage."
    - name: "write_off_category"
      expr: write_off_category
      comment: "Broader category grouping for write-offs. Supports strategic analysis of write-off drivers."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason code for the write-off. Enables granular analysis of write-off causes and process improvement targeting."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type associated with the write-off. Supports write-off analysis by billing model."
    - name: "office_code"
      expr: office_code
      comment: "Office responsible for the write-off. Enables office-level write-off rate benchmarking."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Indicates whether this is a reversal of a prior write-off. Required to distinguish net write-off activity from gross."
    - name: "requires_secondary_approval"
      expr: requires_secondary_approval
      comment: "Indicates whether the write-off requires secondary approval. Tracks governance compliance for large write-offs."
    - name: "write_off_date_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month the write-off was recorded. Enables monthly write-off trend and fiscal period analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the write-off. Required for period-accurate P&L impact reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write-off. Required for multi-currency write-off reporting."
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value written off. Primary revenue leakage KPI. Directly impacts firm profitability and partner compensation."
    - name: "total_functional_currency_write_off"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total write-off value in firm functional currency. Required for consolidated P&L impact reporting."
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total write-down component of write-offs. Distinguishes partial rate/hour reductions from full bad debt write-offs."
    - name: "total_hours_written_off"
      expr: SUM(CAST(hours_written_off AS DOUBLE))
      comment: "Total timekeeper hours written off. Measures productivity loss and non-recoverable time investment."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original billed amount before write-off. Baseline for write-off rate calculation."
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off transactions. Baseline volume metric for write-off frequency monitoring."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of write-off reversals. Tracks recovery of previously written-off amounts."
    - name: "pending_secondary_approval_count"
      expr: COUNT(CASE WHEN requires_secondary_approval = TRUE AND write_off_status = 'Pending Approval' THEN 1 END)
      comment: "Number of write-offs pending secondary approval. Tracks governance bottlenecks for large write-off requests."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per transaction. Benchmarks write-off size and identifies outlier events."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute KPIs covering dispute volumes, disputed amounts, resolution rates, and escalation patterns. Enables billing leadership to monitor client satisfaction, billing quality, and dispute resolution efficiency."
  source: "`legal_ecm`.`billing`.`invoice_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, Under Review, Resolved, Escalated). Primary dimension for dispute pipeline management."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Classification of the dispute (e.g. Rate Dispute, Narrative Dispute, Duplicate Billing, Guideline Violation). Enables root cause analysis of billing quality issues."
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Specific reason code for the dispute. Supports granular billing quality improvement analysis."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g. Credit Issued, Amount Reduced, Upheld, Written-Off). Tracks dispute outcome patterns."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type associated with the disputed invoice. Enables dispute analysis by billing model."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the dispute has been escalated. Tracks high-risk disputes requiring senior intervention."
    - name: "write_off_approved"
      expr: write_off_approved
      comment: "Indicates whether a write-off was approved as part of dispute resolution. Tracks dispute-driven revenue leakage."
    - name: "lpp_flag"
      expr: lpp_flag
      comment: "Indicates whether the dispute involves legally privileged content. Required for privilege protection compliance."
    - name: "office_code"
      expr: office_code
      comment: "Office associated with the disputed invoice. Enables office-level dispute rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed invoice. Required for multi-currency dispute exposure reporting."
    - name: "dispute_date_month"
      expr: DATE_TRUNC('MONTH', dispute_date)
      comment: "Month the dispute was raised. Enables monthly dispute trend and billing quality monitoring."
    - name: "resolution_date_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the dispute was resolved. Supports resolution cycle time and backlog analysis."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of invoiced amounts under dispute. Primary billing quality and revenue-at-risk KPI."
    - name: "total_agreed_reduction_amount"
      expr: SUM(CAST(agreed_reduction_amount AS DOUBLE))
      comment: "Total amount agreed to be reduced as dispute resolution. Measures concession cost and billing quality impact on revenue."
    - name: "total_invoice_amount_disputed"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total original invoice value for disputed invoices. Baseline for dispute rate calculation."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of invoice disputes raised. Baseline volume metric for billing quality monitoring."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of disputes that have been escalated. High escalation rates signal systemic billing quality or client relationship issues."
    - name: "write_off_approved_dispute_count"
      expr: COUNT(CASE WHEN write_off_approved = TRUE THEN 1 END)
      comment: "Number of disputes resolved via write-off approval. Tracks dispute-driven revenue leakage frequency."
    - name: "resolved_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'Resolved' THEN 1 END)
      comment: "Number of disputes successfully resolved. Supports resolution rate calculation and backlog management."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Benchmarks dispute size and identifies high-value dispute patterns."
    - name: "avg_agreed_reduction_amount"
      expr: AVG(CAST(agreed_reduction_amount AS DOUBLE))
      comment: "Average concession amount per resolved dispute. Tracks negotiation outcomes and billing quality cost."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_fee_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee arrangement portfolio KPIs covering arrangement types, agreed values, caps, retainer levels, and discount rates. Enables pricing leadership to monitor fee arrangement mix, budget adherence, and alternative fee arrangement adoption."
  source: "`legal_ecm`.`billing`.`fee_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the fee arrangement (e.g. Active, Expired, Terminated, Pending). Tracks active billing relationship portfolio."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing under the arrangement (e.g. Monthly, Quarterly, Milestone). Supports cash flow forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fee arrangement. Required for multi-currency portfolio reporting."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the fee arrangement. Enables jurisdictional pricing and compliance analysis."
    - name: "expenses_billable"
      expr: expenses_billable
      comment: "Indicates whether expenses are billable under the arrangement. Tracks expense recovery policy across the portfolio."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Indicates whether tax applies to the arrangement. Required for tax liability and compliance reporting."
    - name: "portfolio_arrangement"
      expr: portfolio_arrangement
      comment: "Indicates whether this is a portfolio-level arrangement covering multiple matters. Tracks enterprise client billing structures."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the arrangement became effective. Enables cohort analysis of fee arrangement vintages."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the arrangement expires. Supports renewal pipeline and revenue continuity planning."
    - name: "ledes_billing_format"
      expr: ledes_billing_format
      comment: "LEDES billing format required by the arrangement. Tracks e-billing format compliance across the portfolio."
  measures:
    - name: "total_agreed_amount"
      expr: SUM(CAST(agreed_amount AS DOUBLE))
      comment: "Total contracted fee value across all arrangements. Measures committed revenue pipeline from fixed and capped arrangements."
    - name: "total_fee_cap_amount"
      expr: SUM(CAST(fee_cap_amount AS DOUBLE))
      comment: "Total fee cap exposure across arrangements. Tracks maximum revenue ceiling and budget risk for capped matters."
    - name: "total_expense_cap_amount"
      expr: SUM(CAST(expense_cap_amount AS DOUBLE))
      comment: "Total expense cap across arrangements. Monitors disbursement recovery ceiling and cost exposure."
    - name: "total_retainer_amount"
      expr: SUM(CAST(retainer_amount AS DOUBLE))
      comment: "Total retainer amounts committed under fee arrangements. Tracks advance payment pipeline and cash flow certainty."
    - name: "total_success_fee_amount"
      expr: SUM(CAST(success_fee_amount AS DOUBLE))
      comment: "Total success fee potential across contingency arrangements. Measures upside revenue from outcome-based billing."
    - name: "arrangement_count"
      expr: COUNT(1)
      comment: "Total number of fee arrangements. Baseline portfolio size metric for pricing and relationship management."
    - name: "active_arrangement_count"
      expr: COUNT(CASE WHEN arrangement_status = 'Active' THEN 1 END)
      comment: "Number of currently active fee arrangements. Tracks live billing relationship portfolio size."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage granted across arrangements. Tracks pricing discipline and rate concession trends."
    - name: "avg_blended_hourly_rate"
      expr: AVG(CAST(blended_hourly_rate AS DOUBLE))
      comment: "Average blended hourly rate across arrangements. Benchmarks effective billing rate and rate card adherence."
    - name: "avg_contingency_rate_pct"
      expr: AVG(CAST(contingency_rate_pct AS DOUBLE))
      comment: "Average contingency fee percentage across contingency arrangements. Tracks risk-sharing pricing terms."
    - name: "avg_write_off_limit_pct"
      expr: AVG(CAST(write_off_limit_pct AS DOUBLE))
      comment: "Average write-off limit percentage permitted under arrangements. Monitors contractual write-off exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_credit_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit note KPIs covering credit volumes, credit types, fee and disbursement credits, and pro bono adjustments. Enables billing leadership to monitor revenue adjustments, dispute-driven credits, and billing correction patterns."
  source: "`legal_ecm`.`billing`.`credit_note`"
  dimensions:
    - name: "credit_note_status"
      expr: credit_note_status
      comment: "Current status of the credit note (e.g. Draft, Approved, Applied, Voided). Tracks credit pipeline and approval backlog."
    - name: "credit_type"
      expr: credit_type
      comment: "Classification of the credit (e.g. Fee Credit, Disbursement Credit, Tax Credit, Full Credit). Enables credit composition analysis."
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Specific reason code for the credit note. Supports root cause analysis of billing adjustments."
    - name: "application_method"
      expr: application_method
      comment: "How the credit was applied (e.g. Against Invoice, Refund, On Account). Tracks credit utilisation patterns."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type associated with the credit note. Enables credit analysis by billing model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit note. Required for multi-currency credit reporting."
    - name: "pro_bono_flag"
      expr: pro_bono_flag
      comment: "Indicates whether the credit relates to pro bono work. Required for pro bono commitment and CSR reporting."
    - name: "write_off_approved_flag"
      expr: write_off_approved_flag
      comment: "Indicates whether a write-off was approved in connection with the credit note. Tracks dispute-driven revenue leakage."
    - name: "office_code"
      expr: office_code
      comment: "Office issuing the credit note. Enables office-level credit rate benchmarking."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the credit note was issued. Enables monthly credit trend and billing quality monitoring."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for the credit note. Required for tax credit compliance and jurisdictional reporting."
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total value of credit notes issued. Primary revenue adjustment KPI measuring billing correction and concession exposure."
    - name: "total_fee_credit_amount"
      expr: SUM(CAST(fee_credit_amount AS DOUBLE))
      comment: "Total fee credits issued. Measures professional fee revenue reductions from billing adjustments."
    - name: "total_disbursement_credit_amount"
      expr: SUM(CAST(disbursement_credit_amount AS DOUBLE))
      comment: "Total disbursement credits issued. Tracks expense recovery reductions and cost credit exposure."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credits issued. Required for tax liability adjustment and compliance reporting."
    - name: "total_functional_currency_credit"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total credit value in firm functional currency. Required for consolidated P&L impact reporting."
    - name: "credit_note_count"
      expr: COUNT(1)
      comment: "Total number of credit notes issued. Baseline volume metric for billing quality and adjustment frequency monitoring."
    - name: "write_off_approved_credit_count"
      expr: COUNT(CASE WHEN write_off_approved_flag = TRUE THEN 1 END)
      comment: "Number of credit notes with associated write-off approval. Tracks dispute-driven revenue leakage frequency."
    - name: "avg_total_credit_amount"
      expr: AVG(CAST(total_credit_amount AS DOUBLE))
      comment: "Average credit note value. Benchmarks typical credit size and identifies outlier billing adjustment events."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_retainer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retainer portfolio KPIs covering retainer balances, drawdown activity, replenishment status, and compliance flags. Enables finance and client relationship teams to monitor advance payment health, trust compliance, and retainer sufficiency."
  source: "`legal_ecm`.`billing`.`retainer`"
  dimensions:
    - name: "retainer_status"
      expr: retainer_status
      comment: "Current status of the retainer (e.g. Active, Depleted, Expired, Terminated). Primary dimension for retainer portfolio health monitoring."
    - name: "retainer_type"
      expr: retainer_type
      comment: "Classification of the retainer (e.g. General, Matter-Specific, Evergreen). Supports retainer structure analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of retainer billing or replenishment. Supports cash flow forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the retainer. Required for multi-currency retainer portfolio reporting."
    - name: "evergreen_flag"
      expr: evergreen_flag
      comment: "Indicates whether the retainer auto-replenishes. Tracks evergreen retainer adoption and cash flow certainty."
    - name: "interest_bearing_flag"
      expr: interest_bearing_flag
      comment: "Indicates whether the retainer earns interest. Required for IOLTA and trust accounting compliance."
    - name: "kyc_verified_flag"
      expr: kyc_verified_flag
      comment: "Indicates whether KYC verification has been completed for the retainer. Required for AML/KYC compliance monitoring."
    - name: "refundable_flag"
      expr: refundable_flag
      comment: "Indicates whether the retainer is refundable. Tracks refund liability exposure in the retainer portfolio."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the retainer is tax-exempt. Required for tax compliance and reporting."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the retainer. Enables jurisdictional compliance and regulatory analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the retainer became effective. Enables cohort analysis of retainer vintages."
    - name: "practice_group_code"
      expr: practice_group_code
      comment: "Practice group associated with the retainer. Enables practice group-level retainer portfolio analysis."
  measures:
    - name: "total_current_retainer_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all active retainers. Primary retainer liquidity KPI for finance leadership."
    - name: "total_original_retainer_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original retainer amounts committed. Baseline for drawdown rate and retainer utilisation analysis."
    - name: "total_drawn_to_date"
      expr: SUM(CAST(total_drawn_to_date AS DOUBLE))
      comment: "Total amount drawn from retainers to date. Measures retainer utilisation and billing conversion from advance payments."
    - name: "total_replenished_to_date"
      expr: SUM(CAST(total_replenished_to_date AS DOUBLE))
      comment: "Total amount replenished into retainers to date. Tracks client commitment to maintaining retainer levels."
    - name: "total_replenishment_target_amount"
      expr: SUM(CAST(replenishment_target_amount AS DOUBLE))
      comment: "Total replenishment target across retainers requiring top-up. Measures upcoming cash inflow from retainer replenishments."
    - name: "retainer_count"
      expr: COUNT(1)
      comment: "Total number of retainers in the portfolio. Baseline metric for retainer relationship coverage."
    - name: "active_retainer_count"
      expr: COUNT(CASE WHEN retainer_status = 'Active' THEN 1 END)
      comment: "Number of currently active retainers. Tracks live advance payment relationships."
    - name: "kyc_unverified_retainer_count"
      expr: COUNT(CASE WHEN kyc_verified_flag = FALSE THEN 1 END)
      comment: "Number of retainers without completed KYC verification. Critical AML/KYC compliance risk indicator."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current retainer balance. Benchmarks retainer size and client advance payment commitment."
    - name: "avg_replenishment_threshold"
      expr: AVG(CAST(replenishment_threshold AS DOUBLE))
      comment: "Average replenishment threshold across retainers. Tracks minimum balance requirements and cash flow trigger levels."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disbursement KPIs covering expense volumes, recovery rates, tax exposure, and write-downs. Enables billing and finance teams to monitor cost recovery performance, expense category mix, and disbursement billing compliance."
  source: "`legal_ecm`.`billing`.`billing_disbursement`"
  dimensions:
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement (e.g. Pending, Approved, Billed, Written-Off). Tracks disbursement billing pipeline."
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Classification of the disbursement (e.g. Court Filing, Expert Witness, Travel, Photocopying). Enables expense category analysis."
    - name: "expense_category"
      expr: expense_category
      comment: "Broader expense category for the disbursement. Supports cost recovery analysis by expense type."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the disbursement is billable to the client. Core dimension for cost recovery analysis."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Indicates whether the disbursement is subject to tax. Required for tax compliance and invoice accuracy."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of disbursement cost recovery (e.g. Recovered, Partially Recovered, Written-Off). Tracks expense recovery effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disbursement. Required for multi-currency expense reporting."
    - name: "office_code"
      expr: office_code
      comment: "Office incurring the disbursement. Enables office-level expense analysis."
    - name: "utbms_expense_code"
      expr: utbms_expense_code
      comment: "UTBMS expense code for the disbursement. Required for e-billing compliance and client expense reporting."
    - name: "expense_date_month"
      expr: DATE_TRUNC('MONTH', expense_date)
      comment: "Month the expense was incurred. Enables monthly disbursement trend and cost recovery analysis."
    - name: "billing_period"
      expr: billing_period
      comment: "Billing period in which the disbursement was included. Supports period-accurate cost recovery reporting."
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total disbursement cost incurred. Measures total expense exposure requiring client recovery."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total disbursement amount billed to clients. Measures actual cost recovery billed."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total disbursement amount in firm base currency. Required for consolidated expense reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on disbursements. Required for tax liability and compliance reporting."
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total disbursement write-downs. Measures expense recovery leakage from billing adjustments."
    - name: "disbursement_count"
      expr: COUNT(1)
      comment: "Total number of disbursement entries. Baseline volume metric for expense processing throughput."
    - name: "billable_disbursement_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable disbursements. Supports cost recovery rate calculation."
    - name: "avg_disbursement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average disbursement amount. Benchmarks typical expense size and identifies outlier cost events."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage applied to disbursements. Tracks pricing discipline on expense recovery."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_timekeeper_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timekeeper rate KPIs covering rate levels, discounts, rate increases, and client-agreed rates. Enables pricing leadership to monitor rate card adherence, rate negotiation outcomes, and rate increase effectiveness."
  source: "`legal_ecm`.`billing`.`timekeeper_rate`"
  dimensions:
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the timekeeper rate (e.g. Active, Superseded, Expired, Pending Approval). Tracks live rate portfolio."
    - name: "rate_type"
      expr: rate_type
      comment: "Classification of the rate (e.g. Standard, Blended, Discounted, Pro Bono). Enables rate mix analysis."
    - name: "rate_category"
      expr: rate_category
      comment: "Broader rate category (e.g. Partner, Associate, Paralegal, Expert). Supports rate benchmarking by timekeeper category."
    - name: "timekeeper_level"
      expr: timekeeper_level
      comment: "Seniority level of the timekeeper. Primary dimension for rate analysis and staffing mix optimisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate. Required for multi-currency rate portfolio reporting."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for which the rate applies. Enables jurisdictional rate benchmarking and compliance."
    - name: "office_code"
      expr: office_code
      comment: "Office associated with the rate. Enables office-level rate analysis."
    - name: "client_agreed"
      expr: client_agreed
      comment: "Indicates whether the rate has been formally agreed with the client. Tracks rate approval compliance."
    - name: "pro_bono_flag"
      expr: pro_bono_flag
      comment: "Indicates whether the rate is a pro bono rate. Required for pro bono commitment tracking."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for the rate (e.g. Hourly, Daily, Fixed). Supports rate structure analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the rate became effective. Enables rate vintage and rate increase timing analysis."
    - name: "afa_arrangement_code"
      expr: afa_arrangement_code
      comment: "Alternative fee arrangement code associated with the rate. Tracks AFA adoption across the rate portfolio."
  measures:
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across timekeepers. Primary rate benchmarking KPI for pricing leadership and rate negotiations."
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rack rate. Baseline for discount and realization rate analysis."
    - name: "avg_rate_discount_pct"
      expr: AVG(CAST(rate_discount_pct AS DOUBLE))
      comment: "Average rate discount percentage granted to clients. Tracks pricing discipline and rate concession trends."
    - name: "avg_rate_increase_pct"
      expr: AVG(CAST(rate_increase_pct AS DOUBLE))
      comment: "Average rate increase percentage applied. Monitors rate inflation management and client rate increase acceptance."
    - name: "total_rate_cap_amount"
      expr: SUM(CAST(rate_cap_amount AS DOUBLE))
      comment: "Total rate cap exposure across timekeeper rates. Tracks maximum rate ceiling commitments to clients."
    - name: "rate_count"
      expr: COUNT(1)
      comment: "Total number of timekeeper rate records. Baseline portfolio size metric for rate management."
    - name: "client_agreed_rate_count"
      expr: COUNT(CASE WHEN client_agreed = TRUE THEN 1 END)
      comment: "Number of rates formally agreed with clients. Tracks rate approval compliance and negotiation completion rate."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN rate_status = 'Active' THEN 1 END)
      comment: "Number of currently active timekeeper rates. Tracks live rate portfolio size."
    - name: "avg_rate_floor_amount"
      expr: AVG(CAST(rate_floor_amount AS DOUBLE))
      comment: "Average rate floor amount across timekeeper rates. Monitors minimum rate commitments and pricing floor discipline."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`billing_prebill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-bill review KPIs covering WIP conversion, billing guideline compliance, write-down activity, and billing cycle efficiency. Enables billing managers to monitor pre-bill throughput, guideline violation rates, and billing velocity."
  source: "`legal_ecm`.`billing`.`prebill`"
  dimensions:
    - name: "prebill_status"
      expr: prebill_status
      comment: "Current status of the pre-bill (e.g. Draft, Under Review, Approved, Rejected, Converted). Tracks billing pipeline throughput."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type governing the pre-bill. Enables billing analysis by arrangement type."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the pre-bill. Supports billing cycle analysis."
    - name: "billing_guideline_compliant"
      expr: billing_guideline_compliant
      comment: "Indicates whether the pre-bill is compliant with applicable billing guidelines. Tracks e-billing readiness and rejection risk."
    - name: "narrative_edited"
      expr: narrative_edited
      comment: "Indicates whether narratives were edited during pre-bill review. Tracks billing quality improvement activity."
    - name: "office_code"
      expr: office_code
      comment: "Office generating the pre-bill. Enables office-level billing throughput analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pre-bill. Required for multi-currency billing pipeline reporting."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month the billing period commenced. Enables period-over-period billing pipeline comparison."
    - name: "generated_date_month"
      expr: DATE_TRUNC('MONTH', generated_date)
      comment: "Month the pre-bill was generated. Supports billing cycle timing and velocity analysis."
  measures:
    - name: "total_proposed_fees_amount"
      expr: SUM(CAST(proposed_fees_amount AS DOUBLE))
      comment: "Total proposed fee value across pre-bills. Measures near-term billing pipeline and revenue conversion potential."
    - name: "total_proposed_disbursements_amount"
      expr: SUM(CAST(proposed_disbursements_amount AS DOUBLE))
      comment: "Total proposed disbursements in pre-bills. Tracks expense recovery pipeline."
    - name: "total_proposed_total_amount"
      expr: SUM(CAST(proposed_total_amount AS DOUBLE))
      comment: "Total proposed invoice value across all pre-bills. Primary billing pipeline KPI for revenue forecasting."
    - name: "total_wip_fees_amount"
      expr: SUM(CAST(wip_fees_amount AS DOUBLE))
      comment: "Total WIP fees included in pre-bills. Measures WIP-to-invoice conversion pipeline."
    - name: "total_fee_writedown_amount"
      expr: SUM(CAST(fee_writedown_amount AS DOUBLE))
      comment: "Total fee write-downs applied during pre-bill review. Measures revenue reduction from billing adjustments before invoicing."
    - name: "total_fee_writeup_amount"
      expr: SUM(CAST(fee_writeup_amount AS DOUBLE))
      comment: "Total fee write-ups applied during pre-bill review. Tracks upward billing adjustments and premium billing activity."
    - name: "total_hours_billed"
      expr: SUM(CAST(total_hours_billed AS DOUBLE))
      comment: "Total hours included in pre-bills. Baseline productivity metric for billing throughput analysis."
    - name: "prebill_count"
      expr: COUNT(1)
      comment: "Total number of pre-bills generated. Baseline volume metric for billing cycle throughput monitoring."
    - name: "non_compliant_prebill_count"
      expr: COUNT(CASE WHEN billing_guideline_compliant = FALSE THEN 1 END)
      comment: "Number of pre-bills with billing guideline violations. High counts signal e-billing rejection risk and client relationship issues."
    - name: "avg_proposed_total_amount"
      expr: AVG(CAST(proposed_total_amount AS DOUBLE))
      comment: "Average proposed invoice value per pre-bill. Benchmarks matter billing size and billing intensity."
    - name: "avg_total_hours_billed"
      expr: AVG(CAST(total_hours_billed AS DOUBLE))
      comment: "Average hours billed per pre-bill. Tracks billing intensity and matter effort levels."
$$;