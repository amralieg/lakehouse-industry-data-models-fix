-- Metric views for domain: revenue | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_channel_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel performance and distribution cost metrics for revenue management"
  source: "`travel_hospitality_ecm`.`revenue`.`channel_contribution`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Date of business activity"
    - name: "business_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Month of business activity"
    - name: "channel_type"
      expr: channel_type
      comment: "Type of distribution channel"
    - name: "is_direct_channel"
      expr: is_direct_channel
      comment: "Flag indicating direct booking channel"
    - name: "is_ota_channel"
      expr: is_ota_channel
      comment: "Flag indicating online travel agency channel"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
    - name: "contribution_status"
      expr: contribution_status
      comment: "Status of channel contribution record"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Total gross revenue before distribution costs"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after commissions and fees"
    - name: "total_distribution_cost"
      expr: SUM(CAST(total_distribution_cost AS DOUBLE))
      comment: "Total cost of distribution including commissions and GDS fees"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to intermediaries"
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate as percentage"
    - name: "avg_channel_mix_pct"
      expr: AVG(CAST(channel_mix_pct AS DOUBLE))
      comment: "Average channel mix percentage"
    - name: "avg_cost_per_booking"
      expr: AVG(CAST(cost_per_booking AS DOUBLE))
      comment: "Average cost per booking across channels"
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average daily rate across channel bookings"
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average revenue per available room"
    - name: "total_revenue_net_of_distribution"
      expr: SUM(CAST(revenue_net_of_distribution AS DOUBLE))
      comment: "Total revenue after all distribution costs"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue performance and operational KPIs for property management"
  source: "`travel_hospitality_ecm`.`revenue`.`performance_actuals`"
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Date of performance actuals"
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_date)
      comment: "Month of performance actuals"
    - name: "performance_year"
      expr: YEAR(performance_date)
      comment: "Year of performance actuals"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating if actuals are reconciled"
    - name: "record_status"
      expr: record_status
      comment: "Status of performance record"
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue for the period"
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total property revenue including all departments"
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue"
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue from spa, parking, and other services"
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average daily rate across all rooms sold"
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate as percentage"
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average revenue per available room"
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average total revenue per available room"
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average gross operating profit per available room"
    - name: "total_gop"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Total gross operating profit"
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution"
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average revenue generation index vs competitive set"
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average market penetration index vs competitive set"
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average rate index vs competitive set"
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average cost per occupied room"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting and projected performance metrics for revenue optimization"
  source: "`travel_hospitality_ecm`.`revenue`.`demand_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date of forecast generation"
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month of forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of demand forecast"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of forecast record"
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Type of forecasting model used"
    - name: "is_override"
      expr: is_override
      comment: "Flag indicating manual override of forecast"
    - name: "is_special_event"
      expr: is_special_event
      comment: "Flag indicating special event period"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for forecast"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of forecasted amounts"
  measures:
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue"
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected average daily rate"
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage"
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected revenue per available room"
    - name: "total_unconstrained_demand"
      expr: SUM(CAST(unconstrained_demand AS DOUBLE))
      comment: "Total unconstrained demand without capacity limits"
    - name: "total_constrained_demand"
      expr: SUM(CAST(constrained_demand AS DOUBLE))
      comment: "Total constrained demand with capacity limits"
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average mean absolute percentage error of forecast accuracy"
    - name: "avg_booking_pace_index"
      expr: AVG(CAST(booking_pace_index AS DOUBLE))
      comment: "Average booking pace index vs historical patterns"
    - name: "avg_projected_cancellations"
      expr: AVG(CAST(projected_cancellations AS DOUBLE))
      comment: "Average projected cancellation rate"
    - name: "avg_projected_no_shows"
      expr: AVG(CAST(projected_no_shows AS DOUBLE))
      comment: "Average projected no-show rate"
    - name: "avg_rgi_forecast"
      expr: AVG(CAST(rgi_forecast AS DOUBLE))
      comment: "Average forecasted revenue generation index"
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Average forecasted market penetration index"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_displacement_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business displacement and revenue impact analysis for strategic decision-making"
  source: "`travel_hospitality_ecm`.`revenue`.`displacement_analysis`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date of displacement analysis"
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of analysis record"
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of displacement analysis"
    - name: "recommendation_outcome"
      expr: recommendation_outcome
      comment: "Outcome recommendation from analysis"
    - name: "displacement_risk_level"
      expr: displacement_risk_level
      comment: "Risk level of displacement"
    - name: "is_peak_period"
      expr: is_peak_period
      comment: "Flag indicating peak demand period"
    - name: "is_special_event"
      expr: is_special_event
      comment: "Flag indicating special event period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
  measures:
    - name: "total_net_revenue_impact"
      expr: SUM(CAST(net_revenue_impact AS DOUBLE))
      comment: "Total net revenue impact of group business decision"
    - name: "total_group_room_revenue"
      expr: SUM(CAST(group_room_revenue AS DOUBLE))
      comment: "Total room revenue from group business"
    - name: "total_transient_room_revenue_displaced"
      expr: SUM(CAST(transient_room_revenue_displaced AS DOUBLE))
      comment: "Total transient room revenue displaced by group"
    - name: "total_fb_revenue_contribution"
      expr: SUM(CAST(fb_revenue_contribution AS DOUBLE))
      comment: "Total food and beverage revenue contribution from group"
    - name: "total_ancillary_revenue_contribution"
      expr: SUM(CAST(ancillary_revenue_contribution AS DOUBLE))
      comment: "Total ancillary revenue contribution from group"
    - name: "total_group_spend"
      expr: SUM(CAST(total_group_spend AS DOUBLE))
      comment: "Total spend from group including all revenue streams"
    - name: "avg_proposed_group_rate"
      expr: AVG(CAST(proposed_group_rate AS DOUBLE))
      comment: "Average proposed group rate"
    - name: "avg_estimated_transient_adr_displaced"
      expr: AVG(CAST(estimated_transient_adr_displaced AS DOUBLE))
      comment: "Average estimated transient ADR that would be displaced"
    - name: "avg_min_acceptable_rate"
      expr: AVG(CAST(min_acceptable_rate AS DOUBLE))
      comment: "Average minimum acceptable rate for group business"
    - name: "avg_revpar_impact"
      expr: AVG(CAST(revpar_impact AS DOUBLE))
      comment: "Average RevPAR impact of group decision"
    - name: "avg_forecast_occupancy_pct"
      expr: AVG(CAST(forecast_occupancy_pct AS DOUBLE))
      comment: "Average forecasted occupancy percentage for analysis period"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_pricing_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing override and rate exception tracking for revenue management control"
  source: "`travel_hospitality_ecm`.`revenue`.`pricing_override`"
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

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_competitor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive rate shopping and market positioning intelligence"
  source: "`travel_hospitality_ecm`.`revenue`.`competitor_rate`"
  dimensions:
    - name: "shop_date"
      expr: shop_date
      comment: "Date when rate was shopped"
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for shopped rate"
    - name: "channel_shopped"
      expr: channel_shopped
      comment: "Channel where rate was shopped"
    - name: "competitor_property_name"
      expr: competitor_property_name
      comment: "Name of competitor property"
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan shopped"
    - name: "availability_status"
      expr: availability_status
      comment: "Availability status at time of shop"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for stay date"
    - name: "is_weekend"
      expr: is_weekend
      comment: "Flag indicating weekend stay"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of shopped rates"
  measures:
    - name: "avg_shopped_rate"
      expr: AVG(CAST(shopped_rate AS DOUBLE))
      comment: "Average competitor rate shopped"
    - name: "avg_our_rate"
      expr: AVG(CAST(our_rate AS DOUBLE))
      comment: "Average our rate for comparison"
    - name: "avg_rate_gap"
      expr: AVG(CAST(rate_gap AS DOUBLE))
      comment: "Average rate gap vs competitor"
    - name: "avg_rate_delta"
      expr: AVG(CAST(rate_delta AS DOUBLE))
      comment: "Average rate delta from previous shop"
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average rate index vs competitor set"
    - name: "avg_rate_in_usd"
      expr: AVG(CAST(rate_in_usd AS DOUBLE))
      comment: "Average rate converted to USD"
    - name: "total_rate_shops"
      expr: COUNT(1)
      comment: "Total count of rate shops performed"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue budget targets and strategic planning metrics for performance management"
  source: "`travel_hospitality_ecm`.`revenue`.`revenue_budget`"
  dimensions:
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of planning period"
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of planning period"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of budget"
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of revenue strategy"
    - name: "strategy_status"
      expr: strategy_status
      comment: "Status of strategy"
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Type of planning horizon"
    - name: "is_owner_approved"
      expr: is_owner_approved
      comment: "Flag indicating owner approval"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of budget amounts"
  measures:
    - name: "total_budgeted_room_revenue"
      expr: SUM(CAST(budgeted_room_revenue AS DOUBLE))
      comment: "Total budgeted room revenue"
    - name: "total_budgeted_fb_revenue"
      expr: SUM(CAST(budgeted_fb_revenue AS DOUBLE))
      comment: "Total budgeted food and beverage revenue"
    - name: "total_budgeted_total_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all departments"
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted gross operating profit"
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average target average daily rate"
    - name: "avg_target_occupancy_rate"
      expr: AVG(CAST(target_occupancy_rate AS DOUBLE))
      comment: "Average target occupancy rate"
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average target revenue per available room"
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average target gross operating profit per available room"
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average target revenue generation index"
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average target market penetration index"
    - name: "avg_budgeted_cpor"
      expr: AVG(CAST(budgeted_cpor AS DOUBLE))
      comment: "Average budgeted cost per occupied room"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_str_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "STR competitive benchmarking and market positioning metrics for strategic analysis"
  source: "`travel_hospitality_ecm`.`revenue`.`str_benchmark`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for benchmark data"
    - name: "shop_date"
      expr: shop_date
      comment: "Date when rate was shopped"
    - name: "report_period_start_date"
      expr: report_period_start_date
      comment: "Start date of reporting period"
    - name: "report_period_end_date"
      expr: report_period_end_date
      comment: "End date of reporting period"
    - name: "report_period_type"
      expr: report_period_type
      comment: "Type of reporting period"
    - name: "record_type"
      expr: record_type
      comment: "Type of benchmark record"
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Status of benchmark data"
    - name: "competitor_property_name"
      expr: competitor_property_name
      comment: "Name of competitor property"
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Flag indicating rate parity compliance"
  measures:
    - name: "avg_property_adr"
      expr: AVG(CAST(property_adr AS DOUBLE))
      comment: "Average property ADR"
    - name: "avg_comp_set_adr"
      expr: AVG(CAST(comp_set_adr AS DOUBLE))
      comment: "Average competitive set ADR"
    - name: "avg_property_occupancy_rate"
      expr: AVG(CAST(property_occupancy_rate AS DOUBLE))
      comment: "Average property occupancy rate"
    - name: "avg_comp_set_occupancy_rate"
      expr: AVG(CAST(comp_set_occupancy_rate AS DOUBLE))
      comment: "Average competitive set occupancy rate"
    - name: "avg_property_revpar"
      expr: AVG(CAST(property_revpar AS DOUBLE))
      comment: "Average property RevPAR"
    - name: "avg_comp_set_revpar"
      expr: AVG(CAST(comp_set_revpar AS DOUBLE))
      comment: "Average competitive set RevPAR"
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average revenue generation index"
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average market penetration index"
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average rate index"
    - name: "avg_shopped_rate_amount"
      expr: AVG(CAST(shopped_rate_amount AS DOUBLE))
      comment: "Average shopped rate amount"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_pickup_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking pace and pickup velocity metrics for demand forecasting and revenue optimization"
  source: "`travel_hospitality_ecm`.`revenue`.`pickup_report`"
  dimensions:
    - name: "report_date"
      expr: report_date
      comment: "Date of pickup report"
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date for pickup analysis"
    - name: "report_type"
      expr: report_type
      comment: "Type of pickup report"
    - name: "report_status"
      expr: report_status
      comment: "Status of pickup report"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for stay date"
    - name: "is_weekend"
      expr: is_weekend
      comment: "Flag indicating weekend stay"
    - name: "is_special_event"
      expr: is_special_event
      comment: "Flag indicating special event period"
    - name: "demand_level"
      expr: demand_level
      comment: "Demand level classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
  measures:
    - name: "avg_pickup_velocity"
      expr: AVG(CAST(pickup_velocity AS DOUBLE))
      comment: "Average booking pickup velocity"
    - name: "avg_adr_on_books"
      expr: AVG(CAST(adr_on_books AS DOUBLE))
      comment: "Average ADR for rooms on books"
    - name: "avg_revpar_on_books"
      expr: AVG(CAST(revpar_on_books AS DOUBLE))
      comment: "Average RevPAR for rooms on books"
    - name: "avg_forecasted_adr"
      expr: AVG(CAST(forecasted_adr AS DOUBLE))
      comment: "Average forecasted ADR"
    - name: "avg_forecasted_revpar"
      expr: AVG(CAST(forecasted_revpar AS DOUBLE))
      comment: "Average forecasted RevPAR"
    - name: "avg_adr_variance_to_forecast"
      expr: AVG(CAST(adr_variance_to_forecast AS DOUBLE))
      comment: "Average ADR variance to forecast"
    - name: "avg_prior_year_adr"
      expr: AVG(CAST(prior_year_adr AS DOUBLE))
      comment: "Average prior year ADR for comparison"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`revenue_wash_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group attrition and wash factor metrics for accurate group revenue forecasting"
  source: "`travel_hospitality_ecm`.`revenue`.`wash_factor`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of wash factor"
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of wash factor"
    - name: "factor_status"
      expr: factor_status
      comment: "Status of wash factor"
    - name: "group_type"
      expr: group_type
      comment: "Type of group business"
    - name: "block_size_tier"
      expr: block_size_tier
      comment: "Tier of block size"
    - name: "booking_lead_time_bucket"
      expr: booking_lead_time_bucket
      comment: "Lead time bucket for booking"
    - name: "season_type"
      expr: season_type
      comment: "Type of season"
    - name: "is_default_factor"
      expr: is_default_factor
      comment: "Flag indicating default wash factor"
    - name: "is_rms_active"
      expr: is_rms_active
      comment: "Flag indicating if active in RMS"
  measures:
    - name: "avg_historical_wash_pct"
      expr: AVG(CAST(historical_wash_pct AS DOUBLE))
      comment: "Average historical wash percentage"
    - name: "avg_adjusted_wash_pct"
      expr: AVG(CAST(adjusted_wash_pct AS DOUBLE))
      comment: "Average adjusted wash percentage"
    - name: "avg_wash_pct_variance"
      expr: AVG(CAST(wash_pct_variance AS DOUBLE))
      comment: "Average variance between historical and adjusted wash"
    - name: "avg_displacement_impact_pct"
      expr: AVG(CAST(displacement_impact_pct AS DOUBLE))
      comment: "Average displacement impact percentage"
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level percentage"
    - name: "total_wash_factors"
      expr: COUNT(1)
      comment: "Total count of wash factors defined"
$$;