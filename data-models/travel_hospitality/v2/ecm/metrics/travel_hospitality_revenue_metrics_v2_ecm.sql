-- Metric views for domain: revenue | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core hotel performance KPIs derived from daily actuals: occupancy, ADR, RevPAR, TRevPAR, GOP, and index metrics (MPI, ARI, RGI). Primary steering dashboard for revenue managers and ownership reviews."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`performance_actuals`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Business date of the performance record — primary time axis for trend analysis."
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_date)
      comment: "Month bucket for period-over-period revenue reporting."
    - name: "performance_year"
      expr: DATE_TRUNC('YEAR', performance_date)
      comment: "Year bucket for annual budget vs actuals comparison."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables cross-property portfolio benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for multi-currency portfolio normalization."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source PMS/RMS system for data lineage and reconciliation."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating whether the actuals record has been reconciled against the GL."
  measures:
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate — average room revenue per occupied room night. Core pricing KPI for revenue strategy."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Revenue Per Available Room — primary hotel performance metric combining occupancy and rate. Used in owner reports and STR benchmarking."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Total Revenue Per Available Room — includes all revenue streams (rooms, F&B, spa, parking). Drives total-revenue strategy decisions."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Gross Operating Profit Per Available Room — profitability efficiency metric used in ownership and management fee discussions."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate across reporting period. Paired with ADR to diagnose rate-vs-occupancy trade-offs."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total rooms revenue for the period. Primary top-line revenue KPI for budget vs actuals tracking."
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total property revenue across all departments. Used in TRevPAR computation and owner distribution calculations."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total Food & Beverage revenue. Tracks F&B contribution to total revenue mix."
    - name: "total_spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue. Monitors ancillary revenue diversification beyond rooms."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (non-rooms, non-F&B). Measures revenue diversification strategy effectiveness."
    - name: "total_gop"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Gross Operating Profit — key profitability measure for management fee calculations and owner distributions."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Cost Per Occupied Room — operational efficiency metric. Rising CPOR erodes GOP margin."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Market Penetration Index — occupancy share vs competitive set. Values below 100 indicate underperformance vs comp set."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Rate Index — ADR share vs competitive set. Drives rate positioning strategy."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Revenue Generation Index — RevPAR share vs competitive set. Composite performance indicator for STR reporting."
    - name: "revpar_vs_prior_year_delta"
      expr: AVG(CAST(revpar AS DOUBLE) - CAST(prior_year_revpar AS DOUBLE))
      comment: "Average RevPAR change vs prior year. Year-over-year growth signal used in board and ownership reviews."
    - name: "avg_budget_adr_variance"
      expr: AVG(CAST(adr AS DOUBLE) - CAST(budget_adr AS DOUBLE))
      comment: "Average ADR variance vs budget. Negative values trigger revenue strategy review."
    - name: "avg_budget_occupancy_variance"
      expr: AVG(CAST(occupancy_rate AS DOUBLE) - CAST(budget_occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate variance vs budget. Drives tactical pricing and channel mix decisions."
    - name: "total_parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Total parking revenue. Ancillary revenue stream tracked for total revenue optimization."
    - name: "total_miscellaneous_income"
      expr: SUM(CAST(miscellaneous_income AS DOUBLE))
      comment: "Total miscellaneous income. Monitors non-core revenue streams for budget accuracy."
    - name: "ebitda_contribution_total"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution. Used in investor reporting and asset valuation discussions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_total_revenue_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily total revenue actuals across all departments with budget variance, profitability, and index metrics. Used for owner reporting, management fee calculations, and strategic performance reviews."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date — primary business date for revenue attribution."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket for monthly revenue trend analysis."
    - name: "stay_year"
      expr: DATE_TRUNC('YEAR', stay_date)
      comment: "Year bucket for annual performance comparison."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for portfolio-level revenue aggregation."
    - name: "reporting_segment"
      expr: reporting_segment
      comment: "Reporting segment (transient, group, contract) for segment-level revenue analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekday vs weekend revenue pattern analysis."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for rate strategy segmentation."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for demand-driven pricing analysis."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-driven revenue impact analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for multi-property normalization."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total revenue across all departments. Primary top-line KPI for ownership and management reporting."
    - name: "total_rooms_revenue"
      expr: SUM(CAST(rooms_revenue AS DOUBLE))
      comment: "Total rooms revenue. Core revenue stream driving RevPAR and budget performance."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue. Tracks food and beverage contribution to total revenue mix."
    - name: "total_spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue. Monitors wellness revenue as a diversification strategy."
    - name: "total_parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Total parking revenue. Ancillary revenue stream for total revenue optimization."
    - name: "total_other_operated_dept_revenue"
      expr: SUM(CAST(other_operated_dept_revenue AS DOUBLE))
      comment: "Total other operated department revenue. Captures revenue beyond rooms, F&B, and spa."
    - name: "total_miscellaneous_income"
      expr: SUM(CAST(miscellaneous_income AS DOUBLE))
      comment: "Total miscellaneous income. Non-core revenue stream for budget accuracy monitoring."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average RevPAR — primary hotel performance metric for ownership and STR benchmarking."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average TRevPAR — total revenue efficiency metric across all available rooms."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate — pricing effectiveness metric for revenue strategy."
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_pct AS DOUBLE))
      comment: "Average occupancy percentage. Paired with ADR to evaluate rate-occupancy trade-off."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average GOPPAR — profitability per available room for management fee and owner distribution calculations."
    - name: "total_gop_amount"
      expr: SUM(CAST(gop_amount AS DOUBLE))
      comment: "Total Gross Operating Profit. Key profitability measure for management agreements and investor reporting."
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution. Used in asset valuation and investor return analysis."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses AS DOUBLE))
      comment: "Total operating expenses. Monitors cost efficiency and GOP margin compression."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average Cost Per Occupied Room. Operational efficiency KPI — rising CPOR signals margin risk."
    - name: "rooms_revenue_vs_budget_delta"
      expr: SUM(CAST(rooms_revenue AS DOUBLE) - CAST(rooms_revenue_budget AS DOUBLE))
      comment: "Total rooms revenue variance vs budget. Negative values trigger revenue strategy intervention."
    - name: "total_revenue_vs_budget_delta"
      expr: SUM(CAST(total_revenue AS DOUBLE) - CAST(total_revenue_budget AS DOUBLE))
      comment: "Total revenue variance vs budget. Primary budget accountability metric for GMs and ownership."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index. Occupancy share vs competitive set — below 100 triggers demand strategy review."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index. Composite RevPAR share vs competitive set for STR reporting."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Average Rate Index. ADR share vs competitive set — drives rate positioning decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecast accuracy and projected performance metrics. Used by revenue managers to evaluate forecast model quality, adjust pricing strategies, and plan inventory controls."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date the forecast was generated — tracks forecast vintage for accuracy analysis."
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month bucket for forecast trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level forecast management."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Forecast type (unconstrained, constrained, group-adjusted) for model comparison."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Forecast model algorithm type for model performance benchmarking."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of forecast (daily, weekly, monthly) for aggregation context."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for demand pattern analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for special-period demand forecasting."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-driven demand analysis."
    - name: "is_override"
      expr: is_override
      comment: "Override flag — identifies manual forecast adjustments vs model-generated forecasts."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Forecast status (draft, approved, published) for workflow management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property revenue forecast normalization."
  measures:
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error of forecast model. Lower values indicate better forecast quality — drives model selection decisions."
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage. Primary demand signal for inventory control and pricing decisions."
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected ADR. Pricing forecast used to set rate floors and ceilings."
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected RevPAR. Forward-looking performance KPI for strategy planning."
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue. Used in budget vs forecast variance tracking."
    - name: "avg_unconstrained_demand"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE))
      comment: "Average unconstrained demand (demand before inventory limits). Measures true market demand for overbooking and pricing decisions."
    - name: "avg_constrained_demand"
      expr: AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Average constrained demand (demand after inventory limits). Actual sellable demand for revenue optimization."
    - name: "avg_demand_gap"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE) - CAST(constrained_demand AS DOUBLE))
      comment: "Average gap between unconstrained and constrained demand. Quantifies revenue opportunity lost to inventory constraints."
    - name: "avg_projected_pickup"
      expr: AVG(CAST(projected_pickup AS DOUBLE))
      comment: "Average projected pickup (incremental bookings expected). Drives daily inventory release and pricing decisions."
    - name: "avg_projected_cancellations"
      expr: AVG(CAST(projected_cancellations AS DOUBLE))
      comment: "Average projected cancellations. Used in overbooking policy calibration."
    - name: "avg_projected_no_shows"
      expr: AVG(CAST(projected_no_shows AS DOUBLE))
      comment: "Average projected no-shows. Informs walk policy and overbooking level decisions."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average forecast confidence level. Low confidence triggers manual review and override."
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Average forecasted Market Penetration Index. Forward-looking competitive positioning metric."
    - name: "avg_rgi_forecast"
      expr: AVG(CAST(rgi_forecast AS DOUBLE))
      comment: "Average forecasted Revenue Generation Index. Projected competitive RevPAR share for strategy alignment."
    - name: "override_forecast_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Count of manually overridden forecasts. High override rates signal model quality issues requiring retraining."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_channel_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel-level revenue contribution, distribution cost, and profitability metrics. Used by revenue and distribution teams to optimize channel mix, reduce cost of acquisition, and maximize net revenue."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`channel_contribution`"
  filter: contribution_status = 'ACTIVE'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date for channel contribution — primary time axis for distribution analysis."
    - name: "business_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Month bucket for channel mix trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level channel strategy."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type (OTA, GDS, direct, voice) for channel mix analysis."
    - name: "is_direct_channel"
      expr: is_direct_channel
      comment: "Direct channel flag — direct vs indirect channel profitability comparison."
    - name: "is_ota_channel"
      expr: is_ota_channel
      comment: "OTA channel flag — OTA dependency and cost analysis."
    - name: "reporting_granularity"
      expr: reporting_granularity
      comment: "Reporting granularity for aggregation context."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property channel cost normalization."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Total gross revenue by channel. Primary channel revenue contribution metric."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after commissions and distribution costs. True channel profitability measure."
    - name: "total_revenue_net_of_distribution"
      expr: SUM(CAST(revenue_net_of_distribution AS DOUBLE))
      comment: "Total revenue net of all distribution costs. Used to compare true channel yield."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to channel partners. Monitors distribution cost exposure."
    - name: "total_distribution_cost"
      expr: SUM(CAST(total_distribution_cost AS DOUBLE))
      comment: "Total distribution cost including commissions, GDS fees, and OTA costs. Key cost-of-acquisition metric."
    - name: "total_gds_transaction_fees"
      expr: SUM(CAST(gds_transaction_fees AS DOUBLE))
      comment: "Total GDS transaction fees. Monitors GDS cost efficiency vs direct booking investment."
    - name: "avg_cost_per_booking"
      expr: AVG(CAST(cost_per_booking AS DOUBLE))
      comment: "Average cost per booking by channel. Drives channel investment and direct booking strategy decisions."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage. Monitors commission creep and contract renegotiation triggers."
    - name: "avg_channel_mix_pct"
      expr: AVG(CAST(channel_mix_pct AS DOUBLE))
      comment: "Average channel mix percentage. Tracks channel diversification and OTA dependency."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average ADR by channel. Identifies high-rate vs low-rate channel performance."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average RevPAR by channel. Channel-level revenue efficiency metric."
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_pct AS DOUBLE))
      comment: "Average occupancy percentage by channel. Measures channel volume contribution."
    - name: "avg_alos"
      expr: AVG(CAST(alos AS DOUBLE))
      comment: "Average Length of Stay by channel. Longer ALOS channels typically yield higher net revenue."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average cancellation rate by channel. High cancellation channels erode net revenue and increase re-booking costs."
    - name: "avg_advance_booking_days"
      expr: AVG(CAST(advance_booking_days AS DOUBLE))
      comment: "Average advance booking window by channel. Longer lead times improve revenue certainty and pricing power."
    - name: "net_revenue_margin_pct"
      expr: ROUND(100.0 * AVG(CAST(net_revenue AS DOUBLE)) / NULLIF(AVG(CAST(gross_revenue AS DOUBLE)), 0), 2)
      comment: "Net revenue as a percentage of gross revenue. Measures channel profitability after distribution costs — key channel optimization metric."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue budget planning metrics including target KPIs, budget approval status, and planning horizon coverage. Used by revenue managers, GMs, and ownership for annual planning and budget accountability."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_budget`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Budget planning period start date — primary time axis for budget cycle analysis."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "Budget planning period end date — defines budget horizon."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level budget management."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (Q1, Q2, etc.) for quarterly budget tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget comparison."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Planning horizon type (annual, rolling 12-month, 3-year) for budget scope context."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Revenue strategy type associated with this budget for strategy-budget alignment analysis."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Strategy status for budget approval workflow tracking."
    - name: "is_owner_approved"
      expr: is_owner_approved
      comment: "Owner approval flag — distinguishes approved vs pending budgets for reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property budget normalization."
  measures:
    - name: "total_budgeted_room_revenue"
      expr: SUM(CAST(budgeted_room_revenue AS DOUBLE))
      comment: "Total budgeted room revenue. Primary budget target for revenue accountability."
    - name: "total_budgeted_total_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all departments. Top-line budget target for ownership reporting."
    - name: "total_budgeted_fb_revenue"
      expr: SUM(CAST(budgeted_fb_revenue AS DOUBLE))
      comment: "Total budgeted F&B revenue. Tracks F&B budget planning and outlet performance targets."
    - name: "total_budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Total budgeted events revenue. Monitors group and event revenue planning."
    - name: "total_budgeted_other_revenue"
      expr: SUM(CAST(budgeted_other_revenue AS DOUBLE))
      comment: "Total budgeted other revenue. Tracks ancillary revenue planning."
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted Gross Operating Profit. Key profitability target for management agreements."
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average target RevPAR. Primary performance target for revenue strategy alignment."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average target ADR. Pricing target for rate strategy planning."
    - name: "avg_target_occupancy_rate"
      expr: AVG(CAST(target_occupancy_rate AS DOUBLE))
      comment: "Average target occupancy rate. Volume target for demand and channel strategy."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average target TRevPAR. Total revenue efficiency target for ancillary revenue strategy."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average target GOPPAR. Profitability efficiency target for management fee calculations."
    - name: "avg_target_alos"
      expr: AVG(CAST(target_alos AS DOUBLE))
      comment: "Average target length of stay. Drives minimum stay restrictions and package strategy."
    - name: "avg_budgeted_cpor"
      expr: AVG(CAST(budgeted_cpor AS DOUBLE))
      comment: "Average budgeted Cost Per Occupied Room. Operational cost target for expense management."
    - name: "owner_approved_budget_count"
      expr: COUNT(CASE WHEN is_owner_approved = TRUE THEN 1 END)
      comment: "Count of owner-approved budgets. Tracks budget approval progress for governance reporting."
    - name: "total_budget_records"
      expr: COUNT(1)
      comment: "Total budget records. Used to track budget planning coverage across properties and periods."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_str_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "STR (Smith Travel Research) competitive benchmarking metrics: property vs comp set ADR, occupancy, RevPAR, and index performance. Used in ownership reviews, board decks, and revenue strategy sessions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`str_benchmark`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for STR benchmark — primary time axis for competitive performance tracking."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_period_start_date)
      comment: "Report month for period-over-period STR benchmark comparison."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level competitive benchmarking."
    - name: "report_period_type"
      expr: report_period_type
      comment: "Report period type (daily, weekly, monthly, YTD) for benchmark aggregation context."
    - name: "record_type"
      expr: record_type
      comment: "Record type (actuals, forecast) for benchmark data classification."
    - name: "benchmark_currency_code"
      expr: benchmark_currency_code
      comment: "Benchmark currency for multi-market STR comparison normalization."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Rate parity compliance flag — non-compliant records trigger channel management action."
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Benchmark record status for data quality filtering."
  measures:
    - name: "avg_property_revpar"
      expr: AVG(CAST(property_revpar AS DOUBLE))
      comment: "Average property RevPAR from STR data. Primary competitive performance metric."
    - name: "avg_comp_set_revpar"
      expr: AVG(CAST(comp_set_revpar AS DOUBLE))
      comment: "Average competitive set RevPAR. Benchmark against which property RevPAR is measured."
    - name: "avg_property_adr"
      expr: AVG(CAST(property_adr AS DOUBLE))
      comment: "Average property ADR from STR data. Rate positioning vs competitive set."
    - name: "avg_comp_set_adr"
      expr: AVG(CAST(comp_set_adr AS DOUBLE))
      comment: "Average competitive set ADR. Rate benchmark for pricing strategy."
    - name: "avg_property_occupancy_rate"
      expr: AVG(CAST(property_occupancy_rate AS DOUBLE))
      comment: "Average property occupancy rate from STR. Volume performance vs competitive set."
    - name: "avg_comp_set_occupancy_rate"
      expr: AVG(CAST(comp_set_occupancy_rate AS DOUBLE))
      comment: "Average competitive set occupancy rate. Demand benchmark for market share analysis."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index. Composite RevPAR share vs comp set — primary STR performance indicator."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index. Occupancy share vs comp set — below 100 triggers demand strategy review."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Average Rate Index. ADR share vs comp set — drives rate positioning decisions."
    - name: "avg_revpar_gap"
      expr: AVG(CAST(property_revpar AS DOUBLE) - CAST(comp_set_revpar AS DOUBLE))
      comment: "Average RevPAR gap vs competitive set. Positive = outperformance; negative = underperformance requiring strategy action."
    - name: "avg_adr_gap"
      expr: AVG(CAST(property_adr AS DOUBLE) - CAST(comp_set_adr AS DOUBLE))
      comment: "Average ADR gap vs competitive set. Measures rate premium or discount vs market."
    - name: "avg_occupancy_gap"
      expr: AVG(CAST(property_occupancy_rate AS DOUBLE) - CAST(comp_set_occupancy_rate AS DOUBLE))
      comment: "Average occupancy gap vs competitive set. Measures market share capture vs comp set."
    - name: "avg_shopped_rate_amount"
      expr: AVG(CAST(shopped_rate_amount AS DOUBLE))
      comment: "Average shopped competitor rate. Used in rate parity monitoring and competitive pricing decisions."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = FALSE THEN 1 END)
      comment: "Count of rate parity violations. Triggers channel management and OTA contract review."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_competitor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitor rate shopping metrics: rate gaps, parity analysis, and market positioning. Used by revenue managers to calibrate pricing strategy and respond to competitive rate movements."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`competitor_rate`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "shop_date"
      expr: shop_date
      comment: "Date the competitor rate was shopped — primary time axis for rate trend analysis."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for the shopped rate — links competitive rate to demand period."
    - name: "competitive_set_id"
      expr: competitive_set_id
      comment: "Competitive set identifier for comp set-level rate analysis."
    - name: "channel_shopped"
      expr: channel_shopped
      comment: "Channel where rate was shopped (OTA, GDS, brand.com) for channel-level parity analysis."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Rate plan type (BAR, advance purchase, package) for rate type comparison."
    - name: "room_type_category"
      expr: room_type_category
      comment: "Room type category for like-for-like rate comparison."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekday vs weekend competitive rate pattern analysis."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for rate strategy segmentation."
    - name: "special_event_flag"
      expr: special_event_flag
      comment: "Special event flag for event-driven competitive rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-market rate comparison normalization."
  measures:
    - name: "avg_shopped_rate"
      expr: AVG(CAST(shopped_rate AS DOUBLE))
      comment: "Average competitor shopped rate. Primary competitive pricing reference for rate strategy."
    - name: "avg_our_rate"
      expr: AVG(CAST(our_rate AS DOUBLE))
      comment: "Average our property rate at time of shop. Baseline for rate gap calculation."
    - name: "avg_rate_gap"
      expr: AVG(CAST(rate_gap AS DOUBLE))
      comment: "Average rate gap vs competitor. Positive = we are priced above market; negative = below market. Drives pricing decisions."
    - name: "avg_rate_delta"
      expr: AVG(CAST(rate_delta AS DOUBLE))
      comment: "Average rate change vs previous shop. Monitors competitor rate movement velocity."
    - name: "avg_rate_in_usd"
      expr: AVG(CAST(rate_in_usd AS DOUBLE))
      comment: "Average competitor rate in USD for cross-market normalized comparison."
    - name: "avg_previous_shopped_rate"
      expr: AVG(CAST(previous_shopped_rate AS DOUBLE))
      comment: "Average previous shopped rate. Used to calculate rate movement trend."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Average Rate Index from rate shopping data. Competitive rate positioning metric."
    - name: "total_shop_runs"
      expr: COUNT(1)
      comment: "Total rate shop records. Measures rate shopping coverage and frequency."
    - name: "rate_increase_count"
      expr: COUNT(CASE WHEN rate_change_indicator = 'INCREASE' THEN 1 END)
      comment: "Count of competitor rate increases. Signals market rate momentum — triggers upward pricing review."
    - name: "rate_decrease_count"
      expr: COUNT(CASE WHEN rate_change_indicator = 'DECREASE' THEN 1 END)
      comment: "Count of competitor rate decreases. Signals market softening — triggers defensive pricing review."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating of shopped competitors. Ensures like-for-like competitive set quality."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_pickup_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking pace and pickup velocity metrics. Used by revenue managers to monitor booking momentum, identify demand acceleration or deceleration, and trigger pricing and inventory control actions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`pickup_report`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date being tracked — primary time axis for pickup analysis."
    - name: "report_date"
      expr: report_date
      comment: "Date the pickup report was generated — tracks booking pace vintage."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level pickup monitoring."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code for channel-level pickup analysis."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan code for rate-level pickup tracking."
    - name: "report_type"
      expr: report_type
      comment: "Report type (daily, weekly, event) for pickup report classification."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekday vs weekend pickup pattern analysis."
    - name: "is_weekend"
      expr: is_weekend
      comment: "Weekend flag for rate strategy segmentation."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-driven pickup analysis."
    - name: "los_restriction_active"
      expr: los_restriction_active
      comment: "LOS restriction active flag — identifies dates with minimum stay controls."
    - name: "demand_level"
      expr: demand_level
      comment: "Demand level classification (low, medium, high) for inventory control context."
  measures:
    - name: "avg_pickup_velocity"
      expr: AVG(CAST(pickup_velocity AS DOUBLE))
      comment: "Average pickup velocity (bookings per day). Primary booking pace KPI — declining velocity triggers pricing or promotion action."
    - name: "avg_adr_on_books"
      expr: AVG(CAST(adr_on_books AS DOUBLE))
      comment: "Average ADR on books at report date. Tracks rate quality of current booking position."
    - name: "avg_revpar_on_books"
      expr: AVG(CAST(revpar_on_books AS DOUBLE))
      comment: "Average RevPAR on books at report date. Forward-looking revenue performance indicator."
    - name: "avg_forecasted_adr"
      expr: AVG(CAST(forecasted_adr AS DOUBLE))
      comment: "Average forecasted ADR. Pricing target for remaining inventory."
    - name: "avg_forecasted_revpar"
      expr: AVG(CAST(forecasted_revpar AS DOUBLE))
      comment: "Average forecasted RevPAR. Forward-looking performance target for strategy alignment."
    - name: "avg_adr_variance_to_forecast"
      expr: AVG(CAST(adr_variance_to_forecast AS DOUBLE))
      comment: "Average ADR variance vs forecast. Negative variance triggers rate strategy review."
    - name: "avg_prior_year_adr"
      expr: AVG(CAST(prior_year_adr AS DOUBLE))
      comment: "Average prior year ADR for year-over-year rate comparison."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_group_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business evaluation metrics: displacement cost, net revenue impact, wash factor, and decision outcomes. Used by revenue managers to optimize group acceptance decisions and maximize total revenue."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`group_evaluation`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date — primary time axis for group demand analysis."
    - name: "departure_date"
      expr: departure_date
      comment: "Group departure date — defines group stay window."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level group business analysis."
    - name: "group_type"
      expr: group_type
      comment: "Group type (corporate, association, leisure, SMERF) for segment-level group analysis."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Evaluation status (pending, approved, declined, counter-offered) for pipeline tracking."
    - name: "is_definite_booking"
      expr: is_definite_booking
      comment: "Definite booking flag — distinguishes tentative vs confirmed group business."
    - name: "lead_time_bucket"
      expr: lead_time_bucket
      comment: "Lead time bucket for booking window analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property group revenue normalization."
  measures:
    - name: "total_group_room_revenue"
      expr: SUM(CAST(group_room_revenue AS DOUBLE))
      comment: "Total group room revenue. Primary group revenue contribution metric."
    - name: "total_net_revenue_impact"
      expr: SUM(CAST(net_revenue_impact AS DOUBLE))
      comment: "Total net revenue impact of group decisions. Measures group business value after displacement cost."
    - name: "total_displacement_cost"
      expr: SUM(CAST(displacement_cost AS DOUBLE))
      comment: "Total displacement cost from group bookings. Quantifies transient revenue sacrificed for group business."
    - name: "total_fb_revenue_estimate"
      expr: SUM(CAST(fb_revenue_estimate AS DOUBLE))
      comment: "Total estimated F&B revenue from group. Captures total group spend beyond rooms."
    - name: "total_ancillary_revenue_estimate"
      expr: SUM(CAST(ancillary_revenue_estimate AS DOUBLE))
      comment: "Total estimated ancillary revenue from group. Measures total group value for acceptance decisions."
    - name: "avg_proposed_group_rate"
      expr: AVG(CAST(proposed_group_rate AS DOUBLE))
      comment: "Average proposed group rate. Tracks rate quality of group pipeline."
    - name: "avg_minimum_acceptable_rate"
      expr: AVG(CAST(minimum_acceptable_rate AS DOUBLE))
      comment: "Average minimum acceptable rate. Rate floor for group negotiations."
    - name: "avg_transient_adr_displaced"
      expr: AVG(CAST(transient_adr_displaced AS DOUBLE))
      comment: "Average transient ADR displaced by group. Measures opportunity cost of group acceptance."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(revpar_impact AS DOUBLE))
      comment: "Average RevPAR impact of group decisions. Composite performance impact metric."
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor percentage applied to group blocks. Calibrates group pickup expectations."
    - name: "avg_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage for group contracts. Monitors group pickup performance vs commitment."
    - name: "avg_demand_forecast_occupancy_pct"
      expr: AVG(CAST(demand_forecast_occupancy_pct AS DOUBLE))
      comment: "Average forecasted occupancy at time of group evaluation. Context for displacement risk assessment."
    - name: "definite_group_count"
      expr: COUNT(CASE WHEN is_definite_booking = TRUE THEN 1 END)
      comment: "Count of definite group bookings. Tracks group pipeline conversion to confirmed business."
    - name: "total_group_evaluations"
      expr: COUNT(1)
      comment: "Total group evaluations. Measures group inquiry volume and pipeline activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_displacement_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Displacement analysis metrics quantifying the revenue trade-off between group and transient business. Used by revenue managers to make data-driven group acceptance decisions and optimize total revenue."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date of displacement analysis — primary time axis for analysis tracking."
    - name: "stay_date_from"
      expr: stay_date_from
      comment: "Group stay start date — defines displacement period."
    - name: "stay_date_to"
      expr: stay_date_to
      comment: "Group stay end date — defines displacement period."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level displacement analysis."
    - name: "analysis_type"
      expr: analysis_type
      comment: "Analysis type (group, event, contract) for displacement scenario classification."
    - name: "analysis_status"
      expr: analysis_status
      comment: "Analysis status (pending, approved, declined) for decision pipeline tracking."
    - name: "displacement_risk_level"
      expr: displacement_risk_level
      comment: "Displacement risk level for risk-stratified analysis."
    - name: "is_peak_period"
      expr: is_peak_period
      comment: "Peak period flag — displacement cost is highest during peak demand periods."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Special event flag for event-driven displacement analysis."
    - name: "recommendation_outcome"
      expr: recommendation_outcome
      comment: "Recommendation outcome (accept, decline, counter-offer) for decision quality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property displacement analysis normalization."
  measures:
    - name: "total_net_revenue_impact"
      expr: SUM(CAST(net_revenue_impact AS DOUBLE))
      comment: "Total net revenue impact of displacement decisions. Primary metric for group acceptance ROI."
    - name: "total_transient_revenue_displaced"
      expr: SUM(CAST(transient_room_revenue_displaced AS DOUBLE))
      comment: "Total transient room revenue displaced by group. Quantifies opportunity cost of group acceptance."
    - name: "total_group_room_revenue"
      expr: SUM(CAST(group_room_revenue AS DOUBLE))
      comment: "Total group room revenue from analyzed bookings. Measures group revenue contribution."
    - name: "total_group_spend"
      expr: SUM(CAST(total_group_spend AS DOUBLE))
      comment: "Total group spend including rooms, F&B, and ancillary. Measures total group value for acceptance decisions."
    - name: "total_fb_revenue_contribution"
      expr: SUM(CAST(fb_revenue_contribution AS DOUBLE))
      comment: "Total F&B revenue contribution from group. Captures non-room group value."
    - name: "total_ancillary_revenue_contribution"
      expr: SUM(CAST(ancillary_revenue_contribution AS DOUBLE))
      comment: "Total ancillary revenue contribution from group. Measures total group value beyond rooms."
    - name: "avg_proposed_group_rate"
      expr: AVG(CAST(proposed_group_rate AS DOUBLE))
      comment: "Average proposed group rate. Rate quality metric for group pipeline."
    - name: "avg_min_acceptable_rate"
      expr: AVG(CAST(min_acceptable_rate AS DOUBLE))
      comment: "Average minimum acceptable rate. Rate floor for group negotiations."
    - name: "avg_estimated_transient_adr_displaced"
      expr: AVG(CAST(estimated_transient_adr_displaced AS DOUBLE))
      comment: "Average estimated transient ADR displaced. Measures rate quality of displaced transient business."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(revpar_impact AS DOUBLE))
      comment: "Average RevPAR impact of displacement decisions. Composite performance impact metric."
    - name: "avg_forecast_occupancy_pct"
      expr: AVG(CAST(forecast_occupancy_pct AS DOUBLE))
      comment: "Average forecasted occupancy at time of analysis. Context for displacement risk assessment."
    - name: "total_analyses"
      expr: COUNT(1)
      comment: "Total displacement analyses conducted. Measures group evaluation activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_wash_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block wash factor metrics: historical vs adjusted wash rates, confidence levels, and displacement impact. Used by revenue managers to calibrate group pickup expectations and optimize block sizing."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`wash_factor`"
  filter: factor_status = 'ACTIVE'
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of wash factor — primary time axis for factor validity tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level wash factor management."
    - name: "group_type"
      expr: group_type
      comment: "Group type for segment-specific wash factor analysis."
    - name: "block_size_tier"
      expr: block_size_tier
      comment: "Block size tier for size-stratified wash factor analysis."
    - name: "booking_lead_time_bucket"
      expr: booking_lead_time_bucket
      comment: "Booking lead time bucket for lead-time-stratified wash analysis."
    - name: "season_type"
      expr: season_type
      comment: "Season type for seasonal wash pattern analysis."
    - name: "day_of_week_pattern"
      expr: day_of_week_pattern
      comment: "Day of week pattern for weekday vs weekend wash analysis."
    - name: "is_default_factor"
      expr: is_default_factor
      comment: "Default factor flag — distinguishes system defaults from property-specific calibrations."
    - name: "is_rms_active"
      expr: is_rms_active
      comment: "RMS active flag — identifies wash factors currently used by the revenue management system."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code for channel-specific wash factor analysis."
  measures:
    - name: "avg_historical_wash_pct"
      expr: AVG(CAST(historical_wash_pct AS DOUBLE))
      comment: "Average historical wash percentage. Baseline for wash factor calibration — measures actual group pickup shortfall."
    - name: "avg_adjusted_wash_pct"
      expr: AVG(CAST(adjusted_wash_pct AS DOUBLE))
      comment: "Average adjusted wash percentage. Current wash factor applied to group blocks — drives block sizing decisions."
    - name: "avg_wash_pct_variance"
      expr: AVG(CAST(wash_pct_variance AS DOUBLE))
      comment: "Average variance between historical and adjusted wash. Large variances indicate calibration drift requiring review."
    - name: "avg_displacement_impact_pct"
      expr: AVG(CAST(displacement_impact_pct AS DOUBLE))
      comment: "Average displacement impact percentage. Measures how wash affects transient displacement calculations."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level of wash factor. Low confidence triggers manual review and recalibration."
    - name: "total_wash_factors"
      expr: COUNT(1)
      comment: "Total active wash factor records. Measures wash factor coverage across segments and properties."
    - name: "rms_active_wash_factor_count"
      expr: COUNT(CASE WHEN is_rms_active = TRUE THEN 1 END)
      comment: "Count of wash factors actively used by the RMS. Tracks RMS calibration coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate availability and inventory control metrics: open/closed rates, BAR levels, occupancy forecasts, and parity compliance. Used by revenue managers to monitor rate distribution and availability controls."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_availability`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Snapshot date of rate availability — primary time axis for availability tracking."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month bucket for availability trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level availability management."
    - name: "availability_status"
      expr: availability_status
      comment: "Availability status (open, closed, restricted) for inventory control monitoring."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Rate plan type for rate-level availability analysis."
    - name: "closed_to_arrival"
      expr: closed_to_arrival
      comment: "Closed-to-arrival flag — identifies dates with CTA restrictions."
    - name: "closed_to_departure"
      expr: closed_to_departure
      comment: "Closed-to-departure flag — identifies dates with CTD restrictions."
    - name: "stop_sell"
      expr: stop_sell
      comment: "Stop sell flag — identifies dates where inventory is fully closed."
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Rate parity flag — identifies parity violations requiring channel management action."
    - name: "pricing_override_flag"
      expr: pricing_override_flag
      comment: "Pricing override flag — identifies manually overridden rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property rate normalization."
  measures:
    - name: "avg_bar_rate"
      expr: AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average Best Available Rate. Primary rate level metric for pricing strategy monitoring."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate. Baseline rate for discount and negotiated rate analysis."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor. Monitors rate floor compliance across channels."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling. Monitors rate ceiling compliance."
    - name: "avg_occupancy_forecast_pct"
      expr: AVG(CAST(occupancy_forecast_pct AS DOUBLE))
      comment: "Average forecasted occupancy at rate availability snapshot. Context for rate control decisions."
    - name: "stop_sell_record_count"
      expr: COUNT(CASE WHEN stop_sell = TRUE THEN 1 END)
      comment: "Count of stop-sell records. Monitors inventory closure frequency and duration."
    - name: "cta_record_count"
      expr: COUNT(CASE WHEN closed_to_arrival = TRUE THEN 1 END)
      comment: "Count of closed-to-arrival records. Tracks CTA restriction usage for minimum stay enforcement."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN rate_parity_flag = TRUE THEN 1 END)
      comment: "Count of rate parity violations. Triggers channel management and OTA contract review."
    - name: "pricing_override_count"
      expr: COUNT(CASE WHEN pricing_override_flag = TRUE THEN 1 END)
      comment: "Count of pricing override records. High override counts signal RMS recommendation quality issues."
    - name: "total_availability_records"
      expr: COUNT(1)
      comment: "Total rate availability records. Measures distribution coverage across channels and room types."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue management inventory control metrics: hurdle rates, overbooking levels, sell limits, and occupancy on books. Used by revenue managers to optimize inventory allocation and maximize RevPAR."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`inventory_control`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for inventory control — primary time axis for control monitoring."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket for inventory control trend analysis."
    - name: "control_type"
      expr: control_type
      comment: "Control type (hurdle rate, sell limit, overbooking) for control classification."
    - name: "control_status"
      expr: control_status
      comment: "Control status (active, expired, overridden) for control lifecycle tracking."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "CTA flag for arrival restriction monitoring."
    - name: "is_closed_to_departure"
      expr: is_closed_to_departure
      comment: "CTD flag for departure restriction monitoring."
    - name: "is_override"
      expr: is_override
      comment: "Override flag — identifies manual overrides of system recommendations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property control normalization."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate. Minimum rate threshold for accepting bookings — primary inventory control KPI."
    - name: "avg_current_bar"
      expr: AVG(CAST(current_bar AS DOUBLE))
      comment: "Average current Best Available Rate. Tracks real-time rate level vs hurdle rate."
    - name: "avg_overbooking_pct"
      expr: AVG(CAST(overbooking_pct AS DOUBLE))
      comment: "Average overbooking percentage. Monitors overbooking level vs policy limits."
    - name: "avg_occupancy_on_books"
      expr: AVG(CAST(occupancy_on_books AS DOUBLE))
      comment: "Average occupancy on books at control snapshot. Forward-looking demand signal for pricing decisions."
    - name: "avg_demand_forecast_rooms"
      expr: AVG(CAST(demand_forecast_rooms AS DOUBLE))
      comment: "Average demand forecast rooms. RMS demand signal driving inventory control decisions."
    - name: "avg_control_value"
      expr: AVG(CAST(control_value AS DOUBLE))
      comment: "Average control value (hurdle rate, sell limit, or overbooking cap). Monitors control calibration."
    - name: "avg_system_recommended_value"
      expr: AVG(CAST(system_recommended_value AS DOUBLE))
      comment: "Average RMS-recommended control value. Baseline for override variance analysis."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor applied. Monitors rate floor compliance."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling applied. Monitors rate ceiling compliance."
    - name: "override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Count of manual overrides. High override rates signal RMS recommendation quality issues."
    - name: "cta_control_count"
      expr: COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END)
      comment: "Count of CTA controls active. Monitors minimum stay enforcement coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue strategy planning metrics: target KPIs, strategy status, and planning horizon coverage. Used by revenue managers and GMs to align pricing, channel, and inventory strategies with business objectives."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`strategy`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "planning_horizon_start_date"
      expr: planning_horizon_start_date
      comment: "Strategy planning horizon start date — primary time axis for strategy coverage analysis."
    - name: "planning_horizon_end_date"
      expr: planning_horizon_end_date
      comment: "Strategy planning horizon end date — defines strategy coverage window."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level strategy management."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Strategy type (pricing, channel, inventory, total revenue) for strategy classification."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Strategy status (draft, approved, active, superseded) for strategy lifecycle tracking."
    - name: "horizon_type"
      expr: horizon_type
      comment: "Horizon type (short-term, medium-term, long-term) for planning horizon classification."
    - name: "pricing_approach"
      expr: pricing_approach
      comment: "Pricing approach (BAR-based, dynamic, negotiated) for strategy methodology analysis."
    - name: "channel_focus"
      expr: channel_focus
      comment: "Channel focus for channel strategy alignment."
    - name: "special_event_flag"
      expr: special_event_flag
      comment: "Special event flag for event-driven strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property strategy normalization."
  measures:
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average target RevPAR across active strategies. Primary performance target for strategy alignment."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average target ADR. Pricing target for rate strategy planning."
    - name: "avg_target_occupancy_pct"
      expr: AVG(CAST(target_occupancy_pct AS DOUBLE))
      comment: "Average target occupancy percentage. Volume target for demand and channel strategy."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average target TRevPAR. Total revenue efficiency target for ancillary revenue strategy."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average target GOPPAR. Profitability efficiency target for management fee calculations."
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average target Revenue Generation Index. Competitive performance target for STR benchmarking."
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average target Market Penetration Index. Occupancy share target for demand strategy."
    - name: "avg_target_ari"
      expr: AVG(CAST(target_ari AS DOUBLE))
      comment: "Average target Average Rate Index. Rate share target for pricing strategy."
    - name: "active_strategy_count"
      expr: COUNT(CASE WHEN strategy_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active strategies. Monitors strategy coverage across properties and planning horizons."
    - name: "total_strategies"
      expr: COUNT(1)
      comment: "Total strategy records. Measures strategy planning activity and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_dynamic_rate_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic rate rule performance metrics: trigger frequency, rate adjustment ranges, and rule effectiveness. Used by revenue managers to evaluate and optimize automated pricing rule performance."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`"
  filter: rule_status = 'ACTIVE'
  dimensions:
    - name: "effective_from"
      expr: effective_from
      comment: "Rule effective start date — primary time axis for rule validity tracking."
    - name: "effective_until"
      expr: effective_until
      comment: "Rule effective end date — defines rule validity window."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level rule management."
    - name: "rule_type"
      expr: rule_type
      comment: "Rule type (occupancy-based, pickup-based, competitive) for rule classification."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Adjustment type (percentage, fixed amount) for rule impact analysis."
    - name: "adjustment_direction"
      expr: adjustment_direction
      comment: "Adjustment direction (increase, decrease) for rate movement analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for rule governance tracking."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Stackable flag — identifies rules that can combine with other rules."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property rule normalization."
  measures:
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value. Measures typical rate change magnitude from dynamic rules."
    - name: "avg_min_rate_floor"
      expr: AVG(CAST(min_rate_floor AS DOUBLE))
      comment: "Average minimum rate floor across rules. Monitors rate floor protection across the portfolio."
    - name: "avg_max_rate_ceiling"
      expr: AVG(CAST(max_rate_ceiling AS DOUBLE))
      comment: "Average maximum rate ceiling across rules. Monitors rate ceiling constraints."
    - name: "avg_trigger_threshold_value"
      expr: AVG(CAST(trigger_threshold_value AS DOUBLE))
      comment: "Average trigger threshold value. Calibration metric for rule sensitivity analysis."
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN rule_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active dynamic rate rules. Measures automated pricing coverage."
    - name: "approved_rule_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved rules. Tracks rule governance compliance."
    - name: "stackable_rule_count"
      expr: COUNT(CASE WHEN is_stackable = TRUE THEN 1 END)
      comment: "Count of stackable rules. Monitors rule combination complexity and potential rate impact."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiated rate portfolio metrics: rate levels, commitment volumes, commission rates, and contract status. Used by revenue and sales teams to manage corporate and consortia rate agreements."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate`"
  filter: record_status = 'ACTIVE'
  dimensions:
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date — primary time axis for rate agreement validity."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date — defines rate agreement expiry for renewal planning."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level negotiated rate management."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type (corporate, consortia, government, wholesale) for rate portfolio classification."
    - name: "rate_status"
      expr: rate_status
      comment: "Rate status (active, expired, pending) for rate lifecycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for rate governance tracking."
    - name: "is_lra"
      expr: is_lra
      comment: "Last Room Available flag — LRA rates have higher value and different displacement rules."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Non-refundable flag for rate type classification."
    - name: "breakfast_included"
      expr: breakfast_included
      comment: "Breakfast included flag for rate value comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property rate normalization."
  measures:
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount. Primary rate level metric for portfolio pricing analysis."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage on negotiated rates. Monitors commission cost of negotiated rate portfolio."
    - name: "avg_rate_bar_variance_pct"
      expr: AVG(CAST(rate_bar_variance_pct AS DOUBLE))
      comment: "Average negotiated rate variance vs BAR. Measures discount depth of negotiated rate portfolio."
    - name: "total_active_negotiated_rates"
      expr: COUNT(CASE WHEN rate_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active negotiated rates. Measures negotiated rate portfolio size."
    - name: "lra_rate_count"
      expr: COUNT(CASE WHEN is_lra = TRUE THEN 1 END)
      comment: "Count of Last Room Available rates. LRA rates represent highest-value corporate commitments."
    - name: "expiring_rate_count"
      expr: COUNT(CASE WHEN contract_end_date <= CURRENT_DATE() THEN 1 END)
      comment: "Count of expired or expiring rate contracts. Triggers renewal pipeline management."
    - name: "total_negotiated_rates"
      expr: COUNT(1)
      comment: "Total negotiated rate records. Measures overall negotiated rate portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_segment_program_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment program eligibility metrics: discount levels, eligibility coverage, and program participation. Used by revenue and loyalty teams to manage segment-program alignment and rate plan eligibility rules."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility`"
  filter: is_active = TRUE
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Eligibility effective date — primary time axis for eligibility validity tracking."
    - name: "eligibility_end_date"
      expr: eligibility_end_date
      comment: "Eligibility end date — defines eligibility expiry for renewal planning."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level eligibility management."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status (active, expired, pending) for eligibility lifecycle management."
    - name: "eligibility_basis"
      expr: eligibility_basis
      comment: "Eligibility basis (segment, tier, channel) for eligibility rule classification."
    - name: "approval_required"
      expr: approval_required
      comment: "Approval required flag for eligibility governance tracking."
    - name: "combinable_with_other_offers"
      expr: combinable_with_other_offers
      comment: "Combinable flag — identifies stackable program eligibility rules."
    - name: "enrollment_eligibility_flag"
      expr: enrollment_eligibility_flag
      comment: "Enrollment eligibility flag — identifies programs open for new enrollment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-property eligibility normalization."
  measures:
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage across eligibility rules. Monitors discount depth of segment-program portfolio."
    - name: "avg_program_discount_pct"
      expr: AVG(CAST(program_discount_pct AS DOUBLE))
      comment: "Average program-specific discount percentage. Tracks program discount competitiveness."
    - name: "avg_max_discount_amount"
      expr: AVG(CAST(max_discount_amount AS DOUBLE))
      comment: "Average maximum discount amount cap. Monitors discount exposure limits."
    - name: "avg_min_spend_threshold"
      expr: AVG(CAST(min_spend_threshold AS DOUBLE))
      comment: "Average minimum spend threshold for eligibility. Tracks revenue floor requirements for program participation."
    - name: "active_eligibility_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active eligibility rules. Measures active segment-program coverage."
    - name: "approval_required_count"
      expr: COUNT(CASE WHEN approval_required = TRUE THEN 1 END)
      comment: "Count of eligibility rules requiring approval. Monitors governance overhead in program management."
    - name: "total_eligibility_rules"
      expr: COUNT(1)
      comment: "Total eligibility rule records. Measures segment-program eligibility portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_pricing_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing override and rate exception tracking for revenue management control"
  source: "`vibe_travel_hospitality_v1`.`revenue`.`pricing_override`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of pricing override"
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of pricing override"
    - name: "override_status"
      expr: override_status
      comment: "Status of pricing override"
    - name: "override_reason_code"
      expr: override_reason_code
      comment: "Reason code for override"
    - name: "override_scope"
      expr: override_scope
      comment: "Scope of pricing override"
    - name: "is_bar_override"
      expr: is_bar_override
      comment: "Flag indicating best available rate override"
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating if approval is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of override amounts"
  measures:
    - name: "total_override_count"
      expr: COUNT(1)
      comment: "Total count of pricing overrides"
    - name: "avg_override_rate"
      expr: AVG(CAST(override_rate AS DOUBLE))
      comment: "Average override rate amount"
    - name: "avg_rms_recommended_rate"
      expr: AVG(CAST(rms_recommended_rate AS DOUBLE))
      comment: "Average RMS recommended rate"
    - name: "avg_rate_variance_amount"
      expr: AVG(CAST(rate_variance_amount AS DOUBLE))
      comment: "Average rate variance amount from recommended"
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average rate variance percentage from recommended"
    - name: "avg_competitive_rate_reference"
      expr: AVG(CAST(competitive_rate_reference AS DOUBLE))
      comment: "Average competitive rate reference"
    - name: "avg_approval_threshold_pct"
      expr: AVG(CAST(approval_threshold_pct AS DOUBLE))
      comment: "Average approval threshold percentage"
$$;