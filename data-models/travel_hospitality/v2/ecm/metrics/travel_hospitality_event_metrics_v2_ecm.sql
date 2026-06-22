-- Metric views for domain: event | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core event booking performance metrics covering pipeline value, conversion funnel, attrition risk, and revenue yield. Primary steering dashboard for the Group Sales and Events leadership team."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the event booking (e.g. Tentative, Definite, Cancelled) — primary funnel segmentation dimension."
    - name: "mice_category"
      expr: mice_category
      comment: "MICE segment classification (Meetings, Incentives, Conferences, Exhibitions) for market-mix analysis."
    - name: "event_start_month"
      expr: DATE_TRUNC('month', event_start_date)
      comment: "Month the event begins — used for forward-looking pipeline and pace reporting."
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year the event begins — used for annual pipeline and year-over-year comparisons."
    - name: "inquiry_month"
      expr: DATE_TRUNC('month', inquiry_date)
      comment: "Month the inquiry was received — used for lead-volume trend analysis."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Whether a deposit has been collected — used to segment confirmed vs. at-risk bookings."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the booking for multi-currency revenue reporting."
  measures:
    - name: "total_event_bookings"
      expr: COUNT(1)
      comment: "Total number of event bookings. Baseline volume KPI for pipeline and capacity planning."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Sum of all contracted event values. Primary revenue pipeline measure for Group Sales leadership."
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per event booking. Indicates deal size trends and mix shift."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions payable on event bookings. Drives channel cost and net revenue calculations."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across bookings. Used to benchmark channel cost efficiency."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected or due. Cash-flow and credit-risk indicator for Finance."
    - name: "total_attrition_penalty"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalties incurred. Signals room-block underperformance and contract enforcement effectiveness."
    - name: "avg_attrition_clause_pct"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition clause percentage across contracts. Used to calibrate risk exposure in group block negotiations."
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total value of concessions granted to event clients. Tracks discounting discipline and margin leakage."
    - name: "deposit_collection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deposit_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings with deposit collected. Measures financial commitment and cancellation risk mitigation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed event revenue actuals vs. budget, by category and event type. Core P&L steering view for the Events and Finance teams."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_revenue`"
  filter: is_voided = FALSE
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "High-level revenue category (Room, F&B, Space Rental, AV, Other) for revenue-mix analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating the revenue — used for profitability analysis by event segment."
    - name: "revenue_date_month"
      expr: DATE_TRUNC('month', revenue_date)
      comment: "Month revenue was recognized — used for monthly P&L and pace reporting."
    - name: "revenue_date_year"
      expr: YEAR(revenue_date)
      comment: "Year revenue was recognized — used for annual performance and YoY comparisons."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (Paid, Pending, Overdue) — used for AR aging and cash-flow analysis."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (accrual, cash) — required for finance compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue posting for multi-currency consolidation."
    - name: "subcategory"
      expr: subcategory
      comment: "Granular revenue subcategory for detailed P&L drill-down."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual event revenue recognized. Primary top-line KPI for the Events P&L."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted event revenue. Used as the baseline for variance and attainment reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments. The definitive bottom-line revenue figure for event operations."
    - name: "total_revenue_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total actual vs. budget variance. Negative values signal underperformance requiring management action."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected. Contributes to labor cost recovery and profitability."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event revenue. Required for tax compliance and regulatory filing."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid on event revenue. Measures channel distribution cost against gross revenue."
    - name: "avg_revenue_per_attendee"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue generated per attendee. Key yield metric for pricing and package design decisions."
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks associated with events. Benchmarks group pricing against transient rates."
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from events. Measures events' share of total hotel revenue per available room."
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event room blocks. Quantifies events' impact on overall room revenue yield."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments posted. Large values indicate billing disputes or correction activity requiring review."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event account portfolio health metrics covering spend concentration, credit risk, and account tier performance. Used by Sales leadership to prioritize account management and credit decisions."
  source: "`vibe_travel_hospitality_v1`.`event`.`account`"
  filter: account_status != 'Closed'
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (Corporate, Association, Government, etc.) for portfolio segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (Active, Inactive, Prospect) for pipeline health monitoring."
    - name: "tier"
      expr: tier
      comment: "Account tier (Platinum, Gold, Silver) reflecting strategic importance and service level."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry sector of the account — used for vertical market analysis and targeted sales strategy."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account (Good, Watch, Suspended) — critical for AR risk management."
    - name: "is_national_account"
      expr: is_national_account
      comment: "Flag indicating national account status — used to separate enterprise vs. local account performance."
    - name: "is_vip_account"
      expr: is_vip_account
      comment: "Flag indicating VIP account status — used to prioritize service and resource allocation."
    - name: "preferred_event_type"
      expr: preferred_event_type
      comment: "Most common event type booked by the account — used for targeted upsell and package design."
    - name: "sales_territory_code"
      expr: sales_territory_code
      comment: "Sales territory assignment — used for territory performance and quota attainment reporting."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of active event accounts. Baseline portfolio size metric for Sales leadership."
    - name: "total_lifetime_event_spend"
      expr: SUM(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Total lifetime event spend across all accounts. Measures the cumulative revenue value of the account portfolio."
    - name: "avg_lifetime_event_spend"
      expr: AVG(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Average lifetime event spend per account. Benchmarks account value and identifies high-potential accounts."
    - name: "avg_event_spend_per_booking"
      expr: AVG(CAST(average_event_spend_amount AS DOUBLE))
      comment: "Average spend per event booking at the account level. Used to identify accounts with upsell potential."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit extended across the account portfolio. Used by Finance to monitor credit exposure concentration."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit policy application across the portfolio."
    - name: "total_events_booked"
      expr: SUM(CAST(total_events_booked_count AS DOUBLE))
      comment: "Total events booked across all accounts. Measures account engagement depth and booking frequency."
    - name: "avg_events_per_account"
      expr: AVG(CAST(total_events_booked_count AS DOUBLE))
      comment: "Average number of events booked per account. Identifies loyal repeat accounts vs. one-time clients."
    - name: "national_account_share"
      expr: ROUND(100.0 * SUM(CASE WHEN is_national_account = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts classified as national accounts. Tracks enterprise account penetration in the portfolio."
    - name: "vip_account_share"
      expr: ROUND(100.0 * SUM(CASE WHEN is_vip_account = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with VIP designation. Used to calibrate white-glove service resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event sales funnel metrics from inquiry through conversion. Enables Sales leadership to measure lead quality, conversion rates, and pipeline velocity."
  source: "`vibe_travel_hospitality_v1`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (New, Qualified, Converted, Lost) — primary funnel stage dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of event inquired about — used to analyze demand by event category."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the inquiry (Corporate, Social, Association) for demand-mix analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the inquiry was received (Web, Phone, Referral, OTA) for lead-source ROI analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification status — used to measure sales team qualification efficiency."
    - name: "inquiry_month"
      expr: DATE_TRUNC('month', inquiry_date)
      comment: "Month the inquiry was received — used for lead volume trend and seasonality analysis."
    - name: "preferred_start_month"
      expr: DATE_TRUNC('month', preferred_start_date)
      comment: "Month of the preferred event start date — used for forward demand and capacity planning."
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason the inquiry was lost — used to identify competitive gaps and pricing issues."
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received. Top-of-funnel volume metric for Sales pipeline management."
    - name: "total_converted_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Number of inquiries converted to bookings. Measures sales team effectiveness in closing group business."
    - name: "inquiry_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries converted to definite bookings. Primary sales funnel efficiency KPI."
    - name: "total_lost_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Lost' THEN 1 END)
      comment: "Number of inquiries lost to competitors or cancelled. Used to quantify revenue leakage and competitive pressure."
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget declared by inquiring clients. Used to calibrate pricing strategy and package design."
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum budget declared by inquiring clients. Used alongside max to understand client budget bandwidth."
    - name: "qualified_inquiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries that pass qualification. Measures lead quality from each source channel."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline metrics covering win rates, revenue at stake, and proposal cycle efficiency. Used by Group Sales leadership to manage the proposal-to-contract conversion funnel."
  source: "`vibe_travel_hospitality_v1`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (Draft, Sent, Accepted, Declined, Expired) — primary funnel stage dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of the proposal — used to track internal review cycle efficiency."
    - name: "event_type"
      expr: event_type
      comment: "Type of event in the proposal — used for win-rate analysis by event category."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the proposal originated — used for channel-level win-rate and ROI analysis."
    - name: "issued_month"
      expr: DATE_TRUNC('month', issued_date)
      comment: "Month the proposal was issued — used for proposal volume trend and pipeline pace reporting."
    - name: "event_start_month"
      expr: DATE_TRUNC('month', event_start_date)
      comment: "Month of the proposed event start — used for forward pipeline and capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal for multi-currency pipeline reporting."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals issued. Measures sales team activity and pipeline depth."
    - name: "total_estimated_revenue_at_stake"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all active proposals. Primary pipeline value KPI for revenue forecasting."
    - name: "avg_estimated_revenue_per_proposal"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per proposal. Tracks deal size trends and mix shift in the pipeline."
    - name: "proposal_win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN proposal_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proposals accepted by clients. Core sales effectiveness KPI for Group Sales leadership."
    - name: "total_won_revenue"
      expr: SUM(CASE WHEN proposal_status = 'Accepted' THEN total_estimated_revenue ELSE 0 END)
      comment: "Total estimated revenue from accepted proposals. Measures the revenue value of won group business."
    - name: "total_lost_revenue"
      expr: SUM(CASE WHEN proposal_status = 'Declined' THEN total_estimated_revenue ELSE 0 END)
      comment: "Total estimated revenue from declined proposals. Quantifies competitive revenue loss for strategic review."
    - name: "avg_fb_minimum"
      expr: AVG(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Average F&B minimum commitment in proposals. Used to benchmark F&B yield expectations in group contracts."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount requested in proposals. Used to assess cash-flow commitment and cancellation risk."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate in proposals. Used to monitor channel cost discipline in group sales."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_lost_business`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost business analysis metrics quantifying revenue leakage, competitive displacement, and loss reason patterns. Used by Sales and Revenue Management to identify pricing gaps and competitive vulnerabilities."
  source: "`vibe_travel_hospitality_v1`.`event`.`lost_business`"
  dimensions:
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "High-level category of the loss reason (Price, Availability, Competitor, Service) — primary competitive intelligence dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of event lost — used to identify which event categories are most vulnerable to competitive loss."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the lost business — used to prioritize competitive response by segment."
    - name: "loss_month"
      expr: DATE_TRUNC('month', loss_date)
      comment: "Month the business was lost — used for trend analysis and competitive pressure monitoring."
    - name: "loss_status"
      expr: loss_status
      comment: "Current status of the lost business record (Final, Win-Back Pending) — used to track recovery efforts."
    - name: "lead_source"
      expr: lead_source
      comment: "Original lead source of the lost business — used to evaluate lead quality by channel."
  measures:
    - name: "total_lost_events"
      expr: COUNT(1)
      comment: "Total number of lost event opportunities. Baseline competitive loss volume metric."
    - name: "total_lost_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue lost to competitors or cancellations. Primary revenue leakage KPI for Sales leadership."
    - name: "avg_lost_revenue_per_event"
      expr: AVG(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Average revenue per lost event. Used to prioritize win-back efforts on highest-value lost opportunities."
    - name: "total_lost_room_revenue"
      expr: SUM(CAST(estimated_room_revenue AS DOUBLE))
      comment: "Total room revenue lost. Measures competitive displacement impact on room inventory yield."
    - name: "total_lost_fb_revenue"
      expr: SUM(CAST(estimated_fb_revenue AS DOUBLE))
      comment: "Total F&B revenue lost. Measures competitive displacement impact on food and beverage operations."
    - name: "total_lost_meeting_space_revenue"
      expr: SUM(CAST(estimated_meeting_space_revenue AS DOUBLE))
      comment: "Total meeting space rental revenue lost. Measures competitive displacement impact on space utilization."
    - name: "avg_competitor_quoted_rate"
      expr: AVG(CAST(competitor_quoted_rate AS DOUBLE))
      comment: "Average rate quoted by the winning competitor. Used to benchmark pricing competitiveness in group sales."
    - name: "avg_quoted_group_adr"
      expr: AVG(CAST(quoted_group_adr AS DOUBLE))
      comment: "Average group ADR quoted on lost proposals. Used to identify pricing gaps vs. competitor rates."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event invoice and accounts receivable metrics covering billing completeness, collection performance, and outstanding balances. Used by Finance and Events teams to manage cash flow and AR aging."
  source: "`vibe_travel_hospitality_v1`.`event`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (Draft, Sent, Paid, Disputed, Overdue) — primary AR management dimension."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (Credit Card, Wire, Check) — used for treasury and reconciliation analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued — used for billing volume trend and revenue recognition timing."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AR reporting."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — used for geographic revenue and tax analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of event invoices issued. Baseline billing activity metric."
    - name: "total_invoice_value"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total value of all invoices issued. Primary AR gross billing KPI for Finance."
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against invoices. Measures cash collection effectiveness."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance. Critical cash-flow and credit-risk metric for Finance leadership."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event invoices. Required for tax compliance and regulatory reporting."
    - name: "total_service_charge_billed"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges billed. Contributes to labor cost recovery analysis."
    - name: "total_fb_revenue_billed"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue billed on event invoices. Used for F&B revenue recognition and mix analysis."
    - name: "total_room_revenue_billed"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue billed on event invoices. Used for room revenue recognition from group blocks."
    - name: "total_space_rental_billed"
      expr: SUM(CAST(space_rental_amount AS DOUBLE))
      comment: "Total space rental revenue billed. Measures function space yield contribution."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of total invoiced amount collected. Primary AR collection efficiency KPI for Finance."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN 1 END)
      comment: "Number of invoices in dispute. Signals billing accuracy issues and client satisfaction risks."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event group room block performance metrics covering pickup rates, attrition risk, and revenue yield. Used by Revenue Management and Group Sales to optimize block sizing and minimize attrition penalties."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (Tentative, Definite, Cancelled, Consumed) — primary block lifecycle dimension."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group block — used for segment-level pickup and yield analysis."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan applied to the group block — used for rate-mix and yield analysis."
    - name: "block_start_month"
      expr: DATE_TRUNC('month', block_start_date)
      comment: "Month the group block begins — used for forward pickup pace and capacity planning."
    - name: "cutoff_month"
      expr: DATE_TRUNC('month', cutoff_date)
      comment: "Month of the block cutoff date — used to monitor blocks approaching release deadlines."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the group rate for multi-currency revenue reporting."
    - name: "booking_source_code"
      expr: booking_source_code
      comment: "Source channel of the group booking — used for channel-level group business analysis."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of event group blocks. Baseline volume metric for group inventory management."
    - name: "total_contracted_room_nights"
      expr: SUM(CAST(total_room_nights AS DOUBLE))
      comment: "Total contracted room nights across all group blocks. Primary group inventory commitment metric."
    - name: "avg_pickup_to_block_ratio"
      expr: AVG(CAST(pickup_to_block_ratio AS DOUBLE))
      comment: "Average pickup-to-block ratio across group blocks. Measures room block utilization efficiency."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue from group blocks. Used for forward revenue forecasting."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_total_revenue AS DOUBLE))
      comment: "Total actual revenue realized from group blocks. Used for actuals vs. estimate variance analysis."
    - name: "total_attrition_amount"
      expr: SUM(CAST(attrition_amount AS DOUBLE))
      comment: "Total attrition penalties incurred on group blocks. Measures revenue recovery from underperforming blocks."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group room rate across blocks. Benchmarks group pricing against transient and budget rates."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across group blocks. Signals systematic over-blocking or demand shortfalls."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on group blocks. Measures financial commitment and cancellation risk mitigation."
    - name: "deposit_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deposit_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group blocks requiring a deposit. Used to assess credit risk policy application."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and pricing metrics covering capacity, rental rates, and operational readiness. Used by Events and Revenue Management to optimize space utilization and pricing."
  source: "`vibe_travel_hospitality_v1`.`event`.`function_space`"
  filter: operational_status = 'Active'
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of function space (Ballroom, Boardroom, Breakout, Outdoor) — primary space classification dimension."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space — used to track available vs. out-of-service inventory."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the space — used for logistical planning and accessibility analysis."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into smaller sections — used for flexible capacity planning."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "ADA/accessibility compliance status — used for compliance reporting and inclusive event planning."
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Whether the space is outdoors — used for weather-dependent event planning and pricing."
    - name: "catering_kitchen_access"
      expr: catering_kitchen_access
      comment: "Whether the space has direct catering kitchen access — used for F&B capability and pricing analysis."
  measures:
    - name: "total_function_spaces"
      expr: COUNT(1)
      comment: "Total number of active function spaces. Baseline inventory capacity metric."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of function space inventory. Used for capacity planning and space yield calculations."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space. Used to benchmark space sizing against demand patterns."
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate across function spaces. Used for pricing benchmarking and yield optimization."
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate. Used to evaluate half-day vs. full-day pricing strategy."
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate. Used for short-duration event pricing and yield analysis."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required per space. Used for operational scheduling and turnover capacity planning."
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time per space. Combined with setup time to calculate total non-revenue space time."
    - name: "accessibility_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accessibility_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of function spaces that are ADA/accessibility compliant. Required for compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space allocation utilization and revenue metrics. Used by Events Operations and Revenue Management to measure space yield, setup efficiency, and allocation pipeline."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (Tentative, Confirmed, Released, Cancelled) — primary utilization dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of event using the space — used for demand-mix and space utilization analysis by event category."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration (Theater, Banquet, Classroom, etc.) — used for operational planning and capacity analysis."
    - name: "space_block_type"
      expr: space_block_type
      comment: "Type of space block (Definite, Tentative, Hold) — used for pipeline and availability management."
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of the space allocation — used for forward booking pace and capacity planning."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the space was allocated complimentarily — used to track concession value and yield impact."
    - name: "booking_segment"
      expr: booking_segment
      comment: "Market segment of the booking using the space — used for segment-level space yield analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the allocation — used for conflict resolution and space management decisions."
  measures:
    - name: "total_space_allocations"
      expr: COUNT(1)
      comment: "Total number of function space allocations. Baseline utilization volume metric."
    - name: "total_rental_charge"
      expr: SUM(CAST(rental_charge_amount AS DOUBLE))
      comment: "Total rental revenue from space allocations. Primary space yield KPI for Revenue Management."
    - name: "avg_rental_charge"
      expr: AVG(CAST(rental_charge_amount AS DOUBLE))
      comment: "Average rental charge per space allocation. Used to benchmark space pricing and yield performance."
    - name: "complimentary_allocation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations granted complimentarily. Measures concession rate and yield dilution."
    - name: "confirmed_allocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations in confirmed status. Measures pipeline conversion from tentative to definite."
    - name: "total_complimentary_rental_value"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN rental_charge_amount ELSE 0 END)
      comment: "Total rental value of complimentary space allocations. Quantifies the financial cost of space concessions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order (BEO) financial performance and operational metrics. Used by Catering Operations and Finance to track event execution revenue, service charge yield, and billing accuracy."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (Draft, Issued, Confirmed, Completed, Cancelled) — primary operational lifecycle dimension."
    - name: "function_type"
      expr: function_type
      comment: "Type of function on the BEO (Dinner, Reception, Meeting, etc.) — used for F&B revenue-mix analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup style specified on the BEO — used for operational planning and labor cost analysis."
    - name: "event_date_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the BEO event date — used for monthly F&B revenue and operational volume reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO for multi-currency revenue reporting."
  measures:
    - name: "total_beos"
      expr: COUNT(1)
      comment: "Total number of BEOs issued. Baseline operational volume metric for Catering Operations."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue from completed BEOs. Primary F&B and event execution revenue KPI."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue from BEOs. Used for forward revenue forecasting and kitchen planning."
    - name: "revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_revenue AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated BEO revenue. Measures forecasting accuracy and upsell effectiveness during execution."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE) * service_charge_percentage / 100.0)
      comment: "Estimated total service charge revenue based on service charge percentage applied to estimated revenue. Contributes to labor cost recovery analysis."
    - name: "avg_service_charge_rate"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across BEOs. Used to benchmark service charge policy application."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax rate applied to BEOs. Used for tax compliance monitoring and rate consistency checks."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BEO line-item revenue and cost metrics for catering and event services. Used by Catering Operations and Finance to analyze item-level profitability, waste, and billing accuracy."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo_item`"
  dimensions:
    - name: "item_type"
      expr: item_type
      comment: "Type of BEO line item (Food, Beverage, AV, Décor, Labor) — primary cost and revenue category dimension."
    - name: "item_category"
      expr: item_category
      comment: "Subcategory of the BEO item — used for granular cost and revenue analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category for GL posting — used for financial reporting and cost center allocation."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the line item (Billed, Pending, Voided) — used for AR completeness monitoring."
    - name: "item_status"
      expr: item_status
      comment: "Operational status of the item (Ordered, Delivered, Cancelled) — used for execution tracking."
    - name: "dietary_restriction_flag"
      expr: dietary_restriction_flag
      comment: "Whether the item has dietary restrictions — used for special dietary demand analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO item for multi-currency reporting."
  measures:
    - name: "total_beo_items"
      expr: COUNT(1)
      comment: "Total number of BEO line items. Baseline operational volume metric for catering execution."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount (quantity × unit price) across all BEO items. Primary line-item revenue KPI."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on BEO items. Measures service charge yield at the line-item level."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on BEO items. Required for tax compliance and accurate revenue recognition."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross amount including service charges and taxes. Comprehensive BEO item billing KPI."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across BEO items. Used to benchmark catering pricing and identify outliers."
    - name: "avg_overage_percentage"
      expr: AVG(CAST(overage_percentage AS DOUBLE))
      comment: "Average overage percentage (actual vs. guaranteed quantity). Measures demand forecasting accuracy and waste risk."
    - name: "total_guaranteed_quantity"
      expr: SUM(CAST(guaranteed_quantity AS DOUBLE))
      comment: "Total guaranteed quantity across BEO items. Used for kitchen production planning and minimum revenue commitment."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity consumed across BEO items. Used for waste analysis and demand forecasting calibration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_attendee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event attendee registration, satisfaction, and engagement metrics. Used by Events Operations and Marketing to measure event quality, attendee experience, and registration performance."
  source: "`vibe_travel_hospitality_v1`.`event`.`attendee`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (Registered, Cancelled, Waitlisted, Attended) — primary attendee lifecycle dimension."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (Full, Day Pass, Virtual, VIP) — used for revenue-mix and capacity analysis."
    - name: "attendance_mode"
      expr: attendance_mode
      comment: "Mode of attendance (In-Person, Virtual, Hybrid) — used for event format analysis and resource planning."
    - name: "check_in_status"
      expr: check_in_status
      comment: "Check-in status of the attendee — used for actual attendance vs. registration analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the registration fee — used for AR and cash-flow management."
    - name: "registration_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of registration — used for registration pace and early-bird demand analysis."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Whether the attendee opted into marketing communications — used for post-event marketing reach analysis."
  measures:
    - name: "total_attendees"
      expr: COUNT(1)
      comment: "Total number of attendee registrations. Baseline event participation metric."
    - name: "total_registration_fee_revenue"
      expr: SUM(CAST(registration_fee_amount AS DOUBLE))
      comment: "Total registration fee revenue collected. Measures direct attendee revenue contribution to event P&L."
    - name: "avg_registration_fee"
      expr: AVG(CAST(registration_fee_amount AS DOUBLE))
      comment: "Average registration fee per attendee. Used to benchmark pricing and evaluate fee structure effectiveness."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average attendee satisfaction score. Primary event quality KPI for Experience and Events leadership."
    - name: "check_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN check_in_status = 'Checked In' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registered attendees who checked in. Measures actual attendance vs. registration commitment."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations cancelled. Signals demand risk and informs attrition clause calibration."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendees who opted into marketing. Measures post-event marketing audience growth potential."
    - name: "virtual_access_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN virtual_platform_access_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendees granted virtual platform access. Used for hybrid event technology planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event contract portfolio metrics covering contracted revenue, attrition risk, and legal compliance. Used by Sales, Legal, and Finance to manage contract execution and revenue commitment."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the event contract (Draft, Executed, Expired, Cancelled) — primary contract lifecycle dimension."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of event contract (Standard, Master, Amendment) — used for contract portfolio analysis."
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Whether credit was approved for the contract — used for credit risk and AR management."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether the contract underwent legal review — used for compliance and risk management reporting."
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Whether billing is consolidated to a master account — used for enterprise account billing analysis."
    - name: "execution_month"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Month the contract was executed — used for contract volume trend and pipeline conversion analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency revenue reporting."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of event contracts. Baseline contract portfolio volume metric."
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total contracted revenue across all event contracts. Primary committed revenue pipeline KPI."
    - name: "avg_contracted_revenue"
      expr: AVG(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Average contracted revenue per event contract. Used to track deal size trends and mix shift."
    - name: "total_room_revenue_contracted"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue contracted in event agreements. Used for group room revenue forecasting."
    - name: "total_fb_revenue_contracted"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue contracted in event agreements. Used for catering revenue forecasting and kitchen planning."
    - name: "total_space_rental_contracted"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total space rental revenue contracted. Used for function space yield forecasting."
    - name: "total_av_revenue_contracted"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total AV equipment revenue contracted. Used for AV services revenue forecasting."
    - name: "total_initial_deposit_committed"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposits committed across contracts. Measures cash-flow commitment from group business."
    - name: "avg_attrition_threshold"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across contracts. Used to calibrate group block risk exposure."
    - name: "legal_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that underwent legal review. Measures legal compliance rigor in contract execution."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_staffing_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event staffing labor cost and utilization metrics. Used by Events Operations and HR to manage labor deployment, overtime risk, and cost-per-event efficiency."
  source: "`vibe_travel_hospitality_v1`.`event`.`staffing_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the staffing assignment (Scheduled, Completed, Cancelled) — primary operational dimension."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the assigned staff (Captain, Server, Setup, AV Technician) — used for labor mix analysis."
    - name: "shift"
      expr: shift
      comment: "Shift assignment (Morning, Afternoon, Evening, Overnight) — used for labor scheduling and cost analysis."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether the assignment incurred overtime — used for overtime cost monitoring and scheduling optimization."
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of the staffing assignment — used for monthly labor cost trend analysis."
  measures:
    - name: "total_staffing_assignments"
      expr: COUNT(1)
      comment: "Total number of staffing assignments. Baseline labor deployment volume metric."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all event staffing assignments. Primary labor expense KPI for Events Operations."
    - name: "avg_labor_cost_per_assignment"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per staffing assignment. Used to benchmark labor efficiency and identify cost outliers."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all event staffing assignments. Used for labor utilization and capacity planning."
    - name: "avg_hours_per_assignment"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per assignment. Used to calibrate staffing levels and shift planning."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overtime_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of staffing assignments that incurred overtime. Signals scheduling inefficiency and labor cost risk."
    - name: "total_overtime_assignments"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END)
      comment: "Total number of overtime staffing assignments. Used to monitor overtime exposure and compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo_attendant_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BEO attendant labor performance metrics covering hours, cost, and quality scores. Used by Catering Operations to manage banquet labor efficiency and service quality."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo_attendant_assignment`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the attendant assignment (Completed, In Progress, No Show) — primary operational dimension."
    - name: "role"
      expr: role
      comment: "Role of the attendant on the BEO (Captain, Server, Bartender, Setup) — used for labor mix and cost analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_timestamp)
      comment: "Month of the assignment — used for monthly labor cost and quality trend analysis."
  measures:
    - name: "total_attendant_assignments"
      expr: COUNT(1)
      comment: "Total number of BEO attendant assignments. Baseline banquet labor deployment metric."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for BEO attendant assignments. Primary banquet labor expense KPI."
    - name: "avg_labor_cost_per_assignment"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per BEO attendant assignment. Used to benchmark banquet labor efficiency."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked by BEO attendants. Used for labor utilization and scheduling analysis."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score for BEO attendant performance. Used to identify top performers and training needs."
    - name: "avg_hours_per_assignment"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours per BEO attendant assignment. Used to calibrate staffing levels for future events."
$$;