-- Metric views for domain: distribution | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level KPIs for distribution network capacity, certification coverage, and operational readiness. Used by supply chain leadership to evaluate network footprint and facility capability."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of distribution facility (e.g., DC, cross-dock, hub) for segmenting capacity and performance by facility class."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the facility is owned, leased, or 3PL-operated — drives make-vs-buy and capex decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located, enabling geographic network analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility (active, closed, under construction) for network planning."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the facility supports temperature-controlled storage, critical for cold-chain product segmentation."
    - name: "cross_dock_enabled_flag"
      expr: cross_dock_enabled_flag
      comment: "Indicates cross-dock capability, relevant for transit-time and handling-cost optimization."
    - name: "distribution_facility_status"
      expr: distribution_facility_status
      comment: "Lifecycle status of the facility record for filtering active vs. inactive facilities."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the facility for regional distribution network analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of distribution facilities in the network. Baseline measure for network footprint tracking."
    - name: "total_capacity_sqft_sum"
      expr: SUM(CAST(total_capacity_sqft AS DOUBLE))
      comment: "Total square footage across all distribution facilities. Drives capacity planning and network expansion decisions."
    - name: "avg_capacity_sqft_per_facility"
      expr: AVG(CAST(total_capacity_sqft AS DOUBLE))
      comment: "Average facility size in square feet. Benchmarks facility scale and informs standardization strategy."
    - name: "avg_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average OTIF (On-Time In-Full) target across facilities. Reflects the network-wide service level commitment to customers."
    - name: "avg_osa_target_percentage"
      expr: AVG(CAST(osa_target_percentage AS DOUBLE))
      comment: "Average On-Shelf Availability target across facilities. Directly linked to retail service levels and revenue at risk."
    - name: "hazmat_certified_facility_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of facilities certified to handle hazardous materials. Critical for regulatory compliance and product routing decisions."
    - name: "temperature_controlled_facility_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of temperature-controlled facilities. Determines cold-chain network capacity for perishable and pharmaceutical products."
    - name: "gmp_certified_facility_count"
      expr: COUNT(CASE WHEN gmp_certified_flag = TRUE THEN 1 END)
      comment: "Number of GMP-certified facilities. Required for regulated product distribution and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance KPIs covering receipt accuracy, quality compliance, OTIF adherence, and temperature integrity. Used by DC operations and procurement to manage supplier and inbound quality performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt (e.g., PO receipt, return, transfer) for segmenting inbound volume by source."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt (open, closed, discrepant) for operational queue management."
    - name: "inbound_receipt_status"
      expr: inbound_receipt_status
      comment: "Lifecycle status of the inbound receipt record for filtering and trend analysis."
    - name: "receipt_date"
      expr: DATE_TRUNC('day', receipt_date)
      comment: "Date the receipt was recorded, truncated to day for daily inbound volume trending."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of receipt for monthly inbound performance reporting."
    - name: "discrepancy_reason"
      expr: discrepancy_reason
      comment: "Root cause of receipt discrepancy (e.g., short ship, damage, wrong item) for supplier corrective action."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Outcome of quality inspection at receipt (passed, failed, pending) for quality gate monitoring."
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Whether the receipt met OTIF requirements — key supplier scorecard dimension."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether the inbound shipment met temperature requirements — critical for cold-chain compliance."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts processed. Baseline measure for inbound volume tracking."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all inbound receipts. Core inbound throughput measure."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection. Measures effective inbound supply available for putaway."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receipt. High rejection rates signal supplier quality issues and supply risk."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total quantity expected per ASN/PO. Used as denominator for receipt fill-rate calculations."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with discrepancies. Drives supplier performance management and corrective action."
    - name: "otif_compliant_receipt_count"
      expr: COUNT(CASE WHEN otif_compliant_flag = TRUE THEN 1 END)
      comment: "Number of receipts that were OTIF-compliant. Numerator for supplier OTIF rate calculation."
    - name: "temperature_compliant_receipt_count"
      expr: COUNT(CASE WHEN temperature_compliant_flag = TRUE THEN 1 END)
      comment: "Number of receipts meeting temperature compliance requirements. Numerator for cold-chain compliance rate."
    - name: "avg_temperature_reading_celsius"
      expr: AVG(CAST(temperature_reading_celsius AS DOUBLE))
      comment: "Average temperature at receipt in Celsius. Monitors cold-chain integrity across inbound shipments."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection. Drives QC resource planning and throughput bottleneck analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inbound receipt KPIs covering quantity accuracy, cost, and quality at the SKU/lot level. Used by procurement and quality teams to manage supplier fill rates and product condition at receipt."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line`"
  dimensions:
    - name: "inbound_receipt_line_status"
      expr: inbound_receipt_line_status
      comment: "Status of the receipt line (received, rejected, pending) for operational line-level tracking."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Receipt-level status propagated to the line for filtering active vs. closed receipts."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome at the line level for SKU-level quality performance analysis."
    - name: "condition_code"
      expr: condition_code
      comment: "Physical condition of received goods (e.g., good, damaged, expired) for loss and write-off analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities, required for accurate volume comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the extended cost for multi-currency cost analysis."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Expiration date of received goods truncated to month — used to identify near-expiry inbound inventory risk."
    - name: "manufacture_date"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Manufacture date of received goods truncated to month for shelf-life and freshness analysis."
  measures:
    - name: "total_receipt_lines"
      expr: COUNT(1)
      comment: "Total number of inbound receipt lines. Baseline measure for inbound line-item volume."
    - name: "total_received_quantity_cases"
      expr: SUM(CAST(received_quantity_cases AS DOUBLE))
      comment: "Total cases received across all receipt lines. Primary inbound volume measure in case units."
    - name: "total_expected_quantity_cases"
      expr: SUM(CAST(expected_quantity_cases AS DOUBLE))
      comment: "Total cases expected per ASN/PO lines. Denominator for case fill-rate calculation."
    - name: "total_variance_quantity_cases"
      expr: SUM(CAST(variance_quantity_cases AS DOUBLE))
      comment: "Total case quantity variance (received minus expected). Negative values indicate short shipments; positive indicate overages."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of received goods. Measures inbound inventory value and drives COGS and working capital analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods. Used for cost benchmarking and supplier price variance analysis."
    - name: "avg_temperature_at_receipt_celsius"
      expr: AVG(CAST(temperature_at_receipt_celsius AS DOUBLE))
      comment: "Average temperature at receipt in Celsius at the line level. Monitors cold-chain integrity for temperature-sensitive SKUs."
    - name: "distinct_skus_received"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs received. Measures inbound assortment breadth and supplier range compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability KPIs at the facility-SKU-lot level. Used by supply chain planners and DC managers to manage stock levels, availability, and inventory quality across the distribution network."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inventory_position`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, hold, quarantine, damaged) for stock quality segmentation."
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Physical condition of inventory (good, damaged, expired) for write-off and disposition analysis."
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_date)
      comment: "Date of the inventory snapshot, truncated to day for daily inventory position trending."
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of the inventory snapshot for monthly inventory level reporting."
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone within the facility (e.g., ambient, chilled, frozen) for zone-level capacity and availability analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the storage location for cold-chain inventory segmentation."
    - name: "owner_type"
      expr: owner_type
      comment: "Ownership type of inventory (own, consignment, 3PL) for financial and liability reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of inventory valuation for multi-currency financial reporting."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of last inventory movement (receipt, pick, transfer, adjustment) for activity-based inventory analysis."
    - name: "replenishment_flag"
      expr: replenishment_flag
      comment: "Indicates whether the inventory position has triggered a replenishment signal — key for supply planning."
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity across all positions. Primary stock level measure for supply planning."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for order fulfillment (on-hand minus holds and allocations). Drives ATP and order promising."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to open orders. Measures demand commitment against on-hand stock."
    - name: "total_quantity_hold"
      expr: SUM(CAST(quantity_hold AS DOUBLE))
      comment: "Total quantity on hold (quality, regulatory, or operational). High hold quantities signal quality or compliance risk."
    - name: "total_quantity_damaged"
      expr: SUM(CAST(quantity_damaged AS DOUBLE))
      comment: "Total damaged inventory quantity. Drives write-off decisions and loss prevention initiatives."
    - name: "total_quantity_quarantine"
      expr: SUM(CAST(quantity_quarantine AS DOUBLE))
      comment: "Total quantity in quarantine status. Indicates unresolved quality or regulatory holds impacting available supply."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total financial value of inventory on hand. Core working capital and balance sheet metric for finance leadership."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per inventory unit. Used for cost benchmarking and standard cost variance analysis."
    - name: "distinct_skus_on_hand"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with on-hand inventory. Measures assortment availability and range coverage."
    - name: "replenishment_triggered_positions"
      expr: COUNT(CASE WHEN replenishment_flag = TRUE THEN 1 END)
      comment: "Number of inventory positions that have triggered replenishment. Indicates supply gaps requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment KPIs covering order volume, value, fill rate, OTIF performance, and service level. Used by sales operations and supply chain leadership to manage customer service and order execution performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g., customer, replenishment, DSD) for segmenting fulfillment performance by order class."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound order (open, shipped, cancelled) for pipeline and backlog management."
    - name: "outbound_order_status"
      expr: outbound_order_status
      comment: "Lifecycle status of the outbound order record for operational queue management."
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Date the order was placed, truncated to day for daily order volume trending."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the order was placed for monthly order volume and revenue reporting."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method (e.g., LTL, FTL, parcel) for freight cost and service level analysis."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level for the order (e.g., next-day, standard) for SLA compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order value for multi-currency revenue reporting."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the order is in backorder status — key indicator of supply shortfall and customer impact."
    - name: "otif_commitment_flag"
      expr: otif_commitment_flag
      comment: "Whether the order carries an OTIF commitment to the customer — used to segment OTIF-accountable orders."
    - name: "priority_code"
      expr: priority_code
      comment: "Order priority code for segmenting fulfillment performance by urgency tier."
  measures:
    - name: "total_outbound_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders. Baseline measure for order volume and fulfillment throughput."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of outbound orders. Primary revenue-at-risk and shipment value measure for finance and sales leadership."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all outbound orders. Measures demand volume flowing through the distribution network."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight of outbound orders in kilograms. Drives freight cost estimation and carrier capacity planning."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total volume of outbound orders in cubic meters. Used for load planning and trailer utilization optimization."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average order fill rate percentage. Measures how completely orders are fulfilled — directly impacts customer satisfaction and revenue."
    - name: "backorder_count"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END)
      comment: "Number of orders in backorder status. Indicates supply shortfalls and customer service risk requiring immediate intervention."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per outbound order. Benchmarks order economics and informs pricing and minimum order strategies."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN outbound_order_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled outbound orders. High cancellation rates signal demand volatility or fulfillment failures."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level outbound fulfillment KPIs covering pick accuracy, shipment completeness, OTIF status, and short-ship rates at the SKU level. Used by DC operations and customer service to manage line-level fulfillment quality."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (open, picked, packed, shipped, cancelled) for pipeline management."
    - name: "outbound_order_line_status"
      expr: outbound_order_line_status
      comment: "Lifecycle status of the outbound order line record for operational tracking."
    - name: "otif_status"
      expr: otif_status
      comment: "OTIF compliance status at the line level (compliant, late, short) — key customer service KPI dimension."
    - name: "short_ship_flag"
      expr: short_ship_flag
      comment: "Indicates whether the line was short-shipped. Drives root cause analysis for supply and picking failures."
    - name: "short_ship_reason_code"
      expr: short_ship_reason_code
      comment: "Reason code for short shipment (e.g., out of stock, damage, pick error) for corrective action prioritization."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for order line quantities for accurate volume comparisons."
    - name: "actual_ship_date"
      expr: DATE_TRUNC('day', actual_ship_date)
      comment: "Actual ship date of the order line truncated to day for daily shipment volume trending."
    - name: "ship_month"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Month of actual shipment for monthly fulfillment performance reporting."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates Direct Store Delivery lines for DSD vs. DC-routed fulfillment performance comparison."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates temperature-controlled lines for cold-chain fulfillment performance segmentation."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of outbound order lines. Baseline measure for line-level fulfillment volume."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines. Demand volume measure at the line level."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all lines. Actual fulfillment volume — numerator for line fill rate."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity picked across all lines. Measures warehouse picking throughput and accuracy baseline."
    - name: "total_packed_quantity"
      expr: SUM(CAST(packed_quantity AS DOUBLE))
      comment: "Total quantity packed across all lines. Measures packing throughput and identifies pack-vs-ship discrepancies."
    - name: "total_line_weight_kg"
      expr: SUM(CAST(line_weight_kg AS DOUBLE))
      comment: "Total weight of shipped order lines in kilograms. Used for freight cost allocation and carrier billing reconciliation."
    - name: "total_line_volume_m3"
      expr: SUM(CAST(line_volume_m3 AS DOUBLE))
      comment: "Total volume of shipped order lines in cubic meters. Drives load planning and trailer utilization analysis."
    - name: "short_ship_line_count"
      expr: COUNT(CASE WHEN short_ship_flag = TRUE THEN 1 END)
      comment: "Number of short-shipped order lines. High short-ship counts indicate supply or picking failures impacting customer fill rates."
    - name: "distinct_skus_shipped"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs shipped. Measures assortment fulfillment breadth and range compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking productivity and accuracy KPIs at the task level. Used by DC operations managers to optimize labor efficiency, picking accuracy, and wave execution performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (assigned, in-progress, completed, exception) for operational queue management."
    - name: "task_status"
      expr: task_status
      comment: "Operational task status for filtering active vs. completed picking work."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (e.g., case pick, each pick, pallet pick) for productivity benchmarking by pick method."
    - name: "picking_strategy"
      expr: picking_strategy
      comment: "Picking strategy applied (e.g., FEFO, FIFO, zone pick) for strategy effectiveness analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pick task for SLA compliance and rush order management."
    - name: "pick_accuracy_flag"
      expr: pick_accuracy_flag
      comment: "Indicates whether the pick was executed accurately — key quality dimension for picking error rate analysis."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates Direct Store Delivery pick tasks for DSD vs. DC fulfillment productivity comparison."
    - name: "task_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pick task was created, truncated to day for daily picking volume trending."
    - name: "task_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the pick task was created for monthly picking productivity reporting."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks. Baseline measure for warehouse picking workload and throughput."
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Total quantity to be picked across all tasks. Measures planned picking volume for labor planning."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity actually picked across all tasks. Measures actual picking throughput and completion."
    - name: "accurate_pick_task_count"
      expr: COUNT(CASE WHEN pick_accuracy_flag = TRUE THEN 1 END)
      comment: "Number of pick tasks completed accurately. Numerator for pick accuracy rate — directly impacts order quality and customer satisfaction."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of picked items in kilograms. Used for load planning and carrier capacity management."
    - name: "avg_net_weight_kg_per_task"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per pick task. Benchmarks task density and informs ergonomic and labor standards."
    - name: "otif_eligible_task_count"
      expr: COUNT(CASE WHEN otif_eligible_flag = TRUE THEN 1 END)
      comment: "Number of pick tasks that are OTIF-eligible. Defines the scope of OTIF accountability at the task level."
    - name: "distinct_skus_picked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs picked. Measures assortment breadth in picking operations and slot utilization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment performance KPIs covering OTIF compliance, freight cost, delivery reliability, and shipment volume. Used by logistics, supply chain, and finance leadership to manage carrier performance and customer delivery commitments."
  source: "`vibe_consumer_goods_v1`.`distribution`.`shipment`"
  dimensions:
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., customer delivery, replenishment, DSD) for segmenting logistics performance by shipment class."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in-transit, delivered, delayed, cancelled) for real-time logistics monitoring."
    - name: "distribution_shipment_status"
      expr: distribution_shipment_status
      comment: "Distribution-specific shipment status for DC-level shipment pipeline management."
    - name: "otif_status"
      expr: otif_status
      comment: "OTIF compliance status of the shipment (compliant, late, short, both) — primary customer service KPI dimension."
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Indicates whether the shipment was delivered on time — key carrier and DC performance dimension."
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Indicates whether the shipment was delivered in full — key customer fill rate dimension."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level (e.g., express, standard, economy) for freight cost vs. service trade-off analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic shipment volume and delivery performance analysis."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of delivery destination (e.g., retail store, DC, customer) for channel-level logistics performance."
    - name: "ship_date"
      expr: DATE_TRUNC('day', ship_date)
      comment: "Date the shipment departed, truncated to day for daily shipment volume trending."
    - name: "ship_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month of shipment for monthly logistics performance and freight cost reporting."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates temperature-controlled shipments for cold-chain logistics performance segmentation."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous materials shipments for regulatory compliance and specialized carrier management."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline measure for outbound logistics volume and throughput."
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges across all shipments. Primary logistics cost measure for freight budget management and carrier negotiation."
    - name: "avg_freight_charge_per_shipment"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks carrier efficiency and informs freight rate negotiations."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Used for freight cost per kg analysis and carrier capacity planning."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume shipped in cubic meters. Drives trailer utilization and cubic density analysis."
    - name: "on_time_shipment_count"
      expr: COUNT(CASE WHEN on_time_flag = TRUE THEN 1 END)
      comment: "Number of shipments delivered on time. Numerator for on-time delivery rate — core carrier and DC performance KPI."
    - name: "in_full_shipment_count"
      expr: COUNT(CASE WHEN in_full_flag = TRUE THEN 1 END)
      comment: "Number of shipments delivered in full. Numerator for in-full delivery rate — measures supply completeness to customers."
    - name: "avg_total_weight_kg_per_shipment"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Measures load density and informs minimum shipment size and freight optimization strategies."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity and utilization KPIs for warehouse slotting, compliance, and space management. Used by DC managers and supply chain engineers to optimize warehouse layout and storage strategy."
  source: "`vibe_consumer_goods_v1`.`distribution`.`storage_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g., rack, floor, bulk, pick face) for capacity analysis by storage class."
    - name: "location_status"
      expr: location_status
      comment: "Current status of the storage location (active, blocked, inactive) for available capacity analysis."
    - name: "distribution_storage_location_status"
      expr: distribution_storage_location_status
      comment: "Distribution-specific status of the storage location for DC-level slot management."
    - name: "zone_code"
      expr: zone_code
      comment: "Warehouse zone code for zone-level capacity and utilization analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the storage location (ambient, chilled, frozen) for cold-chain capacity planning."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC velocity classification of the storage location for slotting optimization and pick path efficiency."
    - name: "picking_strategy"
      expr: picking_strategy
      comment: "Picking strategy assigned to the location (FEFO, FIFO, LIFO) for inventory rotation compliance analysis."
    - name: "blocked_flag"
      expr: blocked_flag
      comment: "Indicates whether the location is blocked from use — drives available capacity and operational constraint analysis."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates hazmat-certified storage locations for regulatory compliance and product routing."
    - name: "fefo_eligible_flag"
      expr: fefo_eligible_flag
      comment: "Indicates FEFO-eligible locations for expiry-date-driven inventory rotation compliance."
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations. Baseline measure for warehouse slot count and capacity footprint."
    - name: "total_volume_capacity_m3"
      expr: SUM(CAST(volume_capacity_m3 AS DOUBLE))
      comment: "Total volumetric storage capacity in cubic meters across all locations. Primary warehouse capacity measure for space planning."
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Total weight capacity in kilograms across all storage locations. Drives structural load planning and product routing decisions."
    - name: "total_capacity_units"
      expr: SUM(CAST(capacity_units AS DOUBLE))
      comment: "Total unit capacity across all storage locations. Measures total slot capacity for inventory planning."
    - name: "blocked_location_count"
      expr: COUNT(CASE WHEN blocked_flag = TRUE THEN 1 END)
      comment: "Number of blocked storage locations. High blocked counts reduce effective capacity and signal maintenance or quality issues."
    - name: "hazmat_certified_location_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of hazmat-certified storage locations. Determines hazmat product storage capacity and regulatory compliance coverage."
    - name: "fefo_eligible_location_count"
      expr: COUNT(CASE WHEN fefo_eligible_flag = TRUE THEN 1 END)
      comment: "Number of FEFO-eligible storage locations. Measures the warehouse's capability to enforce expiry-date-driven rotation for perishable products."
    - name: "avg_volume_capacity_m3_per_location"
      expr: AVG(CAST(volume_capacity_m3 AS DOUBLE))
      comment: "Average volumetric capacity per storage location. Benchmarks location size and informs slotting standardization."
$$;