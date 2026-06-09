-- Metric views for domain: workforce | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce composition and compensation metrics derived from the employee master record. Supports headcount planning, pay equity analysis, and labor cost benchmarking across units, departments, and employment types."
  source: "`restaurants_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the employee (e.g., Active, Terminated, On Leave). Used to segment headcount metrics by workforce state."
    - name: "employment_type"
      expr: employment_type
      comment: "Classification of employment arrangement (e.g., Full-Time, Part-Time, Seasonal). Critical for labor cost and scheduling analysis."
    - name: "job_title"
      expr: job_title
      comment: "Employee job title used to analyze compensation and headcount by role."
    - name: "role_classification"
      expr: role_classification
      comment: "Broad role classification (e.g., FOH, BOH, Management) enabling front-of-house vs. back-of-house workforce analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band assigned to the employee, used for compensation benchmarking and equity analysis."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Assigned shift pattern (e.g., Morning, Evening, Split) for scheduling and labor distribution analysis."
    - name: "work_schedule_type"
      expr: work_schedule_type
      comment: "Type of work schedule (e.g., Fixed, Flexible, On-Call) to understand scheduling flexibility across the workforce."
    - name: "union_member"
      expr: union_member
      comment: "Indicates whether the employee is a union member, relevant for labor relations and compliance reporting."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the employee is eligible for overtime pay, used in labor cost forecasting."
    - name: "servsafe_certified"
      expr: servsafe_certified
      comment: "Indicates whether the employee holds a current ServSafe food safety certification, a key compliance dimension."
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired. Used for tenure cohort analysis and attrition tracking."
    - name: "termination_date"
      expr: termination_date
      comment: "Date the employee was terminated. Used to identify attrition periods and calculate tenure."
    - name: "country"
      expr: country
      comment: "Country of the employee's work location, enabling geographic workforce distribution analysis."
    - name: "state"
      expr: state
      comment: "State or province of the employee's work location for regional labor analysis."
  measures:
    - name: "total_active_headcount"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Total number of currently active employees. The primary headcount KPI used in workforce planning and labor cost benchmarking."
    - name: "total_headcount"
      expr: COUNT(employee_id)
      comment: "Total number of employee records regardless of status. Used as the denominator for attrition rate and workforce composition ratios."
    - name: "total_salary_cost"
      expr: SUM(CAST(salary_amount AS DOUBLE))
      comment: "Total annualized salary cost across all employees. A primary input to labor cost budgeting and financial planning."
    - name: "avg_salary_amount"
      expr: AVG(CAST(salary_amount AS DOUBLE))
      comment: "Average salary per employee. Used for pay equity analysis and compensation benchmarking against industry standards."
    - name: "avg_labor_percentage_target"
      expr: AVG(CAST(labor_percentage_target AS DOUBLE))
      comment: "Average labor percentage target across employees. Indicates the expected labor cost as a share of revenue, used to set unit-level labor efficiency goals."
    - name: "servsafe_certified_headcount"
      expr: COUNT(CASE WHEN servsafe_certified = TRUE THEN employee_id END)
      comment: "Number of employees with active ServSafe certification. Tracks food safety compliance coverage across the workforce."
    - name: "servsafe_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN servsafe_certified = TRUE THEN employee_id END) / NULLIF(COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END), 0), 2)
      comment: "Percentage of active employees who are ServSafe certified. A critical food safety compliance KPI monitored by operations and regulatory teams."
    - name: "overtime_eligible_headcount"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN employee_id END)
      comment: "Number of employees eligible for overtime pay. Used in labor cost risk assessment and scheduling optimization."
    - name: "union_member_headcount"
      expr: COUNT(CASE WHEN union_member = TRUE THEN employee_id END)
      comment: "Number of union member employees. Relevant for labor relations management, contract compliance, and cost modeling."
    - name: "union_membership_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_member = TRUE THEN employee_id END) / NULLIF(COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END), 0), 2)
      comment: "Percentage of active employees who are union members. Tracks labor relations exposure and informs collective bargaining strategy."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational labor efficiency and cost metrics at the shift level. Enables management to monitor actual vs. scheduled hours, overtime exposure, labor cost per shift, and daypart-level staffing performance."
  source: "`restaurants_ecm`.`workforce`.`shift`"
  filter: is_deleted = FALSE
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift. Primary time dimension for daily labor cost and hours trending."
    - name: "daypart"
      expr: daypart
      comment: "Daypart segment of the shift (e.g., Breakfast, Lunch, Dinner, Late Night). Enables daypart-level labor efficiency analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., Regular, On-Call, Split). Used to analyze labor cost composition by shift category."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift (e.g., Completed, Cancelled, No-Show). Used to filter and analyze shift fulfillment rates."
    - name: "station"
      expr: station
      comment: "Work station assigned for the shift (e.g., Grill, Drive-Thru, Cashier). Enables station-level labor analysis."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the shift included overtime hours. Used to track overtime exposure and cost."
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Indicates whether the shift was an on-call assignment. Used to measure on-call labor utilization."
    - name: "shift_code"
      expr: shift_code
      comment: "Coded identifier for the shift type or pattern, used for operational categorization and reporting."
  measures:
    - name: "total_shifts"
      expr: COUNT(shift_id)
      comment: "Total number of shifts. Baseline volume metric for staffing coverage and scheduling analysis."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all shifts. Core labor input metric for cost and productivity analysis."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all shifts. Used as the denominator in schedule adherence and variance calculations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost incurred across all shifts. Primary financial KPI for labor spend management and budget variance tracking."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift. Used to benchmark shift-level cost efficiency across units, dayparts, and shift types."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average hourly labor rate across shifts. Used for wage benchmarking and labor cost forecasting."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue at the shift level. A key operational efficiency KPI used to manage labor spend relative to sales."
    - name: "hours_variance"
      expr: SUM((CAST(actual_hours AS DOUBLE)) - (CAST(scheduled_hours AS DOUBLE)))
      comment: "Difference between total actual and scheduled hours. Positive values indicate overstaffing or overtime; negative values indicate understaffing. Critical for schedule adherence management."
    - name: "schedule_adherence_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual hours worked to scheduled hours, expressed as a percentage. Measures how closely operations adhere to the labor schedule — a key operational discipline KPI."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN shift_id END)
      comment: "Number of shifts that incurred overtime. Used to monitor overtime exposure and drive scheduling interventions to reduce premium labor costs."
    - name: "overtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN shift_id END) / NULLIF(COUNT(shift_id), 0), 2)
      comment: "Percentage of shifts that included overtime. Tracks overtime prevalence as a labor cost risk indicator."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost, compensation structure, and labor efficiency metrics derived from payroll records. Supports financial close, labor cost variance analysis, overtime cost management, and pay equity reporting."
  source: "`restaurants_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_date"
      expr: pay_date
      comment: "Date on which payroll was disbursed. Primary time dimension for payroll cost trending and period-over-period analysis."
    - name: "pay_period_start"
      expr: pay_period_start
      comment: "Start date of the pay period. Used to align payroll costs to operational periods."
    - name: "pay_period_end"
      expr: pay_period_end
      comment: "End date of the pay period. Used to bound payroll cost aggregations to specific periods."
    - name: "payroll_type"
      expr: payroll_type
      comment: "Type of payroll run (e.g., Regular, Off-Cycle, Bonus). Used to separate recurring labor costs from one-time payments."
    - name: "payroll_record_status"
      expr: payroll_record_status
      comment: "Processing status of the payroll record (e.g., Processed, Pending, Voided). Used to filter to finalized payroll for accurate cost reporting."
    - name: "employee_type"
      expr: employee_type
      comment: "Employment type classification on the payroll record (e.g., Full-Time, Part-Time). Enables labor cost segmentation by workforce category."
    - name: "job_title"
      expr: job_title
      comment: "Job title associated with the payroll record. Used for role-level compensation analysis."
    - name: "pay_group"
      expr: pay_group
      comment: "Payroll group classification used to segment payroll processing batches and analyze cost by employee cohort."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period label for the payroll record. Enables alignment of payroll costs to financial reporting periods."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payroll was processed. Required for multi-currency labor cost normalization."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether the employee is a union member on this payroll record. Used for union vs. non-union labor cost analysis."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Indicates whether the payroll record includes a bonus payment. Used to isolate bonus spend from base compensation."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay disbursed across all payroll records. The primary labor cost metric used in financial reporting and budget variance analysis."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay after deductions. Used to understand actual cash outflow to employees and model take-home pay distributions."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_hours AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime labor cost calculated as overtime hours multiplied by overtime rate. A key cost control KPI — elevated overtime signals scheduling inefficiency or understaffing."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus compensation paid. Used to track incentive spend against performance targets and budget allocations."
    - name: "total_benefit_deductions"
      expr: SUM(CAST(benefit_deduction AS DOUBLE))
      comment: "Total benefit deductions across payroll records. Used to model total compensation cost including benefits burden."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld AS DOUBLE))
      comment: "Total taxes withheld from employee paychecks. Used for payroll tax compliance reporting and cash flow planning."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours paid. Used to measure base labor input and distinguish from premium-rate hours."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours paid across all payroll records. Tracks overtime volume as a leading indicator of labor cost overruns."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record. Used for compensation benchmarking and identifying pay anomalies."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average hourly or period pay rate across payroll records. Used for wage benchmarking and minimum wage compliance monitoring."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue as recorded on payroll records. A key operational efficiency metric used to manage labor spend relative to sales targets."
    - name: "overtime_hours_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE) + CAST(overtime_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours paid. Measures overtime intensity — high values signal scheduling or staffing issues that inflate labor costs."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular time and attendance metrics derived from employee clock-in/clock-out records. Supports labor cost accuracy, missed punch compliance, overtime monitoring, and time entry approval rate tracking."
  source: "`restaurants_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date on which the work was performed. Primary time dimension for daily labor hours and cost analysis."
    - name: "job_role"
      expr: job_role
      comment: "Job role associated with the time entry. Used to analyze hours and cost by role category."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (e.g., Regular, Overtime, Break). Used to segment labor hours by pay type."
    - name: "time_entry_status"
      expr: time_entry_status
      comment: "Processing status of the time entry (e.g., Approved, Pending, Rejected). Used to filter to approved entries for accurate payroll processing."
    - name: "pay_code"
      expr: pay_code
      comment: "Pay code associated with the time entry, mapping to specific compensation rules (e.g., holiday pay, training pay)."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the time entry includes overtime hours. Used to track overtime incidence at the entry level."
    - name: "missed_punch_flag"
      expr: missed_punch_flag
      comment: "Indicates whether the employee missed a clock-in or clock-out punch. A compliance and payroll accuracy indicator."
    - name: "approved_by_manager"
      expr: approved_by_manager
      comment: "Indicates whether the time entry has been approved by a manager. Used to track approval compliance and identify unapproved labor costs."
    - name: "break_flag"
      expr: break_flag
      comment: "Indicates whether the time entry includes a break period. Used for labor law compliance monitoring."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked as recorded in time entries. The foundational labor input metric for cost, productivity, and compliance analysis."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Used to measure base labor input and separate from premium-cost overtime hours."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded in time entries. Tracks overtime volume as a leading indicator of labor cost overruns and scheduling gaps."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost derived from time entries. Used for real-time labor cost monitoring and comparison against budget and forecast."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per time entry. Used for wage benchmarking and identifying rate anomalies that may indicate payroll errors."
    - name: "missed_punch_count"
      expr: COUNT(CASE WHEN missed_punch_flag = TRUE THEN time_entry_id END)
      comment: "Number of time entries with a missed punch. A payroll accuracy and compliance KPI — high missed punch rates indicate timekeeping process failures."
    - name: "missed_punch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN missed_punch_flag = TRUE THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries with a missed punch. Tracks timekeeping compliance — elevated rates increase payroll error risk and labor law exposure."
    - name: "manager_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_by_manager = TRUE THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries approved by a manager. Measures supervisory compliance with time approval workflows — unapproved entries create payroll processing risk."
    - name: "overtime_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN time_entry_id END) / NULLIF(COUNT(time_entry_id), 0), 2)
      comment: "Percentage of time entries that include overtime. Tracks overtime incidence at the entry level to identify units or roles with chronic overtime exposure."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_labor_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor budget planning and target metrics used to govern labor spend across units, fiscal periods, and budget scenarios. Supports budget vs. actual variance analysis, FTE planning, and labor percent target management."
  source: "`restaurants_ecm`.`workforce`.`labor_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the labor budget. Primary time dimension for annual labor cost planning and year-over-year budget comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., P1, P2) of the labor budget. Used for period-level budget vs. actual variance analysis."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the budget period. Used to align budget data to operational and financial reporting periods."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the budget period. Used to bound budget aggregations to specific planning windows."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of labor budget (e.g., Annual, Revised, Rolling Forecast). Used to distinguish between budget versions in scenario analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and processing status of the budget (e.g., Draft, Approved, Locked). Used to filter to approved budgets for official reporting."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the labor budget (e.g., FOH, BOH, Management). Enables cost center-level budget analysis."
    - name: "scenario"
      expr: scenario
      comment: "Budget scenario label (e.g., Base, Optimistic, Conservative). Used for scenario-based labor planning and sensitivity analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart associated with the budget entry. Enables daypart-level labor budget analysis and scheduling optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the labor budget. Required for multi-currency budget consolidation."
  measures:
    - name: "total_labor_dollar_budget"
      expr: SUM(CAST(labor_dollar_budget AS DOUBLE))
      comment: "Total budgeted labor dollar spend. The primary financial planning KPI for labor cost governance and budget allocation decisions."
    - name: "total_labor_cost_estimate"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total estimated labor cost across all budget records. Used to compare planned spend against approved budget and identify variance."
    - name: "total_labor_cost_estimate_foh"
      expr: SUM(CAST(labor_cost_estimate_foh AS DOUBLE))
      comment: "Total estimated front-of-house labor cost. Used to manage FOH staffing costs separately from BOH for operational efficiency analysis."
    - name: "total_labor_cost_estimate_boh"
      expr: SUM(CAST(labor_cost_estimate_boh AS DOUBLE))
      comment: "Total estimated back-of-house labor cost. Used to manage BOH staffing costs and kitchen labor efficiency."
    - name: "total_fte_budget"
      expr: SUM(CAST(fte_budget_total AS DOUBLE))
      comment: "Total budgeted full-time equivalent headcount. Used for workforce capacity planning and headcount governance."
    - name: "total_fte_budget_foh"
      expr: SUM(CAST(fte_budget_foh AS DOUBLE))
      comment: "Total budgeted FOH FTE count. Used to plan front-of-house staffing levels against expected customer volume."
    - name: "total_fte_budget_boh"
      expr: SUM(CAST(fte_budget_boh AS DOUBLE))
      comment: "Total budgeted BOH FTE count. Used to plan kitchen and food preparation staffing against production requirements."
    - name: "total_hours_budget"
      expr: SUM(CAST(hours_budget_total AS DOUBLE))
      comment: "Total budgeted labor hours. Used to set scheduling targets and measure actual hours against planned labor input."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average budgeted labor cost as a percentage of revenue. The primary labor efficiency target KPI used to set unit-level performance expectations."
    - name: "avg_labor_percent_target_foh"
      expr: AVG(CAST(labor_percent_target_foh AS DOUBLE))
      comment: "Average FOH labor percent target. Used to set front-of-house efficiency benchmarks and evaluate actual FOH labor performance."
    - name: "avg_labor_percent_target_boh"
      expr: AVG(CAST(labor_percent_target_boh AS DOUBLE))
      comment: "Average BOH labor percent target. Used to set kitchen labor efficiency benchmarks and evaluate actual BOH labor performance."
    - name: "foh_boh_fte_ratio"
      expr: ROUND(SUM(CAST(fte_budget_foh AS DOUBLE)) / NULLIF(SUM(CAST(fte_budget_boh AS DOUBLE)), 0), 2)
      comment: "Ratio of budgeted FOH FTEs to BOH FTEs. Tracks the planned balance between customer-facing and kitchen staff — a key operational design metric for restaurant format optimization."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_labor_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor demand forecasting metrics used to project staffing needs, labor costs, and efficiency targets. Supports proactive scheduling, budget alignment, and operational planning across units and dayparts."
  source: "`restaurants_ecm`.`workforce`.`labor_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date for which the labor forecast applies. Primary time dimension for forecast trending and accuracy analysis."
    - name: "week_number"
      expr: week_number
      comment: "Week number associated with the forecast. Used for weekly labor planning and schedule generation."
    - name: "year"
      expr: year
      comment: "Year of the labor forecast. Used for annual planning and year-over-year forecast comparison."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for which the forecast applies (e.g., Breakfast, Lunch, Dinner). Enables daypart-level staffing optimization."
    - name: "scenario"
      expr: scenario
      comment: "Forecast scenario (e.g., Base, Upside, Downside). Used for scenario-based labor planning and risk assessment."
    - name: "labor_forecast_status"
      expr: labor_forecast_status
      comment: "Status of the forecast record (e.g., Draft, Approved, Superseded). Used to filter to active forecasts for planning purposes."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates whether a marketing promotion is active during the forecast period. Used to assess promotional impact on labor demand."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast labor cost estimates. Required for multi-currency forecast consolidation."
    - name: "model_version"
      expr: model_version
      comment: "Version of the forecasting model used. Enables model performance tracking and version-over-version accuracy comparison."
  measures:
    - name: "total_forecasted_labor_cost"
      expr: SUM(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Total forecasted labor cost across all forecast records. Used to project future labor spend and align scheduling to financial targets."
    - name: "avg_projected_labor_percent"
      expr: AVG(CAST(projected_labor_percent AS DOUBLE))
      comment: "Average projected labor cost as a percentage of revenue. The primary forward-looking labor efficiency KPI used to set scheduling targets and evaluate forecast quality."
    - name: "total_projected_fte_foh"
      expr: SUM(CAST(projected_fte_foh AS DOUBLE))
      comment: "Total projected FOH FTE demand. Used to drive front-of-house scheduling decisions and ensure adequate customer-facing coverage."
    - name: "total_projected_fte_boh"
      expr: SUM(CAST(projected_fte_boh AS DOUBLE))
      comment: "Total projected BOH FTE demand. Used to plan kitchen staffing levels against forecasted production requirements."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score for labor forecasts. Tracks forecast reliability — low confidence scores signal the need for manual review before scheduling decisions are made."
    - name: "promotion_period_forecast_count"
      expr: COUNT(CASE WHEN promotion_flag = TRUE THEN labor_forecast_id END)
      comment: "Number of forecast records associated with active promotions. Used to quantify promotional labor demand and plan incremental staffing for marketing events."
    - name: "foh_boh_projected_fte_ratio"
      expr: ROUND(SUM(CAST(projected_fte_foh AS DOUBLE)) / NULLIF(SUM(CAST(projected_fte_boh AS DOUBLE)), 0), 2)
      comment: "Ratio of projected FOH to BOH FTEs in the forecast. Used to validate that the forecasted staffing mix aligns with operational format and service model expectations."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule-level workforce planning metrics tracking FTE coverage, labor percentage targets, and scheduling efficiency across dayparts and periods. Used by operations managers to validate staffing plans against labor budgets and forecasts."
  source: "`restaurants_ecm`.`workforce`.`schedule`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the schedule period. Primary time dimension for schedule coverage and labor planning analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the schedule period. Used to bound schedule aggregations to specific planning windows."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Approval and processing status of the schedule (e.g., Draft, Approved, Published). Used to filter to published schedules for operational reporting."
    - name: "approved_by"
      expr: approved_by
      comment: "Name or identifier of the manager who approved the schedule. Used for accountability tracking and approval workflow compliance."
    - name: "version"
      expr: version
      comment: "Version of the schedule. Used to track schedule revisions and compare planned vs. revised labor allocations."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all schedule records. The primary labor input planning metric used to validate staffing coverage against demand forecasts."
    - name: "total_fte_scheduled"
      expr: SUM(CAST(fte_total AS DOUBLE))
      comment: "Total FTEs scheduled across all schedule records. Used to assess workforce capacity deployment against budgeted FTE targets."
    - name: "total_fte_morning"
      expr: SUM(CAST(fte_morning AS DOUBLE))
      comment: "Total FTEs scheduled for the morning daypart. Used to validate morning staffing coverage against breakfast and opening demand."
    - name: "total_fte_midday"
      expr: SUM(CAST(fte_midday AS DOUBLE))
      comment: "Total FTEs scheduled for the midday daypart. Used to validate lunch rush staffing coverage — typically the highest-volume daypart."
    - name: "total_fte_evening"
      expr: SUM(CAST(fte_evening AS DOUBLE))
      comment: "Total FTEs scheduled for the evening daypart. Used to validate dinner service staffing coverage."
    - name: "total_fte_night"
      expr: SUM(CAST(fte_night AS DOUBLE))
      comment: "Total FTEs scheduled for the night daypart. Used to manage late-night staffing costs and coverage for 24-hour locations."
    - name: "avg_labor_percentage"
      expr: AVG(CAST(labor_percentage AS DOUBLE))
      comment: "Average scheduled labor percentage across schedule records. Measures whether planned staffing aligns with labor cost targets — a key pre-period efficiency indicator."
    - name: "avg_labor_pct_morning"
      expr: AVG(CAST(labor_pct_morning AS DOUBLE))
      comment: "Average scheduled labor percentage for the morning daypart. Used to assess morning staffing efficiency and identify dayparts where labor targets are at risk."
    - name: "avg_labor_pct_midday"
      expr: AVG(CAST(labor_pct_midday AS DOUBLE))
      comment: "Average scheduled labor percentage for the midday daypart. Used to assess lunch staffing efficiency against revenue targets."
    - name: "avg_labor_pct_evening"
      expr: AVG(CAST(labor_pct_evening AS DOUBLE))
      comment: "Average scheduled labor percentage for the evening daypart. Used to assess dinner staffing efficiency and cost control."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee certification compliance metrics tracking certification coverage, expiration risk, and renewal status. Supports food safety compliance, brand standard adherence, and regulatory audit readiness."
  source: "`restaurants_ecm`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Food Safety, Alcohol Service, Brand Standard). Used to segment compliance metrics by certification category."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Pending Renewal). Primary dimension for compliance monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance classification of the certification (e.g., Compliant, Non-Compliant, At Risk). Used for regulatory and brand standard compliance reporting."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification (e.g., ServSafe, State Health Department). Used to track certification sources and validate issuing authority."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the certification is mandatory for the employee's role. Used to prioritize compliance remediation for required certifications."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Indicates whether the certification requires renewal. Used to proactively manage renewal pipelines and avoid compliance lapses."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date on which the certification expires. Used to identify at-risk certifications and trigger renewal workflows."
    - name: "issue_date"
      expr: issue_date
      comment: "Date on which the certification was issued. Used for certification age analysis and renewal cycle planning."
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the certification. Used to identify specific certifications in compliance dashboards and audit reports."
  measures:
    - name: "total_certifications"
      expr: COUNT(certification_id)
      comment: "Total number of certification records. Baseline volume metric for certification portfolio management."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of currently active certifications. Used to measure current compliance coverage across the workforce."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN certification_id END)
      comment: "Number of expired certifications. A critical compliance risk KPI — expired certifications create regulatory exposure and brand standard violations."
    - name: "mandatory_certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE AND certification_status = 'Active' THEN certification_id END) / NULLIF(COUNT(CASE WHEN is_mandatory = TRUE THEN certification_id END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active. The primary certification compliance KPI — directly tied to regulatory audit outcomes and brand standard scores."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN certification_id END)
      comment: "Number of certifications expiring within the next 30 days. A forward-looking compliance risk indicator used to trigger proactive renewal actions before lapses occur."
    - name: "non_compliant_certification_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN certification_id END)
      comment: "Number of certifications in a non-compliant state. Used to quantify active compliance violations requiring immediate remediation."
    - name: "non_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN certification_id END) / NULLIF(COUNT(certification_id), 0), 2)
      comment: "Percentage of certifications in a non-compliant state. Tracks overall certification compliance health — elevated rates signal systemic compliance management failures."
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with at least one certification record. Used to measure certification program reach across the workforce."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`workforce_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training program effectiveness and compliance metrics derived from training completion records. Tracks completion rates, assessment performance, and compliance coverage to support workforce development and brand standard adherence."
  source: "`restaurants_ecm`.`workforce`.`training_completion`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of training completed (e.g., Food Safety, Customer Service, Brand Standards). Used to segment training metrics by program type."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., Onboarding, Recertification, Compliance). Used to analyze training volume and completion rates by program type."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method by which training was delivered (e.g., In-Person, eLearning, On-the-Job). Used to evaluate training channel effectiveness and cost efficiency."
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Completion status of the training record (e.g., Completed, In Progress, Failed). Primary dimension for training completion rate analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance classification of the training completion (e.g., Compliant, Non-Compliant). Used for regulatory and brand standard compliance reporting."
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Indicates whether the employee passed the training assessment. Used to measure training effectiveness and knowledge retention."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which training was completed. Used to analyze training scheduling patterns and operational impact."
    - name: "required_for_role"
      expr: required_for_role
      comment: "Role for which the training is required. Used to track role-specific training compliance and identify coverage gaps."
    - name: "completion_timestamp"
      expr: completion_timestamp
      comment: "Timestamp when training was completed. Used for training completion trending and cohort analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(training_completion_id)
      comment: "Total number of training completion records. Baseline volume metric for training program activity and workforce development investment."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_completion_status = 'Completed' THEN training_completion_id END)
      comment: "Number of training records with a completed status. Used to measure training program throughput and workforce readiness."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completion_status = 'Completed' THEN training_completion_id END) / NULLIF(COUNT(training_completion_id), 0), 2)
      comment: "Percentage of training records that have been completed. A key workforce development KPI — low completion rates signal training compliance risk and operational readiness gaps."
    - name: "assessment_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = TRUE THEN training_completion_id END) / NULLIF(COUNT(CASE WHEN assessment_passed IS NOT NULL THEN training_completion_id END), 0), 2)
      comment: "Percentage of assessed training completions where the employee passed. Measures training effectiveness and knowledge retention — a direct indicator of workforce quality and brand standard adherence."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions with assessments. Used to benchmark training quality and identify programs or cohorts requiring remediation."
    - name: "avg_assessment_max_score"
      expr: AVG(CAST(assessment_max_score AS DOUBLE))
      comment: "Average maximum possible assessment score. Used as the denominator context for score normalization and pass rate benchmarking."
    - name: "distinct_trained_employees"
      expr: COUNT(DISTINCT primary_training_employee_id)
      comment: "Number of distinct employees who have completed at least one training record. Measures training program reach and workforce coverage."
    - name: "non_compliant_training_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN training_completion_id END)
      comment: "Number of training records in a non-compliant state. Tracks active training compliance violations requiring immediate remediation to avoid regulatory or brand standard penalties."
    - name: "non_compliant_training_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN training_completion_id END) / NULLIF(COUNT(training_completion_id), 0), 2)
      comment: "Percentage of training records in a non-compliant state. A critical compliance health KPI — elevated rates indicate systemic training management failures with direct regulatory and brand standard risk."
$$;