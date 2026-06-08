-- Metric views for domain: treatment | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for finished water production operations — tracks daily output volumes, plant efficiency, water quality compliance, and chemical dosing activity to support executive oversight of treatment plant performance."
  source: "`water_utilities_ecm`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Calendar date of the production record, used for daily and monthly trend analysis."
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month bucket derived from production_date for monthly aggregation and reporting."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Type of treatment process applied (e.g., conventional, membrane, UV) — used to compare efficiency across process technologies."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Primary disinfection method used (e.g., chlorination, UV, ozone) — key dimension for regulatory and operational analysis."
    - name: "production_status"
      expr: production_status
      comment: "Operational status of the production record (e.g., approved, pending, flagged) — used to filter for validated data."
    - name: "shift_code"
      expr: shift_code
      comment: "Operational shift identifier — enables shift-level performance benchmarking."
    - name: "regulatory_exceedance"
      expr: regulatory_exceedance
      comment: "Boolean flag indicating whether a regulatory limit was exceeded during this production period — critical compliance dimension."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the production record — used to exclude suspect readings from KPI calculations."
  measures:
    - name: "total_finished_water_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total volume of finished (treated) water produced in million gallons. Core throughput KPI for capacity planning and regulatory reporting."
    - name: "total_source_water_volume_mg"
      expr: SUM(CAST(source_water_volume_mg AS DOUBLE))
      comment: "Total raw source water volume withdrawn in million gallons. Used with finished water volume to compute plant yield and efficiency."
    - name: "total_volume_pumped_to_distribution_mg"
      expr: SUM(CAST(volume_pumped_to_distribution_mg AS DOUBLE))
      comment: "Total volume of finished water delivered to the distribution system in million gallons — measures actual service delivery output."
    - name: "total_backwash_volume_mg"
      expr: SUM(CAST(backwash_volume_mg AS DOUBLE))
      comment: "Total water volume consumed in filter backwash operations in million gallons — a key non-revenue water loss component."
    - name: "total_plant_ops_water_volume_mg"
      expr: SUM(CAST(plant_ops_water_volume_mg AS DOUBLE))
      comment: "Total water used for plant operations (non-revenue internal use) in million gallons — informs operational water loss tracking."
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (finished water / source water) across production records. Measures how effectively raw water is converted to finished water; low values indicate high process losses."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity in NTU across production records. Primary water quality KPI — regulatory limit is typically 0.3 NTU for filtered systems."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_max_ntu)
      comment: "Maximum turbidity recorded during production periods. Used to identify peak exceedance risk and compliance exposure."
    - name: "avg_cl2_residual_mg_l"
      expr: AVG(CAST(cl2_residual_avg_mg_l AS DOUBLE))
      comment: "Average chlorine residual in finished water (mg/L). Ensures disinfection efficacy and regulatory compliance with minimum residual requirements."
    - name: "min_cl2_residual_mg_l"
      expr: MIN(cl2_residual_min_mg_l)
      comment: "Minimum chlorine residual observed across production records. Critical safety metric — values below regulatory minimums indicate disinfection failure risk."
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average pH of finished water. Regulatory compliance and corrosion control metric — must remain within permitted range."
    - name: "avg_toc_mg_l"
      expr: AVG(CAST(toc_avg_mg_l AS DOUBLE))
      comment: "Average total organic carbon in finished water (mg/L). Indicator of disinfection byproduct formation potential — drives chemical dosing decisions."
    - name: "avg_peak_production_rate_gpm"
      expr: AVG(CAST(peak_production_rate_gpm AS DOUBLE))
      comment: "Average peak production flow rate in gallons per minute. Used to assess capacity utilization relative to design capacity."
    - name: "avg_design_capacity_mgd"
      expr: AVG(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Average design capacity of the facility in million gallons per day. Baseline for capacity utilization ratio calculations."
    - name: "regulatory_exceedance_count"
      expr: COUNT(CASE WHEN regulatory_exceedance = TRUE THEN 1 END)
      comment: "Number of production records with a regulatory exceedance. Tracks compliance failures that require corrective action and public notification."
    - name: "production_record_count"
      expr: COUNT(1)
      comment: "Total number of production records. Used as the denominator for rate and average calculations."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_ct_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CT (Concentration × Time) disinfection compliance KPIs — tracks log inactivation achievement, CT ratio performance, and compliance status against Surface Water Treatment Rule requirements. Critical regulatory reporting domain."
  source: "`water_utilities_ecm`.`treatment`.`ct_compliance_record`"
  dimensions:
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start date of the regulatory reporting period — used for monthly compliance period analysis."
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Month bucket for CT compliance trend analysis and regulatory reporting aggregation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "CT compliance determination (e.g., compliant, non-compliant, pending) — primary regulatory status dimension."
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant used (e.g., free chlorine, chloramine, ozone) — affects CT table requirements and inactivation credit."
    - name: "target_organism"
      expr: target_organism
      comment: "Target pathogen for CT inactivation credit (e.g., Giardia, Cryptosporidium, viruses) — determines required log inactivation."
    - name: "source_water_type"
      expr: source_water_type
      comment: "Classification of source water (e.g., surface water, GWUDI) — determines applicable treatment technique requirements."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was required for this CT record — used to track compliance gaps."
    - name: "operator_verified"
      expr: operator_verified
      comment: "Boolean flag indicating operator verification of the CT calculation — data quality and accountability dimension."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate CT value (e.g., SCADA continuous, manual grab sample) — affects data reliability assessment."
  measures:
    - name: "avg_ct_ratio"
      expr: AVG(CAST(ct_ratio AS DOUBLE))
      comment: "Average CT ratio (CT calculated / CT required). Values below 1.0 indicate non-compliance. Core regulatory KPI for Surface Water Treatment Rule."
    - name: "min_ct_ratio"
      expr: MIN(ct_ratio)
      comment: "Minimum CT ratio observed — identifies worst-case compliance exposure within the reporting period."
    - name: "avg_log_inactivation_achieved"
      expr: AVG(CAST(log_inactivation_achieved AS DOUBLE))
      comment: "Average log inactivation credit achieved. Must meet or exceed required log inactivation for Giardia/Cryptosporidium/viruses per SWTR."
    - name: "avg_log_inactivation_required"
      expr: AVG(CAST(log_inactivation_required AS DOUBLE))
      comment: "Average log inactivation required by regulation. Used with achieved value to compute compliance margin."
    - name: "avg_ct_calculated"
      expr: AVG(CAST(ct_calculated AS DOUBLE))
      comment: "Average calculated CT value (mg·min/L). Measures actual disinfection dose delivered to the water."
    - name: "avg_ct_required"
      expr: AVG(CAST(ct_required AS DOUBLE))
      comment: "Average CT value required by regulation (mg·min/L). Baseline for compliance gap analysis."
    - name: "avg_contact_time_min"
      expr: AVG(CAST(contact_time_min AS DOUBLE))
      comment: "Average hydraulic contact time in minutes. Key operational parameter — shorter contact times reduce CT credit."
    - name: "avg_disinfectant_concentration"
      expr: AVG(CAST(disinfectant_concentration AS DOUBLE))
      comment: "Average disinfectant concentration (mg/L) at point of CT measurement. Drives CT calculation alongside contact time."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of CT records with non-compliant status. Regulatory KPI — any non-zero value triggers mandatory reporting and corrective action."
    - name: "ct_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CT records achieving compliance. Executive-level regulatory performance indicator — target is 100%."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average turbidity at CT measurement point (NTU). High turbidity reduces disinfection efficacy and CT credit."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average water temperature at CT measurement (°C). Lower temperatures require higher CT values — critical for winter operations."
    - name: "total_ct_records"
      expr: COUNT(1)
      comment: "Total number of CT compliance records. Used as denominator for compliance rate and as a data completeness indicator."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment compliance violation KPIs — tracks regulatory violations by type, severity, and resolution status. Drives enforcement risk management, public notification obligations, and corrective action prioritization."
  source: "`water_utilities_ecm`.`treatment`.`treatment_violation`"
  dimensions:
    - name: "violation_date"
      expr: violation_date
      comment: "Date the violation was detected — primary time dimension for violation trend analysis."
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month bucket for violation frequency trend reporting."
    - name: "violation_type"
      expr: violation_type
      comment: "Category of violation (e.g., MCL, TT, monitoring, reporting) — determines regulatory consequence and public notification requirements."
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., open, resolved, under review) — used to track outstanding compliance obligations."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation — drives prioritization of corrective actions and enforcement response."
    - name: "contaminant_name"
      expr: contaminant_name
      comment: "Name of the contaminant associated with the violation — identifies recurring problem contaminants."
    - name: "contaminant_code"
      expr: contaminant_code
      comment: "Regulatory contaminant code — used for DMR and CCR reporting alignment."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification of the violation — informs systemic improvement and capital investment decisions."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Boolean flag indicating whether this is a repeat violation — repeat violations carry elevated enforcement risk and penalty exposure."
    - name: "public_notification_required"
      expr: public_notification_required
      comment: "Boolean flag indicating whether public notification is required — Tier 1/2/3 notifications have strict deadlines."
    - name: "enforcement_action_taken"
      expr: enforcement_action_taken
      comment: "Boolean flag indicating whether a formal enforcement action was taken — tracks regulatory escalation."
    - name: "ccr_reportable"
      expr: ccr_reportable
      comment: "Boolean flag indicating whether the violation must appear in the Consumer Confidence Report — public transparency obligation."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of treatment facility associated with the violation — enables cross-facility compliance benchmarking."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of treatment violations. Primary compliance KPI — tracked by regulators and reported in annual CCR."
    - name: "open_violation_count"
      expr: COUNT(CASE WHEN violation_status = 'open' THEN 1 END)
      comment: "Number of currently open (unresolved) violations. Measures outstanding compliance liability and corrective action backlog."
    - name: "repeat_violation_count"
      expr: COUNT(CASE WHEN is_repeat_violation = TRUE THEN 1 END)
      comment: "Number of repeat violations. Repeat violations signal systemic failures and attract heightened regulatory scrutiny and penalties."
    - name: "public_notification_required_count"
      expr: COUNT(CASE WHEN public_notification_required = TRUE THEN 1 END)
      comment: "Number of violations requiring public notification. Tracks public health communication obligations with strict regulatory deadlines."
    - name: "enforcement_action_count"
      expr: COUNT(CASE WHEN enforcement_action_taken = TRUE THEN 1 END)
      comment: "Number of violations that resulted in formal enforcement actions. Measures regulatory escalation frequency and legal exposure."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed for treatment violations in USD. Direct financial impact KPI for executive and board reporting."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Average magnitude by which measured values exceeded regulatory limits. Indicates severity of violations beyond binary pass/fail."
    - name: "max_exceedance_magnitude"
      expr: MAX(exceedance_magnitude)
      comment: "Maximum exceedance magnitude observed. Identifies worst-case regulatory exposure events requiring immediate executive attention."
    - name: "distinct_contaminants_violated"
      expr: COUNT(DISTINCT contaminant_code)
      comment: "Number of distinct contaminants with active violations. Breadth indicator — wide contaminant spread signals systemic treatment deficiency."
    - name: "violation_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_status = 'resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that have been resolved. Measures corrective action effectiveness and compliance recovery speed."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical dosing performance and cost KPIs — tracks disinfection efficacy, CT compliance, dosing accuracy, and chemical spend. Supports operational optimization and regulatory compliance for disinfection treatment stages."
  source: "`water_utilities_ecm`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "dose_start_date"
      expr: CAST(dose_start_timestamp AS DATE)
      comment: "Date of the chemical dose event — primary time dimension for dosing trend analysis."
    - name: "dose_month"
      expr: DATE_TRUNC('MONTH', dose_start_timestamp)
      comment: "Month bucket for chemical dosing cost and compliance trend reporting."
    - name: "chemical_type"
      expr: chemical_type
      comment: "Type of chemical applied (e.g., chlorine, alum, polymer) — primary dimension for chemical-specific performance analysis."
    - name: "treatment_process_stage"
      expr: treatment_process_stage
      comment: "Treatment process stage where chemical was applied (e.g., pre-treatment, primary disinfection, secondary) — enables stage-level optimization."
    - name: "dosing_method"
      expr: dosing_method
      comment: "Method of chemical application (e.g., continuous feed, batch, slug dose) — affects dosing precision and cost."
    - name: "dose_trigger_type"
      expr: dose_trigger_type
      comment: "Trigger that initiated the dose event (e.g., scheduled, alarm, manual) — distinguishes reactive from proactive dosing."
    - name: "ct_compliance_flag"
      expr: ct_compliance_flag
      comment: "Boolean flag indicating whether CT compliance was achieved for this dose event — primary regulatory compliance dimension."
    - name: "dbp_formation_risk_flag"
      expr: dbp_formation_risk_flag
      comment: "Boolean flag indicating elevated disinfection byproduct formation risk — triggers dose optimization review."
    - name: "regulatory_event_flag"
      expr: regulatory_event_flag
      comment: "Boolean flag indicating this dose event has regulatory significance — used to filter for compliance-critical events."
    - name: "dose_event_status"
      expr: dose_event_status
      comment: "Status of the dose event (e.g., completed, aborted, in-progress) — used to filter for valid completed events."
  measures:
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total mass of chemical applied in kilograms. Core chemical consumption KPI for inventory planning and cost management."
    - name: "total_volume_applied_l"
      expr: SUM(CAST(volume_applied_l AS DOUBLE))
      comment: "Total volume of chemical solution applied in liters. Used alongside mass to verify concentration consistency."
    - name: "total_event_dose_cost_usd"
      expr: SUM(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Total chemical dosing cost in USD across all events. Direct operational cost KPI for budget management and cost-per-volume analysis."
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average actual dose rate applied (mg/L). Compared against target dose rate to assess dosing precision and process control quality."
    - name: "avg_target_dose_rate_mg_per_l"
      expr: AVG(CAST(target_dose_rate_mg_per_l AS DOUBLE))
      comment: "Average target dose rate (mg/L). Baseline for dosing accuracy variance analysis."
    - name: "avg_ct_value_mg_min_per_l"
      expr: AVG(CAST(ct_value_mg_min_per_l AS DOUBLE))
      comment: "Average CT value achieved during dose events (mg·min/L). Measures disinfection efficacy — must meet or exceed CT required."
    - name: "avg_ct_required_mg_min_per_l"
      expr: AVG(CAST(ct_required_mg_min_per_l AS DOUBLE))
      comment: "Average CT value required by regulation (mg·min/L). Used with achieved CT to compute compliance margin."
    - name: "avg_unit_cost_per_kg"
      expr: AVG(CAST(unit_cost_per_kg AS DOUBLE))
      comment: "Average unit cost of chemical per kilogram. Procurement efficiency KPI — tracks chemical price trends and vendor performance."
    - name: "ct_non_compliance_count"
      expr: COUNT(CASE WHEN ct_compliance_flag = FALSE THEN 1 END)
      comment: "Number of dose events where CT compliance was not achieved. Regulatory risk KPI — each instance requires investigation and corrective action."
    - name: "dbp_risk_event_count"
      expr: COUNT(CASE WHEN dbp_formation_risk_flag = TRUE THEN 1 END)
      comment: "Number of dose events with elevated DBP formation risk. Tracks TTHM/HAA5 precursor exposure — informs dose optimization to balance disinfection vs. byproduct formation."
    - name: "total_dose_events"
      expr: COUNT(1)
      comment: "Total number of chemical dose events. Used as denominator for rate calculations and as an operational activity volume indicator."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_filter_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Filter performance KPIs — tracks filter run duration, turbidity removal efficiency, hydraulic loading, and regulatory compliance. Supports filter optimization, backwash scheduling, and LT2/SWTR compliance management."
  source: "`water_utilities_ecm`.`treatment`.`filter_run`"
  dimensions:
    - name: "run_start_date"
      expr: CAST(run_start_timestamp AS DATE)
      comment: "Date the filter run started — primary time dimension for filter performance trend analysis."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month bucket for filter performance aggregation and regulatory reporting."
    - name: "run_status"
      expr: run_status
      comment: "Status of the filter run (e.g., completed, terminated, in-progress) — used to filter for valid completed runs."
    - name: "backwash_trigger_reason"
      expr: backwash_trigger_reason
      comment: "Reason the filter run was terminated and backwash initiated (e.g., headloss, turbidity, time) — informs filter optimization strategy."
    - name: "filter_to_waste_flag"
      expr: filter_to_waste_flag
      comment: "Boolean flag indicating whether filter-to-waste was used during ripening — affects net production volume and water loss."
    - name: "turbidity_mcl_exceedance"
      expr: turbidity_mcl_exceedance
      comment: "Boolean flag indicating whether effluent turbidity exceeded the MCL during this run — primary regulatory compliance dimension."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Overall regulatory compliance flag for the filter run — used for compliance rate calculations."
    - name: "data_source"
      expr: data_source
      comment: "Source system for filter run data (e.g., SCADA, manual entry) — data quality and lineage dimension."
  measures:
    - name: "avg_run_duration_hours"
      expr: AVG(CAST(run_duration_hours AS DOUBLE))
      comment: "Average filter run duration in hours. Longer runs indicate better filter performance and lower backwash frequency — key operational efficiency KPI."
    - name: "total_volume_filtered_mg"
      expr: SUM(CAST(volume_filtered_mg AS DOUBLE))
      comment: "Total volume of water filtered in million gallons. Measures filter throughput and capacity utilization."
    - name: "avg_influent_turbidity_ntu"
      expr: AVG(CAST(influent_turbidity_ntu AS DOUBLE))
      comment: "Average influent turbidity entering the filter (NTU). Indicates raw water quality challenge — higher values stress filter performance."
    - name: "avg_terminal_effluent_turbidity_ntu"
      expr: AVG(CAST(terminal_effluent_turbidity_ntu AS DOUBLE))
      comment: "Average effluent turbidity at end of filter run (NTU). Must remain below 0.3 NTU per SWTR — primary filter quality KPI."
    - name: "avg_peak_effluent_turbidity_ntu"
      expr: AVG(CAST(peak_effluent_turbidity_ntu AS DOUBLE))
      comment: "Average peak effluent turbidity during filter runs (NTU). Captures worst-case turbidity spikes that may trigger compliance concerns."
    - name: "avg_hydraulic_loading_rate_gpm_sqft"
      expr: AVG(CAST(hydraulic_loading_rate_gpm_sqft AS DOUBLE))
      comment: "Average hydraulic loading rate (gpm/ft²). Measures filter stress — rates above design limits reduce run duration and increase turbidity breakthrough risk."
    - name: "avg_terminal_head_loss_ft"
      expr: AVG(CAST(terminal_head_loss_ft AS DOUBLE))
      comment: "Average terminal head loss at end of filter run (ft). Indicates filter media fouling rate — used to optimize backwash frequency."
    - name: "avg_coagulant_dose_mg_l"
      expr: AVG(CAST(coagulant_dose_mg_l AS DOUBLE))
      comment: "Average coagulant dose applied prior to filtration (mg/L). Optimizing coagulant dose improves filter performance and reduces chemical costs."
    - name: "turbidity_exceedance_run_count"
      expr: COUNT(CASE WHEN turbidity_mcl_exceedance = TRUE THEN 1 END)
      comment: "Number of filter runs with turbidity MCL exceedances. Regulatory KPI — each exceedance requires reporting and corrective action under SWTR."
    - name: "filter_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filter runs meeting all regulatory compliance criteria. Executive-level filter performance indicator — target is 100%."
    - name: "filter_to_waste_volume_total_mg"
      expr: SUM(CAST(filter_to_waste_volume_mg AS DOUBLE))
      comment: "Total filter-to-waste volume in million gallons. Measures non-revenue water loss during filter ripening — optimization target for water efficiency."
    - name: "total_filter_runs"
      expr: COUNT(1)
      comment: "Total number of filter runs. Used as denominator for compliance rate and as an operational activity volume indicator."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_backwash_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Filter backwash operational KPIs — tracks water consumption, duration efficiency, turbidity compliance post-backwash, and media performance. Supports water loss reduction, filter optimization, and regulatory compliance."
  source: "`water_utilities_ecm`.`treatment`.`backwash_event`"
  dimensions:
    - name: "backwash_start_date"
      expr: CAST(backwash_start_timestamp AS DATE)
      comment: "Date the backwash event started — primary time dimension for backwash frequency and water loss trend analysis."
    - name: "backwash_month"
      expr: DATE_TRUNC('MONTH', backwash_start_timestamp)
      comment: "Month bucket for backwash water consumption and frequency reporting."
    - name: "initiation_type"
      expr: initiation_type
      comment: "How the backwash was initiated (e.g., automatic, manual, scheduled) — distinguishes reactive from proactive maintenance."
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Reason the backwash was triggered (e.g., headloss threshold, turbidity, time-based) — informs filter optimization strategy."
    - name: "filter_media_type"
      expr: filter_media_type
      comment: "Type of filter media being backwashed (e.g., sand, anthracite, GAC) — enables media-specific performance benchmarking."
    - name: "backwash_water_source"
      expr: backwash_water_source
      comment: "Source of water used for backwashing (e.g., finished water, reclaimed) — affects water loss accounting."
    - name: "backwash_waste_disposal_method"
      expr: backwash_waste_disposal_method
      comment: "Method of backwash waste disposal (e.g., recycle, lagoon, sewer) — environmental compliance and cost dimension."
    - name: "turbidity_compliance_met"
      expr: turbidity_compliance_met
      comment: "Boolean flag indicating whether post-backwash turbidity met compliance requirements — critical for filter return-to-service decisions."
    - name: "air_scour_used"
      expr: air_scour_used
      comment: "Boolean flag indicating whether air scour was used during backwash — affects backwash effectiveness and water consumption."
    - name: "abnormal_event_flag"
      expr: abnormal_event_flag
      comment: "Boolean flag indicating an abnormal backwash event — used to identify and investigate process anomalies."
    - name: "operator_confirmed"
      expr: operator_confirmed
      comment: "Boolean flag indicating operator confirmation of the backwash event — data quality and accountability dimension."
  measures:
    - name: "total_backwash_water_volume_gal"
      expr: SUM(CAST(backwash_water_volume_gal AS DOUBLE))
      comment: "Total water consumed in backwash operations in gallons. Primary water loss KPI — directly impacts plant efficiency ratio and non-revenue water."
    - name: "total_backwash_recycle_volume_gal"
      expr: SUM(CAST(backwash_recycle_volume_gal AS DOUBLE))
      comment: "Total backwash water recycled back to the treatment process in gallons. Measures water recovery efficiency — higher recycle reduces net water loss."
    - name: "total_filter_to_waste_volume_gal"
      expr: SUM(CAST(filter_to_waste_volume_gal AS DOUBLE))
      comment: "Total filter-to-waste volume during post-backwash ripening in gallons. Additional non-revenue water loss component — optimization target."
    - name: "avg_backwash_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average backwash event duration in minutes. Longer durations consume more water — optimization target for water efficiency."
    - name: "avg_backwash_flow_rate_gpm"
      expr: AVG(CAST(backwash_flow_rate_gpm AS DOUBLE))
      comment: "Average backwash flow rate in gallons per minute. Must achieve sufficient bed expansion for effective media cleaning."
    - name: "avg_pre_backwash_turbidity_ntu"
      expr: AVG(CAST(pre_backwash_turbidity_ntu AS DOUBLE))
      comment: "Average filter effluent turbidity before backwash (NTU). Indicates the turbidity condition that triggered the backwash event."
    - name: "avg_post_backwash_turbidity_ntu"
      expr: AVG(CAST(post_backwash_turbidity_ntu AS DOUBLE))
      comment: "Average filter effluent turbidity after backwash (NTU). Must meet regulatory limits before filter is returned to service."
    - name: "avg_media_expansion_pct"
      expr: AVG(CAST(media_expansion_pct AS DOUBLE))
      comment: "Average filter media bed expansion percentage during backwash. Insufficient expansion indicates inadequate cleaning — affects filter run performance."
    - name: "avg_filter_run_time_prior_hrs"
      expr: AVG(CAST(filter_run_time_prior_hrs AS DOUBLE))
      comment: "Average filter run time before backwash was required (hours). Longer prior run times indicate better filter performance and lower backwash frequency."
    - name: "turbidity_non_compliance_count"
      expr: COUNT(CASE WHEN turbidity_compliance_met = FALSE THEN 1 END)
      comment: "Number of backwash events where post-backwash turbidity did not meet compliance requirements. Indicates filter media or process issues requiring investigation."
    - name: "abnormal_event_count"
      expr: COUNT(CASE WHEN abnormal_event_flag = TRUE THEN 1 END)
      comment: "Number of abnormal backwash events. Elevated counts signal equipment issues, media degradation, or process upsets requiring maintenance attention."
    - name: "total_backwash_events"
      expr: COUNT(1)
      comment: "Total number of backwash events. Used as denominator for rate calculations and as a filter maintenance frequency indicator."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source water intake quality and volume KPIs — tracks raw water characteristics, withdrawal volumes, and permit compliance. Supports treatment process optimization, source water protection, and regulatory reporting."
  source: "`water_utilities_ecm`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "intake_date"
      expr: CAST(intake_timestamp AS DATE)
      comment: "Date of the source water intake event — primary time dimension for raw water quality trend analysis."
    - name: "intake_month"
      expr: DATE_TRUNC('MONTH', intake_timestamp)
      comment: "Month bucket for intake volume and quality trend reporting."
    - name: "source_type"
      expr: source_type
      comment: "Type of source water (e.g., river, reservoir, groundwater, GWUDI) — determines applicable treatment requirements and monitoring obligations."
    - name: "intake_status"
      expr: intake_status
      comment: "Operational status of the intake event (e.g., active, suspended, emergency) — used to filter for normal operating conditions."
    - name: "intake_method"
      expr: intake_method
      comment: "Method of water intake (e.g., gravity, pumped) — affects energy cost and operational reliability."
    - name: "source_water_alert_active"
      expr: source_water_alert_active
      comment: "Boolean flag indicating an active source water quality alert — triggers enhanced monitoring and treatment adjustments."
    - name: "source_water_protection_zone"
      expr: source_water_protection_zone
      comment: "Source water protection zone classification — regulatory and land-use planning dimension."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during intake — storm events correlate with turbidity spikes and elevated treatment demand."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the intake record — used to exclude suspect readings from KPI calculations."
  measures:
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total raw water volume withdrawn in million gallons. Core intake KPI — tracked against permit daily limits for regulatory compliance."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average raw water turbidity at intake (NTU). High turbidity increases coagulant demand and treatment costs — key treatment planning metric."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_ntu)
      comment: "Maximum raw water turbidity observed at intake (NTU). Identifies peak treatment challenge events — informs design capacity and chemical inventory planning."
    - name: "avg_toc_mg_per_l"
      expr: AVG(CAST(toc_mg_per_l AS DOUBLE))
      comment: "Average total organic carbon in source water (mg/L). Predicts DBP formation potential — drives treatment process selection and chemical dosing strategy."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average pH of source water at intake. Affects coagulation efficiency and disinfection byproduct formation — key treatment optimization parameter."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average source water temperature (°C). Seasonal temperature changes affect CT requirements, coagulation performance, and chemical dosing rates."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average intake flow rate in gallons per minute. Measures intake capacity utilization relative to permitted and design limits."
    - name: "avg_permit_daily_limit_mg"
      expr: AVG(CAST(permit_daily_limit_mg AS DOUBLE))
      comment: "Average permitted daily withdrawal limit in million gallons. Used with actual withdrawal to compute permit utilization ratio."
    - name: "source_water_alert_days"
      expr: COUNT(CASE WHEN source_water_alert_active = TRUE THEN 1 END)
      comment: "Number of intake events with active source water quality alerts. Tracks raw water quality incidents that require enhanced treatment response."
    - name: "avg_dissolved_oxygen_mg_per_l"
      expr: AVG(CAST(dissolved_oxygen_mg_per_l AS DOUBLE))
      comment: "Average dissolved oxygen in source water (mg/L). Low DO indicates anaerobic conditions that can cause taste/odor issues and increase treatment complexity."
    - name: "avg_algae_count_cells_per_ml"
      expr: AVG(CAST(algae_count_cells_per_ml AS DOUBLE))
      comment: "Average algae cell count in source water (cells/mL). Elevated algae causes taste/odor problems, filter clogging, and cyanotoxin risk — triggers treatment adjustments."
    - name: "total_intake_events"
      expr: COUNT(1)
      comment: "Total number of source water intake events. Used as denominator for rate calculations and as an operational activity volume indicator."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`treatment_chemical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical inventory management KPIs — tracks stock levels, days of supply, reorder risk, and storage compliance. Supports procurement planning, regulatory chemical reporting (EPCRA/RMP), and operational continuity."
  source: "`water_utilities_ecm`.`treatment`.`chemical_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the chemical inventory record (e.g., active, depleted, expired) — primary operational status dimension."
    - name: "hazmat_class"
      expr: hazmat_class
      comment: "Hazardous materials classification of the chemical — regulatory reporting and safety management dimension."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the chemical inventory (e.g., lbs, gallons, kg) — required for quantity normalization."
    - name: "is_epcra_reportable"
      expr: is_epcra_reportable
      comment: "Boolean flag indicating whether the chemical is subject to EPCRA Tier II reporting — regulatory compliance dimension."
    - name: "is_rmp_regulated"
      expr: is_rmp_regulated
      comment: "Boolean flag indicating whether the chemical is regulated under EPA Risk Management Program — high-consequence safety dimension."
    - name: "storage_container_type"
      expr: storage_container_type
      comment: "Type of storage container (e.g., bulk tank, cylinder, tote) — affects safety protocols and inventory management."
    - name: "tier2_reporting_year"
      expr: tier2_reporting_year
      comment: "Reporting year for EPCRA Tier II chemical inventory submissions — regulatory reporting dimension."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total chemical quantity currently on hand across all inventory records. Core inventory KPI — compared against safety stock and reorder points."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of chemical supply remaining based on current stock and usage rate. Critical operational continuity KPI — low values trigger emergency procurement."
    - name: "min_days_of_supply"
      expr: MIN(days_of_supply)
      comment: "Minimum days of supply across all chemical inventory items. Identifies the most critical supply risk — any item near zero threatens treatment operations."
    - name: "total_inventory_value_usd"
      expr: SUM(quantity_on_hand * unit_cost)
      comment: "Total value of chemical inventory on hand in USD (quantity × unit cost). Working capital KPI for finance and procurement management."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of chemicals in inventory. Tracks chemical price trends and procurement efficiency over time."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of chemical inventory items below their reorder point. Procurement urgency KPI — items below reorder point require immediate purchase action."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock_quantity THEN 1 END)
      comment: "Number of chemical inventory items below safety stock levels. Critical risk KPI — items below safety stock represent operational continuity risk."
    - name: "avg_max_storage_capacity"
      expr: AVG(CAST(max_storage_capacity AS DOUBLE))
      comment: "Average maximum storage capacity across chemical inventory locations. Used with quantity on hand to compute storage utilization."
    - name: "rmp_regulated_chemical_count"
      expr: COUNT(CASE WHEN is_rmp_regulated = TRUE THEN 1 END)
      comment: "Number of RMP-regulated chemical inventory items. Tracks high-consequence chemical exposure — RMP facilities face enhanced EPA oversight and community right-to-know obligations."
    - name: "total_inventory_items"
      expr: COUNT(1)
      comment: "Total number of chemical inventory records. Used as denominator for rate calculations and as an inventory breadth indicator."
$$;