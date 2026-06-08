-- Metric views for domain: schedule | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core schedule activity performance metrics tracking progress, critical path exposure, and schedule health across all construction project activities."
  source: "`construction_ecm`.`schedule`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current execution status of the activity (e.g. Not Started, In Progress, Complete) used to segment performance reporting."
    - name: "activity_type"
      expr: activity_type
      comment: "Classification of the activity type (e.g. Construction, Procurement, Engineering) enabling type-level schedule analysis."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the activity lies on the project critical path, enabling focused monitoring of schedule-driving work."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint applied to the activity, useful for identifying constrained activities that may drive delays."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of the planned activity start date for time-series schedule analysis."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month bucket of the planned activity finish date for workload and completion forecasting."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of the actual activity start date for comparing planned vs actual start trends."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level schedule performance aggregation."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of schedule activities. Baseline volume metric used to size project scope and track activity population changes."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Executives use this to gauge schedule risk concentration and prioritise resource allocation."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all activities. Key progress indicator used in steering meetings to assess overall schedule advancement."
    - name: "completed_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END)
      comment: "Number of activities with a completed status. Tracks throughput and delivery velocity against the planned schedule."
    - name: "not_started_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Not Started' THEN 1 END)
      comment: "Number of activities not yet started. Highlights backlog and potential schedule slippage risk for leadership intervention."
    - name: "critical_path_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical path activities that are complete. A primary schedule health KPI used by project directors to assess on-time delivery risk."
    - name: "overall_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all activities that are complete. Headline schedule progress metric for executive dashboards and client reporting."
    - name: "activities_with_constraint_count"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type <> '' THEN 1 END)
      comment: "Number of activities carrying a scheduling constraint. High constraint counts signal schedule rigidity and elevated delay risk."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule milestone performance metrics tracking on-time delivery, liquidated damages exposure, and critical milestone health across construction projects."
  source: "`construction_ecm`.`schedule`.`schedule_milestone`"
  dimensions:
    - name: "schedule_milestone_status"
      expr: schedule_milestone_status
      comment: "Current status of the milestone (e.g. Achieved, At Risk, Missed) for milestone health segmentation."
    - name: "schedule_milestone_type"
      expr: schedule_milestone_type
      comment: "Classification of the milestone type (e.g. Contractual, Internal, Regulatory) enabling type-level performance analysis."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the milestone is on the critical path, focusing executive attention on schedule-driving deliverables."
    - name: "ld_exposure_flag"
      expr: ld_exposure_flag
      comment: "Flags milestones with liquidated damages exposure, enabling financial risk monitoring at the milestone level."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the milestone (e.g. High, Medium, Low) for risk-tiered milestone reporting."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month bucket of the planned milestone date for time-series milestone delivery analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project enabling project-level milestone performance aggregation."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of schedule milestones. Baseline count used to track contractual and programme commitment volume."
    - name: "achieved_milestone_count"
      expr: COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones successfully achieved. Core delivery KPI used in client and board reporting."
    - name: "missed_milestone_count"
      expr: COUNT(CASE WHEN schedule_milestone_status = 'Missed' THEN 1 END)
      comment: "Number of milestones missed. Directly triggers executive intervention and contractual penalty review."
    - name: "milestone_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved on time. Primary on-time delivery KPI for project steering committees and client dashboards."
    - name: "ld_exposed_milestone_count"
      expr: COUNT(CASE WHEN ld_exposure_flag = TRUE THEN 1 END)
      comment: "Number of milestones with liquidated damages exposure. Directly informs financial risk management and contract administration decisions."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Sum of daily LD rates across all exposed milestones. Quantifies the maximum daily financial penalty exposure for executive risk reporting."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of milestones on the critical path. Used by programme directors to focus schedule recovery efforts on highest-impact deliverables."
    - name: "critical_path_milestone_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND schedule_milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical path milestones achieved. The single most important schedule delivery KPI for project executives and clients."
    - name: "high_risk_milestone_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of milestones classified as high risk. Drives proactive mitigation planning and resource prioritisation decisions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned value and schedule performance index metrics derived from progress updates, enabling data-driven schedule health assessment and forecast management."
  source: "`construction_ecm`.`schedule`.`progress_update`"
  dimensions:
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update record (e.g. Approved, Draft, Submitted) for data quality and reporting cycle management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of the reporting cycle (e.g. Weekly, Monthly) enabling comparison across reporting cadences."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Flags updates where the critical path changed, highlighting periods of significant schedule re-sequencing."
    - name: "path_drift_indicator"
      expr: path_drift_indicator
      comment: "Indicator of schedule path drift direction (e.g. Ahead, Behind, On Track) for trend analysis."
    - name: "reporting_date_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of the reporting date for time-series earned value and SPI trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project enabling project-level progress performance aggregation."
  measures:
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI = BCWP/BCWS) across reporting periods. SPI < 1.0 signals schedule slippage and triggers recovery planning at executive level."
    - name: "avg_schedule_variance_pct"
      expr: AVG(CAST(sv_percent AS DOUBLE))
      comment: "Average schedule variance percentage across updates. Quantifies the magnitude of schedule deviation for steering committee reporting."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (earned value). Core earned value metric used to assess actual schedule progress in cost terms."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (planned value). Baseline planned value metric used alongside BCWP to compute schedule variance."
    - name: "total_schedule_variance"
      expr: SUM(CAST(sv AS DOUBLE))
      comment: "Total schedule variance (BCWP minus BCWS) in cost terms. Negative values indicate the project is behind schedule and drive executive intervention."
    - name: "avg_percent_complete_duration"
      expr: AVG(CAST(percent_complete_duration AS DOUBLE))
      comment: "Average duration-based percent complete across all progress updates. Tracks overall schedule advancement independent of cost weighting."
    - name: "avg_total_float"
      expr: AVG(CAST(total_float AS DOUBLE))
      comment: "Average total float remaining across progress updates. Declining float signals increasing schedule risk and prompts proactive management action."
    - name: "critical_path_change_count"
      expr: COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END)
      comment: "Number of reporting periods where the critical path changed. Frequent changes indicate schedule instability and elevated delivery risk."
    - name: "updates_behind_schedule_count"
      expr: COUNT(CASE WHEN spi < 1.0 THEN 1 END)
      comment: "Number of progress update periods where SPI was below 1.0 (behind schedule). Tracks schedule slippage frequency for trend and risk reporting."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event analytics measuring the frequency, cost impact, and critical path exposure of schedule delays across construction projects."
  source: "`construction_ecm`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of the delay event (e.g. Weather, Design, Procurement, Labour) enabling root-cause analysis and trend reporting."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event (e.g. Open, Resolved, Under Review) for active delay management tracking."
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of the Extension of Time (EOT) claim associated with the delay, enabling contractual entitlement monitoring."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Flags delay events that impact the critical path, focusing executive attention on schedule-threatening delays."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the delay event (e.g. Critical, Major, Minor) for risk-tiered delay reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the delay event for prioritisation of mitigation and recovery actions."
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event (e.g. Excusable, Compensable, Non-Excusable) for contractual classification and entitlement analysis."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of the delay event start for time-series delay trend analysis."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events recorded. Baseline volume metric for delay frequency trending and programme risk assessment."
    - name: "critical_path_delay_count"
      expr: COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END)
      comment: "Number of delay events impacting the critical path. Directly informs schedule recovery decisions and EOT claim management."
    - name: "total_delay_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total financial cost impact of all delay events. Key financial risk metric used by project directors and finance leadership to quantify delay exposure."
    - name: "avg_delay_cost_impact"
      expr: AVG(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Average cost impact per delay event. Benchmarks the typical financial severity of delays for risk calibration and contingency planning."
    - name: "open_delay_event_count"
      expr: COUNT(CASE WHEN delay_event_status = 'Open' THEN 1 END)
      comment: "Number of currently open delay events. Active delay backlog metric used in weekly project control meetings to drive resolution."
    - name: "eot_claim_pending_count"
      expr: COUNT(CASE WHEN eot_claim_status = 'Pending' THEN 1 END)
      comment: "Number of delay events with a pending EOT claim. Tracks contractual entitlement pipeline and informs legal and commercial strategy."
    - name: "critical_path_delay_cost_impact"
      expr: SUM(CASE WHEN impact_on_critical_path = TRUE THEN CAST(impact_on_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of delays that affect the critical path. Isolates the highest-consequence delay costs for executive financial risk reporting."
    - name: "critical_path_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events that impact the critical path. High rates signal systemic schedule risk requiring programme-level intervention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment cost performance metrics tracking planned vs actual cost, resource utilisation efficiency, and cost variance across schedule activities."
  source: "`construction_ecm`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (e.g. Labour, Equipment, Material, Subcontract) enabling resource-category cost analysis."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the assigned resource (e.g. Foreman, Operator, Engineer) for workforce and skill-level cost reporting."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (e.g. Active, Completed, Cancelled) for assignment lifecycle tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the resource assignment, enabling governance and cost authorisation monitoring."
    - name: "labor_category"
      expr: labor_category
      comment: "Labour category classification for workforce cost segmentation and productivity analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags assignments on the critical path, enabling focused cost monitoring of schedule-driving resources."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of the assignment start date for time-series resource cost trend analysis."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code associated with the resource assignment for work-breakdown-level cost reporting."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all resource assignments. Baseline budget metric used to track resource cost commitments against project budget."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all resource assignments. Core cost performance metric for project financial control and forecasting."
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete across all resource assignments. Drives estimate-at-completion forecasting and cash flow planning."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(planned_cost AS DOUBLE))
      comment: "Total cost variance (actual minus planned) across all assignments. Positive values indicate cost overrun and trigger executive financial review."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per resource assignment. Benchmarks resource pricing for procurement and contract negotiation decisions."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned resource quantity across all assignments. Used to validate resource loading against schedule demand."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual resource quantity consumed. Compared against planned quantity to assess resource productivity and utilisation efficiency."
    - name: "quantity_variance"
      expr: SUM(CAST(actual_quantity AS DOUBLE) - CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity variance (actual minus planned) across assignments. Identifies over- or under-consumption of resources for productivity management."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "Cost Performance Index (planned cost / actual cost) across resource assignments. CPI < 1.0 signals cost overrun and drives corrective action by project controls."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_quantity AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total overtime cost (overtime quantity × overtime rate) across assignments. Tracks premium labour spend for workforce cost control and scheduling optimisation."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last Planner System (LPS) lookahead plan metrics measuring Percent Plan Complete, readiness rates, and short-interval schedule reliability for construction projects."
  source: "`construction_ecm`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the lookahead plan (e.g. Active, Closed, Draft) for plan lifecycle management."
    - name: "readiness_status"
      expr: readiness_status
      comment: "Overall readiness status of the lookahead plan (e.g. Ready, Not Ready) for constraint removal tracking."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint blocking plan execution (e.g. Material, Permit, Design) for root-cause constraint analysis."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Flags lookahead plans on the critical path for prioritised constraint removal and resource allocation."
    - name: "is_lps_enabled"
      expr: is_lps_enabled
      comment: "Indicates whether the Last Planner System is enabled for this plan, enabling LPS adoption tracking across the programme."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the lookahead plan for risk-tiered short-interval planning analysis."
    - name: "plan_date_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month bucket of the plan date for time-series PPC trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project enabling project-level LPS performance aggregation."
  measures:
    - name: "avg_ppc_actual_percent"
      expr: AVG(CAST(ppc_actual_percent AS DOUBLE))
      comment: "Average actual Percent Plan Complete (PPC) across lookahead periods. The primary LPS reliability metric used by project managers to assess short-interval planning effectiveness."
    - name: "avg_ppc_target_percent"
      expr: AVG(CAST(ppc_target_percent AS DOUBLE))
      comment: "Average target PPC across lookahead periods. Benchmarks actual PPC performance against planned targets for continuous improvement tracking."
    - name: "avg_percent_plan_complete"
      expr: AVG(CAST(percent_plan_complete AS DOUBLE))
      comment: "Average overall percent plan complete across all lookahead plans. Tracks short-interval schedule delivery reliability for operational steering."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost committed in lookahead plans. Tracks near-term cost commitments for cash flow and budget management."
    - name: "ready_plan_count"
      expr: COUNT(CASE WHEN readiness_status = 'Ready' THEN 1 END)
      comment: "Number of lookahead plans with all constraints removed and ready for execution. Measures constraint removal effectiveness and workfront readiness."
    - name: "plan_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN readiness_status = 'Ready' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans that are fully ready for execution. High readiness rates correlate with improved PPC and schedule reliability."
    - name: "constrained_plan_count"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type <> '' THEN 1 END)
      comment: "Number of lookahead plans with active constraints. Tracks constraint backlog volume for proactive removal and schedule protection."
    - name: "weather_impacted_plan_count"
      expr: COUNT(CASE WHEN weather_impact_flag = TRUE THEN 1 END)
      comment: "Number of lookahead plans impacted by weather. Informs seasonal risk planning and schedule contingency allocation decisions."
    - name: "ppc_gap"
      expr: AVG(CAST(ppc_target_percent AS DOUBLE) - CAST(ppc_actual_percent AS DOUBLE))
      comment: "Average gap between target and actual PPC. Negative gap indicates plans are outperforming targets; positive gap signals reliability shortfall requiring management attention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_baseline_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline vs actual schedule performance metrics measuring cost variance, schedule adherence, and critical path baseline integrity across project activities."
  source: "`construction_ecm`.`schedule`.`activity`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_wbs_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Breakdown Structure (WBS) node cost and schedule performance metrics enabling hierarchical project control and earned value management at the WBS level."
  source: "`construction_ecm`.`schedule`.`wbs_node`"
  filter: deleted_flag = FALSE
  dimensions:
    - name: "wbs_node_status"
      expr: wbs_node_status
      comment: "Current status of the WBS node (e.g. Active, Closed, On Hold) for WBS lifecycle management."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type classification of the WBS node (e.g. Summary, Work Package, Control Account) for hierarchical cost reporting."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS node enabling drill-down cost and schedule analysis from programme to work package level."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Flags WBS nodes on the critical path for focused schedule and cost monitoring."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the WBS node for risk-tiered project control reporting."
    - name: "change_order_indicator"
      expr: change_order_indicator
      comment: "Indicates WBS nodes affected by change orders, enabling change impact analysis on cost and schedule."
    - name: "earned_value_method"
      expr: earned_value_method
      comment: "Earned value measurement method applied to the WBS node (e.g. 0/100, 50/50, Percent Complete) for EVM methodology reporting."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project enabling project-level WBS cost aggregation."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across all WBS nodes. Establishes the project budget baseline for cost performance monitoring and variance reporting."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all WBS nodes. Tracks current cost plan against the approved budget for financial control."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all WBS nodes. Core cost performance metric for project financial control and forecasting."
    - name: "total_cost_variance"
      expr: SUM(CAST(budgeted_cost AS DOUBLE) - CAST(actual_cost AS DOUBLE))
      comment: "Total cost variance (budgeted minus actual) across WBS nodes. Negative values indicate cost overrun and drive executive financial intervention."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across WBS nodes. Tracks overall project progress at the WBS level for schedule performance reporting."
    - name: "budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed (actual cost / budgeted cost). Key financial health metric used by project directors to assess cost burn rate against budget."
    - name: "change_order_affected_node_count"
      expr: COUNT(CASE WHEN change_order_indicator = TRUE THEN 1 END)
      comment: "Number of WBS nodes affected by change orders. Tracks scope change proliferation and its impact on project cost and schedule baseline."
    - name: "critical_path_node_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of WBS nodes on the critical path. Used to assess the proportion of project scope driving schedule completion."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`schedule_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule baseline governance metrics tracking baseline version history, revision frequency, and planned value commitments across construction project baselines."
  source: "`construction_ecm`.`schedule`.`schedule_baseline`"
  dimensions:
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of schedule baseline (e.g. Original, Revised, Approved) for baseline version classification and governance reporting."
    - name: "schedule_baseline_status"
      expr: schedule_baseline_status
      comment: "Current status of the schedule baseline (e.g. Approved, Superseded, Draft) for baseline lifecycle management."
    - name: "is_current"
      expr: is_current
      comment: "Flags the currently active baseline, enabling filtering to the approved current baseline for performance reporting."
    - name: "source_system"
      expr: source_system
      comment: "Source scheduling system (e.g. Primavera P6, MS Project) for data lineage and system integration reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the baseline cost values for multi-currency project portfolio reporting."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month bucket of the baseline approval date for baseline revision frequency trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project enabling project-level baseline governance aggregation."
  measures:
    - name: "total_baselines"
      expr: COUNT(1)
      comment: "Total number of schedule baselines. Tracks baseline revision frequency — high counts signal scope instability and governance concerns."
    - name: "current_baseline_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of baselines marked as current. Should be 1 per project; values greater than 1 indicate a data governance issue requiring resolution."
    - name: "total_bcws_amount"
      expr: SUM(CAST(bcws_amount AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (planned value) across all baselines. Tracks the total planned value commitment established at baseline approval."
    - name: "avg_bcws_amount"
      expr: AVG(CAST(bcws_amount AS DOUBLE))
      comment: "Average planned value per baseline. Benchmarks the typical scale of baseline cost commitments for portfolio-level planning."
    - name: "revised_baseline_count"
      expr: COUNT(CASE WHEN baseline_type <> 'Original' THEN 1 END)
      comment: "Number of non-original (revised) baselines. High revision counts indicate scope instability and may signal contract or delivery management issues."
    - name: "distinct_project_baseline_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct construction projects with at least one schedule baseline. Tracks baseline governance coverage across the project portfolio."
$$;