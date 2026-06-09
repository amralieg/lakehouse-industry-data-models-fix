-- Metric views for domain: distribution | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_otif_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-Time In-Full (OTIF) performance metrics tracking delivery compliance, penalty exposure, and fill-rate quality at the shipment and SKU level. Core KPI for retailer SLA management and supply chain accountability."
  source: "`consumer_goods_ecm`.`distribution`.`otif_event`"
  dimensions:
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which delivery was made (e.g., DSD, warehouse, e-commerce) — enables channel-level OTIF benchmarking."
    - name: "otif_status"
      expr: CASE WHEN on_time_flag = TRUE AND in_full_flag = TRUE THEN 'OTIF' WHEN on_time_flag = TRUE AND in_full_flag = FALSE THEN 'On-Time Not In-Full' WHEN on_time_flag = FALSE AND in_full_flag = TRUE THEN 'In-Full Not On-Time' ELSE 'Failed' END
      comment: "Derived OTIF compliance category combining on-time and in-full flags for segmented performance analysis."
    - name: "failure_category"
      expr: failure_category
      comment: "Root-cause category of OTIF failure (e.g., carrier delay, warehouse error, demand spike) — drives corrective action prioritization."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party accountable for OTIF failure (e.g., carrier, DC, supplier) — used for vendor scorecards and accountability reporting."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier classification of the delivery commitment — enables tiered performance tracking against contractual obligations."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of OTIF measurement — supports trend analysis and monthly business reviews."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the OTIF event is under dispute — used to separate clean vs. contested performance records."
  measures:
    - name: "total_otif_events"
      expr: COUNT(1)
      comment: "Total number of OTIF measurement events — baseline denominator for OTIF rate calculations."
    - name: "otif_compliant_events"
      expr: SUM(CASE WHEN on_time_flag = TRUE AND in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of delivery events that were both on-time and in-full — numerator for OTIF compliance rate."
    - name: "on_time_events"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of delivery events that met the on-time commitment — used to compute on-time delivery rate independently."
    - name: "in_full_events"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of delivery events that met the in-full quantity commitment — used to compute fill-rate compliance independently."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed across all OTIF events — baseline for fill-rate and quantity variance analysis."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered — compared against committed quantity to assess fill performance."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Aggregate quantity shortfall or overage across all OTIF events — signals systemic supply or fulfillment gaps."
    - name: "total_retailer_penalty_amount"
      expr: SUM(CAST(retailer_penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred from OTIF non-compliance — direct P&L impact metric for executive review."
    - name: "avg_quantity_variance_percent"
      expr: AVG(CAST(quantity_variance_percent AS DOUBLE))
      comment: "Average percentage variance between committed and delivered quantities — indicates systemic fill-rate accuracy."
    - name: "avg_in_full_tolerance_percent"
      expr: AVG(CAST(in_full_tolerance_percent AS DOUBLE))
      comment: "Average in-full tolerance threshold applied across events — contextualizes fill-rate compliance thresholds."
    - name: "disputed_events"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OTIF events under active dispute — high dispute volume signals measurement or process disagreements with retailers."
    - name: "pod_captured_events"
      expr: SUM(CASE WHEN pod_signature_captured_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events with proof-of-delivery signature captured — measures documentation compliance for dispute resolution."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment execution metrics covering freight cost, weight/volume throughput, on-time departure and delivery performance, and shipment status distribution. Drives logistics cost management and carrier performance decisions."
  source: "`consumer_goods_ecm`.`distribution`.`distribution_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., In Transit, Delivered, Exception) — used to monitor pipeline health and exception rates."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., Full Truckload, LTL, Parcel) — enables cost and performance benchmarking by shipment mode."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Service level contracted with the carrier (e.g., Standard, Express, Priority) — used to assess service-level adherence and cost trade-offs."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of delivery destination — enables geographic distribution analysis and cross-border logistics performance."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of delivery destination (e.g., Retail Store, DC, Customer) — supports channel-level logistics cost allocation."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g., Prepaid, Collect, Third Party) — used for freight cost ownership analysis."
    - name: "otif_status"
      expr: otif_status
      comment: "OTIF compliance status of the shipment — links shipment execution to retailer SLA performance."
    - name: "scheduled_ship_month"
      expr: DATE_TRUNC('MONTH', scheduled_ship_date)
      comment: "Month of scheduled ship date — supports trend analysis of shipment volumes and freight costs over time."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the shipment required temperature-controlled transport — used for cold-chain cost and compliance analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contained hazardous materials — used for regulatory compliance and surcharge tracking."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments dispatched — baseline volume metric for logistics capacity and throughput planning."
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight cost incurred across all shipments — primary logistics cost KPI for budget management and carrier negotiations."
    - name: "avg_freight_charge_per_shipment"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight cost per shipment — benchmarks carrier efficiency and identifies cost outliers by lane or service level."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms — used for freight cost normalization and carrier capacity utilization analysis."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume shipped in cubic meters — supports cube utilization analysis and trailer/container optimization."
    - name: "on_time_shipments"
      expr: SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered on time — numerator for on-time delivery rate; key carrier performance KPI."
    - name: "in_full_shipments"
      expr: SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments delivered in full — numerator for in-full delivery rate; measures order completeness at dispatch."
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms — used to assess load optimization and freight cost per kg efficiency."
    - name: "avg_volume_per_shipment_m3"
      expr: AVG(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Average shipment volume in cubic meters — supports trailer utilization benchmarking and cube optimization initiatives."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment metrics covering order value, fill rate, volume/weight throughput, and OTIF commitment performance. Central KPI layer for customer service level and order management decisions."
  source: "`consumer_goods_ecm`.`distribution`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current fulfillment status of the outbound order (e.g., Open, Shipped, Cancelled) — used to monitor order pipeline health."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g., Standard, Rush, DSD, Transfer) — enables performance benchmarking by order category."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipment (e.g., Ground, Air, LTL) — used for logistics cost and service-level analysis by mode."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level for the order — used to assess adherence to customer delivery commitments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order value is denominated — required for multi-currency financial reporting."
    - name: "priority_code"
      expr: priority_code
      comment: "Order priority classification — used to analyze fulfillment performance by urgency tier."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the order is on backorder — used to quantify supply shortfall impact on customer service."
    - name: "otif_commitment_flag"
      expr: otif_commitment_flag
      comment: "Indicates whether the order carries an OTIF commitment to the customer — used to scope OTIF-eligible order population."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed — supports trend analysis of order volumes and values over time."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility — used for trade compliance and logistics cost allocation."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders — baseline volume metric for fulfillment capacity and demand planning."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all outbound orders — primary revenue-linked fulfillment KPI for financial and commercial reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per outbound order — used to track order size trends and identify shifts in customer buying patterns."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all outbound orders — measures demand volume for supply chain capacity planning."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average order fill rate percentage — measures how completely orders are fulfilled; directly impacts customer satisfaction and OTIF scores."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight of all outbound orders in kilograms — used for freight cost estimation and carrier capacity planning."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total volume of all outbound orders in cubic meters — supports trailer utilization and warehouse throughput planning."
    - name: "backorder_orders"
      expr: SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders on backorder — measures supply shortfall impact on customer fulfillment; triggers inventory replenishment decisions."
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled outbound orders — high cancellation rates signal demand forecasting or supply availability issues."
    - name: "otif_committed_orders"
      expr: SUM(CASE WHEN otif_commitment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders with active OTIF commitments — defines the OTIF-eligible order population for compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position metrics tracking on-hand stock levels, availability, allocation, hold/quarantine quantities, and inventory value across distribution facilities. Drives replenishment, working capital, and service-level decisions."
  source: "`consumer_goods_ecm`.`distribution`.`inventory_position`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (e.g., Available, Hold, Quarantine, Damaged) — used to segment usable vs. restricted stock."
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Physical condition of inventory (e.g., Good, Damaged, Near-Expiry) — used for quality-driven inventory management decisions."
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone within the distribution facility — enables zone-level inventory density and utilization analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone classification (e.g., Ambient, Chilled, Frozen) — used for cold-chain inventory compliance and capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which inventory value is denominated — required for multi-currency financial inventory reporting."
    - name: "owner_type"
      expr: owner_type
      comment: "Ownership type of inventory (e.g., Owned, Consignment, 3PL) — used for working capital and liability reporting."
    - name: "replenishment_flag"
      expr: replenishment_flag
      comment: "Indicates whether the inventory position has triggered a replenishment signal — used to monitor replenishment pipeline activity."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of the inventory snapshot — supports month-over-month inventory trend analysis."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of the most recent inventory movement (e.g., Receipt, Pick, Transfer) — used to identify stagnant or slow-moving stock."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total on-hand inventory quantity across all positions — primary stock level KPI for replenishment and service-level management."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total available-to-promise inventory quantity — directly drives order fulfillment capability and customer service level."
    - name: "total_quantity_allocated"
      expr: SUM(CAST(quantity_allocated AS DOUBLE))
      comment: "Total quantity allocated to open orders — measures committed inventory and informs available-to-promise calculations."
    - name: "total_quantity_hold"
      expr: SUM(CAST(quantity_hold AS DOUBLE))
      comment: "Total quantity on hold — high hold quantities signal quality or compliance issues reducing available supply."
    - name: "total_quantity_quarantine"
      expr: SUM(CAST(quantity_quarantine AS DOUBLE))
      comment: "Total quantity in quarantine — measures inventory at risk pending quality inspection or regulatory clearance."
    - name: "total_quantity_damaged"
      expr: SUM(CAST(quantity_damaged AS DOUBLE))
      comment: "Total damaged inventory quantity — tracks shrinkage and write-off exposure; drives warehouse handling improvement initiatives."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total financial value of inventory on hand — primary working capital KPI for finance and supply chain leadership."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per inventory unit — used for inventory valuation benchmarking and standard cost variance analysis."
    - name: "inventory_positions_count"
      expr: COUNT(1)
      comment: "Total number of distinct inventory position records — measures inventory fragmentation and location utilization breadth."
    - name: "replenishment_triggered_positions"
      expr: SUM(CASE WHEN replenishment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inventory positions with active replenishment signals — indicates breadth of stock-out risk across the network."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance metrics covering receipt accuracy, quality inspection compliance, temperature compliance, and discrepancy rates. Drives supplier performance management and inbound quality control decisions."
  source: "`consumer_goods_ecm`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the inbound receipt (e.g., Pending, Complete, Rejected) — used to monitor inbound pipeline health."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt (e.g., Purchase Order, Transfer, Return) — enables performance benchmarking by receipt category."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Outcome of quality inspection (e.g., Passed, Failed, Pending) — used to track inbound quality compliance rates."
    - name: "discrepancy_reason"
      expr: discrepancy_reason
      comment: "Root cause of receipt discrepancy — used for supplier corrective action and inbound process improvement."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities — ensures consistent quantity aggregation across receipt types."
    - name: "scheduled_receipt_month"
      expr: DATE_TRUNC('MONTH', scheduled_receipt_date)
      comment: "Month of scheduled receipt — supports trend analysis of inbound volumes and supplier delivery patterns."
    - name: "temperature_controlled_flag"
      expr: temperature_check_required_flag
      comment: "Indicates whether a temperature check was required for this receipt — used to scope cold-chain compliance analysis."
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Indicates whether the inbound receipt met OTIF requirements — used for supplier OTIF scorecarding."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts processed — baseline volume metric for inbound dock capacity and labor planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all inbound receipts — measures inbound supply volume for inventory replenishment tracking."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection — measures usable inbound supply net of rejections."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receipt — high rejection volumes signal supplier quality issues and drive chargebacks."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total quantity expected per ASN/PO — denominator for receipt accuracy and supplier fill-rate calculations."
    - name: "receipts_with_discrepancy"
      expr: SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts with quantity or condition discrepancies — measures inbound accuracy and supplier compliance."
    - name: "otif_compliant_receipts"
      expr: SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inbound receipts meeting OTIF requirements — numerator for supplier OTIF compliance rate."
    - name: "temperature_non_compliant_receipts"
      expr: SUM(CASE WHEN temperature_check_required_flag = TRUE AND temperature_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of receipts requiring temperature check that failed compliance — critical cold-chain quality KPI for food safety and regulatory risk."
    - name: "avg_temperature_reading_celsius"
      expr: AVG(CAST(temperature_reading_celsius AS DOUBLE))
      comment: "Average temperature reading at receipt — used to monitor cold-chain integrity and identify systemic temperature excursions."
    - name: "quality_inspection_required_receipts"
      expr: SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts requiring quality inspection — measures inspection workload and compliance gate coverage."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory cycle count accuracy and variance metrics tracking count discrepancies, adjustment rates, and inventory value variances. Drives inventory accuracy governance and shrinkage management decisions."
  source: "`consumer_goods_ecm`.`distribution`.`distribution_cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (e.g., Scheduled, In Progress, Complete, Approved) — used to monitor count pipeline completion."
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., Full, Spot, ABC) — enables performance benchmarking by count methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., Manual, RF Scanner, RFID) — used to assess accuracy by counting technology."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the counted SKU — enables prioritized accuracy analysis for high-value (A-class) items."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Root cause code for inventory variance — drives corrective action and process improvement initiatives."
    - name: "adjustment_required_flag"
      expr: adjustment_required_flag
      comment: "Indicates whether a stock adjustment is required based on count results — used to scope adjustment workload and accuracy gaps."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Indicates whether a recount was required — high recount rates signal counting process quality issues."
    - name: "stock_status"
      expr: stock_status
      comment: "Stock status at time of count (e.g., Unrestricted, Blocked, Quality Inspection) — used to segment accuracy by stock category."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the cycle count was scheduled — supports trend analysis of count frequency and accuracy over time."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records — baseline metric for count program coverage and frequency compliance."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total net inventory variance quantity across all counts — measures aggregate stock discrepancy for shrinkage reporting."
    - name: "total_inventory_value_variance"
      expr: SUM(CAST(inventory_value_variance_amount AS DOUBLE))
      comment: "Total financial value of inventory variances — primary P&L impact metric for inventory shrinkage and write-off management."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average inventory variance percentage across cycle counts — key accuracy KPI; high values trigger process audits and controls."
    - name: "counts_requiring_adjustment"
      expr: SUM(CASE WHEN adjustment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cycle counts requiring stock adjustments — measures the breadth of inventory inaccuracy requiring correction."
    - name: "counts_requiring_recount"
      expr: SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cycle counts requiring a recount — high recount rates indicate counting process quality issues or tolerance breaches."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total quantity physically counted — used to assess count program coverage relative to total inventory positions."
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count — paired with counted quantity to compute aggregate accuracy rates."
    - name: "avg_tolerance_threshold_percentage"
      expr: AVG(CAST(tolerance_threshold_percentage AS DOUBLE))
      comment: "Average tolerance threshold applied across cycle counts — contextualizes variance rates against accepted accuracy standards."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking performance metrics covering pick accuracy, task throughput, weight/volume handled, and exception rates. Drives labor productivity, order accuracy, and warehouse operational efficiency decisions."
  source: "`consumer_goods_ecm`.`distribution`.`pick_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pick task (e.g., Assigned, In Progress, Complete, Exception) — used to monitor picking pipeline health."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (e.g., Case Pick, Each Pick, Pallet Pick) — enables productivity benchmarking by pick methodology."
    - name: "picking_strategy"
      expr: picking_strategy
      comment: "Picking strategy applied (e.g., FIFO, FEFO, Zone Pick) — used to assess strategy effectiveness on accuracy and throughput."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pick task — used to analyze fulfillment performance by urgency tier and SLA compliance."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code raised during picking — used for root-cause analysis of pick failures and process improvement."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the pick task is for a Direct Store Delivery order — used to segment DSD vs. warehouse fulfillment performance."
    - name: "task_assigned_month"
      expr: DATE_TRUNC('MONTH', task_assigned_timestamp)
      comment: "Month the pick task was assigned — supports trend analysis of picking volumes and labor productivity over time."
    - name: "otif_eligible_flag"
      expr: otif_eligible_flag
      comment: "Indicates whether the pick task is part of an OTIF-committed order — used to prioritize OTIF-critical picking operations."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks — baseline volume metric for warehouse labor planning and throughput capacity management."
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Total quantity requested to be picked — measures demand volume flowing through the picking operation."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity actually picked — compared against pick quantity to compute pick fill rate and accuracy."
    - name: "accurate_pick_tasks"
      expr: SUM(CASE WHEN pick_accuracy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pick tasks completed with full accuracy — numerator for pick accuracy rate; directly impacts order quality and OTIF."
    - name: "exception_pick_tasks"
      expr: SUM(CASE WHEN exception_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of pick tasks with exceptions raised — measures operational disruption rate and drives root-cause investigation."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of items picked in kilograms — used for labor ergonomics analysis and freight cost estimation."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight of items picked in kilograms — used for product weight accuracy and freight billing validation."
    - name: "otif_eligible_tasks"
      expr: SUM(CASE WHEN otif_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pick tasks tied to OTIF-committed orders — measures the volume of picking activity under SLA obligation."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`distribution_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse packing performance metrics covering pack throughput, weight/volume output, quality check compliance, and exception rates. Drives packing station efficiency, label compliance, and outbound quality decisions."
  source: "`consumer_goods_ecm`.`distribution`.`pack_task`"
  dimensions:
    - name: "pack_status"
      expr: pack_status
      comment: "Current status of the pack task (e.g., In Progress, Complete, Exception) — used to monitor packing pipeline health."
    - name: "pack_type"
      expr: pack_type
      comment: "Type of packing operation (e.g., Carton, Pallet, Mixed) — enables throughput and cost benchmarking by pack method."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Outcome of quality check at packing (e.g., Passed, Failed, Pending) — used to track outbound quality compliance rates."
    - name: "pack_station_code"
      expr: pack_station_code
      comment: "Identifier of the packing station — enables station-level productivity and quality benchmarking."
    - name: "label_type"
      expr: label_type
      comment: "Type of shipping label applied (e.g., GS1-128, SSCC, Carrier) — used for label compliance and retailer requirement tracking."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the pack task is for a Direct Store Delivery order — used to segment DSD vs. warehouse packing performance."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the pack task required temperature-controlled handling — used for cold-chain compliance analysis."
    - name: "pack_completion_month"
      expr: DATE_TRUNC('MONTH', pack_completion_timestamp)
      comment: "Month the pack task was completed — supports trend analysis of packing throughput and quality over time."
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total number of pack tasks completed — baseline volume metric for packing station capacity and labor planning."
    - name: "total_units_packed"
      expr: SUM(CAST(total_unit_quantity AS DOUBLE))
      comment: "Total units packed across all pack tasks — measures packing throughput for labor productivity and capacity analysis."
    - name: "total_gross_weight_packed_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of packed cartons/pallets in kilograms — used for freight cost estimation and carrier weight compliance."
    - name: "total_volume_packed_m3"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of packed shipments in cubic meters — supports trailer cube utilization and load planning optimization."
    - name: "avg_pack_duration_minutes"
      expr: AVG(CAST(pack_duration_minutes AS DOUBLE))
      comment: "Average time to complete a pack task in minutes — primary labor productivity KPI for packing station efficiency benchmarking."
    - name: "quality_check_failed_tasks"
      expr: SUM(CASE WHEN quality_check_status = 'Failed' THEN 1 ELSE 0 END)
      comment: "Count of pack tasks that failed quality check — measures outbound quality defect rate; drives rework and process improvement."
    - name: "exception_pack_tasks"
      expr: SUM(CASE WHEN exception_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of pack tasks with exceptions raised — measures packing disruption rate and identifies systemic process failures."
    - name: "total_net_weight_packed_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight of packed items in kilograms — used for product weight accuracy validation and freight billing reconciliation."
$$;