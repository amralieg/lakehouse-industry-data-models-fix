-- Metric views for domain: revenue | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics"
  source: "`oil_gas_ecm`.`revenue`.`invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., posted, pending)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of all invoice total amounts"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding balances across invoices"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice total amount"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoice records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed revenue line‑item metrics"
  source: "`oil_gas_ecm`.`revenue`.`invoice_line`"
  dimensions:
    - name: "refined_product_id"
      expr: refined_product_id
      comment: "Identifier for the refined product"
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Basis used for pricing the line item"
    - name: "production_month"
      expr: production_month
      comment: "Month of production associated with the line"
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amount for all invoice lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity sold across invoice lines"
    - name: "average_price_per_unit"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines"
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Number of invoice line records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection performance metrics"
  source: "`oil_gas_ecm`.`revenue`.`payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., wire, check)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was posted"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received via payments"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_deferred_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deferred revenue tracking metrics"
  source: "`oil_gas_ecm`.`revenue`.`deferred_revenue`"
  dimensions:
    - name: "deferral_status"
      expr: deferral_status
      comment: "Current status of the deferral (e.g., active, reversed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the deferral"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognize deferred revenue"
  measures:
    - name: "total_original_deferred_amount"
      expr: SUM(CAST(original_deferred_amount AS DOUBLE))
      comment: "Total amount originally deferred"
    - name: "total_recognized_to_date"
      expr: SUM(CAST(recognized_to_date_amount AS DOUBLE))
      comment: "Cumulative amount recognized to date"
    - name: "total_remaining_deferred_balance"
      expr: SUM(CAST(remaining_deferred_balance AS DOUBLE))
      comment: "Remaining balance yet to be recognized"
    - name: "deferred_revenue_record_count"
      expr: COUNT(1)
      comment: "Number of deferred revenue records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue allocation and cost recovery metrics"
  source: "`oil_gas_ecm`.`revenue`.`revenue_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for allocating revenue (e.g., proportional, fixed)"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier associated with allocation"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Petroleum product identifier"
    - name: "allocation_period_start"
      expr: period_start_date
      comment: "Start date of the allocation period"
  measures:
    - name: "total_allocated_revenue_amount"
      expr: SUM(CAST(allocated_revenue_amount AS DOUBLE))
      comment: "Total revenue allocated across entities"
    - name: "total_gross_revenue_amount"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue before allocations"
    - name: "total_cost_recovery_amount"
      expr: SUM(CAST(cost_recovery_amount AS DOUBLE))
      comment: "Total cost recovery amount captured"
    - name: "revenue_allocation_record_count"
      expr: COUNT(1)
      comment: "Number of revenue allocation records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual accounting metrics"
  source: "`oil_gas_ecm`.`revenue`.`accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g., revenue, expense)"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the accrual was posted"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the accrual amounts"
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of all accrual amounts"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance amounts across accruals"
    - name: "accrual_record_count"
      expr: COUNT(1)
      comment: "Number of accrual records"
$$;