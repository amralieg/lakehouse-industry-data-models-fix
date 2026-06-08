-- Metric views for domain: revenue | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue performance KPI layer over daily property actuals. Covers room revenue, total revenue, occupancy, ADR, RevPAR, TRevPAR, GOPPAR, and competitive index metrics used in executive dashboards, QBRs, and owner reporting."
  source: "`travel_hospitality_ecm`.`revenue`.`performance_actuals`"
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Calendar date of the performance record, used for daily, weekly, and monthly trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level performance slicing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which revenue figures are denominated, critical for multi-currency portfolio reporting."
    - name: "loyalty_tier_id"
      expr: loyalty_tier_id
      comment: "Loyalty tier associated with the performance record, enabling tier-based revenue contribution analysis."
    - name: "primary_channel_id"
      expr: primary_channel_id
      comment: "Distribution channel that drove the booking, used for channel mix and cost-of-acquisition analysis."
    - name: "strategy_id"
      expr: strategy_id
      comment: "Revenue strategy in effect during the performance period, enabling strategy effectiveness evaluation."
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period for budget-vs-actual alignment and period-over-period comparisons."
    - name: "record_status"
      expr: record_status
      comment: "Reconciliation status of the performance record (e.g. reconciled, pending), used to filter for finalized data."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source PMS or RMS system that generated the record, used for data lineage and reconciliation."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total rooms revenue across all room types and segments. Primary top-line KPI for hotel revenue performance."
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total property revenue including rooms, F&B, spa, parking, and ancillary streams. Drives TRevPAR and owner NOI analysis."
    - name: "fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Food and beverage revenue contribution. Key non-rooms revenue stream for full-service and resort properties."
    - name: "ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Revenue from ancillary services (spa, parking, miscellaneous). Indicates upsell effectiveness and total guest spend."
    - name: "spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Spa and wellness revenue. Tracked separately for resort and luxury properties where spa is a strategic revenue center."
    - name: "parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Parking revenue. Relevant for urban properties where parking is a meaningful ancillary income stream."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate — average room rate achieved. Core pricing KPI used in every revenue management review."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Revenue Per Available Room — the primary yield metric combining occupancy and rate. Standard hotel industry KPI."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Total Revenue Per Available Room — includes all revenue streams. Used by owners and asset managers to evaluate total asset yield."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Gross Operating Profit Per Available Room — profitability yield metric. Critical for owner reporting and management fee calculations."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate (rooms sold / rooms available). Foundational demand metric used alongside ADR to compute RevPAR."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Cost Per Occupied Room — measures operational efficiency. Rising CPOR erodes GOP margin and triggers cost management action."
    - name: "total_gop"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Gross Operating Profit in absolute terms. Used in HMA contract compliance, owner distributions, and P&L reporting."
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "EBITDA contribution from the property. Used by finance and ownership for valuation, debt service coverage, and investment decisions."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Rate Index — measures rate performance relative to competitive set. ARI < 1 signals pricing underperformance vs. comp set."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Market Penetration Index — measures occupancy share relative to competitive set. MPI < 1 indicates demand capture underperformance."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Revenue Generation Index — composite competitive performance metric (RevPAR share vs. comp set). Primary STR benchmarking KPI."
    - name: "revpar_vs_prior_year"
      expr: AVG(CAST(revpar AS DOUBLE)) - AVG(CAST(prior_year_revpar AS DOUBLE))
      comment: "RevPAR variance versus prior year in absolute terms. Year-over-year growth signal used in board decks and investor reporting."
    - name: "avg_budget_adr"
      expr: AVG(CAST(budget_adr AS DOUBLE))
      comment: "Budgeted ADR for the period. Used alongside actual ADR to compute rate variance against plan."
    - name: "avg_budget_occupancy_rate"
      expr: AVG(CAST(budget_occupancy_rate AS DOUBLE))
      comment: "Budgeted occupancy rate. Used alongside actual occupancy to compute demand variance against plan."
    - name: "total_budget_room_revenue"
      expr: SUM(CAST(budget_room_revenue AS DOUBLE))
      comment: "Budgeted room revenue for the period. Used in budget-vs-actual variance reporting for revenue management and finance."
    - name: "total_budget_total_revenue"
      expr: SUM(CAST(budget_total_revenue AS DOUBLE))
      comment: "Budgeted total property revenue. Used in full P&L budget-vs-actual analysis."
    - name: "room_revenue_vs_budget"
      expr: SUM((CAST(total_room_revenue AS DOUBLE)) - (CAST(budget_room_revenue AS DOUBLE)))
      comment: "Room revenue variance versus budget in absolute terms. Negative values trigger revenue recovery actions."
    - name: "adr_vs_budget"
      expr: AVG(CAST(adr AS DOUBLE)) - AVG(CAST(budget_adr AS DOUBLE))
      comment: "ADR variance versus budget. Indicates whether pricing strategy is delivering planned rate levels."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting KPI layer covering projected occupancy, ADR, RevPAR, room revenue, and forecast accuracy. Used by revenue managers to evaluate forecast quality, adjust pricing strategies, and plan inventory controls."
  source: "`travel_hospitality_ecm`.`revenue`.`demand_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date on which the forecast was generated, used to track forecast evolution over time (pickup curve analysis)."
    - name: "property_id"
      expr: property_id
      comment: "Property for which the forecast applies, enabling property-level demand planning."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment the forecast applies to, enabling segment-level demand mix analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type dimension for room-type-level demand and yield forecasting."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. unconstrained, constrained, override), used to filter for the operative forecast version."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Forecasting model used (e.g. ARIMA, ML ensemble), enabling model performance benchmarking."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g. active, superseded), used to filter for current operative forecasts."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for the forecasted stay date, enabling day-of-week demand pattern analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Flag indicating whether the forecasted date is a holiday, used to segment demand by holiday vs. non-holiday periods."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Flag indicating a special event impacting demand, used to isolate event-driven demand spikes."
    - name: "is_override"
      expr: is_override
      comment: "Flag indicating a revenue manager override of the system forecast, used to measure override frequency and impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast revenue figures."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of the forecast (e.g. daily, weekly), used to filter for the appropriate planning horizon."
  measures:
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage across forecasted dates. Primary demand signal for inventory and pricing decisions."
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected ADR. Used to evaluate whether pricing strategy will deliver planned rate levels."
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected RevPAR. The headline yield forecast metric used in revenue strategy reviews."
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue across the forecast horizon. Used for financial planning and budget gap analysis."
    - name: "avg_unconstrained_demand"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE))
      comment: "Average unconstrained demand (demand before inventory limits). Measures true market demand and informs overbooking strategy."
    - name: "avg_constrained_demand"
      expr: AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Average constrained demand (demand after inventory limits). Reflects sellable demand given current inventory controls."
    - name: "demand_constraint_gap"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE)) - AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Gap between unconstrained and constrained demand. Large gaps indicate significant demand being turned away, signaling potential revenue leakage."
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Mean Absolute Percentage Error of the forecast model. Lower MAPE indicates higher forecast quality; used to evaluate and select forecasting models."
    - name: "avg_booking_pace_index"
      expr: AVG(CAST(booking_pace_index AS DOUBLE))
      comment: "Booking pace index relative to historical baseline. Values above 1 indicate faster-than-normal pace, triggering rate increase recommendations."
    - name: "avg_projected_pickup"
      expr: AVG(CAST(projected_pickup AS DOUBLE))
      comment: "Average projected incremental room pickup. Used to set sell limits and manage group vs. transient inventory allocation."
    - name: "avg_projected_cancellations"
      expr: AVG(CAST(projected_cancellations AS DOUBLE))
      comment: "Average projected cancellations. Used to calibrate overbooking levels and net demand estimates."
    - name: "avg_projected_no_shows"
      expr: AVG(CAST(projected_no_shows AS DOUBLE))
      comment: "Average projected no-shows. Used alongside cancellation forecasts to set overbooking policy and protect revenue."
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Forecasted Market Penetration Index. Used to assess whether projected occupancy will outperform or underperform the competitive set."
    - name: "avg_rgi_forecast"
      expr: AVG(CAST(rgi_forecast AS DOUBLE))
      comment: "Forecasted Revenue Generation Index. Composite competitive yield forecast used in strategy setting and comp set benchmarking."
    - name: "avg_ari_forecast"
      expr: AVG(CAST(ari_forecast AS DOUBLE))
      comment: "Forecasted Average Rate Index. Used to project rate competitiveness and inform pricing strategy adjustments."
    - name: "avg_demand_segment_mix_pct"
      expr: AVG(CAST(demand_segment_mix_pct AS DOUBLE))
      comment: "Average demand mix percentage for the segment. Used to monitor segment contribution shifts and optimize channel/segment strategy."
    - name: "forecast_override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Number of forecasts where a revenue manager override was applied. High override rates may indicate model drift or market anomalies."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_pickup_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking pace and pickup KPI layer tracking rooms on books, ADR on books, RevPAR on books, and pickup velocity across multiple lead-time windows. Used by revenue managers for daily pace monitoring and rate adjustment decisions."
  source: "`travel_hospitality_ecm`.`revenue`.`pickup_report`"
  dimensions:
    - name: "report_date"
      expr: report_date
      comment: "Date the pickup report was generated, used to track booking pace evolution over time."
    - name: "stay_date"
      expr: stay_date
      comment: "The future stay date being monitored, enabling forward-looking demand analysis by arrival date."
    - name: "property_id"
      expr: property_id
      comment: "Property for which the pickup is being tracked."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment dimension for segment-level pace analysis."
    - name: "revenue_rate_plan_id"
      expr: revenue_rate_plan_id
      comment: "Rate plan associated with the pickup, used to evaluate rate plan contribution to pace."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week of the stay date, enabling day-of-week pace pattern analysis."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for weekend vs. weekday pace comparison."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag to isolate event-driven pickup patterns."
    - name: "demand_level"
      expr: demand_level
      comment: "Demand level classification (e.g. high, medium, low) assigned by the RMS, used to contextualize pace performance."
    - name: "report_type"
      expr: report_type
      comment: "Type of pickup report (e.g. daily, weekly), used to filter for the appropriate reporting cadence."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate figures in the pickup report."
  measures:
    - name: "avg_adr_on_books"
      expr: AVG(CAST(adr_on_books AS DOUBLE))
      comment: "Average ADR currently on books for the stay date. Compared against forecasted ADR to assess rate achievement trajectory."
    - name: "avg_revpar_on_books"
      expr: AVG(CAST(revpar_on_books AS DOUBLE))
      comment: "Average RevPAR currently on books. Primary pace KPI used in daily revenue management stand-ups."
    - name: "avg_forecasted_adr"
      expr: AVG(CAST(forecasted_adr AS DOUBLE))
      comment: "Average forecasted ADR for the stay date. Baseline for measuring rate achievement gap."
    - name: "avg_forecasted_revpar"
      expr: AVG(CAST(forecasted_revpar AS DOUBLE))
      comment: "Average forecasted RevPAR. Used to compute RevPAR pace gap and trigger pricing interventions."
    - name: "avg_adr_variance_to_forecast"
      expr: AVG(CAST(adr_variance_to_forecast AS DOUBLE))
      comment: "Average ADR variance between on-books rate and forecast. Negative variance signals rate underperformance requiring pricing action."
    - name: "avg_pickup_velocity"
      expr: AVG(CAST(pickup_velocity AS DOUBLE))
      comment: "Average rate of new bookings being added per day. Declining velocity ahead of stay date triggers rate reduction or promotion decisions."
    - name: "avg_prior_year_adr"
      expr: AVG(CAST(prior_year_adr AS DOUBLE))
      comment: "Prior year ADR for the equivalent stay date. Used for year-over-year rate comparison in pace analysis."
    - name: "pickup_report_count"
      expr: COUNT(1)
      comment: "Number of pickup report records. Used to validate data completeness and coverage across properties and stay dates."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_group_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business evaluation KPI layer covering displacement analysis, group rate decisions, net revenue impact, and wash factor tracking. Used by revenue managers and sales teams to optimize group acceptance decisions and maximize total property revenue."
  source: "`travel_hospitality_ecm`.`revenue`.`group_evaluation`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the group is being evaluated, enabling property-level group business analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment of the group inquiry, used to analyze group mix by segment."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the group evaluation (e.g. pending, approved, declined), used to filter for actionable evaluations."
    - name: "revenue_manager_decision"
      expr: revenue_manager_decision
      comment: "Revenue manager accept/decline/counter decision, used to analyze decision patterns and outcomes."
    - name: "group_type"
      expr: group_type
      comment: "Type of group (e.g. corporate, association, leisure), used for group mix and profitability analysis by type."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date, used for forward-looking group demand analysis and displacement impact assessment."
    - name: "departure_date"
      expr: departure_date
      comment: "Group departure date, used alongside arrival date to compute group length of stay."
    - name: "is_definite_booking"
      expr: is_definite_booking
      comment: "Flag indicating whether the group has converted to a definite booking, used to track conversion rates."
    - name: "lead_time_bucket"
      expr: lead_time_bucket
      comment: "Lead time bucket (e.g. 0-30 days, 31-90 days) for the group inquiry, used to analyze booking window patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the group revenue figures."
  measures:
    - name: "total_group_room_revenue"
      expr: SUM(CAST(group_room_revenue AS DOUBLE))
      comment: "Total room revenue from group bookings. Primary group revenue contribution metric used in group vs. transient mix analysis."
    - name: "total_net_revenue_impact"
      expr: SUM(CAST(net_revenue_impact AS DOUBLE))
      comment: "Net revenue impact of accepting the group after accounting for displacement of transient business. Core group evaluation decision metric."
    - name: "total_displacement_cost"
      expr: SUM(CAST(displacement_cost AS DOUBLE))
      comment: "Total estimated revenue displaced from transient guests by accepting the group. Used to set minimum acceptable group rates."
    - name: "total_fb_revenue_estimate"
      expr: SUM(CAST(fb_revenue_estimate AS DOUBLE))
      comment: "Estimated F&B revenue contribution from the group. Included in total group value calculation for full-service properties."
    - name: "total_ancillary_revenue_estimate"
      expr: SUM(CAST(ancillary_revenue_estimate AS DOUBLE))
      comment: "Estimated ancillary revenue from the group (spa, parking, etc.). Used to compute total group value beyond room revenue."
    - name: "avg_proposed_group_rate"
      expr: AVG(CAST(proposed_group_rate AS DOUBLE))
      comment: "Average proposed group room rate. Compared against minimum acceptable rate and transient ADR to assess rate competitiveness."
    - name: "avg_minimum_acceptable_rate"
      expr: AVG(CAST(minimum_acceptable_rate AS DOUBLE))
      comment: "Average minimum acceptable rate for group acceptance. Used to enforce revenue management rate floors in group negotiations."
    - name: "avg_counter_offer_rate"
      expr: AVG(CAST(counter_offer_rate AS DOUBLE))
      comment: "Average counter-offer rate proposed by revenue management. Tracks negotiation outcomes and rate recovery from initial proposals."
    - name: "avg_transient_adr_displaced"
      expr: AVG(CAST(transient_adr_displaced AS DOUBLE))
      comment: "Average transient ADR that would be displaced by the group. Used to quantify the opportunity cost of group acceptance."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(revpar_impact AS DOUBLE))
      comment: "Average RevPAR impact of the group evaluation decision. Positive values indicate group acceptance improves overall RevPAR."
    - name: "avg_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage for group blocks. High attrition erodes group revenue and signals need for tighter contract terms."
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor applied to group room blocks. Used to calibrate net group pickup expectations and inventory release timing."
    - name: "avg_historical_wash_pct"
      expr: AVG(CAST(historical_wash_pct AS DOUBLE))
      comment: "Average historical wash percentage for similar groups. Used to validate wash factor assumptions and improve group forecasting accuracy."
    - name: "avg_rgi_benchmark"
      expr: AVG(CAST(rgi_benchmark AS DOUBLE))
      comment: "Average RGI benchmark used in the group evaluation. Ensures group decisions are made in the context of competitive market performance."
    - name: "group_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of group evaluations. Used to track group inquiry volume and conversion funnel."
    - name: "definite_booking_count"
      expr: COUNT(CASE WHEN is_definite_booking = TRUE THEN 1 END)
      comment: "Number of group evaluations that converted to definite bookings. Used to compute group conversion rate."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control KPI layer covering overbooking levels, hurdle rates, BAR rates, and sell limits. Used by revenue managers to monitor and optimize room inventory deployment across channels and stay dates."
  source: "`travel_hospitality_ecm`.`revenue`.`inventory_control`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for which inventory controls are set, enabling forward-looking inventory management analysis."
    - name: "primary_inventory_property_id"
      expr: primary_inventory_property_id
      comment: "Property for which inventory controls are applied."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type dimension for room-type-level inventory control analysis."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel for which the inventory control applies, enabling channel-level sell limit analysis."
    - name: "control_type"
      expr: control_type
      comment: "Type of inventory control (e.g. stop sell, CTA, CTD, overbooking), used to categorize control actions."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record (e.g. active, expired), used to filter for operative controls."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "Flag indicating the stay date is closed to arrival, used to monitor CTA restriction deployment."
    - name: "is_closed_to_departure"
      expr: is_closed_to_departure
      comment: "Flag indicating the stay date is closed to departure, used to monitor CTD restriction deployment."
    - name: "is_override"
      expr: is_override
      comment: "Flag indicating a manual override of system-recommended inventory controls, used to track override frequency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate figures in the inventory control record."
  measures:
    - name: "avg_overbooking_pct"
      expr: AVG(CAST(overbooking_pct AS DOUBLE))
      comment: "Average overbooking percentage applied to inventory. Tracks overbooking strategy aggressiveness and walk risk exposure."
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate (minimum acceptable rate) set for inventory. Used to enforce rate floors and prevent below-threshold bookings."
    - name: "avg_current_bar"
      expr: AVG(CAST(current_bar AS DOUBLE))
      comment: "Average Best Available Rate currently set. Tracks rate level deployment across properties and stay dates."
    - name: "avg_occupancy_on_books"
      expr: AVG(CAST(occupancy_on_books AS DOUBLE))
      comment: "Average occupancy currently on books for controlled stay dates. Used to assess pace against inventory control thresholds."
    - name: "avg_control_value"
      expr: AVG(CAST(control_value AS DOUBLE))
      comment: "Average value of the inventory control parameter (e.g. sell limit, overbooking cap). Used to benchmark control aggressiveness."
    - name: "avg_system_recommended_value"
      expr: AVG(CAST(system_recommended_value AS DOUBLE))
      comment: "Average system-recommended inventory control value. Compared against actual control value to measure override magnitude."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling set in inventory controls. Used to monitor rate ceiling deployment and pricing strategy boundaries."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor set in inventory controls. Used to enforce rate floor compliance across channels."
    - name: "override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Number of inventory control records where a manual override was applied. High override rates may indicate model calibration issues."
    - name: "cta_count"
      expr: COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END)
      comment: "Number of stay dates with closed-to-arrival restrictions active. Used to monitor restriction deployment intensity."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate availability and pricing KPI layer covering BAR rates, rate parity, pricing override flags, and availability status across channels and room types. Used by revenue managers to monitor rate distribution health and pricing strategy execution."
  source: "`travel_hospitality_ecm`.`revenue`.`rate_availability`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the rate availability snapshot, used for point-in-time rate analysis and trend tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property for which rate availability is being tracked."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type dimension for room-type-level rate availability analysis."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel for which the rate is available, enabling channel-level rate parity monitoring."
    - name: "revenue_rate_plan_id"
      expr: revenue_rate_plan_id
      comment: "Rate plan associated with the availability record."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status (e.g. open, closed, stop sell), used to monitor rate plan availability deployment."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (e.g. BAR, negotiated, package), used for rate type mix analysis."
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Flag indicating a rate parity violation detected across channels. Used to monitor OTA contract compliance."
    - name: "pricing_override_flag"
      expr: pricing_override_flag
      comment: "Flag indicating a pricing override is in effect, used to track override prevalence across the rate grid."
    - name: "stop_sell"
      expr: stop_sell
      comment: "Stop sell flag indicating the rate plan is closed for new bookings, used to monitor inventory restriction deployment."
    - name: "closed_to_arrival"
      expr: closed_to_arrival
      comment: "Closed-to-arrival flag for the rate plan, used to monitor CTA restriction deployment by rate plan."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Flag indicating a package rate, used to analyze package rate availability and contribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate figures."
    - name: "demand_forecast_level"
      expr: demand_forecast_level
      comment: "Demand level classification driving the rate availability decision, used to validate RMS rate-demand alignment."
  measures:
    - name: "avg_bar_rate"
      expr: AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average Best Available Rate across the rate grid. Primary rate level KPI used to monitor pricing strategy execution."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate. Used to compute discount depth and measure rate optimization versus published rates."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor across rate plans. Used to monitor rate floor compliance and prevent below-threshold distribution."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling across rate plans. Used to monitor rate ceiling deployment and pricing strategy boundaries."
    - name: "avg_occupancy_forecast_pct"
      expr: AVG(CAST(occupancy_forecast_pct AS DOUBLE))
      comment: "Average occupancy forecast percentage embedded in the rate availability record. Used to validate rate-demand alignment."
    - name: "bar_vs_rack_discount"
      expr: AVG(CAST(rack_rate AS DOUBLE)) - AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average discount depth between rack rate and BAR. Large discounts indicate aggressive pricing; used to monitor rate integrity."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN rate_parity_flag = TRUE THEN 1 END)
      comment: "Number of rate availability records with a rate parity violation. Parity violations risk OTA contract penalties and brand damage."
    - name: "stop_sell_count"
      expr: COUNT(CASE WHEN stop_sell = TRUE THEN 1 END)
      comment: "Number of rate plan / stay date combinations with stop sell active. Used to monitor restriction intensity and potential revenue leakage."
    - name: "pricing_override_count"
      expr: COUNT(CASE WHEN pricing_override_flag = TRUE THEN 1 END)
      comment: "Number of rate availability records with a pricing override in effect. Used to track manual intervention frequency in the rate grid."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue strategy KPI layer covering target vs. actual performance gaps, strategy coverage, and strategic objective tracking. Used by revenue management leadership to evaluate strategy effectiveness and alignment with financial targets."
  source: "`travel_hospitality_ecm`.`revenue`.`strategy`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which the strategy is defined, enabling property-level strategy analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment targeted by the strategy, used for segment-level strategy effectiveness analysis."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of revenue strategy (e.g. yield, displacement, channel shift), used to categorize and compare strategy approaches."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Current status of the strategy (e.g. active, draft, superseded), used to filter for operative strategies."
    - name: "horizon_type"
      expr: horizon_type
      comment: "Planning horizon type (e.g. short-term, medium-term, long-term), used to segment strategies by planning window."
    - name: "pricing_approach"
      expr: pricing_approach
      comment: "Pricing approach defined in the strategy (e.g. BAR-based, negotiated, dynamic), used to analyze pricing strategy mix."
    - name: "inventory_control_approach"
      expr: inventory_control_approach
      comment: "Inventory control approach (e.g. open pricing, hurdle rate, sell limits), used to evaluate inventory strategy deployment."
    - name: "channel_focus"
      expr: channel_focus
      comment: "Primary channel focus of the strategy (e.g. direct, OTA, GDS), used to analyze channel strategy mix."
    - name: "planning_horizon_start_date"
      expr: planning_horizon_start_date
      comment: "Start date of the strategy planning horizon, used for time-based strategy coverage analysis."
    - name: "planning_horizon_end_date"
      expr: planning_horizon_end_date
      comment: "End date of the strategy planning horizon."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the strategy target figures."
    - name: "special_event_flag"
      expr: special_event_flag
      comment: "Flag indicating the strategy is designed for a special event period, used to isolate event-driven strategy performance."
  measures:
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average target RevPAR set in revenue strategies. Used to benchmark actual RevPAR performance against strategic objectives."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average target ADR set in revenue strategies. Used to evaluate whether pricing strategies are delivering planned rate levels."
    - name: "avg_target_occupancy_pct"
      expr: AVG(CAST(target_occupancy_pct AS DOUBLE))
      comment: "Average target occupancy percentage set in strategies. Used to assess demand capture objectives."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average target TRevPAR set in strategies. Used to evaluate total revenue yield objectives beyond rooms."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average target GOPPAR set in strategies. Used to align revenue strategy with profitability objectives."
    - name: "avg_target_ari"
      expr: AVG(CAST(target_ari AS DOUBLE))
      comment: "Average target Average Rate Index set in strategies. Used to set competitive rate performance benchmarks."
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average target Market Penetration Index set in strategies. Used to set competitive occupancy share benchmarks."
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average target Revenue Generation Index set in strategies. Primary competitive yield target used in STR benchmarking."
    - name: "active_strategy_count"
      expr: COUNT(CASE WHEN strategy_status = 'active' THEN 1 END)
      comment: "Number of currently active revenue strategies. Used to monitor strategy coverage and ensure all properties have operative strategies."
    - name: "special_event_strategy_count"
      expr: COUNT(CASE WHEN special_event_flag = TRUE THEN 1 END)
      comment: "Number of strategies designed for special events. Used to ensure adequate strategy coverage for high-demand event periods."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiated rate portfolio KPI layer covering contracted rate levels, commission costs, and rate plan compliance. Used by revenue management and sales to evaluate corporate and consortia rate portfolio performance and profitability."
  source: "`travel_hospitality_ecm`.`revenue`.`negotiated_rate`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which the negotiated rate applies."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment associated with the negotiated rate, used for segment-level rate portfolio analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of negotiated rate (e.g. corporate, consortia, government), used to analyze rate portfolio by type."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the negotiated rate (e.g. active, expired, pending), used to filter for operative rates."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the negotiated rate, used to track rates pending approval and ensure governance compliance."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date, used for rate contract lifecycle analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date, used to identify expiring contracts requiring renegotiation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the negotiated rate amount."
    - name: "is_lra"
      expr: is_lra
      comment: "Flag indicating a Last Room Availability rate, which guarantees availability regardless of demand. Used to monitor LRA exposure."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Flag indicating a non-refundable rate, used to analyze non-refundable rate penetration in the negotiated portfolio."
    - name: "breakfast_included"
      expr: breakfast_included
      comment: "Flag indicating breakfast is included in the rate, used to analyze inclusive rate portfolio and F&B revenue implications."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Status of rate loading into distribution systems (e.g. loaded, pending, failed), used to monitor distribution readiness."
  measures:
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount across the portfolio. Used to benchmark contracted rates against BAR and market rates."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage across negotiated rates. Used to monitor distribution cost and net rate yield."
    - name: "avg_rate_bar_variance_pct"
      expr: AVG(CAST(rate_bar_variance_pct AS DOUBLE))
      comment: "Average variance between negotiated rate and BAR as a percentage. Used to assess discount depth in the corporate rate portfolio."
    - name: "negotiated_rate_count"
      expr: COUNT(1)
      comment: "Total number of negotiated rate contracts. Used to monitor portfolio size and rate loading completeness."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Number of currently active negotiated rates. Used to ensure rate portfolio coverage and identify gaps."
    - name: "lra_rate_count"
      expr: COUNT(CASE WHEN is_lra = TRUE THEN 1 END)
      comment: "Number of Last Room Availability rates in the portfolio. LRA rates constrain yield management flexibility and require careful monitoring."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of negotiated rates pending approval. Used to monitor governance pipeline and ensure timely rate activation."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_pricing_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing override KPI layer tracking manual rate interventions, override magnitude, and approval compliance. Used by revenue management leadership to monitor pricing discipline, identify override patterns, and ensure rate strategy adherence."
  source: "`travel_hospitality_ecm`.`revenue`.`pricing_override`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the pricing override was applied."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment affected by the pricing override, used to analyze override patterns by segment."
    - name: "override_reason_code"
      expr: override_reason_code
      comment: "Reason code for the pricing override, used to categorize and analyze override drivers."
    - name: "override_status"
      expr: override_status
      comment: "Current status of the override (e.g. active, expired, reversed), used to filter for operative overrides."
    - name: "override_scope"
      expr: override_scope
      comment: "Scope of the override (e.g. property-wide, room type, channel), used to assess override breadth."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the override became effective, used for time-based override trend analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Date the override expires, used to monitor override duration and ensure timely expiry."
    - name: "is_bar_override"
      expr: is_bar_override
      comment: "Flag indicating the override affects the Best Available Rate, used to monitor BAR integrity."
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating whether approval was required for the override, used to monitor governance compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the override rate figures."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel affected by the override, used for channel-level override analysis."
  measures:
    - name: "avg_override_rate"
      expr: AVG(CAST(override_rate AS DOUBLE))
      comment: "Average override rate applied. Used to assess the rate level of manual interventions versus system recommendations."
    - name: "avg_rms_recommended_rate"
      expr: AVG(CAST(rms_recommended_rate AS DOUBLE))
      comment: "Average RMS-recommended rate at the time of override. Used to quantify the deviation from system recommendations."
    - name: "avg_rate_variance_amount"
      expr: AVG(CAST(rate_variance_amount AS DOUBLE))
      comment: "Average absolute rate variance between override rate and system recommendation. Large variances indicate significant pricing discipline issues."
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average percentage rate variance from system recommendation. Used to benchmark override magnitude and set governance thresholds."
    - name: "avg_competitive_rate_reference"
      expr: AVG(CAST(competitive_rate_reference AS DOUBLE))
      comment: "Average competitive rate used as reference for the override. Used to validate that overrides are grounded in competitive intelligence."
    - name: "avg_approval_threshold_pct"
      expr: AVG(CAST(approval_threshold_pct AS DOUBLE))
      comment: "Average approval threshold percentage for overrides. Used to monitor governance threshold calibration."
    - name: "total_override_count"
      expr: COUNT(1)
      comment: "Total number of pricing overrides. High override volumes indicate potential RMS model drift or market anomalies requiring investigation."
    - name: "bar_override_count"
      expr: COUNT(CASE WHEN is_bar_override = TRUE THEN 1 END)
      comment: "Number of overrides affecting the Best Available Rate. BAR overrides have the broadest revenue impact and require close monitoring."
    - name: "approval_required_count"
      expr: COUNT(CASE WHEN approval_required = TRUE THEN 1 END)
      comment: "Number of overrides that required management approval. Used to monitor governance compliance and approval pipeline."
$$;