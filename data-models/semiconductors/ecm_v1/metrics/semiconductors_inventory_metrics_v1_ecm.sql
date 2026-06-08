-- Metric views for domain: inventory | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory quantities by location and material"
  source: "`semiconductors_ecm`.`inventory`.`stock_balance`"
  dimensions:
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Identifier of the storage location"
    - name: "material_id"
      expr: stock_material_master_id
      comment: "Material master identifier for the stock"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of the snapshot"
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock balances"
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for allocation"
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity currently reserved"
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations"
    - name: "total_qty_quality_inspection"
      expr: SUM(CAST(qty_quality_inspection AS DOUBLE))
      comment: "Total quantity under quality inspection"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation of inventory by location and method"
  source: "`semiconductors_ecm`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location identifier"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used for valuation (e.g., FIFO, LIFO)"
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory (raw, work-in-progress, finished)"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Aggregate monetary value of stock on hand"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of stock valuation"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of stock valuation"
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component of stock valuation"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracking of goods movements across locations"
  source: "`semiconductors_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (receipt, issue, transfer)"
    - name: "source_storage_location_id"
      expr: source_storage_location_id
      comment: "Source storage location identifier"
    - name: "destination_storage_location"
      expr: destination_storage_location
      comment: "Destination storage location code"
    - name: "movement_month"
      expr: DATE_TRUNC('month', movement_date)
      comment: "Month of the movement"
  measures:
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved in the period"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total monetary value of goods moved"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for consignment inventory"
  source: "`semiconductors_ecm`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "consignment_status"
      expr: consignment_status
      comment: "Current status of the consignment (active, expired, etc.)"
    - name: "consignment_type"
      expr: consignment_type
      comment: "Type of consignment agreement"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location where consignment stock resides"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the consigned material"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the consignment record was created"
  measures:
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity currently available in consignment stock"
    - name: "total_consigned_quantity"
      expr: SUM(CAST(consigned_quantity AS DOUBLE))
      comment: "Total quantity consigned to partners"
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed from consignment"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity in transit for consignment"
    - name: "total_valuation_amount"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Monetary valuation of consignment stock"
    - name: "average_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per unit in consignment"
$$;