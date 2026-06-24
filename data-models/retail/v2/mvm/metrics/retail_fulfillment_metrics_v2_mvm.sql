-- Metric views for domain: fulfillment | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fulfillment order execution: throughput, SLA adherence, shipping cost efficiency, and fulfillment method mix. Used by VP of Operations and Supply Chain leadership to steer fulfillment capacity, carrier spend, and service-level performance."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment channel (e.g. SHIP, BOPIS, CURBSIDE, DROP_SHIP) — primary dimension for method-mix analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current lifecycle status of the fulfillment order (e.g. PENDING, PICKING, PACKED, SHIPPED, COMPLETED, CANCELLED)."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority tier (e.g. STANDARD, EXPEDITED, RUSH) — used to segment SLA performance by urgency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which shipping costs are denominated — required for multi-currency cost analysis."
    - name: "is_gift"
      expr: is_gift
      comment: "Boolean flag indicating whether the order is a gift — used to track gift fulfillment volume and special-handling load."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Order creation date truncated to day — primary time grain for daily throughput trending."
    - name: "order_date_week"
      expr: DATE_TRUNC('WEEK', order_date)
      comment: "Order creation date truncated to week — used for weekly operational reviews."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order creation date truncated to month — used for monthly executive reporting."
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Customer-facing promised delivery date — used to segment on-time vs. late fulfillment performance."
    - name: "fulfillment_node_id"
      expr: fulfillment_node_id
      comment: "Identifier of the fulfillment node (DC or store) that owns the order — used for node-level performance benchmarking."
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders. Baseline throughput KPI used to assess operational volume and capacity utilization."
    - name: "completed_fulfillment_orders"
      expr: COUNT(CASE WHEN fulfillment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of fulfillment orders that reached COMPLETED status. Measures actual output vs. demand intake."
    - name: "cancelled_fulfillment_orders"
      expr: COUNT(CASE WHEN fulfillment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled fulfillment orders. Elevated cancellation rates signal inventory, capacity, or demand-planning failures."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillment orders that were cancelled. A key quality and customer-satisfaction KPI; rising rates trigger operational investigation."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all fulfillment orders. Direct P&L line item monitored by Finance and Supply Chain leadership."
    - name: "avg_shipping_cost_per_order"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per fulfillment order. Used to benchmark carrier efficiency and detect cost drift by method or node."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms across all fulfillment orders. Drives carrier rate negotiations and capacity planning."
    - name: "avg_weight_kg_per_order"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight per fulfillment order. Used to detect product-mix shifts that affect carrier cost tiers."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume of all fulfillment orders. Used for truck-load planning, packaging optimization, and carrier dimensional-weight cost management."
    - name: "avg_actual_fulfillment_hours"
      expr: AVG(CAST(actual_fulfillment_hours AS DOUBLE))
      comment: "Average hours from order assignment to completion. Core operational efficiency KPI; directly tied to SLA compliance and customer satisfaction."
    - name: "fulfillment_orders_with_exceptions"
      expr: COUNT(CASE WHEN fulfillment_status NOT IN ('COMPLETED', 'CANCELLED', 'PENDING') AND actual_fulfillment_hours IS NOT NULL THEN 1 END)
      comment: "Proxy count of orders that experienced processing anomalies (non-terminal, non-pending states with recorded hours). Flags operational friction requiring intervention."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes processing orders in the period. Used to assess network utilization breadth."
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used across fulfillment orders. Monitors carrier diversification and single-carrier dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment performance KPIs covering delivery reliability, carrier cost, weight/volume efficiency, and on-time delivery rates. Used by VP of Logistics, Supply Chain, and Customer Experience leadership."
  source: "`vibe_retail_v1`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. CREATED, IN_TRANSIT, DELIVERED, EXCEPTION, RETURNED)."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method associated with the shipment (e.g. SHIP_FROM_DC, SHIP_FROM_STORE, DROP_SHIP)."
    - name: "ship_from_location_type"
      expr: ship_from_location_type
      comment: "Type of origin location (e.g. DC, STORE, VENDOR) — used to benchmark cost and speed by origin type."
    - name: "carrier_charge_currency_code"
      expr: carrier_charge_currency_code
      comment: "Currency of the carrier charge — required for multi-currency cost normalization."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Boolean flag indicating hazardous materials shipment — used to segment compliance and surcharge costs."
    - name: "delivery_signature_required_flag"
      expr: delivery_signature_required_flag
      comment: "Boolean flag indicating signature is required on delivery — used to track premium delivery service usage and associated costs."
    - name: "ship_date_day"
      expr: DATE_TRUNC('DAY', CAST(ship_date AS TIMESTAMP))
      comment: "Ship date truncated to day — primary time grain for daily shipment volume trending."
    - name: "ship_date_week"
      expr: DATE_TRUNC('WEEK', CAST(ship_date AS TIMESTAMP))
      comment: "Ship date truncated to week — used for weekly logistics reviews."
    - name: "ship_date_month"
      expr: DATE_TRUNC('MONTH', CAST(ship_date AS TIMESTAMP))
      comment: "Ship date truncated to month — used for monthly carrier performance reporting."
    - name: "fulfillment_node_id"
      expr: fulfillment_node_id
      comment: "Originating fulfillment node — used for node-level shipment throughput and cost benchmarking."
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier identifier — primary dimension for carrier performance and cost analysis."
    - name: "carrier_service_id"
      expr: carrier_service_id
      comment: "Carrier service level identifier — used to analyze cost and delivery performance by service tier."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments created. Baseline logistics throughput KPI."
    - name: "delivered_shipments"
      expr: COUNT(CASE WHEN shipment_status = 'DELIVERED' THEN 1 END)
      comment: "Count of shipments successfully delivered. Core fulfillment output metric."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date AND shipment_status = 'DELIVERED' THEN 1 END) / NULLIF(COUNT(CASE WHEN shipment_status = 'DELIVERED' THEN 1 END), 0), 2)
      comment: "Percentage of delivered shipments that arrived on or before the estimated delivery date. Premier customer-satisfaction and carrier-performance KPI tracked at every executive review."
    - name: "exception_shipments"
      expr: COUNT(CASE WHEN shipment_status = 'EXCEPTION' THEN 1 END)
      comment: "Count of shipments in exception status. Elevated exceptions signal carrier reliability issues or operational failures requiring immediate intervention."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shipment_status = 'EXCEPTION' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments that encountered exceptions. Key carrier quality KPI used in carrier scorecard reviews."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all shipments. Direct logistics P&L line item."
    - name: "avg_shipping_cost_per_shipment"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per shipment. Used to benchmark carrier efficiency and detect cost inflation by carrier or service level."
    - name: "total_carrier_charge"
      expr: SUM(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Total amount charged by carriers across all shipments. Used to reconcile carrier invoices against contracted rates."
    - name: "avg_carrier_charge_per_shipment"
      expr: AVG(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Average carrier charge per shipment. Benchmarks actual carrier billing against negotiated rates."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms. Used for carrier rate tier analysis and logistics capacity planning."
    - name: "avg_weight_kg_per_shipment"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight. Detects product-mix or packaging changes that affect carrier cost tiers."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Used for dimensional-weight cost analysis and truck-load optimization."
    - name: "avg_days_to_deliver"
      expr: AVG(DATEDIFF(actual_delivery_date, ship_date))
      comment: "Average calendar days from ship date to actual delivery. Measures end-to-end transit speed; directly tied to customer satisfaction and SLA compliance."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used in the period. Monitors carrier diversification and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level fulfillment execution KPIs covering pick/pack/ship throughput, fill rates, substitution rates, and unit cost efficiency. Used by Operations Managers and Supply Chain VPs to manage warehouse execution quality."
  source: "`vibe_retail_v1`.`fulfillment`.`fulfillment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the fulfillment line (e.g. ALLOCATED, PICKED, PACKED, SHIPPED, CANCELLED, EXCEPTION)."
    - name: "fulfillment_source_type"
      expr: fulfillment_source_type
      comment: "Source type for the fulfillment line (e.g. DC, STORE, VENDOR) — used to benchmark execution performance by origin."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Boolean flag indicating the line was fulfilled with a substitute SKU — used to track substitution volume and customer impact."
    - name: "substitution_reason_code"
      expr: substitution_reason_code
      comment: "Reason code for SKU substitution (e.g. OUT_OF_STOCK, DAMAGED) — used to diagnose root causes of substitution events."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line quantity — required for accurate volume aggregation across mixed UOM lines."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded on the fulfillment line — used to categorize and prioritize operational exceptions."
    - name: "pick_timestamp_day"
      expr: DATE_TRUNC('DAY', pick_timestamp)
      comment: "Pick event date truncated to day — used for daily pick throughput trending."
    - name: "pack_timestamp_day"
      expr: DATE_TRUNC('DAY', pack_timestamp)
      comment: "Pack event date truncated to day — used for daily pack throughput trending."
    - name: "ship_timestamp_day"
      expr: DATE_TRUNC('DAY', ship_timestamp)
      comment: "Ship event date truncated to day — used for daily ship throughput trending."
    - name: "fulfillment_node_id"
      expr: fulfillment_node_id
      comment: "Fulfillment node processing the line — used for node-level execution benchmarking."
  measures:
    - name: "total_fulfillment_lines"
      expr: COUNT(1)
      comment: "Total number of fulfillment lines. Baseline execution volume KPI."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all fulfillment lines. Demand baseline for fill-rate calculation."
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total units actually shipped. Core output metric for fulfillment execution."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_shipped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units that were shipped. Premier fulfillment quality KPI; directly tied to revenue realization and customer satisfaction. Monitored at every operational review."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units picked. Used to measure pick throughput and compare against ordered quantity to detect pick shortfalls."
    - name: "total_quantity_packed"
      expr: SUM(CAST(quantity_packed AS DOUBLE))
      comment: "Total units packed. Used to measure pack throughput and identify bottlenecks between pick and ship stages."
    - name: "total_quantity_cancelled"
      expr: SUM(CAST(quantity_cancelled AS DOUBLE))
      comment: "Total units cancelled at the line level. Elevated cancellations signal inventory availability or supplier reliability failures."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_cancelled AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units that were cancelled. Tracks inventory and fulfillment reliability; rising rates trigger supply chain investigation."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillment lines fulfilled with a substitute SKU. High substitution rates indicate chronic inventory gaps and risk customer dissatisfaction."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all fulfillment lines. Used for COGS tracking and margin analysis at the fulfillment level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across fulfillment lines. Used to monitor cost-of-goods trends and detect pricing anomalies."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight AS DOUBLE))
      comment: "Total weight of all fulfillment lines. Used for carrier rate optimization and packaging cost analysis."
    - name: "lines_with_exceptions"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 END)
      comment: "Count of fulfillment lines with recorded exception codes. Measures operational quality; high exception counts drive process improvement initiatives."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillment lines that encountered exceptions. Key warehouse execution quality KPI used in operational steering meetings."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_bopis_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy-Online-Pick-Up-In-Store (BOPIS) appointment performance KPIs covering SLA compliance, wait times, readiness speed, and cancellation rates. Used by Store Operations VPs and Customer Experience leadership to optimize curbside and in-store pickup service levels."
  source: "`vibe_retail_v1`.`fulfillment`.`bopis_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the BOPIS appointment (e.g. SCHEDULED, READY, COMPLETED, CANCELLED, EXPIRED)."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of pickup appointment (e.g. BOPIS, CURBSIDE, LOCKER) — used to segment performance by pickup channel."
    - name: "check_in_method"
      expr: check_in_method
      comment: "Method used by customer to check in (e.g. APP, SMS, IN_STORE) — used to analyze digital vs. physical check-in adoption."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Boolean flag indicating whether the order was ready within the SLA target time — primary SLA compliance dimension."
    - name: "ready_notification_sent_flag"
      expr: ready_notification_sent_flag
      comment: "Boolean flag indicating whether the ready notification was sent to the customer — used to track notification compliance."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for appointment cancellation — used to diagnose root causes of BOPIS cancellations."
    - name: "scheduled_date_day"
      expr: DATE_TRUNC('DAY', CAST(scheduled_date AS TIMESTAMP))
      comment: "Scheduled pickup date truncated to day — primary time grain for daily BOPIS volume trending."
    - name: "scheduled_date_week"
      expr: DATE_TRUNC('WEEK', CAST(scheduled_date AS TIMESTAMP))
      comment: "Scheduled pickup date truncated to week — used for weekly store operations reviews."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_date AS TIMESTAMP))
      comment: "Scheduled pickup date truncated to month — used for monthly BOPIS performance reporting."
    - name: "location_id"
      expr: location_id
      comment: "Store location identifier — used for store-level BOPIS performance benchmarking."
    - name: "fulfillment_node_id"
      expr: fulfillment_node_id
      comment: "Fulfillment node handling the BOPIS appointment — used for node-level readiness and SLA analysis."
  measures:
    - name: "total_bopis_appointments"
      expr: COUNT(1)
      comment: "Total BOPIS appointments scheduled. Baseline volume KPI for BOPIS channel demand."
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'COMPLETED' THEN 1 END)
      comment: "Count of BOPIS appointments successfully completed (customer picked up order). Core BOPIS channel output metric."
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled BOPIS appointments. Elevated cancellations signal inventory, readiness, or customer experience failures."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOPIS appointments that were cancelled. Key customer experience KPI; rising rates trigger store operations investigation."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN appointment_status NOT IN ('CANCELLED', 'EXPIRED') THEN 1 END), 0), 2)
      comment: "Percentage of non-cancelled BOPIS appointments where the order was ready within the SLA target. Premier BOPIS service-level KPI tracked at every store operations review."
    - name: "notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ready_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN appointment_status NOT IN ('CANCELLED', 'EXPIRED') THEN 1 END), 0), 2)
      comment: "Percentage of eligible appointments where the ready notification was sent to the customer. Measures customer communication compliance; missed notifications drive customer wait time and dissatisfaction."
    - name: "expired_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'EXPIRED' THEN 1 END)
      comment: "Count of BOPIS appointments that expired without customer pickup. Measures unclaimed inventory risk and potential revenue loss."
    - name: "expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'EXPIRED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOPIS appointments that expired. High expiry rates indicate customer no-show patterns or notification failures, tying up store inventory."
    - name: "distinct_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations processing BOPIS appointments in the period. Used to assess BOPIS network coverage and adoption breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_drop_ship_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor drop-ship order performance KPIs covering vendor SLA compliance, shipment accuracy, and exception rates. Used by Vendor Management, Supply Chain VPs, and Merchandising leadership to manage vendor fulfillment quality and contract compliance."
  source: "`vibe_retail_v1`.`fulfillment`.`drop_ship_order`"
  dimensions:
    - name: "drop_ship_status"
      expr: drop_ship_status
      comment: "Current status of the drop-ship order (e.g. SENT, ACKNOWLEDGED, SHIPPED, DELIVERED, CANCELLED, EXCEPTION)."
    - name: "vendor_sla_compliance_flag"
      expr: vendor_sla_compliance_flag
      comment: "Boolean flag indicating whether the vendor shipped within the contracted SLA. Primary vendor performance dimension."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded on the drop-ship order — used to categorize vendor fulfillment failures."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the drop-ship order — required for multi-currency cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ordered and shipped quantities — required for accurate volume aggregation."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for drop-ship order cancellation — used to diagnose vendor reliability and inventory issues."
    - name: "actual_ship_date_day"
      expr: DATE_TRUNC('DAY', CAST(actual_ship_date AS TIMESTAMP))
      comment: "Actual vendor ship date truncated to day — used for daily drop-ship throughput trending."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_ship_date AS TIMESTAMP))
      comment: "Actual vendor ship date truncated to month — used for monthly vendor performance reporting."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary dimension for vendor-level drop-ship performance scorecarding."
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier used for the drop-ship order — used to analyze carrier performance within the drop-ship channel."
  measures:
    - name: "total_drop_ship_orders"
      expr: COUNT(1)
      comment: "Total drop-ship orders placed with vendors. Baseline volume KPI for the drop-ship fulfillment channel."
    - name: "vendor_sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vendor_sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN drop_ship_status NOT IN ('CANCELLED') THEN 1 END), 0), 2)
      comment: "Percentage of non-cancelled drop-ship orders where the vendor shipped within the contracted SLA. Premier vendor performance KPI used in vendor scorecards and contract reviews."
    - name: "cancelled_drop_ship_orders"
      expr: COUNT(CASE WHEN drop_ship_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled drop-ship orders. Elevated cancellations signal vendor inventory or reliability failures."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drop_ship_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drop-ship orders that were cancelled. Key vendor reliability KPI; rising rates trigger vendor performance reviews."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drop-ship orders with recorded exceptions. Measures vendor fulfillment quality; high rates drive vendor corrective action plans."
    - name: "avg_days_promised_to_actual_ship"
      expr: AVG(DATEDIFF(actual_ship_date, promised_ship_date))
      comment: "Average days between promised ship date and actual ship date. Negative values indicate early shipment; positive values indicate vendor lateness. Core vendor SLA performance metric."
    - name: "avg_days_ship_to_delivery"
      expr: AVG(DATEDIFF(actual_delivery_date, actual_ship_date))
      comment: "Average transit days from vendor ship date to customer delivery. Used to evaluate carrier performance within the drop-ship channel."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors fulfilling drop-ship orders in the period. Used to assess vendor network breadth and concentration risk."
    - name: "vendor_acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vendor_acknowledged_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drop-ship orders acknowledged by the vendor. Low acknowledgement rates signal vendor integration or communication failures that precede fulfillment delays."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse pick task efficiency KPIs covering pick throughput, task duration, substitution rates, and quality outcomes. Used by Warehouse Operations Managers and DC leadership to optimize labor productivity and picking accuracy."
  source: "`vibe_retail_v1`.`fulfillment`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (e.g. ASSIGNED, IN_PROGRESS, COMPLETED, EXCEPTION, CANCELLED)."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (e.g. SINGLE, BATCH, ZONE, CLUSTER) — used to benchmark productivity by picking methodology."
    - name: "task_method"
      expr: task_method
      comment: "Picking method used (e.g. MANUAL, AUTOMATED, VOICE_DIRECTED) — used to compare efficiency across picking technologies."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel the pick task serves (e.g. SHIP, BOPIS, CURBSIDE) — used to segment pick performance by channel."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pick task — used to ensure high-priority orders are picked within SLA."
    - name: "quality_check_outcome"
      expr: quality_check_outcome
      comment: "Outcome of the quality check performed on the pick task (e.g. PASS, FAIL, SKIPPED) — used to track picking accuracy."
    - name: "substitution_occurred"
      expr: substitution_occurred
      comment: "Boolean flag indicating a SKU substitution occurred during picking — used to track substitution volume and inventory gap signals."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded on the pick task — used to categorize and prioritize operational exceptions."
    - name: "start_timestamp_day"
      expr: DATE_TRUNC('DAY', start_timestamp)
      comment: "Pick task start date truncated to day — primary time grain for daily pick throughput trending."
    - name: "start_timestamp_week"
      expr: DATE_TRUNC('WEEK', start_timestamp)
      comment: "Pick task start date truncated to week — used for weekly warehouse productivity reviews."
    - name: "fulfillment_node_id"
      expr: fulfillment_node_id
      comment: "Fulfillment node where the pick task was executed — used for node-level productivity benchmarking."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total pick tasks created. Baseline warehouse labor demand KPI."
    - name: "completed_pick_tasks"
      expr: COUNT(CASE WHEN pick_task_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed pick tasks. Core warehouse throughput output metric."
    - name: "pick_task_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pick_task_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks completed successfully. Measures warehouse execution reliability; low rates signal labor, inventory, or system issues."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units picked across all pick tasks. Measures warehouse pick throughput in units."
    - name: "pick_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_picked AS DOUBLE)) / NULLIF(SUM(CAST(quantity_requested AS DOUBLE)), 0), 2)
      comment: "Percentage of requested units that were actually picked. Measures inventory availability at the pick face; low rates indicate slotting or replenishment failures."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks where a SKU substitution occurred. High substitution rates signal chronic inventory gaps and risk customer dissatisfaction."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_outcome = 'PASS' THEN 1 END) / NULLIF(COUNT(CASE WHEN quality_check_outcome IS NOT NULL AND quality_check_outcome <> 'SKIPPED' THEN 1 END), 0), 2)
      comment: "Percentage of quality-checked pick tasks that passed. Measures picking accuracy; low pass rates drive retraining and process improvement initiatives."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks with recorded exceptions. Key warehouse quality KPI used in operational steering meetings."
    - name: "distinct_active_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes with pick activity in the period. Used to assess warehouse network utilization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`fulfillment_shipment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package-level shipping KPIs covering billable weight efficiency, insurance coverage, delivery confirmation, and cost per package. Used by Logistics and Finance leadership to optimize packaging costs, carrier billing accuracy, and last-mile delivery quality."
  source: "`vibe_retail_v1`.`fulfillment`.`shipment_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the shipment package (e.g. PACKED, LABELED, MANIFESTED, IN_TRANSIT, DELIVERED, EXCEPTION)."
    - name: "package_type"
      expr: package_type
      comment: "Type of package (e.g. BOX, POLY_MAILER, ENVELOPE, PALLET) — used to analyze packaging cost and dimensional weight by type."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method applied to the package (e.g. GROUND, 2DAY, OVERNIGHT) — used to segment cost and delivery performance by service level."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Boolean flag indicating hazardous materials package — used to segment compliance costs and carrier surcharges."
    - name: "is_insured"
      expr: is_insured
      comment: "Boolean flag indicating the package carries declared insurance — used to track insurance coverage rates and associated costs."
    - name: "is_signature_required"
      expr: is_signature_required
      comment: "Boolean flag indicating signature is required on delivery — used to track premium delivery service usage."
    - name: "delivery_confirmation_method"
      expr: delivery_confirmation_method
      comment: "Method used to confirm delivery (e.g. SIGNATURE, PHOTO, NONE) — used to analyze delivery confirmation compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the shipping cost — required for multi-currency cost normalization."
    - name: "packed_timestamp_day"
      expr: DATE_TRUNC('DAY', packed_timestamp)
      comment: "Package packed date truncated to day — primary time grain for daily package volume trending."
    - name: "packed_timestamp_month"
      expr: DATE_TRUNC('MONTH', packed_timestamp)
      comment: "Package packed date truncated to month — used for monthly packaging cost reporting."
    - name: "fulfillment_node_id"
      expr: fulfillment_node_id
      comment: "Fulfillment node that packed the package — used for node-level packaging cost and efficiency benchmarking."
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier assigned to the package — used for carrier-level cost and delivery performance analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of shipment packages. Baseline packaging volume KPI."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all packages. Direct logistics P&L line item monitored by Finance and Logistics leadership."
    - name: "avg_shipping_cost_per_package"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per package. Used to benchmark carrier billing efficiency and detect cost inflation by package type or carrier."
    - name: "total_billable_weight_kg"
      expr: SUM(CAST(billable_weight_kg AS DOUBLE))
      comment: "Total billable weight across all packages. Billable weight drives carrier charges; monitoring this vs. actual weight reveals dimensional-weight surcharge exposure."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total actual physical weight across all packages. Used alongside billable weight to quantify dimensional-weight surcharge impact."
    - name: "dimensional_weight_premium_kg"
      expr: SUM(CAST(billable_weight_kg AS DOUBLE) - CAST(weight_kg AS DOUBLE))
      comment: "Total excess billable weight over actual weight (dimensional weight premium) in kg. Quantifies the cost impact of dimensional-weight pricing; high values drive packaging optimization initiatives."
    - name: "avg_billable_weight_kg"
      expr: AVG(CAST(billable_weight_kg AS DOUBLE))
      comment: "Average billable weight per package. Used to benchmark packaging efficiency and carrier rate tier exposure."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across all packages. Used by Finance to assess insurance cost exposure and coverage adequacy."
    - name: "insured_package_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_insured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages carrying declared insurance. Used to monitor insurance coverage compliance for high-value shipments."
    - name: "manifested_package_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manifested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages that have been manifested with the carrier. Low manifestation rates indicate carrier handoff failures that delay shipment scanning and tracking."
    - name: "label_printed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_label_printed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with printed shipping labels. Low rates indicate packing station bottlenecks or label printing failures that delay shipment."
$$;