-- Metric views for domain: material | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement activity across warehouses"
  source: "`construction_ecm`.`material`.`stock_movement`"
  dimensions:
    - name: "material_code"
      expr: material_code
      comment: "Material code"
    - name: "material_description"
      expr: material_description
      comment: "Material description"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure"
    - name: "source_warehouse_code"
      expr: source_warehouse_code
      comment: "Source warehouse code"
    - name: "destination_warehouse_code"
      expr: destination_warehouse_code
      comment: "Destination warehouse code"
    - name: "movement_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of movement record"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Hazardous material flag"
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Critical material flag"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of movement"
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received in movements"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of movements"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of movements"
    - name: "distinct_materials_moved"
      expr: COUNT(DISTINCT material_code)
      comment: "Count of distinct material codes moved"
    - name: "movement_count"
      expr: COUNT(1)
      comment: "Number of stock movement records"
$$;