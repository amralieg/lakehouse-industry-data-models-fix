-- Metric views for domain: project | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for advertising initiatives (projects). Covers budget performance, cost efficiency, schedule adherence, and client satisfaction — the primary levers executives use to steer portfolio health."
  source: "`advertising_ecm`.`project`.`initiative`"
  dimensions:
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current lifecycle status of the initiative (e.g. Active, Completed, Cancelled) — primary filter for portfolio health views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the initiative by work type (e.g. Campaign, Brand Strategy, Media Planning) — used to segment performance by service line."
    - name: "priority"
      expr: priority
      comment: "Business priority level assigned to the initiative — enables triage and resource allocation analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the initiative — used to identify at-risk projects requiring executive attention."
    - name: "health_indicator"
      expr: health_indicator
      comment: "Overall health signal (e.g. Green, Amber, Red) — the primary dashboard indicator for portfolio steering."
    - name: "owning_department"
      expr: owning_department
      comment: "Department responsible for the initiative — enables departmental performance benchmarking."
    - name: "billing_type"
      expr: billing_type
      comment: "Revenue model for the initiative (e.g. Fixed Fee, Time & Materials) — critical for margin analysis."
    - name: "delivery_methodology"
      expr: delivery_methodology
      comment: "Delivery approach (e.g. Agile, Waterfall) — used to compare efficiency across methodologies."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency in which the initiative budget is denominated — required for multi-currency portfolio reporting."
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the initiative started — enables trend analysis of initiative launches over time."
    - name: "completion_year_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the initiative was completed — used for throughput and delivery cadence analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the initiative generates billable revenue — key for revenue vs. investment portfolio split."
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total number of initiatives in scope. Baseline volume metric for portfolio sizing and capacity planning."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of approved budget amounts across initiatives. Represents total capital committed to the project portfolio — a primary financial governance metric."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred across initiatives. Compared against budget to assess financial performance and cost overrun exposure."
    - name: "budget_variance"
      expr: SUM(CAST(budget_amount AS DOUBLE) - CAST(actual_cost AS DOUBLE))
      comment: "Aggregate budget surplus or deficit (budget minus actual cost). Positive values indicate underspend; negative values signal cost overruns requiring executive intervention."
    - name: "avg_cost_to_budget_ratio"
      expr: AVG(CAST(actual_cost AS DOUBLE) / NULLIF(CAST(budget_amount AS DOUBLE), 0))
      comment: "Average ratio of actual cost to approved budget per initiative. Values above 1.0 indicate systematic cost overruns — a key efficiency and financial discipline KPI."
    - name: "avg_client_satisfaction_score"
      expr: AVG(CAST(client_satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across initiatives. A leading indicator of client retention risk and service quality — directly tied to revenue renewal decisions."
    - name: "billable_initiative_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable initiatives. Used to track the revenue-generating portion of the portfolio versus investment or overhead work."
    - name: "cancelled_initiative_count"
      expr: COUNT(CASE WHEN initiative_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled initiatives. A high cancellation rate signals scope instability, client relationship issues, or poor project qualification — triggers strategic review."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initiative_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of initiatives that were cancelled. Executives use this to assess portfolio health and client commitment quality."
    - name: "total_billable_budget"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to billable initiatives. Represents the revenue-generating capacity of the project portfolio — a core financial planning metric."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial governance KPIs for project budgets. Tracks budget utilization, spend composition, variance, and approval status — essential for CFO-level portfolio financial oversight."
  source: "`advertising_ecm`.`project`.`project_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g. Original, Revised, Contingency) — used to distinguish baseline from amended financial plans."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the budget record — filters for active, approved, or locked budgets."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget — primary time dimension for annual financial planning and variance reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the budget — enables quarterly financial review and reforecast cycles."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the budget — required for multi-currency financial consolidation."
    - name: "baseline_budget_flag"
      expr: baseline_budget_flag
      comment: "Indicates whether this is the original baseline budget — used to isolate baseline vs. revised budget comparisons."
    - name: "client_approved_flag"
      expr: client_approved_flag
      comment: "Indicates client approval status — critical for revenue recognition and billing authorization."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget became effective — used for budget activation trend analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget across all project budget records. The primary financial envelope metric for portfolio investment governance."
    - name: "total_actual_spend"
      expr: SUM(CAST(total_actual_spend AS DOUBLE))
      comment: "Total actual spend recorded against project budgets. Compared against approved budget to assess financial execution."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) amounts. Represents financial exposure beyond actual spend — critical for cash flow forecasting."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Total remaining budget available across projects. A key liquidity and capacity metric for resource allocation decisions."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average budget utilization rate across project budgets. Values near 100% indicate tight financial management; significantly below signals underutilization or delayed execution."
    - name: "total_labor_budget"
      expr: SUM(CAST(labor_budget AS DOUBLE))
      comment: "Total labor budget across projects. Labor is typically the largest cost driver in advertising — tracked separately for workforce cost governance."
    - name: "total_media_budget"
      expr: SUM(CAST(media_budget AS DOUBLE))
      comment: "Total media spend budget. Media investment is the primary revenue-generating expenditure in advertising — a board-level financial metric."
    - name: "total_third_party_vendor_budget"
      expr: SUM(CAST(third_party_vendor_budget AS DOUBLE))
      comment: "Total budget allocated to third-party vendors. Tracks external spend concentration and vendor dependency risk."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve AS DOUBLE))
      comment: "Total contingency reserves held across project budgets. Indicates risk provisioning adequacy — low reserves on high-risk projects trigger executive review."
    - name: "budget_overrun_count"
      expr: COUNT(CASE WHEN CAST(total_actual_spend AS DOUBLE) > CAST(total_approved_budget AS DOUBLE) THEN 1 END)
      comment: "Number of project budgets where actual spend has exceeded the approved budget. A direct indicator of financial control failures requiring immediate intervention."
    - name: "budget_overrun_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(total_actual_spend AS DOUBLE) > CAST(total_approved_budget AS DOUBLE) THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of project budgets in overrun. Executives use this to assess systemic estimation accuracy and financial discipline across the portfolio."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor efficiency and billing KPIs derived from time entries. Tracks billable hours, cost recovery, overtime exposure, and approval throughput — core metrics for agency profitability management."
  source: "`advertising_ecm`.`project`.`time_entry`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of work activity logged (e.g. Creative, Strategy, Production) — used to analyze labor mix and cost allocation by service type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the time entry (e.g. Submitted, Approved, Rejected) — used to track timesheet governance and billing readiness."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the time entry is billable to the client — the primary dimension for billable vs. non-billable labor analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Indicates overtime hours — used to monitor overtime exposure and associated cost premiums."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing and cost amounts — required for multi-currency revenue reporting."
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of the time entry — primary time dimension for monthly labor cost and billing trend analysis."
    - name: "location"
      expr: location
      comment: "Work location of the time entry — used to analyze remote vs. on-site labor distribution and associated cost differences."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the time entry is locked for billing — used to track billing cycle closure and revenue recognition readiness."
  measures:
    - name: "total_hours_logged"
      expr: SUM(CAST(hours_logged AS DOUBLE))
      comment: "Total hours logged across all time entries. The foundational labor volume metric for capacity utilization and project cost tracking."
    - name: "total_billable_amount"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(billable_amount AS DOUBLE) ELSE 0 END)
      comment: "Total billable revenue generated from time entries. A primary revenue recognition metric for agency financial performance."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total internal cost of labor logged. Compared against billable amounts to assess gross margin on labor."
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours logged. Used to calculate billable utilization rate — a core agency efficiency KPI."
    - name: "non_billable_hours"
      expr: SUM(CASE WHEN is_billable = FALSE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Total non-billable hours. High non-billable ratios indicate overhead inefficiency or scope management issues."
    - name: "overtime_hours"
      expr: SUM(CASE WHEN is_overtime = TRUE THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Total overtime hours logged. Elevated overtime signals resource under-staffing or schedule compression — triggers workforce planning review."
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate per time entry. Tracks rate realization against contracted rates — a key revenue quality metric."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average internal cost rate per time entry. Used alongside billing rate to monitor margin per resource type."
    - name: "pending_approval_hours"
      expr: SUM(CASE WHEN approval_status = 'Submitted' THEN CAST(hours_logged AS DOUBLE) ELSE 0 END)
      comment: "Hours awaiting approval. Large pending volumes delay billing cycles and revenue recognition — an operational urgency metric."
    - name: "rejected_entry_count"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected time entries. High rejection rates indicate timesheet quality issues or policy non-compliance — triggers process improvement action."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment efficiency KPIs. Tracks planned vs. actual hours, billing rate realization, utilization, and reassignment rates — essential for workforce productivity and project staffing governance."
  source: "`advertising_ecm`.`project`.`assignment`"
  dimensions:
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assigned resource (e.g. Art Director, Strategist, Producer) — primary dimension for role-based productivity and cost analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (e.g. Active, Completed, Reassigned) — used to filter active workforce and track completion rates."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the assignment is billable — used to split billable vs. overhead resource allocation."
    - name: "utilization_category"
      expr: utilization_category
      comment: "Categorization of resource utilization (e.g. Underutilized, Optimal, Overloaded) — a key workforce health dimension."
    - name: "work_location"
      expr: work_location
      comment: "Physical or remote work location of the assignment — used for location-based cost and productivity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of billing and cost rates — required for multi-currency financial reporting."
    - name: "priority"
      expr: priority
      comment: "Priority level of the assignment — used to ensure high-priority work is adequately staffed."
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the assignment started — used for staffing trend and capacity planning analysis."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates whether the resource is eligible for overtime — used in workforce cost risk analysis."
  measures:
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours across all assignments. Represents the planned labor capacity committed to projects — a core resource planning metric."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across assignments. Compared against planned hours to assess execution accuracy and schedule adherence."
    - name: "hours_variance"
      expr: SUM(CAST(planned_hours AS DOUBLE) - CAST(actual_hours AS DOUBLE))
      comment: "Aggregate variance between planned and actual hours (planned minus actual). Negative values indicate scope creep or underestimation — a key project health signal."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average resource allocation percentage across assignments. Values consistently near or above 100% indicate overallocation risk — triggers staffing intervention."
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate across assignments. Tracks rate realization and pricing consistency across the resource pool."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average internal cost rate across assignments. Used with billing rate to monitor per-assignment margin."
    - name: "reassigned_assignment_count"
      expr: COUNT(CASE WHEN reassigned_from_project_assignment_id IS NOT NULL THEN 1 END)
      comment: "Number of assignments that were reassigned from a prior assignment. High reassignment rates signal staffing instability or resource availability issues."
    - name: "billable_assignment_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of billable assignments. Used to track the revenue-generating portion of the workforce allocation."
    - name: "hours_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of planned hours actually worked. Below 80% may indicate resource unavailability or scope reduction; above 110% signals overrun — a key delivery efficiency KPI."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_deliverable_tracker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deliverable quality and on-time delivery KPIs. Tracks delivery performance, approval cycle efficiency, revision rates, and billable output — critical for client satisfaction and operational throughput."
  source: "`advertising_ecm`.`project`.`deliverable_tracker`"
  dimensions:
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g. Creative Asset, Report, Media Plan) — used to analyze performance by output category."
    - name: "deliverable_status"
      expr: deliverable_status
      comment: "Current status of the deliverable (e.g. In Progress, Delivered, Approved) — primary filter for delivery pipeline views."
    - name: "client_approval_status"
      expr: client_approval_status
      comment: "Client-side approval state — tracks client acceptance rate and approval cycle bottlenecks."
    - name: "internal_approval_status"
      expr: internal_approval_status
      comment: "Internal quality gate approval status — used to monitor internal review throughput and quality control."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the deliverable is distributed (e.g. Digital, Print, Broadcast) — used for channel-specific delivery performance analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the deliverable — used to ensure high-priority outputs are tracked and escalated appropriately."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the deliverable is billable — used to track revenue-generating output volume."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of compliance review for the deliverable — critical for regulated advertising content governance."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month the deliverable was planned for delivery — used for delivery schedule trend analysis."
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of deliverables tracked. Baseline throughput metric for production capacity and output volume management."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END)
      comment: "Number of deliverables delivered on or before the planned date. A primary client satisfaction and operational excellence KPI."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed deliverables delivered on time. Below target triggers delivery process review and resource reallocation."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated production hours across deliverables. Used for capacity planning and estimation accuracy benchmarking."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent producing deliverables. Compared against estimates to assess production efficiency."
    - name: "hours_overrun"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(estimated_hours AS DOUBLE))
      comment: "Aggregate hours overrun (actual minus estimated). Positive values indicate systematic underestimation — a key scoping and pricing accuracy signal."
    - name: "client_approved_count"
      expr: COUNT(CASE WHEN client_approval_status = 'Approved' THEN 1 END)
      comment: "Number of deliverables approved by the client. Tracks client acceptance throughput and quality of output."
    - name: "client_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables receiving client approval. Low rates indicate quality or alignment issues — a leading indicator of client satisfaction risk."
    - name: "compliance_failed_count"
      expr: COUNT(CASE WHEN compliance_check_status = 'Failed' THEN 1 END)
      comment: "Number of deliverables that failed compliance checks. Any non-zero value in regulated advertising contexts triggers immediate remediation — a risk governance metric."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project schedule and contractual milestone KPIs. Tracks on-time milestone achievement, critical path adherence, billing trigger status, and completion rates — essential for contract governance and client delivery commitments."
  source: "`advertising_ecm`.`project`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Classification of the milestone (e.g. Kickoff, Review Gate, Final Delivery) — used to analyze performance by milestone category."
    - name: "project_milestone_status"
      expr: project_milestone_status
      comment: "Current status of the milestone (e.g. Pending, Achieved, Overdue) — primary filter for schedule health dashboards."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone — used to prioritize at-risk milestones for executive escalation."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path — critical path milestones receive highest monitoring priority."
    - name: "is_billing_trigger"
      expr: is_billing_trigger
      comment: "Indicates whether milestone achievement triggers a client billing event — directly linked to revenue recognition timing."
    - name: "is_contractual_gate"
      expr: is_contractual_gate
      comment: "Indicates whether the milestone is a contractual gate — missed contractual gates carry legal and financial consequences."
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone was planned — used for schedule trend and delivery cadence analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestones tracked. Baseline metric for project schedule complexity and governance scope."
    - name: "achieved_on_time_count"
      expr: COUNT(CASE WHEN actual_date <= planned_date AND actual_date IS NOT NULL THEN 1 END)
      comment: "Number of milestones achieved on or before the planned date. A primary schedule adherence and contract compliance KPI."
    - name: "on_time_milestone_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date <= planned_date AND actual_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones achieved on time. Below target triggers schedule recovery planning and client communication."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones. Tracks overall schedule progress — a key project health indicator for steering meetings."
    - name: "billing_trigger_achieved_count"
      expr: COUNT(CASE WHEN is_billing_trigger = TRUE AND actual_date IS NOT NULL THEN 1 END)
      comment: "Number of billing-trigger milestones that have been achieved. Directly maps to revenue recognition events — a critical financial reporting metric."
    - name: "critical_path_overdue_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND project_milestone_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue milestones on the critical path. Any non-zero value signals project delivery risk requiring immediate executive escalation."
    - name: "contractual_gate_missed_count"
      expr: COUNT(CASE WHEN is_contractual_gate = TRUE AND actual_date > planned_date THEN 1 END)
      comment: "Number of contractual gate milestones missed (actual date after planned date). Missed contractual gates carry legal, financial, and reputational consequences — a zero-tolerance governance metric."
    - name: "replanned_milestone_count"
      expr: COUNT(CASE WHEN replanned_from_project_milestone_id IS NOT NULL THEN 1 END)
      comment: "Number of milestones that were replanned from a prior milestone. High replanning rates indicate chronic schedule instability — triggers root cause analysis."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_work_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work package execution KPIs. Tracks cost performance, effort efficiency, schedule adherence, and completion rates at the work breakdown structure level — essential for project delivery governance."
  source: "`advertising_ecm`.`project`.`work_package`"
  dimensions:
    - name: "work_package_status"
      expr: work_package_status
      comment: "Current status of the work package (e.g. In Progress, Completed, On Hold) — primary filter for delivery pipeline views."
    - name: "work_package_type"
      expr: work_package_type
      comment: "Type of work package (e.g. Creative, Media, Technology) — used to analyze performance by work category."
    - name: "discipline"
      expr: discipline
      comment: "Discipline or practice area responsible for the work package — enables cross-discipline performance benchmarking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work package — used to ensure high-priority work is adequately resourced and monitored."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the work package is billable — used to track revenue-generating vs. overhead work."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the work package is on the critical path — critical path packages receive highest delivery priority."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Level in the work breakdown structure hierarchy — used to analyze performance at different levels of project decomposition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts — required for multi-currency financial reporting."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the work package was planned to start — used for delivery schedule trend analysis."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across work packages. Represents the cost baseline for project financial governance."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across work packages. Compared against planned cost to assess cost performance."
    - name: "cost_variance"
      expr: SUM(CAST(planned_cost AS DOUBLE) - CAST(actual_cost AS DOUBLE))
      comment: "Aggregate cost variance (planned minus actual). Negative values indicate cost overruns — a primary project financial health metric."
    - name: "total_planned_effort_hours"
      expr: SUM(CAST(planned_effort_hours AS DOUBLE))
      comment: "Total planned effort hours across work packages. Baseline for capacity planning and effort estimation accuracy."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours expended. Compared against planned to assess effort estimation accuracy and productivity."
    - name: "effort_variance"
      expr: SUM(CAST(planned_effort_hours AS DOUBLE) - CAST(actual_effort_hours AS DOUBLE))
      comment: "Aggregate effort variance (planned minus actual hours). Persistent negative values indicate systematic underestimation — triggers estimation process review."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across work packages. Tracks overall portfolio progress — a key steering metric for project reviews."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 3)
      comment: "Cost Performance Index (CPI = planned cost / actual cost). CPI > 1.0 indicates under-budget performance; CPI < 1.0 signals cost overrun. An industry-standard earned value metric used in executive project reviews."
    - name: "effort_performance_index"
      expr: ROUND(SUM(CAST(planned_effort_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_effort_hours AS DOUBLE)), 0), 3)
      comment: "Effort Performance Index (planned hours / actual hours). Analogous to CPI for labor efficiency — values below 1.0 indicate productivity shortfalls."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_resource_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource planning KPIs. Tracks planned FTE and cost commitments, role and seniority mix, and planning coverage — essential for workforce capacity management and cost forecasting."
  source: "`advertising_ecm`.`project`.`resource_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Approval and lifecycle status of the resource plan (e.g. Draft, Approved, Locked) — used to filter active plans for capacity analysis."
    - name: "role_name"
      expr: role_name
      comment: "Name of the planned resource role — primary dimension for role-based capacity and cost analysis."
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of the planned resource — used to analyze talent mix and associated cost implications."
    - name: "discipline"
      expr: discipline
      comment: "Practice discipline of the planned resource — used for cross-discipline capacity planning."
    - name: "department_name"
      expr: department_name
      comment: "Department owning the resource plan — enables departmental capacity and cost forecasting."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the planned resource is billable — used to split billable vs. overhead capacity planning."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g. Monthly, Quarterly) — used to normalize capacity metrics across different planning horizons."
    - name: "planning_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month the planning period starts — primary time dimension for capacity trend analysis."
    - name: "cost_rate_currency"
      expr: cost_rate_currency
      comment: "Currency of the cost rate — required for multi-currency workforce cost reporting."
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte AS DOUBLE))
      comment: "Total planned FTE (Full-Time Equivalent) across resource plans. The primary workforce capacity metric for headcount planning and budget forecasting."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours across resource plans. Used for detailed capacity planning and project staffing adequacy assessment."
    - name: "total_planned_cost"
      expr: SUM(CAST(total_planned_cost AS DOUBLE))
      comment: "Total planned labor cost across resource plans. A primary input to project financial forecasting and budget validation."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per resource plan record. Used to benchmark labor cost efficiency and identify rate anomalies."
    - name: "billable_planned_fte"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(planned_fte AS DOUBLE) ELSE 0 END)
      comment: "Total planned FTE allocated to billable work. Represents the revenue-generating workforce capacity — a key agency utilization metric."
    - name: "billable_fte_ratio"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN CAST(planned_fte AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(planned_fte AS DOUBLE)), 0), 2)
      comment: "Percentage of planned FTE allocated to billable work. A core agency efficiency metric — low ratios indicate high overhead burden impacting profitability."
    - name: "distinct_roles_planned"
      expr: COUNT(DISTINCT role_name)
      comment: "Number of distinct roles planned across resource plans. Tracks workforce diversity and specialization breadth — used in talent strategy reviews."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`project_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Task execution and throughput KPIs. Tracks completion rates, estimation accuracy, billable task volume, and schedule adherence at the task level — operational metrics for delivery team performance management."
  source: "`advertising_ecm`.`project`.`task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g. Open, In Progress, Completed, Blocked) — primary filter for delivery pipeline and bottleneck analysis."
    - name: "task_type"
      expr: task_type
      comment: "Type of task (e.g. Creative, Review, Production) — used to analyze throughput and effort by task category."
    - name: "priority"
      expr: priority
      comment: "Priority level of the task — used to ensure high-priority tasks are completed on schedule."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable the task contributes to — used to link task performance to output quality."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the task is billable — used to track billable vs. non-billable work at the task level."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Indicates whether the task represents a milestone — used to filter milestone-level schedule performance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the task — used to track quality gate throughput and approval bottlenecks."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the task was planned to start — used for delivery schedule trend analysis."
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of tasks. Baseline throughput metric for delivery team workload and capacity assessment."
    - name: "completed_task_count"
      expr: COUNT(CASE WHEN task_status = 'Completed' THEN 1 END)
      comment: "Number of completed tasks. Tracks delivery throughput — a key operational performance metric for project teams."
    - name: "task_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed. A primary delivery efficiency KPI — low rates signal execution bottlenecks or resource constraints."
    - name: "blocked_task_count"
      expr: COUNT(CASE WHEN task_status = 'Blocked' THEN 1 END)
      comment: "Number of currently blocked tasks. Blocked tasks directly impede delivery — a critical operational escalation metric."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across tasks. Used for capacity planning and estimation accuracy benchmarking."
    - name: "total_logged_hours"
      expr: SUM(CAST(logged_hours AS DOUBLE))
      comment: "Total hours actually logged against tasks. Compared against estimates to assess effort accuracy and team productivity."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average task completion percentage. Tracks in-flight progress across the task portfolio — used in weekly delivery reviews."
    - name: "hours_estimation_accuracy"
      expr: ROUND(100.0 * SUM(CAST(estimated_hours AS DOUBLE)) / NULLIF(SUM(CAST(logged_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of estimated to actual logged hours expressed as a percentage. Values near 100% indicate accurate estimation; significant deviation triggers estimation process improvement."
$$;