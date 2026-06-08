-- Metric views for domain: terminal | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_container_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core container terminal operations metrics tracking throughput, dwell time, and operational efficiency for container movements through the terminal"
  source: "`shipping_ports_ecm`.`terminal`.`container_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the container visit (in-terminal, gated-out, etc.)"
    - name: "full_empty_indicator"
      expr: full_empty_indicator
      comment: "Whether container is full or empty"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo in the container"
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of arrival (vessel, truck, rail)"
    - name: "departure_mode"
      expr: departure_mode
      comment: "Mode of departure (vessel, truck, rail)"
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Indicates if container requires refrigeration"
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates if container has damage"
    - name: "oog_flag"
      expr: oog_flag
      comment: "Indicates if container is out-of-gauge (oversized)"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_timestamp)
      comment: "Month when container entered terminal"
    - name: "gate_out_month"
      expr: DATE_TRUNC('MONTH', gate_out_timestamp)
      comment: "Month when container exited terminal"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG hazardous goods classification"
  measures:
    - name: "total_container_visits"
      expr: COUNT(1)
      comment: "Total number of container visits through the terminal"
    - name: "total_teu"
      expr: SUM(CAST(teu_factor AS DOUBLE))
      comment: "Total twenty-foot equivalent units handled"
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(dwell_time_hours AS DOUBLE))
      comment: "Average time containers spend in terminal from gate-in to gate-out"
    - name: "total_vgm_weight_tonnes"
      expr: SUM(CAST(vgm_weight_kg AS DOUBLE)) / 1000.0
      comment: "Total verified gross mass in tonnes for all containers"
    - name: "avg_vgm_weight_kg"
      expr: AVG(CAST(vgm_weight_kg AS DOUBLE))
      comment: "Average verified gross mass per container in kilograms"
    - name: "reefer_container_count"
      expr: COUNT(CASE WHEN reefer_flag = TRUE THEN 1 END)
      comment: "Number of refrigerated containers handled"
    - name: "damaged_container_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of containers with damage reported"
    - name: "oog_container_count"
      expr: COUNT(CASE WHEN oog_flag = TRUE THEN 1 END)
      comment: "Number of out-of-gauge oversized containers"
    - name: "hazmat_container_count"
      expr: COUNT(CASE WHEN imdg_class IS NOT NULL THEN 1 END)
      comment: "Number of hazardous materials containers"
    - name: "avg_reefer_temp_setpoint_c"
      expr: AVG(CAST(reefer_temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint for refrigerated containers in Celsius"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_gate_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate operations efficiency metrics tracking truck processing times, throughput, and gate performance"
  source: "`shipping_ports_ecm`.`terminal`.`gate_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of gate transaction (gate-in, gate-out, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the gate transaction"
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates if damage was detected at gate"
    - name: "gate_clerk_override_flag"
      expr: gate_clerk_override_flag
      comment: "Indicates if gate clerk manually overrode system"
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Status of container seal verification"
    - name: "transaction_date"
      expr: DATE_TRUNC('DAY', transaction_timestamp)
      comment: "Date of gate transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of gate transaction"
    - name: "transaction_hour"
      expr: HOUR(transaction_timestamp)
      comment: "Hour of day for gate transaction"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG hazardous goods classification"
  measures:
    - name: "total_gate_transactions"
      expr: COUNT(1)
      comment: "Total number of gate transactions processed"
    - name: "avg_processing_time_seconds"
      expr: AVG(CAST(processing_duration_seconds AS DOUBLE))
      comment: "Average time to process a truck through the gate in seconds"
    - name: "total_processing_time_hours"
      expr: SUM(CAST(processing_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total gate processing time in hours"
    - name: "avg_weight_bridge_reading_tonnes"
      expr: AVG(CAST(weight_bridge_reading_kg AS DOUBLE)) / 1000.0
      comment: "Average weight bridge reading in tonnes"
    - name: "total_vgm_weight_tonnes"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE)) / 1000.0
      comment: "Total verified gross mass processed through gate in tonnes"
    - name: "damage_detection_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of transactions where damage was detected"
    - name: "override_count"
      expr: COUNT(CASE WHEN gate_clerk_override_flag = TRUE THEN 1 END)
      comment: "Number of transactions requiring clerk override"
    - name: "seal_failure_count"
      expr: COUNT(CASE WHEN seal_verification_status = 'FAILED' THEN 1 END)
      comment: "Number of transactions with seal verification failures"
    - name: "hazmat_transaction_count"
      expr: COUNT(CASE WHEN imdg_class IS NOT NULL THEN 1 END)
      comment: "Number of hazardous materials transactions"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_berth_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Berth utilization and vessel operations metrics tracking berth productivity, turnaround time, and allocation efficiency"
  source: "`shipping_ports_ecm`.`terminal`.`terminal_berth_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of berth allocation (confirmed, cancelled, completed)"
    - name: "cargo_operation_type"
      expr: cargo_operation_type
      comment: "Type of cargo operation (loading, discharge, both)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the berth allocation"
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Indicates if pilotage is required"
    - name: "towage_required_flag"
      expr: towage_required_flag
      comment: "Indicates if towage is required"
    - name: "imdg_cargo_flag"
      expr: imdg_cargo_flag
      comment: "Indicates if vessel carries hazardous cargo"
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Indicates if weather restrictions apply"
    - name: "tide_window_required_flag"
      expr: tide_window_required_flag
      comment: "Indicates if tide window is required"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', berth_window_start)
      comment: "Month of berth allocation"
    - name: "crane_allocation_type"
      expr: crane_allocation_type
      comment: "Type of crane allocation strategy"
  measures:
    - name: "total_berth_allocations"
      expr: COUNT(1)
      comment: "Total number of berth allocations"
    - name: "avg_berth_window_hours"
      expr: AVG(CAST(berth_window_duration_hours AS DOUBLE))
      comment: "Average duration of berth window in hours"
    - name: "total_berth_hours"
      expr: SUM(CAST(berth_window_duration_hours AS DOUBLE))
      comment: "Total berth hours allocated"
    - name: "avg_quay_length_allocated_m"
      expr: AVG(CAST(allocated_quay_length_m AS DOUBLE))
      comment: "Average quay length allocated per vessel in meters"
    - name: "total_expected_teu"
      expr: SUM(CAST(expected_teu_volume AS DOUBLE))
      comment: "Total expected TEU volume across all allocations"
    - name: "avg_vessel_loa_m"
      expr: AVG(CAST(vessel_loa_m AS DOUBLE))
      comment: "Average vessel length overall in meters"
    - name: "avg_vessel_draft_m"
      expr: AVG(CAST(vessel_draft_m AS DOUBLE))
      comment: "Average vessel draft in meters"
    - name: "avg_productivity_target_mph"
      expr: AVG(CAST(berth_productivity_target_mph AS DOUBLE))
      comment: "Average berth productivity target in moves per hour"
    - name: "avg_sla_turnaround_hours"
      expr: AVG(CAST(sla_turnaround_time_hours AS DOUBLE))
      comment: "Average SLA turnaround time in hours"
    - name: "cancelled_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled berth allocations"
    - name: "hazmat_vessel_count"
      expr: COUNT(CASE WHEN imdg_cargo_flag = TRUE THEN 1 END)
      comment: "Number of vessels carrying hazardous cargo"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_equipment_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal equipment productivity metrics tracking crane moves, equipment utilization, and operational efficiency"
  source: "`shipping_ports_ecm`.`terminal`.`equipment_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Status of equipment dispatch"
    - name: "work_instruction_type"
      expr: work_instruction_type
      comment: "Type of work instruction (load, discharge, rehandle)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment dispatched"
    - name: "productive_flag"
      expr: productive_flag
      comment: "Indicates if move was productive"
    - name: "rehandle_flag"
      expr: rehandle_flag
      comment: "Indicates if move was a rehandle"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates if handling hazardous materials"
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Indicates if handling refrigerated container"
    - name: "oversized_flag"
      expr: oversized_flag
      comment: "Indicates if handling oversized cargo"
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates if damage occurred during move"
    - name: "twin_lift_flag"
      expr: twin_lift_flag
      comment: "Indicates if twin lift operation"
    - name: "tandem_lift_flag"
      expr: tandem_lift_flag
      comment: "Indicates if tandem lift operation"
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_timestamp)
      comment: "Month of equipment dispatch"
    - name: "rehandle_reason_code"
      expr: rehandle_reason_code
      comment: "Reason code for rehandle operation"
  measures:
    - name: "total_equipment_moves"
      expr: COUNT(1)
      comment: "Total number of equipment moves"
    - name: "productive_moves"
      expr: COUNT(CASE WHEN productive_flag = TRUE THEN 1 END)
      comment: "Number of productive moves"
    - name: "rehandle_moves"
      expr: COUNT(CASE WHEN rehandle_flag = TRUE THEN 1 END)
      comment: "Number of rehandle moves"
    - name: "avg_moves_per_hour"
      expr: AVG(CAST(moves_per_hour AS DOUBLE))
      comment: "Average crane moves per hour"
    - name: "avg_gross_crane_time_minutes"
      expr: AVG(CAST(gross_crane_time_seconds AS DOUBLE)) / 60.0
      comment: "Average gross crane time per move in minutes"
    - name: "avg_net_crane_time_minutes"
      expr: AVG(CAST(net_crane_time_seconds AS DOUBLE)) / 60.0
      comment: "Average net crane time per move in minutes"
    - name: "avg_idle_time_minutes"
      expr: AVG(CAST(idle_time_seconds AS DOUBLE)) / 60.0
      comment: "Average idle time per move in minutes"
    - name: "total_gross_crane_hours"
      expr: SUM(CAST(gross_crane_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total gross crane hours"
    - name: "total_net_crane_hours"
      expr: SUM(CAST(net_crane_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total net crane hours"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total idle hours"
    - name: "twin_lift_count"
      expr: COUNT(CASE WHEN twin_lift_flag = TRUE THEN 1 END)
      comment: "Number of twin lift operations"
    - name: "tandem_lift_count"
      expr: COUNT(CASE WHEN tandem_lift_flag = TRUE THEN 1 END)
      comment: "Number of tandem lift operations"
    - name: "damage_incident_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of moves with damage incidents"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_reefer_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refrigerated container monitoring metrics tracking temperature compliance, alarm events, and cold chain integrity"
  source: "`shipping_ports_ecm`.`terminal`.`reefer_monitoring`"
  dimensions:
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of reefer monitoring"
    - name: "alarm_flag"
      expr: alarm_flag
      comment: "Indicates if alarm was triggered"
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm (temperature, power, etc.)"
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of alarm"
    - name: "cold_chain_compliance_flag"
      expr: cold_chain_compliance_flag
      comment: "Indicates if cold chain compliance maintained"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates if corrective action is required"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates if SLA was breached"
    - name: "power_status"
      expr: power_status
      comment: "Power status of reefer unit"
    - name: "compressor_status"
      expr: compressor_status
      comment: "Status of compressor"
    - name: "door_status"
      expr: door_status
      comment: "Status of container door"
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_timestamp)
      comment: "Month of monitoring reading"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of refrigerated cargo"
  measures:
    - name: "total_monitoring_readings"
      expr: COUNT(1)
      comment: "Total number of reefer monitoring readings"
    - name: "alarm_event_count"
      expr: COUNT(CASE WHEN alarm_flag = TRUE THEN 1 END)
      comment: "Number of alarm events triggered"
    - name: "cold_chain_breach_count"
      expr: COUNT(CASE WHEN cold_chain_compliance_flag = FALSE THEN 1 END)
      comment: "Number of cold chain compliance breaches"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of SLA breaches"
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature AS DOUBLE))
      comment: "Average actual temperature in Celsius"
    - name: "avg_set_temperature_c"
      expr: AVG(CAST(set_temperature AS DOUBLE))
      comment: "Average set temperature in Celsius"
    - name: "avg_temperature_deviation_c"
      expr: AVG(CAST(temperature_deviation AS DOUBLE))
      comment: "Average temperature deviation from setpoint in Celsius"
    - name: "avg_humidity_pct"
      expr: AVG(CAST(humidity_reading AS DOUBLE))
      comment: "Average humidity reading in percent"
    - name: "avg_compressor_runtime_hours"
      expr: AVG(CAST(compressor_runtime_hours AS DOUBLE))
      comment: "Average compressor runtime in hours"
    - name: "avg_power_voltage"
      expr: AVG(CAST(power_supply_voltage AS DOUBLE))
      comment: "Average power supply voltage"
    - name: "corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of readings requiring corrective action"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_gate_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate appointment system metrics tracking appointment compliance, no-shows, and truck turn time efficiency"
  source: "`shipping_ports_ecm`.`terminal`.`gate_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Status of gate appointment"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (delivery, pickup, etc.)"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates if truck did not show for appointment"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Indicates if inspection is required"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection required"
    - name: "is_hazardous_cargo"
      expr: is_hazardous_cargo
      comment: "Indicates if cargo is hazardous"
    - name: "is_overweight"
      expr: is_overweight
      comment: "Indicates if cargo is overweight"
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of appointment"
    - name: "appointment_hour"
      expr: HOUR(appointment_window_start)
      comment: "Hour of appointment window start"
    - name: "haulier_name"
      expr: haulier_name
      comment: "Name of haulier company"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of gate appointments"
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-show appointments"
    - name: "completed_appointment_count"
      expr: COUNT(CASE WHEN appointment_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed appointments"
    - name: "cancelled_appointment_count"
      expr: COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled appointments"
    - name: "avg_processing_duration_minutes"
      expr: AVG(CAST(processing_duration_minutes AS DOUBLE))
      comment: "Average processing duration in minutes"
    - name: "total_processing_hours"
      expr: SUM(CAST(processing_duration_minutes AS DOUBLE)) / 60.0
      comment: "Total processing time in hours"
    - name: "avg_vgm_weight_tonnes"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE)) / 1000.0
      comment: "Average verified gross mass in tonnes"
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Number of appointments requiring inspection"
    - name: "hazmat_appointment_count"
      expr: COUNT(CASE WHEN is_hazardous_cargo = TRUE THEN 1 END)
      comment: "Number of hazardous cargo appointments"
    - name: "overweight_appointment_count"
      expr: COUNT(CASE WHEN is_overweight = TRUE THEN 1 END)
      comment: "Number of overweight cargo appointments"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_container_damage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container damage tracking metrics for liability management, repair cost analysis, and quality control"
  source: "`shipping_ports_ecm`.`terminal`.`container_damage`"
  dimensions:
    - name: "damage_report_status"
      expr: damage_report_status
      comment: "Status of damage report"
    - name: "damage_type"
      expr: damage_type
      comment: "Type of damage"
    - name: "damage_severity"
      expr: damage_severity
      comment: "Severity level of damage"
    - name: "discovery_point"
      expr: discovery_point
      comment: "Point where damage was discovered"
    - name: "liability_party"
      expr: liability_party
      comment: "Party liable for damage"
    - name: "cargo_damage_indicator"
      expr: cargo_damage_indicator
      comment: "Indicates if cargo was also damaged"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates if safety incident occurred"
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Indicates if environmental incident occurred"
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_timestamp)
      comment: "Month when damage was discovered"
    - name: "damage_location_code"
      expr: damage_location_code
      comment: "Location code where damage occurred"
  measures:
    - name: "total_damage_reports"
      expr: COUNT(1)
      comment: "Total number of container damage reports"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all damage reports"
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost incurred"
    - name: "avg_estimated_repair_cost"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per damage report"
    - name: "avg_actual_repair_cost"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average actual repair cost per damage report"
    - name: "cargo_damage_count"
      expr: COUNT(CASE WHEN cargo_damage_indicator = TRUE THEN 1 END)
      comment: "Number of incidents with cargo damage"
    - name: "safety_incident_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of damage incidents involving safety issues"
    - name: "environmental_incident_count"
      expr: COUNT(CASE WHEN environmental_incident_flag = TRUE THEN 1 END)
      comment: "Number of damage incidents with environmental impact"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal service order metrics tracking value-added services, revenue, and service delivery performance"
  source: "`shipping_ports_ecm`.`terminal`.`terminal_service_order`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Status of service order"
    - name: "service_location_type"
      expr: service_location_type
      comment: "Type of location where service is performed"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of service order"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of service order"
    - name: "approval_required"
      expr: approval_required
      comment: "Indicates if approval is required"
    - name: "quality_check_performed"
      expr: quality_check_performed
      comment: "Indicates if quality check was performed"
    - name: "quality_check_result"
      expr: quality_check_result
      comment: "Result of quality check"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates if service met SLA"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month when service was requested"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when service was completed"
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of terminal service orders"
    - name: "total_service_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from terminal services"
    - name: "avg_service_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per service order"
    - name: "avg_service_duration_minutes"
      expr: AVG(CAST(service_duration_minutes AS DOUBLE))
      comment: "Average service duration in minutes"
    - name: "total_service_hours"
      expr: SUM(CAST(service_duration_minutes AS DOUBLE)) / 60.0
      comment: "Total service hours delivered"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target in hours"
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of service orders meeting SLA"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Number of service orders breaching SLA"
    - name: "quality_check_pass_count"
      expr: COUNT(CASE WHEN quality_check_result = 'PASS' THEN 1 END)
      comment: "Number of service orders passing quality check"
    - name: "cancelled_service_count"
      expr: COUNT(CASE WHEN service_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled service orders"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_hazmat_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous materials handling metrics tracking dangerous goods compliance, safety, and regulatory adherence"
  source: "`shipping_ports_ecm`.`terminal`.`hazmat_declaration`"
  dimensions:
    - name: "terminal_acceptance_status"
      expr: terminal_acceptance_status
      comment: "Terminal acceptance status for hazmat"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG hazardous goods classification"
    - name: "packing_group"
      expr: packing_group
      comment: "UN packing group"
    - name: "marine_pollutant_flag"
      expr: marine_pollutant_flag
      comment: "Indicates if substance is marine pollutant"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates if inspection is required"
    - name: "placarding_required_flag"
      expr: placarding_required_flag
      comment: "Indicates if placarding is required"
    - name: "limited_quantity_flag"
      expr: limited_quantity_flag
      comment: "Indicates if limited quantity exemption applies"
    - name: "excepted_quantity_flag"
      expr: excepted_quantity_flag
      comment: "Indicates if excepted quantity exemption applies"
    - name: "segregation_group"
      expr: segregation_group
      comment: "Segregation group for stowage"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', dgd_submission_timestamp)
      comment: "Month of dangerous goods declaration submission"
  measures:
    - name: "total_hazmat_declarations"
      expr: COUNT(1)
      comment: "Total number of hazardous materials declarations"
    - name: "accepted_hazmat_count"
      expr: COUNT(CASE WHEN terminal_acceptance_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of accepted hazmat declarations"
    - name: "rejected_hazmat_count"
      expr: COUNT(CASE WHEN terminal_acceptance_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected hazmat declarations"
    - name: "total_hazmat_weight_tonnes"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE)) / 1000.0
      comment: "Total gross weight of hazardous materials in tonnes"
    - name: "avg_hazmat_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per hazmat declaration in kilograms"
    - name: "avg_flashpoint_celsius"
      expr: AVG(CAST(flashpoint_celsius AS DOUBLE))
      comment: "Average flashpoint temperature in Celsius"
    - name: "avg_segregation_distance_m"
      expr: AVG(CAST(segregation_distance_meters AS DOUBLE))
      comment: "Average segregation distance required in meters"
    - name: "marine_pollutant_count"
      expr: COUNT(CASE WHEN marine_pollutant_flag = TRUE THEN 1 END)
      comment: "Number of marine pollutant declarations"
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of declarations requiring inspection"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`terminal_yard_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yard slot utilization metrics tracking yard capacity, occupancy, and storage efficiency"
  source: "`shipping_ports_ecm`.`terminal`.`yard_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of yard slot"
    - name: "slot_type"
      expr: slot_type
      comment: "Type of yard slot"
    - name: "occupied_flag"
      expr: occupied_flag
      comment: "Indicates if slot is currently occupied"
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates if slot is active and available"
    - name: "reefer_plug_available"
      expr: reefer_plug_available
      comment: "Indicates if reefer plug is available"
    - name: "hazmat_approved"
      expr: hazmat_approved
      comment: "Indicates if slot is approved for hazmat"
    - name: "oog_approved"
      expr: oog_approved
      comment: "Indicates if slot is approved for out-of-gauge cargo"
    - name: "customs_inspection_zone"
      expr: customs_inspection_zone
      comment: "Indicates if slot is in customs inspection zone"
    - name: "operational_zone"
      expr: operational_zone
      comment: "Operational zone of yard slot"
    - name: "equipment_access_type"
      expr: equipment_access_type
      comment: "Type of equipment access for slot"
  measures:
    - name: "total_yard_slots"
      expr: COUNT(1)
      comment: "Total number of yard slots"
    - name: "occupied_slot_count"
      expr: COUNT(CASE WHEN occupied_flag = TRUE THEN 1 END)
      comment: "Number of occupied yard slots"
    - name: "available_slot_count"
      expr: COUNT(CASE WHEN occupied_flag = FALSE AND active_flag = TRUE THEN 1 END)
      comment: "Number of available yard slots"
    - name: "total_teu_capacity"
      expr: SUM(CAST(teu_capacity AS DOUBLE))
      comment: "Total TEU capacity across all yard slots"
    - name: "avg_teu_capacity_per_slot"
      expr: AVG(CAST(teu_capacity AS DOUBLE))
      comment: "Average TEU capacity per yard slot"
    - name: "total_max_weight_capacity_tonnes"
      expr: SUM(CAST(max_weight_capacity_kg AS DOUBLE)) / 1000.0
      comment: "Total maximum weight capacity in tonnes"
    - name: "avg_distance_to_gate_m"
      expr: AVG(CAST(distance_to_gate_meters AS DOUBLE))
      comment: "Average distance from slot to gate in meters"
    - name: "avg_distance_to_quay_m"
      expr: AVG(CAST(distance_to_quay_meters AS DOUBLE))
      comment: "Average distance from slot to quay in meters"
    - name: "reefer_capable_slot_count"
      expr: COUNT(CASE WHEN reefer_plug_available = TRUE THEN 1 END)
      comment: "Number of reefer-capable yard slots"
    - name: "hazmat_approved_slot_count"
      expr: COUNT(CASE WHEN hazmat_approved = TRUE THEN 1 END)
      comment: "Number of hazmat-approved yard slots"
    - name: "oog_approved_slot_count"
      expr: COUNT(CASE WHEN oog_approved = TRUE THEN 1 END)
      comment: "Number of out-of-gauge approved yard slots"
$$;