-- Metric views for domain: distribution | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key shipment performance metrics for distribution operations"
  source: "`consumer_goods_ecm`.`distribution`.`distribution_shipment`"
  dimensions:
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('day', scheduled_delivery_date)
      comment: "Scheduled delivery date (day bucket)"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records"
    - name: "on_time_shipments"
      expr: SUM(CASE WHEN on_time_flag THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on time"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Sum of freight charge amounts for shipments"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order financial and fulfillment KPIs"
  source: "`consumer_goods_ecm`.`distribution`.`outbound_order`"
  dimensions:
    - name: "distribution_facility_id"
      expr: distribution_facility_id
      comment: "Distribution facility shipping the order"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier used for the outbound order"
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Order creation date (day bucket)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account associated with the order"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Sum of total order monetary value"
    - name: "average_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average order value per outbound order"
    - name: "average_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage across orders"
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total quantity of items ordered"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receipt accuracy and volume metrics"
  source: "`consumer_goods_ecm`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "distribution_facility_id"
      expr: distribution_facility_id
      comment: "Facility receiving the inbound shipment"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier that delivered the inbound shipment"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the inbound goods"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total inbound receipt records"
    - name: "discrepant_receipts"
      expr: SUM(CASE WHEN discrepancy_flag THEN 1 ELSE 0 END)
      comment: "Count of receipts flagged with discrepancies"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Sum of quantity actually received"
    - name: "average_received_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity per receipt"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Sum of quantity rejected during receipt"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance KPIs"
  source: "`consumer_goods_ecm`.`distribution`.`distribution_cycle_count`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being counted"
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, partial)"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count process"
    - name: "count_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the count record was created"
  measures:
    - name: "total_counts"
      expr: COUNT(1)
      comment: "Total cycle count events"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Sum of counted inventory quantity"
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Sum of system recorded quantity"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts"
    - name: "variance_events"
      expr: SUM(CASE WHEN variance_quantity != 0 THEN 1 ELSE 0 END)
      comment: "Number of cycle counts with non‑zero variance"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_otif_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On‑time‑in‑full performance metrics"
  source: "`consumer_goods_ecm`.`distribution`.`otif_event`"
  dimensions:
    - name: "distribution_facility_id"
      expr: distribution_facility_id
      comment: "Facility responsible for the delivery"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier used for the delivery"
    - name: "retail_store_id"
      expr: retail_store_id
      comment: "Retail store receiving the delivery"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account linked to the delivery"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_date)
      comment: "Date of OTIF measurement (day bucket)"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which delivery was made"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total OTIF events recorded"
    - name: "otif_success_events"
      expr: SUM(CASE WHEN otif_score THEN 1 ELSE 0 END)
      comment: "Count of OTIF events that met the OTIF criteria"
    - name: "average_quantity_variance_percent"
      expr: AVG(CAST(quantity_variance_percent AS DOUBLE))
      comment: "Average quantity variance percent across OTIF events"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Sum of quantity actually delivered"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Sum of quantity originally committed"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick task efficiency and accuracy metrics"
  source: "`consumer_goods_ecm`.`distribution`.`pick_task`"
  dimensions:
    - name: "distribution_facility_id"
      expr: distribution_facility_id
      comment: "Facility where picking occurs"
    - name: "outbound_order_id"
      expr: outbound_order_id
      comment: "Outbound order associated with the pick task"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being picked"
    - name: "primary_pick_employee_id"
      expr: primary_pick_employee_id
      comment: "Employee responsible for the primary pick"
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pick task"
    - name: "pick_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pick task was created (day bucket)"
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total pick task records"
    - name: "pick_accuracy_count"
      expr: SUM(CASE WHEN pick_accuracy_flag THEN 1 ELSE 0 END)
      comment: "Number of pick tasks marked as accurate"
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Sum of quantity requested for picking"
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Sum of quantity actually picked"
    - name: "average_gross_weight"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per pick task"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging throughput and performance metrics"
  source: "`consumer_goods_ecm`.`distribution`.`pack_task`"
  dimensions:
    - name: "outbound_order_id"
      expr: outbound_order_id
      comment: "Outbound order linked to the pack task"
    - name: "pack_status"
      expr: pack_status
      comment: "Current status of the pack task"
    - name: "pack_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pack task was created (day bucket)"
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total pack task records"
    - name: "average_pack_duration"
      expr: AVG(CAST(pack_duration_minutes AS DOUBLE))
      comment: "Average pack duration in minutes"
    - name: "total_units_packed"
      expr: SUM(CAST(total_unit_quantity AS DOUBLE))
      comment: "Total units packed across tasks"
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of packed items"
$$;