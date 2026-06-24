-- Metric views for domain: logistics | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics covering freight cost efficiency, on-time delivery, weight/volume throughput, and hazmat exposure. Primary KPI surface for logistics operations and supply chain leadership."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. road, rail, air, sea) — key dimension for cost and lead-time benchmarking."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current lifecycle status of the shipment (e.g. in-transit, delivered, cancelled) — used to filter active vs. completed shipments."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level (e.g. standard, express, priority) — drives cost-vs-speed trade-off analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "International commercial terms governing risk and cost transfer — critical for trade compliance and cost allocation."
    - name: "direction"
      expr: direction
      comment: "Shipment direction (inbound / outbound) — separates supply-side from demand-side logistics flows."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials — used for regulatory compliance segmentation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold-chain shipments — used to segment premium-cost temperature-sensitive freight."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month bucket of scheduled delivery date — enables trend analysis of planned delivery volumes."
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location identifier — supports geographic distribution analysis of shipment flows."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight classification code — determines rate tiers and regulatory handling requirements."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records — baseline volume KPI for throughput and capacity planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight spend across all shipments — primary cost KPI for logistics budget management and carrier negotiation."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment — benchmarks unit shipping cost efficiency across carriers, modes, and lanes."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms — measures physical throughput volume for capacity and carrier utilization analysis."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volumetric throughput in cubic metres — used alongside weight to assess dimensional weight pricing exposure."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kg — indicates load consolidation efficiency; low averages signal under-utilised shipments."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across shipments — quantifies financial risk exposure in transit for risk management."
    - name: "hazmat_shipment_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of hazardous material shipments — tracks regulatory compliance exposure and special handling cost drivers."
    - name: "temperature_controlled_shipment_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of cold-chain shipments — quantifies premium freight volume requiring temperature-controlled equipment."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp <= CAST(scheduled_delivery_date AS TIMESTAMP) THEN 1 END)
      comment: "Count of shipments delivered on or before the scheduled delivery date — numerator for on-time delivery rate calculation."
    - name: "delivered_shipment_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of shipments with a confirmed delivery timestamp — denominator for on-time delivery rate and cycle-time metrics."
    - name: "freight_cost_per_kg"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0)
      comment: "Freight cost per kilogram shipped — normalised cost efficiency KPI enabling cross-mode and cross-carrier benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order execution metrics covering tendering efficiency, cost management, temperature and hazmat compliance, and carrier acceptance performance. Used by logistics managers and procurement to govern carrier relationships."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order (e.g. tendered, accepted, in-transit, completed) — primary lifecycle dimension."
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service requested (e.g. FTL, LTL, parcel) — drives cost structure and carrier selection."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type required for the freight order — used for capacity planning and carrier matching."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code governing cost and risk transfer — used for trade compliance and cost allocation analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority level (e.g. standard, urgent, critical) — used to analyse premium freight spend and SLA adherence."
    - name: "tender_method"
      expr: tender_method
      comment: "Method used to tender the freight order to carriers (e.g. spot, contract, auction) — informs procurement strategy."
    - name: "carrier_acceptance_status"
      expr: carrier_acceptance_status
      comment: "Whether the carrier accepted, rejected, or is pending on the freight order — key for tender acceptance rate analysis."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Indicates hazardous material freight orders — used for compliance segmentation and surcharge analysis."
    - name: "temperature_controlled_indicator"
      expr: temperature_controlled_indicator
      comment: "Indicates cold-chain freight orders — used to segment premium-cost temperature-sensitive freight."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the freight order was created — enables trend analysis of order volumes and freight spend over time."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders — baseline volume KPI for logistics throughput and carrier workload planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all orders — primary spend KPI for logistics cost management and budget tracking."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per order — unit cost efficiency benchmark for carrier and mode comparison."
    - name: "total_freight_rate_amount"
      expr: SUM(CAST(freight_rate_amount AS DOUBLE))
      comment: "Total contracted freight rate amount — compared against total_freight_cost to identify accessorial charge overruns."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges (detention, fuel surcharges, etc.) — quantifies cost above base rate; high values indicate operational inefficiency."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight tendered in freight orders (kg) — measures physical volume committed to carriers for capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volumetric freight tendered (m³) — used alongside weight for dimensional weight pricing and load optimisation."
    - name: "carrier_accepted_order_count"
      expr: COUNT(CASE WHEN carrier_acceptance_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of freight orders accepted by the carrier — numerator for carrier acceptance rate; low acceptance signals capacity or relationship issues."
    - name: "hazmat_order_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Number of hazardous material freight orders — tracks compliance exposure and special handling cost drivers."
    - name: "avg_temperature_max_c"
      expr: AVG(CAST(temperature_max_c AS DOUBLE))
      comment: "Average maximum temperature threshold across cold-chain orders — used to validate cold-chain compliance and equipment specification."
    - name: "freight_cost_per_kg"
      expr: SUM(CAST(total_freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(weight_kg AS DOUBLE)), 0)
      comment: "Freight cost per kilogram — normalised cost efficiency KPI enabling cross-carrier and cross-mode benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_delivery_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound delivery execution metrics covering on-time delivery performance, goods issue/receipt cycle times, freight cost, and packing/picking process adherence. Primary KPI surface for warehouse and distribution operations."
  source: "`vibe_manufacturing_v1`.`logistics`.`delivery_note`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery note (e.g. open, in-progress, completed) — primary lifecycle dimension for delivery tracking."
    - name: "delivery_direction"
      expr: delivery_direction
      comment: "Direction of the delivery (outbound / inbound / return) — separates supply-side from demand-side delivery flows."
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level of the delivery — used to analyse premium handling costs and SLA compliance by priority tier."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used (e.g. road, air, courier) — key dimension for cost and lead-time benchmarking."
    - name: "shipping_service_level"
      expr: shipping_service_level
      comment: "Service level agreed for the delivery (e.g. standard, express) — used to assess SLA adherence by tier."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing delivery risk and cost transfer — used for trade compliance and cost allocation."
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Status of the goods issue process — used to identify bottlenecks in warehouse outbound operations."
    - name: "packing_status"
      expr: packing_status
      comment: "Status of the packing process — used to track packing throughput and identify delays in outbound fulfilment."
    - name: "picking_status"
      expr: picking_status
      comment: "Status of the picking process — used to monitor warehouse picking efficiency and identify fulfilment bottlenecks."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('month', planned_delivery_date)
      comment: "Month bucket of planned delivery date — enables trend analysis of planned delivery volumes and on-time performance."
    - name: "proof_of_delivery_received"
      expr: proof_of_delivery_received
      comment: "Indicates whether proof of delivery has been received — used to track delivery confirmation compliance."
  measures:
    - name: "total_delivery_notes"
      expr: COUNT(1)
      comment: "Total number of delivery notes — baseline volume KPI for outbound fulfilment throughput."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total outbound freight cost across delivery notes — primary cost KPI for distribution spend management."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery note — unit cost efficiency benchmark for distribution operations."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped across delivery notes (kg) — measures physical throughput for warehouse and carrier capacity planning."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(total_net_weight_kg AS DOUBLE))
      comment: "Total net weight shipped (kg) — used alongside gross weight to calculate packaging weight overhead."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volumetric throughput (m³) — used for dimensional weight pricing analysis and load optimisation."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date THEN 1 END)
      comment: "Count of deliveries completed on or before the planned delivery date — numerator for on-time delivery rate."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > planned_delivery_date THEN 1 END)
      comment: "Count of deliveries completed after the planned delivery date — used to quantify service failures and SLA breach exposure."
    - name: "pod_received_count"
      expr: COUNT(CASE WHEN proof_of_delivery_received = TRUE THEN 1 END)
      comment: "Count of deliveries with confirmed proof of delivery — tracks delivery confirmation compliance and dispute resolution readiness."
    - name: "goods_issue_to_delivery_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, goods_issue_date) AS DOUBLE))
      comment: "Average days from goods issue to actual delivery — measures end-to-end outbound cycle time; a key operational efficiency KPI."
    - name: "packaging_weight_overhead_kg"
      expr: SUM((CAST(total_gross_weight_kg AS DOUBLE)) - (CAST(total_net_weight_kg AS DOUBLE)))
      comment: "Total packaging weight overhead (gross minus net weight, kg) — quantifies packaging material cost and sustainability impact."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound delivery performance metrics covering receipt accuracy, customs clearance, inspection compliance, freight cost, and delivery variance. Used by procurement, receiving operations, and supply chain leadership."
  source: "`vibe_manufacturing_v1`.`logistics`.`inbound_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the inbound delivery (e.g. pending, received, blocked) — primary lifecycle dimension."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt posting — used to track receiving process completion and identify backlogs."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for cross-border inbound deliveries — critical for import compliance and delay analysis."
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level of the inbound delivery — used to analyse expedite costs and supply urgency."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code governing inbound delivery risk and cost transfer — used for procurement cost allocation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of inbound goods — used for trade compliance, tariff analysis, and supply chain risk assessment."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity fields — required for accurate quantity aggregation and variance analysis."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether quality inspection is required — used to segment inspection-driven lead-time and cost impacts."
    - name: "blocked_stock_flag"
      expr: blocked_stock_flag
      comment: "Indicates whether received stock is blocked (e.g. quality hold) — used to track blocked inventory exposure."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month bucket of expected delivery date — enables trend analysis of inbound delivery volumes and lead-time performance."
  measures:
    - name: "total_inbound_deliveries"
      expr: COUNT(1)
      comment: "Total number of inbound delivery records — baseline volume KPI for receiving throughput and supplier activity."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across inbound deliveries — used as denominator for receipt accuracy and fill-rate calculations."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received — compared against ordered quantity to measure supplier fill rate and delivery accuracy."
    - name: "total_delivery_variance_quantity"
      expr: SUM(CAST(delivery_variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received — quantifies over/under delivery exposure across the supply base."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost — primary cost KPI for inbound logistics spend management and supplier freight terms analysis."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average inbound freight cost per delivery — unit cost benchmark for supplier and carrier performance comparison."
    - name: "on_time_receipt_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Count of inbound deliveries received on or before the expected date — numerator for supplier on-time delivery rate."
    - name: "late_receipt_count"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Count of inbound deliveries received after the expected date — quantifies supplier delivery failures and supply disruption risk."
    - name: "blocked_stock_delivery_count"
      expr: COUNT(CASE WHEN blocked_stock_flag = TRUE THEN 1 END)
      comment: "Count of inbound deliveries resulting in blocked stock — tracks quality-hold exposure and its impact on production availability."
    - name: "inspection_required_delivery_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Count of inbound deliveries requiring quality inspection — quantifies inspection workload and associated lead-time impact."
    - name: "receipt_fill_rate"
      expr: SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0)
      comment: "Ratio of quantity received to quantity ordered — measures supplier fill rate; values below 1.0 indicate under-delivery and potential production risk."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, expected_delivery_date) AS DOUBLE))
      comment: "Average days variance between actual and expected delivery date — negative values indicate early delivery; positive values indicate lateness. Key supplier performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg execution metrics covering transit time performance, delay analysis, freight cost per leg, route optimisation scores, and cross-dock/transshipment activity. Used by network design and operations teams."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the shipment leg (e.g. in-transit, completed, delayed) — primary lifecycle dimension for leg-level tracking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this leg (e.g. road, rail, air, sea) — key dimension for cost and transit-time benchmarking."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Service level provided by the carrier for this leg — used to assess SLA adherence at the leg level."
    - name: "load_type"
      expr: load_type
      comment: "Load type for the leg (e.g. FTL, LTL, parcel) — drives cost structure and consolidation analysis."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for leg delays — used to identify systemic delay causes and drive corrective action."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for cross-border legs — used for import/export compliance and delay attribution."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether this leg involves cross-docking — used to analyse cross-dock network utilisation and cost impact."
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Indicates whether this leg involves transshipment — used to assess multi-modal complexity and associated cost/time penalties."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous material on this leg — used for compliance segmentation and surcharge analysis."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle used for this leg — used for equipment utilisation and cost benchmarking."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_timestamp)
      comment: "Month bucket of scheduled departure — enables trend analysis of leg volumes and on-time departure performance."
  measures:
    - name: "total_shipment_legs"
      expr: COUNT(1)
      comment: "Total number of shipment legs — baseline volume KPI for network complexity and carrier workload analysis."
    - name: "total_leg_freight_cost"
      expr: SUM(CAST(leg_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipment legs — primary cost KPI for leg-level spend management and network cost optimisation."
    - name: "avg_leg_freight_cost"
      expr: AVG(CAST(leg_freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment leg — unit cost benchmark for carrier and mode comparison at the leg level."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge costs across legs — quantifies fuel price exposure and informs fuel hedging and carrier contract strategy."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges across legs — identifies cost overruns above base freight rates driven by operational inefficiencies."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time per leg in hours — key operational efficiency KPI for network design and carrier SLA management."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all shipment legs — quantifies aggregate delay impact on supply chain lead times."
    - name: "avg_delay_hours_per_leg"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay hours per shipment leg — benchmarks carrier and route reliability; high values trigger SLA review."
    - name: "total_distance_km"
      expr: SUM(CAST(leg_distance_km AS DOUBLE))
      comment: "Total distance covered across all shipment legs (km) — used for carbon emission calculations and cost-per-km benchmarking."
    - name: "avg_route_optimisation_score"
      expr: AVG(CAST(route_optimization_score AS DOUBLE))
      comment: "Average route optimisation score across legs — measures how efficiently routes are planned; low scores indicate network optimisation opportunities."
    - name: "delayed_leg_count"
      expr: COUNT(CASE WHEN delay_duration_hours > 0 THEN 1 END)
      comment: "Count of shipment legs with recorded delays — used to calculate delay frequency rate and identify systemic reliability issues."
    - name: "freight_cost_per_km"
      expr: SUM(CAST(leg_freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(leg_distance_km AS DOUBLE)), 0)
      comment: "Freight cost per kilometre across legs — normalised cost efficiency KPI for lane and carrier benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master performance and risk metrics covering on-time delivery rates, safety scores, claims ratios, insurance coverage, and EDI capability. Used by procurement and logistics leadership for carrier qualification and contract management."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (e.g. active, suspended, inactive) — primary dimension for carrier portfolio health analysis."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g. asset-based, broker, NVOCC) — used to segment carrier portfolio by business model."
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode offered by the carrier (e.g. road, air, ocean, rail) — key dimension for mode-level carrier benchmarking."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the carrier contract (e.g. active, expired, under negotiation) — used to track contract coverage and renewal risk."
    - name: "safety_rating"
      expr: safety_rating
      comment: "Regulatory safety rating of the carrier — used for compliance qualification and risk-based carrier selection."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates whether the carrier is certified to handle hazardous materials — used for compliance-based carrier selection."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the carrier offers temperature-controlled services — used to segment cold-chain capable carriers."
    - name: "edi_capability_flag"
      expr: edi_capability_flag
      comment: "Indicates whether the carrier supports EDI integration — used to assess digital integration maturity of the carrier base."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country where the carrier is headquartered — used for geographic coverage and regulatory jurisdiction analysis."
    - name: "contract_expiry_month"
      expr: DATE_TRUNC('month', contract_expiry_date)
      comment: "Month of contract expiry — used to identify upcoming contract renewals and manage procurement pipeline."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carrier records — baseline KPI for carrier portfolio size and diversity management."
    - name: "avg_on_time_delivery_percentage"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers — primary carrier performance KPI used in QBRs and contract negotiations."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score across carriers — used for risk-based carrier qualification and regulatory compliance monitoring."
    - name: "avg_claims_ratio"
      expr: AVG(CAST(claims_ratio AS DOUBLE))
      comment: "Average claims ratio across carriers — measures cargo damage and loss frequency; high values indicate carrier reliability risk."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across all carriers — quantifies aggregate risk coverage in the carrier portfolio."
    - name: "avg_insurance_coverage"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage per carrier — used to assess whether carriers meet minimum coverage thresholds for risk management."
    - name: "active_carrier_count"
      expr: COUNT(CASE WHEN carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active carriers — measures the size of the qualified carrier base available for freight tendering."
    - name: "hazmat_certified_carrier_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Count of hazmat-certified carriers — quantifies the available pool of compliant carriers for hazardous material shipments."
    - name: "edi_capable_carrier_count"
      expr: COUNT(CASE WHEN edi_capability_flag = TRUE THEN 1 END)
      comment: "Count of EDI-capable carriers — measures digital integration coverage of the carrier base; low values indicate manual process risk."
    - name: "expiring_contracts_count"
      expr: COUNT(CASE WHEN contract_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of carrier contracts expiring within the next 90 days — proactive procurement KPI to prevent coverage gaps and forced spot market exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier contract financial and compliance metrics covering rate structures, volume commitments, detention costs, damage liability, and contract renewal risk. Used by procurement and logistics finance for contract governance."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the carrier contract (e.g. active, expired, terminated) — primary lifecycle dimension."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of carrier contract (e.g. spot, annual, multi-year) — used to segment contract portfolio by commitment horizon."
    - name: "service_mode"
      expr: service_mode
      comment: "Service mode covered by the contract (e.g. road, air, ocean) — used for mode-level contract coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — used for multi-currency spend normalisation and FX risk analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — used to identify contracts requiring active renewal management."
    - name: "insurance_coverage_required_flag"
      expr: insurance_coverage_required_flag
      comment: "Indicates whether minimum insurance coverage is contractually required — used for compliance monitoring."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of the contract — used to assess lane coverage and identify gaps in contracted carrier network."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract became effective — used for contract vintage analysis and spend trend tracking."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the contract expires — used to manage contract renewal pipeline and prevent coverage gaps."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of carrier contracts — baseline KPI for contract portfolio size and procurement coverage."
    - name: "total_minimum_volume_commitment"
      expr: SUM(CAST(minimum_volume_commitment AS DOUBLE))
      comment: "Total minimum volume committed across all carrier contracts — quantifies contractual volume obligations and under-utilisation risk."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average contracted on-time delivery target percentage — used to benchmark contracted SLA levels against actual carrier performance."
    - name: "total_damage_claim_liability"
      expr: SUM(CAST(damage_claim_liability_limit AS DOUBLE))
      comment: "Total damage claim liability limits across contracts — quantifies maximum financial exposure from cargo damage claims."
    - name: "avg_detention_charge_per_hour"
      expr: AVG(CAST(detention_charge_per_hour AS DOUBLE))
      comment: "Average contracted detention charge per hour — used to benchmark detention cost exposure and negotiate favourable terms."
    - name: "total_insurance_minimum_coverage"
      expr: SUM(CAST(insurance_minimum_coverage_amount AS DOUBLE))
      comment: "Total minimum insurance coverage required across contracts — quantifies contractual risk protection requirements."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active carrier contracts — measures the size of the governed carrier contract base."
    - name: "expiring_contracts_90d_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of contracts expiring within 90 days — proactive procurement KPI to prevent uncontracted carrier exposure and spot market cost spikes."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of contracts set to auto-renew — used to identify contracts that may renew without active renegotiation, potentially locking in unfavourable terms."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_transport_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport route network metrics covering route cost efficiency, transit time standards, carbon emission factors, hazmat approval coverage, and seasonal restriction exposure. Used by network design and sustainability teams."
  source: "`vibe_manufacturing_v1`.`logistics`.`transport_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Operational status of the transport route (e.g. active, inactive, under review) — primary dimension for network coverage analysis."
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g. direct, multi-stop, cross-dock) — used to segment network complexity and cost structure."
    - name: "primary_transport_mode"
      expr: primary_transport_mode
      comment: "Primary transport mode for the route (e.g. road, rail, air, ocean) — key dimension for mode-level network analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of route origin — used for geographic network coverage and trade lane analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of route destination — used for geographic network coverage and cross-border compliance analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level standard for the route (e.g. standard, express) — used to segment routes by speed and cost tier."
    - name: "hazmat_approved"
      expr: hazmat_approved
      comment: "Indicates whether the route is approved for hazardous material transport — used for compliance-based route selection."
    - name: "customs_clearance_required"
      expr: customs_clearance_required
      comment: "Indicates whether customs clearance is required on this route — used to identify cross-border complexity and associated lead-time."
    - name: "seasonal_restriction_flag"
      expr: seasonal_restriction_flag
      comment: "Indicates whether the route has seasonal restrictions — used for network contingency planning and seasonal capacity management."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the route supports temperature-controlled transport — used to assess cold-chain network coverage."
    - name: "optimization_priority"
      expr: optimization_priority
      comment: "Route optimisation priority (e.g. cost, speed, sustainability) — used to align route selection with strategic objectives."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of transport routes — baseline KPI for network coverage breadth."
    - name: "avg_standard_transit_time_days"
      expr: AVG(CAST(standard_transit_time_days AS DOUBLE))
      comment: "Average standard transit time across routes (days) — key network design KPI for lead-time planning and customer promise setting."
    - name: "avg_minimum_transit_time_days"
      expr: AVG(CAST(minimum_transit_time_days AS DOUBLE))
      comment: "Average minimum transit time across routes (days) — used to assess best-case lead-time capability for express service design."
    - name: "avg_maximum_transit_time_days"
      expr: AVG(CAST(maximum_transit_time_days AS DOUBLE))
      comment: "Average maximum transit time across routes (days) — used to quantify worst-case lead-time exposure for customer SLA risk management."
    - name: "total_standard_freight_cost"
      expr: SUM(CAST(standard_freight_cost AS DOUBLE))
      comment: "Total standard freight cost across all routes — used for network cost baseline and budget planning."
    - name: "avg_cost_per_km"
      expr: AVG(CAST(cost_per_km AS DOUBLE))
      comment: "Average freight cost per kilometre across routes — normalised cost efficiency KPI for route and mode benchmarking."
    - name: "total_network_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered by all transport routes (km) — measures network geographic reach and informs carbon footprint calculations."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor_kg_per_km AS DOUBLE))
      comment: "Average carbon emission factor across routes (kg CO₂ per km) — primary sustainability KPI for network decarbonisation strategy."
    - name: "total_carbon_emission_potential_kg"
      expr: SUM(CAST(carbon_emission_factor_kg_per_km AS DOUBLE) * CAST(distance_km AS DOUBLE))
      comment: "Total potential carbon emissions across all routes (kg CO₂) — quantifies network-level carbon footprint for ESG reporting and decarbonisation planning."
    - name: "hazmat_approved_route_count"
      expr: COUNT(CASE WHEN hazmat_approved = TRUE THEN 1 END)
      comment: "Count of routes approved for hazardous material transport — quantifies compliant route availability for hazmat shipment planning."
    - name: "seasonal_restricted_route_count"
      expr: COUNT(CASE WHEN seasonal_restriction_flag = TRUE THEN 1 END)
      comment: "Count of routes with seasonal restrictions — quantifies network vulnerability to seasonal disruptions and informs contingency planning."
    - name: "active_route_count"
      expr: COUNT(CASE WHEN route_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active transport routes — measures the operational network size available for shipment planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of lading compliance and freight cost metrics covering declared value, freight charges, weight, hazmat exposure, temperature-controlled shipments, and delivery performance. Used by trade compliance, finance, and logistics operations."
  source: "`vibe_manufacturing_v1`.`logistics`.`bill_of_lading`"
  dimensions:
    - name: "bill_of_lading_status"
      expr: bill_of_lading_status
      comment: "Current status of the bill of lading (e.g. issued, in-transit, delivered, cancelled) — primary lifecycle dimension."
    - name: "bol_type"
      expr: bol_type
      comment: "Type of bill of lading (e.g. straight, order, negotiable) — used for trade finance and compliance segmentation."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport on the BOL (e.g. road, ocean, air) — key dimension for freight cost and compliance analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g. prepaid, collect, third-party) — used for cost allocation and billing analysis."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight classification code — determines rate tiers and regulatory handling requirements."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous material on the BOL — used for regulatory compliance segmentation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold-chain BOLs — used to segment premium-cost temperature-sensitive freight."
    - name: "shipper_country_code"
      expr: shipper_country_code
      comment: "Country of the shipper — used for trade lane and export compliance analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the BOL was issued — enables trend analysis of shipment volumes and freight charges over time."
  measures:
    - name: "total_bills_of_lading"
      expr: COUNT(1)
      comment: "Total number of bills of lading — baseline volume KPI for shipment documentation throughput."
    - name: "total_freight_charge"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges across all BOLs — primary cost KPI for freight spend management and carrier invoice reconciliation."
    - name: "avg_freight_charge_per_bol"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per BOL — unit cost benchmark for carrier and mode comparison."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value across all BOLs — quantifies financial risk exposure in transit for insurance and trade compliance purposes."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight AS DOUBLE))
      comment: "Total weight across all BOLs — measures physical freight throughput for capacity and carrier utilisation analysis."
    - name: "avg_weight_per_bol"
      expr: AVG(CAST(total_weight AS DOUBLE))
      comment: "Average weight per BOL — indicates load consolidation efficiency; low averages signal under-utilised shipments."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Count of BOLs with actual delivery on or before expected date — numerator for BOL-level on-time delivery rate."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Count of BOLs with late delivery — quantifies carrier service failures at the shipment documentation level."
    - name: "hazmat_bol_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Count of hazardous material BOLs — tracks regulatory compliance exposure and special handling documentation requirements."
    - name: "freight_charge_to_declared_value_ratio"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(declared_value_amount AS DOUBLE)), 0)
      comment: "Ratio of total freight charges to total declared value — measures freight cost as a proportion of cargo value; high ratios indicate freight cost inefficiency relative to shipment value."
$$;