-- Metric views for domain: supply | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement metrics derived from purchase orders. Tracks order volume and supplier concentration to support sourcing decisions, budget governance, and franchise supply chain oversight."
  source: "`restaurants_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier — enables grouping of procurement activity by supplier for spend concentration and dependency analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier — allows procurement volume to be attributed to individual restaurant locations."
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient identifier — supports category-level procurement analysis and ingredient-level spend tracking."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee identifier — enables procurement analysis segmented by franchise partner for compliance and spend governance."
    - name: "financial_period_id"
      expr: financial_period_id
      comment: "Financial period identifier — supports period-over-period procurement trend analysis aligned to the fiscal calendar."
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity identifier — enables procurement reporting segmented by legal entity for multi-entity organisations."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders raised. Baseline procurement volume KPI used to track sourcing activity and workload across periods, suppliers, and units."
    - name: "distinct_suppliers_used"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers engaged via purchase orders. Measures supplier diversification — a low count signals single-source dependency risk that procurement leadership must address."
    - name: "distinct_ingredients_ordered"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of unique ingredients procured. Tracks menu ingredient coverage and helps identify gaps or over-reliance on specific ingredients in the supply base."
    - name: "distinct_units_supplied"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units receiving purchase orders. Indicates supply chain reach and helps identify units that may be under-served or bypassing the standard procurement process."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods quality and receiving performance metrics. Tracks receipt volumes, cold-chain compliance, temperature deviations, and total receipt costs to govern food safety and supply chain efficiency."
  source: "`restaurants_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g. accepted, rejected, pending) — enables analysis of receipt outcomes and rejection rates."
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (e.g. dock, direct store delivery) — supports operational efficiency analysis by receiving channel."
    - name: "condition"
      expr: condition
      comment: "Physical condition of goods at receipt — enables quality segmentation and trend analysis of inbound product condition."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Boolean flag indicating whether the receipt met cold-chain temperature requirements — critical food safety dimension."
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Boolean flag indicating a temperature deviation was recorded at receipt — key food safety risk indicator."
    - name: "distribution_center_id"
      expr: distribution_center_id
      comment: "Distribution center where goods were received — enables facility-level quality and compliance benchmarking."
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient received — supports ingredient-level quality and compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt cost — required for multi-currency cost aggregation context."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt events. Baseline inbound supply volume KPI used to track receiving throughput across facilities and periods."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Measures inbound supply volume and supports demand fulfilment and inventory replenishment analysis."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received. Core supply cost KPI used by finance and procurement to track inbound spend and validate against purchase orders."
    - name: "avg_receipt_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per goods receipt event. Benchmarks typical receipt size and helps identify abnormally large or small deliveries that may indicate process or pricing issues."
    - name: "cold_chain_non_compliance_count"
      expr: COUNT(CASE WHEN is_cold_chain_compliant = FALSE THEN 1 END)
      comment: "Number of receipts that failed cold-chain compliance. A critical food safety KPI — any increase triggers immediate investigation and potential supplier corrective action."
    - name: "temperature_deviation_count"
      expr: COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END)
      comment: "Number of receipts with a recorded temperature deviation. Directly linked to food safety risk and regulatory compliance — tracked by quality and operations leadership."
    - name: "avg_receipt_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature (°C) recorded at goods receipt. Monitors cold-chain integrity across the inbound supply chain — deviations from safe ranges indicate systemic cold-chain failures."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics performance metrics covering freight cost, shipment volume, on-time delivery, and temperature control compliance. Supports carrier management, logistics cost governance, and supply chain reliability decisions."
  source: "`restaurants_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, delayed) — enables pipeline visibility and exception management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used (e.g. road, rail, air) — supports modal cost and reliability benchmarking."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier — enables carrier-level performance and cost analysis for contract negotiations."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Boolean flag indicating whether the shipment was expedited — expedited shipments carry premium cost and signal supply chain stress."
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Boolean flag indicating whether temperature control was required for this shipment — segments cold-chain vs. ambient logistics."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status for international shipments — tracks regulatory compliance and clearance delays."
    - name: "distribution_center_id"
      expr: distribution_center_id
      comment: "Destination distribution center — enables facility-level inbound logistics performance analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier originating the shipment — supports supplier-level logistics reliability and cost benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight cost — required for multi-currency freight spend aggregation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the freight invoice — tracks outstanding freight payables and cash flow exposure."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline logistics volume KPI used to track supply chain throughput and carrier utilisation."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all inbound shipments. Core logistics spend KPI used by supply chain and finance leadership to manage transportation budgets and carrier contracts."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks carrier pricing efficiency and identifies cost outliers that may indicate routing or carrier selection issues."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight (kg) of all inbound shipments. Measures physical supply volume and supports freight cost-per-kg efficiency analysis."
    - name: "total_shipment_volume_cubic_m"
      expr: SUM(CAST(volume_cubic_m AS DOUBLE))
      comment: "Total volume (cubic metres) of all inbound shipments. Supports capacity utilisation analysis for distribution centres and transport vehicles."
    - name: "expedited_shipment_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited shipments. A high count signals supply chain disruption or poor demand forecasting — directly impacts freight cost and operational margins."
    - name: "avg_freight_cost_per_kg"
      expr: SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(weight_kg AS DOUBLE)), 0)
      comment: "Freight cost per kilogram shipped. Normalised logistics efficiency KPI used to compare carrier rates and modal efficiency independent of shipment size."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract portfolio metrics covering contract value, rebate potential, compliance status, and contract lifecycle. Supports procurement governance, legal risk management, and supplier relationship decisions."
  source: "`restaurants_ecm`.`supply`.`supplier_contract`"
  dimensions:
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Current status of the supplier contract (e.g. active, expired, terminated) — enables portfolio health monitoring and renewal pipeline management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supplier contract (e.g. fixed-price, volume-based, framework) — supports contract structure analysis and risk segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract — tracks supplier adherence to contractual obligations and regulatory requirements."
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the contract — indicates whether the contract has been reviewed and approved through governance processes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency contract value aggregation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed in the contract (e.g. Net 30, Net 60) — supports working capital and cash flow analysis."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of contract renewal (e.g. auto-renew, manual) — supports contract lifecycle management and renewal risk tracking."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean flag indicating whether the contract includes an exclusivity clause — tracks supplier lock-in risk and sourcing flexibility."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier party to the contract — enables supplier-level contract portfolio analysis."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand covered by the contract — supports brand-level procurement governance and contract segmentation."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN supplier_contract_status = 'active' THEN 1 END)
      comment: "Number of currently active supplier contracts. Core procurement governance KPI — tracks the live supplier contract portfolio and identifies gaps in coverage."
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of supplier contracts across all statuses. Baseline portfolio size metric used to assess procurement complexity and supplier relationship breadth."
    - name: "total_liability_limit"
      expr: SUM(CAST(liability_limit AS DOUBLE))
      comment: "Total contractual liability limit across all supplier contracts. Measures aggregate legal and financial exposure — a critical risk metric for the CFO and General Counsel."
    - name: "avg_liability_limit"
      expr: AVG(CAST(liability_limit AS DOUBLE))
      comment: "Average contractual liability limit per supplier contract. Benchmarks risk exposure per contract and identifies outliers requiring enhanced legal scrutiny."
    - name: "total_rebate_threshold_amount"
      expr: SUM(CAST(rebate_threshold_amount AS DOUBLE))
      comment: "Total rebate threshold amount across all contracts. Tracks the aggregate spend level required to unlock supplier rebates — directly linked to procurement savings realisation."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across supplier contracts. Measures the blended rebate rate achievable from the supplier portfolio — a key procurement value metric tracked in QBRs."
    - name: "non_compliant_contract_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN 1 END)
      comment: "Number of supplier contracts with a non-compliant status. A critical governance KPI — non-compliant contracts expose the business to legal, regulatory, and operational risk."
    - name: "exclusive_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of contracts with exclusivity clauses. Tracks single-source dependency risk — a high count limits the organisation's ability to switch suppliers or negotiate competitively."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_approved_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor item metrics covering pricing, lead times, and supplier preference. Supports strategic sourcing decisions, cost benchmarking, and vendor rationalisation initiatives."
  source: "`restaurants_ecm`.`supply`.`approved_vendor_item`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the vendor-ingredient combination (e.g. approved, pending, suspended) — governs which vendor items are eligible for procurement."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Boolean flag indicating whether this is a preferred supplier for the ingredient — enables preferred vs. non-preferred vendor cost and lead time benchmarking."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier — enables vendor-level pricing and lead time analysis."
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient identifier — supports ingredient-level vendor comparison and sourcing strategy."
  measures:
    - name: "total_approved_vendor_items"
      expr: COUNT(1)
      comment: "Total number of approved vendor-ingredient combinations. Measures the breadth of the approved vendor list — a low count per ingredient signals single-source risk."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across approved vendor items. Core procurement cost benchmark — used to evaluate pricing competitiveness and identify overpriced vendor relationships."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across approved vendor items. Complements unit price to assess total landed cost and margin impact of ingredient sourcing decisions."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days. A critical supply chain reliability KPI — longer lead times increase inventory carrying costs and stockout risk."
    - name: "avg_min_order_quantity"
      expr: AVG(CAST(min_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across vendor items. Measures procurement flexibility — high MOQs constrain order sizing and increase working capital requirements."
    - name: "preferred_vendor_item_count"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Number of vendor items flagged as preferred supplier. Tracks the preferred vendor coverage of the ingredient portfolio — gaps indicate ingredients without a designated primary source."
    - name: "price_premium_vs_cost"
      expr: SUM((CAST(unit_price AS DOUBLE)) - (CAST(cost_per_unit AS DOUBLE)))
      comment: "Aggregate difference between unit price and cost per unit across all approved vendor items. Measures the total pricing spread in the vendor portfolio — a persistent positive gap may indicate margin leakage or pricing inefficiency."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_contract_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract pricing metrics tracking price levels, tier structures, and price change activity. Supports procurement cost management, price index monitoring, and contract compliance decisions."
  source: "`restaurants_ecm`.`supply`.`contract_price`"
  dimensions:
    - name: "contract_price_status"
      expr: contract_price_status
      comment: "Status of the contract price record (e.g. active, expired, superseded) — enables analysis of live vs. historical pricing."
    - name: "price_type"
      expr: price_type
      comment: "Type of contract price (e.g. fixed, indexed, tiered) — supports pricing structure analysis and risk assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract price — required for multi-currency price aggregation and FX exposure analysis."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Reason for a price change — enables root cause analysis of price movements (e.g. commodity inflation, renegotiation, index adjustment)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the contract price — required for price normalisation and cross-ingredient comparisons."
    - name: "is_current"
      expr: is_current
      comment: "Boolean flag indicating whether this is the current active price record — enables filtering to live pricing for cost modelling."
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient covered by the contract price — supports ingredient-level price trend and variance analysis."
    - name: "supplier_contract_id"
      expr: supplier_contract_id
      comment: "Supplier contract under which this price is set — enables contract-level price portfolio analysis."
    - name: "financial_period_id"
      expr: financial_period_id
      comment: "Financial period of the contract price — supports period-over-period price trend analysis aligned to the fiscal calendar."
  measures:
    - name: "total_contract_price_records"
      expr: COUNT(1)
      comment: "Total number of contract price records. Baseline metric tracking the volume of pricing agreements in the system — supports governance and audit completeness checks."
    - name: "avg_contract_price_amount"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average contract price amount across all price records. Core procurement cost benchmark — tracks the blended price level across the ingredient portfolio and supplier base."
    - name: "avg_default_price"
      expr: AVG(CAST(default_price AS DOUBLE))
      comment: "Average default price across contract price records. Benchmarks the baseline pricing level before tier or volume adjustments — used to assess pricing competitiveness."
    - name: "price_vs_default_variance"
      expr: SUM((CAST(price_amount AS DOUBLE)) - (CAST(default_price AS DOUBLE)))
      comment: "Aggregate variance between actual contract price and default price. Measures the total pricing deviation from baseline — positive values indicate above-default pricing that may erode margins."
    - name: "avg_price_tier_max_qty"
      expr: AVG(CAST(price_tier_max_qty AS DOUBLE))
      comment: "Average maximum quantity threshold for price tier eligibility. Supports volume commitment analysis — understanding tier thresholds helps procurement optimise order volumes to achieve better pricing."
    - name: "current_price_record_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of currently active contract price records. Tracks live pricing coverage — gaps indicate ingredients or contracts without a current price, creating procurement risk."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety recall metrics tracking recall volume, severity, regulatory compliance, financial impact, and resolution speed. A critical risk and compliance domain — recall performance is monitored by food safety, legal, and executive leadership."
  source: "`restaurants_ecm`.`supply`.`recall_event`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall event (e.g. open, closed, under investigation) — enables pipeline management and resolution tracking."
    - name: "recall_class"
      expr: recall_class
      comment: "Regulatory class of the recall (e.g. Class I, II, III) — Class I recalls represent the highest consumer risk and require immediate executive escalation."
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity level of the recall — supports risk-based prioritisation and resource allocation for recall response."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g. voluntary, mandatory, market withdrawal) — distinguishes proactive from regulatory-mandated actions."
    - name: "recall_reason"
      expr: recall_reason
      comment: "Root cause reason for the recall — enables trend analysis of recurring failure modes (e.g. contamination, labelling, allergen)."
    - name: "product_category"
      expr: product_category
      comment: "Product category affected by the recall — supports category-level food safety risk analysis."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification (e.g. notified, pending, overdue) — tracks compliance with mandatory reporting timelines."
    - name: "compliance_fda"
      expr: compliance_fda
      comment: "Boolean flag indicating FDA compliance for the recall — tracks adherence to US federal food safety regulations."
    - name: "compliance_usda"
      expr: compliance_usda
      comment: "Boolean flag indicating USDA compliance for the recall — tracks adherence to US agricultural product safety regulations."
    - name: "compliance_haccp"
      expr: compliance_haccp
      comment: "Boolean flag indicating HACCP compliance for the recall — tracks adherence to hazard analysis and critical control point protocols."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the recalled product — enables supplier-level food safety risk scoring and corrective action tracking."
    - name: "ingredient_id"
      expr: ingredient_id
      comment: "Ingredient subject to the recall — supports ingredient-level safety risk analysis and sourcing decisions."
    - name: "distribution_center_id"
      expr: distribution_center_id
      comment: "Distribution center involved in the recall — enables facility-level recall impact and response analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of recalled product (e.g. destruction, return to supplier) — supports cost and environmental impact analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of recall cost — required for multi-currency financial impact aggregation."
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of recall events. Baseline food safety KPI — any upward trend triggers immediate investigation by food safety and quality leadership."
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity of product recalled across all recall events. Measures the physical scale of food safety failures — directly linked to consumer risk exposure and disposal cost."
    - name: "total_recall_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total financial cost of all recall events. Core risk and financial KPI — recall costs include disposal, logistics, regulatory fines, and brand remediation. Tracked by CFO and Chief Risk Officer."
    - name: "avg_recall_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per recall event. Benchmarks the financial impact of individual recalls and helps prioritise prevention investment in high-cost recall categories."
    - name: "class_i_recall_count"
      expr: COUNT(CASE WHEN recall_class = 'Class I' THEN 1 END)
      comment: "Number of Class I (highest severity) recall events. The most critical food safety KPI — Class I recalls represent immediate health hazards and trigger mandatory regulatory reporting and executive escalation."
    - name: "open_recall_count"
      expr: COUNT(CASE WHEN recall_status != 'closed' THEN 1 END)
      comment: "Number of recall events not yet closed. Tracks the active recall backlog — open recalls represent ongoing consumer risk and regulatory exposure that must be resolved urgently."
    - name: "fda_non_compliant_recall_count"
      expr: COUNT(CASE WHEN compliance_fda = FALSE THEN 1 END)
      comment: "Number of recall events not compliant with FDA requirements. A critical regulatory risk KPI — FDA non-compliance can result in enforcement actions, fines, and reputational damage."
    - name: "temperature_deviation_recall_count"
      expr: COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END)
      comment: "Number of recall events associated with a temperature deviation. Identifies cold-chain failures as a root cause of recalls — informs investment in temperature monitoring and cold-chain infrastructure."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`supply_distribution_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity, compliance, and operational metrics. Supports network planning, facility investment decisions, food safety governance, and logistics infrastructure management."
  source: "`restaurants_ecm`.`supply`.`distribution_center`"
  dimensions:
    - name: "distribution_center_status"
      expr: distribution_center_status
      comment: "Operational status of the distribution center (e.g. active, closed, under maintenance) — enables active network analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g. ambient, cold storage, cross-dock) — supports network segmentation and capacity planning by facility type."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g. owned, leased, 3PL) — supports make-vs-buy analysis for distribution network strategy."
    - name: "region"
      expr: region
      comment: "Geographic region of the distribution center — enables regional supply chain performance and capacity analysis."
    - name: "country"
      expr: country
      comment: "Country where the distribution center is located — supports international supply chain network analysis."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Boolean flag indicating HACCP compliance — a mandatory food safety requirement for all distribution facilities."
    - name: "cross_dock_enabled"
      expr: cross_dock_enabled
      comment: "Boolean flag indicating whether cross-docking is enabled — cross-dock capability reduces handling costs and transit times."
    - name: "third_party_logistics_flag"
      expr: third_party_logistics_flag
      comment: "Boolean flag indicating whether the facility is operated by a third-party logistics provider — supports 3PL vs. owned network cost and performance benchmarking."
    - name: "waste_management_certified"
      expr: waste_management_certified
      comment: "Boolean flag indicating waste management certification — tracks environmental compliance and sustainability commitments."
  measures:
    - name: "total_distribution_centers"
      expr: COUNT(1)
      comment: "Total number of distribution centers in the network. Baseline network scale KPI used to track infrastructure footprint and support capacity planning decisions."
    - name: "total_storage_capacity_cubic_meters"
      expr: SUM(CAST(storage_capacity_cubic_meters AS DOUBLE))
      comment: "Total storage capacity (cubic metres) across all distribution centers. Core network capacity KPI — tracks aggregate supply chain storage infrastructure and informs expansion or consolidation decisions."
    - name: "avg_storage_capacity_cubic_meters"
      expr: AVG(CAST(storage_capacity_cubic_meters AS DOUBLE))
      comment: "Average storage capacity per distribution center. Benchmarks facility size and supports network rationalisation — identifies undersized facilities that may constrain supply chain throughput."
    - name: "avg_cost_per_square_meter"
      expr: AVG(CAST(cost_per_square_meter AS DOUBLE))
      comment: "Average cost per square metre across distribution centers. Measures real estate and facility cost efficiency — used by supply chain and finance to benchmark facility economics and inform lease vs. own decisions."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average food safety inspection score across distribution centers. A critical quality KPI — low scores indicate systemic food safety risks that require immediate remediation and may trigger regulatory action."
    - name: "haccp_non_compliant_count"
      expr: COUNT(CASE WHEN haccp_compliant = FALSE THEN 1 END)
      comment: "Number of distribution centers not HACCP compliant. A critical food safety and regulatory risk KPI — non-compliant facilities must be remediated or decommissioned to protect consumer safety and brand integrity."
    - name: "third_party_logistics_count"
      expr: COUNT(CASE WHEN third_party_logistics_flag = TRUE THEN 1 END)
      comment: "Number of distribution centers operated by third-party logistics providers. Tracks 3PL dependency in the network — high 3PL concentration increases supply chain risk and reduces operational control."
$$;