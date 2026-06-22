-- Metric views for domain: reservation | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking KPIs covering revenue performance, booking volume, ADR, and channel/segment mix. Primary fact table for reservation analytics used by Revenue Management, Sales, and Operations leadership."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level performance slicing across the portfolio."
    - name: "booking_status"
      expr: booking_status
      comment: "Current reservation status (confirmed, cancelled, checked-in, checked-out, no-show) — essential for pipeline and conversion analysis."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Guest arrival date — used for time-series trending of occupancy and revenue by stay date."
    - name: "departure_date"
      expr: departure_date
      comment: "Guest departure date — used to compute stay windows and length-of-stay cohorts."
    - name: "booking_date"
      expr: booking_date
      comment: "Date the reservation was made — used for booking pace and lead-time analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment FK — enables revenue and volume breakdown by transient, group, corporate, wholesale, etc."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type FK (VREQ-022 FK) — enables ADR and revenue analysis by room category."
    - name: "revenue_rate_plan_id"
      expr: revenue_rate_plan_id
      comment: "Rate plan FK — enables revenue and booking volume breakdown by rate strategy."
    - name: "booking_source_id"
      expr: booking_source_id
      comment: "Booking source FK — enables channel contribution and cost-of-acquisition analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue reporting."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "VIP indicator — enables segmentation of high-value guest bookings for service prioritization."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Payment guarantee method (credit card, deposit, corporate) — used for no-show risk and revenue assurance analysis."
    - name: "corporate_account_id"
      expr: corporate_account_id
      comment: "Corporate account FK — enables corporate segment revenue and volume reporting."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation records. Baseline volume KPI used in conversion rate, cancellation rate, and booking pace calculations."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total rooms revenue across all reservations. Primary top-line revenue KPI for the reservation domain, used in RevPAR and ADR calculations."
    - name: "average_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average Daily Rate across reservations. Core pricing KPI used by Revenue Management to evaluate rate strategy effectiveness."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to booking sources and travel agents. Used to evaluate channel cost-of-acquisition and net revenue impact."
    - name: "avg_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per reservation. Benchmarks commission efficiency across channels and rate plans."
    - name: "distinct_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests with reservations. Used to measure guest acquisition, repeat-visit rates, and loyalty program penetration."
    - name: "distinct_properties_booked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with reservation activity. Used for portfolio-level booking distribution analysis."
    - name: "vip_reservation_count"
      expr: COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END)
      comment: "Number of VIP reservations. Used to track high-value guest volume and ensure service-level commitments are met."
    - name: "early_checkin_request_count"
      expr: COUNT(CASE WHEN early_checkin_requested_flag = TRUE THEN 1 END)
      comment: "Number of reservations with early check-in requests. Used by Front Office to plan room readiness and upsell early check-in fees."
    - name: "late_checkout_request_count"
      expr: COUNT(CASE WHEN late_checkout_requested_flag = TRUE THEN 1 END)
      comment: "Number of reservations with late check-out requests. Used by Housekeeping and Front Office to manage room turn scheduling."
    - name: "accessibility_required_count"
      expr: COUNT(CASE WHEN accessibility_required_flag = TRUE THEN 1 END)
      comment: "Number of reservations requiring accessible rooms. Used by Rooms Division to ensure ADA compliance and room assignment accuracy."
    - name: "group_block_reservation_count"
      expr: COUNT(CASE WHEN reservation_group_block_id IS NOT NULL THEN 1 END)
      comment: "Number of reservations tied to a group block. Used to track group pickup performance against contracted block commitments."
    - name: "loyalty_member_reservation_count"
      expr: COUNT(CASE WHEN loyalty_member_number IS NOT NULL THEN 1 END)
      comment: "Number of reservations made by loyalty program members. Used to measure loyalty program contribution to booking volume and revenue."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation analytics KPIs covering revenue loss, penalty recovery, refund exposure, and OTA chargeback risk. Used by Revenue Management and Front Office to monitor and reduce cancellation impact."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level cancellation performance comparison."
    - name: "reason_code"
      expr: reason_code
      comment: "Cancellation reason code — used to identify root causes and inform policy adjustments."
    - name: "event_type"
      expr: event_type
      comment: "Type of cancellation event (guest-initiated, no-show, OTA, etc.) — used to segment cancellation drivers."
    - name: "original_arrival_date"
      expr: original_arrival_date
      comment: "Original intended arrival date — used to analyze cancellation timing relative to stay date."
    - name: "posting_status"
      expr: posting_status
      comment: "Financial posting status of the cancellation — used to track revenue recognition and penalty collection."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether a cancellation penalty applies — used to segment recoverable vs. non-recoverable revenue loss."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether the cancellation penalty was waived — used to monitor waiver rates and revenue leakage."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the cancellation is under dispute — used to track dispute resolution workload and financial exposure."
    - name: "ota_chargeback_eligible_flag"
      expr: ota_chargeback_eligible_flag
      comment: "Whether the cancellation is eligible for OTA chargeback — used to manage OTA revenue recovery."
    - name: "booking_source_id"
      expr: booking_source_id
      comment: "Booking source FK — enables cancellation rate analysis by channel."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation records. Baseline volume KPI for cancellation rate calculations and trend monitoring."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total room revenue lost due to cancellations. Primary financial impact KPI used by Revenue Management to quantify cancellation exposure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total cancellation penalties charged. Measures revenue recovery from cancellation policy enforcement."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on cancellations. Used to monitor cash outflow from cancellation refunds and refund policy compliance."
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amounts on cancellations. Used to track OTA-related revenue recovery and dispute management."
    - name: "penalty_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_lost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of lost revenue recovered through cancellation penalties. Key policy effectiveness KPI — low rates indicate policy gaps or excessive waivers."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where the penalty was waived. Used to monitor waiver frequency and revenue leakage from discretionary waivers."
    - name: "dispute_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of cancellations under dispute. Used to track dispute workload and financial exposure from contested cancellations."
    - name: "ota_chargeback_eligible_count"
      expr: COUNT(CASE WHEN ota_chargeback_eligible_flag = TRUE THEN 1 END)
      comment: "Number of cancellations eligible for OTA chargeback. Used to ensure all eligible chargebacks are pursued for revenue recovery."
    - name: "avg_revenue_lost_per_cancellation"
      expr: AVG(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Average revenue lost per cancellation event. Used to benchmark cancellation severity and prioritize high-value recovery efforts."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation lifecycle and modification analytics. Tracks status transitions, SLA compliance, revenue impact of modifications, and operational efficiency of the reservations team."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of booking event (status change, modification, cancellation, no-show) — primary dimension for lifecycle stage analysis."
    - name: "new_status"
      expr: new_status
      comment: "Status after the event — used to track reservation pipeline flow and conversion funnel."
    - name: "previous_status"
      expr: previous_status
      comment: "Status before the event — used to analyze transition patterns and identify problematic status flows."
    - name: "modification_type"
      expr: modification_type
      comment: "Type of modification made (date change, room type change, rate change) — used to understand modification drivers."
    - name: "channel_code"
      expr: channel_code
      comment: "Distribution channel code — enables SLA and modification analysis by channel."
    - name: "event_date"
      expr: event_date
      comment: "Date of the booking event — used for time-series trending of modification and cancellation activity."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the event was handled within SLA — used to monitor reservations team service quality."
    - name: "property_code"
      expr: property_code
      comment: "Property code — enables property-level SLA and modification performance comparison."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the status change is under dispute — used to flag contested transactions for review."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of booking status change events. Baseline volume KPI for reservation modification and lifecycle activity."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from all booking status changes and modifications. Used by Revenue Management to quantify the financial effect of reservation changes."
    - name: "total_penalty_fees"
      expr: SUM(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Total penalty fees assessed across all status change events. Used to track penalty revenue and policy enforcement effectiveness."
    - name: "total_rate_difference"
      expr: SUM(CAST(rate_difference_amount AS DOUBLE))
      comment: "Total rate difference from reservation modifications. Used to measure revenue uplift or dilution from rate changes on modified bookings."
    - name: "sla_compliance_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of events handled within SLA. Used to measure reservations team responsiveness and service quality."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Number of events that breached SLA. Used to identify operational bottlenecks and staffing gaps in the reservations team."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of booking events handled within SLA. Key operational KPI for reservations team performance management."
    - name: "guest_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status change events where the guest was notified. Used to monitor guest communication compliance and service standards."
    - name: "avg_revenue_impact_per_event"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per booking status event. Used to benchmark the financial significance of reservation modifications."
    - name: "distinct_reservations_modified"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of unique reservations that experienced a status change. Used to calculate modification rate against total booking volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block pickup performance KPIs tracking utilization, revenue realization, and attrition risk against contracted group blocks. Critical for Group Sales and Revenue Management to manage group commitments."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables group pickup performance comparison across the portfolio."
    - name: "reservation_group_block_id"
      expr: reservation_group_block_id
      comment: "Group block FK — enables drill-down to individual block pickup performance."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group — used to analyze pickup performance by group type (corporate, association, leisure, etc.)."
    - name: "booking_channel_code"
      expr: booking_channel_code
      comment: "Channel through which the pickup was booked — used to analyze group booking channel mix."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date — used for time-series analysis of group pickup pace."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date — used to analyze pickup behavior relative to the release deadline."
    - name: "pickup_status"
      expr: pickup_status
      comment: "Current pickup status — used to segment active, cancelled, and converted group pickups."
    - name: "pickup_before_cutoff_flag"
      expr: pickup_before_cutoff_flag
      comment: "Whether the pickup occurred before the block cutoff — used to measure group booking pace compliance."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the group pickup resulted in a no-show — used to track group no-show rates and attrition."
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "VIP flag on the group pickup — used to prioritize high-value group attendees for service delivery."
  measures:
    - name: "total_pickup_records"
      expr: COUNT(1)
      comment: "Total number of group block pickup records. Baseline volume KPI for group pickup activity."
    - name: "total_group_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue realized from group block pickups. Primary revenue KPI for group segment performance."
    - name: "avg_block_utilization_pct"
      expr: AVG(CAST(block_utilization_percentage AS DOUBLE))
      comment: "Average block utilization percentage across group pickups. Key KPI for measuring how effectively contracted group blocks are being consumed."
    - name: "avg_group_rate"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average room rate achieved on group block pickups. Used to evaluate group rate competitiveness and negotiation outcomes."
    - name: "total_group_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total revenue from group block pickups. Used by Group Sales to measure group segment contribution to total property revenue."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of group pickup no-shows. Used to track group no-show rates and inform attrition clause enforcement."
    - name: "pre_cutoff_pickup_count"
      expr: COUNT(CASE WHEN pickup_before_cutoff_flag = TRUE THEN 1 END)
      comment: "Number of group pickups made before the block cutoff date. Used to measure group booking pace and predict final utilization."
    - name: "pre_cutoff_pickup_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pickup_before_cutoff_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group pickups made before the cutoff date. Used to assess group booking pace health and attrition risk."
    - name: "distinct_group_blocks"
      expr: COUNT(DISTINCT reservation_group_block_id)
      comment: "Number of distinct group blocks with pickup activity. Used to measure group block portfolio size and activity level."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit management KPIs covering deposit collection, forfeiture, refund exposure, and revenue recognition timing. Used by Finance and Front Office to manage deposit liability and cash flow."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level deposit performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency deposit liability reporting."
    - name: "booking_source"
      expr: booking_source
      comment: "Booking source of the reservation — used to analyze deposit collection rates by channel."
    - name: "deposit_due_date"
      expr: deposit_due_date
      comment: "Date the deposit is due — used for cash flow forecasting and overdue deposit tracking."
    - name: "payment_received_date"
      expr: payment_received_date
      comment: "Date the deposit payment was received — used to measure deposit collection timeliness."
    - name: "forfeiture_date"
      expr: forfeiture_date
      comment: "Date the deposit was forfeited — used to track forfeiture events and revenue recognition timing."
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Date the deposit revenue is recognized — used for financial reporting and period-close accuracy."
  measures:
    - name: "total_deposits_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected. Primary cash flow KPI for deposit management — used by Finance to track advance payment liability."
    - name: "total_forfeiture_amount"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE))
      comment: "Total deposit amounts forfeited. Used to measure revenue from forfeited deposits and evaluate cancellation policy effectiveness."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit refunds issued. Used to monitor cash outflow from deposit refunds and manage refund liability."
    - name: "net_deposit_retained"
      expr: SUM((CAST(deposit_amount AS DOUBLE)) - (CAST(refund_amount AS DOUBLE)))
      comment: "Net deposit amount retained after refunds. Used by Finance to calculate actual deposit revenue contribution net of refund obligations."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per reservation. Used to benchmark deposit policy adequacy relative to average booking value."
    - name: "deposit_record_count"
      expr: COUNT(1)
      comment: "Total number of deposit ledger records. Baseline volume KPI for deposit activity monitoring."
    - name: "distinct_reservations_with_deposits"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of unique reservations with deposit records. Used to calculate deposit collection rate against total bookings."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_walk_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Walk (relocation) analytics KPIs covering compensation costs, revenue loss, guest satisfaction impact, and OTA penalty exposure. Used by Operations and Revenue Management to minimize walk incidents and manage their financial impact."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`walk_record`"
  dimensions:
    - name: "primary_walk_property_id"
      expr: primary_walk_property_id
      comment: "Property that walked the guest — enables property-level walk rate and cost analysis."
    - name: "walk_date"
      expr: walk_date
      comment: "Date of the walk event — used for time-series trending of walk frequency."
    - name: "walk_reason_code"
      expr: walk_reason_code
      comment: "Reason code for the walk (overbooking, maintenance, etc.) — used to identify root causes and drive preventive action."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation provided to walked guest — used to analyze compensation strategy and cost."
    - name: "transportation_provided_flag"
      expr: transportation_provided_flag
      comment: "Whether transportation was provided — used to track transportation cost exposure from walk incidents."
    - name: "ota_penalty_applicable_flag"
      expr: ota_penalty_applicable_flag
      comment: "Whether an OTA penalty applies — used to track OTA contractual penalty exposure from walk events."
    - name: "brand_standard_compliance_flag"
      expr: brand_standard_compliance_flag
      comment: "Whether the walk was handled per brand standards — used to monitor brand compliance in walk management."
    - name: "complaint_filed_flag"
      expr: complaint_filed_flag
      comment: "Whether the guest filed a complaint — used to track complaint rates from walk incidents and service recovery needs."
  measures:
    - name: "total_walk_incidents"
      expr: COUNT(1)
      comment: "Total number of walk incidents. Baseline KPI for walk frequency monitoring — high walk rates signal overbooking policy issues."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total room revenue lost due to walk incidents. Primary financial impact KPI for walk management."
    - name: "total_cash_compensation"
      expr: SUM(CAST(cash_compensation_amount AS DOUBLE))
      comment: "Total cash compensation paid to walked guests. Used to quantify direct cash cost of walk incidents."
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost_amount AS DOUBLE))
      comment: "Total transportation costs incurred for walked guests. Used to measure ancillary walk costs beyond room compensation."
    - name: "total_compensation_value"
      expr: SUM(CAST(total_compensation_value_amount AS DOUBLE))
      comment: "Total all-in compensation value provided to walked guests (cash + transportation + loyalty points). Used for full cost-of-walk analysis."
    - name: "total_ota_penalty_amount"
      expr: SUM(CAST(ota_penalty_amount AS DOUBLE))
      comment: "Total OTA penalties incurred from walk incidents. Used to quantify contractual penalty exposure from OTA walk events."
    - name: "avg_compensation_per_walk"
      expr: AVG(CAST(total_compensation_value_amount AS DOUBLE))
      comment: "Average total compensation value per walk incident. Used to benchmark walk cost and evaluate compensation policy adequacy."
    - name: "complaint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN complaint_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of walk incidents that resulted in a guest complaint. Used to measure service recovery effectiveness and guest satisfaction impact of walks."
    - name: "brand_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_standard_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of walk incidents handled in compliance with brand standards. Used to monitor brand standard adherence in walk management."
    - name: "ota_penalty_exposure_count"
      expr: COUNT(CASE WHEN ota_penalty_applicable_flag = TRUE THEN 1 END)
      comment: "Number of walk incidents with OTA penalty exposure. Used to prioritize OTA relationship management and overbooking policy adjustments."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment KPIs covering fulfillment rates, cost management, VIP request handling, and guest satisfaction. Used by Operations and Guest Services to ensure special request delivery excellence."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level special request fulfillment performance comparison."
    - name: "request_category"
      expr: request_category
      comment: "Category of special request (room preference, amenity, dietary, accessibility) — used to analyze request type distribution and fulfillment rates."
    - name: "request_type"
      expr: request_type
      comment: "Specific request type — enables granular fulfillment analysis by request classification."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status (fulfilled, pending, failed) — primary dimension for fulfillment rate analysis."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for fulfillment — used to measure departmental fulfillment performance."
    - name: "priority_level"
      expr: priority_level
      comment: "Request priority level — used to ensure high-priority requests receive appropriate attention."
    - name: "is_vip_request"
      expr: is_vip_request
      comment: "Whether the request is from a VIP guest — used to track VIP fulfillment rates separately."
    - name: "is_pre_arrival"
      expr: is_pre_arrival
      comment: "Whether the request was made pre-arrival — used to analyze pre-arrival vs. in-stay request patterns."
    - name: "requires_charge"
      expr: requires_charge
      comment: "Whether the request incurs a charge — used to track chargeable request revenue and fulfillment."
    - name: "target_fulfillment_date"
      expr: target_fulfillment_date
      comment: "Target date for fulfillment — used for SLA monitoring and on-time delivery analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests. Baseline volume KPI for special request workload management."
    - name: "fulfilled_request_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 END)
      comment: "Number of successfully fulfilled special requests. Used to measure fulfillment team effectiveness."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Key guest satisfaction KPI — low rates directly correlate with negative reviews and loyalty impact."
    - name: "vip_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip_request = TRUE AND fulfillment_status = 'fulfilled' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END), 0), 2)
      comment: "Fulfillment rate specifically for VIP guest requests. Used to ensure premium service delivery for high-value guests."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of fulfilling special requests. Used to manage operational cost of special request delivery."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges billed to guests for special requests. Used to measure ancillary revenue from chargeable special requests."
    - name: "cost_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of special request costs recovered through guest charges. Used to evaluate pricing adequacy for chargeable services."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per special request. Used to benchmark fulfillment cost efficiency and budget planning."
    - name: "failed_request_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'failed' THEN 1 END)
      comment: "Number of special requests that failed to be fulfilled. Used to identify operational gaps and drive service recovery actions."
    - name: "distinct_reservations_with_requests"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of unique reservations with special requests. Used to calculate special request attachment rate against total bookings."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment quality and efficiency KPIs covering upgrade rates, preference match scores, reassignment frequency, and accessibility compliance. Used by Front Office and Rooms Division to optimize room assignment operations."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`room_assignment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level room assignment performance comparison."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used for room assignment (manual, automated, guest-requested) — used to evaluate assignment method effectiveness."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status — used to track active, pending, and completed assignments."
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date of room assignment — used for time-series analysis of assignment activity."
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Whether the assignment is an upgrade — used to track upgrade rate and revenue impact."
    - name: "upgrade_category"
      expr: upgrade_category
      comment: "Category of upgrade provided — used to analyze upgrade type distribution and value."
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Whether an accessible room was assigned — used to monitor ADA compliance in room assignments."
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Whether the assignment was guest-requested — used to measure guest preference fulfillment rates."
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Whether early check-in was provided — used to track early check-in fulfillment rates."
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Whether late check-out was provided — used to track late check-out fulfillment rates."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of room assignment records. Baseline volume KPI for room assignment activity."
    - name: "upgrade_count"
      expr: COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END)
      comment: "Number of room upgrades provided. Used to track upgrade volume and evaluate upsell and loyalty benefit delivery."
    - name: "upgrade_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room assignments that are upgrades. Key metric for loyalty benefit delivery and upsell program effectiveness."
    - name: "avg_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score for room assignments. Used to measure how well room assignments align with guest preferences — directly linked to guest satisfaction."
    - name: "guest_requested_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that fulfilled a guest room request. Used to measure guest preference accommodation rate."
    - name: "accessible_room_assignment_count"
      expr: COUNT(CASE WHEN is_accessible_room = TRUE THEN 1 END)
      comment: "Number of accessible room assignments. Used to monitor ADA compliance and ensure accessibility needs are met."
    - name: "early_checkin_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_checkin_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with early check-in fulfilled. Used to measure early check-in service delivery and upsell conversion."
    - name: "late_checkout_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_checkout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with late check-out fulfilled. Used to measure late check-out service delivery and upsell conversion."
    - name: "distinct_rooms_assigned"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of distinct rooms assigned. Used to measure room utilization breadth and identify rooms with low assignment frequency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel agent performance and portfolio KPIs covering revenue contribution, commission rates, booking volume, and agency relationship health. Used by Sales and Distribution to manage the travel agent channel."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`travel_agent`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of travel agency (OTA, traditional, corporate, wholesale) — used to analyze performance by agency category."
    - name: "booking_volume_tier"
      expr: booking_volume_tier
      comment: "Booking volume tier of the agency — used to segment high-value vs. low-value agency relationships."
    - name: "travel_agent_status"
      expr: travel_agent_status
      comment: "Current status of the travel agent relationship (active, inactive, suspended) — used to manage active agency portfolio."
    - name: "country_code"
      expr: country_code
      comment: "Country of the travel agency — used for geographic distribution analysis of the agency portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for commission and revenue reporting — required for multi-currency agency performance analysis."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Agency contract start date — used to analyze agency tenure and contract renewal timing."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Agency contract end date — used to identify contracts approaching expiration for renewal management."
    - name: "last_booking_date"
      expr: last_booking_date
      comment: "Date of the agency's most recent booking — used to identify inactive agencies and prioritize re-engagement."
  measures:
    - name: "total_agencies"
      expr: COUNT(1)
      comment: "Total number of travel agent records. Baseline portfolio size KPI for distribution channel management."
    - name: "active_agency_count"
      expr: COUNT(CASE WHEN travel_agent_status = 'active' THEN 1 END)
      comment: "Number of active travel agencies. Used to track active distribution partner count and channel health."
    - name: "total_revenue_generated"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated by travel agents. Primary revenue contribution KPI for the travel agent channel."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across travel agents. Used to benchmark commission cost and evaluate rate negotiation outcomes."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit extended to travel agents. Used to manage credit risk exposure across the agency portfolio."
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all travel agents. Used by Finance to monitor aggregate credit risk from the travel agent channel."
    - name: "avg_revenue_per_agency"
      expr: AVG(CAST(total_revenue_generated AS DOUBLE))
      comment: "Average revenue generated per travel agency. Used to benchmark agency productivity and identify high-performing vs. underperforming agencies."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_waitlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist conversion and demand analytics KPIs covering conversion rates, quoted rate levels, and demand overflow patterns. Used by Revenue Management and Front Office to capture demand that exceeds current availability."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`waitlist`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level waitlist demand analysis."
    - name: "waitlist_status"
      expr: waitlist_status
      comment: "Current waitlist status (active, converted, expired, cancelled) — primary dimension for conversion funnel analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the waitlisted guest — used to analyze demand overflow by segment."
    - name: "requested_arrival_date"
      expr: requested_arrival_date
      comment: "Requested arrival date — used to identify high-demand dates and inform inventory release decisions."
    - name: "requested_departure_date"
      expr: requested_departure_date
      comment: "Requested departure date — used to analyze waitlist demand by stay window."
    - name: "guest_priority_tier"
      expr: guest_priority_tier
      comment: "Priority tier of the waitlisted guest — used to ensure high-value guests are prioritized for conversion."
    - name: "auto_convert_flag"
      expr: auto_convert_flag
      comment: "Whether the waitlist entry is set for automatic conversion — used to track automation adoption in waitlist management."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Waitlist expiration date — used to manage waitlist hygiene and identify entries approaching expiration."
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of waitlist entries. Baseline demand overflow KPI — high volumes signal revenue opportunity from inventory optimization."
    - name: "converted_waitlist_count"
      expr: COUNT(CASE WHEN waitlist_status = 'converted' THEN 1 END)
      comment: "Number of waitlist entries successfully converted to reservations. Used to measure waitlist conversion effectiveness."
    - name: "waitlist_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waitlist_status = 'converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries converted to confirmed reservations. Key Revenue Management KPI — measures ability to capture overflow demand."
    - name: "avg_quoted_rate"
      expr: AVG(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Average rate quoted to waitlisted guests. Used to assess demand price sensitivity and inform dynamic pricing decisions."
    - name: "total_quoted_revenue_potential"
      expr: SUM(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Total potential revenue from all waitlisted bookings at quoted rates. Used to quantify the revenue opportunity in the waitlist pipeline."
    - name: "expired_waitlist_count"
      expr: COUNT(CASE WHEN waitlist_status = 'expired' THEN 1 END)
      comment: "Number of waitlist entries that expired without conversion. Used to measure lost demand opportunity and optimize waitlist management processes."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package booking performance KPIs covering package revenue, component mix, refundability, and commission eligibility. Used by Revenue Management and Sales to evaluate package strategy and profitability."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_package`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level package performance comparison."
    - name: "package_category"
      expr: package_category
      comment: "Category of the package (romance, spa, family, business) — used to analyze performance by package type."
    - name: "package_status"
      expr: package_status
      comment: "Current package status (active, cancelled, redeemed) — used to track package lifecycle and redemption rates."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment associated with the package — used to analyze package uptake by guest segment."
    - name: "is_inclusive"
      expr: is_inclusive
      comment: "Whether the package is all-inclusive — used to segment inclusive vs. add-on package performance."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Whether the package is refundable — used to analyze refundable vs. non-refundable package mix and revenue risk."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether the package is commission-eligible — used to track commissionable package volume and cost."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Whether the package rate is tax-inclusive — used for accurate revenue and tax reporting."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Package redemption status — used to track redemption rates and unredeemed package liability."
    - name: "start_date"
      expr: start_date
      comment: "Package start date — used for time-series analysis of package booking and redemption patterns."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of booking package records. Baseline volume KPI for package program activity."
    - name: "total_package_rate_revenue"
      expr: SUM(CAST(package_rate_amount AS DOUBLE))
      comment: "Total revenue from package rates. Primary revenue KPI for the package program — used to measure package contribution to total revenue."
    - name: "total_rooms_revenue_from_packages"
      expr: SUM(CAST(rooms_revenue_amount AS DOUBLE))
      comment: "Total rooms revenue component from packages. Used to analyze rooms revenue contribution within package bundles."
    - name: "total_fb_revenue_from_packages"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue component from packages. Used to measure F&B revenue driven by package inclusions."
    - name: "total_other_revenue_from_packages"
      expr: SUM(CAST(other_revenue_amount AS DOUBLE))
      comment: "Total other revenue component from packages (spa, activities, etc.). Used to measure ancillary revenue driven by package inclusions."
    - name: "total_package_cost"
      expr: SUM(CAST(package_cost_amount AS DOUBLE))
      comment: "Total cost of delivering packages. Used to calculate package margin and evaluate package profitability."
    - name: "package_margin"
      expr: SUM((CAST(package_rate_amount AS DOUBLE)) - (CAST(package_cost_amount AS DOUBLE)))
      comment: "Total package margin (revenue minus cost). Used by Revenue Management to evaluate package profitability and pricing adequacy."
    - name: "avg_package_rate"
      expr: AVG(CAST(package_rate_amount AS DOUBLE))
      comment: "Average package rate per booking. Used to benchmark package pricing and evaluate rate strategy effectiveness."
    - name: "revenue_allocation_total"
      expr: SUM(CAST(revenue_allocation_method AS DOUBLE))
      comment: "Total revenue allocation amount across packages. Used for revenue recognition and component-level financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block portfolio KPIs covering contracted room volume, pickup performance, revenue forecast, and attrition risk. Used by Group Sales and Revenue Management to manage the group block pipeline."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level group block portfolio analysis."
    - name: "block_status"
      expr: block_status
      comment: "Current group block status (tentative, definite, cancelled, consumed) — primary dimension for pipeline stage analysis."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (corporate, association, leisure, sports) — used to analyze group mix and performance by type."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date — used for time-series analysis of group block pipeline by arrival period."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date — used to identify blocks approaching release and manage inventory decisions."
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Whether an attrition clause is in the contract — used to track attrition risk and revenue protection."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Whether a deposit is required — used to monitor deposit collection compliance for group blocks."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Availability flag — used to identify blocks with LRA commitments that constrain inventory management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for group block financial reporting — required for multi-currency group revenue analysis."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group block records. Baseline portfolio size KPI for group sales pipeline management."
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks. Primary pipeline value KPI used by Revenue Management for group revenue forecasting."
    - name: "total_group_rate_revenue"
      expr: SUM(CAST(group_rate_amount AS DOUBLE))
      comment: "Total group room rate revenue across all blocks. Used to measure group rate contribution to total revenue."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group room rate. Used to benchmark group rate levels against transient rates and evaluate group pricing strategy."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts on group blocks. Used by Finance to track group deposit liability and cash flow."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group blocks. Used to assess portfolio-level attrition risk exposure."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage on group blocks. Used to evaluate group channel cost and net revenue impact."
    - name: "distinct_corporate_accounts"
      expr: COUNT(DISTINCT corporate_account_id)
      comment: "Number of distinct corporate accounts with group blocks. Used to measure corporate group segment breadth and account penetration."
    - name: "attrition_risk_block_count"
      expr: COUNT(CASE WHEN attrition_clause_flag = TRUE THEN 1 END)
      comment: "Number of group blocks with attrition clauses. Used to quantify the portfolio at risk for attrition penalties and revenue shortfall."
$$;