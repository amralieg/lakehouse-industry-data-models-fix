-- Metric views for domain: event | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core event booking performance metrics tracking contracted value, attendance, commission, and booking conversion across properties, segments, and channels"
  source: "`travel_hospitality_ecm`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the event booking (e.g., tentative, definite, cancelled)"
    - name: "mice_category"
      expr: mice_category
      comment: "MICE segment classification (Meetings, Incentives, Conferences, Exhibitions)"
    - name: "event_start_date"
      expr: event_start_date
      comment: "Scheduled start date of the event"
    - name: "event_end_date"
      expr: event_end_date
      comment: "Scheduled end date of the event"
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month of event start for trend analysis"
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year of event start for annual comparisons"
    - name: "booking_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when booking was created"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for contracted value and financial metrics"
    - name: "cancellation_policy_code"
      expr: cancellation_policy_code
      comment: "Cancellation policy applied to this booking"
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Whether deposit has been received"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of event bookings"
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Total contracted revenue value across all bookings"
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per booking"
    - name: "total_expected_attendance"
      expr: SUM(CAST(expected_attendance_count AS BIGINT))
      comment: "Total expected attendees across all bookings"
    - name: "total_guaranteed_attendance"
      expr: SUM(CAST(guaranteed_attendance_count AS BIGINT))
      comment: "Total guaranteed attendees across all bookings"
    - name: "total_actual_attendance"
      expr: SUM(CAST(actual_attendance_count AS BIGINT))
      comment: "Total actual attendees across all bookings"
    - name: "avg_expected_attendance"
      expr: AVG(CAST(expected_attendance_count AS DOUBLE))
      comment: "Average expected attendance per booking"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on bookings"
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across bookings"
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total concessions granted to clients"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits required across bookings"
    - name: "total_room_block_count"
      expr: SUM(CAST(room_block_count AS BIGINT))
      comment: "Total room nights blocked for events"
    - name: "total_room_block_pickup"
      expr: SUM(CAST(room_block_pickup_count AS BIGINT))
      comment: "Total room nights actually picked up from blocks"
    - name: "avg_attrition_clause_percentage"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage in contracts"
    - name: "total_attrition_penalty"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalties assessed"
    - name: "bookings_with_deposit_received"
      expr: SUM(CASE WHEN deposit_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bookings where deposit has been received"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with bookings"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts booking events"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event revenue performance metrics tracking actual vs budgeted revenue, variance, payment status, and contribution by category and source"
  source: "`travel_hospitality_ecm`.`event`.`event_revenue`"
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "Primary revenue category (e.g., F&B, AV, Space Rental, Room)"
    - name: "subcategory"
      expr: subcategory
      comment: "Revenue subcategory for detailed analysis"
    - name: "revenue_date"
      expr: revenue_date
      comment: "Date revenue was recognized"
    - name: "revenue_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Month of revenue recognition"
    - name: "revenue_year"
      expr: YEAR(revenue_date)
      comment: "Year of revenue recognition"
    - name: "posting_date"
      expr: posting_date
      comment: "Date revenue was posted to GL"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (e.g., paid, pending, overdue)"
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating revenue"
    - name: "revenue_source"
      expr: revenue_source
      comment: "Source system or channel of revenue"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied"
    - name: "is_voided"
      expr: is_voided
      comment: "Whether this revenue entry has been voided"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center responsible for revenue"
  measures:
    - name: "total_revenue_entries"
      expr: COUNT(1)
      comment: "Total number of revenue line items"
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual revenue recognized"
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted revenue for events"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budgeted revenue"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments applied"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event revenue"
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges applied"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on event revenue"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across revenue items"
    - name: "total_attendee_count"
      expr: SUM(CAST(attendee_count AS BIGINT))
      comment: "Total attendees across revenue-generating events"
    - name: "avg_revenue_per_attendee"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue per attendee"
    - name: "total_group_room_nights"
      expr: SUM(CAST(group_room_nights AS BIGINT))
      comment: "Total group room nights associated with event revenue"
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks"
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from events"
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from events"
    - name: "voided_revenue_count"
      expr: SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END)
      comment: "Count of voided revenue entries"
    - name: "distinct_events"
      expr: COUNT(DISTINCT event_booking_id)
      comment: "Number of distinct events generating revenue"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with event revenue"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event inquiry and lead conversion metrics tracking inquiry volume, qualification, conversion rates, and lost opportunity analysis"
  source: "`travel_hospitality_ecm`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (e.g., new, qualified, converted, lost)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification status"
    - name: "event_type"
      expr: event_type
      comment: "Type of event inquired about"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the inquiry"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which inquiry was received"
    - name: "referral_source"
      expr: referral_source
      comment: "Specific referral source of the inquiry"
    - name: "inquiry_date"
      expr: inquiry_date
      comment: "Date inquiry was received"
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month inquiry was received"
    - name: "inquiry_year"
      expr: YEAR(inquiry_date)
      comment: "Year inquiry was received"
    - name: "preferred_start_date"
      expr: preferred_start_date
      comment: "Client's preferred event start date"
    - name: "preferred_event_month"
      expr: DATE_TRUNC('MONTH', preferred_start_date)
      comment: "Month of preferred event date"
    - name: "lead_score"
      expr: lead_score
      comment: "Lead scoring tier or value"
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason inquiry was lost (if applicable)"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of client budget"
    - name: "catering_required_flag"
      expr: catering_required_flag
      comment: "Whether catering is required"
    - name: "av_equipment_required_flag"
      expr: av_equipment_required_flag
      comment: "Whether AV equipment is required"
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received"
    - name: "converted_inquiries"
      expr: SUM(CASE WHEN inquiry_status = 'converted' THEN 1 ELSE 0 END)
      comment: "Number of inquiries converted to bookings"
    - name: "lost_inquiries"
      expr: SUM(CASE WHEN inquiry_status = 'lost' THEN 1 ELSE 0 END)
      comment: "Number of inquiries lost to competition or cancellation"
    - name: "qualified_inquiries"
      expr: SUM(CASE WHEN qualification_status = 'qualified' THEN 1 ELSE 0 END)
      comment: "Number of inquiries that passed qualification"
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum budget across inquiries"
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget across inquiries"
    - name: "total_estimated_attendance"
      expr: SUM(CAST(estimated_attendance AS BIGINT))
      comment: "Total estimated attendees across all inquiries"
    - name: "avg_estimated_attendance"
      expr: AVG(CAST(estimated_attendance AS DOUBLE))
      comment: "Average estimated attendance per inquiry"
    - name: "total_room_nights_estimate"
      expr: SUM(CAST(room_nights_estimate AS BIGINT))
      comment: "Total estimated room nights from inquiries"
    - name: "inquiries_with_catering"
      expr: SUM(CASE WHEN catering_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inquiries requiring catering"
    - name: "inquiries_with_av"
      expr: SUM(CASE WHEN av_equipment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inquiries requiring AV equipment"
    - name: "inquiries_with_alternate_dates"
      expr: SUM(CASE WHEN alternate_dates_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inquiries with flexible date options"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties receiving inquiries"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT distribution_channel_id)
      comment: "Number of distinct channels generating inquiries"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_lost_business`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost event business analysis tracking lost revenue opportunity, competitive intelligence, and win-back potential by loss reason and competitor"
  source: "`travel_hospitality_ecm`.`event`.`lost_business`"
  dimensions:
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "High-level category of why business was lost"
    - name: "loss_reason_detail"
      expr: loss_reason_detail
      comment: "Detailed reason for losing the business"
    - name: "loss_status"
      expr: loss_status
      comment: "Status of the lost business record"
    - name: "competitor_property_name"
      expr: competitor_property_name
      comment: "Name of competitor who won the business"
    - name: "competitor_property_location"
      expr: competitor_property_location
      comment: "Location of competitor property"
    - name: "event_type"
      expr: event_type
      comment: "Type of event that was lost"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of lost opportunity"
    - name: "lead_source"
      expr: lead_source
      comment: "Original source of the lead"
    - name: "loss_date"
      expr: loss_date
      comment: "Date business was officially lost"
    - name: "loss_month"
      expr: DATE_TRUNC('MONTH', loss_date)
      comment: "Month business was lost"
    - name: "loss_year"
      expr: YEAR(loss_date)
      comment: "Year business was lost"
    - name: "event_start_date"
      expr: event_start_date
      comment: "Planned start date of the lost event"
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month of planned event start"
    - name: "win_back_probability"
      expr: win_back_probability
      comment: "Likelihood of winning back this client"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of estimated revenue"
  measures:
    - name: "total_lost_opportunities"
      expr: COUNT(1)
      comment: "Total number of lost business opportunities"
    - name: "total_estimated_revenue_lost"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue from lost opportunities"
    - name: "total_estimated_room_revenue_lost"
      expr: SUM(CAST(estimated_room_revenue AS DOUBLE))
      comment: "Total estimated room revenue lost"
    - name: "total_estimated_fb_revenue_lost"
      expr: SUM(CAST(estimated_fb_revenue AS DOUBLE))
      comment: "Total estimated F&B revenue lost"
    - name: "total_estimated_meeting_space_revenue_lost"
      expr: SUM(CAST(estimated_meeting_space_revenue AS DOUBLE))
      comment: "Total estimated meeting space revenue lost"
    - name: "total_estimated_other_revenue_lost"
      expr: SUM(CAST(estimated_other_revenue AS DOUBLE))
      comment: "Total estimated other revenue lost"
    - name: "avg_estimated_total_revenue_lost"
      expr: AVG(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Average estimated revenue per lost opportunity"
    - name: "total_estimated_room_nights_lost"
      expr: SUM(CAST(estimated_room_nights AS BIGINT))
      comment: "Total estimated room nights from lost business"
    - name: "total_estimated_peak_rooms_lost"
      expr: SUM(CAST(estimated_peak_rooms AS BIGINT))
      comment: "Total estimated peak rooms from lost business"
    - name: "avg_quoted_group_adr"
      expr: AVG(CAST(quoted_group_adr AS DOUBLE))
      comment: "Average group ADR quoted on lost opportunities"
    - name: "avg_competitor_quoted_rate"
      expr: AVG(CAST(competitor_quoted_rate AS DOUBLE))
      comment: "Average rate quoted by competitors who won"
    - name: "distinct_competitors"
      expr: COUNT(DISTINCT competitor_property_name)
      comment: "Number of distinct competitors winning business"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with lost business"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts with lost opportunities"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event invoice and accounts receivable metrics tracking billing, payment collection, outstanding balances, and dispute resolution performance"
  source: "`travel_hospitality_ecm`.`event`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, issued, paid, overdue, disputed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used or expected"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with client"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month invoice was issued"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year invoice was issued"
    - name: "payment_due_date"
      expr: payment_due_date
      comment: "Date payment is due"
    - name: "payment_received_date"
      expr: payment_received_date
      comment: "Date payment was received"
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start of billing period"
    - name: "billing_period_end_date"
      expr: billing_period_end_date
      comment: "End of billing period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of invoice amounts"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for invoice dispute (if applicable)"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code of billing address"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of event invoices"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount invoiced across all invoices"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount paid by clients"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all invoices"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal before taxes and service charges"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices"
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on invoices"
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue invoiced"
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue invoiced"
    - name: "total_av_equipment_revenue"
      expr: SUM(CAST(av_equipment_amount AS DOUBLE))
      comment: "Total AV equipment revenue invoiced"
    - name: "total_space_rental_revenue"
      expr: SUM(CAST(space_rental_amount AS DOUBLE))
      comment: "Total space rental revenue invoiced"
    - name: "total_miscellaneous_charges"
      expr: SUM(CAST(miscellaneous_charges_amount AS DOUBLE))
      comment: "Total miscellaneous charges invoiced"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount"
    - name: "disputed_invoices"
      expr: SUM(CASE WHEN dispute_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices that have been disputed"
    - name: "paid_invoices"
      expr: SUM(CASE WHEN invoice_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Count of fully paid invoices"
    - name: "overdue_invoices"
      expr: SUM(CASE WHEN invoice_status = 'overdue' THEN 1 ELSE 0 END)
      comment: "Count of overdue invoices"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts invoiced"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties issuing invoices"
    - name: "distinct_events"
      expr: COUNT(DISTINCT event_booking_id)
      comment: "Number of distinct events invoiced"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and capacity metrics tracking space availability, capacity configurations, rental rates, and operational status across properties"
  source: "`travel_hospitality_ecm`.`event`.`function_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of function space (e.g., ballroom, boardroom, outdoor)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space"
    - name: "divisible"
      expr: divisible
      comment: "Whether space can be divided into smaller sections"
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Whether space meets accessibility standards"
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether space has natural light"
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Whether space is outdoor or has outdoor access"
    - name: "catering_kitchen_access"
      expr: catering_kitchen_access
      comment: "Whether space has direct catering kitchen access"
    - name: "climate_control"
      expr: climate_control
      comment: "Type of climate control available"
    - name: "internet_connectivity"
      expr: internet_connectivity
      comment: "Type of internet connectivity available"
    - name: "av_infrastructure"
      expr: av_infrastructure
      comment: "AV infrastructure capabilities"
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level where space is located"
  measures:
    - name: "total_function_spaces"
      expr: COUNT(1)
      comment: "Total number of function spaces"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of function space inventory"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space"
    - name: "total_theater_capacity"
      expr: SUM(CAST(capacity_theater AS BIGINT))
      comment: "Total theater-style seating capacity"
    - name: "total_banquet_capacity"
      expr: SUM(CAST(capacity_banquet AS BIGINT))
      comment: "Total banquet-style seating capacity"
    - name: "total_classroom_capacity"
      expr: SUM(CAST(capacity_classroom AS BIGINT))
      comment: "Total classroom-style seating capacity"
    - name: "total_reception_capacity"
      expr: SUM(CAST(capacity_reception AS BIGINT))
      comment: "Total reception-style standing capacity"
    - name: "total_u_shape_capacity"
      expr: SUM(CAST(capacity_u_shape AS BIGINT))
      comment: "Total U-shape seating capacity"
    - name: "total_hollow_square_capacity"
      expr: SUM(CAST(capacity_hollow_square AS BIGINT))
      comment: "Total hollow-square seating capacity"
    - name: "total_cabaret_capacity"
      expr: SUM(CAST(capacity_cabaret AS BIGINT))
      comment: "Total cabaret-style seating capacity"
    - name: "avg_ceiling_height"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height in feet"
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate"
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate"
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate"
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required in hours"
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time required in hours"
    - name: "divisible_spaces"
      expr: SUM(CASE WHEN divisible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spaces that can be divided"
    - name: "accessible_spaces"
      expr: SUM(CASE WHEN accessibility_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accessibility-compliant spaces"
    - name: "spaces_with_natural_light"
      expr: SUM(CASE WHEN natural_light_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spaces with natural light"
    - name: "outdoor_spaces"
      expr: SUM(CASE WHEN outdoor_space = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outdoor or outdoor-accessible spaces"
    - name: "spaces_with_kitchen_access"
      expr: SUM(CASE WHEN catering_kitchen_access = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spaces with direct catering kitchen access"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with function space"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event contract financial and compliance metrics tracking total contracted revenue by category, deposit schedules, attrition thresholds, and contract execution status"
  source: "`travel_hospitality_ecm`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g., draft, executed, amended, cancelled)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., standard, master, custom)"
    - name: "execution_date"
      expr: execution_date
      comment: "Date contract was executed"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month contract was executed"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year contract was executed"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Contract effective start date"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Contract effective end date"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of contract amounts"
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether contract underwent legal review"
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Whether credit approval was obtained"
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Whether master account billing applies"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of event contracts"
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total contracted revenue across all contracts"
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total contracted room revenue"
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total contracted F&B revenue"
    - name: "total_space_rental_revenue"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total contracted space rental revenue"
    - name: "total_av_equipment_revenue"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total contracted AV equipment revenue"
    - name: "total_other_revenue"
      expr: SUM(CAST(other_revenue AS DOUBLE))
      comment: "Total contracted other revenue"
    - name: "avg_contracted_revenue"
      expr: AVG(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Average contracted revenue per contract"
    - name: "total_initial_deposit"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposit amounts across contracts"
    - name: "avg_initial_deposit"
      expr: AVG(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Average initial deposit amount per contract"
    - name: "avg_attrition_threshold"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage"
    - name: "contracts_with_legal_review"
      expr: SUM(CASE WHEN legal_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts that underwent legal review"
    - name: "contracts_with_credit_approval"
      expr: SUM(CASE WHEN credit_approval_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with credit approval"
    - name: "master_account_contracts"
      expr: SUM(CASE WHEN master_account_billing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts using master account billing"
    - name: "distinct_events"
      expr: COUNT(DISTINCT event_booking_id)
      comment: "Number of distinct events with contracts"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order execution and revenue metrics tracking BEO status, estimated vs actual revenue, setup requirements, and operational readiness"
  source: "`travel_hospitality_ecm`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (e.g., draft, confirmed, completed, cancelled)"
    - name: "function_type"
      expr: function_type
      comment: "Type of function (e.g., breakfast, lunch, dinner, reception, meeting)"
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup style (e.g., theater, banquet, classroom)"
    - name: "event_date"
      expr: event_date
      comment: "Date of the event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of the event"
    - name: "issued_date"
      expr: issued_date
      comment: "Date BEO was issued"
    - name: "confirmed_date"
      expr: confirmed_date
      comment: "Date BEO was confirmed"
    - name: "completed_date"
      expr: completed_date
      comment: "Date BEO was completed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
    - name: "beverage_package"
      expr: beverage_package
      comment: "Beverage package selected"
  measures:
    - name: "total_beos"
      expr: COUNT(1)
      comment: "Total number of Banquet Event Orders"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue from BEOs"
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue from completed BEOs"
    - name: "avg_estimated_revenue"
      expr: AVG(CAST(estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per BEO"
    - name: "avg_actual_revenue"
      expr: AVG(CAST(actual_revenue AS DOUBLE))
      comment: "Average actual revenue per BEO"
    - name: "total_expected_attendance"
      expr: SUM(CAST(expected_attendance AS BIGINT))
      comment: "Total expected attendance across BEOs"
    - name: "total_guaranteed_attendance"
      expr: SUM(CAST(guaranteed_attendance AS BIGINT))
      comment: "Total guaranteed attendance across BEOs"
    - name: "avg_expected_attendance"
      expr: AVG(CAST(expected_attendance AS DOUBLE))
      comment: "Average expected attendance per BEO"
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage"
    - name: "avg_tax_percentage"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax percentage"
    - name: "confirmed_beos"
      expr: SUM(CASE WHEN beo_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Count of confirmed BEOs"
    - name: "completed_beos"
      expr: SUM(CASE WHEN beo_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed BEOs"
    - name: "distinct_events"
      expr: COUNT(DISTINCT event_booking_id)
      comment: "Number of distinct events with BEOs"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with BEOs"
    - name: "distinct_meeting_spaces"
      expr: COUNT(DISTINCT meeting_space_id)
      comment: "Number of distinct meeting spaces used"
$$;