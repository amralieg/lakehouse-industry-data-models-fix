-- Metric views for domain: marine | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_pilotage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pilotage service delivery metrics tracking pilot assignments, passage performance, safety compliance, and revenue generation across vessel movements through port channels and fairways."
  source: "`shipping_ports_ecm`.`marine`.`pilotage_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the pilotage assignment (scheduled, in-progress, completed, cancelled)"
    - name: "service_type"
      expr: service_type
      comment: "Type of pilotage service provided (inbound, outbound, shift, harbor)"
    - name: "pilot_licence_class"
      expr: pilot_licence_class
      comment: "Licence class of the assigned pilot indicating authorized vessel types and routes"
    - name: "boarding_method"
      expr: boarding_method
      comment: "Method used for pilot boarding (launch, helicopter, shore-side)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the pilotage service (pending, invoiced, paid)"
    - name: "assignment_year"
      expr: YEAR(actual_boarding_timestamp)
      comment: "Year of actual pilot boarding for temporal analysis"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', actual_boarding_timestamp)
      comment: "Month of actual pilot boarding for trend analysis"
    - name: "assignment_date"
      expr: DATE(actual_boarding_timestamp)
      comment: "Date of actual pilot boarding for daily operational reporting"
    - name: "tug_required_flag"
      expr: tug_required
      comment: "Indicator whether tug assistance was required for the pilotage"
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Indicator whether any incident was reported during the pilotage"
    - name: "isps_compliance_verified_flag"
      expr: isps_compliance_verified
      comment: "Indicator whether ISPS security compliance was verified"
    - name: "deviation_from_passage_plan_flag"
      expr: deviation_from_passage_plan
      comment: "Indicator whether the vessel deviated from the planned passage route"
  measures:
    - name: "total_pilotage_assignments"
      expr: COUNT(1)
      comment: "Total number of pilotage assignments completed or in progress"
    - name: "total_pilotage_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total revenue generated from pilotage service charges"
    - name: "avg_pilotage_charge"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average service charge per pilotage assignment"
    - name: "total_passage_distance_nm"
      expr: SUM(CAST(passage_distance_nm AS DOUBLE))
      comment: "Total nautical miles piloted across all assignments"
    - name: "avg_passage_distance_nm"
      expr: AVG(CAST(passage_distance_nm AS DOUBLE))
      comment: "Average passage distance per pilotage assignment in nautical miles"
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_avg_knots AS DOUBLE))
      comment: "Average vessel speed over ground during pilotage operations"
    - name: "min_ukc_recorded_avg_m"
      expr: AVG(CAST(min_ukc_recorded_m AS DOUBLE))
      comment: "Average minimum under-keel clearance recorded across pilotage assignments"
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments where incidents were reported"
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deviation_from_passage_plan = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments with deviations from passage plan"
    - name: "tug_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tug_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments requiring tug assistance"
    - name: "isps_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN isps_compliance_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments with verified ISPS compliance"
    - name: "unique_pilots_assigned"
      expr: COUNT(DISTINCT pilot_id)
      comment: "Number of unique pilots assigned across all pilotage assignments"
    - name: "unique_vessels_piloted"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels receiving pilotage services"
    - name: "avg_visibility_nm"
      expr: AVG(CAST(visibility_nm AS DOUBLE))
      comment: "Average visibility in nautical miles during pilotage operations"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed in knots during pilotage operations"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_towage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Towage service delivery and operational efficiency metrics tracking tug assignments, service completion, safety performance, and revenue generation for vessel movements requiring tug assistance."
  source: "`shipping_ports_ecm`.`marine`.`towage_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the towage order (requested, assigned, in-progress, completed, cancelled)"
    - name: "towage_type"
      expr: towage_type
      comment: "Type of towage service (berthing, unberthing, shifting, escort, emergency)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the towage service (pending, invoiced, paid)"
    - name: "service_outcome"
      expr: service_outcome
      comment: "Outcome of the towage service (successful, aborted, incident)"
    - name: "visibility_category"
      expr: visibility_category
      comment: "Visibility conditions during towage operation (good, moderate, poor, restricted)"
    - name: "order_year"
      expr: YEAR(actual_commencement)
      comment: "Year of actual towage commencement for temporal analysis"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', actual_commencement)
      comment: "Month of actual towage commencement for trend analysis"
    - name: "order_date"
      expr: DATE(actual_commencement)
      comment: "Date of actual towage commencement for daily operational reporting"
    - name: "imdg_hazmat_flag"
      expr: imdg_hazmat_flag
      comment: "Indicator whether the vessel carried IMDG hazardous materials"
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Indicator whether safety observations were noted during the operation"
    - name: "tug_attachment_bow_flag"
      expr: tug_attachment_bow
      comment: "Indicator whether tug was attached at bow position"
    - name: "tug_attachment_stern_flag"
      expr: tug_attachment_stern
      comment: "Indicator whether tug was attached at stern position"
  measures:
    - name: "total_towage_orders"
      expr: COUNT(1)
      comment: "Total number of towage orders requested or completed"
    - name: "total_towage_revenue"
      expr: SUM(CAST(towage_charge_amount AS DOUBLE))
      comment: "Total revenue generated from towage service charges"
    - name: "avg_towage_charge"
      expr: AVG(CAST(towage_charge_amount AS DOUBLE))
      comment: "Average charge per towage order"
    - name: "avg_min_bollard_pull_tonnes"
      expr: AVG(CAST(min_bollard_pull_tonnes AS DOUBLE))
      comment: "Average minimum bollard pull required in tonnes across towage orders"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed in knots during towage operations"
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed in knots during towage operations"
    - name: "safety_observation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_observation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders with safety observations noted"
    - name: "hazmat_towage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN imdg_hazmat_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders involving hazardous materials"
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_outcome = 'aborted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders that were aborted before completion"
    - name: "unique_vessels_towed"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels receiving towage services"
    - name: "unique_berths_served"
      expr: COUNT(DISTINCT berth_id)
      comment: "Number of unique berths involved in towage operations"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marine safety and incident management metrics tracking incident frequency, severity, investigation status, financial impact, and regulatory compliance for port operations risk management."
  source: "`shipping_ports_ecm`.`marine`.`marine_incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category
      comment: "High-level category of marine incident (collision, grounding, pollution, injury, property damage)"
    - name: "incident_type"
      expr: incident_type
      comment: "Specific type of marine incident within category"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of incident investigation (open, in-progress, closed, pending)"
    - name: "marpol_classification"
      expr: marpol_classification
      comment: "MARPOL classification of the incident if pollution-related"
    - name: "solas_classification"
      expr: solas_classification
      comment: "SOLAS classification of the incident if safety-related"
    - name: "incident_year"
      expr: YEAR(datetime)
      comment: "Year of incident occurrence for temporal analysis"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of incident occurrence for trend analysis"
    - name: "incident_date"
      expr: DATE(datetime)
      comment: "Date of incident occurrence for daily safety reporting"
    - name: "pollution_occurred_flag"
      expr: pollution_occurred
      comment: "Indicator whether pollution occurred during the incident"
    - name: "human_factor_involved_flag"
      expr: human_factor_involved
      comment: "Indicator whether human factors contributed to the incident"
    - name: "isps_security_implication_flag"
      expr: isps_security_implication
      comment: "Indicator whether the incident has ISPS security implications"
    - name: "pi_club_notified_flag"
      expr: pi_club_notified
      comment: "Indicator whether P&I club was notified of the incident"
    - name: "corrective_actions_completed_flag"
      expr: corrective_actions_completed
      comment: "Indicator whether corrective actions have been completed"
  measures:
    - name: "total_marine_incidents"
      expr: COUNT(1)
      comment: "Total number of marine incidents reported"
    - name: "total_estimated_damage_cost_usd"
      expr: SUM(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Total estimated damage cost across all incidents in USD"
    - name: "avg_estimated_damage_cost_usd"
      expr: AVG(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Average estimated damage cost per incident in USD"
    - name: "total_pollution_volume_litres"
      expr: SUM(CAST(pollution_volume_litres AS DOUBLE))
      comment: "Total volume of pollution in litres across all pollution incidents"
    - name: "avg_pollution_volume_litres"
      expr: AVG(CAST(pollution_volume_litres AS DOUBLE))
      comment: "Average pollution volume per pollution incident in litres"
    - name: "pollution_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pollution_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents involving pollution"
    - name: "human_factor_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN human_factor_involved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with human factors as contributing cause"
    - name: "pi_club_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pi_club_notified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents where P&I club was notified"
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_actions_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with completed corrective actions"
    - name: "avg_visibility_nautical_miles"
      expr: AVG(CAST(visibility_nautical_miles AS DOUBLE))
      comment: "Average visibility in nautical miles at time of incident"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed in knots at time of incident"
    - name: "unique_vessels_involved"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels involved in marine incidents"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_mooring_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mooring service delivery and safety metrics tracking mooring gang operations, line handling performance, equipment compliance, and revenue generation for vessel berthing and unberthing activities."
  source: "`shipping_ports_ecm`.`marine`.`mooring_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the mooring operation (scheduled, in-progress, completed, cancelled)"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of mooring operation (berthing, unberthing, shifting, re-mooring)"
    - name: "mooring_location_type"
      expr: mooring_location_type
      comment: "Type of mooring location (berth, anchorage, buoy, dolphin)"
    - name: "vessel_movement_type"
      expr: vessel_movement_type
      comment: "Type of vessel movement during mooring (arrival, departure, shift)"
    - name: "visibility_category"
      expr: visibility_category
      comment: "Visibility conditions during mooring operation (good, moderate, poor, restricted)"
    - name: "operation_year"
      expr: YEAR(commencement_timestamp)
      comment: "Year of mooring operation commencement for temporal analysis"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', commencement_timestamp)
      comment: "Month of mooring operation commencement for trend analysis"
    - name: "operation_date"
      expr: DATE(commencement_timestamp)
      comment: "Date of mooring operation commencement for daily operational reporting"
    - name: "billable_flag"
      expr: billable
      comment: "Indicator whether the mooring operation is billable to customer"
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Indicator whether any incident was reported during mooring operation"
    - name: "irregularity_observed_flag"
      expr: irregularity_observed
      comment: "Indicator whether any irregularity was observed during operation"
    - name: "swl_compliant_flag"
      expr: swl_compliant
      comment: "Indicator whether safe working load compliance was maintained"
    - name: "pilot_on_board_flag"
      expr: pilot_on_board
      comment: "Indicator whether a pilot was on board during mooring operation"
    - name: "towage_assist_used_flag"
      expr: towage_assist_used
      comment: "Indicator whether tug assistance was used during mooring"
  measures:
    - name: "total_mooring_operations"
      expr: COUNT(1)
      comment: "Total number of mooring operations completed or in progress"
    - name: "total_mooring_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue generated from mooring service charges"
    - name: "avg_mooring_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per mooring operation"
    - name: "avg_tide_height_m"
      expr: AVG(CAST(tide_height_m AS DOUBLE))
      comment: "Average tide height in meters during mooring operations"
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed in knots during mooring operations"
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed in knots during mooring operations"
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN incident_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations where incidents were reported"
    - name: "irregularity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN irregularity_observed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations with observed irregularities"
    - name: "swl_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN swl_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations compliant with safe working load requirements"
    - name: "towage_assist_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN towage_assist_used = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations requiring tug assistance"
    - name: "pilot_on_board_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pilot_on_board = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations with pilot on board"
    - name: "unique_vessels_moored"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels receiving mooring services"
    - name: "unique_berths_used"
      expr: COUNT(DISTINCT berth_id)
      comment: "Number of unique berths used for mooring operations"
    - name: "unique_gangs_deployed"
      expr: COUNT(DISTINCT gang_id)
      comment: "Number of unique mooring gangs deployed across operations"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Integrated marine service order management metrics tracking multi-service coordination, order fulfillment, service mix, and revenue across pilotage, towage, mooring, and launch services."
  source: "`shipping_ports_ecm`.`marine`.`marine_service_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the marine service order (draft, confirmed, in-progress, completed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of marine service order (standard, emergency, scheduled, ad-hoc)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service order (low, normal, high, urgent)"
    - name: "pilotage_type"
      expr: pilotage_type
      comment: "Type of pilotage service requested (inbound, outbound, shift, harbor)"
    - name: "order_year"
      expr: YEAR(created_timestamp)
      comment: "Year of service order creation for temporal analysis"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month of service order creation for trend analysis"
    - name: "order_date"
      expr: DATE(created_timestamp)
      comment: "Date of service order creation for daily operational reporting"
    - name: "pilotage_required_flag"
      expr: pilotage_required
      comment: "Indicator whether pilotage service is required in this order"
    - name: "towage_required_flag"
      expr: towage_required
      comment: "Indicator whether towage service is required in this order"
    - name: "mooring_required_flag"
      expr: mooring_required
      comment: "Indicator whether mooring service is required in this order"
    - name: "launch_service_required_flag"
      expr: launch_service_required
      comment: "Indicator whether launch service is required in this order"
    - name: "surveyor_required_flag"
      expr: surveyor_required
      comment: "Indicator whether surveyor service is required in this order"
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of marine service orders created"
    - name: "total_estimated_charges"
      expr: SUM(CAST(estimated_total_charge AS DOUBLE))
      comment: "Total estimated charges across all marine service orders"
    - name: "avg_estimated_charge"
      expr: AVG(CAST(estimated_total_charge AS DOUBLE))
      comment: "Average estimated charge per marine service order"
    - name: "pilotage_service_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pilotage_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring pilotage"
    - name: "towage_service_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN towage_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring towage"
    - name: "mooring_service_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mooring_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring mooring"
    - name: "launch_service_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN launch_service_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring launch service"
    - name: "surveyor_service_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN surveyor_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring surveyor service"
    - name: "multi_service_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN (CASE WHEN pilotage_required = TRUE THEN 1 ELSE 0 END + CASE WHEN towage_required = TRUE THEN 1 ELSE 0 END + CASE WHEN mooring_required = TRUE THEN 1 ELSE 0 END + CASE WHEN launch_service_required = TRUE THEN 1 ELSE 0 END) > 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service orders requiring multiple coordinated services"
    - name: "unique_vessel_calls_served"
      expr: COUNT(DISTINCT vessel_call_id)
      comment: "Number of unique vessel calls receiving marine services"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_pilot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilot workforce management and competency metrics tracking pilot qualifications, certifications, authorizations, duty status, and compliance for safe and efficient pilotage service delivery."
  source: "`shipping_ports_ecm`.`marine`.`pilot`"
  dimensions:
    - name: "competency_class"
      expr: competency_class
      comment: "Competency class of the pilot indicating authorized vessel sizes and routes"
    - name: "licence_status"
      expr: licence_status
      comment: "Current status of pilot licence (active, suspended, expired, revoked)"
    - name: "duty_status"
      expr: duty_status
      comment: "Current duty status of the pilot (on-duty, off-duty, standby, leave)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type of the pilot (permanent, contract, casual)"
    - name: "medical_cert_status"
      expr: medical_cert_status
      comment: "Status of pilot medical certificate (valid, expired, pending renewal)"
    - name: "home_port_code"
      expr: home_port_code
      comment: "Home port code where the pilot is primarily based"
    - name: "english_proficiency_level"
      expr: english_proficiency_level
      comment: "English language proficiency level for maritime communications"
    - name: "night_pilotage_authorised_flag"
      expr: night_pilotage_authorised
      comment: "Indicator whether pilot is authorized for night pilotage operations"
    - name: "deep_sea_pilot_endorsement_flag"
      expr: deep_sea_pilot_endorsement
      comment: "Indicator whether pilot holds deep sea pilotage endorsement"
    - name: "radar_arpa_endorsement_flag"
      expr: radar_arpa_endorsement
      comment: "Indicator whether pilot holds radar/ARPA endorsement"
    - name: "vhf_radio_operator_cert_flag"
      expr: vhf_radio_operator_cert
      comment: "Indicator whether pilot holds VHF radio operator certificate"
  measures:
    - name: "total_pilots"
      expr: COUNT(1)
      comment: "Total number of pilots in the workforce"
    - name: "active_pilots"
      expr: SUM(CASE WHEN licence_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of pilots with active licences"
    - name: "avg_max_dwt_authorized_mt"
      expr: AVG(CAST(max_dwt_mt AS DOUBLE))
      comment: "Average maximum deadweight tonnage authorized across all pilots"
    - name: "avg_max_grt_authorized"
      expr: AVG(CAST(max_grt AS DOUBLE))
      comment: "Average maximum gross registered tonnage authorized across all pilots"
    - name: "avg_max_loa_authorized_m"
      expr: AVG(CAST(max_loa_m AS DOUBLE))
      comment: "Average maximum length overall authorized in meters across all pilots"
    - name: "night_pilotage_authorization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN night_pilotage_authorised = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots authorized for night pilotage operations"
    - name: "deep_sea_endorsement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deep_sea_pilot_endorsement = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with deep sea pilotage endorsement"
    - name: "radar_arpa_endorsement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN radar_arpa_endorsement = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with radar/ARPA endorsement"
    - name: "vhf_cert_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vhf_radio_operator_cert = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with VHF radio operator certificate"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_tug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tug fleet asset management and capability metrics tracking tug specifications, operational status, certifications, maintenance schedules, and fleet capacity for towage service delivery."
  source: "`shipping_ports_ecm`.`marine`.`tug`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the tug (active, maintenance, standby, decommissioned)"
    - name: "tug_type"
      expr: tug_type
      comment: "Type of tug (harbor, ocean-going, escort, AHTS, salvage)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the tug (owned, chartered, contracted)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel type used by the tug (diesel, LNG, hybrid)"
    - name: "ice_class"
      expr: ice_class
      comment: "Ice class rating of the tug for cold climate operations"
    - name: "fifi_class"
      expr: fifi_class
      comment: "Fire-fighting capability class of the tug"
    - name: "home_port"
      expr: home_port
      comment: "Home port where the tug is primarily based"
    - name: "ahts_capable_flag"
      expr: ahts_capable
      comment: "Indicator whether tug is capable of anchor handling and towing supply operations"
    - name: "escort_certified_flag"
      expr: escort_certified
      comment: "Indicator whether tug is certified for escort towage operations"
  measures:
    - name: "total_tugs"
      expr: COUNT(1)
      comment: "Total number of tugs in the fleet"
    - name: "active_tugs"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of tugs currently in active operational status"
    - name: "total_bollard_pull_capacity_tonnes"
      expr: SUM(CAST(bollard_pull_tonnes AS DOUBLE))
      comment: "Total bollard pull capacity in tonnes across the entire tug fleet"
    - name: "avg_bollard_pull_tonnes"
      expr: AVG(CAST(bollard_pull_tonnes AS DOUBLE))
      comment: "Average bollard pull capacity per tug in tonnes"
    - name: "total_engine_power_kw"
      expr: SUM(CAST(engine_power_kw AS DOUBLE))
      comment: "Total engine power in kilowatts across the entire tug fleet"
    - name: "avg_engine_power_kw"
      expr: AVG(CAST(engine_power_kw AS DOUBLE))
      comment: "Average engine power per tug in kilowatts"
    - name: "avg_max_speed_knots"
      expr: AVG(CAST(max_speed_knots AS DOUBLE))
      comment: "Average maximum speed in knots across the tug fleet"
    - name: "avg_loa_m"
      expr: AVG(CAST(loa_m AS DOUBLE))
      comment: "Average length overall in meters across the tug fleet"
    - name: "avg_gross_tonnage"
      expr: AVG(CAST(gross_tonnage AS DOUBLE))
      comment: "Average gross tonnage across the tug fleet"
    - name: "escort_certified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escort_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tugs certified for escort towage operations"
    - name: "ahts_capable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ahts_capable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tugs capable of anchor handling and towing supply operations"
    - name: "avg_escort_bollard_pull_tonnes"
      expr: AVG(CAST(escort_bollard_pull_tonnes AS DOUBLE))
      comment: "Average escort bollard pull capacity in tonnes for escort-certified tugs"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_marpol_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and waste management metrics tracking MARPOL operations, waste disposal, ballast water treatment, emissions monitoring, and regulatory compliance for port environmental stewardship."
  source: "`shipping_ports_ecm`.`marine`.`marpol_operation`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of MARPOL operation (waste reception, ballast water discharge, emission monitoring, oil transfer)"
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the MARPOL operation (scheduled, in-progress, completed, cancelled)"
    - name: "marpol_annex_code"
      expr: marpol_annex_code
      comment: "MARPOL annex code applicable to the operation (I-VI)"
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste handled (oily waste, sewage, garbage, hazardous, cargo residues)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal (incineration, landfill, recycling, treatment)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of reception facility used (fixed, mobile, barge, truck)"
    - name: "ballast_water_treatment_method"
      expr: ballast_water_treatment_method
      comment: "Method used for ballast water treatment (UV, chemical, filtration, heat)"
    - name: "operation_year"
      expr: YEAR(operation_timestamp)
      comment: "Year of MARPOL operation for temporal analysis"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', operation_timestamp)
      comment: "Month of MARPOL operation for trend analysis"
    - name: "operation_date"
      expr: DATE(operation_timestamp)
      comment: "Date of MARPOL operation for daily environmental reporting"
    - name: "non_compliance_flag"
      expr: non_compliance_flag
      comment: "Indicator whether non-compliance was detected during the operation"
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Indicator whether PSC inspection was conducted"
    - name: "psc_deficiency_noted_flag"
      expr: psc_deficiency_noted
      comment: "Indicator whether PSC deficiency was noted during inspection"
  measures:
    - name: "total_marpol_operations"
      expr: COUNT(1)
      comment: "Total number of MARPOL operations conducted"
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste handled across all MARPOL operations"
    - name: "avg_waste_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average waste quantity per MARPOL operation"
    - name: "total_ballast_water_volume_m3"
      expr: SUM(CAST(ballast_water_volume_m3 AS DOUBLE))
      comment: "Total ballast water volume treated or discharged in cubic meters"
    - name: "avg_ballast_water_volume_m3"
      expr: AVG(CAST(ballast_water_volume_m3 AS DOUBLE))
      comment: "Average ballast water volume per operation in cubic meters"
    - name: "total_ghg_emission_mt_co2e"
      expr: SUM(CAST(ghg_emission_mt_co2e AS DOUBLE))
      comment: "Total greenhouse gas emissions in metric tonnes CO2 equivalent"
    - name: "avg_ghg_emission_mt_co2e"
      expr: AVG(CAST(ghg_emission_mt_co2e AS DOUBLE))
      comment: "Average greenhouse gas emissions per operation in metric tonnes CO2 equivalent"
    - name: "avg_nox_emission_g_kwh"
      expr: AVG(CAST(nox_emission_g_kwh AS DOUBLE))
      comment: "Average NOx emissions in grams per kilowatt-hour"
    - name: "avg_sox_emission_ppm"
      expr: AVG(CAST(sox_emission_ppm AS DOUBLE))
      comment: "Average SOx emissions in parts per million"
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN non_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL operations with non-compliance detected"
    - name: "psc_inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN psc_inspection_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL operations subject to PSC inspection"
    - name: "psc_deficiency_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN psc_deficiency_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PSC inspections where deficiencies were noted"
    - name: "unique_vessels_serviced"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels receiving MARPOL services"
$$;