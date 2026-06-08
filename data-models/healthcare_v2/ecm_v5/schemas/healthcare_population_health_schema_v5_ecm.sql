-- Schema for Domain: population_health | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`population_health` COMMENT 'Population health cohort management';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` (
    `population_health_dynamic_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_dynamic_cohort_definition',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the clinical or quality leader who approved this cohort definition for production use.',
    `care_program_id` BIGINT COMMENT 'Reference to the care management program that utilizes this cohort for patient outreach and intervention targeting.',
    `employee_id` BIGINT COMMENT 'Identifier of the user (analyst, clinician, or informaticist) who originally authored this cohort definition.',
    `organization_id` BIGINT COMMENT 'Organization or department that owns and maintains this cohort definition, responsible for clinical validity and updates.',
    `measure_id` BIGINT COMMENT 'Reference to the quality measure (e.g., HEDIS, MIPS) that this cohort definition supports, if applicable.',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for cohort eligibility, providing a quick-reference demographic boundary.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for cohort eligibility, providing a quick-reference demographic boundary.',
    `approval_date` DATE COMMENT 'Date on which the cohort definition was formally approved for active use in population health programs.',
    `population_health_dynamic_cohort_definition_code` STRING COMMENT 'Externally-known unique business identifier code for this cohort definition, used across Epic Healthy Planet registries and analytics platforms.',
    `cohort_type` STRING COMMENT 'Classification of the cohort definition by its primary purpose, determining how the cohort is used across population health workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was first created in the data platform.',
    `current_member_count` STRING COMMENT 'Most recent count of patients currently meeting the cohort criteria as of the last evaluation run.',
    `data_source_type` STRING COMMENT 'Primary data source category from which patient attributes are evaluated for cohort membership determination.',
    `population_health_dynamic_cohort_definition_description` STRING COMMENT 'Detailed narrative describing the clinical or operational purpose of this cohort, including target patient population and intended use cases.',
    `diagnosis_code_set` STRING COMMENT 'Comma-separated list or value set identifier of ICD-10 diagnosis codes used as primary clinical criteria for cohort inclusion.',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition version is no longer active. Null indicates an open-ended definition.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition version becomes effective and begins evaluating patient membership.',
    `evaluation_frequency` STRING COMMENT 'How often the dynamic cohort membership is re-evaluated against the underlying patient data to refresh the population.',
    `exclusion_criteria_expression` STRING COMMENT 'Structured logical expression defining the exclusion rules that remove patients from cohort membership even if inclusion criteria are met.',
    `fhir_measure_resource_url` STRING COMMENT 'URL reference to the HL7 FHIR Measure or Library resource that formally represents this cohort definition for interoperability.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for the cohort. Value of all indicates no gender restriction; specific indicates complex gender logic in the inclusion criteria expression.',
    `geographic_scope` STRING COMMENT 'Geographic boundary within which the cohort definition applies, determining which facilities or service areas contribute patients.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether the cohort definition has been reviewed to ensure it adheres to HIPAA minimum necessary standard for data access.',
    `inclusion_criteria_expression` STRING COMMENT 'Structured logical expression defining the inclusion rules for patient membership, expressed in a query-compatible format (e.g., SQL predicate, CQL, or FHIR ClinicalReasoning expression).',
    `is_current_version` BOOLEAN COMMENT 'Flag indicating whether this record represents the currently active version of the cohort definition.',
    `is_irb_approved` BOOLEAN COMMENT 'Indicates whether this cohort definition has received IRB approval for use in research contexts.',
    `lab_result_criteria` STRING COMMENT 'LOINC-based laboratory result criteria expression defining lab value thresholds or patterns required for cohort membership.',
    `last_evaluation_duration_seconds` STRING COMMENT 'Execution time in seconds for the most recent cohort evaluation run, used for performance monitoring and optimization.',
    `last_evaluation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the cohort evaluation logic against the patient population.',
    `lookback_period_days` STRING COMMENT 'Number of days into the past that the evaluation engine examines patient data when determining cohort membership.',
    `medication_code_set` STRING COMMENT 'Comma-separated list or value set identifier of NDC or RxNorm codes defining medication-based criteria for cohort membership.',
    `minimum_encounter_count` STRING COMMENT 'Minimum number of qualifying encounters a patient must have within the lookback period to be included in the cohort.',
    `population_health_dynamic_cohort_definition_name` STRING COMMENT 'Human-readable display name for the dynamic cohort definition, used in clinical dashboards and population health reports.',
    `notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated notifications are triggered when patients enter or exit this cohort, supporting care gap closure workflows.',
    `payer_type_filter` STRING COMMENT 'Optional filter restricting cohort membership to patients with specific insurance/payer types (e.g., Medicare, Medicaid, Commercial).',
    `priority_level` STRING COMMENT 'Clinical priority assigned to this cohort for resource allocation and intervention scheduling in care management workflows.',
    `procedure_code_set` STRING COMMENT 'Comma-separated list or value set identifier of CPT/HCPCS procedure codes used as criteria for cohort inclusion.',
    `retention_period_days` STRING COMMENT 'Number of days that historical cohort membership snapshots are retained before purging, per HIPAA retention policy.',
    `review_due_date` DATE COMMENT 'Date by which this cohort definition must be reviewed for continued clinical relevance and accuracy per governance policy.',
    `risk_model_name` STRING COMMENT 'Name of the risk stratification model used for score-based cohort criteria (e.g., HCC, LACE, Charlson Comorbidity Index).',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk stratification score (e.g., HCC risk score) a patient must meet to qualify for this cohort.',
    `sdoh_criteria_flag` BOOLEAN COMMENT 'Indicates whether this cohort definition incorporates Social Determinants of Health factors in its membership logic.',
    `source_system_identifier` STRING COMMENT 'Native identifier of this cohort definition in the originating source system, enabling traceability and reconciliation.',
    `source_system_name` STRING COMMENT 'Name of the operational system where this cohort definition was originally authored (e.g., Epic Healthy Planet, Cerner HealtheIntent).',
    `population_health_dynamic_cohort_definition_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively generating patient membership or is inactive.',
    `target_population_size` STRING COMMENT 'Expected or target number of patients this cohort definition is designed to capture, used for capacity planning and resource allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cohort definition record.',
    `version_number` STRING COMMENT 'Sequential version number supporting SCD Type 2 versioning of cohort logic changes over time for audit and reproducibility.',
    CONSTRAINT pk_population_health_dynamic_cohort_definition PRIMARY KEY(`population_health_dynamic_cohort_definition_id`)
) COMMENT 'Dynamic cohort definition';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` (
    `population_health_cohort_membership_id` BIGINT COMMENT 'Primary key for population_health_cohort_membership',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Cohort membership qualification often depends on a specific risk score evaluation. Linking to the exact patient_risk_score record enables audit of cohort inclusion decisions and supports CMS risk stra',
    `mpi_record_id` BIGINT COMMENT 'description',
    `cohort_refresh_log_id` BIGINT COMMENT 'Foreign key linking to population_health.cohort_refresh_log. Business justification: Each cohort membership record is created or confirmed during a specific refresh cycle. Linking membership to the refresh log that originated/last confirmed it provides critical data lineage and audit ',
    `population_health_dynamic_cohort_definition_id` BIGINT COMMENT 'description',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: Precision medicine cohort programs enroll patients based on qualifying genomic test results (e.g., BRCA+, Lynch syndrome). Tracking the specific result that qualified cohort entry is required for clin',
    CONSTRAINT pk_population_health_cohort_membership PRIMARY KEY(`population_health_cohort_membership_id`)
) COMMENT 'Cohort membership tracking';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` (
    `population_health_cohort_management_id` BIGINT COMMENT 'Primary key for population_health_cohort_management',
    `care_program_enrollment_id` BIGINT COMMENT 'description',
    `cohort_outcome_tracking_id` BIGINT COMMENT 'description',
    `cohort_refresh_log_id` BIGINT COMMENT 'description',
    `mpi_record_id` BIGINT COMMENT 'description',
    `population_health_cohort_definition_id` BIGINT COMMENT 'description',
    `population_health_cohort_membership_id` BIGINT COMMENT 'description',
    `population_health_dynamic_cohort_definition_id` BIGINT COMMENT 'description',
    `cohort_outcome_tracking_benchmark_rate` DECIMAL(18,2) COMMENT 'description',
    `cohort_outcome_tracking_denominator_count` BIGINT COMMENT 'description',
    `cohort_outcome_tracking_numerator_count` BIGINT COMMENT 'description',
    `cohort_outcome_tracking_performance_rate` DECIMAL(18,2) COMMENT 'description',
    `dynamic_cohort_definition_refresh_frequency` STRING COMMENT 'description',
    `dynamic_cohort_definition_target_population_size` BIGINT COMMENT 'description',
    CONSTRAINT pk_population_health_population_health_cohort_management PRIMARY KEY(`population_health_cohort_management_id`)
) COMMENT 'Table defining dynamic cohorts.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` (
    `population_health_cohort_definition_id` BIGINT COMMENT 'Primary key for population_health_cohort_definition',
    `employee_id` BIGINT COMMENT 'Identifier of the data steward accountable for the accuracy and governance of this cohort definition.',
    `measure_id` BIGINT COMMENT 'CMS electronic clinical quality measure (eCQM) identifier when this cohort supports Medicare/Medicaid quality reporting.',
    `population_quality_measure_id` BIGINT COMMENT 'Identifier linking this cohort to a specific quality measure (e.g., HEDIS measure ID, CMS eCQM identifier) when the cohort supports quality reporting.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical leader or medical director responsible for the clinical validity of this cohort definition.',
    `age_max_years` STRING COMMENT 'Maximum patient age in years for cohort eligibility, used as a demographic filter criterion.',
    `age_min_years` STRING COMMENT 'Minimum patient age in years for cohort eligibility, used as a demographic filter criterion.',
    `approved_date` DATE COMMENT 'Date on which the cohort definition was formally approved for production use by the clinical governance committee.',
    `care_gap_identification_flag` BOOLEAN COMMENT 'Indicates whether this cohort definition is used to identify patients with care gaps requiring outreach or intervention.',
    `clinical_domain` STRING COMMENT 'Primary clinical domain or disease area the cohort targets (e.g., cardiology, endocrinology, oncology, behavioral health). [ENUM-REF-CANDIDATE: cardiology|endocrinology|oncology|behavioral_health|pulmonology|nephrology|neurology|orthopedics — promote to reference product]',
    `cohort_type` STRING COMMENT 'Classification of the cohort definition by its primary purpose within population health management.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether patient consent is required before including them in this cohort for outreach or research purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cohort definition record was first created in the system.',
    `criteria_language` STRING COMMENT 'The formal language or notation system used to express the inclusion and exclusion criteria logic.',
    `data_source_systems` STRING COMMENT 'Comma-separated list of source systems whose data feeds the cohort evaluation (e.g., Epic EHR, Claims Warehouse, HIE, Lab System).',
    `diagnosis_code_set` STRING COMMENT 'Comma-separated list or value set identifier containing all ICD-10 codes that qualify a patient for cohort inclusion.',
    `effective_end_date` DATE COMMENT 'Date after which this cohort definition version is no longer active. Null indicates an open-ended definition.',
    `effective_start_date` DATE COMMENT 'Date from which this cohort definition version becomes active and can be used for patient stratification.',
    `evidence_basis` STRING COMMENT 'Clinical evidence or guideline reference supporting the cohort criteria (e.g., AHA guidelines, USPSTF recommendations, peer-reviewed literature citations).',
    `exclusion_criteria_logic` STRING COMMENT 'Structured logical expression defining the exclusion criteria that disqualify patients from cohort membership despite meeting inclusion criteria.',
    `gender_criteria` STRING COMMENT 'Gender-based eligibility filter for the cohort definition. Value of all indicates no gender restriction.',
    `hedis_measure_code` STRING COMMENT 'Specific HEDIS measure code this cohort definition supports, enabling alignment with NCQA quality reporting requirements.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether the cohort criteria and resulting patient list comply with HIPAA minimum necessary standard for data access.',
    `inclusion_criteria_logic` STRING COMMENT 'Structured logical expression defining the inclusion criteria for patient membership in the cohort, expressed as a combination of diagnosis codes, lab values, demographics, and utilization patterns.',
    `intervention_type` STRING COMMENT 'Type of clinical or operational intervention associated with this cohort (e.g., care coordination, medication management, preventive screening, chronic disease management). [ENUM-REF-CANDIDATE: care_coordination|medication_management|preventive_screening|chronic_disease_management|behavioral_health|transitional_care|remote_monitoring — promote to reference product]',
    `irb_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this cohort definition requires IRB approval, typically for research-oriented cohorts.',
    `is_dynamic` BOOLEAN COMMENT 'Indicates whether the cohort membership is dynamically recalculated on each refresh (true) or is a fixed/static patient list (false).',
    `lab_value_criteria` STRING COMMENT 'Laboratory result-based criteria for cohort membership, including LOINC codes, value thresholds, and observation windows.',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the cohort criteria logic to refresh patient membership.',
    `last_reviewed_date` DATE COMMENT 'Date of the most recent clinical review of the cohort definition to ensure criteria remain clinically appropriate and evidence-based.',
    `lookback_period_days` STRING COMMENT 'Number of days to look back in patient history when evaluating cohort criteria (e.g., 365 days for annual diagnosis history).',
    `medication_criteria` STRING COMMENT 'Medication-based criteria for cohort membership, expressed as NDC codes, therapeutic classes, or medication name patterns.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the cohort definition criteria and clinical relevance.',
    `owning_program_name` STRING COMMENT 'Name of the population health program, quality initiative, or care management program that owns and maintains this cohort definition.',
    `payer_type_filter` STRING COMMENT 'Optional payer type restriction for the cohort (e.g., Medicare, Medicaid, Commercial) to support payer-specific population health programs.',
    `population_health_cohort_definition_description` STRING COMMENT 'Detailed narrative describing the clinical or operational purpose of the cohort, target population characteristics, and intended use cases.',
    `population_health_cohort_definition_status` STRING COMMENT 'Current lifecycle state of the cohort definition indicating whether it is actively used for patient stratification.',
    `primary_icd10_code` STRING COMMENT 'Primary ICD-10 diagnosis code that anchors the cohort definition for disease-based registries.',
    `refresh_frequency` STRING COMMENT 'How frequently the cohort membership is recalculated based on updated clinical and claims data.',
    `retirement_reason` STRING COMMENT 'Explanation for why the cohort definition was retired, such as superseded by newer version, program discontinued, or criteria no longer clinically valid.',
    `risk_model_name` STRING COMMENT 'Name of the risk stratification model used to calculate the risk score threshold (e.g., HCC, LACE, HOSPITAL score).',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk score value (e.g., HCC risk score, readmission risk) required for cohort inclusion in risk-stratified populations.',
    `sdoh_criteria_flag` BOOLEAN COMMENT 'Indicates whether this cohort definition incorporates Social Determinants of Health factors in its inclusion or exclusion criteria.',
    `sdoh_factors` STRING COMMENT 'Specific SDOH factors considered in cohort criteria such as food insecurity, housing instability, transportation barriers, or health literacy.',
    `target_population_size` STRING COMMENT 'Estimated or last-calculated number of patients meeting the cohort criteria, used for resource planning and program capacity management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cohort definition record.',
    `utilization_criteria` STRING COMMENT 'Healthcare utilization-based criteria such as ED visit frequency, hospitalization count, or readmission history used for cohort stratification.',
    `version` STRING COMMENT 'Semantic version number of the cohort definition, supporting iterative refinement of inclusion/exclusion criteria.',
    CONSTRAINT pk_population_health_population_health_cohort_definition PRIMARY KEY(`population_health_cohort_definition_id`)
) COMMENT 'Table defining dynamic cohort criteria';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` (
    `cohort_refresh_log_id` BIGINT COMMENT 'Primary key for cohort_refresh_log',
    `care_program_id` BIGINT COMMENT 'Identifier of the population health program (e.g., chronic disease management, preventive care, wellness) that this cohort supports.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or care site whose patient population was included in this cohort refresh scope, if facility-scoped.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or service account that initiated the cohort refresh process. Null for fully automated scheduled refreshes.',
    `parent_refresh_log_cohort_refresh_log_id` BIGINT COMMENT 'Self-referencing identifier linking this log entry to a parent refresh execution, used when a refresh is split into sub-tasks or retried.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer whose covered population was targeted in this cohort refresh, if payer-scoped.',
    `population_health_dynamic_cohort_definition_id` BIGINT COMMENT 'Identifier of the population health cohort that was refreshed during this execution cycle.',
    `care_gap_refresh_flag` BOOLEAN COMMENT 'Indicates whether this cohort refresh also triggered a recalculation of care gaps for the affected patient population.',
    `cohort_definition_version` STRING COMMENT 'Version identifier of the cohort inclusion/exclusion criteria definition that was applied during this refresh cycle, enabling traceability of criteria changes over time.',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time when the cohort refresh process completed, whether successfully or with errors.',
    `data_extraction_end` TIMESTAMP COMMENT 'The end of the data extraction time window used for this refresh, defining the latest clinical data considered for cohort membership evaluation.',
    `data_extraction_start` TIMESTAMP COMMENT 'The beginning of the data extraction time window used for this refresh, defining the earliest clinical data considered for cohort membership evaluation.',
    `data_source_system` STRING COMMENT 'The primary source system from which patient data was extracted for cohort evaluation, such as Epic Healthy Planet, Cerner HealtheIntent, or other population health platforms.',
    `de_identification_method` STRING COMMENT 'The HIPAA de-identification method applied to cohort data during this refresh, if applicable. Safe Harbor follows the 18-identifier removal standard; Expert Determination uses statistical methods.',
    `effective_date` DATE COMMENT 'The date from which the refreshed cohort membership becomes effective for clinical and operational use.',
    `error_code` STRING COMMENT 'Standardized error code associated with a failed or partially completed refresh, enabling categorization and automated alerting of failure types.',
    `error_message` STRING COMMENT 'Descriptive error message captured when the refresh process fails or completes with warnings, providing diagnostic information for troubleshooting.',
    `exclusion_criteria_hash` STRING COMMENT 'A hash value representing the specific exclusion criteria logic applied during this refresh, enabling detection of criteria changes between refresh cycles.',
    `execution_duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time in seconds for the cohort refresh process from initiation to completion, used for performance monitoring and SLA tracking.',
    `expiration_date` DATE COMMENT 'The date after which the refreshed cohort membership is considered stale and requires a new refresh cycle.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether this cohort refresh execution was performed in compliance with HIPAA minimum necessary standards for data access.',
    `inclusion_criteria_hash` STRING COMMENT 'A hash value representing the specific inclusion criteria logic applied during this refresh, enabling detection of criteria changes between refresh cycles.',
    `measure_period_end` DATE COMMENT 'The end date of the quality measurement period for which this cohort refresh is relevant, aligning with HEDIS or CMS reporting periods.',
    `measure_period_start` DATE COMMENT 'The start date of the quality measurement period for which this cohort refresh is relevant, aligning with HEDIS or CMS reporting periods.',
    `members_added_count` BIGINT COMMENT 'Number of new patients or members added to the cohort during this refresh cycle based on meeting inclusion criteria.',
    `members_removed_count` BIGINT COMMENT 'Number of patients or members removed from the cohort during this refresh cycle due to no longer meeting inclusion criteria or meeting exclusion criteria.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether stakeholder notifications (email, alert, dashboard update) were sent upon completion of this cohort refresh.',
    `post_member_count` BIGINT COMMENT 'Total number of patients or members in the cohort after the refresh completed, representing the current cohort size.',
    `prior_member_count` BIGINT COMMENT 'Total number of patients or members in the cohort immediately before this refresh was executed, used to calculate net membership changes.',
    `quality_score` DECIMAL(18,2) COMMENT 'A computed data quality score (0-100) reflecting the completeness and validity of the source data used during this cohort refresh, supporting data governance monitoring.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cohort refresh log record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this cohort refresh log record was last modified, such as when status transitions from in_progress to completed.',
    `records_evaluated_count` BIGINT COMMENT 'Total number of patient records evaluated against the cohort inclusion and exclusion criteria during this refresh execution.',
    `refresh_status` STRING COMMENT 'Current lifecycle status of the cohort refresh execution indicating whether the process completed successfully, failed, is still running, was cancelled, or partially completed.',
    `refresh_timestamp` TIMESTAMP COMMENT 'The date and time when the cohort refresh process was initiated. This is the principal business event timestamp for the log entry.',
    `refresh_type` STRING COMMENT 'Classification of the refresh operation indicating whether it was a full rebuild of the cohort membership, an incremental update, a delta-only change, a manual ad-hoc execution, or a scheduled automated run.',
    `retry_count` STRING COMMENT 'Number of retry attempts made for this cohort refresh execution before reaching the final status, used for operational monitoring.',
    `risk_stratification_applied_flag` BOOLEAN COMMENT 'Indicates whether risk stratification scoring was applied to cohort members during this refresh cycle for care prioritization purposes.',
    `sdoh_criteria_included_flag` BOOLEAN COMMENT 'Indicates whether Social Determinants of Health criteria (housing, food security, transportation, etc.) were included in the cohort identification logic for this refresh.',
    `trigger_source` STRING COMMENT 'The mechanism or source that initiated the cohort refresh, such as an automated scheduler, manual user action, event-driven trigger, API call, or system-initiated process.',
    `validation_notes` STRING COMMENT 'Free-text notes from the post-refresh validation process documenting any anomalies, warnings, or observations about the refresh results.',
    `validation_passed_flag` BOOLEAN COMMENT 'Indicates whether the post-refresh validation checks (membership count thresholds, data completeness, criteria consistency) all passed successfully.',
    CONSTRAINT pk_cohort_refresh_log PRIMARY KEY(`cohort_refresh_log_id`)
) COMMENT 'Master reference table for cohort_refresh_log. Referenced by cohort_refresh_log_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` (
    `cohort_outcome_tracking_id` BIGINT COMMENT 'Primary key for cohort_outcome_tracking',
    `care_program_id` BIGINT COMMENT 'Reference to the care management or disease management program under which this outcome is tracked.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the patient receives care related to this outcome.',
    `employee_id` BIGINT COMMENT 'Reference to the provider primarily responsible for managing the patients outcome within the cohort.',
    `health_plan_id` BIGINT COMMENT 'Reference to the payer quality program (e.g., Medicare Advantage Stars, Medicaid managed care, commercial VBP contract) driving this outcome tracking.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose outcome is being tracked within the cohort.',
    `population_health_cohort_membership_id` BIGINT COMMENT 'Foreign key linking to population_health.population_health_cohort_membership. Business justification: Cohort outcome tracking records measure outcomes for a specific patient within a specific cohort. While the table already has mpi_record_id and population_health_dynamic_cohort_definition_id separatel',
    `population_health_dynamic_cohort_definition_id` BIGINT COMMENT 'Reference to the population health cohort to which this outcome tracking record belongs.',
    `attribution_method` STRING COMMENT 'Method used to attribute the patient to the responsible provider for this outcome measure: prospective (pre-assigned), retrospective (claims-based), or hybrid.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The patients baseline measurement value at the time of cohort enrollment, used to calculate improvement over time.',
    `cohort_outcome_tracking_status` STRING COMMENT 'Current lifecycle status of the outcome tracking record indicating whether the patient has met, not met, or is still being evaluated against the outcome measure.',
    `comparison_operator` STRING COMMENT 'Operator defining how the outcome value is compared to the target value to determine achievement (e.g., HbA1c less_than 8.0).',
    `confidence_level` STRING COMMENT 'Confidence level of the outcome measurement based on data completeness and source reliability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outcome tracking record was first created in the system.',
    `data_source` STRING COMMENT 'Source system from which the outcome measurement was obtained: EHR clinical data, claims administrative data, disease registry, patient-reported outcome, direct lab feed, or health information exchange.',
    `effective_end_date` DATE COMMENT 'End date of the validity period for this version of the record; null indicates the current active version.',
    `effective_start_date` DATE COMMENT 'Start date of the validity period for this version of the record, supporting SCD Type 2 historization in the lakehouse.',
    `enrollment_date` DATE COMMENT 'Date the patient was enrolled into the cohort for outcome tracking purposes.',
    `exclusion_reason` STRING COMMENT 'Reason the patient is excluded from the outcome measure denominator (e.g., hospice enrollment, advanced illness, patient refusal, contraindication).',
    `gap_closure_date` DATE COMMENT 'Date when the identified gap in care was closed through appropriate clinical action or documentation.',
    `gap_in_care_flag` BOOLEAN COMMENT 'Indicates whether a gap in care exists for this patient-measure combination, meaning the patient has not yet received recommended services or achieved the target.',
    `improvement_percentage` DECIMAL(18,2) COMMENT 'Percentage improvement from baseline to current outcome value, calculated as ((baseline - current) / baseline) * 100 for measures where lower is better, or inverse for higher-is-better measures.',
    `intervention_type` STRING COMMENT 'Type of intervention applied to help the patient achieve the outcome (e.g., care coordination, medication therapy management, remote monitoring, health coaching, transitional care).',
    `is_current_record` BOOLEAN COMMENT 'Flag indicating whether this is the most current version of the outcome tracking record in the SCD Type 2 history.',
    `is_denominator_eligible` BOOLEAN COMMENT 'Indicates whether the patient is eligible for inclusion in the measure denominator based on age, diagnosis, and enrollment criteria.',
    `is_numerator_compliant` BOOLEAN COMMENT 'Indicates whether the patient meets the numerator criteria for the quality measure, meaning the desired outcome or service has been achieved.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent outreach attempt to the patient regarding this outcome measure.',
    `measure_code` STRING COMMENT 'Standardized code identifying the quality measure (e.g., NQF number, HEDIS measure ID, CMS eCQM identifier) being tracked.',
    `measure_domain` STRING COMMENT 'Clinical domain of the quality measure (e.g., diabetes management, cardiovascular health, behavioral health, preventive care, medication management).',
    `measurement_date` DATE COMMENT 'The date on which the outcome was most recently measured or assessed for this patient within the cohort.',
    `measurement_period_end` DATE COMMENT 'End date of the measurement period during which the outcome is evaluated.',
    `measurement_period_start` DATE COMMENT 'Start date of the measurement period during which the outcome is evaluated, aligned with HEDIS or CMS reporting periods.',
    `notes` STRING COMMENT 'Free-text clinical or administrative notes regarding the patients progress toward the outcome, barriers encountered, or care plan adjustments.',
    `outcome_achieved_date` DATE COMMENT 'Actual date when the patient first achieved the target outcome, null if not yet achieved.',
    `outcome_score` DECIMAL(18,2) COMMENT 'Normalized score (0-100) representing the degree of outcome achievement relative to the target, used for comparative analytics across different measure types.',
    `outcome_type` STRING COMMENT 'Classification of the outcome being tracked: clinical (lab values, vitals), utilization (ED visits, readmissions), cost (total cost of care), experience (patient satisfaction), or functional (ADL improvement).',
    `outcome_value` DECIMAL(18,2) COMMENT 'The actual numeric value of the outcome measurement (e.g., HbA1c level of 7.2, systolic BP of 130, number of ED visits).',
    `outcome_value_unit` STRING COMMENT 'Unit of measure for the outcome value (e.g., %, mg/dL, mmHg, count, days).',
    `outreach_attempt_count` STRING COMMENT 'Number of outreach attempts made to the patient for this outcome measure (phone calls, letters, portal messages) to close gaps in care.',
    `patient_engagement_level` STRING COMMENT 'Level of patient engagement with the care program and outcome improvement activities, based on appointment adherence, communication responsiveness, and self-management behaviors.',
    `reporting_year` STRING COMMENT 'Calendar or performance year for which this outcome tracking record applies, aligned with CMS or HEDIS reporting cycles.',
    `risk_stratification_level` STRING COMMENT 'Patients risk level at the time of outcome assessment, used to contextualize outcome achievement relative to clinical complexity.',
    `sdoh_impact_flag` BOOLEAN COMMENT 'Indicates whether social determinants of health factors (food insecurity, housing instability, transportation barriers) have been identified as impacting this patients outcome achievement.',
    `target_achievement_date` DATE COMMENT 'Date by which the outcome target should be achieved per the care plan or quality measure specification.',
    `target_value` DECIMAL(18,2) COMMENT 'The target threshold value that defines successful outcome achievement (e.g., HbA1c < 8.0, BP < 140/90).',
    `tracking_number` STRING COMMENT 'Business-facing unique identifier for the outcome tracking record, used in reports and correspondence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this outcome tracking record was last modified.',
    `value_based_contract_flag` BOOLEAN COMMENT 'Indicates whether this outcome is tied to a value-based payment arrangement where financial incentives or penalties depend on achievement.',
    CONSTRAINT pk_cohort_outcome_tracking PRIMARY KEY(`cohort_outcome_tracking_id`)
) COMMENT 'Master reference table for cohort_outcome_tracking. Referenced by cohort_outcome_tracking_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ADD CONSTRAINT `fk_population_health_population_health_cohort_membership_cohort_refresh_log_id` FOREIGN KEY (`cohort_refresh_log_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log`(`cohort_refresh_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ADD CONSTRAINT `fk_population_health_population_health_cohort_membership_population_health_dynamic_cohort_definition_id` FOREIGN KEY (`population_health_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition`(`population_health_dynamic_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_cohort_outcome_tracking_id` FOREIGN KEY (`cohort_outcome_tracking_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking`(`cohort_outcome_tracking_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_cohort_refresh_log_id` FOREIGN KEY (`cohort_refresh_log_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log`(`cohort_refresh_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_population_health_cohort_definition_id` FOREIGN KEY (`population_health_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition`(`population_health_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_population_health_cohort_membership_id` FOREIGN KEY (`population_health_cohort_membership_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership`(`population_health_cohort_membership_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_population_health_dynamic_cohort_definition_id` FOREIGN KEY (`population_health_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition`(`population_health_dynamic_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ADD CONSTRAINT `fk_population_health_cohort_refresh_log_parent_refresh_log_cohort_refresh_log_id` FOREIGN KEY (`parent_refresh_log_cohort_refresh_log_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log`(`cohort_refresh_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ADD CONSTRAINT `fk_population_health_cohort_refresh_log_population_health_dynamic_cohort_definition_id` FOREIGN KEY (`population_health_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition`(`population_health_dynamic_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_population_health_cohort_membership_id` FOREIGN KEY (`population_health_cohort_membership_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership`(`population_health_cohort_membership_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_population_health_dynamic_cohort_definition_id` FOREIGN KEY (`population_health_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition`(`population_health_dynamic_cohort_definition_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`population_health` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`population_health` SET TAGS ('dbx_domain' = 'population_health');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_dynamic_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` SET TAGS ('dbx_subdomain' = 'membership_tracking');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `population_health_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `population_health_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `population_health_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `cohort_refresh_log_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Cohort Refresh Log Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` SET TAGS ('dbx_subdomain' = 'cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_management_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_management Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_management_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_management_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` SET TAGS ('dbx_subdomain' = 'cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'population_health_cohort_definition Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `diagnosis_code_set` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `diagnosis_code_set` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `gender_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ALTER COLUMN `population_health_cohort_definition_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` SET TAGS ('dbx_subdomain' = 'membership_tracking');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ALTER COLUMN `cohort_refresh_log_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Refresh Log Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` SET TAGS ('dbx_subdomain' = 'membership_tracking');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `cohort_outcome_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Outcome Tracking Identifier');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `population_health_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Population Health Cohort Membership Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ALTER COLUMN `population_health_dynamic_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
