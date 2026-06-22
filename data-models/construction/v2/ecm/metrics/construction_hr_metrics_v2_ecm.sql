-- Metric views for domain: hr | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce composition and compensation analytics for strategic headcount and cost management decisions."
  source: "`vibe_construction_v1`.`hr`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Active, terminated, or on-leave status for workforce segmentation."
    - name: "employee_type"
      expr: employee_type
      comment: "Full-time, part-time, contractor classification for workforce mix analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department grouping for headcount and cost allocation reporting."
    - name: "location_code"
      expr: location_code
      comment: "Work location for geographic workforce distribution analysis."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for diversity and inclusion reporting. PII — masked in non-prod."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure cohort and attrition trend analysis."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Salary vs hourly vs commission classification for compensation mix analysis."
    - name: "education_level"
      expr: education_level
      comment: "Highest education attained for workforce capability benchmarking."
    - name: "performance_rating_last_year"
      expr: performance_rating_last_year
      comment: "Last annual performance rating for talent segmentation."
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total number of distinct employees — primary workforce size KPI used in every board-level headcount report."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of currently active employees; drives resource planning and capacity decisions."
    - name: "total_base_salary_cost"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total annualised base salary cost across the workforce; key input to labour cost budgeting and P&L forecasting."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary; used to benchmark compensation competitiveness and identify pay equity gaps."
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Terminated' THEN employee_id END)
      comment: "Count of terminated employees in the period; numerator for attrition rate calculation."
    - name: "attrition_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN employment_status = 'Terminated' THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of workforce that has been terminated; critical retention KPI tracked at every HR steering review."
    - name: "hse_training_compliance_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hse_training_completed = TRUE THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of employees who have completed mandatory HSE training; directly tied to site safety compliance and regulatory risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost analytics covering gross pay, net pay, deductions, and overtime for financial control and labour cost management."
  source: "`vibe_construction_v1`.`hr`.`payroll_record`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-entity payroll cost comparison."
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus paid for incentive cost analysis."
    - name: "is_off_cycle"
      expr: is_off_cycle
      comment: "Flag indicating off-cycle payroll runs for exception monitoring."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Payroll record processing status for reconciliation tracking."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll cost reporting and statutory compliance."
    - name: "superannuation_fund"
      expr: superannuation_fund
      comment: "Superannuation/pension fund for retirement contribution analysis."
  measures:
    - name: "total_gross_salary"
      expr: SUM(CAST(gross_salary AS DOUBLE))
      comment: "Total gross payroll cost; primary labour cost KPI for P&L and budget variance reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed; cash flow impact measure for treasury management."
    - name: "total_tax_deductions"
      expr: SUM(CAST(deduction_tax AS DOUBLE))
      comment: "Total tax withheld across all payroll records; required for statutory tax remittance reporting."
    - name: "total_bonus_paid"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus expenditure; tracked against incentive budget and used in compensation strategy reviews."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked; high overtime signals resourcing gaps and drives workforce planning decisions."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost; used to assess whether hiring additional staff is more cost-effective than ongoing overtime spend."
    - name: "avg_gross_salary_per_record"
      expr: AVG(CAST(gross_salary AS DOUBLE))
      comment: "Average gross salary per payroll record; used for compensation benchmarking and anomaly detection."
    - name: "total_ytd_gross"
      expr: SUM(CAST(year_to_date_gross AS DOUBLE))
      comment: "Sum of year-to-date gross earnings; used for annual labour cost forecasting and budget tracking."
    - name: "total_superannuation_deduction"
      expr: SUM(CAST(deduction_superannuation AS DOUBLE))
      comment: "Total superannuation/pension contributions; monitored for regulatory compliance and retirement liability management."
    - name: "total_salary_sacrifice_deduction"
      expr: SUM(CAST(deduction_salary_sacrifice AS DOUBLE))
      comment: "Total salary sacrifice deductions; used to assess tax-effective remuneration uptake and benefits cost."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run-level analytics for payroll cycle efficiency, cost control, and processing quality management."
  source: "`vibe_construction_v1`.`hr`.`payroll_run`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run for multi-entity reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period payroll cost trend analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual statutory payroll reporting."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag for manual vs automated payroll runs; manual runs indicate exceptions requiring investigation."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Processing status of the payroll run for operational monitoring."
  measures:
    - name: "total_payroll_runs"
      expr: COUNT(DISTINCT payroll_run_id)
      comment: "Total number of payroll runs processed; baseline for payroll operations volume tracking."
    - name: "total_gross_payroll"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll disbursed across all runs; primary labour cost KPI for CFO and board reporting."
    - name: "total_net_payroll"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll paid out; cash flow planning metric for treasury."
    - name: "total_deductions"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions across all payroll runs; used to reconcile gross-to-net and validate statutory obligations."
    - name: "avg_gross_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross payroll per run; used to detect anomalous payroll runs that may indicate errors or fraud."
    - name: "manual_run_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_manual = TRUE THEN payroll_run_id END) / NULLIF(COUNT(DISTINCT payroll_run_id), 0), 2)
      comment: "Percentage of payroll runs that are manual; high rates indicate process inefficiency and elevated error risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilisation and approval analytics for workforce availability planning and absence cost management."
  source: "`vibe_construction_v1`.`hr`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (annual, sick, parental, etc.) for absence pattern analysis."
    - name: "leave_status"
      expr: leave_status
      comment: "Approval status of leave requests for pipeline and backlog monitoring."
    - name: "leave_year"
      expr: leave_year
      comment: "Leave year for annual utilisation trend reporting."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Paid vs unpaid leave flag for cost impact analysis."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Approved, rejected, or pending decision for manager compliance monitoring."
    - name: "request_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of leave start for seasonal absence pattern analysis."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total leave requests submitted; baseline volume metric for HR operations capacity planning."
    - name: "total_leave_days_requested"
      expr: SUM(CAST(total_days AS DOUBLE))
      comment: "Total calendar days of leave requested; key input to workforce availability and project resourcing models."
    - name: "avg_leave_days_per_request"
      expr: AVG(CAST(total_days AS DOUBLE))
      comment: "Average duration of leave requests; used to identify unusual absence patterns and policy compliance."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_decision = 'Approved' THEN leave_request_id END) / NULLIF(COUNT(DISTINCT leave_request_id), 0), 2)
      comment: "Percentage of leave requests approved; low rates may indicate policy issues or manager bottlenecks."
    - name: "pending_leave_requests"
      expr: COUNT(DISTINCT CASE WHEN leave_status = 'Pending' THEN leave_request_id END)
      comment: "Count of unresolved leave requests; operational backlog metric for HR team SLA management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_leave_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave liability and accrual analytics for financial provisioning and workforce entitlement management."
  source: "`vibe_construction_v1`.`hr`.`leave_balance`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Leave type for entitlement liability breakdown by category."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Balance record status for active vs expired entitlement analysis."
    - name: "accrual_period"
      expr: accrual_period
      comment: "Accrual period for leave liability trend analysis."
    - name: "carryover_allowed"
      expr: carryover_allowed
      comment: "Whether carryover is permitted; affects year-end liability provisioning."
    - name: "as_of_date"
      expr: as_of_date
      comment: "Snapshot date for point-in-time leave liability reporting."
  measures:
    - name: "total_accrued_balance_days"
      expr: SUM(CAST(accrued_balance AS DOUBLE))
      comment: "Total accrued leave days across all employees; represents the organisation's leave liability for financial provisioning."
    - name: "total_available_balance_days"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available leave days; used to assess workforce availability risk and plan project resourcing."
    - name: "total_taken_balance_days"
      expr: SUM(CAST(taken_balance AS DOUBLE))
      comment: "Total leave days taken; used to measure actual absence impact on productivity."
    - name: "total_forfeited_balance_days"
      expr: SUM(CAST(forfeited_balance AS DOUBLE))
      comment: "Total forfeited leave days; indicates policy enforcement effectiveness and employee awareness gaps."
    - name: "total_pending_balance_days"
      expr: SUM(CAST(pending_balance AS DOUBLE))
      comment: "Total leave days pending approval; forward-looking availability risk metric for project managers."
    - name: "avg_available_balance_per_employee"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available leave balance per employee record; used to identify employees at risk of burnout (very low balance) or excessive accrual (very high balance)."
    - name: "leave_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(taken_balance AS DOUBLE)) / NULLIF(SUM(CAST(accrued_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued leave that has been taken; low utilisation signals burnout risk and growing financial liability."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management analytics for talent calibration, succession planning, and compensation decision support."
  source: "`vibe_construction_v1`.`hr`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Annual, mid-year, or probation review type for cycle-specific analysis."
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle identifier for year-over-year performance trend comparison."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Final performance rating for talent distribution and calibration analysis."
    - name: "hr_approval_status"
      expr: hr_approval_status
      comment: "HR sign-off status for process compliance monitoring."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Review lifecycle stage for pipeline and completion tracking."
    - name: "review_period_start_year"
      expr: YEAR(review_period_start)
      comment: "Year of review period for annual performance trend analysis."
    - name: "promotion_eligibility"
      expr: promotion_eligibility
      comment: "Whether the employee is eligible for promotion; used in succession and talent pipeline reporting."
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Bonus eligibility flag for incentive cost forecasting."
  measures:
    - name: "total_reviews_completed"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'Completed' THEN performance_review_id END)
      comment: "Count of completed performance reviews; measures HR process execution and manager compliance."
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average performance rating score across the workforce; key talent health indicator used in board talent reviews."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score; measures how effectively the workforce is delivering against strategic objectives."
    - name: "avg_competency_score"
      expr: AVG(CAST(competency_score AS DOUBLE))
      comment: "Average competency score; used to identify capability gaps requiring training investment."
    - name: "avg_technical_competency"
      expr: AVG(CAST(technical_competency AS DOUBLE))
      comment: "Average technical competency score; critical for construction workforce capability benchmarking."
    - name: "avg_safety_competency"
      expr: AVG(CAST(safety_competency AS DOUBLE))
      comment: "Average safety competency score; directly linked to site safety outcomes and regulatory compliance."
    - name: "promotion_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_eligibility = TRUE THEN performance_review_id END)
      comment: "Count of employees identified as promotion-eligible; drives succession pipeline and internal mobility strategy."
    - name: "total_salary_adjustment_amount"
      expr: SUM(CAST(salary_adjustment_amount AS DOUBLE))
      comment: "Total salary adjustment value from performance reviews; key input to compensation budget planning."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN lifecycle_status = 'Completed' THEN performance_review_id END) / NULLIF(COUNT(DISTINCT performance_review_id), 0), 2)
      comment: "Percentage of performance reviews completed on time; low completion rates indicate manager accountability issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline analytics for hiring velocity, cost management, and workforce gap closure."
  source: "`vibe_construction_v1`.`hr`.`recruitment_requisition`"
  dimensions:
    - name: "recruitment_requisition_status"
      expr: recruitment_requisition_status
      comment: "Requisition status for pipeline stage analysis and bottleneck identification."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contract classification for hiring mix analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Requisition priority for resource allocation in the recruitment team."
    - name: "job_grade"
      expr: job_grade
      comment: "Job grade for compensation benchmarking and budget impact assessment."
    - name: "remote_option"
      expr: remote_option
      comment: "Remote work eligibility for talent pool and location strategy analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of job posting for hiring velocity trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for salary budget comparison across regions."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN recruitment_requisition_status = 'Open' THEN recruitment_requisition_id END)
      comment: "Count of open requisitions; primary talent pipeline health metric used in workforce planning reviews."
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total requisitions raised; baseline hiring demand volume metric."
    - name: "avg_salary_budget_max"
      expr: AVG(CAST(salary_max AS DOUBLE))
      comment: "Average maximum salary budget per requisition; used to benchmark compensation offers and manage hiring cost."
    - name: "avg_salary_budget_min"
      expr: AVG(CAST(salary_min AS DOUBLE))
      comment: "Average minimum salary budget per requisition; used for compensation range analysis."
    - name: "total_salary_budget_max"
      expr: SUM(CAST(salary_max AS DOUBLE))
      comment: "Total maximum salary budget committed across open requisitions; key input to workforce cost forecasting."
    - name: "avg_expected_fte"
      expr: AVG(CAST(expected_fte AS DOUBLE))
      comment: "Average FTE expected per requisition; used to translate headcount plans into FTE capacity models."
    - name: "external_posting_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN external_job_posting = TRUE THEN recruitment_requisition_id END) / NULLIF(COUNT(DISTINCT recruitment_requisition_id), 0), 2)
      comment: "Percentage of requisitions posted externally; high rates may indicate insufficient internal talent pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel analytics for conversion rates, offer acceptance, and compensation competitiveness."
  source: "`vibe_construction_v1`.`hr`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current stage in the recruitment funnel for pipeline conversion analysis."
    - name: "source"
      expr: source
      comment: "Recruitment source channel for sourcing effectiveness and cost-per-hire analysis."
    - name: "offer_accepted"
      expr: offer_accepted
      comment: "Whether the offer was accepted; key conversion metric for recruitment effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for offer salary comparison across regions."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application for hiring pipeline velocity trend analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total applications received; baseline recruitment funnel volume metric."
    - name: "offer_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN offer_accepted = TRUE THEN application_id END) / NULLIF(COUNT(DISTINCT application_id), 0), 2)
      comment: "Percentage of offers accepted; critical recruitment effectiveness KPI — low rates indicate compensation or employer brand issues."
    - name: "avg_offer_salary_gross"
      expr: AVG(CAST(offer_salary_gross AS DOUBLE))
      comment: "Average gross salary offered; used to benchmark compensation competitiveness against market rates."
    - name: "avg_interview_score"
      expr: AVG(CAST(interview_score AS DOUBLE))
      comment: "Average interview score across all applications; used to calibrate assessment standards and predict quality of hire."
    - name: "total_salary_adjustment_cost"
      expr: SUM(CAST(salary_adjustment AS DOUBLE))
      comment: "Total salary adjustments made during offer negotiation; measures negotiation cost and compensation flexibility."
    - name: "avg_salary_adjustment"
      expr: AVG(CAST(salary_adjustment AS DOUBLE))
      comment: "Average salary adjustment per application; indicates how much negotiation headroom is being used and whether salary bands are competitive."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and cost analytics for workforce capability development and regulatory compliance management."
  source: "`vibe_construction_v1`.`hr`.`training_enrollment`"
  dimensions:
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Enrollment status for training pipeline and completion tracking."
    - name: "training_type"
      expr: training_type
      comment: "Type of training for capability investment analysis by category."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery mode (classroom, online, on-site) for training effectiveness and cost analysis."
    - name: "compliance_required"
      expr: compliance_required
      comment: "Whether training is mandatory for compliance; critical for regulatory risk management."
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Assessment outcome for training effectiveness measurement."
    - name: "certificate_issued"
      expr: certificate_issued
      comment: "Whether a certificate was issued; tracks formal qualification attainment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for training cost analysis across regions."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month of training completion for capacity and throughput trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total training enrollments; baseline workforce development activity volume metric."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN training_enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(DISTINCT training_enrollment_id), 0), 2)
      comment: "Percentage of training enrollments completed; key L&D effectiveness KPI tracked in board talent reviews."
    - name: "compliance_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_required = TRUE AND training_enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN compliance_required = TRUE THEN training_enrollment_id END), 0), 2)
      comment: "Completion rate for mandatory compliance training; directly tied to regulatory risk and audit findings."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training expenditure; used to track L&D budget utilisation and cost-per-employee training investment."
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training enrollment; used to optimise training delivery mix and vendor selection."
    - name: "total_training_hours"
      expr: SUM(CAST(hours AS DOUBLE))
      comment: "Total training hours delivered; measures workforce capability investment volume for ESG and HR reporting."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all enrollments; measures training quality and knowledge retention."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN certificate_issued = TRUE THEN training_enrollment_id END) / NULLIF(COUNT(DISTINCT training_enrollment_id), 0), 2)
      comment: "Percentage of enrollments resulting in a certificate; tracks formal qualification attainment rate for workforce credentialing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_compensation_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation cycle analytics for budget management, equity analysis, and salary increase effectiveness."
  source: "`vibe_construction_v1`.`hr`.`compensation_review`"
  dimensions:
    - name: "review_cycle"
      expr: review_cycle
      comment: "Compensation review cycle for year-over-year salary movement analysis."
    - name: "review_status"
      expr: review_status
      comment: "Review processing status for cycle completion monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and sign-off tracking."
    - name: "increase_type"
      expr: increase_type
      comment: "Merit, promotion, market adjustment classification for compensation movement analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department for compensation equity and budget allocation analysis."
    - name: "grade_level"
      expr: grade_level
      comment: "Job grade for compensation band compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-entity compensation comparison."
    - name: "is_promoted"
      expr: is_promoted
      comment: "Promotion flag for separating merit increases from promotional uplifts."
    - name: "review_year"
      expr: review_year
      comment: "Review year for annual compensation cycle trend reporting."
  measures:
    - name: "total_salary_increase_cost"
      expr: SUM((CAST(new_salary AS DOUBLE)) - (CAST(current_salary AS DOUBLE)))
      comment: "Total incremental salary cost from the compensation review cycle; primary budget impact metric for CFO approval."
    - name: "avg_salary_increase_pct"
      expr: AVG(CAST(increase_percentage AS DOUBLE))
      comment: "Average salary increase percentage; benchmarked against market and inflation to assess compensation competitiveness."
    - name: "total_new_salary_cost"
      expr: SUM(CAST(new_salary AS DOUBLE))
      comment: "Total new salary cost post-review; used to update the forward labour cost forecast."
    - name: "total_current_salary_cost"
      expr: SUM(CAST(current_salary AS DOUBLE))
      comment: "Total current salary cost pre-review; baseline for budget variance calculation."
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total compensation budget consumed in the review cycle; tracked against approved budget pool."
    - name: "total_budget_remaining"
      expr: SUM(CAST(budget_remaining_amount AS DOUBLE))
      comment: "Total compensation budget remaining; used to manage late-cycle adjustments and exceptions."
    - name: "avg_internal_equity_score"
      expr: AVG(CAST(internal_equity_score AS DOUBLE))
      comment: "Average internal equity score; low scores indicate pay equity issues requiring corrective action."
    - name: "avg_market_rate"
      expr: AVG(CAST(market_rate AS DOUBLE))
      comment: "Average market rate for benchmarked roles; used to assess whether compensation is competitive enough to retain talent."
    - name: "promotion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_promoted = TRUE THEN compensation_review_id END) / NULLIF(COUNT(DISTINCT compensation_review_id), 0), 2)
      comment: "Percentage of reviews resulting in a promotion; tracks internal mobility and career progression health."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and cost analytics for total rewards management and employee wellbeing investment tracking."
  source: "`vibe_construction_v1`.`hr`.`benefit_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Benefit plan type (health, dental, retirement, etc.) for benefits mix analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Active, waived, or terminated enrollment status for participation tracking."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Employee-only, family, or partner coverage tier for cost liability analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for annual benefits cost trend reporting."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether the employee waived the benefit; used to assess opt-out rates and plan attractiveness."
    - name: "open_enrollment_flag"
      expr: open_enrollment_flag
      comment: "Open enrollment vs qualifying event change for enrollment pattern analysis."
    - name: "contribution_currency"
      expr: contribution_currency
      comment: "Currency for multi-entity benefits cost comparison."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Active' THEN benefit_enrollment_id END)
      comment: "Total active benefit enrollments; baseline for benefits participation and cost liability reporting."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer benefits contribution cost; key component of total compensation cost for P&L and budget management."
    - name: "total_employee_contribution"
      expr: SUM(CAST(elected_contribution_amount AS DOUBLE))
      comment: "Total employee-elected contribution amounts; used to assess employee cost-sharing and plan affordability."
    - name: "avg_employer_contribution_per_enrollment"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per enrollment; used to benchmark benefits generosity and manage total rewards cost."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN waiver_flag = TRUE THEN benefit_enrollment_id END) / NULLIF(COUNT(DISTINCT benefit_enrollment_id), 0), 2)
      comment: "Percentage of eligible employees who waived benefits; high waiver rates may indicate plan design or affordability issues."
    - name: "avg_benefit_cost_share"
      expr: AVG(CAST(benefit_cost_share AS DOUBLE))
      comment: "Average benefit cost share per enrollment; used to evaluate the employer-employee cost split and total rewards competitiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning analytics for FTE gap management, attrition forecasting, and headcount budget control."
  source: "`vibe_construction_v1`.`hr`.`workforce_headcount_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (annual, rolling, project-based) for planning horizon analysis."
    - name: "workforce_headcount_plan_status"
      expr: workforce_headcount_plan_status
      comment: "Plan approval and execution status for governance tracking."
    - name: "job_family"
      expr: job_family
      comment: "Job family for workforce mix and capability planning analysis."
    - name: "job_grade"
      expr: job_grade
      comment: "Job grade for compensation cost modelling within headcount plans."
    - name: "period"
      expr: period
      comment: "Planning period for time-series headcount trend analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the plan takes effect for annual planning cycle alignment."
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte AS DOUBLE))
      comment: "Total planned FTE across all headcount plans; primary workforce capacity planning metric."
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE achieved; compared against planned FTE to identify resourcing gaps."
    - name: "total_fte_variance"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (actual vs planned); negative variance signals under-resourcing risk for project delivery."
    - name: "avg_attrition_rate_pct"
      expr: AVG(CAST(attrition_rate_percent AS DOUBLE))
      comment: "Average planned attrition rate; used to size replacement hiring needs and model workforce stability."
    - name: "fte_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_fte AS DOUBLE)) / NULLIF(SUM(CAST(planned_fte AS DOUBLE)), 0), 2)
      comment: "Percentage of planned FTE that has been filled; critical resourcing KPI for project delivery risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations analytics for disciplinary case management, severity tracking, and HR risk monitoring."
  source: "`vibe_construction_v1`.`hr`.`disciplinary_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of disciplinary case for pattern analysis and policy gap identification."
    - name: "disciplinary_case_status"
      expr: disciplinary_case_status
      comment: "Case processing status for open case backlog management."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level for resource allocation in HR case management."
    - name: "outcome"
      expr: outcome
      comment: "Case outcome (warning, termination, no action) for disciplinary effectiveness analysis."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Whether an appeal was lodged; high appeal rates indicate process fairness concerns."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Confidentiality flag for access control and reporting segmentation."
    - name: "case_source"
      expr: case_source
      comment: "Source of the disciplinary case for root cause and reporting channel analysis."
  measures:
    - name: "total_open_cases"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_case_status = 'Open' THEN disciplinary_case_id END)
      comment: "Count of open disciplinary cases; operational HR risk metric monitored in ER steering reviews."
    - name: "total_cases"
      expr: COUNT(DISTINCT disciplinary_case_id)
      comment: "Total disciplinary cases raised; baseline ER activity volume for trend and benchmarking analysis."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN appeal_filed = TRUE THEN disciplinary_case_id END) / NULLIF(COUNT(DISTINCT disciplinary_case_id), 0), 2)
      comment: "Percentage of cases where an appeal was filed; high rates signal process fairness or consistency issues requiring policy review."
    - name: "termination_outcome_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN outcome = 'Termination' THEN disciplinary_case_id END) / NULLIF(COUNT(DISTINCT disciplinary_case_id), 0), 2)
      comment: "Percentage of disciplinary cases resulting in termination; used to assess severity distribution and HR risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`hr_separation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee separation analytics for attrition cost, rehire eligibility, and exit quality management."
  source: "`vibe_construction_v1`.`hr`.`separation`"
  dimensions:
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for separation for voluntary vs involuntary attrition analysis."
    - name: "exit_interview_completed"
      expr: exit_interview_completed
      comment: "Whether exit interview was conducted; tracks HR process compliance and data quality for attrition insights."
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Whether the employee is eligible for rehire; used in talent pool management."
    - name: "equipment_return_status"
      expr: equipment_return_status
      comment: "Asset return status for offboarding compliance and asset recovery tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for severance cost analysis across regions."
  measures:
    - name: "total_separations"
      expr: COUNT(DISTINCT separation_id)
      comment: "Total employee separations; primary attrition volume metric for workforce stability reporting."
    - name: "total_severance_cost"
      expr: SUM(CAST(severance_pay_amount AS DOUBLE))
      comment: "Total severance pay disbursed; key financial liability metric for HR and finance budget management."
    - name: "total_final_pay_amount"
      expr: SUM(CAST(final_pay_amount AS DOUBLE))
      comment: "Total final pay amounts; used to reconcile payroll obligations at separation and manage cash flow."
    - name: "exit_interview_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exit_interview_completed = TRUE THEN separation_id END) / NULLIF(COUNT(DISTINCT separation_id), 0), 2)
      comment: "Percentage of separations with a completed exit interview; low rates reduce the quality of attrition insight available to leadership."
    - name: "rehire_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rehire_eligibility_flag = TRUE THEN separation_id END) / NULLIF(COUNT(DISTINCT separation_id), 0), 2)
      comment: "Percentage of separated employees eligible for rehire; used to size the boomerang talent pool for future recruitment."
    - name: "avg_severance_per_separation"
      expr: AVG(CAST(severance_pay_amount AS DOUBLE))
      comment: "Average severance cost per separation; used to model future separation liability and benchmark against policy entitlements."
$$;