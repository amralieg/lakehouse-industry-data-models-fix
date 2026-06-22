-- Metric views for domain: spa | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spa appointment performance metrics covering booking volume, revenue, cancellations, no-shows, and prepayment capture. Primary operational KPI view for spa directors and revenue managers."
  source: "`vibe_travel_hospitality_v1`.`spa`.`appointment`"
  dimensions:
    - name: "appointment_date"
      expr: appointment_date
      comment: "Date of the appointment, used for daily/weekly/monthly trend analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (confirmed, completed, cancelled, no-show) for funnel analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, phone, walk-in) for channel mix analysis."
    - name: "therapist_gender_preference"
      expr: therapist_gender_preference
      comment: "Guest preference for therapist gender, used for staffing and satisfaction analysis."
    - name: "pressure_preference"
      expr: pressure_preference
      comment: "Guest pressure preference (light, medium, deep) for service personalization insights."
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month bucket for appointment date, enabling monthly trend reporting."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointment records. Baseline volume KPI for spa capacity and demand planning."
    - name: "total_prepayment_amount"
      expr: SUM(CAST(prepayment_amount AS DOUBLE))
      comment: "Total prepayment revenue collected at booking. Indicates advance revenue capture and commitment level."
    - name: "avg_prepayment_amount"
      expr: AVG(CAST(prepayment_amount AS DOUBLE))
      comment: "Average prepayment per appointment. Benchmarks deposit policy effectiveness."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of appointments where the guest did not arrive. Drives no-show policy and overbooking decisions."
    - name: "no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in no-shows. High rates signal need for deposit or reminder policy changes."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cancelled appointments. Tracks demand volatility and policy adherence."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled. Informs cancellation policy tightening and revenue protection."
    - name: "intake_form_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN intake_form_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with completed intake forms. Drives health & safety compliance and guest experience quality."
    - name: "distinct_therapists_utilized"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of distinct therapists assigned to appointments. Indicates workforce utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa revenue and charge analytics covering total revenue, discounts, taxes, service charges, and gratuity. Primary financial performance view for spa finance and operations leadership."
  source: "`vibe_travel_hospitality_v1`.`spa`.`charge`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date the charge was posted, used for daily revenue reporting."
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (treatment, retail, package, gratuity) for revenue category analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the charge posting (posted, voided, pending) for revenue integrity monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge for multi-currency revenue reporting."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for financial categorization and P&L mapping."
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_date)
      comment: "Month bucket for charge date, enabling monthly revenue trend analysis."
  measures:
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross revenue from all spa charges. Primary top-line revenue KPI for spa P&L."
    - name: "avg_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge amount per transaction. Benchmarks spend per visit and pricing effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all charges. Tracks promotional spend and margin erosion."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(unit_price AS DOUBLE) * CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross charge value. Measures promotional intensity and pricing discipline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on spa charges. Required for tax compliance reporting."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected. Tracks ancillary revenue and gratuity pool contributions."
    - name: "net_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE) - CAST(discount_amount AS DOUBLE) - CAST(tax_amount AS DOUBLE))
      comment: "Net revenue after discounts and taxes. Core profitability metric for spa operations."
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of voided charges. High void rates indicate operational issues or fraud risk."
    - name: "voided_revenue_amount"
      expr: SUM(CASE WHEN voided_timestamp IS NOT NULL THEN total_charge_amount ELSE 0 END)
      comment: "Total revenue value of voided charges. Quantifies revenue at risk from voids."
    - name: "distinct_guests_charged"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with charges. Measures revenue-generating guest reach."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership portfolio analytics covering active memberships, fee revenue, renewal rates, and discount exposure. Strategic KPI view for membership program management and revenue planning."
  source: "`vibe_travel_hospitality_v1`.`spa`.`membership`"
  dimensions:
    - name: "membership_type"
      expr: membership_type
      comment: "Type of spa membership (annual, monthly, corporate) for portfolio segmentation."
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the membership (active, suspended, cancelled, expired) for lifecycle analysis."
    - name: "tier"
      expr: tier
      comment: "Membership tier level for premium vs. standard segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of membership fees for multi-currency revenue reporting."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of membership enrollment for cohort and acquisition trend analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the membership auto-renews. Drives retention and churn risk segmentation."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total membership records. Baseline portfolio size KPI."
    - name: "active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN 1 END)
      comment: "Number of currently active memberships. Primary membership health KPI."
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual membership fee revenue. Core recurring revenue KPI for membership program P&L."
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly membership fee revenue. Tracks MRR (monthly recurring revenue) for the spa."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual membership fee. Benchmarks pricing and tier mix effectiveness."
    - name: "total_discount_exposure"
      expr: SUM(CAST(discount_percentage AS DOUBLE) * CAST(annual_fee AS DOUBLE) / 100.0)
      comment: "Estimated total revenue foregone due to membership discounts. Quantifies promotional cost."
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees collected. Tracks contract enforcement and churn cost recovery."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_date IS NOT NULL THEN 1 END)
      comment: "Number of cancelled memberships. Drives churn analysis and retention intervention."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships cancelled. Key retention health metric for membership program leadership."
    - name: "auto_renewal_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships enrolled in auto-renewal. Higher rates reduce churn and improve revenue predictability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_retail_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa retail sales analytics covering revenue, discounts, taxes, and guest purchasing behavior. Supports retail strategy, inventory investment, and promotional effectiveness decisions."
  source: "`vibe_travel_hospitality_v1`.`spa`.`retail_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the retail transaction for daily and trend-based sales reporting."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, refunded, voided) for revenue integrity analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the retail sale occurred (in-spa, online, package) for channel mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency retail revenue reporting."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month bucket for transaction date, enabling monthly retail revenue trend analysis."
  measures:
    - name: "total_retail_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross retail revenue. Primary top-line KPI for spa retail P&L."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-service-charge retail revenue. Used for net revenue and margin analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on retail transactions. Tracks promotional spend and margin impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on retail sales. Required for tax compliance and remittance reporting."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on retail transactions. Tracks ancillary revenue contribution."
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average retail transaction value. Benchmarks basket size and upsell effectiveness."
    - name: "total_quantity_sold"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units sold across all retail transactions. Drives inventory replenishment and demand planning."
    - name: "distinct_retail_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests making retail purchases. Measures retail penetration of the spa guest base."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE) + CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross retail value. Measures promotional intensity and pricing discipline."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist workforce utilization and scheduling efficiency metrics. Enables spa operations leadership to optimize staffing, reduce idle time, and manage overtime costs."
  source: "`vibe_travel_hospitality_v1`.`spa`.`therapist_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the therapist schedule for daily workforce planning and trend analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (published, confirmed, cancelled) for schedule integrity monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (morning, afternoon, evening, split) for shift mix and coverage analysis."
    - name: "primary_treatment_specialty"
      expr: primary_treatment_specialty
      comment: "Therapist's primary treatment specialty for skill-based capacity planning."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Whether the therapist is eligible for overtime on this schedule. Drives labor cost management."
    - name: "schedule_month"
      expr: DATE_TRUNC('MONTH', schedule_date)
      comment: "Month bucket for schedule date, enabling monthly workforce trend analysis."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total therapist hours scheduled. Primary capacity planning KPI for spa staffing."
    - name: "total_booked_hours"
      expr: SUM(CAST(total_booked_hours AS DOUBLE))
      comment: "Total therapist hours with confirmed bookings. Measures demand against available capacity."
    - name: "total_available_hours"
      expr: SUM(CAST(total_available_hours AS DOUBLE))
      comment: "Total therapist hours available for booking. Tracks open capacity for revenue opportunity analysis."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked by therapists. Used for payroll accuracy and productivity benchmarking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred. Drives labor cost management and scheduling optimization."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average therapist utilization rate (booked hours / available hours). Core efficiency KPI for spa operations."
    - name: "max_utilization_percentage"
      expr: MAX(utilization_percentage)
      comment: "Peak therapist utilization rate. Identifies capacity ceiling and burnout risk."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cancelled therapist schedules. Tracks schedule reliability and operational disruption."
    - name: "distinct_therapists_scheduled"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of unique therapists scheduled. Measures workforce breadth and scheduling coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_cancellation_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa appointment cancellation analytics covering fee collection, waiver rates, revenue recovery, and rebooking success. Informs cancellation policy design and revenue protection strategy."
  source: "`vibe_travel_hospitality_v1`.`spa`.`cancellation_log`"
  dimensions:
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Type of cancellation (guest-initiated, no-show, weather, operational) for root cause analysis."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Coded reason for cancellation for structured trend analysis and policy response."
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which the cancellation was made (phone, app, front desk) for process improvement."
    - name: "cancelled_by_party"
      expr: cancelled_by_party
      comment: "Party who initiated the cancellation (guest, property, therapist) for accountability analysis."
    - name: "late_cancellation_flag"
      expr: late_cancellation_flag
      comment: "Whether the cancellation was made within the late-cancellation window. Drives fee enforcement analysis."
    - name: "appointment_scheduled_date"
      expr: appointment_scheduled_date
      comment: "Original scheduled date of the cancelled appointment for demand impact analysis."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation records. Baseline volume KPI for cancellation trend monitoring."
    - name: "total_cancellation_fee_revenue"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fees collected. Measures revenue recovery from policy enforcement."
    - name: "avg_cancellation_fee"
      expr: AVG(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Average cancellation fee per cancellation event. Benchmarks fee policy effectiveness."
    - name: "fee_waiver_count"
      expr: COUNT(CASE WHEN cancellation_fee_waived_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where the fee was waived. Tracks exception management and policy consistency."
    - name: "fee_waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_fee_waived_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN cancellation_fee_applicable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of applicable cancellation fees that were waived. High rates indicate policy enforcement gaps."
    - name: "total_original_appointment_value_lost"
      expr: SUM(CAST(original_appointment_value AS DOUBLE))
      comment: "Total value of cancelled appointments. Quantifies gross revenue at risk from cancellations."
    - name: "total_revenue_recovered"
      expr: SUM(CAST(revenue_recovery_amount AS DOUBLE))
      comment: "Total revenue recovered through fees or rebooking. Measures net revenue protection effectiveness."
    - name: "rebooking_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rebooking_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that resulted in a successful rebooking. Key retention and revenue recovery KPI."
    - name: "late_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_cancellation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations classified as late. Drives policy tightening and advance notice requirements."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_day_pass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Day pass sales and revenue analytics for spa access products. Supports pricing strategy, channel mix optimization, and demand forecasting for non-member spa access."
  source: "`vibe_travel_hospitality_v1`.`spa`.`day_pass`"
  dimensions:
    - name: "pass_date"
      expr: pass_date
      comment: "Date of the day pass for daily demand and revenue trend analysis."
    - name: "pass_type"
      expr: pass_type
      comment: "Type of day pass (standard, premium, couples, family) for product mix analysis."
    - name: "pass_status"
      expr: pass_status
      comment: "Current status of the day pass (active, used, cancelled, expired) for utilization tracking."
    - name: "booking_source"
      expr: booking_source
      comment: "Source of the day pass booking for channel attribution and marketing ROI analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (hotel guest, external, member) for segment-based revenue analysis."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the guest is a loyalty member. Enables loyalty vs. non-loyalty revenue comparison."
    - name: "pass_month"
      expr: DATE_TRUNC('MONTH', pass_date)
      comment: "Month bucket for pass date, enabling monthly demand trend analysis."
  measures:
    - name: "total_day_passes_sold"
      expr: COUNT(1)
      comment: "Total day passes sold. Baseline volume KPI for spa access demand."
    - name: "total_day_pass_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from day pass sales. Primary revenue KPI for spa access products."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax day pass revenue. Used for net revenue and margin analysis."
    - name: "avg_day_pass_revenue"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per day pass. Benchmarks pricing effectiveness and upsell success."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on day passes. Tracks promotional spend and margin erosion."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on day passes. Monitors refund exposure and policy compliance."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cancelled day passes. Tracks demand volatility and revenue at risk."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of day passes cancelled. Informs cancellation policy and overbooking strategy."
    - name: "distinct_day_pass_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests purchasing day passes. Measures spa reach beyond hotel guests."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_fitness_class_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fitness class session performance metrics covering attendance, capacity utilization, revenue, and waitlist demand. Enables fitness program directors to optimize scheduling and pricing."
  source: "`vibe_travel_hospitality_v1`.`spa`.`fitness_class_session`"
  dimensions:
    - name: "session_date"
      expr: session_date
      comment: "Date of the fitness class session for daily and weekly scheduling analysis."
    - name: "fitness_class_session_status"
      expr: fitness_class_session_status
      comment: "Status of the session (scheduled, completed, cancelled) for operational monitoring."
    - name: "session_type"
      expr: session_type
      comment: "Type of fitness session (yoga, pilates, HIIT, aqua) for class mix and demand analysis."
    - name: "difficulty_level"
      expr: difficulty_level
      comment: "Difficulty level of the session for guest segmentation and program design."
    - name: "class_format"
      expr: class_format
      comment: "Format of the class (in-person, virtual, hybrid) for channel and format mix analysis."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month bucket for session date, enabling monthly fitness program trend analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of fitness class sessions. Baseline volume KPI for program scheduling."
    - name: "total_session_revenue"
      expr: SUM(CAST(session_price AS DOUBLE))
      comment: "Total revenue from fitness class sessions. Primary revenue KPI for fitness program P&L."
    - name: "avg_session_price"
      expr: AVG(CAST(session_price AS DOUBLE))
      comment: "Average price per fitness session. Benchmarks pricing strategy and tier differentiation."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END)
      comment: "Number of cancelled fitness sessions. Tracks schedule reliability and guest experience impact."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fitness sessions cancelled. Informs scheduling reliability and instructor management."
    - name: "online_booking_enabled_sessions"
      expr: COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END)
      comment: "Number of sessions available for online booking. Tracks digital channel readiness."
    - name: "loyalty_eligible_sessions"
      expr: COUNT(CASE WHEN loyalty_points_eligible_flag = TRUE THEN 1 END)
      comment: "Number of sessions eligible for loyalty points. Measures loyalty program integration in fitness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_retail_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa retail inventory health metrics covering stock levels, inventory value, reorder triggers, and variance. Enables procurement and operations teams to optimize stock investment and prevent stockouts."
  source: "`vibe_travel_hospitality_v1`.`spa`.`retail_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (in-stock, low-stock, out-of-stock, expired) for stock health monitoring."
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location of the inventory for location-based stock management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of inventory valuation for multi-currency reporting."
    - name: "reorder_triggered_flag"
      expr: reorder_triggered_flag
      comment: "Whether a reorder has been triggered for this inventory item. Drives procurement action."
    - name: "last_physical_count_date"
      expr: last_physical_count_date
      comment: "Date of last physical inventory count for audit and accuracy tracking."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Total value of spa retail inventory on hand. Primary balance sheet KPI for inventory investment."
    - name: "total_current_stock_quantity"
      expr: SUM(CAST(current_stock_quantity AS DOUBLE))
      comment: "Total units currently in stock across all retail products. Baseline inventory volume KPI."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total units available for sale (excluding reserved). Drives sales capacity and replenishment planning."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total units reserved but not yet sold. Tracks committed inventory and fulfillment risk."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total inventory variance (physical count vs. system). Measures shrinkage, theft, and counting accuracy."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory items. Benchmarks procurement efficiency and cost trends."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average retail price per unit. Used for margin analysis alongside average unit cost."
    - name: "reorder_triggered_count"
      expr: COUNT(CASE WHEN reorder_triggered_flag = TRUE THEN 1 END)
      comment: "Number of inventory items with active reorder triggers. Drives procurement prioritization."
    - name: "avg_gross_margin_per_unit"
      expr: AVG(CAST(unit_retail_price AS DOUBLE) - CAST(unit_cost AS DOUBLE))
      comment: "Average gross margin per unit (retail price minus cost). Core profitability KPI for retail product mix decisions."
    - name: "total_replenishment_quantity"
      expr: SUM(CAST(last_replenishment_quantity AS DOUBLE))
      comment: "Total units replenished in the last replenishment cycle. Tracks supply chain throughput."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_golf_tee_time`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Golf tee time booking and revenue analytics covering green fees, ancillary charges, and cancellation patterns. Supports golf operations leadership in pricing, capacity, and ancillary revenue optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`golf_tee_time`"
  dimensions:
    - name: "tee_time_date"
      expr: tee_time_date
      comment: "Date of the tee time for daily demand and revenue trend analysis."
    - name: "golf_tee_time_status"
      expr: golf_tee_time_status
      comment: "Status of the tee time booking (confirmed, completed, cancelled, no-show) for operational monitoring."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied (rack, member, promotional, group) for revenue mix analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the tee time was booked for channel attribution analysis."
    - name: "tee_time_month"
      expr: DATE_TRUNC('MONTH', tee_time_date)
      comment: "Month bucket for tee time date, enabling monthly golf revenue trend analysis."
  measures:
    - name: "total_tee_times"
      expr: COUNT(1)
      comment: "Total tee time bookings. Baseline volume KPI for golf demand planning."
    - name: "total_green_fee_revenue"
      expr: SUM(CAST(green_fee_per_player AS DOUBLE))
      comment: "Total green fee revenue collected. Primary golf revenue KPI."
    - name: "total_cart_fee_revenue"
      expr: SUM(CAST(cart_fee_per_cart AS DOUBLE))
      comment: "Total cart rental fee revenue. Tracks ancillary golf revenue contribution."
    - name: "total_caddie_fee_revenue"
      expr: SUM(CAST(caddie_fee_per_caddie AS DOUBLE))
      comment: "Total caddie fee revenue. Measures premium service uptake and ancillary revenue."
    - name: "total_club_rental_fee_revenue"
      expr: SUM(CAST(club_rental_fee_per_set AS DOUBLE))
      comment: "Total club rental fee revenue. Tracks equipment rental as an ancillary revenue stream."
    - name: "total_golf_revenue"
      expr: SUM(CAST(total_charge AS DOUBLE))
      comment: "Total gross golf revenue including all fees. Primary top-line KPI for golf operations P&L."
    - name: "avg_revenue_per_tee_time"
      expr: AVG(CAST(total_charge AS DOUBLE))
      comment: "Average total revenue per tee time booking. Benchmarks yield and upsell effectiveness."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cancelled tee times. Tracks demand volatility and revenue at risk."
    - name: "weather_cancellation_count"
      expr: COUNT(CASE WHEN weather_cancellation_flag = TRUE THEN 1 END)
      comment: "Number of tee times cancelled due to weather. Informs weather risk management and refund policy."
    - name: "cart_rental_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cart_rental_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tee times with cart rental. Measures ancillary upsell penetration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_class_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa fitness class enrollment analytics covering enrollment volume, revenue, no-shows, and waitlist demand. Enables class program managers to optimize capacity, pricing, and guest experience."
  source: "`vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (enrolled, waitlisted, cancelled, attended, no-show) for funnel analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the enrollment was made (app, front desk, phone) for channel mix analysis."
    - name: "spa_class_enrollment_status"
      expr: spa_class_enrollment_status
      comment: "Operational status of the enrollment record for data quality and lifecycle tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of enrollment charges for multi-currency revenue reporting."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_timestamp)
      comment: "Month of enrollment for cohort and demand trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total class enrollment records. Baseline volume KPI for fitness program demand."
    - name: "total_enrollment_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from class enrollments. Primary revenue KPI for fitness class program P&L."
    - name: "total_net_enrollment_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts from class enrollments. Core profitability KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on class enrollments. Tracks promotional spend and margin impact."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of enrolled guests who did not attend. Drives no-show fee policy and capacity management."
    - name: "no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments resulting in no-shows. Key class capacity efficiency metric."
    - name: "total_no_show_fee_revenue"
      expr: SUM(CASE WHEN no_show_fee_waived_flag = FALSE THEN no_show_fee_amount ELSE 0 END)
      comment: "Total no-show fees collected (excluding waived fees). Measures revenue recovery from no-show policy."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cancelled enrollments. Tracks demand volatility and class fill rate risk."
    - name: "distinct_enrolled_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests enrolled in fitness classes. Measures fitness program reach."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_appointment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa appointment package booking analytics covering package revenue, discounts, cancellations, and loyalty engagement. Supports package pricing strategy and bundled offer performance management."
  source: "`vibe_travel_hospitality_v1`.`spa`.`appointment_package`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current booking status of the appointment package (confirmed, completed, cancelled) for lifecycle analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the package was booked for channel attribution and mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package booking for multi-currency revenue reporting."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the package (redeemed, partially redeemed, unredeemed) for utilization analysis."
    - name: "booking_date"
      expr: booking_date
      comment: "Date the package was booked for demand trend and lead time analysis."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month bucket for booking date, enabling monthly package revenue trend analysis."
  measures:
    - name: "total_package_bookings"
      expr: COUNT(1)
      comment: "Total appointment package bookings. Baseline volume KPI for package demand."
    - name: "total_package_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from appointment package bookings. Primary package P&L KPI."
    - name: "total_package_price_revenue"
      expr: SUM(CAST(package_price AS DOUBLE))
      comment: "Total package price revenue before add-ons. Benchmarks core package pricing performance."
    - name: "total_addon_revenue"
      expr: SUM(CAST(addon_services_amount AS DOUBLE))
      comment: "Total add-on service revenue on packages. Measures upsell effectiveness within package bookings."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on package bookings. Tracks promotional spend and margin erosion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on package bookings. Required for tax compliance reporting."
    - name: "avg_package_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total value per package booking. Benchmarks package pricing and mix effectiveness."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of cancelled package bookings. Tracks revenue at risk from package cancellations."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of package bookings cancelled. Informs package cancellation policy design."
    - name: "distinct_package_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests booking appointment packages. Measures package program reach."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist performance and workforce metrics tracking utilization, ratings, and capacity"
  source: "`vibe_travel_hospitality_v1`.`spa`.`therapist`"
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

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_treatment_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment room utilization and capacity metrics tracking facility efficiency and maintenance"
  source: "`vibe_travel_hospitality_v1`.`spa`.`treatment_room`"
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