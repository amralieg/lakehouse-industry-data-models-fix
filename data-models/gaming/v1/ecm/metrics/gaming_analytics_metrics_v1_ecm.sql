-- Metric views for domain: analytics | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_ab_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B experiment performance metrics tracking test effectiveness, statistical significance, and business impact across gaming experiments"
  source: "`gaming_ecm`.`analytics`.`ab_experiment`"
  dimensions:
    - name: "experiment_name"
      expr: experiment_name
      comment: "Name of the A/B experiment"
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the experiment (e.g., running, completed, cancelled)"
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment being conducted"
    - name: "business_objective"
      expr: business_objective
      comment: "Business goal the experiment is designed to achieve"
    - name: "rollout_decision"
      expr: rollout_decision
      comment: "Decision on whether to roll out the winning variant"
    - name: "is_statistically_significant"
      expr: is_statistically_significant
      comment: "Whether the experiment achieved statistical significance"
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the experiment started"
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of A/B experiments"
    - name: "statistically_significant_experiments"
      expr: COUNT(CASE WHEN is_statistically_significant = TRUE THEN 1 END)
      comment: "Count of experiments that achieved statistical significance"
    - name: "statistical_significance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_statistically_significant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of experiments achieving statistical significance"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level across experiments"
    - name: "avg_effect_size"
      expr: AVG(CAST(effect_size AS DOUBLE))
      comment: "Average effect size measured across experiments"
    - name: "avg_statistical_power"
      expr: AVG(CAST(statistical_power AS DOUBLE))
      comment: "Average statistical power of experiments"
    - name: "total_actual_sample_size"
      expr: SUM(CAST(actual_sample_size AS BIGINT))
      comment: "Total sample size across all experiments"
    - name: "avg_traffic_allocation"
      expr: AVG(CAST(traffic_allocation_pct AS DOUBLE))
      comment: "Average percentage of traffic allocated to experiments"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_experiment_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed experiment outcome metrics measuring treatment effects, statistical validity, and decision quality for gaming experiments"
  source: "`gaming_ecm`.`analytics`.`experiment_result`"
  dimensions:
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the metric being measured (e.g., engagement, monetization, retention)"
    - name: "is_primary_metric"
      expr: is_primary_metric
      comment: "Whether this is the primary success metric for the experiment"
    - name: "analyst_decision"
      expr: analyst_decision
      comment: "Decision made by the analyst based on results"
    - name: "statistical_test_method"
      expr: statistical_test_method
      comment: "Statistical test method used for analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the experiment results"
    - name: "srm_flag"
      expr: srm_flag
      comment: "Sample ratio mismatch flag indicating potential data quality issues"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_window_start_date)
      comment: "Month when the analysis was conducted"
  measures:
    - name: "total_experiment_results"
      expr: COUNT(1)
      comment: "Total number of experiment result records"
    - name: "avg_relative_lift"
      expr: AVG(CAST(relative_lift_percentage AS DOUBLE))
      comment: "Average percentage lift of treatment over control"
    - name: "avg_absolute_delta"
      expr: AVG(CAST(absolute_delta AS DOUBLE))
      comment: "Average absolute difference between treatment and control"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across experiment results"
    - name: "avg_effect_size"
      expr: AVG(CAST(effect_size AS DOUBLE))
      comment: "Average effect size measured in experiment results"
    - name: "avg_statistical_power"
      expr: AVG(CAST(statistical_power AS DOUBLE))
      comment: "Average statistical power of the experiments"
    - name: "total_control_sample_size"
      expr: SUM(CAST(control_sample_size AS BIGINT))
      comment: "Total sample size in control groups"
    - name: "total_treatment_sample_size"
      expr: SUM(CAST(treatment_sample_size AS BIGINT))
      comment: "Total sample size in treatment groups"
    - name: "srm_violation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN srm_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results with sample ratio mismatch violations"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_funnel_instance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player funnel conversion metrics tracking progression, abandonment, and conversion performance across gaming user journeys"
  source: "`gaming_ecm`.`analytics`.`funnel_instance`"
  dimensions:
    - name: "funnel_status"
      expr: funnel_status
      comment: "Current status of the funnel instance (e.g., in-progress, completed, abandoned)"
    - name: "funnel_type"
      expr: funnel_type
      comment: "Type of funnel (e.g., onboarding, purchase, engagement)"
    - name: "is_completed"
      expr: is_completed
      comment: "Whether the player completed the entire funnel"
    - name: "is_converted"
      expr: is_converted
      comment: "Whether the funnel resulted in a conversion"
    - name: "is_abandoned"
      expr: is_abandoned
      comment: "Whether the player abandoned the funnel"
    - name: "player_segment"
      expr: player_segment
      comment: "Player segment at time of funnel entry"
    - name: "device_type"
      expr: device_type
      comment: "Device type used during the funnel"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the player"
    - name: "entry_source"
      expr: entry_source
      comment: "Source from which the player entered the funnel"
    - name: "funnel_start_month"
      expr: DATE_TRUNC('MONTH', funnel_start_timestamp)
      comment: "Month when the funnel was started"
  measures:
    - name: "total_funnel_instances"
      expr: COUNT(1)
      comment: "Total number of funnel instances started"
    - name: "completed_funnels"
      expr: COUNT(CASE WHEN is_completed = TRUE THEN 1 END)
      comment: "Number of funnels completed"
    - name: "converted_funnels"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN 1 END)
      comment: "Number of funnels that resulted in conversion"
    - name: "abandoned_funnels"
      expr: COUNT(CASE WHEN is_abandoned = TRUE THEN 1 END)
      comment: "Number of funnels abandoned by players"
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of funnels completed"
    - name: "conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_converted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of funnels that converted"
    - name: "abandonment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_abandoned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of funnels abandoned"
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average completion rate percentage across funnel instances"
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value_usd AS DOUBLE))
      comment: "Total conversion value in USD across all funnels"
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value_usd AS DOUBLE))
      comment: "Average conversion value per funnel instance"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_kpi_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI governance metrics tracking definition quality, approval status, and lifecycle management of gaming business metrics"
  source: "`gaming_ecm`.`analytics`.`kpi_definition`"
  dimensions:
    - name: "kpi_name"
      expr: kpi_name
      comment: "Name of the KPI"
    - name: "kpi_category"
      expr: kpi_category
      comment: "Category of the KPI (e.g., engagement, monetization, retention)"
    - name: "scope_type"
      expr: scope_type
      comment: "Scope of the KPI (e.g., game-level, platform-level, company-level)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the KPI definition"
    - name: "is_active"
      expr: is_active
      comment: "Whether the KPI is currently active"
    - name: "alert_enabled"
      expr: alert_enabled
      comment: "Whether alerting is enabled for this KPI"
    - name: "threshold_direction"
      expr: threshold_direction
      comment: "Direction of threshold evaluation (e.g., higher is better, lower is better)"
    - name: "owning_analytics_team"
      expr: owning_analytics_team
      comment: "Analytics team responsible for the KPI"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the KPI became effective"
  measures:
    - name: "total_kpi_definitions"
      expr: COUNT(1)
      comment: "Total number of KPI definitions"
    - name: "active_kpis"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active KPI definitions"
    - name: "approved_kpis"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of approved KPI definitions"
    - name: "kpis_with_alerts"
      expr: COUNT(CASE WHEN alert_enabled = TRUE THEN 1 END)
      comment: "Number of KPIs with alerting enabled"
    - name: "kpi_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPIs that are approved"
    - name: "kpi_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPIs that are active"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across KPIs"
    - name: "avg_green_threshold"
      expr: AVG(CAST(green_threshold_value AS DOUBLE))
      comment: "Average green threshold value across KPIs"
    - name: "avg_red_threshold"
      expr: AVG(CAST(red_threshold_value AS DOUBLE))
      comment: "Average red threshold value across KPIs"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_ml_model_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Machine learning model performance and governance metrics tracking model quality, deployment status, and business impact"
  source: "`gaming_ecm`.`analytics`.`ml_model_registry`"
  dimensions:
    - name: "model_name"
      expr: model_name
      comment: "Name of the machine learning model"
    - name: "model_type"
      expr: model_type
      comment: "Type of machine learning model"
    - name: "model_status"
      expr: model_status
      comment: "Current status of the model (e.g., development, production, retired)"
    - name: "use_case"
      expr: use_case
      comment: "Business use case the model addresses"
    - name: "framework"
      expr: framework
      comment: "Machine learning framework used (e.g., TensorFlow, PyTorch, scikit-learn)"
    - name: "is_champion_model"
      expr: is_champion_model
      comment: "Whether this is the champion model in production"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the model"
    - name: "deployment_environment"
      expr: deployment_environment
      comment: "Environment where the model is deployed"
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_start_timestamp)
      comment: "Month when model training started"
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of registered ML models"
    - name: "champion_models"
      expr: COUNT(CASE WHEN is_champion_model = TRUE THEN 1 END)
      comment: "Number of champion models in production"
    - name: "avg_evaluation_metric_value"
      expr: AVG(CAST(evaluation_metric_value AS DOUBLE))
      comment: "Average evaluation metric value across models"
    - name: "avg_model_size_mb"
      expr: AVG(CAST(model_size_mb AS DOUBLE))
      comment: "Average model size in megabytes"
    - name: "avg_prediction_latency_ms"
      expr: AVG(CAST(prediction_latency_ms AS DOUBLE))
      comment: "Average prediction latency in milliseconds"
    - name: "avg_training_duration_minutes"
      expr: AVG(CAST(training_duration_minutes AS DOUBLE))
      comment: "Average training duration in minutes"
    - name: "total_training_sample_count"
      expr: SUM(CAST(training_sample_count AS BIGINT))
      comment: "Total number of training samples across all models"
    - name: "total_test_sample_count"
      expr: SUM(CAST(test_sample_count AS BIGINT))
      comment: "Total number of test samples across all models"
    - name: "model_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of models that are approved"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_player_prediction_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player prediction accuracy and action metrics measuring model performance, prediction quality, and business outcome realization"
  source: "`gaming_ecm`.`analytics`.`player_prediction_record`"
  dimensions:
    - name: "prediction_type"
      expr: prediction_type
      comment: "Type of prediction made (e.g., churn, LTV, next purchase)"
    - name: "prediction_label"
      expr: prediction_label
      comment: "Label assigned by the prediction"
    - name: "prediction_status"
      expr: prediction_status
      comment: "Status of the prediction (e.g., pending, validated, expired)"
    - name: "action_triggered_flag"
      expr: action_triggered_flag
      comment: "Whether an action was triggered based on the prediction"
    - name: "action_type"
      expr: action_type
      comment: "Type of action taken based on the prediction"
    - name: "actual_outcome_flag"
      expr: actual_outcome_flag
      comment: "Whether the predicted outcome actually occurred"
    - name: "model_drift_flag"
      expr: model_drift_flag
      comment: "Whether model drift was detected for this prediction"
    - name: "player_segment"
      expr: player_segment
      comment: "Player segment at time of prediction"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform where the prediction was made"
    - name: "prediction_month"
      expr: DATE_TRUNC('MONTH', prediction_timestamp)
      comment: "Month when the prediction was made"
  measures:
    - name: "total_predictions"
      expr: COUNT(1)
      comment: "Total number of player predictions made"
    - name: "predictions_with_actions"
      expr: COUNT(CASE WHEN action_triggered_flag = TRUE THEN 1 END)
      comment: "Number of predictions that triggered actions"
    - name: "predictions_with_outcomes"
      expr: COUNT(CASE WHEN actual_outcome_flag = TRUE THEN 1 END)
      comment: "Number of predictions where the outcome occurred"
    - name: "predictions_with_drift"
      expr: COUNT(CASE WHEN model_drift_flag = TRUE THEN 1 END)
      comment: "Number of predictions with detected model drift"
    - name: "action_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of predictions that triggered actions"
    - name: "prediction_accuracy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_outcome_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of predictions where the outcome occurred"
    - name: "model_drift_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN model_drift_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of predictions with model drift detected"
    - name: "avg_prediction_confidence"
      expr: AVG(CAST(prediction_confidence AS DOUBLE))
      comment: "Average confidence score of predictions"
    - name: "avg_prediction_value"
      expr: AVG(CAST(prediction_value AS DOUBLE))
      comment: "Average predicted value across predictions"
    - name: "avg_actual_outcome_value"
      expr: AVG(CAST(actual_outcome_value AS DOUBLE))
      comment: "Average actual outcome value when realized"
    - name: "avg_prediction_error"
      expr: AVG(CAST(prediction_error AS DOUBLE))
      comment: "Average prediction error across predictions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_retention_cohort_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player retention cohort metrics tracking retention rates, engagement, and monetization performance across player cohorts"
  source: "`gaming_ecm`.`analytics`.`retention_cohort_analysis`"
  dimensions:
    - name: "cohort_name"
      expr: cohort_name
      comment: "Name of the retention cohort"
    - name: "cohort_type"
      expr: cohort_type
      comment: "Type of cohort (e.g., install date, first purchase, feature adoption)"
    - name: "cohort_status"
      expr: cohort_status
      comment: "Status of the cohort analysis"
    - name: "cohort_entry_event_type"
      expr: cohort_entry_event_type
      comment: "Event type that defines cohort entry"
    - name: "business_objective"
      expr: business_objective
      comment: "Business objective for tracking this cohort"
    - name: "platform_filter"
      expr: platform_filter
      comment: "Platform filter applied to the cohort"
    - name: "geographic_filter"
      expr: geographic_filter
      comment: "Geographic filter applied to the cohort"
    - name: "cohort_entry_month"
      expr: DATE_TRUNC('MONTH', cohort_entry_start_date)
      comment: "Month when the cohort entry period started"
  measures:
    - name: "total_cohorts"
      expr: COUNT(1)
      comment: "Total number of retention cohorts analyzed"
    - name: "total_cohort_players"
      expr: SUM(CAST(player_count_at_entry AS BIGINT))
      comment: "Total number of players across all cohorts at entry"
    - name: "avg_d1_retention_rate"
      expr: AVG(CAST(d1_retention_rate_pct AS DOUBLE))
      comment: "Average day-1 retention rate across cohorts"
    - name: "avg_d7_retention_rate"
      expr: AVG(CAST(d7_retention_rate_pct AS DOUBLE))
      comment: "Average day-7 retention rate across cohorts"
    - name: "avg_d30_retention_rate"
      expr: AVG(CAST(d30_retention_rate_pct AS DOUBLE))
      comment: "Average day-30 retention rate across cohorts"
    - name: "avg_d90_retention_rate"
      expr: AVG(CAST(d90_retention_rate_pct AS DOUBLE))
      comment: "Average day-90 retention rate across cohorts"
    - name: "avg_cohort_arpu"
      expr: AVG(CAST(cohort_arpu AS DOUBLE))
      comment: "Average revenue per user across cohorts"
    - name: "avg_cohort_arppu"
      expr: AVG(CAST(cohort_arppu AS DOUBLE))
      comment: "Average revenue per paying user across cohorts"
    - name: "avg_cohort_ltv"
      expr: AVG(CAST(cohort_ltv_estimate AS DOUBLE))
      comment: "Average estimated lifetime value across cohorts"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_pct AS DOUBLE))
      comment: "Average conversion rate across cohorts"
    - name: "avg_session_length_minutes"
      expr: AVG(CAST(average_session_length_minutes AS DOUBLE))
      comment: "Average session length in minutes across cohorts"
    - name: "avg_sessions_per_player"
      expr: AVG(CAST(average_sessions_per_player AS DOUBLE))
      comment: "Average number of sessions per player across cohorts"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_telemetry_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telemetry event volume and quality metrics tracking data ingestion, processing performance, and data quality across gaming platforms"
  source: "`gaming_ecm`.`analytics`.`telemetry_event`"
  dimensions:
    - name: "event_processing_status"
      expr: event_processing_status
      comment: "Processing status of the telemetry event"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform code where the event originated"
    - name: "device_type"
      expr: device_type
      comment: "Type of device that generated the event"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "network_type"
      expr: network_type
      comment: "Network type used when event was generated"
    - name: "is_synthetic"
      expr: is_synthetic
      comment: "Whether this is a synthetic test event"
    - name: "is_first_session"
      expr: is_first_session
      comment: "Whether this event occurred in the player's first session"
    - name: "is_paying_user"
      expr: is_paying_user
      comment: "Whether the player is a paying user"
    - name: "event_schema_version"
      expr: event_schema_version
      comment: "Version of the event schema"
    - name: "event_date"
      expr: DATE_TRUNC('DAY', event_timestamp)
      comment: "Date when the event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the event occurred"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of telemetry events"
    - name: "synthetic_events"
      expr: COUNT(CASE WHEN is_synthetic = TRUE THEN 1 END)
      comment: "Number of synthetic test events"
    - name: "first_session_events"
      expr: COUNT(CASE WHEN is_first_session = TRUE THEN 1 END)
      comment: "Number of events from first-time sessions"
    - name: "paying_user_events"
      expr: COUNT(CASE WHEN is_paying_user = TRUE THEN 1 END)
      comment: "Number of events from paying users"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across events"
    - name: "distinct_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of distinct players generating events"
    - name: "distinct_sessions"
      expr: COUNT(DISTINCT session_id)
      comment: "Number of distinct sessions generating events"
    - name: "distinct_devices"
      expr: COUNT(DISTINCT device_id)
      comment: "Number of distinct devices generating events"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_telemetry_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telemetry pipeline operational metrics tracking ingestion performance, reliability, compliance, and data quality SLAs"
  source: "`gaming_ecm`.`analytics`.`telemetry_pipeline`"
  dimensions:
    - name: "pipeline_name"
      expr: pipeline_name
      comment: "Name of the telemetry pipeline"
    - name: "pipeline_type"
      expr: pipeline_type
      comment: "Type of telemetry pipeline"
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Current operational status of the pipeline"
    - name: "deployment_environment"
      expr: deployment_environment
      comment: "Environment where the pipeline is deployed"
    - name: "ingestion_mode"
      expr: ingestion_mode
      comment: "Mode of data ingestion (e.g., batch, streaming)"
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Whether the pipeline is GDPR compliant"
    - name: "coppa_compliant_flag"
      expr: coppa_compliant_flag
      comment: "Whether the pipeline is COPPA compliant"
    - name: "encryption_enabled_flag"
      expr: encryption_enabled_flag
      comment: "Whether encryption is enabled for the pipeline"
    - name: "pii_data_flag"
      expr: pii_data_flag
      comment: "Whether the pipeline processes PII data"
    - name: "criticality_level"
      expr: criticality_level
      comment: "Criticality level of the pipeline"
    - name: "data_engineering_team"
      expr: data_engineering_team
      comment: "Team responsible for the pipeline"
  measures:
    - name: "total_pipelines"
      expr: COUNT(1)
      comment: "Total number of telemetry pipelines"
    - name: "gdpr_compliant_pipelines"
      expr: COUNT(CASE WHEN gdpr_compliant_flag = TRUE THEN 1 END)
      comment: "Number of GDPR compliant pipelines"
    - name: "coppa_compliant_pipelines"
      expr: COUNT(CASE WHEN coppa_compliant_flag = TRUE THEN 1 END)
      comment: "Number of COPPA compliant pipelines"
    - name: "encrypted_pipelines"
      expr: COUNT(CASE WHEN encryption_enabled_flag = TRUE THEN 1 END)
      comment: "Number of pipelines with encryption enabled"
    - name: "pii_processing_pipelines"
      expr: COUNT(CASE WHEN pii_data_flag = TRUE THEN 1 END)
      comment: "Number of pipelines processing PII data"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across pipelines"
    - name: "avg_latency_seconds"
      expr: AVG(CAST(average_latency_seconds AS DOUBLE))
      comment: "Average latency in seconds across pipelines"
    - name: "avg_uptime_percentage"
      expr: AVG(CAST(uptime_percentage_last_30d AS DOUBLE))
      comment: "Average uptime percentage over the last 30 days"
    - name: "total_events_per_day"
      expr: SUM(CAST(events_per_day_estimate AS BIGINT))
      comment: "Total estimated events per day across all pipelines"
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_compliant_flag = TRUE AND coppa_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipelines compliant with both GDPR and COPPA"
$$;