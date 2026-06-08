-- Schema for Domain: quality | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`quality` COMMENT 'Quality measurement, patient safety, regulatory reporting, and clinical compliance. Owns HEDIS measures, CAHPS surveys, CMS quality programs (VBP - Value-Based Purchasing, MIPS, APM), HAI tracking (CLABSI, CAUTI, SSI), patient safety events, mortality reviews, CDI metrics, TJC survey readiness, CMS Conditions of Participation compliance, and accreditation management. Supports Healthy Planet population health analytics.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique surrogate key for the HEDIS measure.',
    `benchmark_threshold` DECIMAL(18,2) COMMENT 'Target performance threshold expressed as a percentage.',
    `clinical_area` STRING COMMENT 'Broad clinical domain the measure belongs to (e.g., Cardiology, Diabetes).',
    `compliance_requirement` STRING COMMENT 'Regulatory program that mandates the measure (e.g., CMS, NCQA).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the measure record was first created.',
    `data_quality_flag` STRING COMMENT 'Quality assessment of the underlying data used for the measure.. Valid values are `good|fair|poor`',
    `data_source` STRING COMMENT 'Primary source system(s) used to calculate the measure.. Valid values are `EHR|Claims|Registry|Survey`',
    `denominator_definition` STRING COMMENT 'Textual definition of the denominator component of the measure.',
    `effective_end_date` DATE COMMENT 'Date when the measure was retired or superseded (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the measure became effective for reporting.',
    `eligible_population_age_max` STRING COMMENT 'Maximum age (in years) for patients to be included in the denominator.',
    `eligible_population_age_min` STRING COMMENT 'Minimum age (in years) for patients to be included in the denominator.',
    `eligible_population_sex` STRING COMMENT 'Sex eligibility criteria for the measure.. Valid values are `male|female|both`',
    `hedis_measure_description` STRING COMMENT 'Full narrative description of the measure purpose and scope.',
    `hedis_measure_status` STRING COMMENT 'Current lifecycle status of the measure definition.. Valid values are `active|retired|draft|pending`',
    `is_core_measure` BOOLEAN COMMENT 'True if the measure is part of the core HEDIS set required for reporting.',
    `last_review_date` DATE COMMENT 'Date when the measure definition was last reviewed for relevance.',
    `measure_category` STRING COMMENT 'High‑level classification of the measure purpose.. Valid values are `Preventive Care|Chronic Disease|Utilization|Effectiveness|Safety|Patient Experience`',
    `measure_code` STRING COMMENT 'Official NCQA code that uniquely identifies the measure (e.g., "ABC.01").',
    `measure_name` STRING COMMENT 'Human‑readable name of the HEDIS measure.',
    `measure_owner` STRING COMMENT 'Department or team responsible for the measure stewardship.',
    `measure_type` STRING COMMENT 'Statistical type of the measure calculation.. Valid values are `Rate|Proportion|Ratio|Count`',
    `measurement_year` STRING COMMENT 'Calendar year for which the measure is applicable.',
    `notes` STRING COMMENT 'Free‑form notes or comments from measure stewards.',
    `numerator_definition` STRING COMMENT 'Textual definition of the numerator component of the measure.',
    `population_eligibility_criteria` STRING COMMENT 'Eligibility rules that define the denominator population.',
    `related_measure_ids` STRING COMMENT 'Comma‑separated list of other HEDIS measure IDs that are logically related.',
    `reporting_frequency` STRING COMMENT 'How often the measure must be reported.. Valid values are `annual|biennial|quarterly`',
    `reporting_period_end` DATE COMMENT 'End date of the reporting window for the measure.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting window for the measure.',
    `retention_period_years` STRING COMMENT 'Number of years the measure definition must be retained for compliance.',
    `risk_adjusted` BOOLEAN COMMENT 'Indicates whether the measure results are risk‑adjusted.',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target that defines acceptable performance.',
    `unit_of_measure` STRING COMMENT 'Unit used for the measure result.. Valid values are `%|count|days|hours`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the measure record.',
    `version_number` STRING COMMENT 'Sequential version of the measure definition.',
    `status` STRING COMMENT 'Current lifecycle status of the measure definition.. Valid values are `active|retired|draft|pending`',
    `description` STRING COMMENT 'Full narrative description of the measure purpose and scope.',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'Master catalog of HEDIS (Healthcare Effectiveness Data and Information Set) measures as defined by NCQA. Stores measure specifications, measurement year, eligible population criteria, numerator/denominator definitions, benchmark thresholds, and reporting periods. SSOT for all HEDIS measure definitions used in population health and payer reporting.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'Unique surrogate key for each HEDIS result record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or care site where the measure was evaluated.',
    `clinical_order_id` BIGINT COMMENT 'foreign_key_to',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider (individual or organization) responsible for the measure.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or payer associated with the result.',
    `hedis_measure_id` BIGINT COMMENT 'description',
    `measure_id` BIGINT COMMENT 'Standard code identifying the HEDIS measure (e.g., AD001 for Adult Diabetes).',
    `mpi_record_id` BIGINT COMMENT 'description',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: HEDIS measures like Plan All-Cause Readmissions and SNF utilization rates require attribution to specific post-acute episodes for accurate rate calculation and health plan reporting.',
    `attributed_clinician_id` BIGINT COMMENT 'FK to provider.clinician.clinician_id',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'Industry or peer benchmark rate for the same measure and period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the HEDIS result record was first created in the data warehouse.',
    `data_quality_flag` STRING COMMENT 'Quality assessment of the underlying data used for the calculation.. Valid values are `good|questionable|bad`',
    `data_source` STRING COMMENT 'Primary source system used to calculate the result.. Valid values are `claims|encounter|lab|pharmacy|survey`',
    `denominator` STRING COMMENT 'Count of members in the denominator population for the measure.',
    `exclusion_count` STRING COMMENT 'Number of members excluded from the denominator per measure rules.',
    `gap_count` STRING COMMENT 'Number of members not meeting the measure (denominator minus numerator).',
    `hedis_result_status` STRING COMMENT 'Current lifecycle status of the result record.. Valid values are `active|inactive|archived`',
    `last_reviewed_by` STRING COMMENT 'Name or identifier of the analyst who performed the last review.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent quality review of the result.',
    `measure_category` STRING COMMENT 'High‑level category of the HEDIS measure.. Valid values are `preventive|screening|chronic|utilization`',
    `measure_type` STRING COMMENT 'Indicates whether the measure is administrative, clinical, or hybrid.. Valid values are `administrative|clinical|hybrid`',
    `measure_version` STRING COMMENT 'Version identifier of the measure definition (e.g., v2023).',
    `notes` STRING COMMENT 'Free‑form comments or audit notes related to the result.',
    `numerator` STRING COMMENT 'Count of members meeting the numerator criteria for the measure.',
    `rate` DECIMAL(18,2) COMMENT 'Calculated rate (numerator/denominator) expressed as a decimal fraction.',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period for which the result is calculated.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period for which the result is calculated.',
    `risk_adjusted_flag` BOOLEAN COMMENT 'Indicates whether the result has been risk‑adjusted.',
    `risk_adjusted_rate` DECIMAL(18,2) COMMENT 'Rate after applying risk‑adjustment methodology.',
    `submission_date` DATE COMMENT 'Date the result was submitted for external reporting.',
    `submission_status` STRING COMMENT 'Current status of the results submission to NCQA or the payer.. Valid values are `pending|submitted|rejected|approved`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HEDIS result record.',
    `mips_clinician_measure_id` BIGINT COMMENT 'FK to quality.mips_clinician_measure. Links HEDIS result to the corresponding MIPS clinician-level measure record for dual-program reporting.',
    `measure_name` STRING COMMENT 'Human‑readable name of the HEDIS measure.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider (individual or organization) responsible for the measure.',
    `status` STRING COMMENT 'Current lifecycle status of the result record.. Valid values are `active|inactive|archived`',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'Transactional records capturing the calculated HEDIS measure performance results for each reporting period and care site or health plan. Stores numerator count, denominator count, exclusion count, rate achieved, benchmark comparison, gap count, and submission status to NCQA or payer. Supports HEDIS hybrid and administrative measure methodologies.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`cahps_survey` (
    `cahps_survey_id` BIGINT COMMENT 'Unique identifier for the CAHPS survey record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the survey was administered.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary provider associated with the patient encounter.',
    `mpi_record_id` BIGINT COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: CAHPS surveys are administered as part of quality programs (e.g., Hospital CAHPS under CMS IQR). Linking to quality_program enables program-level survey management and reporting compliance tracking.',
    `vendor_id` BIGINT COMMENT 'Internal identifier for the survey vendor.',
    `administration_mode` STRING COMMENT 'Method used to administer the survey to patients.. Valid values are `mail|phone|mixed|online`',
    `cms_certification_status` STRING COMMENT 'CMS certification status of the survey program.. Valid values are `certified|pending|not_certified`',
    `comments` STRING COMMENT 'Free‑text comments provided by the patient.',
    `communication_doctors_score` STRING COMMENT 'Score for communication with doctors (1‑10).',
    `communication_medicines_score` STRING COMMENT 'Score for communication about medicines (1‑10).',
    `completed_question_count` STRING COMMENT 'Number of questions answered by the patient.',
    `composite_score` DECIMAL(18,2) COMMENT 'Weighted composite score across all domains.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created.',
    `discharge_info_score` STRING COMMENT 'Score for discharge information (1‑10).',
    `language_code` STRING COMMENT 'ISO 639‑1 code of the language used for the survey.. Valid values are `^[a-z]{2}$`',
    `non_response_flag` BOOLEAN COMMENT 'Indicates if the patient did not respond to the survey.',
    `overall_hospital_rating` STRING COMMENT 'Patient’s overall rating of the hospital (1‑10 scale).',
    `pain_management_score` STRING COMMENT 'Score for pain management (1‑10).',
    `patient_age` STRING COMMENT 'Age of the patient at the time of survey.',
    `patient_email` STRING COMMENT 'Primary email address of the patient.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `patient_ethnicity` STRING COMMENT 'Self-reported ethnicity of the patient. [ENUM-REF-CANDIDATE: hispanic|non_hispanic|unknown — promote to reference product]',
    `patient_gender` STRING COMMENT 'Self-reported gender of the patient.. Valid values are `male|female|other|unknown`',
    `patient_mrn` STRING COMMENT 'Medical Record Number (MRN) of the patient.',
    `patient_phone` STRING COMMENT 'Primary contact phone number of the patient.. Valid values are `^+?[0-9]{7,15}$`',
    `patient_race` STRING COMMENT 'Self-reported race of the patient. [ENUM-REF-CANDIDATE: american_indian|asian|black|native_hawaiian|white|other|unknown — promote to reference product]',
    `patient_zip` STRING COMMENT 'Five‑digit ZIP code of the patient’s residence.. Valid values are `^[0-9]{5}(?:-[0-9]{4})?$`',
    `program_effective_from` DATE COMMENT 'Date when the survey program becomes effective.',
    `program_effective_until` DATE COMMENT 'Date when the survey program ends (null if ongoing).',
    `program_status` STRING COMMENT 'Current lifecycle status of the survey program.. Valid values are `active|inactive|retired`',
    `record_status` STRING COMMENT 'Lifecycle status of the survey record.. Valid values are `draft|final|archived`',
    `response_date` DATE COMMENT 'Date the patient completed the survey.',
    `response_mode` STRING COMMENT 'Channel through which the patient submitted the survey.. Valid values are `mail|phone|online|in_person`',
    `responsiveness_staff_score` STRING COMMENT 'Score for staff responsiveness (1‑10).',
    `retention_period_years` STRING COMMENT 'Number of years the survey record must be retained to satisfy HIPAA.',
    `sampling_methodology` STRING COMMENT 'Description of the sampling approach used for the survey population.',
    `survey_cycle` STRING COMMENT 'Frequency with which the survey is administered.. Valid values are `annual|semiannual|quarterly`',
    `survey_program_name` STRING COMMENT 'Descriptive name of the CAHPS survey program.',
    `survey_question_count` STRING COMMENT 'Total number of questions in the survey instrument.',
    `survey_source_system` STRING COMMENT 'Source system that supplied the survey data (e.g., Healthy Planet).',
    `survey_type` STRING COMMENT 'Type of CAHPS survey (Hospital, Clinician and Group, or Home Health).. Valid values are `hospital|clinician|home_health`',
    `survey_version` STRING COMMENT 'Version identifier for the survey instrument.',
    `unity_catalog_tags` STRING COMMENT 'Databricks Unity Catalog tags for governance (e.g., pii, quality).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    `vendor_name` STRING COMMENT 'Name of the external vendor that administers the survey.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the survey was administered.',
    `provider_id` BIGINT COMMENT 'Identifier of the primary provider associated with the patient encounter.',
    `patient_id` BIGINT COMMENT 'Unique patient identifier (e.g., MRN).',
    CONSTRAINT pk_cahps_survey PRIMARY KEY(`cahps_survey_id`)
) COMMENT 'Master and transactional entity for CAHPS (Consumer Assessment of Healthcare Providers and Systems) survey programs and patient responses. Stores program-level data: survey type (Hospital CAHPS, Clinician and Group CAHPS, Home Health CAHPS), survey version, administration mode (mail, phone, mixed), sampling methodology, CMS certification status, and vendor information. Stores response-level data: patient-level survey responses, composite domain scores (communication with doctors, responsiveness of staff, pain management, communication about medicines, discharge information, overall hospital rating), response date, administration mode, and non-response tracking. SSOT for CAHPS survey program definitions and patient experience measurement data. Supports CMS VBP HCAHPS domain scoring and patient experience reporting.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`cahps_response` (
    `cahps_response_id` BIGINT COMMENT 'System-generated unique identifier for the CAHPS survey response record.',
    `cahps_survey_id` BIGINT COMMENT 'Identifier of the CAHPS survey definition used.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the survey was administered.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or process that created the record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient who provided the survey response.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department/unit within the facility that administered the survey.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: HHCAHPS and Hospice CAHPS surveys are CMS-mandated per episode. Linking responses to PAC episodes enables star rating calculation and Home Health VBP program reporting.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the survey administration.',
    `administration_mode` STRING COMMENT 'Method used to administer the survey to the respondent.. Valid values are `mail|phone|online|in_person|tablet|other`',
    `admission_type` STRING COMMENT 'Classification of the admission associated with the survey.. Valid values are `emergency|urgent|elective|newborn|other`',
    `age_at_survey` STRING COMMENT 'Age of the patient at the time the survey was completed.',
    `comments` STRING COMMENT 'Open‑ended comments entered by the respondent.',
    `communication_doctor_score` DECIMAL(18,2) COMMENT 'Score for the communication with doctors domain.',
    `communication_medicine_score` DECIMAL(18,2) COMMENT 'Score for the communication about medicines domain.',
    `discharge_disposition` STRING COMMENT 'Destination of the patient after discharge.. Valid values are `home|rehab|snf|expired|other`',
    `discharge_information_score` DECIMAL(18,2) COMMENT 'Score for the discharge information domain.',
    `gender` STRING COMMENT 'Self‑identified gender of the patient.. Valid values are `male|female|other|unknown`',
    `hospital_rating` STRING COMMENT 'Overall hospital rating on a 0‑10 scale provided by the respondent.',
    `is_hospital_accredited` BOOLEAN COMMENT 'Indicates whether the facility is accredited by a recognized body at the time of survey.',
    `language` STRING COMMENT 'Language in which the survey was completed.. Valid values are `en|es|fr|zh|ar|other`',
    `length_of_stay_days` STRING COMMENT 'Number of days the patient stayed in the facility for the associated encounter.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated overall CAHPS score on a 0‑10 scale.',
    `overall_score_category` STRING COMMENT 'Categorical interpretation of the overall score.. Valid values are `low|medium|high`',
    `pain_management_score` DECIMAL(18,2) COMMENT 'Score for the pain management domain.',
    `proxy_relationship` STRING COMMENT 'Relationship of the proxy to the patient when respondent_type is proxy.. Valid values are `spouse|child|parent|other`',
    `race_ethnicity` STRING COMMENT 'Race or ethnicity of the patient as reported.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the response record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the response record.',
    `reporting_period` STRING COMMENT 'Fiscal or calendar period (e.g., 2023Q1) for which the response is reported.',
    `respondent_type` STRING COMMENT 'Indicates whether the response was provided by the patient, a family member, or a proxy.. Valid values are `patient|family|proxy`',
    `response_number` STRING COMMENT 'External reference number assigned to the survey response by the source system.',
    `response_status` STRING COMMENT 'Current processing status of the survey response.. Valid values are `completed|partial|refused|pending`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the survey response was recorded.',
    `responsiveness_staff_score` DECIMAL(18,2) COMMENT 'Score for the responsiveness of staff domain.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the survey response (e.g., Epic Healthy Planet).',
    `survey_completion_time_minutes` STRING COMMENT 'Total time taken by the respondent to complete the survey.',
    `survey_name` STRING COMMENT 'Descriptive name of the CAHPS survey version.',
    `survey_version` STRING COMMENT 'Version identifier of the CAHPS survey instrument.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient who provided the survey response.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the survey administration.',
    `survey_id` BIGINT COMMENT 'Identifier of the CAHPS survey definition used.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the survey was administered.',
    `department_id` BIGINT COMMENT 'Identifier of the department/unit within the facility that administered the survey.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user or process that created the record.',
    CONSTRAINT pk_cahps_response PRIMARY KEY(`cahps_response_id`)
) COMMENT 'Transactional records of individual patient responses to CAHPS surveys. Captures patient-level survey responses, composite domain scores (communication with doctors, responsiveness of staff, pain management, communication about medicines, discharge information, overall hospital rating), response date, administration mode, and non-response tracking. Supports CMS VBP HCAHPS reporting.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` (
    `patient_safety_event_id` BIGINT COMMENT 'Unique surrogate key for the patient safety event record.',
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.crisis_episode. Business justification: Behavioral health crisis episodes (restraint use, elopement, self-harm) trigger patient safety event reports. Joint Commission and CMS require tracking which crisis events become reportable safety inc',
    `care_site_id` BIGINT COMMENT 'link',
    `clinical_order_id` BIGINT COMMENT 'description',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or provider who reported the event.',
    `health_alert_id` BIGINT COMMENT 'Foreign key linking to digital_health.health_alert. Business justification: When an RPM health alert (e.g., critical vital sign deviation) results in patient harm or near-miss, the safety event must reference the originating alert for root cause analysis and regulatory report',
    `mpi_record_id` BIGINT COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Patient safety events (falls, med errors) in SNFs/home health must link to the PAC episode for CMS incident reporting, root cause analysis, and SNF VBP safety domain scoring.',
    `primary_related_event_patient_safety_event_id` BIGINT COMMENT 'foreign_key_to',
    `unit_id` BIGINT COMMENT 'Identifier of the clinical unit or ward where the event occurred.',
    `visit_id` BIGINT COMMENT 'Identifier of the patient encounter associated with the event.',
    `new_fk` BIGINT COMMENT 'description',
    `reported_by_employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id',
    `action_due_date` DATE COMMENT 'Target date for completion of the corrective action plan.',
    `action_plan` STRING COMMENT 'Planned corrective actions and improvement measures derived from the investigation.',
    `action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|completed|overdue`',
    `contributing_factors` STRING COMMENT 'List of identified factors that contributed to the event (e.g., staffing, equipment, process).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety event record was first entered into the system.',
    `disclosure_status` STRING COMMENT 'Whether the event was disclosed to the patient/family and its current status.. Valid values are `disclosed|not_disclosed|pending`',
    `effectiveness_verification` STRING COMMENT 'Results of verification that the corrective actions have resolved the issue.',
    `event_number` STRING COMMENT 'tags: pii_phi,pii_pii,pii_sensitive',
    `event_source_system` STRING COMMENT 'Source EHR or system that captured the safety event (e.g., Epic, Cerner).',
    `event_type` STRING COMMENT 'Removed boilerplate phrase: "The column indicates ...".. Valid values are `medication_error|procedure_error|fall|infection|equipment_failure|other`',
    `harm_level` STRING COMMENT 'Severity of patient harm as defined by NCC MERP or similar scale.. Valid values are `no_harm|minor|moderate|severe|death`',
    `immediate_action` STRING COMMENT 'Actions performed immediately after the event to mitigate harm.',
    `investigation_end_date` DATE COMMENT 'Date when the investigation was concluded.',
    `investigation_start_date` DATE COMMENT 'Date when the root cause investigation began.',
    `is_reportable` BOOLEAN COMMENT 'Indicates if the event must be reported to external regulators (e.g., TJC, CMS).',
    `is_sentinel` BOOLEAN COMMENT 'True if the event meets sentinel criteria per Joint Commission standards.',
    `location` STRING COMMENT 'Physical location (unit, ward, department) where the event occurred.',
    `occurrence_timestamp` TIMESTAMP COMMENT 'Date and time when the safety event actually occurred.',
    `patient_age` STRING COMMENT 'Age of the patient at the time of the event.',
    `patient_date_of_birth` DATE COMMENT 'Birth date of the patient.',
    `patient_gender` STRING COMMENT 'Gender of the patient at the time of the event.. Valid values are `male|female|other|unknown`',
    `patient_mrn` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `patient_outcome` STRING COMMENT 'Resulting health status of the patient following the event.. Valid values are `recovered|ongoing|death|unknown`',
    `patient_safety_event_category` STRING COMMENT 'Classification of the event for reporting (e.g., sentinel event).. Valid values are `sentinel|non_sentinel|other`',
    `patient_safety_event_description` STRING COMMENT 'Add pii_phi, pii_pii, pii_sensitive tags',
    `patient_safety_event_status` STRING COMMENT 'Current lifecycle status of the safety event.. Valid values are `reported|under_review|closed|dismissed`',
    `rca_type` STRING COMMENT 'Methodology used for the investigation (Root Cause Analysis, Apparent Cause Analysis, etc.).. Valid values are `rca|aca|apparent_cause`',
    `reporting_agency` STRING COMMENT 'Regulatory body to which the event is reported.. Valid values are `TJC|CMS|State|Other`',
    `reporting_date` DATE COMMENT 'Date the event was formally reported to the regulatory agency.',
    `root_cause_summary` STRING COMMENT 'Brief summary of the identified root cause(s) of the event.',
    `severity_score` STRING COMMENT 'Numeric severity rating used for internal scoring models.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the safety event record.',
    `status` STRING COMMENT 'Current lifecycle status of the safety event.. Valid values are `reported|under_review|closed|dismissed`',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient involved in the safety event.',
    `reporter_id` BIGINT COMMENT 'Identifier of the staff member or provider who reported the event.',
    `description` STRING COMMENT 'Narrative description of what happened, including context and details.',
    `category` STRING COMMENT 'Classification of the event for reporting (e.g., sentinel event).. Valid values are `sentinel|non_sentinel|other`',
    `encounter_id` BIGINT COMMENT 'Identifier of the patient encounter associated with the event.',
    CONSTRAINT pk_patient_safety_event PRIMARY KEY(`patient_safety_event_id`)
) COMMENT 'Transactional record of patient safety events and their formal investigations. Captures event data: event type, harm level (NCC MERP or Severity of Harm scale), event description, contributing factors, immediate actions taken, patient outcome, disclosure status, and regulatory reporting obligations (TJC sentinel event, CMS). Captures investigation data: review type (RCA, ACA, apparent cause), review team members, root causes identified, contributing factors analysis, action plan items, corrective action due dates, completion status, and effectiveness verification. SSOT for the full patient safety event lifecycle from initial report through root cause analysis to action plan completion. Supports TJC sentinel event review, CMS Conditions of Participation compliance, and organizational patient safety culture.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` (
    `safety_event_review_id` BIGINT COMMENT 'Unique surrogate key for the safety event review record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or provider who led the review.',
    `mpi_record_id` BIGINT COMMENT 'Medical Record Number of the patient involved in the safety event.',
    `patient_safety_event_id` BIGINT COMMENT 'FK reference to the originating patient safety event being reviewed. Renamed from generic event_id to clarify business role per next_vibes priority.',
    `primary_patient_safety_event_id` BIGINT COMMENT 'description',
    `care_site_id` BIGINT COMMENT 'Identifier of the department where the safety event occurred.',
    `safety_location_care_site_id` BIGINT COMMENT 'Identifier of the specific location (e.g., unit, room) of the event.',
    `action_due_date` DATE COMMENT 'Target date for completion of the corrective action plan.',
    `action_plan` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `action_status` STRING COMMENT 'Current status of the action plan implementation.. Valid values are `not_started|in_progress|completed|overdue`',
    `audit_trail` STRING COMMENT 'Reference to audit log entries for this review.',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality assigned to the review document.. Valid values are `public|internal|confidential|restricted`',
    `contributing_factors` STRING COMMENT 'List of contributing factors identified during the review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `documentation_link` STRING COMMENT 'URL or path to the detailed review documentation.',
    `effectiveness_verification` STRING COMMENT 'Result of verification that corrective actions were effective.',
    `follow_up_due_date` DATE COMMENT 'Due date for any required follow-up actions.',
    `follow_up_required` BOOLEAN COMMENT 'Flag indicating whether additional follow-up is required after the review.',
    `incident_category` STRING COMMENT 'Category of the safety incident.. Valid values are `medication|procedure|equipment|communication|infection|other`',
    `incident_subcategory` STRING COMMENT 'More specific subcategory of the incident.',
    `is_reportable_to_regulator` BOOLEAN COMMENT 'Indicates if the event must be reported to external regulators (e.g., TJC, CMS).',
    `notes` STRING COMMENT 'Additional free-text notes captured by the reviewer.',
    `patient_age_at_event` STRING COMMENT 'Age of the patient at the time of the safety event.',
    `patient_gender` STRING COMMENT 'Gender of the patient.. Valid values are `male|female|other|unknown`',
    `patient_identifier_type` STRING COMMENT 'Type of identifier used for patient_id.. Valid values are `mrn|ssn|national_id`',
    `patient_race` STRING COMMENT 'Race or ethnicity of the patient as recorded.',
    `reportable_regulator` STRING COMMENT 'Name of the regulator to which the event is reportable, if applicable.',
    `retention_period_years` STRING COMMENT 'Number of years the review record must be retained per policy.',
    `review_date` DATE COMMENT 'Date when the review was conducted.',
    `review_number` STRING COMMENT 'External reference number assigned to the review for tracking.',
    `review_status` STRING COMMENT 'Current lifecycle status of the review.. Valid values are `draft|in_progress|completed|closed|rejected`',
    `review_team_members` STRING COMMENT 'Comma-separated list of team member identifiers involved in the review.',
    `review_type` STRING COMMENT 'Classification of the review methodology used.. Valid values are `root_cause|apparent_cause|process_review`',
    `reviewer_role` STRING COMMENT 'Role of the reviewer within the organization.. Valid values are `clinical|quality|risk|admin`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score for the event based on severity and likelihood.',
    `root_cause_summary` STRING COMMENT 'Brief textual summary of the identified root cause(s).',
    `severity_level` STRING COMMENT 'Severity level assigned to the safety event (1-5).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    `verification_date` DATE COMMENT 'Date when effectiveness verification was performed.',
    `patient_id` BIGINT COMMENT 'Medical Record Number of the patient involved in the safety event.',
    `event_id` BIGINT COMMENT 'Identifier of the original safety event that triggered this review.',
    `reviewer_id` BIGINT COMMENT 'Identifier of the staff member or provider who led the review.',
    `department_id` BIGINT COMMENT 'Identifier of the department where the safety event occurred.',
    `location_id` BIGINT COMMENT 'Identifier of the specific location (e.g., unit, room) of the event.',
    CONSTRAINT pk_safety_event_review PRIMARY KEY(`safety_event_review_id`)
) COMMENT 'Transactional record of the formal root cause analysis (RCA) or apparent cause analysis (ACA) conducted following a patient safety event. Captures review type, review team members, root causes identified, contributing factors, action plan items, corrective action due dates, completion status, and effectiveness verification. Supports TJC accreditation and CMS quality improvement requirements.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`mortality_review` (
    `mortality_review_id` BIGINT COMMENT 'System‑generated unique identifier for each mortality review record.',
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.crisis_episode. Business justification: Mortality reviews for behavioral health deaths examine the precipitating crisis episode. Required for sentinel event RCA when death follows a crisis intervention (e.g., restraint-related death).',
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.psychiatric_assessment. Business justification: Suicide death mortality reviews require examining the last psychiatric/risk assessment per TJC sentinel event policy. Reviewers must evaluate whether risk screening was adequate and documented.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician or quality officer who performed the review.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose encounter resulted in death.',
    `patient_safety_event_id` BIGINT COMMENT 'description',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Mortality reviews for deaths in SNF/hospice settings require the PAC episode context for preventability assessment, regulatory reporting, and quality improvement initiatives.',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.quality_committee. Business justification: Mortality reviews are conducted by quality/peer review committees (e.g., Mortality & Morbidity Committee). Linking to quality_committee identifies which committee owns the review process.',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient encounter associated with the mortality case.',
    `cmi_score` DECIMAL(18,2) COMMENT 'CMI value associated with the patient’s DRG at the time of death.',
    `contributing_factors` STRING COMMENT 'Narrative description of clinical factors that contributed to the death.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the review record was first created in the system.',
    `death_cause_code` STRING COMMENT 'ICD‑10 code representing the primary cause of death.. Valid values are `^[A-Z]d{2}(.d+)?$`',
    `death_classification` STRING COMMENT 'Classification of death as expected, unexpected, or unknown based on clinical criteria.. Valid values are `expected|unexpected|unknown`',
    `improvement_recommendations` STRING COMMENT 'Actionable recommendations generated to prevent similar future deaths.',
    `mortality_rate_category` STRING COMMENT 'Risk category (low/medium/high) derived from institutional benchmarks.. Valid values are `low|medium|high`',
    `mortality_review_status` STRING COMMENT 'Current lifecycle state of the mortality review.. Valid values are `open|in_review|closed|rejected`',
    `notes` STRING COMMENT 'Free‑form notes captured by the reviewer.',
    `preventability` STRING COMMENT 'Determination of whether the death was potentially preventable.. Valid values are `yes|no|unknown`',
    `quality_metric_flag` BOOLEAN COMMENT 'Indicates whether this review is counted toward quality‑metric reporting (e.g., CMS VBP).',
    `review_findings` STRING COMMENT 'Key findings from the peer‑review committee regarding the case.',
    `review_location` STRING COMMENT 'Physical location where the review took place (e.g., ICU, Ward, Conference Room).',
    `review_number` STRING COMMENT 'Human‑readable business identifier assigned to the review (e.g., MR‑2024‑000123).',
    `review_outcome` STRING COMMENT 'Result of the review indicating whether corrective action was taken.. Valid values are `action_taken|no_action|deferred`',
    `review_timestamp` TIMESTAMP COMMENT 'Date‑time when the mortality review was conducted.',
    `review_trigger_criteria` STRING COMMENT 'Business rule that triggered the mortality review (e.g., death within 30 days of discharge).',
    `review_type` STRING COMMENT 'Methodology used for the mortality review.. Valid values are `peer_review|clinical_review|root_cause_analysis`',
    `reviewer_role` STRING COMMENT 'Professional role of the reviewer (e.g., physician, nurse, quality officer).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the review record.',
    `status` STRING COMMENT 'Current lifecycle state of the mortality review.. Valid values are `open|in_review|closed|rejected`',
    `patient_id` BIGINT COMMENT 'Reference to the patient whose encounter resulted in death.',
    `encounter_id` BIGINT COMMENT 'Reference to the inpatient encounter associated with the mortality case.',
    `reviewer_id` BIGINT COMMENT 'Identifier of the clinician or quality officer who performed the review.',
    CONSTRAINT pk_mortality_review PRIMARY KEY(`mortality_review_id`)
) COMMENT 'Transactional record of inpatient mortality review cases conducted by the quality and peer review committee. Captures patient encounter reference, death classification (expected vs. unexpected), review trigger criteria, preventability determination, contributing clinical factors, peer review committee findings, and improvement recommendations. Supports CMI (Case Mix Index) analysis and CMS mortality outcome measures.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`vbp_program` (
    `vbp_program_id` BIGINT COMMENT 'Unique surrogate key for each VBP program record.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: VBP (Value-Based Purchasing) programs are a specific type of quality program. Linking vbp_program to quality_program establishes the parent relationship and enables unified program portfolio managemen',
    `baseline_score` DECIMAL(18,2) COMMENT 'Score calculated from baseline period data used as a reference point.',
    `clinical_outcome_weight` DECIMAL(18,2) COMMENT 'Weight (percentage) assigned to clinical outcomes in the overall VBP score.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the VBP program record was first created.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long VBP program data must be retained (e.g., "7_years").',
    `delta_tblproperties` STRING COMMENT 'Key‑value pairs for Delta table configuration (e.g., "delta.enableChangeDataFeed=true").',
    `effective_end_date` DATE COMMENT 'Date when the VBP program ends (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the VBP program becomes effective.',
    `efficiency_cost_reduction_weight` DECIMAL(18,2) COMMENT 'Weight (percentage) for efficiency and cost‑reduction measures.',
    `eligibility_criteria` STRING COMMENT 'Eligibility rules that determine which providers/hospitals can participate.',
    `is_apm_enrolled` BOOLEAN COMMENT 'True if the entity is enrolled in an Alternative Payment Model.',
    `is_care_gap_closure_included` BOOLEAN COMMENT 'True if care‑gap closure measures are part of the program.',
    `is_mips_eligible` BOOLEAN COMMENT 'Indicates whether the entity is also subject to MIPS reporting.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the program configuration was last reviewed for compliance.',
    `measure_set_description` STRING COMMENT 'Narrative description of the measure set(s) included in the program.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the VBP program.',
    `payment_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base reimbursement to calculate VBP payment adjustment.',
    `performance_score` DECIMAL(18,2) COMMENT 'Score derived from the performance period data.',
    `person_community_engagement_weight` DECIMAL(18,2) COMMENT 'Weight (percentage) for person‑ and community‑engagement measures.',
    `program_code` STRING COMMENT 'External code used by CMS to identify the VBP program.',
    `program_name` STRING COMMENT 'Descriptive name of the VBP program (e.g., "Hospital VBP 2024").',
    `program_type` STRING COMMENT 'Classification of the program: VBP, MIPS, or APM.. Valid values are `VBP|MIPS|APM`',
    `program_year` STRING COMMENT 'Fiscal year to which the VBP program applies.',
    `reporting_period_end` DATE COMMENT 'End date of the performance reporting period.',
    `reporting_period_start` DATE COMMENT 'Start date of the performance reporting period.',
    `safety_weight` DECIMAL(18,2) COMMENT 'Weight (percentage) for safety measures in the VBP score.',
    `total_performance_score` DECIMAL(18,2) COMMENT 'Aggregated score after applying domain weights and adjustments.',
    `unity_catalog_tags` STRING COMMENT 'Comma‑separated list of Unity Catalog tags for governance (e.g., "pii,hipaa").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the VBP program record.',
    `vbp_program_status` STRING COMMENT 'Current lifecycle status of the VBP program.. Valid values are `active|inactive|pending|closed`',
    `status` STRING COMMENT 'Current lifecycle status of the VBP program.. Valid values are `active|inactive|pending|closed`',
    CONSTRAINT pk_vbp_program PRIMARY KEY(`vbp_program_id`)
) COMMENT 'Master entity for CMS Value-Based Purchasing (VBP) program participation and performance tracking. Stores program year, domain weights (clinical outcomes, person and community engagement, safety, efficiency and cost reduction), baseline and performance period definitions, total performance score methodology, and payment adjustment factor. SSOT for VBP program configuration.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`measure` (
    `measure_id` BIGINT COMMENT 'System-generated unique identifier for the quality measure.',
    `care_gap_measure_id` BIGINT COMMENT 'Reference to the parent measure that defines the care gap.',
    `active_status` STRING COMMENT 'Current lifecycle status of the measure definition.. Valid values are `active|inactive|retired`',
    `apm_program_enrollment_flag` BOOLEAN COMMENT 'True if the measure is used for Alternative Payment Model program enrollment.',
    `benchmark_threshold` STRING COMMENT 'Target performance level or threshold for the measure (e.g., 90%).',
    `calculation_logic` STRING COMMENT 'Algorithmic description or SQL snippet used to compute the measure.',
    `care_gap_closure_flag` BOOLEAN COMMENT 'Indicates whether the measure tracks closure of identified care gaps.',
    `clinical_area` STRING COMMENT 'Clinical specialty or condition area the measure addresses.',
    `cms_ecqm_identifier` STRING COMMENT 'Electronic Clinical Quality Measure identifier assigned by CMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the measure record was first created.',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall data quality for the measure calculation.. Valid values are `good|questionable|bad`',
    `data_source` STRING COMMENT 'Primary source of data used to calculate the measure (EHR, claims, registry, survey, or other).. Valid values are `ehr|claims|registry|survey|other`',
    `denominator_definition` STRING COMMENT 'Specification of the patient set forming the denominator.',
    `documentation_url` STRING COMMENT 'Link to the detailed measure specification document.',
    `effective_date` DATE COMMENT 'Date when the measure definition becomes effective.',
    `eligible_population_criteria` STRING COMMENT 'Logical definition of the patient cohort eligible for the measure.',
    `exclusion_criteria` STRING COMMENT 'Specific exclusion rules for patients to be omitted.',
    `frequency` STRING COMMENT 'How often the measure is reported.. Valid values are `annual|quarterly|monthly|semiannual`',
    `inclusion_criteria` STRING COMMENT 'Specific inclusion rules for patients to be counted.',
    `is_composite_measure` BOOLEAN COMMENT 'Indicates whether the measure is composed of multiple component measures.',
    `is_mips_measure` BOOLEAN COMMENT 'True if the measure is part of the MIPS program.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the measure was last reviewed for relevance or accuracy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the measure definition.',
    `measure_category` STRING COMMENT 'High‑level domain category (e.g., Clinical, Patient Safety, Experience).',
    `measure_code` STRING COMMENT 'External business code or number used to reference the measure (e.g., NQF number or internal catalog code).',
    `measure_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and calculation of the measure.',
    `measure_name` STRING COMMENT 'Human‑readable title of the quality measure.',
    `measure_type` STRING COMMENT 'Classification of the measure (process, outcome, structural, patient experience, or composite).. Valid values are `process|outcome|structural|patient_experience|composite`',
    `measurement_methodology` STRING COMMENT 'Method used to calculate the measure (administrative, hybrid, chart‑abstracted).',
    `measurement_year` STRING COMMENT 'Calendar year for which the measure is reported.',
    `mips_category` STRING COMMENT 'MIPS performance category to which the measure belongs.. Valid values are `quality|efficiency|improvement|cost`',
    `mips_measure_type` STRING COMMENT 'Specifies whether the MIPS measure is outcome‑based or process‑based.. Valid values are `outcome|process`',
    `mips_reporting_option` STRING COMMENT 'Indicates if the measure is reported publicly or privately.. Valid values are `public|private`',
    `nqf_number` STRING COMMENT 'National Quality Forum identifier when applicable.',
    `numerator_definition` STRING COMMENT 'Specification of the event(s) counted in the numerator.',
    `owner` STRING COMMENT 'Name of the individual or team that owns the measure.',
    `owner_contact` STRING COMMENT 'Email address of the measure owner for communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period.',
    `reporting_program` STRING COMMENT 'Program or initiative for which the measure is reported (e.g., CMS IQR, VBP, MIPS, TJC, NCQA HEDIS, internal).. Valid values are `cms_iqr|vbp|mips|tjc|ncqa_hedis|internal`',
    `retirement_date` DATE COMMENT 'Date when the measure is retired or superseded (nullable).',
    `review_cycle` STRING COMMENT 'Frequency with which the measure definition is formally reviewed.. Valid values are `annual|biennial`',
    `specialty` STRING COMMENT 'Provider specialty relevant to the measure, if applicable.',
    `steward` STRING COMMENT 'Organization or department responsible for the measure definition and maintenance.',
    `target_population` STRING COMMENT 'Description of the patient population targeted by the measure.',
    `name` STRING COMMENT 'Human‑readable title of the quality measure.',
    `description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and calculation of the measure.',
    `cms_ecqm_id` STRING COMMENT 'Electronic Clinical Quality Measure identifier assigned by CMS.',
    `measure_owner` STRING COMMENT 'Name of the individual or team that owns the measure.',
    `measure_owner_contact` STRING COMMENT 'Email address of the measure owner for communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    CONSTRAINT pk_measure PRIMARY KEY(`measure_id`)
) COMMENT 'Master catalog of all quality measures tracked by the organization across programs (CMS IQR, OQR, VBP, MIPS, TJC, NCQA HEDIS, state-specific, internal). Stores measure ID, measure title, measure steward (CMS, NCQA, TJC, NQF), measure type (process, outcome, structural, patient experience), data source, reporting program, NQF number, CMS eCQM identifier, NCQA HEDIS measure specifications, eligible population criteria, numerator/denominator definitions, benchmark thresholds, measurement methodology (administrative, hybrid, chart-abstracted), measurement year, reporting period, and active status. Consolidates all measure definitions including HEDIS measures formerly tracked separately. SSOT for all enterprise quality measure definitions.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`measure_result` (
    `measure_result_id` BIGINT COMMENT 'Unique surrogate key for each quality measure result record.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure definition that this result pertains to.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: Measure results are reported within the context of a quality program (CMS IQR, VBP, MIPS). The existing STRING program column is denormalized. Adding a proper FK normalizes this and enables program-',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'Average performance rate for the measure across all reporting entities nationally.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the result record was first inserted into the data lake.',
    `data_quality_comment` STRING COMMENT 'Free‑text comment explaining the data quality flag.',
    `data_quality_flag` STRING COMMENT 'Overall data quality assessment for the result record.. Valid values are `good|questionable|bad`',
    `data_source` STRING COMMENT 'Primary source system used to calculate the result.. Valid values are `claims|EHR|registry|survey`',
    `denominator` BIGINT COMMENT 'Count of events that constitute the measure denominator.',
    `entity_type` STRING COMMENT 'Type of entity (facility, provider, patient, or health plan) to which the result applies.. Valid values are `facility|provider|patient|health_plan`',
    `exclusion_count` BIGINT COMMENT 'Number of cases excluded from the denominator based on measure‑specific rules.',
    `exclusion_reason` STRING COMMENT 'Narrative reason for exclusion, if applicable.',
    `gap_to_target` DECIMAL(18,2) COMMENT 'Difference between actual performance_rate and target_rate (positive if below target).',
    `is_excluded` BOOLEAN COMMENT 'Indicates whether the entity is excluded from reporting for this measure.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent quality review of this result.',
    `measure_category` STRING COMMENT 'High‑level classification of the measure (outcome, process, or structure).. Valid values are `outcome|process|structure`',
    `measure_result_status` STRING COMMENT 'Current lifecycle status of the measure result.. Valid values are `pending|final|retracted`',
    `measure_version` STRING COMMENT 'Version identifier of the measure definition used for this result.',
    `measured_entity_identifier` BIGINT COMMENT 'Surrogate key of the entity (facility, provider, patient, or health plan) for which the result is reported.',
    `national_benchmark_rate` DECIMAL(18,2) COMMENT 'Duplicate field retained for legacy reporting compatibility.',
    `notes` STRING COMMENT 'Additional comments or observations about the result.',
    `numerator` BIGINT COMMENT 'Count of events that satisfy the measure numerator criteria.',
    `percentile_rank` STRING COMMENT 'Percentile position of the entitys performance relative to peers.',
    `performance_rate` DECIMAL(18,2) COMMENT 'Calculated rate (numerator/denominator) expressed as a decimal.',
    `quality_domain` STRING COMMENT 'Domain within quality management to which the measure belongs.. Valid values are `patient_safety|clinical|population|process`',
    `reporting_method` STRING COMMENT 'Method used to calculate the measure (administrative, hybrid, or chart‑abstracted).. Valid values are `administrative|hybrid|chart_abstracted`',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period for which the measure result is calculated.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period for which the measure result is calculated.',
    `reporting_quarter` STRING COMMENT 'Quarter (1‑4) of the reporting period.',
    `reporting_year` STRING COMMENT 'Calendar year of the reporting period.',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the measure result was generated.',
    `reviewed_by` STRING COMMENT 'Identifier of the user or role that performed the last review.',
    `risk_adjusted_flag` BOOLEAN COMMENT 'Indicates whether the result has been risk‑adjusted.',
    `risk_adjusted_rate` DECIMAL(18,2) COMMENT 'Performance rate after applying risk adjustment.',
    `submission_status` STRING COMMENT 'Current status of the measure result submission to the reporting program.. Valid values are `submitted|pending|rejected|approved`',
    `target_rate` DECIMAL(18,2) COMMENT 'Target performance rate defined by the reporting program or national benchmark.',
    `unit_of_measure` STRING COMMENT 'Unit used for the performance rate (e.g., percent, ratio).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the result record.',
    `status` STRING COMMENT 'Current lifecycle status of the measure result.. Valid values are `pending|final|retracted`',
    `entity_id` BIGINT COMMENT 'Surrogate key of the entity (facility, provider, patient, or health plan) for which the result is reported.',
    `program` STRING COMMENT 'Quality reporting program under which the measure is submitted.. Valid values are `CMS_IQR|OQR|VBP|MIPS|HEDIS|State`',
    `measure_code` STRING COMMENT 'Standardized code (e.g., HEDIS, CMS) identifying the measure.',
    `measure_description` STRING COMMENT 'Human‑readable description of the measure purpose and scope.',
    CONSTRAINT pk_measure_result PRIMARY KEY(`measure_result_id`)
) COMMENT 'Transactional records of quality measure performance results at the facility, unit, provider, or health plan level for a given reporting period. Captures numerator, denominator, exclusion count, performance rate, national benchmark, percentile rank, target rate, gap to target, gap count, measurement methodology (administrative, hybrid, chart-abstracted), reporting program (CMS IQR, OQR, VBP, MIPS, HEDIS, state), NCQA or payer submission status, benchmark comparison, VBP domain-level achievement/improvement scores, and HEDIS hybrid/administrative methodology indicators. Consolidates all measure results including HEDIS results formerly tracked separately. SSOT for all quality measure performance data across all programs.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`cdi_review` (
    `cdi_review_id` BIGINT COMMENT 'Unique surrogate key for each Clinical Documentation Improvement (CDI) review record.',
    `clinical_ai_clinical_nlp_result_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.clinical_nlp_result. Business justification: CDI programs use NLP to identify documentation gaps triggering physician queries. Linking CDI reviews to the NLP result that flagged the opportunity is standard in AI-assisted CDI workflows for DRG ac',
    `employee_id` BIGINT COMMENT 'Unique identifier of the clinician or coder who performed the CDI review.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose chart is under CDI review.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the CDI review.',
    `cc_mcc_captured` BOOLEAN COMMENT 'Indicates whether a Complication/Comorbidity or Major Complication/Comorbidity was captured during the review.',
    `cdi_review_status` STRING COMMENT 'Current lifecycle state of the CDI review.. Valid values are `pending|in_progress|completed|cancelled`',
    `clinical_indicator` STRING COMMENT 'Specific clinical condition or documentation element that prompted the query.',
    `cmi_final` DECIMAL(18,2) COMMENT 'CMI value after the CDI review.',
    `cmi_impact` DECIMAL(18,2) COMMENT 'Numeric difference between final and initial CMI (cmi_final - cmi_initial).',
    `cmi_initial` DECIMAL(18,2) COMMENT 'CMI value calculated from the initial DRG.',
    `compliance_flag` STRING COMMENT 'Regulatory compliance category applicable to the review.. Valid values are `HIPAA|CMS|TJC|None`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the CDI review record was first created.',
    `documentation_impact` STRING COMMENT 'Effect of the query on the chart: DRG change, CC/MCC capture, POA update, or none.. Valid values are `drg_change|cc_mcc_capture|poa_update|none`',
    `drg_final` STRING COMMENT 'DRG code after the CDI review and any documentation changes.',
    `drg_initial` STRING COMMENT 'Diagnosis‑Related Group code assigned before the CDI review.',
    `is_flagged` BOOLEAN COMMENT 'Indicates whether the review was flagged for further audit or compliance review.',
    `physician_response` STRING COMMENT 'Free‑text capture of the physicians answer to the query.',
    `poa_assigned` BOOLEAN COMMENT 'True if the reviewer assigned a Present‑on‑Admission indicator.',
    `quality_metric_score` DECIMAL(18,2) COMMENT 'Score reflecting the quality impact of the CDI review (e.g., CMI improvement percentage).',
    `query_method` STRING COMMENT 'How the query was communicated to the physician.. Valid values are `verbal|written|electronic`',
    `query_notes` STRING COMMENT 'Additional free‑text notes related to the query.',
    `query_outcome` STRING COMMENT 'Result of the query after physician response.. Valid values are `resolved|unresolved|deferred`',
    `query_present` BOOLEAN COMMENT 'True if a physician query was generated as part of the CDI review.',
    `query_type` STRING COMMENT 'Classification of the query: compliant (required) or leading (suggested).. Valid values are `compliant|leading`',
    `retention_period_years` STRING COMMENT 'Number of years the CDI review record must be retained to satisfy HIPAA and other regulations.',
    `review_duration_minutes` STRING COMMENT 'Total time spent on the CDI review, measured in minutes.',
    `review_location` STRING COMMENT 'Physical location (unit/ward) where the CDI review took place.',
    `review_notes` STRING COMMENT 'Reviewer’s free‑text observations and recommendations.',
    `review_number` STRING COMMENT 'Human‑readable identifier assigned to the CDI review for tracking and reporting.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the CDI review was performed.',
    `review_type` STRING COMMENT 'Classification of the review (initial, follow‑up, or post‑discharge).. Valid values are `initial|follow_up|post_discharge`',
    `reviewer_credentials` STRING COMMENT 'Professional credentials of the reviewer (e.g., MD, RN, CDA).',
    `reviewer_name` STRING COMMENT 'Legal name of the reviewer conducting the CDI activity.',
    `reviewer_role` STRING COMMENT 'Professional role of the reviewer conducting the CDI activity.. Valid values are `physician|nurse|coder|clinical_documentation_specialist`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the CDI review record.',
    `status` STRING COMMENT 'Current lifecycle state of the CDI review.. Valid values are `pending|in_progress|completed|cancelled`',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient whose chart is under CDI review.',
    `reviewer_id` BIGINT COMMENT 'Unique identifier of the clinician or coder who performed the CDI review.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the CDI review.',
    CONSTRAINT pk_cdi_review PRIMARY KEY(`cdi_review_id`)
) COMMENT 'Transactional record of Clinical Documentation Improvement (CDI) concurrent and retrospective chart reviews and all associated physician queries. Captures review data: review date, review type (initial, follow-up, post-discharge), working DRG, final DRG, CC/MCC capture status, POA assignment, CMI impact, and reviewer credentials. Captures query data: query type (compliant vs. leading), query method (verbal, written, electronic), clinical indicator supporting query, physician response, documentation impact (DRG change, CC/MCC capture, POA status), and query outcome. SSOT for CDI program activity encompassing both review and query workflows. Supports CDI program productivity tracking, CMI optimization, physician query response rate monitoring, and quality documentation integrity.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Unique surrogate key for the accreditation program record.',
    `accreditation_cycle_end` DATE COMMENT 'End date of the accreditation cycle.',
    `accreditation_cycle_start` DATE COMMENT 'Start date of the accreditation cycle.',
    `accreditation_cycle_status` STRING COMMENT 'Current status of the accreditation cycle.. Valid values are `ongoing|completed|overdue|cancelled`',
    `accreditation_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the accreditation program.',
    `accreditation_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|suspended|expired`',
    `accrediting_body` STRING COMMENT 'Organization that grants the accreditation (e.g., The Joint Commission, NCQA, CMS).',
    `cms_acceptance_date` DATE COMMENT 'Date CMS recorded its acceptance status.',
    `cms_acceptance_status` STRING COMMENT 'CMSs acceptance of the accreditation outcome.. Valid values are `accepted|rejected|pending`',
    `compliance_status` STRING COMMENT 'Overall compliance status after the survey.. Valid values are `compliant|non_compliant|partial|under_review`',
    `compliance_status_date` DATE COMMENT 'Date the compliance status was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accreditation program record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the fee.. Valid values are `^[A-Z]{3}$`',
    `cycle_end_date` DATE COMMENT 'End date of the current accreditation cycle.',
    `cycle_number` STRING COMMENT 'Sequential identifier for the accreditation cycle.',
    `cycle_start_date` DATE COMMENT 'Start date of the current accreditation cycle.',
    `decision` STRING COMMENT 'Outcome of the accreditation survey.. Valid values are `accredited|provisional|denied|withdrawn`',
    `decision_date` DATE COMMENT 'Date the accreditation decision was issued.',
    `documentation_url` STRING COMMENT 'Link to supporting documentation or evidence files.',
    `effective_from` DATE COMMENT 'Date the accreditation program becomes effective.',
    `effective_until` DATE COMMENT 'Date the accreditation program ends or expires (nullable for open‑ended).',
    `fee_paid_date` DATE COMMENT 'Date the accreditation fee was received.',
    `fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the accreditation fee has been paid.',
    `findings_count` STRING COMMENT 'Total number of findings identified in the survey.',
    `findings_summary` STRING COMMENT 'Narrative summary of the survey findings.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent audit of the accreditation record.',
    `last_reviewed_by` STRING COMMENT 'Name or identifier of the user who last reviewed the accreditation record.',
    `next_survey_due_date` DATE COMMENT 'Planned date for the next accreditation survey.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the accreditation program.',
    `plan_of_correction` STRING COMMENT 'Detailed corrective action plan to address findings.',
    `poc_deadline` DATE COMMENT 'Target date for completing the plan of correction.',
    `poc_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|in_progress|completed|closed`',
    `program_category` STRING COMMENT 'High‑level classification of the program (accreditation, certification, or designation).. Valid values are `accreditation|certification|designation`',
    `program_name` STRING COMMENT 'Descriptive name of the accreditation or certification program.',
    `program_type` STRING COMMENT 'Category of care setting the program applies to.. Valid values are `hospital|clinic|ambulatory|specialty|home_health`',
    `renewal_due_date` DATE COMMENT 'Date by which the accreditation must be renewed.',
    `resolution_date` DATE COMMENT 'Date the resolution status was finalized.',
    `resolution_status` STRING COMMENT 'Final resolution status of all findings.. Valid values are `resolved|unresolved|deferred`',
    `risk_level` STRING COMMENT 'Overall risk rating associated with the accreditation findings.. Valid values are `low|moderate|high|critical`',
    `standards_chapters_reviewed` STRING COMMENT 'List of standards or chapters examined during the survey.',
    `survey_date` DATE COMMENT 'Date the accreditation survey was performed.',
    `survey_scope` STRING COMMENT 'Scope of the survey (e.g., tracer methodology, environment of care).',
    `survey_type` STRING COMMENT 'Methodology of the accreditation survey.. Valid values are `triennial|unannounced|for_cause|validation|internal_mock|readiness_tracer`',
    `surveyor_team` STRING COMMENT 'Names or identifiers of the surveyor team members.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|suspended|expired`',
    CONSTRAINT pk_accreditation_program PRIMARY KEY(`accreditation_program_id`)
) COMMENT 'Master and transactional entity for accreditation, certification, and regulatory compliance programs. Stores program-level data: accrediting body (TJC, DNV, HFAP, NCQA, URAC, CMS), program type (hospital accreditation, disease-specific certification, primary stroke center, chest pain center), accreditation cycle, current status, and expiration date. Stores survey-level data: survey date, survey type (triennial, unannounced, for-cause, validation, internal mock, readiness tracer), surveyor team, survey scope (tracer methodology, environment of care, life safety), standards chapters reviewed, findings count, and accreditation decision. Stores finding-level data: standard reference (TJC NPSG, CMS CoP condition, state regulation), finding type (RFI, Immediate Threat, Condition-Level Deficiency, Standard-Level Deficiency), compliance status, evidence, plan of correction, CMS acceptance status, and resolution status. SSOT for organizational accreditation portfolio, survey history, and compliance findings.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` (
    `accreditation_survey_id` BIGINT COMMENT 'Unique surrogate key for the accreditation survey record.',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_program. Business justification: An accreditation survey is conducted for a specific accreditation program (e.g., TJC Hospital Accreditation, CMS Deemed Status). This is a fundamental parent-child relationship — surveys are events wi',
    `care_site_id` BIGINT COMMENT 'Reference to the facility being surveyed.',
    `facility_organization_id` BIGINT COMMENT 'Reference to the accrediting body entity.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: Joint Commission and CMS surveys of SNFs, home health agencies, and hospices must reference the specific PAC location for compliance tracking, corrective action plans, and certification status.',
    `surveyor_team_id` BIGINT COMMENT 'Reference to the surveyor team entity.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id',
    `accreditation_decision` STRING COMMENT 'Final decision outcome of the survey.. Valid values are `accredited|conditionally_accredited|denied|pending`',
    `accrediting_body` STRING COMMENT 'Name of the organization conducting the accreditation (e.g., The Joint Commission).',
    `compliance_score` DECIMAL(18,2) COMMENT 'Score representing compliance with standards (0-100).',
    `corrective_action_plan_due` DATE COMMENT 'Deadline for submitting corrective action plan.',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates if a corrective action plan is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'HIPAA retention annotation for the survey record.',
    `decision_date` DATE COMMENT 'Date when the accreditation decision was made.',
    `documentation_completeness_score` DECIMAL(18,2) COMMENT 'Score for completeness of documentation.',
    `external_audit_reference` STRING COMMENT 'Reference number linking to external audit reports.',
    `external_survey_code` BIGINT COMMENT 'description',
    `findings_high_priority` STRING COMMENT 'Number of findings classified as high priority.',
    `findings_low_priority` STRING COMMENT 'Number of findings classified as low priority.',
    `findings_medium_priority` STRING COMMENT 'Number of findings classified as medium priority.',
    `findings_total` STRING COMMENT 'Total number of findings identified in the survey.',
    `infection_control_findings` STRING COMMENT 'Number of infection control related findings.',
    `next_survey_due_date` DATE COMMENT 'Planned date for the next accreditation survey.',
    `overall_readiness_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) indicating facility readiness.',
    `patient_safety_event_count` STRING COMMENT 'Number of patient safety events identified.',
    `preliminary_findings` STRING COMMENT 'Narrative summary of preliminary findings.',
    `risk_level` STRING COMMENT 'Overall risk level assigned based on findings.. Valid values are `low|moderate|high|critical`',
    `staff_training_compliance` BOOLEAN COMMENT 'Indicates if staff training compliance was satisfactory.',
    `standards_chapters_reviewed` STRING COMMENT 'List of standard chapters (e.g., TJC Chapter 1) reviewed during the survey.',
    `survey_date` DATE COMMENT 'Date when the on-site survey was conducted.',
    `survey_duration_minutes` STRING COMMENT 'Total duration of the survey in minutes.',
    `survey_location` STRING COMMENT 'Physical location within the facility where survey was performed.',
    `survey_notes` STRING COMMENT 'Additional notes captured by surveyors.',
    `survey_number` STRING COMMENT 'External identifier assigned to the survey by the accrediting organization.',
    `survey_scope` STRING COMMENT 'Scope of the survey activities.. Valid values are `environment_of_care|tracer|process|policy|documentation`',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey.. Valid values are `draft|scheduled|in_progress|completed|closed|cancelled`',
    `survey_type` STRING COMMENT 'Classification of the survey type. [ENUM-REF-CANDIDATE: internal|external|unannounced|triennial|for_cause|validation|mock — 7 candidates stripped; promote to reference product]',
    `surveyor_team` STRING COMMENT 'Comma-separated list of surveyor names or IDs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    `accrediting_body_id` BIGINT COMMENT 'Reference to the accrediting body entity.',
    `facility_id` BIGINT COMMENT 'Reference to the facility being surveyed.',
    CONSTRAINT pk_accreditation_survey PRIMARY KEY(`accreditation_survey_id`)
) COMMENT 'Transactional record of accreditation surveys, on-site visits, and internal readiness assessments conducted by accrediting bodies or quality department staff. Captures survey date, survey type (triennial, unannounced, for-cause, validation, internal mock, readiness tracer), surveyor or assessor team composition, survey scope (tracer methodology, environment of care, life safety), standards chapters reviewed, findings count by priority level, overall readiness score, preliminary findings, and accreditation decision. Supports TJC survey readiness, CMS CoP compliance tracking, and continuous survey readiness programs.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` (
    `standard_finding_id` BIGINT COMMENT 'Unique surrogate key for each compliance finding record.',
    `accreditation_survey_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_survey. Business justification: Standard findings are discovered during accreditation surveys. A finding belongs to one survey. This links the finding to the specific survey event where it was identified. Essential for tracking surv',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or site where the finding was observed.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider responsible for the area where the finding originated.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient associated with the finding, if applicable.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department linked to the finding.',
    `employee_id` BIGINT COMMENT 'System user who created the finding record.',
    `apm_program_enrollment_id` BIGINT COMMENT 'Identifier of the Alternative Payment Model program tied to the finding.',
    `mips_clinician_measure_id` BIGINT COMMENT 'Identifier of the MIPS clinician‑level measure associated with the finding.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure linked to this finding.',
    `standard_employee_id` BIGINT COMMENT 'Identifier of the individual accountable for implementing the corrective action.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter linked to the finding.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the finding.',
    `audit_trail` STRING COMMENT 'Chronological log of actions taken on the finding.',
    `care_gap_closure_status` STRING COMMENT 'Status of any care‑gap closure activity linked to the finding.. Valid values are `closed|open|not_applicable`',
    `care_gap_target_date` DATE COMMENT 'Target date for closing the associated care gap.',
    `cms_acceptance_status` STRING COMMENT 'CMSs acceptance or rejection of the corrective plan.. Valid values are `accepted|rejected|pending`',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing the corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the financial impact.',
    `due_date` DATE COMMENT 'Date by which the corrective action must be completed.',
    `evidence` STRING COMMENT 'Supporting documentation or artifacts evidencing the finding.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the finding.',
    `finding_code` STRING COMMENT 'Business identifier code assigned to the finding (e.g., FND-2023-001).',
    `finding_title` STRING COMMENT 'Short descriptive title of the compliance finding.',
    `finding_type` STRING COMMENT 'Classification of the finding based on regulatory taxonomy.. Valid values are `condition_level|standard_level|immediate_threat|requirement_improvement`',
    `is_critical_to_patient_safety` BOOLEAN COMMENT 'True if the finding poses a direct risk to patient safety.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the finding must be reported to external regulators.',
    `notes` STRING COMMENT 'Free‑form notes or comments added by reviewers.',
    `plan_of_correction` STRING COMMENT 'Prescribed corrective actions to remediate the finding.',
    `related_regulation` STRING COMMENT 'Regulatory or accreditation standard that the finding pertains to (e.g., CMS CoP, TJC NPSG).',
    `reported_by` STRING COMMENT 'Name of the individual who reported the finding.',
    `reported_by_role` STRING COMMENT 'Professional role of the person who reported the finding.. Valid values are `nurse|physician|quality_officer|admin|other`',
    `resolution_date` DATE COMMENT 'Date the finding was resolved or closed.',
    `resolution_status` STRING COMMENT 'Outcome of the corrective action.. Valid values are `resolved|unresolved|partial|not_applicable`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating assigned to the finding.',
    `root_cause_category` STRING COMMENT 'High‑level category describing the underlying cause of the finding.. Valid values are `process|system|human|policy|training|other`',
    `root_cause_description` STRING COMMENT 'Narrative explanation of the root cause.',
    `severity` STRING COMMENT 'Severity level indicating impact on patient safety or compliance.. Valid values are `critical|high|moderate|low|informational`',
    `standard_finding_description` STRING COMMENT 'Clean boilerplate phrase from attribute description.',
    `standard_finding_status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|closed|in_progress|deferred|reopened`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the finding record.',
    `status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|closed|in_progress|deferred|reopened`',
    `description` STRING COMMENT 'Detailed narrative describing the compliance issue.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient associated with the finding, if applicable.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter linked to the finding.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider responsible for the area where the finding originated.',
    `department_id` BIGINT COMMENT 'Identifier of the organizational department linked to the finding.',
    `location_id` BIGINT COMMENT 'Identifier of the facility or site where the finding was observed.',
    `corrective_action_owner_id` BIGINT COMMENT 'Identifier of the individual accountable for implementing the corrective action.',
    `related_mips_measure_id` BIGINT COMMENT 'Identifier of the MIPS clinician‑level measure associated with the finding.',
    `related_apm_program_id` BIGINT COMMENT 'Identifier of the Alternative Payment Model program tied to the finding.',
    `created_by_user_id` BIGINT COMMENT 'System user who created the finding record.',
    `last_modified_by_user_id` BIGINT COMMENT 'System user who last updated the finding record.',
    CONSTRAINT pk_standard_finding PRIMARY KEY(`standard_finding_id`)
) COMMENT 'Transactional record of compliance findings identified during accreditation surveys, regulatory inspections, CMS Conditions of Participation assessments, state survey agency visits, or internal readiness assessments. Captures standard reference (TJC NPSG, CMS CoP condition, state regulation), finding type (Requirement for Improvement, Immediate Threat to Life, Condition-Level Deficiency, Standard-Level Deficiency), compliance status, evidence of compliance or deficiency, finding description, plan of correction, CMS acceptance status, due date, and resolution status. SSOT for all regulatory and accreditation compliance findings.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`improvement_initiative` (
    `improvement_initiative_id` BIGINT COMMENT 'Unique surrogate key for the quality improvement initiative.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: Improvement initiatives are managed within quality programs. An initiative belongs to one quality program (e.g., a CLABSI reduction initiative under the HAI quality program). This enables program-leve',
    `aim_statement` STRING COMMENT 'Specific aim of the initiative, including target population and expected impact.',
    `baseline_performance` DECIMAL(18,2) COMMENT 'Performance value before the initiative started.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for the initiative.',
    `budget_currency` STRING COMMENT 'Currency of the budget amount (e.g., USD).',
    `closure_date` DATE COMMENT 'Date the initiative was formally closed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the initiative with regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the initiative record was first created.',
    `current_phase` STRING COMMENT 'Current phase of the improvement cycle (Define, Measure, Analyze, Improve, Control).. Valid values are `define|measure|analyze|improve|control`',
    `data_source` STRING COMMENT 'System or repository providing the measure data.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation, charter, or repository for the initiative.',
    `estimated_savings` DECIMAL(18,2) COMMENT 'Projected financial savings resulting from the initiative.',
    `goal_performance` DECIMAL(18,2) COMMENT 'Target performance value the initiative seeks to achieve.',
    `improvement_cycle_number` STRING COMMENT 'Sequential number of the improvement cycle for repeat initiatives.',
    `improvement_initiative_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the initiative.',
    `improvement_initiative_name` STRING COMMENT 'Human‑readable name of the improvement initiative.',
    `improvement_initiative_status` STRING COMMENT 'Lifecycle status of the initiative.. Valid values are `planned|active|completed|on_hold|cancelled`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the initiative is currently active.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the initiative.',
    `lessons_learned` STRING COMMENT 'Key lessons and recommendations derived from the initiative.',
    `measure_actual` DECIMAL(18,2) COMMENT 'Most recent actual value observed for the measure.',
    `measure_code` STRING COMMENT 'Standardized code for the measure (e.g., HEDIS code).',
    `measure_description` STRING COMMENT 'Narrative description of the selected measure.',
    `measure_reporting_period` STRING COMMENT 'Timeframe for which the measure is reported (e.g., Q1 2024).',
    `measure_target` DECIMAL(18,2) COMMENT 'Target value for the measure during the initiative.',
    `measure_type` STRING COMMENT 'Classification of the measure (process, outcome, balancing).. Valid values are `process|outcome|balancing`',
    `methodology` STRING COMMENT 'Methodology used to drive the improvement (e.g., PDSA, Lean, Six Sigma, IHI Model for Improvement).. Valid values are `PDSA|Lean|Six_Sigma|IHI_Model_for_Improvement`',
    `notes` STRING COMMENT 'Free‑form notes captured by the quality team.',
    `outcome_summary` STRING COMMENT 'High‑level summary of results and impact after closure.',
    `owner_team` STRING COMMENT 'Organizational team responsible for executing the initiative.',
    `patient_population_affected` STRING COMMENT 'Estimated number of patients impacted by the initiative.',
    `priority` STRING COMMENT 'Business priority assigned to the initiative.. Valid values are `low|medium|high|critical`',
    `problem_statement` STRING COMMENT 'Clear statement of the problem the initiative aims to address.',
    `regulatory_program` STRING COMMENT 'Regulatory or value‑based program associated with the initiative.. Valid values are `MIPS|APM|HEDIS|CAHPS|VBP`',
    `related_clinical_area` STRING COMMENT 'Clinical domain or service line the initiative targets.',
    `review_outcome` STRING COMMENT 'Result of the latest review (e.g., continue, modify, terminate).',
    `risk_level` STRING COMMENT 'Assessed risk level of the initiative.. Valid values are `low|moderate|high`',
    `savings_currency` STRING COMMENT 'Currency for the estimated savings amount.',
    `sponsor_name` STRING COMMENT 'Name of the executive or leader sponsoring the initiative.',
    `sponsor_role` STRING COMMENT 'Organizational role of the sponsor (e.g., CMO, VP Quality).',
    `stakeholder_count` STRING COMMENT 'Number of distinct stakeholder groups engaged.',
    `start_date` DATE COMMENT 'Date the initiative officially began.',
    `target_completion_date` DATE COMMENT 'Planned date for completing the initiative.',
    `target_measure` STRING COMMENT 'Key performance measure selected for the initiative (e.g., HEDIS measure code).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the initiative record.',
    `name` STRING COMMENT 'Human‑readable name of the improvement initiative.',
    `description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the initiative.',
    `status` STRING COMMENT 'Lifecycle status of the initiative.. Valid values are `planned|active|completed|on_hold|cancelled`',
    CONSTRAINT pk_improvement_initiative PRIMARY KEY(`improvement_initiative_id`)
) COMMENT 'Master entity for formal quality improvement initiatives and projects managed by the quality department. Stores initiative name, improvement methodology (PDSA, Lean, Six Sigma, IHI Model for Improvement), problem statement, aim statement, target measure, baseline performance, goal performance, initiative sponsor, team members, start date, target completion date, current phase, and status. Links to corrective_action for action item tracking. Supports organizational quality strategy, CMS quality improvement requirements, and TJC performance improvement chapter compliance.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`quality_peer_review` (
    `quality_peer_review_id` BIGINT COMMENT 'Unique surrogate key for the peer review record.',
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.psychiatric_assessment. Business justification: Clinical peer review of behavioral health cases examines adequacy of psychiatric assessments (suicide risk screening, involuntary hold decisions). Required for credentialing OPPE/FPPE and malpractice ',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose care is under review.',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the primary provider associated with the case.',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.quality_committee. Business justification: Peer reviews are conducted under the authority of a quality committee. The existing STRING committee column is denormalized. Adding FK normalizes this. Removing committee STRING since quality_comm',
    `reviewer_clinician_id` BIGINT COMMENT 'Unique identifier of the clinician or staff member who performed the review.',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: Peer reviews can be triggered by patient safety events. The case_trigger field is STRING but a proper FK enables direct navigation from peer review to the triggering safety event. Named with triggeri',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter linked to the case.',
    `action_taken` STRING COMMENT 'Action(s) implemented as a result of the review findings.. Valid values are `no_action|education|remediation|disciplinary|monitoring`',
    `care_gap_closure_date` DATE COMMENT 'Date on which the identified care gap was closed.',
    `care_gap_closure_flag` BOOLEAN COMMENT 'Indicates whether a care gap identified in the review has been closed.',
    `case_number` STRING COMMENT 'External business identifier assigned to the peer review case.',
    `case_summary` STRING COMMENT 'Narrative summary of the case under review, including clinical context.',
    `case_trigger` STRING COMMENT 'Event or condition that initiated the peer review (e.g., mortality, complication).. Valid values are `mortality|complication|complaint|focused_review|oppe|fppe`',
    `confidentiality_protection` STRING COMMENT 'Indicates whether peer review confidentiality protections were applied.. Valid values are `protected|unprotected`',
    `department` STRING COMMENT 'Clinical department associated with the case (e.g., cardiology, surgery).',
    `documentation_attached_flag` BOOLEAN COMMENT 'Indicates whether supporting documentation is attached to the review record.',
    `documentation_reference` STRING COMMENT 'Reference (e.g., file path or URL) to attached supporting documents.',
    `educational_opportunity` STRING COMMENT 'Description of any educational need identified during the review.',
    `enrollment_status` STRING COMMENT 'Current status of enrollment in the quality program.. Valid values are `enrolled|not_enrolled|pending`',
    `external_reviewer_flag` BOOLEAN COMMENT 'Indicates whether an external reviewer participated.',
    `follow_up_date` DATE COMMENT 'Target date by which required follow‑up actions should be completed.',
    `follow_up_required` BOOLEAN COMMENT 'Flag indicating if follow‑up actions are required after the review.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the peer review case.. Valid values are `open|closed|in_review|escalated`',
    `measure_score` DECIMAL(18,2) COMMENT 'Score achieved on the associated quality measure.',
    `notes` STRING COMMENT 'Additional free‑text notes captured by the reviewer.',
    `patient_age_at_review` STRING COMMENT 'Age of the patient at the time of the peer review.',
    `patient_gender` STRING COMMENT 'Gender of the patient.. Valid values are `male|female|other|unknown`',
    `program_enrollment` STRING COMMENT 'Indicates enrollment in MIPS, APM, or none.. Valid values are `MIPS|APM|None`',
    `quality_measure_code` STRING COMMENT 'Code of the quality measure (e.g., MIPS measure) associated with the review.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the peer review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the peer review record.',
    `review_duration_minutes` STRING COMMENT 'Length of time spent conducting the peer review.',
    `review_level` STRING COMMENT 'Scope of the review – department level, committee level, or external review.. Valid values are `department|committee|external`',
    `review_outcome` STRING COMMENT 'Determination of care appropriateness resulting from the review.. Valid values are `appropriate|appropriate_with_suggestions|not_appropriate`',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the peer review was conducted.',
    `reviewer_role` STRING COMMENT 'Professional role of the reviewer within the organization.. Valid values are `attending|resident|nurse|admin|quality_staff`',
    `root_cause_analysis` STRING COMMENT 'Narrative of root‑cause findings derived from the review.',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric severity rating (e.g., 0‑10) assigned to the issue identified.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient whose care is under review.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the primary provider associated with the case.',
    `reviewer_id` BIGINT COMMENT 'Unique identifier of the clinician or staff member who performed the review.',
    `committee` STRING COMMENT 'Name of the quality committee that conducted the review, if applicable.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter linked to the case.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_quality_peer_review PRIMARY KEY(`quality_peer_review_id`)
) COMMENT 'Transactional record of formal physician peer review cases conducted by the medical staff quality committee under peer review protection statutes. Captures case trigger (mortality, complication, complaint, focused review, OPPE/FPPE), review level (department, committee, external), case summary, care appropriateness determination (appropriate, appropriate with suggestions, not appropriate), educational opportunity identified, action taken, and confidentiality protections applied. Supports medical staff credentialing, privileging decisions, OPPE (Ongoing Professional Practice Evaluation), and FPPE (Focused Professional Practice Evaluation) requirements.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`population_health_gap` (
    `population_health_gap_id` BIGINT COMMENT 'Unique surrogate key for each care gap record.',
    `care_program_id` BIGINT COMMENT 'Identifier of the population health program (e.g., Healthy Planet) linked to the gap.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: AI-driven population health gap detection requires traceability to the detecting model for FDA SaMD governance, model performance monitoring, and CMS quality reporting auditability. Domain experts exp',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Population health programs prioritize care gap outreach by AI-computed patient risk scores. Linking gap to the specific risk score enables audit of AI-driven prioritization decisions required for valu',
    `clinician_id` BIGINT COMMENT 'National Provider Identifier of the provider responsible for the gap.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure (e.g., HEDIS measure) that defines the gap.',
    `mpi_record_id` BIGINT COMMENT 'Medical Record Number uniquely identifying the patient.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: Population health gaps are identified and managed within quality programs (e.g., HEDIS gap closure programs, VBP initiatives). Linking gaps to their governing quality program enables program-level gap',
    `rpm_enrollment_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_enrollment. Business justification: Value-based care programs close care gaps by enrolling patients in RPM. Tracking which RPM enrollment addresses a specific population health gap is essential for gap closure workflows and VBP performa',
    `sdoh_screening_id` BIGINT COMMENT 'Foreign key linking to quality.sdoh_screening. Business justification: Population health gaps can be identified through SDOH screenings. A gap may be discovered during a specific screening event. This links the gap to its identifying screening for traceability.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the gap.',
    `closure_method` STRING COMMENT 'Method by which the gap was closed.. Valid values are `claim|clinical_documentation|patient_attestation|provider_override`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the gap record was first created in the data warehouse.',
    `delta_tblproperties` STRING COMMENT 'Key-value properties for Delta Lake table configuration.',
    `effective_from` DATE COMMENT 'Date from which the gap is considered active for reporting.',
    `effective_until` DATE COMMENT 'Date until which the gap remains active; null if open-ended.',
    `exclusion_reason` STRING COMMENT 'Reason for excluding the gap from reporting or measurement.',
    `gap_category` STRING COMMENT 'Specific category of the gap such as screening, vaccination, medication adherence, follow-up, or lifestyle.. Valid values are `screening|vaccination|medication|follow_up|lifestyle`',
    `gap_close_date` DATE COMMENT 'Date when the gap was resolved or closed.',
    `gap_open_date` DATE COMMENT 'Date when the care gap was first identified.',
    `gap_status` STRING COMMENT 'Current lifecycle status of the gap.. Valid values are `open|closed|excluded|in_progress`',
    `gap_type` STRING COMMENT 'Classification of the care gap (preventive, chronic disease, HEDIS, clinical, or social determinant).. Valid values are `preventive|chronic|hedis|clinical|social`',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA-mandated retention period for the record.',
    `is_excluded` BOOLEAN COMMENT 'Indicates whether the gap is excluded from reporting.',
    `liquid_clustering` STRING COMMENT 'Specification for Databricks liquid clustering on the table.',
    `notes` STRING COMMENT 'Free-text notes describing context or special considerations for the gap.',
    `outreach_attempts` STRING COMMENT 'Number of outreach attempts made to close the gap.',
    `outreach_last_date` DATE COMMENT 'Date of the most recent outreach attempt.',
    `priority` STRING COMMENT 'Priority level assigned to the gap for action planning.. Valid values are `high|medium|low`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score indicating the clinical risk associated with the gap.',
    `rls_predicate` STRING COMMENT 'RLS predicate expression applied to the table.',
    `scd_type` STRING COMMENT 'Indicates SCD type applied to the table (Type 2 for history).. Valid values are `type2|type1`',
    `source_system` STRING COMMENT 'Source system that generated the gap record (e.g., Epic Healthy Planet).',
    `unity_catalog_tags` STRING COMMENT 'Databricks Unity Catalog tags for governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the gap record.',
    `patient_id` BIGINT COMMENT 'Medical Record Number uniquely identifying the patient.',
    `provider_id` BIGINT COMMENT 'National Provider Identifier of the provider responsible for the gap.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the gap.',
    CONSTRAINT pk_population_health_gap PRIMARY KEY(`population_health_gap_id`)
) COMMENT 'Transactional record of identified care gaps for patients in population health programs managed through Epic Healthy Planet. Captures gap type (preventive care, chronic disease management, HEDIS measure gap), gap status (open, closed, excluded), outreach attempts, closure method (claim, clinical documentation, patient attestation), closure date, and attributed provider. Supports ACO quality reporting and HEDIS gap closure workflows.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`sdoh_screening` (
    `sdoh_screening_id` BIGINT COMMENT 'Unique surrogate key for the SDOH screening record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the physical or virtual location where the screening took place.',
    `community_resource_id` BIGINT COMMENT 'Identifier of the community resource to which the patient was referred.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who performed the screening.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who was screened.',
    `referral_id` BIGINT COMMENT 'Identifier of the referral record linked to this screening.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the screening.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening record was first created in the system.',
    `external_screening_number` STRING COMMENT 'Identifier assigned by an external system or partner for this screening.',
    `follow_up_completed` BOOLEAN COMMENT 'Indicates whether the scheduled follow‑up was completed.',
    `follow_up_date` DATE COMMENT 'Planned date for follow‑up on the referral or intervention.',
    `positive_screen_flag` BOOLEAN COMMENT 'Indicates whether the patient screened positive for the assessed domain.',
    `referral_generated` BOOLEAN COMMENT 'True if a community resource referral was created as a result of the screening.',
    `risk_level` STRING COMMENT 'Overall risk categorization derived from the screening results.. Valid values are `low|moderate|high`',
    `screening_consent_given` BOOLEAN COMMENT 'Indicates whether the patient provided consent for the SDOH screening.',
    `screening_consent_timestamp` TIMESTAMP COMMENT 'Date and time when consent was recorded.',
    `screening_domain` STRING COMMENT 'Social determinant domain assessed during the screening.. Valid values are `food_insecurity|housing_instability|transportation|interpersonal_safety|financial_strain|employment`',
    `screening_method` STRING COMMENT 'Method used to administer the screening.. Valid values are `questionnaire|interview|digital`',
    `screening_notes` STRING COMMENT 'Free‑text notes captured during screening; may contain protected health information.',
    `screening_result` STRING COMMENT 'Narrative summary of the screening outcome.',
    `screening_source` STRING COMMENT 'Origin of the screening data (who supplied the information).. Valid values are `self_report|provider_administered|community_partner`',
    `screening_status` STRING COMMENT 'Current processing status of the screening record.. Valid values are `completed|pending|cancelled|in_progress`',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the screening was performed.',
    `screening_tool` STRING COMMENT 'Screening instrument used to collect SDOH data.. Valid values are `ahc_hrs|prapare|hunger_vital_sign`',
    `severity_score` STRING COMMENT 'Numeric severity rating (e.g., 1‑5) for a positive screen.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the screening record.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient who was screened.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the screening.',
    `performed_by_staff_id` BIGINT COMMENT 'Identifier of the staff member who performed the screening.',
    `screening_location_id` BIGINT COMMENT 'Identifier of the physical or virtual location where the screening took place.',
    CONSTRAINT pk_sdoh_screening PRIMARY KEY(`sdoh_screening_id`)
) COMMENT 'Transactional record of Social Determinants of Health (SDOH) screenings administered to patients as part of population health and quality programs. Captures screening tool used (AHC HRSN, PRAPARE, Hunger Vital Sign), screening date, domain assessed (food insecurity, housing instability, transportation, interpersonal safety, financial strain), positive screen flags, referral generated, and community resource connected. Supports CMS SDOH quality measures and health equity reporting.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`quality_program` (
    `quality_program_id` BIGINT COMMENT 'Unique surrogate key for each quality program record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.BIGINT surrogate key for clean keying',
    `quality_employee_id` BIGINT COMMENT 'FK to workforce.employee.BIGINT surrogate key for clean keying',
    `baseline_definition` STRING COMMENT 'Definition of baseline performance metrics against which improvement is measured.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the quality program record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy statement governing how long program data is retained to meet HIPAA and regulatory requirements.',
    `delta_tblproperties` STRING COMMENT 'Key‑value string of Delta Lake table properties for governance (e.g., quality=high).',
    `effective_from` DATE COMMENT 'Date when the program becomes effective.',
    `effective_until` DATE COMMENT 'Date when the program expires or is terminated (null if open‑ended).',
    `financial_incentive_amount` DECIMAL(18,2) COMMENT 'Maximum monetary incentive available if performance targets are met.',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty if performance falls below minimum thresholds.',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA‑compliant retention period (e.g., 6 years).',
    `participating_facility_count` STRING COMMENT 'Number of facilities enrolled in the program.',
    `payment_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base payment to reflect performance outcomes.',
    `performance_period_end` DATE COMMENT 'End date of the performance measurement window.',
    `performance_period_start` DATE COMMENT 'Start date of the performance measurement window.',
    `program_category` STRING COMMENT 'High‑level grouping of the program purpose.. Valid values are `clinical|operational|financial|patient_experience`',
    `program_code` STRING COMMENT 'External business identifier or code assigned to the quality program (e.g., VBP2023-01).',
    `program_name` STRING COMMENT 'Human‑readable name of the quality program.',
    `program_type` STRING COMMENT 'Category of the program (e.g., pay‑for‑performance, accreditation, improvement, reporting).. Valid values are `pay_for_performance|accreditation|improvement|reporting`',
    `quality_metric_count` STRING COMMENT 'Total number of distinct quality metrics tracked under the program.',
    `quality_program_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and objectives of the program.',
    `quality_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|suspended|closed`',
    `sponsor` STRING COMMENT 'Organization or agency sponsoring the program (e.g., CMS, TJC, NCQA, Internal).',
    `sponsor_type` STRING COMMENT 'Classification of the sponsor entity.. Valid values are `CMS|TJC|NCQA|Internal`',
    `total_performance_score_methodology` STRING COMMENT 'Description of the algorithm or formula used to calculate the total performance score.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the quality program record.',
    `vbp_weights` STRING COMMENT 'JSON string containing weight percentages for VBP domains (clinical outcomes, patient engagement, safety, efficiency, cost reduction).',
    `year` STRING COMMENT 'Fiscal or calendar year the program applies to.',
    `description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and objectives of the program.',
    `program_manager_name` STRING COMMENT 'Full legal name of the individual responsible for program execution.',
    `program_manager_email` STRING COMMENT 'Primary email address of the program manager.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|suspended|closed`',
    CONSTRAINT pk_quality_program PRIMARY KEY(`quality_program_id`)
) COMMENT 'Master entity for the organizations quality program portfolio including CMS Value-Based Purchasing (VBP), MIPS, IQR, OQR, APM, TJC accreditation, NCQA, state-specific, and internal quality programs. Stores program name, program sponsor (CMS, TJC, NCQA, internal), program type (pay-for-performance, accreditation, improvement, reporting), program year, participating facilities, financial incentive or penalty at risk, program manager, and program-specific configuration including VBP domain weights (clinical outcomes, person and community engagement, safety, efficiency and cost reduction), baseline and performance period definitions, total performance score methodology, payment adjustment factor, and MIPS submission requirements. Consolidates all program configuration including VBP program data formerly tracked separately. SSOT for quality program governance and configuration.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique surrogate key for the corrective action record.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual (e.g., provider, manager, quality officer) accountable for executing the action.',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: Corrective actions are often managed within the scope of a formal improvement initiative. A CAPA belongs to one initiative. This enables tracking which CAPAs are part of which QI project.',
    `patient_safety_event_id` BIGINT COMMENT 'Reference to the patient safety event, audit finding, or regulatory deficiency that initiated the corrective action.',
    `root_cause_analysis_id` BIGINT COMMENT 'Identifier linking to the root cause analysis record that triggered this action.',
    `standard_finding_id` BIGINT COMMENT 'Foreign key linking to quality.standard_finding. Business justification: Corrective actions arise from standard findings identified during accreditation surveys or regulatory inspections. A CAPA addresses a specific finding. This complements the existing patient_safety_eve',
    `action_initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the system.',
    `action_number` STRING COMMENT 'Human‑readable identifier assigned to the corrective action (e.g., CAPA‑2023‑001).',
    `action_owner_role` STRING COMMENT 'Job role of the person responsible for the action. [ENUM-REF-CANDIDATE: physician|nurse|quality_manager|clinical_lead|admin|executive|IT|pharmacist — 8 candidates stripped; promote to reference product]',
    `action_type` STRING COMMENT 'Category of the corrective action indicating the domain it addresses.. Valid values are `process|clinical|administrative|safety|regulatory`',
    `actual_hours_spent` DECIMAL(18,2) COMMENT 'Total labor hours recorded for executing the action.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the corrective action (e.g., policies, evidence).',
    `comments` STRING COMMENT 'Free‑text field for additional notes, observations, or remarks.',
    `completion_date` DATE COMMENT 'Date the corrective action was actually completed.',
    `corrective_action_description` STRING COMMENT 'Detailed narrative of the corrective action, including what will be done and why.',
    `corrective_action_status` STRING COMMENT 'Current lifecycle state of the corrective action.. Valid values are `open|in_progress|completed|closed|deferred|cancelled`',
    `cost_center_code` STRING COMMENT 'Internal cost center to which any expenses for the action are charged.',
    `delta_table_properties` STRING COMMENT 'Key‑value string of Delta Lake table properties for this entity (e.g., autoOptimize.optimizeWrite=true).',
    `department` STRING COMMENT 'Organizational department owning the corrective action. [ENUM-REF-CANDIDATE: clinical|nursing|pharmacy|radiology|administration|finance|compliance|research|IT|supply_chain — 10 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'Date by which the corrective action must be completed.',
    `effectiveness_score` STRING COMMENT 'Numeric rating (1‑5) of how effective the action was, as assessed during verification.',
    `effectiveness_verification_method` STRING COMMENT 'Method used to verify that the corrective action achieved its intended outcome.. Valid values are `audit|review|measurement|survey|test|observation`',
    `escalation_level` STRING COMMENT 'Numeric level indicating how many times the action has been escalated.',
    `financial_impact` DECIMAL(18,2) COMMENT 'Estimated monetary impact (cost or savings) associated with the corrective action.',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA retention classification for the record.',
    `is_external` BOOLEAN COMMENT 'Flag indicating whether the corrective action involves an external entity (e.g., vendor, regulator).',
    `location` STRING COMMENT 'Physical location (facility, unit, or site) where the corrective action will be performed.',
    `priority` STRING COMMENT 'Priority assigned to the action based on risk and impact.. Valid values are `low|medium|high|critical`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp of the initial creation of the record (system audit).',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `regulatory_program` STRING COMMENT 'Regulatory program or accreditation body associated with the action. [ENUM-REF-CANDIDATE: CMS|TJC|NCQA|HITRUST|OIG|FDA|State|None — 8 candidates stripped; promote to reference product]',
    `related_quality_metric` STRING COMMENT 'Identifier of the quality metric (e.g., HEDIS, CAHPS) that this action aims to improve.',
    `retention_period_years` STRING COMMENT 'Number of years the corrective action record must be retained to satisfy HIPAA and other regulations.',
    `risk_level` STRING COMMENT 'Overall risk rating combining severity and likelihood.. Valid values are `low|medium|high|critical`',
    `rls_predicate` STRING COMMENT 'Expression defining row‑level security for the corrective action (e.g., department = current_user_department()).',
    `severity` STRING COMMENT 'Severity level of the underlying issue prompting the action.. Valid values are `minor|moderate|major|severe`',
    `target_completion_date` DATE COMMENT 'Planned date for completion, may differ from due_date due to adjustments.',
    `unity_catalog_tags` STRING COMMENT 'Comma‑separated list of Unity Catalog tags applied to the table for governance.',
    `verification_date` DATE COMMENT 'Date the verification activity was performed.',
    `verification_result` STRING COMMENT 'Outcome of the effectiveness verification.. Valid values are `effective|partially_effective|ineffective|not_applicable`',
    `status` STRING COMMENT 'Current lifecycle state of the corrective action.. Valid values are `open|in_progress|completed|closed|deferred|cancelled`',
    `description` STRING COMMENT 'Detailed narrative of the corrective action, including what will be done and why.',
    `root_cause_id` BIGINT COMMENT 'Identifier linking to the root cause analysis record that triggered this action.',
    `originating_event_id` BIGINT COMMENT 'Reference to the patient safety event, audit finding, or regulatory deficiency that initiated the corrective action.',
    `responsible_party_id` BIGINT COMMENT 'Identifier of the individual (e.g., provider, manager, quality officer) accountable for executing the action.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Transactional record of corrective and preventive actions (CAPA) arising from patient safety events, accreditation findings, regulatory deficiencies, peer review cases, and quality improvement initiatives. Captures action description, responsible party, due date, completion date, effectiveness verification method, verification result, and linkage to the originating event or finding. Serves as the unified action tracking entity across all quality workstreams, supporting TJC survey readiness, CMS plan of correction requirements, and organizational accountability.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`program_measure_assignment` (
    `program_measure_assignment_id` BIGINT COMMENT 'Unique surrogate key for each program-measure assignment record.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure being assigned to the program.',
    `quality_program_id` BIGINT COMMENT 'Identifier of the quality program to which the measure is assigned.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the program‑measure assignment.. Valid values are `active|inactive|pending|retired`',
    `assignment_version` STRING COMMENT 'Version identifier for the assignment configuration (e.g., v1.0).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created.',
    `effective_from` DATE COMMENT 'Date when the assignment becomes effective.',
    `effective_until` DATE COMMENT 'Date when the assignment expires or is superseded (null if open‑ended).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the measure is mandatory for the program (true) or optional (false).',
    `measure_category` STRING COMMENT 'High‑level classification of the measure type.. Valid values are `outcome|process|structure|patient_experience`',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the assignment.',
    `reporting_frequency` STRING COMMENT 'How often the measure is reported for the program.. Valid values are `annual|quarterly|monthly|weekly|daily`',
    `retention_period_years` STRING COMMENT 'Number of years the assignment record must be retained to satisfy HIPAA and regulatory policies.',
    `threshold_operator` STRING COMMENT 'Comparison operator applied to the threshold value (e.g., >=).. Valid values are `>=|<=|=|>|<`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric performance threshold that must be met or exceeded for the measure.',
    `updated_by` STRING COMMENT 'User identifier who last modified the assignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `weight` DECIMAL(18,2) COMMENT 'Relative weight of the measure within the programs scoring model (e.g., 0.2500 = 25%).',
    `program_id` BIGINT COMMENT 'Identifier of the quality program to which the measure is assigned.',
    `created_by` STRING COMMENT 'User identifier (e.g., employee username) who created the assignment.',
    CONSTRAINT pk_program_measure_assignment PRIMARY KEY(`program_measure_assignment_id`)
) COMMENT 'This association product represents the assignment of quality measures to quality programs. It captures the operational configuration of which measures are included in which programs, along with program-specific measure parameters such as weights, thresholds, and reporting requirements. Each record links one quality program to one measure with attributes that exist only in the context of this program-measure relationship. This is the SSOT for program measure configuration and is actively managed by quality teams during program setup and annual reconfiguration.. Existence Justification: Quality program measure assignment is a core operational business process in healthcare quality management. Quality teams actively configure which measures are included in which programs during annual program setup and reconfiguration cycles. A single quality measure (e.g., MORT-30-AMI) is included in multiple programs (VBP, IQR, internal quality program) with different weights, thresholds, and reporting requirements per program. Conversely, a single quality program (e.g., VBP 2024) includes dozens of measures across multiple domains. This is not a reference lookup—it is a managed relationship with program-specific configuration data.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`initiative_measure_target` (
    `initiative_measure_target_id` BIGINT COMMENT 'System-generated unique identifier for each initiative-measure target record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member responsible for managing this target.',
    `improvement_initiative_id` BIGINT COMMENT 'Identifier of the quality improvement initiative linked to this target.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure that is being targeted.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Performance value recorded before the initiative began, used as a reference point.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence (0-100) associated with the current performance measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the target record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'Most recent measured performance value for the measure within the initiative context.',
    `data_source` STRING COMMENT 'Origin of the performance data used for baseline, current, and target values.. Valid values are `EHR|Claims|Survey|Manual|External`',
    `effective_from` DATE COMMENT 'Date when the target values become operational for the initiative.',
    `effective_until` DATE COMMENT 'Date when the target values cease to be applicable (null if open-ended).',
    `initiative_measure_target_status` STRING COMMENT 'Current lifecycle status of the initiative-measure target record.. Valid values are `active|inactive|completed|paused|archived`',
    `measurement_period_end` DATE COMMENT 'Last date of the reporting period for which the performance values apply.',
    `measurement_period_start` DATE COMMENT 'First date of the reporting period for which the performance values apply.',
    `notes` STRING COMMENT 'Free-text comments or rationale related to the target configuration.',
    `risk_level` STRING COMMENT 'Risk categorization indicating the importance of meeting the target.. Valid values are `low|medium|high|critical`',
    `target_type` STRING COMMENT 'Classification of the target metric (e.g., numeric value, percentage, rate, binary flag).. Valid values are `numeric|percentage|rate|binary`',
    `target_value` DECIMAL(18,2) COMMENT 'Goal performance value the initiative aims to achieve for the measure.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the performance values (e.g., percent, days, count).. Valid values are `%|rate|days|points|ratio|count`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the target record.',
    `initiative_id` BIGINT COMMENT 'Identifier of the quality improvement initiative linked to this target.',
    `status` STRING COMMENT 'Current lifecycle status of the initiative-measure target record.. Valid values are `active|inactive|completed|paused|archived`',
    `owner_id` BIGINT COMMENT 'Identifier of the staff member responsible for managing this target.',
    CONSTRAINT pk_initiative_measure_target PRIMARY KEY(`initiative_measure_target_id`)
) COMMENT 'This association product represents the targeting relationship between improvement_initiative and measure. It captures the specific performance targets, baselines, and tracking data for each quality measure that an improvement initiative aims to impact. Each record links one improvement_initiative to one measure with baseline performance, goal targets, current performance values, and measurement periods that exist only in the context of this initiative-measure relationship. This is a core operational entity in quality improvement methodology - quality teams actively create, monitor, and update these targets throughout the initiative lifecycle.. Existence Justification: In healthcare quality improvement operations, initiatives routinely target multiple quality measures simultaneously (e.g., a sepsis initiative may target mortality rate, time-to-antibiotics, and lactate measurement compliance), and quality measures are targeted by multiple improvement initiatives over time (e.g., hand hygiene compliance may be targeted by infection prevention initiatives, surgical site infection initiatives, and CAUTI reduction initiatives). Quality teams actively create, monitor, and update initiative-measure targets as a core operational activity, tracking baseline performance, goal targets, and current performance for each measure within each initiative.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`contract_initiative` (
    `contract_initiative_id` BIGINT COMMENT 'System-generated unique identifier for the contract-initiative linkage record.',
    `improvement_initiative_id` BIGINT COMMENT 'Identifier of the quality improvement initiative associated with the contract.',
    `payer_contract_id` BIGINT COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the initiative met the contractual compliance criteria for the reporting period.',
    `contract_initiative_status` STRING COMMENT 'Current lifecycle state of the contract‑initiative relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the linkage record was first created in the system.',
    `data_source` STRING COMMENT 'System or process that provides the performance data (e.g., Healthy Planet, EHR).',
    `effective_end_date` DATE COMMENT 'Date when the contractual linkage expires or is terminated (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the contractual linkage becomes active.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Financial reward payable when the target is met.',
    `incentive_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the incentive amount.',
    `last_reported_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent performance report submitted for this linkage.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or contractual nuances.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty applied if the target is not achieved.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the penalty amount.',
    `performance_metric_code` STRING COMMENT 'Standardized code (e.g., HEDIS, CMS) representing the quality measure tied to the initiative.',
    `performance_metric_description` STRING COMMENT 'Human‑readable description of the quality metric.',
    `reporting_frequency` STRING COMMENT 'How often performance data must be reported to the payer.. Valid values are `monthly|quarterly|annually|ad_hoc`',
    `target_unit` STRING COMMENT 'Unit of measure for the target value (e.g., %, rate, count).',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric performance target that must be achieved to satisfy the contract clause.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the linkage record.',
    `initiative_id` BIGINT COMMENT 'Identifier of the quality improvement initiative associated with the contract.',
    `contract_id` BIGINT COMMENT 'Identifier of the payer contract that mandates or incentivizes the initiative.',
    `status` STRING COMMENT 'Current lifecycle state of the contract‑initiative relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    CONSTRAINT pk_contract_initiative PRIMARY KEY(`contract_initiative_id`)
) COMMENT 'This association product represents the contractual linkage between quality improvement initiatives and payer contracts that require or incentivize those initiatives. It captures contract-specific performance targets, financial incentives/penalties, and reporting obligations that exist only when a specific initiative is tied to a specific payer contracts value-based care or pay-for-performance provisions.. Existence Justification: In healthcare value-based care arrangements, a single quality improvement initiative (e.g., reducing hospital-acquired infections) can be contractually required or incentivized by multiple payer contracts simultaneously, each with different performance targets, incentive amounts, and reporting requirements. Conversely, a single payer contract (especially comprehensive VBC or P4P contracts) typically requires or incentivizes multiple quality improvement initiatives across different clinical domains. This is an operational relationship actively managed by contract administrators and quality program managers.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`quality_program_participation` (
    `quality_program_participation_id` BIGINT COMMENT 'System-generated unique identifier for each quality program participation record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan participating in the quality program.',
    `quality_program_id` BIGINT COMMENT 'Identifier of the quality program to which the health plan is enrolled.',
    `classification` STRING COMMENT 'Category of the quality program (e.g., quality program, clinical quality, patient safety).. Valid values are `quality_program|clinical_quality|patient_safety`',
    `compliance_status` STRING COMMENT 'Indicates whether the health plan is meeting the programs compliance requirements.. Valid values are `compliant|non_compliant|under_review`',
    `contract_terms` STRING COMMENT 'Free‑text field capturing key contractual obligations, penalties, and special conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the participation record was first created in the system.',
    `data_submission_method` STRING COMMENT 'Preferred method for the health plan to submit required data.. Valid values are `electronic|paper|api`',
    `effective_from` DATE COMMENT 'Date when the participation agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the participation agreement ends or is scheduled to terminate (null for open‑ended).',
    `last_reported_date` DATE COMMENT 'Date of the most recent performance report submitted by the health plan.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the participation agreement.',
    `notes` STRING COMMENT 'Additional remarks or comments about the participation relationship.',
    `participation_number` STRING COMMENT 'External business identifier or contract number for the participation agreement.',
    `participation_type` STRING COMMENT 'Indicates whether the health plans enrollment is mandatory or voluntary.. Valid values are `mandatory|voluntary`',
    `performance_score` DECIMAL(18,2) COMMENT 'Numeric score representing the health plans performance within the program (e.g., star rating).',
    `quality_program_participation_status` STRING COMMENT 'Current lifecycle status of the participation agreement.. Valid values are `active|inactive|terminated|pending`',
    `reporting_frequency` STRING COMMENT 'How often the health plan must submit performance data to the quality program.. Valid values are `monthly|quarterly|annually`',
    `retention_period` STRING COMMENT 'HIPAA‑compliant data retention period for the participation record (e.g., "7 years").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the participation record.',
    `status` STRING COMMENT 'Current lifecycle status of the participation agreement.. Valid values are `active|inactive|terminated|pending`',
    CONSTRAINT pk_quality_program_participation PRIMARY KEY(`quality_program_participation_id`)
) COMMENT 'This association product represents the participation contract between quality_program and health_plan. It captures the formal enrollment of a health plan in a quality program, including plan-specific performance tracking, reporting requirements, and participation lifecycle management. Each record links one quality_program to one health_plan with attributes that exist only in the context of this participation relationship.. Existence Justification: In healthcare operations, health plans routinely participate in multiple quality programs simultaneously (e.g., a Medicare Advantage plan participates in Star Ratings, VBP, and HEDIS concurrently), and each quality program has multiple participating health plans across different payers and plan types. The participation relationship is actively managed by quality teams who track plan-specific performance scores, reporting compliance, submission methods, and participation lifecycle (enrollment, active monitoring, termination). This is not an analytical correlation but an operational business process where participation records are created, updated with performance data, and terminated based on program requirements and plan eligibility.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`program_study_participation` (
    `program_study_participation_id` BIGINT COMMENT 'System‑generated unique identifier for each program‑study participation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the approval review.',
    `quality_program_id` BIGINT COMMENT 'Identifier of the quality program (e.g., Hospital VBP, MIPS) linked to the research study.',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study that may affect the quality programs measures.',
    `approval_status` STRING COMMENT 'Current approval state of the participation relationship.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the participation was approved or rejected.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the participation record was first created in the system.',
    `data_source` STRING COMMENT 'System or process that supplied the participation data.. Valid values are `Healthy Planet|EHR|Research Registry|Other`',
    `effective_from` DATE COMMENT 'Date on which the participation relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the participation relationship ends or is superseded (null for open‑ended).',
    `exclusion_flag` BOOLEAN COMMENT 'True if the study is excluded from the programs measure calculations.',
    `exclusion_reason` STRING COMMENT 'Reason why the study is excluded from the programs reporting.. Valid values are `clinical|operational|regulatory|other`',
    `is_mandatory` BOOLEAN COMMENT 'True if participation in the study is mandatory for the programs compliance.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the participation relationship.',
    `participation_status` STRING COMMENT 'Current lifecycle status of the program‑study participation.. Valid values are `active|inactive|completed|withdrawn`',
    `reporting_adjustment_description` STRING COMMENT 'Narrative explaining the adjustment factor applied for this participation.',
    `reporting_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to program metrics to account for study‑specific adjustments.',
    `stratification_category` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `age|diagnosis|risk|geography|payer|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the participation record.',
    `program_id` BIGINT COMMENT 'Identifier of the quality program (e.g., Hospital VBP, MIPS) linked to the research study.',
    `study_id` BIGINT COMMENT 'Identifier of the research study that may affect the quality programs measures.',
    `reviewer_id` BIGINT COMMENT 'Identifier of the user who performed the approval review.',
    `created_by` STRING COMMENT 'User identifier (e.g., employee ID) of the person who created the record.',
    CONSTRAINT pk_program_study_participation PRIMARY KEY(`program_study_participation_id`)
) COMMENT 'This association product represents the participation relationship between quality programs and research studies. It captures the operational tracking required when research studies impact quality program measure calculation, exclusion logic, and public reporting. Each record links one quality program to one research study with CMS-mandated tracking attributes that exist only in the context of this regulatory relationship.. Existence Justification: In healthcare quality operations, a single quality program (e.g., Hospital VBP) must track multiple research studies simultaneously because each study may affect different measures or patient populations within that program. Conversely, a single research study (e.g., an oncology trial) simultaneously impacts multiple quality programs (MIPS, OCM, Hospital VBP) because the same enrolled patients appear in multiple program denominators. CMS requires bidirectional tracking of these relationships with specific exclusion rules, stratification requirements, and reporting adjustments that vary by program-study combination.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` (
    `measure_budget_allocation_id` BIGINT COMMENT 'System-generated unique identifier for each measure‑budget allocation record.',
    `budget_line_id` BIGINT COMMENT 'Identifier of the budget line (cost center) to which the measure is funded.',
    `measure_id` BIGINT COMMENT 'Identifier of the quality measure that receives the budget allocation.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Monetary amount (in USD) allocated to the quality measure for the fiscal year.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Portion of the budget line expressed as a percent of total line amount allocated to the measure.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the allocation record.. Valid values are `active|inactive|pending|closed`',
    `allocation_type` STRING COMMENT 'Classification of the allocation purpose.. Valid values are `operational|capital|grant`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the allocation was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the user who approved the allocation.',
    `compliance_flag` BOOLEAN COMMENT 'True if the allocation complies with internal policy and external regulations.',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center associated with the budget line.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the allocation record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the allocation becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the allocation expires (null for open‑ended).',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year for which the allocation applies (e.g., 2024).',
    `improvement_cost` DECIMAL(18,2) COMMENT 'Estimated cost required to achieve the performance target for the measure.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Potential financial incentive earned if the measure meets or exceeds its target.',
    `is_overridden` BOOLEAN COMMENT 'Indicates whether the allocation amount has been manually overridden.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the allocations performance.',
    `notes` STRING COMMENT 'Free‑form comments or justification for the allocation.',
    `overridden_amount` DECIMAL(18,2) COMMENT 'Manually adjusted allocation amount when is_overridden is true.',
    `performance_target` STRING COMMENT 'Numeric or descriptive target the measure must meet (e.g., "90% compliance").',
    `review_cycle` STRING COMMENT 'Frequency at which the allocation is reviewed.. Valid values are `annual|semiannual|quarterly`',
    `risk_level` STRING COMMENT 'Risk rating associated with the allocation (e.g., financial or operational risk).. Valid values are `low|medium|high`',
    `source_system` STRING COMMENT 'Originating system that supplied the allocation data.. Valid values are `Epic|Cerner|SAP|Manual`',
    `updated_by` BIGINT COMMENT 'Identifier of the user who last modified the allocation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the allocation record.',
    `budget_line_code` STRING COMMENT 'Business code used to reference the specific budget line.',
    `measure_code` STRING COMMENT 'Standardized code for the quality measure (e.g., HEDIS‑DM01).',
    `created_by` BIGINT COMMENT 'Identifier of the user who created the allocation record.',
    CONSTRAINT pk_measure_budget_allocation PRIMARY KEY(`measure_budget_allocation_id`)
) COMMENT 'This association product represents the financial allocation relationship between quality measures and budget lines. It captures the budgeted funding, expected performance targets, and financial returns associated with implementing and tracking specific quality measures. Each record links one quality measure to one budget line with fiscal year context, allocation percentages, improvement costs, and performance incentive amounts that exist only in the context of this funding relationship.. Existence Justification: In healthcare quality program management, a single quality measure (e.g., HEDIS Diabetes Care) is typically funded through multiple budget lines across different cost centers (quality department operations, clinical staff training, IT system enhancements, data abstraction services). Conversely, a single budget line (e.g., Quality Improvement Initiatives - Cardiology) often funds multiple related quality measures within that clinical domain. The relationship itself carries fiscal-year-specific data including allocation percentages, improvement costs, performance targets, and expected incentive returns that belong to neither the measure definition nor the budget line alone.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`quality_committee` (
    `quality_committee_id` BIGINT COMMENT 'System-generated unique identifier for the quality committee.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.BIGINT surrogate key for clean keying',
    `quality_employee_id` BIGINT COMMENT 'FK to workforce.employee.BIGINT surrogate key for clean keying',
    `apm_enrollment` BOOLEAN COMMENT 'True if the committee manages Alternative Payment Model program enrollment.',
    `audit_log_reference` BIGINT COMMENT 'Identifier linking to the immutable audit log of committee actions.',
    `care_gap_closure_enabled` BOOLEAN COMMENT 'Indicates responsibility for care‑gap identification and closure initiatives.',
    `charter_document` STRING COMMENT 'Reference to the stored charter or governing document for the committee.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the committee record was first created in the system.',
    `data_retention_years` STRING COMMENT 'Number of years the committees records must be retained per HIPAA and internal policy.',
    `effective_end_date` DATE COMMENT 'Date when the committee was formally disbanded or retired; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the committee officially became active.',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA‑specific retention requirements for committee records.',
    `is_cross_department` BOOLEAN COMMENT 'True if the committee includes members from multiple organizational departments.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal committee performance review.',
    `last_review_outcome` STRING COMMENT 'Result of the most recent committee review.. Valid values are `approved|needs_action|rejected`',
    `meeting_frequency` STRING COMMENT 'Regular cadence at which the committee convenes.. Valid values are `monthly|quarterly|annually|ad_hoc`',
    `member_count` STRING COMMENT 'Total count of individuals serving on the committee.',
    `mips_reporting` BOOLEAN COMMENT 'Indicates whether the committee is responsible for MIPS clinician‑level reporting.',
    `next_meeting_date` DATE COMMENT 'Scheduled date for the upcoming committee meeting.',
    `purpose` STRING COMMENT 'Brief statement of the committees mission and objectives.',
    `quality_committee_code` STRING COMMENT 'External business code or abbreviation used to reference the committee.',
    `quality_committee_description` STRING COMMENT 'Detailed narrative describing the committees scope, responsibilities, and authority.',
    `quality_committee_name` STRING COMMENT 'Human‑readable name of the quality committee.',
    `quality_committee_status` STRING COMMENT 'Current lifecycle status of the committee.. Valid values are `active|inactive|pending|disbanded`',
    `quality_committee_type` TIMESTAMP COMMENT 'Categorizes the committee by its functional area.',
    `quality_measure_scope` STRING COMMENT 'Scope of quality measures overseen by the committee.. Valid values are `patient|provider|facility|system`',
    `reporting_line` STRING COMMENT 'Organizational level to which the committee reports.. Valid values are `executive|board|department_head|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the committee record.',
    `name` STRING COMMENT 'Human‑readable name of the quality committee.',
    `code` STRING COMMENT 'External business code or abbreviation used to reference the committee.',
    `type` STRING COMMENT 'Categorizes the committee by its functional area.. Valid values are `clinical|operational|quality|research|compliance`',
    `status` STRING COMMENT 'Current lifecycle status of the committee.. Valid values are `active|inactive|pending|disbanded`',
    `description` STRING COMMENT 'Detailed narrative describing the committees scope, responsibilities, and authority.',
    `chairperson_name` STRING COMMENT 'Legal full name of the committee chairperson.',
    `chairperson_email` STRING COMMENT 'Primary email address for the committee chairperson.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `chairperson_phone` STRING COMMENT 'Contact telephone number for the committee chairperson.',
    `audit_log_id` BIGINT COMMENT 'Identifier linking to the immutable audit log of committee actions.',
    CONSTRAINT pk_quality_committee PRIMARY KEY(`quality_committee_id`)
) COMMENT 'Master reference table for committee. Referenced by committee_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` (
    `mips_clinician_measure_id` BIGINT COMMENT 'BIGINT',
    `care_site_id` BIGINT COMMENT 'BIGINT',
    `clinician_id` BIGINT COMMENT 'BIGINT',
    `measure_id` BIGINT COMMENT 'BIGINT',
    `quality_program_id` BIGINT COMMENT 'FK to quality.quality_program. The MIPS program context for this clinician measure result.',
    `benchmark_decile` STRING COMMENT 'INT',
    `created_dt` TIMESTAMP COMMENT 'description',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp for audit trail.',
    `denominator_count` STRING COMMENT 'INT',
    `exception_count` STRING COMMENT 'description',
    `exclusion_count` STRING COMMENT 'INT',
    `final_score` DECIMAL(18,2) COMMENT 'description',
    `is_high_priority` BOOLEAN COMMENT 'Indicates whether this is a high-priority measure eligible for bonus points under MIPS.',
    `is_outcome_measure` BOOLEAN COMMENT 'Indicates whether this is an outcome measure eligible for additional MIPS bonus points.',
    `measure_category` STRING COMMENT 'MIPS performance category: QUALITY, PROMOTING_INTEROPERABILITY, IMPROVEMENT_ACTIVITIES, COST.',
    `mips_category_cd` STRING COMMENT 'description',
    `modified_dt` TIMESTAMP COMMENT 'description',
    `npi` STRING COMMENT 'National Provider Identifier of the clinician. Required for CMS MIPS submission.',
    `numerator_count` STRING COMMENT 'INT',
    `payment_adjustment_pct` DECIMAL(18,2) COMMENT 'description',
    `performance_rate` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `performance_year` STRING COMMENT 'INT',
    `points_earned` DECIMAL(18,2) COMMENT 'DECIMAL(5,2)',
    `reporting_period_end_date` DATE COMMENT 'End date of the MIPS reporting period for this clinician-measure record.',
    `reporting_period_end_dt` DATE COMMENT 'description',
    `reporting_period_start_date` DATE COMMENT 'Start date of the MIPS reporting period for this clinician-measure record.',
    `reporting_period_start_dt` DATE COMMENT 'description',
    `status_cd` STRING COMMENT 'description',
    `submission_date` DATE COMMENT 'Date this clinician-measure record was submitted to CMS.',
    `submission_method_cd` STRING COMMENT 'description',
    `submission_status` STRING COMMENT 'Status of CMS submission for this clinician-measure record: PENDING, SUBMITTED, ACCEPTED, REJECTED.',
    `submission_type` STRING COMMENT 'MIPS submission mechanism: REGISTRY, EHR, CLAIMS, CMS_WEB_INTERFACE, QCDR.',
    `tin` STRING COMMENT 'Tax Identification Number of the practice. Required for CMS MIPS group submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last-updated timestamp for audit trail.',
    CONSTRAINT pk_mips_clinician_measure PRIMARY KEY(`mips_clinician_measure_id`)
) COMMENT 'MIPS clinician-level quality measure reporting table. Stores individual clinician performance against each reported MIPS quality measure, supporting CMS QPP submission, FPPE/OPPE workflows, and value-based contract analytics. Required for VREQ-010 quality domain expansion.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` (
    `apm_program_enrollment_id` BIGINT COMMENT 'BIGINT',
    `facility_organization_id` BIGINT COMMENT 'description',
    `apm_facility_organization_id` BIGINT COMMENT 'STRING',
    `care_site_id` BIGINT COMMENT 'BIGINT',
    `clinician_id` BIGINT COMMENT 'BIGINT',
    `insurance_accountable_care_organization_id` BIGINT COMMENT 'description',
    `org_provider_id` BIGINT COMMENT 'FK to provider.org_provider. The organization participating in the APM.',
    `payer_id` BIGINT COMMENT 'FK to insurance.payer. The payer sponsoring the APM program.',
    `quality_program_id` BIGINT COMMENT 'FK to quality.quality_program. The APM program being enrolled in.',
    `apm_program_code` STRING COMMENT 'description',
    `cms_certification_number` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `created_dt` TIMESTAMP COMMENT 'description',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp for audit trail.',
    `enrollment_end_date` DATE COMMENT 'DATE',
    `enrollment_end_dt` DATE COMMENT 'description',
    `enrollment_start_date` DATE COMMENT 'DATE',
    `enrollment_start_dt` DATE COMMENT 'description',
    `enrollment_status` STRING COMMENT 'Current enrollment status: ACTIVE, TERMINATED, PENDING, SUSPENDED.',
    `entity_type_code` STRING COMMENT 'description',
    `modified_dt` TIMESTAMP COMMENT 'description',
    `partial_qualifying_participant_flag` BOOLEAN COMMENT 'description',
    `participation_track_cd` STRING COMMENT 'description',
    `participation_type` STRING COMMENT 'Type of APM participation: QUALIFYING_APM_PARTICIPANT, PARTIAL_QP, NON_QP.',
    `participation_year` STRING COMMENT 'description',
    `payment_incentive_amount` DECIMAL(18,2) COMMENT 'APM incentive payment amount earned for this enrollment period.',
    `performance_year` STRING COMMENT 'INT',
    `program_type_cd` STRING COMMENT 'description',
    `qp_threshold_met` BOOLEAN COMMENT 'Indicates whether the clinician met the Qualifying APM Participant threshold for MIPS exclusion.',
    `qualifying_participant_flag` BOOLEAN COMMENT 'description',
    `quality_threshold_score` DECIMAL(18,2) COMMENT 'description',
    `risk_level_cd` STRING COMMENT 'description',
    `shared_loss_rate_pct` DECIMAL(18,2) COMMENT 'description',
    `shared_savings_rate_pct` DECIMAL(18,2) COMMENT 'description',
    `status_cd` STRING COMMENT 'description',
    `status_code` STRING COMMENT 'description',
    `threshold_score` DECIMAL(18,2) COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last-updated timestamp for audit trail.',
    `apm_entity_id` STRING COMMENT 'CMS-assigned APM Entity identifier for the participating organization.',
    CONSTRAINT pk_apm_program_enrollment PRIMARY KEY(`apm_program_enrollment_id`)
) COMMENT 'APM (Alternative Payment Model) program enrollment table. Tracks clinician and organization participation in CMS APM programs including MSSP, PCF, DCE, BPCI-Advanced, and Enhanced Oncology Model. Supports QPP reporting, QP threshold determination, and value-based contract analytics. Required for VREQ-010 quality domain expansion.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`care_gap_closure` (
    `care_gap_closure_id` BIGINT COMMENT 'BIGINT',
    `care_mpi_record_id` BIGINT COMMENT 'description',
    `claim_id` BIGINT COMMENT 'FK to claim.claim. The claim that evidences closure of the care gap.',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'description',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: CMS oncology quality measures (e.g., biomarker testing) require evidence of genomic testing for gap closure. When a care gap for recommended genomic testing is closed, the closure must reference the s',
    `hedis_measure_id` BIGINT COMMENT 'description',
    `measure_id` BIGINT COMMENT 'BIGINT',
    `mpi_record_id` BIGINT COMMENT 'BIGINT',
    `population_health_gap_id` BIGINT COMMENT 'FK to quality.population_health_gap. The care gap being closed.',
    `primary_care_assigned_clinician_id` BIGINT COMMENT 'description',
    `primary_care_closing_visit_id` BIGINT COMMENT 'description',
    `quality_program_id` BIGINT COMMENT 'description',
    `rpm_enrollment_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_enrollment. Business justification: Care gap closure often results from RPM interventions (e.g., sustained BP control via home monitoring). Linking closure to the RPM enrollment enables attribution of quality outcomes to digital health ',
    `rpm_reading_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_reading. Business justification: A specific RPM reading (e.g., HbA1c-equivalent glucose trend, BP reading) serves as clinical evidence that a quality measure numerator criterion is met, closing the care gap. Required for supplemental',
    `tertiary_care_closure_clinician_id` BIGINT COMMENT 'description',
    `tertiary_care_visit_id` BIGINT COMMENT 'FK to encounter.visit. The encounter during which the care gap was closed.',
    `therapy_session_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.therapy_session. Business justification: HEDIS FUH/FUM measures require follow-up after mental health hospitalization. A therapy session serves as closure evidence for behavioral health care gaps, tracked for VBP performance reporting.',
    `vbp_program_id` BIGINT COMMENT 'description',
    `barrier_reason_cd` STRING COMMENT 'description',
    `closure_date` DATE COMMENT 'Date the care gap was closed or the qualifying service was performed.',
    `closure_method` STRING COMMENT 'Method by which the gap was closed: CLAIM, SUPPLEMENTAL_DATA, MEDICAL_RECORD, PATIENT_REPORTED.',
    `closure_method_cd` STRING COMMENT 'description',
    `closure_method_code` STRING COMMENT 'description',
    `closure_status` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `created_at` TIMESTAMP COMMENT 'description',
    `created_dt` TIMESTAMP COMMENT 'description',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp for audit trail.',
    `evidence_code` STRING COMMENT 'Specific code value that evidences gap closure (CPT, LOINC, SNOMED, or ICD-10 code).',
    `evidence_type` STRING COMMENT 'Type of evidence supporting gap closure: CPT_CODE, LOINC, SNOMED, ICD10, LAB_RESULT.',
    `exclusion_reason_code` STRING COMMENT 'description',
    `gap_closed_date` DATE COMMENT 'description',
    `gap_closed_dt` DATE COMMENT 'description',
    `gap_identified_date` DATE COMMENT 'description',
    `gap_identified_dt` DATE COMMENT 'description',
    `gap_status_cd` STRING COMMENT 'description',
    `gap_status_code` STRING COMMENT 'description',
    `last_outreach_date` DATE COMMENT 'description',
    `last_outreach_dt` DATE COMMENT 'description',
    `measurement_year` STRING COMMENT 'description',
    `modified_dt` TIMESTAMP COMMENT 'description',
    `outreach_attempt_count` STRING COMMENT 'INT',
    `patient_declined_flag` BOOLEAN COMMENT 'description',
    `performance_year` STRING COMMENT 'description',
    `supplemental_data_source_cd` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last-updated timestamp for audit trail.',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician. The clinician who performed the service closing the gap.',
    `visit_id` BIGINT COMMENT 'FK to encounter.visit. The encounter during which the care gap was closed.',
    CONSTRAINT pk_care_gap_closure PRIMARY KEY(`care_gap_closure_id`)
) COMMENT 'Care gap closure tracking table. Records the closure of individual patient care gaps identified in quality.population_health_gap, capturing the method, evidence, and timing of closure. Supports HEDIS supplemental data submission, value-based contract reporting, and population health outreach analytics. Required for VREQ-010 quality domain expansion.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` (
    `mips_clinician_measure_report_id` BIGINT COMMENT 'description',
    `clinician_id` BIGINT COMMENT 'description',
    `measure_id` BIGINT COMMENT 'description',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: MIPS clinician measure reports are generated within the context of a quality program. Adding this FK ensures the report table is connected to the quality program framework and enables program-level re',
    `benchmark_decile` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `denominator_count` STRING COMMENT 'description',
    `exclusion_count` STRING COMMENT 'description',
    `final_score` DECIMAL(18,2) COMMENT 'description',
    `measure_score` DECIMAL(18,2) COMMENT 'description',
    `mips_category_code` STRING COMMENT 'description',
    `numerator_count` STRING COMMENT 'description',
    `performance_rate` DECIMAL(18,2) COMMENT 'description',
    `reporting_period_end_date` DATE COMMENT 'description',
    `reporting_period_start_date` DATE COMMENT 'description',
    `reporting_year` STRING COMMENT 'description',
    `status_code` STRING COMMENT 'description',
    `submission_method_code` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_mips_clinician_measure_report PRIMARY KEY(`mips_clinician_measure_report_id`)
) COMMENT 'Stores MIPS clinician-level quality measure reporting data including performance rates, benchmarks, and scoring for individual clinicians under the Merit-based Incentive Payment System';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`mips_reporting` (
    `mips_reporting_id` BIGINT COMMENT 'description',
    `care_site_id` BIGINT COMMENT 'description',
    `clinician_id` BIGINT COMMENT 'description',
    `facility_organization_id` BIGINT COMMENT 'description',
    `measure_id` BIGINT COMMENT 'description',
    `quality_program_id` BIGINT COMMENT 'description',
    `benchmark_decile` STRING COMMENT 'description',
    `category_code` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `denominator_count` STRING COMMENT 'description',
    `exception_count` STRING COMMENT 'description',
    `exceptional_performance_flag` BOOLEAN COMMENT 'description',
    `exclusion_count` STRING COMMENT 'description',
    `final_score` DECIMAL(18,2) COMMENT 'description',
    `npi` STRING COMMENT 'description',
    `numerator_count` STRING COMMENT 'description',
    `payment_adjustment_pct` DECIMAL(18,2) COMMENT 'description',
    `performance_rate` DECIMAL(18,2) COMMENT 'description',
    `performance_year` STRING COMMENT 'description',
    `points_available` DECIMAL(18,2) COMMENT 'description',
    `points_earned` DECIMAL(18,2) COMMENT 'description',
    `reporting_period_end_date` DATE COMMENT 'description',
    `reporting_period_start_date` DATE COMMENT 'description',
    `status_code` STRING COMMENT 'description',
    `submission_date` DATE COMMENT 'description',
    `submission_method_code` STRING COMMENT 'description',
    `tin` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_mips_reporting PRIMARY KEY(`mips_reporting_id`)
) COMMENT 'MIPS clinician-level measure reporting for quality domain expansion per VREQ-010';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`program_measure_alignment` (
    `program_measure_alignment_id` BIGINT COMMENT 'System-generated unique identifier for the program-measure alignment record.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to the quality measure being tracked within the RPM program',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to the RPM program that monitors this quality measure',
    `created_timestamp` TIMESTAMP COMMENT 'Date-time when this alignment record was first created.',
    `effective_from` DATE COMMENT 'Date when this measure alignment becomes active within the RPM program.',
    `effective_until` DATE COMMENT 'Date when this measure alignment ends within the RPM program. Nullable for open-ended alignments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date-time of the most recent update to this alignment record.',
    `measure_weight` DECIMAL(18,2) COMMENT 'Relative weight assigned to this measure within the RPM program for VBP composite scoring. Values between 0 and 1, summing to 1 across all measures in a program.',
    `program_measure_alignment_status` STRING COMMENT 'Current lifecycle status of this alignment (active, suspended, retired).',
    `reporting_frequency` STRING COMMENT 'How often this measure is reported within the context of this RPM program (e.g., monthly, quarterly, annually). May differ from the measures global reporting frequency.',
    `target_threshold` STRING COMMENT 'Program-specific performance target for this measure, which may differ from the measures global benchmark threshold (e.g., 85% vs global 90%).',
    CONSTRAINT pk_program_measure_alignment PRIMARY KEY(`program_measure_alignment_id`)
) COMMENT 'This association product represents the contractual alignment between a quality measure and an RPM program. It captures the program-specific configuration for each measure including weighting for VBP scoring, reporting cadence, effectiveness period, and program-level target thresholds. Each record links one quality measure to one RPM program with attributes that define how that measure is tracked, weighted, and reported within the context of that specific program.. Existence Justification: In healthcare quality and digital health strategy, one quality measure (e.g., blood pressure control, HbA1c management) is tracked by multiple RPM programs (hypertension monitoring, CHF management, diabetes management), and one RPM program simultaneously monitors multiple quality measures for VBP scoring and program effectiveness. Health systems actively manage this program measure alignment as part of their value-based care strategy, assigning measure-specific weights, thresholds, and reporting frequencies to each program-measure combination.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`measure_model_validation` (
    `measure_model_validation_id` BIGINT COMMENT 'System-generated unique identifier for the measure-model validation record',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to the AI model card providing support for the quality measure',
    `measure_id` BIGINT COMMENT 'Foreign key to quality.measure identifying the quality measure being supported',
    `effective_from` DATE COMMENT 'Date when the AI model was validated and approved to support this quality measure',
    `effective_until` DATE COMMENT 'Date when the model validation expires or was retired for this measure (nullable for currently active validations)',
    `model_role` STRING COMMENT 'Classification of how the AI model contributes to the quality measure calculation (e.g., prediction, NLP extraction, scoring)',
    `performance_contribution_weight` DECIMAL(18,2) COMMENT 'Numeric weight representing how much this model contributes to the overall measure calculation (0.0000 to 1.0000)',
    `validation_status` STRING COMMENT 'Current status of the models validation for supporting this specific quality measure',
    CONSTRAINT pk_measure_model_validation PRIMARY KEY(`measure_model_validation_id`)
) COMMENT 'This association product represents the validated linkage between a quality measure and an AI model card in the clinical_ai governance framework. It captures which AI models are approved to support which quality measures, with validation status, effective dating, role classification, and performance contribution weighting. Each record links one quality measure to one model card with attributes that exist only in the context of this governance relationship. Required for FDA SaMD regulatory compliance and CMS AI transparency reporting.. Existence Justification: In healthcare AI governance, quality measures are supported by multiple AI models (e.g., a readmission risk model and an NLP extraction model both feed the same HEDIS measure), and a single AI model can serve multiple quality measures (e.g., a readmission prediction model feeds both HEDIS readmission measures and CMS VBP penalty measures). Healthcare organizations actively manage which AI models support which quality measures, tracking validation status, effective dates, and performance contribution for regulatory compliance and FDA SaMD governance.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`measure_applicability` (
    `measure_applicability_id` BIGINT COMMENT 'System-generated unique surrogate key for each measure-service applicability record.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to the quality measure being applied to a post-acute service',
    `post_acute_service_id` BIGINT COMMENT 'Foreign key linking to the post-acute care service to which the measure applies',
    `applicability_flag` BOOLEAN COMMENT 'Indicates whether the quality measure currently applies to this post-acute service for reporting purposes.',
    `effective_from` DATE COMMENT 'Date when this measure first became applicable to this post-acute service.',
    `effective_until` DATE COMMENT 'Date when this measure ceases to apply to this post-acute service (null if currently active).',
    `measurement_methodology` STRING COMMENT 'The measurement methodology used to calculate this measure for this specific service type, which may differ from the measures default methodology.',
    `reporting_frequency` STRING COMMENT 'How often this measure-service combination must be reported to the relevant regulatory body.',
    CONSTRAINT pk_measure_applicability PRIMARY KEY(`measure_applicability_id`)
) COMMENT 'This association product represents the regulatory applicability mapping between quality measures and post-acute care services. It captures which quality measures apply to which PAC service types, including the specific measurement methodology, reporting frequency, and temporal validity of each applicability determination. Each record links one quality measure to one post-acute service with attributes that define how and when that measure is reported for that service type. Healthcare quality teams actively maintain these mappings as CMS and other stewards update measure specifications annually.. Existence Justification: In healthcare quality reporting, CMS and other regulatory bodies require organizations to track which quality measures apply to which post-acute care services. A single quality measure (e.g., OASIS-based functional improvement) applies across multiple PAC service types (physical therapy, occupational therapy, home health nursing), and each PAC service is subject to multiple quality measures (patient experience, outcome measures, process measures). Healthcare organizations actively manage this applicability mapping as part of their compliance and reporting workflows, updating it as CMS changes measure specifications annually.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`surveyor_team` (
    `surveyor_team_id` BIGINT COMMENT 'Primary key for surveyor_team',
    `accreditation_body` STRING COMMENT 'The accrediting or regulatory organization that the surveyor team represents, such as The Joint Commission (TJC), CMS, DNV Healthcare, HFAP, CIHQ, or AAAHC.',
    `assigned_region` STRING COMMENT 'Geographic region or territory to which the surveyor team is assigned for conducting surveys, used for logistics planning and conflict-of-interest management.',
    `conflict_of_interest_cleared` BOOLEAN COMMENT 'Indicates whether the surveyor team has been cleared of any conflicts of interest with the organization being surveyed, as required by accreditation body policies.',
    `contact_email` STRING COMMENT 'Primary email address for official communication with the surveyor team, used for scheduling coordination and document exchange.',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the surveyor team for scheduling, logistics, and urgent communications during survey activities.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the surveyor team record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the surveyor teams authorization or assignment period concludes. Null for open-ended or standing teams.',
    `effective_start_date` DATE COMMENT 'Date from which the surveyor team is authorized and available to conduct survey activities.',
    `formation_date` DATE COMMENT 'Date on which the surveyor team was officially formed or assembled for a specific survey engagement or standing assignment.',
    `language_capability` STRING COMMENT 'Languages in which the surveyor team can conduct surveys, relevant for organizations serving diverse patient populations or located in multilingual regions.',
    `last_deployment_date` DATE COMMENT 'Date of the most recent survey deployment for this team, used for workload balancing and scheduling optimization.',
    `max_survey_duration_days` STRING COMMENT 'Maximum number of days the surveyor team is authorized to spend on-site for a single survey engagement, based on organization size and complexity.',
    `member_count` STRING COMMENT 'Total number of surveyors assigned to this team for the current or upcoming survey engagement.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the surveyor team, including special instructions, historical context, or administrative remarks.',
    `specialty_focus` STRING COMMENT 'Primary clinical or operational specialty area the team is qualified to assess, such as nursing, pharmacy, infection control, environment of care, medical staff, or information management.',
    `survey_program` STRING COMMENT 'The specific accreditation or certification program the team is assigned to evaluate, such as Hospital Accreditation, Ambulatory Care, Behavioral Health, Home Care, or Laboratory programs.',
    `survey_scope` STRING COMMENT 'Defines the breadth of the survey the team is authorized to conduct: full comprehensive survey, focused review on specific standards, limited scope, tracer methodology, or system-level assessment.',
    `surveyor_team_name` STRING COMMENT 'Human-readable name or designation assigned to the surveyor team for identification during accreditation surveys and regulatory inspections.',
    `surveyor_team_status` STRING COMMENT 'Current lifecycle status of the surveyor team indicating whether it is active and available for deployment, inactive, pending formation, currently deployed on a survey, or disbanded.',
    `team_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the surveyor team for tracking and scheduling purposes across accreditation bodies.',
    `team_lead_credential` STRING COMMENT 'Professional credentials or certifications held by the team lead, such as MD, RN, PharmD, or other relevant healthcare qualifications that authorize them to conduct surveys.',
    `team_lead_name` STRING COMMENT 'Full name of the designated team leader responsible for coordinating the survey activities and serving as the primary point of contact with the surveyed organization.',
    `team_type` STRING COMMENT 'Classification of the surveyor team based on the nature of the survey they conduct, such as accreditation, regulatory compliance, mock surveys, focused reviews, validation surveys, or unannounced inspections.',
    `total_surveys_completed` STRING COMMENT 'Cumulative count of surveys successfully completed by this team since formation, used for experience tracking and team capability assessment.',
    `training_certification_status` STRING COMMENT 'Current status of the teams mandatory training and certification requirements, ensuring all members meet accreditation body standards for conducting surveys.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when the surveyor team record was last modified.',
    CONSTRAINT pk_surveyor_team PRIMARY KEY(`surveyor_team_id`)
) COMMENT 'Master reference table for surveyor_team. Referenced by surveyor_team_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`root_cause_analysis` (
    `root_cause_analysis_id` BIGINT COMMENT 'Primary key for root_cause_analysis',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or care site where the event occurred and the RCA is being conducted.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or unit where the triggering event occurred.',
    `patient_safety_event_id` BIGINT COMMENT 'Identifier of the patient safety event or sentinel event that triggered this root cause analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the provider or staff member designated as the lead investigator for this RCA.',
    `root_executive_sponsor_employee_id` BIGINT COMMENT 'Identifier of the executive leader or senior administrator sponsoring and accountable for the RCA and its action plan.',
    `visit_id` BIGINT COMMENT 'Identifier of the patient encounter during which the event occurred, if applicable.',
    `action_strength_rating` STRING COMMENT 'Rating of the strength of corrective actions per VA National Center for Patient Safety hierarchy (strong actions like forcing functions vs. weak actions like training).',
    `analysis_type` STRING COMMENT 'Classification of the type of root cause analysis based on the severity and nature of the triggering event.',
    `approval_date` DATE COMMENT 'Date on which the completed RCA and corrective action plan were formally approved by leadership.',
    `completion_date` DATE COMMENT 'Actual date on which the root cause analysis was completed and findings were finalized.',
    `confidentiality_protection` STRING COMMENT 'Type of legal or regulatory confidentiality protection applied to this RCA (e.g., peer review privilege, quality improvement privilege).',
    `contributing_factor_summary` STRING COMMENT 'Narrative summary of the contributing factors identified during the analysis, including human, process, equipment, and environmental factors.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective actions and risk reduction strategies developed to prevent recurrence.',
    `effectiveness_measure_description` STRING COMMENT 'Description of the metrics or criteria used to measure whether corrective actions successfully prevented recurrence.',
    `effectiveness_verified` BOOLEAN COMMENT 'Indicates whether the corrective actions have been verified as effective in preventing recurrence during follow-up review.',
    `event_category` STRING COMMENT 'High-level category of the event being analyzed, aligned with patient safety taxonomy. [ENUM-REF-CANDIDATE: medication|surgical|fall|infection|diagnostic|equipment|communication|transfusion|maternal|behavioral — promote to reference product]',
    `event_date` DATE COMMENT 'Date on which the triggering patient safety event or sentinel event occurred.',
    `follow_up_review_date` DATE COMMENT 'Scheduled date for follow-up review to assess effectiveness of implemented corrective actions.',
    `harm_score` STRING COMMENT 'Harm level classification using NCC MERP Index categories (A through I) or equivalent patient harm scale. [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I — promote to reference product]',
    `hipaa_retention_years` STRING COMMENT 'Number of years this record must be retained per HIPAA and organizational record retention policies. Annotated for Delta Lake lifecycle management.',
    `initiation_date` DATE COMMENT 'Date on which the root cause analysis was formally initiated. TJC requires RCA initiation within 72 hours of sentinel event awareness.',
    `is_never_event` BOOLEAN COMMENT 'Indicates whether the event is classified as a CMS Never Event (serious reportable event that should never occur).',
    `is_reportable_to_cms` BOOLEAN COMMENT 'Indicates whether this event qualifies as a CMS-reportable never event or serious reportable event.',
    `is_reportable_to_state` BOOLEAN COMMENT 'Indicates whether this event meets state department of health mandatory reporting criteria.',
    `is_reportable_to_tjc` BOOLEAN COMMENT 'Indicates whether this event meets The Joint Commission criteria for mandatory sentinel event reporting.',
    `is_sentinel_event` BOOLEAN COMMENT 'Indicates whether the triggering event qualifies as a sentinel event per TJC definition (unexpected occurrence involving death or serious harm).',
    `is_shared_organization_wide` BOOLEAN COMMENT 'Indicates whether findings and lessons learned have been disseminated across the organization beyond the originating department.',
    `lessons_learned` STRING COMMENT 'Summary of key lessons learned from the analysis that may be shared across the organization for broader safety improvement.',
    `methodology` STRING COMMENT 'Analytical methodology or framework used to conduct the root cause analysis.',
    `number_of_corrective_actions` STRING COMMENT 'Total count of distinct corrective actions identified in the action plan.',
    `patient_outcome` STRING COMMENT 'Outcome experienced by the patient as a result of the triggering event.',
    `priority_level` STRING COMMENT 'Priority classification indicating urgency of the root cause analysis based on event severity and potential for recurrence.',
    `rca_number` STRING COMMENT 'Externally-known business reference number assigned to this root cause analysis for tracking and reporting purposes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this root cause analysis record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this root cause analysis record was last modified.',
    `recurrence_risk_level` STRING COMMENT 'Assessed probability of the same or similar event recurring without intervention.',
    `related_litigation_flag` BOOLEAN COMMENT 'Indicates whether there is known or anticipated litigation related to the triggering event.',
    `root_cause_analysis_status` STRING COMMENT 'Current lifecycle status of the root cause analysis workflow.',
    `root_cause_statement` STRING COMMENT 'Formal statement identifying the fundamental root cause(s) determined by the analysis team. Must identify system-level causes, not individual blame.',
    `severity_assessment_code` STRING COMMENT 'Safety Assessment Code combining severity and probability to determine the level of action required (SAC-1 highest, SAC-3 lowest).',
    `source_system` STRING COMMENT 'Name of the operational system from which this RCA record originated (e.g., Epic Healthy Planet, Symplr, internal quality management system).',
    `system_factor_category` STRING COMMENT 'Primary system-level factor category identified as the root cause, aligned with human factors engineering taxonomy.',
    `target_completion_date` DATE COMMENT 'Expected date by which the root cause analysis should be completed. TJC requires completion within 45 calendar days for sentinel events.',
    `team_members` STRING COMMENT 'Comma-separated list of roles or names of the multidisciplinary team members who participated in the RCA. TJC requires involvement of leadership and subject matter experts.',
    `team_size` STRING COMMENT 'Number of team members who participated in the root cause analysis.',
    `tjc_submission_date` DATE COMMENT 'Date on which the RCA findings and action plan were submitted to The Joint Commission, if applicable.',
    CONSTRAINT pk_root_cause_analysis PRIMARY KEY(`root_cause_analysis_id`)
) COMMENT 'Master reference table for root_cause_analysis. Referenced by root_cause_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`quality`.`measure_set` (
    `measure_set_id` BIGINT COMMENT 'Primary key for measure_set',
    `parent_set_id` BIGINT COMMENT 'Reference to a parent measure set when this set is a subset or domain within a larger composite program (e.g., Safety domain within overall VBP).',
    `superseded_by_set_id` BIGINT COMMENT 'Reference to the newer measure set that supersedes this version when status is superseded. Enables tracking of measure set evolution across program years.',
    `achievement_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum performance percentile or rate required to earn achievement points (floor threshold for scoring).',
    `applicable_population` STRING COMMENT 'Description of the patient population to which this measure set applies (e.g., Medicare FFS beneficiaries age 65+, Commercial HMO members, All payer inpatient discharges).',
    `benchmark_pct` DECIMAL(18,2) COMMENT 'Top-decile or best-in-class performance rate used as the benchmark ceiling for maximum achievement scoring.',
    `benchmark_source` STRING COMMENT 'Source of benchmark data used for scoring comparisons (e.g., CMS National Average, NCQA HEDIS Percentiles, State Peer Group).',
    `care_setting` STRING COMMENT 'The clinical care setting to which this measure set applies (e.g., inpatient hospital, outpatient clinic, emergency department, skilled nursing facility).',
    `data_source_type` STRING COMMENT 'Primary data source type used to calculate measures within this set (e.g., electronic health record extraction, claims data, clinical registry, patient survey, hybrid chart/claims).',
    `effective_end_date` DATE COMMENT 'Date after which this measure set version is no longer valid for reporting. NULL indicates the measure set is currently open-ended.',
    `effective_start_date` DATE COMMENT 'Date from which this measure set version becomes effective for quality reporting and scoring purposes.',
    `external_url` STRING COMMENT 'URL link to the official external documentation or specification for this measure set from the sponsoring organization.',
    `improvement_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage improvement from baseline required to earn improvement points within the scoring methodology.',
    `incentive_maximum_pct` DECIMAL(18,2) COMMENT 'Maximum payment bonus percentage achievable through high performance on this measure set.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether reporting on this measure set is mandatory (true) or voluntary (false) for eligible providers/facilities under the associated program.',
    `is_pay_for_performance` BOOLEAN COMMENT 'Indicates whether performance on this measure set directly impacts financial incentives or penalties (e.g., VBP payment adjustments, MIPS payment modifiers).',
    `is_public_reported` BOOLEAN COMMENT 'Indicates whether results from this measure set are publicly reported (e.g., on CMS Hospital Compare, Healthgrades, or state transparency websites).',
    `last_reviewed_date` DATE COMMENT 'Date when this measure set was last reviewed for accuracy, applicability, and alignment with current program requirements.',
    `measure_set_category` STRING COMMENT 'High-level category classifying the measure sets primary quality domain focus area.',
    `measure_set_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the measure set within the organizations quality management system (e.g., CMS-VBP-FY24, HEDIS-MY2024).',
    `measure_set_description` STRING COMMENT 'Detailed narrative description of the measure sets purpose, scope, target population, and intended use in quality improvement or payment programs.',
    `measure_set_name` STRING COMMENT 'Human-readable name of the measure set as defined by the sponsoring organization (e.g., CMS Hospital VBP Measure Set FY2024, HEDIS Commercial HMO 2024).',
    `measure_set_status` STRING COMMENT 'Current lifecycle status of the measure set indicating whether it is actively used for reporting and scoring.',
    `minimum_case_threshold` STRING COMMENT 'Minimum number of eligible cases/encounters required for a provider or facility to be scored on this measure set. Below this threshold, the entity is excluded from scoring.',
    `minimum_measure_count` STRING COMMENT 'Minimum number of individual measures within this set that must be reported to satisfy program requirements.',
    `notes` STRING COMMENT 'Free-text notes capturing implementation guidance, known issues, exclusion criteria, or special considerations for this measure set.',
    `nqf_endorsement_status` STRING COMMENT 'Indicates whether the measure set (or its constituent measures) carries National Quality Forum endorsement, which is often required for CMS program inclusion.',
    `owner_department` STRING COMMENT 'Internal department or team responsible for managing, reporting, and ensuring compliance with this measure set (e.g., Quality Management, Population Health, Clinical Analytics).',
    `penalty_maximum_pct` DECIMAL(18,2) COMMENT 'Maximum payment reduction percentage that can result from poor performance on this measure set (e.g., 2% for VBP, 9% for MIPS).',
    `performance_period_end` DATE COMMENT 'End date of the measurement/performance period for data collection and scoring.',
    `performance_period_start` DATE COMMENT 'Start date of the measurement/performance period during which clinical data is collected for scoring against this measure set.',
    `program_type` STRING COMMENT 'The quality or payment program under which this measure set is defined (e.g., Value-Based Purchasing, Merit-based Incentive Payment System, Alternative Payment Model, HEDIS, The Joint Commission, state-mandated).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this measure set record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this measure set record was last modified in the data platform.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory citation or rule reference that mandates this measure set (e.g., 42 CFR 412.160, MACRA Section 101, State Health Code §2805-m).',
    `reporting_level` STRING COMMENT 'The organizational level at which this measure set is reported (e.g., individual provider, group practice, facility, health plan, Accountable Care Organization).',
    `reporting_period_year` STRING COMMENT 'The calendar or fiscal year to which this measure set applies for regulatory reporting (e.g., 2024 for HEDIS MY2024 or CMS VBP FY2024).',
    `review_frequency` STRING COMMENT 'How frequently performance against this measure set is internally reviewed and reported to leadership.',
    `risk_adjustment_method` STRING COMMENT 'Statistical risk adjustment methodology applied to measure set scoring to account for patient acuity and case mix differences (e.g., CMS HCC, APR-DRG severity, none).',
    `scoring_methodology` STRING COMMENT 'Description of how individual measure scores within the set are aggregated into a composite or total score (e.g., weighted average, achievement/improvement points, all-or-nothing).',
    `source_system` STRING COMMENT 'The operational system from which this measure set definition originates (e.g., Healthy Planet, Cerner Quality Management, 3M CDI, MEDITECH Quality).',
    `specialty_focus` STRING COMMENT 'The clinical specialty or service line to which this measure set is most applicable (e.g., cardiology, oncology, primary care, behavioral health). NULL if applicable across specialties.',
    `sponsoring_organization` STRING COMMENT 'The organization that defines and maintains the measure set (e.g., CMS, NCQA, The Joint Commission, AHRQ, state health department).',
    `submission_deadline` DATE COMMENT 'Final date by which measure set results must be submitted to the sponsoring organization or regulatory body.',
    `total_measure_count` STRING COMMENT 'Total number of individual quality measures included in this measure set version.',
    `version` STRING COMMENT 'Version identifier for the measure set, reflecting updates to included measures, scoring methodology, or reporting requirements across program years.',
    `weight_in_program` DECIMAL(18,2) COMMENT 'The percentage weight this measure set carries within the overall quality program scoring (e.g., Safety domain = 25% of VBP Total Performance Score).',
    CONSTRAINT pk_measure_set PRIMARY KEY(`measure_set_id`)
) COMMENT 'Master reference table for measure_set. Referenced by measure_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_cahps_survey_id` FOREIGN KEY (`cahps_survey_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`cahps_survey`(`cahps_survey_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_primary_related_event_patient_safety_event_id` FOREIGN KEY (`primary_related_event_patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_primary_patient_safety_event_id` FOREIGN KEY (`primary_patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_care_gap_measure_id` FOREIGN KEY (`care_gap_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_surveyor_team_id` FOREIGN KEY (`surveyor_team_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`surveyor_team`(`surveyor_team_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_apm_program_enrollment_id` FOREIGN KEY (`apm_program_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`apm_program_enrollment`(`apm_program_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_mips_clinician_measure_id` FOREIGN KEY (`mips_clinician_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`mips_clinician_measure`(`mips_clinician_measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_sdoh_screening_id` FOREIGN KEY (`sdoh_screening_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`sdoh_screening`(`sdoh_screening_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_root_cause_analysis_id` FOREIGN KEY (`root_cause_analysis_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`root_cause_analysis`(`root_cause_analysis_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_standard_finding_id` FOREIGN KEY (`standard_finding_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`standard_finding`(`standard_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` ADD CONSTRAINT `fk_quality_mips_clinician_measure_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` ADD CONSTRAINT `fk_quality_mips_clinician_measure_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_vbp_program_id` FOREIGN KEY (`vbp_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`vbp_program`(`vbp_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` ADD CONSTRAINT `fk_quality_mips_clinician_measure_report_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` ADD CONSTRAINT `fk_quality_mips_clinician_measure_report_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ADD CONSTRAINT `fk_quality_mips_reporting_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ADD CONSTRAINT `fk_quality_mips_reporting_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ADD CONSTRAINT `fk_quality_program_measure_alignment_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ADD CONSTRAINT `fk_quality_measure_model_validation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ADD CONSTRAINT `fk_quality_measure_applicability_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_set` ADD CONSTRAINT `fk_quality_measure_set_parent_set_id` FOREIGN KEY (`parent_set_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure_set`(`measure_set_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_set` ADD CONSTRAINT `fk_quality_measure_set_superseded_by_set_id` FOREIGN KEY (`superseded_by_set_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure_set`(`measure_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`quality` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `healthcare_ecm_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `benchmark_threshold` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Threshold (Percentage)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('dbx_business_glossary_term' = 'Clinical Area');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|fair|poor');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'EHR|Claims|Registry|Survey');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('dbx_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `eligible_population_age_max` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Maximum Age');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `eligible_population_age_min` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Minimum Age');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `eligible_population_sex` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Sex');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `eligible_population_sex` SET TAGS ('dbx_value_regex' = 'male|female|both');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `hedis_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `hedis_measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `hedis_measure_status` SET TAGS ('dbx_value_regex' = 'active|retired|draft|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `is_core_measure` SET TAGS ('dbx_business_glossary_term' = 'Core Measure Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'Preventive Care|Chronic Disease|Utilization|Effectiveness|Safety|Patient Experience');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'Rate|Proportion|Ratio|Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measure Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('dbx_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `population_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `related_measure_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Measure IDs');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `risk_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjusted Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '%|count|days|hours');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|retired|draft|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_measure` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_unity_catalog_tags' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_delta_tblproperties' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_hipaa_retention_annotation' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_liquid_clustering' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_rls_predicate' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` SET TAGS ('dbx_scd_type' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Result Identifier (HEDIS_RESULT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (CARE_SITE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (PROVIDER_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (HEALTH_PLAN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Identifier (MEASURE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate (BENCHMARK_RATE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DATA_QUALITY_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DATA_SOURCE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'claims|encounter|lab|pharmacy|survey');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `denominator` SET TAGS ('dbx_business_glossary_term' = 'Denominator Count (DENOMINATOR)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `exclusion_count` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Count (EXCLUSION_COUNT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `gap_count` SET TAGS ('dbx_business_glossary_term' = 'Gap Count (GAP_COUNT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `hedis_result_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `hedis_result_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By (LAST_REVIEWED_BY)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (LAST_REVIEWED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category (MEASURE_CATEGORY)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'preventive|screening|chronic|utilization');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type (MEASURE_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'administrative|clinical|hybrid');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_version` SET TAGS ('dbx_business_glossary_term' = 'Measure Version (MEASURE_VERSION)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `numerator` SET TAGS ('dbx_business_glossary_term' = 'Numerator Count (NUMERATOR)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Result Rate (RATE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date (RPT_END)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date (RPT_START)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `risk_adjusted_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjusted Flag (RISK_ADJ_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `risk_adjusted_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjusted Rate (RISK_ADJ_RATE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date (SUBMISSION_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status (SUBMISSION_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|rejected|approved');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'HEDIS Measure Name (MEASURE_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (PROVIDER_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` SET TAGS ('dbx_subdomain' = 'population_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `cahps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'CAHPS Survey ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `administration_mode` SET TAGS ('dbx_business_glossary_term' = 'Administration Mode');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `administration_mode` SET TAGS ('dbx_value_regex' = 'mail|phone|mixed|online');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `cms_certification_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Certification Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `cms_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|not_certified');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Patient Comments');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `communication_doctors_score` SET TAGS ('dbx_business_glossary_term' = 'Communication with Doctors Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `communication_medicines_score` SET TAGS ('dbx_business_glossary_term' = 'Communication about Medicines Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `completed_question_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Question Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite CAHPS Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `discharge_info_score` SET TAGS ('dbx_business_glossary_term' = 'Discharge Information Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `non_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑Response Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Hospital Rating');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `pain_management_score` SET TAGS ('dbx_business_glossary_term' = 'Pain Management Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_age` SET TAGS ('dbx_business_glossary_term' = 'Patient Age');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_age` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_business_glossary_term' = 'Patient Email Address');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_business_glossary_term' = 'Patient Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_race` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_business_glossary_term' = 'Patient ZIP Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(?:-[0-9]{4})?$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_zip` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `program_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Program Effective From');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `program_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Until');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|final|archived');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `response_mode` SET TAGS ('dbx_business_glossary_term' = 'Response Mode');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `response_mode` SET TAGS ('dbx_value_regex' = 'mail|phone|online|in_person');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `responsiveness_staff_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness of Staff Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `sampling_methodology` SET TAGS ('dbx_business_glossary_term' = 'Sampling Methodology');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_cycle` SET TAGS ('dbx_business_glossary_term' = 'Survey Cycle');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_cycle` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_program_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Program Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_question_count` SET TAGS ('dbx_business_glossary_term' = 'Survey Question Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_source_system` SET TAGS ('dbx_business_glossary_term' = 'Survey Source System');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'hospital|clinician|home_health');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_business_glossary_term' = 'Unity Catalog Tags');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` SET TAGS ('dbx_subdomain' = 'population_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `cahps_response_id` SET TAGS ('dbx_business_glossary_term' = 'CAHPS Response ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `cahps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `administration_mode` SET TAGS ('dbx_business_glossary_term' = 'Administration Mode');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `administration_mode` SET TAGS ('dbx_value_regex' = 'mail|phone|online|in_person|tablet|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'emergency|urgent|elective|newborn|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `age_at_survey` SET TAGS ('dbx_business_glossary_term' = 'Age at Survey');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Free‑Text Comments');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `communication_doctor_score` SET TAGS ('dbx_business_glossary_term' = 'Communication with Doctors Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `communication_medicine_score` SET TAGS ('dbx_business_glossary_term' = 'Communication About Medicines Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_value_regex' = 'home|rehab|snf|expired|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `discharge_information_score` SET TAGS ('dbx_business_glossary_term' = 'Discharge Information Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `hospital_rating` SET TAGS ('dbx_business_glossary_term' = 'Hospital Rating');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `is_hospital_accredited` SET TAGS ('dbx_business_glossary_term' = 'Hospital Accreditation Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|ar|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (Days)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_score_category` SET TAGS ('dbx_business_glossary_term' = 'Overall Score Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_score_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `pain_management_score` SET TAGS ('dbx_business_glossary_term' = 'Pain Management Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_business_glossary_term' = 'Proxy Relationship');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_value_regex' = 'spouse|child|parent|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `respondent_type` SET TAGS ('dbx_value_regex' = 'patient|family|proxy');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'completed|partial|refused|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `responsiveness_staff_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness of Staff Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `survey_completion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Time (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_unity_catalog_tags' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_delta_tblproperties' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_hipaa_retention_annotation' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_liquid_clustering' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_rls_predicate' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` SET TAGS ('dbx_scd_type' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Health Alert Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|completed|overdue');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'disclosed|not_disclosed|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `effectiveness_verification` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'medication_error|procedure_error|fall|infection|equipment_failure|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level` SET TAGS ('dbx_business_glossary_term' = 'Harm Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level` SET TAGS ('dbx_value_regex' = 'no_harm|minor|moderate|severe|death');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `immediate_action` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Reportable Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel` SET TAGS ('dbx_business_glossary_term' = 'Sentinel Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Event Location');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Occurrence Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_age` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Event');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_age` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_age` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('dbx_business_glossary_term' = 'Patient Outcome');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('dbx_value_regex' = 'recovered|ongoing|death|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_category` SET TAGS ('dbx_value_regex' = 'sentinel|non_sentinel|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|closed|dismissed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `rca_type` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `rca_type` SET TAGS ('dbx_value_regex' = 'rca|aca|apparent_cause');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `reporting_agency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Agency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `reporting_agency` SET TAGS ('dbx_value_regex' = 'TJC|CMS|State|Other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'reported|under_review|closed|dismissed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `reporter_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `category` SET TAGS ('dbx_value_regex' = 'sentinel|non_sentinel|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `safety_event_review_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Review ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `safety_location_care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `effectiveness_verification` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'medication|procedure|equipment|communication|infection|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `incident_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Incident Subcategory');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `is_reportable_to_regulator` SET TAGS ('dbx_business_glossary_term' = 'Reportable to Regulator Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_age_at_event` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Event');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_value_regex' = 'mrn|ssn|national_id');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_identifier_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race/Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `reportable_regulator` SET TAGS ('dbx_business_glossary_term' = 'Reportable Regulator');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Review Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Review Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Review Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|closed|rejected');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_team_members` SET TAGS ('dbx_business_glossary_term' = 'Review Team Members');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Review Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'root_cause|apparent_cause|process_review');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_value_regex' = 'clinical|quality|risk|admin');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_review_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Review Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `quality_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Committee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `cmi_score` SET TAGS ('dbx_business_glossary_term' = 'Case Mix Index (CMI) Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Clinical Factors');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Death Cause ICD‑10 Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_value_regex' = '^[A-Z]d{2}(.d+)?$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_cause_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_business_glossary_term' = 'Death Classification');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_value_regex' = 'expected|unexpected|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Improvement Recommendations');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_rate_category` SET TAGS ('dbx_business_glossary_term' = 'Mortality Rate Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_rate_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_review_status` SET TAGS ('dbx_value_regex' = 'open|in_review|closed|rejected');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Review Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_business_glossary_term' = 'Death Preventability Determination');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_value_regex' = 'yes|no|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `quality_metric_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Metric Inclusion Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_findings` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Findings');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_findings` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_findings` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_findings` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_findings` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_findings` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_location` SET TAGS ('dbx_business_glossary_term' = 'Review Location');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Mortality Review Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'action_taken|no_action|deferred');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_trigger_criteria` SET TAGS ('dbx_business_glossary_term' = 'Review Trigger Criteria');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'peer_review|clinical_review|root_cause_analysis');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|in_review|closed|rejected');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `vbp_program_id` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Purchasing (VBP) Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `baseline_score` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcome_weight` SET TAGS ('dbx_business_glossary_term' = 'Clinical Outcome Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `efficiency_cost_reduction_weight` SET TAGS ('dbx_business_glossary_term' = 'Efficiency & Cost Reduction Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `is_apm_enrolled` SET TAGS ('dbx_business_glossary_term' = 'APM Enrollment Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `is_care_gap_closure_included` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Inclusion Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `is_mips_eligible` SET TAGS ('dbx_business_glossary_term' = 'MIPS Eligibility Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `measure_set_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Set Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `payment_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Factor');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `person_community_engagement_weight` SET TAGS ('dbx_business_glossary_term' = 'Person & Community Engagement Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'VBP Program Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'VBP Program Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'VBP|MIPS|APM');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `safety_weight` SET TAGS ('dbx_business_glossary_term' = 'Safety Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `total_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Total Performance Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_business_glossary_term' = 'Unity Catalog Tags');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_delta_tblproperties' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_hipaa_retention_annotation' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_liquid_clustering' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_rls_predicate' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_scd_type' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_unity_catalog_tags' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `vbp_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `vbp_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`vbp_program` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `care_gap_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Measure Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `apm_program_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'APM Program Enrollment Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `benchmark_threshold` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Threshold');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `calculation_logic` SET TAGS ('dbx_business_glossary_term' = 'Calculation Logic');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `care_gap_closure_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `clinical_area` SET TAGS ('dbx_business_glossary_term' = 'Clinical Area');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `cms_ecqm_identifier` SET TAGS ('dbx_business_glossary_term' = 'CMS eCQM Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ehr|claims|registry|survey|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `denominator_definition` SET TAGS ('dbx_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|semiannual');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `is_composite_measure` SET TAGS ('dbx_business_glossary_term' = 'Composite Measure Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `is_mips_measure` SET TAGS ('dbx_business_glossary_term' = 'MIPS Measure Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'process|outcome|structural|patient_experience|composite');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `mips_category` SET TAGS ('dbx_business_glossary_term' = 'MIPS Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `mips_category` SET TAGS ('dbx_value_regex' = 'quality|efficiency|improvement|cost');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `mips_measure_type` SET TAGS ('dbx_business_glossary_term' = 'MIPS Measure Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `mips_measure_type` SET TAGS ('dbx_value_regex' = 'outcome|process');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `mips_reporting_option` SET TAGS ('dbx_business_glossary_term' = 'MIPS Reporting Option');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `mips_reporting_option` SET TAGS ('dbx_value_regex' = 'public|private');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `nqf_number` SET TAGS ('dbx_business_glossary_term' = 'NQF Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `numerator_definition` SET TAGS ('dbx_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `owner_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('dbx_business_glossary_term' = 'Reporting Program');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('dbx_value_regex' = 'cms_iqr|vbp|mips|tjc|ncqa_hedis|internal');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|biennial');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `steward` SET TAGS ('dbx_business_glossary_term' = 'Measure Steward');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `cms_ecqm_id` SET TAGS ('dbx_business_glossary_term' = 'CMS eCQM Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_owner` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_owner_contact` SET TAGS ('dbx_business_glossary_term' = 'Measure Owner Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_owner_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_owner_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure` ALTER COLUMN `measure_owner_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_result_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Result ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'National Benchmark Rate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `data_quality_comment` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Comment');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'claims|EHR|registry|survey');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `denominator` SET TAGS ('dbx_business_glossary_term' = 'Denominator Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'facility|provider|patient|health_plan');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `exclusion_count` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `gap_to_target` SET TAGS ('dbx_business_glossary_term' = 'Gap to Target');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'outcome|process|structure');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_result_status` SET TAGS ('dbx_value_regex' = 'pending|final|retracted');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_version` SET TAGS ('dbx_business_glossary_term' = 'Measure Version');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measured_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entity ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measured_entity_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measured_entity_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measured_entity_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measured_entity_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measured_entity_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `national_benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'National Benchmark Rate (Duplicate)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Result Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `numerator` SET TAGS ('dbx_business_glossary_term' = 'Numerator Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `percentile_rank` SET TAGS ('dbx_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Rate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `quality_domain` SET TAGS ('dbx_business_glossary_term' = 'Quality Domain');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `quality_domain` SET TAGS ('dbx_value_regex' = 'patient_safety|clinical|population|process');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_method` SET TAGS ('dbx_business_glossary_term' = 'Reporting Methodology');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_method` SET TAGS ('dbx_value_regex' = 'administrative|hybrid|chart_abstracted');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Generation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `risk_adjusted_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk‑Adjusted Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `risk_adjusted_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk‑Adjusted Rate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|rejected|approved');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `target_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Rate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'pending|final|retracted');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `entity_id` SET TAGS ('dbx_business_glossary_term' = 'Entity ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `entity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `entity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `program` SET TAGS ('dbx_business_glossary_term' = 'Reporting Program');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `program` SET TAGS ('dbx_value_regex' = 'CMS_IQR|OQR|VBP|MIPS|HEDIS|State');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_result` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cdi_review_id` SET TAGS ('dbx_business_glossary_term' = 'CDI Review ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_ai_clinical_nlp_result_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Nlp Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cc_mcc_captured` SET TAGS ('dbx_business_glossary_term' = 'CC/MCC Capture Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cdi_review_status` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cdi_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indicator');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cmi_final` SET TAGS ('dbx_business_glossary_term' = 'Final Case Mix Index');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cmi_impact` SET TAGS ('dbx_business_glossary_term' = 'CMI Impact');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `cmi_initial` SET TAGS ('dbx_business_glossary_term' = 'Initial Case Mix Index');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'HIPAA|CMS|TJC|None');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `documentation_impact` SET TAGS ('dbx_business_glossary_term' = 'Documentation Impact');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `documentation_impact` SET TAGS ('dbx_value_regex' = 'drg_change|cc_mcc_capture|poa_update|none');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_final` SET TAGS ('dbx_business_glossary_term' = 'Final DRG Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_initial` SET TAGS ('dbx_business_glossary_term' = 'Initial DRG Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `is_flagged` SET TAGS ('dbx_business_glossary_term' = 'Flagged for Audit');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `physician_response` SET TAGS ('dbx_business_glossary_term' = 'Physician Response');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `poa_assigned` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission Assignment');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `quality_metric_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Metric Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_method` SET TAGS ('dbx_business_glossary_term' = 'Query Method');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_method` SET TAGS ('dbx_value_regex' = 'verbal|written|electronic');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_notes` SET TAGS ('dbx_business_glossary_term' = 'Query Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_outcome` SET TAGS ('dbx_business_glossary_term' = 'Query Outcome');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|deferred');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_present` SET TAGS ('dbx_business_glossary_term' = 'Query Generated Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_type` SET TAGS ('dbx_business_glossary_term' = 'Query Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `query_type` SET TAGS ('dbx_value_regex' = 'compliant|leading');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_location` SET TAGS ('dbx_business_glossary_term' = 'Review Location');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'initial|follow_up|post_discharge');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_credentials` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Credentials');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Full Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_value_regex' = 'physician|nurse|coder|clinical_documentation_specialist');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` SET TAGS ('dbx_subdomain' = 'accreditation_compliance');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_cycle_end` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cycle End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_cycle_start` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cycle Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cycle Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_cycle_status` SET TAGS ('dbx_value_regex' = 'ongoing|completed|overdue|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Fee Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'CMS Acceptance Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acceptance Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|under_review');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `compliance_status_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cycle Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `next_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `plan_of_correction` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `poc_deadline` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction Deadline');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `poc_status` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `poc_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'accreditation|certification|designation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'hospital|clinic|ambulatory|specialty|home_health');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|deferred');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `standards_chapters_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Standards Chapters Reviewed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_scope` SET TAGS ('dbx_business_glossary_term' = 'Survey Scope');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'triennial|unannounced|for_cause|validation|internal_mock|readiness_tracer');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `surveyor_team` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Team');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_program` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` SET TAGS ('dbx_subdomain' = 'accreditation_compliance');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `facility_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `surveyor_team_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Team ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_value_regex' = 'accredited|conditionally_accredited|denied|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `corrective_action_plan_due` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Required');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `documentation_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Documentation Completeness Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `external_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'External Audit Reference');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_high_priority` SET TAGS ('dbx_business_glossary_term' = 'High Priority Findings Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_low_priority` SET TAGS ('dbx_business_glossary_term' = 'Low Priority Findings Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_medium_priority` SET TAGS ('dbx_business_glossary_term' = 'Medium Priority Findings Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_total` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `infection_control_findings` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Findings Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `next_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `overall_readiness_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Readiness Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `patient_safety_event_count` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `preliminary_findings` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Findings Summary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `staff_training_compliance` SET TAGS ('dbx_business_glossary_term' = 'Staff Training Compliance');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `standards_chapters_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Standards Chapters Reviewed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Survey Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_location` SET TAGS ('dbx_business_glossary_term' = 'Survey Location');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_scope` SET TAGS ('dbx_business_glossary_term' = 'Survey Scope');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_scope` SET TAGS ('dbx_value_regex' = 'environment_of_care|tracer|process|policy|documentation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|closed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `surveyor_team` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Team');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body_id` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_subdomain' = 'accreditation_compliance');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_unity_catalog_tags' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_delta_tblproperties' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_hipaa_retention_annotation' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_liquid_clustering' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_rls_predicate' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` SET TAGS ('dbx_scd_type' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Finding ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `apm_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Related APM Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `mips_clinician_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Related MIPS Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Related Quality Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `care_gap_closure_status` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `care_gap_closure_status` SET TAGS ('dbx_value_regex' = 'closed|open|not_applicable');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `care_gap_target_date` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Target Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `cms_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acceptance Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `cms_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Correction Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `evidence` SET TAGS ('dbx_business_glossary_term' = 'Finding Evidence');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_code` SET TAGS ('dbx_business_glossary_term' = 'Finding Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'condition_level|standard_level|immediate_threat|requirement_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `is_critical_to_patient_safety` SET TAGS ('dbx_business_glossary_term' = 'Critical to Patient Safety Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `plan_of_correction` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `related_regulation` SET TAGS ('dbx_business_glossary_term' = 'Related Regulation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (Name)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_value_regex' = 'nurse|physician|quality_officer|admin|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|partial|not_applicable');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process|system|human|policy|training|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low|informational');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_entity_type' = 'Clean boilerplate phrase from quality.standard_finding.description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_entity_type' = 'Cleaned boilerplate description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_entity_type' = 'Cleaned boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_quality_standard_finding_description' = 'Removed boilerplate phrase');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_quality_standard_finding' = 'clean boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_quality_standard_finding_description' = 'Cleaned description without boilerplate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_description` SET TAGS ('dbx_quality_standard_finding_description' = 'Cleaned boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|deferred|reopened');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|deferred|reopened');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `corrective_action_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `related_mips_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Related MIPS Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `related_apm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Related APM Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ALTER COLUMN `last_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('dbx_business_glossary_term' = 'Aim Statement (II_AIM)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `baseline_performance` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance (II_BASE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (II_BUDGET_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency (II_BUDGET_CURR)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date (II_CLOSE_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (II_COMP_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (II_CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `current_phase` SET TAGS ('dbx_business_glossary_term' = 'Current Phase (II_PHASE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `current_phase` SET TAGS ('dbx_value_regex' = 'define|measure|analyze|improve|control');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (II_DATA_SRC)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (II_DOC_URL)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `estimated_savings` SET TAGS ('dbx_business_glossary_term' = 'Estimated Savings (II_EST_SAV)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `goal_performance` SET TAGS ('dbx_business_glossary_term' = 'Goal Performance (II_GOAL)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Improvement Cycle Number (II_CYCLE_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_initiative_description` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Description (II_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Name (II_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status (II_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_initiative_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (II_IS_ACTIVE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (II_LAST_REVIEW)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned (II_LESSONS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_actual` SET TAGS ('dbx_business_glossary_term' = 'Measure Actual (II_MEAS_ACT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code (II_MEAS_CODE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description (II_MEAS_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Measure Reporting Period (II_MEAS_RPT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_target` SET TAGS ('dbx_business_glossary_term' = 'Measure Target (II_MEAS_TGT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Measure Type (II_MEAS_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'process|outcome|balancing');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Improvement Methodology (II_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'PDSA|Lean|Six_Sigma|IHI_Model_for_Improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (II_NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Outcome Summary (II_OUTCOME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team (II_OWNER_TEAM)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `patient_population_affected` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Affected (II_PAT_POP)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (II_PRIORITY)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('dbx_business_glossary_term' = 'Problem Statement (II_PROB)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program (II_REG_PROG)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_value_regex' = 'MIPS|APM|HEDIS|CAHPS|VBP');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `related_clinical_area` SET TAGS ('dbx_business_glossary_term' = 'Related Clinical Area (II_CLIN_AREA)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome (II_REVIEW_OUT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (II_RISK)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `savings_currency` SET TAGS ('dbx_business_glossary_term' = 'Savings Currency (II_SAV_CURR)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name (II_SPONSOR)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_role` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Role (II_SPONSOR_ROLE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `stakeholder_count` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Count (II_STKHLD_COUNT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date (II_START)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date (II_TGT_COMP)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `target_measure` SET TAGS ('dbx_business_glossary_term' = 'Target Measure (II_TGT_MEAS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (II_UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Name (II_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Description (II_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status (II_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`improvement_initiative` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `quality_peer_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Peer Review ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `quality_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Committee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Patient Safety Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken Post Review');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_taken` SET TAGS ('dbx_value_regex' = 'no_action|education|remediation|disciplinary|monitoring');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_gap_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_gap_closure_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Case Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_summary` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Case Summary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_trigger` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Case Trigger');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_trigger` SET TAGS ('dbx_value_regex' = 'mortality|complication|complaint|focused_review|oppe|fppe');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `confidentiality_protection` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Protection Applied');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `confidentiality_protection` SET TAGS ('dbx_value_regex' = 'protected|unprotected');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Clinical Department');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `documentation_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Attached Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `educational_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Educational Opportunity Identified');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `external_reviewer_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reviewer Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_review|escalated');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `measure_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_age_at_review` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Review');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_age_at_review` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_age_at_review` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_age_at_review` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_age_at_review` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_age_at_review` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `program_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `program_enrollment` SET TAGS ('dbx_value_regex' = 'MIPS|APM|None');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `quality_measure_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_level` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_level` SET TAGS ('dbx_value_regex' = 'department|committee|external');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Outcome');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'appropriate|appropriate_with_suggestions|not_appropriate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_value_regex' = 'attending|resident|nurse|admin|quality_staff');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `committee` SET TAGS ('dbx_business_glossary_term' = 'Review Committee');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` SET TAGS ('dbx_subdomain' = 'population_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Population Health Gap ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `care_program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Detecting Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `sdoh_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Screening Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_business_glossary_term' = 'Closure Method');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `closure_method` SET TAGS ('dbx_value_regex' = 'claim|clinical_documentation|patient_attestation|provider_override');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_category` SET TAGS ('dbx_business_glossary_term' = 'Gap Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_category` SET TAGS ('dbx_value_regex' = 'screening|vaccination|medication|follow_up|lifestyle');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_close_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Close Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_open_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Open Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'open|closed|excluded|in_progress');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Gap Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'preventive|chronic|hedis|clinical|social');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `liquid_clustering` SET TAGS ('dbx_business_glossary_term' = 'Liquid Clustering Specification');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Gap Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `outreach_attempts` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempts Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `outreach_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Gap Priority');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `rls_predicate` SET TAGS ('dbx_business_glossary_term' = 'Row-Level Security Predicate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `scd_type` SET TAGS ('dbx_business_glossary_term' = 'Slowly Changing Dimension Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `scd_type` SET TAGS ('dbx_value_regex' = 'type2|type1');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_business_glossary_term' = 'Unity Catalog Tags');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` SET TAGS ('dbx_subdomain' = 'population_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health Screening ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `community_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Resource Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Identifier (Screening Performer)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `external_screening_number` SET TAGS ('dbx_business_glossary_term' = 'External Screening Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `follow_up_completed` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Completed Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `positive_screen_flag` SET TAGS ('dbx_business_glossary_term' = 'Positive Screen Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `referral_generated` SET TAGS ('dbx_business_glossary_term' = 'Referral Generated');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Screening Consent Given');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Consent Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_domain` SET TAGS ('dbx_business_glossary_term' = 'Screening Domain (SDOH)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_domain` SET TAGS ('dbx_value_regex' = 'food_insecurity|housing_instability|transportation|interpersonal_safety|financial_strain|employment');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'questionnaire|interview|digital');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_business_glossary_term' = 'Screening Notes (PHI)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result Summary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_source` SET TAGS ('dbx_business_glossary_term' = 'Screening Source');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_source` SET TAGS ('dbx_value_regex' = 'self_report|provider_administered|community_partner');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled|in_progress');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Date and Time');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool` SET TAGS ('dbx_business_glossary_term' = 'Screening Tool (SDOH)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool` SET TAGS ('dbx_value_regex' = 'ahc_hrs|prapare|hunger_vital_sign');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `performed_by_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Identifier (Screening Performer)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `performed_by_staff_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `performed_by_staff_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_location_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `baseline_definition` SET TAGS ('dbx_business_glossary_term' = 'Baseline Definition');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `financial_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Incentive Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `participating_facility_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Facility Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `payment_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Factor');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `performance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `performance_period_start` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'clinical|operational|financial|patient_experience');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'pay_for_performance|accreditation|improvement|reporting');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `quality_metric_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Metric Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `quality_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `quality_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `quality_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `sponsor` SET TAGS ('dbx_business_glossary_term' = 'Program Sponsor');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Program Sponsor Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_value_regex' = 'CMS|TJC|NCQA|Internal');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `total_performance_score_methodology` SET TAGS ('dbx_business_glossary_term' = 'Performance Score Methodology');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `vbp_weights` SET TAGS ('dbx_business_glossary_term' = 'Value‑Based Purchasing Domain Weights');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Name');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Email');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `program_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Event ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `standard_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Finding Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `action_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Initiated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `action_owner_role` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Role');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'process|clinical|administrative|safety|regulatory');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `actual_hours_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Spent');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|deferred|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `delta_table_properties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_value_regex' = 'audit|review|measurement|survey|test|observation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'Is External Action');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Action Location');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `related_quality_metric` SET TAGS ('dbx_business_glossary_term' = 'Related Quality Metric');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `rls_predicate` SET TAGS ('dbx_business_glossary_term' = 'Row‑Level Security Predicate');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Severity');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|severe');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `unity_catalog_tags` SET TAGS ('dbx_business_glossary_term' = 'Unity Catalog Tags');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_applicable');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|deferred|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `root_cause_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `originating_event_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Event ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `program_measure_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Assignment ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `assignment_version` SET TAGS ('dbx_business_glossary_term' = 'Assignment Version');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_category` SET TAGS ('dbx_value_regex' = 'outcome|process|structure|patient_experience');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly|daily');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = '>=|<=|=|>|<');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Measure Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `initiative_measure_target_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Measure Target ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Staff ID (OSI)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance Value (BPV)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score (CS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'Current Performance Value (CPV)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'EHR|Claims|Survey|Manual|External');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `initiative_measure_target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status (TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `initiative_measure_target_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|paused|archived');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date (MPED)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date (MPSD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type (TT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'numeric|percentage|rate|binary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Value (TPV)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '%|rate|days|points|ratio|count');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Target Status (TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|paused|archived');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Staff ID (OSI)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Initiative ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Initiative ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Initiative Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_initiative_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `incentive_currency` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `last_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `performance_metric_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `performance_metric_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|ad_hoc');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Initiative ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Contract Initiative Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `quality_program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Participation ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Participation Classification (PC)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'quality_program|clinical_quality|patient_safety');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms (CT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `data_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Data Submission Method (DSM)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `data_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|api');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `last_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Date (LRD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NRD)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `participation_number` SET TAGS ('dbx_business_glossary_term' = 'Participation Number (PN)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type (PT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score (PS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `quality_program_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status (PS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `quality_program_participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency (RF)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `retention_period` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (RP)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status (PS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `program_study_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Study Participation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'Healthy Planet|EHR|Research Registry|Other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Indicator');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_value_regex' = 'clinical|operational|regulatory|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Participation Indicator');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `reporting_adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Reporting Adjustment Description');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `reporting_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Reporting Adjustment Factor');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `stratification_category` SET TAGS ('dbx_business_glossary_term' = 'Stratification Category');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `stratification_category` SET TAGS ('dbx_value_regex' = 'age|diagnosis|risk|geography|payer|other');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `reviewer_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `measure_budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Budget Allocation ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'operational|capital|grant');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `improvement_cost` SET TAGS ('dbx_business_glossary_term' = 'Improvement Cost');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `is_overridden` SET TAGS ('dbx_business_glossary_term' = 'Is Overridden Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `overridden_amount` SET TAGS ('dbx_business_glossary_term' = 'Overridden Amount');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `performance_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Target');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|SAP|Manual');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `budget_line_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Committee Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `apm_enrollment` SET TAGS ('dbx_business_glossary_term' = 'APM Program Enrollment (APM_ENROLL)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Identifier (AUDIT_LOG_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `care_gap_closure_enabled` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Closure Enablement (CARE_GAP)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `charter_document` SET TAGS ('dbx_business_glossary_term' = 'Committee Charter Document (CHARTER_DOC)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (RETENTION_YRS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Effective End Date (END_DT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Effective Start Date (START_DT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation (HIPAA_NOTE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `is_cross_department` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Departmental Indicator (CROSS_DEPT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `last_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Review Outcome (REVIEW_OUTCOME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `last_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|needs_action|rejected');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency (FREQ)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|ad_hoc');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Committee Members (MEMBER_CNT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `mips_reporting` SET TAGS ('dbx_business_glossary_term' = 'MIPS Reporting Participation (MIPS_REPORT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `mips_reporting` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `mips_reporting` SET TAGS ('dbx_delta_autoOptimize_autoCompact' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `mips_reporting` SET TAGS ('dbx_quality_reporting' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `mips_reporting` SET TAGS ('dbx_mips' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `mips_reporting` SET TAGS ('dbx_cms' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Meeting Date (NEXT_MEET_DT)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Committee Purpose (PURPOSE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_code` SET TAGS ('dbx_business_glossary_term' = 'Committee Business Code (CODE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_description` SET TAGS ('dbx_business_glossary_term' = 'Committee Description (DESCRIPTION)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name (NAME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|disbanded');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type (TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_measure_scope` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Scope (MEASURE_SCOPE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_measure_scope` SET TAGS ('dbx_value_regex' = 'patient|provider|facility|system');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line (REPORT_LINE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_line` SET TAGS ('dbx_value_regex' = 'executive|board|department_head|none');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name (NAME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `code` SET TAGS ('dbx_business_glossary_term' = 'Committee Business Code (CODE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type (TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `type` SET TAGS ('dbx_value_regex' = 'clinical|operational|quality|research|compliance');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|disbanded');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Committee Description (DESCRIPTION)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Full Name (CHAIR_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Email Address (CHAIR_EMAIL)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Phone Number (CHAIR_PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ALTER COLUMN `audit_log_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Identifier (AUDIT_LOG_ID)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_delta_autoOptimize_autoCompact' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_quality_tier' = 'gold');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` ALTER COLUMN `tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` ALTER COLUMN `tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_subdomain' = 'program_oversight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_unity_catalog_tags' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_delta_tblproperties' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_hipaa_retention_annotation' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_liquid_clustering' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_rls_predicate' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` SET TAGS ('dbx_scd_type' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_subdomain' = 'population_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_unity_catalog_tags' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_delta_tblproperties' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_hipaa_retention_annotation' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_liquid_clustering' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_rls_predicate' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` SET TAGS ('dbx_scd_type' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ALTER COLUMN `rpm_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Reading Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ALTER COLUMN `therapy_session_id` SET TAGS ('dbx_business_glossary_term' = 'Therapy Session Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ALTER COLUMN `mips_reporting_id` SET TAGS ('dbx_primary_key' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ALTER COLUMN `tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ALTER COLUMN `tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` SET TAGS ('dbx_association_edges' = 'quality.measure,digital_health.rpm_program');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `program_measure_alignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Alignment ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Alignment - Measure Id');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Alignment - Rpm Program Id');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Alignment - Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Alignment Effective From');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Alignment Effective Until');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Alignment - Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `measure_weight` SET TAGS ('dbx_business_glossary_term' = 'Measure Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `program_measure_alignment_status` SET TAGS ('dbx_business_glossary_term' = 'Alignment Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Program Reporting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ALTER COLUMN `target_threshold` SET TAGS ('dbx_business_glossary_term' = 'Program Target Threshold');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` SET TAGS ('dbx_association_edges' = 'quality.measure,clinical_ai.model_card');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `measure_model_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Model Validation ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Model Validation - Model Card Id');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Validation Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Validation Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `model_role` SET TAGS ('dbx_business_glossary_term' = 'Model Role in Measure Support');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `performance_contribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Performance Contribution Weight');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` SET TAGS ('dbx_association_edges' = 'quality.measure,post_acute_care.post_acute_service');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `measure_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Applicability Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Applicability - Measure Id');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `post_acute_service_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Applicability - Post Acute Service Id');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Applicability Flag');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Applicability Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Applicability End Date');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Service-Specific Measurement Methodology');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` SET TAGS ('dbx_subdomain' = 'accreditation_compliance');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `surveyor_team_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Team Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `team_lead_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`surveyor_team` ALTER COLUMN `team_lead_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` SET TAGS ('dbx_subdomain' = 'safety_improvement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Identifier');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_executive_sponsor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_executive_sponsor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_set` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_set` ALTER COLUMN `measure_set_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Set Identifier');
