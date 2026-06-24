-- Metric views for domain: logistics | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier quality and performance metrics for strategic carrier selection and contract negotiation decisions"
  source: "`vibe_consumer_goods_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier for performance analysis"
    - name: "carrier_code"
      expr: carrier_code
      comment: "Unique carrier code identifier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (LTL, FTL, parcel, etc.)"
    - name: "service_modes"
      expr: service_modes
      comment: "Transportation modes offered by carrier"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic regions served by carrier"
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of carrier"
    - name: "preferred_carrier_flag"
      expr: preferred_carrier_flag
      comment: "Whether carrier is designated as preferred"
  measures:
    - name: "total_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Total number of unique carriers in network for capacity planning"
    - name: "avg_on_time_performance_pct"
      expr: AVG(CAST(on_time_performance_pct AS DOUBLE))
      comment: "Average on-time delivery performance percentage across carriers for SLA compliance monitoring"
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average carrier quality rating for strategic carrier selection decisions"
    - name: "preferred_carrier_count"
      expr: COUNT(DISTINCT CASE WHEN preferred_carrier_flag = true THEN carrier_id END)
      comment: "Count of preferred carriers for network optimization analysis"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_cost_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight cost and invoice metrics for transportation spend management and carrier cost optimization"
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "invoice_number"
      expr: invoice_number
      comment: "Unique freight invoice identifier"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of freight invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of invoice amounts"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for freight invoice"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice for trend analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for period analysis"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date month for cash flow planning"
  measures:
    - name: "total_freight_spend"
      expr: SUM(CAST(total_invoice_amount AS DOUBLE))
      comment: "Total freight spend for budget management and cost reduction initiatives"
    - name: "total_base_freight_charges"
      expr: SUM(CAST(base_freight_charge AS DOUBLE))
      comment: "Total base freight charges excluding surcharges for rate negotiation analysis"
    - name: "total_fuel_surcharges"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharges for fuel cost impact analysis"
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges for service optimization opportunities"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_invoice_amount AS DOUBLE))
      comment: "Average freight invoice amount for shipment cost benchmarking"
    - name: "invoice_count"
      expr: COUNT(DISTINCT freight_invoice_id)
      comment: "Total number of freight invoices for volume analysis"
    - name: "paid_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN payment_date IS NOT NULL THEN freight_invoice_id END)
      comment: "Count of paid invoices for payment processing efficiency"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_freight_audit_savings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight audit variance and savings metrics for cost recovery and carrier billing accuracy monitoring"
  source: "`vibe_consumer_goods_v1`.`logistics`.`freight_audit_result`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Status of freight audit result"
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for billing variance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of audit amounts"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit for trend analysis"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit for period analysis"
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced amount before audit for baseline comparison"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved amount after audit for actual cost tracking"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total billing variance identified through audit for cost recovery and savings realization"
    - name: "audit_count"
      expr: COUNT(DISTINCT freight_audit_result_id)
      comment: "Total number of freight audits performed for audit coverage analysis"
    - name: "variance_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN variance_amount != 0 THEN freight_audit_result_id END)
      comment: "Count of invoices with billing variances for carrier accuracy assessment"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_shipment_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and on-time delivery metrics for logistics performance management and customer service optimization"
  source: "`vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "shipment_number"
      expr: shipment_number
      comment: "Unique shipment identifier"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of shipment"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment"
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment for shipment"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location of shipment"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location of shipment"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether shipment contains hazardous materials"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether shipment requires temperature control"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for shipment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight costs"
    - name: "planned_ship_year_month"
      expr: DATE_TRUNC('MONTH', planned_ship_date)
      comment: "Planned ship month for volume planning"
    - name: "actual_ship_year_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Actual ship month for execution analysis"
  measures:
    - name: "total_shipments"
      expr: COUNT(DISTINCT logistics_shipment_id)
      comment: "Total number of shipments for volume tracking and capacity planning"
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments for transportation spend management"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms for capacity utilization analysis"
    - name: "total_volume_cubic_m"
      expr: SUM(CAST(total_volume_cubic_m AS DOUBLE))
      comment: "Total shipment volume in cubic meters for space utilization optimization"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment for cost benchmarking and rate analysis"
    - name: "on_time_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date <= planned_delivery_date THEN logistics_shipment_id END)
      comment: "Count of on-time shipments for service level performance tracking"
    - name: "late_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date > planned_delivery_date THEN logistics_shipment_id END)
      comment: "Count of late shipments for service failure analysis and root cause investigation"
    - name: "hazmat_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN hazmat_flag = true THEN logistics_shipment_id END)
      comment: "Count of hazardous material shipments for compliance monitoring and risk management"
    - name: "temp_controlled_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_controlled_flag = true THEN logistics_shipment_id END)
      comment: "Count of temperature-controlled shipments for cold chain capacity planning"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_lane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transportation lane performance and efficiency metrics for network optimization and routing decisions"
  source: "`vibe_consumer_goods_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_code"
      expr: lane_code
      comment: "Unique lane identifier"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location of lane"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location of lane"
    - name: "origin_city"
      expr: origin_city
      comment: "Origin city"
    - name: "destination_city"
      expr: destination_city
      comment: "Destination city"
    - name: "origin_state_province"
      expr: origin_state_province
      comment: "Origin state or province"
    - name: "destination_state_province"
      expr: destination_state_province
      comment: "Destination state or province"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transportation mode for lane"
    - name: "service_level"
      expr: service_level
      comment: "Service level for lane"
    - name: "lane_status"
      expr: lane_status
      comment: "Current status of lane"
  measures:
    - name: "total_lanes"
      expr: COUNT(DISTINCT lane_id)
      comment: "Total number of active transportation lanes for network coverage analysis"
    - name: "total_lane_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total lane distance in kilometers for network reach assessment"
    - name: "avg_lane_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance for routing efficiency analysis"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_delivery_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery execution and exception metrics for last-mile performance and customer satisfaction management"
  source: "`vibe_consumer_goods_v1`.`logistics`.`delivery`"
  dimensions:
    - name: "delivery_number"
      expr: delivery_number
      comment: "Unique delivery identifier"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of delivery"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code if delivery had issues"
    - name: "exception_description"
      expr: exception_description
      comment: "Description of delivery exception"
    - name: "location"
      expr: location
      comment: "Delivery location"
    - name: "delivery_year_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Delivery month for trend analysis"
  measures:
    - name: "total_deliveries"
      expr: COUNT(DISTINCT delivery_id)
      comment: "Total number of deliveries for volume tracking and capacity planning"
    - name: "exception_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN exception_code IS NOT NULL THEN delivery_id END)
      comment: "Count of deliveries with exceptions for service quality monitoring and root cause analysis"
    - name: "successful_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN exception_code IS NULL THEN delivery_id END)
      comment: "Count of successful deliveries without exceptions for service level achievement tracking"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_cold_chain_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain temperature monitoring and excursion metrics for product quality assurance and regulatory compliance"
  source: "`vibe_consumer_goods_v1`.`logistics`.`cold_chain_log`"
  dimensions:
    - name: "sensor_code"
      expr: sensor_code
      comment: "Sensor identifier for temperature monitoring"
    - name: "location_code"
      expr: location_code
      comment: "Location where temperature reading was taken"
    - name: "excursion_flag"
      expr: excursion_flag
      comment: "Whether temperature excursion occurred"
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of temperature excursion"
    - name: "reading_year_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of temperature reading for trend analysis"
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(DISTINCT cold_chain_log_id)
      comment: "Total number of temperature readings for monitoring coverage assessment"
    - name: "excursion_count"
      expr: COUNT(DISTINCT CASE WHEN excursion_flag = true THEN cold_chain_log_id END)
      comment: "Count of temperature excursions for quality risk management and compliance reporting"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature across readings for cold chain performance monitoring"
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity percentage for environmental control assessment"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_customs_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs clearance efficiency and duty cost metrics for international trade compliance and cost management"
  source: "`vibe_consumer_goods_v1`.`logistics`.`customs_declaration`"
  dimensions:
    - name: "declaration_number"
      expr: declaration_number
      comment: "Unique customs declaration identifier"
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Status of customs clearance"
    - name: "export_country_code"
      expr: export_country_code
      comment: "Country of export"
    - name: "import_country_code"
      expr: import_country_code
      comment: "Country of import"
    - name: "hs_code"
      expr: hs_code
      comment: "Harmonized System code for product classification"
    - name: "broker_name"
      expr: broker_name
      comment: "Customs broker handling clearance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of customs charges"
    - name: "declaration_year_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of declaration for trend analysis"
  measures:
    - name: "total_declarations"
      expr: COUNT(DISTINCT customs_declaration_id)
      comment: "Total number of customs declarations for trade volume tracking"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared value of goods for trade value analysis"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty paid for landed cost management and duty optimization"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total customs tax paid for total landed cost calculation"
    - name: "cleared_declaration_count"
      expr: COUNT(DISTINCT CASE WHEN clearance_date IS NOT NULL THEN customs_declaration_id END)
      comment: "Count of cleared declarations for customs efficiency monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_transport_exceptions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transportation exception and disruption metrics for supply chain risk management and service recovery"
  source: "`vibe_consumer_goods_v1`.`logistics`.`transport_exception`"
  dimensions:
    - name: "exception_code"
      expr: exception_code
      comment: "Code identifying type of exception"
    - name: "exception_type"
      expr: exception_type
      comment: "Category of transportation exception"
    - name: "exception_description"
      expr: exception_description
      comment: "Description of exception"
    - name: "severity"
      expr: severity
      comment: "Severity level of exception"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of exception resolution"
    - name: "exception_year_month"
      expr: DATE_TRUNC('MONTH', exception_timestamp)
      comment: "Month of exception for trend analysis"
  measures:
    - name: "total_exceptions"
      expr: COUNT(DISTINCT transport_exception_id)
      comment: "Total number of transportation exceptions for disruption frequency analysis and risk assessment"
    - name: "resolved_exception_count"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NOT NULL THEN transport_exception_id END)
      comment: "Count of resolved exceptions for resolution effectiveness tracking"
    - name: "unresolved_exception_count"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NULL THEN transport_exception_id END)
      comment: "Count of unresolved exceptions for active issue management and escalation"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_route_optimization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route efficiency and utilization metrics for transportation network optimization and cost reduction"
  source: "`vibe_consumer_goods_v1`.`logistics`.`route`"
  dimensions:
    - name: "route_code"
      expr: route_code
      comment: "Unique route identifier"
    - name: "route_name"
      expr: route_name
      comment: "Name of route"
    - name: "route_type"
      expr: route_type
      comment: "Type of route"
    - name: "route_status"
      expr: route_status
      comment: "Current status of route"
    - name: "start_location_code"
      expr: start_location_code
      comment: "Starting location of route"
    - name: "end_location_code"
      expr: end_location_code
      comment: "Ending location of route"
  measures:
    - name: "total_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Total number of routes for network coverage analysis"
    - name: "total_route_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total route distance in kilometers for network efficiency assessment"
    - name: "avg_route_distance_km"
      expr: AVG(CAST(total_distance_km AS DOUBLE))
      comment: "Average route distance for route design optimization"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated route duration for capacity planning"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated route duration for route efficiency benchmarking"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`logistics_carrier_contract_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier contract value and commitment metrics for procurement strategy and carrier relationship management"
  source: "`vibe_consumer_goods_v1`.`logistics`.`carrier_contract`"
  dimensions:
    - name: "contract_number"
      expr: contract_number
      comment: "Unique contract identifier"
    - name: "contract_name"
      expr: contract_name
      comment: "Name of carrier contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of carrier contract"
    - name: "carrier_contract_status"
      expr: carrier_contract_status
      comment: "Current status of contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of contract amounts"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of contract"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract auto-renews"
    - name: "fuel_surcharge_method"
      expr: fuel_surcharge_method
      comment: "Method for calculating fuel surcharges"
    - name: "volume_commitment_uom"
      expr: volume_commitment_uom
      comment: "Unit of measure for volume commitment"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT carrier_contract_id)
      comment: "Total number of carrier contracts for supplier relationship portfolio analysis"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total volume commitment across contracts for capacity assurance and negotiation leverage"
    - name: "total_liability_limit"
      expr: SUM(CAST(liability_limit_amount AS DOUBLE))
      comment: "Total liability coverage across contracts for risk exposure assessment"
    - name: "total_minimum_charges"
      expr: SUM(CAST(minimum_charge AS DOUBLE))
      comment: "Total minimum charges committed for baseline cost planning"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge per contract for contract benchmarking"
$$;