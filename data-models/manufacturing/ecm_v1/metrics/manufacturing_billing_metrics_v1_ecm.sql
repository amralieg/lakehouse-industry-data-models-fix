-- Metric views for domain: billing | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial performance of invoices"
  source: "`manufacturing_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Paid, Open, Cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (e.g., Standard, Credit Memo)"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "average_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per invoice"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoice records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection effectiveness"
  source: "`manufacturing_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current processing status of the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, Credit Card)"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount received via payments"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net payment amount"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`billing_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre‑payment activity and cash flow forecasting"
  source: "`manufacturing_ecm`.`billing`.`payment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "advance_payment_count"
      expr: COUNT(1)
      comment: "Number of advance payment records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`billing_collections`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness and risk of collection activities"
  source: "`manufacturing_ecm`.`billing`.`collections`"
  dimensions:
    - name: "collection_stage"
      expr: collection_stage
      comment: "Current stage of the collection process (e.g., Initial, Escalated)"
  measures:
    - name: "total_dunning_charges"
      expr: SUM(CAST(dunning_charges AS DOUBLE))
      comment: "Total dunning (late fee) charges applied"
    - name: "total_gross_exposure"
      expr: SUM(CAST(gross_exposure_amount AS DOUBLE))
      comment: "Total gross exposure amount across collections"
    - name: "total_net_exposure"
      expr: SUM(CAST(net_exposure_amount AS DOUBLE))
      comment: "Total net exposure amount across collections"
    - name: "collection_record_count"
      expr: COUNT(1)
      comment: "Number of collection records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and volume of invoice disputes"
  source: "`manufacturing_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., Open, Resolved)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the dispute"
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total monetary value under dispute"
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of dispute cases"
$$;