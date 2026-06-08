-- Metric views for domain: fulfillment | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fulfillment order throughput, cycle time, SLA compliance, and operational efficiency. Enables leadership to monitor order flow, identify bottlenecks in pick/pack/ship stages, and track on-time delivery performance."
  source: "`ecommerce_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method (e.g. standard, same-day, BOPIS) used to segment order performance by channel."
    - name: "fulfillment_order_status"
      expr: fulfillment_order_status
      comment: "Current status of the fulfillment order (e.g. pending, picked, packed, shipped, delivered, cancelled) for pipeline analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g. standard, gift, return) to segment KPIs by order category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the fulfillment order (e.g. high, medium, low) for SLA and throughput segmentation."
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "Destination country code for geographic performance analysis."
    - name: "promised_delivery_date"
      expr: DATE_TRUNC('day', promised_delivery_date)
      comment: "Promised delivery date bucketed to day for on-time delivery trend analysis."
    - name: "promised_ship_date"
      expr: DATE_TRUNC('day', promised_ship_date)
      comment: "Promised ship date bucketed to day for ship-on-time trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the fulfillment order was created, for monthly throughput trending."
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether the order is a gift, for gift order performance segmentation."
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders. Baseline volume metric for throughput and capacity planning."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN fulfillment_order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled fulfillment orders. Elevated cancellation rates signal supply, SLA, or demand-planning issues requiring executive intervention."
    - name: "shipped_orders"
      expr: COUNT(CASE WHEN shipped_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of orders that have been shipped. Core throughput KPI for fulfillment center output."
    - name: "delivered_orders"
      expr: COUNT(CASE WHEN delivered_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of orders confirmed delivered. Directly tied to customer satisfaction and revenue recognition."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivered_timestamp IS NOT NULL AND CAST(delivered_timestamp AS DATE) <= promised_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN delivered_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivered orders that arrived on or before the promised delivery date. Premier SLA compliance KPI used in QBRs and carrier performance reviews."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillment orders that were cancelled. A rising cancellation rate triggers investigation into inventory availability, SLA feasibility, and demand forecasting accuracy."
    - name: "avg_total_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight per fulfillment order in kilograms. Used for carrier cost modeling and packaging optimization."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total cubic volume (m³) across all fulfillment orders. Drives warehouse space utilization and carrier capacity planning decisions."
    - name: "avg_pick_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(picking_completed_timestamp) - UNIX_TIMESTAMP(picking_started_timestamp)) AS DOUBLE) / 3600.0)
      comment: "Average time in hours between pick start and pick completion. A key operational efficiency KPI — elevated values indicate warehouse congestion or staffing gaps."
    - name: "avg_pack_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(packing_completed_timestamp) - UNIX_TIMESTAMP(packing_started_timestamp)) AS DOUBLE) / 3600.0)
      comment: "Average time in hours between pack start and pack completion. Identifies packing station bottlenecks that delay ship-on-time performance."
    - name: "avg_fulfillment_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(shipped_timestamp) - UNIX_TIMESTAMP(received_timestamp)) AS DOUBLE) / 3600.0)
      comment: "Average end-to-end fulfillment cycle time in hours from order receipt to shipment. The primary operational throughput KPI for fulfillment center benchmarking."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for shipment cost, carrier performance, delivery outcomes, and shipping efficiency. Enables supply chain leadership to manage carrier spend, monitor delivery quality, and optimize shipping cost structures."
  source: "`ecommerce_ecm`.`fulfillment`.`fulfillment_shipment`"
  dimensions:
    - name: "fulfillment_shipment_status"
      expr: fulfillment_shipment_status
      comment: "Current status of the shipment (e.g. in_transit, delivered, returned, exception) for pipeline and exception analysis."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g. standard, express, freight) for cost and performance segmentation."
    - name: "shipping_priority"
      expr: shipping_priority
      comment: "Priority tier of the shipment for SLA and cost analysis by service level."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic shipping cost and delivery performance analysis."
    - name: "destination_state"
      expr: destination_state
      comment: "Destination state/province for regional carrier performance and cost benchmarking."
    - name: "freight_class"
      expr: freight_class
      comment: "Freight classification for cost modeling and carrier rate analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g. prepaid, collect) for cost allocation analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the shipment contains hazardous materials, for compliance and cost segmentation."
    - name: "insurance_flag"
      expr: insurance_flag
      comment: "Indicates whether the shipment is insured, for risk and cost analysis."
    - name: "ship_month"
      expr: DATE_TRUNC('month', ship_timestamp)
      comment: "Month the shipment was dispatched, for monthly shipping cost and volume trending."
    - name: "actual_delivery_date_day"
      expr: DATE_TRUNC('day', actual_delivery_date)
      comment: "Actual delivery date bucketed to day for delivery performance trending."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments dispatched. Baseline volume metric for carrier capacity and fulfillment throughput."
    - name: "total_shipping_cost_gross"
      expr: SUM(CAST(shipping_cost_gross AS DOUBLE))
      comment: "Total gross shipping cost across all shipments. Primary cost KPI for carrier spend management and budget tracking."
    - name: "total_shipping_cost_net"
      expr: SUM(CAST(shipping_cost_net AS DOUBLE))
      comment: "Total net shipping cost (after discounts/adjustments). Used for true carrier cost benchmarking and P&L reporting."
    - name: "total_shipping_cost_tax"
      expr: SUM(CAST(shipping_cost_tax AS DOUBLE))
      comment: "Total tax component of shipping costs. Required for finance and regulatory reporting on shipping tax liability."
    - name: "avg_shipping_cost_gross"
      expr: AVG(CAST(shipping_cost_gross AS DOUBLE))
      comment: "Average gross shipping cost per shipment. Tracks carrier rate efficiency and cost-per-shipment trends over time."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND actual_delivery_date <= estimated_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivered shipments that arrived on or before the estimated delivery date. Core carrier SLA compliance KPI used in carrier performance reviews and contract negotiations."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Drives carrier rate negotiations and capacity planning."
    - name: "avg_shipment_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Used for packaging optimization and carrier rate tier analysis."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared value of all shipments. Informs insurance coverage decisions and risk exposure quantification."
    - name: "total_insurance_amount"
      expr: SUM(CASE WHEN insurance_flag = TRUE THEN declared_value ELSE 0 END)
      comment: "Total declared value of insured shipments. Tracks insurance coverage exposure and cost-benefit of shipment insurance programs."
    - name: "shipping_cost_per_kg"
      expr: ROUND(SUM(CAST(shipping_cost_net AS DOUBLE)) / NULLIF(SUM(CAST(weight_kg AS DOUBLE)), 0), 4)
      comment: "Net shipping cost per kilogram shipped. A compound efficiency KPI used to benchmark carrier rate competitiveness and identify cost reduction opportunities."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for order line fulfillment quality, pick accuracy, substitution rates, and line-level revenue. Enables operations and merchandising leadership to monitor pick performance, substitution impact, and line-level fulfillment efficiency."
  source: "`ecommerce_ecm`.`fulfillment`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. pending, picked, packed, cancelled) for pipeline analysis."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the order line for order accuracy and exception tracking."
    - name: "pick_method"
      expr: pick_method
      comment: "Method used to pick the item (e.g. manual, automated, voice-directed) for pick efficiency benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the order line quantity, for accurate volume and weight analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line total amount for multi-currency revenue analysis."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether the ordered SKU was substituted with an alternative, for substitution rate and customer impact analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the order line contains hazardous materials, for compliance and handling cost segmentation."
    - name: "gift_wrap_flag"
      expr: gift_wrap_flag
      comment: "Indicates whether gift wrapping was requested, for gift service volume and cost analysis."
    - name: "return_eligible_flag"
      expr: return_eligible_flag
      comment: "Indicates whether the line item is eligible for return, for return liability and policy analysis."
    - name: "pick_exception_code"
      expr: pick_exception_code
      comment: "Exception code raised during picking (e.g. out-of-stock, damaged) for root cause analysis of pick failures."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the order line was created for monthly volume and revenue trending."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines processed. Baseline volume metric for fulfillment throughput and capacity planning."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Core demand volume metric for inventory and fulfillment planning."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units successfully picked. Measures actual pick throughput against ordered demand."
    - name: "total_packed_quantity"
      expr: SUM(CAST(packed_quantity AS DOUBLE))
      comment: "Total units packed and ready for shipment. Tracks pack stage throughput and identifies pack-pick gaps."
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue value across all fulfillment order lines. Directly ties fulfillment throughput to revenue outcomes."
    - name: "pick_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was successfully picked. A critical fulfillment quality KPI — low fill rates signal inventory availability or pick accuracy issues that directly impact customer satisfaction and revenue."
    - name: "pack_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(packed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was successfully packed. Measures end-to-end fulfillment completeness from order to pack stage."
    - name: "substitution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines fulfilled with a substituted SKU. Elevated substitution rates indicate inventory gaps and risk customer dissatisfaction — a key merchandising and inventory health KPI."
    - name: "pick_exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pick_exception_code IS NOT NULL AND pick_exception_code != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines that encountered a pick exception. Directly measures warehouse operational quality and is a leading indicator of fulfillment delays and customer complaints."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across fulfillment order lines. Used to track average selling price trends and assess pricing strategy effectiveness in the fulfillment mix."
    - name: "total_line_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all order lines in kilograms. Drives carrier cost allocation and packaging optimization decisions."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_shipment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for shipment tracking event quality, SLA breach detection, and exception management. Enables logistics and customer experience leadership to monitor carrier event coverage, identify SLA breaches in real time, and manage delivery exceptions proactively."
  source: "`ecommerce_ecm`.`fulfillment`.`shipment_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of shipment tracking event (e.g. picked_up, in_transit, out_for_delivery, delivered, exception) for event funnel analysis."
    - name: "carrier_event_code"
      expr: carrier_event_code
      comment: "Carrier-specific event code for granular carrier performance and exception root cause analysis."
    - name: "event_source"
      expr: event_source
      comment: "Source system that generated the event (e.g. carrier API, manual scan) for data quality and coverage analysis."
    - name: "is_exception"
      expr: is_exception
      comment: "Flag indicating whether the event represents a delivery exception, for exception rate and impact analysis."
    - name: "is_sla_breach"
      expr: is_sla_breach
      comment: "Flag indicating whether the event represents an SLA breach, for SLA compliance monitoring and carrier accountability."
    - name: "is_customer_visible"
      expr: is_customer_visible
      comment: "Flag indicating whether the event is surfaced to the customer in tracking, for customer experience quality analysis."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery location (e.g. residential, commercial, locker) for last-mile performance segmentation."
    - name: "event_location_country"
      expr: event_location_country
      comment: "Country where the shipment event occurred for geographic exception and SLA analysis."
    - name: "exception_reason"
      expr: exception_reason
      comment: "Reason code for delivery exceptions (e.g. address_not_found, recipient_unavailable) for root cause analysis and carrier accountability."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the shipment event occurred for monthly SLA breach and exception trending."
  measures:
    - name: "total_shipment_events"
      expr: COUNT(1)
      comment: "Total number of shipment tracking events. Baseline metric for carrier event coverage and tracking data completeness."
    - name: "total_exception_events"
      expr: COUNT(CASE WHEN is_exception = TRUE THEN 1 END)
      comment: "Total number of shipment exception events. A direct measure of delivery disruptions that impact customer satisfaction and require operational intervention."
    - name: "total_sla_breach_events"
      expr: COUNT(CASE WHEN is_sla_breach = TRUE THEN 1 END)
      comment: "Total number of events flagged as SLA breaches. Core KPI for carrier SLA compliance monitoring and contract penalty assessment."
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exception = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipment events that are exceptions. A rising exception rate is a leading indicator of carrier performance degradation and customer satisfaction risk."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipment events flagged as SLA breaches. Used in carrier performance reviews and SLA penalty calculations — a critical executive KPI for delivery promise management."
    - name: "distinct_shipments_with_exceptions"
      expr: COUNT(DISTINCT CASE WHEN is_exception = TRUE THEN fulfillment_shipment_id END)
      comment: "Number of unique shipments that experienced at least one exception event. Measures the breadth of delivery disruption across the shipment portfolio."
    - name: "distinct_shipments_with_sla_breach"
      expr: COUNT(DISTINCT CASE WHEN is_sla_breach = TRUE THEN fulfillment_shipment_id END)
      comment: "Number of unique shipments that experienced at least one SLA breach event. Directly informs carrier accountability and SLA penalty calculations."
    - name: "avg_actual_weight_kg"
      expr: AVG(CAST(weight_actual_kg AS DOUBLE))
      comment: "Average actual shipment weight recorded at scan events in kilograms. Used to validate declared weights against actual weights for carrier billing accuracy."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for last-mile delivery confirmation quality, SLA compliance, and proof capture rates. Enables customer experience and logistics leadership to monitor delivery verification standards, SLA adherence, and exception resolution."
  source: "`ecommerce_ecm`.`fulfillment`.`proof_of_delivery`"
  dimensions:
    - name: "proof_of_delivery_status"
      expr: proof_of_delivery_status
      comment: "Status of the proof of delivery record (e.g. confirmed, disputed, pending) for delivery confirmation pipeline analysis."
    - name: "proof_type"
      expr: proof_type
      comment: "Type of proof captured (e.g. signature, photo, OTP) for delivery verification method analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (e.g. courier, locker, BOPIS) for last-mile performance segmentation."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country where delivery was confirmed for geographic SLA and quality analysis."
    - name: "sla_compliance"
      expr: sla_compliance
      comment: "SLA compliance status of the delivery (e.g. compliant, breached) for SLA performance reporting."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier code for carrier-level delivery quality and SLA compliance benchmarking."
    - name: "is_bopis"
      expr: is_bopis
      comment: "Indicates whether the delivery was a Buy Online Pick Up In Store (BOPIS) order for omnichannel fulfillment analysis."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates whether a delivery exception occurred, for exception rate and root cause analysis."
    - name: "signature_captured"
      expr: signature_captured
      comment: "Indicates whether a signature was captured at delivery, for compliance and high-value delivery verification analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_timestamp)
      comment: "Month of delivery confirmation for monthly delivery quality and SLA trending."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of proof of delivery records. Baseline metric for confirmed delivery volume."
    - name: "sla_compliant_deliveries"
      expr: COUNT(CASE WHEN sla_compliance = 'compliant' THEN 1 END)
      comment: "Number of deliveries that met SLA targets. Core delivery promise KPI used in carrier and operations performance reviews."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that met SLA targets. Premier last-mile SLA KPI — directly tied to customer satisfaction scores and carrier contract compliance."
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that encountered an exception. A leading indicator of last-mile quality issues requiring carrier or operational intervention."
    - name: "signature_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries where a signature was captured. Measures compliance with high-value and regulated delivery verification requirements."
    - name: "photo_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN photo_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries where a photo was captured as proof. Tracks adoption of contactless delivery verification and dispute resolution readiness."
    - name: "otp_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN otp_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries verified via OTP (one-time password). Measures adoption of secure digital delivery verification, critical for high-value and regulated shipments."
    - name: "distinct_shipments_delivered"
      expr: COUNT(DISTINCT fulfillment_shipment_id)
      comment: "Number of unique shipments with confirmed proof of delivery. Measures actual delivery completion breadth across the shipment portfolio."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fulfillment center capacity utilization, operational coverage, and network configuration. Enables supply chain and real estate leadership to assess center capacity headroom, operational model mix, and network readiness."
  source: "`ecommerce_ecm`.`fulfillment`.`center`"
  dimensions:
    - name: "center_type"
      expr: center_type
      comment: "Type of fulfillment center (e.g. DC, micro-fulfillment, returns center) for network segmentation and capacity analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the center (e.g. active, closed, under_construction) for network availability analysis."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model of the center (e.g. owned, leased, 3PL) for cost structure and strategic asset analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation in the center (e.g. manual, semi-automated, fully-automated) for throughput and cost benchmarking."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the center (e.g. standard, premium, same-day) for service level capacity planning."
    - name: "country_code"
      expr: country_code
      comment: "Country where the fulfillment center is located for geographic network analysis."
    - name: "supports_cold_storage"
      expr: supports_cold_storage
      comment: "Indicates whether the center supports cold storage, for perishable and temperature-sensitive product network planning."
    - name: "supports_hazmat"
      expr: supports_hazmat
      comment: "Indicates whether the center supports hazardous materials handling, for compliance and network routing decisions."
    - name: "operates_24_7"
      expr: operates_24_7
      comment: "Indicates whether the center operates 24/7, for throughput capacity and SLA feasibility analysis."
  measures:
    - name: "total_centers"
      expr: COUNT(1)
      comment: "Total number of fulfillment centers in the network. Baseline metric for network scale and geographic coverage."
    - name: "total_capacity_units"
      expr: SUM(CAST(total_capacity_units AS DOUBLE))
      comment: "Total storage capacity units across all fulfillment centers. Core network capacity KPI for investment and expansion planning."
    - name: "total_available_capacity_units"
      expr: SUM(CAST(available_capacity_units AS DOUBLE))
      comment: "Total available (unused) capacity units across all centers. Measures network headroom and informs inventory placement and expansion decisions."
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(total_capacity_units AS DOUBLE)) - SUM(CAST(available_capacity_units AS DOUBLE))) / NULLIF(SUM(CAST(total_capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total network capacity currently in use. The primary fulfillment network efficiency KPI — high utilization signals need for expansion; low utilization signals cost optimization opportunities."
    - name: "active_centers"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of currently active fulfillment centers. Tracks operational network availability for capacity and SLA planning."
    - name: "centers_with_cold_storage"
      expr: COUNT(CASE WHEN supports_cold_storage = TRUE THEN 1 END)
      comment: "Number of centers supporting cold storage. Informs network readiness for perishable and temperature-sensitive product categories."
    - name: "centers_operating_24_7"
      expr: COUNT(CASE WHEN operates_24_7 = TRUE THEN 1 END)
      comment: "Number of centers operating 24/7. Measures network capacity for same-day and next-day SLA fulfillment commitments."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`fulfillment_shipping_label`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for shipping label cost, rate selection efficiency, and label quality. Enables logistics and finance leadership to monitor carrier rate spend, identify manual override patterns, and optimize rate selection processes."
  source: "`ecommerce_ecm`.`fulfillment`.`shipping_label`"
  dimensions:
    - name: "shipping_label_status"
      expr: shipping_label_status
      comment: "Current status of the shipping label (e.g. generated, voided, printed) for label lifecycle analysis."
    - name: "label_format"
      expr: label_format
      comment: "Format of the shipping label (e.g. ZPL, PDF) for printer compatibility and operational analysis."
    - name: "package_type"
      expr: package_type
      comment: "Type of package (e.g. box, envelope, pallet) for packaging cost and carrier rate analysis."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for the carrier rate calculation (e.g. weight, dimensional, flat) for rate optimization analysis."
    - name: "rate_currency"
      expr: rate_currency
      comment: "Currency of the carrier rate for multi-currency cost analysis."
    - name: "selection_method"
      expr: selection_method
      comment: "Method used to select the carrier rate (e.g. automated, manual) for rate selection efficiency analysis."
    - name: "manual_override_flag"
      expr: manual_override_flag
      comment: "Indicates whether the label was manually overridden, for exception and cost governance analysis."
    - name: "void_flag"
      expr: void_flag
      comment: "Indicates whether the label was voided, for label waste and cost recovery analysis."
    - name: "customs_declaration_flag"
      expr: customs_declaration_flag
      comment: "Indicates whether a customs declaration was required, for international shipping compliance and cost analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the shipping label was created for monthly carrier spend and volume trending."
  measures:
    - name: "total_labels_generated"
      expr: COUNT(1)
      comment: "Total number of shipping labels generated. Baseline metric for shipment volume and label production throughput."
    - name: "total_carrier_rate_amount"
      expr: SUM(CAST(carrier_rate_amount AS DOUBLE))
      comment: "Total carrier rate charges across all labels. Primary carrier cost KPI for spend management and rate negotiation."
    - name: "total_label_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total all-in shipping label cost including adjustments and insurance. Used for full shipping cost accounting and P&L reporting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total carrier rate adjustments (surcharges or credits) applied to labels. Tracks carrier billing accuracy and identifies systematic surcharge patterns."
    - name: "total_insurance_amount"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance cost across all shipping labels. Informs insurance program cost-benefit analysis and risk management decisions."
    - name: "voided_label_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping labels that were voided. High void rates indicate order cancellation issues, carrier selection errors, or operational inefficiencies that drive unnecessary carrier costs."
    - name: "manual_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN manual_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipping labels generated via manual carrier override. Elevated rates signal gaps in automated rate selection logic and potential cost governance risks."
    - name: "avg_carrier_rate_amount"
      expr: AVG(CAST(carrier_rate_amount AS DOUBLE))
      comment: "Average carrier rate per label. Tracks rate efficiency trends and supports carrier contract benchmarking."
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value AS DOUBLE))
      comment: "Total declared customs value across international shipments. Required for trade compliance reporting and customs duty liability assessment."
$$;