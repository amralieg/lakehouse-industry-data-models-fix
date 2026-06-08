-- Metric views for domain: payment | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction KPIs for revenue, cost and cross‑border activity monitoring"
  source: "`banking_ecm`.`payment`.`payment_transaction`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('month', execution_timestamp)
      comment: "Month of transaction execution"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, Wire, Card)"
    - name: "payment_type"
      expr: payment_type
      comment: "Business type of the payment (e.g., Retail, B2B)"
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency in which the transaction was settled"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of all payment transactions"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of all fees charged on payment transactions"
    - name: "average_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount per payment transaction"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Count of payment transaction records"
    - name: "cross_border_transaction_count"
      expr: SUM(CASE WHEN cross_border_flag THEN 1 ELSE 0 END)
      comment: "Number of cross‑border payment transactions"
    - name: "average_fee_percentage"
      expr: AVG(100.0 * fee_amount / NULLIF(amount, 0))
      comment: "Average fee as a percentage of transaction amount"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_card_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Card transaction performance and fraud monitoring"
  source: "`banking_ecm`.`payment`.`card_transaction`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the card transaction"
    - name: "card_type"
      expr: card_type
      comment: "Type of card used (e.g., Debit, Credit)"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel through which the card transaction occurred"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the card transaction"
  measures:
    - name: "total_card_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total amount of card transactions"
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Sum of billed amounts for card transactions"
    - name: "average_card_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average amount per card transaction"
    - name: "card_transaction_count"
      expr: COUNT(1)
      comment: "Number of card transaction records"
    - name: "fraud_transaction_count"
      expr: SUM(CASE WHEN fraud_flag THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged as fraud"
    - name: "fraud_rate_percent"
      expr: AVG(CASE WHEN fraud_flag THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of transactions flagged as fraud"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_instruction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for payment instruction processing efficiency and success"
  source: "`banking_ecm`.`payment`.`instruction`"
  dimensions:
    - name: "instruction_month"
      expr: DATE_TRUNC('month', instruction_timestamp)
      comment: "Month of the payment instruction"
    - name: "payment_rail_type"
      expr: payment_rail_type
      comment: "Rail used for the payment (e.g., ACH, SWIFT)"
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority level of the instruction"
    - name: "instruction_status"
      expr: instruction_status
      comment: "Current status of the instruction"
  measures:
    - name: "total_instruction_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount instructed for payment"
    - name: "total_instruction_fee"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees associated with payment instructions"
    - name: "average_instruction_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average amount per payment instruction"
    - name: "instruction_count"
      expr: COUNT(1)
      comment: "Number of payment instruction records"
    - name: "rejected_instruction_count"
      expr: SUM(CASE WHEN instruction_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Count of instructions that were rejected"
    - name: "instruction_success_rate_percent"
      expr: AVG(CASE WHEN instruction_status = 'Completed' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of instructions completed successfully"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`payment_merchant_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic merchant risk and volume metrics for risk management and revenue planning"
  source: "`banking_ecm`.`payment`.`merchant`"
  dimensions:
    - name: "merchant_type"
      expr: merchant_type
      comment: "Classification of merchant (e.g., Retail, Services)"
    - name: "merchant_status"
      expr: merchant_status
      comment: "Operational status of the merchant"
    - name: "supports_cross_border"
      expr: supports_cross_border_payments
      comment: "Indicates if merchant supports cross‑border payments"
    - name: "onboarding_month"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month the merchant was onboarded"
  measures:
    - name: "total_annual_transaction_volume"
      expr: SUM(CAST(annual_transaction_volume AS DOUBLE))
      comment: "Aggregate annual transaction volume across merchants"
    - name: "average_transaction_amount"
      expr: AVG(CAST(average_transaction_amount AS DOUBLE))
      comment: "Average transaction amount per merchant"
    - name: "high_risk_merchant_count"
      expr: SUM(CASE WHEN is_high_risk THEN 1 ELSE 0 END)
      comment: "Number of merchants flagged as high risk"
    - name: "merchant_count"
      expr: COUNT(1)
      comment: "Total number of merchant records"
$$;