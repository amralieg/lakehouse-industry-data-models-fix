-- Metric views for domain: hr | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, tenure, and demographic distribution for strategic workforce planning and compliance reporting"
  source: "`education_ecm`.`hr`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type classification (full-time, part-time, temporary, etc.)"
    - name: "worker_type"
      expr: worker_type
      comment: "Worker type classification (employee, contractor, etc.)"
    - name: "department_code"
      expr: department_code
      comment: "Department code for organizational grouping"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial allocation"
    - name: "job_title"
      expr: job_title
      comment: "Current job title of employee"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt, non-exempt) for compliance"
    - name: "eeo_category"
      expr: eeo_category
      comment: "EEO job category for regulatory reporting"
    - name: "gender"
      expr: gender
      comment: "Gender for diversity reporting"
    - name: "race_ethnicity_code"
      expr: race_ethnicity_code
      comment: "Race/ethnicity code for diversity and compliance reporting"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for compliance reporting"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for ADA compliance"
    - name: "remote_work_type"
      expr: remote_work_type
      comment: "Remote work arrangement type"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month employee was hired"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count for workforce sizing"
    - name: "total_fte"
      expr: SUM(CAST(fte_percent AS DOUBLE) / 100.0)
      comment: "Total full-time equivalent workforce capacity"
    - name: "avg_fte_percent"
      expr: AVG(CAST(fte_percent AS DOUBLE))
      comment: "Average FTE percentage across employees"
    - name: "total_annual_salary"
      expr: SUM(CAST(annual_salary AS DOUBLE))
      comment: "Total annual salary expense across all employees"
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary per employee"
    - name: "benefits_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN benefits_eligible = True THEN employee_id END)
      comment: "Count of employees eligible for benefits"
    - name: "rehire_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible = True THEN employee_id END)
      comment: "Count of employees eligible for rehire"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_employee_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation change and equity metrics for pay equity analysis, merit planning, and compensation strategy"
  source: "`education_ecm`.`hr`.`employee_compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation event"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for compensation change"
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification at time of compensation event"
    - name: "job_family"
      expr: job_family
      comment: "Job family for compensation benchmarking"
    - name: "employee_category"
      expr: employee_category
      comment: "Employee category for compensation analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year compensation change became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month compensation change became effective"
    - name: "is_equity_adjustment"
      expr: is_equity_adjustment
      comment: "Flag indicating if change was for pay equity"
    - name: "is_market_adjustment"
      expr: is_market_adjustment
      comment: "Flag indicating if change was for market competitiveness"
  measures:
    - name: "total_compensation_events"
      expr: COUNT(DISTINCT employee_compensation_id)
      comment: "Total number of compensation change events"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary across all compensation records"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per compensation record"
    - name: "avg_compa_ratio"
      expr: AVG(CAST(compa_ratio AS DOUBLE))
      comment: "Average compa-ratio indicating pay positioning vs midpoint"
    - name: "avg_range_penetration"
      expr: AVG(CAST(range_penetration AS DOUBLE))
      comment: "Average range penetration showing position within pay range"
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_amount AS DOUBLE))
      comment: "Total merit increase dollars awarded"
    - name: "avg_merit_increase_percent"
      expr: AVG(CAST(merit_increase_percent AS DOUBLE))
      comment: "Average merit increase percentage"
    - name: "total_salary_change_amount"
      expr: SUM(CAST(salary_change_amount AS DOUBLE))
      comment: "Total salary change dollars across all events"
    - name: "avg_salary_change_percent"
      expr: AVG(CAST(salary_change_percent AS DOUBLE))
      comment: "Average salary change percentage"
    - name: "equity_adjustment_count"
      expr: COUNT(DISTINCT CASE WHEN is_equity_adjustment = True THEN employee_compensation_id END)
      comment: "Count of compensation changes made for pay equity"
    - name: "market_adjustment_count"
      expr: COUNT(DISTINCT CASE WHEN is_market_adjustment = True THEN employee_compensation_id END)
      comment: "Count of compensation changes made for market competitiveness"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_staffing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce movement and turnover metrics for retention analysis, hiring effectiveness, and organizational change management"
  source: "`education_ecm`.`hr`.`staffing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of staffing event (hire, termination, transfer, promotion, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for staffing event"
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (voluntary, involuntary, retirement, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type at time of event"
    - name: "event_status"
      expr: event_status
      comment: "Status of staffing event"
    - name: "event_year"
      expr: YEAR(effective_date)
      comment: "Year staffing event became effective"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month staffing event became effective"
    - name: "rehire_eligible"
      expr: rehire_eligible
      comment: "Flag indicating if employee is eligible for rehire"
  measures:
    - name: "total_staffing_events"
      expr: COUNT(DISTINCT staffing_event_id)
      comment: "Total number of staffing events"
    - name: "total_new_fte"
      expr: SUM(CAST(new_fte AS DOUBLE))
      comment: "Total new FTE from staffing events"
    - name: "avg_new_annual_salary"
      expr: AVG(CAST(new_annual_salary AS DOUBLE))
      comment: "Average new annual salary from staffing events"
    - name: "avg_salary_change_percent"
      expr: AVG(CAST(salary_change_pct AS DOUBLE))
      comment: "Average salary change percentage for staffing events"
    - name: "rehire_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible = True THEN staffing_event_id END)
      comment: "Count of separations where employee is eligible for rehire"
    - name: "orientation_completed_count"
      expr: COUNT(DISTINCT CASE WHEN orientation_completed = True THEN staffing_event_id END)
      comment: "Count of new hires who completed orientation"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment effectiveness and time-to-fill metrics for talent acquisition strategy and hiring efficiency"
  source: "`education_ecm`.`hr`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of recruitment requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new position, replacement, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for requisition"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification for position"
    - name: "eeo_job_category"
      expr: eeo_job_category
      comment: "EEO job category for compliance reporting"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (on-site, remote, hybrid)"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year requisition was posted"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month requisition was posted"
    - name: "is_confidential_search"
      expr: is_confidential_search
      comment: "Flag indicating if search is confidential"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total number of recruitment requisitions"
    - name: "total_openings"
      expr: SUM(CAST(number_of_openings AS BIGINT))
      comment: "Total number of open positions across all requisitions"
    - name: "total_positions_filled"
      expr: SUM(CAST(positions_filled_count AS BIGINT))
      comment: "Total number of positions filled"
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Total approved FTE across all requisitions"
    - name: "avg_salary_range_min"
      expr: AVG(CAST(salary_range_min AS DOUBLE))
      comment: "Average minimum salary range for requisitions"
    - name: "avg_salary_range_max"
      expr: AVG(CAST(salary_range_max AS DOUBLE))
      comment: "Average maximum salary range for requisitions"
    - name: "avg_salary_range_midpoint"
      expr: AVG(CAST(salary_range_midpoint AS DOUBLE))
      comment: "Average midpoint salary range for requisitions"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_payroll_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and tax metrics for labor cost analysis, budget management, and financial planning"
  source: "`education_ecm`.`hr`.`payroll_result`"
  dimensions:
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (weekly, biweekly, monthly, etc.)"
    - name: "pay_group"
      expr: pay_group
      comment: "Pay group classification"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (direct deposit, check, etc.)"
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, off-cycle, bonus, etc.)"
    - name: "run_status"
      expr: run_status
      comment: "Status of payroll run"
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Pay rate type (hourly, salary, etc.)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation"
    - name: "fund_code"
      expr: fund_code
      comment: "Fund code for financial tracking"
    - name: "pay_period_year"
      expr: YEAR(pay_period_end_date)
      comment: "Year of pay period end"
    - name: "pay_period_month"
      expr: DATE_TRUNC('MONTH', pay_period_end_date)
      comment: "Month of pay period end"
    - name: "is_supplemental_wage"
      expr: is_supplemental_wage
      comment: "Flag indicating if payment is supplemental wage"
  measures:
    - name: "total_payroll_records"
      expr: COUNT(DISTINCT payroll_result_id)
      comment: "Total number of payroll records processed"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay before deductions"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after all deductions"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all employees"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate per payroll record"
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
    - name: "total_employer_retirement"
      expr: SUM(CAST(employer_retirement_contribution AS DOUBLE))
      comment: "Total employer retirement contributions"
    - name: "total_retirement_deduction"
      expr: SUM(CAST(retirement_deduction_amount AS DOUBLE))
      comment: "Total employee retirement deductions"
    - name: "total_benefit_deduction"
      expr: SUM(CAST(benefit_deduction_amount AS DOUBLE))
      comment: "Total benefit deductions from employee pay"
    - name: "total_employer_taxes"
      expr: SUM(CAST(employer_social_security_tax AS DOUBLE) + CAST(employer_medicare_tax AS DOUBLE))
      comment: "Total employer payroll taxes (Social Security + Medicare)"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_absence_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and FMLA compliance metrics for workforce planning, absence management, and regulatory compliance"
  source: "`education_ecm`.`hr`.`absence_event`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (sick, vacation, FMLA, etc.)"
    - name: "leave_reason"
      expr: leave_reason
      comment: "Reason for leave"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of leave request"
    - name: "leave_pay_type"
      expr: leave_pay_type
      comment: "Pay type for leave (paid, unpaid, partial)"
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of leave event"
    - name: "is_fmla_designated"
      expr: is_fmla_designated
      comment: "Flag indicating if leave is FMLA-designated"
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Flag indicating if leave is intermittent"
    - name: "leave_start_year"
      expr: YEAR(leave_start_date)
      comment: "Year leave started"
    - name: "leave_start_month"
      expr: DATE_TRUNC('MONTH', leave_start_date)
      comment: "Month leave started"
  measures:
    - name: "total_absence_events"
      expr: COUNT(DISTINCT absence_event_id)
      comment: "Total number of absence events"
    - name: "total_requested_hours"
      expr: SUM(CAST(requested_hours AS DOUBLE))
      comment: "Total hours requested for leave"
    - name: "total_approved_hours"
      expr: SUM(CAST(approved_hours AS DOUBLE))
      comment: "Total hours approved for leave"
    - name: "total_used_hours"
      expr: SUM(CAST(used_hours AS DOUBLE))
      comment: "Total hours actually used for leave"
    - name: "total_leave_duration_days"
      expr: SUM(CAST(leave_duration_days AS DOUBLE))
      comment: "Total leave duration in days"
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(leave_duration_days AS DOUBLE))
      comment: "Average leave duration in days per event"
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used_ytd AS DOUBLE))
      comment: "Total FMLA hours used year-to-date"
    - name: "total_fmla_hours_remaining"
      expr: SUM(CAST(fmla_hours_remaining AS DOUBLE))
      comment: "Total FMLA hours remaining"
    - name: "total_fte_impact"
      expr: SUM(CAST(fte_impact AS DOUBLE))
      comment: "Total FTE impact from absences"
    - name: "fmla_designated_count"
      expr: COUNT(DISTINCT CASE WHEN is_fmla_designated = True THEN absence_event_id END)
      comment: "Count of FMLA-designated leave events"
    - name: "intermittent_leave_count"
      expr: COUNT(DISTINCT CASE WHEN is_intermittent = True THEN absence_event_id END)
      comment: "Count of intermittent leave events"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management and talent development metrics for succession planning, merit allocation, and workforce quality"
  source: "`education_ecm`.`hr`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary, etc.)"
    - name: "review_status"
      expr: review_status
      comment: "Status of performance review"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating"
    - name: "competency_rating"
      expr: competency_rating
      comment: "Competency rating"
    - name: "goal_achievement_rating"
      expr: goal_achievement_rating
      comment: "Goal achievement rating"
    - name: "leadership_rating"
      expr: leadership_rating
      comment: "Leadership rating"
    - name: "calibrated_overall_rating"
      expr: calibrated_overall_rating
      comment: "Calibrated overall rating after calibration process"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of calibration process"
    - name: "talent_segment"
      expr: talent_segment
      comment: "Talent segment classification (high performer, solid performer, etc.)"
    - name: "review_year"
      expr: YEAR(review_period_end_date)
      comment: "Year of review period end"
    - name: "merit_eligible"
      expr: merit_eligible
      comment: "Flag indicating if employee is eligible for merit increase"
    - name: "pip_required"
      expr: pip_required
      comment: "Flag indicating if performance improvement plan is required"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews"
    - name: "avg_overall_rating_numeric"
      expr: AVG(CAST(overall_rating_numeric AS DOUBLE))
      comment: "Average numeric overall performance rating"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_pct AS DOUBLE))
      comment: "Average merit increase percentage awarded"
    - name: "total_goals_count"
      expr: SUM(CAST(goals_count AS BIGINT))
      comment: "Total number of goals set"
    - name: "total_goals_met_count"
      expr: SUM(CAST(goals_met_count AS BIGINT))
      comment: "Total number of goals met"
    - name: "merit_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN merit_eligible = True THEN performance_review_id END)
      comment: "Count of reviews where employee is merit-eligible"
    - name: "pip_required_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = True THEN performance_review_id END)
      comment: "Count of reviews requiring performance improvement plan"
    - name: "self_assessment_completed_count"
      expr: COUNT(DISTINCT CASE WHEN self_assessment_completed = True THEN performance_review_id END)
      comment: "Count of reviews with completed self-assessment"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and cost metrics for benefits strategy, cost management, and employee value proposition"
  source: "`education_ecm`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit (health, dental, vision, retirement, etc.)"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of benefit enrollment"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family, etc.)"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of enrollment"
    - name: "election_source"
      expr: election_source
      comment: "Source of enrollment election (open enrollment, new hire, QLE, etc.)"
    - name: "is_waived"
      expr: is_waived
      comment: "Flag indicating if benefit was waived"
    - name: "is_pretax"
      expr: is_pretax
      comment: "Flag indicating if contribution is pre-tax"
    - name: "cobra_eligible"
      expr: cobra_eligible
      comment: "Flag indicating if enrollment is COBRA-eligible"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT benefit_enrollment_id)
      comment: "Total number of benefit enrollments"
    - name: "total_employee_premium"
      expr: SUM(CAST(annual_employee_premium AS DOUBLE))
      comment: "Total annual employee premium contributions"
    - name: "total_employer_premium"
      expr: SUM(CAST(annual_employer_premium AS DOUBLE))
      comment: "Total annual employer premium contributions"
    - name: "avg_employee_premium"
      expr: AVG(CAST(annual_employee_premium AS DOUBLE))
      comment: "Average annual employee premium per enrollment"
    - name: "avg_employer_premium"
      expr: AVG(CAST(annual_employer_premium AS DOUBLE))
      comment: "Average annual employer premium per enrollment"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution amount"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount"
    - name: "waived_count"
      expr: COUNT(DISTINCT CASE WHEN is_waived = True THEN benefit_enrollment_id END)
      comment: "Count of benefits waived by employees"
    - name: "cobra_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN cobra_eligible = True THEN benefit_enrollment_id END)
      comment: "Count of COBRA-eligible enrollments"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position budget and authorization metrics for workforce planning, budget management, and organizational design"
  source: "`education_ecm`.`hr`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Status of position (active, frozen, eliminated, etc.)"
    - name: "position_type"
      expr: position_type
      comment: "Type of position (regular, temporary, grant-funded, etc.)"
    - name: "employee_category"
      expr: employee_category
      comment: "Employee category for position"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification of position"
    - name: "eeo_category"
      expr: eeo_category
      comment: "EEO category for compliance reporting"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade of position"
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for position"
    - name: "is_benefits_eligible"
      expr: is_benefits_eligible
      comment: "Flag indicating if position is benefits-eligible"
    - name: "is_critical_position"
      expr: is_critical_position
      comment: "Flag indicating if position is critical to operations"
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Flag indicating if position is remote-eligible"
  measures:
    - name: "total_positions"
      expr: COUNT(DISTINCT position_id)
      comment: "Total number of positions"
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocation across all positions"
    - name: "avg_fte_allocation"
      expr: AVG(CAST(fte_allocation AS DOUBLE))
      comment: "Average FTE allocation per position"
    - name: "total_budgeted_salary"
      expr: SUM(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Total budgeted annual salary across all positions"
    - name: "avg_budgeted_salary"
      expr: AVG(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Average budgeted annual salary per position"
    - name: "avg_salary_midpoint"
      expr: AVG(CAST(salary_midpoint AS DOUBLE))
      comment: "Average salary midpoint for positions"
    - name: "critical_position_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_position = True THEN position_id END)
      comment: "Count of critical positions"
    - name: "remote_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN is_remote_eligible = True THEN position_id END)
      comment: "Count of remote-eligible positions"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`hr_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion and compliance metrics for workforce development, regulatory compliance, and skill gap analysis"
  source: "`education_ecm`.`hr`.`training_record`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Status of training (completed, in progress, not started, etc.)"
    - name: "training_type"
      expr: training_type
      comment: "Type of training"
    - name: "training_category"
      expr: training_category
      comment: "Category of training"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (online, in-person, hybrid, etc.)"
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Flag indicating if training is compliance-required"
    - name: "passed_flag"
      expr: passed_flag
      comment: "Flag indicating if employee passed training"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Flag indicating if certificate was issued"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month training was completed"
  measures:
    - name: "total_training_records"
      expr: COUNT(DISTINCT training_record_id)
      comment: "Total number of training records"
    - name: "total_contact_hours"
      expr: SUM(CAST(contact_hours AS DOUBLE))
      comment: "Total contact hours of training delivered"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours earned from training"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training score"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training programs"
    - name: "avg_training_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training record"
    - name: "passed_count"
      expr: COUNT(DISTINCT CASE WHEN passed_flag = True THEN training_record_id END)
      comment: "Count of training records where employee passed"
    - name: "compliance_training_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_requirement_flag = True THEN training_record_id END)
      comment: "Count of compliance-required training records"
    - name: "certificate_issued_count"
      expr: COUNT(DISTINCT CASE WHEN certificate_issued_flag = True THEN training_record_id END)
      comment: "Count of training records with certificate issued"
$$;