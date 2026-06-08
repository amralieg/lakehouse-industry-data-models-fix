-- Metric views for domain: transaction | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization level KPIs for payment transactions."
  source: "`payments_fintech_ecm`.`transaction`.`authorization`"
  dimensions:
    - name: "auth_status"
      expr: auth_status
      comment: "Authorization outcome status."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., card, wallet)."
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date of authorization request."
    - name: "card_type"
      expr: card_type
      comment: "Card type (e.g., Visa, MasterCard)."
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of authorization attempts."
    - name: "total_authorized_amount"
      expr: SUM(CAST(amount_authorized AS DOUBLE))
      comment: "Sum of authorized amounts."
    - name: "successful_authorizations"
      expr: COUNT(CASE WHEN auth_status = 'SUCCESS' THEN 1 END)
      comment: "Count of successful authorizations."
    - name: "avg_authorized_amount"
      expr: AVG(CAST(amount_authorized AS DOUBLE))
      comment: "Average authorized amount per authorization."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction_payment_txn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction level financial KPIs."
  source: "`payments_fintech_ecm`.`transaction`.`payment_txn`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction."
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Flag indicating cross-border transaction."
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme identifier."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total gross transaction amount."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees collected."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after fees."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount."
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_amount AS DOUBLE) / NULLIF(CAST(transaction_amount AS DOUBLE), 0) * 100)
      comment: "Average fee as percentage of transaction amount."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction_capture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capture event financial KPIs."
  source: "`payments_fintech_ecm`.`transaction`.`capture`"
  dimensions:
    - name: "capture_status"
      expr: capture_status
      comment: "Status of the capture (e.g., completed, pending)."
    - name: "merchant_id"
      expr: merchant_id
      comment: "Identifier of the merchant."
    - name: "capture_date"
      expr: DATE_TRUNC('day', capture_timestamp)
      comment: "Date of capture."
    - name: "is_incremental"
      expr: is_incremental
      comment: "Flag for incremental capture."
  measures:
    - name: "total_captures"
      expr: COUNT(1)
      comment: "Total number of capture records."
    - name: "total_captured_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of captured amounts."
    - name: "total_interchange_fee"
      expr: SUM(CAST(interchange_fee AS DOUBLE))
      comment: "Total interchange fees."
    - name: "total_processing_fee"
      expr: SUM(CAST(processing_fee AS DOUBLE))
      comment: "Total processing fees."
    - name: "avg_capture_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average captured amount."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`transaction_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reconciliation performance and variance metrics."
  source: "`payments_fintech_ecm`.`transaction`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of reconciliation."
    - name: "settlement_date"
      expr: DATE_TRUNC('day', settlement_date)
      comment: "Settlement date."
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier."
    - name: "regulatory_report_indicator"
      expr: regulatory_report_indicator
      comment: "Regulatory reporting flag."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of reconciliation records."
    - name: "total_matched_amount"
      expr: SUM(CAST(total_matched_amount AS DOUBLE))
      comment: "Sum of matched transaction amounts."
    - name: "total_unmatched_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Sum of variance amounts (unmatched)."
    - name: "avg_variance_amount"
      expr: AVG(CAST(total_variance_amount AS DOUBLE))
      comment: "Average variance per reconciliation."
    - name: "reconciliation_success_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'SUCCESS' THEN 1 END)
      comment: "Count of successful reconciliations."
$$;