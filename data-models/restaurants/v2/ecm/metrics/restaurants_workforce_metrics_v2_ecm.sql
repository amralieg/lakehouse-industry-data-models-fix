-- Metric views for domain: workforce | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shift-level KPIs measuring labor cost, overtime exposure, scheduling adherence, and productivity per shift. Used by restaurant GMs and labor analysts to manage daily staffing efficiency."
  source: "`vibe_restaurants_v1`.`workforce`.`shift`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Calendar date of the shift, used to trend labor metrics over time."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (breakfast, lunch, dinner, late-night) for daypart-level labor analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Classification of shift (e.g., opening, closing, mid) for staffing pattern analysis."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift (scheduled, completed, no-show) for attendance tracking."
    - name: "station"
      expr: station
      comment: "Kitchen or service station assignment for station-level labor distribution analysis."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the shift incurred overtime, used to flag compliance and cost risk."
  measures:
    - name: "total_shift_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all shifts. Core cost metric for labor P&L management."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift. Benchmarks staffing efficiency across units and dayparts."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all shifts. Used to compare planned vs. actual labor deployment."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total hours actually worked. Compared against scheduled hours to measure adherence."
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled hours actually worked. Measures scheduling accuracy and attendance reliability."
    - name: "total_overtime_hours"
      expr: SUM(CASE WHEN overtime_flag = TRUE THEN actual_hours ELSE 0 END)
      comment: "Total hours worked on overtime shifts. Drives overtime cost control and compliance monitoring."
    - name: "overtime_shift_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts that incurred overtime. Key labor compliance and cost risk indicator."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of sales (as recorded on the shift). Core restaurant profitability KPI."
    - name: "avg_break_duration_minutes"
      expr: AVG(CAST(break_duration_minutes AS DOUBLE))
      comment: "Average break duration per shift. Used to verify compliance with labor law break requirements."
    - name: "total_shifts"
      expr: COUNT(1)
      comment: "Total number of shifts. Baseline volume metric for normalizing other labor KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular clock-in/clock-out KPIs for labor hour accuracy, missed punch detection, and overtime management. Used by payroll teams and compliance officers to ensure accurate pay and regulatory adherence."
  source: "`vibe_restaurants_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed, used for daily and weekly labor trend analysis."
    - name: "job_role"
      expr: job_role
      comment: "Role classification of the employee during the time entry, for role-level labor analysis."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, break) for pay code analysis."
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Approval status of the time entry (pending, approved, rejected) for payroll readiness tracking."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the time entry includes overtime hours."
    - name: "missed_punch_flag"
      expr: missed_punch_flag
      comment: "Indicates a missing clock-in or clock-out punch, a key payroll accuracy and compliance signal."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Core input for payroll cost calculation."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Drives overtime cost and labor law compliance monitoring."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked including regular and overtime. Primary labor volume metric."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from time entries. Used to reconcile against payroll and budget."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average hourly labor rate across time entries. Benchmarks wage levels by role and unit."
    - name: "missed_punch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN missed_punch_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of time entries with a missed punch. High rates indicate POS/timekeeping system issues or compliance risk."
    - name: "overtime_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of time entries that include overtime. Used to monitor overtime exposure by unit and role."
    - name: "unapproved_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_by_manager = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of time entries not yet approved by a manager. Flags payroll processing risk."
    - name: "distinct_employees_clocked"
      expr: COUNT(DISTINCT time_employee_id)
      comment: "Number of distinct employees with time entries. Measures active headcount for a given period."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost and compensation KPIs for financial reporting, labor cost management, and compliance. Used by finance, HR, and operations leadership to monitor total compensation spend."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date"
      expr: pay_date
      comment: "Date payroll was disbursed, used for period-over-period payroll cost trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payroll record for financial reporting alignment."
    - name: "employee_type"
      expr: employee_type
      comment: "Employment classification (full-time, part-time, seasonal) for workforce composition analysis."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the employee for role-level compensation benchmarking."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual compensation and tax reporting."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Indicates whether the record includes a bonus payment, for variable compensation analysis."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross payroll cost. Primary labor cost metric for P&L and budget variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees after deductions. Cash flow planning metric."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total taxes withheld from employee paychecks. Used for tax liability reporting and compliance."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions from payroll. Measures employee benefit cost burden."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments made. Tracks variable compensation spend against budget."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tips recorded in payroll. Used for tip compliance and FICA tip credit calculations."
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record. Benchmarks compensation levels across roles and units."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of sales per payroll record. Core restaurant profitability KPI."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_hours AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost (hours × rate). Quantifies the financial impact of overtime for cost control."
    - name: "distinct_employees_paid"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees paid in the period. Measures active paid headcount."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget vs. estimate KPIs for financial planning and variance management. Used by finance and operations leadership to track labor spend against approved budgets."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the labor budget for annual planning and variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget tracking and variance reporting."
    - name: "daypart"
      expr: daypart
      comment: "Meal period dimension for daypart-level labor budget allocation analysis."
    - name: "scenario"
      expr: scenario
      comment: "Budget scenario (base, optimistic, conservative) for scenario planning analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency reporting."
  measures:
    - name: "total_labor_dollar_budget"
      expr: SUM(CAST(labor_dollar_budget AS DOUBLE))
      comment: "Total approved labor dollar budget. Primary financial planning baseline for labor cost management."
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total estimated labor cost. Compared against budget to identify variance before period close."
    - name: "total_hours_budget"
      expr: SUM(CAST(hours_budget_total AS DOUBLE))
      comment: "Total budgeted labor hours. Used to plan staffing levels and FTE requirements."
    - name: "total_fte_budget"
      expr: SUM(CAST(fte_budget_total AS DOUBLE))
      comment: "Total budgeted FTE count. Drives headcount planning and recruitment targets."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average targeted labor cost percentage. Benchmark for operational efficiency targets."
    - name: "boh_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate_boh AS DOUBLE))
      comment: "Back-of-house labor cost estimate. Enables BOH vs. FOH cost split analysis for kitchen staffing decisions."
    - name: "foh_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate_foh AS DOUBLE))
      comment: "Front-of-house labor cost estimate. Enables FOH staffing cost analysis for service model decisions."
    - name: "budget_vs_estimate_variance"
      expr: SUM(CAST(labor_dollar_budget AS DOUBLE) - CAST(labor_cost_estimate AS DOUBLE))
      comment: "Dollar variance between approved budget and current cost estimate. Negative values signal budget overrun risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor demand forecasting KPIs for staffing optimization and cost planning. Used by operations and workforce planning teams to align staffing levels with anticipated demand."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date the forecast applies to, for daily and weekly staffing planning."
    - name: "daypart"
      expr: daypart
      comment: "Meal period for daypart-level staffing forecast analysis."
    - name: "labor_forecast_status"
      expr: labor_forecast_status
      comment: "Status of the forecast (draft, approved, published) for workflow tracking."
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario (base, upside, downside) for scenario-based planning."
    - name: "lto_flag"
      expr: lto_flag
      comment: "Indicates whether a limited-time offer is active, which affects demand and staffing needs."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates whether a promotion is active, which affects traffic and labor demand."
  measures:
    - name: "total_projected_fte_boh"
      expr: SUM(CAST(projected_fte_boh AS DOUBLE))
      comment: "Total projected back-of-house FTE. Drives kitchen staffing decisions for forecasted demand."
    - name: "total_projected_fte_foh"
      expr: SUM(CAST(projected_fte_foh AS DOUBLE))
      comment: "Total projected front-of-house FTE. Drives service staffing decisions for forecasted demand."
    - name: "avg_projected_labor_percent"
      expr: AVG(CAST(projected_labor_percent AS DOUBLE))
      comment: "Average projected labor cost percentage. Measures whether forecasted staffing is within target labor cost ratios."
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total forecasted labor cost. Used to pre-validate labor spend against budget before the period begins."
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records. Used to assess forecast coverage and completeness across units and dates."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_labor_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor compliance violation KPIs for regulatory risk management. Used by HR, legal, and operations leadership to monitor and remediate labor law violations before they escalate to fines or litigation."
  source: "`vibe_restaurants_v1`.`workforce`.`labor_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of labor violation (e.g., missed break, overtime, minor labor) for root cause categorization."
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation (low, medium, high, critical) for prioritized remediation."
    - name: "labor_violation_status"
      expr: labor_violation_status
      comment: "Current status of the violation (open, under review, resolved) for case management tracking."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority governing the violation (e.g., DOL, state labor board) for compliance reporting."
    - name: "daypart"
      expr: daypart
      comment: "Meal period when the violation occurred, for operational pattern analysis."
    - name: "compliance_reported"
      expr: compliance_reported
      comment: "Whether the violation was reported to the regulatory body, for disclosure compliance tracking."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of labor violations. Primary compliance risk volume metric for executive reporting."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines assessed for labor violations. Quantifies the financial cost of non-compliance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred. Tracks cumulative regulatory penalty exposure."
    - name: "total_overtime_hours_in_violation"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours associated with violations. Identifies overtime-driven compliance risk."
    - name: "open_violation_count"
      expr: COUNT(CASE WHEN labor_violation_status = 'open' THEN 1 END)
      comment: "Number of unresolved violations. Measures outstanding compliance risk requiring immediate action."
    - name: "high_severity_violation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity IN ('high', 'critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations classified as high or critical severity. Key risk escalation indicator."
    - name: "avg_fine_per_violation"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine amount per violation. Benchmarks the cost of non-compliance for risk prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_tip_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tip reporting and compliance KPIs for FICA tip credit management and wage law adherence. Used by payroll, HR, and finance to ensure tip declarations meet IRS and DOL requirements."
  source: "`vibe_restaurants_v1`.`workforce`.`tip_compliance`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period for period-level tip compliance analysis."
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period for period-level tip compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the tip record (compliant, non-compliant, under review) for case management."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean flag indicating whether the employee's tip declaration is compliant with minimum wage requirements."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period label for grouping tip compliance records by payroll cycle."
  measures:
    - name: "total_declared_tips"
      expr: SUM(CAST(declared_tips_amount AS DOUBLE))
      comment: "Total tips declared by employees. Core metric for IRS tip reporting and FICA tip credit calculations."
    - name: "total_allocated_tips"
      expr: SUM(CAST(allocated_tips_amount AS DOUBLE))
      comment: "Total tips allocated by the employer where employee declarations fell below the minimum threshold."
    - name: "total_credit_card_tips"
      expr: SUM(CAST(credit_card_tips AS DOUBLE))
      comment: "Total credit card tips processed. Used to reconcile tip income against POS records."
    - name: "total_cash_tips"
      expr: SUM(CAST(cash_tips AS DOUBLE))
      comment: "Total cash tips declared. Monitors cash tip reporting compliance."
    - name: "total_minimum_wage_shortfall"
      expr: SUM(CAST(minimum_wage_shortfall_amount AS DOUBLE))
      comment: "Total minimum wage shortfall requiring employer makeup pay. Quantifies wage law compliance cost."
    - name: "total_tip_credit_amount"
      expr: SUM(CAST(tip_credit_amount AS DOUBLE))
      comment: "Total FICA tip credit claimed. Measures the tax benefit derived from tipped employee wages."
    - name: "non_compliant_employee_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_compliant = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tip compliance records that are non-compliant. Key regulatory risk indicator for tipped workforce management."
    - name: "avg_shortfall_per_record"
      expr: AVG(CAST(shortfall_amount AS DOUBLE))
      comment: "Average minimum wage shortfall per compliance record. Benchmarks the severity of tip shortfall issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance KPIs for talent management, promotion decisions, and training investment. Used by HR and operations leadership to evaluate workforce quality and identify development needs."
  source: "`vibe_restaurants_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_period_start"
      expr: review_period_start
      comment: "Start of the review period for cohort-based performance trend analysis."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (annual, mid-year, probationary) for review cycle analysis."
    - name: "performance_review_status"
      expr: performance_review_status
      comment: "Status of the review (draft, submitted, acknowledged) for completion tracking."
    - name: "department"
      expr: department
      comment: "Department of the reviewed employee for department-level performance benchmarking."
    - name: "shift_daypart"
      expr: shift_daypart
      comment: "Daypart the employee primarily works, for shift-based performance analysis."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Indicates whether the review triggered a corrective action plan, for HR risk tracking."
    - name: "promotion_recommendation"
      expr: promotion_recommendation
      comment: "Whether the reviewer recommended promotion, for talent pipeline analysis."
  measures:
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating. Primary talent quality metric for workforce benchmarking."
    - name: "avg_guest_service_score"
      expr: AVG(CAST(guest_service_score AS DOUBLE))
      comment: "Average guest service score. Directly links employee performance to guest satisfaction outcomes."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score. Critical compliance metric for health inspection readiness."
    - name: "avg_speed_score"
      expr: AVG(CAST(speed_score AS DOUBLE))
      comment: "Average speed-of-service score. Measures employee contribution to throughput and SOS targets."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in corrective action. Measures workforce performance risk concentration."
    - name: "promotion_recommendation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_recommendation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of employees recommended for promotion. Measures internal talent pipeline health."
    - name: "avg_labor_percentage_actual"
      expr: AVG(CAST(labor_percentage_actual AS DOUBLE))
      comment: "Average actual labor percentage recorded during the review period. Links individual performance to unit-level labor efficiency."
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN performance_review_status = 'completed' THEN 1 END)
      comment: "Number of completed performance reviews. Measures HR process compliance and review cycle completion."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance and effectiveness KPIs for workforce development and regulatory certification management. Used by HR, operations, and food safety teams to ensure staff competency and compliance."
  source: "`vibe_restaurants_v1`.`workforce`.`training_completion`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of training (food safety, customer service, operations) for program-level analysis."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e-learning, in-person, on-the-job) for delivery method effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the training was delivered, for modality effectiveness benchmarking."
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Completion status (completed, in-progress, failed) for compliance tracking."
    - name: "certification_required"
      expr: certification_required
      comment: "Whether the training leads to a required certification, for mandatory compliance tracking."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which training was conducted, for scheduling impact analysis."
  measures:
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training assignments completed. Core workforce compliance and development KPI."
    - name: "assessment_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_passed IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessed trainees who passed. Measures training program effectiveness and knowledge retention."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions. Benchmarks knowledge acquisition quality."
    - name: "avg_training_duration_minutes"
      expr: AVG(CAST(training_duration_minutes AS DOUBLE))
      comment: "Average time spent on training. Used to optimize training program length and scheduling impact."
    - name: "mandatory_certification_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required = TRUE AND training_completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN certification_required = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for mandatory certification training. Critical compliance metric for health and safety regulatory requirements."
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT training_employee_id)
      comment: "Number of distinct employees who completed at least one training. Measures training program reach."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management KPIs for workforce availability planning and compliance. Used by HR and operations managers to monitor leave utilization, backfill needs, and payroll impact."
  source: "`vibe_restaurants_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of leave requested (vacation, FMLA, sick, personal) for leave category analysis."
    - name: "request_status"
      expr: request_status
      comment: "Approval status of the leave request (pending, approved, denied) for workflow tracking."
    - name: "is_paid_leave"
      expr: is_paid_leave
      comment: "Whether the leave is paid, for payroll cost impact analysis."
    - name: "coverage_needed_flag"
      expr: coverage_needed_flag
      comment: "Whether shift coverage is needed during the leave, for operational planning."
    - name: "payroll_impact_flag"
      expr: payroll_impact_flag
      comment: "Whether the leave has a payroll impact, for payroll processing prioritization."
  measures:
    - name: "total_leave_days_requested"
      expr: SUM(CAST(leave_days_requested AS DOUBLE))
      comment: "Total leave days requested. Measures workforce availability risk and leave demand volume."
    - name: "total_leave_days_approved"
      expr: SUM(CAST(leave_days_approved AS DOUBLE))
      comment: "Total leave days approved. Measures actual workforce capacity reduction from approved leave."
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * SUM(CAST(leave_days_approved AS DOUBLE)) / NULLIF(SUM(CAST(leave_days_requested AS DOUBLE)), 0), 2)
      comment: "Percentage of requested leave days that were approved. Measures leave policy consistency."
    - name: "coverage_needed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_needed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests requiring shift coverage. Measures operational disruption risk from leave."
    - name: "avg_leave_balance_after"
      expr: AVG(CAST(leave_balance_after AS DOUBLE))
      comment: "Average remaining leave balance after approval. Monitors leave liability and accrual management."
    - name: "total_leave_requests"
      expr: COUNT(1)
      comment: "Total number of leave requests. Baseline volume metric for leave management capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee certification compliance KPIs for regulatory and operational readiness. Used by HR, food safety, and operations teams to ensure all required certifications are current and valid."
  source: "`vibe_restaurants_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (food handler, ServSafe, alcohol service) for compliance category analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, pending renewal) for compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the certification record for regulatory reporting."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for the role, for critical compliance prioritization."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification (e.g., National Restaurant Association) for credential validation."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires periodic renewal, for proactive expiration management."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records. Baseline for compliance coverage analysis."
    - name: "active_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications currently active. Core compliance health metric for health inspection readiness."
    - name: "mandatory_certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE AND certification_status = 'active' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active. Critical regulatory compliance KPI."
    - name: "expiring_soon_count"
      expr: COUNT(CASE WHEN certification_status = 'active' AND renewal_required = TRUE THEN 1 END)
      comment: "Count of active certifications that require renewal. Proactive compliance risk management metric."
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with at least one certification record. Measures certified workforce breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll run execution KPIs for payroll operations management and financial control. Used by payroll administrators and finance to monitor payroll cycle health, cost totals, and processing accuracy."
  source: "`vibe_restaurants_v1`.`workforce`.`payroll_run`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period for payroll cycle tracking."
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period for payroll cycle tracking."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (draft, processing, finalized, reversed) for operational workflow tracking."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Whether the payroll run has been finalized and locked for payment processing."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payroll run for financial period alignment."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual payroll cost and tax reporting."
  measures:
    - name: "total_gross_payroll"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payroll amount across all runs. Primary payroll cost metric for financial reporting."
    - name: "total_net_payroll"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payroll disbursed. Cash flow and treasury planning metric."
    - name: "total_deductions"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total payroll deductions (taxes, benefits, garnishments). Used for deduction liability reconciliation."
    - name: "total_employees_in_run"
      expr: SUM(CAST(total_employee_count AS DOUBLE))
      comment: "Total employees included across payroll runs. Measures payroll processing scale and headcount coverage."
    - name: "finalized_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_finalized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payroll runs that have been finalized. Measures payroll processing timeliness and operational efficiency."
    - name: "avg_gross_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross payroll per run. Benchmarks payroll run size for anomaly detection and cost trending."
$$;