-- Metric views for domain: metadata | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`metadata_industry_outcome_plugin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for monitoring the healthcare industry outcome plugin ecosystem - tracking AI/ML model plugin readiness, regulatory compliance, performance quality, and operational deployment status across the clinical AI governance framework."
  source: "`healthcare_ecm_v1`.`metadata`.`industry_outcome_plugin`"
  dimensions:
    - name: "plugin_type"
      expr: plugin_type
      comment: "Type of industry outcome plugin (e.g., readmission_forecast, sepsis_score, care_gap) for categorizing AI/ML capabilities"
    - name: "clinical_domain"
      expr: clinical_domain
      comment: "Clinical domain the plugin targets (e.g., cardiology, oncology, behavioral_health) for domain-level portfolio analysis"
    - name: "plugin_status"
      expr: industry_outcome_plugin_status
      comment: "Current lifecycle status of the plugin (active, retired, validation, pilot) for deployment readiness tracking"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor or internal team that developed the plugin for vendor management and concentration risk analysis"
    - name: "model_algorithm"
      expr: model_algorithm
      comment: "ML algorithm type (XGBoost, LSTM, logistic regression, etc.) for technical portfolio diversity assessment"
    - name: "execution_frequency"
      expr: execution_frequency
      comment: "How often the plugin runs (real-time, hourly, daily, batch) for infrastructure capacity planning"
    - name: "hipaa_compliant_flag"
      expr: CAST(hipaa_compliant_flag AS STRING)
      comment: "Whether the plugin has been certified HIPAA compliant for regulatory governance reporting"
    - name: "regulatory_clearance_flag"
      expr: CAST(regulatory_clearance_flag AS STRING)
      comment: "Whether the plugin has FDA SaMD clearance or other regulatory approval"
    - name: "requires_real_time_data_flag"
      expr: CAST(requires_real_time_data_flag AS STRING)
      comment: "Whether the plugin requires real-time streaming data, impacting infrastructure requirements"
    - name: "attachment_point"
      expr: attachment_point
      comment: "Base model table the plugin attaches to (e.g., patient, encounter, visit) for integration architecture planning"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the plugin became effective for temporal deployment trend analysis"
    - name: "validation_year_month"
      expr: DATE_TRUNC('MONTH', validation_date)
      comment: "Month of last validation for monitoring revalidation cadence"
  measures:
    - name: "total_plugins"
      expr: COUNT(1)
      comment: "Total number of industry outcome plugins registered in the platform - baseline for portfolio size tracking"
    - name: "active_plugins"
      expr: COUNT(CASE WHEN industry_outcome_plugin_status = 'active' THEN 1 END)
      comment: "Number of plugins currently in active production use - key indicator of AI/ML operational maturity"
    - name: "avg_auroc_score"
      expr: AVG(CAST(auroc_score AS DOUBLE))
      comment: "Average AUROC (Area Under ROC Curve) across plugins - aggregate model quality indicator for clinical AI governance"
    - name: "avg_sensitivity"
      expr: AVG(CAST(sensitivity AS DOUBLE))
      comment: "Average sensitivity (true positive rate) across plugins - critical for clinical safety where missing positive cases has patient harm implications"
    - name: "avg_positive_predictive_value"
      expr: AVG(CAST(positive_predictive_value AS DOUBLE))
      comment: "Average PPV across plugins - measures alert fatigue risk; low PPV means excessive false alarms degrading clinician trust"
    - name: "total_training_cohort_size"
      expr: SUM(CAST(training_cohort_size AS DOUBLE))
      comment: "Total training cohort size across all plugins - indicator of data asset utilization and model robustness"
    - name: "avg_training_cohort_size"
      expr: AVG(CAST(training_cohort_size AS DOUBLE))
      comment: "Average training cohort size per plugin - identifies potentially underpowered models requiring larger datasets"
    - name: "fda_cleared_plugins"
      expr: COUNT(CASE WHEN regulatory_clearance_flag = TRUE THEN 1 END)
      comment: "Number of plugins with FDA SaMD clearance - regulatory compliance posture for clinical AI deployment"
    - name: "hipaa_compliant_plugins"
      expr: COUNT(CASE WHEN hipaa_compliant_flag = TRUE THEN 1 END)
      comment: "Number of HIPAA-compliant plugins - governance readiness indicator for PHI-touching AI models"
    - name: "real_time_plugins"
      expr: COUNT(CASE WHEN requires_real_time_data_flag = TRUE THEN 1 END)
      comment: "Number of plugins requiring real-time data feeds - infrastructure demand indicator for streaming architecture capacity planning"
    - name: "distinct_clinical_domains_covered"
      expr: COUNT(DISTINCT clinical_domain)
      comment: "Number of distinct clinical domains with at least one plugin - measures breadth of AI/ML coverage across the health system"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_name)
      comment: "Number of distinct plugin vendors - vendor concentration risk metric for procurement and business continuity planning"
    - name: "avg_score_threshold"
      expr: AVG(CAST(score_threshold AS DOUBLE))
      comment: "Average score threshold for plugin activation - indicates overall clinical decision sensitivity calibration across the AI portfolio"
$$;