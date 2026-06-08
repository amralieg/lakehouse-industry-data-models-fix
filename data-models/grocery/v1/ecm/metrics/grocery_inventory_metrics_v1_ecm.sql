-- Metric views for domain: inventory | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory balances and quality signals per stock position"
  source: "`grocery_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Physical storage location identifier"
    - name: "category_id"
      expr: category_id
      comment: "Product category identifier"
    - name: "is_perishable"
      expr: is_perishable
      comment: "Indicates if the item is perishable"
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g., shelf, freezer)"
    - name: "oos_flag"
      expr: oos_flag
      comment: "Out‑of‑stock flag for the position"
    - name: "record_date"
      expr: DATE_TRUNC('day', record_created_timestamp)
      comment: "Date of the record"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total quantity physically on hand across all locations"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity that is reserved for pending orders"
    - name: "total_shrink_quantity"
      expr: SUM(CAST(shrink_quantity AS DOUBLE))
      comment: "Total quantity lost to shrinkage"
    - name: "average_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average recorded temperature (Celsius) for the stock position"
    - name: "oos_flagged_count"
      expr: SUM(CASE WHEN oos_flag THEN 1 ELSE 0 END)
      comment: "Count of stock positions flagged as out‑of‑stock"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Movement activity and cost efficiency"
  source: "`grocery_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (e.g., receipt, issue)"
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the movement"
    - name: "is_shrink"
      expr: is_shrink
      comment: "Flag indicating shrinkage movement"
    - name: "is_reserved"
      expr: is_reserved
      comment: "Flag indicating reserved inventory movement"
    - name: "is_cycle_count_correction"
      expr: is_cycle_count_correction
      comment: "Flag for cycle‑count correction movements"
    - name: "movement_date"
      expr: DATE_TRUNC('day', movement_timestamp)
      comment: "Date of the movement"
  measures:
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all goods movements"
    - name: "total_cost_at_movement"
      expr: SUM(CAST(cost_at_movement AS DOUBLE))
      comment: "Total cost associated with movements"
    - name: "shrink_quantity_moved"
      expr: SUM(CASE WHEN is_shrink THEN quantity ELSE 0 END)
      comment: "Quantity moved that was marked as shrink"
    - name: "average_cost_per_unit"
      expr: AVG(CAST(cost_at_movement AS DOUBLE))
      comment: "Average cost per unit for movements"
    - name: "movement_event_count"
      expr: COUNT(1)
      comment: "Number of movement events"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_replenishment_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Signals that drive inventory replenishment decisions"
  source: "`grocery_ecm`.`inventory`.`replenishment_signal`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "is_critical"
      expr: is_critical
      comment: "Criticality flag for the signal"
    - name: "is_oos"
      expr: is_oos
      comment: "Out‑of‑stock flag for the signal"
    - name: "signal_type"
      expr: signal_type
      comment: "Type of replenishment signal"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the signal"
    - name: "signal_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the signal was created"
  measures:
    - name: "total_signal_count"
      expr: COUNT(1)
      comment: "Number of replenishment signals generated"
    - name: "average_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_pct AS DOUBLE))
      comment: "Average forecast accuracy percentage across signals"
    - name: "critical_signal_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of signals marked as critical"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and accuracy of inventory cycle counts"
  source: "`grocery_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "sku"
      expr: sku
      comment: "SKU identifier"
    - name: "count_type"
      expr: count_type
      comment: "Method used for counting (e.g., manual, RFID)"
    - name: "cycle_count_status"
      expr: cycle_count_status
      comment: "Status of the cycle count"
    - name: "is_out_of_stock"
      expr: is_out_of_stock
      comment: "Flag indicating out‑of‑stock at count time"
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Temperature compliance flag for the counted items"
    - name: "count_date"
      expr: DATE_TRUNC('day', count_timestamp)
      comment: "Date of the cycle count"
  measures:
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total quantity counted during cycle counts"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Aggregate variance quantity across cycle counts"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage per cycle count"
    - name: "shrink_event_count"
      expr: SUM(CASE WHEN shrink_flag THEN 1 ELSE 0 END)
      comment: "Number of cycle counts flagged as shrink"
    - name: "cycle_count_event_count"
      expr: COUNT(1)
      comment: "Total number of cycle‑count events"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact of out‑of‑stock situations on sales and operations"
  source: "`grocery_ecm`.`inventory`.`oos_event`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "sku"
      expr: sku
      comment: "SKU identifier"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where OOS occurred"
    - name: "oos_severity"
      expr: oos_severity
      comment: "Severity classification of the OOS event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the OOS"
    - name: "is_resolved"
      expr: is_resolved
      comment: "Resolution status of the OOS event"
    - name: "oos_event_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the OOS event was created"
  measures:
    - name: "total_estimated_lost_sales_value"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Estimated revenue loss due to out‑of‑stock events"
    - name: "average_oos_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration (hours) of out‑of‑stock events"
    - name: "oos_event_count"
      expr: COUNT(1)
      comment: "Number of out‑of‑stock events recorded"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_shrink_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shrinkage tracking and cost impact"
  source: "`grocery_ecm`.`inventory`.`shrink_record`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "shrink_category"
      expr: shrink_category
      comment: "High‑level category of shrink (e.g., damage, theft)"
    - name: "shrink_cause"
      expr: shrink_cause
      comment: "Specific cause of shrinkage"
    - name: "temperature_violation"
      expr: temperature_violation
      comment: "Flag indicating temperature violation contributed to shrink"
    - name: "shrink_record_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the shrink record was created"
  measures:
    - name: "total_quantity_lost"
      expr: SUM(CAST(quantity_lost AS DOUBLE))
      comment: "Total quantity lost due to shrinkage"
    - name: "total_estimated_shrink_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Estimated cost associated with shrinkage"
    - name: "shrink_event_count"
      expr: COUNT(1)
      comment: "Number of shrinkage records"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_stock_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustments and their financial impact"
  source: "`grocery_ecm`.`inventory`.`stock_adjustment`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "sku"
      expr: sku
      comment: "SKU identifier"
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Code representing the reason for adjustment"
    - name: "adjustment_reason_description"
      expr: adjustment_reason_description
      comment: "Human‑readable description of adjustment reason"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where adjustment occurred"
    - name: "adjustment_date"
      expr: DATE_TRUNC('day', adjustment_timestamp)
      comment: "Date of the adjustment event"
  measures:
    - name: "total_quantity_adjusted"
      expr: SUM(CAST(quantity_adjusted AS DOUBLE))
      comment: "Aggregate quantity adjusted across all stock adjustments"
    - name: "total_adjusted_cost"
      expr: SUM(CAST(total_adjusted_cost AS DOUBLE))
      comment: "Total cost impact of stock adjustments"
    - name: "stock_adjustment_event_count"
      expr: COUNT(1)
      comment: "Number of stock adjustment events"
$$;