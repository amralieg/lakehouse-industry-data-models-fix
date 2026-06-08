-- Metric views for domain: workforce | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key absence metrics to monitor workforce availability and productivity impact."
  source: "`automotive_ecm`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_category"
      expr: absence_category
      comment: "Category of absence (e.g., sick, vacation)"
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (e.g., paid, unpaid)"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year of absence start"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month bucket of absence start"
  measures:
    - name: "total_absences"
      expr: COUNT(1)
      comment: "Total number of absence records"
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Sum of absence duration in days"
    - name: "average_absence_duration"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average absence duration in days"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`workforce_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll financials and headcount for cost management and budgeting."
  source: "`automotive_ecm`.`workforce`.`payroll_result`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier"
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with payroll"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code"
    - name: "pay_period_year"
      expr: YEAR(pay_period_start_date)
      comment: "Year of payroll period"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay paid"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay paid"
    - name: "average_gross_pay"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record"
    - name: "payroll_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees paid in period"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident counts to drive risk mitigation and compliance."
  source: "`automotive_ecm`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category
      comment: "Category of safety incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where incident occurred"
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Year of incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Month of incident"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of safety incidents"
    - name: "lost_time_incident_count"
      expr: SUM(CASE WHEN lost_time_indicator THEN 1 ELSE 0 END)
      comment: "Count of incidents resulting in lost time"
    - name: "recordable_incident_count"
      expr: SUM(CASE WHEN osha_recordable_flag THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable incidents"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning metrics for workforce capacity and budgeting."
  source: "`automotive_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "headcount_category"
      expr: headcount_category
      comment: "Category of headcount (e.g., production, admin)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan"
  measures:
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated for headcount"
    - name: "avg_attrition_rate"
      expr: AVG(CAST(attrition_rate AS DOUBLE))
      comment: "Average attrition rate across plans"
    - name: "avg_capacity_factor"
      expr: AVG(CAST(capacity_factor AS DOUBLE))
      comment: "Average capacity factor across plans"
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Number of headcount plans"
$$;