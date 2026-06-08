-- Metric views for domain: logistics | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment-level KPIs covering shipping cost efficiency, delivery performance, weight throughput, and insurance exposure. Primary steering dashboard for logistics operations and carrier management."
  source: "`ecommerce_ecm`.`logistics`.`logistics_shipment`"
  dimensions:
    - name: "logistics_shipment_status"
      expr: logistics_shipment_status
      comment: "Current status of the shipment (e.g. in_transit, delivered, cancelled) — used to slice KPIs by shipment lifecycle stage."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Classification of the shipment (e.g. standard, express, freight) — enables cost and performance comparison across shipment types."
    - name: "origin_country"
      expr: origin_country
      comment: "Country from which the shipment originates — supports geographic analysis of shipping lanes and cost patterns."
    - name: "destination_country"
      expr: destination_country
      comment: "Country to which the shipment is destined — enables cross-border vs. domestic performance segmentation."
    - name: "shipping_cost_currency"
      expr: shipping_cost_currency
      comment: "Currency in which shipping costs are denominated — important for multi-currency cost normalization."
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Flag indicating whether the shipment contains hazardous materials — used to segment compliance-sensitive shipments."
    - name: "insurance_required"
      expr: insurance_required
      comment: "Flag indicating whether insurance was required for the shipment — used to assess risk coverage posture."
    - name: "actual_ship_date"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Month in which the shipment was dispatched — enables trend analysis of shipment volumes and costs over time."
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month in which the shipment was delivered — used for delivery performance trending."
    - name: "signature_required"
      expr: signature_required
      comment: "Flag indicating whether a signature was required upon delivery — used to segment high-value or sensitive shipments."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records — baseline volume metric for operational throughput and capacity planning."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total gross shipping cost across all shipments — primary cost metric for carrier spend management and budget tracking."
    - name: "total_shipping_cost_with_tax"
      expr: SUM(CAST(shipping_cost_total_amount AS DOUBLE))
      comment: "Total all-in shipping cost including tax — used for accurate P&L and accounts payable reconciliation."
    - name: "total_shipping_tax"
      expr: SUM(CAST(shipping_cost_tax_amount AS DOUBLE))
      comment: "Total tax component of shipping costs — supports tax liability reporting and compliance monitoring."
    - name: "avg_shipping_cost_per_shipment"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per shipment — key efficiency KPI for benchmarking carrier rates and negotiating contracts."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms — measures physical throughput and informs carrier capacity utilization."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms — used to assess shipment density and optimize packaging/rate tiers."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of all shipments — measures financial exposure in transit and informs insurance coverage requirements."
    - name: "total_insurance_amount"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance premium/coverage amount across shipments — tracks risk mitigation spend and coverage adequacy."
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value_amount AS DOUBLE))
      comment: "Total customs-declared value — critical for cross-border compliance, duty estimation, and trade reporting."
    - name: "avg_cost_per_kg"
      expr: ROUND(SUM(CAST(shipping_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(weight_kg AS DOUBLE)), 0), 4)
      comment: "Average shipping cost per kilogram — compound efficiency ratio used to benchmark carrier rate competitiveness and identify cost reduction opportunities."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND estimated_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on or before the estimated delivery date — primary SLA adherence KPI used in carrier scorecards and customer satisfaction management."
    - name: "shipments_delivered_late"
      expr: SUM(CASE WHEN actual_delivery_date > estimated_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered after the estimated delivery date — operational alert metric for identifying carrier performance degradation."
    - name: "avg_transit_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, actual_ship_date) AS DOUBLE))
      comment: "Average number of days between ship date and delivery date — measures end-to-end transit performance and informs SLA target setting."
    - name: "insurance_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments requiring insurance — tracks risk exposure coverage posture across the shipment portfolio."
    - name: "hazmat_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazardous_material = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments classified as hazardous material — compliance KPI for regulatory reporting and carrier capability matching."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used — measures carrier diversification and dependency concentration risk."
    - name: "distinct_delivery_zones"
      expr: COUNT(DISTINCT delivery_zone_id)
      comment: "Number of distinct delivery zones served — measures geographic reach and network coverage breadth."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master KPIs covering network capacity, financial exposure, compliance posture, and service quality ratings. Used by procurement and logistics leadership to manage the carrier portfolio."
  source: "`ecommerce_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (e.g. active, suspended, inactive) — used to filter the active carrier network."
    - name: "carrier_tier"
      expr: carrier_tier
      comment: "Strategic tier classification of the carrier (e.g. preferred, standard, spot) — enables tier-based performance and spend analysis."
    - name: "carrier_type"
      expr: carrier_type
      comment: "Mode or type of carrier (e.g. air, ground, ocean) — supports modal split analysis and cost benchmarking."
    - name: "country"
      expr: country
      comment: "Country where the carrier is headquartered — enables geographic concentration analysis of the carrier network."
    - name: "compliance_ctpat"
      expr: compliance_ctpat
      comment: "Flag indicating C-TPAT compliance status — critical for customs security program eligibility and risk management."
    - name: "compliance_iata"
      expr: compliance_iata
      comment: "Flag indicating IATA compliance status — required for air freight carrier qualification."
    - name: "compliance_wto"
      expr: compliance_wto
      comment: "Flag indicating WTO compliance status — relevant for international trade carrier qualification."
    - name: "contract_end_date"
      expr: DATE_TRUNC('month', contract_end_date)
      comment: "Month of contract expiry — used to identify upcoming contract renewals and renegotiation windows."
    - name: "edi_integration_status"
      expr: edi_integration_status
      comment: "Status of EDI integration with the carrier — measures digital connectivity maturity of the carrier network."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carrier records — baseline count for network size and portfolio management."
    - name: "total_network_capacity_tons"
      expr: SUM(CAST(capacity_tons AS DOUBLE))
      comment: "Total contracted capacity in tons across all carriers — measures aggregate network throughput capacity available to the business."
    - name: "avg_carrier_capacity_tons"
      expr: AVG(CAST(capacity_tons AS DOUBLE))
      comment: "Average capacity per carrier in tons — used to assess carrier size distribution and identify capacity concentration risks."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all carriers — measures aggregate financial risk protection in the carrier network."
    - name: "avg_carrier_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average carrier performance rating score — primary quality KPI for carrier scorecard reviews and tier reclassification decisions."
    - name: "max_carrier_weight_lbs"
      expr: MAX(CAST(max_weight_lbs AS DOUBLE))
      comment: "Maximum weight capacity (lbs) available across the carrier network — informs heavy freight routing decisions."
    - name: "avg_max_weight_lbs"
      expr: AVG(CAST(max_weight_lbs AS DOUBLE))
      comment: "Average maximum weight capacity per carrier — used to assess whether the carrier network can handle expected shipment weight profiles."
    - name: "ctpat_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_ctpat = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with C-TPAT compliance — regulatory compliance KPI for customs security program management."
    - name: "iata_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_iata = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with IATA compliance — air freight qualification compliance rate for network risk assessment."
    - name: "carriers_expiring_within_90_days"
      expr: SUM(CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of carriers with contracts expiring within 90 days — operational urgency metric for procurement to prioritize renewal negotiations."
    - name: "edi_integrated_carrier_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_integration_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with active EDI integration — digital connectivity KPI measuring automation maturity of the carrier network."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_carrier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier contract KPIs covering contracted volume commitments, penalty exposure, contract lifecycle health, and compliance posture. Used by procurement and legal teams to manage carrier agreements."
  source: "`ecommerce_ecm`.`logistics`.`carrier_contract`"
  dimensions:
    - name: "carrier_contract_status"
      expr: carrier_contract_status
      comment: "Current status of the carrier contract (e.g. active, expired, terminated) — primary filter for active contract portfolio analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of carrier contract (e.g. spot, long-term, framework) — enables spend and volume analysis by contract structure."
    - name: "contract_category"
      expr: contract_category
      comment: "Business category of the contract — supports portfolio segmentation by service category."
    - name: "contract_region"
      expr: contract_region
      comment: "Geographic region covered by the contract — enables regional contract portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract is denominated — important for multi-currency financial exposure analysis."
    - name: "is_preferred"
      expr: is_preferred
      comment: "Flag indicating whether this is a preferred carrier contract — used to segment preferred vs. non-preferred carrier spend."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the contract grants exclusivity — used to assess supply chain concentration risk."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the contract auto-renews — used to identify contracts requiring active renewal management."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract became effective — used for contract vintage analysis and cohort-based performance tracking."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the contract expires — used to identify upcoming contract expirations requiring renewal action."
    - name: "compliance_ctpat"
      expr: compliance_ctpat
      comment: "C-TPAT compliance flag at the contract level — used for regulatory compliance portfolio analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of carrier contracts — baseline count for contract portfolio size and management workload."
    - name: "total_contracted_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Total volume committed across all carrier contracts — measures aggregate supply chain capacity commitment and obligation."
    - name: "avg_contracted_volume"
      expr: AVG(CAST(contracted_volume AS DOUBLE))
      comment: "Average contracted volume per carrier contract — used to benchmark contract size and identify outlier commitments."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure across all contracts — critical risk metric for legal and finance teams to monitor contractual liability."
    - name: "avg_penalty_per_contract"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per contract — used to assess typical contractual risk level and benchmark against industry norms."
    - name: "contracts_expiring_within_90_days"
      expr: SUM(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of contracts expiring within 90 days — procurement urgency KPI for prioritizing renewal and renegotiation activities."
    - name: "preferred_contract_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_preferred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts designated as preferred — measures strategic carrier relationship concentration and preferred network coverage."
    - name: "exclusive_contract_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_exclusive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with exclusivity clauses — supply chain concentration risk KPI for procurement strategy decisions."
    - name: "auto_renewal_contract_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts set to auto-renew — governance KPI measuring the proportion of contracts requiring active renewal oversight."
    - name: "distinct_carriers_under_contract"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with active contracts — measures breadth of the contracted carrier network."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_carrier_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card KPIs covering freight pricing levels, surcharge exposure, weight tier coverage, and rate card portfolio health. Used by procurement and finance to manage carrier pricing and cost forecasting."
  source: "`ecommerce_ecm`.`logistics`.`carrier_rate_card`"
  dimensions:
    - name: "carrier_rate_card_status"
      expr: carrier_rate_card_status
      comment: "Current status of the rate card (e.g. active, expired, draft) — used to filter the active pricing portfolio."
    - name: "rate_card_category"
      expr: rate_card_category
      comment: "Category of the rate card (e.g. domestic, international, express) — enables cost analysis by service category."
    - name: "lane_type"
      expr: lane_type
      comment: "Type of shipping lane (e.g. FTL, LTL, parcel) — supports modal and lane-level rate benchmarking."
    - name: "lane_origin"
      expr: lane_origin
      comment: "Origin point of the shipping lane — enables origin-based rate analysis and lane optimization."
    - name: "lane_destination"
      expr: lane_destination
      comment: "Destination point of the shipping lane — enables destination-based rate analysis and lane optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the rate card is denominated — required for multi-currency rate normalization."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial term governing the rate card — used to segment rates by trade responsibility allocation."
    - name: "is_fuel_surcharge_applicable"
      expr: is_fuel_surcharge_applicable
      comment: "Flag indicating whether a fuel surcharge applies — used to assess total cost exposure beyond base rates."
    - name: "is_accessorial_applicable"
      expr: is_accessorial_applicable
      comment: "Flag indicating whether accessorial charges apply — used to identify rate cards with additional cost exposure."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the rate card became effective — used for rate trend analysis and pricing vintage comparisons."
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total number of rate card records — baseline count for pricing portfolio size and complexity management."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base freight rate across all rate cards — primary pricing benchmark KPI for carrier rate negotiations and cost forecasting."
    - name: "min_base_rate"
      expr: MIN(CAST(base_rate AS DOUBLE))
      comment: "Minimum base rate in the portfolio — identifies the most competitive rate available for cost optimization routing decisions."
    - name: "max_base_rate"
      expr: MAX(CAST(base_rate AS DOUBLE))
      comment: "Maximum base rate in the portfolio — identifies the highest-cost rate cards for renegotiation prioritization."
    - name: "avg_fuel_surcharge_pct"
      expr: AVG(CAST(fuel_surcharge_pct AS DOUBLE))
      comment: "Average fuel surcharge percentage across rate cards — measures fuel cost exposure and informs hedging or carrier selection decisions."
    - name: "total_weight_tier_range_kg"
      expr: SUM(CAST(weight_tier_max_kg AS DOUBLE) - CAST(weight_tier_min_kg AS DOUBLE))
      comment: "Total weight tier coverage range in kg across all rate cards — measures breadth of weight-based pricing coverage in the rate portfolio."
    - name: "avg_weight_tier_max_kg"
      expr: AVG(CAST(weight_tier_max_kg AS DOUBLE))
      comment: "Average maximum weight tier per rate card — used to assess whether rate cards cover the expected shipment weight distribution."
    - name: "fuel_surcharge_applicable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fuel_surcharge_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate cards with fuel surcharge applicable — measures fuel cost exposure breadth across the pricing portfolio."
    - name: "accessorial_applicable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_accessorial_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate cards with accessorial charges applicable — measures hidden cost exposure in the carrier pricing portfolio."
    - name: "rate_cards_expiring_within_90_days"
      expr: SUM(CASE WHEN effective_until BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of rate cards expiring within 90 days — procurement urgency KPI for proactive rate renegotiation and pricing continuity management."
    - name: "distinct_carriers_with_rate_cards"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with active rate cards — measures pricing coverage breadth across the carrier network."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_tracking_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking event KPIs covering SLA adherence, exception rates, delivery attempt outcomes, and proof-of-delivery performance. Primary operational dashboard for last-mile delivery quality and exception management."
  source: "`ecommerce_ecm`.`logistics`.`tracking_event`"
  dimensions:
    - name: "event_type_code"
      expr: event_type_code
      comment: "Standardized code for the tracking event type (e.g. PICKUP, IN_TRANSIT, DELIVERED) — used to analyze event distribution across the shipment lifecycle."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the tracking event — used to filter and segment events by operational state."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Standardized code for the exception reason — used to categorize and prioritize exception resolution by root cause."
    - name: "exception_responsible_party"
      expr: exception_responsible_party
      comment: "Party responsible for the exception (e.g. carrier, customer, warehouse) — used for accountability analysis and SLA penalty attribution."
    - name: "delivery_attempt_outcome"
      expr: delivery_attempt_outcome
      comment: "Outcome of the delivery attempt (e.g. successful, failed, rescheduled) — key last-mile performance dimension."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Boolean flag indicating whether the SLA was met for this event — primary SLA compliance dimension for carrier scorecards."
    - name: "scan_location"
      expr: scan_location
      comment: "Physical location where the tracking scan occurred — used for geographic bottleneck analysis in the delivery network."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the tracking event — used for trend analysis of event volumes, exceptions, and SLA performance over time."
  measures:
    - name: "total_tracking_events"
      expr: COUNT(1)
      comment: "Total number of tracking events — baseline volume metric for shipment visibility coverage and carrier data feed health."
    - name: "sla_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tracking events where the SLA was met — primary carrier SLA compliance KPI used in performance reviews and penalty calculations."
    - name: "total_sla_breaches"
      expr: SUM(CASE WHEN sla_met_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Total count of SLA breaches across all tracking events — operational alert metric for identifying systemic carrier performance failures."
    - name: "exception_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tracking events with an exception — measures delivery network exception frequency and overall operational quality."
    - name: "total_exceptions"
      expr: SUM(CASE WHEN exception_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Total number of exception events — absolute volume metric for exception management workload and carrier accountability."
    - name: "successful_delivery_attempt_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_attempt_outcome = 'successful' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN delivery_attempt_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivery attempts that were successful — last-mile efficiency KPI directly linked to customer satisfaction and re-delivery cost."
    - name: "proof_of_delivery_capture_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN proof_of_delivery_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with proof of delivery captured — compliance and dispute resolution KPI measuring documentation completeness."
    - name: "distinct_shipments_with_exceptions"
      expr: COUNT(DISTINCT CASE WHEN exception_reason_code IS NOT NULL THEN logistics_shipment_id END)
      comment: "Number of distinct shipments that experienced at least one exception — measures the breadth of exception impact across the shipment portfolio."
    - name: "avg_exception_resolution_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(exception_resolution_timestamp) - UNIX_TIMESTAMP(event_timestamp) AS DOUBLE) / 3600.0)
      comment: "Average time in hours to resolve an exception from the event timestamp — operational efficiency KPI for exception management team performance."
    - name: "distinct_carriers_with_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_met_flag = FALSE THEN carrier_id END)
      comment: "Number of distinct carriers with at least one SLA breach — identifies the breadth of carrier underperformance for targeted remediation."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_shipment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package-level KPIs covering declared value exposure, insurance coverage, return rates, and delivery confirmation performance. Used by operations and customer service to manage package-level quality and risk."
  source: "`ecommerce_ecm`.`logistics`.`shipment_package`"
  dimensions:
    - name: "shipment_package_status"
      expr: shipment_package_status
      comment: "Current status of the package (e.g. in_transit, delivered, returned) — primary filter for active package portfolio analysis."
    - name: "package_type"
      expr: package_type
      comment: "Type of package (e.g. box, envelope, pallet) — used to analyze cost and performance by packaging format."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier code associated with the package — enables carrier-level package performance analysis."
    - name: "is_return"
      expr: is_return
      comment: "Flag indicating whether the package is a return shipment — used to segment and analyze reverse logistics performance."
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Flag indicating whether the package has insurance coverage — used to assess risk coverage posture at the package level."
    - name: "signature_required"
      expr: signature_required
      comment: "Flag indicating whether a signature is required for delivery — used to segment high-value or sensitive packages."
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of actual package delivery — used for delivery volume trending and seasonal pattern analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of packages — baseline volume metric for package throughput and operational capacity planning."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of all packages in USD — measures aggregate financial exposure in transit for insurance and risk management."
    - name: "avg_declared_value_usd"
      expr: AVG(CAST(declared_value_usd AS DOUBLE))
      comment: "Average declared value per package in USD — used to assess typical package value and calibrate insurance coverage thresholds."
    - name: "total_insurance_amount_usd"
      expr: SUM(CAST(insurance_amount_usd AS DOUBLE))
      comment: "Total insurance coverage amount across all packages in USD — tracks aggregate risk mitigation spend at the package level."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all packages in kilograms — measures physical throughput volume for carrier capacity and cost planning."
    - name: "avg_weight_per_package_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average package weight in kilograms — used to optimize packaging standards and match carrier weight tier pricing."
    - name: "return_package_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_return = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages that are returns — reverse logistics KPI directly linked to customer satisfaction, return processing cost, and product quality signals."
    - name: "insurance_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_coverage_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with insurance coverage — risk management KPI for assessing financial protection coverage across the package portfolio."
    - name: "on_time_package_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND estimated_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of packages delivered on or before the estimated delivery date — package-level SLA adherence KPI for carrier performance management."
    - name: "delivery_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_confirmation_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with a delivery confirmation timestamp — measures proof-of-delivery completeness for dispute resolution and compliance."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`logistics_shipment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level logistics KPIs covering line value, weight throughput, hazmat exposure, and customs compliance. Used by trade compliance, finance, and operations teams to manage item-level shipping risk and cost."
  source: "`ecommerce_ecm`.`logistics`.`shipment_item`"
  dimensions:
    - name: "shipment_item_status"
      expr: shipment_item_status
      comment: "Current status of the shipment item — used to filter active vs. completed or cancelled item lines."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier code for the shipment item — enables carrier-level item performance and cost analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the item — critical for trade compliance, duty calculation, and sourcing analysis."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating whether the item is classified as hazardous material — used for compliance segmentation and carrier capability matching."
    - name: "hazmat_classification"
      expr: hazmat_classification
      comment: "Hazmat classification code for the item — enables granular compliance analysis by hazard category."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification number — used for trade compliance monitoring and export license management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the item quantity — used to normalize volume and weight metrics across different product types."
    - name: "restricted_flag"
      expr: restricted_flag
      comment: "Flag indicating whether the item is restricted — used to identify items requiring special handling or regulatory approval."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the item value is denominated — required for multi-currency financial analysis."
  measures:
    - name: "total_shipment_items"
      expr: COUNT(1)
      comment: "Total number of shipment item lines — baseline volume metric for item-level throughput and operational workload."
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units shipped across all item lines — measures physical unit throughput for inventory and fulfillment performance."
    - name: "total_line_value"
      expr: SUM(CAST(line_value AS DOUBLE))
      comment: "Total declared line value across all shipment items — measures aggregate financial value in transit for risk and insurance management."
    - name: "avg_line_value"
      expr: AVG(CAST(line_value AS DOUBLE))
      comment: "Average line value per shipment item — used to assess typical item value and calibrate insurance and declared value thresholds."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total customs-declared value across all items — critical for cross-border duty estimation and trade compliance reporting."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all shipment items in kilograms — measures physical throughput and informs carrier weight tier cost allocation."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volumetric size of all shipment items in cubic meters — used for container utilization and dimensional weight pricing analysis."
    - name: "hazmat_item_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazmat = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipment items classified as hazardous material — compliance KPI for regulatory reporting and carrier hazmat capability requirements."
    - name: "restricted_item_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN restricted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipment items flagged as restricted — trade compliance KPI for identifying items requiring special regulatory handling."
    - name: "avg_quantity_per_line"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per shipment item line — used to assess order consolidation efficiency and packaging optimization opportunities."
    - name: "distinct_skus_shipped"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs shipped — measures product assortment breadth in logistics and informs carrier capability and packaging requirements."
$$;