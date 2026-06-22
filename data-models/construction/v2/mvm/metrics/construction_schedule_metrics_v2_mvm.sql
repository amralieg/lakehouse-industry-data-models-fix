-- Metric views for domain: schedule | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core schedule activity KPIs tracking progress, duration performance, and critical path exposure across construction project activities. Used by project controls and scheduling teams to steer schedule health."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g. Not Started, In Progress, Complete) — primary filter for schedule health dashboards."
    - name: "activity_type"
      expr: activity_type
      comment: "Classification of the activity type (e.g. Construction, Procurement, Engineering) — used to segment schedule performance by work category."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean flag indicating whether the activity lies on the critical path — essential for prioritising schedule recovery actions."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint applied to the activity — used to identify constrained activities that may drive schedule risk."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of the planned start date — enables time-series trending of planned workload."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of the actual start date — used to compare planned vs actual start timing trends."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('MONTH', planned_finish_date)
      comment: "Month bucket of the planned finish date — used for workload forecasting and schedule density analysis."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of schedule activities. Baseline volume metric used to contextualise all other activity-level KPIs."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Executives use this to gauge schedule risk concentration and resource prioritisation needs."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all activities. Key schedule progress indicator used in steering meetings and project status reports."
    - name: "total_original_duration_days"
      expr: SUM(CAST(original_duration_days AS DOUBLE))
      comment: "Sum of original planned durations across activities. Used to measure total planned schedule scope and compare against remaining work."
    - name: "total_remaining_duration_days"
      expr: SUM(CAST(remaining_duration_days AS DOUBLE))
      comment: "Sum of remaining duration days across all activities. Directly informs schedule-to-complete forecasting and resource loading."
    - name: "avg_remaining_duration_days"
      expr: AVG(CAST(remaining_duration_days AS DOUBLE))
      comment: "Average remaining duration per activity. Used to identify activities with disproportionately large remaining work relative to plan."
    - name: "schedule_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities with a Complete status. Core schedule performance KPI used in executive dashboards and client reporting."
    - name: "critical_path_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical path activities that are complete. Directly tied to on-time delivery risk — a drop triggers immediate schedule recovery action."
    - name: "duration_performance_index"
      expr: ROUND(SUM(CAST(original_duration_days AS DOUBLE) - CAST(remaining_duration_days AS DOUBLE)) / NULLIF(SUM(CAST(original_duration_days AS DOUBLE)), 0), 4)
      comment: "Ratio of work consumed (original minus remaining) to original planned duration. Analogous to a schedule efficiency index — values below 1.0 indicate schedule underperformance."
    - name: "not_started_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Not Started' THEN 1 END)
      comment: "Number of activities not yet started. Used to assess schedule mobilisation progress and identify stalled work fronts."
    - name: "in_progress_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'In Progress' THEN 1 END)
      comment: "Number of activities currently in progress. Used to measure active workload and identify over-loading or under-loading of resources."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment cost and quantity KPIs for schedule activities. Enables earned value analysis, cost performance tracking, and resource utilisation decisions at the activity level."
  source: "`vibe_construction_v1`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (e.g. Labour, Equipment, Material, Subcontract) — primary segmentation for cost and quantity analysis."
    - name: "labor_category"
      expr: labor_category
      comment: "Labour category of the assigned resource — used to analyse workforce cost distribution across schedule activities."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the assigned resource — enables workforce planning and role-based cost analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment — used to filter active vs completed vs cancelled assignments."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the resource assignment — used to track unapproved cost commitments and governance compliance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the assignment — used to flag non-compliant resource deployments for risk and audit reporting."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean flag indicating whether the assignment is on the critical path — used to prioritise resource allocation decisions."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the resource quantity — required for quantity-based performance analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of the assignment start date — enables time-series cost and quantity trending."
    - name: "finish_month"
      expr: DATE_TRUNC('MONTH', finish_date)
      comment: "Month bucket of the assignment finish date — used for cost accrual and resource release forecasting."
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code of the assignment — enables cost and quantity roll-up by WBS hierarchy."
    - name: "safety_risk_level"
      expr: safety_risk_level
      comment: "Safety risk level associated with the resource assignment — used to correlate high-risk assignments with cost and schedule performance."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all resource assignments. Baseline budget measure used in cost performance and earned value reporting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across resource assignments. Core cost tracking KPI used in project financial reviews and client billing."
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete across assignments. Used to forecast cost-at-completion and identify budget overrun risk."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of planned cost to actual cost (CPI). A CPI below 1.0 signals cost overrun — a critical executive KPI for project financial health."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) - SUM(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Difference between planned and actual cost. Positive values indicate under-spend; negative values indicate cost overrun requiring management action."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned resource quantity across assignments. Used to validate resource loading against schedule demand."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual resource quantity consumed. Compared against planned quantity to assess resource productivity and schedule adherence."
    - name: "quantity_performance_index"
      expr: ROUND(SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to planned quantity consumed. Values above 1.0 indicate over-consumption relative to plan — triggers resource reallocation decisions."
    - name: "total_overtime_cost"
      expr: ROUND(SUM(CAST(overtime_quantity AS DOUBLE) * CAST(overtime_rate AS DOUBLE)), 2)
      comment: "Total overtime cost (overtime quantity × overtime rate) across assignments. Used to monitor premium labour spend and workforce efficiency."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per resource assignment. Used to benchmark resource pricing and identify above-market rate anomalies."
    - name: "critical_path_planned_cost"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN CAST(planned_cost AS DOUBLE) ELSE 0 END)
      comment: "Total planned cost for critical path assignments. Enables focused cost monitoring on activities that directly drive project completion date."
    - name: "remaining_cost_pct_of_planned"
      expr: ROUND(100.0 * SUM(CAST(remaining_cost AS DOUBLE)) / NULLIF(SUM(CAST(planned_cost AS DOUBLE)), 0), 2)
      comment: "Remaining cost as a percentage of planned cost. Indicates how much budget is yet to be spent — used in cost-to-complete forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule progress and earned value KPIs derived from periodic progress updates. Provides SPI, schedule variance, and forecast completion insights used in executive steering and client reporting."
  source: "`vibe_construction_v1`.`schedule`.`progress_update`"
  dimensions:
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update record — used to filter approved vs draft updates for reporting."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of the reporting period (e.g. Weekly, Monthly) — used to segment performance trends by reporting cadence."
    - name: "reporting_status"
      expr: reporting_status
      comment: "Status of the reporting submission — used to track reporting compliance and identify overdue updates."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Boolean flag indicating whether the critical path changed in this update period — a key risk signal for project controls."
    - name: "path_drift_indicator"
      expr: path_drift_indicator
      comment: "Indicator of critical path drift direction — used to classify updates as improving, stable, or deteriorating."
    - name: "update_source"
      expr: update_source
      comment: "Source system or method of the progress update — used to assess data quality and update reliability."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month bucket of the reporting period start — enables time-series trending of schedule performance metrics."
    - name: "reporting_date_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of the reporting date — primary time dimension for schedule performance dashboards."
  measures:
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI = BCWP/BCWS) across progress updates. SPI below 1.0 indicates schedule underperformance — a primary executive KPI for on-time delivery risk."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (earned value). Core earned value metric used to measure actual schedule progress in cost terms."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (planned value). Baseline planned progress measure used in earned value analysis."
    - name: "total_schedule_variance"
      expr: SUM(CAST(sv AS DOUBLE))
      comment: "Total Schedule Variance (BCWP minus BCWS) across updates. Negative values indicate schedule slippage — directly triggers recovery planning."
    - name: "avg_schedule_variance_pct"
      expr: AVG(CAST(sv_percent AS DOUBLE))
      comment: "Average schedule variance as a percentage of planned value. Normalised KPI enabling cross-project schedule performance comparison."
    - name: "avg_percent_complete_duration"
      expr: AVG(CAST(percent_complete_duration AS DOUBLE))
      comment: "Average duration-based percent complete across progress updates. Used to track overall schedule progress against the baseline programme."
    - name: "avg_percent_complete_units"
      expr: AVG(CAST(percent_complete_units AS DOUBLE))
      comment: "Average units-based percent complete across progress updates. Provides a quantity-driven view of schedule progress complementing duration-based measures."
    - name: "total_remaining_duration"
      expr: SUM(CAST(remaining_duration AS DOUBLE))
      comment: "Total remaining schedule duration across all progress updates. Used to forecast time-to-complete and assess schedule recovery feasibility."
    - name: "avg_total_float"
      expr: AVG(CAST(total_float AS DOUBLE))
      comment: "Average total float across progress updates. Declining float signals increasing schedule risk — a leading indicator used in project controls steering."
    - name: "critical_path_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of progress updates where the critical path changed. High rates indicate schedule instability — a key risk metric for executive oversight."
    - name: "earned_value_ratio"
      expr: ROUND(SUM(CAST(bcwp AS DOUBLE)) / NULLIF(SUM(CAST(bcws AS DOUBLE)), 0), 4)
      comment: "Ratio of total earned value (BCWP) to planned value (BCWS). Equivalent to aggregate SPI — used to assess overall schedule efficiency across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event KPIs tracking the frequency, duration, cost impact, and EOT claim status of schedule delays. Used by project controls, legal, and executive teams to manage delay risk and contractual exposure."
  source: "`vibe_construction_v1`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of the delay event (e.g. Weather, Design, Procurement, Client) — primary dimension for root cause analysis and responsibility attribution."
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event — used to classify delays for contractual and insurance reporting."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event (e.g. Open, Closed, Under Review) — used to track resolution progress."
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of the Extension of Time (EOT) claim associated with the delay — critical for contractual entitlement tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the delay event — used to prioritise management attention and escalation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the delay event — used to assess residual schedule and cost risk exposure."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Boolean flag indicating whether the delay impacts the critical path — the most important filter for schedule recovery prioritisation."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of the delay event start — enables time-series trending of delay frequency and impact."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month bucket of the delay approval date — used to track EOT approval cycle times."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events recorded. Baseline volume metric for delay frequency analysis and trend monitoring."
    - name: "total_delay_duration_calendar_days"
      expr: SUM(CAST(delay_duration_calendar_days AS DOUBLE))
      comment: "Total calendar days of delay across all events. Primary schedule impact metric used in EOT claims and project completion forecasting."
    - name: "total_delay_duration_working_days"
      expr: SUM(CAST(delay_duration_working_days AS DOUBLE))
      comment: "Total working days of delay across all events. Used in contractual EOT calculations where working day calendars apply."
    - name: "avg_delay_duration_calendar_days"
      expr: AVG(CAST(delay_duration_calendar_days AS DOUBLE))
      comment: "Average calendar days per delay event. Used to benchmark delay severity and identify categories with disproportionate schedule impact."
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total cost impact of all delay events. Directly informs project financial exposure reporting and insurance/legal claim quantification."
    - name: "avg_cost_impact_per_event"
      expr: AVG(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Average cost impact per delay event. Used to prioritise delay resolution by financial exposure and benchmark against industry norms."
    - name: "critical_path_delay_count"
      expr: COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END)
      comment: "Number of delay events impacting the critical path. Directly tied to project completion date risk — a primary executive escalation trigger."
    - name: "critical_path_delay_duration_days"
      expr: SUM(CASE WHEN impact_on_critical_path = TRUE THEN CAST(delay_duration_calendar_days AS DOUBLE) ELSE 0 END)
      comment: "Total calendar days of delay on the critical path. The most consequential schedule risk metric — directly drives EOT entitlement and LD exposure."
    - name: "eot_pending_event_count"
      expr: COUNT(CASE WHEN eot_claim_status = 'Pending' THEN 1 END)
      comment: "Number of delay events with a pending EOT claim. Used to track unresolved contractual entitlements and legal exposure."
    - name: "delay_cost_per_calendar_day"
      expr: ROUND(SUM(CAST(impact_on_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(delay_duration_calendar_days AS DOUBLE)), 0), 2)
      comment: "Average cost impact per calendar day of delay. Used to quantify the financial cost of schedule slippage and prioritise mitigation investment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule milestone KPIs tracking on-time delivery, variance, and liquidated damages exposure. Used by project directors and clients to assess contractual milestone performance."
  source: "`vibe_construction_v1`.`schedule`.`schedule_milestone`"
  dimensions:
    - name: "schedule_milestone_status"
      expr: schedule_milestone_status
      comment: "Current status of the milestone (e.g. Achieved, At Risk, Delayed) — primary filter for milestone performance dashboards."
    - name: "schedule_milestone_type"
      expr: schedule_milestone_type
      comment: "Type of milestone (e.g. Contractual, Internal, Regulatory) — used to segment milestone performance by contractual significance."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean flag indicating whether the milestone is on the critical path — used to prioritise milestone recovery actions."
    - name: "ld_exposure_flag"
      expr: ld_exposure_flag
      comment: "Boolean flag indicating whether the milestone carries liquidated damages exposure — critical for financial risk reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the milestone — used to prioritise management attention and resource allocation."
    - name: "location"
      expr: location
      comment: "Physical location associated with the milestone — used to analyse schedule performance by site or zone."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month bucket of the planned milestone date — enables time-series analysis of milestone density and schedule loading."
    - name: "forecast_date_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month bucket of the forecast milestone date — used to track forecast slippage trends over time."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of schedule milestones. Baseline volume metric for milestone portfolio analysis."
    - name: "achieved_milestone_count"
      expr: COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones with Achieved status. Core on-time delivery KPI used in client reporting and executive dashboards."
    - name: "milestone_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved. Primary contractual performance KPI — directly tied to client satisfaction and LD exposure."
    - name: "ld_exposed_milestone_count"
      expr: COUNT(CASE WHEN ld_exposure_flag = TRUE THEN 1 END)
      comment: "Number of milestones with liquidated damages exposure. Used to quantify contractual financial risk and prioritise schedule recovery."
    - name: "total_ld_daily_rate_exposure"
      expr: SUM(CASE WHEN ld_exposure_flag = TRUE THEN CAST(ld_rate_per_day AS DOUBLE) ELSE 0 END)
      comment: "Total daily LD rate across all LD-exposed milestones. Represents the maximum daily financial exposure from schedule delays — a critical executive risk metric."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of milestones on the critical path. Used to assess the concentration of schedule risk on the critical path."
    - name: "critical_path_ld_daily_rate"
      expr: SUM(CASE WHEN critical_path_flag = TRUE AND ld_exposure_flag = TRUE THEN CAST(ld_rate_per_day AS DOUBLE) ELSE 0 END)
      comment: "Total daily LD rate for critical path milestones with LD exposure. The highest-priority financial risk metric — any critical path delay directly triggers this exposure."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CASE WHEN ld_exposure_flag = TRUE THEN CAST(ld_rate_per_day AS DOUBLE) END)
      comment: "Average daily LD rate across LD-exposed milestones. Used to benchmark contractual penalty severity and prioritise milestone recovery investment."
    - name: "at_risk_milestone_count"
      expr: COUNT(CASE WHEN schedule_milestone_status = 'At Risk' THEN 1 END)
      comment: "Number of milestones currently flagged as At Risk. Leading indicator of future milestone failures — used to trigger proactive schedule intervention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline vs current schedule performance KPIs at the activity level. Enables variance analysis between the approved baseline and current schedule — essential for change management and schedule control."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_activity_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay impact KPIs at the activity level, tracking EOT claims, float consumption, and critical path impacts. Used by project controls and legal teams to quantify and defend schedule delay claims."
  source: "`vibe_construction_v1`.`schedule`.`delay_activity_impact`"
  dimensions:
    - name: "impact_status"
      expr: impact_status
      comment: "Current status of the delay impact assessment — used to filter active vs resolved impacts."
    - name: "impact_severity_level"
      expr: impact_severity_level
      comment: "Severity level of the delay impact — used to prioritise management attention and recovery resource allocation."
    - name: "analysis_method"
      expr: analysis_method
      comment: "Method used to analyse the delay impact (e.g. Time Impact Analysis, As-Planned vs As-Built) — used to assess claim methodology robustness."
    - name: "is_critical_path_impact"
      expr: is_critical_path_impact
      comment: "Boolean flag indicating whether the delay impact affects the critical path — the primary filter for schedule recovery prioritisation."
    - name: "impact_start_month"
      expr: DATE_TRUNC('MONTH', impact_start_date)
      comment: "Month bucket of the impact start date — enables time-series analysis of delay impact concentration."
    - name: "impact_end_month"
      expr: DATE_TRUNC('MONTH', impact_end_date)
      comment: "Month bucket of the impact end date — used to track when delay impacts are resolved."
  measures:
    - name: "total_impact_duration_days"
      expr: SUM(CAST(impact_duration_days AS DOUBLE))
      comment: "Total duration of delay impacts across all affected activities. Primary schedule impact quantification metric used in EOT claims."
    - name: "total_eot_days_claimed"
      expr: SUM(CAST(eot_days_claimed AS DOUBLE))
      comment: "Total Extension of Time days claimed across all delay impacts. Directly represents contractual schedule entitlement — a critical legal and financial KPI."
    - name: "total_float_consumed_days"
      expr: SUM(CAST(float_consumed_days AS DOUBLE))
      comment: "Total float consumed by delay impacts. Indicates how much schedule buffer has been eroded — a leading indicator of critical path risk."
    - name: "avg_impact_duration_days"
      expr: AVG(CAST(impact_duration_days AS DOUBLE))
      comment: "Average delay impact duration per affected activity. Used to benchmark impact severity and identify outlier activities driving disproportionate delay."
    - name: "critical_path_impact_count"
      expr: COUNT(CASE WHEN is_critical_path_impact = TRUE THEN 1 END)
      comment: "Number of delay impacts on the critical path. Directly tied to project completion date risk — triggers immediate executive escalation."
    - name: "critical_path_eot_days_claimed"
      expr: SUM(CASE WHEN is_critical_path_impact = TRUE THEN CAST(eot_days_claimed AS DOUBLE) ELSE 0 END)
      comment: "Total EOT days claimed for critical path impacts. The most consequential contractual entitlement metric — directly determines project completion date extension."
    - name: "eot_to_impact_ratio"
      expr: ROUND(SUM(CAST(eot_days_claimed AS DOUBLE)) / NULLIF(SUM(CAST(impact_duration_days AS DOUBLE)), 0), 4)
      comment: "Ratio of EOT days claimed to total impact duration. Values below 1.0 indicate float absorption is reducing EOT entitlement — used in claim strategy decisions."
    - name: "float_consumption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(float_consumed_days AS DOUBLE)) / NULLIF(SUM(CAST(impact_duration_days AS DOUBLE)), 0), 2)
      comment: "Float consumed as a percentage of total impact duration. High rates indicate delays are being absorbed by float rather than extending the programme — a key schedule resilience metric."
$$;