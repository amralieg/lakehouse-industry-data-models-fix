-- Metric views for domain: quality | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_analytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core water-quality analytical results KPIs. Tracks compliance exceedance rates, detection rates, PFAS burden, hazard quotients, and percent recovery to steer laboratory quality assurance and regulatory compliance programmes."
  source: "`vibe_water_utilities_v1`.`quality`.`analytical_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Calendar date the laboratory analysis was performed — enables trend analysis over time."
    - name: "analysis_year_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month-level time bucket for rolling compliance and quality trend reporting."
    - name: "analytical_method"
      expr: analytical_method
      comment: "Laboratory analytical method used (e.g. EPA 537.1, SM 2130B) — identifies method-level quality patterns."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction (state/country code) — enables cross-jurisdiction compliance benchmarking."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g. SDWA, EU DWD) — segments results by applicable rule set."
    - name: "result_status"
      expr: result_status
      comment: "Current status of the analytical result (e.g. Accepted, Rejected, Pending) — filters to validated data."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix type (e.g. drinking water, source water, treated effluent) — key grouping for quality benchmarking."
    - name: "pfas_compound_class"
      expr: pfas_compound_class
      comment: "PFAS compound class (e.g. PFOA, PFOS, GenX) — critical for PFAS regulatory reporting and risk stratification."
    - name: "data_validation_level"
      expr: data_validation_level
      comment: "Level of data validation applied to the result — distinguishes field-screened from fully validated laboratory data."
    - name: "compliance_exceeded"
      expr: compliance_exceeded
      comment: "Boolean flag indicating whether the result exceeded the applicable regulatory limit — primary compliance filter."
    - name: "is_pfas_result"
      expr: is_pfas_result
      comment: "Boolean flag indicating the result is for a PFAS compound — enables PFAS-specific programme dashboards."
    - name: "qualifier_code"
      expr: qualifier_code
      comment: "Laboratory qualifier code (e.g. J, U, B) — identifies estimated or non-detect results affecting compliance decisions."
  measures:
    - name: "total_analytical_results"
      expr: COUNT(1)
      comment: "Total number of analytical results processed — baseline throughput measure for laboratory capacity planning."
    - name: "compliance_exceedance_count"
      expr: COUNT(CASE WHEN compliance_exceeded = TRUE THEN 1 END)
      comment: "Number of results that exceeded the applicable regulatory limit — primary regulatory risk indicator."
    - name: "compliance_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_exceeded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analytical results exceeding regulatory limits — key KPI for executive compliance dashboards and board reporting."
    - name: "pfas_result_count"
      expr: COUNT(CASE WHEN is_pfas_result = TRUE THEN 1 END)
      comment: "Number of PFAS analytical results — tracks PFAS monitoring programme scope and regulatory exposure."
    - name: "avg_hazard_quotient"
      expr: ROUND(AVG(CAST(hazard_quotient AS DOUBLE)), 4)
      comment: "Average hazard quotient across results — values above 1.0 signal unacceptable health risk; drives treatment investment decisions."
    - name: "max_hazard_quotient"
      expr: ROUND(MAX(CAST(hazard_quotient AS DOUBLE)), 4)
      comment: "Maximum hazard quotient observed — worst-case health risk indicator used in public notification and enforcement decisions."
    - name: "avg_percent_recovery"
      expr: ROUND(AVG(CAST(percent_recovery AS DOUBLE)), 2)
      comment: "Average laboratory percent recovery — measures analytical accuracy; values outside 70–130% indicate QA/QC failures requiring corrective action."
    - name: "avg_eu_sum20_contribution_ng_l"
      expr: ROUND(AVG(CAST(eu_sum20_contribution_ng_l AS DOUBLE)), 4)
      comment: "Average EU Sum-of-20 PFAS contribution in ng/L — tracks proximity to the 100 ng/L EU DWD parametric limit for PFAS sum."
    - name: "total_eu_sum20_contribution_ng_l"
      expr: ROUND(SUM(CAST(eu_sum20_contribution_ng_l AS DOUBLE)), 4)
      comment: "Total EU Sum-of-20 PFAS contribution across all results — aggregate PFAS burden indicator for EU regulatory reporting."
    - name: "avg_result_value"
      expr: ROUND(AVG(CAST(result_value AS DOUBLE)), 4)
      comment: "Average measured contaminant concentration — baseline quality level indicator for trend and benchmarking analysis."
    - name: "avg_mcl_value"
      expr: ROUND(AVG(CAST(mcl_value AS DOUBLE)), 4)
      comment: "Average Maximum Contaminant Level applicable to results — contextualises measured concentrations against regulatory thresholds."
    - name: "hold_time_non_compliant_count"
      expr: COUNT(CASE WHEN hold_time_compliant = FALSE THEN 1 END)
      comment: "Number of results where sample hold time was exceeded — indicates sample integrity failures that may invalidate compliance data."
    - name: "hold_time_non_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_time_compliant = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results with hold-time violations — operational quality metric for field sampling and chain-of-custody management."
    - name: "distinct_contaminants_tested"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants tested — measures breadth of monitoring programme coverage against regulatory requirements."
    - name: "distinct_water_samples_analysed"
      expr: COUNT(DISTINCT water_sample_id)
      comment: "Number of distinct water samples with analytical results — measures sampling programme throughput and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_exceedance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory exceedance event KPIs. Tracks the volume, severity, resolution status, and public notification obligations of contaminant limit exceedances — the primary operational risk register for water quality compliance."
  source: "`vibe_water_utilities_v1`.`quality`.`exceedance`"
  dimensions:
    - name: "exceedance_date"
      expr: exceedance_date
      comment: "Date the exceedance was recorded — enables time-series trend analysis of compliance events."
    - name: "exceedance_year_month"
      expr: DATE_TRUNC('MONTH', exceedance_date)
      comment: "Month-level bucket for exceedance trend reporting and regulatory period analysis."
    - name: "exceedance_type"
      expr: exceedance_type
      comment: "Type of exceedance (e.g. MCL, Action Level, Treatment Technique) — classifies regulatory severity and response obligation."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the exceedance (e.g. Critical, High, Medium, Low) — drives prioritisation of corrective actions."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status (e.g. Open, Resolved, Under Investigation) — tracks remediation progress."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the contaminant or parameter that was exceeded — identifies which substances drive the most compliance risk."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating a formal corrective action is mandated — segments exceedances requiring regulatory response."
    - name: "public_notification_required"
      expr: public_notification_required
      comment: "Boolean flag indicating public notification is legally required — critical for public health and regulatory obligation tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the exceedance value — provides context for cross-contaminant comparisons."
  measures:
    - name: "total_exceedances"
      expr: COUNT(1)
      comment: "Total number of exceedance events — primary regulatory risk volume indicator for executive and board reporting."
    - name: "open_exceedances"
      expr: COUNT(CASE WHEN resolution_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of unresolved exceedance events — active compliance liability count requiring management attention."
    - name: "resolved_exceedances"
      expr: COUNT(CASE WHEN resolution_status IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of exceedances that have been resolved — measures remediation effectiveness."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status IN ('Resolved', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceedances resolved — key operational KPI for compliance programme effectiveness; low rates signal systemic treatment or operational failures."
    - name: "public_notification_required_count"
      expr: COUNT(CASE WHEN public_notification_required = TRUE THEN 1 END)
      comment: "Number of exceedances requiring public notification — directly tied to regulatory obligation fulfilment and public health risk."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of exceedances mandating formal corrective action — drives capital and operational investment decisions."
    - name: "critical_exceedances"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical-severity exceedances — highest-priority risk indicator for executive escalation and emergency response."
    - name: "avg_measured_value"
      expr: ROUND(AVG(CAST(measured_value AS DOUBLE)), 4)
      comment: "Average measured contaminant concentration at exceedance — indicates typical magnitude of violations for treatment optimisation."
    - name: "max_measured_value"
      expr: ROUND(MAX(CAST(measured_value AS DOUBLE)), 4)
      comment: "Maximum measured contaminant concentration across exceedances — worst-case exposure indicator for public health risk assessment."
    - name: "distinct_contaminants_exceeded"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants with exceedances — breadth-of-risk indicator; high counts signal systemic source water or treatment issues."
    - name: "distinct_sampling_points_with_exceedances"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling locations with exceedances — geographic spread of compliance risk; drives targeted infrastructure investment."
    - name: "avg_days_to_resolution"
      expr: ROUND(AVG(CAST(DATEDIFF(resolution_date, exceedance_date) AS DOUBLE)), 1)
      comment: "Average number of days from exceedance detection to resolution — operational efficiency KPI for compliance response; regulatory deadlines are typically 30–90 days."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_lead_copper_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead and Copper Rule (LCR) monitoring KPIs. Tracks action level exceedances, 90th percentile sampling, customer notification compliance, and corrosion control effectiveness — critical for public health protection and EPA/state LCR regulatory reporting."
  source: "`vibe_water_utilities_v1`.`quality`.`lead_copper_result`"
  dimensions:
    - name: "sample_collection_date"
      expr: sample_collection_date
      comment: "Date the lead/copper sample was collected — enables monitoring period and trend analysis."
    - name: "sample_collection_year_month"
      expr: DATE_TRUNC('MONTH', sample_collection_date)
      comment: "Month-level bucket for LCR monitoring period reporting."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line at the sample site (e.g. Lead, Galvanised, Copper, Plastic) — primary risk stratification dimension for LCR compliance."
    - name: "site_tier"
      expr: site_tier
      comment: "LCR site tier classification (Tier 1, 2, 3) — regulatory sampling priority; Tier 1 sites carry highest lead risk."
    - name: "corrosion_control_treatment_status"
      expr: corrosion_control_treatment_status
      comment: "Status of corrosion control treatment at the site — links treatment effectiveness to lead/copper levels."
    - name: "lead_action_level_exceeded"
      expr: lead_action_level_exceeded
      comment: "Boolean flag for lead action level exceedance (>15 ppb) — primary LCR compliance indicator."
    - name: "copper_action_level_exceeded"
      expr: copper_action_level_exceeded
      comment: "Boolean flag for copper action level exceedance (>1,300 ppb) — secondary LCR compliance indicator."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting for this result — tracks submission completeness to state primacy agency."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of the sample result — filters to validated data for compliance calculations."
    - name: "analysis_method"
      expr: analysis_method
      comment: "Analytical method used for lead/copper analysis — ensures method-specific compliance with LCR analytical requirements."
  measures:
    - name: "total_lcr_samples"
      expr: COUNT(1)
      comment: "Total number of Lead and Copper Rule samples collected — baseline measure for monitoring programme completeness."
    - name: "lead_action_level_exceedance_count"
      expr: COUNT(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 END)
      comment: "Number of samples exceeding the lead action level (15 ppb) — primary LCR compliance trigger; exceedances mandate corrosion control and public notification."
    - name: "lead_action_level_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_action_level_exceeded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LCR samples exceeding the lead action level — key public health KPI; if 90th percentile exceeds 15 ppb, system-wide corrosion control is required."
    - name: "copper_action_level_exceedance_count"
      expr: COUNT(CASE WHEN copper_action_level_exceeded = TRUE THEN 1 END)
      comment: "Number of samples exceeding the copper action level (1,300 ppb) — LCR compliance trigger for corrosion control review."
    - name: "copper_action_level_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN copper_action_level_exceeded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LCR samples exceeding the copper action level — operational indicator for corrosion control programme effectiveness."
    - name: "avg_lead_result_ppb"
      expr: ROUND(AVG(CAST(lead_result_ppb AS DOUBLE)), 3)
      comment: "Average lead concentration in ppb across all LCR samples — baseline lead exposure level indicator for trend monitoring."
    - name: "max_lead_result_ppb"
      expr: ROUND(MAX(CAST(lead_result_ppb AS DOUBLE)), 3)
      comment: "Maximum lead concentration observed in ppb — worst-case exposure indicator; values above 15 ppb trigger regulatory action."
    - name: "avg_copper_result_ppb"
      expr: ROUND(AVG(CAST(copper_result_ppb AS DOUBLE)), 3)
      comment: "Average copper concentration in ppb — baseline corrosion indicator for treatment optimisation decisions."
    - name: "customer_notification_sent_count"
      expr: COUNT(CASE WHEN customer_notification_sent = TRUE THEN 1 END)
      comment: "Number of customers notified of lead/copper exceedances — measures fulfilment of mandatory public notification obligations."
    - name: "customer_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notification_sent = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN lead_action_level_exceeded = TRUE OR copper_action_level_exceeded = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of action-level exceedances where customer notification was sent — regulatory obligation fulfilment rate; failure to notify is a separate LCR violation."
    - name: "holding_time_non_compliant_count"
      expr: COUNT(CASE WHEN holding_time_compliant = FALSE THEN 1 END)
      comment: "Number of LCR samples with hold-time violations — sample integrity failures that may invalidate compliance data and require re-sampling."
    - name: "samples_included_in_90th_percentile"
      expr: COUNT(CASE WHEN included_in_90th_percentile > 0 THEN 1 END)
      comment: "Number of samples included in the 90th percentile calculation — verifies adequate sample set size for LCR 90th percentile compliance determination."
    - name: "distinct_premises_sampled"
      expr: COUNT(DISTINCT premise_id)
      comment: "Number of distinct premises sampled under LCR — measures geographic coverage of the monitoring programme."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_water_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water sampling programme operational KPIs. Tracks field measurement quality, sample throughput, QC flag rates, and field parameter distributions — drives sampling programme efficiency and field data quality management."
  source: "`vibe_water_utilities_v1`.`quality`.`water_sample`"
  dimensions:
    - name: "collection_date"
      expr: CAST(collection_timestamp AS DATE)
      comment: "Date the water sample was collected — primary time dimension for sampling programme trend analysis."
    - name: "collection_year_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month-level bucket for sampling volume and quality trend reporting."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Sample matrix type (e.g. drinking water, source water, wastewater effluent) — key grouping for programme-level quality benchmarking."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample (e.g. Compliance, Operational, Investigative) — distinguishes regulatory from operational sampling."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (e.g. Collected, Submitted, Analysed, Rejected) — tracks sample lifecycle and identifies bottlenecks."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory programme the sample supports (e.g. SDWA, NPDES, LCR) — enables programme-level compliance tracking."
    - name: "quality_control_flag"
      expr: quality_control_flag
      comment: "Boolean QC flag indicating a quality issue with the sample — filters to flagged samples for investigation."
    - name: "requested_analysis_group"
      expr: requested_analysis_group
      comment: "Group of analyses requested for the sample (e.g. Metals, Organics, Microbiology) — enables workload and cost analysis by analysis type."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of collection — contextualises field parameter anomalies (e.g. turbidity spikes during storm events)."
  measures:
    - name: "total_samples_collected"
      expr: COUNT(1)
      comment: "Total number of water samples collected — baseline throughput measure for sampling programme capacity and scheduling."
    - name: "qc_flagged_sample_count"
      expr: COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END)
      comment: "Number of samples flagged for quality control issues — identifies data integrity problems that may compromise compliance reporting."
    - name: "qc_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_control_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with QC flags — field quality KPI; high rates indicate equipment, training, or procedural issues requiring corrective action."
    - name: "avg_field_turbidity_ntu"
      expr: ROUND(AVG(CAST(field_turbidity_ntu AS DOUBLE)), 3)
      comment: "Average field turbidity in NTU — key source water quality indicator; elevated turbidity signals treatment challenges and potential pathogen risk."
    - name: "max_field_turbidity_ntu"
      expr: ROUND(MAX(CAST(field_turbidity_ntu AS DOUBLE)), 3)
      comment: "Maximum field turbidity observed in NTU — worst-case turbidity event indicator; values above regulatory limits trigger treatment response."
    - name: "avg_field_chlorine_residual_mg_l"
      expr: ROUND(AVG(CAST(field_chlorine_residual_mg_l AS DOUBLE)), 3)
      comment: "Average field chlorine residual in mg/L — distribution system disinfection effectiveness indicator; values below 0.2 mg/L signal microbial risk."
    - name: "avg_field_ph"
      expr: ROUND(AVG(CAST(field_ph AS DOUBLE)), 2)
      comment: "Average field pH — corrosion control and disinfection effectiveness indicator; pH outside 6.5–8.5 range triggers regulatory review."
    - name: "avg_field_temperature_c"
      expr: ROUND(AVG(CAST(field_temperature_c AS DOUBLE)), 2)
      comment: "Average field water temperature in Celsius — affects disinfection efficacy and microbial growth risk; drives seasonal treatment adjustments."
    - name: "avg_field_dissolved_oxygen_mg_l"
      expr: ROUND(AVG(CAST(field_dissolved_oxygen_mg_l AS DOUBLE)), 3)
      comment: "Average field dissolved oxygen in mg/L — source water quality and treatment process health indicator."
    - name: "distinct_sampling_points_sampled"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling points with samples collected — measures spatial coverage of the monitoring programme."
    - name: "avg_composite_duration_hours"
      expr: ROUND(AVG(CAST(composite_duration_hours AS DOUBLE)), 2)
      comment: "Average composite sample duration in hours — verifies composite sampling protocols are followed per regulatory requirements."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_sampling_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling schedule compliance and programme management KPIs. Tracks schedule adherence, budget utilisation, violation flags, and monitoring period coverage — drives regulatory compliance programme governance and resource allocation."
  source: "`vibe_water_utilities_v1`.`quality`.`sampling_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the sampling schedule (e.g. Active, Suspended, Completed) — primary filter for active programme management."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of sampling schedule (e.g. Routine, Triggered, Investigative) — classifies monitoring obligations by regulatory driver."
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Required sampling frequency (e.g. Daily, Weekly, Quarterly, Annual) — enables workload planning and compliance gap analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the schedule (e.g. Compliant, Non-Compliant, At Risk) — primary regulatory programme health indicator."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the sampling schedule — enables resource allocation to highest-risk monitoring obligations."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample required (e.g. Grab, Composite, Continuous) — affects field resource and laboratory planning."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Boolean flag indicating a monitoring violation exists for this schedule — primary compliance alert dimension."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Boolean flag indicating seasonal adjustments apply — identifies schedules with variable monitoring requirements."
    - name: "regulatory_rule"
      expr: regulatory_rule
      comment: "Specific regulatory rule driving the monitoring requirement (e.g. Stage 2 DBPR, LCR, TCR) — enables rule-level compliance tracking."
    - name: "monitoring_period_start_date"
      expr: monitoring_period_start_date
      comment: "Start date of the monitoring period — enables period-over-period compliance comparison."
  measures:
    - name: "total_sampling_schedules"
      expr: COUNT(1)
      comment: "Total number of active sampling schedules — baseline measure for monitoring programme scope and regulatory obligation inventory."
    - name: "violation_flagged_schedules"
      expr: COUNT(CASE WHEN violation_flag = TRUE THEN 1 END)
      comment: "Number of sampling schedules with active monitoring violations — primary regulatory non-compliance count requiring immediate management action."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sampling schedules with monitoring violations — programme-level compliance health KPI for executive reporting."
    - name: "total_annual_budget_allocation"
      expr: ROUND(SUM(CAST(annual_budget_allocation AS DOUBLE)), 2)
      comment: "Total annual budget allocated across all sampling schedules — financial planning KPI for water quality monitoring programme investment."
    - name: "avg_cost_per_sample"
      expr: ROUND(AVG(CAST(cost_per_sample AS DOUBLE)), 2)
      comment: "Average cost per sample across schedules — efficiency benchmark for laboratory procurement and sampling programme cost management."
    - name: "total_cost_per_sample"
      expr: ROUND(SUM(CAST(cost_per_sample AS DOUBLE)), 2)
      comment: "Total cost per sample summed across schedules — aggregate cost exposure indicator for budget forecasting."
    - name: "non_compliant_schedule_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of schedules in non-compliant status — direct regulatory risk count; each non-compliant schedule represents a potential enforcement action."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sampling schedules in compliant status — headline programme compliance rate for board and regulatory agency reporting."
    - name: "avg_sample_volume_ml"
      expr: ROUND(AVG(CAST(sample_volume_ml AS DOUBLE)), 2)
      comment: "Average required sample volume in mL — operational planning metric for field equipment and container procurement."
    - name: "distinct_sampling_points_scheduled"
      expr: COUNT(DISTINCT sampling_point_id)
      comment: "Number of distinct sampling points covered by active schedules — measures spatial coverage of the regulatory monitoring network."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_contaminant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contaminant regulatory profile KPIs. Tracks the regulatory landscape of monitored contaminants including PFAS classification, MCL/MCLG values, EU DWD parametric limits, and treatment technique requirements — informs regulatory strategy, treatment investment, and compliance programme design."
  source: "`vibe_water_utilities_v1`.`quality`.`contaminant`"
  dimensions:
    - name: "contaminant_type"
      expr: contaminant_type
      comment: "Type of contaminant (e.g. Inorganic, Organic, Microbiological, Radiological) — primary classification for regulatory programme segmentation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g. SDWA, EU DWD, WHO) — enables cross-jurisdictional regulatory gap analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction code — enables state/country-level regulatory requirement comparison."
    - name: "contaminant_status"
      expr: contaminant_status
      comment: "Regulatory status of the contaminant (e.g. Regulated, Candidate, Unregulated) — tracks emerging contaminant regulatory pipeline."
    - name: "health_effect_category"
      expr: health_effect_category
      comment: "Health effect category (e.g. Carcinogen, Neurotoxin, Endocrine Disruptor) — risk-based grouping for public health prioritisation."
    - name: "is_pfas"
      expr: is_pfas
      comment: "Boolean flag indicating the contaminant is a PFAS compound — enables PFAS-specific regulatory and treatment programme analysis."
    - name: "pfas_class"
      expr: pfas_class
      comment: "PFAS compound class (e.g. PFOA, PFOS, PFNA) — granular PFAS classification for EU Sum-of-20 and US MCL compliance tracking."
    - name: "eu_sum20_member"
      expr: eu_sum20_member
      comment: "Boolean flag indicating membership in the EU Sum-of-20 PFAS group — critical for EU DWD parametric value compliance."
    - name: "treatment_technique_required"
      expr: treatment_technique_required
      comment: "Boolean flag indicating a treatment technique is required instead of an MCL — identifies contaminants requiring process-based compliance."
    - name: "source_category"
      expr: source_category
      comment: "Source category of the contaminant (e.g. Industrial, Agricultural, Natural) — informs source water protection and risk management strategies."
    - name: "public_notification_tier"
      expr: public_notification_tier
      comment: "Public notification tier (Tier 1, 2, 3) — determines urgency and method of public notification upon exceedance."
  measures:
    - name: "total_regulated_contaminants"
      expr: COUNT(1)
      comment: "Total number of contaminants in the regulatory profile — measures scope of the monitoring and compliance programme."
    - name: "pfas_contaminant_count"
      expr: COUNT(CASE WHEN is_pfas = TRUE THEN 1 END)
      comment: "Number of PFAS contaminants in the regulatory profile — tracks PFAS programme scope as regulations rapidly expand."
    - name: "treatment_technique_required_count"
      expr: COUNT(CASE WHEN treatment_technique_required = TRUE THEN 1 END)
      comment: "Number of contaminants requiring treatment technique compliance — identifies process-based obligations that drive capital treatment investment."
    - name: "ccr_reporting_required_count"
      expr: COUNT(CASE WHEN ccr_reporting_required = TRUE THEN 1 END)
      comment: "Number of contaminants requiring Consumer Confidence Report disclosure — measures CCR reporting burden and public communication obligations."
    - name: "avg_mcl_value"
      expr: ROUND(AVG(CAST(mcl_value AS DOUBLE)), 6)
      comment: "Average Maximum Contaminant Level across regulated contaminants — baseline regulatory stringency indicator for treatment design benchmarking."
    - name: "avg_mclg_value"
      expr: ROUND(AVG(CAST(mclg_value AS DOUBLE)), 6)
      comment: "Average Maximum Contaminant Level Goal — health-based benchmark; gap between MCLG and MCL indicates residual health risk accepted by regulation."
    - name: "avg_eu_dwd_parametric_value_ng_l"
      expr: ROUND(AVG(CAST(eu_dwd_parametric_value_ng_l AS DOUBLE)), 4)
      comment: "Average EU Drinking Water Directive parametric value in ng/L — EU regulatory stringency benchmark for PFAS and emerging contaminants."
    - name: "avg_who_guideline_value"
      expr: ROUND(AVG(CAST(who_guideline_value AS DOUBLE)), 6)
      comment: "Average WHO guideline value — international health-based benchmark; comparison with MCL reveals regulatory gaps relative to WHO recommendations."
    - name: "eu_sum20_member_count"
      expr: COUNT(CASE WHEN eu_sum20_member = TRUE THEN 1 END)
      comment: "Number of contaminants in the EU Sum-of-20 PFAS group — determines scope of EU DWD Sum-of-20 parametric value compliance obligation."
    - name: "hazard_index_member_count"
      expr: COUNT(CASE WHEN hazard_index_member = TRUE THEN 1 END)
      comment: "Number of contaminants included in the US EPA Hazard Index calculation — measures scope of cumulative risk assessment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_water_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water system operational and compliance health KPIs. Tracks system capacity utilisation, water quality parameters, compliance status, and reliability metrics across the utility's water systems — primary executive dashboard for system-level performance management."
  source: "`vibe_water_utilities_v1`.`quality`.`water_system`"
  dimensions:
    - name: "system_type"
      expr: system_type
      comment: "Type of water system (e.g. Community, Non-Transient Non-Community, Transient) — primary regulatory classification driving monitoring requirements."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the water system — primary regulatory health indicator for executive and regulatory reporting."
    - name: "water_quality_category"
      expr: water_quality_category
      comment: "Overall water quality category assigned to the system — high-level quality classification for portfolio management."
    - name: "primary_source_type"
      expr: primary_source_type
      comment: "Primary water source type (e.g. Surface Water, Groundwater, Purchased) — drives treatment requirements and source water protection obligations."
    - name: "location_state"
      expr: location_state
      comment: "State where the water system is located — enables geographic compliance and performance benchmarking."
    - name: "location_city"
      expr: location_city
      comment: "City where the water system is located — granular geographic dimension for local performance management."
    - name: "water_system_status"
      expr: water_system_status
      comment: "Operational status of the water system (e.g. Active, Inactive, Decommissioned) — filters to operational systems for performance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating the system is currently active — primary filter for operational portfolio analysis."
    - name: "classification"
      expr: classification
      comment: "Regulatory classification of the water system — determines applicable treatment and monitoring standards."
  measures:
    - name: "total_water_systems"
      expr: COUNT(1)
      comment: "Total number of water systems in the portfolio — baseline measure for utility scale and regulatory obligation scope."
    - name: "active_water_systems"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active water systems — operational portfolio size for capacity and compliance planning."
    - name: "non_compliant_systems"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of water systems in non-compliant status — primary regulatory risk count; each non-compliant system represents enforcement exposure."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active water systems in compliant status — headline utility compliance rate for board, regulator, and investor reporting."
    - name: "total_capacity_mgd"
      expr: ROUND(SUM(CAST(capacity_mgd AS DOUBLE)), 2)
      comment: "Total treatment/distribution capacity in million gallons per day — strategic capacity planning KPI for infrastructure investment decisions."
    - name: "total_avg_daily_production_mgd"
      expr: ROUND(SUM(CAST(average_daily_production_mgd AS DOUBLE)), 2)
      comment: "Total average daily production across all systems in MGD — operational throughput measure for demand management and capacity planning."
    - name: "avg_capacity_utilisation_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_production_mgd AS DOUBLE)) / NULLIF(AVG(CAST(capacity_mgd AS DOUBLE)), 0), 2)
      comment: "Average capacity utilisation percentage across systems — infrastructure efficiency KPI; high utilisation signals need for capacity expansion investment."
    - name: "avg_turbidity_ntu"
      expr: ROUND(AVG(CAST(turbidity_ntu AS DOUBLE)), 3)
      comment: "Average system turbidity in NTU — treated water quality indicator; values above 1 NTU (surface water) trigger regulatory review."
    - name: "avg_chlorine_residual_mg_l"
      expr: ROUND(AVG(CAST(chlorine_residual_mg_l AS DOUBLE)), 3)
      comment: "Average chlorine residual in mg/L across systems — distribution system disinfection effectiveness KPI; values below 0.2 mg/L signal microbial risk."
    - name: "avg_total_coliforms_cfu_100ml"
      expr: ROUND(AVG(CAST(total_coliforms_cfu_100ml AS DOUBLE)), 3)
      comment: "Average total coliform count in CFU/100mL — microbial water quality indicator; any positive result triggers Total Coliform Rule response."
    - name: "avg_mean_time_between_failures_hours"
      expr: ROUND(AVG(CAST(mean_time_between_failures_hours AS DOUBLE)), 1)
      comment: "Average mean time between failures in hours — system reliability KPI for asset management and maintenance investment decisions."
    - name: "avg_mean_time_to_repair_hours"
      expr: ROUND(AVG(CAST(mean_time_to_repair_hours AS DOUBLE)), 1)
      comment: "Average mean time to repair in hours — operational resilience KPI; high values indicate maintenance resource or supply chain constraints."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_contaminant_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contaminant limit regulatory inventory KPIs. Tracks the portfolio of applicable regulatory limits, variance/waiver status, compliance posture, and limit stringency — informs regulatory strategy, permit management, and treatment investment prioritisation."
  source: "`vibe_water_utilities_v1`.`quality`.`contaminant_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of regulatory limit (e.g. MCL, Action Level, Treatment Technique, Effluent Limit) — classifies the nature of the compliance obligation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status against this limit — primary regulatory risk indicator for the limit portfolio."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the limit applies — enables cross-jurisdictional regulatory burden analysis."
    - name: "jurisdiction_authority"
      expr: jurisdiction_authority
      comment: "Regulatory authority enforcing the limit (e.g. EPA, State Primacy Agency, EU Member State) — identifies enforcement body for compliance management."
    - name: "health_effect_category"
      expr: health_effect_category
      comment: "Health effect category associated with the limit — risk-based grouping for public health prioritisation."
    - name: "sample_location_type"
      expr: sample_location_type
      comment: "Type of sampling location where the limit applies (e.g. Entry Point, Distribution, Source) — determines where compliance monitoring must occur."
    - name: "variance_waiver_flag"
      expr: variance_waiver_flag
      comment: "Boolean flag indicating a variance or waiver is in effect — identifies limits with temporary regulatory relief that may expire."
    - name: "ccr_reporting_required"
      expr: ccr_reporting_required
      comment: "Boolean flag indicating CCR reporting is required for this limit — measures Consumer Confidence Report disclosure obligations."
    - name: "public_notification_tier"
      expr: public_notification_tier
      comment: "Public notification tier for this limit — determines urgency of public communication upon exceedance."
    - name: "averaging_period"
      expr: averaging_period
      comment: "Averaging period for the limit (e.g. Annual, Running Annual Average, 90th Percentile) — affects compliance calculation methodology."
  measures:
    - name: "total_contaminant_limits"
      expr: COUNT(1)
      comment: "Total number of contaminant limits in the regulatory inventory — measures scope of compliance obligations across all permits and programmes."
    - name: "non_compliant_limit_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of contaminant limits currently in non-compliant status — primary regulatory risk count driving enforcement and remediation priorities."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contaminant limits in compliant status — headline regulatory compliance rate for executive and regulatory reporting."
    - name: "variance_waiver_count"
      expr: COUNT(CASE WHEN variance_waiver_flag = TRUE THEN 1 END)
      comment: "Number of limits with active variances or waivers — regulatory risk indicator; variances have expiration dates and may be revoked, exposing the utility to compliance gaps."
    - name: "avg_limit_value"
      expr: ROUND(AVG(CAST(limit_value AS DOUBLE)), 6)
      comment: "Average regulatory limit value across the portfolio — baseline stringency indicator for treatment design and benchmarking."
    - name: "avg_detection_limit_required"
      expr: ROUND(AVG(CAST(detection_limit_required AS DOUBLE)), 6)
      comment: "Average required detection limit — laboratory capability benchmark; ensures analytical methods meet regulatory sensitivity requirements."
    - name: "ccr_reporting_required_count"
      expr: COUNT(CASE WHEN ccr_reporting_required = TRUE THEN 1 END)
      comment: "Number of limits requiring CCR disclosure — measures annual Consumer Confidence Report reporting burden."
    - name: "distinct_contaminants_with_limits"
      expr: COUNT(DISTINCT contaminant_id)
      comment: "Number of distinct contaminants with regulatory limits — measures breadth of the compliance monitoring programme."
$$;