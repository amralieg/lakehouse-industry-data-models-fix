-- Metric views for domain: people | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`people_employee_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee headcount and average tenure metrics."
  source: "`telecommunication_ecm`.`people`.`employee`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier."
    - name: "location_site_id"
      expr: location_site_id
      comment: "Location site identifier."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., full-time, contractor)."
    - name: "gender"
      expr: gender
      comment: "Gender of employee."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employees."
    - name: "average_tenure_years"
      expr: AVG(DATEDIFF(current_date, hire_date) / 365.0)
      comment: "Average tenure in years."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`people_assignment_fte`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Full-time equivalent (FTE) allocation per assignment."
  source: "`telecommunication_ecm`.`people`.`assignment`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier."
    - name: "location_site_id"
      expr: location_site_id
      comment: "Location site identifier."
    - name: "job_family"
      expr: job_family
      comment: "Job family of the assignment."
    - name: "job_level"
      expr: job_level
      comment: "Job level of the assignment."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year assignment started."
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year assignment ended."
  measures:
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Sum of FTE percentages across assignments."
    - name: "average_fte_per_assignment"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE per assignment."
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Number of assignments."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`people_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation totals and averages."
  source: "`telecommunication_ecm`.`people`.`compensation`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code associated with compensation."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Current status of the compensation record."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the compensation became effective."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation amounts."
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary amount."
    - name: "average_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary."
    - name: "total_target_bonus_pct"
      expr: SUM(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Sum of target bonus percentages."
    - name: "average_target_bonus_pct"
      expr: AVG(CAST(target_bonus_percentage AS DOUBLE))
      comment: "Average target bonus percentage."
    - name: "compensation_count"
      expr: COUNT(1)
      comment: "Number of compensation records."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`people_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review outcomes and merit increase recommendations."
  source: "`telecommunication_ecm`.`people`.`performance_review`"
  dimensions:
    - name: "performance_cycle_id"
      expr: performance_cycle_id
      comment: "Identifier of the performance cycle."
    - name: "job_level"
      expr: job_level
      comment: "Job level of the employee being reviewed."
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with the review."
    - name: "overall_rating_label"
      expr: overall_rating_label
      comment: "Overall rating label (e.g., Meets Expectations)."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the performance review."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total number of performance reviews."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_recommended_pct AS DOUBLE))
      comment: "Average recommended merit increase percentage."
    - name: "high_performer_count"
      expr: SUM(CASE WHEN overall_rating_label = 'Exceeds Expectations' THEN 1 ELSE 0 END)
      comment: "Count of high performers (Exceeds Expectations)."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`people_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned vs. actual headcount and cost metrics."
  source: "`telecommunication_ecm`.`people`.`headcount_plan`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the headcount plan."
    - name: "headcount_type"
      expr: headcount_type
      comment: "Type of headcount (e.g., new hire, replacement)."
    - name: "is_active"
      expr: is_active
      comment: "Indicates if the headcount plan is active."
  measures:
    - name: "total_planned_headcount"
      expr: SUM(CAST(planned_headcount AS DOUBLE))
      comment: "Total planned headcount."
    - name: "total_current_filled_headcount"
      expr: SUM(CAST(current_filled_headcount AS DOUBLE))
      comment: "Current filled headcount."
    - name: "total_current_vacant_headcount"
      expr: SUM(CAST(current_vacant_headcount AS DOUBLE))
      comment: "Current vacant headcount."
    - name: "net_new_requested_headcount"
      expr: SUM(CAST(net_new_headcount_requested AS DOUBLE))
      comment: "Net new headcount requested."
    - name: "total_estimated_annual_cost"
      expr: SUM(CAST(total_estimated_annual_cost AS DOUBLE))
      comment: "Total estimated annual cost for headcount."
    - name: "headcount_plan_count"
      expr: COUNT(1)
      comment: "Number of headcount plans."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`people_payslip_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll payout and deduction metrics per payslip."
  source: "`telecommunication_ecm`.`people`.`payslip`"
  dimensions:
    - name: "payroll_run_id"
      expr: payroll_run_id
      comment: "Identifier of the payroll run."
    - name: "employee_id"
      expr: employee_id
      comment: "Employee identifier."
    - name: "pay_period_year"
      expr: YEAR(pay_period_start_date)
      comment: "Pay period year."
    - name: "pay_period_month"
      expr: MONTH(pay_period_start_date)
      comment: "Pay period month."
    - name: "department_code"
      expr: department_code
      comment: "Department code associated with the payslip."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for the payslip."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay."
    - name: "average_gross_pay"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payslip."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid."
    - name: "payslip_count"
      expr: COUNT(1)
      comment: "Number of payslips."
$$;