-- Metric views for domain: workforce | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_applicant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting funnel and applicant quality metrics"
  source: "`media_broadcasting_ecm`.`workforce`.`applicant`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date the application was submitted"
    - name: "application_source"
      expr: application_source
      comment: "Source channel of the application (e.g., job board, referral)"
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "country_code"
      expr: country_code
      comment: "Country code of applicant's address"
    - name: "degree_field"
      expr: degree_field
      comment: "Field of study for the highest degree"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of applicant records submitted"
    - name: "total_referred"
      expr: SUM(CASE WHEN referral_employee_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of applicants who were referred by an existing employee"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience reported by applicants"
    - name: "avg_desired_salary"
      expr: AVG(CAST(desired_salary_amount AS DOUBLE))
      comment: "Average desired salary amount across applicants"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation plan financial and eligibility metrics"
  source: "`media_broadcasting_ecm`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the compensation plan"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade associated with the plan"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (e.g., biweekly, monthly)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan"
    - name: "union_code"
      expr: union_code
      comment: "Union code if the employee is unionized"
  measures:
    - name: "count_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with a compensation plan"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary amount across all compensation plans"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary amount"
    - name: "total_bonus_eligible"
      expr: SUM(CASE WHEN bonus_eligible THEN 1 ELSE 0 END)
      comment: "Count of employees eligible for bonus"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly employees"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payroll financial metrics for finance leadership"
  source: "`media_broadcasting_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the payroll period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the payroll period"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (e.g., weekly, biweekly)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll amounts"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll record"
  measures:
    - name: "count_payroll_records"
      expr: COUNT(1)
      comment: "Number of payroll records processed"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay paid"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay paid after deductions"
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_pay AS DOUBLE))
      comment: "Total bonus payments"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions across all payroll records"
    - name: "avg_gross_pay"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics to monitor utilization and approval rates"
  source: "`media_broadcasting_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "request_date"
      expr: request_date
      comment: "Date the leave request was submitted"
    - name: "leave_type"
      expr: leave_type
      comment: "Primary type of leave (e.g., PTO, Sick)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the request"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit of the employee"
  measures:
    - name: "count_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests submitted"
    - name: "total_requested_days"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total number of leave days requested"
    - name: "total_approved_requests"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of leave requests that were approved"
    - name: "avg_requested_days"
      expr: AVG(CAST(actual_days_taken AS DOUBLE))
      comment: "Average number of days requested per leave request"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic headcount planning metrics for workforce planning"
  source: "`media_broadcasting_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit the plan applies to"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (e.g., growth, reduction)"
    - name: "plan_approval_status"
      expr: plan_approval_status
      comment: "Current approval status of the plan"
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte_count AS DOUBLE))
      comment: "Total approved full-time equivalents in the headcount plan"
    - name: "total_current_filled_fte"
      expr: SUM(CAST(current_filled_fte AS DOUBLE))
      comment: "Total currently filled FTEs"
    - name: "total_variance_fte"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Aggregate variance between planned and actual FTEs"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated for headcount"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review KPIs to assess talent development and readiness"
  source: "`media_broadcasting_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_date"
      expr: review_date
      comment: "Date the performance review took place"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g., Completed, In Progress)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., Annual, Mid-Year)"
  measures:
    - name: "count_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews recorded"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating"
    - name: "avg_leadership_rating"
      expr: AVG(CAST(leadership_rating AS DOUBLE))
      comment: "Average leadership competency rating"
    - name: "avg_technical_rating"
      expr: AVG(CAST(technical_skills_rating AS DOUBLE))
      comment: "Average technical skills rating"
    - name: "promotion_eligible_count"
      expr: SUM(CASE WHEN promotion_eligible_flag THEN 1 ELSE 0 END)
      comment: "Number of employees flagged as promotion eligible"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_interview_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interview effectiveness metrics for talent acquisition leadership"
  source: "`media_broadcasting_ecm`.`workforce`.`interview_event`"
  dimensions:
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Date the interview was scheduled"
    - name: "interview_status"
      expr: interview_status
      comment: "Current status of the interview"
    - name: "interview_type"
      expr: interview_type
      comment: "Format of the interview (e.g., Phone, Onsite)"
    - name: "interview_round_number"
      expr: interview_round_number
      comment: "Round number of the interview in the hiring process"
  measures:
    - name: "total_interviews"
      expr: COUNT(1)
      comment: "Total interview events recorded"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across interviews"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall interview rating"
    - name: "total_hire_recommendations"
      expr: SUM(CASE WHEN hire_recommendation = 'Hire' THEN 1 ELSE 0 END)
      comment: "Number of interviews that resulted in a hire recommendation"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development metrics to track training uptake and effectiveness"
  source: "`media_broadcasting_ecm`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment (e.g., Enrolled, Completed, Cancelled)"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating if the training is mandatory"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (e.g., New Hire, Ongoing Development)"
    - name: "employee_id"
      expr: employee_id
      comment: "Identifier of the employee enrolled"
  measures:
    - name: "count_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments recorded"
    - name: "completed_enrollments"
      expr: SUM(CASE WHEN enrollment_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of enrollments that were completed"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score for completed trainings"
$$;