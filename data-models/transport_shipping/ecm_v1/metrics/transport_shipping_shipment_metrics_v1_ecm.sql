-- Metric views for domain: shipment | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_consignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core consignment-level metrics covering shipment volume, weight utilization, declared values, and service mix analysis for strategic logistics performance management."
  source: "`transport_shipping_ecm`.`shipment`.`consignment`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of shipping service (e.g., express, standard, economy) for service mix analysis"
    - name: "service_level"
      expr: service_level
      comment: "Service level tier (e.g., next-day, 2-day, ground) for SLA segmentation"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for trade lane analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane and market analysis"
    - name: "origin_city"
      expr: origin_city
      comment: "Origin city for regional performance analysis"
    - name: "destination_city"
      expr: destination_city
      comment: "Destination city for demand and delivery analysis"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current consignment lifecycle status for pipeline visibility"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the booking was made for channel performance analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Shipment priority level for workload prioritization"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing the shipment"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the consignment contains dangerous goods"
    - name: "is_cod"
      expr: is_cod
      comment: "Whether the consignment is cash-on-delivery"
    - name: "booking_date"
      expr: booking_date
      comment: "Date the consignment was booked for time-series analysis"
  measures:
    - name: "total_consignments"
      expr: COUNT(1)
      comment: "Total number of consignments — baseline volume metric for capacity planning and demand forecasting"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kg — primary revenue driver metric for yield management"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared shipment value — risk exposure and insurance planning metric"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per consignment — shipment profile indicator for network design"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total shipment volume in cubic meters — capacity utilization planning metric"
    - name: "avg_volume_per_consignment_cbm"
      expr: AVG(CAST(volume_cbm AS DOUBLE))
      comment: "Average volume per consignment — density and load optimization indicator"
    - name: "total_cod_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount — cash flow and collection risk metric"
    - name: "weight_utilization_ratio_numerator"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Chargeable weight total (numerator for weight vs volumetric utilization ratio computed in BI layer)"
    - name: "volumetric_weight_total"
      expr: SUM(CAST(volumetric_weight_kg AS DOUBLE))
      comment: "Total volumetric weight — denominator for dim-weight factor analysis in BI layer"
    - name: "distinct_origin_countries"
      expr: COUNT(DISTINCT origin_country_code)
      comment: "Number of distinct origin countries — network breadth indicator"
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of distinct destination countries — market reach indicator"
    - name: "dangerous_goods_consignments"
      expr: SUM(CASE WHEN is_dangerous_goods = true THEN 1 ELSE 0 END)
      comment: "Count of dangerous goods consignments — compliance workload and risk metric"
    - name: "cod_consignments"
      expr: SUM(CASE WHEN is_cod = true THEN 1 ELSE 0 END)
      comment: "Count of COD consignments — cash collection operations workload metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_consignment_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment milestone and status transition metrics for operational visibility, exception monitoring, and SLA breach tracking."
  source: "`transport_shipping_ecm`.`shipment`.`consignment_status`"
  dimensions:
    - name: "new_status_code"
      expr: new_status_code
      comment: "New status after transition for milestone funnel analysis"
    - name: "previous_status_code"
      expr: previous_status_code
      comment: "Previous status before transition for flow analysis"
    - name: "milestone_code"
      expr: milestone_code
      comment: "Milestone type code for operational milestone tracking"
    - name: "scan_type"
      expr: scan_type
      comment: "Type of scan event for operational process analysis"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether this status event represents an exception"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether this event triggered an SLA breach"
    - name: "route_deviation_flag"
      expr: route_deviation_flag
      comment: "Whether a route deviation was detected"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system generating the status event"
    - name: "status_reason_code"
      expr: status_reason_code
      comment: "Reason code for the status change"
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total status transition events — operational throughput and scan compliance metric"
    - name: "exception_events"
      expr: SUM(CASE WHEN exception_flag = true THEN 1 ELSE 0 END)
      comment: "Count of exception events — operational quality and disruption frequency metric"
    - name: "sla_breach_events"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Count of SLA breach events — service quality failure metric driving penalty exposure"
    - name: "route_deviation_events"
      expr: SUM(CASE WHEN route_deviation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of route deviation events — network compliance and cost leakage indicator"
    - name: "distinct_consignments_tracked"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Distinct consignments with status updates — tracking coverage metric"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average recorded temperature — cold chain compliance monitoring metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment revenue and charge metrics for financial performance, yield management, and billing accuracy analysis."
  source: "`transport_shipping_ecm`.`shipment`.`shipment_charge`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge (freight, fuel surcharge, accessorial, etc.) for revenue composition analysis"
    - name: "charge_code"
      expr: charge_code
      comment: "Specific charge code for granular pricing analysis"
    - name: "charge_status"
      expr: charge_status
      comment: "Status of the charge (pending, approved, invoiced, disputed) for billing pipeline visibility"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge for multi-currency revenue analysis"
    - name: "application_level"
      expr: application_level
      comment: "Level at which charge is applied (consignment, leg, package)"
    - name: "waived_flag"
      expr: waived_flag
      comment: "Whether the charge was waived — revenue leakage indicator"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the charge is disputed — billing quality indicator"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Invoice date for revenue recognition timing analysis"
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Revenue recognition date for financial reporting alignment"
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross charge amount — primary revenue metric for financial performance"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts — realized revenue metric"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount given — pricing erosion and commercial effectiveness metric"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount — tax liability and compliance metric"
    - name: "avg_charge_per_record"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average charge amount per line item — yield per charge indicator"
    - name: "total_charge_lines"
      expr: COUNT(1)
      comment: "Total charge line items — billing volume and complexity metric"
    - name: "disputed_charges"
      expr: SUM(CASE WHEN dispute_flag = true THEN 1 ELSE 0 END)
      comment: "Count of disputed charges — billing accuracy and customer satisfaction indicator"
    - name: "waived_charges"
      expr: SUM(CASE WHEN waived_flag = true THEN 1 ELSE 0 END)
      comment: "Count of waived charges — revenue leakage and goodwill cost metric"
    - name: "waived_charge_amount"
      expr: SUM(CASE WHEN waived_flag = true THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of waived charges — quantified revenue leakage"
    - name: "disputed_charge_amount"
      expr: SUM(CASE WHEN dispute_flag = true THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of disputed charges — financial risk from billing disputes"
    - name: "distinct_consignments_charged"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Distinct consignments with charges — billing coverage metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_exception_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exception and disruption metrics for operational quality management, root cause analysis, and service recovery performance."
  source: "`transport_shipping_ecm`.`shipment`.`exception_event`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (damage, delay, loss, misroute, etc.) for root cause categorization"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the exception for prioritization and escalation analysis"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of exception resolution for aging and backlog analysis"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for systemic improvement initiatives"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the exception for accountability and vendor management"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the exception caused an SLA breach"
    - name: "sla_breach_type"
      expr: sla_breach_type
      comment: "Type of SLA breach triggered by the exception"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the exception was escalated"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the exception was preventable — process improvement opportunity indicator"
    - name: "claim_eligible_flag"
      expr: claim_eligible_flag
      comment: "Whether the exception is eligible for a cargo claim"
    - name: "exception_location_country_code"
      expr: exception_location_country_code
      comment: "Country where exception occurred for geographic risk analysis"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total exception events — primary operational quality metric"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of exceptions — cost of quality metric for P&L impact"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception — severity benchmarking metric"
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration in hours — service recovery speed indicator"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all exceptions — aggregate service disruption metric"
    - name: "sla_breach_exceptions"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Exceptions causing SLA breaches — penalty exposure and service failure metric"
    - name: "escalated_exceptions"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Escalated exceptions — management attention and process failure indicator"
    - name: "preventable_exceptions"
      expr: SUM(CASE WHEN preventable_flag = true THEN 1 ELSE 0 END)
      comment: "Preventable exceptions — addressable quality improvement opportunity metric"
    - name: "claim_eligible_exceptions"
      expr: SUM(CASE WHEN claim_eligible_flag = true THEN 1 ELSE 0 END)
      comment: "Claim-eligible exceptions — potential claims liability metric"
    - name: "distinct_consignments_with_exceptions"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Distinct consignments affected by exceptions — shipment quality rate denominator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_sla_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA commitment and on-time delivery performance metrics for service quality management, penalty tracking, and customer satisfaction."
  source: "`transport_shipping_ecm`.`shipment`.`shipment_sla_commitment`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current SLA status (met, breached, at-risk, waived) for performance categorization"
    - name: "sla_type_code"
      expr: sla_type_code
      comment: "Type of SLA commitment for service tier analysis"
    - name: "service_level_code"
      expr: service_level_code
      comment: "Service level associated with the SLA commitment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the SLA commitment"
    - name: "sla_source"
      expr: sla_source
      comment: "Source of the SLA definition (contract, rate card, standard)"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location for lane-level SLA performance analysis"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location for lane-level SLA performance analysis"
    - name: "breach_reason_code"
      expr: breach_reason_code
      comment: "Reason for SLA breach for root cause analysis"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether the SLA breach was waived"
    - name: "force_majeure_flag"
      expr: force_majeure_flag
      comment: "Whether force majeure was invoked"
    - name: "committed_delivery_date"
      expr: committed_delivery_date
      comment: "Committed delivery date for time-based SLA analysis"
  measures:
    - name: "total_sla_commitments"
      expr: COUNT(1)
      comment: "Total SLA commitments — baseline for on-time delivery rate calculation"
    - name: "sla_breaches"
      expr: SUM(CASE WHEN sla_status = 'breached' THEN 1 ELSE 0 END)
      comment: "Total SLA breaches — primary service failure metric"
    - name: "sla_met"
      expr: SUM(CASE WHEN sla_status = 'met' THEN 1 ELSE 0 END)
      comment: "Total SLAs met — service success metric for OTD rate numerator"
    - name: "total_breach_penalty_amount"
      expr: SUM(CAST(breach_penalty_amount AS DOUBLE))
      comment: "Total breach penalty amount — financial cost of service failures"
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average committed transit time in hours — service speed benchmark"
    - name: "waived_breaches"
      expr: SUM(CASE WHEN waiver_flag = true THEN 1 ELSE 0 END)
      comment: "Waived SLA breaches — goodwill cost and exception management metric"
    - name: "force_majeure_events"
      expr: SUM(CASE WHEN force_majeure_flag = true THEN 1 ELSE 0 END)
      comment: "Force majeure invocations — external disruption frequency metric"
    - name: "breach_penalty_flagged"
      expr: SUM(CASE WHEN breach_penalty_flag = true THEN 1 ELSE 0 END)
      comment: "Commitments with penalty triggered — contractual liability exposure metric"
    - name: "distinct_customers_with_sla"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Distinct customers with SLA commitments — contracted service coverage metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment leg-level metrics for transport network performance, cost efficiency, carbon emissions, and multi-modal operations analysis."
  source: "`transport_shipping_ecm`.`shipment`.`shipment_leg`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail) for modal split analysis"
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the shipment leg for pipeline visibility"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for network flow analysis"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for network flow analysis"
    - name: "customs_clearance_required_flag"
      expr: customs_clearance_required_flag
      comment: "Whether customs clearance is required on this leg"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the leg carries hazardous materials"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether temperature control is required"
    - name: "service_level_code"
      expr: service_level_code
      comment: "Service level for the leg"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason for delay on this leg for root cause analysis"
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Total shipment legs — network activity volume metric"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered in km — network utilization and carbon footprint driver"
    - name: "avg_distance_per_leg_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance per leg — network design efficiency indicator"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total transport cost — primary cost metric for margin analysis"
    - name: "avg_cost_per_leg"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per leg — unit economics and carrier rate benchmarking"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions in kg — sustainability KPI for ESG reporting"
    - name: "avg_carbon_per_leg_kg"
      expr: AVG(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Average carbon emissions per leg — emissions intensity metric"
    - name: "distinct_consignments"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Distinct consignments with legs — multi-leg shipment analysis"
    - name: "customs_required_legs"
      expr: SUM(CASE WHEN customs_clearance_required_flag = true THEN 1 ELSE 0 END)
      comment: "Legs requiring customs clearance — cross-border operations workload metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_pod`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof of delivery metrics for last-mile performance, COD collection efficiency, and delivery quality management."
  source: "`transport_shipping_ecm`.`shipment`.`pod`"
  dimensions:
    - name: "pod_status"
      expr: pod_status
      comment: "POD status for delivery confirmation pipeline analysis"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (direct, locker, neighbour, safe place) for last-mile strategy analysis"
    - name: "delivery_city"
      expr: delivery_city
      comment: "Delivery city for geographic performance analysis"
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Delivery country for international last-mile analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for COD collection analysis"
    - name: "remittance_status"
      expr: remittance_status
      comment: "COD remittance status for cash flow tracking"
    - name: "dispute_raised_flag"
      expr: dispute_raised_flag
      comment: "Whether a delivery dispute was raised"
    - name: "delivery_exception_code"
      expr: delivery_exception_code
      comment: "Exception code at delivery for failed delivery analysis"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total proof of delivery records — delivery volume metric"
    - name: "total_cod_collected"
      expr: SUM(CAST(amount_collected AS DOUBLE))
      comment: "Total COD amount collected — cash collection performance metric"
    - name: "total_cod_expected"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total expected COD amount — collection target metric"
    - name: "total_collection_variance"
      expr: SUM(CAST(collection_variance_amount AS DOUBLE))
      comment: "Total collection variance — cash reconciliation and leakage metric"
    - name: "disputed_deliveries"
      expr: SUM(CASE WHEN dispute_raised_flag = true THEN 1 ELSE 0 END)
      comment: "Deliveries with disputes raised — delivery quality and customer satisfaction metric"
    - name: "distinct_consignments_delivered"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Distinct consignments with POD — delivery completion coverage metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_return_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return shipment metrics for reverse logistics performance, return cost management, and customer experience analysis."
  source: "`transport_shipping_ecm`.`shipment`.`return_shipment`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current return status for pipeline and aging analysis"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason for return for root cause and product quality analysis"
    - name: "return_type"
      expr: return_type
      comment: "Type of return (customer-initiated, carrier-initiated, refused) for process analysis"
    - name: "return_initiator"
      expr: return_initiator
      comment: "Who initiated the return for accountability analysis"
    - name: "return_service_type"
      expr: return_service_type
      comment: "Service type used for the return shipment"
    - name: "return_transport_mode"
      expr: return_transport_mode
      comment: "Transport mode for the return for cost optimization"
    - name: "return_disposition_code"
      expr: return_disposition_code
      comment: "Disposition of returned goods (restock, refurbish, dispose) for inventory impact"
    - name: "return_freight_paid_by"
      expr: return_freight_paid_by
      comment: "Party paying return freight for cost allocation analysis"
    - name: "return_pickup_country_code"
      expr: return_pickup_country_code
      comment: "Country of return pickup for geographic analysis"
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total return shipments — reverse logistics volume metric"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount — financial impact of returns on revenue"
    - name: "total_return_freight_charge"
      expr: SUM(CAST(return_freight_charge_amount AS DOUBLE))
      comment: "Total return freight charges — reverse logistics cost metric"
    - name: "total_restocking_fee"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected — cost recovery from returns"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund per return — return value profile metric"
    - name: "distinct_customers_returning"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Distinct customers with returns — return propensity and experience metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_freight_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight manifest metrics for load planning efficiency, capacity utilization, transport cost management, and network operations."
  source: "`transport_shipping_ecm`.`shipment`.`freight_manifest`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for modal performance comparison"
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current manifest status for operations pipeline visibility"
    - name: "origin_facility_code"
      expr: origin_facility_code
      comment: "Origin facility for hub performance analysis"
    - name: "destination_facility_code"
      expr: destination_facility_code
      comment: "Destination facility for network flow analysis"
    - name: "service_level_code"
      expr: service_level_code
      comment: "Service level for the manifest movement"
    - name: "equipment_type_code"
      expr: equipment_type_code
      comment: "Equipment type for fleet utilization analysis"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether manifest contains dangerous goods"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether temperature control is required"
    - name: "route_code"
      expr: route_code
      comment: "Route code for lane-level performance analysis"
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total freight manifests — network movement volume metric"
    - name: "total_manifest_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight on manifests — capacity utilization metric"
    - name: "total_manifest_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume on manifests — space utilization metric"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(total_chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight — revenue-bearing weight metric"
    - name: "total_manifest_cost"
      expr: SUM(CAST(manifest_cost_amount AS DOUBLE))
      comment: "Total manifest transport cost — network cost metric"
    - name: "avg_manifest_cost"
      expr: AVG(CAST(manifest_cost_amount AS DOUBLE))
      comment: "Average cost per manifest — unit cost benchmarking metric"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emissions_kg AS DOUBLE))
      comment: "Total carbon emissions from manifests — sustainability reporting metric"
    - name: "avg_weight_per_manifest_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per manifest — load density indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`shipment_carrier_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier assignment and performance metrics for carrier management, procurement optimization, and transport cost control."
  source: "`transport_shipping_ecm`.`shipment`.`shipment_carrier_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status for carrier allocation pipeline analysis"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method of carrier assignment (auto, manual, auction) for procurement efficiency"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode for modal carrier performance comparison"
    - name: "service_type"
      expr: service_type
      comment: "Service type for carrier service mix analysis"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type for fleet and capacity analysis"
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Whether carrier delivered on time — carrier quality indicator"
    - name: "contract_rate_flag"
      expr: contract_rate_flag
      comment: "Whether contracted rate was used vs spot rate"
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the carrier rate for multi-currency analysis"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total carrier assignments — carrier utilization volume metric"
    - name: "total_carrier_charge"
      expr: SUM(CAST(total_carrier_charge AS DOUBLE))
      comment: "Total carrier charges — primary transport procurement cost metric"
    - name: "avg_carrier_charge"
      expr: AVG(CAST(total_carrier_charge AS DOUBLE))
      comment: "Average carrier charge per assignment — unit cost benchmarking"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharges — fuel cost exposure metric"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN on_time_delivery_flag = true THEN 1 ELSE 0 END)
      comment: "On-time deliveries by carriers — carrier OTD performance numerator"
    - name: "contract_rate_assignments"
      expr: SUM(CASE WHEN contract_rate_flag = true THEN 1 ELSE 0 END)
      comment: "Assignments using contract rates — procurement compliance metric"
    - name: "avg_carrier_performance_rating"
      expr: AVG(CAST(carrier_performance_rating AS DOUBLE))
      comment: "Average carrier performance rating — carrier quality scorecard metric"
    - name: "distinct_carriers_used"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Distinct carriers used — carrier diversification and concentration risk metric"
$$;