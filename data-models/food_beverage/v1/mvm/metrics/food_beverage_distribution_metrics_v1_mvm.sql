-- Metric views for domain: distribution | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fulfillment performance metrics tracking order execution, delivery timeliness, and operational efficiency across distribution channels"
  source: "`food_beverage_ecm`.`distribution`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment order (e.g., pending, picking, shipped, delivered)"
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the order is fulfilled (e.g., retail, foodservice, DTC, ecommerce)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, promotional, cross-dock)"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level assigned to the order for fulfillment sequencing"
    - name: "cold_chain_required"
      expr: cold_chain_required_flag
      comment: "Whether the order requires temperature-controlled handling"
    - name: "hazmat_required"
      expr: hazmat_flag
      comment: "Whether the order contains hazardous materials requiring special handling"
    - name: "cross_dock"
      expr: cross_dock_flag
      comment: "Whether the order is processed via cross-dock (no storage)"
    - name: "exception_code"
      expr: exception_code
      comment: "Code identifying any fulfillment exception or issue"
    - name: "exception_resolution_status"
      expr: exception_resolution_status
      comment: "Current status of exception resolution (e.g., open, investigating, resolved)"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Date the order was actually delivered to the customer"
    - name: "actual_ship_date"
      expr: actual_ship_date
      comment: "Date the order was actually shipped from the distribution center"
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date promised to the customer for delivery"
    - name: "requested_ship_date"
      expr: requested_ship_date
      comment: "Date requested by the customer for shipment"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery for time-series analysis"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month of actual shipment for time-series analysis"
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders processed"
    - name: "total_order_cases"
      expr: SUM(CAST(total_order_cases AS DOUBLE))
      comment: "Total number of cases across all fulfillment orders"
    - name: "total_order_pallets"
      expr: SUM(CAST(total_order_pallets AS DOUBLE))
      comment: "Total number of pallets across all fulfillment orders"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all fulfillment orders"
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters across all fulfillment orders"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage — measures how completely orders are fulfilled vs. requested"
    - name: "otif_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_target_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders meeting On-Time In-Full (OTIF) targets — critical customer service KPI"
    - name: "cold_chain_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cold_chain_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders requiring cold chain handling — indicates temperature-sensitive product mix"
    - name: "cross_dock_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_dock_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders processed via cross-dock — measures operational efficiency and inventory velocity"
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exception_code IS NOT NULL THEN fulfillment_order_id END) / NULLIF(COUNT(DISTINCT fulfillment_order_id), 0), 2)
      comment: "Percentage of orders with fulfillment exceptions — key quality and operational risk indicator"
    - name: "avg_cases_per_order"
      expr: AVG(CAST(total_order_cases AS DOUBLE))
      comment: "Average number of cases per fulfillment order — indicates order size and complexity"
    - name: "avg_pallets_per_order"
      expr: AVG(CAST(total_order_pallets AS DOUBLE))
      comment: "Average number of pallets per fulfillment order — measures shipment scale"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_otif_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full performance measurement and compliance tracking — critical customer service and contractual obligation metrics"
  source: "`food_beverage_ecm`.`distribution`.`otif_record`"
  dimensions:
    - name: "record_status"
      expr: record_status
      comment: "Status of the OTIF record (e.g., open, closed, disputed)"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether the delivery met the on-time commitment"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether the delivery met the in-full quantity commitment"
    - name: "temperature_compliance"
      expr: temperature_compliance_flag
      comment: "Whether temperature requirements were maintained throughout delivery"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the OTIF failure was escalated to management"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Code identifying the root cause of OTIF failure"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the OTIF failure (e.g., carrier, warehouse, supplier)"
    - name: "delivery_destination_type"
      expr: delivery_destination_type
      comment: "Type of delivery destination (e.g., retail store, distribution center, foodservice)"
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date the OTIF performance was measured"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of OTIF measurement for time-series trending"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for penalty and chargeback amounts"
  measures:
    - name: "total_otif_records"
      expr: COUNT(1)
      comment: "Total number of OTIF performance records measured"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE AND in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting both on-time and in-full commitments — primary customer service KPI"
    - name: "on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting on-time commitment — measures delivery timeliness"
    - name: "in_full_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting in-full quantity commitment — measures order accuracy"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate across all OTIF records — measures order completeness"
    - name: "avg_otif_composite_score"
      expr: AVG(CAST(otif_composite_score AS DOUBLE))
      comment: "Average composite OTIF score — weighted performance metric combining multiple factors"
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries maintaining required temperature — critical for food safety and quality"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTIF failures requiring management escalation — indicates severity of service issues"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_fine_amount AS DOUBLE))
      comment: "Total financial penalties incurred for OTIF failures — direct cost of service failures"
    - name: "avg_penalty_per_failure"
      expr: AVG(CAST(penalty_fine_amount AS DOUBLE))
      comment: "Average penalty amount per OTIF failure — measures financial impact of service issues"
    - name: "total_cases_ordered"
      expr: SUM(CAST(cases_ordered AS DOUBLE))
      comment: "Total cases ordered across all OTIF records"
    - name: "total_cases_delivered"
      expr: SUM(CAST(cases_delivered AS DOUBLE))
      comment: "Total cases actually delivered across all OTIF records"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_cold_chain_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Temperature monitoring and cold chain compliance tracking — critical for food safety, regulatory compliance, and product quality"
  source: "`food_beverage_ecm`.`distribution`.`cold_chain_event`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of cold chain asset (e.g., truck, trailer, container, warehouse zone)"
    - name: "excursion_flag"
      expr: excursion_flag
      comment: "Whether a temperature excursion (out-of-range event) occurred"
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity level of the temperature excursion (e.g., minor, moderate, critical)"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition decision for product after excursion (e.g., approved, rejected, quarantine)"
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Whether product was placed on quality hold due to temperature event"
    - name: "fsma_compliant"
      expr: fsma_compliant_flag
      comment: "Whether the cold chain event met FSMA (Food Safety Modernization Act) requirements"
    - name: "haccp_compliant"
      expr: haccp_compliant_flag
      comment: "Whether the cold chain event met HACCP (Hazard Analysis Critical Control Point) requirements"
    - name: "regulatory_report_required"
      expr: regulatory_report_required_flag
      comment: "Whether the event requires regulatory reporting"
    - name: "alert_notification_sent"
      expr: alert_notification_sent_flag
      comment: "Whether real-time alert was sent for the temperature event"
    - name: "product_category"
      expr: product_category
      comment: "Category of product being monitored (e.g., frozen, refrigerated, ambient)"
    - name: "event_date"
      expr: CAST(event_timestamp AS DATE)
      comment: "Date of the cold chain event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the cold chain event for time-series analysis"
  measures:
    - name: "total_cold_chain_events"
      expr: COUNT(1)
      comment: "Total number of cold chain monitoring events recorded"
    - name: "temperature_excursion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN excursion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with temperature excursions — critical food safety and quality risk indicator"
    - name: "fsma_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fsma_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events meeting FSMA requirements — regulatory compliance metric"
    - name: "haccp_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events meeting HACCP requirements — food safety system compliance"
    - name: "quality_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events resulting in quality hold — measures product risk and potential waste"
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_report_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events requiring regulatory reporting — indicates severity and compliance burden"
    - name: "alert_effectiveness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with alerts sent — measures monitoring system effectiveness"
    - name: "avg_recorded_temp_celsius"
      expr: AVG(CAST(recorded_temperature_celsius AS DOUBLE))
      comment: "Average recorded temperature in Celsius across all events"
    - name: "avg_excursion_duration_minutes"
      expr: AVG(CAST(excursion_duration_minutes AS DOUBLE))
      comment: "Average duration of temperature excursions in minutes — measures severity of cold chain breaks"
    - name: "avg_humidity_pct"
      expr: AVG(CAST(humidity_percentage AS DOUBLE))
      comment: "Average humidity percentage during cold chain events — secondary quality control metric"
    - name: "critical_excursion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN excursion_severity = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with critical severity excursions — highest-risk food safety events"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and logistics performance metrics tracking freight efficiency, carrier performance, and delivery execution"
  source: "`food_beverage_ecm`.`distribution`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., planned, in-transit, delivered, cancelled)"
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment (e.g., standard, expedited, next-day)"
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Temperature control requirement for the shipment (e.g., frozen, refrigerated, ambient)"
    - name: "cross_dock"
      expr: cross_dock_flag
      comment: "Whether the shipment was processed via cross-dock"
    - name: "hazmat"
      expr: hazmat_flag
      comment: "Whether the shipment contains hazardous materials"
    - name: "dsd_route"
      expr: dsd_route_flag
      comment: "Whether the shipment is part of a direct store delivery route"
    - name: "third_party_logistics"
      expr: third_party_logistics_flag
      comment: "Whether the shipment is handled by a third-party logistics provider"
    - name: "otif_compliant"
      expr: otif_compliant_flag
      comment: "Whether the shipment met OTIF (On-Time In-Full) commitments"
    - name: "asn_sent"
      expr: asn_sent_flag
      comment: "Whether an Advanced Shipping Notice was sent to the customer"
    - name: "proof_of_delivery_received"
      expr: proof_of_delivery_received_flag
      comment: "Whether proof of delivery documentation was received"
    - name: "temperature_zone_segregation"
      expr: temperature_zone_segregation_flag
      comment: "Whether multiple temperature zones were segregated in the shipment"
    - name: "delivery_exception_code"
      expr: delivery_exception_code
      comment: "Code identifying any delivery exception or issue"
    - name: "actual_delivery_date"
      expr: CAST(actual_delivery_datetime AS DATE)
      comment: "Date the shipment was actually delivered"
    - name: "scheduled_delivery_date"
      expr: CAST(scheduled_delivery_datetime AS DATE)
      comment: "Date the shipment was scheduled for delivery"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_datetime)
      comment: "Month of actual delivery for time-series analysis"
    - name: "freight_cost_currency"
      expr: freight_cost_currency
      comment: "Currency code for freight cost amounts"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments executed"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipments — primary logistics cost metric"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment — measures logistics efficiency"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all shipments"
    - name: "total_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total volume in cubic meters across all shipments"
    - name: "total_pallets"
      expr: SUM(CAST(pallet_count AS DOUBLE))
      comment: "Total number of pallets shipped"
    - name: "total_cases"
      expr: SUM(CAST(case_count AS DOUBLE))
      comment: "Total number of cases shipped"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average trailer/container utilization percentage — measures freight efficiency and cost optimization"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments meeting OTIF commitments — critical customer service KPI"
    - name: "delivery_exception_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN delivery_exception_code IS NOT NULL THEN shipment_id END) / NULLIF(COUNT(DISTINCT shipment_id), 0), 2)
      comment: "Percentage of shipments with delivery exceptions — measures operational quality"
    - name: "cross_dock_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_dock_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments processed via cross-dock — measures supply chain velocity"
    - name: "third_party_logistics_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN third_party_logistics_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments handled by 3PL providers — measures outsourcing strategy"
    - name: "asn_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN asn_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with ASN sent — measures EDI compliance and customer communication"
    - name: "pod_receipt_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN proof_of_delivery_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with proof of delivery received — measures documentation completeness"
    - name: "freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0), 4)
      comment: "Freight cost per kilogram — measures logistics cost efficiency by weight"
    - name: "freight_cost_per_pallet"
      expr: ROUND(SUM(CAST(freight_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(pallet_count AS DOUBLE)), 0), 2)
      comment: "Freight cost per pallet — measures logistics cost efficiency by handling unit"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance and compliance metrics tracking transportation partner quality, safety, and operational effectiveness"
  source: "`food_beverage_ecm`.`distribution`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current status of the carrier (e.g., active, inactive, suspended)"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g., truckload, LTL, parcel, intermodal)"
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode (e.g., over-the-road, rail, air, ocean)"
    - name: "fleet_size"
      expr: fleet_size
      comment: "Size category of carrier fleet (e.g., small, medium, large, enterprise)"
    - name: "cold_chain_capable"
      expr: cold_chain_capable_flag
      comment: "Whether the carrier has temperature-controlled capabilities"
    - name: "edi_capable"
      expr: edi_capable_flag
      comment: "Whether the carrier supports EDI (Electronic Data Interchange)"
    - name: "fsma_compliant"
      expr: fsma_compliant_flag
      comment: "Whether the carrier is FSMA (Food Safety Modernization Act) compliant"
    - name: "preferred_carrier"
      expr: preferred_carrier_flag
      comment: "Whether the carrier has preferred status"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (e.g., platinum, gold, silver, bronze)"
    - name: "safety_rating"
      expr: safety_rating
      comment: "DOT safety rating (e.g., satisfactory, conditional, unsatisfactory)"
    - name: "contracted_rate_tier"
      expr: contracted_rate_tier
      comment: "Rate tier in contracted pricing structure"
    - name: "service_coverage_region"
      expr: service_coverage_region
      comment: "Geographic region of service coverage"
    - name: "headquarters_country"
      expr: headquarters_country_code
      comment: "Country code of carrier headquarters"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the carrier was onboarded"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network"
    - name: "active_carriers"
      expr: COUNT(DISTINCT CASE WHEN carrier_status = 'active' THEN carrier_id END)
      comment: "Number of active carriers available for shipment assignment"
    - name: "avg_otif_pct"
      expr: AVG(CAST(otif_percentage AS DOUBLE))
      comment: "Average On-Time In-Full percentage across all carriers — primary carrier performance KPI"
    - name: "avg_claims_ratio_pct"
      expr: AVG(CAST(claims_ratio_percentage AS DOUBLE))
      comment: "Average claims ratio percentage — measures cargo damage and loss risk"
    - name: "cold_chain_capable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cold_chain_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with cold chain capabilities — measures network capacity for temperature-sensitive products"
    - name: "edi_capable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with EDI capabilities — measures digital integration maturity"
    - name: "fsma_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fsma_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers meeting FSMA requirements — regulatory compliance metric"
    - name: "preferred_carrier_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_carrier_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with preferred status — indicates strategic partnership concentration"
    - name: "avg_insurance_coverage"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage amount across carriers — measures financial risk protection"
    - name: "satisfactory_safety_rating_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_rating = 'satisfactory' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with satisfactory DOT safety rating — critical safety and compliance metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route execution and direct store delivery performance metrics tracking route efficiency, driver productivity, and last-mile effectiveness"
  source: "`food_beverage_ecm`.`distribution`.`delivery_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the route (e.g., active, inactive, seasonal)"
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g., DSD, bulk delivery, mixed)"
    - name: "route_completion_status"
      expr: route_completion_status
      comment: "Completion status of route execution (e.g., completed, partial, cancelled)"
    - name: "frequency"
      expr: frequency
      comment: "Delivery frequency (e.g., daily, weekly, bi-weekly)"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether the route requires temperature-controlled vehicles"
    - name: "hazmat_required"
      expr: hazmat_required
      comment: "Whether the route requires hazmat-certified drivers and vehicles"
    - name: "vehicle_type_required"
      expr: vehicle_type_required
      comment: "Type of vehicle required for the route (e.g., box truck, refrigerated truck, van)"
    - name: "execution_date"
      expr: execution_date
      comment: "Date the route was executed"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month of route execution for time-series analysis"
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of delivery routes"
    - name: "total_stops_planned"
      expr: SUM(CAST(stops_planned AS DOUBLE))
      comment: "Total number of stops planned across all routes"
    - name: "total_stops_completed"
      expr: SUM(CAST(stops_completed AS DOUBLE))
      comment: "Total number of stops successfully completed"
    - name: "stop_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(stops_completed AS DOUBLE)) / NULLIF(SUM(CAST(stops_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned stops successfully completed — measures route execution effectiveness"
    - name: "avg_otif_performance_pct"
      expr: AVG(CAST(otif_performance_pct AS DOUBLE))
      comment: "Average OTIF performance percentage across routes — critical last-mile service KPI"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage — measures order completeness at delivery"
    - name: "total_cases_loaded"
      expr: SUM(CAST(cases_loaded AS DOUBLE))
      comment: "Total cases loaded onto routes"
    - name: "total_cases_delivered"
      expr: SUM(CAST(cases_delivered AS DOUBLE))
      comment: "Total cases successfully delivered"
    - name: "total_cases_returned"
      expr: SUM(CAST(cases_returned AS DOUBLE))
      comment: "Total cases returned undelivered — indicates delivery failures and inefficiency"
    - name: "case_return_rate"
      expr: ROUND(100.0 * SUM(CAST(cases_returned AS DOUBLE)) / NULLIF(SUM(CAST(cases_loaded AS DOUBLE)), 0), 2)
      comment: "Percentage of loaded cases returned undelivered — measures route effectiveness and customer acceptance"
    - name: "total_actual_mileage"
      expr: SUM(CAST(actual_mileage AS DOUBLE))
      comment: "Total actual miles driven across all routes"
    - name: "total_estimated_mileage"
      expr: SUM(CAST(estimated_mileage AS DOUBLE))
      comment: "Total estimated miles for all routes"
    - name: "mileage_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_mileage AS DOUBLE)) - SUM(CAST(estimated_mileage AS DOUBLE))) / NULLIF(SUM(CAST(estimated_mileage AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated mileage — measures route planning accuracy"
    - name: "total_fuel_consumed_gallons"
      expr: SUM(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Total fuel consumed in gallons across all routes — primary route cost driver"
    - name: "avg_fuel_efficiency_mpg"
      expr: ROUND(SUM(CAST(actual_mileage AS DOUBLE)) / NULLIF(SUM(CAST(fuel_consumed_gallons AS DOUBLE)), 0), 2)
      comment: "Average miles per gallon across all routes — measures fuel efficiency and environmental impact"
    - name: "total_cash_collected"
      expr: SUM(CAST(cash_collected AS DOUBLE))
      comment: "Total cash collected on routes — measures COD and route-based payment collection"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`distribution_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity, capability, and operational readiness metrics tracking facility performance and strategic network positioning"
  source: "`food_beverage_ecm`.`distribution`.`center`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the distribution center (e.g., active, inactive, under construction)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of distribution facility (e.g., regional DC, cross-dock, fulfillment center)"
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (e.g., owned, leased, 3PL-operated)"
    - name: "country"
      expr: country_code
      comment: "Country code of the distribution center location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the distribution center"
    - name: "cross_dock_capable"
      expr: cross_dock_capable_flag
      comment: "Whether the center supports cross-dock operations"
    - name: "ecommerce_fulfillment"
      expr: ecommerce_fulfillment_flag
      comment: "Whether the center supports ecommerce order fulfillment"
    - name: "direct_store_delivery_hub"
      expr: direct_store_delivery_hub_flag
      comment: "Whether the center serves as a DSD hub"
    - name: "twenty_four_seven_operation"
      expr: twenty_four_seven_operation_flag
      comment: "Whether the center operates 24/7"
    - name: "frozen_zone"
      expr: frozen_zone_flag
      comment: "Whether the center has frozen storage capability"
    - name: "refrigerated_zone"
      expr: refrigerated_zone_flag
      comment: "Whether the center has refrigerated storage capability"
    - name: "ambient_zone"
      expr: ambient_zone_flag
      comment: "Whether the center has ambient storage capability"
    - name: "haccp_certified"
      expr: haccp_certified_flag
      comment: "Whether the center is HACCP certified"
    - name: "iso_9001_certified"
      expr: iso_9001_certified_flag
      comment: "Whether the center is ISO 9001 certified"
    - name: "third_party_logistics_provider"
      expr: third_party_logistics_provider
      comment: "Name of 3PL provider if facility is outsourced"
  measures:
    - name: "total_distribution_centers"
      expr: COUNT(1)
      comment: "Total number of distribution centers in the network"
    - name: "active_distribution_centers"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'active' THEN center_id END)
      comment: "Number of active distribution centers — measures operational network capacity"
    - name: "total_storage_sqft"
      expr: SUM(CAST(storage_square_footage AS DOUBLE))
      comment: "Total storage square footage across all centers — measures network storage capacity"
    - name: "total_facility_sqft"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total facility square footage including non-storage areas"
    - name: "total_cubic_capacity"
      expr: SUM(CAST(cubic_capacity AS DOUBLE))
      comment: "Total cubic capacity across all centers — measures volumetric storage capability"
    - name: "total_pallet_positions"
      expr: SUM(CAST(pallet_position_capacity AS DOUBLE))
      comment: "Total pallet position capacity across all centers — measures handling unit capacity"
    - name: "total_dock_doors"
      expr: SUM(CAST(dock_door_count AS DOUBLE))
      comment: "Total dock doors across all centers — measures throughput capacity"
    - name: "avg_storage_sqft_per_center"
      expr: AVG(CAST(storage_square_footage AS DOUBLE))
      comment: "Average storage square footage per center — measures typical facility scale"
    - name: "cross_dock_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_dock_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of centers with cross-dock capability — measures network velocity potential"
    - name: "ecommerce_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ecommerce_fulfillment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of centers supporting ecommerce fulfillment — measures omnichannel readiness"
    - name: "twenty_four_seven_operation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN twenty_four_seven_operation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of centers operating 24/7 — measures network operational intensity"
    - name: "cold_chain_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN frozen_zone_flag = TRUE OR refrigerated_zone_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of centers with cold chain capability — critical for food and beverage distribution"
    - name: "haccp_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of centers with HACCP certification — food safety compliance metric"
    - name: "iso_9001_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of centers with ISO 9001 certification — quality management system compliance"
    - name: "third_party_operated_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_logistics_provider IS NOT NULL THEN center_id END) / NULLIF(COUNT(DISTINCT center_id), 0), 2)
      comment: "Percentage of centers operated by 3PL providers — measures outsourcing strategy"
$$;