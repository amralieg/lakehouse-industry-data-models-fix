-- Metric views for domain: logistics | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for logistics carriers derived from carrier performance records"
  source: "`automotive_ecm`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier"
    - name: "performance_month"
      expr: DATE_TRUNC('month', performance_month)
      comment: "Month of the performance measurement"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., truck, rail, sea)"
  measures:
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on‑time delivery rate percentage across carriers for the selected period"
    - name: "avg_cost_per_shipment_usd"
      expr: AVG(CAST(cost_per_shipment_usd AS DOUBLE))
      comment: "Average cost per shipment in USD"
    - name: "avg_fuel_consumption_l_per_100km"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption (liters per 100 km) for carrier performance records"
    - name: "avg_transit_days"
      expr: AVG(CAST(average_transit_days AS DOUBLE))
      comment: "Average transit days per shipment"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational metrics for individual shipments"
  source: "`automotive_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier handling the shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode used for the shipment"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "planned_arrival_month"
      expr: DATE_TRUNC('month', planned_arrival_date)
      comment: "Planned arrival month"
  measures:
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost in USD for shipments"
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment in USD"
    - name: "avg_shipment_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms"
    - name: "avg_shipment_volume_cbm"
      expr: AVG(CAST(volume_cbm AS DOUBLE))
      comment: "Average shipment volume in cubic meters"
    - name: "on_time_delivery_rate_pct"
      expr: AVG(CASE WHEN otd_flag THEN 1.0 ELSE 0.0 END) * 100
      comment: "On‑time delivery rate percentage derived from OTD flag"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_transport_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate and surcharge metrics for carrier transport contracts"
  source: "`automotive_ecm`.`logistics`.`transport_rate`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier identifier for the rate"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport covered by the rate"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the rate"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the rate"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month when the rate became effective"
  measures:
    - name: "avg_rate_amount_usd"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average transport rate amount in USD"
    - name: "avg_fuel_surcharge_percent"
      expr: AVG(CAST(fuel_surcharge_percent AS DOUBLE))
      comment: "Average fuel surcharge percentage applied to rates"
    - name: "avg_accessorial_charges_usd"
      expr: AVG(CAST(accessorial_charges AS DOUBLE))
      comment: "Average accessorial charges in USD"
    - name: "total_rate_amount_usd"
      expr: SUM(CAST(rate_amount AS DOUBLE))
      comment: "Total of all transport rate amounts"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`logistics_in_transit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental and weight metrics for inventory currently in transit"
  source: "`automotive_ecm`.`logistics`.`in_transit_inventory`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier moving the inventory"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode used"
    - name: "origin_facility_code"
      expr: origin_facility_code
      comment: "Origin facility code"
    - name: "destination_facility_code"
      expr: destination_facility_code
      comment: "Destination facility code"
    - name: "arrival_month"
      expr: DATE_TRUNC('month', actual_arrival_date)
      comment: "Month of actual arrival"
  measures:
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight of inventory in transit (tons)"
    - name: "avg_emissions_kg_co2"
      expr: AVG(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Average CO2 emissions (kg) for in‑transit inventory"
    - name: "avg_fuel_consumption_liters"
      expr: AVG(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Average fuel consumption (liters) for in‑transit inventory"
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Number of in‑transit inventory records"
$$;