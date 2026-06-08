-- Metric views for domain: workforce | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, tenure, and compensation analysis"
  source: "`gaming_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on leave)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contract)"
    - name: "department"
      expr: department
      comment: "Department assignment"
    - name: "job_title"
      expr: job_title
      comment: "Current job title"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level classification"
    - name: "primary_skill"
      expr: primary_skill
      comment: "Primary skill or discipline"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Most recent performance rating"
    - name: "compensation_grade"
      expr: compensation_grade
      comment: "Compensation grade band"
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Whether employee is eligible for remote work"
    - name: "work_location"
      expr: work_location
      comment: "Primary work location"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month employee was hired"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year employee was terminated (if applicable)"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count"
    - name: "total_annual_compensation"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Total annual salary expense across all employees"
    - name: "avg_annual_compensation"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary per employee"
    - name: "avg_tenure_years"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date) / 365.25)
      comment: "Average employee tenure in years"
    - name: "remote_eligible_count"
      expr: SUM(CASE WHEN is_remote_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees eligible for remote work"
    - name: "remote_eligible_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_remote_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(employee_id), 0), 2)
      comment: "Percentage of employees eligible for remote work"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment effectiveness and time-to-fill metrics for talent acquisition"
  source: "`gaming_ecm`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment for the position"
    - name: "position_level"
      expr: position_level
      comment: "Seniority level of the position"
    - name: "discipline"
      expr: discipline
      comment: "Discipline or functional area"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition"
    - name: "location_country_code"
      expr: location_country_code
      comment: "Country code for the position location"
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Whether the position is remote-eligible"
    - name: "diversity_hiring_flag"
      expr: diversity_hiring_flag
      comment: "Whether this is a diversity hiring initiative"
    - name: "requisition_open_month"
      expr: DATE_TRUNC('MONTH', requisition_open_date)
      comment: "Month the requisition was opened"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total number of recruitment requisitions"
    - name: "total_openings"
      expr: SUM(CAST(number_of_openings AS BIGINT))
      comment: "Total number of open positions across all requisitions"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS BIGINT))
      comment: "Average time to fill a position in days"
    - name: "total_candidates_applied"
      expr: SUM(CAST(total_candidates_applied AS BIGINT))
      comment: "Total number of candidates who applied"
    - name: "total_candidates_interviewed"
      expr: SUM(CAST(total_candidates_interviewed AS BIGINT))
      comment: "Total number of candidates interviewed"
    - name: "total_offers_extended"
      expr: SUM(CAST(total_offers_extended AS BIGINT))
      comment: "Total number of offers extended"
    - name: "interview_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(total_candidates_interviewed AS BIGINT)) / NULLIF(SUM(CAST(total_candidates_applied AS BIGINT)), 0), 2)
      comment: "Percentage of applicants who were interviewed"
    - name: "offer_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(total_offers_extended AS BIGINT)) / NULLIF(SUM(CAST(total_candidates_interviewed AS BIGINT)), 0), 2)
      comment: "Percentage of interviewed candidates who received offers"
    - name: "avg_salary_range_midpoint"
      expr: AVG((CAST(salary_range_min AS DOUBLE) + CAST(salary_range_max AS DOUBLE)) / 2.0)
      comment: "Average midpoint of salary ranges across requisitions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics including ratings, goal achievement, and promotion readiness"
  source: "`gaming_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the performance review"
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration committee status"
    - name: "promotion_readiness_level"
      expr: promotion_readiness_level
      comment: "Readiness level for promotion"
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Whether promotion is recommended"
    - name: "compensation_increase_recommended"
      expr: compensation_increase_recommended
      comment: "Whether compensation increase is recommended"
    - name: "review_period_year"
      expr: YEAR(review_period_end_date)
      comment: "Year of the review period end"
    - name: "review_period_quarter"
      expr: QUARTER(review_period_end_date)
      comment: "Quarter of the review period end"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "avg_technical_competency_score"
      expr: AVG(CAST(technical_competency_score AS DOUBLE))
      comment: "Average technical competency score"
    - name: "avg_collaboration_score"
      expr: AVG(CAST(collaboration_score AS DOUBLE))
      comment: "Average collaboration score"
    - name: "avg_innovation_score"
      expr: AVG(CAST(innovation_score AS DOUBLE))
      comment: "Average innovation score"
    - name: "avg_leadership_score"
      expr: AVG(CAST(leadership_score AS DOUBLE))
      comment: "Average leadership score"
    - name: "avg_goal_achievement_pct"
      expr: AVG(CAST(goal_achievement_percentage AS DOUBLE))
      comment: "Average percentage of goals achieved"
    - name: "promotion_recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN promotion_recommended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(performance_review_id), 0), 2)
      comment: "Percentage of reviews recommending promotion"
    - name: "compensation_increase_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compensation_increase_recommended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(performance_review_id), 0), 2)
      comment: "Percentage of reviews recommending compensation increase"
    - name: "avg_compensation_increase_pct"
      expr: AVG(CAST(compensation_increase_percentage AS DOUBLE))
      comment: "Average recommended compensation increase percentage"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time tracking and utilization metrics for workforce productivity and billing"
  source: "`gaming_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry"
    - name: "activity_type"
      expr: activity_type
      comment: "Activity type for the time entry"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry"
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the time is billable"
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the time has been processed in payroll"
    - name: "work_location"
      expr: work_location
      comment: "Location where work was performed"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year of the time entry"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of the time entry"
    - name: "entry_week"
      expr: DATE_TRUNC('WEEK', entry_date)
      comment: "Week of the time entry"
  measures:
    - name: "total_time_entries"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Total number of time entries"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entries"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours per time entry"
    - name: "total_billable_hours"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours worked"
    - name: "billable_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are billable"
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are overtime"
    - name: "total_billing_value"
      expr: SUM(CAST(hours_worked AS DOUBLE) * CAST(billing_rate AS DOUBLE))
      comment: "Total billing value of time entries"
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate per hour"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure and equity metrics for pay analysis and planning"
  source: "`gaming_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation arrangement"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade classification"
    - name: "pay_equity_band"
      expr: pay_equity_band
      comment: "Pay equity band for internal equity analysis"
    - name: "job_title"
      expr: job_title
      comment: "Job title associated with compensation"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (monthly, bi-weekly, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of compensation change"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for compensation change"
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Whether employee is eligible for overtime"
    - name: "equity_grant_type"
      expr: equity_grant_type
      comment: "Type of equity grant"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year compensation became effective"
  measures:
    - name: "total_compensation_records"
      expr: COUNT(DISTINCT compensation_id)
      comment: "Total number of compensation records"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary across all compensation records"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary"
    - name: "total_bonus_target"
      expr: SUM(CAST(bonus_target_amount AS DOUBLE))
      comment: "Total bonus target amounts"
    - name: "avg_bonus_target_pct"
      expr: AVG(CAST(bonus_target_percentage AS DOUBLE))
      comment: "Average bonus target as percentage of base"
    - name: "total_compensation_value"
      expr: SUM(CAST(total_compensation_amount AS DOUBLE))
      comment: "Total compensation including base, bonus, and equity"
    - name: "avg_total_compensation"
      expr: AVG(CAST(total_compensation_amount AS DOUBLE))
      comment: "Average total compensation per record"
    - name: "total_equity_grants"
      expr: SUM(CAST(equity_grant_quantity AS DOUBLE))
      comment: "Total equity grant quantity"
    - name: "avg_market_benchmark_percentile"
      expr: AVG(CAST(market_benchmark_percentile AS DOUBLE))
      comment: "Average market benchmark percentile position"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate percentage"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_absence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence and leave management metrics for workforce availability and compliance"
  source: "`gaming_ecm`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_type_code"
      expr: absence_type_code
      comment: "Type of absence"
    - name: "absence_status"
      expr: absence_status
      comment: "Current status of the absence record"
    - name: "absence_reason"
      expr: absence_reason
      comment: "Reason for absence"
    - name: "is_paid"
      expr: is_paid
      comment: "Whether the absence is paid"
    - name: "is_fmla_qualified"
      expr: is_fmla_qualified
      comment: "Whether absence qualifies under FMLA"
    - name: "is_statutory_leave"
      expr: is_statutory_leave
      comment: "Whether absence is statutory leave"
    - name: "medical_certificate_required"
      expr: medical_certificate_required
      comment: "Whether medical certificate is required"
    - name: "medical_certificate_received"
      expr: medical_certificate_received
      comment: "Whether medical certificate was received"
    - name: "absence_year"
      expr: YEAR(start_date)
      comment: "Year the absence started"
    - name: "absence_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the absence started"
  measures:
    - name: "total_absence_records"
      expr: COUNT(DISTINCT absence_record_id)
      comment: "Total number of absence records"
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total days of absence across all records"
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of absence in days"
    - name: "paid_absence_count"
      expr: SUM(CASE WHEN is_paid = TRUE THEN 1 ELSE 0 END)
      comment: "Count of paid absence records"
    - name: "unpaid_absence_count"
      expr: SUM(CASE WHEN is_paid = FALSE THEN 1 ELSE 0 END)
      comment: "Count of unpaid absence records"
    - name: "fmla_qualified_count"
      expr: SUM(CASE WHEN is_fmla_qualified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of FMLA-qualified absences"
    - name: "fmla_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fmla_qualified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(absence_record_id), 0), 2)
      comment: "Percentage of absences that are FMLA-qualified"
    - name: "avg_accrual_balance_after"
      expr: AVG(CAST(accrual_balance_after AS DOUBLE))
      comment: "Average accrual balance remaining after absence"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and capacity metrics for strategic headcount management"
  source: "`gaming_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the plan"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period"
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the headcount plan"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the plan snapshot"
  measures:
    - name: "total_headcount_plans"
      expr: COUNT(DISTINCT headcount_plan_id)
      comment: "Total number of headcount plans"
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte_total AS DOUBLE))
      comment: "Total approved FTE across all plans"
    - name: "total_filled_fte"
      expr: SUM(CAST(current_filled_fte_total AS DOUBLE))
      comment: "Total currently filled FTE"
    - name: "total_capacity_gap_fte"
      expr: SUM(CAST(capacity_gap_fte AS DOUBLE))
      comment: "Total FTE capacity gap (approved minus filled)"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate percentage"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(current_filled_fte_total AS DOUBLE)) / NULLIF(SUM(CAST(approved_fte_total AS DOUBLE)), 0), 2)
      comment: "Percentage of approved FTE that is currently filled"
    - name: "total_approved_engineering_fte"
      expr: SUM(CAST(approved_fte_engineering AS DOUBLE))
      comment: "Total approved engineering FTE"
    - name: "total_approved_art_fte"
      expr: SUM(CAST(approved_fte_art AS DOUBLE))
      comment: "Total approved art FTE"
    - name: "total_approved_design_fte"
      expr: SUM(CAST(approved_fte_design AS DOUBLE))
      comment: "Total approved design FTE"
    - name: "total_approved_qa_fte"
      expr: SUM(CAST(approved_fte_qa AS DOUBLE))
      comment: "Total approved QA FTE"
    - name: "total_contractor_fte_budget"
      expr: SUM(CAST(contractor_fte_budget AS DOUBLE))
      comment: "Total budgeted contractor FTE"
    - name: "total_contractor_fte_actual"
      expr: SUM(CAST(contractor_fte_actual AS DOUBLE))
      comment: "Total actual contractor FTE"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll processing and cost metrics for financial and compliance reporting"
  source: "`gaming_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the payroll run"
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payroll run"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payroll run"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payroll run"
    - name: "pay_group_code"
      expr: pay_group_code
      comment: "Pay group code"
    - name: "payroll_area"
      expr: payroll_area
      comment: "Payroll area"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether this is a reversal run"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment"
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total number of payroll runs"
    - name: "total_employees_processed"
      expr: SUM(CAST(total_employees_processed AS BIGINT))
      comment: "Total employees processed across all runs"
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross pay across all payroll runs"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay across all payroll runs"
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total tax withheld across all payroll runs"
    - name: "total_employee_deductions"
      expr: SUM(CAST(total_employee_deductions AS DOUBLE))
      comment: "Total employee deductions"
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer contributions"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(total_gross_pay AS DOUBLE) / NULLIF(CAST(total_employees_processed AS BIGINT), 0))
      comment: "Average gross pay per employee per run"
    - name: "avg_net_pay_per_employee"
      expr: AVG(CAST(total_net_pay AS DOUBLE) / NULLIF(CAST(total_employees_processed AS BIGINT), 0))
      comment: "Average net pay per employee per run"
    - name: "total_payroll_cost"
      expr: SUM(CAST(total_gross_pay AS DOUBLE) + CAST(total_employer_contributions AS DOUBLE))
      comment: "Total payroll cost including employer contributions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development effectiveness metrics for talent development and compliance"
  source: "`gaming_ecm`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status"
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the course"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of course delivery"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the course is mandatory"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category if applicable"
    - name: "discipline"
      expr: discipline
      comment: "Discipline or functional area"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the training"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT learning_enrollment_id)
      comment: "Total number of learning enrollments"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours across all enrollments"
    - name: "avg_training_hours_per_enrollment"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training hours per enrollment"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(learning_enrollment_id), 0), 2)
      comment: "Percentage of enrollments completed"
    - name: "avg_attendance_pct"
      expr: AVG(CAST(attendance_percentage AS DOUBLE))
      comment: "Average attendance percentage"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average score across all enrollments"
    - name: "avg_feedback_rating"
      expr: AVG(CAST(feedback_rating AS DOUBLE))
      comment: "Average feedback rating from learners"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training across all enrollments"
    - name: "avg_cost_per_enrollment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per enrollment"
    - name: "total_ceu_credits"
      expr: SUM(CAST(ceu_credits AS DOUBLE))
      comment: "Total continuing education units earned"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(score AS DOUBLE) >= CAST(passing_score_threshold AS DOUBLE) THEN 1 ELSE 0 END) / NULLIF(COUNT(learning_enrollment_id), 0), 2)
      comment: "Percentage of enrollments that passed"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`workforce_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate application funnel and conversion metrics for recruitment pipeline analysis"
  source: "`gaming_ecm`.`workforce`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "application_type"
      expr: application_type
      comment: "Type of application"
    - name: "source_channel"
      expr: source_channel
      comment: "Source channel of the application"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment applied for"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of the position"
    - name: "discipline"
      expr: discipline
      comment: "Discipline or functional area"
    - name: "diversity_hire_flag"
      expr: diversity_hire_flag
      comment: "Whether this is a diversity hire"
    - name: "referral_bonus_eligible"
      expr: referral_bonus_eligible
      comment: "Whether referral bonus is eligible"
    - name: "assessment_completed"
      expr: assessment_completed
      comment: "Whether assessment was completed"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of application submission"
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total number of applications"
    - name: "unique_candidates"
      expr: COUNT(DISTINCT candidate_id)
      comment: "Total unique candidates who applied"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score"
    - name: "avg_screening_score"
      expr: AVG(CAST(screening_score AS DOUBLE))
      comment: "Average screening score"
    - name: "offer_extended_count"
      expr: SUM(CASE WHEN offer_extended_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of applications with offers extended"
    - name: "offer_accepted_count"
      expr: SUM(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of applications with offers accepted"
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN offer_extended_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of offers that were accepted"
    - name: "assessment_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN assessment_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(application_id), 0), 2)
      comment: "Percentage of applications with completed assessments"
    - name: "avg_time_to_offer_days"
      expr: AVG(DATEDIFF(offer_extended_date, submission_timestamp))
      comment: "Average days from application submission to offer extended"
$$;