-- Metric views for domain: freight | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core freight order metrics tracking revenue, volume, weight, and operational performance across the freight forwarding business."
  source: "`transport_shipping_ecm`.`freight`.`freight_order`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport: ocean, air, road, rail, or multimodal."
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service (e.g., FCL, LCL, express, standard)."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier (e.g., premium, standard, economy)."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the freight order."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "ISO country code of shipment origin."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO country code of shipment destination."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing the shipment (e.g., FOB, CIF, DDP)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the freight charges."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the shipment contains dangerous goods."
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Month in which the freight order was booked."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the order."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging used for the shipment."
  measures:
    - name: "total_freight_revenue"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charge revenue across all orders — primary top-line revenue indicator."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total order value including all charges and surcharges — full commercial value of freight operations."
    - name: "total_surcharge_revenue"
      expr: SUM(CAST(total_surcharge_amount AS DOUBLE))
      comment: "Total surcharge revenue (fuel, peak season, etc.) — tracks ancillary revenue streams."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average order value per freight order — key pricing and yield metric."
    - name: "avg_freight_charge_per_order"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per order — monitors pricing trends and rate competitiveness."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms — measures throughput volume."
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight — the billable weight driving revenue calculations."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume shipped in cubic meters — capacity utilization indicator."
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU (Twenty-foot Equivalent Units) shipped — standard ocean freight volume measure."
    - name: "total_co2e_emissions_kg"
      expr: SUM(CAST(co2e_emissions_kg AS DOUBLE))
      comment: "Total CO2-equivalent emissions in kg — sustainability and ESG reporting metric."
    - name: "avg_rate_per_kg"
      expr: ROUND(SUM(CAST(freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(chargeable_weight_kg AS DOUBLE)), 0), 4)
      comment: "Average freight rate per chargeable kilogram — yield management KPI."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of freight orders — baseline volume metric."
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers placing freight orders — customer base breadth."
    - name: "dangerous_goods_order_count"
      expr: SUM(CASE WHEN is_dangerous_goods = true THEN 1 ELSE 0 END)
      comment: "Count of orders containing dangerous goods — compliance and risk monitoring."
    - name: "avg_co2e_per_teu"
      expr: ROUND(SUM(CAST(co2e_emissions_kg AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Average CO2e emissions per TEU — carbon intensity metric for sustainability reporting."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight booking metrics tracking conversion, demand patterns, and booking pipeline health."
  source: "`transport_shipping_ecm`.`freight`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, pending, cancelled)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the booking."
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service booked."
    - name: "channel"
      expr: channel
      comment: "Channel through which the booking was made (e.g., online, agent, API)."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (prepaid, collect)."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the booking."
    - name: "container_type"
      expr: container_type
      comment: "Type of container requested."
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Month of booking creation."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the booking requires temperature-controlled transport."
    - name: "dangerous_goods"
      expr: dangerous_goods
      comment: "Whether the booking involves dangerous goods."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of bookings — demand pipeline volume."
    - name: "confirmed_bookings"
      expr: SUM(CASE WHEN booking_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Number of confirmed bookings — conversion success indicator."
    - name: "cancelled_bookings"
      expr: SUM(CASE WHEN booking_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled bookings — churn and service quality signal."
    - name: "total_estimated_freight_charge"
      expr: SUM(CAST(estimated_freight_charge AS DOUBLE))
      comment: "Total estimated freight charges in pipeline — revenue forecast input."
    - name: "avg_estimated_freight_charge"
      expr: AVG(CAST(estimated_freight_charge AS DOUBLE))
      comment: "Average estimated freight charge per booking — pricing benchmark."
    - name: "total_booked_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in booking pipeline — capacity planning input."
    - name: "total_booked_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in booking pipeline — space utilization planning."
    - name: "total_booked_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEUs booked — ocean capacity demand indicator."
    - name: "space_confirmed_bookings"
      expr: SUM(CASE WHEN space_confirmed = true THEN 1 ELSE 0 END)
      comment: "Bookings with confirmed carrier space — supply-demand match rate."
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Distinct customers with active bookings — customer engagement breadth."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight leg operational metrics tracking transit performance, delays, costs, and multimodal efficiency."
  source: "`transport_shipping_ecm`.`freight`.`freight_leg`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this leg (ocean, air, road, rail)."
    - name: "leg_status"
      expr: leg_status
      comment: "Current status of the freight leg."
    - name: "service_type"
      expr: service_type
      comment: "Service type for this leg."
    - name: "is_intermodal_transfer"
      expr: is_intermodal_transfer
      comment: "Whether this leg involves an intermodal transfer point."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether this leg requires temperature control."
    - name: "container_type"
      expr: container_type
      comment: "Container type used on this leg."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Reason code for any delay on this leg."
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (port, airport, depot)."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location."
  measures:
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges across all legs — cost of carriage."
    - name: "total_handling_charges"
      expr: SUM(CAST(handling_charges_amount AS DOUBLE))
      comment: "Total handling charges — terminal and port handling costs."
    - name: "total_leg_charges"
      expr: SUM(CAST(total_leg_charges_amount AS DOUBLE))
      comment: "Total all-in charges per leg including freight, handling, and surcharges."
    - name: "total_baf_amount"
      expr: SUM(CAST(baf_amount AS DOUBLE))
      comment: "Total Bunker Adjustment Factor charges — fuel cost exposure."
    - name: "total_thc_amount"
      expr: SUM(CAST(thc_amount AS DOUBLE))
      comment: "Total Terminal Handling Charges — port cost component."
    - name: "avg_transit_time_hours"
      expr: AVG(CAST(transit_time_hours AS DOUBLE))
      comment: "Average planned transit time in hours — service speed benchmark."
    - name: "avg_actual_transit_time_hours"
      expr: AVG(CAST(actual_transit_time_hours AS DOUBLE))
      comment: "Average actual transit time in hours — realized service performance."
    - name: "avg_delay_duration_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration in hours — on-time performance degradation."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours across all legs — aggregate service disruption."
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(dwell_time_hours AS DOUBLE))
      comment: "Average dwell time at transfer points — efficiency of handoffs."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered across all legs in kilometers."
    - name: "total_teu_moved"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEUs transported across all legs."
    - name: "leg_count"
      expr: COUNT(1)
      comment: "Total number of freight legs — operational complexity indicator."
    - name: "delayed_leg_count"
      expr: SUM(CASE WHEN delay_duration_hours > 0 THEN 1 ELSE 0 END)
      comment: "Number of legs experiencing delays — on-time reliability metric."
    - name: "avg_cost_per_teu"
      expr: ROUND(SUM(CAST(total_leg_charges_amount AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Average all-in cost per TEU — unit economics for ocean freight."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight charge analytics tracking revenue composition, charge types, billing status, and profitability signals."
  source: "`transport_shipping_ecm`.`freight`.`freight_charge`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (freight, surcharge, accessorial, etc.)."
    - name: "charge_category"
      expr: charge_category
      comment: "Category grouping of the charge."
    - name: "charge_status"
      expr: charge_status
      comment: "Billing status of the charge (invoiced, accrued, disputed)."
    - name: "direction"
      expr: direction
      comment: "Direction of charge: buy (cost) or sell (revenue)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode associated with the charge."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the charge."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge amount."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the charge is billable to the customer."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the charge is under dispute."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the charge."
    - name: "charge_effective_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month when the charge becomes effective."
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total charge amount — aggregate financial value of all freight charges."
    - name: "avg_charge_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average charge amount per line — pricing granularity indicator."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity units billed across all charges."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across charges — rate trend monitoring."
    - name: "charge_line_count"
      expr: COUNT(1)
      comment: "Total number of charge lines — billing complexity indicator."
    - name: "disputed_charge_amount"
      expr: SUM(CASE WHEN is_disputed = true THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount under dispute — financial risk and billing quality signal."
    - name: "disputed_charge_count"
      expr: SUM(CASE WHEN is_disputed = true THEN 1 ELSE 0 END)
      comment: "Number of disputed charge lines — billing accuracy indicator."
    - name: "billable_charge_amount"
      expr: SUM(CASE WHEN is_billable = true THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total billable amount — revenue recognition basis."
    - name: "revenue_per_unit"
      expr: ROUND(SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 4)
      comment: "Revenue per unit quantity — yield and pricing efficiency."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_consolidation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidation metrics tracking container utilization, groupage efficiency, and LCL/groupage profitability."
  source: "`transport_shipping_ecm`.`freight`.`consolidation`"
  dimensions:
    - name: "consolidation_type"
      expr: consolidation_type
      comment: "Type of consolidation (LCL, air groupage, buyer consolidation)."
    - name: "consolidation_status"
      expr: consolidation_status
      comment: "Current status of the consolidation."
    - name: "container_size_type"
      expr: container_size_type
      comment: "Container size and type (20GP, 40HC, etc.)."
    - name: "service_level"
      expr: service_level
      comment: "Service level of the consolidation."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms governing the consolidation."
    - name: "contains_dangerous_goods"
      expr: contains_dangerous_goods
      comment: "Whether the consolidation contains DG cargo."
    - name: "contains_temperature_controlled"
      expr: contains_temperature_controlled
      comment: "Whether the consolidation includes reefer cargo."
  measures:
    - name: "total_consolidations"
      expr: COUNT(1)
      comment: "Total number of consolidations — groupage activity volume."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average container/ULD utilization percentage — key efficiency KPI for groupage operations."
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(total_freight_charge_amount AS DOUBLE))
      comment: "Total freight charges for consolidations — groupage revenue."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight consolidated — throughput measure."
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(total_chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight — billable volume."
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume consolidated in cubic meters."
    - name: "avg_freight_charge_per_consolidation"
      expr: AVG(CAST(total_freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per consolidation — unit economics."
    - name: "avg_revenue_per_cbm"
      expr: ROUND(SUM(CAST(total_freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_volume_cbm AS DOUBLE)), 0), 2)
      comment: "Average revenue per cubic meter — yield metric for groupage."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight exception metrics tracking service disruptions, SLA breaches, financial impact, and resolution performance."
  source: "`transport_shipping_ecm`.`freight`.`freight_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (delay, damage, documentation, customs hold)."
    - name: "exception_category"
      expr: exception_category
      comment: "Category grouping of the exception."
    - name: "exception_status"
      expr: exception_status
      comment: "Current resolution status of the exception."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the exception."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode where the exception occurred."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the exception resulted in an SLA breach."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the exception was preventable."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the exception."
    - name: "detection_source"
      expr: detection_source
      comment: "How the exception was detected (system, carrier, customer)."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of freight exceptions — service quality baseline."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of exceptions — cost of poor quality."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception — severity indicator."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Number of SLA breaches — contractual compliance metric."
    - name: "avg_delay_duration_hours"
      expr: AVG(CAST(delay_duration_hours AS DOUBLE))
      comment: "Average delay duration for exceptions — service recovery speed."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_duration_hours AS DOUBLE))
      comment: "Total delay hours from exceptions — aggregate disruption impact."
    - name: "preventable_exception_count"
      expr: SUM(CASE WHEN preventable_flag = true THEN 1 ELSE 0 END)
      comment: "Number of preventable exceptions — operational improvement opportunity."
    - name: "claim_filed_count"
      expr: SUM(CASE WHEN claim_filed_flag = true THEN 1 ELSE 0 END)
      comment: "Number of exceptions resulting in claims — financial liability exposure."
    - name: "unique_affected_orders"
      expr: COUNT(DISTINCT freight_order_id)
      comment: "Distinct freight orders affected by exceptions — impact breadth."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight quote metrics tracking pricing competitiveness, win rates, and sales pipeline value."
  source: "`transport_shipping_ecm`.`freight`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (draft, sent, accepted, expired, rejected)."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (spot, contract, RFQ response)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode quoted."
    - name: "service_type"
      expr: service_type
      comment: "Service type quoted."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country of the quoted shipment."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the quoted shipment."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the quote involves dangerous goods."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the quote requires temperature control."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the quote was issued."
  measures:
    - name: "total_quoted_amount"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total value of all quotes issued — sales pipeline value."
    - name: "avg_quoted_amount"
      expr: AVG(CAST(total_quoted_amount AS DOUBLE))
      comment: "Average quote value — deal size indicator."
    - name: "total_base_freight_charge"
      expr: SUM(CAST(base_freight_charge_amount AS DOUBLE))
      comment: "Total base freight charges quoted — core pricing benchmark."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharges quoted — fuel cost pass-through."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges quoted — ancillary revenue potential."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued — sales activity volume."
    - name: "unique_customers_quoted"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Distinct customers receiving quotes — market reach."
    - name: "avg_rate_per_kg"
      expr: ROUND(SUM(CAST(total_quoted_amount AS DOUBLE)) / NULLIF(SUM(CAST(chargeable_weight_kg AS DOUBLE)), 0), 4)
      comment: "Average quoted rate per chargeable kg — pricing competitiveness."
    - name: "total_quoted_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight quoted — demand volume in pipeline."
    - name: "total_quoted_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEUs quoted — ocean freight pipeline volume."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_air_waybill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Air waybill metrics tracking air freight revenue, volume, and operational performance."
  source: "`transport_shipping_ecm`.`freight`.`air_waybill`"
  dimensions:
    - name: "awb_status"
      expr: awb_status
      comment: "Current status of the air waybill."
    - name: "awb_type"
      expr: awb_type
      comment: "Type of AWB (master or house)."
    - name: "service_type"
      expr: service_type
      comment: "Air freight service type."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "IATA code of origin airport."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA code of destination airport."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the airline carrier."
    - name: "iata_airline_code"
      expr: iata_airline_code
      comment: "IATA code of the airline."
    - name: "rate_class"
      expr: rate_class
      comment: "Rate class applied to the shipment."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the AWB contains dangerous goods."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the AWB was issued."
  measures:
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total air freight charges — air cargo revenue."
    - name: "total_charges"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total all-in charges including freight and other charges."
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight — billable air cargo volume."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of air shipments."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of air cargo in cubic meters."
    - name: "avg_rate_per_kg"
      expr: AVG(CAST(rate_per_kg AS DOUBLE))
      comment: "Average rate per kilogram — air freight yield."
    - name: "avg_yield_per_kg"
      expr: ROUND(SUM(CAST(total_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(chargeable_weight_kg AS DOUBLE)), 0), 4)
      comment: "Realized yield per chargeable kg — actual pricing performance."
    - name: "awb_count"
      expr: COUNT(1)
      comment: "Total number of air waybills — shipment count."
    - name: "total_declared_value_customs"
      expr: SUM(CAST(declared_value_for_customs AS DOUBLE))
      comment: "Total declared customs value — trade value indicator."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of lading metrics tracking ocean freight revenue, TEU volume, and trade lane performance."
  source: "`transport_shipping_ecm`.`freight`.`bill_of_lading`"
  dimensions:
    - name: "bol_status"
      expr: bol_status
      comment: "Current status of the bill of lading."
    - name: "bol_type"
      expr: bol_type
      comment: "Type of B/L (master, house, express)."
    - name: "service_type"
      expr: service_type
      comment: "Ocean freight service type."
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port where cargo is loaded."
    - name: "port_of_discharge"
      expr: port_of_discharge
      comment: "Port where cargo is discharged."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of destination."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (prepaid/collect)."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms for the shipment."
    - name: "vessel_name"
      expr: vessel_name
      comment: "Name of the vessel."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the B/L was issued."
  measures:
    - name: "total_freight_amount"
      expr: SUM(CAST(total_freight_amount AS DOUBLE))
      comment: "Total ocean freight amount — sea cargo revenue."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(freight_surcharge_amount AS DOUBLE))
      comment: "Total freight surcharges — ancillary ocean revenue."
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEUs shipped — standard ocean volume measure."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of ocean shipments."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume of ocean cargo in cubic meters."
    - name: "bol_count"
      expr: COUNT(1)
      comment: "Total number of bills of lading — ocean shipment count."
    - name: "avg_freight_per_teu"
      expr: ROUND(SUM(CAST(total_freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Average freight revenue per TEU — ocean yield metric."
    - name: "hazardous_shipment_count"
      expr: SUM(CASE WHEN is_hazardous = true THEN 1 ELSE 0 END)
      comment: "Number of hazardous cargo shipments — compliance monitoring."
    - name: "unique_vessels"
      expr: COUNT(DISTINCT vessel_name)
      comment: "Distinct vessels used — carrier diversification."
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`freight_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load plan metrics tracking capacity utilization, loading efficiency, and operational planning performance."
  source: "`transport_shipping_ecm`.`freight`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Current status of the load plan."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the load plan."
    - name: "transport_unit_type"
      expr: transport_unit_type
      comment: "Type of transport unit (container, ULD, trailer)."
    - name: "load_optimization_method"
      expr: load_optimization_method
      comment: "Method used for load optimization."
    - name: "contains_hazmat"
      expr: contains_hazmat
      comment: "Whether the load contains hazardous materials."
    - name: "contains_temperature_controlled"
      expr: contains_temperature_controlled
      comment: "Whether the load includes temperature-controlled cargo."
    - name: "planned_load_month"
      expr: DATE_TRUNC('month', planned_load_date)
      comment: "Month of planned loading."
  measures:
    - name: "total_load_plans"
      expr: COUNT(1)
      comment: "Total number of load plans created."
    - name: "avg_weight_utilization_pct"
      expr: AVG(CAST(weight_utilization_percentage AS DOUBLE))
      comment: "Average weight utilization percentage — capacity efficiency by weight."
    - name: "avg_volume_utilization_pct"
      expr: AVG(CAST(volume_utilization_percentage AS DOUBLE))
      comment: "Average volume utilization percentage — capacity efficiency by volume."
    - name: "total_planned_weight_kg"
      expr: SUM(CAST(total_planned_weight_kg AS DOUBLE))
      comment: "Total planned weight across all load plans."
    - name: "total_planned_volume_cbm"
      expr: SUM(CAST(total_planned_volume_cbm AS DOUBLE))
      comment: "Total planned volume across all load plans."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(total_actual_weight_kg AS DOUBLE))
      comment: "Total actual weight loaded — realized throughput."
    - name: "total_actual_volume_cbm"
      expr: SUM(CAST(total_actual_volume_cbm AS DOUBLE))
      comment: "Total actual volume loaded."
    - name: "total_max_weight_capacity_kg"
      expr: SUM(CAST(max_weight_capacity_kg AS DOUBLE))
      comment: "Total maximum weight capacity available — supply side."
    - name: "total_max_volume_capacity_cbm"
      expr: SUM(CAST(max_volume_capacity_cbm AS DOUBLE))
      comment: "Total maximum volume capacity available."
$$;