-- Metric views for domain: revenue | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core hospitality revenue performance KPIs derived from daily actuals. Covers room revenue, total property revenue, GOP, RevPAR, ADR, occupancy, TRevPAR, GOPPAR, CPOR, and competitive index metrics (ARI, MPI, RGI). Primary steering dashboard for revenue management and ownership reporting."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`performance_actuals`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Calendar date of the performance record; used for daily, weekly, and monthly trend analysis."
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_date)
      comment: "Month bucket of the performance date for period-over-period revenue reporting."
    - name: "performance_year"
      expr: YEAR(performance_date)
      comment: "Fiscal/calendar year of the performance record for annual KPI tracking."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension; enables property-level revenue segmentation."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Originating PMS or RMS system code; useful for data lineage and reconciliation filtering."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Boolean flag indicating whether the actuals record has been reconciled against the general ledger."
    - name: "hierarchy_id"
      expr: hierarchy_id
      comment: "Organisational hierarchy reference enabling roll-up reporting across regions, brands, or ownership groups."
    - name: "seasonal_calendar_id"
      expr: seasonal_calendar_id
      comment: "Seasonal calendar reference for demand-season segmentation of revenue performance."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Loyalty promotion reference enabling measurement of promotion-driven revenue lift."
  measures:
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total revenue across all streams (rooms, F&B, spa, parking, ancillary, misc) for the property. Primary top-line KPI for ownership and executive reporting."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Aggregate room revenue; the largest single revenue stream and primary driver of RevPAR and ADR performance."
    - name: "fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue; key ancillary revenue stream tracked against budget and prior year."
    - name: "spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue; ancillary revenue stream used to evaluate wellness offering performance."
    - name: "parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Total parking revenue; ancillary stream contributing to TRevPAR and total property yield."
    - name: "ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (excluding rooms and F&B); measures upsell and non-room revenue diversification."
    - name: "miscellaneous_income"
      expr: SUM(CAST(miscellaneous_income AS DOUBLE))
      comment: "Miscellaneous income items; tracked to ensure full revenue capture and audit completeness."
    - name: "gross_operating_profit"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Gross Operating Profit (GOP) — total revenue minus departmental and undistributed operating expenses. Core profitability KPI for hotel owners and operators."
    - name: "ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "EBITDA contribution from the property; used by ownership and asset management for investment performance evaluation."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate (ADR) — average achieved room rate per occupied room. Core pricing KPI for revenue management."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average Revenue Per Available Room (RevPAR) — the primary yield metric combining occupancy and rate performance."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average Total Revenue Per Available Room (TRevPAR) — measures total property yield across all revenue streams per available room."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average Gross Operating Profit Per Available Room (GOPPAR) — profitability yield metric used by asset managers and ownership groups."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average Cost Per Occupied Room (CPOR) — operational efficiency metric; rising CPOR erodes GOP margin."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate (percentage of available rooms sold); fundamental demand metric driving RevPAR."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Accommodation Revenue Index (ARI) — competitive benchmarking metric measuring revenue share relative to the competitive set."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index (MPI) — measures occupancy performance relative to the competitive set; index above 100 indicates outperformance."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index (RGI) — composite competitive index (RevPAR vs comp set); primary STR benchmarking KPI."
    - name: "revpar_vs_prior_year_variance"
      expr: AVG(CAST(revpar AS DOUBLE)) - AVG(CAST(prior_year_revpar AS DOUBLE))
      comment: "RevPAR variance versus prior year (absolute); measures year-over-year revenue yield improvement or decline."
    - name: "revpar_growth_pct"
      expr: ROUND(100.0 * (AVG(CAST(revpar AS DOUBLE)) - AVG(CAST(prior_year_revpar AS DOUBLE))) / NULLIF(AVG(CAST(prior_year_revpar AS DOUBLE)), 0), 2)
      comment: "RevPAR year-over-year growth percentage; key executive KPI for evaluating revenue recovery and growth trajectory."
    - name: "reconciled_record_count"
      expr: COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END)
      comment: "Count of reconciled performance records; data quality and close-process completeness indicator."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance records that have been reconciled; financial close quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue budget planning KPIs enabling variance analysis between budgeted targets and strategic goals. Covers room revenue, F&B, total revenue, GOP, and key performance targets (ADR, RevPAR, occupancy, GOPPAR, TRevPAR). Used by finance, revenue management, and ownership for annual planning and quarterly reforecasting."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`budget`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget record; primary time dimension for annual budget cycle management."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) within the budget year for period-level budget tracking."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the budget planning period; used to align budget to operational calendar."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of the budget planning period."
    - name: "property_id"
      expr: property_id
      comment: "Property reference enabling property-level budget comparison and roll-up to portfolio level."
    - name: "property_segment"
      expr: property_segment
      comment: "Property segment classification (e.g. luxury, select-service) for segment-level budget benchmarking."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Type of planning horizon (annual, rolling, strategic) to distinguish budget versions."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Revenue strategy type associated with the budget (e.g. growth, stabilisation, repositioning)."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Current status of the revenue strategy (e.g. approved, in-review, superseded)."
    - name: "is_owner_approved"
      expr: is_owner_approved
      comment: "Boolean flag indicating owner approval of the budget; required for capital and operating plan finalisation."
    - name: "version"
      expr: version
      comment: "Budget version identifier enabling comparison across reforecast iterations."
    - name: "hierarchy_id"
      expr: hierarchy_id
      comment: "Organisational hierarchy reference for portfolio-level budget roll-up."
  measures:
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all streams; primary top-line budget target for ownership and finance reporting."
    - name: "budgeted_room_revenue"
      expr: SUM(CAST(budgeted_room_revenue AS DOUBLE))
      comment: "Budgeted room revenue; largest revenue stream target used to set ADR and occupancy goals."
    - name: "budgeted_fb_revenue"
      expr: SUM(CAST(budgeted_fb_revenue AS DOUBLE))
      comment: "Budgeted food and beverage revenue; used to set F&B outlet targets and staffing plans."
    - name: "budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Budgeted events and meetings revenue; key for conference and banqueting capacity planning."
    - name: "budgeted_other_revenue"
      expr: SUM(CAST(budgeted_other_revenue AS DOUBLE))
      comment: "Budgeted ancillary and other revenue streams; ensures full revenue budget coverage."
    - name: "budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Budgeted Gross Operating Profit; primary profitability target for ownership and management agreements."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average budgeted ADR target; pricing benchmark for revenue management strategy setting."
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average budgeted RevPAR target; primary yield benchmark for revenue management performance evaluation."
    - name: "avg_target_occupancy_rate"
      expr: AVG(CAST(target_occupancy_rate AS DOUBLE))
      comment: "Average budgeted occupancy rate target; demand planning benchmark for staffing and cost management."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average budgeted GOPPAR target; profitability yield benchmark for asset management reporting."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average budgeted TRevPAR target; total revenue yield benchmark across all property revenue streams."
    - name: "avg_target_alos"
      expr: AVG(CAST(target_alos AS DOUBLE))
      comment: "Average budgeted length of stay target; used to optimise rate strategy and channel mix planning."
    - name: "avg_budgeted_cpor"
      expr: AVG(CAST(budgeted_cpor AS DOUBLE))
      comment: "Average budgeted Cost Per Occupied Room; operational efficiency benchmark for housekeeping and rooms division."
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average budgeted Market Penetration Index target; competitive positioning goal for revenue management."
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average budgeted Revenue Generation Index target; composite competitive benchmark goal."
    - name: "avg_target_ari"
      expr: AVG(CAST(target_ari AS DOUBLE))
      comment: "Average budgeted Accommodation Revenue Index target; revenue share competitive goal."
    - name: "owner_approved_budget_count"
      expr: COUNT(CASE WHEN is_owner_approved = TRUE THEN 1 END)
      comment: "Number of owner-approved budget records; governance and approval process completeness metric."
    - name: "owner_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_owner_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of budget records with owner approval; financial governance KPI for ownership reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and projected performance KPIs. Covers projected occupancy, ADR, RevPAR, room revenue, cancellations, no-shows, pickup, and forecast accuracy (MAPE). Used by revenue management to evaluate forecast quality and calibrate pricing and inventory decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date for which the demand forecast applies; primary time dimension for forecast horizon analysis."
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month bucket of the forecast date for monthly demand planning and revenue projection."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. unconstrained, constrained, pickup) enabling comparison of forecast methodologies."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Forecasting model used (e.g. ARIMA, ML ensemble, exponential smoothing); used to evaluate model performance."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of the forecast (daily, weekly, segment-level) for appropriate aggregation and comparison."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g. published, draft, superseded); filter for active forecasts."
    - name: "property_id"
      expr: property_id
      comment: "Property reference for property-level demand forecast analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type reference enabling room-type-level demand and pricing analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment reference for segment-level demand forecasting and mix management."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Boolean flag for holiday periods; enables demand uplift analysis on holidays vs. standard periods."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Boolean flag for special events; critical for identifying event-driven demand spikes in forecasting."
    - name: "is_override"
      expr: is_override
      comment: "Boolean flag indicating a manual revenue manager override of the system forecast."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week (numeric) for day-of-week demand pattern analysis and pricing strategy."
  measures:
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage across forecast records; primary demand forecast KPI for inventory and pricing decisions."
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected ADR from demand forecasts; pricing benchmark for rate strategy and channel optimisation."
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected RevPAR; forward-looking yield KPI used to set revenue targets and evaluate strategy."
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue from demand forecasts; used for cash flow planning and ownership reporting."
    - name: "avg_unconstrained_demand"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE))
      comment: "Average unconstrained demand (demand without inventory limits); measures true market demand and identifies displacement opportunities."
    - name: "avg_constrained_demand"
      expr: AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Average constrained demand (demand within available inventory); operational demand signal for staffing and procurement."
    - name: "demand_displacement_rate_pct"
      expr: ROUND(100.0 * (AVG(CAST(unconstrained_demand AS DOUBLE)) - AVG(CAST(constrained_demand AS DOUBLE))) / NULLIF(AVG(CAST(unconstrained_demand AS DOUBLE)), 0), 2)
      comment: "Percentage of unconstrained demand displaced by inventory constraints; measures revenue opportunity loss from sell-outs."
    - name: "avg_projected_cancellations"
      expr: AVG(CAST(projected_cancellations AS DOUBLE))
      comment: "Average projected cancellation volume; used to calibrate overbooking strategy and net demand estimates."
    - name: "avg_projected_no_shows"
      expr: AVG(CAST(projected_no_shows AS DOUBLE))
      comment: "Average projected no-show volume; informs overbooking policy and walk risk management."
    - name: "avg_projected_pickup"
      expr: AVG(CAST(projected_pickup AS DOUBLE))
      comment: "Average projected booking pickup; measures expected incremental reservations within the forecast horizon."
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error (MAPE) of demand forecasts; primary forecast quality KPI — lower is better."
    - name: "avg_booking_pace_index"
      expr: AVG(CAST(booking_pace_index AS DOUBLE))
      comment: "Average booking pace index; measures how quickly reservations are accumulating relative to historical pace — early warning signal for demand shifts."
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Average forecasted Market Penetration Index; forward-looking competitive positioning metric."
    - name: "avg_ari_forecast"
      expr: AVG(CAST(ari_forecast AS DOUBLE))
      comment: "Average forecasted Accommodation Revenue Index; projected competitive revenue share metric."
    - name: "avg_rgi_forecast"
      expr: AVG(CAST(rgi_forecast AS DOUBLE))
      comment: "Average forecasted Revenue Generation Index; composite competitive yield forecast metric."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of forecast records manually overridden by revenue managers; high override rates may indicate model calibration issues."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of demand forecasts; measures forecast reliability for decision-making."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control and yield management KPIs covering overbooking levels, hurdle rates, BAR pricing, occupancy on books, and sell restrictions. Used by revenue management to optimise room inventory allocation, pricing floors, and channel availability decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`inventory_control`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for which the inventory control record applies; primary time dimension for inventory analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket of the stay date for monthly inventory and yield analysis."
    - name: "primary_inventory_property_id"
      expr: primary_inventory_property_id
      comment: "Property reference for property-level inventory control analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type reference enabling room-type-level inventory and pricing analysis."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel reference for channel-level availability and rate management."
    - name: "control_type"
      expr: control_type
      comment: "Type of inventory control applied (e.g. stop-sell, min-stay, overbooking cap)."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record (active, expired, overridden)."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "Boolean flag indicating closed-to-arrival restriction; critical for understanding booking restriction patterns."
    - name: "is_closed_to_departure"
      expr: is_closed_to_departure
      comment: "Boolean flag indicating closed-to-departure restriction."
    - name: "is_override"
      expr: is_override
      comment: "Boolean flag indicating a manual revenue manager override of system-recommended inventory control."
    - name: "walk_policy"
      expr: walk_policy
      comment: "Walk policy applied when overbooking results in guest displacement; risk management dimension."
  measures:
    - name: "avg_occupancy_on_books"
      expr: AVG(CAST(occupancy_on_books AS DOUBLE))
      comment: "Average occupancy on books at time of inventory control snapshot; forward-looking demand signal for pricing decisions."
    - name: "avg_overbooking_pct"
      expr: AVG(CAST(overbooking_pct AS DOUBLE))
      comment: "Average overbooking percentage applied; measures revenue management aggressiveness in capturing displaced demand."
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate (minimum acceptable rate for accepting a booking); key yield management threshold metric."
    - name: "avg_current_bar"
      expr: AVG(CAST(current_bar AS DOUBLE))
      comment: "Average current Best Available Rate (BAR); real-time pricing benchmark for rate parity and competitive monitoring."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor applied across inventory control records; measures rate floor strategy."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling applied; measures rate ceiling strategy and revenue capture limits."
    - name: "avg_system_recommended_value"
      expr: AVG(CAST(system_recommended_value AS DOUBLE))
      comment: "Average RMS system-recommended control value; baseline for measuring override impact on revenue outcomes."
    - name: "avg_control_value"
      expr: AVG(CAST(control_value AS DOUBLE))
      comment: "Average applied inventory control value (actual vs. system recommendation); measures revenue manager intervention level."
    - name: "bar_vs_system_recommendation_variance"
      expr: AVG(CAST(current_bar AS DOUBLE)) - AVG(CAST(system_recommended_value AS DOUBLE))
      comment: "Variance between applied BAR and RMS system recommendation; measures revenue manager override impact on pricing."
    - name: "closed_to_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory control records with closed-to-arrival restriction; measures restriction intensity by date/room type."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory control records manually overridden; high rates may indicate RMS calibration issues or exceptional demand events."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate availability and pricing distribution KPIs covering BAR, rack rate, min/max rates, occupancy forecast, and rate parity. Used by revenue management and distribution teams to monitor pricing consistency, channel availability, and rate strategy execution across distribution channels."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_availability`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the rate availability snapshot; primary time dimension for rate monitoring and parity analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month bucket of the snapshot date for monthly rate strategy analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property reference for property-level rate availability analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type reference enabling room-type-level rate and availability analysis."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel reference for channel-level rate parity and availability monitoring."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status (open, closed, stop-sell) for the rate/room type/channel combination."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Rate plan type (BAR, negotiated, package, group) for rate mix and strategy analysis."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan code for granular rate performance tracking."
    - name: "meal_plan_code"
      expr: meal_plan_code
      comment: "Meal plan inclusion code (e.g. BB, HB, FB) for package rate analysis."
    - name: "stop_sell"
      expr: stop_sell
      comment: "Boolean flag indicating stop-sell restriction; measures inventory closure frequency by channel and room type."
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Boolean flag indicating rate parity compliance; critical for OTA contract compliance and brand integrity."
    - name: "pricing_override_flag"
      expr: pricing_override_flag
      comment: "Boolean flag indicating a manual pricing override; used to track revenue manager intervention frequency."
  measures:
    - name: "avg_bar_rate"
      expr: AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average Best Available Rate (BAR) across rate availability records; primary pricing benchmark for channel management."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate; baseline published rate used to measure discount depth and rate strategy positioning."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor across availability records; measures rate floor strategy execution."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling; measures rate ceiling strategy and revenue capture limits."
    - name: "avg_occupancy_forecast_pct"
      expr: AVG(CAST(occupancy_forecast_pct AS DOUBLE))
      comment: "Average occupancy forecast percentage at time of rate availability snapshot; demand signal for pricing decisions."
    - name: "bar_to_rack_discount_pct"
      expr: ROUND(100.0 * (AVG(CAST(rack_rate AS DOUBLE)) - AVG(CAST(bar_rate AS DOUBLE))) / NULLIF(AVG(CAST(rack_rate AS DOUBLE)), 0), 2)
      comment: "Average BAR discount percentage relative to rack rate; measures pricing aggressiveness and discount depth."
    - name: "rate_range_spread"
      expr: AVG(CAST(max_rate AS DOUBLE)) - AVG(CAST(min_rate AS DOUBLE))
      comment: "Average spread between max and min rates; measures dynamic pricing range and revenue management flexibility."
    - name: "rate_parity_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_parity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate availability records in rate parity compliance; OTA contract compliance and brand integrity KPI."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_sell = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate availability records with stop-sell active; measures inventory restriction intensity by channel."
    - name: "pricing_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pricing_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate availability records with manual pricing overrides; measures revenue manager intervention frequency."
    - name: "distinct_active_rate_plans"
      expr: COUNT(DISTINCT rate_plan_code)
      comment: "Count of distinct active rate plan codes in the availability snapshot; measures rate plan complexity and distribution breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiated rate contract KPIs covering contracted rate levels, commission structures, LRA compliance, and contract portfolio health. Used by sales, revenue management, and finance to evaluate corporate account rate performance, commission costs, and contract compliance."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract effective start date; used to track contract portfolio vintage and renewal cycles."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract expiry date; used for contract renewal pipeline management."
    - name: "property_id"
      expr: property_id
      comment: "Property reference for property-level negotiated rate portfolio analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment reference for segment-level negotiated rate analysis (corporate, consortia, government)."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel reference for channel-level negotiated rate performance."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of negotiated rate (corporate, consortia, government, wholesale) for portfolio segmentation."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the negotiated rate (active, expired, pending-load) for contract health monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the negotiated rate contract; governance and compliance dimension."
    - name: "is_lra"
      expr: is_lra
      comment: "Boolean flag indicating Last Room Availability (LRA) obligation; LRA contracts constrain inventory control flexibility."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Boolean flag for non-refundable rate contracts; impacts cancellation revenue and risk profile."
    - name: "breakfast_included"
      expr: breakfast_included
      comment: "Boolean flag indicating breakfast inclusion; impacts F&B revenue attribution and rate value perception."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "GDS/CRS rate loading status; operational metric for distribution readiness of negotiated rates."
  measures:
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount across active contracts; pricing benchmark for corporate account management."
    - name: "total_negotiated_rate_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of all negotiated rate amounts; portfolio-level contracted rate value indicator."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage across negotiated rate contracts; measures distribution cost burden on negotiated business."
    - name: "avg_bar_variance_pct"
      expr: AVG(CAST(rate_bar_variance_pct AS DOUBLE))
      comment: "Average variance between negotiated rate and BAR; measures discount depth of corporate contracts relative to best available rate."
    - name: "lra_contract_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lra = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of negotiated rate contracts with LRA obligation; measures inventory flexibility constraints from corporate commitments."
    - name: "non_refundable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_non_refundable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of negotiated rate contracts that are non-refundable; measures revenue certainty from contracted business."
    - name: "breakfast_included_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breakfast_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of negotiated rate contracts including breakfast; measures F&B bundling prevalence in corporate contracts."
    - name: "distinct_active_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of distinct corporate accounts with active negotiated rates; measures corporate account portfolio breadth."
    - name: "avg_rate_includes_tax"
      expr: AVG(CAST(rate_includes_tax AS DOUBLE))
      comment: "Average tax-inclusive rate value; used for net rate analysis and revenue recognition accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_dynamic_rate_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic rate rule (DRR) KPIs covering pricing adjustment strategies, rate floor/ceiling compliance, rule activation frequency, and approval governance. Used by revenue management to evaluate the effectiveness and coverage of automated pricing rules."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`"
  filter: rule_status = 'ACTIVE'
  dimensions:
    - name: "effective_from"
      expr: effective_from
      comment: "Date from which the dynamic rate rule is effective; used for rule lifecycle and seasonality analysis."
    - name: "effective_until"
      expr: effective_until
      comment: "Date until which the dynamic rate rule is effective; used for rule expiry and renewal management."
    - name: "property_id"
      expr: property_id
      comment: "Property reference for property-level dynamic pricing rule analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type reference for room-type-level pricing rule coverage analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment reference for segment-targeted pricing rule analysis."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of dynamic rate rule (e.g. demand-based, pickup-based, competitive) for strategy classification."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of rate adjustment (percentage, absolute, BAR-relative) for pricing strategy analysis."
    - name: "adjustment_direction"
      expr: adjustment_direction
      comment: "Direction of rate adjustment (increase, decrease) for pricing strategy directional analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the dynamic rate rule; governance and compliance dimension."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Boolean flag indicating whether the rule can be stacked with other rules; impacts combined pricing adjustment analysis."
    - name: "rule_priority"
      expr: rule_priority
      comment: "Priority ranking of the rule when multiple rules apply; used to analyse rule conflict resolution."
  measures:
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied by dynamic rate rules; measures pricing aggressiveness of automated rules."
    - name: "avg_min_rate_floor"
      expr: AVG(CAST(min_rate_floor AS DOUBLE))
      comment: "Average minimum rate floor set by dynamic rate rules; measures rate protection strategy across the portfolio."
    - name: "avg_max_rate_ceiling"
      expr: AVG(CAST(max_rate_ceiling AS DOUBLE))
      comment: "Average maximum rate ceiling set by dynamic rate rules; measures rate cap strategy and revenue capture limits."
    - name: "avg_trigger_threshold_value"
      expr: AVG(CAST(trigger_threshold_value AS DOUBLE))
      comment: "Average trigger threshold value (e.g. occupancy %, pickup count) that activates dynamic rate rules; calibration benchmark."
    - name: "rate_floor_to_ceiling_spread"
      expr: AVG(CAST(max_rate_ceiling AS DOUBLE)) - AVG(CAST(min_rate_floor AS DOUBLE))
      comment: "Average spread between rate ceiling and floor across dynamic rate rules; measures dynamic pricing range flexibility."
    - name: "stackable_rule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stackable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dynamic rate rules that are stackable; measures combined pricing adjustment risk and complexity."
    - name: "approved_rule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dynamic rate rules with approved status; governance compliance metric for pricing rule management."
    - name: "distinct_active_rules"
      expr: COUNT(DISTINCT dynamic_rate_rule_id)
      comment: "Count of distinct active dynamic rate rules; measures breadth of automated pricing coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue rate plan portfolio KPIs covering base rates, discount structures, commission costs, and rate plan eligibility attributes. Used by revenue management and distribution teams to evaluate rate plan mix, pricing strategy, and channel distribution effectiveness."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`"
  filter: rate_status = 'ACTIVE'
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the rate plan is effective; used for rate plan lifecycle and seasonal pricing analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Date on which the rate plan expires; used for rate plan renewal pipeline management."
    - name: "property_id"
      expr: property_id
      comment: "Property reference for property-level rate plan portfolio analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment reference for segment-level rate plan analysis."
    - name: "distribution_channel_id"
      expr: distribution_channel_id
      comment: "Distribution channel reference for channel-level rate plan availability analysis."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Rate plan type (BAR, corporate, package, group, promotional) for rate mix analysis."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category classification for portfolio segmentation and pricing strategy analysis."
    - name: "meal_plan_type"
      expr: meal_plan_type
      comment: "Meal plan inclusion type (room-only, B&B, half-board, full-board) for package revenue analysis."
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Boolean flag indicating whether the rate plan pays commission; impacts net revenue and distribution cost analysis."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Boolean flag for refundable rate plans; impacts cancellation revenue risk profile."
    - name: "is_lra_eligible"
      expr: is_lra_eligible
      comment: "Boolean flag for Last Room Availability eligibility; measures inventory flexibility constraints."
    - name: "gds_eligible"
      expr: gds_eligible
      comment: "Boolean flag for GDS distribution eligibility; measures global distribution reach of rate plans."
    - name: "ota_eligible"
      expr: ota_eligible
      comment: "Boolean flag for OTA distribution eligibility; measures online channel distribution breadth."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Boolean flag for loyalty points accrual eligibility; measures loyalty programme integration in rate strategy."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Boolean flag indicating tax-inclusive pricing; impacts net revenue calculation and market positioning."
  measures:
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across active rate plans; pricing benchmark for rate plan portfolio management."
    - name: "avg_rate_floor_amount"
      expr: AVG(CAST(rate_floor_amount AS DOUBLE))
      comment: "Average rate floor amount; measures minimum rate protection strategy across the rate plan portfolio."
    - name: "avg_rate_ceiling_amount"
      expr: AVG(CAST(rate_ceiling_amount AS DOUBLE))
      comment: "Average rate ceiling amount; measures maximum rate capture strategy across the rate plan portfolio."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage across rate plans; measures overall discount depth and pricing strategy aggressiveness."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage across commissionable rate plans; measures distribution cost burden on the rate portfolio."
    - name: "rate_floor_to_ceiling_spread"
      expr: AVG(CAST(rate_ceiling_amount AS DOUBLE)) - AVG(CAST(rate_floor_amount AS DOUBLE))
      comment: "Average spread between rate ceiling and floor; measures dynamic pricing flexibility range in the rate plan portfolio."
    - name: "commissionable_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_commissionable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active rate plans that are commissionable; measures distribution cost exposure across the portfolio."
    - name: "non_refundable_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refundable = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active rate plans that are non-refundable; measures revenue certainty and cancellation risk profile."
    - name: "gds_eligible_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gds_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans distributed via GDS; measures global distribution reach and travel agent channel coverage."
    - name: "ota_eligible_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans distributed via OTA channels; measures online channel dependency and distribution mix."
    - name: "loyalty_eligible_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_points_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans eligible for loyalty points accrual; measures loyalty programme integration in pricing strategy."
    - name: "distinct_active_rate_plans"
      expr: COUNT(DISTINCT revenue_rate_plan_id)
      comment: "Count of distinct active rate plans; measures rate plan portfolio breadth and complexity."
$$;