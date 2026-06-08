-- Metric views for domain: product | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_order_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule performance and safety metrics"
  source: "`chemical_mfg_ecm`.`product`.`order_delivery_schedule`"
  dimensions:
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Identifier of the chemical product being scheduled"
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Condition under which the product is shipped"
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation (e.g., truck, rail)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the delivery schedule"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled delivery"
  measures:
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery"
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity originally scheduled"
    - name: "hazardous_delivery_count"
      expr: SUM(CASE WHEN hazardous_material_flag THEN 1 ELSE 0 END)
      comment: "Count of delivery schedules flagged as hazardous"
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of delivery schedule records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation volume metrics for production planning"
  source: "`chemical_mfg_ecm`.`product`.`allocation`"
  dimensions:
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier linked to allocation"
    - name: "po_line_id"
      expr: po_line_id
      comment: "Purchase order line identifier"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of the scheduled delivery"
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated across line items"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of allocation records"
$$;