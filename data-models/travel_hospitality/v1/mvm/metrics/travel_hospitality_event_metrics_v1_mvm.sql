-- Metric views for domain: event | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over event bookings capturing pipeline value, conversion health, attrition exposure, and revenue yield for the MICE and group-events business. Used by Sales, Revenue Management, and C-suite to steer group-sales strategy."
  source: "`travel_hospitality_ecm`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the event booking (e.g. Tentative, Definite, Cancelled, Lost) — primary segmentation for pipeline analysis."
    - name: "mice_category"
      expr: mice_category
      comment: "MICE classification of the event (Meetings, Incentives, Conferences, Exhibitions) — drives segment-level revenue reporting."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the event is scheduled to begin — used for demand forecasting and pacing analysis."
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year the event is scheduled to begin — supports annual trend and YoY comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking is denominated — required for multi-currency revenue reporting."
    - name: "booking_source_id"
      expr: booking_source_id
      comment: "Foreign key to the booking source — enables channel-mix analysis for group sales."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the event booking — supports property-level performance benchmarking."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment classification of the booking — used for segment-level revenue and conversion reporting."
    - name: "inquiry_date_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the initial inquiry was received — used to measure lead-to-booking cycle time trends."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Indicates whether the deposit has been received — used to assess financial commitment and booking quality."
  measures:
    - name: "total_event_bookings"
      expr: COUNT(1)
      comment: "Total number of event bookings in the period — baseline volume KPI for group-sales pipeline tracking."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Sum of all contracted event values — primary revenue pipeline measure used in quarterly business reviews."
    - name: "avg_contracted_value_per_booking"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per event booking — indicates deal size trends and mix shift between large and small events."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected across event bookings — measures financial commitment secured from group clients."
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalties assessed — quantifies revenue leakage from underperforming room blocks and attendance shortfalls."
    - name: "avg_attrition_clause_percentage"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition clause percentage across bookings — informs contract risk exposure and negotiation benchmarks."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid to booking intermediaries — used to evaluate channel cost and net revenue yield."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across event bookings — benchmarks intermediary cost by channel and segment."
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total concessions granted to event clients — measures discounting pressure and its impact on net contracted value."
    - name: "deposit_received_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deposit_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings with deposit received — indicates booking quality and financial commitment rate in the pipeline."
    - name: "avg_lead_to_contract_days"
      expr: AVG(DATEDIFF(contract_signed_date, inquiry_date))
      comment: "Average number of days from initial inquiry to signed contract — measures sales cycle efficiency for group events."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance KPI layer over event revenue postings, covering actual vs. budgeted revenue, service charges, taxes, and per-attendee yield. Core view for Revenue Management and Finance to evaluate event P&L."
  source: "`travel_hospitality_ecm`.`event`.`event_revenue`"
  filter: is_voided = FALSE
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "High-level revenue category (e.g. F&B, Space Rental, AV, Room Block) — primary dimension for revenue-mix analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating the revenue (e.g. Conference, Wedding, Corporate Meeting) — used for segment-level yield benchmarking."
    - name: "revenue_date_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Month of revenue recognition — supports monthly pacing and period-over-period trend analysis."
    - name: "revenue_date_year"
      expr: YEAR(revenue_date)
      comment: "Year of revenue recognition — used for annual performance reporting and YoY comparisons."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status of the revenue record — used to identify outstanding receivables and collection risk."
    - name: "property_id"
      expr: property_id
      comment: "Property where the event revenue was generated — enables property-level P&L benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue posting — required for multi-currency financial consolidation."
    - name: "revenue_source"
      expr: revenue_source
      comment: "Source system or channel originating the revenue — used for channel attribution and reconciliation."
    - name: "subcategory"
      expr: subcategory
      comment: "Granular revenue sub-classification within a category — supports detailed P&L drill-down."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g. at-event, deferred) — relevant for finance compliance and audit reporting."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual event revenue posted — primary top-line KPI for event financial performance."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted event revenue — baseline for variance analysis against actuals."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments — the most accurate measure of realized event income."
    - name: "total_revenue_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budgeted revenue — quantifies forecast accuracy and over/under performance."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected — measures ancillary revenue contribution from event service fees."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event revenue — required for tax liability reporting and compliance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-posting adjustments applied — flags revenue integrity issues and concession patterns."
    - name: "avg_per_attendee_revenue"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue generated per attendee — key yield metric for pricing and package optimization decisions."
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks associated with events — benchmarks group room pricing effectiveness."
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from event revenue — links event performance to whole-property revenue-per-available-room metrics."
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event revenue — measures the impact of group events on overall room revenue yield."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid on event revenue — used to calculate net revenue yield after intermediary costs."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and lead-funnel KPI layer over event inquiries. Tracks lead volume, budget qualification, conversion readiness, and pipeline value to guide sales team prioritization and marketing ROI assessment."
  source: "`travel_hospitality_ecm`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (e.g. New, Qualified, Converted, Lost) — primary funnel-stage dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of event being inquired about — used to analyze demand mix and tailor sales responses."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification tier — used to prioritize sales follow-up and measure pipeline quality."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the inquiring organization — supports segment-level pipeline and conversion analysis."
    - name: "inquiry_date_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the inquiry was received — used for lead volume trending and seasonal demand analysis."
    - name: "inquiry_date_year"
      expr: YEAR(inquiry_date)
      comment: "Year the inquiry was received — supports annual pipeline volume and YoY comparisons."
    - name: "property_id"
      expr: property_id
      comment: "Property the inquiry is directed to — enables property-level pipeline benchmarking."
    - name: "referral_source"
      expr: referral_source
      comment: "Source that generated the inquiry (e.g. website, referral, trade show) — used for marketing channel attribution."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the client's stated budget — required for multi-currency pipeline valuation."
    - name: "catering_required_flag"
      expr: catering_required_flag
      comment: "Whether catering is required — used to estimate F&B revenue potential in the pipeline."
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received — baseline lead volume KPI for sales pipeline management."
    - name: "total_converted_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Number of inquiries that converted to a booking — measures sales effectiveness and funnel throughput."
    - name: "inquiry_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries that converted to confirmed bookings — primary sales funnel efficiency KPI."
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget stated by inquiring clients — used to size pipeline value and qualify leads."
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum budget stated by inquiring clients — provides lower-bound pipeline value estimate."
    - name: "total_pipeline_budget_max"
      expr: SUM(CAST(budget_range_max AS DOUBLE))
      comment: "Total maximum budget across all open inquiries — upper-bound estimate of addressable pipeline value."
    - name: "avg_inquiry_to_decision_days"
      expr: AVG(DATEDIFF(decision_timeline, inquiry_date))
      comment: "Average days from inquiry receipt to client decision deadline — informs sales urgency and follow-up cadence."
    - name: "av_equipment_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN av_equipment_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries requiring AV equipment — used to forecast AV revenue potential and resource planning."
    - name: "catering_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN catering_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries requiring catering — used to forecast F&B revenue potential and kitchen capacity planning."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline KPI layer tracking proposal volume, estimated revenue, win rates, and pricing competitiveness. Used by Sales Directors and Revenue Management to optimize proposal strategy and close rates."
  source: "`travel_hospitality_ecm`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g. Draft, Sent, Won, Lost, Expired) — primary funnel-stage dimension for win/loss analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of the proposal — used to track compliance with pricing authority and approval workflows."
    - name: "event_type"
      expr: event_type
      comment: "Type of event the proposal covers — used to analyze win rates and revenue yield by event category."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the proposal was issued — used for proposal volume trending and sales activity pacing."
    - name: "issued_date_year"
      expr: YEAR(issued_date)
      comment: "Year the proposal was issued — supports annual win-rate and revenue-yield trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property the proposal is for — enables property-level win-rate and revenue benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal — required for multi-currency pipeline valuation."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the proposal was originated — used for channel-level conversion and revenue attribution."
    - name: "guest_segment_id"
      expr: guest_segment_id
      comment: "Guest segment associated with the proposal — supports segment-level win-rate and deal-size analysis."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals issued — baseline sales activity volume KPI."
    - name: "total_won_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Won' THEN 1 END)
      comment: "Number of proposals that resulted in a confirmed booking — measures sales conversion effectiveness."
    - name: "proposal_win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN proposal_status = 'Won' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proposals that converted to won bookings — primary sales effectiveness KPI for group events."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all proposals — measures the gross value of the active sales pipeline."
    - name: "avg_estimated_revenue_per_proposal"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per proposal — indicates deal size trends and mix shift in the pipeline."
    - name: "total_fb_minimum_amount"
      expr: SUM(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Total F&B minimum commitments across proposals — measures contracted F&B revenue floor in the pipeline."
    - name: "avg_room_block_rate"
      expr: AVG(CAST(room_block_rate AS DOUBLE))
      comment: "Average room block rate offered in proposals — benchmarks group room pricing competitiveness."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate offered in proposals — used to evaluate intermediary cost and net revenue yield."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount requested in proposals — indicates financial commitment terms and risk posture."
    - name: "avg_proposal_to_decision_days"
      expr: AVG(DATEDIFF(decision_date, issued_date))
      comment: "Average days from proposal issuance to client decision — measures sales cycle length and urgency of follow-up."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable and billing KPI layer over event invoices. Tracks total billed value, outstanding balances, collection efficiency, and revenue composition. Used by Finance and Event Operations to manage cash flow and billing accuracy."
  source: "`travel_hospitality_ecm`.`event`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. Draft, Sent, Paid, Overdue, Disputed) — primary dimension for AR aging and collection analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the client — used to analyze payment mix and processing cost."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued — used for billing volume trending and revenue recognition pacing."
    - name: "invoice_date_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued — supports annual billing and collection trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property that generated the invoice — enables property-level AR and billing performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice — required for multi-currency AR reporting and FX exposure analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the client — used to segment AR aging by contractual due dates."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — used for geographic revenue and tax compliance reporting."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of event invoices issued — baseline billing volume KPI."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total gross amount billed across all event invoices — primary top-line billing KPI for Finance."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected from event invoices — measures cash collection performance."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all event invoices — primary AR exposure KPI for cash flow management."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of total billed amount that has been collected — measures billing-to-cash efficiency."
    - name: "total_room_revenue_billed"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue component billed on event invoices — used for revenue category mix analysis."
    - name: "total_fb_revenue_billed"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue component billed on event invoices — measures catering revenue contribution to total billing."
    - name: "total_space_rental_billed"
      expr: SUM(CAST(space_rental_amount AS DOUBLE))
      comment: "Total space rental revenue billed — measures function space monetization through event billing."
    - name: "total_av_equipment_billed"
      expr: SUM(CAST(av_equipment_amount AS DOUBLE))
      comment: "Total AV equipment charges billed — measures ancillary AV revenue contribution."
    - name: "total_service_charge_billed"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges billed — used to evaluate service charge revenue and compliance with contracted rates."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed — required for tax liability reconciliation and regulatory reporting."
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_received_date, invoice_date))
      comment: "Average number of days from invoice issuance to payment receipt — measures collection cycle efficiency (DSO proxy)."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract risk and value KPI layer over event contracts. Tracks contracted revenue composition, attrition exposure, deposit schedules, and legal compliance. Used by Legal, Finance, and Sales leadership to manage contract risk and revenue assurance."
  source: "`travel_hospitality_ecm`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the event contract (e.g. Draft, Executed, Expired, Cancelled) — primary dimension for contract lifecycle analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of event contract (e.g. Standard, Master, Amendment) — used to segment contract portfolio by complexity and risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency contracted revenue reporting."
    - name: "execution_date_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the contract was executed — used for contract volume trending and revenue recognition scheduling."
    - name: "execution_date_year"
      expr: YEAR(execution_date)
      comment: "Year the contract was executed — supports annual contracted revenue and risk trend analysis."
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Whether credit was approved for the contract — used to segment contracts by credit risk profile."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether the contract underwent legal review — used to assess compliance with legal governance policies."
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Whether billing is consolidated to a master account — used to identify corporate account billing patterns."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of event contracts — baseline contract volume KPI for legal and sales governance."
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total revenue committed across all event contracts — primary contracted revenue pipeline KPI."
    - name: "avg_contracted_revenue_per_contract"
      expr: AVG(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Average contracted revenue per event contract — indicates deal size trends and portfolio mix."
    - name: "total_room_revenue_contracted"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue committed in event contracts — measures group room block value in the contract portfolio."
    - name: "total_fb_revenue_contracted"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue committed in event contracts — measures catering revenue assurance from signed contracts."
    - name: "total_space_rental_contracted"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total space rental revenue committed in event contracts — measures function space revenue assurance."
    - name: "total_av_equipment_contracted"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total AV equipment revenue committed in event contracts — measures ancillary AV revenue assurance."
    - name: "total_initial_deposit_amount"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposits committed across contracts — measures upfront financial commitment secured from clients."
    - name: "avg_attrition_threshold_percentage"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across contracts — benchmarks contractual risk tolerance for attendance shortfalls."
    - name: "legal_review_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that underwent legal review — measures compliance with legal governance policy."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space asset and pricing KPI layer. Tracks rental rate benchmarks, capacity configurations, and space portfolio characteristics. Used by Revenue Management and Property Operations to optimize space pricing and utilization strategy."
  source: "`travel_hospitality_ecm`.`event`.`function_space`"
  filter: operational_status = 'Active'
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of function space (e.g. Ballroom, Boardroom, Breakout Room) — primary dimension for space portfolio analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property where the function space is located — enables property-level space portfolio benchmarking."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space — used to filter active vs. inactive inventory."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the function space — used for location-based pricing and demand analysis."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into smaller sections — impacts capacity flexibility and multi-event scheduling."
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Whether the space is outdoors — used to segment indoor vs. outdoor event capacity and pricing."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Whether the space meets accessibility compliance standards — used for compliance reporting and inclusive event planning."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether the space has natural light — a premium feature that influences rental rate and demand."
  measures:
    - name: "total_function_spaces"
      expr: COUNT(1)
      comment: "Total number of active function spaces in the portfolio — baseline inventory KPI for capacity planning."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of active function space inventory — measures total event space capacity available."
    - name: "avg_square_footage_per_space"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space — benchmarks space size mix across the portfolio."
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate across function spaces — used to benchmark pricing competitiveness and yield optimization."
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate across function spaces — used for pricing strategy and package design."
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate across function spaces — used for short-duration event pricing optimization."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across function spaces — relevant for AV setup feasibility and premium space classification."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required per function space — used to optimize event turnaround scheduling and space utilization."
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time per function space — used alongside setup time to calculate effective available event hours."
    - name: "revenue_per_sqft_full_day"
      expr: ROUND(AVG(CAST(rental_rate_full_day AS DOUBLE)) / NULLIF(AVG(CAST(square_footage AS DOUBLE)), 0), 4)
      comment: "Average full-day rental revenue per square foot — measures space monetization efficiency and pricing density."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_attendee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attendee engagement and registration KPI layer. Tracks registration volume, fee revenue, satisfaction scores, check-in rates, and loyalty linkage. Used by Event Operations and Marketing to evaluate attendee experience quality and event commercial performance."
  source: "`travel_hospitality_ecm`.`event`.`attendee`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the attendee (e.g. Registered, Cancelled, Waitlisted) — primary dimension for registration funnel analysis."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g. Full Conference, Day Pass, Virtual) — used to analyze attendance mix and fee yield."
    - name: "attendance_mode"
      expr: attendance_mode
      comment: "Mode of attendance (e.g. In-Person, Virtual, Hybrid) — used to track hybrid event participation trends."
    - name: "check_in_status"
      expr: check_in_status
      comment: "Check-in status of the attendee — used to measure actual vs. registered attendance rates."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the registration fee — used to identify outstanding fee collections."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of attendee registration — used for registration pacing and early-bird vs. late registration analysis."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Whether the attendee opted into marketing communications — used to measure marketable audience size from events."
    - name: "data_privacy_consent_flag"
      expr: data_privacy_consent_flag
      comment: "Whether the attendee provided data privacy consent — required for GDPR/privacy compliance reporting."
  measures:
    - name: "total_attendees"
      expr: COUNT(1)
      comment: "Total number of attendee registrations — baseline event participation volume KPI."
    - name: "total_checked_in_attendees"
      expr: COUNT(CASE WHEN check_in_status = 'Checked In' THEN 1 END)
      comment: "Number of attendees who physically checked in — measures actual event attendance vs. registered count."
    - name: "check_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN check_in_status = 'Checked In' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registered attendees who checked in — measures event show-up rate and no-show risk."
    - name: "total_registration_fee_revenue"
      expr: SUM(CAST(registration_fee_amount AS DOUBLE))
      comment: "Total registration fees collected across all attendees — measures direct revenue generated from event registrations."
    - name: "avg_registration_fee_per_attendee"
      expr: AVG(CAST(registration_fee_amount AS DOUBLE))
      comment: "Average registration fee per attendee — benchmarks event pricing and fee yield per participant."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average attendee satisfaction score — primary guest experience quality KPI for event operations."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendees who opted into marketing — measures event-driven audience acquisition for CRM and marketing programs."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations that were cancelled — measures attrition risk and event demand stability."
    - name: "loyalty_linked_attendee_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendees linked to a loyalty member profile — measures loyalty program penetration at events and cross-sell opportunity."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group room block performance KPI layer tracking pickup rates, attrition exposure, and revenue yield for event-associated room blocks. Used by Revenue Management to optimize group room pricing, block sizing, and attrition risk management."
  source: "`travel_hospitality_ecm`.`event`.`event_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group room block (e.g. Active, Released, Cancelled) — primary dimension for block portfolio analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code of the group block — used for segment-level pickup and revenue analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the group block — enables property-level group room performance benchmarking."
    - name: "block_start_month"
      expr: DATE_TRUNC('MONTH', block_start_date)
      comment: "Month the group block begins — used for demand pacing and seasonal group room analysis."
    - name: "block_start_year"
      expr: YEAR(block_start_date)
      comment: "Year the group block begins — supports annual group room revenue trend analysis."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Whether a deposit is required for the block — used to assess financial commitment and block quality."
    - name: "shoulder_dates_allowed_flag"
      expr: shoulder_dates_allowed_flag
      comment: "Whether shoulder dates are permitted for the block — impacts total room night potential and revenue yield."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the group room rate — required for multi-currency group revenue reporting."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group room blocks — baseline group inventory KPI."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_total_revenue AS DOUBLE))
      comment: "Total actual revenue realized from group room blocks — primary group room revenue KPI."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue from group room blocks at time of booking — used for pipeline and forecast analysis."
    - name: "total_attrition_amount"
      expr: SUM(CAST(attrition_amount AS DOUBLE))
      comment: "Total attrition penalties assessed on group blocks — quantifies revenue leakage from underperforming blocks."
    - name: "avg_pickup_to_block_ratio"
      expr: AVG(CAST(pickup_to_block_ratio AS DOUBLE))
      comment: "Average ratio of rooms picked up to rooms contracted — primary group block utilization KPI for Revenue Management."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group room rate across blocks — benchmarks group pricing competitiveness and yield."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across group blocks — measures the extent of room block underperformance."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on group room blocks — measures financial commitment secured from group clients."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage offered on group blocks — used to evaluate incentive cost and net group room yield."
    - name: "revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_total_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_total_revenue AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated group block revenue that was actually realized — measures forecast accuracy and block performance."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order (BEO) financial and operational KPI layer. Tracks estimated vs. actual BEO revenue, service charge rates, and tax exposure. Used by Catering Operations and Finance to manage event execution profitability."
  source: "`travel_hospitality_ecm`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (e.g. Draft, Confirmed, Completed, Cancelled) — primary dimension for BEO lifecycle analysis."
    - name: "function_type"
      expr: function_type
      comment: "Type of function covered by the BEO (e.g. Dinner, Reception, Meeting) — used for revenue and cost analysis by function type."
    - name: "property_id"
      expr: property_id
      comment: "Property where the BEO function takes place — enables property-level catering performance benchmarking."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the BEO event date — used for catering revenue pacing and operational planning."
    - name: "event_date_year"
      expr: YEAR(event_date)
      comment: "Year of the BEO event date — supports annual catering revenue trend analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup style for the BEO function (e.g. Banquet, Theater, Classroom) — used to analyze setup preferences and operational cost."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO — required for multi-currency catering revenue reporting."
  measures:
    - name: "total_beos"
      expr: COUNT(1)
      comment: "Total number of Banquet Event Orders — baseline catering operations volume KPI."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue generated from BEOs — primary catering revenue KPI for operations and finance."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across BEOs — used for catering revenue forecasting and kitchen capacity planning."
    - name: "beo_revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_revenue AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated BEO revenue that was actually realized — measures catering forecast accuracy and execution performance."
    - name: "avg_actual_revenue_per_beo"
      expr: AVG(CAST(actual_revenue AS DOUBLE))
      comment: "Average actual revenue per BEO — benchmarks catering deal size and yield per function."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage applied across BEOs — used to benchmark service charge consistency and revenue contribution."
    - name: "avg_tax_percentage"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax rate applied across BEOs — used for tax liability estimation and compliance monitoring."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`event_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space allocation and utilization KPI layer. Tracks space booking volume, rental revenue, and allocation efficiency. Used by Event Operations and Revenue Management to optimize space scheduling and monetization."
  source: "`travel_hospitality_ecm`.`event`.`space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (e.g. Tentative, Confirmed, Released, Cancelled) — primary dimension for space pipeline analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event using the allocated space — used to analyze space demand by event category."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration for the allocation — used to analyze setup preference mix and operational cost."
    - name: "property_id"
      expr: property_id
      comment: "Property where the space is allocated — enables property-level space utilization benchmarking."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the space allocation — used for space demand pacing and seasonal utilization analysis."
    - name: "allocation_date_year"
      expr: YEAR(allocation_date)
      comment: "Year of the space allocation — supports annual space utilization trend analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the space was allocated on a complimentary basis — used to track complimentary space cost and policy compliance."
    - name: "booking_segment"
      expr: booking_segment
      comment: "Booking segment of the space allocation — used for segment-level space revenue and utilization analysis."
    - name: "space_block_type"
      expr: space_block_type
      comment: "Type of space block (e.g. Definite, Tentative, Wash) — used to assess confirmed vs. speculative space demand."
  measures:
    - name: "total_space_allocations"
      expr: COUNT(1)
      comment: "Total number of function space allocations — baseline space booking volume KPI."
    - name: "total_rental_charge_revenue"
      expr: SUM(CAST(rental_charge_amount AS DOUBLE))
      comment: "Total rental charges generated from space allocations — primary space monetization KPI."
    - name: "avg_rental_charge_per_allocation"
      expr: AVG(CAST(rental_charge_amount AS DOUBLE))
      comment: "Average rental charge per space allocation — benchmarks space pricing yield per booking."
    - name: "complimentary_space_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations granted on a complimentary basis — measures complimentary space cost exposure and policy adherence."
    - name: "confirmed_allocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations that are confirmed — measures pipeline conversion and space commitment quality."
    - name: "avg_event_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(end_time) - UNIX_TIMESTAMP(start_time)) / 3600.0 AS DOUBLE))
      comment: "Average event duration in hours per space allocation — used to assess space utilization intensity and scheduling efficiency."
$$;