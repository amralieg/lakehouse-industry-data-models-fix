-- Metric views for domain: workforce | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core headcount capacity and utilization metrics"
  source: "`payments_fintech_ecm`.`workforce`.`headcount`"
  dimensions:
    - name: "reporting_date"
      expr: reporting_date
      comment: "Date of the headcount report"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of the headcount report"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit identifier"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity identifier"
    - name: "headcount_status"
      expr: headcount_status
      comment: "Status of the headcount record (e.g., active, projected)"
  measures:
    - name: "total_fte"
      expr: SUM(filled_fte + vacant_fte)
      comment: "Total FTE (filled + vacant) for the reporting period"
    - name: "authorized_fte"
      expr: SUM(CAST(authorized_fte AS DOUBLE))
      comment: "Total authorized FTE capacity"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of headcount records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_employee_turnover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnover and active workforce metrics"
  source: "`payments_fintech_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code of the employee"
    - name: "manager_employee_id"
      expr: manager_employee_id
      comment: "Manager employee identifier"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "hire_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month of hire date"
  measures:
    - name: "terminated_employee_count"
      expr: SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of employees who terminated in the period"
    - name: "active_employee_count"
      expr: SUM(CASE WHEN termination_date IS NULL THEN 1 ELSE 0 END)
      comment: "Number of currently active employees"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Total employee records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_compensation_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation expense and equity grant metrics"
  source: "`payments_fintech_ecm`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan"
    - name: "currency"
      expr: currency
      comment: "Currency of compensation amounts"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Effective month of the compensation plan"
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary across all compensation plans"
    - name: "average_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary per compensation plan"
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total allowance amount across plans"
    - name: "total_equity_units"
      expr: SUM(CAST(equity_units AS DOUBLE))
      comment: "Total equity units granted"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of compensation plan records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_benefit_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit enrollment cost and participation metrics"
  source: "`payments_fintech_ecm`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the benefit plan"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier of the enrollment"
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating if the enrollment is currently active"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the benefit became effective"
  measures:
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contributions to benefits"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contributions to benefits"
    - name: "total_benefit_cost"
      expr: SUM(employee_contribution_amount + employer_contribution_amount)
      comment: "Combined cost of benefits per enrollment"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of benefit enrollments"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_background_check_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment of background checks"
  source: "`payments_fintech_ecm`.`workforce`.`background_check`"
  dimensions:
    - name: "provider_name"
      expr: provider_name
      comment: "Background check provider"
    - name: "check_type"
      expr: check_type
      comment: "Type of background check"
    - name: "is_periodic"
      expr: is_periodic
      comment: "Indicates if the check is periodic"
    - name: "result_month"
      expr: DATE_TRUNC('month', result_date)
      comment: "Month of the check result"
  measures:
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across background checks"
    - name: "high_risk_check_count"
      expr: SUM(CASE WHEN risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Count of background checks with risk score >= 80"
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of background checks performed"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training program effectiveness metrics"
  source: "`payments_fintech_ecm`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "training_program_name"
      expr: training_program_name
      comment: "Name of the training program"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the training was completed"
  measures:
    - name: "average_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score for completed trainings"
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review rating metrics"
  source: "`payments_fintech_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_month"
      expr: DATE_TRUNC('month', review_period_start_date)
      comment: "Month the review period started"
    - name: "reviewer_employee_id"
      expr: reviewer_employee_id
      comment: "Identifier of the reviewer"
    - name: "review_status"
      expr: performance_review_status
      comment: "Status of the performance review"
  measures:
    - name: "average_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating"
    - name: "review_count"
      expr: COUNT(1)
      comment: "Number of performance reviews"
$$;