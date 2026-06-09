-- Metric views for domain: analytics | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_ab_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B experiment performance metrics tracking test effectiveness, statistical significance, and business impact for product optimization decisions"
  source: "`gaming_ecm`.`analytics`.`ab_experiment`"
  dimensions:
    - name: "experiment_name"
      expr: experiment_name
      comment: "Name of the A/B experiment"
    - name: "experiment_code"
      expr: experiment_code
      comment: "Unique code identifier for the experiment"
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the experiment (e.g., running, completed, cancelled)"
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment (e.g., feature test, pricing test, UI test)"
    - name: "business_objective"
      expr: business_objective
      comment: "Business goal the experiment aims to achieve"
    - name: "rollout_decision"
      expr: rollout_decision
      comment: "Decision on whether to roll out the winning variant"
    - name: "winning_variant"
      expr: winning_variant
      comment: "Identifier of the variant that won the experiment"
    - name: "is_statistically_significant"
      expr: is_statistically_significant
      comment: "Whether the experiment achieved statistical significance"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the experiment started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the experiment started"
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of A/B experiments"
    - name: "statistically_significant_experiments"
      expr: SUM(CASE WHEN is_statistically_significant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of experiments that achieved statistical significance"
    - name: "statistical_significance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_statistically_significant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of experiments achieving statistical significance - key quality indicator for experimentation program"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average confidence level across experiments"
    - name: "avg_statistical_power"
      expr: AVG(CAST(statistical_power AS DOUBLE))
      comment: "Average statistical power - measures ability to detect true effects"
    - name: "avg_effect_size"
      expr: AVG(CAST(effect_size AS DOUBLE))
      comment: "Average effect size observed across experiments"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across experiments"
    - name: "total_actual_sample_size"
      expr: SUM(CAST(actual_sample_size AS DOUBLE))
      comment: "Total sample size achieved across all experiments"
    - name: "avg_traffic_allocation"
      expr: AVG(CAST(traffic_allocation_pct AS DOUBLE))
      comment: "Average percentage of traffic allocated to experiments"
    - name: "sample_size_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(actual_sample_size AS DOUBLE) / NULLIF(CAST(required_sample_size AS DOUBLE), 0)), 2)
      comment: "Percentage of required sample size achieved - measures experiment execution quality"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_experiment_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experiment outcome metrics measuring treatment effects, statistical validity, and business impact for data-driven product decisions"
  source: "`gaming_ecm`.`analytics`.`experiment_result`"
  dimensions:
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of statistical analysis performed"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the metric being analyzed (e.g., engagement, revenue, retention)"
    - name: "analyst_decision"
      expr: analyst_decision
      comment: "Decision made by analyst based on results"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the experiment results"
    - name: "statistical_test_method"
      expr: statistical_test_method
      comment: "Statistical test method used (e.g., t-test, chi-square)"
    - name: "is_primary_metric"
      expr: is_primary_metric
      comment: "Whether this is the primary success metric for the experiment"
    - name: "srm_flag"
      expr: srm_flag
      comment: "Sample ratio mismatch flag indicating potential data quality issues"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_run_timestamp)
      comment: "Month when analysis was run"
  measures:
    - name: "total_experiment_results"
      expr: COUNT(1)
      comment: "Total number of experiment result analyses"
    - name: "avg_treatment_effect"
      expr: AVG(CAST(absolute_delta AS DOUBLE))
      comment: "Average absolute treatment effect across experiments"
    - name: "avg_relative_lift"
      expr: AVG(CAST(relative_lift_percentage AS DOUBLE))
      comment: "Average percentage lift of treatment over control - key business impact metric"
    - name: "avg_effect_size"
      expr: AVG(CAST(effect_size AS DOUBLE))
      comment: "Average standardized effect size"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across experiment results"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average confidence level of results"
    - name: "avg_statistical_power"
      expr: AVG(CAST(statistical_power AS DOUBLE))
      comment: "Average statistical power - ability to detect true effects"
    - name: "total_control_sample_size"
      expr: SUM(CAST(control_sample_size AS DOUBLE))
      comment: "Total sample size in control groups"
    - name: "total_treatment_sample_size"
      expr: SUM(CAST(treatment_sample_size AS DOUBLE))
      comment: "Total sample size in treatment groups"
    - name: "srm_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN srm_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results with sample ratio mismatch - data quality indicator"
    - name: "avg_control_mean"
      expr: AVG(CAST(control_arm_mean AS DOUBLE))
      comment: "Average metric value in control groups"
    - name: "avg_treatment_mean"
      expr: AVG(CAST(treatment_arm_mean AS DOUBLE))
      comment: "Average metric value in treatment groups"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_kpi_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI governance metrics tracking definition quality, usage, and alignment with business objectives for data-driven decision making"
  source: "`gaming_ecm`.`analytics`.`kpi_definition`"
  dimensions:
    - name: "kpi_name"
      expr: kpi_name
      comment: "Name of the KPI"
    - name: "kpi_code"
      expr: kpi_code
      comment: "Unique code identifier for the KPI"
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
      comment: "Direction of threshold evaluation (higher is better vs lower is better)"
    - name: "owning_analytics_team"
      expr: owning_analytics_team
      comment: "Team responsible for the KPI"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the KPI definition became effective"
  measures:
    - name: "total_kpi_definitions"
      expr: COUNT(1)
      comment: "Total number of KPI definitions"
    - name: "active_kpi_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active KPI definitions"
    - name: "kpi_activation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPIs that are active - measures KPI portfolio health"
    - name: "approved_kpi_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved KPI definitions"
    - name: "kpi_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPIs that are approved - governance quality indicator"
    - name: "alerted_kpi_count"
      expr: SUM(CASE WHEN alert_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of KPIs with alerting enabled"
    - name: "alert_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPIs with alerting enabled - proactive monitoring coverage"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across KPIs"
    - name: "avg_green_threshold"
      expr: AVG(CAST(green_threshold_value AS DOUBLE))
      comment: "Average green threshold value"
    - name: "avg_amber_threshold"
      expr: AVG(CAST(amber_threshold_value AS DOUBLE))
      comment: "Average amber threshold value"
    - name: "avg_red_threshold"
      expr: AVG(CAST(red_threshold_value AS DOUBLE))
      comment: "Average red threshold value"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI target performance metrics measuring goal achievement, planning accuracy, and business commitment tracking for strategic steering"
  source: "`gaming_ecm`.`analytics`.`kpi_target`"
  dimensions:
    - name: "target_status"
      expr: target_status
      comment: "Current status of the target (e.g., active, achieved, missed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the target"
    - name: "target_period_type"
      expr: target_period_type
      comment: "Type of target period (e.g., quarterly, annual, monthly)"
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle the target belongs to"
    - name: "target_owner_type"
      expr: target_owner_type
      comment: "Type of owner responsible for the target"
    - name: "is_public_commitment"
      expr: is_public_commitment
      comment: "Whether this is a public commitment (e.g., to investors, board)"
    - name: "target_confidence_level"
      expr: target_confidence_level
      comment: "Confidence level in achieving the target"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for the target"
    - name: "target_year"
      expr: YEAR(target_period_start_date)
      comment: "Year of the target period"
    - name: "target_month"
      expr: DATE_TRUNC('MONTH', target_period_start_date)
      comment: "Month of the target period start"
  measures:
    - name: "total_kpi_targets"
      expr: COUNT(1)
      comment: "Total number of KPI targets set"
    - name: "public_commitment_count"
      expr: SUM(CASE WHEN is_public_commitment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of targets that are public commitments"
    - name: "public_commitment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_public_commitment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of targets that are public commitments - accountability indicator"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all KPI targets"
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value before target period"
    - name: "avg_stretch_target"
      expr: AVG(CAST(stretch_target_value AS DOUBLE))
      comment: "Average stretch target value"
    - name: "avg_floor_value"
      expr: AVG(CAST(floor_value AS DOUBLE))
      comment: "Average floor value (minimum acceptable)"
    - name: "avg_target_ambition"
      expr: ROUND(AVG((CAST(target_value AS DOUBLE) - CAST(baseline_value AS DOUBLE)) / NULLIF(CAST(baseline_value AS DOUBLE), 0) * 100.0), 2)
      comment: "Average percentage increase from baseline to target - measures planning ambition"
    - name: "avg_stretch_ambition"
      expr: ROUND(AVG((CAST(stretch_target_value AS DOUBLE) - CAST(target_value AS DOUBLE)) / NULLIF(CAST(target_value AS DOUBLE), 0) * 100.0), 2)
      comment: "Average percentage increase from target to stretch - measures upside potential"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_player_behavior_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player segmentation performance metrics tracking segment quality, monetization potential, and retention characteristics for targeted engagement strategies"
  source: "`gaming_ecm`.`analytics`.`player_behavior_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the player behavior segment"
    - name: "segment_code"
      expr: segment_code
      comment: "Unique code identifier for the segment"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segmentation (e.g., behavioral, value-based, engagement-based)"
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment"
    - name: "use_case"
      expr: use_case
      comment: "Business use case for the segment"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience description"
    - name: "model_algorithm"
      expr: model_algorithm
      comment: "Algorithm used for segmentation"
    - name: "is_primary_segment"
      expr: is_primary_segment
      comment: "Whether this is a primary segment for business decisions"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the segment became effective"
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of player behavior segments"
    - name: "total_players_segmented"
      expr: SUM(CAST(player_count AS DOUBLE))
      comment: "Total number of players across all segments"
    - name: "avg_segment_size"
      expr: AVG(CAST(player_count AS DOUBLE))
      comment: "Average number of players per segment"
    - name: "avg_arpu"
      expr: AVG(CAST(avg_arpu AS DOUBLE))
      comment: "Average revenue per user across segments - key monetization metric"
    - name: "avg_ltv"
      expr: AVG(CAST(avg_ltv AS DOUBLE))
      comment: "Average lifetime value across segments - strategic value indicator"
    - name: "avg_session_length"
      expr: AVG(CAST(avg_session_length_minutes AS DOUBLE))
      comment: "Average session length in minutes across segments"
    - name: "avg_d7_retention"
      expr: AVG(CAST(d7_retention_rate AS DOUBLE))
      comment: "Average day-7 retention rate across segments - early engagement indicator"
    - name: "avg_d30_retention"
      expr: AVG(CAST(d30_retention_rate AS DOUBLE))
      comment: "Average day-30 retention rate across segments - long-term engagement indicator"
    - name: "avg_churn_risk"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segments"
    - name: "avg_model_accuracy"
      expr: AVG(CAST(model_accuracy_score AS DOUBLE))
      comment: "Average model accuracy score - segmentation quality indicator"
    - name: "weighted_avg_arpu"
      expr: SUM(CAST(avg_arpu AS DOUBLE) * CAST(player_count AS DOUBLE)) / NULLIF(SUM(CAST(player_count AS DOUBLE)), 0)
      comment: "Player-weighted average ARPU - true portfolio monetization metric"
    - name: "weighted_avg_ltv"
      expr: SUM(CAST(avg_ltv AS DOUBLE) * CAST(player_count AS DOUBLE)) / NULLIF(SUM(CAST(player_count AS DOUBLE)), 0)
      comment: "Player-weighted average LTV - true portfolio value metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_telemetry_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telemetry event quality and volume metrics tracking data pipeline health, player engagement patterns, and platform performance for operational monitoring"
  source: "`gaming_ecm`.`analytics`.`telemetry_event`"
  dimensions:
    - name: "event_processing_status"
      expr: event_processing_status
      comment: "Processing status of the telemetry event"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform where the event originated"
    - name: "device_type"
      expr: device_type
      comment: "Type of device that generated the event"
    - name: "network_type"
      expr: network_type
      comment: "Network type during event (e.g., wifi, cellular)"
    - name: "server_region"
      expr: server_region
      comment: "Server region that processed the event"
    - name: "is_first_session"
      expr: is_first_session
      comment: "Whether this event is from a first-time session"
    - name: "is_paying_user"
      expr: is_paying_user
      comment: "Whether the user is a paying customer"
    - name: "is_synthetic"
      expr: is_synthetic
      comment: "Whether this is a synthetic test event"
    - name: "event_date"
      expr: DATE_TRUNC('DAY', event_timestamp)
      comment: "Date of the event"
    - name: "event_hour"
      expr: DATE_TRUNC('HOUR', event_timestamp)
      comment: "Hour of the event"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of telemetry events"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct count of players generating events"
    - name: "unique_sessions"
      expr: COUNT(DISTINCT session_id)
      comment: "Distinct count of sessions"
    - name: "unique_devices"
      expr: COUNT(DISTINCT device_id)
      comment: "Distinct count of devices"
    - name: "first_session_events"
      expr: SUM(CASE WHEN is_first_session = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events from first-time sessions"
    - name: "paying_user_events"
      expr: SUM(CASE WHEN is_paying_user = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events from paying users"
    - name: "synthetic_event_count"
      expr: SUM(CASE WHEN is_synthetic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of synthetic test events"
    - name: "synthetic_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_synthetic = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that are synthetic - data quality indicator"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across events - pipeline health indicator"
    - name: "avg_ingestion_latency_seconds"
      expr: AVG(CAST(UNIX_TIMESTAMP(server_ingestion_timestamp) - UNIX_TIMESTAMP(event_timestamp) AS DOUBLE))
      comment: "Average latency between event generation and server ingestion - real-time capability metric"
    - name: "avg_pipeline_latency_seconds"
      expr: AVG(CAST(UNIX_TIMESTAMP(pipeline_ingestion_timestamp) - UNIX_TIMESTAMP(event_timestamp) AS DOUBLE))
      comment: "Average end-to-end pipeline latency - data freshness indicator"
    - name: "events_per_session"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT session_id), 0)
      comment: "Average number of events per session - engagement intensity metric"
    - name: "events_per_player"
      expr: COUNT(1) / NULLIF(COUNT(DISTINCT player_account_id), 0)
      comment: "Average number of events per player"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_telemetry_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telemetry pipeline operational metrics tracking reliability, performance, compliance, and cost efficiency for data infrastructure governance"
  source: "`gaming_ecm`.`analytics`.`telemetry_pipeline`"
  dimensions:
    - name: "pipeline_name"
      expr: pipeline_name
      comment: "Name of the telemetry pipeline"
    - name: "pipeline_code"
      expr: pipeline_code
      comment: "Unique code identifier for the pipeline"
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Current operational status of the pipeline"
    - name: "pipeline_type"
      expr: pipeline_type
      comment: "Type of pipeline (e.g., real-time, batch, hybrid)"
    - name: "deployment_environment"
      expr: deployment_environment
      comment: "Environment where pipeline is deployed (e.g., production, staging)"
    - name: "criticality_level"
      expr: criticality_level
      comment: "Business criticality level of the pipeline"
    - name: "data_volume_tier"
      expr: data_volume_tier
      comment: "Volume tier classification of the pipeline"
    - name: "ingestion_mode"
      expr: ingestion_mode
      comment: "Mode of data ingestion (e.g., streaming, batch)"
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Whether pipeline is GDPR compliant"
    - name: "coppa_compliant_flag"
      expr: coppa_compliant_flag
      comment: "Whether pipeline is COPPA compliant"
    - name: "pii_data_flag"
      expr: pii_data_flag
      comment: "Whether pipeline processes PII data"
    - name: "encryption_enabled_flag"
      expr: encryption_enabled_flag
      comment: "Whether encryption is enabled"
  measures:
    - name: "total_pipelines"
      expr: COUNT(1)
      comment: "Total number of telemetry pipelines"
    - name: "active_pipelines"
      expr: SUM(CASE WHEN pipeline_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active pipelines"
    - name: "pipeline_availability_rate"
      expr: AVG(CAST(uptime_percentage_last_30d AS DOUBLE))
      comment: "Average uptime percentage - operational reliability metric"
    - name: "avg_latency_seconds"
      expr: AVG(CAST(average_latency_seconds AS DOUBLE))
      comment: "Average pipeline latency in seconds - performance indicator"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score - data integrity metric"
    - name: "total_daily_event_volume"
      expr: SUM(CAST(events_per_day_estimate AS DOUBLE))
      comment: "Total estimated events per day across all pipelines - capacity planning metric"
    - name: "gdpr_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipelines that are GDPR compliant - regulatory compliance indicator"
    - name: "coppa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN coppa_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipelines that are COPPA compliant - child safety compliance indicator"
    - name: "encryption_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN encryption_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipelines with encryption enabled - security posture metric"
    - name: "pii_pipeline_count"
      expr: SUM(CASE WHEN pii_data_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pipelines processing PII data"
    - name: "pii_pipeline_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pii_data_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipelines processing PII - privacy risk indicator"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_ml_model_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ML model lifecycle metrics tracking model performance, deployment status, and business impact for AI/ML governance and ROI measurement"
  source: "`gaming_ecm`.`analytics`.`ml_model_registry`"
  dimensions:
    - name: "model_name"
      expr: model_name
      comment: "Name of the ML model"
    - name: "model_type"
      expr: model_type
      comment: "Type of ML model (e.g., classification, regression, recommendation)"
    - name: "model_status"
      expr: model_status
      comment: "Current status of the model"
    - name: "use_case"
      expr: use_case
      comment: "Business use case for the model"
    - name: "framework"
      expr: framework
      comment: "ML framework used (e.g., TensorFlow, PyTorch, scikit-learn)"
    - name: "deployment_environment"
      expr: deployment_environment
      comment: "Environment where model is deployed"
    - name: "is_champion_model"
      expr: is_champion_model
      comment: "Whether this is the champion model in production"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the model"
    - name: "retraining_frequency"
      expr: retraining_frequency
      comment: "Frequency of model retraining"
    - name: "deployment_year"
      expr: YEAR(deployment_timestamp)
      comment: "Year the model was deployed"
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of ML models in registry"
    - name: "champion_model_count"
      expr: SUM(CASE WHEN is_champion_model = TRUE THEN 1 ELSE 0 END)
      comment: "Count of champion models in production"
    - name: "avg_evaluation_metric"
      expr: AVG(CAST(evaluation_metric_value AS DOUBLE))
      comment: "Average evaluation metric value across models - model quality indicator"
    - name: "avg_model_size_mb"
      expr: AVG(CAST(model_size_mb AS DOUBLE))
      comment: "Average model size in megabytes"
    - name: "avg_prediction_latency_ms"
      expr: AVG(CAST(prediction_latency_ms AS DOUBLE))
      comment: "Average prediction latency in milliseconds - inference performance metric"
    - name: "avg_training_duration_minutes"
      expr: AVG(CAST(training_duration_minutes AS DOUBLE))
      comment: "Average training duration in minutes - training efficiency metric"
    - name: "total_training_samples"
      expr: SUM(CAST(training_sample_count AS DOUBLE))
      comment: "Total training samples across all models"
    - name: "total_test_samples"
      expr: SUM(CAST(test_sample_count AS DOUBLE))
      comment: "Total test samples across all models"
    - name: "avg_training_samples"
      expr: AVG(CAST(training_sample_count AS DOUBLE))
      comment: "Average training sample count per model"
    - name: "avg_test_samples"
      expr: AVG(CAST(test_sample_count AS DOUBLE))
      comment: "Average test sample count per model"
    - name: "avg_validation_samples"
      expr: AVG(CAST(validation_sample_count AS DOUBLE))
      comment: "Average validation sample count per model"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`analytics_funnel_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion funnel performance metrics tracking funnel effectiveness, benchmark achievement, and optimization opportunities for user journey improvement"
  source: "`gaming_ecm`.`analytics`.`funnel_definition`"
  dimensions:
    - name: "funnel_name"
      expr: funnel_name
      comment: "Name of the conversion funnel"
    - name: "funnel_code"
      expr: funnel_code
      comment: "Unique code identifier for the funnel"
    - name: "funnel_type"
      expr: funnel_type
      comment: "Type of funnel (e.g., acquisition, monetization, engagement)"
    - name: "funnel_status"
      expr: funnel_status
      comment: "Current status of the funnel"
    - name: "business_objective"
      expr: business_objective
      comment: "Business objective the funnel supports"
    - name: "is_ab_test_funnel"
      expr: is_ab_test_funnel
      comment: "Whether this funnel is used for A/B testing"
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this is the current version of the funnel"
    - name: "owning_team"
      expr: owning_team
      comment: "Team responsible for the funnel"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the funnel became effective"
  measures:
    - name: "total_funnels"
      expr: COUNT(1)
      comment: "Total number of funnel definitions"
    - name: "active_funnel_count"
      expr: SUM(CASE WHEN funnel_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active funnels"
    - name: "ab_test_funnel_count"
      expr: SUM(CASE WHEN is_ab_test_funnel = TRUE THEN 1 ELSE 0 END)
      comment: "Count of funnels used for A/B testing"
    - name: "avg_benchmark_conversion_rate"
      expr: AVG(CAST(benchmark_conversion_rate AS DOUBLE))
      comment: "Average benchmark conversion rate across funnels"
    - name: "avg_target_conversion_rate"
      expr: AVG(CAST(target_conversion_rate AS DOUBLE))
      comment: "Average target conversion rate - goal-setting metric"
    - name: "avg_conversion_rate_gap"
      expr: AVG(CAST(target_conversion_rate AS DOUBLE) - CAST(benchmark_conversion_rate AS DOUBLE))
      comment: "Average gap between target and benchmark conversion rates - improvement opportunity metric"
    - name: "conversion_rate_improvement_potential"
      expr: ROUND(AVG((CAST(target_conversion_rate AS DOUBLE) - CAST(benchmark_conversion_rate AS DOUBLE)) / NULLIF(CAST(benchmark_conversion_rate AS DOUBLE), 0) * 100.0), 2)
      comment: "Average percentage improvement potential from benchmark to target - optimization priority indicator"
$$;