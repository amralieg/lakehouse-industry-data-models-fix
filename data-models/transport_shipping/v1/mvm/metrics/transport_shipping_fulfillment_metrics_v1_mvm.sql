-- Metric views for domain: fulfillment | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fulfillment order performance metrics tracking order volume, value, delivery performance, and SLA compliance"
  source: "`transport_shipping_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the fulfillment order (received, allocated, picked, packed, dispatched, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of fulfillment order (standard, express, return, replacement)"
    - name: "service_type"
      expr: service_type
      comment: "Service level type (same-day, next-day, standard, economy)"
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Mode of fulfillment (warehouse, dropship, cross-dock, store)"
    - name: "source_channel"
      expr: source_channel
      comment: "Source channel of the order (web, mobile, marketplace, B2B)"
    - name: "delivery_country"
      expr: delivery_country_code
      comment: "Destination country code for delivery"
    - name: "is_cod_order"
      expr: cod_flag
      comment: "Whether order is cash-on-delivery"
    - name: "is_return_order"
      expr: return_flag
      comment: "Whether order is a return"
    - name: "sla_breached"
      expr: sla_breach_flag
      comment: "Whether order breached SLA commitment"
    - name: "order_date"
      expr: DATE(received_timestamp)
      comment: "Date order was received into fulfillment system"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month order was received"
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date promised to customer for delivery"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "total_order_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total declared value of all orders in local currency"
    - name: "avg_order_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average declared value per order"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of all orders in kilograms"
    - name: "total_order_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume of all orders in cubic meters"
    - name: "avg_order_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per order in kilograms"
    - name: "total_cod_value"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount to be collected"
    - name: "total_packages"
      expr: SUM(CAST(total_package_count AS BIGINT))
      comment: "Total number of packages across all orders"
    - name: "total_items"
      expr: SUM(CAST(total_item_quantity AS BIGINT))
      comment: "Total number of items across all orders"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders that breached SLA commitments"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders meeting SLA commitments"
    - name: "cod_order_count"
      expr: SUM(CASE WHEN cod_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cash-on-delivery orders"
    - name: "cod_penetration_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cod_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are cash-on-delivery"
    - name: "return_order_count"
      expr: SUM(CASE WHEN return_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of return orders"
    - name: "return_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN return_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are returns"
    - name: "delivered_order_count"
      expr: SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END)
      comment: "Number of successfully delivered orders"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled orders"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that were cancelled"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_delivery_attempt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery attempt performance metrics tracking delivery success rates, failure reasons, and operational efficiency"
  source: "`transport_shipping_ecm`.`fulfillment`.`delivery_attempt`"
  dimensions:
    - name: "attempt_outcome"
      expr: attempt_outcome_code
      comment: "Outcome code of the delivery attempt (delivered, failed, rescheduled)"
    - name: "failure_reason"
      expr: failure_reason_code
      comment: "Reason code for failed delivery attempt"
    - name: "attempt_number_bucket"
      expr: attempt_number
      comment: "Delivery attempt number (1st, 2nd, 3rd, etc.)"
    - name: "is_cod_collected"
      expr: cod_collected_flag
      comment: "Whether cash-on-delivery payment was collected"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether delivery attempt breached SLA target"
    - name: "epod_signature_captured"
      expr: epod_signature_captured_flag
      comment: "Whether electronic proof of delivery signature was captured"
    - name: "epod_photo_captured"
      expr: epod_photo_captured_flag
      comment: "Whether electronic proof of delivery photo was captured"
    - name: "delivery_country"
      expr: delivery_country_code
      comment: "Country code of delivery address"
    - name: "attempt_date"
      expr: attempt_date
      comment: "Date of delivery attempt"
    - name: "attempt_month"
      expr: DATE_TRUNC('MONTH', attempt_timestamp)
      comment: "Month of delivery attempt"
  measures:
    - name: "total_delivery_attempts"
      expr: COUNT(1)
      comment: "Total number of delivery attempts"
    - name: "successful_deliveries"
      expr: SUM(CASE WHEN attempt_outcome_code = 'delivered' THEN 1 ELSE 0 END)
      comment: "Number of successful delivery attempts"
    - name: "failed_deliveries"
      expr: SUM(CASE WHEN attempt_outcome_code IN ('failed', 'rescheduled') THEN 1 ELSE 0 END)
      comment: "Number of failed or rescheduled delivery attempts"
    - name: "first_attempt_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN attempt_number = '1' AND attempt_outcome_code = 'delivered' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN attempt_number = '1' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of deliveries successful on first attempt"
    - name: "overall_delivery_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN attempt_outcome_code = 'delivered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Overall percentage of successful delivery attempts"
    - name: "total_cod_collected"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount collected"
    - name: "cod_collection_count"
      expr: SUM(CASE WHEN cod_collected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of successful COD collections"
    - name: "cod_collection_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cod_collected_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN cod_amount > 0 THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of COD attempts that successfully collected payment"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of delivery attempts that breached SLA"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery attempts meeting SLA targets"
    - name: "epod_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN epod_signature_captured_flag = TRUE OR epod_photo_captured_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attempts with electronic proof of delivery captured"
    - name: "avg_time_at_location_minutes"
      expr: AVG(CAST(time_at_location_minutes AS DOUBLE))
      comment: "Average time spent at delivery location in minutes"
    - name: "reattempt_required_count"
      expr: SUM(CASE WHEN reattempt_scheduled_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of attempts requiring rescheduling"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_parcel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parcel-level shipping metrics tracking volume, weight, value, and service characteristics"
  source: "`transport_shipping_ecm`.`fulfillment`.`parcel`"
  dimensions:
    - name: "parcel_status"
      expr: parcel_status
      comment: "Current status of the parcel (created, manifested, in-transit, delivered, returned)"
    - name: "carrier_service"
      expr: carrier_service_code
      comment: "Carrier service code used for parcel"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging used (box, envelope, tube, pallet)"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country code"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether parcel contains hazardous materials"
    - name: "is_cod"
      expr: cod_flag
      comment: "Whether parcel is cash-on-delivery"
    - name: "signature_required"
      expr: signature_required_flag
      comment: "Whether signature is required for delivery"
    - name: "insurance_required"
      expr: insurance_required_flag
      comment: "Whether insurance is required"
    - name: "pack_date"
      expr: DATE(pack_timestamp)
      comment: "Date parcel was packed"
    - name: "pack_month"
      expr: DATE_TRUNC('MONTH', pack_timestamp)
      comment: "Month parcel was packed"
    - name: "target_delivery_date"
      expr: sla_target_delivery_date
      comment: "Target delivery date per SLA"
  measures:
    - name: "total_parcels"
      expr: COUNT(1)
      comment: "Total number of parcels"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight of all parcels in kilograms"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight (greater of actual or dimensional) in kilograms"
    - name: "total_dimensional_weight_kg"
      expr: SUM(CAST(dimensional_weight_kg AS DOUBLE))
      comment: "Total dimensional weight in kilograms"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of all parcels in cubic meters"
    - name: "avg_actual_weight_kg"
      expr: AVG(CAST(actual_weight_kg AS DOUBLE))
      comment: "Average actual weight per parcel in kilograms"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per parcel in kilograms"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of all parcels"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per parcel"
    - name: "total_cod_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount for all parcels"
    - name: "hazmat_parcel_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of parcels containing hazardous materials"
    - name: "hazmat_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parcels that are hazmat"
    - name: "cod_parcel_count"
      expr: SUM(CASE WHEN cod_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cash-on-delivery parcels"
    - name: "cod_penetration_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cod_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parcels that are COD"
    - name: "dimensional_weight_factor_avg"
      expr: AVG(CAST(dimensional_weight_kg AS DOUBLE) / NULLIF(CAST(actual_weight_kg AS DOUBLE), 0))
      comment: "Average ratio of dimensional weight to actual weight"
    - name: "delivered_parcel_count"
      expr: SUM(CASE WHEN parcel_status = 'delivered' THEN 1 ELSE 0 END)
      comment: "Number of successfully delivered parcels"
    - name: "delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN parcel_status = 'delivered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parcels successfully delivered"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_dispatch_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile dispatch run operational metrics tracking route efficiency, capacity utilization, and delivery performance"
  source: "`transport_shipping_ecm`.`fulfillment`.`dispatch_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the dispatch run (planned, dispatched, in-progress, completed, reconciled)"
    - name: "dispatch_type"
      expr: dispatch_type
      comment: "Type of dispatch run (scheduled, on-demand, express, return)"
    - name: "route_code"
      expr: route_code
      comment: "Route code identifier"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether run contains hazardous materials"
    - name: "is_temperature_controlled"
      expr: temperature_controlled_flag
      comment: "Whether run requires temperature control"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether run breached SLA target completion time"
    - name: "manifest_reconciliation_status"
      expr: manifest_reconciliation_status
      comment: "Reconciliation status of manifest (pending, reconciled, discrepancy)"
    - name: "run_date"
      expr: run_date
      comment: "Date of dispatch run"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of dispatch run"
  measures:
    - name: "total_dispatch_runs"
      expr: COUNT(1)
      comment: "Total number of dispatch runs"
    - name: "total_parcels_loaded"
      expr: SUM(CAST(total_parcels_loaded AS BIGINT))
      comment: "Total number of parcels loaded across all runs"
    - name: "total_parcels_delivered"
      expr: SUM(CAST(total_parcels_delivered AS BIGINT))
      comment: "Total number of parcels successfully delivered"
    - name: "total_failed_deliveries"
      expr: SUM(CAST(failed_delivery_count AS BIGINT))
      comment: "Total number of failed delivery attempts"
    - name: "total_returned_parcels"
      expr: SUM(CAST(returned_parcel_count AS BIGINT))
      comment: "Total number of parcels returned to depot"
    - name: "delivery_success_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_parcels_delivered AS BIGINT)) / NULLIF(SUM(CAST(total_parcels_loaded AS BIGINT)), 0), 2)
      comment: "Percentage of loaded parcels successfully delivered"
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance traveled in kilometers"
    - name: "total_planned_distance_km"
      expr: SUM(CAST(planned_distance_km AS DOUBLE))
      comment: "Total planned distance in kilometers"
    - name: "avg_actual_distance_km"
      expr: AVG(CAST(actual_distance_km AS DOUBLE))
      comment: "Average actual distance per run in kilometers"
    - name: "route_adherence_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_distance_km AS DOUBLE)) / NULLIF(SUM(CAST(actual_distance_km AS DOUBLE)), 0), 2)
      comment: "Percentage of planned distance to actual distance (route efficiency)"
    - name: "avg_vehicle_utilization_pct"
      expr: AVG(CAST(vehicle_utilization_percentage AS DOUBLE))
      comment: "Average vehicle capacity utilization percentage"
    - name: "total_weight_hauled_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight hauled across all runs in kilograms"
    - name: "total_volume_hauled_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume hauled across all runs in cubic meters"
    - name: "total_cod_collected"
      expr: SUM(CAST(total_cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount collected"
    - name: "cod_collection_count"
      expr: SUM(CAST(cod_collection_count AS BIGINT))
      comment: "Total number of COD collections"
    - name: "avg_stops_per_run"
      expr: AVG(CAST(actual_stop_count AS DOUBLE))
      comment: "Average number of stops per dispatch run"
    - name: "stop_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_stop_count AS BIGINT)) / NULLIF(SUM(CAST(actual_stop_count AS BIGINT)), 0), 2)
      comment: "Percentage of planned stops to actual stops"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of runs that breached SLA"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs meeting SLA targets"
    - name: "parcels_per_km"
      expr: SUM(CAST(total_parcels_delivered AS BIGINT)) / NULLIF(SUM(CAST(actual_distance_km AS DOUBLE)), 0)
      comment: "Average parcels delivered per kilometer traveled"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment center capacity and operational characteristics metrics"
  source: "`transport_shipping_ecm`.`fulfillment`.`center`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the center (active, inactive, seasonal, maintenance)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of fulfillment facility (warehouse, distribution center, cross-dock, micro-fulfillment)"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation (manual, semi-automated, fully-automated)"
    - name: "country"
      expr: country_code
      comment: "Country code where center is located"
    - name: "is_temperature_controlled"
      expr: temperature_controlled_flag
      comment: "Whether center has temperature-controlled storage"
    - name: "is_hazmat_certified"
      expr: hazmat_certified_flag
      comment: "Whether center is certified for hazardous materials"
    - name: "is_customs_bonded"
      expr: customs_bonded_warehouse_flag
      comment: "Whether center is a customs bonded warehouse"
    - name: "quality_certification"
      expr: quality_certification
      comment: "Quality certification standard (ISO, GMP, etc.)"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification (LEED, BREEAM, etc.)"
  measures:
    - name: "total_centers"
      expr: COUNT(1)
      comment: "Total number of fulfillment centers"
    - name: "active_centers"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active fulfillment centers"
    - name: "total_storage_capacity_cbm"
      expr: SUM(CAST(storage_capacity_cbm AS DOUBLE))
      comment: "Total storage capacity across all centers in cubic meters"
    - name: "avg_storage_capacity_cbm"
      expr: AVG(CAST(storage_capacity_cbm AS DOUBLE))
      comment: "Average storage capacity per center in cubic meters"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total floor area across all centers in square meters"
    - name: "avg_floor_area_sqm"
      expr: AVG(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Average floor area per center in square meters"
    - name: "total_annual_throughput_capacity"
      expr: SUM(CAST(annual_throughput_capacity_units AS BIGINT))
      comment: "Total annual throughput capacity in units across all centers"
    - name: "avg_annual_throughput_capacity"
      expr: AVG(CAST(annual_throughput_capacity_units AS BIGINT))
      comment: "Average annual throughput capacity per center"
    - name: "temperature_controlled_centers"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of centers with temperature-controlled capability"
    - name: "hazmat_certified_centers"
      expr: SUM(CASE WHEN hazmat_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of centers certified for hazardous materials"
    - name: "customs_bonded_centers"
      expr: SUM(CASE WHEN customs_bonded_warehouse_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of customs bonded warehouse centers"
    - name: "storage_density_ratio"
      expr: AVG(CAST(storage_capacity_cbm AS DOUBLE) / NULLIF(CAST(total_floor_area_sqm AS DOUBLE), 0))
      comment: "Average storage capacity per square meter of floor area"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics tracking return processing efficiency, refund performance, and policy compliance"
  source: "`transport_shipping_ecm`.`fulfillment`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of RMA (requested, approved, in-transit, received, inspected, processed, closed)"
    - name: "return_reason"
      expr: return_reason_code
      comment: "Reason code for return (defective, wrong-item, damaged, customer-remorse, etc.)"
    - name: "disposition_instruction"
      expr: disposition_instruction
      comment: "Disposition instruction for returned item (restock, scrap, repair, vendor-return)"
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund (original-payment, store-credit, exchange)"
    - name: "is_merchant_approved"
      expr: merchant_approved_flag
      comment: "Whether merchant approved the return"
    - name: "is_policy_compliant"
      expr: return_policy_compliant_flag
      comment: "Whether return complies with return policy"
    - name: "is_restocked"
      expr: restocked_flag
      comment: "Whether returned item was restocked"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether RMA processing breached SLA"
    - name: "return_label_generated"
      expr: return_label_generated_flag
      comment: "Whether return shipping label was generated"
    - name: "request_date"
      expr: DATE(request_timestamp)
      comment: "Date RMA was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month RMA was requested"
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of return merchandise authorizations"
    - name: "approved_rmas"
      expr: SUM(CASE WHEN merchant_approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of approved RMAs"
    - name: "rma_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN merchant_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs that were approved"
    - name: "policy_compliant_rmas"
      expr: SUM(CASE WHEN return_policy_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs compliant with return policy"
    - name: "policy_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN return_policy_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs compliant with return policy"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount processed"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees charged"
    - name: "avg_restocking_fee"
      expr: AVG(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Average restocking fee per RMA"
    - name: "restocked_items"
      expr: SUM(CASE WHEN restocked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of returned items that were restocked"
    - name: "restock_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN restocked_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns that were restocked for resale"
    - name: "refund_processed_count"
      expr: SUM(CASE WHEN refund_processed_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of RMAs with refund processed"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs that breached processing SLA"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs meeting processing SLA"
    - name: "return_label_generation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN return_label_generated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs with return label generated"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_merchant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchant account performance and service adoption metrics"
  source: "`transport_shipping_ecm`.`fulfillment`.`merchant`"
  dimensions:
    - name: "merchant_status"
      expr: merchant_status
      comment: "Current status of merchant account (active, suspended, terminated, onboarding)"
    - name: "merchant_tier"
      expr: merchant_tier
      comment: "Merchant tier classification (platinum, gold, silver, bronze)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of merchant (fashion, electronics, grocery, etc.)"
    - name: "platform_type"
      expr: platform_type
      comment: "E-commerce platform type (Shopify, Magento, custom, etc.)"
    - name: "integration_channel"
      expr: integration_channel
      comment: "Integration channel (API, EDI, SFTP, manual)"
    - name: "is_cod_enabled"
      expr: cod_enabled_flag
      comment: "Whether cash-on-delivery is enabled for merchant"
    - name: "is_returns_enabled"
      expr: returns_enabled_flag
      comment: "Whether returns are enabled for merchant"
    - name: "is_aeo_certified"
      expr: aeo_certified_flag
      comment: "Whether merchant is Authorized Economic Operator certified"
    - name: "country"
      expr: business_country_code
      comment: "Country code of merchant business location"
    - name: "onboarding_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month merchant was onboarded"
  measures:
    - name: "total_merchants"
      expr: COUNT(1)
      comment: "Total number of merchant accounts"
    - name: "active_merchants"
      expr: SUM(CASE WHEN merchant_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active merchant accounts"
    - name: "merchant_activation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN merchant_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merchants with active status"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to all merchants"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per merchant"
    - name: "avg_daily_order_volume"
      expr: AVG(CAST(average_daily_order_volume AS DOUBLE))
      comment: "Average daily order volume across merchants"
    - name: "cod_enabled_merchants"
      expr: SUM(CASE WHEN cod_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of merchants with COD enabled"
    - name: "cod_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cod_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merchants with COD service enabled"
    - name: "returns_enabled_merchants"
      expr: SUM(CASE WHEN returns_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of merchants with returns enabled"
    - name: "returns_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN returns_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merchants with returns service enabled"
    - name: "aeo_certified_merchants"
      expr: SUM(CASE WHEN aeo_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of AEO certified merchants"
    - name: "avg_peak_season_multiplier"
      expr: AVG(CAST(peak_season_multiplier AS DOUBLE))
      comment: "Average peak season volume multiplier across merchants"
    - name: "terminated_merchants"
      expr: SUM(CASE WHEN merchant_status = 'terminated' THEN 1 ELSE 0 END)
      comment: "Number of terminated merchant accounts"
    - name: "merchant_churn_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN merchant_status = 'terminated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merchants that have been terminated"
$$;