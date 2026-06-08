-- Metric views for domain: inventory | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory balances by location, SKU and valuation attributes"
  source: "`automotive_ecm`.`inventory`.`stock_balance`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the stock is located"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Identifier of the storage location"
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU identifier"
    - name: "valuation_area_code"
      expr: valuation_area_code
      comment: "Valuation area code for accounting"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the stock"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method type"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock records"
    - name: "total_stock_valuation"
      expr: SUM(CAST(valuation_price AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total monetary value of stock on hand (valuation price multiplied by quantity)"
    - name: "total_blocked_stock_qty"
      expr: SUM(CAST(blocked_stock_qty AS DOUBLE))
      comment: "Sum of blocked stock quantity"
    - name: "total_in_transit_stock_qty"
      expr: SUM(CAST(in_transit_stock_qty AS DOUBLE))
      comment: "Sum of stock currently in transit"
    - name: "total_unrestricted_stock_qty"
      expr: SUM(CAST(unrestricted_stock_qty AS DOUBLE))
      comment: "Sum of unrestricted (available) stock quantity"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation snapshot metrics for financial analysis"
  source: "`automotive_ecm`.`inventory`.`inventory_valuation`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the valuation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "period"
      expr: period
      comment: "Period within the fiscal year"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the valuation snapshot"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record"
  measures:
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Aggregate quantity of stock covered by valuation records"
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Aggregate monetary value of stock per valuation"
    - name: "average_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across valuation records"
    - name: "average_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price"
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Sum of price variance amounts"
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total write‑down amount recorded"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational movement KPIs for inventory flow monitoring"
  source: "`automotive_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type_id"
      expr: movement_type_id
      comment: "Identifier of the movement type"
    - name: "source_storage_location_id"
      expr: source_storage_location_id
      comment: "Source storage location"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the movement was posted"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the movement was automated"
  measures:
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all goods movements"
    - name: "total_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total monetary amount in USD"
    - name: "total_amount_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total monetary amount in local currency"
    - name: "movement_count"
      expr: COUNT(1)
      comment: "Number of goods movement records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment activity metrics to monitor inventory corrections"
  source: "`automotive_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where adjustment was applied"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the adjustment was posted"
    - name: "is_approved"
      expr: is_approved
      comment: "Approval flag for the adjustment"
  measures:
    - name: "total_quantity_adjusted"
      expr: SUM(CAST(quantity_adjusted AS DOUBLE))
      comment: "Sum of quantity adjustments"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact from adjustments"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustment records"
    - name: "average_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per adjustment"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count performance indicators for inventory accuracy"
  source: "`automotive_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where cycle count was performed"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location counted"
    - name: "count_date"
      expr: count_date
      comment: "Date of the cycle count"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (e.g., completed, pending)"
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory counted"
  measures:
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total quantity counted during cycle counts"
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book quantity recorded"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Aggregate variance quantity"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts"
    - name: "cycle_count_records"
      expr: COUNT(1)
      comment: "Number of cycle count records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_finished_vehicle_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for finished vehicle inventory, supporting sales and production planning"
  source: "`automotive_ecm`.`inventory`.`finished_vehicle_stock`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where vehicle was produced"
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Program identifier for the vehicle"
    - name: "model_code"
      expr: model_code
      comment: "Model code of the vehicle"
    - name: "color"
      expr: color
      comment: "Exterior color"
    - name: "body_style"
      expr: body_style
      comment: "Body style (e.g., sedan, SUV)"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain classification (e.g., ICE, Hybrid, EV)"
    - name: "stock_status"
      expr: stock_status
      comment: "Current stock status of the vehicle"
    - name: "delivery_date"
      expr: delivery_date
      comment: "Scheduled delivery date"
  measures:
    - name: "vehicle_count"
      expr: COUNT(1)
      comment: "Number of finished vehicles in stock"
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Aggregate MSRP value of finished vehicles"
    - name: "average_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per vehicle"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`inventory_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master SKU catalog metrics for product portfolio analysis"
  source: "`automotive_ecm`.`inventory`.`sku_master`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "High‑level product category"
    - name: "product_subcategory"
      expr: product_subcategory
      comment: "Sub‑category within the product line"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Base unit of measure for the SKU"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class used for accounting"
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Indicates if the SKU is hazardous"
  measures:
    - name: "sku_count"
      expr: COUNT(1)
      comment: "Number of distinct SKUs"
    - name: "average_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across SKUs"
    - name: "average_last_price"
      expr: AVG(CAST(last_price AS DOUBLE))
      comment: "Average last recorded price"
    - name: "total_max_order_qty"
      expr: SUM(CAST(max_order_qty AS DOUBLE))
      comment: "Sum of maximum order quantities"
    - name: "total_min_order_qty"
      expr: SUM(CAST(min_order_qty AS DOUBLE))
      comment: "Sum of minimum order quantities"
    - name: "average_safety_stock_qty"
      expr: AVG(CAST(safety_stock_qty AS DOUBLE))
      comment: "Average safety stock quantity per SKU"
$$;