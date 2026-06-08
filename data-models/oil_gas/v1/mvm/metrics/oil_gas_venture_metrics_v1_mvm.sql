-- Metric views for domain: venture | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_cash_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash call activity and financial exposure"
  source: "`oil_gas_ecm`.`venture`.`cash_call`"
  dimensions:
    - name: "cash_call_status"
      expr: cash_call_status
      comment: "Current status of the cash call (e.g., Open, Closed)"
    - name: "cash_call_number"
      expr: cash_call_number
      comment: "Business identifier for the cash call"
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month of the cash call billing period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cash call amounts"
  measures:
    - name: "total_call_amount"
      expr: SUM(CAST(total_call_amount AS DOUBLE))
      comment: "Total amount of cash calls issued"
    - name: "total_amount_outstanding"
      expr: SUM(CAST(total_amount_outstanding AS DOUBLE))
      comment: "Aggregate outstanding cash call balances"
    - name: "total_amount_received"
      expr: SUM(CAST(total_amount_received AS DOUBLE))
      comment: "Aggregate cash call payments received"
    - name: "average_call_amount"
      expr: AVG(CAST(total_call_amount AS DOUBLE))
      comment: "Average cash call amount per record"
    - name: "cash_call_count"
      expr: COUNT(1)
      comment: "Number of cash call records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_cash_call_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payments against cash calls, including interest and currency conversion"
  source: "`oil_gas_ecm`.`venture`.`cash_call_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., Wire, ACH)"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of the payment transaction"
    - name: "currency_code"
      expr: payment_currency
      comment: "Currency of the payment"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner receiving the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid in cash call payments"
    - name: "total_payment_amount_base_currency"
      expr: SUM(CAST(payment_amount_base_currency AS DOUBLE))
      comment: "Total payment amount converted to base currency"
    - name: "total_default_interest_amount"
      expr: SUM(CAST(default_interest_amount AS DOUBLE))
      comment: "Aggregate default interest charged on late payments"
    - name: "average_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of cash call payment records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_cost_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost recovery performance and exposure"
  source: "`oil_gas_ecm`.`venture`.`cost_recovery`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High‑level cost category"
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost sub‑category"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts"
    - name: "period_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the cost recovery period"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner associated with the cost recovery"
  measures:
    - name: "total_costs_incurred"
      expr: SUM(CAST(costs_incurred_period AS DOUBLE))
      comment: "Total costs incurred in the reporting period"
    - name: "total_costs_recovered"
      expr: SUM(CAST(costs_recovered_period AS DOUBLE))
      comment: "Total costs recovered in the reporting period"
    - name: "total_unrecovered_balance"
      expr: SUM(CAST(unrecovered_cost_balance_closing AS DOUBLE))
      comment: "Closing unrecovered cost balance"
    - name: "total_ceiling_limit"
      expr: SUM(CAST(ceiling_limit AS DOUBLE))
      comment: "Aggregate ceiling limits for cost recovery"
    - name: "cost_recovery_record_count"
      expr: COUNT(1)
      comment: "Number of cost recovery records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_lifting_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Oil lifting entitlement vs. actual production"
  source: "`oil_gas_ecm`.`venture`.`lifting_entitlement`"
  dimensions:
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Identifier of the petroleum product"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner entitled to lift"
    - name: "entitlement_month"
      expr: DATE_TRUNC('month', entitlement_period_start_date)
      comment: "Month of the entitlement period"
    - name: "lease_id"
      expr: lease_id
      comment: "Lease associated with the entitlement"
  measures:
    - name: "total_entitlement_volume_bbl"
      expr: SUM(CAST(entitlement_volume_bbl AS DOUBLE))
      comment: "Total oil volume entitlement"
    - name: "total_actual_lifted_volume_bbl"
      expr: SUM(CAST(actual_lifted_volume_bbl AS DOUBLE))
      comment: "Total actual lifted oil volume"
    - name: "total_imbalance_volume_boe"
      expr: SUM(CAST(imbalance_volume_boe AS DOUBLE))
      comment: "Aggregate volume imbalance (BOE)"
    - name: "lifting_record_count"
      expr: COUNT(1)
      comment: "Number of lifting entitlement records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`venture_profit_oil_split`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit oil split performance and revenue attribution"
  source: "`oil_gas_ecm`.`venture`.`profit_oil_split`"
  dimensions:
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the split"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Petroleum product identifier"
    - name: "production_tier"
      expr: production_tier
      comment: "Production tier classification"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month of the calculation"
  measures:
    - name: "total_profit_oil_volume_bbl"
      expr: SUM(CAST(profit_oil_volume_bbl AS DOUBLE))
      comment: "Total profit oil volume produced"
    - name: "average_government_profit_oil_share_percent"
      expr: AVG(CAST(government_profit_oil_share_percent AS DOUBLE))
      comment: "Average government share of profit oil (%)"
    - name: "total_cumulative_revenue_usd"
      expr: SUM(CAST(cumulative_revenue_amount_usd AS DOUBLE))
      comment: "Cumulative revenue in USD associated with profit oil split"
    - name: "profit_oil_split_record_count"
      expr: COUNT(1)
      comment: "Number of profit oil split records"
$$;