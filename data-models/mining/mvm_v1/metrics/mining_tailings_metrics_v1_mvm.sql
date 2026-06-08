-- Metric views for domain: tailings | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tsf`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for Tailings Storage Facilities (TSFs) — covers capacity utilisation, closure liability exposure, and safety classification profile. Used by the VP Tailings and CFO to steer capital allocation, regulatory compliance, and risk management across the TSF portfolio."
  source: "`mining_ecm`.`tailings`.`tsf`"
  dimensions:
    - name: "tsf_operational_status"
      expr: operational_status
      comment: "Current operational status of the TSF (e.g. Active, Care & Maintenance, Closed). Primary filter for portfolio health reviews."
    - name: "tsf_consequence_classification"
      expr: consequence_classification
      comment: "Regulatory consequence classification of the TSF (e.g. Extreme, High, Significant). Drives inspection frequency and regulatory obligations."
    - name: "tsf_dam_type"
      expr: dam_type
      comment: "Construction method / dam type (e.g. Upstream, Downstream, Centreline). Critical risk dimension for dam safety benchmarking."
    - name: "tsf_mine_site_id"
      expr: mine_site_id
      comment: "Foreign key to the mine site. Enables portfolio roll-up by site for executive reporting."
    - name: "tsf_regulatory_acceptance_status"
      expr: regulatory_acceptance_status
      comment: "Whether the TSF has current regulatory acceptance. Non-accepted facilities represent compliance risk."
    - name: "tsf_is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the TSF is currently active. Used to filter operational vs. legacy facilities."
    - name: "tsf_classification_assessment_date_month"
      expr: DATE_TRUNC('MONTH', classification_assessment_date)
      comment: "Month of the most recent consequence classification assessment. Tracks recency of safety reviews."
  measures:
    - name: "total_tsf_count"
      expr: COUNT(1)
      comment: "Total number of TSFs in the portfolio. Baseline headcount for portfolio management and regulatory inventory."
    - name: "total_design_capacity_m3"
      expr: SUM(CAST(design_capacity_m3 AS DOUBLE))
      comment: "Sum of design storage capacity (m³) across all TSFs. Indicates total engineered storage envelope available for tailings."
    - name: "total_current_capacity_m3"
      expr: SUM(CAST(current_capacity_m3 AS DOUBLE))
      comment: "Sum of current available storage capacity (m³). Tracks remaining airspace across the portfolio — a critical operational constraint."
    - name: "avg_capacity_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(current_height_m AS DOUBLE)) / NULLIF(SUM(CAST(design_height_m AS DOUBLE)), 0), 2)
      comment: "Average capacity utilisation expressed as current height vs. design height (%). Proxy for how full TSFs are relative to their design envelope — triggers raise planning decisions."
    - name: "total_estimated_closure_liability_usd"
      expr: SUM(CAST(estimated_closure_liability_usd AS DOUBLE))
      comment: "Total estimated closure liability (USD) across all TSFs. A key balance-sheet exposure metric reported to the CFO and Board."
    - name: "avg_current_height_m"
      expr: AVG(CAST(current_height_m AS DOUBLE))
      comment: "Average current embankment height (m) across TSFs. Tracks structural growth and informs raise scheduling."
    - name: "total_catchment_area_km2"
      expr: SUM(CAST(catchment_area_km2 AS DOUBLE))
      comment: "Total catchment area (km²) across all TSFs. Drives water balance planning and flood risk assessment."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_deposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for tailings deposition events — tracks volumes deposited, storage consumption, freeboard compliance, and remaining airspace. Used by the Tailings Engineer and Operations Manager to manage daily deposition rates and trigger raise decisions."
  source: "`mining_ecm`.`tailings`.`deposition`"
  dimensions:
    - name: "deposition_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF receiving deposition. Primary grouping dimension for per-facility analysis."
    - name: "deposition_event_type"
      expr: event_type
      comment: "Type of deposition event (e.g. Routine, Emergency, Test). Distinguishes planned from unplanned deposition."
    - name: "deposition_compliance_status"
      expr: compliance_status
      comment: "Compliance status of the deposition event. Non-compliant events require immediate investigation."
    - name: "deposition_approval_status"
      expr: approval_status
      comment: "Approval status of the deposition record. Unapproved records indicate data quality or authorisation gaps."
    - name: "deposition_survey_method"
      expr: survey_method
      comment: "Method used to survey the deposition (e.g. Drone, GPS, Manual). Affects measurement accuracy and confidence."
    - name: "deposition_event_month"
      expr: DATE_TRUNC('MONTH', CAST(event_timestamp AS DATE))
      comment: "Month of the deposition event. Enables trend analysis of deposition rates over time."
    - name: "deposition_raise_trigger_flag"
      expr: raise_trigger_flag
      comment: "Boolean flag indicating whether this deposition event triggered a raise requirement. Tracks frequency of capacity-critical events."
    - name: "deposition_weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of deposition. Used to correlate operational disruptions with weather events."
  measures:
    - name: "total_deposition_events"
      expr: COUNT(1)
      comment: "Total number of deposition events recorded. Baseline operational activity count."
    - name: "total_volume_deposited_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of tailings deposited (m³). Primary throughput KPI for tailings operations — directly linked to processing plant output."
    - name: "total_solids_tonnage_deposited_t"
      expr: SUM(CAST(solids_tonnage_t AS DOUBLE))
      comment: "Total dry solids mass deposited (tonnes). Tracks actual tailings mass placed — used for mass balance reconciliation."
    - name: "avg_slurry_density_t_per_m3"
      expr: AVG(CAST(slurry_density_t_per_m3 AS DOUBLE))
      comment: "Average slurry density (t/m³) across deposition events. Indicates thickener performance and deposition efficiency — higher density means less water and better storage utilisation."
    - name: "avg_freeboard_m"
      expr: AVG(CAST(freeboard_m AS DOUBLE))
      comment: "Average freeboard (m) across deposition events. Critical safety metric — low freeboard indicates risk of overtopping."
    - name: "min_freeboard_m"
      expr: MIN(CAST(freeboard_m AS DOUBLE))
      comment: "Minimum freeboard (m) recorded across all deposition events. Identifies the most critical safety exposure point in the period."
    - name: "total_remaining_airspace_m3"
      expr: SUM(CAST(remaining_airspace_m3 AS DOUBLE))
      comment: "Total remaining airspace (m³) across all deposition records. Tracks how much storage capacity remains — a key trigger for raise capital decisions."
    - name: "avg_remaining_life_years"
      expr: AVG(CAST(remaining_life_years AS DOUBLE))
      comment: "Average estimated remaining life (years) of TSFs based on current deposition rates. Drives long-term capital planning for raises or new facilities."
    - name: "total_variance_from_plan_m3"
      expr: SUM(CAST(variance_from_plan_m3 AS DOUBLE))
      comment: "Total variance between actual and planned deposition volume (m³). Measures deposition plan adherence — large variances indicate scheduling or operational issues."
    - name: "raise_trigger_event_count"
      expr: COUNT(CASE WHEN raise_trigger_flag = TRUE THEN 1 END)
      comment: "Number of deposition events that triggered a raise requirement. Tracks frequency of capacity-critical thresholds being reached."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water balance KPIs for TSFs — tracks inflows, outflows, storage changes, freeboard, and licence compliance. Used by the Environmental Manager and Tailings Engineer to manage water licence obligations and prevent overtopping or licence exceedances."
  source: "`mining_ecm`.`tailings`.`water_balance`"
  dimensions:
    - name: "water_balance_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF. Primary grouping dimension for per-facility water balance analysis."
    - name: "water_balance_status"
      expr: balance_status
      comment: "Status of the water balance record (e.g. Approved, Draft, Under Review). Filters to approved balances for reporting."
    - name: "water_licence_compliance_status"
      expr: water_licence_compliance_status
      comment: "Whether the TSF is compliant with its water licence conditions. Non-compliant status triggers regulatory notification obligations."
    - name: "balance_period_start_month"
      expr: DATE_TRUNC('MONTH', balance_period_start_date)
      comment: "Month of the balance period start date. Enables monthly trend analysis of water balance components."
    - name: "water_balance_mine_site_id"
      expr: mine_site_id
      comment: "Foreign key to the mine site. Enables site-level water balance roll-up for environmental reporting."
  measures:
    - name: "total_water_balance_records"
      expr: COUNT(1)
      comment: "Total number of water balance records. Baseline count for completeness and frequency monitoring."
    - name: "total_inflow_m3"
      expr: SUM(CAST(total_inflow_m3 AS DOUBLE))
      comment: "Total water inflow (m³) across all balance periods. Aggregates all inflow sources — critical for water licence volume tracking."
    - name: "total_outflow_m3"
      expr: SUM(CAST(total_outflow_m3 AS DOUBLE))
      comment: "Total water outflow (m³) across all balance periods. Tracks water leaving the TSF system via all pathways."
    - name: "total_seepage_outflow_m3"
      expr: SUM(CAST(seepage_outflow_m3 AS DOUBLE))
      comment: "Total seepage outflow (m³). Seepage is an uncontrolled loss pathway — high values indicate liner or embankment integrity issues."
    - name: "total_process_water_inflow_m3"
      expr: SUM(CAST(process_water_inflow_m3 AS DOUBLE))
      comment: "Total process water inflow (m³) from the processing plant. Tracks the primary operational water input to the TSF."
    - name: "total_decant_return_outflow_m3"
      expr: SUM(CAST(decant_return_outflow_m3 AS DOUBLE))
      comment: "Total decant water returned to the processing plant (m³). Measures water recycling efficiency — higher return reduces fresh water demand."
    - name: "avg_freeboard_m"
      expr: AVG(CAST(freeboard_m AS DOUBLE))
      comment: "Average freeboard (m) across balance periods. Key safety indicator — must remain above design minimum to prevent overtopping."
    - name: "min_freeboard_m"
      expr: MIN(CAST(freeboard_m AS DOUBLE))
      comment: "Minimum freeboard (m) recorded. Identifies the most critical safety exposure point — used to assess overtopping risk."
    - name: "avg_balance_reconciliation_variance_pct"
      expr: AVG(CAST(balance_reconciliation_variance_percent AS DOUBLE))
      comment: "Average reconciliation variance (%) between calculated and measured water balance. High variance indicates measurement gaps or unaccounted water pathways."
    - name: "total_storage_change_m3"
      expr: SUM(CAST(storage_change_m3 AS DOUBLE))
      comment: "Net change in stored water volume (m³) across all balance periods. Positive trend indicates accumulation risk; negative trend may indicate excessive seepage."
    - name: "water_recycling_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(decant_return_outflow_m3 AS DOUBLE)) / NULLIF(SUM(CAST(total_inflow_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of total inflow returned as decant to the processing plant. Measures water recycling efficiency — a key sustainability and cost KPI."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_dam_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dam safety inspection KPIs — tracks inspection outcomes, factor of safety, freeboard compliance, and remedial action rates. Used by the Engineer of Record, Tailings Manager, and Board Safety Committee to monitor structural integrity and regulatory compliance of TSF embankments."
  source: "`mining_ecm`.`tailings`.`dam_safety_inspection`"
  dimensions:
    - name: "inspection_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF inspected. Primary grouping dimension for per-facility safety tracking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Annual Dam Safety Review, Routine, Independent). Distinguishes regulatory from operational inspections."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection record (e.g. Complete, In Progress, Overdue). Tracks inspection programme execution."
    - name: "overall_safety_rating"
      expr: overall_safety_rating
      comment: "Overall safety rating assigned by the inspector (e.g. Satisfactory, Unsatisfactory, Critical). Primary risk signal for executive reporting."
    - name: "fos_compliance_status"
      expr: fos_compliance_status
      comment: "Factor of Safety compliance status. Non-compliant FOS is a critical structural risk indicator requiring immediate action."
    - name: "freeboard_compliance_status"
      expr: freeboard_compliance_status
      comment: "Freeboard compliance status. Non-compliant freeboard indicates overtopping risk."
    - name: "remedial_action_priority"
      expr: remedial_action_priority
      comment: "Priority level of remedial actions identified (e.g. Immediate, High, Medium, Low). Drives maintenance and capital prioritisation."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection. Enables trend analysis of safety ratings and compliance over time."
    - name: "seepage_severity"
      expr: seepage_severity
      comment: "Severity classification of observed seepage (e.g. None, Minor, Moderate, Severe). Key indicator of embankment integrity."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of dam safety inspections conducted. Baseline for inspection programme completeness."
    - name: "avg_factor_of_safety"
      expr: AVG(CAST(factor_of_safety AS DOUBLE))
      comment: "Average factor of safety (FOS) across all inspections. FOS < 1.5 typically triggers regulatory intervention — a critical structural stability KPI."
    - name: "min_factor_of_safety"
      expr: MIN(CAST(factor_of_safety AS DOUBLE))
      comment: "Minimum factor of safety recorded. Identifies the most structurally critical TSF in the portfolio — a Board-level risk metric."
    - name: "avg_freeboard_measurement_m"
      expr: AVG(CAST(freeboard_measurement_m AS DOUBLE))
      comment: "Average freeboard measurement (m) across inspections. Tracks the safety buffer against overtopping across the portfolio."
    - name: "min_freeboard_measurement_m"
      expr: MIN(CAST(freeboard_measurement_m AS DOUBLE))
      comment: "Minimum freeboard measurement (m) recorded. Identifies the most critical overtopping risk point in the portfolio."
    - name: "inspections_with_remedial_actions"
      expr: COUNT(CASE WHEN remedial_actions_required IS NOT NULL AND remedial_actions_required <> '' THEN 1 END)
      comment: "Number of inspections where remedial actions were identified. Tracks the volume of outstanding safety deficiencies requiring resolution."
    - name: "fos_non_compliant_count"
      expr: COUNT(CASE WHEN fos_compliance_status <> 'Compliant' AND fos_compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of inspections where the Factor of Safety was non-compliant. A non-zero value is a critical risk signal requiring immediate executive attention."
    - name: "freeboard_non_compliant_count"
      expr: COUNT(CASE WHEN freeboard_compliance_status <> 'Compliant' AND freeboard_compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of inspections where freeboard was non-compliant. Tracks overtopping risk exposure across the portfolio."
    - name: "stability_analysis_conducted_count"
      expr: COUNT(CASE WHEN stability_analysis_conducted = TRUE THEN 1 END)
      comment: "Number of inspections where a formal stability analysis was conducted. Measures rigour of the dam safety programme."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_seepage_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seepage monitoring KPIs — tracks contaminant concentrations, flow rates, licence exceedances, and alert triggers. Used by the Environmental Manager and Tailings Engineer to manage groundwater protection obligations and detect early signs of embankment internal erosion."
  source: "`mining_ecm`.`tailings`.`seepage_monitoring`"
  dimensions:
    - name: "seepage_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF being monitored. Primary grouping dimension for per-facility seepage analysis."
    - name: "seepage_monitoring_point_code"
      expr: monitoring_point_code
      comment: "Unique code for the monitoring point. Enables spatial analysis of seepage patterns around the TSF."
    - name: "seepage_location_type"
      expr: location_type
      comment: "Type of monitoring location (e.g. Downstream Toe, Underdrain, Perimeter). Contextualises seepage observations."
    - name: "seepage_measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g. Valid, Suspect, Rejected). Filters to valid data for compliance reporting."
    - name: "seepage_internal_erosion_risk_indicator"
      expr: internal_erosion_risk_indicator
      comment: "Risk indicator for internal erosion (e.g. Low, Medium, High). Critical early-warning dimension for embankment failure risk."
    - name: "seepage_measurement_month"
      expr: DATE_TRUNC('MONTH', CAST(measurement_timestamp AS DATE))
      comment: "Month of the seepage measurement. Enables trend analysis of contaminant concentrations and flow rates over time."
    - name: "seepage_weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of measurement. Enables correlation of seepage rates with rainfall events."
  measures:
    - name: "total_seepage_readings"
      expr: COUNT(1)
      comment: "Total number of seepage monitoring readings. Baseline for monitoring programme completeness."
    - name: "avg_flow_rate"
      expr: AVG(CAST(flow_rate AS DOUBLE))
      comment: "Average seepage flow rate across all monitoring points. Increasing trend indicates potential embankment or liner deterioration."
    - name: "max_flow_rate"
      expr: MAX(CAST(flow_rate AS DOUBLE))
      comment: "Maximum seepage flow rate recorded. Identifies peak seepage events that may indicate structural issues."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average pH level of seepage water. Low pH indicates acid rock drainage — a key environmental compliance and remediation cost driver."
    - name: "avg_total_dissolved_solids"
      expr: AVG(CAST(total_dissolved_solids AS DOUBLE))
      comment: "Average total dissolved solids (TDS) in seepage. High TDS indicates contaminant migration into groundwater — a licence exceedance risk."
    - name: "avg_electrical_conductivity"
      expr: AVG(CAST(electrical_conductivity AS DOUBLE))
      comment: "Average electrical conductivity of seepage. A proxy for dissolved solids and contaminant load — used as a rapid screening indicator."
    - name: "licence_exceedance_count"
      expr: COUNT(CASE WHEN licence_exceedance_flag = TRUE THEN 1 END)
      comment: "Number of seepage readings that exceeded licence limits. Each exceedance may trigger regulatory notification — a critical compliance KPI."
    - name: "alert_triggered_count"
      expr: COUNT(CASE WHEN alert_triggered_flag = TRUE THEN 1 END)
      comment: "Number of seepage readings that triggered an alert threshold. Tracks frequency of early-warning activations requiring investigation."
    - name: "design_exceedance_count"
      expr: COUNT(CASE WHEN design_exceedance_flag = TRUE THEN 1 END)
      comment: "Number of readings exceeding design seepage rates. Indicates the TSF is performing outside its design envelope — a structural risk signal."
    - name: "avg_arsenic_concentration"
      expr: AVG(CAST(arsenic_concentration AS DOUBLE))
      comment: "Average arsenic concentration in seepage water. Arsenic is a regulated contaminant — exceedances trigger environmental enforcement action."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tarp_trigger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TARP (Trigger Action Response Plan) trigger KPIs — tracks activation frequency, response times, exceedance magnitudes, and regulatory notification rates. Used by the Tailings Manager, HSE Director, and Board to monitor the effectiveness of the early-warning and emergency response system."
  source: "`mining_ecm`.`tailings`.`tarp_trigger`"
  dimensions:
    - name: "tarp_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF where the trigger occurred. Primary grouping dimension for per-facility TARP analysis."
    - name: "tarp_trigger_level"
      expr: trigger_level
      comment: "TARP trigger level activated (e.g. Level 1 Alert, Level 2 Action, Level 3 Evacuation). Indicates severity of the trigger event."
    - name: "tarp_trigger_status"
      expr: trigger_status
      comment: "Current status of the trigger (e.g. Open, Closed, Under Investigation). Tracks resolution of active triggers."
    - name: "tarp_parameter_category"
      expr: parameter_category
      comment: "Category of the triggering parameter (e.g. Piezometric, Seepage, Deformation). Identifies which monitoring system is generating the most alerts."
    - name: "tarp_triggering_parameter"
      expr: triggering_parameter
      comment: "Specific parameter that triggered the TARP (e.g. Pore Pressure, Flow Rate). Enables root cause pattern analysis."
    - name: "tarp_activation_month"
      expr: DATE_TRUNC('MONTH', CAST(activation_timestamp AS DATE))
      comment: "Month of TARP activation. Enables trend analysis of trigger frequency over time."
    - name: "tarp_regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Boolean flag indicating whether regulatory notification was required. Tracks regulatory exposure from TARP events."
    - name: "tarp_investigation_required_flag"
      expr: investigation_required_flag
      comment: "Boolean flag indicating whether a formal investigation was required. Distinguishes routine alerts from significant events."
  measures:
    - name: "total_tarp_activations"
      expr: COUNT(1)
      comment: "Total number of TARP trigger activations. Baseline frequency metric — increasing trend indicates deteriorating facility condition."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which the measured value exceeded the trigger threshold. Indicates the magnitude of exceedances — larger values signal more severe conditions."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum exceedance percentage recorded. Identifies the most severe TARP event in the period — a key risk escalation indicator."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(UNIX_TIMESTAMP(response_initiated_timestamp) - UNIX_TIMESTAMP(activation_timestamp) AS DOUBLE) / 60.0)
      comment: "Average time (minutes) from TARP activation to response initiation. Measures emergency response effectiveness — a critical safety performance KPI."
    - name: "regulatory_notification_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of TARP events requiring regulatory notification. Tracks regulatory exposure and notification obligation fulfilment."
    - name: "open_tarp_trigger_count"
      expr: COUNT(CASE WHEN trigger_status = 'Open' THEN 1 END)
      comment: "Number of currently open (unresolved) TARP triggers. A non-zero value indicates active unresolved safety concerns requiring management attention."
    - name: "investigation_required_count"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END)
      comment: "Number of TARP events requiring formal investigation. Tracks the volume of significant events demanding root cause analysis."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tsf_capacity_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TSF capacity survey KPIs — tracks storage utilisation, freeboard compliance, remaining airspace, and projected capacity exhaustion. Used by the Tailings Engineer and Capital Planning team to schedule raises and manage long-term storage capacity."
  source: "`mining_ecm`.`tailings`.`tsf_capacity_survey`"
  dimensions:
    - name: "capacity_survey_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF surveyed. Primary grouping dimension for per-facility capacity tracking."
    - name: "capacity_survey_status"
      expr: survey_status
      comment: "Status of the survey (e.g. Complete, In Progress, Rejected). Filters to validated surveys for reporting."
    - name: "capacity_survey_method"
      expr: survey_method
      comment: "Survey method used (e.g. Drone LiDAR, GPS, Total Station). Affects measurement accuracy and confidence."
    - name: "capacity_survey_accuracy_classification"
      expr: survey_accuracy_classification
      comment: "Accuracy classification of the survey. Drives confidence intervals on capacity estimates."
    - name: "capacity_survey_freeboard_compliance_flag"
      expr: freeboard_compliance_flag
      comment: "Boolean flag indicating whether freeboard meets minimum requirements. Non-compliant surveys trigger immediate operational response."
    - name: "capacity_survey_date_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month of the capacity survey. Enables trend analysis of storage consumption over time."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of capacity surveys conducted. Baseline for survey programme completeness."
    - name: "avg_capacity_utilisation_pct"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average storage capacity utilisation (%) across surveys. Primary KPI for storage management — high utilisation triggers raise capital decisions."
    - name: "max_capacity_utilisation_pct"
      expr: MAX(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Maximum capacity utilisation (%) recorded. Identifies the most capacity-constrained TSF — a critical capital planning signal."
    - name: "total_remaining_airspace_m3"
      expr: SUM(CAST(remaining_airspace_m3 AS DOUBLE))
      comment: "Total remaining airspace (m³) across all surveyed TSFs. Portfolio-level storage headroom — a key constraint on production continuity."
    - name: "avg_freeboard_m"
      expr: AVG(CAST(freeboard_m AS DOUBLE))
      comment: "Average freeboard (m) across surveys. Safety buffer against overtopping — must remain above regulatory minimum."
    - name: "min_freeboard_m"
      expr: MIN(CAST(freeboard_m AS DOUBLE))
      comment: "Minimum freeboard (m) recorded across all surveys. Identifies the most critical overtopping risk point in the portfolio."
    - name: "avg_estimated_filling_rate_m3_per_day"
      expr: AVG(CAST(estimated_filling_rate_m3_per_day AS DOUBLE))
      comment: "Average estimated filling rate (m³/day). Drives projected capacity exhaustion date calculations and raise scheduling."
    - name: "avg_variance_from_design_m3"
      expr: AVG(CAST(variance_from_design_m3 AS DOUBLE))
      comment: "Average variance between actual and design storage volume (m³). Tracks how closely TSFs are performing to their design — large variances indicate survey or construction issues."
    - name: "freeboard_non_compliant_survey_count"
      expr: COUNT(CASE WHEN freeboard_compliance_flag = FALSE THEN 1 END)
      comment: "Number of surveys where freeboard was below the minimum required. Each non-compliant survey is a regulatory and safety risk event."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_closure_liability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closure liability KPIs — tracks estimated closure costs, NPV, financial assurance lodgement, and variance to approved estimates. Used by the CFO, Finance Director, and Board Audit Committee to manage balance-sheet provisions and regulatory financial assurance obligations."
  source: "`mining_ecm`.`tailings`.`closure_liability`"
  dimensions:
    - name: "closure_liability_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF. Primary grouping dimension for per-facility closure liability analysis."
    - name: "closure_liability_type"
      expr: liability_type
      comment: "Type of closure liability (e.g. TSF Rehabilitation, Waste Dump Closure, Water Treatment). Enables cost category analysis."
    - name: "closure_liability_status"
      expr: liability_status
      comment: "Status of the liability estimate (e.g. Approved, Draft, Under Review). Filters to approved estimates for financial reporting."
    - name: "closure_consequence_classification"
      expr: consequence_classification
      comment: "Consequence classification of the facility. Enables risk-weighted liability analysis."
    - name: "closure_financial_assurance_instrument_type"
      expr: financial_assurance_instrument_type
      comment: "Type of financial assurance instrument lodged (e.g. Bank Guarantee, Cash Bond, Insurance). Tracks assurance portfolio composition."
    - name: "closure_cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the closure cost estimate. Required for multi-currency portfolio consolidation."
    - name: "closure_estimate_date_month"
      expr: DATE_TRUNC('MONTH', estimate_date)
      comment: "Month of the closure cost estimate. Enables trend analysis of liability growth over time."
  measures:
    - name: "total_estimated_closure_cost"
      expr: SUM(CAST(estimated_closure_cost AS DOUBLE))
      comment: "Total estimated closure cost across all liabilities. Primary balance-sheet provision metric — reported to the Board and external auditors."
    - name: "total_approved_estimate_amount"
      expr: SUM(CAST(approved_estimate_amount AS DOUBLE))
      comment: "Total approved closure cost estimate. The regulatory-accepted liability quantum — used for financial assurance sizing."
    - name: "total_net_present_value"
      expr: SUM(CAST(net_present_value AS DOUBLE))
      comment: "Total NPV of closure liabilities. The discounted present value of future closure obligations — the balance-sheet provision amount."
    - name: "total_assurance_amount_lodged"
      expr: SUM(CAST(assurance_amount_lodged AS DOUBLE))
      comment: "Total financial assurance lodged with regulators. Tracks whether assurance coverage is adequate relative to approved estimates."
    - name: "assurance_coverage_ratio"
      expr: ROUND(100.0 * SUM(CAST(assurance_amount_lodged AS DOUBLE)) / NULLIF(SUM(CAST(approved_estimate_amount AS DOUBLE)), 0), 2)
      comment: "Financial assurance lodged as a percentage of the approved estimate. Values below 100% indicate a regulatory assurance shortfall — a compliance risk."
    - name: "avg_variance_to_approved_estimate_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance (%) between estimated and approved closure costs. Tracks estimation accuracy and identifies facilities with growing cost pressures."
    - name: "total_variance_to_approved_estimate"
      expr: SUM(CAST(variance_to_approved_estimate AS DOUBLE))
      comment: "Total absolute variance between estimated and approved closure costs. Quantifies the aggregate cost estimation gap across the portfolio."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to closure cost NPV calculations. Tracks consistency of financial modelling assumptions across the portfolio."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_rehabilitation_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rehabilitation activity KPIs — tracks area treated, cost performance, vegetation cover achievement, and activity completion rates. Used by the Environmental Manager and CFO to monitor progressive rehabilitation progress against closure plan milestones and regulatory commitments."
  source: "`mining_ecm`.`tailings`.`rehabilitation_activity`"
  dimensions:
    - name: "rehab_activity_type"
      expr: activity_type
      comment: "Type of rehabilitation activity (e.g. Topsoil Placement, Seeding, Revegetation, Landform Reshaping). Enables activity-type cost and performance analysis."
    - name: "rehab_activity_status"
      expr: activity_status
      comment: "Status of the rehabilitation activity (e.g. Planned, In Progress, Complete, Overdue). Tracks programme execution."
    - name: "rehab_rehabilitation_phase"
      expr: rehabilitation_phase
      comment: "Phase of rehabilitation (e.g. Progressive, Final, Post-Closure). Enables phase-based cost and progress tracking."
    - name: "rehab_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF being rehabilitated. Primary grouping dimension for per-facility rehabilitation tracking."
    - name: "rehab_assessment_outcome"
      expr: assessment_outcome
      comment: "Outcome of the rehabilitation assessment (e.g. Successful, Partially Successful, Failed). Tracks success rates by activity type and phase."
    - name: "rehab_actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month of actual activity completion. Enables trend analysis of rehabilitation programme delivery."
    - name: "rehab_cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of rehabilitation cost. Required for multi-currency portfolio consolidation."
  measures:
    - name: "total_rehabilitation_activities"
      expr: COUNT(1)
      comment: "Total number of rehabilitation activities recorded. Baseline for programme scope and completeness."
    - name: "total_area_treated_hectares"
      expr: SUM(CAST(area_treated_hectares AS DOUBLE))
      comment: "Total area rehabilitated (hectares). Primary physical progress KPI — tracked against regulatory commitments and closure plan milestones."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual rehabilitation expenditure. Tracks spend against budget and closure provision — a key financial performance metric."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated rehabilitation cost. Baseline for budget vs. actual cost variance analysis."
    - name: "cost_per_hectare"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(area_treated_hectares AS DOUBLE)), 0), 2)
      comment: "Actual rehabilitation cost per hectare treated. Efficiency KPI — benchmarks rehabilitation productivity and identifies cost outliers."
    - name: "avg_target_vegetation_cover_pct"
      expr: AVG(CAST(target_vegetation_cover_percent AS DOUBLE))
      comment: "Average target vegetation cover (%) across rehabilitation activities. Tracks the ambition level of revegetation commitments."
    - name: "total_topsoil_volume_m3"
      expr: SUM(CAST(topsoil_volume_m3 AS DOUBLE))
      comment: "Total topsoil volume placed (m³). Tracks a critical rehabilitation input — topsoil availability often constrains rehabilitation programme delivery."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(estimated_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated rehabilitation cost. Positive values indicate cost overruns — a key financial control metric."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_ard_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Acid Rock Drainage (ARD) assessment KPIs — tracks geochemical risk classification, neutralisation potential ratios, sulfide content, and metal leaching risk across waste materials. Used by the Environmental Manager and Tailings Engineer to manage ARD risk, inform waste routing decisions, and demonstrate regulatory compliance."
  source: "`mining_ecm`.`tailings`.`ard_assessment`"
  dimensions:
    - name: "ard_risk_classification"
      expr: ard_risk_classification
      comment: "ARD risk classification of the assessed material (e.g. PAF, NAF, UC). Primary risk dimension — drives waste routing and management strategy decisions."
    - name: "ard_material_type"
      expr: material_type
      comment: "Type of material assessed (e.g. Waste Rock, Tailings, Ore). Enables material-type risk profiling."
    - name: "ard_metal_leaching_risk"
      expr: metal_leaching_risk
      comment: "Metal leaching risk classification (e.g. High, Medium, Low). Identifies materials requiring special handling or containment."
    - name: "ard_management_strategy"
      expr: management_strategy
      comment: "Management strategy assigned to the material (e.g. Co-disposal, Encapsulation, Lime Treatment). Tracks strategy distribution across the waste inventory."
    - name: "ard_assessment_status"
      expr: assessment_status
      comment: "Status of the ARD assessment (e.g. Complete, Pending Review, Superseded). Filters to current, valid assessments."
    - name: "ard_test_method"
      expr: test_method
      comment: "Test method used for the ARD assessment (e.g. NAG, ABA, NAPP). Enables method-based data quality stratification."
    - name: "ard_assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of the ARD assessment. Enables trend analysis of geochemical risk profile changes over time."
  measures:
    - name: "total_ard_assessments"
      expr: COUNT(1)
      comment: "Total number of ARD assessments conducted. Baseline for geochemical characterisation programme coverage."
    - name: "avg_net_neutralization_potential_ratio"
      expr: AVG(CAST(net_neutralization_potential_ratio AS DOUBLE))
      comment: "Average Net Neutralisation Potential Ratio (NNPR). Values < 1 indicate acid-generating potential — a critical geochemical risk threshold used in waste classification."
    - name: "avg_paste_ph"
      expr: AVG(CAST(paste_ph AS DOUBLE))
      comment: "Average paste pH across assessed materials. Low pH confirms acid-generating conditions — a key indicator for ARD management strategy selection."
    - name: "avg_sulfide_sulfur_pct"
      expr: AVG(CAST(sulfide_sulfur_percent AS DOUBLE))
      comment: "Average sulfide sulfur content (%). Higher sulfide content increases ARD generation potential — drives waste classification and routing decisions."
    - name: "avg_maximum_potential_acidity"
      expr: AVG(CAST(maximum_potential_acidity_kg_h2so4_per_tonne AS DOUBLE))
      comment: "Average Maximum Potential Acidity (MPA) in kg H₂SO₄/tonne. Quantifies the acid-generating capacity of waste materials — a key input to ARD risk modelling."
    - name: "avg_anc_kg_caco3_per_tonne"
      expr: AVG(CAST(anc_kg_caco3_per_tonne AS DOUBLE))
      comment: "Average Acid Neutralising Capacity (ANC) in kg CaCO₃/tonne. Measures the buffering capacity of waste materials against acid generation."
    - name: "high_ard_risk_sample_count"
      expr: COUNT(CASE WHEN ard_risk_classification = 'PAF' THEN 1 END)
      comment: "Number of samples classified as Potentially Acid Forming (PAF). Tracks the volume of high-risk material requiring special management — a key environmental liability driver."
    - name: "avg_arsenic_leachate_mg_per_l"
      expr: AVG(CAST(arsenic_leachate_mg_per_l AS DOUBLE))
      comment: "Average arsenic leachate concentration (mg/L). Arsenic is a regulated contaminant — high concentrations drive containment and treatment cost obligations."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tailings_tsf_raise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TSF raise construction KPIs — tracks raise cost performance, schedule adherence, height achievement, and volume delivered. Used by the Capital Projects team and CFO to manage raise capital expenditure and ensure storage capacity is delivered on schedule."
  source: "`mining_ecm`.`tailings`.`tsf_raise`"
  dimensions:
    - name: "tsf_raise_tsf_id"
      expr: tsf_id
      comment: "Foreign key to the TSF being raised. Primary grouping dimension for per-facility raise performance analysis."
    - name: "tsf_raise_status"
      expr: raise_status
      comment: "Status of the raise (e.g. Planned, Under Construction, Complete, On Hold). Tracks capital programme execution."
    - name: "tsf_raise_method"
      expr: raise_method
      comment: "Construction method for the raise (e.g. Upstream, Downstream, Centreline). Affects cost, risk profile, and regulatory requirements."
    - name: "tsf_raise_cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of raise cost. Required for multi-currency capital programme consolidation."
    - name: "tsf_raise_approval_authority"
      expr: approval_authority
      comment: "Authority that approved the raise (e.g. Board, Regulator, EOR). Tracks governance compliance for raise approvals."
    - name: "tsf_raise_actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month of actual raise completion. Enables trend analysis of capital delivery performance."
  measures:
    - name: "total_raises"
      expr: COUNT(1)
      comment: "Total number of TSF raises in the programme. Baseline for capital programme scope."
    - name: "total_actual_raise_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual capital expenditure on TSF raises. Primary capital spend KPI — tracked against budget and closure provision."
    - name: "total_estimated_raise_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated capital cost of TSF raises. Baseline for budget vs. actual variance analysis."
    - name: "raise_cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(estimated_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated raise cost. Positive values indicate cost overruns — a key capital project performance metric."
    - name: "total_raise_volume_m3"
      expr: SUM(CAST(raise_volume_m3 AS DOUBLE))
      comment: "Total embankment volume constructed across all raises (m³). Tracks physical construction output — a key capital productivity metric."
    - name: "avg_raise_height_m"
      expr: AVG(CAST(raise_height_m AS DOUBLE))
      comment: "Average raise height (m) across all raises. Tracks the scale of raise construction activity."
    - name: "cost_per_m3_raised"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(raise_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Actual cost per cubic metre of embankment raised. Unit cost efficiency KPI — benchmarks raise construction productivity and identifies cost outliers."
$$;