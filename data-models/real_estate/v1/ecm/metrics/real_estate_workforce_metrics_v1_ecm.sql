-- Metric views for domain: workforce | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, compensation, tenure, and workforce composition analysis"
  source: "`real_estate_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (full-time, part-time, contractor, etc.)"
    - name: "department_name"
      expr: department_name
      comment: "Department to which employee is assigned"
    - name: "job_title"
      expr: job_title
      comment: "Employee job title"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt or non-exempt classification"
    - name: "workforce_segment"
      expr: workforce_segment
      comment: "Workforce segment categorization"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Type of work location (office, remote, hybrid, field)"
    - name: "eeo_category"
      expr: eeo_category
      comment: "EEO job category for compliance reporting"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month employee was hired"
    - name: "benefits_eligible"
      expr: benefits_eligible
      comment: "Whether employee is eligible for benefits"
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether employee is eligible for commission"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary across all employees"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary per employee"
    - name: "avg_pto_balance_days"
      expr: AVG(CAST(pto_balance_days AS DOUBLE))
      comment: "Average PTO balance in days across employees"
    - name: "total_pto_liability_days"
      expr: SUM(CAST(pto_balance_days AS DOUBLE))
      comment: "Total PTO liability in days across all employees"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll processing and labor cost metrics including gross earnings, deductions, taxes, and net pay analysis"
  source: "`real_estate_ecm`.`workforce`.`payroll`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period"
    - name: "pay_date"
      expr: pay_date
      comment: "Date payroll was paid"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (weekly, bi-weekly, monthly, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for payroll record"
    - name: "run_status"
      expr: run_status
      comment: "Status of payroll run (draft, approved, processed, etc.)"
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, off-cycle, bonus, etc.)"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for payroll record"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State code where work was performed"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (direct deposit, check, etc.)"
    - name: "gl_posted_flag"
      expr: gl_posted_flag
      comment: "Whether payroll has been posted to general ledger"
  measures:
    - name: "total_gross_earnings"
      expr: SUM(CAST(gross_earnings AS DOUBLE))
      comment: "Total gross earnings before deductions and taxes"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay after all deductions and taxes"
    - name: "total_base_salary_earnings"
      expr: SUM(CAST(base_salary_earnings AS DOUBLE))
      comment: "Total base salary component of earnings"
    - name: "total_overtime_earnings"
      expr: SUM(CAST(overtime_earnings AS DOUBLE))
      comment: "Total overtime earnings"
    - name: "total_bonus_earnings"
      expr: SUM(CAST(bonus_earnings AS DOUBLE))
      comment: "Total bonus earnings"
    - name: "total_commission_earnings"
      expr: SUM(CAST(commission_earnings AS DOUBLE))
      comment: "Total commission earnings"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_income_tax_withheld AS DOUBLE))
      comment: "Total federal income tax withheld"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_income_tax_withheld AS DOUBLE))
      comment: "Total state income tax withheld"
    - name: "total_social_security_tax"
      expr: SUM(CAST(social_security_tax_withheld AS DOUBLE))
      comment: "Total social security tax withheld"
    - name: "total_medicare_tax"
      expr: SUM(CAST(medicare_tax_withheld AS DOUBLE))
      comment: "Total Medicare tax withheld"
    - name: "total_employer_tax_liability"
      expr: SUM(CAST(employer_tax_liability AS DOUBLE))
      comment: "Total employer tax liability"
    - name: "total_pretax_deductions"
      expr: SUM(CAST(pretax_deductions_total AS DOUBLE))
      comment: "Total pre-tax deductions (401k, health insurance, etc.)"
    - name: "total_posttax_deductions"
      expr: SUM(CAST(posttax_deductions_total AS DOUBLE))
      comment: "Total post-tax deductions"
    - name: "avg_gross_earnings"
      expr: AVG(CAST(gross_earnings AS DOUBLE))
      comment: "Average gross earnings per payroll record"
    - name: "avg_net_pay"
      expr: AVG(CAST(net_pay AS DOUBLE))
      comment: "Average net pay per payroll record"
    - name: "payroll_record_count"
      expr: COUNT(DISTINCT payroll_id)
      comment: "Total number of payroll records processed"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_commission_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission tracking and sales compensation metrics including gross commission, splits, clawbacks, and payment status"
  source: "`real_estate_ecm`.`workforce`.`commission_record`"
  dimensions:
    - name: "commission_event_type"
      expr: commission_event_type
      comment: "Type of commission event (sale, lease, renewal, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of commission payment (pending, approved, paid, clawed back)"
    - name: "commission_period_start_date"
      expr: commission_period_start_date
      comment: "Start date of commission period"
    - name: "commission_period_end_date"
      expr: commission_period_end_date
      comment: "End date of commission period"
    - name: "deal_close_date"
      expr: deal_close_date
      comment: "Date the deal closed"
    - name: "payment_date"
      expr: payment_date
      comment: "Date commission was paid"
    - name: "approval_date"
      expr: approval_date
      comment: "Date commission was approved"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for commission"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (W2, 1099, etc.)"
    - name: "co_broker_flag"
      expr: co_broker_flag
      comment: "Whether commission involves a co-broker"
    - name: "draw_plan_flag"
      expr: draw_plan_flag
      comment: "Whether commission is part of a draw plan"
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Whether commission is 1099 reportable"
    - name: "gl_posted_flag"
      expr: gl_posted_flag
      comment: "Whether commission has been posted to general ledger"
    - name: "clawback_reason"
      expr: clawback_reason
      comment: "Reason for commission clawback if applicable"
  measures:
    - name: "total_gross_commission"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission amount before splits and deductions"
    - name: "total_net_commission"
      expr: SUM(CAST(net_commission_amount AS DOUBLE))
      comment: "Total net commission amount after splits and deductions"
    - name: "total_payable_amount"
      expr: SUM(CAST(payable_amount AS DOUBLE))
      comment: "Total amount payable to commission recipients"
    - name: "total_deal_transaction_value"
      expr: SUM(CAST(deal_transaction_value AS DOUBLE))
      comment: "Total transaction value of deals generating commissions"
    - name: "total_draw_balance_offset"
      expr: SUM(CAST(draw_balance_offset AS DOUBLE))
      comment: "Total draw balance offset against commissions"
    - name: "total_outstanding_draw_balance"
      expr: SUM(CAST(outstanding_draw_balance AS DOUBLE))
      comment: "Total outstanding draw balance across all commission records"
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage"
    - name: "avg_split_pct"
      expr: AVG(CAST(split_pct AS DOUBLE))
      comment: "Average commission split percentage"
    - name: "commission_record_count"
      expr: COUNT(DISTINCT commission_record_id)
      comment: "Total number of commission records"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_recruiting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting and talent acquisition metrics including requisition status, time-to-fill, applicant volume, and hiring effectiveness"
  source: "`real_estate_ecm`.`workforce`.`recruiting`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of requisition (open, filled, cancelled, on-hold)"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new hire, backfill, expansion)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for position (full-time, part-time, contractor)"
    - name: "job_title"
      expr: job_title
      comment: "Job title for requisition"
    - name: "job_family"
      expr: job_family
      comment: "Job family categorization"
    - name: "workforce_segment"
      expr: workforce_segment
      comment: "Workforce segment for requisition"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of requisition (critical, high, medium, low)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of requisition"
    - name: "primary_sourcing_channel"
      expr: primary_sourcing_channel
      comment: "Primary channel for sourcing candidates"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Type of work location (office, remote, hybrid)"
    - name: "open_date"
      expr: open_date
      comment: "Date requisition was opened"
    - name: "target_fill_date"
      expr: target_fill_date
      comment: "Target date to fill requisition"
    - name: "filled_date"
      expr: filled_date
      comment: "Date requisition was filled"
    - name: "internal_posting_flag"
      expr: internal_posting_flag
      comment: "Whether requisition is posted internally only"
    - name: "re_license_required"
      expr: re_license_required
      comment: "Whether real estate license is required"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruiting_id)
      comment: "Total number of recruiting requisitions"
    - name: "total_budget_salary_max"
      expr: SUM(CAST(budget_salary_max AS DOUBLE))
      comment: "Total maximum budgeted salary across all requisitions"
    - name: "total_budget_salary_min"
      expr: SUM(CAST(budget_salary_min AS DOUBLE))
      comment: "Total minimum budgeted salary across all requisitions"
    - name: "avg_budget_salary_max"
      expr: AVG(CAST(budget_salary_max AS DOUBLE))
      comment: "Average maximum budgeted salary per requisition"
    - name: "avg_budget_salary_min"
      expr: AVG(CAST(budget_salary_min AS DOUBLE))
      comment: "Average minimum budgeted salary per requisition"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time tracking and labor utilization metrics including regular hours, overtime, labor costs, and productivity analysis"
  source: "`real_estate_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date work was performed"
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of pay period"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entry (pending, approved, rejected)"
    - name: "entry_method"
      expr: entry_method
      comment: "Method of time entry (manual, clock, mobile, etc.)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift worked"
    - name: "pay_code"
      expr: pay_code
      comment: "Pay code for time entry"
    - name: "cost_allocation_type"
      expr: cost_allocation_type
      comment: "Type of cost allocation (direct, indirect, overhead)"
    - name: "department_code"
      expr: department_code
      comment: "Department code for time entry"
    - name: "work_location_code"
      expr: work_location_code
      comment: "Work location code"
    - name: "is_amended"
      expr: is_amended
      comment: "Whether time entry has been amended"
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all categories"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost for time entries"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across time entries"
    - name: "time_entry_count"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Total number of time entries"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics including ratings, merit increases, promotion recommendations, and talent development tracking"
  source: "`real_estate_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of performance review (draft, in-progress, completed, calibrated)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probationary, project-based)"
    - name: "review_cycle_name"
      expr: review_cycle_name
      comment: "Name of review cycle"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category"
    - name: "goal_rating"
      expr: goal_rating
      comment: "Goal achievement rating category"
    - name: "competency_rating"
      expr: competency_rating
      comment: "Competency rating category"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of review"
    - name: "retention_risk"
      expr: retention_risk
      comment: "Retention risk level (low, medium, high, critical)"
    - name: "succession_readiness"
      expr: succession_readiness
      comment: "Succession readiness level"
    - name: "workforce_segment"
      expr: workforce_segment
      comment: "Workforce segment for review"
    - name: "review_period_start_date"
      expr: review_period_start_date
      comment: "Start date of review period"
    - name: "review_period_end_date"
      expr: review_period_end_date
      comment: "End date of review period"
    - name: "merit_increase_recommended"
      expr: merit_increase_recommended
      comment: "Whether merit increase was recommended"
    - name: "bonus_recommended"
      expr: bonus_recommended
      comment: "Whether bonus was recommended"
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Whether promotion was recommended"
    - name: "pip_indicator"
      expr: pip_indicator
      comment: "Whether employee is on performance improvement plan"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall rating score"
    - name: "avg_goal_rating_score"
      expr: AVG(CAST(goal_rating_score AS DOUBLE))
      comment: "Average goal rating score"
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_pct AS DOUBLE))
      comment: "Average merit increase percentage"
    - name: "total_bonus_recommended_amount"
      expr: SUM(CAST(bonus_recommended_amount AS DOUBLE))
      comment: "Total recommended bonus amount across all reviews"
    - name: "avg_bonus_recommended_amount"
      expr: AVG(CAST(bonus_recommended_amount AS DOUBLE))
      comment: "Average recommended bonus amount per review"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics including FMLA tracking, leave duration, approval rates, and workforce availability impact"
  source: "`real_estate_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_status"
      expr: leave_status
      comment: "Status of leave request (pending, approved, denied, active, completed)"
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, medical, parental, personal, etc.)"
    - name: "leave_reason"
      expr: leave_reason
      comment: "Reason for leave"
    - name: "requested_start_date"
      expr: requested_start_date
      comment: "Requested start date of leave"
    - name: "requested_end_date"
      expr: requested_end_date
      comment: "Requested end date of leave"
    - name: "approved_start_date"
      expr: approved_start_date
      comment: "Approved start date of leave"
    - name: "approved_end_date"
      expr: approved_end_date
      comment: "Approved end date of leave"
    - name: "fmla_designated"
      expr: fmla_designated
      comment: "Whether leave is designated as FMLA"
    - name: "fmla_eligible"
      expr: fmla_eligible
      comment: "Whether employee is FMLA eligible"
    - name: "paid_leave"
      expr: paid_leave
      comment: "Whether leave is paid"
    - name: "intermittent_leave"
      expr: intermittent_leave
      comment: "Whether leave is intermittent"
    - name: "medical_certification_required"
      expr: medical_certification_required
      comment: "Whether medical certification is required"
    - name: "medical_certification_received"
      expr: medical_certification_received
      comment: "Whether medical certification has been received"
    - name: "benefits_continuation"
      expr: benefits_continuation
      comment: "Whether benefits continue during leave"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total number of leave requests"
    - name: "avg_fmla_hours_used"
      expr: AVG(CAST(fmla_hours_used AS DOUBLE))
      comment: "Average FMLA hours used per leave request"
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "Total FMLA hours used across all leave requests"
    - name: "total_employee_premium_owed"
      expr: SUM(CAST(employee_premium_owed AS DOUBLE))
      comment: "Total employee premium owed during leave"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_license_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional license and certification compliance metrics including expiration tracking, renewal status, and credential verification"
  source: "`real_estate_ecm`.`workforce`.`license_certification`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (license, certification, designation)"
    - name: "credential_status"
      expr: credential_status
      comment: "Status of credential (active, expired, suspended, pending)"
    - name: "credential_name"
      expr: credential_name
      comment: "Name of credential"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for credential"
    - name: "jurisdiction_country"
      expr: jurisdiction_country
      comment: "Country jurisdiction for credential"
    - name: "issue_date"
      expr: issue_date
      comment: "Date credential was issued"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date credential expires"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of credential"
    - name: "is_primary_credential"
      expr: is_primary_credential
      comment: "Whether this is the primary credential for the employee"
    - name: "is_company_sponsored"
      expr: is_company_sponsored
      comment: "Whether credential is company-sponsored"
    - name: "primary_practice_area"
      expr: primary_practice_area
      comment: "Primary practice area for credential"
  measures:
    - name: "total_credentials"
      expr: COUNT(DISTINCT license_certification_id)
      comment: "Total number of licenses and certifications"
    - name: "avg_ce_hours_completed"
      expr: AVG(CAST(ce_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed"
    - name: "avg_ce_hours_required"
      expr: AVG(CAST(ce_hours_required AS DOUBLE))
      comment: "Average continuing education hours required"
    - name: "total_ce_hours_completed"
      expr: SUM(CAST(ce_hours_completed AS DOUBLE))
      comment: "Total continuing education hours completed"
    - name: "total_ce_hours_required"
      expr: SUM(CAST(ce_hours_required AS DOUBLE))
      comment: "Total continuing education hours required"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training participation and completion metrics including enrollment status, completion rates, assessment scores, and training costs"
  source: "`real_estate_ecm`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of training enrollment (enrolled, in-progress, completed, withdrawn, failed)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (mandatory, voluntary, recommended)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (online, in-person, virtual, hybrid)"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category for training"
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date of enrollment"
    - name: "completion_date"
      expr: completion_date
      comment: "Date training was completed"
    - name: "due_date"
      expr: due_date
      comment: "Due date for training completion"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether training is mandatory"
    - name: "is_overdue"
      expr: is_overdue
      comment: "Whether training is overdue"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether training was waived"
    - name: "training_provider"
      expr: training_provider
      comment: "Provider of training"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body for training"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total number of training enrollments"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across enrollments"
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold"
    - name: "avg_time_spent_hours"
      expr: AVG(CAST(time_spent_hours AS DOUBLE))
      comment: "Average time spent on training in hours"
    - name: "total_time_spent_hours"
      expr: SUM(CAST(time_spent_hours AS DOUBLE))
      comment: "Total time spent on training in hours"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training cost across all enrollments"
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average training cost per enrollment"
    - name: "avg_ce_hours_earned"
      expr: AVG(CAST(ce_hours_earned AS DOUBLE))
      comment: "Average continuing education hours earned"
    - name: "total_ce_hours_earned"
      expr: SUM(CAST(ce_hours_earned AS DOUBLE))
      comment: "Total continuing education hours earned"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and budgeting metrics including planned vs actual headcount, labor cost variance, and succession planning readiness"
  source: "`real_estate_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of headcount plan (draft, submitted, approved, rejected, active)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (annual, quarterly, project-based)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for plan"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for plan"
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of planning period"
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of planning period"
    - name: "workforce_segment"
      expr: workforce_segment
      comment: "Workforce segment for plan"
    - name: "critical_role_flag"
      expr: critical_role_flag
      comment: "Whether plan includes critical roles"
    - name: "retention_risk_level"
      expr: retention_risk_level
      comment: "Retention risk level for planned headcount"
    - name: "succession_readiness_level"
      expr: succession_readiness_level
      comment: "Succession readiness level"
    - name: "opex_capex_classification"
      expr: opex_capex_classification
      comment: "OPEX or CAPEX classification for labor costs"
  measures:
    - name: "total_budgeted_headcount_fte"
      expr: SUM(CAST(budgeted_headcount_fte AS DOUBLE))
      comment: "Total budgeted headcount in FTE"
    - name: "total_actual_filled_fte"
      expr: SUM(CAST(actual_filled_fte AS DOUBLE))
      comment: "Total actual filled headcount in FTE"
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost AS DOUBLE))
      comment: "Total budgeted labor cost"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost"
    - name: "total_labor_cost_variance"
      expr: SUM(CAST(labor_cost_variance AS DOUBLE))
      comment: "Total labor cost variance (actual vs budget)"
    - name: "avg_budgeted_headcount_fte"
      expr: AVG(CAST(budgeted_headcount_fte AS DOUBLE))
      comment: "Average budgeted headcount in FTE per plan"
    - name: "avg_actual_filled_fte"
      expr: AVG(CAST(actual_filled_fte AS DOUBLE))
      comment: "Average actual filled headcount in FTE per plan"
    - name: "headcount_plan_count"
      expr: COUNT(DISTINCT headcount_plan_id)
      comment: "Total number of headcount plans"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits enrollment and cost metrics including employee and employer contributions, coverage tiers, and enrollment events"
  source: "`real_estate_ecm`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of benefit enrollment (active, pending, terminated, waived)"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event (new hire, open enrollment, qualifying event, etc.)"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family, etc.)"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for enrollment"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of enrollment"
    - name: "termination_date"
      expr: termination_date
      comment: "Termination date of enrollment"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for enrollment"
    - name: "cobra_eligible"
      expr: cobra_eligible
      comment: "Whether enrollment is COBRA eligible"
    - name: "has_dependent_coverage"
      expr: has_dependent_coverage
      comment: "Whether enrollment includes dependent coverage"
    - name: "waiver_indicator"
      expr: waiver_indicator
      comment: "Whether benefit was waived"
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying event if applicable"
    - name: "aca_offer_type_code"
      expr: aca_offer_type_code
      comment: "ACA offer type code"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT benefit_enrollment_id)
      comment: "Total number of benefit enrollments"
    - name: "total_annual_employee_cost"
      expr: SUM(CAST(annual_employee_cost AS DOUBLE))
      comment: "Total annual employee cost for benefits"
    - name: "total_annual_employer_cost"
      expr: SUM(CAST(annual_employer_cost AS DOUBLE))
      comment: "Total annual employer cost for benefits"
    - name: "avg_annual_employee_cost"
      expr: AVG(CAST(annual_employee_cost AS DOUBLE))
      comment: "Average annual employee cost per enrollment"
    - name: "avg_annual_employer_cost"
      expr: AVG(CAST(annual_employer_cost AS DOUBLE))
      comment: "Average annual employer cost per enrollment"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution amount"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount"
    - name: "total_fsa_election"
      expr: SUM(CAST(fsa_election_amount AS DOUBLE))
      comment: "Total FSA election amount"
    - name: "total_hsa_contribution"
      expr: SUM(CAST(hsa_contribution_amount AS DOUBLE))
      comment: "Total HSA contribution amount"
    - name: "total_life_insurance_coverage"
      expr: SUM(CAST(life_insurance_coverage_amount AS DOUBLE))
      comment: "Total life insurance coverage amount"
$$;