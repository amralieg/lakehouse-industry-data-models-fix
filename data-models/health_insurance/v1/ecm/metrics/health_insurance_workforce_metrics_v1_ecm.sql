-- Metric views for domain: workforce | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce demographics and headcount metrics for health insurance workforce planning, attrition analysis, and compliance tracking."
  source: "`health_insurance_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Organizational department the employee belongs to"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, On Leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (Full-time, Part-time, Contract, etc.)"
    - name: "gender"
      expr: gender
      comment: "Employee gender for diversity and EEO reporting"
    - name: "ethnicity"
      expr: ethnicity
      comment: "Employee ethnicity for diversity and EEO reporting"
    - name: "state"
      expr: state
      comment: "Employee state of residence for geographic workforce distribution"
    - name: "country"
      expr: country
      comment: "Employee country for international workforce analysis"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center assignment for financial allocation"
    - name: "organization_level"
      expr: organization_level
      comment: "Organizational hierarchy level of the employee"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (Weekly, Bi-weekly, Monthly, etc.)"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month of hire for trend analysis"
    - name: "is_health_plan_eligible"
      expr: health_plan_eligible
      comment: "Whether the employee is eligible for health plan benefits"
    - name: "is_bonus_eligible"
      expr: bonus_eligible
      comment: "Whether the employee is eligible for bonus compensation"
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records — baseline workforce size metric"
    - name: "active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of currently active employees for workforce capacity planning"
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated employees for attrition tracking"
    - name: "avg_salary"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary amount across employees for compensation benchmarking"
    - name: "total_salary_expense"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total salary expense for workforce cost management"
    - name: "health_plan_eligible_count"
      expr: COUNT(CASE WHEN health_plan_eligible = TRUE THEN 1 END)
      comment: "Count of employees eligible for health plan — critical for ACA compliance and benefit cost forecasting"
    - name: "hipaa_trained_count"
      expr: COUNT(CASE WHEN hipaa_training_completion_date IS NOT NULL THEN 1 END)
      comment: "Count of employees who have completed HIPAA training — regulatory compliance metric"
    - name: "distinct_department_count"
      expr: COUNT(DISTINCT department)
      comment: "Number of distinct departments for organizational span analysis"
    - name: "distinct_cost_center_count"
      expr: COUNT(DISTINCT cost_center)
      comment: "Number of distinct cost centers for financial allocation coverage"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation analysis metrics for health insurance workforce — tracks pay equity, compensation mix, and salary band positioning to support total rewards strategy."
  source: "`health_insurance_ecm`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (Base, Bonus, Equity, etc.)"
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of the compensation record (Active, Pending, Expired)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (Weekly, Bi-weekly, Monthly, Semi-monthly)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade level for salary band analysis"
    - name: "is_exempt"
      expr: is_exempt
      comment: "FLSA exemption status — critical for overtime compliance"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for compensation change (Merit, Promotion, Market Adjustment, etc.)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for financial allocation of compensation expense"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation for multi-currency workforce analysis"
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus (Performance, Signing, Retention, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the compensation became effective for trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the compensation became effective"
  measures:
    - name: "total_base_compensation"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base compensation expense across all records"
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average base compensation for benchmarking and equity analysis"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payouts for variable compensation cost tracking"
    - name: "avg_bonus_amount"
      expr: AVG(CAST(bonus_amount AS DOUBLE))
      comment: "Average bonus amount for incentive program effectiveness"
    - name: "total_equity_amount"
      expr: SUM(CAST(equity_amount AS DOUBLE))
      comment: "Total equity compensation value for long-term incentive tracking"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for non-exempt workforce cost analysis"
    - name: "avg_incentive_target_pct"
      expr: AVG(CAST(incentive_target_pct AS DOUBLE))
      comment: "Average incentive target percentage — measures variable pay aggressiveness"
    - name: "salary_range_utilization_avg"
      expr: AVG(CAST(base_amount AS DOUBLE) / NULLIF(CAST(salary_range_max AS DOUBLE), 0))
      comment: "Average ratio of base pay to salary range max — indicates pay band positioning and compression risk"
    - name: "compensation_record_count"
      expr: COUNT(1)
      comment: "Total compensation records for volume and change frequency analysis"
    - name: "exempt_employee_count"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN 1 END)
      comment: "Count of FLSA-exempt compensation records for compliance monitoring"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_payroll_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll disbursement metrics for health insurance workforce — tracks gross/net pay, tax withholdings, hours worked, and payroll cost distribution for financial planning and compliance."
  source: "`health_insurance_ecm`.`workforce`.`payroll_disbursement`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status
      comment: "Status of the payroll disbursement (Processed, Pending, Voided)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (Direct Deposit, Check, etc.)"
    - name: "payroll_disbursement_type"
      expr: payroll_disbursement_type
      comment: "Type of disbursement (Regular, Bonus, Adjustment, etc.)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for payroll expense allocation"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for segment-level payroll analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disbursement"
    - name: "employee_role"
      expr: employee_role
      comment: "Role of the employee at time of disbursement"
    - name: "timesheet_status"
      expr: timesheet_status
      comment: "Status of the associated timesheet"
    - name: "is_tax_exempt"
      expr: tax_exempt_flag
      comment: "Whether the disbursement is tax exempt"
    - name: "pay_period_end"
      expr: DATE_TRUNC('month', pay_period_end_date)
      comment: "Pay period end month for trend analysis"
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Payment date month for cash flow analysis"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay disbursed — primary payroll cost metric"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay disbursed to employees after all deductions"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld AS DOUBLE))
      comment: "Total federal tax withholdings for tax compliance reporting"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld AS DOUBLE))
      comment: "Total state tax withholdings for multi-state compliance"
    - name: "total_fica_tax_withheld"
      expr: SUM(CAST(fica_tax_withheld AS DOUBLE))
      comment: "Total FICA tax withholdings (Social Security + Medicare employer portion)"
    - name: "total_medicare_tax_withheld"
      expr: SUM(CAST(medicare_tax_withheld AS DOUBLE))
      comment: "Total Medicare tax withholdings"
    - name: "total_other_deductions"
      expr: SUM(CAST(other_deductions_total AS DOUBLE))
      comment: "Total other deductions (benefits, garnishments, etc.)"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours paid for labor utilization analysis"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid — key cost control and FLSA compliance metric"
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours consumed for leave liability tracking"
    - name: "total_sick_hours"
      expr: SUM(CAST(sick_hours AS DOUBLE))
      comment: "Total sick hours used for absenteeism analysis"
    - name: "avg_gross_pay_per_disbursement"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per disbursement for per-employee cost benchmarking"
    - name: "avg_net_pay_per_disbursement"
      expr: AVG(CAST(net_pay_amount AS DOUBLE))
      comment: "Average net pay per disbursement"
    - name: "disbursement_count"
      expr: COUNT(1)
      comment: "Total number of payroll disbursements processed"
    - name: "distinct_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees receiving payroll disbursements in the period"
    - name: "total_allocated_benefit_cost"
      expr: SUM(CAST(allocated_benefit_cost_amount AS DOUBLE))
      comment: "Total employer benefit cost allocated through payroll — critical for total compensation cost analysis"
    - name: "total_employer_tax"
      expr: SUM(CAST(allocated_employer_tax_amount AS DOUBLE))
      comment: "Total employer-side tax burden allocated through payroll"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_employee_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefit enrollment metrics for health insurance workforce — tracks enrollment volumes, contribution costs, coverage tiers, and ACA compliance for benefits administration and cost management."
  source: "`health_insurance_ecm`.`workforce`.`employee_benefit_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the benefit enrollment (Active, Terminated, Pending, COBRA)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (Medical, Dental, Vision, Life, etc.)"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (Employee Only, Employee+Spouse, Family, etc.)"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit plan year for annual comparison"
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of benefit contributions (Per Pay Period, Monthly, etc.)"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of enrollment (Open Enrollment, New Hire, Qualifying Life Event)"
    - name: "is_aca_compliant"
      expr: is_aca_compliant
      comment: "Whether the enrollment meets ACA compliance requirements"
    - name: "is_cobra_eligible"
      expr: is_cobra_eligible
      comment: "Whether the employee is COBRA eligible"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of contribution amounts"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Effective month of enrollment for trend analysis"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total benefit enrollment records for volume tracking"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Count of active benefit enrollments — measures current benefit participation"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee benefit contributions — employee cost share"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefit contributions — employer cost burden for benefits"
    - name: "total_combined_contribution"
      expr: SUM(CAST(total_contribution_amount AS DOUBLE))
      comment: "Total combined employee + employer benefit contributions"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution per enrollment for cost benchmarking"
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment for cost management"
    - name: "distinct_enrolled_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees enrolled in benefits — participation rate denominator"
    - name: "aca_compliant_count"
      expr: COUNT(CASE WHEN is_aca_compliant = TRUE THEN 1 END)
      comment: "Count of ACA-compliant enrollments — regulatory compliance metric"
    - name: "cobra_eligible_count"
      expr: COUNT(CASE WHEN is_cobra_eligible = TRUE THEN 1 END)
      comment: "Count of COBRA-eligible enrollments for continuation coverage liability estimation"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request metrics for health insurance workforce — tracks leave utilization, FMLA eligibility, payroll impact, and leave balance management for workforce availability and compliance."
  source: "`health_insurance_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, PTO, Sick, Bereavement, Parental, etc.)"
    - name: "leave_status"
      expr: leave_status
      comment: "Status of the leave request (Approved, Pending, Denied, Cancelled)"
    - name: "is_fmla_eligible"
      expr: fmla_eligible
      comment: "Whether the leave qualifies under FMLA — federal compliance tracking"
    - name: "is_intermittent"
      expr: intermittent
      comment: "Whether the leave is intermittent (recurring partial-day absences)"
    - name: "has_payroll_impact"
      expr: payroll_impact
      comment: "Whether the leave impacts payroll (paid vs unpaid leave)"
    - name: "ada_accommodation_required"
      expr: ada_accommodation_required
      comment: "Whether ADA accommodation is required — disability compliance"
    - name: "leave_policy_code"
      expr: leave_policy_code
      comment: "Leave policy governing the request"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center of the requesting employee"
    - name: "request_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of leave start for seasonal trend analysis"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total leave requests submitted for volume and trend analysis"
    - name: "approved_leave_requests"
      expr: COUNT(CASE WHEN leave_status = 'Approved' THEN 1 END)
      comment: "Count of approved leave requests"
    - name: "denied_leave_requests"
      expr: COUNT(CASE WHEN leave_status = 'Denied' THEN 1 END)
      comment: "Count of denied leave requests — may indicate policy issues or capacity constraints"
    - name: "total_requested_days"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total days of leave requested across all requests"
    - name: "total_approved_days"
      expr: SUM(CAST(approved_days AS DOUBLE))
      comment: "Total days of leave approved — measures actual workforce absence"
    - name: "avg_approved_days_per_request"
      expr: AVG(CAST(approved_days AS DOUBLE))
      comment: "Average approved leave duration per request for capacity planning"
    - name: "total_payroll_impact_amount"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total payroll cost impact of leave — paid leave liability"
    - name: "fmla_leave_count"
      expr: COUNT(CASE WHEN fmla_eligible = TRUE THEN 1 END)
      comment: "Count of FMLA-eligible leave requests — federal compliance tracking"
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average remaining leave balance after request — indicates leave bank depletion risk"
    - name: "distinct_employees_on_leave"
      expr: COUNT(DISTINCT primary_leave_employee_id)
      comment: "Distinct employees requesting leave — workforce availability impact"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_time_and_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics for health insurance workforce — tracks hours worked, overtime, absenteeism, and labor cost for operational efficiency and FLSA compliance."
  source: "`health_insurance_ecm`.`workforce`.`time_and_attendance`"
  dimensions:
    - name: "time_and_attendance_status"
      expr: time_and_attendance_status
      comment: "Status of the time record (Submitted, Approved, Rejected)"
    - name: "manager_approval_status"
      expr: manager_approval_status
      comment: "Manager approval status for the time entry"
    - name: "department_code"
      expr: department_code
      comment: "Department for labor distribution analysis"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation"
    - name: "location_code"
      expr: location_code
      comment: "Work location for site-level labor analysis"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift worked for shift-differential and scheduling analysis"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (Regular, Overtime, PTO, etc.)"
    - name: "time_entry_method"
      expr: time_entry_method
      comment: "Method of time capture (Badge, Manual, Mobile, etc.)"
    - name: "is_overtime_eligible"
      expr: overtime_eligibility
      comment: "Whether the employee is eligible for overtime — FLSA compliance"
    - name: "is_flsa_compliant"
      expr: flsa_compliance
      comment: "Whether the time record is FLSA compliant"
    - name: "payroll_integration_status"
      expr: payroll_integration_status
      comment: "Status of payroll system integration"
    - name: "pay_period_code"
      expr: pay_period_code
      comment: "Pay period identifier for period-over-period analysis"
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Period start month for trend analysis"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all time records — primary labor utilization metric"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours — key cost control and FLSA compliance metric"
    - name: "total_pto_hours_used"
      expr: SUM(CAST(pto_used_hours AS DOUBLE))
      comment: "Total PTO hours consumed for leave utilization tracking"
    - name: "total_sick_hours_used"
      expr: SUM(CAST(sick_hours_used AS DOUBLE))
      comment: "Total sick hours used — absenteeism indicator"
    - name: "total_holiday_hours"
      expr: SUM(CAST(holiday_hours AS DOUBLE))
      comment: "Total holiday hours for paid holiday cost tracking"
    - name: "total_shift_differential_hours"
      expr: SUM(CAST(shift_differential_hours AS DOUBLE))
      comment: "Total shift differential hours for premium pay analysis"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay from time records for labor cost analysis"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay from time records"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount from time records"
    - name: "avg_hours_per_record"
      expr: AVG(CAST(total_hours_worked AS DOUBLE))
      comment: "Average hours worked per time record for scheduling efficiency"
    - name: "distinct_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees with time records in the period"
    - name: "time_record_count"
      expr: COUNT(1)
      comment: "Total time and attendance records for processing volume tracking"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review metrics for health insurance workforce — tracks review completion, ratings distribution, merit recommendations, and performance improvement plans for talent management."
  source: "`health_insurance_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of the performance review (Draft, In Progress, Completed, Finalized)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (Annual, Mid-Year, Probationary, etc.)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating for distribution analysis"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the review for rating consistency"
    - name: "department"
      expr: department
      comment: "Department of the reviewed employee"
    - name: "job_role"
      expr: job_role
      comment: "Job role of the reviewed employee"
    - name: "compensation_grade"
      expr: compensation_grade
      comment: "Compensation grade for pay-performance alignment analysis"
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the review has been finalized"
    - name: "has_pip"
      expr: performance_improvement_plan_flag
      comment: "Whether a Performance Improvement Plan was triggered"
    - name: "review_period_start_year"
      expr: YEAR(review_period_start)
      comment: "Review period start year for annual comparison"
    - name: "review_completion_month"
      expr: DATE_TRUNC('month', review_completion_date)
      comment: "Month of review completion for cycle tracking"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total performance reviews for cycle completion tracking"
    - name: "completed_reviews"
      expr: COUNT(CASE WHEN review_status = 'Completed' OR is_finalized = TRUE THEN 1 END)
      comment: "Count of completed/finalized reviews for cycle completion rate"
    - name: "avg_goal_rating"
      expr: AVG(CAST(average_goal_rating AS DOUBLE))
      comment: "Average goal achievement rating across reviews — measures workforce goal attainment"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage recommended — compensation planning input"
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_recommendation_amount AS DOUBLE))
      comment: "Total merit increase amount recommended — budget impact of performance cycle"
    - name: "total_salary_adjustment_amount"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustments resulting from performance reviews"
    - name: "pip_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_flag = TRUE THEN 1 END)
      comment: "Count of Performance Improvement Plans triggered — risk indicator for talent retention"
    - name: "distinct_employees_reviewed"
      expr: COUNT(DISTINCT primary_performance_employee_id)
      comment: "Distinct employees who received performance reviews in the cycle"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training record metrics for health insurance workforce — tracks training completion, hours invested, assessment scores, and compliance training status critical for HIPAA and regulatory requirements."
  source: "`health_insurance_ecm`.`workforce`.`training_record`"
  dimensions:
    - name: "training_record_status"
      expr: training_record_status
      comment: "Status of the training record (Completed, In Progress, Not Started, Expired)"
    - name: "training_type"
      expr: training_type
      comment: "Type of training (Compliance, Clinical, Technical, Leadership, etc.)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (Online, Classroom, Virtual, On-the-Job)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the training assessment"
    - name: "is_expired"
      expr: is_expired
      comment: "Whether the training certification has expired — compliance risk indicator"
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required for the training"
    - name: "training_location"
      expr: training_location
      comment: "Location where training was delivered"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the training record"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_timestamp)
      comment: "Month of training completion for trend analysis"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total training records for volume and compliance coverage tracking"
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_record_status = 'Completed' THEN 1 END)
      comment: "Count of completed training records for compliance reporting"
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested — measures organizational learning investment"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per record for efficiency benchmarking"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training records — measures learning effectiveness"
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of passed training assessments"
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of failed training assessments — identifies retraining needs"
    - name: "expired_training_count"
      expr: COUNT(CASE WHEN is_expired = TRUE THEN 1 END)
      comment: "Count of expired training records — compliance risk metric for HIPAA and regulatory audits"
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT primary_training_employee_id)
      comment: "Distinct employees with training records — training penetration metric"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification metrics for health insurance — tracks certification status, renewals, costs, and compliance for clinical and regulatory certifications critical to healthcare operations."
  source: "`health_insurance_ecm`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (Clinical, Regulatory, Professional, Technical)"
    - name: "certification_category"
      expr: certification_category
      comment: "Category of certification for grouping analysis"
    - name: "workforce_certification_status"
      expr: workforce_certification_status
      comment: "Current status of the certification (Active, Expired, Pending Renewal)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status for expiring certifications"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether renewal is required"
    - name: "issuing_organization"
      expr: issuing_organization
      comment: "Organization that issued the certification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of certification cost"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year of certification issuance"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of certification expiration for renewal planning"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records for compliance coverage tracking"
    - name: "active_certifications"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Active' THEN 1 END)
      comment: "Count of active certifications — measures current compliance posture"
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN workforce_certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications — compliance risk indicator"
    - name: "mandatory_certification_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory certifications — regulatory compliance baseline"
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications for training budget management"
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average certification cost for budget planning"
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees holding certifications — certification penetration metric"
    - name: "renewal_pending_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE AND renewal_status != 'Renewed' THEN 1 END)
      comment: "Count of certifications pending renewal — proactive compliance management"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce recruitment metrics for health insurance — tracks requisition pipeline, offer acceptance, salary offers, and time-to-fill for talent acquisition effectiveness in a competitive healthcare labor market."
  source: "`health_insurance_ecm`.`workforce`.`workforce_recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the recruitment requisition (Open, Filled, Cancelled, On Hold)"
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Source channel of the hire (Referral, Job Board, Agency, Internal, etc.)"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Compensation type for the position (Salaried, Hourly, Contract)"
    - name: "job_level"
      expr: job_level
      comment: "Level of the job being recruited for"
    - name: "department_code"
      expr: department_code
      comment: "Department of the open requisition"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for recruitment cost allocation"
    - name: "location_code"
      expr: location_code
      comment: "Location of the open position"
    - name: "is_remote"
      expr: is_remote
      comment: "Whether the position allows remote work"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of salary offer"
    - name: "job_posting_month"
      expr: DATE_TRUNC('month', job_posting_date)
      comment: "Month of job posting for pipeline trend analysis"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total recruitment requisitions for pipeline volume tracking"
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Open' THEN 1 END)
      comment: "Count of open requisitions — measures current hiring demand"
    - name: "filled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'Filled' THEN 1 END)
      comment: "Count of filled requisitions — measures hiring throughput"
    - name: "total_salary_offered"
      expr: SUM(CAST(salary_offer_amount AS DOUBLE))
      comment: "Total salary offered across all requisitions for compensation budget tracking"
    - name: "avg_salary_offered"
      expr: AVG(CAST(salary_offer_amount AS DOUBLE))
      comment: "Average salary offered — market competitiveness indicator"
    - name: "total_salary_adjustment"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustments during recruitment — negotiation cost impact"
    - name: "offers_extended_count"
      expr: COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN 1 END)
      comment: "Count of offers extended for offer pipeline tracking"
    - name: "offers_accepted_count"
      expr: COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END)
      comment: "Count of offers accepted — measures offer acceptance effectiveness"
    - name: "distinct_positions_recruiting"
      expr: COUNT(DISTINCT position_id)
      comment: "Distinct positions being recruited for — breadth of hiring activity"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_background_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Background check metrics for health insurance workforce — tracks screening completion, OIG exclusion checks, adjudication outcomes, and costs critical for healthcare regulatory compliance and federal program access."
  source: "`health_insurance_ecm`.`workforce`.`background_check`"
  dimensions:
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the background check (Pending, Completed, In Progress, Failed)"
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening (Criminal, Credit, Education, OIG, Drug, etc.)"
    - name: "adjudication_decision"
      expr: adjudication_decision
      comment: "Adjudication decision outcome (Clear, Review, Adverse Action)"
    - name: "result"
      expr: result
      comment: "Result of the background check (Pass, Fail, Pending)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the background check"
    - name: "is_oig_exclusion_required"
      expr: is_oig_exclusion_required
      comment: "Whether OIG exclusion screening is required — critical for Medicare/Medicaid programs"
    - name: "is_oig_exclusion_flag"
      expr: is_oig_exclusion_flag
      comment: "Whether OIG exclusion was found — immediate compliance risk"
    - name: "is_federal_program_access"
      expr: is_federal_program_access
      comment: "Whether the employee requires federal program access (Medicare, Medicaid)"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_timestamp)
      comment: "Month the background check was ordered for trend analysis"
  measures:
    - name: "total_background_checks"
      expr: COUNT(1)
      comment: "Total background checks ordered for volume and compliance tracking"
    - name: "completed_checks"
      expr: COUNT(CASE WHEN background_check_status = 'Completed' THEN 1 END)
      comment: "Count of completed background checks"
    - name: "adverse_action_count"
      expr: COUNT(CASE WHEN adjudication_decision = 'Adverse Action' THEN 1 END)
      comment: "Count of adverse action decisions — risk and compliance metric"
    - name: "oig_exclusion_found_count"
      expr: COUNT(CASE WHEN is_oig_exclusion_flag = TRUE THEN 1 END)
      comment: "Count of OIG exclusion findings — critical healthcare compliance risk for federal program participation"
    - name: "total_background_check_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of background checks for vendor cost management"
    - name: "avg_background_check_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per background check for vendor benchmarking"
    - name: "federal_program_access_checks"
      expr: COUNT(CASE WHEN is_federal_program_access = TRUE THEN 1 END)
      comment: "Count of checks for federal program access employees — Medicare/Medicaid compliance scope"
    - name: "distinct_employees_checked"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees screened for background check coverage analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run metrics for health insurance workforce — tracks payroll processing volumes, gross/net totals, employer tax burden, and deductions for financial planning and payroll operations management."
  source: "`health_insurance_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (Completed, Processing, Failed, Voided)"
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (Regular, Off-Cycle, Bonus, Correction)"
    - name: "payroll_cycle_code"
      expr: payroll_cycle_code
      comment: "Payroll cycle identifier (Weekly, Bi-weekly, Monthly)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run"
    - name: "is_manual_run"
      expr: is_manual_run
      comment: "Whether the payroll run was manually triggered"
    - name: "source_system"
      expr: source_system
      comment: "Source payroll system"
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Pay date month for cash flow and trend analysis"
    - name: "period_end_month"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Period end month for accrual analysis"
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(1)
      comment: "Total payroll runs processed for operational volume tracking"
    - name: "total_gross_payroll"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross payroll amount — primary workforce cost metric"
    - name: "total_net_payroll"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payroll disbursed to employees"
    - name: "total_employer_tax_burden"
      expr: SUM(CAST(total_employer_tax AS DOUBLE))
      comment: "Total employer tax burden — critical for total labor cost calculation"
    - name: "total_employee_deductions"
      expr: SUM(CAST(total_employee_deductions AS DOUBLE))
      comment: "Total employee deductions (benefits, taxes, garnishments)"
    - name: "avg_gross_per_run"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross payroll per run for run-size benchmarking"
    - name: "manual_run_count"
      expr: COUNT(CASE WHEN is_manual_run = TRUE THEN 1 END)
      comment: "Count of manual payroll runs — operational efficiency indicator (manual runs indicate exceptions)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary action metrics for health insurance workforce — tracks disciplinary volumes, types, severity, repeat offenses, and appeal outcomes for employee relations management and risk mitigation."
  source: "`health_insurance_ecm`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (Verbal Warning, Written Warning, Suspension, Termination)"
    - name: "disciplinary_action_status"
      expr: disciplinary_action_status
      comment: "Status of the disciplinary action (Active, Resolved, Appealed)"
    - name: "disciplinary_action_category"
      expr: disciplinary_action_category
      comment: "Category of the disciplinary action for classification"
    - name: "policy_violated"
      expr: policy_violated
      comment: "Policy that was violated — identifies systemic compliance gaps"
    - name: "is_repeat_offense"
      expr: is_repeat_offense
      comment: "Whether this is a repeat offense — escalation risk indicator"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal process"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the action"
    - name: "action_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month of disciplinary action for trend analysis"
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total disciplinary actions — employee relations volume and culture health indicator"
    - name: "repeat_offense_count"
      expr: COUNT(CASE WHEN is_repeat_offense = TRUE THEN 1 END)
      comment: "Count of repeat offenses — identifies chronic behavioral issues requiring escalation"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per action for severity benchmarking"
    - name: "appealed_actions_count"
      expr: COUNT(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN 1 END)
      comment: "Count of disciplinary actions that were appealed — fairness and process quality indicator"
    - name: "distinct_employees_disciplined"
      expr: COUNT(DISTINCT primary_disciplinary_employee_id)
      comment: "Distinct employees receiving disciplinary actions — concentration risk analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning metrics for health insurance workforce — tracks approved vs filled FTE, budget variance, requisition pipeline, and diversity hiring for strategic workforce planning."
  source: "`health_insurance_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the headcount plan (Draft, Approved, Active, Closed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan"
    - name: "planning_period"
      expr: planning_period
      comment: "Planning period (Q1, Q2, H1, Annual, etc.)"
    - name: "department_code"
      expr: department_code
      comment: "Department for the headcount plan"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for budget allocation"
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of associated requisition"
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Planned source of hire"
    - name: "is_contractor"
      expr: is_contractor
      comment: "Whether the planned headcount is for contractors"
    - name: "diversity_hiring_indicator"
      expr: diversity_hiring_indicator
      comment: "Whether diversity hiring goals apply"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Compliance review status of the plan"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Effective month of the headcount plan"
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte AS DOUBLE))
      comment: "Total approved FTE across all headcount plans — authorized workforce capacity"
    - name: "total_filled_fte"
      expr: SUM(CAST(filled_fte AS DOUBLE))
      comment: "Total filled FTE — actual staffing level against plan"
    - name: "total_vacant_fte"
      expr: SUM(CAST(vacant_fte AS DOUBLE))
      comment: "Total vacant FTE — unfilled positions requiring recruitment action"
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance for headcount plans — financial planning accuracy"
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(budget_variance_percent AS DOUBLE))
      comment: "Average budget variance percentage — workforce budget adherence"
    - name: "headcount_plan_count"
      expr: COUNT(1)
      comment: "Total headcount plan records for planning coverage tracking"
    - name: "diversity_hiring_plan_count"
      expr: COUNT(CASE WHEN diversity_hiring_indicator = TRUE THEN 1 END)
      comment: "Count of plans with diversity hiring goals — DEI commitment tracking"
$$;