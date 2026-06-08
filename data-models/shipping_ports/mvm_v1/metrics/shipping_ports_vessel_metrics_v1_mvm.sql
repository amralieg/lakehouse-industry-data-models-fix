-- Metric views for domain: vessel | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vessel registry metrics covering fleet composition, capacity, compliance risk, and operational readiness. Used by port operations leadership to assess fleet profile and risk exposure."
  source: "`shipping_ports_ecm`.`vessel`.`vessel`"
  dimensions:
    - name: "vessel_type"
      expr: vessel_type_id
      comment: "Foreign key to vessel type master — used to segment fleet by vessel category (container, bulk, tanker, etc.)."
    - name: "flag_state"
      expr: flag_state_id
      comment: "Foreign key to flag state master — used to segment fleet by country of registration for regulatory and risk analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the vessel (e.g., Active, Laid-up, Scrapped) — key filter for active fleet analysis."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level assigned to the vessel — used for port security compliance segmentation."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Current sanctions screening status — critical for trade compliance and port access decisions."
    - name: "classification_society_code"
      expr: classification_society_code
      comment: "Classification society code (e.g., Lloyd's, DNV, BV) — used to segment fleet by certification body."
    - name: "owner_country_domicile_code"
      expr: owner_country_domicile_code
      comment: "Country of domicile of the registered owner — used for trade partner and geopolitical risk analysis."
    - name: "last_psc_detention_flag"
      expr: last_psc_detention_flag
      comment: "Boolean flag indicating whether the vessel was detained at its last PSC inspection — key risk indicator."
  measures:
    - name: "total_vessels"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Total number of distinct vessels in the registry. Baseline fleet size KPI for capacity planning and port throughput forecasting."
    - name: "avg_deadweight_tonnage"
      expr: AVG(CAST(dwt_tonnes AS DOUBLE))
      comment: "Average deadweight tonnage (DWT) across the fleet. Indicates average cargo-carrying capacity and informs berth and infrastructure planning."
    - name: "total_gross_registered_tonnage"
      expr: SUM(CAST(grt_tonnes AS DOUBLE))
      comment: "Total gross registered tonnage (GRT) of all vessels. Used for port dues calculation benchmarking and infrastructure load assessment."
    - name: "avg_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average length overall (LOA) in meters across the fleet. Drives berth allocation planning and channel navigation constraints."
    - name: "avg_draft_meters"
      expr: AVG(CAST(draft_meters AS DOUBLE))
      comment: "Average vessel draft in meters. Critical for channel depth management and tidal window planning."
    - name: "vessels_with_psc_detention"
      expr: COUNT(DISTINCT CASE WHEN last_psc_detention_flag = TRUE THEN vessel_id END)
      comment: "Number of vessels that were detained at their most recent PSC inspection. High-risk fleet indicator used by compliance and port state control teams."
    - name: "psc_detention_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN last_psc_detention_flag = TRUE THEN vessel_id END) / NULLIF(COUNT(DISTINCT vessel_id), 0), 2)
      comment: "Percentage of vessels with a PSC detention flag. Key compliance KPI — elevated rates trigger port authority intervention and shipping line reviews."
    - name: "vessels_with_sanctions_risk"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_status != 'CLEAR' THEN vessel_id END)
      comment: "Number of vessels with a non-clear sanctions screening status. Critical trade compliance metric monitored by port security and legal teams."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_port_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port call performance and revenue metrics measuring vessel turnaround efficiency, port stay duration, cargo throughput, and port charge yield. Core operational dashboard for port management."
  source: "`shipping_ports_ecm`.`vessel`.`call`"
  dimensions:
    - name: "call_status"
      expr: call_status
      comment: "Current status of the port call (e.g., Planned, In-Port, Completed, Cancelled) — primary filter for operational vs. historical analysis."
  measures:
    - name: "total_port_calls"
      expr: COUNT(DISTINCT port_call_id)
      comment: "Total number of distinct port calls. Primary throughput KPI for port capacity utilisation and revenue forecasting."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voyage-level metrics covering fleet utilisation, cargo capacity fill rates, schedule reliability, and operational compliance. Used by vessel operations and commercial teams to optimise voyage planning."
  source: "`shipping_ports_ecm`.`vessel`.`voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Current status of the voyage (e.g., Planned, In-Progress, Completed, Omitted) — primary filter for active vs. historical voyage analysis."
    - name: "voyage_type"
      expr: voyage_type
      comment: "Type of voyage (e.g., Laden, Ballast, Coastal, Deep-Sea) — used to segment capacity utilisation and cost analysis."
    - name: "shipping_line"
      expr: shipping_line_id
      comment: "Foreign key to shipping line master — enables per-operator performance benchmarking."
    - name: "service_route"
      expr: service_route_id
      comment: "Foreign key to service route — used to analyse voyage performance by trade lane."
    - name: "is_omitted"
      expr: is_omitted
      comment: "Boolean flag indicating whether the voyage was omitted — used to track schedule reliability and omission rates."
    - name: "is_maiden_call"
      expr: is_maiden_call
      comment: "Boolean flag indicating whether this is the vessel's maiden call — used for new service onboarding tracking."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for the voyage — used for trade compliance monitoring and delay root-cause analysis."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level applicable to the voyage — used for port security compliance segmentation."
    - name: "imdg_cargo_onboard_flag"
      expr: imdg_cargo_onboard_flag
      comment: "Boolean flag indicating presence of IMDG (dangerous goods) cargo — used for safety and regulatory compliance reporting."
  measures:
    - name: "total_voyages"
      expr: COUNT(DISTINCT voyage_id)
      comment: "Total number of distinct voyages. Baseline fleet activity KPI for schedule density and operational throughput reporting."
    - name: "total_laden_teu_onboard"
      expr: SUM(CAST(laden_teu_onboard AS DOUBLE))
      comment: "Total laden TEU onboard across all voyages. Primary cargo volume KPI for trade lane throughput and revenue forecasting."
    - name: "total_teu_capacity"
      expr: SUM(CAST(total_teu_capacity AS DOUBLE))
      comment: "Total TEU capacity deployed across all voyages. Denominator for capacity utilisation calculations and fleet deployment analysis."
    - name: "avg_capacity_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(laden_teu_onboard AS DOUBLE)) / NULLIF(SUM(CAST(total_teu_capacity AS DOUBLE)), 0), 2)
      comment: "Average TEU capacity utilisation percentage across voyages. Core commercial KPI — low utilisation signals revenue leakage; high utilisation drives yield management decisions."
    - name: "total_reefer_teu_onboard"
      expr: SUM(CAST(reefer_teu_onboard AS DOUBLE))
      comment: "Total reefer (refrigerated) TEU onboard across voyages. Premium cargo volume KPI — reefer cargo commands higher tariffs and requires specialised infrastructure."
    - name: "reefer_teu_mix_pct"
      expr: ROUND(100.0 * SUM(CAST(reefer_teu_onboard AS DOUBLE)) / NULLIF(SUM(CAST(laden_teu_onboard AS DOUBLE)), 0), 2)
      comment: "Reefer TEU as a percentage of total laden TEU. Revenue quality KPI — higher reefer mix indicates premium cargo yield and cold chain infrastructure demand."
    - name: "total_empty_teu_onboard"
      expr: SUM(CAST(empty_teu_onboard AS DOUBLE))
      comment: "Total empty TEU repositioned across voyages. Cost efficiency KPI — high empty repositioning volumes indicate trade imbalance and incremental operating costs."
    - name: "empty_teu_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(empty_teu_onboard AS DOUBLE)) / NULLIF(SUM(CAST(total_teu_capacity AS DOUBLE)), 0), 2)
      comment: "Empty TEU as a percentage of total capacity. Trade imbalance KPI — high ratios signal repositioning cost pressure and commercial opportunity to fill backhaul legs."
    - name: "voyage_omission_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_omitted = TRUE THEN voyage_id END) / NULLIF(COUNT(DISTINCT voyage_id), 0), 2)
      comment: "Percentage of voyages that were omitted. Schedule reliability KPI — high omission rates damage shipping line relationships and port revenue predictability."
    - name: "avg_berth_productivity_target"
      expr: AVG(CAST(berth_productivity_target AS DOUBLE))
      comment: "Average berth productivity target (moves per hour) set for voyages. Operational planning KPI used to benchmark actual terminal performance against contracted targets."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_bunker_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bunker operation metrics covering fuel procurement volumes, costs, quality compliance, and delivery efficiency. Used by marine operations and procurement teams to manage fuel spend and supplier performance."
  source: "`shipping_ports_ecm`.`vessel`.`bunker_operation`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel bunkered (e.g., HFO, VLSFO, MGO, LNG) — primary segmentation for emissions compliance and cost analysis."
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Specific fuel grade — used for quality compliance and sulphur content regulatory reporting."
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the bunker operation (e.g., Planned, In-Progress, Completed, Cancelled) — used to filter completed vs. in-progress operations."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of fuel delivery (e.g., Barge, Pipeline, Truck) — used to segment delivery efficiency and cost by channel."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Location type where bunkering occurred (e.g., Berth, Anchorage) — used for operational planning and cost allocation."
    - name: "bunker_supplier_name"
      expr: bunker_supplier_name
      comment: "Name of the bunker fuel supplier — used for supplier performance benchmarking and procurement analysis."
    - name: "safety_checklist_completed_flag"
      expr: safety_checklist_completed_flag
      comment: "Boolean flag indicating whether the safety checklist was completed — critical safety compliance KPI."
    - name: "fuel_sample_taken_flag"
      expr: fuel_sample_taken_flag
      comment: "Boolean flag indicating whether a fuel sample was taken for quality verification — used for quality assurance compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the bunker transaction was denominated — used for multi-currency cost consolidation."
  measures:
    - name: "total_bunker_operations"
      expr: COUNT(DISTINCT bunker_operation_id)
      comment: "Total number of distinct bunker operations. Baseline activity KPI for fuel procurement frequency and supplier engagement tracking."
    - name: "total_fuel_delivered_mt"
      expr: SUM(CAST(quantity_delivered_mt AS DOUBLE))
      comment: "Total fuel quantity delivered in metric tonnes. Primary volume KPI for fuel procurement reporting and emissions baseline calculation."
    - name: "total_fuel_ordered_mt"
      expr: SUM(CAST(quantity_ordered_mt AS DOUBLE))
      comment: "Total fuel quantity ordered in metric tonnes. Used as denominator for delivery fulfilment rate calculation."
    - name: "delivery_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_delivered_mt AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered_mt AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered fuel quantity actually delivered. Supplier reliability KPI — shortfalls indicate supply chain risk and potential vessel operational disruption."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total fuel procurement cost across all bunker operations. Primary cost KPI for vessel operating expense management and budget variance analysis."
    - name: "avg_unit_price_per_mt"
      expr: AVG(CAST(unit_price_per_mt AS DOUBLE))
      comment: "Average fuel unit price per metric tonne. Procurement benchmarking KPI — used to evaluate supplier pricing against market indices."
    - name: "avg_sulphur_content_pct"
      expr: AVG(CAST(sulphur_content_percent AS DOUBLE))
      comment: "Average sulphur content percentage of bunkered fuel. Regulatory compliance KPI — must remain within IMO 2020 sulphur cap limits (0.5% global, 0.1% ECA)."
    - name: "safety_checklist_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safety_checklist_completed_flag = TRUE THEN bunker_operation_id END) / NULLIF(COUNT(DISTINCT bunker_operation_id), 0), 2)
      comment: "Percentage of bunker operations with a completed safety checklist. HSSE compliance KPI — non-compliance is a reportable safety incident and regulatory violation."
    - name: "fuel_sample_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fuel_sample_taken_flag = TRUE THEN bunker_operation_id END) / NULLIF(COUNT(DISTINCT bunker_operation_id), 0), 2)
      comment: "Percentage of bunker operations where a fuel sample was taken. Quality assurance KPI — required under MARPOL Annex VI for fuel quality verification and dispute resolution."
    - name: "avg_density_at_15c"
      expr: AVG(CAST(density_at_15c_kg_per_m3 AS DOUBLE))
      comment: "Average fuel density at 15°C in kg/m³. Fuel quality KPI — deviations from grade specifications indicate off-spec fuel delivery and potential engine damage risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_psc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port State Control inspection metrics covering inspection outcomes, deficiency rates, detention performance, and compliance risk. Used by port authority compliance teams and vessel operators to manage regulatory risk."
  source: "`shipping_ports_ecm`.`vessel`.`psc_inspection`"
  dimensions:
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the PSC inspection (e.g., No Deficiencies, Deficiencies, Detained) — primary segmentation for compliance performance analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of PSC inspection (e.g., Initial, Expanded, Concentrated Inspection Campaign) — used to segment inspection intensity and outcome rates."
    - name: "inspection_regime"
      expr: inspection_regime
      comment: "Inspection regime under which the inspection was conducted (e.g., Paris MOU, Tokyo MOU, USCG) — used for regional compliance benchmarking."
    - name: "psc_authority_name"
      expr: psc_authority_name
      comment: "Name of the PSC authority conducting the inspection — used to segment outcomes by inspecting authority."
    - name: "detention_flag"
      expr: detention_flag
      comment: "Boolean flag indicating whether the vessel was detained — primary risk indicator for fleet compliance status."
    - name: "ship_risk_profile"
      expr: ship_risk_profile
      comment: "Risk profile classification of the vessel at time of inspection (e.g., Low, Standard, High) — used to validate risk-based inspection targeting effectiveness."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Boolean flag indicating whether follow-up action is required post-inspection — used to track open compliance actions."
    - name: "flag_state_notified_flag"
      expr: flag_state_notified_flag
      comment: "Boolean flag indicating whether the flag state was notified of inspection findings — used for regulatory notification compliance tracking."
  measures:
    - name: "total_psc_inspections"
      expr: COUNT(DISTINCT psc_inspection_id)
      comment: "Total number of PSC inspections conducted. Baseline compliance activity KPI for regulatory engagement reporting."
    - name: "total_detentions"
      expr: COUNT(DISTINCT CASE WHEN detention_flag = TRUE THEN psc_inspection_id END)
      comment: "Total number of vessel detentions resulting from PSC inspections. Critical compliance KPI — detentions cause direct revenue loss, reputational damage, and port access restrictions."
    - name: "detention_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN detention_flag = TRUE THEN psc_inspection_id END) / NULLIF(COUNT(DISTINCT psc_inspection_id), 0), 2)
      comment: "Percentage of PSC inspections resulting in vessel detention. Primary fleet compliance KPI — industry benchmark is below 3%; rates above 5% trigger MOU targeted inspection campaigns."
    - name: "avg_detention_duration_hours"
      expr: AVG(CAST(detention_duration_hours AS DOUBLE))
      comment: "Average detention duration in hours for detained vessels. Operational impact KPI — longer detentions indicate more severe deficiencies and higher revenue loss per incident."
    - name: "total_detention_hours"
      expr: SUM(CAST(detention_duration_hours AS DOUBLE))
      comment: "Total vessel detention hours across all PSC inspections. Aggregate operational disruption KPI — used to quantify fleet-wide compliance cost and schedule impact."
    - name: "inspections_with_follow_up"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN psc_inspection_id END)
      comment: "Number of inspections requiring follow-up action. Open compliance action KPI — used to manage rectification workload and track closure rates."
    - name: "follow_up_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN psc_inspection_id END) / NULLIF(COUNT(DISTINCT psc_inspection_id), 0), 2)
      comment: "Percentage of PSC inspections requiring follow-up action. Compliance quality KPI — high rates indicate systemic vessel maintenance or documentation deficiencies."
    - name: "flag_state_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN flag_state_notified_flag = TRUE THEN psc_inspection_id END) / NULLIF(COUNT(DISTINCT CASE WHEN detention_flag = TRUE THEN psc_inspection_id END), 0), 2)
      comment: "Percentage of detention cases where the flag state was notified. Regulatory obligation compliance KPI — flag state notification is mandatory under SOLAS and MOU agreements."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_anchorage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anchorage utilisation and operational metrics covering wait times, capacity demand, safety compliance, and clearance status. Used by VTS and port operations teams to manage anchorage congestion and vessel flow."
  source: "`shipping_ports_ecm`.`vessel`.`anchorage`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the anchorage assignment (e.g., Active, Completed, Cancelled) — primary filter for live vs. historical anchorage analysis."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the anchorage assignment — used to analyse priority queue management and fairness of berth allocation."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the anchorage assignment (e.g., Awaiting Berth, Customs Hold, Weather) — used for root-cause analysis of port congestion."
    - name: "security_level"
      expr: security_level
      comment: "ISPS security level at the anchorage — used for port security compliance reporting."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status during anchorage — used to identify customs-related delays contributing to port congestion."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Boolean flag indicating whether the vessel is under quarantine at anchorage — used for port health authority reporting."
    - name: "pilot_required_flag"
      expr: pilot_required_flag
      comment: "Boolean flag indicating whether pilotage is required for the vessel to proceed from anchorage — used for pilot scheduling and resource planning."
    - name: "tug_assistance_required_flag"
      expr: tug_assistance_required_flag
      comment: "Boolean flag indicating whether tug assistance is required — used for tug fleet scheduling and capacity planning."
  measures:
    - name: "total_anchorage_assignments"
      expr: COUNT(DISTINCT anchorage_id)
      comment: "Total number of anchorage assignments. Baseline demand KPI for anchorage capacity planning and port congestion monitoring."
    - name: "avg_anchorage_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average anchorage duration in hours. Port efficiency KPI — prolonged anchorage times indicate berth congestion, customs delays, or operational bottlenecks."
    - name: "total_anchorage_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total anchorage hours across all assignments. Aggregate congestion KPI — used to quantify port waiting time and its impact on vessel operating costs and schedule reliability."
    - name: "avg_water_depth_meters"
      expr: AVG(CAST(water_depth_meters AS DOUBLE))
      comment: "Average water depth at anchorage positions in meters. Infrastructure safety KPI — used to validate anchorage suitability for vessel draft requirements."
    - name: "quarantine_anchorage_count"
      expr: COUNT(DISTINCT CASE WHEN quarantine_flag = TRUE THEN anchorage_id END)
      comment: "Number of anchorage assignments involving quarantined vessels. Port health KPI — monitored by port health authorities for biosecurity risk management."
    - name: "pilot_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pilot_required_flag = TRUE THEN anchorage_id END) / NULLIF(COUNT(DISTINCT anchorage_id), 0), 2)
      comment: "Percentage of anchorage assignments requiring pilotage. Pilot resource demand KPI — used to forecast pilot scheduling requirements and avoid service bottlenecks."
    - name: "tug_assistance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN tug_assistance_required_flag = TRUE THEN anchorage_id END) / NULLIF(COUNT(DISTINCT anchorage_id), 0), 2)
      comment: "Percentage of anchorage assignments requiring tug assistance. Tug fleet demand KPI — used for tug capacity planning and marine services revenue forecasting."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel movement metrics covering traffic flow, pilotage demand, tug utilisation, delay performance, and navigational safety. Used by VTS, marine operations, and port planning teams to optimise vessel traffic management."
  source: "`shipping_ports_ecm`.`vessel`.`movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of vessel movement (e.g., Arrival, Departure, Shift, Anchorage) — primary segmentation for traffic flow analysis."
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the movement (e.g., Planned, In-Progress, Completed, Cancelled) — used to filter active vs. historical movements."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level applicable to the movement — used for port security compliance segmentation."
    - name: "pilot_on_board_flag"
      expr: pilot_on_board_flag
      comment: "Boolean flag indicating whether a pilot was on board during the movement — used for pilotage compliance and safety analysis."
    - name: "tug_assistance_flag"
      expr: tug_assistance_flag
      comment: "Boolean flag indicating whether tug assistance was used — used for tug utilisation and revenue analysis."
    - name: "dangerous_cargo_flag"
      expr: dangerous_cargo_flag
      comment: "Boolean flag indicating whether the vessel was carrying dangerous cargo during the movement — used for IMDG safety compliance reporting."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for movement delay — used for root-cause analysis of port congestion and schedule disruption."
  measures:
    - name: "total_movements"
      expr: COUNT(DISTINCT movement_id)
      comment: "Total number of vessel movements. Primary port traffic KPI — used for VTS workload planning, channel capacity management, and port throughput reporting."
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_knots AS DOUBLE))
      comment: "Average vessel speed over ground in knots during movements. Navigational safety KPI — deviations from speed limits in port approaches indicate compliance issues."
    - name: "avg_draft_aft_meters"
      expr: AVG(CAST(draft_aft_meters AS DOUBLE))
      comment: "Average aft draft in meters across movements. Channel depth management KPI — used to validate under-keel clearance compliance for safe navigation."
    - name: "avg_air_draft_meters"
      expr: AVG(CAST(air_draft_meters AS DOUBLE))
      comment: "Average air draft in meters across movements. Bridge and overhead clearance safety KPI — critical for port infrastructure planning and vessel routing."
    - name: "movements_with_tug_assistance"
      expr: COUNT(DISTINCT CASE WHEN tug_assistance_flag = TRUE THEN movement_id END)
      comment: "Number of movements utilising tug assistance. Tug demand KPI — used for tug fleet utilisation reporting and marine services revenue tracking."
    - name: "tug_utilisation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN tug_assistance_flag = TRUE THEN movement_id END) / NULLIF(COUNT(DISTINCT movement_id), 0), 2)
      comment: "Percentage of movements utilising tug assistance. Marine services demand KPI — used to optimise tug fleet sizing and pricing strategy."
    - name: "dangerous_cargo_movement_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dangerous_cargo_flag = TRUE THEN movement_id END) / NULLIF(COUNT(DISTINCT movement_id), 0), 2)
      comment: "Percentage of movements involving dangerous cargo. Port safety risk KPI — high rates require enhanced VTS monitoring, dedicated berth allocation, and emergency response readiness."
    - name: "movements_with_delays"
      expr: COUNT(DISTINCT CASE WHEN delay_reason_code IS NOT NULL THEN movement_id END)
      comment: "Number of movements experiencing a recorded delay. Schedule reliability KPI — used to identify systemic bottlenecks in port traffic flow and berth allocation."
    - name: "avg_tide_height_meters"
      expr: AVG(CAST(tide_height_meters AS DOUBLE))
      comment: "Average tide height in meters at time of movement. Tidal window planning KPI — used to validate that movements are scheduled within safe tidal windows for deep-draft vessels."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_draft_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Draft survey metrics covering cargo weight accuracy, survey quality, and vessel stability parameters. Used by cargo operations, billing, and compliance teams to validate cargo weights for tariff billing and safety compliance."
  source: "`shipping_ports_ecm`.`vessel`.`draft_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of draft survey (e.g., Loading, Discharging, Bunker) — primary segmentation for cargo weight verification analysis."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the draft survey (e.g., Pending, Completed, Disputed) — used to filter completed vs. in-progress surveys."
    - name: "survey_purpose"
      expr: survey_purpose
      comment: "Purpose of the draft survey — used to segment surveys by commercial or regulatory intent."
    - name: "survey_accuracy_rating"
      expr: survey_accuracy_rating
      comment: "Accuracy rating assigned to the survey — used to assess surveyor quality and identify surveys requiring re-verification."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Boolean flag indicating whether a survey certificate was issued — used for billing and compliance documentation tracking."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of survey — used to contextualise survey accuracy and identify adverse condition impacts."
    - name: "sea_state_code"
      expr: sea_state_code
      comment: "Sea state code at time of survey — used to assess environmental conditions affecting draft measurement accuracy."
  measures:
    - name: "total_draft_surveys"
      expr: COUNT(DISTINCT draft_survey_id)
      comment: "Total number of draft surveys conducted. Baseline activity KPI for cargo weight verification workload and surveyor capacity planning."
    - name: "total_calculated_cargo_weight_mt"
      expr: SUM(CAST(calculated_cargo_weight_mt AS DOUBLE))
      comment: "Total calculated cargo weight in metric tonnes across all draft surveys. Primary cargo throughput KPI — used for wharfage billing validation and trade volume reporting."
    - name: "avg_calculated_cargo_weight_mt"
      expr: AVG(CAST(calculated_cargo_weight_mt AS DOUBLE))
      comment: "Average calculated cargo weight per draft survey in metric tonnes. Cargo intensity KPI — used to benchmark survey workload and validate billing accuracy."
    - name: "avg_displacement_mt"
      expr: AVG(CAST(displacement_mt AS DOUBLE))
      comment: "Average vessel displacement in metric tonnes at time of survey. Vessel loading KPI — used to validate structural load limits and port infrastructure stress analysis."
    - name: "avg_mean_draft_meters"
      expr: AVG(CAST(mean_draft_meters AS DOUBLE))
      comment: "Average mean draft in meters across all surveys. Channel and berth depth planning KPI — used to validate under-keel clearance compliance for surveyed vessels."
    - name: "avg_trim_meters"
      expr: AVG(CAST(trim_meters AS DOUBLE))
      comment: "Average vessel trim in meters at time of survey. Vessel stability KPI — excessive trim values indicate loading imbalance and potential safety risk."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN certificate_issued_flag = TRUE THEN draft_survey_id END) / NULLIF(COUNT(DISTINCT draft_survey_id), 0), 2)
      comment: "Percentage of draft surveys resulting in certificate issuance. Billing completeness KPI — low rates indicate survey disputes or documentation gaps that delay cargo billing."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`vessel_agent_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipping agent appointment metrics covering agency portfolio, authority delegation, compliance status, and performance. Used by port commercial and compliance teams to manage agent relationships and authority governance."
  source: "`shipping_ports_ecm`.`vessel`.`agent_appointment`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of shipping agency (e.g., General Agent, Protective Agent, Husbanding Agent) — primary segmentation for agency portfolio analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the agent appointment (e.g., Active, Terminated, Suspended) — used to filter active vs. historical appointments."
    - name: "appointment_scope"
      expr: appointment_scope
      comment: "Scope of the agent appointment (e.g., Full Agency, Limited Scope) — used to segment authority delegation levels."
    - name: "isps_security_clearance_status"
      expr: isps_security_clearance_status
      comment: "ISPS security clearance status of the agent — used for port security compliance and access control reporting."
    - name: "financial_authority_flag"
      expr: financial_authority_flag
      comment: "Boolean flag indicating whether the agent has financial authority — used for financial governance and disbursement control analysis."
    - name: "customs_clearance_authority"
      expr: customs_clearance_authority
      comment: "Boolean flag indicating whether the agent has customs clearance authority — used for trade compliance governance."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating assigned to the agent — used for agent relationship management and contract renewal decisions."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Boolean flag indicating whether the agent is EDI-enabled for electronic data interchange — used for digital integration readiness assessment."
  measures:
    - name: "total_agent_appointments"
      expr: COUNT(DISTINCT agent_appointment_id)
      comment: "Total number of agent appointments. Baseline agency portfolio KPI for commercial relationship management and port coverage analysis."
    - name: "active_agent_appointments"
      expr: COUNT(DISTINCT CASE WHEN appointment_status = 'Active' THEN agent_appointment_id END)
      comment: "Number of currently active agent appointments. Operational coverage KPI — ensures sufficient agency representation across all active port calls."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage across all agent appointments. Cost governance KPI — used by commercial teams to benchmark agency commission structures and control disbursement costs."
    - name: "agents_with_financial_authority"
      expr: COUNT(DISTINCT CASE WHEN financial_authority_flag = TRUE THEN agent_appointment_id END)
      comment: "Number of agent appointments with financial authority delegated. Financial governance KPI — used to monitor disbursement authority exposure and ensure appropriate controls."
    - name: "financial_authority_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN financial_authority_flag = TRUE THEN agent_appointment_id END) / NULLIF(COUNT(DISTINCT agent_appointment_id), 0), 2)
      comment: "Percentage of agent appointments with financial authority. Governance risk KPI — high rates may indicate over-delegation of financial controls requiring audit attention."
    - name: "edi_enabled_agent_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN edi_enabled_flag = TRUE THEN agent_appointment_id END) / NULLIF(COUNT(DISTINCT agent_appointment_id), 0), 2)
      comment: "Percentage of agent appointments with EDI capability enabled. Digital transformation KPI — low rates indicate manual processing bottlenecks in port community data exchange."
$$;