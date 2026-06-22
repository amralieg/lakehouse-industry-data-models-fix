-- Metric views for domain: reservation | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking KPIs covering revenue performance, booking velocity, ADR, length-of-stay economics, and cancellation exposure. Primary steering dashboard for Revenue Management and Front Office leadership."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the reservation (e.g. CONFIRMED, CANCELLED, NO_SHOW, CHECKED_OUT). Enables status-based segmentation of all KPIs."
    - name: "booking_date"
      expr: DATE_TRUNC('DAY', booking_date)
      comment: "Calendar day the reservation was created. Used for booking-pace and lead-time trend analysis."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Calendar month the reservation was created. Supports monthly booking-volume and revenue trend reporting."
    - name: "arrival_date"
      expr: DATE_TRUNC('DAY', arrival_date)
      comment: "Guest arrival date. Used to align revenue and occupancy KPIs to the stay period."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Arrival month bucket for seasonal demand and revenue forecasting."
    - name: "departure_date"
      expr: DATE_TRUNC('DAY', departure_date)
      comment: "Guest departure date. Combined with arrival_date to derive stay-window analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the booking. Required for multi-currency revenue reporting and FX normalisation."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Payment guarantee type (e.g. CREDIT_CARD, DEPOSIT, CORPORATE). Informs risk and no-show exposure segmentation."
    - name: "package_code"
      expr: package_code
      comment: "Package or rate bundle code attached to the booking. Enables package-revenue contribution analysis."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Indicates whether the guest holds VIP status. Used to segment high-value guest KPIs."
    - name: "accessibility_required_flag"
      expr: accessibility_required_flag
      comment: "Flags bookings requiring accessible accommodation. Supports compliance and inventory planning."
    - name: "early_checkin_requested_flag"
      expr: early_checkin_requested_flag
      comment: "Indicates an early check-in request. Used to measure ancillary demand and operational load."
    - name: "late_checkout_requested_flag"
      expr: late_checkout_requested_flag
      comment: "Indicates a late check-out request. Used to measure ancillary demand and housekeeping scheduling impact."
    - name: "pms_reservation_code"
      expr: pms_reservation_code
      comment: "Property Management System reservation code. Enables cross-system reconciliation and audit."
  measures:
    - name: "total_confirmed_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CONFIRMED' THEN reservation_booking_id END)
      comment: "Count of reservations currently in CONFIRMED status. Core volume KPI for demand forecasting and capacity planning."
    - name: "total_cancelled_bookings"
      expr: COUNT(CASE WHEN booking_status = 'CANCELLED' THEN reservation_booking_id END)
      comment: "Count of cancelled reservations. Drives cancellation-rate calculation and revenue-at-risk assessment."
    - name: "total_no_show_bookings"
      expr: COUNT(CASE WHEN booking_status = 'NO_SHOW' THEN reservation_booking_id END)
      comment: "Count of no-show reservations. Critical for overbooking strategy and penalty-revenue tracking."
    - name: "total_bookings"
      expr: COUNT(reservation_booking_id)
      comment: "Total reservation count across all statuses. Baseline denominator for rate and ratio KPIs."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Sum of total room revenue across all bookings. Primary top-line revenue KPI for Revenue Management."
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average Daily Rate (ADR) across bookings. Fundamental hotel revenue KPI used in RevPAR and yield management."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to booking channels and travel agents. Directly impacts net revenue and distribution cost management."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'CANCELLED' THEN reservation_booking_id END) / NULLIF(COUNT(reservation_booking_id), 0), 2)
      comment: "Percentage of all bookings that were cancelled. Key risk and demand-quality KPI; high rates trigger overbooking or policy review."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'NO_SHOW' THEN reservation_booking_id END) / NULLIF(COUNT(reservation_booking_id), 0), 2)
      comment: "Percentage of bookings resulting in a no-show. Informs overbooking levels and guarantee-policy effectiveness."
    - name: "vip_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_status_flag = TRUE THEN reservation_booking_id END) / NULLIF(COUNT(reservation_booking_id), 0), 2)
      comment: "Percentage of bookings flagged as VIP. Tracks high-value guest mix and informs loyalty and service investment decisions."
    - name: "avg_revenue_per_booking"
      expr: AVG(CAST(total_room_revenue AS DOUBLE))
      comment: "Average room revenue per booking record. Proxy for booking quality and yield; used alongside ADR for revenue mix analysis."
    - name: "total_points_earned"
      expr: SUM(CAST(points_earned AS DOUBLE))
      comment: "Total loyalty points earned across bookings. Measures loyalty programme engagement and liability accrual."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation analytics covering penalty revenue, refund exposure, OTA chargeback risk, waiver rates, and revenue loss. Used by Revenue Management, Finance, and Guest Experience teams to manage cancellation policy effectiveness."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of cancellation event (e.g. GUEST_CANCEL, NO_SHOW, FORCE_CANCEL). Enables event-type segmentation of cancellation KPIs."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised cancellation reason code. Drives root-cause analysis of cancellation patterns."
    - name: "posting_status"
      expr: posting_status
      comment: "Financial posting status of the cancellation (e.g. POSTED, PENDING, REVERSED). Required for revenue recognition accuracy."
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which the cancellation was processed. Identifies channel-specific cancellation behaviour."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the cancellation is under dispute. Segments disputed vs. clean cancellations for risk reporting."
    - name: "dispute_resolution_status"
      expr: dispute_resolution_status
      comment: "Current resolution status of a disputed cancellation. Tracks dispute pipeline and financial exposure."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Indicates whether a cancellation penalty applies. Segments penalty-eligible cancellations for revenue recovery analysis."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the guest is eligible for a refund. Drives refund liability forecasting."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether a penalty waiver was granted. Tracks waiver frequency and its revenue impact."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the cancellation was reversed (re-instated). Measures booking reinstatement rate."
    - name: "ota_chargeback_eligible_flag"
      expr: ota_chargeback_eligible_flag
      comment: "Indicates OTA chargeback eligibility. Critical for OTA contract compliance and chargeback revenue recovery."
    - name: "original_arrival_date"
      expr: DATE_TRUNC('MONTH', original_arrival_date)
      comment: "Month of the originally planned arrival. Aligns cancellation revenue loss to the intended stay period."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the cancellation record was created. Supports trend analysis of cancellation volumes over time."
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency of the penalty charge. Required for multi-currency penalty revenue reporting."
  measures:
    - name: "total_cancellations"
      expr: COUNT(cancellation_id)
      comment: "Total number of cancellation events. Baseline volume KPI for cancellation trend and policy impact analysis."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty fees charged on cancellations. Measures revenue recovered through cancellation policy enforcement."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on cancellations. Tracks cash outflow from cancellation refunds; key liability metric for Finance."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total room revenue lost due to cancellations. Primary financial impact KPI for Revenue Management and forecasting."
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amounts on cancellations. Tracks OTA-channel financial exposure and contract compliance."
    - name: "penalty_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_lost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of lost revenue recovered via cancellation penalties. Measures cancellation policy effectiveness in protecting revenue."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN cancellation_id END) / NULLIF(COUNT(cancellation_id), 0), 2)
      comment: "Percentage of cancellations where a penalty waiver was granted. High waiver rates signal policy enforcement gaps or guest-service trade-offs."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN cancellation_id END) / NULLIF(COUNT(cancellation_id), 0), 2)
      comment: "Percentage of cancellations that are disputed. Elevated dispute rates indicate policy clarity issues or guest dissatisfaction."
    - name: "avg_penalty_per_cancellation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per cancellation event. Benchmarks penalty yield and informs policy tier calibration."
    - name: "net_cancellation_revenue_impact"
      expr: SUM(CAST(penalty_amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net financial impact of cancellations (penalties collected minus refunds issued). Summarises the true P&L effect of cancellation activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit lifecycle KPIs covering deposit collection, forfeiture, refund activity, and revenue recognition timing. Used by Finance and Revenue Management to manage cash flow, forfeiture revenue, and deposit compliance."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "booking_source"
      expr: booking_source
      comment: "Source channel of the booking associated with the deposit. Enables channel-level deposit performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deposit transaction. Required for multi-currency deposit reporting."
    - name: "forfeiture_reason"
      expr: forfeiture_reason
      comment: "Reason the deposit was forfeited. Drives root-cause analysis of forfeiture events."
    - name: "deposit_due_date_month"
      expr: DATE_TRUNC('MONTH', deposit_due_date)
      comment: "Month the deposit was due. Supports cash-flow forecasting and collection compliance tracking."
    - name: "payment_received_date_month"
      expr: DATE_TRUNC('MONTH', payment_received_date)
      comment: "Month the deposit payment was actually received. Used to measure collection timeliness vs. due date."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month deposit revenue was recognised. Aligns deposit cash to accounting periods for Finance reporting."
    - name: "forfeiture_date_month"
      expr: DATE_TRUNC('MONTH', forfeiture_date)
      comment: "Month the deposit was forfeited. Tracks forfeiture revenue timing for Finance."
  measures:
    - name: "total_deposit_amount_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected. Primary cash-inflow KPI for deposit programme performance and working-capital management."
    - name: "total_forfeiture_amount"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE))
      comment: "Total deposit amounts forfeited (retained as revenue). Measures revenue captured from non-refundable deposit forfeitures."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit refunds issued. Tracks cash outflow from deposit refunds; key liability metric for Finance."
    - name: "net_deposit_revenue"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net deposit revenue retained (forfeitures minus refunds). Summarises the true P&L contribution of the deposit programme."
    - name: "forfeiture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN forfeiture_amount > 0 THEN deposit_ledger_id END) / NULLIF(COUNT(deposit_ledger_id), 0), 2)
      comment: "Percentage of deposit records with a forfeiture amount. Measures how frequently deposits are forfeited; informs policy and guest communication strategy."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per ledger record. Benchmarks deposit sizing relative to booking value and policy tiers."
    - name: "total_deposit_records"
      expr: COUNT(deposit_ledger_id)
      comment: "Total number of deposit ledger entries. Baseline volume metric for deposit programme scale and audit completeness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance KPIs covering pickup rate, attrition risk, revenue forecast, and block utilisation. Used by Group Sales and Revenue Management to manage group business and attrition exposure."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g. TENTATIVE, DEFINITE, CANCELLED). Primary segmentation dimension for group pipeline reporting."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (e.g. CORPORATE, WEDDING, CONFERENCE). Enables segment-level group performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the group block contract. Required for multi-currency group revenue reporting."
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Indicates whether an attrition clause is in the group contract. Segments blocks with financial attrition exposure."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for the group block. Tracks deposit compliance and cash-flow planning."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag. Identifies blocks with LRA rate obligations, which affect yield management decisions."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of group arrival. Aligns group block KPIs to the stay period for demand and revenue forecasting."
    - name: "cutoff_date_month"
      expr: DATE_TRUNC('MONTH', cutoff_date)
      comment: "Month of the block cutoff date. Used to track blocks approaching release and manage inventory reallocation timing."
    - name: "contract_signed_date_month"
      expr: DATE_TRUNC('MONTH', contract_signed_date)
      comment: "Month the group contract was signed. Supports group sales pipeline and booking-pace analysis."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(reservation_group_block_id)
      comment: "Total number of group blocks. Baseline volume KPI for group sales pipeline and capacity planning."
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks. Primary group revenue pipeline KPI used in financial forecasting and sales target tracking."
    - name: "total_group_rate_revenue"
      expr: SUM(CAST(group_rate_amount AS DOUBLE))
      comment: "Sum of contracted group room rates across all blocks. Measures the rate-level revenue commitment from group business."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts required across group blocks. Tracks cash-flow obligations and deposit collection compliance."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group contracts. Benchmarks contractual attrition exposure and informs negotiation strategy."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across group blocks. Tracks distribution cost of group business and informs channel profitability."
    - name: "attrition_risk_block_count"
      expr: COUNT(CASE WHEN attrition_clause_flag = TRUE THEN reservation_group_block_id END)
      comment: "Number of group blocks with an active attrition clause. Quantifies the volume of blocks carrying financial attrition risk."
    - name: "cancelled_block_count"
      expr: COUNT(CASE WHEN block_status = 'CANCELLED' THEN reservation_group_block_id END)
      comment: "Number of cancelled group blocks. Tracks group cancellation volume and its impact on revenue pipeline."
    - name: "group_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'CANCELLED' THEN reservation_group_block_id END) / NULLIF(COUNT(reservation_group_block_id), 0), 2)
      comment: "Percentage of group blocks that were cancelled. Key risk KPI for group sales; high rates trigger contract or deposit policy review."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment quality and upgrade KPIs covering upgrade rates, reassignment frequency, guest preference match, and accessibility compliance. Used by Front Office and Guest Experience leadership to optimise room assignment operations."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`room_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the room assignment (e.g. ASSIGNED, CHECKED_IN, VACATED). Primary segmentation for assignment lifecycle analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the room (e.g. AUTO, MANUAL, GUEST_REQUEST). Enables analysis of assignment automation effectiveness."
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Indicates whether the assignment was an upgrade. Segments upgrade activity for revenue and guest satisfaction analysis."
    - name: "upgrade_category"
      expr: upgrade_category
      comment: "Category of the room upgrade (e.g. COMPLIMENTARY, PAID, LOYALTY). Enables upgrade revenue and loyalty benefit tracking."
    - name: "upgrade_reason_code"
      expr: upgrade_reason_code
      comment: "Reason code for the upgrade. Supports root-cause analysis of upgrade drivers (e.g. VIP, OVERBOOKING, LOYALTY)."
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Indicates whether the assigned room is accessible. Tracks accessibility compliance and inventory utilisation."
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Indicates whether the room was specifically requested by the guest. Measures guest preference fulfilment rate."
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Indicates an early check-in was performed. Tracks early check-in volume for ancillary revenue and housekeeping planning."
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Indicates a late check-out was performed. Tracks late check-out volume for ancillary revenue and housekeeping scheduling."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of room assignment. Supports trend analysis of assignment volumes and upgrade rates over time."
    - name: "view_type"
      expr: view_type
      comment: "View type of the assigned room (e.g. OCEAN, CITY, GARDEN). Enables preference-match and upsell analysis by view category."
    - name: "bed_configuration"
      expr: bed_configuration
      comment: "Bed configuration of the assigned room (e.g. KING, DOUBLE, TWIN). Supports preference fulfilment and inventory mix analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(room_assignment_id)
      comment: "Total number of room assignments. Baseline volume KPI for Front Office operational throughput."
    - name: "upgrade_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_upgrade = TRUE THEN room_assignment_id END) / NULLIF(COUNT(room_assignment_id), 0), 2)
      comment: "Percentage of room assignments that were upgrades. Key guest experience and revenue KPI; tracks upgrade programme effectiveness."
    - name: "guest_requested_fulfilment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_requested = TRUE THEN room_assignment_id END) / NULLIF(COUNT(room_assignment_id), 0), 2)
      comment: "Percentage of assignments fulfilling a specific guest room request. Measures guest preference satisfaction and service quality."
    - name: "avg_guest_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score across all assignments. Composite quality score for room assignment personalisation; directly linked to guest satisfaction outcomes."
    - name: "reassignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reassignment_count > 0 THEN room_assignment_id END) / NULLIF(COUNT(room_assignment_id), 0), 2)
      comment: "Percentage of assignments that required at least one reassignment. High rates indicate inventory or operational issues impacting guest experience."
    - name: "early_checkin_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_checkin_flag = TRUE THEN room_assignment_id END) / NULLIF(COUNT(room_assignment_id), 0), 2)
      comment: "Percentage of assignments with an early check-in. Measures early check-in demand for ancillary revenue and housekeeping resource planning."
    - name: "late_checkout_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_checkout_flag = TRUE THEN room_assignment_id END) / NULLIF(COUNT(room_assignment_id), 0), 2)
      comment: "Percentage of assignments with a late check-out. Measures late check-out demand for ancillary revenue and housekeeping scheduling impact."
    - name: "accessible_room_assignment_count"
      expr: COUNT(CASE WHEN is_accessible_room = TRUE THEN room_assignment_id END)
      comment: "Number of assignments to accessible rooms. Tracks accessibility inventory utilisation and ADA/regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfilment KPIs covering fulfilment rates, cost accuracy, VIP request handling, and guest satisfaction. Used by Guest Experience, Operations, and Loyalty teams to measure service delivery quality."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`special_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of special request (e.g. AMENITY, TRANSPORT, DIETARY). Enables category-level fulfilment and cost analysis."
    - name: "request_category"
      expr: request_category
      comment: "Broader category grouping of the request. Supports department-level workload and fulfilment reporting."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfilment status of the request (e.g. FULFILLED, PENDING, FAILED). Primary KPI segmentation dimension."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for fulfilling the request. Enables department-level performance and workload analysis."
    - name: "is_vip_request"
      expr: is_vip_request
      comment: "Indicates whether the request is for a VIP guest. Segments VIP service delivery for high-value guest experience management."
    - name: "is_pre_arrival"
      expr: is_pre_arrival
      comment: "Indicates whether the request was made pre-arrival. Enables pre-arrival vs. in-stay fulfilment performance comparison."
    - name: "requires_charge"
      expr: requires_charge
      comment: "Indicates whether the request incurs a charge. Segments chargeable vs. complimentary requests for revenue and cost analysis."
    - name: "impacts_loyalty_points"
      expr: impacts_loyalty_points
      comment: "Indicates whether the request affects loyalty point accrual. Tracks loyalty-linked service interactions."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the guest about their request (e.g. EMAIL, SMS, IN_PERSON). Supports communication channel effectiveness analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the special request was submitted. Supports trend analysis of request volumes and fulfilment rates over time."
    - name: "failure_category"
      expr: failure_category
      comment: "Category of fulfilment failure. Enables root-cause analysis of service failures and targeted operational improvements."
  measures:
    - name: "total_special_requests"
      expr: COUNT(special_request_id)
      comment: "Total number of special requests submitted. Baseline volume KPI for operational workload and service demand planning."
    - name: "fulfilment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'FULFILLED' THEN special_request_id END) / NULLIF(COUNT(special_request_id), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Primary service quality KPI; directly linked to guest satisfaction and loyalty outcomes."
    - name: "vip_fulfilment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip_request = TRUE AND fulfillment_status = 'FULFILLED' THEN special_request_id END) / NULLIF(COUNT(CASE WHEN is_vip_request = TRUE THEN special_request_id END), 0), 2)
      comment: "Fulfilment rate specifically for VIP guest requests. Critical KPI for high-value guest retention and loyalty programme performance."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue charged for special requests. Measures ancillary revenue contribution from chargeable guest services."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfil special requests. Tracks operational cost of service delivery for margin management."
    - name: "cost_vs_estimate_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total variance between actual and estimated fulfilment costs. Measures cost estimation accuracy and budget adherence for guest services operations."
    - name: "failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'FAILED' THEN special_request_id END) / NULLIF(COUNT(special_request_id), 0), 2)
      comment: "Percentage of special requests that failed to be fulfilled. Tracks service failure rate; high values trigger operational investigation and process improvement."
    - name: "pre_arrival_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_pre_arrival = TRUE THEN special_request_id END) / NULLIF(COUNT(special_request_id), 0), 2)
      comment: "Percentage of requests submitted pre-arrival. Measures pre-arrival engagement and enables proactive service planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation policy portfolio KPIs covering policy mix, non-refundable rate, deposit requirements, and guarantee coverage. Used by Revenue Management and Legal to govern policy design and compliance."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Lifecycle status of the cancellation policy (e.g. ACTIVE, INACTIVE, DRAFT). Segments active vs. retired policies."
    - name: "policy_tier"
      expr: policy_tier
      comment: "Tier classification of the policy (e.g. STANDARD, PREMIUM, FLEXIBLE). Enables tier-level policy mix and coverage analysis."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty structure (e.g. FLAT_FEE, PERCENTAGE, NIGHTS). Supports penalty design benchmarking."
    - name: "no_show_penalty_type"
      expr: no_show_penalty_type
      comment: "Type of no-show penalty (e.g. FLAT_FEE, PERCENTAGE). Enables no-show policy design analysis."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Indicates whether the policy is fully non-refundable. Key dimension for revenue certainty and refund liability analysis."
    - name: "deposit_required"
      expr: deposit_required
      comment: "Indicates whether a deposit is required under this policy. Tracks deposit-backed policy coverage."
    - name: "guarantee_required"
      expr: guarantee_required
      comment: "Indicates whether a payment guarantee is required. Measures guarantee coverage across the policy portfolio."
    - name: "applies_to_corporate_bookings"
      expr: applies_to_corporate_bookings
      comment: "Indicates whether the policy applies to corporate bookings. Enables corporate vs. leisure policy segmentation."
    - name: "applies_to_group_bookings"
      expr: applies_to_group_bookings
      comment: "Indicates whether the policy applies to group bookings. Enables group vs. transient policy segmentation."
    - name: "allows_modification"
      expr: allows_modification
      comment: "Indicates whether the policy permits booking modifications. Tracks flexibility vs. rigidity in the policy portfolio."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the policy became effective. Supports policy lifecycle and version management analysis."
  measures:
    - name: "total_active_policies"
      expr: COUNT(CASE WHEN policy_status = 'ACTIVE' THEN cancellation_policy_id END)
      comment: "Number of currently active cancellation policies. Tracks policy portfolio size and governance coverage."
    - name: "non_refundable_policy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_non_refundable = TRUE THEN cancellation_policy_id END) / NULLIF(COUNT(cancellation_policy_id), 0), 2)
      comment: "Percentage of policies that are fully non-refundable. Measures revenue certainty strategy; higher rates reduce refund liability but may impact booking conversion."
    - name: "deposit_required_policy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deposit_required = TRUE THEN cancellation_policy_id END) / NULLIF(COUNT(cancellation_policy_id), 0), 2)
      comment: "Percentage of policies requiring a deposit. Tracks deposit-backed policy coverage and cash-flow protection strategy."
    - name: "guarantee_required_policy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guarantee_required = TRUE THEN cancellation_policy_id END) / NULLIF(COUNT(cancellation_policy_id), 0), 2)
      comment: "Percentage of policies requiring a payment guarantee. Measures no-show and cancellation risk mitigation coverage across the policy portfolio."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage across all policies. Benchmarks penalty severity and informs policy calibration relative to industry norms."
    - name: "avg_deposit_percentage"
      expr: AVG(CAST(deposit_percentage AS DOUBLE))
      comment: "Average deposit percentage required across deposit-bearing policies. Benchmarks deposit sizing strategy and its impact on booking conversion."
    - name: "avg_no_show_penalty_amount"
      expr: AVG(CAST(no_show_penalty_amount AS DOUBLE))
      comment: "Average flat no-show penalty amount across policies. Benchmarks no-show penalty levels and informs policy design for revenue protection."
    - name: "modification_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_modification = TRUE THEN cancellation_policy_id END) / NULLIF(COUNT(cancellation_policy_id), 0), 2)
      comment: "Percentage of policies that allow booking modifications. Tracks flexibility in the policy portfolio; informs guest experience and conversion strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel agent and agency performance KPIs covering revenue contribution, booking volume, credit exposure, and contract health. Used by Distribution and Sales leadership to manage the travel agent channel."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`travel_agent`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of travel agency (e.g. LEISURE, CORPORATE, WHOLESALE). Enables segment-level agency performance analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the travel agency. Supports geographic distribution and market penetration analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred communication language of the agency. Supports localisation and relationship management segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Preferred currency of the travel agent. Required for multi-currency revenue and commission reporting."
    - name: "contract_start_date_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month the agency contract started. Supports contract cohort and tenure analysis."
    - name: "contract_end_date_month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
      comment: "Month the agency contract expires. Enables proactive contract renewal pipeline management."
    - name: "last_booking_date_month"
      expr: DATE_TRUNC('MONTH', last_booking_date)
      comment: "Month of the agency's most recent booking. Supports recency analysis and identification of lapsing agents."
  measures:
    - name: "total_revenue_generated"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated by travel agents. Primary channel revenue KPI for distribution strategy and agent tier management."
    - name: "avg_revenue_per_agent"
      expr: AVG(CAST(total_revenue_generated AS DOUBLE))
      comment: "Average revenue generated per travel agent. Benchmarks agent productivity and informs tiering and incentive programme design."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all travel agents. Measures aggregate financial exposure in the agent channel; key risk metric for Finance."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per travel agent. Benchmarks credit policy and informs risk-adjusted agent onboarding decisions."
    - name: "active_agent_count"
      expr: COUNT(CASE WHEN travel_agent_status = 1 THEN travel_agent_id END)
      comment: "Number of active travel agents. Tracks the size of the active distribution network; declining counts signal channel health issues."
    - name: "total_agents"
      expr: COUNT(travel_agent_id)
      comment: "Total number of travel agent records. Baseline portfolio size metric for distribution channel management."
    - name: "revenue_concentration_top_agent_share_pct"
      expr: ROUND(100.0 * MAX(CAST(total_revenue_generated AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue_generated AS DOUBLE)), 0), 2)
      comment: "Percentage of total agent-channel revenue attributable to the single highest-revenue agent. Measures revenue concentration risk; high values indicate over-dependence on a single agent."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking status change event KPIs covering modification patterns, penalty fee recovery, revenue impact of changes, SLA compliance, and dispute activity. Used by Revenue Management, Operations, and Compliance teams."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of booking status event (e.g. MODIFICATION, CANCELLATION, REINSTATEMENT). Primary segmentation for change-event analysis."
    - name: "modification_type"
      expr: modification_type
      comment: "Type of modification applied (e.g. DATE_CHANGE, ROOM_CHANGE, RATE_CHANGE). Enables modification pattern analysis."
    - name: "new_status"
      expr: new_status
      comment: "Status the booking transitioned to. Tracks status flow and transition patterns across the booking lifecycle."
    - name: "previous_status"
      expr: previous_status
      comment: "Status the booking held before the event. Combined with new_status to analyse status transition paths."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the status change event is under dispute. Segments disputed events for risk and compliance reporting."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the event was processed within SLA. Tracks operational SLA adherence for booking change processing."
    - name: "guest_notification_sent_flag"
      expr: guest_notification_sent_flag
      comment: "Indicates whether the guest was notified of the status change. Tracks communication compliance and guest experience quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts in the event record. Required for multi-currency financial impact reporting."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the booking status event occurred. Supports trend analysis of modification and cancellation event volumes."
    - name: "system_source"
      expr: system_source
      comment: "Source system that generated the event (e.g. PMS, CRS, OTA). Enables system-level event volume and error analysis."
  measures:
    - name: "total_status_change_events"
      expr: COUNT(booking_status_history_id)
      comment: "Total number of booking status change events. Baseline volume KPI for operational change activity and system load analysis."
    - name: "total_penalty_fee_amount"
      expr: SUM(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Total penalty fees charged across all booking change events. Measures revenue recovered through change and cancellation penalties."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact (positive or negative) from booking status changes. Quantifies the net financial effect of all booking modifications and cancellations."
    - name: "total_rate_difference_amount"
      expr: SUM(CAST(rate_difference_amount AS DOUBLE))
      comment: "Total rate difference amounts from booking modifications. Measures revenue uplift or dilution from rate changes on modified bookings."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN booking_status_history_id END) / NULLIF(COUNT(booking_status_history_id), 0), 2)
      comment: "Percentage of booking change events processed within SLA. Operational quality KPI; low compliance rates trigger process and staffing reviews."
    - name: "guest_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_sent_flag = TRUE THEN booking_status_history_id END) / NULLIF(COUNT(booking_status_history_id), 0), 2)
      comment: "Percentage of status change events where the guest was notified. Tracks communication compliance; low rates indicate guest experience and regulatory risk."
    - name: "dispute_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN booking_status_history_id END) / NULLIF(COUNT(booking_status_history_id), 0), 2)
      comment: "Percentage of booking change events that are disputed. Elevated rates signal policy clarity issues or systemic processing errors."
    - name: "avg_revenue_impact_per_event"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per booking status change event. Benchmarks the financial materiality of booking changes and informs change-fee policy calibration."
$$;