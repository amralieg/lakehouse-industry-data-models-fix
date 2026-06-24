-- Metric views for domain: logistics | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics covering freight cost, on-time delivery, weight/volume throughput, and hazmat exposure. Used by logistics VPs and supply chain directors to steer carrier strategy and cost management."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail) for segmenting shipment cost and performance."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current lifecycle status of the shipment (in-transit, delivered, cancelled, etc.)."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level (standard, express, overnight) for SLA analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code governing risk and cost transfer point."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic freight cost and volume analysis."
    - name: "direction"
      expr: direction
      comment: "Shipment direction (outbound, inbound, return) for flow analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials, for compliance segmentation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates cold-chain shipments requiring temperature control, for premium cost analysis."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month of scheduled delivery for trend analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline volume KPI for capacity and throughput planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipments. Primary cost driver for logistics budget management."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Used to benchmark carrier efficiency and detect cost anomalies."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipped weight in kilograms. Drives carrier capacity planning and freight rate negotiations."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipped volume in cubic meters. Used for load optimization and carrier capacity utilization."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight. Indicates shipment density trends relevant to rate class negotiations."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across shipments. Informs risk exposure and insurance premium decisions."
    - name: "hazmat_shipment_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of hazardous material shipments. Tracks regulatory compliance exposure and specialized handling costs."
    - name: "temperature_controlled_shipment_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of cold-chain shipments. Drives premium carrier capacity planning and cost allocation."
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of distinct destination countries. Measures geographic reach and trade compliance complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics covering invoiced amounts, audit variances, payment status, and three-way match outcomes. Used by finance and logistics controllers to manage freight spend and detect billing discrepancies."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service invoiced (LTL, FTL, air, ocean) for cost category analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice) — key control for AP accuracy."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency freight spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing freight cost responsibility."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight classification for rate and cost benchmarking."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for freight spend trend analysis."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for invoice variance from expected amount, for root-cause analysis of billing disputes."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total freight invoiced amount. Primary freight spend KPI for budget vs. actuals tracking."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved freight invoice amount after audit. Represents confirmed payable freight cost."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed freight invoice amount. Indicates billing accuracy issues with carriers."
    - name: "total_audited_amount"
      expr: SUM(CAST(audited_amount AS DOUBLE))
      comment: "Total audited freight amount. Used to measure freight audit program coverage and savings."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharge billed. Tracks fuel cost exposure and carrier surcharge compliance."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges (detention, liftgate, etc.). Identifies operational inefficiencies driving extra costs."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on freight invoices. Required for tax compliance and cost reporting."
    - name: "total_customs_duties"
      expr: SUM(CAST(customs_duties AS DOUBLE))
      comment: "Total customs duties on freight invoices. Tracks import cost exposure for trade compliance decisions."
    - name: "avg_invoiced_amount"
      expr: AVG(CAST(invoiced_amount AS DOUBLE))
      comment: "Average freight invoice amount. Benchmarks carrier billing levels and detects outliers."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of freight invoices processed. Measures AP workload and carrier billing volume."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered across invoiced shipments. Used to compute cost-per-km efficiency metrics."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight billed across freight invoices. Validates weight-based rate accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order execution metrics covering order volume, freight cost, weight/volume, and carrier acceptance. Used by logistics operations managers to monitor tender performance and freight cost commitments."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order (tendered, accepted, in-transit, delivered, cancelled)."
    - name: "service_type"
      expr: service_type
      comment: "Service type (LTL, FTL, air, ocean) for cost and performance segmentation."
    - name: "carrier_acceptance_status"
      expr: carrier_acceptance_status
      comment: "Whether the carrier accepted or rejected the tender. Tracks carrier reliability."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms code for cost responsibility segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the freight order for urgency-based cost analysis."
    - name: "tender_method"
      expr: tender_method
      comment: "Method used to tender the freight order (spot, contract, auction) for procurement strategy analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type required (dry van, reefer, flatbed) for capacity planning."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the freight order was created for trend analysis."
  measures:
    - name: "total_freight_orders"
      expr: COUNT(1)
      comment: "Total freight orders placed. Baseline volume KPI for logistics operations capacity."
    - name: "total_freight_cost"
      expr: SUM(CAST(total_freight_cost AS DOUBLE))
      comment: "Total committed freight cost across all orders. Primary logistics cost KPI."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(total_freight_cost AS DOUBLE))
      comment: "Average freight cost per order. Benchmarks carrier pricing and detects cost escalation."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges on freight orders. Identifies operational inefficiencies adding to freight cost."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight across freight orders. Drives carrier capacity and rate negotiation decisions."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume across freight orders. Used for load optimization and capacity planning."
    - name: "carrier_accepted_orders"
      expr: COUNT(CASE WHEN carrier_acceptance_status = 'ACCEPTED' THEN 1 END)
      comment: "Number of freight orders accepted by carriers. Measures tender acceptance rate performance."
    - name: "hazmat_order_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Number of hazmat freight orders. Tracks specialized handling volume and compliance exposure."
    - name: "temperature_controlled_order_count"
      expr: COUNT(CASE WHEN temperature_controlled_indicator = TRUE THEN 1 END)
      comment: "Number of temperature-controlled freight orders. Drives cold-chain capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master performance and risk metrics covering on-time delivery, safety scores, claims ratios, and insurance coverage. Used by procurement and logistics leadership to manage carrier qualification and contract decisions."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (asset-based, broker, NVOCC, etc.) for portfolio segmentation."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Active/inactive/suspended status for carrier qualification management."
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode (road, air, ocean, rail) for modal analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the carrier contract (active, expired, pending renewal) for contract management."
    - name: "safety_rating"
      expr: safety_rating
      comment: "Regulatory safety rating (satisfactory, conditional, unsatisfactory) for risk segmentation."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the carrier is certified to handle hazardous materials."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the carrier offers temperature-controlled services."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network. Measures carrier base breadth for supply chain resilience."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers. Primary carrier performance KPI for SLA management."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average carrier safety score. Tracks fleet safety risk for compliance and insurance decisions."
    - name: "avg_claims_ratio"
      expr: AVG(CAST(claims_ratio AS DOUBLE))
      comment: "Average freight claims ratio across carriers. Identifies high-risk carriers driving cargo loss costs."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across all carriers. Measures aggregate risk coverage in the carrier network."
    - name: "hazmat_certified_carrier_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of hazmat-certified carriers. Ensures sufficient specialized carrier capacity for dangerous goods."
    - name: "active_carrier_count"
      expr: COUNT(CASE WHEN carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active carriers. Tracks available carrier capacity for logistics operations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight claims financial and resolution metrics covering claimed amounts, settlement rates, and escalation patterns. Used by logistics risk managers and finance to control cargo loss costs and carrier liability."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the freight claim (filed, under review, settled, denied, escalated)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (damage, shortage, delay, loss) for root-cause analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the claim for prioritization and management attention."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight class of the claimed shipment for commodity risk analysis."
    - name: "claimed_currency_code"
      expr: claimed_currency_code
      comment: "Currency of the claim for multi-currency financial reporting."
    - name: "filing_date_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month the claim was filed for trend analysis of cargo loss incidents."
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Whether subrogation recovery is being pursued, for insurance cost recovery tracking."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of freight claims filed. Baseline KPI for cargo loss and damage frequency."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all freight claims. Measures gross cargo loss financial exposure."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled on freight claims. Measures actual financial recovery from carriers."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared value of goods in claims. Benchmarks claim amounts against insured values."
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average claim amount per incident. Tracks severity trends for risk management decisions."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim. Measures carrier liability recovery effectiveness."
    - name: "total_settlement_offer_amount"
      expr: SUM(CAST(settlement_offer_amount AS DOUBLE))
      comment: "Total settlement offers made by carriers. Used to assess carrier negotiation posture."
    - name: "distinct_carriers_with_claims"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with active claims. Identifies high-risk carriers for contract review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment_tracking_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking event metrics covering on-time performance, exception rates, delay durations, and delivery confirmation. Used by logistics operations and customer service to monitor real-time shipment health and SLA compliance."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment_tracking_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of tracking event (pickup, in-transit, out-for-delivery, delivered, exception) for milestone analysis."
    - name: "event_country_code"
      expr: event_country_code
      comment: "Country where the tracking event occurred for geographic delay analysis."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether the event occurred on time relative to schedule. Core SLA compliance dimension."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Reason code for shipment exceptions (weather, customs, carrier delay) for root-cause analysis."
    - name: "customs_clearance_flag"
      expr: customs_clearance_flag
      comment: "Whether the event represents a customs clearance milestone."
    - name: "signature_required_flag"
      expr: signature_required_flag
      comment: "Whether a signature was required at this event, for proof-of-delivery compliance."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the tracking event for trend analysis of delivery performance."
  measures:
    - name: "total_tracking_events"
      expr: COUNT(1)
      comment: "Total tracking events recorded. Measures tracking data coverage and carrier visibility."
    - name: "on_time_event_count"
      expr: COUNT(CASE WHEN on_time_flag = TRUE THEN 1 END)
      comment: "Number of on-time tracking events. Numerator for on-time delivery rate calculation."
    - name: "exception_event_count"
      expr: COUNT(CASE WHEN exception_reason_code IS NOT NULL THEN 1 END)
      comment: "Number of exception events. Tracks shipment disruption frequency for carrier performance management."
    - name: "total_delay_duration_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all tracking events. Measures aggregate delivery delay impact on customers."
    - name: "avg_delay_duration_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration per event. Benchmarks carrier delay severity for SLA negotiations."
    - name: "signature_obtained_count"
      expr: COUNT(CASE WHEN signature_obtained_flag = TRUE THEN 1 END)
      comment: "Number of events with confirmed signature. Measures proof-of-delivery compliance rate."
    - name: "distinct_shipments_tracked"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Number of distinct shipments with tracking events. Measures carrier tracking visibility coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier contract financial and compliance metrics covering rate commitments, volume obligations, penalty exposure, and contract health. Used by procurement and logistics leadership to manage carrier agreements and renegotiation cycles."
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the carrier contract (active, expired, pending, terminated)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (spot, annual, multi-year, master) for portfolio analysis."
    - name: "service_mode"
      expr: service_mode
      comment: "Service mode covered by the contract (road, air, ocean, rail)."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, for contract management and renegotiation planning."
    - name: "insurance_coverage_required_flag"
      expr: insurance_coverage_required_flag
      comment: "Whether minimum insurance coverage is contractually required."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract became effective for contract lifecycle trend analysis."
    - name: "last_modified_by_name"
      expr: last_modified_by_name
      comment: "Name of the person who last modified the contract. Sensitivity: PII (sensitivity=pii, mask in non-prod per VREQ-053)."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of carrier contracts. Measures carrier agreement portfolio size."
    - name: "total_minimum_volume_commitment"
      expr: SUM(CAST(minimum_volume_commitment AS DOUBLE))
      comment: "Total minimum volume committed across all carrier contracts. Tracks contractual volume obligations."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average contracted on-time delivery target. Benchmarks SLA stringency across the carrier portfolio."
    - name: "total_damage_claim_liability"
      expr: SUM(CAST(damage_claim_liability_limit AS DOUBLE))
      comment: "Total damage claim liability limits across contracts. Measures aggregate carrier liability coverage."
    - name: "total_insurance_minimum_coverage"
      expr: SUM(CAST(insurance_minimum_coverage_amount AS DOUBLE))
      comment: "Total minimum insurance coverage required across contracts. Tracks risk coverage adequacy."
    - name: "avg_detention_charge_per_hour"
      expr: AVG(CAST(detention_charge_per_hour AS DOUBLE))
      comment: "Average detention charge per hour across contracts. Benchmarks detention cost exposure."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active carrier contracts. Tracks available contracted carrier capacity."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew. Identifies contracts requiring proactive renegotiation review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs declaration compliance and financial metrics covering declared values, duty costs, hold rates, and screening outcomes. Used by trade compliance officers and logistics directors to manage import/export risk and duty spend."
  source: "`vibe_manufacturing_v1`.`logistics`.`customs_declaration`"
  dimensions:
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for tariff and trade compliance analysis."
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for import duty and regulatory analysis."
    - name: "compliance_screening_outcome"
      expr: compliance_screening_outcome
      comment: "Outcome of compliance screening (cleared, held, escalated) for risk management."
    - name: "denied_party_screening_result"
      expr: denied_party_screening_result
      comment: "Result of denied party list screening. Critical for export control compliance."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether the declaration is under regulatory hold. Tracks compliance risk exposure."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing cost and risk transfer for the declared shipment."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the declared shipment."
    - name: "entry_date_month"
      expr: DATE_TRUNC('month', entry_date)
      comment: "Month of customs entry for duty spend trend analysis."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total customs declarations filed. Baseline KPI for trade compliance workload and cross-border volume."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared customs value. Drives duty calculation and trade compliance risk assessment."
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duties paid. Primary trade cost KPI for landed cost and sourcing decisions."
    - name: "total_vat_amount"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT on customs declarations. Required for tax compliance and cost reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total taxes (duties + VAT + other) on customs declarations. Measures full import tax burden."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of declared goods. Used for freight and duty rate validation."
    - name: "regulatory_hold_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of declarations under regulatory hold. Tracks compliance risk and supply chain disruption exposure."
    - name: "denied_party_match_count"
      expr: COUNT(CASE WHEN denied_party_screening_result = 'MATCH' THEN 1 END)
      comment: "Number of declarations with denied party matches. Critical export control compliance KPI."
    - name: "distinct_origin_countries"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin. Measures supply chain geographic diversity and tariff exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound delivery performance metrics covering receipt accuracy, delivery variance, freight costs, and goods receipt timeliness. Used by warehouse operations and procurement to manage supplier delivery performance."
  source: "`vibe_manufacturing_v1`.`logistics`.`inbound_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the inbound delivery (in-transit, received, partial, blocked)."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt posting for inventory accuracy tracking."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for import compliance monitoring."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether quality inspection is required on receipt, for quality control planning."
    - name: "blocked_stock_flag"
      expr: blocked_stock_flag
      comment: "Whether received stock is blocked pending inspection or resolution."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms for the inbound delivery, determining freight cost responsibility."
    - name: "expected_delivery_date_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery for inbound volume planning."
  measures:
    - name: "total_inbound_deliveries"
      expr: COUNT(1)
      comment: "Total inbound deliveries. Baseline KPI for receiving workload and supplier delivery volume."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across inbound deliveries. Measures inbound supply volume."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received. Compared to ordered quantity to measure supplier fill rate."
    - name: "total_delivery_variance_quantity"
      expr: SUM(CAST(delivery_variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received. Measures supplier delivery accuracy."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost. Tracks inbound logistics spend for cost management."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average inbound freight cost per delivery. Benchmarks inbound logistics efficiency."
    - name: "blocked_stock_delivery_count"
      expr: COUNT(CASE WHEN blocked_stock_flag = TRUE THEN 1 END)
      comment: "Number of deliveries with blocked stock. Tracks quality and compliance hold frequency."
    - name: "inspection_required_delivery_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of deliveries requiring quality inspection. Drives QC resource planning."
    - name: "complete_delivery_count"
      expr: COUNT(CASE WHEN delivery_complete_flag = TRUE THEN 1 END)
      comment: "Number of fully completed deliveries. Measures supplier on-time and in-full delivery performance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_trade_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade compliance screening and risk metrics covering embargo flags, denied party matches, license requirements, and risk scores. Used by trade compliance officers and legal to manage export control and sanctions risk."
  source: "`vibe_manufacturing_v1`.`logistics`.`trade_compliance_record`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Type of compliance check (denied party, embargo, dual-use, license) for risk category analysis."
    - name: "check_status"
      expr: check_status
      comment: "Outcome of the compliance check (cleared, flagged, escalated, pending)."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic trade compliance risk analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the compliance record (low, medium, high, critical)."
    - name: "embargo_flag"
      expr: embargo_flag
      comment: "Whether an embargo was flagged on this record. Critical sanctions compliance indicator."
    - name: "denied_party_match_flag"
      expr: denied_party_match_flag
      comment: "Whether a denied party list match was found. Critical export control compliance indicator."
    - name: "license_required_flag"
      expr: license_required_flag
      comment: "Whether an export/import license is required for this shipment."
    - name: "check_date_month"
      expr: DATE_TRUNC('month', check_date)
      comment: "Month of the compliance check for trend analysis of screening volume and risk."
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total trade compliance checks performed. Measures compliance program coverage and workload."
    - name: "embargo_flagged_count"
      expr: COUNT(CASE WHEN embargo_flag = TRUE THEN 1 END)
      comment: "Number of records with embargo flags. Critical KPI for sanctions compliance risk management."
    - name: "denied_party_match_count"
      expr: COUNT(CASE WHEN denied_party_match_flag = TRUE THEN 1 END)
      comment: "Number of denied party list matches. Tracks export control violation risk exposure."
    - name: "license_required_count"
      expr: COUNT(CASE WHEN license_required_flag = TRUE THEN 1 END)
      comment: "Number of shipments requiring export/import licenses. Drives compliance workload planning."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of compliance records requiring escalation. Measures high-risk transaction volume."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average trade compliance risk score. Tracks overall portfolio risk level for compliance leadership."
    - name: "documentation_complete_count"
      expr: COUNT(CASE WHEN documentation_complete_flag = TRUE THEN 1 END)
      comment: "Number of records with complete documentation. Measures trade documentation compliance rate."
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of distinct destination countries screened. Measures geographic trade compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport lane network metrics covering capacity, cost efficiency, utilization, and transit performance. Used by network design and logistics strategy teams to optimize the freight lane portfolio."
  source: "`vibe_manufacturing_v1`.`logistics`.`lane`"
  dimensions:
    - name: "lane_status"
      expr: lane_status
      comment: "Active/inactive/suspended status of the lane for network availability analysis."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (direct, relay, intermodal) for network design analysis."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Primary transport mode for the lane (road, air, ocean, rail)."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier serving the lane for capacity planning."
    - name: "region"
      expr: region
      comment: "Geographic region of the lane for regional network analysis."
    - name: "compliance_hazardous_allowed"
      expr: compliance_hazardous_allowed
      comment: "Whether hazardous goods are permitted on this lane for dangerous goods routing."
    - name: "customs_documentation_required"
      expr: customs_documentation_required
      comment: "Whether customs documentation is required for this lane, indicating cross-border complexity."
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of transport lanes in the network. Measures network coverage breadth."
    - name: "total_capacity_tons"
      expr: SUM(CAST(capacity_tons AS DOUBLE))
      comment: "Total capacity across all lanes in tons. Measures aggregate network throughput capacity."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(average_transit_time_hours AS DOUBLE))
      comment: "Average transit time across lanes. Key network performance indicator for delivery speed planning."
    - name: "avg_load_factor_pct"
      expr: AVG(CAST(average_load_factor_percent AS DOUBLE))
      comment: "Average load factor across lanes. Measures network utilization efficiency for capacity optimization."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total network distance across all lanes. Used for carbon emission and cost-per-km analysis."
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(cost_per_mile AS DOUBLE))
      comment: "Average cost per mile across lanes. Benchmarks lane cost efficiency for network optimization."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume capacity across lanes in cubic meters. Drives volumetric capacity planning."
    - name: "total_lane_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total usage count across all lanes. Identifies high-frequency lanes for capacity investment decisions."
    - name: "active_lane_count"
      expr: COUNT(CASE WHEN lane_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active lanes. Tracks available network capacity for logistics operations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load plan efficiency and cost metrics covering weight/volume utilization, freight cost estimates, and hazmat handling. Used by warehouse and logistics operations to maximize load efficiency and reduce per-unit freight costs."
  source: "`vibe_manufacturing_v1`.`logistics`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Current status of the load plan (draft, confirmed, loaded, dispatched)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the load plan for modal cost analysis."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (FTL, LTL, parcel) for load optimization analysis."
    - name: "requires_hazmat_handling"
      expr: requires_hazmat_handling
      comment: "Whether the load plan requires hazmat handling for compliance and cost segmentation."
    - name: "requires_temperature_control"
      expr: requires_temperature_control
      comment: "Whether the load plan requires temperature control for cold-chain cost analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the load plan for urgency-based resource allocation."
    - name: "planned_load_date_month"
      expr: DATE_TRUNC('month', planned_load_date)
      comment: "Month of planned load date for outbound volume trend analysis."
  measures:
    - name: "total_load_plans"
      expr: COUNT(1)
      comment: "Total load plans created. Baseline KPI for outbound logistics planning volume."
    - name: "total_planned_weight_kg"
      expr: SUM(CAST(total_planned_weight_kg AS DOUBLE))
      comment: "Total planned weight across all load plans. Drives carrier capacity and rate management."
    - name: "total_planned_volume_m3"
      expr: SUM(CAST(total_planned_volume_m3 AS DOUBLE))
      comment: "Total planned volume across all load plans. Used for load optimization and vehicle selection."
    - name: "total_estimated_freight_cost"
      expr: SUM(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total estimated freight cost across load plans. Tracks planned logistics spend for budget management."
    - name: "avg_weight_utilization_pct"
      expr: AVG(CAST(weight_utilization_percentage AS DOUBLE))
      comment: "Average weight utilization percentage across load plans. Measures load efficiency for cost optimization."
    - name: "avg_volume_utilization_pct"
      expr: AVG(CAST(volume_utilization_percentage AS DOUBLE))
      comment: "Average volume utilization percentage across load plans. Identifies under-loaded vehicles for consolidation."
    - name: "avg_estimated_freight_cost"
      expr: AVG(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Average estimated freight cost per load plan. Benchmarks planning cost accuracy."
    - name: "hazmat_load_plan_count"
      expr: COUNT(CASE WHEN requires_hazmat_handling = TRUE THEN 1 END)
      comment: "Number of load plans requiring hazmat handling. Tracks specialized handling volume and compliance cost."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg performance metrics covering transit times, freight costs, delays, and route efficiency. Used by logistics operations to identify bottlenecks in multi-leg shipments and optimize routing decisions."
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment_leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the shipment leg (in-transit, completed, delayed, cancelled)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this leg for modal cost and performance analysis."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Service level for this leg for SLA compliance analysis."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for leg delay for root-cause analysis of transit disruptions."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Whether this leg involves cross-docking for network efficiency analysis."
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Whether this leg involves transshipment for multi-modal routing analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether this leg carries hazardous materials for compliance segmentation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether this leg requires temperature control for cold-chain cost analysis."
  measures:
    - name: "total_shipment_legs"
      expr: COUNT(1)
      comment: "Total shipment legs executed. Measures multi-leg routing complexity and operational volume."
    - name: "total_leg_freight_cost"
      expr: SUM(CAST(leg_freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipment legs. Identifies highest-cost routing segments."
    - name: "avg_leg_freight_cost"
      expr: AVG(CAST(leg_freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment leg. Benchmarks leg-level cost efficiency."
    - name: "total_transit_time_hours"
      expr: SUM(CAST(transit_time_hours AS DOUBLE))
      comment: "Total transit time across all legs. Measures aggregate delivery time for end-to-end SLA analysis."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average transit time per leg. Benchmarks carrier speed performance by mode and route."
    - name: "total_delay_duration_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all shipment legs. Measures aggregate disruption impact on delivery schedules."
    - name: "avg_delay_duration_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay per leg. Identifies chronic delay patterns for carrier and route optimization."
    - name: "total_distance_km"
      expr: SUM(CAST(leg_distance_km AS DOUBLE))
      comment: "Total distance across all shipment legs. Used for carbon emission and cost-per-km analysis."
    - name: "avg_route_optimization_score"
      expr: AVG(CAST(route_optimization_score AS DOUBLE))
      comment: "Average route optimization score across legs. Measures routing efficiency for network design decisions."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge across shipment legs. Tracks fuel cost exposure by route and carrier."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight rate benchmarking and cost structure metrics covering base rates, fuel surcharges, weight breaks, and rate coverage. Used by procurement and logistics finance to manage rate competitiveness and carrier negotiations."
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_rate`"
  dimensions:
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport for the rate (road, air, ocean, rail) for modal rate benchmarking."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight classification for rate tier analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service level (standard, express, economy) for rate-service trade-off analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type (dry van, reefer, flatbed) for specialized rate analysis."
    - name: "origin_zone_code"
      expr: origin_zone_code
      comment: "Origin zone for geographic rate analysis."
    - name: "destination_zone_code"
      expr: destination_zone_code
      comment: "Destination zone for lane-level rate benchmarking."
    - name: "hazmat_eligible"
      expr: hazmat_eligible
      comment: "Whether the rate applies to hazardous materials shipments."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rate became effective for rate trend analysis."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total freight rate records. Measures rate table coverage for carrier and lane combinations."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base freight rate. Benchmarks carrier pricing competitiveness across the rate portfolio."
    - name: "avg_fuel_surcharge_pct"
      expr: AVG(CAST(fuel_surcharge_percentage AS DOUBLE))
      comment: "Average fuel surcharge percentage. Tracks fuel cost pass-through trends for budget forecasting."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum freight charge. Identifies floor pricing for small shipment cost management."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum freight charge. Identifies ceiling pricing for large shipment cost management."
    - name: "total_max_weight_break_kg"
      expr: SUM(CAST(weight_break_max_kg AS DOUBLE))
      comment: "Total maximum weight break coverage across rates. Measures rate table completeness for heavy shipments."
    - name: "total_max_distance_km"
      expr: SUM(CAST(distance_max_km AS DOUBLE))
      comment: "Total maximum distance coverage across rates. Measures geographic rate table completeness."
    - name: "distinct_carriers_with_rates"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with active rate records. Measures competitive rate coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and safety metrics for bills of lading"
  source: "`vibe_manufacturing_v1`.`logistics`.`bill_of_lading`"
  dimensions:
    - name: "bill_of_lading_status"
      expr: bill_of_lading_status
      comment: "Current status of the BOL"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the BOL"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode indicated on the BOL"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Date the shipment was actually delivered"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the BOL was created"
  measures:
    - name: "total_bols"
      expr: COUNT(1)
      comment: "Total number of bills of lading"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Sum of declared monetary value on all BOLs"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per BOL"
    - name: "hazmat_bol_count"
      expr: SUM(CASE WHEN hazmat_flag THEN 1 ELSE 0 END)
      comment: "Count of BOLs that contain hazardous materials"
$$;