-- Metric views for domain: maintenance | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core maintenance work order execution and cost performance metrics"
  source: "`mining_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (preventive, corrective, breakdown, project)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "priority"
      expr: priority
      comment: "Work order priority level"
    - name: "cost_centre"
      expr: cost_centre
      comment: "Cost centre responsible for the work"
    - name: "trade_craft_required"
      expr: trade_craft_required
      comment: "Trade or craft skill required for execution"
    - name: "shutdown_flag"
      expr: shutdown_flag
      comment: "Whether work requires equipment shutdown"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when work was planned to start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when work actually started"
    - name: "completion_code"
      expr: completion_code
      comment: "Code indicating how work was completed"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all work orders"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (actual minus estimated)"
    - name: "avg_cost_variance_pct"
      expr: ROUND(100.0 * AVG(CAST(cost_variance AS DOUBLE) / NULLIF(CAST(total_estimated_cost AS DOUBLE), 0)), 2)
      comment: "Average cost variance as percentage of estimated cost"
    - name: "total_labour_hours"
      expr: SUM(CAST(actual_labour_hours AS DOUBLE))
      comment: "Total actual labour hours consumed"
    - name: "total_estimated_labour_hours"
      expr: SUM(CAST(estimated_labour_hours AS DOUBLE))
      comment: "Total estimated labour hours planned"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance work"
    - name: "avg_downtime_per_order"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labour cost component"
    - name: "total_parts_materials_cost"
      expr: SUM(CAST(parts_materials_cost AS DOUBLE))
      comment: "Total parts and materials cost component"
    - name: "total_contractor_cost"
      expr: SUM(CAST(contractor_cost AS DOUBLE))
      comment: "Total contractor cost component"
    - name: "schedule_adherence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_finish_timestamp <= planned_finish_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders completed on or before planned finish date"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_equipment_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment availability and downtime event performance metrics"
  source: "`mining_ecm`.`maintenance`.`equipment_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event (planned, unplanned, breakdown)"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category classification of downtime"
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event"
    - name: "primary_failure_code"
      expr: primary_failure_code
      comment: "Primary failure code for root cause classification"
    - name: "cause_code"
      expr: cause_code
      comment: "Cause code for the downtime event"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the downtime event"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for resolving the downtime"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether downtime was associated with a safety incident"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether downtime had environmental impact"
    - name: "downtime_start_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month when downtime event started"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total equipment downtime hours across all events"
    - name: "avg_downtime_per_event"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime duration per event in hours"
    - name: "total_production_impact_tonnes"
      expr: SUM(CAST(production_impact_tonnes AS DOUBLE))
      comment: "Total production loss in tonnes due to downtime"
    - name: "avg_production_impact_per_event"
      expr: AVG(CAST(production_impact_tonnes AS DOUBLE))
      comment: "Average production loss per downtime event in tonnes"
    - name: "total_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost for all downtime events"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost"
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average response time from event detection to action start"
    - name: "avg_repair_time_minutes"
      expr: AVG(CAST(repair_time_minutes AS DOUBLE))
      comment: "Average time to complete repair in minutes"
    - name: "mttr_hours"
      expr: ROUND(AVG(CAST(repair_time_minutes AS DOUBLE)) / 60.0, 2)
      comment: "Mean Time To Repair in hours"
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events associated with safety incidents"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule compliance and effectiveness metrics"
  source: "`mining_ecm`.`maintenance`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule"
    - name: "frequency_type"
      expr: frequency_type
      comment: "Type of maintenance frequency (time-based, usage-based, condition-based)"
    - name: "interval_unit"
      expr: interval_unit
      comment: "Unit of measurement for maintenance interval"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the PM schedule"
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Whether PM is for safety-critical equipment"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether PM is required for environmental compliance"
    - name: "shutdown_required_flag"
      expr: shutdown_required_flag
      comment: "Whether PM requires equipment shutdown"
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month when next PM is due"
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all PM schedules"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration for all PM activities"
    - name: "avg_estimated_cost_per_pm"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per PM schedule"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM activity"
    - name: "avg_interval_value"
      expr: AVG(CAST(interval_value AS DOUBLE))
      comment: "Average maintenance interval value"
    - name: "avg_compliance_target_pct"
      expr: AVG(CAST(compliance_target_percentage AS DOUBLE))
      comment: "Average compliance target percentage across PM schedules"
    - name: "safety_critical_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PM schedules that are safety-critical"
    - name: "shutdown_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shutdown_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PM schedules requiring equipment shutdown"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_parts_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts consumption and inventory utilization metrics"
  source: "`mining_ecm`.`maintenance`.`parts_consumption`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of parts transaction (issue, return, transfer)"
    - name: "store_location_code"
      expr: store_location_code
      comment: "Store location where parts were issued from"
    - name: "cost_centre_code"
      expr: cost_centre_code
      comment: "Cost centre charged for parts consumption"
    - name: "opex_category"
      expr: opex_category
      comment: "Operating expense category for the parts"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether parts consumption is covered by warranty claim"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal transaction"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when parts were issued"
  measures:
    - name: "total_parts_transactions"
      expr: COUNT(1)
      comment: "Total number of parts consumption transactions"
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of parts issued"
    - name: "total_parts_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of parts consumed"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per part"
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average value per parts transaction"
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts consumption covered by warranty"
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are reversals"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment failure analysis and reliability improvement metrics"
  source: "`mining_ecm`.`maintenance`.`failure_report`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure observed"
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure"
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure"
    - name: "event_classification"
      expr: event_classification
      comment: "Classification of the failure event"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which failure was detected"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the failure report"
    - name: "rca_performed_flag"
      expr: rca_performed_flag
      comment: "Whether root cause analysis was performed"
    - name: "repeat_failure_flag"
      expr: repeat_failure_flag
      comment: "Whether this is a repeat failure"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether failure resulted in safety incident"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_timestamp)
      comment: "Month when failure occurred"
  measures:
    - name: "total_failure_reports"
      expr: COUNT(1)
      comment: "Total number of failure reports"
    - name: "total_failure_cost"
      expr: SUM(CAST(failure_cost AS DOUBLE))
      comment: "Total cost of all failures"
    - name: "avg_failure_cost"
      expr: AVG(CAST(failure_cost AS DOUBLE))
      comment: "Average cost per failure event"
    - name: "total_production_loss_tonnes"
      expr: SUM(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Total production loss due to failures in tonnes"
    - name: "avg_production_loss_per_failure"
      expr: AVG(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Average production loss per failure event"
    - name: "total_estimated_mtbf_gain_hours"
      expr: SUM(CAST(estimated_mtbf_gain_hours AS DOUBLE))
      comment: "Total estimated MTBF improvement from corrective actions"
    - name: "rca_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rca_performed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures with completed root cause analysis"
    - name: "repeat_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_failure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures that are repeat occurrences"
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures resulting in safety incidents"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_shutdown_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major maintenance shutdown execution and performance metrics"
  source: "`mining_ecm`.`maintenance`.`shutdown_plan`"
  dimensions:
    - name: "shutdown_type"
      expr: shutdown_type
      comment: "Type of shutdown (planned, emergency, regulatory)"
    - name: "shutdown_status"
      expr: shutdown_status
      comment: "Current status of the shutdown"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the shutdown plan"
    - name: "contractor_involvement_flag"
      expr: contractor_involvement_flag
      comment: "Whether contractors are involved in the shutdown"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when shutdown is planned to start"
  measures:
    - name: "total_shutdowns"
      expr: COUNT(1)
      comment: "Total number of shutdown events"
    - name: "total_planned_cost"
      expr: SUM(CAST(total_planned_cost AS DOUBLE))
      comment: "Total planned cost for all shutdowns"
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for all shutdowns"
    - name: "total_capex_amount"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure during shutdowns"
    - name: "total_opex_amount"
      expr: SUM(CAST(opex_amount AS DOUBLE))
      comment: "Total operating expenditure during shutdowns"
    - name: "total_planned_duration_hours"
      expr: SUM(CAST(planned_duration_hours AS DOUBLE))
      comment: "Total planned duration for all shutdowns"
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual duration for all shutdowns"
    - name: "avg_cost_variance_pct"
      expr: ROUND(100.0 * AVG((CAST(total_actual_cost AS DOUBLE) - CAST(total_planned_cost AS DOUBLE)) / NULLIF(CAST(total_planned_cost AS DOUBLE), 0)), 2)
      comment: "Average cost variance as percentage of planned cost"
    - name: "avg_duration_variance_pct"
      expr: ROUND(100.0 * AVG((CAST(actual_duration_hours AS DOUBLE) - CAST(planned_duration_hours AS DOUBLE)) / NULLIF(CAST(planned_duration_hours AS DOUBLE), 0)), 2)
      comment: "Average duration variance as percentage of planned duration"
    - name: "total_production_loss_tonnes"
      expr: SUM(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Total production loss during shutdowns in tonnes"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all shutdowns"
    - name: "total_planned_labour_hours"
      expr: SUM(CAST(total_planned_labour_hours AS DOUBLE))
      comment: "Total planned labour hours for all shutdowns"
    - name: "total_actual_labour_hours"
      expr: SUM(CAST(total_actual_labour_hours AS DOUBLE))
      comment: "Total actual labour hours consumed in shutdowns"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_labour_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance labour productivity and cost metrics"
  source: "`mining_ecm`.`maintenance`.`labour_record`"
  dimensions:
    - name: "trade_craft"
      expr: trade_craft
      comment: "Trade or craft of the worker"
    - name: "cost_centre"
      expr: cost_centre
      comment: "Cost centre charged for labour"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which work was performed"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the labour record"
    - name: "source_type"
      expr: source_type
      comment: "Source type of labour (internal, contractor)"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month when work was performed"
  measures:
    - name: "total_labour_records"
      expr: COUNT(1)
      comment: "Total number of labour records"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked (regular plus overtime)"
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labour cost incurred"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across all labour records"
    - name: "avg_overtime_rate"
      expr: AVG(CAST(overtime_rate AS DOUBLE))
      comment: "Average overtime rate"
    - name: "overtime_percentage"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as percentage of total hours"
    - name: "avg_labour_cost_per_hour"
      expr: ROUND(SUM(CAST(labour_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Average labour cost per hour worked"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory management and criticality metrics"
  source: "`mining_ecm`.`maintenance`.`spare_part`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "Category classification of the spare part"
    - name: "part_type"
      expr: part_type
      comment: "Type of spare part"
    - name: "part_status"
      expr: part_status
      comment: "Current status of the spare part"
    - name: "criticality_classification"
      expr: criticality_classification
      comment: "Criticality classification (A/B/C or critical/non-critical)"
    - name: "obsolescence_status"
      expr: obsolescence_status
      comment: "Obsolescence status of the part"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether part is classified as hazardous material"
    - name: "serial_number_tracking_flag"
      expr: serial_number_tracking_flag
      comment: "Whether part requires serial number tracking"
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of unique spare parts in catalog"
    - name: "total_inventory_value"
      expr: SUM(CAST(standard_unit_cost AS DOUBLE) * CAST(minimum_stock_level AS DOUBLE))
      comment: "Total inventory value at minimum stock levels"
    - name: "avg_unit_cost"
      expr: AVG(CAST(standard_unit_cost AS DOUBLE))
      comment: "Average standard unit cost per part"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for parts procurement"
    - name: "avg_minimum_stock_level"
      expr: AVG(CAST(minimum_stock_level AS DOUBLE))
      comment: "Average minimum stock level across all parts"
    - name: "avg_maximum_stock_level"
      expr: AVG(CAST(maximum_stock_level AS DOUBLE))
      comment: "Average maximum stock level across all parts"
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity"
    - name: "avg_economic_order_quantity"
      expr: AVG(CAST(economic_order_quantity AS DOUBLE))
      comment: "Average economic order quantity"
    - name: "hazardous_parts_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts classified as hazardous materials"
$$;