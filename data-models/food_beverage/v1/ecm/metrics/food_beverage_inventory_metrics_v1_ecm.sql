-- Metric views for domain: inventory | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory balances and valuation at the stock position level"
  source: "`food_beverage_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Warehouse/storage location identifier"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the storage location"
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency of the valuation amount"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the stock position record was created"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Count of stock position records"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock positions"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for allocation"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity currently reserved"
    - name: "total_quantity_blocked"
      expr: SUM(CAST(quantity_blocked AS DOUBLE))
      comment: "Total quantity blocked due to quality or regulatory holds"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Aggregate monetary valuation of inventory"
    - name: "average_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Track inbound/outbound inventory movements"
  source: "`food_beverage_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of movement (e.g., receipt, issue)"
    - name: "movement_indicator"
      expr: movement_indicator
      comment: "Indicator of movement direction"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the movement"
    - name: "source_storage_location"
      expr: source_storage_location
      comment: "Origin storage location code"
    - name: "destination_storage_location"
      expr: destination_storage_location
      comment: "Destination storage location code"
    - name: "posting_day"
      expr: DATE_TRUNC('day', posting_date)
      comment: "Posting date of the movement"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Count of goods movement transactions"
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_amount_lc"
      expr: SUM(CAST(amount_lc AS DOUBLE))
      comment: "Total local currency amount of movements"
    - name: "distinct_skus_moved"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs moved"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory audit performance and variance metrics"
  source: "`food_beverage_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "center_id"
      expr: center_id
      comment: "Distribution center identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "cycle_count_status"
      expr: cycle_count_status
      comment: "Status of the cycle count (e.g., completed, pending)"
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, partial)"
    - name: "scheduled_day"
      expr: DATE_TRUNC('day', scheduled_date)
      comment: "Scheduled date for the cycle count"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Count of cycle count events"
    - name: "average_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average accuracy of cycle counts"
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total monetary variance identified during cycle counts"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and quantity impact of inventory adjustments"
  source: "`food_beverage_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of adjustment (e.g., reclass, correction)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "is_manual_adjustment"
      expr: is_manual_adjustment
      comment: "Flag indicating if adjustment was entered manually"
    - name: "is_quality_hold"
      expr: is_quality_hold
      comment: "Flag indicating if adjustment is due to quality hold"
    - name: "posting_day"
      expr: DATE_TRUNC('day', posting_date)
      comment: "Posting date of the adjustment"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Count of inventory adjustments"
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted across all records"
    - name: "total_adjusted_value"
      expr: SUM(CAST(adjusted_value_amount AS DOUBLE))
      comment: "Total monetary value of adjustments"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of adjustments"
$$;