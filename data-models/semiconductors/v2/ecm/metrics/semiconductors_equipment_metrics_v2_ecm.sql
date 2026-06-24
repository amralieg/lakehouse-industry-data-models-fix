-- Metric views for domain: equipment | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) metrics for fab tools — tracks availability, performance, quality rates and throughput to drive equipment productivity decisions."
  source: "`vibe_semiconductors_v1`.`equipment`.`oee_record`"
  dimensions:
    - name: "record_date"
      expr: record_date
      comment: "Calendar date of the OEE measurement period for time-series trending."
    - name: "shift_date"
      expr: shift_date
      comment: "Shift date for intra-day OEE analysis by production shift."
    - name: "shift_name"
      expr: shift_name
      comment: "Production shift name (e.g. Day, Night) for shift-level OEE comparison."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (planned, unplanned, engineering) for root-cause analysis."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Specific reason code for downtime to identify recurring failure modes."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Granularity of the OEE measurement (hourly, daily, weekly) for drill-down analysis."
    - name: "oee_calculation_method"
      expr: oee_calculation_method
      comment: "Method used to calculate OEE for comparability across sites."
    - name: "record_status"
      expr: record_status
      comment: "Status of the OEE record (confirmed, provisional) for data quality filtering."
  measures:
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average OEE percentage across tools and periods — primary equipment productivity KPI used in executive steering reviews."
    - name: "avg_availability_percent"
      expr: AVG(CAST(availability_percent AS DOUBLE))
      comment: "Average equipment availability rate — measures uptime as a fraction of scheduled production time; drives maintenance investment decisions."
    - name: "avg_performance_percent"
      expr: AVG(CAST(performance_percent AS DOUBLE))
      comment: "Average equipment performance rate — measures actual throughput vs. theoretical maximum; identifies speed-loss opportunities."
    - name: "avg_quality_percent"
      expr: AVG(CAST(quality_percent AS DOUBLE))
      comment: "Average quality rate — measures good output vs. total output; links equipment health to yield outcomes."
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total scheduled available hours across all tools and periods — denominator for capacity utilization planning."
    - name: "total_productive_hours"
      expr: SUM(CAST(productive_hours AS DOUBLE))
      comment: "Total hours tools were actively producing — numerator for utilization rate; directly tied to wafer output capacity."
    - name: "total_unscheduled_downtime_hours"
      expr: SUM(CAST(unscheduled_downtime_hours AS DOUBLE))
      comment: "Total unplanned downtime hours — key risk metric; high values trigger maintenance escalation and capacity replanning."
    - name: "total_scheduled_downtime_hours"
      expr: SUM(CAST(scheduled_downtime_hours AS DOUBLE))
      comment: "Total planned maintenance downtime hours — used to optimize PM scheduling vs. production capacity trade-offs."
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average equipment utilization rate — measures productive use of available capacity; informs capacity expansion decisions."
    - name: "avg_wafer_throughput"
      expr: AVG(CAST(wafer_throughput AS DOUBLE))
      comment: "Average wafer throughput per OEE record period — directly tied to fab output and revenue capacity."
    - name: "total_wafer_throughput"
      expr: SUM(CAST(wafer_throughput AS DOUBLE))
      comment: "Total wafers processed across all tools and periods — top-line fab output metric used in capacity and revenue planning."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours (tool available but not running) — identifies underutilized assets and scheduling inefficiencies."
    - name: "utilization_efficiency_ratio"
      expr: ROUND(100.0 * SUM(CAST(productive_hours AS DOUBLE)) / NULLIF(SUM(CAST(available_hours AS DOUBLE)), 0), 2)
      comment: "Productive hours as a percentage of available hours — compound utilization KPI that drives capacity investment and scheduling decisions."
    - name: "downtime_ratio_percent"
      expr: ROUND(100.0 * SUM(CAST(unscheduled_downtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(available_hours AS DOUBLE)), 0), 2)
      comment: "Unscheduled downtime as a percentage of available hours — reliability KPI that triggers maintenance strategy reviews when elevated."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment downtime analytics — quantifies downtime frequency, OEE impact, and root-cause distribution to drive reliability improvement and maintenance prioritization."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Classification of downtime (unplanned, planned, engineering) for category-level analysis."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Specific reason code for the downtime event — used to identify top failure modes."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (mechanical, electrical, process, human) for systemic improvement targeting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the downtime event for prioritizing corrective actions."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the downtime occurred — identifies shift-specific reliability patterns."
    - name: "scheduled_flag"
      expr: scheduled_flag
      comment: "Boolean flag indicating whether the downtime was scheduled (planned maintenance) or unscheduled (failure)."
    - name: "downtime_start_timestamp"
      expr: DATE_TRUNC('day', downtime_start_timestamp)
      comment: "Day-truncated downtime start timestamp for daily trend analysis."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline frequency metric for reliability trending and SLA compliance."
    - name: "total_oee_impact_percent"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Cumulative OEE impact percentage across all downtime events — quantifies total productivity loss attributable to equipment failures."
    - name: "avg_oee_impact_percent"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact per downtime event — identifies which downtime categories cause the most productivity loss per occurrence."
    - name: "unscheduled_downtime_event_count"
      expr: COUNT(CASE WHEN scheduled_flag = false THEN 1 END)
      comment: "Count of unplanned downtime events — key reliability KPI; high counts trigger maintenance strategy and spare-parts reviews."
    - name: "scheduled_downtime_event_count"
      expr: COUNT(CASE WHEN scheduled_flag = true THEN 1 END)
      comment: "Count of planned maintenance downtime events — used to assess PM program effectiveness and scheduling efficiency."
    - name: "distinct_tools_with_downtime"
      expr: COUNT(DISTINCT primary_fab_tool_id)
      comment: "Number of distinct fab tools that experienced downtime — breadth metric for fleet reliability health assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance event cost, labor, and effectiveness metrics — drives maintenance budget management, technician productivity, and equipment reliability strategy."
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of maintenance event (preventive, corrective, emergency) for category-level cost and frequency analysis."
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Maintenance category (mechanical, electrical, process) for root-cause and cost allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the maintenance event for systemic reliability improvement targeting."
    - name: "maintenance_event_status"
      expr: maintenance_event_status
      comment: "Current status of the maintenance event (open, closed, in-progress) for workload management."
    - name: "requalification_required"
      expr: requalification_required
      comment: "Flag indicating whether tool requalification is required post-maintenance — impacts production scheduling."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating a safety incident occurred during maintenance — critical for EHS compliance reporting."
    - name: "event_timestamp_day"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Day-truncated event timestamp for daily maintenance activity trending."
    - name: "upgrade_type"
      expr: upgrade_type
      comment: "Type of equipment upgrade performed — used to track upgrade program progress and ROI."
  measures:
    - name: "total_maintenance_events"
      expr: COUNT(1)
      comment: "Total number of maintenance events — baseline volume metric for maintenance program capacity planning."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance cost across all events — primary financial KPI for maintenance budget management and cost control."
    - name: "avg_maintenance_cost_per_event"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per maintenance event — benchmarking KPI for identifying high-cost failure modes and optimizing repair strategies."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_total AS DOUBLE))
      comment: "Total labor cost for maintenance activities — drives workforce planning and outsourcing decisions."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_total AS DOUBLE))
      comment: "Total spare parts cost for maintenance — informs spare parts inventory investment and supplier negotiations."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total technician labor hours consumed by maintenance — capacity planning metric for maintenance workforce sizing."
    - name: "avg_labor_hours_per_event"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance event — efficiency KPI for technician productivity benchmarking."
    - name: "total_oee_impact_percent"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Cumulative OEE impact from maintenance events — quantifies total productivity cost of maintenance activities."
    - name: "safety_incident_count"
      expr: COUNT(CASE WHEN safety_incident_flag = true THEN 1 END)
      comment: "Number of maintenance events with safety incidents — critical EHS KPI; any non-zero value triggers safety review."
    - name: "requalification_required_count"
      expr: COUNT(CASE WHEN requalification_required = true THEN 1 END)
      comment: "Number of maintenance events requiring tool requalification — impacts production scheduling and capacity planning."
    - name: "labor_cost_as_pct_of_total"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_total AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of total maintenance cost — informs make-vs-buy and outsourcing strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fab_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab tool fleet health, capacity, and financial metrics — provides the master view of equipment assets for capital planning, utilization management, and lifecycle decisions."
  source: "`vibe_semiconductors_v1`.`equipment`.`fab_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Tool type (lithography, etch, CVD, etc.) for fleet composition and capacity analysis by process category."
    - name: "tool_subtype"
      expr: tool_subtype
      comment: "Tool subtype for granular fleet segmentation and process compatibility analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Tool lifecycle status (active, end-of-life, decommissioned) for asset management and replacement planning."
    - name: "asset_status"
      expr: asset_status
      comment: "Financial asset status for fixed asset accounting and depreciation tracking."
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "Cleanroom classification of the tool location — used for process compatibility and contamination risk analysis."
    - name: "process_node_compatibility"
      expr: process_node_compatibility
      comment: "Process node(s) the tool supports — critical for capacity planning by technology node."
    - name: "installation_date"
      expr: installation_date
      comment: "Tool installation date for fleet age analysis and depreciation scheduling."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the tool — used for export control and compliance reporting."
  measures:
    - name: "total_tools"
      expr: COUNT(1)
      comment: "Total number of fab tools in the fleet — baseline capacity metric for production planning and capital investment decisions."
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure across all fab tools — primary financial metric for equipment investment portfolio management."
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average OEE percentage across the tool fleet — fleet-level productivity KPI used in executive capacity reviews."
    - name: "total_capacity_wafer_per_hour"
      expr: SUM(CAST(capacity_wafer_per_hour AS DOUBLE))
      comment: "Total theoretical wafer processing capacity per hour across all active tools — top-line capacity planning metric."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures across the tool fleet — reliability KPI that drives PM strategy and spare parts investment."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair across the tool fleet — maintenance efficiency KPI; high values indicate technician or parts availability issues."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across the tool fleet — sustainability and operating cost KPI for energy optimization programs."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating per tool — used for utility infrastructure planning and energy cost modeling."
    - name: "tools_near_warranty_expiry"
      expr: COUNT(CASE WHEN warranty_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND warranty_expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of tools with warranty expiring within 90 days — triggers maintenance contract renewal and extended warranty decisions."
    - name: "active_tool_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Count of tools in active lifecycle status — denominator for utilization and capacity calculations."
    - name: "avg_capital_expenditure_per_tool"
      expr: AVG(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Average capital expenditure per tool — benchmarking metric for new tool procurement negotiations and ROI analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fdc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fault Detection and Classification (FDC) event analytics — monitors process excursions, alarm frequency, and OEE impact to drive real-time process control and equipment health management."
  source: "`vibe_semiconductors_v1`.`equipment`.`fdc_event`"
  dimensions:
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of FDC alarm (process, equipment, safety) for category-level excursion analysis."
    - name: "alarm_status"
      expr: alarm_status
      comment: "Current status of the alarm (active, acknowledged, cleared) for open-alarm workload management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the FDC event for prioritizing engineering response."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the FDC event for systemic process improvement targeting."
    - name: "fault_code"
      expr: fault_code
      comment: "Specific fault code for granular failure mode analysis and Pareto ranking."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter that triggered the FDC event — identifies which parameters are most frequently out of control."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating the event was escalated — used to track escalation rate and response effectiveness."
    - name: "event_timestamp_day"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Day-truncated event timestamp for daily FDC event trending."
    - name: "is_simulated"
      expr: is_simulated
      comment: "Flag indicating whether the event was a simulation/test — used to filter real vs. test events in production dashboards."
  measures:
    - name: "total_fdc_events"
      expr: COUNT(1)
      comment: "Total number of FDC events — baseline process control health metric; high counts indicate process instability."
    - name: "total_oee_impact_percent"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Cumulative OEE impact from FDC events — quantifies total productivity loss attributable to process excursions."
    - name: "avg_oee_impact_percent"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact per FDC event — identifies which fault types cause the most productivity loss per occurrence."
    - name: "escalated_event_count"
      expr: COUNT(CASE WHEN escalation_flag = true THEN 1 END)
      comment: "Number of FDC events that were escalated — measures severity of process excursion backlog requiring engineering intervention."
    - name: "escalation_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FDC events that required escalation — process control effectiveness KPI; high rates trigger SPC and recipe reviews."
    - name: "avg_parameter_value"
      expr: AVG(CAST(parameter_value AS DOUBLE))
      comment: "Average measured parameter value at time of FDC event — used to assess how far out-of-control processes are drifting."
    - name: "distinct_tools_with_fdc_events"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct tools generating FDC events — fleet-level process health indicator; high counts signal systemic issues."
    - name: "out_of_range_event_count"
      expr: COUNT(CASE WHEN parameter_value > threshold_high OR parameter_value < threshold_low THEN 1 END)
      comment: "Number of FDC events where the parameter value exceeded defined thresholds — direct measure of process excursion frequency."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment calibration compliance and measurement accuracy metrics — ensures tools are calibrated on schedule and within tolerance to maintain process quality and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`equipment`.`calibration_record`"
  dimensions:
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (initial, periodic, post-repair) for compliance program analysis."
    - name: "calibration_result"
      expr: calibration_result
      comment: "Outcome of the calibration (pass, fail, conditional) for compliance rate tracking."
    - name: "calibration_record_status"
      expr: calibration_record_status
      comment: "Administrative status of the calibration record for data completeness monitoring."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Binary pass/fail result of the calibration for compliance rate calculation."
    - name: "calibration_date"
      expr: calibration_date
      comment: "Date of calibration for scheduling compliance and overdue tracking."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the calibration parameter — used for cross-tool comparability analysis."
    - name: "calibration_method"
      expr: calibration_method
      comment: "Calibration method used — for method-level accuracy and compliance analysis."
  measures:
    - name: "total_calibrations"
      expr: COUNT(1)
      comment: "Total number of calibration records — baseline compliance program volume metric."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_result = 'PASS' THEN 1 END)
      comment: "Number of calibrations that passed — numerator for calibration pass rate KPI."
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail_result = 'FAIL' THEN 1 END)
      comment: "Number of calibrations that failed — triggers tool quarantine and process risk assessment."
    - name: "calibration_pass_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations passing — primary calibration compliance KPI; low rates indicate tool drift or maintenance issues."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across calibration records — used to detect systematic bias or drift in tool measurements."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty — quantifies calibration precision; high uncertainty triggers metrology review."
    - name: "overdue_calibration_count"
      expr: COUNT(CASE WHEN next_calibration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of tools with overdue calibrations — compliance risk KPI; non-zero values trigger immediate regulatory and quality escalation."
    - name: "avg_nominal_vs_measured_deviation"
      expr: AVG(ABS(measured_value - nominal_value))
      comment: "Average absolute deviation between measured and nominal values — accuracy KPI for detecting systematic tool bias."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_recipe_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe execution process control metrics — monitors process parameter adherence, OEE contribution, and execution quality to drive yield improvement and process stability. Includes cooling/thermal process coverage per VREQ-021."
  source: "`vibe_semiconductors_v1`.`equipment`.`recipe_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the recipe execution (completed, aborted, failed) for process yield analysis."
    - name: "process_step"
      expr: process_step
      comment: "Process step name for step-level process control and yield analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used for the execution — enables process performance comparison across tool types."
    - name: "recipe_version"
      expr: recipe_version
      comment: "Recipe version executed — used to compare process performance across recipe revisions."
    - name: "result_code"
      expr: result_code
      comment: "Execution result code for failure mode analysis and process excursion categorization."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical process step — used to prioritize monitoring and escalation."
    - name: "execution_timestamp_day"
      expr: DATE_TRUNC('day', execution_timestamp)
      comment: "Day-truncated execution timestamp for daily process volume and quality trending."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the recipe execution — used for regulatory and quality audit reporting."
  measures:
    - name: "total_recipe_executions"
      expr: COUNT(1)
      comment: "Total number of recipe executions — baseline process volume metric for throughput and capacity analysis."
    - name: "successful_execution_count"
      expr: COUNT(CASE WHEN execution_status = 'COMPLETED' THEN 1 END)
      comment: "Number of successfully completed recipe executions — numerator for process success rate KPI."
    - name: "execution_success_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN execution_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipe executions completing successfully — process reliability KPI directly linked to yield and throughput."
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint across executions — thermal process control baseline for cooling and heating optimization (VREQ-021)."
    - name: "avg_temperature_actual_c"
      expr: AVG(CAST(temperature_actual_c AS DOUBLE))
      comment: "Average actual temperature achieved during execution — compared to setpoint to detect thermal drift and cooling inefficiency (VREQ-021)."
    - name: "avg_temperature_deviation_c"
      expr: AVG(ABS(temperature_actual_c - temperature_setpoint_c))
      comment: "Average absolute deviation between actual and setpoint temperature — cooling/heating process accuracy KPI; high deviation triggers thermal system maintenance (VREQ-021)."
    - name: "avg_pressure_actual_pa"
      expr: AVG(CAST(pressure_actual_pa AS DOUBLE))
      comment: "Average actual chamber pressure during execution — process control metric for etch, CVD, and other pressure-sensitive steps."
    - name: "avg_pressure_deviation_pa"
      expr: AVG(ABS(pressure_actual_pa - pressure_setpoint_pa))
      comment: "Average absolute deviation between actual and setpoint pressure — process stability KPI for pressure-controlled steps."
    - name: "avg_gas_flow_deviation_sccm"
      expr: AVG(ABS(gas_flow_actual_sccm - gas_flow_setpoint_sccm))
      comment: "Average absolute deviation between actual and setpoint gas flow — process gas control accuracy KPI; relevant for cooling gas optimization (VREQ-021)."
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability contribution from recipe executions — links process scheduling to equipment availability."
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average recipe execution duration — throughput efficiency KPI; deviations from target indicate process drift or equipment issues."
    - name: "avg_power_deviation_w"
      expr: AVG(ABS(power_actual_w - power_setpoint_w))
      comment: "Average absolute deviation between actual and setpoint power — energy efficiency and process control KPI for power-intensive steps."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spc_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) metrics for equipment — monitors control limit violations, process stability, and corrective action effectiveness to maintain process quality and yield."
  source: "`vibe_semiconductors_v1`.`equipment`.`spc_control`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "SPC chart type (X-bar, R, CUSUM, EWMA) for control methodology analysis."
    - name: "control_parameter"
      expr: control_parameter
      comment: "Process parameter being controlled — used to identify which parameters are most frequently out of control."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of SPC rule violation (Western Electric, Nelson) for process stability classification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the SPC violation for prioritizing engineering response."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of corrective action for the SPC violation — tracks open vs. resolved excursions."
    - name: "spc_control_status"
      expr: spc_control_status
      comment: "Overall SPC control status for the record — used for compliance and audit reporting."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of process trend (upward, downward, stable) for predictive process control."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the measurement is within compliance limits — used for compliance rate calculation."
    - name: "event_timestamp_day"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Day-truncated event timestamp for daily SPC violation trending."
  measures:
    - name: "total_spc_measurements"
      expr: COUNT(1)
      comment: "Total number of SPC measurements — baseline process monitoring volume metric."
    - name: "total_violations"
      expr: COUNT(CASE WHEN compliance_flag = false THEN 1 END)
      comment: "Total number of SPC control limit violations — primary process stability KPI; high counts trigger process and equipment reviews."
    - name: "violation_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = false THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC measurements that violated control limits — process capability KPI directly linked to yield and quality outcomes."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured process parameter value — used to detect systematic process drift relative to target."
    - name: "avg_deviation_from_target"
      expr: AVG(ABS(measured_value - target_value))
      comment: "Average absolute deviation from process target — process accuracy KPI; high values indicate systematic bias requiring recipe adjustment."
    - name: "open_remediation_count"
      expr: COUNT(CASE WHEN remediation_status = 'OPEN' THEN 1 END)
      comment: "Number of SPC violations with open corrective actions — backlog metric for process engineering workload management."
    - name: "false_alarm_count"
      expr: COUNT(CASE WHEN is_false_alarm = true THEN 1 END)
      comment: "Number of SPC alarms identified as false positives — used to tune control limits and reduce alarm fatigue."
    - name: "false_alarm_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_false_alarm = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC alarms that are false positives — control limit calibration KPI; high rates reduce operator responsiveness to real excursions."
    - name: "distinct_tools_with_violations"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct tools with SPC violations — fleet-level process health indicator for systemic issue detection."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool qualification status and performance metrics — tracks qualification pass rates, cycle times, and OEE impact to manage tool readiness for production and new process node introductions."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (initial, periodic, post-maintenance) for program-level analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, disqualified, in-progress) for production readiness tracking."
    - name: "result"
      expr: result
      comment: "Qualification result (pass, fail, conditional) for pass rate calculation."
    - name: "process_node"
      expr: process_node
      comment: "Process node for which the tool is being qualified — critical for technology node ramp planning."
    - name: "qualification_reason"
      expr: qualification_reason
      comment: "Reason for qualification (new tool, post-repair, process change) for root-cause analysis of disqualifications."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical tool qualification — used to prioritize qualification resources."
    - name: "qualification_start_date"
      expr: qualification_start_date
      comment: "Qualification start date for cycle time analysis and scheduling."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Maintenance status at time of qualification — used to correlate maintenance history with qualification outcomes."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of tool qualification events — baseline metric for qualification program volume and resource planning."
    - name: "pass_count"
      expr: COUNT(CASE WHEN result = 'PASS' THEN 1 END)
      comment: "Number of tool qualifications that passed — numerator for qualification pass rate KPI."
    - name: "qualification_pass_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tool qualifications passing — tool readiness KPI; low rates delay production ramps and new node introductions."
    - name: "avg_result_metric_value"
      expr: AVG(CAST(result_metric_value AS DOUBLE))
      comment: "Average qualification result metric value — used to benchmark tool performance against qualification criteria."
    - name: "avg_oee_impact"
      expr: AVG(CAST(oee_impact AS DOUBLE))
      comment: "Average OEE impact during qualification — quantifies production capacity cost of qualification activities."
    - name: "critical_qualification_count"
      expr: COUNT(CASE WHEN is_critical = true THEN 1 END)
      comment: "Number of critical tool qualifications — used to prioritize engineering resources and track critical path items."
    - name: "disqualified_tool_count"
      expr: COUNT(CASE WHEN qualification_status = 'DISQUALIFIED' THEN 1 END)
      comment: "Number of tools currently disqualified — production risk metric; high counts reduce available capacity and trigger expedited re-qualification."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline performance value at qualification — used to track tool performance trends over successive qualification cycles."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance contract financial and compliance metrics — manages contract portfolio value, SLA performance, and renewal risk to optimize equipment support spend."
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of maintenance contract (full-service, time-and-materials, parts-only) for spend category analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier of the contract (gold, silver, bronze) for SLA performance benchmarking."
    - name: "maintenance_contract_status"
      expr: maintenance_contract_status
      comment: "Current contract status (active, expired, pending renewal) for contract lifecycle management."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment covered by the contract for spend analysis by tool type."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the contract is exclusive — used for vendor dependency and risk analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date for renewal pipeline management and budget forecasting."
    - name: "currency"
      expr: currency
      comment: "Contract currency for multi-currency spend consolidation."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total value of all maintenance contracts — primary financial KPI for equipment support spend management."
    - name: "total_annual_cost_usd"
      expr: SUM(CAST(annual_cost_usd AS DOUBLE))
      comment: "Total annualized maintenance contract cost in USD — used for budget planning and year-over-year spend comparison."
    - name: "avg_annual_cost_per_contract"
      expr: AVG(CAST(annual_cost_usd AS DOUBLE))
      comment: "Average annual cost per maintenance contract — benchmarking metric for contract negotiation and vendor comparison."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN maintenance_contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active maintenance contracts — baseline for contract portfolio management."
    - name: "contracts_expiring_90_days"
      expr: COUNT(CASE WHEN contract_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND contract_end_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of contracts expiring within 90 days — renewal pipeline KPI that triggers procurement and negotiation actions."
    - name: "exclusive_contract_count"
      expr: COUNT(CASE WHEN is_exclusive = true THEN 1 END)
      comment: "Number of exclusive maintenance contracts — vendor dependency risk metric for supply chain resilience analysis."
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of maintenance contracts in portfolio — baseline for contract management workload and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_capex`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool capital expenditure metrics — tracks equipment investment spend, warranty costs, and procurement efficiency to support capital planning and ROI analysis."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_capex`"
  dimensions:
    - name: "tool_capex_status"
      expr: tool_capex_status
      comment: "Status of the CAPEX request (approved, pending, rejected) for investment pipeline management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, accelerated) for financial reporting analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of capital funding (internal, government grant, CHIPS Act) for investment portfolio analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage for warranty cost and risk analysis."
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Flag indicating extended warranty was purchased — used to analyze extended warranty ROI."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the CAPEX transaction for multi-currency investment consolidation."
    - name: "approval_date"
      expr: approval_date
      comment: "CAPEX approval date for investment cycle time analysis."
  measures:
    - name: "total_capex_amount_usd"
      expr: SUM(CAST(capex_amount_usd AS DOUBLE))
      comment: "Total capital expenditure amount in USD — primary equipment investment KPI for capital budget management."
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price across all tool CAPEX records — used for procurement spend analysis and vendor negotiations."
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total installation cost — often underestimated; tracking enables more accurate total cost of ownership modeling."
    - name: "total_nre_charges"
      expr: SUM(CAST(nre_charges AS DOUBLE))
      comment: "Total non-recurring engineering charges — tracks one-time customization costs for tool procurement ROI analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid on tool purchases — used for tax planning and total cost of ownership calculations."
    - name: "total_warranty_claim_amount"
      expr: SUM(CAST(warranty_claim_total_amount AS DOUBLE))
      comment: "Total warranty claim value recovered — measures warranty program effectiveness and tool reliability ROI."
    - name: "avg_capex_per_tool"
      expr: AVG(CAST(capex_amount_usd AS DOUBLE))
      comment: "Average CAPEX per tool — benchmarking metric for procurement negotiations and technology node investment planning."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total all-in amount (purchase + installation + NRE + tax) — true total cost of ownership metric for capital investment decisions."
    - name: "extended_warranty_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN extended_warranty_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tool purchases with extended warranty — risk management KPI for equipment reliability and maintenance cost planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_metrology_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology run measurement quality and process control metrics — monitors measurement accuracy, process parameter distributions, and tool calibration status to maintain process control and yield."
  source: "`vibe_semiconductors_v1`.`equipment`.`metrology_run`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (CD, overlay, film thickness, etc.) for measurement program analysis."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Measurement mode (inline, offline, monitor) for sampling strategy analysis."
    - name: "metrology_run_status"
      expr: metrology_run_status
      comment: "Status of the metrology run (completed, failed, aborted) for data quality filtering."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass/fail result of the metrology measurement — used for process control compliance rate calculation."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the metrology tool at time of measurement — used to assess measurement data reliability."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot measured (production, monitor, qualification) for measurement program coverage analysis."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the metrology run was performed — for shift-level measurement quality analysis."
    - name: "run_timestamp_day"
      expr: DATE_TRUNC('day', run_timestamp)
      comment: "Day-truncated run timestamp for daily metrology volume and quality trending."
  measures:
    - name: "total_metrology_runs"
      expr: COUNT(1)
      comment: "Total number of metrology runs — baseline measurement program volume metric."
    - name: "pass_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of metrology measurements passing spec limits — process control compliance KPI directly linked to yield."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across metrology runs — process centering metric for detecting systematic process drift."
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average of run mean values — used for process capability and centering analysis."
    - name: "avg_std_dev"
      expr: AVG(CAST(std_dev AS DOUBLE))
      comment: "Average standard deviation across metrology runs — process variability KPI; high values indicate process instability."
    - name: "avg_sigma_value"
      expr: AVG(CAST(sigma_value AS DOUBLE))
      comment: "Average sigma value — process capability indicator; values below 3 trigger immediate process engineering review."
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average OEE percentage for metrology tools — equipment productivity KPI for metrology tool fleet management."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN measured_value > spec_limit_high OR measured_value < spec_limit_low THEN 1 END)
      comment: "Number of measurements outside specification limits — direct process excursion count; triggers lot disposition and process review."
    - name: "spec_exceedance_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN measured_value > spec_limit_high OR measured_value < spec_limit_low THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements exceeding specification limits — process yield risk KPI for executive quality reviews."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment process recipe management metrics — tracks recipe lifecycle, process parameter targets, and yield performance to govern recipe qualification and change control. Includes thermal/cooling parameter coverage per VREQ-021."
  source: "`vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`"
  dimensions:
    - name: "recipe_category"
      expr: recipe_category
      comment: "Category of the process recipe (etch, deposition, litho, anneal, cool) for process type analysis including cooling processes (VREQ-021)."
    - name: "approval_status"
      expr: approval_status
      comment: "Recipe approval status (approved, pending, rejected) for change control compliance tracking."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the recipe is currently active in production — used to filter active recipe portfolio."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating whether the recipe has been deprecated — used for recipe lifecycle management."
    - name: "process_node_target"
      expr: process_node_target
      comment: "Target process node for the recipe — used for technology node-level recipe portfolio analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the recipe — used for compliance and quality audit reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the recipe — used for regulatory and export control reporting."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Recipe effective start date for version lifecycle and change control analysis."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of equipment process recipes — baseline recipe portfolio size metric for change control management."
    - name: "active_recipe_count"
      expr: COUNT(CASE WHEN is_active = true THEN 1 END)
      comment: "Number of currently active recipes — production-ready recipe portfolio size for capacity and process planning."
    - name: "avg_yield_actual_percent"
      expr: AVG(CAST(yield_actual_percent AS DOUBLE))
      comment: "Average actual yield percentage across recipes — recipe performance KPI directly linked to wafer output and revenue."
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE) - CAST(yield_actual_percent AS DOUBLE))
      comment: "Average gap between target and actual yield — recipe optimization opportunity metric; high values prioritize recipe improvement programs."
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint across recipes — thermal process baseline for cooling and heating optimization analysis (VREQ-021)."
    - name: "avg_pressure_setpoint_pa"
      expr: AVG(CAST(pressure_setpoint_pa AS DOUBLE))
      comment: "Average pressure setpoint across recipes — process parameter baseline for chamber condition optimization."
    - name: "avg_gas_flow_rate_sccm"
      expr: AVG(CAST(gas_flow_rate_sccm AS DOUBLE))
      comment: "Average gas flow rate setpoint — process gas consumption baseline for cooling gas and waste elimination optimization (VREQ-021)."
    - name: "avg_rf_power_watts"
      expr: AVG(CAST(rf_power_watts AS DOUBLE))
      comment: "Average RF power setpoint — energy consumption baseline for power optimization and cooling load analysis (VREQ-021)."
    - name: "avg_oee_actual_percent"
      expr: AVG(CAST(oee_actual_percent AS DOUBLE))
      comment: "Average actual OEE percentage for recipes — recipe-level equipment productivity KPI."
    - name: "deprecated_recipe_count"
      expr: COUNT(CASE WHEN is_deprecated = true THEN 1 END)
      comment: "Number of deprecated recipes still in the system — recipe hygiene metric for change control and system maintenance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory and cost metrics — manages parts availability, stock levels, and procurement costs to minimize equipment downtime and optimize maintenance spend."
  source: "`vibe_semiconductors_v1`.`equipment`.`spare_part`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "Category of spare part (mechanical, electrical, consumable) for inventory segmentation and spend analysis."
    - name: "part_type"
      expr: part_type
      comment: "Specific part type for granular inventory management."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the spare part (critical, important, standard) for safety stock prioritization."
    - name: "spare_part_status"
      expr: spare_part_status
      comment: "Current status of the spare part (in-stock, on-order, obsolete) for inventory availability analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating hazardous material content — used for EHS compliance and storage requirement analysis."
    - name: "calibration_required_flag"
      expr: calibration_required_flag
      comment: "Flag indicating whether the part requires calibration after installation — impacts maintenance cycle time planning."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of the spare part — used for incoming quality control monitoring."
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of spare part SKUs in the inventory — baseline parts catalog size metric."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost_usd AS DOUBLE))
      comment: "Total unit cost value of spare parts inventory — financial exposure metric for inventory investment management."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost_usd AS DOUBLE))
      comment: "Average unit cost per spare part — benchmarking metric for procurement negotiations and cost reduction programs."
    - name: "critical_part_count"
      expr: COUNT(CASE WHEN criticality_rating = 'CRITICAL' THEN 1 END)
      comment: "Number of critical spare parts — risk metric for supply chain resilience; critical parts with low stock trigger emergency procurement."
    - name: "hazardous_part_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = true THEN 1 END)
      comment: "Number of hazardous material spare parts — EHS compliance metric for storage and handling program management."
    - name: "total_part_weight_kg"
      expr: SUM(CAST(part_weight_kg AS DOUBLE))
      comment: "Total weight of spare parts inventory — logistics and storage capacity planning metric."
    - name: "avg_part_volume_cm3"
      expr: AVG(CAST(part_volume_cm3 AS DOUBLE))
      comment: "Average part volume — storage space planning metric for warehouse and cleanroom storage optimization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_alarm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool alarm frequency, severity, and response metrics — monitors equipment health signals to drive predictive maintenance and reduce unplanned downtime."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_alarm`"
  dimensions:
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the tool alarm (process, equipment, safety, environmental) for alarm type analysis."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of the alarm for prioritizing response and escalation."
    - name: "alarm_status"
      expr: alarm_status
      comment: "Current status of the alarm (active, acknowledged, cleared) for open alarm workload management."
    - name: "alarm_priority"
      expr: alarm_priority
      comment: "Priority level of the alarm for response time SLA management."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the alarm for systemic failure mode analysis."
    - name: "oee_impact_flag"
      expr: oee_impact_flag
      comment: "Flag indicating the alarm had an OEE impact — used to filter alarms with production consequences."
    - name: "predicted_failure_flag"
      expr: predicted_failure_flag
      comment: "Flag indicating the alarm was a predicted failure — used to measure predictive maintenance effectiveness."
    - name: "alarm_timestamp_day"
      expr: DATE_TRUNC('day', alarm_timestamp)
      comment: "Day-truncated alarm timestamp for daily alarm volume trending."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the alarm occurred — for shift-level alarm pattern analysis."
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total number of tool alarms — baseline equipment health metric; high counts indicate deteriorating tool condition."
    - name: "oee_impacting_alarm_count"
      expr: COUNT(CASE WHEN oee_impact_flag = true THEN 1 END)
      comment: "Number of alarms with direct OEE impact — production risk metric for prioritizing alarm response."
    - name: "oee_impact_alarm_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN oee_impact_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarms with OEE impact — alarm quality KPI; high rates indicate systemic equipment issues affecting production."
    - name: "predicted_failure_alarm_count"
      expr: COUNT(CASE WHEN predicted_failure_flag = true THEN 1 END)
      comment: "Number of alarms flagged as predicted failures — measures predictive maintenance program coverage and effectiveness."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average alarm severity score — fleet-level equipment health indicator for maintenance prioritization."
    - name: "distinct_tools_with_alarms"
      expr: COUNT(DISTINCT primary_fab_tool_id)
      comment: "Number of distinct tools generating alarms — breadth metric for fleet health assessment."
    - name: "active_alarm_count"
      expr: COUNT(CASE WHEN alarm_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active (unresolved) alarms — real-time equipment health risk metric for operations management."
$$;