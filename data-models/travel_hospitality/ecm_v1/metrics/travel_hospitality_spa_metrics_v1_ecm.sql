-- Metric views for domain: spa | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spa appointment metrics tracking booking performance, revenue, cancellations, and guest experience"
  source: "`travel_hospitality_ecm`.`spa`.`appointment`"
  dimensions:
    - name: "appointment_date"
      expr: appointment_date
      comment: "Date of the spa appointment"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (confirmed, completed, cancelled, no-show)"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, phone, walk-in, mobile app)"
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of appointment for trend analysis"
    - name: "appointment_quarter"
      expr: DATE_TRUNC('QUARTER', appointment_date)
      comment: "Quarter of appointment for seasonal analysis"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for appointment cancellation"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicator whether guest failed to show for appointment"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month when appointment was booked"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of spa appointments"
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END)
      comment: "Number of appointments successfully completed"
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END)
      comment: "Number of appointments cancelled by guest or property"
    - name: "no_show_appointments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of appointments where guest did not show"
    - name: "total_prepayment_revenue"
      expr: SUM(CAST(prepayment_amount AS DOUBLE))
      comment: "Total prepayment revenue collected for appointments"
    - name: "avg_prepayment_amount"
      expr: AVG(CAST(prepayment_amount AS DOUBLE))
      comment: "Average prepayment amount per appointment"
    - name: "unique_guests"
      expr: COUNT(DISTINCT appointment_profile_id)
      comment: "Number of unique guests with appointments"
    - name: "unique_therapists"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of unique therapists serving appointments"
    - name: "appointments_with_intake_form"
      expr: COUNT(CASE WHEN intake_form_completed = TRUE THEN 1 END)
      comment: "Number of appointments with completed intake forms"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled - key operational efficiency metric"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in no-show - critical revenue leakage indicator"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments successfully completed - primary service delivery KPI"
    - name: "intake_form_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN intake_form_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with completed intake forms - compliance and guest experience metric"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa revenue and charge metrics tracking financial performance, discounts, and payment patterns"
  source: "`travel_hospitality_ecm`.`spa`.`charge`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date when charge was posted"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (treatment, product, package, service)"
    - name: "posting_status"
      expr: posting_status
      comment: "Status of charge posting (posted, pending, voided)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment for the charge"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_date)
      comment: "Month of charge for revenue trending"
    - name: "charge_quarter"
      expr: DATE_TRUNC('QUARTER', charge_date)
      comment: "Quarter of charge for seasonal revenue analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which charge was posted"
    - name: "gratuity_included_flag"
      expr: gratuity_included_flag
      comment: "Indicator whether gratuity is included in charge"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of spa charges posted"
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total revenue from all spa charges - primary revenue KPI"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to spa charges"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on spa charges"
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected"
    - name: "avg_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge amount per transaction"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all charged items"
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items/services sold"
    - name: "voided_charges"
      expr: COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of charges that were voided"
    - name: "unique_guests_charged"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with spa charges"
    - name: "unique_therapists_generating_revenue"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of unique therapists generating charge revenue"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE) + CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount rate on spa charges - pricing strategy effectiveness metric"
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges voided - operational quality indicator"
    - name: "avg_revenue_per_guest"
      expr: SUM(CAST(total_charge_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT profile_id), 0)
      comment: "Average revenue per unique guest - guest value metric"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership metrics tracking subscription revenue, retention, and member lifecycle"
  source: "`travel_hospitality_ecm`.`spa`.`membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of membership (active, suspended, cancelled, expired)"
    - name: "membership_tier"
      expr: membership_tier
      comment: "Tier level of membership (basic, premium, elite)"
    - name: "membership_type"
      expr: membership_type
      comment: "Type of membership program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month when membership was enrolled"
    - name: "enrollment_quarter"
      expr: DATE_TRUNC('QUARTER', enrollment_date)
      comment: "Quarter when membership was enrolled"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicator whether membership auto-renews"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for membership cancellation"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method on file"
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of spa memberships"
    - name: "active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN 1 END)
      comment: "Number of currently active memberships"
    - name: "cancelled_memberships"
      expr: COUNT(CASE WHEN membership_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled memberships"
    - name: "suspended_memberships"
      expr: COUNT(CASE WHEN membership_status = 'suspended' THEN 1 END)
      comment: "Number of suspended memberships"
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual fee revenue from memberships"
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly recurring revenue from memberships"
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual membership fee"
    - name: "avg_monthly_fee"
      expr: AVG(CAST(monthly_fee AS DOUBLE))
      comment: "Average monthly membership fee"
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees collected"
    - name: "memberships_with_auto_renewal"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of memberships set to auto-renew"
    - name: "unique_member_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles with memberships"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered to members"
    - name: "active_membership_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN membership_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships currently active - retention health indicator"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN membership_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships cancelled - churn metric"
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships with auto-renewal enabled - retention predictor"
    - name: "avg_monthly_recurring_revenue_per_member"
      expr: SUM(CAST(monthly_fee AS DOUBLE)) / NULLIF(COUNT(DISTINCT profile_id), 0)
      comment: "Average MRR per unique member - member value metric"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_retail_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa retail sales metrics tracking product revenue, basket size, and channel performance"
  source: "`travel_hospitality_ecm`.`spa`.`retail_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of retail transaction"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of transaction (completed, pending, refunded, voided)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which sale was made (in-spa, online, mobile)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for sales trending"
    - name: "transaction_quarter"
      expr: DATE_TRUNC('QUARTER', transaction_date)
      comment: "Quarter of transaction for seasonal analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of transaction"
    - name: "refund_reason"
      expr: refund_reason
      comment: "Reason provided for refund if applicable"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of retail transactions"
    - name: "total_retail_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total retail revenue - primary retail performance KPI"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal before tax and service charges"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to retail transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on retail sales"
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on retail transactions"
    - name: "total_quantity_sold"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of retail items sold"
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value - basket size metric"
    - name: "avg_items_per_transaction"
      expr: AVG(CAST(item_count AS DOUBLE))
      comment: "Average number of items per transaction"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers making retail purchases"
    - name: "transactions_with_loyalty_points_earned"
      expr: COUNT(CASE WHEN loyalty_points_earned IS NOT NULL THEN 1 END)
      comment: "Number of transactions earning loyalty points"
    - name: "transactions_with_loyalty_points_redeemed"
      expr: COUNT(CASE WHEN loyalty_points_redeemed IS NOT NULL THEN 1 END)
      comment: "Number of transactions redeeming loyalty points"
    - name: "refunded_transactions"
      expr: COUNT(CASE WHEN transaction_status = 'refunded' THEN 1 END)
      comment: "Number of transactions refunded"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE) + CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount rate on retail sales - promotional effectiveness metric"
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_status = 'refunded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions refunded - product satisfaction indicator"
    - name: "avg_revenue_per_customer"
      expr: SUM(CAST(total_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT profile_id), 0)
      comment: "Average retail revenue per unique customer - customer value metric"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_therapist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist performance and workforce metrics tracking utilization, ratings, and capacity"
  source: "`travel_hospitality_ecm`.`spa`.`therapist`"
  dimensions:
    - name: "therapist_status"
      expr: therapist_status
      comment: "Current employment status of therapist (active, on-leave, terminated)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor)"
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level of therapist"
    - name: "gender"
      expr: gender
      comment: "Gender of therapist"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month when therapist was hired"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year when therapist was hired"
    - name: "tip_eligible_flag"
      expr: tip_eligible_flag
      comment: "Indicator whether therapist is eligible for tips"
  measures:
    - name: "total_therapists"
      expr: COUNT(1)
      comment: "Total number of therapists"
    - name: "active_therapists"
      expr: COUNT(CASE WHEN therapist_status = 'active' THEN 1 END)
      comment: "Number of currently active therapists - workforce capacity metric"
    - name: "avg_guest_rating"
      expr: AVG(CAST(guest_rating_average AS DOUBLE))
      comment: "Average guest rating across all therapists - service quality KPI"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate paid to therapists"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across therapists"
    - name: "therapists_with_expired_license"
      expr: COUNT(CASE WHEN primary_license_expiry_date < CURRENT_DATE THEN 1 END)
      comment: "Number of therapists with expired primary license - compliance risk metric"
    - name: "therapists_needing_certification_renewal"
      expr: COUNT(CASE WHEN next_certification_due_date <= DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of therapists needing certification renewal within 90 days"
    - name: "tip_eligible_therapists"
      expr: COUNT(CASE WHEN tip_eligible_flag = TRUE THEN 1 END)
      comment: "Number of therapists eligible to receive tips"
    - name: "full_time_therapists"
      expr: COUNT(CASE WHEN employment_type = 'full-time' THEN 1 END)
      comment: "Number of full-time therapists"
    - name: "part_time_therapists"
      expr: COUNT(CASE WHEN employment_type = 'part-time' THEN 1 END)
      comment: "Number of part-time therapists"
    - name: "contractor_therapists"
      expr: COUNT(CASE WHEN employment_type = 'contractor' THEN 1 END)
      comment: "Number of contractor therapists"
    - name: "active_therapist_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN therapist_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of therapists currently active - workforce availability metric"
    - name: "license_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_license_expiry_date >= CURRENT_DATE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of therapists with valid licenses - regulatory compliance KPI"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_treatment_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment room utilization and capacity metrics tracking facility efficiency and maintenance"
  source: "`travel_hospitality_ecm`.`spa`.`treatment_room`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of treatment room (available, occupied, maintenance, closed)"
    - name: "room_type"
      expr: room_type
      comment: "Type of treatment room (single, couple, suite, wet room)"
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Maintenance status of room"
    - name: "gender_designation"
      expr: gender_designation
      comment: "Gender designation of room if applicable"
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Indicator whether room is ADA compliant"
    - name: "has_private_shower"
      expr: has_private_shower
      comment: "Indicator whether room has private shower"
    - name: "has_outdoor_access"
      expr: has_outdoor_access
      comment: "Indicator whether room has outdoor access"
  measures:
    - name: "total_treatment_rooms"
      expr: COUNT(1)
      comment: "Total number of treatment rooms - facility capacity metric"
    - name: "available_treatment_rooms"
      expr: COUNT(CASE WHEN operational_status = 'available' THEN 1 END)
      comment: "Number of treatment rooms currently available"
    - name: "occupied_treatment_rooms"
      expr: COUNT(CASE WHEN operational_status = 'occupied' THEN 1 END)
      comment: "Number of treatment rooms currently occupied"
    - name: "rooms_in_maintenance"
      expr: COUNT(CASE WHEN operational_status = 'maintenance' THEN 1 END)
      comment: "Number of rooms currently in maintenance - capacity constraint metric"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of all treatment rooms"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per treatment room"
    - name: "total_ffe_value"
      expr: SUM(CAST(ffe_value AS DOUBLE))
      comment: "Total furniture, fixtures, and equipment value"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for treatment rooms"
    - name: "accessible_rooms"
      expr: COUNT(CASE WHEN accessibility_compliant = TRUE THEN 1 END)
      comment: "Number of ADA-compliant treatment rooms"
    - name: "rooms_with_private_shower"
      expr: COUNT(CASE WHEN has_private_shower = TRUE THEN 1 END)
      comment: "Number of rooms with private shower amenity"
    - name: "rooms_with_outdoor_access"
      expr: COUNT(CASE WHEN has_outdoor_access = TRUE THEN 1 END)
      comment: "Number of rooms with outdoor access"
    - name: "rooms_needing_maintenance"
      expr: COUNT(CASE WHEN next_maintenance_date <= DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Number of rooms needing maintenance within 30 days"
    - name: "room_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'available' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms available for use - facility utilization KPI"
    - name: "room_occupancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'occupied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms currently occupied - real-time utilization metric"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accessibility_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms that are ADA compliant - regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_cancellation_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation analytics tracking patterns, fees, and revenue recovery opportunities"
  source: "`travel_hospitality_ecm`.`spa`.`cancellation_log`"
  dimensions:
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Type of cancellation (guest-initiated, property-initiated, system)"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Coded reason for cancellation"
    - name: "cancelled_by_party"
      expr: cancelled_by_party
      comment: "Party who initiated cancellation (guest, staff, system)"
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was made"
    - name: "late_cancellation_flag"
      expr: late_cancellation_flag
      comment: "Indicator whether cancellation was late per policy"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicator whether cancellation was actually a no-show"
    - name: "cancellation_fee_waived_flag"
      expr: cancellation_fee_waived_flag
      comment: "Indicator whether cancellation fee was waived"
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_timestamp)
      comment: "Month of cancellation for trend analysis"
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellations logged"
    - name: "late_cancellations"
      expr: COUNT(CASE WHEN late_cancellation_flag = TRUE THEN 1 END)
      comment: "Number of late cancellations - policy compliance metric"
    - name: "no_shows"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-shows - revenue leakage indicator"
    - name: "total_cancellation_fees"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fees charged"
    - name: "total_fees_waived"
      expr: SUM(CASE WHEN cancellation_fee_waived_flag = TRUE THEN CAST(cancellation_fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cancellation fees waived"
    - name: "total_original_appointment_value"
      expr: SUM(CAST(original_appointment_value AS DOUBLE))
      comment: "Total value of cancelled appointments - potential revenue loss"
    - name: "total_revenue_recovery"
      expr: SUM(CAST(revenue_recovery_amount AS DOUBLE))
      comment: "Total revenue recovered from cancellations"
    - name: "avg_advance_notice_hours"
      expr: AVG(CAST(advance_notice_hours AS DOUBLE))
      comment: "Average hours of advance notice given for cancellations"
    - name: "cancellations_with_rebooking"
      expr: COUNT(CASE WHEN rebooking_completed_flag = TRUE THEN 1 END)
      comment: "Number of cancellations that resulted in rebooking"
    - name: "cancellations_offered_rebooking"
      expr: COUNT(CASE WHEN rebooking_offer_extended_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where rebooking was offered"
    - name: "late_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_cancellation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that were late - policy adherence metric"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that were no-shows - guest behavior indicator"
    - name: "fee_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_fee_waived_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN cancellation_fee_applicable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of applicable fees that were waived - policy exception metric"
    - name: "rebooking_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rebooking_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN rebooking_offer_extended_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of rebooking offers that converted - revenue recovery effectiveness"
    - name: "revenue_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_appointment_value AS DOUBLE)), 0), 2)
      comment: "Percentage of original appointment value recovered - financial impact mitigation metric"
$$;