-- Schema for Domain: clinical_trial_matching | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching` COMMENT 'Clinical Trial Matching domain with eligibility criteria evaluation tables';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria` (
    `eligibility_criteria_id` BIGINT COMMENT 'Primary key for eligibility_criteria',
    `trial_id` BIGINT COMMENT 'description',
    `criteria_code` BIGINT COMMENT 'description',
    CONSTRAINT pk_eligibility_criteria PRIMARY KEY(`eligibility_criteria_id`)
) COMMENT 'Table storing trial eligibility criteria';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` (
    `patient_eligibility_id` BIGINT COMMENT 'Primary key for patient_eligibility',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Trial coordinators use AI risk scores to prioritize patients for trial recruitment. High-risk patients with unmet needs are matched to experimental therapies. Standard clinical trial operations workfl',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to genomics.patient_genomic_profile. Business justification: Patient eligibility evaluation in precision oncology requires checking genomic profile for biomarker-driven criteria (e.g., HER2+, BRCA mutation). Eligibility records must reference the genomic profil',
    `mpi_record_id` BIGINT COMMENT 'description',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.trial. Business justification: Patient eligibility must reference which trial the patient is being evaluated for. Adding trial_id FK.',
    CONSTRAINT pk_patient_eligibility PRIMARY KEY(`patient_eligibility_id`)
) COMMENT 'Table linking patients to trial eligibility results';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` (
    `eligibility_criteria_evaluation_id` BIGINT COMMENT 'Primary key for eligibility_criteria_evaluation',
    `clinical_ai_clinical_nlp_result_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_nlp_result. Business justification: NLP-extracted clinical concepts (diagnoses, labs, medications) from patient notes are evaluated against trial inclusion/exclusion criteria. Core AI-driven trial matching pipeline requires this linkage',
    `eligibility_criteria_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.eligibility_criteria. Business justification: An eligibility criteria evaluation evaluates a specific criterion. This links the evaluation to the criterion being evaluated. Natural parent-child relationship.',
    `eligibility_evaluation_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.eligibility_evaluation. Business justification: Individual criteria evaluations belong to an overall eligibility evaluation session. This links the detail to the header.',
    CONSTRAINT pk_eligibility_criteria_evaluation PRIMARY KEY(`eligibility_criteria_evaluation_id`)
) COMMENT 'Eligibility criteria evaluation';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` (
    `eligibility_evaluation_id` BIGINT COMMENT 'Primary key for eligibility_evaluation',
    `care_site_id` BIGINT COMMENT 'Reference to the clinical research site or facility where the eligibility evaluation is being conducted.',
    `trial_id` BIGINT COMMENT 'Reference to the clinical trial protocol against which the patients eligibility is being evaluated.',
    `employee_id` BIGINT COMMENT 'Reference to the provider (research coordinator or principal investigator) who performed or reviewed the eligibility evaluation.',
    `eligibility_override_provider_employee_id` BIGINT COMMENT 'Reference to the principal investigator or authorized provider who approved the eligibility override.',
    `eligibility_referring_provider_employee_id` BIGINT COMMENT 'Reference to the provider who referred the patient for clinical trial screening, enabling referral pathway analytics.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient being evaluated for clinical trial eligibility. Links to the master patient index for identity resolution.',
    `prior_evaluation_eligibility_evaluation_id` BIGINT COMMENT 'Reference to the previous eligibility evaluation for the same patient-trial combination, enabling longitudinal tracking of re-screening attempts.',
    `protocol_version_id` BIGINT COMMENT 'Reference to the specific version of the trial protocol used for this eligibility evaluation, ensuring criteria alignment with the active protocol amendment.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the eligibility evaluation was initiated or completed, if applicable.',
    `clinical_data_cutoff_date` DATE COMMENT 'The date through which clinical data (labs, vitals, imaging) was considered for this eligibility evaluation, establishing the temporal boundary of evidence.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility evaluation was finalized and the overall result was determined, marking the end of the evaluation workflow.',
    `confidence_level` STRING COMMENT 'Degree of confidence in the eligibility determination based on data completeness, recency of clinical information, and criteria clarity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility evaluation record was first created in the system, supporting audit trail requirements under FDA 21 CFR Part 11.',
    `criteria_not_assessable_count` STRING COMMENT 'Number of eligibility criteria that could not be evaluated due to missing clinical data, pending lab results, or insufficient documentation.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of required clinical data elements available at the time of evaluation (0-100), indicating the reliability of the eligibility determination.',
    `disease_stage` STRING COMMENT 'The patients disease stage or severity classification relevant to trial eligibility (e.g., cancer staging, NYHA class, GOLD stage), as documented in the clinical record.',
    `eligibility_evaluation_status` STRING COMMENT 'Current lifecycle status of the eligibility evaluation workflow, tracking progression from initiation through final determination.',
    `evaluation_date` DATE COMMENT 'The business date on which the eligibility evaluation was formally conducted. Represents the clinical decision point for trial matching.',
    `evaluation_method` STRING COMMENT 'The primary data collection method used to assess eligibility criteria, indicating the source of clinical evidence for the determination.',
    `evaluation_number` STRING COMMENT 'Human-readable business identifier for the eligibility evaluation, used for tracking and communication across research coordinators and principal investigators.',
    `evaluation_type` STRING COMMENT 'Classification of how the eligibility evaluation was performed: automated (algorithm-driven), manual (clinician review), hybrid (algorithm with clinician override), or re-evaluation (repeat assessment).',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined in the trial protocol that were evaluated for this patient.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of exclusion criteria that the patient triggers, indicating disqualifying conditions identified during evaluation.',
    `expiration_date` DATE COMMENT 'Date after which this eligibility evaluation is no longer valid and must be repeated, typically driven by protocol-defined screening windows.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of inclusion criteria that the patient satisfies for the clinical trial, used to calculate match percentage.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined in the trial protocol that were evaluated for this patient.',
    `ineligibility_narrative` STRING COMMENT 'Detailed clinical narrative explaining why the patient does not meet eligibility criteria, supporting screen failure documentation and protocol deviation tracking.',
    `ineligibility_reason_code` STRING COMMENT 'Coded reason for patient ineligibility when the overall result is ineligible, enabling structured reporting on screen failure reasons. [ENUM-REF-CANDIDATE: age_out_of_range|comorbidity|prior_therapy|lab_abnormal|consent_declined|geographic|capacity_full|other — promote to reference product]',
    `informed_consent_status` STRING COMMENT 'Status of the patients informed consent for trial participation at the time of eligibility evaluation. Consent is a prerequisite for enrollment.',
    `irb_approval_status` STRING COMMENT 'Status of IRB approval for the trial at the evaluating site, which must be active for patient enrollment to proceed.',
    `matching_algorithm_version` STRING COMMENT 'Semantic version of the eligibility matching algorithm or decision support tool used for automated evaluation, supporting reproducibility and audit.',
    `notes` STRING COMMENT 'Free-text clinical or administrative notes captured by the research team during the eligibility evaluation process.',
    `overall_result` STRING COMMENT 'The final determination of the patients eligibility for the clinical trial based on evaluation of all inclusion and exclusion criteria.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite numeric score (0-100) representing the degree of match between the patients clinical profile and the trials eligibility criteria. Used for ranking and prioritization.',
    `override_indicator` BOOLEAN COMMENT 'Indicates whether the principal investigator exercised clinical judgment to override an automated eligibility determination (e.g., waiving a borderline criterion).',
    `override_reason` STRING COMMENT 'Free-text justification provided by the principal investigator when overriding an automated eligibility determination, required for audit and regulatory compliance.',
    `patient_mrn` STRING COMMENT 'The patients medical record number at the time of evaluation, captured for audit trail and cross-system reconciliation with the EHR.',
    `primary_diagnosis_code` STRING COMMENT 'The patients primary diagnosis code (ICD-10) relevant to the clinical trials therapeutic area, captured at the time of eligibility evaluation.',
    `prior_treatment_status` STRING COMMENT 'Classification of the patients treatment history relative to the trials therapeutic area, a common eligibility criterion for oncology and specialty trials.',
    `randomization_eligible` BOOLEAN COMMENT 'Indicates whether the patient has cleared all eligibility gates and is ready for randomization into the trial, representing the final enrollment readiness state.',
    `re_evaluation_indicator` BOOLEAN COMMENT 'Indicates whether this evaluation is a repeat assessment following a prior evaluation that was indeterminate, expired, or resulted in a protocol amendment.',
    `screening_visit_date` DATE COMMENT 'Date of the formal screening visit associated with this eligibility evaluation, if a dedicated visit was scheduled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the eligibility evaluation record, supporting change tracking and audit compliance.',
    `washout_period_met` BOOLEAN COMMENT 'Indicates whether the patient has completed the required washout period from prior therapies as specified by the trial protocol.',
    CONSTRAINT pk_eligibility_evaluation PRIMARY KEY(`eligibility_evaluation_id`)
) COMMENT 'Table for evaluating patient eligibility.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` (
    `trial_match_result_id` BIGINT COMMENT 'Primary key for trial_match_result',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: FDA/regulatory governance requires traceability of AI models producing trial match recommendations. Model card linkage enables audit of which algorithm version generated each match per 21 CFR Part 11.',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Trial match results record the patients risk score at matching time for outcome analysis and recruitment prioritization. Enables post-hoc analysis of whether risk-stratified matching improves enrollm',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: Trial match results are driven by specific genomic test findings (e.g., actionable mutation detected). Linking to the qualifying test result supports FDA audit trails and clinical validation of match ',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to genomics.patient_genomic_profile. Business justification: Precision medicine trial matching evaluates patient genomic profiles to determine eligibility. Match results must trace to the specific genomic profile assessed for regulatory audit and clinical decis',
    `mpi_record_id` BIGINT COMMENT 'description',
    `trial_id` BIGINT COMMENT 'description',
    `trial_match_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.trial_match. Business justification: A trial match result is a detailed outcome record belonging to a trial match. Links result to its parent match record.',
    CONSTRAINT pk_trial_match_result PRIMARY KEY(`trial_match_result_id`)
) COMMENT 'Table for trial match results per patient.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` (
    `patient_eligibility_match_id` BIGINT COMMENT 'Primary key for patient_eligibility_match',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or care site where the eligibility evaluation was conducted.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial against which the patient is being matched.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider or research coordinator who performed or reviewed the eligibility evaluation.',
    `patient_referring_provider_clinician_id` BIGINT COMMENT 'Identifier of the provider who referred the patient for clinical trial screening.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which eligibility screening was initiated, if applicable.',
    `age_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients age at evaluation falls within the trials age range requirements.',
    `biomarker_match_flag` BOOLEAN COMMENT 'Indicates whether the patients biomarker profile matches the trials biomarker-based eligibility requirements.',
    `confidence_level` STRING COMMENT 'Qualitative confidence level of the eligibility match based on data completeness and algorithm certainty.',
    `consent_status` STRING COMMENT 'Status of informed consent for the patients participation in the matched clinical trial.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility match record was first created in the system.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of required patient data elements that were available for the eligibility evaluation (0.00 to 100.00).',
    `disease_stage` STRING COMMENT 'Clinical stage or severity classification of the patients condition relevant to trial eligibility (e.g., TNM staging for oncology trials).',
    `distance_to_site_km` DECIMAL(18,2) COMMENT 'Calculated distance in kilometers between the patients residence and the nearest trial site, used for feasibility assessment.',
    `eligibility_determination_date` DATE COMMENT 'Business date on which the final eligibility determination was made for the patient-trial combination.',
    `enrollment_outcome` STRING COMMENT 'Final outcome of the eligibility match in terms of actual trial enrollment.',
    `evaluation_method` STRING COMMENT 'Method used to perform the eligibility evaluation: automated algorithm, manual chart review, or hybrid combination.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation was performed or last recalculated.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined in the trial protocol against which the patient was evaluated.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of exclusion criteria that the patient triggers, potentially disqualifying them from the trial.',
    `expiration_date` DATE COMMENT 'Date after which the eligibility determination is no longer valid and must be re-evaluated due to changing patient conditions or protocol amendments.',
    `genomic_match_flag` BOOLEAN COMMENT 'Indicates whether the patients genomic or molecular profiling results satisfy the trials genetic eligibility criteria.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of inclusion criteria that the patient satisfies for the clinical trial.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined in the trial protocol against which the patient was evaluated.',
    `irb_approval_number` STRING COMMENT 'IRB approval number under which this eligibility evaluation is conducted, ensuring ethical oversight.',
    `lab_values_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients laboratory test results fall within the acceptable ranges defined by the trial protocol.',
    `match_status` STRING COMMENT 'Current status of the patient eligibility determination for the clinical trial.',
    `matching_algorithm_version` STRING COMMENT 'Version identifier of the clinical trial matching algorithm used for this evaluation, following semantic versioning.',
    `missing_data_elements` STRING COMMENT 'Comma-separated list of data element categories that were unavailable during evaluation and may affect match accuracy.',
    `notes` STRING COMMENT 'Free-text clinical notes documenting additional context, rationale, or observations related to the eligibility determination.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the treating physician or care team has been notified of the patients eligibility match.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility match notification was sent to the care team or patient.',
    `overall_eligibility_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the degree of patient match to trial eligibility criteria, expressed as a percentage (0.00 to 100.00).',
    `patient_contacted_flag` BOOLEAN COMMENT 'Indicates whether the patient has been contacted regarding their potential eligibility for the clinical trial.',
    `patient_preference_match_flag` BOOLEAN COMMENT 'Indicates whether the trial aligns with the patients stated preferences regarding treatment type, visit frequency, or travel requirements.',
    `patient_response` STRING COMMENT 'Patients response after being informed of their eligibility for the clinical trial.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code representing the primary condition for which the patient is being considered for the trial.',
    `prior_treatment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients prior treatment history (lines of therapy, washout periods) satisfies the trials treatment history requirements.',
    `randomization_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient has cleared all screening requirements and is eligible for randomization into the trial.',
    `re_evaluation_count` STRING COMMENT 'Number of times this patient-trial eligibility match has been re-evaluated due to protocol amendments or patient condition changes.',
    `review_completed_timestamp` TIMESTAMP COMMENT 'Date and time when a human reviewer completed their assessment of the eligibility match result.',
    `screening_failure_reason` STRING COMMENT 'Primary reason for screening failure or ineligibility determination, referencing the specific criterion not met.',
    `source_system` STRING COMMENT 'Name of the operational system from which the eligibility data was sourced (e.g., Epic Healthy Planet, CTMS, EHR clinical decision support).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility match record was last modified.',
    `waiver_approved_flag` BOOLEAN COMMENT 'Indicates whether the requested eligibility waiver was approved by the principal investigator or sponsor.',
    `waiver_requested_flag` BOOLEAN COMMENT 'Indicates whether a protocol deviation waiver was requested for a criterion the patient does not fully meet.',
    CONSTRAINT pk_patient_eligibility_match PRIMARY KEY(`patient_eligibility_match_id`)
) COMMENT 'Table linking patients to trial eligibility results';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` (
    `trial_match_id` BIGINT COMMENT 'Primary key for trial_match',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the trial enrollment would occur.',
    `trial_id` BIGINT COMMENT 'Reference to the clinical trial protocol against which the patient was evaluated.',
    `employee_id` BIGINT COMMENT 'Reference to the clinical research coordinator who performed or reviewed the eligibility screening.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient evaluated for clinical trial eligibility.',
    `previous_match_trial_match_id` BIGINT COMMENT 'Reference to a prior match record if this is a re-evaluation or re-screening of a previously assessed match.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who referred or identified the patient as a potential trial candidate.',
    `trial_principal_investigator_clinician_id` BIGINT COMMENT 'Reference to the principal investigator responsible for the clinical trial at the matching site.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the trial match was identified or initiated.',
    `confidence_level` STRING COMMENT 'Qualitative confidence assessment of the match accuracy based on data completeness and criteria evaluation certainty.',
    `consent_date` DATE COMMENT 'Date when the patient provided informed consent for trial participation, if applicable.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this trial match record was first created in the system.',
    `criteria_indeterminate_count` STRING COMMENT 'Number of eligibility criteria that could not be evaluated due to missing or incomplete patient data.',
    `criteria_met_count` STRING COMMENT 'Number of eligibility criteria that the patient successfully met during evaluation.',
    `criteria_not_met_count` STRING COMMENT 'Number of eligibility criteria that the patient did not meet, indicating potential exclusion factors.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of required patient data elements available at the time of eligibility evaluation (0-100).',
    `decline_reason` STRING COMMENT 'Reason provided by the patient for declining participation in the matched clinical trial.',
    `eligibility_determination_date` DATE COMMENT 'Date when the final eligibility determination was made by the research team.',
    `enrollment_date` DATE COMMENT 'Date when the patient was formally enrolled in the clinical trial following successful matching and consent.',
    `exclusion_reason` STRING COMMENT 'Primary reason for patient ineligibility when exclusion criteria are triggered, may contain clinical details.',
    `has_exclusion_criteria_triggered` BOOLEAN COMMENT 'Indicates whether any exclusion criteria were triggered that would disqualify the patient from enrollment.',
    `irb_protocol_number` STRING COMMENT 'IRB-assigned protocol number for the clinical trial under which this match is evaluated.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this match record is currently active and under consideration, supporting SCD Type 2 patterns.',
    `is_inclusion_criteria_met` BOOLEAN COMMENT 'Indicates whether all mandatory inclusion criteria were satisfied by the patient.',
    `is_re_screening_required` BOOLEAN COMMENT 'Indicates whether the patient requires re-screening due to elapsed time or changed clinical status since initial evaluation.',
    `match_algorithm_version` STRING COMMENT 'Version identifier of the matching algorithm or rule engine used to generate this match result.',
    `match_date` TIMESTAMP COMMENT 'Timestamp when the patient-trial match was first identified or generated by the matching system.',
    `match_expiration_date` DATE COMMENT 'Date after which this match result is no longer valid due to trial enrollment window closure or clinical status changes.',
    `match_number` STRING COMMENT 'Human-readable business identifier for the trial match result, used in clinical research communications and tracking.',
    `match_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the strength of the patient-trial match based on eligibility criteria alignment.',
    `match_status` STRING COMMENT 'Current lifecycle status of the patient-trial match evaluation workflow.',
    `match_type` STRING COMMENT 'Method by which the patient-trial match was identified: automated algorithm, manual screening, hybrid approach, or direct referral.',
    `notes` STRING COMMENT 'Free-text clinical notes from the research coordinator regarding the eligibility evaluation, may contain PHI.',
    `outreach_date` DATE COMMENT 'Date when the patient was first contacted about this trial match opportunity.',
    `outreach_status` STRING COMMENT 'Status of patient outreach and communication regarding the trial match opportunity.',
    `patient_consent_status` STRING COMMENT 'Status of patient informed consent for trial participation at the time of match evaluation.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 code for the primary diagnosis relevant to the clinical trial eligibility evaluation.',
    `priority_rank` STRING COMMENT 'Relative priority ranking of this match among multiple trial options for the same patient, with 1 being highest priority.',
    `randomization_arm` STRING COMMENT 'Treatment arm or cohort to which the patient was randomized upon enrollment, if applicable.',
    `screening_date` DATE COMMENT 'Date when formal eligibility screening was conducted against the trial inclusion and exclusion criteria.',
    `total_criteria_count` STRING COMMENT 'Total number of inclusion and exclusion criteria evaluated for this trial match.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this trial match record was last modified.',
    CONSTRAINT pk_trial_match PRIMARY KEY(`trial_match_id`)
) COMMENT 'Table storing patient‑trial match results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` (
    `trial_eligibility_id` BIGINT COMMENT 'Primary key for trial_eligibility',
    `care_site_id` BIGINT COMMENT 'Identifier of the clinical trial site where the eligibility evaluation was performed.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial against which eligibility is being assessed.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider (principal investigator or research coordinator) who performed the eligibility evaluation.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `prior_evaluation_trial_eligibility_id` BIGINT COMMENT 'Reference to a previous eligibility evaluation for the same patient-trial combination, used for rescreening tracking.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the eligibility evaluation was initiated, if applicable.',
    `age_eligible` BOOLEAN COMMENT 'Indicates whether the patients age falls within the trials specified age range at the time of evaluation.',
    `confidence_level` STRING COMMENT 'Confidence level of the eligibility determination based on data completeness and recency of clinical information.',
    `consent_status` STRING COMMENT 'Status of the patients informed consent for participation in the clinical trial at the time of eligibility evaluation.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of required clinical data elements that were available in the EHR at the time of eligibility evaluation.',
    `disease_stage` STRING COMMENT 'Clinical stage or severity classification of the patients condition relevant to trial inclusion criteria (e.g., TNM staging for oncology trials).',
    `effective_end_date` DATE COMMENT 'Date on which this eligibility determination expires or is superseded, supporting SCD Type 2 historization. Null indicates current record.',
    `effective_start_date` DATE COMMENT 'Date from which this eligibility determination is considered valid, supporting SCD Type 2 historization.',
    `eligibility_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the degree of patient match to trial criteria, typically expressed as a percentage (0.00 to 100.00).',
    `evaluation_method` STRING COMMENT 'Method used to perform the eligibility assessment: manual clinician review, automated algorithmic screening, or hybrid combination.',
    `evaluation_number` STRING COMMENT 'Business-facing unique reference number assigned to this eligibility evaluation for tracking and audit purposes.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the eligibility evaluation workflow.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation was performed or completed.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined in the trial protocol for this evaluation.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of exclusion criteria that the patient triggered (failed) during this evaluation.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of inclusion criteria that the patient satisfied during this evaluation.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined in the trial protocol for this evaluation.',
    `ineligibility_reason` STRING COMMENT 'Primary reason the patient was determined ineligible, referencing the specific criterion or clinical condition that disqualified them.',
    `irb_approval_reference` STRING COMMENT 'Reference number of the IRB approval under which this eligibility evaluation was conducted.',
    `lab_criteria_met` BOOLEAN COMMENT 'Indicates whether the patient meets all laboratory value requirements specified in the trial eligibility criteria.',
    `matching_algorithm_version` STRING COMMENT 'Version identifier of the automated matching algorithm used for eligibility screening, if applicable.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 code for the primary diagnosis relevant to the trial eligibility evaluation.',
    `prior_treatment_status` STRING COMMENT 'Indicates the patients prior treatment history relative to the condition being studied in the trial.',
    `protocol_version` STRING COMMENT 'Version of the clinical trial protocol against which eligibility criteria were evaluated.',
    `randomization_eligible` BOOLEAN COMMENT 'Indicates whether the patient has been cleared for randomization into the trial following successful eligibility confirmation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility evaluation record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility evaluation record was last modified.',
    `rescreening_indicator` BOOLEAN COMMENT 'Indicates whether this evaluation is a rescreening attempt after a prior screen failure for the same trial.',
    `screening_visit_date` DATE COMMENT 'Date of the formal screening visit during which eligibility assessments were conducted.',
    `waiver_approved` BOOLEAN COMMENT 'Indicates whether the eligibility waiver was approved by the sponsor or principal investigator.',
    `waiver_requested` BOOLEAN COMMENT 'Indicates whether a protocol deviation waiver was requested to enroll the patient despite not meeting all criteria.',
    `washout_period_met` BOOLEAN COMMENT 'Indicates whether the patient has completed the required washout period from prior therapies as specified by the trial protocol.',
    CONSTRAINT pk_trial_eligibility PRIMARY KEY(`trial_eligibility_id`)
) COMMENT 'Table evaluating patient eligibility against trial criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` (
    `trial_id` BIGINT COMMENT 'Primary key for trial',
    `care_site_id` BIGINT COMMENT 'Identifier of the primary facility or care site coordinating the trial.',
    `accepts_healthy_volunteers` BOOLEAN COMMENT 'Indicates whether the trial accepts participants without the condition being studied.',
    `acronym` STRING COMMENT 'Short acronym or abbreviation commonly used to refer to the trial in clinical communications.',
    `actual_enrollment` STRING COMMENT 'Current or final number of participants actually enrolled in the trial.',
    `allocation_method` STRING COMMENT 'Method used to assign participants to arms or groups in the trial.',
    `brief_title` STRING COMMENT 'Short descriptive title of the trial used for display and quick reference in matching interfaces.',
    `condition_studied` STRING COMMENT 'Primary disease, disorder, or condition that the trial is investigating, expressed as a clinical term.',
    `contact_email` STRING COMMENT 'Primary contact email for patient inquiries about trial participation.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for patient inquiries about trial enrollment.',
    `eligibility_criteria_summary` STRING COMMENT 'Free-text summary of key inclusion and exclusion criteria for participant screening and matching.',
    `eligible_sex` STRING COMMENT 'Sex-based eligibility criterion for the trial, used in patient matching filters.',
    `estimated_duration_months` STRING COMMENT 'Estimated total duration of the trial from first enrollment to study completion, in months.',
    `fda_regulated_device` BOOLEAN COMMENT 'Indicates whether the trial involves a medical device regulated by the FDA.',
    `fda_regulated_drug` BOOLEAN COMMENT 'Indicates whether the trial involves a drug product regulated by the FDA.',
    `first_posted_date` DATE COMMENT 'Date the trial record was first made publicly available on ClinicalTrials.gov.',
    `has_data_monitoring_committee` BOOLEAN COMMENT 'Indicates whether an independent data monitoring committee oversees the trial for safety.',
    `ind_number` STRING COMMENT 'FDA Investigational New Drug application number associated with the trial, if applicable.',
    `intervention_name` STRING COMMENT 'Name of the primary drug, device, biological, or other intervention being evaluated in the trial.',
    `intervention_type` STRING COMMENT 'Primary category of the intervention being studied in the trial.',
    `irb_approval_date` DATE COMMENT 'Date on which the IRB or ethics committee granted approval for the trial protocol.',
    `irb_approval_number` STRING COMMENT 'Reference number of the IRB or ethics committee approval authorizing the trial.',
    `is_actively_matching` BOOLEAN COMMENT 'Indicates whether the trial is currently enabled in the patient matching engine for automated screening.',
    `is_multi_center` BOOLEAN COMMENT 'Indicates whether the trial is conducted at more than one clinical site.',
    `last_update_posted_date` DATE COMMENT 'Date of the most recent update to the trial record on the public registry.',
    `masking_type` STRING COMMENT 'Level of blinding applied in the trial to reduce bias in outcome assessment.',
    `matching_priority_score` DECIMAL(18,2) COMMENT 'Institutional priority score assigned to the trial for patient matching algorithms, reflecting strategic importance and enrollment urgency.',
    `maximum_age_years` STRING COMMENT 'Maximum age in years for participant eligibility, critical for patient matching algorithms.',
    `minimum_age_years` STRING COMMENT 'Minimum age in years for participant eligibility, critical for patient matching algorithms.',
    `nct_number` STRING COMMENT 'ClinicalTrials.gov registry number uniquely identifying the trial in the national registry. Primary external business identifier for the trial.',
    `number_of_arms` STRING COMMENT 'Count of distinct intervention groups or arms defined in the trial protocol.',
    `number_of_sites` STRING COMMENT 'Total count of participating clinical sites or facilities conducting the trial.',
    `phase` STRING COMMENT 'Phase of the clinical trial indicating the stage of drug or intervention development being studied.',
    `primary_completion_date` DATE COMMENT 'Date on which the last participant was examined or received intervention for primary outcome measurement.',
    `primary_outcome_measure` STRING COMMENT 'Description of the primary endpoint or outcome measure used to evaluate the intervention effectiveness.',
    `primary_purpose` STRING COMMENT 'Main objective of the trial intervention in relation to the condition being studied.',
    `principal_investigator_name` STRING COMMENT 'Full name of the principal investigator leading the trial, classified as PHI when linked to provider records.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp when this trial record was first created in the clinical trial matching platform.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this trial record in the platform.',
    `results_available` BOOLEAN COMMENT 'Indicates whether trial results have been posted to the public registry.',
    `sponsor_name` STRING COMMENT 'Name of the organization or entity responsible for initiating, managing, and financing the trial.',
    `sponsor_type` STRING COMMENT 'Classification of the sponsoring organization by sector.',
    `start_date` DATE COMMENT 'Date on which the trial began enrolling participants or the first participant was screened.',
    `study_completion_date` DATE COMMENT 'Date on which the final participant completed the last visit or all data collection concluded.',
    `study_type` STRING COMMENT 'Classification of the trial by its fundamental research design approach.',
    `target_enrollment` STRING COMMENT 'Planned total number of participants to be enrolled in the trial across all sites.',
    `therapeutic_area` STRING COMMENT 'Primary disease or therapeutic area targeted by the trial, used for matching patients with relevant conditions.',
    `title` STRING COMMENT 'Official title of the clinical trial as registered with the regulatory authority.',
    `trial_status` STRING COMMENT 'Current recruitment and operational status of the clinical trial per ClinicalTrials.gov definitions.',
    CONSTRAINT pk_trial PRIMARY KEY(`trial_id`)
) COMMENT 'Table storing clinical trial metadata.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` (
    `patient_eligibility_evaluation_id` BIGINT COMMENT 'Primary key for patient_eligibility_evaluation',
    `care_site_id` BIGINT COMMENT 'Identifier of the clinical research site where this eligibility evaluation was conducted.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial against which the patient is being evaluated.',
    `eligibility_criteria_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.eligibility_criteria. Business justification: patient_eligibility_evaluation.criterion_id references a specific eligibility criterion. Adding properly named eligibility_criteria_id FK and removing the non-conforming criterion_id column.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `employee_id` BIGINT COMMENT 'Identifier of the principal investigator or authorized delegate who approved the criterion waiver.',
    `previous_evaluation_patient_eligibility_evaluation_id` BIGINT COMMENT 'Reference to the prior version of this evaluation, enabling audit trail of eligibility re-assessments over time.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which eligibility data was collected or evaluated.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000 to 1.0000) indicating the reliability of the automated eligibility determination, based on data completeness and recency.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the patient prior to performing this eligibility evaluation, as required by federal regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility evaluation record was first created in the system.',
    `criterion_category` STRING COMMENT 'Clinical category of the eligibility criterion being evaluated, such as demographic, diagnosis, laboratory value, medication, procedure, or vital sign. [ENUM-REF-CANDIDATE: demographic|diagnosis|lab_value|medication|procedure|vital_sign|comorbidity|allergy|functional_status|genomic — promote to reference product]',
    `criterion_operator` STRING COMMENT 'Logical operator used to compare the patient value against the criterion threshold (e.g., equals, greater_than, between, contains).',
    `criterion_threshold_value` DECIMAL(18,2) COMMENT 'The threshold or target value defined by the trial protocol for this criterion (e.g., >=18, <7.0, present). Stored as string to accommodate ranges and operators.',
    `criterion_type` STRING COMMENT 'Indicates whether the criterion being evaluated is an inclusion criterion or an exclusion criterion for the trial.',
    `data_completeness_flag` STRING COMMENT 'Indicates whether sufficient clinical data was available to perform a definitive evaluation: complete, partial (some data gaps), or missing (criterion could not be evaluated).',
    `data_source_system` STRING COMMENT 'Name of the clinical system from which the patient data used for evaluation was sourced (e.g., Epic EHR, Cerner Millennium, Beaker LIS).',
    `evaluation_method` STRING COMMENT 'Method used to perform the eligibility evaluation: automated (EHR-driven algorithm), manual (clinician review), or hybrid (algorithm with clinician confirmation).',
    `evaluation_notes` STRING COMMENT 'Free-text clinical notes or observations recorded by the evaluator during the eligibility assessment process.',
    `evaluation_number` STRING COMMENT 'Externally-visible business reference number for this eligibility evaluation, used in correspondence and audit trails.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of this eligibility evaluation indicating whether the criterion has been assessed and the outcome.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation was performed or last assessed for this patient-criterion combination.',
    `evaluation_version` STRING COMMENT 'Version number of this evaluation, incremented when the evaluation is re-performed due to updated patient data or protocol amendments.',
    `hipaa_authorization_status` STRING COMMENT 'Status of HIPAA authorization for using the patients PHI in this research eligibility evaluation.',
    `irb_protocol_number` STRING COMMENT 'IRB-assigned protocol number under which this eligibility evaluation is conducted, linking to regulatory oversight.',
    `is_latest_evaluation` BOOLEAN COMMENT 'Indicates whether this is the most current evaluation for this patient-criterion combination, supporting SCD Type 2 history tracking.',
    `is_protocol_deviation_allowed` BOOLEAN COMMENT 'Indicates whether a protocol deviation or waiver is permitted for this criterion per the principal investigators discretion and IRB approval.',
    `matching_diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code from the patient record that matched or was evaluated against the trial criterion, when the criterion is diagnosis-based.',
    `matching_loinc_code` STRING COMMENT 'LOINC code identifying the laboratory test or clinical observation used to evaluate this criterion.',
    `matching_medication_code` STRING COMMENT 'NDC code of the medication from the patient record evaluated against the trial criterion, when the criterion is medication-based.',
    `missing_data_description` STRING COMMENT 'Description of what clinical data is missing or incomplete that prevents a definitive eligibility determination for this criterion.',
    `override_comment` STRING COMMENT 'Free-text clinical justification provided when a provider manually overrides the automated eligibility determination.',
    `override_reason_code` STRING COMMENT 'Standardized code indicating why an evaluation result was manually overridden from the automated determination.',
    `patient_value` DECIMAL(18,2) COMMENT 'The actual clinical value observed for the patient relevant to this criterion (e.g., lab result value, age, diagnosis code). Stored as string for heterogeneous data types.',
    `patient_value_numeric` DECIMAL(18,2) COMMENT 'Numeric representation of the patients clinical value when the criterion involves a quantitative measurement (e.g., hemoglobin level, BMI, age).',
    `patient_value_unit` STRING COMMENT 'Unit of measure for the patients numeric value (e.g., mg/dL, kg/m2, years). Uses UCUM coding system where applicable.',
    `protocol_version` STRING COMMENT 'Version of the clinical trial protocol under which this eligibility evaluation was performed, critical for tracking criterion changes across amendments.',
    `rescreening_due_date` DATE COMMENT 'Date by which rescreening must be completed if the evaluation result has expired or requires re-confirmation per protocol timelines.',
    `rescreening_required` BOOLEAN COMMENT 'Indicates whether the patient needs to be rescreened for this criterion due to data staleness, protocol amendment, or indeterminate result.',
    `result_indicator` STRING COMMENT 'Outcome of the evaluation for this specific criterion: met (patient satisfies), not_met (patient does not satisfy), indeterminate (insufficient data), pending_data, or waived (PI discretion).',
    `screening_window_end_date` DATE COMMENT 'End date of the protocol-defined screening window after which this evaluation expires and rescreening is required.',
    `screening_window_start_date` DATE COMMENT 'Start date of the protocol-defined screening window during which this evaluation is valid.',
    `source_data_date` DATE COMMENT 'Date when the patient clinical data used for this evaluation was originally recorded, indicating data freshness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility evaluation record was last modified.',
    `waiver_approval_date` DATE COMMENT 'Date when the criterion waiver was formally approved by the principal investigator.',
    `waiver_reason` STRING COMMENT 'Documented justification when a criterion is waived by the principal investigator, required for regulatory audit trail.',
    CONSTRAINT pk_patient_eligibility_evaluation PRIMARY KEY(`patient_eligibility_evaluation_id`)
) COMMENT 'Table evaluating patient eligibility against trial criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` (
    `trial_eligibility_status_id` BIGINT COMMENT 'Primary key for trial_eligibility_status',
    `care_site_id` BIGINT COMMENT 'Identifier of the clinical research site or facility where the eligibility evaluation was conducted.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial for which eligibility is being assessed.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider (principal investigator or research coordinator) who performed the eligibility evaluation.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `prior_eligibility_status_trial_eligibility_status_id` BIGINT COMMENT 'Reference to the previous eligibility evaluation record for this patient-trial combination, enabling tracking of rescreening history.',
    `trial_eligibility_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.trial_eligibility. Business justification: Trial eligibility status tracks the status outcome of a trial eligibility evaluation. Links status to the evaluation it summarizes.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which eligibility screening was initiated.',
    `age_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient meets the age-related inclusion/exclusion criteria for the trial.',
    `comorbidity_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients comorbid conditions are acceptable per the trials exclusion criteria for concurrent diseases.',
    `confidence_level` STRING COMMENT 'Confidence level of the eligibility determination, reflecting data completeness and certainty of the assessment.',
    `consent_date` DATE COMMENT 'Date on which the patient provided informed consent for trial screening or enrollment.',
    `consent_status` STRING COMMENT 'Status of informed consent relative to the eligibility screening process, indicating whether the patient has consented to screening procedures.',
    `data_completeness_percent` DECIMAL(18,2) COMMENT 'Percentage of required eligibility data elements that are available in the patients EHR for automated or manual evaluation.',
    `diagnosis_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients confirmed diagnosis meets the trials disease-specific inclusion criteria.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination status for the patient relative to the clinical trial enrollment criteria.',
    `enrollment_decision` STRING COMMENT 'Final enrollment decision made following the eligibility determination, indicating the next action for the patient.',
    `enrollment_decision_date` DATE COMMENT 'Date on which the final enrollment decision was made by the investigator or study team.',
    `evaluation_date` DATE COMMENT 'Date on which the eligibility evaluation was performed or last updated.',
    `evaluation_method` STRING COMMENT 'Method used to perform the eligibility assessment, indicating whether criteria were evaluated manually by staff, through automated EHR-based screening, or a combination.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the eligibility determination was recorded in the system.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined in the clinical trial protocol.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of exclusion criteria that the patient triggers, potentially disqualifying them from enrollment.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of inclusion criteria that the patient satisfies for the clinical trial protocol.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined in the clinical trial protocol that must be evaluated.',
    `ineligibility_reason_code` STRING COMMENT 'Coded reason for ineligibility determination when the patient does not meet trial criteria. References a standardized reason code set.',
    `ineligibility_reason_description` STRING COMMENT 'Free-text narrative describing why the patient was determined ineligible, which may contain clinical details about the patients health conditions.',
    `irb_approval_reference` STRING COMMENT 'Reference number or identifier of the IRB approval associated with the eligibility waiver or protocol amendment.',
    `is_current_record` BOOLEAN COMMENT 'Indicates whether this is the most current eligibility status record for the patient-trial combination, supporting SCD Type 2 history.',
    `lab_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients laboratory results meet the trials lab-based inclusion and exclusion criteria.',
    `medication_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients current and prior medication history satisfies the trials washout and concomitant medication criteria.',
    `overall_match_score` DECIMAL(18,2) COMMENT 'Computed eligibility match score as a percentage (0-100) representing how well the patient matches the trial criteria profile.',
    `pending_criteria_details` STRING COMMENT 'Description of criteria still pending evaluation or awaiting additional clinical data (e.g., pending lab results, imaging), which may contain PHI.',
    `performance_status_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patients functional/performance status (e.g., ECOG, Karnofsky) meets the trials minimum threshold.',
    `randomization_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient has cleared all eligibility requirements and is ready for randomization into a study arm.',
    `rescreening_attempt_number` STRING COMMENT 'Sequential number indicating which rescreening attempt this evaluation represents (1 for first screen, 2+ for rescreens).',
    `rescreening_flag` BOOLEAN COMMENT 'Indicates whether this evaluation represents a rescreening attempt after a prior screening failure or withdrawal.',
    `reviewer_notes` STRING COMMENT 'Free-text notes from the research coordinator or investigator regarding the eligibility determination, which may contain clinical PHI.',
    `screening_window_end_date` DATE COMMENT 'End date of the protocol-defined screening window; eligibility must be confirmed before this date for valid enrollment.',
    `screening_window_start_date` DATE COMMENT 'Start date of the protocol-defined screening window during which eligibility assessments must be completed.',
    `source_system` STRING COMMENT 'Name of the operational system from which the eligibility evaluation data originated (e.g., Epic Healthy Planet, Cerner PowerChart).',
    `status_effective_date` DATE COMMENT 'Date on which the current eligibility status became effective, supporting SCD Type 2 tracking.',
    `status_expiration_date` DATE COMMENT 'Date on which the current eligibility determination expires and requires re-evaluation per protocol requirements.',
    `waiver_approved_flag` BOOLEAN COMMENT 'Indicates whether the protocol deviation waiver was approved by the sponsor or IRB, permitting enrollment despite criteria gaps.',
    `waiver_requested_flag` BOOLEAN COMMENT 'Indicates whether a protocol deviation waiver was requested to allow enrollment despite not meeting all criteria.',
    CONSTRAINT pk_trial_eligibility_status PRIMARY KEY(`trial_eligibility_status_id`)
) COMMENT 'Trial enrollment eligibility status table.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` (
    `patient_trial_match_id` BIGINT COMMENT 'Primary key for patient_trial_match',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or care site where the trial enrollment would occur.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial against which the patient is being matched.',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical research coordinator managing the patients trial matching process.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who referred or identified the patient as a potential trial candidate.',
    `patient_principal_investigator_clinician_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for the clinical trial at the site.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the trial match evaluation was initiated or identified.',
    `consent_date` DATE COMMENT 'Date on which the patient provided informed consent for trial participation.',
    `consent_status` STRING COMMENT 'Status of the informed consent process for the patients participation in the clinical trial.',
    `data_completeness_percent` DECIMAL(18,2) COMMENT 'Percentage of required patient data elements available at the time of eligibility evaluation, indicating confidence in the match assessment.',
    `decline_reason` STRING COMMENT 'Reason provided by the patient or their representative for declining participation in the trial after being deemed eligible.',
    `distance_to_site_miles` DECIMAL(18,2) COMMENT 'Calculated distance in miles between the patients residence and the trial site, used to assess feasibility of participation.',
    `eligibility_determination_timestamp` TIMESTAMP COMMENT 'Timestamp when the final eligibility determination was made for this patient-trial combination.',
    `enrollment_date` DATE COMMENT 'Date on which the patient was formally enrolled into the clinical trial, if applicable.',
    `evaluation_date` DATE COMMENT 'Date on which the patients eligibility for the clinical trial was formally evaluated.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined for the clinical trial.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of exclusion criteria that the patient triggers, potentially disqualifying them from the trial.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of inclusion criteria that the patient satisfies for the clinical trial.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined for the clinical trial against which the patient was evaluated.',
    `ineligibility_reason` STRING COMMENT 'Primary reason the patient was determined ineligible for the trial, referencing specific exclusion criteria or unmet inclusion criteria.',
    `irb_approval_number` STRING COMMENT 'IRB protocol approval number under which this patient-trial match is governed, ensuring ethical oversight compliance.',
    `is_diversity_candidate` BOOLEAN COMMENT 'Indicates whether the patient contributes to the trials diversity enrollment goals as required by FDA guidance on clinical trial diversity.',
    `is_re_screening_allowed` BOOLEAN COMMENT 'Indicates whether the patient is permitted to be re-screened for this trial after an initial screen failure, per protocol allowances.',
    `is_screen_failure` BOOLEAN COMMENT 'Indicates whether the patient failed the screening process after initial match identification, meaning they did not proceed to enrollment.',
    `match_confidence_level` STRING COMMENT 'Qualitative confidence level of the eligibility match, reflecting data completeness and algorithmic certainty.',
    `match_identified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient was first identified as a potential match for the clinical trial, representing the business event time.',
    `match_status` STRING COMMENT 'Current lifecycle status of the patient-trial matching evaluation, from initial screening through enrollment or exclusion.',
    `match_type` STRING COMMENT 'Method by which the patient-trial match was identified, distinguishing between algorithmic screening, manual review, or physician-initiated referral.',
    `matching_algorithm_version` STRING COMMENT 'Version identifier of the eligibility matching algorithm or rule engine used to generate this match, supporting reproducibility and audit.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the referring provider or care team was notified of the patient-trial match for clinical review.',
    `overall_eligibility_score` DECIMAL(18,2) COMMENT 'Composite numerical score representing the degree to which the patient meets the trials eligibility criteria, typically on a 0-100 scale.',
    `patient_notified_date` DATE COMMENT 'Date on which the patient was informed about the potential clinical trial opportunity.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code representing the patients primary condition relevant to the trials therapeutic area.',
    `priority_rank` STRING COMMENT 'Relative priority ranking of this trial match compared to other potential trials for the same patient, used to guide clinical discussion.',
    `randomization_date` DATE COMMENT 'Date on which the patient was randomized into a treatment arm of the clinical trial.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient-trial match record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient-trial match record was last modified.',
    `review_notes` STRING COMMENT 'Free-text clinical notes from the provider or research coordinator documenting the eligibility review rationale and clinical judgment.',
    `screen_failure_reason` STRING COMMENT 'Specific clinical or administrative reason for screen failure, used for reporting and process improvement.',
    `screening_visit_date` DATE COMMENT 'Date of the patients screening visit for the clinical trial, where formal eligibility assessments are conducted.',
    `source_system` STRING COMMENT 'Operational system from which the match was originated (e.g., Epic Healthy Planet, Cerner PowerChart, dedicated CTMS).',
    `treatment_arm` STRING COMMENT 'Treatment arm or cohort to which the patient was assigned upon enrollment (e.g., intervention, control, placebo).',
    `withdrawal_date` DATE COMMENT 'Date on which the patient withdrew from the trial matching process or from the trial itself after enrollment.',
    `withdrawal_reason` STRING COMMENT 'Reason for patient withdrawal from the trial or matching process, supporting retention analysis and regulatory reporting.',
    CONSTRAINT pk_patient_trial_match PRIMARY KEY(`patient_trial_match_id`)
) COMMENT 'Table linking patients to trials based on eligibility evaluation.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` (
    `clinical_trial_matching_trial_eligibility_criteria_id` BIGINT COMMENT 'Primary key for clinical_trial_matching_trial_eligibility_criteria',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial to which this eligibility criterion belongs.',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical provider or research coordinator who last reviewed and validated this criterion.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED CT concept identifier for the clinical condition, finding, or procedure referenced by this criterion.',
    `age_max_years` STRING COMMENT 'Maximum patient age in years allowed by this criterion, applicable when criterion_category is demographic.',
    `age_min_years` STRING COMMENT 'Minimum patient age in years required by this criterion, applicable when criterion_category is demographic.',
    `amendment_number` STRING COMMENT 'The protocol amendment number that introduced or last modified this criterion, enabling audit of criterion changes over time.',
    `automation_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000 to 1.0000) indicating the reliability of automated evaluation for this criterion based on data availability and matching algorithm performance.',
    `clinical_domain` STRING COMMENT 'The therapeutic or clinical domain to which this criterion pertains, enabling domain-specific matching logic. [ENUM-REF-CANDIDATE: oncology|cardiology|neurology|endocrinology|pulmonology|immunology|rheumatology|infectious_disease|psychiatry|nephrology|hematology — promote to reference product]',
    `comparison_operator` STRING COMMENT 'The logical comparison operator used to evaluate the criterion against patient data (equals, not equals, greater than, greater than or equal, less than, less than or equal).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility criterion record was first created in the system.',
    `criterion_category` STRING COMMENT 'Classification of the criterion by clinical domain such as demographic, diagnosis, laboratory value, medication history, procedure history, or vital sign. [ENUM-REF-CANDIDATE: demographic|diagnosis|lab_value|medication|procedure|vital_sign|comorbidity|biomarker|genetic|functional_status|imaging — promote to reference product]',
    `criterion_code` STRING COMMENT 'Unique business code identifying this specific eligibility criterion within the trial protocol, used for cross-referencing with protocol documents.',
    `criterion_description` STRING COMMENT 'Detailed narrative description of the eligibility criterion as stated in the clinical trial protocol, including any qualifying conditions or exceptions.',
    `criterion_status` STRING COMMENT 'Current lifecycle status of this eligibility criterion indicating whether it is actively used for patient matching.',
    `criterion_title` STRING COMMENT 'Short human-readable title summarizing the eligibility criterion for display in matching interfaces and protocol summaries.',
    `criterion_type` STRING COMMENT 'Indicates whether this criterion is an inclusion criterion (patient must meet) or exclusion criterion (patient must not meet) for trial participation.',
    `data_source_system` STRING COMMENT 'The EHR or clinical system from which patient data is sourced for evaluating this criterion (e.g., Epic ClinDoc, Beaker, Cerner PowerChart).',
    `effective_end_date` DATE COMMENT 'Date after which this eligibility criterion is no longer active, typically due to protocol amendment or trial closure.',
    `effective_start_date` DATE COMMENT 'Date from which this eligibility criterion becomes active for patient screening and matching.',
    `evaluation_logic_expression` STRING COMMENT 'Machine-readable logical expression or rule defining how this criterion is computationally evaluated against patient data (e.g., CQL or FHIR PathExpression).',
    `fhir_resource_type` STRING COMMENT 'The FHIR resource type that maps to this criterion for interoperability-based patient data retrieval (e.g., Condition, Observation, MedicationStatement).',
    `fhir_search_parameter` STRING COMMENT 'The FHIR search parameter expression used to query patient data for this criterion evaluation.',
    `gender_requirement` STRING COMMENT 'Required patient gender for this criterion, if the trial restricts enrollment by sex or gender.',
    `group_logical_operator` STRING COMMENT 'The logical operator (AND, OR, NOT) defining how this criterion combines with other criteria in the same group.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code referenced by this criterion for diagnosis-based eligibility evaluation.',
    `irb_approval_required` BOOLEAN COMMENT 'Indicates whether changes to this criterion require separate IRB approval before implementation.',
    `is_automatable` BOOLEAN COMMENT 'Indicates whether this criterion can be automatically evaluated against structured EHR data without manual clinical review.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this criterion is mandatory (hard criterion that cannot be waived) versus optional/preferred (soft criterion that may be waived by the principal investigator).',
    `last_reviewed_date` DATE COMMENT 'Date when this criterion was last reviewed by the clinical research team for accuracy and relevance.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the laboratory test or clinical observation referenced by this criterion, enabling automated matching against structured EHR data.',
    `lookback_period_days` STRING COMMENT 'Number of days to look back in patient history when evaluating this criterion (e.g., lab result within last 30 days, no surgery within 90 days).',
    `matching_algorithm_version` STRING COMMENT 'Version identifier of the automated matching algorithm or NLP model used to evaluate this criterion against patient records.',
    `natural_language_text` STRING COMMENT 'The original free-text eligibility criterion as written in the trial protocol, prior to structured decomposition, used for NLP-based matching and audit trail.',
    `ndc_code` STRING COMMENT 'NDC code identifying a specific medication referenced by this criterion for medication-based eligibility evaluation.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the evaluation priority or importance of this criterion relative to other criteria in the same trial, where lower numbers indicate higher priority.',
    `protocol_version` STRING COMMENT 'Version of the clinical trial protocol from which this criterion was derived, supporting criterion traceability across protocol amendments.',
    `sequence_number` STRING COMMENT 'Ordinal position of this criterion within its criterion group or overall trial eligibility list, controlling evaluation order.',
    `source_protocol_section` STRING COMMENT 'Reference to the specific section or page of the trial protocol document from which this criterion was extracted.',
    `sponsor_criterion_code` STRING COMMENT 'The trial sponsors original identifier or reference number for this criterion as provided in the sponsor protocol package.',
    `target_data_element` STRING COMMENT 'The specific EHR data element or clinical observation that must be evaluated to assess this criterion (e.g., hemoglobin A1c, ejection fraction, tumor stage).',
    `threshold_lower_bound` DECIMAL(18,2) COMMENT 'The lower numeric boundary for range-based criteria evaluation (e.g., minimum age, minimum lab value).',
    `threshold_upper_bound` DECIMAL(18,2) COMMENT 'The upper numeric boundary for range-based criteria evaluation (e.g., maximum age, maximum lab value).',
    `threshold_value` DECIMAL(18,2) COMMENT 'The target or threshold value against which patient data is compared. Stored as string to accommodate numeric, coded, and text-based criteria values.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for numeric threshold values (e.g., mg/dL, kg, years, mmHg), aligned with UCUM standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility criterion record was last modified.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether the principal investigator may grant a waiver for this criterion under documented clinical justification.',
    `waiver_justification_required` BOOLEAN COMMENT 'Indicates whether a documented justification must be provided when a waiver is granted for this criterion.',
    CONSTRAINT pk_clinical_trial_matching_trial_eligibility_criteria PRIMARY KEY(`clinical_trial_matching_trial_eligibility_criteria_id`)
) COMMENT 'Table storing eligibility criteria for trials';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` (
    `trial_enrollment_id` BIGINT COMMENT 'Primary key for trial_enrollment',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Post-acute rehab/recovery trials recruit from SNF/home health populations. Tracking the source episode enables regulatory reporting of recruitment context and study population characterization per FDA',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.trial. Business justification: Trial enrollment must reference which trial the patient is enrolling in. Adding trial_id FK to connect enrollment to trial.',
    `trial_match_id` BIGINT COMMENT 'Foreign key linking to clinical_trial_matching.trial_match. Business justification: Enrollment typically follows from a successful trial match. Linking enrollment to the match that led to it. Nullable - some enrollments may be direct without going through matching system.',
    CONSTRAINT pk_trial_enrollment PRIMARY KEY(`trial_enrollment_id`)
) COMMENT 'Table storing patient trial enrollment records.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` (
    `match_result_id` BIGINT COMMENT 'Primary key for match_result',
    `care_site_id` BIGINT COMMENT 'Identifier of the specific trial site or facility where the patient could potentially enroll if eligible.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial against which the patient was evaluated for eligibility.',
    `hipaa_authorization_id` BIGINT COMMENT 'Identifier of the HIPAA authorization record permitting use of patient data for research matching purposes.',
    `employee_id` BIGINT COMMENT 'Identifier of the ordering or referring provider who initiated or reviewed the trial match evaluation.',
    `match_principal_investigator_employee_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for the trial at the matched site.',
    `match_research_coordinator_employee_id` BIGINT COMMENT 'Identifier of the clinical research coordinator assigned to follow up on this match result.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient evaluated for clinical trial eligibility.',
    `previous_match_result_id` BIGINT COMMENT 'Reference to a prior match result for the same patient-trial combination, enabling longitudinal tracking of eligibility changes.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the trial matching was initiated or evaluated.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level (0.0000-1.0000) of the matching algorithms eligibility determination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this match result record was first created in the system.',
    `data_completeness_percent` DECIMAL(18,2) COMMENT 'Percentage of required patient data elements that were available at the time of eligibility evaluation (0-100).',
    `data_source_system` STRING COMMENT 'Name of the primary clinical system from which patient data was sourced for the eligibility evaluation (e.g., Epic EHR, Cerner Millennium).',
    `distance_to_site_km` DECIMAL(18,2) COMMENT 'Calculated distance in kilometers between the patients residence and the trial site, used for feasibility assessment.',
    `eligibility_determination` STRING COMMENT 'Final eligibility determination outcome based on the comprehensive evaluation of all inclusion and exclusion criteria.',
    `enrollment_date` DATE COMMENT 'Date when the patient was formally enrolled in the clinical trial, if applicable.',
    `enrollment_outcome` STRING COMMENT 'Final enrollment outcome indicating whether the matched patient ultimately enrolled in the trial.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the eligibility evaluation was performed against the trial criteria, representing the principal business event time.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined for the clinical trial being evaluated.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of trial exclusion criteria that the patient triggers, potentially disqualifying them from participation.',
    `expiration_date` DATE COMMENT 'Date after which this match result is no longer valid due to changes in patient condition, trial status, or enrollment capacity.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of trial inclusion criteria that the patient satisfies based on available clinical data.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined for the clinical trial being evaluated.',
    `indeterminate_criteria_count` STRING COMMENT 'Number of eligibility criteria that could not be evaluated due to missing or incomplete patient data.',
    `irb_protocol_number` STRING COMMENT 'IRB-approved protocol number associated with the clinical trial for regulatory compliance tracking.',
    `is_rescreen` BOOLEAN COMMENT 'Indicates whether this evaluation is a re-screening of a previously evaluated patient-trial combination.',
    `is_urgent` BOOLEAN COMMENT 'Indicates whether this match is flagged as urgent due to patient condition severity or trial enrollment deadline proximity.',
    `match_number` STRING COMMENT 'Externally-visible business identifier for the match result, used for tracking and communication with patients and research coordinators.',
    `match_status` STRING COMMENT 'Current lifecycle status of the trial matching evaluation indicating the disposition of the patient-trial pairing.',
    `match_type` STRING COMMENT 'Classification of the method used to perform the eligibility matching (automated algorithm, manual review, hybrid, or AI-assisted).',
    `matching_algorithm_version` STRING COMMENT 'Version identifier of the eligibility matching algorithm or model used to produce this result, supporting reproducibility and audit.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite eligibility score (0-100) representing the degree to which the patient meets all trial inclusion and exclusion criteria.',
    `patient_consent_obtained` BOOLEAN COMMENT 'Indicates whether the patient has provided consent to be contacted about this specific trial opportunity.',
    `patient_notification_status` STRING COMMENT 'Status of patient notification regarding the trial match opportunity.',
    `primary_ineligibility_reason` STRING COMMENT 'Primary reason for patient ineligibility when the determination is ineligible, often referencing specific clinical conditions or demographic factors.',
    `priority_rank` STRING COMMENT 'Relative priority ranking of this match result among all matches for the same patient, used to guide clinical decision-making.',
    `referral_date` DATE COMMENT 'Date when the patient was formally referred to the clinical trial team based on the match result.',
    `referral_status` STRING COMMENT 'Status of the patient referral to the clinical trial team following a positive eligibility match.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when a clinician or research coordinator completed their review of this match result.',
    `reviewer_notes` STRING COMMENT 'Free-text clinical notes from the reviewing physician or research coordinator regarding the match evaluation, may contain PHI.',
    `screen_failure_reason` STRING COMMENT 'Reason for screening failure if the patient was referred but did not pass the trials formal screening process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this match result record was last modified.',
    CONSTRAINT pk_match_result PRIMARY KEY(`match_result_id`)
) COMMENT 'Table for trial matching results per patient.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` (
    `clinical_trial_matching_trial_eligibility_match_id` BIGINT COMMENT 'Primary key for clinical_trial_matching_trial_eligibility_match',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to the genomic test result that produced the biomarker finding being evaluated for trial eligibility',
    `trial_id` BIGINT COMMENT 'Foreign key linking to the clinical trial against which the genomic result is being matched',
    `trial_match_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each genomic-result-to-trial eligibility match record',
    `biomarker_match_type` STRING COMMENT 'Classification of how the genomic finding matches the trials biomarker criteria — exact variant match, partial match, inferred from pathway, etc.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this match record was first created in the system',
    `eligibility_status` STRING COMMENT 'Current status of the patients eligibility for this trial based on the genomic result',
    `match_date` TIMESTAMP COMMENT 'Timestamp when the eligibility match was evaluated by the matching algorithm or coordinator',
    `match_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the strength of the genomic eligibility match to the trial biomarker criteria',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this match record',
    CONSTRAINT pk_clinical_trial_matching_trial_eligibility_match PRIMARY KEY(`clinical_trial_matching_trial_eligibility_match_id`)
) COMMENT 'This association product represents the eligibility matching event between a genomic test result and a clinical trial. It captures the precision medicine trial matching workflow where genomic findings are evaluated against trial biomarker criteria. Each record links one genomic test result to one trial with match scoring, eligibility determination, and biomarker classification attributes that exist only in the context of this matching relationship.. Existence Justification: In precision medicine, a single genomic test result (e.g., EGFR L858R mutation detected) can qualify a patient for multiple clinical trials simultaneously, and a single clinical trial accepts patients with many different genomic test results as eligibility biomarkers. Clinical trial matching is an actively managed operational process where coordinators evaluate, score, and track eligibility matches between genomic findings and trial criteria. The relationship itself carries match_score, match_date, eligibility_status, and biomarker_match_type — data that belongs to neither the test result nor the trial alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_criteria_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_criteria_evaluation_eligibility_criteria_id` FOREIGN KEY (`eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria`(`eligibility_criteria_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_criteria_evaluation_eligibility_evaluation_id` FOREIGN KEY (`eligibility_evaluation_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation`(`eligibility_evaluation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_prior_evaluation_eligibility_evaluation_id` FOREIGN KEY (`prior_evaluation_eligibility_evaluation_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation`(`eligibility_evaluation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_trial_match_id` FOREIGN KEY (`trial_match_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`(`trial_match_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_match_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_previous_match_trial_match_id` FOREIGN KEY (`previous_match_trial_match_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`(`trial_match_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_prior_evaluation_trial_eligibility_id` FOREIGN KEY (`prior_evaluation_trial_eligibility_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility`(`trial_eligibility_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_eligibility_criteria_id` FOREIGN KEY (`eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria`(`eligibility_criteria_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_previous_evaluation_patient_eligibility_evaluation_id` FOREIGN KEY (`previous_evaluation_patient_eligibility_evaluation_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation`(`patient_eligibility_evaluation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_prior_eligibility_status_trial_eligibility_status_id` FOREIGN KEY (`prior_eligibility_status_trial_eligibility_status_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status`(`trial_eligibility_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_trial_eligibility_id` FOREIGN KEY (`trial_eligibility_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility`(`trial_eligibility_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_trial_matching_clinical_trial_matching_trial_eligibility_criteria_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ADD CONSTRAINT `fk_clinical_trial_matching_trial_enrollment_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ADD CONSTRAINT `fk_clinical_trial_matching_trial_enrollment_trial_match_id` FOREIGN KEY (`trial_match_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`(`trial_match_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_previous_match_result_id` FOREIGN KEY (`previous_match_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result`(`match_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_clinical_trial_matching_trial_eligibility_match_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_clinical_trial_matching_trial_eligibility_match_trial_match_id` FOREIGN KEY (`trial_match_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`(`trial_match_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`clinical_trial_matching` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`clinical_trial_matching` SET TAGS ('dbx_domain' = 'clinical_trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria` ALTER COLUMN `eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'eligibility_criteria Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ALTER COLUMN `patient_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'patient_eligibility Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ALTER COLUMN `eligibility_criteria_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'eligibility_criteria_evaluation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ALTER COLUMN `clinical_ai_clinical_nlp_result_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Nlp Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ALTER COLUMN `eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ALTER COLUMN `eligibility_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Evaluation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `eligibility_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'eligibility_evaluation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `eligibility_override_provider_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `eligibility_override_provider_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `eligibility_referring_provider_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `eligibility_referring_provider_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `disease_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `disease_stage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `ineligibility_narrative` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `ineligibility_narrative` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `prior_treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ALTER COLUMN `prior_treatment_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ALTER COLUMN `trial_match_result_id` SET TAGS ('dbx_business_glossary_term' = 'trial_match_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ALTER COLUMN `trial_match_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Match Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `patient_eligibility_match_id` SET TAGS ('dbx_business_glossary_term' = 'patient_eligibility_match Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `biomarker_match_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `biomarker_match_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `disease_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `disease_stage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `genomic_match_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `genomic_match_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `lab_values_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `lab_values_eligible_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `prior_treatment_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `prior_treatment_eligible_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `screening_failure_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ALTER COLUMN `screening_failure_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `trial_match_id` SET TAGS ('dbx_business_glossary_term' = 'trial_match Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `trial_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'trial_eligibility Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `disease_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `disease_stage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `prior_treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ALTER COLUMN `prior_treatment_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` SET TAGS ('dbx_subdomain' = 'enrollment_operations');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'trial Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `patient_eligibility_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'patient_eligibility_evaluation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `matching_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `matching_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `matching_medication_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `matching_medication_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `patient_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `patient_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `patient_value_numeric` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ALTER COLUMN `patient_value_numeric` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `trial_eligibility_status_id` SET TAGS ('dbx_business_glossary_term' = 'trial_eligibility_status Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `trial_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `diagnosis_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `diagnosis_eligible_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `ineligibility_reason_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `ineligibility_reason_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `pending_criteria_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `pending_criteria_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `patient_trial_match_id` SET TAGS ('dbx_business_glossary_term' = 'patient_trial_match Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `review_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `review_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `screen_failure_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `screen_failure_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` SET TAGS ('dbx_subdomain' = 'criteria_management');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ALTER COLUMN `clinical_trial_matching_trial_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_trial_matching_trial_eligibility_criteria Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ALTER COLUMN `gender_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ALTER COLUMN `gender_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` SET TAGS ('dbx_subdomain' = 'enrollment_operations');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ALTER COLUMN `trial_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'trial_enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ALTER COLUMN `trial_match_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Match Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `match_result_id` SET TAGS ('dbx_business_glossary_term' = 'match_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `match_principal_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `match_principal_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `match_research_coordinator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `match_research_coordinator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `primary_ineligibility_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `primary_ineligibility_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `screen_failure_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ALTER COLUMN `screen_failure_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` SET TAGS ('dbx_subdomain' = 'match_results');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` SET TAGS ('dbx_association_edges' = 'genomics.genomic_test_result,clinical_trial_matching.trial');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `clinical_trial_matching_trial_eligibility_match_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_trial_matching_trial_eligibility_match Identifier');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Match - Genomic Test Result Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Match - Trial Id');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `trial_match_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Match ID');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `biomarker_match_type` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Match Type');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `match_date` SET TAGS ('dbx_business_glossary_term' = 'Match Date');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
