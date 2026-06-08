-- Metric views for domain: hr | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`hr_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key benefit enrollment KPIs to monitor cost exposure and employee participation"
  source: "`banking_ecm`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Identifier of the employee"
    - name: "benefit_plan_id"
      expr: benefit_plan_id
      comment: "Identifier of the benefit plan"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment"
    - name: "enrollment_effective_month"
      expr: DATE_TRUNC('month', enrollment_effective_date)
      comment: "Month of enrollment effective date"
  measures:
    - name: "total_premium_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount across all benefit enrollments"
    - name: "average_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount per enrollment"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of benefit enrollment records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`hr_compensation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation event metrics to assess reward effectiveness and cost"
  source: "`banking_ecm`.`hr`.`compensation_event`"
  dimensions:
    - name: "employee_id"
      expr: primary_compensation_employee_id
      comment: "Employee receiving the compensation change"
    - name: "event_type"
      expr: event_type
      comment: "Type of compensation event (e.g., salary increase, bonus)"
  measures:
    - name: "total_bonus_award"
      expr: SUM(CAST(bonus_award_amount AS DOUBLE))
      comment: "Sum of bonus awards granted in compensation events"
    - name: "average_compa_ratio"
      expr: AVG(CAST(compa_ratio AS DOUBLE))
      comment: "Average compa ratio across events"
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation amount"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of compensation events"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`hr_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll financial metrics for cost monitoring and budgeting"
  source: "`banking_ecm`.`hr`.`payroll_record`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Employee associated with the payroll record"
    - name: "pay_period_month"
      expr: DATE_TRUNC('month', pay_period_start_date)
      comment: "Payroll period month"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll run (e.g., processed, pending)"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll amount"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net payroll amount after deductions"
    - name: "average_gross_pay"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record"
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Count of payroll records processed"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`hr_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attendance metrics to evaluate labor utilization and overtime exposure"
  source: "`banking_ecm`.`hr`.`time_attendance`"
  dimensions:
    - name: "employee_id"
      expr: primary_time_employee_id
      comment: "Employee associated with the time entry"
    - name: "work_date"
      expr: work_date
      comment: "Date of the work entry"
    - name: "absence_type_code"
      expr: absence_type_code
      comment: "Code indicating type of absence"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all attendance records"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours logged"
    - name: "total_absence_hours"
      expr: SUM(CAST(absence_hours AS DOUBLE))
      comment: "Total hours of recorded absence"
    - name: "attendance_record_count"
      expr: COUNT(1)
      comment: "Number of time attendance entries"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`hr_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review KPIs to track employee effectiveness and compensation alignment"
  source: "`banking_ecm`.`hr`.`performance_review`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Employee being reviewed"
    - name: "review_cycle_id"
      expr: review_cycle_id
      comment: "Identifier of the review cycle"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review"
  measures:
    - name: "average_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall rating score from performance reviews"
    - name: "average_bonus_percentage"
      expr: AVG(CAST(bonus_percentage AS DOUBLE))
      comment: "Average bonus percentage awarded"
    - name: "average_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score"
    - name: "review_count"
      expr: COUNT(1)
      comment: "Number of performance review records"
$$;