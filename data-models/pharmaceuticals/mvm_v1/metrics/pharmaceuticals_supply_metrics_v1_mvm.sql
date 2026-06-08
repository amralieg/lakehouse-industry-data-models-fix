-- Metric views for domain: supply | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_inventory_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability metrics across pharmaceutical lots. Tracks on-hand stock, quality holds, expiry risk, and lot-level cost exposure to support supply continuity and GDP compliance decisions."
  source: "`pharmaceuticals_ecm`.`supply`.`inventory_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inventory lot (e.g. Released, Quarantine, Rejected) — primary filter for usable stock."
    - name: "material_type"
      expr: material_type
      comment: "Classification of the material (e.g. Finished Good, API, Packaging) for supply segmentation."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition (e.g. 2-8°C, Room Temperature) — critical for cold-chain planning."
    - name: "is_clinical_supply"
      expr: is_clinical_supply
      comment: "Indicates whether the lot is designated for clinical trial supply vs. commercial distribution."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Flags DEA-scheduled controlled substances requiring enhanced regulatory oversight."
    - name: "is_gdp_compliant"
      expr: is_gdp_compliant
      comment: "Indicates GDP compliance status of the lot — non-compliant lots cannot be distributed."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags lots that have experienced a temperature excursion, potentially compromising product integrity."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of lot expiry — used to identify near-term expiry risk and prioritise FEFO dispatch."
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture — supports shelf-life and ageing analysis."
    - name: "site_code"
      expr: site_code
      comment: "Manufacturing or storage site code — enables site-level inventory visibility."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code — standard product identifier for regulatory and commercial reporting."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Inventory valuation type (e.g. Standard Cost, Moving Average) — relevant for financial reporting."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units physically on hand across all lots. Core supply availability KPI used in S&OP and inventory reviews."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total unreserved, releasable quantity available for dispatch. Directly drives order fulfilment capacity decisions."
    - name: "total_quantity_on_quality_hold"
      expr: SUM(CAST(quantity_on_quality_hold AS DOUBLE))
      comment: "Total quantity currently blocked on quality hold. Elevated values signal QA bottlenecks impacting supply."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved against open orders. Indicates committed supply and reduces available stock."
    - name: "quality_hold_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_on_quality_hold AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory currently on quality hold. A rising rate signals systemic quality or GDP compliance issues."
    - name: "inventory_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_available AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Proportion of on-hand inventory that is freely available for dispatch. Key supply readiness indicator for commercial and clinical operations."
    - name: "total_inventory_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total carrying cost of on-hand inventory (unit cost × quantity). Drives working capital and inventory write-off risk assessments."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across lots. Used to benchmark transfer pricing and detect cost anomalies by material or site."
    - name: "lot_count"
      expr: COUNT(DISTINCT inventory_lot_id)
      comment: "Number of distinct active inventory lots. High lot fragmentation increases complexity and expiry risk."
    - name: "expiry_risk_quantity"
      expr: SUM(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN CAST(quantity_available AS DOUBLE) ELSE 0 END)
      comment: "Available quantity expiring within 90 days. Critical for FEFO prioritisation and waste prevention decisions."
    - name: "temperature_excursion_lot_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_excursion_flag = TRUE THEN inventory_lot_id END)
      comment: "Number of lots with a recorded temperature excursion. Directly informs cold-chain integrity and potential recall risk."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "End-to-end shipment performance metrics covering on-time delivery, cold-chain compliance, serialization, and volume throughput. Supports GDP compliance monitoring and logistics performance management."
  source: "`pharmaceuticals_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. In Transit, Delivered, Cancelled) — primary operational filter."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. Air, Road, Sea) — used to analyse cost, speed, and risk trade-offs."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Indicates whether the shipment requires cold-chain management — critical for temperature-sensitive biologics."
    - name: "gdp_compliance_status"
      expr: gdp_compliance_status
      comment: "GDP compliance status of the shipment — non-compliant shipments cannot be released to market."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g. Commercial, Clinical, Inter-company) — drives regulatory and financial treatment."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination (e.g. Distributor, Hospital, Clinical Site) — supports channel-level logistics analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing risk and cost transfer — relevant for cross-border supply chain governance."
    - name: "controlled_substance_flag"
      expr: controlled_substance_flag
      comment: "Flags shipments containing DEA-scheduled substances requiring chain-of-custody documentation."
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month of shipment dispatch — used for trend analysis and S&OP cycle reviews."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin — supports trade compliance and cross-border supply analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Total number of distinct shipments. Baseline throughput KPI for logistics capacity planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped. Core supply output metric used in S&OP and commercial performance reviews."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= estimated_delivery_date THEN shipment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL THEN shipment_id END), 0), 2)
      comment: "Percentage of shipments delivered on or before the estimated delivery date. Key logistics performance indicator for customer service levels."
    - name: "temperature_excursion_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_max_c > temperature_min_c AND temperature_max_c IS NOT NULL THEN shipment_id END)
      comment: "Proxy count of shipments with potential temperature range anomalies. Elevated counts signal cold-chain integrity risk requiring investigation."
    - name: "gdp_non_compliant_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN gdp_compliance_status <> 'Compliant' AND gdp_compliance_status IS NOT NULL THEN shipment_id END)
      comment: "Number of shipments with non-compliant GDP status. Any non-zero value is a regulatory risk requiring immediate remediation."
    - name: "serialization_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN serialization_verified = TRUE THEN shipment_id END) / NULLIF(COUNT(DISTINCT shipment_id), 0), 2)
      comment: "Percentage of shipments with serialization verification completed. Regulatory requirement in most markets — low rates indicate track-and-trace compliance gaps."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms. Used for freight cost allocation and logistics capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic metres. Supports warehouse and transport capacity utilisation analysis."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, shipment_date) AS DOUBLE))
      comment: "Average number of days from shipment dispatch to actual delivery. Benchmarks logistics partner performance and informs safety stock calculations."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning accuracy and forecast quality metrics. Tracks forecast bias, accuracy, safety stock adequacy, and consensus alignment to support S&OP decision-making and supply risk management."
  source: "`pharmaceuticals_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the demand plan (e.g. Draft, Approved, Locked) — filters to active planning cycles."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Classification of demand type (e.g. Commercial, Clinical, Safety Stock) — drives planning strategy."
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "S&OP planning cycle identifier — enables cycle-over-cycle forecast performance comparison."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area (e.g. Oncology, Immunology) — supports portfolio-level demand analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel (e.g. Wholesale, Direct, Specialty Pharmacy) — channel-level demand visibility."
    - name: "supply_chain_tier"
      expr: supply_chain_tier
      comment: "Supply chain tier (e.g. Tier 1, Tier 2) — identifies planning horizon and granularity level."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flags cold-chain products — these require specialised logistics and have higher supply risk."
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_date)
      comment: "Month of the forecast period — primary time dimension for demand trend analysis."
    - name: "statistical_model_type"
      expr: statistical_model_type
      comment: "Statistical forecasting model used (e.g. ARIMA, Exponential Smoothing) — supports model performance benchmarking."
    - name: "demand_signal_source"
      expr: demand_signal_source
      comment: "Source of the demand signal (e.g. POS, Orders, IMS) — indicates data quality and signal reliability."
  measures:
    - name: "total_consensus_forecast_qty"
      expr: SUM(CAST(consensus_forecast_qty AS DOUBLE))
      comment: "Total consensus-approved forecast quantity. The primary demand signal used for production and procurement planning."
    - name: "total_baseline_forecast_qty"
      expr: SUM(CAST(baseline_forecast_qty AS DOUBLE))
      comment: "Total statistical baseline forecast before commercial adjustments. Benchmarks the value added by human override."
    - name: "total_adjusted_forecast_qty"
      expr: SUM(CAST(adjusted_forecast_qty AS DOUBLE))
      comment: "Total adjusted forecast quantity after planner overrides. Compared to baseline to quantify override impact."
    - name: "forecast_override_volume"
      expr: SUM(CAST(adjusted_forecast_qty AS DOUBLE) - CAST(baseline_forecast_qty AS DOUBLE))
      comment: "Net volume difference between adjusted and baseline forecast. Large positive or negative values indicate significant human intervention in the statistical model."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_pct AS DOUBLE))
      comment: "Average forecast accuracy percentage across plans. Industry benchmark is >80% — below this threshold drives excess inventory or stockouts."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias (positive = over-forecast, negative = under-forecast). Persistent bias indicates systematic model or process failure requiring correction."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity planned. Directly impacts working capital — over-stocking ties up cash, under-stocking creates stockout risk."
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity across plans. Triggers replenishment actions — miscalibration leads to supply disruptions."
    - name: "consensus_vs_baseline_uplift_pct"
      expr: ROUND(100.0 * SUM(CAST(adjusted_forecast_qty AS DOUBLE) - CAST(baseline_forecast_qty AS DOUBLE)) / NULLIF(SUM(CAST(baseline_forecast_qty AS DOUBLE)), 0), 2)
      comment: "Percentage uplift of adjusted forecast over baseline. Quantifies the commercial team's net adjustment to statistical forecasts — a governance metric for S&OP process quality."
    - name: "active_plan_count"
      expr: COUNT(DISTINCT demand_plan_id)
      comment: "Number of active demand plans. Tracks planning coverage across products and markets."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_clinical_supply_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical supply order fulfilment metrics tracking order quantities, delivery performance, cold-chain compliance, and QP release status. Supports clinical trial supply chain governance and IRT system oversight."
  source: "`pharmaceuticals_ecm`.`supply`.`clinical_supply_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the clinical supply order (e.g. Open, Shipped, Delivered, Cancelled)."
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical supply order (e.g. Initial, Resupply, Emergency) — drives prioritisation and logistics planning."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding type (e.g. Double-Blind, Open-Label) — critical for clinical integrity and packaging requirements."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flags orders requiring cold-chain logistics — higher complexity and cost."
    - name: "qualified_person_release"
      expr: qualified_person_release
      comment: "Indicates whether QP release has been completed — mandatory before clinical supply can be dispensed."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority (e.g. Urgent, Standard) — used to triage supply allocation and logistics scheduling."
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "Country of shipment origin — supports import/export compliance and cross-border supply analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed — primary time dimension for clinical supply trend analysis."
    - name: "is_blinded"
      expr: is_blinded
      comment: "Boolean flag indicating whether the supply is blinded — affects packaging, labelling, and handling procedures."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across clinical supply orders. Primary volume metric for clinical supply planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped against clinical orders. Compared to ordered quantity to identify fulfilment gaps."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total QP-approved quantity. Represents the maximum releasable supply for clinical use."
    - name: "order_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been shipped. Low fill rates risk patient enrolment delays and protocol deviations in clinical trials."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= required_delivery_date THEN clinical_supply_order_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL THEN clinical_supply_order_id END), 0), 2)
      comment: "Percentage of clinical supply orders delivered by the required date. Delays directly impact patient dosing schedules and trial timelines."
    - name: "qp_release_pending_order_count"
      expr: COUNT(DISTINCT CASE WHEN qualified_person_release = FALSE OR qualified_person_release IS NULL THEN clinical_supply_order_id END)
      comment: "Number of orders awaiting QP release. Unresolved QP holds are a critical bottleneck for clinical supply availability."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, shipment_date) AS DOUBLE))
      comment: "Average days from shipment to actual delivery for clinical orders. Benchmarks courier performance and informs site resupply lead times."
    - name: "total_clinical_supply_orders"
      expr: COUNT(DISTINCT clinical_supply_order_id)
      comment: "Total number of clinical supply orders. Baseline throughput metric for clinical operations capacity planning."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall effectiveness and regulatory compliance metrics. Tracks recall scope, recovery rates, regulatory notification timeliness, and health hazard classification to support quality and regulatory affairs governance."
  source: "`pharmaceuticals_ecm`.`supply`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g. Ongoing, Closed, Pending) — primary operational filter."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA/EMA recall classification (Class I, II, III) — Class I is the most severe, indicating serious health risk."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g. Voluntary, Mandatory, Market Withdrawal) — determines regulatory obligations."
    - name: "recall_reason_code"
      expr: recall_reason_code
      comment: "Coded reason for the recall (e.g. Contamination, Labelling Error, Potency) — drives root cause analysis."
    - name: "distribution_level"
      expr: distribution_level
      comment: "Level of distribution reached (e.g. Wholesale, Retail, Patient) — determines recall scope and complexity."
    - name: "health_hazard_assessment"
      expr: health_hazard_assessment
      comment: "Health hazard assessment outcome — informs urgency and public communication strategy."
    - name: "recall_initiated_month"
      expr: DATE_TRUNC('MONTH', recall_initiated_date)
      comment: "Month the recall was initiated — used for trend analysis and regulatory reporting cycles."
    - name: "gdp_compliance_flag"
      expr: gdp_compliance_flag
      comment: "Indicates whether GDP compliance was maintained during the recall process."
    - name: "affected_markets"
      expr: affected_markets
      comment: "Markets affected by the recall — supports geographic scope assessment and regulatory notification planning."
  measures:
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS DOUBLE))
      comment: "Total quantity distributed prior to recall initiation. Defines the maximum scope of patient exposure and recovery effort."
    - name: "total_quantity_recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity successfully recovered. Directly measures recall execution effectiveness and residual market risk."
    - name: "recall_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_recovered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_distributed AS DOUBLE)), 0), 2)
      comment: "Percentage of distributed product recovered. Regulatory agencies expect high recovery rates for Class I recalls — low rates indicate execution failure."
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_pct AS DOUBLE))
      comment: "Average recall effectiveness percentage as assessed. Regulatory benchmark metric — FDA expects >99% for Class I recalls."
    - name: "regulatory_notification_lag_days"
      expr: AVG(CAST(DATEDIFF(regulatory_notification_date, recall_initiated_date) AS DOUBLE))
      comment: "Average days between recall initiation and regulatory notification. Regulatory requirements mandate notification within 3 days for Class I — breaches create enforcement risk."
    - name: "customer_notification_lag_days"
      expr: AVG(CAST(DATEDIFF(customer_notification_date, recall_initiated_date) AS DOUBLE))
      comment: "Average days between recall initiation and customer notification. Delays increase patient safety risk and regulatory scrutiny."
    - name: "open_recall_count"
      expr: COUNT(DISTINCT CASE WHEN recall_status <> 'Closed' AND recall_status IS NOT NULL THEN product_recall_id END)
      comment: "Number of currently open recalls. Any open Class I recall is a critical business and patient safety risk requiring executive attention."
    - name: "total_recalls"
      expr: COUNT(DISTINCT product_recall_id)
      comment: "Total number of product recalls. Trend increases signal systemic quality or manufacturing issues requiring root cause investigation."
    - name: "avg_recall_closure_days"
      expr: AVG(CAST(DATEDIFF(recall_closure_date, recall_initiated_date) AS DOUBLE))
      comment: "Average days from recall initiation to closure. Prolonged open recalls indicate execution challenges and sustained regulatory exposure."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_cold_chain_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain integrity and temperature excursion monitoring metrics. Tracks excursion frequency, severity, GDP compliance, and disposition outcomes to protect product quality and regulatory standing."
  source: "`pharmaceuticals_ecm`.`supply`.`cold_chain_record`"
  dimensions:
    - name: "excursion_flag"
      expr: excursion_flag
      comment: "Primary flag indicating whether a temperature excursion occurred — the key cold-chain quality signal."
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity classification of the excursion (e.g. Minor, Major, Critical) — drives disposition and regulatory reporting decisions."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Outcome of the quality disposition review (e.g. Released, Rejected, Pending) — determines product usability."
    - name: "gdp_compliance_status"
      expr: gdp_compliance_status
      comment: "GDP compliance status of the cold chain event — non-compliant records require regulatory notification."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flags excursions that must be reported to regulatory authorities — mandatory compliance tracking."
    - name: "location_type"
      expr: location_type
      comment: "Type of location where the excursion occurred (e.g. Warehouse, In-Transit, Site) — identifies weak points in the cold chain."
    - name: "supply_chain_segment"
      expr: supply_chain_segment
      comment: "Supply chain segment (e.g. Primary, Secondary, Last Mile) — pinpoints excursion hotspots."
    - name: "device_type"
      expr: device_type
      comment: "Type of temperature monitoring device — supports device performance benchmarking."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the temperature reading — used for trend analysis of cold chain performance."
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone within the facility — identifies specific zones with recurring excursion patterns."
  measures:
    - name: "total_excursion_events"
      expr: COUNT(DISTINCT CASE WHEN excursion_flag = TRUE THEN cold_chain_record_id END)
      comment: "Total number of temperature excursion events. Any excursion risks product integrity and may trigger regulatory reporting obligations."
    - name: "excursion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN excursion_flag = TRUE THEN cold_chain_record_id END) / NULLIF(COUNT(DISTINCT cold_chain_record_id), 0), 2)
      comment: "Percentage of cold chain monitoring records with a temperature excursion. Industry benchmark is <1% — elevated rates indicate systemic cold chain failures."
    - name: "regulatory_reportable_excursion_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable = TRUE AND excursion_flag = TRUE THEN cold_chain_record_id END)
      comment: "Number of excursions requiring regulatory notification. Each represents a mandatory compliance action — unresolved items create enforcement risk."
    - name: "avg_temperature_reading_c"
      expr: AVG(CAST(temperature_reading_c AS DOUBLE))
      comment: "Average temperature reading across monitoring events. Persistent deviation from target range signals equipment or process failure."
    - name: "avg_humidity_reading_pct"
      expr: AVG(CAST(humidity_reading_pct AS DOUBLE))
      comment: "Average humidity reading across monitoring events. Out-of-specification humidity can degrade product stability independent of temperature."
    - name: "gdp_non_compliant_record_count"
      expr: COUNT(DISTINCT CASE WHEN gdp_compliance_status <> 'Compliant' AND gdp_compliance_status IS NOT NULL THEN cold_chain_record_id END)
      comment: "Number of cold chain records with GDP non-compliance. Non-compliant records block product release and require CAPA initiation."
    - name: "pending_disposition_count"
      expr: COUNT(DISTINCT CASE WHEN disposition_status = 'Pending' OR disposition_status IS NULL THEN cold_chain_record_id END)
      comment: "Number of cold chain records awaiting disposition decision. Backlog indicates QA resource constraints and delays product release."
    - name: "max_temperature_reading_c"
      expr: MAX(CAST(temperature_reading_c AS DOUBLE))
      comment: "Maximum temperature recorded across all monitoring events. Extreme values identify worst-case excursions for risk assessment."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and clinical delivery order fulfilment metrics. Tracks delivery quantities, FEFO compliance, goods issue performance, and temperature excursion rates to support distribution excellence and customer service."
  source: "`pharmaceuticals_ecm`.`supply`.`delivery_order`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery order (e.g. Open, Picked, Shipped, Delivered) — primary fulfilment tracking dimension."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g. Standard, Express, Clinical) — drives logistics prioritisation and cost allocation."
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level of the delivery — used to triage fulfilment operations and allocate warehouse resources."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flags deliveries requiring cold-chain logistics — higher complexity and regulatory scrutiny."
    - name: "clinical_supply_flag"
      expr: clinical_supply_flag
      comment: "Distinguishes clinical trial supply deliveries from commercial — different regulatory and handling requirements."
    - name: "fefo_compliant"
      expr: fefo_compliant
      comment: "Indicates whether First-Expiry-First-Out picking was applied — non-compliance increases waste and expiry risk."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags deliveries with a recorded temperature excursion — potential product quality compromise."
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Status of goods issue processing — pending goods issues block inventory depletion and financial posting."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of planned delivery — primary time dimension for delivery performance trend analysis."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the delivered product — used to validate cold-chain compliance."
  measures:
    - name: "total_delivery_quantity"
      expr: SUM(CAST(delivery_quantity AS DOUBLE))
      comment: "Total quantity planned for delivery. Primary volume metric for distribution capacity planning."
    - name: "total_goods_issue_quantity"
      expr: SUM(CAST(goods_issue_quantity AS DOUBLE))
      comment: "Total quantity for which goods issue has been posted. Represents confirmed inventory depletion and revenue recognition trigger."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity picked from warehouse. Compared to delivery quantity to identify picking shortfalls."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(goods_issue_quantity AS DOUBLE)) / NULLIF(SUM(CAST(delivery_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned delivery quantity that has been goods-issued. Core customer service level metric — low rates indicate fulfilment failures."
    - name: "fefo_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fefo_compliant = TRUE THEN delivery_order_id END) / NULLIF(COUNT(DISTINCT delivery_order_id), 0), 2)
      comment: "Percentage of delivery orders picked in FEFO sequence. Non-compliance increases product waste and expiry risk — a key warehouse quality KPI."
    - name: "temperature_excursion_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN temperature_excursion_flag = TRUE THEN delivery_order_id END) / NULLIF(COUNT(DISTINCT delivery_order_id), 0), 2)
      comment: "Percentage of deliveries with a temperature excursion. Elevated rates signal cold-chain failures requiring logistics partner review."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of delivery orders in kilograms. Used for freight cost allocation and carrier capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of delivery orders in cubic metres. Supports warehouse space and transport utilisation analysis."
    - name: "on_time_goods_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_goods_issue_date <= planned_delivery_date THEN delivery_order_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_goods_issue_date IS NOT NULL THEN delivery_order_id END), 0), 2)
      comment: "Percentage of delivery orders where goods issue was posted on or before the planned delivery date. Measures warehouse execution timeliness."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_stock_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-site and inter-company stock transfer performance metrics. Tracks transfer quantities, GDP compliance, on-time receipt, and controlled substance handling to support network inventory balancing and regulatory compliance."
  source: "`pharmaceuticals_ecm`.`supply`.`stock_transfer_order`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the stock transfer order (e.g. Open, In Transit, Received, Cancelled)."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g. Plant-to-Plant, Intercompany, Returns) — determines financial and regulatory treatment."
    - name: "transfer_category"
      expr: transfer_category
      comment: "Category of the transfer (e.g. Commercial, Clinical, Safety Stock) — supports supply chain segmentation."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flags transfers requiring cold-chain logistics — higher risk and cost profile."
    - name: "controlled_substance_flag"
      expr: controlled_substance_flag
      comment: "Flags transfers of DEA-scheduled substances — requires enhanced chain-of-custody documentation."
    - name: "gdp_compliant"
      expr: gdp_compliant
      comment: "Indicates whether the transfer was executed in GDP compliance — non-compliant transfers cannot be received into releasable stock."
    - name: "supply_chain_type"
      expr: supply_chain_type
      comment: "Supply chain type (e.g. Commercial, Clinical, Named Patient) — drives planning and regulatory requirements."
    - name: "priority_level"
      expr: priority_level
      comment: "Transfer priority (e.g. Urgent, Standard) — used to triage logistics scheduling."
    - name: "goods_issue_month"
      expr: DATE_TRUNC('MONTH', goods_issue_date)
      comment: "Month goods were issued from the sending location — primary time dimension for transfer volume trend analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock being transferred (e.g. Unrestricted, Quality Inspection, Blocked) — determines usability at receiving location."
  measures:
    - name: "total_transfer_quantity"
      expr: SUM(CAST(transfer_quantity AS DOUBLE))
      comment: "Total quantity planned for transfer. Primary volume metric for network inventory balancing decisions."
    - name: "total_issued_quantity"
      expr: SUM(CAST(issued_quantity AS DOUBLE))
      comment: "Total quantity actually issued from the sending location. Compared to transfer quantity to identify dispatch shortfalls."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity confirmed received at the destination. Compared to issued quantity to identify in-transit losses."
    - name: "transfer_receipt_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(issued_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of issued quantity confirmed received. Shortfalls indicate in-transit losses, documentation errors, or quality rejections."
    - name: "on_time_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN goods_receipt_date <= requested_delivery_date THEN stock_transfer_order_id END) / NULLIF(COUNT(DISTINCT CASE WHEN goods_receipt_date IS NOT NULL THEN stock_transfer_order_id END), 0), 2)
      comment: "Percentage of stock transfers received by the requested delivery date. Delays disrupt downstream production and distribution planning."
    - name: "gdp_non_compliant_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN gdp_compliant = FALSE THEN stock_transfer_order_id END)
      comment: "Number of stock transfers executed without GDP compliance. Each represents a regulatory risk — product cannot enter releasable stock without remediation."
    - name: "avg_transfer_lead_time_days"
      expr: AVG(CAST(DATEDIFF(goods_receipt_date, goods_issue_date) AS DOUBLE))
      comment: "Average days from goods issue to goods receipt. Benchmarks logistics network performance and informs safety stock calculations."
    - name: "total_stock_transfer_orders"
      expr: COUNT(DISTINCT stock_transfer_order_id)
      comment: "Total number of stock transfer orders. Baseline throughput metric for supply network activity."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue financial and operational metrics. Tracks material cost, issue quantities, controlled substance movements, and GMP relevance to support inventory accounting, cost control, and regulatory compliance."
  source: "`pharmaceuticals_ecm`.`supply`.`goods_issue`"
  dimensions:
    - name: "gi_status"
      expr: gi_status
      comment: "Status of the goods issue document (e.g. Posted, Reversed, Pending) — primary operational filter."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type code (e.g. 601 Delivery, 551 Scrapping) — determines the business purpose of the inventory movement."
    - name: "order_type"
      expr: order_type
      comment: "Type of order driving the goods issue (e.g. Sales Order, Production Order, Clinical) — supports cost allocation."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Flags goods issues involving DEA-scheduled substances — requires enhanced audit trail and regulatory reporting."
    - name: "is_gmp_relevant"
      expr: is_gmp_relevant
      comment: "Indicates whether the goods issue is GMP-relevant — affects documentation and quality system requirements."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flags goods issues for cold-chain products — relevant for logistics cost and compliance analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock issued (e.g. Unrestricted, Quality Inspection) — non-unrestricted issues may indicate quality events."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the material cost amount — required for multi-currency financial consolidation."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods issue posting — primary time dimension for inventory cost trend analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the goods issue (e.g. Destruction, Sample, Expiry) — supports waste and loss analysis."
  measures:
    - name: "total_issued_quantity"
      expr: SUM(CAST(issued_quantity AS DOUBLE))
      comment: "Total quantity issued from inventory. Core inventory depletion metric used in supply chain and financial reporting."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost of goods issued. Directly impacts COGS and inventory valuation — key financial metric for supply chain finance."
    - name: "avg_unit_material_cost"
      expr: ROUND(SUM(CAST(material_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(issued_quantity AS DOUBLE)), 0), 4)
      comment: "Average material cost per unit issued. Benchmarks transfer pricing and identifies cost anomalies by product or movement type."
    - name: "controlled_substance_issue_count"
      expr: COUNT(DISTINCT CASE WHEN is_controlled_substance = TRUE THEN goods_issue_id END)
      comment: "Number of goods issues involving controlled substances. Each must be traceable in DEA records — gaps create enforcement risk."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reversal_document_number IS NOT NULL THEN goods_issue_id END) / NULLIF(COUNT(DISTINCT goods_issue_id), 0), 2)
      comment: "Percentage of goods issues that have been reversed. High reversal rates indicate data quality issues, process errors, or quality rejections."
    - name: "total_goods_issues"
      expr: COUNT(DISTINCT goods_issue_id)
      comment: "Total number of goods issue documents. Baseline throughput metric for warehouse and inventory operations."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_warehouse_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt quality and compliance metrics. Tracks received quantities, quarantine rates, temperature excursions, and GDP compliance at receipt to support inbound quality control and supplier performance management."
  source: "`pharmaceuticals_ecm`.`supply`.`warehouse_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the warehouse receipt (e.g. Posted, Pending, Reversed) — primary operational filter."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) — determines immediate usability."
    - name: "gdp_compliance_status"
      expr: gdp_compliance_status
      comment: "GDP compliance status at receipt — non-compliant receipts cannot be released to usable stock."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Flags receipts placed into quarantine — quarantined stock is unavailable until QA disposition."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags receipts with a temperature excursion detected at goods receipt — may trigger rejection or quality investigation."
    - name: "clinical_supply_flag"
      expr: clinical_supply_flag
      comment: "Distinguishes clinical supply receipts from commercial — different QA and documentation requirements."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for received goods — used to validate correct storage assignment."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting — primary time dimension for inbound volume trend analysis."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier delivering the goods — supports carrier performance benchmarking."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received into the warehouse. Core inbound supply metric for inventory replenishment tracking."
    - name: "total_po_quantity"
      expr: SUM(CAST(po_quantity AS DOUBLE))
      comment: "Total purchase order quantity expected. Compared to received quantity to identify delivery shortfalls."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(po_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of PO quantity actually received. Shortfalls indicate supplier delivery failures impacting production and distribution plans."
    - name: "quarantine_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quarantine_flag = TRUE THEN warehouse_receipt_id END) / NULLIF(COUNT(DISTINCT warehouse_receipt_id), 0), 2)
      comment: "Percentage of receipts placed into quarantine. High rates indicate supplier quality issues or documentation failures — a key supplier performance KPI."
    - name: "temperature_excursion_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN temperature_excursion_flag = TRUE THEN warehouse_receipt_id END) / NULLIF(COUNT(DISTINCT warehouse_receipt_id), 0), 2)
      comment: "Percentage of receipts with a temperature excursion at delivery. Elevated rates indicate carrier cold-chain failures requiring contract review."
    - name: "gdp_non_compliant_receipt_count"
      expr: COUNT(DISTINCT CASE WHEN gdp_compliance_status <> 'Compliant' AND gdp_compliance_status IS NOT NULL THEN warehouse_receipt_id END)
      comment: "Number of receipts with GDP non-compliance. Each blocks stock release and requires CAPA — a critical quality and supply risk indicator."
    - name: "total_warehouse_receipts"
      expr: COUNT(DISTINCT warehouse_receipt_id)
      comment: "Total number of warehouse receipts. Baseline inbound throughput metric for receiving operations capacity planning."
$$;