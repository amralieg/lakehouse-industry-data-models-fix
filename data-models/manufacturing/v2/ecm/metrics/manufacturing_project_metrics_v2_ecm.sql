-- Metric views for domain: project | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic project portfolio metrics covering budget performance, schedule adherence, and earned value at the project level. Used by PMO and executives to steer the portfolio."
  source: "`vibe_manufacturing_v1`.`project`.`project_header`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of project (e.g., capital, operational, R&D) for portfolio segmentation."
    - name: "project_category"
      expr: project_category
      comment: "Business category of the project for cross-portfolio analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current lifecycle phase of the project (e.g., initiation, execution, closeout)."
    - name: "project_header_status"
      expr: project_header_status
      comment: "Current status of the project (e.g., active, on-hold, completed, cancelled)."
    - name: "priority"
      expr: priority
      comment: "Project priority level for resource allocation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project for executive risk monitoring."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the project for regional portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which project financials are reported."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g., capex, opex, grant) for financial governance."
    - name: "governance_approval_status"
      expr: governance_approval_status
      comment: "Governance approval status indicating whether the project has executive sign-off."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned project start date for timeline analysis."
    - name: "planned_end_date"
      expr: DATE_TRUNC('month', planned_end_date)
      comment: "Month bucket of planned project end date for delivery forecasting."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of projects in the portfolio. Baseline measure for portfolio size tracking."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all projects. Key financial governance metric for capital allocation."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all projects. Compared against budget to assess financial performance."
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project. Helps benchmark project sizing and resource allocation norms."
    - name: "avg_actual_cost_per_project"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per project. Used alongside avg budget to assess typical cost overrun patterns."
    - name: "total_planned_work_hours"
      expr: SUM(CAST(total_work_hours AS DOUBLE))
      comment: "Total planned work hours across all projects. Drives workforce capacity planning decisions."
    - name: "total_actual_work_hours"
      expr: SUM(CAST(actual_work_hours AS DOUBLE))
      comment: "Total actual work hours consumed. Compared against planned hours to assess labor efficiency."
    - name: "avg_critical_path_duration_days"
      expr: AVG(CAST(critical_path_duration_days AS DOUBLE))
      comment: "Average critical path duration in days. Indicates typical project complexity and schedule risk."
    - name: "avg_expected_oee_percent"
      expr: AVG(CAST(expected_oee_percent AS DOUBLE))
      comment: "Average expected OEE (Overall Equipment Effectiveness) percent across projects. Links project outcomes to operational efficiency targets."
    - name: "avg_actual_oee_percent"
      expr: AVG(CAST(actual_oee_percent AS DOUBLE))
      comment: "Average actual OEE percent achieved across projects. Measures whether projects deliver their operational efficiency goals."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_header_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active projects. Key portfolio health indicator for PMO dashboards."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level = 'HIGH' THEN 1 END)
      comment: "Number of projects assessed as high risk. Triggers executive review and risk mitigation actions."
    - name: "projects_with_safety_incidents"
      expr: COUNT(CASE WHEN CAST(safety_incident_count AS INT) > 0 THEN 1 END)
      comment: "Number of projects that have recorded safety incidents. Critical for HSE governance and compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget performance metrics tracking original vs revised budgets, spending, commitments, and variance. Used by finance and PMO to govern project financial health."
  source: "`vibe_manufacturing_v1`.`project`.`project_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual financial planning and reporting."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget (e.g., top-down, bottom-up) for governance analysis."
    - name: "owner_role"
      expr: owner_role
      comment: "Role of the budget owner for accountability and delegation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency portfolio consolidation."
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the budget is locked, indicating finalized vs. open budgets."
    - name: "version"
      expr: version
      comment: "Budget version for tracking revisions and baseline comparisons."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month bucket of budget effective start date for temporal budget analysis."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget. Baseline for measuring budget growth and scope creep."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after amendments. Reflects current authorized spend ceiling."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total amount spent against the budget. Core financial execution metric."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed but not yet spent amount. Represents future cash obligations."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining budget available. Key liquidity and project viability indicator."
    - name: "total_transferred_in"
      expr: SUM(CAST(transferred_in_amount AS DOUBLE))
      comment: "Total budget transferred into projects from other sources. Tracks inter-project fund movements."
    - name: "total_transferred_out"
      expr: SUM(CAST(transferred_out_amount AS DOUBLE))
      comment: "Total budget transferred out of projects. Tracks fund reallocation decisions."
    - name: "avg_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(revised_budget_amount AS DOUBLE)), 0), 2)
      comment: "Average budget utilization percentage (spent / revised budget). Measures financial execution efficiency across the portfolio."
    - name: "avg_budget_revision_growth_pct"
      expr: ROUND(100.0 * SUM(CAST(revised_budget_amount AS DOUBLE) - CAST(original_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage growth from original to revised budget. Measures scope creep and budget discipline at portfolio level."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_cost_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actual cost posting metrics for project cost control. Tracks spending by period, category, and posting status to support financial governance and variance analysis."
  source: "`vibe_manufacturing_v1`.`project`.`cost_actual`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost posting for annual cost reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost posting for period-level cost control."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the cost posting (e.g., posted, reversed, pending) for financial accuracy."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase during which the cost was incurred for phase-level cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost posting for multi-currency consolidation."
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Whether the cost was manually entered, flagging potential data quality risks."
    - name: "overhead_allocation_flag"
      expr: overhead_allocation_flag
      comment: "Whether the cost includes overhead allocation, for direct vs. indirect cost analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of posting date for trend analysis of cost incurrence."
  measures:
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total actual cost amount posted. Primary financial execution metric for project cost control."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount at the cost posting level. Used for line-level budget vs. actual comparison."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. budget). Negative variance signals overspend requiring management action."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on cost postings. Required for tax reporting and compliance."
    - name: "avg_cost_per_posting"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average cost per posting record. Helps identify unusually large or small postings for audit purposes."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of resources consumed. Supports unit cost and productivity analysis."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of budget. Key project financial health indicator — negative values trigger corrective action."
    - name: "manual_entry_cost_amount"
      expr: SUM(CASE WHEN is_manual_entry = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost amount from manual entries. High values indicate data quality risk and audit exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_earned_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) metrics providing schedule and cost performance indices, variance analysis, and completion forecasts. Core PMO performance measurement tool."
  source: "`vibe_manufacturing_v1`.`project`.`earned_value_record`"
  dimensions:
    - name: "reporting_date"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month bucket of the EVM reporting date for trend analysis."
    - name: "baseline_version"
      expr: baseline_version
      comment: "Baseline version against which earned value is measured. Enables baseline comparison analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used to forecast estimate at completion (e.g., CPI-based, ETC-based)."
    - name: "is_forecast"
      expr: is_forecast
      comment: "Whether the record is a forecast vs. actuals, for separating reported vs. projected performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EVM record for multi-currency portfolio analysis."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month bucket of reporting period start for period-over-period EVM comparison."
  measures:
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average CPI (Earned Value / Actual Cost). CPI < 1.0 signals cost overrun; used by executives to assess financial efficiency of project execution."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average SPI (Earned Value / Planned Value). SPI < 1.0 signals schedule slippage; key indicator for delivery risk management."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value (BCWP) across projects. Measures the value of work actually completed."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) across projects. Represents the authorized budget for scheduled work."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost (ACWP) across projects. Core EVM financial input."
    - name: "total_estimate_at_completion"
      expr: SUM(CAST(estimate_at_completion AS DOUBLE))
      comment: "Total EAC (Estimate at Completion) across projects. Forecasts final project cost for budget governance."
    - name: "total_estimate_to_complete"
      expr: SUM(CAST(estimate_to_complete AS DOUBLE))
      comment: "Total ETC (Estimate to Complete) across projects. Represents remaining cost to finish all work."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (EV - AC). Negative values indicate cost overrun across the portfolio."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance (EV - PV). Negative values indicate schedule slippage across the portfolio."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total variance at completion (BAC - EAC). Forecasts final over/under-run for executive financial planning."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all WBS elements. Portfolio-level progress indicator for steering meetings."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project activity execution metrics covering schedule performance, labor efficiency, cost variance, and critical path adherence. Used by project managers to control delivery."
  source: "`vibe_manufacturing_v1`.`project`.`activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity (e.g., engineering, procurement, construction) for workstream analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g., not started, in progress, complete) for progress tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the activity is on the critical path. Critical path activities drive schedule risk."
    - name: "milestone_flag"
      expr: milestone_flag
      comment: "Whether the activity is a milestone. Milestone activities trigger payment and governance events."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of activity cost estimates for financial analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned activity start for schedule distribution analysis."
    - name: "planned_finish_date"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Month bucket of planned activity finish for delivery forecasting."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of activities. Baseline measure for project scope and workload assessment."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Higher counts indicate greater schedule risk exposure."
    - name: "total_labor_hours_estimated"
      expr: SUM(CAST(labor_hours_estimated AS DOUBLE))
      comment: "Total estimated labor hours across all activities. Drives workforce capacity planning."
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed. Compared against estimates to assess labor efficiency."
    - name: "labor_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_estimated AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours_actual AS DOUBLE)), 0), 2)
      comment: "Labor efficiency percentage (estimated / actual hours). Values below 100% indicate labor overrun, triggering workforce reallocation decisions."
    - name: "total_material_cost_estimated"
      expr: SUM(CAST(material_cost_estimated AS DOUBLE))
      comment: "Total estimated material cost across activities. Key input for procurement planning."
    - name: "total_material_cost_actual"
      expr: SUM(CAST(material_cost_actual AS DOUBLE))
      comment: "Total actual material cost incurred. Compared against estimates to assess procurement performance."
    - name: "total_equipment_cost_estimated"
      expr: SUM(CAST(equipment_cost_estimated AS DOUBLE))
      comment: "Total estimated equipment cost across activities. Supports asset utilization planning."
    - name: "total_equipment_cost_actual"
      expr: SUM(CAST(equipment_cost_actual AS DOUBLE))
      comment: "Total actual equipment cost incurred. Compared against estimates to assess equipment cost control."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all activities. Indicates overall project execution progress."
    - name: "avg_float_days"
      expr: AVG(CAST(float_days AS DOUBLE))
      comment: "Average schedule float in days across activities. Low float indicates high schedule risk and limited recovery options."
    - name: "total_earned_value_bcwp"
      expr: SUM(CAST(earned_value_bcwp AS DOUBLE))
      comment: "Total budgeted cost of work performed (BCWP) at activity level. Activity-level EVM input."
    - name: "total_earned_value_bcws"
      expr: SUM(CAST(earned_value_bcws AS DOUBLE))
      comment: "Total budgeted cost of work scheduled (BCWS) at activity level. Planned value for activity-level EVM."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone performance metrics tracking on-time delivery, cost performance, and payment milestones. Used by PMO and executives to monitor contractual and strategic commitments."
  source: "`vibe_manufacturing_v1`.`project`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., contractual, internal, payment) for categorized milestone tracking."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., pending, achieved, overdue) for delivery monitoring."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the milestone is on the critical path. Critical milestones drive contract and payment events."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone for proactive risk management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the milestone for regulatory and contractual adherence tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of milestone financial values for multi-currency reporting."
    - name: "planned_date"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Month bucket of planned milestone date for delivery timeline analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestones. Baseline measure for project commitment tracking."
    - name: "achieved_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'ACHIEVED' THEN 1 END)
      comment: "Number of milestones achieved. Measures delivery execution against contractual commitments."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'OVERDUE' THEN 1 END)
      comment: "Number of overdue milestones. Triggers executive escalation and schedule recovery planning."
    - name: "milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'ACHIEVED' AND actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones delivered on or before planned date. Key delivery performance KPI for executive dashboards."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount tied to milestones. Tracks revenue recognition triggers and cash flow events."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred at milestone level. Supports milestone-level cost performance analysis."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost at milestone level. Baseline for milestone cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance at milestone level. Negative values indicate cost overrun on milestone deliverables."
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual duration to achieve milestones. Compared against planned duration to assess schedule performance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project commitment and obligation metrics tracking financial commitments, delivery performance, and budget exposure. Used by finance and PMO to manage project cash flow and obligations."
  source: "`vibe_manufacturing_v1`.`project`.`commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (e.g., purchase order, contract, reservation) for obligation categorization."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (e.g., open, partially delivered, closed) for obligation tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the commitment for financial governance and authorization control."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the commitment for multi-currency financial consolidation."
    - name: "is_funds_reserved"
      expr: is_funds_reserved
      comment: "Whether funds are formally reserved against the commitment. Impacts available budget calculations."
    - name: "commitment_date"
      expr: DATE_TRUNC('month', commitment_date)
      comment: "Month bucket of commitment creation date for obligation trend analysis."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount across all project obligations. Represents future cash outflows for financial planning."
    - name: "total_net_committed_amount"
      expr: SUM(CAST(net_committed_amount AS DOUBLE))
      comment: "Total net committed amount after adjustments. More accurate measure of outstanding financial obligations."
    - name: "total_actual_spent_amount"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total amount actually spent against commitments. Measures commitment liquidation rate."
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount for commitments. Baseline for commitment vs. budget variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and budgeted amounts. Signals budget pressure from over-commitment."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on commitments. Required for tax liability forecasting."
    - name: "commitment_liquidation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(committed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of committed amounts that have been spent. Low rates indicate delayed delivery or procurement bottlenecks."
    - name: "open_commitment_count"
      expr: COUNT(CASE WHEN commitment_status = 'OPEN' THEN 1 END)
      comment: "Number of open commitments. High counts indicate significant unresolved financial obligations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project labor timesheet metrics tracking hours worked, overtime, billability, and cost rates. Used by PMO and finance to manage labor costs and workforce productivity."
  source: "`vibe_manufacturing_v1`.`project`.`timesheet`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity recorded on the timesheet for labor category analysis."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (e.g., engineering, management, skilled trades) for workforce cost analysis."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labor grade for rate-based cost analysis and workforce mix optimization."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the hours are billable to the customer. Drives revenue recognition and billing efficiency."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the timesheet for payroll and billing governance."
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental labor cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of timesheet cost entries for financial consolidation."
    - name: "work_date"
      expr: DATE_TRUNC('week', work_date)
      comment: "Week bucket of work date for weekly labor trend analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all timesheets. Primary labor input metric for project cost and productivity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded. High overtime signals resource constraints and schedule pressure."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total hours worked. Elevated rates indicate workforce stress and cost overrun risk."
    - name: "total_labor_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total labor cost from timesheets. Core financial metric for project cost control."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average labor cost rate per hour. Used to benchmark workforce cost efficiency."
    - name: "billable_hours"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours recorded. Directly drives revenue recognition and customer invoicing."
    - name: "billability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are billable. Key profitability driver — low billability erodes project margins."
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense amount recorded on timesheets. Tracks non-labor project costs for full cost capture."
    - name: "overtime_cost"
      expr: SUM(CAST(overtime_hours AS DOUBLE) * CAST(cost_rate AS DOUBLE) * CAST(overtime_multiplier AS DOUBLE))
      comment: "Estimated overtime cost (overtime hours × cost rate × multiplier). Quantifies the financial impact of schedule pressure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment utilization and cost metrics for project workforce management. Used by PMO to optimize resource allocation and identify over/under-utilization."
  source: "`vibe_manufacturing_v1`.`project`.`resource_assignment`"
  dimensions:
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assigned resource for role-based utilization analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., full-time, part-time, contractor) for workforce mix analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (e.g., active, completed, cancelled) for active resource tracking."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the assigned resource for competency-based resource planning."
    - name: "department_code"
      expr: department_code
      comment: "Department of the assigned resource for departmental capacity analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Whether the assignment involves overtime. Flags resource stress and cost premium."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month bucket of assignment start date for resource demand timeline analysis."
  measures:
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours across all resource assignments. Drives capacity planning and resource demand forecasting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours consumed by assigned resources. Measures labor execution against plan."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours across assignments. Indicates resource constraint and schedule pressure."
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average resource utilization percentage. Values significantly above 100% indicate overallocation requiring rebalancing."
    - name: "total_cost_rate_amount"
      expr: SUM(CAST(cost_rate_amount AS DOUBLE))
      comment: "Total cost rate amount across assignments. Represents the financial value of resource commitments."
    - name: "hours_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Hours efficiency percentage (planned / actual). Values below 100% indicate resource overrun, triggering reallocation decisions."
    - name: "unique_resources_assigned"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees assigned to projects. Measures workforce breadth and identifies key-person concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project change request metrics tracking scope changes, cost impacts, and approval performance. Used by PMO and executives to govern scope creep and change control effectiveness."
  source: "`vibe_manufacturing_v1`.`project`.`project_change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change request (e.g., scope, schedule, cost) for change category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change request for governance and authorization tracking."
    - name: "project_change_request_status"
      expr: project_change_request_status
      comment: "Current lifecycle status of the change request for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority of the change request for triage and resource allocation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change request for impact assessment."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the change request is critical. Critical changes require expedited executive approval."
    - name: "request_timestamp"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month bucket of change request submission for change volume trend analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests. High volumes indicate scope instability and project management risk."
    - name: "approved_change_request_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved change requests. Measures change control throughput and governance effectiveness."
    - name: "total_cost_delta_amount"
      expr: SUM(CAST(cost_delta_amount AS DOUBLE))
      comment: "Total cost impact of all change requests. Quantifies the financial exposure from scope changes — key budget governance metric."
    - name: "avg_cost_delta_per_change"
      expr: AVG(CAST(cost_delta_amount AS DOUBLE))
      comment: "Average cost impact per change request. Benchmarks the typical financial magnitude of project changes."
    - name: "critical_change_request_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical change requests. Triggers executive escalation and expedited review processes."
    - name: "change_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests that are approved. Low rates may indicate poor change quality; high rates may indicate weak governance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project issue and risk metrics tracking open issues, resolution performance, cost impact, and risk scores. Used by PMO to manage project risk and ensure timely issue resolution."
  source: "`vibe_manufacturing_v1`.`project`.`issue`"
  dimensions:
    - name: "issue_type"
      expr: issue_type
      comment: "Type of issue (e.g., technical, resource, commercial) for issue category analysis."
    - name: "issue_status"
      expr: issue_status
      comment: "Current status of the issue (e.g., open, in progress, resolved) for resolution pipeline tracking."
    - name: "priority"
      expr: priority
      comment: "Priority of the issue for triage and escalation decisions."
    - name: "severity"
      expr: severity
      comment: "Severity of the issue for impact assessment and resource prioritization."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the issue for executive visibility and intervention tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of issue cost estimates for financial impact analysis."
    - name: "identified_timestamp"
      expr: DATE_TRUNC('month', identified_timestamp)
      comment: "Month bucket of issue identification date for issue trend analysis."
  measures:
    - name: "total_issues"
      expr: COUNT(1)
      comment: "Total number of project issues. Baseline measure for project health monitoring."
    - name: "open_issue_count"
      expr: COUNT(CASE WHEN issue_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open issues. High counts signal project execution risk requiring management attention."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost impact of all issues. Quantifies financial risk exposure from unresolved project issues."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred from issues. Measures realized financial impact of project problems."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all issues. Composite risk indicator for project health dashboards."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average probability of issue occurrence. Used in risk-weighted cost exposure calculations."
    - name: "issue_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN issue_status = 'RESOLVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issues that have been resolved. Key project management effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_procurement_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project procurement performance metrics tracking spend, delivery, invoice status, and supplier performance. Used by PMO and procurement to manage project supply chain execution."
  source: "`vibe_manufacturing_v1`.`project`.`procurement_item`"
  dimensions:
    - name: "procurement_category"
      expr: procurement_category
      comment: "Category of procurement (e.g., materials, services, equipment) for spend category analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g., competitive bid, sole source) for sourcing strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the procurement item for governance and authorization tracking."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status of the procurement item for accounts payable and cash flow management."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the procurement item for pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of procurement amounts for multi-currency financial consolidation."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month bucket of delivery date for procurement delivery timeline analysis."
  measures:
    - name: "total_procurement_spend"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total procurement spend across all project procurement items. Core financial metric for project supply chain cost control."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement amount (excluding tax and discounts). Used for budget vs. actual procurement analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount achieved on procurement. Measures procurement negotiation effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on procurement items. Required for tax compliance and financial reporting."
    - name: "total_receipt_quantity"
      expr: SUM(CAST(receipt_quantity AS DOUBLE))
      comment: "Total quantity received against procurement orders. Measures supply chain delivery completeness."
    - name: "receipt_completeness_pct"
      expr: ROUND(100.0 * SUM(CAST(receipt_quantity AS DOUBLE)) / NULLIF(SUM(CAST(line_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received. Low rates indicate supply chain delivery risk impacting project schedule."
    - name: "invoiced_item_count"
      expr: COUNT(CASE WHEN is_invoiced = TRUE THEN 1 END)
      comment: "Number of procurement items that have been invoiced. Tracks accounts payable pipeline completeness."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across procurement items. Benchmarks procurement cost efficiency and supplier pricing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project settlement and cost allocation metrics tracking financial settlement amounts, approval performance, and reversal activity. Used by finance to close project accounts and allocate final costs."
  source: "`vibe_manufacturing_v1`.`project`.`settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (e.g., pending, posted, reversed) for financial close tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the settlement for financial governance."
    - name: "receiver_object_type"
      expr: receiver_object_type
      comment: "Type of receiver object (e.g., cost center, GL account, asset) for settlement distribution analysis."
    - name: "is_manual_settlement"
      expr: is_manual_settlement
      comment: "Whether the settlement was manually created. Manual settlements carry higher audit risk."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the settlement has been reversed. High reversal rates indicate financial processing errors."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement for multi-currency financial consolidation."
    - name: "settlement_date"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month bucket of settlement date for financial close timeline analysis."
  measures:
    - name: "total_settlement_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross settlement amount. Measures the total financial value settled from project accounts."
    - name: "total_settlement_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net settlement amount after tax. Core financial close metric for project accounting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on settlements. Required for tax compliance and financial reporting."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed settlements. High counts indicate financial processing quality issues requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of settlements that have been reversed. Elevated rates signal financial process quality problems."
    - name: "manual_settlement_count"
      expr: COUNT(CASE WHEN is_manual_settlement = TRUE THEN 1 END)
      comment: "Number of manually created settlements. High counts increase audit risk and indicate process automation gaps."
    - name: "avg_settlement_amount_net"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net settlement amount per record. Benchmarks typical settlement size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_invoice_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project invoice request metrics tracking billing performance, revenue recognition, and payment milestones. Used by finance and project managers to manage project cash flow and revenue."
  source: "`vibe_manufacturing_v1`.`project`.`invoice_request`"
  dimensions:
    - name: "invoice_request_status"
      expr: invoice_request_status
      comment: "Current status of the invoice request (e.g., draft, submitted, approved, invoiced) for billing pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice request for financial governance."
    - name: "billing_basis"
      expr: billing_basis
      comment: "Basis for billing (e.g., milestone, time-and-material, fixed price) for revenue model analysis."
    - name: "is_advance"
      expr: is_advance
      comment: "Whether the invoice request is an advance payment. Advance invoices impact cash flow timing."
    - name: "is_final"
      expr: is_final
      comment: "Whether this is the final invoice request for the project. Triggers project financial close."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice request for multi-currency revenue reporting."
    - name: "billing_period_start"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Month bucket of billing period start for revenue recognition timeline analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross invoice request amount. Measures total project revenue billed to customers."
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net invoice request amount. Core revenue metric for project financial performance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoice requests. Required for tax compliance and financial reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoice requests. Measures revenue leakage from commercial concessions."
    - name: "avg_percent_complete_at_billing"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average project percent complete at time of invoice request. Validates billing is aligned with actual progress."
    - name: "approved_invoice_request_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved invoice requests. Measures billing throughput and revenue recognition readiness."
    - name: "billing_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoice requests that are approved. Low rates indicate billing disputes or governance bottlenecks impacting cash flow."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_progress_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project progress reporting metrics tracking schedule, cost, and overall project health over time. Used by PMO and executives for periodic project performance reviews."
  source: "`vibe_manufacturing_v1`.`project`.`progress_report`"
  dimensions:
    - name: "overall_status"
      expr: overall_status
      comment: "Overall project status (e.g., green, amber, red) for portfolio health dashboard."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status indicator for delivery risk monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory and contractual adherence tracking."
    - name: "reporting_cadence"
      expr: reporting_cadence
      comment: "Frequency of progress reporting (e.g., weekly, monthly) for governance cadence analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level reported in the progress report for portfolio risk monitoring."
    - name: "report_date"
      expr: DATE_TRUNC('month', report_date)
      comment: "Month bucket of report date for trend analysis of project health over time."
  measures:
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all reported projects. Portfolio-level progress indicator for executive steering meetings."
    - name: "avg_forecast_percent_complete"
      expr: AVG(CAST(forecast_percent_complete AS DOUBLE))
      comment: "Average forecasted percent complete. Compared against actual to assess forecast accuracy and delivery confidence."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost reported across all progress reports. Tracks cumulative project spend."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost reported. Baseline for cost performance analysis in progress reviews."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance reported. Negative values trigger executive intervention and corrective action."
    - name: "red_status_report_count"
      expr: COUNT(CASE WHEN overall_status = 'RED' THEN 1 END)
      comment: "Number of progress reports with red overall status. Directly triggers executive escalation and recovery planning."
    - name: "cost_performance_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Actual cost as a percentage of budgeted cost. Values above 100% indicate cost overrun requiring management action."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_earned_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value management KPIs"
  source: "`vibe_manufacturing_v1`.`project`.`earned_value_record`"
  dimensions:
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Work breakdown structure element identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the values"
    - name: "is_forecast"
      expr: is_forecast
      comment: "Indicates if the record is a forecast"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of reporting date"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of earned value records"
    - name: "sum_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost captured in earned value records"
    - name: "sum_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value (EV)"
    - name: "sum_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (PV)"
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average Cost Performance Index (CPI)"
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI)"
$$;