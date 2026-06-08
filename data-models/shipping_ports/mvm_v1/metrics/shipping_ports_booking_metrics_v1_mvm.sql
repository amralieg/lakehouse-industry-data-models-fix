-- Metric views for domain: booking | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_call_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for vessel call bookings — tracks booking pipeline health, cancellation rates, lead times, and service demand signals to support port capacity planning and commercial performance management."
  source: "`shipping_ports_ecm`.`booking`.`call_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the call booking (e.g. CONFIRMED, CANCELLED, PENDING) — primary segmentation for funnel analysis."
    - name: "booking_date_month"
      expr: DATE_TRUNC('MONTH', booking_submitted_timestamp)
      comment: "Month the booking was submitted — enables trend analysis of booking volumes over time."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level declared for the vessel call — used for compliance and risk segmentation."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether the vessel call involves dangerous goods — critical for safety and regulatory reporting."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required for this call — drives resource planning for pilot boat scheduling."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required for this call — drives tug allocation planning."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for the vessel call — used to monitor compliance bottlenecks."
    - name: "booking_confirmed_date"
      expr: DATE_TRUNC('DAY', booking_confirmed_timestamp)
      comment: "Date the booking was confirmed — used to measure confirmation throughput and SLA adherence."
  measures:
    - name: "total_call_bookings"
      expr: COUNT(1)
      comment: "Total number of vessel call bookings — baseline volume KPI for port traffic planning and commercial pipeline monitoring."
    - name: "confirmed_call_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of call bookings in CONFIRMED status — measures effective booking conversion and port schedule commitment."
    - name: "cancelled_call_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled call bookings — high cancellation rates signal commercial risk, scheduling instability, or customer dissatisfaction."
    - name: "dangerous_goods_call_bookings"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of call bookings involving dangerous goods — drives HAZMAT compliance resource allocation and risk exposure reporting."
    - name: "pilotage_required_bookings"
      expr: COUNT(CASE WHEN pilotage_required = TRUE THEN 1 END)
      comment: "Number of bookings requiring pilotage — directly informs pilot boat and pilot officer scheduling demand."
    - name: "towage_required_bookings"
      expr: COUNT(CASE WHEN towage_required = TRUE THEN 1 END)
      comment: "Number of bookings requiring towage — directly informs tug fleet scheduling and capacity planning."
    - name: "avg_booking_to_eta_lead_time_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(eta) - UNIX_TIMESTAMP(booking_submitted_timestamp) AS DOUBLE) / 3600.0)
      comment: "Average lead time in hours between booking submission and estimated time of arrival — measures advance planning horizon; short lead times indicate reactive bookings that stress port operations."
    - name: "avg_eta_to_atd_port_stay_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(atd) - UNIX_TIMESTAMP(eta) AS DOUBLE) / 3600.0)
      comment: "Average port stay duration in hours from ETA to ATD — a key berth utilisation and throughput efficiency indicator."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines with active call bookings — measures commercial diversity and dependency concentration risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_berth_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and commercial KPIs for berth reservations — tracks berth utilisation, vessel dimensions, service complexity, and reservation lifecycle to support terminal planning and revenue optimisation."
  source: "`shipping_ports_ecm`.`booking`.`berth_reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the berth reservation (e.g. CONFIRMED, CANCELLED, PENDING) — primary lifecycle segmentation."
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the berth reservation (e.g. CONTAINER, BULK, RO-RO) — enables revenue and utilisation analysis by service category."
    - name: "berth_side"
      expr: berth_side
      comment: "Side of berth assigned (PORT/STARBOARD) — operational dimension for mooring planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the reservation — used to assess premium service demand and SLA compliance."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the reservation involves dangerous goods — critical for safety compliance segmentation."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required for this berth reservation — drives pilot resource demand forecasting."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required — drives tug fleet demand forecasting."
    - name: "tidal_window_required"
      expr: tidal_window_required
      comment: "Whether a tidal window constraint applies — affects scheduling flexibility and berth throughput."
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reservation_created_timestamp)
      comment: "Month the reservation was created — enables monthly trend analysis of berth demand."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level for the reservation — used for compliance and risk reporting."
  measures:
    - name: "total_berth_reservations"
      expr: COUNT(1)
      comment: "Total number of berth reservations — baseline volume KPI for terminal capacity planning."
    - name: "confirmed_berth_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed berth reservations — measures committed berth schedule and revenue pipeline."
    - name: "cancelled_berth_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled berth reservations — high cancellation rates indicate revenue leakage and scheduling inefficiency."
    - name: "total_berth_utilisation_hours"
      expr: SUM(CAST(berth_utilization_hours AS DOUBLE))
      comment: "Total berth utilisation hours across all reservations — primary KPI for berth throughput and capacity consumption."
    - name: "avg_berth_utilisation_hours"
      expr: AVG(CAST(berth_utilization_hours AS DOUBLE))
      comment: "Average berth utilisation hours per reservation — benchmarks typical vessel stay duration for scheduling optimisation."
    - name: "avg_vessel_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average vessel length overall (LOA) in meters — informs berth length allocation and infrastructure planning."
    - name: "avg_vessel_draft_meters"
      expr: AVG(CAST(draft_meters AS DOUBLE))
      comment: "Average vessel draft in meters — critical for under-keel clearance management and channel depth planning."
    - name: "avg_vessel_dwt_tonnes"
      expr: AVG(CAST(dwt_tonnes AS DOUBLE))
      comment: "Average deadweight tonnage of vessels using berths — indicates cargo capacity mix and port dues revenue potential."
    - name: "avg_under_keel_clearance_meters"
      expr: AVG(CAST(under_keel_clearance_meters AS DOUBLE))
      comment: "Average under-keel clearance in meters — safety KPI; low values indicate risk of grounding and may require dredging investment."
    - name: "dangerous_goods_reservations"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of berth reservations involving dangerous goods — drives HAZMAT berth allocation and emergency response planning."
    - name: "avg_etb_to_etd_planned_stay_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(etd) - UNIX_TIMESTAMP(etb) AS DOUBLE) / 3600.0)
      comment: "Average planned port stay in hours (ETD minus ETB) — baseline for berth scheduling efficiency and turnaround time benchmarking."
    - name: "avg_atb_to_atd_actual_stay_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(atd) - UNIX_TIMESTAMP(atb) AS DOUBLE) / 3600.0)
      comment: "Average actual port stay in hours (ATD minus ATB) — compared against planned stay to measure schedule adherence and operational efficiency."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_cargo_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and operational KPIs for cargo bookings — tracks cargo volume, weight, TEU throughput, special cargo complexity, and booking conversion to support terminal revenue and capacity management."
  source: "`shipping_ports_ecm`.`booking`.`cargo_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the cargo booking (e.g. CONFIRMED, CANCELLED, PENDING) — primary funnel segmentation."
    - name: "service_type"
      expr: service_type
      comment: "Service type for the cargo booking (e.g. IMPORT, EXPORT, TRANSSHIPMENT) — key commercial and operational segmentation."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the cargo booking involves dangerous goods — drives HAZMAT compliance and berth allocation decisions."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the cargo requires temperature control (reefer) — drives reefer plug and cold-chain infrastructure planning."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Whether the cargo is oversized (OOG) — drives special handling and stowage planning."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Whether the cargo is overweight — drives crane and equipment capacity planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the cargo booking — used for cash flow and credit risk analysis."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month of the cargo booking date — enables monthly volume and revenue trend analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code — enables trade lane and destination analysis."
  measures:
    - name: "total_cargo_bookings"
      expr: COUNT(1)
      comment: "Total number of cargo bookings — baseline volume KPI for commercial pipeline and terminal throughput planning."
    - name: "confirmed_cargo_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed cargo bookings — measures committed cargo revenue pipeline."
    - name: "cancelled_cargo_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled cargo bookings — high cancellation rates signal revenue leakage and demand volatility."
    - name: "total_teu_booked"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU (Twenty-foot Equivalent Units) booked — primary container throughput KPI used in port capacity planning and commercial reporting."
    - name: "total_feu_booked"
      expr: SUM(CAST(feu_count AS DOUBLE))
      comment: "Total FEU (Forty-foot Equivalent Units) booked — complements TEU metric for container mix analysis."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross cargo weight in kilograms — drives berth load planning, crane capacity allocation, and port dues calculation."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres — used for yard space planning and stowage optimisation."
    - name: "avg_teu_per_booking"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU per cargo booking — measures booking size and helps identify high-value vs. small-lot customers."
    - name: "avg_gross_weight_per_booking_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per cargo booking in kg — benchmarks typical cargo density for equipment and berth planning."
    - name: "dangerous_goods_bookings"
      expr: COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END)
      comment: "Number of cargo bookings involving dangerous goods — drives HAZMAT compliance resource allocation and risk exposure reporting."
    - name: "reefer_cargo_bookings"
      expr: COUNT(CASE WHEN is_temperature_controlled = TRUE THEN 1 END)
      comment: "Number of temperature-controlled (reefer) cargo bookings — drives reefer plug capacity planning and cold-chain infrastructure investment decisions."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT masterdata_shipping_line_id)
      comment: "Number of distinct shipping lines with cargo bookings — measures commercial diversity and customer concentration risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_voyage_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for voyage nominations — tracks nomination pipeline, TEU volume commitments, acceptance rates, and service complexity to support commercial planning and vessel scheduling."
  source: "`shipping_ports_ecm`.`booking`.`voyage_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the voyage nomination (e.g. ACCEPTED, REJECTED, PENDING) — primary lifecycle segmentation for pipeline analysis."
    - name: "nomination_source"
      expr: nomination_source
      comment: "Source channel of the nomination (e.g. EDI, PORTAL, MANUAL) — used to assess digital adoption and operational efficiency."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required for the nominated voyage — drives pilot resource demand forecasting."
    - name: "towage_required"
      expr: towage_required
      comment: "Whether towage is required for the nominated voyage — drives tug fleet demand forecasting."
    - name: "next_port_of_call"
      expr: next_port_of_call
      comment: "Next port of call after this port — enables trade route and connectivity analysis."
    - name: "nomination_month"
      expr: DATE_TRUNC('MONTH', nomination_received_timestamp)
      comment: "Month the nomination was received — enables monthly trend analysis of nomination volumes."
  measures:
    - name: "total_voyage_nominations"
      expr: COUNT(1)
      comment: "Total number of voyage nominations received — baseline volume KPI for commercial pipeline and vessel scheduling demand."
    - name: "accepted_nominations"
      expr: COUNT(CASE WHEN nomination_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of accepted voyage nominations — measures confirmed vessel schedule commitments and revenue pipeline."
    - name: "rejected_nominations"
      expr: COUNT(CASE WHEN nomination_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected voyage nominations — high rejection rates signal capacity constraints, compliance issues, or commercial misalignment."
    - name: "total_import_teu_nominated"
      expr: SUM(CAST(import_teu AS DOUBLE))
      comment: "Total import TEU nominated across all voyage nominations — primary import throughput demand signal for terminal planning."
    - name: "total_export_teu_nominated"
      expr: SUM(CAST(export_teu AS DOUBLE))
      comment: "Total export TEU nominated — primary export throughput demand signal for yard and crane planning."
    - name: "total_transhipment_teu_nominated"
      expr: SUM(CAST(transhipment_teu AS DOUBLE))
      comment: "Total transhipment TEU nominated — measures hub port connectivity value and transhipment revenue potential."
    - name: "total_restow_teu_nominated"
      expr: SUM(CAST(restow_teu AS DOUBLE))
      comment: "Total restow TEU nominated — restow moves are non-revenue but consume crane and yard capacity; high values indicate stowage planning inefficiency."
    - name: "avg_nomination_to_acceptance_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(acceptance_timestamp) - UNIX_TIMESTAMP(nomination_received_timestamp) AS DOUBLE) / 3600.0)
      comment: "Average time in hours from nomination receipt to acceptance — measures commercial responsiveness; long lead times risk losing vessel calls to competing ports."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines submitting voyage nominations — measures commercial diversity and customer concentration risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_anchorage_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and revenue KPIs for anchorage bookings — tracks anchorage demand, duration variances, charge revenue, and special cargo risk to support marine operations planning and anchorage revenue management."
  source: "`shipping_ports_ecm`.`booking`.`anchorage_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the anchorage booking — primary lifecycle segmentation."
    - name: "anchorage_reason_code"
      expr: anchorage_reason_code
      comment: "Reason code for the anchorage (e.g. AWAITING_BERTH, WEATHER, CUSTOMS) — identifies root causes of anchorage demand for operational improvement."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the anchorage booking — used to assess premium service demand."
    - name: "hazmat_cargo_flag"
      expr: hazmat_cargo_flag
      comment: "Whether the anchored vessel carries hazardous materials — drives safety zone and emergency response planning."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Whether the vessel is under quarantine — critical for port health authority reporting and berth allocation."
    - name: "weather_restriction_flag"
      expr: weather_restriction_flag
      comment: "Whether weather restrictions apply to this anchorage — used to analyse weather-driven operational disruptions."
    - name: "security_level"
      expr: security_level
      comment: "Security level declared for the anchorage — used for ISPS compliance and risk reporting."
    - name: "anchorage_charge_currency"
      expr: anchorage_charge_currency
      comment: "Currency of the anchorage charge — used for multi-currency revenue reporting."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_requested_timestamp)
      comment: "Month the anchorage was requested — enables monthly demand trend analysis."
  measures:
    - name: "total_anchorage_bookings"
      expr: COUNT(1)
      comment: "Total number of anchorage bookings — baseline volume KPI for anchorage capacity planning and marine operations management."
    - name: "confirmed_anchorage_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed anchorage bookings — measures committed anchorage schedule and revenue pipeline."
    - name: "cancelled_anchorage_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled anchorage bookings — high cancellation rates indicate revenue leakage and scheduling instability."
    - name: "total_anchorage_charge_amount"
      expr: SUM(CAST(anchorage_charge_amount AS DOUBLE))
      comment: "Total anchorage charge revenue — direct revenue KPI for anchorage services; used in port dues and marine services P&L reporting."
    - name: "avg_anchorage_charge_amount"
      expr: AVG(CAST(anchorage_charge_amount AS DOUBLE))
      comment: "Average anchorage charge per booking — benchmarks pricing effectiveness and identifies under-priced anchorage slots."
    - name: "total_actual_anchorage_duration_hours"
      expr: SUM(CAST(actual_anchorage_duration_hours AS DOUBLE))
      comment: "Total actual anchorage duration in hours — measures total anchorage area consumption for capacity utilisation reporting."
    - name: "avg_actual_anchorage_duration_hours"
      expr: AVG(CAST(actual_anchorage_duration_hours AS DOUBLE))
      comment: "Average actual anchorage duration per booking — benchmarks typical vessel wait time; long durations indicate berth congestion or operational bottlenecks."
    - name: "avg_planned_anchorage_duration_hours"
      expr: AVG(CAST(planned_anchorage_duration_hours AS DOUBLE))
      comment: "Average planned anchorage duration per booking — compared against actual duration to measure planning accuracy and schedule adherence."
    - name: "hazmat_anchorage_bookings"
      expr: COUNT(CASE WHEN hazmat_cargo_flag = TRUE THEN 1 END)
      comment: "Number of anchorage bookings involving hazardous materials — drives HAZMAT safety zone allocation and emergency response resource planning."
    - name: "quarantine_anchorage_bookings"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of anchorage bookings under quarantine — critical for port health authority compliance reporting and biosecurity risk management."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_pre_arrival`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and operational KPIs for pre-arrival notifications — tracks submission timeliness, health and customs clearance rates, cargo declaration completeness, and service demand to support port authority compliance and vessel scheduling."
  source: "`shipping_ports_ecm`.`booking`.`pre_arrival`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the pre-arrival notification submission (e.g. SUBMITTED, ACKNOWLEDGED, REJECTED) — primary compliance lifecycle segmentation."
    - name: "health_declaration_status"
      expr: health_declaration_status
      comment: "Health declaration status for the vessel — critical for port health authority compliance and biosecurity risk reporting."
    - name: "port_health_clearance_status"
      expr: port_health_clearance_status
      comment: "Port health clearance status — measures compliance with health authority requirements before vessel entry."
    - name: "vts_coordination_status"
      expr: vts_coordination_status
      comment: "Vessel Traffic Service coordination status — measures VTS compliance and coordination effectiveness."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level declared in the pre-arrival notification — used for security compliance reporting."
    - name: "dangerous_goods_onboard"
      expr: dangerous_goods_onboard
      comment: "Whether dangerous goods are declared onboard — drives HAZMAT compliance and berth allocation decisions."
    - name: "pilotage_required"
      expr: pilotage_required
      comment: "Whether pilotage is required — drives pilot resource demand forecasting from pre-arrival data."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of pre-arrival submission — enables monthly compliance trend analysis."
  measures:
    - name: "total_pre_arrivals"
      expr: COUNT(1)
      comment: "Total number of pre-arrival notifications — baseline volume KPI for port authority compliance workload and vessel traffic forecasting."
    - name: "acknowledged_pre_arrivals"
      expr: COUNT(CASE WHEN submission_status = 'ACKNOWLEDGED' THEN 1 END)
      comment: "Number of pre-arrival notifications acknowledged by port authority — measures compliance processing throughput."
    - name: "rejected_pre_arrivals"
      expr: COUNT(CASE WHEN submission_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected pre-arrival notifications — high rejection rates indicate data quality issues or non-compliant submissions, creating vessel delay risk."
    - name: "total_declared_cargo_weight_tonnes"
      expr: SUM(CAST(total_cargo_weight_tonnes AS DOUBLE))
      comment: "Total cargo weight declared in pre-arrival notifications in tonnes — provides advance cargo demand signal for berth and equipment planning."
    - name: "total_declared_teu"
      expr: SUM(CAST(total_teu AS DOUBLE))
      comment: "Total TEU declared in pre-arrival notifications — advance container volume signal for yard and crane planning."
    - name: "avg_submission_to_eta_lead_time_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(eta) - UNIX_TIMESTAMP(submission_timestamp) AS DOUBLE) / 3600.0)
      comment: "Average lead time in hours between pre-arrival submission and ETA — measures compliance with advance notification requirements; short lead times indicate late submissions that risk port authority penalties."
    - name: "dangerous_goods_pre_arrivals"
      expr: COUNT(CASE WHEN dangerous_goods_onboard = TRUE THEN 1 END)
      comment: "Number of pre-arrivals declaring dangerous goods onboard — drives HAZMAT berth allocation and emergency response pre-positioning."
    - name: "waste_disposal_required_pre_arrivals"
      expr: COUNT(CASE WHEN waste_disposal_required = TRUE THEN 1 END)
      comment: "Number of pre-arrivals requiring waste disposal services — drives environmental compliance service scheduling and MARPOL reporting."
    - name: "bunker_fuel_required_pre_arrivals"
      expr: COUNT(CASE WHEN bunker_fuel_required = TRUE THEN 1 END)
      comment: "Number of pre-arrivals requiring bunkering — drives fuel supply scheduling and commercial bunkering revenue forecasting."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service delivery and cost KPIs for booking service orders — tracks service execution performance, cost variance, SLA compliance, and hazardous cargo handling to support operational efficiency and service quality management."
  source: "`shipping_ports_ecm`.`booking`.`booking_service_order`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service order (e.g. COMPLETED, CANCELLED, IN_PROGRESS) — primary lifecycle segmentation for service delivery analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service order — used to assess premium service demand and SLA compliance by tier."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the service order met its SLA — primary quality KPI for service delivery performance management."
    - name: "hazardous_cargo_flag"
      expr: hazardous_cargo_flag
      comment: "Whether the service order involves hazardous cargo — drives HAZMAT compliance and safety resource allocation."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether environmental compliance requirements apply — used for sustainability and regulatory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the service order cost — used for multi-currency financial reporting."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level for the service order — used for compliance and risk segmentation."
    - name: "service_order_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service order was created — enables monthly service volume and cost trend analysis."
  measures:
    - name: "total_service_orders"
      expr: COUNT(1)
      comment: "Total number of booking service orders — baseline volume KPI for service demand planning and operational workload management."
    - name: "sla_compliant_service_orders"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of service orders meeting SLA — measures service quality and contractual compliance; directly impacts customer satisfaction and penalty exposure."
    - name: "sla_breached_service_orders"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Number of service orders breaching SLA — high breach counts trigger penalty clauses and customer churn risk; key operational quality KPI."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of service orders — primary cost KPI for service operations P&L and budget variance analysis."
    - name: "total_estimated_cost_amount"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of service orders — compared against actual cost to measure cost estimation accuracy and budget adherence."
    - name: "avg_actual_cost_per_service_order"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per service order — benchmarks unit service cost for pricing and margin analysis."
    - name: "total_service_quantity"
      expr: SUM(CAST(service_quantity AS DOUBLE))
      comment: "Total service quantity delivered across all orders — measures operational throughput volume for capacity and resource planning."
    - name: "hazardous_cargo_service_orders"
      expr: COUNT(CASE WHEN hazardous_cargo_flag = TRUE THEN 1 END)
      comment: "Number of service orders involving hazardous cargo — drives HAZMAT-certified crew allocation and compliance reporting."
    - name: "cancelled_service_orders"
      expr: COUNT(CASE WHEN service_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled service orders — high cancellation rates indicate revenue leakage and operational planning inefficiency."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_slot_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container slot and stowage KPIs for slot reservations — tracks TEU allocation, reefer demand, transshipment volumes, VGM compliance, and slot revenue to support vessel stowage planning and commercial slot management."
  source: "`shipping_ports_ecm`.`booking`.`slot_reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the slot reservation (e.g. CONFIRMED, CANCELLED, EXPIRED) — primary lifecycle segmentation."
    - name: "slot_type"
      expr: slot_type
      comment: "Type of slot reserved (e.g. IMPORT, EXPORT, TRANSSHIPMENT) — key commercial and operational segmentation."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the slot allocation (e.g. MANUAL, AUTOMATED, EDI) — used to assess digital adoption and allocation efficiency."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority of the slot allocation — used to assess premium slot demand and revenue optimisation."
    - name: "reefer_required"
      expr: reefer_required
      comment: "Whether a reefer slot is required — drives reefer plug capacity planning and cold-chain infrastructure investment."
    - name: "transshipment_indicator"
      expr: transshipment_indicator
      comment: "Whether the slot is for a transshipment container — measures hub port connectivity value."
    - name: "restow_indicator"
      expr: restow_indicator
      comment: "Whether the slot involves a restow — restow moves consume crane capacity without generating revenue."
    - name: "slot_rate_currency"
      expr: slot_rate_currency
      comment: "Currency of the slot rate — used for multi-currency revenue reporting."
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reserved_at)
      comment: "Month the slot was reserved — enables monthly slot demand and revenue trend analysis."
    - name: "port_of_discharge"
      expr: port_of_discharge
      comment: "Port of discharge for the slot — enables trade lane and destination analysis."
  measures:
    - name: "total_slot_reservations"
      expr: COUNT(1)
      comment: "Total number of slot reservations — baseline volume KPI for vessel stowage planning and commercial slot management."
    - name: "confirmed_slot_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed slot reservations — measures committed vessel capacity utilisation and revenue pipeline."
    - name: "cancelled_slot_reservations"
      expr: COUNT(CASE WHEN reservation_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled slot reservations — high cancellation rates indicate revenue leakage and vessel capacity wastage."
    - name: "total_teu_reserved"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU reserved across all slot reservations — primary vessel capacity utilisation KPI for stowage planning and commercial reporting."
    - name: "total_slot_revenue"
      expr: SUM(CAST(slot_rate_amount AS DOUBLE))
      comment: "Total slot rate revenue across all reservations — direct commercial revenue KPI for slot management and pricing strategy."
    - name: "avg_slot_rate_amount"
      expr: AVG(CAST(slot_rate_amount AS DOUBLE))
      comment: "Average slot rate per reservation — benchmarks pricing effectiveness and identifies yield optimisation opportunities."
    - name: "total_verified_gross_mass_kg"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass (VGM) in kg across all slot reservations — SOLAS compliance KPI; ensures vessel stability and regulatory adherence."
    - name: "vgm_verified_slots"
      expr: COUNT(CASE WHEN vgm_verified_at IS NOT NULL THEN 1 END)
      comment: "Number of slot reservations with VGM verified — measures SOLAS VGM compliance rate; unverified slots cannot be loaded and create operational delays."
    - name: "reefer_slot_reservations"
      expr: COUNT(CASE WHEN reefer_required = TRUE THEN 1 END)
      comment: "Number of reefer slot reservations — drives reefer plug capacity planning and cold-chain infrastructure investment decisions."
    - name: "transshipment_slot_reservations"
      expr: COUNT(CASE WHEN transshipment_indicator = TRUE THEN 1 END)
      comment: "Number of transshipment slot reservations — measures hub port connectivity value and transshipment revenue contribution."
    - name: "restow_slot_reservations"
      expr: COUNT(CASE WHEN restow_indicator = TRUE THEN 1 END)
      comment: "Number of restow slot reservations — restow moves are non-revenue but consume crane and yard capacity; high values indicate stowage planning inefficiency requiring corrective action."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_truck_gate_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate throughput and compliance KPIs for truck gate bookings — tracks appointment utilisation, no-show rates, hazardous cargo handling, and gate processing efficiency to support terminal gate operations and landside logistics management."
  source: "`shipping_ports_ecm`.`booking`.`truck_gate_booking`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the truck gate appointment (e.g. CONFIRMED, COMPLETED, NO_SHOW, CANCELLED) — primary lifecycle segmentation for gate throughput analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of truck gate appointment (e.g. IMPORT_PICKUP, EXPORT_DROP, EMPTY_RETURN) — key operational segmentation for gate lane planning."
    - name: "is_hazardous_cargo"
      expr: is_hazardous_cargo
      comment: "Whether the truck is carrying hazardous cargo — drives HAZMAT gate lane allocation and compliance checks."
    - name: "is_refrigerated"
      expr: is_refrigerated
      comment: "Whether the cargo is refrigerated — drives reefer inspection and cold-chain gate processing planning."
    - name: "is_oversize"
      expr: is_oversize
      comment: "Whether the cargo is oversize — drives special gate lane and escort planning."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the truck did not show for its appointment — high no-show rates waste gate capacity and disrupt terminal operations."
    - name: "container_condition"
      expr: container_condition
      comment: "Condition of the container at gate — used for damage reporting and equipment quality management."
    - name: "appointment_date_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of the truck gate appointment — enables monthly gate throughput trend analysis."
  measures:
    - name: "total_truck_gate_bookings"
      expr: COUNT(1)
      comment: "Total number of truck gate bookings — baseline volume KPI for gate capacity planning and landside logistics management."
    - name: "completed_gate_bookings"
      expr: COUNT(CASE WHEN appointment_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed truck gate appointments — measures effective gate throughput and terminal accessibility."
    - name: "no_show_gate_bookings"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of truck gate no-shows — no-shows waste gate slot capacity and disrupt terminal flow; high rates trigger appointment policy reviews."
    - name: "cancelled_gate_bookings"
      expr: COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled truck gate bookings — high cancellation rates indicate demand volatility and gate capacity wastage."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight processed through the gate in kg — measures landside cargo throughput volume for weighbridge and gate capacity planning."
    - name: "avg_cargo_weight_per_truck_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per truck gate booking in kg — benchmarks typical truck load for weighbridge and axle load compliance planning."
    - name: "hazardous_cargo_gate_bookings"
      expr: COUNT(CASE WHEN is_hazardous_cargo = TRUE THEN 1 END)
      comment: "Number of truck gate bookings involving hazardous cargo — drives HAZMAT gate lane allocation and compliance inspection resource planning."
    - name: "reefer_gate_bookings"
      expr: COUNT(CASE WHEN is_refrigerated = TRUE THEN 1 END)
      comment: "Number of refrigerated cargo truck gate bookings — drives reefer inspection staffing and cold-chain gate processing planning."
    - name: "distinct_trucking_companies"
      expr: COUNT(DISTINCT trucking_company_port_community_participant_id)
      comment: "Number of distinct trucking companies using the gate — measures landside customer diversity and dependency concentration risk."
$$;