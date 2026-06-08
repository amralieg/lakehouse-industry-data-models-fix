-- Metric views for domain: fulfillment | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for fulfillment orders, supporting operational and strategic decisions around timeliness, weight, and volume."
  source: "`grocery_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of order creation (day level)"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier handling the order"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where the order originated"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment order"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment (e.g., delivery, pickup)"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone required for the order"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Sum of order weight in kilograms across all orders"
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Sum of order volume in cubic meters"
    - name: "average_order_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per order (kg)"
    - name: "average_order_volume_m3"
      expr: AVG(CAST(total_volume_m3 AS DOUBLE))
      comment: "Average volume per order (m3)"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN delivery_timestamp <= sla_due_timestamp THEN 1 ELSE 0 END)
      comment: "Count of orders delivered on or before SLA due timestamp"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level KPIs that drive cost management and delivery performance."
  source: "`grocery_ecm`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the shipment record was created"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier responsible for the shipment"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., standard, expedited)"
    - name: "origin_node_id"
      expr: origin_location_type
      comment: "Origin location type identifier"
    - name: "destination_node_id"
      expr: destination_location_type
      comment: "Destination location type identifier"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across shipments"
    - name: "average_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "total_shipment_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Sum of shipment weight in pounds"
    - name: "total_shipment_volume_cubic_ft"
      expr: SUM(CAST(total_volume_cubic_ft AS DOUBLE))
      comment: "Sum of shipment volume in cubic feet"
    - name: "on_time_shipment_count"
      expr: SUM(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on or before the scheduled delivery date"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wave-level metrics to monitor throughput, fill efficiency, and special handling requirements."
  source: "`grocery_ecm`.`fulfillment`.`wave`"
  dimensions:
    - name: "wave_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the wave was created"
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave"
    - name: "wave_type"
      expr: wave_type
      comment: "Classification of the wave (e.g., regular, priority)"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to the wave"
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of waves"
    - name: "total_orders_across_waves"
      expr: SUM(CAST(total_orders AS DOUBLE))
      comment: "Sum of orders across all waves"
    - name: "average_fill_rate_percent"
      expr: AVG(CAST(fill_rate_percent AS DOUBLE))
      comment: "Average fill rate percentage across waves"
    - name: "rush_wave_count"
      expr: SUM(CASE WHEN is_rush_wave THEN 1 ELSE 0 END)
      comment: "Number of rush waves"
    - name: "cold_chain_compliant_wave_count"
      expr: SUM(CASE WHEN is_cold_chain_compliant THEN 1 ELSE 0 END)
      comment: "Number of waves that are cold‑chain compliant"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance metrics that inform partner selection and contract negotiations."
  source: "`grocery_ecm`.`fulfillment`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type/category of the carrier"
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier"
    - name: "geographic_coverage_zones"
      expr: geographic_coverage_zones
      comment: "Geographic zones covered by the carrier"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers"
    - name: "average_on_time_delivery_rate_percent"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on‑time delivery rate across carriers"
    - name: "average_damage_claim_rate_percent"
      expr: AVG(CAST(damage_claim_rate_percent AS DOUBLE))
      comment: "Average damage claim rate across carriers"
    - name: "average_transit_time_days"
      expr: AVG(CAST(average_transit_time_days AS DOUBLE))
      comment: "Average transit time in days across carriers"
    - name: "cold_chain_certified_carrier_count"
      expr: SUM(CASE WHEN cold_chain_certified_flag THEN 1 ELSE 0 END)
      comment: "Number of carriers certified for cold‑chain handling"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery route KPIs to evaluate efficiency, cost, and SLA adherence."
  source: "`grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`"
  dimensions:
    - name: "route_date"
      expr: DATE_TRUNC('day', route_date)
      comment: "Date of the route"
    - name: "route_status"
      expr: route_status
      comment: "Current status of the route"
    - name: "route_type"
      expr: route_type
      comment: "Classification of the route (e.g., standard, express)"
    - name: "service_level"
      expr: service_level
      comment: "Service level offered for the route"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone required for the route"
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of delivery routes"
    - name: "total_actual_distance_miles"
      expr: SUM(CAST(actual_distance_miles AS DOUBLE))
      comment: "Sum of actual distance traveled across routes (miles)"
    - name: "total_route_cost_amount"
      expr: SUM(CAST(route_cost_amount AS DOUBLE))
      comment: "Total cost incurred for routes"
    - name: "average_route_cost_amount"
      expr: AVG(CAST(route_cost_amount AS DOUBLE))
      comment: "Average cost per route"
    - name: "total_fuel_cost_amount"
      expr: SUM(CAST(fuel_cost_amount AS DOUBLE))
      comment: "Total fuel cost across routes"
    - name: "sla_compliant_route_count"
      expr: SUM(CASE WHEN sla_compliance_flag THEN 1 ELSE 0 END)
      comment: "Number of routes that met SLA compliance"
$$;