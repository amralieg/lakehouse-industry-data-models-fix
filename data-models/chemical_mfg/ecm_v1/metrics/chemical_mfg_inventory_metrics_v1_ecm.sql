-- Metric views for domain: inventory | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key consignment inventory KPIs for strategic oversight of vendor‑managed stock"
  source: "`chemical_mfg_ecm`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "site_id"
      expr: site_id
      comment: "Site where consignment stock is held"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the consignment stock"
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Chemical product identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the consignment value"
    - name: "consignment_stock_status"
      expr: consignment_stock_status
      comment: "Current status of the consignment stock"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if the material is hazardous"
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Expiration month for aging analysis"
  measures:
    - name: "total_consignment_quantity"
      expr: SUM(CAST(consignment_quantity AS DOUBLE))
      comment: "Total quantity of consignment stock"
    - name: "total_consignment_value"
      expr: SUM(CAST(consignment_value AS DOUBLE))
      comment: "Total monetary value of consignment stock"
    - name: "average_consignment_quantity"
      expr: AVG(CAST(consignment_quantity AS DOUBLE))
      comment: "Average quantity per consignment record"
    - name: "average_consignment_value"
      expr: AVG(CAST(consignment_value AS DOUBLE))
      comment: "Average value per consignment record"
    - name: "consignment_stock_record_count"
      expr: COUNT(1)
      comment: "Number of consignment stock records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory balance KPIs to drive inventory optimization and working‑capital decisions"
  source: "`chemical_mfg_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "warehouse_location_id"
      expr: warehouse_location_id
      comment: "Warehouse location identifier"
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Chemical product identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the stock is located"
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency of the valuation price"
    - name: "stock_category"
      expr: stock_category
      comment: "Category of stock (e.g., raw, work‑in‑process, finished)"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on‑hand quantity across all stock positions"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for allocation"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity currently reserved"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity"
    - name: "total_inventory_value"
      expr: SUM(on_hand_quantity * valuation_price)
      comment: "Monetary value of on‑hand inventory (quantity × valuation price)"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Movement KPIs to monitor throughput, logistics efficiency and cost impact"
  source: "`chemical_mfg_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Code describing the type of movement (e.g., receipt, issue)"
    - name: "movement_category"
      expr: movement_category
      comment: "Higher‑level category of movement"
    - name: "movement_direction"
      expr: movement_direction
      comment: "Direction of movement (IN/OUT)"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where movement originated"
    - name: "warehouse_location_id"
      expr: warehouse_location_id
      comment: "Warehouse location involved in the movement"
    - name: "material_number"
      expr: material_number
      comment: "Material number of the product moved"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates if the material is hazardous"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved in the period"
    - name: "total_movement_amount"
      expr: SUM(CAST(movement_amount AS DOUBLE))
      comment: "Total monetary amount associated with movements"
    - name: "average_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per movement transaction"
    - name: "movement_record_count"
      expr: COUNT(1)
      comment: "Number of stock movement records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment KPIs to track inventory corrections, financial impact and control effectiveness"
  source: "`chemical_mfg_ecm`.`inventory`.`inventory_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., correction, write‑off)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where adjustment occurred"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if the adjusted material is hazardous"
  measures:
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity adjusted (positive or negative)"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_value AS DOUBLE))
      comment: "Monetary impact of inventory adjustments"
    - name: "adjustment_record_count"
      expr: COUNT(1)
      comment: "Number of inventory adjustment records"
$$;