-- Metric views for domain: reservation | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking performance metrics tracking revenue, booking velocity, cancellation impact, and guest behavior patterns"
  source: "`travel_hospitality_ecm`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the reservation (confirmed, cancelled, no-show, etc.)"
    - name: "booking_date"
      expr: DATE_TRUNC('day', booking_date)
      comment: "Date the reservation was booked, truncated to day"
    - name: "arrival_date"
      expr: DATE_TRUNC('day', arrival_date)
      comment: "Guest arrival date, truncated to day"
    - name: "departure_date"
      expr: DATE_TRUNC('day', departure_date)
      comment: "Guest departure date, truncated to day"
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Month the reservation was booked"
    - name: "arrival_month"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Month of guest arrival"
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Method used to guarantee the reservation (credit card, deposit, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method selected for the reservation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the reservation transaction"
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Indicates whether the guest has VIP status"
    - name: "accessibility_required_flag"
      expr: accessibility_required_flag
      comment: "Indicates whether accessibility features are required"
    - name: "room_type_requested"
      expr: room_type_requested
      comment: "Type of room requested by the guest"
    - name: "package_code"
      expr: package_code
      comment: "Package code associated with the reservation"
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue across all reservations"
    - name: "total_bookings"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Total number of unique reservation bookings"
    - name: "total_room_nights"
      expr: SUM(CAST(length_of_stay AS DOUBLE))
      comment: "Total room nights booked across all reservations"
    - name: "total_rooms_booked"
      expr: SUM(CAST(number_of_rooms AS DOUBLE))
      comment: "Total number of rooms booked"
    - name: "total_guests"
      expr: SUM(CAST(number_of_adults AS DOUBLE) + CAST(number_of_children AS DOUBLE))
      comment: "Total number of guests (adults plus children) across all reservations"
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average daily rate across all reservations"
    - name: "avg_length_of_stay"
      expr: AVG(CAST(length_of_stay AS DOUBLE))
      comment: "Average length of stay in nights"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on reservations"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles who made reservations"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with reservations"
    - name: "vip_booking_count"
      expr: SUM(CASE WHEN vip_status_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings with VIP status"
    - name: "accessibility_booking_count"
      expr: SUM(CASE WHEN accessibility_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings requiring accessibility features"
    - name: "early_checkin_request_count"
      expr: SUM(CASE WHEN early_checkin_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings requesting early check-in"
    - name: "late_checkout_request_count"
      expr: SUM(CASE WHEN late_checkout_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings requesting late checkout"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation performance metrics tracking revenue loss, penalty recovery, refund exposure, and cancellation patterns"
  source: "`travel_hospitality_ecm`.`reservation`.`cancellation`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized code for cancellation reason"
    - name: "event_type"
      expr: event_type
      comment: "Type of cancellation event"
    - name: "cancellation_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date the cancellation occurred, truncated to day"
    - name: "cancellation_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the cancellation occurred"
    - name: "original_arrival_date"
      expr: DATE_TRUNC('day', original_arrival_date)
      comment: "Original arrival date of the cancelled reservation"
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Indicates whether a cancellation penalty applies"
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the guest is eligible for a refund"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the cancellation is disputed"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether the penalty was waived"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the cancellation was reversed"
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Guarantee method used for the original reservation"
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which the cancellation was processed"
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency code for penalty amounts"
  measures:
    - name: "total_cancellations"
      expr: COUNT(DISTINCT cancellation_id)
      comment: "Total number of unique cancellations"
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total revenue lost due to cancellations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty fees collected from cancellations"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued for cancellations"
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amounts incurred"
    - name: "net_cancellation_impact"
      expr: SUM((CAST(revenue_lost_amount AS DOUBLE)) - (CAST(penalty_amount AS DOUBLE)))
      comment: "Net revenue impact of cancellations (revenue lost minus penalties recovered)"
    - name: "penalty_applicable_count"
      expr: SUM(CASE WHEN penalty_applicable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cancellations where penalty was applicable"
    - name: "refund_eligible_count"
      expr: SUM(CASE WHEN refund_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cancellations eligible for refund"
    - name: "disputed_cancellation_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cancellations that are disputed"
    - name: "waived_penalty_count"
      expr: SUM(CASE WHEN waiver_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cancellations where penalty was waived"
    - name: "reversed_cancellation_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cancellations that were reversed"
    - name: "ota_chargeback_eligible_count"
      expr: SUM(CASE WHEN ota_chargeback_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cancellations eligible for OTA chargeback"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per cancellation"
    - name: "avg_revenue_lost"
      expr: AVG(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Average revenue lost per cancellation"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance metrics tracking contracted vs picked-up rooms, attrition risk, and group revenue realization"
  source: "`travel_hospitality_ecm`.`reservation`.`reservation_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block"
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (corporate, event, wedding, etc.)"
    - name: "arrival_date"
      expr: DATE_TRUNC('day', arrival_date)
      comment: "Group arrival date, truncated to day"
    - name: "departure_date"
      expr: DATE_TRUNC('day', departure_date)
      comment: "Group departure date, truncated to day"
    - name: "cutoff_date"
      expr: DATE_TRUNC('day', cutoff_date)
      comment: "Cutoff date for room block release"
    - name: "arrival_month"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Month of group arrival"
    - name: "contract_signed_date"
      expr: DATE_TRUNC('day', contract_signed_date)
      comment: "Date the group contract was signed"
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Indicates whether an attrition clause is in effect"
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required"
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates whether last room availability applies"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for group block financials"
    - name: "block_code"
      expr: block_code
      comment: "Unique code identifying the group block"
  measures:
    - name: "total_group_blocks"
      expr: COUNT(DISTINCT reservation_group_block_id)
      comment: "Total number of unique group blocks"
    - name: "total_contracted_rooms"
      expr: SUM(CAST(contracted_room_count AS DOUBLE))
      comment: "Total number of rooms contracted across all group blocks"
    - name: "total_picked_up_rooms"
      expr: SUM(CAST(pickup_room_count AS DOUBLE))
      comment: "Total number of rooms actually picked up from group blocks"
    - name: "total_available_rooms"
      expr: SUM(CAST(available_room_count AS DOUBLE))
      comment: "Total number of rooms still available in group blocks"
    - name: "total_group_rate_amount"
      expr: SUM(CAST(group_rate_amount AS DOUBLE))
      comment: "Total group rate amount across all blocks"
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected for group blocks"
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group rate across all blocks"
    - name: "avg_contracted_rooms"
      expr: AVG(CAST(contracted_room_count AS DOUBLE))
      comment: "Average number of contracted rooms per group block"
    - name: "avg_attrition_threshold"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group blocks"
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage for group blocks"
    - name: "attrition_clause_count"
      expr: SUM(CASE WHEN attrition_clause_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of group blocks with attrition clauses"
    - name: "deposit_required_count"
      expr: SUM(CASE WHEN deposit_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of group blocks requiring deposits"
    - name: "lra_block_count"
      expr: SUM(CASE WHEN lra_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of group blocks with last room availability"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_walk_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Walk/relocation performance metrics tracking guest displacement impact, compensation costs, and service recovery effectiveness"
  source: "`travel_hospitality_ecm`.`reservation`.`walk_record`"
  dimensions:
    - name: "walk_date"
      expr: DATE_TRUNC('day', walk_date)
      comment: "Date the guest was walked, truncated to day"
    - name: "walk_month"
      expr: DATE_TRUNC('month', walk_date)
      comment: "Month the guest was walked"
    - name: "walk_reason_code"
      expr: walk_reason_code
      comment: "Standardized code for walk reason"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation provided to walked guest"
    - name: "original_arrival_date"
      expr: DATE_TRUNC('day', original_arrival_date)
      comment: "Original arrival date of the walked reservation"
    - name: "original_room_type_code"
      expr: original_room_type_code
      comment: "Room type originally reserved"
    - name: "provided_room_type_code"
      expr: provided_room_type_code
      comment: "Room type provided at destination hotel"
    - name: "transportation_provided_flag"
      expr: transportation_provided_flag
      comment: "Indicates whether transportation was provided"
    - name: "complaint_filed_flag"
      expr: complaint_filed_flag
      comment: "Indicates whether the guest filed a complaint"
    - name: "ota_penalty_applicable_flag"
      expr: ota_penalty_applicable_flag
      comment: "Indicates whether OTA penalty applies"
    - name: "brand_standard_compliance_flag"
      expr: brand_standard_compliance_flag
      comment: "Indicates whether walk handling met brand standards"
    - name: "compensation_currency_code"
      expr: compensation_currency_code
      comment: "Currency code for compensation amounts"
  measures:
    - name: "total_walks"
      expr: COUNT(DISTINCT walk_record_id)
      comment: "Total number of guest walk incidents"
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total revenue lost due to walking guests"
    - name: "total_compensation_value"
      expr: SUM(CAST(total_compensation_value_amount AS DOUBLE))
      comment: "Total value of compensation provided to walked guests"
    - name: "total_cash_compensation"
      expr: SUM(CAST(cash_compensation_amount AS DOUBLE))
      comment: "Total cash compensation paid to walked guests"
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost_amount AS DOUBLE))
      comment: "Total cost of transportation provided to walked guests"
    - name: "total_ota_penalty"
      expr: SUM(CAST(ota_penalty_amount AS DOUBLE))
      comment: "Total OTA penalties incurred from walk incidents"
    - name: "total_loyalty_points_awarded"
      expr: SUM(CAST(loyalty_points_awarded AS DOUBLE))
      comment: "Total loyalty points awarded as compensation"
    - name: "total_complimentary_nights"
      expr: SUM(CAST(complimentary_nights_count AS DOUBLE))
      comment: "Total complimentary nights provided as compensation"
    - name: "avg_compensation_value"
      expr: AVG(CAST(total_compensation_value_amount AS DOUBLE))
      comment: "Average compensation value per walk incident"
    - name: "avg_guest_satisfaction_score"
      expr: AVG(CAST(guest_satisfaction_score AS DOUBLE))
      comment: "Average guest satisfaction score after walk incident"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score after walk incident"
    - name: "transportation_provided_count"
      expr: SUM(CASE WHEN transportation_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of walk incidents where transportation was provided"
    - name: "complaint_filed_count"
      expr: SUM(CASE WHEN complaint_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of walk incidents resulting in guest complaints"
    - name: "ota_penalty_applicable_count"
      expr: SUM(CASE WHEN ota_penalty_applicable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of walk incidents subject to OTA penalties"
    - name: "brand_compliant_walk_count"
      expr: SUM(CASE WHEN brand_standard_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of walk incidents handled in compliance with brand standards"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit management metrics tracking deposit collection, forfeiture, refund exposure, and cash flow timing"
  source: "`travel_hospitality_ecm`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the deposit"
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (advance, guarantee, damage, etc.)"
    - name: "deposit_due_date"
      expr: DATE_TRUNC('day', deposit_due_date)
      comment: "Date the deposit is due"
    - name: "payment_received_date"
      expr: DATE_TRUNC('day', payment_received_date)
      comment: "Date the deposit payment was received"
    - name: "applied_to_folio_date"
      expr: DATE_TRUNC('day', applied_to_folio_date)
      comment: "Date the deposit was applied to guest folio"
    - name: "forfeiture_date"
      expr: DATE_TRUNC('day', forfeiture_date)
      comment: "Date the deposit was forfeited"
    - name: "refund_date"
      expr: DATE_TRUNC('day', refund_date)
      comment: "Date the deposit was refunded"
    - name: "revenue_recognition_date"
      expr: DATE_TRUNC('day', revenue_recognition_date)
      comment: "Date the deposit was recognized as revenue"
    - name: "deposit_month"
      expr: DATE_TRUNC('month', payment_received_date)
      comment: "Month the deposit was received"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for deposit amounts"
    - name: "booking_source"
      expr: booking_source
      comment: "Source of the booking requiring deposit"
    - name: "deposit_policy_code"
      expr: deposit_policy_code
      comment: "Policy code governing the deposit"
  measures:
    - name: "total_deposits"
      expr: COUNT(DISTINCT deposit_ledger_id)
      comment: "Total number of deposit transactions"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected"
    - name: "total_forfeiture_amount"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE))
      comment: "Total deposit amounts forfeited"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit amounts refunded"
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per transaction"
    - name: "avg_forfeiture_amount"
      expr: AVG(CAST(forfeiture_amount AS DOUBLE))
      comment: "Average forfeiture amount per transaction"
    - name: "unique_reservations_with_deposits"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of unique reservations with deposit transactions"
    - name: "unique_properties_with_deposits"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with deposit transactions"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment performance metrics tracking upgrade rates, guest preference matching, and assignment efficiency"
  source: "`travel_hospitality_ecm`.`reservation`.`room_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the room assignment"
    - name: "assignment_date"
      expr: DATE_TRUNC('day', assignment_date)
      comment: "Date the room was assigned, truncated to day"
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month the room was assigned"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the room (manual, auto, etc.)"
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Indicates whether the assignment is an upgrade"
    - name: "upgrade_category"
      expr: upgrade_category
      comment: "Category of upgrade provided"
    - name: "upgrade_reason_code"
      expr: upgrade_reason_code
      comment: "Reason code for the upgrade"
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Indicates whether the assignment was guest-requested"
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Indicates whether the assigned room is accessible"
    - name: "is_connecting_room"
      expr: is_connecting_room
      comment: "Indicates whether the assigned room is a connecting room"
    - name: "room_type_code"
      expr: room_type_code
      comment: "Type code of the assigned room"
    - name: "floor_number"
      expr: floor_number
      comment: "Floor number of the assigned room"
    - name: "view_type"
      expr: view_type
      comment: "View type of the assigned room"
    - name: "smoking_preference"
      expr: smoking_preference
      comment: "Smoking preference for the assigned room"
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Indicates whether early check-in was provided"
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Indicates whether late checkout was provided"
  measures:
    - name: "total_room_assignments"
      expr: COUNT(DISTINCT room_assignment_id)
      comment: "Total number of room assignments"
    - name: "total_upgrades"
      expr: SUM(CASE WHEN is_upgrade = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of room upgrades provided"
    - name: "total_guest_requested_assignments"
      expr: SUM(CASE WHEN is_guest_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of guest-requested room assignments"
    - name: "total_accessible_room_assignments"
      expr: SUM(CASE WHEN is_accessible_room = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of accessible room assignments"
    - name: "total_connecting_room_assignments"
      expr: SUM(CASE WHEN is_connecting_room = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of connecting room assignments"
    - name: "total_early_checkins"
      expr: SUM(CASE WHEN early_checkin_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of early check-ins provided"
    - name: "total_late_checkouts"
      expr: SUM(CASE WHEN late_checkout_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of late checkouts provided"
    - name: "avg_guest_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score across all assignments"
    - name: "avg_reassignment_count"
      expr: AVG(CAST(reassignment_count AS DOUBLE))
      comment: "Average number of reassignments per room assignment"
    - name: "unique_rooms_assigned"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms assigned"
    - name: "unique_reservations_assigned"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of unique reservations with room assignments"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_booking_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package performance metrics tracking package revenue mix, redemption rates, and package profitability"
  source: "`travel_hospitality_ecm`.`reservation`.`booking_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the booking package"
    - name: "package_category"
      expr: package_category
      comment: "Category of the package (spa, dining, activity, etc.)"
    - name: "package_code"
      expr: package_code
      comment: "Unique code identifying the package"
    - name: "package_name"
      expr: package_name
      comment: "Name of the package"
    - name: "start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Package start date, truncated to day"
    - name: "end_date"
      expr: DATE_TRUNC('day', end_date)
      comment: "Package end date, truncated to day"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the package starts"
    - name: "redemption_date"
      expr: DATE_TRUNC('day', redemption_date)
      comment: "Date the package was redeemed"
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the package"
    - name: "is_inclusive"
      expr: is_inclusive
      comment: "Indicates whether the package is inclusive"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the package is mandatory"
    - name: "is_refundable"
      expr: is_refundable
      comment: "Indicates whether the package is refundable"
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Indicates whether the package is commission-eligible"
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Indicates whether the package price is tax-inclusive"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for package amounts"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for the package"
  measures:
    - name: "total_packages"
      expr: COUNT(DISTINCT booking_package_id)
      comment: "Total number of booking packages"
    - name: "total_package_rate_amount"
      expr: SUM(CAST(package_rate_amount AS DOUBLE))
      comment: "Total package rate revenue"
    - name: "total_package_cost_amount"
      expr: SUM(CAST(package_cost_amount AS DOUBLE))
      comment: "Total package cost"
    - name: "total_rooms_revenue"
      expr: SUM(CAST(rooms_revenue_amount AS DOUBLE))
      comment: "Total rooms revenue component of packages"
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total food and beverage revenue component of packages"
    - name: "total_other_revenue"
      expr: SUM(CAST(other_revenue_amount AS DOUBLE))
      comment: "Total other revenue component of packages"
    - name: "avg_package_rate"
      expr: AVG(CAST(package_rate_amount AS DOUBLE))
      comment: "Average package rate amount"
    - name: "avg_package_cost"
      expr: AVG(CAST(package_cost_amount AS DOUBLE))
      comment: "Average package cost amount"
    - name: "inclusive_package_count"
      expr: SUM(CASE WHEN is_inclusive = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inclusive packages"
    - name: "mandatory_package_count"
      expr: SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END)
      comment: "Number of mandatory packages"
    - name: "refundable_package_count"
      expr: SUM(CASE WHEN is_refundable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of refundable packages"
    - name: "commission_eligible_package_count"
      expr: SUM(CASE WHEN commission_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of commission-eligible packages"
    - name: "unique_reservations_with_packages"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of unique reservations with packages"
$$;