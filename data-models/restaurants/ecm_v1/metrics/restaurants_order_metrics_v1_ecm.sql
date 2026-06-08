-- Metric views for domain: order | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order‑level KPIs for revenue, tax, discount and guest reach"
  source: "`restaurants_ecm`.`order`.`guest_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., completed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Classification of order (e.g., dine‑in, delivery, drive‑thru)"
    - name: "daypart"
      expr: daypart
      comment: "Business daypart (e.g., breakfast, lunch, dinner)"
    - name: "site_id"
      expr: site_id
      comment: "Identifier of the restaurant site"
    - name: "unit_id"
      expr: unit_id
      comment: "Identifier of the restaurant unit"
    - name: "channel_id"
      expr: channel_id
      comment: "Sales channel through which the order was placed"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment settlement status"
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating if the order contains a limited‑time‑offer item"
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating if the order was voided"
  measures:
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of guest orders"
    - name: "total_order_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of all order total amounts (gross revenue)"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax collected across orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discounts applied to orders"
    - name: "average_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value per guest order"
    - name: "distinct_guest_count"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of unique guests placing orders"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item‑level financial and volume metrics for menu performance"
  source: "`restaurants_ecm`.`order`.`order_item`"
  dimensions:
    - name: "menu_item_id"
      expr: menu_item_id
      comment: "Identifier of the menu item sold"
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code for the sale"
    - name: "is_lto"
      expr: is_lto
      comment: "Flag for limited‑time‑offer items"
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Flag indicating if the item is part of a combo meal"
    - name: "item_status"
      expr: item_status
      comment: "Operational status of the line item"
  measures:
    - name: "order_item_count"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Sum of quantities across all line items"
    - name: "total_gross_amount"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Sum of gross amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net amount after discounts and taxes"
    - name: "total_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Sum of cost of goods sold for line items"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per line item"
    - name: "distinct_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of unique menu items sold"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction financial metrics"
  source: "`restaurants_ecm`.`order`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Settlement status of the payment"
    - name: "channel"
      expr: channel
      comment: "Channel through which the payment was captured"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the payment event"
    - name: "site_id"
      expr: site_id
      comment: "Restaurant site identifier"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Flag indicating split‑tender payment"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount captured from payments"
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amount collected via payments"
    - name: "total_interchange_fee"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees incurred"
    - name: "average_payment_amount"
      expr: AVG(CAST(applied_amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund activity and financial impact metrics"
  source: "`restaurants_ecm`.`order`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund"
    - name: "refund_reason"
      expr: reason_description
      comment: "Narrative reason for the refund"
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating if the refund was flagged as fraudulent"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the refund was processed"
    - name: "site_id"
      expr: site_id
      comment: "Restaurant site identifier"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
  measures:
    - name: "refund_count"
      expr: COUNT(1)
      comment: "Number of refund transactions"
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "average_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction"
    - name: "distinct_refund_reason_count"
      expr: COUNT(DISTINCT reason_description)
      comment: "Number of unique refund reasons"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key delivery performance and cost metrics"
  source: "`restaurants_ecm`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery"
    - name: "delivery_platform_id"
      expr: delivery_platform_id
      comment: "Identifier of the third‑party delivery platform"
    - name: "site_id"
      expr: site_id
      comment: "Restaurant site identifier"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Flag indicating contactless delivery"
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of any delivery exception"
  measures:
    - name: "delivery_order_count"
      expr: COUNT(1)
      comment: "Total number of delivery orders"
    - name: "total_delivery_fee"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Sum of delivery fees charged"
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Sum of tips collected for deliveries"
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Sum of platform commission amounts"
    - name: "total_delivery_distance_km"
      expr: SUM(CAST(delivery_distance_km AS DOUBLE))
      comment: "Total kilometers driven for deliveries"
    - name: "average_delivery_distance_km"
      expr: AVG(CAST(delivery_distance_km AS DOUBLE))
      comment: "Average delivery distance per order"
$$;