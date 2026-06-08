-- Metric views for domain: fulfillment | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fulfillment order KPIs covering order volume, SLA compliance, substitution behaviour, and cold-chain/hazmat risk exposure. Primary steering dashboard for fulfillment operations and supply-chain leadership."
  source: "`grocery_ecm`.`fulfillment`.`order`"
  dimensions:
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the order was placed (e.g. delivery, pickup, ship-to-home). Enables channel-level performance comparison."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Operational fulfillment type (e.g. same-day, next-day, standard). Used to segment SLA performance by service tier."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current lifecycle status of the order (e.g. picked, packed, dispatched, delivered, cancelled). Drives operational triage."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature handling zone required for the order (ambient, chilled, frozen). Critical for cold-chain compliance tracking."
    - name: "priority_code"
      expr: priority_code
      comment: "Order priority tier (e.g. rush, standard, low). Used to assess whether high-priority orders receive preferential treatment."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level selected for the order (e.g. express, ground). Supports carrier performance benchmarking."
    - name: "order_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Calendar day the order was created. Primary time grain for daily operational reporting."
    - name: "order_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month the order was created. Used for monthly trend analysis and period-over-period comparisons."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether the order requires cold-chain handling. Enables cold-chain compliance segmentation."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the order contains hazardous materials. Used for regulatory compliance and risk reporting."
    - name: "prescription_flag"
      expr: prescription_flag
      comment: "Indicates whether the order includes a pharmacy prescription. Supports pharmacy fulfillment performance tracking."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception type code recorded against the order. Used to categorise and prioritise exception resolution."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders. Baseline volume metric for capacity planning and throughput monitoring."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Aggregate weight (kg) across all orders. Drives carrier capacity planning and freight cost forecasting."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Aggregate cubic volume (m³) across all orders. Used for vehicle load optimisation and warehouse space planning."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled orders. A rising cancellation rate signals fulfilment capacity or inventory issues requiring executive intervention."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that were cancelled. Key quality KPI — high rates indicate systemic fulfilment failures impacting customer satisfaction and revenue."
    - name: "orders_with_substitutions"
      expr: COUNT(CASE WHEN CAST(substitution_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of orders where at least one item was substituted. Elevated substitution volume signals inventory availability or assortment gaps."
    - name: "orders_with_short_picks"
      expr: COUNT(CASE WHEN CAST(short_pick_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of orders with at least one short-pick (item unavailable at pick time). Directly linked to out-of-stock rates and customer satisfaction."
    - name: "cold_chain_order_count"
      expr: COUNT(CASE WHEN cold_chain_required_flag = TRUE THEN 1 END)
      comment: "Number of orders requiring cold-chain handling. Used to size cold-chain capacity and monitor compliance exposure."
    - name: "prescription_order_count"
      expr: COUNT(CASE WHEN prescription_flag = TRUE THEN 1 END)
      comment: "Number of orders containing pharmacy prescriptions. Supports pharmacy fulfilment SLA and regulatory compliance reporting."
    - name: "avg_order_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average order weight in kilograms. Used to benchmark carrier load efficiency and detect anomalous order profiles."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level fulfillment KPIs measuring pick accuracy, substitution rates, pack throughput, and cold-chain compliance at the SKU/item level. Essential for operational quality and inventory health steering."
  source: "`grocery_ecm`.`fulfillment`.`fulfillment_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the fulfillment order line (e.g. picked, packed, short, cancelled). Drives line-level exception management."
    - name: "pick_zone"
      expr: pick_zone
      comment: "Warehouse pick zone where the item was located. Used to identify zone-level pick performance bottlenecks."
    - name: "cold_chain_zone"
      expr: cold_chain_zone
      comment: "Cold-chain temperature zone for the line item (ambient, chilled, frozen). Supports cold-chain compliance analysis."
    - name: "cancel_reason_code"
      expr: cancel_reason_code
      comment: "Reason code for line cancellation. Enables root-cause analysis of cancellation drivers."
    - name: "short_pick_reason"
      expr: short_pick_reason
      comment: "Reason recorded when a pick could not be fully fulfilled. Used to distinguish out-of-stock from process failures."
    - name: "substitution_allowed_flag"
      expr: substitution_allowed_flag
      comment: "Whether the customer permitted substitution for this line. Contextualises substitution rate calculations."
    - name: "substitution_made_flag"
      expr: substitution_made_flag
      comment: "Whether a substitution was actually made on this line. Direct indicator of inventory availability gaps."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the line item is classified as hazardous material. Required for regulatory compliance reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item quantity (each, kg, lb). Ensures correct quantity aggregation context."
    - name: "pick_date"
      expr: DATE_TRUNC('day', pick_start_timestamp)
      comment: "Calendar day picking began for this line. Primary time grain for daily pick throughput reporting."
    - name: "pack_date"
      expr: DATE_TRUNC('day', pack_timestamp)
      comment: "Calendar day the line was packed. Used to track pack throughput trends."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of fulfillment order lines processed. Baseline throughput metric for warehouse operations."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Drives demand signal and capacity planning."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units successfully picked. Compared against ordered quantity to compute pick fulfilment rate."
    - name: "total_packed_quantity"
      expr: SUM(CAST(packed_quantity AS DOUBLE))
      comment: "Total units packed and ready for dispatch. Measures pack throughput and identifies pack-vs-pick gaps."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total units allocated to fulfillment lines. Used to assess inventory reservation accuracy."
    - name: "pick_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was successfully picked. Core operational KPI — low fill rate signals inventory or process failures directly impacting customer satisfaction."
    - name: "pack_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(packed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was packed. Measures end-to-end fulfilment completeness from order to dispatch."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_made_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines where a substitution was made. High substitution rates indicate chronic inventory availability issues requiring assortment or replenishment action."
    - name: "short_pick_line_count"
      expr: COUNT(CASE WHEN picked_quantity < ordered_quantity THEN 1 END)
      comment: "Number of lines where picked quantity fell short of ordered quantity. Directly measures out-of-stock and pick failure exposure."
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue value across all fulfillment order lines. Connects operational fulfilment performance to financial outcomes."
    - name: "avg_line_revenue"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average revenue per fulfillment order line. Used to identify high-value line segments and prioritise fulfilment resources."
    - name: "total_actual_weight"
      expr: SUM(CAST(weight_actual AS DOUBLE))
      comment: "Total actual weight of all packed line items. Used for freight cost reconciliation and carrier billing validation."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level KPIs covering delivery performance, freight cost efficiency, cold-chain compliance, and carrier reliability. Core metrics for last-mile logistics steering and carrier contract management."
  source: "`grocery_ecm`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. in-transit, delivered, failed, returned). Primary dimension for delivery performance triage."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g. customer delivery, store transfer, wholesale). Enables performance segmentation by shipment category."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the shipment (ambient, chilled, frozen). Critical for cold-chain compliance monitoring."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination (e.g. residential, commercial, store). Used to benchmark delivery performance by destination category."
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (e.g. DC, store, supplier). Supports network flow analysis."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Whether the shipment requires cold-chain handling. Enables cold-chain compliance rate calculation."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the shipment contains hazardous materials. Required for regulatory and safety compliance reporting."
    - name: "delivery_outcome"
      expr: delivery_outcome
      comment: "Final outcome of the delivery attempt (e.g. delivered, failed, returned). Drives last-mile performance analysis."
    - name: "scheduled_ship_date"
      expr: DATE_TRUNC('day', scheduled_ship_date)
      comment: "Scheduled ship date. Used to align shipment volume with planned carrier capacity."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('day', scheduled_delivery_date)
      comment: "Scheduled delivery date. Primary time dimension for on-time delivery performance reporting."
    - name: "ship_month"
      expr: DATE_TRUNC('month', actual_ship_timestamp)
      comment: "Month the shipment was actually dispatched. Used for monthly freight cost and volume trend analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline volume metric for last-mile capacity and carrier utilisation planning."
    - name: "delivered_shipment_count"
      expr: COUNT(CASE WHEN delivery_outcome = 'DELIVERED' THEN 1 END)
      comment: "Number of shipments successfully delivered. Core delivery success metric used in carrier scorecards."
    - name: "failed_delivery_count"
      expr: COUNT(CASE WHEN delivery_outcome = 'FAILED' THEN 1 END)
      comment: "Number of shipments with a failed delivery attempt. Elevated failure rates trigger carrier review and re-delivery cost analysis."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_timestamp <= estimated_delivery_timestamp THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of delivered shipments where actual delivery was on or before the estimated delivery time. Premier last-mile KPI for SLA compliance and customer satisfaction management."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all shipments. Primary cost driver in last-mile logistics; used for carrier contract negotiation and cost-per-shipment benchmarking."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarked against carrier contracts to identify cost overruns and renegotiation opportunities."
    - name: "total_shipment_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight shipped in pounds. Used for freight cost per pound analysis and carrier capacity utilisation."
    - name: "total_shipment_volume_cubic_ft"
      expr: SUM(CAST(total_volume_cubic_ft AS DOUBLE))
      comment: "Total cubic footage shipped. Supports vehicle load factor analysis and route density optimisation."
    - name: "multi_attempt_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(delivery_attempt_count AS BIGINT) > 1 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments requiring more than one delivery attempt. High rates indicate address quality, access, or carrier execution issues driving incremental cost."
    - name: "cold_chain_shipment_count"
      expr: COUNT(CASE WHEN cold_chain_required_flag = TRUE THEN 1 END)
      comment: "Number of shipments requiring cold-chain handling. Used to size cold-chain carrier capacity and monitor compliance exposure."
    - name: "proof_of_delivery_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN proof_of_delivery_signature_captured_flag = TRUE OR proof_of_delivery_photo_captured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with proof-of-delivery captured (signature or photo). Low capture rates increase dispute and fraud risk, impacting revenue recovery."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route-level logistics KPIs measuring cost efficiency, on-time performance, load utilisation, and SLA compliance. Used by logistics operations and network planning teams to optimise last-mile route design."
  source: "`grocery_ecm`.`fulfillment`.`delivery_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the delivery route (e.g. planned, in-progress, completed, cancelled). Primary operational triage dimension."
    - name: "route_type"
      expr: route_type
      comment: "Type of route (e.g. delivery, pickup, transfer). Enables performance segmentation by route category."
    - name: "service_level"
      expr: service_level
      comment: "Service level associated with the route (e.g. same-day, next-day). Used to assess whether route execution meets service commitments."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone handled on the route (ambient, chilled, frozen). Supports cold-chain route compliance analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the route met its SLA target. Enables direct SLA compliance rate calculation."
    - name: "optimization_source"
      expr: optimization_source
      comment: "System or method used to optimise the route (e.g. manual, algorithmic). Used to evaluate optimisation tool effectiveness."
    - name: "route_date"
      expr: DATE_TRUNC('day', route_date)
      comment: "Date the route was executed. Primary time grain for daily route performance reporting."
    - name: "route_month"
      expr: DATE_TRUNC('month', route_date)
      comment: "Month the route was executed. Used for monthly cost and performance trend analysis."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of delivery routes executed. Baseline volume metric for network capacity and driver utilisation planning."
    - name: "sla_compliant_route_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of routes that met their SLA target. Core service quality metric for last-mile operations."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of routes meeting SLA targets. Premier route-level KPI for service quality steering and carrier accountability."
    - name: "total_route_cost"
      expr: SUM(CAST(route_cost_amount AS DOUBLE))
      comment: "Total cost across all delivery routes. Primary cost driver for last-mile logistics; used for budget management and cost-per-stop benchmarking."
    - name: "total_fuel_cost"
      expr: SUM(CAST(fuel_cost_amount AS DOUBLE))
      comment: "Total fuel cost across all routes. Monitored against fuel surcharge recovery and used to evaluate route efficiency improvements."
    - name: "avg_route_cost"
      expr: AVG(CAST(route_cost_amount AS DOUBLE))
      comment: "Average cost per delivery route. Benchmarked against targets to identify high-cost routes requiring optimisation."
    - name: "total_distance_miles"
      expr: SUM(CAST(actual_distance_miles AS DOUBLE))
      comment: "Total miles driven across all routes. Used to compute cost-per-mile and assess route density efficiency."
    - name: "avg_distance_per_route_miles"
      expr: AVG(CAST(actual_distance_miles AS DOUBLE))
      comment: "Average distance per route in miles. Longer average distances signal route density issues or suboptimal network design."
    - name: "total_route_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight loaded across all routes in pounds. Used to assess vehicle load utilisation and identify under-loaded routes."
    - name: "total_route_volume_cubic_ft"
      expr: SUM(CAST(total_volume_cubic_feet AS DOUBLE))
      comment: "Total cubic footage loaded across all routes. Supports vehicle capacity utilisation analysis."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across routes. Aggregated route-level OTD metric used in carrier performance scorecards and executive dashboards."
    - name: "cost_per_mile"
      expr: ROUND(SUM(CAST(route_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_distance_miles AS DOUBLE)), 0), 4)
      comment: "Total route cost divided by total miles driven. Efficiency ratio used to benchmark carrier and route cost performance; declining cost-per-mile indicates improving route density."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wave-level warehouse execution KPIs measuring pick throughput, fill rates, cold-chain compliance, and rush-wave frequency. Used by warehouse operations managers and supply-chain executives to optimise wave planning and labour allocation."
  source: "`grocery_ecm`.`fulfillment`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave (e.g. planned, in-progress, completed, cancelled). Primary operational triage dimension."
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g. standard, rush, replenishment). Used to segment performance by wave category."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone handled in the wave (ambient, chilled, frozen). Supports cold-chain compliance analysis."
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method used in the wave (e.g. batch, zone, single). Used to compare efficiency across picking strategies."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to the wave. Used to assess whether high-priority waves are executed ahead of standard waves."
    - name: "is_rush_wave"
      expr: is_rush_wave
      comment: "Whether the wave was flagged as a rush wave. High rush-wave frequency signals planning failures or demand volatility."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Whether the wave maintained cold-chain compliance throughout execution. Non-compliant waves represent food safety and regulatory risk."
    - name: "facility_zone"
      expr: facility_zone
      comment: "Facility zone where the wave was executed. Enables zone-level throughput and efficiency benchmarking."
    - name: "wave_release_date"
      expr: DATE_TRUNC('day', released_timestamp)
      comment: "Date the wave was released for picking. Primary time grain for daily wave throughput reporting."
    - name: "wave_month"
      expr: DATE_TRUNC('month', released_timestamp)
      comment: "Month the wave was released. Used for monthly throughput and efficiency trend analysis."
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of waves executed. Baseline throughput metric for warehouse capacity planning."
    - name: "total_wave_orders"
      expr: SUM(CAST(total_orders AS DOUBLE))
      comment: "Total orders processed across all waves. Measures warehouse order throughput and informs labour and equipment planning."
    - name: "total_wave_lines"
      expr: SUM(CAST(total_lines AS DOUBLE))
      comment: "Total order lines processed across all waves. More granular throughput metric than order count; drives pick labour planning."
    - name: "total_wave_units"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total units picked across all waves. Core warehouse throughput KPI used in units-per-hour productivity benchmarking."
    - name: "total_wave_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight processed across all waves in kilograms. Used for equipment load planning and ergonomic risk assessment."
    - name: "total_wave_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total cubic volume processed across all waves. Supports storage and staging capacity planning."
    - name: "avg_wave_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percent AS DOUBLE))
      comment: "Average fill rate percentage across waves. Low fill rates indicate inventory availability or wave planning failures directly impacting order completeness."
    - name: "rush_wave_count"
      expr: COUNT(CASE WHEN is_rush_wave = TRUE THEN 1 END)
      comment: "Number of rush waves executed. High rush-wave frequency is a leading indicator of planning inefficiency and elevated labour costs."
    - name: "rush_wave_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rush_wave = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waves classified as rush. Executives use this to assess planning maturity — high rates signal reactive operations and cost inefficiency."
    - name: "cold_chain_non_compliant_wave_count"
      expr: COUNT(CASE WHEN is_cold_chain_compliant = FALSE THEN 1 END)
      comment: "Number of waves that failed cold-chain compliance. Each non-compliant wave represents food safety risk, potential regulatory breach, and product write-off exposure."
    - name: "avg_orders_per_wave"
      expr: AVG(CAST(total_orders AS DOUBLE))
      comment: "Average number of orders per wave. Used to assess wave sizing efficiency — very low averages indicate under-utilised waves driving excess labour cost."
    - name: "avg_units_per_wave"
      expr: AVG(CAST(total_units AS DOUBLE))
      comment: "Average units per wave. Benchmarked against wave capacity targets to identify under- or over-loaded waves."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack task KPIs measuring packing throughput, SLA compliance, quality control outcomes, and exception rates. Used by warehouse operations to monitor pack station performance and identify bottlenecks in the order fulfilment pipeline."
  source: "`grocery_ecm`.`fulfillment`.`pack_task`"
  dimensions:
    - name: "pack_task_status"
      expr: pack_task_status
      comment: "Current status of the pack task (e.g. pending, in-progress, completed, exception). Primary triage dimension for pack operations."
    - name: "container_type"
      expr: container_type
      comment: "Type of container used for packing (e.g. box, bag, tote). Used to analyse container utilisation and cost."
    - name: "pack_station_code"
      expr: pack_station_code
      comment: "Identifier of the pack station where the task was executed. Enables station-level throughput and quality benchmarking."
    - name: "service_level_code"
      expr: service_level_code
      comment: "Service level code for the pack task. Used to segment SLA compliance by service tier."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the pack task was completed within its SLA target time. Core quality metric for pack operations."
    - name: "qc_check_status"
      expr: qc_check_status
      comment: "Quality control check outcome for the pack task (e.g. passed, failed, skipped). Drives quality assurance reporting."
    - name: "pack_exception_code"
      expr: pack_exception_code
      comment: "Exception code recorded against the pack task. Used to categorise and prioritise exception resolution."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether a substitution was made during packing. Contextualises substitution impact on pack throughput."
    - name: "pack_date"
      expr: DATE_TRUNC('day', pack_start_timestamp)
      comment: "Date packing began. Primary time grain for daily pack throughput reporting."
    - name: "pack_month"
      expr: DATE_TRUNC('month', pack_start_timestamp)
      comment: "Month packing began. Used for monthly pack performance trend analysis."
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total number of pack tasks executed. Baseline throughput metric for pack station capacity planning."
    - name: "sla_compliant_pack_task_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of pack tasks completed within SLA. Core service quality metric for pack operations management."
    - name: "pack_sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pack tasks meeting SLA targets. Low compliance rates indicate pack station bottlenecks or staffing gaps impacting order dispatch timelines."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_check_status = 'PASSED' THEN 1 END) / NULLIF(COUNT(CASE WHEN qc_check_status IS NOT NULL AND qc_check_status != 'SKIPPED' THEN 1 END), 0), 2)
      comment: "Percentage of quality-checked pack tasks that passed QC. Low pass rates signal packing quality issues that increase customer complaints and returns."
    - name: "pack_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pack_exception_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pack tasks with an exception recorded. High exception rates indicate systemic packing process failures requiring operational intervention."
    - name: "total_container_weight_kg"
      expr: SUM(CAST(container_weight_kg AS DOUBLE))
      comment: "Total weight of packed containers in kilograms. Used for freight cost estimation and carrier handoff planning."
    - name: "avg_container_weight_kg"
      expr: AVG(CAST(container_weight_kg AS DOUBLE))
      comment: "Average packed container weight in kilograms. Benchmarked against carrier weight limits to prevent overweight shipments."
    - name: "label_print_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN label_printed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pack tasks where a shipping label was printed. Low rates indicate dispatch readiness failures that delay carrier handoff."
    - name: "substitution_pack_task_count"
      expr: COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END)
      comment: "Number of pack tasks involving a substituted item. Used to quantify substitution volume impact on pack throughput and customer experience."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_pickup_staging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Curbside and in-store pickup staging KPIs measuring customer wait times, SLA compliance, handoff quality, and cold-chain staging compliance. Used by store operations and omnichannel teams to optimise the pickup customer experience."
  source: "`grocery_ecm`.`fulfillment`.`pickup_staging`"
  dimensions:
    - name: "staging_status"
      expr: staging_status
      comment: "Current status of the pickup staging record (e.g. staged, handed-off, exception). Primary operational triage dimension."
    - name: "check_in_method"
      expr: check_in_method
      comment: "Method used by the customer to check in for pickup (e.g. app, text, in-store). Used to analyse check-in channel adoption and efficiency."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used at pickup. Supports payment channel analysis and fraud risk monitoring."
    - name: "staging_exception_type"
      expr: staging_exception_type
      comment: "Type of exception recorded during staging (e.g. missing item, temperature breach). Drives root-cause analysis of staging failures."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the pickup SLA was met. Core service quality dimension for pickup operations."
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Whether temperature compliance was maintained during staging. Non-compliance represents food safety and regulatory risk."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the customer is a loyalty programme member. Enables loyalty vs. non-loyalty pickup experience comparison."
    - name: "prescription_included_flag"
      expr: prescription_included_flag
      comment: "Whether the pickup order includes a pharmacy prescription. Supports pharmacy pickup SLA and compliance reporting."
    - name: "age_verified_flag"
      expr: age_verified_flag
      comment: "Whether age verification was completed at handoff. Required for alcohol and tobacco regulatory compliance reporting."
    - name: "pickup_date"
      expr: DATE_TRUNC('day', customer_arrival_timestamp)
      comment: "Date the customer arrived for pickup. Primary time grain for daily pickup volume and SLA reporting."
    - name: "pickup_month"
      expr: DATE_TRUNC('month', customer_arrival_timestamp)
      comment: "Month of customer pickup arrival. Used for monthly pickup trend and SLA compliance analysis."
  measures:
    - name: "total_pickup_orders"
      expr: COUNT(1)
      comment: "Total number of pickup staging events. Baseline volume metric for pickup capacity planning and staffing."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Number of pickup orders where the SLA was met. Core service quality metric for curbside and in-store pickup operations."
    - name: "pickup_sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pickup orders meeting SLA targets. Premier pickup KPI — low compliance directly impacts customer satisfaction scores and loyalty retention."
    - name: "temperature_non_compliant_count"
      expr: COUNT(CASE WHEN temperature_compliance_flag = FALSE THEN 1 END)
      comment: "Number of pickup orders with a temperature compliance failure during staging. Each failure represents food safety risk and potential regulatory breach."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pickup orders maintaining temperature compliance during staging. Critical food safety KPI monitored by operations and compliance teams."
    - name: "staging_exception_count"
      expr: COUNT(CASE WHEN staging_exception_type IS NOT NULL THEN 1 END)
      comment: "Number of pickup orders with a staging exception recorded. High exception rates signal process failures requiring operational intervention."
    - name: "staging_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN staging_exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pickup orders with a staging exception. Used to benchmark staging quality across nodes and identify systemic issues."
    - name: "loyalty_member_pickup_count"
      expr: COUNT(CASE WHEN loyalty_member_flag = TRUE THEN 1 END)
      comment: "Number of pickup orders from loyalty programme members. Used to assess loyalty programme engagement with the pickup channel."
    - name: "age_verification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN age_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN alcohol_verification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of age-restricted pickup orders where age verification was completed. Regulatory compliance KPI — failures expose the business to licensing and legal risk."
    - name: "signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_signature_captured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pickup orders where a customer signature was captured at handoff. Low rates increase dispute and liability risk for high-value or regulated items."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master KPIs measuring delivery reliability, damage claim exposure, transit time performance, and contract coverage. Used by procurement and logistics leadership for carrier selection, contract negotiation, and performance management."
  source: "`grocery_ecm`.`fulfillment`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g. parcel, LTL, FTL, last-mile). Enables performance benchmarking within carrier category."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Operational status of the carrier (e.g. active, suspended, terminated). Used to filter active carrier performance analysis."
    - name: "preferred_carrier_tier"
      expr: preferred_carrier_tier
      comment: "Preferred tier classification of the carrier (e.g. tier-1, tier-2, spot). Used to assess whether preferred carriers outperform spot carriers."
    - name: "cold_chain_certified_flag"
      expr: cold_chain_certified_flag
      comment: "Whether the carrier holds cold-chain certification. Critical for routing cold-chain orders to compliant carriers."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the carrier is certified to handle hazardous materials. Required for regulatory compliance in hazmat shipment routing."
    - name: "geographic_coverage_zones"
      expr: geographic_coverage_zones
      comment: "Geographic zones covered by the carrier. Used to assess carrier network coverage and identify coverage gaps."
    - name: "service_level_offered"
      expr: service_level_offered
      comment: "Service levels offered by the carrier (e.g. same-day, next-day, standard). Supports service-level-based carrier selection analysis."
    - name: "contract_expiration_date"
      expr: DATE_TRUNC('month', contract_expiration_date)
      comment: "Month of carrier contract expiration. Used to proactively identify contracts requiring renegotiation."
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network. Baseline metric for carrier network breadth and diversification analysis."
    - name: "active_carrier_count"
      expr: COUNT(CASE WHEN carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active carriers. Used to assess carrier network capacity and single-source dependency risk."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on-time delivery rate across carriers. Premier carrier performance KPI used in quarterly business reviews and contract renewal decisions."
    - name: "avg_damage_claim_rate_pct"
      expr: AVG(CAST(damage_claim_rate_percent AS DOUBLE))
      comment: "Average damage claim rate across carriers. High rates drive insurance cost increases and customer satisfaction degradation — triggers carrier performance review."
    - name: "avg_transit_time_days"
      expr: AVG(CAST(average_transit_time_days AS DOUBLE))
      comment: "Average transit time in days across carriers. Used to benchmark carrier speed performance against service level commitments."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_limit_amount AS DOUBLE))
      comment: "Total insurance coverage limit across all carriers. Used to assess aggregate liability exposure in the carrier network."
    - name: "cold_chain_certified_carrier_count"
      expr: COUNT(CASE WHEN cold_chain_certified_flag = TRUE THEN 1 END)
      comment: "Number of cold-chain certified carriers. Used to assess cold-chain routing capacity and identify coverage gaps for temperature-sensitive shipments."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN contract_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND carrier_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active carrier contracts expiring within 90 days. Proactive risk metric — expiring contracts without renewal create carrier capacity gaps and cost exposure."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fulfillment_wms_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WMS task-level KPIs measuring warehouse task throughput, pick accuracy, substitution rates, damage exposure, and SLA compliance. Used by warehouse operations managers to optimise labour productivity and task execution quality."
  source: "`grocery_ecm`.`fulfillment`.`wms_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of WMS task (e.g. pick, putaway, replenishment, cycle-count). Primary dimension for task-type performance benchmarking."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the WMS task (e.g. assigned, in-progress, completed, exception). Drives operational triage and exception management."
    - name: "task_method"
      expr: task_method
      comment: "Method used to execute the task (e.g. manual, RF-guided, voice, robotic). Used to compare productivity across task execution methods."
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method for pick tasks (e.g. batch, zone, single). Used to evaluate pick method efficiency."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the task. Used to assess whether high-priority tasks are completed ahead of standard tasks."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the task (ambient, chilled, frozen). Supports cold-chain task compliance analysis."
    - name: "cold_chain_flag"
      expr: cold_chain_flag
      comment: "Whether the task involves cold-chain handling. Enables cold-chain task volume and compliance tracking."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Whether damage was recorded during task execution. Used to identify damage hotspots by zone, method, or task type."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether a substitution was made during the task. Contextualises substitution volume at the task level."
    - name: "task_date"
      expr: DATE_TRUNC('day', task_created_timestamp)
      comment: "Date the task was created. Primary time grain for daily task throughput reporting."
    - name: "task_month"
      expr: DATE_TRUNC('month', task_created_timestamp)
      comment: "Month the task was created. Used for monthly throughput and quality trend analysis."
  measures:
    - name: "total_wms_tasks"
      expr: COUNT(1)
      comment: "Total number of WMS tasks executed. Baseline throughput metric for warehouse labour planning and productivity benchmarking."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total units actually processed across all WMS tasks. Core throughput metric for warehouse productivity measurement."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total target units planned across all WMS tasks. Compared against actual quantity to compute task fulfilment accuracy."
    - name: "task_quantity_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target quantity actually fulfilled across WMS tasks. Low accuracy rates indicate pick errors, inventory discrepancies, or process failures impacting order completeness."
    - name: "damage_task_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of WMS tasks where damage was recorded. Elevated damage counts drive product write-off costs and customer complaint rates."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WMS tasks with damage recorded. Key quality KPI — high damage rates signal handling process failures requiring immediate operational intervention."
    - name: "substitution_task_count"
      expr: COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END)
      comment: "Number of WMS tasks involving a substitution. Used to quantify substitution volume and its impact on pick throughput."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WMS tasks involving a substitution. High rates indicate chronic inventory availability issues requiring assortment or replenishment action."
    - name: "total_travel_distance_feet"
      expr: SUM(CAST(travel_distance_feet AS DOUBLE))
      comment: "Total travel distance in feet across all WMS tasks. Used to assess warehouse layout efficiency — high travel distances indicate suboptimal slotting or pick path design."
    - name: "avg_travel_distance_per_task_feet"
      expr: AVG(CAST(travel_distance_feet AS DOUBLE))
      comment: "Average travel distance per WMS task in feet. Benchmarked against layout optimisation targets; reductions directly improve labour productivity."
$$;