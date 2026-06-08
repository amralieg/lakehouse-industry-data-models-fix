-- Metric views for domain: wastewater | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_wwtp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capacity metrics for Wastewater Treatment Plants (WWTPs). Supports executive oversight of treatment capacity utilization, compliance posture, and energy efficiency across the plant portfolio."
  source: "`water_utilities_ecm`.`wastewater`.`wwtp`"
  dimensions:
    - name: "wwtp_id"
      expr: wwtp_id
      comment: "Unique identifier for the wastewater treatment plant."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the WWTP (e.g., Active, Offline, Under Maintenance)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the WWTP (e.g., In Compliance, NOV Issued)."
    - name: "treatment_level"
      expr: treatment_level
      comment: "Level of treatment achieved at the plant (e.g., Primary, Secondary, Tertiary)."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of wastewater facility (e.g., Municipal, Industrial)."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Disinfection technology used at the plant (e.g., UV, Chlorination)."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the plant's permits and reporting."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the WWTP is located."
    - name: "biosolids_class"
      expr: biosolids_class
      comment: "EPA biosolids classification (Class A or Class B) for the plant's biosolids output."
    - name: "receiving_water_classification"
      expr: receiving_water_classification
      comment: "Classification of the receiving water body for effluent discharge (e.g., Impaired, Outstanding Resource Water)."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the WWTP was commissioned, used for age-based portfolio analysis."
  measures:
    - name: "total_wwtp_count"
      expr: COUNT(DISTINCT wwtp_id)
      comment: "Total number of wastewater treatment plants in the portfolio. Baseline KPI for asset portfolio sizing."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total permitted design treatment capacity in million gallons per day (MGD) across all WWTPs. Drives capital planning and growth capacity decisions."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total actual average daily flow processed across all WWTPs in MGD. Compared against design capacity to assess system loading."
    - name: "avg_capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_flow_mgd AS DOUBLE) / NULLIF(CAST(design_capacity_mgd AS DOUBLE), 0)), 2)
      comment: "Average capacity utilization percentage across WWTPs (actual flow / design capacity). A critical executive KPI — plants consistently above 80% signal urgent capital investment need."
    - name: "total_peak_flow_mgd"
      expr: SUM(CAST(peak_flow_mgd AS DOUBLE))
      comment: "Total peak flow capacity across all WWTPs in MGD. Used to assess wet-weather surge capacity and SSO/CSO risk."
    - name: "avg_energy_consumption_kwh_per_mg"
      expr: AVG(CAST(energy_consumption_kwh_per_mg AS DOUBLE))
      comment: "Average energy intensity in kWh per million gallons treated. Drives energy efficiency benchmarking and sustainability reporting."
    - name: "non_compliant_wwtp_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status != 'In Compliance' THEN wwtp_id END)
      comment: "Number of WWTPs not currently in compliance with their operating permits. A leading indicator of regulatory enforcement risk and penalty exposure."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_sso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanitary Sewer Overflow (SSO) event metrics for regulatory compliance, environmental risk management, and operational response performance. SSOs are a primary regulatory and public health risk for wastewater utilities."
  source: "`water_utilities_ecm`.`wastewater`.`sso_event`"
  dimensions:
    - name: "sso_event_id"
      expr: sso_event_id
      comment: "Unique identifier for the SSO event."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the SSO event (e.g., Open, Closed, Under Investigation)."
    - name: "cause_category"
      expr: cause_category
      comment: "High-level category of the SSO root cause (e.g., Blockage, Capacity, Equipment Failure). Used to prioritize prevention programs."
    - name: "cause_code"
      expr: cause_code
      comment: "Specific cause code for the SSO event, enabling granular root cause analysis."
    - name: "overflow_location_type"
      expr: overflow_location_type
      comment: "Type of location where the overflow occurred (e.g., Manhole, Cleanout, Lift Station)."
    - name: "receiving_environment"
      expr: receiving_environment
      comment: "Environment that received the overflow (e.g., Surface Water, Storm Drain, Street). Determines environmental impact severity."
    - name: "receiving_water_body_name"
      expr: receiving_water_body_name
      comment: "Name of the water body that received the overflow, used for environmental impact tracking."
    - name: "weather_related"
      expr: weather_related
      comment: "Flag indicating whether the SSO was weather-related (True/False). Supports wet-weather vs. dry-weather SSO trend analysis."
    - name: "reached_surface_water"
      expr: reached_surface_water
      comment: "Flag indicating whether the overflow reached a surface water body (True/False). High-severity indicator for regulatory reporting."
    - name: "public_notification_required"
      expr: public_notification_required
      comment: "Flag indicating whether public notification was required for this SSO event."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "Discharge Monitoring Report (DMR) reporting period associated with the SSO event."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month the SSO event started, used for trend analysis and regulatory period reporting."
    - name: "event_start_year"
      expr: YEAR(event_start_timestamp)
      comment: "Year the SSO event started, used for annual regulatory reporting and year-over-year trend analysis."
  measures:
    - name: "total_sso_event_count"
      expr: COUNT(DISTINCT sso_event_id)
      comment: "Total number of SSO events. Primary regulatory KPI — utilities are required to minimize and report SSO frequency."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(estimated_volume_gallons AS DOUBLE))
      comment: "Total estimated volume of sewage overflowed in gallons. A critical environmental impact and regulatory compliance metric."
    - name: "total_volume_recovered_gallons"
      expr: SUM(CAST(volume_recovered_gallons AS DOUBLE))
      comment: "Total volume of overflow recovered in gallons. Measures effectiveness of spill response and environmental mitigation."
    - name: "avg_overflow_volume_gallons"
      expr: AVG(CAST(estimated_volume_gallons AS DOUBLE))
      comment: "Average overflow volume per SSO event in gallons. Tracks severity trends over time."
    - name: "avg_event_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of SSO events in minutes. Longer durations indicate slower detection or response — a key operational efficiency metric."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(UNIX_TIMESTAMP(response_timestamp) - UNIX_TIMESTAMP(discovery_timestamp) AS DOUBLE) / 60.0)
      comment: "Average operator response time in minutes from discovery to response. Measures operational readiness and emergency response performance."
    - name: "surface_water_impact_event_count"
      expr: COUNT(DISTINCT CASE WHEN reached_surface_water = TRUE THEN sso_event_id END)
      comment: "Number of SSO events that reached a surface water body. High-severity events with direct environmental and regulatory consequences."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties assessed for SSO events in USD. Directly quantifies the financial cost of non-compliance."
    - name: "weather_related_sso_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN weather_related = TRUE THEN sso_event_id END) / NULLIF(COUNT(DISTINCT sso_event_id), 0), 2)
      comment: "Percentage of SSO events that were weather-related. Informs capital investment decisions for wet-weather capacity improvements."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_cso_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Combined Sewer Overflow (CSO) event metrics for regulatory compliance, Long-Term Control Plan (LTCP) performance tracking, and environmental impact management. CSOs are a major regulatory focus under the Clean Water Act."
  source: "`water_utilities_ecm`.`wastewater`.`cso_event`"
  dimensions:
    - name: "cso_event_id"
      expr: cso_event_id
      comment: "Unique identifier for the CSO event."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the CSO event (e.g., Open, Closed, Reported)."
    - name: "cause_category"
      expr: cause_category
      comment: "Root cause category of the CSO event (e.g., Wet Weather, Capacity Exceedance)."
    - name: "outfall_designation"
      expr: outfall_designation
      comment: "Regulatory designation of the outfall associated with the CSO event."
    - name: "receiving_water_body_name"
      expr: receiving_water_body_name
      comment: "Name of the receiving water body impacted by the CSO discharge."
    - name: "receiving_water_body_classification"
      expr: receiving_water_body_classification
      comment: "Classification of the receiving water body (e.g., Impaired, Outstanding Resource Water)."
    - name: "dmr_submitted"
      expr: dmr_submitted
      comment: "Flag indicating whether the DMR was submitted for this CSO event. Tracks regulatory reporting compliance."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required for this CSO event."
    - name: "control_measure_active"
      expr: control_measure_active
      comment: "Flag indicating whether an active control measure is in place for this CSO outfall."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period for the CSO event, used for regulatory period aggregation."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month the CSO event started, used for seasonal and trend analysis."
    - name: "event_start_year"
      expr: YEAR(event_start_timestamp)
      comment: "Year the CSO event started, used for annual LTCP progress reporting."
  measures:
    - name: "total_cso_event_count"
      expr: COUNT(DISTINCT cso_event_id)
      comment: "Total number of CSO events. Primary LTCP performance metric — reduction in CSO frequency is a core regulatory objective."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Total volume of combined sewage overflowed in gallons. Key environmental impact metric for LTCP reporting and Clean Water Act compliance."
    - name: "total_overflow_volume_mgd"
      expr: SUM(CAST(overflow_volume_mgd AS DOUBLE))
      comment: "Total overflow volume in million gallons per day (MGD). Used for hydraulic capacity analysis and LTCP benchmarking."
    - name: "avg_event_duration_minutes"
      expr: AVG(CAST(event_duration_minutes AS DOUBLE))
      comment: "Average duration of CSO events in minutes. Longer events indicate greater environmental impact and potential control measure gaps."
    - name: "avg_precipitation_amount_inches"
      expr: AVG(CAST(precipitation_amount_inches AS DOUBLE))
      comment: "Average precipitation amount (inches) associated with CSO events. Used to establish rainfall-CSO activation thresholds for LTCP design."
    - name: "dmr_submission_compliance_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dmr_submitted = TRUE THEN cso_event_id END) / NULLIF(COUNT(DISTINCT cso_event_id), 0), 2)
      comment: "Percentage of CSO events for which DMR was submitted on time. Regulatory reporting compliance rate — failures trigger enforcement actions."
    - name: "post_event_monitoring_completion_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN post_event_monitoring_completed = TRUE THEN cso_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN post_event_monitoring_required = TRUE THEN cso_event_id END), 0), 2)
      comment: "Percentage of CSO events requiring post-event monitoring where monitoring was completed. Measures environmental stewardship and permit compliance."
    - name: "avg_operator_response_time_minutes"
      expr: AVG(CAST(operator_response_time_minutes AS DOUBLE))
      comment: "Average operator response time to CSO events in minutes. Measures emergency response effectiveness and SCADA/telemetry performance."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_effluent_parameter_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effluent quality and permit compliance metrics derived from discharge monitoring results. Tracks permit limit exceedances, parameter-level compliance rates, and mass loading — the core data for DMR reporting and NPDES permit compliance."
  source: "`water_utilities_ecm`.`wastewater`.`effluent_parameter_result`"
  dimensions:
    - name: "effluent_parameter_result_id"
      expr: effluent_parameter_result_id
      comment: "Unique identifier for the effluent parameter result record."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the effluent quality parameter (e.g., BOD, TSS, Total Nitrogen, E. coli). Primary grouping dimension for compliance analysis."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Regulatory parameter code (e.g., EPA parameter code) for standardized reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the individual result against the permit limit (e.g., Compliant, Exceedance)."
    - name: "permit_limit_type"
      expr: permit_limit_type
      comment: "Type of permit limit applied (e.g., Daily Maximum, Monthly Average). Determines regulatory consequence of exceedance."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., Grab, Composite). Affects regulatory validity of the result."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the parameter result (e.g., mg/L, CFU/100mL)."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency with jurisdiction over this permit condition (e.g., EPA, State DEQ)."
    - name: "data_validation_status"
      expr: data_validation_status
      comment: "Data quality validation status of the result (e.g., Validated, Rejected, Pending Review)."
    - name: "analysis_method"
      expr: analysis_method
      comment: "Analytical method used for the measurement (e.g., EPA Method 624). Ensures regulatory defensibility."
    - name: "sample_collection_month"
      expr: DATE_TRUNC('MONTH', sample_collection_date)
      comment: "Month of sample collection, used for monthly DMR period aggregation."
    - name: "sample_collection_year"
      expr: YEAR(sample_collection_date)
      comment: "Year of sample collection, used for annual compliance trend analysis."
  measures:
    - name: "total_sample_result_count"
      expr: COUNT(DISTINCT effluent_parameter_result_id)
      comment: "Total number of effluent parameter results. Baseline measure for sampling program completeness."
    - name: "exceedance_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Exceedance' THEN effluent_parameter_result_id END)
      comment: "Number of permit limit exceedances. Each exceedance is a potential NPDES violation requiring DMR reporting and may trigger enforcement."
    - name: "permit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN effluent_parameter_result_id END) / NULLIF(COUNT(DISTINCT effluent_parameter_result_id), 0), 2)
      comment: "Percentage of effluent parameter results in compliance with permit limits. Primary NPDES permit compliance KPI reported to regulators."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceed permit limits (for exceedances). Measures severity of non-compliance events."
    - name: "total_mass_loading_lbs_per_day"
      expr: SUM(CAST(mass_loading_lbs_per_day AS DOUBLE))
      comment: "Total pollutant mass loading in pounds per day across all measured parameters. Used for watershed load allocation and permit limit setting."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured concentration across all effluent parameter results. Used for trend analysis and permit limit negotiation."
    - name: "avg_permit_limit_value"
      expr: AVG(CAST(permit_limit_value AS DOUBLE))
      comment: "Average permit limit value across all applicable results. Used as a benchmark reference for compliance margin analysis."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_biosolids_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biosolids production, quality, and disposition metrics. Biosolids management is a significant cost center and regulatory obligation for WWTPs — tracking batch quality, pathogen class compliance, and disposition volumes is essential for 503 permit compliance."
  source: "`water_utilities_ecm`.`wastewater`.`biosolids_batch`"
  dimensions:
    - name: "biosolids_batch_id"
      expr: biosolids_batch_id
      comment: "Unique identifier for the biosolids batch."
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method used to dispose of or beneficially reuse the biosolids (e.g., Land Application, Landfill, Incineration). Drives cost and regulatory strategy."
    - name: "pathogen_class"
      expr: pathogen_class
      comment: "EPA 503 pathogen class of the biosolids batch (Class A or Class B). Determines allowable disposition methods and regulatory requirements."
    - name: "exceptional_quality_flag"
      expr: exceptional_quality_flag
      comment: "Flag indicating whether the batch meets EPA Exceptional Quality (EQ) standards. EQ biosolids have fewer use restrictions and higher market value."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Type of treatment process used to produce the biosolids (e.g., Anaerobic Digestion, Composting, Thermal Drying)."
    - name: "vector_attraction_reduction_method"
      expr: vector_attraction_reduction_method
      comment: "Method used to achieve vector attraction reduction as required by 40 CFR Part 503."
    - name: "disposition_site_name"
      expr: disposition_site_name
      comment: "Name of the site where biosolids were disposed or applied. Used for site-level compliance tracking."
    - name: "dmr_reporting_period"
      expr: dmr_reporting_period
      comment: "DMR reporting period for the biosolids batch, used for regulatory period aggregation."
    - name: "batch_month"
      expr: DATE_TRUNC('MONTH', batch_date)
      comment: "Month of the biosolids batch, used for production trend analysis."
    - name: "batch_year"
      expr: YEAR(batch_date)
      comment: "Year of the biosolids batch, used for annual 503 compliance reporting."
  measures:
    - name: "total_batch_count"
      expr: COUNT(DISTINCT biosolids_batch_id)
      comment: "Total number of biosolids batches produced. Baseline production volume metric."
    - name: "total_dry_weight_tons"
      expr: SUM(CAST(dry_weight_tons AS DOUBLE))
      comment: "Total dry weight of biosolids produced in tons. Primary production volume metric for 503 annual reporting and disposition planning."
    - name: "total_wet_weight_tons"
      expr: SUM(CAST(wet_weight_tons AS DOUBLE))
      comment: "Total wet weight of biosolids produced in tons. Used for hauling cost estimation and logistics planning."
    - name: "avg_percent_solids"
      expr: AVG(CAST(percent_solids AS DOUBLE))
      comment: "Average percent solids content of biosolids batches. Higher solids content reduces hauling costs and improves land application efficiency."
    - name: "avg_volatile_solids_reduction_pct"
      expr: AVG(CAST(volatile_solids_reduction_percent AS DOUBLE))
      comment: "Average volatile solids reduction percentage. A key 503 compliance metric — must meet minimum thresholds for Class A/B designation."
    - name: "exceptional_quality_batch_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exceptional_quality_flag = TRUE THEN biosolids_batch_id END) / NULLIF(COUNT(DISTINCT biosolids_batch_id), 0), 2)
      comment: "Percentage of biosolids batches achieving Exceptional Quality (EQ) status. EQ biosolids command higher reuse value and face fewer regulatory restrictions."
    - name: "avg_total_nitrogen_pct"
      expr: AVG(CAST(total_nitrogen_percent AS DOUBLE))
      comment: "Average total nitrogen percentage in biosolids. Determines agronomic value for land application and nutrient management plan requirements."
    - name: "avg_fecal_coliform_density"
      expr: AVG(CAST(fecal_coliform_density_mpn_per_gram AS DOUBLE))
      comment: "Average fecal coliform density in MPN per gram. Must meet 503 pathogen reduction standards — exceedances prevent beneficial reuse."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_iup_compliance_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Industrial User Pretreatment (IUP) compliance sampling metrics. Tracks industrial discharge compliance against pretreatment permit limits — a core regulatory obligation under the National Pretreatment Program."
  source: "`water_utilities_ecm`.`wastewater`.`iup_compliance_sample`"
  dimensions:
    - name: "iup_compliance_sample_id"
      expr: iup_compliance_sample_id
      comment: "Unique identifier for the IUP compliance sample."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the parameter sampled (e.g., Copper, Zinc, BOD, TSS). Primary grouping dimension for pollutant-level compliance analysis."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Regulatory parameter code for standardized pretreatment reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the sample result against the IUP permit limit (e.g., Compliant, Violation)."
    - name: "permit_limit_type"
      expr: permit_limit_type
      comment: "Type of permit limit (e.g., Daily Maximum, Monthly Average) applicable to this sample."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., Grab, Composite). Affects regulatory validity."
    - name: "violation_notice_issued"
      expr: violation_notice_issued
      comment: "Flag indicating whether a violation notice was issued for this sample result."
    - name: "enforcement_action_required"
      expr: enforcement_action_required
      comment: "Flag indicating whether enforcement action is required based on this sample result."
    - name: "sample_month"
      expr: DATE_TRUNC('MONTH', sample_date)
      comment: "Month of sample collection, used for monthly compliance period aggregation."
    - name: "sample_year"
      expr: YEAR(sample_date)
      comment: "Year of sample collection, used for annual pretreatment program reporting."
  measures:
    - name: "total_sample_count"
      expr: COUNT(DISTINCT iup_compliance_sample_id)
      comment: "Total number of IUP compliance samples collected. Measures pretreatment program sampling completeness."
    - name: "violation_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Violation' THEN iup_compliance_sample_id END)
      comment: "Number of IUP compliance samples with permit limit violations. Each violation may require enforcement action and regulatory reporting."
    - name: "iup_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN iup_compliance_sample_id END) / NULLIF(COUNT(DISTINCT iup_compliance_sample_id), 0), 2)
      comment: "Percentage of IUP compliance samples meeting permit limits. Primary pretreatment program performance KPI reported to EPA/state regulators."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceed IUP permit limits (for violations). Measures severity of industrial discharge non-compliance."
    - name: "violation_notice_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN violation_notice_issued = TRUE THEN iup_compliance_sample_id END) / NULLIF(COUNT(DISTINCT CASE WHEN compliance_status = 'Violation' THEN iup_compliance_sample_id END), 0), 2)
      comment: "Percentage of violations for which a violation notice was issued. Measures enforcement program responsiveness — low rates indicate enforcement gaps."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured concentration across all IUP compliance samples. Used for trend analysis and permit limit adequacy review."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_fog_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fats, Oils, and Grease (FOG) inspection program metrics. FOG accumulation is a leading cause of SSOs — tracking inspection outcomes, compliance rates, and enforcement actions is critical for SSO prevention and collection system protection."
  source: "`water_utilities_ecm`.`wastewater`.`fog_inspection`"
  dimensions:
    - name: "fog_inspection_id"
      expr: fog_inspection_id
      comment: "Unique identifier for the FOG inspection record."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of FOG inspection conducted (e.g., Routine, Follow-Up, Complaint-Driven)."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the FOG inspection (e.g., Completed, Pending, Cancelled)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the inspected establishment (e.g., Compliant, Non-Compliant)."
    - name: "interceptor_type"
      expr: interceptor_type
      comment: "Type of grease interceptor at the establishment (e.g., Gravity, Hydromechanical). Affects compliance requirements."
    - name: "interceptor_condition"
      expr: interceptor_condition
      comment: "Physical condition of the grease interceptor (e.g., Good, Fair, Poor). Drives maintenance and enforcement decisions."
    - name: "violations_noted"
      expr: violations_noted
      comment: "Flag indicating whether violations were noted during the inspection."
    - name: "enforcement_action_recommended"
      expr: enforcement_action_recommended
      comment: "Flag indicating whether enforcement action was recommended based on inspection findings."
    - name: "re_inspection_required"
      expr: re_inspection_required
      comment: "Flag indicating whether a re-inspection is required. Tracks follow-up compliance workload."
    - name: "best_management_practices_compliant"
      expr: best_management_practices_compliant
      comment: "Flag indicating whether the establishment is compliant with required Best Management Practices (BMPs)."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity classification of violations noted (e.g., Minor, Major, Critical). Prioritizes enforcement response."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the FOG inspection, used for program activity trend analysis."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of the FOG inspection, used for annual program performance reporting."
  measures:
    - name: "total_inspection_count"
      expr: COUNT(DISTINCT fog_inspection_id)
      comment: "Total number of FOG inspections conducted. Measures FOG program activity and coverage."
    - name: "non_compliant_inspection_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Non-Compliant' THEN fog_inspection_id END)
      comment: "Number of FOG inspections resulting in non-compliance findings. Identifies high-risk establishments contributing to SSO risk."
    - name: "fog_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN fog_inspection_id END) / NULLIF(COUNT(DISTINCT fog_inspection_id), 0), 2)
      comment: "Percentage of FOG inspections resulting in compliance. Primary FOG program effectiveness KPI — directly linked to SSO prevention."
    - name: "avg_grease_depth_inches"
      expr: AVG(CAST(grease_depth_inches AS DOUBLE))
      comment: "Average grease depth in inches measured during inspections. Tracks FOG accumulation severity across the program."
    - name: "avg_grease_depth_percentage"
      expr: AVG(CAST(grease_depth_percentage AS DOUBLE))
      comment: "Average grease depth as a percentage of interceptor capacity. Values above 25% typically trigger enforcement — a key operational threshold metric."
    - name: "enforcement_action_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enforcement_action_recommended = TRUE THEN fog_inspection_id END) / NULLIF(COUNT(DISTINCT fog_inspection_id), 0), 2)
      comment: "Percentage of FOG inspections resulting in an enforcement action recommendation. Measures program enforcement intensity and non-compliance severity."
    - name: "re_inspection_required_count"
      expr: COUNT(DISTINCT CASE WHEN re_inspection_required = TRUE THEN fog_inspection_id END)
      comment: "Number of inspections requiring a follow-up re-inspection. Drives FOG program workload planning and compliance follow-through tracking."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_sewer_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sewer collection system inspection metrics for asset condition management, rehabilitation prioritization, and SSO risk reduction. CCTV and PACP/MACP inspection data drives capital planning for pipe rehabilitation programs."
  source: "`water_utilities_ecm`.`wastewater`.`sewer_inspection`"
  dimensions:
    - name: "sewer_inspection_id"
      expr: sewer_inspection_id
      comment: "Unique identifier for the sewer inspection record."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of sewer inspection (e.g., CCTV, Manhole, Smoke Test). Determines data quality and regulatory applicability."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for the inspection (e.g., CCTV, Visual, Sonar). Affects condition assessment accuracy."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Completed, Pending Review, Cancelled)."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Overall condition grade assigned to the inspected asset (e.g., Grade 1-5 per PACP). Drives rehabilitation prioritization."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency classification for recommended action (e.g., Immediate, Short-Term, Long-Term). Prioritizes capital program scheduling."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the inspected pipe (e.g., VCP, PVC, Concrete). Used for material-specific deterioration analysis."
    - name: "asset_type"
      expr: asset_type
      comment: "Type of sewer asset inspected (e.g., Gravity Main, Force Main, Manhole)."
    - name: "structural_defect_flag"
      expr: structural_defect_flag
      comment: "Flag indicating whether structural defects were observed. Structural defects pose collapse and SSO risk."
    - name: "critical_defect_flag"
      expr: critical_defect_flag
      comment: "Flag indicating whether critical defects requiring immediate action were observed."
    - name: "infiltration_observed_flag"
      expr: infiltration_observed_flag
      comment: "Flag indicating whether infiltration was observed during inspection. Infiltration contributes to I/I flow and treatment cost."
    - name: "root_intrusion_flag"
      expr: root_intrusion_flag
      comment: "Flag indicating whether root intrusion was observed. Root intrusion is a leading cause of blockages and SSOs."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of the sewer inspection, used for annual inspection program performance reporting."
  measures:
    - name: "total_inspection_count"
      expr: COUNT(DISTINCT sewer_inspection_id)
      comment: "Total number of sewer inspections completed. Measures inspection program coverage and activity."
    - name: "total_inspection_length_feet"
      expr: SUM(CAST(inspection_length_feet AS DOUBLE))
      comment: "Total linear feet of sewer pipe inspected. Primary measure of inspection program coverage relative to total system length."
    - name: "critical_defect_count"
      expr: COUNT(DISTINCT CASE WHEN critical_defect_flag = TRUE THEN sewer_inspection_id END)
      comment: "Number of inspections identifying critical defects requiring immediate action. Drives emergency rehabilitation prioritization and SSO risk mitigation."
    - name: "critical_defect_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN critical_defect_flag = TRUE THEN sewer_inspection_id END) / NULLIF(COUNT(DISTINCT sewer_inspection_id), 0), 2)
      comment: "Percentage of inspections identifying critical defects. A rising rate signals accelerating infrastructure deterioration requiring capital response."
    - name: "total_estimated_repair_cost_usd"
      expr: SUM(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Total estimated repair cost for all inspected defects in USD. Quantifies the capital investment backlog identified through the inspection program."
    - name: "avg_estimated_repair_cost_usd"
      expr: AVG(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Average estimated repair cost per inspection in USD. Used for capital program budgeting and unit cost benchmarking."
    - name: "infiltration_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN infiltration_observed_flag = TRUE THEN sewer_inspection_id END) / NULLIF(COUNT(DISTINCT sewer_inspection_id), 0), 2)
      comment: "Percentage of inspections where infiltration was observed. High rates indicate I/I problem areas requiring targeted rehabilitation to reduce treatment costs."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_lift_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lift station asset portfolio metrics for capacity management, SSO risk assessment, and capital planning. Lift stations are critical infrastructure nodes — failures directly cause SSOs and service disruptions."
  source: "`water_utilities_ecm`.`wastewater`.`lift_station`"
  dimensions:
    - name: "lift_station_id"
      expr: lift_station_id
      comment: "Unique identifier for the lift station."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the lift station (e.g., Active, Offline, Under Maintenance)."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the lift station (e.g., High, Medium, Low). Drives maintenance prioritization and capital investment decisions."
    - name: "station_type"
      expr: station_type
      comment: "Type of lift station (e.g., Submersible, Dry Pit, Wet Pit). Affects maintenance requirements and failure modes."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the lift station (e.g., Public, Private). Determines maintenance responsibility."
    - name: "sso_risk_flag"
      expr: sso_risk_flag
      comment: "Flag indicating whether the lift station has been identified as an SSO risk. High-priority assets for capital investment and monitoring."
    - name: "scada_integration_flag"
      expr: scada_integration_flag
      comment: "Flag indicating whether the lift station is integrated with SCADA for remote monitoring. Non-SCADA stations have higher SSO risk."
    - name: "backup_power_type"
      expr: backup_power_type
      comment: "Type of backup power available at the lift station (e.g., Generator, None). Stations without backup power are high SSO risk during outages."
    - name: "pump_configuration"
      expr: pump_configuration
      comment: "Pump configuration at the lift station (e.g., Duplex, Triplex). Affects redundancy and reliability."
    - name: "service_area_name"
      expr: service_area_name
      comment: "Name of the service area served by the lift station. Used for geographic performance analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the lift station is located."
  measures:
    - name: "total_lift_station_count"
      expr: COUNT(DISTINCT lift_station_id)
      comment: "Total number of lift stations in the portfolio. Baseline asset count for portfolio management."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design pumping capacity across all lift stations in MGD. Used for system hydraulic capacity planning."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total replacement cost of the lift station portfolio in USD. Quantifies the capital asset value at risk and informs long-term capital planning."
    - name: "total_annual_operating_cost_usd"
      expr: SUM(CAST(annual_operating_cost_usd AS DOUBLE))
      comment: "Total annual operating cost across all lift stations in USD. Drives O&M budget planning and cost efficiency benchmarking."
    - name: "avg_asset_condition_score"
      expr: AVG(CAST(asset_condition_score AS DOUBLE))
      comment: "Average asset condition score across all lift stations. Declining scores signal increasing rehabilitation investment needs."
    - name: "sso_risk_station_count"
      expr: COUNT(DISTINCT CASE WHEN sso_risk_flag = TRUE THEN lift_station_id END)
      comment: "Number of lift stations flagged as SSO risk. Directly informs capital prioritization for SSO prevention programs."
    - name: "scada_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN scada_integration_flag = TRUE THEN lift_station_id END) / NULLIF(COUNT(DISTINCT lift_station_id), 0), 2)
      comment: "Percentage of lift stations with SCADA integration. Low SCADA coverage increases SSO risk and is a key operational resilience metric."
    - name: "avg_pump_horsepower"
      expr: AVG(CAST(pump_horsepower AS DOUBLE))
      comment: "Average pump horsepower across lift stations. Used for energy consumption benchmarking and pump sizing analysis."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`wastewater_ii_flow_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infiltration and Inflow (I/I) flow measurement metrics for collection system performance management. Excess I/I increases treatment costs, causes SSOs during wet weather, and is a primary driver of sewer rehabilitation capital programs."
  source: "`water_utilities_ecm`.`wastewater`.`ii_flow_measurement`"
  dimensions:
    - name: "ii_flow_measurement_id"
      expr: ii_flow_measurement_id
      comment: "Unique identifier for the I/I flow measurement record."
    - name: "ii_type"
      expr: ii_type
      comment: "Type of I/I measured (e.g., Infiltration, Inflow, Combined). Distinguishes groundwater infiltration from surface water inflow for targeted remediation."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure flow (e.g., Ultrasonic, Electromagnetic, V-Notch Weir). Affects measurement accuracy and data quality."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the measurement (e.g., Good, Suspect, Invalid). Used to filter analysis to validated data."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the flow measurement (e.g., Validated, Pending, Rejected)."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of measurement (e.g., Dry, Wet, Post-Storm). Enables dry-weather vs. wet-weather I/I analysis."
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Flag indicating whether a flow alarm was triggered during this measurement period."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm triggered (e.g., High Flow, Surcharge). Categorizes operational alert severity."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of the flow measurement, used for seasonal I/I trend analysis."
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year of the flow measurement, used for annual I/I program reporting."
  measures:
    - name: "total_measurement_count"
      expr: COUNT(DISTINCT ii_flow_measurement_id)
      comment: "Total number of I/I flow measurements recorded. Measures monitoring program coverage."
    - name: "total_calculated_ii_volume_gallons"
      expr: SUM(CAST(calculated_ii_volume_gallons AS DOUBLE))
      comment: "Total calculated I/I volume in gallons. Quantifies the total excess flow burden on the collection system and treatment plant."
    - name: "avg_measured_flow_rate_mgd"
      expr: AVG(CAST(measured_flow_rate_mgd AS DOUBLE))
      comment: "Average measured flow rate in MGD across all monitoring points. Baseline for I/I contribution analysis."
    - name: "avg_peak_flow_rate_gpm"
      expr: AVG(CAST(peak_flow_rate_gpm AS DOUBLE))
      comment: "Average peak flow rate in GPM. Peak flows drive SSO risk and treatment plant hydraulic loading during wet weather events."
    - name: "avg_dry_weather_baseline_gpm"
      expr: AVG(CAST(dry_weather_baseline_gpm AS DOUBLE))
      comment: "Average dry weather baseline flow in GPM. Used as the reference for calculating I/I volume above baseline."
    - name: "avg_rainfall_depth_inches"
      expr: AVG(CAST(rainfall_depth_inches AS DOUBLE))
      comment: "Average rainfall depth in inches associated with flow measurements. Used to establish rainfall-response curves for I/I characterization."
    - name: "alarm_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN alarm_triggered_flag = TRUE THEN ii_flow_measurement_id END) / NULLIF(COUNT(DISTINCT ii_flow_measurement_id), 0), 2)
      comment: "Percentage of flow measurement periods that triggered a flow alarm. High rates indicate chronic hydraulic overloading and SSO risk."
$$;