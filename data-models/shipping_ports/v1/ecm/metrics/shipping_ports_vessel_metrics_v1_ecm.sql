-- Metric views for domain: vessel | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_port_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vessel port call operational and financial performance metrics tracking call volumes, turnaround times, cargo throughput, and revenue generation"
  source: "`shipping_ports_ecm`.`vessel`.`call`"
  dimensions:
    - name: "call_status"
      expr: call_status
      comment: "Current status of the port call (e.g., scheduled, in-progress, completed, cancelled)"
    - name: "call_purpose"
      expr: purpose
      comment: "Primary purpose of the vessel call (e.g., cargo operations, bunkering, repairs, crew change)"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo being handled during the call (e.g., container, bulk, liquid, general)"
    - name: "call_year"
      expr: YEAR(ata)
      comment: "Year of actual time of arrival for trend analysis"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', ata)
      comment: "Month of actual time of arrival for seasonal analysis"
    - name: "call_quarter"
      expr: CONCAT('Q', QUARTER(ata), '-', YEAR(ata))
      comment: "Quarter and year of actual arrival for quarterly business reviews"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance process for compliance tracking"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level applied during the call for security analysis"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicator whether dangerous goods were handled during the call"
    - name: "port_state_control_inspection_flag"
      expr: port_state_control_inspection_flag
      comment: "Indicator whether PSC inspection occurred during the call"
  measures:
    - name: "total_port_calls"
      expr: COUNT(1)
      comment: "Total number of vessel port calls for volume tracking and capacity planning"
    - name: "unique_vessels"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels calling at the port for customer diversity analysis"
    - name: "total_teu_declared"
      expr: SUM(CAST(total_teu_declared AS DOUBLE))
      comment: "Total twenty-foot equivalent units declared across all calls for throughput measurement"
    - name: "avg_teu_per_call"
      expr: AVG(CAST(total_teu_declared AS DOUBLE))
      comment: "Average TEU per call for vessel size and cargo volume analysis"
    - name: "avg_berth_time_hours"
      expr: AVG(CAST(TIMESTAMPDIFF(HOUR, atb, COALESCE(atd, CURRENT_TIMESTAMP())) AS DOUBLE))
      comment: "Average time vessels spend at berth from arrival to departure for turnaround efficiency"
    - name: "avg_cargo_ops_duration_hours"
      expr: AVG(CAST(TIMESTAMPDIFF(HOUR, cargo_ops_start_timestamp, cargo_ops_end_timestamp) AS DOUBLE))
      comment: "Average duration of cargo operations for productivity benchmarking"
    - name: "avg_port_stay_hours"
      expr: AVG(CAST(TIMESTAMPDIFF(HOUR, ata, COALESCE(atd, CURRENT_TIMESTAMP())) AS DOUBLE))
      comment: "Average total port stay from arrival to departure for overall port efficiency"
    - name: "schedule_adherence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ABS(TIMESTAMPDIFF(HOUR, eta, ata)) <= 2 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls arriving within 2 hours of ETA for schedule reliability measurement"
    - name: "calls_with_dangerous_goods"
      expr: SUM(CASE WHEN dangerous_goods_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls handling dangerous goods for safety and compliance monitoring"
    - name: "calls_with_psc_inspection"
      expr: SUM(CASE WHEN port_state_control_inspection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls subject to PSC inspection for regulatory compliance tracking"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel fleet composition, risk profile, and compliance metrics for fleet management and safety oversight"
  source: "`shipping_ports_ecm`.`vessel`.`vessel`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the vessel (e.g., active, laid-up, scrapped)"
    - name: "vessel_type"
      expr: vessel_type_id
      comment: "Type classification of the vessel for fleet segmentation"
    - name: "flag_state"
      expr: flag_state_id
      comment: "Flag state of vessel registration for regulatory jurisdiction analysis"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "Current ISPS security level assigned to the vessel"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Result of sanctions screening for compliance risk management"
    - name: "last_psc_detention_flag"
      expr: last_psc_detention_flag
      comment: "Indicator whether vessel was detained at last PSC inspection"
    - name: "vessel_age_band"
      expr: CASE WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 5 THEN '0-5 years' WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 10 THEN '6-10 years' WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 15 THEN '11-15 years' WHEN CAST(year_built AS INT) >= YEAR(CURRENT_DATE()) - 20 THEN '16-20 years' ELSE '20+ years' END
      comment: "Age band of vessel for fleet age profile analysis"
    - name: "pni_club"
      expr: pni_club_code
      comment: "Protection and indemnity insurance club for insurance coverage analysis"
  measures:
    - name: "total_vessels"
      expr: COUNT(1)
      comment: "Total number of vessels in the registry for fleet size tracking"
    - name: "active_vessels"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of operationally active vessels for capacity planning"
    - name: "total_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Total container capacity across fleet in TEU for capacity management"
    - name: "avg_teu_capacity"
      expr: AVG(CAST(teu_capacity AS DOUBLE))
      comment: "Average TEU capacity per vessel for fleet profile analysis"
    - name: "total_dwt"
      expr: SUM(CAST(dwt_tonnes AS DOUBLE))
      comment: "Total deadweight tonnage across fleet for cargo capacity measurement"
    - name: "avg_vessel_age_years"
      expr: AVG(CAST(YEAR(CURRENT_DATE()) - CAST(year_built AS INT) AS DOUBLE))
      comment: "Average age of vessels in years for fleet modernization planning"
    - name: "vessels_with_psc_detention"
      expr: SUM(CASE WHEN last_psc_detention_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vessels detained at last PSC inspection for safety risk assessment"
    - name: "avg_psc_deficiency_count"
      expr: AVG(CAST(last_psc_deficiency_count AS DOUBLE))
      comment: "Average number of PSC deficiencies per vessel for fleet safety benchmarking"
    - name: "high_risk_vessels"
      expr: SUM(CASE WHEN CAST(risk_profile_score AS DOUBLE) >= 70 THEN 1 ELSE 0 END)
      comment: "Number of vessels with high risk profile scores for targeted oversight"
    - name: "vessels_sanctions_cleared"
      expr: SUM(CASE WHEN sanctions_screening_status = 'Cleared' THEN 1 ELSE 0 END)
      comment: "Number of vessels cleared in sanctions screening for compliance assurance"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_bunker_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bunker fuel supply operational efficiency, cost, and safety metrics for fuel procurement optimization and environmental compliance"
  source: "`shipping_ports_ecm`.`vessel`.`bunker_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Status of the bunker operation (e.g., scheduled, in-progress, completed, cancelled)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel supplied (e.g., VLSFO, LSMGO, MGO, HFO)"
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Grade specification of the fuel for quality analysis"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of fuel delivery (e.g., barge, truck, pipeline)"
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of location where fuel was delivered (e.g., berth, anchorage)"
    - name: "operation_year"
      expr: YEAR(actual_start_timestamp)
      comment: "Year of bunker operation for trend analysis"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month of bunker operation for seasonal analysis"
    - name: "safety_checklist_completed_flag"
      expr: safety_checklist_completed_flag
      comment: "Indicator whether safety checklist was completed for compliance tracking"
    - name: "fuel_sample_taken_flag"
      expr: fuel_sample_taken_flag
      comment: "Indicator whether fuel sample was taken for quality assurance"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level during bunker operation for security analysis"
  measures:
    - name: "total_bunker_operations"
      expr: COUNT(1)
      comment: "Total number of bunker operations for volume tracking and supplier performance"
    - name: "total_fuel_delivered_mt"
      expr: SUM(CAST(quantity_delivered_mt AS DOUBLE))
      comment: "Total metric tonnes of fuel delivered for fuel consumption analysis"
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total cost of fuel across all operations for procurement spend management"
    - name: "avg_unit_price_per_mt"
      expr: AVG(CAST(unit_price_per_mt AS DOUBLE))
      comment: "Average unit price per metric tonne for fuel price benchmarking"
    - name: "avg_operation_duration_minutes"
      expr: AVG(CAST(operation_duration_minutes AS DOUBLE))
      comment: "Average duration of bunker operations for efficiency measurement"
    - name: "delivery_accuracy_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(quantity_delivered_mt AS DOUBLE) / NULLIF(CAST(quantity_ordered_mt AS DOUBLE), 0)), 2)
      comment: "Percentage of ordered quantity actually delivered for supplier reliability assessment"
    - name: "avg_sulphur_content_pct"
      expr: AVG(CAST(sulphur_content_percent AS DOUBLE))
      comment: "Average sulphur content percentage for environmental compliance monitoring"
    - name: "operations_with_safety_checklist"
      expr: SUM(CASE WHEN safety_checklist_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of operations with completed safety checklist for safety compliance rate"
    - name: "operations_with_fuel_sample"
      expr: SUM(CASE WHEN fuel_sample_taken_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of operations with fuel sample taken for quality assurance compliance"
    - name: "total_port_service_charges"
      expr: SUM(CAST(port_service_charge AS DOUBLE))
      comment: "Total port service charges for bunker operations for revenue tracking"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_psc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port State Control inspection outcomes, deficiency rates, and detention metrics for maritime safety and regulatory compliance oversight"
  source: "`shipping_ports_ecm`.`vessel`.`psc_inspection`"
  dimensions:
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Overall outcome of the PSC inspection (e.g., no deficiencies, deficiencies found, detained)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of PSC inspection conducted (e.g., initial, more detailed, expanded)"
    - name: "inspection_regime"
      expr: inspection_regime
      comment: "PSC regime conducting the inspection (e.g., Paris MOU, Tokyo MOU, USCG)"
    - name: "detention_flag"
      expr: detention_flag
      comment: "Indicator whether vessel was detained as result of inspection"
    - name: "ship_risk_profile"
      expr: ship_risk_profile
      comment: "Risk profile of the vessel (e.g., high risk, standard risk, low risk)"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection for trend analysis"
    - name: "inspection_quarter"
      expr: CONCAT('Q', QUARTER(inspection_date), '-', YEAR(inspection_date))
      comment: "Quarter and year of inspection for quarterly compliance reporting"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicator whether follow-up inspection is required"
    - name: "flag_state_notified_flag"
      expr: flag_state_notified_flag
      comment: "Indicator whether flag state was notified of deficiencies"
    - name: "psc_authority"
      expr: psc_authority_name
      comment: "Name of the PSC authority conducting the inspection"
  measures:
    - name: "total_psc_inspections"
      expr: COUNT(1)
      comment: "Total number of PSC inspections conducted for inspection volume tracking"
    - name: "total_deficiencies_found"
      expr: SUM(CAST(total_deficiencies_found AS DOUBLE))
      comment: "Total number of deficiencies identified across all inspections for safety performance"
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(total_deficiencies_found AS DOUBLE))
      comment: "Average number of deficiencies per inspection for fleet safety benchmarking"
    - name: "detention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN detention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in detention for safety risk measurement"
    - name: "inspections_with_deficiencies"
      expr: SUM(CASE WHEN CAST(total_deficiencies_found AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Number of inspections where deficiencies were found for deficiency rate calculation"
    - name: "avg_detention_duration_hours"
      expr: AVG(CAST(detention_duration_hours AS DOUBLE))
      comment: "Average duration of vessel detention in hours for operational impact assessment"
    - name: "total_inspection_cost_usd"
      expr: SUM(CAST(inspection_cost_usd AS DOUBLE))
      comment: "Total cost of PSC inspections in USD for cost management"
    - name: "inspections_requiring_followup"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections requiring follow-up for compliance tracking"
    - name: "high_risk_vessel_inspections"
      expr: SUM(CASE WHEN ship_risk_profile = 'High Risk' THEN 1 ELSE 0 END)
      comment: "Number of inspections on high-risk vessels for targeted oversight effectiveness"
    - name: "clean_inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(total_deficiencies_found AS DOUBLE) = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with no deficiencies for fleet quality measurement"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_anchorage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anchorage utilization, waiting time, and operational efficiency metrics for berth planning and port congestion management"
  source: "`shipping_ports_ecm`.`vessel`.`anchorage`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the anchorage assignment (e.g., assigned, in-use, completed, cancelled)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for anchorage (e.g., awaiting berth, awaiting pilot, weather delay)"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicator whether vessel is under quarantine at anchorage"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance while at anchorage"
    - name: "pilot_required_flag"
      expr: pilot_required_flag
      comment: "Indicator whether pilot is required for vessel movement from anchorage"
    - name: "anchorage_year"
      expr: YEAR(actual_anchor_drop_time)
      comment: "Year of anchorage for trend analysis"
    - name: "anchorage_month"
      expr: DATE_TRUNC('MONTH', actual_anchor_drop_time)
      comment: "Month of anchorage for seasonal analysis"
    - name: "security_level"
      expr: security_level
      comment: "Security level applied during anchorage"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during anchorage for operational analysis"
  measures:
    - name: "total_anchorage_assignments"
      expr: COUNT(1)
      comment: "Total number of anchorage assignments for utilization tracking"
    - name: "unique_vessels_at_anchorage"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels using anchorage for demand analysis"
    - name: "avg_anchorage_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration vessels spend at anchorage for berth planning efficiency"
    - name: "total_anchorage_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours vessels spent at anchorage for congestion measurement"
    - name: "total_anchorage_charges"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total anchorage charges collected for revenue tracking"
    - name: "avg_waiting_time_hours"
      expr: AVG(CAST(TIMESTAMPDIFF(HOUR, actual_anchor_drop_time, expected_weigh_anchor_time) AS DOUBLE))
      comment: "Average waiting time from anchor drop to expected departure for port efficiency"
    - name: "vessels_in_quarantine"
      expr: SUM(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vessels under quarantine at anchorage for health compliance tracking"
    - name: "anchorages_requiring_pilot"
      expr: SUM(CASE WHEN pilot_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of anchorage assignments requiring pilot for resource planning"
    - name: "anchorages_requiring_tugs"
      expr: SUM(CASE WHEN tug_assistance_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of anchorage assignments requiring tug assistance for resource allocation"
    - name: "avg_water_depth_meters"
      expr: AVG(CAST(water_depth_meters AS DOUBLE))
      comment: "Average water depth at anchorage positions for safety and capacity planning"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voyage operational performance, schedule reliability, and cargo handling metrics for service quality and customer satisfaction management"
  source: "`shipping_ports_ecm`.`vessel`.`voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Current status of the voyage (e.g., scheduled, in-progress, completed, cancelled)"
    - name: "voyage_type"
      expr: voyage_type
      comment: "Type of voyage (e.g., laden, ballast, positioning)"
    - name: "service_name"
      expr: service_name
      comment: "Name of the shipping service for service-level analysis"
    - name: "is_maiden_call"
      expr: is_maiden_call
      comment: "Indicator whether this is the vessel's first call on this service"
    - name: "is_omitted"
      expr: is_omitted
      comment: "Indicator whether the voyage was omitted from the schedule"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance for the voyage"
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status of the vessel during voyage"
    - name: "voyage_year"
      expr: YEAR(ata)
      comment: "Year of voyage arrival for trend analysis"
    - name: "voyage_quarter"
      expr: CONCAT('Q', QUARTER(ata), '-', YEAR(ata))
      comment: "Quarter and year of voyage arrival for quarterly performance reviews"
    - name: "imdg_cargo_onboard_flag"
      expr: imdg_cargo_onboard_flag
      comment: "Indicator whether IMDG dangerous cargo is onboard"
  measures:
    - name: "total_voyages"
      expr: COUNT(1)
      comment: "Total number of voyages for service frequency and volume tracking"
    - name: "completed_voyages"
      expr: SUM(CASE WHEN voyage_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of completed voyages for service reliability measurement"
    - name: "omitted_voyages"
      expr: SUM(CASE WHEN is_omitted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of omitted voyages for schedule reliability analysis"
    - name: "total_laden_teu"
      expr: SUM(CAST(laden_teu_onboard AS DOUBLE))
      comment: "Total laden TEU across all voyages for cargo volume measurement"
    - name: "total_empty_teu"
      expr: SUM(CAST(empty_teu_onboard AS DOUBLE))
      comment: "Total empty TEU across all voyages for repositioning analysis"
    - name: "total_reefer_teu"
      expr: SUM(CAST(reefer_teu_onboard AS DOUBLE))
      comment: "Total reefer TEU across all voyages for specialized cargo tracking"
    - name: "avg_vessel_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(laden_teu_onboard AS DOUBLE) / NULLIF(CAST(total_teu_capacity AS DOUBLE), 0)), 2)
      comment: "Average vessel utilization percentage for capacity management and pricing strategy"
    - name: "schedule_reliability_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ABS(TIMESTAMPDIFF(HOUR, eta, ata)) <= 6 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voyages arriving within 6 hours of ETA for service quality measurement"
    - name: "voyages_with_imdg_cargo"
      expr: SUM(CASE WHEN imdg_cargo_onboard_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of voyages carrying dangerous goods for safety and compliance tracking"
    - name: "maiden_calls"
      expr: SUM(CASE WHEN is_maiden_call = TRUE THEN 1 ELSE 0 END)
      comment: "Number of maiden calls for new service development tracking"
$$;