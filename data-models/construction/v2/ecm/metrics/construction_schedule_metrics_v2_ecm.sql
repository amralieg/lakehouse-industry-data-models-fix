-- Metric views for domain: schedule | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core schedule activity KPIs tracking completion, critical path exposure, and schedule performance across the construction project portfolio. Used by project controls and PMO to steer schedule health."
  source: "`vibe_construction_v1`.`schedule`.`activity`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier — primary grouping for all schedule KPIs."
    - name: "activity_status"
      expr: activity_status
      comment: "Current lifecycle status of the activity (Not Started, In Progress, Complete, etc.)."
    - name: "activity_type"
      expr: activity_type
      comment: "Classification of the activity (Task, Milestone, Summary, etc.) for portfolio filtering."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Boolean flag indicating whether the activity lies on the critical path — key filter for schedule risk analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start date for time-series trending of scheduled work."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of actual start date for comparing planned vs actual start distribution."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of scheduling constraint applied to the activity (ASAP, ALAP, MFO, etc.)."
    - name: "wbs_node_id"
      expr: wbs_node_id
      comment: "WBS node identifier for hierarchical schedule analysis."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of schedule activities. Baseline denominator for all schedule performance ratios."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Executives use this to gauge schedule risk concentration."
    - name: "completed_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END)
      comment: "Count of fully completed activities. Drives completion rate KPI and progress reporting."
    - name: "in_progress_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'In Progress' THEN 1 END)
      comment: "Count of activities currently in progress. Indicates active workload and resource demand."
    - name: "not_started_activity_count"
      expr: COUNT(CASE WHEN activity_status = 'Not Started' THEN 1 END)
      comment: "Count of activities not yet started. Highlights backlog and upcoming mobilization needs."
    - name: "activity_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities completed out of total. Core schedule progress KPI for steering meetings and board decks."
    - name: "critical_path_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND activity_status = 'Complete' THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical path activities completed. Directly predicts project delivery date risk."
    - name: "avg_percent_complete"
      expr: ROUND(AVG(CAST(percent_complete AS DOUBLE)), 2)
      comment: "Average percent complete across all activities. Weighted progress indicator for portfolio-level schedule health."
    - name: "avg_original_duration_days"
      expr: ROUND(AVG(CAST(original_duration_days AS DOUBLE)), 2)
      comment: "Average planned duration of activities in days. Baseline for duration variance analysis."
    - name: "avg_remaining_duration_days"
      expr: ROUND(AVG(CAST(remaining_duration_days AS DOUBLE)), 2)
      comment: "Average remaining duration across active activities. Drives forecast-to-complete calculations."
    - name: "total_remaining_duration_days"
      expr: SUM(CAST(remaining_duration_days AS DOUBLE))
      comment: "Total remaining work in activity-days across the schedule. Used to assess overall schedule exposure."
    - name: "overdue_activity_count"
      expr: COUNT(CASE WHEN activity_status != 'Complete' AND planned_finish_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of incomplete activities past their planned finish date. Critical schedule health indicator triggering recovery plan actions."
    - name: "overdue_critical_path_activity_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE AND activity_status != 'Complete' AND planned_finish_date < CURRENT_DATE() THEN 1 END)
      comment: "Overdue activities specifically on the critical path. Highest-priority schedule risk metric for executive escalation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_progress_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period-by-period schedule performance metrics including Earned Value indicators (SPI, SV), forecast accuracy, and critical path drift. Primary source for schedule performance index reporting to PMO and executives."
  source: "`vibe_construction_v1`.`schedule`.`progress_update`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level schedule performance grouping."
    - name: "reporting_date_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month bucket of the reporting date for time-series schedule performance trending."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of progress updates (Weekly, Bi-Weekly, Monthly) for cadence analysis."
    - name: "progress_update_status"
      expr: progress_update_status
      comment: "Status of the progress update record (Draft, Submitted, Approved) for data quality filtering."
    - name: "is_critical_path_changed"
      expr: is_critical_path_changed
      comment: "Flag indicating whether the critical path changed in this update period — key risk signal."
    - name: "activity_id"
      expr: activity_id
      comment: "Activity identifier for activity-level progress drill-down."
  measures:
    - name: "total_progress_updates"
      expr: COUNT(1)
      comment: "Total number of progress update records. Baseline for update cadence and coverage analysis."
    - name: "avg_spi"
      expr: ROUND(AVG(CAST(spi AS DOUBLE)), 4)
      comment: "Average Schedule Performance Index (BCWP/BCWS). SPI < 1.0 signals schedule slippage; used in every project controls steering meeting."
    - name: "avg_sv"
      expr: ROUND(AVG(CAST(sv AS DOUBLE)), 2)
      comment: "Average Schedule Variance (BCWP - BCWS) in currency units. Negative SV indicates behind-schedule condition requiring executive intervention."
    - name: "avg_sv_percent"
      expr: ROUND(AVG(CAST(sv_percent AS DOUBLE)), 2)
      comment: "Average Schedule Variance as a percentage. Normalizes SV across projects of different sizes for portfolio comparison."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value). Core EVM metric representing value of work actually accomplished."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value). Baseline against which earned value is measured."
    - name: "avg_percent_complete_duration"
      expr: ROUND(AVG(CAST(percent_complete_duration AS DOUBLE)), 2)
      comment: "Average duration-based percent complete across updated activities. Tracks physical progress against schedule."
    - name: "avg_percent_complete_units"
      expr: ROUND(AVG(CAST(percent_complete_units AS DOUBLE)), 2)
      comment: "Average units-based percent complete. Provides a resource-consumption view of schedule progress."
    - name: "total_remaining_duration"
      expr: SUM(CAST(remaining_duration AS DOUBLE))
      comment: "Total remaining duration across all updated activities. Drives time-to-complete forecasting."
    - name: "avg_total_float"
      expr: ROUND(AVG(CAST(total_float AS DOUBLE)), 2)
      comment: "Average total float across updated activities. Declining float signals increasing schedule risk and potential critical path expansion."
    - name: "critical_path_change_event_count"
      expr: COUNT(CASE WHEN is_critical_path_changed = TRUE THEN 1 END)
      comment: "Number of update periods where the critical path changed. Frequent changes indicate schedule instability requiring PMO escalation."
    - name: "behind_schedule_update_count"
      expr: COUNT(CASE WHEN spi < 1.0 THEN 1 END)
      comment: "Number of progress update records where SPI < 1.0 (behind schedule). Tracks frequency and persistence of schedule underperformance."
    - name: "schedule_recovery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN spi >= 1.0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of update periods where schedule was on or ahead of plan (SPI >= 1.0). Measures schedule recovery effectiveness over time."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule baseline governance metrics tracking baseline versions, approval status, and duration commitments. Used by project controls to manage baseline integrity and change control."
  source: "`vibe_construction_v1`.`schedule`.`schedule_baseline`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level baseline governance."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (Original, Revised, Recovery) for change control analysis."
    - name: "schedule_baseline_status"
      expr: schedule_baseline_status
      comment: "Approval status of the baseline (Draft, Approved, Superseded) for governance filtering."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating the currently active baseline. Ensures KPIs reference the correct control baseline."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of baseline approval for change frequency trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the baseline budget for multi-currency portfolio analysis."
  measures:
    - name: "total_baselines"
      expr: COUNT(1)
      comment: "Total number of schedule baselines. High counts indicate frequent re-baselining, a schedule governance risk signal."
    - name: "approved_baseline_count"
      expr: COUNT(CASE WHEN schedule_baseline_status = 'Approved' THEN 1 END)
      comment: "Number of approved baselines. Governance metric ensuring projects operate against formally approved schedules."
    - name: "current_baseline_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of projects with a current active baseline. Projects without a current baseline lack schedule control."
    - name: "avg_total_duration_days"
      expr: ROUND(AVG(CAST(total_duration_days AS DOUBLE)), 2)
      comment: "Average total project duration in days across baselines. Benchmark for project complexity and resource planning."
    - name: "total_bcws_amount"
      expr: SUM(CAST(bcws_amount AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled across all baselines. Represents total planned schedule value committed."
    - name: "avg_bcws_amount"
      expr: ROUND(AVG(CAST(bcws_amount AS DOUBLE)), 2)
      comment: "Average BCWS per baseline. Used to benchmark project scale and planned value commitments."
    - name: "rebaseline_frequency"
      expr: COUNT(CASE WHEN baseline_type != 'Original' THEN 1 END)
      comment: "Count of non-original baselines (revisions, recoveries). High frequency signals chronic schedule instability requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule milestone performance metrics tracking on-time delivery, LD exposure, and forecast accuracy for contractual and project milestones. Critical for client reporting and contract compliance."
  source: "`vibe_construction_v1`.`schedule`.`schedule_milestone`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level milestone performance."
    - name: "schedule_milestone_type"
      expr: schedule_milestone_type
      comment: "Type of milestone (Contractual, Internal, Payment, Handover) for category-specific performance analysis."
    - name: "schedule_milestone_status"
      expr: schedule_milestone_status
      comment: "Current status of the milestone (Pending, Achieved, Overdue, Forecasted) for pipeline visibility."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Whether the milestone is on the critical path — highest-priority milestones for executive tracking."
    - name: "ld_exposure_flag"
      expr: ld_exposure_flag
      comment: "Flag indicating the milestone carries Liquidated Damages exposure. Drives financial risk reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the milestone (Low, Medium, High, Critical) for risk-weighted milestone reporting."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month bucket of planned milestone date for delivery schedule trending."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of schedule milestones. Baseline for milestone completion rate calculations."
    - name: "achieved_milestone_count"
      expr: COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones successfully achieved. Core delivery performance indicator."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN schedule_milestone_status != 'Achieved' AND planned_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of milestones past their planned date without achievement. Triggers contract risk and LD exposure review."
    - name: "milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_milestone_status = 'Achieved' AND actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN schedule_milestone_status = 'Achieved' THEN 1 END), 0), 2)
      comment: "Percentage of achieved milestones delivered on or before planned date. Primary on-time delivery KPI for client and board reporting."
    - name: "ld_exposed_milestone_count"
      expr: COUNT(CASE WHEN ld_exposure_flag = TRUE AND schedule_milestone_status != 'Achieved' THEN 1 END)
      comment: "Number of outstanding milestones with active LD exposure. Directly quantifies financial penalty risk from schedule delays."
    - name: "total_ld_rate_exposure_per_day"
      expr: SUM(CASE WHEN ld_exposure_flag = TRUE AND schedule_milestone_status != 'Achieved' THEN ld_rate_per_day ELSE 0 END)
      comment: "Total daily LD rate exposure across all outstanding LD-bearing milestones. Quantifies maximum daily financial penalty accrual for CFO and legal review."
    - name: "critical_path_milestone_overdue_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE AND schedule_milestone_status != 'Achieved' AND planned_date < CURRENT_DATE() THEN 1 END)
      comment: "Overdue milestones on the critical path. Highest-severity schedule risk metric requiring immediate executive escalation."
    - name: "avg_ld_rate_per_day"
      expr: ROUND(AVG(CASE WHEN ld_exposure_flag = TRUE THEN ld_rate_per_day END), 2)
      comment: "Average daily LD rate across LD-bearing milestones. Benchmarks contractual penalty severity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_delay_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay event analytics quantifying schedule impact, EOT claim status, and cost exposure from delay events. Used by project controls, legal, and executives to manage schedule recovery and claim strategy."
  source: "`vibe_construction_v1`.`schedule`.`delay_event`"
  dimensions:
    - name: "delay_category"
      expr: delay_category
      comment: "Category of delay (Weather, Design, Procurement, Client, Contractor) for root-cause analysis and claim attribution."
    - name: "delay_event_status"
      expr: delay_event_status
      comment: "Current status of the delay event (Open, Under Review, Approved, Rejected) for pipeline management."
    - name: "event_type"
      expr: event_type
      comment: "Type of delay event (Force Majeure, Excusable, Compensable, etc.) for contractual classification."
    - name: "eot_claim_status"
      expr: eot_claim_status
      comment: "Status of the associated EOT claim for claim pipeline tracking."
    - name: "impact_on_critical_path"
      expr: impact_on_critical_path
      comment: "Whether the delay event impacts the critical path — highest-priority delays for schedule recovery."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the delay (Minor, Moderate, Major, Critical) for risk-weighted reporting."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of delay event start for time-series delay trending."
  measures:
    - name: "total_delay_events"
      expr: COUNT(1)
      comment: "Total number of delay events. Baseline for delay frequency and trend analysis."
    - name: "critical_path_delay_count"
      expr: COUNT(CASE WHEN impact_on_critical_path = TRUE THEN 1 END)
      comment: "Number of delay events impacting the critical path. Directly correlates with project completion date risk."
    - name: "total_delay_calendar_days"
      expr: SUM(CAST(delay_duration_calendar_days AS DOUBLE))
      comment: "Total calendar days of delay across all events. Aggregate schedule impact measure for EOT claim quantification."
    - name: "total_delay_working_days"
      expr: SUM(CAST(delay_duration_working_days AS DOUBLE))
      comment: "Total working days of delay. Used in contractual EOT calculations and schedule recovery planning."
    - name: "avg_delay_calendar_days"
      expr: ROUND(AVG(CAST(delay_duration_calendar_days AS DOUBLE)), 2)
      comment: "Average calendar days per delay event. Benchmarks typical delay magnitude for risk modeling."
    - name: "total_cost_impact"
      expr: SUM(CAST(impact_on_cost_amount AS DOUBLE))
      comment: "Total financial impact of delay events. Quantifies the cost consequence of schedule delays for CFO and contract management."
    - name: "avg_cost_impact_per_event"
      expr: ROUND(AVG(CAST(impact_on_cost_amount AS DOUBLE)), 2)
      comment: "Average cost impact per delay event. Used to prioritize delay mitigation investments."
    - name: "approved_delay_count"
      expr: COUNT(CASE WHEN delay_event_status = 'Approved' THEN 1 END)
      comment: "Number of approved delay events. Represents formally recognized schedule impacts with contractual implications."
    - name: "critical_path_delay_duration_days"
      expr: SUM(CASE WHEN impact_on_critical_path = TRUE THEN delay_duration_working_days ELSE 0 END)
      comment: "Total working days of delay on the critical path. Directly quantifies project completion date slippage from delay events."
    - name: "delay_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delay_event_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delay events approved. Low approval rates may indicate weak documentation or disputed claims."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Extension of Time (EOT) claim performance metrics tracking claim volumes, approval rates, and extension days granted. Critical for contract administration, legal strategy, and project completion date management."
  source: "`vibe_construction_v1`.`schedule`.`schedule_eot_claim`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level EOT claim analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (Submitted, Under Review, Approved, Rejected, Withdrawn) for pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (Excusable, Compensable, Force Majeure) for contractual classification."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the claimed delay is on the critical path — determines entitlement to time extension."
    - name: "claim_submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_date)
      comment: "Month of claim submission for claim volume trending."
  measures:
    - name: "total_eot_claims"
      expr: COUNT(1)
      comment: "Total number of EOT claims submitted. High volumes signal schedule instability and contract risk."
    - name: "approved_eot_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'Approved' THEN 1 END)
      comment: "Number of approved EOT claims. Represents formally granted time extensions with project completion date impact."
    - name: "rejected_eot_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected EOT claims. High rejection rates may indicate disputes requiring legal escalation."
    - name: "eot_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims approved. Key contract performance indicator for claim management effectiveness."
    - name: "critical_path_eot_claim_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of EOT claims on the critical path. These directly affect the project completion date and LD exposure."
    - name: "pending_eot_claim_count"
      expr: COUNT(CASE WHEN claim_status NOT IN ('Approved', 'Rejected', 'Withdrawn') THEN 1 END)
      comment: "Number of EOT claims pending resolution. Unresolved claims represent contingent schedule and financial risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule risk register metrics quantifying risk exposure, Monte Carlo probability outcomes, and mitigation coverage. Used by risk managers and PMO to prioritize schedule risk responses."
  source: "`vibe_construction_v1`.`schedule`.`schedule_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of schedule risk (Design, Procurement, Weather, Regulatory, etc.) for root-cause risk analysis."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (Open, Mitigated, Closed, Realized) for risk pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the risk (Critical, High, Medium, Low) for risk-weighted reporting."
    - name: "response_type"
      expr: response_type
      comment: "Risk response strategy (Mitigate, Accept, Transfer, Avoid) for response effectiveness analysis."
    - name: "owner_department"
      expr: owner_department
      comment: "Department responsible for the risk. Enables accountability tracking and departmental risk exposure reporting."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment for risk register evolution trending."
  measures:
    - name: "total_schedule_risks"
      expr: COUNT(1)
      comment: "Total number of schedule risks in the register. Baseline for risk density and coverage analysis."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open schedule risks. Unmitigated open risks represent active schedule threats requiring management attention."
    - name: "critical_high_risk_count"
      expr: COUNT(CASE WHEN priority IN ('Critical', 'High') THEN 1 END)
      comment: "Number of critical or high priority schedule risks. Executives focus on this subset for schedule protection decisions."
    - name: "avg_risk_score"
      expr: ROUND(AVG(CAST(score AS DOUBLE)), 4)
      comment: "Average risk score across all schedule risks. Tracks overall schedule risk exposure level over time."
    - name: "mitigated_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Mitigated' THEN 1 END)
      comment: "Number of risks with active mitigation in place. Measures risk management effectiveness."
    - name: "risk_mitigation_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_status = 'Mitigated' THEN 1 END) / NULLIF(COUNT(CASE WHEN risk_status IN ('Open', 'Mitigated') THEN 1 END), 0), 2)
      comment: "Percentage of active risks with mitigation plans in place. Low coverage signals inadequate risk response and schedule vulnerability."
    - name: "risks_with_mitigation_plan_count"
      expr: COUNT(CASE WHEN mitigation_plan IS NOT NULL AND mitigation_plan != '' THEN 1 END)
      comment: "Number of risks with documented mitigation plans. Governance metric ensuring all significant risks have response strategies."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_lookahead_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lookahead planning performance metrics tracking Percent Plan Complete (PPC), readiness rates, and constraint management. Core Last Planner System (LPS) KPIs for weekly work planning effectiveness."
  source: "`vibe_construction_v1`.`schedule`.`lookahead_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level lookahead performance."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the lookahead plan (Draft, Active, Closed) for plan lifecycle management."
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of constraint blocking planned activities (Material, Equipment, Labor, Design, Permit) for constraint resolution prioritization."
    - name: "plan_date_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month bucket of plan date for PPC trending over time."
    - name: "is_lps_enabled"
      expr: is_lps_enabled
      comment: "Whether Last Planner System is enabled for this plan. Enables LPS adoption rate tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the lookahead plan for risk-weighted planning analysis."
  measures:
    - name: "total_lookahead_plans"
      expr: COUNT(1)
      comment: "Total number of lookahead plans. Baseline for planning cadence and coverage analysis."
    - name: "avg_ppc_actual_percent"
      expr: ROUND(AVG(CAST(ppc_actual_percent AS DOUBLE)), 2)
      comment: "Average Percent Plan Complete (PPC) — the primary Last Planner System KPI. PPC < 80% triggers root cause analysis and planning process improvement."
    - name: "avg_ppc_target_percent"
      expr: ROUND(AVG(CAST(ppc_target_percent AS DOUBLE)), 2)
      comment: "Average PPC target percentage. Benchmarks actual PPC against planned targets for performance gap analysis."
    - name: "ppc_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppc_actual_percent >= ppc_target_percent THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans meeting or exceeding their PPC target. Measures planning reliability and commitment culture."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across lookahead plans. Tracks near-term cost commitment and cash flow requirements."
    - name: "avg_percent_plan_complete"
      expr: ROUND(AVG(CAST(percent_plan_complete AS DOUBLE)), 2)
      comment: "Average overall plan completion percentage. Tracks lookahead plan execution effectiveness."
    - name: "constrained_plan_count"
      expr: COUNT(CASE WHEN constraint_type IS NOT NULL AND constraint_type != '' THEN 1 END)
      comment: "Number of lookahead plans with active constraints. High constraint counts indicate readiness failures blocking planned work."
    - name: "fully_ready_plan_count"
      expr: COUNT(CASE WHEN crew_ready_flag = TRUE AND material_ready_flag = TRUE AND equipment_ready_flag = TRUE THEN 1 END)
      comment: "Number of plans where crew, material, and equipment are all confirmed ready. Measures true work readiness before commitment."
    - name: "readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN crew_ready_flag = TRUE AND material_ready_flag = TRUE AND equipment_ready_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookahead plans with full resource readiness confirmed. Low readiness rates predict low PPC and schedule slippage."
    - name: "weather_impacted_plan_count"
      expr: COUNT(CASE WHEN weather_impact_flag = TRUE THEN 1 END)
      comment: "Number of lookahead plans impacted by weather. Quantifies weather-related planning disruption for risk and contingency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_activity_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment cost and performance metrics tracking planned vs actual cost, quantity variances, and overtime exposure across schedule activities. Used by project controls and finance for cost-at-completion forecasting."
  source: "`vibe_construction_v1`.`schedule`.`activity_resource_assignment`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (Labor, Equipment, Material, Subcontract) for resource category cost analysis."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category for workforce cost breakdown and productivity analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (Active, Complete, Cancelled) for active resource tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the assignment for governance and cost commitment control."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the assigned activity is on the critical path — prioritizes resource allocation decisions."
    - name: "activity_id"
      expr: activity_id
      comment: "Activity identifier for activity-level resource cost drill-down."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of assignment start date for resource cost time-series analysis."
  measures:
    - name: "total_resource_assignments"
      expr: COUNT(1)
      comment: "Total number of resource assignments. Baseline for resource loading and assignment density analysis."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across all resource assignments. Represents the full resource cost budget for schedule activities."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across resource assignments. Core cost performance metric for project controls."
    - name: "total_remaining_cost"
      expr: SUM(CAST(remaining_cost AS DOUBLE))
      comment: "Total remaining cost to complete across all assignments. Drives Estimate-to-Complete (ETC) calculations."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned resource quantity across assignments. Baseline for productivity and quantity variance analysis."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual resource quantity consumed. Measures resource consumption against plan."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(planned_cost AS DOUBLE)), 2)
      comment: "Total cost variance (Actual - Planned) across resource assignments. Negative values indicate cost overrun requiring management intervention."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(planned_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 4)
      comment: "Cost Performance Index (Planned/Actual). CPI < 1.0 signals cost overrun; used in EAC forecasting and executive cost reviews."
    - name: "total_overtime_quantity"
      expr: SUM(CAST(overtime_quantity AS DOUBLE))
      comment: "Total overtime resource quantity across assignments. High overtime signals resource under-allocation or schedule compression risk."
    - name: "total_overtime_cost"
      expr: SUM(CAST(overtime_quantity AS DOUBLE) * CAST(overtime_rate AS DOUBLE))
      comment: "Total estimated overtime cost (overtime quantity × overtime rate). Quantifies premium labor cost from schedule pressure."
    - name: "quantity_variance"
      expr: ROUND(SUM(CAST(actual_quantity AS DOUBLE)) - SUM(CAST(planned_quantity AS DOUBLE)), 2)
      comment: "Total quantity variance (Actual - Planned). Positive variance indicates resource over-consumption, signaling productivity issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`schedule_wbs_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS node cost and schedule performance metrics providing hierarchical project control visibility. Used by project managers and finance to track budget performance at each WBS level."
  source: "`vibe_construction_v1`.`schedule`.`wbs_node`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level WBS performance analysis."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS node for drill-down analysis from summary to detail."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS node (Phase, Deliverable, Work Package, etc.) for structural analysis."
    - name: "wbs_node_status"
      expr: wbs_node_status
      comment: "Current status of the WBS node (Active, Complete, On Hold) for portfolio health filtering."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Whether the WBS node is on the critical path for priority cost control."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the WBS node for risk-weighted budget analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start for WBS schedule distribution analysis."
  measures:
    - name: "total_wbs_nodes"
      expr: COUNT(1)
      comment: "Total number of WBS nodes. Baseline for WBS structure complexity analysis."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across WBS nodes. Represents the full project cost budget broken down by WBS structure."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across WBS nodes. Tracks cost commitment against budget."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS nodes. Core cost performance metric for project controls."
    - name: "total_cost_variance"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(budgeted_cost AS DOUBLE)), 2)
      comment: "Total cost variance (Actual - Budget) across WBS nodes. Negative values indicate budget overrun requiring corrective action."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed across WBS nodes. Tracks cost burn rate against budget allocation."
    - name: "avg_percent_complete"
      expr: ROUND(AVG(CAST(percent_complete AS DOUBLE)), 2)
      comment: "Average percent complete across WBS nodes. Provides a weighted view of overall project physical progress."
    - name: "avg_actual_duration_days"
      expr: ROUND(AVG(CAST(actual_duration_days AS DOUBLE)), 2)
      comment: "Average actual duration of WBS nodes. Benchmarks execution speed against planned durations."
    - name: "avg_planned_duration_days"
      expr: ROUND(AVG(CAST(planned_duration_days AS DOUBLE)), 2)
      comment: "Average planned duration of WBS nodes. Baseline for duration performance comparison."
    - name: "change_order_impacted_node_count"
      expr: COUNT(CASE WHEN change_order_indicator = TRUE THEN 1 END)
      comment: "Number of WBS nodes impacted by change orders. High counts indicate scope instability affecting budget and schedule."
    - name: "overbudget_node_count"
      expr: COUNT(CASE WHEN actual_cost > budgeted_cost THEN 1 END)
      comment: "Number of WBS nodes where actual cost exceeds budget. Identifies cost overrun hotspots for targeted corrective action."
$$;