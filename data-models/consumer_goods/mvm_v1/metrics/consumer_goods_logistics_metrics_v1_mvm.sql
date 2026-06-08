-- Metric views for domain: logistics | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance metrics tracking OTIF compliance, freight cost efficiency, and exception rates across all customer deliveries. Core operational KPI layer for logistics service quality management."
  source: "`consumer_goods_ecm`.`logistics`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. delivered, failed, in-transit) for segmenting performance by outcome."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g. DSD, 3PL, direct) enabling channel-level performance analysis."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier identifier on the delivery record for carrier-level performance benchmarking."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating whether cold chain handling was required, enabling temperature-sensitive delivery analysis."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('day', scheduled_delivery_date)
      comment: "Scheduled delivery date truncated to day for time-series trending of delivery volumes and performance."
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled delivery date truncated to month for monthly OTIF and freight cost trend reporting."
    - name: "goods_condition_code"
      expr: goods_condition_code
      comment: "Condition of goods upon delivery (e.g. intact, damaged) for quality and claims analysis."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded on the delivery for root-cause analysis of delivery failures."
    - name: "pod_source"
      expr: pod_source
      comment: "Source of proof-of-delivery confirmation (e.g. electronic, paper) for compliance tracking."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery records. Baseline volume metric for normalizing all delivery KPIs."
    - name: "otif_deliveries"
      expr: SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries that were both on-time and in-full. Numerator for OTIF rate calculation — the primary supply chain service level KPI."
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries completed on or before the scheduled delivery timestamp. Numerator for on-time delivery rate."
    - name: "in_full_deliveries"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries where the full ordered quantity was delivered. Numerator for in-full delivery rate."
    - name: "exception_deliveries"
      expr: SUM(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 ELSE 0 END)
      comment: "Count of deliveries with a recorded exception code. Drives exception rate KPI and root-cause investigation prioritization."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries. Core cost metric for logistics spend management and carrier cost benchmarking."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery record. Used to benchmark carrier efficiency and identify cost outliers."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity of goods delivered across all delivery records. Throughput metric for logistics capacity planning."
    - name: "total_refused_quantity"
      expr: SUM(CAST(refused_quantity AS DOUBLE))
      comment: "Total quantity refused at point of delivery. Elevated refused quantity signals quality, compliance, or scheduling issues requiring intervention."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all deliveries. Denominator for fill-rate calculations and demand fulfillment analysis."
    - name: "electronic_pod_deliveries"
      expr: SUM(CASE WHEN electronic_signature_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliveries confirmed via electronic signature. Tracks digital POD adoption rate, which reduces disputes and accelerates invoice processing."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level metrics covering freight cost, OTIF performance, weight/volume throughput, and cold chain compliance. Primary KPI layer for end-to-end shipment management and carrier performance evaluation."
  source: "`consumer_goods_ecm`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, exception) for pipeline visibility and SLA monitoring."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. road, rail, air, ocean) for modal cost and performance benchmarking."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level (e.g. standard, express, overnight) for SLA compliance analysis."
    - name: "direction"
      expr: direction
      comment: "Shipment direction (inbound/outbound) for separating supply-side from demand-side logistics flows."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating cold chain requirement for temperature-sensitive product compliance tracking."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous materials shipment for regulatory compliance and risk monitoring."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms code governing freight responsibility and cost allocation."
    - name: "planned_ship_month"
      expr: DATE_TRUNC('month', planned_ship_date)
      comment: "Planned ship date truncated to month for monthly shipment volume and cost trend analysis."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Actual delivery date truncated to month for monthly OTIF performance trending."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g. prepaid, collect) for cost responsibility segmentation."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code on the shipment for root-cause analysis of delivery failures and disruptions."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline volume metric for normalizing all shipment KPIs."
    - name: "otif_shipments"
      expr: SUM(CASE WHEN otif_on_time = TRUE AND otif_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments that were both on-time and in-full. Numerator for OTIF rate — the primary logistics service level KPI used in retailer scorecards."
    - name: "on_time_shipments"
      expr: SUM(CASE WHEN otif_on_time = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on or before the planned delivery date. Numerator for on-time delivery rate."
    - name: "in_full_shipments"
      expr: SUM(CASE WHEN otif_in_full = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered with full quantity. Numerator for in-full rate, indicating supply availability and order fulfillment quality."
    - name: "pod_received_shipments"
      expr: SUM(CASE WHEN pod_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments with proof of delivery received. Tracks POD completion rate, which gates invoice processing and dispute resolution."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipments. Primary logistics cost metric for budget management and carrier spend analysis."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Used to benchmark carrier efficiency and detect cost anomalies."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge amount across all shipments. Tracks variable cost exposure to fuel price fluctuations for procurement negotiations."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms. Capacity utilization and freight rate optimization metric."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used alongside weight for load factor and density-based rate analysis."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Informs load planning and carrier capacity negotiations."
    - name: "exception_shipments"
      expr: SUM(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 ELSE 0 END)
      comment: "Count of shipments with a recorded exception. Elevated exception rate signals systemic carrier or lane issues requiring escalation."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering invoiced amounts, contracted vs. actual variance, dispute rates, and payment compliance. Enables freight audit, cost control, and carrier billing accuracy management."
  source: "`consumer_goods_ecm`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the freight invoice (e.g. approved, disputed, paid) for accounts payable pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of freight invoice (e.g. line-haul, accessorial, fuel surcharge) for cost category analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport on the invoice for modal cost benchmarking."
    - name: "service_level"
      expr: service_level
      comment: "Service level on the invoice for SLA-cost correlation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency freight spend consolidation."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country of the shipment for geographic freight cost analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the shipment for lane-level cost benchmarking."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for monthly freight spend trend reporting."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating cold chain shipment for premium freight cost segmentation."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating hazardous materials for regulatory surcharge cost tracking."
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for invoice disputes enabling root-cause analysis of billing discrepancies."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for cash flow and early payment discount analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices. Baseline volume metric for invoice processing throughput analysis."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_total_amount AS DOUBLE))
      comment: "Total amount invoiced by carriers. Primary freight spend metric for budget vs. actual cost management."
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted freight amount. Denominator for freight audit variance analysis — identifies overbilling vs. contracted rates."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved payment amount after audit. Represents actual committed freight spend post-audit."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and contracted amounts. Positive variance indicates overbilling; a key freight audit recovery metric."
    - name: "total_line_haul_amount"
      expr: SUM(CAST(line_haul_amount AS DOUBLE))
      comment: "Total line-haul freight charges. Core transportation cost component for carrier rate benchmarking."
    - name: "total_fuel_surcharge_amount"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge billed. Tracks variable cost exposure to fuel price movements across the carrier base."
    - name: "total_accessorial_amount"
      expr: SUM(CAST(accessorial_amount AS DOUBLE))
      comment: "Total accessorial charges (e.g. detention, liftgate). Elevated accessorials signal operational inefficiencies at origin or destination."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on freight invoices. Required for accurate freight cost accounting and tax compliance reporting."
    - name: "avg_invoiced_amount"
      expr: AVG(CAST(invoiced_total_amount AS DOUBLE))
      comment: "Average invoiced amount per freight invoice. Used to detect billing anomalies and benchmark carrier pricing."
    - name: "disputed_invoices"
      expr: SUM(CASE WHEN dispute_reason_code IS NOT NULL AND dispute_reason_code <> '' THEN 1 ELSE 0 END)
      comment: "Count of invoices with a dispute reason code. Dispute rate is a key freight audit KPI indicating carrier billing accuracy."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Total shipment weight billed across all freight invoices. Used to calculate cost-per-kg efficiency metrics."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order execution metrics covering cost, weight, volume, on-time pickup/delivery, and carrier tendering performance. Enables TMS-level operational management and freight procurement decision-making."
  source: "`consumer_goods_ecm`.`logistics`.`freight_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the freight order (e.g. tendered, in-transit, delivered) for pipeline visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the freight order enabling modal cost and performance benchmarking."
    - name: "service_level"
      expr: service_level
      comment: "Service level of the freight order for SLA compliance and cost-to-serve analysis."
    - name: "direction"
      expr: direction
      comment: "Freight order direction (inbound/outbound) for separating procurement vs. distribution logistics flows."
    - name: "load_type"
      expr: load_type
      comment: "Load type (e.g. FTL, LTL, parcel) for load optimization and rate benchmarking."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type used for the freight order for asset utilization and capacity planning."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing cost and risk transfer for trade compliance analysis."
    - name: "tendering_method"
      expr: tendering_method
      comment: "Method used to tender the freight order (e.g. spot, contract, auction) for procurement strategy analysis."
    - name: "freight_audit_status"
      expr: freight_audit_status
      comment: "Audit status of the freight order for invoice reconciliation pipeline management."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Requested delivery date truncated to month for monthly freight order volume and cost trending."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating cold chain requirement for temperature-sensitive freight cost segmentation."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating hazardous materials for regulatory compliance cost tracking."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total number of freight orders. Baseline volume metric for logistics throughput and capacity planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total freight cost across all freight orders. Primary cost metric for logistics spend management and carrier contract performance."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per order. Benchmarks carrier pricing efficiency and detects cost anomalies by lane or mode."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge across all freight orders. Tracks variable cost exposure to fuel price volatility."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms. Capacity utilization and freight rate optimization metric."
    - name: "avg_gross_weight_per_order_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per freight order. Informs load planning and LTL vs. FTL consolidation decisions."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume shipped in cubic meters. Used with weight for density-based rate analysis and load optimization."
    - name: "pod_received_orders"
      expr: SUM(CASE WHEN pod_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of freight orders with proof of delivery received. POD completion rate gates invoice processing and dispute resolution."
    - name: "agreed_freight_rate_total"
      expr: SUM(CAST(agreed_freight_rate AS DOUBLE))
      comment: "Sum of agreed freight rates across all orders. Used as the contracted cost baseline for freight audit variance analysis."
    - name: "avg_agreed_freight_rate"
      expr: AVG(CAST(agreed_freight_rate AS DOUBLE))
      comment: "Average agreed freight rate per order. Benchmarks contracted rate levels across carriers, lanes, and modes."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route execution metrics covering distance efficiency, fuel consumption, CO2 emissions, vehicle utilization, and OTIF compliance. Enables last-mile and DSD route optimization and sustainability reporting."
  source: "`consumer_goods_ecm`.`logistics`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the route (e.g. planned, in-progress, completed) for operational pipeline visibility."
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g. DSD, inter-DC, last-mile) for segmenting route performance by distribution model."
    - name: "is_dsd"
      expr: is_dsd
      comment: "Flag indicating Direct Store Delivery route for DSD-specific performance benchmarking."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Flag indicating cold chain route for temperature-sensitive delivery compliance tracking."
    - name: "otif_compliant"
      expr: otif_compliant
      comment: "Flag indicating whether the route met OTIF requirements for service level compliance analysis."
    - name: "route_date"
      expr: DATE_TRUNC('day', route_date)
      comment: "Route execution date for daily operational performance trending."
    - name: "route_month"
      expr: DATE_TRUNC('month', route_date)
      comment: "Route date truncated to month for monthly efficiency and cost trend reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of route freight cost for multi-currency cost consolidation."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of routes executed. Baseline volume metric for fleet utilization and route planning analysis."
    - name: "otif_compliant_routes"
      expr: SUM(CASE WHEN otif_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of routes meeting OTIF requirements. Numerator for route-level OTIF rate — a key last-mile service quality KPI."
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance driven across all routes. Core metric for fuel cost modeling and route efficiency benchmarking."
    - name: "total_planned_distance_km"
      expr: SUM(CAST(planned_distance_km AS DOUBLE))
      comment: "Total planned distance across all routes. Denominator for distance efficiency ratio (actual vs. planned)."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all routes. Directly drives fuel cost and carbon footprint calculations."
    - name: "avg_fuel_consumption_per_route"
      expr: AVG(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Average fuel consumption per route. Benchmarks driver and vehicle fuel efficiency for fleet management decisions."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions across all routes in kilograms. Primary sustainability KPI for ESG reporting and carbon reduction target tracking."
    - name: "avg_co2_per_route_kg"
      expr: AVG(CAST(co2_emissions_kg AS DOUBLE))
      comment: "Average CO2 emissions per route. Used to benchmark route-level carbon intensity and prioritize decarbonization initiatives."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all routes. Enables cost-per-stop and cost-per-km efficiency analysis."
    - name: "avg_vehicle_capacity_utilization_pct"
      expr: AVG(CAST(vehicle_capacity_utilization_pct AS DOUBLE))
      comment: "Average vehicle capacity utilization percentage across routes. Low utilization indicates consolidation opportunities; high utilization may signal capacity constraints."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume delivered across all routes in cubic meters. Used with capacity utilization for load density analysis."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight delivered across all routes in kilograms. Supports payload utilization and weight-based cost allocation."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_tracking_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking event metrics covering exception rates, temperature breaches, financial impact of disruptions, and carrier SLA compliance. Enables real-time visibility and proactive exception management."
  source: "`consumer_goods_ecm`.`logistics`.`tracking_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of tracking event (e.g. pickup, in-transit, delivered, exception) for event-level performance analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the tracking event for pipeline visibility and exception triage."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the tracked shipment for modal exception rate benchmarking."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag indicating whether the tracking event represents an exception for exception rate analysis."
    - name: "temperature_breach"
      expr: temperature_breach
      comment: "Flag indicating a temperature breach event for cold chain compliance monitoring."
    - name: "carrier_sla_met"
      expr: carrier_sla_met
      comment: "Flag indicating whether the carrier met its SLA at this event for carrier scorecard analysis."
    - name: "event_country_code"
      expr: event_country_code
      comment: "Country where the tracking event occurred for geographic exception and delay analysis."
    - name: "exception_root_cause_code"
      expr: exception_root_cause_code
      comment: "Root cause code for exception events enabling systemic issue identification and corrective action prioritization."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Event timestamp truncated to month for monthly exception rate and SLA compliance trending."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status for cross-border shipment delay analysis."
  measures:
    - name: "total_tracking_events"
      expr: COUNT(1)
      comment: "Total number of tracking events. Baseline volume metric for shipment visibility coverage analysis."
    - name: "exception_events"
      expr: SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tracking events flagged as exceptions. Numerator for exception rate — a key carrier performance and supply chain risk KPI."
    - name: "temperature_breach_events"
      expr: SUM(CASE WHEN temperature_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tracking events with a temperature breach. Critical cold chain compliance KPI — breaches can trigger product recalls and regulatory penalties."
    - name: "carrier_sla_met_events"
      expr: SUM(CASE WHEN carrier_sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tracking events where the carrier met its SLA. Numerator for carrier SLA compliance rate used in carrier scorecards."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of tracking events (e.g. delays, exceptions). Quantifies the monetary cost of supply chain disruptions for executive risk reporting."
    - name: "avg_financial_impact_per_exception"
      expr: AVG(CASE WHEN exception_flag = TRUE THEN CAST(financial_impact_amount AS DOUBLE) END)
      comment: "Average financial impact per exception event. Prioritizes exception types by economic severity for corrective action investment decisions."
    - name: "distinct_shipments_tracked"
      expr: COUNT(DISTINCT logistics_shipment_id)
      comment: "Count of distinct shipments with at least one tracking event. Measures tracking coverage across the shipment portfolio."
    - name: "avg_temperature_at_event"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average recorded temperature across all tracking events. Used to monitor cold chain integrity and detect systematic temperature drift."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof of delivery metrics covering discrepancy rates, cold chain compliance, electronic POD adoption, and dispute resolution performance. Enables last-mile quality assurance and accounts receivable acceleration."
  source: "`consumer_goods_ecm`.`logistics`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery at POD capture for outcome-level performance analysis."
    - name: "pod_source"
      expr: pod_source
      comment: "Source system or channel of the POD record for data quality and coverage analysis."
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled delivery date truncated to month for monthly POD performance trending."
    - name: "otif_flag"
      expr: otif_flag
      comment: "OTIF flag on the POD record for last-mile OTIF compliance analysis."
  measures:
    - name: "total_pod_records"
      expr: COUNT(1)
      comment: "Total number of proof of delivery records. Baseline volume metric for POD coverage and completeness analysis."
    - name: "electronic_signature_pods"
      expr: SUM(CASE WHEN electronic_signature_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PODs confirmed via electronic signature. Tracks digital POD adoption rate, which accelerates invoice processing and reduces dispute resolution time."
    - name: "otif_pod_records"
      expr: SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of POD records with OTIF flag set. Numerator for last-mile OTIF rate as confirmed at point of delivery."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity confirmed as delivered across all POD records. Used to calculate fill rate and identify systemic short-delivery patterns."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all POD records. Denominator for POD-confirmed fill rate calculation."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_shipment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment item-level metrics covering shipped vs. ordered quantity fill rates, line value, weight, volume, and quality hold rates. Enables SKU-level logistics performance and cost-to-serve analysis."
  source: "`consumer_goods_ecm`.`logistics`.`shipment_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Status of the shipment item (e.g. shipped, held, rejected) for fulfillment pipeline analysis."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type of the shipment item for packaging efficiency and damage rate analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the shipment item for trade compliance and sourcing analysis."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating hazardous material item for regulatory compliance cost tracking."
    - name: "is_temperature_sensitive"
      expr: is_temperature_sensitive
      comment: "Flag indicating temperature-sensitive item for cold chain compliance and premium freight cost segmentation."
    - name: "is_dsd"
      expr: is_dsd
      comment: "Flag indicating Direct Store Delivery item for DSD channel performance analysis."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Flag indicating the item is on quality hold for supply chain quality risk monitoring."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the shipment item for quantity normalization across product categories."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Shipment item creation date truncated to month for monthly volume and value trend analysis."
  measures:
    - name: "total_shipment_items"
      expr: COUNT(1)
      comment: "Total number of shipment item lines. Baseline volume metric for order line fulfillment throughput."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipment item lines. Primary fulfillment throughput metric."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all shipment item lines. Denominator for item-level fill rate calculation."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed quantity across all shipment item lines. Represents committed supply for demand fulfillment analysis."
    - name: "total_line_value"
      expr: SUM(CAST(line_value AS DOUBLE))
      comment: "Total value of all shipment item lines. Revenue-at-risk metric for logistics disruption impact quantification."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all shipment items. Used for cost-to-serve analysis and freight cost allocation per unit."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all shipment items in kilograms. Drives freight rate calculation and load planning."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight of all shipment items in kilograms. Used for customs declarations and weight-based duty calculations."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of all shipment items in cubic meters. Used for load density analysis and volumetric freight rate optimization."
    - name: "quality_hold_items"
      expr: SUM(CASE WHEN quality_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipment items on quality hold. Elevated quality hold rate signals upstream manufacturing or supplier quality issues requiring intervention."
    - name: "distinct_skus_shipped"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs shipped. Measures product breadth in logistics flows for assortment and distribution planning."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master metrics covering fleet capability, compliance status, insurance coverage, and payload capacity. Enables carrier qualification, risk management, and procurement decision-making."
  source: "`consumer_goods_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (e.g. active, suspended, inactive) for carrier base health monitoring."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g. asset-based, broker, 3PL) for carrier portfolio segmentation."
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode of the carrier (e.g. road, rail, air) for modal capability analysis."
    - name: "country_of_registration"
      expr: country_of_registration
      comment: "Country where the carrier is registered for geographic coverage and regulatory compliance analysis."
    - name: "cold_chain_capable"
      expr: cold_chain_capable
      comment: "Flag indicating cold chain capability for temperature-sensitive freight carrier qualification."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Flag indicating hazmat certification for regulated goods carrier qualification."
    - name: "preferred_carrier"
      expr: preferred_carrier
      comment: "Flag indicating preferred carrier status for routing guide compliance analysis."
    - name: "fmcsa_safety_rating"
      expr: fmcsa_safety_rating
      comment: "FMCSA safety rating of the carrier for regulatory compliance and risk management."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage area of the carrier for network design and lane assignment decisions."
    - name: "onboarding_date"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Carrier onboarding date truncated to month for carrier base growth trend analysis."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network. Baseline metric for carrier base size and diversity management."
    - name: "active_carriers"
      expr: SUM(CASE WHEN carrier_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of carriers with active status. Measures the effective size of the available carrier network for capacity planning."
    - name: "cold_chain_capable_carriers"
      expr: SUM(CASE WHEN cold_chain_capable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carriers with cold chain capability. Measures cold chain capacity availability for temperature-sensitive product distribution."
    - name: "hazmat_certified_carriers"
      expr: SUM(CASE WHEN hazmat_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carriers with hazmat certification. Measures regulated goods transport capacity for compliance risk management."
    - name: "total_max_payload_capacity_kg"
      expr: SUM(CAST(max_payload_kg AS DOUBLE))
      comment: "Total maximum payload capacity across all carriers in kilograms. Measures aggregate network freight capacity for supply chain resilience planning."
    - name: "avg_max_payload_kg"
      expr: AVG(CAST(max_payload_kg AS DOUBLE))
      comment: "Average maximum payload capacity per carrier. Used to benchmark carrier fleet size and capability for lane assignment decisions."
    - name: "total_cargo_insurance_coverage"
      expr: SUM(CAST(insurance_cargo_amount AS DOUBLE))
      comment: "Total cargo insurance coverage across all carriers. Measures aggregate risk coverage in the carrier network for risk management reporting."
    - name: "preferred_carriers"
      expr: SUM(CASE WHEN preferred_carrier = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carriers designated as preferred. Tracks preferred carrier network size for routing guide compliance and strategic partnership management."
$$;