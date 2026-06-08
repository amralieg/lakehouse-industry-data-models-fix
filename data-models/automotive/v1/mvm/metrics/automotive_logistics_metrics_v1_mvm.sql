-- Metric views for domain: logistics | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance KPIs including on-time delivery rates, cost efficiency, and transit time compliance for strategic carrier management and contract negotiations"
  source: "`automotive_ecm`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "performance_month"
      expr: performance_month
      comment: "Month of performance measurement for trend analysis"
    - name: "performance_year"
      expr: YEAR(performance_month)
      comment: "Year of performance measurement"
    - name: "performance_quarter"
      expr: CONCAT('Q', QUARTER(performance_month), '-', YEAR(performance_month))
      comment: "Quarter of performance measurement"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (road, rail, sea, air)"
    - name: "lane_type"
      expr: lane_type
      comment: "Type of shipping lane"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall carrier performance rating"
    - name: "carrier_performance_status"
      expr: carrier_performance_status
      comment: "Status of carrier performance record"
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Total number of carrier performance records"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate percentage across all carriers - key KPI for carrier reliability"
    - name: "avg_cost_per_shipment"
      expr: AVG(CAST(cost_per_shipment_usd AS DOUBLE))
      comment: "Average cost per shipment in USD - critical for cost optimization and carrier selection"
    - name: "avg_transit_days"
      expr: AVG(CAST(average_transit_days AS DOUBLE))
      comment: "Average transit time in days - key metric for supply chain velocity"
    - name: "avg_fuel_consumption"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption per 100km - sustainability and cost efficiency metric"
    - name: "total_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total distance traveled in kilometers - volume metric for carrier utilization"
    - name: "avg_transit_time_compliance"
      expr: AVG(CAST(transit_time_compliance_pct AS DOUBLE))
      comment: "Average transit time compliance percentage - operational excellence KPI"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers evaluated - carrier network diversity metric"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_in_transit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory KPIs tracking vehicles in motion, transit times, costs, and environmental impact for working capital and supply chain velocity optimization"
  source: "`automotive_ecm`.`logistics`.`in_transit_inventory`"
  dimensions:
    - name: "transit_status"
      expr: transit_status
      comment: "Current status of in-transit inventory"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status"
    - name: "load_type"
      expr: load_type
      comment: "Type of load configuration"
    - name: "origin_facility"
      expr: origin_facility_code
      comment: "Origin facility code"
    - name: "destination_facility"
      expr: destination_facility_code
      comment: "Destination facility code"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if shipment contains hazardous materials"
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Indicates if temperature control is required"
    - name: "estimated_arrival_month"
      expr: DATE_TRUNC('MONTH', estimated_arrival_date)
      comment: "Month of estimated arrival"
  measures:
    - name: "total_units_in_transit"
      expr: COUNT(1)
      comment: "Total number of units currently in transit - key working capital metric"
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transportation cost - critical for logistics spend management"
    - name: "avg_transport_cost_per_unit"
      expr: AVG(CAST(transport_cost_amount AS DOUBLE))
      comment: "Average transportation cost per unit - efficiency benchmark"
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight in tons of in-transit inventory - capacity utilization metric"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume in cubic meters - space utilization metric"
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions in kg - environmental sustainability KPI"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumption in liters - cost and sustainability metric"
    - name: "distinct_shipments"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Number of unique shipments in transit"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers utilized"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles in transit"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution KPIs including on-time delivery performance, freight costs, and shipment volumes for operational excellence and cost management"
  source: "`automotive_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "load_type"
      expr: load_type
      comment: "Type of load"
    - name: "origin_location"
      expr: origin_location
      comment: "Origin location of shipment"
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location of shipment"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of shipment"
    - name: "on_time_delivery_flag"
      expr: otd_flag
      comment: "Flag indicating if shipment was delivered on time"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if shipment contains hazardous materials"
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Indicates if temperature control is required"
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates if shipment is export or import"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('MONTH', planned_departure_date)
      comment: "Month of planned departure"
    - name: "planned_arrival_month"
      expr: DATE_TRUNC('MONTH', planned_arrival_date)
      comment: "Month of planned arrival"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments - volume metric for logistics operations"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost - critical for logistics spend management and budgeting"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment - efficiency benchmark"
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after discounts - actual logistics spend"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount - savings realized from carrier negotiations"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms - capacity utilization metric"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters - space utilization metric"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time deliveries - operational excellence metric"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used"
    - name: "distinct_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of unique routes utilized"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles shipped"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route performance KPIs including on-time performance, cost efficiency, emissions, and fuel consumption for network optimization and sustainability"
  source: "`automotive_ecm`.`logistics`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of route"
    - name: "route_type"
      expr: route_type
      comment: "Type of route"
    - name: "carrier_mode"
      expr: carrier_mode
      comment: "Mode of carrier transportation"
    - name: "destination_location"
      expr: destination_location
      comment: "Destination location"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of route"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of route"
    - name: "is_express"
      expr: is_express
      comment: "Indicates if route is express service"
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Regulatory region for route"
    - name: "route_group"
      expr: route_group
      comment: "Route grouping for analysis"
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of routes - network coverage metric"
    - name: "total_route_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total route cost in USD - critical for network cost optimization"
    - name: "avg_route_cost"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average route cost - efficiency benchmark"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance in kilometers - network scale metric"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average route distance - network design metric"
    - name: "avg_on_time_performance_pct"
      expr: AVG(CAST(on_time_performance_pct AS DOUBLE))
      comment: "Average on-time performance percentage - key service level KPI"
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions in kg - environmental sustainability KPI for carbon footprint management"
    - name: "avg_fuel_consumption_per_100km"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption per 100km - efficiency and sustainability metric"
    - name: "total_max_load_capacity_tons"
      expr: SUM(CAST(max_load_capacity_tons AS DOUBLE))
      comment: "Total maximum load capacity in tons - network capacity metric"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers on routes"
    - name: "distinct_origin_plants"
      expr: COUNT(DISTINCT origin_plant_id)
      comment: "Number of unique origin plants"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_vehicle_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle transport order KPIs including order fulfillment, on-time delivery, transport costs, and emissions for finished vehicle logistics management"
  source: "`automotive_ecm`.`logistics`.`vehicle_transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of transport order"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "priority"
      expr: priority
      comment: "Priority level of order"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Indicates if order is expedited"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates if order contains hazardous materials"
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Flag indicating if order was delivered on time"
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates if order is export or import"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used for transport"
    - name: "container_type"
      expr: container_type
      comment: "Type of container used"
    - name: "requested_pickup_month"
      expr: DATE_TRUNC('MONTH', requested_pickup_date)
      comment: "Month of requested pickup"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of delivery"
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle transport orders - volume metric for finished vehicle logistics"
    - name: "total_transport_cost_gross"
      expr: SUM(CAST(transport_cost_gross AS DOUBLE))
      comment: "Total gross transport cost - critical for finished vehicle logistics spend management"
    - name: "total_transport_cost_net"
      expr: SUM(CAST(transport_cost_net AS DOUBLE))
      comment: "Total net transport cost after tax - actual logistics spend"
    - name: "total_transport_cost_tax"
      expr: SUM(CAST(transport_cost_tax AS DOUBLE))
      comment: "Total transport tax amount - tax burden metric"
    - name: "avg_transport_cost_per_order"
      expr: AVG(CAST(transport_cost_net AS DOUBLE))
      comment: "Average net transport cost per order - efficiency benchmark"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance in kilometers - network utilization metric"
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight in tons - capacity utilization metric"
    - name: "total_emissions_co2_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions in kg - environmental sustainability KPI for carbon footprint reporting"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time deliveries - service level metric"
    - name: "expedited_order_count"
      expr: SUM(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END)
      comment: "Count of expedited orders - urgency metric"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers utilized"
    - name: "distinct_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of unique routes used"
    - name: "distinct_plants"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique origin plants"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel voyage KPIs including capacity utilization, voyage costs, and schedule adherence for maritime logistics optimization"
  source: "`automotive_ecm`.`logistics`.`vessel_voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Current status of vessel voyage"
    - name: "voyage_type"
      expr: voyage_type
      comment: "Type of voyage"
    - name: "origin_port"
      expr: origin_port_code
      comment: "Origin port code"
    - name: "destination_port"
      expr: destination_port_code
      comment: "Destination port code"
    - name: "vessel_name"
      expr: vessel_name
      comment: "Name of vessel"
    - name: "planned_departure_month"
      expr: DATE_TRUNC('MONTH', planned_departure_timestamp)
      comment: "Month of planned departure"
    - name: "planned_arrival_month"
      expr: DATE_TRUNC('MONTH', planned_arrival_timestamp)
      comment: "Month of planned arrival"
  measures:
    - name: "total_voyages"
      expr: COUNT(1)
      comment: "Total number of vessel voyages - maritime logistics volume metric"
    - name: "total_voyage_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total voyage cost - critical for maritime logistics spend management"
    - name: "avg_voyage_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per voyage - efficiency benchmark"
    - name: "distinct_vessels"
      expr: COUNT(DISTINCT vessel_name)
      comment: "Number of unique vessels utilized - fleet diversity metric"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique maritime carriers"
    - name: "distinct_origin_ports"
      expr: COUNT(DISTINCT origin_port_code)
      comment: "Number of unique origin ports - network coverage metric"
    - name: "distinct_destination_ports"
      expr: COUNT(DISTINCT destination_port_code)
      comment: "Number of unique destination ports - network reach metric"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_vehicle_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle handover KPIs including handover completion rates, fees, and on-time delivery for last-mile logistics and customer delivery performance"
  source: "`automotive_ecm`.`logistics`.`vehicle_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Current status of vehicle handover"
    - name: "handover_type"
      expr: handover_type
      comment: "Type of handover"
    - name: "handover_location"
      expr: handover_location
      comment: "Location of handover"
    - name: "handover_condition"
      expr: handover_condition
      comment: "Condition of vehicle at handover"
    - name: "receiving_party_type"
      expr: receiving_party_type
      comment: "Type of receiving party"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation"
    - name: "on_time_delivery_flag"
      expr: otd_flag
      comment: "Flag indicating if handover was on time"
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates if handover involves export or import"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if vehicle contains hazardous materials"
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Indicates if temperature control was required"
    - name: "handover_month"
      expr: DATE_TRUNC('MONTH', handover_timestamp)
      comment: "Month of handover"
  measures:
    - name: "total_handovers"
      expr: COUNT(1)
      comment: "Total number of vehicle handovers - last-mile delivery volume metric"
    - name: "total_handover_fees"
      expr: SUM(CAST(handover_fee_amount AS DOUBLE))
      comment: "Total handover fee amount - last-mile logistics revenue or cost metric"
    - name: "total_handover_fees_net"
      expr: SUM(CAST(handover_fee_net_amount AS DOUBLE))
      comment: "Total net handover fees after tax - actual revenue or cost"
    - name: "total_handover_fees_tax"
      expr: SUM(CAST(handover_fee_tax_amount AS DOUBLE))
      comment: "Total handover fee tax amount - tax burden metric"
    - name: "avg_handover_fee"
      expr: AVG(CAST(handover_fee_amount AS DOUBLE))
      comment: "Average handover fee per transaction - pricing benchmark"
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions in kg - environmental impact of last-mile delivery"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumption in liters - last-mile efficiency metric"
    - name: "avg_odometer_reading_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at handover - vehicle usage metric"
    - name: "on_time_handover_count"
      expr: SUM(CASE WHEN otd_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of on-time handovers - customer service level KPI"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles handed over"
    - name: "distinct_receiving_parties"
      expr: COUNT(DISTINCT receiving_party_id)
      comment: "Number of unique receiving parties - customer reach metric"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master data KPIs including carrier performance ratings, cost benchmarks, and fleet capacity for strategic carrier management and sourcing decisions"
  source: "`automotive_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current status of carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier"
    - name: "carrier_tier"
      expr: carrier_tier
      comment: "Tier classification of carrier"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating of carrier"
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification status"
    - name: "iatf_compliance_status"
      expr: iatf_compliance_status
      comment: "IATF 16949 compliance status"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment operated"
    - name: "fleet_size"
      expr: fleet_size
      comment: "Size of carrier fleet"
    - name: "operating_regions"
      expr: operating_regions
      comment: "Regions where carrier operates"
    - name: "country"
      expr: country
      comment: "Country of carrier"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers - carrier network size metric"
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(average_cost_per_mile AS DOUBLE))
      comment: "Average cost per mile across carriers - critical benchmark for carrier rate negotiations"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(average_on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage - key carrier reliability KPI for sourcing decisions"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average carrier performance rating - strategic carrier management metric"
    - name: "active_carrier_count"
      expr: SUM(CASE WHEN carrier_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active carriers - available carrier capacity metric"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country)
      comment: "Number of countries with carrier presence - geographic diversity metric"
$$;