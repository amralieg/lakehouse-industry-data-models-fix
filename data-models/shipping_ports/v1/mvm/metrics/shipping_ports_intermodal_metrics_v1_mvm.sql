-- Metric views for domain: intermodal | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_drayage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and performance metrics for drayage orders — the last-mile truck movements connecting port terminals to inland destinations. Supports haulier performance management, on-time delivery tracking, hazmat compliance, and reefer cargo oversight."
  source: "`shipping_ports_ecm`.`intermodal`.`drayage_order`"
  dimensions:
    - name: "drayage_status"
      expr: drayage_status
      comment: "Current lifecycle status of the drayage order (e.g. PENDING, IN_TRANSIT, DELIVERED, CANCELLED) — primary operational grouping for performance dashboards."
    - name: "drayage_type"
      expr: drayage_type
      comment: "Classification of the drayage movement (e.g. IMPORT, EXPORT, TRANSSHIPMENT) — used to segment volumes and costs by trade direction."
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (e.g. BERTH, WAREHOUSE, ICD) — identifies where the drayage leg begins for network analysis."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location (e.g. TERMINAL_ZONE, PORT_GATE, CUSTOMER_SITE) — identifies where the drayage leg ends."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the drayage order (e.g. HIGH, NORMAL, LOW) — used to assess SLA adherence by priority tier."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating whether the drayage order carries hazardous materials — critical for compliance and safety reporting."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Boolean flag indicating whether the drayage order involves a refrigerated container — used to track cold-chain performance."
    - name: "overweight_indicator"
      expr: overweight_indicator
      comment: "Boolean flag indicating whether the container is overweight — used for regulatory compliance and road permit tracking."
    - name: "proof_of_delivery_received"
      expr: proof_of_delivery_received
      comment: "Boolean flag indicating whether proof of delivery has been received — key indicator for order completion and billing readiness."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month bucket of the scheduled delivery date — enables trend analysis of delivery volumes over time."
    - name: "container_condition"
      expr: container_condition
      comment: "Condition of the container at time of drayage (e.g. GOOD, DAMAGED) — used for cargo integrity and claims management."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class code — used to segment hazmat drayage orders by risk category for compliance reporting."
  measures:
    - name: "total_drayage_orders"
      expr: COUNT(1)
      comment: "Total number of drayage orders — baseline volume metric for capacity planning and haulier workload assessment."
    - name: "delivered_orders"
      expr: COUNT(CASE WHEN drayage_status = 'DELIVERED' THEN 1 END)
      comment: "Count of drayage orders with DELIVERED status — measures actual throughput and completion rate."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN drayage_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled drayage orders — elevated cancellation rates signal haulier reliability or booking quality issues."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_time_window_end AND drayage_status = 'DELIVERED' THEN 1 END)
      comment: "Count of drayage orders delivered within the scheduled time window — numerator for on-time delivery rate KPI."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_time_window_end AND drayage_status = 'DELIVERED' THEN 1 END) / NULLIF(COUNT(CASE WHEN drayage_status = 'DELIVERED' THEN 1 END), 0), 2)
      comment: "Percentage of delivered drayage orders completed within the scheduled delivery window — primary SLA performance KPI for haulier management."
    - name: "proof_of_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN proof_of_delivery_received = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN drayage_status = 'DELIVERED' THEN 1 END), 0), 2)
      comment: "Percentage of delivered orders with confirmed proof of delivery — measures documentation compliance and billing readiness."
    - name: "hazmat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drayage orders carrying hazardous materials — used to assess regulatory exposure and resource allocation for hazmat handling."
    - name: "reefer_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reefer_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drayage orders involving refrigerated containers — informs cold-chain capacity planning and reefer equipment utilisation."
    - name: "avg_verified_gross_mass_kg"
      expr: ROUND(AVG(CAST(verified_gross_mass_kg AS DOUBLE)), 2)
      comment: "Average verified gross mass in kilograms across drayage orders — used to monitor cargo weight profiles and overweight risk."
    - name: "total_verified_gross_mass_kg"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass in kilograms across all drayage orders — aggregate weight throughput metric for infrastructure load planning."
    - name: "distinct_hauliers_active"
      expr: COUNT(DISTINCT haulier_id)
      comment: "Number of distinct hauliers executing drayage orders — measures haulier network breadth and dependency concentration."
    - name: "overweight_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overweight_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drayage orders flagged as overweight — high rates indicate road permit compliance risk and potential infrastructure damage liability."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_truck_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate and truck appointment performance metrics covering slot utilisation, no-show rates, hazmat and reefer appointment volumes, and appointment lifecycle management. Supports gate throughput optimisation and haulier compliance monitoring."
  source: "`shipping_ports_ecm`.`intermodal`.`truck_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the truck appointment (e.g. CONFIRMED, CANCELLED, COMPLETED, NO_SHOW) — primary grouping for gate throughput analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of truck appointment (e.g. IMPORT_PICKUP, EXPORT_DROP, EMPTY_RETURN) — used to segment gate activity by trade direction and cargo type."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (e.g. WEB_PORTAL, EDI, PHONE) — used to drive digital adoption and reduce manual booking costs."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the appointment (e.g. ROAD, RAIL) — used to segment gate activity by transport type."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Boolean flag indicating whether the appointment involves hazardous cargo — used for compliance and gate lane allocation."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Boolean flag indicating whether the appointment involves a refrigerated container — used for reefer plug and cold-chain resource planning."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Boolean flag indicating whether the appointment involves oversized cargo — used for special handling lane allocation."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Boolean flag indicating whether the appointment involves overweight cargo — used for weighbridge and permit compliance tracking."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle used for the appointment (e.g. SEMI_TRAILER, RIGID_TRUCK) — used for gate infrastructure and lane capacity planning."
    - name: "confirmed_slot_date"
      expr: DATE_TRUNC('month', confirmed_slot_start_time)
      comment: "Month bucket of the confirmed slot start time — enables trend analysis of appointment volumes and gate utilisation over time."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for the appointment — used to segment hazmat appointments by risk category."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of truck appointments — baseline gate demand metric for capacity planning."
    - name: "confirmed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'CONFIRMED' THEN 1 END)
      comment: "Count of confirmed truck appointments — measures effective gate slot utilisation."
    - name: "no_show_appointments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Count of appointments where the truck did not arrive — no-shows waste gate capacity and disrupt terminal operations."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN appointment_status IN ('CONFIRMED', 'COMPLETED', 'NO_SHOW') THEN 1 END), 0), 2)
      comment: "Percentage of confirmed appointments resulting in a no-show — key gate efficiency KPI; high rates indicate haulier reliability issues or overbooking."
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled truck appointments — used to assess booking quality and gate slot wastage."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments that were cancelled — high cancellation rates reduce gate throughput and increase operational costs."
    - name: "hazmat_appointment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck appointments involving hazardous cargo — used to plan dedicated hazmat lanes and compliance resources."
    - name: "reefer_appointment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reefer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck appointments involving refrigerated containers — informs reefer plug capacity allocation at the gate."
    - name: "avg_cargo_weight_kg"
      expr: ROUND(AVG(CAST(cargo_weight_kg AS DOUBLE)), 2)
      comment: "Average cargo weight in kilograms per truck appointment — used to monitor load profiles and infrastructure stress."
    - name: "total_teu_quantity"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU quantity across all truck appointments — measures container throughput volume at the gate."
    - name: "distinct_hauliers"
      expr: COUNT(DISTINCT haulier_id)
      comment: "Number of distinct hauliers with truck appointments — measures haulier network activity and concentration risk."
    - name: "digital_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_channel IN ('WEB_PORTAL', 'EDI', 'API') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked through digital channels — measures progress toward paperless port operations and cost reduction."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_truck_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate transaction and truck visit performance metrics covering actual gate throughput, turnaround quality, ISPS compliance, and damage reporting. Supports real-time gate operations management and security compliance oversight."
  source: "`shipping_ports_ecm`.`intermodal`.`truck_visit`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the gate transaction (e.g. COMPLETED, REJECTED, PENDING) — primary grouping for gate throughput and exception analysis."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of truck visit (e.g. IMPORT_PICKUP, EXPORT_DROP, EMPTY_RETURN) — used to segment gate activity by cargo movement direction."
    - name: "container_condition"
      expr: container_condition
      comment: "Condition of the container at gate entry (e.g. GOOD, DAMAGED) — used for cargo integrity tracking and insurance claims management."
    - name: "isps_compliance_check_result"
      expr: isps_compliance_check_result
      comment: "Result of the ISPS security compliance check at gate entry — used for port security reporting and regulatory compliance."
    - name: "seal_verification_status"
      expr: seal_verification_status
      comment: "Status of container seal verification at gate (e.g. VERIFIED, BROKEN, MISSING) — critical for cargo security and customs compliance."
    - name: "driver_verification_method"
      expr: driver_verification_method
      comment: "Method used to verify the driver identity (e.g. BIOMETRIC, PIN, RFID) — used to assess security protocol adherence."
    - name: "damage_report_indicator"
      expr: damage_report_indicator
      comment: "Boolean flag indicating whether a damage report was raised during the visit — used for cargo claims and container maintenance tracking."
    - name: "gate_in_month"
      expr: DATE_TRUNC('month', gate_in_time)
      comment: "Month bucket of gate-in time — enables trend analysis of truck visit volumes and gate throughput over time."
  measures:
    - name: "total_truck_visits"
      expr: COUNT(1)
      comment: "Total number of truck visits processed at the gate — primary gate throughput volume metric."
    - name: "completed_visits"
      expr: COUNT(CASE WHEN transaction_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed gate transactions — measures effective gate throughput."
    - name: "rejected_visits"
      expr: COUNT(CASE WHEN transaction_status = 'REJECTED' THEN 1 END)
      comment: "Count of rejected gate transactions — rejections cause congestion and indicate compliance or documentation failures."
    - name: "gate_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_status = 'REJECTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck visits rejected at the gate — high rejection rates signal documentation, compliance, or appointment quality issues."
    - name: "damage_report_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_report_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck visits resulting in a damage report — used to monitor cargo integrity and container condition at gate entry."
    - name: "isps_non_compliance_count"
      expr: COUNT(CASE WHEN isps_compliance_check_result = 'FAIL' THEN 1 END)
      comment: "Count of truck visits failing the ISPS security compliance check — a critical port security KPI with direct regulatory consequences."
    - name: "isps_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN isps_compliance_check_result = 'PASS' THEN 1 END) / NULLIF(COUNT(CASE WHEN isps_compliance_check_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of truck visits passing the ISPS security compliance check — mandatory port security performance indicator."
    - name: "seal_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN seal_verification_status IN ('BROKEN', 'MISSING') THEN 1 END) / NULLIF(COUNT(CASE WHEN seal_verification_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of truck visits with broken or missing container seals — elevated rates indicate cargo security risk and potential customs violations."
    - name: "avg_ocr_confidence_score"
      expr: ROUND(AVG(CAST(ocr_confidence_score AS DOUBLE)), 2)
      comment: "Average OCR confidence score for automated license plate and container number recognition — measures gate automation quality and readiness for straight-through processing."
    - name: "distinct_hauliers_visiting"
      expr: COUNT(DISTINCT haulier_id)
      comment: "Number of distinct hauliers with truck visits — measures active haulier network utilisation at the gate."
    - name: "appointment_utilisation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN truck_appointment_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of truck visits that arrived with a pre-booked appointment — measures appointment system adoption and gate pre-planning effectiveness."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intermodal journey leg performance metrics covering transit time adherence, cost efficiency, carbon emissions, TEU throughput, and delay analysis across all transport modes. Core KPI layer for multimodal supply chain performance management."
  source: "`shipping_ports_ecm`.`intermodal`.`leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the intermodal leg (e.g. PLANNED, IN_TRANSIT, COMPLETED, DELAYED) — primary operational grouping for performance dashboards."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the leg (e.g. ROAD, RAIL, SEA) — used to compare performance and cost across transport modes."
    - name: "origin_node_type"
      expr: origin_node_type
      comment: "Type of origin node (e.g. PORT, ICD, WAREHOUSE) — used to analyse leg performance by supply chain node type."
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node (e.g. PORT, ICD, CUSTOMER) — used to segment legs by destination node category."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating whether the leg carries hazardous materials — used for compliance and risk-weighted performance analysis."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Boolean flag indicating whether the leg involves a refrigerated container — used for cold-chain performance monitoring."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for leg delay (e.g. CUSTOMS_HOLD, EQUIPMENT_FAILURE, WEATHER) — used to identify root causes of transit delays."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_timestamp)
      comment: "Month bucket of scheduled departure — enables trend analysis of leg volumes and performance over time."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for the leg — used to segment hazmat legs by risk category."
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Total number of intermodal legs — baseline throughput metric for network capacity and utilisation analysis."
    - name: "completed_legs"
      expr: COUNT(CASE WHEN leg_status = 'COMPLETED' THEN 1 END)
      comment: "Count of completed intermodal legs — measures actual network throughput."
    - name: "delayed_legs"
      expr: COUNT(CASE WHEN leg_status = 'DELAYED' THEN 1 END)
      comment: "Count of delayed intermodal legs — used to identify systemic delay patterns across the intermodal network."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= scheduled_arrival_timestamp AND leg_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN leg_status = 'COMPLETED' THEN 1 END), 0), 2)
      comment: "Percentage of completed legs where actual arrival was within the scheduled arrival time — primary transit reliability KPI for the intermodal network."
    - name: "total_teu_throughput"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU throughput across all intermodal legs — primary volume metric for network capacity planning and revenue forecasting."
    - name: "avg_teu_per_leg"
      expr: ROUND(AVG(CAST(teu_count AS DOUBLE)), 2)
      comment: "Average TEU count per intermodal leg — measures load density and identifies underutilised legs for consolidation opportunities."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost in USD across all intermodal legs — primary cost base for transport cost management and budget variance analysis."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost in USD across all intermodal legs — used as the budget baseline for cost variance calculation."
    - name: "cost_variance_usd"
      expr: ROUND(SUM(CAST(actual_cost_usd AS DOUBLE)) - SUM(CAST(estimated_cost_usd AS DOUBLE)), 2)
      comment: "Difference between actual and estimated transport costs in USD — positive values indicate cost overruns requiring management attention."
    - name: "avg_transit_time_hours"
      expr: ROUND(AVG(CAST(transit_time_hours AS DOUBLE)), 2)
      comment: "Average transit time in hours per intermodal leg — key supply chain velocity metric used to benchmark against SLA targets."
    - name: "total_carbon_emissions_kg_co2"
      expr: SUM(CAST(carbon_emissions_kg_co2 AS DOUBLE))
      comment: "Total carbon emissions in kg CO2 across all intermodal legs — primary sustainability KPI for ESG reporting and decarbonisation target tracking."
    - name: "avg_carbon_per_teu_kg_co2"
      expr: ROUND(SUM(CAST(carbon_emissions_kg_co2 AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 4)
      comment: "Average carbon emissions per TEU in kg CO2 — carbon intensity efficiency metric used to compare transport modes and drive modal shift decisions."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered across all intermodal legs in kilometres — used for network coverage analysis and cost-per-km benchmarking."
    - name: "cost_per_teu_usd"
      expr: ROUND(SUM(CAST(actual_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Actual transport cost per TEU in USD — primary unit economics metric for intermodal pricing and profitability management."
    - name: "edi_acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_message_acknowledged_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN edi_message_sent_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of EDI messages sent that received acknowledgement — measures digital connectivity reliability with transport partners."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_rail_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rail visit performance metrics covering train punctuality, TEU throughput, wagon utilisation, and billing status. Supports rail terminal operations management and rail operator performance benchmarking."
  source: "`shipping_ports_ecm`.`intermodal`.`rail_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the rail visit (e.g. PLANNED, IN_PROGRESS, COMPLETED, CANCELLED) — primary grouping for rail terminal throughput analysis."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of rail visit (e.g. IMPORT, EXPORT, TRANSIT) — used to segment rail volumes by trade direction."
    - name: "service_type"
      expr: service_type
      comment: "Type of rail service (e.g. BLOCK_TRAIN, INTERMODAL_EXPRESS, SHUTTLE) — used to compare performance across service categories."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the rail visit (e.g. PENDING, INVOICED, PAID) — used to track revenue recognition and accounts receivable."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating whether the rail visit includes hazardous cargo — used for compliance and safety reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the rail visit — used to assess SLA adherence by priority tier."
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_time)
      comment: "Month bucket of scheduled arrival time — enables trend analysis of rail visit volumes over time."
    - name: "origin_location"
      expr: origin_location
      comment: "Origin location of the rail visit — used to analyse rail corridor performance and volume by origin."
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of the rail visit — used to analyse rail corridor performance and volume by destination."
  measures:
    - name: "total_rail_visits"
      expr: COUNT(1)
      comment: "Total number of rail visits — baseline rail terminal throughput metric."
    - name: "completed_rail_visits"
      expr: COUNT(CASE WHEN visit_status = 'COMPLETED' THEN 1 END)
      comment: "Count of completed rail visits — measures actual rail terminal throughput."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_time <= scheduled_arrival_time AND visit_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN visit_status = 'COMPLETED' THEN 1 END), 0), 2)
      comment: "Percentage of completed rail visits where the train arrived on or before the scheduled arrival time — primary rail punctuality KPI."
    - name: "on_time_departure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_departure_time <= scheduled_departure_time AND visit_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN visit_status = 'COMPLETED' THEN 1 END), 0), 2)
      comment: "Percentage of completed rail visits where the train departed on or before the scheduled departure time — measures rail terminal operational efficiency."
    - name: "avg_train_length_meters"
      expr: ROUND(AVG(CAST(train_length_meters AS DOUBLE)), 2)
      comment: "Average train length in metres across rail visits — used to assess infrastructure utilisation and track capacity planning."
    - name: "avg_train_weight_tonnes"
      expr: ROUND(AVG(CAST(train_weight_tonnes AS DOUBLE)), 2)
      comment: "Average train weight in tonnes across rail visits — used to monitor load profiles and rail infrastructure stress."
    - name: "total_train_weight_tonnes"
      expr: SUM(CAST(train_weight_tonnes AS DOUBLE))
      comment: "Total train weight in tonnes across all rail visits — aggregate load metric for rail infrastructure capacity management."
    - name: "distinct_rail_operators"
      expr: COUNT(DISTINCT rail_operator_id)
      comment: "Number of distinct rail operators with visits — measures rail operator network breadth and dependency concentration."
    - name: "hazmat_visit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rail visits carrying hazardous cargo — used to plan dedicated hazmat handling resources and compliance oversight."
    - name: "billing_pending_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_status = 'PENDING' THEN 1 END) / NULLIF(COUNT(CASE WHEN visit_status = 'COMPLETED' THEN 1 END), 0), 2)
      comment: "Percentage of completed rail visits with pending billing — high rates indicate revenue leakage risk and billing process inefficiency."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_rail_wagon_load`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rail wagon load metrics covering cargo weight, TEU utilisation, hazmat and reefer load profiles, customs status, and load completion rates. Supports rail cargo planning, compliance management, and wagon utilisation optimisation."
  source: "`shipping_ports_ecm`.`intermodal`.`rail_wagon_load`"
  dimensions:
    - name: "load_status"
      expr: load_status
      comment: "Current status of the wagon load (e.g. PLANNED, LOADED, SECURED, UNLOADED) — primary grouping for rail cargo throughput analysis."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status of the wagon load (e.g. CLEARED, HELD, PENDING) — used for compliance monitoring and dwell time analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Boolean flag indicating whether the wagon load contains hazardous materials — used for IMDG compliance and safety reporting."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Boolean flag indicating whether the wagon load involves a refrigerated container — used for cold-chain performance monitoring."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Boolean flag indicating whether the wagon load is oversized — used for special handling and clearance gauge compliance."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Boolean flag indicating whether the wagon load is overweight — used for axle load compliance and infrastructure protection."
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the wagon load — used to analyse cargo flows by destination corridor."
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the wagon load — used to analyse cargo flows by origin corridor."
    - name: "planned_load_month"
      expr: DATE_TRUNC('month', planned_load_timestamp)
      comment: "Month bucket of planned load timestamp — enables trend analysis of rail cargo volumes over time."
    - name: "special_handling_code"
      expr: special_handling_code
      comment: "Special handling code for the wagon load — used to segment loads requiring non-standard handling for resource planning."
  measures:
    - name: "total_wagon_loads"
      expr: COUNT(1)
      comment: "Total number of rail wagon load records — baseline rail cargo volume metric."
    - name: "total_teu_loaded"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU count across all wagon loads — primary rail cargo throughput metric for capacity planning and revenue forecasting."
    - name: "avg_teu_per_wagon_load"
      expr: ROUND(AVG(CAST(teu_count AS DOUBLE)), 2)
      comment: "Average TEU count per wagon load — measures wagon utilisation density and identifies consolidation opportunities."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kilograms across all wagon loads — aggregate load metric for rail infrastructure capacity management."
    - name: "total_net_cargo_weight_kg"
      expr: SUM(CAST(net_cargo_weight_kg AS DOUBLE))
      comment: "Total net cargo weight in kilograms — measures actual cargo payload carried, excluding tare weight."
    - name: "avg_net_cargo_weight_kg"
      expr: ROUND(AVG(CAST(net_cargo_weight_kg AS DOUBLE)), 2)
      comment: "Average net cargo weight per wagon load — used to benchmark load efficiency against wagon payload capacity."
    - name: "payload_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(net_cargo_weight_kg AS DOUBLE)) / NULLIF(SUM(CAST(gross_weight_kg AS DOUBLE)), 0), 2)
      comment: "Percentage of gross weight that is net cargo — measures payload efficiency; low values indicate high tare-to-payload ratios."
    - name: "hazmat_load_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wagon loads containing hazardous materials — used to assess regulatory exposure and plan hazmat handling resources."
    - name: "customs_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_status = 'HELD' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wagon loads under customs hold — high rates indicate customs clearance bottlenecks causing rail dwell time and cost overruns."
    - name: "overweight_load_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overweight = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wagon loads flagged as overweight — used for axle load compliance monitoring and infrastructure protection."
    - name: "distinct_wagons_utilised"
      expr: COUNT(DISTINCT rail_wagon_id)
      comment: "Number of distinct rail wagons utilised — measures active fleet utilisation and identifies idle wagon capacity."
    - name: "reefer_load_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reefer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wagon loads involving refrigerated containers — informs reefer-capable wagon fleet planning."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport order lifecycle and performance metrics covering order fulfilment rates, delivery punctuality, cargo volume throughput, and multimodal order management. Core KPI layer for supply chain execution and customer service performance."
  source: "`shipping_ports_ecm`.`intermodal`.`transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the transport order (e.g. PENDING, IN_PROGRESS, DELIVERED, CANCELLED) — primary grouping for order fulfilment analysis."
    - name: "primary_transport_mode"
      expr: primary_transport_mode
      comment: "Primary mode of transport for the order (e.g. ROAD, RAIL, SEA) — used to segment order volumes and performance by transport mode."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transport order (e.g. HIGH, NORMAL, LOW) — used to assess SLA adherence by priority tier."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Boolean flag indicating whether the transport order involves hazardous cargo — used for compliance and risk-weighted performance analysis."
    - name: "is_refrigerated"
      expr: is_refrigerated
      comment: "Boolean flag indicating whether the transport order involves refrigerated cargo — used for cold-chain performance monitoring."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for the transport order — used to segment hazmat orders by risk category."
    - name: "origin_location"
      expr: origin_location
      comment: "Origin location of the transport order — used to analyse order flows and performance by origin corridor."
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of the transport order — used to analyse order flows and performance by destination corridor."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month bucket of the order creation date — enables trend analysis of transport order volumes over time."
    - name: "transport_mode_sequence"
      expr: transport_mode_sequence
      comment: "Sequence of transport modes used in the order (e.g. ROAD-RAIL-SEA) — used to analyse multimodal routing patterns and performance."
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of transport orders — baseline volume metric for supply chain throughput and capacity planning."
    - name: "delivered_orders"
      expr: COUNT(CASE WHEN order_status = 'DELIVERED' THEN 1 END)
      comment: "Count of transport orders with DELIVERED status — measures actual supply chain fulfilment throughput."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date AND order_status = 'DELIVERED' THEN 1 END) / NULLIF(COUNT(CASE WHEN order_status = 'DELIVERED' THEN 1 END), 0), 2)
      comment: "Percentage of delivered transport orders completed by the estimated delivery date — primary customer service level KPI."
    - name: "order_fulfilment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'DELIVERED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transport orders successfully delivered — measures end-to-end supply chain execution effectiveness."
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU count across all transport orders — primary container volume metric for capacity planning and revenue forecasting."
    - name: "avg_teu_per_order"
      expr: ROUND(AVG(CAST(teu_count AS DOUBLE)), 2)
      comment: "Average TEU count per transport order — measures order size and identifies consolidation opportunities."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across all transport orders — aggregate payload metric for infrastructure and equipment planning."
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres across all transport orders — used for space utilisation and load planning analysis."
    - name: "hazmat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transport orders involving hazardous cargo — used to assess regulatory exposure and resource allocation for hazmat handling."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled transport orders — elevated cancellation rates signal demand volatility or operational execution issues."
    - name: "distinct_shippers"
      expr: COUNT(DISTINCT primary_transport_participant_account_id)
      comment: "Number of distinct shipper accounts with transport orders — measures customer base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_slot_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intermodal slot booking performance metrics covering booking conversion, no-show rates, TEU volume, digital channel adoption, and hazmat/reefer booking profiles. Supports slot capacity management and booking quality optimisation."
  source: "`shipping_ports_ecm`.`intermodal`.`slot_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the slot booking (e.g. CONFIRMED, CANCELLED, COMPLETED, NO_SHOW) — primary grouping for booking performance analysis."
    - name: "booking_type"
      expr: booking_type
      comment: "Type of slot booking (e.g. IMPORT, EXPORT, TRANSSHIPMENT) — used to segment booking volumes by trade direction."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the booking was made (e.g. WEB_PORTAL, EDI, PHONE) — used to drive digital adoption and reduce manual booking costs."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo in the booking (e.g. DRY, REEFER, HAZMAT) — used to segment slot demand by cargo category."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating whether the booking involves hazardous cargo — used for compliance and slot allocation planning."
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Boolean flag indicating whether the booking involves a refrigerated container — used for reefer slot capacity planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the slot booking — used to assess SLA adherence and premium slot utilisation."
    - name: "no_show_indicator"
      expr: no_show_indicator
      comment: "Boolean flag indicating whether the booking resulted in a no-show — used to measure slot wastage and booking reliability."
    - name: "booking_date_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Month bucket of the booking date — enables trend analysis of slot booking volumes over time."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms associated with the booking — used to segment bookings by commercial terms for revenue management."
  measures:
    - name: "total_slot_bookings"
      expr: COUNT(1)
      comment: "Total number of slot bookings — baseline slot demand metric for capacity planning."
    - name: "confirmed_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Count of confirmed slot bookings — measures effective slot utilisation."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_indicator = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN booking_status IN ('CONFIRMED', 'COMPLETED', 'NO_SHOW') THEN 1 END), 0), 2)
      comment: "Percentage of confirmed slot bookings resulting in a no-show — key slot efficiency KPI; high rates indicate wasted capacity and revenue loss."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot bookings that were cancelled — high cancellation rates reduce slot utilisation and increase operational costs."
    - name: "total_teu_booked"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU quantity booked across all slot bookings — primary slot demand volume metric for capacity planning and revenue forecasting."
    - name: "avg_teu_per_booking"
      expr: ROUND(AVG(CAST(teu_quantity AS DOUBLE)), 2)
      comment: "Average TEU quantity per slot booking — measures booking size and identifies consolidation opportunities."
    - name: "total_weight_tonnes_booked"
      expr: SUM(CAST(weight_tonnes AS DOUBLE))
      comment: "Total cargo weight in tonnes booked across all slot bookings — used for load planning and infrastructure capacity management."
    - name: "total_volume_cbm_booked"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres booked — used for space utilisation and slot capacity planning."
    - name: "digital_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_channel IN ('WEB_PORTAL', 'EDI', 'API') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot bookings made through digital channels — measures progress toward paperless port operations and cost reduction."
    - name: "hazmat_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot bookings involving hazardous cargo — used to plan dedicated hazmat slots and compliance resources."
    - name: "reefer_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reefer_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slot bookings involving refrigerated containers — informs reefer slot capacity allocation."
    - name: "booking_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(CASE WHEN booking_status IN ('CONFIRMED', 'COMPLETED') THEN 1 END), 0), 2)
      comment: "Percentage of confirmed slot bookings that were successfully completed — measures end-to-end booking fulfilment effectiveness."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_haulier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haulier master data and performance tier metrics covering fleet composition, licence compliance, credit exposure, and performance tier distribution. Supports haulier qualification, risk management, and network partner governance."
  source: "`shipping_ports_ecm`.`intermodal`.`haulier`"
  dimensions:
    - name: "haulier_status"
      expr: haulier_status
      comment: "Current operational status of the haulier (e.g. ACTIVE, SUSPENDED, TERMINATED) — primary grouping for haulier network health analysis."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the haulier (e.g. GOLD, SILVER, BRONZE) — used to segment hauliers by service quality for preferential routing."
    - name: "operator_type"
      expr: operator_type
      comment: "Type of haulier operator (e.g. OWNER_OPERATOR, FLEET_OPERATOR, FREIGHT_FORWARDER) — used to segment the haulier network by business model."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode of the haulier (e.g. ROAD, RAIL, MULTIMODAL) — used to segment hauliers by modal capability."
    - name: "fleet_size"
      expr: fleet_size
      comment: "Fleet size category of the haulier — used to segment hauliers by capacity and assess network concentration risk."
    - name: "onboarding_month"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month bucket of haulier onboarding date — enables trend analysis of haulier network growth over time."
    - name: "licence_expiry_month"
      expr: DATE_TRUNC('month', licence_expiry_date)
      comment: "Month bucket of licence expiry date — used to proactively identify hauliers with upcoming licence renewals."
  measures:
    - name: "total_hauliers"
      expr: COUNT(1)
      comment: "Total number of hauliers in the network — baseline metric for haulier network size and capacity."
    - name: "active_hauliers"
      expr: COUNT(CASE WHEN haulier_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active hauliers — measures the operational haulier network available for drayage and transport assignments."
    - name: "suspended_hauliers"
      expr: COUNT(CASE WHEN haulier_status = 'SUSPENDED' THEN 1 END)
      comment: "Count of suspended hauliers — elevated counts indicate compliance or performance issues reducing available network capacity."
    - name: "active_haulier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN haulier_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hauliers with active status — measures haulier network health and availability."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all hauliers — measures aggregate financial exposure to the haulier network."
    - name: "avg_credit_limit_usd"
      expr: ROUND(AVG(CAST(credit_limit AS DOUBLE)), 2)
      comment: "Average credit limit per haulier — used to benchmark credit exposure and identify outliers requiring credit review."
    - name: "licence_expiring_within_90_days"
      expr: COUNT(CASE WHEN licence_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND haulier_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active hauliers with licences expiring within 90 days — proactive compliance risk indicator to prevent operational disruption."
    - name: "premium_tier_haulier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_tier = 'GOLD' THEN 1 END) / NULLIF(COUNT(CASE WHEN haulier_status = 'ACTIVE' THEN 1 END), 0), 2)
      comment: "Percentage of active hauliers in the top performance tier — measures the quality composition of the active haulier network."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_icd_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inland Container Depot (ICD) facility metrics covering operational status, service capability, compliance posture, and SLA performance. Supports ICD network governance, capacity planning, and regulatory compliance oversight."
  source: "`shipping_ports_ecm`.`intermodal`.`icd_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the ICD facility (e.g. ACTIVE, INACTIVE, UNDER_MAINTENANCE) — primary grouping for network availability analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of ICD facility (e.g. BONDED_WAREHOUSE, DRY_PORT, LOGISTICS_PARK) — used to segment the ICD network by facility category."
    - name: "customs_bonded_facility"
      expr: customs_bonded_facility
      comment: "Boolean flag indicating whether the facility is customs bonded — used to identify facilities capable of handling goods under customs control."
    - name: "dangerous_goods_certified"
      expr: dangerous_goods_certified
      comment: "Boolean flag indicating whether the facility is certified for dangerous goods handling — used for hazmat routing and compliance."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "Boolean flag indicating whether the facility is ISPS compliant — mandatory security compliance indicator for port-connected ICDs."
    - name: "rail_connectivity"
      expr: rail_connectivity
      comment: "Boolean flag indicating whether the facility has rail connectivity — used to identify multimodal-capable ICDs for rail-road interchange planning."
    - name: "fcl_service_available"
      expr: fcl_service_available
      comment: "Boolean flag indicating whether Full Container Load service is available — used for service capability mapping."
    - name: "lcl_service_available"
      expr: lcl_service_available
      comment: "Boolean flag indicating whether Less than Container Load service is available — used for service capability mapping."
    - name: "security_level"
      expr: security_level
      comment: "Security level of the ICD facility — used for risk-based routing and compliance reporting."
    - name: "active_from_month"
      expr: DATE_TRUNC('month', active_from_date)
      comment: "Month bucket of facility activation date — enables trend analysis of ICD network expansion over time."
  measures:
    - name: "total_icd_facilities"
      expr: COUNT(1)
      comment: "Total number of ICD facilities in the network — baseline metric for inland logistics network coverage."
    - name: "active_facilities"
      expr: COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END)
      comment: "Count of operationally active ICD facilities — measures available inland logistics network capacity."
    - name: "isps_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN isps_compliant = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END), 0), 2)
      comment: "Percentage of active ICD facilities that are ISPS compliant — mandatory security compliance KPI for port authority governance."
    - name: "rail_connected_facility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rail_connectivity = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END), 0), 2)
      comment: "Percentage of active ICD facilities with rail connectivity — measures multimodal capability of the inland logistics network."
    - name: "dangerous_goods_certified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_certified = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END), 0), 2)
      comment: "Percentage of active ICD facilities certified for dangerous goods — used to assess hazmat routing capacity across the inland network."
    - name: "avg_sla_turnaround_time_hours"
      expr: ROUND(AVG(CAST(sla_turnaround_time_hours AS DOUBLE)), 2)
      comment: "Average SLA turnaround time in hours across ICD facilities — used to benchmark facility performance against contractual service levels."
    - name: "avg_distance_from_port_km"
      expr: ROUND(AVG(CAST(distance_from_port_km AS DOUBLE)), 2)
      comment: "Average distance of ICD facilities from the port in kilometres — used for drayage cost modelling and inland network optimisation."
    - name: "avg_drayage_time_hours"
      expr: ROUND(AVG(CAST(average_drayage_time_hours AS DOUBLE)), 2)
      comment: "Average drayage time in hours to/from ICD facilities — used to benchmark inland transport performance and identify congestion hotspots."
    - name: "customs_bonded_facility_count"
      expr: COUNT(CASE WHEN customs_bonded_facility = TRUE AND operational_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active customs bonded ICD facilities — measures the network capacity for handling goods under customs control."
$$;