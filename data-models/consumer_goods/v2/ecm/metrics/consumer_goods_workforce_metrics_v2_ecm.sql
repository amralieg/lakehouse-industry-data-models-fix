-- Metric views for domain: workforce | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount, demographics, and tenure metrics for workforce planning and diversity analysis"
  source: "`vibe_consumer_goods_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contractor, etc.)"
    - name: "gender"
      expr: gender
      comment: "Employee gender for diversity reporting"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month employee was hired for cohort analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for attrition analysis"
    - name: "has_manager"
      expr: CASE WHEN manager_employee_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether employee has an assigned manager"
  measures:
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count"
    - name: "active_employees"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees"
    - name: "terminated_employees"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of employees with termination date"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average employee tenure in days from hire to termination or current date"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation metrics for labor cost analysis and budgeting"
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payroll payment"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payroll payment for trend analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payroll payment"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost before deductions"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net payroll cost after deductions and taxes"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total employee deductions (benefits, garnishments, etc.)"
    - name: "total_taxes"
      expr: SUM(CAST(total_taxes AS DOUBLE))
      comment: "Total payroll taxes withheld"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record"
    - name: "avg_net_pay_per_employee"
      expr: AVG(CAST(net_pay AS DOUBLE))
      comment: "Average net pay per payroll record"
    - name: "payroll_record_count"
      expr: COUNT(DISTINCT payroll_record_id)
      comment: "Total number of payroll records processed"
    - name: "unique_employees_paid"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct count of employees who received payment"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours, overtime, and time utilization metrics for workforce productivity and cost allocation"
  source: "`vibe_consumer_goods_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year of work performed"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work performed for trend analysis"
    - name: "time_type"
      expr: time_type
      comment: "Type of time entry (regular, overtime, PTO, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entry"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total regular hours worked across all time entries"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average regular hours per time entry"
    - name: "avg_overtime_per_entry"
      expr: AVG(CAST(overtime_hours AS DOUBLE))
      comment: "Average overtime hours per time entry"
    - name: "time_entry_count"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Total number of time entries submitted"
    - name: "unique_employees_with_time"
      expr: COUNT(DISTINCT time_employee_id)
      comment: "Distinct count of employees who submitted time"
    - name: "approved_time_entries"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN time_entry_id END)
      comment: "Count of approved time entries"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_recruiting_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting pipeline and time-to-fill metrics for talent acquisition effectiveness"
  source: "`vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of recruiting requisition"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year requisition was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month requisition was opened"
    - name: "target_hire_year"
      expr: YEAR(target_hire_date)
      comment: "Target year for hire"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruiting_requisition_id)
      comment: "Total number of recruiting requisitions"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN recruiting_requisition_id END)
      comment: "Count of open requisitions"
    - name: "closed_requisitions"
      expr: COUNT(DISTINCT CASE WHEN close_date IS NOT NULL THEN recruiting_requisition_id END)
      comment: "Count of closed requisitions"
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(close_date, open_date))
      comment: "Average days from requisition open to close (time-to-fill)"
    - name: "avg_days_open_to_target"
      expr: AVG(DATEDIFF(target_hire_date, open_date))
      comment: "Average days from open date to target hire date (planned hiring window)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_job_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel conversion and candidate pipeline metrics for talent acquisition optimization"
  source: "`vibe_consumer_goods_v1`.`workforce`.`job_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of job application"
    - name: "application_source"
      expr: application_source
      comment: "Source channel of application (referral, job board, etc.)"
    - name: "current_stage"
      expr: current_stage
      comment: "Current stage in recruiting pipeline"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year application was submitted"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month application was submitted"
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT job_application_id)
      comment: "Total number of job applications received"
    - name: "unique_applicants"
      expr: COUNT(DISTINCT applicant_id)
      comment: "Distinct count of applicants"
    - name: "offers_extended"
      expr: COUNT(DISTINCT CASE WHEN offer_extended_date IS NOT NULL THEN job_application_id END)
      comment: "Count of applications that received an offer"
    - name: "offers_accepted"
      expr: COUNT(DISTINCT CASE WHEN offer_accepted_date IS NOT NULL THEN job_application_id END)
      comment: "Count of offers that were accepted"
    - name: "rejections"
      expr: COUNT(DISTINCT CASE WHEN rejection_date IS NOT NULL THEN job_application_id END)
      comment: "Count of rejected applications"
    - name: "avg_days_to_offer"
      expr: AVG(DATEDIFF(offer_extended_date, application_date))
      comment: "Average days from application to offer extended"
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(offer_accepted_date, offer_extended_date))
      comment: "Average days from offer extended to acceptance"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, effectiveness, and compliance metrics for workforce development and regulatory adherence"
  source: "`vibe_consumer_goods_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_record_status"
      expr: training_record_status
      comment: "Status of training record (completed, in progress, expired, etc.)"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month training was completed"
    - name: "is_expired"
      expr: CASE WHEN expiration_date < CURRENT_DATE() THEN 'Yes' ELSE 'No' END
      comment: "Whether training certification has expired"
  measures:
    - name: "total_training_records"
      expr: COUNT(DISTINCT training_record_id)
      comment: "Total number of training records"
    - name: "completed_trainings"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN training_record_id END)
      comment: "Count of completed training records"
    - name: "expired_certifications"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE() THEN training_record_id END)
      comment: "Count of training certifications that have expired"
    - name: "unique_employees_trained"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct count of employees with training records"
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score across all records"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety incident frequency, severity, and OSHA recordability metrics for risk management and regulatory compliance"
  source: "`vibe_consumer_goods_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (injury, near miss, property damage, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity level of incident"
    - name: "osha_recordable"
      expr: osha_recordable
      comment: "Whether incident is OSHA recordable"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month incident occurred"
    - name: "has_corrective_action"
      expr: CASE WHEN corrective_action IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether corrective action was documented"
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT safety_incident_id)
      comment: "Total number of safety incidents"
    - name: "osha_recordable_incidents"
      expr: COUNT(DISTINCT CASE WHEN osha_recordable = TRUE THEN safety_incident_id END)
      comment: "Count of OSHA recordable incidents"
    - name: "unique_employees_involved"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct count of employees involved in incidents"
    - name: "incidents_with_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action IS NOT NULL THEN safety_incident_id END)
      comment: "Count of incidents with documented corrective action"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance rating distribution and review completion metrics for talent management and succession planning"
  source: "`vibe_consumer_goods_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating"
    - name: "review_status"
      expr: review_status
      comment: "Status of performance review"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year review was conducted"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month review was conducted"
    - name: "review_period_year"
      expr: YEAR(review_period_start)
      comment: "Year of review period start"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews"
    - name: "completed_reviews"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Completed' THEN performance_review_id END)
      comment: "Count of completed performance reviews"
    - name: "unique_employees_reviewed"
      expr: COUNT(DISTINCT performance_employee_id)
      comment: "Distinct count of employees who received reviews"
    - name: "unique_reviewers"
      expr: COUNT(DISTINCT reviewer_employee_id)
      comment: "Distinct count of employees who conducted reviews"
    - name: "avg_review_period_days"
      expr: AVG(DATEDIFF(review_period_end, review_period_start))
      comment: "Average length of review period in days"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits enrollment, cost, and participation metrics for total compensation analysis and benefits program optimization"
  source: "`vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (health, dental, vision, 401k, etc.)"
    - name: "benefit_enrollment_status"
      expr: benefit_enrollment_status
      comment: "Status of benefit enrollment"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (employee only, employee+spouse, family, etc.)"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of benefit enrollment"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year benefit became effective"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT benefit_enrollment_id)
      comment: "Total number of benefit enrollments"
    - name: "active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN benefit_enrollment_status = 'Active' THEN benefit_enrollment_id END)
      comment: "Count of active benefit enrollments"
    - name: "unique_employees_enrolled"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct count of employees with benefit enrollments"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee contributions to benefits"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer contributions to benefits (labor cost)"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution AS DOUBLE))
      comment: "Average employee contribution per enrollment"
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution AS DOUBLE))
      comment: "Average employer contribution per enrollment"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll processing cycle metrics for payroll operations efficiency and cost control"
  source: "`vibe_consumer_goods_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of payroll run (completed, in progress, failed, etc.)"
    - name: "run_year"
      expr: YEAR(run_date)
      comment: "Year payroll run was executed"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month payroll run was executed"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment disbursement"
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total number of payroll runs executed"
    - name: "completed_payroll_runs"
      expr: COUNT(DISTINCT CASE WHEN run_status = 'Completed' THEN payroll_run_id END)
      comment: "Count of successfully completed payroll runs"
    - name: "total_gross_pay_processed"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross pay processed across all payroll runs"
    - name: "total_net_pay_processed"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay processed across all payroll runs"
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run"
    - name: "avg_net_pay_per_run"
      expr: AVG(CAST(total_net_pay AS DOUBLE))
      comment: "Average net pay per payroll run"
$$;