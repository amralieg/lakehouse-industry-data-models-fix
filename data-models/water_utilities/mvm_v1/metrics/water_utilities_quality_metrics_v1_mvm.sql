-- Metric views for domain: quality | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_analytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analytical laboratory result KPIs tracking contaminant detection, compliance exceedance rates, method quality, and quantitative result statistics. Core operational quality dashboard for water quality managers and regulatory compliance officers."
  source: "`water_utilities_ecm`.`quality`.`analytical_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the laboratory analysis was performed — used to trend result volumes and compliance rates over time."
    - name: "analytical_method"
      expr: analytical_method
      comment: "Laboratory analytical method applied (e.g. EPA 200.8, SM 4500) — used to compare method-level performance and compliance."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Matrix type of the sample (e.g. drinking water, wastewater effluent) — segments results by water type for regulatory reporting."
    - name: "result_status"
      expr: result_status
      comment: "Validation status of the result (e.g. accepted, rejected, preliminary) — filters dashboards to finalized data."
    - name: "data_validation_level"
      expr: data_validation_level
      comment: "Level of data validation applied to the result — used to assess data quality tier for regulatory submissions."
    - name: "compliance_exceeded"
      expr: compliance_exceeded
      comment: "Boolean flag indicating whether the result exceeded the applicable regulatory limit — primary compliance dimension."
    - name: "hold_time_compliant"
      expr: hold_time_compliant
      comment: "Boolean flag indicating whether sample hold time requirements were met — quality control dimension for result validity."
    - name: "reporting_required"
      expr: reporting_required
      comment: "Boolean flag indicating whether this result must be reported to the regulatory agency — filters to reportable results."
    - name: "qualifier_code"
      expr: qualifier_code
      comment: "Laboratory qualifier code (e.g. J, U, B) indicating result qualification status — used in data usability assessments."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result value (e.g. mg/L, NTU, CFU/100mL) — ensures correct interpretation of numeric results."
  measures:
    - name: "total_analytical_results"
      expr: COUNT(1)
      comment: "Total number of analytical results — baseline volume metric for laboratory throughput and monitoring program coverage."
    - name: "compliance_exceedance_count"
      expr: SUM(CAST(compliance_exceeded AS INT))
      comment: "Number of results where the regulatory limit was exceeded — direct measure of water quality compliance failures requiring immediate action."
    - name: "compliance_exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(compliance_exceeded AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analytical results that exceeded the regulatory compliance limit — key regulatory risk KPI tracked by compliance officers and executives."
    - name: "hold_time_noncompliance_count"
      expr: SUM(CASE WHEN hold_time_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Number of results where sample hold time requirements were violated — indicates laboratory handling quality issues that may invalidate results."
    - name: "hold_time_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(hold_time_compliant AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples collected and analyzed within required hold times — laboratory quality control KPI affecting result defensibility."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured contaminant concentration across results — used to track trends relative to MCL thresholds and identify systemic quality issues."
    - name: "avg_percent_recovery"
      expr: AVG(CAST(percent_recovery AS DOUBLE))
      comment: "Average laboratory percent recovery across QC samples — measures analytical method accuracy; values outside 70–130% indicate method performance issues."
    - name: "avg_relative_percent_difference"
      expr: AVG(CAST(relative_percent_difference AS DOUBLE))
      comment: "Average relative percent difference between duplicate analyses — measures laboratory precision; high RPD indicates reproducibility problems."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied to samples — elevated dilution factors may indicate high-concentration events or matrix interference issues."
    - name: "results_above_mcl_count"
      expr: SUM(CASE WHEN result_value > mcl_value AND mcl_value > 0 THEN 1 ELSE 0 END)
      comment: "Number of results where the measured value exceeded the Maximum Contaminant Level — regulatory violation indicator used in CCR and primacy agency reporting."
    - name: "results_above_mclg_count"
      expr: SUM(CASE WHEN result_value > mclg_value AND mclg_value > 0 THEN 1 ELSE 0 END)
      comment: "Number of results exceeding the Maximum Contaminant Level Goal — health-based risk indicator used for proactive treatment optimization decisions."
    - name: "reporting_required_result_count"
      expr: SUM(CAST(reporting_required AS INT))
      comment: "Count of results flagged as requiring regulatory reporting — drives workload planning for compliance reporting staff."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_water_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water sample collection KPIs covering field measurement quality, sample program throughput, and collection condition monitoring. Used by field operations managers and quality assurance teams to evaluate sampling program effectiveness."
  source: "`water_utilities_ecm`.`quality`.`water_sample`"
  dimensions:
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g. routine, repeat, confirmation, QC) — segments sampling activity by regulatory program requirement."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Matrix of the collected sample (e.g. drinking water, raw water, wastewater) — used to segment field measurements by water type."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (e.g. collected, submitted, analyzed, rejected) — tracks sample lifecycle for chain-of-custody management."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample collection (e.g. compliance monitoring, investigative, operational) — used to categorize sampling effort by program type."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which the sample was collected (e.g. TCR, LCR, SDWA) — enables program-level compliance tracking."
    - name: "quality_control_flag"
      expr: quality_control_flag
      comment: "Boolean flag indicating whether the sample is a quality control sample — separates QC samples from routine compliance samples in analysis."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of sample collection — used to correlate field quality measurements with environmental conditions."
    - name: "collection_date"
      expr: DATE(collection_timestamp)
      comment: "Date the sample was collected — primary time dimension for trending sample volumes and field measurement values."
  measures:
    - name: "total_samples_collected"
      expr: COUNT(1)
      comment: "Total number of water samples collected — baseline throughput metric for sampling program coverage and field operations capacity."
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field pH measurement at time of sample collection — operational water quality indicator; values outside 6.5–8.5 may indicate treatment or corrosion issues."
    - name: "avg_field_turbidity_ntu"
      expr: AVG(CAST(field_turbidity_ntu AS DOUBLE))
      comment: "Average field turbidity in NTU at sample collection — key treatment performance indicator; elevated turbidity may signal filtration failure or distribution system disturbance."
    - name: "avg_field_chlorine_residual_mg_l"
      expr: AVG(CAST(field_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average free chlorine residual measured in the field — disinfection effectiveness KPI; low residuals indicate distribution system vulnerability to microbial contamination."
    - name: "avg_field_temperature_c"
      expr: AVG(CAST(field_temperature_c AS DOUBLE))
      comment: "Average water temperature at sample collection — affects disinfection efficacy and microbial growth risk; used in seasonal treatment optimization."
    - name: "avg_field_dissolved_oxygen_mg_l"
      expr: AVG(CAST(field_dissolved_oxygen_mg_l AS DOUBLE))
      comment: "Average dissolved oxygen concentration measured in the field — wastewater treatment performance indicator; low DO indicates biological treatment stress."
    - name: "avg_field_conductivity_us_cm"
      expr: AVG(CAST(field_conductivity_us_cm AS DOUBLE))
      comment: "Average field conductivity in µS/cm — indicator of total dissolved solids and potential contamination events; used for source water quality trending."
    - name: "samples_below_chlorine_threshold_count"
      expr: SUM(CASE WHEN field_chlorine_residual_mg_l < 0.2 THEN 1 ELSE 0 END)
      comment: "Number of samples collected where field chlorine residual was below 0.2 mg/L — regulatory risk indicator for distribution system disinfection compliance (SWTR/RTCR)."
    - name: "high_turbidity_sample_count"
      expr: SUM(CASE WHEN field_turbidity_ntu > 1.0 THEN 1 ELSE 0 END)
      comment: "Number of samples with field turbidity exceeding 1.0 NTU — treatment performance alert metric; triggers investigation of filtration or source water events."
    - name: "qc_sample_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quality_control_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collected samples that are quality control samples — measures QC program intensity; used to verify laboratory quality assurance compliance."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_turbidity_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Continuous turbidity monitoring KPIs for treatment facility compliance and operational performance. Tracks exceedance events, alarm frequency, and turbidity trends critical for Surface Water Treatment Rule compliance and filter performance management."
  source: "`water_utilities_ecm`.`quality`.`turbidity_reading`"
  dimensions:
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Date of the turbidity measurement — primary time dimension for daily compliance reporting and trend analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the turbidity reading (e.g. compliant, violation, warning) — used to filter and segment compliance dashboards."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Boolean flag indicating whether the turbidity reading exceeded the regulatory limit — primary compliance event dimension."
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Boolean flag indicating whether the reading triggered an operational alarm — used to track alarm frequency and response requirements."
    - name: "measurement_location_type"
      expr: measurement_location_type
      comment: "Type of measurement location (e.g. filter effluent, combined filter effluent, entry point) — segments turbidity data by regulatory monitoring point type."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used for turbidity measurement (e.g. nephelometric, online continuous) — used to assess measurement comparability across instruments."
    - name: "filter_unit_number"
      expr: filter_unit_number
      comment: "Identifier of the filter unit being monitored — enables per-filter performance comparison and targeted maintenance decisions."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Regulatory reporting period for the turbidity reading — used to aggregate readings into monthly operating report (MOR) compliance summaries."
    - name: "data_quality_code"
      expr: data_quality_code
      comment: "Data quality code assigned to the reading — used to filter out suspect or invalid readings from compliance calculations."
  measures:
    - name: "total_turbidity_readings"
      expr: COUNT(1)
      comment: "Total number of turbidity readings recorded — baseline volume metric for continuous monitoring coverage and instrument uptime assessment."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_value_ntu AS DOUBLE))
      comment: "Average turbidity value in NTU — primary treatment performance KPI; sustained averages above regulatory thresholds indicate filtration system degradation."
    - name: "max_turbidity_ntu"
      expr: MAX(CAST(turbidity_value_ntu AS DOUBLE))
      comment: "Maximum turbidity value recorded in the period — peak exceedance indicator used in regulatory reporting and treatment event investigation."
    - name: "exceedance_event_count"
      expr: SUM(CAST(exceedance_flag AS INT))
      comment: "Number of turbidity readings that exceeded the regulatory limit — direct compliance violation count used in MOR reporting and SWTR compliance tracking."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(exceedance_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of turbidity readings exceeding the regulatory limit — compliance rate KPI used by operations and regulatory affairs to assess treatment system reliability."
    - name: "alarm_trigger_count"
      expr: SUM(CAST(alarm_triggered_flag AS INT))
      comment: "Number of readings that triggered operational alarms — operational reliability metric; high alarm frequency indicates instrument calibration issues or treatment instability."
    - name: "alarm_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(alarm_triggered_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings that triggered alarms — used to benchmark alarm sensitivity and identify chronic treatment performance issues."
    - name: "avg_regulatory_limit_ntu"
      expr: AVG(CAST(regulatory_limit_ntu AS DOUBLE))
      comment: "Average applicable regulatory turbidity limit across readings — provides context for exceedance rate interpretation and limit change impact analysis."
    - name: "avg_flow_rate_mgd"
      expr: AVG(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Average flow rate in MGD at time of turbidity measurement — used to correlate turbidity exceedances with high-flow events and hydraulic loading conditions."
    - name: "readings_above_1ntu_count"
      expr: SUM(CASE WHEN turbidity_value_ntu > 1.0 THEN 1 ELSE 0 END)
      comment: "Number of readings exceeding 1.0 NTU — SWTR individual filter turbidity threshold; used for filter-specific compliance tracking and backwash optimization."
    - name: "readings_above_4ntu_count"
      expr: SUM(CASE WHEN turbidity_value_ntu > 4.0 THEN 1 ELSE 0 END)
      comment: "Number of readings exceeding 4.0 NTU — combined filter effluent MCL threshold; each occurrence is a potential regulatory violation requiring immediate corrective action."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_sampling_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling schedule compliance and program management KPIs. Tracks monitoring program adherence, schedule violation rates, and cost-per-sample efficiency — used by compliance managers to ensure regulatory monitoring obligations are met on time and within budget."
  source: "`water_utilities_ecm`.`quality`.`sampling_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the sampling schedule (e.g. active, completed, suspended) — used to filter dashboards to active monitoring obligations."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of sampling schedule (e.g. routine, triggered, special study) — segments monitoring effort by program category."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the sampling schedule (e.g. compliant, violation, at-risk) — primary regulatory risk dimension for schedule management."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency (e.g. daily, weekly, quarterly, annual) — used to segment schedules by monitoring intensity and regulatory requirement."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample required by the schedule (e.g. distribution, entry point, source water) — segments monitoring by regulatory program location type."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the schedule (e.g. high, medium, low) — used to triage compliance risk and allocate field resources."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Boolean flag indicating whether the schedule has a monitoring violation — direct compliance risk indicator for regulatory reporting."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Boolean flag indicating whether the schedule has a seasonal adjustment — used to account for seasonal monitoring waivers in compliance calculations."
    - name: "monitoring_period_start_date"
      expr: monitoring_period_start_date
      comment: "Start date of the monitoring period — time dimension for aligning schedule compliance with regulatory reporting periods."
  measures:
    - name: "total_sampling_schedules"
      expr: COUNT(1)
      comment: "Total number of active sampling schedules — baseline metric for monitoring program scope and regulatory obligation inventory."
    - name: "schedule_violation_count"
      expr: SUM(CAST(violation_flag AS INT))
      comment: "Number of sampling schedules with a monitoring violation — direct regulatory non-compliance count; each violation may require primacy agency notification."
    - name: "schedule_violation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(violation_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sampling schedules with a monitoring violation — compliance program health KPI used by compliance directors and regulators."
    - name: "avg_cost_per_sample"
      expr: AVG(CAST(cost_per_sample AS DOUBLE))
      comment: "Average cost per sample across all schedules — financial efficiency KPI for laboratory and field sampling budget management."
    - name: "total_sampling_cost"
      expr: SUM(CAST(cost_per_sample AS DOUBLE))
      comment: "Total estimated sampling cost across all schedules — budget planning metric for compliance program financial management."
    - name: "avg_sample_volume_ml"
      expr: AVG(CAST(sample_volume_ml AS DOUBLE))
      comment: "Average required sample volume in mL — used for container procurement planning and laboratory capacity management."
    - name: "schedules_with_compliance_deadline_overdue_count"
      expr: SUM(CASE WHEN compliance_deadline_date < CURRENT_DATE() AND compliance_status != 'compliant' THEN 1 ELSE 0 END)
      comment: "Number of schedules past their compliance deadline that are not yet compliant — urgent regulatory risk metric requiring immediate management escalation."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_sampling_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling point network KPIs covering monitoring location coverage, operational status, and geographic distribution. Used by water quality managers and GIS analysts to optimize the monitoring network and ensure regulatory coverage across the distribution system."
  source: "`water_utilities_ecm`.`quality`.`sampling_point`"
  dimensions:
    - name: "sampling_point_status"
      expr: sampling_point_status
      comment: "Operational status of the sampling point (e.g. active, inactive, decommissioned) — used to filter to active monitoring locations."
    - name: "location_type"
      expr: location_type
      comment: "Type of sampling location (e.g. entry point, distribution, source water, treatment effluent) — segments monitoring network by regulatory program location category."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source water type served by the sampling point (e.g. surface water, groundwater, GWUDI) — used to apply correct regulatory monitoring requirements."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Pressure zone in which the sampling point is located — used to analyze water quality variation across hydraulic zones in the distribution system."
    - name: "treatment_stage"
      expr: treatment_stage
      comment: "Treatment stage at which the sampling point is located (e.g. raw, settled, filtered, finished) — enables treatment process performance analysis."
    - name: "primary_contaminant_group"
      expr: primary_contaminant_group
      comment: "Primary contaminant group monitored at this point (e.g. microbial, disinfection byproducts, inorganics) — used to segment monitoring network by regulatory program."
    - name: "ccr_reporting_flag"
      expr: ccr_reporting_flag
      comment: "Boolean flag indicating whether this sampling point contributes to Consumer Confidence Report data — used to identify CCR-relevant monitoring locations."
    - name: "dmr_reporting_flag"
      expr: dmr_reporting_flag
      comment: "Boolean flag indicating whether this sampling point contributes to Discharge Monitoring Report data — used to identify NPDES-relevant monitoring locations."
    - name: "regulatory_zone"
      expr: regulatory_zone
      comment: "Regulatory zone designation for the sampling point — used to align monitoring locations with primacy agency geographic reporting zones."
  measures:
    - name: "total_sampling_points"
      expr: COUNT(1)
      comment: "Total number of sampling points in the monitoring network — baseline metric for monitoring network coverage and regulatory location inventory."
    - name: "active_sampling_point_count"
      expr: SUM(CASE WHEN sampling_point_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active sampling points — operational network size metric used to verify adequate monitoring coverage for regulatory compliance."
    - name: "ccr_reporting_point_count"
      expr: SUM(CAST(ccr_reporting_flag AS INT))
      comment: "Number of sampling points contributing to Consumer Confidence Report — used to verify CCR monitoring network completeness for annual report preparation."
    - name: "dmr_reporting_point_count"
      expr: SUM(CAST(dmr_reporting_flag AS INT))
      comment: "Number of sampling points contributing to Discharge Monitoring Reports — used to verify NPDES permit monitoring network completeness."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in GPM across sampling points — used to assess hydraulic loading at monitoring locations and prioritize high-flow monitoring points."
    - name: "avg_residence_time_hours"
      expr: AVG(CAST(residence_time_hours AS DOUBLE))
      comment: "Average water residence time in hours at sampling points — used to assess disinfection byproduct formation risk and distribution system age-of-water management."
    - name: "overdue_sample_point_count"
      expr: SUM(CASE WHEN next_scheduled_sample_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of sampling points where the next scheduled sample date is past due — operational compliance risk metric requiring immediate field dispatch."
    - name: "avg_elevation_ft"
      expr: AVG(CAST(elevation_ft AS DOUBLE))
      comment: "Average elevation in feet of sampling points — used in hydraulic modeling and pressure zone analysis to understand monitoring network topographic distribution."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_contaminant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contaminant regulatory profile KPIs covering MCL/MCLG thresholds, treatment technique requirements, and regulatory program coverage. Used by regulatory affairs and water quality teams to manage the contaminant monitoring portfolio and assess regulatory risk exposure."
  source: "`water_utilities_ecm`.`quality`.`contaminant`"
  dimensions:
    - name: "contaminant_type"
      expr: contaminant_type
      comment: "Type of contaminant (e.g. microbiological, chemical, radiological, disinfection byproduct) — primary segmentation for regulatory program management."
    - name: "contaminant_status"
      expr: contaminant_status
      comment: "Regulatory status of the contaminant (e.g. regulated, candidate, unregulated) — used to track emerging contaminant risk and regulatory pipeline."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program governing the contaminant (e.g. SDWA, NPDES, RCRA) — used to segment contaminant portfolio by regulatory framework."
    - name: "health_effect_category"
      expr: health_effect_category
      comment: "Health effect category associated with the contaminant (e.g. carcinogen, neurotoxin, gastrointestinal) — used to prioritize public health risk management."
    - name: "public_notification_tier"
      expr: public_notification_tier
      comment: "Public notification tier required upon violation (Tier 1, 2, or 3) — used to assess urgency of public communication requirements for each contaminant."
    - name: "treatment_technique_required"
      expr: treatment_technique_required
      comment: "Boolean flag indicating whether a treatment technique is required instead of an MCL — used to segment contaminants by compliance approach."
    - name: "wastewater_parameter"
      expr: wastewater_parameter
      comment: "Boolean flag indicating whether the contaminant is a wastewater parameter — used to separate drinking water and wastewater monitoring portfolios."
    - name: "ccr_reporting_required"
      expr: ccr_reporting_required
      comment: "Boolean flag indicating whether the contaminant must be reported in the Consumer Confidence Report — used to manage CCR content requirements."
    - name: "source_category"
      expr: source_category
      comment: "Source category of the contaminant (e.g. industrial, agricultural, naturally occurring) — used for source water protection planning and risk communication."
  measures:
    - name: "total_regulated_contaminants"
      expr: COUNT(1)
      comment: "Total number of contaminants in the regulatory monitoring portfolio — baseline metric for compliance program scope and monitoring obligation inventory."
    - name: "ccr_reportable_contaminant_count"
      expr: SUM(CAST(ccr_reporting_required AS INT))
      comment: "Number of contaminants required to be reported in the Consumer Confidence Report — used to scope CCR preparation effort and verify report completeness."
    - name: "treatment_technique_contaminant_count"
      expr: SUM(CAST(treatment_technique_required AS INT))
      comment: "Number of contaminants regulated by treatment technique rather than MCL — used to identify contaminants requiring process compliance rather than concentration-based monitoring."
    - name: "avg_mcl_value"
      expr: AVG(CAST(mcl_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level across regulated contaminants — used as a reference baseline for regulatory stringency analysis and treatment target setting."
    - name: "avg_mclg_value"
      expr: AVG(CAST(mclg_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level Goal across regulated contaminants — health-based reference metric; gap between MCL and MCLG indicates residual health risk accepted by regulation."
    - name: "tier1_notification_contaminant_count"
      expr: SUM(CASE WHEN public_notification_tier = 'Tier 1' THEN 1 ELSE 0 END)
      comment: "Number of contaminants requiring Tier 1 (immediate, within 24 hours) public notification upon violation — used to assess acute public health risk exposure in the monitoring portfolio."
    - name: "wastewater_parameter_count"
      expr: SUM(CAST(wastewater_parameter AS INT))
      comment: "Number of contaminants classified as wastewater parameters — used to scope NPDES permit monitoring obligations and effluent quality management."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_water_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water system operational and quality KPIs covering production capacity utilization, water quality parameters, treatment reliability, and compliance status. Used by utility executives and operations directors to monitor system-wide performance and regulatory standing."
  source: "`water_utilities_ecm`.`quality`.`water_system`"
  dimensions:
    - name: "water_system_status"
      expr: water_system_status
      comment: "Operational status of the water system (e.g. active, inactive, emergency) — used to filter dashboards to operational systems."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the water system — primary executive KPI dimension for regulatory risk management."
    - name: "system_type"
      expr: system_type
      comment: "Type of water system (e.g. community water system, non-transient non-community, transient) — used to apply correct regulatory requirements and segment reporting."
    - name: "classification"
      expr: classification
      comment: "Regulatory classification of the water system — used to segment systems by size, treatment complexity, and regulatory tier."
    - name: "source_type"
      expr: source_type
      comment: "Primary source water type (e.g. surface water, groundwater, purchased) — used to apply correct treatment and monitoring requirements."
    - name: "water_quality_category"
      expr: water_quality_category
      comment: "Overall water quality category assigned to the system — executive-level quality rating used for portfolio performance benchmarking."
    - name: "location_state"
      expr: location_state
      comment: "State where the water system is located — used for geographic segmentation and state primacy agency reporting."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the water system is currently active — used to filter analyses to operational systems."
  measures:
    - name: "total_water_systems"
      expr: COUNT(1)
      comment: "Total number of water systems in the portfolio — baseline metric for utility asset inventory and regulatory reporting scope."
    - name: "compliant_system_count"
      expr: SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END)
      comment: "Number of water systems currently in regulatory compliance — executive compliance health metric; non-compliant systems require immediate regulatory response."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of water systems in regulatory compliance — top-level regulatory performance KPI reported to board and regulators."
    - name: "avg_capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_production_mgd AS DOUBLE)) / NULLIF(AVG(CAST(capacity_mgd AS DOUBLE)), 0), 2)
      comment: "Average capacity utilization percentage across water systems — infrastructure planning KPI; high utilization indicates need for capacity expansion investment."
    - name: "total_production_capacity_mgd"
      expr: SUM(CAST(capacity_mgd AS DOUBLE))
      comment: "Total water production capacity in MGD across all systems — strategic infrastructure capacity metric used for long-range planning and regulatory reporting."
    - name: "total_avg_daily_production_mgd"
      expr: SUM(CAST(average_daily_production_mgd AS DOUBLE))
      comment: "Total average daily water production in MGD across all systems — operational throughput metric used for demand management and production planning."
    - name: "avg_chlorine_residual_mg_l"
      expr: AVG(CAST(chlorine_residual_mg_l AS DOUBLE))
      comment: "Average chlorine residual in mg/L across water systems — disinfection effectiveness KPI; values below 0.2 mg/L indicate distribution system vulnerability."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average turbidity in NTU across water systems — treatment performance KPI; elevated values indicate filtration issues requiring operational intervention."
    - name: "avg_total_coliforms_cfu_100ml"
      expr: AVG(CAST(total_coliforms_cfu_100ml AS DOUBLE))
      comment: "Average total coliform concentration across water systems — microbial water quality KPI; any detection triggers Total Coliform Rule response requirements."
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average mean time between failures in hours across water systems — infrastructure reliability KPI used for maintenance program effectiveness evaluation and capital planning."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average mean time to repair in hours across water systems — operational responsiveness KPI; high MTTR indicates maintenance resource or parts supply constraints."
    - name: "systems_with_expired_permits_count"
      expr: SUM(CASE WHEN permit_expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of water systems with expired operating permits — regulatory risk metric requiring immediate permit renewal action to avoid enforcement."
    - name: "systems_overdue_inspection_count"
      expr: SUM(CASE WHEN next_inspection_due < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of water systems past their next scheduled inspection date — compliance risk metric used to prioritize regulatory inspection scheduling."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_online_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online continuous monitoring instrument KPIs covering calibration compliance, operational status, and measurement range utilization. Used by instrumentation and control teams to manage instrument reliability and ensure continuous monitoring data quality for regulatory compliance."
  source: "`water_utilities_ecm`.`quality`.`online_instrument`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument (e.g. online, offline, maintenance, failed) — primary dimension for instrument fleet availability management."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of online instrument (e.g. turbidimeter, chlorine analyzer, pH meter, flow meter) — used to segment instrument fleet by measurement parameter."
    - name: "treatment_stage"
      expr: treatment_stage
      comment: "Treatment stage where the instrument is installed (e.g. raw water, filter effluent, clearwell) — used to analyze instrument coverage by treatment process stage."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for instrument maintenance — used to allocate calibration workload and track departmental instrument management performance."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the instrument is used for regulatory compliance monitoring — used to prioritize maintenance and calibration of compliance-critical instruments."
    - name: "installation_date"
      expr: installation_date
      comment: "Date the instrument was installed — used to calculate instrument age and plan lifecycle replacement."
  measures:
    - name: "total_online_instruments"
      expr: COUNT(1)
      comment: "Total number of online monitoring instruments in the fleet — baseline metric for continuous monitoring network coverage."
    - name: "online_instrument_count"
      expr: SUM(CASE WHEN operational_status = 'online' THEN 1 ELSE 0 END)
      comment: "Number of instruments currently online and operational — fleet availability metric; low online count indicates monitoring coverage gaps requiring immediate maintenance response."
    - name: "instrument_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'online' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instruments currently online — continuous monitoring uptime KPI; low availability may create regulatory data gaps for SWTR and other continuous monitoring requirements."
    - name: "regulatory_compliance_instrument_count"
      expr: SUM(CAST(regulatory_compliance_flag AS INT))
      comment: "Number of instruments designated for regulatory compliance monitoring — used to scope compliance monitoring network and prioritize maintenance resources."
    - name: "overdue_calibration_count"
      expr: SUM(CASE WHEN next_calibration_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of instruments past their calibration due date — data quality risk metric; uncalibrated instruments produce unreliable data that may invalidate regulatory compliance records."
    - name: "calibration_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN next_calibration_due_date >= CURRENT_DATE() THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instruments with current (non-overdue) calibration — instrument quality assurance KPI directly affecting regulatory data defensibility."
    - name: "avg_measurement_range_span"
      expr: AVG(CAST(measurement_range_max AS DOUBLE) - CAST(measurement_range_min AS DOUBLE))
      comment: "Average measurement range span across instruments — used to assess instrument suitability for expected concentration ranges and identify range mismatch issues."
    - name: "instruments_under_warranty_count"
      expr: SUM(CASE WHEN warranty_expiration_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of instruments still under manufacturer warranty — asset management metric used to optimize maintenance cost by leveraging warranty coverage."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`quality_ccr_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer Confidence Report (CCR) period KPIs tracking report preparation status, violation counts, and public communication compliance. Used by regulatory affairs managers to ensure annual CCR obligations are met and public notification requirements are fulfilled."
  source: "`water_utilities_ecm`.`quality`.`ccr_period`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the CCR report (e.g. draft, submitted, certified, distributed) — tracks CCR lifecycle stage for compliance deadline management."
    - name: "report_year"
      expr: report_year
      comment: "Calendar year covered by the CCR report — primary time dimension for year-over-year CCR compliance trend analysis."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method used to distribute the CCR to customers (e.g. mail, online, newspaper insert) — used to track distribution compliance and accessibility."
    - name: "certification_method"
      expr: certification_method
      comment: "Method used to certify the CCR to the primacy agency — used to verify certification compliance with state-specific requirements."
    - name: "primacy_agency"
      expr: primacy_agency
      comment: "State primacy agency to which the CCR is submitted — used to segment CCR compliance by regulatory jurisdiction."
    - name: "health_effects_language_included_flag"
      expr: health_effects_language_included_flag
      comment: "Boolean flag indicating whether required health effects language was included in the CCR — used to verify mandatory content compliance."
    - name: "language_accessibility_provided_flag"
      expr: language_accessibility_provided_flag
      comment: "Boolean flag indicating whether language accessibility (translation) was provided — used to verify compliance with multilingual community notification requirements."
    - name: "lead_copper_educational_information_flag"
      expr: lead_copper_educational_information_flag
      comment: "Boolean flag indicating whether Lead and Copper Rule educational information was included — mandatory CCR content requirement under LCR revisions."
    - name: "publication_date"
      expr: publication_date
      comment: "Date the CCR was published and made available to customers — used to verify compliance with the July 1 annual publication deadline."
  measures:
    - name: "total_ccr_periods"
      expr: COUNT(1)
      comment: "Total number of CCR reporting periods — baseline metric for CCR program scope across water systems and reporting years."
    - name: "certified_ccr_count"
      expr: SUM(CASE WHEN report_status = 'certified' THEN 1 ELSE 0 END)
      comment: "Number of CCR periods with certified reports — compliance completion metric; uncertified reports represent regulatory violations requiring immediate action."
    - name: "ccr_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN report_status = 'certified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCR periods with certified reports — annual regulatory compliance rate KPI reported to utility leadership and regulators."
    - name: "health_effects_language_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(health_effects_language_included_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCRs that included required health effects language — mandatory content compliance rate; failures constitute regulatory violations."
    - name: "language_accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(language_accessibility_provided_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCRs that provided language accessibility for non-English speaking communities — environmental justice compliance metric."
    - name: "lead_copper_education_inclusion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(lead_copper_educational_information_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCRs that included Lead and Copper Rule educational information — LCR revision compliance rate; required for all community water systems."
    - name: "ccr_published_on_time_count"
      expr: SUM(CASE WHEN publication_date <= DATE(CONCAT(report_year, '-07-01')) THEN 1 ELSE 0 END)
      comment: "Number of CCRs published by the July 1 regulatory deadline — timeliness compliance metric; late publication is a regulatory violation requiring primacy agency notification."
$$;