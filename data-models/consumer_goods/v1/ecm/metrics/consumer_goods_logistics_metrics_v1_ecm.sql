-- Metric views for domain: logistics | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core delivery performance and cost KPIs"
  source: "`consumer_goods_ecm`.`logistics`.`delivery`"
  dimensions:
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier code used in external systems"
    - name: "carrier_tracking_number"
      expr: carrier_tracking_number
      comment: "Tracking number assigned by the carrier"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., standard, express)"
    - name: "scheduled_delivery_date"
      expr: scheduled_delivery_date
      comment: "Planned delivery date"
    - name: "country_code"
      expr: country_code
      comment: "Destination country code"
    - name: "city"
      expr: city
      comment: "Destination city"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Count of delivery records"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN on_time_flag THEN 1 ELSE 0 END)
      comment: "Number of deliveries that arrived on time"
    - name: "otif_deliveries"
      expr: SUM(CASE WHEN otif_flag THEN 1 ELSE 0 END)
      comment: "Number of deliveries meeting OTIF criteria (on‑time and in‑full)"
    - name: "in_full_deliveries"
      expr: SUM(CASE WHEN in_full_flag THEN 1 ELSE 0 END)
      comment: "Number of deliveries where ordered quantity was fully delivered"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost incurred for deliveries"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered across all deliveries"
    - name: "avg_delivered_quantity"
      expr: AVG(CAST(delivered_quantity AS DOUBLE))
      comment: "Average delivered quantity per delivery"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance scores and rates"
  source: "`consumer_goods_ecm`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier identifier"
    - name: "network_region"
      expr: network_region
      comment: "Geographic network region of the carrier"
    - name: "service_level"
      expr: service_level
      comment: "Service level associated with the performance record"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type (e.g., monthly, quarterly)"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the measurement period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the measurement period"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of carrier performance records"
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score for carriers"
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on‑time delivery rate percentage"
    - name: "avg_damage_rate_pct"
      expr: AVG(CAST(damage_rate_pct AS DOUBLE))
      comment: "Average damage rate percentage"
    - name: "avg_claims_rate_pct"
      expr: AVG(CAST(claims_rate_pct AS DOUBLE))
      comment: "Average claims rate percentage"
    - name: "avg_in_full_rate_pct"
      expr: AVG(CAST(in_full_rate_pct AS DOUBLE))
      comment: "Average in‑full delivery rate percentage"
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate percentage"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_freight_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial freight cost metrics"
  source: "`consumer_goods_ecm`.`logistics`.`freight_cost`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier identifier"
    - name: "carrier_contract_id"
      expr: carrier_contract_id
      comment: "Carrier contract identifier"
    - name: "lane_id"
      expr: lane_id
      comment: "Lane identifier for the freight movement"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of the freight cost (e.g., base, accessorial)"
    - name: "cost_status"
      expr: cost_status
      comment: "Current status of the cost record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the cost amount"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., road, air)"
    - name: "service_level"
      expr: service_level
      comment: "Service level associated with the cost"
    - name: "billing_period"
      expr: billing_period
      comment: "Billing period for the cost"
    - name: "cost_recognition_date"
      expr: cost_recognition_date
      comment: "Date the cost was recognized"
  measures:
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total freight cost amount"
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_amount_usd AS DOUBLE))
      comment: "Total freight cost converted to USD"
    - name: "avg_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average freight cost per line item"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight billed in kilograms"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kilograms"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg operational and environmental KPIs"
  source: "`consumer_goods_ecm`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier handling the leg"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the leg"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country code of the leg"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code of the leg"
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the leg"
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating if the leg requires cold chain"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating if the leg involves hazardous material"
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Number of shipment legs"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight across legs"
    - name: "total_freight_cost_amount"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost amount for legs"
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours per leg"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions for shipment legs"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_transport_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exception and claim impact metrics"
  source: "`consumer_goods_ecm`.`logistics`.`transport_exception`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier involved in the exception"
    - name: "lane_id"
      expr: lane_id
      comment: "Lane where the exception occurred"
    - name: "exception_type"
      expr: exception_type
      comment: "Type/category of the exception"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the exception"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the affected shipment"
    - name: "exception_timestamp"
      expr: exception_timestamp
      comment: "Timestamp when the exception was recorded"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Count of transport exceptions"
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total monetary claim amount associated with exceptions"
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount of exceptions"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lane efficiency and cost benchmark metrics"
  source: "`consumer_goods_ecm`.`logistics`.`lane`"
  dimensions:
    - name: "carrier_contract_id"
      expr: carrier_contract_id
      comment: "Carrier contract associated with the lane"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country code of the lane"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code of the lane"
    - name: "service_level"
      expr: service_level
      comment: "Service level for the lane"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the lane"
    - name: "lane_status"
      expr: lane_status
      comment: "Current status of the lane"
    - name: "network_region"
      expr: network_region
      comment: "Network region the lane belongs to"
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Number of lanes"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance of lanes in kilometers"
    - name: "avg_annual_volume_weight_kg"
      expr: AVG(CAST(annual_volume_weight_kg AS DOUBLE))
      comment: "Average annual volume weight per lane"
    - name: "avg_benchmark_rate_per_km"
      expr: AVG(CAST(benchmark_rate_per_km AS DOUBLE))
      comment: "Average benchmark rate per kilometer"
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor for lanes"
$$;