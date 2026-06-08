-- Metric views for domain: fulfillment | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fulfillment order execution: throughput, cost efficiency, SLA adherence, and fulfillment method mix. Used by VP of Operations and Supply Chain leadership to steer fulfillment capacity, carrier spend, and on-time performance."
  source: "`retail_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment channel (e.g. ship-to-home, BOPIS, curbside) — key dimension for channel-level performance analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current lifecycle status of the fulfillment order (e.g. pending, picking, shipped, delivered, cancelled)."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority tier (e.g. standard, expedited, same-day) — used to segment SLA performance by urgency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which shipping costs are denominated — required for multi-currency cost analysis."
    - name: "promised_delivery_date"
      expr: DATE_TRUNC('day', promised_delivery_date)
      comment: "Promised delivery date bucketed to day — enables on-time delivery trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Calendar month the fulfillment order was placed — primary time grain for trend reporting."
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether the order is a gift — used to segment gift vs. standard order fulfillment performance."
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders. Baseline volume KPI used to assess throughput and capacity utilization."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all fulfillment orders. Directly informs carrier spend management and cost-per-order benchmarking."
    - name: "avg_shipping_cost_per_order"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per fulfillment order. Key efficiency KPI — rising averages signal carrier rate or mix issues requiring negotiation or routing changes."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped across all fulfillment orders in kilograms. Used for carrier capacity planning and dimensional weight cost analysis."
    - name: "avg_fulfillment_hours"
      expr: AVG(CAST(actual_fulfillment_hours AS DOUBLE))
      comment: "Average actual hours from order creation to fulfillment completion. Core operational efficiency KPI — directly tied to customer satisfaction and SLA compliance."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Used for packaging optimization, carrier capacity planning, and dimensional weight surcharge management."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled fulfillment orders. A rising cancellation count signals inventory, capacity, or customer experience issues requiring immediate intervention."
    - name: "completed_order_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'COMPLETED' THEN 1 END)
      comment: "Number of successfully completed fulfillment orders. Numerator for fulfillment completion rate — used to assess operational throughput quality."
    - name: "gift_order_count"
      expr: COUNT(CASE WHEN is_gift = TRUE THEN 1 END)
      comment: "Number of gift fulfillment orders. Used for seasonal capacity planning and gift-wrapping resource allocation."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier and shipment execution KPIs covering shipping cost, delivery performance, weight/volume efficiency, and on-time delivery. Used by logistics leadership to manage carrier relationships, control freight spend, and monitor delivery SLA compliance."
  source: "`retail_ecm`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, exception, returned) — primary dimension for delivery performance segmentation."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment (e.g. ship-from-store, ship-from-DC, drop-ship) — used to benchmark cost and speed by fulfillment model."
    - name: "ship_from_location_type"
      expr: ship_from_location_type
      comment: "Origin node type (e.g. store, warehouse, vendor) — enables cost and performance comparison across origin types."
    - name: "carrier_charge_currency_code"
      expr: carrier_charge_currency_code
      comment: "Currency of carrier charges — required for accurate multi-currency freight cost reporting."
    - name: "ship_date_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Calendar month of ship date — primary time grain for shipment volume and cost trend analysis."
    - name: "estimated_delivery_date_day"
      expr: DATE_TRUNC('day', estimated_delivery_date)
      comment: "Estimated delivery date bucketed to day — used for delivery promise tracking and SLA window analysis."
    - name: "actual_delivery_date_day"
      expr: DATE_TRUNC('day', actual_delivery_date)
      comment: "Actual delivery date bucketed to day — used to compute on-time delivery rates against promised dates."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contains hazardous materials — used to segment compliance costs and carrier eligibility."
    - name: "delivery_signature_required_flag"
      expr: delivery_signature_required_flag
      comment: "Indicates whether a delivery signature was required — used to analyze signature surcharge impact on total shipping cost."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline throughput KPI for logistics capacity and carrier volume management."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost paid across all shipments. Primary freight spend KPI — directly informs carrier contract negotiations and cost reduction initiatives."
    - name: "avg_shipping_cost_per_shipment"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per shipment. Efficiency benchmark — deviations signal carrier mix shifts, surcharge increases, or routing inefficiencies."
    - name: "total_carrier_charge"
      expr: SUM(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Total amount charged by carriers across all shipments. Used to reconcile carrier invoices against contracted rates and identify billing discrepancies."
    - name: "avg_carrier_charge_per_shipment"
      expr: AVG(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Average carrier charge per shipment. Compared against contracted rates to detect rate compliance issues and surcharge creep."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Used for carrier capacity planning, weight-break rate optimization, and freight cost modeling."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Informs packaging consolidation opportunities and weight-break tier optimization."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume shipped. Used for dimensional weight analysis and carrier capacity utilization planning."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END)
      comment: "Number of shipments delivered on or before the estimated delivery date. Numerator for on-time delivery rate — core customer experience and SLA compliance KPI."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > estimated_delivery_date THEN 1 END)
      comment: "Number of shipments delivered after the estimated delivery date. Directly tied to customer satisfaction scores and SLA breach penalties."
    - name: "delivered_shipment_count"
      expr: COUNT(CASE WHEN shipment_status = 'DELIVERED' THEN 1 END)
      comment: "Number of shipments with confirmed delivery status. Used as denominator for delivery success rate and to track fulfillment completion."
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used. Tracks carrier diversification — concentration risk indicator for supply chain resilience planning."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level fulfillment execution KPIs covering pick/pack accuracy, substitution rates, quantity fulfillment rates, and unit economics. Used by operations managers and merchandising teams to identify SKU-level fulfillment gaps and substitution patterns."
  source: "`retail_ecm`.`fulfillment`.`fulfillment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the fulfillment line (e.g. allocated, picked, packed, shipped, cancelled) — primary dimension for line-level pipeline analysis."
    - name: "fulfillment_source_type"
      expr: fulfillment_source_type
      comment: "Source type for the fulfillment line (e.g. store, DC, vendor direct) — used to benchmark fulfillment accuracy and speed by origin."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether the line item was fulfilled with a substitute SKU — key dimension for substitution rate analysis and customer satisfaction impact."
    - name: "substitution_reason_code"
      expr: substitution_reason_code
      comment: "Reason code for SKU substitution (e.g. out-of-stock, damaged) — used to identify root causes driving substitution rates."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item quantity — required for accurate quantity aggregation across mixed-UOM product lines."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded on the fulfillment line — used to identify systemic fulfillment failure patterns by exception type."
    - name: "pick_timestamp_date"
      expr: DATE_TRUNC('day', pick_timestamp)
      comment: "Date the line item was picked — used for daily pick throughput trend analysis."
    - name: "ship_timestamp_month"
      expr: DATE_TRUNC('month', ship_timestamp)
      comment: "Month the line item was shipped — primary time grain for shipped quantity and cost trend reporting."
  measures:
    - name: "total_fulfillment_lines"
      expr: COUNT(1)
      comment: "Total number of fulfillment lines. Baseline volume KPI for pick/pack workload planning and throughput measurement."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all fulfillment lines. Demand baseline used to compute fulfillment rate and identify shortfall."
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total units actually shipped. Numerator for line fill rate — directly measures fulfillment execution quality against customer demand."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units picked. Used to measure pick accuracy and identify gaps between picked and shipped quantities."
    - name: "total_quantity_packed"
      expr: SUM(CAST(quantity_packed AS DOUBLE))
      comment: "Total units packed. Used to identify pack-stage losses and measure pack throughput efficiency."
    - name: "total_quantity_cancelled"
      expr: SUM(CAST(quantity_cancelled AS DOUBLE))
      comment: "Total units cancelled at the line level. Rising cancellations signal inventory availability or allocation failures requiring supply chain intervention."
    - name: "total_quantity_allocated"
      expr: SUM(CAST(quantity_allocated AS DOUBLE))
      comment: "Total units allocated to fulfillment lines. Used to measure allocation efficiency and identify over/under-allocation patterns."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all fulfillment lines. Core COGS input for fulfillment profitability analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across fulfillment lines. Used to benchmark cost per unit by fulfillment source type and identify cost anomalies."
    - name: "substitution_line_count"
      expr: COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END)
      comment: "Number of fulfillment lines fulfilled with a substitute SKU. Numerator for substitution rate — high rates indicate inventory availability issues impacting customer experience."
    - name: "total_line_weight_kg"
      expr: SUM(CAST(weight AS DOUBLE))
      comment: "Total weight of all fulfillment line items in the declared weight unit. Used for shipment weight reconciliation and carrier cost attribution."
    - name: "lines_with_exceptions"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Number of fulfillment lines with recorded exceptions. Tracks operational quality — high exception rates signal process or system failures requiring root cause investigation."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking productivity and accuracy KPIs. Used by fulfillment center managers to optimize pick labor, reduce substitution rates, and improve pick accuracy — directly impacting order cycle time and customer satisfaction."
  source: "`retail_ecm`.`fulfillment`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (e.g. assigned, in-progress, completed, exception) — primary dimension for pick queue and throughput analysis."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel the pick task supports (e.g. e-commerce, BOPIS, ship-from-store) — used to benchmark pick performance by channel."
    - name: "task_method"
      expr: task_method
      comment: "Pick method used (e.g. single-order, batch, zone) — key dimension for labor efficiency analysis and method optimization."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (e.g. standard, substitution, replenishment) — used to segment workload and identify non-standard task volume."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pick task — used to ensure high-priority orders are being picked within SLA windows."
    - name: "quality_check_outcome"
      expr: quality_check_outcome
      comment: "Outcome of the quality check performed at pick (e.g. pass, fail, waived) — used to track pick accuracy and quality gate effectiveness."
    - name: "substitution_occurred"
      expr: substitution_occurred
      comment: "Indicates whether a SKU substitution occurred during picking — key dimension for substitution rate analysis."
    - name: "work_zone"
      expr: work_zone
      comment: "Warehouse work zone where the pick task was executed — used for zone-level productivity benchmarking and layout optimization."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pick task was created — used for daily pick volume trend analysis and workload forecasting."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks. Baseline workload volume KPI for labor planning and throughput benchmarking."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total units picked across all pick tasks. Core throughput KPI — used to measure picker productivity and fulfillment center output."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total units requested to be picked. Denominator for pick fill rate — used to identify shortfall between demand and actual pick execution."
    - name: "completed_pick_task_count"
      expr: COUNT(CASE WHEN pick_task_status = 'COMPLETED' THEN 1 END)
      comment: "Number of pick tasks completed successfully. Numerator for pick task completion rate — measures operational throughput quality."
    - name: "exception_pick_task_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Number of pick tasks with recorded exceptions. Tracks pick quality failures — high rates indicate inventory, system, or process issues requiring intervention."
    - name: "substitution_pick_count"
      expr: COUNT(CASE WHEN substitution_occurred = TRUE THEN 1 END)
      comment: "Number of pick tasks where a SKU substitution occurred. Numerator for pick substitution rate — directly tied to inventory availability and customer satisfaction."
    - name: "distinct_skus_picked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs picked. Used to measure pick breadth and identify SKU concentration in pick workload."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes executing pick tasks. Used to assess network-wide pick activity distribution."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack station productivity, quality, and cost KPIs. Used by fulfillment operations managers to optimize pack labor, reduce packaging costs, and ensure quality gate compliance before shipment."
  source: "`retail_ecm`.`fulfillment`.`pack_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pack task (e.g. assigned, in-progress, completed, voided) — primary dimension for pack queue and throughput analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type the pack task supports (e.g. ship-to-home, BOPIS, same-day) — used to benchmark pack performance by fulfillment channel."
    - name: "package_type"
      expr: package_type
      comment: "Type of package used (e.g. box, poly-bag, envelope) — key dimension for packaging cost analysis and material optimization."
    - name: "package_size"
      expr: package_size
      comment: "Size category of the package — used to analyze packaging mix and identify opportunities to right-size packaging for cost reduction."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Outcome of the quality check at pack station (e.g. pass, fail, skipped) — used to track pack accuracy and quality gate compliance."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the pack task — used to ensure high-priority orders are packed within SLA windows."
    - name: "gift_wrap_flag"
      expr: gift_wrap_flag
      comment: "Indicates whether gift wrapping was applied — used to measure gift service volume and associated labor cost."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the pack task involved hazardous materials — used to segment compliance-related pack tasks and associated costs."
    - name: "packing_station_code"
      expr: packing_station_code
      comment: "Identifier of the packing station — used for station-level productivity benchmarking and bottleneck identification."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pack task was created — used for daily pack volume trend analysis and workload forecasting."
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total number of pack tasks. Baseline workload volume KPI for pack labor planning and station capacity management."
    - name: "total_package_weight_kg"
      expr: SUM(CAST(package_weight_kg AS DOUBLE))
      comment: "Total weight of all packed packages in kilograms. Used for carrier cost attribution and weight-based shipping rate optimization."
    - name: "avg_package_weight_kg"
      expr: AVG(CAST(package_weight_kg AS DOUBLE))
      comment: "Average package weight in kilograms. Used to benchmark packaging efficiency and identify opportunities to reduce dimensional weight surcharges."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across all pack tasks. Used to manage insurance cost exposure and ensure adequate coverage for high-value shipments."
    - name: "completed_pack_task_count"
      expr: COUNT(CASE WHEN task_status = 'COMPLETED' THEN 1 END)
      comment: "Number of pack tasks completed successfully. Numerator for pack completion rate — measures pack station throughput quality."
    - name: "quality_fail_count"
      expr: COUNT(CASE WHEN quality_check_status = 'FAIL' THEN 1 END)
      comment: "Number of pack tasks that failed quality check. Directly tied to shipment accuracy and customer return rates — rising failures require immediate process intervention."
    - name: "gift_wrap_task_count"
      expr: COUNT(CASE WHEN gift_wrap_flag = TRUE THEN 1 END)
      comment: "Number of pack tasks requiring gift wrapping. Used for seasonal gift service capacity planning and labor cost allocation."
    - name: "hazmat_pack_task_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of pack tasks involving hazardous materials. Used to ensure compliance staffing levels and track hazmat handling volume."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes with active pack tasks. Used to assess network-wide pack activity distribution."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment exception management KPIs covering financial impact, resolution efficiency, SLA breach rates, and exception type distribution. Used by operations leadership to identify systemic failure patterns, prioritize corrective actions, and manage exception-related financial exposure."
  source: "`retail_ecm`.`fulfillment`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Category of exception (e.g. inventory shortage, carrier delay, damage, mispick) — primary dimension for root cause analysis and corrective action prioritization."
    - name: "exception_status"
      expr: exception_status
      comment: "Current resolution status of the exception (e.g. open, in-progress, resolved, escalated) — used to track exception backlog and resolution pipeline."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category assigned to the exception — used to identify systemic process failures and drive targeted corrective actions."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the exception — used to monitor escalation rates and ensure high-severity exceptions receive appropriate management attention."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the exception — used to ensure critical exceptions are resolved within SLA windows."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the exception caused an SLA breach — key dimension for SLA compliance reporting and penalty exposure analysis."
    - name: "detected_at_stage"
      expr: detected_at_stage
      comment: "Fulfillment stage where the exception was detected (e.g. pick, pack, ship, delivery) — used to identify which process stages generate the most exceptions."
    - name: "owner_type"
      expr: owner_type
      comment: "Type of owner responsible for resolving the exception (e.g. carrier, warehouse, vendor) — used for accountability tracking and SLA enforcement."
    - name: "exception_month"
      expr: DATE_TRUNC('month', exception_timestamp)
      comment: "Month the exception occurred — primary time grain for exception volume and financial impact trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact amount — required for accurate multi-currency exception cost reporting."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of fulfillment exceptions. Baseline quality KPI — rising exception counts signal systemic process or supplier failures requiring leadership attention."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all exceptions. Core cost-of-quality KPI — directly informs investment decisions in process improvement and carrier performance management."
    - name: "avg_financial_impact_per_exception"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception. Used to prioritize exception types by cost severity and allocate corrective action resources effectively."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total units affected by exceptions. Used to quantify the operational scale of exception impact beyond financial cost."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of exceptions that resulted in an SLA breach. Directly tied to customer satisfaction penalties and contractual compliance risk."
    - name: "open_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open (unresolved) exceptions. Operational backlog KPI — high open counts indicate resolution capacity constraints requiring staffing or process intervention."
    - name: "customer_notified_count"
      expr: COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END)
      comment: "Number of exceptions where the customer was proactively notified. Measures customer communication compliance — low rates relative to total exceptions signal a customer experience risk."
    - name: "distinct_exception_types"
      expr: COUNT(DISTINCT exception_type)
      comment: "Number of distinct exception types recorded. Used to assess exception diversity — a high count signals broad systemic issues vs. concentrated failure modes."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_shipment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package-level shipping cost, weight efficiency, and delivery confirmation KPIs. Used by logistics and packaging teams to optimize package dimensions, manage billable weight costs, and track delivery confirmation compliance."
  source: "`retail_ecm`.`fulfillment`.`shipment_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the shipment package (e.g. packed, labeled, manifested, in-transit, delivered) — primary dimension for package pipeline analysis."
    - name: "package_type"
      expr: package_type
      comment: "Type of package (e.g. box, poly-bag, envelope, pallet) — key dimension for packaging cost and dimensional weight analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the package (e.g. ground, 2-day, overnight) — used to benchmark cost and delivery performance by service level."
    - name: "delivery_confirmation_method"
      expr: delivery_confirmation_method
      comment: "Method used to confirm delivery (e.g. signature, photo, none) — used to analyze confirmation compliance and associated surcharge costs."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the package contains hazardous materials — used to segment compliance costs and carrier eligibility."
    - name: "is_insured"
      expr: is_insured
      comment: "Indicates whether the package is insured — used to track insurance coverage rates and associated cost exposure."
    - name: "is_signature_required"
      expr: is_signature_required
      comment: "Indicates whether a signature is required for delivery — used to analyze signature surcharge impact on total shipping cost."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the shipping cost amount — required for accurate multi-currency freight cost reporting."
    - name: "packed_date"
      expr: DATE_TRUNC('day', packed_timestamp)
      comment: "Date the package was packed — used for daily pack volume trend analysis and carrier manifest scheduling."
    - name: "estimated_delivery_date_day"
      expr: DATE_TRUNC('day', estimated_delivery_date)
      comment: "Estimated delivery date bucketed to day — used for delivery promise tracking and SLA window analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of shipment packages. Baseline volume KPI for carrier manifest management and packaging material procurement."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all packages. Primary freight spend KPI at the package level — used for carrier invoice reconciliation and cost-per-package benchmarking."
    - name: "avg_shipping_cost_per_package"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per package. Efficiency benchmark — rising averages signal dimensional weight issues, surcharge increases, or service level mix shifts."
    - name: "total_billable_weight_kg"
      expr: SUM(CAST(billable_weight_kg AS DOUBLE))
      comment: "Total billable weight across all packages. Directly drives carrier charges — used to identify dimensional weight surcharge exposure and packaging optimization opportunities."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total actual physical weight of all packages. Compared against billable weight to quantify dimensional weight uplift and associated cost premium."
    - name: "avg_billable_weight_kg"
      expr: AVG(CAST(billable_weight_kg AS DOUBLE))
      comment: "Average billable weight per package. Used to benchmark packaging efficiency and identify SKU categories with excessive dimensional weight ratios."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total declared insurance value across all packages. Used to manage insurance cost exposure and ensure adequate coverage for high-value shipments."
    - name: "insured_package_count"
      expr: COUNT(CASE WHEN is_insured = TRUE THEN 1 END)
      comment: "Number of insured packages. Numerator for insurance coverage rate — used to ensure high-value shipments are adequately covered."
    - name: "hazmat_package_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Number of hazmat packages. Used to track compliance handling volume and ensure carrier hazmat certification requirements are met."
    - name: "manifested_package_count"
      expr: COUNT(CASE WHEN is_manifested = TRUE THEN 1 END)
      comment: "Number of packages successfully manifested with the carrier. Numerator for manifest completion rate — unmanifested packages risk carrier pickup failures."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA configuration and coverage KPIs for fulfillment promise management. Used by operations and commercial leadership to ensure SLA policies are correctly configured, active, and appropriately scoped across fulfillment methods, channels, and geographies."
  source: "`retail_ecm`.`fulfillment`.`sla`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. delivery, ship, ready) — primary dimension for SLA policy analysis by promise type."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method the SLA applies to (e.g. ship-to-home, BOPIS, same-day) — used to benchmark SLA stringency by channel."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel the SLA applies to (e.g. web, mobile, in-store) — used to ensure channel-appropriate SLA coverage."
    - name: "node_type"
      expr: node_type
      comment: "Type of fulfillment node the SLA applies to (e.g. DC, store, vendor) — used to compare SLA commitments across node types."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier the SLA applies to (e.g. standard, premium, VIP) — used to ensure differentiated SLA coverage for loyalty tiers."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the SLA is currently active — used to audit SLA coverage gaps and ensure no active fulfillment methods are operating without a valid SLA."
    - name: "country_code"
      expr: country_code
      comment: "Country the SLA applies to — used for geographic SLA coverage analysis and cross-border fulfillment compliance."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the SLA (e.g. national, regional, local) — used to identify coverage gaps in specific geographies."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the SLA became effective — used to track SLA policy change history and coverage evolution over time."
  measures:
    - name: "total_sla_policies"
      expr: COUNT(1)
      comment: "Total number of SLA policies defined. Baseline coverage KPI — used to audit SLA completeness across fulfillment methods and channels."
    - name: "active_sla_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active SLA policies. Used to ensure adequate SLA coverage is in place for all active fulfillment operations."
    - name: "avg_promised_hours_to_deliver"
      expr: AVG(CAST(promised_hours_to_deliver AS DOUBLE))
      comment: "Average promised delivery hours across all SLA policies. Benchmarks the overall delivery promise stringency — used to assess competitiveness against market standards."
    - name: "avg_promised_hours_to_ship"
      expr: AVG(CAST(promised_hours_to_ship AS DOUBLE))
      comment: "Average promised hours from order to shipment across SLA policies. Used to assess ship-speed commitments and identify policies that may be operationally unachievable."
    - name: "avg_promised_hours_to_ready"
      expr: AVG(CAST(promised_hours_to_ready AS DOUBLE))
      comment: "Average promised hours to order-ready status (e.g. BOPIS ready for pickup). Used to benchmark click-to-ready performance commitments."
    - name: "avg_breach_threshold_hours"
      expr: AVG(CAST(breach_threshold_hours AS DOUBLE))
      comment: "Average breach threshold in hours across SLA policies. Used to assess how much buffer exists between promised delivery and breach trigger — low values indicate tight SLA risk."
    - name: "total_order_value_coverage"
      expr: SUM(CAST(order_value_max AS DOUBLE))
      comment: "Sum of maximum order value thresholds across SLA policies. Used to audit whether high-value order segments have appropriate SLA coverage."
    - name: "distinct_fulfillment_methods_covered"
      expr: COUNT(DISTINCT fulfillment_method)
      comment: "Number of distinct fulfillment methods covered by SLA policies. Used to identify fulfillment methods operating without formal SLA governance."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries covered by SLA policies. Used to audit international fulfillment SLA coverage and identify geographic gaps."
$$;