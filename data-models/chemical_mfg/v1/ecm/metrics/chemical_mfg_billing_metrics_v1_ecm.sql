-- Metric views for domain: billing | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial performance of invoices"
  source: "`chemical_mfg_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (e.g., standard, credit)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the invoice"
    - name: "is_electronic_invoice"
      expr: is_electronic_invoice
      comment: "Flag indicating electronic invoice"
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag indicating tax exemption"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for time‑based analysis"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Due month for aging analysis"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of invoice gross amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of invoice net amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts across invoices"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per invoice"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoice records"
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of unique accounts billed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed line‑item financial metrics"
  source: "`chemical_mfg_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the invoice line item"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line"
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the line item"
    - name: "product_description"
      expr: product_description
      comment: "Description of the product sold"
    - name: "line_month"
      expr: DATE_TRUNC('month', accounting_date)
      comment: "Accounting month for the line item"
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Sum of line item amounts"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity sold across line items"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per line item"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts on line items"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs sold"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_ar_open_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and exposure metrics"
  source: "`chemical_mfg_ecm`.`billing`.`ar_open_item`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification"
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR amount"
    - name: "credit_memo_flag"
      expr: credit_memo_flag
      comment: "Flag indicating presence of a credit memo"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating a dispute exists"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting month for time analysis"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Due month for aging analysis"
  measures:
    - name: "total_outstanding_amount"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Sum of outstanding AR amounts"
    - name: "total_original_amount"
      expr: SUM(CAST(amount_original AS DOUBLE))
      comment: "Sum of original AR amounts"
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Sum of credit memo amounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Sum of write‑off amounts"
    - name: "open_item_count"
      expr: COUNT(1)
      comment: "Number of AR open item records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for recurring billing schedules"
  source: "`chemical_mfg_ecm`.`billing`.`billing_schedule`"
  dimensions:
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing (e.g., monthly, quarterly)"
    - name: "billing_interval"
      expr: billing_interval
      comment: "Interval descriptor for the schedule"
    - name: "billing_schedule_status"
      expr: billing_schedule_status
      comment: "Current status of the schedule"
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency used for the schedule"
    - name: "is_milestone_based"
      expr: is_milestone_based
      comment: "Flag indicating milestone‑based billing"
    - name: "fixed_amount_flag"
      expr: fixed_amount_flag
      comment: "Flag indicating a fixed amount schedule"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Schedule start month"
    - name: "end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Schedule end month"
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Sum of scheduled billing amounts"
    - name: "average_billing_amount"
      expr: AVG(CAST(billing_amount AS DOUBLE))
      comment: "Average billing amount per schedule"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discounts applied in schedules"
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of billing schedule records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition performance metrics"
  source: "`chemical_mfg_ecm`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method used for revenue recognition"
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition (e.g., point‑in‑time, over‑time)"
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating the amount is estimated"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating a reversal event"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the recognition event"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue (e.g., product, service)"
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Sum of revenue recognized in the period"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Sum of revenue deferred"
    - name: "average_recognized_revenue"
      expr: AVG(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Average recognized revenue per event"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition events"
$$;