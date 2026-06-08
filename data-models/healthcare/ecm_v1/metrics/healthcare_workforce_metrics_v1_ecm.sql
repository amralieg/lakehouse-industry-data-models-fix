-- Metric views for domain: workforce | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`workforce_benefit_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of employee benefit enrollments"
  source: "`healthcare_ecm`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (e.g., health, dental, vision)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Benefit carrier name"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the enrollment"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the benefit became effective"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee associated with the enrollment"
  measures:
    - name: "total_employee_premium"
      expr: SUM(CAST(employee_premium_amount AS DOUBLE))
      comment: "Sum of employee premium contributions across all enrollments"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Sum of employer contributions across all enrollments"
    - name: "total_premium"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount (employee + employer)"
    - name: "average_premium_per_enrollment"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium per benefit enrollment"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of benefit enrollments"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payroll financial metrics per payroll run"
  source: "`healthcare_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "pay_date"
      expr: pay_date
      comment: "Date of the payroll payment"
    - name: "payroll_calendar_id"
      expr: payroll_calendar_id
      comment: "Identifier of the payroll calendar used"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit of the payroll run"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payroll run"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payroll run"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Sum of gross pay for the payroll run"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Sum of net pay for the payroll run"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Sum of all deductions for the payroll run"
    - name: "employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees paid in the run"
$$;