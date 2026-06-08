-- Metric views for domain: cargo | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core cargo revenue performance metrics including yield, revenue per RTK, and revenue composition by type and channel"
  source: "`airlines_ecm`.`cargo`.`cargo_revenue`"
  dimensions:
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for revenue recognition"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which cargo was booked (direct, agent, online, etc.)"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity classification code for cargo type"
    - name: "revenue_type"
      expr: revenue_type
      comment: "Type of revenue (freight, handling, surcharge, etc.)"
    - name: "service_level"
      expr: service_level
      comment: "Service level of cargo shipment (express, standard, economy)"
    - name: "destination_station_code"
      expr: destination_station_code
      comment: "Destination airport/station code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for revenue amounts"
    - name: "recognition_date"
      expr: recognition_date
      comment: "Date when revenue was recognized"
    - name: "recognition_year"
      expr: YEAR(recognition_date)
      comment: "Year of revenue recognition"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition"
    - name: "revenue_status"
      expr: revenue_status
      comment: "Status of revenue record (recognized, pending, adjusted)"
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total cargo revenue across all revenue types - primary top-line metric for cargo business performance"
    - name: "freight_revenue"
      expr: SUM(CAST(freight_revenue_amount AS DOUBLE))
      comment: "Revenue from freight charges - core cargo transportation revenue"
    - name: "handling_revenue"
      expr: SUM(CAST(handling_revenue_amount AS DOUBLE))
      comment: "Revenue from cargo handling services"
    - name: "surcharge_revenue"
      expr: SUM(CAST(surcharge_revenue_amount AS DOUBLE))
      comment: "Revenue from surcharges (fuel, security, peak season, etc.)"
    - name: "total_rtk_flown"
      expr: SUM(CAST(rtk_flown AS DOUBLE))
      comment: "Total revenue tonne-kilometers flown - key capacity utilization metric"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Total weight of cargo shipped in kilograms"
    - name: "avg_yield_per_kg"
      expr: AVG(CAST(yield_per_kg AS DOUBLE))
      comment: "Average revenue yield per kilogram - critical pricing effectiveness metric"
    - name: "avg_revenue_per_rtk"
      expr: AVG(CAST(per_rtk AS DOUBLE))
      comment: "Average revenue per revenue tonne-kilometer - key unit economics metric"
    - name: "shipment_count"
      expr: COUNT(DISTINCT awb_id)
      comment: "Number of unique air waybills (shipments) generating revenue"
    - name: "revenue_transaction_count"
      expr: COUNT(1)
      comment: "Total number of revenue transactions recorded"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo capacity utilization and availability metrics for flight inventory management and yield optimization"
  source: "`airlines_ecm`.`cargo`.`capacity`"
  dimensions:
    - name: "flight_date"
      expr: flight_date
      comment: "Date of flight operation"
    - name: "flight_year"
      expr: YEAR(flight_date)
      comment: "Year of flight operation"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_date)
      comment: "Month of flight operation"
    - name: "flight_number"
      expr: flight_number
      comment: "Flight number identifier"
    - name: "destination_station_code"
      expr: destination_station_code
      comment: "Destination airport/station code"
    - name: "aircraft_configuration"
      expr: aircraft_configuration
      comment: "Aircraft configuration type (passenger, freighter, combi)"
    - name: "capacity_status"
      expr: capacity_status
      comment: "Status of capacity (available, full, restricted, embargoed)"
    - name: "embargo_flag"
      expr: embargo_flag
      comment: "Whether capacity is under embargo"
    - name: "bulk_cargo_allowed_flag"
      expr: bulk_cargo_allowed_flag
      comment: "Whether bulk cargo is allowed on this flight"
  measures:
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(total_weight_capacity_kg AS DOUBLE))
      comment: "Total cargo weight capacity available across flights - key supply metric"
    - name: "available_weight_kg"
      expr: SUM(CAST(available_weight_kg AS DOUBLE))
      comment: "Available cargo weight capacity remaining for booking"
    - name: "booked_weight_kg"
      expr: SUM(CAST(booked_weight_kg AS DOUBLE))
      comment: "Total cargo weight already booked"
    - name: "total_volume_capacity_cbm"
      expr: SUM(CAST(total_volume_capacity_cbm AS DOUBLE))
      comment: "Total cargo volume capacity in cubic meters"
    - name: "available_volume_cbm"
      expr: SUM(CAST(available_volume_cbm AS DOUBLE))
      comment: "Available cargo volume capacity remaining"
    - name: "booked_volume_cbm"
      expr: SUM(CAST(booked_volume_cbm AS DOUBLE))
      comment: "Total cargo volume already booked"
    - name: "avg_weight_utilization_pct"
      expr: AVG(CAST(100.0 * booked_weight_kg / NULLIF(total_weight_capacity_kg, 0) AS DOUBLE))
      comment: "Average weight capacity utilization percentage - critical efficiency metric for cargo operations"
    - name: "avg_volume_utilization_pct"
      expr: AVG(CAST(100.0 * booked_volume_cbm / NULLIF(total_volume_capacity_cbm, 0) AS DOUBLE))
      comment: "Average volume capacity utilization percentage"
    - name: "belly_cargo_weight_capacity_kg"
      expr: SUM(CAST(belly_cargo_weight_capacity_kg AS DOUBLE))
      comment: "Total belly cargo weight capacity (passenger aircraft lower deck)"
    - name: "main_deck_weight_capacity_kg"
      expr: SUM(CAST(main_deck_weight_capacity_kg AS DOUBLE))
      comment: "Total main deck cargo weight capacity (freighter aircraft)"
    - name: "flight_count"
      expr: COUNT(1)
      comment: "Number of flight capacity records"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_awb`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Air waybill operational and financial metrics tracking shipment volume, weight, charges, and processing performance"
  source: "`airlines_ecm`.`cargo`.`awb`"
  dimensions:
    - name: "awb_status"
      expr: awb_status
      comment: "Current status of air waybill (booked, accepted, manifested, delivered, etc.)"
    - name: "awb_type"
      expr: awb_type
      comment: "Type of air waybill (master, house, neutral)"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity classification code"
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport code"
    - name: "dangerous_goods_indicator"
      expr: dangerous_goods_indicator
      comment: "Whether shipment contains dangerous goods"
    - name: "payment_indicator"
      expr: payment_indicator
      comment: "Payment terms (prepaid, collect, credit)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for charges"
    - name: "executed_date"
      expr: executed_date
      comment: "Date AWB was executed"
    - name: "executed_year"
      expr: YEAR(executed_date)
      comment: "Year AWB was executed"
    - name: "executed_month"
      expr: DATE_TRUNC('MONTH', executed_date)
      comment: "Month AWB was executed"
    - name: "booking_date"
      expr: DATE(booking_timestamp)
      comment: "Date of booking"
    - name: "acceptance_date"
      expr: DATE(acceptance_timestamp)
      comment: "Date cargo was accepted"
  measures:
    - name: "awb_count"
      expr: COUNT(1)
      comment: "Total number of air waybills - primary volume metric for cargo operations"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight (greater of actual or volumetric weight) - key billing metric"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total actual gross weight of shipments"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of shipments in cubic meters"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges billed - core revenue metric"
    - name: "total_charges"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total all-in charges including freight, valuation, and other charges"
    - name: "total_declared_value_carriage"
      expr: SUM(CAST(declared_value_for_carriage AS DOUBLE))
      comment: "Total declared value for carriage - risk exposure metric"
    - name: "total_declared_value_customs"
      expr: SUM(CAST(declared_value_for_customs AS DOUBLE))
      comment: "Total declared value for customs purposes"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per AWB - shipment size metric"
    - name: "avg_freight_charge"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per AWB - pricing metric"
    - name: "dangerous_goods_count"
      expr: SUM(CASE WHEN dangerous_goods_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of AWBs containing dangerous goods - compliance and safety metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment tracking and operational performance metrics including on-time delivery, exceptions, and customs clearance"
  source: "`airlines_ecm`.`cargo`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of shipment (booked, in-transit, delivered, exception)"
    - name: "origin_station_code"
      expr: origin_station_code
      comment: "Origin airport/station code"
    - name: "destination_station_code"
      expr: destination_station_code
      comment: "Destination airport/station code"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity classification code"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether shipment contains dangerous goods"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether shipment has exceptions"
    - name: "exception_reason"
      expr: exception_reason
      comment: "Reason for shipment exception"
    - name: "customs_cleared_flag"
      expr: customs_cleared_flag
      comment: "Whether shipment has cleared customs"
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening status"
    - name: "acceptance_date"
      expr: DATE(acceptance_timestamp)
      comment: "Date cargo was accepted"
    - name: "delivery_date"
      expr: DATE(delivery_timestamp)
      comment: "Date cargo was delivered"
  measures:
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipments tracked"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight of shipments"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight for billing"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of shipments"
    - name: "exception_count"
      expr: SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with exceptions - key operational quality metric"
    - name: "exception_rate_pct"
      expr: AVG(CASE WHEN exception_flag = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of shipments with exceptions - critical service quality KPI"
    - name: "customs_cleared_count"
      expr: SUM(CASE WHEN customs_cleared_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments that have cleared customs"
    - name: "dangerous_goods_shipment_count"
      expr: SUM(CASE WHEN dangerous_goods_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dangerous goods shipments - compliance tracking metric"
    - name: "delivered_shipment_count"
      expr: SUM(CASE WHEN delivery_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of shipments successfully delivered"
    - name: "avg_actual_weight_kg"
      expr: AVG(CAST(actual_weight_kg AS DOUBLE))
      comment: "Average actual weight per shipment"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo booking performance metrics including conversion rates, cancellations, and booking channel effectiveness"
  source: "`airlines_ecm`.`cargo`.`cargo_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Status of booking (confirmed, pending, cancelled, expired)"
    - name: "channel"
      expr: channel
      comment: "Booking channel (online, agent, direct, API)"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity classification code"
    - name: "destination_station_code"
      expr: destination_station_code
      comment: "Destination airport/station code"
    - name: "dangerous_goods_indicator"
      expr: dangerous_goods_indicator
      comment: "Whether booking includes dangerous goods"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for booking cancellation"
    - name: "booking_date"
      expr: DATE(booking_timestamp)
      comment: "Date of booking"
    - name: "booking_year"
      expr: YEAR(booking_timestamp)
      comment: "Year of booking"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month of booking"
    - name: "requested_flight_date"
      expr: requested_flight_date
      comment: "Requested flight date"
  measures:
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Total number of cargo bookings - primary demand metric"
    - name: "confirmed_booking_count"
      expr: SUM(CASE WHEN booking_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Number of confirmed bookings"
    - name: "cancelled_booking_count"
      expr: SUM(CASE WHEN booking_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled bookings"
    - name: "cancellation_rate_pct"
      expr: AVG(CASE WHEN booking_status = 'cancelled' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of bookings cancelled - key customer satisfaction and operational efficiency metric"
    - name: "total_requested_weight_kg"
      expr: SUM(CAST(requested_weight_kg AS DOUBLE))
      comment: "Total requested cargo weight - demand forecast metric"
    - name: "total_requested_volume_cbm"
      expr: SUM(CAST(requested_volume_cbm AS DOUBLE))
      comment: "Total requested cargo volume"
    - name: "total_quoted_rate_amount"
      expr: SUM(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Total quoted rate amounts - potential revenue metric"
    - name: "avg_requested_weight_kg"
      expr: AVG(CAST(requested_weight_kg AS DOUBLE))
      comment: "Average requested weight per booking"
    - name: "avg_quoted_rate"
      expr: AVG(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Average quoted rate per booking - pricing metric"
    - name: "dangerous_goods_booking_count"
      expr: SUM(CASE WHEN dangerous_goods_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings with dangerous goods"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo claims and loss metrics tracking claim frequency, amounts, settlement rates, and liability exposure"
  source: "`airlines_ecm`.`cargo`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of claim (filed, investigating, approved, settled, rejected)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (damage, loss, delay, shortage)"
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (shipper, consignee, forwarder, insurer)"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of claim (approved, denied, settled, withdrawn)"
    - name: "liability_determination"
      expr: liability_determination
      comment: "Liability determination (carrier, shipper, third-party, shared)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for claim amounts"
    - name: "filing_date"
      expr: filing_date
      comment: "Date claim was filed"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year claim was filed"
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month claim was filed"
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date claim was settled"
  measures:
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of cargo claims - key quality and risk metric"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed by customers - liability exposure metric"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount paid in settlements - actual loss metric critical for P&L"
    - name: "avg_claimed_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average amount claimed per claim"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "settled_claim_count"
      expr: SUM(CASE WHEN settlement_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of claims that have been settled"
    - name: "approved_claim_count"
      expr: SUM(CASE WHEN outcome = 'approved' THEN 1 ELSE 0 END)
      comment: "Number of claims approved for payment"
    - name: "rejected_claim_count"
      expr: SUM(CASE WHEN outcome = 'denied' THEN 1 ELSE 0 END)
      comment: "Number of claims rejected"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Total weight of shipments involved in claims"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_freight_forwarder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight forwarder partner performance and relationship metrics including accreditation status and credit exposure"
  source: "`airlines_ecm`.`cargo`.`freight_forwarder`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current account status (active, suspended, closed)"
    - name: "forwarder_type"
      expr: forwarder_type
      comment: "Type of freight forwarder (IATA agent, consolidator, broker)"
    - name: "iata_accreditation_status"
      expr: iata_accreditation_status
      comment: "IATA accreditation status"
    - name: "dg_handling_certified_flag"
      expr: dg_handling_certified_flag
      comment: "Whether forwarder is certified to handle dangerous goods"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (cash, credit, CASS)"
    - name: "cass_participation_flag"
      expr: cass_participation_flag
      comment: "Whether forwarder participates in CASS settlement"
    - name: "accreditation_date"
      expr: accreditation_date
      comment: "Date of IATA accreditation"
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date"
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date"
  measures:
    - name: "forwarder_count"
      expr: COUNT(1)
      comment: "Total number of freight forwarder partners - network breadth metric"
    - name: "active_forwarder_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active freight forwarder accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to forwarders - credit risk exposure metric"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per forwarder"
    - name: "dg_certified_forwarder_count"
      expr: SUM(CASE WHEN dg_handling_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dangerous goods certified forwarders - compliance capability metric"
    - name: "cass_participant_count"
      expr: SUM(CASE WHEN cass_participation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of forwarders participating in CASS settlement"
    - name: "iata_accredited_count"
      expr: SUM(CASE WHEN iata_accreditation_status = 'accredited' THEN 1 ELSE 0 END)
      comment: "Number of IATA accredited forwarders - quality partner metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight manifest operational metrics tracking cargo volume, piece counts, special cargo, and customs compliance"
  source: "`airlines_ecm`.`cargo`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Status of manifest (draft, finalized, departed, arrived)"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of operation (departure, arrival, transit)"
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport code"
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport code"
    - name: "dangerous_goods_indicator"
      expr: dangerous_goods_indicator
      comment: "Whether manifest contains dangerous goods"
    - name: "live_animals_indicator"
      expr: live_animals_indicator
      comment: "Whether manifest contains live animals"
    - name: "perishables_indicator"
      expr: perishables_indicator
      comment: "Whether manifest contains perishable cargo"
    - name: "valuable_cargo_indicator"
      expr: valuable_cargo_indicator
      comment: "Whether manifest contains valuable cargo"
    - name: "security_screening_status"
      expr: security_screening_status
      comment: "Security screening status"
    - name: "flight_date"
      expr: flight_date
      comment: "Date of flight"
    - name: "flight_year"
      expr: YEAR(flight_date)
      comment: "Year of flight"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_date)
      comment: "Month of flight"
  measures:
    - name: "manifest_count"
      expr: COUNT(1)
      comment: "Total number of cargo manifests - flight operations volume metric"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total cargo weight manifested - key operational metric"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(total_chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight manifested - revenue weight metric"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total cargo volume manifested"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Total declared value of cargo - risk exposure metric"
    - name: "avg_cargo_weight_per_manifest_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average cargo weight per manifest - load factor metric"
    - name: "dangerous_goods_manifest_count"
      expr: SUM(CASE WHEN dangerous_goods_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of manifests with dangerous goods - compliance tracking metric"
    - name: "live_animals_manifest_count"
      expr: SUM(CASE WHEN live_animals_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of manifests with live animals"
    - name: "valuable_cargo_manifest_count"
      expr: SUM(CASE WHEN valuable_cargo_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of manifests with valuable cargo - security risk metric"
    - name: "finalized_manifest_count"
      expr: SUM(CASE WHEN finalized_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of finalized manifests - operational readiness metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`cargo_uld`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit load device asset utilization and maintenance metrics tracking fleet size, serviceability, and inspection compliance"
  source: "`airlines_ecm`.`cargo`.`uld`"
  dimensions:
    - name: "serviceable_status"
      expr: serviceable_status
      comment: "Serviceability status (serviceable, unserviceable, under repair)"
    - name: "damage_status"
      expr: damage_status
      comment: "Damage status (none, minor, major, beyond repair)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, pooled)"
    - name: "type_code"
      expr: type_code
      comment: "ULD type code (AKE, AKN, PMC, etc.)"
    - name: "uld_category"
      expr: uld_category
      comment: "ULD category (container, pallet, igloo)"
    - name: "dangerous_goods_certified_flag"
      expr: dangerous_goods_certified_flag
      comment: "Whether ULD is certified for dangerous goods"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether ULD has temperature control capability"
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date ULD was acquired"
    - name: "last_inspection_date"
      expr: last_inspection_date
      comment: "Date of last inspection"
  measures:
    - name: "uld_count"
      expr: COUNT(1)
      comment: "Total number of ULDs in fleet - asset inventory metric"
    - name: "serviceable_uld_count"
      expr: SUM(CASE WHEN serviceable_status = 'serviceable' THEN 1 ELSE 0 END)
      comment: "Number of serviceable ULDs - operational capacity metric"
    - name: "unserviceable_uld_count"
      expr: SUM(CASE WHEN serviceable_status = 'unserviceable' THEN 1 ELSE 0 END)
      comment: "Number of unserviceable ULDs"
    - name: "serviceability_rate_pct"
      expr: AVG(CASE WHEN serviceable_status = 'serviceable' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of ULDs that are serviceable - critical asset utilization KPI"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_amount AS DOUBLE))
      comment: "Total acquisition cost of ULD fleet - capital investment metric"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost_amount AS DOUBLE))
      comment: "Average acquisition cost per ULD"
    - name: "total_tare_weight_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight of ULD fleet"
    - name: "total_max_gross_weight_kg"
      expr: SUM(CAST(maximum_gross_weight_kg AS DOUBLE))
      comment: "Total maximum gross weight capacity of ULD fleet"
    - name: "dg_certified_uld_count"
      expr: SUM(CASE WHEN dangerous_goods_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dangerous goods certified ULDs - compliance capability metric"
    - name: "temperature_controlled_uld_count"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of temperature controlled ULDs - specialized capability metric"
$$;