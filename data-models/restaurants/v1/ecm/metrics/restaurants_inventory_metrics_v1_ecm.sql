-- Metric views for domain: inventory | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_food_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food cost performance metrics per period"
  source: "`restaurants_ecm`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of cost period (e.g., monthly, weekly)"
    - name: "period_status"
      expr: period_status
      comment: "Current status of the period"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the cost period"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Identifier of the restaurant unit"
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Identifier of the franchisee"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary values"
  measures:
    - name: "period_count"
      expr: COUNT(1)
      comment: "Number of food cost periods"
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost across periods"
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue across periods"
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS percent"
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percent"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount between actual and theoretical costs"
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste percent"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key inventory adjustment metrics"
  source: "`restaurants_ecm`.`inventory`.`inventory_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment"
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date the adjustment was recorded"
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating if adjustment is shrinkage"
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Whether the adjustment impacts COGS"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit where adjustment occurred"
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee associated with the adjustment"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of inventory adjustments"
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total monetary value of adjustments"
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted"
    - name: "total_shrinkage_quantity"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN adjusted_quantity ELSE 0 END)
      comment: "Total quantity lost to shrinkage"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Snapshot‑level inventory valuation metrics"
  source: "`restaurants_ecm`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "sku_code"
      expr: sku_code
      comment: "SKU identifier"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record"
    - name: "is_perishable"
      expr: is_perishable
      comment: "Whether the item is perishable"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the inventory batch"
    - name: "snapshot_timestamp"
      expr: snapshot_timestamp
      comment: "Timestamp of the inventory snapshot"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit associated with the balance"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of on‑hand balance snapshots"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all SKUs"
    - name: "total_extended_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total monetary value of on‑hand inventory"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for sale"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical count accuracy and variance metrics"
  source: "`restaurants_ecm`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_date"
      expr: count_date
      comment: "Date the physical count was performed"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (e.g., completed, pending)"
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., period‑end, cycle)"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit where count occurred"
  measures:
    - name: "count_records"
      expr: COUNT(1)
      comment: "Number of physical count events"
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total value recorded during physical counts"
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system‑recorded inventory value at count time"
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Sum of monetary variance between physical and system values"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_waste`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste tracking metrics for operational efficiency"
  source: "`restaurants_ecm`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_date"
      expr: waste_date
      comment: "Date the waste was recorded"
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (e.g., spoilage, preparation)"
    - name: "waste_reason"
      expr: waste_reason
      comment: "Reason provided for waste"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit where waste occurred"
  measures:
    - name: "waste_event_count"
      expr: COUNT(1)
      comment: "Number of waste log events"
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of waste recorded"
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total monetary cost of waste"
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`inventory_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield and waste efficiency metrics for recipe preparation"
  source: "`restaurants_ecm`.`inventory`.`yield_record`"
  dimensions:
    - name: "prep_date"
      expr: prep_date
      comment: "Date of the preparation"
    - name: "recipe_id"
      expr: recipe_id
      comment: "Identifier of the recipe"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit where preparation occurred"
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Code indicating reason for waste"
  measures:
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield records captured"
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage across recipes"
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across preparations"
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity recorded in yield processes"
$$;