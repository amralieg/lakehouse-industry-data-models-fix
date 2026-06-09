-- Metric views for domain: workforce | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount and tenure metrics"
  source: "`genomics_biotech_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g., Active, Terminated)"
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employees"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_employee_tenure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average tenure to monitor retention"
  source: "`genomics_biotech_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department_name"
      expr: department_name
      comment: "Department of the employee"
  measures:
    - name: "average_tenure_years"
      expr: AVG(DATEDIFF(current_date, hire_date) / 365.0)
      comment: "Average employee tenure in years"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence utilization metrics"
  source: "`genomics_biotech_ecm`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_reason"
      expr: absence_reason
      comment: "Reason for the absence"
  measures:
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total days of absence recorded"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_absence_paid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Paid vs unpaid absence analysis"
  source: "`genomics_biotech_ecm`.`workforce`.`absence_record`"
  dimensions:
    - name: "paid_flag"
      expr: paid_flag
      comment: "Indicates if the absence was paid"
  measures:
    - name: "total_paid_absence_days"
      expr: SUM(CASE WHEN paid_flag THEN duration_days ELSE 0 END)
      comment: "Total paid absence days"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation cost metrics"
  source: "`genomics_biotech_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., Full-time, Contractor)"
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Sum of base salary amounts"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_compensation_variable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Variable compensation analysis"
  source: "`genomics_biotech_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code"
  measures:
    - name: "total_variable_pay"
      expr: SUM(CAST(variable_pay_amount AS DOUBLE))
      comment: "Sum of variable pay amounts"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_compensation_average`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average compensation for budgeting"
  source: "`genomics_biotech_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation"
  measures:
    - name: "average_total_compensation"
      expr: AVG(base_salary_amount + variable_pay_amount)
      comment: "Average total compensation per employee"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning vs actual"
  source: "`genomics_biotech_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
  measures:
    - name: "total_planned_headcount"
      expr: SUM(CAST(planned_headcount AS DOUBLE))
      comment: "Planned headcount for the period"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_headcount_approved`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved headcount tracking"
  source: "`genomics_biotech_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan"
  measures:
    - name: "total_approved_headcount"
      expr: SUM(CAST(approved_headcount AS DOUBLE))
      comment: "Approved headcount"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review scoring"
  source: "`genomics_biotech_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review"
  measures:
    - name: "average_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall rating score"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_performance_goal_achievement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goal achievement effectiveness"
  source: "`genomics_biotech_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "high_potential_flag"
      expr: high_potential_flag
      comment: "Flag for high-potential employees"
  measures:
    - name: "average_goal_achievement_pct"
      expr: AVG(CAST(goal_achievement_percentage AS DOUBLE))
      comment: "Average percentage of goal achievement"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic goal performance"
  source: "`genomics_biotech_ecm`.`workforce`.`goal`"
  dimensions:
    - name: "goal_status"
      expr: goal_status
      comment: "Current status of the goal"
  measures:
    - name: "average_achievement_percentage"
      expr: AVG(CAST(achievement_percentage AS DOUBLE))
      comment: "Average achievement percentage across goals"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_goal_target_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Target value tracking"
  source: "`genomics_biotech_ecm`.`workforce`.`goal`"
  dimensions:
    - name: "strategic_pillar"
      expr: strategic_pillar
      comment: "Strategic pillar the goal aligns to"
  measures:
    - name: "average_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for goals"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll financial summary"
  source: "`genomics_biotech_ecm`.`workforce`.`payroll_result`"
  dimensions:
    - name: "payroll_run_id"
      expr: payroll_run_id
      comment: "Identifier of the payroll run"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay for the payroll run"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_payroll_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hour aggregation"
  source: "`genomics_biotech_ecm`.`workforce`.`payroll_result`"
  dimensions:
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of payment"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`workforce_payroll_average_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average pay rate for analysis"
  source: "`genomics_biotech_ecm`.`workforce`.`payroll_result`"
  dimensions:
    - name: "payroll_frequency"
      expr: payroll_frequency
      comment: "Payroll frequency (e.g., Biweekly)"
  measures:
    - name: "average_hourly_rate"
      expr: AVG(gross_pay_amount / NULLIF(hours_worked, 0))
      comment: "Average hourly gross pay rate"
$$;