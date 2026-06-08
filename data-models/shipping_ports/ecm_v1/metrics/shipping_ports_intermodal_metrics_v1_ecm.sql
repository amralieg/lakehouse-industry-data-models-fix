-- Metric views for domain: intermodal | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_drayage_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for drayage operations including on-time delivery, order cycle time, and container handling efficiency"
  source: "`shipping_ports_ecm`.`intermodal`.`drayage_order`"
  dimensions:
    - name: "drayage_status"
      expr: drayage_status
      comment: "Current status of the drayage order (e.g., scheduled, in-transit, completed, cancelled)"
    - name: "drayage_type"
      expr: drayage_type
      comment: "Type of drayage movement (e.g., import, export, street turn, repositioning)"
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (e.g., vessel, rail, warehouse, ICD)"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location (e.g., vessel, rail, warehouse, customer site)"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether the container contains hazardous materials requiring special handling"
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Whether the container is refrigerated requiring temperature control"
    - name: "overweight_indicator"
      expr: overweight_indicator
      comment: "Whether the container exceeds standard weight limits"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the drayage order affecting scheduling and resource allocation"
    - name: "scheduled_pickup_date"
      expr: scheduled_pickup_date
      comment: "Planned date for container pickup"
    - name: "scheduled_delivery_date"
      expr: scheduled_delivery_date
      comment: "Planned date for container delivery"
    - name: "proof_of_delivery_received"
      expr: proof_of_delivery_received
      comment: "Whether proof of delivery documentation has been received"
  measures:
    - name: "total_drayage_orders"
      expr: COUNT(1)
      comment: "Total number of drayage orders executed"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_time_window_end THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of drayage orders delivered within the scheduled time window - critical KPI for service level agreement compliance and customer satisfaction"
    - name: "avg_drayage_cycle_time_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(actual_delivery_timestamp) - UNIX_TIMESTAMP(actual_pickup_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average time in hours from container pickup to delivery - key efficiency metric for drayage operations optimization"
    - name: "total_verified_gross_mass_kg"
      expr: SUM(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass of all containers handled in kilograms - important for capacity planning and safety compliance"
    - name: "avg_verified_gross_mass_kg"
      expr: AVG(CAST(verified_gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per container in kilograms - used for equipment sizing and route planning"
    - name: "hazmat_order_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Number of drayage orders involving hazardous materials - critical for safety resource allocation and regulatory compliance"
    - name: "reefer_order_count"
      expr: COUNT(CASE WHEN reefer_indicator = TRUE THEN 1 END)
      comment: "Number of refrigerated container orders - important for specialized equipment and energy cost planning"
    - name: "overweight_order_count"
      expr: COUNT(CASE WHEN overweight_indicator = TRUE THEN 1 END)
      comment: "Number of overweight container orders - key for permit management and route optimization"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drayage_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drayage orders cancelled - indicator of planning accuracy and customer commitment"
    - name: "failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN failure_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drayage orders that failed to complete - critical quality metric for operational excellence"
    - name: "pod_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN proof_of_delivery_received = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed deliveries with proof of delivery received - important for billing accuracy and dispute resolution"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for multimodal transport order management including order fulfillment, cargo volume, and service quality metrics"
  source: "`shipping_ports_ecm`.`intermodal`.`transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the transport order in its lifecycle"
    - name: "primary_transport_mode"
      expr: primary_transport_mode
      comment: "Primary mode of transport (e.g., road, rail, vessel, air)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the transport order"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the cargo is classified as hazardous"
    - name: "is_refrigerated"
      expr: is_refrigerated
      comment: "Whether the cargo requires refrigeration"
    - name: "origin_location"
      expr: origin_location
      comment: "Origin location of the transport order"
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of the transport order"
    - name: "order_date"
      expr: DATE(order_date)
      comment: "Date when the transport order was created"
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of transport orders processed"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total weight of cargo transported in kilograms - key throughput metric for capacity utilization"
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total volume of cargo transported in cubic meters - critical for space utilization and revenue optimization"
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total twenty-foot equivalent units handled - standard industry metric for container throughput"
    - name: "avg_cargo_weight_kg"
      expr: AVG(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Average cargo weight per transport order in kilograms"
    - name: "avg_teu_per_order"
      expr: AVG(CAST(teu_count AS DOUBLE))
      comment: "Average TEU count per transport order - indicator of order consolidation efficiency"
    - name: "on_time_pickup_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_pickup_date <= estimated_pickup_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_pickup_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of transport orders picked up on or before estimated time - key service quality metric"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of transport orders delivered on or before estimated time - critical customer satisfaction KPI"
    - name: "order_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status IN ('completed', 'delivered') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transport orders successfully completed - primary operational success metric"
    - name: "hazardous_cargo_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders involving hazardous cargo - important for safety resource planning and compliance"
    - name: "reefer_cargo_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refrigerated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders requiring refrigeration - key for specialized equipment investment decisions"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_truck_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for truck appointment system including slot utilization, no-show rates, and gate efficiency metrics"
  source: "`shipping_ports_ecm`.`intermodal`.`truck_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the truck appointment (e.g., scheduled, confirmed, completed, cancelled, no-show)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (e.g., import pickup, export drop-off, empty return)"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (e.g., web portal, EDI, phone)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the appointment"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the appointment involves hazardous cargo"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Whether the appointment involves refrigerated containers"
    - name: "is_oversized"
      expr: is_oversized
      comment: "Whether the appointment involves oversized cargo"
    - name: "is_overweight"
      expr: is_overweight
      comment: "Whether the appointment involves overweight cargo"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the truck failed to arrive for the scheduled appointment"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of truck appointments scheduled"
    - name: "appointment_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status IN ('completed', 'in-progress') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled appointments that were utilized - critical metric for gate capacity planning and revenue optimization"
    - name: "no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments where trucks failed to arrive - key indicator of capacity waste and customer reliability"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled - indicator of planning volatility and slot availability"
    - name: "avg_turnaround_time_minutes"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(actual_departure_time) - UNIX_TIMESTAMP(actual_arrival_time)) / 60.0 AS DOUBLE)), 2)
      comment: "Average time in minutes from truck arrival to departure - critical efficiency metric for gate operations and customer satisfaction"
    - name: "total_teu_quantity"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU volume handled through appointments - key throughput metric for capacity utilization"
    - name: "avg_teu_per_appointment"
      expr: AVG(CAST(teu_quantity AS DOUBLE))
      comment: "Average TEU per appointment - indicator of load consolidation efficiency"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight handled through appointments in kilograms"
    - name: "on_time_arrival_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_time BETWEEN requested_slot_start_time AND requested_slot_end_time THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_time IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of trucks arriving within their scheduled time slot - key metric for appointment system effectiveness"
    - name: "hazmat_appointment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments involving hazardous materials - important for safety resource allocation"
    - name: "reefer_appointment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reefer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments involving refrigerated containers - key for specialized handling capacity planning"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_rail_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for rail operations including train utilization, on-time performance, and container throughput efficiency"
  source: "`shipping_ports_ecm`.`intermodal`.`rail_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the rail visit (e.g., scheduled, arrived, in-progress, departed, completed)"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of rail visit (e.g., import, export, mixed)"
    - name: "service_type"
      expr: service_type
      comment: "Type of rail service (e.g., scheduled, ad-hoc, shuttle)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the rail visit"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether the rail visit involves hazardous materials"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the rail visit"
    - name: "origin_location"
      expr: origin_location
      comment: "Origin location of the rail service"
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of the rail service"
  measures:
    - name: "total_rail_visits"
      expr: COUNT(1)
      comment: "Total number of rail visits processed"
    - name: "total_train_weight_tonnes"
      expr: SUM(CAST(train_weight_tonnes AS DOUBLE))
      comment: "Total weight of trains handled in tonnes - key capacity utilization metric"
    - name: "avg_train_weight_tonnes"
      expr: AVG(CAST(train_weight_tonnes AS DOUBLE))
      comment: "Average train weight in tonnes - indicator of load optimization"
    - name: "avg_train_length_meters"
      expr: AVG(CAST(train_length_meters AS DOUBLE))
      comment: "Average train length in meters - important for track capacity planning"
    - name: "total_teu_loaded"
      expr: SUM(CAST(teu_loaded AS DOUBLE))
      comment: "Total TEU loaded onto trains - critical throughput metric for export operations"
    - name: "total_teu_discharged"
      expr: SUM(CAST(teu_discharged AS DOUBLE))
      comment: "Total TEU discharged from trains - critical throughput metric for import operations"
    - name: "avg_teu_per_visit"
      expr: AVG(CAST((CAST(teu_loaded AS DOUBLE) + CAST(teu_discharged AS DOUBLE)) AS DOUBLE))
      comment: "Average total TEU handled per rail visit - key efficiency metric for rail operations"
    - name: "rail_utilization_rate"
      expr: ROUND(100.0 * AVG(CAST((CAST(teu_loaded AS DOUBLE) + CAST(teu_discharged AS DOUBLE)) AS DOUBLE)) / NULLIF(AVG(CAST(teu_capacity AS DOUBLE)), 0), 2)
      comment: "Average percentage of rail capacity utilized - critical metric for asset utilization and revenue optimization"
    - name: "on_time_arrival_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_time <= scheduled_arrival_time THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_time IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of trains arriving on or before scheduled time - key service quality and operational efficiency metric"
    - name: "on_time_departure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_departure_time <= scheduled_departure_time THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_departure_time IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of trains departing on or before scheduled time - critical for network reliability and customer satisfaction"
    - name: "avg_dwell_time_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(actual_departure_time) - UNIX_TIMESTAMP(actual_arrival_time)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average time in hours trains spend at the terminal - key efficiency metric for terminal operations and capacity planning"
    - name: "hazmat_visit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rail visits involving hazardous materials - important for safety compliance and resource allocation"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_icd_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for inland container depot facility performance including capacity utilization, service quality, and operational efficiency"
  source: "`shipping_ports_ecm`.`intermodal`.`icd_facility`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the ICD facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of ICD facility (e.g., dry port, CFS, bonded warehouse)"
    - name: "customs_bonded_facility"
      expr: customs_bonded_facility
      comment: "Whether the facility is customs bonded"
    - name: "dangerous_goods_certified"
      expr: dangerous_goods_certified
      comment: "Whether the facility is certified to handle dangerous goods"
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "Whether the facility is ISPS (International Ship and Port Facility Security) compliant"
    - name: "rail_connectivity"
      expr: rail_connectivity
      comment: "Whether the facility has rail connectivity"
    - name: "fcl_service_available"
      expr: fcl_service_available
      comment: "Whether full container load service is available"
    - name: "lcl_service_available"
      expr: lcl_service_available
      comment: "Whether less than container load service is available"
    - name: "twenty_four_seven_operations"
      expr: twenty_four_seven_operations
      comment: "Whether the facility operates 24/7"
    - name: "country_code"
      expr: country_code
      comment: "Country where the ICD facility is located"
    - name: "city"
      expr: city
      comment: "City where the ICD facility is located"
  measures:
    - name: "total_icd_facilities"
      expr: COUNT(1)
      comment: "Total number of ICD facilities in the network"
    - name: "avg_distance_from_port_km"
      expr: AVG(CAST(distance_from_port_km AS DOUBLE))
      comment: "Average distance of ICD facilities from their serving port in kilometers - key metric for inland logistics efficiency"
    - name: "avg_drayage_time_hours"
      expr: AVG(CAST(average_drayage_time_hours AS DOUBLE))
      comment: "Average drayage time to/from port in hours - critical metric for supply chain velocity and cost optimization"
    - name: "avg_sla_turnaround_time_hours"
      expr: AVG(CAST(sla_turnaround_time_hours AS DOUBLE))
      comment: "Average service level agreement turnaround time in hours - key customer service commitment metric"
    - name: "customs_bonded_facility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_bonded_facility = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are customs bonded - important for duty deferral and trade facilitation capabilities"
    - name: "dangerous_goods_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities certified for dangerous goods - critical for hazmat handling capacity in the network"
    - name: "isps_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN isps_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are ISPS compliant - key security and regulatory compliance metric"
    - name: "rail_connectivity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rail_connectivity = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with rail connectivity - strategic metric for multimodal capability and cost efficiency"
    - name: "twenty_four_seven_operations_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN twenty_four_seven_operations = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities operating 24/7 - important for service flexibility and throughput capacity"
    - name: "fcl_service_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fcl_service_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities offering FCL service - key metric for full container handling capability"
    - name: "lcl_service_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lcl_service_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities offering LCL service - important for cargo consolidation and deconsolidation capability"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for intermodal service performance including service reliability, capacity utilization, and route efficiency"
  source: "`shipping_ports_ecm`.`intermodal`.`service`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the intermodal service (e.g., active, suspended, discontinued)"
    - name: "service_type"
      expr: service_type
      comment: "Type of intermodal service (e.g., scheduled, on-demand, dedicated)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode of the service (e.g., rail, road, barge)"
    - name: "reefer_capable"
      expr: reefer_capable
      comment: "Whether the service can handle refrigerated containers"
    - name: "dangerous_goods_allowed"
      expr: dangerous_goods_allowed
      comment: "Whether the service allows dangerous goods"
    - name: "oversize_cargo_allowed"
      expr: oversize_cargo_allowed
      comment: "Whether the service allows oversized cargo"
    - name: "customs_clearance_supported"
      expr: customs_clearance_supported
      comment: "Whether the service includes customs clearance support"
    - name: "edi_enabled"
      expr: edi_enabled
      comment: "Whether the service supports EDI integration"
    - name: "origin_location"
      expr: service_name
      comment: "Name of the intermodal service"
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of the service"
  measures:
    - name: "total_services"
      expr: COUNT(1)
      comment: "Total number of intermodal services in the network"
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time in hours across all services - key metric for service velocity and competitiveness"
    - name: "avg_route_distance_km"
      expr: AVG(CAST(route_distance_km AS DOUBLE))
      comment: "Average route distance in kilometers - important for cost modeling and pricing"
    - name: "avg_sla_on_time_performance_target"
      expr: AVG(CAST(sla_on_time_performance_target AS DOUBLE))
      comment: "Average on-time performance target across services - key service quality commitment metric"
    - name: "reefer_capable_service_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reefer_capable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services capable of handling refrigerated cargo - strategic metric for cold chain capability"
    - name: "dangerous_goods_service_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services allowing dangerous goods - important for hazmat handling network coverage"
    - name: "oversize_cargo_service_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN oversize_cargo_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services allowing oversized cargo - key for project cargo and special handling capability"
    - name: "customs_clearance_service_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_clearance_supported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services offering customs clearance support - important for end-to-end service value proposition"
    - name: "edi_enabled_service_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services with EDI integration - critical for digital supply chain integration and automation"
    - name: "active_service_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services currently active - key metric for network availability and service portfolio health"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`intermodal_slot_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for intermodal slot booking including booking conversion, slot utilization, and customer demand patterns"
  source: "`shipping_ports_ecm`.`intermodal`.`slot_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the slot booking (e.g., requested, confirmed, completed, cancelled)"
    - name: "booking_type"
      expr: booking_type
      comment: "Type of slot booking (e.g., standard, priority, spot)"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the booking was made (e.g., web portal, EDI, API, phone)"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo being booked"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether the booking involves hazardous materials"
    - name: "reefer_indicator"
      expr: reefer_indicator
      comment: "Whether the booking involves refrigerated containers"
    - name: "oversized_indicator"
      expr: oversized_indicator
      comment: "Whether the booking involves oversized cargo"
    - name: "no_show_indicator"
      expr: no_show_indicator
      comment: "Whether the customer failed to show for the booked slot"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the booking"
    - name: "booking_date"
      expr: booking_date
      comment: "Date when the booking was made"
  measures:
    - name: "total_slot_bookings"
      expr: COUNT(1)
      comment: "Total number of slot bookings made"
    - name: "booking_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status IN ('confirmed', 'completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were confirmed - key metric for demand fulfillment and customer satisfaction"
    - name: "booking_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were completed - critical metric for slot utilization and revenue realization"
    - name: "booking_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled - indicator of demand volatility and capacity planning challenges"
    - name: "no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmed bookings where customer failed to show - critical metric for capacity waste and revenue loss"
    - name: "total_teu_booked"
      expr: SUM(CAST(teu_quantity AS DOUBLE))
      comment: "Total TEU quantity booked - key demand and capacity utilization metric"
    - name: "avg_teu_per_booking"
      expr: AVG(CAST(teu_quantity AS DOUBLE))
      comment: "Average TEU per booking - indicator of booking size and consolidation patterns"
    - name: "total_weight_tonnes"
      expr: SUM(CAST(weight_tonnes AS DOUBLE))
      comment: "Total weight booked in tonnes - important for capacity planning and equipment sizing"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume booked in cubic meters - key metric for space utilization"
    - name: "avg_booking_lead_time_days"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(requested_transport_date) - UNIX_TIMESTAMP(booking_date)) / 86400.0 AS DOUBLE)), 2)
      comment: "Average days between booking and requested transport date - important for demand forecasting and capacity planning"
    - name: "hazmat_booking_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings involving hazardous materials - key for safety resource allocation"
    - name: "reefer_booking_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reefer_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings involving refrigerated containers - important for specialized equipment planning"
$$;