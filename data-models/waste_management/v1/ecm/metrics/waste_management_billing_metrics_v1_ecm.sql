-- Metric views for domain: billing | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice metrics tracking revenue, payment performance, and dispute rates across billing cycles and customer segments"
  source: "`waste_management_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, issued, paid, overdue, disputed)"
    - name: "billing_cycle"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing cycle month for period-over-period analysis"
    - name: "customer_segment"
      expr: customer_type
      comment: "Customer type segment (residential, commercial, industrial)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms applied to the invoice"
    - name: "billing_model"
      expr: billing_model_type
      comment: "Billing model type (subscription, usage-based, hybrid)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice has been disputed by the customer"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Invoice delivery method (email, postal, portal)"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid across all invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount per invoice"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected (paid / total invoiced)"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices disputed by customers"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all invoices"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to invoices"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics tracking aging, credit risk, and collection performance by account status and customer segment"
  source: "`waste_management_ecm`.`billing`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the AR account (active, suspended, closed)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the account (current, delinquent, in collections)"
    - name: "credit_status"
      expr: credit_status
      comment: "Credit status of the account (good standing, on hold, review)"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for collections escalation"
    - name: "payment_plan_active"
      expr: payment_plan_flag
      comment: "Whether the account is on a payment plan"
    - name: "auto_pay_enrolled"
      expr: auto_pay_enrolled_flag
      comment: "Whether the account is enrolled in auto-pay"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the account is on credit hold"
  measures:
    - name: "total_ar_accounts"
      expr: COUNT(1)
      comment: "Total number of AR accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all AR accounts"
    - name: "total_aging_0_30_days"
      expr: SUM(CAST(aging_bucket_0_30_days AS DOUBLE))
      comment: "Total receivables aged 0-30 days"
    - name: "total_aging_31_60_days"
      expr: SUM(CAST(aging_bucket_31_60_days AS DOUBLE))
      comment: "Total receivables aged 31-60 days"
    - name: "total_aging_61_90_days"
      expr: SUM(CAST(aging_bucket_61_90_days AS DOUBLE))
      comment: "Total receivables aged 61-90 days"
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_bucket_over_90_days AS DOUBLE))
      comment: "Total receivables aged over 90 days"
    - name: "delinquency_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(aging_bucket_31_60_days AS DOUBLE)) + SUM(CAST(aging_bucket_61_90_days AS DOUBLE)) + SUM(CAST(aging_bucket_over_90_days AS DOUBLE))) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of current balance that is past 30 days"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per AR account"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount currently in dispute"
    - name: "total_bad_debt_reserve"
      expr: SUM(CAST(bad_debt_reserve AS DOUBLE))
      comment: "Total bad debt reserve across all accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit across all accounts"
    - name: "credit_utilization_pct"
      expr: ROUND(100.0 * (SUM(CAST(credit_limit AS DOUBLE)) - SUM(CAST(available_credit AS DOUBLE))) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of credit limit utilized across all accounts"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment metrics tracking collection efficiency, payment methods, and processing performance"
  source: "`waste_management_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (pending, cleared, failed, reversed)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (standard, prepayment, refund)"
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which payment was received (online, mail, in-person)"
    - name: "payment_processor"
      expr: processor
      comment: "Payment processor used for the transaction"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month when payment was received"
    - name: "refund_status"
      expr: refund_status
      comment: "Refund status if applicable"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount not yet applied to invoices"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payment amount applied to invoices"
    - name: "total_nsf_fees"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF (non-sufficient funds) fees assessed"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_fee_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments with NSF fees (failed payment rate)"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute resolution metrics tracking dispute volume, resolution time, and financial impact by reason and status"
  source: "`waste_management_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, under review, resolved, closed)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the dispute"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution (customer favor, company favor, partial adjustment)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the dispute"
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the dispute"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the dispute resolution breached SLA"
    - name: "dispute_month"
      expr: DATE_TRUNC('month', dispute_date)
      comment: "Month when dispute was raised"
  measures:
    - name: "total_dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount disputed by customers"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued to resolve disputes"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued to resolve disputes"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average amount disputed per dispute case"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that have been resolved"
    - name: "credit_resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount resolved via credit"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that breached resolution SLA"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment metrics tracking revenue impact, adjustment reasons, and approval patterns"
  source: "`waste_management_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (pending, approved, posted, reversed)"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (credit, debit, write-off, correction)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this adjustment reverses a prior adjustment"
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Whether this adjustment is a write-off"
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Whether this adjustment is related to bad debt"
    - name: "adjustment_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when adjustment became effective"
  measures:
    - name: "total_adjustment_count"
      expr: COUNT(1)
      comment: "Total number of adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total adjustment amount (positive or negative)"
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of all adjustments"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from adjustments"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per adjustment"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are write-offs"
    - name: "bad_debt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bad_debt_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments related to bad debt"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(ABS(SUM(CAST(amount AS DOUBLE))), 0), 2)
      comment: "Percentage of adjustment amount recovered"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan performance metrics tracking enrollment, completion rates, and default risk"
  source: "`waste_management_ecm`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (active, completed, defaulted, cancelled)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (standard, hardship, settlement)"
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (weekly, bi-weekly, monthly)"
    - name: "auto_pay_enabled"
      expr: auto_pay_enabled_flag
      comment: "Whether auto-pay is enabled for the plan"
    - name: "approval_required"
      expr: approval_required_flag
      comment: "Whether the plan required approval"
    - name: "plan_start_month"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Month when payment plan started"
  measures:
    - name: "total_payment_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans"
    - name: "total_enrolled_balance"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total balance enrolled in payment plans"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid under payment plans"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining balance on payment plans"
    - name: "total_late_fees"
      expr: SUM(CAST(total_late_fees_assessed AS DOUBLE))
      comment: "Total late fees assessed on payment plans"
    - name: "avg_enrolled_balance"
      expr: AVG(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Average balance enrolled per payment plan"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(enrolled_balance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of enrolled balance paid (plan completion rate)"
    - name: "avg_missed_installments"
      expr: AVG(CAST(missed_installment_count AS DOUBLE))
      comment: "Average number of missed installments per plan"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off metrics tracking bad debt expense, recovery performance, and write-off reasons"
  source: "`waste_management_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write-off (pending, approved, posted, reversed)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write-off"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the write-off"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this write-off has been reversed"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether SOX controls apply to this write-off"
    - name: "write_off_month"
      expr: DATE_TRUNC('month', write_off_date)
      comment: "Month when write-off was executed"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the write-off"
  measures:
    - name: "total_write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-offs"
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered after write-off"
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per write-off"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of written-off amount subsequently recovered"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of write-offs that were reversed"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking deferred revenue, recognition timing, and compliance with accounting standards"
  source: "`waste_management_ecm`.`billing`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of revenue recognition (pending, recognized, deferred, reversed)"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition (point-in-time, over-time, milestone)"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue (service, product, subscription)"
    - name: "revenue_stream_type"
      expr: revenue_stream_type
      comment: "Type of revenue stream"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this recognition has been reversed"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether SOX controls apply to this recognition"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of revenue recognition"
    - name: "recognition_month"
      expr: DATE_TRUNC('month', recognition_date)
      comment: "Month when revenue was recognized"
  measures:
    - name: "total_recognition_events"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred for future recognition"
    - name: "total_unbilled_amount"
      expr: SUM(CAST(unbilled_amount AS DOUBLE))
      comment: "Total unbilled revenue"
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price across all recognition events"
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average revenue recognized per event"
    - name: "recognition_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Percentage of transaction price recognized as revenue"
    - name: "deferral_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Percentage of transaction price deferred"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage for over-time recognition"
$$;