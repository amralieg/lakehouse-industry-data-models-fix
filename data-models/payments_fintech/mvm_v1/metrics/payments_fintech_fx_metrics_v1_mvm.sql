-- Metric views for domain: fx | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_cross_border_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core transaction KPIs for cross‑border payments"
  source: "`payments_fintech_ecm`.`fx`.`cross_border_payment`"
  dimensions:
    - name: "payment_rail"
      expr: payment_rail
      comment: "Payment rail used (e.g., SWIFT, ACH)"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Identifier of the payment product"
    - name: "payment_status"
      expr: cross_border_payment_status
      comment: "Current status of the payment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO code of the destination country"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., purchase, refund)"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the payment event"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of cross-border payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of payment amounts in transaction currency"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees charged for cross-border payments"
    - name: "average_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied across payments"
    - name: "distinct_beneficiary_count"
      expr: COUNT(DISTINCT beneficiary_id)
      comment: "Number of unique beneficiaries"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule financial impact metrics"
  source: "`payments_fintech_ecm`.`fx`.`fx_fee_schedule`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Category of the fee (e.g., transaction, service)"
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency in which the fee is expressed"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment targeted by the fee schedule"
    - name: "fee_version"
      expr: fee_version
      comment: "Version identifier of the fee schedule"
    - name: "schedule_name"
      expr: schedule_name
      comment: "Human‑readable name of the fee schedule"
    - name: "fee_schedule_status"
      expr: fx_fee_schedule_status
      comment: "Current status of the fee schedule"
  measures:
    - name: "fee_schedule_count"
      expr: COUNT(1)
      comment: "Number of fee schedule records"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount defined in the schedule"
    - name: "average_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee amount across the schedule"
    - name: "max_fee_amount"
      expr: MAX(fee_amount)
      comment: "Maximum fee amount in the schedule"
    - name: "min_fee_amount"
      expr: MIN(fee_amount)
      comment: "Minimum fee amount in the schedule"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk exposure overview for FX positions"
  source: "`payments_fintech_ecm`.`fx`.`exposure`"
  dimensions:
    - name: "exposure_status"
      expr: exposure_status
      comment: "Current status of the exposure (e.g., active, closed)"
    - name: "direction"
      expr: direction
      comment: "Direction of exposure (incoming or outgoing)"
    - name: "exposure_source"
      expr: exposure_source
      comment: "Source system or process that generated the exposure"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the exposure"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the exposure snapshot"
  measures:
    - name: "exposure_count"
      expr: COUNT(1)
      comment: "Number of exposure records"
    - name: "total_gross_notional_exposure"
      expr: SUM(CAST(gross_notional_exposure AS DOUBLE))
      comment: "Sum of gross notional exposure across all records"
    - name: "total_net_exposure"
      expr: SUM(CAST(net_exposure AS DOUBLE))
      comment: "Sum of net exposure values"
    - name: "average_limit_utilization"
      expr: AVG(CAST(limit_utilization_amount AS DOUBLE))
      comment: "Average limit utilization amount"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_nostro_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity and utilization metrics for Nostro accounts"
  source: "`payments_fintech_ecm`.`fx`.`nostro_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of Nostro account (e.g., settlement, liquidity)"
    - name: "account_status"
      expr: nostro_account_status
      comment: "Operational status of the account"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the account"
    - name: "is_pre_funded"
      expr: is_pre_funded
      comment: "Indicates if the account is pre‑funded"
    - name: "opened_date"
      expr: DATE_TRUNC('day', opened_date)
      comment: "Date the Nostro account was opened"
  measures:
    - name: "nostro_account_count"
      expr: COUNT(1)
      comment: "Number of Nostro accounts"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Aggregate available balance across all Nostro accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Aggregate current balance across all Nostro accounts"
    - name: "average_daily_usage_pct"
      expr: AVG(CAST(daily_usage_percentage AS DOUBLE))
      comment: "Average daily usage percentage of account limits"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fx_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FX rate market pricing metrics"
  source: "`payments_fintech_ecm`.`fx`.`rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Classification of the rate (e.g., spot, forward)"
    - name: "base_currency"
      expr: base_currency
      comment: "Base currency of the rate pair"
    - name: "quote_currency"
      expr: quote_currency
      comment: "Quote currency of the rate pair"
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region for the rate"
    - name: "is_active"
      expr: is_active
      comment: "Indicates if the rate is currently active"
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_timestamp)
      comment: "Date the rate became effective"
  measures:
    - name: "rate_record_count"
      expr: COUNT(1)
      comment: "Number of rate records"
    - name: "average_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price across rates"
    - name: "average_ask_price"
      expr: AVG(CAST(ask_price AS DOUBLE))
      comment: "Average ask price across rates"
    - name: "average_mid_price"
      expr: AVG(CAST(mid_price AS DOUBLE))
      comment: "Average mid price across rates"
$$;