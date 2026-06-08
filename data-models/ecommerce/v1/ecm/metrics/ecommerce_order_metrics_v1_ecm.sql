-- Metric views for domain: order | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level order‑level KPIs for revenue, discounts, tax and SLA breaches"
  source: "`ecommerce_ecm`.`order`.`header`"
  dimensions:
    - name: "order_source"
      expr: order_source
      comment: "Origin channel of the order (e.g., web, mobile)"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., B2B, B2C)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order"
    - name: "order_placed_date"
      expr: DATE_TRUNC('day', order_placed_timestamp)
      comment: "Date the order was placed (day granularity)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the order"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates if the order is tax‑exempt"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the order"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed"
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of order total amounts (gross revenue)"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value across all orders"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on orders"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line‑level revenue and quantity metrics for detailed order analysis"
  source: "`ecommerce_ecm`.`order`.`line`"
  dimensions:
    - name: "marketplace_listing_id"
      expr: marketplace_listing_id
      comment: "Marketplace listing reference"
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Number of order line records"
    - name: "total_gross"
      expr: SUM(CAST(total_gross AS DOUBLE))
      comment: "Sum of gross amount for all order lines"
    - name: "total_net"
      expr: SUM(CAST(total_net AS DOUBLE))
      comment: "Sum of net amount for all order lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items ordered across all lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied at line level"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line level"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment‑related financial KPIs for the order domain"
  source: "`ecommerce_ecm`.`order`.`order_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., credit_card, paypal)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "is_refund"
      expr: is_refund
      comment: "Flag indicating if the payment is a refund"
    - name: "is_gift_card"
      expr: is_gift_card
      comment: "Indicates if the payment involved a gift card"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "channel"
      expr: channel
      comment: "Channel through which the payment was made"
    - name: "payment_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the payment record was created"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount captured across all payments"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees associated with payments"
    - name: "total_refunded_amount"
      expr: SUM(CAST(refunded_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service‑level agreement performance metrics"
  source: "`ecommerce_ecm`.`order`.`order_sla`"
  dimensions:
    - name: "sla_tier"
      expr: sla_tier
      comment: "Tier of the SLA (e.g., Gold, Silver)"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier responsible for delivery"
    - name: "breach_flag"
      expr: breach_flag
      comment: "Boolean flag indicating SLA breach"
    - name: "sla_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the SLA record was created"
  measures:
    - name: "sla_count"
      expr: COUNT(1)
      comment: "Total number of SLA records"
    - name: "breached_sla_count"
      expr: SUM(CASE WHEN breach_flag THEN 1 ELSE 0 END)
      comment: "Count of SLAs that were breached"
    - name: "total_actual_handling_time_hours"
      expr: SUM(CAST(actual_handling_time_hours AS DOUBLE))
      comment: "Cumulative actual handling time across all SLAs"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation and refund KPIs to monitor order churn"
  source: "`ecommerce_ecm`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Current status of the cancellation request"
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Type/category of cancellation"
    - name: "is_partial"
      expr: is_partial
      comment: "Indicates if the cancellation was partial"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the cancellation originated"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized code for cancellation reason"
    - name: "cancellation_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the cancellation record was created"
  measures:
    - name: "cancellation_count"
      expr: COUNT(1)
      comment: "Total number of cancellations"
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Sum of monetary value of cancelled orders"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount processed for cancellations"
$$;