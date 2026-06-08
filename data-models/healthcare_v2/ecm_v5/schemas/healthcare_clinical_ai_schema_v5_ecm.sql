-- Schema for Domain: clinical_ai | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai` COMMENT 'Domain for AI/ML model outputs, risk scores, NLP results, care gaps, and governance';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` (
    `patient_risk_score_id` BIGINT COMMENT 'Primary key for patient_risk_score',
    `care_program_id` BIGINT COMMENT 'Reference to the population health or care management program associated with this risk assessment.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the patient was located or receiving care when the score was generated.',
    `model_card_id` BIGINT COMMENT 'Reference to the AI/ML model or algorithm that generated this risk score.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this risk score was computed.',
    `clinician_id` BIGINT COMMENT 'Reference to the ordering or responsible provider who requested or is accountable for the risk assessment.',
    `patient_reviewed_by_provider_clinician_id` BIGINT COMMENT 'Reference to the clinician who reviewed and acknowledged this risk score in the clinical workflow.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter that triggered or is associated with this risk score calculation, if applicable.',
    `actual_outcome_occurred` BOOLEAN COMMENT 'Indicates whether the predicted adverse event actually occurred within the prediction horizon, used for model accuracy measurement.',
    `alert_generated` BOOLEAN COMMENT 'Indicates whether this risk score triggered a clinical alert or notification in the EHR system.',
    `bias_assessment_flag` BOOLEAN COMMENT 'Indicates whether algorithmic bias assessment was performed for this model version against the patients demographic group.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when this risk score was computed by the AI/ML model.',
    `care_gap_identified` BOOLEAN COMMENT 'Indicates whether this risk score calculation identified an actionable care gap for the patient.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence or certainty level of the prediction, representing how reliable the model considers this particular score.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of required input data elements that were available at the time of score calculation, indicating data quality.',
    `effective_end_date` DATE COMMENT 'The date after which this risk score is no longer considered clinically valid, typically when superseded by a newer calculation.',
    `effective_start_date` DATE COMMENT 'The date from which this risk score is considered clinically valid and actionable.',
    `explanation_text` STRING COMMENT 'Human-readable explanation of the risk score factors and reasoning, generated for clinical transparency. May contain PHI references.',
    `hipaa_retention_expiry_date` DATE COMMENT 'The date after which this record may be purged per HIPAA minimum necessary and organizational retention policies.',
    `icd10_primary_code` STRING COMMENT 'The primary ICD-10 diagnosis code most relevant to this risk assessment, providing clinical context for the score.',
    `input_feature_count` STRING COMMENT 'Number of clinical and demographic features used as inputs for this particular score calculation.',
    `intervention_recommended` BOOLEAN COMMENT 'Indicates whether the risk score triggered a recommendation for clinical intervention or care management outreach.',
    `intervention_type` STRING COMMENT 'The type of clinical intervention recommended based on the risk score threshold and clinical rules.',
    `is_current` BOOLEAN COMMENT 'SCD Type 2 indicator denoting whether this is the most current version of the risk score for this patient and score type.',
    `model_regulatory_class` STRING COMMENT 'FDA regulatory classification of the AI/ML model as a Software as Medical Device (SaMD), governing oversight requirements.',
    `model_version` STRING COMMENT 'Version identifier of the AI/ML model used to generate this score, supporting reproducibility and audit requirements.',
    `outcome_validated` BOOLEAN COMMENT 'Indicates whether the predicted outcome has been retrospectively validated against actual patient outcomes for model performance tracking.',
    `outcome_validation_date` DATE COMMENT 'The date when the actual outcome was assessed against the prediction for model performance evaluation.',
    `override_reason` STRING COMMENT 'Free-text or coded reason provided by the clinician when overriding or dismissing the AI-generated risk score.',
    `patient_risk_score_status` STRING COMMENT 'Current lifecycle status of this risk score record indicating whether it is the active score or has been replaced.',
    `population_cohort` STRING COMMENT 'The reference population or patient cohort against which this score was calibrated (e.g., Medicare 65+, general adult, pediatric).',
    `prediction_horizon_days` STRING COMMENT 'The number of days into the future that this risk score predicts (e.g., 30-day readmission, 90-day mortality).',
    `primary_contributing_factor` STRING COMMENT 'The single most influential clinical factor driving this risk score, derived from model explainability (e.g., SHAP values).',
    `prior_score_value` DECIMAL(18,2) COMMENT 'The most recent previous risk score value for the same patient and score type, enabling trend analysis.',
    `review_outcome` STRING COMMENT 'The clinicians decision after reviewing the risk score, indicating whether they accepted or overrode the AI recommendation.',
    `review_timestamp` TIMESTAMP COMMENT 'The date and time when a clinician reviewed this risk score, supporting clinical workflow tracking.',
    `risk_level` STRING COMMENT 'Categorical risk stratification level derived from the numeric score value based on clinically validated thresholds.',
    `score_change_direction` STRING COMMENT 'Direction of change compared to the prior score, supporting clinical trend monitoring and alerting.',
    `score_percentile` DECIMAL(18,2) COMMENT 'The percentile rank of this score relative to the reference population, indicating where this patient falls in the distribution.',
    `score_type` STRING COMMENT 'Classification of the type of clinical risk being assessed. [ENUM-REF-CANDIDATE: readmission|mortality|sepsis|fall|deterioration|chronic_disease|suicide|pressure_injury|venous_thromboembolism — promote to reference product]',
    `score_value` DECIMAL(18,2) COMMENT 'The computed numeric risk score value, typically a probability between 0 and 1 or a scaled score depending on the model.',
    `sdoh_factor_included` BOOLEAN COMMENT 'Indicates whether social determinants of health data was incorporated into the risk score calculation.',
    `secondary_contributing_factor` STRING COMMENT 'The second most influential clinical factor contributing to this risk score, supporting clinical decision-making transparency.',
    `source_system` STRING COMMENT 'The clinical or analytics system that originated this risk score (e.g., Epic Healthy Planet, Cerner HealtheIntent).',
    `valid_from_timestamp` TIMESTAMP COMMENT 'SCD Type 2 timestamp marking when this version of the record became the active version in the data lakehouse.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'SCD Type 2 timestamp marking when this version of the record was superseded. NULL indicates the current active version.',
    `patient_id` BIGINT COMMENT 'Unique medical record number that identifies the patient for whom the risk score is calculated.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the AI model generated the risk score.',
    `model_name` STRING COMMENT 'Descriptive name of the clinical AI model that produced the score (e.g., sepsis_prediction).',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that executed the inference.',
    `risk_score` DOUBLE COMMENT 'Numeric risk score output by the model, typically ranging from 0.0 to 1.0.',
    `risk_score_category` STRING COMMENT 'Categorical risk band derived from the numeric score for clinical decision support.. Valid values are `low|medium|high|critical`',
    `prediction_date` DATE COMMENT 'Calendar date (without time) on which the risk score applies.',
    `feature_set_version` STRING COMMENT 'Version identifier of the feature set used for the model inference.',
    `notes` STRING COMMENT 'Free‑text field for any additional context or reviewer comments about the score.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this risk score record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record (e.g., after re‑scoring).',
    CONSTRAINT pk_patient_risk_score PRIMARY KEY(`patient_risk_score_id`)
) COMMENT 'Table storing patient risk scores';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` (
    `clinical_nlp_result_id` BIGINT COMMENT 'Primary key for clinical_nlp_result',
    `clinician_id` BIGINT COMMENT 'The authoring provider of the source clinical document that was processed by NLP.',
    `clinical_validated_by_provider_clinician_id` BIGINT COMMENT 'The provider who clinically reviewed and validated or rejected this NLP extraction result.',
    `model_card_id` BIGINT COMMENT 'Reference to the specific NLP model or pipeline version that produced this result.',
    `mpi_record_id` BIGINT COMMENT 'The patient whose clinical documentation was processed by the NLP pipeline.',
    `note_id` BIGINT COMMENT 'Reference to the clinical note or document from which NLP extractions were derived.',
    `visit_id` BIGINT COMMENT 'The patient encounter during which the source clinical document was generated.',
    `assertion_status` STRING COMMENT 'The contextual assertion status of the extracted concept indicating whether the condition is affirmed, negated, or uncertain in the clinical narrative.',
    `body_site` STRING COMMENT 'The anatomical body site associated with the extracted clinical concept.',
    `care_gap_identified` STRING COMMENT 'Description of any care gap identified by the NLP extraction (e.g., missing screening, overdue vaccination, unaddressed condition).',
    `cdi_opportunity_flag` BOOLEAN COMMENT 'Indicates whether this extraction identifies a potential CDI opportunity for more specific clinical documentation or coding.',
    `coding_system` STRING COMMENT 'The clinical terminology or coding system to which the concept_code belongs.',
    `concept_code` STRING COMMENT 'The standardized code from the mapped terminology system (e.g., SNOMED CT concept ID, ICD-10 code, RxNorm CUI).',
    `confidence_score` DECIMAL(18,2) COMMENT 'The model confidence score (0.0000 to 1.0000) indicating the certainty of the NLP extraction.',
    `context_window_size` STRING COMMENT 'The number of tokens or characters in the context window used by the NLP model for this extraction.',
    `document_date` DATE COMMENT 'The clinically relevant date of the source document from which the NLP extraction was performed.',
    `document_type` STRING COMMENT 'The type of clinical document processed (e.g., progress note, discharge summary, operative report, radiology report, pathology report). [ENUM-REF-CANDIDATE: progress_note|discharge_summary|operative_report|radiology_report|pathology_report|consultation|h_and_p|nursing_note — promote to reference product]',
    `effective_date` DATE COMMENT 'The date from which this NLP result is considered effective for clinical decision support and analytics purposes.',
    `entity_type` STRING COMMENT 'The clinical named entity type extracted (e.g., problem, medication, procedure, anatomy, lab test, symptom). [ENUM-REF-CANDIDATE: problem|medication|procedure|anatomy|lab_test|symptom|allergy|device|vital_sign — promote to reference product]',
    `experiencer` STRING COMMENT 'Identifies who experiences the clinical concept — the patient themselves or a family member (relevant for family history).',
    `expiration_date` DATE COMMENT 'The date after which this NLP result should no longer be used for active clinical decision support (e.g., superseded by newer extraction).',
    `extracted_text` STRING COMMENT 'The exact text span extracted from the clinical document by the NLP engine, representing the identified clinical concept.',
    `extraction_timestamp` TIMESTAMP COMMENT 'The date and time when the NLP extraction was performed on the source document.',
    `is_actionable` BOOLEAN COMMENT 'Indicates whether the NLP extraction represents an actionable clinical finding requiring follow-up or intervention.',
    `is_clinically_relevant` BOOLEAN COMMENT 'Indicates whether the extracted concept has been determined to be clinically relevant for the patients care.',
    `laterality` STRING COMMENT 'The laterality qualifier for anatomical findings indicating left, right, or bilateral involvement.',
    `negation_flag` BOOLEAN COMMENT 'Indicates whether the extracted concept was negated in the clinical text (e.g., no fever, denies chest pain).',
    `normalized_concept` STRING COMMENT 'The standardized clinical concept label after normalization against a controlled terminology (e.g., SNOMED CT preferred term).',
    `pipeline_version` STRING COMMENT 'The semantic version of the NLP processing pipeline that generated this result, supporting reproducibility and model governance.',
    `processing_status` STRING COMMENT 'The current status of the NLP extraction result indicating whether processing completed successfully or encountered issues.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NLP result record was first persisted in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this NLP result record was last modified, including validation status changes.',
    `relation_type` STRING COMMENT 'For relation-type results, the semantic relationship between two entities (e.g., treats, causes, administered_via, located_at).',
    `result_type` STRING COMMENT 'Classification of the NLP extraction result indicating what type of linguistic or clinical concept was identified.',
    `sdoh_category` STRING COMMENT 'The SDOH category if the extraction identifies a social determinant (e.g., housing instability, food insecurity, transportation barrier). [ENUM-REF-CANDIDATE: housing|food_insecurity|transportation|financial_strain|social_isolation|education|employment|violence — promote to reference product]',
    `section_name` STRING COMMENT 'The clinical document section from which the extraction was made (e.g., History of Present Illness, Assessment and Plan, Medications).',
    `sentence_text` STRING COMMENT 'The full sentence from the clinical document containing the extracted concept, providing context for clinical review.',
    `severity` STRING COMMENT 'The severity qualifier extracted for the clinical concept when applicable (e.g., mild chest pain, severe headache).',
    `source_system` STRING COMMENT 'The originating clinical system from which the source document was obtained (e.g., Epic ClinDoc, Cerner PowerChart).',
    `span_end_offset` STRING COMMENT 'The character position in the source document where the extracted text span ends.',
    `span_start_offset` STRING COMMENT 'The character position in the source document where the extracted text span begins, enabling precise text highlighting.',
    `suggested_cpt_code` STRING COMMENT 'The CPT code suggested by the NLP model for procedure-related extractions, supporting coding workflows.',
    `suggested_icd_code` STRING COMMENT 'The ICD-10-CM code suggested by the NLP model based on the extracted clinical concept, supporting computer-assisted coding.',
    `temporality` STRING COMMENT 'The temporal context of the extracted concept indicating whether it refers to a current, historical, or future clinical state.',
    `validation_status` STRING COMMENT 'The human review status indicating whether a clinician has validated, rejected, or modified the NLP extraction.',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the clinical validation review was performed on this NLP result.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient whose clinical note was processed.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the source note.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider who authored the source clinical note.',
    `source_note_type` STRING COMMENT 'Category of the source clinical document.. Valid values are `progress_note|discharge_summary|consult_note|procedure_note|radiology_report`',
    `mlflow_run_id` STRING COMMENT 'Identifier of the MLflow run that generated this NLP result.',
    `model_name` STRING COMMENT 'Name of the NLP model used for extraction.',
    `model_version` STRING COMMENT 'Version of the NLP model.',
    `concept_display` STRING COMMENT 'Human-readable name of the extracted concept.',
    `certainty` STRING COMMENT 'Certainty level of the extracted concept.. Valid values are `certain|probable|possible|unknown`',
    `source_text_snippet` STRING COMMENT 'Excerpt of the source note containing the concept.',
    `extraction_method` STRING COMMENT 'Technique used for extraction.. Valid values are `rule_based|machine_learning|deep_learning|hybrid`',
    `processing_time_ms` STRING COMMENT 'Time in milliseconds taken to process the note.',
    `status` STRING COMMENT 'Current lifecycle status of the NLP result record.. Valid values are `active|inactive|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was first inserted.',
    `updated_timestamp` TIMESTAMP COMMENT 'When the record was last modified.',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the source note.. Valid values are `en|es|fr|de|zh|ar`',
    `document_version` STRING COMMENT 'Version identifier of the source clinical document.',
    `annotation_id` BIGINT COMMENT 'Identifier for the annotation within the note (if multiple per note).',
    `is_sensitive` BOOLEAN COMMENT 'Indicates if the extracted concept is considered sensitive PHI.',
    `related_concept_codes` STRING COMMENT 'Comma-separated list of related concept codes linked to this extraction.',
    CONSTRAINT pk_clinical_nlp_result PRIMARY KEY(`clinical_nlp_result_id`)
) COMMENT 'Table storing clinical NLP extraction results';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`care_gap` (
    `care_gap_id` BIGINT COMMENT 'Primary key for care_gap',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site or facility where the care gap is expected to be addressed.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary care provider or attributed provider responsible for closing the care gap.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure or clinical guideline that defines this care gap (e.g., HEDIS measure, CMS eCQM).',
    `model_card_id` BIGINT COMMENT 'Identifier of the AI/ML model or clinical rules engine version that generated or validated this care gap prediction.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom the care gap has been identified.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer whose quality program or contract requires tracking of this care gap.',
    `visit_id` BIGINT COMMENT 'Identifier of the encounter during which the care gap was identified or last assessed.',
    `attribution_method` STRING COMMENT 'Method used to attribute this care gap to a specific provider, such as primary care panel assignment, claims plurality, or ACO attribution.',
    `care_gap_status` STRING COMMENT 'Current lifecycle status of the care gap indicating whether it is open, being addressed, resolved, or excluded from measurement.',
    `care_program_name` STRING COMMENT 'Name of the population health or disease management program under which this care gap is tracked (e.g., Diabetes Management, Preventive Wellness).',
    `closure_date` DATE COMMENT 'Date when the care gap was resolved or closed, either through completion of the recommended action or valid exclusion.',
    `closure_method` STRING COMMENT 'Method by which the care gap was closed, such as completion of the recommended service, valid clinical exclusion, or patient refusal.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Machine learning model confidence score (0.0000 to 1.0000) indicating the probability that this care gap is valid and actionable.',
    `cpt_code` STRING COMMENT 'CPT procedure code for the service or intervention that would satisfy and close this care gap.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this care gap record was first created in the system.',
    `days_open` STRING COMMENT 'Number of days the care gap has remained in open status since detection, used for aging analysis and escalation workflows.',
    `denominator_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is eligible for inclusion in the quality measure denominator based on age, gender, diagnosis, and enrollment criteria.',
    `detection_date` DATE COMMENT 'Date when the care gap was first identified or detected by the system or clinician.',
    `detection_method` STRING COMMENT 'Method by which the care gap was identified, such as clinical rules engine, NLP extraction, machine learning prediction, or manual clinical review.',
    `due_date` DATE COMMENT 'Date by which the recommended care action should be completed to satisfy the quality measure compliance window.',
    `evidence_source` STRING COMMENT 'Source of clinical evidence used to identify or validate the care gap, such as claims data, EHR documentation, lab results, or health information exchange.',
    `exclusion_reason` STRING COMMENT 'Clinical or administrative reason for excluding the patient from the quality measure denominator, such as contraindication, hospice enrollment, or advanced illness.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact in USD associated with this care gap, including potential quality bonus/penalty, shared savings, or withheld reimbursement.',
    `gap_type` STRING COMMENT 'Classification of the care gap by clinical category indicating the nature of the missed or overdue care intervention.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code associated with the clinical condition relevant to this care gap.',
    `is_overdue` BOOLEAN COMMENT 'Indicates whether the care gap has exceeded its due date without being closed, triggering escalation protocols.',
    `is_patient_notified` BOOLEAN COMMENT 'Indicates whether the patient has been notified about this care gap through any communication channel.',
    `is_provider_notified` BOOLEAN COMMENT 'Indicates whether the attributed provider has been alerted about this care gap for clinical action.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent patient outreach attempt related to this care gap.',
    `last_service_date` DATE COMMENT 'Date of the most recent clinical service relevant to this care gap, used to determine if the gap is still open based on lookback periods.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the laboratory test or clinical observation that would satisfy this care gap requirement.',
    `measurement_period_end` DATE COMMENT 'End date of the quality measurement period during which this care gap must be closed to count toward performance.',
    `measurement_period_start` DATE COMMENT 'Start date of the quality measurement period during which this care gap is evaluated for compliance.',
    `model_version` STRING COMMENT 'Semantic version of the AI/ML model or rules engine that produced this care gap identification for reproducibility and audit.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the care gap, which may contain protected health information regarding patient-specific clinical context.',
    `numerator_compliance_flag` BOOLEAN COMMENT 'Indicates whether the patient currently meets the numerator criteria for the associated quality measure, meaning the gap is effectively closed.',
    `outreach_channel` STRING COMMENT 'Communication channel used for the most recent outreach attempt to the patient regarding this care gap.',
    `outreach_count` STRING COMMENT 'Number of outreach attempts made to the patient to address this care gap, including phone calls, letters, portal messages, and text notifications.',
    `priority` STRING COMMENT 'Clinical priority level assigned to the care gap based on patient risk, measure importance, and time sensitivity.',
    `quality_program` STRING COMMENT 'Quality reporting program under which this care gap is measured, such as HEDIS, MIPS, Medicare Stars, Value-Based Purchasing, or ACO shared savings.',
    `recommended_action` STRING COMMENT 'Description of the specific clinical action recommended to close the care gap, such as scheduling a screening, ordering a lab test, or prescribing medication.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk stratification score associated with the patient at the time of care gap detection, used to prioritize outreach and intervention.',
    `sdoh_barrier_flag` BOOLEAN COMMENT 'Indicates whether social determinants of health barriers (transportation, food insecurity, housing instability) have been identified as contributing to this care gap.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this care gap record (e.g., Epic Healthy Planet, Cerner HealtheIntent, Salesforce Health Cloud).',
    `suppression_end_date` DATE COMMENT 'Date when the care gap suppression expires and the gap returns to active worklists for follow-up.',
    `suppression_reason` STRING COMMENT 'Reason for suppressing or snoozing the care gap from active worklists, such as patient preference, temporary clinical hold, or pending data reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this care gap record was last modified, used for change tracking and data freshness monitoring.',
    `patient_id` BIGINT COMMENT 'Surrogate key referencing the patient for whom the care gap was identified.',
    `gap_severity` STRING COMMENT 'Clinical severity rating of the identified care gap.. Valid values are `low|moderate|high|critical`',
    `recommendation` STRING COMMENT 'Suggested clinical intervention or action to address the gap.',
    `status` STRING COMMENT 'Current lifecycle status of the care gap.. Valid values are `identified|in_progress|resolved|closed|dismissed`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the care gap was first identified by the AI model.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the care gap was resolved or closed, if applicable.',
    `model_name` STRING COMMENT 'Name of the clinical AI model that generated the care‑gap prediction.',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that produced the prediction, enabling traceability.',
    `intervention_due_date` DATE COMMENT 'Target date by which the recommended intervention should be completed.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the care gap is flagged as critical for immediate action.',
    `resolved_by_user_id` BIGINT COMMENT 'Identifier of the clinician or staff member who resolved the care gap.',
    `care_gap_category` STRING COMMENT 'Higher‑level classification of the gap (e.g., preventive, diagnostic).. Valid values are `preventive|diagnostic|therapeutic|educational`',
    `priority_level` STRING COMMENT 'Operational priority assigned to the care gap for scheduling interventions.. Valid values are `low|medium|high|urgent`',
    CONSTRAINT pk_care_gap PRIMARY KEY(`care_gap_id`)
) COMMENT 'Table tracking care gaps';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` (
    `model_inference_log_id` BIGINT COMMENT 'Primary key for model_inference_log',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where this inference was generated or consumed.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who requested or was the intended consumer of this inference result.',
    `governance_id` BIGINT COMMENT 'Reference to the governance committee approval record authorizing this model version for clinical use.',
    `model_version_id` BIGINT COMMENT 'Reference to the specific AI/ML model that produced this inference result.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the inference was generated. Classified as PHI under HIPAA.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter context during which this inference was triggered, if applicable.',
    `alert_acknowledged` BOOLEAN COMMENT 'Indicates whether a clinician acknowledged the alert or recommendation generated by this inference.',
    `alert_overridden` BOOLEAN COMMENT 'Indicates whether the clinician overrode or dismissed the model recommendation, critical for measuring alert fatigue and model utility.',
    `batch_run_identifier` STRING COMMENT 'Identifier for the batch execution run when inference was performed in batch mode, null for real-time inferences.',
    `clinical_action_taken` STRING COMMENT 'The downstream clinical action triggered by this inference result within the clinical workflow.',
    `confidence_score` DECIMAL(18,2) COMMENT 'The models confidence or probability score for the primary prediction, expressed as a value between 0 and 1.',
    `consent_verified` BOOLEAN COMMENT 'Indicates whether patient consent for AI-assisted clinical decision support was verified prior to inference execution.',
    `correlation_identifier` STRING COMMENT 'Identifier linking this inference to a broader clinical workflow or decision chain spanning multiple model calls.',
    `data_drift_flag` BOOLEAN COMMENT 'Indicates whether input data drift was detected for this inference relative to the models training distribution.',
    `department_code` STRING COMMENT 'Code identifying the clinical department context for this inference (e.g., ED, ICU, oncology).',
    `deployment_environment` STRING COMMENT 'The environment context in which this inference was executed, distinguishing production from test or shadow deployments.',
    `error_code` STRING COMMENT 'Standardized error code when inference_status is not success, enabling systematic error categorization and monitoring.',
    `error_message` STRING COMMENT 'Descriptive error message providing details when the inference execution fails or produces a partial result.',
    `explanation_text` STRING COMMENT 'Human-readable explanation of the inference result generated by explainability methods (e.g., SHAP, LIME) for clinical transparency.',
    `fairness_group` STRING COMMENT 'The demographic or clinical subgroup used for bias and fairness monitoring of this inference (e.g., age_group, race_ethnicity category). Stored as category label, not individual PHI.',
    `feedback_label` STRING COMMENT 'Post-hoc ground truth label assigned after clinical outcome is known, used for model performance monitoring and retraining.',
    `feedback_timestamp` TIMESTAMP COMMENT 'Date and time when ground truth feedback was recorded for this inference event.',
    `hipaa_minimum_necessary` BOOLEAN COMMENT 'Confirms that only the minimum necessary PHI was accessed for this inference per HIPAA minimum necessary standard.',
    `inference_status` STRING COMMENT 'Outcome status of the inference execution indicating whether the model produced a valid result.',
    `inference_timestamp` TIMESTAMP COMMENT 'The exact date and time when the AI/ML model inference was executed. This is the principal business event time for the log entry.',
    `inference_type` STRING COMMENT 'Category of AI/ML inference performed, indicating the nature of the model output.',
    `input_feature_count` STRING COMMENT 'Number of input features provided to the model for this inference event.',
    `input_feature_hash` STRING COMMENT 'SHA-256 hash of the input feature vector used for this inference, enabling reproducibility verification without storing raw PHI features.',
    `is_real_time` BOOLEAN COMMENT 'Indicates whether this inference was executed in real-time (synchronous) versus batch (asynchronous) mode.',
    `latency_ms` STRING COMMENT 'Total elapsed time in milliseconds from inference request to response, critical for monitoring real-time clinical decision support SLAs.',
    `model_framework` STRING COMMENT 'The ML framework used to train and serve the model (e.g., MLflow, TensorFlow, PyTorch, scikit-learn, Spark MLlib).',
    `model_name` STRING COMMENT 'Human-readable name of the AI/ML model used for this inference (e.g., sepsis_risk_predictor, readmission_risk_v3, nlp_clinical_note_extractor).',
    `model_version` STRING COMMENT 'Semantic version identifier of the model used for this inference, enabling traceability to specific trained model artifacts.',
    `override_reason` STRING COMMENT 'Clinician-provided reason for overriding the model recommendation, supporting model improvement feedback loops.',
    `prediction_class_label` STRING COMMENT 'For classification models, the predicted class label (e.g., positive, negative, or specific condition codes).',
    `prediction_output` STRING COMMENT 'The primary output value or label produced by the model inference. May contain clinical predictions classified as PHI.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inference log record was first persisted to the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inference log record was last modified, typically when feedback or outcome data is appended.',
    `request_identifier` STRING COMMENT 'Unique UUID for this inference request enabling end-to-end traceability across distributed systems.',
    `risk_category` STRING COMMENT 'Categorical risk level derived from the risk score, used for clinical decision support alerting thresholds.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated clinical risk score output when the model produces a risk assessment (e.g., sepsis risk, fall risk, readmission risk). Classified as PHI.',
    `secondary_output_json` STRING COMMENT 'JSON-serialized secondary outputs from the model such as multi-class probabilities, NLP entity extractions, or care gap lists. Stored as string for Delta compatibility.',
    `serving_endpoint` STRING COMMENT 'The deployment endpoint or service URL that served this inference request, supporting infrastructure traceability.',
    `source_system` STRING COMMENT 'The originating clinical system that provided input data for this inference (e.g., Epic EHR, Cerner Millennium, Beaker LIS).',
    `top_contributing_features` STRING COMMENT 'JSON-serialized list of the top contributing features and their importance weights that drove this prediction, supporting model interpretability.',
    `trigger_source` STRING COMMENT 'The mechanism or event that initiated this model inference execution.',
    `use_case` STRING COMMENT 'The specific clinical or operational use case this inference supports (e.g., sepsis_early_warning, readmission_risk, care_gap_detection, clinical_documentation_improvement, medication_interaction).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the model inference was executed.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient whose data was used for the inference.',
    `model_id` BIGINT COMMENT 'Unique identifier of the AI/ML model used for inference.',
    `mlflow_run_id` STRING COMMENT 'MLflow run ID that tracks the experiment execution for reproducibility.',
    `input_features_hash` STRING COMMENT 'Hash of the input feature snapshot used for the inference to enable data lineage.',
    `risk_score_category` STRING COMMENT 'Categorical interpretation of the risk score.. Valid values are `low|moderate|high|critical`',
    `nlp_entities` STRING COMMENT 'JSON string of clinical entities extracted by NLP from unstructured text.',
    `prediction_label` STRING COMMENT 'Class label or outcome predicted by the model.',
    `prediction_probability` DECIMAL(18,2) COMMENT 'Probability associated with the predicted label.',
    `inference_duration_ms` STRING COMMENT 'Elapsed time in milliseconds for the inference to complete.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inference log record was first created.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inference log record.',
    CONSTRAINT pk_model_inference_log PRIMARY KEY(`model_inference_log_id`)
) COMMENT 'Table logging model inference events';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` (
    `feature_store_entity_id` BIGINT COMMENT 'Primary key for feature_store_entity',
    `contains_phi_flag` BOOLEAN COMMENT 'Indicates whether any feature in this entity contains Protected Health Information subject to HIPAA privacy and security rules.',
    `data_classification_level` STRING COMMENT 'Highest data classification level among features in this entity, driving access control policies and HIPAA compliance requirements.',
    `drift_detection_method` STRING COMMENT 'Statistical method used to detect distribution drift in features over time, critical for maintaining clinical AI model reliability.',
    `drift_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold value above which feature drift triggers an alert for model retraining evaluation (e.g., PSI > 0.2 indicates significant drift).',
    `effective_end_date` DATE COMMENT 'Date on which this version of the feature entity definition is superseded or retired. Null indicates the currently active version.',
    `effective_start_date` DATE COMMENT 'Date from which this version of the feature entity definition becomes active, supporting SCD Type 2 versioning of entity metadata.',
    `entity_type` STRING COMMENT 'Classification of the business object this entity represents, determining the primary key structure and join semantics for feature lookups. [ENUM-REF-CANDIDATE: patient|encounter|provider|medication|diagnosis|procedure|lab_result|claim|device|observation — promote to reference product]',
    `feature_count` STRING COMMENT 'Total number of features currently registered under this entity, reflecting the breadth of signals available for ML model consumption.',
    `feature_store_entity_code` STRING COMMENT 'Unique business code assigned to the feature store entity for programmatic reference across ML training and serving pipelines.',
    `feature_store_entity_description` STRING COMMENT 'Detailed business description of the feature store entity, explaining its clinical or operational purpose and intended use cases in AI/ML workflows.',
    `feature_store_entity_name` STRING COMMENT 'Human-readable name of the feature store entity, used for discovery and reference in ML pipelines and analytics workflows.',
    `feature_store_entity_status` STRING COMMENT 'Current lifecycle status of the feature store entity indicating whether it is available for use in production ML models and analytics.',
    `fhir_resource_type` STRING COMMENT 'Corresponding HL7 FHIR resource type that this feature entity maps to, enabling interoperability alignment and semantic consistency.',
    `hipaa_retention_days` STRING COMMENT 'Minimum number of days feature data must be retained per HIPAA and state medical record retention requirements before eligible for purging.',
    `last_drift_check_at` TIMESTAMP COMMENT 'Timestamp of the most recent feature drift analysis execution for this entity.',
    `last_materialized_at` TIMESTAMP COMMENT 'Timestamp of the most recent successful feature materialization run, used to monitor freshness and trigger alerts on stale data.',
    `liquid_clustering_keys` STRING COMMENT 'Comma-separated column names used for Delta Lake liquid clustering optimization, improving query performance for feature serving workloads.',
    `materialization_strategy` STRING COMMENT 'Method by which features are computed and written to the feature table — batch for scheduled pipelines, streaming for real-time, on_demand for inference-time computation.',
    `online_store_enabled_flag` BOOLEAN COMMENT 'Indicates whether this entity is published to an online feature store for low-latency real-time inference serving (e.g., clinical decision support at point of care).',
    `owner_team` STRING COMMENT 'Name of the data science or engineering team responsible for maintaining, validating, and governing this feature store entity.',
    `primary_key_columns` STRING COMMENT 'Comma-separated list of column names that form the primary key for this entity, used for point lookups during model inference (e.g., patient_id, encounter_id).',
    `refresh_frequency_minutes` STRING COMMENT 'Expected interval in minutes between feature materialization runs, defining the staleness tolerance for downstream ML models.',
    `rls_predicate_expression` STRING COMMENT 'SQL predicate expression applied as a row-level security filter in Unity Catalog, restricting feature access based on user attributes (e.g., care team membership).',
    `row_count` BIGINT COMMENT 'Approximate number of rows in the materialized feature table, indicating entity population size for capacity planning and cost estimation.',
    `scd_type` STRING COMMENT 'Slowly Changing Dimension strategy applied to this feature entity for historical tracking — Type 2 maintains full history required for point-in-time correctness in clinical AI.',
    `serving_endpoint_name` STRING COMMENT 'Name of the Databricks model serving endpoint or feature serving endpoint that exposes this entity for real-time lookups.',
    `source_catalog` STRING COMMENT 'Name of the Databricks Unity Catalog catalog where the underlying feature table is physically stored.',
    `source_schema` STRING COMMENT 'Name of the schema (database) within Unity Catalog containing the feature table for this entity.',
    `source_system` STRING COMMENT 'Primary operational system from which raw data for this feature entity originates (e.g., Epic EHR, Cerner Millennium, Beaker LIS).',
    `source_table` STRING COMMENT 'Fully qualified table name in Unity Catalog that stores the materialized features for this entity.',
    `steward_email` STRING COMMENT 'Email address of the designated data steward accountable for data quality and governance of this feature entity.',
    `tags_json` STRING COMMENT 'JSON-encoded key-value pairs representing Unity Catalog governance tags applied to this entity (e.g., domain, sensitivity, regulatory_framework).',
    `timestamp_key_column` STRING COMMENT 'Name of the timestamp column used for point-in-time lookups, enabling time-travel feature retrieval to prevent data leakage in training datasets.',
    `version_number` STRING COMMENT 'Current version number of the entity schema, incremented when features are added, removed, or their definitions change.',
    `feature_name` STRING COMMENT 'Human-readable name of the feature as used in model pipelines.',
    `feature_description` STRING COMMENT 'Detailed description of the feature purpose and semantics.',
    `feature_type` STRING COMMENT 'Category of the feature indicating the nature of its values.. Valid values are `numeric|categorical|binary|text|datetime|boolean`',
    `data_type` STRING COMMENT 'Spark SQL data type of the feature values.. Valid values are `int|bigint|float|double|decimal|string|boolean|date|timestamp`',
    `source_column` STRING COMMENT 'Column in the source table used to compute the feature.',
    `transformation_logic` STRING COMMENT 'SQL or code expression that transforms source data into the feature.',
    `feature_version` STRING COMMENT 'Version identifier for the feature definition, supporting SCD Type 2.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the feature is currently active for model consumption.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the feature.. Valid values are `draft|active|deprecated|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the feature definition was first created.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the feature definition.',
    `mlflow_run_id` STRING COMMENT 'Identifier of the MLflow run that generated or validated the feature.',
    `model_name` STRING COMMENT 'Name of the AI/ML model that consumes this feature.',
    `model_version` STRING COMMENT 'Version of the consuming model.',
    `risk_score_name` STRING COMMENT 'Name of the risk score associated with the feature, if applicable.',
    `risk_score_value` DOUBLE COMMENT 'Numeric value of the risk score produced by the feature.',
    `nlp_result` STRING COMMENT 'Extracted NLP information stored as JSON string.',
    `inference_timestamp` TIMESTAMP COMMENT 'Timestamp when the model inference using this feature was executed.',
    `retention_period_days` STRING COMMENT 'Number of days the feature record is retained per HIPAA retention policy.',
    `delta_table_properties` STRING COMMENT 'Key-value pairs for Delta Lake table properties (e.g., autoOptimize, ZORDER).',
    `unity_catalog_tags` STRING COMMENT 'Comma-separated list of Unity Catalog tags applied for governance.',
    `rls_predicate` STRING COMMENT 'SQL predicate defining row-level security for the feature.',
    `clustering_columns` STRING COMMENT 'Columns used for liquid clustering to improve query performance.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates if the feature contains PHI or other restricted data.',
    `data_quality_score` DOUBLE COMMENT 'Score (0-1) representing the quality of the underlying source data.',
    `documentation_url` STRING COMMENT 'Link to external documentation describing the feature.',
    `last_validated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent validation run for the feature.',
    CONSTRAINT pk_feature_store_entity PRIMARY KEY(`feature_store_entity_id`)
) COMMENT 'Table storing feature store entities';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` (
    `population_health_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_definition',
    `care_site_id` BIGINT COMMENT 'description',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_consent_policy. Business justification: Population health cohort definitions must reference governing consent policy to verify data use authorization before patient inclusion. Required for IRB compliance and HIPAA minimum necessary standard',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Population health cohorts are defined per health plan for HEDIS/STARS quality reporting and VBC program measurement. Plan-specific cohort definitions drive payer quality submissions.',
    `model_version_id` BIGINT COMMENT 'BIGINT',
    `clinician_id` BIGINT COMMENT 'BIGINT',
    `ai_cohort_definition_id` BIGINT COMMENT 'description',
    `population_cohort_definition_ai_cohort_definition_id` BIGINT COMMENT 'BIGINT',
    `quality_program_id` BIGINT COMMENT 'BIGINT',
    `research_clinical_trial_matching_eligibility_criteria_id` BIGINT COMMENT 'Foreign key linking to research_clinical_trial_matching.eligibility_criteria. Business justification: Research coordinators build population health cohorts mirroring trial eligibility criteria for automated patient recruitment. Links cohort definitions to the specific trial criteria they operationaliz',
    `cohort_description` STRING COMMENT 'STRING',
    `cohort_type` STRING COMMENT 'STRING',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `created_ts` TIMESTAMP COMMENT 'TIMESTAMP',
    `current_member_count` BIGINT COMMENT 'description',
    `definition_logic_json` STRING COMMENT 'STRING',
    `definition_type` STRING COMMENT 'STRING',
    `effective_end_date` DATE COMMENT 'DATE',
    `effective_start_date` DATE COMMENT 'DATE',
    `exclusion_criteria_json` STRING COMMENT 'STRING',
    `exclusion_criteria_sql` STRING COMMENT 'STRING',
    `inclusion_criteria_json` STRING COMMENT 'STRING',
    `inclusion_criteria_sql` STRING COMMENT 'STRING',
    `is_active` BOOLEAN COMMENT 'description',
    `last_refresh_at` TIMESTAMP COMMENT 'description',
    `last_refresh_ts` TIMESTAMP COMMENT 'TIMESTAMP',
    `population_health_cohort_definition_status` STRING COMMENT 'description',
    `refresh_frequency` STRING COMMENT 'description',
    `refresh_frequency_code` STRING COMMENT 'STRING',
    `rule_expression` STRING COMMENT 'description',
    `status_code` STRING COMMENT 'STRING',
    `target_population_size` BIGINT COMMENT 'BIGINT',
    `updated_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `updated_ts` TIMESTAMP COMMENT 'TIMESTAMP',
    `created_by` STRING COMMENT 'STRING',
    CONSTRAINT pk_population_health_cohort_definition PRIMARY KEY(`population_health_cohort_definition_id`)
) COMMENT 'Table defining dynamic population health cohorts.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` (
    `clinical_ai_population_health_cohort_membership_id` BIGINT COMMENT 'Primary key for population_health_cohort_membership',
    `ai_cohort_membership_id` BIGINT COMMENT 'BIGINT',
    `care_site_id` BIGINT COMMENT 'BIGINT',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'BIGINT',
    `clinical_ai_model_inference_log_id` BIGINT COMMENT 'BIGINT',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'description',
    `mpi_record_id` BIGINT COMMENT 'description',
    `population_health_cohort_definition_id` BIGINT COMMENT 'BIGINT',
    `population_mpi_record_id` BIGINT COMMENT 'BIGINT',
    `clinician_id` BIGINT COMMENT 'BIGINT',
    `created_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `created_ts` TIMESTAMP COMMENT 'TIMESTAMP',
    `current_risk_score` DECIMAL(18,2) COMMENT 'description',
    `entry_date` DATE COMMENT 'DATE',
    `entry_reason_code` STRING COMMENT 'STRING',
    `entry_ts` TIMESTAMP COMMENT 'description',
    `exclusion_reason_code` STRING COMMENT 'description',
    `exit_date` DATE COMMENT 'DATE',
    `exit_reason` STRING COMMENT 'description',
    `exit_reason_code` STRING COMMENT 'STRING',
    `exit_ts` TIMESTAMP COMMENT 'description',
    `inclusion_reason_code` STRING COMMENT 'description',
    `intervention_recommended_code` STRING COMMENT 'description',
    `is_active` BOOLEAN COMMENT 'description',
    `is_current` BOOLEAN COMMENT 'description',
    `last_evaluated_at` TIMESTAMP COMMENT 'description',
    `last_evaluated_ts` TIMESTAMP COMMENT 'TIMESTAMP',
    `membership_end_date` DATE COMMENT 'description',
    `membership_reason` STRING COMMENT 'description',
    `membership_start_date` DATE COMMENT 'description',
    `membership_status_code` STRING COMMENT 'STRING',
    `next_evaluation_date` DATE COMMENT 'description',
    `next_evaluation_ts` TIMESTAMP COMMENT 'description',
    `outreach_priority_rank` STRING COMMENT 'description',
    `outreach_status_code` STRING COMMENT 'description',
    `risk_score` DECIMAL(18,2) COMMENT 'DECIMAL(10,4)',
    `risk_score_at_entry` DECIMAL(18,2) COMMENT 'DECIMAL(10,4)',
    `risk_score_current` DECIMAL(18,2) COMMENT 'description',
    `risk_tier_code` STRING COMMENT 'STRING',
    `updated_at` TIMESTAMP COMMENT 'TIMESTAMP',
    `updated_ts` TIMESTAMP COMMENT 'TIMESTAMP',
    CONSTRAINT pk_clinical_ai_population_health_cohort_membership PRIMARY KEY(`clinical_ai_population_health_cohort_membership_id`)
) COMMENT 'Table tracking membership of patients in dynamic cohorts.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` (
    `clinical_ai_model_card_id` BIGINT COMMENT 'Primary key for clinical_ai_model_card',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Clinical AI model cards require a designated physician owner who validates clinical appropriateness and signs off on deployment. Required by healthcare AI governance frameworks and CDS oversight polic',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Each AI model must be governed under a specific compliance program (HIPAA for PHI-handling models, FDA for clinical decision support). Required for compliance reporting on which models fall under whic',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Organizations track AI model ownership by cost center for departmental IT spending reports, annual budget planning, and operational cost allocation. Required for AI governance financial accountability',
    `databricks_governance_delta_tblproperties4_id` BIGINT COMMENT 'Foreign key linking to metadata.delta_tblproperties. Business justification: Platform governance requires AI model storage tables to use approved Delta configurations (change data feed, optimize, vacuum) per Databricks lakehouse governance standards (VREQ-011).',
    `databricks_governance_rls_predicates_id` BIGINT COMMENT 'Foreign key linking to metadata.rls_predicates. Business justification: HIPAA minimum necessary standard requires AI model outputs to have approved row-level security predicates controlling clinician access to patient predictions.',
    `databricks_governance_uc_tag_definitions_id` BIGINT COMMENT 'Foreign key linking to metadata.uc_tag_definitions. Business justification: Unity Catalog governance requires AI models to use approved tag definitions for data classification, PHI labeling, and sensitivity tagging per Databricks healthcare governance patterns.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: FDA SaMD and HIPAA AI governance require named accountable employee for each deployed model. Tracks model ownership for audit, incident response, and regulatory submissions. Domain experts expect this',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: HIPAA requires documented retention policies for AI models processing PHI. Normalizes text annotation to governed reference table per VREQ-011 Databricks governance patterns.',
    `model_card_id` BIGINT COMMENT 'Unique surrogate key for the model card record.',
    `rls_predicate_id` BIGINT COMMENT 'Foreign key linking to uc_tags.rls_predicate. Business justification: Unity Catalog RLS predicates control PHI access to AI model inference outputs. Required for HIPAA minimum-necessary access control on model results tables.',
    `scd_configuration_id` BIGINT COMMENT 'Foreign key linking to delta_tblproperties.scd_configuration. Business justification: FDA SaMD and HIPAA regulations require each AI model to declare its change-tracking strategy (Type 1 vs Type 2). This FK formalizes which SCD configuration governs model card versioning for regulatory',
    `scd_type2_config_id` BIGINT COMMENT 'Foreign key linking to uc_tags.scd_type2_config. Business justification: SCD Type 2 configuration tracks how model card history is maintained for regulatory audit trails. FDA SaMD requires full version lineage of deployed models.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: AI model governance and FDA SaMD regulatory submissions require documenting the target clinical concept (e.g., sepsis, readmission diagnosis) each model predicts, using standardized SNOMED terminology',
    `clinical_ai_model_card_description` STRING COMMENT 'Detailed free‑text description of the model, its scope and limitations.',
    `compliance_framework` STRING COMMENT 'Regulatory framework(s) applicable to the model.. Valid values are `HIPAA|GDPR|HITECH|None`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the model card record was first created.',
    `data_quality_assessment_date` DATE COMMENT 'Date on which the data quality score was evaluated.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality rating for the models input dataset.',
    `delta_tblproperties_reference` BIGINT COMMENT 'Foreign key linking to uc_tags.delta_tblproperties. Business justification: Delta table properties (optimize, auto-compact) govern AI model backing tables. Centralizes Databricks lakehouse configuration per VREQ-011 governance patterns.',
    `inference_log_table` STRING COMMENT 'Qualified name of the table that logs model inference events.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the model card was last reviewed for accuracy.',
    `metric_timestamp` TIMESTAMP COMMENT 'Date‑time when the performance metric was calculated.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that produced the model version.',
    `model_card_status` STRING COMMENT 'Lifecycle status of the model card.. Valid values are `draft|published|archived`',
    `model_deployment_environment` STRING COMMENT 'Target environment where the model is deployed.. Valid values are `dev|test|prod`',
    `model_deployment_timestamp` TIMESTAMP COMMENT 'Date‑time when the model was deployed to the target environment.',
    `model_documentation_url` STRING COMMENT 'Link to the detailed model documentation or repository.',
    `model_input_schema` STRING COMMENT 'JSON representation of the models expected input schema.',
    `model_name` STRING COMMENT 'model_card',
    `model_output_schema` STRING COMMENT 'JSON representation of the models output schema.',
    `model_training_end_timestamp` TIMESTAMP COMMENT 'Date‑time when model training completed.',
    `model_training_start_timestamp` TIMESTAMP COMMENT 'Date‑time when model training began.',
    `model_type` STRING COMMENT 'Category of the models function.. Valid values are `risk_score|nlp|prediction|classification|regression`',
    `model_version` STRING COMMENT 'Version identifier for the model (e.g., semantic version).',
    `nlp_result_table` STRING COMMENT 'Qualified name of the table storing NLP extraction results produced by the model.',
    `owner_role` STRING COMMENT 'Organizational role responsible for the model (e.g., Data Science Lead).',
    `performance_metric_name` STRING COMMENT 'Name of the primary performance metric reported for the model.. Valid values are `accuracy|precision|recall|f1|auc|rmse`',
    `performance_metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the selected performance metric.',
    `purpose` STRING COMMENT 'Business purpose or clinical use‑case the model addresses.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the model received regulatory approval, if applicable.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory review for the model.. Valid values are `approved|pending|rejected|exempt`',
    `retention_policy` STRING COMMENT 'Policy governing how long model artifacts and logs are retained.. Valid values are `7_years|indefinite|custom`',
    `risk_score_name` STRING COMMENT 'Name of the clinical risk score generated by the model (e.g., readmission_risk).',
    `risk_score_timestamp` TIMESTAMP COMMENT 'Date‑time when the risk score was generated for a patient.',
    `risk_score_value` DECIMAL(18,2) COMMENT 'Numeric value of the risk score, typically expressed as a percentage.',
    `training_data_source` STRING COMMENT 'System or dataset name from which the models training data was drawn.',
    `training_data_version` STRING COMMENT 'Version identifier of the training dataset.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the model card.',
    `version_number` STRING COMMENT 'Sequential integer version of the model card.',
    CONSTRAINT pk_clinical_ai_model_card PRIMARY KEY(`clinical_ai_model_card_id`)
) COMMENT 'Table storing model cards for AI models.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` (
    `clinical_ai_bias_monitoring_id` BIGINT COMMENT 'Primary key for clinical_ai_bias_monitoring',
    `bias_monitoring_id` BIGINT COMMENT 'Unique identifier for the bias monitoring record.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CMS health equity mandates require site-level AI bias assessment to detect disparate model performance across facilities serving different demographic populations.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Identifier of the AI/ML model being evaluated for bias.',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: Bias assessments are version-specific - a model may exhibit different bias characteristics across versions. Adding model_version_id enables version-level bias tracking. Removing version STRING column ',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the bias assessment was performed.',
    `assessment_type` STRING COMMENT 'Category of bias assessment applied.. Valid values are `fairness|disparity|calibration`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bias monitoring record was first created.',
    `dataset_reference` BIGINT COMMENT 'Identifier of the dataset used for the bias assessment.',
    `metric_name` STRING COMMENT 'bias_monitoring. Valid values are `stat_parity_diff|equal_opportunity_diff|average_odds_diff|disparate_impact|false_positive_rate_diff|false_negative_rate_diff`',
    `metric_status` STRING COMMENT 'Result status of the metric compared to the threshold.. Valid values are `pass|fail|warning`',
    `metric_threshold` DECIMAL(18,2) COMMENT 'Acceptable threshold for the bias metric; used to determine pass/fail.',
    `metric_value` DECIMAL(18,2) COMMENT 'Calculated value of the bias metric.',
    `mlflow_run_reference` STRING COMMENT 'MLflow run ID that generated the model inference used in this assessment.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the bias assessment.',
    `protected_attribute` STRING COMMENT 'Protected characteristic evaluated for bias.. Valid values are `race|gender|age|ethnicity|disability|sexual_orientation`',
    `remediation_action` STRING COMMENT 'Description of any remediation taken to address identified bias.',
    `remediation_timestamp` TIMESTAMP COMMENT 'Date and time when remediation action was performed.',
    `source_system` STRING COMMENT 'System or tool that generated the bias assessment (e.g., MLflow, custom script).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bias monitoring record.',
    CONSTRAINT pk_clinical_ai_bias_monitoring PRIMARY KEY(`clinical_ai_bias_monitoring_id`)
) COMMENT 'Table tracking bias monitoring metrics for AI models.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` (
    `clinical_ai_fda_samd_id` BIGINT COMMENT 'Primary key for clinical_ai_fda_samd',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: FDA SaMD submissions document regulatory status of specific AI models. Linking to model_card connects regulatory artifacts to model governance documentation. Removing model_name as retrievable via JOI',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_submission. Business justification: FDA SaMD (Software as Medical Device) clearances require formal regulatory submissions tracked by compliance. Links AI device records to their official submission for 510(k)/De Novo/PMA tracking and p',
    `databricks_governance_hipaa_retention_annotations_id` BIGINT COMMENT 'Foreign key linking to metadata.hipaa_retention_annotations. Business justification: FDA SaMD regulatory submissions must demonstrate HIPAA-compliant data retention; linking to approved retention annotation ensures audit trail for 510(k)/De Novo submissions.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: FDA SaMD 510(k)/De Novo submissions require documenting interoperability standards (HL7 FHIR, CDA) the AI device uses for data input/output per FDA guidance on AI/ML-based SaMD.',
    `fda_samd_id` BIGINT COMMENT 'System-generated unique identifier for the FDA SAMD submission record.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FDA SaMD regulatory submissions require standardized clinical indication coding per FDA guidance for AI/ML devices. SNOMED CT provides the required coded representation for the devices intended clini',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: FDA clearances are granted for specific model versions. Linking to model_version enables version-level regulatory tracking. Removing model_version STRING as version details retrievable via JOIN.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose data contributed to the risk score (if applicable).',
    `vendor_id` BIGINT COMMENT 'Internal or external identifier for the manufacturer (e.g., NPI for organizations).',
    `artifact_uri` STRING COMMENT 'Location (URI) of the model artifact in the MLflow artifact store.',
    `clinical_ai_fda_samd_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `clinical_validation_status` STRING COMMENT 'Status of clinical validation activities for the AI model.. Valid values are `not_started|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `data_source` STRING COMMENT 'Origin of the training data used for the model (e.g., EHR, registry).',
    `data_version` STRING COMMENT 'Version tag of the dataset used for model training.',
    `delta_tblproperties` STRING COMMENT 'Key‑value pairs for Delta Lake table configuration (stored as JSON string).',
    `device_name` STRING COMMENT 'Commercial name of the medical device associated with the submission.',
    `device_udi` STRING COMMENT 'Global unique identifier for the device as defined by the UDI system.',
    `documentation_url` STRING COMMENT 'Link to external documentation or supporting files.',
    `indication` STRING COMMENT 'Intended clinical condition or disease the device addresses.',
    `intended_use` STRING COMMENT 'Statement of the devices intended medical purpose and use environment.',
    `manufacturer_name` STRING COMMENT 'Legal name of the device manufacturer.',
    `metric_units` STRING COMMENT 'Units of the performance metric (e.g., percentage).',
    `metric_value` DECIMAL(18,2) COMMENT 'Numeric result of the selected performance metric.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that generated the model artifact.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the submission.',
    `performance_metric` STRING COMMENT 'Metric used to evaluate model performance.. Valid values are `auc|accuracy|precision|recall|f1_score`',
    `regulatory_body` STRING COMMENT 'Regulatory authority overseeing the submission (e.g., FDA).',
    `retention_policy` STRING COMMENT 'Data retention policy applicable to the submission record.. Valid values are `5_years|10_years|indefinite`',
    `review_end_date` DATE COMMENT 'Date the regulatory review concluded (approval or decision).',
    `review_start_date` DATE COMMENT 'Date the regulatory review commenced.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score for the AI/ML component (0‑100 scale).',
    `submission_date` DATE COMMENT 'Date the submission was formally filed with the regulator.',
    `submission_number` STRING COMMENT 'External submission number assigned by the regulatory authority (e.g., 510(k) number).',
    `submission_type` STRING COMMENT 'Category of regulatory submission (e.g., 510(k), PMA).. Valid values are `510k|pma|de_novo|clearance|exempt`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `validation_dataset_reference` STRING COMMENT 'Identifier of the dataset used for model validation.',
    CONSTRAINT pk_clinical_ai_fda_samd PRIMARY KEY(`clinical_ai_fda_samd_id`)
) COMMENT 'Table storing FDA SAMD documentation for AI models.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` (
    `cohort_management_id` BIGINT COMMENT 'description',
    `care_site_id` BIGINT COMMENT 'description',
    `clinical_ai_model_card_id` BIGINT COMMENT 'description',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: Population health cohort definitions drive care interventions; HIPAA audit trails require tracking which employee created/modified cohort logic affecting patient outreach and treatment decisions.',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort.cohort_definition. Business justification: AI cohort management programs operate on and enrich standard population health cohort definitions. Care managers need to trace which base cohort definition an AI management program is augmenting for H',
    `quality_program_id` BIGINT COMMENT 'description',
    `vbp_program_id` BIGINT COMMENT 'description',
    `cohort_description` STRING COMMENT 'description',
    `cohort_management_status` STRING COMMENT 'description',
    `cohort_type` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `definition_logic` STRING COMMENT 'description',
    `exclusion_criteria_json` STRING COMMENT 'description',
    `inclusion_criteria_json` STRING COMMENT 'description',
    `is_dynamic` BOOLEAN COMMENT 'description',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'description',
    `member_count` BIGINT COMMENT 'description',
    `owning_program` STRING COMMENT 'description',
    `refresh_frequency` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_cohort_management PRIMARY KEY(`cohort_management_id`)
) COMMENT 'Table defining dynamic cohort criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` (
    `clinical_ai_population_health_cohort_id` BIGINT COMMENT 'Primary key for clinical_ai_population_health_cohort',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: clinical_ai_population_health_cohort has risk_model_algorithm, model_confidence_threshold, nlp_criteria_enabled — all AI-driven attributes. Linking to model_card connects this cohort to its governing ',
    `clinician_id` BIGINT COMMENT 'Provider or clinical leader responsible for the cohort definition, outcomes monitoring, and intervention strategy oversight.',
    `measure_set_id` BIGINT COMMENT 'Reference to the quality measure set (e.g., HEDIS, MIPS, CMS Star Rating) that this cohort supports as a denominator or numerator population.',
    `quality_program_id` BIGINT COMMENT 'Reference to the population health management program under which this cohort operates, such as chronic disease management or wellness initiatives.',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for cohort eligibility. Null indicates no upper age restriction.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for cohort eligibility. Null indicates no lower age restriction.',
    `approval_date` DATE COMMENT 'Date when the cohort definition received formal clinical governance approval for activation.',
    `approved_by` STRING COMMENT 'Name or identifier of the clinical governance committee or medical director who approved this cohort definition for production use.',
    `care_gap_category` STRING COMMENT 'Category of care gap this cohort is designed to identify and close, such as overdue screenings, missed follow-ups, medication non-adherence, or uncontrolled chronic conditions.',
    `clinical_ai_population_health_cohort_description` STRING COMMENT 'Detailed narrative description of the cohorts clinical purpose, target population characteristics, and intended use in population health programs.',
    `clinical_ai_population_health_cohort_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively being used for patient identification and outreach.',
    `clinical_domain` STRING COMMENT 'Primary clinical specialty or disease domain that the cohort addresses. [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|pulmonology|nephrology|behavioral_health|neurology|orthopedics|obstetrics|pediatrics — promote to reference product]',
    `cohort_code` STRING COMMENT 'Unique business code for the cohort used in system integrations, reporting, and cross-referencing with quality measure registries.',
    `cohort_name` STRING COMMENT 'Human-readable name identifying the cohort for clinical and operational use, such as Diabetic Patients with HbA1c > 9 or High-Risk Heart Failure Readmission.',
    `cohort_type` STRING COMMENT 'Classification of the cohort by its primary purpose, distinguishing between disease registries, risk stratification groups, quality measure denominators, care gap populations, research cohorts, and preventive care targets.',
    `continuous_enrollment_days` STRING COMMENT 'Minimum number of days of continuous health plan enrollment required for a patient to be eligible for cohort membership, per quality measure specifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cohort definition record was first created in the system.',
    `criteria_version` STRING COMMENT 'Semantic version number of the cohort criteria definition, enabling tracking of changes to inclusion/exclusion logic over time for auditability.',
    `data_source_systems` STRING COMMENT 'Clinical and administrative data systems contributing to cohort criteria evaluation, such as EHR, claims, pharmacy, lab, and HIE data feeds.',
    `effective_end_date` DATE COMMENT 'Date when this cohort definition expires or is retired. Null indicates an open-ended active cohort with no planned termination.',
    `effective_start_date` DATE COMMENT 'Date when this cohort definition becomes active and begins identifying eligible patients for population health interventions.',
    `estimated_member_count` STRING COMMENT 'Approximate number of patients currently meeting the cohort criteria as of the last refresh, used for resource planning and program capacity management.',
    `exclusion_criteria_logic` STRING COMMENT 'Structured expression or CQL defining the exclusion criteria that remove patients from cohort membership, such as hospice enrollment, terminal diagnosis, or age limits.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for the cohort. All indicates no gender restriction; specific values limit cohort to gender-specific conditions (e.g., cervical cancer screening).',
    `hipaa_minimum_necessary` BOOLEAN COMMENT 'Confirms that the cohort criteria and resulting patient lists comply with HIPAA minimum necessary standard, limiting PHI exposure to what is required for the stated purpose.',
    `inclusion_criteria_logic` STRING COMMENT 'Structured expression or CQL (Clinical Quality Language) defining the inclusion criteria for patient membership in this cohort, including diagnosis codes, lab values, demographics, and utilization patterns.',
    `intervention_type` STRING COMMENT 'Primary type of clinical intervention or outreach recommended for patients in this cohort, guiding care coordination workflows.',
    `irb_approval_number` STRING COMMENT 'IRB protocol number if this cohort is used for research purposes, ensuring human subjects protection compliance.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this cohort is mandated by regulatory or accreditation requirements (CMS, TJC, state health department) versus being internally defined for quality improvement.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the cohort membership was last recalculated, enabling monitoring of data currency and staleness.',
    `lookback_period_days` STRING COMMENT 'Number of days to look back in patient clinical history when evaluating cohort inclusion criteria, such as 365 days for annual measures or 730 days for chronic condition identification.',
    `model_confidence_threshold` DECIMAL(18,2) COMMENT 'Minimum confidence score from the AI/ML model output required for a patient to be included in the cohort, ensuring prediction quality meets clinical standards.',
    `nlp_criteria_enabled` BOOLEAN COMMENT 'Indicates whether natural language processing of unstructured clinical notes is used as part of the cohort identification criteria.',
    `outcome_measure_definition` STRING COMMENT 'Definition of the primary clinical or operational outcome being measured for this cohort, such as readmission rate reduction, HbA1c control, or ED utilization decrease.',
    `owning_department` STRING COMMENT 'Clinical or operational department responsible for managing this cohort and its associated population health interventions.',
    `payer_alignment` STRING COMMENT 'Payer programs or value-based contracts that this cohort aligns with, such as Medicare Advantage Star Ratings, Medicaid managed care, or commercial ACO arrangements.',
    `priority_level` STRING COMMENT 'Organizational priority assigned to this cohort for resource allocation, outreach sequencing, and care management staffing decisions.',
    `refresh_frequency` STRING COMMENT 'How frequently the cohort membership is recalculated based on updated clinical data, ensuring patients are dynamically added or removed as their conditions change.',
    `regulatory_program_reference` STRING COMMENT 'Specific regulatory program or mandate requiring this cohort, such as MIPS measure ID, HEDIS measure code, or state reporting requirement identifier.',
    `reporting_period_end` DATE COMMENT 'End date of the measurement or reporting period for cohort evaluation and quality measure calculation.',
    `reporting_period_start` DATE COMMENT 'Start date of the measurement or reporting period during which cohort membership and outcomes are evaluated.',
    `risk_model_algorithm` STRING COMMENT 'Name or identifier of the AI/ML risk stratification algorithm used to score or segment patients within this cohort, such as Johns Hopkins ACG, HCC, or proprietary models.',
    `risk_score_threshold_max` DECIMAL(18,2) COMMENT 'Upper bound of the risk score range for cohort inclusion. Null indicates no upper limit (open-ended high-risk capture).',
    `risk_score_threshold_min` DECIMAL(18,2) COMMENT 'Lower bound of the risk score range that qualifies patients for inclusion in this cohort when risk stratification is part of the criteria.',
    `sdoh_factors_included` STRING COMMENT 'Social determinants of health factors incorporated into cohort criteria, such as food insecurity, housing instability, transportation barriers, or health literacy levels.',
    `target_condition_icd10_codes` STRING COMMENT 'Comma-separated list of ICD-10-CM diagnosis codes that define the primary clinical conditions targeted by this cohort for disease registry or quality measure purposes.',
    `target_medication_classes` STRING COMMENT 'Therapeutic drug classes relevant to the cohort criteria, used to identify patients on specific medication regimens (e.g., insulin, ACE inhibitors, statins).',
    `target_outcome_value` DECIMAL(18,2) COMMENT 'Quantitative target for the cohorts primary outcome measure, such as a target readmission rate of 12% or HbA1c below 8.0.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this cohort definition record was last modified, enabling change tracking and audit compliance.',
    CONSTRAINT pk_clinical_ai_population_health_cohort PRIMARY KEY(`clinical_ai_population_health_cohort_id`)
) COMMENT 'Table defining dynamic cohort criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`governance` (
    `governance_id` BIGINT COMMENT 'description',
    `clinical_ai_model_card_id` BIGINT COMMENT 'description',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: AI governance frameworks must operate under a formal compliance program (HIPAA, FDA). Healthcare compliance officers need to track which program oversees each AI governance policy for regulatory repor',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_consent_policy. Business justification: AI governance frameworks must align with consent policies to ensure models only process data for which valid patient consent exists. Required for HIPAA compliance audits and AI transparency regulation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: Healthcare AI governance frameworks (ONC, CMS) require named responsible party for each governance policy. Enables compliance reporting and accountability chain for clinical AI oversight.',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: AI governance records (audit trails, policy documents) have HIPAA-mandated retention periods. Links governance scope to specific retention/destruction policy.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Healthcare AI governance requires a named physician champion (CMIO/clinical informatics lead) accountable for clinical AI oversight per FDA SaMD guidance and ONC regulations. Audit trails require this',
    `rls_predicate_id` BIGINT COMMENT 'Foreign key linking to uc_tags.rls_predicate. Business justification: AI governance policies define which RLS predicate enforces access control on governed AI outputs. Required for Unity Catalog policy-based access to clinical AI results.',
    `audit_trail_retention_days` STRING COMMENT 'description',
    `clinician_override_policy` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `fda_regulatory_pathway` STRING COMMENT 'description',
    `governance_scope` STRING COMMENT 'description',
    `governance_status` STRING COMMENT 'description',
    `hipaa_compliance_flag` BOOLEAN COMMENT 'description',
    `last_review_date` DATE COMMENT 'description',
    `next_review_date` DATE COMMENT 'description',
    `patient_notification_required` BOOLEAN COMMENT 'description',
    `policy_document_url` STRING COMMENT 'description',
    `review_cadence_days` STRING COMMENT 'description',
    `risk_tier` STRING COMMENT 'description',
    `transparency_requirements` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_governance PRIMARY KEY(`governance_id`)
) COMMENT 'Table storing model cards describing model provenance and performance.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` (
    `clinical_ai_cohort_membership_id` BIGINT COMMENT 'Primary key for clinical_ai_cohort_membership',
    `ai_cohort_definition_id` BIGINT COMMENT 'Identifier of the clinical AI cohort to which the patient belongs. References the cohort definition containing inclusion/exclusion criteria.',
    `care_program_id` BIGINT COMMENT 'Identifier of the care management program associated with this cohort membership, linking to population health or disease management initiatives.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider responsible for managing the patient within this cohort, typically the primary care physician or care coordinator.',
    `clinical_override_provider_clinician_id` BIGINT COMMENT 'Identifier of the provider who performed the manual override of the AI-generated cohort membership decision.',
    `clinical_ai_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_cohort_definition. Business justification: clinical_ai_cohort_membership has a cohort_id BIGINT column with no FK. This links membership records to their cohort definition. A membership record belongs to exactly one cohort definition.',
    `consent_record_id` BIGINT COMMENT 'Identifier of the formal consent record documenting the patients agreement to participate in the AI cohort.',
    `model_version_id` BIGINT COMMENT 'Identifier of the specific AI/ML model version that generated the inclusion score or determined cohort membership.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who is a member of the cohort. Links to the master patient record.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter that triggered or is associated with the cohort membership assignment, if applicable.',
    `cohort_entry_event_type` STRING COMMENT 'Type of clinical event that triggered cohort entry, such as diagnosis, lab result, admission, or risk score change.',
    `criteria_match_count` STRING COMMENT 'Number of cohort inclusion criteria that the patient currently satisfies, used to assess strength of cohort fit.',
    `criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined for the cohort at the time of the patients enrollment or last evaluation.',
    `data_source_system` STRING COMMENT 'Name of the operational system or AI platform that generated or contributed to this cohort membership determination (e.g., Epic Healthy Planet, custom ML pipeline).',
    `disenrollment_date` DATE COMMENT 'Date on which the patient was removed or disenrolled from the cohort. Null if membership is still active.',
    `disenrollment_reason` STRING COMMENT 'Reason for the patients removal from the cohort, such as criteria no longer met, patient opt-out, death, or transfer of care.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking when this cohort membership record ceased to be the current version. Null for the current active record. Supports SCD Type 2 historization.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking when this cohort membership record became effective, supporting SCD Type 2 historization.',
    `enrollment_date` DATE COMMENT 'Date on which the patient was enrolled or added to the cohort, representing the start of their membership period.',
    `enrollment_method` STRING COMMENT 'Method by which the patient was enrolled into the cohort, distinguishing between automated AI-driven selection and manual clinical assignment.',
    `enrollment_reason` STRING COMMENT 'Clinical or algorithmic reason for the patients enrollment in the cohort, such as diagnosis match, risk score elevation, or care gap identification.',
    `evaluation_frequency_days` STRING COMMENT 'Number of days between scheduled re-evaluations of the patients cohort membership eligibility.',
    `exclusion_flag` BOOLEAN COMMENT 'Indicates whether the patient has triggered any exclusion criteria that may warrant removal from the cohort.',
    `exclusion_reason_code` STRING COMMENT 'Coded reason for exclusion if the patient has been flagged or removed due to meeting exclusion criteria.',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which this record may be purged per HIPAA minimum necessary retention requirements and organizational data governance policy.',
    `inclusion_score` DECIMAL(18,2) COMMENT 'AI/ML model-generated probability score (0.0000 to 1.0000) indicating the confidence that the patient meets cohort inclusion criteria.',
    `inclusion_score_threshold` DECIMAL(18,2) COMMENT 'The minimum score threshold that was applied at the time of enrollment to determine cohort eligibility.',
    `intervention_eligible` BOOLEAN COMMENT 'Indicates whether the patient is currently eligible for clinical interventions associated with this cohort.',
    `is_consent_obtained` BOOLEAN COMMENT 'Indicates whether patient consent has been obtained for inclusion in this AI-driven cohort, as required by institutional policy and applicable regulations.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this is the current (most recent) version of the cohort membership record in an SCD Type 2 pattern.',
    `is_manually_overridden` BOOLEAN COMMENT 'Indicates whether a clinician or administrator manually overrode the AI-generated cohort membership decision.',
    `last_evaluation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent re-evaluation of the patients eligibility for continued cohort membership.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent outreach attempt to the patient related to this cohort membership.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the patients membership in the cohort, reflecting whether they currently qualify and are actively included.',
    `membership_type` STRING COMMENT 'Classification of the patients role within the cohort, distinguishing between primary study/intervention members, control group members, and comparison populations.',
    `next_evaluation_date` DATE COMMENT 'Date when the patients cohort membership eligibility is next scheduled for re-evaluation.',
    `outreach_status` STRING COMMENT 'Current status of care team outreach to the patient as part of cohort-driven population health management activities.',
    `override_reason` STRING COMMENT 'Free-text or coded explanation provided by the clinician when manually overriding the AI cohort membership determination.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the patients priority within the cohort for intervention or outreach, with lower numbers indicating higher priority.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort membership record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this cohort membership record.',
    `risk_stratification_level` STRING COMMENT 'Risk tier assigned to the patient within the cohort context, used for population health management and care prioritization.',
    CONSTRAINT pk_clinical_ai_cohort_membership PRIMARY KEY(`clinical_ai_cohort_membership_id`)
) COMMENT 'Table tracking patient membership in cohorts.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` (
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Primary key for clinical_ai_patient_risk_score',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Risk scores contextualized to generating facility enable site-level acuity dashboards, capacity planning, and population health resource allocation decisions per care site.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: Patient risk scores are generated by AI models. Linking to model_card provides governance traceability. Removing model_name STRING as it is retrievable via JOIN to model_card (which has model_name att',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: FDA SaMD traceability: when a risk score incorporates a specific genomic test result (e.g., polygenic risk score), regulatory compliance requires linking the prediction to the source genomic evidence.',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to genomics.patient_genomic_profile. Business justification: Genomic-informed risk stratification: hereditary cancer risk, pharmacogenomic variants, and polygenic risk scores from genomic profiles are key features in AI risk models. Required for precision medic',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: Each risk score is produced by a specific model version for auditability and reproducibility. Removing model_version STRING column as version details are retrievable via JOIN to model_version table.',
    `mpi_record_id` BIGINT COMMENT 'Unique medical record number that identifies the patient for whom the risk score is calculated.',
    `patient_risk_score_id` BIGINT COMMENT 'System-generated unique identifier for each risk score record.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Clinical decision support computes risk scores (sepsis, deterioration, readmission) in context of a specific encounter. CMS quality programs and Joint Commission require traceability of AI-assisted cl',
    `confidence_score` DOUBLE COMMENT 'Probability that the models prediction is correct, expressed as a value between 0 and 1.',
    `delta_tblproperties` STRING COMMENT 'delta.enableChangeDataFeed = true',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the AI model generated the risk score.',
    `feature_set_version` STRING COMMENT 'Version identifier of the feature set used for the model inference.',
    `hipaa_retention_annotation` STRING COMMENT 'description',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that executed the inference.',
    `notes` STRING COMMENT 'Free‑text field for any additional context or reviewer comments about the score.',
    `prediction_date` DATE COMMENT 'Calendar date (without time) on which the risk score applies.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this risk score record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record (e.g., after re‑scoring).',
    `risk_score` DOUBLE COMMENT 'risk_score',
    `risk_score_category` STRING COMMENT 'Categorical risk band derived from the numeric score for clinical decision support.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating clinical system that supplied the input data for the model (e.g., Epic, Cerner, or custom).. Valid values are `epic|cerner|custom`',
    `unity_catalog_tags` STRING COMMENT 'description',
    CONSTRAINT pk_clinical_ai_patient_risk_score PRIMARY KEY(`clinical_ai_patient_risk_score_id`)
) COMMENT 'Patient-level risk score generated by clinical AI models, captured per model run with timestamp, score value, model version, and patient identifier.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` (
    `clinical_ai_clinical_nlp_result_id` BIGINT COMMENT 'Primary key for clinical_ai_clinical_nlp_result',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: NLP extraction on HIE-received CDA documents requires provenance tracking. Clinical data lineage audits and AI explainability regulations demand tracing extracted concepts back to the source exchanged',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: NLP extraction results are produced by AI models documented in model_card. Linking provides governance and lineage traceability. Removing model_name STRING as retrievable via JOIN.',
    `clinical_finding_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_finding. Business justification: NLP extracts clinical findings from notes into structured records. Linking enables provenance tracking for auto-generated findings, required for FDA SaMD transparency and clinician review.',
    `clinical_nlp_result_id` BIGINT COMMENT 'Surrogate primary key for each NLP extraction record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who authored the source clinical note.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: CDI programs use NLP to identify undocumented diagnoses. Linking NLP results to confirmed diagnoses enables CDI query validation and NLP model accuracy measurement.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose clinical note was processed.',
    `note_id` BIGINT COMMENT 'Unique identifier of the source clinical note document.',
    `pathology_report_id` BIGINT COMMENT 'Foreign key linking to laboratory.pathology_report. Business justification: Clinical NLP pipelines extract structured findings (cancer staging, biomarkers, diagnoses) from unstructured pathology report narratives. This is a core NLP use case in anatomic pathology workflows an',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: NLP-extracted conditions reconcile against the problem list. Business process: automated problem list reconciliation and completeness auditing per Joint Commission requirements.',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report.BIGINT surrogate key for clean keying. Business justification: NLP models extract structured concepts (findings, measurements, follow-up recommendations) from radiology report free text. Required for AI-assisted radiology workflow, incidental finding detection, a',
    `observation_id` BIGINT COMMENT 'Foreign key linking to clinical.observation. Business justification: NLP pipeline creates structured observations from unstructured text. Data lineage governance requires tracing which observation was auto-generated from which NLP extraction.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: NLP pipelines extract SNOMED-coded clinical concepts from notes. Linking to reference terminology validates extracted entities against the ontology for downstream CDS, quality reporting, and interoper',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the source note.',
    `annotation_reference` BIGINT COMMENT 'Identifier for the annotation within the note (if multiple per note).',
    `certainty` STRING COMMENT 'Certainty level of the extracted concept.. Valid values are `certain|probable|possible|unknown`',
    `clinical_ai_clinical_nlp_result_status` STRING COMMENT 'Current lifecycle status of the NLP result record.. Valid values are `active|inactive|archived`',
    `concept_code` STRING COMMENT 'Standardized clinical concept code extracted.',
    `concept_display` STRING COMMENT 'Human-readable name of the extracted concept.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Model confidence (0.0 to 1.0) for the extracted concept.',
    `created_timestamp` TIMESTAMP COMMENT 'When the record was first inserted.',
    `document_version` STRING COMMENT 'Version identifier of the source clinical document.',
    `extraction_method` STRING COMMENT 'Technique used for extraction.. Valid values are `rule_based|machine_learning|deep_learning|hybrid`',
    `extraction_timestamp` TIMESTAMP COMMENT 'Date and time when the NLP extraction was performed.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates if the extracted concept is considered sensitive PHI.',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the source note.. Valid values are `en|es|fr|de|zh|ar`',
    `mlflow_run_reference` STRING COMMENT 'Identifier of the MLflow run that generated this NLP result.',
    `model_version` STRING COMMENT 'Version of the NLP model.',
    `negation_flag` BOOLEAN COMMENT 'Indicates if the concept is negated in the source text.',
    `processing_time_ms` STRING COMMENT 'Time in milliseconds taken to process the note.',
    `related_concept_codes` STRING COMMENT 'Comma-separated list of related concept codes linked to this extraction.',
    `source_note_type` STRING COMMENT 'Category of the source clinical document.. Valid values are `progress_note|discharge_summary|consult_note|procedure_note|radiology_report`',
    `source_system` STRING COMMENT 'EHR system that provided the source note.. Valid values are `epic|cerner|meditech|custom`',
    `source_text_snippet` STRING COMMENT 'Excerpt of the source note containing the concept.',
    `temporality` STRING COMMENT 'Temporal context of the concept.. Valid values are `past|present|future|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'When the record was last modified.',
    CONSTRAINT pk_clinical_ai_clinical_nlp_result PRIMARY KEY(`clinical_ai_clinical_nlp_result_id`)
) COMMENT 'Results of clinical natural language processing on provider notes, storing extracted concepts, confidence scores, source note reference, and processing timestamp.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` (
    `clinical_ai_care_gap_id` BIGINT COMMENT 'Primary key for clinical_ai_care_gap',
    `care_gap_id` BIGINT COMMENT 'System-generated unique identifier for each care gap record.',
    `care_plan_goal_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan_goal. Business justification: Care gaps map to unmet care plan goals. Quality programs require tracking which specific goal is unmet when a gap is detected, enabling targeted clinician intervention workflows.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: Care gap closure workflow requires linking detected gaps to the patients active care plan. Quality teams track gap resolution within care plan context for HEDIS/Stars reporting.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Care gaps must be attributed to specific facilities for HEDIS quality measure reporting, value-based care program performance tracking, and site-level gap closure workflows.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: Care gaps are identified by AI models. Linking to model_card provides model governance traceability. Removing model_name STRING as it is available via JOIN to model_card.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: Care gap closure workflow: when AI detects a gap (missed screening, overdue vaccination), a clinical order is placed to resolve it. Tracking which order closes which gap is essential for quality repor',
    `employee_id` BIGINT COMMENT 'Identifier of the clinician or staff member who resolved the care gap.',
    `observation_id` BIGINT COMMENT 'Foreign key linking to clinical.observation. Business justification: Care gaps require clinical evidence (e.g., last HbA1c observation proving diabetes management gap). Links gap to the specific observation that triggered or evidences the gap for audit.',
    `follow_up_id` BIGINT COMMENT 'Foreign key linking to radiology.follow_up. Business justification: AI-detected care gaps for missed radiology follow-ups (e.g., lung nodule surveillance CT not completed) must reference the specific radiology recommendation. Critical patient safety closing the loop',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: HEDIS/quality measure care gap detection requires standardized clinical concept coding to align detected gaps with measure specifications and enable cross-system interoperability for gap closure workf',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to genomics.patient_genomic_profile. Business justification: Precision oncology care gap detection: AI identifies gaps based on genomic profile (e.g., BRCA+ patient missing recommended prophylactic interventions). Links gap to the genomic evidence triggering it',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Care gaps are plan-specific for HEDIS/STARS quality measure reporting. Payers define which gaps apply to their members; plan-level filtering is required for quality submissions and VBC incentive calcu',
    `laboratory_test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result.BIGINT surrogate key for clean keying. Business justification: Care gap detection/closure references the most recent qualifying lab result (e.g., last HbA1c for diabetes screening gap). Quality programs and HEDIS measures require linking gaps to evidence lab resu',
    `mpi_record_id` BIGINT COMMENT 'Surrogate key referencing the patient for whom the care gap was identified.',
    `population_health_dynamic_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health.dynamic_cohort_definition. Business justification: Population health programs define cohorts then identify care gaps within them. Tracking which cohort analysis detected a care gap enables program effectiveness reporting and gap closure workflows requ',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Care gaps are condition-specific (e.g., diabetes A1c gap). Linking to the problem list entry enables problem-oriented gap tracking for population health and quality measure reporting.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Care gap closure workflows identify the specific billable procedure (CPT) that resolves the gap, enabling automated order suggestions, scheduling integration, and reimbursement tracking for value-base',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Value-based care programs assign each care gap (missed screening, overdue lab) to a responsible clinician accountable for closure. HEDIS/Stars quality reporting requires clinician-level gap attributio',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_program. Business justification: Care gap closure workflows recommend specific RPM programs as interventions (e.g., hypertension gap → BP monitoring program). Population health teams track which RPM program addresses each gap for out',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Care gaps specify which lab test is needed to close the gap (e.g., needs HbA1c test). Operationalizing gap closure requires knowing the exact test_catalog entry to order, supporting automated order ',
    `care_gap_category` STRING COMMENT 'Higher‑level classification of the gap (e.g., preventive, diagnostic).. Valid values are `preventive|diagnostic|therapeutic|educational`',
    `clinical_ai_care_gap_status` STRING COMMENT 'Current lifecycle status of the care gap.. Valid values are `identified|in_progress|resolved|closed|dismissed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care gap record was first created in the data lake.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the care gap was first identified by the AI model.',
    `gap_severity` STRING COMMENT 'Clinical severity rating of the identified care gap.. Valid values are `low|moderate|high|critical`',
    `gap_type` STRING COMMENT 'Category of the care gap (e.g., medication adherence, preventive screening).. Valid values are `medication|screening|follow_up|lifestyle|vaccination`',
    `intervention_due_date` DATE COMMENT 'Target date by which the recommended intervention should be completed.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the care gap is flagged as critical for immediate action.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that produced the prediction, enabling traceability.',
    `notes` STRING COMMENT 'Free‑text field for clinicians to add contextual comments or observations.',
    `priority_level` STRING COMMENT 'Operational priority assigned to the care gap for scheduling interventions.. Valid values are `low|medium|high|urgent`',
    `recommendation` STRING COMMENT 'Suggested clinical intervention or action to address the gap.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the care gap was resolved or closed, if applicable.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0.00‑100.00) indicating the likelihood of adverse outcome if the gap remains unaddressed.',
    `source_system` STRING COMMENT 'Originating system or pipeline that supplied the raw data for the AI inference.. Valid values are `epic|cerner|custom_ai`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the care gap record.',
    CONSTRAINT pk_clinical_ai_care_gap PRIMARY KEY(`clinical_ai_care_gap_id`)
) COMMENT 'Identified care gaps for a patient based on AI predictions, including gap type, severity, recommended intervention, and resolution status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` (
    `clinical_ai_model_inference_log_id` BIGINT COMMENT 'Primary key for clinical_ai_model_inference_log',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: AI inference results must be tracked per facility for site-level model performance dashboards, drift detection, and CMS-required AI transparency reporting across care sites.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim.BIGINT surrogate key for clean keying. Business justification: Claim-level AI models (fraud detection, denial prediction, coding accuracy) generate inferences per claim. Payer SIU and revenue cycle teams require tracing which inference scored which claim for audi',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Unique identifier of the AI/ML model used for inference.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: AI explainability and FDA SaMD audit: when a model inference (e.g., sepsis prediction) triggers a clinical order, the inference-to-order linkage is required for clinical decision support governance, o',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to genomics.patient_genomic_profile. Business justification: AI explainability and reproducibility: inference logs must trace which genomic profile version was used as input for genomic-informed predictions, required for FDA SaMD audit trails and clinical valid',
    `model_inference_log_id` BIGINT COMMENT 'Unique surrogate key for each model inference event record.',
    `model_version_id` BIGINT COMMENT 'model_version_id',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose data was used for the inference.',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report.BIGINT surrogate key for clean keying. Business justification: AI models (PE detection, chest X-ray triage, mammography CAD) run inference on radiology reports/images. Inference log must reference the analyzed report for FDA SaMD post-market surveillance and clin',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: AI model inferences (readmission prediction at discharge, sepsis alert in ED) execute during specific visits. FDA SaMD audit trails and clinical governance require linking each inference to the encoun',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inference log record was first created.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the model inference was executed.',
    `inference_duration_ms` STRING COMMENT 'Elapsed time in milliseconds for the inference to complete.',
    `inference_status` STRING COMMENT 'Result status of the inference execution.. Valid values are `success|failure|partial`',
    `input_features_hash` STRING COMMENT 'Hash of the input feature snapshot used for the inference to enable data lineage.',
    `mlflow_run_reference` STRING COMMENT 'MLflow run ID that tracks the experiment execution for reproducibility.',
    `nlp_entities` STRING COMMENT 'JSON string of clinical entities extracted by NLP from unstructured text.',
    `prediction_label` STRING COMMENT 'Class label or outcome predicted by the model.',
    `prediction_probability` DECIMAL(18,2) COMMENT 'Probability associated with the predicted label.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score produced by the model indicating patient risk level.',
    `risk_score_category` STRING COMMENT 'Categorical interpretation of the risk score.. Valid values are `low|moderate|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inference log record.',
    CONSTRAINT pk_clinical_ai_model_inference_log PRIMARY KEY(`clinical_ai_model_inference_log_id`)
) COMMENT 'Log of each model inference event linking patient, model version, input feature snapshot, output score, and MLflow run ID for traceability.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` (
    `clinical_ai_feature_store_entity_id` BIGINT COMMENT 'Primary key for clinical_ai_feature_store_entity',
    `databricks_governance_delta_tblproperties4_id` BIGINT COMMENT 'Foreign key linking to uc_tags.delta_tblproperties. Business justification: Feature store backing Delta tables need governed properties (auto-optimize, Z-order). Normalizes text config to centralized Databricks table properties reference.',
    `databricks_governance_rls_predicates_id` BIGINT COMMENT 'Foreign key linking to metadata.rls_predicates. Business justification: Feature access control requires approved RLS predicates to restrict which teams/roles can access sensitive patient features (e.g., behavioral health, substance use) per HIPAA minimum necessary.',
    `databricks_governance_uc_tag_definitions_id` BIGINT COMMENT 'Foreign key linking to metadata.uc_tag_definitions. Business justification: Feature store governance requires each feature to reference approved Unity Catalog tag definitions for PHI classification, sensitivity labeling, and data lineage tracking.',
    `feature_store_entity_id` BIGINT COMMENT 'Unique surrogate identifier for the feature definition.',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: PHI-derived features must comply with HIPAA retention/destruction schedules. Links feature lifecycle to centralized retention policy for compliance audits.',
    `liquid_clustering_config_id` BIGINT COMMENT 'Foreign key linking to uc_tags.liquid_clustering_config. Business justification: Feature tables queried by patient_id/timestamp need liquid clustering. Centralizes clustering strategy with rationale and estimated improvement metrics.',
    `rls_predicate_id` BIGINT COMMENT 'Foreign key linking to uc_tags.rls_predicate. Business justification: Feature store entities derived from PHI (diagnoses, labs) require RLS predicates restricting access by role. HIPAA minimum-necessary principle for ML feature access.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the feature definition was first created.',
    `data_quality_score` DOUBLE COMMENT 'Score (0-1) representing the quality of the underlying source data.',
    `data_type` STRING COMMENT 'Spark SQL data type of the feature values. [ENUM-REF-CANDIDATE: int|bigint|float|double|decimal|string|boolean|date|timestamp — 9 candidates stripped; promote to reference product]',
    `documentation_url` STRING COMMENT 'Link to external documentation describing the feature.',
    `feature_description` STRING COMMENT 'Detailed description of the feature purpose and semantics.',
    `feature_name` STRING COMMENT 'Human-readable name of the feature as used in model pipelines.',
    `feature_set_reference` BIGINT COMMENT 'description',
    `feature_type` STRING COMMENT 'Category of the feature indicating the nature of its values.. Valid values are `numeric|categorical|binary|text|datetime|boolean`',
    `feature_version` STRING COMMENT 'Version identifier for the feature definition, supporting SCD Type 2.',
    `inference_timestamp` TIMESTAMP COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `is_active` BOOLEAN COMMENT 'Indicates whether the feature is currently active for model consumption.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates if the feature contains PHI or other restricted data.',
    `last_validated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent validation run for the feature.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the feature.. Valid values are `draft|active|deprecated|retired`',
    `mlflow_run_reference` STRING COMMENT 'Identifier of the MLflow run that generated or validated the feature.',
    `nlp_result` STRING COMMENT 'Extracted NLP information stored as JSON string.',
    `owner_team` STRING COMMENT 'Name of the data engineering or analytics team responsible for the feature.',
    `retention_period_days` STRING COMMENT 'Number of days the feature record is retained per HIPAA retention policy.',
    `risk_score_name` STRING COMMENT 'Name of the risk score associated with the feature, if applicable.',
    `risk_score_value` DOUBLE COMMENT 'Numeric value of the risk score produced by the feature.',
    `source_column` STRING COMMENT 'Column in the source table used to compute the feature.',
    `source_table` STRING COMMENT 'Name of the source table from which the feature is derived.',
    `transformation_logic` STRING COMMENT 'SQL or code expression that transforms source data into the feature.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the feature definition.',
    CONSTRAINT pk_clinical_ai_feature_store_entity PRIMARY KEY(`clinical_ai_feature_store_entity_id`)
) COMMENT 'Definition of a feature used in AI models, including feature name, data type, source table, transformation logic, and version.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`model_card` (
    `model_card_id` BIGINT COMMENT 'Primary key for model_card',
    `model_name` STRING COMMENT 'Human‑readable name of the AI/ML model.',
    `model_version` STRING COMMENT 'Version identifier for the model (e.g., semantic version).',
    `model_type` STRING COMMENT 'Category of the models function.. Valid values are `risk_score|nlp|prediction|classification|regression`',
    `purpose` STRING COMMENT 'Business purpose or clinical use‑case the model addresses.',
    `description` STRING COMMENT 'Detailed free‑text description of the model, its scope and limitations.',
    `owner_role` STRING COMMENT 'Organizational role responsible for the model (e.g., Data Science Lead).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the model card record was first created.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the model card.',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that produced the model version.',
    `risk_score_name` STRING COMMENT 'Name of the clinical risk score generated by the model (e.g., readmission_risk).',
    `risk_score_value` DECIMAL(18,2) COMMENT 'Numeric value of the risk score, typically expressed as a percentage.',
    `risk_score_timestamp` TIMESTAMP COMMENT 'Date‑time when the risk score was generated for a patient.',
    `nlp_result_table` STRING COMMENT 'Qualified name of the table storing NLP extraction results produced by the model.',
    `inference_log_table` STRING COMMENT 'Qualified name of the table that logs model inference events.',
    `training_data_source` STRING COMMENT 'System or dataset name from which the models training data was drawn.',
    `training_data_version` STRING COMMENT 'Version identifier of the training dataset.',
    `performance_metric_name` STRING COMMENT 'Name of the primary performance metric reported for the model.. Valid values are `accuracy|precision|recall|f1|auc|rmse`',
    `performance_metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the selected performance metric.',
    `metric_timestamp` TIMESTAMP COMMENT 'Date‑time when the performance metric was calculated.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory review for the model.. Valid values are `approved|pending|rejected|exempt`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the model received regulatory approval, if applicable.',
    `retention_policy` STRING COMMENT 'Policy governing how long model artifacts and logs are retained.. Valid values are `7_years|indefinite|custom`',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA‑specific retention requirements.',
    `unity_catalog_tags` STRING COMMENT 'Comma‑separated list of Databricks Unity Catalog tags applied to the table.',
    `rls_predicate` STRING COMMENT 'SQL predicate defining row‑level security for the model card table.',
    `scd_type` STRING COMMENT 'Indicates whether the table implements SCD Type 2, Type 1, or none.. Valid values are `type2|type1|none`',
    `delta_tblproperties` STRING COMMENT 'Key‑value pairs defining Delta Lake table properties.',
    `liquid_clustering` STRING COMMENT 'Specification for Databricks liquid clustering on the table.',
    `model_card_status` STRING COMMENT 'Lifecycle status of the model card.. Valid values are `draft|published|archived`',
    `version_number` STRING COMMENT 'Sequential integer version of the model card.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the model card was last reviewed for accuracy.',
    `compliance_framework` STRING COMMENT 'Regulatory framework(s) applicable to the model.. Valid values are `HIPAA|GDPR|HITECH|None`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality rating for the models input dataset.',
    `data_quality_assessment_date` DATE COMMENT 'Date on which the data quality score was evaluated.',
    `model_input_schema` STRING COMMENT 'JSON representation of the models expected input schema.',
    `model_output_schema` STRING COMMENT 'JSON representation of the models output schema.',
    `model_training_start_timestamp` TIMESTAMP COMMENT 'Date‑time when model training began.',
    `model_training_end_timestamp` TIMESTAMP COMMENT 'Date‑time when model training completed.',
    `model_deployment_environment` STRING COMMENT 'Target environment where the model is deployed.. Valid values are `dev|test|prod`',
    `model_deployment_timestamp` TIMESTAMP COMMENT 'Date‑time when the model was deployed to the target environment.',
    `model_owner_email` STRING COMMENT 'Email address of the model owner for notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `model_owner_phone` STRING COMMENT 'Contact phone number of the model owner.',
    `model_documentation_url` STRING COMMENT 'Link to the detailed model documentation or repository.',
    CONSTRAINT pk_model_card PRIMARY KEY(`model_card_id`)
) COMMENT 'Standardized documentation for an AI model covering purpose, architecture, training data, performance metrics, and intended use.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` (
    `bias_monitoring_id` BIGINT COMMENT 'Primary key for bias_monitoring',
    `model_id` BIGINT COMMENT 'Identifier of the AI/ML model being evaluated for bias.',
    `dataset_id` BIGINT COMMENT 'Identifier of the dataset used for the bias assessment.',
    `mlflow_run_id` STRING COMMENT 'MLflow run ID that generated the model inference used in this assessment.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the bias assessment was performed.',
    `assessment_type` STRING COMMENT 'Category of bias assessment applied.. Valid values are `fairness|disparity|calibration`',
    `protected_attribute` STRING COMMENT 'Protected characteristic evaluated for bias.. Valid values are `race|gender|age|ethnicity|disability|sexual_orientation`',
    `metric_name` STRING COMMENT 'Name of the bias metric calculated.. Valid values are `stat_parity_diff|equal_opportunity_diff|average_odds_diff|disparate_impact|false_positive_rate_diff|false_negative_rate_diff`',
    `metric_value` DECIMAL(18,2) COMMENT 'Calculated value of the bias metric.',
    `metric_threshold` DECIMAL(18,2) COMMENT 'Acceptable threshold for the bias metric; used to determine pass/fail.',
    `metric_status` STRING COMMENT 'Result status of the metric compared to the threshold.. Valid values are `pass|fail|warning`',
    `remediation_action` STRING COMMENT 'Description of any remediation taken to address identified bias.',
    `remediation_timestamp` TIMESTAMP COMMENT 'Date and time when remediation action was performed.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the bias assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bias monitoring record was first created.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bias monitoring record.',
    `source_system` STRING COMMENT 'System or tool that generated the bias assessment (e.g., MLflow, custom script).',
    `version` STRING COMMENT 'Version identifier for the bias assessment methodology or configuration.',
    CONSTRAINT pk_bias_monitoring PRIMARY KEY(`bias_monitoring_id`)
) COMMENT 'Recorded bias assessment metrics for AI models across protected attributes, with timestamps and remediation actions.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` (
    `fda_samd_id` BIGINT COMMENT 'Primary key for fda_samd',
    `submission_number` STRING COMMENT 'External submission number assigned by the regulatory authority (e.g., 510(k) number).',
    `submission_type` STRING COMMENT 'Category of regulatory submission (e.g., 510(k), PMA).. Valid values are `510k|pma|de_novo|clearance|exempt`',
    `device_name` STRING COMMENT 'Commercial name of the medical device associated with the submission.',
    `device_udi` STRING COMMENT 'Global unique identifier for the device as defined by the UDI system.',
    `manufacturer_name` STRING COMMENT 'Legal name of the device manufacturer.',
    `manufacturer_id` STRING COMMENT 'Internal or external identifier for the manufacturer (e.g., NPI for organizations).',
    `indication` STRING COMMENT 'Intended clinical condition or disease the device addresses.',
    `intended_use` STRING COMMENT 'Statement of the devices intended medical purpose and use environment.',
    `regulatory_body` STRING COMMENT 'Regulatory authority overseeing the submission (e.g., FDA).',
    `status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `submission_date` DATE COMMENT 'Date the submission was formally filed with the regulator.',
    `review_start_date` DATE COMMENT 'Date the regulatory review commenced.',
    `review_end_date` DATE COMMENT 'Date the regulatory review concluded (approval or decision).',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score for the AI/ML component (0‑100 scale).',
    `model_name` STRING COMMENT 'Descriptive name of the AI/ML model linked to the submission.',
    `model_version` STRING COMMENT 'Version identifier of the AI/ML model (e.g., v1.2.3).',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that generated the model artifact.',
    `artifact_uri` STRING COMMENT 'Location (URI) of the model artifact in the MLflow artifact store.',
    `data_source` STRING COMMENT 'Origin of the training data used for the model (e.g., EHR, registry).',
    `data_version` STRING COMMENT 'Version tag of the dataset used for model training.',
    `validation_dataset_id` STRING COMMENT 'Identifier of the dataset used for model validation.',
    `performance_metric` STRING COMMENT 'Metric used to evaluate model performance.. Valid values are `auc|accuracy|precision|recall|f1_score`',
    `metric_value` DECIMAL(18,2) COMMENT 'Numeric result of the selected performance metric.',
    `metric_units` STRING COMMENT 'Units of the performance metric (e.g., percentage).',
    `clinical_validation_status` STRING COMMENT 'Status of clinical validation activities for the AI model.. Valid values are `not_started|in_progress|completed|failed`',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the submission.',
    `documentation_url` STRING COMMENT 'Link to external documentation or supporting files.',
    `retention_policy` STRING COMMENT 'Data retention policy applicable to the submission record.. Valid values are `5_years|10_years|indefinite`',
    `delta_tblproperties` STRING COMMENT 'Key‑value pairs for Delta Lake table configuration (stored as JSON string).',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA‑required retention period for the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient whose data contributed to the risk score (if applicable).',
    CONSTRAINT pk_fda_samd PRIMARY KEY(`fda_samd_id`)
) COMMENT 'FDA Software as a Medical Device submission artifacts linked to AI models, including regulatory status and review dates.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` (
    `ai_cohort_definition_id` BIGINT COMMENT 'System-generated unique identifier for the cohort definition.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the cohort definition.',
    `primary_employee_id` BIGINT COMMENT 'Identifier of the user who last updated the cohort definition.',
    `ai_cohort_definition_description` STRING COMMENT 'Detailed description of the cohort purpose, inclusion/exclusion rationale, and clinical relevance.',
    `ai_cohort_definition_name` STRING COMMENT 'Human‑readable name of the cohort definition.',
    `ai_cohort_definition_status` STRING COMMENT 'Current lifecycle status of the cohort definition.. Valid values are `active|inactive|deprecated`',
    `cohort_category` STRING COMMENT 'High‑level classification of the cohort (e.g., high_risk_diabetes, post_surgery).',
    `cohort_code` STRING COMMENT 'Business-friendly code used to reference the cohort across systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the cohort definition was first created in the system.',
    `data_source` STRING COMMENT 'Primary clinical data source used to populate the cohort.. Valid values are `Epic|Cerner|Custom`',
    `estimated_patient_count` BIGINT COMMENT 'Projected number of unique patients that satisfy the cohort criteria.',
    `exclusion_criteria` STRING COMMENT 'Textual or JSON representation of the logical conditions that exclude patients from the cohort.',
    `inclusion_criteria` STRING COMMENT 'Textual or JSON representation of the logical conditions that include patients in the cohort.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Date‑time when the cohort definition was last evaluated against source data.',
    `logic_expression` STRING COMMENT 'Executable expression (e.g., SQL, DSL) that evaluates the inclusion/exclusion rules.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that generated the cohort definition or its scores.',
    `model_name` STRING COMMENT 'Name of the machine‑learning model used to compute risk scores for the cohort.',
    `model_version` STRING COMMENT 'Version string of the model referenced by model_name.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes related to the cohort definition.',
    `retention_policy` STRING COMMENT 'Governance rule defining how long cohort data is retained.. Valid values are `7_years|5_years|indefinite`',
    `risk_score_type` STRING COMMENT 'Type of risk score associated with the cohort (e.g., readmission, sepsis).',
    `risk_score_version` STRING COMMENT 'Version identifier of the risk‑score model used for this cohort.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the cohort definition.',
    `version` STRING COMMENT 'Incremental version number of the cohort definition; higher numbers indicate newer revisions.',
    `name` STRING COMMENT 'Human‑readable name of the cohort definition.',
    `description` STRING COMMENT 'Detailed description of the cohort purpose, inclusion/exclusion rationale, and clinical relevance.',
    `status` STRING COMMENT 'Current lifecycle status of the cohort definition.. Valid values are `active|inactive|deprecated`',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who created the cohort definition.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the user who last updated the cohort definition.',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that generated the cohort definition or its scores.',
    CONSTRAINT pk_ai_cohort_definition PRIMARY KEY(`ai_cohort_definition_id`)
) COMMENT 'Definition of a dynamic patient cohort used for population health AI, specifying inclusion criteria, logic expressions, and version.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` (
    `ai_cohort_membership_id` BIGINT COMMENT 'System-generated unique identifier for the AI cohort membership record.',
    `ai_cohort_definition_id` BIGINT COMMENT 'Unique identifier of the AI‑generated cohort definition.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Patient inclusion in AI-driven cohorts requires documented consent linkage per HIPAA research use provisions and 21st Century Cures Act. Enables consent withdrawal to cascade to cohort removal.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient who is a member of the AI‑defined cohort.',
    `ai_cohort_membership_status` STRING COMMENT 'Current lifecycle status of the cohort membership.. Valid values are `active|inactive|pending|expired|withdrawn`',
    `cohort_type` STRING COMMENT 'Category of the cohort indicating the clinical or population‑health focus.. Valid values are `risk|gap|outcome|utilization|readmission|mortality`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑1) reflecting the completeness and reliability of the source data used for the prediction.',
    `effective_end_date` DATE COMMENT 'Date on which the membership expires or is terminated (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the patient became an active member of the cohort.',
    `inclusion_reason` STRING COMMENT 'Narrative explanation why the patient was placed in the cohort (e.g., high risk score, specific diagnosis).',
    `inclusion_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) produced by the AI model that qualified the patient for inclusion.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether a clinician manually overrode the AI‑generated membership.',
    `membership_number` STRING COMMENT 'Human‑readable business identifier for the membership, used in reporting and audit trails.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that produced the prediction, enabling traceability.',
    `model_name` STRING COMMENT 'Descriptive name of the AI/ML model that generated the cohort assignment.',
    `model_version` STRING COMMENT 'Version identifier of the AI model (e.g., v1.2.3).',
    `notes` STRING COMMENT 'Free‑text field for additional context or reviewer comments.',
    `prediction_confidence` DECIMAL(18,2) COMMENT 'Confidence level (percentage) associated with the models prediction.',
    `prediction_timestamp` TIMESTAMP COMMENT 'Date‑time when the AI model generated the prediction used for cohort assignment.',
    `prediction_value` DECIMAL(18,2) COMMENT 'Raw output value from the model (e.g., probability, risk score).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the membership record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the membership record.',
    `source_system` STRING COMMENT 'Originating source system that supplied the patient data for the AI inference.. Valid values are `Epic|Cerner|Custom|Other`',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient who is a member of the AI‑defined cohort.',
    `cohort_id` BIGINT COMMENT 'Unique identifier of the AI‑generated cohort definition.',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that produced the prediction, enabling traceability.',
    `status` STRING COMMENT 'Current lifecycle status of the cohort membership.. Valid values are `active|inactive|pending|expired|withdrawn`',
    CONSTRAINT pk_ai_cohort_membership PRIMARY KEY(`ai_cohort_membership_id`)
) COMMENT 'Membership record linking patients to an AI-defined cohort with effective dates and inclusion reason.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`model_version` (
    `model_version_id` BIGINT COMMENT 'Unique surrogate key for each model version record.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Identifier of the parent AI model to which this version belongs.',
    `employee_id` BIGINT COMMENT 'Identifier of the data scientist or engineer who authored the version.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the reviewer who approved the version for release.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the version was formally approved.',
    `compliance_annotation` STRING COMMENT 'Annotations required for regulatory compliance (e.g., HIPAA, GDPR).',
    `compute_environment` STRING COMMENT 'Description of the hardware/cluster configuration used for training (e.g., "GPU‑V100‑4x").',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the version record was first created.',
    `data_split` STRING COMMENT 'Portion of data the model was trained on.. Valid values are `train|validation|test`',
    `delta_tblproperties` STRING COMMENT 'Key‑value string of Delta Lake table properties for governance (e.g., "quality=high").',
    `deprecation_timestamp` TIMESTAMP COMMENT 'Date‑time when the version was marked deprecated.',
    `evaluation_metric_name` STRING COMMENT 'Name of the primary performance metric (e.g., "AUC").',
    `evaluation_metric_timestamp` TIMESTAMP COMMENT 'Date‑time when the evaluation metric was recorded.',
    `evaluation_metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary performance metric.',
    `framework` STRING COMMENT 'Machine‑learning framework used to develop the model.. Valid values are `TensorFlow|PyTorch|Scikit-Learn|XGBoost|LightGBM`',
    `framework_version` STRING COMMENT 'Version of the ML framework (e.g., 2.4.1).',
    `hyperparameters` STRING COMMENT 'JSON string capturing all hyperparameter key‑value pairs used for training.',
    `input_features` STRING COMMENT 'JSON list of feature names and data types used as inputs.',
    `is_production` BOOLEAN COMMENT 'Indicates whether the version is currently deployed in production.',
    `mlflow_run_reference` STRING COMMENT 'Unique identifier of the MLflow run that produced this model version.',
    `model_type` STRING COMMENT 'High‑level category of the models function.. Valid values are `risk_score|nlp_extraction|prediction|classification|regression`',
    `model_version_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and changes in this version.',
    `model_version_status` STRING COMMENT 'Current lifecycle state of the model version.. Valid values are `draft|active|deprecated|archived`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the version.',
    `output_schema` STRING COMMENT 'JSON definition of the models output structure.',
    `released_timestamp` TIMESTAMP COMMENT 'Date‑time when the model version was promoted to production or made available.',
    `retention_policy` STRING COMMENT 'HIPAA‑compliant data retention rule for this model version.. Valid values are `retain_1yr|retain_3yr|retain_7yr|retain_indefinite`',
    `source_code_version` STRING COMMENT 'Version control tag/commit hash of the source code used to build the model.',
    `tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for categorization.',
    `target_variable` STRING COMMENT 'Name of the outcome variable the model predicts.',
    `training_dataset_snapshot_reference` BIGINT COMMENT 'Identifier of the immutable dataset snapshot used for training this version.',
    `training_end_timestamp` TIMESTAMP COMMENT 'Date‑time when model training completed.',
    `training_start_timestamp` TIMESTAMP COMMENT 'Date‑time when model training began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the version record.',
    `version_label` STRING COMMENT 'Human‑readable label for the model version (e.g., "Baseline", "Improved").',
    `version_number` STRING COMMENT 'Sequential version identifier (e.g., 1.0, 1.1, 2.0).',
    `model_id` BIGINT COMMENT 'Identifier of the parent AI model to which this version belongs.',
    `description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and changes in this version.',
    `status` STRING COMMENT 'Current lifecycle state of the model version.. Valid values are `draft|active|deprecated|archived`',
    `training_dataset_snapshot_id` BIGINT COMMENT 'Identifier of the immutable dataset snapshot used for training this version.',
    `mlflow_run_id` STRING COMMENT 'Unique identifier of the MLflow run that produced this model version.',
    `author_user_id` BIGINT COMMENT 'Identifier of the data scientist or engineer who authored the version.',
    `reviewer_user_id` BIGINT COMMENT 'Identifier of the reviewer who approved the version for release.',
    CONSTRAINT pk_model_version PRIMARY KEY(`model_version_id`)
) COMMENT 'Versioned metadata for each AI model, including version number, training dataset snapshot, hyperparameters, and release date.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` (
    `model_training_run_id` BIGINT COMMENT 'Unique surrogate key for each model training execution.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: A training run is executed for a specific AI model documented in model_card. This provides direct model-level traceability for training activities without needing to traverse through model_version.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Healthcare IT chargeback and research grant accounting require allocating ML compute costs to specific cost centers. Finance teams report AI/ML spending by department for budget variance analysis and ',
    `employee_id` BIGINT COMMENT 'Identifier of the data scientist or team responsible for the training run.',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: A training run produces a specific model version. Adding FK to model_version links training execution to its output artifact. Removing model_version STRING column as it becomes redundant once the FK t',
    `compute_node_count` STRING COMMENT 'Count of compute nodes allocated for the training job.',
    `compute_resource` STRING COMMENT 'Name or identifier of the compute cluster or environment used for training.',
    `cost_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost amount.. Valid values are `^[A-Z]{3}$`',
    `cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the training run, expressed in USD.',
    `cpu_hours_consumed` DECIMAL(18,2) COMMENT 'Aggregate CPU usage for the run expressed in hours.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training run record was first created in the data lake.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the model training completed or terminated.',
    `evaluation_metric` STRING COMMENT 'Primary metric used to assess model performance after training.',
    `framework_version` STRING COMMENT 'Version of the training framework library.',
    `gpu_enabled` BOOLEAN COMMENT 'Indicates whether GPU resources were used during training.',
    `gpu_hours_consumed` DECIMAL(18,2) COMMENT 'Aggregate GPU usage for the run expressed in hours.',
    `hyperparameters_json` STRING COMMENT 'JSON-encoded hyperparameter set used for the training run.',
    `loss_function` STRING COMMENT 'Loss function used to evaluate model error during training.',
    `memory_gb` DECIMAL(18,2) COMMENT 'Average memory consumption of the training job in gigabytes.',
    `metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the selected evaluation metric.',
    `mlflow_run_reference` STRING COMMENT 'Identifier assigned by MLflow to track the training execution.',
    `model_artifact_uri` STRING COMMENT 'Location (e.g., DBFS path) where the trained model is stored.',
    `model_training_run_status` STRING COMMENT 'Current lifecycle state of the training run.. Valid values are `pending|running|completed|failed|canceled`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the training run.',
    `optimizer` STRING COMMENT 'Name of the optimizer algorithm applied during training.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the model training started.',
    `tags` STRING COMMENT 'Comma‑separated list of user‑assigned tags for categorization.',
    `training_data_version` STRING COMMENT 'Version tag of the dataset snapshot used for training.',
    `training_duration_seconds` STRING COMMENT 'Total elapsed time of the training run measured in seconds.',
    `training_framework` STRING COMMENT 'Machine‑learning framework used for the training run.. Valid values are `pytorch|tensorflow|sklearn|xgboost|lightgbm|catboost`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this training run record.',
    `mlflow_run_id` STRING COMMENT 'Identifier assigned by MLflow to track the training execution.',
    `status` STRING COMMENT 'Current lifecycle state of the training run.. Valid values are `pending|running|completed|failed|canceled`',
    `owner_id` BIGINT COMMENT 'Identifier of the data scientist or team responsible for the training run.',
    `model_version` STRING COMMENT 'Version string of the resulting model artifact.',
    CONSTRAINT pk_model_training_run PRIMARY KEY(`model_training_run_id`)
) COMMENT 'Record of a model training execution, capturing start/end timestamps, compute resources, training data version, and resulting model version.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` (
    `clinical_ai_cohort_definition_id` BIGINT COMMENT 'Primary key for clinical_ai_cohort_definition',
    `care_site_id` BIGINT COMMENT 'Identifier of the organization or department responsible for maintaining and governing this cohort definition.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical leader or governance committee member who approved the cohort definition for production use.',
    `clinical_clinician_id` BIGINT COMMENT 'Identifier of the clinical or data science professional who authored the cohort definition.',
    `measure_id` BIGINT COMMENT 'Identifier linking this cohort to a specific quality measure such as HEDIS, MIPS, or CMS Star Rating measure.',
    `age_range_max` STRING COMMENT 'Upper bound of the patient age range in years for cohort eligibility.',
    `age_range_min` STRING COMMENT 'Lower bound of the patient age range in years for cohort eligibility, supporting age-stratified population health programs.',
    `approval_date` DATE COMMENT 'Date on which the cohort definition received formal clinical or governance approval for operational use.',
    `clinical_ai_cohort_definition_code` STRING COMMENT 'Unique business identifier code assigned to the cohort definition for cross-system referencing and cataloging.',
    `clinical_ai_cohort_definition_description` STRING COMMENT 'Detailed narrative explanation of the cohorts clinical intent, target population characteristics, and expected use cases.',
    `clinical_ai_cohort_definition_name` STRING COMMENT 'Human-readable name of the cohort definition used for display and search purposes across population health management tools.',
    `clinical_ai_cohort_definition_status` STRING COMMENT 'Current lifecycle state of the cohort definition governing whether it can be used for patient identification and analytics.',
    `clinical_domain` STRING COMMENT 'The clinical specialty or disease area the cohort targets such as cardiology, oncology, diabetes management, or behavioral health.',
    `cohort_type` STRING COMMENT 'Classification of the cohort definition methodology indicating how the population is assembled and maintained.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether patient consent is required before including them in this cohort for outreach or research activities.',
    `criteria_expression` STRING COMMENT 'Formal logical expression defining inclusion and exclusion criteria using Clinical Quality Language (CQL) or equivalent structured query syntax. May reference diagnosis codes, lab values, or medication histories.',
    `criteria_logic_type` STRING COMMENT 'The formal language or framework used to express the cohort selection criteria.',
    `data_source_system` STRING COMMENT 'Primary source system from which patient data is drawn for cohort evaluation such as EHR, claims, or HIE.',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition version is no longer active. Null indicates an open-ended definition.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition version becomes active and eligible for use in clinical programs.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter applied to the cohort definition for clinically appropriate population segmentation.',
    `icd10_category` STRING COMMENT 'Primary ICD-10 diagnosis category or code range that anchors the cohort definitions clinical focus.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number if the cohort is used for research purposes, ensuring regulatory compliance with human subjects protections.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the cohort membership was last recalculated against current patient data.',
    `model_algorithm_name` STRING COMMENT 'Name of the AI/ML algorithm or predictive model used to identify or score patients for cohort membership when applicable.',
    `model_version` STRING COMMENT 'Version identifier of the AI/ML model used for cohort identification, supporting reproducibility and audit requirements.',
    `purpose` STRING COMMENT 'Primary intended use of the cohort definition indicating the business function it supports.',
    `refresh_frequency` STRING COMMENT 'How often the cohort membership is recalculated to reflect changes in patient clinical data.',
    `retention_period_days` STRING COMMENT 'Number of days cohort membership snapshots are retained before archival or deletion per HIPAA data retention policies.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk score value a patient must meet or exceed to qualify for this cohort, used in risk stratification models.',
    `sdoh_inclusion_flag` BOOLEAN COMMENT 'Indicates whether social determinants of health factors are incorporated into the cohort selection criteria.',
    `sensitivity_level` STRING COMMENT 'Data governance sensitivity classification indicating the level of access control required for cohort membership results.',
    `target_population_size` BIGINT COMMENT 'Estimated or last-computed number of patients meeting the cohort criteria, used for capacity planning and resource allocation.',
    `validation_status` STRING COMMENT 'Status of clinical validation confirming the cohort definition correctly identifies the intended patient population.',
    `version_number` STRING COMMENT 'Semantic version number of the cohort definition following major.minor.patch convention to track iterative refinements.',
    CONSTRAINT pk_clinical_ai_cohort_definition PRIMARY KEY(`clinical_ai_cohort_definition_id`)
) COMMENT 'Table defining dynamic population health cohorts.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` (
    `population_cohort_definition_id` BIGINT COMMENT 'Primary key for population_cohort_definition',
    `care_program_id` BIGINT COMMENT 'Reference to the population health care management program that utilizes this cohort definition for patient outreach and intervention targeting.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinical leader or physician champion responsible for the clinical validity and governance of this cohort definition.',
    `measure_id` BIGINT COMMENT 'Reference to the associated quality measure or HEDIS measure that this cohort definition supports, linking population identification to performance measurement.',
    `age_max_years` STRING COMMENT 'Maximum patient age in years for cohort eligibility. Used as a primary demographic filter in population stratification.',
    `age_min_years` STRING COMMENT 'Minimum patient age in years for cohort eligibility. Used as a primary demographic filter in population stratification.',
    `approval_date` DATE COMMENT 'Date on which the cohort definition was formally approved by the clinical governance committee for operational use.',
    `clinical_domain` STRING COMMENT 'Primary clinical specialty or disease domain that this cohort definition addresses. [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|pulmonology|nephrology|behavioral_health|neurology|orthopedics|obstetrics|pediatrics|geriatrics — promote to reference product]',
    `cohort_type` STRING COMMENT 'Classification of the cohort definition by its primary analytical purpose, determining how the cohort is used in population health management workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was first created in the system.',
    `data_source_systems` STRING COMMENT 'Comma-separated list of source systems (e.g., Epic EHR, Cerner Millennium, claims warehouse) whose data feeds are required to evaluate this cohort definition.',
    `diagnosis_code_set` STRING COMMENT 'Comma-separated list of all ICD-10 codes (including related conditions) that qualify a patient for cohort inclusion beyond the primary code.',
    `effective_end_date` DATE COMMENT 'Date after which this version of the cohort definition is no longer active. Null indicates currently effective. Supports SCD Type 2 versioning.',
    `effective_start_date` DATE COMMENT 'Date from which this version of the cohort definition becomes active and available for use in population health programs. Supports SCD Type 2 versioning.',
    `exclusion_criteria_expression` STRING COMMENT 'Formal logical expression defining the exclusion criteria that remove patients from cohort membership despite meeting inclusion criteria, such as hospice enrollment or terminal diagnosis.',
    `fhir_measure_resource_url` STRING COMMENT 'URL reference to the FHIR Measure resource that formally represents this cohort definition in interoperable health information exchange contexts.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for the cohort definition. Value of all indicates no gender restriction applies.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether this cohort definition has been reviewed for HIPAA minimum necessary compliance, ensuring only required PHI elements are accessed during evaluation.',
    `inclusion_criteria_expression` STRING COMMENT 'Formal logical expression defining the inclusion criteria for patient membership in this cohort, expressed in Clinical Quality Language (CQL) or equivalent structured query notation.',
    `irb_approval_required_flag` BOOLEAN COMMENT 'Indicates whether use of this cohort definition for research purposes requires Institutional Review Board approval prior to patient data access.',
    `is_current_version` BOOLEAN COMMENT 'Flag indicating whether this record represents the currently active version of the cohort definition for SCD Type 2 history tracking.',
    `lab_value_criteria` STRING COMMENT 'Structured criteria based on laboratory test results (e.g., HbA1c > 9%, eGFR < 60) using LOINC-coded observations for cohort qualification.',
    `last_execution_member_count` STRING COMMENT 'Number of patients identified as cohort members during the most recent execution run, used for trending and capacity planning.',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this cohort definition against the patient population, indicating data currency for downstream consumers.',
    `last_validated_date` DATE COMMENT 'Date of the most recent clinical validation review confirming the cohort definition still accurately identifies the intended patient population.',
    `lookback_period_days` STRING COMMENT 'Number of days into the patients clinical history to evaluate when determining cohort eligibility, defining the temporal window for criteria assessment.',
    `measurement_period_end` DATE COMMENT 'End date of the measurement period during which the cohort definition is actively evaluated for quality reporting and performance measurement.',
    `measurement_period_start` DATE COMMENT 'Start date of the measurement period during which the cohort definition is actively evaluated for quality reporting and performance measurement.',
    `medication_criteria` STRING COMMENT 'Description of medication-based criteria for cohort membership, referencing therapeutic classes or specific National Drug Codes (NDC) that indicate relevant pharmacotherapy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this cohort definition to ensure continued clinical relevance and accuracy.',
    `payer_program_alignment` STRING COMMENT 'Identifies the payer-sponsored program (e.g., Medicare Advantage Star Ratings, Medicaid managed care, commercial value-based contract) that this cohort supports.',
    `population_cohort_definition_code` STRING COMMENT 'Unique business identifier code for the cohort definition, used for cross-system referencing and registry alignment.',
    `population_cohort_definition_description` STRING COMMENT 'Detailed narrative description of the cohorts clinical intent, target population characteristics, and intended use cases for care management teams.',
    `population_cohort_definition_name` STRING COMMENT 'Human-readable name of the population cohort definition, such as Diabetic Adults Age 18-75 with HbA1c > 9% or Heart Failure Readmission Risk.',
    `population_cohort_definition_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is available for use in population health programs and reporting.',
    `primary_icd10_code` STRING COMMENT 'Primary ICD-10 diagnosis code that anchors this cohort definition, representing the core clinical condition being targeted.',
    `refresh_frequency` STRING COMMENT 'How frequently the cohort membership is recalculated based on updated clinical data, determining data freshness for care gap interventions.',
    `retention_period_years` STRING COMMENT 'Number of years this cohort definition and its associated membership snapshots must be retained per HIPAA and organizational data governance policies.',
    `risk_model_name` STRING COMMENT 'Name of the predictive risk model whose output scores are referenced in the cohort criteria, such as LACE index, HCC risk adjustment, or custom ML model.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum AI/ML-generated risk score value that qualifies a patient for cohort membership when the definition uses predictive model outputs as criteria.',
    `sdoh_criteria_detail` STRING COMMENT 'Narrative description of specific SDOH factors used in cohort criteria, such as Z-codes for social risk factors or area deprivation index thresholds.',
    `sdoh_criteria_flag` BOOLEAN COMMENT 'Indicates whether this cohort definition incorporates Social Determinants of Health factors (housing instability, food insecurity, transportation barriers) in its eligibility criteria.',
    `sensitivity_score` DECIMAL(18,2) COMMENT 'Statistical sensitivity (true positive rate) of the cohort definition measured during validation, indicating how well it captures all eligible patients.',
    `specificity_score` DECIMAL(18,2) COMMENT 'Statistical specificity (true negative rate) of the cohort definition measured during validation, indicating how well it excludes non-eligible patients.',
    `steward_department` STRING COMMENT 'Name of the organizational department (e.g., Population Health, Quality, Clinical Analytics) responsible for maintaining and validating this cohort definition.',
    `target_population_size` STRING COMMENT 'Estimated or last-calculated number of patients meeting the cohort definition criteria, used for resource planning and program capacity assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was last modified, supporting audit trail and change management requirements.',
    `value_set_oid` STRING COMMENT 'Object Identifier for the primary clinical value set (from VSAC or similar repository) used in this cohort definitions criteria evaluation.',
    `version_number` STRING COMMENT 'Semantic version number of this cohort definition following major.minor.patch convention, supporting change tracking and audit requirements.',
    CONSTRAINT pk_population_cohort_definition PRIMARY KEY(`population_cohort_definition_id`)
) COMMENT 'Population health cohort definition table';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` (
    `population_cohort_membership_id` BIGINT COMMENT 'Primary key for population_cohort_membership',
    `care_program_id` BIGINT COMMENT 'Identifier of the specific care management program associated with this cohort membership, linking to structured intervention protocols.',
    `care_site_id` BIGINT COMMENT 'Identifier of the primary facility or care site associated with the patients cohort management, used for geographic and organizational reporting.',
    `population_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.population_cohort_definition. Business justification: population_cohort_membership has cohort_id (BIGINT) with no FK. This links membership records to their population cohort definition. A membership belongs to exactly one cohort definition.',
    `insurance_accountable_care_organization_id` BIGINT COMMENT 'Identifier of the ACO under which this cohort membership is managed, supporting value-based care reporting and shared savings calculations.',
    `model_version_id` BIGINT COMMENT 'Version identifier of the AI/ML model or algorithm that generated the cohort assignment, supporting model governance and reproducibility.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient assigned to the population health cohort. Links to the master patient index.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer relevant to the cohort program, particularly for payer-sponsored population health initiatives.',
    `clinician_id` BIGINT COMMENT 'Identifier of the care manager or care coordinator responsible for managing this patient within the cohort.',
    `population_cohort_id` BIGINT COMMENT 'Identifier of the population health cohort to which the patient is assigned (e.g., diabetes management, heart failure, high-risk pregnancy).',
    `population_pcp_provider_clinician_id` BIGINT COMMENT 'Identifier of the patients primary care physician at the time of cohort enrollment, used for attribution and care coordination.',
    `assignment_method` STRING COMMENT 'Method by which the patient was assigned to the cohort, distinguishing between AI/ML algorithm-driven, clinician-referred, registry-based, or claims-based identification.',
    `assignment_reason_code` STRING COMMENT 'Coded reason for the patients inclusion in the cohort, typically referencing a diagnosis code (ICD-10), risk factor, or qualifying clinical criterion.',
    `assignment_reason_description` STRING COMMENT 'Human-readable narrative describing why the patient qualifies for cohort membership, including clinical criteria met or risk factors identified.',
    `attribution_method` STRING COMMENT 'Method used to attribute the patient to a primary care provider within the cohort, per CMS or ACO attribution rules.',
    `care_gap_count` STRING COMMENT 'Number of open care gaps identified for this patient within the context of the cohorts quality measures at last assessment.',
    `clinician_override_flag` BOOLEAN COMMENT 'Indicates whether a clinician manually overrode the algorithmic cohort assignment decision (either to include or exclude the patient).',
    `cohort_priority_rank` STRING COMMENT 'Numeric rank indicating the patients priority within the cohort for outreach and intervention, with lower numbers indicating higher priority.',
    `comorbidity_count` STRING COMMENT 'Number of comorbid conditions identified for the patient at the time of cohort assessment, influencing care complexity and resource needs.',
    `consent_status` STRING COMMENT 'Status of the patients consent to participate in the population health cohort program, required for certain outreach and data sharing activities.',
    `current_risk_score` DECIMAL(18,2) COMMENT 'Patients most recently calculated risk score within the cohort, reflecting updated clinical and claims data for ongoing stratification.',
    `data_source` STRING COMMENT 'Primary data source used to identify and validate the patients cohort eligibility, supporting data provenance and quality assessment.',
    `days_since_last_encounter` STRING COMMENT 'Number of days elapsed since the patients last clinical encounter related to the cohort condition, used for lost-to-follow-up identification.',
    `disenrollment_date` DATE COMMENT 'Date the patient was removed, graduated, or otherwise disenrolled from the cohort. Null if membership is still active.',
    `disenrollment_reason` STRING COMMENT 'Reason the patient was disenrolled from the cohort, supporting program effectiveness analysis and outcome tracking.',
    `ed_utilization_flag` BOOLEAN COMMENT 'Indicates whether the patient has had emergency department visits related to the cohort condition during the current measurement period.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort membership record was superseded or closed, null for current active records. Supports SCD Type 2 historization.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort membership record became effective, supporting SCD Type 2 historization for membership changes over time.',
    `engagement_level` STRING COMMENT 'Assessment of the patients level of engagement with the cohorts care management program, based on response to outreach and adherence to care plans.',
    `enrollment_date` DATE COMMENT 'Date the patient was enrolled or assigned into the population health cohort.',
    `hospitalization_flag` BOOLEAN COMMENT 'Indicates whether the patient has had inpatient hospitalizations related to the cohort condition during the current measurement period.',
    `intervention_count` STRING COMMENT 'Total number of care management interventions completed for this patient within the cohort program since enrollment.',
    `is_current_record` BOOLEAN COMMENT 'Flag indicating whether this is the current/active version of the membership record in the SCD Type 2 history, simplifying queries for latest state.',
    `last_encounter_date` DATE COMMENT 'Date of the patients most recent clinical encounter relevant to the cohort condition, used to identify patients overdue for follow-up.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent care management outreach attempt to the patient within this cohort program.',
    `last_risk_assessment_date` DATE COMMENT 'Date of the most recent risk score calculation or clinical risk assessment for this patient within the cohort.',
    `measurement_period_end_date` DATE COMMENT 'End date of the current quality measurement period applicable to this cohort membership.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the current quality measurement period applicable to this cohort membership, aligning with HEDIS or CMS reporting cycles.',
    `medication_adherence_pct` DECIMAL(18,2) COMMENT 'Proportion of days covered (PDC) for prescribed medications related to the cohort condition, a key quality measure for chronic disease management.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the patients membership in the cohort, indicating whether they are actively being managed within the cohort program.',
    `model_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-1) from the AI/ML model that identified this patient for cohort membership, supporting clinical validation and threshold tuning.',
    `next_scheduled_outreach_date` DATE COMMENT 'Date of the next planned care management outreach or follow-up contact for this patient within the cohort.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted out of active cohort management while remaining technically eligible for the cohort.',
    `override_reason` STRING COMMENT 'Free-text or coded reason provided by the clinician when overriding the algorithmic cohort assignment, supporting model feedback loops.',
    `qualifying_condition_code` STRING COMMENT 'Primary ICD-10-CM diagnosis code that qualifies the patient for cohort membership, representing the principal clinical condition being managed.',
    `quality_measure_compliance_pct` DECIMAL(18,2) COMMENT 'Percentage of applicable quality measures for which the patient is compliant within the cohorts measure set, supporting HEDIS and MIPS reporting.',
    `review_due_date` DATE COMMENT 'Date by which the patients cohort membership should be reviewed for continued eligibility, graduation, or status change.',
    `risk_score_at_enrollment` DECIMAL(18,2) COMMENT 'Patients calculated risk score at the time of cohort enrollment, used to stratify patients within the cohort for care management prioritization.',
    `risk_stratification_tier` STRING COMMENT 'Risk tier classification within the cohort used to determine intensity of care management interventions and resource allocation.',
    `sdoh_risk_flag` BOOLEAN COMMENT 'Indicates whether the patient has identified social determinants of health risk factors (housing instability, food insecurity, transportation barriers) that may impact cohort outcomes.',
    CONSTRAINT pk_population_cohort_membership PRIMARY KEY(`population_cohort_membership_id`)
) COMMENT 'Population health cohort membership tracking table';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` (
    `clinical_ai_population_health_cohort_management_id` BIGINT COMMENT 'Primary key for clinical_ai_population_health_cohort_management',
    `care_program_id` BIGINT COMMENT 'Identifier of the care management program associated with this cohort, linking cohort membership to specific intervention workflows.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare organization (ACO, health system, or practice) that owns and governs this cohort definition.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: Population health cohort management uses AI models for risk stratification and cohort identification. Has model_governance_status field indicating model governance awareness. Linking to model_card con',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical provider or medical director who approved this cohort definition for use in patient care workflows.',
    `clinical_clinician_id` BIGINT COMMENT 'Identifier of the provider or care team responsible for managing this cohort and overseeing population health interventions for its members.',
    `measure_id` BIGINT COMMENT 'Identifier of the associated quality measure (NQF, CMS, or HEDIS) that this cohort supports for regulatory reporting and value-based payment programs.',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for cohort eligibility, supporting age-based population health segmentation.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for cohort eligibility, supporting age-based population health segmentation.',
    `approval_date` DATE COMMENT 'Date on which the cohort definition was formally approved for clinical use by the governing clinical committee or medical director.',
    `attribution_method` STRING COMMENT 'Method used to attribute patients to providers or care teams for this cohort, critical for ACO and value-based payment program alignment.',
    `bias_assessment_completed` BOOLEAN COMMENT 'Indicates whether an algorithmic bias assessment has been completed for the cohort definition criteria to ensure equitable patient identification across demographic groups.',
    `clinical_ai_population_health_cohort_management_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively being used for patient identification and care management.',
    `clinical_domain` STRING COMMENT 'Primary clinical specialty or disease domain that this cohort addresses for population health management. [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|pulmonology|behavioral_health|nephrology|neurology|orthopedics|obstetrics|pediatrics — promote to reference product]',
    `cohort_code` STRING COMMENT 'Externally-known unique business code assigned to the cohort for cross-system reference and reporting purposes.',
    `cohort_name` STRING COMMENT 'Human-readable name of the population health cohort used for identification in clinical analytics dashboards and care management workflows.',
    `cohort_type` STRING COMMENT 'Classification of the cohort by its primary purpose, such as disease registry tracking, risk stratification, quality measure compliance, care gap identification, research enrollment, or custom analytics.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required for inclusion in this cohort, particularly relevant for research cohorts or those involving data sharing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort management record was first created in the system.',
    `current_member_count` STRING COMMENT 'Total number of patients currently meeting cohort inclusion criteria as of the last refresh, used for capacity planning and resource allocation.',
    `data_source_system` STRING COMMENT 'Primary source system from which patient data is extracted for cohort evaluation, such as Epic Healthy Planet, Cerner HealtheIntent, or claims data warehouse.',
    `de_identification_level` STRING COMMENT 'Level of patient de-identification applied to cohort data when shared externally or used for research purposes.',
    `definition_version` STRING COMMENT 'Semantic version number of the cohort definition criteria, supporting SCD Type 2 tracking of definition changes over time.',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition is no longer active. Null indicates an open-ended cohort with no planned retirement.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition becomes active and patients begin to be evaluated for membership.',
    `exclusion_criteria_expression` STRING COMMENT 'Structured logical expression defining conditions that disqualify a patient from cohort membership even if inclusion criteria are met, such as hospice enrollment or terminal diagnosis.',
    `gap_closure_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of identified care gaps that have been closed for members of this cohort, measuring intervention effectiveness.',
    `hipaa_minimum_necessary` BOOLEAN COMMENT 'Indicates whether the cohort definition and membership data comply with HIPAA minimum necessary standard for PHI access.',
    `inclusion_criteria_expression` STRING COMMENT 'Structured logical expression defining the clinical, demographic, and utilization criteria that qualify a patient for cohort membership. May reference ICD-10, CPT, LOINC codes, lab values, or SDOH factors.',
    `intervention_type` STRING COMMENT 'Primary type of clinical intervention or care management strategy applied to members of this cohort.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent cohort membership recalculation, used to assess data freshness for clinical decision support.',
    `measurement_period_end` DATE COMMENT 'End date of the clinical measurement period for quality measure evaluation and outcomes reporting.',
    `measurement_period_start` DATE COMMENT 'Start date of the clinical measurement period used for evaluating quality measures and outcomes associated with this cohort.',
    `model_governance_status` STRING COMMENT 'Governance approval status of the AI/ML model or algorithm used to define or score this cohort, ensuring responsible AI practices.',
    `next_scheduled_refresh` TIMESTAMP COMMENT 'Timestamp when the next cohort membership recalculation is scheduled to execute based on the defined refresh frequency.',
    `notes` STRING COMMENT 'Free-text clinical or administrative notes providing additional context about the cohort definition, its rationale, or operational considerations.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated notifications are sent to care teams when patients enter or exit this cohort, supporting proactive care management.',
    `outcome_current_value` DECIMAL(18,2) COMMENT 'Most recently calculated value of the primary outcome measure for this cohort, enabling performance tracking against targets.',
    `outcome_measure_name` STRING COMMENT 'Primary clinical or operational outcome measure tracked for this cohort, such as HbA1c control rate, readmission rate, or ED utilization.',
    `outcome_target_value` DECIMAL(18,2) COMMENT 'Target value for the primary outcome measure that defines success for this cohorts population health intervention.',
    `payer_line_of_business` STRING COMMENT 'Insurance line of business filter applied to cohort membership, enabling payer-specific population health strategies and value-based contract alignment.',
    `priority_level` STRING COMMENT 'Clinical priority level assigned to this cohort for resource allocation and care team workload management.',
    `refresh_frequency` STRING COMMENT 'How frequently the cohort membership is recalculated based on updated clinical data, determining the currency of patient inclusion/exclusion decisions.',
    `retention_period_days` STRING COMMENT 'Number of days that cohort membership history data must be retained per HIPAA and organizational data governance policies.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk score value (from HCC, LACE, or proprietary models) required for patient inclusion in risk-stratified cohorts.',
    `risk_stratification_model` STRING COMMENT 'Name or identifier of the AI/ML risk stratification model used to score and segment patients within this cohort for care prioritization.',
    `sdoh_factors_included` BOOLEAN COMMENT 'Indicates whether Social Determinants of Health factors (housing, food security, transportation, etc.) are incorporated into the cohort inclusion/exclusion criteria.',
    `target_member_count` STRING COMMENT 'Expected or planned number of patients for this cohort based on epidemiological estimates, used to identify under-identification of at-risk populations.',
    `target_population_description` STRING COMMENT 'Narrative description of the intended patient population for this cohort, providing clinical context for care managers and analysts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort management record was last modified, supporting audit trail and SCD Type 2 change tracking.',
    CONSTRAINT pk_clinical_ai_population_health_cohort_management PRIMARY KEY(`clinical_ai_population_health_cohort_management_id`)
) COMMENT 'population_health_cohort_management tables dynamic_cohort_definition and cohort_membership.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` (
    `clinical_ai_population_health_cohort_mgmt_id` BIGINT COMMENT 'Primary key for clinical_ai_population_health_cohort_mgmt',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or care site to which this cohort is scoped, if not system-wide.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: Similar to clinical_ai_population_health_cohort_management — this variant also uses AI models for risk stratification (has risk_stratification_model, model_validation_status). Connecting to model_card',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical provider or physician champion responsible for the clinical governance and oversight of this cohort definition.',
    `measure_id` BIGINT COMMENT 'Identifier linking this cohort to a specific quality measure such as HEDIS, CMS Star Rating, or MIPS measure for which the cohort was designed.',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for cohort eligibility, used as a demographic filter in the inclusion criteria.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for cohort eligibility, used as a demographic filter in the inclusion criteria.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the cohort definition was formally approved for production use by clinical governance.',
    `care_program_name` STRING COMMENT 'Name of the population health care management program this cohort supports, such as chronic disease management, transitional care, or wellness programs.',
    `clinical_ai_population_health_cohort_mgmt_description` STRING COMMENT 'Detailed narrative describing the clinical rationale, target population characteristics, and intended use of the cohort in population health programs.',
    `clinical_ai_population_health_cohort_mgmt_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively being used for patient identification and intervention targeting.',
    `clinical_domain` STRING COMMENT 'The clinical specialty or disease domain the cohort addresses, such as cardiology, endocrinology, oncology, behavioral health, or preventive care. [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|behavioral_health|pulmonology|nephrology|neurology|preventive_care — promote to reference product]',
    `cohort_code` STRING COMMENT 'Unique business code assigned to the cohort for programmatic reference across clinical AI systems and reporting platforms.',
    `cohort_name` STRING COMMENT 'Human-readable name of the population health cohort used for identification in analytics dashboards and care management workflows.',
    `cohort_type` STRING COMMENT 'Classification of the cohort by its primary purpose, such as disease registry tracking, risk stratification, quality measure compliance, care gap identification, or research enrollment.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether patient consent is required before including them in this cohort or triggering associated interventions.',
    `cpt_code_set` STRING COMMENT 'Comma-separated list of CPT procedure codes relevant to the cohort definition for identifying patients by procedure history.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cohort definition record was initially created in the system.',
    `criteria_version` STRING COMMENT 'Semantic version number of the cohort criteria definition, enabling tracking of changes over time for reproducibility and audit purposes.',
    `current_member_count` BIGINT COMMENT 'The most recently computed count of patients currently meeting the cohort inclusion criteria as of the last evaluation run.',
    `data_source_system` STRING COMMENT 'Primary source system from which patient data is extracted for cohort evaluation, such as Epic Healthy Planet, Cerner HealtheIntent, or custom data lake.',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition is no longer active. Null indicates an open-ended cohort with no planned retirement.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition becomes active and eligible for patient identification and intervention triggering.',
    `evaluation_frequency` STRING COMMENT 'How often the cohort membership is re-evaluated against the defined criteria to refresh the patient population.',
    `exclusion_criteria_logic` STRING COMMENT 'Structured or semi-structured expression defining conditions that disqualify a patient from cohort membership, such as hospice enrollment, terminal diagnosis, or age limits.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for the cohort, applicable for gender-specific screening or disease cohorts.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether the cohort criteria and resulting patient list comply with HIPAA minimum necessary standard for data access.',
    `icd10_code_set` STRING COMMENT 'Comma-separated list of ICD-10 diagnosis codes that define the clinical conditions targeted by this cohort.',
    `inclusion_criteria_logic` STRING COMMENT 'Structured or semi-structured expression defining the clinical, demographic, and utilization criteria that qualify a patient for cohort membership. May reference ICD-10, CPT, LOINC codes, lab values, or risk scores.',
    `intervention_type` STRING COMMENT 'Primary type of clinical intervention or care action triggered when patients are identified as cohort members.',
    `irb_approval_number` STRING COMMENT 'IRB protocol approval number if this cohort is used for research purposes, ensuring ethical oversight compliance.',
    `is_dynamic` BOOLEAN COMMENT 'Indicates whether cohort membership is dynamically recalculated on each evaluation cycle (true) or is a static one-time patient list (false).',
    `last_evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the cohort criteria were last executed to refresh the patient membership list.',
    `loinc_code_set` STRING COMMENT 'Comma-separated list of LOINC codes for laboratory observations used in cohort inclusion or exclusion criteria.',
    `managing_care_team` STRING COMMENT 'Name of the care management team or population health department responsible for operationalizing interventions for this cohort.',
    `medication_class_filter` STRING COMMENT 'Therapeutic drug class or NDC-based medication filter used to identify patients by active prescriptions or medication history.',
    `model_validation_status` STRING COMMENT 'Status of the AI/ML model validation process that underpins the cohort criteria, ensuring clinical accuracy and bias assessment.',
    `next_evaluation_date` DATE COMMENT 'Scheduled date for the next cohort membership refresh based on the configured evaluation frequency.',
    `outcome_measure` STRING COMMENT 'Primary clinical or operational outcome being tracked for patients in this cohort, such as readmission rate, HbA1c control, or ED utilization reduction.',
    `payer_alignment` STRING COMMENT 'Insurance payer or value-based contract to which this cohort is aligned, relevant for ACO shared savings, Medicare Advantage Star Ratings, or commercial risk contracts.',
    `priority_level` STRING COMMENT 'Clinical priority assigned to this cohort for resource allocation and care team workload balancing in population health workflows.',
    `refresh_method` STRING COMMENT 'Technical approach used to refresh cohort membership: full rebuild recalculates all members, incremental processes only changes, streaming evaluates in near-real-time.',
    `retention_period_days` STRING COMMENT 'Number of days cohort membership and associated data are retained per HIPAA and organizational data governance policies.',
    `risk_score_threshold_max` DECIMAL(18,2) COMMENT 'Maximum AI-generated risk score value for cohort inclusion, enabling banding of patients into risk tiers.',
    `risk_score_threshold_min` DECIMAL(18,2) COMMENT 'Minimum AI-generated risk score value required for a patient to be included in this cohort based on predictive model output.',
    `risk_stratification_model` STRING COMMENT 'Name or identifier of the AI/ML risk stratification model used to score patients within this cohort, such as HCC risk adjustment, LACE index, or custom predictive models.',
    `sdoh_factor` STRING COMMENT 'Social determinants of health factors incorporated into cohort criteria, such as food insecurity, housing instability, transportation barriers, or health literacy.',
    `sensitivity_score` DECIMAL(18,2) COMMENT 'Statistical sensitivity (true positive rate) of the cohort identification algorithm, measuring how well it captures all eligible patients.',
    `specificity_score` DECIMAL(18,2) COMMENT 'Statistical specificity (true negative rate) of the cohort identification algorithm, measuring how well it excludes non-eligible patients.',
    `target_population_size` BIGINT COMMENT 'Estimated or projected number of patients expected to qualify for this cohort based on historical data and prevalence rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this cohort definition record was last modified, including criteria changes or status transitions.',
    `value_based_contract_flag` BOOLEAN COMMENT 'Indicates whether this cohort is directly tied to a value-based purchasing or alternative payment model contract with financial implications.',
    CONSTRAINT pk_clinical_ai_population_health_cohort_mgmt PRIMARY KEY(`clinical_ai_population_health_cohort_mgmt_id`)
) COMMENT 'Table defining dynamic cohort criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` (
    `clinical_ai_governance_id` BIGINT COMMENT 'Primary key for clinical_ai_clinical_ai_governance',
    `employee_id` BIGINT COMMENT 'Reference to the internal governance committee or individual with authority to approve clinical deployment of this AI model.',
    `clinical_responsible_data_scientist_employee_id` BIGINT COMMENT 'Reference to the data scientist or ML engineer accountable for the technical development and maintenance of this AI model.',
    `clinician_id` BIGINT COMMENT 'Reference to the physician or clinical provider who serves as the clinical champion and subject matter expert for this AI model.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: clinical_ai_clinical_ai_governance has model_id, model_name, model_version as raw fields but no FK to clinical_ai_model_card. Governance records govern specific AI models — this is a fundamental relat',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: clinical_ai_clinical_ai_governance tracks governance for specific model versions (has model_version string). Adding FK to model_version table enables joining to get full version metadata including tra',
    `model_card_id` BIGINT COMMENT 'Reference to the specific AI/ML model instance being governed under this record.',
    `adverse_event_count` STRING COMMENT 'Cumulative number of reported adverse events or near-misses attributed to or associated with this AI models clinical recommendations since deployment.',
    `algorithm_type` STRING COMMENT 'Technical classification of the AI/ML algorithm architecture such as deep learning, random forest, NLP transformer, or ensemble method.',
    `bias_audit_outcome` STRING COMMENT 'Result of the most recent bias audit indicating whether the model meets organizational fairness thresholds.',
    `bias_fairness_score` DECIMAL(18,2) COMMENT 'Composite fairness metric score from the most recent bias monitoring assessment, measuring equitable performance across protected demographic groups.',
    `bias_monitoring_frequency` STRING COMMENT 'Scheduled frequency at which bias and fairness metrics are recalculated and reviewed for this clinical AI model.',
    `clearance_date` DATE COMMENT 'Date on which FDA clearance or approval was granted for this clinical AI model as a medical device.',
    `clinical_domain` STRING COMMENT 'The clinical specialty or care domain where the AI model is deployed, such as radiology, pathology, cardiology, or sepsis prediction.',
    `clinician_override_rate` DECIMAL(18,2) COMMENT 'Proportion of AI model recommendations that are overridden by clinicians, serving as a signal for model calibration and clinical trust assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this governance record was first created in the system, establishing the audit trail origin.',
    `current_drift_score` DECIMAL(18,2) COMMENT 'Most recently calculated drift metric indicating how much the models real-world performance has deviated from its validated baseline.',
    `data_use_agreement_reference` STRING COMMENT 'Reference identifier for the data use agreement governing the training and inference data used by this clinical AI model.',
    `demographic_parity_ratio` DECIMAL(18,2) COMMENT 'Ratio measuring whether the AI model produces equitable positive prediction rates across racial, ethnic, and gender subgroups.',
    `deployment_date` DATE COMMENT 'Date when the AI model was first deployed into the clinical production environment for patient care use.',
    `deployment_environment` STRING COMMENT 'Current deployment stage of the AI model indicating whether it is in active clinical production, pilot testing, shadow mode, or has been retired.',
    `effective_end_date` DATE COMMENT 'Date on which this governance record ceases to be effective, nullable for currently active governance records.',
    `effective_start_date` DATE COMMENT 'Date from which this governance record becomes effective and the associated oversight requirements are enforceable.',
    `equalized_odds_difference` DECIMAL(18,2) COMMENT 'Maximum difference in true positive rates or false positive rates across protected groups, measuring conditional fairness of the model.',
    `explainability_method` STRING COMMENT 'Technique used to provide model interpretability and clinical decision explanations, such as SHAP, LIME, attention maps, or feature importance.',
    `fda_samd_classification` STRING COMMENT 'FDA device classification level for the AI/ML software when it qualifies as a Software as a Medical Device under FDA regulatory framework.',
    `governance_status` STRING COMMENT 'Current lifecycle state of this governance record within the clinical AI oversight workflow.',
    `governance_type` STRING COMMENT 'Classification of the governance activity type: model card documentation, bias monitoring audit, FDA SaMD submission, validation review, retraining approval, or decommission assessment.',
    `hipaa_phi_exposure_level` STRING COMMENT 'Classification of the level of PHI data the AI model accesses during inference, determining applicable HIPAA safeguard requirements.',
    `intended_use_statement` STRING COMMENT 'Formal description of the AI models intended clinical use, target patient population, and clinical workflow integration point as required for FDA SaMD submissions.',
    `is_locked_algorithm` BOOLEAN COMMENT 'Indicates whether the AI model is a locked algorithm (does not learn after deployment) versus an adaptive algorithm that continuously updates, per FDA predetermined change control plan requirements.',
    `last_bias_audit_date` DATE COMMENT 'Date of the most recent formal bias and fairness audit conducted on this clinical AI model.',
    `last_validation_date` DATE COMMENT 'Date of the most recent clinical validation or performance evaluation conducted on the deployed model.',
    `model_card_url` STRING COMMENT 'URL or document management system reference to the formal model card containing complete documentation of model purpose, performance, limitations, and ethical considerations.',
    `model_drift_threshold` DECIMAL(18,2) COMMENT 'Performance degradation threshold that triggers an automatic alert for governance review when model accuracy drops below acceptable limits.',
    `model_name` STRING COMMENT 'Human-readable name of the clinical AI model or algorithm subject to governance oversight.',
    `model_version` STRING COMMENT 'Semantic version number of the governed AI model, following major.minor.patch convention for change tracking.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next governance review cycle including performance assessment, bias audit, and continued appropriateness evaluation.',
    `patient_consent_required` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before the AI model can be applied to their clinical data or influence their care decisions.',
    `predetermined_change_control_plan` STRING COMMENT 'Reference to the FDA-approved predetermined change control plan that defines acceptable modifications to the AI model without requiring new regulatory submission.',
    `regulatory_submission_number` STRING COMMENT 'FDA 510(k), De Novo, or PMA submission number associated with this AI/ML device if applicable.',
    `retirement_date` DATE COMMENT 'Date on which the AI model was formally retired from clinical use, triggering archival of governance records per HIPAA retention requirements.',
    `retirement_reason` STRING COMMENT 'Documented rationale for retiring the AI model from clinical use, such as performance degradation, superseded by newer version, safety concern, or regulatory action.',
    `risk_category` STRING COMMENT 'Risk stratification of the AI model based on potential patient safety impact, clinical decision influence, and autonomy level.',
    `total_predictions_count` BIGINT COMMENT 'Cumulative number of clinical predictions or recommendations generated by this AI model since deployment, used for utilization tracking.',
    `training_data_description` STRING COMMENT 'Summary of the training dataset characteristics including size, demographic composition, data sources, and temporal coverage used to develop the model.',
    `training_data_size` BIGINT COMMENT 'Total number of samples or records used in the model training dataset for transparency and reproducibility documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this governance record, supporting change tracking and audit compliance.',
    `validation_auc_score` DECIMAL(18,2) COMMENT 'Area Under the Receiver Operating Characteristic Curve score from the most recent model validation, measuring discriminative performance.',
    `validation_sensitivity` DECIMAL(18,2) COMMENT 'Sensitivity or true positive rate from the most recent clinical validation study, critical for patient safety assessment.',
    `validation_specificity` DECIMAL(18,2) COMMENT 'Specificity or true negative rate from the most recent clinical validation study, measuring false alarm rate control.',
    CONSTRAINT pk_clinical_ai_clinical_ai_governance PRIMARY KEY(`clinical_ai_governance_id`)
) COMMENT 'Tables for model_card, bias_monitoring, fda_samd.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` (
    `clinical_ai_trial_eligibility_criteria_id` BIGINT COMMENT 'Primary key for clinical_ai_trial_eligibility_criteria',
    `employee_id` BIGINT COMMENT 'Identifier of the principal investigator or authorized clinician who approved this criterion for use in patient screening.',
    `clinical_employee_id` BIGINT COMMENT 'Identifier of the clinical researcher or data scientist who created this criterion definition.',
    `trial_id` BIGINT COMMENT 'Reference to the clinical trial or research study that this eligibility criterion belongs to.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED CT concept identifier for the clinical finding, procedure, or substance referenced by this criterion, enabling semantic interoperability.',
    `organization_id` BIGINT COMMENT 'Reference to the sponsoring organization (pharmaceutical company, research institution) that defined this criterion as part of the trial protocol.',
    `age_max_years` STRING COMMENT 'Maximum patient age in years allowed by this criterion when the criterion is age-based. Null if criterion is not age-related.',
    `age_min_years` STRING COMMENT 'Minimum patient age in years required by this criterion when the criterion is age-based. Null if criterion is not age-related.',
    `clinical_ai_trial_eligibility_criteria_status` STRING COMMENT 'Current lifecycle status of the eligibility criterion indicating whether it is actively used for patient matching, in draft, retired, or under clinical review.',
    `clinical_domain` STRING COMMENT 'The therapeutic or clinical domain to which this criterion applies, used for organizing criteria by medical specialty. [ENUM-REF-CANDIDATE: cardiology|oncology|neurology|endocrinology|pulmonology|immunology|nephrology|gastroenterology|hematology|rheumatology — promote to reference product]',
    `complexity_level` STRING COMMENT 'Assessment of the computational and clinical complexity of evaluating this criterion, used for workload planning and AI model selection.',
    `confidence_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum AI model confidence score (0-100%) required for automated criterion evaluation to be accepted without manual review.',
    `cpt_code` STRING COMMENT 'CPT code identifying the specific procedure referenced by this criterion when the criterion involves prior procedure history.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility criterion record was first created in the system.',
    `criterion_category` STRING COMMENT 'Broad clinical category of the criterion such as demographic, diagnosis, laboratory value, medication history, procedure history, or vital sign measurement.',
    `criterion_code` STRING COMMENT 'Externally-known unique business identifier code for this eligibility criterion, used for cross-system referencing and regulatory submissions.',
    `criterion_description` STRING COMMENT 'Detailed free-text description of the eligibility criterion as written in the clinical trial protocol, providing full clinical context for the requirement.',
    `criterion_name` STRING COMMENT 'Human-readable descriptive name of the eligibility criterion, used for display in clinical trial matching interfaces and reports.',
    `criterion_type` STRING COMMENT 'Classification of whether this criterion is an inclusion criterion (patient must meet) or exclusion criterion (patient must not meet) for trial eligibility.',
    `data_element_source` STRING COMMENT 'The source system or data domain from which the criterion evaluation data is extracted (e.g., EHR clinical documentation, laboratory information system, pharmacy system, patient-reported outcomes, or claims data).',
    `effective_end_date` DATE COMMENT 'Date after which this criterion version is no longer used for patient eligibility screening. Null indicates currently active.',
    `effective_start_date` DATE COMMENT 'Date from which this criterion version becomes effective for patient eligibility screening.',
    `evaluation_logic_expression` STRING COMMENT 'Formal logical expression or CQL (Clinical Quality Language) statement defining how this criterion is computationally evaluated against patient data.',
    `evidence_level` STRING COMMENT 'The level of clinical evidence supporting this criterions inclusion in the trial protocol, following evidence-based medicine hierarchy.',
    `exception_allowed` BOOLEAN COMMENT 'Indicates whether a principal investigator may grant an exception to this criterion for individual patients based on clinical judgment.',
    `exception_justification_required` BOOLEAN COMMENT 'Indicates whether a documented justification is required when an exception is granted for this criterion.',
    `fhir_resource_type` STRING COMMENT 'The FHIR resource type from which data for this criterion is sourced (e.g., Condition, Observation, MedicationStatement, Procedure), enabling interoperable data retrieval.',
    `fhir_search_parameter` STRING COMMENT 'The specific FHIR search parameter or path expression used to query patient data for evaluating this criterion programmatically.',
    `gender_requirement` STRING COMMENT 'The gender requirement for this criterion when the criterion is gender-specific. Value of all indicates no gender restriction.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code associated with this criterion when the criterion is diagnosis-based, enabling structured matching against patient problem lists.',
    `irb_approval_date` DATE COMMENT 'Date on which the Institutional Review Board approved this criterion as part of the study protocol, required for regulatory compliance.',
    `is_ai_evaluable` BOOLEAN COMMENT 'Indicates whether this criterion can be automatically evaluated by the AI/ML matching algorithm using structured EHR data, or requires manual clinical review.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this criterion is mandatory (must be met for eligibility) or optional/preferred (contributes to scoring but does not disqualify).',
    `last_validated_date` DATE COMMENT 'Date when this criterions logic and thresholds were last clinically validated against current medical evidence and guidelines.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the specific laboratory test or clinical observation that this criterion evaluates, used for lab-value-based eligibility matching.',
    `lookback_period_days` STRING COMMENT 'The number of days to look back in patient history when evaluating this criterion. For example, a lab value criterion may require results within the last 90 days.',
    `ndc_code` STRING COMMENT 'National Drug Code identifying the specific medication referenced by this criterion when the criterion involves medication history or current therapy.',
    `nlp_extraction_required` BOOLEAN COMMENT 'Indicates whether evaluation of this criterion requires NLP extraction from unstructured clinical notes rather than structured data fields.',
    `notes` STRING COMMENT 'Additional clinical or operational notes about this criterion, including special handling instructions, known data quality issues, or implementation considerations.',
    `operator` STRING COMMENT 'The logical comparison operator used to evaluate the criterion against patient data (e.g., equals, not equals, greater than, less than, between, contains).',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the relative importance or evaluation order of this criterion within the trials eligibility criteria set. Lower numbers indicate higher priority.',
    `regulatory_basis` STRING COMMENT 'Reference to the specific regulatory requirement or guidance that mandates or supports this eligibility criterion (e.g., FDA label indication, CMS coverage determination).',
    `threshold_high` DECIMAL(18,2) COMMENT 'The upper bound numeric value for range-based criteria (used with between operator), representing the maximum acceptable value for eligibility.',
    `threshold_low` DECIMAL(18,2) COMMENT 'The lower bound numeric value for range-based criteria (used with between operator), representing the minimum acceptable value for eligibility.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The target value or threshold against which patient data is compared for this criterion. Stored as string to accommodate numeric, coded, and text-based criteria values.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for numeric threshold values (e.g., mg/dL, mmHg, years, kg/m2), following UCUM standards for clinical data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility criterion record was last modified.',
    `version_number` STRING COMMENT 'Version number of this criterion definition, incremented when the criterion logic or thresholds are modified during protocol amendments.',
    CONSTRAINT pk_clinical_ai_trial_eligibility_criteria PRIMARY KEY(`clinical_ai_trial_eligibility_criteria_id`)
) COMMENT 'Table for clinical trial eligibility criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` (
    `trial_eligibility_evaluation_id` BIGINT COMMENT 'Primary key for trial_eligibility_evaluation',
    `care_site_id` BIGINT COMMENT 'Identifier of the clinical research site where the eligibility evaluation was conducted or where the patient would be enrolled.',
    `clinical_ai_trial_eligibility_criteria_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_trial_eligibility_criteria. Business justification: Trial eligibility evaluation evaluates a patient against specific eligibility criteria. This is a natural parent-child relationship where the evaluation references which criteria set was used. Connect',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `previous_evaluation_trial_eligibility_evaluation_id` BIGINT COMMENT 'Reference to the prior eligibility evaluation record if this is a re-evaluation, enabling longitudinal tracking of eligibility changes.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial or research study against which the patient is being evaluated for eligibility.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical reviewer (physician or PI) who validated or overrode the automated eligibility determination.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Identifier of the AI/ML model version used to generate the eligibility assessment, enabling model governance and reproducibility.',
    `trial_clinician_id` BIGINT COMMENT 'Identifier of the provider (principal investigator, research coordinator, or AI system) that performed or initiated the eligibility evaluation.',
    `trial_model_card_clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: Trial eligibility evaluation uses an ML model (ml_model_id exists as raw BIGINT). Adding model_card_id FK connects the evaluation to the governed AI model card that performed the eligibility assessmen',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the eligibility evaluation was triggered or performed, if applicable.',
    `age_at_evaluation` STRING COMMENT 'Patient age in years at the time of eligibility evaluation, used for age-based inclusion/exclusion criteria assessment.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Model confidence level (0.0000 to 1.0000) in the eligibility determination, reflecting data completeness and prediction certainty.',
    `consent_status` STRING COMMENT 'Status of informed consent for trial screening, indicating whether the patient has authorized the eligibility evaluation process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation record was first created in the system.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of required patient data elements available at the time of evaluation, indicating how much clinical information was accessible for the assessment.',
    `eligibility_score` DECIMAL(18,2) COMMENT 'Numeric probability score (0.0000 to 1.0000) representing the likelihood that the patient meets all trial eligibility criteria. Higher scores indicate stronger eligibility match.',
    `enrollment_recommendation` STRING COMMENT 'Final recommendation regarding patient enrollment into the trial based on the eligibility evaluation outcome and clinical judgment.',
    `evaluation_method` STRING COMMENT 'Method used to perform the eligibility evaluation, distinguishing between AI/ML-driven, manual clinical review, or hybrid approaches.',
    `evaluation_number` STRING COMMENT 'Business-facing unique reference number for the eligibility evaluation, used for tracking and audit purposes.',
    `evaluation_priority` STRING COMMENT 'Priority level assigned to the eligibility evaluation based on trial enrollment urgency, patient acuity, or study timeline constraints.',
    `evaluation_source_system` STRING COMMENT 'Name of the clinical system or AI platform that generated the eligibility evaluation (e.g., Epic Healthy Planet, custom NLP pipeline).',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the eligibility evaluation indicating where it stands in the assessment workflow.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation was performed or completed. Represents the principal business event time.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined for the trial protocol, providing the denominator for exclusion criteria assessment.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of exclusion criteria that the patient triggers, indicating disqualifying conditions identified during evaluation.',
    `exclusion_reason_code` STRING COMMENT 'Standardized code representing the category of exclusion reason, enabling structured reporting and analytics on ineligibility patterns.',
    `expiration_date` DATE COMMENT 'Date after which the eligibility evaluation result is no longer considered valid and a re-evaluation is required, typically based on protocol-defined windows.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of inclusion criteria that the patient satisfies for the trial, used to quantify eligibility completeness.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined for the trial protocol, providing the denominator for inclusion criteria assessment.',
    `irb_approval_reference` STRING COMMENT 'Reference number of the IRB approval under which this eligibility screening is conducted, ensuring regulatory compliance.',
    `matching_diagnosis_codes` STRING COMMENT 'ICD-10 diagnosis codes from the patient record that matched trial inclusion criteria, stored as comma-separated values. Contains PHI.',
    `matching_lab_results_summary` STRING COMMENT 'Summary of laboratory results that were evaluated against trial criteria (e.g., eGFR, HbA1c values), supporting clinical decision transparency. Contains PHI.',
    `matching_medication_codes` STRING COMMENT 'NDC or RxNorm codes of medications from the patient record relevant to trial criteria evaluation, stored as comma-separated values. Contains PHI.',
    `missing_data_elements` STRING COMMENT 'Comma-separated list of clinical data elements that were unavailable or incomplete during evaluation, identifying gaps that may affect determination accuracy.',
    `model_version` STRING COMMENT 'Semantic version of the AI/ML model used for this evaluation, supporting reproducibility and audit trail requirements.',
    `nlp_extraction_summary` STRING COMMENT 'Summary of key clinical concepts extracted via NLP from unstructured clinical notes that informed the eligibility determination. Contains PHI.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments recorded during the eligibility evaluation process by the evaluator or reviewer. May contain PHI.',
    `overall_determination` STRING COMMENT 'Final eligibility determination outcome for the patient against the trial criteria, representing the conclusive assessment result.',
    `override_reason` STRING COMMENT 'Free-text explanation provided by the reviewer when overriding the automated eligibility determination, supporting audit and model improvement.',
    `primary_exclusion_reason` STRING COMMENT 'Primary reason for ineligibility when the patient is determined ineligible, describing the most significant disqualifying criterion. May contain PHI related to health conditions.',
    `processing_duration_seconds` DECIMAL(18,2) COMMENT 'Time in seconds taken to complete the eligibility evaluation computation, used for performance monitoring and SLA compliance.',
    `protocol_version` STRING COMMENT 'Version of the clinical trial protocol against which eligibility was assessed, ensuring traceability to the specific criteria set used.',
    `re_evaluation_flag` BOOLEAN COMMENT 'Indicates whether this evaluation is a re-assessment of a previously evaluated patient, typically triggered by new clinical data or protocol amendments.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when a human reviewer validated, confirmed, or overrode the eligibility evaluation result.',
    `reviewer_override_flag` BOOLEAN COMMENT 'Indicates whether a human reviewer overrode the AI/automated eligibility determination, critical for model governance and bias monitoring.',
    `trial_arm_recommendation` STRING COMMENT 'Recommended trial arm or cohort for the patient based on the eligibility evaluation, if the trial has multiple arms with different criteria.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation record was last modified.',
    CONSTRAINT pk_trial_eligibility_evaluation PRIMARY KEY(`trial_eligibility_evaluation_id`)
) COMMENT 'Table for eligibility evaluation results per patient.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` (
    `clinical_ai_dynamic_cohort_definition_id` BIGINT COMMENT 'Primary key for clinical_ai_dynamic_cohort_definition',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: Reconsidered: clinical_ai_dynamic_cohort_definition uses AI models (model_algorithm_name, sensitivity_score, specificity_score). Without this FK, the product is siloed (self-ref PK doesnt count as a ',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical leader or medical director who approved this cohort definition for production use.',
    `clinical_employee_id` BIGINT COMMENT 'Identifier of the clinical informaticist, data analyst, or physician who authored this cohort definition.',
    `parent_cohort_definition_clinical_ai_dynamic_cohort_definition_id` BIGINT COMMENT 'Reference to a parent cohort definition from which this cohort was derived or refined, enabling hierarchical cohort relationships.',
    `measure_id` BIGINT COMMENT 'Identifier of the associated quality measure (HEDIS, MIPS, or CMS eCQM) that this cohort definition supports for denominator or numerator population identification.',
    `care_gap_category` STRING COMMENT 'Category of care gap this cohort is designed to identify, such as overdue screenings, missed follow-ups, medication non-adherence, or uncontrolled chronic conditions.',
    `clinical_ai_dynamic_cohort_definition_description` STRING COMMENT 'Detailed narrative describing the clinical intent, target population characteristics, and intended use of the dynamic cohort.',
    `clinical_ai_dynamic_cohort_definition_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively computing membership or has been deactivated.',
    `clinical_domain` STRING COMMENT 'The clinical specialty or disease domain this cohort targets, such as cardiology, oncology, diabetes management, behavioral health, or preventive care.',
    `cohort_code` STRING COMMENT 'Unique business code for the cohort definition used for programmatic reference across clinical AI systems and interoperability interfaces.',
    `cohort_name` STRING COMMENT 'Human-readable name identifying the dynamic cohort definition, used for display in population health dashboards and care management workflows.',
    `cohort_type` STRING COMMENT 'Classification of the cohort by its primary purpose, determining how the cohort is used in population health management, quality reporting, or research workflows.',
    `composition_logic` STRING COMMENT 'Set operation used to combine child cohorts when this is a composite cohort definition.',
    `cpt_code_list` STRING COMMENT 'Comma-separated list of CPT procedure codes used as criteria for cohort membership based on procedures received or ordered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was first created in the system.',
    `criteria_language` STRING COMMENT 'The formal language or syntax used to express the inclusion and exclusion criteria, enabling proper parsing and execution by the cohort computation engine.',
    `data_source_systems` STRING COMMENT 'Comma-separated list of source clinical systems whose data feeds the cohort computation, such as Epic EHR, Beaker LIS, or claims data warehouse.',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition is no longer active, nullable for open-ended definitions that remain in perpetual use.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition becomes active and begins computing membership for clinical workflows.',
    `estimated_member_count` BIGINT COMMENT 'Approximate number of patients currently meeting the cohort criteria as of the last refresh, used for capacity planning and resource allocation.',
    `exclusion_criteria_expression` STRING COMMENT 'Structured logical expression defining conditions that exclude patients from cohort membership even if inclusion criteria are met, such as hospice status or terminal diagnosis.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for the cohort, applicable for gender-specific screening or disease cohorts such as cervical cancer or prostate cancer registries.',
    `hipaa_minimum_necessary` BOOLEAN COMMENT 'Indicates whether this cohort definition has been reviewed for HIPAA minimum necessary standard compliance, ensuring only required PHI elements are accessed.',
    `icd10_code_list` STRING COMMENT 'Comma-separated list of ICD-10 diagnosis codes that define the clinical conditions for cohort inclusion, supporting both specific codes and code ranges.',
    `inclusion_criteria_expression` STRING COMMENT 'Structured logical expression defining the inclusion rules for cohort membership, expressed in a query-compatible format referencing clinical data elements such as diagnoses, procedures, lab results, and demographics.',
    `irb_approval_required` BOOLEAN COMMENT 'Indicates whether use of this cohort for research purposes requires Institutional Review Board approval prior to patient data access.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number associated with this cohort when used for research, linking to the approved research study.',
    `is_composite` BOOLEAN COMMENT 'Indicates whether this cohort is composed by combining (union, intersection, or exclusion) of other cohort definitions rather than direct clinical criteria.',
    `lab_result_criteria` STRING COMMENT 'Laboratory test result thresholds used for cohort inclusion, expressed as LOINC codes with value ranges (e.g., HbA1c > 9.0%).',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful computation of cohort membership, used to assess data currency for clinical decision support.',
    `lookback_period_days` STRING COMMENT 'Number of days into the past from the refresh date that clinical data is evaluated for cohort membership determination.',
    `maximum_age_years` STRING COMMENT 'Upper bound of the age range for cohort eligibility, used as a demographic filter in the cohort computation logic.',
    `medication_criteria` STRING COMMENT 'Medication-based criteria for cohort inclusion expressed as NDC codes, therapeutic classes, or medication names that patients must be actively prescribed.',
    `minimum_age_years` STRING COMMENT 'Lower bound of the age range for cohort eligibility, used as a demographic filter in the cohort computation logic.',
    `next_scheduled_refresh` TIMESTAMP COMMENT 'Timestamp when the next cohort membership recomputation is scheduled to execute based on the configured refresh frequency.',
    `notes` STRING COMMENT 'Free-text clinical or operational notes providing additional context about the cohort definition, its limitations, or special considerations for use.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated notifications are sent to care teams when patients enter or exit this cohort, enabling proactive outreach.',
    `owning_department` STRING COMMENT 'Clinical or operational department responsible for maintaining and governing this cohort definition, such as Population Health, Quality, or Care Management.',
    `payer_program_alignment` STRING COMMENT 'Value-based care or payer program this cohort aligns with, such as Medicare Advantage Star Ratings, ACO REACH, or commercial quality incentive programs.',
    `priority_level` STRING COMMENT 'Clinical urgency priority assigned to this cohort, determining the order in which care management teams address identified patients.',
    `refresh_frequency` STRING COMMENT 'How often the cohort membership is recomputed from source clinical data, balancing computational cost against the need for current membership lists.',
    `retention_period_days` STRING COMMENT 'Number of days that historical cohort membership snapshots are retained before purging, per organizational data governance and HIPAA retention policies.',
    `risk_model_name` STRING COMMENT 'Name of the AI/ML risk prediction model whose output scores are used as criteria for this cohort definition.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk score value required for cohort inclusion when the cohort is defined by AI-generated risk stratification scores.',
    `sdoh_criteria` STRING COMMENT 'Social determinants of health factors used for cohort inclusion such as food insecurity, housing instability, transportation barriers, or health literacy levels.',
    `sensitivity_score` DECIMAL(18,2) COMMENT 'Statistical sensitivity (true positive rate) of the cohort definition measured during validation, indicating how well it captures the intended population.',
    `specificity_score` DECIMAL(18,2) COMMENT 'Statistical specificity (true negative rate) of the cohort definition measured during validation, indicating how well it excludes non-target patients.',
    `target_intervention` STRING COMMENT 'Recommended clinical intervention or care pathway for patients identified in this cohort, such as outreach call, appointment scheduling, or medication review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was last modified, used for change tracking and audit purposes.',
    `validation_query` STRING COMMENT 'SQL or CQL query used to validate cohort membership accuracy against known patient populations during quality assurance testing.',
    `version_number` STRING COMMENT 'Sequential version number tracking iterations of this cohort definition as criteria are refined over time.',
    CONSTRAINT pk_clinical_ai_dynamic_cohort_definition PRIMARY KEY(`clinical_ai_dynamic_cohort_definition_id`)
) COMMENT 'Table defining dynamic population health cohorts';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` (
    `clinical_ai_population_health_id` BIGINT COMMENT 'Primary key for clinical_ai_population_health',
    `care_program_id` BIGINT COMMENT 'Reference to the care management program that utilizes this cohort for patient outreach and intervention planning.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare organization or department responsible for managing and acting upon this cohort definition.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: clinical_ai_population_health has model_version, confidence_level, sensitivity_score, specificity_score — all AI model metrics. Linking to model_card connects this population health cohort definition ',
    `clinician_id` BIGINT COMMENT 'Reference to the clinical leader or population health physician champion accountable for cohort outcomes and intervention oversight.',
    `measure_id` BIGINT COMMENT 'Reference to the quality measure (HEDIS, CMS Star, MIPS) that this cohort supports for performance tracking and regulatory reporting.',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for cohort eligibility. Null indicates no upper age bound.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for cohort eligibility. Null indicates no lower age bound.',
    `baseline_outcome_value` DECIMAL(18,2) COMMENT 'Measured value of the outcome metric at cohort creation or program start, serving as the benchmark against which improvement is tracked.',
    `clinical_ai_population_health_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively identifying patients.',
    `clinical_domain` STRING COMMENT 'Primary clinical specialty or disease domain that this cohort addresses. [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|pulmonology|nephrology|behavioral_health|neurology|orthopedics|obstetrics|pediatrics — promote to reference product]',
    `cohort_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this cohort definition for cross-system reference and reporting.',
    `cohort_description` STRING COMMENT 'Detailed narrative description of the cohorts clinical purpose, target population characteristics, and intended use in care management programs.',
    `cohort_name` STRING COMMENT 'Human-readable descriptive name of the population health cohort (e.g., Diabetic Patients with HbA1c > 9%, High-Risk Heart Failure Readmission).',
    `cohort_type` STRING COMMENT 'Classification of the cohort by its primary analytical purpose, determining how the cohort is used in population health management workflows.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level (0-1 scale) of the AI models cohort identification accuracy based on validation against clinical outcomes.',
    `cpt_code_set` STRING COMMENT 'Comma-separated list of CPT procedure codes used as criteria for identifying patients who have undergone specific interventions relevant to this cohort.',
    `current_member_count` STRING COMMENT 'Most recently computed count of patients currently meeting the cohort criteria as of the last refresh execution.',
    `data_source` STRING COMMENT 'Primary data source system(s) from which patient eligibility data is extracted for cohort computation (e.g., Epic Healthy Planet, claims data warehouse, HIE feed).',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition is no longer active. Null indicates an open-ended cohort with no planned retirement.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition becomes active and begins identifying qualifying patients for intervention.',
    `exclusion_criteria` STRING COMMENT 'Structured clinical logic expression defining which patients should be excluded from this cohort despite meeting inclusion criteria (e.g., hospice patients, deceased).',
    `hipaa_minimum_necessary` BOOLEAN COMMENT 'Indicates whether this cohort definition has been reviewed and certified to access only the minimum necessary PHI required for its stated purpose.',
    `icd10_code_set` STRING COMMENT 'Comma-separated list of ICD-10 diagnosis codes used as primary clinical criteria for cohort membership identification.',
    `inclusion_criteria` STRING COMMENT 'Structured clinical logic expression defining which patients qualify for inclusion in this cohort (e.g., ICD-10 codes, lab value thresholds, age ranges, medication history).',
    `intervention_type` STRING COMMENT 'Primary type of clinical intervention recommended for patients identified in this cohort to close care gaps or reduce risk.',
    `irb_approval_required` BOOLEAN COMMENT 'Indicates whether use of this cohort for research purposes requires Institutional Review Board approval due to the nature of data accessed.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the cohort membership was last recalculated by the population health analytics engine.',
    `model_version` STRING COMMENT 'Semantic version of the AI/ML model or algorithm used to define and score this cohort, supporting model governance and reproducibility.',
    `next_scheduled_refresh` TIMESTAMP COMMENT 'Planned date and time for the next cohort membership recalculation based on the configured refresh frequency.',
    `outcome_measure` STRING COMMENT 'Primary clinical or operational outcome metric used to evaluate the effectiveness of interventions applied to this cohort (e.g., 30-day readmission rate, HbA1c reduction).',
    `priority_level` STRING COMMENT 'Organizational priority ranking of this cohort for resource allocation, determining which cohorts receive intervention resources first.',
    `refresh_frequency` STRING COMMENT 'How often the cohort membership is recalculated by the population health engine to capture new qualifying patients and remove those no longer meeting criteria.',
    `risk_score_model_name` STRING COMMENT 'Name of the AI/ML risk stratification model used to score patients within this cohort (e.g., LACE Index, HCC Risk Adjustment, custom ML model).',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk score value that qualifies a patient for inclusion in this cohort when risk-based stratification is applied.',
    `sdoh_criteria` STRING COMMENT 'Social determinants of health factors used in cohort identification such as food insecurity, housing instability, transportation barriers, encoded as structured criteria expression.',
    `sensitivity_score` DECIMAL(18,2) COMMENT 'True positive rate (sensitivity/recall) of the cohort identification model measuring its ability to correctly identify all qualifying patients.',
    `specificity_score` DECIMAL(18,2) COMMENT 'True negative rate (specificity) of the cohort identification model measuring its ability to correctly exclude non-qualifying patients.',
    `target_outcome_value` DECIMAL(18,2) COMMENT 'Goal value for the outcome metric that the care program aims to achieve through interventions on this cohort population.',
    `target_population_size` STRING COMMENT 'Expected or estimated number of patients that should qualify for this cohort based on epidemiological data and organizational patient volume.',
    CONSTRAINT pk_clinical_ai_population_health PRIMARY KEY(`clinical_ai_population_health_id`)
) COMMENT 'Dynamic cohort definition table.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` (
    `population_cohort_id` BIGINT COMMENT 'Primary key for population_cohort',
    `care_site_id` BIGINT COMMENT 'Organization, department, or ACO that owns and maintains this cohort definition.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_ai_model_card. Business justification: population_cohort uses AI risk models (risk_model_name, risk_score_threshold_min/max). Connecting to model_card provides governance and lineage for the AI model used in cohort identification. Prevents',
    `clinician_id` BIGINT COMMENT 'Provider or care team lead accountable for managing interventions and outcomes for this cohort.',
    `measure_id` BIGINT COMMENT 'Identifier of the associated quality measure (CMS eCQM, NQF, or HEDIS measure) that this cohort supports, if applicable.',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for cohort eligibility. Null indicates no upper age bound.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for cohort eligibility. Null indicates no lower age bound.',
    `approval_date` DATE COMMENT 'Date on which the cohort definition was formally approved for operational use.',
    `approved_by` STRING COMMENT 'Name or role of the clinical or quality leadership authority who approved this cohort definition for production use.',
    `care_gap_category` STRING COMMENT 'Primary care gap or quality improvement opportunity this cohort is designed to identify and address.',
    `clinical_domain` STRING COMMENT 'Primary clinical specialty or disease domain that this cohort addresses. [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|pulmonology|nephrology|behavioral_health|neurology|orthopedics|obstetrics|pediatrics — promote to reference product]',
    `cohort_type` STRING COMMENT 'Classification of the cohort by its primary analytical or operational purpose.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before enrollment in this cohort (e.g., for research cohorts or opt-in programs).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was initially created in the system.',
    `current_member_count` STRING COMMENT 'Most recently calculated count of patients currently meeting cohort criteria. Updated during each refresh cycle.',
    `data_source_system` STRING COMMENT 'Primary source system from which patient data is evaluated for cohort membership (e.g., Epic Healthy Planet, Cerner HealtheIntent).',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition is no longer active. Null indicates an open-ended cohort.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition becomes active and patients begin to be identified and enrolled.',
    `exclusion_criteria_logic` STRING COMMENT 'Structured or semi-structured expression defining conditions that disqualify patients from cohort membership despite meeting inclusion criteria.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for cohort membership. All indicates no gender restriction.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether the cohort criteria and resulting patient data access comply with HIPAA minimum necessary standard.',
    `inclusion_criteria_logic` STRING COMMENT 'Structured or semi-structured expression defining the clinical, demographic, and utilization criteria patients must meet for cohort membership. May reference ICD-10, CPT, lab values, and demographic filters.',
    `intervention_type` STRING COMMENT 'Primary type of clinical intervention or outreach recommended for patients identified in this cohort.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number if this cohort is used for research purposes and requires institutional review board oversight.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the cohort membership was last recalculated and patient lists were updated.',
    `measurement_period_months` STRING COMMENT 'Lookback window in months used to evaluate patient clinical data against cohort criteria (e.g., 12 months for annual quality measures).',
    `population_cohort_code` STRING COMMENT 'Externally-known unique business code assigned to this cohort for cross-system reference and reporting.',
    `population_cohort_description` STRING COMMENT 'Detailed narrative describing the clinical rationale, target population characteristics, and intended use of this cohort.',
    `population_cohort_name` STRING COMMENT 'Human-readable descriptive name of the population cohort (e.g., Diabetes Type 2 High Risk Adults 65+).',
    `population_cohort_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively used for patient identification and reporting.',
    `priority_level` STRING COMMENT 'Organizational priority ranking indicating urgency of intervention for this patient population.',
    `program_affiliation` STRING COMMENT 'Value-based care program or initiative this cohort supports (e.g., ACO REACH, MSSP, Bundled Payments, commercial VBP contract).',
    `refresh_frequency` STRING COMMENT 'How often the cohort membership is recalculated by evaluating patients against inclusion/exclusion criteria.',
    `retention_period_months` STRING COMMENT 'Number of months cohort membership history must be retained per regulatory and organizational data governance policy.',
    `risk_model_name` STRING COMMENT 'Name of the predictive model or algorithm used to generate risk scores for cohort stratification (e.g., HCC v28, LACE Index, Custom Readmission Model).',
    `risk_score_threshold_max` DECIMAL(18,2) COMMENT 'Upper bound of the AI/ML-generated risk score for cohort inclusion. Null indicates no upper limit.',
    `risk_score_threshold_min` DECIMAL(18,2) COMMENT 'Lower bound of the AI/ML-generated risk score required for cohort inclusion. Used in risk stratification cohorts.',
    `sdoh_criteria_flag` BOOLEAN COMMENT 'Indicates whether this cohort incorporates Social Determinants of Health factors in its inclusion or stratification criteria.',
    `target_size` STRING COMMENT 'Expected or target number of patients to be enrolled in this cohort based on population estimates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was last modified.',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions to the cohort inclusion/exclusion criteria over time.',
    CONSTRAINT pk_population_cohort PRIMARY KEY(`population_cohort_id`)
) COMMENT 'Population health cohort definition and membership tracking tables';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` (
    `model_feature_mapping_id` BIGINT COMMENT 'Unique surrogate key for the model-feature mapping record.',
    `clinical_ai_feature_store_entity_id` BIGINT COMMENT 'Foreign key linking to the feature definition that is consumed by the model',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to the model card that consumes this feature',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this feature-model mapping was first created.',
    `effective_end_date` DATE COMMENT 'Date when this feature was removed from the models input feature set. NULL if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this feature was added to the models input feature set.',
    `feature_version` STRING COMMENT 'Version of the feature definition used by this specific model version.',
    `importance_score` DECIMAL(18,2) COMMENT 'SHAP or LIME feature importance score indicating how much this feature contributes to the specific models predictions. Value between 0 and 1.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this feature-model mapping is currently active for production inference.',
    `is_required` BOOLEAN COMMENT 'Indicates whether the model requires this feature for inference or can gracefully degrade without it.',
    `model_name` STRING COMMENT 'Name of the AI/ML model that consumes this feature. [Moved from feature_store_entity: This attribute on feature_store_entity tracks which model consumes the feature, but a feature can be consumed by multiple models. This data belongs to the M:N association, not to the feature entity itself.]',
    `model_version` STRING COMMENT 'Version of the consuming model. [Moved from feature_store_entity: This attribute on feature_store_entity tracks the version of the consuming model, but since a feature can be consumed by multiple model versions simultaneously, this belongs to the association.]',
    `rank` STRING COMMENT 'Ordinal rank of this features importance within the models feature set (1 = most important).',
    `transformation_applied` STRING COMMENT 'Model-specific transformation applied to the feature before model consumption (e.g., normalization, one-hot encoding, log transform).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this mapping.',
    CONSTRAINT pk_model_feature_mapping PRIMARY KEY(`model_feature_mapping_id`)
) COMMENT 'This association product represents the contractual relationship between a feature_store_entity and a model_card in clinical AI governance. It captures which features are consumed by which AI/ML models, with importance scores, version tracking, and required/optional status. Each record links one feature definition to one model card with attributes that exist only in the context of this specific feature-model relationship. This supports FDA SaMD documentation, model card governance, and MLOps feature lineage requirements.. Existence Justification: In MLOps and healthcare AI governance, the relationship between features and models is a well-established operational M:N. A single feature (e.g., patient_age, lab_value_trend) is consumed by multiple AI models simultaneously, and each model consumes multiple features as inputs. Healthcare AI governance frameworks (FDA SaMD, model cards per the user-king directive) require explicit documentation of which features each model uses, with importance scores, version tracking, and required/optional status. This is an actively managed operational relationship - data scientists and ML engineers create, update, and retire feature-model mappings as models are retrained.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` (
    `criteria_match_evaluation_id` BIGINT COMMENT 'Surrogate primary key for each criteria match evaluation record',
    `clinical_ai_clinical_nlp_result_id` BIGINT COMMENT 'Foreign key linking to the NLP extraction result that provides clinical evidence for the eligibility criterion evaluation',
    `eligibility_criteria_id` BIGINT COMMENT 'Foreign key linking to the trial eligibility criterion being evaluated against the NLP extraction',
    `criteria_met_flag` BOOLEAN COMMENT 'Indicates whether the eligibility criterion is considered satisfied by this NLP extraction based on the match evaluation',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when this match evaluation was performed or last updated',
    `match_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0 to 1.0) indicating how strongly the NLP extraction satisfies the eligibility criterion',
    `match_status` STRING COMMENT 'Current evaluation status of this NLP-to-criterion match as determined by the trial coordinator or automated system',
    CONSTRAINT pk_criteria_match_evaluation PRIMARY KEY(`criteria_match_evaluation_id`)
) COMMENT 'This association product represents the evaluation event between a clinical NLP extraction result and a trial eligibility criterion. It captures whether a specific NLP-extracted clinical concept satisfies a specific trial eligibility requirement, with match confidence scoring and evaluation status tracking. Each record links one clinical_nlp_result to one eligibility_criteria with attributes that exist only in the context of this matching relationship. Trial coordinators actively manage these evaluations as part of the clinical trial screening and patient matching workflow.. Existence Justification: In clinical trial matching workflows, trial coordinators actively evaluate NLP-extracted clinical concepts (e.g., HbA1c=8.2, diabetes diagnosis) against trial eligibility criteria. One NLP extraction can satisfy criteria across multiple trials simultaneously, and one eligibility criterion (e.g., must have Type 2 diabetes) can be evidenced by multiple NLP extractions from different patient notes. This is an operational process where coordinators actively create, review, and update match evaluations as part of the clinical trial screening workflow.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` (
    `model_tag_assignment_id` BIGINT COMMENT 'Unique surrogate key for the model tag assignment record',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to the AI model card that is being tagged for governance classification',
    `uc_tag_definition_id` BIGINT COMMENT 'Foreign key linking to the Unity Catalog tag definition being applied to the model',
    `applied_by` STRING COMMENT 'Identity of the user or service principal who applied the tag to the model, required for HIPAA audit compliance',
    `applied_timestamp` TIMESTAMP COMMENT 'Date-time when the tag was applied to the model card, supporting governance audit trail',
    `is_inherited` BOOLEAN COMMENT 'Indicates whether the tag was inherited from a parent model or catalog-level policy rather than explicitly assigned to this model card',
    `tag_value` DECIMAL(18,2) COMMENT 'The specific value assigned from the tag definitions allowed_values list (e.g., true, high, cardiology)',
    CONSTRAINT pk_model_tag_assignment PRIMARY KEY(`model_tag_assignment_id`)
) COMMENT 'This association product represents the governance assignment of Unity Catalog tag definitions to AI model cards. It captures which tags are applied to which models, the specific tag values, who applied them, and when — supporting HIPAA compliance audits, dynamic data masking policy enforcement, and clinical AI governance workflows. Each record links one model_card to one uc_tag_definition with attributes that exist only in the context of this tagging relationship.. Existence Justification: In healthcare AI governance, one AI model (model_card) requires multiple Unity Catalog tag definitions (PHI, PII, risk_tier, department, sensitivity level) to properly classify its inputs and outputs for HIPAA compliance. Conversely, one tag definition (e.g., pii_phi) applies to many AI models across the organization. Healthcare data governance teams actively manage these tag assignments as part of model deployment workflows, tracking who applied each tag, when, and what value was assigned.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` (
    `feature_tag_application_id` BIGINT COMMENT 'Primary key for the feature_tag_application association',
    `clinical_ai_feature_store_entity_id` BIGINT COMMENT 'Foreign key linking to the feature store entity being tagged',
    `uc_tag_definition_id` BIGINT COMMENT 'Foreign key linking to the Unity Catalog tag definition being applied',
    `applied_by` STRING COMMENT 'Identity of the data steward or automated process that applied this tag to the feature, required for HIPAA audit trail.',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when this tag was applied to the feature entity, supporting audit trail for governance changes.',
    `is_sensitive_override` BOOLEAN COMMENT 'Indicates whether this specific tag application overrides the default sensitivity classification derived from the tag definition, allowing per-feature exceptions to standard governance rules.',
    `tag_value` DECIMAL(18,2) COMMENT 'The specific value assigned for this tag on this feature entity. For boolean tags like pii_phi this is true/false; for categorical tags like sensitivity_level this is the level.',
    CONSTRAINT pk_feature_tag_application PRIMARY KEY(`feature_tag_application_id`)
) COMMENT 'This association product represents the application of Unity Catalog tag definitions to feature store entities for PHI/PII classification and governance. Each record links one feature_store_entity to one uc_tag_definition with the specific tag value assigned, who applied it, and when. This enables dynamic data masking, row-level security policies, and HIPAA compliance auditing across the clinical AI feature store.. Existence Justification: In a Databricks healthcare lakehouse, feature store entities (ML features derived from clinical data) require multiple Unity Catalog tag classifications (pii_phi, pii_pii, pii_sensitive, data_domain, sensitivity_level) simultaneously, and each tag definition applies to hundreds or thousands of features across the catalog. This is an operational governance relationship that data stewards actively manage - they apply, modify, and revoke tag assignments as features change sensitivity classification. The relationship itself carries data (tag_value, applied_timestamp, applied_by, is_sensitive_override) that belongs to neither the feature nor the tag definition alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_governance_id` FOREIGN KEY (`governance_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`governance`(`governance_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_ai_cohort_definition_id` FOREIGN KEY (`ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_population_cohort_definition_ai_cohort_definition_id` FOREIGN KEY (`population_cohort_definition_ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_ai_cohort_membership_id` FOREIGN KEY (`ai_cohort_membership_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership`(`ai_cohort_membership_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_population_health_cohort_definition_id` FOREIGN KEY (`population_health_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition`(`population_health_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_bias_monitoring_bias_monitoring_id` FOREIGN KEY (`bias_monitoring_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring`(`bias_monitoring_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_bias_monitoring_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_bias_monitoring_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_fda_samd_id` FOREIGN KEY (`fda_samd_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`fda_samd`(`fda_samd_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ADD CONSTRAINT `fk_clinical_ai_cohort_management_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_ai_cohort_definition_id` FOREIGN KEY (`ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_clinical_ai_cohort_definition_id` FOREIGN KEY (`clinical_ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition`(`clinical_ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_clinical_nlp_result_id` FOREIGN KEY (`clinical_nlp_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result`(`clinical_nlp_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_care_gap_id` FOREIGN KEY (`care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`care_gap`(`care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_model_inference_log_id` FOREIGN KEY (`model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log`(`model_inference_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_feature_store_entity_id` FOREIGN KEY (`feature_store_entity_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity`(`feature_store_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_ai_cohort_membership_ai_cohort_definition_id` FOREIGN KEY (`ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ADD CONSTRAINT `fk_clinical_ai_model_version_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ADD CONSTRAINT `fk_clinical_ai_model_training_run_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ADD CONSTRAINT `fk_clinical_ai_model_training_run_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_population_cohort_definition_id` FOREIGN KEY (`population_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition`(`population_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_population_cohort_id` FOREIGN KEY (`population_cohort_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`population_cohort`(`population_cohort_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_management_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_mgmt_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_ai_governance_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_ai_governance_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_ai_governance_model_card_id` FOREIGN KEY (`model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_card`(`model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_clinical_ai_trial_eligibility_criteria_id` FOREIGN KEY (`clinical_ai_trial_eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria`(`clinical_ai_trial_eligibility_criteria_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_previous_evaluation_trial_eligibility_evaluation_id` FOREIGN KEY (`previous_evaluation_trial_eligibility_evaluation_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation`(`trial_eligibility_evaluation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_trial_model_card_clinical_ai_model_card_id` FOREIGN KEY (`trial_model_card_clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_dynamic_cohort_definition_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_dynamic_cohort_definition_parent_cohort_definition_clinical_ai_dynamic_cohort_definition_id` FOREIGN KEY (`parent_cohort_definition_clinical_ai_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition`(`clinical_ai_dynamic_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ADD CONSTRAINT `fk_clinical_ai_population_cohort_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ADD CONSTRAINT `fk_clinical_ai_model_feature_mapping_clinical_ai_feature_store_entity_id` FOREIGN KEY (`clinical_ai_feature_store_entity_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity`(`clinical_ai_feature_store_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ADD CONSTRAINT `fk_clinical_ai_model_feature_mapping_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ADD CONSTRAINT `fk_clinical_ai_criteria_match_evaluation_clinical_ai_clinical_nlp_result_id` FOREIGN KEY (`clinical_ai_clinical_nlp_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result`(`clinical_ai_clinical_nlp_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ADD CONSTRAINT `fk_clinical_ai_model_tag_assignment_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ADD CONSTRAINT `fk_clinical_ai_feature_tag_application_clinical_ai_feature_store_entity_id` FOREIGN KEY (`clinical_ai_feature_store_entity_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity`(`clinical_ai_feature_store_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`clinical_ai` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `healthcare_ecm_v1`.`clinical_ai` SET TAGS ('dbx_domain' = 'clinical_ai');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'patient_risk_score Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `explanation_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `explanation_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `prediction_date` SET TAGS ('dbx_business_glossary_term' = 'Prediction Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `feature_set_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_nlp_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `extracted_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `extracted_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `normalized_concept` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `normalized_concept` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `sentence_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `sentence_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `source_note_type` SET TAGS ('dbx_business_glossary_term' = 'Source Note Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `source_note_type` SET TAGS ('dbx_value_regex' = 'progress_note|discharge_summary|consult_note|procedure_note|radiology_report');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'NLP Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'NLP Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `concept_display` SET TAGS ('dbx_business_glossary_term' = 'Concept Display Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `certainty` SET TAGS ('dbx_business_glossary_term' = 'Certainty');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `certainty` SET TAGS ('dbx_value_regex' = 'certain|probable|possible|unknown');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `source_text_snippet` SET TAGS ('dbx_business_glossary_term' = 'Source Text Snippet');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Extraction Method');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `extraction_method` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|deep_learning|hybrid');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `processing_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (ms)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ar');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Annotation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ALTER COLUMN `related_concept_codes` SET TAGS ('dbx_business_glossary_term' = 'Related Concept Codes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'care_gap Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Severity');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Recommendation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'identified|in_progress|resolved|closed|dismissed');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Detection Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Resolution Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'AI Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `intervention_due_date` SET TAGS ('dbx_business_glossary_term' = 'Intervention Due Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `resolved_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Resolver User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `care_gap_category` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `care_gap_category` SET TAGS ('dbx_value_regex' = 'preventive|diagnostic|therapeutic|educational');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_inference_log_id` SET TAGS ('dbx_business_glossary_term' = 'model_inference_log Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `explanation_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `explanation_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `prediction_output` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `prediction_output` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `risk_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `risk_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `secondary_output_json` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `secondary_output_json` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inference Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `input_features_hash` SET TAGS ('dbx_business_glossary_term' = 'Input Features Hash');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `nlp_entities` SET TAGS ('dbx_business_glossary_term' = 'NLP Extracted Entities');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `nlp_entities` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `nlp_entities` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `prediction_label` SET TAGS ('dbx_business_glossary_term' = 'Prediction Label');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `prediction_probability` SET TAGS ('dbx_business_glossary_term' = 'Prediction Probability');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `inference_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Inference Duration (ms)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_store_entity_id` SET TAGS ('dbx_business_glossary_term' = 'feature_store_entity Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `steward_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `steward_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_type` SET TAGS ('dbx_value_regex' = 'numeric|categorical|binary|text|datetime|boolean');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'int|bigint|float|double|decimal|string|boolean|date|timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `source_column` SET TAGS ('dbx_business_glossary_term' = 'Source Column');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `transformation_logic` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `feature_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|retired');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `risk_score_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `nlp_result` SET TAGS ('dbx_business_glossary_term' = 'NLP Result');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `inference_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inference Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `delta_table_properties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_business_glossary_term' = 'Unity Catalog Tags');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `rls_predicate` SET TAGS ('dbx_business_glossary_term' = 'Row-Level Security Predicate');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `clustering_columns` SET TAGS ('dbx_business_glossary_term' = 'Clustering Columns');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_store_entity` ALTER COLUMN `last_validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_delta_enableChangeDataFeed' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` SET TAGS ('dbx_liquid_clustering_keys' = 'cohort_definition_id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `research_clinical_trial_matching_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_delta_enableChangeDataFeed' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_liquid_clustering_keys' = 'cohort_definition_id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_mpi_id' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` SET TAGS ('dbx_pii_phi' = 'mpi_id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ALTER COLUMN `clinical_ai_population_health_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ALTER COLUMN `clinical_ai_population_health_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ALTER COLUMN `clinical_ai_population_health_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_model_card Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Owner Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `databricks_governance_delta_tblproperties4_id` SET TAGS ('dbx_business_glossary_term' = 'Delta Tblproperties Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `databricks_governance_rls_predicates_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicates Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `databricks_governance_uc_tag_definitions_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Tag Definitions Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `rls_predicate_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicate Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `scd_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Scd Configuration Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `scd_type2_config_id` SET TAGS ('dbx_business_glossary_term' = 'Scd Config Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Target Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `clinical_ai_model_card_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'HIPAA|GDPR|HITECH|None');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `data_quality_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `delta_tblproperties_reference` SET TAGS ('dbx_business_glossary_term' = 'Tblproperties Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `inference_log_table` SET TAGS ('dbx_business_glossary_term' = 'Inference Log Table');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `metric_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metric Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_card_status` SET TAGS ('dbx_business_glossary_term' = 'Model Card Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_card_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Environment');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_value_regex' = 'dev|test|prod');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Model Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_input_schema` SET TAGS ('dbx_business_glossary_term' = 'Model Input Schema');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_output_schema` SET TAGS ('dbx_business_glossary_term' = 'Model Output Schema');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Training End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Training Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'risk_score|nlp|prediction|classification|regression');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `nlp_result_table` SET TAGS ('dbx_business_glossary_term' = 'NLP Result Table');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Role');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `performance_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `performance_metric_name` SET TAGS ('dbx_value_regex' = 'accuracy|precision|recall|f1|auc|rmse');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `performance_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Model Purpose');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|exempt');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = '7_years|indefinite|custom');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `retention_policy` SET TAGS ('dbx_unity_catalog_tag' = 'hipaa_retention');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `risk_score_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `risk_score_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `training_data_source` SET TAGS ('dbx_business_glossary_term' = 'Training Data Source');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `training_data_version` SET TAGS ('dbx_business_glossary_term' = 'Training Data Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `clinical_ai_bias_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_bias_monitoring Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `bias_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Bias Monitoring ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bias Assessment Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Bias Assessment Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'fairness|disparity|calibration');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `dataset_reference` SET TAGS ('dbx_business_glossary_term' = 'Dataset ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('dbx_value_regex' = 'stat_parity_diff|equal_opportunity_diff|average_odds_diff|disparate_impact|false_positive_rate_diff|false_negative_rate_diff');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `metric_status` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `metric_status` SET TAGS ('dbx_value_regex' = 'pass|fail|warning');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `metric_threshold` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Threshold');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `protected_attribute` SET TAGS ('dbx_business_glossary_term' = 'Protected Attribute (e.g., race, gender)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `protected_attribute` SET TAGS ('dbx_value_regex' = 'race|gender|age|ethnicity|disability|sexual_orientation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `remediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Assessment');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `clinical_ai_fda_samd_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_fda_samd Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Submission Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `databricks_governance_hipaa_retention_annotations_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Retention Annotations Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `fda_samd_id` SET TAGS ('dbx_business_glossary_term' = 'FDA Software as a Medical Device Submission ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `artifact_uri` SET TAGS ('dbx_business_glossary_term' = 'Artifact URI');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `clinical_ai_fda_samd_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `clinical_ai_fda_samd_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `clinical_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Validation Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `clinical_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `data_version` SET TAGS ('dbx_business_glossary_term' = 'Data Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `device_udi` SET TAGS ('dbx_business_glossary_term' = 'Device Unique Device Identifier (UDI)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `device_udi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `metric_units` SET TAGS ('dbx_business_glossary_term' = 'Metric Units');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `performance_metric` SET TAGS ('dbx_value_regex' = 'auc|accuracy|precision|recall|f1_score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = '5_years|10_years|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `review_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review End Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = '510k|pma|de_novo|clearance|exempt');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ALTER COLUMN `validation_dataset_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Dataset ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_delta_autoOptimize_autoCompact' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_domain' = 'clinical_ai');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` SET TAGS ('dbx_uc_catalog' = 'healthcare');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_population_health_cohort Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `clinical_ai_population_health_cohort_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` SET TAGS ('dbx_clinical_ai_governance' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` SET TAGS ('dbx_ai_oversight' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` SET TAGS ('dbx_fda_samd_governance' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` SET TAGS ('dbx_hipaa_compliant' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ALTER COLUMN `rls_predicate_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicate Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ALTER COLUMN `clinical_ai_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ALTER COLUMN `clinical_ai_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Clinical Ai Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_patient_risk_score Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_rls_predicate_rls_predicate' = 'patient_id = current_user()');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Model Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `feature_set_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `prediction_date` SET TAGS ('dbx_business_glossary_term' = 'Prediction Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'epic|cerner|custom');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinical_ai_clinical_nlp_result_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_clinical_nlp_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinical_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical NLP Result ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `note_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `note_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Observation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `annotation_reference` SET TAGS ('dbx_business_glossary_term' = 'Annotation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `certainty` SET TAGS ('dbx_business_glossary_term' = 'Certainty');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `certainty` SET TAGS ('dbx_value_regex' = 'certain|probable|possible|unknown');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinical_ai_clinical_nlp_result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `clinical_ai_clinical_nlp_result_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `concept_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Concept Code (SNOMED CT)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `concept_display` SET TAGS ('dbx_business_glossary_term' = 'Concept Display Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Extraction Method');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `extraction_method` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|deep_learning|hybrid');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `extraction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Extraction Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ar');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'NLP Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `negation_flag` SET TAGS ('dbx_business_glossary_term' = 'Negation Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `processing_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (ms)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `related_concept_codes` SET TAGS ('dbx_business_glossary_term' = 'Related Concept Codes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `source_note_type` SET TAGS ('dbx_business_glossary_term' = 'Source Note Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `source_note_type` SET TAGS ('dbx_value_regex' = 'progress_note|discharge_summary|consult_note|procedure_note|radiology_report');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'epic|cerner|meditech|custom');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `source_text_snippet` SET TAGS ('dbx_business_glossary_term' = 'Source Text Snippet');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `temporality` SET TAGS ('dbx_business_glossary_term' = 'Temporality');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `temporality` SET TAGS ('dbx_value_regex' = 'past|present|future|unknown');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `clinical_ai_care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_care_gap Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `care_plan_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goal Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolver User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Observation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `follow_up_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Gap Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `laboratory_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Recommended Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `care_gap_category` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `care_gap_category` SET TAGS ('dbx_value_regex' = 'preventive|diagnostic|therapeutic|educational');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `clinical_ai_care_gap_status` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `clinical_ai_care_gap_status` SET TAGS ('dbx_value_regex' = 'identified|in_progress|resolved|closed|dismissed');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Detection Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Severity');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'medication|screening|follow_up|lifestyle|vaccination');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `intervention_due_date` SET TAGS ('dbx_business_glossary_term' = 'Intervention Due Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Recommendation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Resolution Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'epic|cerner|custom_ai');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `clinical_ai_model_inference_log_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_model_inference_log Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `model_inference_log_id` SET TAGS ('dbx_business_glossary_term' = 'Model Inference Log ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Model Version Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inference Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `inference_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Inference Duration (ms)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `inference_status` SET TAGS ('dbx_business_glossary_term' = 'Inference Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `inference_status` SET TAGS ('dbx_value_regex' = 'success|failure|partial');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `input_features_hash` SET TAGS ('dbx_business_glossary_term' = 'Input Features Hash');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `nlp_entities` SET TAGS ('dbx_business_glossary_term' = 'NLP Extracted Entities');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `nlp_entities` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `nlp_entities` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `prediction_label` SET TAGS ('dbx_business_glossary_term' = 'Prediction Label');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `prediction_probability` SET TAGS ('dbx_business_glossary_term' = 'Prediction Probability');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Clinical Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `risk_score_category` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `clinical_ai_feature_store_entity_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_feature_store_entity Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `databricks_governance_delta_tblproperties4_id` SET TAGS ('dbx_business_glossary_term' = 'Tblproperties Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `databricks_governance_rls_predicates_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicates Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `databricks_governance_uc_tag_definitions_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Tag Definitions Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `feature_store_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Store Entity ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `liquid_clustering_config_id` SET TAGS ('dbx_business_glossary_term' = 'Clustering Config Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `rls_predicate_id` SET TAGS ('dbx_business_glossary_term' = 'Rls Predicate Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `feature_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `feature_type` SET TAGS ('dbx_value_regex' = 'numeric|categorical|binary|text|datetime|boolean');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `feature_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `inference_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inference Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `last_validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|retired');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `nlp_result` SET TAGS ('dbx_business_glossary_term' = 'NLP Result');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `risk_score_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `source_column` SET TAGS ('dbx_business_glossary_term' = 'Source Column');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `source_table` SET TAGS ('dbx_business_glossary_term' = 'Source Table');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `transformation_logic` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_card_id` SET TAGS ('dbx_business_glossary_term' = 'model_card Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'risk_score|nlp|prediction|classification|regression');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Model Purpose');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Role');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `risk_score_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `risk_score_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `nlp_result_table` SET TAGS ('dbx_business_glossary_term' = 'NLP Result Table');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `inference_log_table` SET TAGS ('dbx_business_glossary_term' = 'Inference Log Table');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `training_data_source` SET TAGS ('dbx_business_glossary_term' = 'Training Data Source');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `training_data_version` SET TAGS ('dbx_business_glossary_term' = 'Training Data Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `performance_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `performance_metric_name` SET TAGS ('dbx_value_regex' = 'accuracy|precision|recall|f1|auc|rmse');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `performance_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `metric_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metric Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|exempt');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = '7_years|indefinite|custom');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_business_glossary_term' = 'Unity Catalog Tags');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `rls_predicate` SET TAGS ('dbx_business_glossary_term' = 'Row‑Level Security Predicate');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `scd_type` SET TAGS ('dbx_business_glossary_term' = 'Slowly Changing Dimension Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `scd_type` SET TAGS ('dbx_value_regex' = 'type2|type1|none');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `liquid_clustering` SET TAGS ('dbx_business_glossary_term' = 'Liquid Clustering Specification');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_card_status` SET TAGS ('dbx_business_glossary_term' = 'Model Card Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_card_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'HIPAA|GDPR|HITECH|None');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `data_quality_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_input_schema` SET TAGS ('dbx_business_glossary_term' = 'Model Input Schema');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_output_schema` SET TAGS ('dbx_business_glossary_term' = 'Model Output Schema');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Training Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Training End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Environment');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_value_regex' = 'dev|test|prod');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Email');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_card` ALTER COLUMN `model_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Model Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `bias_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'bias_monitoring Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Dataset ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bias Assessment Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Bias Assessment Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'fairness|disparity|calibration');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `protected_attribute` SET TAGS ('dbx_business_glossary_term' = 'Protected Attribute (e.g., race, gender)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `protected_attribute` SET TAGS ('dbx_value_regex' = 'race|gender|age|ethnicity|disability|sexual_orientation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_name` SET TAGS ('dbx_value_regex' = 'stat_parity_diff|equal_opportunity_diff|average_odds_diff|disparate_impact|false_positive_rate_diff|false_negative_rate_diff');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_threshold` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Threshold');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_status` SET TAGS ('dbx_business_glossary_term' = 'Bias Metric Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `metric_status` SET TAGS ('dbx_value_regex' = 'pass|fail|warning');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `remediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Assessment');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`bias_monitoring` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `fda_samd_id` SET TAGS ('dbx_business_glossary_term' = 'fda_samd Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = '510k|pma|de_novo|clearance|exempt');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `device_udi` SET TAGS ('dbx_business_glossary_term' = 'Device Unique Device Identifier (UDI)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `device_udi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `manufacturer_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `review_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review End Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `artifact_uri` SET TAGS ('dbx_business_glossary_term' = 'Artifact URI');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `data_version` SET TAGS ('dbx_business_glossary_term' = 'Data Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `validation_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Dataset ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `performance_metric` SET TAGS ('dbx_value_regex' = 'auc|accuracy|precision|recall|f1_score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `metric_units` SET TAGS ('dbx_business_glossary_term' = 'Metric Units');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `clinical_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Validation Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `clinical_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = '5_years|10_years|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`fda_samd` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `ai_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'AI Cohort Definition ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `ai_cohort_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Cohort Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `ai_cohort_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `ai_cohort_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `ai_cohort_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `cohort_category` SET TAGS ('dbx_business_glossary_term' = 'Cohort Category');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Custom');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `estimated_patient_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Patient Count');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `logic_expression` SET TAGS ('dbx_business_glossary_term' = 'Logic Expression');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = '7_years|5_years|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `risk_score_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Cohort Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Cohort Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `ai_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'AI Cohort Membership ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `ai_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'AI Cohort ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `ai_cohort_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `ai_cohort_membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `cohort_type` SET TAGS ('dbx_business_glossary_term' = 'Cohort Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `cohort_type` SET TAGS ('dbx_value_regex' = 'risk|gap|outcome|utilization|readmission|mortality');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `inclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Reason');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `inclusion_score` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'AI Cohort Membership Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `prediction_confidence` SET TAGS ('dbx_business_glossary_term' = 'Prediction Confidence');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `prediction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prediction Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `prediction_value` SET TAGS ('dbx_business_glossary_term' = 'Prediction Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Custom|Other');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `cohort_id` SET TAGS ('dbx_business_glossary_term' = 'AI Cohort ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Model Version ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `compliance_annotation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Annotation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `compute_environment` SET TAGS ('dbx_business_glossary_term' = 'Compute Environment');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `data_split` SET TAGS ('dbx_business_glossary_term' = 'Data Split');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `data_split` SET TAGS ('dbx_value_regex' = 'train|validation|test');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `deprecation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `evaluation_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `evaluation_metric_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metric Evaluation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `evaluation_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'ML Framework');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `framework` SET TAGS ('dbx_value_regex' = 'TensorFlow|PyTorch|Scikit-Learn|XGBoost|LightGBM');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `framework_version` SET TAGS ('dbx_business_glossary_term' = 'Framework Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters (JSON)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `input_features` SET TAGS ('dbx_business_glossary_term' = 'Input Features (JSON)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `is_production` SET TAGS ('dbx_business_glossary_term' = 'Production Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'risk_score|nlp_extraction|prediction|classification|regression');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_version_description` SET TAGS ('dbx_business_glossary_term' = 'Model Version Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_version_status` SET TAGS ('dbx_business_glossary_term' = 'Model Version Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_version_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|archived');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Model Version Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `output_schema` SET TAGS ('dbx_business_glossary_term' = 'Output Schema (JSON)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = 'retain_1yr|retain_3yr|retain_7yr|retain_indefinite');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `source_code_version` SET TAGS ('dbx_business_glossary_term' = 'Source Code Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Custom Tags');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `target_variable` SET TAGS ('dbx_business_glossary_term' = 'Target Variable');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `training_dataset_snapshot_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset Snapshot ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Model Version Description');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Model Version Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|archived');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `training_dataset_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset Snapshot ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `author_user_id` SET TAGS ('dbx_business_glossary_term' = 'Author User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `author_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `author_user_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `reviewer_user_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `reviewer_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ALTER COLUMN `reviewer_user_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `model_training_run_id` SET TAGS ('dbx_business_glossary_term' = 'Model Training Run ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Person Identifier (OWNER_ID)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Training Run Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `compute_node_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Compute Nodes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `compute_resource` SET TAGS ('dbx_business_glossary_term' = 'Compute Resource Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code (ISO 4217)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Training Cost in US Dollars');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `cpu_hours_consumed` SET TAGS ('dbx_business_glossary_term' = 'CPU Hours Consumed');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `evaluation_metric` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `framework_version` SET TAGS ('dbx_business_glossary_term' = 'Framework Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `gpu_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPU Enabled Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `gpu_hours_consumed` SET TAGS ('dbx_business_glossary_term' = 'GPU Hours Consumed');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `hyperparameters_json` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters JSON (JSON)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `loss_function` SET TAGS ('dbx_business_glossary_term' = 'Loss Function');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `memory_gb` SET TAGS ('dbx_business_glossary_term' = 'Average Memory Usage in GB');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `mlflow_run_reference` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier (MLFLOW_RUN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `model_artifact_uri` SET TAGS ('dbx_business_glossary_term' = 'Model Artifact URI');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `model_training_run_status` SET TAGS ('dbx_business_glossary_term' = 'Training Run Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `model_training_run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed|canceled');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `optimizer` SET TAGS ('dbx_business_glossary_term' = 'Optimization Algorithm');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'User-Defined Tags');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `training_data_version` SET TAGS ('dbx_business_glossary_term' = 'Training Data Version Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `training_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Seconds');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `training_framework` SET TAGS ('dbx_business_glossary_term' = 'Training Framework');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `training_framework` SET TAGS ('dbx_value_regex' = 'pytorch|tensorflow|sklearn|xgboost|lightgbm|catboost');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `mlflow_run_id` SET TAGS ('dbx_business_glossary_term' = 'MLflow Run Identifier (MLFLOW_RUN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Training Run Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed|canceled');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Person Identifier (OWNER_ID)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Trained Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ALTER COLUMN `clinical_ai_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ALTER COLUMN `criteria_expression` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ALTER COLUMN `criteria_expression` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ALTER COLUMN `population_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ALTER COLUMN `diagnosis_code_set` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ALTER COLUMN `diagnosis_code_set` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `population_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'population_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `population_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Population Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `current_risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `current_risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `medication_adherence_pct` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `medication_adherence_pct` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `qualifying_condition_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `qualifying_condition_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `risk_score_at_enrollment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ALTER COLUMN `risk_score_at_enrollment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ALTER COLUMN `clinical_ai_population_health_cohort_management_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_population_health_cohort_management Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ALTER COLUMN `clinical_ai_population_health_cohort_management_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ALTER COLUMN `clinical_ai_population_health_cohort_management_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ALTER COLUMN `clinical_ai_population_health_cohort_management_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ALTER COLUMN `clinical_ai_population_health_cohort_management_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_population_health_cohort_mgmt Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `clinical_ai_population_health_cohort_mgmt_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `clinical_ai_governance_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_clinical_ai_governance Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `clinical_responsible_data_scientist_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `clinical_responsible_data_scientist_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Governed Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Governed Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `clinical_ai_trial_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_trial_eligibility_criteria Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `clinical_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `clinical_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `gender_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ALTER COLUMN `gender_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `trial_eligibility_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'trial_eligibility_evaluation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `clinical_ai_trial_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Trial Eligibility Criteria Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `trial_model_card_clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `matching_diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `matching_diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `matching_lab_results_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `matching_lab_results_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `matching_medication_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `matching_medication_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `nlp_extraction_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `nlp_extraction_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `primary_exclusion_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ALTER COLUMN `primary_exclusion_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `clinical_ai_dynamic_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_dynamic_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `clinical_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `clinical_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ALTER COLUMN `clinical_ai_population_health_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_ai_population_health Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ALTER COLUMN `clinical_ai_population_health_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ALTER COLUMN `clinical_ai_population_health_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ALTER COLUMN `clinical_ai_population_health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ALTER COLUMN `clinical_ai_population_health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` SET TAGS ('dbx_subdomain' = 'cohort_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `population_cohort_id` SET TAGS ('dbx_business_glossary_term' = 'population_cohort Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Ai Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `exclusion_criteria_logic` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `exclusion_criteria_logic` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `inclusion_criteria_logic` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ALTER COLUMN `inclusion_criteria_logic` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` SET TAGS ('dbx_association_edges' = 'clinical_ai.feature_store_entity,clinical_ai.model_card');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `model_feature_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Model Feature Mapping ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `clinical_ai_feature_store_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Model Feature Mapping - Feature Store Entity Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Feature Mapping - Model Card Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mapping Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Feature Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Feature Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `feature_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Version in Model');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `importance_score` SET TAGS ('dbx_business_glossary_term' = 'Feature Importance Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Mapping Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Feature Required Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Feature Rank');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `transformation_applied` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Transformation');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_feature_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mapping Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` SET TAGS ('dbx_subdomain' = 'predictive_scoring');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` SET TAGS ('dbx_association_edges' = 'clinical_ai.clinical_nlp_result,clinical_trial_matching.eligibility_criteria');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `criteria_match_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Criteria Match Evaluation ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `clinical_ai_clinical_nlp_result_id` SET TAGS ('dbx_business_glossary_term' = 'Criteria Match Evaluation - Clinical Nlp Result Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Criteria Match Evaluation - Criteria Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Criteria Met Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` SET TAGS ('dbx_association_edges' = 'clinical_ai.model_card,uc_tags.uc_tag_definition');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `model_tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Model Tag Assignment ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Tag Assignment - Model Card Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `uc_tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Model Tag Assignment - Tag Definition Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `applied_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Applied By');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Applied Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `is_inherited` SET TAGS ('dbx_business_glossary_term' = 'Tag Inherited Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ALTER COLUMN `tag_value` SET TAGS ('dbx_business_glossary_term' = 'Tag Value');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` SET TAGS ('dbx_subdomain' = 'model_governance');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` SET TAGS ('dbx_association_edges' = 'clinical_ai.feature_store_entity,uc_tags.uc_tag_definition');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `feature_tag_application_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Tag Application - Feature Tag Application Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `clinical_ai_feature_store_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Tag Application - Feature Store Entity Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `uc_tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Tag Application - Tag Definition Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `applied_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Applier Identity');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Application Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `is_sensitive_override` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Override Flag');
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ALTER COLUMN `tag_value` SET TAGS ('dbx_business_glossary_term' = 'Applied Tag Value');
