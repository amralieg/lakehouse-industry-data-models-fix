-- Metric views for domain: terminal | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_berth_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth allocation performance metrics covering vessel turnaround efficiency, SLA compliance, pilotage and towage service demand, and berth window utilisation. Used by port operations managers and terminal executives to optimise berth scheduling and vessel throughput."
  source: "`shipping_ports_ecm`.`terminal`.`berth_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the berth allocation (e.g. CONFIRMED, CANCELLED, COMPLETED) — primary operational grouping for berth scheduling analysis."
    - name: "cargo_operation_type"
      expr: cargo_operation_type
      comment: "Type of cargo operation (e.g. DISCHARGE, LOAD, BOTH) — used to segment berth productivity and resource demand by operation type."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the berth allocation — enables analysis of high-priority vessel handling versus standard scheduling."
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Indicates whether pilotage was required for this allocation — used to assess pilotage service demand and cost exposure."
    - name: "towage_required_flag"
      expr: towage_required_flag
      comment: "Indicates whether towage was required — used to assess towage service demand and associated cost."
    - name: "imdg_cargo_flag"
      expr: imdg_cargo_flag
      comment: "Indicates presence of IMDG (dangerous goods) cargo — used to segment allocations requiring special handling compliance."
    - name: "tide_window_required_flag"
      expr: tide_window_required_flag
      comment: "Indicates whether a tide window constraint applies — used to assess scheduling complexity and berth window flexibility."
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Indicates weather-related restrictions on the allocation — used to analyse weather-driven operational disruptions."
    - name: "crane_allocation_type"
      expr: crane_allocation_type
      comment: "Type of crane allocation assigned (e.g. SINGLE, TWIN, TANDEM) — used to segment productivity targets by crane configuration."
    - name: "berth_window_month"
      expr: DATE_TRUNC('MONTH', berth_window_start)
      comment: "Month of the berth window start — used for monthly trend analysis of berth utilisation and vessel call volumes."
  measures:
    - name: "total_berth_allocations"
      expr: COUNT(1)
      comment: "Total number of berth allocations — baseline volume metric for berth scheduling demand and port call activity."
    - name: "avg_berth_window_duration_hours"
      expr: AVG(CAST(berth_window_duration_hours AS DOUBLE))
      comment: "Average planned berth window duration in hours — key indicator of berth occupancy planning and scheduling efficiency."
    - name: "avg_sla_turnaround_time_hours"
      expr: AVG(CAST(sla_turnaround_time_hours AS DOUBLE))
      comment: "Average SLA-committed vessel turnaround time in hours — directly measures service level commitments to shipping lines."
    - name: "avg_vessel_draft_m"
      expr: AVG(CAST(vessel_draft_m AS DOUBLE))
      comment: "Average vessel draft in metres — used to assess berth depth utilisation and infrastructure adequacy for vessel mix."
    - name: "avg_allocated_quay_length_m"
      expr: AVG(CAST(allocated_quay_length_m AS DOUBLE))
      comment: "Average quay length allocated per berth call — measures quay infrastructure utilisation intensity."
    - name: "avg_berth_productivity_target_mph"
      expr: AVG(CAST(berth_productivity_target_mph AS DOUBLE))
      comment: "Average berth productivity target in moves per hour — benchmarks planned operational throughput against actual performance."
    - name: "total_quay_length_allocated_m"
      expr: SUM(CAST(allocated_quay_length_m AS DOUBLE))
      comment: "Total quay length allocated across all berth allocations — aggregate measure of quay infrastructure demand."
    - name: "pilotage_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pilotage_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth allocations requiring pilotage — informs pilotage resource planning and cost forecasting."
    - name: "towage_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN towage_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth allocations requiring towage — informs towage fleet sizing and marine service cost management."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allocation_status = 'CANCELLED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth allocations that were cancelled — measures scheduling reliability and revenue-at-risk from cancellations."
    - name: "imdg_cargo_allocation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN imdg_cargo_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berth allocations involving IMDG dangerous goods — used for safety compliance monitoring and resource planning."
    - name: "distinct_vessels_allocated"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels with berth allocations — measures breadth of shipping line and vessel call diversity."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines with berth allocations — measures customer diversity and commercial exposure."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_container_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container visit throughput and dwell metrics covering TEU volumes, reefer handling, dangerous goods, damage rates, and yard dwell efficiency. Core operational KPI layer for terminal throughput management and customer service performance."
  source: "`shipping_ports_ecm`.`terminal`.`container_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the container visit (e.g. IN_YARD, DEPARTED, ON_VESSEL) — primary grouping for container flow analysis."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo (e.g. FCL, LCL, BULK) — used to segment throughput and dwell metrics by cargo category."
    - name: "full_empty_indicator"
      expr: full_empty_indicator
      comment: "Indicates whether the container is full or empty — critical for yard capacity planning and equipment dispatch optimisation."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Indicates whether the container is a reefer (temperature-controlled) unit — used to segment reefer-specific KPIs and plug demand."
    - name: "oog_flag"
      expr: oog_flag
      comment: "Indicates out-of-gauge cargo — used to segment special handling requirements and yard planning complexity."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether container damage was recorded — used to monitor cargo integrity and liability exposure."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of arrival (e.g. VESSEL, TRUCK, RAIL) — used to analyse intermodal flow patterns and gate/quay demand."
    - name: "departure_mode"
      expr: departure_mode
      comment: "Mode of departure (e.g. VESSEL, TRUCK, RAIL) — used to analyse outbound intermodal distribution patterns."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code — used to analyse origin trade lane distribution and vessel service coverage."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code — used to analyse destination trade lane distribution and transhipment flows."
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_timestamp)
      comment: "Month of container gate-in — used for monthly throughput trend analysis and capacity planning."
  measures:
    - name: "total_container_visits"
      expr: COUNT(1)
      comment: "Total number of container visits — baseline throughput volume metric for terminal capacity and activity reporting."
    - name: "total_teu_throughput"
      expr: SUM(CAST(teu_factor AS DOUBLE))
      comment: "Total TEU throughput — the primary industry-standard volume metric for terminal performance benchmarking and capacity planning."
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(dwell_time_hours AS DOUBLE))
      comment: "Average container dwell time in hours — key efficiency KPI; high dwell times indicate yard congestion and storage cost exposure."
    - name: "total_vgm_weight_tonnes"
      expr: ROUND(SUM(CAST(vgm_weight_kg AS DOUBLE)) / 1000.0, 2)
      comment: "Total verified gross mass in tonnes — measures cargo weight throughput for berth and structural load planning."
    - name: "avg_tare_weight_kg"
      expr: AVG(CAST(tare_weight_kg AS DOUBLE))
      comment: "Average container tare weight in kg — used for equipment load planning and weight compliance monitoring."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN damage_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container visits with recorded damage — critical quality KPI linked to cargo liability, insurance claims, and customer satisfaction."
    - name: "reefer_container_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reefer_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container visits that are reefer units — used to plan reefer plug capacity and cold chain service resources."
    - name: "oog_container_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN oog_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of out-of-gauge container visits — measures special handling demand and yard planning complexity."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines with container visits — measures commercial diversity and customer concentration risk."
    - name: "distinct_vessels_served"
      expr: COUNT(DISTINCT port_call_id)
      comment: "Number of distinct vessel port calls with container activity — measures vessel call volume and service breadth."
    - name: "avg_reefer_temperature_setpoint_c"
      expr: AVG(CASE WHEN reefer_flag = TRUE THEN CAST(reefer_temperature_setpoint_c AS DOUBLE) END)
      comment: "Average reefer temperature setpoint in Celsius for reefer containers — used to monitor cold chain compliance and energy planning."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal equipment fleet health, utilisation, and lifecycle metrics. Supports asset management decisions on maintenance scheduling, replacement investment, and operational readiness of cranes, RTGs, reach stackers, and other port equipment."
  source: "`shipping_ports_ecm`.`terminal`.`equipment`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment (e.g. OPERATIONAL, UNDER_MAINTENANCE, DECOMMISSIONED) — primary grouping for fleet availability analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation of the equipment (e.g. MANUAL, SEMI_AUTO, FULLY_AUTO) — used to segment productivity and cost metrics by automation tier."
    - name: "fuel_power_type"
      expr: fuel_power_type
      comment: "Fuel or power type (e.g. DIESEL, ELECTRIC, HYBRID) — used for emissions reporting, energy cost analysis, and sustainability KPIs."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g. OWNED, LEASED, RENTED) — used to segment asset base for capital vs. operating expenditure analysis."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emission standard compliance level — used for environmental regulatory reporting and fleet upgrade planning."
    - name: "imdg_certified"
      expr: imdg_certified
      comment: "Indicates whether the equipment is certified for IMDG dangerous goods handling — used to assess dangerous goods handling capacity."
    - name: "gps_tracking_enabled"
      expr: gps_tracking_enabled
      comment: "Indicates whether GPS tracking is active on the equipment — used to assess real-time visibility coverage of the fleet."
    - name: "reefer_monitoring_capable"
      expr: reefer_monitoring_capable
      comment: "Indicates whether the equipment can monitor reefer containers — used to plan reefer handling capacity."
  measures:
    - name: "total_equipment_units"
      expr: COUNT(1)
      comment: "Total number of equipment units in the fleet — baseline fleet size metric for capacity and investment planning."
    - name: "operational_equipment_count"
      expr: SUM(CASE WHEN operational_status = 'OPERATIONAL' THEN 1 ELSE 0 END)
      comment: "Number of equipment units currently in operational status — measures available fleet capacity for terminal operations."
    - name: "fleet_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'OPERATIONAL' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet units in operational status — critical KPI for terminal throughput capacity and SLA delivery risk."
    - name: "avg_operating_hours_total"
      expr: AVG(CAST(operating_hours_total AS DOUBLE))
      comment: "Average total operating hours across the fleet — used to assess fleet age, wear, and remaining useful life for replacement planning."
    - name: "avg_hours_since_last_service"
      expr: AVG(CAST(operating_hours_since_last_service AS DOUBLE))
      comment: "Average operating hours since last service — key maintenance KPI; high values indicate overdue maintenance and breakdown risk."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of the equipment fleet — measures capital asset exposure and informs insurance and investment decisions."
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per equipment unit — used for asset valuation benchmarking and procurement cost planning."
    - name: "avg_swl_tonnes"
      expr: AVG(CAST(swl_tonnes AS DOUBLE))
      comment: "Average safe working load in tonnes across the fleet — measures fleet lifting capacity for heavy cargo handling planning."
    - name: "imdg_certified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN imdg_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment units certified for dangerous goods handling — measures dangerous goods handling capacity compliance."
    - name: "gps_tracking_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gps_tracking_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet with GPS tracking enabled — measures real-time asset visibility coverage for operational control."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_equipment_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment dispatch productivity and quality metrics covering crane moves per hour, rehandle rates, hazmat handling, and dispatch efficiency. Core KPI layer for yard and quay crane productivity management."
  source: "`shipping_ports_ecm`.`terminal`.`equipment_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the equipment dispatch (e.g. COMPLETED, IN_PROGRESS, CANCELLED) — primary grouping for productivity analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment dispatched (e.g. STS_CRANE, RTG, REACH_STACKER) — used to segment productivity KPIs by equipment category."
    - name: "work_instruction_type"
      expr: work_instruction_type
      comment: "Type of work instruction (e.g. DISCHARGE, LOAD, SHIFT, REHANDLE) — used to segment dispatch activity by operation type."
    - name: "dispatch_source"
      expr: dispatch_source
      comment: "Source system or origin of the dispatch instruction — used to analyse TOS integration quality and manual override rates."
    - name: "productive_flag"
      expr: productive_flag
      comment: "Indicates whether the dispatch was a productive move — used to calculate productive vs. non-productive move ratios."
    - name: "rehandle_flag"
      expr: rehandle_flag
      comment: "Indicates whether the move was a rehandle — rehandles are non-revenue moves that reduce effective crane productivity."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the dispatch involved hazardous materials — used for safety compliance monitoring and resource planning."
    - name: "tandem_lift_flag"
      expr: tandem_lift_flag
      comment: "Indicates whether a tandem lift was performed — used to assess high-productivity lift utilisation rates."
    - name: "twin_lift_flag"
      expr: twin_lift_flag
      comment: "Indicates whether a twin lift was performed — twin lifts double throughput per crane cycle and are a key productivity lever."
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_timestamp)
      comment: "Month of dispatch — used for monthly productivity trend analysis and performance benchmarking."
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total number of equipment dispatches — baseline move volume metric for crane and equipment utilisation reporting."
    - name: "avg_moves_per_hour"
      expr: AVG(CAST(moves_per_hour AS DOUBLE))
      comment: "Average crane/equipment moves per hour — the primary productivity KPI for terminal equipment performance benchmarking."
    - name: "rehandle_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rehandle_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches that are rehandles — high rehandle rates indicate poor yard planning and directly reduce effective throughput."
    - name: "productive_move_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN productive_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches classified as productive moves — measures operational efficiency and equipment utilisation quality."
    - name: "tandem_lift_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tandem_lift_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches using tandem lifts — measures utilisation of high-productivity lift configurations."
    - name: "twin_lift_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN twin_lift_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches using twin lifts — twin lift utilisation is a key lever for crane productivity improvement."
    - name: "hazmat_dispatch_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispatches involving hazardous materials — used for safety compliance monitoring and certified equipment demand planning."
    - name: "distinct_vessels_served"
      expr: COUNT(DISTINCT port_call_id)
      comment: "Number of distinct vessel port calls served by equipment dispatches — measures vessel service breadth and crane allocation spread."
    - name: "avg_reefer_temperature_celsius"
      expr: AVG(CASE WHEN reefer_flag = TRUE THEN CAST(reefer_temperature_celsius AS DOUBLE) END)
      comment: "Average actual reefer temperature during dispatch for reefer moves — used to monitor cold chain integrity during equipment handling."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_gate_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate transaction throughput, processing efficiency, and compliance metrics. Covers truck turn times, OCR/RFID capture rates, damage detection, customs hold rates, and gate clerk override frequency. Used by gate operations managers to optimise truck flow and compliance."
  source: "`shipping_ports_ecm`.`terminal`.`gate_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of gate transaction (e.g. GATE_IN, GATE_OUT, INTERCHANGE) — primary grouping for inbound vs. outbound flow analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the gate transaction (e.g. COMPLETED, REJECTED, PENDING) — used to monitor gate processing success rates."
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Result of seal verification check (e.g. VERIFIED, MISMATCH, NOT_CHECKED) — used for cargo security compliance monitoring."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether damage was recorded at the gate — used to monitor cargo integrity at point of entry/exit."
    - name: "gate_clerk_override_flag"
      expr: gate_clerk_override_flag
      comment: "Indicates whether a gate clerk manually overrode the automated system — high override rates signal automation quality issues."
    - name: "rpm_scan_result"
      expr: rpm_scan_result
      comment: "Result of radiation portal monitor scan — used for security compliance reporting and anomaly detection."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of gate transaction — used for monthly gate throughput trend analysis and capacity planning."
  measures:
    - name: "total_gate_transactions"
      expr: COUNT(1)
      comment: "Total number of gate transactions — baseline gate throughput volume metric for capacity and staffing planning."
    - name: "avg_processing_duration_seconds"
      expr: AVG(CAST(processing_duration_seconds AS DOUBLE))
      comment: "Average gate processing duration in seconds — primary gate efficiency KPI; directly impacts truck queue length and haulier satisfaction."
    - name: "gate_damage_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN damage_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gate transactions with damage recorded — measures cargo integrity at gate and liability exposure."
    - name: "clerk_override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gate_clerk_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring manual clerk override — high rates indicate automation failures or data quality issues requiring investment."
    - name: "seal_mismatch_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN seal_verification_status = 'MISMATCH' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with seal verification mismatches — critical security KPI for cargo integrity and customs compliance."
    - name: "avg_verified_gross_mass_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass at gate in kg — used for weight compliance monitoring and overweight detection."
    - name: "avg_weight_bridge_reading_kg"
      expr: AVG(CAST(weight_bridge_reading_kg AS DOUBLE))
      comment: "Average weighbridge reading in kg — used to validate VGM compliance and detect overweight vehicles."
    - name: "distinct_hauliers"
      expr: COUNT(DISTINCT haulier_id)
      comment: "Number of distinct hauliers transacting at the gate — measures haulier diversity and concentration risk in truck operations."
    - name: "distinct_gate_lanes_used"
      expr: COUNT(DISTINCT gate_lane_id)
      comment: "Number of distinct gate lanes used — measures gate lane utilisation spread and identifies bottleneck lanes."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_gate_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate appointment adherence, no-show rates, and hazardous cargo pre-notification metrics. Used by gate operations and customer service teams to manage truck appointment systems and reduce gate congestion."
  source: "`shipping_ports_ecm`.`terminal`.`gate_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Status of the gate appointment (e.g. CONFIRMED, CANCELLED, COMPLETED, NO_SHOW) — primary grouping for appointment adherence analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction for the appointment (e.g. GATE_IN, GATE_OUT) — used to segment appointment volumes by direction."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates whether the truck did not arrive for the appointment — no-shows waste gate slot capacity and disrupt scheduling."
    - name: "is_hazardous_cargo"
      expr: is_hazardous_cargo
      comment: "Indicates whether the appointment involves hazardous cargo — used for pre-notification compliance and resource planning."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Indicates whether the vehicle is flagged as overweight — used for weight compliance monitoring and gate rejection analysis."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Indicates whether an inspection was required for this appointment — used to plan inspection resource demand."
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of the appointment date — used for monthly appointment volume trend analysis and gate capacity planning."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of gate appointments — baseline volume metric for gate slot demand and truck appointment system utilisation."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments where the truck did not arrive — high no-show rates waste gate capacity and indicate poor appointment system adherence."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'CANCELLED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled — measures appointment system reliability and gate slot wastage."
    - name: "hazardous_cargo_appointment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazardous_cargo = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments involving hazardous cargo — used for safety resource planning and compliance monitoring."
    - name: "overweight_appointment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_overweight = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments flagged as overweight — measures weight compliance risk and gate rejection workload."
    - name: "inspection_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments requiring inspection — used to plan inspection staffing and estimate gate processing time impact."
    - name: "avg_verified_gross_mass_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass at appointment in kg — used for weight compliance pre-screening and overweight risk assessment."
    - name: "distinct_hauliers"
      expr: COUNT(DISTINCT haulier_id)
      comment: "Number of distinct hauliers with gate appointments — measures haulier community engagement with the appointment system."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_reefer_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reefer container cold chain compliance, alarm, and SLA breach metrics. Used by reefer operations teams and quality managers to ensure cold chain integrity, manage alarm response, and protect perishable cargo value."
  source: "`shipping_ports_ecm`.`terminal`.`reefer_monitoring`"
  dimensions:
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Current monitoring status of the reefer unit (e.g. ACTIVE, ALARM, OFFLINE) — primary grouping for reefer fleet health analysis."
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Indicates whether an alarm condition is active — used to identify reefer units requiring immediate intervention."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of the alarm (e.g. CRITICAL, WARNING, INFO) — used to prioritise corrective action and escalation."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm triggered (e.g. TEMPERATURE_DEVIATION, POWER_FAILURE, DOOR_OPEN) — used to categorise failure modes and drive preventive maintenance."
    - name: "cold_chain_compliance_flag"
      expr: cold_chain_compliance_flag
      comment: "Indicates whether the reefer unit is within cold chain compliance parameters — primary cold chain quality KPI."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether an SLA breach has occurred for this reefer monitoring event — used for customer SLA reporting and penalty exposure."
    - name: "power_status"
      expr: power_status
      comment: "Power supply status of the reefer unit (e.g. ON, OFF, FAULT) — used to monitor power infrastructure reliability."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action is required — used to track open action items and technician workload."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_timestamp)
      comment: "Month of monitoring event — used for monthly cold chain compliance trend analysis."
  measures:
    - name: "total_monitoring_events"
      expr: COUNT(1)
      comment: "Total number of reefer monitoring events — baseline volume metric for reefer monitoring system activity and coverage."
    - name: "alarm_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alarm_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events with an active alarm — primary reefer fleet health KPI; high rates indicate systemic equipment or power issues."
    - name: "cold_chain_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cold_chain_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events within cold chain compliance — critical quality KPI for perishable cargo protection and customer SLA delivery."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events with an SLA breach — directly measures contractual penalty exposure and customer satisfaction risk."
    - name: "avg_temperature_deviation_c"
      expr: AVG(CAST(temperature_deviation AS DOUBLE))
      comment: "Average temperature deviation from setpoint in Celsius — measures cold chain precision and identifies systemic refrigeration performance issues."
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature AS DOUBLE))
      comment: "Average actual recorded temperature across all reefer monitoring events — used to benchmark fleet temperature performance."
    - name: "avg_humidity_reading_pct"
      expr: AVG(CAST(humidity_reading AS DOUBLE))
      comment: "Average humidity reading across reefer monitoring events — used for humidity-sensitive cargo compliance monitoring."
    - name: "avg_compressor_runtime_hours"
      expr: AVG(CAST(compressor_runtime_hours AS DOUBLE))
      comment: "Average compressor runtime hours — used to assess compressor wear, maintenance scheduling, and energy consumption."
    - name: "corrective_action_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events requiring corrective action — measures technician workload demand and reefer fleet reliability."
    - name: "distinct_reefer_containers_monitored"
      expr: COUNT(DISTINCT container_visit_id)
      comment: "Number of distinct container visits under reefer monitoring — measures reefer monitoring coverage across the yard."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal service order fulfilment, SLA compliance, revenue, and quality metrics. Used by terminal operations and commercial teams to manage value-added service delivery, billing accuracy, and customer satisfaction."
  source: "`shipping_ports_ecm`.`terminal`.`terminal_service_order`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service order (e.g. COMPLETED, IN_PROGRESS, CANCELLED) — primary grouping for service fulfilment analysis."
    - name: "service_location_type"
      expr: service_location_type
      comment: "Location type where the service is performed (e.g. YARD, QUAY, WAREHOUSE) — used to segment service demand by terminal zone."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service order — used to analyse high-priority service fulfilment rates and SLA risk."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the service order was completed within SLA — primary customer service quality KPI."
    - name: "approval_required"
      expr: approval_required
      comment: "Indicates whether approval was required before execution — used to analyse approval workflow bottlenecks."
    - name: "approval_status"
      expr: approval_status
      comment: "Status of the approval workflow (e.g. APPROVED, PENDING, REJECTED) — used to identify approval delays impacting service delivery."
    - name: "quality_check_performed"
      expr: quality_check_performed
      comment: "Indicates whether a quality check was performed on the service — used to monitor quality assurance coverage."
    - name: "charge_currency"
      expr: charge_currency
      comment: "Currency of the service charge — used for multi-currency revenue analysis and FX exposure reporting."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_timestamp)
      comment: "Month the service was requested — used for monthly service demand trend analysis and resource planning."
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of terminal service orders — baseline volume metric for value-added service demand and revenue pipeline."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from terminal service orders — primary commercial KPI for value-added services revenue tracking."
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per service order — used to benchmark service pricing and identify revenue yield opportunities."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders completed within SLA — critical customer satisfaction KPI linked to penalty clauses and contract renewals."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_status = 'CANCELLED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders cancelled — measures revenue leakage and operational disruption from cancellations."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target duration in hours across service orders — used to benchmark service commitments and identify overly aggressive SLAs."
    - name: "quality_check_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_check_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders with a quality check performed — measures quality assurance coverage and process compliance."
    - name: "distinct_customers_served"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct customer accounts with service orders — measures commercial breadth and customer concentration in value-added services."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal infrastructure capacity, capability, and compliance metrics. Used by port authority executives and terminal operators to benchmark terminal assets, assess infrastructure investment needs, and monitor regulatory certifications."
  source: "`shipping_ports_ecm`.`terminal`.`terminal_terminal`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the terminal (e.g. OPERATIONAL, UNDER_CONSTRUCTION, DECOMMISSIONED) — primary grouping for active vs. inactive terminal analysis."
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of terminal (e.g. CONTAINER, BULK, RO_RO, MULTIPURPOSE) — used to segment capacity and capability metrics by terminal category."
    - name: "country_code"
      expr: country_code
      comment: "Country where the terminal is located — used for geographic analysis of port network capacity and trade lane coverage."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "Indicates ISPS Code compliance — mandatory security certification; non-compliance is a critical regulatory risk."
    - name: "iso_28000_certified"
      expr: iso_28000_certified
      comment: "Indicates ISO 28000 supply chain security certification — used for premium customer qualification and trade facilitation."
    - name: "dangerous_goods_certified"
      expr: dangerous_goods_certified
      comment: "Indicates dangerous goods handling certification — used to assess DG cargo handling capacity across the terminal network."
    - name: "customs_bonded_area"
      expr: customs_bonded_area
      comment: "Indicates whether the terminal has a customs bonded area — used to assess bonded storage capacity for customs-controlled cargo."
    - name: "cfs_facility_available"
      expr: cfs_facility_available
      comment: "Indicates whether a Container Freight Station is available — used to assess LCL consolidation and deconsolidation capacity."
  measures:
    - name: "total_terminals"
      expr: COUNT(1)
      comment: "Total number of terminals in the network — baseline fleet size metric for port network capacity planning."
    - name: "total_quay_length_m"
      expr: SUM(CAST(total_quay_length_m AS DOUBLE))
      comment: "Total quay length in metres across all terminals — primary infrastructure capacity metric for vessel berthing capacity planning."
    - name: "avg_quay_length_m"
      expr: AVG(CAST(total_quay_length_m AS DOUBLE))
      comment: "Average quay length per terminal — used to benchmark terminal scale and identify capacity expansion priorities."
    - name: "total_area_sqm"
      expr: SUM(CAST(total_area_sqm AS DOUBLE))
      comment: "Total terminal area in square metres across the network — measures land infrastructure capacity for yard and storage planning."
    - name: "total_cfs_area_sqm"
      expr: SUM(CAST(cfs_area_sqm AS DOUBLE))
      comment: "Total CFS (Container Freight Station) area in square metres — measures LCL cargo handling capacity across the terminal network."
    - name: "avg_max_vessel_draft_m"
      expr: AVG(CAST(max_vessel_draft_m AS DOUBLE))
      comment: "Average maximum vessel draft in metres — measures fleet-wide berth depth capability for large vessel accommodation."
    - name: "avg_max_vessel_loa_m"
      expr: AVG(CAST(max_vessel_loa_m AS DOUBLE))
      comment: "Average maximum vessel LOA (length overall) in metres — measures terminal capability to accommodate ultra-large container vessels."
    - name: "isps_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN isps_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with ISPS compliance — critical regulatory KPI; non-compliant terminals face port state control sanctions."
    - name: "dangerous_goods_certified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dangerous_goods_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals certified for dangerous goods handling — measures DG cargo handling network coverage."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_vessel_bay_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel bay plan stowage efficiency, OOG and reefer cargo planning, and pre-marshalling demand metrics. Used by vessel planners and terminal operations to optimise stowage plans, crane sequencing, and vessel stability."
  source: "`shipping_ports_ecm`.`terminal`.`vessel_bay_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the bay plan (e.g. DRAFT, APPROVED, EXECUTED) — primary grouping for plan lifecycle analysis."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code — used to segment bay plan TEU volumes by origin port and trade lane."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code — used to segment bay plan TEU volumes by destination port and trade lane."
    - name: "oog_flag"
      expr: oog_flag
      comment: "Indicates out-of-gauge cargo in the bay plan — used to assess special stowage complexity and deck planning requirements."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Indicates reefer cargo in the bay plan — used to assess reefer slot demand and power supply planning."
    - name: "transhipment_flag"
      expr: transhipment_flag
      comment: "Indicates transhipment cargo — used to segment transhipment TEU volumes and assess hub port connectivity performance."
    - name: "restow_flag"
      expr: restow_flag
      comment: "Indicates whether a restow is required — restows are non-productive moves that reduce crane efficiency and increase costs."
    - name: "pre_marshalling_required"
      expr: pre_marshalling_required
      comment: "Indicates whether pre-marshalling is required — pre-marshalling drives additional yard moves and equipment cost."
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_created_timestamp)
      comment: "Month the bay plan was created — used for monthly vessel call and stowage planning trend analysis."
  measures:
    - name: "total_bay_plans"
      expr: COUNT(1)
      comment: "Total number of vessel bay plans — baseline volume metric for vessel call planning activity."
    - name: "total_planned_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU count across all bay plans — primary vessel stowage volume metric for capacity utilisation and revenue planning."
    - name: "avg_teu_per_bay_plan"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU count per bay plan — measures average vessel utilisation and stowage density."
    - name: "oog_cargo_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN oog_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bay plans with OOG cargo — measures special stowage complexity and deck planning demand."
    - name: "reefer_cargo_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reefer_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bay plans with reefer cargo — measures reefer slot demand for vessel capacity planning."
    - name: "transhipment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transhipment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bay plans with transhipment cargo — measures hub port transhipment activity and connectivity value."
    - name: "restow_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN restow_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bay plans requiring restow — high restow rates indicate poor stowage planning and drive unnecessary crane moves and cost."
    - name: "pre_marshalling_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pre_marshalling_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bay plans requiring pre-marshalling — measures yard pre-work demand and associated equipment cost."
    - name: "total_oog_overhang_front_cm"
      expr: SUM(CAST(oog_overhang_front_cm AS DOUBLE))
      comment: "Total OOG front overhang in cm across bay plans — used for vessel stability and stowage safety compliance monitoring."
    - name: "distinct_vessels_planned"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of distinct vessels with bay plans — measures vessel call diversity and stowage planning workload breadth."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_yard_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yard block capacity, infrastructure capability, and safety certification metrics. Used by yard planners and terminal managers to optimise yard layout, reefer plug allocation, and dangerous goods segregation."
  source: "`shipping_ports_ecm`.`terminal`.`yard_block`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the yard block (e.g. ACTIVE, UNDER_MAINTENANCE, DECOMMISSIONED) — primary grouping for active yard capacity analysis."
    - name: "block_type"
      expr: block_type
      comment: "Type of yard block (e.g. IMPORT, EXPORT, TRANSHIPMENT, REEFER, HAZMAT) — used to segment capacity by cargo category."
    - name: "reefer_capable"
      expr: reefer_capable
      comment: "Indicates whether the yard block supports reefer containers — used to assess reefer storage capacity across the yard."
    - name: "imdg_certified"
      expr: imdg_certified
      comment: "Indicates whether the yard block is certified for IMDG dangerous goods — used to assess DG storage capacity and compliance."
    - name: "cctv_coverage"
      expr: cctv_coverage
      comment: "Indicates whether the yard block has CCTV coverage — used for security compliance and incident investigation capability assessment."
    - name: "lighting_available"
      expr: lighting_available
      comment: "Indicates whether lighting is available — used to assess 24-hour operational capability of yard blocks."
    - name: "segregation_zone"
      expr: segregation_zone
      comment: "Segregation zone designation — used for dangerous goods segregation compliance and yard planning."
  measures:
    - name: "total_yard_blocks"
      expr: COUNT(1)
      comment: "Total number of yard blocks — baseline yard infrastructure count for capacity planning."
    - name: "total_yard_area_sqm"
      expr: SUM(CAST(area_square_meters AS DOUBLE))
      comment: "Total yard area in square metres across all blocks — primary yard capacity metric for storage planning and throughput capacity assessment."
    - name: "avg_yard_block_area_sqm"
      expr: AVG(CAST(area_square_meters AS DOUBLE))
      comment: "Average yard block area in square metres — used to benchmark block sizing and identify expansion opportunities."
    - name: "reefer_capable_block_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reefer_capable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yard blocks capable of reefer storage — measures reefer infrastructure coverage and cold chain capacity."
    - name: "imdg_certified_block_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN imdg_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yard blocks certified for dangerous goods — measures DG storage compliance coverage across the yard."
    - name: "total_length_meters"
      expr: SUM(CAST(length_meters AS DOUBLE))
      comment: "Total yard block length in metres — used for yard layout planning and equipment access route optimisation."
    - name: "total_width_meters"
      expr: SUM(CAST(width_meters AS DOUBLE))
      comment: "Total yard block width in metres — used alongside length for yard footprint and density analysis."
    - name: "cctv_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cctv_coverage = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yard blocks with CCTV coverage — measures security surveillance coverage for cargo protection and incident response."
$$;