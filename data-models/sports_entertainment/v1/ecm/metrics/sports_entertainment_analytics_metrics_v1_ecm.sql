-- Metric views for domain: analytics | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_attribution_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution performance metrics tracking conversion revenue, channel effectiveness, and attribution model accuracy across fan journeys"
  source: "`sports_entertainment_ecm`.`analytics`.`attribution_result`"
  dimensions:
    - name: "attributed_channel"
      expr: attributed_channel
      comment: "Marketing channel credited with conversion (e.g., social, broadcast, email, digital)"
    - name: "attributed_channel_subtype"
      expr: attributed_channel_subtype
      comment: "Detailed channel subtype for granular attribution analysis"
    - name: "conversion_event_type"
      expr: conversion_event_type
      comment: "Type of conversion event (ticket purchase, merchandise order, subscription, wager)"
    - name: "attribution_model_type"
      expr: attribution_model_type
      comment: "Attribution methodology applied (first-touch, last-touch, linear, time-decay, algorithmic)"
    - name: "fan_segment_code"
      expr: fan_segment_code
      comment: "Fan segment for cohort-based attribution analysis"
    - name: "market_region_code"
      expr: market_region_code
      comment: "Geographic market for regional attribution performance"
    - name: "device_type"
      expr: device_type
      comment: "Device type used in conversion journey (mobile, desktop, tablet, connected TV)"
    - name: "is_converting_touchpoint"
      expr: is_converting_touchpoint
      comment: "Flag indicating whether this touchpoint directly converted"
    - name: "is_first_touchpoint"
      expr: is_first_touchpoint
      comment: "Flag indicating whether this was the first touchpoint in the journey"
    - name: "attribution_run_month"
      expr: DATE_TRUNC('MONTH', attribution_run_date)
      comment: "Month of attribution run for time-series analysis"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_timestamp)
      comment: "Month of conversion event for trend analysis"
  measures:
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue AS DOUBLE))
      comment: "Total revenue attributed to marketing touchpoints across all channels"
    - name: "total_conversion_revenue"
      expr: SUM(CAST(conversion_revenue AS DOUBLE))
      comment: "Total actual conversion revenue generated from attributed journeys"
    - name: "total_attributed_cost"
      expr: SUM(CAST(attributed_cost AS DOUBLE))
      comment: "Total marketing cost attributed to touchpoints in conversion journeys"
    - name: "total_touchpoint_cost"
      expr: SUM(CAST(touchpoint_cost AS DOUBLE))
      comment: "Total cost of individual touchpoints across all journeys"
    - name: "avg_credit_weight"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average attribution credit weight assigned to touchpoints"
    - name: "total_conversions"
      expr: COUNT(DISTINCT CASE WHEN is_converting_touchpoint = TRUE THEN attribution_result_id END)
      comment: "Total number of conversion events attributed"
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of marketing touchpoints in attributed journeys"
    - name: "unique_fan_journeys"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Distinct fans with attributed conversion journeys"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_audience_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast and digital audience measurement KPIs including viewership, ratings, engagement, and monetization metrics"
  source: "`sports_entertainment_ecm`.`analytics`.`audience_measurement`"
  dimensions:
    - name: "broadcast_type"
      expr: broadcast_type
      comment: "Type of broadcast (live, replay, highlight, on-demand)"
    - name: "sport_type"
      expr: sport_type
      comment: "Sport or entertainment property measured"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Measurement provider (Nielsen, Adobe Analytics, internal platform)"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used for audience measurement (panel, census, hybrid)"
    - name: "country_code"
      expr: country_code
      comment: "Country of audience measurement"
    - name: "geographic_market_code"
      expr: geographic_market_code
      comment: "Geographic market or DMA for regional analysis"
    - name: "demographic_segment_code"
      expr: demographic_segment_code
      comment: "Demographic segment measured (e.g., Adults 18-49, HH income)"
    - name: "is_live_event"
      expr: is_live_event
      comment: "Flag indicating live event broadcast vs on-demand"
    - name: "is_ppv"
      expr: is_ppv
      comment: "Flag indicating pay-per-view event"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement for time-series analysis"
  measures:
    - name: "total_unique_viewers"
      expr: SUM(CAST(total_unique_viewers AS DOUBLE))
      comment: "Total unique viewers across all measured broadcasts"
    - name: "total_live_viewers"
      expr: SUM(CAST(live_viewers AS DOUBLE))
      comment: "Total live concurrent viewers during broadcast"
    - name: "peak_concurrent_viewers"
      expr: MAX(CAST(peak_concurrent_viewers AS DOUBLE))
      comment: "Maximum concurrent viewers reached across measured broadcasts"
    - name: "avg_minute_audience"
      expr: AVG(CAST(ama AS DOUBLE))
      comment: "Average minute audience across measured broadcasts"
    - name: "total_viewing_minutes"
      expr: SUM(CAST(viewing_duration_minutes AS DOUBLE))
      comment: "Total minutes of content consumed across all viewers"
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average content completion rate as percentage"
    - name: "avg_household_rating"
      expr: AVG(CAST(household_rating AS DOUBLE))
      comment: "Average household rating across measured broadcasts"
    - name: "avg_persons_rating"
      expr: AVG(CAST(persons_rating AS DOUBLE))
      comment: "Average persons rating across measured broadcasts"
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total gross rating points delivered across broadcasts"
    - name: "avg_audience_share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average share of total viewing audience"
    - name: "total_broadcast_minutes"
      expr: SUM(CAST(broadcast_duration_minutes AS DOUBLE))
      comment: "Total minutes of broadcast content measured"
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of audience measurement records"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_engagement_index`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Composite fan engagement index tracking multi-dimensional engagement across attendance, digital, broadcast, merchandise, and loyalty"
  source: "`sports_entertainment_ecm`.`analytics`.`engagement_index`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of entity measured (league, franchise, venue, event, fan segment)"
    - name: "entity_name"
      expr: entity_name
      comment: "Name of entity being measured"
    - name: "index_period_type"
      expr: index_period_type
      comment: "Period type for index calculation (daily, weekly, monthly, seasonal)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of engagement measurement"
    - name: "index_status"
      expr: index_status
      comment: "Status of index calculation (draft, published, archived)"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend direction vs prior period (improving, declining, stable)"
    - name: "is_baseline_period"
      expr: is_baseline_period
      comment: "Flag indicating baseline period for comparison"
    - name: "is_published_to_dashboard"
      expr: is_published_to_dashboard
      comment: "Flag indicating index is published to executive dashboards"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of period start for time-series analysis"
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite engagement index score across entities"
    - name: "avg_attendance_score"
      expr: AVG(CAST(attendance_score AS DOUBLE))
      comment: "Average attendance engagement component score"
    - name: "avg_digital_activity_score"
      expr: AVG(CAST(digital_activity_score AS DOUBLE))
      comment: "Average digital activity engagement component score"
    - name: "avg_broadcast_consumption_score"
      expr: AVG(CAST(broadcast_consumption_score AS DOUBLE))
      comment: "Average broadcast consumption engagement component score"
    - name: "avg_merchandise_score"
      expr: AVG(CAST(merchandise_score AS DOUBLE))
      comment: "Average merchandise purchase engagement component score"
    - name: "avg_loyalty_score"
      expr: AVG(CAST(loyalty_score AS DOUBLE))
      comment: "Average loyalty program engagement component score"
    - name: "avg_social_media_score"
      expr: AVG(CAST(social_media_score AS DOUBLE))
      comment: "Average social media engagement component score"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across measured entities"
    - name: "avg_score_change_pct"
      expr: AVG(CAST(score_change_pct AS DOUBLE))
      comment: "Average percentage change in composite score vs prior period"
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_pct AS DOUBLE))
      comment: "Average data completeness percentage for index calculation quality"
    - name: "total_engagement_indices"
      expr: COUNT(1)
      comment: "Total number of engagement index calculations"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_fan_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Predictive fan scoring metrics including lifetime value, churn risk, propensity models, and fan tier segmentation"
  source: "`sports_entertainment_ecm`.`analytics`.`fan_score`"
  dimensions:
    - name: "score_type"
      expr: score_type
      comment: "Type of predictive score (LTV, churn_risk, propensity_to_buy, engagement_propensity)"
    - name: "fan_tier"
      expr: fan_tier
      comment: "Fan tier segment (platinum, gold, silver, bronze, casual)"
    - name: "nps_segment"
      expr: nps_segment
      comment: "Net Promoter Score segment (promoter, passive, detractor)"
    - name: "churn_risk_reason"
      expr: churn_risk_reason
      comment: "Primary reason for churn risk classification"
    - name: "percentile_band"
      expr: percentile_band
      comment: "Score percentile band for segmentation (top 10%, top 25%, etc.)"
    - name: "score_trend"
      expr: score_trend
      comment: "Score trend direction (improving, declining, stable)"
    - name: "score_status"
      expr: score_status
      comment: "Status of score (active, expired, pending_refresh)"
    - name: "activation_eligible"
      expr: activation_eligible
      comment: "Flag indicating fan is eligible for marketing activation"
    - name: "consent_verified"
      expr: consent_verified
      comment: "Flag indicating marketing consent is verified"
    - name: "is_season_ticket_holder"
      expr: is_season_ticket_holder
      comment: "Flag indicating season ticket holder status"
    - name: "model_algorithm"
      expr: model_algorithm
      comment: "Machine learning algorithm used for scoring"
    - name: "score_month"
      expr: DATE_TRUNC('MONTH', score_date)
      comment: "Month of score calculation for time-series analysis"
  measures:
    - name: "avg_score_value"
      expr: AVG(CAST(score_value AS DOUBLE))
      comment: "Average predictive score value across fans"
    - name: "avg_ltv_amount"
      expr: AVG(CAST(ltv_amount AS DOUBLE))
      comment: "Average predicted lifetime value per fan"
    - name: "total_ltv_amount"
      expr: SUM(CAST(ltv_amount AS DOUBLE))
      comment: "Total predicted lifetime value across all scored fans"
    - name: "avg_score_percentile"
      expr: AVG(CAST(score_percentile AS DOUBLE))
      comment: "Average score percentile across fans"
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average model confidence level percentage"
    - name: "avg_score_delta"
      expr: AVG(CAST(score_delta AS DOUBLE))
      comment: "Average change in score vs previous scoring period"
    - name: "total_scored_fans"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Total number of unique fans with predictive scores"
    - name: "total_activation_eligible_fans"
      expr: COUNT(DISTINCT CASE WHEN activation_eligible = TRUE THEN fan_profile_id END)
      comment: "Total fans eligible for marketing activation based on scores"
    - name: "total_fan_scores"
      expr: COUNT(1)
      comment: "Total number of fan score records"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_forecast_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business forecast performance metrics tracking forecast accuracy, variance, and predictive model effectiveness across revenue, attendance, and operational KPIs"
  source: "`sports_entertainment_ecm`.`analytics`.`forecast_output`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (revenue, attendance, merchandise_sales, viewership, cost)"
    - name: "metric_name"
      expr: metric_name
      comment: "Name of metric being forecasted"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of forecasted metric (financial, operational, engagement)"
    - name: "forecast_scenario_label"
      expr: forecast_scenario_label
      comment: "Forecast scenario (base_case, optimistic, pessimistic, stress_test)"
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of forecast (daily, weekly, monthly, quarterly)"
    - name: "algorithm_type"
      expr: algorithm_type
      comment: "Forecasting algorithm used (ARIMA, Prophet, XGBoost, ensemble)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of forecast"
    - name: "forecast_output_status"
      expr: forecast_output_status
      comment: "Status of forecast (draft, approved, published, superseded)"
    - name: "is_actuals_available"
      expr: is_actuals_available
      comment: "Flag indicating actual values are available for accuracy measurement"
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating forecast has been approved for business use"
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Month of forecast period for time-series analysis"
  measures:
    - name: "avg_point_forecast_value"
      expr: AVG(CAST(point_forecast_value AS DOUBLE))
      comment: "Average point forecast value across all forecasts"
    - name: "total_point_forecast_value"
      expr: SUM(CAST(point_forecast_value AS DOUBLE))
      comment: "Total forecasted value across all forecasts"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value where available for accuracy assessment"
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Total actual value where available for accuracy assessment"
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average variance between forecast and actual (forecast minus actual)"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average percentage variance between forecast and actual"
    - name: "avg_model_accuracy_score"
      expr: AVG(CAST(model_accuracy_score AS DOUBLE))
      comment: "Average model accuracy score across forecasts"
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level percentage for forecasts"
    - name: "avg_lower_confidence_interval"
      expr: AVG(CAST(lower_confidence_interval AS DOUBLE))
      comment: "Average lower bound of confidence interval"
    - name: "avg_upper_confidence_interval"
      expr: AVG(CAST(upper_confidence_interval AS DOUBLE))
      comment: "Average upper bound of confidence interval"
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of forecast outputs"
    - name: "total_forecasts_with_actuals"
      expr: COUNT(CASE WHEN is_actuals_available = TRUE THEN 1 END)
      comment: "Total forecasts with actual values available for accuracy measurement"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI target performance tracking variance, achievement rates, and target governance across strategic and operational metrics"
  source: "`sports_entertainment_ecm`.`analytics`.`kpi_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of target (annual, quarterly, monthly, event-based)"
    - name: "kpi_category"
      expr: kpi_category
      comment: "Category of KPI (financial, operational, fan_engagement, compliance)"
    - name: "target_status"
      expr: target_status
      comment: "Status of target (active, achieved, missed, revised, archived)"
    - name: "target_direction"
      expr: target_direction
      comment: "Direction of target (maximize, minimize, maintain)"
    - name: "target_basis"
      expr: target_basis
      comment: "Basis for target setting (historical, benchmark, strategic, regulatory)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of target"
    - name: "is_board_approved"
      expr: is_board_approved
      comment: "Flag indicating board-level approval of target"
    - name: "is_public_commitment"
      expr: is_public_commitment
      comment: "Flag indicating publicly committed target"
    - name: "is_revised"
      expr: is_revised
      comment: "Flag indicating target has been revised"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of target performance reporting"
    - name: "target_period_month"
      expr: DATE_TRUNC('MONTH', target_period_start_date)
      comment: "Month of target period for time-series analysis"
  measures:
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all KPI targets"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across all KPI targets"
    - name: "avg_stretch_target_value"
      expr: AVG(CAST(stretch_target_value AS DOUBLE))
      comment: "Average stretch target value for aspirational performance"
    - name: "avg_minimum_threshold_value"
      expr: AVG(CAST(minimum_threshold_value AS DOUBLE))
      comment: "Average minimum acceptable threshold value"
    - name: "avg_benchmark_value"
      expr: AVG(CAST(benchmark_value AS DOUBLE))
      comment: "Average benchmark value for comparative performance"
    - name: "avg_prior_year_actual_value"
      expr: AVG(CAST(prior_year_actual_value AS DOUBLE))
      comment: "Average prior year actual value for year-over-year comparison"
    - name: "avg_variance_tolerance_pct"
      expr: AVG(CAST(variance_tolerance_pct AS DOUBLE))
      comment: "Average acceptable variance tolerance percentage"
    - name: "total_kpi_targets"
      expr: COUNT(1)
      comment: "Total number of KPI targets set"
    - name: "total_board_approved_targets"
      expr: COUNT(CASE WHEN is_board_approved = TRUE THEN 1 END)
      comment: "Total number of board-approved KPI targets"
    - name: "total_public_commitment_targets"
      expr: COUNT(CASE WHEN is_public_commitment = TRUE THEN 1 END)
      comment: "Total number of publicly committed KPI targets"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_model_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Machine learning model execution performance tracking compute cost, data quality, throughput, and operational efficiency"
  source: "`sports_entertainment_ecm`.`analytics`.`model_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of model run (success, failed, running, cancelled)"
    - name: "run_type"
      expr: run_type
      comment: "Type of run (training, scoring, validation, backfill)"
    - name: "model_type"
      expr: model_type
      comment: "Type of model executed (classification, regression, clustering, recommendation)"
    - name: "model_framework"
      expr: model_framework
      comment: "ML framework used (scikit-learn, XGBoost, TensorFlow, PyTorch, MLlib)"
    - name: "environment"
      expr: environment
      comment: "Execution environment (dev, staging, production)"
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered run (scheduled, manual, event-driven, API)"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the model run"
    - name: "contains_pii"
      expr: contains_pii
      comment: "Flag indicating run processed personally identifiable information"
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level (public, internal, confidential, restricted)"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month of model run for time-series analysis"
  measures:
    - name: "total_records_input"
      expr: SUM(CAST(records_input AS DOUBLE))
      comment: "Total records input to model runs"
    - name: "total_records_scored"
      expr: SUM(CAST(records_scored AS DOUBLE))
      comment: "Total records successfully scored by models"
    - name: "total_records_failed"
      expr: SUM(CAST(records_failed AS DOUBLE))
      comment: "Total records that failed processing"
    - name: "total_output_record_count"
      expr: SUM(CAST(output_record_count AS DOUBLE))
      comment: "Total output records produced by model runs"
    - name: "total_dbu_consumed"
      expr: SUM(CAST(dbu_consumed AS DOUBLE))
      comment: "Total Databricks Units consumed across all model runs"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated compute cost in USD across all model runs"
    - name: "avg_estimated_cost_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average compute cost per model run in USD"
    - name: "total_model_runs"
      expr: COUNT(1)
      comment: "Total number of model execution runs"
    - name: "total_successful_runs"
      expr: COUNT(CASE WHEN run_status = 'success' THEN 1 END)
      comment: "Total number of successful model runs"
    - name: "total_failed_runs"
      expr: COUNT(CASE WHEN run_status = 'failed' THEN 1 END)
      comment: "Total number of failed model runs"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`analytics_pipeline_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data pipeline execution performance tracking throughput, data quality, SLA compliance, and operational efficiency"
  source: "`sports_entertainment_ecm`.`analytics`.`pipeline_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of pipeline run (success, failed, running, cancelled, timeout)"
    - name: "pipeline_type"
      expr: pipeline_type
      comment: "Type of pipeline (ingestion, transformation, aggregation, export)"
    - name: "environment"
      expr: environment
      comment: "Execution environment (dev, staging, production)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Trigger mechanism (scheduled, manual, event-driven, streaming)"
    - name: "business_domain"
      expr: business_domain
      comment: "Business domain of pipeline (ticketing, merchandise, fan, broadcast)"
    - name: "source_system"
      expr: source_system
      comment: "Source system feeding the pipeline"
    - name: "dq_check_passed"
      expr: dq_check_passed
      comment: "Flag indicating all data quality checks passed"
    - name: "sla_breach"
      expr: sla_breach
      comment: "Flag indicating pipeline breached SLA threshold"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of pipeline run for time-series analysis"
  measures:
    - name: "total_records_processed"
      expr: SUM(CAST(records_processed AS DOUBLE))
      comment: "Total records processed across all pipeline runs"
    - name: "total_records_inserted"
      expr: SUM(CAST(records_inserted AS DOUBLE))
      comment: "Total records inserted into target tables"
    - name: "total_records_updated"
      expr: SUM(CAST(records_updated AS DOUBLE))
      comment: "Total records updated in target tables"
    - name: "total_records_rejected"
      expr: SUM(CAST(records_rejected AS DOUBLE))
      comment: "Total records rejected due to quality or validation failures"
    - name: "total_dbu_consumed"
      expr: SUM(CAST(dbu_consumed AS DOUBLE))
      comment: "Total Databricks Units consumed across all pipeline runs"
    - name: "total_compute_cost_usd"
      expr: SUM(CAST(compute_cost_usd AS DOUBLE))
      comment: "Total compute cost in USD across all pipeline runs"
    - name: "avg_compute_cost_usd"
      expr: AVG(CAST(compute_cost_usd AS DOUBLE))
      comment: "Average compute cost per pipeline run in USD"
    - name: "total_pipeline_runs"
      expr: COUNT(1)
      comment: "Total number of pipeline execution runs"
    - name: "total_successful_runs"
      expr: COUNT(CASE WHEN run_status = 'success' THEN 1 END)
      comment: "Total number of successful pipeline runs"
    - name: "total_failed_runs"
      expr: COUNT(CASE WHEN run_status = 'failed' THEN 1 END)
      comment: "Total number of failed pipeline runs"
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN sla_breach = TRUE THEN 1 END)
      comment: "Total number of pipeline runs that breached SLA"
    - name: "total_dq_failures"
      expr: COUNT(CASE WHEN dq_check_passed = FALSE THEN 1 END)
      comment: "Total number of pipeline runs with data quality check failures"
$$;