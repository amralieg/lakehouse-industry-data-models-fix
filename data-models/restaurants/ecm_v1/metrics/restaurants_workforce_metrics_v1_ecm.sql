-- Metric views for domain: workforce | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics for headcount, compensation, and labor allocation."
  source: "`restaurants_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Unique employee identifier"
    - name: "department"
      expr: department
      comment: "Department name"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full‑time, part‑time, etc.)"
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired"
    - name: "union_member"
      expr: union_member
      comment: "Union membership flag"
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "ServSafe certification status"
  measures:
    - name: "employee_count"
      expr: COUNT(1)
      comment: "Number of employee records"
    - name: "total_salary_amount"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total salary amount across all employees"
    - name: "average_salary_amount"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary amount per employee"
    - name: "average_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target across employees"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budgeting metrics to track FTE and cost allocations."
  source: "`restaurants_ecm`.`workforce`.`labor_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., Q1, Q2)"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operational, capital)"
    - name: "scenario"
      expr: scenario
      comment: "Budget scenario (e.g., baseline, optimistic)"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of labor budget records"
    - name: "total_fte_budget_total"
      expr: SUM(CAST(fte_budget_total AS DOUBLE))
      comment: "Total full‑time equivalent budget across all units"
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total estimated labor cost"
    - name: "total_hours_budget_total"
      expr: SUM(CAST(hours_budget_total AS DOUBLE))
      comment: "Total hours budgeted"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_labor_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecasted labor metrics for planning staffing and cost."
  source: "`restaurants_ecm`.`workforce`.`labor_forecast`"
  dimensions:
    - name: "year"
      expr: year
      comment: "Forecast year"
    - name: "week_number"
      expr: week_number
      comment: "Week number within the forecast year"
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario (e.g., base, promotion)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart (e.g., breakfast, lunch, dinner)"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date the forecast was generated"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of labor forecast records"
    - name: "total_projected_fte_boh"
      expr: SUM(CAST(projected_fte_boh AS DOUBLE))
      comment: "Total projected back‑of‑house FTE"
    - name: "total_projected_fte_foh"
      expr: SUM(CAST(projected_fte_foh AS DOUBLE))
      comment: "Total projected front‑of‑house FTE"
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total projected labor cost"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_labor_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor compliance violation metrics for risk and cost monitoring."
  source: "`restaurants_ecm`.`workforce`.`labor_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of labor violation"
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when violation occurred"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the violation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the violation"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
    - name: "violation_timestamp"
      expr: violation_timestamp
      comment: "Timestamp of the violation event"
  measures:
    - name: "violation_count"
      expr: COUNT(1)
      comment: "Number of labor violations recorded"
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fine amount assessed for violations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for violations"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run financial metrics for cost and payout analysis."
  source: "`restaurants_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payroll run"
    - name: "pay_cycle"
      expr: pay_cycle
      comment: "Pay cycle (e.g., weekly, bi‑weekly)"
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll (e.g., regular, bonus)"
    - name: "status"
      expr: status
      comment: "Current status of the payroll run"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
  measures:
    - name: "run_record_count"
      expr: COUNT(1)
      comment: "Number of payroll run records"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll amount after deductions"
    - name: "total_deductions_amount"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total payroll deductions"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time entry metrics for labor tracking and cost analysis."
  source: "`restaurants_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of the work entry"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier"
    - name: "shift_id"
      expr: shift_id
      comment: "Shift identifier"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (e.g., regular, break)"
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Status of the time entry"
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier"
  measures:
    - name: "time_entry_count"
      expr: COUNT(1)
      comment: "Number of time entry records"
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours recorded"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost associated with time entries"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review metrics to assess employee effectiveness and labor efficiency."
  source: "`restaurants_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_date"
      expr: review_date
      comment: "Timestamp of the performance review"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier"
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., annual, probation)"
    - name: "review_period_start"
      expr: review_period_start
      comment: "Start date of the review period"
    - name: "review_period_end"
      expr: review_period_end
      comment: "End date of the review period"
  measures:
    - name: "review_record_count"
      expr: COUNT(1)
      comment: "Number of performance review records"
    - name: "average_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall rating across reviews"
    - name: "average_labor_percentage_actual"
      expr: AVG(CAST(labor_percentage_actual AS DOUBLE))
      comment: "Average actual labor percentage"
    - name: "average_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average target labor percentage"
    - name: "average_attendance_score"
      expr: AVG(CAST(attendance_score AS DOUBLE))
      comment: "Average attendance score"
$$;