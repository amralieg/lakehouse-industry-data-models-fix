-- Metric views for domain: revenue | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial KPIs"
  source: "`oil_gas_ecm`.`revenue`.`invoice`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of all invoice total amounts, representing gross revenue billed"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax collected on invoices"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount, useful for pricing analysis"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoice records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual financial impact KPIs"
  source: "`oil_gas_ecm`.`revenue`.`accrual`"
  dimensions:
    - name: "accrual_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of accrual posting"
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type/category of accrual"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the accrual"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the accrual"
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrued revenue amount"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance adjustments across accruals"
    - name: "average_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount per record"
    - name: "accrual_record_count"
      expr: COUNT(1)
      comment: "Number of accrual records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_cash_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash application efficiency KPIs"
  source: "`oil_gas_ecm`.`revenue`.`cash_application`"
  dimensions:
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of cash application"
    - name: "application_method"
      expr: application_method
      comment: "Method used for cash application"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cash application"
    - name: "account_id"
      expr: account_id
      comment: "Customer account receiving cash"
  measures:
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total cash applied to invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discounts taken during cash application"
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Sum of overpayments identified"
    - name: "cash_application_count"
      expr: COUNT(1)
      comment: "Number of cash application records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue forecasting KPIs"
  source: "`oil_gas_ecm`.`revenue`.`revenue_forecast`"
  dimensions:
    - name: "forecast_month"
      expr: DATE_TRUNC('month', forecast_date)
      comment: "Month of the forecast"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product being forecasted"
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario (e.g., base, optimistic)"
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue_amount AS DOUBLE))
      comment: "Sum of forecasted revenue amounts"
    - name: "total_forecasted_volume"
      expr: SUM(CAST(forecasted_volume AS DOUBLE))
      comment: "Sum of forecasted product volume"
    - name: "average_forecast_price"
      expr: AVG(CAST(forecasted_price AS DOUBLE))
      comment: "Average forecast price per unit"
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue allocation and net interest KPIs"
  source: "`oil_gas_ecm`.`revenue`.`revenue_allocation`"
  dimensions:
    - name: "allocation_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of allocation period start"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product associated with allocation"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center receiving allocation"
  measures:
    - name: "total_allocated_revenue"
      expr: SUM(CAST(allocated_revenue_amount AS DOUBLE))
      comment: "Total revenue allocated to partners/centers"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Sum of gross revenue before allocations"
    - name: "total_cost_recovery"
      expr: SUM(CAST(cost_recovery_amount AS DOUBLE))
      comment: "Sum of cost recovery amounts"
    - name: "average_nri_percentage"
      expr: AVG(CAST(nri_percentage AS DOUBLE))
      comment: "Average Net Revenue Interest percentage across allocations"
    - name: "allocation_record_count"
      expr: COUNT(1)
      comment: "Number of allocation records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement financial KPIs"
  source: "`oil_gas_ecm`.`revenue`.`settlement`"
  dimensions:
    - name: "settlement_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of settlement"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product involved in settlement"
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net amount settled"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Sum of invoiced amounts linked to settlements"
    - name: "average_invoiced_price"
      expr: AVG(CAST(invoiced_price AS DOUBLE))
      comment: "Average price per unit invoiced in settlements"
    - name: "settlement_record_count"
      expr: COUNT(1)
      comment: "Number of settlement records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`revenue_take_or_pay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Take-or-pay contract performance KPIs"
  source: "`oil_gas_ecm`.`revenue`.`take_or_pay`"
  dimensions:
    - name: "contract_month"
      expr: DATE_TRUNC('month', obligation_period_start_date)
      comment: "Month when the contract obligation period starts"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the contract obligation"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product covered by the contract"
    - name: "contract_reference_number"
      expr: contract_reference_number
      comment: "External reference number for the contract"
  measures:
    - name: "total_actual_taken_volume"
      expr: SUM(CAST(actual_taken_volume AS DOUBLE))
      comment: "Total volume actually taken under take-or-pay contracts"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Sum of deferred revenue amounts associated with contracts"
    - name: "take_or_pay_record_count"
      expr: COUNT(1)
      comment: "Number of take-or-pay contract records"
$$;