-- Metric views for domain: cargo | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_awb`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Air Waybill (AWB) financial and operational metrics. Tracks freight revenue, chargeable weight, declared values, and shipment mix across commodity types, routes, and payment indicators. Core revenue and yield analytics for cargo commercial teams."
  source: "`airlines_ecm`.`cargo`.`awb`"
  dimensions:
    - name: "awb_status"
      expr: awb_status
      comment: "Current lifecycle status of the AWB (e.g., executed, cancelled, pending). Used to filter active vs. closed shipments."
    - name: "awb_type"
      expr: awb_type
      comment: "Type of AWB (e.g., master, house, direct). Drives revenue attribution and interline settlement analysis."
    - name: "commodity_code"
      expr: commodity_code
      comment: "IATA commodity code for the shipment. Enables yield and revenue analysis by cargo category."
    - name: "payment_indicator"
      expr: payment_indicator
      comment: "Indicates whether charges are prepaid or collect. Critical for cash-flow and billing cycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which AWB charges are denominated. Required for multi-currency revenue reporting."
    - name: "dangerous_goods_indicator"
      expr: dangerous_goods_indicator
      comment: "Flags AWBs containing dangerous goods. Used for regulatory compliance and premium surcharge analysis."
    - name: "executed_date"
      expr: DATE_TRUNC('month', executed_date)
      comment: "Month of AWB execution. Primary time dimension for monthly revenue trend analysis."
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_timestamp)
      comment: "Month the booking was made. Enables lead-time and booking-to-execution lag analysis."
  measures:
    - name: "total_awb_count"
      expr: COUNT(1)
      comment: "Total number of AWBs. Baseline volume metric for shipment throughput and market activity."
    - name: "total_freight_charge_amount"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges billed across all AWBs. Primary cargo revenue KPI used in P&L and commercial performance reviews."
    - name: "total_charges_amount"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total all-in charges per AWB including freight, valuation, and ancillary fees. Represents gross cargo revenue."
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kilograms across all AWBs. Core capacity utilisation and yield denominator."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total actual gross weight shipped. Used alongside chargeable weight to assess volumetric vs. actual weight mix."
    - name: "avg_freight_charge_per_awb"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per AWB. Tracks average transaction value and commercial rate effectiveness."
    - name: "revenue_yield_per_kg"
      expr: ROUND(SUM(CAST(freight_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(chargeable_weight_kg AS DOUBLE)), 0), 4)
      comment: "Freight revenue per kilogram of chargeable weight (yield). The primary cargo pricing efficiency KPI used by revenue management and commercial leadership."
    - name: "total_valuation_charge_amount"
      expr: SUM(CAST(valuation_charge_amount AS DOUBLE))
      comment: "Total valuation surcharge revenue. Indicates declared-value shipment mix and associated ancillary revenue stream."
    - name: "total_declared_value_for_customs"
      expr: SUM(CAST(declared_value_for_customs AS DOUBLE))
      comment: "Aggregate declared customs value across AWBs. Used for customs compliance reporting and liability exposure assessment."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used with weight to compute volumetric density and optimise hold utilisation."
    - name: "dangerous_goods_awb_count"
      expr: COUNT(CASE WHEN dangerous_goods_indicator = TRUE THEN 1 END)
      comment: "Number of AWBs flagged as containing dangerous goods. Tracks DG shipment volume for regulatory compliance and risk management."
    - name: "dangerous_goods_revenue_share"
      expr: ROUND(100.0 * SUM(CASE WHEN dangerous_goods_indicator = TRUE THEN CAST(freight_charge_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(freight_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total freight revenue attributable to dangerous goods shipments. Informs risk-adjusted revenue strategy and DG capacity allocation."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo booking pipeline metrics covering demand intake, conversion, cancellation, and rate realisation. Enables commercial teams to monitor booking velocity, channel mix, and revenue-at-risk from cancellations."
  source: "`airlines_ecm`.`cargo`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, cancelled, waitlisted). Primary filter for pipeline health analysis."
    - name: "channel"
      expr: channel
      comment: "Booking channel (e.g., direct, GDS, forwarder portal). Drives channel mix and cost-of-sale analysis."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for the booked shipment. Enables demand analysis by cargo type."
    - name: "dangerous_goods_indicator"
      expr: dangerous_goods_indicator
      comment: "Flags bookings containing dangerous goods. Used for capacity planning and compliance monitoring."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Indicates whether temperature-controlled handling is required. Tracks premium cold-chain demand."
    - name: "insurance_requested"
      expr: insurance_requested
      comment: "Flags bookings where cargo insurance was requested. Tracks ancillary revenue attachment rate."
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_timestamp)
      comment: "Month the booking was created. Primary time dimension for demand trend analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for booking cancellation. Identifies root causes of demand leakage."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of cargo bookings. Baseline demand volume metric."
    - name: "confirmed_bookings"
      expr: COUNT(CASE WHEN booking_status = 'confirmed' THEN 1 END)
      comment: "Number of confirmed bookings. Tracks active pipeline and capacity commitment."
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled bookings. Monitors demand leakage and revenue-at-risk."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. A key commercial health indicator — high rates signal pricing, capacity, or service issues."
    - name: "total_requested_weight_kg"
      expr: SUM(CAST(requested_weight_kg AS DOUBLE))
      comment: "Total weight requested across all bookings in kilograms. Represents gross demand signal for capacity planning."
    - name: "total_requested_volume_cbm"
      expr: SUM(CAST(requested_volume_cbm AS DOUBLE))
      comment: "Total volume requested across all bookings in cubic meters. Used alongside weight for hold utilisation planning."
    - name: "avg_quoted_rate_amount"
      expr: AVG(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Average quoted rate per booking. Tracks rate level trends and commercial pricing effectiveness."
    - name: "total_quoted_revenue"
      expr: SUM(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Total quoted revenue across all bookings. Represents the gross revenue pipeline before confirmation and execution."
    - name: "avg_requested_weight_per_booking_kg"
      expr: AVG(CAST(requested_weight_kg AS DOUBLE))
      comment: "Average shipment weight per booking. Tracks shipment size trends and customer mix shifts."
    - name: "temperature_control_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_control_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings requiring temperature control. Tracks cold-chain demand growth, a high-yield premium segment."
    - name: "insurance_attachment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN insurance_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings with insurance requested. Measures ancillary revenue attachment and customer risk awareness."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo capacity utilisation metrics at the flight-leg level. Tracks weight and volume load factors, overbooking exposure, and allotment consumption by commodity type. Core KPIs for network capacity management and revenue optimisation."
  source: "`airlines_ecm`.`cargo`.`capacity`"
  dimensions:
    - name: "capacity_status"
      expr: capacity_status
      comment: "Status of the capacity record (e.g., open, closed, embargoed). Used to filter actionable capacity."
    - name: "aircraft_configuration"
      expr: aircraft_configuration
      comment: "Aircraft configuration type (e.g., combi, freighter, belly). Drives capacity benchmark segmentation."
    - name: "control_method"
      expr: control_method
      comment: "Method used to control cargo capacity (e.g., allotment, free-sale). Informs revenue management strategy."
    - name: "embargo_flag"
      expr: embargo_flag
      comment: "Indicates whether an embargo is active on this capacity. Used to identify constrained routes."
    - name: "bulk_cargo_allowed_flag"
      expr: bulk_cargo_allowed_flag
      comment: "Indicates whether bulk (non-ULD) cargo is permitted. Affects product mix and handling cost analysis."
    - name: "flight_date_month"
      expr: DATE_TRUNC('month', flight_date)
      comment: "Month of the flight. Primary time dimension for capacity trend and seasonal analysis."
    - name: "weight_unit_of_measure"
      expr: weight_unit_of_measure
      comment: "Unit of measure for weight fields. Ensures correct aggregation in multi-unit environments."
  measures:
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(total_weight_capacity_kg AS DOUBLE))
      comment: "Total available cargo weight capacity in kilograms across all flight legs. Baseline supply metric for network capacity planning."
    - name: "total_booked_weight_kg"
      expr: SUM(CAST(booked_weight_kg AS DOUBLE))
      comment: "Total weight booked against available capacity. Measures demand absorption and revenue commitment."
    - name: "total_available_weight_kg"
      expr: SUM(CAST(available_weight_kg AS DOUBLE))
      comment: "Total remaining available weight capacity. Tracks unsold capacity and revenue opportunity."
    - name: "weight_load_factor_pct"
      expr: ROUND(100.0 * SUM(CAST(booked_weight_kg AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_capacity_kg AS DOUBLE)), 0), 2)
      comment: "Weight load factor: booked weight as a percentage of total weight capacity. The primary cargo capacity utilisation KPI used by network and revenue management."
    - name: "volume_load_factor_pct"
      expr: ROUND(100.0 * SUM(CAST(booked_volume_cbm AS DOUBLE)) / NULLIF(SUM(CAST(total_volume_capacity_cbm AS DOUBLE)), 0), 2)
      comment: "Volume load factor: booked volume as a percentage of total volume capacity. Complements weight load factor for volumetric cargo mix analysis."
    - name: "belly_weight_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(booked_weight_kg AS DOUBLE)) / NULLIF(SUM(CAST(belly_cargo_weight_capacity_kg AS DOUBLE)), 0), 2)
      comment: "Belly hold weight utilisation rate. Tracks efficiency of passenger aircraft belly cargo revenue contribution."
    - name: "avg_overbooking_factor_pct"
      expr: AVG(CAST(overbooking_factor_percent AS DOUBLE))
      comment: "Average overbooking factor applied across capacity records. Monitors revenue management aggressiveness and offload risk exposure."
    - name: "total_allotment_perishable_kg"
      expr: SUM(CAST(allotment_perishable_kg AS DOUBLE))
      comment: "Total weight allotted for perishable cargo. Tracks premium cold-chain capacity allocation, a high-yield segment."
    - name: "total_allotment_dangerous_goods_kg"
      expr: SUM(CAST(allotment_dangerous_goods_kg AS DOUBLE))
      comment: "Total weight allotted for dangerous goods. Monitors DG capacity commitment for regulatory compliance and premium revenue."
    - name: "embargoed_capacity_count"
      expr: COUNT(CASE WHEN embargo_flag = TRUE THEN 1 END)
      comment: "Number of capacity records under active embargo. Tracks network restrictions impacting revenue availability."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo claims financial and operational metrics. Tracks claim volumes, settlement costs, recovery rates, and liability exposure. Critical for risk management, ground handler performance, and insurance strategy."
  source: "`airlines_ecm`.`cargo`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g., open, settled, rejected). Primary filter for active liability exposure."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., damage, loss, delay). Identifies root cause categories for operational improvement."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (e.g., shipper, consignee, forwarder). Informs customer relationship and liability management."
    - name: "liability_determination"
      expr: liability_determination
      comment: "Outcome of liability assessment (e.g., carrier liable, third-party liable). Drives cost allocation and recovery actions."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the claim (e.g., cash, credit note). Tracks settlement efficiency and cash impact."
    - name: "insurance_recovery_flag"
      expr: insurance_recovery_flag
      comment: "Indicates whether insurance recovery was pursued. Tracks net cost after recovery."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month the claim was filed. Primary time dimension for claims trend and seasonality analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current investigation status. Tracks operational response speed and backlog."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of cargo claims filed. Baseline quality and service failure metric."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed by claimants. Represents gross liability exposure before investigation and settlement."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount paid in claim settlements. Represents actual cash cost of cargo service failures."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim. Tracks severity trends and informs reserve adequacy."
    - name: "settlement_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Settlement amount as a percentage of claimed amount. Measures negotiation effectiveness and liability containment — a key risk management KPI."
    - name: "open_claims_count"
      expr: COUNT(CASE WHEN claim_status = 'open' THEN 1 END)
      comment: "Number of currently open claims. Tracks outstanding liability exposure and operational backlog."
    - name: "open_claims_liability_amount"
      expr: SUM(CASE WHEN claim_status = 'open' THEN CAST(claimed_amount AS DOUBLE) ELSE 0 END)
      comment: "Total claimed amount for open (unresolved) claims. Represents current unresolved financial liability on the balance sheet."
    - name: "insurance_recovery_claim_count"
      expr: COUNT(CASE WHEN insurance_recovery_flag = TRUE THEN 1 END)
      comment: "Number of claims where insurance recovery was pursued. Tracks cost recovery effectiveness."
    - name: "avg_days_to_settlement"
      expr: AVG(CAST(DATEDIFF(settlement_date, filing_date) AS DOUBLE))
      comment: "Average number of days from claim filing to settlement. Measures claims resolution efficiency and customer service quality."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo invoice revenue and billing metrics. Tracks billed revenue by charge type, invoice status, payment terms, and billing party. Core financial KPIs for accounts receivable, revenue recognition, and billing performance."
  source: "`airlines_ecm`.`cargo`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., issued, paid, overdue). Primary filter for AR aging and collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., freight, handling, customs). Enables revenue stream decomposition."
    - name: "billing_party_type"
      expr: billing_party_type
      comment: "Type of billing party (e.g., shipper, forwarder, corporate account). Drives customer segment revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency. Required for multi-currency revenue reporting and FX exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., CASS, bank transfer, credit card). Tracks settlement channel mix and collection risk."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice (e.g., net 30). Informs cash flow forecasting and credit risk management."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued. Primary time dimension for revenue recognition and billing cycle analysis."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing party. Enables geographic revenue analysis and tax jurisdiction reporting."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount including all charges and taxes. Primary cargo billing revenue KPI for financial reporting."
    - name: "total_freight_charge_prepaid"
      expr: SUM(CAST(freight_charge_prepaid AS DOUBLE))
      comment: "Total prepaid freight charges billed. Tracks origin-billed revenue, a key cash flow indicator."
    - name: "total_freight_charge_collect"
      expr: SUM(CAST(freight_charge_collect AS DOUBLE))
      comment: "Total collect freight charges billed. Tracks destination-billed revenue and associated collection risk."
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharge revenue billed. Tracks surcharge recovery effectiveness against fuel cost exposure."
    - name: "total_handling_fee"
      expr: SUM(CAST(handling_fee AS DOUBLE))
      comment: "Total handling fee revenue. Tracks ground handling ancillary revenue stream."
    - name: "total_dg_surcharge"
      expr: SUM(CAST(dg_surcharge AS DOUBLE))
      comment: "Total dangerous goods surcharge revenue. Monitors DG premium revenue contribution."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed. Required for tax compliance reporting and net revenue calculation."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax invoice subtotal. Represents net revenue before tax for P&L reporting."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value. Tracks transaction size trends and customer spend patterns."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'overdue' THEN 1 END)
      comment: "Number of overdue invoices. Tracks AR collection risk and customer payment behaviour."
    - name: "fuel_surcharge_revenue_share_pct"
      expr: ROUND(100.0 * SUM(CAST(fuel_surcharge AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Fuel surcharge as a percentage of total invoiced revenue. Monitors surcharge recovery rate relative to total billing — a key cost recovery KPI."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo shipment operational performance metrics. Tracks on-time delivery, exception rates, customs clearance, weight throughput, and temperature compliance. Core KPIs for operations, customer service, and quality management."
  source: "`airlines_ecm`.`cargo`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, exception). Primary operational health dimension."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for the shipment. Enables performance analysis by cargo type."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether the shipment contains dangerous goods. Used for compliance and risk segmentation."
    - name: "customs_cleared_flag"
      expr: customs_cleared_flag
      comment: "Indicates whether customs clearance has been completed. Tracks regulatory compliance and delivery readiness."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flags shipments with operational exceptions (e.g., offload, damage, delay). Primary quality and service failure indicator."
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening outcome for the shipment. Tracks regulatory compliance and screening throughput."
    - name: "origin_station_code"
      expr: origin_station_code
      comment: "Origin station code. Enables route-level and station-level performance analysis."
    - name: "destination_station_code"
      expr: destination_station_code
      comment: "Destination station code. Used with origin for O&D performance analysis."
    - name: "acceptance_month"
      expr: DATE_TRUNC('month', acceptance_timestamp)
      comment: "Month of shipment acceptance. Primary time dimension for throughput and performance trend analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments processed. Baseline operational throughput metric."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight of all shipments in kilograms. Measures physical cargo throughput for capacity and cost analysis."
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight across shipments. Revenue-relevant weight basis for yield calculations."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with operational exceptions. The primary cargo service quality KPI — directly impacts customer satisfaction and claims."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= estimated_arrival_timestamp AND actual_arrival_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on or before estimated arrival. Core service reliability KPI used in customer SLA reporting and operational reviews."
    - name: "customs_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_cleared_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments that have cleared customs. Tracks regulatory compliance throughput and identifies clearance bottlenecks."
    - name: "dangerous_goods_shipment_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END)
      comment: "Number of shipments containing dangerous goods. Tracks DG volume for regulatory compliance and risk management."
    - name: "avg_actual_weight_per_shipment_kg"
      expr: AVG(CAST(actual_weight_kg AS DOUBLE))
      comment: "Average actual weight per shipment. Tracks shipment size trends and customer mix changes."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Used with weight for density analysis and hold optimisation."
    - name: "avg_insurance_declared_value"
      expr: AVG(CAST(insurance_declared_value AS DOUBLE))
      comment: "Average declared insurance value per shipment. Tracks high-value cargo exposure and insurance product uptake."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_customs_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs entry compliance and cost metrics. Tracks duty and tax liabilities, clearance cycle times, examination rates, and entry status. Critical for trade compliance, regulatory reporting, and cost management."
  source: "`airlines_ecm`.`cargo`.`customs_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Current status of the customs entry (e.g., filed, released, held). Primary compliance and throughput dimension."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of customs entry (e.g., formal, informal, in-bond). Drives regulatory reporting segmentation."
    - name: "examination_type"
      expr: examination_type
      comment: "Type of customs examination applied (e.g., documentary, physical). Tracks inspection intensity and associated delays."
    - name: "examination_result"
      expr: examination_result
      comment: "Result of customs examination (e.g., cleared, seized, re-examined). Monitors compliance outcomes."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the goods. Enables trade lane and tariff analysis."
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Country of destination. Used with origin for bilateral trade flow analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay customs duties (e.g., cash, bond, deferred). Tracks payment channel mix."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_timestamp)
      comment: "Month the customs entry was filed. Primary time dimension for compliance volume and cost trend analysis."
  measures:
    - name: "total_customs_entries"
      expr: COUNT(1)
      comment: "Total number of customs entries filed. Baseline compliance volume metric."
    - name: "total_customs_duty_amount"
      expr: SUM(CAST(customs_duty_amount AS DOUBLE))
      comment: "Total customs duty assessed across all entries. Represents direct trade cost and regulatory liability."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount assessed on customs entries. Tracks tax liability for financial reporting and compliance."
    - name: "total_charges_amount"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total all-in customs charges including duties, taxes, and fees. Represents full customs cost burden."
    - name: "avg_customs_duty_per_entry"
      expr: AVG(CAST(customs_duty_amount AS DOUBLE))
      comment: "Average customs duty per entry. Tracks duty intensity trends by trade lane and commodity."
    - name: "held_entry_count"
      expr: COUNT(CASE WHEN entry_status = 'held' THEN 1 END)
      comment: "Number of entries currently on hold. Tracks compliance risk and potential shipment delay exposure."
    - name: "examination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN examination_type IS NOT NULL AND examination_type != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entries subject to customs examination. High rates indicate elevated compliance risk or targeting by authorities."
    - name: "avg_clearance_cycle_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(release_timestamp) - UNIX_TIMESTAMP(filing_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average hours from customs filing to release. Measures customs clearance efficiency — directly impacts shipment delivery performance."
    - name: "total_declared_value_amount"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared customs value across all entries. Used for duty base analysis and trade value reporting."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load plan weight and balance metrics for cargo operations. Tracks actual vs. maximum weight utilisation, load factors, centre-of-gravity compliance, and special load handling. Core KPIs for flight operations safety and cargo revenue optimisation."
  source: "`airlines_ecm`.`cargo`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Current status of the load plan (e.g., planned, finalised, amended). Tracks operational readiness."
    - name: "departure_station"
      expr: departure_station
      comment: "Departure station for the flight. Enables station-level load planning performance analysis."
    - name: "arrival_station"
      expr: arrival_station
      comment: "Arrival station for the flight. Used with departure for route-level analysis."
    - name: "dangerous_goods_onboard_flag"
      expr: dangerous_goods_onboard_flag
      comment: "Indicates whether dangerous goods are loaded on this flight. Tracks DG operational exposure."
    - name: "special_load_flag"
      expr: special_load_flag
      comment: "Flags flights with special load requirements. Tracks operational complexity and handling cost drivers."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the load plan meets all regulatory requirements. Primary safety compliance KPI."
    - name: "dispatch_release_flag"
      expr: dispatch_release_flag
      comment: "Indicates whether dispatch release has been granted. Tracks operational readiness and departure punctuality."
    - name: "flight_date_month"
      expr: DATE_TRUNC('month', flight_date)
      comment: "Month of the flight. Primary time dimension for load planning trend analysis."
  measures:
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight loaded across all flights. Measures actual cargo throughput and revenue-generating payload."
    - name: "avg_load_factor_pct"
      expr: AVG(CAST(load_factor_percent AS DOUBLE))
      comment: "Average cargo load factor across flights. The primary operational efficiency KPI for cargo capacity utilisation."
    - name: "total_maximum_takeoff_weight_kg"
      expr: SUM(CAST(maximum_takeoff_weight_kg AS DOUBLE))
      comment: "Total maximum takeoff weight capacity across all load plans. Baseline for structural weight utilisation analysis."
    - name: "total_actual_takeoff_weight_kg"
      expr: SUM(CAST(actual_takeoff_weight_kg AS DOUBLE))
      comment: "Total actual takeoff weight across all flights. Used with MTOW to compute weight utilisation rate."
    - name: "takeoff_weight_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_takeoff_weight_kg AS DOUBLE)) / NULLIF(SUM(CAST(maximum_takeoff_weight_kg AS DOUBLE)), 0), 2)
      comment: "Actual takeoff weight as a percentage of maximum takeoff weight. Measures structural weight utilisation — a key safety and revenue optimisation KPI."
    - name: "regulatory_non_compliance_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 END)
      comment: "Number of load plans that failed regulatory compliance checks. Critical safety KPI — any non-zero value triggers immediate operational review."
    - name: "avg_cargo_center_of_gravity_mac_pct"
      expr: AVG(CAST(cargo_center_of_gravity_mac_percent AS DOUBLE))
      comment: "Average cargo centre of gravity as a percentage of mean aerodynamic chord. Tracks weight distribution compliance for flight safety."
    - name: "trim_adjustment_required_count"
      expr: COUNT(CASE WHEN trim_adjustment_required_flag = TRUE THEN 1 END)
      comment: "Number of load plans requiring trim adjustment. Tracks weight distribution issues impacting fuel efficiency and safety."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_dangerous_goods`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dangerous goods compliance and volume metrics. Tracks DG shipment volumes, compliance verification rates, acceptance check outcomes, and high-risk categories. Core KPIs for safety, regulatory compliance, and risk management."
  source: "`airlines_ecm`.`cargo`.`dangerous_goods`"
  dimensions:
    - name: "dg_class"
      expr: dg_class
      comment: "IATA dangerous goods class (e.g., Class 1 Explosives, Class 3 Flammable Liquids). Primary risk categorisation dimension."
    - name: "dg_division"
      expr: dg_division
      comment: "Subdivision within the DG class. Enables granular risk and compliance analysis."
    - name: "packing_group"
      expr: packing_group
      comment: "Packing group indicating hazard severity (I=high, II=medium, III=low). Tracks risk level distribution."
    - name: "acceptance_check_status"
      expr: acceptance_check_status
      comment: "Result of the DG acceptance check (e.g., accepted, rejected, pending). Primary compliance gate metric."
    - name: "compliance_verified_flag"
      expr: compliance_verified_flag
      comment: "Indicates whether full DG compliance was verified. Tracks regulatory adherence rate."
    - name: "cargo_aircraft_only_flag"
      expr: cargo_aircraft_only_flag
      comment: "Flags shipments restricted to cargo aircraft only. Tracks CAO volume for capacity planning and safety."
    - name: "acceptance_check_month"
      expr: DATE_TRUNC('month', acceptance_check_timestamp)
      comment: "Month of DG acceptance check. Primary time dimension for compliance trend analysis."
  measures:
    - name: "total_dg_shipments"
      expr: COUNT(1)
      comment: "Total number of dangerous goods shipment records. Baseline DG volume metric for regulatory reporting."
    - name: "compliance_verified_count"
      expr: COUNT(CASE WHEN compliance_verified_flag = TRUE THEN 1 END)
      comment: "Number of DG shipments with verified compliance. Tracks regulatory adherence volume."
    - name: "compliance_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DG shipments with verified compliance. The primary DG safety KPI — any decline triggers immediate regulatory and safety review."
    - name: "acceptance_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_check_status = 'rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DG shipments rejected at acceptance check. Tracks shipper compliance quality and regulatory risk."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of dangerous goods shipments. Measures DG payload volume for capacity and risk management."
    - name: "total_net_quantity"
      expr: SUM(CAST(total_net_quantity AS DOUBLE))
      comment: "Total net quantity of dangerous substances. Tracks hazardous material volume for regulatory reporting."
    - name: "cargo_aircraft_only_count"
      expr: COUNT(CASE WHEN cargo_aircraft_only_flag = TRUE THEN 1 END)
      comment: "Number of DG shipments restricted to cargo aircraft only. Tracks CAO volume impacting passenger flight capacity allocation."
    - name: "avg_transport_index"
      expr: AVG(CAST(transport_index AS DOUBLE))
      comment: "Average transport index for radioactive materials. Monitors radiation exposure risk level across DG shipments."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_freight_forwarder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight forwarder portfolio and credit metrics. Tracks forwarder account health, credit exposure, DG certification status, and contract coverage. Enables commercial teams to manage forwarder relationships and credit risk."
  source: "`airlines_ecm`.`cargo`.`freight_forwarder`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current account status of the forwarder (e.g., active, suspended, terminated). Primary account health dimension."
    - name: "forwarder_type"
      expr: forwarder_type
      comment: "Type of freight forwarder (e.g., IATA agent, GSSA, direct). Drives commercial segmentation."
    - name: "iata_accreditation_status"
      expr: iata_accreditation_status
      comment: "IATA accreditation status of the forwarder. Tracks regulatory standing and billing eligibility."
    - name: "dg_handling_certified_flag"
      expr: dg_handling_certified_flag
      comment: "Indicates whether the forwarder is certified for DG handling. Tracks DG-capable forwarder network coverage."
    - name: "cass_participation_flag"
      expr: cass_participation_flag
      comment: "Indicates CASS (Cargo Accounts Settlement System) participation. Tracks automated billing coverage."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the forwarder. Enables geographic portfolio analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the forwarder. Tracks settlement channel mix and collection risk."
  measures:
    - name: "total_forwarders"
      expr: COUNT(1)
      comment: "Total number of freight forwarder accounts. Baseline network coverage metric."
    - name: "active_forwarder_count"
      expr: COUNT(CASE WHEN account_status = 'active' THEN 1 END)
      comment: "Number of active freight forwarder accounts. Tracks active commercial network size."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to all freight forwarders. Represents aggregate credit exposure for financial risk management."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per forwarder. Tracks credit policy consistency and exposure concentration."
    - name: "dg_certified_forwarder_count"
      expr: COUNT(CASE WHEN dg_handling_certified_flag = TRUE THEN 1 END)
      comment: "Number of forwarders certified for dangerous goods handling. Tracks DG-capable network coverage for premium cargo."
    - name: "dg_certified_forwarder_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dg_handling_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of forwarders with DG certification. Measures DG network capability depth."
    - name: "cass_participation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cass_participation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of forwarders participating in CASS. Tracks automated billing coverage and collection efficiency."
    - name: "expiring_dg_certification_count"
      expr: COUNT(CASE WHEN dg_certification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND dg_handling_certified_flag = TRUE THEN 1 END)
      comment: "Number of forwarders with DG certification expiring within 90 days. Proactive compliance risk indicator for account management."
$$;