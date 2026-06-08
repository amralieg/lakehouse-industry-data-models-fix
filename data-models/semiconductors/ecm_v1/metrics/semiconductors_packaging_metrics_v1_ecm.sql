-- Metric views for domain: packaging | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`packaging_assembly_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key production and cost metrics at the assembly lot level"
  source: "`semiconductors_ecm`.`packaging`.`assembly_lot`"
  dimensions:
    - name: "assembly_lot_id"
      expr: assembly_lot_id
      comment: "Primary key of the assembly lot"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the lot"
    - name: "packaging_line_id"
      expr: packaging_line_id
      comment: "Packaging line where the lot is processed"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot"
    - name: "start_date"
      expr: start_date
      comment: "Planned start date of the lot"
    - name: "target_completion_date"
      expr: target_completion_date
      comment: "Planned completion date"
  measures:
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total cost estimate in USD for the lot"
    - name: "avg_cumulative_yield_percent"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield percent across lots"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density for the lot"
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Number of assembly lots"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`packaging_assembly_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and yield performance of assembly orders"
  source: "`semiconductors_ecm`.`packaging`.`assembly_order`"
  dimensions:
    - name: "assembly_order_id"
      expr: assembly_order_id
      comment: "Primary key of the assembly order"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being assembled"
    - name: "account_id"
      expr: account_id
      comment: "Customer account associated with the order"
    - name: "assembly_site"
      expr: assembly_site
      comment: "Site where assembly occurs"
    - name: "assembly_order_status"
      expr: assembly_order_status
      comment: "Current status of the assembly order"
    - name: "priority"
      expr: priority
      comment: "Priority level of the order"
    - name: "target_ship_date"
      expr: target_ship_date
      comment: "Planned ship date"
  measures:
    - name: "total_cost_gross_usd"
      expr: SUM(CAST(cost_gross_amount AS DOUBLE))
      comment: "Total gross cost in USD for assembly orders"
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percent across orders"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of assembly orders"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`packaging_assembly_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield and quality metrics per assembly step"
  source: "`semiconductors_ecm`.`packaging`.`assembly_yield`"
  dimensions:
    - name: "assembly_yield_id"
      expr: assembly_yield_id
      comment: "Primary key of the assembly yield record"
    - name: "assembly_lot_id"
      expr: assembly_lot_id
      comment: "Lot associated with the yield record"
    - name: "process_step"
      expr: process_step
      comment: "Process step name"
    - name: "step_sequence"
      expr: step_sequence
      comment: "Sequence order of the step"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped units"
  measures:
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percent per process step"
    - name: "avg_cumulative_yield_percent"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield percent per step"
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defects per million (DPPM) per step"
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`packaging_assembly_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect severity and frequency metrics"
  source: "`semiconductors_ecm`.`packaging`.`assembly_defect`"
  dimensions:
    - name: "assembly_defect_id"
      expr: assembly_defect_id
      comment: "Primary key of the defect record"
    - name: "defect_category"
      expr: defect_category
      comment: "Category of the defect"
    - name: "defect_type"
      expr: defect_type
      comment: "Specific type of defect"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the defect"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if defect is critical"
    - name: "detection_timestamp"
      expr: detection_timestamp
      comment: "Timestamp when defect was detected"
  measures:
    - name: "defect_count"
      expr: COUNT(1)
      comment: "Number of defect records"
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM for defects"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value associated with defects"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`packaging_material_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory and cost metrics for material lots"
  source: "`semiconductors_ecm`.`packaging`.`material_lot`"
  dimensions:
    - name: "material_lot_id"
      expr: material_lot_id
      comment: "Primary key of the material lot"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the material"
    - name: "material_type"
      expr: material_type
      comment: "Type of material"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition for the material"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates if material is quarantined"
    - name: "received_timestamp"
      expr: received_timestamp
      comment: "Timestamp when material was received"
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of material received"
    - name: "avg_cost_per_unit_usd"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit in USD"
    - name: "material_lot_count"
      expr: COUNT(1)
      comment: "Number of material lots"
$$;