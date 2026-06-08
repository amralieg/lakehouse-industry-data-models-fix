-- Metric views for domain: marine | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_pilotage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for pilotage operations covering assignment throughput, service charge revenue, passage efficiency, safety compliance, and incident rates. Used by Port Marine Superintendent and CFO to steer pilotage resource allocation, tariff review, and safety governance."
  source: "`shipping_ports_ecm`.`marine`.`pilotage_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current lifecycle status of the pilotage assignment (e.g. COMPLETED, CANCELLED, IN_PROGRESS) — used to filter active vs. closed assignments."
    - name: "service_type"
      expr: service_type
      comment: "Type of pilotage service rendered (e.g. INBOUND, OUTBOUND, SHIFTING) — key dimension for workload and revenue analysis."
    - name: "pilot_licence_class"
      expr: pilot_licence_class
      comment: "Licence class of the assigned pilot — used to analyse assignment distribution across competency tiers."
    - name: "boarding_method"
      expr: boarding_method
      comment: "Method used for pilot boarding (e.g. LADDER, HELICOPTER) — relevant for safety and operational cost analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing lifecycle status of the assignment — used to track revenue recognition and outstanding charges."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the service charge is denominated — required for multi-currency revenue reporting."
    - name: "scheduled_boarding_date"
      expr: DATE_TRUNC('day', scheduled_boarding_timestamp)
      comment: "Calendar day of scheduled pilot boarding — primary time dimension for daily throughput trending."
    - name: "scheduled_boarding_month"
      expr: DATE_TRUNC('month', scheduled_boarding_timestamp)
      comment: "Calendar month of scheduled pilot boarding — used for monthly KPI roll-ups and trend analysis."
    - name: "tug_required_flag"
      expr: tug_required
      comment: "Indicates whether tug assistance was required for this pilotage — used to correlate tug demand with pilotage volume."
    - name: "isps_compliance_verified_flag"
      expr: isps_compliance_verified
      comment: "Whether ISPS security compliance was verified during the assignment — key regulatory dimension."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported during this assignment — used to segment safe vs. incident-affected assignments."
    - name: "deviation_from_passage_plan_flag"
      expr: deviation_from_passage_plan
      comment: "Whether the pilot deviated from the approved passage plan — used for safety and compliance monitoring."
  measures:
    - name: "total_pilotage_assignments"
      expr: COUNT(1)
      comment: "Total number of pilotage assignments — baseline throughput KPI used to assess port traffic volume and pilot workload."
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed pilotage assignments — measures operational delivery performance."
    - name: "cancelled_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled pilotage assignments — elevated cancellation rates signal scheduling or weather-related disruption."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total pilotage service charge revenue — primary revenue KPI for the marine pilotage business unit."
    - name: "avg_service_charge_per_assignment"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average pilotage service charge per assignment — used for tariff benchmarking and revenue yield analysis."
    - name: "total_passage_distance_nm"
      expr: SUM(CAST(passage_distance_nm AS DOUBLE))
      comment: "Total nautical miles covered across all pilotage assignments — proxy for operational intensity and fuel/resource consumption."
    - name: "avg_passage_distance_nm"
      expr: AVG(CAST(passage_distance_nm AS DOUBLE))
      comment: "Average passage distance per assignment in nautical miles — used to benchmark route complexity and pilot workload."
    - name: "avg_speed_over_ground_knots"
      expr: AVG(CAST(speed_over_ground_avg_knots AS DOUBLE))
      comment: "Average speed over ground across pilotage assignments — used to assess passage efficiency and compliance with speed limits."
    - name: "avg_min_ukc_recorded_m"
      expr: AVG(CAST(min_ukc_recorded_m AS DOUBLE))
      comment: "Average minimum under-keel clearance recorded during pilotage — critical safety KPI; low values indicate grounding risk."
    - name: "incident_reported_count"
      expr: COUNT(CASE WHEN incident_reported = TRUE THEN 1 END)
      comment: "Number of pilotage assignments with a reported safety incident — key safety governance metric for the Port Marine Superintendent."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments resulting in a reported incident — safety rate KPI used in regulatory and board reporting."
    - name: "deviation_from_passage_plan_count"
      expr: COUNT(CASE WHEN deviation_from_passage_plan = TRUE THEN 1 END)
      comment: "Number of assignments where the pilot deviated from the approved passage plan — compliance KPI for passage plan adherence."
    - name: "passage_plan_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_from_passage_plan = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with a passage plan deviation — used to identify systemic route or planning issues."
    - name: "distinct_pilots_deployed"
      expr: COUNT(DISTINCT pilot_id)
      comment: "Number of unique pilots deployed — used for workforce utilisation and rostering analysis."
    - name: "distinct_vessels_piloted"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels receiving pilotage services — measures breadth of port traffic served."
    - name: "tug_assisted_assignments"
      expr: COUNT(CASE WHEN tug_required = TRUE THEN 1 END)
      comment: "Number of pilotage assignments requiring tug assistance — used to forecast tug demand and associated costs."
    - name: "tug_assist_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tug_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilotage assignments requiring tug assistance — informs tug fleet sizing and operational planning."
    - name: "isps_non_compliance_count"
      expr: COUNT(CASE WHEN isps_compliance_verified = FALSE THEN 1 END)
      comment: "Number of assignments where ISPS compliance was not verified — regulatory risk KPI for port security governance."
    - name: "revenue_per_nautical_mile"
      expr: ROUND(SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(passage_distance_nm AS DOUBLE)), 0), 2)
      comment: "Pilotage revenue earned per nautical mile of passage — yield efficiency KPI used in tariff and route profitability analysis."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_towage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for towage services covering order throughput, revenue, tug utilisation, safety observations, and service outcomes. Used by the Harbour Master, Towage Manager, and CFO to manage tug fleet performance and towage revenue."
  source: "`shipping_ports_ecm`.`marine`.`towage_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the towage order (e.g. COMPLETED, CANCELLED, IN_PROGRESS) — primary filter for operational reporting."
    - name: "towage_type"
      expr: towage_type
      comment: "Type of towage service (e.g. HARBOUR, COASTAL, EMERGENCY) — used to segment revenue and workload by service category."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing lifecycle status of the towage order — used to track revenue recognition and unbilled services."
    - name: "service_outcome"
      expr: service_outcome
      comment: "Outcome of the towage service (e.g. SUCCESSFUL, ABORTED, PARTIAL) — used to measure service delivery quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the towage charge — required for multi-currency financial reporting."
    - name: "port_code"
      expr: port_code
      comment: "Port where the towage service was rendered — used for port-level performance benchmarking."
    - name: "imdg_hazmat_flag"
      expr: imdg_hazmat_flag
      comment: "Whether the towage involved IMDG hazardous materials — used for risk-weighted operational analysis."
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Whether a safety observation was raised during the towage — used to track safety culture and near-miss reporting."
    - name: "scheduled_commencement_date"
      expr: DATE_TRUNC('day', scheduled_commencement)
      comment: "Calendar day of scheduled towage commencement — primary time dimension for daily throughput analysis."
    - name: "scheduled_commencement_month"
      expr: DATE_TRUNC('month', scheduled_commencement)
      comment: "Calendar month of scheduled towage commencement — used for monthly revenue and volume trending."
  measures:
    - name: "total_towage_orders"
      expr: COUNT(1)
      comment: "Total number of towage orders — baseline throughput KPI for tug fleet demand and port traffic intensity."
    - name: "completed_towage_orders"
      expr: COUNT(CASE WHEN order_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed towage orders — measures towage service delivery performance."
    - name: "aborted_towage_orders"
      expr: COUNT(CASE WHEN service_outcome = 'ABORTED' THEN 1 END)
      comment: "Count of aborted towage operations — elevated abort rates signal operational or weather-related risk."
    - name: "total_towage_revenue"
      expr: SUM(CAST(towage_charge_amount AS DOUBLE))
      comment: "Total towage charge revenue — primary financial KPI for the towage business unit."
    - name: "avg_towage_charge_per_order"
      expr: AVG(CAST(towage_charge_amount AS DOUBLE))
      comment: "Average towage charge per order — used for tariff benchmarking and revenue yield analysis."
    - name: "avg_min_bollard_pull_required_tonnes"
      expr: AVG(CAST(min_bollard_pull_tonnes AS DOUBLE))
      comment: "Average minimum bollard pull required across towage orders — used for tug fleet capability planning and procurement decisions."
    - name: "max_bollard_pull_required_tonnes"
      expr: MAX(CAST(min_bollard_pull_tonnes AS DOUBLE))
      comment: "Maximum bollard pull requirement observed — used to ensure fleet capability covers peak demand scenarios."
    - name: "avg_current_speed_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed at time of towage — used to correlate environmental conditions with operational difficulty and safety outcomes."
    - name: "hazmat_towage_orders"
      expr: COUNT(CASE WHEN imdg_hazmat_flag = TRUE THEN 1 END)
      comment: "Number of towage orders involving IMDG hazardous materials — risk exposure KPI for port safety and insurance reporting."
    - name: "hazmat_towage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN imdg_hazmat_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders involving hazardous materials — used to assess risk profile of towage operations."
    - name: "safety_observation_count"
      expr: COUNT(CASE WHEN safety_observation_flag = TRUE THEN 1 END)
      comment: "Number of towage orders with a safety observation raised — safety culture KPI used in HSE governance reporting."
    - name: "safety_observation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_observation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage orders with a safety observation — used to benchmark safety reporting culture across periods."
    - name: "distinct_vessels_towed"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels receiving towage services — measures breadth of port traffic served by the tug fleet."
    - name: "abort_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_outcome = 'ABORTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of towage operations that were aborted — operational reliability KPI; high abort rates trigger fleet or process review."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_mooring_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for mooring operations covering throughput, revenue, safety incidents, compliance, and gang utilisation. Used by the Mooring Superintendent and Finance team to manage mooring service quality and cost recovery."
  source: "`shipping_ports_ecm`.`marine`.`mooring_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Lifecycle status of the mooring operation (e.g. COMPLETED, IN_PROGRESS, CANCELLED) — primary filter for operational reporting."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of mooring operation (e.g. BERTHING, UNBERTHING, SHIFTING) — used to segment workload and revenue by service type."
    - name: "vessel_movement_type"
      expr: vessel_movement_type
      comment: "Type of vessel movement associated with the mooring (e.g. ARRIVAL, DEPARTURE, SHIFT) — used for traffic pattern analysis."
    - name: "mooring_location_type"
      expr: mooring_location_type
      comment: "Location type where mooring was performed (e.g. BERTH, BUOY, ANCHORAGE) — used to analyse workload distribution across port infrastructure."
    - name: "line_material_type"
      expr: line_material_type
      comment: "Material type of mooring lines used — relevant for equipment procurement and SWL compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the mooring charge — required for multi-currency financial reporting."
    - name: "billable_flag"
      expr: billable
      comment: "Whether the mooring operation is billable — used to identify revenue leakage from non-billed operations."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported during the mooring — used to segment safe vs. incident-affected operations."
    - name: "irregularity_observed_flag"
      expr: irregularity_observed
      comment: "Whether an operational irregularity was observed — used for quality assurance and corrective action tracking."
    - name: "swl_compliant_flag"
      expr: swl_compliant
      comment: "Whether the mooring operation was compliant with Safe Working Load limits — critical safety compliance dimension."
    - name: "towage_assist_used_flag"
      expr: towage_assist_used
      comment: "Whether tug assistance was used during mooring — used to correlate tug demand with mooring complexity."
    - name: "commencement_date"
      expr: DATE_TRUNC('day', commencement_timestamp)
      comment: "Calendar day of mooring commencement — primary time dimension for daily throughput trending."
    - name: "commencement_month"
      expr: DATE_TRUNC('month', commencement_timestamp)
      comment: "Calendar month of mooring commencement — used for monthly KPI roll-ups."
  measures:
    - name: "total_mooring_operations"
      expr: COUNT(1)
      comment: "Total number of mooring operations — baseline throughput KPI for berth utilisation and gang workload planning."
    - name: "completed_mooring_operations"
      expr: COUNT(CASE WHEN operation_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed mooring operations — measures service delivery performance."
    - name: "total_mooring_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total mooring charge revenue — primary financial KPI for the mooring services business unit."
    - name: "avg_mooring_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average mooring charge per operation — used for tariff benchmarking and revenue yield analysis."
    - name: "avg_current_speed_at_mooring_knots"
      expr: AVG(CAST(current_speed_knots AS DOUBLE))
      comment: "Average current speed during mooring operations — used to assess environmental difficulty and correlate with incident rates."
    - name: "incident_reported_count"
      expr: COUNT(CASE WHEN incident_reported = TRUE THEN 1 END)
      comment: "Number of mooring operations with a reported safety incident — key safety governance KPI."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations resulting in a reported incident — safety rate KPI for HSE governance and regulatory reporting."
    - name: "swl_non_compliance_count"
      expr: COUNT(CASE WHEN swl_compliant = FALSE THEN 1 END)
      comment: "Number of mooring operations not compliant with Safe Working Load limits — critical safety and liability KPI."
    - name: "swl_non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN swl_compliant = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations with SWL non-compliance — used to trigger corrective action and training interventions."
    - name: "irregularity_count"
      expr: COUNT(CASE WHEN irregularity_observed = TRUE THEN 1 END)
      comment: "Number of mooring operations with an observed irregularity — quality assurance KPI for operational standards."
    - name: "billable_operations_count"
      expr: COUNT(CASE WHEN billable = TRUE THEN 1 END)
      comment: "Count of billable mooring operations — used to track revenue-generating activity vs. total throughput."
    - name: "non_billable_operations_count"
      expr: COUNT(CASE WHEN billable = FALSE THEN 1 END)
      comment: "Count of non-billable mooring operations — used to identify revenue leakage and cost absorption."
    - name: "billable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations that are billable — revenue capture efficiency KPI for the mooring business unit."
    - name: "towage_assist_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN towage_assist_used = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mooring operations requiring tug assistance — used to forecast tug demand and associated costs."
    - name: "distinct_vessels_moored"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels moored — measures breadth of port traffic served by mooring gangs."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety, environmental, and regulatory KPIs for marine incidents covering incident frequency, damage costs, pollution events, investigation status, and regulatory notifications. Used by the Port Safety Manager, Harbour Master, and Board to govern safety performance and regulatory compliance."
  source: "`shipping_ports_ecm`.`marine`.`marine_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident type (e.g. COLLISION, GROUNDING, FIRE) — primary dimension for safety trend analysis."
    - name: "incident_category"
      expr: incident_category
      comment: "Broader category of the incident (e.g. NAVIGATIONAL, ENVIRONMENTAL, SECURITY) — used for portfolio-level safety reporting."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the incident investigation (e.g. OPEN, CLOSED, PENDING) — used to track investigation backlog and closure rates."
    - name: "marpol_classification"
      expr: marpol_classification
      comment: "MARPOL annex classification of the incident — used for environmental regulatory reporting."
    - name: "solas_classification"
      expr: solas_classification
      comment: "SOLAS classification of the incident — used for safety regulatory reporting and flag state notifications."
    - name: "pollution_occurred_flag"
      expr: pollution_occurred
      comment: "Whether pollution occurred as a result of the incident — used to segment environmental incidents for MARPOL reporting."
    - name: "human_factor_involved_flag"
      expr: human_factor_involved
      comment: "Whether a human factor contributed to the incident — used to target training and procedural interventions."
    - name: "isps_security_implication_flag"
      expr: isps_security_implication
      comment: "Whether the incident has ISPS security implications — used for port security governance and ISPS reporting."
    - name: "amsa_notified_flag"
      expr: amsa_notified
      comment: "Whether AMSA was notified of the incident — used to track regulatory notification compliance."
    - name: "psc_notified_flag"
      expr: psc_notified
      comment: "Whether Port State Control was notified — used to track PSC notification compliance."
    - name: "incident_date"
      expr: DATE_TRUNC('day', datetime)
      comment: "Calendar day of the incident — primary time dimension for daily and weekly safety trend analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('month', datetime)
      comment: "Calendar month of the incident — used for monthly safety KPI roll-ups and board reporting."
    - name: "corrective_actions_completed_flag"
      expr: corrective_actions_completed
      comment: "Whether corrective actions have been completed — used to track safety action closure rates."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of marine incidents — primary safety frequency KPI used in board and regulatory reporting."
    - name: "total_estimated_damage_cost_usd"
      expr: SUM(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Total estimated damage cost across all incidents in USD — financial impact KPI for insurance, P&I club, and board reporting."
    - name: "avg_estimated_damage_cost_usd"
      expr: AVG(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Average estimated damage cost per incident — used to benchmark incident severity and set insurance reserve levels."
    - name: "max_estimated_damage_cost_usd"
      expr: MAX(CAST(estimated_damage_cost_usd AS DOUBLE))
      comment: "Maximum single-incident damage cost — used to identify tail-risk events for insurance and risk management review."
    - name: "total_pollution_volume_litres"
      expr: SUM(CAST(pollution_volume_litres AS DOUBLE))
      comment: "Total volume of pollutants discharged across all incidents in litres — environmental impact KPI for MARPOL and regulatory reporting."
    - name: "pollution_incident_count"
      expr: COUNT(CASE WHEN pollution_occurred = TRUE THEN 1 END)
      comment: "Number of incidents involving pollution — environmental safety KPI for MARPOL compliance and port environmental governance."
    - name: "pollution_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pollution_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents involving pollution — environmental risk rate KPI used in sustainability and regulatory reporting."
    - name: "human_factor_incident_count"
      expr: COUNT(CASE WHEN human_factor_involved = TRUE THEN 1 END)
      comment: "Number of incidents where human factors contributed — used to target crew training and procedural improvement programmes."
    - name: "human_factor_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN human_factor_involved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents attributable to human factors — used to benchmark safety culture and training effectiveness."
    - name: "open_investigations_count"
      expr: COUNT(CASE WHEN investigation_status = 'OPEN' THEN 1 END)
      comment: "Number of incidents with open investigations — backlog KPI for the safety investigation team; high values indicate resource constraints."
    - name: "corrective_actions_completed_count"
      expr: COUNT(CASE WHEN corrective_actions_completed = TRUE THEN 1 END)
      comment: "Number of incidents where corrective actions have been completed — safety action closure KPI for governance reporting."
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_actions_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with completed corrective actions — safety governance KPI measuring follow-through on safety findings."
    - name: "isps_security_implication_count"
      expr: COUNT(CASE WHEN isps_security_implication = TRUE THEN 1 END)
      comment: "Number of incidents with ISPS security implications — port security risk KPI for the Port Facility Security Officer."
    - name: "distinct_vessels_involved"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels involved in incidents — used to identify repeat-offender vessels for targeted PSC inspection."
    - name: "avg_location_latitude"
      expr: AVG(CAST(location_latitude AS DOUBLE))
      comment: "Average latitude of incident locations — used as a spatial proxy to identify geographic hotspots for incident clustering analysis."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_marpol_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and waste management KPIs for MARPOL operations covering waste reception volumes, GHG and NOx/SOx emissions, non-compliance rates, and PSC inspection outcomes. Used by the Environmental Officer, Port Authority, and Compliance team for MARPOL regulatory reporting and sustainability governance."
  source: "`shipping_ports_ecm`.`marine`.`marpol_operation`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of MARPOL operation (e.g. WASTE_RECEPTION, BALLAST_WATER_TREATMENT, OIL_DISCHARGE) — primary dimension for environmental workload analysis."
    - name: "operation_status"
      expr: operation_status
      comment: "Lifecycle status of the MARPOL operation — used to filter completed vs. in-progress environmental operations."
    - name: "marpol_annex_code"
      expr: marpol_annex_code
      comment: "MARPOL annex under which the operation is classified (e.g. ANNEX_I, ANNEX_V) — regulatory dimension for annex-specific compliance reporting."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste received or managed (e.g. OILY_WASTE, SEWAGE, GARBAGE) — used for waste stream analysis and facility planning."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal — used to assess environmental best-practice compliance."
    - name: "non_compliance_flag"
      expr: non_compliance_flag
      comment: "Whether the operation involved a MARPOL non-compliance event — primary compliance risk dimension."
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Whether a PSC inspection was conducted in relation to this operation — used to track regulatory inspection exposure."
    - name: "psc_deficiency_noted_flag"
      expr: psc_deficiency_noted
      comment: "Whether a PSC deficiency was noted — used to track PSC deficiency rates and remediation actions."
    - name: "quantity_unit"
      expr: quantity_unit
      comment: "Unit of measurement for the waste or substance quantity — required for correct aggregation and reporting."
    - name: "operation_date"
      expr: DATE_TRUNC('day', operation_timestamp)
      comment: "Calendar day of the MARPOL operation — primary time dimension for daily environmental activity trending."
    - name: "operation_month"
      expr: DATE_TRUNC('month', operation_timestamp)
      comment: "Calendar month of the MARPOL operation — used for monthly environmental KPI roll-ups and regulatory submissions."
    - name: "ballast_water_treatment_method"
      expr: ballast_water_treatment_method
      comment: "Method used for ballast water treatment — used to assess compliance with ballast water management convention."
  measures:
    - name: "total_marpol_operations"
      expr: COUNT(1)
      comment: "Total number of MARPOL operations — baseline environmental activity KPI for port environmental management reporting."
    - name: "total_waste_quantity_received"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste received across all MARPOL operations — primary environmental throughput KPI for waste reception facility planning."
    - name: "avg_waste_quantity_per_operation"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average waste quantity per MARPOL operation — used to benchmark waste generation per vessel call and plan reception capacity."
    - name: "total_ballast_water_volume_m3"
      expr: SUM(CAST(ballast_water_volume_m3 AS DOUBLE))
      comment: "Total ballast water volume managed in cubic metres — environmental compliance KPI for ballast water management convention reporting."
    - name: "total_ghg_emissions_mt_co2e"
      expr: SUM(CAST(ghg_emission_mt_co2e AS DOUBLE))
      comment: "Total GHG emissions in metric tonnes CO2 equivalent — primary sustainability KPI for port carbon footprint and IMO DCS reporting."
    - name: "avg_ghg_emissions_per_operation_mt_co2e"
      expr: AVG(CAST(ghg_emission_mt_co2e AS DOUBLE))
      comment: "Average GHG emissions per MARPOL operation — used to benchmark emission intensity and track decarbonisation progress."
    - name: "total_nox_emissions_g_kwh"
      expr: SUM(CAST(nox_emission_g_kwh AS DOUBLE))
      comment: "Total NOx emissions in g/kWh — air quality KPI for MARPOL Annex VI compliance and port environmental reporting."
    - name: "avg_sox_emission_ppm"
      expr: AVG(CAST(sox_emission_ppm AS DOUBLE))
      comment: "Average SOx emission concentration in PPM — used to monitor compliance with MARPOL Annex VI sulphur cap requirements."
    - name: "non_compliance_count"
      expr: COUNT(CASE WHEN non_compliance_flag = TRUE THEN 1 END)
      comment: "Number of MARPOL operations with a non-compliance event — regulatory risk KPI for the Environmental Officer and Port Authority."
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN non_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL operations with non-compliance — environmental compliance rate KPI for regulatory and board reporting."
    - name: "psc_deficiency_count"
      expr: COUNT(CASE WHEN psc_deficiency_noted = TRUE THEN 1 END)
      comment: "Number of MARPOL operations where a PSC deficiency was noted — regulatory inspection outcome KPI."
    - name: "psc_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN psc_deficiency_noted = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN psc_inspection_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of PSC-inspected MARPOL operations resulting in a deficiency — used to assess PSC inspection risk and remediation effectiveness."
    - name: "distinct_vessels_with_marpol_operations"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels with MARPOL operations — used to measure environmental service coverage across port calls."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_tug_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tug fleet utilisation and operational performance KPIs covering bollard pull deployment, fuel consumption, assignment outcomes, safety observations, and incident rates. Used by the Towage Manager and Fleet Operations team to optimise tug deployment and manage operational costs."
  source: "`shipping_ports_ecm`.`marine`.`tug_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Lifecycle status of the tug assignment (e.g. COMPLETED, CANCELLED, ABORTED) — primary filter for operational reporting."
    - name: "assignment_outcome"
      expr: assignment_outcome
      comment: "Outcome of the tug assignment (e.g. SUCCESSFUL, ABORTED, PARTIAL) — used to measure tug deployment effectiveness."
    - name: "assigned_position"
      expr: assigned_position
      comment: "Position of the tug during the assignment (e.g. BOW, STERN, BREAST) — used to analyse tug positioning patterns and fleet configuration."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the tug — used for emissions analysis and fuel cost allocation."
    - name: "tow_line_type"
      expr: tow_line_type
      comment: "Type of tow line used — relevant for equipment maintenance and SWL compliance analysis."
    - name: "billable_flag"
      expr: billable
      comment: "Whether the tug assignment is billable — used to identify revenue leakage from non-billed deployments."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported during the assignment — used to segment safe vs. incident-affected deployments."
    - name: "safety_observation_flag"
      expr: safety_observation_flag
      comment: "Whether a safety observation was raised — used to track safety culture and near-miss reporting."
    - name: "engagement_date"
      expr: DATE_TRUNC('day', engagement_timestamp)
      comment: "Calendar day of tug engagement — primary time dimension for daily utilisation trending."
    - name: "engagement_month"
      expr: DATE_TRUNC('month', engagement_timestamp)
      comment: "Calendar month of tug engagement — used for monthly fleet utilisation and cost roll-ups."
  measures:
    - name: "total_tug_assignments"
      expr: COUNT(1)
      comment: "Total number of tug assignments — baseline fleet utilisation KPI for tug demand planning and capacity management."
    - name: "completed_tug_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed tug assignments — measures tug fleet delivery performance."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across all tug assignments in litres — primary operational cost KPI for tug fleet management."
    - name: "avg_fuel_consumed_per_assignment_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumption per tug assignment — used to benchmark fuel efficiency and identify high-consumption outliers."
    - name: "total_bollard_pull_applied_tonnes"
      expr: SUM(CAST(bollard_pull_applied_tonnes AS DOUBLE))
      comment: "Total bollard pull applied across all assignments in tonnes — measures aggregate tug force deployed; used for fleet capability reporting."
    - name: "avg_bollard_pull_applied_tonnes"
      expr: AVG(CAST(bollard_pull_applied_tonnes AS DOUBLE))
      comment: "Average bollard pull applied per assignment — used to assess typical operational demand vs. fleet capability."
    - name: "max_bollard_pull_applied_tonnes"
      expr: MAX(CAST(max_bollard_pull_applied_tonnes AS DOUBLE))
      comment: "Maximum bollard pull applied in a single assignment — used to validate fleet capability against peak demand scenarios."
    - name: "avg_tow_line_length_m"
      expr: AVG(CAST(tow_line_length_m AS DOUBLE))
      comment: "Average tow line length deployed in metres — used to assess operational complexity and equipment utilisation."
    - name: "incident_reported_count"
      expr: COUNT(CASE WHEN incident_reported = TRUE THEN 1 END)
      comment: "Number of tug assignments with a reported safety incident — key safety governance KPI for the Towage Manager."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments resulting in a reported incident — safety rate KPI for HSE governance and insurance reporting."
    - name: "safety_observation_count"
      expr: COUNT(CASE WHEN safety_observation_flag = TRUE THEN 1 END)
      comment: "Number of tug assignments with a safety observation raised — safety culture KPI for near-miss reporting analysis."
    - name: "billable_assignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tug assignments that are billable — revenue capture efficiency KPI; low rates indicate cost absorption or billing process gaps."
    - name: "distinct_tugs_deployed"
      expr: COUNT(DISTINCT tug_id)
      comment: "Number of unique tugs deployed — used to measure active fleet utilisation and identify idle assets."
    - name: "fuel_efficiency_per_bollard_pull_tonne"
      expr: ROUND(SUM(CAST(fuel_consumed_litres AS DOUBLE)) / NULLIF(SUM(CAST(bollard_pull_applied_tonnes AS DOUBLE)), 0), 2)
      comment: "Fuel consumed per tonne of bollard pull applied — operational efficiency KPI for tug fleet decarbonisation and cost management."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_survey_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey operations KPIs covering appointment throughput, compliance outcomes, deficiency rates, PSC inspection triggers, and cargo survey volumes. Used by the Port Surveyor Manager, Compliance team, and P&I clubs to govern survey quality and regulatory compliance."
  source: "`shipping_ports_ecm`.`marine`.`survey_appointment`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey conducted (e.g. CONDITION, DRAUGHT, CARGO, MARPOL) — primary dimension for survey workload and compliance analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Lifecycle status of the survey appointment (e.g. COMPLETED, CANCELLED, IN_PROGRESS) — used to filter active vs. closed appointments."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Outcome of the survey (e.g. PASSED, FAILED, CONDITIONAL) — primary quality dimension for survey result analysis."
    - name: "survey_location_type"
      expr: survey_location_type
      comment: "Location type where the survey was conducted (e.g. BERTH, ANCHORAGE, VESSEL) — used for operational logistics analysis."
    - name: "surveying_organisation"
      expr: surveying_organisation
      comment: "Organisation conducting the survey — used to benchmark performance across surveying bodies."
    - name: "isps_compliance_flag"
      expr: isps_compliance_flag
      comment: "Whether the survey confirmed ISPS compliance — used for port security governance reporting."
    - name: "marpol_compliance_flag"
      expr: marpol_compliance_flag
      comment: "Whether the survey confirmed MARPOL compliance — used for environmental regulatory reporting."
    - name: "solas_compliance_flag"
      expr: solas_compliance_flag
      comment: "Whether the survey confirmed SOLAS compliance — used for safety regulatory reporting."
    - name: "psc_inspection_triggered_flag"
      expr: psc_inspection_triggered
      comment: "Whether the survey triggered a PSC inspection — used to track PSC referral rates from survey findings."
    - name: "pi_club_notified_flag"
      expr: pi_club_notified
      comment: "Whether the P&I club was notified following the survey — used to track P&I notification compliance."
    - name: "scheduled_commencement_date"
      expr: DATE_TRUNC('day', scheduled_commencement)
      comment: "Calendar day of scheduled survey commencement — primary time dimension for daily survey throughput trending."
    - name: "scheduled_commencement_month"
      expr: DATE_TRUNC('month', scheduled_commencement)
      comment: "Calendar month of scheduled survey commencement — used for monthly KPI roll-ups."
  measures:
    - name: "total_survey_appointments"
      expr: COUNT(1)
      comment: "Total number of survey appointments — baseline throughput KPI for surveyor workload and capacity planning."
    - name: "completed_survey_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of completed survey appointments — measures survey service delivery performance."
    - name: "total_cargo_quantity_surveyed_mt"
      expr: SUM(CAST(cargo_quantity_mt AS DOUBLE))
      comment: "Total cargo quantity surveyed in metric tonnes — measures the volume of cargo subject to survey; used for capacity and revenue planning."
    - name: "avg_cargo_quantity_per_survey_mt"
      expr: AVG(CAST(cargo_quantity_mt AS DOUBLE))
      comment: "Average cargo quantity per survey appointment in metric tonnes — used to benchmark survey scope and resource requirements."
    - name: "avg_draught_aft_m"
      expr: AVG(CAST(draught_aft_m AS DOUBLE))
      comment: "Average aft draught recorded during surveys — used to assess vessel loading conditions and UKC compliance."
    - name: "avg_draught_forward_m"
      expr: AVG(CAST(draught_forward_m AS DOUBLE))
      comment: "Average forward draught recorded during surveys — used alongside aft draught to assess trim and loading compliance."
    - name: "avg_draught_midship_m"
      expr: AVG(CAST(draught_midship_m AS DOUBLE))
      comment: "Average midship draught recorded during surveys — used for comprehensive vessel loading and stability assessment."
    - name: "psc_inspection_triggered_count"
      expr: COUNT(CASE WHEN psc_inspection_triggered = TRUE THEN 1 END)
      comment: "Number of surveys that triggered a PSC inspection — regulatory risk KPI; high counts indicate systemic compliance issues."
    - name: "psc_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN psc_inspection_triggered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys triggering a PSC inspection — compliance risk rate KPI for port regulatory governance."
    - name: "marpol_non_compliance_count"
      expr: COUNT(CASE WHEN marpol_compliance_flag = FALSE THEN 1 END)
      comment: "Number of surveys where MARPOL non-compliance was identified — environmental compliance KPI for the Environmental Officer."
    - name: "solas_non_compliance_count"
      expr: COUNT(CASE WHEN solas_compliance_flag = FALSE THEN 1 END)
      comment: "Number of surveys where SOLAS non-compliance was identified — safety regulatory KPI for the Port Safety Manager."
    - name: "isps_non_compliance_count"
      expr: COUNT(CASE WHEN isps_compliance_flag = FALSE THEN 1 END)
      comment: "Number of surveys where ISPS non-compliance was identified — port security governance KPI."
    - name: "distinct_surveyors_deployed"
      expr: COUNT(DISTINCT surveyor_id)
      comment: "Number of unique surveyors deployed — used for workforce utilisation and accreditation coverage analysis."
    - name: "distinct_vessels_surveyed"
      expr: COUNT(DISTINCT vessel_id)
      comment: "Number of unique vessels surveyed — measures breadth of compliance coverage across port calls."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_pilot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilot workforce KPIs covering fleet size, licence compliance, medical certification status, competency distribution, and operational readiness. Used by the Harbour Master and HR to govern pilot workforce capacity, regulatory compliance, and succession planning."
  source: "`shipping_ports_ecm`.`marine`.`pilot`"
  dimensions:
    - name: "competency_class"
      expr: competency_class
      comment: "Competency class of the pilot — used to analyse workforce distribution across qualification tiers."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type of the pilot (e.g. PERMANENT, CONTRACT, CASUAL) — used for workforce planning and cost analysis."
    - name: "duty_status"
      expr: duty_status
      comment: "Current duty status of the pilot (e.g. ON_DUTY, OFF_DUTY, LEAVE) — used for real-time operational readiness monitoring."
    - name: "licence_status"
      expr: licence_status
      comment: "Current status of the pilot licence (e.g. ACTIVE, EXPIRED, SUSPENDED) — critical compliance dimension for regulatory reporting."
    - name: "medical_cert_status"
      expr: medical_cert_status
      comment: "Current status of the pilot medical certificate — used to ensure all active pilots meet medical fitness requirements."
    - name: "night_pilotage_authorised_flag"
      expr: night_pilotage_authorised
      comment: "Whether the pilot is authorised for night pilotage — used to assess after-hours operational capacity."
    - name: "deep_sea_pilot_endorsement_flag"
      expr: deep_sea_pilot_endorsement
      comment: "Whether the pilot holds a deep-sea endorsement — used to assess capability for deep-sea pilotage assignments."
    - name: "radar_arpa_endorsement_flag"
      expr: radar_arpa_endorsement
      comment: "Whether the pilot holds a RADAR/ARPA endorsement — used to assess navigational technology competency."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the pilot licence — used for regulatory jurisdiction analysis."
    - name: "licence_expiry_month"
      expr: DATE_TRUNC('month', licence_expiry_date)
      comment: "Month of pilot licence expiry — used to forecast upcoming licence renewals and prevent lapses."
    - name: "medical_cert_expiry_month"
      expr: DATE_TRUNC('month', medical_cert_expiry_date)
      comment: "Month of medical certificate expiry — used to forecast upcoming medical renewals and ensure continuous fitness compliance."
  measures:
    - name: "total_pilots"
      expr: COUNT(1)
      comment: "Total number of pilots in the workforce — baseline headcount KPI for capacity planning and regulatory minimum staffing compliance."
    - name: "active_licence_pilots"
      expr: COUNT(CASE WHEN licence_status = 'ACTIVE' THEN 1 END)
      comment: "Number of pilots with an active licence — operational readiness KPI; must meet minimum regulatory staffing thresholds."
    - name: "expired_licence_pilots"
      expr: COUNT(CASE WHEN licence_status = 'EXPIRED' THEN 1 END)
      comment: "Number of pilots with an expired licence — compliance risk KPI; any non-zero value requires immediate remediation."
    - name: "licence_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN licence_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with an active licence — workforce compliance rate KPI for regulatory reporting and audit."
    - name: "valid_medical_cert_pilots"
      expr: COUNT(CASE WHEN medical_cert_status = 'VALID' THEN 1 END)
      comment: "Number of pilots with a valid medical certificate — fitness-for-duty compliance KPI."
    - name: "medical_cert_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_cert_status = 'VALID' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots with a valid medical certificate — medical fitness compliance rate KPI for regulatory and HR reporting."
    - name: "night_pilotage_authorised_count"
      expr: COUNT(CASE WHEN night_pilotage_authorised = TRUE THEN 1 END)
      comment: "Number of pilots authorised for night pilotage — operational capacity KPI for after-hours port operations planning."
    - name: "night_pilotage_authorisation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN night_pilotage_authorised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pilots authorised for night pilotage — used to assess 24/7 operational coverage capability."
    - name: "deep_sea_endorsed_pilots"
      expr: COUNT(CASE WHEN deep_sea_pilot_endorsement = TRUE THEN 1 END)
      comment: "Number of pilots with a deep-sea endorsement — specialist capability KPI for deep-sea pilotage service capacity."
    - name: "avg_max_dwt_authorised_mt"
      expr: AVG(CAST(max_dwt_mt AS DOUBLE))
      comment: "Average maximum DWT authorised across the pilot fleet — used to assess fleet capability against vessel size trends at the port."
    - name: "avg_max_loa_authorised_m"
      expr: AVG(CAST(max_loa_m AS DOUBLE))
      comment: "Average maximum LOA authorised across the pilot fleet — used to assess pilot fleet capability for handling larger vessels."
    - name: "avg_max_grt_authorised"
      expr: AVG(CAST(max_grt AS DOUBLE))
      comment: "Average maximum GRT authorised across the pilot fleet — used for vessel size capability benchmarking."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_launch_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Launch dispatch operational and financial KPIs covering mission throughput, fuel consumption, service charges, safety compliance, and cargo transport. Used by the Marine Operations Manager and Finance team to manage launch fleet efficiency and cost recovery."
  source: "`shipping_ports_ecm`.`marine`.`launch_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Lifecycle status of the launch dispatch (e.g. COMPLETED, CANCELLED, IN_PROGRESS) — primary filter for operational reporting."
    - name: "dispatch_purpose"
      expr: dispatch_purpose
      comment: "Purpose of the launch dispatch (e.g. PILOT_TRANSFER, CREW_CHANGE, STORES_DELIVERY) — used to segment workload by mission type."
    - name: "dispatch_priority"
      expr: dispatch_priority
      comment: "Priority level of the dispatch (e.g. ROUTINE, URGENT, EMERGENCY) — used to analyse priority distribution and response capability."
    - name: "pilot_boarding_ground"
      expr: pilot_boarding_ground
      comment: "Pilot boarding ground served by the launch — used for route-level workload and cost analysis."
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of the launch dispatch — used for route analysis and fuel consumption benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the service charge — required for multi-currency financial reporting."
    - name: "night_operation_flag"
      expr: night_operation
      comment: "Whether the dispatch was a night operation — used to assess after-hours operational demand and associated risk."
    - name: "incident_reported_flag"
      expr: incident_reported
      comment: "Whether a safety incident was reported during the dispatch — used to segment safe vs. incident-affected missions."
    - name: "isps_clearance_verified_flag"
      expr: isps_clearance_verified
      comment: "Whether ISPS clearance was verified for the dispatch — used for port security compliance monitoring."
    - name: "marpol_compliance_checked_flag"
      expr: marpol_compliance_checked
      comment: "Whether MARPOL compliance was checked during the dispatch — used for environmental compliance monitoring."
    - name: "life_jackets_worn_flag"
      expr: life_jackets_worn
      comment: "Whether life jackets were worn during the dispatch — safety compliance KPI for launch operations."
    - name: "departure_date"
      expr: DATE_TRUNC('day', actual_departure_time)
      comment: "Calendar day of actual departure — primary time dimension for daily launch throughput trending."
    - name: "departure_month"
      expr: DATE_TRUNC('month', actual_departure_time)
      comment: "Calendar month of actual departure — used for monthly operational and financial KPI roll-ups."
  measures:
    - name: "total_launch_dispatches"
      expr: COUNT(1)
      comment: "Total number of launch dispatches — baseline throughput KPI for launch fleet demand and capacity planning."
    - name: "completed_dispatches"
      expr: COUNT(CASE WHEN dispatch_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed launch dispatches — measures launch service delivery performance."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total launch service charge revenue — primary financial KPI for the launch operations business unit."
    - name: "avg_service_charge_per_dispatch"
      expr: AVG(CAST(service_charge_amount AS DOUBLE))
      comment: "Average service charge per launch dispatch — used for tariff benchmarking and revenue yield analysis."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across all launch dispatches in litres — primary operational cost KPI for launch fleet management."
    - name: "avg_fuel_consumed_per_dispatch_litres"
      expr: AVG(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Average fuel consumption per launch dispatch — used to benchmark fuel efficiency and identify high-consumption routes."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight transported by launch in kilograms — used to assess cargo handling capacity and load compliance."
    - name: "avg_cargo_weight_per_dispatch_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per launch dispatch — used to benchmark load utilisation and plan capacity."
    - name: "incident_reported_count"
      expr: COUNT(CASE WHEN incident_reported = TRUE THEN 1 END)
      comment: "Number of launch dispatches with a reported safety incident — key safety governance KPI for launch operations."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of launch dispatches resulting in a reported incident — safety rate KPI for HSE governance."
    - name: "life_jacket_non_compliance_count"
      expr: COUNT(CASE WHEN life_jackets_worn = FALSE THEN 1 END)
      comment: "Number of dispatches where life jackets were not worn — critical safety compliance KPI; any non-zero value requires immediate intervention."
    - name: "night_operation_count"
      expr: COUNT(CASE WHEN night_operation = TRUE THEN 1 END)
      comment: "Number of night launch dispatches — used to assess after-hours operational demand and associated safety risk."
    - name: "night_operation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN night_operation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of launch dispatches conducted at night — used to assess after-hours risk exposure and staffing requirements."
    - name: "revenue_per_litre_fuel"
      expr: ROUND(SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(fuel_consumed_litres AS DOUBLE)), 0), 2)
      comment: "Launch service revenue earned per litre of fuel consumed — operational efficiency and yield KPI for launch fleet cost management."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_weather_tide_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental and operational constraint KPIs for weather and tide windows covering restriction rates, UKC availability, visibility, wave and wind conditions, and tidal variance. Used by the Harbour Master and VTS to manage port access decisions, vessel scheduling, and safety governance."
  source: "`shipping_ports_ecm`.`marine`.`weather_tide_window`"
  dimensions:
    - name: "service_window_status"
      expr: service_window_status
      comment: "Status of the service window (e.g. OPEN, RESTRICTED, CLOSED) — primary dimension for port access availability analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Prevailing weather condition during the window (e.g. CLEAR, FOG, STORM) — used to correlate weather with operational restrictions."
    - name: "visibility_category"
      expr: visibility_category
      comment: "Visibility category (e.g. GOOD, MODERATE, POOR, FOG) — used to assess visibility-related operational risk."
    - name: "tidal_phase"
      expr: tidal_phase
      comment: "Tidal phase during the window (e.g. FLOOD, EBB, SLACK) — used to correlate tidal conditions with operational constraints."
    - name: "sea_state_code"
      expr: sea_state_code
      comment: "Beaufort or Douglas sea state code — used to assess sea conditions and their impact on vessel operations."
    - name: "pilotage_restriction_flag"
      expr: pilotage_restriction_flag
      comment: "Whether pilotage was restricted during this window — used to quantify pilotage downtime due to weather."
    - name: "towage_restriction_flag"
      expr: towage_restriction_flag
      comment: "Whether towage was restricted during this window — used to quantify towage downtime due to weather."
    - name: "mooring_restriction_flag"
      expr: mooring_restriction_flag
      comment: "Whether mooring was restricted during this window — used to quantify mooring downtime due to weather."
    - name: "marpol_environmental_flag"
      expr: marpol_environmental_flag
      comment: "Whether MARPOL environmental conditions were flagged during this window — used for environmental risk monitoring."
    - name: "solas_compliance_flag"
      expr: solas_compliance_flag
      comment: "Whether SOLAS compliance conditions were met during this window — used for safety regulatory monitoring."
    - name: "observation_date"
      expr: DATE_TRUNC('day', observation_timestamp)
      comment: "Calendar day of the weather/tide observation — primary time dimension for daily environmental condition trending."
    - name: "observation_month"
      expr: DATE_TRUNC('month', observation_timestamp)
      comment: "Calendar month of the observation — used for monthly environmental condition roll-ups and seasonal analysis."
    - name: "forecast_source"
      expr: forecast_source
      comment: "Source of the weather forecast (e.g. BOM, METSERVICE, PORT_SENSOR) — used to assess forecast accuracy by source."
  measures:
    - name: "total_weather_tide_windows"
      expr: COUNT(1)
      comment: "Total number of weather and tide window observations — baseline KPI for environmental monitoring coverage."
    - name: "restricted_windows_count"
      expr: COUNT(CASE WHEN service_window_status = 'RESTRICTED' THEN 1 END)
      comment: "Number of windows with operational restrictions — port access availability KPI used by the Harbour Master for scheduling decisions."
    - name: "restriction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_window_status IN ('RESTRICTED', 'CLOSED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of windows with operational restrictions or closures — port availability KPI for commercial and operational planning."
    - name: "pilotage_restriction_count"
      expr: COUNT(CASE WHEN pilotage_restriction_flag = TRUE THEN 1 END)
      comment: "Number of windows with pilotage restrictions — used to quantify weather-driven pilotage downtime and its impact on vessel scheduling."
    - name: "pilotage_restriction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pilotage_restriction_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of windows with pilotage restrictions — used to assess weather-driven pilotage availability and port competitiveness."
    - name: "avg_ukc_available_m"
      expr: AVG(CAST(ukc_available_m AS DOUBLE))
      comment: "Average under-keel clearance available in metres — critical safety KPI for vessel draft management and grounding risk assessment."
    - name: "min_ukc_available_m"
      expr: MIN(CAST(ukc_available_m AS DOUBLE))
      comment: "Minimum under-keel clearance recorded — extreme safety KPI; values approaching zero indicate critical grounding risk."
    - name: "avg_wave_height_m"
      expr: AVG(CAST(wave_height_m AS DOUBLE))
      comment: "Average wave height in metres — used to assess sea state severity and correlate with operational restrictions."
    - name: "max_wave_height_m"
      expr: MAX(CAST(wave_height_m AS DOUBLE))
      comment: "Maximum wave height recorded — used to identify extreme weather events and validate operational limit thresholds."
    - name: "avg_wind_speed_knots"
      expr: AVG(CAST(wind_speed_knots AS DOUBLE))
      comment: "Average wind speed in knots — used to assess wind-driven operational risk and correlate with restriction rates."
    - name: "max_wind_gust_speed_knots"
      expr: MAX(CAST(wind_gust_speed_knots AS DOUBLE))
      comment: "Maximum wind gust speed recorded in knots — used to identify extreme wind events and validate operational limit thresholds."
    - name: "avg_visibility_nm"
      expr: AVG(CAST(visibility_nm AS DOUBLE))
      comment: "Average visibility in nautical miles — used to assess visibility conditions and their impact on pilotage and navigation safety."
    - name: "avg_tide_height_variance_m"
      expr: AVG(CAST(tide_height_variance_m AS DOUBLE))
      comment: "Average variance between predicted and actual tide height in metres — forecast accuracy KPI used to assess tidal prediction reliability."
    - name: "avg_tidal_stream_rate_knots"
      expr: AVG(CAST(tidal_stream_rate_knots AS DOUBLE))
      comment: "Average tidal stream rate in knots — used to assess current-driven operational difficulty for pilotage and mooring."
    - name: "avg_max_vessel_draft_permitted_m"
      expr: AVG(CAST(max_vessel_draft_permitted_m AS DOUBLE))
      comment: "Average maximum vessel draft permitted across all windows — used to assess port accessibility for deep-draught vessels."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`marine_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marine service order financial and operational KPIs covering order throughput, estimated revenue, service type mix, and multi-service coordination. Used by the Port Operations Manager and Finance team to govern marine service delivery and revenue forecasting."
  source: "`shipping_ports_ecm`.`marine`.`marine_service_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the marine service order (e.g. CONFIRMED, COMPLETED, CANCELLED) — primary filter for operational reporting."
    - name: "order_type"
      expr: order_type
      comment: "Type of marine service order (e.g. PILOTAGE, TOWAGE, MOORING, COMBINED) — used to segment revenue and workload by service category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service order (e.g. ROUTINE, URGENT, EMERGENCY) — used to analyse priority distribution and response capability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimated charge — required for multi-currency financial reporting."
    - name: "pilotage_required_flag"
      expr: pilotage_required
      comment: "Whether pilotage was required for this service order — used to analyse pilotage demand across all marine service orders."
    - name: "towage_required_flag"
      expr: towage_required
      comment: "Whether towage was required for this service order — used to analyse tug demand across all marine service orders."
    - name: "mooring_required_flag"
      expr: mooring_required
      comment: "Whether mooring was required for this service order — used to analyse mooring gang demand."
    - name: "launch_service_required_flag"
      expr: launch_service_required
      comment: "Whether a launch service was required — used to analyse launch demand across marine service orders."
    - name: "surveyor_required_flag"
      expr: surveyor_required
      comment: "Whether a surveyor was required — used to analyse survey demand across marine service orders."
    - name: "pilotage_type"
      expr: pilotage_type
      comment: "Type of pilotage service requested (e.g. COMPULSORY, VOLUNTARY) — used for regulatory compliance and revenue analysis."
    - name: "order_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Calendar day the service order was created — primary time dimension for daily order intake trending."
    - name: "order_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month the service order was created — used for monthly revenue forecasting and volume trending."
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of marine service orders — baseline throughput KPI for port marine operations demand."
    - name: "completed_service_orders"
      expr: COUNT(CASE WHEN order_status = 'COMPLETED' THEN 1 END)
      comment: "Count of completed marine service orders — measures overall marine service delivery performance."
    - name: "cancelled_service_orders"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled marine service orders — elevated cancellation rates signal scheduling or demand forecasting issues."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of marine service orders that were cancelled — service reliability KPI used in operational performance reviews."
    - name: "total_estimated_charge_revenue"
      expr: SUM(CAST(estimated_total_charge AS DOUBLE))
      comment: "Total estimated charge across all marine service orders — revenue pipeline KPI for financial forecasting."
    - name: "avg_estimated_charge_per_order"
      expr: AVG(CAST(estimated_total_charge AS DOUBLE))
      comment: "Average estimated charge per marine service order — used for tariff benchmarking and revenue yield analysis."
    - name: "pilotage_required_orders"
      expr: COUNT(CASE WHEN pilotage_required = TRUE THEN 1 END)
      comment: "Number of service orders requiring pilotage — used to forecast pilot demand and ensure adequate pilot rostering."
    - name: "towage_required_orders"
      expr: COUNT(CASE WHEN towage_required = TRUE THEN 1 END)
      comment: "Number of service orders requiring towage — used to forecast tug demand and fleet deployment planning."
    - name: "mooring_required_orders"
      expr: COUNT(CASE WHEN mooring_required = TRUE THEN 1 END)
      comment: "Number of service orders requiring mooring — used to forecast mooring gang demand and berth scheduling."
    - name: "multi_service_orders"
      expr: COUNT(CASE WHEN pilotage_required = TRUE AND towage_required = TRUE THEN 1 END)
      comment: "Number of orders requiring both pilotage and towage — used to identify complex vessel movements requiring coordinated multi-service deployment."
    - name: "distinct_vessel_calls_served"
      expr: COUNT(DISTINCT vessel_call_id)
      comment: "Number of unique vessel calls served by marine service orders — measures port traffic coverage by marine services."
$$;