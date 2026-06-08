-- Metric views for domain: inventory | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core valuation metrics for inventory stock positions"
  source: "`agriculture_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier where stock is located"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location identifier"
    - name: "stock_type"
      expr: stock_type
      comment: "Classification of stock (e.g., raw, finished)"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of valuation"
  measures:
    - name: "total_inventory_value_usd"
      expr: SUM(CAST(total_value_usd AS DOUBLE))
      comment: "Total monetary value of inventory on hand in USD"
    - name: "average_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price of inventory items in USD"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand across all stock positions"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_bin_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization and capacity metrics for storage bins"
  source: "`agriculture_ecm`.`inventory`.`bin_location`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier for the bin"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location identifier containing the bin"
    - name: "bin_type"
      expr: bin_type
      comment: "Type of bin (e.g., bulk, pallet)"
    - name: "bin_status"
      expr: bin_status
      comment: "Current operational status of the bin"
  measures:
    - name: "average_utilization_pct"
      expr: AVG(CAST(current_utilization_pct AS DOUBLE))
      comment: "Average bin utilization percentage"
    - name: "total_capacity_bu"
      expr: SUM(CAST(capacity_bu AS DOUBLE))
      comment: "Total bin capacity in business units"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_adjustments`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and quantity impact of inventory adjustments"
  source: "`agriculture_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of adjustment (e.g., shrinkage, correction)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where adjustment occurred"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the adjustment was posted"
  measures:
    - name: "total_adjustment_value_usd"
      expr: SUM(CAST(value_impact_usd AS DOUBLE))
      comment: "Total monetary impact of inventory adjustments in USD"
    - name: "total_adjusted_qty"
      expr: SUM(CAST(adjusted_qty AS DOUBLE))
      comment: "Sum of quantities adjusted"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustment records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor cycle count accuracy and variance"
  source: "`agriculture_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location counted"
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, partial)"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count process"
    - name: "count_date"
      expr: count_date
      comment: "Date the count took place"
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count events"
    - name: "cycle_counts_with_variance"
      expr: COUNT(CASE WHEN variance_qty <> 0 THEN 1 END)
      comment: "Number of cycle counts where counted quantity differed from system quantity"
    - name: "total_variance_qty"
      expr: SUM(CAST(variance_qty AS DOUBLE))
      comment: "Aggregate quantity variance across all cycle counts"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key issuance metrics for tracking outbound inventory movement"
  source: "`agriculture_ecm`.`inventory`.`goods_issue`"
  dimensions:
    - name: "posting_date"
      expr: posting_date
      comment: "Date the goods issue was posted"
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Code representing the type of movement"
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates if the issued material is GMO"
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Indicates if the issued material is organically certified"
  measures:
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of goods issued"
    - name: "total_issue_cost_usd"
      expr: SUM(CAST(total_cost_usd AS DOUBLE))
      comment: "Total cost associated with goods issued in USD"
    - name: "average_unit_cost_usd"
      expr: AVG(CAST(unit_cost_usd AS DOUBLE))
      comment: "Average unit cost of issued goods in USD"
$$;