-- Metric views for domain: process | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_capability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process capability KPIs tracking Cpk/Ppk indices, specification limits, and statistical control health across process steps and technology nodes. Used by process engineers and manufacturing VPs to assess whether processes are capable of meeting design specifications."
  source: "`vibe_semiconductors_v1`.`process`.`capability`"
  dimensions:
    - name: "process_area"
      expr: process_area
      comment: "Fab process area (e.g., FEOL, BEOL, Litho) for grouping capability results by manufacturing zone."
    - name: "process_layer"
      expr: process_layer
      comment: "Specific process layer being evaluated, enabling layer-level capability drill-down."
    - name: "capability_status"
      expr: capability_status
      comment: "Current status of the capability study (e.g., In Control, Out of Control, Under Review)."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Statistical method used for capability assessment (e.g., Minitab, SPC, DOE)."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification state of the process being measured, used to filter production-released vs. experimental data."
    - name: "control_chart_type"
      expr: control_chart_type
      comment: "Type of SPC control chart used (e.g., Xbar-R, EWMA, CUSUM)."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Observed trend direction (Improving, Degrading, Stable) for executive-level process health monitoring."
    - name: "evaluation_period_start"
      expr: evaluation_period_start_date
      comment: "Start date of the capability evaluation period for time-series trending."
    - name: "evaluation_period_end"
      expr: evaluation_period_end_date
      comment: "End date of the capability evaluation period."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required, used to prioritize engineering response."
  measures:
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Cpk index across all capability studies. The primary process capability KPI — values below 1.33 trigger engineering intervention and risk yield loss."
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Ppk (overall process performance index) reflecting long-term process variation including all sources of noise."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Cp (process potential index) measuring the ratio of specification width to process spread, independent of centering."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk observed — identifies the worst-performing process step or layer, the most critical risk indicator for yield."
    - name: "avg_standard_deviation"
      expr: AVG(CAST(standard_deviation AS DOUBLE))
      comment: "Average process standard deviation across capability studies, indicating overall process variability level."
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average measured process mean, used to assess centering relative to target and specification limits."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across capability studies, providing the baseline for centering analysis."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_specification_limit AS DOUBLE))
      comment: "Average upper specification limit, used alongside mean and sigma to contextualize capability indices."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_specification_limit AS DOUBLE))
      comment: "Average lower specification limit across studies."
    - name: "capability_study_count"
      expr: COUNT(1)
      comment: "Total number of capability studies conducted. Tracks coverage of process steps under statistical monitoring."
    - name: "out_of_control_study_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of capability studies requiring corrective action — a direct measure of process risk exposure."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capability studies requiring corrective action. A rising rate signals systemic process degradation requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process excursion KPIs tracking out-of-control events, yield impact, financial exposure, and resolution cycle times. Critical for manufacturing operations reviews and risk management dashboards."
  source: "`vibe_semiconductors_v1`.`process`.`excursion`"
  dimensions:
    - name: "excursion_type"
      expr: excursion_type
      comment: "Category of excursion (e.g., SPC violation, defect spike, parametric shift) for root cause classification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (Critical, Major, Minor) driving escalation and resource prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (Equipment, Process, Material, Human) for Pareto analysis."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of affected material (Use As Is, Rework, Scrap) impacting cost and delivery."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current investigation state (Open, In Progress, Closed) for workload and closure rate tracking."
    - name: "yield_loss_mode"
      expr: yield_loss_mode
      comment: "Mode of yield loss (Defect, Parametric, Electrical) enabling targeted process improvement."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the excursion (SPC, Inspection, Customer) for detection effectiveness analysis."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Flag indicating customer notification obligation, critical for customer relationship and compliance management."
    - name: "spc_rule_violated"
      expr: spc_rule_violated
      comment: "Specific SPC rule that was violated (e.g., Western Electric Rule 1-8), enabling rule-specific trend analysis."
  measures:
    - name: "total_excursions"
      expr: COUNT(1)
      comment: "Total number of process excursions. The primary operational health KPI — rising counts signal systemic process instability."
    - name: "avg_estimated_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact per excursion. Directly quantifies the production efficiency cost of process excursions."
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of all excursions in USD. The primary cost-of-quality metric for executive financial reviews."
    - name: "avg_financial_impact_per_excursion_usd"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per excursion, used to prioritize high-cost excursion types for targeted prevention programs."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density at excursion events, linking process control failures to physical defect outcomes."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of excursions requiring customer notification — a key customer satisfaction and contractual compliance risk indicator."
    - name: "critical_excursion_count"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of critical-severity excursions requiring immediate executive escalation and resource mobilization."
    - name: "open_excursion_count"
      expr: COUNT(CASE WHEN investigation_status = 'Open' THEN 1 END)
      comment: "Number of currently open excursions — a real-time operational risk backlog metric for manufacturing leadership."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value at excursion detection, providing context for specification deviation magnitude."
    - name: "avg_upper_control_limit"
      expr: AVG(CAST(upper_control_limit AS DOUBLE))
      comment: "Average upper control limit across excursion events, used to assess control limit adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_lot_process_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot-level process execution KPIs covering throughput, defect rates, cooling efficiency, and waste metrics. The primary operational dashboard source for fab floor performance and process engineering reviews."
  source: "`vibe_semiconductors_v1`.`process`.`lot_process_run`"
  dimensions:
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final disposition of the lot (Pass, Rework, Scrap, Hold) for yield and material loss analysis."
    - name: "cooling_method"
      expr: cooling_method
      comment: "Cooling method applied during the process run, enabling cooling strategy performance comparison."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Indicates whether a cooling process was active during this run, used to segment cooling vs. non-cooling runs."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization was enabled, used to measure the operational adoption rate of optimization programs."
    - name: "cooling_optimization_mode"
      expr: cooling_optimization_mode
      comment: "Specific cooling optimization mode applied, enabling mode-level performance benchmarking."
    - name: "waste_elimination_strategy"
      expr: waste_elimination_strategy
      comment: "Waste elimination strategy in use, supporting sustainability and cost reduction program tracking."
    - name: "waste_heat_recovery_flag"
      expr: waste_heat_recovery_flag
      comment: "Whether waste heat recovery was active, used to track energy sustainability program adoption."
    - name: "process_qualification_status"
      expr: process_qualification_status
      comment: "Qualification status of the process at run time, enabling separation of qualified vs. experimental runs."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot holds, used to Pareto hold causes and drive targeted process improvements."
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Whether an SPC control chart violation occurred during this run, linking process runs to quality events."
  measures:
    - name: "total_process_runs"
      expr: COUNT(1)
      comment: "Total number of lot process runs. The primary throughput metric for fab capacity and utilization analysis."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² across process runs. The primary in-line quality metric driving yield prediction and process control decisions."
    - name: "avg_process_temperature_c"
      expr: AVG(CAST(process_temperature_c AS DOUBLE))
      comment: "Average process temperature across runs, used to monitor thermal process stability and detect drift."
    - name: "avg_process_gas_flow_sccm"
      expr: AVG(CAST(process_gas_flow_sccm AS DOUBLE))
      comment: "Average process gas flow rate, used to monitor consumable usage and process recipe adherence."
    - name: "avg_process_power_watts"
      expr: AVG(CAST(process_power_watts AS DOUBLE))
      comment: "Average process power consumption per run, supporting energy efficiency and cost-per-wafer analysis."
    - name: "avg_process_pressure_torr"
      expr: AVG(CAST(process_pressure_torr AS DOUBLE))
      comment: "Average chamber pressure across runs, used to detect process drift and equipment degradation."
    - name: "avg_cooling_duration_seconds"
      expr: AVG(CAST(cooling_duration_seconds AS DOUBLE))
      comment: "Average cooling duration per run. A key cycle time component — reducing cooling time directly improves fab throughput."
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption per run. Directly informs energy cost reduction and sustainability targets."
    - name: "total_cooling_energy_kwh"
      expr: SUM(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Total cooling energy consumed across all runs. The primary sustainability KPI for cooling process environmental impact reporting."
    - name: "avg_coolant_waste_volume_liters"
      expr: AVG(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Average coolant waste volume per run. Tracks chemical waste generation for environmental compliance and waste elimination programs."
    - name: "total_coolant_waste_volume_liters"
      expr: SUM(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Total coolant waste volume across all runs. A critical environmental KPI for fab sustainability reporting and regulatory compliance."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate percentage. Measures the effectiveness of coolant recycling programs — higher rates reduce cost and environmental impact."
    - name: "avg_measurement_result_value"
      expr: AVG(CAST(measurement_result_value AS DOUBLE))
      comment: "Average in-line measurement result value across process runs, used to monitor process centering and detect systematic drift."
    - name: "spc_violation_run_count"
      expr: COUNT(CASE WHEN control_chart_violation_flag = TRUE THEN 1 END)
      comment: "Number of runs with SPC control chart violations. A leading indicator of process instability requiring immediate engineering response."
    - name: "spc_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN control_chart_violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs with SPC violations. A key process control health KPI — rising rates signal systemic process degradation."
    - name: "avg_measured_cooling_temperature_c"
      expr: AVG(CAST(measured_cooling_temperature_celsius AS DOUBLE))
      comment: "Average measured cooling temperature during process runs. Used to validate cooling process performance against target setpoints."
    - name: "avg_cooling_ramp_rate"
      expr: AVG(CAST(cooling_ramp_rate_celsius_per_min AS DOUBLE))
      comment: "Average cooling ramp rate in °C/min. Faster controlled ramp rates improve throughput; deviations indicate equipment or process issues."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_yield_loss_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield loss event KPIs quantifying defect-driven yield degradation, financial impact, and cooling-related waste. The primary yield management dashboard source for process engineering and operations leadership."
  source: "`vibe_semiconductors_v1`.`process`.`yield_loss_event`"
  dimensions:
    - name: "yield_loss_mode"
      expr: yield_loss_mode
      comment: "Mode of yield loss (Defect, Parametric, Electrical, Mechanical) for Pareto-driven root cause prioritization."
    - name: "defect_type"
      expr: defect_type
      comment: "Specific defect type causing yield loss, enabling targeted process improvement investments."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category for yield loss, used in executive quality reviews and corrective action prioritization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the yield loss event, driving escalation and resource allocation decisions."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution state (Open, In Progress, Resolved) for backlog management and closure rate tracking."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer where yield loss occurred, enabling layer-level yield loss Pareto analysis."
    - name: "lot_hold_applied"
      expr: lot_hold_applied
      comment: "Whether a lot hold was applied in response to the yield loss event, indicating severity of containment action."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Whether a cooling process was active at the time of yield loss, used to correlate cooling issues with yield degradation."
    - name: "waste_elimination_strategy"
      expr: waste_elimination_strategy
      comment: "Waste elimination strategy in effect, used to assess whether waste reduction programs correlate with yield improvement."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the yield loss (SPC, Inspection, Test) for detection effectiveness benchmarking."
  measures:
    - name: "total_yield_loss_events"
      expr: COUNT(1)
      comment: "Total number of yield loss events. The primary yield quality KPI — rising counts signal process degradation requiring executive intervention."
    - name: "avg_estimated_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact per event. Directly quantifies the production efficiency cost of yield loss, informing process investment decisions."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density at yield loss events, linking process control failures to physical yield outcomes."
    - name: "avg_defect_size_nm"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers, used to assess whether defects are within or beyond the critical dimension threshold for the technology node."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk at yield loss events — low Cpk at yield loss events confirms process capability as the root cause."
    - name: "lot_hold_event_count"
      expr: COUNT(CASE WHEN lot_hold_applied = TRUE THEN 1 END)
      comment: "Number of yield loss events that triggered lot holds. Measures the operational disruption and material-at-risk from yield excursions."
    - name: "lot_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lot_hold_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield loss events resulting in lot holds. A key operational risk metric — high rates indicate severe process instability."
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption at yield loss events, used to identify whether cooling inefficiency correlates with yield degradation."
    - name: "total_coolant_waste_volume_liters"
      expr: SUM(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Total coolant waste volume associated with yield loss events, quantifying the environmental cost of process excursions."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate at yield loss events, used to assess whether poor coolant management contributes to yield loss."
    - name: "open_yield_loss_event_count"
      expr: COUNT(CASE WHEN resolution_status = 'Open' THEN 1 END)
      comment: "Number of unresolved yield loss events — a real-time risk backlog metric for manufacturing and quality leadership."
    - name: "avg_wafer_position_x_mm"
      expr: AVG(CAST(wafer_position_x_mm AS DOUBLE))
      comment: "Average X-coordinate of yield loss events on the wafer, used to detect systematic spatial patterns indicating equipment or process issues."
    - name: "avg_wafer_position_y_mm"
      expr: AVG(CAST(wafer_position_y_mm AS DOUBLE))
      comment: "Average Y-coordinate of yield loss events on the wafer, used alongside X to identify edge, center, or quadrant yield loss patterns."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_spc_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SPC measurement KPIs tracking statistical process control performance, out-of-control rates, and sigma levels across process steps. The primary real-time process control dashboard for manufacturing operations."
  source: "`vibe_semiconductors_v1`.`process`.`spc_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of SPC measurement (e.g., CD, Thickness, Overlay) for parameter-specific control analysis."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Standardized parameter code for cross-tool and cross-lot SPC trending."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Human-readable parameter name for business user dashboards."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (Valid, Suspect, Rejected) for data quality filtering."
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Whether the measurement triggered an out-of-control condition, the primary SPC alert dimension."
    - name: "out_of_spec_flag"
      expr: out_of_spec_flag
      comment: "Whether the measurement exceeded specification limits, indicating potential product non-conformance."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Whether a cooling process was active during measurement, used to correlate cooling conditions with measurement outcomes."
    - name: "cooling_optimization_mode"
      expr: cooling_optimization_mode
      comment: "Cooling optimization mode active during measurement, enabling mode-level SPC performance comparison."
    - name: "waste_elimination_strategy"
      expr: waste_elimination_strategy
      comment: "Waste elimination strategy in effect, used to assess whether waste reduction programs affect measurement stability."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the SPC parameter, ensuring correct interpretation of measurement values."
  measures:
    - name: "total_spc_measurements"
      expr: COUNT(1)
      comment: "Total number of SPC measurements. Tracks the volume of process monitoring activity and sampling coverage."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured SPC value. The primary process centering metric — deviations from target trigger process adjustment."
    - name: "avg_sigma_level"
      expr: AVG(CAST(sigma_level AS DOUBLE))
      comment: "Average sigma level across measurements. The primary process capability health metric — values below 3-sigma trigger engineering escalation."
    - name: "avg_deviation_from_target"
      expr: AVG(CAST(deviation_from_target AS DOUBLE))
      comment: "Average deviation from target value. Measures systematic process bias requiring recipe or equipment adjustment."
    - name: "avg_control_limit_lower"
      expr: AVG(CAST(control_limit_lower AS DOUBLE))
      comment: "Average lower control limit across SPC charts, used to assess control limit adequacy relative to process variation."
    - name: "avg_control_limit_upper"
      expr: AVG(CAST(control_limit_upper AS DOUBLE))
      comment: "Average upper control limit across SPC charts."
    - name: "out_of_control_measurement_count"
      expr: COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END)
      comment: "Number of out-of-control measurements. The primary SPC alarm metric — rising counts require immediate process engineering response."
    - name: "out_of_spec_measurement_count"
      expr: COUNT(CASE WHEN out_of_spec_flag = TRUE THEN 1 END)
      comment: "Number of out-of-specification measurements. Indicates potential product non-conformance requiring disposition decisions."
    - name: "out_of_control_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements that are out of control. The primary SPC health rate KPI for process control dashboards and executive quality reviews."
    - name: "out_of_spec_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_spec_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements exceeding specification limits. Directly predicts product non-conformance rate and customer quality risk."
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption during SPC measurement runs, used to correlate cooling efficiency with measurement stability."
    - name: "avg_coolant_waste_volume_liters"
      expr: AVG(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Average coolant waste volume during SPC measurement runs, supporting waste elimination program tracking."
    - name: "avg_measured_cooling_temperature_c"
      expr: AVG(CAST(measured_cooling_temperature_celsius AS DOUBLE))
      comment: "Average measured cooling temperature during SPC runs, used to validate cooling process performance and its impact on measurement repeatability."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_defect_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect inspection KPIs tracking defect density, killer defect rates, and inspection coverage across wafer lots and process steps. The primary in-line quality monitoring source for yield engineering and operations reviews."
  source: "`vibe_semiconductors_v1`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., Brightfield, Darkfield, E-beam) for tool-specific defect analysis."
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Inspection mode (e.g., Die-to-Die, Die-to-Database) affecting defect detection sensitivity."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer inspected, enabling layer-level defect Pareto analysis."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the inspected wafer (Pass, Hold, Scrap) for material flow impact analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection result (Complete, Pending Review, Rejected)."
    - name: "excursion_detected"
      expr: excursion_detected
      comment: "Whether an excursion was detected during inspection, linking inspection results to process excursion events."
    - name: "review_required"
      expr: review_required
      comment: "Whether manual review is required, used to track inspection review backlog and resource loading."
    - name: "nuisance_filter_applied"
      expr: nuisance_filter_applied
      comment: "Whether a nuisance filter was applied, used to assess the impact of filtering on true defect detection rates."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of defect inspections performed. Tracks inspection coverage and sampling completeness."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm². The primary in-line yield predictor — rising defect density directly forecasts yield loss."
    - name: "avg_inspected_area_cm2"
      expr: AVG(CAST(inspected_area_cm2 AS DOUBLE))
      comment: "Average inspected area per wafer, used to normalize defect counts and assess inspection coverage completeness."
    - name: "avg_spc_control_limit_upper"
      expr: AVG(CAST(spc_control_limit_upper AS DOUBLE))
      comment: "Average upper SPC control limit for defect density, used to assess whether control limits are appropriately set for the technology node."
    - name: "avg_spc_control_limit_lower"
      expr: AVG(CAST(spc_control_limit_lower AS DOUBLE))
      comment: "Average lower SPC control limit for defect density."
    - name: "excursion_detected_count"
      expr: COUNT(CASE WHEN excursion_detected = TRUE THEN 1 END)
      comment: "Number of inspections that detected a process excursion. The primary in-line excursion detection metric for real-time process control."
    - name: "excursion_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN excursion_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections detecting an excursion. A rising rate is a leading indicator of process instability requiring immediate engineering response."
    - name: "review_required_count"
      expr: COUNT(CASE WHEN review_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring manual review, used to manage inspection review backlog and engineer workload."
    - name: "review_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring manual review, indicating inspection automation effectiveness and review resource demand."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_cooling_process`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cooling process KPIs covering thermal performance, energy efficiency, waste elimination, and qualification status. Addresses VREQ-021 cooling process modeling requirement — provides executive visibility into cooling optimization and waste reduction programs across the fab."
  source: "`vibe_semiconductors_v1`.`process`.`cooling_process`"
  dimensions:
    - name: "process_type"
      expr: process_type
      comment: "Type of cooling process (e.g., Backside Gas, Chilled Water, Electrostatic Chuck) for technology-level performance comparison."
    - name: "process_status"
      expr: process_status
      comment: "Current status of the cooling process (Active, Deprecated, Under Qualification) for lifecycle management."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification state of the cooling process, used to separate production-released from experimental cooling processes."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type the cooling process applies to, enabling equipment-class-level cooling performance analysis."
    - name: "coolant_medium"
      expr: coolant_medium
      comment: "Coolant medium used (e.g., DI Water, Fluorinert, Helium) for medium-level efficiency and cost comparison."
    - name: "ehs_classification"
      expr: ehs_classification
      comment: "Environmental health and safety classification of the cooling process, used for regulatory compliance tracking."
    - name: "safety_interlock_required_flag"
      expr: safety_interlock_required_flag
      comment: "Whether a safety interlock is required, used to track safety compliance across cooling process deployments."
    - name: "hazardous_gas_flag"
      expr: hazardous_gas_flag
      comment: "Whether hazardous gas is used in the cooling process, critical for EHS risk management and regulatory reporting."
    - name: "electrostatic_chuck_required_flag"
      expr: electrostatic_chuck_required_flag
      comment: "Whether an electrostatic chuck is required, used to assess equipment compatibility and capital requirements."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node the cooling process is qualified for, enabling node-level cooling performance benchmarking."
  measures:
    - name: "total_cooling_processes"
      expr: COUNT(1)
      comment: "Total number of defined cooling processes. Tracks the breadth of cooling process coverage across the fab."
    - name: "avg_target_temperature_c"
      expr: AVG(CAST(target_temperature_c AS DOUBLE))
      comment: "Average target cooling temperature across all cooling processes. Used to benchmark thermal targets and assess process window adequacy."
    - name: "avg_cooling_rate_c_per_sec"
      expr: AVG(CAST(cooling_rate_c_per_sec AS DOUBLE))
      comment: "Average cooling rate in °C/sec. Faster cooling rates improve throughput — this KPI drives cooling optimization investment decisions."
    - name: "avg_max_cooling_rate_c_per_sec"
      expr: AVG(CAST(max_cooling_rate_c_per_sec AS DOUBLE))
      comment: "Average maximum achievable cooling rate, used to assess headroom for throughput improvement through cooling optimization."
    - name: "avg_cooldown_duration_sec"
      expr: AVG(CAST(cooldown_duration_sec AS DOUBLE))
      comment: "Average cooldown duration in seconds. A direct cycle time component — reducing cooldown duration is a primary fab throughput lever."
    - name: "avg_max_cooldown_duration_sec"
      expr: AVG(CAST(max_cooldown_duration_sec AS DOUBLE))
      comment: "Average maximum allowed cooldown duration, used to assess process window tightness and equipment capability."
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per cooling process. The primary energy efficiency KPI for cooling sustainability programs."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across all cooling processes. The primary sustainability KPI for cooling environmental impact reporting and carbon footprint reduction programs."
    - name: "avg_uniformity_spec_pct"
      expr: AVG(CAST(uniformity_spec_pct AS DOUBLE))
      comment: "Average cooling uniformity specification percentage. Tighter uniformity specs indicate higher-precision cooling requirements for advanced nodes."
    - name: "avg_cpk_target"
      expr: AVG(CAST(cpk_target AS DOUBLE))
      comment: "Average Cpk target for cooling processes. Used to assess whether cooling process capability targets are aligned with technology node requirements."
    - name: "avg_thermal_budget_c_sec"
      expr: AVG(CAST(thermal_budget_c_sec AS DOUBLE))
      comment: "Average thermal budget (°C·sec) across cooling processes. Thermal budget management is critical for advanced node device performance and reliability."
    - name: "hazardous_gas_process_count"
      expr: COUNT(CASE WHEN hazardous_gas_flag = TRUE THEN 1 END)
      comment: "Number of cooling processes using hazardous gases. A critical EHS risk metric for regulatory compliance and safety program management."
    - name: "safety_interlock_required_count"
      expr: COUNT(CASE WHEN safety_interlock_required_flag = TRUE THEN 1 END)
      comment: "Number of cooling processes requiring safety interlocks, used to track safety infrastructure requirements and compliance."
    - name: "qualified_cooling_process_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of fully qualified cooling processes available for production use. Tracks cooling process readiness for manufacturing ramp."
    - name: "qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cooling processes that are fully qualified. A process readiness KPI for technology node ramp planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_cooling_optimization_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cooling optimization run KPIs measuring the effectiveness of cooling optimization experiments, energy savings, yield impact, and production recommendation rates. Directly addresses VREQ-021 cooling optimization modeling requirement."
  source: "`vibe_semiconductors_v1`.`process`.`cooling_optimization_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the optimization run (Complete, In Progress, Failed) for pipeline management."
    - name: "run_type"
      expr: run_type
      comment: "Type of optimization run (DOE, Iterative, Model-Based) for methodology-level performance comparison."
    - name: "optimization_algorithm"
      expr: optimization_algorithm
      comment: "Algorithm used for cooling optimization (e.g., Gradient Descent, Genetic Algorithm, RSM) for algorithm effectiveness benchmarking."
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Primary optimization objective (e.g., Minimize Temperature, Maximize Uniformity, Minimize Energy) for objective-level outcome analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the optimization run result, used to track production readiness of optimized cooling recipes."
    - name: "recommended_for_production"
      expr: recommended_for_production
      comment: "Whether the optimization run result is recommended for production deployment — the primary output metric of the optimization program."
    - name: "spc_in_control"
      expr: spc_in_control
      comment: "Whether the process was in SPC control during the optimization run, used to validate optimization results under controlled conditions."
    - name: "coolant_type"
      expr: coolant_type
      comment: "Coolant type used during the optimization run, enabling coolant-level performance comparison."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for which the cooling optimization was performed, enabling node-level optimization effectiveness analysis."
    - name: "fab_area"
      expr: fab_area
      comment: "Fab area where the optimization run was conducted, used for area-level cooling performance benchmarking."
  measures:
    - name: "total_optimization_runs"
      expr: COUNT(1)
      comment: "Total number of cooling optimization runs. Tracks the scale of the cooling optimization program."
    - name: "avg_optimization_score"
      expr: AVG(CAST(optimization_score AS DOUBLE))
      comment: "Average optimization score achieved. The primary optimization effectiveness KPI — higher scores indicate better cooling performance relative to the objective function."
    - name: "avg_temp_improvement_c"
      expr: AVG(CAST(temp_improvement_c AS DOUBLE))
      comment: "Average temperature improvement achieved by optimization in °C. Directly quantifies the thermal benefit of the cooling optimization program."
    - name: "avg_optimized_wafer_temp_c"
      expr: AVG(CAST(optimized_wafer_temp_c AS DOUBLE))
      comment: "Average optimized wafer temperature achieved, used to validate that optimization meets thermal budget requirements."
    - name: "avg_baseline_wafer_temp_c"
      expr: AVG(CAST(baseline_wafer_temp_c AS DOUBLE))
      comment: "Average baseline wafer temperature before optimization, providing the reference point for improvement measurement."
    - name: "avg_wafer_temp_uniformity_c"
      expr: AVG(CAST(wafer_temp_uniformity_c AS DOUBLE))
      comment: "Average wafer temperature uniformity achieved post-optimization. Better uniformity directly improves within-wafer yield uniformity."
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per optimization run. Used to assess whether optimization reduces energy use alongside thermal performance."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across all optimization runs, used to quantify the energy investment in the cooling optimization program."
    - name: "avg_heat_removal_rate_w"
      expr: AVG(CAST(heat_removal_rate_w AS DOUBLE))
      comment: "Average heat removal rate in watts. A key thermal engineering KPI — higher heat removal rates enable faster processing and better thermal control."
    - name: "avg_cooling_system_efficiency_pct"
      expr: AVG(CAST(cooling_system_efficiency_pct AS DOUBLE))
      comment: "Average cooling system efficiency percentage. The primary cooling infrastructure performance KPI for facilities and equipment management."
    - name: "avg_thermal_resistance_c_per_w"
      expr: AVG(CAST(thermal_resistance_c_per_w AS DOUBLE))
      comment: "Average thermal resistance of the cooling system. Lower thermal resistance indicates better heat transfer capability and cooling effectiveness."
    - name: "avg_thermal_stabilization_time_s"
      expr: AVG(CAST(thermal_stabilization_time_s AS DOUBLE))
      comment: "Average thermal stabilization time in seconds. Reducing stabilization time directly improves fab throughput and cycle time."
    - name: "avg_process_capability_cpk"
      expr: AVG(CAST(process_capability_cpk AS DOUBLE))
      comment: "Average process Cpk achieved during optimization runs. Validates that cooling optimization improves process capability alongside thermal performance."
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(yield_impact_pct AS DOUBLE))
      comment: "Average yield impact of cooling optimization. The ultimate business value metric — positive yield impact justifies the optimization program investment."
    - name: "production_recommended_count"
      expr: COUNT(CASE WHEN recommended_for_production = TRUE THEN 1 END)
      comment: "Number of optimization runs recommended for production deployment. Tracks the output pipeline of the cooling optimization program."
    - name: "production_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recommended_for_production = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of optimization runs recommended for production. The primary program effectiveness KPI — low rates indicate optimization methodology needs improvement."
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average duration of cooling optimization runs in minutes. Used to plan optimization program capacity and resource requirements."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_cooling_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cooling condition KPIs tracking thermal setpoints, qualification status, and process window adequacy across cooling conditions. Supports VREQ-021 cooling process coverage and enables process engineers to manage cooling condition libraries."
  source: "`vibe_semiconductors_v1`.`process`.`cooling_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of cooling condition (e.g., Post-Etch, Post-Implant, Post-CMP) for process-step-level cooling analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the cooling condition, used to separate production-released from experimental conditions."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type the cooling condition applies to, enabling equipment-class-level cooling performance analysis."
    - name: "coolant_medium"
      expr: coolant_medium
      comment: "Coolant medium used in the condition, for medium-level performance and cost comparison."
    - name: "is_active"
      expr: is_active
      comment: "Whether the cooling condition is currently active, used to filter the active condition library."
    - name: "is_default"
      expr: is_default
      comment: "Whether this is the default cooling condition for the process step, used to track standardization."
    - name: "safety_interlock_required"
      expr: safety_interlock_required
      comment: "Whether a safety interlock is required for this cooling condition, used for safety compliance tracking."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node the cooling condition is qualified for, enabling node-level condition library analysis."
    - name: "wafer_material"
      expr: wafer_material
      comment: "Wafer material (e.g., Silicon, SiC, GaN) the cooling condition is designed for."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer size in mm (e.g., 200, 300) the cooling condition applies to."
  measures:
    - name: "total_cooling_conditions"
      expr: COUNT(1)
      comment: "Total number of defined cooling conditions. Tracks the breadth of the cooling condition library."
    - name: "avg_target_temperature_c"
      expr: AVG(CAST(target_temperature_c AS DOUBLE))
      comment: "Average target cooling temperature across conditions. Used to benchmark thermal targets across technology nodes and process steps."
    - name: "avg_cooling_rate_c_per_min"
      expr: AVG(CAST(cooling_rate_c_per_min AS DOUBLE))
      comment: "Average cooling rate in °C/min. A key throughput driver — faster cooling rates reduce cycle time."
    - name: "avg_max_cooling_rate_c_per_min"
      expr: AVG(CAST(cooling_rate_max_c_per_min AS DOUBLE))
      comment: "Average maximum cooling rate specification, used to assess equipment capability headroom."
    - name: "avg_cooling_duration_sec"
      expr: AVG(CAST(cooling_duration_sec AS DOUBLE))
      comment: "Average cooling duration in seconds. A direct cycle time component for throughput optimization."
    - name: "avg_max_cooling_duration_sec"
      expr: AVG(CAST(cooling_duration_max_sec AS DOUBLE))
      comment: "Average maximum allowed cooling duration, used to assess process window tightness."
    - name: "avg_cpk_target"
      expr: AVG(CAST(cpk_target AS DOUBLE))
      comment: "Average Cpk target for cooling conditions. Used to assess whether cooling capability targets are aligned with technology node requirements."
    - name: "avg_thermal_budget_c_sec"
      expr: AVG(CAST(thermal_budget_c_sec AS DOUBLE))
      comment: "Average thermal budget across cooling conditions. Critical for advanced node device performance and reliability management."
    - name: "avg_uniformity_spec_pct"
      expr: AVG(CAST(uniformity_spec_pct AS DOUBLE))
      comment: "Average uniformity specification percentage. Tighter uniformity specs indicate higher-precision cooling requirements."
    - name: "avg_stabilization_time_sec"
      expr: AVG(CAST(stabilization_time_sec AS DOUBLE))
      comment: "Average thermal stabilization time in seconds. Reducing stabilization time is a key cycle time improvement lever."
    - name: "active_condition_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active cooling conditions. Tracks the size of the production-ready cooling condition library."
    - name: "safety_interlock_required_count"
      expr: COUNT(CASE WHEN safety_interlock_required = TRUE THEN 1 END)
      comment: "Number of cooling conditions requiring safety interlocks, used to plan safety infrastructure requirements."
    - name: "qualified_condition_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of fully qualified cooling conditions. Tracks production readiness of the cooling condition library."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow KPIs tracking qualification status, cycle time targets, yield targets, and cooling/waste metrics across process flows. Used by process integration and manufacturing engineering leadership to manage process flow portfolios."
  source: "`vibe_semiconductors_v1`.`process`.`process_flow`"
  dimensions:
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (e.g., Standard, Experimental, Customer-Specific) for portfolio segmentation."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the process flow, used to separate production-released from experimental flows."
    - name: "device_family"
      expr: device_family
      comment: "Device family the process flow supports, enabling family-level flow portfolio analysis."
    - name: "is_baseline_flow"
      expr: is_baseline_flow
      comment: "Whether this is the baseline process flow for the technology node, used to track baseline vs. derivative flows."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Whether a cooling process is part of this flow, used to segment flows with and without dedicated cooling steps."
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Whether cooling optimization is enabled for this flow, tracking adoption of cooling optimization programs."
    - name: "waste_elimination_strategy"
      expr: waste_elimination_strategy
      comment: "Waste elimination strategy applied to this flow, used to track sustainability program adoption across the flow portfolio."
    - name: "waste_heat_recovery_flag"
      expr: waste_heat_recovery_flag
      comment: "Whether waste heat recovery is enabled for this flow, tracking energy sustainability program adoption."
    - name: "supports_multi_patterning"
      expr: supports_multi_patterning
      comment: "Whether the flow supports multi-patterning lithography, used to track advanced node capability."
  measures:
    - name: "total_process_flows"
      expr: COUNT(1)
      comment: "Total number of process flows in the portfolio. Tracks the breadth of process flow coverage."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across process flows. The primary process flow quality target KPI for manufacturing planning."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time target in days across process flows. A key manufacturing efficiency KPI — shorter cycle times improve delivery performance and capital efficiency."
    - name: "avg_baseline_cpk"
      expr: AVG(CAST(baseline_cpk AS DOUBLE))
      comment: "Average baseline Cpk across process flows. Used to assess the overall process capability health of the flow portfolio."
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption per process flow. Used to benchmark cooling energy intensity across flows and identify optimization opportunities."
    - name: "total_cooling_energy_kwh"
      expr: SUM(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Total cooling energy consumption across all process flows. The primary cooling sustainability KPI for process flow portfolio management."
    - name: "avg_coolant_waste_volume_liters"
      expr: AVG(CAST(coolant_waste_volume_liters AS DOUBLE))
      comment: "Average coolant waste volume per process flow, used to identify high-waste flows for targeted waste elimination programs."
    - name: "avg_coolant_reclaim_rate_pct"
      expr: AVG(CAST(coolant_reclaim_rate_percent AS DOUBLE))
      comment: "Average coolant reclaim rate across process flows. Higher reclaim rates indicate more sustainable process flow designs."
    - name: "qualified_flow_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of fully qualified process flows available for production. Tracks process flow readiness for manufacturing ramp."
    - name: "cooling_optimized_flow_count"
      expr: COUNT(CASE WHEN cooling_optimization_enabled_flag = TRUE THEN 1 END)
      comment: "Number of process flows with cooling optimization enabled. Tracks adoption of cooling optimization programs across the flow portfolio."
    - name: "waste_heat_recovery_flow_count"
      expr: COUNT(CASE WHEN waste_heat_recovery_flag = TRUE THEN 1 END)
      comment: "Number of process flows with waste heat recovery enabled. Tracks energy sustainability program adoption across the flow portfolio."
    - name: "cooling_optimization_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cooling_optimization_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process flows with cooling optimization enabled. The primary cooling program adoption KPI for sustainability and efficiency reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process qualification KPIs tracking qualification completion rates, yield achievement, Cpk performance, and customer approval status. Used by process engineering and quality leadership to manage qualification pipelines and technology readiness."
  source: "`vibe_semiconductors_v1`.`process`.`process_qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., Initial, Re-qualification, Customer-Specific) for pipeline segmentation."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (In Progress, Passed, Failed, On Hold) for pipeline management."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for qualifications requiring customer sign-off, critical for customer-facing technology readiness."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the qualification (Approved, Rejected, Conditional) for decision tracking."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Whether customer approval is required, used to segment internal vs. customer-facing qualification pipelines."
    - name: "qualification_name"
      expr: qualification_name
      comment: "Name of the qualification program for portfolio-level tracking."
    - name: "owner_organization"
      expr: owner_organization
      comment: "Organization responsible for the qualification, used for workload and accountability analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of process qualifications. Tracks the scale of the qualification pipeline."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield achieved during qualification. The primary qualification outcome metric — yield below target triggers re-qualification or process improvement."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield for qualifications, providing the benchmark for actual yield comparison."
    - name: "avg_actual_cpk"
      expr: AVG(CAST(actual_cpk AS DOUBLE))
      comment: "Average actual Cpk achieved during qualification. Cpk below 1.33 typically fails qualification criteria and requires process improvement."
    - name: "avg_target_cpk"
      expr: AVG(CAST(target_cpk AS DOUBLE))
      comment: "Average target Cpk for qualifications, providing the capability benchmark."
    - name: "passed_qualification_count"
      expr: COUNT(CASE WHEN qualification_status = 'Passed' THEN 1 END)
      comment: "Number of passed qualifications. Tracks the output rate of the qualification pipeline."
    - name: "failed_qualification_count"
      expr: COUNT(CASE WHEN qualification_status = 'Failed' THEN 1 END)
      comment: "Number of failed qualifications. A key process readiness risk metric — high failure rates delay technology ramp and customer commitments."
    - name: "qualification_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications that passed. The primary qualification program effectiveness KPI for technology readiness reviews."
    - name: "customer_approval_pending_count"
      expr: COUNT(CASE WHEN customer_approval_status = 'Pending' AND requires_customer_approval = TRUE THEN 1 END)
      comment: "Number of qualifications awaiting customer approval. A critical customer commitment risk metric — delays here directly impact customer design win timelines."
    - name: "yield_achievement_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(actual_yield_percent AS DOUBLE)) / NULLIF(AVG(CAST(target_yield_percent AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to target yield as a percentage. Measures how effectively qualifications achieve their yield targets — below 100% indicates process improvement is needed."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process metrology measurement KPIs tracking measurement accuracy, process centering, uniformity, and cooling-related measurement conditions. Used by metrology engineers and process control teams to ensure measurement quality and process stability."
  source: "`vibe_semiconductors_v1`.`process`.`process_metrology_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (e.g., CD-SEM, Ellipsometry, XRF) for tool-specific analysis."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Specific parameter being measured (e.g., Film Thickness, CD, Overlay) for parameter-level trending."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer being measured, enabling layer-level metrology performance analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (Valid, Suspect, Rejected) for data quality filtering."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the measured wafer (Pass, Hold, Scrap) for material flow impact analysis."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Whether the measurement has a data quality issue, used to filter reliable measurements for process control decisions."
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Whether a cooling process was active during measurement, used to correlate cooling conditions with measurement repeatability."
    - name: "cooling_optimization_mode"
      expr: cooling_optimization_mode
      comment: "Cooling optimization mode during measurement, enabling mode-level measurement quality comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the metrology parameter, ensuring correct interpretation of measurement values."
  measures:
    - name: "total_metrology_measurements"
      expr: COUNT(1)
      comment: "Total number of metrology measurements. Tracks measurement coverage and sampling completeness across process steps."
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average measured mean value across metrology measurements. The primary process centering metric for metrology-driven process control."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across measurements, providing the reference for centering analysis."
    - name: "avg_std_deviation"
      expr: AVG(CAST(std_deviation AS DOUBLE))
      comment: "Average standard deviation of measurements. Measures process variability — lower values indicate better process control."
    - name: "avg_uniformity_pct"
      expr: AVG(CAST(uniformity_percent AS DOUBLE))
      comment: "Average within-wafer uniformity percentage. A key process quality metric — poor uniformity leads to die-level yield variation."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value from metrology measurements. Validates that measured process parameters meet capability requirements."
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp value from metrology measurements, measuring process potential independent of centering."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across measurements, used to contextualize measurement values relative to specifications."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across measurements."
    - name: "data_quality_issue_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Number of measurements with data quality issues. Tracks metrology tool reliability and measurement system health."
    - name: "data_quality_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements with data quality issues. A rising rate signals metrology tool degradation requiring maintenance or calibration."
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption during metrology runs, used to assess cooling energy efficiency in the metrology process."
    - name: "avg_measured_cooling_temperature_c"
      expr: AVG(CAST(measured_cooling_temperature_celsius AS DOUBLE))
      comment: "Average measured cooling temperature during metrology runs, used to validate that cooling conditions meet measurement environment requirements."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_ocap_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-Control Action Plan (OCAP) KPIs tracking response times, resolution effectiveness, and escalation rates for SPC violations. Used by process control and manufacturing operations leadership to manage process excursion response performance."
  source: "`vibe_semiconductors_v1`.`process`.`ocap_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of OCAP action taken (e.g., Tool Hold, Recipe Adjustment, Lot Disposition) for action effectiveness analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the OCAP action (Open, In Progress, Closed) for workload management."
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity of the triggering excursion (Critical, Major, Minor) for priority-based response analysis."
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause classification (Equipment, Process, Material, Human) for Pareto-driven prevention programs."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached (L1, L2, L3) for escalation rate and management burden analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation was required, used to track the rate of excursions requiring management intervention."
    - name: "containment_action_flag"
      expr: containment_action_flag
      comment: "Whether a containment action was taken, used to assess containment response completeness."
    - name: "customer_notification_required_flag"
      expr: customer_notification_required_flag
      comment: "Whether customer notification was required, a key customer relationship and contractual compliance metric."
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Disposition of affected lots (Use As Is, Rework, Scrap) for material loss impact analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the OCAP action (P1, P2, P3) for resource allocation and response time benchmarking."
  measures:
    - name: "total_ocap_actions"
      expr: COUNT(1)
      comment: "Total number of OCAP actions initiated. Tracks the volume of process control interventions required."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average OCAP response time in minutes. The primary process control responsiveness KPI — faster response times reduce yield loss from excursions."
    - name: "avg_resolution_time_minutes"
      expr: AVG(CAST(resolution_time_minutes AS DOUBLE))
      comment: "Average OCAP resolution time in minutes. Measures the end-to-end effectiveness of the OCAP process — longer resolution times increase yield loss exposure."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of OCAP actions requiring escalation. A key management burden metric — high escalation rates indicate systemic process control issues."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OCAP actions requiring escalation. A rising rate signals deteriorating process control health requiring executive attention."
    - name: "customer_notification_count"
      expr: COUNT(CASE WHEN customer_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of OCAP actions requiring customer notification. A critical customer satisfaction and contractual compliance risk metric."
    - name: "open_ocap_count"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Number of currently open OCAP actions. A real-time process risk backlog metric for manufacturing operations leadership."
    - name: "critical_ocap_count"
      expr: COUNT(CASE WHEN excursion_severity = 'Critical' THEN 1 END)
      comment: "Number of OCAP actions for critical-severity excursions. Tracks the most severe process control events requiring immediate executive attention."
    - name: "containment_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN containment_action_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OCAP actions with containment actions taken. Measures the completeness of the containment response process."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_doe_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design of Experiments (DOE) KPIs tracking experiment completion rates, process capability improvement, and yield impact. Used by process integration and R&D leadership to manage the DOE pipeline and measure the ROI of process optimization experiments."
  source: "`vibe_semiconductors_v1`.`process`.`doe_experiment`"
  dimensions:
    - name: "doe_type"
      expr: doe_type
      comment: "Type of DOE (e.g., Full Factorial, Fractional Factorial, Response Surface) for methodology-level analysis."
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the experiment (Planned, In Progress, Complete, Cancelled) for pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the experiment (Approved, Pending, Rejected) for governance tracking."
    - name: "owner_organization"
      expr: owner_organization
      comment: "Organization responsible for the DOE, used for workload and accountability analysis."
    - name: "primary_response_variable"
      expr: primary_response_variable
      comment: "Primary response variable being optimized (e.g., Yield, CD, Thickness) for objective-level analysis."
    - name: "run_order_strategy"
      expr: run_order_strategy
      comment: "Run order strategy (Randomized, Blocked, Sequential) for experimental design quality assessment."
    - name: "statistical_analysis_method"
      expr: statistical_analysis_method
      comment: "Statistical analysis method used (e.g., ANOVA, Regression, RSM) for methodology benchmarking."
  measures:
    - name: "total_doe_experiments"
      expr: COUNT(1)
      comment: "Total number of DOE experiments. Tracks the scale of the process optimization experimentation program."
    - name: "avg_baseline_cpk"
      expr: AVG(CAST(baseline_cpk AS DOUBLE))
      comment: "Average baseline Cpk before DOE intervention, providing the starting point for improvement measurement."
    - name: "avg_post_doe_cpk"
      expr: AVG(CAST(post_doe_cpk AS DOUBLE))
      comment: "Average Cpk achieved after DOE completion. The primary DOE outcome metric — improvement over baseline validates the experiment's value."
    - name: "avg_cpk_improvement"
      expr: AVG(CAST(post_doe_cpk AS DOUBLE) - CAST(baseline_cpk AS DOUBLE))
      comment: "Average Cpk improvement achieved by DOE experiments. The primary ROI metric for the process optimization program — positive values justify continued DOE investment."
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(yield_impact_percent AS DOUBLE))
      comment: "Average yield impact of DOE experiments. Directly quantifies the production value of process optimization experiments."
    - name: "completed_experiment_count"
      expr: COUNT(CASE WHEN experiment_status = 'Complete' THEN 1 END)
      comment: "Number of completed DOE experiments. Tracks the output rate of the process optimization pipeline."
    - name: "experiment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN experiment_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DOE experiments that reached completion. A program execution effectiveness KPI — low rates indicate resource or technical barriers to experimentation."
    - name: "positive_yield_impact_count"
      expr: COUNT(CASE WHEN yield_impact_percent > 0 THEN 1 END)
      comment: "Number of DOE experiments with positive yield impact. Tracks the success rate of yield improvement experiments."
    - name: "positive_yield_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN yield_impact_percent > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DOE experiments achieving positive yield impact. The primary DOE program ROI rate KPI for R&D and process engineering leadership."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_flow_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow qualification KPIs tracking yield achievement, Cpk performance, qualification cycle times, and production release rates. Used by process engineering and manufacturing leadership to manage flow qualification pipelines and technology readiness."
  source: "`vibe_semiconductors_v1`.`process`.`flow_qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of flow qualification (e.g., Initial, Re-qualification, Customer-Specific) for pipeline segmentation."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (In Progress, Passed, Failed, On Hold) for pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the qualification (Approved, Pending, Rejected) for governance tracking."
    - name: "is_production_released"
      expr: is_production_released
      comment: "Whether the flow qualification has been released to production, the ultimate readiness milestone."
    - name: "is_active_flag"
      expr: is_active_flag
      comment: "Whether the qualification is currently active, used to filter the active qualification pipeline."
    - name: "qualification_method"
      expr: qualification_method
      comment: "Method used for qualification (e.g., Statistical, Engineering Judgment, Customer Audit) for methodology analysis."
  measures:
    - name: "total_flow_qualifications"
      expr: COUNT(1)
      comment: "Total number of flow qualifications. Tracks the scale of the flow qualification pipeline."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield achieved during flow qualification. The primary qualification outcome metric."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield for flow qualifications, providing the benchmark for actual yield comparison."
    - name: "avg_achieved_yield_pct"
      expr: AVG(CAST(achieved_yield_percent AS DOUBLE))
      comment: "Average achieved yield percentage, used alongside actual and target yield for comprehensive yield performance analysis."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk achieved during flow qualification. Cpk below 1.33 typically fails qualification criteria."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density achieved during flow qualification, used to validate defect performance against technology node requirements."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average qualification cycle time in days. Shorter cycle times accelerate technology ramp and customer commitment fulfillment."
    - name: "production_released_count"
      expr: COUNT(CASE WHEN is_production_released = TRUE THEN 1 END)
      comment: "Number of flow qualifications released to production. Tracks the output rate of the qualification pipeline."
    - name: "production_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_production_released = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flow qualifications released to production. The primary technology readiness KPI for manufacturing ramp planning."
    - name: "yield_achievement_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(actual_yield_percent AS DOUBLE)) / NULLIF(AVG(CAST(target_yield_percent AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to target yield as a percentage. Measures how effectively flow qualifications achieve their yield targets."
$$;