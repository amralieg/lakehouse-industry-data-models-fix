-- Metric views for domain: distribution | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_nrw_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Revenue Water (NRW) and Unaccounted-For Water (UFW) performance metrics derived from the IWA water balance audit. These KPIs are the primary executive lens for water loss management, regulatory compliance, and infrastructure investment prioritisation."
  source: "`water_utilities_ecm`.`distribution`.`nrw_water_balance`"
  dimensions:
    - name: "audit_period_type"
      expr: audit_period_type
      comment: "Granularity of the audit period (e.g. Monthly, Quarterly, Annual) — enables trending at different time horizons."
    - name: "audit_period_start_date"
      expr: audit_period_start_date
      comment: "Start date of the water balance audit period for time-series analysis."
    - name: "audit_period_end_date"
      expr: audit_period_end_date
      comment: "End date of the water balance audit period."
    - name: "audit_status"
      expr: audit_status
      comment: "Workflow status of the audit (e.g. Draft, Approved, Submitted) — filters to only approved/final records for reporting."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the water balance audit (e.g. IWA Top-Down, AWWA Free Water Audit) — supports methodology benchmarking."
    - name: "data_grading"
      expr: data_grading
      comment: "IWA data validity grading (A–D) indicating confidence level of the audit inputs — critical for interpreting KPI reliability."
    - name: "data_validity_score"
      expr: data_validity_score
      comment: "Numeric data validity score from the IWA audit tool — higher scores indicate more reliable loss estimates."
  measures:
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non-Revenue Water percentage across audit periods. The primary executive KPI for water loss performance; regulatory thresholds and investment decisions are benchmarked against this figure."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water percentage. Complements NRW% by isolating the portion of water loss that cannot be attributed to any known consumption category."
    - name: "total_nrw_volume_mg"
      expr: SUM(CAST(nrw_volume_mg AS DOUBLE))
      comment: "Total Non-Revenue Water volume in million gallons. Translates the percentage KPI into an absolute volumetric loss figure used for cost quantification and infrastructure investment sizing."
    - name: "total_system_input_volume_mg"
      expr: SUM(CAST(system_input_volume_mg AS DOUBLE))
      comment: "Total water injected into the distribution system in million gallons. The denominator for all loss-rate calculations and a key throughput metric for capacity planning."
    - name: "total_real_losses_mg"
      expr: SUM(CAST(real_losses_mg AS DOUBLE))
      comment: "Total physical (real) losses in million gallons — primarily pipe leakage and storage tank overflows. Drives capital rehabilitation programmes and leak detection investment."
    - name: "total_apparent_losses_mg"
      expr: SUM(CAST(apparent_losses_mg AS DOUBLE))
      comment: "Total commercial (apparent) losses in million gallons — meter inaccuracies, data errors, and unauthorised consumption. Drives meter replacement and revenue protection programmes."
    - name: "avg_infrastructure_leakage_index"
      expr: AVG(CAST(infrastructure_leakage_index AS DOUBLE))
      comment: "Average Infrastructure Leakage Index (ILI = Current Annual Real Losses / Unavoidable Annual Real Losses). The international benchmark for physical loss efficiency; ILI > 1 indicates recoverable leakage."
    - name: "total_water_losses_mg"
      expr: SUM(CAST(water_losses_mg AS DOUBLE))
      comment: "Total water losses (real + apparent) in million gallons. The aggregate loss figure used in regulatory submissions and rate-case filings."
    - name: "total_billed_metered_consumption_mg"
      expr: SUM(CAST(billed_metered_consumption_mg AS DOUBLE))
      comment: "Total billed and metered consumption in million gallons. The revenue-generating portion of system input; growth in this metric directly improves NRW%."
    - name: "total_authorized_consumption_mg"
      expr: SUM(CAST(authorized_consumption_mg AS DOUBLE))
      comment: "Total authorised consumption (billed + unbilled) in million gallons. Establishes the legitimate demand baseline against which losses are measured."
    - name: "avg_current_annual_real_losses_mg"
      expr: AVG(CAST(current_annual_real_losses_mg AS DOUBLE))
      comment: "Average current annual real losses in million gallons. Used alongside unavoidable annual real losses to compute ILI and set leakage reduction targets."
    - name: "avg_system_pressure_psi"
      expr: AVG(CAST(average_system_pressure_psi AS DOUBLE))
      comment: "Average system operating pressure in PSI across audit periods. Pressure is the primary driver of real losses; this metric supports pressure management investment decisions."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Main break frequency, severity, and response-time metrics. These KPIs directly inform pipe rehabilitation prioritisation, capital investment planning, regulatory reporting, and customer service performance."
  source: "`water_utilities_ecm`.`distribution`.`main_break`"
  dimensions:
    - name: "break_type"
      expr: break_type
      comment: "Classification of the break (e.g. Circumferential, Longitudinal, Joint Failure) — identifies failure modes driving rehabilitation strategy."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the failed pipe (e.g. Cast Iron, PVC, Ductile Iron) — the primary dimension for asset condition and replacement prioritisation."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the break record (e.g. Reported, In Repair, Closed) — used to track open incidents and repair backlog."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the main break (e.g. Corrosion, Ground Movement, Pressure Surge) — drives targeted maintenance and capital programmes."
    - name: "priority_level"
      expr: priority_level
      comment: "Operational priority assigned to the break (e.g. Emergency, High, Routine) — used to assess response-time compliance."
    - name: "boil_water_advisory_issued"
      expr: boil_water_advisory_issued
      comment: "Flag indicating whether a boil-water advisory was issued — a key public health and regulatory compliance dimension."
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Flag indicating whether a regulatory report is required for this break — filters to compliance-sensitive incidents."
    - name: "break_timestamp"
      expr: break_timestamp
      comment: "Timestamp of the break event — enables time-series trending of break frequency."
  measures:
    - name: "total_main_breaks"
      expr: COUNT(1)
      comment: "Total number of main breaks recorded. The primary frequency KPI used in regulatory reporting (breaks per 100 miles of main) and asset condition benchmarking."
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water lost due to main breaks in gallons. Quantifies the volumetric and financial impact of pipe failures; feeds directly into NRW water balance calculations."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average time to complete a main break repair in hours. A key customer service and operational efficiency KPI; prolonged repairs increase customer impact and water loss."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure at break locations in PSI. Elevated pressure is a leading indicator of break risk; this metric supports pressure management investment decisions."
    - name: "avg_pipe_diameter_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average diameter of failed pipes in inches. Larger-diameter breaks carry higher consequence; this metric supports risk-based rehabilitation prioritisation."
    - name: "boil_water_advisory_count"
      expr: COUNT(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 END)
      comment: "Number of main breaks that triggered a boil-water advisory. A direct public health and regulatory compliance KPI tracked by health authorities and reported to regulators."
    - name: "regulatory_reportable_break_count"
      expr: COUNT(CASE WHEN regulatory_report_required = TRUE THEN 1 END)
      comment: "Number of main breaks requiring regulatory reporting. Tracks compliance exposure and submission workload for the regulatory affairs team."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_leak_detection_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leak detection survey coverage, effectiveness, and cost metrics. These KPIs govern the proactive leakage management programme — a core driver of NRW reduction and regulatory compliance."
  source: "`water_utilities_ecm`.`distribution`.`leak_detection_survey`"
  dimensions:
    - name: "survey_method"
      expr: survey_method
      comment: "Detection technology used (e.g. Acoustic, Correlator, Ground Penetrating Radar) — enables method effectiveness benchmarking."
    - name: "survey_status"
      expr: survey_status
      comment: "Workflow status of the survey (e.g. Scheduled, In Progress, Completed) — tracks programme execution against plan."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Result of the survey (e.g. Leak Found, No Leak, Inconclusive) — the primary effectiveness dimension."
    - name: "survey_priority"
      expr: survey_priority
      comment: "Priority assigned to the survey (e.g. High, Medium, Low) — reflects risk-based scheduling of DMA coverage."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Quality flag on survey data — used to filter out low-confidence records from performance reporting."
    - name: "repair_work_order_generated"
      expr: repair_work_order_generated
      comment: "Flag indicating whether a repair work order was raised following the survey — measures conversion from detection to remediation."
    - name: "survey_date"
      expr: survey_date
      comment: "Date the survey was conducted — enables time-series tracking of survey programme cadence."
  measures:
    - name: "total_surveys_completed"
      expr: COUNT(1)
      comment: "Total number of leak detection surveys conducted. Measures programme coverage and activity volume against the planned survey schedule."
    - name: "total_survey_length_feet"
      expr: SUM(CAST(survey_length_feet AS DOUBLE))
      comment: "Total pipe length surveyed in feet. The primary coverage metric — compared against total main length to compute network survey coverage percentage."
    - name: "total_estimated_leak_rate_gpm"
      expr: SUM(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Total estimated leak rate identified across all surveys in gallons per minute. Quantifies the volume of leakage detected and available for remediation."
    - name: "avg_estimated_leak_rate_gpm"
      expr: AVG(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Average estimated leak rate per survey in gallons per minute. Benchmarks the severity of leaks found and informs repair prioritisation."
    - name: "surveys_with_leaks_found"
      expr: COUNT(CASE WHEN survey_outcome = 'Leak Found' THEN 1 END)
      comment: "Number of surveys that identified at least one leak. The numerator for survey detection rate — a key programme effectiveness KPI."
    - name: "repair_work_orders_generated_count"
      expr: COUNT(CASE WHEN repair_work_order_generated = TRUE THEN 1 END)
      comment: "Number of surveys that resulted in a repair work order being raised. Measures the conversion rate from detection to active remediation — a critical NRW reduction pipeline metric."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution network flow and pressure telemetry metrics. These KPIs support hydraulic performance monitoring, minimum night flow analysis for leakage estimation, and SCADA data quality governance."
  source: "`water_utilities_ecm`.`distribution`.`flow_reading`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. Inlet, Outlet, Zone Boundary) — essential for distinguishing DMA input/output flows used in leakage calculations."
    - name: "flow_direction"
      expr: flow_direction
      comment: "Direction of flow (e.g. Forward, Reverse) — reverse flow is an operational anomaly indicator."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation status (e.g. Validated, Estimated, Rejected) — filters to quality-assured readings for KPI computation."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality classification flag — used to exclude suspect readings from hydraulic model calibration and NRW calculations."
    - name: "estimated_flag"
      expr: estimated_flag
      comment: "Indicates whether the reading was estimated rather than directly measured — estimated readings carry higher uncertainty in leakage calculations."
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Indicates whether an alarm condition was active during the reading — alarm readings signal hydraulic anomalies requiring investigation."
    - name: "nrw_calculation_flag"
      expr: nrw_calculation_flag
      comment: "Indicates whether this reading is included in NRW water balance calculations — ensures only designated meters contribute to loss accounting."
    - name: "reading_timestamp"
      expr: reading_timestamp
      comment: "Timestamp of the flow reading — enables time-of-day and minimum night flow analysis."
    - name: "engineering_unit"
      expr: engineering_unit
      comment: "Unit of measurement for the flow value (e.g. GPM, MGD, m³/h) — required for unit-consistent aggregation."
  measures:
    - name: "avg_flow_value"
      expr: AVG(CAST(flow_value AS DOUBLE))
      comment: "Average flow rate across all readings. The baseline hydraulic performance metric used to assess demand patterns and detect anomalies against expected flow profiles."
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total cumulative flow volume across all readings. Used to compute system input volumes for NRW water balance calculations."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average network pressure in PSI across all readings. Pressure management is the most cost-effective lever for real loss reduction; this metric drives PRV set-point optimisation."
    - name: "alarm_reading_count"
      expr: COUNT(CASE WHEN alarm_flag = TRUE THEN 1 END)
      comment: "Number of readings with an active alarm condition. Elevated alarm counts indicate hydraulic anomalies (burst events, pressure exceedances) requiring operational response."
    - name: "estimated_reading_count"
      expr: COUNT(CASE WHEN estimated_flag = TRUE THEN 1 END)
      comment: "Number of estimated (non-measured) readings. High estimation rates degrade NRW calculation accuracy and trigger meter maintenance or replacement programmes."
    - name: "avg_meter_accuracy_percent"
      expr: AVG(CAST(meter_accuracy_percent AS DOUBLE))
      comment: "Average meter accuracy percentage across readings. Meter inaccuracy is a primary driver of apparent losses; this metric governs the meter replacement and calibration programme."
    - name: "total_totalizer_reading"
      expr: SUM(CAST(totalizer_reading AS DOUBLE))
      comment: "Sum of totalizer (cumulative volume) readings. Used to cross-validate interval flow data against cumulative meter registers for data quality assurance."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_hydrant_flow_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fire hydrant flow test performance metrics. These KPIs assess fire flow adequacy, ISO rating compliance, and hydraulic model calibration status — directly impacting public safety, insurance ratings, and regulatory standing."
  source: "`water_utilities_ecm`.`distribution`.`hydrant_flow_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Status of the flow test (e.g. Pass, Fail, Inconclusive) — the primary compliance dimension for fire flow adequacy."
    - name: "test_type"
      expr: test_type
      comment: "Type of test conducted (e.g. Routine, Fire Incident, ISO Rating) — distinguishes regulatory from operational tests."
    - name: "nfpa_color_classification"
      expr: nfpa_color_classification
      comment: "NFPA 291 colour classification (Blue/Green/Orange/Red) indicating available fire flow capacity — the standard fire protection adequacy dimension."
    - name: "iso_fire_flow_adequacy"
      expr: iso_fire_flow_adequacy
      comment: "ISO fire flow adequacy rating — directly impacts the community's ISO Public Protection Classification and property insurance premiums."
    - name: "iso_rating_submitted"
      expr: iso_rating_submitted
      comment: "Flag indicating whether the test result was submitted to ISO — tracks regulatory submission compliance."
    - name: "hydraulic_model_updated"
      expr: hydraulic_model_updated
      comment: "Flag indicating whether the hydraulic model was updated with test results — measures model calibration currency."
    - name: "test_date"
      expr: test_date
      comment: "Date the flow test was conducted — enables trending of test programme cadence and identification of overdue hydrants."
    - name: "hydrant_condition_observed"
      expr: hydrant_condition_observed
      comment: "Physical condition of the hydrant observed during testing — feeds asset condition management and maintenance scheduling."
  measures:
    - name: "total_flow_tests"
      expr: COUNT(1)
      comment: "Total number of hydrant flow tests conducted. Measures programme coverage against the required testing schedule for ISO compliance."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average measured flow rate in GPM across all tests. Benchmarks network fire flow delivery capability against NFPA and ISO minimum thresholds."
    - name: "avg_available_flow_at_20psi_gpm"
      expr: AVG(CAST(available_flow_at_20psi_gpm AS DOUBLE))
      comment: "Average available fire flow at the 20 PSI residual pressure threshold in GPM. The ISO-standard fire flow adequacy metric used to classify hydrants and set insurance ratings."
    - name: "avg_residual_pressure_psi"
      expr: AVG(CAST(residual_pressure_psi AS DOUBLE))
      comment: "Average residual pressure during flow tests in PSI. Residual pressure below 20 PSI during fire flow indicates inadequate system capacity — a critical public safety metric."
    - name: "avg_static_pressure_psi"
      expr: AVG(CAST(static_pressure_psi AS DOUBLE))
      comment: "Average static pressure at test locations in PSI. Establishes the baseline pressure available before fire flow demand — used in hydraulic model calibration."
    - name: "iso_submitted_test_count"
      expr: COUNT(CASE WHEN iso_rating_submitted = TRUE THEN 1 END)
      comment: "Number of tests submitted to ISO for rating purposes. Tracks regulatory submission compliance and the proportion of the network with current ISO fire flow data."
    - name: "hydraulic_model_updated_count"
      expr: COUNT(CASE WHEN hydraulic_model_updated = TRUE THEN 1 END)
      comment: "Number of tests used to update the hydraulic model. Measures model calibration currency — an outdated model increases risk of incorrect capacity assessments."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_flushing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water main flushing programme metrics covering volume discharged, water quality improvement, and programme efficiency. These KPIs govern water quality compliance, customer complaint response, and operational cost management."
  source: "`water_utilities_ecm`.`distribution`.`flushing_event`"
  dimensions:
    - name: "flush_reason"
      expr: flush_reason
      comment: "Reason for the flushing event (e.g. Routine, Complaint, Post-Repair, Disinfection) — the primary dimension for understanding programme drivers and cost allocation."
    - name: "flushing_method"
      expr: flushing_method
      comment: "Flushing technique used (e.g. Conventional, Unidirectional) — unidirectional flushing is more effective and water-efficient; this dimension supports method optimisation."
    - name: "flush_status"
      expr: flush_status
      comment: "Completion status of the flushing event (e.g. Completed, Cancelled, In Progress) — filters to completed events for volume and quality metrics."
    - name: "flush_effectiveness_rating"
      expr: flush_effectiveness_rating
      comment: "Qualitative effectiveness rating assigned post-flush — used to benchmark method and location effectiveness."
    - name: "water_quality_sample_collected"
      expr: water_quality_sample_collected
      comment: "Flag indicating whether a water quality sample was collected post-flush — measures compliance with post-flush verification protocols."
    - name: "public_notification_sent"
      expr: public_notification_sent
      comment: "Flag indicating whether public notification was issued — tracks compliance with customer communication requirements."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether a follow-up action is required — measures the proportion of flushes that did not fully resolve the underlying issue."
    - name: "flush_date"
      expr: flush_date
      comment: "Date of the flushing event — enables seasonal and time-series analysis of programme activity."
  measures:
    - name: "total_flushing_events"
      expr: COUNT(1)
      comment: "Total number of flushing events conducted. Measures programme activity volume and is used to compute cost-per-flush and water-per-flush efficiency metrics."
    - name: "total_volume_discharged_gallons"
      expr: SUM(CAST(volume_discharged_gallons AS DOUBLE))
      comment: "Total water volume discharged during flushing in gallons. A direct operational cost metric — flushing water is treated water that generates no revenue and contributes to NRW."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flushing flow rate in GPM. Higher flow rates improve sediment removal effectiveness; this metric supports method and equipment optimisation."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of flushing events in minutes. Combined with flow rate, this drives volume-per-event calculations and crew productivity benchmarking."
    - name: "avg_pre_flush_chlorine_residual"
      expr: AVG(CAST(pre_flush_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average chlorine residual before flushing in mg/L. Low pre-flush residuals indicate water quality deterioration in the distribution system — a regulatory compliance trigger."
    - name: "avg_post_flush_chlorine_residual"
      expr: AVG(CAST(post_flush_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average chlorine residual after flushing in mg/L. Post-flush residual must meet regulatory minimums; this metric validates flushing effectiveness for water quality compliance."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of flushing events requiring follow-up action. Elevated counts indicate persistent water quality issues or infrastructure problems that flushing alone cannot resolve."
    - name: "quality_sample_collected_count"
      expr: COUNT(CASE WHEN water_quality_sample_collected = TRUE THEN 1 END)
      comment: "Number of flushing events where a post-flush water quality sample was collected. Measures compliance with post-flush verification protocols required by drinking water regulations."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_valve_exercise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network valve exercising programme metrics covering operability, deficiency rates, and programme compliance. Valve operability is a critical emergency response and isolation capability metric — inoperable valves directly increase main break repair times and customer impact."
  source: "`water_utilities_ecm`.`distribution`.`valve_exercise`"
  dimensions:
    - name: "exercise_status"
      expr: exercise_status
      comment: "Outcome status of the exercise event (e.g. Completed, Failed, Partial) — the primary programme compliance dimension."
    - name: "operability_status"
      expr: operability_status
      comment: "Post-exercise operability classification (e.g. Operable, Inoperable, Requires Repair) — the key asset condition KPI for emergency response readiness."
    - name: "deficiency_noted"
      expr: deficiency_noted
      comment: "Flag indicating whether a deficiency was identified during exercising — drives the valve repair and replacement backlog."
    - name: "deficiency_code"
      expr: deficiency_code
      comment: "Coded classification of the deficiency type — enables root-cause analysis and targeted maintenance programme design."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether a follow-up work order is required — measures the proportion of exercises that identified actionable deficiencies."
    - name: "leak_detected"
      expr: leak_detected
      comment: "Flag indicating whether a leak was detected at the valve during exercising — valve exercising is a secondary leak detection mechanism."
    - name: "exercise_date"
      expr: exercise_date
      comment: "Date the valve was exercised — enables tracking of programme cadence and identification of overdue valves."
    - name: "exercise_method"
      expr: exercise_method
      comment: "Method used to exercise the valve (e.g. Manual, Mechanical) — supports equipment and crew productivity analysis."
  measures:
    - name: "total_valves_exercised"
      expr: COUNT(1)
      comment: "Total number of valve exercise events. Measures programme coverage against the required exercising schedule — a key asset management compliance KPI."
    - name: "deficiency_rate_count"
      expr: COUNT(CASE WHEN deficiency_noted = TRUE THEN 1 END)
      comment: "Number of valve exercises where a deficiency was identified. Elevated deficiency counts signal deteriorating valve infrastructure and increased emergency response risk."
    - name: "inoperable_valve_count"
      expr: COUNT(CASE WHEN operability_status = 'Inoperable' THEN 1 END)
      comment: "Number of valves found to be inoperable during exercising. Inoperable valves directly compromise the utility's ability to isolate main breaks — a critical public safety and service continuity metric."
    - name: "leak_detected_count"
      expr: COUNT(CASE WHEN leak_detected = TRUE THEN 1 END)
      comment: "Number of valve exercises where a leak was detected. Valve exercising is a secondary leak detection mechanism; this metric contributes to the overall leakage identification programme."
    - name: "avg_torque_reading"
      expr: AVG(CAST(torque_reading AS DOUBLE))
      comment: "Average torque required to operate valves. Increasing torque trends indicate valve deterioration and predict future inoperability — a leading indicator for proactive replacement."
    - name: "avg_final_position_percent"
      expr: AVG(CAST(final_position_percent AS DOUBLE))
      comment: "Average final position of valves after exercising as a percentage of full open. Values significantly below 100% indicate partially stuck valves that compromise isolation capability."
    - name: "follow_up_work_order_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of valve exercises requiring a follow-up work order. Measures the active valve repair backlog generated by the exercising programme."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_pressure_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pressure zone hydraulic performance and capacity metrics. These KPIs govern pressure management strategy, storage adequacy, and demand forecasting — foundational inputs to capital planning and regulatory compliance."
  source: "`water_utilities_ecm`.`distribution`.`pressure_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Classification of the pressure zone (e.g. Gravity, Pumped, Booster) — determines the hydraulic management approach and energy cost profile."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the pressure zone (e.g. Active, Decommissioned, Planned) — filters to active zones for performance reporting."
    - name: "zone_code"
      expr: zone_code
      comment: "Unique alphanumeric code identifying the pressure zone — the standard reference dimension for cross-system reporting."
    - name: "zone_name"
      expr: zone_name
      comment: "Descriptive name of the pressure zone — the business-friendly label used in executive dashboards and regulatory submissions."
  measures:
    - name: "avg_daily_demand_mgd"
      expr: AVG(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Average daily demand in million gallons per day across pressure zones. The primary demand metric for capacity planning, source water procurement, and treatment facility sizing."
    - name: "total_storage_capacity_mg"
      expr: SUM(CAST(storage_capacity_mg AS DOUBLE))
      comment: "Total storage capacity in million gallons across all pressure zones. Storage adequacy (typically expressed as days of average demand) is a key resilience and regulatory compliance metric."
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non-Revenue Water percentage by pressure zone. Zone-level NRW% identifies the highest-loss areas for targeted leak detection and rehabilitation investment."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water percentage by pressure zone. Complements NRW% at the zone level for granular loss management."
    - name: "avg_design_pressure_psi"
      expr: AVG(CAST(design_pressure_psi AS DOUBLE))
      comment: "Average design pressure in PSI across pressure zones. Benchmarks actual operating pressures against design intent — deviations indicate hydraulic model recalibration needs."
    - name: "avg_peak_hour_demand_mgd"
      expr: AVG(CAST(peak_hour_demand_mgd AS DOUBLE))
      comment: "Average peak hour demand in million gallons per day. The peak-to-average demand ratio drives pump station sizing, storage requirements, and PRV set-point optimisation."
    - name: "total_service_area_sq_mi"
      expr: SUM(CAST(service_area_sq_mi AS DOUBLE))
      comment: "Total service area in square miles across all pressure zones. Used to compute demand density metrics and benchmark infrastructure investment per unit area."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_pipe_main`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution pipe main asset inventory and condition metrics. These KPIs underpin the capital rehabilitation programme, risk-based asset management, and regulatory asset reporting."
  source: "`water_utilities_ecm`.`distribution`.`pipe_main`"
  dimensions:
    - name: "material"
      expr: material
      comment: "Pipe material (e.g. Cast Iron, Ductile Iron, PVC, HDPE) — the primary dimension for age-based and material-based rehabilitation prioritisation."
    - name: "pipe_type"
      expr: pipe_type
      comment: "Functional classification of the pipe (e.g. Transmission, Distribution, Service) — determines criticality and replacement priority."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Asset lifecycle stage (e.g. Active, Decommissioned, Planned Replacement) — filters to active network for performance reporting."
    - name: "installation_year"
      expr: installation_year
      comment: "Year the pipe was installed — the primary dimension for age-cohort analysis and end-of-life replacement planning."
    - name: "cathodic_protection_flag"
      expr: cathodic_protection_flag
      comment: "Flag indicating whether cathodic protection is installed — metallic pipes without cathodic protection have significantly higher corrosion failure risk."
    - name: "fire_flow_capable_flag"
      expr: fire_flow_capable_flag
      comment: "Flag indicating whether the pipe can deliver required fire flow — pipes failing this criterion are prioritised for upsizing in the CIP."
  measures:
    - name: "total_pipe_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total pipe main length in feet. The fundamental network size metric used to normalise break rates (breaks per 100 miles), survey coverage, and rehabilitation investment per mile."
    - name: "avg_nominal_diameter_inches"
      expr: AVG(CAST(nominal_diameter_inches AS DOUBLE))
      comment: "Average nominal pipe diameter in inches. Smaller-diameter pipes are more susceptible to blockage and have lower fire flow capacity — this metric supports targeted upsizing programmes."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across the pipe network in PSI. Sustained high pressure accelerates pipe deterioration and increases break frequency — a key input to pressure management strategy."
    - name: "avg_hazen_williams_c_factor"
      expr: AVG(CAST(hazen_williams_c_factor AS DOUBLE))
      comment: "Average Hazen-Williams C-factor (hydraulic roughness coefficient). Declining C-factors indicate internal pipe deterioration and increased head loss — triggers lining or replacement programmes."
    - name: "total_max_flow_capacity_gpm"
      expr: SUM(CAST(max_flow_capacity_gpm AS DOUBLE))
      comment: "Total maximum flow capacity across the pipe network in GPM. Measures aggregate hydraulic capacity and identifies capacity-constrained zones requiring reinforcement."
    - name: "pipes_without_cathodic_protection"
      expr: COUNT(CASE WHEN cathodic_protection_flag = FALSE THEN 1 END)
      comment: "Number of metallic pipes without cathodic protection. These pipes face elevated corrosion risk and are prioritised for cathodic protection installation or replacement in the CIP."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`distribution_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line inventory, material classification, and LCRR (Lead and Copper Rule Revisions) compliance metrics. These KPIs are among the highest-priority regulatory obligations in the water industry — EPA LCRR requires full inventory verification and lead service line replacement programmes."
  source: "`water_utilities_ecm`.`distribution`.`service_line`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Material of the service line (e.g. Lead, Galvanised, Copper, Plastic) — the primary LCRR compliance dimension; lead service lines must be inventoried and replaced."
    - name: "lcrr_classification"
      expr: lcrr_classification
      comment: "EPA LCRR material classification (e.g. Lead, Non-Lead, Unknown, Galvanised Requiring Replacement) — the regulatory classification driving replacement programme prioritisation."
    - name: "lcrr_inventory_verified"
      expr: lcrr_inventory_verified
      comment: "Flag indicating whether the service line material has been field-verified per LCRR requirements — unverified lines must be treated as lead for regulatory purposes."
    - name: "connection_status"
      expr: connection_status
      comment: "Current connection status (e.g. Active, Inactive, Abandoned) — filters to active service connections for compliance counting."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the service line (e.g. Utility, Customer, Shared) — determines responsibility for replacement costs and programme eligibility."
    - name: "replacement_priority_score"
      expr: replacement_priority_score
      comment: "Risk-based replacement priority score — used to sequence the lead service line replacement programme within budget constraints."
    - name: "installation_year"
      expr: installation_year
      comment: "Year the service line was installed — pre-1986 installations are presumed lead under LCRR until verified otherwise."
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of service lines in the inventory. The denominator for all LCRR compliance rate calculations and the baseline for replacement programme sizing."
    - name: "lcrr_verified_count"
      expr: COUNT(CASE WHEN lcrr_inventory_verified = TRUE THEN 1 END)
      comment: "Number of service lines with verified LCRR material classification. EPA LCRR requires 100% inventory verification; this metric tracks progress against the regulatory deadline."
    - name: "lcrr_unverified_count"
      expr: COUNT(CASE WHEN lcrr_inventory_verified = FALSE THEN 1 END)
      comment: "Number of service lines with unverified material classification. Unverified lines must be treated as lead under LCRR — this metric quantifies the remaining compliance gap."
    - name: "total_service_line_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of service lines in feet. Used to estimate replacement programme costs and prioritise geographic areas for field verification campaigns."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average service line diameter in inches. Undersized service lines restrict flow and pressure to customers — this metric supports targeted upsizing in conjunction with replacement programmes."
    - name: "curb_stop_installed_count"
      expr: COUNT(CASE WHEN curb_stop_installed = TRUE THEN 1 END)
      comment: "Number of service lines with a curb stop installed. Curb stops are required for emergency isolation; this metric identifies service connections lacking isolation capability."
$$;