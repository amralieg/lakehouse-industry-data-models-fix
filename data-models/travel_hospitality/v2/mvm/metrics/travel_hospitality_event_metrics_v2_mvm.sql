-- Metric views for domain: event | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for event bookings covering pipeline value, conversion health, attrition risk, and booking economics. Used by Sales, Revenue Management, and C-suite to steer group/MICE business."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the event booking (e.g., Tentative, Definite, Cancelled) — primary segmentation for pipeline analysis."
    - name: "mice_category"
      expr: mice_category
      comment: "MICE segment classification (Meetings, Incentives, Conferences, Exhibitions) enabling segment-level revenue and volume analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking is denominated, required for multi-currency revenue reporting."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the event is scheduled to begin — used for forward-looking pipeline and pacing reports."
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year the event is scheduled to begin — supports annual trend and year-over-year comparisons."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the original inquiry was received — used to measure lead-to-booking velocity and pipeline aging."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Indicates whether the deposit has been collected, supporting cash-flow and commitment tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier enabling property-level performance benchmarking."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of event booking records — baseline volume KPI for pipeline and throughput reporting."
    - name: "definite_bookings"
      expr: COUNT(CASE WHEN booking_status = 'Definite' THEN 1 END)
      comment: "Count of bookings in Definite status — the confirmed revenue pipeline that drives operational planning."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Sum of all contracted booking values — total committed revenue pipeline across all statuses."
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per booking — indicates deal size trends and mix shifts over time."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected or expected across bookings — cash-flow and commitment indicator."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission liability across bookings — cost-of-acquisition metric for channel profitability analysis."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across bookings — monitors channel cost efficiency and negotiation outcomes."
    - name: "total_attrition_penalty"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalties incurred — measures revenue leakage from under-delivery against contracted room blocks."
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total value of concessions granted to clients — tracks discounting and negotiation give-aways impacting net revenue."
    - name: "avg_attrition_clause_pct"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition clause threshold across bookings — indicates contractual risk exposure in the portfolio."
    - name: "deposit_collection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deposit_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings where deposit has been received — cash-flow health and commitment quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial performance metrics for event revenue, covering actuals vs. budget, net revenue, service charges, taxes, and RevPAR/TRevPAR contributions. Primary KPI layer for Finance and Revenue Management."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_revenue`"
  filter: is_voided = FALSE
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "High-level revenue category (e.g., F&B, AV, Space Rental, Room Block) — enables revenue mix analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating the revenue (e.g., Conference, Wedding, Gala) — supports segment-level P&L."
    - name: "revenue_source"
      expr: revenue_source
      comment: "Origin of the revenue stream — used to attribute revenue to channels and booking sources."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the revenue record — critical for accounts receivable and cash-flow management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue record — required for multi-currency financial consolidation."
    - name: "revenue_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Month of revenue recognition — primary time dimension for monthly financial reporting."
    - name: "revenue_year"
      expr: YEAR(revenue_date)
      comment: "Year of revenue recognition — supports annual trend and year-over-year variance analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the revenue was posted to the GL — used for period-close reconciliation."
    - name: "subcategory"
      expr: subcategory
      comment: "Granular revenue sub-classification within a category — enables detailed P&L drill-down."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level revenue benchmarking and portfolio analysis."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code — links event revenue to the chart of accounts for financial reporting."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual event revenue recognized — primary top-line financial KPI for the event business."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted event revenue — baseline for variance and forecast accuracy analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments — the true economic contribution of the event portfolio."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total actual-vs-budget variance — measures forecast accuracy and identifies over/under-performance."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected — ancillary revenue stream and labor cost recovery metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event revenue — required for tax compliance and remittance reporting."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on event revenue — cost-of-acquisition metric for net revenue calculation."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments posted — monitors correction activity and potential revenue integrity issues."
    - name: "avg_revenue_per_attendee"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue generated per attendee — yield efficiency metric used to benchmark event profitability."
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks associated with events — key pricing performance indicator."
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event revenue — measures the event segment's impact on overall room yield."
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from event revenue — measures total revenue per available room driven by events."
    - name: "budget_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Actual revenue as a percentage of budgeted revenue — primary financial performance vs. plan KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead pipeline and conversion funnel metrics for event inquiries. Enables Sales leadership to monitor lead volume, qualification rates, budget sizing, and pipeline health."
  source: "`vibe_travel_hospitality_v1`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (e.g., New, Qualified, Converted, Lost) — primary funnel stage dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of event being inquired about — enables segment-level lead volume and conversion analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the inquiring client — supports targeted sales strategy and segment mix reporting."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification tier — used to prioritize sales effort and measure pipeline quality."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the inquiry was received — primary time dimension for lead volume trending."
    - name: "inquiry_year"
      expr: YEAR(inquiry_date)
      comment: "Year the inquiry was received — supports annual lead volume and conversion trend analysis."
    - name: "catering_required_flag"
      expr: catering_required_flag
      comment: "Whether catering is required — used to size F&B pipeline and resource planning."
    - name: "av_equipment_required_flag"
      expr: av_equipment_required_flag
      comment: "Whether AV equipment is required — used to size AV revenue pipeline and operational readiness."
    - name: "property_id"
      expr: property_id
      comment: "Property the inquiry is directed to — enables property-level pipeline and conversion benchmarking."
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received — top-of-funnel volume KPI for sales pipeline management."
    - name: "converted_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Number of inquiries that converted to a booking — measures sales effectiveness and funnel throughput."
    - name: "lost_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Lost' THEN 1 END)
      comment: "Number of inquiries lost to competitors or abandoned — identifies win/loss trends and competitive pressure."
    - name: "inquiry_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries that convert to bookings — primary sales funnel efficiency KPI."
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget declared by inquiring clients — indicates addressable deal size and market positioning."
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum budget declared by inquiring clients — lower bound of addressable pipeline value."
    - name: "total_budget_range_max"
      expr: SUM(CAST(budget_range_max AS DOUBLE))
      comment: "Total maximum budget across all open inquiries — upper-bound pipeline value for revenue forecasting."
    - name: "qualified_inquiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries that reach qualified status — measures lead quality and sales qualification efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline metrics covering win rates, revenue estimates, pricing, and proposal cycle times. Used by Sales and Revenue Management to optimize proposal strategy and close rates."
  source: "`vibe_travel_hospitality_v1`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., Draft, Sent, Accepted, Declined) — primary funnel stage for proposal pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of the proposal — tracks compliance with pricing authority and approval workflows."
    - name: "event_type"
      expr: event_type
      comment: "Type of event the proposal covers — enables segment-level win rate and revenue analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the proposal originated — supports channel-level ROI and conversion analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal — required for multi-currency pipeline valuation."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the proposal was issued — primary time dimension for proposal volume and velocity trending."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the proposed event would begin — used for forward-looking revenue pacing."
    - name: "property_id"
      expr: property_id
      comment: "Property the proposal is for — enables property-level win rate and pipeline benchmarking."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals issued — baseline volume KPI for sales activity and pipeline depth."
    - name: "accepted_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Accepted' THEN 1 END)
      comment: "Number of proposals accepted by clients — measures sales close effectiveness."
    - name: "proposal_win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN proposal_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proposals that are accepted — primary sales conversion KPI for the proposal stage."
    - name: "total_estimated_revenue_pipeline"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all proposals — forward-looking pipeline value for revenue forecasting."
    - name: "avg_estimated_revenue_per_proposal"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per proposal — indicates deal size trends and mix shifts in the pipeline."
    - name: "total_av_package_value"
      expr: SUM(CAST(av_package_amount AS DOUBLE))
      comment: "Total AV package revenue in the proposal pipeline — measures ancillary revenue opportunity."
    - name: "total_fb_minimum_pipeline"
      expr: SUM(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Total F&B minimum commitments across proposals — forward-looking F&B revenue floor for operational planning."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across proposals — monitors channel cost and pricing discipline."
    - name: "avg_room_block_rate"
      expr: AVG(CAST(room_block_rate AS DOUBLE))
      comment: "Average room block rate offered in proposals — tracks group pricing strategy and rate competitiveness."
    - name: "avg_client_feedback_score"
      expr: AVG(CAST(client_feedback AS DOUBLE))
      comment: "Average client feedback score on proposals — measures proposal quality and client satisfaction with the sales process."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio metrics covering contracted revenue, attrition risk, deposit schedules, and legal compliance. Used by Finance, Legal, and Revenue Management to manage contractual obligations and risk."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g., Draft, Executed, Expired, Cancelled) — primary lifecycle dimension."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of event contract — enables analysis by contract structure and associated risk profile."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency financial exposure reporting."
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Whether credit has been approved for this contract — tracks credit risk exposure in the portfolio."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether the contract has undergone legal review — compliance and risk management dimension."
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Whether billing is consolidated to a master account — used for corporate account revenue attribution."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the contract was executed — primary time dimension for contract volume and revenue commitment trending."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract becomes effective — used for forward-looking revenue recognition scheduling."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of event contracts — baseline volume KPI for contract portfolio management."
    - name: "executed_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Executed' THEN 1 END)
      comment: "Number of fully executed contracts — measures committed, legally binding revenue pipeline."
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total contracted revenue across all contracts — the legally committed top-line revenue portfolio."
    - name: "avg_contracted_revenue"
      expr: AVG(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Average contracted revenue per contract — indicates deal size trends and portfolio mix."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue contracted — measures the F&B component of the event revenue portfolio."
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue contracted in event contracts — measures group room block revenue commitments."
    - name: "total_space_rental_revenue"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total function space rental revenue contracted — measures space utilization revenue commitments."
    - name: "total_av_equipment_revenue"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total AV equipment revenue contracted — measures ancillary technology revenue in the portfolio."
    - name: "total_initial_deposit"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposits required across contracts — cash-flow planning and commitment quality indicator."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold across contracts — measures portfolio-level contractual risk exposure."
    - name: "legal_review_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that have undergone legal review — compliance and risk governance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order (BEO) operational and financial metrics covering revenue realization, service charge economics, and event execution quality. Used by Catering Operations and F&B Management."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (e.g., Draft, Confirmed, Completed, Cancelled) — primary operational lifecycle dimension."
    - name: "function_type"
      expr: function_type
      comment: "Type of function covered by the BEO (e.g., Dinner, Reception, Meeting) — enables function-level revenue analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration (e.g., Banquet, Theater, Classroom) — used for space utilization and labor planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO — required for multi-currency revenue reporting."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event — primary time dimension for BEO volume and revenue trending."
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of the event — supports annual BEO volume and revenue trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property where the BEO event takes place — enables property-level operational benchmarking."
  measures:
    - name: "total_beos"
      expr: COUNT(1)
      comment: "Total number of BEOs — baseline operational volume KPI for catering and event execution planning."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue realized from BEOs — primary financial outcome KPI for catering operations."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across BEOs — forward-looking catering revenue pipeline."
    - name: "avg_actual_revenue_per_beo"
      expr: AVG(CAST(actual_revenue AS DOUBLE))
      comment: "Average actual revenue per BEO — measures event yield and catering productivity."
    - name: "revenue_realization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_revenue AS DOUBLE)), 0), 2)
      comment: "Actual revenue as a percentage of estimated revenue — measures forecast accuracy and upsell/downsell dynamics in catering."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge rate applied across BEOs — monitors pricing consistency and labor cost recovery."
    - name: "avg_tax_percentage"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax rate applied across BEOs — supports tax compliance monitoring and rate consistency checks."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and pricing metrics covering capacity, rental rates, and space characteristics. Used by Revenue Management and Operations to optimize space utilization and pricing strategy."
  source: "`vibe_travel_hospitality_v1`.`event`.`function_space`"
  filter: operational_status = 'Active'
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Classification of the function space (e.g., Ballroom, Boardroom, Breakout) — primary inventory segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space — used to filter active inventory for utilization analysis."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into smaller sections — impacts capacity planning and multi-event scheduling."
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Whether the space is outdoors — used for weather-dependent event planning and seasonal demand analysis."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Whether the space meets accessibility requirements — compliance and inclusivity reporting dimension."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether the space has natural light — a client preference dimension affecting booking demand."
    - name: "property_id"
      expr: property_id
      comment: "Property the function space belongs to — enables property-level inventory and pricing benchmarking."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the function space — used for operational logistics and client preference analysis."
  measures:
    - name: "total_function_spaces"
      expr: COUNT(1)
      comment: "Total number of active function spaces in inventory — baseline capacity KPI for event operations."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of function space inventory — measures physical capacity available for events."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space — indicates typical space size and suitability for event types."
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate across function spaces — primary pricing benchmark for space revenue management."
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate — used for pricing strategy and rate card optimization."
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate — supports flexible pricing and short-duration event revenue optimization."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across function spaces — operational specification metric for event suitability assessment."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required per space — operational efficiency metric impacting event turnaround capacity."
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time per space — combined with setup time determines minimum turnaround between events."
    - name: "revenue_per_sqft_full_day"
      expr: ROUND(SUM(CAST(rental_rate_full_day AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 2)
      comment: "Full-day rental revenue per square foot across the portfolio — space yield efficiency KPI for pricing optimization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space allocation utilization and revenue metrics covering rental charges, allocation status, and event type mix. Used by Revenue Management and Operations to maximize space utilization and identify scheduling inefficiencies."
  source: "`vibe_travel_hospitality_v1`.`event`.`space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (e.g., Tentative, Confirmed, Released) — primary utilization pipeline dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of event using the allocated space — enables event-type-level space demand and revenue analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration for the allocation — used for operational planning and turnaround scheduling."
    - name: "space_block_type"
      expr: space_block_type
      comment: "Type of space block (e.g., Definite, Tentative, Wash) — critical for accurate availability and yield management."
    - name: "booking_segment"
      expr: booking_segment
      comment: "Market segment of the booking using the space — enables segment-level space demand analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the space allocation is complimentary — used to track concession costs and comp space policies."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the space allocation — primary time dimension for utilization trending and pacing."
    - name: "property_id"
      expr: property_id
      comment: "Property where the space is allocated — enables property-level utilization benchmarking."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of space allocations — baseline volume KPI for space demand and scheduling activity."
    - name: "confirmed_allocations"
      expr: COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END)
      comment: "Number of confirmed space allocations — measures committed space utilization pipeline."
    - name: "complimentary_allocations"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Number of complimentary space allocations — tracks concession volume and associated revenue opportunity cost."
    - name: "total_rental_charge"
      expr: SUM(CAST(rental_charge_amount AS DOUBLE))
      comment: "Total rental charges across all space allocations — primary space revenue KPI for utilization management."
    - name: "avg_rental_charge_per_allocation"
      expr: AVG(CAST(rental_charge_amount AS DOUBLE))
      comment: "Average rental charge per space allocation — measures yield per booking and pricing effectiveness."
    - name: "confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations that reach confirmed status — measures tentative-to-definite conversion efficiency."
    - name: "complimentary_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations that are complimentary — monitors concession policy adherence and revenue leakage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_catering_menu`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering menu portfolio metrics covering pricing, cost, margin, and operational characteristics. Used by F&B Management and Revenue Management to optimize menu mix, pricing strategy, and profitability."
  source: "`vibe_travel_hospitality_v1`.`event`.`catering_menu`"
  filter: active_status = 'Active'
  dimensions:
    - name: "menu_category"
      expr: menu_category
      comment: "High-level menu category (e.g., Breakfast, Lunch, Dinner, Reception) — primary menu portfolio segmentation."
    - name: "menu_type"
      expr: menu_type
      comment: "Type of menu offering (e.g., Buffet, Plated, Stations) — used for service style analysis and labor planning."
    - name: "cuisine_style"
      expr: cuisine_style
      comment: "Cuisine style of the menu — enables demand analysis by culinary preference and market positioning."
    - name: "service_style"
      expr: service_style
      comment: "Service delivery style — impacts labor cost and client experience, used for margin analysis."
    - name: "contains_alcohol"
      expr: contains_alcohol
      comment: "Whether the menu includes alcohol — used for licensing compliance and beverage revenue mix analysis."
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Whether the menu is sustainability certified — supports ESG reporting and premium pricing analysis."
    - name: "requires_specialty_equipment"
      expr: requires_specialty_equipment
      comment: "Whether the menu requires specialty equipment — operational complexity and cost driver dimension."
    - name: "active_status"
      expr: active_status
      comment: "Whether the menu is currently active — used to filter live portfolio for pricing and demand analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property offering the menu — enables property-level menu portfolio and margin benchmarking."
  measures:
    - name: "total_menu_items"
      expr: COUNT(1)
      comment: "Total number of active catering menu items — baseline portfolio size KPI for menu management."
    - name: "avg_price_per_person"
      expr: AVG(CAST(price_per_person AS DOUBLE))
      comment: "Average menu price per person — primary pricing benchmark for catering revenue optimization."
    - name: "avg_cost_per_person"
      expr: AVG(CAST(cost_per_person AS DOUBLE))
      comment: "Average menu cost per person — key input for gross margin and food cost percentage analysis."
    - name: "avg_contribution_margin_pct"
      expr: AVG(CAST(contribution_margin_percent AS DOUBLE))
      comment: "Average contribution margin percentage across menus — primary profitability KPI for menu portfolio management."
    - name: "avg_preparation_lead_time_hours"
      expr: AVG(CAST(preparation_lead_time_hours AS DOUBLE))
      comment: "Average preparation lead time across menus — operational planning metric for kitchen capacity management."
    - name: "avg_service_duration_minutes"
      expr: AVG(CAST(service_duration_minutes AS DOUBLE))
      comment: "Average service duration per menu — impacts event scheduling, space turnaround, and labor planning."
    - name: "avg_labor_intensity_rating"
      expr: AVG(CAST(labor_intensity_rating AS DOUBLE))
      comment: "Average labor intensity rating across menus — used to forecast staffing requirements and labor cost."
    - name: "price_to_cost_ratio"
      expr: ROUND(AVG(CAST(price_per_person AS DOUBLE)) / NULLIF(AVG(CAST(cost_per_person AS DOUBLE)), 0), 2)
      comment: "Ratio of average price to average cost per person — measures overall menu pricing power and margin health."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event account portfolio metrics covering spend, credit, and account health. Used by Sales and Finance to manage corporate account relationships, credit risk, and lifetime value."
  source: "`vibe_travel_hospitality_v1`.`event`.`account`"
  filter: account_status = 'Active'
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive, Closed) — primary account health dimension."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., Corporate, Association, Government) — enables segment-level portfolio analysis."
    - name: "tier"
      expr: tier
      comment: "Account tier classification — used for tiered service delivery and revenue concentration analysis."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account — primary risk dimension for accounts receivable and credit management."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the account — enables vertical-level demand and revenue analysis."
    - name: "is_national_account"
      expr: is_national_account
      comment: "Whether the account is a national account — used to segment strategic vs. local account performance."
    - name: "is_vip_account"
      expr: is_vip_account
      comment: "Whether the account has VIP status — used for high-value account monitoring and service prioritization."
    - name: "preferred_event_type"
      expr: preferred_event_type
      comment: "Preferred event type for the account — used for targeted sales outreach and demand forecasting."
    - name: "sales_territory_code"
      expr: sales_territory_code
      comment: "Sales territory assigned to the account — enables territory-level performance and quota tracking."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of active event accounts — baseline portfolio size KPI for sales coverage analysis."
    - name: "total_lifetime_event_spend"
      expr: SUM(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Total lifetime event spend across all accounts — measures cumulative revenue contribution of the account portfolio."
    - name: "avg_lifetime_event_spend"
      expr: AVG(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Average lifetime event spend per account — key customer lifetime value (CLV) metric for account prioritization."
    - name: "avg_event_spend_amount"
      expr: AVG(CAST(average_event_spend_amount AS DOUBLE))
      comment: "Average per-event spend across accounts — measures typical deal size and account productivity."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across the account portfolio — measures aggregate credit risk exposure."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account — used to benchmark credit policy and identify outliers."
    - name: "total_events_booked"
      expr: SUM(CAST(total_events_booked_count AS DOUBLE))
      comment: "Total events booked across all accounts — measures account engagement and booking activity volume."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across accounts — cash-flow and working capital management metric."
    - name: "vip_account_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip_account = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with VIP status — measures concentration of high-value relationships in the portfolio."
$$;