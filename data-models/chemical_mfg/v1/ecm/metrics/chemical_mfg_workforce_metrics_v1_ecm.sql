-- Metric views for domain: workforce | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics for headcount, compensation and compliance"
  source: "`chemical_mfg_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code the employee belongs to"
    - name: "job_role_id"
      expr: job_role_id
      comment: "Job role identifier (foreign key)"
    - name: "employee_type"
      expr: employee_type
      comment: "Classification of employee (e.g., full‑time, contractor)"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status"
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired"
  measures:
    - name: "total_employees"
      expr: COUNT(1)
      comment: "Total number of employee records"
    - name: "average_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary across employees"
    - name: "total_annual_salary"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Sum of annual salaries for all employees"
    - name: "gmp_qualified_count"
      expr: SUM(CASE WHEN gmp_qualification_flag THEN 1 ELSE 0 END)
      comment: "Number of employees qualified for GMP"
    - name: "psm_trained_count"
      expr: SUM(CASE WHEN psm_training_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Employees with a recorded PSM training date"
    - name: "safety_training_completed_count"
      expr: SUM(CASE WHEN safety_training_completed_flag THEN 1 ELSE 0 END)
      comment: "Employees who have completed safety training"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic headcount planning metrics for capacity and budgeting"
  source: "`chemical_mfg_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit the plan applies to"
    - name: "job_role_id"
      expr: job_role_id
      comment: "Job role targeted by the plan"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan"
    - name: "headcount_plan_status"
      expr: headcount_plan_status
      comment: "Current status of the headcount plan"
    - name: "is_contractor_allowed"
      expr: is_contractor_allowed
      comment: "Whether contractors are permitted in the plan"
  measures:
    - name: "total_target_fte"
      expr: SUM(CAST(target_fte AS DOUBLE))
      comment: "Sum of target full‑time equivalents across plans"
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Sum of approved full‑time equivalents"
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Number of headcount plan records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`workforce_training_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development metrics to monitor training investment and requirements"
  source: "`chemical_mfg_ecm`.`workforce`.`training_course`"
  dimensions:
    - name: "course_type"
      expr: course_type
      comment: "Classification of the training course"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (e.g., online, classroom)"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating if the course is mandatory"
    - name: "regulatory_mandate"
      expr: regulatory_mandate
      comment: "Regulatory requirement associated with the course"
  measures:
    - name: "count_courses"
      expr: COUNT(1)
      comment: "Total training courses defined"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Aggregate cost of all training courses"
    - name: "average_credit_hours"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per course"
    - name: "mandatory_course_count"
      expr: SUM(CASE WHEN is_mandatory THEN 1 ELSE 0 END)
      comment: "Number of courses marked as mandatory"
$$;