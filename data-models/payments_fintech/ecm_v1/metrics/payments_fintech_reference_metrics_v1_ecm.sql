-- Metric views for domain: reference | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`reference_bin_range`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for BIN range configurations"
  source: "`payments_fintech_ecm`.`reference`.`bin_range`"
  dimensions:
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand (e.g., Visa, Mastercard)"
  measures:
    - name: "total_bins"
      expr: COUNT(1)
      comment: "Total number of BIN range records"
    - name: "avg_max_transaction_amount"
      expr: AVG(CAST(max_transaction_amount AS DOUBLE))
      comment: "Average maximum transaction amount across BIN ranges"
    - name: "avg_min_transaction_amount"
      expr: AVG(CAST(min_transaction_amount AS DOUBLE))
      comment: "Average minimum transaction amount across BIN ranges"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`reference_fx_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FX rate market overview metrics"
  source: "`payments_fintech_ecm`.`reference`.`fx_rate`"
  dimensions:
    - name: "market"
      expr: market
      comment: "Market identifier for the FX rate"
  measures:
    - name: "count_rates"
      expr: COUNT(1)
      comment: "Number of FX rate records"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate across all FX rates"
    - name: "max_exchange_rate"
      expr: MAX(CAST(exchange_rate AS DOUBLE))
      comment: "Maximum exchange rate observed"
    - name: "min_exchange_rate"
      expr: MIN(CAST(exchange_rate AS DOUBLE))
      comment: "Minimum exchange rate observed"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`reference_mcc`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics summarizing Merchant Category Codes"
  source: "`payments_fintech_ecm`.`reference`.`mcc`"
  dimensions:
    - name: "mcc_code"
      expr: mcc_code
      comment: "MCC numeric code"
  measures:
    - name: "count_mcc"
      expr: COUNT(1)
      comment: "Total number of MCC records"
    - name: "avg_average_transaction_amount"
      expr: AVG(CAST(average_transaction_amount AS DOUBLE))
      comment: "Average transaction amount per MCC"
    - name: "avg_average_transaction_volume"
      expr: AVG(CAST(average_transaction_volume AS DOUBLE))
      comment: "Average transaction volume per MCC"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`reference_transaction_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core transaction type financial limits and fees"
  source: "`payments_fintech_ecm`.`reference`.`transaction_type`"
  dimensions:
    - name: "transaction_type_name"
      expr: transaction_type_name
      comment: "Descriptive name of the transaction type"
  measures:
    - name: "count_transaction_types"
      expr: COUNT(1)
      comment: "Total number of transaction type records"
    - name: "avg_max_amount_limit"
      expr: AVG(CAST(max_amount_limit AS DOUBLE))
      comment: "Average maximum amount limit across transaction types"
    - name: "avg_min_amount_limit"
      expr: AVG(CAST(min_amount_limit AS DOUBLE))
      comment: "Average minimum amount limit across transaction types"
    - name: "avg_transaction_fee_amount"
      expr: AVG(CAST(transaction_fee_amount AS DOUBLE))
      comment: "Average flat transaction fee amount"
    - name: "avg_transaction_fee_percentage"
      expr: AVG(CAST(transaction_fee_percentage AS DOUBLE))
      comment: "Average transaction fee percentage"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`reference_wallet_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and risk metrics for digital wallet schemes"
  source: "`payments_fintech_ecm`.`reference`.`wallet_scheme`"
  dimensions:
    - name: "scheme_name"
      expr: scheme_name
      comment: "Name of the wallet scheme"
  measures:
    - name: "count_wallet_schemes"
      expr: COUNT(1)
      comment: "Total number of wallet scheme records"
    - name: "avg_interchange_fee_rate"
      expr: AVG(CAST(interchange_fee_rate AS DOUBLE))
      comment: "Average interchange fee rate for wallet schemes"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across wallet schemes"
    - name: "avg_max_transaction_amount"
      expr: AVG(CAST(max_transaction_amount AS DOUBLE))
      comment: "Average maximum transaction amount supported by wallet schemes"
$$;