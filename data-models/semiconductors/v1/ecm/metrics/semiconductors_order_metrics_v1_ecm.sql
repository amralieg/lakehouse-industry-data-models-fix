-- Metric views for domain: order | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order level financial and status metrics"
  source: "`semiconductors_ecm`.`order`.`order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was created"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End market segment for the order"
    - name: "priority"
      expr: priority
      comment: "Priority flag for the order"
  measures:
    - name: "total_gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Sum of gross order value across all orders"
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order value across all orders"
    - name: "average_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of orders"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Count of orders with status Cancelled"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line level revenue, quantity and SKU diversity metrics"
  source: "`semiconductors_ecm`.`order`.`order_line`"
  dimensions:
    - name: "order_id"
      expr: primary_sales_order_id
      comment: "Identifier of the parent order"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for the line item"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line"
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Date the customer requested delivery"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Country to which the line is shipped"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity"
  measures:
    - name: "total_line_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Sum of net value for all order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all lines"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per order line"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs sold"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment level logistics and cost metrics"
  source: "`semiconductors_ecm`.`order`.`shipment`"
  dimensions:
    - name: "ship_date"
      expr: ship_date
      comment: "Date the shipment was sent"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier handling the shipment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country code of the shipment destination"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "is_multi_leg"
      expr: is_multi_leg
      comment: "Flag indicating if shipment involves multiple legs"
  measures:
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipments"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD"
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Number of shipment records"
    - name: "delayed_shipment_count"
      expr: SUM(CASE WHEN estimated_arrival_date < actual_arrival_date THEN 1 ELSE 0 END)
      comment: "Count of shipments that arrived later than estimated"
    - name: "damaged_shipment_count"
      expr: SUM(CASE WHEN damaged_goods_flag THEN 1 ELSE 0 END)
      comment: "Count of shipments flagged as damaged"
$$;