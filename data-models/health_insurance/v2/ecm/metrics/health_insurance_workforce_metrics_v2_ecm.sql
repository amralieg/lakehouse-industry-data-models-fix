-- Metric views for domain: workforce | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, tenure, turnover, and demographic distribution for strategic workforce planning and compliance reporting."
  source: "`vibe_health_insurance_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employee_status"
      expr: employee_status
      comment: "Current employment status (active, terminated, on leave, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor, etc.)"
    - name: "department"
      expr: department
      comment: "Department to which the employee is assigned"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the employee was hired"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year the employee was terminated (null if active)"
    - name: "gender"
      expr: gender
      comment: "Employee gender for diversity reporting"
    - name: "ethnicity"
      expr: ethnicity
      comment: "Employee ethnicity for diversity and compliance reporting"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of salary payment (weekly, biweekly, monthly, etc.)"
    - name: "health_plan_eligible"
      expr: health_plan_eligible
      comment: "Whether employee is eligible for health plan benefits"
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Whether employee is eligible for bonus compensation"
  measures:
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count - primary headcount metric for workforce planning and capacity analysis"
    - name: "total_active_employees"
      expr: COUNT(DISTINCT CASE WHEN employee_status = 'active' THEN employee_id END)
      comment: "Count of active employees - key metric for current workforce capacity and operational planning"
    - name: "total_terminated_employees"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of terminated employees - critical for turnover analysis and retention strategy"
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total salary expense across all employees - primary cost metric for budget planning and financial forecasting"
    - name: "avg_salary"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary per employee - key compensation benchmark for market competitiveness and equity analysis"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average employee tenure in days - critical retention metric for workforce stability and engagement assessment"
    - name: "health_plan_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN health_plan_eligible = true THEN employee_id END)
      comment: "Count of employees eligible for health benefits - drives benefits cost forecasting and compliance planning"
    - name: "bonus_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN bonus_eligible = true THEN employee_id END)
      comment: "Count of employees eligible for bonus compensation - impacts variable compensation budgeting and incentive program design"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll disbursement metrics tracking gross pay, net pay, tax withholdings, and hours worked for financial planning, labor cost analysis, and compliance reporting."
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_disbursement`"
  dimensions:
    - name: "pay_period_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month of the payroll period for trend analysis"
    - name: "pay_date"
      expr: pay_date
      comment: "Date payroll was disbursed"
    - name: "payroll_disbursement_status"
      expr: payroll_disbursement_status
      comment: "Status of payroll disbursement (processed, pending, failed, etc.)"
    - name: "payroll_disbursement_type"
      expr: payroll_disbursement_type
      comment: "Type of payroll disbursement (regular, bonus, adjustment, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (direct deposit, check, etc.)"
    - name: "cost_center"
      expr: cost_center_code
      comment: "Cost center code for financial allocation and departmental cost tracking"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for segmented labor cost analysis"
  measures:
    - name: "total_disbursements"
      expr: COUNT(1)
      comment: "Total number of payroll disbursements - volume metric for payroll operations and processing efficiency"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross payroll before deductions - primary labor cost metric for financial planning and P&L analysis"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net payroll after all deductions - actual cash outflow metric for treasury and liquidity management"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld AS DOUBLE))
      comment: "Total federal tax withholdings - critical for tax remittance compliance and cash flow forecasting"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld AS DOUBLE))
      comment: "Total state tax withholdings - required for multi-state tax compliance and remittance planning"
    - name: "total_fica_tax_withheld"
      expr: SUM(CAST(fica_tax_withheld AS DOUBLE))
      comment: "Total FICA tax withholdings - mandatory for Social Security compliance and employer liability tracking"
    - name: "total_medicare_tax_withheld"
      expr: SUM(CAST(medicare_tax_withheld AS DOUBLE))
      comment: "Total Medicare tax withholdings - required for Medicare compliance and employer contribution tracking"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked - baseline productivity metric for capacity planning and labor efficiency"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked - key metric for FLSA compliance, cost control, and workforce optimization"
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours used - impacts labor availability and accrued liability management"
    - name: "avg_gross_pay_per_disbursement"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per disbursement - benchmark for compensation consistency and anomaly detection"
    - name: "avg_net_pay_per_disbursement"
      expr: AVG(CAST(net_pay_amount AS DOUBLE))
      comment: "Average net pay per disbursement - employee take-home benchmark for compensation competitiveness"
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as percentage of regular hours - critical efficiency metric for labor cost optimization and burnout risk"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance review metrics tracking ratings, merit increases, and performance improvement plans for talent management, compensation planning, and organizational effectiveness."
  source: "`vibe_health_insurance_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_period_year"
      expr: YEAR(review_period_start)
      comment: "Year of the performance review period"
    - name: "review_period_month"
      expr: DATE_TRUNC('MONTH', review_period_start)
      comment: "Month of the performance review period start"
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary, etc.)"
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of the performance review (draft, completed, approved, etc.)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating assigned to the employee"
    - name: "department"
      expr: department
      comment: "Department of the employee being reviewed"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of calibration process for rating consistency"
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Whether employee is placed on performance improvement plan"
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the performance review has been finalized"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews - volume metric for HR operations and review cycle completion tracking"
    - name: "total_completed_reviews"
      expr: COUNT(CASE WHEN is_finalized = true THEN 1 END)
      comment: "Count of finalized performance reviews - completion rate driver for HR compliance and talent management effectiveness"
    - name: "total_pip_cases"
      expr: COUNT(CASE WHEN performance_improvement_plan_flag = true THEN 1 END)
      comment: "Count of employees on performance improvement plans - critical metric for retention risk and performance management intervention"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage - key compensation metric for budget planning and market competitiveness"
    - name: "total_merit_increase_amount"
      expr: SUM(CAST(merit_increase_recommendation_amount AS DOUBLE))
      comment: "Total merit increase dollars recommended - primary compensation budget impact metric for financial planning"
    - name: "avg_salary_adjustment"
      expr: AVG(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Average salary adjustment amount - compensation equity metric for pay parity and retention strategy"
    - name: "total_salary_adjustment"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustment dollars - aggregate compensation impact for budget forecasting and cost management"
    - name: "avg_goal_rating"
      expr: AVG(CAST(average_goal_rating AS DOUBLE))
      comment: "Average goal achievement rating - organizational performance metric for strategic objective attainment"
    - name: "review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_finalized = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews completed - HR operational efficiency metric for compliance and cycle management"
    - name: "pip_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_improvement_plan_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of employees on performance improvement plans - talent quality and retention risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave request metrics tracking leave utilization, FMLA eligibility, approval rates, and leave balances for workforce planning, compliance, and employee wellbeing analysis."
  source: "`vibe_health_insurance_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave requested (PTO, sick, FMLA, parental, etc.)"
    - name: "leave_request_status"
      expr: leave_request_status
      comment: "Status of the leave request (pending, approved, denied, cancelled)"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the leave request was submitted"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the leave period starts"
    - name: "fmla_eligible"
      expr: fmla_eligible
      comment: "Whether the leave request is FMLA eligible"
    - name: "ada_accommodation_required"
      expr: ada_accommodation_required
      comment: "Whether ADA accommodation is required for the leave"
    - name: "intermittent"
      expr: intermittent
      comment: "Whether the leave is intermittent (vs. continuous)"
    - name: "payroll_impact"
      expr: payroll_impact
      comment: "Whether the leave impacts payroll (paid vs. unpaid)"
  measures:
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests - volume metric for HR workload and leave program utilization"
    - name: "total_approved_requests"
      expr: COUNT(CASE WHEN leave_request_status = 'approved' THEN 1 END)
      comment: "Count of approved leave requests - approval rate driver for employee satisfaction and policy effectiveness"
    - name: "total_denied_requests"
      expr: COUNT(CASE WHEN leave_request_status = 'denied' THEN 1 END)
      comment: "Count of denied leave requests - policy friction metric for employee relations and operational constraints"
    - name: "total_requested_days"
      expr: SUM(CAST(requested_days AS DOUBLE))
      comment: "Total leave days requested - workforce availability impact metric for capacity planning"
    - name: "total_approved_days"
      expr: SUM(CAST(approved_days AS DOUBLE))
      comment: "Total leave days approved - actual workforce absence metric for operational planning and coverage needs"
    - name: "avg_requested_days"
      expr: AVG(CAST(requested_days AS DOUBLE))
      comment: "Average leave days per request - leave pattern metric for policy design and workforce planning"
    - name: "avg_approved_days"
      expr: AVG(CAST(approved_days AS DOUBLE))
      comment: "Average approved leave days per request - actual absence duration for staffing and coverage analysis"
    - name: "total_fmla_requests"
      expr: COUNT(CASE WHEN fmla_eligible = true THEN 1 END)
      comment: "Count of FMLA-eligible leave requests - compliance metric for federal leave law adherence and liability management"
    - name: "total_ada_accommodation_requests"
      expr: COUNT(CASE WHEN ada_accommodation_required = true THEN 1 END)
      comment: "Count of leave requests requiring ADA accommodation - compliance and inclusion metric for disability support"
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN leave_request_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests approved - employee satisfaction and policy flexibility indicator"
    - name: "fmla_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fmla_eligible = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests that are FMLA-eligible - compliance exposure and workforce health indicator"
    - name: "avg_leave_balance_before"
      expr: AVG(CAST(leave_balance_before AS DOUBLE))
      comment: "Average leave balance before request - accrued liability metric for financial planning and policy sustainability"
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average leave balance after request - remaining liability and employee benefit utilization metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion metrics tracking training hours, pass rates, expiration, and recertification for compliance, skill development, and workforce capability assessment."
  source: "`vibe_health_insurance_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (compliance, technical, leadership, etc.)"
    - name: "training_record_status"
      expr: training_record_status
      comment: "Status of the training record (completed, in-progress, expired, etc.)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the training was passed or failed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month the training was completed"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (online, in-person, hybrid, etc.)"
    - name: "is_expired"
      expr: is_expired
      comment: "Whether the training certification has expired"
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required for this training"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of training records - volume metric for learning and development program scale"
    - name: "total_completed_trainings"
      expr: COUNT(CASE WHEN training_record_status = 'completed' THEN 1 END)
      comment: "Count of completed training records - completion rate driver for compliance and skill development effectiveness"
    - name: "total_passed_trainings"
      expr: COUNT(CASE WHEN pass_fail_status = 'pass' THEN 1 END)
      comment: "Count of passed training assessments - learning effectiveness metric for program quality and employee capability"
    - name: "total_failed_trainings"
      expr: COUNT(CASE WHEN pass_fail_status = 'fail' THEN 1 END)
      comment: "Count of failed training assessments - training quality and employee readiness risk indicator"
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered - investment metric for learning and development spend and employee time allocation"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per record - training intensity metric for program design and time commitment"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across trainings - learning effectiveness and employee competency benchmark"
    - name: "total_expired_trainings"
      expr: COUNT(CASE WHEN is_expired = true THEN 1 END)
      comment: "Count of expired training certifications - compliance risk metric for recertification and regulatory adherence"
    - name: "total_recertification_required"
      expr: COUNT(CASE WHEN recertification_required = true THEN 1 END)
      comment: "Count of trainings requiring recertification - ongoing compliance workload and cost driver"
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of training assessments passed - training effectiveness and employee readiness metric"
    - name: "expiration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expired = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records expired - compliance risk and recertification program effectiveness indicator"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure metrics tracking base pay, bonuses, equity, and pay changes for total rewards strategy, budget planning, and compensation equity analysis."
  source: "`vibe_health_insurance_v1`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (salary, hourly, commission, etc.)"
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of the compensation record (active, pending, expired, etc.)"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for compensation change (promotion, merit, market adjustment, etc.)"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay (weekly, biweekly, monthly, etc.)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade or band assigned to the compensation"
    - name: "is_exempt"
      expr: is_exempt
      comment: "Whether the position is exempt from overtime (FLSA classification)"
    - name: "overtime_eligibility"
      expr: overtime_eligibility
      comment: "Whether the employee is eligible for overtime pay"
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus (annual, quarterly, spot, etc.)"
    - name: "equity_type"
      expr: equity_type
      comment: "Type of equity compensation (stock options, RSUs, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the compensation became effective"
  measures:
    - name: "total_compensation_records"
      expr: COUNT(1)
      comment: "Total number of compensation records - volume metric for compensation program complexity and change frequency"
    - name: "total_base_compensation"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base compensation across all records - primary fixed labor cost metric for budget planning and P&L forecasting"
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average base compensation per record - market competitiveness benchmark for talent acquisition and retention"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus compensation - variable pay cost metric for incentive program budgeting and performance alignment"
    - name: "avg_bonus_amount"
      expr: AVG(CAST(bonus_amount AS DOUBLE))
      comment: "Average bonus per record - variable pay benchmark for incentive competitiveness and program design"
    - name: "total_equity_amount"
      expr: SUM(CAST(equity_amount AS DOUBLE))
      comment: "Total equity compensation value - long-term incentive cost metric for retention and shareholder dilution analysis"
    - name: "avg_equity_amount"
      expr: AVG(CAST(equity_amount AS DOUBLE))
      comment: "Average equity compensation per record - equity program competitiveness and retention effectiveness metric"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly employees - labor cost benchmark for operational budgeting and market positioning"
    - name: "avg_incentive_target_pct"
      expr: AVG(CAST(incentive_target_pct AS DOUBLE))
      comment: "Average incentive target as percentage of base - variable pay mix metric for total rewards strategy"
    - name: "total_shift_differential"
      expr: SUM(CAST(shift_differential AS DOUBLE))
      comment: "Total shift differential pay - premium labor cost for non-standard hours and operational coverage"
    - name: "overtime_eligible_count"
      expr: COUNT(CASE WHEN overtime_eligibility = true THEN 1 END)
      comment: "Count of overtime-eligible positions - FLSA compliance metric and overtime cost exposure indicator"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment metrics tracking time-to-fill, applicant volume, offer acceptance, and hiring costs for talent acquisition effectiveness and workforce planning."
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_recruitment`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the recruitment requisition (open, filled, cancelled, etc.)"
    - name: "workforce_recruitment_status"
      expr: workforce_recruitment_status
      comment: "Overall recruitment status for the position"
    - name: "job_level"
      expr: job_level
      comment: "Level of the job being recruited (entry, mid, senior, executive)"
    - name: "source_of_hire"
      expr: source_of_hire
      comment: "Source channel for the hire (referral, job board, recruiter, etc.)"
    - name: "is_remote"
      expr: is_remote
      comment: "Whether the position is remote"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation for the position (salary, hourly, etc.)"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', job_posting_date)
      comment: "Month the job was posted"
    - name: "offer_accepted_month"
      expr: DATE_TRUNC('MONTH', offer_accepted_date)
      comment: "Month the offer was accepted"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of recruitment requisitions - hiring volume metric for talent acquisition workload and growth planning"
    - name: "total_filled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'filled' THEN 1 END)
      comment: "Count of filled requisitions - hiring success metric for talent acquisition effectiveness and workforce capacity"
    - name: "total_cancelled_requisitions"
      expr: COUNT(CASE WHEN requisition_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled requisitions - hiring plan volatility and business priority shift indicator"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(time_to_fill_days AS DOUBLE))
      comment: "Average days to fill a position - talent acquisition efficiency metric critical for workforce planning and operational readiness"
    - name: "avg_number_of_applicants"
      expr: AVG(CAST(number_of_applicants AS DOUBLE))
      comment: "Average applicants per requisition - employer brand strength and talent market competitiveness indicator"
    - name: "avg_salary_offer"
      expr: AVG(CAST(salary_offer_amount AS DOUBLE))
      comment: "Average salary offer amount - market competitiveness benchmark for talent acquisition and compensation strategy"
    - name: "total_salary_offers"
      expr: SUM(CAST(salary_offer_amount AS DOUBLE))
      comment: "Total salary offer dollars - new hire compensation cost metric for budget planning and financial forecasting"
    - name: "fill_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN requisition_status = 'filled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions filled - talent acquisition success rate for hiring effectiveness and workforce planning reliability"
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of offers accepted - employer attractiveness and compensation competitiveness metric"
    - name: "remote_position_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_remote = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positions that are remote - workforce flexibility and talent market access strategy indicator"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary action metrics tracking action types, repeat offenses, and outcomes for employee relations, compliance risk, and organizational culture assessment."
  source: "`vibe_health_insurance_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination, etc.)"
    - name: "disciplinary_action_status"
      expr: disciplinary_action_status
      comment: "Status of the disciplinary action (active, closed, under appeal, etc.)"
    - name: "disciplinary_action_category"
      expr: disciplinary_action_category
      comment: "Category of the disciplinary issue (attendance, performance, conduct, policy violation, etc.)"
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month the disciplinary action was taken"
    - name: "is_repeat_offense"
      expr: is_repeat_offense
      comment: "Whether this is a repeat offense by the employee"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against the disciplinary action"
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Whether the employee has acknowledged the disciplinary action"
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total number of disciplinary actions - employee relations volume metric for organizational culture and management effectiveness"
    - name: "total_repeat_offenses"
      expr: COUNT(CASE WHEN is_repeat_offense = true THEN 1 END)
      comment: "Count of repeat offense disciplinary actions - performance management effectiveness and termination risk indicator"
    - name: "total_suspensions"
      expr: COUNT(CASE WHEN action_type = 'suspension' THEN 1 END)
      comment: "Count of suspension actions - serious misconduct volume metric for workplace safety and culture risk"
    - name: "total_terminations"
      expr: COUNT(CASE WHEN action_type = 'termination' THEN 1 END)
      comment: "Count of termination actions - involuntary turnover metric for retention strategy and legal risk exposure"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed - monetary discipline cost metric for policy enforcement and employee relations"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average financial penalty per action - discipline severity benchmark for policy consistency and fairness"
    - name: "repeat_offense_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_offense = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary actions that are repeat offenses - performance management effectiveness and culture health indicator"
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_status IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary actions appealed - employee relations friction and policy fairness perception metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_background_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Background check metrics for health insurance workforce — tracks screening completion, OIG exclusion checks, adjudication outcomes, and costs critical for healthcare regulatory compliance and federal program access."
  source: "`vibe_health_insurance_v1`.`workforce`.`background_check`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_employee_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefit enrollment metrics for health insurance workforce — tracks enrollment volumes, contribution costs, coverage tiers, and ACA compliance for benefits administration and cost management."
  source: "`vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount planning metrics for health insurance workforce — tracks approved vs filled FTE, budget variance, requisition pipeline, and diversity hiring for strategic workforce planning."
  source: "`vibe_health_insurance_v1`.`workforce`.`headcount_plan`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run metrics for health insurance workforce — tracks payroll processing volumes, gross/net totals, employer tax burden, and deductions for financial planning and payroll operations management."
  source: "`vibe_health_insurance_v1`.`workforce`.`payroll_run`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_time_and_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and attendance metrics for health insurance workforce — tracks hours worked, overtime, absenteeism, and labor cost for operational efficiency and FLSA compliance."
  source: "`vibe_health_insurance_v1`.`workforce`.`time_and_attendance`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification metrics for health insurance — tracks certification status, renewals, costs, and compliance for clinical and regulatory certifications critical to healthcare operations."
  source: "`vibe_health_insurance_v1`.`workforce`.`workforce_certification`"
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