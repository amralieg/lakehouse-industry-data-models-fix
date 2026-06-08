-- Metric views for domain: payment | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction KPIs for revenue, fee, and volume analysis"
  source: "`ecommerce_ecm`.`payment`.`payment_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction (day level)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel used for the payment (e.g., online, mobile)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., credit_card, wallet)"
    - name: "merchant_category_code"
      expr: merchant_category_code
      comment: "Merchant category code for the transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating if the transaction is part of a recurring series"
    - name: "fraud_score"
      expr: fraud_score
      comment: "Fraud risk score assigned to the transaction"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross transaction amount across all payment transactions"
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net transaction amount after fees and adjustments"
    - name: "total_fee_amount"
      expr: SUM(CAST(amount_fee AS DOUBLE))
      comment: "Total fee amount collected from transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of payment transaction records"
    - name: "avg_gross_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross amount per transaction"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization layer KPIs to monitor approval rates and authorized volume"
  source: "`ecommerce_ecm`.`payment`.`authorization`"
  dimensions:
    - name: "auth_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of the authorization event (day level)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was attempted"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment attempt"
    - name: "authorization_status"
      expr: authorization_status
      comment: "Result status of the authorization (e.g., approved, declined)"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates if the authorization was flagged for fraud"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the authorized amount"
  measures:
    - name: "total_authorized_amount"
      expr: SUM(CAST(auth_amount AS DOUBLE))
      comment: "Total amount authorized across all authorizations"
    - name: "auth_count"
      expr: COUNT(1)
      comment: "Number of authorization attempts"
    - name: "avg_authorized_amount"
      expr: AVG(CAST(auth_amount AS DOUBLE))
      comment: "Average authorized amount per attempt"
    - name: "successful_auth_count"
      expr: COUNT(CASE WHEN authorization_status = 'approved' THEN 1 END)
      comment: "Count of authorizations with approved status"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement KPIs to track cash flow and settlement efficiency"
  source: "`ecommerce_ecm`.`payment`.`settlement`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of the settlement"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (e.g., completed, pending)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the settlement"
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total settled amount across all settlements"
    - name: "net_settlement_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net amount after settlement fees"
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Number of settlement records"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount per settlement"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback KPIs to monitor loss exposure and dispute volume"
  source: "`ecommerce_ecm`.`payment`.`chargeback`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date when the chargeback was settled"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of the dispute (e.g., fraud, service)"
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback case"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount"
  measures:
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount_original AS DOUBLE))
      comment: "Total original amount disputed in chargebacks"
    - name: "total_chargeback_fee"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees associated with chargebacks"
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Number of chargeback cases"
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(amount_original AS DOUBLE))
      comment: "Average original amount per chargeback"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud case KPIs to assess risk exposure and detection effectiveness"
  source: "`ecommerce_ecm`.`payment`.`fraud_case`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction linked to the fraud case"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case"
    - name: "detection_source"
      expr: detection_source
      comment: "Source system or method that detected the fraud"
    - name: "fraud_type"
      expr: fraud_type
      comment: "Type/category of fraud"
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Flag indicating high‑risk fraud cases"
  measures:
    - name: "fraud_case_count"
      expr: COUNT(1)
      comment: "Number of fraud cases recorded"
    - name: "total_fraud_amount"
      expr: SUM(CAST(fraud_amount AS DOUBLE))
      comment: "Total monetary impact of fraud cases"
    - name: "avg_fraud_amount"
      expr: AVG(CAST(fraud_amount AS DOUBLE))
      comment: "Average fraud amount per case"
    - name: "high_risk_case_count"
      expr: COUNT(CASE WHEN is_high_risk THEN 1 END)
      comment: "Count of fraud cases flagged as high risk"
$$;