-- Metric views for domain: fulfillment | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fulfillment order metrics tracking order volume, value, SLA performance, and operational throughput across the fulfillment lifecycle."
  source: "`transport_shipping_ecm`.`fulfillment`.`fulfillment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the fulfillment order (e.g., received, picked, packed, dispatched, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of fulfillment order (e.g., standard, express, return)"
    - name: "service_type"
      expr: service_type
      comment: "Service level type (e.g., same-day, next-day, standard, economy)"
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Mode of fulfillment (e.g., warehouse, drop-ship, cross-dock)"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel from which the order originated (e.g., marketplace, direct, API)"
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Destination country code for the delivery"
    - name: "delivery_city"
      expr: delivery_city
      comment: "Destination city for the delivery"
    - name: "is_cod"
      expr: cod_flag
      comment: "Whether the order is cash-on-delivery"
    - name: "is_return"
      expr: return_flag
      comment: "Whether this is a return order"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether the order breached its SLA commitment"
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date promised to the customer for delivery"
    - name: "order_created_date"
      expr: DATE(created_timestamp)
      comment: "Date the fulfillment order was created"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "total_order_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total declared monetary value of all fulfillment orders"
    - name: "avg_order_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average monetary value per fulfillment order"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all orders"
    - name: "total_order_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters across all orders"
    - name: "sla_breached_order_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of orders that breached their SLA target"
    - name: "cod_order_count"
      expr: COUNT(CASE WHEN cod_flag = TRUE THEN 1 END)
      comment: "Number of cash-on-delivery orders"
    - name: "total_cod_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount to be collected"
    - name: "return_order_count"
      expr: COUNT(CASE WHEN return_flag = TRUE THEN 1 END)
      comment: "Number of return orders processed"
    - name: "avg_weight_per_order_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per order in kilograms, indicating shipment density"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_delivery_attempt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery attempt performance metrics measuring first-attempt success rates, failure analysis, and last-mile delivery efficiency."
  source: "`transport_shipping_ecm`.`fulfillment`.`delivery_attempt`"
  dimensions:
    - name: "attempt_outcome_code"
      expr: attempt_outcome_code
      comment: "Outcome of the delivery attempt (e.g., delivered, failed, partial)"
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Reason code for failed delivery attempts"
    - name: "attempt_number"
      expr: attempt_number
      comment: "Sequential number of this delivery attempt for the shipment"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether this attempt breached the SLA target"
    - name: "is_cod_collected"
      expr: cod_collected_flag
      comment: "Whether COD payment was collected on this attempt"
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather conditions during the delivery attempt"
    - name: "delivery_city"
      expr: delivery_city
      comment: "City where delivery was attempted"
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country where delivery was attempted"
    - name: "attempt_date"
      expr: attempt_date
      comment: "Date of the delivery attempt"
    - name: "has_epod_signature"
      expr: epod_signature_captured_flag
      comment: "Whether electronic proof of delivery signature was captured"
    - name: "has_epod_photo"
      expr: epod_photo_captured_flag
      comment: "Whether electronic proof of delivery photo was captured"
  measures:
    - name: "total_delivery_attempts"
      expr: COUNT(1)
      comment: "Total number of delivery attempts made"
    - name: "successful_delivery_count"
      expr: COUNT(CASE WHEN attempt_outcome_code = 'DELIVERED' THEN 1 END)
      comment: "Number of successful deliveries"
    - name: "failed_delivery_count"
      expr: COUNT(CASE WHEN failure_reason_code IS NOT NULL THEN 1 END)
      comment: "Number of failed delivery attempts"
    - name: "first_attempt_delivery_count"
      expr: COUNT(CASE WHEN attempt_number = '1' AND attempt_outcome_code = 'DELIVERED' THEN 1 END)
      comment: "Number of deliveries successful on first attempt — key last-mile efficiency indicator"
    - name: "sla_breached_attempt_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of delivery attempts that breached SLA targets"
    - name: "cod_collected_count"
      expr: COUNT(CASE WHEN cod_collected_flag = TRUE THEN 1 END)
      comment: "Number of attempts where COD was successfully collected"
    - name: "total_cod_amount_collected"
      expr: SUM(CASE WHEN cod_collected_flag = TRUE THEN CAST(cod_amount AS DOUBLE) ELSE 0 END)
      comment: "Total COD amount successfully collected across all attempts"
    - name: "epod_signature_capture_count"
      expr: COUNT(CASE WHEN epod_signature_captured_flag = TRUE THEN 1 END)
      comment: "Number of attempts with electronic proof of delivery signature captured"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_parcel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parcel-level metrics tracking shipment volumes, weight distribution, dimensional efficiency, and declared values for logistics optimization."
  source: "`transport_shipping_ecm`.`fulfillment`.`parcel`"
  dimensions:
    - name: "parcel_status"
      expr: parcel_status
      comment: "Current status of the parcel in the fulfillment pipeline"
    - name: "carrier_service_code"
      expr: carrier_service_code
      comment: "Carrier service code used for this parcel"
    - name: "carrier_service_name"
      expr: carrier_service_name
      comment: "Human-readable carrier service name"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the parcel"
    - name: "destination_city"
      expr: destination_city
      comment: "Destination city for the parcel"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging used (e.g., box, envelope, pallet)"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether the parcel contains hazardous materials"
    - name: "is_cod"
      expr: cod_flag
      comment: "Whether the parcel requires cash-on-delivery collection"
    - name: "is_signature_required"
      expr: signature_required_flag
      comment: "Whether signature is required upon delivery"
    - name: "origin_facility_code"
      expr: origin_facility_code
      comment: "Originating fulfillment facility code"
    - name: "sla_target_delivery_date"
      expr: sla_target_delivery_date
      comment: "SLA target date for parcel delivery"
  measures:
    - name: "total_parcels"
      expr: COUNT(1)
      comment: "Total number of parcels in the system"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight of all parcels in kilograms"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight (max of actual and dimensional) in kilograms"
    - name: "total_dimensional_weight_kg"
      expr: SUM(CAST(dimensional_weight_kg AS DOUBLE))
      comment: "Total dimensional (volumetric) weight in kilograms"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per parcel — key for rate optimization"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of all parcels for insurance and customs purposes"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of all parcels in cubic meters"
    - name: "avg_volume_per_parcel_cbm"
      expr: AVG(CAST(volume_cbm AS DOUBLE))
      comment: "Average volume per parcel in cubic meters"
    - name: "hazmat_parcel_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of parcels containing hazardous materials requiring special handling"
    - name: "total_cod_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount across all COD parcels"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach analytics measuring service level compliance, penalty exposure, breach severity distribution, and resolution performance."
  source: "`transport_shipping_ecm`.`fulfillment`.`sla_breach`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of SLA breach (e.g., late delivery, missed pickup, processing delay)"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the breach (e.g., critical, major, minor)"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (e.g., open, resolved, disputed)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause for the breach"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the breach (e.g., carrier, warehouse, customs)"
    - name: "is_penalty_applicable"
      expr: penalty_applicable_flag
      comment: "Whether a financial penalty applies to this breach"
    - name: "is_disputed"
      expr: dispute_flag
      comment: "Whether the breach is being disputed"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation for the breach"
    - name: "is_customer_notified"
      expr: customer_notification_flag
      comment: "Whether the customer was notified of the breach"
    - name: "breach_detected_date"
      expr: DATE(breach_detected_timestamp)
      comment: "Date the breach was detected"
  measures:
    - name: "total_sla_breaches"
      expr: COUNT(1)
      comment: "Total number of SLA breaches recorded"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty amount from SLA breaches"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per breach — indicates severity of service failures"
    - name: "penalty_applicable_breach_count"
      expr: COUNT(CASE WHEN penalty_applicable_flag = TRUE THEN 1 END)
      comment: "Number of breaches where financial penalties apply"
    - name: "disputed_breach_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of breaches currently under dispute"
    - name: "critical_breach_count"
      expr: COUNT(CASE WHEN breach_severity = 'CRITICAL' THEN 1 END)
      comment: "Number of critical-severity SLA breaches requiring immediate attention"
    - name: "resolved_breach_count"
      expr: COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of breaches that have been resolved"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of breaches requiring corrective action plans"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exception management metrics tracking operational disruptions, financial impact, resolution efficiency, and preventability for continuous improvement."
  source: "`transport_shipping_ecm`.`fulfillment`.`fulfillment_exception`"
  dimensions:
    - name: "exception_category"
      expr: exception_category
      comment: "Category of the exception (e.g., damage, shortage, mislabel, delay)"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (e.g., open, investigating, resolved, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the exception"
    - name: "type_code"
      expr: type_code
      comment: "Specific type code for the exception"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code"
    - name: "is_escalated"
      expr: escalation_flag
      comment: "Whether the exception has been escalated"
    - name: "is_preventable"
      expr: preventable_flag
      comment: "Whether the exception was deemed preventable"
    - name: "is_compliance_breach"
      expr: compliance_breach_flag
      comment: "Whether the exception constitutes a compliance breach"
    - name: "is_recurrence"
      expr: recurrence_flag
      comment: "Whether this is a recurring exception"
    - name: "detected_by_source"
      expr: detected_by_source
      comment: "System or process that detected the exception"
    - name: "raised_date"
      expr: DATE(raised_timestamp)
      comment: "Date the exception was raised"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of fulfillment exceptions raised"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount from all exceptions"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception"
    - name: "escalated_exception_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of exceptions that required escalation"
    - name: "preventable_exception_count"
      expr: COUNT(CASE WHEN preventable_flag = TRUE THEN 1 END)
      comment: "Number of exceptions classified as preventable — key for process improvement"
    - name: "compliance_breach_count"
      expr: COUNT(CASE WHEN compliance_breach_flag = TRUE THEN 1 END)
      comment: "Number of exceptions that constitute compliance breaches"
    - name: "recurring_exception_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring exceptions indicating systemic issues"
    - name: "resolved_exception_count"
      expr: COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of exceptions that have been resolved"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorization metrics tracking return volumes, refund exposure, processing efficiency, and return policy compliance."
  source: "`transport_shipping_ecm`.`fulfillment`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g., requested, approved, received, inspected, refunded)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "condition_assessment_code"
      expr: condition_assessment_code
      comment: "Condition of the returned item upon inspection"
    - name: "disposition_instruction"
      expr: disposition_instruction
      comment: "Disposition action for the returned item (e.g., restock, refurbish, dispose)"
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund (e.g., original payment, store credit)"
    - name: "return_service_level"
      expr: return_service_level
      comment: "Service level for the return shipment"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether the RMA processing breached SLA"
    - name: "is_restocked"
      expr: restocked_flag
      comment: "Whether the returned item was restocked"
    - name: "is_policy_compliant"
      expr: return_policy_compliant_flag
      comment: "Whether the return complies with the return policy"
    - name: "is_merchant_approved"
      expr: merchant_approved_flag
      comment: "Whether the merchant approved the return"
    - name: "request_date"
      expr: DATE(request_timestamp)
      comment: "Date the RMA was requested"
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of Return Merchandise Authorizations"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all RMAs"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA"
    - name: "total_restocking_fee"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees charged on returns"
    - name: "sla_breached_rma_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of RMAs that breached processing SLA"
    - name: "restocked_rma_count"
      expr: COUNT(CASE WHEN restocked_flag = TRUE THEN 1 END)
      comment: "Number of returned items successfully restocked into inventory"
    - name: "policy_non_compliant_count"
      expr: COUNT(CASE WHEN return_policy_compliant_flag = FALSE THEN 1 END)
      comment: "Number of returns that did not comply with return policy"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wave planning and execution metrics measuring warehouse throughput, pick-pack efficiency, and fulfillment capacity utilization."
  source: "`transport_shipping_ecm`.`fulfillment`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave (e.g., planned, released, in-progress, completed, cancelled)"
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g., standard, priority, bulk)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the wave"
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method used (e.g., batch, zone, discrete)"
    - name: "carrier_service_type"
      expr: carrier_service_type
      comment: "Carrier service type targeted by this wave"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether the wave breached its SLA target"
    - name: "target_ship_date"
      expr: target_ship_date
      comment: "Target shipping date for the wave"
    - name: "assigned_zone_code"
      expr: assigned_zone_code
      comment: "Warehouse zone assigned for this wave"
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of fulfillment waves planned or executed"
    - name: "avg_wave_efficiency_pct"
      expr: AVG(CAST(efficiency_percent AS DOUBLE))
      comment: "Average wave execution efficiency percentage — key warehouse productivity indicator"
    - name: "total_wave_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight processed across all waves in kilograms"
    - name: "total_wave_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume processed across all waves in cubic meters"
    - name: "sla_breached_wave_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of waves that breached their SLA targets"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_dispatch_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch run metrics measuring route efficiency, vehicle utilization, delivery success rates, and last-mile operational performance."
  source: "`transport_shipping_ecm`.`fulfillment`.`dispatch_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the dispatch run"
    - name: "dispatch_type"
      expr: dispatch_type
      comment: "Type of dispatch (e.g., scheduled, ad-hoc, express)"
    - name: "is_sla_breached"
      expr: sla_breach_flag
      comment: "Whether the dispatch run breached its SLA target"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Whether the run includes hazardous materials"
    - name: "is_temperature_controlled"
      expr: temperature_controlled_flag
      comment: "Whether the run requires temperature-controlled transport"
    - name: "origin_depot_code"
      expr: origin_depot_code
      comment: "Origin depot from which the dispatch run starts"
    - name: "run_date"
      expr: run_date
      comment: "Date of the dispatch run"
  measures:
    - name: "total_dispatch_runs"
      expr: COUNT(1)
      comment: "Total number of dispatch runs executed"
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance covered across all dispatch runs in kilometers"
    - name: "total_planned_distance_km"
      expr: SUM(CAST(planned_distance_km AS DOUBLE))
      comment: "Total planned distance across all dispatch runs in kilometers"
    - name: "avg_vehicle_utilization_pct"
      expr: AVG(CAST(vehicle_utilization_percentage AS DOUBLE))
      comment: "Average vehicle capacity utilization percentage — key fleet efficiency metric"
    - name: "total_weight_dispatched_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight dispatched across all runs in kilograms"
    - name: "total_volume_dispatched_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume dispatched across all runs in cubic meters"
    - name: "total_cod_collected"
      expr: SUM(CAST(total_cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount collected across all dispatch runs"
    - name: "sla_breached_run_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of dispatch runs that breached their SLA completion targets"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_merchant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchant portfolio metrics tracking merchant health, credit exposure, SLA targets, and operational capacity for partner management."
  source: "`transport_shipping_ecm`.`fulfillment`.`merchant`"
  dimensions:
    - name: "merchant_status"
      expr: merchant_status
      comment: "Current status of the merchant (e.g., active, suspended, terminated)"
    - name: "merchant_tier"
      expr: merchant_tier
      comment: "Tier classification of the merchant (e.g., platinum, gold, silver)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the merchant"
    - name: "platform_type"
      expr: platform_type
      comment: "E-commerce platform type used by the merchant"
    - name: "integration_channel"
      expr: integration_channel
      comment: "Integration channel used (e.g., API, EDI, portal)"
    - name: "default_service_level"
      expr: default_service_level
      comment: "Default service level for the merchant's shipments"
    - name: "business_country_code"
      expr: business_country_code
      comment: "Country where the merchant is based"
    - name: "is_cod_enabled"
      expr: cod_enabled_flag
      comment: "Whether COD service is enabled for this merchant"
    - name: "is_returns_enabled"
      expr: returns_enabled_flag
      comment: "Whether returns service is enabled for this merchant"
    - name: "is_aeo_certified"
      expr: aeo_certified_flag
      comment: "Whether the merchant holds Authorized Economic Operator certification"
  measures:
    - name: "total_merchants"
      expr: COUNT(1)
      comment: "Total number of merchants in the fulfillment network"
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit exposure across all merchants"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per merchant"
    - name: "avg_otd_target_pct"
      expr: AVG(CAST(sla_on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery SLA target percentage across merchants"
    - name: "avg_order_accuracy_target_pct"
      expr: AVG(CAST(sla_order_accuracy_target_pct AS DOUBLE))
      comment: "Average order accuracy SLA target percentage across merchants"
    - name: "active_merchant_count"
      expr: COUNT(CASE WHEN merchant_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active merchants"
    - name: "avg_peak_season_multiplier"
      expr: AVG(CAST(peak_season_multiplier AS DOUBLE))
      comment: "Average peak season volume multiplier — indicates seasonal capacity planning needs"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fulfillment_parcel_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parcel manifest metrics tracking carrier handoff volumes, weight throughput, and manifest reconciliation for carrier management."
  source: "`transport_shipping_ecm`.`fulfillment`.`parcel_manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest (e.g., created, dispatched, in-transit, delivered, reconciled)"
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (e.g., outbound, inbound, transfer)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (e.g., road, air, rail, sea)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the manifest with carrier"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the manifest"
    - name: "destination_city"
      expr: destination_city
      comment: "Destination city for the manifest"
    - name: "contains_hazmat"
      expr: contains_hazmat_flag
      comment: "Whether the manifest contains hazardous materials"
    - name: "contains_high_value"
      expr: contains_high_value_flag
      comment: "Whether the manifest contains high-value items"
    - name: "edi_transmission_status"
      expr: edi_transmission_status
      comment: "Status of EDI transmission to carrier"
    - name: "dispatch_date"
      expr: dispatch_date
      comment: "Date the manifest was dispatched"
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total number of parcel manifests created"
    - name: "total_manifest_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight across all manifests in kilograms"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(total_chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight across all manifests"
    - name: "total_manifest_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume across all manifests in cubic meters"
    - name: "total_declared_value"
      expr: SUM(CAST(total_declared_value_amount AS DOUBLE))
      comment: "Total declared value across all manifests"
    - name: "total_cod_amount"
      expr: SUM(CAST(total_cod_amount AS DOUBLE))
      comment: "Total COD amount across all manifests"
    - name: "avg_weight_per_manifest_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per manifest — indicates consolidation efficiency"
$$;