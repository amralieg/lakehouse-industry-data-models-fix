-- Metric views for domain: supply | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_case_cart_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and waste metrics for case carts, enabling cost management per care site and procedure."
  source: "`healthcare_ecm`.`supply`.`case_cart`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the case cart is used"
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure associated with the case cart"
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical priority level of the case"
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the case cart"
    - name: "assembly_status"
      expr: assembly_status
      comment: "Assembly status of the case cart"
    - name: "scheduled_procedure_date"
      expr: scheduled_procedure_date
      comment: "Scheduled date of the procedure"
  measures:
    - name: "total_supply_cost_sum"
      expr: SUM(CAST(total_supply_cost AS DOUBLE))
      comment: "Total supply cost across case carts"
    - name: "waste_cost_sum"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total waste cost associated with case carts"
    - name: "case_cart_count"
      expr: COUNT(1)
      comment: "Number of case cart records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory balance metrics for monitoring stock levels, value, and stockouts."
  source: "`healthcare_ecm`.`supply`.`inventory_balance`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site identifier"
    - name: "inventory_location_id"
      expr: inventory_location_id
      comment: "Inventory location identifier"
    - name: "item_category"
      expr: item_category
      comment: "Category of the inventory item"
    - name: "stockout_flag"
      expr: stockout_flag
      comment: "Flag indicating a stockout condition"
    - name: "last_movement_date"
      expr: last_movement_date
      comment: "Date of the last inventory movement"
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across inventory balances"
    - name: "total_inventory_value"
      expr: SUM(qty_on_hand * unit_cost)
      comment: "Monetary value of inventory on hand (qty * unit cost)"
    - name: "stockout_incidents"
      expr: SUM(CASE WHEN stockout_flag THEN 1 ELSE 0 END)
      comment: "Count of stockout incidents"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_purchase_order_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for purchase orders to support spend analysis."
  source: "`healthcare_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the purchase order"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods"
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period of the purchase order"
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was created"
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of purchase orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of purchase orders"
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Number of purchase order records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_purchase_order_line_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and quantity metrics for purchase order lines."
  source: "`healthcare_ecm`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site linked to the line item"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor for the line item"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier for the item"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the purchase order line"
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase order lines"
    - name: "total_line_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across lines"
    - name: "purchase_order_line_count"
      expr: COUNT(1)
      comment: "Number of purchase order line records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_recall_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall incident metrics to monitor product safety and compliance."
  source: "`healthcare_ecm`.`supply`.`recall_notice`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site impacted by the recall"
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall"
    - name: "recall_class"
      expr: recall_class
      comment: "Regulatory class of the recall"
    - name: "recall_initiation_source"
      expr: recall_initiation_source
      comment: "Source that initiated the recall"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of recall notices"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_sterile_processing_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Efficiency metrics for sterile processing cycles."
  source: "`healthcare_ecm`.`supply`.`sterile_processing_record`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where processing occurred"
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Method used for sterilization"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of processing cycle"
  measures:
    - name: "avg_cycle_seconds"
      expr: AVG(UNIX_TIMESTAMP(sterilization_timestamp) - UNIX_TIMESTAMP(assembly_timestamp))
      comment: "Average cycle time in seconds from assembly to sterilization"
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of sterile processing records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_surgical_bom_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimation metrics for surgical bill of materials."
  source: "`healthcare_ecm`.`supply`.`surgical_bom`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the BOM"
    - name: "procedure_name"
      expr: procedure_name
      comment: "Name of the surgical procedure"
  measures:
    - name: "total_estimated_supply_cost"
      expr: SUM(CAST(estimated_supply_cost AS DOUBLE))
      comment: "Total estimated supply cost for surgical BOMs"
    - name: "total_estimated_implant_cost"
      expr: SUM(CAST(estimated_implant_cost AS DOUBLE))
      comment: "Total estimated implant cost for surgical BOMs"
    - name: "bom_count"
      expr: COUNT(1)
      comment: "Number of surgical BOM records"
$$;