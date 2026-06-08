-- Metric views for domain: workforce | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor timesheet KPIs capturing total hours, billable hours and labor cost."
  source: "`construction_ecm`.`workforce`.`timesheet`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of the timesheet entry"
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code associated with the work"
    - name: "craft_worker_id"
      expr: craft_worker_id
      comment: "Identifier of the craft worker"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (e.g., day, night)"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during work"
  measures:
    - name: "timesheet_record_count"
      expr: COUNT(1)
      comment: "Number of timesheet records"
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours logged"
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable THEN total_hours ELSE 0 END)
      comment: "Sum of billable hours"
    - name: "overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost amount"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_production_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production rate and quantity KPIs for construction activities."
  source: "`construction_ecm`.`workforce`.`production_rate`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of production record"
    - name: "crew_id"
      expr: crew_id
      comment: "Crew identifier"
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code"
    - name: "activity_code"
      expr: activity_code
      comment: "Activity code"
    - name: "shift"
      expr: shift
      comment: "Shift during which work occurred"
  measures:
    - name: "production_record_count"
      expr: COUNT(1)
      comment: "Number of production records"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced"
    - name: "total_earned_hours"
      expr: SUM(CAST(earned_hours AS DOUBLE))
      comment: "Total earned hours"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Sum of quantity variance"
    - name: "total_variance_hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Sum of hours variance"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_crew_productivity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew-level productivity and cost metrics."
  source: "`construction_ecm`.`workforce`.`crew`"
  dimensions:
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g., trade, subcontract)"
    - name: "crew_status"
      expr: crew_status
      comment: "Current status of the crew"
    - name: "is_union_crew"
      expr: is_union_crew
      comment: "Whether the crew is unionized"
  measures:
    - name: "crew_count"
      expr: COUNT(1)
      comment: "Number of crew records"
    - name: "average_hourly_rate"
      expr: AVG(CAST(average_hourly_rate AS DOUBLE))
      comment: "Average hourly rate across crews"
    - name: "average_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_craft_worker_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount and compensation metrics for craft workers."
  source: "`construction_ecm`.`workforce`.`craft_worker`"
  dimensions:
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Skill trade identifier"
    - name: "craft_code"
      expr: craft_code
      comment: "Craft code"
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Union affiliation flag"
    - name: "supervisory_role_flag"
      expr: supervisory_role_flag
      comment: "Whether worker holds supervisory role"
  measures:
    - name: "craft_worker_count"
      expr: COUNT(1)
      comment: "Number of craft workers"
    - name: "average_hourly_base_rate"
      expr: AVG(CAST(hourly_base_rate AS DOUBLE))
      comment: "Average hourly base rate"
    - name: "average_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned vs actual labor hours and headcount tracking."
  source: "`construction_ecm`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the staffing plan"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan (e.g., ramp-up, ramp-down)"
    - name: "skill_trade_id"
      expr: skill_trade_id
      comment: "Skill trade associated with the plan"
  measures:
    - name: "staffing_plan_record_count"
      expr: COUNT(1)
      comment: "Number of staffing plan records"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours"
    - name: "total_labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Sum of labor hours variance"
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours"
$$;