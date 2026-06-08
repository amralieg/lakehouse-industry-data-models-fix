-- Metric views for domain: billing | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue and collection metrics derived from the invoice fact table"
  source: "`energy_utilities_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle identifier"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., regular, credit memo)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts"
    - name: "service_agreement"
      expr: service_agreement
      comment: "Associated service agreement identifier"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for time‑based analysis"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount billed on invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Sum of outstanding balances across invoices"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount per invoice"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices issued"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN payment_received_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of invoices with any payment received"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection performance metrics"
  source: "`energy_utilities_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., credit card, ACH)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current processing status of the payment"
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment (e.g., regular, refund)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "service_agreement"
      expr: service_agreement
      comment: "Service agreement linked to the payment"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of the payment date"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of payments received"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "total_reversed_amount"
      expr: SUM(CASE WHEN reversal_flag THEN amount ELSE 0 END)
      comment: "Sum of payment amounts that were reversed"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on billing adjustments affecting revenue and receivables"
  source: "`energy_utilities_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of the adjustment (e.g., credit, debit)"
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date the adjustment was recorded"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment amount"
    - name: "service_agreement"
      expr: service_agreement
      comment: "Service agreement linked to the adjustment"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates if the adjustment is a reversal"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of adjustments"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustment records"
    - name: "average_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average amount per adjustment"
    - name: "total_reversal_amount"
      expr: SUM(CASE WHEN reversal_flag THEN amount ELSE 0 END)
      comment: "Sum of adjustment amounts that were reversed"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_bill_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer dispute metrics to monitor billing issues and satisfaction"
  source: "`energy_utilities_ecm`.`billing`.`bill_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code categorizing the dispute cause"
    - name: "dispute_open_month"
      expr: DATE_TRUNC('month', dispute_open_date)
      comment: "Month when the dispute was opened"
    - name: "service_agreement"
      expr: service_agreement
      comment: "Service agreement associated with the dispute"
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of bill disputes opened"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Sum of amounts under dispute"
    - name: "average_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average amount per dispute"
    - name: "resolved_dispute_count"
      expr: SUM(CASE WHEN dispute_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of disputes that have been resolved"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational performance of billing runs"
  source: "`energy_utilities_ecm`.`billing`.`billing_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Final status of the billing run"
    - name: "run_type"
      expr: run_type
      comment: "Type of run (e.g., scheduled, manual)"
    - name: "run_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month of the billing period covered by the run"
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed in the run"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied during the run"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected in the run"
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of billing runs (should be 1 per view instance)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning effectiveness and revenue impact metrics"
  source: "`energy_utilities_ecm`.`billing`.`dunning_notice`"
  dimensions:
    - name: "dunning_level"
      expr: dunning_level
      comment: "Level of dunning (e.g., first, second)"
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current status of the dunning notice"
    - name: "action_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month when the dunning action occurred"
  measures:
    - name: "total_dunning_fee"
      expr: SUM(CAST(dunning_fee AS DOUBLE))
      comment: "Total dunning fees assessed"
    - name: "total_late_payment_fee"
      expr: SUM(CAST(late_payment_fee AS DOUBLE))
      comment: "Total late payment fees assessed"
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Aggregate amount due across all notices"
    - name: "notice_count"
      expr: COUNT(1)
      comment: "Number of dunning notices issued"
$$;