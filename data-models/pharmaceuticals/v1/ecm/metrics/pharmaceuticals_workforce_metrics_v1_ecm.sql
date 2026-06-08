-- Metric views for domain: workforce | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking employee demographics, tenure, qualifications, and regulatory compliance status"
  source: "`pharmaceuticals_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor, etc.)"
    - name: "job_family"
      expr: job_family
      comment: "Job family classification for role grouping"
    - name: "job_title"
      expr: job_title
      comment: "Employee job title"
    - name: "work_country_code"
      expr: work_country_code
      comment: "Country where employee works"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center assignment for financial tracking"
    - name: "is_people_manager"
      expr: is_people_manager
      comment: "Flag indicating whether employee manages others"
    - name: "is_quality_critical_role"
      expr: is_quality_critical_role
      comment: "Flag indicating quality-critical role requiring enhanced oversight"
    - name: "gxp_qualified"
      expr: CASE WHEN is_gmp_qualified = TRUE OR is_gcp_qualified = TRUE OR is_glp_qualified = TRUE THEN 'GxP Qualified' ELSE 'Not GxP Qualified' END
      comment: "Consolidated GxP qualification status across GMP, GCP, and GLP"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Most recent performance rating"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for employee termination"
  measures:
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count"
    - name: "active_employees"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees"
    - name: "gxp_qualified_employees"
      expr: COUNT(DISTINCT CASE WHEN (is_gmp_qualified = TRUE OR is_gcp_qualified = TRUE OR is_glp_qualified = TRUE) THEN employee_id END)
      comment: "Count of employees qualified in any GxP discipline (GMP, GCP, or GLP)"
    - name: "quality_critical_employees"
      expr: COUNT(DISTINCT CASE WHEN is_quality_critical_role = TRUE THEN employee_id END)
      comment: "Count of employees in quality-critical roles"
    - name: "people_managers"
      expr: COUNT(DISTINCT CASE WHEN is_people_manager = TRUE THEN employee_id END)
      comment: "Count of employees with direct reports"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average employee tenure in days from hire to termination or current date"
    - name: "terminated_employees"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of employees with termination date recorded"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_gxp_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GxP training compliance metrics tracking completion rates, qualification status, and regulatory readiness"
  source: "`pharmaceuticals_ecm`.`workforce`.`gxp_training_record`"
  dimensions:
    - name: "gxp_category"
      expr: gxp_category
      comment: "GxP category (GMP, GCP, GLP, GDP, etc.)"
    - name: "training_type"
      expr: training_type
      comment: "Type of training (initial, refresher, requalification, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, expired, pending, etc.)"
    - name: "record_status"
      expr: record_status
      comment: "Training record status"
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance status for training session"
    - name: "assessment_result"
      expr: assessment_result
      comment: "Result of training assessment (pass, fail, pending, etc.)"
    - name: "completion_method"
      expr: completion_method
      comment: "Method used to complete training (classroom, e-learning, OJT, etc.)"
    - name: "regulatory_inspection_ready_flag"
      expr: regulatory_inspection_ready_flag
      comment: "Flag indicating training record is inspection-ready"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month training was completed"
  measures:
    - name: "total_training_records"
      expr: COUNT(DISTINCT gxp_training_record_id)
      comment: "Total distinct GxP training records"
    - name: "completed_trainings"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN gxp_training_record_id END)
      comment: "Count of completed training records"
    - name: "qualified_records"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN gxp_training_record_id END)
      comment: "Count of training records with qualified status"
    - name: "inspection_ready_records"
      expr: COUNT(DISTINCT CASE WHEN regulatory_inspection_ready_flag = TRUE THEN gxp_training_record_id END)
      comment: "Count of training records ready for regulatory inspection"
    - name: "passed_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_result = 'Pass' THEN gxp_training_record_id END)
      comment: "Count of training records with passing assessment"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training records"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours"
    - name: "overdue_trainings"
      expr: COUNT(DISTINCT CASE WHEN due_date < CURRENT_DATE() AND completion_date IS NULL THEN gxp_training_record_id END)
      comment: "Count of training records past due date without completion"
    - name: "expired_qualifications"
      expr: COUNT(DISTINCT CASE WHEN qualification_expiry_date < CURRENT_DATE() THEN gxp_training_record_id END)
      comment: "Count of training records with expired qualifications"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline metrics tracking requisition volume, time-to-fill, and hiring effectiveness"
  source: "`pharmaceuticals_ecm`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of recruitment requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new hire, backfill, expansion, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment for requisition"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of requisition"
    - name: "gxp_regulated_flag"
      expr: gxp_regulated_flag
      comment: "Flag indicating GxP-regulated position"
    - name: "gmp_critical_flag"
      expr: gmp_critical_flag
      comment: "Flag indicating GMP-critical position"
    - name: "country_code"
      expr: country_code
      comment: "Country for position"
    - name: "company_code"
      expr: company_code
      comment: "Company code for requisition"
    - name: "open_year"
      expr: YEAR(requisition_open_date)
      comment: "Year requisition was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', requisition_open_date)
      comment: "Month requisition was opened"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total distinct recruitment requisitions"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Count of open requisitions"
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN recruitment_requisition_id END)
      comment: "Count of filled requisitions"
    - name: "cancelled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Cancelled' THEN recruitment_requisition_id END)
      comment: "Count of cancelled requisitions"
    - name: "gxp_regulated_requisitions"
      expr: COUNT(DISTINCT CASE WHEN gxp_regulated_flag = TRUE THEN recruitment_requisition_id END)
      comment: "Count of GxP-regulated requisitions"
    - name: "total_headcount_requested"
      expr: SUM(CAST(headcount_quantity AS DOUBLE))
      comment: "Total headcount quantity requested across all requisitions"
    - name: "avg_time_to_fill_days"
      expr: AVG(DATEDIFF(requisition_close_date, requisition_open_date))
      comment: "Average days from requisition open to close date"
    - name: "avg_approved_salary_midpoint"
      expr: AVG((CAST(approved_salary_range_min AS DOUBLE) + CAST(approved_salary_range_max AS DOUBLE)) / 2.0)
      comment: "Average midpoint of approved salary range"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics tracking review completion, ratings distribution, and talent development outcomes"
  source: "`pharmaceuticals_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of performance review"
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Type of review cycle (annual, mid-year, probation, etc.)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of review"
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Flag indicating performance improvement plan required"
    - name: "promotion_readiness_flag"
      expr: promotion_readiness_flag
      comment: "Flag indicating employee is promotion-ready"
    - name: "succession_candidate_flag"
      expr: succession_candidate_flag
      comment: "Flag indicating employee is succession candidate"
    - name: "gxp_training_compliance_flag"
      expr: gxp_training_compliance_flag
      comment: "Flag indicating GxP training compliance status"
    - name: "merit_increase_eligibility_flag"
      expr: merit_increase_eligibility_flag
      comment: "Flag indicating eligibility for merit increase"
    - name: "review_completion_year"
      expr: YEAR(review_completion_date)
      comment: "Year review was completed"
    - name: "review_period_year"
      expr: YEAR(review_period_start_date)
      comment: "Year of review period start"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total distinct performance reviews"
    - name: "completed_reviews"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Completed' THEN performance_review_id END)
      comment: "Count of completed performance reviews"
    - name: "promotion_ready_employees"
      expr: COUNT(DISTINCT CASE WHEN promotion_readiness_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews indicating promotion readiness"
    - name: "succession_candidates"
      expr: COUNT(DISTINCT CASE WHEN succession_candidate_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews identifying succession candidates"
    - name: "pip_required"
      expr: COUNT(DISTINCT CASE WHEN performance_improvement_plan_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews requiring performance improvement plan"
    - name: "merit_eligible_reviews"
      expr: COUNT(DISTINCT CASE WHEN merit_increase_eligibility_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews with merit increase eligibility"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score"
    - name: "gxp_compliant_reviews"
      expr: COUNT(DISTINCT CASE WHEN gxp_training_compliance_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews with GxP training compliance"
    - name: "acknowledged_reviews"
      expr: COUNT(DISTINCT CASE WHEN employee_acknowledgement_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews acknowledged by employee"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll processing metrics tracking gross pay, deductions, net pay, and payroll efficiency"
  source: "`pharmaceuticals_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of payroll run"
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, off-cycle, correction, etc.)"
    - name: "payroll_frequency"
      expr: payroll_frequency
      comment: "Frequency of payroll (weekly, bi-weekly, monthly, etc.)"
    - name: "company_code"
      expr: company_code
      comment: "Company code for payroll run"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for payroll amounts"
    - name: "sox_scope_flag"
      expr: sox_scope_flag
      comment: "Flag indicating SOX scope applicability"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment date"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date"
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total distinct payroll runs"
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount across all payroll runs"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay_amount AS DOUBLE))
      comment: "Total net pay amount across all payroll runs"
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld across all payroll runs"
    - name: "total_social_security"
      expr: SUM(CAST(total_social_security_amount AS DOUBLE))
      comment: "Total social security contributions"
    - name: "total_pension_contribution"
      expr: SUM(CAST(total_pension_contribution_amount AS DOUBLE))
      comment: "Total pension contributions"
    - name: "total_other_deductions"
      expr: SUM(CAST(total_other_deductions_amount AS DOUBLE))
      comment: "Total other deductions"
    - name: "total_employees_paid"
      expr: SUM(CAST(total_employees_processed AS DOUBLE))
      comment: "Total employees processed across all payroll runs"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(total_gross_pay_amount AS DOUBLE) / NULLIF(CAST(total_employees_processed AS DOUBLE), 0))
      comment: "Average gross pay per employee per payroll run"
    - name: "avg_net_pay_per_employee"
      expr: AVG(CAST(total_net_pay_amount AS DOUBLE) / NULLIF(CAST(total_employees_processed AS DOUBLE), 0))
      comment: "Average net pay per employee per payroll run"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics tracking hours worked, overtime, absenteeism, and labor utilization"
  source: "`pharmaceuticals_ecm`.`workforce`.`time_attendance`"
  dimensions:
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance status (present, absent, leave, etc.)"
    - name: "absence_code"
      expr: absence_code
      comment: "Code for absence type"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for attendance record"
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern (day, night, rotating, etc.)"
    - name: "overtime_category"
      expr: overtime_category
      comment: "Category of overtime (standard, premium, holiday, etc.)"
    - name: "gxp_regulated_flag"
      expr: gxp_regulated_flag
      comment: "Flag indicating GxP-regulated work"
    - name: "gmp_critical_flag"
      expr: gmp_critical_flag
      comment: "Flag indicating GMP-critical work"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for time entry"
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Flag indicating payroll processing status"
    - name: "attendance_year"
      expr: YEAR(attendance_date)
      comment: "Year of attendance date"
    - name: "attendance_month"
      expr: DATE_TRUNC('MONTH', attendance_date)
      comment: "Month of attendance date"
  measures:
    - name: "total_attendance_records"
      expr: COUNT(DISTINCT time_attendance_id)
      comment: "Total distinct time and attendance records"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked (regular plus overtime)"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours"
    - name: "avg_regular_hours_per_day"
      expr: AVG(CAST(regular_hours AS DOUBLE))
      comment: "Average regular hours per attendance record"
    - name: "avg_overtime_hours_per_day"
      expr: AVG(CAST(overtime_hours AS DOUBLE))
      comment: "Average overtime hours per attendance record"
    - name: "absent_records"
      expr: COUNT(DISTINCT CASE WHEN attendance_status = 'Absent' THEN time_attendance_id END)
      comment: "Count of absent attendance records"
    - name: "present_records"
      expr: COUNT(DISTINCT CASE WHEN attendance_status = 'Present' THEN time_attendance_id END)
      comment: "Count of present attendance records"
    - name: "gxp_regulated_hours"
      expr: SUM(CAST(CASE WHEN gxp_regulated_flag = TRUE THEN actual_hours_worked ELSE 0 END AS DOUBLE))
      comment: "Total hours worked on GxP-regulated activities"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_succession_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Succession planning metrics tracking readiness, development gaps, and business continuity preparedness"
  source: "`pharmaceuticals_ecm`.`workforce`.`succession_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of succession plan"
    - name: "readiness_level"
      expr: readiness_level
      comment: "Readiness level of successor (ready now, 1-2 years, 3+ years, etc.)"
    - name: "business_continuity_priority"
      expr: business_continuity_priority
      comment: "Business continuity priority level"
    - name: "retention_risk_rating"
      expr: retention_risk_rating
      comment: "Retention risk rating for incumbent"
    - name: "gxp_qualification_status"
      expr: gxp_qualification_status
      comment: "GxP qualification status of successor"
    - name: "qualified_person_flag"
      expr: qualified_person_flag
      comment: "Flag indicating qualified person status"
    - name: "responsible_pharmacist_flag"
      expr: responsible_pharmacist_flag
      comment: "Flag indicating responsible pharmacist status"
    - name: "regulatory_inspection_ready_flag"
      expr: regulatory_inspection_ready_flag
      comment: "Flag indicating regulatory inspection readiness"
    - name: "therapeutic_area_criticality"
      expr: therapeutic_area_criticality
      comment: "Criticality level for therapeutic area"
    - name: "plan_year"
      expr: YEAR(created_timestamp)
      comment: "Year succession plan was created"
  measures:
    - name: "total_succession_plans"
      expr: COUNT(DISTINCT succession_plan_id)
      comment: "Total distinct succession plans"
    - name: "active_succession_plans"
      expr: COUNT(DISTINCT CASE WHEN plan_status = 'Active' THEN succession_plan_id END)
      comment: "Count of active succession plans"
    - name: "ready_now_successors"
      expr: COUNT(DISTINCT CASE WHEN readiness_level = 'Ready Now' THEN succession_plan_id END)
      comment: "Count of succession plans with ready-now successors"
    - name: "high_retention_risk_plans"
      expr: COUNT(DISTINCT CASE WHEN retention_risk_rating = 'High' THEN succession_plan_id END)
      comment: "Count of succession plans with high retention risk"
    - name: "gxp_qualified_successors"
      expr: COUNT(DISTINCT CASE WHEN gxp_qualification_status = 'Qualified' THEN succession_plan_id END)
      comment: "Count of succession plans with GxP-qualified successors"
    - name: "inspection_ready_successors"
      expr: COUNT(DISTINCT CASE WHEN regulatory_inspection_ready_flag = TRUE THEN succession_plan_id END)
      comment: "Count of succession plans with inspection-ready successors"
    - name: "qualified_person_successors"
      expr: COUNT(DISTINCT CASE WHEN qualified_person_flag = TRUE THEN succession_plan_id END)
      comment: "Count of succession plans with qualified person successors"
    - name: "critical_business_continuity_plans"
      expr: COUNT(DISTINCT CASE WHEN business_continuity_priority = 'Critical' THEN succession_plan_id END)
      comment: "Count of succession plans with critical business continuity priority"
    - name: "avg_days_to_transition"
      expr: AVG(DATEDIFF(estimated_transition_date, created_timestamp))
      comment: "Average days from plan creation to estimated transition date"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation planning metrics tracking salary ranges, bonus targets, benefit costs, and pay equity"
  source: "`pharmaceuticals_ecm`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of compensation plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of compensation plan"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status for plan"
    - name: "job_grade_band"
      expr: job_grade_band
      comment: "Job grade band for compensation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for compensation amounts"
    - name: "lti_eligibility_flag"
      expr: lti_eligibility_flag
      comment: "Flag indicating long-term incentive eligibility"
    - name: "pay_equity_analysis_flag"
      expr: pay_equity_analysis_flag
      comment: "Flag indicating pay equity analysis performed"
    - name: "compliance_review_flag"
      expr: compliance_review_flag
      comment: "Flag indicating compliance review completed"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of compensation plan"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year compensation plan became effective"
  measures:
    - name: "total_compensation_plans"
      expr: COUNT(DISTINCT compensation_plan_id)
      comment: "Total distinct compensation plans"
    - name: "avg_base_salary_midpoint"
      expr: AVG(CAST(base_salary_midpoint AS DOUBLE))
      comment: "Average base salary midpoint across plans"
    - name: "avg_base_salary_minimum"
      expr: AVG(CAST(base_salary_minimum AS DOUBLE))
      comment: "Average base salary minimum across plans"
    - name: "avg_base_salary_maximum"
      expr: AVG(CAST(base_salary_maximum AS DOUBLE))
      comment: "Average base salary maximum across plans"
    - name: "avg_bonus_target_pct"
      expr: AVG(CAST(bonus_target_percentage AS DOUBLE))
      comment: "Average bonus target percentage"
    - name: "avg_lti_target_pct"
      expr: AVG(CAST(lti_target_percentage AS DOUBLE))
      comment: "Average long-term incentive target percentage"
    - name: "avg_merit_increase_budget_pct"
      expr: AVG(CAST(merit_increase_budget_percentage AS DOUBLE))
      comment: "Average merit increase budget percentage"
    - name: "avg_retirement_match_pct"
      expr: AVG(CAST(retirement_plan_employer_match_percentage AS DOUBLE))
      comment: "Average retirement plan employer match percentage"
    - name: "avg_health_insurance_contribution"
      expr: AVG(CAST(health_insurance_employer_contribution AS DOUBLE))
      comment: "Average health insurance employer contribution"
    - name: "lti_eligible_plans"
      expr: COUNT(DISTINCT CASE WHEN lti_eligibility_flag = TRUE THEN compensation_plan_id END)
      comment: "Count of plans with long-term incentive eligibility"
    - name: "pay_equity_reviewed_plans"
      expr: COUNT(DISTINCT CASE WHEN pay_equity_analysis_flag = TRUE THEN compensation_plan_id END)
      comment: "Count of plans with pay equity analysis completed"
$$;