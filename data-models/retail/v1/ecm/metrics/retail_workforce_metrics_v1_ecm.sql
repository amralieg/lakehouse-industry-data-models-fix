-- Metric views for domain: workforce | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_associate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking headcount, tenure, and employment composition across locations, departments, and employment types"
  source: "`retail_ecm`.`workforce`.`associate`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, Leave of Absence, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (Full-Time, Part-Time, Seasonal, Temporary)"
    - name: "job_title"
      expr: job_title
      comment: "Current job title of the associate"
    - name: "primary_work_location_type"
      expr: primary_work_location_type
      comment: "Type of primary work location (Store, DC, Corporate, Remote)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade level for compensation analysis"
    - name: "flsa_status"
      expr: flsa_status
      comment: "FLSA classification (Exempt, Non-Exempt) for overtime eligibility"
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether associate is a union member"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the associate was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the associate was hired for cohort analysis"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for termination (Voluntary, Involuntary, Retirement, etc.)"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT associate_id)
      comment: "Total unique associate count - primary workforce sizing metric"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN associate_id END)
      comment: "Count of currently active associates - key operational staffing metric"
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN associate_id END)
      comment: "Count of associates with termination dates - attrition tracking"
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average standard weekly hours across associates - capacity planning metric"
    - name: "total_standard_hours_capacity"
      expr: SUM(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Total weekly hours capacity across all associates - workforce capacity metric"
    - name: "union_member_count"
      expr: COUNT(DISTINCT CASE WHEN union_membership_flag = TRUE THEN associate_id END)
      comment: "Count of union members - labor relations metric"
    - name: "rehire_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible_flag = TRUE THEN associate_id END)
      comment: "Count of associates eligible for rehire - talent pool metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and cost metrics tracking actual time worked, overtime, and labor efficiency across departments and locations"
  source: "`retail_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work performed"
    - name: "work_week"
      expr: DATE_TRUNC('WEEK', work_date)
      comment: "Week of work for weekly labor analysis"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work for monthly labor reporting"
    - name: "department_code"
      expr: department_code
      comment: "Department where work was performed"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (Regular, Overtime, Holiday, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entry (Pending, Approved, Rejected)"
    - name: "shift_differential_type"
      expr: shift_differential_type
      comment: "Type of shift differential applied (Night, Weekend, etc.)"
    - name: "is_holiday_work"
      expr: is_holiday_work
      comment: "Whether work was performed on a holiday"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether time entry has exceptions requiring review"
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether time entry has been processed in payroll"
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked - primary labor hours metric"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked - baseline labor hours"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked - premium labor cost driver"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked - highest premium labor cost"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all time entries - primary labor expense metric"
    - name: "avg_hourly_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average hourly pay rate - compensation benchmarking metric"
    - name: "total_time_entries"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Total number of time entries - administrative workload metric"
    - name: "exception_entry_count"
      expr: COUNT(DISTINCT CASE WHEN exception_flag = TRUE THEN time_entry_id END)
      comment: "Count of time entries with exceptions - compliance and quality metric"
    - name: "holiday_work_hours"
      expr: SUM(CAST(CASE WHEN is_holiday_work = TRUE THEN actual_hours_worked END AS DOUBLE))
      comment: "Total hours worked on holidays - premium pay analysis"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_compensation_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation adjustment metrics tracking merit increases, promotions, and pay equity across the organization"
  source: "`retail_ecm`.`workforce`.`compensation_change`"
  dimensions:
    - name: "change_effective_date"
      expr: change_effective_date
      comment: "Date when compensation change becomes effective"
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', change_effective_date)
      comment: "Month of compensation change for trend analysis"
    - name: "change_type"
      expr: change_type
      comment: "Type of compensation change (Merit, Promotion, Market Adjustment, etc.)"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for compensation change"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating associated with the change"
    - name: "hr_approval_status"
      expr: hr_approval_status
      comment: "HR approval status (Pending, Approved, Rejected)"
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Whether change is a one-time lump sum payment"
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Whether change includes retroactive pay"
    - name: "new_pay_grade"
      expr: new_pay_grade
      comment: "New pay grade after change"
    - name: "previous_pay_grade"
      expr: previous_pay_grade
      comment: "Previous pay grade before change"
  measures:
    - name: "total_compensation_changes"
      expr: COUNT(DISTINCT compensation_change_id)
      comment: "Total number of compensation changes - merit cycle activity metric"
    - name: "total_pay_rate_increase_amount"
      expr: SUM(CAST(pay_rate_change_amount AS DOUBLE))
      comment: "Total dollar amount of pay rate increases - compensation investment metric"
    - name: "avg_pay_rate_increase_pct"
      expr: AVG(CAST(pay_rate_change_percentage AS DOUBLE))
      comment: "Average percentage pay rate increase - merit increase benchmark"
    - name: "total_lump_sum_amount"
      expr: SUM(CAST(lump_sum_amount AS DOUBLE))
      comment: "Total lump sum payments - one-time compensation expense"
    - name: "total_retroactive_amount"
      expr: SUM(CAST(retroactive_amount AS DOUBLE))
      comment: "Total retroactive pay adjustments - catch-up compensation expense"
    - name: "total_budget_impact"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total budget impact of compensation changes - financial planning metric"
    - name: "avg_compa_ratio_after"
      expr: AVG(CAST(compa_ratio_after AS DOUBLE))
      comment: "Average compa-ratio after changes - pay equity and market positioning metric"
    - name: "promotion_count"
      expr: COUNT(DISTINCT CASE WHEN change_type = 'Promotion' THEN compensation_change_id END)
      comment: "Count of promotions - internal mobility and career progression metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hiring demand and recruitment effectiveness metrics tracking open positions, time-to-fill, and talent acquisition performance"
  source: "`retail_ecm`.`workforce`.`requisition`"
  dimensions:
    - name: "open_date"
      expr: open_date
      comment: "Date requisition was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month requisition was opened for hiring trend analysis"
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of requisition (Open, Filled, Cancelled, On Hold)"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (New Hire, Replacement, Backfill)"
    - name: "job_title"
      expr: job_title
      comment: "Job title for the requisition"
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping for talent pipeline analysis"
    - name: "job_level"
      expr: job_level
      comment: "Job level (Entry, Mid, Senior, Executive)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (Full-Time, Part-Time, Seasonal)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of requisition (Critical, High, Normal, Low)"
    - name: "is_remote_eligible"
      expr: is_remote_eligible
      comment: "Whether position is eligible for remote work"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT requisition_id)
      comment: "Total number of requisitions - hiring demand metric"
    - name: "open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN requisition_id END)
      comment: "Count of open requisitions - current hiring pipeline metric"
    - name: "filled_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN requisition_id END)
      comment: "Count of filled requisitions - recruitment success metric"
    - name: "avg_budgeted_salary_min"
      expr: AVG(CAST(budgeted_salary_min AS DOUBLE))
      comment: "Average minimum budgeted salary - compensation planning metric"
    - name: "avg_budgeted_salary_max"
      expr: AVG(CAST(budgeted_salary_max AS DOUBLE))
      comment: "Average maximum budgeted salary - compensation planning metric"
    - name: "total_approved_headcount"
      expr: SUM(CAST(approved_headcount AS DOUBLE))
      comment: "Total approved headcount across requisitions - workforce expansion metric"
    - name: "total_positions_filled"
      expr: SUM(CAST(positions_filled AS DOUBLE))
      comment: "Total positions filled - recruitment productivity metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll expense and tax metrics tracking gross pay, deductions, net pay, and employer costs by pay period"
  source: "`retail_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date"
      expr: pay_date
      comment: "Date payroll was paid"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of payroll for monthly expense reporting"
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of pay period"
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of pay period"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of payroll record (Pending, Approved, Processed, Paid)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (Direct Deposit, Check, Pay Card)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (Weekly, Bi-Weekly, Semi-Monthly, Monthly)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for payroll expense allocation"
    - name: "department_code"
      expr: department_code
      comment: "Department for payroll expense analysis"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay before deductions - primary payroll expense metric"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions - actual cash disbursed to employees"
    - name: "total_regular_pay"
      expr: SUM(CAST(regular_pay_amount AS DOUBLE))
      comment: "Total regular pay - baseline payroll expense"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay_amount AS DOUBLE))
      comment: "Total overtime pay - premium labor cost"
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_pay_amount AS DOUBLE))
      comment: "Total bonus payments - variable compensation expense"
    - name: "total_commission_pay"
      expr: SUM(CAST(commission_pay_amount AS DOUBLE))
      comment: "Total commission payments - sales incentive expense"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions_amount AS DOUBLE))
      comment: "Total deductions from gross pay - employee withholdings"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal tax withheld - tax remittance liability"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state tax withheld - state tax liability"
    - name: "total_fica_social_security"
      expr: SUM(CAST(fica_social_security_withheld_amount AS DOUBLE))
      comment: "Total FICA Social Security withheld - payroll tax liability"
    - name: "total_fica_medicare"
      expr: SUM(CAST(fica_medicare_withheld_amount AS DOUBLE))
      comment: "Total FICA Medicare withheld - payroll tax liability"
    - name: "total_retirement_contributions"
      expr: SUM(CAST(retirement_contribution_amount AS DOUBLE))
      comment: "Total retirement contributions - employee savings and employer match"
    - name: "total_health_insurance_deductions"
      expr: SUM(CAST(health_insurance_deduction_amount AS DOUBLE))
      comment: "Total health insurance deductions - employee benefit cost sharing"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular hours worked in pay period"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked in pay period"
    - name: "total_payroll_records"
      expr: COUNT(DISTINCT payroll_record_id)
      comment: "Total number of payroll records processed"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and absence metrics tracking leave requests, approvals, FMLA usage, and leave balance impacts"
  source: "`retail_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "requested_start_date"
      expr: requested_start_date
      comment: "Requested start date of leave"
    - name: "leave_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Month of leave request for absence trend analysis"
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (Vacation, Sick, FMLA, Personal, Bereavement, etc.)"
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Subtype of leave for detailed categorization"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status (Pending, Approved, Denied)"
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Whether employee is FMLA eligible"
    - name: "fmla_designation_status"
      expr: fmla_designation_status
      comment: "FMLA designation status for compliance tracking"
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether leave is paid or unpaid"
    - name: "intermittent_leave_flag"
      expr: intermittent_leave_flag
      comment: "Whether leave is intermittent FMLA"
    - name: "hr_review_status"
      expr: hr_review_status
      comment: "HR review status for compliance verification"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total number of leave requests - absence volume metric"
    - name: "approved_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN leave_request_id END)
      comment: "Count of approved leave requests - leave utilization metric"
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total days of leave requested - absence demand metric"
    - name: "total_days_approved"
      expr: SUM(CAST(total_days_approved AS DOUBLE))
      comment: "Total days of leave approved - actual absence impact metric"
    - name: "total_hours_requested"
      expr: SUM(CAST(total_hours_requested AS DOUBLE))
      comment: "Total hours of leave requested - granular absence metric"
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total hours of leave approved - actual hours lost to absence"
    - name: "avg_leave_duration_days"
      expr: AVG(CAST(total_days_approved AS DOUBLE))
      comment: "Average duration of approved leave in days - leave pattern metric"
    - name: "fmla_request_count"
      expr: COUNT(DISTINCT CASE WHEN fmla_eligible_flag = TRUE THEN leave_request_id END)
      comment: "Count of FMLA-eligible leave requests - compliance and risk metric"
    - name: "intermittent_leave_count"
      expr: COUNT(DISTINCT CASE WHEN intermittent_leave_flag = TRUE THEN leave_request_id END)
      comment: "Count of intermittent leave requests - scheduling complexity metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics tracking ratings, merit eligibility, performance improvement plans, and talent calibration"
  source: "`retail_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_date"
      expr: review_date
      comment: "Date of performance review"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of review for performance cycle analysis"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (Annual, Mid-Year, Probationary, PIP, etc.)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating (Exceeds, Meets, Needs Improvement, etc.)"
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of review (Draft, Submitted, Approved, Acknowledged)"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status for talent review process"
    - name: "merit_increase_eligible_flag"
      expr: merit_increase_eligible_flag
      comment: "Whether employee is eligible for merit increase"
    - name: "pip_flag"
      expr: pip_flag
      comment: "Whether employee is on performance improvement plan"
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether promotion is recommended"
    - name: "termination_recommended_flag"
      expr: termination_recommended_flag
      comment: "Whether termination is recommended"
  measures:
    - name: "total_performance_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total number of performance reviews - performance management activity metric"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score - workforce performance metric"
    - name: "merit_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN merit_increase_eligible_flag = TRUE THEN performance_review_id END)
      comment: "Count of merit-eligible employees - compensation planning metric"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage - compensation investment metric"
    - name: "pip_count"
      expr: COUNT(DISTINCT CASE WHEN pip_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees on performance improvement plans - performance risk metric"
    - name: "promotion_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Count of promotion recommendations - talent development metric"
    - name: "termination_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN termination_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Count of termination recommendations - performance management risk metric"
    - name: "employee_acknowledged_count"
      expr: COUNT(DISTINCT CASE WHEN employee_acknowledgment_flag = TRUE THEN performance_review_id END)
      comment: "Count of reviews acknowledged by employees - process completion metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training and development metrics tracking completion rates, compliance training, certification attainment, and learning investment"
  source: "`retail_ecm`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date of training enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for training trend analysis"
    - name: "training_type"
      expr: training_type
      comment: "Type of training (Technical, Leadership, Compliance, Safety, etc.)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (Online, Classroom, On-the-Job, Virtual)"
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status (Not Started, In Progress, Completed, Failed)"
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether training is mandatory for compliance"
    - name: "compliance_training_flag"
      expr: compliance_training_flag
      comment: "Whether training is compliance-related"
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether training is overdue - compliance risk indicator"
    - name: "pass_fail_indicator"
      expr: pass_fail_indicator
      comment: "Pass/Fail result of training"
    - name: "certification_earned_flag"
      expr: certification_earned_flag
      comment: "Whether certification was earned from training"
  measures:
    - name: "total_training_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total number of training enrollments - learning activity metric"
    - name: "completed_training_count"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'Completed' THEN training_enrollment_id END)
      comment: "Count of completed training enrollments - learning completion metric"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered - learning investment metric"
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training score - learning effectiveness metric"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training cost - learning investment expense metric"
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training enrollment - learning efficiency metric"
    - name: "mandatory_training_count"
      expr: COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE THEN training_enrollment_id END)
      comment: "Count of mandatory training enrollments - compliance requirement metric"
    - name: "overdue_training_count"
      expr: COUNT(DISTINCT CASE WHEN overdue_flag = TRUE THEN training_enrollment_id END)
      comment: "Count of overdue training - compliance risk metric"
    - name: "certification_earned_count"
      expr: COUNT(DISTINCT CASE WHEN certification_earned_flag = TRUE THEN training_enrollment_id END)
      comment: "Count of certifications earned - skill development metric"
    - name: "pass_count"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_indicator = 'Pass' THEN training_enrollment_id END)
      comment: "Count of passed training - learning success metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor planning and budget metrics tracking planned FTE, labor cost budgets, and workforce capacity plans by department and period"
  source: "`retail_ecm`.`workforce`.`labor_budget`"
  dimensions:
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of planning period"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (Annual, Quarterly, Monthly)"
    - name: "budget_status"
      expr: budget_status
      comment: "Status of budget (Draft, Submitted, Approved, Active)"
    - name: "budget_version_code"
      expr: budget_version_code
      comment: "Version code for budget iteration tracking"
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte_count AS DOUBLE))
      comment: "Total planned full-time equivalent headcount - workforce capacity plan"
    - name: "total_budgeted_labor_cost"
      expr: SUM(CAST(budgeted_labor_cost_amount AS DOUBLE))
      comment: "Total budgeted labor cost - primary labor expense budget metric"
    - name: "total_budgeted_regular_hours"
      expr: SUM(CAST(budgeted_regular_hours AS DOUBLE))
      comment: "Total budgeted regular hours - baseline labor capacity"
    - name: "total_budgeted_overtime_hours"
      expr: SUM(CAST(budgeted_overtime_hours AS DOUBLE))
      comment: "Total budgeted overtime hours - premium labor budget"
    - name: "avg_budgeted_labor_pct_of_sales"
      expr: AVG(CAST(budgeted_labor_cost_percent_of_sales AS DOUBLE))
      comment: "Average budgeted labor as percent of sales - labor efficiency target"
    - name: "avg_attrition_assumption_pct"
      expr: AVG(CAST(attrition_assumption_percent AS DOUBLE))
      comment: "Average attrition assumption percentage - workforce planning assumption"
    - name: "total_labor_budget_records"
      expr: COUNT(DISTINCT labor_budget_id)
      comment: "Total number of labor budget records - planning granularity metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor deployment metrics tracking scheduled hours, shift coverage, and labor cost allocation"
  source: "`retail_ecm`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of scheduled shift"
    - name: "schedule_week"
      expr: DATE_TRUNC('WEEK', shift_date)
      comment: "Week of schedule for weekly labor planning"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (Opening, Closing, Mid, Overnight, etc.)"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of schedule (Draft, Published, Confirmed, Cancelled)"
    - name: "is_holiday_shift"
      expr: is_holiday_shift
      comment: "Whether shift is on a holiday"
    - name: "is_overtime_eligible"
      expr: is_overtime_eligible
      comment: "Whether shift is eligible for overtime"
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source of schedule (Auto-Generated, Manual, Employee Request)"
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours - labor deployment metric"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for scheduled shifts - labor budget tracking"
    - name: "total_shifts_scheduled"
      expr: COUNT(DISTINCT shift_schedule_id)
      comment: "Total number of shifts scheduled - scheduling activity metric"
    - name: "published_shifts_count"
      expr: COUNT(DISTINCT CASE WHEN schedule_status = 'Published' THEN shift_schedule_id END)
      comment: "Count of published shifts - schedule communication metric"
    - name: "cancelled_shifts_count"
      expr: COUNT(DISTINCT CASE WHEN schedule_status = 'Cancelled' THEN shift_schedule_id END)
      comment: "Count of cancelled shifts - schedule disruption metric"
    - name: "holiday_shifts_count"
      expr: COUNT(DISTINCT CASE WHEN is_holiday_shift = TRUE THEN shift_schedule_id END)
      comment: "Count of holiday shifts - premium pay planning metric"
    - name: "avg_scheduled_hours_per_shift"
      expr: AVG(CAST(scheduled_hours AS DOUBLE))
      comment: "Average hours per scheduled shift - shift length metric"
$$;