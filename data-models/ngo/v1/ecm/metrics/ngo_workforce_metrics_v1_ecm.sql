-- Metric views for domain: workforce | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_staff_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount, demographics, and employment status metrics for strategic workforce planning and diversity monitoring"
  source: "`ngo_ecm`.`workforce`.`staff_member`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, separated, on leave)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor)"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract classification (permanent, fixed-term, consultant)"
    - name: "staff_category"
      expr: job_grade
      comment: "Job grade or staff category for workforce segmentation"
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country where staff member is stationed"
    - name: "gender"
      expr: gender
      comment: "Gender for diversity reporting"
    - name: "nationality"
      expr: nationality
      comment: "Nationality for workforce composition analysis"
    - name: "department"
      expr: department
      comment: "Department or organizational unit"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort analysis"
    - name: "separation_reason"
      expr: separation_reason
      comment: "Reason for separation (resignation, termination, retirement)"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT staff_member_id)
      comment: "Total unique staff members for workforce size tracking"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN staff_member_id END)
      comment: "Count of currently active staff members"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary cost across all staff"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per staff member"
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage across staff for capacity planning"
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE)) / 100.0
      comment: "Total full-time equivalent headcount"
    - name: "separation_count"
      expr: COUNT(DISTINCT CASE WHEN separation_date IS NOT NULL THEN staff_member_id END)
      comment: "Count of staff who have separated"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline efficiency, time-to-fill, and hiring velocity metrics for talent acquisition performance"
  source: "`ngo_ecm`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of requisition (open, filled, cancelled)"
    - name: "recruitment_type"
      expr: recruitment_type
      comment: "Type of recruitment (internal, external, emergency)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment being recruited for"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category or level being recruited"
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country code for duty station location"
    - name: "is_emergency_surge"
      expr: is_emergency_surge
      comment: "Whether this is an emergency surge recruitment"
    - name: "funding_confirmed"
      expr: funding_confirmed
      comment: "Whether funding has been confirmed for the position"
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month when requisition was opened"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total number of recruitment requisitions"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Count of currently open requisitions"
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN recruitment_requisition_id END)
      comment: "Count of filled requisitions"
    - name: "total_openings"
      expr: SUM(CAST(number_of_openings AS DOUBLE))
      comment: "Total number of position openings across all requisitions"
    - name: "total_positions_filled"
      expr: SUM(CAST(positions_filled_count AS DOUBLE))
      comment: "Total number of positions successfully filled"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average number of days to fill a requisition"
    - name: "total_budgeted_salary"
      expr: SUM(CAST(budgeted_annual_salary AS DOUBLE))
      comment: "Total budgeted annual salary across all requisitions"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management effectiveness, rating distribution, and talent development metrics for organizational capability building"
  source: "`ngo_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of performance review"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category"
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Type of review cycle (annual, mid-year, probation)"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category being reviewed"
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country code for duty station"
    - name: "pip_required"
      expr: pip_required
      comment: "Whether performance improvement plan is required"
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Whether promotion is recommended"
    - name: "retention_risk_flag"
      expr: retention_risk_flag
      comment: "Whether staff member is flagged as retention risk"
    - name: "review_period_year"
      expr: YEAR(review_period_end_date)
      comment: "Year of review period end"
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews"
    - name: "completed_reviews"
      expr: COUNT(DISTINCT CASE WHEN review_status = 'Completed' THEN performance_review_id END)
      comment: "Count of completed performance reviews"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "avg_competency_rating_score"
      expr: AVG(CAST(competency_rating_score AS DOUBLE))
      comment: "Average competency rating score"
    - name: "avg_objective_achievement_score"
      expr: AVG(CAST(objective_achievement_score AS DOUBLE))
      comment: "Average objective achievement score"
    - name: "pip_required_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN performance_review_id END)
      comment: "Count of reviews requiring performance improvement plan"
    - name: "promotion_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommendation = TRUE THEN performance_review_id END)
      comment: "Count of reviews with promotion recommendation"
    - name: "retention_risk_count"
      expr: COUNT(DISTINCT CASE WHEN retention_risk_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews flagged as retention risk"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_separation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attrition analysis, turnover drivers, and exit process compliance metrics for retention strategy and workforce stability"
  source: "`ngo_ecm`.`workforce`.`separation_event`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (voluntary, involuntary, retirement)"
    - name: "primary_departure_reason"
      expr: primary_departure_reason
      comment: "Primary reason for departure"
    - name: "separation_status"
      expr: separation_status
      comment: "Current status of separation process"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of departing employee"
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type of departing employee"
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Whether employee is eligible for rehire"
    - name: "exit_interview_status"
      expr: exit_interview_status
      comment: "Status of exit interview completion"
    - name: "separation_year"
      expr: YEAR(effective_date)
      comment: "Year of separation effective date"
    - name: "separation_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of separation effective date"
  measures:
    - name: "total_separations"
      expr: COUNT(DISTINCT separation_event_id)
      comment: "Total number of separation events"
    - name: "voluntary_separations"
      expr: COUNT(DISTINCT CASE WHEN separation_type = 'Voluntary' THEN separation_event_id END)
      comment: "Count of voluntary separations"
    - name: "involuntary_separations"
      expr: COUNT(DISTINCT CASE WHEN separation_type = 'Involuntary' THEN separation_event_id END)
      comment: "Count of involuntary separations"
    - name: "avg_years_of_service"
      expr: AVG(CAST(years_of_service AS DOUBLE))
      comment: "Average years of service at separation"
    - name: "total_final_settlement"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amount paid"
    - name: "avg_final_settlement"
      expr: AVG(CAST(final_settlement_amount AS DOUBLE))
      comment: "Average final settlement amount per separation"
    - name: "total_severance_pay"
      expr: SUM(CAST(severance_pay_amount AS DOUBLE))
      comment: "Total severance pay amount"
    - name: "exit_interview_completed_count"
      expr: COUNT(DISTINCT CASE WHEN exit_interview_status = 'Completed' THEN separation_event_id END)
      comment: "Count of completed exit interviews"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_learning_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development effectiveness, training completion rates, and capability building investment metrics"
  source: "`ngo_ecm`.`workforce`.`learning_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (enrolled, completed, withdrawn)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status for completed courses"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the training is mandatory"
    - name: "is_certified"
      expr: is_certified
      comment: "Whether certification was issued"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of training delivery (online, in-person, blended)"
    - name: "course_category"
      expr: course_category
      comment: "Category of course"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of training provider (internal, external)"
    - name: "staff_type"
      expr: staff_type
      comment: "Type of staff enrolled"
    - name: "country_code"
      expr: country_code
      comment: "Country code for training location"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT learning_enrollment_id)
      comment: "Total number of learning enrollments"
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN learning_enrollment_id END)
      comment: "Count of completed enrollments"
    - name: "passed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'Pass' THEN learning_enrollment_id END)
      comment: "Count of enrollments with passing status"
    - name: "certified_enrollments"
      expr: COUNT(DISTINCT CASE WHEN is_certified = TRUE THEN learning_enrollment_id END)
      comment: "Count of enrollments resulting in certification"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total training cost investment"
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average training cost per enrollment"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "avg_training_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training hours per enrollment"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average score achieved across enrollments"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll processing efficiency, cost control, and compliance metrics for financial management and audit"
  source: "`ngo_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of payroll run (draft, approved, processed)"
    - name: "run_type"
      expr: run_type
      comment: "Type of payroll run (regular, off-cycle, correction)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of payroll run"
    - name: "payroll_group"
      expr: payroll_group
      comment: "Payroll group classification"
    - name: "country_code"
      expr: country_code
      comment: "Country code for payroll jurisdiction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for payroll"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (monthly, bi-weekly, weekly)"
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Whether payroll run includes retroactive adjustments"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of payroll run"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date"
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total number of payroll runs"
    - name: "total_employees_paid"
      expr: SUM(CAST(employee_count AS DOUBLE))
      comment: "Total number of employees paid across all runs"
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross pay amount across all runs"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay amount across all runs"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions amount"
    - name: "total_tax_withheld"
      expr: SUM(CAST(total_tax_withheld AS DOUBLE))
      comment: "Total tax withheld amount"
    - name: "total_employer_contributions"
      expr: SUM(CAST(total_employer_contributions AS DOUBLE))
      comment: "Total employer contributions (pension, social security)"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(total_gross_pay AS DOUBLE) / NULLIF(CAST(employee_count AS DOUBLE), 0))
      comment: "Average gross pay per employee per run"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time tracking, effort allocation, and grant charging accuracy metrics for project costing and compliance"
  source: "`ngo_ecm`.`workforce`.`timesheet`"
  dimensions:
    - name: "timesheet_status"
      expr: timesheet_status
      comment: "Current status of timesheet (draft, submitted, approved, rejected)"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type of staff member"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether time is billable"
    - name: "is_grant_chargeable"
      expr: is_grant_chargeable
      comment: "Whether time is chargeable to a grant"
    - name: "is_cost_shared"
      expr: is_cost_shared
      comment: "Whether time is cost-shared across multiple funding sources"
    - name: "is_field_deployment"
      expr: is_field_deployment
      comment: "Whether time is for field deployment"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Type of work location (office, field, remote)"
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country code for duty station"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work date"
  measures:
    - name: "total_timesheets"
      expr: COUNT(DISTINCT timesheet_id)
      comment: "Total number of timesheets"
    - name: "approved_timesheets"
      expr: COUNT(DISTINCT CASE WHEN timesheet_status = 'Approved' THEN timesheet_id END)
      comment: "Count of approved timesheets"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all timesheets"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_toil_hours_accrued"
      expr: SUM(CAST(toil_hours_accrued AS DOUBLE))
      comment: "Total time-off-in-lieu hours accrued"
    - name: "avg_hours_per_timesheet"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per timesheet"
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours"
    - name: "grant_chargeable_hours"
      expr: SUM(CASE WHEN is_grant_chargeable = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total hours chargeable to grants"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization, balance management, and absence pattern metrics for workforce capacity planning"
  source: "`ngo_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (annual, sick, maternity, RnR)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of leave request"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of requester"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type of requester"
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station"
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Whether leave request is retroactive"
    - name: "is_rnr_eligible"
      expr: is_rnr_eligible
      comment: "Whether request is eligible for rest and recuperation"
    - name: "medical_certificate_required"
      expr: medical_certificate_required
      comment: "Whether medical certificate is required"
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year for entitlement tracking"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Month of leave start date"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total number of leave requests"
    - name: "approved_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN leave_request_id END)
      comment: "Count of approved leave requests"
    - name: "total_requested_days"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested"
    - name: "total_actual_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total leave days actually taken"
    - name: "avg_requested_days"
      expr: AVG(CAST(requested_days AS DOUBLE))
      comment: "Average leave days requested per request"
    - name: "total_entitlement_days"
      expr: SUM(CAST(entitlement_days AS DOUBLE))
      comment: "Total leave entitlement days"
    - name: "total_carry_forward_days"
      expr: SUM(CAST(carry_forward_days AS DOUBLE))
      comment: "Total carry forward days"
    - name: "avg_leave_balance_before"
      expr: AVG(CAST(leave_balance_before AS DOUBLE))
      comment: "Average leave balance before request"
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance after request"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position management, vacancy tracking, and organizational structure metrics for workforce planning and budgeting"
  source: "`ngo_ecm`.`workforce`.`position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Current status of position (active, frozen, closed)"
    - name: "position_type"
      expr: position_type
      comment: "Type of position (regular, temporary, project-based)"
    - name: "is_vacant"
      expr: is_vacant
      comment: "Whether position is currently vacant"
    - name: "is_supervisory"
      expr: is_supervisory
      comment: "Whether position has supervisory responsibilities"
    - name: "is_field_position"
      expr: is_field_position
      comment: "Whether position is field-based"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of position"
    - name: "duty_station_country_code"
      expr: duty_station_country_code
      comment: "Country code for duty station"
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (core, grant, project)"
    - name: "pay_grade_band"
      expr: pay_grade_band
      comment: "Pay grade band of position"
    - name: "vacancy_reason"
      expr: vacancy_reason
      comment: "Reason for vacancy"
  measures:
    - name: "total_positions"
      expr: COUNT(DISTINCT position_id)
      comment: "Total number of positions in organizational structure"
    - name: "vacant_positions"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = TRUE THEN position_id END)
      comment: "Count of vacant positions"
    - name: "filled_positions"
      expr: COUNT(DISTINCT CASE WHEN is_vacant = FALSE THEN position_id END)
      comment: "Count of filled positions"
    - name: "supervisory_positions"
      expr: COUNT(DISTINCT CASE WHEN is_supervisory = TRUE THEN position_id END)
      comment: "Count of supervisory positions"
    - name: "field_positions"
      expr: COUNT(DISTINCT CASE WHEN is_field_position = TRUE THEN position_id END)
      comment: "Count of field-based positions"
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Total budgeted annual cost for all positions"
    - name: "avg_budgeted_cost"
      expr: AVG(CAST(budgeted_annual_cost AS DOUBLE))
      comment: "Average budgeted annual cost per position"
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocation across all positions"
    - name: "avg_max_salary"
      expr: AVG(CAST(max_salary AS DOUBLE))
      comment: "Average maximum salary across positions"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`workforce_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary case management, safeguarding compliance, and organizational conduct metrics for risk management and governance"
  source: "`ngo_ecm`.`workforce`.`disciplinary_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of disciplinary case"
    - name: "case_type"
      expr: case_type
      comment: "Type of disciplinary case"
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of case (high, medium, low)"
    - name: "is_psea_case"
      expr: is_psea_case
      comment: "Whether case involves protection from sexual exploitation and abuse"
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of investigation"
    - name: "sanction_applied"
      expr: sanction_applied
      comment: "Sanction applied as result of case"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category of subject"
    - name: "duty_station_country"
      expr: duty_station_country
      comment: "Country of duty station"
    - name: "referred_to_authorities"
      expr: referred_to_authorities
      comment: "Whether case was referred to external authorities"
    - name: "beneficiary_involved"
      expr: beneficiary_involved
      comment: "Whether beneficiary was involved in incident"
    - name: "case_opened_year"
      expr: YEAR(case_opened_date)
      comment: "Year case was opened"
  measures:
    - name: "total_disciplinary_cases"
      expr: COUNT(DISTINCT disciplinary_case_id)
      comment: "Total number of disciplinary cases"
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Open' THEN disciplinary_case_id END)
      comment: "Count of currently open cases"
    - name: "closed_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Closed' THEN disciplinary_case_id END)
      comment: "Count of closed cases"
    - name: "psea_cases"
      expr: COUNT(DISTINCT CASE WHEN is_psea_case = TRUE THEN disciplinary_case_id END)
      comment: "Count of PSEA-related cases"
    - name: "high_priority_cases"
      expr: COUNT(DISTINCT CASE WHEN case_priority = 'High' THEN disciplinary_case_id END)
      comment: "Count of high-priority cases"
    - name: "cases_referred_to_authorities"
      expr: COUNT(DISTINCT CASE WHEN referred_to_authorities = TRUE THEN disciplinary_case_id END)
      comment: "Count of cases referred to external authorities"
    - name: "cases_with_beneficiary_involvement"
      expr: COUNT(DISTINCT CASE WHEN beneficiary_involved = TRUE THEN disciplinary_case_id END)
      comment: "Count of cases involving beneficiaries"
$$;