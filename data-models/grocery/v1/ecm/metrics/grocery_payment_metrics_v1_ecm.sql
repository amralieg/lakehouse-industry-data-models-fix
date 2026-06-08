-- Metric views for domain: payment | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction metrics capturing revenue, taxes, discounts, tips, and chargeback activity."
  source: "`grocery_ecm`.`payment`.`payment_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction (day bucket)."
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction occurred (e.g., online, in-store)."
    - name: "tender_type"
      expr: tender_type
      comment: "Tender type used for the transaction."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Identifier of the store location."
    - name: "shopper_id"
      expr: shopper_id
      comment: "Identifier of the shopper."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the transaction."
  measures:
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transaction amount (gross revenue)."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of transactions."
    - name: "average_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount given."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amount."
    - name: "total_cashback_amount"
      expr: SUM(CAST(cashback_amount AS DOUBLE))
      comment: "Total cashback awarded."
    - name: "chargeback_count"
      expr: SUM(CASE WHEN chargeback_flag THEN 1 ELSE 0 END)
      comment: "Number of transactions flagged as chargebacks."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_settlement_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement batch level financial aggregates for reconciliation and performance monitoring."
  source: "`grocery_ecm`.`payment`.`settlement_batch`"
  dimensions:
    - name: "batch_date"
      expr: batch_date
      comment: "Date of the settlement batch."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the batch."
    - name: "gateway_id"
      expr: gateway_id
      comment: "Payment gateway used for the batch."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch."
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency of the settlement."
  measures:
    - name: "total_batch_amount"
      expr: SUM(CAST(total_batch_amount AS DOUBLE))
      comment: "Total monetary amount of the batch."
    - name: "net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Net amount settled after fees."
    - name: "total_assessment_fee_amount"
      expr: SUM(CAST(total_assessment_fee_amount AS DOUBLE))
      comment: "Total assessment fees for the batch."
    - name: "total_interchange_fee_amount"
      expr: SUM(CAST(total_interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees."
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total refunds processed in the batch."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(total_chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount in the batch."
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of settlement batches (should be 1 per row)."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback performance and financial impact metrics."
  source: "`grocery_ecm`.`payment`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location related to the chargeback."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the chargeback."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the chargeback was created."
  measures:
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total disputed amount."
    - name: "total_fee"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees associated with chargebacks."
    - name: "total_net_financial_impact"
      expr: SUM(CAST(net_financial_impact AS DOUBLE))
      comment: "Net financial impact of chargebacks."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from chargebacks."
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Number of chargeback records."
    - name: "fraud_indicator_count"
      expr: SUM(CASE WHEN fraud_indicator_flag THEN 1 ELSE 0 END)
      comment: "Count of chargebacks flagged as fraud."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud case detection and loss metrics for risk management."
  source: "`grocery_ecm`.`payment`.`fraud_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the fraud alert."
    - name: "channel"
      expr: channel
      comment: "Channel where fraud was detected."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the case."
    - name: "fraud_type"
      expr: fraud_type
      comment: "Type/category of fraud."
    - name: "detection_source"
      expr: detection_source
      comment: "Source system that detected the fraud."
  measures:
    - name: "total_confirmed_fraud_amount"
      expr: SUM(CAST(confirmed_fraud_amount AS DOUBLE))
      comment: "Total amount confirmed as fraud."
    - name: "total_loss_amount"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Total loss amount from fraud cases."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total recovered amount from fraud cases."
    - name: "fraud_case_count"
      expr: COUNT(1)
      comment: "Number of fraud cases."
    - name: "high_severity_count"
      expr: SUM(CASE WHEN alert_severity = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high severity fraud alerts."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card balance and activation metrics."
  source: "`grocery_ecm`.`payment`.`gift_card`"
  dimensions:
    - name: "gift_card_type"
      expr: gift_card_type
      comment: "Type of the gift card."
    - name: "activation_status"
      expr: activation_status
      comment: "Activation status of the gift card."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where the gift card is issued."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift card."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if the gift card is currently active."
    - name: "is_expired"
      expr: is_expired
      comment: "Flag indicating if the gift card has expired."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across gift cards."
    - name: "total_initial_load_amount"
      expr: SUM(CAST(initial_load_amount AS DOUBLE))
      comment: "Total amount initially loaded onto gift cards."
    - name: "gift_card_count"
      expr: COUNT(1)
      comment: "Number of gift cards."
    - name: "active_gift_card_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of active gift cards."
    - name: "expired_gift_card_count"
      expr: SUM(CASE WHEN is_expired THEN 1 ELSE 0 END)
      comment: "Count of expired gift cards."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_method`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment method usage and performance metrics."
  source: "`grocery_ecm`.`payment`.`method`"
  dimensions:
    - name: "card_brand"
      expr: card_brand
      comment: "Brand of the card used."
    - name: "card_type"
      expr: card_type
      comment: "Type of the card (e.g., credit, debit)."
    - name: "channel"
      expr: channel
      comment: "Channel where the payment method was used."
    - name: "is_default"
      expr: is_default
      comment: "Indicates if this method is the shopper's default."
    - name: "is_expired"
      expr: is_expired
      comment: "Indicates if the payment method is expired."
    - name: "issuing_bank"
      expr: issuing_bank
      comment: "Issuing bank of the card."
  measures:
    - name: "method_count"
      expr: COUNT(1)
      comment: "Number of payment methods."
    - name: "average_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across payment methods."
    - name: "total_gift_card_balance"
      expr: SUM(CAST(gift_card_balance AS DOUBLE))
      comment: "Total balance of gift cards linked to payment methods."
$$;