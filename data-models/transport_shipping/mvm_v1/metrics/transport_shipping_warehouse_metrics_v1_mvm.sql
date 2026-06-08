-- Metric views for domain: warehouse | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance metrics tracking receipt accuracy, timeliness, and operational efficiency for warehouse receiving operations"
  source: "`transport_shipping_ecm`.`warehouse`.`inbound_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the inbound receipt (e.g., scheduled, in-progress, completed, discrepancy)"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt (e.g., purchase order, return, transfer)"
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where goods were received"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier that delivered the shipment"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month when goods were actually received"
    - name: "receipt_date"
      expr: DATE(actual_arrival_timestamp)
      comment: "Date when goods were actually received"
    - name: "has_discrepancy"
      expr: discrepancy_flag
      comment: "Whether the receipt had any discrepancies between expected and actual"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether the receipt contained hazardous materials"
    - name: "is_cross_dock"
      expr: cross_dock_flag
      comment: "Whether the receipt was designated for cross-docking"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection for the receipt"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts processed"
    - name: "total_weight_received_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods received in kilograms"
    - name: "total_volume_received_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume of goods received in cubic meters"
    - name: "avg_weight_per_receipt_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per receipt in kilograms"
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with discrepancies between expected and actual quantities"
    - name: "on_time_receipt_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= scheduled_arrival_timestamp THEN 1 END) / NULLIF(COUNT(CASE WHEN scheduled_arrival_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of receipts that arrived on or before scheduled time"
    - name: "avg_unloading_duration_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(unloading_end_timestamp) - UNIX_TIMESTAMP(unloading_start_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes to unload goods from arrival to completion"
    - name: "avg_receipt_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(receipt_completed_timestamp) - UNIX_TIMESTAMP(actual_arrival_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from arrival to receipt completion"
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection"
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN temperature_compliant_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of temperature-controlled receipts that maintained required temperature"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_outbound_shipment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound fulfillment performance metrics tracking order processing speed, accuracy, and on-time delivery performance"
  source: "`transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound shipment order"
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g., standard, express, return)"
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility fulfilling the order"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier assigned to deliver the shipment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (e.g., standard, expedited, urgent)"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_received_timestamp)
      comment: "Month when order was received"
    - name: "order_date"
      expr: DATE(order_received_timestamp)
      comment: "Date when order was received"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country for the shipment"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the order contains hazardous materials"
    - name: "on_time_delivery_flag"
      expr: otd_flag
      comment: "Whether the order was delivered on time"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of outbound shipment orders"
    - name: "total_weight_shipped_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods shipped in kilograms"
    - name: "total_volume_shipped_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume of goods shipped in cubic meters"
    - name: "avg_weight_per_order_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per order in kilograms"
    - name: "avg_lines_per_order"
      expr: AVG(CAST(total_line_count AS DOUBLE))
      comment: "Average number of line items per order"
    - name: "avg_units_per_order"
      expr: AVG(CAST(total_unit_count AS DOUBLE))
      comment: "Average number of units per order"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN otd_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN otd_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of orders delivered on time per committed delivery date"
    - name: "avg_pick_to_pack_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(packed_timestamp) - UNIX_TIMESTAMP(picked_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from picking completion to packing completion"
    - name: "avg_order_to_dispatch_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(dispatched_timestamp) - UNIX_TIMESTAMP(order_received_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from order receipt to dispatch"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that were cancelled after being received"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight used for freight billing in kilograms"
    - name: "total_cod_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount for orders requiring COD payment"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_pick_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick wave execution metrics tracking picking efficiency, accuracy, and labor productivity for warehouse order fulfillment"
  source: "`transport_shipping_ecm`.`warehouse`.`pick_wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the pick wave (e.g., planned, released, in-progress, completed)"
    - name: "wave_type"
      expr: wave_type
      comment: "Type of pick wave (e.g., batch, discrete, cluster)"
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where pick wave was executed"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the wave (e.g., standard, expedited, urgent)"
    - name: "wave_month"
      expr: DATE_TRUNC('MONTH', actual_release_timestamp)
      comment: "Month when wave was released for picking"
    - name: "wave_date"
      expr: DATE(actual_release_timestamp)
      comment: "Date when wave was released for picking"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the wave contains hazardous materials"
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the wave requires temperature-controlled handling"
    - name: "carrier_service_type"
      expr: carrier_service_type
      comment: "Type of carrier service for the wave shipments"
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of pick waves executed"
    - name: "total_orders_picked"
      expr: SUM(CAST(total_order_count AS DOUBLE))
      comment: "Total number of orders picked across all waves"
    - name: "total_lines_picked"
      expr: SUM(CAST(total_line_count AS DOUBLE))
      comment: "Total number of order lines picked across all waves"
    - name: "total_units_picked"
      expr: SUM(CAST(total_unit_count AS DOUBLE))
      comment: "Total number of units picked across all waves"
    - name: "avg_orders_per_wave"
      expr: AVG(CAST(total_order_count AS DOUBLE))
      comment: "Average number of orders per pick wave"
    - name: "avg_lines_per_wave"
      expr: AVG(CAST(total_line_count AS DOUBLE))
      comment: "Average number of lines per pick wave"
    - name: "pick_accuracy_rate"
      expr: AVG(CAST(pick_accuracy_percentage AS DOUBLE))
      comment: "Average pick accuracy percentage across waves (correct picks / total picks)"
    - name: "avg_wave_cycle_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(actual_completion_timestamp) - UNIX_TIMESTAMP(actual_release_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from wave release to completion"
    - name: "avg_picking_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(picking_end_timestamp) - UNIX_TIMESTAMP(picking_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours spent on picking activities"
    - name: "labor_efficiency_units_per_hour"
      expr: ROUND(SUM(CAST(total_unit_count AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours_actual AS DOUBLE)), 0), 2)
      comment: "Units picked per labor hour (productivity metric)"
    - name: "labor_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_actual AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned labor hours actually used"
    - name: "short_pick_rate"
      expr: ROUND(100.0 * SUM(CAST(short_pick_count AS DOUBLE)) / NULLIF(SUM(CAST(total_line_count AS DOUBLE)), 0), 2)
      comment: "Percentage of lines that could not be fully picked due to inventory shortage"
    - name: "exception_rate"
      expr: ROUND(100.0 * SUM(CAST(exception_count AS DOUBLE)) / NULLIF(SUM(CAST(total_line_count AS DOUBLE)), 0), 2)
      comment: "Percentage of lines with exceptions during picking"
    - name: "total_weight_picked_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods picked in kilograms"
    - name: "total_volume_picked_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume of goods picked in cubic meters"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability metrics tracking stock levels, turnover, and inventory accuracy for warehouse inventory management"
  source: "`transport_shipping_ecm`.`warehouse`.`inventory_position`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility holding the inventory"
    - name: "sku_id"
      expr: sku_id
      comment: "Stock keeping unit identifier"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of inventory (e.g., available, reserved, quarantine, damaged)"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account owning the inventory (for 3PL operations)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the goods originated"
    - name: "is_hazmat"
      expr: hazmat_indicator
      comment: "Whether the inventory item is hazardous material"
    - name: "is_temperature_controlled"
      expr: temperature_controlled_indicator
      comment: "Whether the inventory requires temperature-controlled storage"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', last_updated_timestamp)
      comment: "Month of the inventory position snapshot"
    - name: "has_hold"
      expr: CASE WHEN hold_id IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether the inventory position has an active hold"
  measures:
    - name: "total_inventory_positions"
      expr: COUNT(1)
      comment: "Total number of distinct inventory positions (SKU-location combinations)"
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand quantity across all inventory positions"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity (on-hand minus reserved and holds)"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for orders but not yet picked"
    - name: "total_hold_quantity"
      expr: SUM(CAST(hold_quantity AS DOUBLE))
      comment: "Total quantity on hold (quality, customs, or other restrictions)"
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity marked as damaged or unsellable"
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity in quarantine pending inspection or clearance"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity in transit to the facility"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for fulfillment"
    - name: "inventory_hold_rate"
      expr: ROUND(100.0 * SUM(CAST(hold_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is on hold"
    - name: "inventory_damage_rate"
      expr: ROUND(100.0 * SUM(CAST(damaged_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is damaged"
    - name: "total_inventory_value"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE) * CAST(cost_per_unit AS DOUBLE))
      comment: "Total value of on-hand inventory at cost"
    - name: "total_available_inventory_value"
      expr: SUM(CAST(available_quantity AS DOUBLE) * CAST(cost_per_unit AS DOUBLE))
      comment: "Total value of available inventory at cost"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across inventory positions"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and execution metrics tracking inventory accuracy, variance, and audit compliance for warehouse inventory control"
  source: "`transport_shipping_ecm`.`warehouse`.`cycle_count`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where cycle count was performed"
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g., scheduled, in-progress, completed, approved)"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., ABC, random, full, targeted)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., manual, RF scan, automated)"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_start_timestamp)
      comment: "Month when cycle count was started"
    - name: "count_date"
      expr: DATE(count_start_timestamp)
      comment: "Date when cycle count was started"
    - name: "recount_required"
      expr: recount_required
      comment: "Whether a recount was required due to variance"
    - name: "is_regulatory_audit"
      expr: regulatory_audit_flag
      comment: "Whether the count was part of a regulatory audit"
    - name: "is_hazmat"
      expr: hazmat_count_flag
      comment: "Whether the count included hazardous materials"
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count events executed"
    - name: "total_locations_counted"
      expr: SUM(CAST(total_locations_counted AS DOUBLE))
      comment: "Total number of storage locations counted"
    - name: "total_skus_counted"
      expr: SUM(CAST(total_skus_counted AS DOUBLE))
      comment: "Total number of SKUs counted"
    - name: "total_units_counted"
      expr: SUM(CAST(total_units_counted AS DOUBLE))
      comment: "Total number of units counted"
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage (counted matches system)"
    - name: "avg_locations_per_count"
      expr: AVG(CAST(total_locations_counted AS DOUBLE))
      comment: "Average number of locations counted per cycle count event"
    - name: "recount_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts that required a recount due to variance"
    - name: "avg_count_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(count_end_timestamp) - UNIX_TIMESTAMP(count_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours to complete a cycle count"
    - name: "avg_labor_hours_per_count"
      expr: AVG(CAST(labor_hours_actual AS DOUBLE))
      comment: "Average labor hours spent per cycle count"
    - name: "total_variance_value_usd"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total financial value of inventory variances found in USD"
    - name: "avg_variance_value_usd"
      expr: AVG(CAST(variance_value_usd AS DOUBLE))
      comment: "Average financial value of variance per cycle count in USD"
    - name: "adjustment_posted_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_posted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts where inventory adjustments were posted to the system"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_putaway_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Putaway execution and efficiency metrics tracking putaway speed, accuracy, and labor productivity for warehouse receiving operations"
  source: "`transport_shipping_ecm`.`warehouse`.`putaway_task`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where putaway was performed"
    - name: "task_status"
      expr: task_status
      comment: "Status of the putaway task (e.g., assigned, in-progress, completed, cancelled)"
    - name: "task_type"
      expr: task_type
      comment: "Type of putaway task (e.g., directed, system-suggested, manual)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the putaway task"
    - name: "putaway_month"
      expr: DATE_TRUNC('MONTH', completed_timestamp)
      comment: "Month when putaway was completed"
    - name: "putaway_date"
      expr: DATE(completed_timestamp)
      comment: "Date when putaway was completed"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether the putaway task involved hazardous materials"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone where goods were put away"
    - name: "is_system_directed"
      expr: system_directed_flag
      comment: "Whether the putaway location was system-directed vs manual"
    - name: "quality_check_required"
      expr: quality_check_required
      comment: "Whether quality check was required before putaway"
  measures:
    - name: "total_putaway_tasks"
      expr: COUNT(1)
      comment: "Total number of putaway tasks executed"
    - name: "total_quantity_putaway"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units put away"
    - name: "total_weight_putaway_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of goods put away in kilograms"
    - name: "total_volume_putaway_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of goods put away in cubic meters"
    - name: "avg_quantity_per_task"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per putaway task"
    - name: "avg_task_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE) / 60.0)
      comment: "Average time in minutes to complete a putaway task"
    - name: "avg_travel_distance_meters"
      expr: AVG(CAST(travel_distance_meters AS DOUBLE))
      comment: "Average travel distance in meters per putaway task"
    - name: "putaway_efficiency_units_per_hour"
      expr: ROUND(SUM(CAST(quantity AS DOUBLE)) / NULLIF(SUM(CAST(duration_seconds AS DOUBLE) / 3600.0), 0), 2)
      comment: "Units put away per hour (productivity metric)"
    - name: "task_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of putaway tasks successfully completed"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of putaway tasks that were cancelled"
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of putaway tasks with exceptions"
    - name: "system_directed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN system_directed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of putaway tasks that were system-directed"
    - name: "avg_time_to_start_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(started_timestamp) - UNIX_TIMESTAMP(assigned_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from task assignment to start"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick task execution and accuracy metrics tracking picking speed, accuracy, and labor productivity for warehouse order fulfillment"
  source: "`transport_shipping_ecm`.`warehouse`.`pick_task`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where picking was performed"
    - name: "task_status"
      expr: task_status
      comment: "Status of the pick task (e.g., assigned, in-progress, completed, cancelled)"
    - name: "pick_type"
      expr: pick_type
      comment: "Type of pick (e.g., discrete, batch, cluster, zone)"
    - name: "pick_method"
      expr: pick_method
      comment: "Method used for picking (e.g., RF scan, voice, pick-to-light)"
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the pick task"
    - name: "pick_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month when pick task was completed"
    - name: "pick_date"
      expr: DATE(completion_timestamp)
      comment: "Date when pick task was completed"
    - name: "zone_code"
      expr: zone_code
      comment: "Warehouse zone where picking occurred"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether the pick task involved hazardous materials"
    - name: "has_short_pick"
      expr: CASE WHEN short_pick_quantity > 0 THEN TRUE ELSE FALSE END
      comment: "Whether the task had a short pick (could not fulfill full quantity)"
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks executed"
    - name: "total_quantity_picked"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity of units picked"
    - name: "total_quantity_requested"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity of units requested to be picked"
    - name: "total_short_pick_quantity"
      expr: SUM(CAST(short_pick_quantity AS DOUBLE))
      comment: "Total quantity of units that could not be picked (short picks)"
    - name: "pick_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity successfully picked (first-time fill rate)"
    - name: "short_pick_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN short_pick_quantity > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks with short picks"
    - name: "avg_task_duration_seconds"
      expr: AVG(CAST(task_duration_seconds AS DOUBLE))
      comment: "Average time in seconds to complete a pick task"
    - name: "avg_travel_distance_meters"
      expr: AVG(CAST(travel_distance_meters AS DOUBLE))
      comment: "Average travel distance in meters per pick task"
    - name: "pick_efficiency_units_per_hour"
      expr: ROUND(SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(task_duration_seconds AS DOUBLE) / 3600.0), 0), 2)
      comment: "Units picked per hour (productivity metric)"
    - name: "task_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks successfully completed"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks that were cancelled"
    - name: "replenishment_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN replenishment_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pick tasks that triggered a replenishment"
    - name: "total_weight_picked_kg"
      expr: SUM(CAST(weight_picked_kg AS DOUBLE))
      comment: "Total weight of goods picked in kilograms"
    - name: "total_volume_picked_cbm"
      expr: SUM(CAST(volume_picked_cbm AS DOUBLE))
      comment: "Total volume of goods picked in cubic meters"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse facility capacity and sustainability metrics tracking facility utilization, certifications, and environmental performance"
  source: "`transport_shipping_ecm`.`warehouse`.`facility`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Unique identifier for the warehouse facility"
    - name: "facility_code"
      expr: facility_code
      comment: "Business code for the facility"
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the warehouse facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., distribution center, fulfillment center, cross-dock)"
    - name: "country_code"
      expr: country_code
      comment: "Country where facility is located"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "is_customs_bonded"
      expr: customs_bonded_warehouse
      comment: "Whether the facility is a customs bonded warehouse"
    - name: "is_iso9001_certified"
      expr: is_iso9001_certified
      comment: "Whether the facility has ISO 9001 quality certification"
    - name: "is_iso28000_certified"
      expr: is_iso28000_certified
      comment: "Whether the facility has ISO 28000 supply chain security certification"
    - name: "is_ctpat_certified"
      expr: is_ctpat_certified
      comment: "Whether the facility is C-TPAT certified (US customs security)"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of warehouse facilities"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total floor area across all facilities in square meters"
    - name: "total_storage_capacity_cbm"
      expr: SUM(CAST(storage_capacity_cbm AS DOUBLE))
      comment: "Total storage capacity across all facilities in cubic meters"
    - name: "avg_floor_area_sqm"
      expr: AVG(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Average floor area per facility in square meters"
    - name: "avg_storage_capacity_cbm"
      expr: AVG(CAST(storage_capacity_cbm AS DOUBLE))
      comment: "Average storage capacity per facility in cubic meters"
    - name: "total_dock_doors"
      expr: SUM(CAST(dock_door_count AS DOUBLE))
      comment: "Total number of dock doors across all facilities"
    - name: "avg_dock_doors_per_facility"
      expr: AVG(CAST(dock_door_count AS DOUBLE))
      comment: "Average number of dock doors per facility"
    - name: "cold_storage_facility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_cold_storage = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with cold storage capability"
    - name: "hazmat_storage_facility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_hazmat_storage = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with hazmat storage capability"
    - name: "iso9001_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_iso9001_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with ISO 9001 quality certification"
    - name: "ctpat_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_ctpat_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with C-TPAT security certification"
    - name: "total_ghg_emissions_co2e_tonnes"
      expr: SUM(CAST(annual_ghg_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total annual greenhouse gas emissions across all facilities in CO2 equivalent tonnes"
    - name: "avg_renewable_energy_percentage"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average percentage of renewable energy usage across facilities"
    - name: "avg_ghg_emissions_per_sqm"
      expr: ROUND(SUM(CAST(annual_ghg_emissions_co2e_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(total_floor_area_sqm AS DOUBLE)), 0), 4)
      comment: "Average GHG emissions per square meter of facility space (carbon intensity)"
$$;