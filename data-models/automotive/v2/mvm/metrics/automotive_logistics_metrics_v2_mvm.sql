-- Metric views for domain: logistics | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance and cost efficiency metrics for evaluating logistics partner quality, contract compliance, and fleet capability across the carrier network."
  source: "`vibe_automotive_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g., road, rail, ocean, air) used to segment performance by transport mode category."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (e.g., active, suspended, terminated) for filtering active vs. inactive partners."
    - name: "tier"
      expr: tier
      comment: "Carrier tier classification (e.g., Tier 1, Tier 2) reflecting strategic importance and volume commitment."
    - name: "transport_modes"
      expr: transport_modes
      comment: "Transport modes supported by the carrier, enabling multi-modal analysis."
    - name: "country"
      expr: country
      comment: "Country of carrier registration for geographic segmentation of the carrier network."
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating assigned to the carrier, used for risk-based carrier selection and compliance monitoring."
    - name: "iatf_compliance_status"
      expr: iatf_compliance_status
      comment: "IATF 16949 compliance status of the carrier, critical for automotive supply chain quality governance."
    - name: "contract_start_date"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Month of contract start date, used to track contract cohorts and renewal cycles."
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification held by the carrier (e.g., ISO 14001), supporting sustainability reporting."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carrier records. Baseline measure for network size and coverage analysis."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(average_on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers. Core KPI for carrier reliability and customer satisfaction impact."
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(average_cost_per_mile AS DOUBLE))
      comment: "Average freight cost per mile across carriers. Drives carrier selection, rate negotiation, and cost optimization decisions."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average carrier performance rating. Composite KPI used in quarterly business reviews to rank and tier carrier partners."
    - name: "min_performance_rating"
      expr: MIN(CAST(performance_rating AS DOUBLE))
      comment: "Minimum carrier performance rating in the network. Identifies underperforming carriers requiring intervention or contract review."
    - name: "max_performance_rating"
      expr: MAX(CAST(performance_rating AS DOUBLE))
      comment: "Maximum carrier performance rating. Benchmarks top-performing carriers for best-practice sharing and preferred partner designation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level logistics KPIs covering freight cost, on-time delivery performance, volume throughput, and compliance status. Central to supply chain steering and cost management."
  source: "`vibe_automotive_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, delayed) for pipeline visibility and exception management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used (e.g., road, rail, ocean, air) for modal cost and performance benchmarking."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates whether the shipment is an export or import, enabling cross-border logistics analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the shipment, critical for customs and trade compliance reporting."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing delivery responsibility and cost allocation between parties."
    - name: "load_type"
      expr: load_type
      comment: "Load type (e.g., FTL, LTL, container) for capacity utilization and cost-per-unit analysis."
    - name: "planned_departure_date"
      expr: DATE_TRUNC('month', planned_departure_date)
      comment: "Month of planned departure date for time-series trend analysis of shipment volumes and costs."
    - name: "planned_arrival_date"
      expr: DATE_TRUNC('month', planned_arrival_date)
      comment: "Month of planned arrival date for delivery schedule adherence tracking."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates presence of hazardous materials, used for compliance and risk segmentation."
    - name: "last_mile_delivery_flag"
      expr: last_mile_delivery_flag
      comment: "Flags last-mile delivery shipments, enabling cost and performance analysis of final-leg logistics."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight cost amounts for multi-currency cost consolidation."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline throughput measure for logistics capacity and volume planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments. Primary cost KPI for logistics spend management and budget variance analysis."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Tracks cost efficiency trends and supports carrier rate benchmarking."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net logistics cost after discounts. Used for P&L reporting and logistics cost-to-revenue ratio analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to shipments. Measures negotiated savings and carrier incentive program effectiveness."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(otd_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time. Top-tier KPI for customer satisfaction, SLA compliance, and carrier performance management."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms. Drives capacity planning, carrier load optimization, and freight rate negotiations."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used for container utilization analysis and space-based freight cost allocation."
    - name: "avg_weight_per_shipment"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Supports load planning and identification of shipment consolidation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering invoiced amounts, variances, payment status, and tax exposure. Drives accounts payable governance, carrier billing accuracy, and logistics cost control."
  source: "`vibe_automotive_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "freight_invoice_status"
      expr: freight_invoice_status
      comment: "Current status of the freight invoice (e.g., pending, approved, paid, disputed) for AP workflow management."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status for governance and audit trail tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., unpaid, paid, overdue) for cash flow and working capital management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode associated with the invoice for modal cost analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code on the invoice for trade terms cost allocation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency financial reporting and FX exposure analysis."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for time-series freight spend trend analysis."
    - name: "payment_due_date"
      expr: DATE_TRUNC('month', payment_due_date)
      comment: "Month of payment due date for cash flow forecasting and overdue invoice monitoring."
    - name: "otd_flag"
      expr: otd_flag
      comment: "On-time delivery flag on the invoice, linking financial settlement to delivery performance."
    - name: "attachment_flag"
      expr: attachment_flag
      comment: "Indicates whether supporting documentation is attached to the invoice, used for audit completeness checks."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices. Baseline measure for invoice volume and AP workload analysis."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total gross invoiced freight amount. Primary financial KPI for logistics spend tracking and budget management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net freight amount after discounts. Used for actual cost reporting and P&L impact assessment."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on freight invoices. Required for tax compliance reporting and VAT reclaim processes."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across freight invoices. Measures carrier negotiation effectiveness and volume rebate capture."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between agreed and invoiced freight amounts. Critical KPI for billing accuracy, dispute management, and carrier contract compliance."
    - name: "avg_variance_per_invoice"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average billing variance per invoice. Identifies systemic overbilling patterns and drives carrier audit prioritization."
    - name: "avg_agreed_rate"
      expr: AVG(CAST(agreed_rate AS DOUBLE))
      comment: "Average agreed freight rate per invoice. Benchmarks contracted rates across carriers and lanes for rate negotiation strategy."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight billed across freight invoices. Supports cost-per-kg analysis and weight-based rate validation."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume billed in cubic meters. Enables volumetric rate validation and container utilization cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle transport order KPIs covering transport cost, on-time delivery, emissions, and order execution efficiency. Central to finished vehicle logistics performance management."
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_transport_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the vehicle transport order (e.g., planned, in-transit, delivered, cancelled) for pipeline and exception management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for vehicle delivery (e.g., road, rail, ocean) for modal cost and performance benchmarking."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates cross-border transport orders for international logistics cost and compliance analysis."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flags expedited transport orders, enabling premium cost tracking and root-cause analysis of expedite frequency."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates hazardous vehicle transport orders for compliance and risk management segmentation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the transport order (e.g., high, medium, low) for resource allocation and SLA management."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the transported vehicle (e.g., BEV, ICE, PHEV) for EV logistics planning and sustainability reporting."
    - name: "container_type"
      expr: container_type
      comment: "Container type used for vehicle transport, supporting equipment planning and cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of transport cost amounts for multi-currency financial consolidation."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of vehicle delivery date for time-series delivery volume and cost trend analysis."
    - name: "confirmed_pickup_date"
      expr: DATE_TRUNC('month', confirmed_pickup_date)
      comment: "Month of confirmed pickup date for outbound logistics scheduling and capacity planning."
  measures:
    - name: "total_transport_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle transport orders. Baseline throughput measure for finished vehicle logistics volume."
    - name: "total_transport_cost_gross"
      expr: SUM(CAST(transport_cost_gross AS DOUBLE))
      comment: "Total gross transport cost across all vehicle transport orders. Primary cost KPI for finished vehicle logistics spend management."
    - name: "total_transport_cost_net"
      expr: SUM(CAST(transport_cost_net AS DOUBLE))
      comment: "Total net transport cost after tax. Used for P&L reporting and cost-per-vehicle analysis."
    - name: "total_transport_cost_tax"
      expr: SUM(CAST(transport_cost_tax AS DOUBLE))
      comment: "Total tax component of transport costs. Required for tax compliance and VAT reporting."
    - name: "avg_transport_cost_per_order"
      expr: AVG(CAST(transport_cost_net AS DOUBLE))
      comment: "Average net transport cost per vehicle transport order. Tracks cost efficiency and supports carrier rate benchmarking."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(on_time_delivery_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicle transport orders delivered on time. Top-tier KPI for dealer satisfaction, SLA compliance, and carrier performance management."
    - name: "expedite_rate"
      expr: ROUND(100.0 * SUM(CAST(is_expedited AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transport orders that were expedited. High expedite rates signal planning failures and drive premium cost — a key operational efficiency KPI."
    - name: "total_emission_co2_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions in kilograms from vehicle transport orders. Mandatory for ESG reporting, carbon footprint tracking, and regulatory compliance."
    - name: "avg_emission_co2_per_order"
      expr: AVG(CAST(emission_co2_kg AS DOUBLE))
      comment: "Average CO2 emissions per transport order. Benchmarks carrier and modal emissions efficiency for sustainability strategy."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered by vehicle transport orders in kilometers. Supports cost-per-km analysis and network optimization."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average transport distance per order. Informs lane optimization and hub-and-spoke network design decisions."
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight transported in tons. Drives capacity planning and weight-based freight rate validation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg-level operational KPIs covering segment cost, emissions, fuel consumption, and distance. Enables granular multi-leg logistics analysis for route optimization and carrier accountability."
  source: "`vibe_automotive_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the shipment leg (e.g., planned, in-transit, completed, delayed) for real-time pipeline visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this leg (e.g., road, rail, ocean, air) for modal cost and emissions benchmarking."
    - name: "load_type"
      expr: load_type
      comment: "Load type for this leg (e.g., FTL, LTL) for capacity utilization and cost-per-unit analysis."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost associated with the leg (e.g., linehaul, accessorial) for cost category analysis."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the leg cost for multi-currency financial consolidation."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status for cross-border legs, critical for trade compliance monitoring."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates hazardous material presence on this leg for compliance and risk segmentation."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Flags legs requiring temperature-controlled transport, used for specialized equipment cost analysis."
    - name: "planned_departure_timestamp"
      expr: DATE_TRUNC('month', planned_departure_timestamp)
      comment: "Month of planned departure for time-series leg volume and cost trend analysis."
  measures:
    - name: "total_shipment_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs. Baseline measure for multi-leg complexity and routing analysis."
    - name: "total_leg_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost across all shipment legs. Granular cost KPI for route-level P&L and carrier billing validation."
    - name: "avg_leg_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per shipment leg. Benchmarks leg-level cost efficiency across carriers, modes, and routes."
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions across shipment legs in kilograms. Core ESG KPI for carbon footprint reporting at the route segment level."
    - name: "avg_emissions_per_leg"
      expr: AVG(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Average CO2 emissions per shipment leg. Enables modal and carrier emissions benchmarking for decarbonization strategy."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across shipment legs in liters. Drives fuel cost management and efficiency improvement initiatives."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered across shipment legs in kilometers. Supports route optimization and cost-per-km benchmarking."
    - name: "avg_distance_per_leg"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance per shipment leg. Informs network design decisions and identifies consolidation opportunities."
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight transported across shipment legs in tons. Supports load factor analysis and capacity utilization optimization."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume transported across shipment legs in cubic meters. Enables volumetric utilization and space efficiency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_in_transit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory KPIs covering transport cost, emissions, fuel consumption, and temperature compliance for vehicles and parts in motion. Supports supply chain visibility and working capital management."
  source: "`vibe_automotive_v1`.`logistics`.`in_transit_inventory`"
  dimensions:
    - name: "transit_status"
      expr: transit_status
      comment: "Current transit status of the inventory (e.g., in-transit, arrived, delayed) for real-time supply chain visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the in-transit inventory for modal cost and performance analysis."
    - name: "load_type"
      expr: load_type
      comment: "Load type (e.g., FTL, LTL, container) for capacity utilization analysis."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status for cross-border in-transit inventory, critical for import/export compliance monitoring."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates hazardous material in transit for compliance and risk management."
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Flags temperature-controlled shipments for specialized handling cost and compliance analysis."
    - name: "delay_reason"
      expr: delay_reason
      comment: "Reason for transit delay, used for root-cause analysis and corrective action prioritization."
    - name: "transport_cost_currency"
      expr: transport_cost_currency
      comment: "Currency of transport cost for multi-currency financial consolidation."
    - name: "estimated_arrival_date"
      expr: DATE_TRUNC('month', estimated_arrival_date)
      comment: "Month of estimated arrival date for demand planning and inventory availability forecasting."
    - name: "actual_arrival_date"
      expr: DATE_TRUNC('month', actual_arrival_date)
      comment: "Month of actual arrival date for delivery performance trend analysis."
  measures:
    - name: "total_in_transit_records"
      expr: COUNT(1)
      comment: "Total number of in-transit inventory records. Baseline measure for supply chain pipeline volume and working capital exposure."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost for in-transit inventory. Tracks logistics spend on inventory in motion for cost control and accrual management."
    - name: "avg_transport_cost"
      expr: AVG(CAST(transport_cost_amount AS DOUBLE))
      comment: "Average transport cost per in-transit inventory record. Benchmarks cost efficiency across carriers and transport modes."
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from in-transit inventory movements. Core ESG KPI for supply chain carbon footprint reporting."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed for in-transit inventory transport. Drives fuel efficiency analysis and sustainability improvement programs."
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total weight of in-transit inventory in tons. Supports capacity planning and freight rate validation."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of in-transit inventory in cubic meters. Enables container utilization and space efficiency analysis."
    - name: "avg_temperature_max_c"
      expr: AVG(CAST(temperature_max_c AS DOUBLE))
      comment: "Average maximum temperature recorded for temperature-controlled in-transit inventory. Monitors cold chain compliance and product integrity risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle handover KPIs covering handover fee financials, on-time delivery, emissions, and condition quality at point of vehicle transfer to dealer or customer. Directly linked to customer satisfaction and revenue recognition."
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Current status of the vehicle handover (e.g., scheduled, completed, cancelled) for delivery pipeline management."
    - name: "handover_type"
      expr: handover_type
      comment: "Type of handover (e.g., dealer delivery, home delivery, fleet delivery) for channel-specific performance analysis."
    - name: "handover_condition"
      expr: handover_condition
      comment: "Condition of the vehicle at handover (e.g., perfect, minor damage, major damage) — critical quality KPI for customer satisfaction and warranty cost management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for vehicle delivery to handover point."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates cross-border handovers for international delivery compliance analysis."
    - name: "home_delivery_flag"
      expr: home_delivery_flag
      comment: "Flags home delivery handovers for last-mile cost and customer experience analysis."
    - name: "acceptance_signature_status"
      expr: acceptance_signature_status
      comment: "Status of customer acceptance signature at handover, used for legal and revenue recognition compliance."
    - name: "handover_fee_currency"
      expr: handover_fee_currency
      comment: "Currency of handover fee for multi-currency financial reporting."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing delivery responsibility at handover point."
    - name: "handover_timestamp"
      expr: DATE_TRUNC('month', handover_timestamp)
      comment: "Month of vehicle handover for time-series delivery volume and revenue recognition trend analysis."
    - name: "receiving_party_type"
      expr: receiving_party_type
      comment: "Type of receiving party (e.g., dealer, fleet customer, retail customer) for channel-level handover performance analysis."
  measures:
    - name: "total_handovers"
      expr: COUNT(1)
      comment: "Total number of vehicle handovers. Baseline measure for delivery volume and revenue recognition pipeline."
    - name: "total_handover_fee_gross"
      expr: SUM(CAST(handover_fee_amount AS DOUBLE))
      comment: "Total gross handover fee revenue. Tracks logistics service revenue associated with vehicle delivery and handover operations."
    - name: "total_handover_fee_net"
      expr: SUM(CAST(handover_fee_net_amount AS DOUBLE))
      comment: "Total net handover fee after tax. Used for net revenue reporting and margin analysis on delivery services."
    - name: "total_handover_fee_tax"
      expr: SUM(CAST(handover_fee_tax_amount AS DOUBLE))
      comment: "Total tax on handover fees. Required for tax compliance and VAT reporting on logistics service revenue."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(otd_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicle handovers completed on time. Top-tier KPI directly linked to dealer and customer satisfaction scores and SLA compliance."
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from vehicle handover transport. Contributes to ESG reporting and last-mile decarbonization tracking."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed in vehicle handover transport. Supports fuel cost management and efficiency benchmarking."
    - name: "avg_odometer_reading_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at vehicle handover in kilometers. Monitors pre-delivery mileage accumulation — high values indicate logistics inefficiency or compound dwell issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics lane KPIs covering network coverage, distance, and transit time characteristics. Supports lane rationalization, network design, and transport mode optimization decisions."
  source: "`vibe_automotive_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Current status of the lane (e.g., active, inactive, under review) for network coverage management."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (e.g., primary, secondary, spot) for strategic vs. tactical lane analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Primary transport mode for the lane for modal network analysis and optimization."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Indicates cross-border lanes for international trade network analysis."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for the lane, used to filter operational vs. dormant lanes in network analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country of the lane for geographic network coverage analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the lane for trade flow and network reach analysis."
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of logistics lanes. Baseline measure for network coverage and complexity."
    - name: "total_network_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered by all lanes in kilometers. Measures logistics network reach and supports cost-per-km benchmarking."
    - name: "avg_lane_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average lane distance in kilometers. Informs hub-and-spoke vs. direct route network design decisions."
    - name: "active_lane_count"
      expr: SUM(CAST(is_active AS INT))
      comment: "Count of currently active lanes. Tracks operational network size and supports lane rationalization initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_transport_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport rate KPIs covering rate levels, surcharges, and capacity parameters. Supports freight rate benchmarking, carrier contract management, and cost modeling."
  source: "`vibe_automotive_v1`.`logistics`.`transport_rate`"
  dimensions:
    - name: "transport_rate_status"
      expr: transport_rate_status
      comment: "Status of the transport rate (e.g., active, expired, pending) for rate validity management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode covered by the rate for modal rate benchmarking."
    - name: "container_type"
      expr: container_type
      comment: "Container type associated with the rate for equipment-specific cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transport rate for multi-currency rate comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the rate (e.g., per km, per ton, per CBM) for normalized rate comparison."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the rate is compliant with regulatory or contractual requirements."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Vehicle type covered by the rate for vehicle-class-specific cost analysis."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the rate became effective for rate trend and contract cycle analysis."
    - name: "effective_until"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Month the rate expires for proactive contract renewal management."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total number of transport rate records. Baseline measure for rate catalog size and coverage."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average transport rate amount. Core benchmarking KPI for carrier rate negotiations and market rate comparison."
    - name: "min_rate_amount"
      expr: MIN(CAST(rate_amount AS DOUBLE))
      comment: "Minimum transport rate in the catalog. Identifies best-available rates for cost optimization and carrier selection."
    - name: "max_rate_amount"
      expr: MAX(CAST(rate_amount AS DOUBLE))
      comment: "Maximum transport rate in the catalog. Flags premium rates for review and potential renegotiation."
    - name: "avg_fuel_surcharge_percent"
      expr: AVG(CAST(fuel_surcharge_percent AS DOUBLE))
      comment: "Average fuel surcharge percentage across transport rates. Tracks fuel cost pass-through exposure and informs hedging strategy."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges across rate records. Identifies ancillary cost exposure beyond base freight rates."
    - name: "avg_weight_capacity_tons"
      expr: AVG(CAST(weight_capacity_tons AS DOUBLE))
      comment: "Average weight capacity per transport rate. Supports load planning and capacity utilization optimization."
    - name: "avg_volume_capacity_cubic_meters"
      expr: AVG(CAST(volume_capacity_cubic_meters AS DOUBLE))
      comment: "Average volume capacity per transport rate in cubic meters. Enables volumetric utilization benchmarking and container selection optimization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_compound`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle compound (yard/storage facility) KPIs covering capacity utilization, dwell time, and operational capability. Drives compound network optimization, PDI throughput planning, and EV readiness assessment."
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_compound`"
  dimensions:
    - name: "vehicle_compound_status"
      expr: vehicle_compound_status
      comment: "Operational status of the compound (e.g., active, closed, under maintenance) for network availability management."
    - name: "compound_type"
      expr: compound_type
      comment: "Type of compound (e.g., PDI center, storage yard, distribution hub) for facility-type performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the compound is located for geographic network analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional classification of the compound for regional capacity planning."
    - name: "is_pdi_capable"
      expr: is_pdi_capable
      comment: "Indicates whether the compound can perform Pre-Delivery Inspection (PDI), critical for delivery readiness planning."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Flags temperature-controlled compounds for specialized vehicle storage (e.g., battery-sensitive EVs)."
    - name: "dangerous_goods_storage_flag"
      expr: dangerous_goods_storage_flag
      comment: "Indicates capability to store dangerous goods, used for compliance and routing decisions."
    - name: "security_level"
      expr: security_level
      comment: "Security level of the compound for risk management and high-value vehicle storage planning."
  measures:
    - name: "total_compounds"
      expr: COUNT(1)
      comment: "Total number of vehicle compounds in the network. Baseline measure for logistics infrastructure coverage."
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(average_dwell_time_hours AS DOUBLE))
      comment: "Average vehicle dwell time in hours across compounds. Critical KPI for compound throughput efficiency — high dwell times increase working capital costs and delay customer delivery."
    - name: "total_storage_area_sqft"
      expr: SUM(CAST(storage_area_sqft AS DOUBLE))
      comment: "Total storage area in square feet across all compounds. Measures total logistics infrastructure capacity for network planning."
    - name: "avg_otd_target_percentage"
      expr: AVG(CAST(otd_target_percentage AS DOUBLE))
      comment: "Average on-time delivery target percentage set for compounds. Benchmarks compound-level delivery commitments against actuals."
    - name: "pdi_capable_compound_count"
      expr: SUM(CAST(is_pdi_capable AS INT))
      comment: "Number of PDI-capable compounds in the network. Tracks PDI capacity availability for delivery readiness planning."
    - name: "ev_charging_capable_compound_count"
      expr: SUM(CASE WHEN ev_charging_slot_count IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of compounds with EV charging slots. Tracks EV logistics infrastructure readiness — a strategic KPI for the automotive industry's electrification transition."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude of compounds. Used for geographic centroid analysis in network optimization modeling."
$$;