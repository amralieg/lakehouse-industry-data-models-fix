-- Metric views for domain: schedule | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and resource utilization metrics for schedule activities."
  source: "`construction_ecm`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource (e.g., labor, equipment)."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the resource within the activity."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category classification."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating if the assignment is on the critical path."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred by resource assignments."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost for resource assignments."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity of resources used."
    - name: "average_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per unit of resource."
    - name: "total_overtime_cost"
      expr: SUM(overtime_quantity * overtime_rate)
      comment: "Total overtime cost (quantity multiplied by rate)."
    - name: "average_overtime_rate"
      expr: AVG(CAST(overtime_rate AS DOUBLE))
      comment: "Average overtime rate per hour."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value and schedule performance metrics per reporting period."
  source: "`construction_ecm`.`schedule`.`progress_update`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Identifier of the construction project."
    - name: "reporting_date"
      expr: reporting_date
      comment: "Date of the reporting period."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting (e.g., weekly, monthly)."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Flag indicating if critical path changed in this period."
  measures:
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled."
    - name: "average_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index."
    - name: "average_sv"
      expr: AVG(CAST(sv AS DOUBLE))
      comment: "Average Schedule Variance (cost)."
    - name: "total_percent_complete_units"
      expr: SUM(CAST(percent_complete_units AS DOUBLE))
      comment: "Sum of percent complete expressed in units."
    - name: "total_percent_complete_duration"
      expr: SUM(CAST(percent_complete_duration AS DOUBLE))
      comment: "Sum of percent complete expressed in duration."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline financial and schedule snapshot metrics."
  source: "`construction_ecm`.`schedule`.`schedule_baseline`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (e.g., initial, revised)."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating if this baseline is the current active baseline."
    - name: "schedule_baseline_status"
      expr: schedule_baseline_status
      comment: "Status of the baseline (e.g., approved, draft)."
  measures:
    - name: "total_bcws_amount"
      expr: SUM(CAST(bcws_amount AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled amount for the baseline."
    - name: "baseline_count"
      expr: COUNT(1)
      comment: "Number of baseline records."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and occurrence metrics for schedule delay events."
  source: "`construction_ecm`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of the delay (e.g., weather, labor)."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Whether the delay impacts the critical path."
    - name: "source_system"
      expr: source_system
      comment: "Originating source system of the delay record."
  measures:
    - name: "total_impact_cost"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total cost impact of delay events."
    - name: "delay_event_count"
      expr: COUNT(1)
      comment: "Number of delay events recorded."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment metrics for schedule risks."
  source: "`construction_ecm`.`schedule`.`schedule_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the schedule risk."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., open, closed)."
    - name: "owner_department"
      expr: owner_department
      comment: "Department owning the risk."
    - name: "priority"
      expr: priority
      comment: "Priority level of the risk."
  measures:
    - name: "average_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average risk score across all schedule risks."
    - name: "risk_count"
      expr: COUNT(1)
      comment: "Total number of schedule risk records."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planning and readiness metrics for lookahead schedules."
  source: "`construction_ecm`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the lookahead plan."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Flag indicating if the plan includes critical path activities."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the lookahead plan."
    - name: "end_date"
      expr: end_date
      comment: "End date of the lookahead plan."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost for the lookahead plan."
    - name: "average_percent_plan_complete"
      expr: AVG(CAST(percent_plan_complete AS DOUBLE))
      comment: "Average percentage of plan completion."
    - name: "lookahead_plan_count"
      expr: COUNT(1)
      comment: "Number of lookahead plan records."
$$;