-- Metric views for domain: reservation | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_pnr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core PNR (Passenger Name Record) booking metrics. Tracks booking volumes, revenue, and booking mix across channels, trip types, and booking sources — essential for revenue management and distribution strategy."
  source: "`airlines_ecm`.`reservation`.`pnr`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the PNR (e.g. CONFIRMED, CANCELLED, WAITLISTED) — used to segment active vs. cancelled bookings."
    - name: "booking_type"
      expr: booking_type
      comment: "Type of booking (e.g. INDIVIDUAL, GROUP, STAFF) — drives revenue mix analysis."
    - name: "booking_source"
      expr: booking_source
      comment: "System or channel that originated the booking (e.g. GDS, DIRECT, OTA) — critical for distribution cost analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel through which the booking was made — used for channel profitability analysis."
    - name: "trip_type"
      expr: trip_type
      comment: "Trip type (e.g. ONE_WAY, ROUND_TRIP, MULTI_CITY) — informs fare and ancillary bundling strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was priced — used for multi-currency revenue reporting."
    - name: "point_of_sale_country"
      expr: point_of_sale_country
      comment: "Country where the booking was sold — supports geographic revenue attribution."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Whether the booking involves a codeshare flight — used to separate own-metal vs. partner revenue."
    - name: "interline_indicator"
      expr: interline_indicator
      comment: "Whether the booking involves an interline itinerary — relevant for interline settlement analysis."
    - name: "departure_date"
      expr: DATE_TRUNC('month', departure_date)
      comment: "Departure month — primary time dimension for booking trend analysis."
    - name: "creation_month"
      expr: DATE_TRUNC('month', creation_timestamp)
      comment: "Month the PNR was created — used for booking curve and advance-purchase analysis."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of PNRs created. Baseline booking volume KPI used in all revenue and capacity planning dashboards."
    - name: "confirmed_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of PNRs in CONFIRMED status. Represents firm demand and is the primary input to load factor and revenue forecasting."
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled PNRs. Elevated cancellation rates signal demand volatility or fare rule issues requiring revenue management intervention."
    - name: "total_base_fare_revenue"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Sum of base fare amounts across all PNRs. Core revenue KPI excluding taxes and surcharges — used for yield and RASK calculations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all PNRs. Required for regulatory reporting and net revenue reconciliation."
    - name: "total_fare_revenue"
      expr: SUM(CAST(total_fare_amount AS DOUBLE))
      comment: "Total fare revenue including taxes and surcharges. Top-line passenger revenue KPI for P&L reporting."
    - name: "avg_total_fare_per_pnr"
      expr: AVG(CAST(total_fare_amount AS DOUBLE))
      comment: "Average total fare per PNR. Proxy for average ticket value — a key yield management indicator tracked weekly by revenue management."
    - name: "avg_base_fare_per_pnr"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare per PNR excluding taxes. Used to track pure yield trends independent of tax regime changes."
    - name: "ticketed_bookings"
      expr: COUNT(CASE WHEN ticketed_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of PNRs that have been ticketed. Ticketing conversion rate (ticketed / confirmed) is a key revenue assurance metric."
    - name: "corporate_bookings"
      expr: COUNT(CASE WHEN corporate_account_number IS NOT NULL THEN 1 END)
      comment: "Number of PNRs linked to a corporate account. Tracks corporate channel penetration — a strategic revenue diversification KPI."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_booking_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction metrics for airline bookings. Tracks payment volumes, revenue collected, refund exposure, fraud risk, and payment method mix — essential for treasury, fraud management, and revenue assurance."
  source: "`airlines_ecm`.`reservation`.`booking_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment transaction (e.g. AUTHORISED, SETTLED, DECLINED, REFUNDED) — primary dimension for payment health monitoring."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method used (e.g. CREDIT_CARD, DEBIT_CARD, MILES, VOUCHER) — used for payment mix and cost-of-acceptance analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card scheme (e.g. VISA, MASTERCARD, AMEX) — relevant for interchange fee benchmarking."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the payment transaction — used for FX exposure and multi-currency settlement reporting."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — used for geographic fraud risk profiling and regulatory compliance."
    - name: "instalment_plan_flag"
      expr: instalment_plan_flag
      comment: "Whether the payment is on an instalment plan — used to track instalment adoption and associated credit risk."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_timestamp)
      comment: "Month of payment — primary time dimension for cash collection trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount collected. Primary cash collection KPI for treasury and revenue assurance dashboards."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers. High refund volumes signal cancellation waves, schedule disruptions, or fare rule issues."
    - name: "net_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net payment amount after refunds. True cash retained — the most important treasury KPI for short-term liquidity management."
    - name: "total_miles_redeemed"
      expr: SUM(CAST(miles_redeemed_quantity AS DOUBLE))
      comment: "Total frequent flyer miles redeemed as payment. Tracks loyalty liability burn-down and mileage redemption revenue contribution."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks average ticket value trends and is used to detect anomalous payment patterns."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across payment transactions. Elevated scores trigger fraud team intervention and payment gateway rule adjustments."
    - name: "high_fraud_risk_payments"
      expr: COUNT(CASE WHEN CAST(fraud_score AS DOUBLE) >= 70 THEN 1 END)
      comment: "Number of payments with a fraud score >= 70 (high risk threshold). Key fraud operations KPI — directly linked to chargeback exposure and revenue leakage."
    - name: "declined_payments"
      expr: COUNT(CASE WHEN payment_status = 'DECLINED' THEN 1 END)
      comment: "Number of declined payment transactions. High decline rates indicate payment gateway issues or fraud rule over-triggering, causing booking abandonment and revenue loss."
    - name: "settled_payments"
      expr: COUNT(CASE WHEN payment_status = 'SETTLED' THEN 1 END)
      comment: "Number of successfully settled payment transactions. Baseline for settlement reconciliation and revenue recognition."
    - name: "instalment_payment_count"
      expr: COUNT(CASE WHEN instalment_plan_flag = TRUE THEN 1 END)
      comment: "Number of payments on instalment plans. Tracks instalment product adoption — a strategic ancillary revenue and conversion rate lever."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_e_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic ticket metrics covering ticket issuance, fare revenue, tax collection, commission costs, and ticket lifecycle status. Central to revenue accounting, BSP settlement, and yield management."
  source: "`airlines_ecm`.`reservation`.`e_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the e-ticket (e.g. OPEN, USED, REFUNDED, VOIDED, EXCHANGED) — primary dimension for ticket lifecycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Ticketing currency — used for multi-currency revenue reporting and BSP settlement."
    - name: "issuing_airline_code"
      expr: issuing_airline_code
      comment: "IATA code of the airline that issued the ticket — used to separate own-issued vs. interline-issued ticket revenue."
    - name: "validating_carrier_code"
      expr: validating_carrier_code
      comment: "Validating carrier code — determines which airline is responsible for BSP settlement."
    - name: "form_of_payment_type"
      expr: form_of_payment_type
      comment: "Form of payment on the ticket (e.g. CC, CASH, MILES) — used for payment mix and revenue assurance analysis."
    - name: "exchange_ticket_indicator"
      expr: exchange_ticket_indicator
      comment: "Whether this ticket is an exchange/reissue — used to track ticket change volumes and associated revenue impact."
    - name: "refund_indicator"
      expr: refund_indicator
      comment: "Whether a refund has been processed against this ticket — used to track refund exposure."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_timestamp)
      comment: "Month the ticket was issued — primary time dimension for ticket issuance trend and advance-purchase analysis."
  measures:
    - name: "total_tickets_issued"
      expr: COUNT(1)
      comment: "Total number of e-tickets issued. Baseline ticket volume KPI used in BSP reporting and revenue accounting reconciliation."
    - name: "total_base_fare_revenue"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Sum of base fare amounts across all e-tickets. Core yield metric — used to compute RASK and track fare level trends."
    - name: "total_tax_revenue"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total taxes collected on e-tickets. Required for regulatory tax remittance reporting and net revenue reconciliation."
    - name: "total_ticket_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total ticket revenue including base fare and taxes. Top-line passenger revenue KPI for P&L and BSP settlement."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to agents on issued tickets. Key distribution cost KPI — directly impacts net revenue margin."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across tickets. Tracks agency commission cost trends — a lever for distribution cost management."
    - name: "avg_base_fare"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare per ticket. Primary yield indicator — tracked daily by revenue management to assess pricing effectiveness."
    - name: "avg_total_ticket_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total ticket value including taxes. Tracks average revenue per ticket — a key metric for pricing strategy reviews."
    - name: "refunded_tickets"
      expr: COUNT(CASE WHEN refund_indicator = TRUE THEN 1 END)
      comment: "Number of tickets with a refund processed. Elevated refund counts signal disruption events or fare rule compliance issues."
    - name: "exchanged_tickets"
      expr: COUNT(CASE WHEN exchange_ticket_indicator = TRUE THEN 1 END)
      comment: "Number of exchanged/reissued tickets. High exchange volumes indicate schedule instability or flexible fare demand — informs fare product design."
    - name: "voided_tickets"
      expr: COUNT(CASE WHEN ticket_status = 'VOIDED' THEN 1 END)
      comment: "Number of voided tickets. Voids represent lost revenue opportunities and may indicate booking system or agent workflow issues."
    - name: "total_equivalent_fare_revenue"
      expr: SUM(CAST(equivalent_fare_amount AS DOUBLE))
      comment: "Total fare revenue in the equivalent (reporting) currency. Used for standardised multi-currency revenue reporting and FX impact analysis."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_refund_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund transaction metrics tracking refund volumes, amounts, penalty recovery, and processing efficiency. Critical for revenue leakage management, customer experience, and regulatory compliance."
  source: "`airlines_ecm`.`reservation`.`refund_transaction`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g. PENDING, APPROVED, PROCESSED, REJECTED) — primary dimension for refund pipeline monitoring."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g. INVOLUNTARY, VOLUNTARY, SCHEDULE_CHANGE) — used to separate controllable vs. uncontrollable refund costs."
    - name: "refund_reason_code"
      expr: refund_reason_code
      comment: "Coded reason for the refund — used to identify root causes of revenue leakage and prioritise remediation."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to process the refund (e.g. ORIGINAL_FORM, VOUCHER, MILES) — tracks voucher vs. cash refund mix, which impacts liquidity."
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which the refund was processed (e.g. AIRPORT, CALL_CENTRE, ONLINE) — used for operational cost attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund transaction — used for multi-currency refund liability reporting."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether a fee waiver was applied to the refund — tracks waiver policy compliance and associated revenue impact."
    - name: "refund_request_month"
      expr: DATE_TRUNC('month', refund_request_timestamp)
      comment: "Month the refund was requested — used for refund trend analysis and seasonal pattern detection."
    - name: "refund_processing_month"
      expr: DATE_TRUNC('month', refund_processing_timestamp)
      comment: "Month the refund was processed — used to measure refund processing backlog and SLA compliance."
  measures:
    - name: "total_refund_transactions"
      expr: COUNT(1)
      comment: "Total number of refund transactions. Baseline refund volume KPI — spikes indicate disruption events or policy issues requiring executive attention."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total base refund amount paid out. Primary revenue leakage KPI — directly impacts net passenger revenue on the P&L."
    - name: "total_tax_refund_amount"
      expr: SUM(CAST(tax_refund_amount AS DOUBLE))
      comment: "Total taxes refunded. Required for tax authority reconciliation and net tax liability reporting."
    - name: "total_gross_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total gross refund amount including taxes and fees. Full cash outflow KPI for treasury and liquidity management."
    - name: "total_penalty_recovered"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total cancellation/change penalties retained from refunds. Penalty recovery is a key revenue protection metric — low recovery signals fare rule enforcement gaps."
    - name: "total_original_fare_amount"
      expr: SUM(CAST(original_fare_amount AS DOUBLE))
      comment: "Sum of original fare amounts on refunded tickets. Used to compute refund rate as a percentage of original revenue."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction. Tracks average refund size — useful for detecting high-value refund clusters that may indicate fraud or policy abuse."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount retained per refund. Benchmarks fare rule enforcement effectiveness across booking channels and passenger types."
    - name: "waived_penalty_refunds"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Number of refunds where the cancellation penalty was waived. Tracks waiver policy usage — excessive waivers represent unrecovered revenue and require management review."
    - name: "fee_refund_total"
      expr: SUM(CAST(fee_refund_amount AS DOUBLE))
      comment: "Total ancillary fees refunded alongside ticket refunds. Tracks ancillary revenue reversal exposure during disruption events."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_check_in_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Check-in event metrics tracking check-in volumes, channel mix, baggage handling, upgrade activity, and operational efficiency. Used by airport operations, customer experience, and ground handling management."
  source: "`airlines_ecm`.`reservation`.`check_in_event`"
  dimensions:
    - name: "check_in_status"
      expr: check_in_status
      comment: "Status of the check-in event (e.g. COMPLETED, FAILED, PENDING) — primary dimension for check-in completion rate analysis."
    - name: "check_in_channel"
      expr: check_in_channel
      comment: "Channel used for check-in (e.g. WEB, MOBILE, KIOSK, COUNTER) — critical for self-service adoption and cost-per-check-in analysis."
    - name: "check_in_station_code"
      expr: check_in_station_code
      comment: "Airport station where check-in occurred — used for station-level operational performance benchmarking."
    - name: "priority_boarding_flag"
      expr: priority_boarding_flag
      comment: "Whether the passenger received priority boarding — used to track premium service utilisation and loyalty benefit delivery."
    - name: "upgrade_at_check_in_flag"
      expr: upgrade_at_check_in_flag
      comment: "Whether the passenger was upgraded at check-in — tracks upgrade conversion rate, a key ancillary revenue and loyalty KPI."
    - name: "mobile_boarding_pass_issued_flag"
      expr: mobile_boarding_pass_issued_flag
      comment: "Whether a mobile boarding pass was issued — tracks digital adoption rate, a key cost reduction and customer experience KPI."
    - name: "apis_submission_status"
      expr: apis_submission_status
      comment: "Status of APIS (Advance Passenger Information System) submission — regulatory compliance dimension; failures can result in fines."
    - name: "check_in_month"
      expr: DATE_TRUNC('month', check_in_timestamp)
      comment: "Month of check-in event — primary time dimension for check-in volume trend analysis."
  measures:
    - name: "total_check_ins"
      expr: COUNT(1)
      comment: "Total number of check-in events. Baseline operational volume KPI for airport staffing and resource planning."
    - name: "completed_check_ins"
      expr: COUNT(CASE WHEN check_in_status = 'COMPLETED' THEN 1 END)
      comment: "Number of successfully completed check-ins. Completion rate (completed / total) is the primary check-in operational KPI."
    - name: "self_service_check_ins"
      expr: COUNT(CASE WHEN check_in_channel IN ('WEB', 'MOBILE', 'KIOSK') THEN 1 END)
      comment: "Number of check-ins via self-service channels. Self-service adoption rate directly reduces ground handling cost per passenger."
    - name: "mobile_boarding_passes_issued"
      expr: COUNT(CASE WHEN mobile_boarding_pass_issued_flag = TRUE THEN 1 END)
      comment: "Number of mobile boarding passes issued. Tracks digital boarding pass adoption — a key sustainability and cost reduction metric."
    - name: "upgrades_at_check_in"
      expr: COUNT(CASE WHEN upgrade_at_check_in_flag = TRUE THEN 1 END)
      comment: "Number of passengers upgraded at check-in. Upgrade conversion is a key ancillary revenue and premium cabin yield optimisation KPI."
    - name: "total_checked_baggage_weight_kg"
      expr: SUM(CAST(checked_baggage_weight_kg AS DOUBLE))
      comment: "Total checked baggage weight in kilograms. Used for load planning, fuel cost attribution, and excess baggage revenue analysis."
    - name: "avg_checked_baggage_weight_kg"
      expr: AVG(CAST(checked_baggage_weight_kg AS DOUBLE))
      comment: "Average checked baggage weight per check-in event. Benchmarks baggage load against allowance thresholds — informs baggage policy and fee design."
    - name: "total_excess_baggage_fees"
      expr: SUM(CAST(excess_baggage_fee_amount AS DOUBLE))
      comment: "Total excess baggage fees collected at check-in. Key ancillary revenue KPI — tracked by airport revenue managers to optimise baggage fee structures."
    - name: "avg_excess_baggage_fee"
      expr: AVG(CAST(excess_baggage_fee_amount AS DOUBLE))
      comment: "Average excess baggage fee per check-in event. Used to benchmark fee yield and assess baggage allowance policy effectiveness."
    - name: "apis_failed_submissions"
      expr: COUNT(CASE WHEN apis_submission_status = 'FAILED' THEN 1 END)
      comment: "Number of failed APIS submissions. APIS failures are a regulatory compliance risk — airlines can face fines and boarding denials if not resolved promptly."
    - name: "priority_boarding_passengers"
      expr: COUNT(CASE WHEN priority_boarding_flag = TRUE THEN 1 END)
      comment: "Number of passengers with priority boarding. Tracks premium service delivery volume — used to validate loyalty benefit fulfilment rates."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_itinerary_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Itinerary segment metrics covering booked segment volumes, fare revenue by cabin and booking class, codeshare and interline mix, and flown vs. booked ratios. Core to revenue management, network planning, and interline settlement."
  source: "`airlines_ecm`.`reservation`.`itinerary_segment`"
  dimensions:
    - name: "booking_class_code"
      expr: booking_class_code
      comment: "RBD (Reservation Booking Designator) — the inventory class in which the segment was booked. Primary dimension for revenue management yield analysis."
    - name: "fare_basis_code"
      expr: fare_basis_code
      comment: "Fare basis code of the booked segment — used for fare product performance analysis and revenue accounting."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "Marketing airline code — used to separate own-metal vs. codeshare marketed segments for revenue attribution."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "Operating airline code — used for interline proration and codeshare cost allocation."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Whether the segment is a codeshare — used to track codeshare revenue contribution and partner performance."
    - name: "interline_indicator"
      expr: interline_indicator
      comment: "Whether the segment is part of an interline itinerary — used for interline proration and settlement analysis."
    - name: "flown_indicator"
      expr: flown_indicator
      comment: "Whether the segment has been flown — used to compute no-show rates and flown revenue vs. booked revenue."
    - name: "booking_channel_code"
      expr: booking_channel_code
      comment: "Channel through which the segment was booked — used for distribution cost and channel yield analysis."
    - name: "fare_currency_code"
      expr: fare_currency_code
      comment: "Currency of the segment fare — used for multi-currency revenue reporting."
    - name: "segment_status_code"
      expr: segment_status_code
      comment: "Current status of the segment (e.g. HK=CONFIRMED, UN=UNABLE, WL=WAITLISTED) — used to track confirmed vs. waitlisted demand."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_datetime)
      comment: "Month of scheduled departure — primary time dimension for forward booking and revenue trend analysis."
  measures:
    - name: "total_booked_segments"
      expr: COUNT(1)
      comment: "Total number of booked itinerary segments. Baseline demand volume KPI used in load factor and capacity utilisation calculations."
    - name: "confirmed_segments"
      expr: COUNT(CASE WHEN segment_status_code = 'HK' THEN 1 END)
      comment: "Number of confirmed (HK status) segments. Confirmed segment count is the primary input to load factor and revenue forecasting models."
    - name: "flown_segments"
      expr: COUNT(CASE WHEN flown_indicator = TRUE THEN 1 END)
      comment: "Number of segments that have been flown. Used to compute no-show rate (booked - flown) and validate revenue recognition."
    - name: "total_segment_fare_revenue"
      expr: SUM(CAST(fare_amount AS DOUBLE))
      comment: "Total fare revenue across all booked segments. Core segment-level yield KPI — used to compute revenue per available seat mile (RASM)."
    - name: "avg_segment_fare"
      expr: AVG(CAST(fare_amount AS DOUBLE))
      comment: "Average fare per booked segment. Primary yield indicator at the segment level — tracked by revenue management to assess pricing effectiveness by route."
    - name: "codeshare_segments"
      expr: COUNT(CASE WHEN codeshare_indicator = TRUE THEN 1 END)
      comment: "Number of codeshare segments. Tracks codeshare volume contribution — used to evaluate partner airline agreements and revenue sharing."
    - name: "interline_segments"
      expr: COUNT(CASE WHEN interline_indicator = TRUE THEN 1 END)
      comment: "Number of interline segments. Tracks interline traffic volume — key input for interline proration and settlement with partner airlines."
    - name: "schedule_changed_segments"
      expr: COUNT(CASE WHEN schedule_change_indicator = TRUE THEN 1 END)
      comment: "Number of segments affected by a schedule change. High schedule change counts drive involuntary refund and rebooking costs — a key operational disruption KPI."
    - name: "stopover_segments"
      expr: COUNT(CASE WHEN stopover_indicator = TRUE THEN 1 END)
      comment: "Number of segments with a stopover. Tracks connecting itinerary complexity — relevant for hub connectivity and network planning analysis."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_fare_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare quote metrics tracking pricing activity, fare levels, discount and commission costs, and private fare usage. Used by revenue management, pricing teams, and distribution strategy to evaluate fare competitiveness and pricing efficiency."
  source: "`airlines_ecm`.`reservation`.`fare_quote`"
  dimensions:
    - name: "fare_quote_status"
      expr: fare_quote_status
      comment: "Status of the fare quote (e.g. ACTIVE, EXPIRED, TICKETED) — used to track quote-to-ticket conversion rates."
    - name: "fare_type"
      expr: fare_type
      comment: "Type of fare (e.g. PUBLISHED, PRIVATE, CORPORATE, AWARD) — primary dimension for fare product mix analysis."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "IATA passenger type code (e.g. ADT, CHD, INF) — used for passenger type yield analysis and fare product design."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fare quote — used for multi-currency pricing analysis."
    - name: "private_fare_indicator"
      expr: private_fare_indicator
      comment: "Whether the fare is a private/negotiated fare — used to track private fare penetration and associated revenue impact."
    - name: "repricing_indicator"
      expr: repricing_indicator
      comment: "Whether this is a repriced quote — tracks repricing activity volume, which may indicate schedule changes or fare adjustments."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of the pricing (e.g. GDS, DIRECT, NDC) — used for distribution channel pricing analysis."
    - name: "validating_carrier_code"
      expr: validating_carrier_code
      comment: "Validating carrier on the fare quote — used for interline and codeshare revenue attribution."
    - name: "pricing_month"
      expr: DATE_TRUNC('month', pricing_timestamp)
      comment: "Month the fare was priced — used for pricing activity trend analysis and advance-purchase curve monitoring."
  measures:
    - name: "total_fare_quotes"
      expr: COUNT(1)
      comment: "Total number of fare quotes generated. Tracks pricing activity volume — a leading indicator of booking demand and system load."
    - name: "total_base_fare_amount"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Sum of base fare amounts across all fare quotes. Tracks total fare value in the pricing pipeline — used for revenue forecasting."
    - name: "total_quoted_fare_amount"
      expr: SUM(CAST(total_fare_amount AS DOUBLE))
      comment: "Total fare amount quoted including taxes and surcharges. Represents the total revenue potential in the pricing pipeline."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total taxes included in fare quotes. Used for tax liability forecasting and regulatory compliance planning."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(total_surcharge_amount AS DOUBLE))
      comment: "Total surcharges (e.g. fuel surcharge, YQ) included in fare quotes. Tracks surcharge revenue contribution and fuel cost pass-through effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across fare quotes. Tracks promotional and corporate discount cost — a key revenue dilution KPI."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission cost across fare quotes. Tracks distribution cost at the pricing stage — used for net revenue margin analysis."
    - name: "avg_base_fare"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare per quote. Primary pricing yield indicator — tracked by revenue management to assess fare level competitiveness."
    - name: "avg_total_fare"
      expr: AVG(CAST(total_fare_amount AS DOUBLE))
      comment: "Average total fare per quote including taxes. Tracks average all-in price — the customer-facing price competitiveness metric."
    - name: "private_fare_quotes"
      expr: COUNT(CASE WHEN private_fare_indicator = TRUE THEN 1 END)
      comment: "Number of fare quotes using private/negotiated fares. Tracks private fare penetration — high penetration may indicate over-reliance on discounted channels."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across fare quotes. Benchmarks agency commission costs — used to negotiate and optimise distribution agreements."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_coupon_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket coupon status metrics tracking coupon lifecycle events (flown, refunded, exchanged, voided), cabin and booking class mix, and codeshare/interline activity. Essential for revenue accounting, BSP settlement, and coupon audit compliance."
  source: "`airlines_ecm`.`reservation`.`coupon_status`"
  dimensions:
    - name: "coupon_status_code"
      expr: coupon_status_code
      comment: "Current coupon status code (e.g. O=OPEN, F=FLOWN, R=REFUNDED, V=VOIDED, E=EXCHANGED) — primary dimension for coupon lifecycle analysis."
    - name: "cabin_class_code"
      expr: cabin_class_code
      comment: "Cabin class of the coupon (e.g. F, C, Y) — used for cabin mix and premium vs. economy revenue analysis."
    - name: "booking_class_code"
      expr: booking_class_code
      comment: "Booking class (RBD) of the coupon — used for inventory class yield analysis and revenue management reporting."
    - name: "fare_basis_code"
      expr: fare_basis_code
      comment: "Fare basis code of the coupon — used for fare product performance and revenue accounting."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "Marketing carrier code — used to attribute coupon revenue to the marketing airline."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "Operating carrier code — used for interline proration and codeshare cost allocation."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Whether the coupon is on a codeshare flight — used to separate own-metal vs. codeshare coupon volumes."
    - name: "interline_indicator"
      expr: interline_indicator
      comment: "Whether the coupon is part of an interline itinerary — used for interline settlement and proration analysis."
    - name: "reissue_indicator"
      expr: reissue_indicator
      comment: "Whether the coupon was reissued — tracks ticket exchange/reissue activity volume."
    - name: "irop_indicator"
      expr: irop_indicator
      comment: "Whether the coupon is associated with an irregular operation (IROP) — used to quantify disruption impact on coupon status changes."
    - name: "flown_month"
      expr: DATE_TRUNC('month', flown_timestamp)
      comment: "Month the coupon was flown — primary time dimension for flown revenue and traffic analysis."
    - name: "scheduled_departure_month"
      expr: DATE_TRUNC('month', scheduled_departure_date)
      comment: "Month of scheduled departure — used for forward-looking coupon and revenue analysis."
  measures:
    - name: "total_coupons"
      expr: COUNT(1)
      comment: "Total number of ticket coupons. Baseline coupon volume KPI used in BSP settlement reconciliation and revenue accounting."
    - name: "flown_coupons"
      expr: COUNT(CASE WHEN coupon_status_code = 'F' THEN 1 END)
      comment: "Number of flown coupons. Represents actual transported passengers — the primary traffic volume KPI for revenue per passenger mile calculations."
    - name: "open_coupons"
      expr: COUNT(CASE WHEN coupon_status_code = 'O' THEN 1 END)
      comment: "Number of open (unused) coupons. Represents future revenue liability — used in revenue forecasting and capacity planning."
    - name: "refunded_coupons"
      expr: COUNT(CASE WHEN coupon_status_code = 'R' THEN 1 END)
      comment: "Number of refunded coupons. Tracks refund volume at the coupon level — used for revenue leakage analysis and BSP refund reconciliation."
    - name: "voided_coupons"
      expr: COUNT(CASE WHEN coupon_status_code = 'V' THEN 1 END)
      comment: "Number of voided coupons. Voids represent cancelled revenue — elevated void rates may indicate booking system issues or agent errors."
    - name: "exchanged_coupons"
      expr: COUNT(CASE WHEN coupon_status_code = 'E' THEN 1 END)
      comment: "Number of exchanged coupons. Tracks ticket change volume — high exchange rates indicate schedule instability or flexible fare demand."
    - name: "irop_affected_coupons"
      expr: COUNT(CASE WHEN irop_indicator = TRUE THEN 1 END)
      comment: "Number of coupons affected by irregular operations. Quantifies disruption impact on the ticket inventory — used to estimate IROP-related rebooking and refund costs."
    - name: "codeshare_coupons"
      expr: COUNT(CASE WHEN codeshare_indicator = TRUE THEN 1 END)
      comment: "Number of codeshare coupons. Tracks codeshare traffic contribution — used to evaluate partner airline agreement performance."
    - name: "interline_coupons"
      expr: COUNT(CASE WHEN interline_indicator = TRUE THEN 1 END)
      comment: "Number of interline coupons. Tracks interline traffic volume — key input for interline proration and bilateral settlement with partner airlines."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_boarding_pass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Boarding pass issuance and boarding metrics tracking boarding completion, check-in method mix, digital adoption, security selectee rates, and lounge access. Used by airport operations, customer experience, and security compliance teams."
  source: "`airlines_ecm`.`reservation`.`boarding_pass`"
  dimensions:
    - name: "boarding_pass_status"
      expr: boarding_pass_status
      comment: "Current status of the boarding pass (e.g. ISSUED, SCANNED, CANCELLED) — primary dimension for boarding completion analysis."
    - name: "check_in_method"
      expr: check_in_method
      comment: "Method used to check in and obtain the boarding pass (e.g. WEB, MOBILE, KIOSK, COUNTER) — used for self-service adoption and cost-per-boarding analysis."
    - name: "boarding_group"
      expr: boarding_group
      comment: "Boarding group assigned to the passenger — used to analyse boarding group distribution and boarding process efficiency."
    - name: "format"
      expr: format
      comment: "Format of the boarding pass (e.g. MOBILE, PAPER, KIOSK) — tracks digital vs. paper boarding pass mix for sustainability and cost reporting."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "Marketing carrier code on the boarding pass — used for codeshare boarding pass attribution."
    - name: "fast_track_eligible_flag"
      expr: fast_track_eligible_flag
      comment: "Whether the passenger is eligible for fast track security — tracks premium service delivery and lounge/fast-track benefit utilisation."
    - name: "lounge_access_flag"
      expr: lounge_access_flag
      comment: "Whether the passenger has lounge access — used to track lounge benefit utilisation and capacity planning."
    - name: "security_selectee_flag"
      expr: security_selectee_flag
      comment: "Whether the passenger is a security selectee (SSSS) — tracks enhanced security screening volumes for compliance reporting."
    - name: "document_check_status"
      expr: document_check_status
      comment: "Status of the travel document check at boarding — used for regulatory compliance and boarding denial analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_timestamp)
      comment: "Month the boarding pass was issued — primary time dimension for boarding pass volume trend analysis."
  measures:
    - name: "total_boarding_passes_issued"
      expr: COUNT(1)
      comment: "Total number of boarding passes issued. Baseline boarding volume KPI — used for airport capacity planning and gate resource allocation."
    - name: "boarded_passengers"
      expr: COUNT(CASE WHEN boarding_scan_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of passengers who were scanned at the gate (boarded). Boarding completion rate (boarded / issued) is the primary gate operations KPI."
    - name: "mobile_boarding_passes"
      expr: COUNT(CASE WHEN format = 'MOBILE' THEN 1 END)
      comment: "Number of mobile boarding passes issued. Tracks digital boarding pass adoption — a key sustainability, cost reduction, and customer experience KPI."
    - name: "lounge_access_passengers"
      expr: COUNT(CASE WHEN lounge_access_flag = TRUE THEN 1 END)
      comment: "Number of passengers with lounge access on their boarding pass. Used for lounge capacity planning and premium benefit delivery tracking."
    - name: "fast_track_eligible_passengers"
      expr: COUNT(CASE WHEN fast_track_eligible_flag = TRUE THEN 1 END)
      comment: "Number of passengers eligible for fast track security. Used to plan fast track lane capacity and validate premium service delivery."
    - name: "security_selectee_passengers"
      expr: COUNT(CASE WHEN security_selectee_flag = TRUE THEN 1 END)
      comment: "Number of passengers flagged as security selectees (SSSS). Tracks enhanced screening volumes — a regulatory compliance and security operations KPI."
    - name: "reprinted_boarding_passes"
      expr: COUNT(CASE WHEN CAST(reprint_count AS INT) > 0 THEN 1 END)
      comment: "Number of boarding passes that were reprinted at least once. High reprint rates indicate passenger confusion, system issues, or seat change activity — an operational quality indicator."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_group_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group booking metrics tracking group contract volumes, negotiated fare revenue, deposit collection, seat fulfilment rates, and group booking lifecycle. Used by group sales, revenue management, and accounts receivable teams."
  source: "`airlines_ecm`.`reservation`.`group_booking`"
  dimensions:
    - name: "group_booking_status"
      expr: group_booking_status
      comment: "Current status of the group booking (e.g. CONFIRMED, CANCELLED, PENDING, TICKETED) — primary dimension for group booking pipeline analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of group (e.g. TOUR, CORPORATE, SPORTS, INCENTIVE) — used for group segment revenue mix analysis."
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of the group booking — used for premium vs. economy group revenue analysis."
    - name: "marketing_airline_code"
      expr: marketing_airline_code
      comment: "Marketing airline code for the group booking — used for codeshare group revenue attribution."
    - name: "fare_currency_code"
      expr: fare_currency_code
      comment: "Currency of the group fare — used for multi-currency group revenue reporting."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Whether the group deposit has been received — used to track deposit collection compliance and cash flow risk."
    - name: "departure_month"
      expr: DATE_TRUNC('month', departure_date)
      comment: "Month of group departure — primary time dimension for group booking forward demand analysis."
  measures:
    - name: "total_group_bookings"
      expr: COUNT(1)
      comment: "Total number of group bookings. Baseline group sales volume KPI used in group revenue forecasting and capacity allocation."
    - name: "confirmed_group_bookings"
      expr: COUNT(CASE WHEN group_booking_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed group bookings. Represents firm group demand — used in load factor and group revenue forecasting."
    - name: "cancelled_group_bookings"
      expr: COUNT(CASE WHEN group_booking_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled group bookings. Cancellation rate is a key group sales risk KPI — high rates may indicate pricing or market demand issues."
    - name: "total_negotiated_fare_revenue"
      expr: SUM(CAST(negotiated_fare_amount AS DOUBLE))
      comment: "Total negotiated fare revenue across group bookings. Primary group revenue KPI — used to assess group channel contribution to total passenger revenue."
    - name: "avg_negotiated_fare"
      expr: AVG(CAST(negotiated_fare_amount AS DOUBLE))
      comment: "Average negotiated fare per group booking. Benchmarks group pricing against published fares — used to evaluate group discount policy effectiveness."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected from group bookings. Tracks cash collected ahead of travel — a key accounts receivable and liquidity KPI."
    - name: "groups_without_deposit"
      expr: COUNT(CASE WHEN deposit_received_flag = FALSE THEN 1 END)
      comment: "Number of confirmed group bookings where the deposit has not been received. Represents financial exposure — used by accounts receivable to prioritise collection activity."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`reservation_ssr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special Service Request (SSR) metrics tracking SSR volumes, fulfilment rates, charge revenue, regulatory compliance, and service category mix. Used by customer experience, ground operations, and compliance teams."
  source: "`airlines_ecm`.`reservation`.`ssr`"
  dimensions:
    - name: "ssr_code"
      expr: ssr_code
      comment: "IATA SSR code (e.g. WCHR, UMNR, VGML, DEAF) — primary dimension for service type analysis and operational resource planning."
    - name: "ssr_category"
      expr: ssr_category
      comment: "Category of the SSR (e.g. MEDICAL, DIETARY, MOBILITY, MINOR) — used for service category mix and resource allocation analysis."
    - name: "ssr_status"
      expr: ssr_status
      comment: "Current status of the SSR (e.g. REQUESTED, CONFIRMED, CANCELLED, FULFILLED) — primary dimension for SSR fulfilment rate analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Operational fulfilment status of the SSR — used to track service delivery quality and identify fulfilment gaps."
    - name: "charge_applicable_flag"
      expr: charge_applicable_flag
      comment: "Whether a charge applies to the SSR — used to separate chargeable vs. complimentary special services."
    - name: "operating_airline_code"
      expr: operating_airline_code
      comment: "Operating airline responsible for fulfilling the SSR — used for interline SSR responsibility attribution."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the SSR has a regulatory compliance requirement — used to prioritise mandatory service fulfilment and avoid regulatory penalties."
    - name: "creation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the SSR was created — primary time dimension for SSR volume trend analysis."
  measures:
    - name: "total_ssrs"
      expr: COUNT(1)
      comment: "Total number of Special Service Requests. Baseline SSR volume KPI used for ground operations staffing and service resource planning."
    - name: "fulfilled_ssrs"
      expr: COUNT(CASE WHEN fulfillment_status = 'FULFILLED' THEN 1 END)
      comment: "Number of SSRs that were successfully fulfilled. SSR fulfilment rate is a key customer experience and regulatory compliance KPI."
    - name: "unfulfilled_ssrs"
      expr: COUNT(CASE WHEN fulfillment_status = 'UNFULFILLED' THEN 1 END)
      comment: "Number of SSRs that were not fulfilled. Unfulfilled SSRs — especially for mobility or medical needs — represent regulatory risk and customer experience failures."
    - name: "regulatory_compliance_ssrs"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of SSRs with a regulatory compliance requirement. Tracks mandatory service volume — non-fulfilment of these SSRs can result in regulatory fines."
    - name: "chargeable_ssrs"
      expr: COUNT(CASE WHEN charge_applicable_flag = TRUE THEN 1 END)
      comment: "Number of SSRs that carry a charge. Tracks chargeable special service volume — used for ancillary revenue forecasting."
    - name: "total_ssr_charge_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from chargeable SSRs. Tracks ancillary revenue from special services — a growing revenue stream for airlines."
    - name: "avg_ssr_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per chargeable SSR. Used to benchmark SSR pricing and identify opportunities to optimise special service fee structures."
$$;