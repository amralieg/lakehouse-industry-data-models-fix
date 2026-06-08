-- Metric views for domain: route | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core route financial and operational performance KPIs covering revenue, cost, yield, load factor, and on-time performance. Primary steering dashboard for network planning and revenue management executives."
  source: "`airlines_ecm`.`route`.`performance`"
  dimensions:
    - name: "route_id"
      expr: route_id
      comment: "Foreign key to the route entity — enables slicing all KPIs by individual route."
    - name: "schedule_season_id"
      expr: schedule_season_id
      comment: "Foreign key to the schedule season — enables seasonal trend analysis (Summer vs Winter IATA seasons)."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Granularity of the measurement period (e.g. monthly, quarterly, annual) — controls time-series aggregation level."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the performance measurement window — used for time-series trending and period-over-period comparisons."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End date of the performance measurement window — paired with start date to define the reporting interval."
    - name: "grade"
      expr: grade
      comment: "Performance grade assigned to the route (e.g. A, B, C, D) — enables tiered route portfolio analysis."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency in which cost figures are denominated — essential for multi-currency fleet and network cost comparisons."
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency in which revenue figures are denominated — required for consistent revenue reporting across regions."
    - name: "cost_centre_id"
      expr: cost_centre_id
      comment: "Foreign key to the finance cost centre — enables P&L attribution by business unit or hub."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated across all routes in the selected period. Primary top-line KPI for network revenue management and board reporting."
    - name: "total_cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total operating cost across all routes in the selected period. Drives cost efficiency analysis and budget variance reviews."
    - name: "avg_load_factor_percent"
      expr: AVG(CAST(load_factor_percent AS DOUBLE))
      comment: "Average passenger load factor (%) across routes — the primary capacity utilisation KPI. A sustained drop below threshold triggers capacity reallocation decisions."
    - name: "avg_otp_percent"
      expr: AVG(CAST(otp_percent AS DOUBLE))
      comment: "Average on-time performance (%) across routes. Directly linked to customer satisfaction scores, slot compliance, and regulatory reporting obligations."
    - name: "avg_rask"
      expr: AVG(CAST(rask AS DOUBLE))
      comment: "Average Revenue per Available Seat Kilometre (RASK) — the airline industry's primary revenue productivity KPI used in investor presentations and network strategy reviews."
    - name: "avg_cask"
      expr: AVG(CAST(cask AS DOUBLE))
      comment: "Average Cost per Available Seat Kilometre (CASK) — the primary cost efficiency KPI benchmarked against competitors and used in route profitability decisions."
    - name: "avg_yield"
      expr: AVG(CAST(yield AS DOUBLE))
      comment: "Average fare yield (revenue per RPK) — measures pricing power on a route. Declining yield triggers revenue management intervention."
    - name: "total_ask"
      expr: SUM(CAST(ask AS DOUBLE))
      comment: "Total Available Seat Kilometres (ASK) — measures deployed capacity. Used to normalise revenue and cost KPIs and track network growth."
    - name: "total_rpk"
      expr: SUM(CAST(rpk AS DOUBLE))
      comment: "Total Revenue Passenger Kilometres (RPK) — measures actual traffic carried. The industry standard demand volume metric reported to IATA and investors."
    - name: "avg_cancellation_rate_percent"
      expr: AVG(CAST(cancellation_rate_percent AS DOUBLE))
      comment: "Average flight cancellation rate (%) — a key operational reliability KPI. Elevated cancellation rates trigger operational review and may breach slot usage thresholds."
    - name: "avg_diversion_rate_percent"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average flight diversion rate (%) — indicates operational disruption frequency. High diversion rates signal safety, weather, or ATC systemic issues requiring investigation."
    - name: "avg_delay_minutes"
      expr: AVG(CAST(average_delay_minutes AS DOUBLE))
      comment: "Average delay in minutes per route — directly impacts customer satisfaction, crew duty time compliance, and downstream connection integrity."
    - name: "avg_block_time_minutes"
      expr: AVG(CAST(average_block_time_minutes AS DOUBLE))
      comment: "Average actual block time in minutes — compared against the block time standard to identify schedule padding inefficiencies or chronic under-scheduling."
    - name: "avg_block_time_variance_minutes"
      expr: AVG(CAST(block_time_variance_minutes AS DOUBLE))
      comment: "Average variance between planned and actual block time — high variance indicates schedule reliability issues and drives block time standard review cycles."
    - name: "route_count"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes with performance records in the period — provides the denominator context for all per-route average KPIs."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route network portfolio metrics covering distance, load factor, OTP, and route mix. Used by network planning teams to assess portfolio composition, competitive positioning, and route lifecycle management."
  source: "`airlines_ecm`.`route`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Operational status of the route (e.g. Active, Suspended, Planned) — primary filter for live network vs pipeline analysis."
    - name: "route_type"
      expr: route_type
      comment: "Classification of the route (e.g. Domestic, Short-haul International, Long-haul) — drives fleet assignment and pricing strategy segmentation."
    - name: "service_type"
      expr: service_type
      comment: "Service type on the route (e.g. Full-service, Low-cost, Charter) — enables competitive positioning analysis by service tier."
    - name: "profitability_tier"
      expr: profitability_tier
      comment: "Profitability tier assigned to the route (e.g. Tier 1, Tier 2, Tier 3) — used in portfolio prioritisation and capacity allocation decisions."
    - name: "operating_season"
      expr: operating_season
      comment: "Season in which the route operates (e.g. Year-round, Summer only, Winter only) — critical for seasonal capacity planning."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Boolean flag indicating whether the route is seasonal — used to separate perennial network from seasonal capacity."
    - name: "etops_required"
      expr: etops_required
      comment: "Boolean flag indicating whether ETOPS certification is required for this route — affects aircraft type eligibility and regulatory compliance tracking."
    - name: "codeshare_eligible"
      expr: codeshare_eligible
      comment: "Boolean flag indicating whether the route is eligible for codeshare operations — used in partnership revenue opportunity analysis."
    - name: "competitive_route_indicator"
      expr: competitive_route_indicator
      comment: "Boolean flag indicating whether the route faces direct competition — used to segment routes for yield management and pricing strategy."
    - name: "slot_controlled_origin"
      expr: slot_controlled_origin
      comment: "Boolean flag indicating whether the origin airport is slot-controlled — affects schedule flexibility and slot portfolio management."
    - name: "slot_controlled_destination"
      expr: slot_controlled_destination
      comment: "Boolean flag indicating whether the destination airport is slot-controlled — paired with origin flag to identify fully constrained routes."
    - name: "city_pair_id"
      expr: city_pair_id
      comment: "Foreign key to the city pair — enables market-level aggregation across multiple routes serving the same O&D pair."
    - name: "inaugural_date"
      expr: inaugural_date
      comment: "Date the route was first operated — used to calculate route age and assess maturity curve performance."
  measures:
    - name: "active_route_count"
      expr: COUNT(DISTINCT route_id)
      comment: "Total number of distinct routes in the network portfolio. The foundational network size KPI used in investor reporting and IATA filings."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average route distance in kilometres — indicates the network's long-haul vs short-haul mix, which drives fleet type requirements and cost structure."
    - name: "total_network_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total cumulative route distance across the network in kilometres — a proxy for network reach and geographic footprint."
    - name: "avg_load_factor_percent"
      expr: AVG(CAST(average_load_factor_percent AS DOUBLE))
      comment: "Average load factor (%) across all routes — the headline capacity utilisation KPI for the network portfolio, reported in quarterly earnings."
    - name: "avg_otp_percent"
      expr: AVG(CAST(average_otp_percent AS DOUBLE))
      comment: "Average on-time performance (%) across all routes — the primary operational reliability KPI for the network, used in customer satisfaction and regulatory reporting."
    - name: "competitive_route_count"
      expr: COUNT(DISTINCT CASE WHEN competitive_route_indicator = TRUE THEN route_id END)
      comment: "Number of routes facing direct competition — used to size the competitive exposure of the network and prioritise yield management resources."
    - name: "codeshare_eligible_route_count"
      expr: COUNT(DISTINCT CASE WHEN codeshare_eligible = TRUE THEN route_id END)
      comment: "Number of routes eligible for codeshare — quantifies the partnership revenue opportunity pipeline for alliance and commercial teams."
    - name: "etops_route_count"
      expr: COUNT(DISTINCT CASE WHEN etops_required = TRUE THEN route_id END)
      comment: "Number of routes requiring ETOPS certification — drives fleet certification planning and regulatory compliance workload for the airworthiness team."
    - name: "slot_constrained_route_count"
      expr: COUNT(DISTINCT CASE WHEN slot_controlled_origin = TRUE OR slot_controlled_destination = TRUE THEN route_id END)
      comment: "Number of routes with at least one slot-controlled airport — quantifies the slot portfolio management burden and schedule flexibility constraints."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet assignment efficiency and capacity deployment metrics. Used by network planning and fleet management teams to assess aircraft utilisation, capacity deployment, and assignment portfolio health."
  source: "`airlines_ecm`.`route`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (e.g. Active, Pending, Cancelled) — primary filter for live vs historical assignment analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of fleet assignment (e.g. Permanent, Temporary, Charter) — used to segment planned capacity from ad-hoc deployments."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority ranking of the assignment — used to resolve conflicts during schedule disruptions and fleet reallocation decisions."
    - name: "route_id"
      expr: route_id
      comment: "Foreign key to the route — enables fleet assignment analysis at the individual route level."
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Foreign key to the aircraft type — enables capacity and cost analysis segmented by aircraft family."
    - name: "schedule_season_id"
      expr: schedule_season_id
      comment: "Foreign key to the schedule season — enables seasonal fleet deployment comparison."
    - name: "etops_required_flag"
      expr: etops_required_flag
      comment: "Boolean flag indicating whether ETOPS capability is required for this assignment — used to validate aircraft eligibility against route requirements."
    - name: "codeshare_eligible_flag"
      expr: codeshare_eligible_flag
      comment: "Boolean flag indicating whether this assignment supports codeshare operations — used in partnership capacity planning."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the fleet assignment is effective — used for timeline analysis of fleet deployment changes."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date on which the fleet assignment expires — used to identify upcoming reallocation events and plan transitions."
  measures:
    - name: "total_planned_ask"
      expr: SUM(CAST(planned_ask_capacity AS DOUBLE))
      comment: "Total planned Available Seat Kilometres (ASK) across all fleet assignments — the primary capacity deployment volume KPI used in network planning and investor guidance."
    - name: "avg_planned_ask"
      expr: AVG(CAST(planned_ask_capacity AS DOUBLE))
      comment: "Average planned ASK per fleet assignment — used to compare capacity deployment intensity across routes and aircraft types."
    - name: "avg_target_load_factor_percent"
      expr: AVG(CAST(target_load_factor_percent AS DOUBLE))
      comment: "Average target load factor (%) set at assignment time — benchmarked against actual load factor from performance data to assess planning accuracy."
    - name: "total_cargo_belly_capacity_kg"
      expr: SUM(CAST(cargo_belly_capacity_kg AS DOUBLE))
      comment: "Total belly cargo capacity in kilograms across all fleet assignments — used by cargo revenue management to size belly cargo revenue opportunity."
    - name: "total_cargo_belly_capacity_m3"
      expr: SUM(CAST(cargo_belly_capacity_m3 AS DOUBLE))
      comment: "Total belly cargo volume capacity in cubic metres — used alongside weight capacity to identify volume vs weight constrained cargo operations."
    - name: "fleet_assignment_count"
      expr: COUNT(DISTINCT fleet_assignment_id)
      comment: "Total number of distinct fleet assignments — provides the portfolio size context for all per-assignment average KPIs."
    - name: "etops_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN etops_required_flag = TRUE THEN fleet_assignment_id END)
      comment: "Number of fleet assignments requiring ETOPS-certified aircraft — drives airworthiness compliance planning and fleet certification investment decisions."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_slot_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Airport slot portfolio utilisation and compliance metrics. Used by slot management and network planning teams to monitor slot usage rates, identify at-risk slots, and manage slot return obligations under IATA guidelines."
  source: "`airlines_ecm`.`route`.`slot_allocation`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the slot (e.g. Confirmed, Pending, Returned, Cancelled) — primary filter for active slot portfolio analysis."
    - name: "slot_type"
      expr: slot_type
      comment: "Type of slot (e.g. Arrival, Departure) — used to balance arrival/departure slot portfolios at coordinated airports."
    - name: "slot_series_type"
      expr: slot_series_type
      comment: "Series classification of the slot (e.g. Historic, New Entrant, Ad-hoc) — determines slot priority and use-it-or-lose-it compliance obligations."
    - name: "slot_coordination_level"
      expr: slot_coordination_level
      comment: "IATA coordination level of the airport (Level 1, 2, or 3) — determines the regulatory compliance burden and slot management complexity."
    - name: "slot_movement_type"
      expr: slot_movement_type
      comment: "Type of slot movement (e.g. Original, Swap, Return) — used to track slot portfolio changes and bilateral swap activity."
    - name: "historical_precedence_flag"
      expr: historical_precedence_flag
      comment: "Boolean flag indicating whether the slot carries grandfather rights — critical for assessing the strategic value of the slot portfolio."
    - name: "environmental_restriction_flag"
      expr: environmental_restriction_flag
      comment: "Boolean flag indicating whether the slot is subject to environmental restrictions (e.g. night curfew) — affects operational planning and fleet type selection."
    - name: "route_id"
      expr: route_id
      comment: "Foreign key to the route — enables slot analysis at the route level to identify slot-constrained routes."
    - name: "station_id"
      expr: station_id
      comment: "Foreign key to the airport station — enables slot portfolio analysis by airport, the primary unit of slot management."
    - name: "schedule_season_id"
      expr: schedule_season_id
      comment: "Foreign key to the schedule season — enables season-over-season slot portfolio comparison."
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date from which the slot allocation is effective — used for timeline analysis of slot portfolio changes."
  measures:
    - name: "total_slot_count"
      expr: COUNT(DISTINCT slot_allocation_id)
      comment: "Total number of slots in the portfolio — the foundational slot inventory KPI used in IATA slot conference planning and regulatory filings."
    - name: "avg_slot_usage_percentage"
      expr: AVG(CAST(slot_usage_percentage AS DOUBLE))
      comment: "Average slot usage rate (%) across the portfolio — the primary IATA use-it-or-lose-it compliance KPI. Slots falling below the 80% threshold risk being forfeited to competitors."
    - name: "avg_slot_priority_score"
      expr: AVG(CAST(slot_priority_score AS DOUBLE))
      comment: "Average slot priority score across the portfolio — used to assess the strategic quality of the slot portfolio and prioritise slot defence efforts."
    - name: "historic_precedence_slot_count"
      expr: COUNT(DISTINCT CASE WHEN historical_precedence_flag = TRUE THEN slot_allocation_id END)
      comment: "Number of slots with grandfather (historic precedence) rights — quantifies the strategically protected portion of the slot portfolio, a key competitive moat metric."
    - name: "at_risk_slot_count"
      expr: COUNT(DISTINCT CASE WHEN slot_usage_percentage < 80.0 THEN slot_allocation_id END)
      comment: "Number of slots with usage below the IATA 80% use-it-or-lose-it threshold — directly actionable metric triggering slot return or schedule adjustment decisions."
    - name: "environmentally_restricted_slot_count"
      expr: COUNT(DISTINCT CASE WHEN environmental_restriction_flag = TRUE THEN slot_allocation_id END)
      comment: "Number of slots subject to environmental restrictions — used in sustainability reporting and fleet noise compliance planning."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_seasonal_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal schedule capacity and deployment metrics. Used by schedule planning and revenue management teams to monitor planned seat capacity, codeshare deployment, and schedule filing status across seasons."
  source: "`airlines_ecm`.`route`.`seasonal_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the seasonal schedule record (e.g. Filed, Approved, Cancelled) — primary filter for active vs historical schedule analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type for the scheduled operation (e.g. Passenger, Cargo, Charter) — used to segment capacity planning by service category."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Boolean flag indicating whether the scheduled flight operates as a codeshare — used to separate own-metal capacity from partner-operated capacity."
    - name: "route_id"
      expr: route_id
      comment: "Foreign key to the route — enables schedule capacity analysis at the individual route level."
    - name: "schedule_season_id"
      expr: schedule_season_id
      comment: "Foreign key to the schedule season — the primary time dimension for seasonal capacity planning comparisons."
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Foreign key to the aircraft type — enables capacity analysis segmented by aircraft family to support fleet planning."
    - name: "days_of_operation"
      expr: days_of_operation
      comment: "Days of the week on which the flight operates (e.g. 1234567) — used to assess weekly frequency patterns and identify thin-frequency routes."
    - name: "meal_service_code"
      expr: meal_service_code
      comment: "Meal service code for the flight — used in catering cost planning and product differentiation analysis."
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date from which the seasonal schedule record is effective — used for schedule change timeline analysis."
    - name: "effective_to_date"
      expr: effective_to_date
      comment: "Date on which the seasonal schedule record expires — used to identify upcoming schedule transitions."
  measures:
    - name: "total_planned_ask"
      expr: SUM(CAST(ask_planned AS DOUBLE))
      comment: "Total planned Available Seat Kilometres (ASK) across all seasonal schedule records — the primary forward-looking capacity deployment KPI used in network planning and investor guidance."
    - name: "avg_planned_ask"
      expr: AVG(CAST(ask_planned AS DOUBLE))
      comment: "Average planned ASK per seasonal schedule record — used to compare capacity intensity across routes and seasons."
    - name: "scheduled_flight_count"
      expr: COUNT(DISTINCT seasonal_schedule_id)
      comment: "Total number of distinct scheduled flight records — provides the schedule volume context for capacity and frequency analysis."
    - name: "codeshare_flight_count"
      expr: COUNT(DISTINCT CASE WHEN codeshare_indicator = TRUE THEN seasonal_schedule_id END)
      comment: "Number of scheduled flights operating as codeshares — quantifies the codeshare capacity contribution and partner dependency in the schedule."
    - name: "own_metal_flight_count"
      expr: COUNT(DISTINCT CASE WHEN codeshare_indicator = FALSE THEN seasonal_schedule_id END)
      comment: "Number of scheduled flights operated on own-metal (non-codeshare) — the core network capacity metric excluding partner-operated flights."
    - name: "distinct_route_count"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes covered by the seasonal schedule — measures the breadth of the scheduled network for a given season."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_codeshare_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Codeshare agreement portfolio metrics covering revenue share, agreement status, and partnership terms. Used by commercial and alliance teams to manage the codeshare agreement lifecycle and revenue sharing arrangements."
  source: "`airlines_ecm`.`route`.`codeshare_agreement`"
  dimensions:
    - name: "codeshare_agreement_status"
      expr: codeshare_agreement_status
      comment: "Current status of the codeshare agreement (e.g. Active, Expired, Terminated) — primary filter for live vs historical agreement analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of codeshare arrangement (e.g. Free-flow, Block-space) — determines revenue sharing mechanics and inventory control obligations."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Status of regulatory approval for the agreement — used to track compliance pipeline and identify agreements at risk of regulatory rejection."
    - name: "inventory_control_party"
      expr: inventory_control_party
      comment: "Party controlling inventory under the agreement (Operating or Marketing carrier) — determines revenue management authority and yield optimisation responsibility."
    - name: "revenue_share_model"
      expr: revenue_share_model
      comment: "Revenue sharing model applied (e.g. Prorate, Fixed-fee, Percentage) — used to segment agreements by financial structure for commercial review."
    - name: "alliance_affiliation"
      expr: alliance_affiliation
      comment: "Alliance affiliation of the codeshare agreement (e.g. Star Alliance, oneworld, SkyTeam) — used to analyse codeshare portfolio by alliance grouping."
    - name: "frequent_flyer_accrual_allowed"
      expr: frequent_flyer_accrual_allowed
      comment: "Boolean flag indicating whether frequent flyer miles accrue on codeshare flights — affects loyalty programme attractiveness and partner selection decisions."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the codeshare agreement is effective — used for agreement lifecycle and renewal pipeline analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date on which the codeshare agreement expires — used to identify agreements requiring renewal action within planning horizons."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT codeshare_agreement_id)
      comment: "Total number of codeshare agreements in the portfolio — the foundational partnership portfolio size KPI used in alliance and commercial reporting."
    - name: "avg_marketing_carrier_share_pct"
      expr: AVG(CAST(marketing_carrier_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage retained by the marketing carrier — used to benchmark commercial terms across the codeshare portfolio and negotiate renewals."
    - name: "avg_operating_carrier_share_pct"
      expr: AVG(CAST(operating_carrier_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage allocated to the operating carrier — paired with marketing carrier share to validate that revenue splits sum correctly across the portfolio."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN codeshare_agreement_id END)
      comment: "Number of agreements with auto-renewal enabled — used to identify agreements that will roll over without active commercial review, a governance risk metric."
    - name: "ffp_accrual_eligible_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN frequent_flyer_accrual_allowed = TRUE THEN codeshare_agreement_id END)
      comment: "Number of codeshare agreements enabling frequent flyer accrual — quantifies the loyalty programme reach extension through partner agreements."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_block_time_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block time standard accuracy and schedule reliability metrics. Used by schedule planning and operations teams to monitor planned vs historical block times, assess schedule padding, and manage block time standard review cycles."
  source: "`airlines_ecm`.`route`.`block_time_standard`"
  dimensions:
    - name: "block_time_standard_status"
      expr: block_time_standard_status
      comment: "Current status of the block time standard record (e.g. Active, Expired, Under Review) — primary filter for current vs historical standards."
    - name: "direction"
      expr: direction
      comment: "Direction of the flight (Outbound/Inbound) — block times typically differ by direction due to prevailing winds and ATC routing."
    - name: "seasonal_adjustment_type"
      expr: seasonal_adjustment_type
      comment: "Type of seasonal adjustment applied to the block time standard — used to assess the magnitude of seasonal schedule padding."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "IATA code of the origin airport — enables block time analysis by departure airport to identify ATC delay hotspots."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA code of the destination airport — enables block time analysis by arrival airport to identify congestion patterns."
    - name: "route_id"
      expr: route_id
      comment: "Foreign key to the route — enables block time standard analysis at the individual route level."
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Foreign key to the aircraft type — block times vary significantly by aircraft performance characteristics."
    - name: "schedule_season_id"
      expr: schedule_season_id
      comment: "Foreign key to the schedule season — enables seasonal block time standard comparison."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the block time standard is effective — used for timeline analysis of standard revisions."
    - name: "approval_date"
      expr: approval_date
      comment: "Date on which the block time standard was approved — used to track the review and approval cycle cadence."
  measures:
    - name: "avg_standard_deviation_minutes"
      expr: AVG(CAST(standard_deviation_minutes AS DOUBLE))
      comment: "Average standard deviation of block time in minutes — measures schedule predictability. High standard deviation indicates unreliable block time standards requiring revision."
    - name: "max_standard_deviation_minutes"
      expr: MAX(standard_deviation_minutes)
      comment: "Maximum standard deviation of block time across all standards — identifies the most unpredictable route/aircraft combinations requiring priority schedule review."
    - name: "block_time_standard_count"
      expr: COUNT(DISTINCT block_time_standard_id)
      comment: "Total number of block time standards in the portfolio — provides the inventory size context for standard review workload planning."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_interline_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline agreement portfolio metrics covering prorate terms, liability limits, and agreement status. Used by commercial and legal teams to manage interline partnership health and revenue settlement obligations."
  source: "`airlines_ecm`.`route`.`interline_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the interline agreement (e.g. Active, Expired, Suspended) — primary filter for live vs historical agreement analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of interline arrangement (e.g. Standard, Special Prorate, Bilateral) — determines revenue settlement mechanics and commercial terms."
    - name: "settlement_basis"
      expr: settlement_basis
      comment: "Basis on which interline revenue is settled (e.g. IATA prorate, Fixed fee) — used to segment agreements by financial settlement structure."
    - name: "prorate_basis"
      expr: prorate_basis
      comment: "Prorate methodology applied (e.g. Mileage, Equal split) — used to assess revenue allocation fairness and renegotiation opportunities."
    - name: "baggage_through_check_eligible"
      expr: baggage_through_check_eligible
      comment: "Boolean flag indicating whether through-check baggage is enabled — a key customer experience differentiator in interline itinerary quality."
    - name: "irop_reprotection_eligible"
      expr: irop_reprotection_eligible
      comment: "Boolean flag indicating whether the agreement covers IROP (Irregular Operations) reprotection — critical for assessing passenger recovery capability during disruptions."
    - name: "frequent_flyer_accrual_eligible"
      expr: frequent_flyer_accrual_eligible
      comment: "Boolean flag indicating whether frequent flyer miles accrue on interline itineraries — affects loyalty programme attractiveness."
    - name: "route_id"
      expr: route_id
      comment: "Foreign key to the route — enables interline agreement analysis at the route level."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the interline agreement is effective — used for agreement lifecycle and renewal pipeline analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date on which the interline agreement expires — used to identify agreements requiring renewal action."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT interline_agreement_id)
      comment: "Total number of interline agreements in the portfolio — the foundational interline network size KPI used in commercial partnership reporting."
    - name: "avg_prorate_percentage"
      expr: AVG(CAST(prorate_percentage AS DOUBLE))
      comment: "Average prorate percentage across interline agreements — used to benchmark revenue allocation terms and identify agreements with below-market prorate rates."
    - name: "avg_liability_limit_sdr"
      expr: AVG(CAST(liability_limit_sdr AS DOUBLE))
      comment: "Average liability limit in Special Drawing Rights (SDR) across interline agreements — used by legal and insurance teams to assess aggregate liability exposure."
    - name: "total_liability_limit_sdr"
      expr: SUM(CAST(liability_limit_sdr AS DOUBLE))
      comment: "Total aggregate liability limit in SDR across all interline agreements — used by risk management to size the maximum interline liability exposure for insurance provisioning."
    - name: "irop_eligible_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN irop_reprotection_eligible = TRUE THEN interline_agreement_id END)
      comment: "Number of interline agreements covering IROP reprotection — quantifies the disruption recovery network available to passengers on interline itineraries."
    - name: "through_check_eligible_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN baggage_through_check_eligible = TRUE THEN interline_agreement_id END)
      comment: "Number of interline agreements enabling through-check baggage — measures the quality of the interline network from a passenger experience perspective."
$$;