-- Metric views for domain: site | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks concrete pour execution quality, volume throughput, and QC compliance across construction projects. Used by site engineers and project managers to monitor structural work progress and quality hold rates."
  source: "`vibe_construction_v1`.`site`.`concrete_pour`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the pour belongs to — primary grouping for project-level analysis."
    - name: "pour_date"
      expr: pour_date
      comment: "Calendar date of the pour — enables daily and weekly trend analysis."
    - name: "pour_month"
      expr: DATE_TRUNC('MONTH', pour_date)
      comment: "Month of pour — supports monthly volume and quality trend reporting."
    - name: "pour_type"
      expr: pour_type
      comment: "Type of concrete pour (e.g. slab, column, footing) — drives structural element analysis."
    - name: "structure_element"
      expr: structure_element
      comment: "Structural element being poured — enables element-level quality and volume tracking."
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the pour (e.g. completed, on-hold) — used to filter active vs. closed pours."
    - name: "qc_hold_status"
      expr: qc_hold_status
      comment: "QC hold classification — identifies pours under quality review or rejection."
    - name: "mix_design_code"
      expr: mix_design_code
      comment: "Concrete mix design code — enables mix-level quality performance comparison."
    - name: "placement_method"
      expr: placement_method
      comment: "Method used to place concrete (e.g. pump, crane bucket) — informs method efficiency analysis."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element the pour is charged to — supports cost and schedule integration."
  measures:
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Core throughput KPI for structural progress tracking and schedule performance."
    - name: "avg_volume_per_pour_m3"
      expr: AVG(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Average volume per pour event. Indicates pour efficiency and crew/equipment sizing adequacy."
    - name: "total_pour_count"
      expr: COUNT(1)
      comment: "Total number of pour events. Baseline activity count for productivity benchmarking."
    - name: "slump_non_compliant_count"
      expr: SUM(CASE WHEN slump_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Number of pours where slump test failed specification. Directly signals concrete quality risk and potential rework cost."
    - name: "slump_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN slump_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours passing slump test. Key quality KPI — low rates trigger mix design or supplier review."
    - name: "avg_slump_test_result_mm"
      expr: AVG(CAST(slump_test_result_mm AS DOUBLE))
      comment: "Average measured slump in mm. Tracks concrete workability trend against specification limits."
    - name: "avg_specified_strength_mpa"
      expr: AVG(CAST(specified_strength_mpa AS DOUBLE))
      comment: "Average specified compressive strength across pours. Supports structural compliance reporting."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at placement. Temperatures outside range risk strength gain — monitored for QC compliance."
    - name: "qc_hold_pour_count"
      expr: COUNT(DISTINCT CASE WHEN qc_hold_status IS NOT NULL AND qc_hold_status != '' THEN concrete_pour_id END)
      comment: "Number of pours placed on QC hold. Elevated counts signal systemic quality issues requiring management intervention."
    - name: "avg_relative_humidity_pct"
      expr: AVG(CAST(relative_humidity_pct AS DOUBLE))
      comment: "Average ambient relative humidity during pours. Extreme humidity affects curing — used in weather-impact analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures crew productivity, overtime exposure, and deployment efficiency across work fronts. Used by site managers and project controls to optimise labour allocation and identify productivity gaps."
  source: "`vibe_construction_v1`.`site`.`crew_deployment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for project-level labour performance."
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of crew deployment — enables daily and weekly labour trend analysis."
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_date)
      comment: "Month of deployment — supports monthly labour cost and productivity reporting."
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g. concrete, steel, civil) — enables trade-level productivity comparison."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (day/night/weekend) — used to analyse shift-based productivity differentials."
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Flags subcontractor vs. direct labour crews — supports make-vs-buy and cost analysis."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current deployment status — filters active, completed, or cancelled deployments."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the crew is deployed to — enables front-level productivity analysis."
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Flags weather-impacted deployments — quantifies weather-related productivity loss."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labour hours deployed. Core workforce utilisation KPI for cost and schedule control."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labour hours. Baseline for schedule adherence and resource planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred. High overtime signals resource shortfalls or schedule pressure — drives cost overrun risk."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total actual hours. Elevated rates trigger labour cost review and resource reallocation decisions."
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(planned_hours AS DOUBLE))
      comment: "Total variance between actual and planned hours. Negative = under-deployment; positive = over-run. Key schedule and cost signal."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity achieved by deployed crews. Measures physical output against plan."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity. Denominator for production achievement rate."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual vs. planned production as a percentage. Core productivity KPI — below 80% triggers site management intervention."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average crew productivity rate (output per hour). Benchmarks crew performance and informs future resource planning."
    - name: "weather_impacted_deployment_count"
      expr: SUM(CASE WHEN is_weather_impacted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deployments impacted by weather. Supports EOT claim substantiation and risk reporting."
    - name: "ppe_non_compliance_count"
      expr: SUM(CASE WHEN ppe_compliance = FALSE THEN 1 ELSE 0 END)
      comment: "Number of deployments with PPE non-compliance. Safety KPI — triggers HSE audit and corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates daily site activity, safety events, and production volumes from site daily logs. Used by project managers and site superintendents to monitor site health, delay trends, and safety performance."
  source: "`vibe_construction_v1`.`site`.`daily_log`"
  dimensions:
    - name: "daily_construction_project_id"
      expr: daily_construction_project_id
      comment: "Construction project the daily log belongs to — primary project-level grouping."
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily log — enables daily trend and calendar analysis."
    - name: "log_month"
      expr: DATE_TRUNC('MONTH', log_date)
      comment: "Month of log — supports monthly site performance trend reporting."
    - name: "log_status"
      expr: log_status
      comment: "Status of the daily log (draft/approved/submitted) — filters for approved records in reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day/night) — enables shift-level performance comparison."
    - name: "overall_site_status"
      expr: overall_site_status
      comment: "Overall site status for the day — used to track site operational health trends."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded — supports weather-impact analysis on productivity."
    - name: "has_delay_event"
      expr: has_delay_event
      comment: "Flags days with delay events — used to quantify delay frequency and patterns."
  measures:
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured as recorded in daily logs. Tracks structural progress at project level."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved. Key civil works progress KPI for bulk earthworks projects."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across all daily logs. Directly informs EOT claims and schedule recovery planning."
    - name: "avg_daily_delay_hrs"
      expr: AVG(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Average delay hours per day. Elevated averages signal systemic site issues requiring management escalation."
    - name: "delay_day_count"
      expr: SUM(CASE WHEN has_delay_event = TRUE THEN 1 ELSE 0 END)
      comment: "Number of days with at least one delay event. Frequency metric for delay risk assessment."
    - name: "lti_day_count"
      expr: SUM(CASE WHEN lti_occurred_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of days with a Lost Time Injury. Critical safety KPI — any LTI triggers executive review and regulatory reporting."
    - name: "ncr_raised_day_count"
      expr: SUM(CASE WHEN ncr_raised_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of days with an NCR raised. Tracks quality non-conformance frequency — high rates signal systemic quality issues."
    - name: "tbm_conducted_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tbm_conducted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of days where a toolbox meeting was conducted. Safety compliance KPI — below target triggers HSE intervention."
    - name: "avg_precipitation_mm"
      expr: AVG(CAST(precipitation_mm AS DOUBLE))
      comment: "Average daily precipitation in mm. Used to correlate weather conditions with productivity and delay events."
    - name: "cost_impact_day_count"
      expr: SUM(CASE WHEN cost_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of days with a cost impact event. Drives cost risk reporting and change order substantiation."
    - name: "eot_impact_day_count"
      expr: SUM(CASE WHEN eot_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of days with an EOT-impacting event. Supports extension of time claim preparation and schedule risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_earthwork_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks earthwork cut, fill, and net movement volumes against contracted quantities. Used by project controls and site engineers to monitor bulk earthworks progress, survey accuracy, and variation order exposure."
  source: "`vibe_construction_v1`.`site`.`earthwork_volume`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for project-level earthworks tracking."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of survey measurement — enables temporal progress tracking."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement — supports monthly earthworks progress reporting."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (approved/pending/rejected) — filters certified volumes for payment."
    - name: "material_classification"
      expr: material_classification
      comment: "Material type (e.g. rock, common fill) — drives unit rate and cost analysis."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey method used (e.g. drone, total station) — supports accuracy and methodology analysis."
    - name: "work_area_code"
      expr: work_area_code
      comment: "Work area code — enables zone-level earthworks progress tracking."
    - name: "is_variation_order"
      expr: is_variation_order
      comment: "Flags variation order volumes — separates base contract from variation scope for cost control."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element — links earthwork volumes to schedule and cost structure."
  measures:
    - name: "total_cut_volume_m3"
      expr: SUM(CAST(cut_volume_m3 AS DOUBLE))
      comment: "Total cut volume in cubic metres. Core earthworks progress KPI for excavation-heavy projects."
    - name: "total_fill_volume_m3"
      expr: SUM(CAST(fill_volume_m3 AS DOUBLE))
      comment: "Total fill volume in cubic metres. Tracks embankment and backfill progress against design quantities."
    - name: "total_net_movement_m3"
      expr: SUM(CAST(net_movement_m3 AS DOUBLE))
      comment: "Total net earthwork movement (cut minus fill). Indicates mass balance and haul efficiency."
    - name: "total_contracted_volume_m3"
      expr: SUM(CAST(contracted_volume_m3 AS DOUBLE))
      comment: "Total contracted earthwork volume. Denominator for progress achievement rate."
    - name: "cumulative_cut_volume_m3"
      expr: SUM(CAST(cumulative_cut_volume_m3 AS DOUBLE))
      comment: "Cumulative cut volume to date. Tracks overall excavation progress against total scope."
    - name: "cumulative_fill_volume_m3"
      expr: SUM(CAST(cumulative_fill_volume_m3 AS DOUBLE))
      comment: "Cumulative fill volume to date. Tracks overall fill progress against total scope."
    - name: "total_spoil_volume_m3"
      expr: SUM(CAST(spoil_volume_m3 AS DOUBLE))
      comment: "Total spoil volume requiring off-site disposal. Drives disposal cost and logistics planning."
    - name: "avg_compaction_factor"
      expr: AVG(CAST(compaction_factor AS DOUBLE))
      comment: "Average compaction factor across measurements. Deviations from design factor signal fill quality issues."
    - name: "avg_swell_factor"
      expr: AVG(CAST(swell_factor AS DOUBLE))
      comment: "Average swell factor. Used to reconcile bank measure vs. loose measure volumes for payment certification."
    - name: "variation_volume_m3"
      expr: SUM(CASE WHEN is_variation_order = TRUE THEN net_movement_m3 ELSE 0 END)
      comment: "Net earthwork volume attributable to variation orders. Quantifies scope growth for commercial management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures equipment utilisation, idle time, fuel consumption, and breakdown frequency on site. Used by plant managers and project controls to optimise fleet deployment and reduce equipment cost."
  source: "`vibe_construction_v1`.`site`.`equipment_deployment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for project-level equipment performance."
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of equipment deployment — enables daily and weekly utilisation trend analysis."
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_date)
      comment: "Month of deployment — supports monthly fleet cost and utilisation reporting."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment (e.g. excavator, crane, dozer) — enables fleet category analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Owned vs. rented equipment — supports make-vs-buy and rental cost analysis."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Deployment status — filters active, completed, or breakdown deployments."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type — enables shift-level utilisation comparison."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the equipment is deployed to — enables front-level fleet analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (diesel/electric/hybrid) — supports sustainability and fuel cost reporting."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours. Core equipment utilisation KPI for fleet performance management."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours. High idle time signals over-deployment or poor scheduling — drives cost reduction actions."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours. Standby costs are often contractually recoverable — tracked for commercial management."
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total hours lost to equipment breakdown. Directly impacts schedule and triggers maintenance strategy review."
    - name: "equipment_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(operating_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Operating hours as a percentage of total available hours. Primary fleet efficiency KPI — below 70% triggers fleet review."
    - name: "breakdown_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(breakdown_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(breakdown_hours AS DOUBLE)), 0), 2)
      comment: "Breakdown hours as a percentage of total scheduled hours. Elevated rates signal maintenance failures and schedule risk."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in litres. Drives fuel cost forecasting and carbon emission calculations."
    - name: "avg_fuel_consumption_per_operating_hour"
      expr: ROUND(SUM(CAST(fuel_consumption_liters AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)), 0), 2)
      comment: "Average fuel consumption per operating hour. Benchmarks equipment efficiency and identifies abnormal consumption."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output from deployed equipment. Measures equipment contribution to physical progress."
    - name: "breakdown_event_count"
      expr: SUM(CASE WHEN breakdown_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breakdown events. Frequency metric for maintenance reliability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks field-measured physical progress against planned quantities and schedule. Used by project controls and site engineers to report earned value, identify critical path slippage, and drive schedule recovery."
  source: "`vibe_construction_v1`.`site`.`field_progress`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for project-level progress reporting."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of field measurement — enables temporal progress trend analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement — supports monthly progress reporting cycles."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity being measured — enables work-type level progress analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the progress record — filters certified vs. pending progress for payment."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags critical path activities — focuses management attention on schedule-critical work."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flags milestone activities — enables milestone achievement tracking."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type (weekly/monthly) — supports different reporting cadence analysis."
    - name: "work_front"
      expr: work_front
      comment: "Work front identifier — enables front-level progress comparison."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed to date. Core physical progress KPI for scope completion tracking."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Quantity installed in the current period. Measures period productivity against plan."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity. Denominator for progress achievement rate calculation."
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average reported percent complete across activities. High-level project progress indicator for executive dashboards."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (earned value). Core EVM metric — drives schedule and cost performance analysis."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion across measured activities. Denominator for overall project percent complete."
    - name: "progress_delta_sum"
      expr: SUM(CAST(progress_delta AS DOUBLE))
      comment: "Sum of progress deltas (period-over-period change). Identifies acceleration or deceleration in work execution."
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average progress delta per activity. Benchmarks period productivity and flags underperforming work fronts."
    - name: "critical_path_avg_pct_complete"
      expr: AVG(CASE WHEN is_critical_path = TRUE THEN reported_percent_complete ELSE NULL END)
      comment: "Average percent complete for critical path activities only. Most important schedule health indicator for project delivery."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours consumed in field progress activities. Supports resource utilisation and cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures daily production output, labour efficiency, and cost performance at the work front level. Used by site managers and project controls to track productivity rates and identify underperforming activities."
  source: "`vibe_construction_v1`.`site`.`production_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for project-level production analysis."
    - name: "entry_date"
      expr: entry_date
      comment: "Date of production entry — enables daily and weekly production trend analysis."
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of entry — supports monthly production reporting cycles."
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the production entry (approved/pending/rejected) — filters certified production for payment."
    - name: "production_type"
      expr: production_type
      comment: "Type of production work — enables work-type level productivity benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type — enables shift-level productivity comparison."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front — enables front-level production performance analysis."
    - name: "is_rework"
      expr: is_rework
      comment: "Flags rework entries — quantifies rework cost and quality impact."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Finance cost code — enables cost-code level production and cost analysis."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed. Core production throughput KPI for physical progress tracking."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity. Denominator for production achievement rate."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 2)
      comment: "Actual vs. budgeted production as a percentage. Primary productivity KPI — below 85% triggers site management review."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours consumed. Core input metric for labour productivity and cost analysis."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours consumed. Supports equipment cost allocation and utilisation analysis."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate (output per hour). Benchmarks crew and equipment efficiency against budgeted rates."
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate. Baseline for production rate variance analysis."
    - name: "production_rate_variance"
      expr: AVG(CAST(production_rate AS DOUBLE) - CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average variance between actual and budgeted production rate. Negative variance signals productivity underperformance."
    - name: "rework_entry_count"
      expr: SUM(CASE WHEN is_rework = TRUE THEN 1 ELSE 0 END)
      comment: "Number of rework production entries. Elevated counts signal quality failures driving cost and schedule impact."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across production entries. Supports progress reporting and earned value calculation."
    - name: "total_cumulative_quantity"
      expr: SUM(CAST(cumulative_quantity AS DOUBLE))
      comment: "Total cumulative quantity installed to date. Tracks overall scope completion for payment certification."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates shift-level production, safety, and delay performance. Used by site managers and project directors to monitor shift productivity, safety incidents, and operational efficiency across construction projects."
  source: "`vibe_construction_v1`.`site`.`shift_report`"
  dimensions:
    - name: "shift_construction_project_id"
      expr: shift_construction_project_id
      comment: "Construction project — primary grouping for project-level shift performance."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — enables daily and weekly shift performance trend analysis."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of shift — supports monthly shift performance reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day/night/weekend) — enables shift-type performance comparison."
    - name: "report_status"
      expr: report_status
      comment: "Status of the shift report — filters approved reports for performance analysis."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front — enables front-level shift performance analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during shift — supports weather-impact analysis on productivity."
  measures:
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output across shifts. Core throughput KPI for shift performance management."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity. Denominator for shift production achievement rate."
    - name: "shift_production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_quantity AS DOUBLE)), 0), 2)
      comment: "Actual vs. planned production per shift as a percentage. Primary shift productivity KPI for operational steering."
    - name: "total_labour_hours"
      expr: SUM(CAST(total_labour_hours AS DOUBLE))
      comment: "Total labour hours worked across shifts. Core workforce utilisation metric for cost control."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours across shifts. Drives EOT claim substantiation and schedule recovery planning."
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilisation percentage per shift. Identifies under-utilised fleet and drives redeployment decisions."
    - name: "lti_shift_count"
      expr: SUM(CASE WHEN lti_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shifts with a Lost Time Injury. Critical safety KPI — any LTI triggers executive review and regulatory notification."
    - name: "ncr_raised_shift_count"
      expr: SUM(CASE WHEN ncr_raised_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shifts with an NCR raised. Quality non-conformance frequency metric for management review."
    - name: "tbm_conducted_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tbm_conducted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts where a toolbox meeting was conducted. Safety compliance KPI — below 100% triggers HSE corrective action."
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured per shift. Tracks structural progress contribution by shift."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved per shift. Tracks civil works progress contribution by shift."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks work front progress, production performance, and resource deployment status. Used by site managers and project directors to monitor active work fronts, identify critical path delays, and optimise resource allocation."
  source: "`vibe_construction_v1`.`site`.`work_front`"
  dimensions:
    - name: "work_construction_project_id"
      expr: work_construction_project_id
      comment: "Construction project — primary grouping for project-level work front analysis."
    - name: "front_type"
      expr: front_type
      comment: "Type of work front (e.g. civil, structural, MEP) — enables work-type level performance comparison."
    - name: "front_status"
      expr: front_status
      comment: "Current status of the work front — filters active, completed, or on-hold fronts."
    - name: "current_phase"
      expr: current_phase
      comment: "Current construction phase — enables phase-level progress analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags critical path work fronts — focuses management attention on schedule-critical areas."
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Flags subcontracted work fronts — supports subcontractor performance analysis."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level of the work front — enables risk-stratified safety management."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification — enables spatial analysis of work front performance."
  measures:
    - name: "total_work_front_count"
      expr: COUNT(1)
      comment: "Total number of work fronts. Baseline metric for site complexity and resource demand assessment."
    - name: "active_work_front_count"
      expr: COUNT(DISTINCT CASE WHEN front_status = 'Active' THEN work_front_id END)
      comment: "Number of currently active work fronts. Drives resource allocation and site coordination decisions."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across work fronts. High-level site progress indicator for executive reporting."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity across work fronts. Measures overall site output against plan."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity. Denominator for site-wide production achievement rate."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual vs. planned production across all work fronts. Primary site productivity KPI for project steering."
    - name: "critical_path_front_count"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN 1 ELSE 0 END)
      comment: "Number of critical path work fronts. Tracks schedule-critical scope concentration for risk management."
    - name: "critical_path_avg_pct_complete"
      expr: AVG(CASE WHEN is_critical_path = TRUE THEN percent_complete ELSE NULL END)
      comment: "Average percent complete for critical path work fronts. Most important schedule health indicator for project delivery."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area covered by work fronts in square metres. Supports site coverage and resource density analysis."
    - name: "high_risk_front_count"
      expr: COUNT(DISTINCT CASE WHEN hse_risk_level = 'High' THEN work_front_id END)
      comment: "Number of high HSE risk work fronts. Safety risk concentration metric — drives targeted HSE resource deployment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks craft worker assignments to work fronts, measuring allocation efficiency, hours performance, and productivity. Used by site managers and workforce planners to optimise labour deployment and identify productivity gaps."
  source: "`vibe_construction_v1`.`site`.`work_front_assignment`"
  dimensions:
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the worker is assigned to — primary grouping for front-level workforce analysis."
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date of assignment — enables temporal workforce deployment trend analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of assignment — supports monthly workforce planning and cost reporting."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the assignment (active/completed/cancelled) — filters current vs. historical assignments."
    - name: "role"
      expr: role
      comment: "Role of the assigned worker — enables role-level workforce analysis."
    - name: "shift"
      expr: shift
      comment: "Shift the worker is assigned to — enables shift-level workforce analysis."
    - name: "is_supervisor"
      expr: is_supervisor
      comment: "Flags supervisory assignments — tracks supervisor-to-worker ratios."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active assignments — filters for real-time workforce headcount."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked by assigned craft workers. Core labour input metric for cost and productivity analysis."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours for assignments. Denominator for hours achievement rate."
    - name: "hours_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Actual vs. planned hours as a percentage. Measures workforce deployment adherence to plan."
    - name: "total_assigned_quantity"
      expr: SUM(CAST(assigned_quantity AS DOUBLE))
      comment: "Total quantity assigned to craft workers. Tracks scope allocation across the workforce."
    - name: "total_completed_quantity"
      expr: SUM(CAST(completed_quantity AS DOUBLE))
      comment: "Total quantity completed by assigned workers. Measures physical output against assignment scope."
    - name: "quantity_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(completed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(assigned_quantity AS DOUBLE)), 0), 2)
      comment: "Completed vs. assigned quantity as a percentage. Individual and front-level productivity completion KPI."
    - name: "avg_allocation_pct"
      expr: AVG(CAST(allocation_pct AS DOUBLE))
      comment: "Average allocation percentage across assignments. Low averages signal under-utilised workforce capacity."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate of assigned workers. Benchmarks individual and crew performance against standards."
    - name: "active_assignment_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active assignments. Real-time workforce headcount metric for site management."
    - name: "supervisor_assignment_count"
      expr: SUM(CASE WHEN is_supervisor = TRUE THEN 1 ELSE 0 END)
      comment: "Number of supervisory assignments. Used to calculate supervisor-to-worker ratios for safety compliance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site mobilisation cost performance, schedule adherence, and readiness milestones. Used by project directors and commercial managers to monitor mobilisation efficiency and cost-to-budget performance."
  source: "`vibe_construction_v1`.`site`.`site_mobilization`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project — primary grouping for project-level mobilisation analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilisation status — tracks progress through mobilisation stages."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilisation (initial/remobilisation/demobilisation) — enables type-level cost and schedule analysis."
    - name: "actual_mobilization_date"
      expr: actual_mobilization_date
      comment: "Actual mobilisation date — enables schedule variance analysis."
    - name: "mobilization_month"
      expr: DATE_TRUNC('MONTH', actual_mobilization_date)
      comment: "Month of mobilisation — supports monthly mobilisation activity reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of mobilisation costs — enables multi-currency cost analysis."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Flags whether HSE plan was approved — tracks safety readiness compliance."
    - name: "environmental_permit_obtained"
      expr: environmental_permit_obtained
      comment: "Flags whether environmental permit was obtained — tracks regulatory compliance readiness."
  measures:
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual mobilisation cost. Core cost performance KPI for mobilisation budget management."
    - name: "total_cost_budget"
      expr: SUM(CAST(cost_budget AS DOUBLE))
      comment: "Total budgeted mobilisation cost. Denominator for cost performance ratio."
    - name: "mobilization_cost_variance"
      expr: SUM(CAST(cost_actual AS DOUBLE) - CAST(cost_budget AS DOUBLE))
      comment: "Total cost variance (actual minus budget). Positive variance signals cost overrun requiring management action."
    - name: "mobilization_cost_performance_ratio"
      expr: ROUND(SUM(CAST(cost_budget AS DOUBLE)) / NULLIF(SUM(CAST(cost_actual AS DOUBLE)), 0), 4)
      comment: "Budget-to-actual cost ratio. Values below 1.0 indicate cost overrun — drives commercial management decisions."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area mobilised in square metres. Supports resource density and logistics planning analysis."
    - name: "hse_plan_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hse_plan_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with approved HSE plans. Safety compliance KPI — below 100% is a regulatory risk."
    - name: "environmental_permit_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN environmental_permit_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with environmental permits obtained. Regulatory compliance KPI — gaps trigger legal risk escalation."
    - name: "site_office_readiness_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN site_office_established = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with site office established. Operational readiness KPI for project commencement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks material delivery performance, acceptance rates, and supply chain reliability. Used by procurement managers and site engineers to monitor delivery compliance, rejection rates, and material availability risk."
  source: "`vibe_construction_v1`.`site`.`material_delivery`"
  dimensions:
    - name: "material_construction_project_id"
      expr: material_construction_project_id
      comment: "Construction project — primary grouping for project-level material delivery analysis."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of delivery — enables daily and weekly delivery trend analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of delivery — supports monthly supply chain performance reporting."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status (accepted/rejected/partial) — filters for quality and compliance analysis."
    - name: "material_category"
      expr: material_category
      comment: "Material category — enables category-level supply chain performance analysis."
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Flags hazardous material deliveries — supports HSE compliance and handling risk management."
    - name: "temperature_sensitive"
      expr: temperature_sensitive
      comment: "Flags temperature-sensitive materials — tracks cold chain compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of delivery value — enables multi-currency procurement analysis."
  measures:
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered. Core procurement spend KPI for cost control and cash flow management."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of materials delivered. Tracks supply chain throughput against project demand."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity accepted on delivery. Denominator for acceptance rate calculation."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected on delivery. Elevated rejections signal supplier quality issues and rework risk."
    - name: "delivery_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_accepted AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Accepted quantity as a percentage of delivered quantity. Primary supplier quality KPI — below 95% triggers vendor review."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries arriving on or before expected date. Supply chain reliability KPI — low rates signal material availability risk."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across deliveries. Tracks material price trends and benchmarks against contract rates."
    - name: "hazardous_delivery_count"
      expr: SUM(CASE WHEN hazardous_material = TRUE THEN 1 ELSE 0 END)
      comment: "Number of hazardous material deliveries. Safety compliance metric — drives MSDS verification and handling protocol checks."
    - name: "msds_non_compliance_count"
      expr: SUM(CASE WHEN hazardous_material = TRUE AND msds_verified = FALSE THEN 1 ELSE 0 END)
      comment: "Number of hazardous deliveries without verified MSDS. Critical safety compliance gap — triggers immediate corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site permit status, expiry risk, and compliance coverage. Used by HSE managers and project directors to ensure regulatory permit compliance and avoid work stoppages due to expired or missing permits."
  source: "`vibe_construction_v1`.`site`.`site_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of site permit — enables permit-type level compliance analysis."
    - name: "permit_category"
      expr: permit_category
      comment: "Permit category — supports category-level compliance tracking."
    - name: "site_permit_status"
      expr: site_permit_status
      comment: "Current permit status (active/expired/pending) — primary filter for compliance monitoring."
    - name: "is_environmental"
      expr: is_environmental
      comment: "Flags environmental permits — enables environmental compliance tracking."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flags safety-critical permits — prioritises monitoring of high-risk permit compliance."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit — enables authority-level compliance analysis."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front the permit covers — enables front-level permit compliance analysis."
    - name: "application_date"
      expr: application_date
      comment: "Date permit was applied for — enables permit lead time analysis."
  measures:
    - name: "total_permit_count"
      expr: COUNT(1)
      comment: "Total number of site permits. Baseline metric for permit portfolio management."
    - name: "active_permit_count"
      expr: COUNT(DISTINCT CASE WHEN site_permit_status = 'Active' THEN site_permit_id END)
      comment: "Number of currently active permits. Tracks live permit coverage for ongoing site activities."
    - name: "expired_permit_count"
      expr: COUNT(DISTINCT CASE WHEN site_permit_status = 'Expired' THEN site_permit_id END)
      comment: "Number of expired permits. Expired permits on active work fronts represent regulatory non-compliance risk."
    - name: "safety_critical_permit_count"
      expr: SUM(CASE WHEN is_safety_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Number of safety-critical permits. Tracks high-risk permit coverage — gaps trigger immediate work stoppage."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid. Tracks regulatory compliance cost for project budget management."
    - name: "extension_requested_count"
      expr: SUM(CASE WHEN extension_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of permits with extension requests. Elevated counts signal permit management issues and schedule risk."
    - name: "expiry_notice_sent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN expiration_notice_sent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits with expiry notices sent. Compliance process KPI — gaps risk unnoticed permit lapses."
$$;