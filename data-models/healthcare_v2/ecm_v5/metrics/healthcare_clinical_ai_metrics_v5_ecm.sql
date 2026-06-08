-- Metric views for domain: clinical_ai | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_patient_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for patient risk scoring - tracks AI model performance, risk stratification effectiveness, and clinical intervention alignment for population health management."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score`"
  dimensions:
    - name: "risk_level"
      expr: risk_level
      comment: "Risk stratification tier (high/medium/low) for cohort analysis"
    - name: "score_type"
      expr: score_type
      comment: "Type of risk score (readmission, sepsis, fall, deterioration) for model comparison"
    - name: "population_cohort"
      expr: population_cohort
      comment: "Population cohort assignment for targeted intervention analysis"
    - name: "model_version"
      expr: model_version
      comment: "ML model version for performance tracking across releases"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Recommended intervention type for resource planning"
    - name: "score_change_direction"
      expr: score_change_direction
      comment: "Direction of score change (improving/worsening/stable) for trend analysis"
    - name: "is_current"
      expr: CAST(is_current AS STRING)
      comment: "Whether this is the current active risk score for the patient"
    - name: "prediction_month"
      expr: DATE_TRUNC('MONTH', calculation_timestamp)
      comment: "Month of risk score calculation for temporal trending"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk score calculations performed - baseline volume metric"
    - name: "avg_risk_score"
      expr: AVG(CAST(score_value AS DOUBLE))
      comment: "Average risk score value across population - key indicator of overall population acuity"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence - indicates data completeness and model reliability"
    - name: "high_risk_patient_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'high' THEN mpi_record_id END)
      comment: "Distinct patients classified as high-risk - drives care management staffing and intervention capacity planning"
    - name: "intervention_recommended_count"
      expr: SUM(CASE WHEN intervention_recommended = TRUE THEN 1 ELSE 0 END)
      comment: "Number of scores triggering intervention recommendations - measures actionability of AI models"
    - name: "alert_generated_count"
      expr: SUM(CASE WHEN alert_generated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of clinical alerts generated from risk scores - measures clinical workflow integration"
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_pct AS DOUBLE))
      comment: "Average data completeness percentage for risk calculations - data quality indicator affecting model accuracy"
    - name: "outcome_validated_count"
      expr: SUM(CASE WHEN outcome_validated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of predictions with validated outcomes - essential for model calibration and AUC tracking"
    - name: "avg_score_percentile"
      expr: AVG(CAST(score_percentile AS DOUBLE))
      comment: "Average score percentile across population - distribution health check"
    - name: "care_gap_identified_count"
      expr: SUM(CASE WHEN care_gap_identified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of risk scores that identified care gaps - measures AI contribution to quality improvement"
    - name: "bias_flagged_count"
      expr: SUM(CASE WHEN bias_assessment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of scores flagged for potential bias - critical for AI fairness governance and regulatory compliance"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_model_inference_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for AI model inference performance - tracks latency, accuracy, clinical adoption, and fairness metrics essential for MLOps governance in healthcare."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`model_inference_log`"
  dimensions:
    - name: "inference_status"
      expr: inference_status
      comment: "Status of inference execution (success/failure/timeout) for reliability monitoring"
    - name: "model_name"
      expr: model_name
      comment: "Name of the ML model for cross-model performance comparison"
    - name: "model_version"
      expr: model_version
      comment: "Model version for release-over-release performance tracking"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category output for distribution analysis"
    - name: "inference_type"
      expr: inference_type
      comment: "Real-time vs batch inference for SLA monitoring"
    - name: "deployment_environment"
      expr: deployment_environment
      comment: "Deployment environment (prod/staging/dev) for environment-specific monitoring"
    - name: "use_case"
      expr: use_case
      comment: "Clinical use case (readmission, sepsis, etc.) for domain-specific performance tracking"
    - name: "trigger_source"
      expr: trigger_source
      comment: "What triggered the inference (order entry, admission, scheduled) for workflow analysis"
    - name: "inference_month"
      expr: DATE_TRUNC('MONTH', inference_timestamp)
      comment: "Month of inference for temporal trending"
  measures:
    - name: "total_inferences"
      expr: COUNT(1)
      comment: "Total inference volume - capacity planning and utilization baseline"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average prediction confidence - model reliability indicator"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score output - population acuity trending"
    - name: "alert_override_count"
      expr: SUM(CASE WHEN alert_overridden = TRUE THEN 1 ELSE 0 END)
      comment: "Number of AI alerts overridden by clinicians - measures clinical trust and model calibration needs"
    - name: "alert_acknowledged_count"
      expr: SUM(CASE WHEN alert_acknowledged = TRUE THEN 1 ELSE 0 END)
      comment: "Number of AI alerts acknowledged - measures clinical engagement with AI recommendations"
    - name: "data_drift_flagged_count"
      expr: SUM(CASE WHEN data_drift_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inferences flagged for data drift - early warning for model degradation"
    - name: "real_time_inference_count"
      expr: SUM(CASE WHEN is_real_time = TRUE THEN 1 ELSE 0 END)
      comment: "Count of real-time inferences - measures point-of-care AI integration"
    - name: "distinct_patients_scored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients receiving AI predictions - population coverage metric"
    - name: "consent_verified_count"
      expr: SUM(CASE WHEN consent_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Inferences with verified patient consent - HIPAA/42 CFR Part 2 compliance metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_clinical_nlp_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for clinical NLP extraction performance - tracks entity extraction quality, clinical actionability, and CDI opportunity identification from unstructured clinical notes."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of clinical entity extracted (diagnosis, medication, procedure, lab) for extraction coverage analysis"
    - name: "result_type"
      expr: result_type
      comment: "NLP result classification for output categorization"
    - name: "processing_status"
      expr: processing_status
      comment: "Processing pipeline status for operational monitoring"
    - name: "validation_status"
      expr: validation_status
      comment: "Clinician validation status for accuracy tracking"
    - name: "document_type"
      expr: document_type
      comment: "Source document type (progress note, discharge summary, etc.) for extraction yield analysis"
    - name: "sdoh_category"
      expr: sdoh_category
      comment: "SDOH category identified by NLP for social determinants screening automation"
    - name: "pipeline_version"
      expr: pipeline_version
      comment: "NLP pipeline version for release performance comparison"
    - name: "extraction_month"
      expr: DATE_TRUNC('MONTH', extraction_timestamp)
      comment: "Month of extraction for temporal trending"
  measures:
    - name: "total_extractions"
      expr: COUNT(1)
      comment: "Total NLP extractions performed - processing volume baseline"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average extraction confidence - model quality indicator driving validation workload"
    - name: "actionable_finding_count"
      expr: SUM(CASE WHEN is_actionable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of clinically actionable findings - measures NLP value delivery to clinical workflows"
    - name: "cdi_opportunity_count"
      expr: SUM(CASE WHEN cdi_opportunity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Clinical Documentation Improvement opportunities identified - directly impacts DRG revenue capture"
    - name: "negated_finding_count"
      expr: SUM(CASE WHEN negation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Negated findings correctly identified - critical for avoiding false positive clinical alerts"
    - name: "clinically_relevant_count"
      expr: SUM(CASE WHEN is_clinically_relevant = TRUE THEN 1 ELSE 0 END)
      comment: "Clinically relevant extractions - signal-to-noise ratio of NLP pipeline"
    - name: "distinct_patients_processed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with NLP-processed notes - population coverage of AI-assisted documentation"
    - name: "care_gap_identified_count"
      expr: COUNT(DISTINCT CASE WHEN care_gap_identified IS NOT NULL AND care_gap_identified != '' THEN clinical_nlp_result_id END)
      comment: "NLP extractions that identified care gaps - measures AI contribution to quality measure closure"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for AI-detected care gaps - tracks gap identification, closure rates, financial impact, and quality program performance essential for value-based care contracts."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`care_gap`"
  dimensions:
    - name: "care_gap_status"
      expr: care_gap_status
      comment: "Current gap status (open/closed/suppressed) for pipeline management"
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (preventive, chronic, acute) for intervention prioritization"
    - name: "priority"
      expr: priority
      comment: "Gap priority level for resource allocation"
    - name: "quality_program"
      expr: quality_program
      comment: "Associated quality program (HEDIS, MIPS, Stars) for contract performance tracking"
    - name: "detection_method"
      expr: detection_method
      comment: "How the gap was detected (AI model, rule-based, manual) for method effectiveness comparison"
    - name: "closure_method"
      expr: closure_method
      comment: "How the gap was closed for intervention effectiveness analysis"
    - name: "outreach_channel"
      expr: outreach_channel
      comment: "Patient outreach channel used for channel effectiveness optimization"
    - name: "is_overdue"
      expr: CAST(is_overdue AS STRING)
      comment: "Whether the gap is past due date for urgency monitoring"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month of gap detection for seasonal and trending analysis"
  measures:
    - name: "total_care_gaps"
      expr: COUNT(1)
      comment: "Total care gaps identified - baseline volume for quality program management"
    - name: "open_care_gaps"
      expr: SUM(CASE WHEN care_gap_status = 'open' THEN 1 ELSE 0 END)
      comment: "Currently open care gaps - primary operational metric for care management teams"
    - name: "closed_care_gaps"
      expr: SUM(CASE WHEN care_gap_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Closed care gaps - numerator for gap closure rate calculations"
    - name: "overdue_care_gaps"
      expr: SUM(CASE WHEN is_overdue = TRUE THEN 1 ELSE 0 END)
      comment: "Overdue care gaps requiring immediate attention - escalation trigger metric"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of open care gaps - quantifies revenue at risk from quality program non-compliance"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average AI confidence in gap detection - model reliability for clinical trust"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average patient risk score associated with care gaps - acuity-weighted prioritization"
    - name: "distinct_patients_with_gaps"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with open care gaps - population health management scope"
    - name: "sdoh_barrier_count"
      expr: SUM(CASE WHEN sdoh_barrier_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Care gaps with SDOH barriers identified - drives community health worker intervention allocation"
    - name: "patient_notified_count"
      expr: SUM(CASE WHEN is_patient_notified = TRUE THEN 1 ELSE 0 END)
      comment: "Patients notified of care gaps - outreach effectiveness baseline"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_model_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Model lifecycle and governance KPIs - tracks model versions across development stages, validation performance, and production readiness for FDA SaMD and clinical AI governance."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`model_version`"
  dimensions:
    - name: "model_version_status"
      expr: model_version_status
      comment: "Lifecycle status (development/validation/production/deprecated) for pipeline health"
    - name: "model_type"
      expr: model_type
      comment: "Type of ML model (classification, regression, NLP) for portfolio analysis"
    - name: "framework"
      expr: framework
      comment: "ML framework used (sklearn, pytorch, spark) for infrastructure planning"
    - name: "is_production"
      expr: CAST(is_production AS STRING)
      comment: "Whether version is in production for active model inventory"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', released_timestamp)
      comment: "Month of production release for deployment velocity tracking"
  measures:
    - name: "total_model_versions"
      expr: COUNT(1)
      comment: "Total model versions registered - MLOps maturity indicator"
    - name: "production_model_count"
      expr: SUM(CASE WHEN is_production = TRUE THEN 1 ELSE 0 END)
      comment: "Models currently in production - active clinical AI footprint"
    - name: "avg_evaluation_metric_value"
      expr: AVG(CAST(evaluation_metric_value AS DOUBLE))
      comment: "Average evaluation metric (AUC/F1/accuracy) across versions - portfolio quality indicator"
    - name: "distinct_model_cards"
      expr: COUNT(DISTINCT clinical_ai_model_card_id)
      comment: "Distinct model cards with versions - breadth of AI capabilities deployed"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_governance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI governance and compliance KPIs - tracks policy adherence, review cadence, and regulatory readiness for clinical AI systems under HIPAA and FDA oversight."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`governance`"
  dimensions:
    - name: "governance_status"
      expr: governance_status
      comment: "Current governance status (active/under_review/suspended) for compliance monitoring"
    - name: "risk_tier"
      expr: risk_tier
      comment: "AI risk tier classification (high/medium/low) per FDA SaMD framework"
    - name: "governance_scope"
      expr: governance_scope
      comment: "Scope of governance policy for coverage analysis"
    - name: "hipaa_compliance_flag"
      expr: CAST(hipaa_compliance_flag AS STRING)
      comment: "HIPAA compliance status for regulatory readiness reporting"
  measures:
    - name: "total_governance_policies"
      expr: COUNT(1)
      comment: "Total governance policies in place - AI governance program maturity"
    - name: "active_policies"
      expr: SUM(CASE WHEN governance_status = 'active' THEN 1 ELSE 0 END)
      comment: "Active governance policies - current regulatory coverage"
    - name: "hipaa_compliant_count"
      expr: SUM(CASE WHEN hipaa_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Policies with confirmed HIPAA compliance - regulatory audit readiness"
    - name: "patient_notification_required_count"
      expr: SUM(CASE WHEN patient_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Policies requiring patient notification - transparency obligation tracking"
    - name: "distinct_governed_models"
      expr: COUNT(DISTINCT clinical_ai_model_card_id)
      comment: "Distinct AI models under governance - coverage gap identification"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_model_training_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ML training operations KPIs - tracks compute costs, training efficiency, and model development velocity for healthcare AI R&D budget management."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`model_training_run`"
  dimensions:
    - name: "model_training_run_status"
      expr: model_training_run_status
      comment: "Training run status (completed/failed/running) for pipeline reliability"
    - name: "training_framework"
      expr: training_framework
      comment: "ML framework for infrastructure cost allocation"
    - name: "gpu_enabled"
      expr: CAST(gpu_enabled AS STRING)
      comment: "Whether GPU was used for compute cost analysis"
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of training run for R&D spend trending"
  measures:
    - name: "total_training_runs"
      expr: COUNT(1)
      comment: "Total training runs executed - development velocity indicator"
    - name: "total_training_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total compute cost in USD - AI R&D budget tracking and optimization"
    - name: "avg_training_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training run - efficiency benchmarking"
    - name: "total_gpu_hours"
      expr: SUM(CAST(gpu_hours_consumed AS DOUBLE))
      comment: "Total GPU hours consumed - infrastructure capacity planning"
    - name: "total_cpu_hours"
      expr: SUM(CAST(cpu_hours_consumed AS DOUBLE))
      comment: "Total CPU hours consumed - compute resource utilization"
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average evaluation metric across runs - model improvement trajectory"
    - name: "failed_run_count"
      expr: SUM(CASE WHEN model_training_run_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Failed training runs - pipeline reliability and waste indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_bias_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI fairness and bias monitoring KPIs - tracks algorithmic bias across protected attributes, essential for health equity compliance and FDA SaMD regulatory requirements."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring`"
  dimensions:
    - name: "protected_attribute"
      expr: protected_attribute
      comment: "Protected demographic attribute being monitored (race, gender, age, language) for equity analysis"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of bias assessment (disparate impact, equalized odds, calibration) for methodology tracking"
    - name: "metric_status"
      expr: metric_status
      comment: "Whether metric is within acceptable threshold (pass/fail/warning) for alerting"
    - name: "metric_name"
      expr: metric_name
      comment: "Specific fairness metric being measured for detailed analysis"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_timestamp)
      comment: "Month of bias assessment for trend monitoring"
  measures:
    - name: "total_bias_assessments"
      expr: COUNT(1)
      comment: "Total bias assessments performed - monitoring program activity level"
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average fairness metric value - overall equity health indicator"
    - name: "threshold_violation_count"
      expr: SUM(CASE WHEN metric_status = 'fail' THEN 1 ELSE 0 END)
      comment: "Number of fairness threshold violations - triggers remediation workflows and regulatory reporting"
    - name: "avg_metric_threshold"
      expr: AVG(CAST(metric_threshold AS DOUBLE))
      comment: "Average threshold setting - governance stringency indicator"
    - name: "distinct_models_monitored"
      expr: COUNT(DISTINCT clinical_ai_model_card_id)
      comment: "Distinct models under bias monitoring - fairness program coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_population_cohort_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health cohort management KPIs - tracks patient attribution, risk stratification, engagement, and quality measure compliance for value-based care programs."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Cohort membership status (active/disenrolled/pending) for population management"
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Risk tier assignment for resource allocation across care management levels"
    - name: "engagement_level"
      expr: engagement_level
      comment: "Patient engagement level for outreach strategy optimization"
    - name: "attribution_method"
      expr: attribution_method
      comment: "How patient was attributed to provider/program for methodology comparison"
    - name: "consent_status"
      expr: consent_status
      comment: "Patient consent status for data sharing compliance"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of cohort enrollment for growth trending"
  measures:
    - name: "total_cohort_members"
      expr: COUNT(1)
      comment: "Total cohort membership records - population health program scale"
    - name: "active_members"
      expr: SUM(CASE WHEN is_current_record = TRUE THEN 1 ELSE 0 END)
      comment: "Currently active cohort members - real-time managed population size"
    - name: "avg_current_risk_score"
      expr: AVG(CAST(current_risk_score AS DOUBLE))
      comment: "Average current risk score - population acuity for staffing models"
    - name: "avg_quality_measure_compliance_pct"
      expr: AVG(CAST(quality_measure_compliance_pct AS DOUBLE))
      comment: "Average quality measure compliance - value-based contract performance indicator"
    - name: "avg_medication_adherence_pct"
      expr: AVG(CAST(medication_adherence_pct AS DOUBLE))
      comment: "Average medication adherence - chronic disease management effectiveness"
    - name: "avg_model_confidence_score"
      expr: AVG(CAST(model_confidence_score AS DOUBLE))
      comment: "Average AI model confidence in cohort assignment - data quality indicator"
    - name: "sdoh_risk_flagged_count"
      expr: SUM(CASE WHEN sdoh_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Members with SDOH risk factors - drives community health resource allocation"
    - name: "opt_out_count"
      expr: SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Members who opted out - patient autonomy and program acceptance metric"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients across cohort memberships - deduplicated population reach"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_ai_feature_store_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feature store operational KPIs - tracks feature freshness, data quality, and PHI governance for the clinical AI feature engineering platform."
  source: "`healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Feature entity type (patient, encounter, provider) for coverage analysis"
    - name: "feature_store_entity_status"
      expr: feature_store_entity_status
      comment: "Entity lifecycle status for operational health monitoring"
    - name: "materialization_strategy"
      expr: materialization_strategy
      comment: "How features are materialized (batch/streaming/on-demand) for infrastructure planning"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data sensitivity classification for governance compliance"
    - name: "scd_type"
      expr: scd_type
      comment: "Slowly changing dimension type for temporal feature management"
  measures:
    - name: "total_feature_entities"
      expr: COUNT(1)
      comment: "Total feature store entities registered - platform maturity indicator"
    - name: "active_entities"
      expr: SUM(CASE WHEN feature_store_entity_status = 'active' THEN 1 ELSE 0 END)
      comment: "Active feature entities available for model consumption"
    - name: "phi_containing_entities"
      expr: SUM(CASE WHEN contains_phi_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Feature entities containing PHI - HIPAA governance scope"
    - name: "online_store_enabled_count"
      expr: SUM(CASE WHEN online_store_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Entities with online serving enabled - real-time inference readiness"
    - name: "total_row_count"
      expr: SUM(CAST(row_count AS DOUBLE))
      comment: "Total rows across feature entities - storage and compute cost driver"
    - name: "avg_drift_threshold"
      expr: AVG(CAST(drift_threshold AS DOUBLE))
      comment: "Average drift detection threshold - monitoring sensitivity configuration"
$$;