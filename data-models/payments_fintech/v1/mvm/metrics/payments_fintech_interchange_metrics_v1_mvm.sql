-- Metric views for domain: interchange | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core interchange billing KPIs – revenue, settlement and transaction volume"
  source: "`payments_fintech_ecm`.`interchange`.`billing`"
  dimensions:
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme identifier for the interchange"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product associated with the billing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing amounts"
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing record"
    - name: "billing_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the billing period"
  measures:
    - name: "billing_record_count"
      expr: COUNT(1)
      comment: "Number of billing records processed"
    - name: "total_gross_interchange_amount"
      expr: SUM(CAST(gross_interchange_amount AS DOUBLE))
      comment: "Total gross interchange amount across all billing records"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount across all billing records"
    - name: "total_transaction_count"
      expr: SUM(CAST(total_transaction_count AS DOUBLE))
      comment: "Sum of transaction counts reported in billing records"
    - name: "average_gross_interchange_amount"
      expr: AVG(CAST(gross_interchange_amount AS DOUBLE))
      comment: "Average gross interchange amount per billing record"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_cost_of_acceptance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of acceptance and revenue efficiency metrics"
  source: "`payments_fintech_ecm`.`interchange`.`cost_of_acceptance`"
  dimensions:
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product linked to the cost record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost and revenue amounts"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month of the cost calculation"
    - name: "cost_of_acceptance_status"
      expr: cost_of_acceptance_status
      comment: "Status of the cost of acceptance record"
    - name: "mdr_config_id"
      expr: mdr_config_id
      comment: "MDR configuration identifier"
  measures:
    - name: "cost_of_acceptance_record_count"
      expr: COUNT(1)
      comment: "Number of cost of acceptance records"
    - name: "total_interchange_cost"
      expr: SUM(CAST(total_interchange_cost AS DOUBLE))
      comment: "Total interchange cost incurred"
    - name: "total_msf_revenue"
      expr: SUM(CAST(total_msf_revenue AS DOUBLE))
      comment: "Total revenue from merchant service fees"
    - name: "total_scheme_fees"
      expr: SUM(CAST(total_scheme_fees AS DOUBLE))
      comment: "Total scheme fees collected"
    - name: "average_ticket_size"
      expr: AVG(CAST(average_ticket_size AS DOUBLE))
      comment: "Average ticket size across records"
    - name: "cost_per_transaction"
      expr: AVG(total_interchange_cost / NULLIF(transaction_count, 0))
      comment: "Average interchange cost per transaction"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualification event KPIs – revenue and rate effectiveness"
  source: "`payments_fintech_ecm`.`interchange`.`qualification`"
  dimensions:
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme identifier for the qualification"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product involved"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "card_present_flag"
      expr: card_present_flag
      comment: "Indicates if card was present"
    - name: "cross_border_flag"
      expr: cross_border_flag
      comment: "Indicates cross‑border transaction"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification"
    - name: "settlement_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of settlement for the qualification"
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "qualification_record_count"
      expr: COUNT(1)
      comment: "Number of qualification events"
    - name: "total_interchange_amount"
      expr: SUM(CAST(interchange_amount AS DOUBLE))
      comment: "Total interchange amount for qualified transactions"
    - name: "total_irf_fixed_amount"
      expr: SUM(CAST(irf_fixed_amount AS DOUBLE))
      comment: "Total IRF fixed amount applied"
    - name: "average_irf_rate_percentage"
      expr: AVG(CAST(irf_rate_percentage AS DOUBLE))
      comment: "Average IRF rate percentage across qualifications"
    - name: "distinct_transaction_count"
      expr: COUNT(DISTINCT transaction_id)
      comment: "Count of distinct transactions qualified"
    - name: "average_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount for qualified events"
$$;