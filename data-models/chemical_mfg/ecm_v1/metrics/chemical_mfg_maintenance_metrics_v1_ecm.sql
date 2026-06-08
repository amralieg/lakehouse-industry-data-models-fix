-- Metric views for domain: maintenance | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core maintenance execution KPIs derived from work orders"
  source: "`chemical_mfg_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment associated with the work order"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order"
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center responsible for the work order"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month in which the work order was scheduled"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders created"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Aggregate downtime hours across all work orders"
    - name: "average_downtime_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime per work order"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Sum of actual labor cost for all work orders"
    - name: "average_actual_labor_cost"
      expr: AVG(CAST(actual_labor_cost AS DOUBLE))
      comment: "Average actual labor cost per work order"
    - name: "high_priority_work_orders"
      expr: SUM(CASE WHEN priority = 'High' THEN 1 ELSE 0 END)
      comment: "Count of work orders marked as high priority"
    - name: "completed_on_time_work_orders"
      expr: SUM(CASE WHEN actual_end_timestamp <= scheduled_end_date THEN 1 ELSE 0 END)
      comment: "Count of work orders finished on or before the scheduled end date"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_breakdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs that measure equipment reliability and production impact"
  source: "`chemical_mfg_ecm`.`maintenance`.`breakdown_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the breakdown occurred"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment involved in the breakdown"
    - name: "breakdown_status"
      expr: breakdown_status
      comment: "Current status of the breakdown event"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code assigned to the breakdown"
    - name: "breakdown_month"
      expr: DATE_TRUNC('month', breakdown_start_timestamp)
      comment: "Month of breakdown start"
  measures:
    - name: "total_breakdowns"
      expr: COUNT(1)
      comment: "Total number of breakdown events recorded"
    - name: "total_breakdown_duration_hours"
      expr: SUM(CAST(breakdown_duration_hours AS DOUBLE))
      comment: "Cumulative duration of all breakdowns"
    - name: "average_breakdown_duration_hours"
      expr: AVG(CAST(breakdown_duration_hours AS DOUBLE))
      comment: "Average duration per breakdown event"
    - name: "safety_incident_breakdowns"
      expr: SUM(CASE WHEN safety_incident_flag THEN 1 ELSE 0 END)
      comment: "Breakdowns that involved a safety incident"
    - name: "critical_breakdowns"
      expr: SUM(CASE WHEN psm_critical_flag THEN 1 ELSE 0 END)
      comment: "Breakdowns flagged as PSM critical"
    - name: "total_production_loss_quantity"
      expr: SUM(CAST(production_loss_quantity AS DOUBLE))
      comment: "Total quantity of production loss due to breakdowns"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_asset_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic change management KPIs for asset modifications"
  source: "`chemical_mfg_ecm`.`maintenance`.`asset_change_request`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the change request originated"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment targeted by the change request"
    - name: "functional_location_id"
      expr: functional_location_id
      comment: "Functional location of the asset"
    - name: "change_type"
      expr: change_type
      comment: "Type/category of the change request"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request"
    - name: "request_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the request was created"
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of asset change requests submitted"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs for all change requests"
    - name: "average_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per change request"
    - name: "approved_requests"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of change requests that received approval"
    - name: "high_priority_requests"
      expr: SUM(CASE WHEN priority_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of change requests marked as high priority"
    - name: "moc_required_requests"
      expr: SUM(CASE WHEN moc_status IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of requests that required a Management of Change"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and cost effectiveness of equipment calibration activities"
  source: "`chemical_mfg_ecm`.`maintenance`.`calibration_record`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where calibration was performed"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment calibrated"
    - name: "calibration_month"
      expr: DATE_TRUNC('month', calibration_date)
      comment: "Month of calibration activity"
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor that performed the calibration"
  measures:
    - name: "total_calibrations"
      expr: COUNT(1)
      comment: "Total number of calibration records performed"
    - name: "total_calibration_cost"
      expr: SUM(CAST(calibration_cost AS DOUBLE))
      comment: "Aggregate cost of all calibrations"
    - name: "average_calibration_cost"
      expr: AVG(CAST(calibration_cost AS DOUBLE))
      comment: "Average cost per calibration activity"
    - name: "out_of_tolerance_count"
      expr: SUM(CASE WHEN out_of_tolerance_flag THEN 1 ELSE 0 END)
      comment: "Number of calibrations that were out of tolerance"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of calibrations that passed"
$$;