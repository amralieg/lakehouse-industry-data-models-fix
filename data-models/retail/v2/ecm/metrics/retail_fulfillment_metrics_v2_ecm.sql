-- Metric views for domain: fulfillment | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fulfillment order throughput, cost, weight, and SLA performance. Drives decisions on node capacity, carrier selection, and promised-delivery commitments."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment channel (ship-to-home, BOPIS, curbside, etc.) used to segment order volume and cost by channel."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current lifecycle status of the fulfillment order (pending, picking, packed, shipped, delivered, cancelled) for funnel analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority tier (standard, expedited, same-day) to analyze SLA compliance by urgency segment."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Calendar day the fulfillment order was created, enabling daily throughput trending."
    - name: "order_date_week"
      expr: DATE_TRUNC('WEEK', order_date)
      comment: "ISO week the fulfillment order was created, for weekly capacity and volume planning."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Calendar month the fulfillment order was created, for monthly operational reviews."
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether the order contains a gift, used to track gift-fulfillment volume and special-handling demand."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency shipping cost analysis."
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders processed. Baseline throughput KPI for capacity planning and operational reviews."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total outbound shipping cost across all fulfillment orders. Directly informs carrier negotiation and cost-reduction initiatives."
    - name: "avg_shipping_cost_per_order"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per fulfillment order. Tracks cost efficiency trends and benchmarks carrier performance."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms across all orders. Used for carrier rate negotiation and dimensional-weight billing analysis."
    - name: "avg_weight_per_order_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight per order. Informs packaging standards and carrier tier selection."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Drives truck-load utilization and warehouse space planning decisions."
    - name: "avg_actual_fulfillment_hours"
      expr: AVG(CAST(actual_fulfillment_hours AS DOUBLE))
      comment: "Average actual hours from order receipt to shipment. Core operational efficiency KPI compared against SLA targets."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'cancelled' THEN 1 END)
      comment: "Number of fulfillment orders cancelled. Elevated cancellation rates signal inventory, capacity, or carrier availability issues."
    - name: "gift_order_count"
      expr: COUNT(CASE WHEN is_gift = TRUE THEN 1 END)
      comment: "Number of gift orders requiring special handling. Drives staffing and packaging supply decisions during peak seasons."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes active in the period. Measures network breadth and node utilization spread."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level KPIs covering cost, weight, volume, and on-time delivery performance. Core metrics for carrier management, logistics cost control, and customer experience."
  source: "`vibe_retail_v1`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in-transit, delivered, exception, returned) for pipeline visibility."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method (ship-to-home, ship-from-store, drop-ship) to segment cost and performance by channel."
    - name: "ship_from_location_type"
      expr: ship_from_location_type
      comment: "Origin location type (DC, store, vendor) to analyze cost and transit-time differences by origin."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for international vs. domestic shipment cost and transit analysis."
    - name: "ship_date_day"
      expr: DATE_TRUNC('DAY', ship_date)
      comment: "Calendar day shipment was dispatched, enabling daily volume and cost trending."
    - name: "ship_date_week"
      expr: DATE_TRUNC('WEEK', ship_date)
      comment: "ISO week of shipment dispatch for weekly carrier performance reviews."
    - name: "ship_date_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Calendar month of shipment dispatch for monthly logistics cost reporting."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the shipment contains hazardous materials, used to segment compliance costs and carrier surcharges."
    - name: "carrier_charge_currency_code"
      expr: carrier_charge_currency_code
      comment: "Currency of the carrier charge for multi-currency cost normalization."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total shipments dispatched. Baseline volume KPI for logistics capacity and carrier contract utilization."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost incurred. Primary logistics cost KPI driving carrier negotiation and mode-shift decisions."
    - name: "avg_shipping_cost_per_shipment"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per shipment. Benchmarks carrier efficiency and tracks cost-per-unit trends over time."
    - name: "total_carrier_charge"
      expr: SUM(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Total amount billed by carriers. Compared against contracted rates to identify billing discrepancies and overcharges."
    - name: "avg_carrier_charge_per_shipment"
      expr: AVG(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Average carrier charge per shipment. Used in carrier scorecard and rate-negotiation benchmarking."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Drives carrier tier selection and dimensional-weight billing reconciliation."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight. Informs packaging optimization and carrier weight-break tier management."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Used for truck-load utilization analysis and dimensional-weight cost management."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of shipments. Drives insurance coverage decisions and liability exposure assessment."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivered shipments that arrived on or before the estimated delivery date. Core customer experience and carrier SLA KPI."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used in the period. Measures carrier diversification and dependency concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package-level KPIs for dimensional weight billing, insurance exposure, and packaging efficiency. Informs packaging standardization and carrier cost optimization."
  source: "`vibe_retail_v1`.`fulfillment`.`shipment_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (packed, labeled, manifested, in-transit, delivered) for pipeline tracking."
    - name: "package_type"
      expr: package_type
      comment: "Package type (box, poly-bag, envelope, pallet) to analyze cost and damage rates by packaging format."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping service level used (ground, 2-day, overnight) for cost and transit-time segmentation."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the package contains hazardous materials, for compliance cost segmentation."
    - name: "is_insured"
      expr: is_insured
      comment: "Whether the package carries declared insurance, for insurance cost and coverage analysis."
    - name: "is_signature_required"
      expr: is_signature_required
      comment: "Whether a delivery signature is required, to track signature-surcharge cost exposure."
    - name: "estimated_delivery_date_month"
      expr: DATE_TRUNC('MONTH', estimated_delivery_date)
      comment: "Month of estimated delivery for monthly volume and cost forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of shipping cost for multi-currency cost normalization."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total packages processed. Baseline volume KPI for packaging supply planning and carrier manifest reconciliation."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all packages. Primary cost KPI for packaging and carrier cost management."
    - name: "avg_shipping_cost_per_package"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per package. Benchmarks packaging efficiency and carrier rate utilization."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total actual weight of all packages. Used for carrier billing reconciliation and weight-break tier analysis."
    - name: "total_billable_weight_kg"
      expr: SUM(CAST(billable_weight_kg AS DOUBLE))
      comment: "Total billable weight (greater of actual vs. dimensional weight). Directly drives carrier invoice amounts."
    - name: "total_dimensional_weight_kg"
      expr: SUM(CAST(dimensional_weight_kg AS DOUBLE))
      comment: "Total dimensional weight across packages. Identifies over-packaged SKUs driving unnecessary carrier surcharges."
    - name: "dimensional_weight_premium_kg"
      expr: SUM(CAST(dimensional_weight_kg AS DOUBLE) - CAST(weight_kg AS DOUBLE))
      comment: "Total excess dimensional weight over actual weight. Quantifies packaging inefficiency cost opportunity."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total insured value across packages. Drives insurance premium budgeting and risk exposure assessment."
    - name: "insured_package_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_insured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages carrying insurance. Informs insurance policy coverage decisions and cost optimization."
    - name: "signature_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_signature_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages requiring delivery signature. Tracks signature-surcharge cost exposure and customer friction."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master KPIs covering rate structures, surcharge exposure, and capability coverage. Supports carrier selection, contract negotiation, and network diversification decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Carrier category (parcel, LTL, FTL, last-mile, postal) for network strategy segmentation."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (active, suspended, inactive) for network availability analysis."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of carrier coverage (domestic, international, regional) for network gap analysis."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the carrier is certified for hazardous materials, for compliance routing decisions."
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether the carrier supports EDI integration, for automation and operational efficiency segmentation."
    - name: "contract_end_date_month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
      comment: "Month of contract expiry to proactively identify renewal windows and negotiation timelines."
  measures:
    - name: "total_active_carriers"
      expr: COUNT(CASE WHEN carrier_status = 'active' THEN 1 END)
      comment: "Number of active carriers in the network. Measures carrier diversification and single-carrier dependency risk."
    - name: "avg_base_rate_per_lb"
      expr: AVG(CAST(base_rate_per_lb AS DOUBLE))
      comment: "Average base shipping rate per pound across carriers. Benchmarks carrier cost competitiveness for contract negotiations."
    - name: "avg_fuel_surcharge_percentage"
      expr: AVG(CAST(fuel_surcharge_percentage AS DOUBLE))
      comment: "Average fuel surcharge percentage across carriers. Tracks fuel cost exposure and informs carrier mix decisions during fuel price volatility."
    - name: "avg_negotiated_discount_percentage"
      expr: AVG(CAST(negotiated_discount_percentage AS DOUBLE))
      comment: "Average negotiated discount percentage across carrier contracts. Measures procurement effectiveness in carrier rate negotiations."
    - name: "avg_dimensional_weight_factor"
      expr: AVG(CAST(dimensional_weight_factor AS DOUBLE))
      comment: "Average dimensional weight divisor across carriers. Informs packaging optimization to minimize dimensional-weight billing."
    - name: "same_day_capable_carrier_count"
      expr: COUNT(CASE WHEN service_level_same_day = TRUE THEN 1 END)
      comment: "Number of carriers offering same-day delivery. Measures same-day fulfillment network capacity and resilience."
    - name: "overnight_capable_carrier_count"
      expr: COUNT(CASE WHEN service_level_overnight = TRUE THEN 1 END)
      comment: "Number of carriers offering overnight delivery. Ensures sufficient overnight capacity for premium service commitments."
    - name: "avg_extended_area_surcharge"
      expr: AVG(CAST(extended_area_surcharge AS DOUBLE))
      comment: "Average extended area surcharge across carriers. Quantifies rural/remote delivery cost premium for pricing and zone strategy."
    - name: "avg_residential_delivery_surcharge"
      expr: AVG(CAST(residential_delivery_surcharge AS DOUBLE))
      comment: "Average residential delivery surcharge. Informs B2C shipping cost modeling and customer-facing shipping fee decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_carrier_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier rate card KPIs for cost benchmarking, surcharge analysis, and rate optimization. Drives carrier selection logic and shipping cost modeling."
  source: "`vibe_retail_v1`.`fulfillment`.`carrier_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Rate card type (base, negotiated, spot, contract) for cost tier analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Whether the rate is active, expired, or pending, for rate card currency management."
    - name: "service_level"
      expr: service_level
      comment: "Service level (ground, 2-day, overnight, same-day) for cost-by-service-tier analysis."
    - name: "rate_zone"
      expr: rate_zone
      comment: "Geographic rate zone for origin-destination cost matrix analysis."
    - name: "is_international"
      expr: is_international
      comment: "Whether the rate applies to international shipments, for domestic vs. international cost segmentation."
    - name: "is_hazmat_eligible"
      expr: is_hazmat_eligible
      comment: "Whether the rate covers hazardous materials, for compliance routing cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate for multi-currency cost normalization."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate became effective, for rate change trend analysis."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total rate card entries. Measures rate card complexity and coverage breadth."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across rate cards. Benchmarks carrier cost competitiveness across zones and service levels."
    - name: "avg_rate_per_kg"
      expr: AVG(CAST(rate_per_kg AS DOUBLE))
      comment: "Average per-kilogram rate. Enables weight-normalized carrier cost comparison across service levels and zones."
    - name: "avg_fuel_surcharge_rate"
      expr: AVG(CAST(fuel_surcharge_rate AS DOUBLE))
      comment: "Average fuel surcharge rate across active rate cards. Tracks fuel cost exposure for shipping cost forecasting."
    - name: "avg_negotiated_discount_percentage"
      expr: AVG(CAST(negotiated_discount_percentage AS DOUBLE))
      comment: "Average negotiated discount applied to base rates. Measures procurement effectiveness in carrier rate negotiations."
    - name: "avg_residential_delivery_surcharge"
      expr: AVG(CAST(residential_delivery_surcharge AS DOUBLE))
      comment: "Average residential surcharge across rate cards. Informs B2C shipping cost modeling and customer-facing fee decisions."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge floor across rate cards. Identifies minimum-charge exposure for small/light shipments."
    - name: "avg_oversized_surcharge"
      expr: AVG(CAST(oversized_package_surcharge AS DOUBLE))
      comment: "Average oversized package surcharge. Quantifies cost penalty for non-standard package sizes and informs packaging guidelines."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level fulfillment KPIs covering fill rates, substitution rates, and unit economics. Drives inventory availability, pick accuracy, and order quality decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the fulfillment line (allocated, picked, packed, shipped, cancelled) for pipeline funnel analysis."
    - name: "fulfillment_source_type"
      expr: fulfillment_source_type
      comment: "Source of fulfillment (DC, store, drop-ship, vendor) to analyze fill rate and cost by sourcing channel."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether a substitute SKU was used, for substitution rate tracking and customer satisfaction impact analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity normalization across different product types."
    - name: "pick_timestamp_day"
      expr: DATE_TRUNC('DAY', pick_timestamp)
      comment: "Calendar day of pick completion for daily pick throughput trending."
    - name: "ship_timestamp_month"
      expr: DATE_TRUNC('MONTH', ship_timestamp)
      comment: "Calendar month of shipment for monthly fill rate and unit economics reporting."
  measures:
    - name: "total_fulfillment_lines"
      expr: COUNT(1)
      comment: "Total fulfillment lines processed. Baseline throughput KPI for pick/pack capacity planning."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all fulfillment lines. Demand volume baseline for fill rate calculation."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units successfully picked. Measures pick throughput and availability against ordered demand."
    - name: "total_quantity_packed"
      expr: SUM(CAST(quantity_packed AS DOUBLE))
      comment: "Total units packed and ready for shipment. Measures pack throughput and identifies pick-to-pack drop-off."
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total units shipped to customers. Core fulfillment output volume KPI."
    - name: "total_quantity_cancelled"
      expr: SUM(CAST(quantity_cancelled AS DOUBLE))
      comment: "Total units cancelled at the line level. Elevated cancellations signal inventory availability or sourcing failures."
    - name: "total_quantity_allocated"
      expr: SUM(CAST(quantity_allocated AS DOUBLE))
      comment: "Total units allocated to fulfillment. Measures inventory reservation effectiveness and allocation accuracy."
    - name: "line_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_shipped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units successfully shipped. Core order quality KPI directly linked to customer satisfaction and revenue realization."
    - name: "substitution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillment lines fulfilled with a substitute SKU. High rates indicate inventory gaps and risk customer dissatisfaction."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of fulfilled lines. Drives COGS reporting and margin analysis at the fulfillment level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across fulfilled lines. Benchmarks sourcing cost efficiency and informs pricing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick task KPIs for warehouse labor efficiency, pick accuracy, and substitution management. Drives staffing, zone layout, and WMS configuration decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (assigned, in-progress, completed, exception) for workflow pipeline analysis."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (single-order, batch, zone, cluster) to analyze efficiency by picking methodology."
    - name: "task_method"
      expr: task_method
      comment: "Pick method (manual, voice-directed, scan-to-pick, automated) for labor efficiency benchmarking."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel (ship-to-home, BOPIS, curbside) to segment pick performance by customer-facing service type."
    - name: "priority_level"
      expr: priority_level
      comment: "Pick task priority (standard, expedited, same-day) for SLA compliance analysis by urgency tier."
    - name: "substitution_occurred"
      expr: substitution_occurred
      comment: "Whether a substitution was made during picking, for substitution rate and inventory gap analysis."
    - name: "work_zone"
      expr: work_zone
      comment: "Warehouse zone where the pick occurred, for zone-level throughput and congestion analysis."
    - name: "completion_timestamp_day"
      expr: DATE_TRUNC('DAY', completion_timestamp)
      comment: "Calendar day of pick task completion for daily throughput trending."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total pick tasks executed. Baseline labor throughput KPI for warehouse staffing and capacity planning."
    - name: "total_units_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units picked across all tasks. Core warehouse throughput KPI for productivity benchmarking."
    - name: "total_units_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total units requested for picking. Denominator for pick accuracy and fill rate calculations."
    - name: "pick_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_picked AS DOUBLE)) / NULLIF(SUM(CAST(quantity_requested AS DOUBLE)), 0), 2)
      comment: "Percentage of requested units successfully picked. Core warehouse quality KPI; low accuracy drives customer complaints and re-fulfillment costs."
    - name: "substitution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks where a substitution was made. Signals inventory availability gaps and impacts customer satisfaction."
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pick_task_status = 'exception' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks resulting in an exception. Drives root-cause analysis for inventory, system, or process failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack task KPIs for packing throughput, quality, and cost. Drives packing station staffing, packaging material procurement, and quality control decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`pack_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pack task (assigned, in-progress, completed, exception) for workflow pipeline analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type used (box, poly-bag, envelope) to analyze packaging material consumption and cost by type."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment channel (ship-to-home, BOPIS, drop-ship) for packing efficiency segmentation by channel."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Outcome of quality check (passed, failed, skipped) for packing quality rate analysis."
    - name: "gift_wrap_flag"
      expr: gift_wrap_flag
      comment: "Whether gift wrapping was applied, to track gift-service volume and associated labor cost."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the pack task involved hazardous materials, for compliance cost segmentation."
    - name: "packing_station_code"
      expr: packing_station_code
      comment: "Packing station identifier for station-level throughput and utilization analysis."
    - name: "completed_timestamp_day"
      expr: DATE_TRUNC('DAY', completed_timestamp)
      comment: "Calendar day of pack task completion for daily throughput trending."
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total pack tasks completed. Baseline packing throughput KPI for station capacity and staffing planning."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across packed shipments. Drives insurance premium budgeting and risk exposure management."
    - name: "avg_insurance_value_per_task"
      expr: AVG(CAST(insurance_value_amount AS DOUBLE))
      comment: "Average insurance value per pack task. Benchmarks insurance cost per shipment and informs coverage tier decisions."
    - name: "total_package_weight_kg"
      expr: SUM(CAST(package_weight_kg AS DOUBLE))
      comment: "Total weight of all packed packages. Used for carrier billing reconciliation and dimensional-weight analysis."
    - name: "avg_package_weight_kg"
      expr: AVG(CAST(package_weight_kg AS DOUBLE))
      comment: "Average packed package weight. Informs packaging standardization and carrier weight-break tier optimization."
    - name: "quality_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_status = 'passed' THEN 1 END) / NULLIF(COUNT(CASE WHEN quality_check_status != 'skipped' THEN 1 END), 0), 2)
      comment: "Percentage of quality-checked pack tasks that passed. Core packing quality KPI; failures drive re-pack costs and customer complaints."
    - name: "gift_wrap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gift_wrap_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pack tasks requiring gift wrapping. Drives gift-service staffing and material procurement during peak seasons."
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'exception' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pack tasks resulting in an exception. Elevated rates signal packaging supply, system, or process failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery route KPIs for last-mile efficiency, cost, and utilization. Drives route optimization, fleet management, and delivery capacity planning decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`delivery_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the delivery route (planned, dispatched, in-progress, completed, cancelled) for operational pipeline visibility."
    - name: "route_type"
      expr: route_type
      comment: "Route type (scheduled, on-demand, same-day) for cost and efficiency segmentation by delivery model."
    - name: "route_zone"
      expr: route_zone
      comment: "Geographic delivery zone for zone-level efficiency and cost analysis."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Vehicle type used (van, truck, bike, car) for fleet utilization and cost-per-stop analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the route required temperature-controlled transport, for cold-chain cost segmentation."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the route carried hazardous materials, for compliance cost and routing constraint analysis."
    - name: "route_date_week"
      expr: DATE_TRUNC('WEEK', route_date)
      comment: "ISO week of the delivery route for weekly volume and efficiency trending."
    - name: "route_date_month"
      expr: DATE_TRUNC('MONTH', route_date)
      comment: "Calendar month of the delivery route for monthly fleet utilization and cost reporting."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total delivery routes executed. Baseline fleet utilization KPI for capacity and cost planning."
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total kilometers driven across all routes. Primary driver of fuel cost and vehicle maintenance expense."
    - name: "avg_distance_per_route_km"
      expr: AVG(CAST(actual_distance_km AS DOUBLE))
      comment: "Average distance per delivery route. Benchmarks route efficiency and identifies optimization opportunities."
    - name: "total_weight_delivered_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight delivered across all routes. Measures fleet payload utilization and informs vehicle capacity planning."
    - name: "total_volume_delivered_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total cubic volume delivered. Measures volumetric load utilization and identifies under-loaded routes."
    - name: "avg_weight_per_route_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average payload weight per route. Benchmarks vehicle load efficiency and identifies under-utilized capacity."
    - name: "route_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN route_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of planned routes that were cancelled. Elevated rates signal capacity, driver, or vehicle availability failures."
    - name: "distinct_fulfillment_nodes_served"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes originating routes. Measures network breadth and node-level delivery activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_bopis_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOPIS (Buy Online, Pick Up In Store) appointment KPIs for pickup SLA compliance, customer wait time, and appointment conversion. Drives store staffing, pickup bay capacity, and customer experience decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`bopis_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the BOPIS appointment (scheduled, ready, picked-up, expired, cancelled) for funnel analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of pickup appointment (standard BOPIS, curbside, locker) for channel-level performance segmentation."
    - name: "check_in_method"
      expr: check_in_method
      comment: "How the customer checked in (app, SMS, in-store kiosk) to analyze digital vs. physical check-in adoption."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the ready-for-pickup SLA was met, for SLA compliance rate analysis."
    - name: "ready_notification_sent_flag"
      expr: ready_notification_sent_flag
      comment: "Whether the customer was notified when order was ready, for notification compliance tracking."
    - name: "scheduled_date_week"
      expr: DATE_TRUNC('WEEK', scheduled_date)
      comment: "ISO week of scheduled pickup for weekly BOPIS volume and staffing planning."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Calendar month of scheduled pickup for monthly BOPIS performance reporting."
  measures:
    - name: "total_bopis_appointments"
      expr: COUNT(1)
      comment: "Total BOPIS appointments scheduled. Baseline volume KPI for store pickup capacity and staffing planning."
    - name: "completed_pickups"
      expr: COUNT(CASE WHEN appointment_status = 'picked-up' THEN 1 END)
      comment: "Number of BOPIS appointments successfully completed. Measures actual pickup conversion from scheduled appointments."
    - name: "pickup_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'picked-up' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled BOPIS appointments that resulted in a completed pickup. Core BOPIS conversion KPI."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN sla_met_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of BOPIS orders made ready within the SLA target window. Core customer promise fulfillment KPI for BOPIS."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOPIS appointments cancelled. High rates signal inventory availability issues or customer experience friction."
    - name: "expiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOPIS appointments that expired without pickup. Drives inventory re-stocking decisions and hold-period policy review."
    - name: "notification_sent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ready_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ready orders where customer notification was sent. Measures notification process compliance and customer communication quality."
    - name: "distinct_pickup_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations handling BOPIS appointments. Measures BOPIS network coverage and location-level activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment exception KPIs for root-cause analysis, financial impact, and resolution performance. Drives process improvement, carrier accountability, and customer service escalation decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Category of exception (lost package, damage, delay, mis-pick, address error) for root-cause segmentation."
    - name: "exception_status"
      expr: exception_status
      comment: "Current resolution status of the exception (open, in-progress, resolved, escalated) for pipeline management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic issue identification and process improvement prioritization."
    - name: "detected_at_stage"
      expr: detected_at_stage
      comment: "Fulfillment stage where the exception was detected (pick, pack, ship, delivery) for process failure localization."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the exception for severity-weighted analysis and management reporting."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the exception caused an SLA breach, for SLA impact quantification."
    - name: "owner_type"
      expr: owner_type
      comment: "Responsible party for the exception (carrier, warehouse, vendor, system) for accountability attribution."
    - name: "exception_timestamp_month"
      expr: DATE_TRUNC('MONTH', exception_timestamp)
      comment: "Calendar month the exception occurred for monthly trend and seasonality analysis."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total fulfillment exceptions raised. Baseline quality KPI; rising exception counts signal systemic process or carrier failures."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of fulfillment exceptions. Quantifies cost of quality failures for ROI analysis of process improvement investments."
    - name: "avg_financial_impact_per_exception"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception. Prioritizes exception types by cost severity for remediation investment decisions."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total units affected by fulfillment exceptions. Measures exception scope and customer impact breadth."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions that caused an SLA breach. Core customer promise reliability KPI; high rates trigger carrier and process reviews."
    - name: "customer_notified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions where the customer was proactively notified. Measures customer communication compliance and experience quality."
    - name: "open_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'open' THEN 1 END)
      comment: "Number of currently open unresolved exceptions. Operational backlog KPI for exception management team capacity planning."
    - name: "distinct_nodes_with_exceptions"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes generating exceptions. Identifies high-exception nodes for targeted process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA definition KPIs for coverage analysis, promised delivery windows, and breach threshold management. Drives SLA policy design, carrier selection, and customer promise calibration."
  source: "`vibe_retail_v1`.`fulfillment`.`sla`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (ready-to-ship, ship-to-deliver, order-to-deliver) for coverage and performance segmentation."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment channel the SLA applies to (ship-to-home, BOPIS, same-day) for channel-level promise analysis."
    - name: "order_channel"
      expr: order_channel
      comment: "Order origination channel (web, mobile, store, marketplace) for channel-specific SLA policy analysis."
    - name: "node_type"
      expr: node_type
      comment: "Fulfillment node type (DC, store, vendor) the SLA applies to, for node-type performance benchmarking."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier the SLA applies to, for premium-tier promise differentiation analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the SLA definition is currently active, for active vs. expired policy coverage analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country the SLA applies to for geographic promise coverage analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the SLA became effective for policy change trend analysis."
  measures:
    - name: "total_sla_definitions"
      expr: COUNT(1)
      comment: "Total SLA definitions in the system. Measures policy complexity and coverage breadth across channels and node types."
    - name: "active_sla_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active SLA definitions. Ensures adequate SLA coverage across all fulfillment scenarios."
    - name: "avg_promised_hours_to_deliver"
      expr: AVG(CAST(promised_hours_to_deliver AS DOUBLE))
      comment: "Average promised delivery window in hours across SLA definitions. Benchmarks customer promise competitiveness against industry standards."
    - name: "avg_promised_hours_to_ship"
      expr: AVG(CAST(promised_hours_to_ship AS DOUBLE))
      comment: "Average promised ship window in hours. Measures operational commitment tightness and informs node capacity requirements."
    - name: "avg_promised_hours_to_ready"
      expr: AVG(CAST(promised_hours_to_ready AS DOUBLE))
      comment: "Average promised ready-for-pickup window in hours. Core BOPIS and curbside customer promise KPI."
    - name: "avg_breach_threshold_hours"
      expr: AVG(CAST(breach_threshold_hours AS DOUBLE))
      comment: "Average breach threshold in hours across SLA definitions. Calibrates how aggressively SLA violations are flagged for escalation."
    - name: "avg_order_value_min"
      expr: AVG(CAST(order_value_min AS DOUBLE))
      comment: "Average minimum order value threshold across SLAs. Informs free-shipping and premium-service eligibility policy design."
    - name: "avg_order_value_max"
      expr: AVG(CAST(order_value_max AS DOUBLE))
      comment: "Average maximum order value threshold across SLAs. Ensures high-value order SLA coverage is appropriately differentiated."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof-of-delivery KPIs for delivery confirmation quality, dispute rates, and temperature compliance. Drives carrier accountability, dispute resolution, and cold-chain compliance decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`proof_of_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Final delivery outcome (delivered, failed, returned, exception) for delivery success rate analysis."
    - name: "pod_capture_method"
      expr: pod_capture_method
      comment: "Method used to capture proof of delivery (signature, photo, PIN, contactless) for capture quality analysis."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery location (residential, commercial, locker, neighbor) for location-type success rate analysis."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the delivery met the promised SLA window, for on-time delivery rate analysis."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether temperature requirements were met at delivery, for cold-chain compliance rate analysis."
    - name: "dispute_filed_flag"
      expr: dispute_filed_flag
      comment: "Whether a delivery dispute was filed, for dispute rate trending and carrier accountability."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Calendar month of delivery for monthly on-time and quality trend reporting."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total delivery events with proof of delivery records. Baseline delivery volume KPI."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN sla_met_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliveries meeting the promised SLA window. Core customer experience and carrier performance KPI."
    - name: "signature_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_captured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with a captured signature. Measures POD quality and liability protection compliance."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries resulting in a customer dispute. High rates signal delivery quality failures and drive carrier accountability reviews."
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN temperature_compliant_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of temperature-sensitive deliveries meeting cold-chain requirements. Critical food safety and product quality KPI."
    - name: "avg_temperature_at_delivery_celsius"
      expr: AVG(CAST(temperature_at_delivery_celsius AS DOUBLE))
      comment: "Average recorded temperature at delivery for cold-chain shipments. Monitors cold-chain integrity and regulatory compliance."
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy of delivery location capture. Measures POD location data quality for dispute resolution and route optimization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_drop_ship_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drop-ship order KPIs for vendor fulfillment performance, SLA compliance, and delivery accuracy. Drives vendor accountability, drop-ship program management, and customer promise decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`drop_ship_order`"
  dimensions:
    - name: "drop_ship_status"
      expr: drop_ship_status
      comment: "Current status of the drop-ship order (sent, acknowledged, shipped, delivered, cancelled, exception) for pipeline analysis."
    - name: "vendor_sla_compliance_flag"
      expr: vendor_sla_compliance_flag
      comment: "Whether the vendor met the agreed ship SLA, for vendor scorecard and accountability analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cost analysis."
    - name: "promised_ship_date_month"
      expr: DATE_TRUNC('MONTH', promised_ship_date)
      comment: "Month of promised ship date for monthly vendor performance trending."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month of actual ship date for monthly fulfillment volume reporting."
  measures:
    - name: "total_drop_ship_orders"
      expr: COUNT(1)
      comment: "Total drop-ship orders placed. Baseline volume KPI for drop-ship program scale and vendor dependency analysis."
    - name: "vendor_sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vendor_sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN vendor_sla_compliance_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of drop-ship orders where the vendor met the agreed ship SLA. Core vendor scorecard KPI for drop-ship program management."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drop_ship_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drop-ship orders cancelled. High rates signal vendor inventory availability issues or program reliability problems."
    - name: "vendor_acknowledgement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vendor_acknowledged_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drop-ship orders acknowledged by the vendor. Measures vendor EDI/portal responsiveness and order visibility."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors fulfilling drop-ship orders. Measures drop-ship network breadth and single-vendor concentration risk."
    - name: "exception_order_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Number of drop-ship orders with exceptions. Drives vendor performance reviews and exception root-cause analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_carrier_facility_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier-facility contract KPIs for rate optimization, SLA performance, and contract coverage. Drives facility-level carrier negotiation and contract renewal decisions."
  source: "`vibe_retail_v1`.`fulfillment`.`carrier_facility_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the carrier-facility contract (active, expired, pending) for contract portfolio management."
    - name: "rate_tier"
      expr: rate_tier
      comment: "Rate tier assigned to the facility contract for cost tier segmentation and negotiation benchmarking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for contract lifecycle trend analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of contract expiry to proactively identify renewal windows."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total carrier-facility contracts. Measures contract portfolio breadth and carrier coverage per facility."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of currently active carrier-facility contracts. Ensures adequate carrier coverage for each fulfillment facility."
    - name: "avg_facility_discount_percentage"
      expr: AVG(CAST(facility_discount_percentage AS DOUBLE))
      comment: "Average facility-specific discount percentage across contracts. Measures procurement effectiveness in facility-level carrier negotiations."
    - name: "avg_facility_base_rate"
      expr: AVG(CAST(facility_specific_base_rate AS DOUBLE))
      comment: "Average base rate negotiated at the facility level. Benchmarks facility cost competitiveness across the carrier network."
    - name: "avg_sla_on_time_percentage"
      expr: AVG(CAST(sla_on_time_percentage AS DOUBLE))
      comment: "Average contracted on-time SLA percentage across carrier-facility agreements. Baseline for carrier performance accountability."
    - name: "distinct_facilities_covered"
      expr: COUNT(DISTINCT dc_facility_id)
      comment: "Number of distinct DC facilities with active carrier contracts. Measures carrier network coverage across the distribution footprint."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment node capacity and capability metrics tracking operational readiness, service offerings, automation levels, and geographic coverage"
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_node`"
  dimensions:
    - name: "node_status"
      expr: node_status
      comment: "Current operational status of the fulfillment node (active, inactive, seasonal, under-construction)"
    - name: "node_type"
      expr: node_type
      comment: "Type of fulfillment node (DC, micro-fulfillment-center, store, dark-store, cross-dock)"
    - name: "node_name"
      expr: node_name
      comment: "Name of the fulfillment node"
    - name: "node_code"
      expr: node_code
      comment: "Standardized code for the fulfillment node"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation at the node (manual, semi-automated, fully-automated)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the node is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province where the node is located"
    - name: "city"
      expr: city
      comment: "City where the node is located"
    - name: "bopis_enabled"
      expr: bopis_enabled
      comment: "Whether the node supports BOPIS fulfillment"
    - name: "curbside_pickup_enabled"
      expr: curbside_pickup_enabled
      comment: "Whether the node supports curbside pickup"
    - name: "ropis_enabled"
      expr: ropis_enabled
      comment: "Whether the node supports reserve-online-pickup-in-store"
    - name: "ship_from_store_enabled"
      expr: ship_from_store_enabled
      comment: "Whether the node supports ship-from-store fulfillment"
    - name: "same_day_delivery_enabled"
      expr: same_day_delivery_enabled
      comment: "Whether the node supports same-day delivery"
    - name: "next_day_delivery_enabled"
      expr: next_day_delivery_enabled
      comment: "Whether the node supports next-day delivery"
    - name: "refrigerated_storage_enabled"
      expr: refrigerated_storage_enabled
      comment: "Whether the node has refrigerated storage capability"
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Whether the node is certified for hazardous materials"
  measures:
    - name: "total_fulfillment_nodes"
      expr: COUNT(1)
      comment: "Total number of fulfillment nodes in the network"
    - name: "avg_delivery_zone_radius_miles"
      expr: AVG(CAST(delivery_zone_coverage_radius_miles AS DOUBLE))
      comment: "Average delivery zone coverage radius in miles across nodes"
$$;