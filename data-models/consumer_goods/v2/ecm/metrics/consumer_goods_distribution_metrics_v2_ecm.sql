-- Metric views for domain: distribution | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution facility operational performance and capacity metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_facility`"
  dimensions:
    - name: "facility_code"
      expr: facility_code
      comment: "Unique facility identifier code"
    - name: "facility_name"
      expr: facility_name
      comment: "Distribution facility name"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of distribution facility (DC, cross-dock, hub)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "country_code"
      expr: country_code
      comment: "Country where facility is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province location"
    - name: "city"
      expr: city
      comment: "City location"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (owned, leased, 3PL)"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether facility has temperature control capability"
    - name: "cross_dock_enabled_flag"
      expr: cross_dock_enabled_flag
      comment: "Whether facility supports cross-docking operations"
    - name: "dsd_hub_flag"
      expr: dsd_hub_flag
      comment: "Whether facility serves as a direct store delivery hub"
    - name: "opened_year"
      expr: YEAR(opened_date)
      comment: "Year the facility opened"
  measures:
    - name: "facility_count"
      expr: COUNT(DISTINCT distribution_facility_id)
      comment: "Number of unique distribution facilities"
    - name: "total_capacity_sqft"
      expr: SUM(CAST(capacity_sqft AS DOUBLE))
      comment: "Total facility capacity in square feet"
    - name: "avg_capacity_sqft"
      expr: AVG(CAST(capacity_sqft AS DOUBLE))
      comment: "Average facility capacity in square feet"
    - name: "total_dock_doors_inbound"
      expr: SUM(CAST(dock_doors_inbound AS DOUBLE))
      comment: "Total number of inbound dock doors across facilities"
    - name: "total_dock_doors_outbound"
      expr: SUM(CAST(dock_doors_outbound AS DOUBLE))
      comment: "Total number of outbound dock doors across facilities"
    - name: "avg_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average on-time in-full target percentage across facilities"
    - name: "avg_osa_target_percentage"
      expr: AVG(CAST(osa_target_percentage AS DOUBLE))
      comment: "Average on-shelf availability target percentage"
    - name: "total_storage_capacity_pallets"
      expr: SUM(CAST(storage_capacity_pallet_positions AS DOUBLE))
      comment: "Total pallet storage capacity across all facilities"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment and delivery performance metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment for delivery"
    - name: "priority_code"
      expr: priority_code
      comment: "Order priority classification"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipment"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether order requires temperature control"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether order contains hazardous materials"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Whether order has backorder items"
    - name: "otif_commitment_flag"
      expr: otif_commitment_flag
      comment: "Whether order has OTIF commitment"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
  measures:
    - name: "order_count"
      expr: COUNT(DISTINCT outbound_order_id)
      comment: "Number of unique outbound orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all outbound orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average order value"
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total quantity across all orders"
    - name: "avg_order_quantity"
      expr: AVG(CAST(total_order_quantity AS DOUBLE))
      comment: "Average quantity per order"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight of all orders in kilograms"
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total volume of all orders in cubic meters"
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average order fill rate percentage"
    - name: "backorder_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with backorders"
    - name: "otif_commitment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_commitment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with OTIF commitment"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_otif_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-time in-full delivery performance and compliance metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`otif_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Status of the OTIF event"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which delivery was made"
    - name: "failure_category"
      expr: failure_category
      comment: "Category of OTIF failure if applicable"
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Specific reason code for OTIF failure"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for OTIF failure"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether delivery was on time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether delivery was in full"
    - name: "otif_flag"
      expr: otif_flag
      comment: "Whether delivery met both on-time and in-full criteria"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether OTIF event is disputed"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of the OTIF event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the OTIF event"
  measures:
    - name: "otif_event_count"
      expr: COUNT(DISTINCT otif_event_id)
      comment: "Number of unique OTIF events"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting OTIF criteria"
    - name: "on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that were on time"
    - name: "in_full_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that were in full"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed across all events"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered across all events"
    - name: "total_short_quantity"
      expr: SUM(CAST(short_quantity AS DOUBLE))
      comment: "Total quantity short across all events"
    - name: "avg_quantity_variance_percent"
      expr: AVG(CAST(quantity_variance_percent AS DOUBLE))
      comment: "Average quantity variance as percentage"
    - name: "avg_late_days"
      expr: AVG(CAST(late_days AS DOUBLE))
      comment: "Average number of days late for late deliveries"
    - name: "total_retailer_penalty_amount"
      expr: SUM(CAST(retailer_penalty_amount AS DOUBLE))
      comment: "Total retailer penalties incurred for OTIF failures"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTIF events that are disputed"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution shipment execution and freight performance metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level used"
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms"
    - name: "otif_status"
      expr: otif_status
      comment: "On-time in-full status"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether shipment was on time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether shipment was in full"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether shipment requires temperature control"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether shipment contains hazardous materials"
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year of shipment"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country"
  measures:
    - name: "shipment_count"
      expr: COUNT(DISTINCT distribution_shipment_id)
      comment: "Number of unique shipments"
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges across all shipments"
    - name: "avg_freight_charge_amount"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per shipment"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume shipped in cubic meters"
    - name: "avg_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per shipment in kilograms"
    - name: "total_pallet_count"
      expr: SUM(CAST(pallet_count AS DOUBLE))
      comment: "Total number of pallets shipped"
    - name: "total_carton_count"
      expr: SUM(CAST(carton_count AS DOUBLE))
      comment: "Total number of cartons shipped"
    - name: "on_time_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time"
    - name: "in_full_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered in full"
    - name: "freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0), 2)
      comment: "Average freight cost per kilogram"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving operations and quality compliance metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status"
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether receipt had discrepancies"
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Whether receipt met OTIF criteria"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection was required"
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether temperature was compliant"
    - name: "seal_intact_flag"
      expr: seal_intact_flag
      comment: "Whether seal was intact upon receipt"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year of receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt"
  measures:
    - name: "receipt_count"
      expr: COUNT(DISTINCT inbound_receipt_id)
      comment: "Number of unique inbound receipts"
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total expected quantity across all receipts"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total received quantity across all receipts"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total accepted quantity across all receipts"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total rejected quantity across all receipts"
    - name: "receipt_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(expected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of expected quantity that was received"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was accepted"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected"
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with discrepancies"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts meeting OTIF criteria"
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts meeting temperature requirements"
    - name: "total_pallet_count"
      expr: SUM(CAST(pallet_count AS DOUBLE))
      comment: "Total number of pallets received"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking productivity and accuracy metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`pick_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pick task"
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task"
    - name: "picking_strategy"
      expr: picking_strategy
      comment: "Picking strategy used"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the task"
    - name: "pick_accuracy_flag"
      expr: pick_accuracy_flag
      comment: "Whether pick was accurate"
    - name: "otif_eligible_flag"
      expr: otif_eligible_flag
      comment: "Whether task is eligible for OTIF measurement"
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Whether task is for direct store delivery"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code if applicable"
    - name: "task_date"
      expr: DATE(task_assigned_timestamp)
      comment: "Date the task was assigned"
  measures:
    - name: "pick_task_count"
      expr: COUNT(DISTINCT pick_task_id)
      comment: "Number of unique pick tasks"
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Total quantity picked across all tasks"
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total quantity actually picked"
    - name: "avg_pick_quantity"
      expr: AVG(CAST(pick_quantity AS DOUBLE))
      comment: "Average quantity per pick task"
    - name: "pick_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pick_accuracy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of picks that were accurate"
    - name: "avg_task_duration_seconds"
      expr: AVG(CAST(task_duration_seconds AS DOUBLE))
      comment: "Average task duration in seconds"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight picked in kilograms"
    - name: "picks_per_hour"
      expr: ROUND(COUNT(1) / NULLIF(SUM(CAST(task_duration_seconds AS DOUBLE)) / 3600.0, 0), 2)
      comment: "Average number of picks per hour"
    - name: "units_per_hour"
      expr: ROUND(SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(task_duration_seconds AS DOUBLE)) / 3600.0, 0), 2)
      comment: "Average units picked per hour"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory availability and stock health metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`inventory_position`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of inventory"
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Physical condition of inventory"
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone location"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone classification"
    - name: "owner_type"
      expr: owner_type
      comment: "Type of inventory owner"
    - name: "pick_face_flag"
      expr: pick_face_flag
      comment: "Whether inventory is in pick face location"
    - name: "replenishment_flag"
      expr: replenishment_flag
      comment: "Whether inventory needs replenishment"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of inventory snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of inventory snapshot"
  measures:
    - name: "inventory_position_count"
      expr: COUNT(DISTINCT inventory_position_id)
      comment: "Number of unique inventory positions"
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand quantity across all positions"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity for allocation"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total allocated quantity"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total reserved quantity"
    - name: "total_damaged_quantity"
      expr: SUM(CAST(quantity_damaged AS DOUBLE))
      comment: "Total damaged quantity"
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quantity_quarantine AS DOUBLE))
      comment: "Total quarantined quantity"
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total inventory value across all positions"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit"
    - name: "avg_days_on_hand"
      expr: AVG(CAST(days_on_hand AS DOUBLE))
      comment: "Average days inventory has been on hand"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available"
    - name: "damaged_inventory_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_damaged AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory that is damaged"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and inventory control metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting"
    - name: "count_reason_code"
      expr: count_reason_code
      comment: "Reason for the cycle count"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of counted items"
    - name: "adjustment_required_flag"
      expr: adjustment_required_flag
      comment: "Whether inventory adjustment is required"
    - name: "adjustment_approved_flag"
      expr: adjustment_approved_flag
      comment: "Whether adjustment has been approved"
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Whether recount is required"
    - name: "stock_status"
      expr: stock_status
      comment: "Status of the stock"
    - name: "count_year"
      expr: YEAR(count_date)
      comment: "Year of the cycle count"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month of the cycle count"
  measures:
    - name: "cycle_count_count"
      expr: COUNT(DISTINCT distribution_cycle_count_id)
      comment: "Number of unique cycle counts performed"
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system quantity across all counts"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total counted quantity across all counts"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity across all counts"
    - name: "total_inventory_value_variance"
      expr: SUM(CAST(inventory_value_variance_amount AS DOUBLE))
      comment: "Total inventory value variance"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts"
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_quantity = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts with zero variance"
    - name: "adjustment_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adjustment_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring adjustment"
    - name: "recount_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount"
    - name: "within_tolerance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ABS(variance_percentage) <= tolerance_threshold_percentage THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts within tolerance threshold"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_returns_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product returns processing and disposition metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`returns_receipt`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Status of the return"
    - name: "return_type"
      expr: return_type
      comment: "Type of return"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for returned goods"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code"
    - name: "condition_assessment"
      expr: condition_assessment
      comment: "Assessment of returned goods condition"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether return is related to a recall"
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether temperature was compliant during return"
    - name: "return_year"
      expr: YEAR(return_date)
      comment: "Year of the return"
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', return_date)
      comment: "Month of the return"
  measures:
    - name: "returns_receipt_count"
      expr: COUNT(DISTINCT returns_receipt_id)
      comment: "Number of unique returns receipts"
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned"
    - name: "total_resalable_quantity"
      expr: SUM(CAST(resalable_quantity AS DOUBLE))
      comment: "Total quantity that can be resold"
    - name: "total_destroy_quantity"
      expr: SUM(CAST(destroy_quantity AS DOUBLE))
      comment: "Total quantity to be destroyed"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity requiring rework"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for returns"
    - name: "resalable_rate"
      expr: ROUND(100.0 * SUM(CAST(resalable_quantity AS DOUBLE)) / NULLIF(SUM(CAST(returned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of returned goods that are resalable"
    - name: "destroy_rate"
      expr: ROUND(100.0 * SUM(CAST(destroy_quantity AS DOUBLE)) / NULLIF(SUM(CAST(returned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of returned goods to be destroyed"
    - name: "recall_return_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns related to recalls"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per return"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load planning efficiency and trailer utilization metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Status of the load plan"
    - name: "load_type"
      expr: load_type
      comment: "Type of load"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level"
    - name: "trailer_type"
      expr: trailer_type
      comment: "Type of trailer"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether load requires temperature control"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether load contains hazardous materials"
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Whether load is for direct store delivery"
    - name: "load_sequence_strategy"
      expr: load_sequence_strategy
      comment: "Strategy used for load sequencing"
    - name: "plan_year"
      expr: YEAR(plan_date)
      comment: "Year of the load plan"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month of the load plan"
  measures:
    - name: "load_plan_count"
      expr: COUNT(DISTINCT load_plan_id)
      comment: "Number of unique load plans"
    - name: "total_pallet_count"
      expr: SUM(CAST(pallet_count AS DOUBLE))
      comment: "Total number of pallets loaded"
    - name: "total_case_count"
      expr: SUM(CAST(case_count AS DOUBLE))
      comment: "Total number of cases loaded"
    - name: "total_order_count"
      expr: SUM(CAST(order_count AS DOUBLE))
      comment: "Total number of orders in loads"
    - name: "total_stop_count"
      expr: SUM(CAST(stop_count AS DOUBLE))
      comment: "Total number of stops across all loads"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight loaded in kilograms"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume loaded in cubic meters"
    - name: "total_estimated_freight_cost"
      expr: SUM(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total estimated freight cost"
    - name: "avg_trailer_utilization_percentage"
      expr: AVG(CAST(trailer_utilization_percentage AS DOUBLE))
      comment: "Average trailer utilization percentage"
    - name: "avg_pallets_per_load"
      expr: AVG(CAST(pallet_count AS DOUBLE))
      comment: "Average number of pallets per load"
    - name: "avg_stops_per_load"
      expr: AVG(CAST(stop_count AS DOUBLE))
      comment: "Average number of stops per load"
    - name: "freight_cost_per_pallet"
      expr: ROUND(SUM(CAST(estimated_freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(pallet_count AS DOUBLE)), 0), 2)
      comment: "Average freight cost per pallet"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wave planning and execution performance metrics"
  source: "`vibe_consumer_goods_v1`.`distribution`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Status of the wave"
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave"
    - name: "strategy"
      expr: strategy
      comment: "Wave strategy used"
    - name: "priority"
      expr: priority
      comment: "Priority level of the wave"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type used for wave"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether wave is critical"
    - name: "wave_date"
      expr: DATE(planned_start_timestamp)
      comment: "Date of the wave"
  measures:
    - name: "wave_count"
      expr: COUNT(DISTINCT wave_id)
      comment: "Number of unique waves"
    - name: "total_order_count"
      expr: SUM(CAST(total_orders AS DOUBLE))
      comment: "Total number of orders across all waves"
    - name: "total_item_count"
      expr: SUM(CAST(total_items AS DOUBLE))
      comment: "Total number of items across all waves"
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity across all waves"
    - name: "total_picker_count"
      expr: SUM(CAST(picker_count AS DOUBLE))
      comment: "Total number of pickers assigned"
    - name: "avg_on_time_pct"
      expr: AVG(CAST(on_time_pct AS DOUBLE))
      comment: "Average on-time percentage across waves"
    - name: "avg_orders_per_wave"
      expr: AVG(CAST(total_orders AS DOUBLE))
      comment: "Average number of orders per wave"
    - name: "avg_items_per_wave"
      expr: AVG(CAST(total_items AS DOUBLE))
      comment: "Average number of items per wave"
    - name: "orders_per_picker"
      expr: ROUND(SUM(CAST(total_orders AS DOUBLE)) / NULLIF(SUM(CAST(picker_count AS DOUBLE)), 0), 2)
      comment: "Average orders per picker across waves"
$$;