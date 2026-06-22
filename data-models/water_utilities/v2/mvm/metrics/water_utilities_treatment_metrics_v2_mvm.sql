-- Metric views for domain: treatment | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core operational KPIs for finished water production at treatment facilities. Tracks volumetric output, treatment efficiency, disinfection compliance, and water quality parameters to steer daily operations and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility identifier — primary grouping dimension for facility-level performance benchmarking."
    - name: "production_date"
      expr: production_date
      comment: "Date of finished water production record (yyyy-MM-dd) — used for daily, monthly, and annual trend analysis."
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Calendar month of production — supports monthly volumetric and efficiency trend reporting."
    - name: "production_year"
      expr: DATE_TRUNC('YEAR', production_date)
      comment: "Calendar year of production — supports annual capacity utilisation and regulatory summary reporting."
    - name: "regulatory_exceedance_flag"
      expr: regulatory_exceedance
      comment: "Boolean flag indicating whether a regulatory exceedance occurred on this production record — key compliance dimension."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean flag indicating data quality issues on the production record — used to filter or segment reliable vs. suspect readings."
  measures:
    - name: "total_finished_water_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total volume of finished (treated) water produced in million gallons. Primary throughput KPI for capacity planning, demand forecasting, and regulatory reporting."
    - name: "avg_daily_finished_water_volume_mg"
      expr: AVG(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Average daily finished water production volume in million gallons. Benchmarks typical output against design capacity and permitted limits."
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (finished water output vs. source water input). Measures process efficiency and water loss — a key operational and cost KPI."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity in NTU. Regulatory compliance and treatment effectiveness indicator — exceedances trigger immediate operational response."
    - name: "max_turbidity_ntu"
      expr: MAX(CAST(turbidity_max_ntu AS DOUBLE))
      comment: "Maximum turbidity recorded across production records. Identifies worst-case treatment performance events for regulatory review and process optimisation."
    - name: "avg_cl2_residual_mg_l"
      expr: AVG(CAST(cl2_residual_avg_mg_l AS DOUBLE))
      comment: "Average chlorine residual in finished water (mg/L). Core disinfection compliance KPI — must remain within regulatory minimum/maximum bounds."
    - name: "min_cl2_residual_mg_l"
      expr: MIN(CAST(cl2_residual_min_mg_l AS DOUBLE))
      comment: "Minimum chlorine residual observed across production records. Identifies disinfection deficit events that may trigger regulatory non-compliance."
    - name: "avg_ct_achieved_mg_min_l"
      expr: AVG(CAST(ct_achieved_mg_min_l AS DOUBLE))
      comment: "Average CT value achieved (concentration × time, mg·min/L). Measures disinfection efficacy against pathogens — must meet or exceed CT required for regulatory compliance."
    - name: "avg_ct_required_mg_min_l"
      expr: AVG(CAST(ct_required_mg_min_l AS DOUBLE))
      comment: "Average CT value required by regulation (mg·min/L). Paired with avg_ct_achieved to compute CT compliance margin at the BI layer."
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average pH of finished water. Operational quality KPI — pH outside optimal range affects disinfection efficacy, corrosion control, and regulatory compliance."
    - name: "avg_peak_production_rate_gpm"
      expr: AVG(CAST(peak_production_rate_gpm AS DOUBLE))
      comment: "Average peak production rate in gallons per minute. Indicates peak demand handling capability and proximity to hydraulic capacity limits."
    - name: "regulatory_exceedance_days"
      expr: SUM(CASE WHEN regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of production days with a regulatory exceedance. Directly drives compliance risk scoring, regulatory reporting, and enforcement exposure."
    - name: "total_production_records"
      expr: COUNT(1)
      comment: "Total number of finished water production records. Baseline volume measure for data completeness checks and per-facility reporting coverage."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical dosing operational and cost KPIs for treatment facilities. Tracks dosing rates, CT compliance, chemical mass applied, and event costs to optimise chemical spend and ensure disinfection regulatory compliance."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility identifier — primary grouping dimension for facility-level chemical dosing analysis."
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit where the chemical dose was applied — enables unit-level dosing performance analysis."
    - name: "chemical_id"
      expr: chemical_id
      comment: "Chemical identifier — groups dosing events by chemical type for spend and compliance analysis."
    - name: "chemical_type"
      expr: chemical_type
      comment: "Category/type of chemical dosed (e.g., disinfectant, coagulant, pH adjuster) — supports chemical programme performance segmentation."
    - name: "dose_event_status"
      expr: dose_event_status
      comment: "Status of the dosing event (e.g., completed, aborted, in-progress) — used to filter valid completed events for KPI calculations."
    - name: "ct_compliance_flag"
      expr: ct_compliance_flag
      comment: "Boolean flag indicating whether the CT compliance threshold was met during this dosing event — primary disinfection compliance dimension."
    - name: "dose_start_month"
      expr: DATE_TRUNC('MONTH', dose_start_timestamp)
      comment: "Calendar month of dose event start — supports monthly chemical cost and compliance trend analysis."
    - name: "dose_start_year"
      expr: DATE_TRUNC('YEAR', dose_start_timestamp)
      comment: "Calendar year of dose event start — supports annual chemical programme budget and compliance reporting."
  measures:
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total chemical mass applied across all dosing events in kilograms. Primary chemical consumption KPI for procurement planning and cost management."
    - name: "total_event_dose_cost_usd"
      expr: SUM(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Total chemical dosing cost in USD. Core financial KPI for treatment chemical budget tracking and cost-per-volume benchmarking."
    - name: "avg_event_dose_cost_usd"
      expr: AVG(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Average cost per chemical dosing event in USD. Benchmarks dosing efficiency and identifies cost outliers for operational review."
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average actual chemical dose rate in mg/L. Compared against target dose rate to assess dosing precision and process control quality."
    - name: "avg_target_dose_rate_mg_per_l"
      expr: AVG(CAST(target_dose_rate_mg_per_l AS DOUBLE))
      comment: "Average target chemical dose rate in mg/L. Paired with avg_dose_rate to compute dosing accuracy at the BI layer."
    - name: "avg_ct_value_mg_min_per_l"
      expr: AVG(CAST(ct_value_mg_min_per_l AS DOUBLE))
      comment: "Average CT value achieved during dosing events (mg·min/L). Measures disinfection efficacy — must meet regulatory CT requirements."
    - name: "avg_ct_required_mg_min_per_l"
      expr: AVG(CAST(ct_required_mg_min_per_l AS DOUBLE))
      comment: "Average CT value required by regulation (mg·min/L). Paired with avg_ct_value to compute CT compliance margin at the BI layer."
    - name: "ct_non_compliant_events"
      expr: SUM(CASE WHEN ct_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of dosing events where CT compliance was not achieved. Directly measures disinfection regulatory risk — drives immediate operational and regulatory response."
    - name: "ct_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ct_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dosing events meeting CT compliance requirements. Executive-level disinfection compliance KPI — regulatory agencies and leadership track this closely."
    - name: "total_dose_events"
      expr: COUNT(1)
      comment: "Total number of chemical dosing events. Baseline activity volume measure for normalising cost and compliance KPIs."
    - name: "avg_chemical_mass_applied_kg"
      expr: AVG(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Average chemical mass applied per dosing event in kilograms. Identifies dosing intensity trends and supports chemical efficiency benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process monitoring and regulatory compliance KPIs derived from treatment process readings. Tracks measured parameter values against regulatory limits to identify exceedances, monitor treatment performance, and support regulatory reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_reading`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility identifier — primary grouping dimension for facility-level process monitoring analysis."
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit where the reading was taken — enables unit-level performance and compliance analysis."
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of process parameter measured (e.g., turbidity, chlorine, pH, TOC) — primary analytical dimension for parameter-specific compliance tracking."
    - name: "engineering_unit"
      expr: engineering_unit
      comment: "Engineering unit of the measured value (e.g., NTU, mg/L, pH units) — ensures correct interpretation of measured values in analysis."
    - name: "is_regulatory_exceedance"
      expr: is_regulatory_exceedance
      comment: "Boolean flag indicating whether the reading exceeded the applicable regulatory limit — primary compliance dimension."
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Boolean flag indicating whether the reading was manually entered vs. automated SCADA capture — used to assess data reliability and audit risk."
    - name: "quality_flag"
      expr: quality_flag
      comment: "Boolean data quality flag on the reading — used to segment reliable vs. suspect readings in compliance analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Calendar month of the process reading — supports monthly compliance trend and exceedance frequency analysis."
    - name: "reading_year"
      expr: DATE_TRUNC('YEAR', reading_timestamp)
      comment: "Calendar year of the process reading — supports annual regulatory summary and permit compliance reporting."
  measures:
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured process parameter value. Core process performance KPI — compared against regulatory limits to assess treatment effectiveness."
    - name: "max_measured_value"
      expr: MAX(CAST(measured_value AS DOUBLE))
      comment: "Maximum measured process parameter value. Identifies worst-case readings that may represent regulatory exceedances or process upsets."
    - name: "avg_regulatory_limit_value"
      expr: AVG(CAST(regulatory_limit_value AS DOUBLE))
      comment: "Average regulatory limit value applicable to readings. Paired with avg_measured_value to compute compliance headroom at the BI layer."
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN is_regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Total count of process readings that exceeded regulatory limits. Primary compliance risk KPI — drives regulatory reporting, enforcement exposure, and corrective action."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_regulatory_exceedance = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process readings within regulatory limits. Executive-level compliance KPI — tracked by regulators, leadership, and board-level risk committees."
    - name: "manual_entry_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_manual_entry = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings entered manually vs. automated SCADA capture. Data integrity KPI — high manual entry rates increase audit risk and regulatory scrutiny."
    - name: "total_process_readings"
      expr: COUNT(1)
      comment: "Total number of process readings. Baseline monitoring activity volume — used to assess monitoring programme completeness and regulatory sampling frequency compliance."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source water intake operational KPIs tracking raw water quality, volumetric withdrawals, and permit compliance. Informs source water protection decisions, treatment process adjustments, and regulatory withdrawal reporting."
  source: "`vibe_water_utilities_v1`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility receiving the source water intake — primary grouping dimension for facility-level intake analysis."
    - name: "source_type"
      expr: source_type
      comment: "Type of source water (e.g., surface water, groundwater, purchased) — key dimension for source-specific quality and treatment strategy analysis."
    - name: "permit_compliance_status"
      expr: permit_compliance_status
      comment: "Permit compliance status of the intake event — identifies non-compliant withdrawals for regulatory reporting and enforcement risk management."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean data quality flag on the intake record — used to segment reliable vs. suspect intake measurements."
    - name: "intake_month"
      expr: DATE_TRUNC('MONTH', intake_timestamp)
      comment: "Calendar month of the source water intake — supports monthly withdrawal volume and quality trend analysis."
    - name: "intake_year"
      expr: DATE_TRUNC('YEAR', intake_timestamp)
      comment: "Calendar year of the source water intake — supports annual withdrawal permit compliance and source water quality reporting."
  measures:
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total source water volume withdrawn in million gallons. Primary water rights and permit compliance KPI — must remain within permitted withdrawal limits."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average source water intake flow rate in gallons per minute. Operational KPI for intake capacity utilisation and hydraulic performance monitoring."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average raw source water turbidity in NTU. Drives treatment process adjustments — high turbidity increases chemical demand and treatment cost."
    - name: "max_turbidity_ntu"
      expr: MAX(CAST(turbidity_ntu AS DOUBLE))
      comment: "Maximum raw source water turbidity recorded. Identifies extreme raw water quality events that stress treatment capacity and may trigger enhanced treatment protocols."
    - name: "avg_toc_mg_per_l"
      expr: AVG(CAST(toc_mg_per_l AS DOUBLE))
      comment: "Average total organic carbon (TOC) in source water (mg/L). Key precursor indicator for disinfection by-product (DBP) formation — drives treatment strategy and regulatory compliance."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average pH of source water at intake. Influences coagulation efficiency, disinfection efficacy, and corrosion control — operational process optimisation KPI."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average source water temperature in Celsius. Affects disinfection CT requirements, chemical reaction rates, and seasonal treatment planning."
    - name: "total_intake_events"
      expr: COUNT(1)
      comment: "Total number of source water intake records. Baseline monitoring completeness measure for permit compliance and operational reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment facility portfolio KPIs covering capacity utilisation, energy intensity, and PFAS treatment capability. Supports strategic asset investment decisions, regulatory capacity planning, and infrastructure upgrade prioritisation."
  source: "`vibe_water_utilities_v1`.`treatment`.`facility`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Unique treatment facility identifier — primary key dimension for facility-level portfolio analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of treatment facility (e.g., surface water plant, groundwater plant, blending station) — segments portfolio by facility class for benchmarking."
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (e.g., active, decommissioned, under construction) — filters active vs. inactive assets in capacity analysis."
    - name: "state_code"
      expr: state_code
      comment: "US state code of the facility — supports geographic regulatory jurisdiction and regional capacity planning analysis."
    - name: "source_water_type"
      expr: source_water_type
      comment: "Primary source water type served by the facility — key dimension for treatment technology and regulatory requirement segmentation."
    - name: "treatment_technology_primary"
      expr: treatment_technology_primary
      comment: "Primary treatment technology deployed at the facility — supports technology portfolio analysis and capital investment planning."
    - name: "disinfection_type"
      expr: disinfection_type
      comment: "Disinfection method used at the facility (e.g., chlorination, UV, ozone) — key dimension for disinfection by-product risk and regulatory compliance analysis."
    - name: "pfas_treatment_capable_flag"
      expr: pfas_treatment_capable_flag
      comment: "Boolean flag indicating whether the facility is capable of PFAS treatment — critical dimension for PFAS regulatory compliance gap analysis."
  measures:
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design treatment capacity across facilities in million gallons per day. Portfolio-level capacity KPI for strategic planning and regulatory capacity adequacy assessment."
    - name: "total_permitted_capacity_mgd"
      expr: SUM(CAST(permitted_capacity_mgd AS DOUBLE))
      comment: "Total permitted treatment capacity across facilities in million gallons per day. Regulatory capacity ceiling — must not be exceeded without permit amendment."
    - name: "avg_capacity_utilisation_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_flow_mgd AS DOUBLE)) / NULLIF(AVG(CAST(design_capacity_mgd AS DOUBLE)), 0), 2)
      comment: "Average capacity utilisation percentage (average daily flow vs. design capacity). Strategic KPI for identifying over-utilised facilities requiring expansion and under-utilised assets for optimisation."
    - name: "avg_energy_intensity_kwh_per_mg"
      expr: AVG(CAST(energy_intensity_kwh_per_mg AS DOUBLE))
      comment: "Average energy intensity in kWh per million gallons treated. Operational efficiency and sustainability KPI — drives energy reduction programmes and cost benchmarking."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total average daily flow across all facilities in million gallons per day. System-wide demand KPI for capacity planning and regulatory reporting."
    - name: "pfas_capable_facility_count"
      expr: SUM(CASE WHEN pfas_treatment_capable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities with PFAS treatment capability. Strategic PFAS compliance readiness KPI — regulators and executives track this against PFAS MCL compliance deadlines."
    - name: "pfas_capability_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pfas_treatment_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with PFAS treatment capability. Portfolio-level PFAS regulatory readiness KPI — directly informs capital investment prioritisation for PFAS compliance."
    - name: "total_active_facilities"
      expr: COUNT(1)
      comment: "Total number of treatment facilities in the portfolio. Baseline asset count for capacity, compliance, and investment planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment process unit asset KPIs covering operational status, PFAS removal capability, and maintenance scheduling. Supports asset lifecycle management, PFAS compliance investment decisions, and process reliability planning."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_unit`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility owning the process unit — primary grouping dimension for facility-level asset portfolio analysis."
    - name: "process_type"
      expr: process_type
      comment: "Type of treatment process (e.g., filtration, disinfection, adsorption, coagulation) — segments asset portfolio by process function."
    - name: "process_stage"
      expr: process_stage
      comment: "Stage in the treatment train where the unit operates — supports process train completeness and redundancy analysis."
    - name: "technology_class"
      expr: technology_class
      comment: "Technology class of the process unit (e.g., GAC, IX, membrane, UV) — key dimension for technology portfolio and PFAS removal capability analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the process unit (e.g., online, offline, maintenance) — primary dimension for availability and reliability analysis."
    - name: "pfas_removal_capable_flag"
      expr: pfas_removal_capable_flag
      comment: "Boolean flag indicating whether the process unit is capable of PFAS removal — critical dimension for PFAS compliance gap analysis."
    - name: "media_type"
      expr: media_type
      comment: "Filter or adsorption media type (e.g., GAC, anthracite, sand) — supports media replacement planning and performance benchmarking."
    - name: "filter_type"
      expr: filter_type
      comment: "Filter configuration type — supports filter performance and maintenance strategy analysis."
  measures:
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design treatment capacity across process units in million gallons per day. Asset capacity portfolio KPI for redundancy and expansion planning."
    - name: "avg_design_flow_rate_gpm"
      expr: AVG(CAST(design_flow_rate_gpm AS DOUBLE))
      comment: "Average design flow rate per process unit in gallons per minute. Benchmarks unit sizing and supports hydraulic capacity planning."
    - name: "avg_empty_bed_contact_time_min"
      expr: AVG(CAST(empty_bed_contact_time_min AS DOUBLE))
      comment: "Average empty bed contact time (EBCT) in minutes across adsorption units. Key GAC/IX performance parameter — directly affects contaminant removal efficiency and media replacement frequency."
    - name: "total_media_volume_cubic_ft"
      expr: SUM(CAST(media_volume_cubic_ft AS DOUBLE))
      comment: "Total treatment media volume across process units in cubic feet. Asset inventory KPI for media procurement planning and replacement cost forecasting."
    - name: "pfas_capable_unit_count"
      expr: SUM(CASE WHEN pfas_removal_capable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of process units with PFAS removal capability. PFAS compliance readiness KPI — tracks treatment capacity available to meet PFAS MCL requirements."
    - name: "pfas_capability_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pfas_removal_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process units with PFAS removal capability. Portfolio-level PFAS readiness KPI — informs capital investment prioritisation for PFAS treatment upgrades."
    - name: "online_unit_count"
      expr: SUM(CASE WHEN operational_status = 'online' THEN 1 ELSE 0 END)
      comment: "Count of process units currently in online/operational status. Availability KPI — low online counts signal capacity risk and maintenance backlog issues."
    - name: "total_process_units"
      expr: COUNT(1)
      comment: "Total number of process units in the asset portfolio. Baseline asset count for availability rate, PFAS coverage, and maintenance planning calculations."
    - name: "avg_surface_area_sqft"
      expr: AVG(CAST(surface_area_sqft AS DOUBLE))
      comment: "Average surface area of process units in square feet. Supports filter loading rate calculations and unit sizing benchmarking for capital planning."
$$;