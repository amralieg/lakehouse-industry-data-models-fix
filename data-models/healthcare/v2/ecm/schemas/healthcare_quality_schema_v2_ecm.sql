-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`quality` COMMENT 'Quality measurement, patient safety, regulatory reporting, and clinical compliance. Owns HEDIS measures, CAHPS surveys, CMS quality programs (VBP - Value-Based Purchasing, MIPS, APM), HAI tracking (CLABSI, CAUTI, SSI), patient safety events, mortality reviews, CDI metrics, TJC survey readiness, CMS Conditions of Participation compliance, and accreditation management. Supports Healthy Planet population health analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure definition record.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key to the reference code set version used for this measure (e.g., ICD-10-CM 2023, CPT 2024).',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key to the compliance policy governing this HEDIS measure reporting requirement.',
    `age_range_max` STRING COMMENT 'Maximum age (in years) for the eligible population for this HEDIS measure.',
    `age_range_min` STRING COMMENT 'Minimum age (in years) for the eligible population for this HEDIS measure.',
    `allowable_gap_days` STRING COMMENT 'Number of days allowed as a gap in continuous enrollment or medication adherence for this measure.',
    `clinical_area` STRING COMMENT 'Clinical domain or specialty area for this HEDIS measure (e.g., Diabetes, Cardiovascular, Behavioral Health).',
    `collection_method` STRING COMMENT 'Data collection methodology for this measure (e.g., Administrative, Hybrid, ECDS, Survey).',
    `continuous_enrollment_days` STRING COMMENT 'Number of days of continuous health plan enrollment required for measure eligibility.',
    `cpt_code_list` STRING COMMENT 'Comma-separated list of CPT codes used in the measure numerator or denominator logic.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HEDIS measure record was created in the system.',
    `denominator_definition` STRING COMMENT 'Textual definition of the measure denominator (eligible population) per NCQA specifications.',
    `domain_category` STRING COMMENT 'HEDIS domain category (e.g., Effectiveness of Care, Access/Availability of Care, Experience of Care, Utilization).',
    `effective_end_date` DATE COMMENT 'Date when this HEDIS measure version is no longer effective or was retired.',
    `effective_start_date` DATE COMMENT 'Date when this HEDIS measure version became effective for reporting.',
    `eligible_population_description` STRING COMMENT 'Narrative description of the eligible population for this HEDIS measure.',
    `exception_criteria` STRING COMMENT 'Criteria for denominator exceptions (patients removed from the denominator due to valid clinical reasons).',
    `exclusion_criteria` STRING COMMENT 'Criteria for denominator exclusions (patients removed from the denominator for administrative or clinical reasons).',
    `hedis_ecqm_code` STRING COMMENT 'Electronic Clinical Quality Measure (eCQM) code if this HEDIS measure has an eCQM equivalent.',
    `hybrid_medical_record_required` BOOLEAN COMMENT 'Flag indicating whether hybrid methodology (administrative + medical record review) is required for this measure.',
    `icd10_code_list` STRING COMMENT 'Comma-separated list of ICD-10 diagnosis codes used in the measure logic.',
    `loinc_code_list` STRING COMMENT 'Comma-separated list of LOINC codes for lab tests or observations used in the measure.',
    `measure_code` STRING COMMENT 'Official NCQA HEDIS measure code (e.g., CBP, CDC, COL, BCS).',
    `measure_name` STRING COMMENT 'Full official name of the HEDIS measure per NCQA specifications.',
    `measure_short_name` STRING COMMENT 'Abbreviated or short name for the HEDIS measure.',
    `measure_status` STRING COMMENT 'Current status of the measure (e.g., Active, Retired, Under Review, Proposed).',
    `measure_type` STRING COMMENT 'Type of measure (e.g., Process, Outcome, Intermediate Outcome, Structural).',
    `measure_version` STRING COMMENT 'Version number of the HEDIS measure specification (e.g., HEDIS MY 2024).',
    `measurement_year` STRING COMMENT 'Calendar year for which this HEDIS measure is being reported (e.g., 2024).',
    `minimum_performance_threshold` DECIMAL(18,2) COMMENT 'Minimum performance rate threshold for this measure to be considered compliant or reportable.',
    `mips_eligible` BOOLEAN COMMENT 'Flag indicating whether this HEDIS measure is also eligible for MIPS (Merit-based Incentive Payment System) reporting.',
    `national_average_rate` DECIMAL(18,2) COMMENT 'National average performance rate for this HEDIS measure across all reporting health plans.',
    `national_benchmark_rate` DECIMAL(18,2) COMMENT 'National benchmark performance rate (e.g., 90th percentile) for this HEDIS measure.',
    `ncqa_program` STRING COMMENT 'NCQA program or accreditation type for which this measure is required (e.g., Health Plan Accreditation, PCMH).',
    `ncqa_specification_url` STRING COMMENT 'URL to the official NCQA technical specification document for this measure.',
    `notes` STRING COMMENT 'Additional notes or comments about this HEDIS measure configuration or reporting requirements.',
    `numerator_definition` STRING COMMENT 'Textual definition of the measure numerator (patients who met the measure criteria) per NCQA specifications.',
    `performance_rate_direction` DECIMAL(18,2) COMMENT 'Direction of desired performance (e.g., Higher is Better, Lower is Better).',
    `product_line` STRING COMMENT 'Health plan product line for which this measure applies (e.g., Commercial, Medicare, Medicaid).',
    `reporting_period_end_date` DATE COMMENT 'End date of the measurement period for this HEDIS measure.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the measurement period for this HEDIS measure.',
    `reporting_submission_deadline` DATE COMMENT 'Deadline date for submitting HEDIS measure results to NCQA or the health plan.',
    `responsible_program` STRING COMMENT 'Internal program or department responsible for this HEDIS measure reporting.',
    `stratification_criteria` STRING COMMENT 'Criteria for stratifying measure results (e.g., by age group, race/ethnicity, product line).',
    `stratification_required` BOOLEAN COMMENT 'Flag indicating whether stratified reporting is required for this measure.',
    `target_performance_rate` DECIMAL(18,2) COMMENT 'Internal target performance rate goal for this HEDIS measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HEDIS measure record was last updated.',
    `value_set_oid` STRING COMMENT 'Object Identifier (OID) for the VSAC value set used in this measure logic.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'HEDIS (Healthcare Effectiveness Data and Information Set) measure definitions from NCQA, including eligibility criteria, numerator/denominator logic, value sets, and reporting specifications for health plan quality measurement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'Unique identifier for the HEDIS measure result record.',
    `care_site_id` BIGINT COMMENT 'Foreign key to the care site where this HEDIS measure was calculated.',
    `claim_id` BIGINT COMMENT 'Foreign key to a representative claim used in the HEDIS measure calculation.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key to the regulatory submission record for this HEDIS result.',
    `cost_center_id` BIGINT COMMENT 'Foreign key to the cost center responsible for this HEDIS measure reporting.',
    `drg_id` BIGINT COMMENT 'Foreign key to a DRG code relevant to this HEDIS measure result.',
    `health_plan_id` BIGINT COMMENT 'Foreign key to the health plan for which this HEDIS result was calculated.',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key to the HEDIS measure definition for which this result was calculated.',
    `interface_channel_id` BIGINT COMMENT 'Foreign key to the interface channel used to submit this HEDIS result to NCQA or the health plan.',
    `org_provider_id` BIGINT COMMENT 'Foreign key to the organization provider responsible for this HEDIS measure result.',
    `audit_status` STRING COMMENT 'Status of external audit or validation of this HEDIS result (e.g., Pending, Audited, Validated, Discrepancy Found).',
    `auditor_organization` STRING COMMENT 'Name of the external auditor or validation organization that reviewed this HEDIS result.',
    `benchmark_comparison_result` STRING COMMENT 'Result of comparing this HEDIS performance rate to national benchmarks (e.g., Above Benchmark, Below Benchmark, At Benchmark).',
    `calculation_run_timestamp` TIMESTAMP COMMENT 'Timestamp when the HEDIS measure calculation was executed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HEDIS result record was created.',
    `data_source_type` STRING COMMENT 'Type of data source used for this HEDIS result (e.g., Administrative, Hybrid, ECDS, Survey).',
    `denominator_count` STRING COMMENT 'Number of patients in the eligible population (denominator) for this HEDIS measure.',
    `exception_count` STRING COMMENT 'Number of patients removed from the denominator due to valid exceptions.',
    `exclusion_count` STRING COMMENT 'Number of patients removed from the denominator due to exclusions.',
    `gap_count` STRING COMMENT 'Number of patients in the denominator who did not meet the numerator criteria (care gaps).',
    `hybrid_sample_size` STRING COMMENT 'Sample size for hybrid methodology medical record review.',
    `hybrid_supplemental_data_used` BOOLEAN COMMENT 'Flag indicating whether supplemental data from medical record review was used in the hybrid calculation.',
    `initial_population_count` STRING COMMENT 'Number of patients in the initial population before applying exclusions and exceptions.',
    `is_reportable` BOOLEAN COMMENT 'Flag indicating whether this HEDIS result meets minimum reporting thresholds and is reportable to NCQA.',
    `is_starred_measure` BOOLEAN COMMENT 'Flag indicating whether this is a starred HEDIS measure (weighted more heavily in NCQA accreditation scoring).',
    `measurement_year` STRING COMMENT 'Calendar year for which this HEDIS result was calculated (e.g., 2024).',
    `methodology_type` STRING COMMENT 'Methodology used for this HEDIS result (e.g., Administrative, Hybrid, ECDS).',
    `mips_quality_category` STRING COMMENT 'MIPS quality category if this HEDIS measure is also reported for MIPS.',
    `ncqa_benchmark_percentile_50` DECIMAL(18,2) COMMENT 'NCQA 50th percentile benchmark rate for this HEDIS measure.',
    `ncqa_benchmark_percentile_90` DECIMAL(18,2) COMMENT 'NCQA 90th percentile benchmark rate for this HEDIS measure.',
    `numerator_count` STRING COMMENT 'Number of patients who met the HEDIS measure criteria (numerator).',
    `performance_rate` DECIMAL(18,2) COMMENT 'Calculated performance rate for this HEDIS measure (numerator / denominator).',
    `prior_year_performance_rate` DECIMAL(18,2) COMMENT 'Performance rate for this HEDIS measure in the prior measurement year.',
    `product_line` STRING COMMENT 'Health plan product line for this HEDIS result (e.g., Commercial, Medicare, Medicaid).',
    `rate_change_from_prior_year` DECIMAL(18,2) COMMENT 'Change in performance rate compared to the prior measurement year.',
    `reporting_period_end_date` DATE COMMENT 'End date of the measurement period for this HEDIS result.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the measurement period for this HEDIS result.',
    `result_identifier` STRING COMMENT 'Unique identifier or code for this HEDIS result submission.',
    `result_notes` STRING COMMENT 'Additional notes or comments about this HEDIS result.',
    `result_version` STRING COMMENT 'Version number of this HEDIS result (incremented for resubmissions or corrections).',
    `star_rating_weight` DECIMAL(18,2) COMMENT 'Weight of this HEDIS measure in the overall Star Rating calculation.',
    `stratification_category` STRING COMMENT 'Stratification category for this HEDIS result (e.g., Age Group, Race/Ethnicity, Product Line).',
    `submission_date` DATE COMMENT 'Date when this HEDIS result was submitted to NCQA or the health plan.',
    `submission_status` STRING COMMENT 'Status of the HEDIS result submission (e.g., Draft, Submitted, Accepted, Rejected).',
    `submission_target` STRING COMMENT 'Target recipient of the HEDIS result submission (e.g., NCQA, CMS, Health Plan).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HEDIS result record was last updated.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'Calculated HEDIS measure results for a specific health plan, product line, and measurement year, including numerator/denominator counts, performance rates, gap counts, and submission status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` (
    `cahps_survey_id` BIGINT COMMENT 'Unique identifier for the CAHPS survey administration record.',
    `care_site_id` BIGINT COMMENT 'Foreign key to the care site where the patient received care and was surveyed.',
    `clinician_id` BIGINT COMMENT 'Foreign key to the clinician who provided care to the patient (for clinician-specific CAHPS surveys).',
    `health_plan_id` BIGINT COMMENT 'Foreign key to the health plan for which this CAHPS survey was administered.',
    `interface_channel_id` BIGINT COMMENT 'Foreign key to the interface channel used to submit CAHPS survey results to CMS or the survey vendor.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key to the patient MPI record for the survey respondent.',
    `consent_record_id` BIGINT COMMENT 'Foreign key to the consent record authorizing use of patient contact information for survey administration.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key to the research subject enrollment if this CAHPS survey is part of a research study.',
    `unit_id` BIGINT COMMENT 'Foreign key to the hospital unit where the patient received care.',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter/visit for which this CAHPS survey was administered.',
    `administration_mode` DECIMAL(18,2) COMMENT 'Mode of survey administration (e.g., Mail, Phone, Web, Mixed Mode).',
    `cms_certification_number` STRING COMMENT 'CMS Certification Number (CCN) for the hospital or facility.',
    `cms_submission_date` DATE COMMENT 'Date when CAHPS survey results were submitted to CMS.',
    `cms_submission_status` STRING COMMENT 'Status of the CMS submission (e.g., Submitted, Accepted, Rejected, Pending).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAHPS survey record was created.',
    `discharge_date` DATE COMMENT 'Date when the patient was discharged from the hospital (for HCAHPS surveys).',
    `eligible_discharges` STRING COMMENT 'Number of eligible discharges in the sampling frame for this CAHPS survey period.',
    `exclusion_reason` STRING COMMENT 'Reason for excluding this patient from the CAHPS survey sample (e.g., Deceased, No Contact Information, Court/Supervisory Care).',
    `hcahps_linear_mean_score` DECIMAL(18,2) COMMENT 'HCAHPS linear mean score across all survey dimensions for this patient.',
    `minimum_case_threshold_met` BOOLEAN COMMENT 'Flag indicating whether the minimum case threshold for public reporting was met.',
    `mode_adjustment_applied` BOOLEAN COMMENT 'Flag indicating whether mode adjustment was applied to the survey results.',
    `overall_hospital_rating` STRING COMMENT 'Patients overall rating of the hospital on a 0-10 scale.',
    `patient_mix_adjustment_applied` BOOLEAN COMMENT 'Flag indicating whether patient mix adjustment was applied to the survey results.',
    `publicly_reported` BOOLEAN COMMENT 'Flag indicating whether this CAHPS survey result is publicly reported on Hospital Compare or other public platforms.',
    `recommend_hospital` STRING COMMENT 'Patients response to whether they would recommend the hospital to friends and family (e.g., Definitely Yes, Probably Yes, Probably No, Definitely No).',
    `reporting_period_end` DATE COMMENT 'End date of the CAHPS survey reporting period.',
    `reporting_period_start` DATE COMMENT 'Start date of the CAHPS survey reporting period.',
    `response_date` DATE COMMENT 'Date when the patient completed and returned the CAHPS survey.',
    `response_language` STRING COMMENT 'Language in which the patient completed the survey (e.g., English, Spanish).',
    `response_received` BOOLEAN COMMENT 'Flag indicating whether a response was received from the patient.',
    `sample_size` STRING COMMENT 'Number of patients sampled for this CAHPS survey period.',
    `sampling_methodology` STRING COMMENT 'Sampling methodology used for this CAHPS survey (e.g., Random, Systematic, Stratified).',
    `score_care_transition` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Care Transition domain.',
    `score_cleanliness` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Cleanliness of Hospital Environment domain.',
    `score_communication_doctors` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Communication with Doctors domain.',
    `score_communication_medicines` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Communication about Medicines domain.',
    `score_communication_nurses` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Communication with Nurses domain.',
    `score_discharge_information` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Discharge Information domain.',
    `score_pain_management` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Pain Management domain.',
    `score_quietness` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Quietness of Hospital Environment domain.',
    `score_responsiveness_staff` DECIMAL(18,2) COMMENT 'HCAHPS composite score for Responsiveness of Hospital Staff domain.',
    `star_rating` STRING COMMENT 'Overall HCAHPS Star Rating for the hospital (1-5 stars).',
    `survey_followup_date` DATE COMMENT 'Date when a follow-up survey contact was made (for phone or mixed-mode surveys).',
    `survey_mailed_date` DATE COMMENT 'Date when the survey was mailed to the patient.',
    `survey_program_code` STRING COMMENT 'Code identifying the CAHPS survey program (e.g., HCAHPS, CAHPS Clinician & Group, CAHPS Health Plan).',
    `survey_status` STRING COMMENT 'Status of the survey (e.g., Mailed, Completed, Non-Response, Excluded).',
    `survey_type` STRING COMMENT 'Type of CAHPS survey (e.g., HCAHPS, CAHPS Clinician & Group, CAHPS Health Plan).',
    `survey_version` STRING COMMENT 'Version of the CAHPS survey instrument used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAHPS survey record was last updated.',
    `vbp_patient_experience_score` DECIMAL(18,2) COMMENT 'Value-Based Purchasing (VBP) Patient Experience of Care domain score derived from HCAHPS.',
    `vendor_certification_number` STRING COMMENT 'Certification number of the CAHPS survey vendor.',
    `vendor_name` STRING COMMENT 'Name of the CAHPS survey vendor or survey administration company.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_cahps_survey PRIMARY KEY(`cahps_survey_id`)
) COMMENT 'CAHPS (Consumer Assessment of Healthcare Providers and Systems) survey administration records, including HCAHPS hospital surveys, capturing patient experience data, survey methodology, response rates, and composite scores.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` (
    `cahps_response_id` BIGINT COMMENT 'Unique surrogate identifier for each individual CAHPS survey response record in the silver layer lakehouse. Primary key for this transactional entity.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Individual survey responses must tie to patients active coverage at service time for accurate payer-specific satisfaction scoring. Replaces denormalized payer_type with proper FK to coverage, enablin',
    `cahps_survey_id` BIGINT COMMENT 'Reference to the specific CAHPS survey instrument version administered to the patient. Links to the survey definition including question set, version, and CMS program year.',
    `care_site_id` BIGINT COMMENT 'Reference to the hospital or care facility where the patient received care. Used for facility-level HCAHPS reporting to CMS and internal benchmarking.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Individual CAHPS responses roll up to plan-level scores for CMS Star Ratings and public reporting. Payer type on response determines applicable measure set and benchmarks.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who completed or was sampled for the CAHPS survey. Links to the patient master record. Protected Health Information (PHI) under HIPAA.',
    `record_cahps_survey_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Individual survey responses must be traceable to consent documentation for vendor certification and regulatory audits. CMS requires consent verification at response level for publicly reported HCAHPS ',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or outpatient encounter that triggered the CAHPS survey sampling. Used to link survey responses back to the clinical episode for Value-Based Purchasing (VBP) reporting.',
    `adjusted_composite_score` DECIMAL(18,2) COMMENT 'The overall case-mix and mode-adjusted HCAHPS composite score for this response, calculated per CMS linear mean scoring methodology. Adjusts for patient mix differences (age, education, health status, service category, language) to enable fair hospital comparisons.',
    `administration_mode` DECIMAL(18,2) COMMENT 'The method used to administer the CAHPS survey to the patient. CMS-approved modes include mail, telephone, mail with telephone follow-up, active interactive voice response (IVR), and web. Affects response rate benchmarking and mode adjustment factors.',
    `care_transition_score` STRING COMMENT 'Patient-reported composite score for the Care Transition domain. Derived from questions about whether staff took patient preferences into account, understood the purpose of medications, and knew what to do if concerned after discharge. Scored on a 0–100 scale.',
    `cms_certification_number` STRING COMMENT 'The six-digit CMS Certification Number (CCN) identifying the hospital for HCAHPS submission to the CMS Quality Net portal. Required for regulatory reporting.. Valid values are `^[0-9]{6}$`',
    `contact_attempt_count` STRING COMMENT 'The total number of contact attempts made to the patient by the survey vendor (mailings sent, telephone calls placed). Used to document vendor compliance with CMS minimum contact attempt requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CAHPS response record was first created in the silver layer lakehouse. Supports audit trail and data lineage requirements per HIPAA and HITRUST CSF.',
    `discharge_date` DATE COMMENT 'The date the patient was discharged from the inpatient encounter that triggered the CAHPS survey. CMS requires surveys to be administered between 48 hours and 6 weeks post-discharge.',
    `discharge_information_score` STRING COMMENT 'Patient-reported composite score for the Discharge Information domain. Derived from questions about whether patients received written information about symptoms to watch for and understood their care responsibilities after discharge. Scored on a 0–100 scale.',
    `doctor_communication_score` STRING COMMENT 'Patient-reported composite score for the Communication with Doctors domain of the HCAHPS survey. Derived from questions about how often doctors communicated clearly, listened carefully, and explained things in an understandable way. Scored on a 0–100 scale per CMS methodology.',
    `education_level` STRING COMMENT 'Patients self-reported highest level of education completed as captured on the CAHPS survey. Used as a case-mix adjustment covariate in CMS HCAHPS linear mean score methodology. [ENUM-REF-CANDIDATE: 8th_grade_or_less|some_high_school|high_school_graduate|some_college|4_year_college_graduate|more_than_4_year_college — promote to reference product]. Valid values are `8th_grade_or_less|some_high_school|high_school_graduate|some_college|4_year_college_graduate|more_than_4_year_college`',
    `first_contact_date` DATE COMMENT 'The date of the first survey contact attempt (initial mailing or first telephone call) made to the patient. Used to track the survey administration timeline and compliance with CMS contact windows.',
    `hospital_environment_score` STRING COMMENT 'Patient-reported composite score for the Hospital Environment domain covering cleanliness and quietness of the hospital environment. Scored on a 0–100 scale per CMS HCAHPS methodology.',
    `ineligibility_reason` STRING COMMENT 'The specific reason a patient was excluded from the HCAHPS survey sampling frame. Populated only when is_eligible is False. Used for sampling frame documentation and CMS audit compliance.. Valid values are `age_under_18|psychiatric_admission|excluded_drg|no_overnight_stay|court_ordered|other`',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the patient met all CMS eligibility criteria for HCAHPS survey inclusion (e.g., age 18+, non-psychiatric admission, non-excluded diagnosis, minimum one-night stay). Ineligible patients are excluded from the sampling frame.',
    `is_sampled` BOOLEAN COMMENT 'Indicates whether the eligible patient was selected into the HCAHPS survey sample for the reporting period. Hospitals may use census or random sampling per CMS guidelines.',
    `language_of_response` STRING COMMENT 'The ISO 639-2 three-letter language code indicating the language in which the patient completed the CAHPS survey. CMS requires survey vendors to offer surveys in multiple languages. Used for language-stratified response rate analysis.. Valid values are `^[A-Z]{3}$`',
    `length_of_stay_days` STRING COMMENT 'The number of inpatient days for the encounter associated with this survey. Used as a case-mix adjustment covariate in HCAHPS linear mean score calculations per CMS methodology.',
    `medicine_communication_score` STRING COMMENT 'Patient-reported composite score for the Communication About Medicines domain. Derived from questions about how often staff explained the purpose of new medications and described possible side effects. Scored on a 0–100 scale per CMS methodology.',
    `mrn` STRING COMMENT 'The Medical Record Number assigned to the patient in the source Electronic Health Record (EHR) system. Used for survey sampling frame construction and de-duplication. PHI under HIPAA.',
    `nurse_communication_score` STRING COMMENT 'Patient-reported composite score for the Communication with Nurses domain of the HCAHPS survey. Derived from questions about how often nurses communicated clearly, listened carefully, and explained things in an understandable way. Scored on a 0–100 scale per CMS methodology.',
    `overall_hospital_rating` STRING COMMENT 'Patients overall rating of the hospital on a 0–10 numeric scale as reported on the HCAHPS survey. A key individual measure used in CMS VBP Patient Experience of Care domain scoring.',
    `pain_management_score` STRING COMMENT 'Patient-reported composite score for the Pain Management domain. Derived from questions about how often staff did everything they could to help with pain and how often pain was well controlled. Scored on a 0–100 scale. Note: CMS removed this domain from VBP scoring in 2018 due to opioid concerns; retained for historical trending.',
    `patient_service_line` STRING COMMENT 'The clinical service line associated with the patients inpatient stay (e.g., cardiology, orthopedics, oncology, obstetrics). Used for service-line-level HCAHPS performance stratification and internal benchmarking.',
    `program_year` STRING COMMENT 'The CMS fiscal year for which this CAHPS response contributes to Value-Based Purchasing (VBP) performance scoring and MIPS quality reporting.',
    `recommend_hospital` STRING COMMENT 'Patients response to the HCAHPS question asking whether they would recommend the hospital to friends and family. One of four ordinal response options. Used in CMS VBP Patient Experience of Care domain.. Valid values are `definitely_yes|probably_yes|probably_no|definitely_no`',
    `reporting_quarter` STRING COMMENT 'The CMS reporting quarter in which this survey response is included for HCAHPS public reporting and Value-Based Purchasing (VBP) scoring. Format: YYYYQn (e.g., 2024Q1).. Valid values are `^[0-9]{4}Q[1-4]$`',
    `response_date` DATE COMMENT 'The date on which the patient completed and returned the CAHPS survey. Used to determine the survey reporting period and CMS submission quarter.',
    `response_status` STRING COMMENT 'The disposition of the survey attempt indicating whether the patient completed the survey or the reason for non-response. Used for response rate calculation and CMS non-response bias analysis.. Valid values are `completed|non_response|ineligible|deceased|bad_address|language_barrier`',
    `sampling_date` DATE COMMENT 'The date the patient was selected into the CAHPS survey sample from the eligible discharge population. Used for sampling frame documentation and CMS audit trail.',
    `self_reported_health_status` STRING COMMENT 'Patients self-reported general health status as captured on the CAHPS survey. Used as a case-mix adjustment covariate in CMS HCAHPS linear mean score methodology to account for patient mix differences across hospitals.. Valid values are `excellent|very_good|good|fair|poor`',
    `service_category` STRING COMMENT 'The CMS-defined patient service category for the inpatient stay: Medical, Surgical, or Maternity. Used as a case-mix adjustment variable in HCAHPS scoring and for CMS VBP stratified reporting.. Valid values are `medical|surgical|maternity`',
    `staff_responsiveness_score` STRING COMMENT 'Patient-reported composite score for the Responsiveness of Hospital Staff domain. Derived from questions about how often patients received help as soon as they wanted when using the call button or needing to use the bathroom. Scored on a 0–100 scale.',
    `survey_type` STRING COMMENT 'The specific CAHPS instrument type administered. HCAHPS is the Hospital Consumer Assessment of Healthcare Providers and Systems used for CMS VBP reporting. Other types support outpatient and specialty settings. [ENUM-REF-CANDIDATE: HCAHPS|CGCAHPS|PCMH_CAHPS|ED_CAHPS|OAS_CAHPS|ICH_CAHPS — promote to reference product]. Valid values are `HCAHPS|CGCAHPS|PCMH_CAHPS|ED_CAHPS|OAS_CAHPS`',
    `top_box_doctor_communication` BOOLEAN COMMENT 'Indicates whether the patient provided the most favorable (top-box) response for the Communication with Doctors composite domain. CMS VBP scoring uses top-box percentage rates across the patient population.',
    `top_box_nurse_communication` BOOLEAN COMMENT 'Indicates whether the patient provided the most favorable (top-box) response for the Communication with Nurses composite domain. Used in CMS VBP Patient Experience of Care domain top-box rate calculation.',
    `top_box_overall_rating` BOOLEAN COMMENT 'Indicates whether the patient gave an overall hospital rating of 9 or 10 (top-box threshold per CMS methodology). Used in CMS VBP Patient Experience of Care domain scoring.',
    `top_box_recommend` BOOLEAN COMMENT 'Indicates whether the patient responded Definitely Yes to the hospital recommendation question (top-box threshold per CMS methodology). Used in CMS VBP Patient Experience of Care domain scoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CAHPS response record was last modified in the silver layer lakehouse. Used for incremental load processing and audit trail compliance.',
    `vbp_patient_experience_score` DECIMAL(18,2) COMMENT 'The individual patient-level contribution score to the CMS Value-Based Purchasing (VBP) Patient Experience of Care domain, calculated from HCAHPS composite and global measures per CMS scoring methodology.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_cahps_response PRIMARY KEY(`cahps_response_id`)
) COMMENT 'Individual patient responses to CAHPS surveys.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` (
    `patient_safety_event_id` BIGINT COMMENT 'Unique surrogate identifier for the patient safety event record. Primary key for this data product.',
    `bed_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.bed_assignment. Business justification: Safety events (falls, pressure ulcers, HAIs, medication errors) are location-specific and tied to bed assignments. Real business process: Safety investigations document which bed/unit was active when ',
    `bed_id` BIGINT COMMENT 'Foreign key linking to facility.bed. Business justification: Bed-level tracking essential for falls (bed type, low-bed status), pressure injuries (bariatric capability, air-fluidized beds), and patient identification errors. Risk management and quality teams an',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, clinic, outpatient center) where the patient safety event occurred. Supports multi-facility enterprise reporting and CMS Conditions of Participation compliance.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or staff member who initially reported the patient safety event. Used for follow-up and reporter acknowledgment workflows.',
    `contrast_admin_id` BIGINT COMMENT 'Foreign key linking to radiology.contrast_admin. Business justification: Contrast administration adverse reactions (extravasation, anaphylaxis, contrast-induced nephropathy) are reportable safety events. Event investigation requires linking to the administration record for',
    `critical_result_id` BIGINT COMMENT 'Foreign key linking to radiology.critical_result. Business justification: Critical finding notification failures are sentinel events under TJC standards. Safety event tracking must link to the specific critical result notification to measure compliance with read-back and ac',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: TJC sentinel event standards require documented patient/family consent before disclosure of safety event details. Disclosure_status field indicates when consent is needed; this links to the actual con',
    `environmental_service_request_id` BIGINT COMMENT 'Foreign key linking to facility.environmental_service_request. Business justification: Healthcare-acquired infections linked to environmental cleaning failures require EVS request tracking. Infection prevention teams investigate cleaning protocol compliance, disinfectant product used, a',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to facility.equipment_asset. Business justification: Device-related adverse events (infusion pump programming errors, ventilator malfunctions, defibrillator failures) require equipment asset linkage for FDA MedWatch reporting, manufacturer recall tracki',
    `hazardous_material_id` BIGINT COMMENT 'Foreign key linking to facility.hazardous_material. Business justification: Hazardous material exposure events (chemotherapy spills, radioactive material incidents, chemical burns) require hazmat inventory linkage for OSHA reporting, EPA notification, and SDS documentation. S',
    `hotline_report_id` BIGINT COMMENT 'Foreign key linking to compliance.hotline_report. Business justification: Patient safety events are frequently reported through compliance hotlines by staff, patients, or families. Linking events to originating hotline reports enables tracking of allegation investigation, r',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Imaging orders trigger safety events (wrong-site imaging, contrast reactions, radiation overexposure). TJC and CMS require linking safety events to originating orders for root cause analysis and corre',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to compliance.investigation. Business justification: Patient safety events trigger formal compliance investigations to determine regulatory violations, root causes, disclosure requirements, and potential sanctions. Investigations assess whether events c',
    `maintenance_order_id` BIGINT COMMENT 'Foreign key linking to facility.maintenance_order. Business justification: Equipment failure-related adverse events (HVAC failures causing temperature excursions, medical gas system failures, emergency generator failures during procedures) require maintenance work order link',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Patient safety events frequently involve specific medical devices or supplies (defective equipment, wrong item administered). FDA adverse event reporting and root cause analysis require tracking which',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient involved in the safety event. Links to the Master Patient Index (MPI) record. Protected Health Information (PHI) under HIPAA.',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Surgical safety events (retained foreign objects, wrong-site surgery, surgical site infections) require OR suite linkage for environmental factor analysis (laminar airflow failures, sterilization issu',
    `employee_id` BIGINT COMMENT 'Reference to the risk management staff member assigned to oversee this patient safety event, coordinate disclosure, and manage potential liability. Supports risk management workflow and accountability.',
    `dose_record_id` BIGINT COMMENT 'Foreign key linking to radiology.dose_record. Business justification: Radiation overexposure incidents (dose alert threshold breaches, cumulative dose concerns) are patient safety events requiring investigation. Safety event reporting must link to the dose record for ph',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.study. Business justification: Imaging studies are direct sources of safety events (equipment malfunction, patient falls during scan, adverse reactions). Safety event investigation and regulatory reporting require study-level trace',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Room-level precision critical for healthcare-acquired infection tracking, environmental hazard analysis (negative pressure room failures), and room-specific safety interventions. Infection prevention ',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Safety events in research subjects trigger dual reporting: institutional patient safety system AND research adverse event reporting to IRB/sponsor/FDA. Linkage enables proper classification, expedited',
    `triage_assessment_id` BIGINT COMMENT 'Foreign key linking to encounter.triage_assessment. Business justification: Safety events (treatment delays, missed diagnoses, deterioration) often originate in ED triage. Real business process: Safety event investigations trace back to triage assessment for root cause analys',
    `udi_record_id` BIGINT COMMENT 'Foreign key linking to supply.udi_record. Business justification: When safety events involve implantable devices, linking to the specific UDI record provides complete device traceability required by FDA MedWatch reporting and enables correlation with manufacturer re',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (Admit-Discharge-Transfer event) during which the patient safety event occurred. Supports linkage to Admit Discharge Transfer (ADT) data for context.',
    `action_plan_completion_date` DATE COMMENT 'Actual date on which all corrective action plan items were completed and implemented. Used to confirm closure of the safety event lifecycle.',
    `action_plan_due_date` DATE COMMENT 'Target date by which all corrective action plan items must be completed. Submitted to TJC as part of the sentinel event response package.',
    `action_plan_status` STRING COMMENT 'Current completion status of the corrective action plan. Tracks progress from initiation through implementation and effectiveness verification. Drives quality management follow-up workflows.. Valid values are `not_started|in_progress|completed|overdue|verified`',
    `action_plan_summary` STRING COMMENT 'Narrative summary of the corrective action plan developed in response to the root cause analysis findings. Describes systemic changes, process improvements, and preventive measures to be implemented.',
    `confidentiality_indicator` BOOLEAN COMMENT 'Indicates whether this safety event record is protected under peer review or quality assurance confidentiality statutes, which may restrict discoverability in legal proceedings. Varies by state law.',
    `contributing_factors_summary` STRING COMMENT 'Narrative summary of the contributing factors identified at the time of initial event report, prior to formal Root Cause Analysis (RCA). May be updated as investigation progresses. Supports early causal analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient safety event record was first created in the data system. Audit trail field for data governance and HIPAA compliance.',
    `disclosure_date` DATE COMMENT 'Date on which the patient and/or family were formally informed of the safety event and its circumstances. Required for TJC accreditation and CMS Conditions of Participation compliance.',
    `disclosure_status` STRING COMMENT 'Status of the patient and/or family disclosure process for this safety event. Tracks whether disclosure has been completed per TJC and CMS requirements for transparent communication of unanticipated outcomes.. Valid values are `not_required|pending|disclosed|declined_by_patient`',
    `effectiveness_verification_date` DATE COMMENT 'Date on which the effectiveness of the corrective action plan was formally verified and documented. Confirms that implemented changes achieved the intended safety improvement. Required for TJC sentinel event closure.',
    `effectiveness_verified` BOOLEAN COMMENT 'Indicates whether the corrective action plan has been formally verified as effective in preventing recurrence of the safety event. Required for TJC sentinel event final closure.',
    `event_category` STRING COMMENT 'Standardized category of the safety event per AHRQ Common Formats taxonomy (e.g., medication or other substance, fall, pressure ulcer, surgery or anesthesia, healthcare-associated infection, perinatal, device or medical/surgical supply, blood or blood product, environment or infrastructure). [ENUM-REF-CANDIDATE: medication_or_substance|fall|pressure_ulcer|surgery_or_anesthesia|healthcare_associated_infection|perinatal|device_or_supply|blood_or_blood_product|environment_or_infrastructure|other — promote to reference product]',
    `event_description` STRING COMMENT 'Free-text narrative description of what occurred during the patient safety event, including the sequence of events, conditions at the time, and immediate context. Contains Protected Health Information (PHI). Used in Root Cause Analysis (RCA) and regulatory reporting.',
    `event_number` STRING COMMENT 'Externally-known, human-readable identifier assigned to the safety event at time of report (e.g., PSE-2024-00342). Used for cross-system reference, regulatory submissions, and communication with TJC or CMS.',
    `event_status` STRING COMMENT 'Current lifecycle status of the patient safety event from initial report through investigation closure. Drives workflow routing in the safety event management system.. Valid values are `reported|under_review|rca_in_progress|action_plan_active|closed|voided`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the patient safety event actually occurred (real-world event time). Distinct from the report timestamp. Critical for timeline reconstruction during Root Cause Analysis (RCA).',
    `event_type` STRING COMMENT 'Classification of the safety event by severity tier. Sentinel events require TJC review and root cause analysis (RCA). Near misses and unsafe conditions support proactive safety culture. [ENUM-REF-CANDIDATE: sentinel_event|serious_safety_event|near_miss|unsafe_condition|no_harm_event — promote to reference product if additional types are needed]. Valid values are `sentinel_event|serious_safety_event|near_miss|unsafe_condition|no_harm_event`',
    `hai_event_type` STRING COMMENT 'If the safety event involves a Healthcare-Associated Infection (HAI), specifies the HAI type: Central Line-Associated Bloodstream Infection (CLABSI), Catheter-Associated Urinary Tract Infection (CAUTI), Surgical Site Infection (SSI), Ventilator-Associated Pneumonia (VAP), C. difficile (CDIFF), or none. Supports CDC NHSN reporting.. Valid values are `CLABSI|CAUTI|SSI|VAP|CDIFF|none`',
    `harm_level_code` STRING COMMENT 'Harm level assigned to the event using the National Coordinating Council for Medication Error Reporting and Prevention (NCC MERP) index or equivalent Severity of Harm scale. Categories A–I represent no harm through death. Values A–F shown; full scale: [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I — promote to reference product]. Valid values are `A|B|C|D|E|F`',
    `harm_level_description` STRING COMMENT 'Human-readable description of the harm level assigned (e.g., Reached the patient and required intervention to preclude harm, Contributed to or resulted in permanent patient harm). Complements the NCC MERP code for reporting and disclosure.',
    `immediate_actions_taken` STRING COMMENT 'Free-text description of the immediate clinical and administrative actions taken at the time of the event to mitigate harm (e.g., medication reversal, code response, physician notification, patient transfer). Captured at time of initial report.',
    `is_cms_reportable` BOOLEAN COMMENT 'Indicates whether this event must be reported to the Centers for Medicare and Medicaid Services (CMS) under Conditions of Participation or Value-Based Purchasing (VBP) quality reporting requirements.',
    `is_sentinel_event` BOOLEAN COMMENT 'Indicates whether this patient safety event meets The Joint Commission (TJC) definition of a sentinel event requiring formal review and root cause analysis submission. Drives TJC reporting workflow.',
    `is_state_reportable` BOOLEAN COMMENT 'Indicates whether this event must be reported to the applicable State Department of Health under mandatory adverse event reporting laws. State reporting requirements vary by jurisdiction.',
    `location_unit` STRING COMMENT 'Clinical unit or department where the patient safety event occurred (e.g., ICU, ED, OR, Medical-Surgical Unit, Pharmacy). Supports unit-level safety performance analysis and TJC survey readiness.',
    `patient_outcome` STRING COMMENT 'Clinical outcome experienced by the patient as a result of the safety event. Drives regulatory reporting obligations and sentinel event classification. Contains Protected Health Information (PHI).. Valid values are `no_harm|temporary_harm|permanent_harm|required_intervention|death|unknown`',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the patient safety event was formally reported into the safety event management system. Used to calculate reporting lag and compliance with internal reporting windows.',
    `review_completion_date` DATE COMMENT 'Actual date on which the formal investigation review was completed and findings were finalized. Used to calculate compliance with TJC 45-day RCA completion requirement.',
    `review_due_date` DATE COMMENT 'Target completion date for the formal investigation review. For TJC sentinel events, this is typically 45 days from event identification. Drives escalation and compliance tracking.',
    `review_start_date` DATE COMMENT 'Date on which the formal investigation review (RCA, ACA, or peer review) was initiated. TJC requires RCA completion within 45 days of sentinel event identification.',
    `review_team_members` STRING COMMENT 'Comma-separated list of names or role titles of individuals who participated in the formal investigation review team (RCA or ACA). Supports accountability tracking and TJC documentation requirements.',
    `review_type` STRING COMMENT 'Type of formal investigation review conducted for this event. Root Cause Analysis (RCA) is required for TJC sentinel events. Apparent Cause Analysis (ACA) is used for less severe events. Apparent Cause Analysis is a lighter-weight structured review.. Valid values are `RCA|ACA|apparent_cause|peer_review|no_review_required`',
    `root_causes_identified` STRING COMMENT 'Narrative summary of the root causes identified through the formal Root Cause Analysis (RCA) or Apparent Cause Analysis (ACA). Documents the fundamental systemic factors that allowed the event to occur. Supports action plan development.',
    `source_event_reference` STRING COMMENT 'Original identifier of the patient safety event in the source operational system (e.g., Epic incident report ID, RL Solutions event number). Enables traceability back to the system of record.',
    `tjc_acknowledgment_date` DATE COMMENT 'Date on which The Joint Commission (TJC) formally acknowledged receipt and acceptance of the sentinel event RCA submission. Marks completion of the TJC reporting obligation.',
    `tjc_submission_date` DATE COMMENT 'Date on which the sentinel event report and Root Cause Analysis (RCA) action plan were formally submitted to The Joint Commission (TJC). Required for TJC accreditation compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient safety event record was most recently modified. Supports audit trail, change tracking, and incremental ETL processing.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_patient_safety_event PRIMARY KEY(`patient_safety_event_id`)
) COMMENT 'Patient safety events including falls, medication errors, HAIs, and other adverse events.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` (
    `safety_event_review_id` BIGINT COMMENT 'Unique surrogate identifier for the safety event review record. Primary key for the safety_event_review data product in the quality domain.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility (hospital, clinic, outpatient center) where the safety event and subsequent review occurred.',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.committee. Business justification: Safety event reviews (RCA/ACA) are conducted by or presented to committees (e.g., Patient Safety Committee, Risk Management Committee). This FK enables tracking which committee conducted or reviewed t',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Safety event reviews generate corrective action plans that must be tracked in the compliance system for regulatory submission to CMS, TJC, and state agencies. CAPs require verification, monitoring, an',
    `employee_id` BIGINT COMMENT 'Identifier of the primary clinician, quality officer, or patient safety professional leading the RCA/ACA review team. Typically a physician, risk manager, or patient safety officer.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient involved in the safety event under review. Protected Health Information (PHI) per HIPAA. Links to the patient master record.',
    `patient_safety_event_id` BIGINT COMMENT 'Reference to the originating patient safety event that triggered this review. Links the review record back to the reported safety event.',
    `prior_review_safety_event_review_id` BIGINT COMMENT 'Reference to a previous safety event review of the same event type, populated when recurrence_flag is True. Enables longitudinal tracking of recurring safety issues and effectiveness of prior corrective actions.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, ED visit, outpatient visit) during which the safety event occurred.',
    `action_plan_completed_date` DATE COMMENT 'Actual date on which all corrective action plan items were fully implemented. Used to measure timeliness of corrective action completion against the action_plan_due_date.',
    `action_plan_due_date` DATE COMMENT 'Target completion date for the overall corrective action plan. TJC requires action plan submission within 45 days of sentinel event determination. Drives compliance monitoring and escalation.',
    `action_plan_status` STRING COMMENT 'Current implementation status of the corrective action plan. Tracks whether corrective actions are on track, completed, or overdue relative to the action_plan_due_date.. Valid values are `Not Started|In Progress|Completed|Overdue|Cancelled`',
    `action_plan_summary` STRING COMMENT 'Narrative summary of the corrective action plan developed in response to the identified root causes. Describes systemic improvements, process changes, and preventive measures to reduce recurrence risk.',
    `care_setting` STRING COMMENT 'Clinical care setting where the safety event occurred (e.g., Inpatient unit, Emergency Department (ED), Intensive Care Unit (ICU), Operating Room (OR), Outpatient). Used for stratified safety analytics and benchmarking. [ENUM-REF-CANDIDATE: Inpatient|Emergency Department|ICU|Operating Room|Outpatient|Ambulatory|Long-Term Care — promote to reference product]',
    `cms_reportable_flag` BOOLEAN COMMENT 'Indicates whether this safety event requires reporting to the Centers for Medicare and Medicaid Services (CMS) under Conditions of Participation or Hospital-Acquired Condition (HAC) reduction program requirements.',
    `contributing_factors_summary` STRING COMMENT 'Narrative description of contributing factors identified during the review, including human factors, communication failures, equipment issues, environmental conditions, and organizational/system factors per TJC RCA framework.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety event review record was first created in the system. Supports audit trail and data lineage requirements.',
    `department_unit` STRING COMMENT 'Name of the specific clinical department or nursing unit where the safety event occurred (e.g., 4 North Med/Surg, MICU, OR Suite 3). Supports unit-level safety performance reporting.',
    `disclosure_date` DATE COMMENT 'Date on which the safety event was disclosed to the patient and/or family. Populated when disclosure_to_patient_flag is True. Supports compliance with CMS and TJC patient rights requirements.',
    `disclosure_to_patient_flag` BOOLEAN COMMENT 'Indicates whether the safety event and its findings were disclosed to the patient and/or family per CMS Conditions of Participation and TJC patient rights standards. True = disclosure completed.',
    `effectiveness_verification_date` DATE COMMENT 'Date on which the effectiveness of the implemented corrective actions was formally assessed and documented. Supports TJC follow-up review requirements.',
    `effectiveness_verification_notes` STRING COMMENT 'Narrative documentation of the effectiveness verification findings, including metrics used, data reviewed, and conclusions drawn about whether corrective actions achieved the intended risk reduction.',
    `effectiveness_verification_status` STRING COMMENT 'Status of the post-implementation effectiveness check confirming whether corrective actions successfully reduced or eliminated the identified risk. TJC requires evidence of effectiveness measurement for sentinel event action plans.. Valid values are `Pending|In Progress|Verified Effective|Verified Ineffective|Inconclusive`',
    `event_category` STRING COMMENT 'Severity classification of the patient safety event under review per TJC and AHRQ taxonomy. Sentinel Events require mandatory RCA and TJC reporting. Drives review type selection and regulatory notification obligations.. Valid values are `Sentinel Event|Serious Safety Event|Near Miss|Precursor|No Harm Event`',
    `event_date` DATE COMMENT 'Calendar date on which the patient safety event occurred. Used as the principal real-world event date for regulatory reporting timelines and trending analysis.',
    `event_type_code` STRING COMMENT 'Standardized code classifying the type of patient safety event (e.g., medication error, fall, wrong-site surgery, HAI, pressure injury) per AHRQ Common Formats or NQF Serious Reportable Events taxonomy.',
    `event_type_description` STRING COMMENT 'Human-readable description of the safety event type corresponding to the event_type_code. Provides narrative context for reporting and analytics.',
    `hai_event_type` STRING COMMENT 'If the safety event involves a Healthcare-Associated Infection (HAI), specifies the HAI type: Central Line-Associated Bloodstream Infection (CLABSI), Catheter-Associated Urinary Tract Infection (CAUTI), Surgical Site Infection (SSI), Ventilator-Associated Pneumonia (VAP), C. difficile (CDIFF), MRSA, or None. Supports CDC NHSN reporting. [ENUM-REF-CANDIDATE: CLABSI|CAUTI|SSI|VAP|CDIFF|MRSA|None — 7 candidates stripped; promote to reference product]',
    `harm_level` STRING COMMENT 'Severity of harm to the patient using the National Coordinating Council for Medication Error Reporting and Prevention (NCC MERP) Index or equivalent harm scale (E through I for harm-causing events). Drives regulatory reporting thresholds and review intensity. [ENUM-REF-CANDIDATE: E - Temporary Harm|F - Temporary Harm with Intervention|G - Permanent Harm|H - Life-Sustaining Intervention|I - Death — promote to reference product]. Valid values are `E - Temporary Harm|F - Temporary Harm with Intervention|G - Permanent Harm|H - Life-Sustaining Intervention|I - Death`',
    `icd10_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code most closely associated with the patient safety event or resulting harm. Used for clinical coding, regulatory reporting, and linkage to claims data for HAC identification.. Valid values are `^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$`',
    `patient_safety_indicator_code` STRING COMMENT 'AHRQ Patient Safety Indicator (PSI) code associated with this safety event, if applicable (e.g., PSI-03 Pressure Ulcer, PSI-06 Iatrogenic Pneumothorax, PSI-90 Composite). Used for CMS VBP and MIPS quality reporting.',
    `quality_committee_review_flag` BOOLEAN COMMENT 'Indicates whether this safety event review was escalated to and reviewed by the hospital Quality Improvement Committee or Patient Safety Committee. Required for TJC governance and CMS QAPI program compliance.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this safety event represents a recurrence of a previously reviewed event type within the same department or facility. True = recurrence detected. Triggers escalated review and pattern analysis.',
    `review_approved_date` DATE COMMENT 'Date on which the completed review findings and action plan were formally approved by the quality committee, patient safety officer, or governing body.',
    `review_completed_date` DATE COMMENT 'Date on which the safety event review (RCA/ACA) was formally completed and all findings documented. Used to measure compliance with TJC 45-day completion requirement.',
    `review_initiated_date` DATE COMMENT 'Date on which the formal Root Cause Analysis (RCA) or Apparent Cause Analysis (ACA) review process was officially initiated. TJC requires RCA initiation within 45 days of a sentinel event.',
    `review_number` STRING COMMENT 'Externally-known, human-readable business identifier for this safety event review (e.g., RCA-2024-00123). Used for tracking, reporting, and regulatory correspondence with TJC and CMS.',
    `review_status` STRING COMMENT 'Current lifecycle state of the safety event review workflow. Tracks progression from initiation through completion and closure for TJC survey readiness and CMS reporting.. Valid values are `Initiated|In Progress|Pending Approval|Completed|Closed|Cancelled`',
    `review_team_composition` STRING COMMENT 'Narrative description of the multidisciplinary review team members and their roles (e.g., physician, nurse, pharmacist, risk manager, quality officer, department director). TJC requires interdisciplinary team participation in RCA.',
    `review_team_size` STRING COMMENT 'Total number of individuals who participated in the formal safety event review team. Supports TJC interdisciplinary team composition compliance verification.',
    `review_type` STRING COMMENT 'Classification of the formal review methodology applied: Root Cause Analysis (RCA) for serious/sentinel events, Apparent Cause Analysis (ACA) for less severe events, Failure Mode and Effects Analysis (FMEA) for proactive risk, Peer Review for clinical quality, Mortality Review for unexpected deaths, or Near Miss Review. [ENUM-REF-CANDIDATE: RCA|ACA|FMEA|Peer Review|Mortality Review|Near Miss Review — promote to reference product]. Valid values are `RCA|ACA|FMEA|Peer Review|Mortality Review|Near Miss Review`',
    `risk_score` STRING COMMENT 'Numeric risk priority score assigned to the safety event, typically calculated as Severity × Probability × Detectability (e.g., Risk Priority Number from FMEA methodology). Ranges typically 1–1000. Drives prioritization of corrective actions.',
    `root_cause_category` STRING COMMENT 'Primary categorical classification of the root cause per TJC RCA framework (e.g., Human Factors, Communication, Training, Environment/Equipment, Rules/Policies/Procedures, Fatigue, Assessment). [ENUM-REF-CANDIDATE: Human Factors|Communication|Training|Environment|Equipment|Rules/Policies|Fatigue|Assessment — promote to reference product]',
    `root_cause_summary` STRING COMMENT 'Narrative summary of the primary root cause(s) identified through the Root Cause Analysis (RCA) or Apparent Cause Analysis (ACA) process. Documents the fundamental system or process failures that contributed to the event.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this safety event review record originated (e.g., Epic EHR, Cerner Millennium, RL Solutions patient safety event reporting system). Supports data lineage and ETL traceability. [ENUM-REF-CANDIDATE: Epic|Cerner|MEDITECH|RL Solutions|Quantros|Origami|Manual — 7 candidates stripped; promote to reference product]',
    `state_reportable_flag` BOOLEAN COMMENT 'Indicates whether this safety event meets state Department of Health mandatory adverse event reporting requirements. Reporting thresholds vary by state jurisdiction.',
    `tjc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this safety event meets The Joint Commission (TJC) criteria for mandatory sentinel event reporting. True = TJC notification required within 5 business days of event determination.',
    `tjc_reported_date` DATE COMMENT 'Date on which the sentinel event was formally reported to The Joint Commission (TJC). Required for TJC accreditation compliance tracking. Null if tjc_reportable_flag is False.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety event review record was last modified. Supports audit trail, change tracking, and data lineage requirements.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_safety_event_review PRIMARY KEY(`safety_event_review_id`)
) COMMENT 'Reviews and root cause analyses of patient safety events.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` (
    `mortality_review_id` BIGINT COMMENT 'Unique surrogate identifier for each inpatient mortality review case record in the quality and peer review system. Primary key for the mortality_review data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital or care site) where the patient death occurred. Supports multi-facility enterprise mortality reporting and CMS facility-level quality measure submission.',
    `quality_committee_id` BIGINT COMMENT 'Reference to the peer review or quality committee responsible for conducting this mortality review. Supports committee-level workload tracking and governance reporting.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Mortality reviews analyze DRG assignments to assess case mix impact on mortality rates and identify CMI documentation opportunities. Quality committees require DRG reference data for risk-adjusted mor',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to compliance.investigation. Business justification: Mortality reviews identifying care quality issues, policy violations, or potential regulatory non-compliance trigger formal compliance investigations. Investigations assess whether deaths involve repo',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of this mortality review. Links to the Master Patient Index (MPI) record for demographic and identity context. Protected Health Information (PHI) under HIPAA.',
    `clinician_id` BIGINT COMMENT 'Reference to the attending physician of record at the time of the patients death. Used to associate the mortality event with the responsible clinician for peer review and quality reporting purposes.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Mortality review committees requiring family interviews or extended record access beyond treatment scope need documented consent. Quality improvement activities involving patient/family contact requir',
    `reviewer_provider_clinician_id` BIGINT COMMENT 'Reference to the physician or clinical reviewer assigned as the primary reviewer for this mortality case. Supports peer review workload distribution and conflict-of-interest tracking.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Mortality reviews analyze death patterns by specialty to identify specialty-specific quality improvement opportunities. CMS mortality measures and AHRQ PSIs are stratified by specialty for benchmarkin',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Deaths of research subjects require mandatory mortality review with research-specific considerations: investigational product causality assessment, protocol adherence evaluation, and expedited reporti',
    `udi_record_id` BIGINT COMMENT 'Foreign key linking to supply.udi_record. Business justification: Mortality reviews involving implanted devices must trace the specific device for root cause analysis, correlation with known device issues, and potential recall investigation. Required for sentinel ev',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Mortality review committees analyze deaths by nursing unit to identify unit-specific care quality issues (ICU staffing, rapid response team effectiveness, palliative care access). Unit-level mortality',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient encounter during which the patient death occurred. Links the mortality review to the originating clinical encounter for clinical context, LOS, and DRG data.',
    `action_plan_due_date` DATE COMMENT 'Target date by which the corrective action plan resulting from this mortality review must be submitted and implemented. Populated only when action_plan_required_flag is true.',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether the peer review committee determined that a formal corrective action plan is required as a result of this mortality review. Triggers downstream quality improvement workflow and follow-up tracking.',
    `care_quality_rating` STRING COMMENT 'Peer review committees overall rating of the quality of care provided during the encounter leading to death. Supports identification of systemic care delivery issues and drives Clinical Documentation Improvement (CDI) initiatives.. Valid values are `optimal|suboptimal|poor|not_applicable`',
    `cdi_query_initiated_flag` BOOLEAN COMMENT 'Indicates whether a Clinical Documentation Improvement (CDI) query was initiated as a result of this mortality review to clarify or improve clinical documentation for accurate ICD-10 coding and DRG assignment.',
    `cmi_impact_flag` BOOLEAN COMMENT 'Indicates whether this mortality case was identified as having a potential impact on the facilitys Case Mix Index (CMI) due to coding gaps or Clinical Documentation Improvement (CDI) opportunities. Supports CDI program prioritization.',
    `cms_mortality_measure_code` STRING COMMENT 'Specific CMS mortality outcome measure identifier (e.g., MORT-30-AMI, MORT-30-HF, MORT-30-PN, MORT-30-COPD, MORT-30-STK) applicable to this mortality case. Populated when cms_mortality_measure_flag is true.',
    `cms_mortality_measure_flag` BOOLEAN COMMENT 'Indicates whether this mortality case is included in a CMS Hospital Inpatient Quality Reporting (IQR) mortality outcome measure (e.g., AMI-30-day, HF-30-day, PN-30-day mortality). Supports CMS quality program reporting and VBP scoring.',
    `committee_findings_summary` STRING COMMENT 'Narrative summary of the peer review committees findings regarding the mortality case, including clinical assessment, care quality observations, and determination rationale. Protected under peer review privilege in most jurisdictions. Confidential business data.',
    `committee_review_date` DATE COMMENT 'Date on which the peer review committee formally convened to review this mortality case. Supports compliance tracking against medical staff bylaws and TJC peer review timeliness requirements.',
    `confidentiality_protection_flag` BOOLEAN COMMENT 'Indicates whether this mortality review record is protected under state peer review privilege statutes, restricting discoverability in legal proceedings. Critical for legal and compliance governance of peer review documentation.',
    `contributing_factor_1` STRING COMMENT 'Primary contributing clinical factor identified by the peer review committee as having contributed to the patients death (e.g., delayed diagnosis, medication error, communication failure, system failure). Supports root cause analysis and quality improvement planning.',
    `contributing_factor_2` STRING COMMENT 'Secondary contributing clinical factor identified by the peer review committee. Captures additional systemic or clinical issues beyond the primary factor that contributed to the mortality outcome.',
    `contributing_factor_3` STRING COMMENT 'Tertiary contributing clinical factor identified by the peer review committee. Supports comprehensive root cause analysis when multiple systemic issues are identified.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this mortality review record was first created in the quality management system. Supports audit trail, data lineage, and Silver layer ingestion tracking.',
    `days_from_admission_to_death` STRING COMMENT 'Number of days elapsed between the patients admission date and the date of death. Supports Length of Stay (LOS) analysis, early mortality detection (death within 24-48 hours), and CMS mortality outcome measure stratification.',
    `death_classification` STRING COMMENT 'Clinical classification of the death as expected (consistent with terminal prognosis or end-of-life care plan) or unexpected (unanticipated given the patients clinical condition). Core field for CMS mortality outcome measures and peer review triage.. Valid values are `expected|unexpected|indeterminate`',
    `death_date` DATE COMMENT 'Calendar date on which the patient death occurred. Principal real-world event date for the mortality review. Used in CMS mortality outcome measure calculations and TJC accreditation reporting. PHI under HIPAA.',
    `death_location_type` STRING COMMENT 'Clinical care setting within the facility where the patient death occurred (e.g., ICU, ED, OR, inpatient unit). Supports unit-level mortality analysis and identification of high-risk care areas. [ENUM-REF-CANDIDATE: inpatient_unit|icu|ed|or|pacu|step_down|other — promote to reference product]',
    `death_timestamp` TIMESTAMP COMMENT 'Precise date and time of patient death as documented in the Electronic Health Record (EHR). Used for time-of-day analysis, shift-level mortality reporting, and clinical event sequencing. PHI under HIPAA.',
    `dnr_status_at_death` STRING COMMENT 'Patients resuscitation code status at the time of death as documented in the EHR. Informs the expected vs. unexpected death classification and supports advance directive compliance review. Relevant to EMTALA and CMS Patient Rights Conditions of Participation.. Valid values are `full_code|dnr|dni|dnr_dni|comfort_care`',
    `hai_related_flag` BOOLEAN COMMENT 'Indicates whether a Healthcare-Associated Infection (HAI) — such as CLABSI, CAUTI, or SSI — was identified as a contributing factor to the patients death. Supports HAI mortality linkage reporting to CMS and CDC National Healthcare Safety Network (NHSN).',
    `hai_type` STRING COMMENT 'Specific type of Healthcare-Associated Infection (HAI) linked to this mortality case when hai_related_flag is true. Values include CLABSI (Central Line-Associated Bloodstream Infection), CAUTI (Catheter-Associated Urinary Tract Infection), SSI (Surgical Site Infection), C. diff, VAP, MRSA. [ENUM-REF-CANDIDATE: clabsi|cauti|ssi|cdiff|vap|mrsa|other — promote to reference product]',
    `hospice_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the patient was enrolled in a hospice program at the time of or prior to the encounter. Supports expected death classification and CMS hospice quality reporting.',
    `improvement_recommendation` STRING COMMENT 'Narrative description of quality improvement recommendations issued by the peer review committee as a result of this mortality review. Drives performance improvement plans and TJC survey readiness activities. Protected under peer review privilege.',
    `mips_reportable_flag` BOOLEAN COMMENT 'Indicates whether this mortality case is reportable under the Merit-Based Incentive Payment System (MIPS) quality performance category for the attending provider. Supports MACRA/MIPS compliance tracking.',
    `palliative_care_involved_flag` BOOLEAN COMMENT 'Indicates whether the palliative care team was involved in the patients care during the encounter. Supports expected death classification validation and end-of-life care quality metrics.',
    `preventability_determination` STRING COMMENT 'Peer review committees determination of whether the death was preventable, potentially preventable, not preventable, or indeterminate based on clinical evidence review. Core outcome field for quality improvement and CMS Value-Based Purchasing (VBP) reporting.. Valid values are `preventable|potentially_preventable|not_preventable|indeterminate`',
    `primary_cause_of_death_description` STRING COMMENT 'Plain-language description of the primary underlying cause of death corresponding to the ICD-10 code. Supports readability in committee reports and regulatory submissions without requiring code lookup.',
    `primary_icd10_cause_of_death` STRING COMMENT 'International Classification of Diseases 10th Revision (ICD-10) code representing the primary underlying cause of death as coded by Health Information Management (HIM). Used for mortality statistics, DRG grouping, and CMS quality measure reporting.. Valid values are `^[A-Z][0-9A-Z]{2,6}$`',
    `readmission_related_flag` BOOLEAN COMMENT 'Indicates whether the patient was readmitted within 30 days of a prior discharge and died during the readmission encounter. Supports CMS Hospital Readmissions Reduction Program (HRRP) mortality linkage analysis.',
    `review_case_number` STRING COMMENT 'Externally-known alphanumeric case number assigned by the quality department or peer review committee to uniquely identify and track this mortality review case across systems and correspondence.',
    `review_completed_date` DATE COMMENT 'Date on which the mortality review was formally completed and findings were finalized by the peer review committee. Used to calculate review cycle time and SLA compliance.',
    `review_initiated_date` DATE COMMENT 'Date on which the formal mortality review process was initiated by the quality department. Used to measure timeliness of review initiation against TJC and internal SLA standards.',
    `review_status` STRING COMMENT 'Current workflow lifecycle state of the mortality review case. Tracks progression from initial case opening through committee review to final closure. Drives quality dashboard reporting and SLA compliance.. Valid values are `initiated|in_review|pending_committee|completed|closed|voided`',
    `review_trigger_type` STRING COMMENT 'Criterion or event that triggered the formal mortality review (e.g., unexpected death, post-surgical death, death within 24 hours of admission, Against Medical Advice (AMA) discharge followed by death, readmission death). Determines review pathway and committee assignment. [ENUM-REF-CANDIDATE: unexpected_death|surgical_death|icu_death|ed_death|readmission_death|ama_death|other — promote to reference product]',
    `root_cause_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Root Cause Analysis (RCA) has been mandated for this mortality case, either due to sentinel event classification or internal quality policy. Triggers RCA workflow in the quality management system.',
    `sentinel_event_flag` BOOLEAN COMMENT 'Indicates whether this mortality case has been classified as a TJC Sentinel Event requiring a formal Root Cause Analysis (RCA) and corrective action plan submission to The Joint Commission.',
    `surgical_case_flag` BOOLEAN COMMENT 'Indicates whether the patient underwent a surgical procedure during the encounter associated with this mortality review. Triggers AHRQ PSI-04 (Death Among Surgical Inpatients) measure inclusion and surgical mortality peer review pathway.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this mortality review record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver layer.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_mortality_review PRIMARY KEY(`mortality_review_id`)
) COMMENT 'Mortality review records for quality improvement and peer review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` (
    `vbp_program_id` BIGINT COMMENT 'Unique surrogate identifier for a CMS Value-Based Purchasing (VBP) program record. Primary key for this master configuration entity.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: VBP programs are payer-sponsored quality initiatives. Each program is administered by a specific payer for their contracted providers. Payer defines measure set, payment methodology, and performance t',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: vbp_program represents specific VBP (Value-Based Purchasing) program instances, while quality_program is the master portfolio entity for all quality programs. This FK connects VBP programs to the broa',
    `raf_score_id` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `achievement_benchmark_percentile` DECIMAL(18,2) COMMENT 'National performance percentile representing the benchmark (top performance) for achievement scoring. Typically set at the 95th percentile of baseline period national performance.',
    `achievement_threshold_percentile` DECIMAL(18,2) COMMENT 'National performance percentile that a hospital must exceed to earn achievement points for a given measure. Typically set at the 50th percentile of baseline period national performance.',
    `apm_participant_registry_code` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `applicable_provider_type` STRING COMMENT 'Type of healthcare provider or facility to which this VBP program configuration applies. Determines eligibility rules, measure sets, and payment adjustment calculations. [ENUM-REF-CANDIDATE: acute_care_hospital|critical_access_hospital|psychiatric_hospital|long_term_care|skilled_nursing_facility|home_health_agency — promote to reference product]. Valid values are `acute_care_hospital|critical_access_hospital|psychiatric_hospital|long_term_care|skilled_nursing_facility|home_health_agency`',
    `approved_by` STRING COMMENT 'Name or identifier of the quality leadership role (e.g., Chief Quality Officer, VP Quality) who approved this VBP program configuration for use in performance tracking and reporting.',
    `approved_date` DATE COMMENT 'Date on which the VBP program configuration was formally approved by quality leadership for operational use. Supports governance and audit trail requirements.',
    `baseline_period_end` DATE COMMENT 'End date of the baseline period used to establish benchmark performance scores for achievement scoring calculations.',
    `baseline_period_start` DATE COMMENT 'Start date of the baseline period used to establish benchmark performance scores against which the performance period is compared for achievement scoring.',
    `benchmark_score` DECIMAL(18,2) COMMENT 'Benchmark score for comparison.',
    `cahps_survey_vendor_required` BOOLEAN COMMENT 'Indicates whether hospitals must use a CMS-approved CAHPS survey vendor to collect patient experience data for the Person and Community Engagement domain. True for HVBP programs.',
    `clinical_outcomes_domain_weight` DECIMAL(18,2) COMMENT 'Proportional weight assigned to the Clinical Outcomes domain in the Total Performance Score (TPS) calculation, expressed as a decimal (e.g., 0.25 = 25%). Includes mortality, complications, and readmission measures.',
    `cms_program_code` STRING COMMENT 'Official CMS-assigned program identifier used in federal regulatory filings, CMS Quality Reporting systems, and QualityNet submissions. Serves as the external reference key for CMS correspondence.. Valid values are `^CMS-VBP-[0-9]{4}-[A-Z0-9]+$`',
    `correction_window_end` DATE COMMENT 'Deadline by which hospitals must submit data corrections or reconsideration requests following the preview report release. After this date, scores are finalized for payment adjustment calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBP program configuration record was first created in the system. Supports audit trail and data lineage requirements.',
    `efficiency_cost_reduction_weight` DECIMAL(18,2) COMMENT 'Proportional weight assigned to the Efficiency and Cost Reduction domain in the TPS calculation, expressed as a decimal (e.g., 0.25 = 25%). Includes Medicare Spending Per Beneficiary (MSPB) measure.',
    `federal_register_notice` STRING COMMENT 'Federal Register citation (volume, page, and date) for the CMS IPPS Final Rule that established this program years VBP parameters (e.g., 88 FR 49000, July 31, 2023). Supports regulatory audit trail.',
    `final_score_publication_date` DATE COMMENT 'Date on which CMS publicly releases final Total Performance Scores (TPS) and payment adjustment factors for all participating hospitals. Triggers the payment adjustment application in the payment year.',
    `fiscal_year` STRING COMMENT 'Federal fiscal year (October 1 – September 30) to which this VBP program configuration applies (e.g., 2024 for FY2024). Drives payment adjustment calculations and performance period alignment.',
    `is_new_measure_set` BOOLEAN COMMENT 'Indicates whether this program year introduces a new or substantially revised measure set compared to the prior fiscal year. Triggers additional staff education, CDI workflow updates, and quality committee review.',
    `max_achievement_points` STRING COMMENT 'Maximum number of achievement points a hospital can earn per measure under the VBP scoring methodology (typically 10 points).',
    `max_domain_score` STRING COMMENT 'Maximum possible score achievable within any single domain before weighting is applied. Used to normalize domain scores to a common scale for TPS calculation.',
    `max_improvement_points` STRING COMMENT 'Maximum number of improvement points a hospital can earn per measure under the VBP scoring methodology (typically 9 points).',
    `max_payment_adjustment_factor` DECIMAL(18,2) COMMENT 'Maximum payment adjustment factor (multiplier) that can be applied to a hospitals Medicare IPPS payments under this program year. Values above 1.0000 represent a net payment bonus.',
    `max_tps` STRING COMMENT 'Maximum possible Total Performance Score (TPS) a hospital can achieve under this program year configuration. Defines the upper bound for payment adjustment factor calculations.',
    `measure_set_version` STRING COMMENT 'Version identifier of the CMS-published measure set applicable to this program year (e.g., FY2024-v1.2). Tracks changes in included measures, specifications, and exclusion criteria across program years.',
    `measurement_year` STRING COMMENT 'Performance measurement year.',
    `min_case_volume_required` STRING COMMENT 'Minimum number of eligible cases required for a measure to be scored for a hospital. Measures with case volumes below this threshold are suppressed from scoring to ensure statistical reliability.',
    `min_measure_count_required` STRING COMMENT 'Minimum number of measures a hospital must have reportable data for in order to receive a domain score and be included in VBP payment adjustment calculations. Hospitals below this threshold are excluded from VBP.',
    `min_payment_adjustment_factor` DECIMAL(18,2) COMMENT 'Minimum payment adjustment factor (multiplier) that can be applied to a hospitals Medicare IPPS payments under this program year. Values below 1.0000 represent a net payment reduction.',
    `nqf_alignment_flag` BOOLEAN COMMENT 'Indicates whether all measures in this program years measure set are endorsed by the National Quality Forum (NQF). NQF endorsement is a CMS requirement for VBP measure inclusion.',
    `payment_adjustment_formula` DECIMAL(18,2) COMMENT 'Narrative or coded description of the formula used to translate the Total Performance Score (TPS) into a payment adjustment factor. Documents the linear exchange function parameters published in the CMS IPPS Final Rule.',
    `payment_adjustment_rate` DECIMAL(18,2) COMMENT 'Payment adjustment rate based on performance.',
    `payment_year` DECIMAL(18,2) COMMENT 'Federal fiscal year in which the VBP payment adjustment (bonus or penalty) is applied to Medicare IPPS payments. Typically lags the performance period by approximately two years.',
    `performance_period_end` DATE COMMENT 'End date of the performance period during which hospital quality data is collected and measured for VBP scoring.',
    `performance_period_start` DATE COMMENT 'Start date of the performance period during which hospital quality data is collected and measured for VBP scoring. Distinct from the baseline period.',
    `performance_score` DECIMAL(18,2) COMMENT 'Overall program performance score.',
    `person_community_engagement_weight` DECIMAL(18,2) COMMENT 'Proportional weight assigned to the Person and Community Engagement domain (formerly Patient Experience / CAHPS) in the TPS calculation, expressed as a decimal (e.g., 0.25 = 25%).',
    `preview_report_release_date` DATE COMMENT 'Date on which CMS releases preliminary VBP performance scores to hospitals for review and correction prior to final score publication. Hospitals have a defined review and correction window following this date.',
    `program_code` STRING COMMENT 'Externally-known CMS-assigned alphanumeric code uniquely identifying this VBP program configuration (e.g., VBP-IPPS-2024). Used in CMS reporting submissions and regulatory correspondence.. Valid values are `^VBP-[A-Z0-9]{3,20}$`',
    `program_description` STRING COMMENT 'Free-text narrative description of the VBP program year configuration, including key policy changes from the prior year, new measures added, measures removed, and notable methodology updates.',
    `program_name` STRING COMMENT 'Official CMS-designated name of the VBP program (e.g., Hospital Value-Based Purchasing Program FY2024). Used in regulatory reports, dashboards, and executive communications.',
    `program_status` STRING COMMENT 'Current lifecycle state of the VBP program configuration. active indicates the program is in effect for the current fiscal year; pending indicates approved but not yet effective; archived indicates a prior program year record retained for historical reference.. Valid values are `active|inactive|pending|suspended|archived`',
    `program_type` STRING COMMENT 'Classification of the VBP program variant: HVBP (Hospital VBP), PVBP (Physician VBP), ESRD_QIP (End-Stage Renal Disease Quality Incentive Program), SNF_VBP (Skilled Nursing Facility VBP), HH_VBP (Home Health VBP). Determines applicable domain weights and scoring methodology.. Valid values are `HVBP|PVBP|ESRD_QIP|SNF_VBP|HH_VBP`',
    `qualitynet_program_code` STRING COMMENT 'Program code used within the CMS QualityNet reporting portal for data submission, preview reports, and final VBP scoring. Required for electronic data interchange with CMS.',
    `regulatory_rule_citation` STRING COMMENT 'Primary federal regulatory citation governing this VBP program year (e.g., 42 CFR Part 412 Subpart O). Used for compliance documentation, audit support, and regulatory reporting.',
    `safety_domain_weight` DECIMAL(18,2) COMMENT 'Proportional weight assigned to the Safety domain in the TPS calculation, expressed as a decimal (e.g., 0.25 = 25%). Includes HAI measures such as CLABSI, CAUTI, SSI, and MRSA.',
    `total_domain_weight_check` DECIMAL(18,2) COMMENT 'Sum of all four domain weights (clinical outcomes + person and community engagement + safety + efficiency and cost reduction). Must equal 1.0000 (100%) for a valid program configuration. Used for data quality validation and audit.',
    `tps_methodology` STRING COMMENT 'Scoring methodology used to calculate the Total Performance Score (TPS). achievement_improvement_higher selects the higher of achievement or improvement scores per measure; achievement_only uses only achievement; improvement_only uses only improvement.. Valid values are `achievement_improvement_higher|achievement_only|improvement_only`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBP program configuration record was most recently modified. Supports change tracking, audit trail, and data lineage requirements.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `withhold_rate` DECIMAL(18,2) COMMENT 'Percentage of Medicare IPPS base operating DRG payments withheld from all participating hospitals to fund the VBP incentive pool, expressed as a decimal (e.g., 0.0200 = 2.0%). Established annually by CMS per ACA mandate.',
    CONSTRAINT pk_vbp_program PRIMARY KEY(`vbp_program_id`)
) COMMENT 'Value-Based Purchasing program definitions and configurations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure` (
    `measure_id` BIGINT COMMENT 'Primary key for measure',
    `member_attribution_id` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Quality measures require policy documentation for implementation, data collection procedures, numerator/denominator definitions, and compliance with regulatory specifications. Policies govern how meas',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Quality measures reference CPT code sets in cpt_code_set attribute for procedure-based numerator/denominator definitions. MIPS quality category scoring and VBP clinical outcomes domain require validat',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Quality measures are stratified by DRG for risk adjustment in hospital quality reporting. CMS Hospital Compare and VBP programs require DRG-level risk adjustment to ensure fair performance comparisons',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Quality measures are often plan-specific (HEDIS measures vary by product line: Commercial, Medicare, Medicaid). Plans report measure performance to NCQA and CMS for accreditation and Star Ratings.',
    `hedis_measure_id` BIGINT COMMENT 'NCQA-assigned HEDIS measure identifier (e.g., CDC, CBP, W34). Populated only for measures that are part of the HEDIS measure set. Supports NCQA accreditation and health plan reporting.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Quality measures reference ICD-10 code sets in icd10_code_set attribute for eligible population and exclusion criteria definitions. CMS, MIPS, and TJC quality reporting require validated ICD code refe',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Quality measures reference LOINC code sets in loinc_code_set attribute for lab-based quality metrics (e.g., diabetes control, lipid management). eCQM reporting and clinical quality improvement initiat',
    `mips_clinician_measure_id` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `active_status` STRING COMMENT 'Current lifecycle status of the measure in the enterprise catalog: active (currently tracked and reported), inactive (temporarily suspended), retired (no longer in use), draft (under development), or under_review (specification being updated).. Valid values are `active|inactive|retired|draft|under_review`',
    `benchmark_percentile` DECIMAL(18,2) COMMENT 'National percentile rank corresponding to the benchmark threshold (e.g., 75.00 for the 75th percentile). Used to contextualize organizational performance against national peer comparisons in VBP and MIPS scoring.',
    `benchmark_threshold` DECIMAL(18,2) COMMENT 'National or program-defined benchmark performance rate (expressed as a percentage, 0.00–100.00) that the organization targets or must meet for this measure (e.g., 75.00 for 75%). Used in Value-Based Purchasing (VBP) and MIPS scoring.',
    `care_gap_closure_id` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `care_setting` STRING COMMENT 'Clinical care setting to which the measure applies (e.g., inpatient, outpatient, ED, ambulatory, post-acute, home health, hospice, or all settings). Drives measure applicability filtering in reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|ED|ambulatory|post_acute|home_health|hospice|all — 8 candidates stripped; promote to reference product]',
    `clinical_domain` STRING COMMENT 'Clinical or programmatic domain the measure belongs to (e.g., Cardiovascular, Diabetes, Infection Control, Maternal Health, Behavioral Health, Patient Safety, Preventive Care). Used for grouping and filtering in quality dashboards. [ENUM-REF-CANDIDATE: cardiovascular|diabetes|infection_control|maternal_health|behavioral_health|patient_safety|preventive_care|oncology|respiratory|orthopedics — promote to reference product]',
    `cms_ecqm_code` STRING COMMENT 'CMS-assigned electronic Clinical Quality Measure (eCQM) identifier (e.g., CMS122v11). Used for electronic submission to CMS quality reporting programs including MIPS and IQR.. Valid values are `^CMS[0-9]{1,5}v[0-9]{1,3}$`',
    `measure_code` STRING COMMENT 'Internally assigned alphanumeric code uniquely identifying the measure within the enterprise catalog. Used as the business-facing key across reporting systems and dashboards.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `cpt_code_set` STRING COMMENT 'Comma-separated list or value set reference of CPT procedure codes used in the measure logic (e.g., qualifying visit codes, procedure codes for numerator events). References the official value set OID where applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this measure record was first created in the enterprise quality catalog. Supports audit trail and data governance requirements.',
    `data_source` STRING COMMENT 'Primary source system or data type used to calculate the measure (e.g., EHR, claims, registry, survey, ADT, lab, pharmacy, manual abstraction, hybrid). Informs ETL pipeline design and data lineage. [ENUM-REF-CANDIDATE: EHR|claims|registry|survey|ADT|lab|pharmacy|manual|hybrid — 9 candidates stripped; promote to reference product]',
    `denominator_definition` STRING COMMENT 'Formal definition of the denominator population — the eligible patient or encounter population to which the measure applies (e.g., All patients aged 65+ with at least one qualifying visit during the measurement period).',
    `denominator_exception` STRING COMMENT 'Criteria allowing removal of patients from the denominator for clinical or patient-choice reasons that do not constitute exclusions (e.g., Patient declined vaccination — documented medical reason). Distinct from exclusions; applies to process measures only.',
    `denominator_exclusion` STRING COMMENT 'Criteria for excluding patients or encounters from the denominator (e.g., Patients with documented allergy to influenza vaccine). Null if no exclusions apply. Critical for accurate measure calculation.',
    `effective_end_date` DATE COMMENT 'Date on which this measure was retired or deactivated in the enterprise quality catalog. Null for currently active measures. Enables point-in-time historical reporting.',
    `effective_start_date` DATE COMMENT 'Date on which this measure became effective and active in the enterprise quality catalog. Supports historical trending and measure lifecycle management.',
    `eligible_population_criteria` STRING COMMENT 'Initial patient population criteria defining who is eligible to be included in the measure calculation (age range, diagnosis codes, encounter types, payer types, etc.). Serves as the outermost filter before denominator logic is applied.',
    `floor_threshold` DECIMAL(18,2) COMMENT 'Minimum acceptable performance rate (as a percentage) below which the organization is subject to payment penalties or accreditation risk. Distinct from the benchmark target; represents the regulatory floor.',
    `hai_category` STRING COMMENT 'For HAI-related measures, identifies the specific infection type tracked: CLABSI (Central Line-Associated Bloodstream Infection), CAUTI (Catheter-Associated Urinary Tract Infection), SSI (Surgical Site Infection), MRSA, CDI (C. difficile), VAE (Ventilator-Associated Event), or NONE for non-HAI measures. [ENUM-REF-CANDIDATE: CLABSI|CAUTI|SSI|MRSA|CDI|VAE|NONE — 7 candidates stripped; promote to reference product]',
    `higher_is_better` BOOLEAN COMMENT 'Indicates whether a higher measure rate represents better performance (True) or worse performance (False). For example, vaccination rates are higher-is-better; readmission rates are lower-is-better. Critical for correct performance scoring logic.',
    `icd10_code_set` STRING COMMENT 'Comma-separated list or value set reference of ICD-10 diagnosis codes used in the measures eligible population, numerator, or denominator logic (e.g., E11.9, E11.65). References the official value set OID where applicable.',
    `is_active` BOOLEAN COMMENT 'Whether measure is currently active.',
    `loinc_code_set` STRING COMMENT 'Comma-separated list or value set reference of LOINC codes used in the measure logic for laboratory results, clinical observations, or survey instruments (e.g., HbA1c result codes for diabetes measures).',
    `measure_type` STRING COMMENT 'Classification of the measure by its methodological type per NQF/CMS taxonomy: process (care delivery steps), outcome (patient results), structural (organizational capacity), patient experience (CAHPS-based), efficiency (resource use), or intermediate outcome.. Valid values are `process|outcome|structural|patient_experience|efficiency|intermediate_outcome`',
    `measurement_methodology` STRING COMMENT 'Data collection and calculation methodology used for the measure: administrative (claims/ADT data), hybrid (claims + chart review), chart_abstracted (manual chart review), ecqm (electronic clinical quality measure via EHR), survey (patient-reported, e.g., CAHPS), or registry.. Valid values are `administrative|hybrid|chart_abstracted|ecqm|survey|registry`',
    `measurement_year` STRING COMMENT 'Calendar year for which the measure is being tracked and reported (e.g., 2024). Used to version measure performance results and align with annual reporting cycles.',
    `minimum_sample_size` STRING COMMENT 'Minimum number of eligible patients or encounters required for the measure result to be reportable and statistically valid. Results below this threshold are typically suppressed in public reporting.',
    `mips_category` STRING COMMENT 'MIPS performance category to which this measure contributes: quality, promoting_interoperability, improvement_activities, cost, or NONE if not applicable to MIPS. Supports MACRA/MIPS composite score calculation for eligible clinicians.. Valid values are `quality|promoting_interoperability|improvement_activities|cost|NONE`',
    `measure_name` STRING COMMENT 'Full name of the quality measure.',
    `nqf_number` STRING COMMENT 'National Quality Forum (NQF) endorsement number assigned to the measure (e.g., NQF-0028). Null if the measure is not NQF-endorsed. Used for regulatory alignment and cross-program mapping.. Valid values are `^NQF-?[0-9]{4}[A-Za-z]?$`',
    `numerator_definition` STRING COMMENT 'Formal definition of the numerator population for the measure — the subset of the denominator that meets the quality criterion (e.g., Patients who received a flu vaccination during the measurement period). Derived from the official measure specification.',
    `reporting_period_end` DATE COMMENT 'Last date of the measurement/reporting period during which patient encounters and events are evaluated for this measure (e.g., 2024-12-31 for an annual measure).',
    `reporting_period_start` DATE COMMENT 'First date of the measurement/reporting period during which patient encounters and events are evaluated for this measure (e.g., 2024-01-01 for an annual measure).',
    `reporting_period_type` STRING COMMENT 'Annual, quarterly, monthly.',
    `reporting_program` STRING COMMENT 'Name of the regulatory or accreditation program under which this measure is reported (e.g., CMS IQR, CMS OQR, VBP, MIPS, HEDIS, TJC ORYX, State Medicaid, Internal). A measure may belong to multiple programs; this field captures the primary program. [ENUM-REF-CANDIDATE: CMS_IQR|CMS_OQR|VBP|MIPS|APM|HEDIS|TJC_ORYX|STATE|INTERNAL|PCMH — promote to reference product]',
    `risk_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the measure requires risk adjustment to account for patient case mix before performance comparison (True = risk-adjusted). Applies to outcome measures such as mortality and readmission rates.',
    `risk_adjustment_model` STRING COMMENT 'Name or identifier of the risk adjustment model applied to this measure when risk_adjustment_flag is True (e.g., CMS Hierarchical Condition Category (HCC), AHRQ Elixhauser Comorbidity Index). Null if not risk-adjusted.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the measure used in dashboards, scorecards, and internal communications (e.g., Flu Vax — Elderly).',
    `snomed_code_set` STRING COMMENT 'Comma-separated list or value set reference of SNOMED CT codes used in the measure logic for clinical findings, conditions, or procedures. Supports eCQM value set alignment.',
    `specification_url` STRING COMMENT 'URL link to the official published measure specification document or web page maintained by the measure steward (e.g., CMS eCQM library URL, NCQA HEDIS specification page). Enables direct reference to authoritative source.',
    `steward` STRING COMMENT 'Organization responsible for developing, maintaining, and publishing the measure specification (e.g., CMS, NCQA, TJC, NQF, AMA). Determines the authoritative source for measure updates and versioning. [ENUM-REF-CANDIDATE: CMS|NCQA|TJC|NQF|AMA|AHRQ|STATE|INTERNAL|OTHER — promote to reference product]',
    `steward_organization` STRING COMMENT 'Organization that stewards the measure.',
    `stratification_criteria` STRING COMMENT 'Defines how the measure is stratified for sub-group reporting (e.g., by race/ethnicity, payer type, age group, facility). Supports health equity reporting requirements and SDOH analytics per CMS health equity frameworks.',
    `submission_deadline` DATE COMMENT 'Date by which the measure results must be submitted to the applicable regulatory or accreditation body (e.g., CMS IQR submission deadline). Drives quality reporting workflow and compliance tracking.',
    `title` STRING COMMENT 'Official full title of the quality measure as published by the measure steward (e.g., Pneumonia Vaccination Status for Older Adults). Used in regulatory submissions and performance reports.',
    `tjc_measure_set` STRING COMMENT 'Name of The Joint Commission (TJC) ORYX measure set this measure belongs to (e.g., Perinatal Care, Stroke, Venous Thromboembolism). Null if not a TJC measure. Supports TJC accreditation survey readiness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this measure record was last modified in the enterprise quality catalog. Tracks specification updates, benchmark changes, and status transitions.',
    `vbp_domain` STRING COMMENT 'CMS Hospital Value-Based Purchasing (VBP) program domain to which this measure is assigned: clinical_care, safety, efficiency (cost reduction), patient_experience (CAHPS), or NONE if not part of VBP. Drives VBP Total Performance Score calculation.. Valid values are `clinical_care|safety|efficiency|patient_experience|NONE`',
    `version` STRING COMMENT 'Version number of the measure specification as published by the steward (e.g., 11.0, 2024.1). Tracks specification changes year-over-year and ensures the correct logic version is applied during calculation.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_measure PRIMARY KEY(`measure_id`)
) COMMENT 'Quality measure definitions across all programs (CMS, TJC, NCQA, etc.).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure_result` (
    `measure_result_id` BIGINT COMMENT 'Unique surrogate identifier for each quality measure performance result record. Primary key for the measure_result data product.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Quality measure results are subject to external audits by CMS, NCQA, TJC, and state agencies. Auditors validate data accuracy, methodology compliance, and calculation correctness. Linking results to a',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Quality measure results are reported by payer and product line for value-based contracts. Linking enables payer-specific performance tracking, supports ACO and bundled payment reporting, and facilitat',
    `care_gap_closure_id` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, clinic, outpatient center) for which this measure result is reported.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Quality measure results are calculated from underlying claims data. Healthcare audit and validation processes require tracing measure results back to source claims for numerator/denominator verificati',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider for whom this measure result is reported, applicable when measurement_level is provider (e.g., for MIPS individual reporting).',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Quality measure results require regulatory submission to CMS (MIPS, HVBP), state agencies, TJC, and accrediting bodies. Compliance system tracks submission deadlines, attestations, acceptance status, ',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Measure results are stratified by DRG for case mix adjustment and comparative analysis in quality reporting. VBP payment adjustment calculations and Hospital Compare public reporting require DRG-level',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Measure results are calculated at health plan level for Star Ratings, HEDIS reporting, and regulatory submissions. Plan-level results determine quality bonus payments and public ratings.',
    `measure_id` BIGINT COMMENT 'Reference to the quality measure definition (e.g., HEDIS, CMS IQR, MIPS measure) for which this result is recorded.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Quality measure results are reported at organizational provider level for MIPS, VBP, and ACO programs. CMS requires organizational NPI for quality reporting submissions, distinct from facility-level c',
    `payer_id` BIGINT COMMENT 'Reference to the health plan or payer for which this measure result is reported, applicable when measurement_level is health_plan (e.g., HEDIS submission to a specific payer).',
    `radiology_appointment_id` BIGINT COMMENT 'Foreign key linking to radiology.appointment. Business justification: Imaging appointment no-show rates, wait times, and scheduling efficiency are access quality measures. Measure results must link to appointments for operational improvement and patient satisfaction tra',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report. Business justification: Report turnaround time, addendum rates, and critical finding communication timeliness are CMS and ACR quality measures. Measure results must link to reports for performance validation and peer compari',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.study. Business justification: Quality measures for imaging appropriateness, turnaround time, and critical result notification are calculated from imaging studies. Measure results must trace to the studies included in numerator/den',
    `raf_score_id` BIGINT COMMENT 'Vibe-added attribute for quality VBC/MIPS expansion.',
    `reader_assignment_id` BIGINT COMMENT 'Foreign key linking to radiology.reader_assignment. Business justification: Radiologist productivity, turnaround time, and peer review scores are quality measures for OPPE/FPPE and privileging. Measure results must link to reader assignments for individual provider performanc',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Quality measure results must exclude or separately report research subjects to prevent investigational interventions from skewing standard care performance metrics. CMS, NCQA, and TJC require research',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.facility_service. Business justification: Quality measure results reported at service line level (trauma, stroke, cardiac, oncology) for program-specific accreditation and CMS quality reporting. Service line leaders track program-specific mea',
    `unit_id` BIGINT COMMENT 'Reference to the clinical unit (e.g., ICU, ED, surgical unit) for which this measure result is reported, applicable when measurement_level is unit.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Quality measures require specific procedures for numerator compliance (colonoscopy for colorectal screening, HbA1c testing for diabetes control, mammography for breast cancer screening). Real business',
    `benchmark_comparison_result` STRING COMMENT 'Categorical comparison of this facilitys performance rate against the national benchmark rate (above, at, or below benchmark). Supports executive dashboards and regulatory reporting summaries.. Valid values are `above_benchmark|at_benchmark|below_benchmark|no_benchmark`',
    `cms_submission_date` DATE COMMENT 'The date on which this measure result was submitted to the Centers for Medicare and Medicaid Services (CMS) via the applicable quality reporting portal (e.g., QualityNet, MIPS submission system).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this measure result record was first created in the system.',
    `data_completeness_rate` DECIMAL(18,2) COMMENT 'The proportion of eligible cases for which complete data was available for measure calculation. CMS requires a minimum data completeness threshold (typically 75%) for measure results to be publicly reported.',
    `denominator_count` STRING COMMENT 'The total number of eligible patients, encounters, or events in the initial patient population that meet the denominator criteria for this quality measure during the measurement period.',
    `exception_count` STRING COMMENT 'The number of patients or events meeting denominator exception criteria (e.g., patient declined, medical reason documented), distinct from exclusions. Applicable for MIPS and certain CMS measures.',
    `exclusion_count` STRING COMMENT 'The number of patients or events excluded from the denominator based on measure-defined exclusion criteria (e.g., medical contraindications, patient refusals, hospice enrollment).',
    `gap_count` STRING COMMENT 'The estimated number of additional patients or events that would need to meet the numerator criteria to achieve the target rate. Used for care gap closure prioritization in population health programs.',
    `gap_to_target_rate` DECIMAL(18,2) COMMENT 'The arithmetic difference between the target_rate and the actual performance_rate (target_rate minus performance_rate). Positive values indicate underperformance; negative values indicate the target has been exceeded.',
    `hai_event_type` STRING COMMENT 'For HAI-related quality measures, specifies the type of healthcare-associated infection being tracked (Central Line-Associated Bloodstream Infection (CLABSI), Catheter-Associated Urinary Tract Infection (CAUTI), Surgical Site Infection (SSI), MRSA bacteremia, Clostridioides difficile (CDI)). Not applicable for non-HAI measures.. Valid values are `CLABSI|CAUTI|SSI|MRSA|CDI|not_applicable`',
    `hedis_methodology_indicator` BOOLEAN COMMENT 'For HEDIS measures, specifies whether the administrative or hybrid methodology was used for this result. The hybrid methodology supplements administrative data with medical record review to improve accuracy. Not applicable for non-HEDIS measures.',
    `is_publicly_reported` BOOLEAN COMMENT 'Indicates whether this measure result has been or is eligible to be publicly reported on CMS Care Compare, NCQA Health Plan Ratings, or other public transparency platforms.',
    `measure_domain` STRING COMMENT 'The clinical or operational domain to which the measure belongs (e.g., Patient Safety, Effectiveness of Care, Efficiency, Patient Experience, Care Coordination). [ENUM-REF-CANDIDATE: patient_safety|effectiveness|efficiency|patient_experience|care_coordination|timeliness|equity — promote to reference product]',
    `measurement_level` STRING COMMENT 'The organizational level at which this measure result is reported (facility, unit, provider, health plan, or population). Determines the granularity of the performance result.. Valid values are `facility|unit|provider|health_plan|population`',
    `measurement_methodology` STRING COMMENT 'The data collection methodology used to calculate this measure result (administrative claims-based, hybrid combining claims and medical record review, chart-abstracted from medical records, registry-based, or direct EHR extraction). Impacts data completeness and comparability.. Valid values are `administrative|hybrid|chart_abstracted|registry|ehr_direct`',
    `measurement_period_end_date` DATE COMMENT 'The last date of the reporting/measurement period for which this quality measure result applies (e.g., December 31 of the performance year).',
    `measurement_period_start_date` DATE COMMENT 'The first date of the reporting/measurement period for which this quality measure result applies (e.g., January 1 of the performance year).',
    `meets_reporting_threshold` BOOLEAN COMMENT 'Indicates whether this measure result meets the minimum case volume and data completeness thresholds required for public reporting by CMS or the applicable program. Results not meeting thresholds are suppressed from public display.',
    `mips_measure_category` STRING COMMENT 'For MIPS-reported measures, the performance category under which this measure is reported (Quality, Promoting Interoperability, Improvement Activities, or Cost). Null for non-MIPS measures.. Valid values are `quality|promoting_interoperability|improvement_activities|cost`',
    `mips_points_earned` DECIMAL(18,2) COMMENT 'The number of MIPS performance points earned for this measure in the reporting period, used to calculate the composite MIPS performance score. Null for non-MIPS measures.',
    `national_benchmark_rate` DECIMAL(18,2) COMMENT 'The national benchmark performance rate for this measure as published by the measure steward or CMS (e.g., HEDIS 90th percentile, CMS national average). Used for comparative performance analysis.',
    `ncqa_submission_status` STRING COMMENT 'The submission status of this measure result to the National Committee for Quality Assurance (NCQA) for HEDIS reporting and health plan accreditation purposes. Null for non-HEDIS measures.. Valid values are `not_submitted|submitted|accepted|rejected|pending`',
    `nqf_number` STRING COMMENT 'The National Quality Forum (NQF) endorsement number for this quality measure (e.g., NQF-0059 for Diabetes HbA1c Poor Control). Null if the measure is not NQF-endorsed.. Valid values are `^NQF-[0-9]{4}$`',
    `numerator_count` STRING COMMENT 'The number of patients, encounters, or events in the denominator that met the numerator criteria (i.e., received the desired care or outcome) for this quality measure.',
    `payer_submission_status` STRING COMMENT 'The submission status of this measure result to the applicable health plan or payer (e.g., commercial payer, Medicaid managed care organization). Tracks whether the result has been transmitted and acknowledged.. Valid values are `not_submitted|submitted|accepted|rejected|pending`',
    `percentile_rank` DECIMAL(18,2) COMMENT 'The percentile rank of this facilitys or providers performance rate relative to national or peer benchmarks for this measure (e.g., 75.00 = 75th percentile nationally).',
    `performance_rate` DECIMAL(18,2) COMMENT 'The calculated performance rate for this quality measure, expressed as a decimal proportion (numerator / adjusted denominator). For example, 0.8750 represents 87.50% compliance.',
    `performance_year` STRING COMMENT 'The calendar or fiscal year for which this quality measure result is being reported (e.g., 2024). Used for year-over-year trending and regulatory submission alignment.',
    `reporting_program` STRING COMMENT 'The quality reporting program under which this measure result is submitted (e.g., CMS Inpatient Quality Reporting (IQR), Outpatient Quality Reporting (OQR), Value-Based Purchasing (VBP), Merit-based Incentive Payment System (MIPS), HEDIS, state program, Alternative Payment Model (APM), CAHPS). [ENUM-REF-CANDIDATE: CMS_IQR|CMS_OQR|VBP|MIPS|HEDIS|STATE|APM|CAHPS — promote to reference product]',
    `reporting_quarter` STRING COMMENT 'The calendar quarter (1–4) within the performance year for which this measure result is reported, applicable for measures with quarterly reporting cycles (e.g., CMS OQR quarterly submissions).',
    `result_calculated_timestamp` TIMESTAMP COMMENT 'The date and time when this quality measure result was calculated or generated by the analytics or quality measurement system.',
    `result_status` STRING COMMENT 'Current lifecycle status of this measure result record (e.g., draft during calculation, final after internal validation, submitted to payer/CMS, accepted or rejected by the receiving entity, under_review for audit).. Valid values are `draft|final|submitted|accepted|rejected|under_review`',
    `sir_value` DECIMAL(18,2) COMMENT 'The Standardized Infection Ratio (SIR) for HAI measures, calculated as observed infections divided by predicted infections based on national baseline data. A SIR below 1.0 indicates better-than-expected performance. Null for non-HAI measures.',
    `target_rate` DECIMAL(18,2) COMMENT 'The internally established or externally mandated performance target rate for this measure in the given reporting period (e.g., organizational goal of 0.9000 for 90% compliance).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this measure result record was last modified.',
    `vbp_achievement_score` DECIMAL(18,2) COMMENT 'The CMS VBP domain-level achievement score for this measure, reflecting performance relative to national achievement thresholds and benchmarks. Null for non-VBP measures.',
    `vbp_domain` STRING COMMENT 'The CMS Value-Based Purchasing (VBP) program domain to which this measure belongs (e.g., Clinical Outcomes, Safety, Person and Community Engagement, Efficiency and Cost Reduction). Applicable only for VBP-reported measures. [ENUM-REF-CANDIDATE: clinical_outcomes|safety|person_community_engagement|efficiency_cost_reduction — promote to reference product]',
    `vbp_improvement_score` DECIMAL(18,2) COMMENT 'The CMS VBP domain-level improvement score for this measure, reflecting performance improvement relative to the facilitys own baseline performance. Null for non-VBP measures.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_measure_result PRIMARY KEY(`measure_result_id`)
) COMMENT 'Calculated quality measure results for all programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` (
    `cdi_review_id` BIGINT COMMENT 'Unique surrogate identifier for each CDI concurrent or retrospective chart review record. Primary key for the cdi_review data product.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: CDI reviews are subject to compliance audits for documentation integrity, query appropriateness, physician response rates, and DRG assignment accuracy. Audits by RACs, MACs, and OIG assess compliance ',
    `care_site_id` BIGINT COMMENT 'Reference to the hospital or care facility where the encounter and CDI review occurred.',
    `cdi_worksheet_id` BIGINT COMMENT 'Reference to the CDI worksheet record in the clinical.cdi_worksheet product used to document the structured review findings for this encounter.',
    `clinician_id` BIGINT COMMENT 'Reference to the attending physician responsible for the patient encounter being reviewed. Used for physician query response rate monitoring.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: CDI reviews analyze specific DRG assignments to validate coding accuracy, identify documentation gaps, and track DRG changes. Real business process: CDI specialists review assigned DRGs, initiate quer',
    `employee_id` BIGINT COMMENT 'Reference to the CDI specialist or clinician who performed the chart review. Used for productivity tracking and reviewer credentialing.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: CDI reviews directly impact final billing through DRG optimization and CC/MCC capture. The invoice reflects the financial outcome of CDI findings. Linking enables tracking of CDI program ROI, DRG chan',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose medical record is under CDI review. Protected Health Information (PHI) per HIPAA.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: cdi_review (Clinical Documentation Improvement reviews) currently has only cross-domain FKs and no in-domain quality relationship. CDI work is conducted under a quality/performance improvement program',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: CDI reviews target specialty-specific documentation patterns for DRG optimization. Cardiology, orthopedics, and other specialties have distinct documentation requirements for CC/MCC capture and CMI im',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: CDI reviews for research subjects require special handling because research protocols drive diagnoses, procedures, and documentation patterns that differ from standard care. Linkage prevents inappropr',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Clinical documentation improvement reviews analyzed by unit to identify unit-specific documentation gaps and physician education needs. CDI specialists target units with low CC/MCC capture rates and h',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or outpatient encounter being reviewed. Links the CDI review to the clinical encounter record.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: CDI reviews evaluate working DRG assignments during concurrent review to identify documentation improvement opportunities. CDI specialists must reference DRG definitions, relative weights, and CC/MCC ',
    `admit_date` DATE COMMENT 'Date the patient was admitted to the facility. Used to calculate review lag (days from admission to first CDI review) and concurrent review timeliness.',
    `cc_mcc_opportunity_flag` BOOLEAN COMMENT 'Indicates whether the CDI reviewer identified a potential CC or MCC capture opportunity requiring physician query or documentation clarification.',
    `cc_mcc_status` STRING COMMENT 'Indicates whether a Complication and Comorbidity (CC) or Major Complication and Comorbidity (MCC) was captured in the documentation at the time of review. Critical CDI metric driving DRG assignment and reimbursement.. Valid values are `no_cc_mcc|cc|mcc|not_applicable`',
    `clinical_indicator_summary` STRING COMMENT 'Free-text summary of the clinical indicators identified in the medical record that support the CDI review finding or physician query. Documents the clinical basis for the query per AHIMA/ACDIS compliant query guidelines.',
    `cmi_impact` DECIMAL(18,2) COMMENT 'Calculated difference in DRG relative weight between the working DRG and the potential or final DRG resulting from CDI review activity. Quantifies the CMI optimization contribution of this review.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this CDI review record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged from the facility. Populated for post-discharge retrospective reviews. Used to calculate Length of Stay (LOS) context for CDI review.',
    `documentation_impact` STRING COMMENT 'Category of documentation improvement resulting from the CDI review and query: DRG change, CC/MCC capture, POA status change, or no impact. Used for CDI program ROI and quality reporting.. Valid values are `drg_change|cc_mcc_capture|poa_change|no_impact|multiple`',
    `drg_change_flag` BOOLEAN COMMENT 'Indicates whether the CDI review and associated query activity resulted in a change to the DRG assignment. Key CDI program outcome metric.',
    `poa_status` STRING COMMENT 'Present on Admission (POA) indicator status for the principal diagnosis at the time of CDI review. Affects HAI reporting, quality metrics, and CMS payment adjustments.. Valid values are `yes|no|unknown|exempt|clinically_undetermined`',
    `principal_diagnosis_code` STRING COMMENT 'ICD-10-CM code for the principal diagnosis at the time of CDI review. Used to assess documentation specificity and identify query opportunities.',
    `query_initiated_flag` BOOLEAN COMMENT 'Indicates whether a physician query was initiated as a result of this CDI review. Used to calculate query rate and CDI program activity metrics.',
    `query_method` STRING COMMENT 'Method by which the physician query was communicated: verbal, written paper-based, or electronic (e.g., via Epic In-Basket or Cerner PowerChart message). Supports CDI workflow analysis and compliance documentation.. Valid values are `verbal|written|electronic|concurrent_electronic`',
    `query_outcome` STRING COMMENT 'Outcome of the physician query: whether the physician agreed with the CDI suggestion, disagreed, amended documentation, or indicated clinical undetermination. Core CDI program outcome metric.. Valid values are `agree|disagree|amended|no_change|clinically_undetermined`',
    `query_response_date` DATE COMMENT 'Date the attending physician responded to the CDI query. Used to calculate query response turnaround time and physician engagement metrics.',
    `query_response_status` STRING COMMENT 'Current status of the physician query response. Used to monitor physician query response rates, a key CDI program KPI.. Valid values are `pending|responded|no_response|withdrawn`',
    `query_type` STRING COMMENT 'Classification of the physician query as compliant (meets AHIMA/ACDIS standards), leading (directs physician to a specific answer), or non-compliant. Supports CDI compliance monitoring and OIG audit readiness.. Valid values are `compliant|leading|non_compliant`',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Date and time the CDI review was marked complete. Used to calculate review turnaround time and CDI specialist productivity.',
    `review_date` DATE COMMENT 'Calendar date on which the CDI specialist performed the chart review. Principal business event date for the review record.',
    `review_finding_type` STRING COMMENT 'Classification of the CDI reviewers primary finding from the chart review. Drives query initiation workflow and CDI program productivity reporting.. Valid values are `query_opportunity|no_opportunity|documentation_complete|unable_to_review`',
    `review_lag_days` STRING COMMENT 'Number of days elapsed between the patient admission date and the date of this CDI review. Used to measure concurrent review timeliness; a key CDI program performance indicator.',
    `review_number` STRING COMMENT 'Externally visible, human-readable business identifier for the CDI review record. Used for cross-system reference and audit trail. Format: CDI-YYYY-NNNNNNN.. Valid values are `^CDI-[0-9]{4}-[0-9]{7}$`',
    `review_sequence_number` STRING COMMENT 'Sequential number of this review within the encounter (1 = initial review, 2 = first follow-up, etc.). Used to track review frequency per encounter and CDI program throughput.',
    `review_status` STRING COMMENT 'Current workflow state of the CDI chart review. Drives CDI program productivity dashboards and workqueue management.. Valid values are `open|pending_query|pending_response|completed|cancelled`',
    `review_timestamp` TIMESTAMP COMMENT 'Precise date and time the CDI review was initiated in the CDI system. Used for concurrent review timeliness measurement and SLA tracking.',
    `review_type` STRING COMMENT 'Classification of the CDI review by timing and purpose: initial concurrent review, follow-up concurrent review, or post-discharge retrospective review. Drives CDI workflow routing and productivity metrics.. Valid values are `initial|follow_up|post_discharge|concurrent|retrospective`',
    `reviewer_credential` STRING COMMENT 'Professional credential of the CDI reviewer performing the review (e.g., CCDS, CDIP, RN, MD). Used for CDI program staffing analytics and credential-based productivity reporting.',
    `reviewer_role` STRING COMMENT 'Functional role of the individual performing the CDI review. Distinguishes between CDI specialists, physician advisors, coders, and supervisors for productivity and workflow analysis.. Valid values are `cdi_specialist|cdi_physician_advisor|coder|supervisor`',
    `source_review_reference` STRING COMMENT 'Native identifier of the CDI review record in the originating operational system (e.g., 3M CDI internal review ID, Epic CDI activity ID). Supports cross-system traceability and ETL reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this CDI review record was last modified in the data platform. Supports change tracking, audit trail, and incremental ETL processing.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_cdi_review PRIMARY KEY(`cdi_review_id`)
) COMMENT 'Clinical Documentation Improvement review records.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Unique surrogate identifier for the accreditation program record. Primary key for the accreditation_program data product in the quality domain.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Quality accreditation programs (TJC, DNV, HFAP) must link to compliance tracking of accreditation status, deemed status for CMS certification, survey cycles, and findings resolution. Compliance system',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or organizational entity to which this accreditation program applies.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Accreditation programs (NCQA, URAC) are often payer-sponsored for contracted facilities. Payers track facility accreditation status for network adequacy requirements and quality assurance. Payer contr',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: Accreditation programs are a specialized type of quality program. This FK establishes the parent-child relationship, enabling accreditation programs to inherit program-level attributes and be included',
    `accreditation_coordinator_name` STRING COMMENT 'Name of the internal staff member or manager responsible for coordinating the accreditation program, managing survey logistics, and tracking compliance activities.',
    `accreditation_cycle_years` STRING COMMENT 'The standard duration in years of the accreditation cycle for this program (e.g., 3 years for TJC hospital accreditation, 2 years for some disease-specific certifications). Drives renewal scheduling and survey planning.',
    `accreditation_decision` STRING COMMENT 'The formal accreditation decision issued by the accrediting body following the most recent survey or review cycle (e.g., accredited, accredited_with_follow_up, conditional, preliminary_denial, denial, not_accredited). Distinct from program_status which reflects the current operational state.. Valid values are `accredited|accredited_with_follow_up|conditional|preliminary_denial|denial|not_accredited`',
    `accrediting_body` STRING COMMENT 'The external organization responsible for granting and maintaining the accreditation or certification (e.g., TJC = The Joint Commission, CMS = Centers for Medicare and Medicaid Services, NCQA = National Committee for Quality Assurance, DNV = DNV Healthcare, HFAP = Healthcare Facilities Accreditation Program, URAC = Utilization Review Accreditation Commission).. Valid values are `TJC|CMS|NCQA|DNV|HFAP|URAC`',
    `cms_acceptance_status` STRING COMMENT 'Status of CMS review and acceptance of the submitted Plan of Correction. accepted = CMS approved the PoC; rejected = CMS rejected and requires revision; pending = under CMS review; not_applicable = no CMS PoC required for this program.. Valid values are `accepted|rejected|pending|not_applicable`',
    `cms_certification_number` STRING COMMENT 'The six-digit CMS Certification Number (CCN), formerly known as the Medicare Provider Number, assigned by CMS to identify the certified provider or supplier. Required for Medicare and Medicaid participation and regulatory reporting.. Valid values are `^[0-9]{6}$`',
    `complaint_survey_indicator` BOOLEAN COMMENT 'Indicates whether the most recent survey was triggered by a complaint or adverse event report filed with the accrediting body or CMS. True = complaint-triggered survey; False = routine or scheduled survey.',
    `condition_level_deficiency_count` STRING COMMENT 'Number of findings classified as Condition-Level Deficiencies (CLDs) identified during the survey. Condition-level deficiencies indicate substantial non-compliance with a CMS Condition of Participation and require a Plan of Correction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation program record was first created in the system. Supports audit trail, data lineage, and compliance record-keeping requirements.',
    `deemed_status` BOOLEAN COMMENT 'Indicates whether the organization holds CMS Deemed Status through this accreditation program, meaning the accrediting bodys standards are recognized by CMS as meeting or exceeding CMS Conditions of Participation. True = deemed status granted; False = not deemed.',
    `effective_date` DATE COMMENT 'The date on which the current accreditation or certification became effective and binding. Marks the start of the accreditation cycle.',
    `expiration_date` DATE COMMENT 'The date on which the current accreditation or certification expires and must be renewed. Used for renewal tracking, compliance monitoring, and regulatory reporting.',
    `finding_compliance_status` STRING COMMENT 'Current compliance status of the primary finding from the most recent survey. Tracks whether the organization has achieved compliance with the cited standard or condition.. Valid values are `compliant|non_compliant|partial|resolved|pending_review`',
    `finding_evidence` STRING COMMENT 'Narrative description of the evidence observed or documented by surveyors that supports the primary finding or deficiency citation. Used for Plan of Correction development and compliance tracking.',
    `finding_resolution_date` DATE COMMENT 'The date on which the primary accreditation finding was resolved and verified as compliant by the accrediting body or internal quality team.',
    `finding_resolution_status` STRING COMMENT 'Current resolution status of the primary accreditation finding. Tracks the lifecycle from identification through corrective action to verified closure.. Valid values are `open|in_progress|resolved|verified|closed`',
    `finding_standard_reference` STRING COMMENT 'The specific accreditation standard, National Patient Safety Goal (NPSG), CMS Condition of Participation (CoP) condition, or state regulation citation associated with the primary or most significant finding from the survey (e.g., TJC NPSG.07.01.01, CMS CoP 482.13, State Health Code §405.1). For multi-finding surveys, this captures the lead citation.',
    `finding_type` STRING COMMENT 'Classification of the primary or most significant finding type from the survey. RFI = Requirement for Improvement (TJC); immediate_threat = Immediate Threat to Health and Safety; condition_level_deficiency = CMS Condition-Level Deficiency; standard_level_deficiency = CMS Standard-Level Deficiency; observation = non-scored observation.. Valid values are `RFI|immediate_threat|condition_level_deficiency|standard_level_deficiency|observation`',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up survey or focused review is required following the most recent survey due to unresolved findings or conditional accreditation status. True = follow-up required; False = no follow-up required.',
    `follow_up_survey_date` DATE COMMENT 'Scheduled or actual date of the follow-up survey or focused review required to verify correction of findings from the primary survey. Populated only when follow_up_required is True.',
    `immediate_threat_count` STRING COMMENT 'Number of findings classified as Immediate Threat to Health and Safety (ITHS) identified during the survey. These are the most severe findings requiring immediate corrective action and may trigger CMS termination proceedings.',
    `is_cms_cop_applicable` BOOLEAN COMMENT 'Indicates whether CMS Conditions of Participation apply to this accreditation program. True = CMS CoP requirements govern this program; False = program is not subject to CMS CoP (e.g., voluntary certification programs).',
    `last_cms_validation_date` DATE COMMENT 'Date of the most recent CMS validation survey conducted to verify that the accrediting bodys survey process meets CMS standards for deemed status programs. CMS conducts validation surveys on a sample of accredited organizations.',
    `next_survey_due_date` DATE COMMENT 'The projected or scheduled date by which the next accreditation survey must occur to maintain continuous accreditation. Calculated from the accreditation cycle and effective date. Used for survey readiness planning.',
    `plan_of_correction` STRING COMMENT 'Narrative description of the organizations Plan of Correction (PoC) submitted to the accrediting body or CMS in response to identified findings or deficiencies. Describes corrective actions, responsible parties, and timelines.',
    `poc_due_date` DATE COMMENT 'The regulatory deadline by which the Plan of Correction must be submitted to the accrediting body or CMS. Drives compliance workflow and escalation management.',
    `poc_submission_date` DATE COMMENT 'The date on which the Plan of Correction was submitted to the accrediting body or CMS. CMS requires PoC submission within 10 calendar days of receipt of the Statement of Deficiencies (Form CMS-2567).',
    `program_name` STRING COMMENT 'Human-readable name of the accreditation or certification program (e.g., Hospital Accreditation, Primary Stroke Center Certification, Chest Pain Center Certification, NCQA Health Plan Accreditation).',
    `program_number` STRING COMMENT 'Externally assigned or internally tracked unique program identifier issued by the accrediting body (e.g., TJC organization ID, CMS certification number, NCQA organization ID). Used for cross-referencing with accrediting body portals and regulatory submissions.',
    `program_status` STRING COMMENT 'Current lifecycle status of the accreditation program. active = currently accredited; pending = application submitted, awaiting decision; suspended = accreditation temporarily suspended; withdrawn = organization voluntarily withdrew; expired = accreditation lapsed without renewal; denied = accreditation application denied.. Valid values are `active|pending|suspended|withdrawn|expired|denied`',
    `program_type` STRING COMMENT 'Classification of the accreditation or certification program by scope and purpose (e.g., hospital_accreditation, disease_specific_certification, primary_stroke_center, chest_pain_center, ambulatory_care, behavioral_health, home_care, laboratory, long_term_care). [ENUM-REF-CANDIDATE: hospital_accreditation|disease_specific_certification|primary_stroke_center|chest_pain_center|ambulatory_care|behavioral_health|home_care|laboratory|long_term_care — promote to reference product]',
    `readiness_assessment_date` DATE COMMENT 'The date of the most recent internal mock survey, readiness tracer, or formal readiness assessment conducted in preparation for the accreditation survey. Supports TJC survey readiness and continuous compliance programs.',
    `readiness_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) from the most recent internal readiness assessment or mock survey, representing the organizations estimated compliance percentage with accreditation standards. Used for gap analysis and improvement prioritization.',
    `regulatory_body_contact` STRING COMMENT 'Name and contact information for the primary liaison or account representative at the accrediting body (e.g., TJC account executive, CMS regional office contact). Used for survey coordination and issue escalation.',
    `standard_level_deficiency_count` STRING COMMENT 'Number of findings classified as Standard-Level Deficiencies identified during the survey. These represent non-compliance at the individual standard level within a Condition of Participation.',
    `standards_chapters_reviewed` STRING COMMENT 'Comma-separated list or description of the accreditation standards chapters or domains reviewed during the survey (e.g., NPSG, EC, IC, HR, LD, MM, PC, RC, RI, TS for TJC; or CMS CoP conditions reviewed). Supports gap analysis and compliance tracking.',
    `state_license_number` STRING COMMENT 'State-issued facility license number associated with this accreditation program. Required for state regulatory reporting and cross-referencing with state department of health records.',
    `state_survey_agency` STRING COMMENT 'Name of the state survey agency responsible for conducting CMS validation surveys or state licensure surveys for this program (e.g., state department of health). Required for CMS deemed status programs.',
    `survey_date` DATE COMMENT 'The date on which the most recent accreditation survey or on-site review was conducted by the accrediting body. For multi-day surveys, this is the start date.',
    `survey_end_date` DATE COMMENT 'The date on which the most recent accreditation survey concluded. For single-day surveys, this equals survey_date. Used to calculate survey duration and schedule post-survey activities.',
    `survey_scope` STRING COMMENT 'Description of the scope of the survey including methodology applied (e.g., tracer methodology, environment of care review, life safety code survey, full organization survey, focused standards review). Free-text or structured description of areas covered.',
    `survey_type` STRING COMMENT 'Classification of the accreditation survey by its purpose and scheduling method. triennial = standard scheduled full survey; unannounced = surprise survey without advance notice; for_cause = triggered by complaint or adverse event; validation = CMS validation of deemed status; internal_mock = internal readiness simulation; readiness_tracer = internal tracer methodology readiness assessment.. Valid values are `triennial|unannounced|for_cause|validation|internal_mock|readiness_tracer`',
    `surveyor_team` STRING COMMENT 'Names or identifiers of the surveyors assigned to conduct the accreditation survey. May include lead surveyor and team members from the accrediting body.',
    `total_findings_count` STRING COMMENT 'Total number of accreditation findings, deficiencies, or Requirements for Improvement (RFIs) identified during the most recent survey. Used for benchmarking, trend analysis, and quality improvement prioritization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation program record was most recently modified. Supports change tracking, audit trail, and data quality monitoring.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_accreditation_program PRIMARY KEY(`accreditation_program_id`)
) COMMENT 'Accreditation program enrollment and status tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` (
    `accreditation_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each accreditation survey or readiness assessment record. Serves as the primary key for this entity.',
    `accreditation_program_id` BIGINT COMMENT 'FK to quality.accreditation_program',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site that is the subject of this accreditation survey.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Accreditation surveys review charge capture processes, CDM accuracy, and pricing transparency. Findings may require specific CDM entry updates to resolve deficiencies. Linking enables tracking of CDM ',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.committee. Business justification: Accreditation survey findings and corrective action plans are reviewed by committees (e.g., Accreditation Readiness Committee, Quality Council). This FK enables tracking which committee has oversight ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Accreditation surveys are formal external audits conducted by TJC, DNV, or other accrediting bodies. Findings must be tracked in the compliance audit system for corrective action planning, regulatory ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Accreditation survey costs (surveyor fees, staff time, corrective action implementation) are allocated to specific cost centers. Survey findings often require departmental budget adjustments for compl',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Accreditation surveys may be payer-initiated or payer-tracked for network quality assurance. Payers receive survey results to assess facility compliance with network quality standards and regulatory r',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Accreditation surveys (TJC, CAP, AABB) include research-specific standards: human subjects protection (RI chapter), investigational product management, research laboratory operations, and informed con',
    `accreditation_decision` STRING COMMENT 'Final accreditation decision issued by the accrediting body following the survey and review of any corrective action submissions. Values include Accredited (full compliance), Conditional (compliance with corrective action required), Preliminary Denial, Denial, or Not Applicable for internal assessments.. Valid values are `accredited|conditional|preliminary_denial|denial|not_applicable`',
    `accreditation_decision_date` DATE COMMENT 'Date on which the accrediting body issued the official accreditation decision. Used to track decision timelines and accreditation cycle management.',
    `accreditation_expiration_date` DATE COMMENT 'Date on which the accreditation award resulting from this survey expires, typically three years from the decision date for TJC triennial surveys. Drives scheduling of the next survey cycle.',
    `accreditation_standards_edition` STRING COMMENT 'Version or edition year of the accreditation standards manual applied during this survey (e.g., TJC Comprehensive Accreditation Manual for Hospitals 2024 edition). Ensures findings are evaluated against the correct standards version.',
    `accrediting_body` STRING COMMENT 'Name or code of the organization conducting the accreditation survey. Examples include The Joint Commission (TJC), Centers for Medicare and Medicaid Services (CMS), DNV Healthcare, Healthcare Facilities Accreditation Program (HFAP), Center for Improvement in Healthcare Quality (CIHQ), National Committee for Quality Assurance (NCQA), or INTERNAL for mock/readiness surveys. [ENUM-REF-CANDIDATE: TJC|CMS|DNV|HFAP|CIHQ|NCQA|INTERNAL — 7 candidates stripped; promote to reference product]',
    `cms_certification_number` STRING COMMENT 'The six-digit CMS Certification Number (CCN), formerly known as the Medicare Provider Number, assigned to the facility by the Centers for Medicare and Medicaid Services. Used to link survey records to CMS certification and reimbursement records.. Valid values are `^[0-9]{6}$`',
    `condition_level_deficiency` BOOLEAN COMMENT 'Indicates whether any Condition-Level deficiency (as opposed to Standard-Level) was cited during a CMS survey. Condition-Level deficiencies represent systemic non-compliance with a Condition of Participation and carry the most severe regulatory consequences.',
    `cop_deficiencies_cited` STRING COMMENT 'Number of CMS Conditions of Participation (CoP) deficiencies cited during the survey. CoP deficiencies are the most serious CMS findings and may jeopardize Medicare and Medicaid participation if not corrected.',
    `corrective_action_plan_status` STRING COMMENT 'Current status of the facilitys Corrective Action Plan (CAP) or Plan of Correction (PoC) developed in response to survey findings. Tracks whether corrective actions are required, in progress, submitted to the accrediting body, accepted, or overdue.. Valid values are `not_required|in_progress|submitted|accepted|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation survey record was first created in the system. Supports audit trail and data lineage requirements.',
    `environment_of_care_included` BOOLEAN COMMENT 'Indicates whether the Environment of Care (EC) standards chapter was included in the scope of this survey, covering safety management, security, hazardous materials, fire safety, medical equipment, and utilities.',
    `esc_acceptance_status` STRING COMMENT 'Status of the accrediting bodys review of the submitted Evidence of Standards Compliance (ESC). Indicates whether the corrective action evidence was accepted, rejected, partially accepted, or is still pending review.. Valid values are `accepted|rejected|pending|partial`',
    `esc_submission_date` DATE COMMENT 'Actual date on which the facility submitted its Evidence of Standards Compliance (ESC) to the accrediting body. Compared against the due date to assess timeliness of corrective action response.',
    `esc_submission_due_date` DATE COMMENT 'Deadline by which the facility must submit its Evidence of Standards Compliance (ESC) to the accrediting body addressing all Requirements for Improvement (RFI) identified during the survey.',
    `findings_count_immediate_threat` STRING COMMENT 'Number of findings classified at the highest priority level representing an Immediate Threat to Health or Safety (ITHS). These require urgent corrective action and may trigger conditional accreditation or denial.',
    `findings_count_observation` STRING COMMENT 'Number of lower-priority findings or observations noted during the survey that do not rise to the level of a formal Requirement for Improvement but are documented for quality improvement awareness.',
    `findings_count_requirement_improvement` STRING COMMENT 'Number of findings classified as Requirements for Improvement (RFI) — standards elements that were not fully compliant but do not represent an immediate threat. Must be addressed in the Evidence of Standards Compliance (ESC) submission.',
    `findings_count_total` STRING COMMENT 'Total number of all findings across all priority levels identified during the survey. Equals the sum of immediate threat, requirement for improvement, and observation findings.',
    `follow_up_survey_date` DATE COMMENT 'Scheduled or actual date of the follow-up or revisit survey required to verify correction of findings from this survey. Null if no follow-up survey is required.',
    `follow_up_survey_required` BOOLEAN COMMENT 'Indicates whether the accrediting body has required a follow-up or revisit survey to verify correction of findings. Typically triggered by Immediate Threat to Health or Safety findings or Condition-Level CMS deficiencies.',
    `infection_prevention_included` BOOLEAN COMMENT 'Indicates whether Infection Prevention and Control (IC) standards were included in the survey scope. Relevant for tracking Healthcare-Associated Infection (HAI) compliance including CLABSI, CAUTI, and SSI prevention standards.',
    `is_unannounced` BOOLEAN COMMENT 'Indicates whether this survey was conducted without prior notification to the facility. Unannounced surveys are standard for TJC triennial surveys and all CMS surveys, providing an unfiltered view of day-to-day operations.',
    `lead_surveyor_name` STRING COMMENT 'Full name of the primary surveyor or lead assessor assigned by the accrediting body or internal quality team to conduct this survey. Used for accountability and follow-up communications.',
    `life_safety_module_included` BOOLEAN COMMENT 'Indicates whether the Life Safety Code (LSC) module was included in the scope of this survey. TJC surveys may include a dedicated Life Safety specialist reviewing NFPA 101 compliance.',
    `national_patient_safety_goals_reviewed` BOOLEAN COMMENT 'Indicates whether the TJC National Patient Safety Goals (NPSG) were specifically reviewed during this survey. NPSGs address critical safety areas including patient identification, medication safety, infection prevention, and fall reduction.',
    `next_survey_target_date` DATE COMMENT 'Projected or scheduled date for the next accreditation survey cycle. Used for continuous survey readiness planning and resource allocation.',
    `notification_date` DATE COMMENT 'Date on which the facility received official notification of the upcoming survey. Null for unannounced surveys. Used to calculate preparation lead time.',
    `overall_readiness_score` DECIMAL(18,2) COMMENT 'Numeric score (typically expressed as a percentage 0.00–100.00) representing the facilitys overall compliance or readiness level as assessed during the survey. For internal mock surveys, this reflects the percentage of standards elements found compliant.',
    `preliminary_findings_summary` STRING COMMENT 'Narrative summary of preliminary findings communicated to facility leadership at the survey exit conference before the formal report is issued. Captures key themes, high-priority concerns, and commendations noted by surveyors.',
    `standards_chapters_reviewed` STRING COMMENT 'Comma-delimited list or narrative description of the accreditation standards chapters or domains reviewed during the survey (e.g., Environment of Care, Life Safety, Infection Prevention, Medication Management, National Patient Safety Goals, Human Resources, Leadership).',
    `survey_duration_days` DECIMAL(18,2) COMMENT 'Total number of calendar days the survey spanned from start to end date. Used for resource planning and benchmarking survey scope.',
    `survey_end_date` DATE COMMENT 'The date on which the on-site survey or assessment concluded. Multi-day surveys will have an end date later than the start date.',
    `survey_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the accrediting body or internal quality department to uniquely reference this survey event (e.g., TJC survey tracking number, CMS survey ID, or internal mock survey reference number).',
    `survey_report_received_date` DATE COMMENT 'Date on which the facility received the official written survey report from the accrediting body. Triggers the formal corrective action response timeline.',
    `survey_scope` STRING COMMENT 'Description of the scope of the survey including which care settings, service lines, or departments were included (e.g., inpatient, emergency department, surgical services, behavioral health, ambulatory). May reference tracer methodology, environment of care, or life safety module scope.',
    `survey_start_date` DATE COMMENT 'The date on which the on-site survey or assessment officially commenced. For unannounced surveys, this is the date surveyors arrived on-site.',
    `survey_status` STRING COMMENT 'Current lifecycle state of the accreditation survey record, tracking progression from scheduling through completion and accreditation decision.. Valid values are `scheduled|in_progress|completed|cancelled|pending_decision`',
    `survey_type` STRING COMMENT 'Classification of the survey by its purpose and scheduling basis. Triennial surveys are scheduled full accreditation reviews; unannounced surveys occur without prior notice; for-cause surveys are triggered by complaints or adverse events; validation surveys verify prior findings; mock surveys are internal simulations; readiness tracers are targeted internal assessments of specific standards chapters.. Valid values are `triennial|unannounced|for_cause|validation|mock|readiness_tracer`',
    `surveyor_team_composition` STRING COMMENT 'Description of the full surveyor or assessor team including roles and specialties (e.g., physician surveyor, nurse surveyor, life safety specialist, behavioral health surveyor). Captures team size and expertise mix for survey context.',
    `system_tracer_topics` STRING COMMENT 'Comma-delimited list of system tracer topics evaluated during the survey (e.g., Medication Management, Infection Control, Data Use, Emergency Management). System tracers evaluate organization-wide processes rather than individual patient care.',
    `tjc_organization_code` STRING COMMENT 'Unique identifier assigned by The Joint Commission to the healthcare organization in the TJC Connect portal. Used to cross-reference survey records with TJCs accreditation management system.',
    `tracer_methodology_used` BOOLEAN COMMENT 'Indicates whether the TJC tracer methodology was employed during this survey, where surveyors follow individual patient care experiences across departments and care transitions to evaluate standards compliance in real-world context.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation survey record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_accreditation_survey PRIMARY KEY(`accreditation_survey_id`)
) COMMENT 'Accreditation survey events and results.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` (
    `standard_finding_id` BIGINT COMMENT 'Unique surrogate identifier for each compliance finding record. Primary key for the standard_finding data product in the quality domain.',
    `accreditation_program_id` BIGINT COMMENT 'FK to quality.accreditation_program',
    `accreditation_survey_id` BIGINT COMMENT 'Reference to the parent accreditation survey, regulatory inspection, or internal readiness assessment event that generated this finding.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Accreditation standard findings are audit findings that require compliance tracking for corrective action plans, regulatory submission to CMS, and verification of effectiveness. Compliance system mana',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the compliance finding was identified during the survey or inspection.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Regulatory findings often cite charge capture or pricing issues requiring CDM corrections. Linking enables tracking of specific CDM entries implicated in deficiencies, supports corrective action plans',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.committee. Business justification: Standard findings (deficiencies, observations) from accreditation surveys are reviewed and addressed by committees. This FK enables tracking which committee is responsible for the plan of correction a',
    `interface_downtime_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_downtime. Business justification: Accreditation findings related to data exchange failures (e.g., missed lab results, delayed ADT notifications) need to reference specific downtime events as root cause. This link supports evidence-bas',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Accreditation survey findings frequently cite specific supplies or equipment (expired items found, improper storage conditions, missing safety equipment). Linking to material master enables targeted c',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: Accreditation survey findings (ACR, TJC, state) often cite specific imaging equipment for calibration, QC documentation, or safety deficiencies. Standard findings must link to modality for corrective ',
    `prior_finding_standard_finding_id` BIGINT COMMENT 'Reference to the previous standard_finding record for the same standard citation at this facility, when repeat_finding is true. Enables lineage tracking of recurring deficiencies.',
    `affected_department` STRING COMMENT 'The clinical or operational department, unit, or service line within the facility where the deficiency was identified (e.g., ICU, Emergency Department, Pharmacy, Operating Room). Supports departmental accountability tracking.',
    `cms_acceptance_date` DATE COMMENT 'The date on which CMS or the State Survey Agency formally accepted the Plan of Correction (POC) for this finding.',
    `cms_acceptance_status` STRING COMMENT 'The acceptance status of the Plan of Correction (POC) as determined by the Centers for Medicare and Medicaid Services (CMS) or the applicable State Survey Agency. Tracks whether CMS has formally accepted the facilitys corrective action response.. Valid values are `Pending|Accepted|Rejected|Partially Accepted|Not Applicable`',
    `cms_certification_number` STRING COMMENT 'The CMS Certification Number (CCN), formerly known as the Medicare Provider Number, for the facility associated with this finding. Required for CMS regulatory reporting and public disclosure.',
    `compliance_due_date` DATE COMMENT 'The date by which the facility must achieve full compliance with the cited standard and complete all corrective actions. May differ from the POC submission due date.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the specific corrective actions taken or planned to address the root cause of the finding and achieve sustained compliance.',
    `corrective_action_owner` STRING COMMENT 'Name or role title of the individual or department accountable for executing and completing the corrective actions specified in the Plan of Correction.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this standard finding record was first created in the system. Supports audit trail and data lineage requirements.',
    `deficiency_tag_number` STRING COMMENT 'The CMS deficiency tag number (e.g., F-Tag for long-term care, K-Tag for life safety code) associated with this finding. Provides standardized cross-reference to the CMS regulatory citation database.',
    `effectiveness_verification_date` DATE COMMENT 'The date on which corrective action effectiveness was formally verified and documented, confirming that the deficiency has been sustainably resolved.',
    `effectiveness_verified` BOOLEAN COMMENT 'Indicates whether the corrective actions have been verified as effective through follow-up monitoring, re-audit, or surveyor revisit, confirming sustained compliance.',
    `element_of_performance` STRING COMMENT 'The specific Element of Performance (EP) within a TJC standard, or the equivalent sub-requirement within a CMS Condition of Participation, that was cited as deficient. Granular citation enabling targeted corrective action.',
    `enforcement_action` STRING COMMENT 'The regulatory enforcement remedy imposed as a result of this finding, if applicable (e.g., Civil Monetary Penalty, Denial of Payment for New Admissions, Temporary Management, Termination from Medicare/Medicaid). [ENUM-REF-CANDIDATE: None|Civil Monetary Penalty|Denial of Payment|Temporary Management|Termination|State Monitor|Directed Plan of Correction — promote to reference product]. Valid values are `None|Civil Monetary Penalty|Denial of Payment|Temporary Management|Termination|State Monitor`',
    `evidence_of_deficiency` STRING COMMENT 'Specific evidence cited by the surveyor to support the finding, including observations, document reviews, staff interviews, or patient record reviews that substantiate the deficiency.',
    `finding_date` DATE COMMENT 'The date on which the compliance finding was identified during the survey, inspection, or internal assessment. The principal real-world event date for this record.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the compliance deficiency or observation as documented by the surveyor or internal assessor. Describes what was observed, what was missing, or what was non-compliant.',
    `finding_number` STRING COMMENT 'Human-readable, externally-known identifier assigned to this finding by the surveying body or internal tracking system (e.g., TJC finding reference number, CMS deficiency tag number). Used for cross-referencing with official survey reports.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the compliance finding, tracking progression from identification through resolution and regulatory acceptance.. Valid values are `Open|In Progress|Submitted|Accepted|Rejected|Closed`',
    `finding_type` STRING COMMENT 'Classification of the finding severity and regulatory category as assigned by the surveying body. Drives escalation, reporting timelines, and plan of correction requirements. [ENUM-REF-CANDIDATE: Requirement for Improvement|Immediate Threat to Life|Condition-Level Deficiency|Standard-Level Deficiency|Observation — promote to reference product if additional types are needed]. Valid values are `Requirement for Improvement|Immediate Threat to Life|Condition-Level Deficiency|Standard-Level Deficiency|Observation`',
    `immediate_jeopardy` BOOLEAN COMMENT 'Indicates whether the finding has been classified as Immediate Jeopardy (IJ) — a situation in which the facilitys noncompliance has caused, or is likely to cause, serious injury, harm, impairment, or death to a patient. Triggers mandatory expedited regulatory response.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which ongoing compliance monitoring activities are conducted following corrective action implementation.. Valid values are `Daily|Weekly|Monthly|Quarterly|Annually|Ad Hoc`',
    `monitoring_method` STRING COMMENT 'Description of the ongoing monitoring mechanism established to verify sustained compliance after corrective actions are implemented (e.g., monthly audits, staff competency checks, policy review cycles).',
    `plan_of_correction` STRING COMMENT 'The formal Plan of Correction (POC) narrative submitted by the facility in response to the finding, describing corrective actions, responsible parties, and timelines to achieve and maintain compliance.',
    `poc_due_date` DATE COMMENT 'The regulatory or accreditation deadline by which the Plan of Correction (POC) must be submitted to the surveying body. Drives compliance workflow prioritization.',
    `poc_submission_date` DATE COMMENT 'The date on which the Plan of Correction (POC) was formally submitted to the surveying body or regulatory agency.',
    `repeat_finding` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously cited deficiency for the same standard at this facility. Repeat findings carry heightened regulatory scrutiny and may trigger escalated enforcement actions.',
    `resolution_date` DATE COMMENT 'The date on which the finding was formally resolved, corrective actions were verified as complete, and the finding was closed in the tracking system.',
    `revisit_date` DATE COMMENT 'The scheduled or actual date of the follow-up revisit by the surveying body to verify correction of this finding.',
    `revisit_required` BOOLEAN COMMENT 'Indicates whether a follow-up revisit by the surveying body is required to verify correction of this finding before the finding can be closed.',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause analysis findings identifying the underlying systemic or process factors that contributed to the compliance deficiency.',
    `scope_code` STRING COMMENT 'CMS scope classification indicating how broadly the deficiency affects patients or residents: Isolated (limited number), Pattern (more than limited), or Widespread (majority or all). Combined with severity to determine the CMS scope-severity grid rating.. Valid values are `Isolated|Pattern|Widespread`',
    `scope_severity_grid` STRING COMMENT 'The combined CMS scope and severity grid rating (e.g., D, G, J) derived from the intersection of scope and severity classifications. Determines enforcement remedies and civil monetary penalty calculations.',
    `severity_code` STRING COMMENT 'CMS severity classification (A through L on the scope-severity grid, with A-C representing no actual harm, D-F low actual harm, G-I high actual harm, J-L immediate jeopardy). Stored as the letter code. [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I|J|K|L — promote to reference product]. Valid values are `A|B|C|D|E|F`',
    `standard_chapter` STRING COMMENT 'The chapter or section grouping within the accreditation or regulatory framework to which the cited standard belongs (e.g., Environment of Care, Infection Prevention and Control, Patient Rights). Supports trend analysis by chapter.',
    `standard_reference_code` STRING COMMENT 'The specific regulatory standard, condition, or requirement code that was found to be deficient or at risk (e.g., TJC NPSG.07.01.01, CMS CoP 482.13, State regulation section number). The authoritative citation for the finding.',
    `standard_reference_description` STRING COMMENT 'Full descriptive title of the regulatory standard, condition, or requirement cited in this finding (e.g., Reduce the Risk of Health Care-Associated Infections). Provides human-readable context for the standard_reference_code.',
    `survey_end_date` DATE COMMENT 'The date the survey, inspection, or assessment concluded. Used to bound the survey window and associate findings to the correct survey event.',
    `survey_start_date` DATE COMMENT 'The date the survey, inspection, or assessment began. Used to associate the finding with the full survey window and calculate survey duration.',
    `survey_type` STRING COMMENT 'Type of survey or inspection that produced this finding, distinguishing between accreditation surveys, regulatory inspections, and internal assessments. [ENUM-REF-CANDIDATE: TJC Accreditation|CMS CoP|State Survey|Internal Readiness|CMS Validation|Complaint Investigation|Focused Survey — promote to reference product]. Valid values are `TJC Accreditation|CMS CoP|State Survey|Internal Readiness|CMS Validation|Complaint Investigation`',
    `surveying_body` STRING COMMENT 'The regulatory or accrediting organization that conducted the survey and issued this finding (e.g., The Joint Commission, CMS, State Department of Health, OIG). Determines applicable standards and reporting obligations. [ENUM-REF-CANDIDATE: TJC|CMS|State DOH|OIG|Internal|DNV|HFAP — 7 candidates stripped; promote to reference product]',
    `tjc_npsg_number` STRING COMMENT 'The TJC National Patient Safety Goal (NPSG) number cited in this finding, when applicable (e.g., NPSG.01.01.01 for patient identification, NPSG.07.01.01 for infection prevention). Null when the finding does not relate to an NPSG.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this standard finding record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_standard_finding PRIMARY KEY(`standard_finding_id`)
) COMMENT 'Accreditation survey findings and deficiencies.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` (
    `improvement_initiative_id` BIGINT COMMENT 'Unique surrogate identifier for the quality improvement initiative record in the lakehouse silver layer.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Quality improvement initiatives require dedicated operational and capital funding. Healthcare organizations budget specifically for QI projects (PDSA cycles, process improvements, technology implement',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Major quality improvement initiatives (new clinical equipment, facility upgrades for accreditation, EMR enhancements) are tracked as capital projects with multi-year depreciation schedules. Finance te',
    `care_site_id` BIGINT COMMENT 'Identifier of the primary facility or care site where the improvement initiative is being implemented.',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.committee. Business justification: Quality improvement initiatives are sponsored, overseen, or governed by committees (e.g., Quality Improvement Committee, Performance Improvement Committee). This FK enables tracking which committee ha',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Quality improvement initiatives often originate from compliance audit findings, accreditation deficiencies, or regulatory citations. Linking initiatives to formal corrective action plans enables track',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Supply chain improvement initiatives (reduce surgical tray waste, standardize preference cards, eliminate expired inventory) target specific items. Link to material master enables baseline measurement',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Quality improvement initiatives are often payer-driven (reducing readmissions, improving HEDIS rates) as part of VBC contracts. Payers fund initiatives and track performance against contract targets.',
    `employee_id` BIGINT COMMENT 'Identifier of the executive or senior clinical leader who sponsors and is accountable for the initiative. Typically a Chief Medical Officer, Chief Nursing Officer, or department VP.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: Improvement initiatives are launched and managed under specific quality programs (e.g., VBP, MIPS, TJC accreditation). Currently improvement_initiative has regulatory_program as STRING, which should b',
    `readmission_id` BIGINT COMMENT 'Foreign key linking to encounter.readmission. Business justification: Readmission reduction is a major quality improvement focus (HRRP penalties, CMS readmission measures). Real business process: QI teams track specific readmission cases in improvement initiatives, anal',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Quality improvement initiatives often originate from research findings or run parallel to research studies. Linkage tracks translation of research into practice improvement, supports pragmatic trial d',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Quality improvement initiatives often target specialty-specific clinical processes (surgical site infection reduction in orthopedics, door-to-balloon time in cardiology). Specialty attribution enables',
    `actual_completion_date` DATE COMMENT 'Date on which the initiative was formally completed or closed. Null if still active. Used to calculate on-time completion rates.',
    `aim_statement` STRING COMMENT 'Specific, measurable, time-bound goal statement for the initiative following IHI Model for Improvement format (e.g., By December 2024, reduce CAUTI rate from 2.1 to 1.0 per 1,000 catheter days). Core element of CMS quality improvement submissions.',
    `baseline_period_end` DATE COMMENT 'End date of the measurement period used to calculate the baseline performance value.',
    `baseline_period_start` DATE COMMENT 'Start date of the measurement period used to calculate the baseline performance value.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Quantitative baseline performance level for the target measure at the time the initiative was launched. Establishes the starting point for measuring improvement.',
    `cms_submission_date` DATE COMMENT 'Date on which initiative data was submitted to CMS for quality program reporting. Null if not yet submitted or not required.',
    `cms_submission_status` STRING COMMENT 'Status of the CMS quality program submission associated with this initiative (e.g., pending, submitted, accepted, rejected). Tracks compliance with CMS reporting obligations.. Valid values are `not_required|pending|submitted|accepted|rejected`',
    `corrective_action_plan` STRING COMMENT 'Narrative summary of the corrective actions and interventions planned or underway as part of this initiative. Supports TJC survey readiness and CMS Conditions of Participation documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this improvement initiative record was first created in the system. Supports audit trail and data lineage requirements.',
    `current_performance_date` DATE COMMENT 'Date on which the current performance value was last measured or updated.',
    `current_performance_value` DECIMAL(18,2) COMMENT 'Most recently recorded performance value for the target measure. Enables real-time progress tracking against baseline and goal.',
    `current_phase` STRING COMMENT 'Current phase of the improvement cycle (e.g., Plan, Do, Study, Act, Sustain for PDSA-based initiatives). Tracks progress through the improvement methodology lifecycle.. Valid values are `plan|do|study|act|sustain|closed`',
    `department_name` STRING COMMENT 'Name of the primary clinical or operational department where the initiative is focused (e.g., ICU, Emergency Department, Pharmacy). Supports departmental performance reporting.',
    `goal_value` DECIMAL(18,2) COMMENT 'Target quantitative performance level the initiative aims to achieve by the target completion date. Defined in the aim statement and used to assess initiative success.',
    `hai_event_type` STRING COMMENT 'If the initiative targets a specific Healthcare-Associated Infection (HAI) type, identifies the HAI category (e.g., Central Line-Associated Bloodstream Infection (CLABSI), Catheter-Associated Urinary Tract Infection (CAUTI), Surgical Site Infection (SSI)). Null or none for non-HAI initiatives. [ENUM-REF-CANDIDATE: CLABSI|CAUTI|SSI|MRSA|CDI|VAP|none — 7 candidates stripped; promote to reference product]',
    `improvement_methodology` STRING COMMENT 'Formal quality improvement methodology applied to this initiative (e.g., Plan-Do-Study-Act (PDSA), Lean, Six Sigma, IHI Model for Improvement, Root Cause Analysis (RCA), Failure Mode and Effects Analysis (FMEA)). Required for TJC performance improvement chapter compliance. [ENUM-REF-CANDIDATE: PDSA|Lean|Six_Sigma|IHI_Model|RCA|FMEA|Kaizen|other — promote to reference product]',
    `initiative_name` STRING COMMENT 'Short, descriptive title of the quality improvement initiative (e.g., Reduce CAUTI Rate in ICU by 30%). Used in dashboards, reports, and TJC performance improvement documentation.',
    `initiative_number` STRING COMMENT 'Externally-known, human-readable business identifier for the initiative (e.g., QI-2024-00042). Used in regulatory submissions, TJC survey documentation, and cross-departmental communications.. Valid values are `^QI-[0-9]{4}-[0-9]{5}$`',
    `initiative_status` STRING COMMENT 'Current lifecycle state of the improvement initiative. Drives workflow routing, reporting filters, and CMS quality program compliance tracking.. Valid values are `draft|active|on_hold|completed|cancelled`',
    `initiative_type` STRING COMMENT 'Categorical classification of the initiative by primary focus area. Supports portfolio analysis and alignment to organizational quality strategy. [ENUM-REF-CANDIDATE: patient_safety|clinical_quality|operational_efficiency|regulatory_compliance|patient_experience|workforce_development — promote to reference product]. Valid values are `patient_safety|clinical_quality|operational_efficiency|regulatory_compliance|patient_experience|workforce_development`',
    `is_cms_reportable` BOOLEAN COMMENT 'Indicates whether this initiative is associated with a CMS-reportable quality measure or program (e.g., VBP, MIPS, HAI reporting). Drives inclusion in CMS submission workflows.',
    `is_sentinel_event_related` BOOLEAN COMMENT 'Indicates whether this initiative was triggered by or is directly related to a sentinel event review. Sentinel event-related initiatives require expedited TJC reporting.',
    `is_tjc_reportable` BOOLEAN COMMENT 'Indicates whether this initiative is required to be documented and reported as part of TJC performance improvement chapter compliance or survey readiness.',
    `lessons_learned` STRING COMMENT 'Narrative summary of key insights, successes, and failures identified during the initiative. Supports organizational learning, knowledge management, and future initiative planning.',
    `pdsa_cycle_count` STRING COMMENT 'Number of Plan-Do-Study-Act (PDSA) or improvement cycles completed to date for this initiative. Tracks iterative improvement progress per IHI Model for Improvement.',
    `priority_level` STRING COMMENT 'Organizational priority assigned to the initiative, used to allocate resources and sequence work across the quality improvement portfolio.. Valid values are `critical|high|medium|low`',
    `problem_statement` STRING COMMENT 'Narrative description of the specific quality problem or gap being addressed. Defines the what and why of the initiative. Required for TJC performance improvement documentation.',
    `reporting_period_end` DATE COMMENT 'End date of the measurement or reporting period for which initiative performance data is being captured.',
    `reporting_period_start` DATE COMMENT 'Start date of the measurement or reporting period for which initiative performance data is being captured. Aligns with CMS and HEDIS reporting cycles.',
    `service_line` STRING COMMENT 'Clinical or operational service line associated with the initiative (e.g., Cardiovascular, Oncology, Women and Children). Enables service-line-level quality portfolio analysis.',
    `source_system_initiative_reference` STRING COMMENT 'Native identifier of this initiative record in the originating operational system (e.g., Epic Healthy Planet project ID). Enables reconciliation between the lakehouse and source systems.',
    `start_date` DATE COMMENT 'Date on which the improvement initiative formally commenced. Used for timeline tracking and regulatory reporting.',
    `sustainability_plan` STRING COMMENT 'Narrative description of the plan to sustain achieved improvements after the initiative closes, including process changes, policy updates, and monitoring mechanisms.',
    `target_completion_date` DATE COMMENT 'Planned date by which the initiative aims to achieve its goal performance value and transition to the sustain phase.',
    `team_members` STRING COMMENT 'Comma-separated list of names or employee IDs of multidisciplinary team members participating in the initiative. Supports accountability tracking and TJC performance improvement documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this improvement initiative record was last modified. Supports change tracking, audit trail, and incremental ETL (Extract Transform Load) processing.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_improvement_initiative PRIMARY KEY(`improvement_initiative_id`)
) COMMENT 'Quality improvement initiatives and projects.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` (
    `quality_peer_review_id` BIGINT COMMENT 'Unique surrogate identifier for the physician peer review case record in the medical staff quality committee system.',
    `radiology_peer_review_id` BIGINT COMMENT 'Unique surrogate identifier for each radiology peer review event record in the silver layer lakehouse. Primary key for this entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Peer review programs are audited for OPPE/FPPE compliance, ACR RadPeer standards, and medical staff bylaws adherence. Compliance verifies peer review program effectiveness and regulatory compliance.',
    `care_site_id` BIGINT COMMENT 'Reference to the hospital or care facility where the reviewed clinical event occurred.',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.committee. Business justification: Physician peer review cases are conducted by medical staff quality committees (e.g., Peer Review Committee, Credentials Committee). This FK enables tracking which committee conducted the peer review, ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Peer review programs have administrative coordinators (QA nurses, radiology managers) who manage case selection, distribution, and follow-up. Required for OPPE/FPPE programs and accreditation.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Peer review discrepancies trigger corrective action plans for quality improvement and patient safety. Quality/compliance departments create CAPs to address systematic issues identified through peer re',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Peer reviews evaluate appropriateness of procedure coding and clinical documentation supporting CPT code assignment. Medical staff peer review committees require validated CPT code references to asses',
    `demographics_id` BIGINT COMMENT 'Reference to the patient whose care episode is the subject of this peer review case. Links to the Master Patient Index (MPI).',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Peer reviews evaluate DRG assignment appropriateness and case complexity for quality of care assessment. Medical staff peer review committees require DRG reference data to assess whether clinical docu',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Peer reviews evaluate appropriateness of diagnosis coding and clinical documentation supporting ICD-10 code assignment. Medical staff peer review committees require validated ICD code references to as',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to compliance.investigation. Business justification: Peer reviews identifying care quality issues, standard-of-care violations, or potential regulatory non-compliance trigger formal compliance investigations. Investigations assess whether findings requi',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Surgical peer review cases require OR suite linkage for surgical site infection analysis, equipment availability assessment, and OR-specific protocol compliance review. Surgical quality committees inv',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department (e.g., Surgery, Emergency Medicine, Cardiology) responsible for the care under review.',
    `report_id` BIGINT COMMENT 'Reference to the radiology report that was authored by the original interpreting radiologist and is being reviewed in this peer review event.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician whose clinical performance or care decisions are under review. Used for Ongoing Professional Practice Evaluation (OPPE) and Focused Professional Practice Evaluation (FPPE) tracking.',
    `quality_clinician_id` BIGINT COMMENT '',
    `measure_id` BIGINT COMMENT 'Reference to a specific quality measure (e.g., HEDIS, CMS eCQM, VBP measure) that this peer review case is associated with or contributes to.',
    `report_addendum_id` BIGINT COMMENT 'Reference to the addendum or amended radiology report created as a result of this peer review, if applicable. Populated only when review_disposition is addendum_required or report_amended. Supports audit trail linking original and corrected reports.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Peer review of care involving research subjects or investigational procedures requires protocol context for proper clinical evaluation. Reviewers must assess whether research participation influenced ',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Peer review cases requiring patient contact for additional information or clarification need documented consent separate from treatment consent. OPPE/FPPE processes involving patient interviews requir',
    `udi_record_id` BIGINT COMMENT 'Foreign key linking to supply.udi_record. Business justification: Peer reviews of surgical cases with implants require device-level detail to assess appropriateness of device selection, sizing, and placement technique. Supports OPPE/FPPE evaluation of surgeon compet',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Peer review cases analyzed by unit for unit-specific clinical practice patterns and educational opportunities. Medical staff committees review unit-level peer review findings to identify system issues',
    `visit_id` BIGINT COMMENT 'Reference to the specific clinical encounter (inpatient admission, ED visit, outpatient visit) that triggered the peer review case.',
    `visit_provider_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_provider. Business justification: Peer review evaluates individual provider clinical performance on specific cases. Real business process: Peer review committees assess care delivered by specific providers during visits, need visit_pr',
    `accession_number` STRING COMMENT 'The RIS-assigned accession number of the original imaging study that is the subject of this peer review. Serves as the primary business identifier linking the review to the source imaging order and PACS study.',
    `acr_accreditation_cycle` STRING COMMENT 'The ACR accreditation cycle year range (e.g., 2023-2026) to which this peer review event is attributed. Used to aggregate peer review volumes and discrepancy rates for ACR accreditation submission and renewal reporting.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `acr_radpeer_score` STRING COMMENT 'The ACR RADPEER 2.0 concordance rating assigned by the reviewing radiologist on a 1–4 scale: 1 = Agree with interpretation; 2 = Disagree, but would not have changed management; 3 = Disagree, may have changed management; 4 = Disagree, would have changed management. Drives quality reporting and radiologist performance management.',
    `action_completion_date` DATE COMMENT 'The actual date on which the required corrective or educational action was completed and verified by the medical staff office.',
    `action_description` STRING COMMENT 'Detailed narrative of the specific corrective or educational action taken, including any conditions, timelines, or requirements imposed on the reviewed provider.',
    `action_due_date` DATE COMMENT 'Target date by which the required corrective or educational action must be completed by the reviewed provider.',
    `action_taken` STRING COMMENT 'The formal action taken by the medical staff committee as a result of the peer review determination. [ENUM-REF-CANDIDATE: no_action|letter_of_concern|education_required|proctoring|privilege_restriction|privilege_suspension|privilege_revocation|referral_to_mec|voluntary_relinquishment — promote to reference product]',
    `appeal_resolution_date` DATE COMMENT 'The date on which the formal appeal of the peer review determination was resolved by the appellate hearing panel.',
    `appeal_status` STRING COMMENT 'Status of any formal appeal filed by the reviewed provider against the peer review determination or action taken.. Valid values are `not_appealed|appeal_pending|appeal_upheld|appeal_overturned`',
    `blinded_review_flag` BOOLEAN COMMENT 'Indicates whether the peer review was conducted in a blinded manner, meaning the reviewing radiologist did not have access to the original report at the time of review. True = blinded review (ACR RADPEER preferred methodology); False = non-blinded review.',
    `body_part_examined` STRING COMMENT 'The anatomical region or body part that was the primary subject of the imaging study under review, using SNOMED CT or DICOM body part terminology (e.g., CHEST, ABDOMEN, BRAIN, SPINE). Supports subspecialty-level peer review analytics.',
    `care_determination` STRING COMMENT 'The formal committee determination of whether the care provided was clinically appropriate: appropriate (care met standard), appropriate with suggestions (care met standard but improvement opportunities identified), not appropriate (care did not meet standard), or unable to determine (insufficient information).. Valid values are `appropriate|appropriate_with_suggestions|not_appropriate|unable_to_determine`',
    `care_event_date` DATE COMMENT 'The date on which the clinical care event under review occurred (e.g., date of surgery, date of adverse event, date of the encounter being reviewed). Distinct from the case open date.',
    `case_conference_flag` BOOLEAN COMMENT 'Indicates whether this peer review case was referred to or discussed at a departmental case conference or quality committee meeting. True = case was presented at conference; False = not referred to conference. Supports TJC quality committee documentation requirements.',
    `case_number` STRING COMMENT 'Externally-known, human-readable case identifier assigned by the medical staff office or quality committee (e.g., PR-2024-00412). Used for tracking, correspondence, and committee minutes.',
    `case_open_date` DATE COMMENT 'The date on which the peer review case was formally opened and assigned to a reviewer by the medical staff office.',
    `case_status` STRING COMMENT 'Current workflow state of the peer review case through the medical staff quality committee process.. Valid values are `open|in_review|pending_committee|closed|appealed|deferred`',
    `case_summary` STRING COMMENT 'Narrative summary of the clinical case under review, including relevant clinical context, key events, and the basis for the review. Protected under peer review confidentiality statutes.',
    `clinical_history_available_flag` BOOLEAN COMMENT 'Indicates whether adequate clinical history was available to the original interpreting radiologist at the time of interpretation. Contextual factor used in assessing the fairness and validity of the peer review discrepancy rating.',
    `committee_review_date` DATE COMMENT 'The date on which the medical staff quality committee formally reviewed and voted on the case determination. May differ from the individual reviewer completion date.',
    `confidentiality_protection_flag` BOOLEAN COMMENT 'Indicates whether this peer review record is protected under applicable state peer review protection statutes, shielding it from discovery in civil litigation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this peer review case record was first created in the system.',
    `discrepancy_category` STRING COMMENT 'Classification of the interpretation discrepancy identified during peer review. none = no discrepancy found (RADPEER score 1); minor = discrepancy unlikely to change clinical management (RADPEER score 2); major = discrepancy that may or would change clinical management (RADPEER scores 3–4). Drives escalation and reporting workflows.. Valid values are `none|minor|major`',
    `discrepancy_description` STRING COMMENT 'Free-text narrative describing the nature of the interpretation discrepancy identified by the reviewing radiologist. Captures the specific finding, anatomical location, and clinical significance. Protected under peer review privilege in most jurisdictions.',
    `discrepancy_type` STRING COMMENT 'Categorical classification of the type of interpretation error or discrepancy identified. missed_finding = finding present but not reported; mischaracterization = finding reported but incorrectly described; incorrect_recommendation = appropriate finding but wrong follow-up recommendation; incomplete_report = report lacks required elements; wrong_anatomy = finding attributed to incorrect anatomical location. [ENUM-REF-CANDIDATE: missed_finding|mischaracterization|incorrect_recommendation|incomplete_report|wrong_anatomy — promote to reference product]. Valid values are `missed_finding|mischaracterization|incorrect_recommendation|incomplete_report|wrong_anatomy`',
    `educational_feedback_flag` BOOLEAN COMMENT 'Indicates whether the peer review event generated educational feedback to be communicated to the original interpreting radiologist. True = educational feedback was provided; False = no educational feedback generated. Supports CME tracking and radiologist performance improvement programs.',
    `educational_opportunity_description` STRING COMMENT 'Narrative description of the specific educational opportunity identified for the reviewed provider (e.g., documentation improvement, clinical guideline adherence, procedural technique).',
    `educational_opportunity_flag` BOOLEAN COMMENT 'Indicates whether the peer review case identified an educational opportunity for the reviewed provider, regardless of the care determination outcome.',
    `escalated_to_chair_flag` BOOLEAN COMMENT 'Indicates whether this peer review case was escalated to the radiology department chair or medical director due to a major discrepancy or patient safety concern. True = escalated; False = not escalated. Triggers formal performance management workflow.',
    `external_reviewer_organization` STRING COMMENT 'Name of the external organization or independent review entity engaged to conduct the peer review when an internal reviewer is not available or a conflict of interest exists.',
    `fppe_trigger_flag` BOOLEAN COMMENT 'Indicates whether this peer review case resulted in the initiation of a Focused Professional Practice Evaluation (FPPE) for the reviewed provider.',
    `icd10_finding_code` STRING COMMENT 'The ICD-10-CM diagnosis code corresponding to the primary imaging finding or discrepancy identified during peer review. Supports clinical coding alignment, quality reporting, and population health analytics.. Valid values are `^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$`',
    `modality_code` STRING COMMENT 'DICOM-standard modality code identifying the imaging technology used for the study under review (e.g., CT = Computed Tomography, MR = Magnetic Resonance Imaging, XR = X-Ray, US = Ultrasound, PT = PET). Used for subspecialty-stratified peer review reporting and ACR accreditation compliance. [ENUM-REF-CANDIDATE: CT|MR|XR|US|PT|NM|MG|FL|DX|CR — 10 candidates stripped; promote to reference product]',
    `npdb_report_date` DATE COMMENT 'The date on which the adverse action was reported to the National Practitioner Data Bank (NPDB). Required within 30 days of the action per HCQIA.',
    `npdb_reportable_flag` BOOLEAN COMMENT 'Indicates whether the action taken as a result of this peer review case meets the threshold for mandatory reporting to the National Practitioner Data Bank (NPDB) under HCQIA.',
    `oppe_cycle` STRING COMMENT 'The OPPE review cycle period to which this peer review case contributes (e.g., 2024-H1, 2024-Q3). Used to aggregate peer review outcomes into the providers OPPE profile for reappointment decisions.',
    `oppe_fppe_flag` BOOLEAN COMMENT 'Indicates whether this peer review event is being counted toward the radiologists Ongoing Professional Practice Evaluation (OPPE) or Focused Professional Practice Evaluation (FPPE) for medical staff credentialing and privileging purposes. True = counts toward OPPE/FPPE; False = routine QA only.',
    `original_radiologist_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the radiologist who authored the original interpretation being reviewed. Used for performance tracking and credentialing compliance.. Valid values are `^[0-9]{10}$`',
    `original_radiologist_response` STRING COMMENT 'Free-text response or rebuttal provided by the original interpreting radiologist in response to the peer review findings. Supports the formal peer review appeal and feedback loop process. Protected under peer review privilege.',
    `original_report_finalized_datetime` TIMESTAMP COMMENT 'The date and time the original radiology report was finalized (signed/attested) by the interpreting radiologist. Used to calculate the lag between report finalization and peer review, and to assess timeliness of discrepancy identification.',
    `patient_outcome` STRING COMMENT 'The clinical outcome experienced by the patient as a result of the care event under review. Used to contextualize the severity of the case and inform the care determination.. Valid values are `death|permanent_harm|temporary_harm|no_harm|unknown`',
    `patient_safety_event_flag` BOOLEAN COMMENT 'Indicates whether the discrepancy identified in this peer review was determined to constitute a patient safety event requiring reporting to the facilitys patient safety officer or risk management. True = patient safety event; False = not a patient safety event.',
    `prior_study_available_flag` BOOLEAN COMMENT 'Indicates whether prior imaging studies were available to the original interpreting radiologist at the time of interpretation. Relevant context for assessing the reasonableness of the original interpretation and the severity of any discrepancy.',
    `privileging_impact_flag` BOOLEAN COMMENT 'Indicates whether the outcome of this peer review case has a direct impact on the reviewed providers clinical privileges (restriction, suspension, or revocation).',
    `protection_statute_reference` STRING COMMENT 'The specific state or federal statute under which peer review confidentiality protection is claimed (e.g., California Evidence Code §1157, Texas Occupations Code §160.007).',
    `reconciliation_source` STRING COMMENT 'SSOT reconciliation linkage column added by cross-domain dedup vibe.',
    `response_datetime` TIMESTAMP COMMENT 'The date and time the original interpreting radiologist submitted their response or acknowledgment of the peer review findings. Used to track completion of the feedback loop and compliance with departmental peer review policy timelines.',
    `review_assigned_datetime` TIMESTAMP COMMENT 'The date and time the peer review case was assigned to the reviewing radiologist. Used to calculate turnaround time and compliance with departmental SLA targets for peer review completion.',
    `review_completion_date` DATE COMMENT 'The actual date on which the peer review case was completed and a determination was rendered by the reviewer or committee.',
    `review_datetime` TIMESTAMP COMMENT 'The date and time at which the peer review was performed and the concordance score was assigned by the reviewing radiologist. Principal business event timestamp for this transaction.',
    `review_disposition` STRING COMMENT 'The final action or outcome disposition resulting from the peer review. no_action = review complete, no further action needed; feedback_provided = educational feedback sent to original radiologist; addendum_required = original report requires addendum; report_amended = original report was amended; escalated = referred to department leadership; referred_to_committee = referred to quality or peer review committee. [ENUM-REF-CANDIDATE: no_action|feedback_provided|addendum_required|report_amended|escalated|referred_to_committee — promote to reference product]. Valid values are `no_action|feedback_provided|addendum_required|report_amended|escalated|referred_to_committee`',
    `review_due_date` DATE COMMENT 'Target completion date for the peer review case as established by medical staff bylaws or committee policy (typically 30–60 days from case open date).',
    `review_level` STRING COMMENT 'The organizational level at which the review is conducted: department-level (chief review), committee-level (medical staff quality committee), external (independent third-party reviewer), or appellate (appeal hearing panel).. Valid values are `department|committee|external|appellate`',
    `review_program_type` STRING COMMENT 'Identifies the quality or regulatory program under which this peer review was conducted. acr_radpeer = ACR RADPEER program; internal_qa = internal departmental QA; mips = MIPS quality measure; vbp = Value-Based Purchasing; tjc_required = TJC-mandated review; focused_professional_practice_evaluation = FPPE for credentialing. [ENUM-REF-CANDIDATE: acr_radpeer|internal_qa|mips|vbp|tjc_required|focused_professional_practice_evaluation — promote to reference product]. Valid values are `acr_radpeer|internal_qa|mips|vbp|tjc_required|focused_professional_practice_evaluation`',
    `review_status` STRING COMMENT '',
    `review_type` STRING COMMENT 'Classification of the review type: OPPE (Ongoing Professional Practice Evaluation) for routine periodic review, FPPE (Focused Professional Practice Evaluation) for targeted review of specific concerns, sentinel event review, or complaint-driven review. [ENUM-REF-CANDIDATE: oppe|fppe|sentinel_event|focused|routine|complaint_driven|mortality|morbidity — promote to reference product]. Valid values are `oppe|fppe|sentinel_event|focused|routine|complaint_driven`',
    `reviewer_comments` STRING COMMENT 'Free-text comments entered by the reviewing radiologist providing additional context, clinical reasoning, or recommendations beyond the structured discrepancy description. Protected under peer review privilege statutes in most jurisdictions.',
    `reviewer_findings` STRING COMMENT 'Narrative of the peer reviewers clinical findings, analysis of the care provided, and rationale supporting the care appropriateness determination.',
    `reviewer_radiologist_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the radiologist who performed the peer review. Must be a credentialed radiologist distinct from the original interpreter per ACR RADPEER blinding requirements.. Valid values are `^[0-9]{10}$`',
    `specialty_code` STRING COMMENT 'Medical specialty of the provider under review (e.g., General Surgery, Internal Medicine, Emergency Medicine). Used to ensure peer reviewer is of the same specialty.',
    `ssot_canonical_reference` STRING COMMENT 'Reference to the canonical SSOT record when this record is deprecated or merged',
    `ssot_reconciliation_status` STRING COMMENT 'Status indicating reconciliation state with related SSOT entity: ACTIVE, DEPRECATED, MERGED, SUPERSEDED',
    `study_datetime` TIMESTAMP COMMENT 'The date and time the imaging study was performed (acquisition datetime from PACS/DICOM metadata). Provides temporal context for the study under review and supports lag-time analytics between study acquisition and peer review.',
    `subspecialty` STRING COMMENT 'The radiology subspecialty category of the study under review. Used to ensure subspecialty-matched peer review assignments and to generate subspecialty-stratified quality metrics for ACR accreditation and departmental performance reporting. [ENUM-REF-CANDIDATE: neuroradiology|musculoskeletal|body|breast|cardiovascular|interventional|nuclear|pediatric|emergency — promote to reference product]',
    `subspecialty_matched_flag` BOOLEAN COMMENT 'Indicates whether the reviewing radiologists subspecialty matches the subspecialty of the imaging study under review. True = subspecialty-matched review; False = cross-subspecialty review. ACR RADPEER recommends subspecialty-matched reviews for complex studies.',
    `trigger_description` STRING COMMENT 'Narrative description of the specific event, complaint, or indicator that triggered this peer review case (e.g., unexpected intraoperative complication, patient complaint regarding surgical outcome).',
    `trigger_type` STRING COMMENT 'The initiating event or mechanism that caused this peer review case to be opened. OPPE = Ongoing Professional Practice Evaluation; FPPE = Focused Professional Practice Evaluation.. Valid values are `mortality|complication|complaint|focused_review|oppe|fppe`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this peer review case record was most recently modified.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_quality_peer_review PRIMARY KEY(`quality_peer_review_id`)
) COMMENT 'Peer review records for quality and clinical performance. Quality domain peer review. For radiology-specific peer review see radiology.radiology_peer_review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` (
    `population_health_gap_id` BIGINT COMMENT 'Unique surrogate identifier for each care gap record in the population health program. Primary key for this entity in the Silver Layer lakehouse.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Care gaps are identified and closed within specific insurance coverage contexts. Payer type drives gap closure strategies, HEDIS star ratings, and risk adjustment. Replaces denormalized payer fields w',
    `care_program_enrollment_id` BIGINT COMMENT 'Foreign key linking to patient.care_program_enrollment. Business justification: Gap identification triggers care program enrollment (diabetes, CHF management). Value-based contracts track gap closure within program context. Care managers use this link to prioritize interventions ',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site associated with the patients attributed care team and responsible for gap closure outreach.',
    `clinician_id` BIGINT COMMENT 'Reference to the Primary Care Physician (PCP) or care team provider to whom this patient is attributed for population health management and gap closure accountability.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Care gaps are closed when claims provide evidence of required services. Healthcare gap closure workflows require linking to the specific claim that satisfied the measure for HEDIS reporting and payer ',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Care gap closure data must be submitted to CMS for HEDIS, Stars, MIPS, and ACO programs. Compliance system tracks submission of gap closure documentation, exclusion justifications, and numerator compl',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Care gaps are identified by specific CPT procedure codes for preventive services (e.g., mammography, colonoscopy, immunizations). Population health programs require validated CPT code references to id',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this care gap has been identified. Links to the patient master record in the Master Patient Index (MPI).',
    `employee_id` BIGINT COMMENT 'Reference to the care coordinator or population health nurse assigned to manage outreach and closure activities for this care gap. Supports workload distribution and accountability tracking.',
    `follow_up_id` BIGINT COMMENT 'Foreign key linking to radiology.follow_up. Business justification: Radiology follow-up recommendations (incidental findings, lung nodules requiring surveillance) create care gaps tracked in population health programs. Gap closure requires linking to the originating r',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Care gaps are plan-specific; different plans have different measure sets and gap identification logic. Plan-level gap closure rates determine Star Ratings and quality bonus payments.',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to quality.hedis_measure. Business justification: Population health care gaps are often HEDIS-specific (e.g., gaps in diabetic eye exams, colorectal cancer screening). The existing hedis_measure_code STRING field should be replaced with a proper FK t',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Care gaps are identified by specific ICD-10 diagnosis codes for chronic condition management (e.g., diabetes, hypertension, asthma). Population health programs require validated ICD code references to',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Care gaps are identified by specific LOINC lab codes for screening compliance (e.g., HbA1c, cholesterol, colorectal cancer screening). Population health programs require validated LOINC code reference',
    `mpi_record_id` BIGINT COMMENT '',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Care gaps are identified by payer for their members to close HEDIS/Star Rating measures. Payers track gap closure rates for quality reporting and provider incentive payments.',
    `pcp_attribution_id` BIGINT COMMENT 'Foreign key linking to patient.pcp_attribution. Business justification: Care gap closure workflows assign outreach responsibility to attributed PCP. Provider-level gap closure rates drive HEDIS/Stars performance measurement and value-based contract reconciliation. Healthc',
    `measure_id` BIGINT COMMENT '',
    `population_quality_measure_id` BIGINT COMMENT 'Reference to the quality measure definition (e.g., HEDIS measure, CMS eCQM) that defines the clinical criteria for this care gap. Links to the quality.measure reference product.',
    `quality_program_id` BIGINT COMMENT 'Reference to the population health program (e.g., ACO, HMO, PPO, PCMH, chronic disease registry) under which this care gap was identified and is being managed.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Care gaps are specialty-specific (diabetic retinopathy screening requires ophthalmology, colorectal cancer screening requires gastroenterology). HEDIS measure closure requires routing gaps to appropri',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Care gap closure programs track which specific documented diagnoses satisfy quality measure requirements (e.g., diabetes diagnosis for HbA1c testing gaps, depression diagnosis for screening gaps). Rea',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit, telehealth, or procedure) during which the care gap was satisfied. Used to validate claims-based and documentation-based gap closures.',
    `care_gap_description` STRING COMMENT 'A human-readable description of the specific care gap, including the required service or intervention (e.g., HbA1c test overdue — last result >12 months ago, Annual mammogram not on file for patient aged 50-74). Used by care coordinators and providers in outreach communications.',
    `clinical_note` STRING COMMENT 'Free-text clinical notes or care coordinator comments associated with this care gap record, documenting outreach context, patient preferences, clinical rationale for exclusion, or closure documentation details. Supports CDI and care coordination workflows.',
    `closure_date` DATE COMMENT 'The date on which the care gap was satisfied and transitioned to closed status. Null if the gap remains open or excluded. Used to calculate gap closure rates and HEDIS numerator compliance.',
    `closure_method` STRING COMMENT 'The method by which the care gap was satisfied and closed. Claim indicates closure via a paid claims record; clinical_documentation via EHR charting; patient_attestation via patient self-report; lab_result via a qualifying lab value; immunization_registry via state registry data; care_plan via documented care plan goal achievement.. Valid values are `claim|clinical_documentation|patient_attestation|lab_result|immunization_registry|care_plan`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this care gap record was first created in the data platform. Represents the audit trail creation event for Silver Layer lineage tracking.',
    `data_source` STRING COMMENT 'The source of data used to identify or close this care gap. Indicates whether the gap was identified or satisfied via EHR clinical documentation, administrative claims, lab feed, immunization registry, patient attestation, or care plan documentation. Supports HEDIS hybrid vs. administrative methodology tracking.. Valid values are `ehr_clinical|claims|lab_feed|immunization_registry|patient_attestation|care_plan`',
    `due_date` DATE COMMENT 'The date by which the care gap must be closed to count toward the current HEDIS measurement year or quality program reporting period. Drives outreach prioritization and care coordinator workload management.',
    `exclusion_reason` STRING COMMENT 'The reason a patient has been excluded from the denominator for this care gap measure. Applies when gap_status is excluded. Examples include medical contraindication, patient refusal, hospice enrollment, patient death, or geographic ineligibility. Aligns with NCQA HEDIS denominator exclusion criteria.. Valid values are `medical_exclusion|patient_declined|hospice|deceased|moved_out_of_area|not_eligible`',
    `gap_category` STRING COMMENT 'Clinical sub-category of the care gap describing the nature of the required service (e.g., screening, immunization, lab monitoring, medication management, counseling, follow-up visit). Supports stratified reporting and outreach prioritization.. Valid values are `screening|immunization|monitoring|medication|counseling|follow_up`',
    `gap_number` STRING COMMENT 'Business-facing unique identifier for this care gap record, used in outreach workflows, care coordinator communications, and ACO quality reporting. Sourced from Epic Healthy Planet gap tracking.',
    `gap_status` STRING COMMENT 'Current workflow status of the care gap. Open indicates the gap has not been addressed; closed indicates the gap has been satisfied; excluded indicates the patient meets a denominator exclusion criterion; in_progress indicates active outreach is underway; voided indicates the gap was identified in error.. Valid values are `open|closed|excluded|in_progress|voided`',
    `gap_type` STRING COMMENT 'Classification of the care gap by clinical category. Indicates whether the gap relates to preventive care (e.g., cancer screening), chronic disease management (e.g., diabetes HbA1c), HEDIS measure compliance, medication adherence, or behavioral health. [ENUM-REF-CANDIDATE: preventive_care|chronic_disease_management|hedis_measure|medication_adherence|behavioral_health|other — promote to reference product]. Valid values are `preventive_care|chronic_disease_management|hedis_measure|medication_adherence|behavioral_health|other`',
    `identified_date` DATE COMMENT 'The date on which this care gap was first identified for the patient, typically generated by Epic Healthy Planet during a registry refresh or care gap analysis run. Represents the business event timestamp for gap creation.',
    `is_denominator_eligible` BOOLEAN COMMENT 'Indicates whether the patient meets the denominator eligibility criteria for the associated quality measure (True = eligible; False = ineligible). Ineligible patients are excluded from gap rate calculations.',
    `is_numerator_compliant` BOOLEAN COMMENT 'Indicates whether the patient currently meets the numerator criteria for the associated HEDIS or quality measure (True = compliant, gap closed; False = non-compliant, gap open). Directly drives HEDIS rate calculations and ACO quality score submissions.',
    `last_outreach_channel` STRING COMMENT 'The communication channel used for the most recent outreach attempt (phone call, mailed letter, patient portal message, care coordinator visit, telehealth, or SMS text). Supports outreach channel effectiveness analytics.. Valid values are `phone|letter|portal_message|care_coordinator|telehealth|sms`',
    `last_outreach_date` DATE COMMENT 'The date of the most recent outreach attempt made to the patient or their care team regarding this care gap. Used to manage follow-up scheduling and avoid duplicate outreach.',
    `measurement_year` STRING COMMENT 'The four-digit calendar year of the HEDIS or quality program measurement period to which this care gap belongs (e.g., 2024). Used to partition gap records by reporting cycle and support year-over-year trend analysis.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the facility. Used for cross-system patient identification and care gap reconciliation workflows.',
    `outreach_attempt_count` STRING COMMENT 'The total number of outreach attempts made to the patient or care team to address this care gap (phone calls, letters, portal messages, care coordinator contacts). Supports outreach effectiveness analysis and escalation workflows.',
    `outreach_response_status` STRING COMMENT 'The patients response to the most recent outreach attempt. Indicates whether the patient engaged, scheduled an appointment, declined the service, could not be reached, or has not yet responded. Drives next-step care coordinator actions.. Valid values are `no_response|patient_engaged|appointment_scheduled|declined|unreachable`',
    `priority_level` STRING COMMENT 'The clinical or operational priority assigned to this care gap, used to triage outreach efforts. High priority may reflect overdue preventive services, high-risk patients, or gaps with significant quality score impact. Assigned by Epic Healthy Planet risk stratification or care coordinator review.. Valid values are `high|medium|low`',
    `reporting_period_end` DATE COMMENT 'The end date of the quality program reporting period. Care gap closures must occur on or before this date to count toward the current measurement cycle numerator.',
    `reporting_period_start` DATE COMMENT 'The start date of the quality program reporting period during which this care gap is eligible for closure and numerator credit. Aligns with HEDIS measurement year or CMS program-specific reporting windows.',
    `reporting_program` STRING COMMENT 'The quality reporting program under which this care gap is tracked and submitted. Examples include HEDIS (NCQA), MIPS (Merit-based Incentive Payment System), ACO MSSP (Medicare Shared Savings Program), VBP (Value-Based Purchasing), PCMH (Patient-Centered Medical Home), CMS Star Ratings, or APM (Alternative Payment Model). [ENUM-REF-CANDIDATE: HEDIS|MIPS|ACO_MSSP|VBP|PCMH|CMS_STAR|APM — 7 candidates stripped; promote to reference product]',
    `risk_score` DECIMAL(18,2) COMMENT 'The patients risk stratification score at the time this care gap was identified, derived from Epic Healthy Planet or a population health risk model (e.g., HCC risk score, ACG score). Used to prioritize high-risk patients for gap closure outreach.',
    `scheduled_appointment_date` DATE COMMENT 'The date of a scheduled appointment intended to address and close this care gap. Populated when outreach_response_status is appointment_scheduled. Sourced from Epic Cadence scheduling module.',
    `snomed_code` STRING COMMENT 'The SNOMED CT concept code representing the clinical finding, procedure, or condition associated with this care gap. Supports semantic interoperability with HL7 FHIR-based population health platforms.. Valid values are `^[0-9]{6,18}$`',
    `source_gap_reference` STRING COMMENT 'The native identifier for this care gap record in the originating source system (e.g., Epic Healthy Planet internal gap ID). Supports ETL reconciliation, deduplication, and upstream system traceability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this care gap record was most recently modified in the data platform, including status changes, outreach updates, or closure events. Supports incremental ETL processing and audit compliance.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_population_health_gap PRIMARY KEY(`population_health_gap_id`)
) COMMENT 'Care gaps identified for patients in quality measures.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` (
    `sdoh_screening_id` BIGINT COMMENT 'Primary key for sdoh_screening',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the SDOH screening was administered. Supports site-level quality reporting and CMS facility-based measure stratification.',
    `chw_intervention_id` BIGINT COMMENT 'CHW intervention triggered from the screening.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or care team member who administered the SDOH screening tool. Used for provider-level quality attribution and MIPS reporting.',
    `community_resource_id` BIGINT COMMENT 'Community resource the screened patient was connected to.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: SDOH screening data must be submitted for CMS health equity measures, HEDIS social needs screening measures, and ACO health equity reporting. Compliance system tracks submission of screening rates, po',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: SDOH screening requirements vary by plan. Plans report screening rates to CMS and state regulators for health equity measures and social determinants quality reporting.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: SDOH screenings use standardized LOINC codes for interoperability and quality reporting (e.g., food insecurity, housing instability, transportation needs). CMS quality measures and health equity repor',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the SDOH screening. Links to the patient master record. Satisfies TRANSACTION_HEADER PARTY_REFERENCE minimum category.',
    `need_closure_id` BIGINT COMMENT 'Need closure record tracking resolution of the screened SDOH need.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: SDOH screenings are increasingly required by payers for health equity reporting and VBC contracts. Payers track screening rates and positive screen follow-up for quality measure compliance.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: SDOH screenings are tracked for quality measure compliance (CMS quality programs require SDOH screening documentation). Currently sdoh_screening has cms_measure_code as STRING, which should be normali',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: SDOH screening programs require patient consent before sharing information with community resources or external agencies. CMS quality measures for social needs screening require documented consent for',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: Quality SDOH screening tracks measure compliance (CMS eCQMs, HEDIS). Patient SDOH assessment captures clinical interventions and referrals. Linking validates screening completion against clinical docu',
    `sdoh_need_closure_id` BIGINT COMMENT 'FK to the need closure tracking table for monitoring resolution of identified social determinant needs.',
    `sdoh_referral_id` BIGINT COMMENT 'FK to the SDOH referral management table linking screening results to community resource referrals.',
    `sdoh_risk_stratification_id` BIGINT COMMENT 'FK to the SDOH risk stratification table for priority scoring and population segmentation.',
    `sdoh_zcode_mapping_id` BIGINT COMMENT 'FK to the ICD-10 Z-code mapping',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: SDOH screenings use SNOMED codes for structured clinical documentation and problem list integration in EHR systems. Quality reporting and health equity stratification require validated SNOMED concept ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Social determinants of health screening programs deployed at unit level (ED, inpatient units, outpatient clinics) with unit-specific workflows and community resource referral processes. Quality teams ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the SDOH screening was administered. Supports linkage to visit context for quality reporting and population health analytics.',
    `zcode_mapping_id` BIGINT COMMENT 'ICD-10 Z-code mapping for the identified social need.',
    `administration_mode` DECIMAL(18,2) COMMENT 'Method by which the SDOH screening was administered to the patient. Supports stratification of screening completion rates by modality and equity analysis.',
    `community_resource_connected` BOOLEAN COMMENT 'Indicates whether the patient was successfully connected to a community resource following a positive SDOH screen and referral. Supports close-the-loop tracking for CMS SDOH quality measures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SDOH screening record was first created in the source system. Used for audit trail and data lineage. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED minimum category.',
    `health_equity_stratifier` STRING COMMENT 'Stratification category used for health equity reporting (e.g., race/ethnicity group, payer type, geographic area). Supports CMS health equity reporting requirements and SDOH disparity analysis. Value is a non-PHI aggregate category, not individual patient data.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a professional interpreter was used during the SDOH screening administration. Supports language access compliance reporting and health equity analytics.',
    `is_denominator_eligible` BOOLEAN COMMENT 'Indicates whether this patient-screening record meets the denominator eligibility criteria for the associated CMS SDOH quality measure. Supports automated measure calculation in the Silver layer.',
    `is_numerator_compliant` BOOLEAN COMMENT 'Indicates whether this screening record satisfies the numerator criteria for the associated CMS SDOH quality measure (i.e., screening was completed). Supports automated measure rate calculation.',
    `is_positive_screen` BOOLEAN COMMENT 'Indicates whether the patient screened positive for a social need in this SDOH domain. A positive screen triggers referral workflows and community resource connection. Core flag for CMS SDOH quality measure numerator identification.',
    `is_referral_generated` BOOLEAN COMMENT 'Indicates whether a community resource or social services referral was generated as a result of a positive SDOH screen. Key metric for CMS SDOH quality measure numerator tracking and health equity reporting.',
    `language_of_administration` DECIMAL(18,2) COMMENT 'ISO 639-1 two-letter language code indicating the language in which the SDOH screening was administered. Supports health equity reporting and language access compliance under Title VI of the Civil Rights Act.',
    `need_resolution_date` DATE COMMENT 'Date on which the patients social need was confirmed resolved. Supports longitudinal outcomes measurement and population health program effectiveness reporting.',
    `need_resolved` BOOLEAN COMMENT 'Indicates whether the identified social need was resolved following intervention and community resource connection. Supports longitudinal population health outcomes tracking.',
    `positive_screen_reason` STRING COMMENT 'Clinical or administrative reason code or description explaining why the patient screened positive for this SDOH domain. Supports CDI and population health care management workflows.',
    `program_year` STRING COMMENT 'Calendar year of the quality measurement program to which this SDOH screening record is attributed. Used for annual CMS quality measure reporting, HEDIS measurement year alignment, and MIPS performance period tracking.',
    `question_text` STRING COMMENT 'Verbatim text of the SDOH screening question as presented to the patient. Supports audit, quality review, and longitudinal tracking of question wording across tool versions.',
    `referral_date` DATE COMMENT 'Date on which the community resource or social services referral was generated following a positive SDOH screen. Used to measure timeliness of referral and close-the-loop quality metrics.',
    `referral_type` STRING COMMENT 'Category of referral generated in response to a positive SDOH screen. Supports population health program tracking and community partnership analytics.. Valid values are `community_resource|social_work|care_management|food_bank|housing_agency|other`',
    `refusal_reason` STRING COMMENT 'Reason the patient declined or was unable to complete the SDOH screening. Required for denominator exclusion logic in CMS SDOH quality measures and equity reporting.. Valid values are `patient_declined|language_barrier|cognitive_impairment|time_constraint|not_applicable|other`',
    `reporting_period_end` DATE COMMENT 'End date of the quality reporting period to which this SDOH screening is attributed. Supports CMS quality measure submission windows and HEDIS measurement period alignment.',
    `reporting_period_start` DATE COMMENT 'Start date of the quality reporting period to which this SDOH screening is attributed. Supports CMS quality measure submission windows and HEDIS measurement period alignment.',
    `resource_connection_date` DATE COMMENT 'Date on which the patient was confirmed connected to the community resource. Used to calculate time-to-connection metrics and close-the-loop quality measure compliance.',
    `response_code` STRING COMMENT 'Standardized code (e.g., LOINC answer code, SNOMED CT) representing the patients response to the SDOH screening question. Enables structured analytics and interoperability distinct from the free-text response value.',
    `response_value` DECIMAL(18,2) COMMENT 'Patients verbatim or coded response to the SDOH screening question. Contains Protected Health Information (PHI) as it reflects the patients social needs. Satisfies TRANSACTION_HEADER QUANTITATIVE_RESULT minimum category for non-monetary clinical transactions.',
    `screening_date` DATE COMMENT 'Calendar date on which the SDOH screening was administered to the patient. Used as the principal event date for quality measure denominator and numerator identification. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP minimum category.',
    `screening_number` STRING COMMENT 'Externally visible business identifier for the SDOH screening event, typically sourced from the EHR (Epic Healthy Planet or Cerner Millennium). Used for cross-system reconciliation and audit trail. Satisfies TRANSACTION_HEADER BUSINESS_IDENTIFIER minimum category.',
    `screening_setting` STRING COMMENT 'Clinical care setting in which the SDOH screening was administered. Supports stratification of screening rates by care setting for CMS quality reporting and health equity analytics.. Valid values are `inpatient|outpatient|emergency_department|telehealth|community`',
    `screening_status` STRING COMMENT 'Current workflow status of the SDOH screening record. Indicates whether the screening was fully completed, partially administered, refused by the patient, or voided. Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS minimum category.. Valid values are `completed|in_progress|refused|not_eligible|voided`',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise date and time the SDOH screening was administered, including timezone offset. Supports time-of-day analytics and HL7 FHIR Observation.effectiveDateTime mapping.',
    `screening_tool_code` STRING COMMENT 'Standardized code identifying the validated SDOH screening instrument used. Common tools include AHC HRSN (Accountable Health Communities Health-Related Social Needs), PRAPARE (Protocol for Responding to and Assessing Patients Assets, Risks, and Experiences), and Hunger Vital Sign. [ENUM-REF-CANDIDATE: AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN|WELLCARE|ISCREEN|WE_CARE|NACHC_SDOH|EPIC_SDOH — promote to reference product]. Valid values are `AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN|WELLCARE|ISCREEN|WE_CARE`',
    `screening_tool_name` STRING COMMENT 'Human-readable name of the SDOH screening instrument administered (e.g., Accountable Health Communities Health-Related Social Needs Screening Tool, PRAPARE, Hunger Vital Sign). Supports display in clinical dashboards and quality reports.',
    `screening_tool_version` STRING COMMENT 'Version number or edition of the SDOH screening tool used. Important for longitudinal comparability and measure specification alignment as tools are updated.',
    `sdoh_domain` STRING COMMENT 'Primary SDOH domain assessed by this screening record. Each domain represents a distinct social need category per CMS and AHRQ SDOH frameworks. A single screening encounter may generate multiple domain-level records. [ENUM-REF-CANDIDATE: food_insecurity|housing_instability|transportation|interpersonal_safety|financial_strain|utilities|childcare|education|employment|social_isolation — promote to reference product]. Valid values are `food_insecurity|housing_instability|transportation|interpersonal_safety|financial_strain`',
    `source_system_record_reference` STRING COMMENT 'Native identifier of the SDOH screening record in the originating operational system (e.g., Epic SmartData element ID, Cerner PowerForm instance ID). Supports cross-system reconciliation and ETL audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the SDOH screening record was last modified in the source system. Supports incremental ETL processing and change data capture. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED minimum category.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_sdoh_screening PRIMARY KEY(`sdoh_screening_id`)
) COMMENT 'Social Determinants of Health screening results.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record. Primary key for the corrective action entity.',
    `accreditation_survey_id` BIGINT COMMENT 'Reference to the accreditation survey that identified the deficiency requiring this corrective action, if applicable.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Corrective actions from safety events, accreditation findings, or peer reviews require budget allocation for implementation (staff training, process redesign, monitoring systems). Finance teams track ',
    `capital_expenditure_id` BIGINT COMMENT 'Foreign key linking to finance.capital_expenditure. Business justification: Some corrective actions require capital purchases (equipment replacement for safety compliance, facility modifications for accreditation standards, technology upgrades for infection control). These ar',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the corrective action is being implemented.',
    `quality_committee_id` BIGINT COMMENT 'Foreign key linking to quality.committee. Business justification: Corrective actions are often reviewed, approved, or monitored by quality committees (e.g., Patient Safety Committee, Quality Improvement Committee). This FK enables tracking which committee has oversi',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Quality corrective actions originating from safety events, accreditation findings, or peer reviews must link to compliance CAP system for regulatory tracking, submission to CMS/TJC, verification of ef',
    `employee_id` BIGINT COMMENT 'Reference to the provider, staff member, or leader assigned primary accountability for completing the corrective action.',
    `improvement_initiative_id` BIGINT COMMENT 'Reference to the broader quality improvement initiative that this corrective action supports, if applicable.',
    `interface_downtime_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_downtime. Business justification: Corrective actions for interface failures (e.g., missed lab results causing patient safety events) reference specific downtime events as the originating incident. This link supports action plan tracki',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Corrective actions frequently target specific supply items (remove from formulary, change par levels, implement new storage protocol, restrict usage). Direct link to material master supports action im',
    `mortality_review_id` BIGINT COMMENT 'Reference to the mortality review case that identified the need for this corrective action, if applicable.',
    `parent_corrective_action_id` BIGINT COMMENT 'Self-referencing FK on corrective_action (parent_corrective_action_id)',
    `patient_safety_event_id` BIGINT COMMENT 'Reference to the patient safety event that triggered this corrective action, if applicable.',
    `quality_peer_review_id` BIGINT COMMENT 'Reference to the peer review case that identified the need for this corrective action, if applicable.',
    `recall_notice_id` BIGINT COMMENT 'Foreign key linking to supply.recall_notice. Business justification: Many corrective actions originate from product recalls (quarantine affected lots, notify patients with implants, update preference cards). Linking to recall notice enables tracking of recall-driven qu',
    `standard_finding_id` BIGINT COMMENT 'Reference to the specific accreditation or regulatory standard finding that requires this corrective action, if applicable.',
    `acceptance_date` DATE COMMENT 'Date when the regulatory or accreditation body formally accepted the corrective action plan or evidence of completion.',
    `acceptance_status` STRING COMMENT 'Status of the corrective action plan or evidence as reviewed and accepted by the regulatory or accreditation body.. Valid values are `pending|accepted|rejected|revision_requested`',
    `action_description` STRING COMMENT 'Detailed narrative description of the corrective or preventive action to be taken, including specific steps, interventions, and expected outcomes.',
    `action_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the corrective action, used for external reference and communication with regulatory bodies and accreditation organizations.',
    `action_status` STRING COMMENT 'Current lifecycle status of the corrective action indicating progress through the action workflow from initiation to closure.. Valid values are `open|in_progress|completed|verified|closed|overdue`',
    `action_type` STRING COMMENT 'Classification of the action as corrective (addressing an existing deficiency), preventive (preventing future occurrence), or both.. Valid values are `corrective|preventive|both`',
    `assigned_date` DATE COMMENT 'Date when the corrective action was formally assigned to the responsible party.',
    `completion_date` DATE COMMENT 'Actual date when the corrective action was completed and implemented.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was first created in the system.',
    `days_to_complete` STRING COMMENT 'Number of calendar days elapsed from action assignment to completion, used for performance monitoring and accountability tracking.',
    `department_name` STRING COMMENT 'Name of the clinical or operational department responsible for implementing the corrective action.',
    `due_date` DATE COMMENT 'Target completion date for the corrective action, often driven by regulatory deadlines or accreditation requirements.',
    `effectiveness_verification_date` DATE COMMENT 'Date when the effectiveness of the corrective action was formally verified and documented.',
    `effectiveness_verification_method` STRING COMMENT 'Description of the method or process used to verify that the corrective action achieved its intended outcome and prevented recurrence (e.g., audits, chart reviews, process observations, outcome measurement).',
    `effectiveness_verified` BOOLEAN COMMENT 'Flag indicating whether the corrective action has been verified as effective in addressing the root cause and preventing recurrence.',
    `is_cms_reportable` BOOLEAN COMMENT 'Flag indicating whether this corrective action is required to be reported to CMS as part of a plan of correction or quality program submission.',
    `is_overdue` BOOLEAN COMMENT 'Flag indicating whether the corrective action has passed its due date without completion.',
    `is_state_reportable` BOOLEAN COMMENT 'Flag indicating whether this corrective action is required to be reported to state health department or licensing authority.',
    `is_tjc_reportable` BOOLEAN COMMENT 'Flag indicating whether this corrective action is required to be reported to The Joint Commission as part of accreditation survey response or sentinel event follow-up.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which the corrective action and its sustained effectiveness will be monitored (e.g., weekly, monthly, quarterly, annually).',
    `monitoring_method` STRING COMMENT 'Description of the ongoing monitoring process or mechanism used to ensure sustained compliance and effectiveness of the corrective action.',
    `originating_event_type` STRING COMMENT 'Classification of the source event or finding that triggered the need for this corrective action. [ENUM-REF-CANDIDATE: patient_safety_event|accreditation_finding|regulatory_deficiency|peer_review|mortality_review|quality_measure_gap|complaint|audit_finding — 8 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Priority classification indicating the urgency and importance of completing the corrective action based on risk severity and regulatory requirements.. Valid values are `critical|high|medium|low`',
    `regulatory_program` STRING COMMENT 'Name of the regulatory or quality program that requires or monitors this corrective action (e.g., CMS Conditions of Participation, TJC Accreditation, State Licensure, MIPS, VBP).',
    `responsible_party_name` STRING COMMENT 'Full name of the individual or role accountable for executing and completing the corrective action.',
    `responsible_party_role` STRING COMMENT 'Job title or functional role of the individual assigned responsibility for the corrective action (e.g., Nurse Manager, Quality Director, Department Chair).',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause type that the corrective action addresses, used for trending and systemic improvement. [ENUM-REF-CANDIDATE: human_factors|communication|process_design|equipment|environment|training|policy_procedure — 7 candidates stripped; promote to reference product]',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause analysis findings that informed the design of this corrective action, linking the action to underlying system or process failures.',
    `service_line` STRING COMMENT 'Clinical service line or specialty area affected by or responsible for the corrective action (e.g., cardiology, surgery, emergency medicine).',
    `source_system_action_reference` STRING COMMENT 'Unique identifier for the corrective action in the originating source system, used for data lineage and reconciliation.',
    `submission_date` DATE COMMENT 'Date when the corrective action plan or evidence of completion was submitted to the regulatory or accreditation body.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was last modified in the system.',
    `verification_notes` STRING COMMENT 'Detailed notes and findings from the effectiveness verification process, including evidence of sustained improvement or identification of additional actions needed.',
    `verification_result` STRING COMMENT 'Outcome of the effectiveness verification assessment, indicating whether the corrective action successfully resolved the issue.. Valid values are `effective|partially_effective|ineffective|pending`',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective actions for quality findings and deficiencies.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` (
    `program_measure_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for the program-measure assignment record. Primary key.',
    `measure_id` BIGINT COMMENT '',
    `program_quality_measure_id` BIGINT COMMENT 'Foreign key linking to the quality measure. Part of the composite business key (quality_program_id, quality_measure_id, measure_inclusion_start_date).',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to the quality program. Part of the composite business key (quality_program_id, quality_measure_id, measure_inclusion_start_date).',
    `achievement_threshold` DECIMAL(18,2) COMMENT 'Program-specific performance threshold for this measure that defines achievement level or benchmark attainment. Thresholds vary by program even for the same measure (e.g., CMS VBP vs. internal quality program).',
    `assigned_by` STRING COMMENT 'User ID or name of the quality team member who assigned this measure to this program. Supports audit and accountability.',
    `assigned_date` TIMESTAMP COMMENT 'Timestamp when this measure was assigned to this program in the system. Supports audit trail.',
    `assignment_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `improvement_threshold` DECIMAL(18,2) COMMENT 'Program-specific improvement threshold for this measure used in improvement scoring methodologies. Defines the performance improvement required to earn improvement points.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this measure is mandatory or optional within this program. Some programs allow measure selection from a menu; others require all measures.',
    `last_modified_by` STRING COMMENT 'User ID or name of the quality team member who last modified this program-measure assignment configuration.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the last modification to this program-measure assignment record.',
    `measure_domain_assignment` STRING COMMENT 'Program-specific domain or category assignment for this measure (e.g., Clinical Outcomes, Safety, Efficiency for VBP; Quality, Cost, Improvement Activities for MIPS). A measure may be assigned to different domains in different programs.',
    `measure_inclusion_end_date` DATE COMMENT 'Date on which this measure was removed or became inactive within this quality program. Null indicates the measure is currently active in the program.',
    `measure_inclusion_start_date` DATE COMMENT 'Date on which this measure became active within this quality program. Supports temporal tracking of program measure composition changes across program years.',
    `measure_points_available` DECIMAL(18,2) COMMENT 'Total points available for this measure within this programs scoring methodology. Used in point-based programs like MIPS.',
    `measure_reporting_frequency` STRING COMMENT 'Frequency at which this measure must be reported or calculated for this specific program. A measure may be reported quarterly for one program and annually for another.',
    `measure_status_in_program` STRING COMMENT 'Current lifecycle status of this measure within this specific program. A measure may be active in one program and inactive in another. Drives reporting and calculation logic.',
    `measure_weight` DECIMAL(18,2) COMMENT 'Percentage weight or point value assigned to this measure within the quality programs total performance score calculation. Used in VBP, MIPS, and other pay-for-performance programs where measures contribute differentially to overall program score.',
    `notes` STRING COMMENT 'Free-text notes documenting rationale for measure inclusion, exclusion, or configuration decisions for this program-measure combination.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_program_measure_assignment PRIMARY KEY(`program_measure_assignment_id`)
) COMMENT 'Assignment of quality measures to quality programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` (
    `initiative_measure_target_id` BIGINT COMMENT 'Unique surrogate identifier for this initiative-measure targeting relationship',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to the improvement initiative that is targeting this measure',
    `measure_id` BIGINT COMMENT '',
    `initiative_quality_measure_id` BIGINT COMMENT 'Foreign key linking to the quality measure being targeted by this initiative',
    `baseline_period_end` DATE COMMENT 'End date of the measurement period used to calculate the baseline performance for this specific measure within this initiative',
    `baseline_period_start` DATE COMMENT 'Start date of the measurement period used to calculate the baseline performance for this specific measure within this initiative',
    `baseline_value` DECIMAL(18,2) COMMENT 'Quantitative baseline performance level for this specific measure at the time the initiative commenced. This is measure-specific and belongs to the relationship, not to the initiative alone (which may target multiple measures with different baselines).',
    `created_timestamp` TIMESTAMP COMMENT '',
    `current_performance_date` DATE COMMENT 'Date on which the current performance value was last measured or updated for this measure within this initiative',
    `current_performance_value` DECIMAL(18,2) COMMENT 'Most recently recorded performance value for this specific measure within this initiative. Enables real-time tracking of progress toward the goal for each measure.',
    `goal_value` DECIMAL(18,2) COMMENT 'Target quantitative performance level the initiative aims to achieve for this specific measure. Each measure targeted by an initiative may have different goal values.',
    `is_primary_measure` BOOLEAN COMMENT 'Indicates whether this is the primary/lead measure for the initiative (true) or a secondary/balancing measure (false). An initiative typically has one primary measure and may have multiple secondary measures.',
    `measure_role_in_initiative` STRING COMMENT 'Categorical role this measure plays within the improvement initiative (e.g., Primary outcome measure, Balancing measure, Process measure). Supports IHI Model for Improvement methodology which requires tracking multiple measure types.',
    `measure_unit` STRING COMMENT 'Unit of measurement for the target measure (e.g., per 1,000 catheter days, percentage, rate per 100 admissions). Required for accurate baseline and goal comparison. [Moved from improvement_initiative: This attribute stores the unit of measurement for the target measure. However, if an initiative targets multiple measures, each measure may have different units. This should come from the measure table or be stored per initiative-measure relationship, not on the initiative itself.]',
    `measurement_end_date` DATE COMMENT 'Date when measurement and tracking of this specific measure concluded for this initiative. Null if still actively tracked.',
    `measurement_start_date` DATE COMMENT 'Date when active measurement and tracking of this specific measure began for this initiative. May differ from initiative start date if measures are added during the initiative lifecycle.',
    `target_rate` DECIMAL(18,2) COMMENT '',
    `target_status` STRING COMMENT 'Current status of progress toward the goal for this specific measure (e.g., On Track, At Risk, Behind, Goal Met, Suspended). Enables status tracking per measure within an initiative.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_initiative_measure_target PRIMARY KEY(`initiative_measure_target_id`)
) COMMENT 'Performance targets for quality improvement initiatives.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` (
    `contract_initiative_id` BIGINT COMMENT 'Unique surrogate identifier for this contract-initiative linkage record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created this contract-initiative linkage record, typically a contract administrator or quality program manager.',
    `contract_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the employee who most recently updated this contract-initiative linkage record.',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to the quality improvement initiative that is contractually required or incentivized by the payer contract',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to the payer contract that requires or incentivizes this quality improvement initiative',
    `payer_id` BIGINT COMMENT '',
    `contract_initiative_status` STRING COMMENT 'Current lifecycle status of this contract-initiative linkage. Tracks whether the initiative is actively being pursued for this specific contracts requirements.',
    `contract_measure_code` STRING COMMENT 'The specific quality measure code or identifier used in this payer contract to reference this initiative. May differ from the initiatives internal measure code if the payer uses a different coding system.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this contract-initiative linkage record was created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `end_date` DATE COMMENT 'Date on which this contract-initiative linkage ended or is scheduled to end. May be driven by contract termination, initiative completion, or contractual requirement sunset.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Dollar amount of quality bonus or incentive payment available from this payer contract if the initiative achieves the contract-specific performance target.',
    `incentive_earned_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of quality incentive payments earned from this payer contract for this initiative as of the current date.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this initiative is contractually mandatory (required by the payer contract) or voluntary (eligible for incentive but not required).',
    `last_reported_date` DATE COMMENT 'Date on which performance for this contract-initiative linkage was most recently reported to the payer.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this contract-initiative linkage record was most recently updated.',
    `next_reporting_due_date` DATE COMMENT 'Date by which the next performance report for this contract-initiative linkage is due to the payer per contractual obligations.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Dollar amount of financial penalty or withheld payment from this payer contract if the initiative fails to meet the contract-specific performance target.',
    `penalty_incurred_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of quality penalties or withheld payments incurred from this payer contract for this initiative as of the current date.',
    `performance_target` DECIMAL(18,2) COMMENT 'The specific quantitative performance target for this initiative as defined in this payer contract. May differ from the initiatives overall goal if the contract specifies a different threshold for incentive eligibility.',
    `reporting_frequency` STRING COMMENT 'Frequency at which performance on this initiative must be reported to this payer per contractual requirements.',
    `start_date` DATE COMMENT 'Date on which this initiative became contractually linked to this payer contract. May differ from the initiatives overall start date if the contract was signed after initiative launch.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_contract_initiative PRIMARY KEY(`contract_initiative_id`)
) COMMENT 'Quality initiatives tied to value-based contracts.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` (
    `program_study_participation_id` BIGINT COMMENT 'Unique surrogate identifier for this program-study participation record. Primary key.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to the quality program affected by research study participation',
    `research_study_id` BIGINT COMMENT 'Foreign key to research_study. Identifies which research study impacts quality program measures.',
    `program_study_research_study_id` BIGINT COMMENT 'Foreign key linking to the research study that impacts quality program measures',
    `affected_measure_ids` STRING COMMENT 'Comma-separated list of specific quality measure IDs within the program that are affected by this research study participation. Enables targeted exclusion/stratification logic application.',
    `cms_reporting_flag` BOOLEAN COMMENT 'Indicates whether this program-study relationship must be reported to CMS as part of regulatory quality data submission. Drives compliance workflow.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this program-study participation record was created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `end_date` DATE COMMENT 'The date on which this research study stopped impacting the quality programs measure calculation, or null if ongoing. Defines the end of the period during which exclusion/stratification rules apply. Explicitly identified in detection phase.',
    `enrollment_impact_on_measures` STRING COMMENT 'Detailed description of how patient enrollment in this research study impacts specific quality measures within the program. Documents which measures are affected and the nature of the impact. Explicitly identified in detection phase.',
    `last_updated_by` STRING COMMENT 'User or system identifier that last updated this program-study participation record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this program-study participation record.',
    `measure_stratification_required` BOOLEAN COMMENT 'Indicates whether CMS or the program sponsor requires separate stratified reporting of quality measures for patients enrolled in this research study versus non-enrolled patients. Drives reporting workflow and data submission requirements. Explicitly identified in detection phase.',
    `participation_status` STRING COMMENT 'Current operational status of this program-study participation relationship. Determines whether exclusion/stratification rules are currently being applied in measure calculation.',
    `program_participation_type` STRING COMMENT 'Categorical classification of how the research study participation affects quality program measure calculation. Determines the operational impact on performance scoring and reporting. Explicitly identified in detection phase.',
    `reporting_exclusion_rules` STRING COMMENT 'Specific exclusion logic and rules to be applied when calculating quality measures for patients enrolled in this research study. Defines how study participants are handled in numerator/denominator calculations. Explicitly identified in detection phase.',
    `start_date` DATE COMMENT 'The date on which this research study began impacting the quality programs measure calculation and reporting. Defines the beginning of the period during which exclusion/stratification rules apply. Explicitly identified in detection phase.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `created_by` STRING COMMENT 'User or system identifier that created this program-study participation record.',
    CONSTRAINT pk_program_study_participation PRIMARY KEY(`program_study_participation_id`)
) COMMENT 'Participation of quality programs in research studies.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` (
    `measure_budget_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each measure-budget allocation record. Primary key.',
    `budget_id` BIGINT COMMENT '',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to the budget line providing funding for this quality measure',
    `measure_id` BIGINT COMMENT 'Foreign key linking to the quality measure being funded by this budget allocation',
    `allocation_amount` DECIMAL(18,2) COMMENT '',
    `allocation_notes` STRING COMMENT 'Free-text notes explaining the rationale for this budget allocation, assumptions about improvement activities, or justification for the funding level.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the budget line amount allocated to this specific quality measure. Enables proportional cost allocation when a single budget line funds multiple measures.',
    `allocation_status` STRING COMMENT 'Current status of this budget allocation in the budget approval and execution lifecycle.',
    `budgeted_improvement_cost` DECIMAL(18,2) COMMENT 'Dollar amount budgeted specifically for improvement activities related to this quality measure (e.g., staff training, process redesign, technology enhancements). Represents the investment expected to improve measure performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the system. Audit trail field.',
    `effective_end_date` DATE COMMENT 'Date on which this budget allocation ceases to be effective. Null for ongoing allocations.',
    `effective_start_date` DATE COMMENT 'Date from which this budget allocation becomes effective for this measure-budget line combination.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this budget allocation applies to this quality measure. Enables year-over-year tracking of measure funding.',
    `measure_target_value` DECIMAL(18,2) COMMENT 'The performance target or goal set for this quality measure for this fiscal year and budget allocation. Expressed as a rate, percentage, or score depending on measure type. Links financial investment to expected performance outcome.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this allocation record. Audit trail field.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified. Audit trail field.',
    `performance_incentive_amount` DECIMAL(18,2) COMMENT 'Expected financial return or incentive payment associated with achieving the measure target (e.g., VBP bonus, MIPS positive payment adjustment, shared savings). Enables ROI calculation for quality measure investments.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this allocation record. Audit trail field.',
    CONSTRAINT pk_measure_budget_allocation PRIMARY KEY(`measure_budget_allocation_id`)
) COMMENT 'Budget allocations for quality measure reporting and improvement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` (
    `quality_program_participation_id` BIGINT COMMENT 'Unique identifier for the quality program participation.',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: quality_program_participation is completely SILOED (only has PK + vibe/ssot columns, zero inbound and zero outbound FKs). It represents participation of care sites/providers IN a quality program, so i',
    `merged_with_facility_facility_program_participation` STRING COMMENT 'SSOT reconciliation attribute added by vibe cross-domain dedup pass.',
    `ssot_canonical_reference` STRING COMMENT 'Distinct entity; counterpart facility.facility_program_participation serves a separate domain context',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT review: kept distinct from facility.facility_program_participation (documented as separate business concepts)',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_quality_program_participation PRIMARY KEY(`quality_program_participation_id`)
) COMMENT 'Participation of care sites and providers in quality programs. Quality program participation. For facility-level participation see facility.facility_program_participation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` (
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee.',
    `merged_with_provider_committee` STRING COMMENT 'SSOT reconciliation attribute added by vibe cross-domain dedup pass.',
    `ssot_canonical_reference` STRING COMMENT 'Fully-qualified reference to the canonical SSOT table that supersedes this duplicate concept.',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT reconciliation status indicating this product was reconciled against its canonical source-of-truth table.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_quality_committee PRIMARY KEY(`quality_committee_id`)
) COMMENT 'Quality and safety committees (Mortality Review, Patient Safety, etc.). Quality and patient safety committee. For provider credentialing committees see provider.committee.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_program` (
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program.',
    `merged_with_compliance_compliance_program` STRING COMMENT 'SSOT reconciliation attribute added by vibe cross-domain dedup pass.',
    `ssot_canonical_reference` STRING COMMENT 'Distinct entity; counterpart compliance.compliance_program serves a separate domain context',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT review: kept distinct from compliance.compliance_program (documented as separate business concepts)',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    CONSTRAINT pk_quality_program PRIMARY KEY(`quality_program_id`)
) COMMENT 'Quality and performance improvement program definitions. Quality domain program management. For compliance programs see compliance.compliance_program.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`raf_score` (
    `raf_score_id` BIGINT COMMENT 'Primary key for raf_score',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider or care team to whom the patient (and thus this RAF) is attributed for the program period.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient (member/beneficiary) to whom this RAF score applies.',
    `prior_raf_score_id` BIGINT COMMENT 'Self-referencing FK on raf_score (prior_raf_score_id)',
    `calculation_date` DATE COMMENT 'The date on which the RAF score was computed by the risk adjustment engine.',
    `calculation_source` STRING COMMENT 'The submission/data source basis for the score (e.g., claims, encounter data EDPS, RAPS, chart review supplemental).',
    `calculation_status` STRING COMMENT 'Lifecycle status of the score calculation from draft through final reconciliation.',
    `coding_intensity_adjustment` DECIMAL(18,2) COMMENT 'The CMS-mandated coding pattern adjustment applied to the normalized RAF value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RAF score record was first captured in the system.',
    `data_collection_year` STRING COMMENT 'The calendar year from which diagnosis (ICD) data was collected to compute the score.',
    `demographic_score_component` DECIMAL(18,2) COMMENT 'The portion of the RAF value derived from demographic factors (age, sex, Medicaid status, disability, institutional status).',
    `disease_score_component` DECIMAL(18,2) COMMENT 'The portion of the RAF value derived from documented Hierarchical Condition Categories (HCCs) / disease interactions.',
    `effective_end_date` DATE COMMENT 'The date through which this RAF score remains effective; nullable for open-ended current scores.',
    `effective_start_date` DATE COMMENT 'The date from which this RAF score is effective for the payment/scoring period.',
    `enrollment_status` STRING COMMENT 'The CMS enrollment segment used in scoring (e.g., continuing enrollee, new enrollee, institutional, community, ESRD) which determines model coefficient set.',
    `hcc_count` STRING COMMENT 'The total number of distinct HCCs captured and contributing to the disease score component for the period.',
    `medicaid_dual_status` STRING COMMENT 'The dual-eligible status flag (non-dual, partial, full) impacting demographic risk coefficients.',
    `member_identifier` STRING COMMENT 'External payer/CMS member or beneficiary identifier (e.g., Medicare Beneficiary Identifier) the RAF score is attributed to under the risk-bearing contract.',
    `model_version` STRING COMMENT 'The CMS HCC risk adjustment model version used to compute the score (e.g., V24, V28, RxHCC, ESRD model).',
    `normalization_factor` DECIMAL(18,2) COMMENT 'The CMS-published normalization factor applied to the raw RAF value for the payment year.',
    `normalized_raf_value` DECIMAL(18,2) COMMENT 'The RAF value after applying normalization factor and coding intensity adjustment, used for final payment determination.',
    `payment_year` STRING COMMENT 'The CMS payment year for which this RAF score determines risk-adjusted payment.',
    `program_type` STRING COMMENT 'The value-based / risk-bearing program under which this RAF score is calculated and reported. [ENUM-REF-CANDIDATE: medicare_advantage|aco|aco_reach|commercial_aca|medicaid|mssp|dual_eligible_snp — promote to reference product]',
    `raf_gap_value` DECIMAL(18,2) COMMENT 'The difference between suspected and documented RAF, representing potential risk capture opportunity from open coding gaps.',
    `raf_value` DECIMAL(18,2) COMMENT 'The principal calculated risk adjustment factor numeric value representing the patients predicted relative cost/health burden. This is PHI as it reflects aggregate health condition severity.',
    `score_type` STRING COMMENT 'The methodology timing classification of the score: prospective (predicts future cost), concurrent (explains current period), or retrospective (reconciliation).',
    `submission_status` STRING COMMENT 'Status of the underlying diagnosis data submission to CMS that backs this score.',
    `suspected_raf_value` DECIMAL(18,2) COMMENT 'Projected RAF value including suspected but not-yet-documented conditions identified via analytics/gap-closure workflows.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RAF score record was last modified, supporting reconciliation and audit lineage.',
    CONSTRAINT pk_raf_score PRIMARY KEY(`raf_score_id`)
) COMMENT 'Master reference table for raf_score. Referenced by raf_score_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` (
    `care_gap_closure_id` BIGINT COMMENT 'Primary key for care_gap_closure',
    `clinician_id` BIGINT COMMENT 'Reference to the provider responsible for or credited with closing the care gap (e.g., the rendering clinician who delivered the recommended service).',
    `measure_id` BIGINT COMMENT 'Reference to the quality measure (e.g., HEDIS, CMS Star, MIPS) that defines the care gap being closed.',
    `member_mpi_record_id` BIGINT COMMENT 'Health plan member identifier associated with the patients coverage at the time the care gap was tracked, used for payer attribution and HEDIS reporting.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this care gap was identified and closed. Links to the enterprise patient master (MPI) for multi-facility identity resolution.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the care gap was addressed or closed, supporting traceability to the visit where the service was rendered.',
    `reopened_care_gap_closure_id` BIGINT COMMENT 'Self-referencing FK on care_gap_closure (reopened_care_gap_closure_id)',
    `attribution_payer` STRING COMMENT 'The health plan or payer to which this gap and its closure are attributed for value-based and HEDIS reporting purposes.',
    `care_gap_number` STRING COMMENT 'Externally-known business identifier for the care gap, used by care management and population health teams to reference the gap across systems and reports.',
    `clinical_condition` STRING COMMENT 'The underlying clinical condition or chronic disease driving the care gap (e.g., diabetes, hypertension), used for chronic care management cohorting. Protected health information.',
    `closure_date` DATE COMMENT 'The real-world date on which the qualifying service was rendered or the gap was confirmed closed. Principal business event date for closure-rate analytics.',
    `closure_method` STRING COMMENT 'The data source or mechanism through which the care gap was confirmed closed, supporting HEDIS hybrid and administrative measure validation.',
    `closure_notes` STRING COMMENT 'Free-text clinical or care management notes documenting the circumstances of the gap closure or exclusion. May contain protected health information.',
    `closure_status` STRING COMMENT 'Current lifecycle state of the care gap closure workflow, indicating whether the gap remains open, has been satisfactorily closed, or excluded.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the patient is now compliant with the measure numerator following gap closure (true) or remains non-compliant (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this care gap closure record was first created in the quality data store.',
    `due_date` DATE COMMENT 'The date by which the recommended service must be performed to close the gap within the measurement period.',
    `exclusion_reason` STRING COMMENT 'The reason the care gap was excluded from the eligible denominator, supporting HEDIS valid data reporting exclusions.',
    `gap_type` STRING COMMENT 'Categorical classification of the care gap by clinical domain, segmenting the gap population for targeted outreach and analytics.',
    `identification_date` DATE COMMENT 'The date the care gap was first identified as open for the patient, marking the start of the outreach and intervention window.',
    `last_outreach_date` DATE COMMENT 'The date of the most recent patient outreach activity related to this care gap.',
    `measure_domain` STRING COMMENT 'The quality program domain the measure belongs to (e.g., HEDIS Effectiveness of Care, CMS Stars, MIPS). [ENUM-REF-CANDIDATE: hedis_effectiveness_of_care|hedis_access_availability|cms_stars|mips|vbp|cahps|aco_mssp — promote to reference product]',
    `measure_year` STRING COMMENT 'The HEDIS/quality measurement year for which this care gap applies, governing the reporting period and eligibility window.',
    `outreach_attempt_count` STRING COMMENT 'Number of patient outreach attempts (calls, letters, messages) made to encourage closure of the gap, supporting care management effectiveness analysis.',
    `outreach_channel` STRING COMMENT 'The communication channel used for the most recent outreach to the patient regarding the care gap.',
    `priority_level` STRING COMMENT 'The prioritization tier assigned to the gap for care management workqueues, based on clinical urgency and risk stratification.',
    `program_name` STRING COMMENT 'The value-based or quality program under which this gap is tracked (e.g., ACO MSSP, Medicare Advantage Stars, commercial VBP contract).',
    `qualifying_code` STRING COMMENT 'The CPT, HCPCS, ICD-10, LOINC, or CVX code that satisfies the numerator criteria and closes the gap, used for administrative measure validation.',
    `qualifying_code_system` STRING COMMENT 'The terminology system to which the qualifying code belongs, enabling correct interpretation of the closure evidence.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk stratification score (e.g., HCC/RAF-derived) associated with the patient at gap identification, used to prioritize high-risk patients for closure.',
    `service_date` DATE COMMENT 'The date the qualifying clinical service (e.g., screening, immunization, lab) was performed that satisfies the measure numerator.',
    `supplemental_data_flag` BOOLEAN COMMENT 'Indicates whether non-claims supplemental data (e.g., EHR extract, registry) was used as evidence to close the gap, relevant for NCQA supplemental data validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this care gap closure record was last modified, supporting change tracking for quality workflows.',
    `validation_status` STRING COMMENT 'The audit/validation state of the closure evidence, indicating whether the supporting data has been reviewed and accepted for quality reporting.',
    CONSTRAINT pk_care_gap_closure PRIMARY KEY(`care_gap_closure_id`)
) COMMENT 'Master reference table for care_gap_closure. Referenced by care_gap_closure_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` (
    `chw_intervention_id` BIGINT COMMENT 'Primary key for chw_intervention',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or site associated with the CHW program managing the intervention.',
    `employee_id` BIGINT COMMENT 'Identifier of the community health worker (workforce member) who delivered the intervention.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who is the recipient of the community health worker intervention.',
    `barrier_identified` STRING COMMENT 'Description of any barrier to care or resource access identified during the intervention. [ENUM-REF-CANDIDATE: language|transportation|cost|trust|literacy|availability|none — promote to reference product]',
    `completion_timestamp` TIMESTAMP COMMENT 'The date and time the intervention was marked complete, used to measure cycle time and program throughput.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether patient consent was obtained prior to delivering the intervention, supporting compliance and consent governance.',
    `duration_minutes` STRING COMMENT 'The total length of the intervention contact in minutes, supporting workload and productivity analysis.',
    `encounter_modality` STRING COMMENT 'The channel or setting through which the intervention was delivered to the patient.',
    `followup_due_date` DATE COMMENT 'The target date by which any required follow-up intervention should occur.',
    `followup_required_flag` BOOLEAN COMMENT 'Indicates whether an additional follow-up intervention is needed to address the patients ongoing needs.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether language interpretation services were used during the intervention, supporting health equity measurement.',
    `intervention_category` STRING COMMENT 'Broad category that segments the intervention by the type of support provided, enabling population health analytics and program mix reporting.',
    `intervention_code` STRING COMMENT 'Externally-known short code identifying the specific intervention type within the CHW program catalog, used for standardized reporting and tracking.',
    `intervention_name` STRING COMMENT 'Human-readable name of the community health worker intervention, describing the supportive action delivered to a patient or population.',
    `intervention_notes` STRING COMMENT 'Free-text clinical and social notes documenting details of the intervention; contains protected health information.',
    `intervention_status` STRING COMMENT 'Current lifecycle state of the intervention as it progresses from planning through completion or cancellation.',
    `intervention_timestamp` TIMESTAMP COMMENT 'The actual real-world date and time the intervention was delivered to the patient, distinct from record audit timestamps.',
    `location_name` STRING COMMENT 'Name of the physical or community location where the intervention took place.',
    `need_severity_score` STRING COMMENT 'Numeric severity score of the social need at the time of intervention, supporting risk stratification and population health analytics.',
    `outcome_status` STRING COMMENT 'The resulting outcome of the intervention in addressing the patients health-related social need.',
    `primary_language` STRING COMMENT 'The primary spoken language of the patient at the time of intervention, supporting culturally and linguistically appropriate services (CLAS) reporting.',
    `priority_level` STRING COMMENT 'Assigned urgency level guiding scheduling and resource allocation for the intervention.',
    `program_name` STRING COMMENT 'The name of the population health or value-based care program under which the intervention is delivered.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the intervention record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the intervention record was last modified.',
    `referral_completed_flag` BOOLEAN COMMENT 'Indicates whether the patient successfully connected with the referred community resource, a key program effectiveness measure.',
    `referral_source` STRING COMMENT 'The originating source that triggered the intervention, used to analyze referral pathways and program reach.',
    `resource_referred_to` STRING COMMENT 'Name of the community resource or service organization the patient was connected to as part of the intervention.',
    `scheduled_date` DATE COMMENT 'The planned calendar date on which the intervention was scheduled to occur.',
    `sdoh_domain` STRING COMMENT 'The social determinant of health domain targeted by the intervention (e.g., housing, food security, transportation, utilities, interpersonal safety). [ENUM-REF-CANDIDATE: housing|food_insecurity|transportation|utilities|interpersonal_safety|employment|education|financial_strain — promote to reference product]',
    CONSTRAINT pk_chw_intervention PRIMARY KEY(`chw_intervention_id`)
) COMMENT 'Master reference table for chw_intervention. Referenced by chw_intervention_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` (
    `sdoh_risk_stratification_id` BIGINT COMMENT 'Primary key for sdoh_risk_stratification',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose social determinants of health risk is being stratified.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider/clinician who reviewed and validated the stratification result.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the SDOH screening was administered or captured.',
    `area_deprivation_index` DECIMAL(18,2) COMMENT 'Geographic socioeconomic deprivation index for the patients residential area, used to contextualize individual risk.',
    `assessment_reference_number` STRING COMMENT 'Externally-known business reference number assigned to the SDOH screening/stratification instance for tracking and audit.',
    `care_management_priority` STRING COMMENT 'Prioritization level assigned for care management and population-health outreach based on the risk tier.',
    `composite_risk_score` DECIMAL(18,2) COMMENT 'Principal quantitative composite score summarizing the patients overall social determinant risk burden across all assessed domains.',
    `consent_to_share_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to share SDOH data with community partners and referral organizations.',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of screening questions answered, indicating reliability/completeness of the resulting score.',
    `data_source_type` STRING COMMENT 'Origin of the SDOH data used for stratification, supporting data provenance and confidence assessment.',
    `economic_domain_score` DECIMAL(18,2) COMMENT 'Sub-domain score quantifying economic stability risk (income, employment, financial strain).',
    `education_barrier_flag` BOOLEAN COMMENT 'Indicates limited education or health literacy barriers identified during screening.',
    `employment_status` STRING COMMENT 'Self-reported employment status captured as part of the SDOH economic domain assessment.',
    `financial_strain_flag` BOOLEAN COMMENT 'Indicates the patient reported financial strain affecting their ability to meet basic needs.',
    `food_insecurity_flag` BOOLEAN COMMENT 'Indicates the patient screened positive for food insecurity.',
    `healthcare_access_domain_score` DECIMAL(18,2) COMMENT 'Sub-domain score quantifying healthcare access and quality risk (coverage, transportation).',
    `housing_domain_score` DECIMAL(18,2) COMMENT 'Sub-domain score quantifying neighborhood and built-environment/housing risk.',
    `housing_instability_flag` BOOLEAN COMMENT 'Indicates the patient screened positive for housing instability or homelessness risk.',
    `identified_needs_count` STRING COMMENT 'Number of distinct positive social-need domains identified in this stratification.',
    `insurance_coverage_gap_flag` BOOLEAN COMMENT 'Indicates the patient reported gaps or lack of health insurance coverage affecting access.',
    `interpersonal_safety_flag` BOOLEAN COMMENT 'Indicates the patient screened positive for interpersonal violence or safety concerns.',
    `intervention_recommendation` STRING COMMENT 'Narrative description of recommended interventions or community resources based on identified social needs.',
    `patient_declined_flag` BOOLEAN COMMENT 'Indicates the patient declined to complete part or all of the SDOH screening, affecting score completeness.',
    `primary_language` STRING COMMENT 'Patients primary spoken language, relevant for language-access barriers and equity analytics.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stratification record was first captured in the system.',
    `referral_indicated_flag` BOOLEAN COMMENT 'Indicates whether the stratification result warrants a referral to community-based social services.',
    `residential_zip_code` STRING COMMENT 'Patient residential postal code used for geographic SDOH index linkage and equity stratification.',
    `risk_score_methodology` STRING COMMENT 'Method used to calculate the composite risk score, supporting transparency and model governance.',
    `risk_stratification_status` STRING COMMENT 'Current lifecycle state of the SDOH risk stratification record.',
    `risk_tier` STRING COMMENT 'Categorical risk segmentation tier derived from the composite SDOH score, used to prioritize care management outreach.',
    `screening_date` DATE COMMENT 'Date on which the SDOH screening was administered to the patient.',
    `screening_method` STRING COMMENT 'Method by which the SDOH screening was administered to the patient.',
    `screening_tool_name` STRING COMMENT 'Standardized screening instrument used to capture social needs data (e.g., AHC-HRSN, PRAPARE).',
    `screening_tool_version` STRING COMMENT 'Version of the screening instrument used, supporting reproducibility and longitudinal comparison of scores.',
    `social_context_domain_score` DECIMAL(18,2) COMMENT 'Sub-domain score quantifying social and community context risk (isolation, safety, support).',
    `social_isolation_flag` BOOLEAN COMMENT 'Indicates the patient screened positive for social isolation or lack of social connection.',
    `social_vulnerability_index` DECIMAL(18,2) COMMENT 'CDC/ATSDR Social Vulnerability Index for the patients geographic area, ranging 0-1.',
    `stratification_calculated_timestamp` TIMESTAMP COMMENT 'Timestamp when the composite risk score and tier were calculated for this record.',
    `transportation_barrier_flag` BOOLEAN COMMENT 'Indicates the patient reported transportation barriers affecting access to care.',
    `utility_needs_flag` BOOLEAN COMMENT 'Indicates the patient screened positive for difficulty paying for utilities (heat, electricity, water).',
    `valid_from_date` DATE COMMENT 'Date from which this risk stratification result is considered effective and current.',
    `valid_until_date` DATE COMMENT 'Date through which this stratification remains valid before re-screening is recommended (nullable for open-ended).',
    CONSTRAINT pk_sdoh_risk_stratification PRIMARY KEY(`sdoh_risk_stratification_id`)
) COMMENT 'Master reference table for sdoh_risk_stratification. Referenced by sdoh_risk_stratification_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_cahps_survey_id` FOREIGN KEY (`cahps_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`cahps_survey`(`cahps_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_record_cahps_survey_id` FOREIGN KEY (`record_cahps_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`cahps_survey`(`cahps_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_prior_review_safety_event_review_id` FOREIGN KEY (`prior_review_safety_event_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`safety_event_review`(`safety_event_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_raf_score_id` FOREIGN KEY (`raf_score_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`raf_score`(`raf_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_mips_clinician_measure_id` FOREIGN KEY (`mips_clinician_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_care_gap_closure_id` FOREIGN KEY (`care_gap_closure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`care_gap_closure`(`care_gap_closure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_raf_score_id` FOREIGN KEY (`raf_score_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`raf_score`(`raf_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_prior_finding_standard_finding_id` FOREIGN KEY (`prior_finding_standard_finding_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`standard_finding`(`standard_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_population_quality_measure_id` FOREIGN KEY (`population_quality_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_chw_intervention_id` FOREIGN KEY (`chw_intervention_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`chw_intervention`(`chw_intervention_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_sdoh_risk_stratification_id` FOREIGN KEY (`sdoh_risk_stratification_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification`(`sdoh_risk_stratification_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_mortality_review_id` FOREIGN KEY (`mortality_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`mortality_review`(`mortality_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_parent_corrective_action_id` FOREIGN KEY (`parent_corrective_action_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_standard_finding_id` FOREIGN KEY (`standard_finding_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`standard_finding`(`standard_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_program_quality_measure_id` FOREIGN KEY (`program_quality_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_initiative_quality_measure_id` FOREIGN KEY (`initiative_quality_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_prior_raf_score_id` FOREIGN KEY (`prior_raf_score_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`raf_score`(`raf_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_reopened_care_gap_closure_id` FOREIGN KEY (`reopened_care_gap_closure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`care_gap_closure`(`care_gap_closure_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`quality` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`quality` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_hedis' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_ncqa' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_quality_measure' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_performance_reporting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measure Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Policy');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `age_range_max` SET TAGS ('pii_business_glossary_term' = 'Age Range Maximum');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `age_range_min` SET TAGS ('pii_business_glossary_term' = 'Age Range Minimum');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `allowable_gap_days` SET TAGS ('pii_business_glossary_term' = 'Allowable Gap Days');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_business_glossary_term' = 'Clinical Area');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_business_glossary_term' = 'Continuous Enrollment Days');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `cpt_code_list` SET TAGS ('pii_business_glossary_term' = 'CPT Code List');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `denominator_definition` SET TAGS ('pii_business_glossary_term' = 'Denominator Definition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `domain_category` SET TAGS ('pii_business_glossary_term' = 'Domain Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `eligible_population_description` SET TAGS ('pii_business_glossary_term' = 'Eligible Population Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `exception_criteria` SET TAGS ('pii_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hedis_ecqm_code` SET TAGS ('pii_business_glossary_term' = 'HEDIS eCQM Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_business_glossary_term' = 'Hybrid Medical Record Required');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `icd10_code_list` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Code List');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `icd10_code_list` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `loinc_code_list` SET TAGS ('pii_business_glossary_term' = 'LOINC Code List');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_code` SET TAGS ('pii_business_glossary_term' = 'Measure Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_business_glossary_term' = 'Measure Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_business_glossary_term' = 'Measure Short Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_status` SET TAGS ('pii_business_glossary_term' = 'Measure Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_type` SET TAGS ('pii_business_glossary_term' = 'Measure Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_version` SET TAGS ('pii_business_glossary_term' = 'Measure Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `minimum_performance_threshold` SET TAGS ('pii_business_glossary_term' = 'Minimum Performance Threshold');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `mips_eligible` SET TAGS ('pii_business_glossary_term' = 'MIPS Eligible');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `national_average_rate` SET TAGS ('pii_business_glossary_term' = 'National Average Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `national_benchmark_rate` SET TAGS ('pii_business_glossary_term' = 'National Benchmark Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `ncqa_program` SET TAGS ('pii_business_glossary_term' = 'NCQA Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `ncqa_specification_url` SET TAGS ('pii_business_glossary_term' = 'NCQA Specification URL');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `numerator_definition` SET TAGS ('pii_business_glossary_term' = 'Numerator Definition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `performance_rate_direction` SET TAGS ('pii_business_glossary_term' = 'Performance Rate Direction');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `product_line` SET TAGS ('pii_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Reporting Submission Deadline');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `responsible_program` SET TAGS ('pii_business_glossary_term' = 'Responsible Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `stratification_criteria` SET TAGS ('pii_business_glossary_term' = 'Stratification Criteria');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `stratification_required` SET TAGS ('pii_business_glossary_term' = 'Stratification Required');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `target_performance_rate` SET TAGS ('pii_business_glossary_term' = 'Target Performance Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `value_set_oid` SET TAGS ('pii_business_glossary_term' = 'Value Set OID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_hedis' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_ncqa' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_quality_result' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_performance_reporting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `hedis_result_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Submission');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Organization Provider');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `auditor_organization` SET TAGS ('pii_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `benchmark_comparison_result` SET TAGS ('pii_business_glossary_term' = 'Benchmark Comparison Result');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `calculation_run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Calculation Run Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `data_source_type` SET TAGS ('pii_business_glossary_term' = 'Data Source Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `denominator_count` SET TAGS ('pii_business_glossary_term' = 'Denominator Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `exception_count` SET TAGS ('pii_business_glossary_term' = 'Exception Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `exclusion_count` SET TAGS ('pii_business_glossary_term' = 'Exclusion Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `gap_count` SET TAGS ('pii_business_glossary_term' = 'Gap Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `hybrid_sample_size` SET TAGS ('pii_business_glossary_term' = 'Hybrid Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `hybrid_supplemental_data_used` SET TAGS ('pii_business_glossary_term' = 'Hybrid Supplemental Data Used');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `initial_population_count` SET TAGS ('pii_business_glossary_term' = 'Initial Population Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `is_reportable` SET TAGS ('pii_business_glossary_term' = 'Is Reportable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `is_starred_measure` SET TAGS ('pii_business_glossary_term' = 'Is Starred Measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `methodology_type` SET TAGS ('pii_business_glossary_term' = 'Methodology Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `mips_quality_category` SET TAGS ('pii_business_glossary_term' = 'MIPS Quality Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `ncqa_benchmark_percentile_50` SET TAGS ('pii_business_glossary_term' = 'NCQA Benchmark Percentile 50');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `ncqa_benchmark_percentile_90` SET TAGS ('pii_business_glossary_term' = 'NCQA Benchmark Percentile 90');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `numerator_count` SET TAGS ('pii_business_glossary_term' = 'Numerator Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `performance_rate` SET TAGS ('pii_business_glossary_term' = 'Performance Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `prior_year_performance_rate` SET TAGS ('pii_business_glossary_term' = 'Prior Year Performance Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `product_line` SET TAGS ('pii_business_glossary_term' = 'Product Line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `rate_change_from_prior_year` SET TAGS ('pii_business_glossary_term' = 'Rate Change from Prior Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_business_glossary_term' = 'Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_notes` SET TAGS ('pii_business_glossary_term' = 'Result Notes');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_version` SET TAGS ('pii_business_glossary_term' = 'Result Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_business_glossary_term' = 'Star Rating Weight');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `stratification_category` SET TAGS ('pii_business_glossary_term' = 'Stratification Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `submission_target` SET TAGS ('pii_business_glossary_term' = 'Submission Target');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_cahps' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_hcahps' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_patient_experience' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_survey' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `cahps_survey_id` SET TAGS ('pii_business_glossary_term' = 'CAHPS Survey Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `administration_mode` SET TAGS ('pii_business_glossary_term' = 'Administration Mode');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `cms_submission_date` SET TAGS ('pii_business_glossary_term' = 'CMS Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `cms_submission_status` SET TAGS ('pii_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `eligible_discharges` SET TAGS ('pii_business_glossary_term' = 'Eligible Discharges');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `hcahps_linear_mean_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Linear Mean Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `minimum_case_threshold_met` SET TAGS ('pii_business_glossary_term' = 'Minimum Case Threshold Met');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `mode_adjustment_applied` SET TAGS ('pii_business_glossary_term' = 'Mode Adjustment Applied');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Hospital Rating');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mix_adjustment_applied` SET TAGS ('pii_business_glossary_term' = 'Patient Mix Adjustment Applied');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mix_adjustment_applied` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mix_adjustment_applied` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `publicly_reported` SET TAGS ('pii_business_glossary_term' = 'Publicly Reported');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `recommend_hospital` SET TAGS ('pii_business_glossary_term' = 'Recommend Hospital');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `response_language` SET TAGS ('pii_business_glossary_term' = 'Response Language');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `response_received` SET TAGS ('pii_business_glossary_term' = 'Response Received');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `sampling_methodology` SET TAGS ('pii_business_glossary_term' = 'Sampling Methodology');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_care_transition` SET TAGS ('pii_business_glossary_term' = 'Score Care Transition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_cleanliness` SET TAGS ('pii_business_glossary_term' = 'Score Cleanliness');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_communication_doctors` SET TAGS ('pii_business_glossary_term' = 'Score Communication Doctors');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_communication_medicines` SET TAGS ('pii_business_glossary_term' = 'Score Communication Medicines');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_communication_nurses` SET TAGS ('pii_business_glossary_term' = 'Score Communication Nurses');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_discharge_information` SET TAGS ('pii_business_glossary_term' = 'Score Discharge Information');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_pain_management` SET TAGS ('pii_business_glossary_term' = 'Score Pain Management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_quietness` SET TAGS ('pii_business_glossary_term' = 'Score Quietness');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `score_responsiveness_staff` SET TAGS ('pii_business_glossary_term' = 'Score Responsiveness Staff');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_followup_date` SET TAGS ('pii_business_glossary_term' = 'Survey Followup Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_mailed_date` SET TAGS ('pii_business_glossary_term' = 'Survey Mailed Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_program_code` SET TAGS ('pii_business_glossary_term' = 'Survey Program Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_status` SET TAGS ('pii_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `survey_version` SET TAGS ('pii_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_business_glossary_term' = 'VBP Patient Experience Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_certification_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_cahps' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_patient_experience' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_survey_response' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `cahps_response_id` SET TAGS ('pii_business_glossary_term' = 'Consumer Assessment of Healthcare Providers and Systems (CAHPS) Response ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `cahps_survey_id` SET TAGS ('pii_business_glossary_term' = 'CAHPS Survey ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `cahps_survey_id` SET TAGS ('pii_business_role' = 'primary_cahps_survey_reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_cahps_survey_id` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `adjusted_composite_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Case-Mix Adjusted Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `administration_mode` SET TAGS ('pii_business_glossary_term' = 'Survey Administration Mode');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `care_transition_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Care Transition Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Survey Contact Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Patient Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `discharge_information_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Discharge Information Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `doctor_communication_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Communication with Doctors Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `education_level` SET TAGS ('pii_business_glossary_term' = 'Patient Education Level');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `education_level` SET TAGS ('pii_value_regex' = '8th_grade_or_less|some_high_school|high_school_graduate|some_college|4_year_college_graduate|more_than_4_year_college');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `first_contact_date` SET TAGS ('pii_business_glossary_term' = 'First Survey Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `first_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `first_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `hospital_environment_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Hospital Environment Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `ineligibility_reason` SET TAGS ('pii_business_glossary_term' = 'Survey Ineligibility Reason');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `ineligibility_reason` SET TAGS ('pii_value_regex' = 'age_under_18|psychiatric_admission|excluded_drg|no_overnight_stay|court_ordered|other');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `is_eligible` SET TAGS ('pii_business_glossary_term' = 'Survey Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `is_sampled` SET TAGS ('pii_business_glossary_term' = 'Survey Sampled Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `language_of_response` SET TAGS ('pii_business_glossary_term' = 'Survey Response Language');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `language_of_response` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `length_of_stay_days` SET TAGS ('pii_business_glossary_term' = 'Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `medicine_communication_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Communication About Medicines Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `nurse_communication_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Communication with Nurses Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Overall Hospital Rating');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `pain_management_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Pain Management Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_service_line` SET TAGS ('pii_business_glossary_term' = 'Patient Service Line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_service_line` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_service_line` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `program_year` SET TAGS ('pii_business_glossary_term' = 'CMS Program Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `recommend_hospital` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Hospital Recommendation Response');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `recommend_hospital` SET TAGS ('pii_value_regex' = 'definitely_yes|probably_yes|probably_no|definitely_no');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_business_glossary_term' = 'CMS Reporting Quarter');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_value_regex' = '^[0-9]{4}Q[1-4]$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `response_date` SET TAGS ('pii_business_glossary_term' = 'Survey Response Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `response_status` SET TAGS ('pii_business_glossary_term' = 'Survey Response Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `response_status` SET TAGS ('pii_value_regex' = 'completed|non_response|ineligible|deceased|bad_address|language_barrier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `sampling_date` SET TAGS ('pii_business_glossary_term' = 'Survey Sampling Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_business_glossary_term' = 'Patient Self-Reported Health Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_value_regex' = 'excellent|very_good|good|fair|poor');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `service_category` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Patient Service Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `service_category` SET TAGS ('pii_value_regex' = 'medical|surgical|maternity');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `staff_responsiveness_score` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Responsiveness of Hospital Staff Composite Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'CAHPS Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'HCAHPS|CGCAHPS|PCMH_CAHPS|ED_CAHPS|OAS_CAHPS');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_doctor_communication` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Top-Box Doctor Communication Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_nurse_communication` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Top-Box Nurse Communication Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Top-Box Overall Rating Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_recommend` SET TAGS ('pii_business_glossary_term' = 'HCAHPS Top-Box Recommend Hospital Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Patient Experience of Care Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_patient_safety' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_adverse_event' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `bed_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Bed Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `bed_id` SET TAGS ('pii_business_glossary_term' = 'Bed Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contrast_admin_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `critical_result_id` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Notification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Disclosure Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `environmental_service_request_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Service Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `environmental_service_request_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `hazardous_material_id` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `hotline_report_id` SET TAGS ('pii_business_glossary_term' = 'Hotline Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `maintenance_order_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'Or Suite Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Risk Manager ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `dose_record_id` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `triage_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Triage Assessment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `udi_record_id` SET TAGS ('pii_business_glossary_term' = 'Udi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_plan_completion_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_plan_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|overdue|verified');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `action_plan_summary` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `confidentiality_indicator` SET TAGS ('pii_business_glossary_term' = 'Peer Review Confidentiality Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `confidentiality_indicator` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_business_glossary_term' = 'Contributing Factors Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Patient Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `disclosure_status` SET TAGS ('pii_business_glossary_term' = 'Patient Disclosure Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `disclosure_status` SET TAGS ('pii_value_regex' = 'not_required|pending|disclosed|declined_by_patient');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `effectiveness_verified` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verified Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_category` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_description` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_number` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_status` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_status` SET TAGS ('pii_value_regex' = 'reported|under_review|rca_in_progress|action_plan_active|closed|voided');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Occurrence Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'sentinel_event|serious_safety_event|near_miss|unsafe_condition|no_harm_event');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `hai_event_type` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `hai_event_type` SET TAGS ('pii_value_regex' = 'CLABSI|CAUTI|SSI|VAP|CDIFF|none');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `hai_event_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_code` SET TAGS ('pii_business_glossary_term' = 'Harm Level Code (NCC MERP)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_code` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_description` SET TAGS ('pii_business_glossary_term' = 'Harm Level Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `immediate_actions_taken` SET TAGS ('pii_business_glossary_term' = 'Immediate Actions Taken');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_cms_reportable` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reportable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_business_glossary_term' = 'Sentinel Event Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_business_glossary_term' = 'State Regulatory Reportable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `location_unit` SET TAGS ('pii_business_glossary_term' = 'Event Location Unit');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_business_glossary_term' = 'Patient Outcome');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_value_regex' = 'no_harm|temporary_harm|permanent_harm|required_intervention|death|unknown');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `report_timestamp` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Report Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Review Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Review Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_team_members` SET TAGS ('pii_business_glossary_term' = 'Review Team Members');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_team_members` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_team_members` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Investigation Review Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'RCA|ACA|apparent_cause|peer_review|no_review_required');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `root_causes_identified` SET TAGS ('pii_business_glossary_term' = 'Root Causes Identified');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `source_event_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `tjc_acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `tjc_submission_date` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_patient_safety' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_root_cause_analysis' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `safety_event_review_id` SET TAGS ('pii_business_glossary_term' = 'Safety Event Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_business_glossary_term' = 'Safety Event ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `prior_review_safety_event_review_id` SET TAGS ('pii_business_glossary_term' = 'Prior Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_plan_completed_date` SET TAGS ('pii_business_glossary_term' = 'Action Plan Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Action Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_plan_status` SET TAGS ('pii_value_regex' = 'Not Started|In Progress|Completed|Overdue|Cancelled');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `action_plan_summary` SET TAGS ('pii_business_glossary_term' = 'Action Plan Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `cms_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_business_glossary_term' = 'Contributing Factors Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `department_unit` SET TAGS ('pii_business_glossary_term' = 'Department / Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `disclosure_date` SET TAGS ('pii_business_glossary_term' = 'Patient Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `disclosure_to_patient_flag` SET TAGS ('pii_business_glossary_term' = 'Disclosure to Patient Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `disclosure_to_patient_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `disclosure_to_patient_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `effectiveness_verification_notes` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Notes');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `effectiveness_verification_status` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `effectiveness_verification_status` SET TAGS ('pii_value_regex' = 'Pending|In Progress|Verified Effective|Verified Ineffective|Inconclusive');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `event_category` SET TAGS ('pii_business_glossary_term' = 'Safety Event Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `event_category` SET TAGS ('pii_value_regex' = 'Sentinel Event|Serious Safety Event|Near Miss|Precursor|No Harm Event');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `event_date` SET TAGS ('pii_business_glossary_term' = 'Safety Event Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `event_type_code` SET TAGS ('pii_business_glossary_term' = 'Safety Event Type Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `event_type_description` SET TAGS ('pii_business_glossary_term' = 'Safety Event Type Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `hai_event_type` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `hai_event_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `harm_level` SET TAGS ('pii_business_glossary_term' = 'Harm Level (NCC MERP Index)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `harm_level` SET TAGS ('pii_value_regex' = 'E - Temporary Harm|F - Temporary Harm with Intervention|G - Permanent Harm|H - Life-Sustaining Intervention|I - Death');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `harm_level` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_indicator_code` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Indicator (PSI) Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_indicator_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_indicator_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `quality_committee_review_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Committee Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `recurrence_flag` SET TAGS ('pii_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_approved_date` SET TAGS ('pii_business_glossary_term' = 'Review Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_completed_date` SET TAGS ('pii_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_initiated_date` SET TAGS ('pii_business_glossary_term' = 'Review Initiated Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'Initiated|In Progress|Pending Approval|Completed|Closed|Cancelled');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_team_composition` SET TAGS ('pii_business_glossary_term' = 'Review Team Composition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_team_size` SET TAGS ('pii_business_glossary_term' = 'Review Team Size');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'RCA|ACA|FMEA|Peer Review|Mortality Review|Near Miss Review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `root_cause_summary` SET TAGS ('pii_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'State Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `tjc_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `tjc_reported_date` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Reported Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_mortality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_peer_review' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_review_id` SET TAGS ('pii_business_glossary_term' = 'Mortality Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mortality_review_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Peer Review Committee ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Review Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `reviewer_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Primary Reviewer Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `udi_record_id` SET TAGS ('pii_business_glossary_term' = 'Udi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `action_plan_required_flag` SET TAGS ('pii_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_business_glossary_term' = 'Care Quality Rating');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_value_regex' = 'optimal|suboptimal|poor|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `cdi_query_initiated_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Initiated Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `cmi_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Case Mix Index (CMI) Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `cms_mortality_measure_code` SET TAGS ('pii_business_glossary_term' = 'CMS Mortality Outcome Measure Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `cms_mortality_measure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `cms_mortality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'CMS Mortality Outcome Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `cms_mortality_measure_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `committee_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Committee Findings Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `committee_findings_summary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `committee_review_date` SET TAGS ('pii_business_glossary_term' = 'Committee Review Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `confidentiality_protection_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Confidentiality Protection Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_business_glossary_term' = 'Contributing Clinical Factor 1');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_business_glossary_term' = 'Contributing Clinical Factor 2');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_business_glossary_term' = 'Contributing Clinical Factor 3');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_business_glossary_term' = 'Days from Admission to Death');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_business_glossary_term' = 'Death Classification');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_value_regex' = 'expected|unexpected|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_business_glossary_term' = 'Date of Death');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_business_glossary_term' = 'Death Location Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_business_glossary_term' = 'Date and Time of Death');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_business_glossary_term' = 'Do Not Resuscitate (DNR) Status at Time of Death');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_value_regex' = 'full_code|dnr|dni|dnr_dni|comfort_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `hai_related_flag` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `hai_type` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `hospice_enrolled_flag` SET TAGS ('pii_business_glossary_term' = 'Hospice Enrollment Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `hospice_enrolled_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendation` SET TAGS ('pii_business_glossary_term' = 'Improvement Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `improvement_recommendation` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mips_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'Merit-Based Incentive Payment System (MIPS) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `palliative_care_involved_flag` SET TAGS ('pii_business_glossary_term' = 'Palliative Care Involvement Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `palliative_care_involved_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability_determination` SET TAGS ('pii_business_glossary_term' = 'Preventability Determination');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `preventability_determination` SET TAGS ('pii_value_regex' = 'preventable|potentially_preventable|not_preventable|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_business_glossary_term' = 'Primary Cause of Death Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_business_glossary_term' = 'Primary ICD-10 Cause of Death Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_value_regex' = '^[A-Z][0-9A-Z]{2,6}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `readmission_related_flag` SET TAGS ('pii_business_glossary_term' = 'Readmission-Related Death Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `review_case_number` SET TAGS ('pii_business_glossary_term' = 'Mortality Review Case Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `review_completed_date` SET TAGS ('pii_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `review_initiated_date` SET TAGS ('pii_business_glossary_term' = 'Review Initiated Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Mortality Review Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'initiated|in_review|pending_committee|completed|closed|voided');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `review_trigger_type` SET TAGS ('pii_business_glossary_term' = 'Mortality Review Trigger Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `root_cause_analysis_required_flag` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis (RCA) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_business_glossary_term' = 'Sentinel Event Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `surgical_case_flag` SET TAGS ('pii_business_glossary_term' = 'Surgical Case Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_vbp' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_value_based_care' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_cms' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `vbp_program_id` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Program ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `achievement_benchmark_percentile` SET TAGS ('pii_business_glossary_term' = 'Achievement Benchmark Percentile');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `achievement_benchmark_percentile` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `achievement_threshold_percentile` SET TAGS ('pii_business_glossary_term' = 'Achievement Threshold Percentile');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `achievement_threshold_percentile` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `applicable_provider_type` SET TAGS ('pii_business_glossary_term' = 'Applicable Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `applicable_provider_type` SET TAGS ('pii_value_regex' = 'acute_care_hospital|critical_access_hospital|psychiatric_hospital|long_term_care|skilled_nursing_facility|home_health_agency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Program Configuration Approved By');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Program Configuration Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `baseline_period_end` SET TAGS ('pii_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `baseline_period_start` SET TAGS ('pii_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `cahps_survey_vendor_required` SET TAGS ('pii_business_glossary_term' = 'CAHPS Survey Approved Vendor Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_business_glossary_term' = 'Clinical Outcomes Domain Weight');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `cms_program_code` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `cms_program_code` SET TAGS ('pii_value_regex' = '^CMS-VBP-[0-9]{4}-[A-Z0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `correction_window_end` SET TAGS ('pii_business_glossary_term' = 'VBP Score Correction Window End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `efficiency_cost_reduction_weight` SET TAGS ('pii_business_glossary_term' = 'Efficiency and Cost Reduction Domain Weight');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `federal_register_notice` SET TAGS ('pii_business_glossary_term' = 'Federal Register Notice Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `final_score_publication_date` SET TAGS ('pii_business_glossary_term' = 'VBP Final Score Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'CMS Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `is_new_measure_set` SET TAGS ('pii_business_glossary_term' = 'New Measure Set Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `max_achievement_points` SET TAGS ('pii_business_glossary_term' = 'Maximum Achievement Points');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `max_domain_score` SET TAGS ('pii_business_glossary_term' = 'Maximum Domain Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `max_improvement_points` SET TAGS ('pii_business_glossary_term' = 'Maximum Improvement Points');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `max_payment_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Maximum VBP Payment Adjustment Factor');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `max_tps` SET TAGS ('pii_business_glossary_term' = 'Maximum Total Performance Score (TPS)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `measure_set_version` SET TAGS ('pii_business_glossary_term' = 'VBP Measure Set Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `min_case_volume_required` SET TAGS ('pii_business_glossary_term' = 'Minimum Case Volume Required for Measure Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `min_measure_count_required` SET TAGS ('pii_business_glossary_term' = 'Minimum Measure Count Required for Scoring');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `min_payment_adjustment_factor` SET TAGS ('pii_business_glossary_term' = 'Minimum VBP Payment Adjustment Factor');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `nqf_alignment_flag` SET TAGS ('pii_business_glossary_term' = 'National Quality Forum (NQF) Measure Alignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `payment_adjustment_formula` SET TAGS ('pii_business_glossary_term' = 'VBP Payment Adjustment Formula Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `payment_year` SET TAGS ('pii_business_glossary_term' = 'VBP Payment Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `performance_period_end` SET TAGS ('pii_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `performance_period_start` SET TAGS ('pii_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `person_community_engagement_weight` SET TAGS ('pii_business_glossary_term' = 'Person and Community Engagement Domain Weight');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `preview_report_release_date` SET TAGS ('pii_business_glossary_term' = 'VBP Preview Report Release Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Program Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_code` SET TAGS ('pii_value_regex' = '^VBP-[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_description` SET TAGS ('pii_business_glossary_term' = 'VBP Program Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Program Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Program Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Program Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'HVBP|PVBP|ESRD_QIP|SNF_VBP|HH_VBP');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `qualitynet_program_code` SET TAGS ('pii_business_glossary_term' = 'QualityNet Program Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `regulatory_rule_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Rule Citation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `safety_domain_weight` SET TAGS ('pii_business_glossary_term' = 'Safety Domain Weight');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `total_domain_weight_check` SET TAGS ('pii_business_glossary_term' = 'Total Domain Weight Validation Sum');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `tps_methodology` SET TAGS ('pii_business_glossary_term' = 'Total Performance Score (TPS) Methodology');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `tps_methodology` SET TAGS ('pii_value_regex' = 'achievement_improvement_higher|achievement_only|improvement_only');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `withhold_rate` SET TAGS ('pii_business_glossary_term' = 'VBP Medicare Payment Withhold Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `withhold_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_quality_measure' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_performance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_reporting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Measure Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Measure Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `active_status` SET TAGS ('pii_business_glossary_term' = 'Measure Active Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `active_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|draft|under_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `benchmark_percentile` SET TAGS ('pii_business_glossary_term' = 'Benchmark Percentile');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `benchmark_percentile` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `benchmark_threshold` SET TAGS ('pii_business_glossary_term' = 'Benchmark Performance Threshold');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_business_glossary_term' = 'Clinical Domain');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `cms_ecqm_code` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Electronic Clinical Quality Measure (eCQM) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `cms_ecqm_code` SET TAGS ('pii_value_regex' = '^CMS[0-9]{1,5}v[0-9]{1,3}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_code` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `cpt_code_set` SET TAGS ('pii_business_glossary_term' = 'Current Procedural Terminology (CPT) Code Set');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `cpt_code_set` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Measure Data Source');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `denominator_definition` SET TAGS ('pii_business_glossary_term' = 'Measure Denominator Definition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `denominator_exception` SET TAGS ('pii_business_glossary_term' = 'Measure Denominator Exception');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `denominator_exclusion` SET TAGS ('pii_business_glossary_term' = 'Measure Denominator Exclusion');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Measure Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Measure Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `eligible_population_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligible Population Criteria');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `floor_threshold` SET TAGS ('pii_business_glossary_term' = 'Performance Floor Threshold');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `hai_category` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `higher_is_better` SET TAGS ('pii_business_glossary_term' = 'Higher Score Is Better Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd10_code_set` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code Set');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd10_code_set` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd10_code_set` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `loinc_code_set` SET TAGS ('pii_business_glossary_term' = 'Logical Observation Identifiers Names and Codes (LOINC) Code Set');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `loinc_code_set` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_type` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_type` SET TAGS ('pii_value_regex' = 'process|outcome|structural|patient_experience|efficiency|intermediate_outcome');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measurement_methodology` SET TAGS ('pii_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measurement_methodology` SET TAGS ('pii_value_regex' = 'administrative|hybrid|chart_abstracted|ecqm|survey|registry');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `minimum_sample_size` SET TAGS ('pii_business_glossary_term' = 'Minimum Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `mips_category` SET TAGS ('pii_business_glossary_term' = 'Merit-Based Incentive Payment System (MIPS) Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `mips_category` SET TAGS ('pii_value_regex' = 'quality|promoting_interoperability|improvement_activities|cost|NONE');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `measure_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `nqf_number` SET TAGS ('pii_business_glossary_term' = 'National Quality Forum (NQF) Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `nqf_number` SET TAGS ('pii_value_regex' = '^NQF-?[0-9]{4}[A-Za-z]?$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `numerator_definition` SET TAGS ('pii_business_glossary_term' = 'Measure Numerator Definition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_business_glossary_term' = 'Quality Reporting Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `risk_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `risk_adjustment_model` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Model');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Short Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `snomed_code_set` SET TAGS ('pii_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code Set');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `snomed_code_set` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `specification_url` SET TAGS ('pii_business_glossary_term' = 'Measure Specification URL');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `steward` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Steward');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `stratification_criteria` SET TAGS ('pii_business_glossary_term' = 'Measure Stratification Criteria');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Deadline');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Title');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `tjc_measure_set` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `vbp_domain` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Domain');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `vbp_domain` SET TAGS ('pii_value_regex' = 'clinical_care|safety|efficiency|patient_experience|NONE');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Measure Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `version` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_quality_result' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_performance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_reporting' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measure_result_id` SET TAGS ('pii_business_glossary_term' = 'Measure Result ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Measure ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `radiology_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reader_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Radiologist Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `service_id` SET TAGS ('pii_business_glossary_term' = 'Facility Service Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `visit_procedure_id` SET TAGS ('pii_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `visit_procedure_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `visit_procedure_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `benchmark_comparison_result` SET TAGS ('pii_business_glossary_term' = 'Benchmark Comparison Result');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `benchmark_comparison_result` SET TAGS ('pii_value_regex' = 'above_benchmark|at_benchmark|below_benchmark|no_benchmark');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `cms_submission_date` SET TAGS ('pii_business_glossary_term' = 'CMS Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `data_completeness_rate` SET TAGS ('pii_business_glossary_term' = 'Data Completeness Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `data_completeness_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `denominator_count` SET TAGS ('pii_business_glossary_term' = 'Denominator Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `exception_count` SET TAGS ('pii_business_glossary_term' = 'Exception Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `exclusion_count` SET TAGS ('pii_business_glossary_term' = 'Exclusion Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `gap_count` SET TAGS ('pii_business_glossary_term' = 'Gap Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `gap_to_target_rate` SET TAGS ('pii_business_glossary_term' = 'Gap to Target Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `gap_to_target_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `hai_event_type` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `hai_event_type` SET TAGS ('pii_value_regex' = 'CLABSI|CAUTI|SSI|MRSA|CDI|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `hai_event_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `hedis_methodology_indicator` SET TAGS ('pii_business_glossary_term' = 'HEDIS Methodology Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `is_publicly_reported` SET TAGS ('pii_business_glossary_term' = 'Publicly Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measure_domain` SET TAGS ('pii_business_glossary_term' = 'Measure Domain');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measurement_level` SET TAGS ('pii_business_glossary_term' = 'Measurement Level');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measurement_level` SET TAGS ('pii_value_regex' = 'facility|unit|provider|health_plan|population');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measurement_methodology` SET TAGS ('pii_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measurement_methodology` SET TAGS ('pii_value_regex' = 'administrative|hybrid|chart_abstracted|registry|ehr_direct');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measurement_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `measurement_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_business_glossary_term' = 'Meets Reporting Threshold Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `mips_measure_category` SET TAGS ('pii_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Measure Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `mips_measure_category` SET TAGS ('pii_value_regex' = 'quality|promoting_interoperability|improvement_activities|cost');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `mips_points_earned` SET TAGS ('pii_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Points Earned');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `national_benchmark_rate` SET TAGS ('pii_business_glossary_term' = 'National Benchmark Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `national_benchmark_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `ncqa_submission_status` SET TAGS ('pii_business_glossary_term' = 'National Committee for Quality Assurance (NCQA) Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `ncqa_submission_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|accepted|rejected|pending');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `nqf_number` SET TAGS ('pii_business_glossary_term' = 'National Quality Forum (NQF) Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `nqf_number` SET TAGS ('pii_value_regex' = '^NQF-[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `numerator_count` SET TAGS ('pii_business_glossary_term' = 'Numerator Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `payer_submission_status` SET TAGS ('pii_business_glossary_term' = 'Payer Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `payer_submission_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|accepted|rejected|pending');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `percentile_rank` SET TAGS ('pii_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `percentile_rank` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `performance_rate` SET TAGS ('pii_business_glossary_term' = 'Performance Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `performance_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `performance_year` SET TAGS ('pii_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_business_glossary_term' = 'Reporting Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `result_calculated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Result Calculated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `result_status` SET TAGS ('pii_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `result_status` SET TAGS ('pii_value_regex' = 'draft|final|submitted|accepted|rejected|under_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `sir_value` SET TAGS ('pii_business_glossary_term' = 'Standardized Infection Ratio (SIR) Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `target_rate` SET TAGS ('pii_business_glossary_term' = 'Target Rate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `target_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `vbp_achievement_score` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Achievement Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `vbp_domain` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Domain');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `vbp_improvement_score` SET TAGS ('pii_business_glossary_term' = 'Value-Based Purchasing (VBP) Improvement Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_cdi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_clinical_documentation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `cdi_review_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `cdi_worksheet_id` SET TAGS ('pii_business_glossary_term' = 'CDI Worksheet ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_assignment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'CDI Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Working Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `admit_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `cc_mcc_opportunity_flag` SET TAGS ('pii_business_glossary_term' = 'CC/MCC Capture Opportunity Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `cc_mcc_status` SET TAGS ('pii_business_glossary_term' = 'Complication and Comorbidity / Major Complication and Comorbidity (CC/MCC) Capture Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `cc_mcc_status` SET TAGS ('pii_value_regex' = 'no_cc_mcc|cc|mcc|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_business_glossary_term' = 'Clinical Indicator Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `cmi_impact` SET TAGS ('pii_business_glossary_term' = 'Case Mix Index (CMI) Impact');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `documentation_impact` SET TAGS ('pii_business_glossary_term' = 'Documentation Impact Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `documentation_impact` SET TAGS ('pii_value_regex' = 'drg_change|cc_mcc_capture|poa_change|no_impact|multiple');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_change_flag` SET TAGS ('pii_business_glossary_term' = 'DRG Change Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_change_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `poa_status` SET TAGS ('pii_business_glossary_term' = 'Present on Admission (POA) Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `poa_status` SET TAGS ('pii_value_regex' = 'yes|no|unknown|exempt|clinically_undetermined');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis ICD-10-CM Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_initiated_flag` SET TAGS ('pii_business_glossary_term' = 'Physician Query Initiated Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_method` SET TAGS ('pii_business_glossary_term' = 'Physician Query Method');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_method` SET TAGS ('pii_value_regex' = 'verbal|written|electronic|concurrent_electronic');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_outcome` SET TAGS ('pii_business_glossary_term' = 'Physician Query Outcome');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_outcome` SET TAGS ('pii_value_regex' = 'agree|disagree|amended|no_change|clinically_undetermined');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_response_date` SET TAGS ('pii_business_glossary_term' = 'Physician Query Response Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_response_status` SET TAGS ('pii_business_glossary_term' = 'Physician Query Response Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_response_status` SET TAGS ('pii_value_regex' = 'pending|responded|no_response|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_type` SET TAGS ('pii_business_glossary_term' = 'Physician Query Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `query_type` SET TAGS ('pii_value_regex' = 'compliant|leading|non_compliant');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_completion_timestamp` SET TAGS ('pii_business_glossary_term' = 'CDI Review Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'CDI Review Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_finding_type` SET TAGS ('pii_business_glossary_term' = 'CDI Review Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_finding_type` SET TAGS ('pii_value_regex' = 'query_opportunity|no_opportunity|documentation_complete|unable_to_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_lag_days` SET TAGS ('pii_business_glossary_term' = 'CDI Review Lag Days');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'CDI Review Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_number` SET TAGS ('pii_value_regex' = '^CDI-[0-9]{4}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_sequence_number` SET TAGS ('pii_business_glossary_term' = 'CDI Review Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'CDI Review Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'open|pending_query|pending_response|completed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_timestamp` SET TAGS ('pii_business_glossary_term' = 'CDI Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'CDI Review Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'initial|follow_up|post_discharge|concurrent|retrospective');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_credential` SET TAGS ('pii_business_glossary_term' = 'CDI Reviewer Credential');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_role` SET TAGS ('pii_business_glossary_term' = 'CDI Reviewer Role');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_role` SET TAGS ('pii_value_regex' = 'cdi_specialist|cdi_physician_advisor|coder|supervisor');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `source_review_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_subdomain' = 'accreditation_compliance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_accreditation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_tjc' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_cms' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Coordinator Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_cycle_years` SET TAGS ('pii_business_glossary_term' = 'Accreditation Cycle Duration (Years)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_cycle_years` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_value_regex' = 'accredited|accredited_with_follow_up|conditional|preliminary_denial|denial|not_accredited');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_value_regex' = 'TJC|CMS|NCQA|DNV|HFAP|URAC');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Plan of Correction Acceptance Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_acceptance_status` SET TAGS ('pii_value_regex' = 'accepted|rejected|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `complaint_survey_indicator` SET TAGS ('pii_business_glossary_term' = 'Complaint Survey Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_business_glossary_term' = 'Condition-Level Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `deemed_status` SET TAGS ('pii_business_glossary_term' = 'Deemed Status Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Finding Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial|resolved|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_evidence` SET TAGS ('pii_business_glossary_term' = 'Finding Evidence');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Finding Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_resolution_status` SET TAGS ('pii_business_glossary_term' = 'Finding Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_resolution_status` SET TAGS ('pii_value_regex' = 'open|in_progress|resolved|verified|closed');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_standard_reference` SET TAGS ('pii_business_glossary_term' = 'Finding Standard Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'RFI|immediate_threat|condition_level_deficiency|standard_level_deficiency|observation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Survey Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `follow_up_survey_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `immediate_threat_count` SET TAGS ('pii_business_glossary_term' = 'Immediate Threat to Health and Safety Finding Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `is_cms_cop_applicable` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Conditions of Participation (CoP) Applicable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `last_cms_validation_date` SET TAGS ('pii_business_glossary_term' = 'Last Centers for Medicare and Medicaid Services (CMS) Validation Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `next_survey_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Survey Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `plan_of_correction` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `poc_due_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `poc_submission_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (PoC) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_number` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_status` SET TAGS ('pii_value_regex' = 'active|pending|suspended|withdrawn|expired|denied');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `readiness_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Survey Readiness Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `readiness_score` SET TAGS ('pii_business_glossary_term' = 'Survey Readiness Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `regulatory_body_contact` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body Contact Information');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `regulatory_body_contact` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `regulatory_body_contact` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `standard_level_deficiency_count` SET TAGS ('pii_business_glossary_term' = 'Standard-Level Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `standards_chapters_reviewed` SET TAGS ('pii_business_glossary_term' = 'Standards Chapters Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_business_glossary_term' = 'State Facility License Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_business_glossary_term' = 'State Survey Agency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_date` SET TAGS ('pii_business_glossary_term' = 'Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_end_date` SET TAGS ('pii_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_scope` SET TAGS ('pii_business_glossary_term' = 'Survey Scope');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'triennial|unannounced|for_cause|validation|internal_mock|readiness_tracer');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `surveyor_team` SET TAGS ('pii_business_glossary_term' = 'Surveyor Team');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `total_findings_count` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_subdomain' = 'accreditation_compliance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_accreditation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_survey' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_tjc' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_value_regex' = 'accredited|conditional|preliminary_denial|denial|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_decision_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_standards_edition` SET TAGS ('pii_business_glossary_term' = 'Accreditation Standards Edition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accreditation_standards_edition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number (CCN)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_business_glossary_term' = 'Condition-Level Deficiency Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `cop_deficiencies_cited` SET TAGS ('pii_business_glossary_term' = 'Conditions of Participation (CoP) Deficiencies Cited');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_value_regex' = 'not_required|in_progress|submitted|accepted|overdue');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `environment_of_care_included` SET TAGS ('pii_business_glossary_term' = 'Environment of Care (EC) Module Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `esc_acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Evidence of Standards Compliance (ESC) Acceptance Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `esc_acceptance_status` SET TAGS ('pii_value_regex' = 'accepted|rejected|pending|partial');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `esc_submission_date` SET TAGS ('pii_business_glossary_term' = 'Evidence of Standards Compliance (ESC) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `esc_submission_due_date` SET TAGS ('pii_business_glossary_term' = 'Evidence of Standards Compliance (ESC) Submission Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_immediate_threat` SET TAGS ('pii_business_glossary_term' = 'Findings Count — Immediate Threat to Health or Safety');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_business_glossary_term' = 'Findings Count — Observation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_requirement_improvement` SET TAGS ('pii_business_glossary_term' = 'Findings Count — Requirement for Improvement (RFI)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_total` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `follow_up_survey_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `follow_up_survey_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Survey Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `infection_prevention_included` SET TAGS ('pii_business_glossary_term' = 'Infection Prevention and Control Module Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `is_unannounced` SET TAGS ('pii_business_glossary_term' = 'Unannounced Survey Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Surveyor Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `life_safety_module_included` SET TAGS ('pii_business_glossary_term' = 'Life Safety Module Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `national_patient_safety_goals_reviewed` SET TAGS ('pii_business_glossary_term' = 'National Patient Safety Goals (NPSG) Reviewed Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `national_patient_safety_goals_reviewed` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `national_patient_safety_goals_reviewed` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `next_survey_target_date` SET TAGS ('pii_business_glossary_term' = 'Next Survey Target Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Survey Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `overall_readiness_score` SET TAGS ('pii_business_glossary_term' = 'Overall Readiness Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `preliminary_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Preliminary Findings Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `standards_chapters_reviewed` SET TAGS ('pii_business_glossary_term' = 'Standards Chapters Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_duration_days` SET TAGS ('pii_business_glossary_term' = 'Survey Duration (Days)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_end_date` SET TAGS ('pii_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_number` SET TAGS ('pii_business_glossary_term' = 'Survey Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_report_received_date` SET TAGS ('pii_business_glossary_term' = 'Survey Report Received Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_scope` SET TAGS ('pii_business_glossary_term' = 'Survey Scope');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_start_date` SET TAGS ('pii_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_status` SET TAGS ('pii_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|cancelled|pending_decision');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'triennial|unannounced|for_cause|validation|mock|readiness_tracer');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `surveyor_team_composition` SET TAGS ('pii_business_glossary_term' = 'Surveyor Team Composition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `system_tracer_topics` SET TAGS ('pii_business_glossary_term' = 'System Tracer Topics');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `system_tracer_topics` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `system_tracer_topics` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `tjc_organization_code` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `tracer_methodology_used` SET TAGS ('pii_business_glossary_term' = 'Tracer Methodology Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `tracer_methodology_used` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `tracer_methodology_used` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_subdomain' = 'accreditation_compliance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_accreditation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_finding' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_deficiency' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_finding_id` SET TAGS ('pii_business_glossary_term' = 'Standard Finding ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Survey ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `interface_downtime_id` SET TAGS ('pii_business_glossary_term' = 'Interface Downtime Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `prior_finding_standard_finding_id` SET TAGS ('pii_business_glossary_term' = 'Prior Finding ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `affected_department` SET TAGS ('pii_business_glossary_term' = 'Affected Department');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `cms_acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `cms_acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Acceptance Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `cms_acceptance_status` SET TAGS ('pii_value_regex' = 'Pending|Accepted|Rejected|Partially Accepted|Not Applicable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number (CCN)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `compliance_due_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `corrective_action_owner` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `deficiency_tag_number` SET TAGS ('pii_business_glossary_term' = 'Deficiency Tag Number (F-Tag / K-Tag)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `effectiveness_verified` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `element_of_performance` SET TAGS ('pii_business_glossary_term' = 'Element of Performance (EP)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `enforcement_action` SET TAGS ('pii_business_glossary_term' = 'Enforcement Action');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `enforcement_action` SET TAGS ('pii_value_regex' = 'None|Civil Monetary Penalty|Denial of Payment|Temporary Management|Termination|State Monitor');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `evidence_of_deficiency` SET TAGS ('pii_business_glossary_term' = 'Evidence of Deficiency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_date` SET TAGS ('pii_business_glossary_term' = 'Finding Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_number` SET TAGS ('pii_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_value_regex' = 'Open|In Progress|Submitted|Accepted|Rejected|Closed');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `finding_type` SET TAGS ('pii_value_regex' = 'Requirement for Improvement|Immediate Threat to Life|Condition-Level Deficiency|Standard-Level Deficiency|Observation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `immediate_jeopardy` SET TAGS ('pii_business_glossary_term' = 'Immediate Jeopardy (IJ) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'Daily|Weekly|Monthly|Quarterly|Annually|Ad Hoc');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `monitoring_method` SET TAGS ('pii_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `plan_of_correction` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (POC)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `poc_due_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (POC) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `poc_submission_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction (POC) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `repeat_finding` SET TAGS ('pii_business_glossary_term' = 'Repeat Finding Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `revisit_date` SET TAGS ('pii_business_glossary_term' = 'Revisit Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `revisit_required` SET TAGS ('pii_business_glossary_term' = 'Revisit Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `root_cause_summary` SET TAGS ('pii_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `scope_code` SET TAGS ('pii_business_glossary_term' = 'Deficiency Scope Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `scope_code` SET TAGS ('pii_value_regex' = 'Isolated|Pattern|Widespread');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `scope_severity_grid` SET TAGS ('pii_business_glossary_term' = 'Scope-Severity Grid Rating');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `severity_code` SET TAGS ('pii_business_glossary_term' = 'Deficiency Severity Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `severity_code` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_chapter` SET TAGS ('pii_business_glossary_term' = 'Standard Chapter');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_reference_code` SET TAGS ('pii_business_glossary_term' = 'Standard Reference Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `standard_reference_description` SET TAGS ('pii_business_glossary_term' = 'Standard Reference Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `survey_end_date` SET TAGS ('pii_business_glossary_term' = 'Survey End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `survey_start_date` SET TAGS ('pii_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `survey_type` SET TAGS ('pii_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `survey_type` SET TAGS ('pii_value_regex' = 'TJC Accreditation|CMS CoP|State Survey|Internal Readiness|CMS Validation|Complaint Investigation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `surveying_body` SET TAGS ('pii_business_glossary_term' = 'Surveying Body');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `tjc_npsg_number` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) National Patient Safety Goal (NPSG) Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_quality_improvement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_performance_improvement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_pdsa' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Improvement Initiative ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `capital_project_id` SET TAGS ('pii_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiative Sponsor ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `readmission_id` SET TAGS ('pii_business_glossary_term' = 'Readmission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_business_glossary_term' = 'Aim Statement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `baseline_period_end` SET TAGS ('pii_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `baseline_period_start` SET TAGS ('pii_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Performance Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `cms_submission_date` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `cms_submission_status` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `cms_submission_status` SET TAGS ('pii_value_regex' = 'not_required|pending|submitted|accepted|rejected');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `corrective_action_plan` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `current_performance_date` SET TAGS ('pii_business_glossary_term' = 'Current Performance Measurement Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `current_performance_value` SET TAGS ('pii_business_glossary_term' = 'Current Performance Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `current_phase` SET TAGS ('pii_business_glossary_term' = 'Current Initiative Phase');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `current_phase` SET TAGS ('pii_value_regex' = 'plan|do|study|act|sustain|closed');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `department_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `department_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `goal_value` SET TAGS ('pii_business_glossary_term' = 'Goal Performance Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `hai_event_type` SET TAGS ('pii_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `hai_event_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `improvement_methodology` SET TAGS ('pii_business_glossary_term' = 'Improvement Methodology');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_business_glossary_term' = 'Improvement Initiative Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_number` SET TAGS ('pii_business_glossary_term' = 'Quality Improvement (QI) Initiative Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_number` SET TAGS ('pii_value_regex' = '^QI-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_status` SET TAGS ('pii_business_glossary_term' = 'Improvement Initiative Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_status` SET TAGS ('pii_value_regex' = 'draft|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_type` SET TAGS ('pii_business_glossary_term' = 'Improvement Initiative Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_type` SET TAGS ('pii_value_regex' = 'patient_safety|clinical_quality|operational_efficiency|regulatory_compliance|patient_experience|workforce_development');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `is_cms_reportable` SET TAGS ('pii_business_glossary_term' = 'CMS Reportable Initiative Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `is_sentinel_event_related` SET TAGS ('pii_business_glossary_term' = 'Sentinel Event Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `is_tjc_reportable` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Reportable Initiative Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `pdsa_cycle_count` SET TAGS ('pii_business_glossary_term' = 'Plan-Do-Study-Act (PDSA) Cycle Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Initiative Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_business_glossary_term' = 'Problem Statement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `service_line` SET TAGS ('pii_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `source_system_initiative_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Initiative ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Initiative Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sustainability_plan` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `team_members` SET TAGS ('pii_business_glossary_term' = 'Initiative Team Members');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `team_members` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `team_members` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_peer_review' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_clinical_review' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Peer Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `radiology_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Peer Review ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `demographics_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `investigation_id` SET TAGS ('pii_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'Or Suite Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Original Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Reviewed Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `report_addendum_id` SET TAGS ('pii_business_glossary_term' = 'Addendum Report ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Review Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `udi_record_id` SET TAGS ('pii_business_glossary_term' = 'Udi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `visit_provider_id` SET TAGS ('pii_business_glossary_term' = 'Visit Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `acr_accreditation_cycle` SET TAGS ('pii_business_glossary_term' = 'ACR Accreditation Cycle');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `acr_accreditation_cycle` SET TAGS ('pii_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `acr_accreditation_cycle` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `acr_radpeer_score` SET TAGS ('pii_business_glossary_term' = 'ACR RADPEER Concordance Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_completion_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Action Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_completion_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_description` SET TAGS ('pii_business_glossary_term' = 'Peer Review Action Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_due_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_due_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_taken` SET TAGS ('pii_business_glossary_term' = 'Peer Review Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `action_taken` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `appeal_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Appeal Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `appeal_resolution_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Peer Review Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'not_appealed|appeal_pending|appeal_upheld|appeal_overturned');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `appeal_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `blinded_review_flag` SET TAGS ('pii_business_glossary_term' = 'Blinded Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_determination` SET TAGS ('pii_business_glossary_term' = 'Care Appropriateness Determination');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_determination` SET TAGS ('pii_value_regex' = 'appropriate|appropriate_with_suggestions|not_appropriate|unable_to_determine');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_determination` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_event_date` SET TAGS ('pii_business_glossary_term' = 'Care Event Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_event_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_conference_flag` SET TAGS ('pii_business_glossary_term' = 'Case Conference Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Peer Review Case Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_open_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Case Open Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_open_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_status` SET TAGS ('pii_business_glossary_term' = 'Peer Review Case Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_status` SET TAGS ('pii_value_regex' = 'open|in_review|pending_committee|closed|appealed|deferred');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_summary` SET TAGS ('pii_business_glossary_term' = 'Peer Review Case Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `case_summary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical History Available Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `committee_review_date` SET TAGS ('pii_business_glossary_term' = 'Committee Review Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `committee_review_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `confidentiality_protection_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Confidentiality Protection Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `confidentiality_protection_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `discrepancy_category` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `discrepancy_category` SET TAGS ('pii_value_regex' = 'none|minor|major');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `discrepancy_description` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `discrepancy_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `discrepancy_type` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `discrepancy_type` SET TAGS ('pii_value_regex' = 'missed_finding|mischaracterization|incorrect_recommendation|incomplete_report|wrong_anatomy');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `educational_feedback_flag` SET TAGS ('pii_business_glossary_term' = 'Educational Feedback Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `educational_opportunity_description` SET TAGS ('pii_business_glossary_term' = 'Educational Opportunity Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `educational_opportunity_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `educational_opportunity_flag` SET TAGS ('pii_business_glossary_term' = 'Educational Opportunity Identified Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `educational_opportunity_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `escalated_to_chair_flag` SET TAGS ('pii_business_glossary_term' = 'Escalated to Department Chair Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `external_reviewer_organization` SET TAGS ('pii_business_glossary_term' = 'External Reviewer Organization');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `external_reviewer_organization` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `fppe_trigger_flag` SET TAGS ('pii_business_glossary_term' = 'Focused Professional Practice Evaluation (FPPE) Trigger Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `fppe_trigger_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `icd10_finding_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Finding Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `icd10_finding_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `icd10_finding_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `icd10_finding_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `modality_code` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `npdb_report_date` SET TAGS ('pii_business_glossary_term' = 'National Practitioner Data Bank (NPDB) Report Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `npdb_report_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `npdb_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'National Practitioner Data Bank (NPDB) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `npdb_reportable_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `oppe_cycle` SET TAGS ('pii_business_glossary_term' = 'Ongoing Professional Practice Evaluation (OPPE) Cycle');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `oppe_cycle` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `oppe_fppe_flag` SET TAGS ('pii_business_glossary_term' = 'Ongoing/Focused Professional Practice Evaluation (OPPE/FPPE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Original Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_radiologist_response` SET TAGS ('pii_business_glossary_term' = 'Original Radiologist Response');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_radiologist_response` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `original_report_finalized_datetime` SET TAGS ('pii_business_glossary_term' = 'Original Report Finalized Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_outcome` SET TAGS ('pii_business_glossary_term' = 'Patient Outcome');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_outcome` SET TAGS ('pii_value_regex' = 'death|permanent_harm|temporary_harm|no_harm|unknown');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_outcome` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_outcome` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_outcome` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_outcome` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `prior_study_available_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Study Available Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `privileging_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Privileging Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `privileging_impact_flag` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `protection_statute_reference` SET TAGS ('pii_business_glossary_term' = 'Peer Review Protection Statute Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `protection_statute_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reconciliation_source` SET TAGS ('pii_sensitivity' = 'internal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reconciliation_source` SET TAGS ('pii_ssot' = 'reconciled');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `response_datetime` SET TAGS ('pii_business_glossary_term' = 'Original Radiologist Response Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_assigned_datetime` SET TAGS ('pii_business_glossary_term' = 'Peer Review Assigned Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_completion_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_datetime` SET TAGS ('pii_business_glossary_term' = 'Peer Review Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_disposition` SET TAGS ('pii_business_glossary_term' = 'Peer Review Disposition');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_disposition` SET TAGS ('pii_value_regex' = 'no_action|feedback_provided|addendum_required|report_amended|escalated|referred_to_committee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_due_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_level` SET TAGS ('pii_business_glossary_term' = 'Peer Review Level');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_level` SET TAGS ('pii_value_regex' = 'department|committee|external|appellate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_level` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_program_type` SET TAGS ('pii_business_glossary_term' = 'Peer Review Program Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_program_type` SET TAGS ('pii_value_regex' = 'acr_radpeer|internal_qa|mips|vbp|tjc_required|focused_professional_practice_evaluation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Peer Review Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'oppe|fppe|sentinel_event|focused|routine|complaint_driven');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `review_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_findings` SET TAGS ('pii_business_glossary_term' = 'Reviewer Clinical Findings');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_findings` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Reviewed Provider Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_business_glossary_term' = 'SSOT Canonical Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'SSOT Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `study_datetime` SET TAGS ('pii_business_glossary_term' = 'Imaging Study Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `subspecialty` SET TAGS ('pii_business_glossary_term' = 'Radiology Subspecialty');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `subspecialty_matched_flag` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Matched Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `trigger_description` SET TAGS ('pii_business_glossary_term' = 'Peer Review Trigger Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `trigger_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `trigger_type` SET TAGS ('pii_business_glossary_term' = 'Peer Review Trigger Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `trigger_type` SET TAGS ('pii_value_regex' = 'mortality|complication|complaint|focused_review|oppe|fppe');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `trigger_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_care_gap' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_population_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_business_glossary_term' = 'Population Health Gap ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `care_program_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Care Program Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Attributed Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Closure Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `follow_up_id` SET TAGS ('pii_business_glossary_term' = 'Follow Up Recommendation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'Hedis Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `pcp_attribution_id` SET TAGS ('pii_business_glossary_term' = 'Pcp Attribution Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_quality_measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Population Health Program ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Closure Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `care_gap_description` SET TAGS ('pii_business_glossary_term' = 'Care Gap Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_note` SET TAGS ('pii_business_glossary_term' = 'Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_note` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_note` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Care Gap Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `closure_method` SET TAGS ('pii_business_glossary_term' = 'Care Gap Closure Method');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `closure_method` SET TAGS ('pii_value_regex' = 'claim|clinical_documentation|patient_attestation|lab_result|immunization_registry|care_plan');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Gap Data Source');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `data_source` SET TAGS ('pii_value_regex' = 'ehr_clinical|claims|lab_feed|immunization_registry|patient_attestation|care_plan');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Care Gap Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_business_glossary_term' = 'Denominator Exclusion Reason');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `exclusion_reason` SET TAGS ('pii_value_regex' = 'medical_exclusion|patient_declined|hospice|deceased|moved_out_of_area|not_eligible');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_category` SET TAGS ('pii_business_glossary_term' = 'Care Gap Clinical Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_category` SET TAGS ('pii_value_regex' = 'screening|immunization|monitoring|medication|counseling|follow_up');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_number` SET TAGS ('pii_business_glossary_term' = 'Care Gap Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_status` SET TAGS ('pii_business_glossary_term' = 'Care Gap Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_status` SET TAGS ('pii_value_regex' = 'open|closed|excluded|in_progress|voided');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_type` SET TAGS ('pii_business_glossary_term' = 'Care Gap Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_type` SET TAGS ('pii_value_regex' = 'preventive_care|chronic_disease_management|hedis_measure|medication_adherence|behavioral_health|other');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Gap Identified Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `is_denominator_eligible` SET TAGS ('pii_business_glossary_term' = 'Denominator Eligibility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `is_numerator_compliant` SET TAGS ('pii_business_glossary_term' = 'Numerator Compliance Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `last_outreach_channel` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Channel');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `last_outreach_channel` SET TAGS ('pii_value_regex' = 'phone|letter|portal_message|care_coordinator|telehealth|sms');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `last_outreach_date` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `measurement_year` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `outreach_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `outreach_response_status` SET TAGS ('pii_business_glossary_term' = 'Outreach Response Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `outreach_response_status` SET TAGS ('pii_value_regex' = 'no_response|patient_engaged|appointment_scheduled|declined|unreachable');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Care Gap Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `reporting_program` SET TAGS ('pii_business_glossary_term' = 'Quality Reporting Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Patient Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `risk_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `scheduled_appointment_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `snomed_code` SET TAGS ('pii_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `snomed_code` SET TAGS ('pii_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `snomed_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `source_gap_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Gap ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_sdoh' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_social_determinants' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_screening' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sdoh Screening Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_screening_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Administering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Referral Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_need_closure_id` SET TAGS ('pii_business_glossary_term' = 'SDOH Need Closure Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_referral_id` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_risk_stratification_id` SET TAGS ('pii_business_glossary_term' = 'SDOH Risk Stratification Reference');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_zcode_mapping_id` SET TAGS ('pii_business_glossary_term' = 'SDOH Z-Code Mapping ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `administration_mode` SET TAGS ('pii_business_glossary_term' = 'Screening Administration Mode');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `community_resource_connected` SET TAGS ('pii_business_glossary_term' = 'Community Resource Connected Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_equity_stratifier` SET TAGS ('pii_business_glossary_term' = 'Health Equity Stratifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_equity_stratifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_equity_stratifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_equity_stratifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `health_equity_stratifier` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `interpreter_used` SET TAGS ('pii_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_denominator_eligible` SET TAGS ('pii_business_glossary_term' = 'Denominator Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_numerator_compliant` SET TAGS ('pii_business_glossary_term' = 'Numerator Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_positive_screen` SET TAGS ('pii_business_glossary_term' = 'Positive SDOH Screen Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_positive_screen` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_positive_screen` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_referral_generated` SET TAGS ('pii_business_glossary_term' = 'Referral Generated Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `is_referral_generated` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `language_of_administration` SET TAGS ('pii_business_glossary_term' = 'Language of Administration');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `need_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Social Need Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `need_resolved` SET TAGS ('pii_business_glossary_term' = 'Social Need Resolved Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `positive_screen_reason` SET TAGS ('pii_business_glossary_term' = 'Positive Screen Reason');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `positive_screen_reason` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `positive_screen_reason` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `program_year` SET TAGS ('pii_business_glossary_term' = 'Quality Program Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `question_text` SET TAGS ('pii_business_glossary_term' = 'Screening Question Text');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `referral_type` SET TAGS ('pii_business_glossary_term' = 'SDOH Referral Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `referral_type` SET TAGS ('pii_value_regex' = 'community_resource|social_work|care_management|food_bank|housing_agency|other');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `refusal_reason` SET TAGS ('pii_business_glossary_term' = 'Screening Refusal Reason');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `refusal_reason` SET TAGS ('pii_value_regex' = 'patient_declined|language_barrier|cognitive_impairment|time_constraint|not_applicable|other');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `resource_connection_date` SET TAGS ('pii_business_glossary_term' = 'Resource Connection Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `response_code` SET TAGS ('pii_business_glossary_term' = 'Screening Response Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `response_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `response_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `response_value` SET TAGS ('pii_business_glossary_term' = 'Screening Response Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `response_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `response_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_date` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_number` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_business_glossary_term' = 'Screening Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency_department|telehealth|community');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_status` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_status` SET TAGS ('pii_value_regex' = 'completed|in_progress|refused|not_eligible|voided');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_code` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Tool Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_code` SET TAGS ('pii_value_regex' = 'AHC_HRSN|PRAPARE|HUNGER_VITAL_SIGN|WELLCARE|ISCREEN|WE_CARE');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Tool Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_tool_version` SET TAGS ('pii_business_glossary_term' = 'SDOH Screening Tool Version');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_domain` SET TAGS ('pii_business_glossary_term' = 'Social Determinants of Health (SDOH) Domain');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_domain` SET TAGS ('pii_value_regex' = 'food_insecurity|housing_instability|transportation|interpersonal_safety|financial_strain');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `sdoh_domain` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `source_system_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_subdomain' = 'accreditation_compliance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_corrective_action' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_improvement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `capital_expenditure_id` SET TAGS ('pii_business_glossary_term' = 'Capital Expenditure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `improvement_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Quality Improvement Initiative Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `interface_downtime_id` SET TAGS ('pii_business_glossary_term' = 'Interface Downtime Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `mortality_review_id` SET TAGS ('pii_business_glossary_term' = 'Mortality Review Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `mortality_review_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `parent_corrective_action_id` SET TAGS ('pii_business_glossary_term' = 'Parent Corrective Action Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `parent_corrective_action_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Peer Review Case Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `recall_notice_id` SET TAGS ('pii_business_glossary_term' = 'Recall Notice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `standard_finding_id` SET TAGS ('pii_business_glossary_term' = 'Standard Finding Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `acceptance_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Acceptance Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `acceptance_status` SET TAGS ('pii_value_regex' = 'pending|accepted|rejected|revision_requested');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('pii_value_regex' = 'open|in_progress|completed|verified|closed|overdue');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('pii_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('pii_value_regex' = 'corrective|preventive|both');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Action Assigned Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `days_to_complete` SET TAGS ('pii_business_glossary_term' = 'Days to Complete Action');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `department_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `department_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_verified` SET TAGS ('pii_business_glossary_term' = 'Effectiveness Verified Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `is_cms_reportable` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reportable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `is_overdue` SET TAGS ('pii_business_glossary_term' = 'Action Overdue Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_business_glossary_term' = 'State Regulatory Agency Reportable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `is_tjc_reportable` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Reportable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `monitoring_method` SET TAGS ('pii_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `originating_event_type` SET TAGS ('pii_business_glossary_term' = 'Originating Event Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Action Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `regulatory_program` SET TAGS ('pii_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_role` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Role');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `root_cause_summary` SET TAGS ('pii_business_glossary_term' = 'Root Cause Analysis Summary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `service_line` SET TAGS ('pii_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `source_system_action_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Action Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('pii_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_result` SET TAGS ('pii_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `verification_result` SET TAGS ('pii_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_association_edges' = 'quality.quality_program,quality.measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_quality_program' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_measure_assignment' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `program_measure_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Program Measure Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `program_quality_measure_id` SET TAGS ('pii_business_glossary_term' = 'Program Measure Assignment - Quality Measure Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Program Measure Assignment - Quality Program Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `achievement_threshold` SET TAGS ('pii_business_glossary_term' = 'Achievement Threshold');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `assigned_by` SET TAGS ('pii_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `improvement_threshold` SET TAGS ('pii_business_glossary_term' = 'Improvement Threshold');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory Measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_domain_assignment` SET TAGS ('pii_business_glossary_term' = 'Measure Domain Assignment');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_inclusion_end_date` SET TAGS ('pii_business_glossary_term' = 'Measure Inclusion End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_inclusion_start_date` SET TAGS ('pii_business_glossary_term' = 'Measure Inclusion Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_points_available` SET TAGS ('pii_business_glossary_term' = 'Measure Points Available');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Measure Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_status_in_program` SET TAGS ('pii_business_glossary_term' = 'Measure Status in Program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `measure_weight` SET TAGS ('pii_business_glossary_term' = 'Measure Weight');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_association_edges' = 'quality.improvement_initiative,quality.measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_quality_improvement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_target' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_goal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `initiative_measure_target_id` SET TAGS ('pii_business_glossary_term' = 'Initiative Measure Target ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `improvement_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Initiative Measure Target - Improvement Initiative Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `initiative_quality_measure_id` SET TAGS ('pii_business_glossary_term' = 'Initiative Measure Target - Quality Measure Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `baseline_period_end` SET TAGS ('pii_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `baseline_period_start` SET TAGS ('pii_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Performance Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `current_performance_date` SET TAGS ('pii_business_glossary_term' = 'Current Performance Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `current_performance_value` SET TAGS ('pii_business_glossary_term' = 'Current Performance Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `goal_value` SET TAGS ('pii_business_glossary_term' = 'Goal Performance Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `is_primary_measure` SET TAGS ('pii_business_glossary_term' = 'Is Primary Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measure_role_in_initiative` SET TAGS ('pii_business_glossary_term' = 'Measure Role in Initiative');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measure_unit` SET TAGS ('pii_business_glossary_term' = 'Measure Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measurement_end_date` SET TAGS ('pii_business_glossary_term' = 'Measurement End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `measurement_start_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `target_status` SET TAGS ('pii_business_glossary_term' = 'Target Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_association_edges' = 'quality.improvement_initiative,insurance.payer_contract');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_vbc' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_contract' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Contract Initiative Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_last_updated_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Updated By Employee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_last_updated_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_last_updated_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `improvement_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Contract Initiative - Improvement Initiative Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `payer_contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract Initiative - Payer Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_initiative_status` SET TAGS ('pii_business_glossary_term' = 'Contract Initiative Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `contract_measure_code` SET TAGS ('pii_business_glossary_term' = 'Contract Measure Code');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Contract Initiative End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Contract Incentive Amount');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `incentive_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `incentive_earned_to_date` SET TAGS ('pii_business_glossary_term' = 'Incentive Earned To Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `incentive_earned_to_date` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Initiative Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `last_reported_date` SET TAGS ('pii_business_glossary_term' = 'Last Reported Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `next_reporting_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Reporting Due Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Contract Penalty Amount');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `penalty_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `penalty_incurred_to_date` SET TAGS ('pii_business_glossary_term' = 'Penalty Incurred To Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `penalty_incurred_to_date` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `performance_target` SET TAGS ('pii_business_glossary_term' = 'Contract Performance Target');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Contract Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Contract Initiative Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_association_edges' = 'quality.quality_program,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_research' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_study' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `program_study_participation_id` SET TAGS ('pii_business_glossary_term' = 'Program Study Participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Program Study Participation - Quality Program Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `program_study_research_study_id` SET TAGS ('pii_business_glossary_term' = 'Program Study Participation - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `affected_measure_ids` SET TAGS ('pii_business_glossary_term' = 'Affected Measure Identifiers');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `cms_reporting_flag` SET TAGS ('pii_business_glossary_term' = 'CMS Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `enrollment_impact_on_measures` SET TAGS ('pii_business_glossary_term' = 'Enrollment Impact on Measures');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `measure_stratification_required` SET TAGS ('pii_business_glossary_term' = 'Measure Stratification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `program_participation_type` SET TAGS ('pii_business_glossary_term' = 'Program Participation Type');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `reporting_exclusion_rules` SET TAGS ('pii_business_glossary_term' = 'Reporting Exclusion Rules');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_association_edges' = 'quality.measure,finance.budget_line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_budget' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_finance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `measure_budget_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Measure Budget Allocation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `budget_line_id` SET TAGS ('pii_business_glossary_term' = 'Measure Budget Allocation - Budget Line Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Measure Budget Allocation - Quality Measure Id');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Budget Allocation Percentage');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `budgeted_improvement_cost` SET TAGS ('pii_business_glossary_term' = 'Budgeted Improvement Cost');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `measure_target_value` SET TAGS ('pii_business_glossary_term' = 'Measure Target Value');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `performance_incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Performance Incentive Amount');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_quality_program' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_participation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `quality_program_participation_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program Participation ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_subdomain' = 'accreditation_compliance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_committee' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `quality_committee_id` SET TAGS ('pii_business_glossary_term' = 'Committee ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_ssot_canonical' = 'provider.committee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_ssot_status' = 'consolidated_to_canonical');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_subdomain' = 'program_governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_quality_program' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_qapi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_performance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `quality_program_id` SET TAGS ('pii_business_glossary_term' = 'Quality Program ID');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_subdomain' = 'measure_reporting');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `raf_score_id` SET TAGS ('pii_business_glossary_term' = 'Raf Score Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `prior_raf_score_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `demographic_score_component` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `demographic_score_component` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `disease_score_component` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `disease_score_component` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `medicaid_dual_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `medicaid_dual_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `member_identifier` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `member_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `member_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `member_identifier` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `normalized_raf_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `normalized_raf_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `raf_gap_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `raf_gap_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `raf_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `raf_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `suspected_raf_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `suspected_raf_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `care_gap_closure_id` SET TAGS ('pii_business_glossary_term' = 'Care Gap Closure Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `member_mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `member_mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `member_mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `member_mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `reopened_care_gap_closure_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_condition` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `closure_notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `closure_notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `chw_intervention_id` SET TAGS ('pii_business_glossary_term' = 'Chw Intervention Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `intervention_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `intervention_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `intervention_notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `intervention_notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `location_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`chw_intervention` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `sdoh_risk_stratification_id` SET TAGS ('pii_business_glossary_term' = 'Sdoh Risk Stratification Identifier');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `sdoh_risk_stratification_id` SET TAGS ('pii_ssot_owner' = 'patient.sdoh_risk_stratification');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `composite_risk_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `composite_risk_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `consent_to_share_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `consent_to_share_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `economic_domain_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `economic_domain_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `education_barrier_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `education_barrier_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `employment_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `employment_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `financial_strain_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `food_insecurity_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `healthcare_access_domain_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `healthcare_access_domain_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `healthcare_access_domain_score` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `healthcare_access_domain_score` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `housing_domain_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `housing_domain_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `housing_instability_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `insurance_coverage_gap_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `insurance_coverage_gap_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `insurance_coverage_gap_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `insurance_coverage_gap_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `interpersonal_safety_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `intervention_recommendation` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `intervention_recommendation` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `patient_declined_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `patient_declined_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `primary_language` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `primary_language` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `residential_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `residential_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `residential_zip_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `residential_zip_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `screening_tool_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `social_context_domain_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `social_context_domain_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `social_isolation_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `transportation_barrier_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `transportation_barrier_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `utility_needs_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_risk_stratification` ALTER COLUMN `utility_needs_flag` SET TAGS ('pii_health' = 'true');
