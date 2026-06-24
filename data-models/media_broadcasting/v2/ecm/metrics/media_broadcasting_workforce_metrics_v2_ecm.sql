-- Metric views for domain: workforce | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and demographic metrics for executive workforce planning, diversity reporting, and attrition analysis."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status_id
      comment: "Current employment status of the employee (active, on-leave, terminated) for headcount segmentation."
    - name: "employment_type"
      expr: employment_type_id
      comment: "Full-time, part-time, contractor classification for workforce composition analysis."
    - name: "job_level"
      expr: job_level_id
      comment: "Seniority/grade level for compensation band and promotion pipeline analysis."
    - name: "gender"
      expr: gender
      comment: "Gender identity for EEO and diversity reporting (PII-tagged, masked in non-prod)."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire for cohort-based tenure and attrition trend analysis."
    - name: "termination_year"
      expr: DATE_TRUNC('YEAR', termination_date)
      comment: "Year of termination for attrition cohort analysis."
    - name: "nationality"
      expr: nationality
      comment: "Employee nationality for global workforce distribution and work-authorization compliance tracking."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records; primary headcount KPI for workforce planning and budget allocation."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN termination_date IS NULL THEN 1 END)
      comment: "Count of employees without a termination date, representing current active workforce size."
    - name: "terminated_headcount"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of terminated employees in the period; drives attrition rate calculation."
    - name: "distinct_org_units_staffed"
      expr: COUNT(DISTINCT org_unit_id)
      comment: "Number of distinct org units with at least one employee; measures organizational breadth and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost, compensation structure, and labor expense metrics for finance and HR leadership to manage total compensation spend and overtime exposure."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "payroll_status"
      expr: payroll_status_id
      comment: "Processing status of the payroll record (processed, pending, error) for payroll run quality monitoring."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay cadence (weekly, bi-weekly, monthly) for cash-flow and payroll scheduling analysis."
    - name: "pay_period_start"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month of pay period start for trend analysis of labor costs over time."
    - name: "payment_method"
      expr: payment_method
      comment: "Direct deposit vs. check for payroll operations efficiency tracking."
    - name: "cost_center"
      expr: cost_center_id
      comment: "Cost center allocation for departmental labor cost attribution and budget variance analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll expense across all employees; primary labor cost KPI for finance and CFO reporting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed; used for cash-flow forecasting and treasury management."
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime compensation paid; high overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked; leading indicator of workforce capacity strain and burnout risk."
    - name: "total_regular_pay"
      expr: SUM(CAST(regular_pay AS DOUBLE))
      comment: "Total base/regular pay component; baseline for compensation benchmarking and budget planning."
    - name: "total_bonus_pay"
      expr: SUM(CAST(bonus_pay AS DOUBLE))
      comment: "Total bonus compensation paid; tracks variable pay spend against incentive plan budgets."
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total payroll deductions (taxes, benefits, garnishments); used for benefits cost analysis and compliance."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record; benchmark for compensation equity and market competitiveness analysis."
    - name: "total_employer_tax_burden"
      expr: SUM(CAST(social_security_tax AS DOUBLE) + CAST(medicare_tax AS DOUBLE))
      comment: "Total employer-side payroll tax liability (FICA); critical for total compensation cost modeling."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked; denominator for productivity and cost-per-hour calculations."
    - name: "payroll_record_count"
      expr: COUNT(1)
      comment: "Total payroll records processed; used to validate payroll run completeness against expected headcount."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure analytics for HR and finance to manage salary bands, bonus eligibility, and total compensation cost by org unit and job profile."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`compensation_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type_id
      comment: "Type of compensation plan (base, incentive, equity) for compensation mix analysis."
    - name: "plan_status"
      expr: plan_status_id
      comment: "Current status of the compensation plan (active, pending, expired) for governance tracking."
    - name: "approval_status"
      expr: approval_status_id
      comment: "Approval workflow status for compensation change governance and audit compliance."
    - name: "flsa_classification"
      expr: flsa_classification_id
      comment: "FLSA exempt/non-exempt classification for overtime eligibility and labor law compliance."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit for departmental compensation cost attribution."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay cadence for cash-flow planning and compensation structure benchmarking."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year compensation plan became effective for trend analysis of compensation changes."
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total annualized base salary across all active compensation plans; primary fixed labor cost KPI."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary; used for compensation benchmarking against market data and equity analysis."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for hourly workers; benchmark for wage competitiveness and minimum wage compliance."
    - name: "avg_target_bonus_percent"
      expr: AVG(CAST(target_bonus_percent AS DOUBLE))
      comment: "Average target bonus percentage; measures variable pay generosity and incentive plan design."
    - name: "bonus_eligible_count"
      expr: COUNT(CASE WHEN bonus_eligible = TRUE THEN 1 END)
      comment: "Number of employees eligible for bonus; drives incentive plan budget forecasting."
    - name: "overtime_eligible_count"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN 1 END)
      comment: "Number of overtime-eligible employees; key input for overtime cost risk modeling."
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average contracted weekly hours; used for FTE calculation and workforce capacity planning."
    - name: "compensation_plan_count"
      expr: COUNT(1)
      comment: "Total active compensation plans; used to validate coverage against headcount and identify gaps."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management metrics for HR and business leaders to assess talent quality, identify high performers, manage promotion pipelines, and drive compensation decisions."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type_id
      comment: "Type of review (annual, mid-year, probationary) for performance cycle analysis."
    - name: "review_status"
      expr: review_status_id
      comment: "Current status of the review (in-progress, completed, approved) for cycle completion tracking."
    - name: "review_period_start_year"
      expr: DATE_TRUNC('YEAR', review_period_start_date)
      comment: "Year of review period for year-over-year performance trend analysis."
    - name: "promotion_eligible_flag"
      expr: promotion_eligible_flag
      comment: "Whether the employee was flagged as promotion-eligible; drives succession planning and talent pipeline reporting."
    - name: "succession_planning_flag"
      expr: succession_planning_flag
      comment: "Whether the employee is included in succession planning; critical for leadership pipeline visibility."
    - name: "compensation_adjustment_recommended_flag"
      expr: compensation_adjustment_recommended_flag
      comment: "Whether a compensation adjustment was recommended; links performance outcomes to compensation decisions."
  measures:
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating across all completed reviews; primary talent quality KPI for leadership."
    - name: "avg_goal_achievement_score"
      expr: AVG(CAST(goal_achievement_score AS DOUBLE))
      comment: "Average goal achievement score; measures how effectively the workforce is delivering on business objectives."
    - name: "avg_technical_skills_rating"
      expr: AVG(CAST(technical_skills_rating AS DOUBLE))
      comment: "Average technical skills rating; identifies skill gaps requiring training investment or hiring."
    - name: "avg_leadership_rating"
      expr: AVG(CAST(leadership_rating AS DOUBLE))
      comment: "Average leadership rating; key input for succession planning and management development programs."
    - name: "promotion_eligible_count"
      expr: COUNT(CASE WHEN promotion_eligible_flag = TRUE THEN 1 END)
      comment: "Number of employees flagged as promotion-eligible; drives talent pipeline and succession planning decisions."
    - name: "avg_recommended_compensation_adjustment_pct"
      expr: AVG(CAST(recommended_compensation_adjustment_percent AS DOUBLE))
      comment: "Average recommended compensation adjustment percentage; used to forecast merit increase budget requirements."
    - name: "review_completion_count"
      expr: COUNT(1)
      comment: "Total performance reviews completed; used to track review cycle completion rate against headcount."
    - name: "employee_dispute_count"
      expr: COUNT(CASE WHEN employee_dispute_flag = TRUE THEN 1 END)
      comment: "Number of reviews with employee disputes filed; signals management quality issues or process fairness concerns."
    - name: "avg_final_approved_rating"
      expr: AVG(CAST(final_approved_rating AS DOUBLE))
      comment: "Average post-calibration approved rating; the definitive performance score used for compensation and promotion decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave utilization and absence management metrics for HR and operations to monitor workforce availability, FMLA compliance, and leave liability."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type_id
      comment: "Type of leave (vacation, sick, FMLA, parental) for absence pattern analysis by category."
    - name: "approval_status"
      expr: approval_status_id
      comment: "Approval status of the leave request for workflow compliance and manager accountability tracking."
    - name: "fmla_protected_flag"
      expr: fmla_protected_flag
      comment: "Whether the leave is FMLA-protected; critical for legal compliance monitoring and risk management."
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether the leave is paid or unpaid; drives payroll cost impact and leave liability calculations."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month leave was requested for seasonal absence trend analysis and workforce availability planning."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit for departmental absence rate benchmarking."
  measures:
    - name: "total_days_requested"
      expr: SUM(CAST(total_days_requested AS DOUBLE))
      comment: "Total leave days requested; primary absence volume KPI for workforce availability planning."
    - name: "total_days_taken"
      expr: SUM(CAST(actual_days_taken AS DOUBLE))
      comment: "Total leave days actually taken; used to calculate actual absence rates and productivity impact."
    - name: "avg_days_per_request"
      expr: AVG(CAST(total_days_requested AS DOUBLE))
      comment: "Average leave duration per request; identifies patterns of extended absence that may signal engagement or health issues."
    - name: "fmla_leave_request_count"
      expr: COUNT(CASE WHEN fmla_protected_flag = TRUE THEN 1 END)
      comment: "Number of FMLA-protected leave requests; key compliance metric for legal risk management."
    - name: "leave_request_count"
      expr: COUNT(1)
      comment: "Total leave requests submitted; baseline for absence rate calculation against headcount."
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN denial_reason_code_id IS NOT NULL THEN 1 END)
      comment: "Number of denied leave requests; high denial rates may indicate policy issues or manager bias requiring HR intervention."
    - name: "total_hours_requested"
      expr: SUM(CAST(total_hours_requested AS DOUBLE))
      comment: "Total leave hours requested; used for hourly workforce availability and scheduling impact analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_leave_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave liability and accrual metrics for finance and HR to manage leave balance liabilities, carryover risk, and accrual compliance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`leave_balance`"
  dimensions:
    - name: "leave_type_code"
      expr: leave_type_code_id
      comment: "Leave type code for balance analysis by leave category (vacation, sick, PTO)."
    - name: "eligibility_status"
      expr: eligibility_status_id
      comment: "Eligibility status for leave type; identifies employees approaching or exceeding eligibility thresholds."
    - name: "policy_tier"
      expr: policy_tier_id
      comment: "Policy tier governing accrual rates; used for equity analysis across employee tiers."
    - name: "balance_as_of_month"
      expr: DATE_TRUNC('MONTH', balance_as_of_date)
      comment: "Month of balance snapshot for trend analysis of leave liability over time."
    - name: "is_active"
      expr: is_active
      comment: "Whether the leave balance record is currently active; filters to current-state balances."
  measures:
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available leave balance across all employees; represents the organization's leave liability on the balance sheet."
    - name: "total_liability_amount"
      expr: SUM(CAST(liability_amount AS DOUBLE))
      comment: "Total monetary value of accrued leave liability; critical for financial reporting and balance sheet accuracy."
    - name: "avg_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available leave balance per employee; identifies over-accrual risk and encourages leave utilization."
    - name: "total_forfeited_balance"
      expr: SUM(CAST(forfeited_balance AS DOUBLE))
      comment: "Total leave days forfeited due to carryover caps; measures policy enforcement and employee communication effectiveness."
    - name: "total_accrued_current_period"
      expr: SUM(CAST(accrued_current_period AS DOUBLE))
      comment: "Total leave days accrued in the current period; used for payroll accrual journal entries."
    - name: "total_used_current_period"
      expr: SUM(CAST(used_current_period AS DOUBLE))
      comment: "Total leave days used in the current period; measures actual absence impact on workforce capacity."
    - name: "avg_accrual_rate"
      expr: AVG(CAST(accrual_rate AS DOUBLE))
      comment: "Average leave accrual rate; used to validate policy consistency and benchmark against industry norms."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development effectiveness metrics for HR and compliance to track training completion rates, regulatory compliance, and L&D investment ROI."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status_id
      comment: "Current enrollment status (enrolled, completed, withdrawn, failed) for training pipeline analysis."
    - name: "enrollment_type"
      expr: enrollment_type_id
      comment: "How the employee was enrolled (self-enrolled, manager-assigned, system-auto) for engagement analysis."
    - name: "training_delivery_method"
      expr: training_delivery_method_id
      comment: "Delivery modality (in-person, e-learning, virtual) for L&D channel effectiveness analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the training is mandatory; mandatory completion rates are a compliance KPI."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the training is required by regulation; non-completion creates legal and compliance risk."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for training demand trend analysis and capacity planning."
  measures:
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total L&D spend across all enrollments; primary training investment KPI for budget management."
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training enrollment; used for L&D ROI analysis and vendor cost benchmarking."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed across the workforce; measures L&D throughput and learning culture investment."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across completed trainings; measures training effectiveness and knowledge retention."
    - name: "completion_count"
      expr: COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END)
      comment: "Number of training enrollments completed; numerator for completion rate calculation."
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total training enrollments; denominator for completion rate and per-capita training investment calculations."
    - name: "mandatory_completion_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND completion_date IS NOT NULL THEN 1 END)
      comment: "Number of mandatory training completions; critical compliance KPI — gaps trigger regulatory risk."
    - name: "mandatory_enrollment_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Total mandatory training enrollments; denominator for mandatory completion rate compliance reporting."
    - name: "withdrawal_count"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of training withdrawals; high withdrawal rates signal scheduling conflicts or course quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefits participation and cost metrics for HR and finance to manage benefits spend, enrollment rates, and plan utilization across the workforce."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment`"
  dimensions:
    - name: "benefit_plan"
      expr: benefit_plan_id
      comment: "Specific benefit plan for plan-level participation and cost analysis."
    - name: "enrollment_status"
      expr: enrollment_status_id
      comment: "Current enrollment status (active, waived, terminated) for benefits coverage tracking."
    - name: "plan_type"
      expr: plan_type_id
      comment: "Type of benefit plan (medical, dental, vision, 401k) for benefits mix and cost analysis."
    - name: "coverage_tier"
      expr: coverage_tier_id
      comment: "Coverage tier (employee-only, employee+spouse, family) for premium cost segmentation."
    - name: "qualifying_event_type"
      expr: qualifying_event_type_id
      comment: "Qualifying life event triggering enrollment change; tracks mid-year enrollment activity."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrollment for annual open enrollment cycle analysis."
    - name: "tobacco_user_flag"
      expr: tobacco_user_flag
      comment: "Tobacco user status for wellness surcharge and health risk cost modeling."
  measures:
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee-side benefit premium contributions; used for total compensation cost modeling."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer-side benefit cost; primary benefits spend KPI for HR budget management."
    - name: "total_premium_cost"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total combined premium cost (employer + employee); full benefits liability for financial planning."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount per enrollment; used for benefits adequacy and risk exposure analysis."
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total benefit enrollments; baseline for participation rate calculation against eligible headcount."
    - name: "waived_enrollment_count"
      expr: COUNT(CASE WHEN waiver_reason IS NOT NULL THEN 1 END)
      comment: "Number of employees who waived benefits; high waiver rates may indicate affordability or plan design issues."
    - name: "avg_annual_election_amount"
      expr: AVG(CAST(annual_election_amount AS DOUBLE))
      comment: "Average annual FSA/HSA election amount; used for tax-advantaged account utilization analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline metrics for HR and business leaders to manage time-to-fill, hiring velocity, and recruitment cost against headcount plans."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status_id
      comment: "Current status of the requisition (open, filled, cancelled, on-hold) for pipeline health monitoring."
    - name: "requisition_type"
      expr: requisition_type_id
      comment: "Type of requisition (backfill, new headcount, contract) for hiring demand analysis."
    - name: "employment_type"
      expr: employment_type_id
      comment: "Employment type being recruited for (FT, PT, contractor) for workforce mix planning."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit with the open requisition for departmental hiring demand analysis."
    - name: "priority_level"
      expr: priority_level_id
      comment: "Requisition priority for resource allocation in the recruiting function."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month requisition was opened for hiring velocity trend analysis."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Whether the role is remote-eligible; tracks remote work strategy execution."
  measures:
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN close_date IS NULL THEN 1 END)
      comment: "Number of currently open requisitions; primary talent pipeline KPI for workforce planning."
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total requisitions created; measures overall hiring demand volume."
    - name: "avg_salary_range_midpoint"
      expr: AVG((CAST(salary_range_minimum AS DOUBLE) + CAST(salary_range_maximum AS DOUBLE)) / 2.0)
      comment: "Average salary range midpoint across open requisitions; used for compensation budget forecasting."
    - name: "total_salary_range_maximum"
      expr: SUM(CAST(salary_range_maximum AS DOUBLE))
      comment: "Sum of maximum salary ranges for all open requisitions; worst-case compensation budget exposure."
    - name: "union_position_count"
      expr: COUNT(CASE WHEN union_position = TRUE THEN 1 END)
      comment: "Number of union requisitions; tracks CBA compliance and union workforce growth."
    - name: "security_clearance_required_count"
      expr: COUNT(CASE WHEN security_clearance_required = TRUE THEN 1 END)
      comment: "Number of requisitions requiring security clearance; drives specialized recruiting resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce planning metrics for HR leadership and finance to track headcount budget vs. actuals, diversity hiring targets, and attrition assumptions."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type_id
      comment: "Type of headcount plan (annual, quarterly, scenario) for planning cycle analysis."
    - name: "plan_approval_status"
      expr: plan_approval_status_id
      comment: "Approval status of the headcount plan for governance and budget authorization tracking."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit the headcount plan covers for departmental workforce planning analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the headcount plan for year-over-year workforce growth analysis."
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (base, optimistic, conservative) for scenario-based workforce modeling."
    - name: "critical_role_flag"
      expr: critical_role_flag
      comment: "Whether the plan covers critical roles; prioritizes succession and retention investment."
  measures:
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte_count AS DOUBLE))
      comment: "Total approved FTE headcount across all plans; primary workforce budget authorization KPI."
    - name: "total_current_filled_fte"
      expr: SUM(CAST(current_filled_fte AS DOUBLE))
      comment: "Total currently filled FTE positions; measures actual staffing against approved headcount."
    - name: "total_variance_fte"
      expr: SUM(CAST(variance_fte AS DOUBLE))
      comment: "Total FTE variance (approved minus filled); negative variance signals over-staffing, positive signals open positions."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total headcount budget across all plans; primary financial authorization for workforce spend."
    - name: "avg_attrition_assumption_pct"
      expr: AVG(CAST(attrition_assumption_percentage AS DOUBLE))
      comment: "Average attrition assumption used in planning; validates planning assumptions against actual attrition rates."
    - name: "avg_diversity_hiring_target_pct"
      expr: AVG(CAST(diversity_hiring_target_percentage AS DOUBLE))
      comment: "Average diversity hiring target percentage; tracks DEI commitment in workforce planning."
    - name: "total_contractor_fte"
      expr: SUM(CAST(contractor_fte_count AS DOUBLE))
      comment: "Total planned contractor FTE; measures contingent workforce dependency and associated cost risk."
    - name: "total_union_fte"
      expr: SUM(CAST(union_fte_count AS DOUBLE))
      comment: "Total planned union FTE; tracks CBA workforce obligations and union labor cost planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_separation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attrition and offboarding metrics for HR and finance to analyze voluntary vs. involuntary turnover, severance costs, and rehire eligibility."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`separation_record`"
  dimensions:
    - name: "separation_type"
      expr: separation_type
      comment: "Type of separation (voluntary, involuntary, retirement, layoff) for attrition root-cause analysis."
    - name: "separation_reason_code"
      expr: separation_reason_code
      comment: "Specific reason for separation for detailed attrition driver analysis."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit of the separated employee for departmental attrition rate analysis."
    - name: "separation_month"
      expr: DATE_TRUNC('MONTH', separation_date)
      comment: "Month of separation for attrition trend analysis and seasonal pattern identification."
    - name: "rehire_eligibility_flag"
      expr: rehire_eligibility_flag
      comment: "Whether the employee is eligible for rehire; tracks talent pool for future recruitment."
    - name: "severance_eligible_flag"
      expr: severance_eligible_flag
      comment: "Whether the employee is eligible for severance; drives severance liability forecasting."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Whether the employee is COBRA-eligible; tracks benefits continuation compliance obligations."
  measures:
    - name: "total_separations"
      expr: COUNT(1)
      comment: "Total employee separations; primary attrition volume KPI for workforce stability analysis."
    - name: "total_severance_amount"
      expr: SUM(CAST(severance_amount AS DOUBLE))
      comment: "Total severance paid; key financial liability metric for restructuring and RIF cost management."
    - name: "avg_severance_amount"
      expr: AVG(CAST(severance_amount AS DOUBLE))
      comment: "Average severance payment per separated employee; benchmarks severance policy generosity and cost."
    - name: "avg_severance_weeks"
      expr: AVG(CAST(severance_weeks AS DOUBLE))
      comment: "Average severance duration in weeks; validates severance policy consistency and CBA compliance."
    - name: "total_final_paycheck_amount"
      expr: SUM(CAST(final_paycheck_amount AS DOUBLE))
      comment: "Total final paycheck disbursements; used for offboarding cash-flow planning."
    - name: "exit_interview_completed_count"
      expr: COUNT(CASE WHEN exit_interview_completed_flag = TRUE THEN 1 END)
      comment: "Number of exit interviews completed; measures offboarding process quality and attrition insight capture rate."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of separated employees eligible for rehire; quantifies the boomerang talent pool for future recruiting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and disciplinary metrics for HR and legal to monitor policy violations, escalation rates, and corrective action effectiveness."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type_id
      comment: "Type of disciplinary action (verbal warning, written warning, suspension, termination) for severity analysis."
    - name: "action_status"
      expr: action_status_id
      comment: "Current status of the disciplinary action for case management and resolution tracking."
    - name: "violation_category"
      expr: violation_category_id
      comment: "Category of policy violation for root-cause analysis and policy effectiveness assessment."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month disciplinary action was taken for trend analysis of employee relations issues."
    - name: "termination_triggered_flag"
      expr: termination_triggered_flag
      comment: "Whether the action resulted in termination; tracks escalation rate from disciplinary process."
    - name: "union_notification_required_flag"
      expr: union_notification_required_flag
      comment: "Whether union notification was required; tracks CBA compliance in disciplinary proceedings."
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total disciplinary actions issued; primary employee relations health KPI for HR leadership."
    - name: "termination_triggered_count"
      expr: COUNT(CASE WHEN termination_triggered_flag = TRUE THEN 1 END)
      comment: "Number of disciplinary actions that resulted in termination; measures escalation rate and policy enforcement severity."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of disciplinary actions with appeals filed; high appeal rates signal process fairness concerns."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Number of cases requiring legal review; measures legal risk exposure from employee relations issues."
    - name: "union_notified_count"
      expr: COUNT(CASE WHEN union_notified_date IS NOT NULL THEN 1 END)
      comment: "Number of cases where union was notified; validates CBA compliance in disciplinary proceedings."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and payroll processing metrics for operations and finance to manage overtime exposure, timesheet compliance, and labor cost accuracy."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "approval_status"
      expr: approval_status_id
      comment: "Timesheet approval status for payroll processing compliance and manager accountability."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit for departmental labor hours analysis and cost attribution."
    - name: "pay_period_start_month"
      expr: DATE_TRUNC('MONTH', pay_period_start_date)
      comment: "Month of pay period for labor hours trend analysis and seasonal capacity planning."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the timesheet has been processed through payroll; tracks payroll cycle completeness."
    - name: "channel"
      expr: channel_id
      comment: "Broadcasting channel the labor hours are attributed to; enables channel-level labor cost analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked; baseline for labor capacity utilization and productivity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours; high overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_hours_approved"
      expr: SUM(CAST(total_hours_approved AS DOUBLE))
      comment: "Total approved hours for payroll processing; validates timesheet approval completeness."
    - name: "total_hours_submitted"
      expr: SUM(CAST(total_hours_submitted AS DOUBLE))
      comment: "Total hours submitted by employees; compared to approved hours to identify approval bottlenecks."
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total PTO hours taken; used for leave liability reconciliation and absence rate calculation."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours; premium labor cost indicator for broadcast operations scheduling."
    - name: "timesheet_count"
      expr: COUNT(1)
      comment: "Total timesheets submitted; used to validate submission completeness against active headcount."
    - name: "avg_regular_hours_per_timesheet"
      expr: AVG(CAST(regular_hours AS DOUBLE))
      comment: "Average regular hours per timesheet; benchmark for standard work week compliance and FTE utilization."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance metrics for HR and operations to track regulatory certification coverage, expiry risk, and broadcast license compliance."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type_id
      comment: "Type of certification (technical, regulatory, safety, broadcast) for compliance coverage analysis."
    - name: "certification_status"
      expr: certification_status_id
      comment: "Current certification status (active, expired, pending renewal) for compliance risk monitoring."
    - name: "certification_category"
      expr: certification_category_id
      comment: "Category of certification for portfolio analysis and training investment prioritization."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the certification is required by regulation; non-compliance creates legal and operational risk."
    - name: "employer_sponsored"
      expr: employer_sponsored
      comment: "Whether the employer sponsored the certification; tracks L&D investment in workforce credentials."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year of certification expiry for renewal pipeline planning and compliance risk forecasting."
  measures:
    - name: "total_certification_count"
      expr: COUNT(1)
      comment: "Total certifications held across the workforce; measures overall credential coverage."
    - name: "regulatory_required_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Number of regulatory-required certifications; baseline for compliance coverage rate calculation."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE THEN 1 END)
      comment: "Number of expired certifications; critical compliance risk KPI — expired regulatory certs create legal exposure."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in workforce certifications; used for L&D budget planning and ROI analysis."
    - name: "avg_exam_score"
      expr: AVG(CAST(exam_score AS DOUBLE))
      comment: "Average certification exam score; measures workforce competency level and training effectiveness."
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees holding at least one certification; measures credentialed workforce breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_union_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Union workforce metrics for HR and labor relations to manage CBA compliance, dues collection, and union workforce composition."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`union_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status_id
      comment: "Current union membership status (active, suspended, resigned) for workforce composition analysis."
    - name: "bargaining_unit_code"
      expr: bargaining_unit_code_id
      comment: "Bargaining unit for CBA-specific workforce analysis and contract compliance tracking."
    - name: "cba_reference_code"
      expr: cba_reference_code_id
      comment: "Collective bargaining agreement reference for contract-specific compliance analysis."
    - name: "right_to_work_state"
      expr: right_to_work_state
      comment: "Whether the employee is in a right-to-work state; affects dues collection and membership obligations."
    - name: "membership_initiation_year"
      expr: DATE_TRUNC('YEAR', membership_initiation_date)
      comment: "Year of union membership initiation for workforce unionization trend analysis."
  measures:
    - name: "total_union_members"
      expr: COUNT(1)
      comment: "Total union members; primary CBA workforce size KPI for labor relations management."
    - name: "total_dues_deduction_amount"
      expr: SUM(CAST(dues_deduction_amount AS DOUBLE))
      comment: "Total union dues deducted; validates dues collection compliance and union financial obligations."
    - name: "avg_dues_deduction_amount"
      expr: AVG(CAST(dues_deduction_amount AS DOUBLE))
      comment: "Average dues deduction per member; benchmarks against CBA-specified dues rates for compliance."
    - name: "total_initiation_fees_collected"
      expr: SUM(CAST(initiation_fee_amount AS DOUBLE))
      comment: "Total initiation fees collected; tracks new member onboarding and union financial health."
    - name: "union_steward_count"
      expr: COUNT(CASE WHEN union_steward_flag = TRUE THEN 1 END)
      comment: "Number of union stewards; measures union representation coverage across the workforce."
    - name: "pension_plan_participant_count"
      expr: COUNT(CASE WHEN pension_plan_participant = TRUE THEN 1 END)
      comment: "Number of union members in pension plans; tracks pension liability exposure and CBA benefit obligations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`workforce_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and grievance management metrics for HR and legal to monitor grievance volume, resolution rates, and legal risk exposure."
  source: "`vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type_id
      comment: "Type of grievance (discrimination, harassment, wage, safety) for root-cause analysis."
    - name: "grievance_status"
      expr: grievance_status_id
      comment: "Current status of the grievance (open, under investigation, resolved, escalated) for case management."
    - name: "severity_level"
      expr: severity_level_id
      comment: "Severity classification of the grievance for prioritization and legal risk assessment."
    - name: "org_unit"
      expr: org_unit_id
      comment: "Organizational unit where the grievance originated for departmental culture and management quality analysis."
    - name: "filed_month"
      expr: DATE_TRUNC('MONTH', filed_date)
      comment: "Month grievance was filed for trend analysis of employee relations climate."
    - name: "union_involved_flag"
      expr: union_involved_flag
      comment: "Whether the union is involved in the grievance; tracks CBA grievance procedure utilization."
    - name: "external_agency_reported_flag"
      expr: external_agency_reported_flag
      comment: "Whether the grievance was reported to an external agency (EEOC, NLRB); highest legal risk indicator."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total grievances filed; primary employee relations health KPI for HR and legal leadership."
    - name: "external_agency_reported_count"
      expr: COUNT(CASE WHEN external_agency_reported_flag = TRUE THEN 1 END)
      comment: "Number of grievances escalated to external agencies; highest-severity legal risk metric requiring immediate executive attention."
    - name: "resolved_grievance_count"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Number of resolved grievances; numerator for grievance resolution rate calculation."
    - name: "legal_counsel_involved_count"
      expr: COUNT(CASE WHEN legal_counsel_involved_flag = TRUE THEN 1 END)
      comment: "Number of grievances requiring legal counsel; measures legal cost exposure from employee relations issues."
    - name: "retaliation_reported_count"
      expr: COUNT(CASE WHEN retaliation_reported_flag = TRUE THEN 1 END)
      comment: "Number of grievances with retaliation claims; critical legal risk indicator requiring immediate HR and legal response."
    - name: "union_involved_count"
      expr: COUNT(CASE WHEN union_involved_flag = TRUE THEN 1 END)
      comment: "Number of grievances with union involvement; tracks CBA grievance procedure utilization and labor relations health."
$$;