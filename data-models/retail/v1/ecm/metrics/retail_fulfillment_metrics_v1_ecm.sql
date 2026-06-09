-- Metric views for domain: fulfillment | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fulfillment order performance metrics tracking order volume, cycle time, SLA compliance, and operational efficiency across fulfillment methods and nodes"
  source: "`retail_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method of fulfillment (ship-from-DC, ship-from-store, BOPIS, curbside, etc.)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment order (assigned, picking, packing, shipped, completed, cancelled)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the fulfillment order (standard, expedited, rush, same-day)"
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Date the order was placed, truncated to day"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the order was placed"
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date promised to customer for delivery"
    - name: "is_gift"
      expr: is_gift
      comment: "Whether the order is a gift"
  measures:
    - name: "total_fulfillment_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "total_order_value"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost amount across all fulfillment orders"
    - name: "avg_fulfillment_hours"
      expr: AVG(CAST(actual_fulfillment_hours AS DOUBLE))
      comment: "Average hours from order assignment to completion"
    - name: "total_packages"
      expr: SUM(CAST(package_count AS BIGINT))
      comment: "Total number of packages across all fulfillment orders"
    - name: "total_items"
      expr: SUM(CAST(total_item_quantity AS BIGINT))
      comment: "Total quantity of items fulfilled"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of all fulfilled orders"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume in cubic meters of all fulfilled orders"
    - name: "avg_items_per_order"
      expr: AVG(CAST(total_item_quantity AS BIGINT))
      comment: "Average number of items per fulfillment order"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with fulfillment orders"
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of unique fulfillment nodes processing orders"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment performance metrics tracking delivery accuracy, carrier performance, shipping costs, and on-time delivery rates"
  source: "`retail_ecm`.`fulfillment`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (created, in-transit, delivered, exception, returned)"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment for this shipment"
    - name: "ship_from_location_type"
      expr: ship_from_location_type
      comment: "Type of location shipment originated from (DC, store, vendor)"
    - name: "ship_date"
      expr: ship_date
      comment: "Date the shipment was shipped"
    - name: "ship_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month the shipment was shipped"
    - name: "estimated_delivery_date"
      expr: estimated_delivery_date
      comment: "Estimated delivery date for the shipment"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual delivery date for the shipment"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the shipment contains hazardous materials"
    - name: "delivery_signature_required_flag"
      expr: delivery_signature_required_flag
      comment: "Whether delivery signature is required"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country code"
    - name: "ship_to_state_province"
      expr: ship_to_state_province
      comment: "Destination state or province"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost across all shipments"
    - name: "total_carrier_charges"
      expr: SUM(CAST(carrier_charge_amount AS DOUBLE))
      comment: "Total carrier charges across all shipments"
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per shipment"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of all shipments"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of all shipments"
    - name: "total_shipment_volume_m3"
      expr: SUM(CAST(total_volume_cubic_meters AS DOUBLE))
      comment: "Total volume in cubic meters of all shipments"
    - name: "avg_weight_per_shipment_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per shipment in kilograms"
    - name: "total_packages_shipped"
      expr: SUM(CAST(package_count AS BIGINT))
      comment: "Total number of packages across all shipments"
    - name: "distinct_customers_shipped"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers receiving shipments"
    - name: "distinct_fulfillment_nodes_shipping"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of unique fulfillment nodes originating shipments"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used for shipments"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery route efficiency metrics tracking route optimization, completion rates, distance, duration, and operational costs"
  source: "`retail_ecm`.`fulfillment`.`delivery_route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Current status of the delivery route (planned, dispatched, in-progress, completed, cancelled)"
    - name: "route_type"
      expr: route_type
      comment: "Type of delivery route (standard, express, same-day, scheduled)"
    - name: "route_zone"
      expr: route_zone
      comment: "Geographic zone for the delivery route"
    - name: "route_priority"
      expr: route_priority
      comment: "Priority level of the route"
    - name: "route_date"
      expr: route_date
      comment: "Date the route was executed"
    - name: "route_month"
      expr: DATE_TRUNC('month', route_date)
      comment: "Month the route was executed"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle used for the route"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the route contains hazardous materials"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the route requires temperature control"
    - name: "optimization_algorithm"
      expr: optimization_algorithm
      comment: "Algorithm used for route optimization"
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of delivery routes"
    - name: "total_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total distance traveled across all routes in kilometers"
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance traveled (vs planned) in kilometers"
    - name: "avg_distance_per_route_km"
      expr: AVG(CAST(total_distance_km AS DOUBLE))
      comment: "Average distance per route in kilometers"
    - name: "total_route_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight carried across all routes in kilograms"
    - name: "total_route_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume carried across all routes in cubic meters"
    - name: "total_stops"
      expr: SUM(CAST(total_stops AS BIGINT))
      comment: "Total number of stops across all routes"
    - name: "total_completed_stops"
      expr: SUM(CAST(completed_stops AS BIGINT))
      comment: "Total number of successfully completed stops"
    - name: "total_failed_stops"
      expr: SUM(CAST(failed_stops AS BIGINT))
      comment: "Total number of failed delivery stops"
    - name: "total_packages_on_routes"
      expr: SUM(CAST(total_packages AS BIGINT))
      comment: "Total number of packages across all routes"
    - name: "avg_stops_per_route"
      expr: AVG(CAST(total_stops AS BIGINT))
      comment: "Average number of stops per route"
    - name: "distinct_delivery_associates"
      expr: COUNT(DISTINCT primary_delivery_associate_id)
      comment: "Number of unique delivery associates executing routes"
    - name: "distinct_fulfillment_nodes_routing"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of unique fulfillment nodes originating routes"
    - name: "distinct_carriers_routing"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers executing routes"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_bopis_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy-Online-Pickup-In-Store (BOPIS) appointment performance metrics tracking pickup efficiency, wait times, SLA compliance, and customer experience"
  source: "`retail_ecm`.`fulfillment`.`bopis_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the BOPIS appointment (scheduled, ready, checked-in, picked-up, cancelled, expired)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of pickup appointment (curbside, in-store, locker)"
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Date the pickup was scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the pickup was scheduled"
    - name: "pickup_location_code"
      expr: pickup_location_code
      comment: "Code identifying the pickup location within the store"
    - name: "check_in_method"
      expr: check_in_method
      comment: "Method used by customer to check in (app, SMS, call, in-person)"
    - name: "id_verification_method"
      expr: id_verification_method
      comment: "Method used to verify customer identity at pickup"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the service level agreement was met for this appointment"
    - name: "ready_notification_sent_flag"
      expr: ready_notification_sent_flag
      comment: "Whether ready-for-pickup notification was sent to customer"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for appointment cancellation if applicable"
  measures:
    - name: "total_bopis_appointments"
      expr: COUNT(1)
      comment: "Total number of BOPIS appointments"
    - name: "distinct_customers_bopis"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with BOPIS appointments"
    - name: "distinct_pickup_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of unique store locations handling BOPIS pickups"
    - name: "distinct_pickup_associates"
      expr: COUNT(DISTINCT pickup_associate_id)
      comment: "Number of unique associates handling BOPIS pickups"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment exception and issue tracking metrics measuring exception frequency, resolution efficiency, financial impact, and root cause analysis"
  source: "`retail_ecm`.`fulfillment`.`exception`"
  dimensions:
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (open, in-progress, resolved, escalated, closed)"
    - name: "exception_type"
      expr: exception_type
      comment: "Type of fulfillment exception (inventory shortage, damage, address issue, carrier delay, quality issue)"
    - name: "exception_code"
      expr: exception_code
      comment: "Standardized code for the exception"
    - name: "priority"
      expr: priority
      comment: "Priority level of the exception (low, medium, high, critical)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the exception"
    - name: "detected_at_stage"
      expr: detected_at_stage
      comment: "Fulfillment stage where exception was detected (picking, packing, shipping, delivery)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the exception"
    - name: "exception_date"
      expr: DATE_TRUNC('day', exception_timestamp)
      comment: "Date the exception occurred"
    - name: "exception_month"
      expr: DATE_TRUNC('month', exception_timestamp)
      comment: "Month the exception occurred"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the exception caused an SLA breach"
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Whether the customer was notified of the exception"
    - name: "owner_type"
      expr: owner_type
      comment: "Type of owner responsible for resolving the exception"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of fulfillment exceptions"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all exceptions"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception"
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of items affected by exceptions"
    - name: "avg_quantity_affected"
      expr: AVG(CAST(quantity_affected AS DOUBLE))
      comment: "Average quantity affected per exception"
    - name: "distinct_fulfillment_orders_with_exceptions"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of unique fulfillment orders with exceptions"
    - name: "distinct_fulfillment_nodes_with_exceptions"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of unique fulfillment nodes with exceptions"
    - name: "distinct_carriers_with_exceptions"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with exceptions"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking task performance metrics tracking pick accuracy, productivity, substitution rates, and task completion efficiency"
  source: "`retail_ecm`.`fulfillment`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (assigned, in-progress, completed, exception, cancelled)"
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (single-order, batch, wave, zone)"
    - name: "task_method"
      expr: task_method
      comment: "Method used for picking (manual, RF-scan, voice, pick-to-light, autonomous)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pick task"
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel for the pick task (e-commerce, store, wholesale)"
    - name: "work_zone"
      expr: work_zone
      comment: "Warehouse zone where picking occurred"
    - name: "substitution_occurred"
      expr: substitution_occurred
      comment: "Whether a product substitution occurred during picking"
    - name: "quality_check_outcome"
      expr: quality_check_outcome
      comment: "Outcome of quality check on picked items"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code if pick task encountered an issue"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pick task was created"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the pick task was created"
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks"
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of items requested to be picked"
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total quantity of items actually picked"
    - name: "avg_quantity_per_task"
      expr: AVG(CAST(quantity_picked AS DOUBLE))
      comment: "Average quantity picked per task"
    - name: "distinct_pickers"
      expr: COUNT(DISTINCT assigned_associate_id)
      comment: "Number of unique associates performing pick tasks"
    - name: "distinct_fulfillment_nodes_picking"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of unique fulfillment nodes with pick tasks"
    - name: "distinct_orders_picked"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of unique orders with pick tasks"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_pack_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse packing task performance metrics tracking pack efficiency, quality, packaging utilization, and task completion rates"
  source: "`retail_ecm`.`fulfillment`.`pack_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the pack task (assigned, in-progress, completed, exception, cancelled)"
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the pack task"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment for this pack task"
    - name: "package_type"
      expr: package_type
      comment: "Type of package used (box, envelope, poly-bag, custom)"
    - name: "package_size"
      expr: package_size
      comment: "Size category of the package (small, medium, large, oversized)"
    - name: "packing_station_code"
      expr: packing_station_code
      comment: "Code identifying the packing station"
    - name: "gift_wrap_flag"
      expr: gift_wrap_flag
      comment: "Whether gift wrapping was applied"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the package contains hazardous materials"
    - name: "signature_required_flag"
      expr: signature_required_flag
      comment: "Whether signature is required for delivery"
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Status of quality check on packed items"
    - name: "shipping_label_applied_flag"
      expr: shipping_label_applied_flag
      comment: "Whether shipping label was applied"
    - name: "packing_slip_printed_flag"
      expr: packing_slip_printed_flag
      comment: "Whether packing slip was printed"
    - name: "void_fill_type"
      expr: void_fill_type
      comment: "Type of void fill material used"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the pack task was created"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the pack task was created"
  measures:
    - name: "total_pack_tasks"
      expr: COUNT(1)
      comment: "Total number of pack tasks"
    - name: "total_items_packed"
      expr: SUM(CAST(items_packed_count AS BIGINT))
      comment: "Total number of items packed across all tasks"
    - name: "total_units_packed"
      expr: SUM(CAST(units_packed_count AS BIGINT))
      comment: "Total number of units packed across all tasks"
    - name: "avg_items_per_pack_task"
      expr: AVG(CAST(items_packed_count AS BIGINT))
      comment: "Average number of items packed per task"
    - name: "total_package_weight_kg"
      expr: SUM(CAST(package_weight_kg AS DOUBLE))
      comment: "Total weight of all packed packages in kilograms"
    - name: "avg_package_weight_kg"
      expr: AVG(CAST(package_weight_kg AS DOUBLE))
      comment: "Average weight per package in kilograms"
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total insurance value across all packed items"
    - name: "distinct_packers"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of unique associates performing pack tasks"
    - name: "distinct_fulfillment_nodes_packing"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of unique fulfillment nodes with pack tasks"
    - name: "distinct_carriers_packing"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers for packed shipments"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof of delivery performance metrics tracking delivery confirmation, customer satisfaction, compliance verification, and dispute resolution"
  source: "`retail_ecm`.`fulfillment`.`proof_of_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery (delivered, attempted, refused, returned, exception)"
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery location (front-door, mailroom, reception, neighbor, locker)"
    - name: "pod_capture_method"
      expr: pod_capture_method
      comment: "Method used to capture proof of delivery (signature, photo, PIN, contactless)"
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date the delivery was completed"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month the delivery was completed"
    - name: "signature_captured_flag"
      expr: signature_captured_flag
      comment: "Whether a signature was captured at delivery"
    - name: "age_verification_required_flag"
      expr: age_verification_required_flag
      comment: "Whether age verification was required"
    - name: "age_verification_completed_flag"
      expr: age_verification_completed_flag
      comment: "Whether age verification was successfully completed"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether delivery SLA was met"
    - name: "delivery_instructions_followed_flag"
      expr: delivery_instructions_followed_flag
      comment: "Whether delivery instructions were followed"
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether temperature requirements were maintained during delivery"
    - name: "package_condition"
      expr: package_condition
      comment: "Condition of package at delivery (good, damaged, opened, wet)"
    - name: "dispute_filed_flag"
      expr: dispute_filed_flag
      comment: "Whether a delivery dispute was filed"
    - name: "dispute_resolution_status"
      expr: dispute_resolution_status
      comment: "Status of dispute resolution if applicable"
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Whether customer was notified of delivery"
    - name: "delivery_exception_code"
      expr: delivery_exception_code
      comment: "Exception code if delivery encountered an issue"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of deliveries with proof of delivery"
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy at delivery in meters"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_at_delivery_celsius AS DOUBLE))
      comment: "Average temperature at delivery in Celsius"
    - name: "distinct_delivery_associates"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of unique delivery associates"
    - name: "distinct_carriers_delivering"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers completing deliveries"
    - name: "distinct_orders_delivered"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of unique orders delivered"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_drop_ship_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drop-ship order performance metrics tracking vendor fulfillment, SLA compliance, exception rates, and direct-to-customer delivery efficiency"
  source: "`retail_ecm`.`fulfillment`.`drop_ship_order`"
  dimensions:
    - name: "drop_ship_status"
      expr: drop_ship_status
      comment: "Current status of the drop-ship order (sent-to-vendor, acknowledged, shipped, delivered, exception, cancelled)"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code if drop-ship order encountered an issue"
    - name: "vendor_sla_compliance_flag"
      expr: vendor_sla_compliance_flag
      comment: "Whether vendor met SLA requirements for this order"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for order cancellation if applicable"
    - name: "promised_ship_date"
      expr: promised_ship_date
      comment: "Date vendor promised to ship the order"
    - name: "actual_ship_date"
      expr: actual_ship_date
      comment: "Actual date vendor shipped the order"
    - name: "estimated_delivery_date"
      expr: estimated_delivery_date
      comment: "Estimated delivery date to customer"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual delivery date to customer"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the drop-ship order was created"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country code"
    - name: "ship_to_state_province"
      expr: ship_to_state_province
      comment: "Destination state or province"
  measures:
    - name: "total_drop_ship_orders"
      expr: COUNT(1)
      comment: "Total number of drop-ship orders"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS BIGINT))
      comment: "Total quantity ordered via drop-ship"
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS BIGINT))
      comment: "Total quantity shipped by vendors"
    - name: "avg_quantity_per_order"
      expr: AVG(CAST(quantity_ordered AS BIGINT))
      comment: "Average quantity per drop-ship order"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors fulfilling drop-ship orders"
    - name: "distinct_customers_drop_ship"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers receiving drop-ship orders"
    - name: "distinct_carriers_drop_ship"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used for drop-ship deliveries"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance and capability metrics tracking service levels, rates, coverage, certifications, and operational readiness"
  source: "`retail_ecm`.`fulfillment`.`carrier`"
  dimensions:
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current status of the carrier (active, inactive, suspended, onboarding)"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (parcel, LTL, FTL, last-mile, regional, national, international)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier"
    - name: "carrier_code"
      expr: carrier_code
      comment: "Standardized code for the carrier"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage area of the carrier"
    - name: "service_level_same_day"
      expr: service_level_same_day
      comment: "Whether carrier offers same-day delivery"
    - name: "service_level_overnight"
      expr: service_level_overnight
      comment: "Whether carrier offers overnight delivery"
    - name: "service_level_two_day"
      expr: service_level_two_day
      comment: "Whether carrier offers two-day delivery"
    - name: "service_level_ground"
      expr: service_level_ground
      comment: "Whether carrier offers ground delivery"
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether carrier is certified for hazardous materials"
    - name: "tracking_capability_flag"
      expr: tracking_capability_flag
      comment: "Whether carrier provides tracking capability"
    - name: "api_integration_flag"
      expr: api_integration_flag
      comment: "Whether carrier has API integration enabled"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether carrier supports EDI transactions"
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Whether carrier provides insurance coverage"
    - name: "signature_required_flag"
      expr: signature_required_flag
      comment: "Whether carrier requires signature for delivery"
    - name: "bopis_ready_flag"
      expr: bopis_ready_flag
      comment: "Whether carrier supports BOPIS fulfillment"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network"
    - name: "avg_base_rate_per_lb"
      expr: AVG(CAST(base_rate_per_lb AS DOUBLE))
      comment: "Average base rate per pound across carriers"
    - name: "avg_negotiated_discount_pct"
      expr: AVG(CAST(negotiated_discount_percentage AS DOUBLE))
      comment: "Average negotiated discount percentage across carriers"
    - name: "avg_fuel_surcharge_pct"
      expr: AVG(CAST(fuel_surcharge_percentage AS DOUBLE))
      comment: "Average fuel surcharge percentage across carriers"
    - name: "avg_residential_surcharge"
      expr: AVG(CAST(residential_delivery_surcharge AS DOUBLE))
      comment: "Average residential delivery surcharge across carriers"
    - name: "avg_extended_area_surcharge"
      expr: AVG(CAST(extended_area_surcharge AS DOUBLE))
      comment: "Average extended area surcharge across carriers"
    - name: "avg_max_weight_lbs"
      expr: AVG(CAST(max_weight_lbs AS DOUBLE))
      comment: "Average maximum weight capacity in pounds across carriers"
    - name: "avg_dimensional_weight_factor"
      expr: AVG(CAST(dimensional_weight_factor AS DOUBLE))
      comment: "Average dimensional weight factor across carriers"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment node capacity and capability metrics tracking operational readiness, service offerings, automation levels, and geographic coverage"
  source: "`retail_ecm`.`fulfillment`.`fulfillment_node`"
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