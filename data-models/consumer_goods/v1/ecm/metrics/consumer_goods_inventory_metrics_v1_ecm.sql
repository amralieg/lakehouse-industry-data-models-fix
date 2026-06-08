-- Metric views for domain: inventory | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_intransit_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key shipment performance metrics for in‑transit shipments."
  source: "`consumer_goods_ecm`.`inventory`.`intransit_shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier handling the shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport"
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "expected_arrival_month"
      expr: DATE_TRUNC('month', expected_arrival_date)
      comment: "Month of expected arrival"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "on_time_shipments"
      expr: SUM(CASE WHEN on_time_flag THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on time"
    - name: "freight_cost_total"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost amount"
    - name: "average_shipment_weight"
      expr: AVG(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kg"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory cycle count accuracy and variance metrics."
  source: "`consumer_goods_ecm`.`inventory`.`inventory_cycle_count`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Storage location identifier"
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of the count"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of SKU"
  measures:
    - name: "total_counts"
      expr: COUNT(1)
      comment: "Number of cycle count records"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Sum of quantity variance across counts"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage"
    - name: "total_inventory_value_at_count"
      expr: SUM(CAST(inventory_value_at_count AS DOUBLE))
      comment: "Total inventory value captured at count"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out‑of‑stock events and associated lost sales impact."
  source: "`consumer_goods_ecm`.`inventory`.`oos_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "product_category"
      expr: product_category
      comment: "Product category"
    - name: "oos_type"
      expr: oos_type
      comment: "Type of OOS event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the OOS event"
    - name: "oos_start_month"
      expr: DATE_TRUNC('month', oos_start_timestamp)
      comment: "Month when OOS started"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel type"
  measures:
    - name: "oos_event_count"
      expr: COUNT(1)
      comment: "Number of OOS events"
    - name: "total_estimated_lost_sales"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Estimated lost sales value due to OOS"
    - name: "total_estimated_lost_units"
      expr: SUM(CAST(estimated_lost_units AS DOUBLE))
      comment: "Estimated lost units due to OOS"
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration of OOS events in hours"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_stock_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock adjustments impact on quantity and value."
  source: "`consumer_goods_ecm`.`inventory`.`stock_adjustment`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment"
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Month of adjustment"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the adjustment"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of stock adjustments"
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Sum of adjusted quantities"
    - name: "total_adjusted_value"
      expr: SUM(CAST(adjusted_value AS DOUBLE))
      comment: "Sum of adjusted monetary value"
    - name: "avg_adjustment_quantity"
      expr: AVG(CAST(adjusted_quantity AS DOUBLE))
      comment: "Average adjusted quantity per adjustment"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor‑managed inventory agreement performance metrics."
  source: "`consumer_goods_ecm`.`inventory`.`inventory_vmi_agreement`"
  dimensions:
    - name: "retail_store_id"
      expr: retail_store_id
      comment: "Retail store identifier"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of VMI agreement"
    - name: "inventory_ownership"
      expr: inventory_ownership
      comment: "Ownership model of inventory"
    - name: "agreement_status"
      expr: inventory_vmi_agreement_status
      comment: "Current status of the agreement"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Effective start month of the agreement"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of VMI agreements"
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage"
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage"
    - name: "avg_max_stock_level"
      expr: AVG(CAST(max_stock_level AS DOUBLE))
      comment: "Average maximum stock level"
    - name: "avg_min_stock_level"
      expr: AVG(CAST(min_stock_level AS DOUBLE))
      comment: "Average minimum stock level"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy parameters and service level targets."
  source: "`consumer_goods_ecm`.`inventory`.`safety_stock_policy`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Storage location identifier"
    - name: "policy_type"
      expr: policy_type
      comment: "Policy classification"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Effective from month"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock"
  measures:
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Number of safety stock policies"
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity"
    - name: "avg_service_level_target_percent"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percent"
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation of inventory stock."
  source: "`consumer_goods_ecm`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "valuation_date_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of valuation"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used for valuation"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of valuation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of valuation"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total stock value"
    - name: "avg_inventory_turnover_ratio"
      expr: AVG(CAST(inventory_turnover_ratio AS DOUBLE))
      comment: "Average inventory turnover ratio"
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total write‑down amount"
    - name: "avg_slow_moving_flag"
      expr: AVG(CASE WHEN slow_moving_flag THEN 1 ELSE 0 END)
      comment: "Proportion of slow‑moving stock"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Current stock position and availability metrics."
  source: "`consumer_goods_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "inventory_storage_location_id"
      expr: inventory_storage_location_id
      comment: "Storage location identifier"
    - name: "stock_status"
      expr: stock_status
      comment: "Stock status indicator"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock"
    - name: "record_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of the stock position record"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total reserved quantity"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity"
    - name: "total_unrestricted_quantity"
      expr: SUM(CAST(unrestricted_quantity AS DOUBLE))
      comment: "Total unrestricted quantity"
$$;