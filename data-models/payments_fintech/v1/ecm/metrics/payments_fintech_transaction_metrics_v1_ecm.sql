-- Metric views for domain: transaction | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction_payment_txn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial KPIs derived from the payment transaction fact table"
  source: "`payments_fintech_ecm`.`transaction`.`payment_txn`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Transaction date (day level) for time‑series analysis"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Identifier of the merchant receiving the payment"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel through which the payment was initiated"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Business transaction type (e.g., purchase, refund)"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of payment transaction records"
    - name: "fraud_transaction_count"
      expr: SUM(CASE WHEN fraud_flag THEN 1 ELSE 0 END)
      comment: "Count of payment transactions flagged as fraud"
    - name: "cross_border_transaction_count"
      expr: SUM(CASE WHEN is_cross_border THEN 1 ELSE 0 END)
      comment: "Count of cross‑border payment transactions"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level transaction KPIs for revenue and risk monitoring"
  source: "`payments_fintech_ecm`.`transaction`.`transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction (day granularity)"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel category (e.g., online, POS)"
    - name: "currency_id"
      expr: currency_id
      comment: "Foreign key to currency dimension"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount for all transactions"
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount after fees and adjustments"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of transaction records"
    - name: "declined_transaction_count"
      expr: SUM(CASE WHEN decline_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of transactions that were declined"
    - name: "fraud_transaction_count"
      expr: SUM(CASE WHEN fraud_flag THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged as fraud"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization performance and risk metrics"
  source: "`payments_fintech_ecm`.`transaction`.`authorization`"
  dimensions:
    - name: "authorization_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date of the authorization request"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant involved in the authorization"
    - name: "card_type"
      expr: card_type
      comment: "Card scheme/type used"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., credit, debit)"
    - name: "auth_status"
      expr: auth_status
      comment: "Result status of the authorization"
  measures:
    - name: "total_authorized_amount"
      expr: SUM(CAST(amount_authorized AS DOUBLE))
      comment: "Sum of amounts that were authorized"
    - name: "total_requested_amount"
      expr: SUM(CAST(amount_requested AS DOUBLE))
      comment: "Sum of amounts requested for authorization"
    - name: "authorization_count"
      expr: COUNT(1)
      comment: "Number of authorization attempts"
    - name: "declined_authorization_count"
      expr: SUM(CASE WHEN auth_status = 'DECLINED' THEN 1 ELSE 0 END)
      comment: "Count of authorizations that were declined"
    - name: "fraud_authorization_count"
      expr: SUM(CASE WHEN fraud_flag = 'TRUE' THEN 1 ELSE 0 END)
      comment: "Count of authorizations flagged for fraud"
$$;