-- Metric views for domain: project | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic initiative performance metrics tracking budget utilization, cost variance, duration performance, and project health across campaigns and clients"
  source: "`advertising_ecm`.`project`.`initiative`"
  dimensions:
    - name: "initiative_name"
      expr: initiative_name
      comment: "Name of the initiative or project"
    - name: "project_code"
      expr: project_code
      comment: "Unique project code identifier"
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the initiative (e.g., Active, Completed, On Hold)"
    - name: "project_type"
      expr: project_type
      comment: "Type or category of project"
    - name: "health_indicator"
      expr: health_indicator
      comment: "Overall health status indicator (e.g., Green, Yellow, Red)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification for the initiative"
    - name: "priority"
      expr: priority
      comment: "Priority level of the initiative"
    - name: "delivery_methodology"
      expr: delivery_methodology
      comment: "Delivery methodology used (e.g., Agile, Waterfall, Hybrid)"
    - name: "billing_type"
      expr: billing_type
      comment: "Billing type for the initiative (e.g., Fixed Price, Time & Materials)"
    - name: "owning_department"
      expr: owning_department
      comment: "Department that owns the initiative"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the initiative is billable to client"
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether the initiative is confidential"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the initiative started"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(start_date), '-', YEAR(start_date))
      comment: "Quarter and year the initiative started"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the initiative was completed"
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total count of initiatives"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all initiatives"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all initiatives"
    - name: "avg_budget_per_initiative"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget amount per initiative"
    - name: "avg_actual_cost_per_initiative"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per initiative"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget utilized (actual cost / budget) - key financial efficiency metric"
    - name: "avg_client_satisfaction_score"
      expr: AVG(CAST(client_satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across initiatives - key quality metric"
    - name: "avg_planned_duration_days"
      expr: AVG(CAST(planned_duration_days AS DOUBLE))
      comment: "Average planned duration in days"
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual duration in days"
    - name: "initiatives_on_budget"
      expr: COUNT(CASE WHEN CAST(actual_cost AS DOUBLE) <= CAST(budget_amount AS DOUBLE) THEN 1 END)
      comment: "Count of initiatives that stayed within budget"
    - name: "initiatives_over_budget"
      expr: COUNT(CASE WHEN CAST(actual_cost AS DOUBLE) > CAST(budget_amount AS DOUBLE) THEN 1 END)
      comment: "Count of initiatives that exceeded budget"
    - name: "on_budget_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(actual_cost AS DOUBLE) <= CAST(budget_amount AS DOUBLE) THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of initiatives delivered on or under budget - key delivery performance metric"
    - name: "billable_initiatives_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Count of billable initiatives"
    - name: "billable_revenue_potential"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget amount for billable initiatives - revenue potential metric"
    - name: "high_satisfaction_initiatives"
      expr: COUNT(CASE WHEN CAST(client_satisfaction_score AS DOUBLE) >= 4.0 THEN 1 END)
      comment: "Count of initiatives with client satisfaction score >= 4.0"
    - name: "at_risk_initiatives"
      expr: COUNT(CASE WHEN health_indicator IN ('Red', 'Yellow') THEN 1 END)
      comment: "Count of initiatives with Red or Yellow health indicators - risk exposure metric"
    - name: "completed_initiatives"
      expr: COUNT(CASE WHEN initiative_status = 'Completed' THEN 1 END)
      comment: "Count of completed initiatives"
    - name: "active_initiatives"
      expr: COUNT(CASE WHEN initiative_status = 'Active' THEN 1 END)
      comment: "Count of currently active initiatives"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget performance metrics tracking approved budgets, actual spend, commitments, utilization, and budget health across cost categories"
  source: "`advertising_ecm`.`project`.`project_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Baseline, Forecast, Revised)"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the budget"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the budget"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code associated with the budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for budget amounts"
    - name: "baseline_budget_flag"
      expr: baseline_budget_flag
      comment: "Flag indicating if this is a baseline budget"
    - name: "client_approved_flag"
      expr: client_approved_flag
      comment: "Flag indicating if budget was approved by client"
    - name: "version"
      expr: version
      comment: "Budget version number"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the budget was approved"
    - name: "approval_quarter"
      expr: CONCAT('Q', QUARTER(approval_date), '-', YEAR(approval_date))
      comment: "Quarter and year the budget was approved"
  measures:
    - name: "total_budgets"
      expr: COUNT(1)
      comment: "Total count of project budgets"
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget amount across all projects"
    - name: "total_actual_spend"
      expr: SUM(CAST(total_actual_spend AS DOUBLE))
      comment: "Total actual spend across all projects"
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed spend (obligations not yet paid)"
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Total remaining budget available"
    - name: "avg_budget_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average budget utilization percentage across projects"
    - name: "total_labor_budget"
      expr: SUM(CAST(labor_budget AS DOUBLE))
      comment: "Total labor budget allocation"
    - name: "total_media_budget"
      expr: SUM(CAST(media_budget AS DOUBLE))
      comment: "Total media budget allocation"
    - name: "total_creative_production_budget"
      expr: SUM(CAST(creative_production_budget AS DOUBLE))
      comment: "Total creative production budget allocation"
    - name: "total_technology_budget"
      expr: SUM(CAST(technology_budget AS DOUBLE))
      comment: "Total technology budget allocation"
    - name: "total_vendor_budget"
      expr: SUM(CAST(third_party_vendor_budget AS DOUBLE))
      comment: "Total third-party vendor budget allocation"
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve AS DOUBLE))
      comment: "Total contingency reserve across projects"
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve AS DOUBLE))
      comment: "Total management reserve across projects"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget AS DOUBLE)), 0), 2)
      comment: "Overall budget utilization rate (actual spend / approved budget) - key financial control metric"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_committed_spend AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget AS DOUBLE)), 0), 2)
      comment: "Commitment rate (committed spend / approved budget) - forward-looking obligation metric"
    - name: "labor_budget_share"
      expr: ROUND(100.0 * SUM(CAST(labor_budget AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget AS DOUBLE)), 0), 2)
      comment: "Labor budget as percentage of total approved budget - resource allocation metric"
    - name: "media_budget_share"
      expr: ROUND(100.0 * SUM(CAST(media_budget AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget AS DOUBLE)), 0), 2)
      comment: "Media budget as percentage of total approved budget - media investment metric"
    - name: "client_approved_budgets"
      expr: COUNT(CASE WHEN client_approved_flag = TRUE THEN 1 END)
      comment: "Count of budgets approved by client"
    - name: "baseline_budgets"
      expr: COUNT(CASE WHEN baseline_budget_flag = TRUE THEN 1 END)
      comment: "Count of baseline budgets"
    - name: "avg_approved_budget"
      expr: AVG(CAST(total_approved_budget AS DOUBLE))
      comment: "Average approved budget per project"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time tracking and labor utilization metrics measuring hours logged, billable vs non-billable time, billing efficiency, and resource utilization"
  source: "`advertising_ecm`.`project`.`time_entry`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity performed"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating if time is billable to client"
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flag indicating if time is overtime"
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating if time entry is locked from editing"
    - name: "location"
      expr: location
      comment: "Work location for the time entry"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for billing and cost amounts"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year of the time entry"
    - name: "entry_quarter"
      expr: CONCAT('Q', QUARTER(entry_date), '-', YEAR(entry_date))
      comment: "Quarter and year of the time entry"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of the time entry"
    - name: "entry_week"
      expr: DATE_TRUNC('WEEK', entry_date)
      comment: "Week of the time entry"
  measures:
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total count of time entries"
    - name: "total_hours_logged"
      expr: SUM(CAST(hours_logged AS DOUBLE))
      comment: "Total hours logged across all time entries"
    - name: "total_billable_amount"
      expr: SUM(CAST(billable_amount AS DOUBLE))
      comment: "Total billable amount generated from time entries"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost amount for time entries"
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours logged"
    - name: "non_billable_hours"
      expr: SUM(CASE WHEN is_billable = FALSE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Total non-billable hours logged"
    - name: "overtime_hours"
      expr: SUM(CASE WHEN is_overtime = TRUE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Total overtime hours logged"
    - name: "billable_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(hours_logged AS DOUBLE)), 0), 2)
      comment: "Billable utilization rate (billable hours / total hours) - key resource efficiency metric"
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate per hour"
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per hour"
    - name: "blended_billing_rate"
      expr: ROUND(SUM(CAST(billable_amount AS DOUBLE)) / NULLIF(SUM(CASE WHEN is_billable = TRUE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END), 0), 2)
      comment: "Blended billing rate (total billable amount / billable hours) - realized rate metric"
    - name: "blended_cost_rate"
      expr: ROUND(SUM(CAST(cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(hours_logged AS DOUBLE)), 0), 2)
      comment: "Blended cost rate (total cost / total hours) - average cost per hour metric"
    - name: "labor_margin_amount"
      expr: SUM((CAST(billable_amount AS DOUBLE)) - (CAST(cost_amount AS DOUBLE)))
      comment: "Total labor margin (billable amount minus cost amount) - profitability metric"
    - name: "labor_margin_rate"
      expr: ROUND(100.0 * (SUM(CAST(billable_amount AS DOUBLE)) - SUM(CAST(cost_amount AS DOUBLE))) / NULLIF(SUM(CAST(billable_amount AS DOUBLE)), 0), 2)
      comment: "Labor margin rate ((billable - cost) / billable) - profitability percentage metric"
    - name: "approved_time_entries"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved time entries"
    - name: "pending_time_entries"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Count of pending time entries"
    - name: "rejected_time_entries"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected time entries"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_logged AS DOUBLE))
      comment: "Average hours per time entry"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Task execution and delivery performance metrics tracking task completion, effort variance, on-time delivery, and workload distribution"
  source: "`advertising_ecm`.`project`.`task`"
  dimensions:
    - name: "task_name"
      expr: task_name
      comment: "Name of the task"
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task"
    - name: "task_type"
      expr: task_type
      comment: "Type or category of task"
    - name: "priority"
      expr: priority
      comment: "Priority level of the task"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the task"
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable associated with the task"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating if task is billable"
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating if task is a milestone"
    - name: "dependency_type"
      expr: dependency_type
      comment: "Type of dependency relationship"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned task start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date), '-', YEAR(planned_start_date))
      comment: "Quarter and year of planned task start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year of actual task start"
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total count of tasks"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all tasks"
    - name: "total_logged_hours"
      expr: SUM(CAST(logged_hours AS DOUBLE))
      comment: "Total logged hours across all tasks"
    - name: "avg_estimated_hours"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated hours per task"
    - name: "avg_logged_hours"
      expr: AVG(CAST(logged_hours AS DOUBLE))
      comment: "Average logged hours per task"
    - name: "effort_variance_hours"
      expr: SUM((CAST(logged_hours AS DOUBLE)) - (CAST(estimated_hours AS DOUBLE)))
      comment: "Total effort variance (logged minus estimated hours) - estimation accuracy metric"
    - name: "effort_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(logged_hours AS DOUBLE)) - SUM(CAST(estimated_hours AS DOUBLE))) / NULLIF(SUM(CAST(estimated_hours AS DOUBLE)), 0), 2)
      comment: "Effort variance rate ((logged - estimated) / estimated) - estimation accuracy percentage"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across tasks"
    - name: "completed_tasks"
      expr: COUNT(CASE WHEN task_status = 'Completed' THEN 1 END)
      comment: "Count of completed tasks"
    - name: "in_progress_tasks"
      expr: COUNT(CASE WHEN task_status = 'In Progress' THEN 1 END)
      comment: "Count of tasks currently in progress"
    - name: "blocked_tasks"
      expr: COUNT(CASE WHEN task_status = 'Blocked' THEN 1 END)
      comment: "Count of blocked tasks"
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Task completion rate (completed / total tasks) - delivery performance metric"
    - name: "billable_tasks"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Count of billable tasks"
    - name: "milestone_tasks"
      expr: COUNT(CASE WHEN is_milestone = TRUE THEN 1 END)
      comment: "Count of milestone tasks"
    - name: "billable_hours_estimated"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(estimated_hours AS DOUBLE) ELSE 0 END)
      comment: "Total estimated hours for billable tasks"
    - name: "billable_hours_logged"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(logged_hours AS DOUBLE) ELSE 0 END)
      comment: "Total logged hours for billable tasks"
    - name: "approved_tasks"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved tasks"
    - name: "high_priority_tasks"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Count of high priority tasks"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change request and scope management metrics tracking change volume, approval rates, cost and timeline impacts, and scope creep"
  source: "`advertising_ecm`.`project`.`change_request`"
  dimensions:
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current status of the change request"
    - name: "change_type"
      expr: change_type
      comment: "Type or category of change"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change request"
    - name: "requestor_type"
      expr: requestor_type
      comment: "Type of requestor (e.g., Client, Internal)"
    - name: "client_approval_required_flag"
      expr: client_approval_required_flag
      comment: "Flag indicating if client approval is required"
    - name: "billing_impact_flag"
      expr: billing_impact_flag
      comment: "Flag indicating if change impacts billing"
    - name: "scope_creep_flag"
      expr: scope_creep_flag
      comment: "Flag indicating if change represents scope creep"
    - name: "impact_cost_currency"
      expr: impact_cost_currency
      comment: "Currency for cost impact amounts"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the change request was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter and year the change request was submitted"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the change request was approved"
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total count of change requests"
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_cost_delta AS DOUBLE))
      comment: "Total cost impact across all change requests"
    - name: "total_effort_impact_hours"
      expr: SUM(CAST(impact_effort_hours_delta AS DOUBLE))
      comment: "Total effort impact in hours across all change requests"
    - name: "avg_cost_impact"
      expr: AVG(CAST(impact_cost_delta AS DOUBLE))
      comment: "Average cost impact per change request"
    - name: "avg_effort_impact_hours"
      expr: AVG(CAST(impact_effort_hours_delta AS DOUBLE))
      comment: "Average effort impact in hours per change request"
    - name: "approved_change_requests"
      expr: COUNT(CASE WHEN change_request_status = 'Approved' THEN 1 END)
      comment: "Count of approved change requests"
    - name: "rejected_change_requests"
      expr: COUNT(CASE WHEN change_request_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected change requests"
    - name: "pending_change_requests"
      expr: COUNT(CASE WHEN change_request_status = 'Pending' THEN 1 END)
      comment: "Count of pending change requests"
    - name: "change_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_request_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN change_request_status IN ('Approved', 'Rejected') THEN 1 END), 0), 2)
      comment: "Change request approval rate (approved / (approved + rejected)) - governance effectiveness metric"
    - name: "scope_creep_requests"
      expr: COUNT(CASE WHEN scope_creep_flag = TRUE THEN 1 END)
      comment: "Count of change requests flagged as scope creep"
    - name: "scope_creep_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scope_creep_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Scope creep rate (scope creep requests / total requests) - scope control metric"
    - name: "billing_impact_requests"
      expr: COUNT(CASE WHEN billing_impact_flag = TRUE THEN 1 END)
      comment: "Count of change requests with billing impact"
    - name: "client_approval_required_requests"
      expr: COUNT(CASE WHEN client_approval_required_flag = TRUE THEN 1 END)
      comment: "Count of change requests requiring client approval"
    - name: "cost_impact_of_approved_changes"
      expr: SUM(CASE WHEN change_request_status = 'Approved' THEN CAST(impact_cost_delta AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of approved change requests - financial exposure metric"
    - name: "effort_impact_of_approved_changes"
      expr: SUM(CASE WHEN change_request_status = 'Approved' THEN CAST(impact_effort_hours_delta AS DOUBLE) ELSE 0 END)
      comment: "Total effort impact of approved change requests - resource exposure metric"
    - name: "high_priority_changes"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Count of high priority change requests"
    - name: "client_initiated_changes"
      expr: COUNT(CASE WHEN requestor_type = 'Client' THEN 1 END)
      comment: "Count of client-initiated change requests"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and issue management metrics tracking risk exposure, mitigation effectiveness, escalation rates, and risk resolution performance"
  source: "`advertising_ecm`.`project`.`risk_register`"
  dimensions:
    - name: "risk_register_status"
      expr: risk_register_status
      comment: "Current status of the risk or issue"
    - name: "risk_register_type"
      expr: risk_register_type
      comment: "Type (Risk or Issue)"
    - name: "risk_register_category"
      expr: risk_register_category
      comment: "Category of risk or issue"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating (e.g., High, Medium, Low)"
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating (e.g., High, Medium, Low)"
    - name: "risk_score"
      expr: risk_score
      comment: "Calculated risk score"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the risk or issue"
    - name: "client_visibility_flag"
      expr: client_visibility_flag
      comment: "Flag indicating if risk is visible to client"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the risk was identified"
    - name: "identified_quarter"
      expr: CONCAT('Q', QUARTER(identified_date), '-', YEAR(identified_date))
      comment: "Quarter and year the risk was identified"
  measures:
    - name: "total_risks_and_issues"
      expr: COUNT(1)
      comment: "Total count of risks and issues"
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of all risks and issues"
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per risk or issue"
    - name: "open_risks_and_issues"
      expr: COUNT(CASE WHEN risk_register_status IN ('Open', 'Active') THEN 1 END)
      comment: "Count of open or active risks and issues"
    - name: "closed_risks_and_issues"
      expr: COUNT(CASE WHEN risk_register_status = 'Closed' THEN 1 END)
      comment: "Count of closed risks and issues"
    - name: "mitigated_risks"
      expr: COUNT(CASE WHEN risk_register_status = 'Mitigated' THEN 1 END)
      comment: "Count of mitigated risks"
    - name: "high_impact_risks"
      expr: COUNT(CASE WHEN impact_rating = 'High' THEN 1 END)
      comment: "Count of high impact risks and issues"
    - name: "high_probability_risks"
      expr: COUNT(CASE WHEN probability_rating = 'High' THEN 1 END)
      comment: "Count of high probability risks"
    - name: "escalated_risks"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END)
      comment: "Count of escalated risks and issues"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Escalation rate (escalated / total) - risk severity metric"
    - name: "client_visible_risks"
      expr: COUNT(CASE WHEN client_visibility_flag = TRUE THEN 1 END)
      comment: "Count of risks visible to client"
    - name: "risk_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_register_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Risk closure rate (closed / total) - risk resolution effectiveness metric"
    - name: "risks_count"
      expr: COUNT(CASE WHEN risk_register_type = 'Risk' THEN 1 END)
      comment: "Count of risks (not yet materialized)"
    - name: "issues_count"
      expr: COUNT(CASE WHEN risk_register_type = 'Issue' THEN 1 END)
      comment: "Count of issues (materialized risks)"
    - name: "cost_impact_of_open_risks"
      expr: SUM(CASE WHEN risk_register_status IN ('Open', 'Active') THEN CAST(estimated_cost_impact AS DOUBLE) ELSE 0 END)
      comment: "Total estimated cost impact of open risks - financial exposure metric"
    - name: "high_severity_risks"
      expr: COUNT(CASE WHEN impact_rating = 'High' AND probability_rating = 'High' THEN 1 END)
      comment: "Count of high severity risks (high impact and high probability) - critical risk exposure metric"
$$;