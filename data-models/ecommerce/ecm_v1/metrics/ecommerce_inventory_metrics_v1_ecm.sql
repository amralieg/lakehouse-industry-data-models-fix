-- Metric views for domain: inventory | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Snapshot-level inventory overview per warehouse and SKU"
  source: "`ecommerce_ecm`.`inventory`.`snapshot`"
  dimensions:
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the inventory snapshot"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of snapshot records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_snapshot_measures`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated inventory health metrics from snapshot data"
  source: "`ecommerce_ecm`.`inventory`.`snapshot`"
  dimensions:
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total quantity on hand across all snapshots"
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand"
    - name: "average_days_of_cover"
      expr: AVG(CAST(days_of_cover AS DOUBLE))
      comment: "Average days of inventory cover"
    - name: "total_oos_flagged"
      expr: SUM(CASE WHEN oos_flag THEN 1 ELSE 0 END)
      comment: "Count of snapshots where inventory is out‑of‑stock"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key OOS performance indicators"
  source: "`ecommerce_ecm`.`inventory`.`oos_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU impacted by OOS"
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse where OOS occurred"
    - name: "oos_status"
      expr: oos_status
      comment: "Current status of the OOS event"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the OOS event"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the SKU"
  measures:
    - name: "total_oos_events"
      expr: COUNT(1)
      comment: "Number of out‑of‑stock events"
    - name: "total_estimated_lost_revenue"
      expr: SUM(CAST(estimated_lost_revenue AS DOUBLE))
      comment: "Estimated revenue lost due to OOS events"
    - name: "average_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration of OOS events in hours"
    - name: "average_customer_impact_score"
      expr: AVG(CAST(customer_impact_score AS DOUBLE))
      comment: "Average impact score on customers"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order efficiency and cost metrics"
  source: "`ecommerce_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being replenished"
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse receiving the replenishment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order"
    - name: "replenishment_status"
      expr: replenishment_status
      comment: "Current status of the replenishment order"
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Number of replenishment orders placed"
    - name: "average_lead_time_days"
      expr: AVG(DATEDIFF(day, created_timestamp, expected_receipt_date))
      comment: "Average lead time from order creation to expected receipt"
    - name: "average_order_quantity"
      expr: AVG(CAST(order_quantity AS DOUBLE))
      comment: "Average quantity per replenishment order"
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total monetary cost of all replenishment orders"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation of inventory assets"
  source: "`ecommerce_ecm`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node where valuation is recorded"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the valuation"
  measures:
    - name: "total_valuation_amount"
      expr: SUM(CAST(layer_value AS DOUBLE))
      comment: "Total value of inventory valuation layers"
    - name: "average_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per unit"
    - name: "total_cogs_allocated"
      expr: SUM(CAST(cogs_allocated AS DOUBLE))
      comment: "Total cost of goods sold allocated"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics"
  source: "`ecommerce_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being counted"
    - name: "warehouse_node_id"
      expr: warehouse_node_id
      comment: "Warehouse node where count occurred"
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., full, partial)"
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date for the cycle count"
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Number of cycle count events"
    - name: "average_variance_quantity"
      expr: AVG(CAST(variance_quantity AS DOUBLE))
      comment: "Average quantity variance discovered during cycle counts"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance discovered"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total quantity counted across all cycle counts"
$$;