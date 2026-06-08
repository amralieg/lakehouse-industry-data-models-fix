-- Metric views for domain: project | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`project_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key activity performance and cost metrics"
  source: "`manufacturing_ecm`.`project`.`activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity (e.g., construction, inspection)"
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the activity"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost values"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating if activity is on the critical path"
    - name: "activity_month"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month of activity start"
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Count of activity records"
    - name: "sum_total_cost_estimated"
      expr: SUM(CAST(total_cost_estimated AS DOUBLE))
      comment: "Total estimated cost for activities"
    - name: "sum_actual_cost"
      expr: SUM(CAST(equipment_cost_actual + material_cost_actual AS DOUBLE))
      comment: "Sum of actual equipment and material costs per activity"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across activities"
    - name: "sum_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total duration hours for activities"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`project_earned_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value management KPIs"
  source: "`manufacturing_ecm`.`project`.`earned_value_record`"
  dimensions:
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Work breakdown structure element identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the values"
    - name: "is_forecast"
      expr: is_forecast
      comment: "Indicates if the record is a forecast"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of reporting date"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of earned value records"
    - name: "sum_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost captured in earned value records"
    - name: "sum_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value (EV)"
    - name: "sum_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (PV)"
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average Cost Performance Index (CPI)"
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI)"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget vs. actual financial health of projects"
  source: "`manufacturing_ecm`.`project`.`project_budget`"
  dimensions:
    - name: "project_header_id"
      expr: project_header_id
      comment: "Identifier of the project header"
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element linked to the budget"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget (e.g., CAPEX, OPEX)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of budget amounts"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "budget_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the budget became effective"
  measures:
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of budget records"
    - name: "total_original_budget_amount"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of original budgeted amounts"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Sum of committed amounts"
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Sum of actual spent amounts"
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Sum of remaining budget amounts"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone delivery and cost performance"
  source: "`manufacturing_ecm`.`project`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., design, construction)"
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating critical milestones"
    - name: "planned_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned month for the milestone"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Count of milestone records"
    - name: "sum_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost for milestones"
    - name: "sum_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for milestones"
    - name: "completed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of milestones marked as Completed"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`project_progress_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated progress reporting KPIs"
  source: "`manufacturing_ecm`.`project`.`progress_report`"
  dimensions:
    - name: "report_month"
      expr: DATE_TRUNC('month', report_date)
      comment: "Month of the progress report"
    - name: "project_header_id"
      expr: project_header_id
      comment: "Project header identifier"
    - name: "overall_status"
      expr: overall_status
      comment: "Overall status descriptor from the report"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the report highlights critical issues"
  measures:
    - name: "report_count"
      expr: COUNT(1)
      comment: "Number of progress reports submitted"
    - name: "sum_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost reported"
    - name: "sum_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost reported"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across reports"
    - name: "avg_cost_variance_amount"
      expr: AVG(CAST(cost_variance_amount AS DOUBLE))
      comment: "Average cost variance amount per report"
$$;