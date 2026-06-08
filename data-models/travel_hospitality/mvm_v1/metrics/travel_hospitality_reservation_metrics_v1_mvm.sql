-- Metric views for domain: reservation | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking KPIs covering revenue performance, booking volume, ADR, length of stay, and channel/segment mix. Primary steering dashboard for Revenue Management and Front Office leadership."
  source: "`travel_hospitality_ecm`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the reservation (e.g. Confirmed, Cancelled, No-Show, Checked-Out). Enables segmentation of active vs. lost bookings."
    - name: "booking_date"
      expr: booking_date
      comment: "Calendar date the reservation was created. Used for booking pace and lead-time trend analysis."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Guest arrival date. Used for occupancy forecasting and revenue attribution by stay period."
    - name: "departure_date"
      expr: departure_date
      comment: "Guest departure date. Used alongside arrival_date to compute stay windows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was transacted. Enables multi-currency revenue reporting."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Payment guarantee method (e.g. Credit Card, Corporate Account, Deposit). Indicates financial risk exposure per booking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used for the booking. Supports payment channel mix analysis."
    - name: "package_code"
      expr: package_code
      comment: "Package code associated with the booking. Enables package attach-rate and revenue contribution analysis."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Indicates whether the guest holds VIP status. Used to segment high-value guest bookings for service prioritization."
    - name: "accessibility_required_flag"
      expr: accessibility_required_flag
      comment: "Indicates whether the guest requires an accessible room. Supports compliance and room inventory planning."
    - name: "early_checkin_requested_flag"
      expr: early_checkin_requested_flag
      comment: "Indicates whether an early check-in was requested. Supports front-office operational planning."
    - name: "late_checkout_requested_flag"
      expr: late_checkout_requested_flag
      comment: "Indicates whether a late check-out was requested. Supports housekeeping scheduling and upsell tracking."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation bookings. Baseline volume KPI for booking pace and demand tracking."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue across all bookings. Primary top-line revenue KPI for Revenue Management and Finance."
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average Daily Rate (ADR) across bookings. Core hotel pricing KPI used in RevPAR calculations and rate strategy reviews."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to travel agents and OTA channels. Directly impacts net revenue and distribution cost management."
    - name: "avg_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per booking. Used to benchmark distribution cost efficiency across channels."
    - name: "avg_length_of_stay"
      expr: AVG(CAST(length_of_stay AS DOUBLE))
      comment: "Average length of stay (nights) per booking. Key demand pattern metric influencing pricing strategy and housekeeping resource planning."
    - name: "vip_booking_count"
      expr: COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END)
      comment: "Number of bookings flagged as VIP. Tracks high-value guest volume for loyalty and service investment decisions."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled reservations. Tracks cancellation volume to assess revenue risk and policy effectiveness."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. Critical KPI for revenue risk management and cancellation policy calibration."
    - name: "avg_room_revenue_per_booking"
      expr: AVG(CAST(total_room_revenue AS DOUBLE))
      comment: "Average room revenue per booking record. Measures booking value intensity and supports upsell effectiveness tracking."
    - name: "distinct_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guest profiles with bookings. Measures guest reach and supports loyalty penetration analysis."
    - name: "loyalty_member_booking_count"
      expr: COUNT(CASE WHEN member_id IS NOT NULL THEN 1 END)
      comment: "Number of bookings made by loyalty program members. Tracks loyalty channel contribution to total booking volume."
    - name: "loyalty_member_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings from loyalty members. Strategic KPI for loyalty program ROI and member engagement."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation analytics covering penalty revenue, refund exposure, OTA chargeback risk, waiver rates, and revenue loss. Used by Revenue Management, Finance, and Operations to manage cancellation policy effectiveness and financial recovery."
  source: "`travel_hospitality_ecm`.`reservation`.`cancellation`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the cancellation. Enables root-cause analysis of cancellation drivers."
    - name: "reason_description"
      expr: reason_description
      comment: "Human-readable description of the cancellation reason. Supports qualitative analysis alongside reason codes."
    - name: "event_type"
      expr: event_type
      comment: "Type of cancellation event (e.g. Guest-Initiated, No-Show, OTA). Segments cancellations by origin for policy targeting."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Guarantee method on the cancelled booking. Indicates whether penalty collection is feasible."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the cancellation charge posting (e.g. Posted, Pending, Waived). Tracks financial processing completion."
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which the cancellation was processed. Supports channel-level cancellation cost analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the cancellation is under dispute. Flags financial risk items requiring resolution."
    - name: "dispute_resolution_status"
      expr: dispute_resolution_status
      comment: "Current resolution status of a disputed cancellation. Tracks dispute pipeline for Finance and Legal."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether the cancellation penalty was waived. Used to measure waiver frequency and revenue impact."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the guest is eligible for a refund. Supports refund liability forecasting."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Indicates whether a cancellation penalty applies. Used to segment penalized vs. fee-free cancellations."
    - name: "original_arrival_date"
      expr: original_arrival_date
      comment: "Original intended arrival date of the cancelled booking. Enables analysis of cancellation timing relative to stay date."
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency of the penalty charge. Supports multi-currency penalty revenue reporting."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation events. Baseline volume KPI for cancellation trend monitoring."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total room revenue lost due to cancellations. Primary financial impact KPI for Revenue Management and Finance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total cancellation penalty fees charged. Measures financial recovery from cancellations against policy."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty fee per cancellation. Benchmarks penalty policy effectiveness across segments and channels."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on cancellations. Tracks cash outflow from refund obligations for treasury planning."
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amounts on cancellations. Measures OTA channel financial risk and dispute exposure."
    - name: "penalty_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_lost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of lost revenue recovered through cancellation penalties. Measures cancellation policy financial effectiveness."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations where the penalty was waived. Tracks waiver frequency to assess policy adherence and revenue leakage."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations under dispute. Indicates guest satisfaction issues and financial risk concentration."
    - name: "ota_chargeback_eligible_count"
      expr: COUNT(CASE WHEN ota_chargeback_eligible_flag = TRUE THEN 1 END)
      comment: "Number of cancellations eligible for OTA chargeback. Quantifies recoverable OTA revenue exposure."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_group_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block pickup performance metrics tracking room block utilization, pickup rates, revenue realization, and cutoff compliance. Used by Group Sales, Revenue Management, and Event Operations to manage group business performance."
  source: "`travel_hospitality_ecm`.`reservation`.`group_block_pickup`"
  dimensions:
    - name: "pickup_status"
      expr: pickup_status
      comment: "Current status of the group block pickup (e.g. Confirmed, Cancelled, No-Show). Segments pickups by fulfillment state."
    - name: "booking_channel_code"
      expr: booking_channel_code
      comment: "Channel through which the group pickup was booked. Enables channel mix analysis for group business."
    - name: "group_attendee_type"
      expr: group_attendee_type
      comment: "Type of group attendee (e.g. Corporate, Leisure, Conference). Supports group segment performance analysis."
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Guarantee type for the group pickup. Indicates financial commitment level of the group booking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the group pickup transaction. Supports multi-currency group revenue reporting."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Arrival date for the group pickup. Used for demand forecasting and group arrival pattern analysis."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date after which unreleased rooms return to inventory. Critical for attrition and inventory management."
    - name: "pickup_before_cutoff_flag"
      expr: pickup_before_cutoff_flag
      comment: "Indicates whether the pickup was made before the block cutoff date. Measures group booking pace compliance."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates whether the group attendee was a no-show. Tracks no-show incidence for group attrition management."
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "Indicates whether the group pickup is for a VIP attendee. Supports high-value guest service prioritization."
  measures:
    - name: "total_group_pickups"
      expr: COUNT(1)
      comment: "Total number of group block pickup records. Baseline volume KPI for group booking activity."
    - name: "total_group_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue generated from group block pickups. Primary group revenue KPI for Group Sales and Revenue Management."
    - name: "avg_group_rate"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average negotiated group room rate. Benchmarks group pricing against transient rates and market segments."
    - name: "avg_block_utilization_pct"
      expr: AVG(CAST(block_utilization_percentage AS DOUBLE))
      comment: "Average block utilization percentage across group blocks. Core KPI measuring how effectively contracted room blocks are consumed."
    - name: "total_group_revenue_per_pickup"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Aggregate room revenue from group pickups. Used alongside pickup count to derive revenue intensity per group event."
    - name: "pre_cutoff_pickup_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pickup_before_cutoff_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group pickups made before the block cutoff date. Measures group booking pace and attrition risk management effectiveness."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group pickups resulting in no-shows. Tracks group no-show incidence to inform overbooking and attrition policy."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_date IS NOT NULL THEN 1 END)
      comment: "Number of group pickups that were cancelled. Measures group cancellation volume for attrition clause management."
    - name: "distinct_group_blocks"
      expr: COUNT(DISTINCT reservation_group_block_id)
      comment: "Number of distinct group blocks with pickup activity. Measures breadth of active group business across the portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block contract performance metrics covering contracted vs. pickup room counts, revenue forecasting, attrition risk, and deposit compliance. Used by Group Sales, Revenue Management, and Finance for group business portfolio management."
  source: "`travel_hospitality_ecm`.`reservation`.`reservation_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g. Tentative, Definite, Cancelled). Segments the group pipeline by commitment stage."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (e.g. Corporate, Association, Leisure). Enables group segment mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the group block contract. Supports multi-currency group revenue reporting."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Arrival date for the group block. Used for demand forecasting and group arrival pattern analysis."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date. Critical for inventory release planning and attrition clause enforcement."
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Indicates whether an attrition clause is in the group contract. Flags blocks with financial penalty exposure if pickup falls short."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for the group block. Tracks deposit compliance and cash flow planning."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates whether the group block is under a Last Room Availability (LRA) agreement. Flags contractual inventory obligations."
    - name: "contract_signed_date"
      expr: contract_signed_date
      comment: "Date the group contract was signed. Used for booking pace and conversion timeline analysis."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group block records. Baseline volume KPI for group pipeline size."
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks. Primary group revenue pipeline KPI for Finance and Revenue Management."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average contracted group room rate. Benchmarks group pricing strategy and negotiation outcomes."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected on group blocks. Tracks cash-on-hand from group commitments for treasury management."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group contracts. Measures contractual pickup obligation levels for risk assessment."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage on group blocks. Tracks distribution cost for group channel management."
    - name: "attrition_risk_block_count"
      expr: COUNT(CASE WHEN attrition_clause_flag = TRUE THEN 1 END)
      comment: "Number of group blocks with attrition clauses. Quantifies the portfolio of blocks with financial penalty exposure."
    - name: "deposit_required_block_count"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END)
      comment: "Number of group blocks requiring a deposit. Tracks deposit compliance pipeline for Finance."
    - name: "cancelled_block_count"
      expr: COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of group blocks that have been cancelled. Measures group cancellation volume and pipeline attrition."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_booking_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking package performance metrics covering package revenue, cost, margin, attach rates, and fulfillment. Used by Revenue Management, F&B, and Spa teams to evaluate package profitability and guest experience investment."
  source: "`travel_hospitality_ecm`.`reservation`.`booking_package`"
  dimensions:
    - name: "package_name"
      expr: package_name
      comment: "Name of the booking package. Enables package-level performance comparison."
    - name: "package_category"
      expr: package_category
      comment: "Category of the package (e.g. Romance, Family, Business). Supports package mix and segment analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (e.g. Active, Cancelled, Redeemed). Segments packages by fulfillment state."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the package. Tracks whether package benefits have been consumed by the guest."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package transaction. Supports multi-currency package revenue reporting."
    - name: "is_inclusive"
      expr: is_inclusive
      comment: "Indicates whether the package is all-inclusive. Differentiates inclusive vs. add-on package revenue structures."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Indicates whether the package is refundable. Tracks refund liability exposure in the package portfolio."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the package is mandatory for the booking. Distinguishes mandatory vs. optional package attach."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Indicates whether the package rate is tax-inclusive. Supports accurate net revenue calculation."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Indicates whether the package is eligible for commission. Tracks commissionable package volume for distribution cost management."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the package validity period. Used for seasonal package performance analysis."
    - name: "redemption_date"
      expr: redemption_date
      comment: "Date the package was redeemed. Enables redemption timing and fulfillment lag analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of booking packages. Baseline volume KPI for package attach activity."
    - name: "total_package_rate_revenue"
      expr: SUM(CAST(package_rate_amount AS DOUBLE))
      comment: "Total revenue from package rates charged to guests. Measures top-line package revenue contribution."
    - name: "total_package_cost"
      expr: SUM(CAST(package_cost_amount AS DOUBLE))
      comment: "Total cost of delivering booking packages. Used to calculate package gross margin and profitability."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue attributed to booking packages. Measures package-driven F&B outlet performance."
    - name: "total_rooms_revenue_from_packages"
      expr: SUM(CAST(rooms_revenue_amount AS DOUBLE))
      comment: "Total rooms revenue allocated to booking packages. Supports revenue allocation analysis between rooms and ancillary components."
    - name: "avg_package_rate"
      expr: AVG(CAST(package_rate_amount AS DOUBLE))
      comment: "Average package rate per booking package. Benchmarks package pricing and yield performance."
    - name: "package_gross_margin"
      expr: SUM(CAST(package_rate_amount AS DOUBLE) - CAST(package_cost_amount AS DOUBLE))
      comment: "Total gross margin from booking packages (rate minus cost). Core profitability KPI for package portfolio management."
    - name: "cancelled_package_count"
      expr: COUNT(CASE WHEN package_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled booking packages. Tracks package cancellation volume for revenue leakage analysis."
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'Redeemed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages that have been redeemed. Measures guest engagement with purchased packages and fulfillment effectiveness."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment and guest satisfaction metrics covering fulfillment rates, cost, charge recovery, and VIP request handling. Used by Guest Experience, Operations, and Loyalty teams to measure service delivery quality."
  source: "`travel_hospitality_ecm`.`reservation`.`reservation_special_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of special request (e.g. Room Preference, Amenity, Accessibility). Enables request category performance analysis."
    - name: "request_category"
      expr: request_category
      comment: "Category of the special request. Supports operational workload analysis by request category."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status of the request (e.g. Fulfilled, Pending, Failed). Core dimension for service delivery tracking."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for fulfilling the request. Enables departmental workload and performance analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request (e.g. High, Medium, Low). Supports SLA compliance and escalation analysis."
    - name: "is_vip_request"
      expr: is_vip_request
      comment: "Indicates whether the request is for a VIP guest. Enables VIP service delivery performance tracking."
    - name: "is_pre_arrival"
      expr: is_pre_arrival
      comment: "Indicates whether the request was made pre-arrival. Supports pre-arrival planning and operational readiness analysis."
    - name: "requires_charge"
      expr: requires_charge
      comment: "Indicates whether the request incurs a charge. Segments chargeable vs. complimentary requests for revenue tracking."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the guest about their request status. Supports communication channel effectiveness analysis."
    - name: "failure_category"
      expr: failure_category
      comment: "Category of failure when a request was not fulfilled. Enables root-cause analysis of service delivery failures."
    - name: "request_source"
      expr: request_source
      comment: "Source through which the request was submitted (e.g. App, Front Desk, Concierge). Tracks request channel mix."
    - name: "target_fulfillment_date"
      expr: target_fulfillment_date
      comment: "Target date for fulfilling the request. Used for SLA compliance and on-time delivery analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests submitted. Baseline volume KPI for guest service demand tracking."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Primary service quality KPI for Guest Experience and Operations leadership."
    - name: "failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'Failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests that failed to be fulfilled. Tracks service failure rate to drive operational improvement."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges billed for special requests. Measures ancillary revenue generated through guest service requests."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill special requests. Used to calculate service delivery margin."
    - name: "avg_guest_satisfaction_rating"
      expr: AVG(CAST(guest_satisfaction_rating AS DOUBLE))
      comment: "Average guest satisfaction rating for fulfilled special requests. Directly measures service quality and guest experience outcomes."
    - name: "vip_request_count"
      expr: COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END)
      comment: "Number of special requests flagged as VIP. Tracks VIP service demand volume for high-value guest management."
    - name: "vip_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip_request = TRUE AND fulfillment_status = 'Fulfilled' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END), 0), 2)
      comment: "Fulfillment rate for VIP special requests. Critical KPI for luxury service delivery and high-value guest retention."
    - name: "charge_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of charges billed to actual cost incurred for special requests. Measures cost recovery efficiency for chargeable guest services."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment quality and upgrade metrics covering upgrade rates, guest preference match, early/late request fulfillment, and reassignment frequency. Used by Front Office and Revenue Management to optimize room inventory allocation and guest satisfaction."
  source: "`travel_hospitality_ecm`.`reservation`.`room_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the room assignment (e.g. Assigned, Checked-In, Checked-Out). Segments assignments by lifecycle stage."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the room (e.g. Auto, Manual, Guest Request). Enables analysis of assignment process efficiency."
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Indicates whether the assignment is a room upgrade. Core dimension for upgrade program performance analysis."
    - name: "upgrade_category"
      expr: upgrade_category
      comment: "Category of the room upgrade (e.g. Room Type, Floor, View). Supports upgrade mix and revenue impact analysis."
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Indicates whether the assigned room is accessible. Tracks accessibility compliance in room assignments."
    - name: "is_connecting_room"
      expr: is_connecting_room
      comment: "Indicates whether the assigned room is a connecting room. Supports family and group room configuration analysis."
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Indicates whether the room was specifically requested by the guest. Measures guest preference fulfillment rate."
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Indicates whether an early check-in was granted. Tracks early check-in fulfillment for guest satisfaction and housekeeping planning."
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Indicates whether a late check-out was granted. Tracks late check-out fulfillment for revenue and housekeeping impact."
    - name: "view_type"
      expr: view_type
      comment: "View type of the assigned room (e.g. Ocean, Garden, City). Supports premium view inventory utilization analysis."
    - name: "bed_configuration"
      expr: bed_configuration
      comment: "Bed configuration of the assigned room (e.g. King, Twin, Double). Enables bed type preference fulfillment analysis."
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date the room was assigned. Used for assignment timing and pre-arrival planning analysis."
  measures:
    - name: "total_room_assignments"
      expr: COUNT(1)
      comment: "Total number of room assignments. Baseline volume KPI for front office assignment activity."
    - name: "upgrade_count"
      expr: COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END)
      comment: "Number of room upgrades granted. Tracks upgrade volume for loyalty benefit and upsell program performance."
    - name: "upgrade_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room assignments that are upgrades. Measures upgrade program reach and inventory utilization for premium rooms."
    - name: "avg_guest_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score for room assignments. Measures how well room assignments align with guest preferences — a direct driver of satisfaction scores."
    - name: "guest_requested_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments where the guest's specific room request was honored. Measures preference fulfillment effectiveness."
    - name: "early_checkin_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_checkin_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with early check-in granted. Tracks early check-in fulfillment rate for guest experience and operational planning."
    - name: "late_checkout_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_checkout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with late check-out granted. Tracks late check-out fulfillment rate for revenue impact and housekeeping scheduling."
    - name: "avg_reassignment_count"
      expr: AVG(CAST(reassignment_count AS DOUBLE))
      comment: "Average number of reassignments per room assignment record. High reassignment rates indicate inventory management or guest satisfaction issues."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel agent portfolio performance metrics covering revenue generation, commission rates, booking volume tiers, and contract status. Used by Distribution, Sales, and Finance to manage travel agent relationships and optimize commission spend."
  source: "`travel_hospitality_ecm`.`reservation`.`travel_agent`"
  dimensions:
    - name: "travel_agent_status"
      expr: travel_agent_status
      comment: "Current status of the travel agent (e.g. Active, Inactive, Suspended). Segments the agent portfolio by operational state."
    - name: "agency_type"
      expr: agency_type
      comment: "Type of travel agency (e.g. Leisure, Corporate, OTA, Wholesale). Enables agency segment mix analysis."
    - name: "booking_volume_tier"
      expr: booking_volume_tier
      comment: "Booking volume tier of the travel agent (e.g. Platinum, Gold, Silver). Supports tiered commission and incentive program management."
    - name: "country_code"
      expr: country_code
      comment: "Country of the travel agency. Enables geographic distribution analysis of travel agent revenue."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used by the travel agent. Supports multi-currency commission and revenue reporting."
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Preferred payment method of the travel agent. Supports payment channel analysis for agent settlements."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Start date of the travel agent contract. Used for contract lifecycle and renewal analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "End date of the travel agent contract. Flags agents with expiring contracts for renewal management."
    - name: "last_booking_date"
      expr: last_booking_date
      comment: "Date of the agent's most recent booking. Used to identify dormant agents and re-engagement opportunities."
  measures:
    - name: "total_travel_agents"
      expr: COUNT(1)
      comment: "Total number of travel agent records. Baseline portfolio size KPI for distribution channel management."
    - name: "total_revenue_generated"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated by travel agents. Primary KPI for measuring travel agent channel contribution to hotel revenue."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across travel agents. Benchmarks commission spend and informs rate negotiation strategy."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to travel agents. Measures financial exposure from agent credit facilities for treasury management."
    - name: "avg_revenue_per_agent"
      expr: AVG(CAST(total_revenue_generated AS DOUBLE))
      comment: "Average revenue generated per travel agent. Identifies high-performing agents and benchmarks portfolio productivity."
    - name: "active_agent_count"
      expr: COUNT(CASE WHEN travel_agent_status = 'Active' THEN 1 END)
      comment: "Number of active travel agents. Tracks the productive agent base for distribution channel capacity planning."
    - name: "active_agent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN travel_agent_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of travel agents with active status. Measures portfolio health and agent engagement rate."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking status change event analytics covering modification patterns, penalty fee collection, revenue impact of changes, SLA compliance, and dispute rates. Used by Revenue Management, Operations, and Finance to monitor booking lifecycle health."
  source: "`travel_hospitality_ecm`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of booking status event (e.g. Cancellation, Modification, No-Show). Core dimension for event-level analysis."
    - name: "modification_type"
      expr: modification_type
      comment: "Type of modification made to the booking (e.g. Date Change, Rate Change, Room Type Change). Enables modification pattern analysis."
    - name: "new_status"
      expr: new_status
      comment: "New booking status after the event. Tracks status transition patterns across the booking lifecycle."
    - name: "previous_status"
      expr: previous_status
      comment: "Previous booking status before the event. Used with new_status to analyze status transition flows."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel through which the status change was initiated. Enables channel-level modification and cancellation analysis."
    - name: "booking_source_code"
      expr: booking_source_code
      comment: "Source code of the booking. Supports source-level event pattern analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the status change event is under dispute. Flags contested events for Finance and Legal review."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the event was processed within SLA. Tracks operational SLA adherence for booking change processing."
    - name: "guest_notification_sent_flag"
      expr: guest_notification_sent_flag
      comment: "Indicates whether the guest was notified of the status change. Tracks communication compliance for guest experience management."
    - name: "event_date"
      expr: event_date
      comment: "Date of the booking status change event. Used for trend analysis of modification and cancellation activity."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of booking status change events. Baseline volume KPI for booking lifecycle activity monitoring."
    - name: "total_penalty_fees_collected"
      expr: SUM(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Total penalty fees collected across all booking status events. Measures financial recovery from cancellations and no-shows."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from booking status change events. Quantifies the net financial effect of modifications and cancellations on the business."
    - name: "avg_rate_difference"
      expr: AVG(CAST(rate_difference_amount AS DOUBLE))
      comment: "Average rate difference amount from booking modifications. Measures the pricing impact of booking changes for revenue management."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of booking status events processed within SLA. Measures operational efficiency and service standard adherence."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of booking status events under dispute. Tracks dispute incidence as a proxy for guest satisfaction and process quality."
    - name: "guest_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status change events where the guest was notified. Measures communication compliance and guest experience standard adherence."
$$;