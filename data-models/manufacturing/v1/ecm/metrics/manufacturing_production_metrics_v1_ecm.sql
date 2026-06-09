-- Metric views for domain: production | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core work order performance metrics"
  source: "`manufacturing_ecm`.`production`.`production_work_order`"
  dimensions:
    - name: "shift_id"
      expr: shift_id
      comment: "Shift during which the order ran"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type/category of the work order"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code assigned to the work order"
  measures:
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Number of production work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred by work orders"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced"
    - name: "average_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time per work order (minutes)"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift‑level production efficiency and quality metrics"
  source: "`manufacturing_ecm`.`production`.`shift_report`"
  dimensions:
    - name: "shift_id"
      expr: shift_id
      comment: "Shift identifier"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center associated with the shift"
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU being produced"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift"
  measures:
    - name: "shift_report_count"
      expr: COUNT(1)
      comment: "Number of shift reports"
    - name: "total_good_quantity"
      expr: SUM(CAST(actual_good_quantity AS DOUBLE))
      comment: "Total good quantity produced in the shift"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity recorded in the shift"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes in the shift"
    - name: "average_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage for the shift"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime event impact and repair efficiency metrics"
  source: "`manufacturing_ecm`.`production`.`production_downtime_event`"
  dimensions:
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center where downtime occurred"
    - name: "shift_id"
      expr: shift_id
      comment: "Shift during which downtime was recorded"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g., mechanical, electrical)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the downtime event"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime (planned, unplanned)"
  measures:
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Number of downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total minutes of downtime"
    - name: "total_impact_on_oee"
      expr: SUM(CAST(impact_on_oee AS DOUBLE))
      comment: "Cumulative OEE impact from downtime"
    - name: "average_mttr_minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Mean time to repair (minutes)"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt volume and cost metrics"
  source: "`manufacturing_ecm`.`production`.`production_goods_receipt`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the received goods"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier"
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU of the received goods"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of receipt"
  measures:
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipt records"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM consumption cost and volume metrics"
  source: "`manufacturing_ecm`.`production`.`bom_consumption`"
  dimensions:
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center code where consumption occurred"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material being consumed"
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU associated with consumption"
    - name: "batch_number"
      expr: batch_number
      comment: "Batch number of the consumption event"
  measures:
    - name: "bom_consumption_count"
      expr: COUNT(1)
      comment: "Number of BOM consumption records"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity consumed"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of consumption"
$$;