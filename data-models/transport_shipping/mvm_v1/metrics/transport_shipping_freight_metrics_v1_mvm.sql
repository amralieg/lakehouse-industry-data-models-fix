-- Metric views for domain: freight | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core freight order performance metrics tracking revenue, volume, weight, emissions, and service quality across transport modes and lanes"
  source: "`transport_shipping_ecm`.`freight`.`freight_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the freight order (e.g., booked, in-transit, delivered, cancelled)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (air, ocean, rail, truck, intermodal)"
    - name: "service_type"
      expr: service_type
      comment: "Service type classification (express, standard, economy)"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Country code of shipment origin"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "incoterms"
      expr: incoterms_code
      comment: "International commercial terms governing responsibility and risk transfer"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether shipment contains hazardous materials"
    - name: "is_nvocc"
      expr: is_nvocc
      comment: "Flag indicating non-vessel operating common carrier arrangement"
    - name: "booking_year"
      expr: YEAR(booking_date)
      comment: "Year the freight order was booked"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month the freight order was booked"
    - name: "booking_quarter"
      expr: DATE_TRUNC('QUARTER', booking_date)
      comment: "Quarter the freight order was booked"
  measures:
    - name: "total_freight_revenue"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total freight revenue across all orders - primary top-line KPI for business performance"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Base freight charges excluding surcharges - core transportation cost component"
    - name: "total_surcharges"
      expr: SUM(CAST(total_surcharge_amount AS DOUBLE))
      comment: "Total surcharge amounts (fuel, peak season, etc.) - key margin and pricing insight"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average revenue per freight order - critical for pricing strategy and customer segmentation"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms - capacity planning and network optimization metric"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight (actual or dimensional) - revenue yield calculation basis"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters - asset utilization and capacity planning KPI"
    - name: "total_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total twenty-foot equivalent units - ocean freight capacity and pricing benchmark"
    - name: "total_co2e_emissions_kg"
      expr: SUM(CAST(co2e_emissions_kg AS DOUBLE))
      comment: "Total carbon dioxide equivalent emissions - ESG reporting and sustainability KPI"
    - name: "revenue_per_kg"
      expr: ROUND(SUM(CAST(total_order_amount AS DOUBLE)) / NULLIF(SUM(CAST(chargeable_weight_kg AS DOUBLE)), 0), 2)
      comment: "Revenue yield per chargeable kilogram - pricing efficiency and profitability indicator"
    - name: "surcharge_rate"
      expr: ROUND(100.0 * SUM(CAST(total_surcharge_amount AS DOUBLE)) / NULLIF(SUM(CAST(freight_charge_amount AS DOUBLE)), 0), 2)
      comment: "Surcharges as percentage of base freight - margin protection and cost recovery metric"
    - name: "avg_weight_per_order_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average shipment weight - operational planning and customer profile insight"
    - name: "co2e_intensity_per_kg"
      expr: ROUND(SUM(CAST(co2e_emissions_kg AS DOUBLE)) / NULLIF(SUM(CAST(gross_weight_kg AS DOUBLE)), 0), 4)
      comment: "Carbon intensity per kilogram shipped - sustainability efficiency benchmark"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of freight orders - volume and growth tracking baseline"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts - customer base and concentration analysis"
    - name: "dangerous_goods_order_count"
      expr: SUM(CASE WHEN is_dangerous_goods = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazmat shipments - compliance and risk management KPI"
    - name: "pod_received_count"
      expr: SUM(CASE WHEN pod_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders with proof of delivery - operational closure and billing readiness metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight booking performance metrics tracking booking conversion, capacity utilization, and service commitment across carriers and lanes"
  source: "`transport_shipping_ecm`.`freight`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (pending, confirmed, cancelled, rejected)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for the booking"
    - name: "service_type"
      expr: service_type
      comment: "Service type requested"
    - name: "channel"
      expr: channel
      comment: "Booking channel (web, API, EDI, phone, agent)"
    - name: "space_confirmed"
      expr: space_confirmed
      comment: "Whether carrier space has been confirmed"
    - name: "dangerous_goods"
      expr: dangerous_goods
      comment: "Whether booking includes dangerous goods"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether booking requires temperature control"
    - name: "nvocc_arrangement"
      expr: nvocc_arrangement
      comment: "Whether booking uses NVOCC arrangement"
    - name: "container_type"
      expr: container_type
      comment: "Type of container requested"
    - name: "booking_year"
      expr: YEAR(booking_date)
      comment: "Year the booking was created"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month the booking was created"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of bookings - demand volume and sales pipeline metric"
    - name: "confirmed_bookings"
      expr: SUM(CASE WHEN space_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings with confirmed carrier space - capacity commitment and fulfillment readiness"
    - name: "cancelled_bookings"
      expr: SUM(CASE WHEN booking_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled bookings - customer churn and service quality indicator"
    - name: "booking_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN space_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings with confirmed space - carrier relationship and capacity access KPI"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_freight_charge AS DOUBLE))
      comment: "Total estimated freight charges from bookings - forward revenue pipeline visibility"
    - name: "avg_estimated_charge"
      expr: AVG(CAST(estimated_freight_charge AS DOUBLE))
      comment: "Average estimated freight charge per booking - pricing and deal size insight"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight booked - capacity demand forecasting metric"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume booked in cubic meters - space utilization planning KPI"
    - name: "total_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEUs booked - ocean freight capacity planning benchmark"
    - name: "avg_weight_per_booking_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per booking - shipment profile and pricing strategy input"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers booking - customer engagement and market penetration"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used - carrier diversification and network breadth"
    - name: "hazmat_booking_count"
      expr: SUM(CASE WHEN dangerous_goods = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazardous goods bookings - compliance and specialized handling capacity"
    - name: "temp_controlled_booking_count"
      expr: SUM(CASE WHEN temperature_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-controlled bookings - cold chain capacity and service capability"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight leg performance metrics tracking transit efficiency, on-time performance, cost per leg, and intermodal transfer quality"
  source: "`transport_shipping_ecm`.`freight`.`freight_leg`"
  dimensions:
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the freight leg"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for this leg"
    - name: "service_type"
      expr: service_type
      comment: "Service type for this leg"
    - name: "is_intermodal_transfer"
      expr: is_intermodal_transfer
      comment: "Whether this leg involves intermodal transfer"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether this leg carries hazardous materials"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether this leg requires temperature control"
    - name: "container_type"
      expr: container_type
      comment: "Type of container used"
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (port, airport, warehouse, etc.)"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', scheduled_departure_timestamp)
      comment: "Month of scheduled departure"
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Total number of freight legs - network complexity and routing efficiency baseline"
    - name: "completed_legs"
      expr: SUM(CASE WHEN leg_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed legs - operational throughput and execution metric"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges across all legs - cost structure and carrier spend analysis"
    - name: "total_handling_charges"
      expr: SUM(CAST(handling_charges_amount AS DOUBLE))
      comment: "Total handling charges - terminal and transfer cost component"
    - name: "total_leg_charges"
      expr: SUM(CAST(total_leg_charges_amount AS DOUBLE))
      comment: "Total all-in charges per leg - comprehensive leg cost for profitability analysis"
    - name: "avg_freight_charge_per_leg"
      expr: AVG(CAST(freight_charges_amount AS DOUBLE))
      comment: "Average freight charge per leg - cost benchmarking and carrier rate comparison"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance traveled in kilometers - network reach and routing efficiency"
    - name: "avg_distance_per_leg_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance per leg - routing pattern and network design insight"
    - name: "total_transit_time_hours"
      expr: SUM(CAST(actual_transit_time_hours AS DOUBLE))
      comment: "Total actual transit time - service speed and efficiency aggregate"
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(actual_transit_time_hours AS DOUBLE))
      comment: "Average transit time per leg - service level and carrier performance benchmark"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all legs - service quality and reliability KPI"
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay per leg - on-time performance and carrier reliability metric"
    - name: "total_dwell_time_hours"
      expr: SUM(CAST(dwell_time_hours AS DOUBLE))
      comment: "Total dwell time at transfer points - terminal efficiency and congestion indicator"
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(dwell_time_hours AS DOUBLE))
      comment: "Average dwell time per leg - transfer efficiency and facility performance"
    - name: "total_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEUs moved - ocean freight volume and capacity utilization"
    - name: "cost_per_km"
      expr: ROUND(SUM(CAST(total_leg_charges_amount AS DOUBLE)) / NULLIF(SUM(CAST(distance_km AS DOUBLE)), 0), 2)
      comment: "Cost per kilometer traveled - routing efficiency and carrier cost benchmark"
    - name: "on_time_leg_count"
      expr: SUM(CASE WHEN CAST(delay_duration_hours AS DOUBLE) = 0 OR delay_duration_hours IS NULL THEN 1 ELSE 0 END)
      comment: "Count of on-time legs - service reliability and carrier performance"
    - name: "intermodal_transfer_count"
      expr: SUM(CASE WHEN is_intermodal_transfer = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intermodal transfers - network complexity and modal integration"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight exception and disruption metrics tracking incident frequency, resolution time, financial impact, and root cause patterns"
  source: "`transport_shipping_ecm`.`freight`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (delay, damage, loss, documentation, customs, etc.)"
    - name: "exception_category"
      expr: exception_category
      comment: "High-level category of exception"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of exception (open, investigating, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier (L1, L2, L3, executive)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for closed exceptions"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode where exception occurred"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether exception caused SLA breach"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether exception was preventable"
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Whether customer was notified of exception"
    - name: "claim_filed_flag"
      expr: claim_filed_flag
      comment: "Whether a cargo claim was filed"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month exception was detected"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of exceptions - service quality and operational risk baseline"
    - name: "open_exceptions"
      expr: SUM(CASE WHEN exception_status IN ('open', 'investigating') THEN 1 ELSE 0 END)
      comment: "Count of unresolved exceptions - operational backlog and response capacity"
    - name: "resolved_exceptions"
      expr: SUM(CASE WHEN exception_status IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of resolved exceptions - problem resolution throughput"
    - name: "critical_exceptions"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity exceptions - high-impact incident tracking"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions causing SLA breach - customer commitment failure rate"
    - name: "preventable_exception_count"
      expr: SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of preventable exceptions - process improvement opportunity metric"
    - name: "claim_filed_count"
      expr: SUM(CASE WHEN claim_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exceptions with claims filed - financial exposure and liability indicator"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of exceptions - direct cost of service failures"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception - incident cost severity"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours caused by exceptions - service disruption magnitude"
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay per exception - typical disruption impact"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions causing SLA breach - service reliability KPI"
    - name: "preventable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions that were preventable - process quality indicator"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_status IN ('resolved', 'closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions resolved - incident management effectiveness"
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions where customer was notified - communication compliance KPI"
    - name: "distinct_affected_orders"
      expr: COUNT(DISTINCT freight_order_id)
      comment: "Number of unique freight orders affected - exception impact breadth"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_consolidation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidation performance metrics tracking load efficiency, utilization rates, cost optimization, and deconsolidation cycle time"
  source: "`transport_shipping_ecm`.`freight`.`consolidation`"
  dimensions:
    - name: "consolidation_status"
      expr: consolidation_status
      comment: "Current status of consolidation (planning, loading, in-transit, arrived, deconsolidated)"
    - name: "consolidation_type"
      expr: consolidation_type
      comment: "Type of consolidation (LCL, groupage, ULD, etc.)"
    - name: "service_level"
      expr: service_level
      comment: "Service level for consolidated shipment"
    - name: "container_size_type"
      expr: container_size_type
      comment: "Container size and type (20ft, 40ft, 40HC, etc.)"
    - name: "contains_dangerous_goods"
      expr: contains_dangerous_goods
      comment: "Whether consolidation includes hazardous materials"
    - name: "contains_temperature_controlled"
      expr: contains_temperature_controlled
      comment: "Whether consolidation includes temperature-controlled cargo"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', scheduled_departure_datetime)
      comment: "Month of scheduled departure"
  measures:
    - name: "total_consolidations"
      expr: COUNT(1)
      comment: "Total number of consolidations - network efficiency and groupage volume"
    - name: "completed_consolidations"
      expr: SUM(CASE WHEN consolidation_status = 'deconsolidated' THEN 1 ELSE 0 END)
      comment: "Count of completed consolidations - throughput and cycle completion"
    - name: "total_freight_charges"
      expr: SUM(CAST(total_freight_charge_amount AS DOUBLE))
      comment: "Total freight charges for consolidations - cost aggregation and carrier spend"
    - name: "avg_freight_charge"
      expr: AVG(CAST(total_freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per consolidation - cost per load benchmark"
    - name: "total_shipments_consolidated"
      expr: SUM(CAST(total_shipment_count AS DOUBLE))
      comment: "Total number of shipments consolidated - groupage efficiency metric"
    - name: "avg_shipments_per_consolidation"
      expr: AVG(CAST(total_shipment_count AS DOUBLE))
      comment: "Average shipments per consolidation - load density and efficiency KPI"
    - name: "total_pieces"
      expr: SUM(CAST(total_piece_count AS DOUBLE))
      comment: "Total pieces consolidated - handling volume and complexity"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(total_chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight consolidated - revenue weight basis"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight consolidated - actual payload and capacity planning"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume consolidated - space utilization metric"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage - load efficiency and asset optimization KPI"
    - name: "high_utilization_count"
      expr: SUM(CASE WHEN CAST(utilization_percentage AS DOUBLE) >= 85.0 THEN 1 ELSE 0 END)
      comment: "Count of consolidations with 85%+ utilization - efficient load target achievement"
    - name: "cost_per_shipment"
      expr: ROUND(SUM(CAST(total_freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_shipment_count AS DOUBLE)), 0), 2)
      comment: "Average cost per shipment in consolidation - unit economics and pricing efficiency"
    - name: "cost_per_kg"
      expr: ROUND(SUM(CAST(total_freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_chargeable_weight_kg AS DOUBLE)), 0), 2)
      comment: "Cost per chargeable kilogram - weight-based efficiency benchmark"
    - name: "hazmat_consolidation_count"
      expr: SUM(CASE WHEN contains_dangerous_goods = TRUE THEN 1 ELSE 0 END)
      comment: "Count of consolidations with dangerous goods - specialized handling volume"
    - name: "temp_controlled_consolidation_count"
      expr: SUM(CASE WHEN contains_temperature_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-controlled consolidations - cold chain capacity utilization"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight charge and billing metrics tracking revenue composition, charge type mix, dispute rates, and billing accuracy"
  source: "`transport_shipping_ecm`.`freight`.`freight_charge`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (freight, fuel, accessorial, duty, tax, etc.)"
    - name: "charge_category"
      expr: charge_category
      comment: "High-level charge category"
    - name: "charge_status"
      expr: charge_status
      comment: "Status of charge (draft, approved, invoiced, paid, disputed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether charge is billable to customer"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether charge is under dispute"
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether charge is subject to tax"
    - name: "direction"
      expr: direction
      comment: "Charge direction (inbound, outbound, import, export)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode associated with charge"
    - name: "service_type"
      expr: service_type
      comment: "Service type for charge"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of charge"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month charge was created"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of charge line items - billing complexity and detail level"
    - name: "total_charge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total charge amount across all line items - comprehensive revenue and cost view"
    - name: "billable_charge_amount"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total billable charges - customer-facing revenue component"
    - name: "non_billable_charge_amount"
      expr: SUM(CASE WHEN is_billable = FALSE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total non-billable charges - internal cost absorption and margin impact"
    - name: "disputed_charge_amount"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total disputed charges - revenue at risk and billing quality indicator"
    - name: "approved_charge_amount"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total approved charges - revenue recognition readiness"
    - name: "avg_charge_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average charge per line item - typical charge magnitude"
    - name: "billable_charge_count"
      expr: SUM(CASE WHEN is_billable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billable charges - customer invoice line volume"
    - name: "disputed_charge_count"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed charges - billing dispute frequency"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges disputed - billing accuracy and customer satisfaction KPI"
    - name: "billable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges that are billable - revenue capture efficiency"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges approved - billing workflow efficiency"
    - name: "distinct_freight_orders"
      expr: COUNT(DISTINCT freight_order_id)
      comment: "Number of unique freight orders with charges - billing coverage breadth"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with charges - carrier billing complexity"
    - name: "distinct_charge_types"
      expr: COUNT(DISTINCT charge_type)
      comment: "Number of distinct charge types - billing complexity and service mix"
$$;