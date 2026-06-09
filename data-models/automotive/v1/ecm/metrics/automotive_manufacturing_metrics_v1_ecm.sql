-- Metric views for domain: manufacturing | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_agv_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for Automated Guided Vehicle (AGV) movements."
  source: "`automotive_ecm`.`manufacturing`.`agv_movement`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant where the AGV operated."
    - name: "shift_id"
      expr: shift_id
      comment: "Shift during which the movement occurred."
    - name: "agv_controller_code"
      expr: agv_controller_code
      comment: "Controller identifier for the AGV."
    - name: "movement_type"
      expr: movement_type
      comment: "Type of movement (e.g., transport, idle)."
    - name: "movement_date"
      expr: DATE_TRUNC('day', movement_start_timestamp)
      comment: "Date of the movement."
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of AGV movements."
    - name: "avg_speed_mps"
      expr: AVG(CAST(average_speed_mps AS DOUBLE))
      comment: "Average speed of AGVs in meters per second."
    - name: "total_distance_m"
      expr: SUM(CAST(distance_travelled_m AS DOUBLE))
      comment: "Total distance traveled by AGVs in meters."
    - name: "fault_count"
      expr: SUM(CASE WHEN fault_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of movements that reported a fault."
    - name: "manual_override_count"
      expr: SUM(CASE WHEN is_manual_override THEN 1 ELSE 0 END)
      comment: "Count of movements where manual override was used."
    - name: "route_deviation_count"
      expr: SUM(CASE WHEN route_deviation_flag THEN 1 ELSE 0 END)
      comment: "Count of movements that deviated from the planned route."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order performance and efficiency metrics."
  source: "`automotive_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the order is executed."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line handling the order."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle being built."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order."
    - name: "order_date_day"
      expr: DATE_TRUNC('day', order_date)
      comment: "Date the order was created."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of production orders."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual cost incurred for production orders."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total target production quantity across orders."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed quantity produced."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped during production."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity reworked."
    - name: "late_delivery_count"
      expr: SUM(CASE WHEN actual_finish_timestamp > CAST(planned_finish_date AS TIMESTAMP) THEN 1 ELSE 0 END)
      comment: "Number of orders finished later than the planned finish date."
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per order."
    - name: "avg_actual_machine_hours"
      expr: AVG(CAST(actual_machine_hours AS DOUBLE))
      comment: "Average actual machine hours per order."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime events impacting production availability."
  source: "`automotive_ecm`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the downtime occurred."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center affected by the downtime."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which the downtime was recorded."
    - name: "event_date_day"
      expr: DATE_TRUNC('day', event_date)
      comment: "Date of the downtime event."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category classification of the downtime."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events recorded."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Cumulative downtime minutes across events."
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event."
    - name: "quality_hold_triggered_count"
      expr: SUM(CASE WHEN is_quality_hold_triggered THEN 1 ELSE 0 END)
      comment: "Count of downtime events that triggered a quality hold."
    - name: "safety_related_count"
      expr: SUM(CASE WHEN is_safety_related THEN 1 ELSE 0 END)
      comment: "Count of downtime events related to safety issues."
$$;