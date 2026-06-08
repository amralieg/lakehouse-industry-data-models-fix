-- Metric views for domain: consumer | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_dtc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and volume metrics for direct-to-consumer orders"
  source: "`consumer_goods_ecm`.`consumer`.`dtc_order`"
  dimensions:
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order (UTC)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "channel_code"
      expr: channel_code
      comment: "Channel through which the order was placed"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of DTC orders"
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Sum of all order total amounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts applied to orders"
    - name: "average_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order total amount per order"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_cltv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic CLTV and revenue forecasting metrics"
  source: "`consumer_goods_ecm`.`consumer`.`cltv_record`"
  dimensions:
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month of CLTV calculation"
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier classification"
    - name: "primary_brand_code"
      expr: primary_brand_code
      comment: "Primary brand associated with the customer"
    - name: "primary_category_code"
      expr: primary_category_code
      comment: "Primary product category for the customer"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary sales channel for the customer"
  measures:
    - name: "customer_count"
      expr: COUNT(1)
      comment: "Number of customers with a CLTV record"
    - name: "average_cltv_score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average Customer Lifetime Value score"
    - name: "average_predicted_revenue_12m"
      expr: AVG(CAST(predicted_revenue_12m AS DOUBLE))
      comment: "Average predicted revenue for next 12 months"
    - name: "average_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency per customer"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program activity and value generation metrics"
  source: "`consumer_goods_ecm`.`consumer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the loyalty transaction"
    - name: "program_id"
      expr: program_id
      comment: "Loyalty program identifier"
    - name: "tier_id"
      expr: tier_id
      comment: "Loyalty tier at time of transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (Earn, Redeem, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the transaction occurred"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of loyalty transactions"
    - name: "total_points_earned"
      expr: SUM(CASE WHEN points_direction = 'Earn' THEN points_amount ELSE 0 END)
      comment: "Sum of loyalty points earned"
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN points_direction = 'Redeem' THEN points_amount ELSE 0 END)
      comment: "Sum of loyalty points redeemed"
    - name: "average_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per loyalty transaction"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and advocacy metrics from NPS surveys"
  source: "`consumer_goods_ecm`.`consumer`.`nps_response`"
  dimensions:
    - name: "survey_month"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Month when the NPS survey was taken"
    - name: "brand_name"
      expr: brand_name
      comment: "Brand associated with the NPS response"
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Marketing brand identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU referenced in the survey response"
  measures:
    - name: "response_count"
      expr: COUNT(1)
      comment: "Number of NPS survey responses"
    - name: "average_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score across responses"
    - name: "average_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score derived from free‑text comments"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_dtc_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return and refund performance metrics"
  source: "`consumer_goods_ecm`.`consumer`.`dtc_return`"
  dimensions:
    - name: "return_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month when the return was requested"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return process"
  measures:
    - name: "return_count"
      expr: COUNT(1)
      comment: "Total number of product returns"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Sum of monetary refunds issued"
    - name: "average_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score for returned items"
$$;