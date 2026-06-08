-- Schema for Domain: behavioral_health | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health` COMMENT 'Behavioral Health domain covering psychiatric assessments, SUD episodes, MAT treatment, OTP enrollment, crisis episodes, and 42 CFR Part 2 consent workflow.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` (
    `psychiatric_assessment_id` BIGINT COMMENT 'Primary key for psychiatric_assessment',
    `mpi_record_id` BIGINT COMMENT 'The patient who is the subject of this psychiatric assessment.',
    `psychiatric_clinician_id` BIGINT COMMENT 'The clinician (psychiatrist, psychologist, LCSW, or other qualified provider) who conducted the psychiatric assessment.',
    `psychiatric_cosigning_provider_clinician_id` BIGINT COMMENT 'The supervising or attending provider who cosigned this assessment when performed by a trainee or mid-level provider requiring supervision.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which this psychiatric assessment was performed.',
    `affect_description` STRING COMMENT 'Clinicians objective observation of the patients emotional expression including range, congruence, intensity, and reactivity.',
    `amendment_reason` STRING COMMENT 'Reason for any amendment or addendum to the original signed psychiatric assessment, if applicable.',
    `assessment_datetime` TIMESTAMP COMMENT 'The date and time when the psychiatric assessment was conducted with the patient. This is the principal clinical event timestamp.',
    `assessment_number` STRING COMMENT 'Externally-visible business identifier for this psychiatric assessment, used for clinical documentation and cross-system reference.',
    `assessment_setting` STRING COMMENT 'The clinical setting or environment in which the psychiatric assessment was conducted.',
    `assessment_type` STRING COMMENT 'Classification of the psychiatric assessment indicating its clinical purpose and context.',
    `capacity_to_consent` STRING COMMENT 'Clinicians determination of the patients decisional capacity to provide informed consent for treatment at the time of assessment.',
    `chief_complaint` STRING COMMENT 'The patients primary presenting complaint or reason for the psychiatric evaluation, documented in the patients own words when possible.',
    `clinical_formulation` STRING COMMENT 'The clinicians integrative summary explaining the patients presentation through biopsychosocial factors, linking history, symptoms, and diagnosis into a coherent clinical narrative.',
    `cognitive_function_assessment` STRING COMMENT 'Summary of cognitive evaluation findings including orientation, attention, memory, language, and executive function observations.',
    `collateral_information_source` STRING COMMENT 'Sources of collateral information consulted during the assessment (e.g., family members, prior records, referring provider, law enforcement).',
    `confidentiality_restriction` STRING COMMENT 'Special confidentiality restrictions applied to this assessment record beyond standard HIPAA protections, such as 42 CFR Part 2 substance use restrictions or court-sealed records.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this psychiatric assessment record was first created in the system.',
    `current_medications_reviewed` BOOLEAN COMMENT 'Indicates whether the patients current medication list was reviewed during this assessment for psychotropic and non-psychotropic medications.',
    `dsm5_diagnostic_category` STRING COMMENT 'The broad DSM-5 diagnostic category applicable to the primary diagnosis (e.g., Depressive Disorders, Schizophrenia Spectrum, Anxiety Disorders, Substance-Related Disorders).',
    `duration_minutes` STRING COMMENT 'Total duration of the psychiatric assessment session in minutes, used for clinical documentation and billing purposes.',
    `family_psychiatric_history` STRING COMMENT 'Summary of relevant psychiatric conditions in the patients family members, contributing to diagnostic formulation and risk assessment.',
    `follow_up_plan` STRING COMMENT 'Documented plan for follow-up care including next appointment timing, referrals, and monitoring requirements.',
    `gaf_score` STRING COMMENT 'Clinician-rated score (1-100) reflecting the patients overall psychological, social, and occupational functioning at the time of assessment.',
    `history_of_present_illness` STRING COMMENT 'Narrative description of the current psychiatric symptoms, their onset, duration, severity, and progression leading to this assessment.',
    `homicidal_ideation_present` BOOLEAN COMMENT 'Indicates whether the patient endorsed any homicidal ideation or intent to harm others during this assessment.',
    `insight_level` STRING COMMENT 'Clinicians assessment of the patients awareness and understanding of their psychiatric condition and need for treatment.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a language interpreter was used during the psychiatric assessment to facilitate communication with the patient.',
    `involuntary_hold_indicated` BOOLEAN COMMENT 'Indicates whether the assessment findings meet criteria for involuntary psychiatric hold (e.g., danger to self or others, gravely disabled).',
    `judgment_level` STRING COMMENT 'Clinicians assessment of the patients capacity for sound decision-making and ability to manage daily affairs.',
    `legal_status` STRING COMMENT 'The patients legal status with respect to psychiatric treatment at the time of assessment (voluntary admission, involuntary hold, court-ordered evaluation, or conditional release).',
    `mental_status_exam` STRING COMMENT 'Structured clinical documentation of the mental status examination including appearance, behavior, speech, mood, affect, thought process, thought content, perception, cognition, insight, and judgment.',
    `mood_description` STRING COMMENT 'The patients self-reported subjective emotional state at the time of assessment (e.g., depressed, anxious, euphoric, irritable).',
    `part2_consent_obtained` BOOLEAN COMMENT 'Indicates whether specific consent under 42 CFR Part 2 was obtained for disclosure of substance use disorder information documented in this assessment.',
    `phq9_score` STRING COMMENT 'Total score on the PHQ-9 depression screening instrument (range 0-27), used to quantify depression severity.',
    `primary_diagnosis_code` STRING COMMENT 'The primary ICD-10-CM diagnosis code assigned as a result of this psychiatric assessment.',
    `psychiatric_assessment_status` STRING COMMENT 'Current state of the psychiatric assessment in its documentation workflow lifecycle.',
    `psychiatric_history_summary` STRING COMMENT 'Summary of the patients prior psychiatric diagnoses, hospitalizations, treatments, and medication trials relevant to the current assessment.',
    `psychosis_symptoms_present` BOOLEAN COMMENT 'Indicates whether the patient exhibited or reported psychotic symptoms (hallucinations, delusions, disorganized thinking) during this assessment.',
    `recommended_level_of_care` STRING COMMENT 'The clinically recommended level of behavioral health care based on assessment findings (outpatient, Intensive Outpatient Program, Partial Hospitalization Program, residential, or inpatient).',
    `safety_plan_completed` BOOLEAN COMMENT 'Indicates whether a safety plan was developed with the patient during or as a result of this assessment.',
    `secondary_diagnosis_codes` STRING COMMENT 'Comma-separated list of additional ICD-10-CM diagnosis codes identified during this assessment (comorbid conditions).',
    `signed_datetime` TIMESTAMP COMMENT 'The date and time when the assessing clinician electronically signed and finalized this psychiatric assessment documentation.',
    `substance_use_history` STRING COMMENT 'Documentation of the patients history of alcohol, tobacco, and illicit substance use including patterns, duration, and prior treatment episodes.',
    `suicidal_ideation_present` BOOLEAN COMMENT 'Indicates whether the patient endorsed any suicidal ideation during this assessment. Critical for safety planning and risk stratification.',
    `suicide_risk_level` STRING COMMENT 'Clinician-determined level of suicide risk based on structured assessment of ideation, plan, intent, means, and protective factors.',
    `trauma_history_screened` BOOLEAN COMMENT 'Indicates whether a trauma history screening was conducted as part of this psychiatric assessment.',
    `treatment_recommendation` STRING COMMENT 'Clinicians recommended treatment plan resulting from this assessment, including therapy modality, medication considerations, and level of care.',
    `updated_datetime` TIMESTAMP COMMENT 'The date and time when this psychiatric assessment record was last modified.',
    `violence_risk_level` STRING COMMENT 'Clinician-determined level of risk for violence toward others based on structured risk assessment.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient undergoing the assessment.',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the clinician who performed the assessment.',
    `assessment_date` DATE COMMENT 'Date when the assessment was conducted.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Exact date and time when the assessment was recorded.',
    `status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `completed|in_progress|cancelled|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `diagnosis_codes` STRING COMMENT 'Comma-separated list of diagnosis codes (ICD-10) assigned during the assessment.',
    `assessment_findings` STRING COMMENT 'Narrative findings and observations recorded by the clinician.',
    `treatment_recommendations` STRING COMMENT 'Recommended treatment plan or interventions resulting from the assessment.',
    `risk_level` STRING COMMENT 'Clinical risk level determined during assessment.. Valid values are `low|moderate|high|critical`',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the patient provided consent for treatment as per 42 CFR Part 2.',
    `consent_type` STRING COMMENT 'Type of consent obtained.. Valid values are `full|partial|none`',
    `substance_use_disorder_flag` BOOLEAN COMMENT 'Flag indicating presence of substance use disorder identified.',
    `medication_allergy_flag` BOOLEAN COMMENT 'Flag indicating if patient has documented medication allergies.',
    `previous_assessment_id` BIGINT COMMENT 'Reference to a prior related psychiatric assessment, if any.',
    `assessment_location` STRING COMMENT 'Physical location or facility where assessment took place.',
    `assessment_modality` STRING COMMENT 'Mode of delivery for the assessment.. Valid values are `in_person|telehealth|phone|video`',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up appointment is required.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up assessment.',
    `severity_score` STRING COMMENT 'Numeric severity score assigned by clinician (e.g., 0-10).',
    `comorbid_conditions` STRING COMMENT 'List of comorbid mental health conditions identified.',
    `assessment_duration_minutes` STRING COMMENT 'Duration of the assessment session in minutes.',
    `assessment_source` STRING COMMENT 'Source that initiated the assessment.. Valid values are `referral|self|screening|emergency`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates if patient’s insurance covers the assessment.',
    `billing_code` STRING COMMENT 'Billing code (CPT/HCPCS) associated with the assessment.',
    `notes_private` STRING COMMENT 'Additional private notes by clinician, may contain PHI.',
    `assessment_outcome` STRING COMMENT 'Overall outcome of the assessment.. Valid values are `stable|improved|deteriorated|no_change`',
    `care_plan_id` BIGINT COMMENT 'Identifier linking to a detailed care plan.',
    `is_telehealth` BOOLEAN COMMENT 'Flag indicating if assessment was conducted via telehealth.',
    `language_used` STRING COMMENT 'Language used during the assessment.',
    `patient_age_at_assessment` STRING COMMENT 'Patient age in years at time of assessment.',
    `patient_gender` STRING COMMENT 'Patient gender recorded at assessment.. Valid values are `male|female|non_binary|other|unknown`',
    `patient_race` STRING COMMENT 'Patient race/ethnicity as recorded.',
    `patient_employment_status` STRING COMMENT 'Employment status of patient at assessment.. Valid values are `employed|unemployed|student|retired|disabled|unknown`',
    `patient_income_bracket` STRING COMMENT 'Income bracket category for socioeconomic context.. Valid values are `low|middle|high|unknown`',
    `assessment_version` STRING COMMENT 'Version number of the assessment form used.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the assessment is marked confidential per patient request.',
    `data_retention_date` DATE COMMENT 'Date after which the assessment record may be archived per retention policy.',
    `audit_user_id` BIGINT COMMENT 'Identifier of the user who performed the last audit action.',
    `audit_action` STRING COMMENT 'Type of audit action performed.. Valid values are `create|update|delete|review`',
    CONSTRAINT pk_psychiatric_assessment PRIMARY KEY(`psychiatric_assessment_id`)
) COMMENT 'Table for psychiatric assessments';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` (
    `sud_episode_id` BIGINT COMMENT 'Primary key for sud_episode',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the SUD treatment is being delivered.',
    `clinician_id` BIGINT COMMENT 'Reference to the primary clinician or counselor responsible for the SUD treatment episode.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient receiving substance use disorder treatment.',
    `org_provider_id` BIGINT COMMENT 'Reference to the entity or provider that referred the patient into SUD treatment.',
    `visit_id` BIGINT COMMENT 'Reference to the initial clinical encounter that opened this SUD episode.',
    `abstinence_days_at_discharge` STRING COMMENT 'Number of consecutive days of abstinence from the primary substance at the time of discharge.',
    `actual_length_of_stay_days` STRING COMMENT 'Actual number of days from admission to discharge. Null if episode is still active.',
    `admission_date` DATE COMMENT 'Date the patient was formally admitted into the substance use disorder treatment episode.',
    `age_at_first_use` STRING COMMENT 'Patient-reported age in years when they first used the primary substance. Used for chronicity assessment.',
    `asam_level_of_care` STRING COMMENT 'ASAM criteria level of care placement recommendation or actual placement (0.5=Early Intervention through 4.0=Medically Managed Intensive Inpatient). [ENUM-REF-CANDIDATE: 0.5|1.0|2.1|2.5|3.1|3.3|3.5|3.7|4.0 — promote to reference product]',
    `authorization_number` STRING COMMENT 'Prior authorization or pre-certification number from the payer authorizing the SUD treatment episode.',
    `cfr42_consent_date` DATE COMMENT 'Date the patient provided or revoked consent under 42 CFR Part 2 for disclosure of SUD treatment records.',
    `cfr42_consent_status` STRING COMMENT 'Status of patient consent under 42 CFR Part 2 regulations governing confidentiality of substance use disorder patient records.',
    `co_occurring_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code for the co-occurring mental health condition, if present.',
    `co_occurring_mental_health_indicator` BOOLEAN COMMENT 'Indicates whether the patient has a co-occurring mental health diagnosis alongside the substance use disorder (dual diagnosis).',
    `confidentiality_flag` BOOLEAN COMMENT 'Flag indicating this record is subject to heightened confidentiality protections under 42 CFR Part 2 and must not be disclosed without specific patient consent.',
    `crisis_episode_indicator` BOOLEAN COMMENT 'Indicates whether this episode was initiated due to a behavioral health crisis (e.g., overdose, acute intoxication, suicidal ideation with substance use).',
    `discharge_date` DATE COMMENT 'Date the patient was discharged from the substance use disorder treatment episode. Null if episode is still active.',
    `discharge_disposition` STRING COMMENT 'Where the patient went or their living situation upon discharge from the SUD treatment episode.',
    `discharge_reason` STRING COMMENT 'Reason for discharge from the SUD treatment episode. AMA indicates Against Medical Advice.',
    `dsm5_diagnosis_code` STRING COMMENT 'ICD-10-CM code corresponding to the DSM-5 substance use disorder diagnosis (F10-F19 range).',
    `episode_number` STRING COMMENT 'Business-facing unique episode number assigned at intake, used for external communication and claims submission.',
    `episode_status` STRING COMMENT 'Current lifecycle status of the substance use disorder treatment episode.',
    `episode_type` STRING COMMENT 'Classification of the episode indicating whether it is an initial admission, readmission after relapse, transfer from another program, or continuation of prior treatment.',
    `expected_length_of_stay_days` STRING COMMENT 'Projected duration of the treatment episode in days based on ASAM level of care and clinical assessment.',
    `frequency_of_use` STRING COMMENT 'Self-reported frequency of primary substance use at the time of admission to treatment.',
    `iv_drug_use_indicator` BOOLEAN COMMENT 'Indicates whether the patient has a history of intravenous drug use, relevant for infectious disease screening and harm reduction planning.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent clinical assessment or treatment plan review during the episode.',
    `legal_status` STRING COMMENT 'Legal circumstances under which the patient entered treatment, including court-mandated or criminal justice involvement.',
    `mat_indicator` BOOLEAN COMMENT 'Indicates whether the patient is receiving medication-assisted treatment (e.g., buprenorphine, methadone, naltrexone) as part of this episode.',
    `mat_medication` STRING COMMENT 'Specific medication used for medication-assisted treatment if MAT is part of the treatment plan.',
    `narcan_administered_indicator` BOOLEAN COMMENT 'Indicates whether naloxone was administered to reverse an opioid overdose in connection with this episode.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next treatment plan review or continued stay review.',
    `otp_enrollment_indicator` BOOLEAN COMMENT 'Indicates whether the patient is enrolled in a federally certified Opioid Treatment Program for methadone or buprenorphine dispensing.',
    `outcome_at_discharge` STRING COMMENT 'Clinician-assessed outcome of the patient at the time of discharge from the SUD treatment episode.',
    `overdose_history_indicator` BOOLEAN COMMENT 'Indicates whether the patient has a documented history of substance overdose prior to or during this episode.',
    `pregnancy_indicator` BOOLEAN COMMENT 'Indicates whether the patient was pregnant at the time of admission. Critical for treatment planning and medication safety.',
    `primary_payer_type` STRING COMMENT 'Primary source of payment for the SUD treatment episode.',
    `primary_route_of_administration` STRING COMMENT 'The primary method by which the patient administers the primary substance of use.',
    `primary_substance` STRING COMMENT 'The primary substance for which the patient is seeking treatment, coded per SAMHSA substance categories (e.g., alcohol, opioids, cocaine, methamphetamine, cannabis). [ENUM-REF-CANDIDATE: alcohol|heroin|rx_opioids|cocaine|methamphetamine|cannabis|benzodiazepines|other — promote to reference product]',
    `prior_treatment_episodes_count` STRING COMMENT 'Number of prior substance use disorder treatment episodes the patient has had, used for relapse risk assessment and treatment planning.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SUD episode record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SUD episode record was last modified.',
    `referral_source_type` STRING COMMENT 'Category of the entity that referred the patient to SUD treatment (e.g., self-referral, court/criminal justice, healthcare provider, employer).',
    `secondary_substance` STRING COMMENT 'Secondary substance the patient reports using, if applicable. Coded per SAMHSA substance categories.',
    `severity_level` STRING COMMENT 'DSM-5 severity classification of the substance use disorder based on number of diagnostic criteria met (mild: 2-3, moderate: 4-5, severe: 6+).',
    `tertiary_substance` STRING COMMENT 'Third substance the patient reports using, if applicable. Coded per SAMHSA substance categories.',
    `treatment_modality` STRING COMMENT 'Primary therapeutic modality employed during the episode. MAT refers to Medication-Assisted Treatment. [ENUM-REF-CANDIDATE: individual_therapy|group_therapy|family_therapy|mat|detoxification|peer_support|cbt|dbt|contingency_management|12_step — promote to reference product]',
    `treatment_plan_goal` STRING COMMENT 'Primary treatment goal established in the individualized treatment plan (e.g., abstinence, harm reduction, stabilization).',
    `treatment_setting` STRING COMMENT 'The physical or programmatic setting in which SUD treatment is delivered. OTP refers to Opioid Treatment Program.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient receiving SUD treatment.',
    `start_date` DATE COMMENT 'Date when the SUD treatment episode began.',
    `end_date` DATE COMMENT 'Date when the SUD treatment episode concluded or was terminated.',
    `status` STRING COMMENT 'Current lifecycle status of the episode.. Valid values are `active|completed|terminated|paused|withdrawn`',
    `secondary_substances` STRING COMMENT 'Comma-separated list of additional substances of abuse identified.',
    `treatment_plan_id` BIGINT COMMENT 'Reference to the care plan associated with this episode.',
    `primary_care_provider_id` BIGINT COMMENT 'Provider responsible for overseeing the episode.',
    `medication_assisted_treatment_flag` BOOLEAN COMMENT 'Indicates if medication‑assisted treatment (MAT) was part of the episode.',
    `mat_start_date` DATE COMMENT 'Date MAT medication was initiated.',
    `mat_end_date` DATE COMMENT 'Date MAT medication was discontinued.',
    `relapse_flag` BOOLEAN COMMENT 'Indicates whether the patient experienced a relapse during the episode.',
    `relapse_date` DATE COMMENT 'Date of documented relapse event.',
    `outcome_score` STRING COMMENT 'Clinician‑assigned outcome score (1‑5) for the episode.',
    `notes` STRING COMMENT 'Free‑text clinical notes for the episode.',
    `consent_id` BIGINT COMMENT 'Reference to the 42 CFR Part 2 consent record linked to this episode.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was created.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the episode record.',
    `insurance_payer_id` BIGINT COMMENT 'Payer responsible for coverage during the episode.',
    `claim_id` BIGINT COMMENT 'Associated claim identifier for billing this episode.',
    `location_id` BIGINT COMMENT 'Facility or location where the episode was primarily delivered.',
    `program_enrollment_flag` BOOLEAN COMMENT 'Indicates enrollment in a specific SUD program (e.g., intensive outpatient).',
    `program_type` STRING COMMENT 'Type of SUD treatment program for the episode.. Valid values are `outpatient|inpatient|intensive_outpatient|residential`',
    `total_visits` STRING COMMENT 'Total number of clinical visits within the episode.',
    `total_days_of_care` STRING COMMENT 'Total days of care delivered in the episode.',
    `urine_drug_screen_flag` BOOLEAN COMMENT 'Indicates if urine drug screening was performed.',
    `urine_drug_screen_result` STRING COMMENT 'Result of the most recent urine drug screen.',
    `risk_assessment_score` STRING COMMENT 'Risk assessment score at episode start.',
    `patient_mrn` STRING COMMENT 'Medical Record Number of the patient.',
    `patient_dob` DATE COMMENT 'Date of birth of the patient.',
    `patient_gender` STRING COMMENT 'Self‑identified gender of the patient.. Valid values are `male|female|other|unknown`',
    `patient_race` STRING COMMENT 'Self‑reported race of the patient.',
    `patient_ethnicity` STRING COMMENT 'Self‑reported ethnicity of the patient.',
    CONSTRAINT pk_sud_episode PRIMARY KEY(`sud_episode_id`)
) COMMENT 'Table for substance use disorder episodes';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` (
    `mat_treatment_id` BIGINT COMMENT 'Primary key for mat_treatment',
    `care_program_id` BIGINT COMMENT 'Identifier of the opioid treatment program (OTP) or office-based opioid treatment (OBOT) program administering the MAT.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or OTP clinic where the MAT is being administered.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider authorized to prescribe MAT medications (must hold DATA 2000 waiver or DEA X-license for buprenorphine).',
    `mat_supervising_provider_clinician_id` BIGINT COMMENT 'Identifier of the medical director or supervising physician overseeing the MAT program at the OTP.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient receiving medication assisted treatment for substance use disorder.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which MAT was initiated or managed.',
    `adverse_reaction_flag` BOOLEAN COMMENT 'Indicates whether the patient experienced a clinically significant adverse reaction to the MAT medication during this treatment episode.',
    `asam_level_of_care` STRING COMMENT 'ASAM criteria level of care determination for the patients substance use disorder treatment intensity.',
    `clinical_notes` STRING COMMENT 'Free-text clinical notes documenting treatment progress, patient response, and clinical decision-making for the MAT episode.',
    `consecutive_negative_screens` STRING COMMENT 'Count of consecutive negative urine drug screens, used to determine eligibility for take-home privilege advancement.',
    `consent_42cfr_part2_obtained` BOOLEAN COMMENT 'Indicates whether the patient has provided written consent for disclosure of substance use disorder treatment records per federal confidentiality regulations.',
    `consent_date` DATE COMMENT 'Date on which the patient signed the 42 CFR Part 2 consent for disclosure of SUD treatment information.',
    `counseling_frequency` STRING COMMENT 'Required frequency of behavioral health counseling sessions as part of the comprehensive MAT treatment plan.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this MAT treatment record was first created in the system.',
    `dea_waiver_number` STRING COMMENT 'DEA X-waiver number of the prescribing provider authorizing buprenorphine prescribing under DATA 2000 Act.',
    `discontinuation_reason` STRING COMMENT 'Reason for discontinuation of MAT if treatment ended prematurely (e.g., patient request, non-compliance, incarceration, relapse, adverse reaction, transfer, lost to follow-up).',
    `dosage_amount` DECIMAL(18,2) COMMENT 'Current prescribed dosage amount of the MAT medication.',
    `dosage_unit` STRING COMMENT 'Unit of measure for the prescribed MAT medication dosage.',
    `dosing_frequency` STRING COMMENT 'Frequency at which the MAT medication is administered or taken by the patient.',
    `end_date` DATE COMMENT 'Date on which the medication assisted treatment episode was completed, discontinued, or transferred.',
    `episode_number` STRING COMMENT 'Business-facing unique episode number assigned to this MAT treatment course for tracking and regulatory reporting.',
    `icd10_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code for the substance use disorder being treated (F10-F19 series).',
    `induction_date` DATE COMMENT 'Date on which the initial induction dose of MAT medication was administered under clinical observation.',
    `last_dose_date` DATE COMMENT 'Date of the most recent dose administration, critical for tracking adherence and missed doses.',
    `last_uds_date` DATE COMMENT 'Date of the most recent urine drug screen performed for treatment compliance monitoring.',
    `last_uds_result` STRING COMMENT 'Result of the most recent urine drug screen for the patient in this MAT episode.',
    `mat_treatment_status` STRING COMMENT 'Current lifecycle status of the medication assisted treatment episode.',
    `medication_name` STRING COMMENT 'Name of the medication prescribed for assisted treatment (e.g., buprenorphine/naloxone, methadone, naltrexone, acamprosate, disulfiram, varenicline).',
    `medication_ndc_code` STRING COMMENT 'National Drug Code identifying the specific MAT medication product, strength, and package.',
    `medication_route` STRING COMMENT 'Route by which the MAT medication is administered to the patient.',
    `next_scheduled_visit_date` DATE COMMENT 'Date of the next scheduled MAT clinic visit for dosing, counseling, or drug screening.',
    `observed_dosing_required` BOOLEAN COMMENT 'Indicates whether the patient is required to take medication under direct clinical observation (typical during induction and early stabilization).',
    `peak_dosage_amount` DECIMAL(18,2) COMMENT 'Highest dosage amount reached during the treatment episode, used for clinical review and taper planning.',
    `pregnancy_flag` BOOLEAN COMMENT 'Indicates whether the patient is pregnant during MAT, which affects medication selection (methadone or buprenorphine monoproduct preferred).',
    `primary_substance` STRING COMMENT 'Primary substance for which the patient is receiving medication assisted treatment (e.g., heroin, prescription opioids, alcohol, fentanyl).',
    `prior_authorization_number` STRING COMMENT 'Insurance prior authorization number required for MAT medication coverage.',
    `prior_treatment_episodes` STRING COMMENT 'Number of prior MAT or SUD treatment episodes the patient has had, indicating treatment history complexity.',
    `referral_source` STRING COMMENT 'Source from which the patient was referred to the MAT program.',
    `start_date` DATE COMMENT 'Date on which the medication assisted treatment episode was initiated.',
    `take_home_doses_per_week` STRING COMMENT 'Number of take-home doses authorized per week for the patient based on their privilege level and treatment compliance.',
    `take_home_privilege_level` STRING COMMENT 'OTP take-home medication privilege level (0-6) indicating the number of unsupervised doses permitted based on time in treatment and compliance.',
    `taper_start_date` DATE COMMENT 'Date on which medication taper was initiated for planned dose reduction toward discontinuation.',
    `treatment_phase` STRING COMMENT 'Current phase of the medication assisted treatment protocol indicating progression through the treatment continuum.',
    `treatment_plan_goal` STRING COMMENT 'Primary clinical goal of the MAT treatment plan as agreed upon by provider and patient.',
    `treatment_setting` STRING COMMENT 'Clinical setting where the MAT is being administered or managed.',
    `treatment_type` STRING COMMENT 'Classification of the substance use disorder being treated with medication assisted therapy.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this MAT treatment record was last modified.',
    `urine_drug_screen_frequency` STRING COMMENT 'Required frequency of urine drug screening to monitor treatment compliance and detect illicit substance use.',
    `treatment_number` STRING COMMENT 'Business identifier assigned to the treatment episode, used for external reference and reporting.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient receiving the medication assisted treatment.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the treatment was administered.',
    `medication_id` BIGINT COMMENT 'Identifier of the medication used in the assisted treatment.',
    `administration_route` STRING COMMENT 'Pathway by which the medication is delivered to the patient.. Valid values are `oral|intravenous|intramuscular|subcutaneous|inhalation|other`',
    `administration_frequency` STRING COMMENT 'Scheduled frequency of medication administration.. Valid values are `once_daily|twice_daily|weekly|monthly|as_needed|other`',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time for the first dose of the treatment.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time for the final dose of the treatment.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Date and time when the first dose was actually administered.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Date and time when the final dose was actually administered.',
    `prescriber_id` BIGINT COMMENT 'Identifier of the clinician who prescribed the medication.',
    `prescriber_npi` STRING COMMENT 'National Provider Identifier of the prescriber.',
    `treatment_status` STRING COMMENT 'Current lifecycle state of the treatment episode.. Valid values are `planned|in_progress|completed|cancelled|no_show`',
    `compliance_status` STRING COMMENT 'Indicates whether the patient complied with the prescribed regimen.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `urine_test_result` STRING COMMENT 'Result of the most recent urine drug screen associated with the treatment.. Valid values are `negative|positive|not_tested|pending`',
    `notes` STRING COMMENT 'Free‑text clinical notes documenting observations, patient response, and provider comments.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the treatment record was first created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the treatment record.',
    `program_enrollment_id` BIGINT COMMENT 'Identifier of the substance use disorder program enrollment linked to this treatment.',
    `consent_id` BIGINT COMMENT 'Reference to the patient consent record required for substance use treatment data sharing.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the treatment is flagged as clinically critical (e.g., high overdose risk).',
    `location_id` BIGINT COMMENT 'Identifier of the care site where the treatment was administered.',
    `billing_code` STRING COMMENT 'Procedure code used for billing the medication assisted treatment.',
    `billing_amount` DECIMAL(18,2) COMMENT 'Charged amount for the treatment episode before adjustments.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the billing amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `adverse_event_flag` BOOLEAN COMMENT 'True if an adverse event was recorded during the treatment.',
    `adverse_event_description` STRING COMMENT 'Narrative description of any adverse event associated with the treatment.',
    `refill_count` STRING COMMENT 'Number of medication refills authorized for the treatment course.',
    `next_scheduled_dose_datetime` TIMESTAMP COMMENT 'Planned date and time for the next dose after the current record.',
    `treatment_plan_id` BIGINT COMMENT 'Identifier of the overarching treatment plan to which this episode belongs.',
    `is_telehealth` BOOLEAN COMMENT 'True if the medication was administered via telehealth modalities.',
    `telehealth_platform` STRING COMMENT 'Technology platform used for remote administration or supervision.. Valid values are `zoom|teams|doxy|other`',
    `patient_consent_given` BOOLEAN COMMENT 'Indicates whether the patient provided consent for this treatment episode.',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the patient consent was recorded.',
    `risk_score` DECIMAL(18,2) COMMENT 'Clinical risk score associated with the patient at the time of treatment.',
    `outcome_score` DECIMAL(18,2) COMMENT 'Measured outcome score reflecting treatment effectiveness.',
    `discharge_status` STRING COMMENT 'Final disposition of the patient after the treatment episode.. Valid values are `discharged|transferred|deceased|ongoing`',
    `discharge_date` DATE COMMENT 'Date on which the patient was discharged or the episode concluded.',
    CONSTRAINT pk_mat_treatment PRIMARY KEY(`mat_treatment_id`)
) COMMENT 'Table for medication assisted treatment';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` (
    `otp_enrollment_id` BIGINT COMMENT 'Primary key for otp_enrollment',
    `care_program_id` BIGINT COMMENT 'Identifier of the specific opioid treatment program facility or clinic where the patient is enrolled.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient enrolled in the opioid treatment program.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary prescribing physician or medical director overseeing the patients OTP treatment.',
    `otp_counselor_clinician_id` BIGINT COMMENT 'Identifier of the substance use disorder counselor assigned to the patient for ongoing behavioral health support.',
    `admission_date` DATE COMMENT 'Date the patient was formally admitted to the opioid treatment program, which may differ from the effective start date due to intake processing.',
    `authorization_number` STRING COMMENT 'Insurance prior authorization number for the OTP treatment services, when required by the payer.',
    `consent_42cfr_part2_indicator` BOOLEAN COMMENT 'Indicates whether the patient has provided written consent for disclosure of substance use disorder treatment records per 42 CFR Part 2 federal confidentiality regulations.',
    `consent_date` DATE COMMENT 'Date the patient signed the 42 CFR Part 2 consent form authorizing disclosure of SUD treatment information.',
    `consent_expiration_date` DATE COMMENT 'Date the 42 CFR Part 2 consent authorization expires and must be renewed for continued information sharing.',
    `counseling_frequency` STRING COMMENT 'Required frequency of individual or group counseling sessions as part of the patients treatment plan.',
    `court_order_indicator` BOOLEAN COMMENT 'Indicates whether the patients enrollment in the OTP is mandated by a court order or criminal justice referral.',
    `court_order_number` STRING COMMENT 'Reference number of the court order mandating the patients participation in the opioid treatment program, when applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OTP enrollment record was first created in the system.',
    `current_dose_mg` DECIMAL(18,2) COMMENT 'Current daily dose of the MAT medication in milligrams as of the most recent dose adjustment.',
    `dea_registration_number` STRING COMMENT 'DEA registration number of the OTP facility authorized to dispense controlled substances for opioid treatment.',
    `discharge_date` DATE COMMENT 'Date the patient was formally discharged from the opioid treatment program, nullable for active enrollments.',
    `discharge_reason` STRING COMMENT 'Reason for the patients discharge from the opioid treatment program.',
    `dosing_frequency` STRING COMMENT 'Frequency at which the patient receives their MAT medication dose.',
    `effective_end_date` DATE COMMENT 'Date the patients enrollment in the opioid treatment program ends, nullable for open-ended active enrollments.',
    `effective_start_date` DATE COMMENT 'Date the patients enrollment in the opioid treatment program becomes active and treatment may commence.',
    `enrollment_number` STRING COMMENT 'Externally-known business identifier for this OTP enrollment episode, used for regulatory reporting and patient communication.',
    `enrollment_status` STRING COMMENT 'Current state of the patients enrollment in the opioid treatment program.',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment indicating how the patient entered the opioid treatment program.',
    `initial_dose_mg` DECIMAL(18,2) COMMENT 'Initial daily dose of the MAT medication in milligrams prescribed at the start of treatment.',
    `insurance_coverage_type` STRING COMMENT 'Primary insurance or payment coverage type for the patients OTP services.',
    `intake_assessment_date` DATE COMMENT 'Date the initial comprehensive substance use disorder assessment was completed as part of the OTP intake process.',
    `last_counseling_date` DATE COMMENT 'Date of the patients most recent counseling session within the OTP.',
    `last_drug_screen_date` DATE COMMENT 'Date of the most recent urine drug screen or toxicology test performed as part of treatment monitoring.',
    `last_drug_screen_result` STRING COMMENT 'Result of the most recent urine drug screen indicating presence or absence of illicit substances.',
    `medication_type` STRING COMMENT 'Type of medication prescribed for the patients medication-assisted treatment within the OTP.',
    `next_review_date` DATE COMMENT 'Date of the next scheduled treatment plan review by the medical director and treatment team.',
    `notes` STRING COMMENT 'Free-text clinical or administrative notes related to the enrollment, subject to 42 CFR Part 2 confidentiality protections.',
    `phase_level` STRING COMMENT 'Current treatment phase indicating the patients progression through the OTP program stages from induction to maintenance.',
    `pregnancy_indicator` BOOLEAN COMMENT 'Indicates whether the patient is currently pregnant, which affects dosing protocols and take-home eligibility per federal guidelines.',
    `primary_substance` STRING COMMENT 'Primary opioid substance the patient was using at the time of admission to the OTP.',
    `prior_treatment_episodes` STRING COMMENT 'Number of prior substance use disorder treatment episodes the patient has participated in before this enrollment.',
    `referral_source` STRING COMMENT 'Source from which the patient was referred to the opioid treatment program.',
    `route_of_administration` STRING COMMENT 'Primary route of administration for the patients opioid use at the time of admission.',
    `samhsa_certification_number` STRING COMMENT 'SAMHSA certification number of the opioid treatment program under which this enrollment is administered.',
    `take_home_approved_date` DATE COMMENT 'Date the current take-home medication privilege level was approved by the program physician.',
    `take_home_privilege_level` STRING COMMENT 'Level of take-home medication privileges granted to the patient based on treatment compliance and stability criteria per federal regulations. [ENUM-REF-CANDIDATE: none|one_day|two_day|three_day|weekly|biweekly|monthly — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this OTP enrollment record was last modified.',
    `years_of_opioid_use` STRING COMMENT 'Self-reported number of years the patient has been using opioids, captured at intake assessment.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient enrolling in the OTP; links to the patient master record.',
    `program_type` STRING COMMENT 'Type of behavioral health program; for OTP this is typically Opioid Treatment Program.',
    `program_tier` STRING COMMENT 'Tier level indicating intensity of services provided to the patient.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `enrollment_date` DATE COMMENT 'Date the patient officially entered the OTP.',
    `expected_end_date` DATE COMMENT 'Planned termination date of the enrollment agreement, if known.',
    `actual_end_date` DATE COMMENT 'Date the enrollment was actually closed or terminated.',
    `eligibility_status` STRING COMMENT 'Result of the eligibility assessment for OTP participation.. Valid values are `eligible|ineligible|pending`',
    `eligibility_check_date` DATE COMMENT 'Date the eligibility criteria were evaluated.',
    `eligibility_reason` STRING COMMENT 'Free‑text explanation for eligibility decision.',
    `consent_status` STRING COMMENT 'Current status of the patient’s 42 CFR Part 2 consent.. Valid values are `consented|declined|revoked`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form used.',
    `consent_document_id` BIGINT COMMENT 'Reference to the stored consent document.',
    `referring_provider_id` BIGINT COMMENT 'Identifier of the provider who referred the patient to the OTP.',
    `intake_assessment_id` BIGINT COMMENT 'Link to the initial psychiatric assessment performed at intake.',
    `diagnosis_code` STRING COMMENT 'ICD‑10 code representing the primary clinical diagnosis at enrollment.',
    `substance_use_disorder_type` STRING COMMENT 'Class of substance use disorder identified for the patient.. Valid values are `opioid|alcohol|cocaine|methamphetamine|other`',
    `medication_assigned` STRING COMMENT 'Medication selected for opioid use disorder treatment.. Valid values are `methadone|buprenorphine|naltrexone|other`',
    `medication_dosage_mg` DECIMAL(18,2) COMMENT 'Prescribed daily dosage in milligrams.',
    `medication_start_date` DATE COMMENT 'Date the medication regimen began.',
    `medication_end_date` DATE COMMENT 'Date the medication regimen is scheduled to end or was discontinued.',
    `urine_test_required` BOOLEAN COMMENT 'Indicates whether routine urine drug testing is required for the patient.',
    `urine_test_schedule` STRING COMMENT 'Frequency of required urine drug tests.. Valid values are `weekly|biweekly|monthly|none`',
    `last_urine_test_date` DATE COMMENT 'Date of the most recent urine drug test.',
    `case_manager_id` BIGINT COMMENT 'Identifier of the case manager assigned to the patient.',
    `case_manager_notes` STRING COMMENT 'Free‑text notes entered by the case manager.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `hipaa_retention_date` DATE COMMENT 'Date after which the enrollment record may be archived or destroyed per HIPAA policy.',
    `risk_level` STRING COMMENT 'Clinical risk classification for the patient during enrollment.. Valid values are `low|medium|high`',
    `treatment_plan_id` BIGINT COMMENT 'Reference to the detailed treatment plan associated with the enrollment.',
    `insurance_payer_id` BIGINT COMMENT 'Identifier of the payer responsible for coverage of OTP services.',
    `coverage_type` STRING COMMENT 'Extent of insurance coverage for the OTP services.. Valid values are `full|partial|none`',
    `billing_status` STRING COMMENT 'Current status of billing for the enrollment.. Valid values are `pending|billed|paid|denied|reversed`',
    `financial_responsibility` STRING COMMENT 'Entity responsible for payment of OTP services.. Valid values are `patient|payer|shared`',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_otp_enrollment PRIMARY KEY(`otp_enrollment_id`)
) COMMENT 'Table for opioid treatment program enrollment';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` (
    `crisis_episode_id` BIGINT COMMENT 'Primary key for crisis_episode',
    `care_site_id` BIGINT COMMENT 'The facility or care site where crisis services were delivered, if applicable.',
    `care_team_id` BIGINT COMMENT 'The mobile crisis team or crisis response unit dispatched to manage this episode.',
    `consent_record_id` BIGINT COMMENT 'Reference to the consent record governing disclosure of this crisis episode information.',
    `clinician_id` BIGINT COMMENT 'The provider or clinician assigned for post-crisis follow-up care.',
    `insurance_coverage_id` BIGINT COMMENT 'The insurance coverage or benefit plan applicable to this crisis episode for billing purposes.',
    `mpi_record_id` BIGINT COMMENT 'The patient experiencing the behavioral health crisis.',
    `primary_clinician_id` BIGINT COMMENT 'The primary behavioral health clinician or crisis counselor responsible for managing this crisis episode.',
    `visit_id` BIGINT COMMENT 'The clinical encounter associated with this crisis episode, if the patient was seen in a facility.',
    `authorization_number` STRING COMMENT 'Prior authorization or pre-certification number obtained from the payer for crisis services rendered.',
    `cfr_part2_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has provided consent for disclosure of substance use disorder information under 42 CFR Part 2 regulations.',
    `clinical_notes` STRING COMMENT 'Free-text clinical documentation of the crisis episode including assessment findings, interventions, and clinical reasoning.',
    `contact_method` STRING COMMENT 'The method by which the crisis service was initially contacted or the patient presented for crisis care.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when this crisis episode record was first created in the system.',
    `crisis_type` STRING COMMENT 'Classification of the behavioral health crisis event. [ENUM-REF-CANDIDATE: suicidal_ideation|self_harm|psychotic_break|substance_overdose|panic_attack|violent_behavior|dissociative_episode|manic_episode|severe_anxiety|homicidal_ideation — promote to reference product]',
    `discharge_plan_description` STRING COMMENT 'Summary of the safety plan and discharge instructions provided to the patient upon crisis resolution.',
    `disposition` STRING COMMENT 'The clinical disposition or outcome decision at the conclusion of the crisis episode.',
    `duration_minutes` STRING COMMENT 'Total duration of the active crisis episode measured in minutes from onset to resolution or stabilization.',
    `episode_number` STRING COMMENT 'Externally-known business identifier for the crisis episode used in clinical documentation and reporting.',
    `episode_status` STRING COMMENT 'Current lifecycle status of the crisis episode indicating where it stands in the clinical workflow.',
    `follow_up_within_24h_flag` BOOLEAN COMMENT 'Indicates whether a follow-up contact was made within 24 hours of crisis resolution, per best practice guidelines.',
    `hold_type` STRING COMMENT 'The specific type of involuntary hold or commitment statute applied, varying by state jurisdiction.',
    `intervention_summary` STRING COMMENT 'Summary of clinical interventions performed during the crisis episode including de-escalation techniques, medications, and therapeutic approaches.',
    `involuntary_hold_flag` BOOLEAN COMMENT 'Indicates whether an involuntary psychiatric hold (e.g., 5150, Baker Act) was initiated during this crisis episode.',
    `is_repeat_crisis` BOOLEAN COMMENT 'Indicates whether this crisis episode is a recurrence within a defined lookback period for the same patient.',
    `law_enforcement_involved_flag` BOOLEAN COMMENT 'Indicates whether law enforcement was involved in the crisis response or transport.',
    `location_type` STRING COMMENT 'Type of location where the crisis occurred or where the patient was found. [ENUM-REF-CANDIDATE: home|public_space|ed|inpatient|shelter|school|workplace|correctional|residential_facility — promote to reference product]',
    `medication_administered_flag` BOOLEAN COMMENT 'Indicates whether emergency or PRN medication was administered during the crisis episode.',
    `onset_datetime` TIMESTAMP COMMENT 'The date and time when the crisis episode began or was first reported, representing the principal business event timestamp.',
    `outcome_rating` STRING COMMENT 'Clinical assessment of the outcome effectiveness at the conclusion of the crisis episode.',
    `presenting_complaint` STRING COMMENT 'Chief complaint or presenting problem as described by the patient, family, or first responder at the time of crisis contact.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code assigned as the primary diagnosis for this crisis episode.',
    `prior_crisis_count_12m` STRING COMMENT 'Number of prior crisis episodes for this patient in the preceding 12-month period, used for recidivism tracking and care planning.',
    `referral_source` STRING COMMENT 'The source that referred or directed the patient to crisis services. [ENUM-REF-CANDIDATE: self|family|law_enforcement|ed|988_lifeline|provider|school|employer|court|community_agency — promote to reference product]',
    `reporting_period_date` DATE COMMENT 'The reporting period date used for state and federal behavioral health crisis reporting submissions.',
    `resolution_datetime` TIMESTAMP COMMENT 'The date and time when the crisis episode was clinically resolved or the patient was stabilized.',
    `response_time_minutes` STRING COMMENT 'Time in minutes from initial crisis contact to first clinical intervention or team arrival.',
    `restraint_used_flag` BOOLEAN COMMENT 'Indicates whether physical or chemical restraints were used during the crisis episode. Subject to CMS Conditions of Participation reporting.',
    `safety_plan_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal safety plan was completed with the patient during or after the crisis episode.',
    `seclusion_used_flag` BOOLEAN COMMENT 'Indicates whether seclusion was used during the crisis episode. Subject to CMS Conditions of Participation reporting.',
    `secondary_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code for a secondary or co-occurring condition relevant to the crisis episode.',
    `severity_level` STRING COMMENT 'Assessed severity of the crisis episode based on clinical evaluation, used for triage and resource allocation.',
    `substance_involved_flag` BOOLEAN COMMENT 'Indicates whether substance use or intoxication was a contributing factor in the crisis episode. Subject to 42 CFR Part 2 protections.',
    `substance_type` STRING COMMENT 'Primary substance involved in the crisis if substance use is a contributing factor. Subject to 42 CFR Part 2 protections. [ENUM-REF-CANDIDATE: alcohol|opioid|stimulant|benzodiazepine|cannabis|polysubstance|hallucinogen|inhalant — promote to reference product]',
    `suicide_risk_score` STRING COMMENT 'Standardized suicide risk assessment score (e.g., C-SSRS score) assigned during the crisis evaluation.',
    `transport_mode` STRING COMMENT 'Mode of transportation used to bring the patient to a crisis facility or to transport them after stabilization.',
    `trigger_description` STRING COMMENT 'Narrative description of the precipitating event or stressor that triggered the crisis episode.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when this crisis episode record was last modified.',
    `violence_risk_score` STRING COMMENT 'Standardized violence or aggression risk score assigned during crisis evaluation.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient experiencing the crisis.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the crisis.',
    `provider_id` BIGINT COMMENT 'Identifier of the primary provider who managed the crisis.',
    `trigger_event` STRING COMMENT 'Description of the precipitating event or circumstance.',
    `intervention_type` STRING COMMENT 'Primary intervention applied during the crisis.. Valid values are `medication|psychotherapy|debrief|hospitalization|community_support|other`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric risk assessment score (0‑100) indicating suicide risk.',
    `crisis_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the crisis episode began.',
    `crisis_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the crisis episode ended or was resolved.',
    `location_id` BIGINT COMMENT 'Identifier of the location/facility where the crisis occurred.',
    `facility_name` STRING COMMENT 'Name of the facility or site of the crisis.',
    `follow_up_plan` STRING COMMENT 'Planned follow‑up actions or appointments.',
    `follow_up_date` DATE COMMENT 'Scheduled date for the follow‑up appointment.',
    `medication_administered` STRING COMMENT 'Medication(s) given during the episode (e.g., lorazepam).',
    `notes` STRING COMMENT 'Clinical notes documenting the episode.',
    `consent_42cfr_part2_id` BIGINT COMMENT 'Reference to the 42 CFR Part 2 consent record linked to this episode.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who created the record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the user who last modified the record.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating if the episode contains highly sensitive information subject to additional access controls.',
    `referral_needed_flag` BOOLEAN COMMENT 'Indicates whether a referral to external services is required.',
    `referral_destination` STRING COMMENT 'Name or code of the external service to which referral is made.',
    `crisis_outcome` STRING COMMENT 'Overall outcome of the crisis management.. Valid values are `stabilized|escalated|resolved|ongoing|other`',
    `assessment_tool_used` STRING COMMENT 'Standardized assessment tool employed (e.g., C-SSRS).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score derived from the assessment tool.',
    `emergency_contact_id` BIGINT COMMENT 'Identifier of the emergency contact person for the patient.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.',
    `is_repeat_episode` BOOLEAN COMMENT 'Indicates if this episode is a repeat occurrence for the same patient within 30 days.',
    `prior_episode_id` BIGINT COMMENT 'Reference to a prior related crisis episode, if any.',
    `documentation_source` STRING COMMENT 'Source system or method used to capture the episode data.. Valid values are `EHR|Paper|Phone|Other`',
    CONSTRAINT pk_crisis_episode PRIMARY KEY(`crisis_episode_id`)
) COMMENT 'Table for crisis episodes';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` (
    `cfr42_consent_id` BIGINT COMMENT 'Primary key for cfr42_consent',
    `care_site_id` BIGINT COMMENT 'Identifier of the treatment facility or program holding the Part 2 records.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider or program from which SUD records may be disclosed.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who obtained and documented this consent from the patient.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient granting consent for disclosure of substance use disorder treatment records.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which this consent was obtained, if applicable.',
    `consent_number` STRING COMMENT 'Business-facing unique reference number assigned to this consent form for tracking and audit purposes.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent authorization within the 42 CFR Part 2 workflow.',
    `consent_type` STRING COMMENT 'Classification of the consent form type indicating the nature of the authorization for disclosure of SUD records.',
    `consent_version` STRING COMMENT 'Version identifier of the consent form template used, supporting compliance tracking when form language is updated.',
    `court_order_reference` STRING COMMENT 'Reference number or citation of the court order authorizing disclosure, if applicable.',
    `disclosure_scope` STRING COMMENT 'Defines the extent of SUD records authorized for disclosure—whether all records, specific treatment episodes, a date range, or specific categories of information.',
    `document_storage_location` STRING COMMENT 'Reference path or URI to the scanned or electronic copy of the signed consent form in the document management system.',
    `effective_date` DATE COMMENT 'Date on which the consent authorization becomes legally effective and disclosure is permitted.',
    `expiration_condition` STRING COMMENT 'Description of the event or condition upon which the consent expires if not a fixed date (e.g., completion of treatment episode).',
    `expiration_date` DATE COMMENT 'Date on which the consent authorization expires. Per 42 CFR Part 2, consent must include a date, event, or condition upon which it expires.',
    `hipaa_retention_years` STRING COMMENT 'Number of years this consent record must be retained per HIPAA and 42 CFR Part 2 retention requirements. Supports Databricks HIPAA retention annotations.',
    `information_disclosed` STRING COMMENT 'Description of the specific kind and amount of SUD information authorized for disclosure (e.g., diagnosis, treatment dates, medications, lab results).',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter was used during the consent process to ensure patient comprehension.',
    `is_court_ordered` BOOLEAN COMMENT 'Indicates whether this disclosure is authorized by court order rather than patient consent, subject to 42 CFR Part 2 Subpart E requirements.',
    `is_minor_consent` BOOLEAN COMMENT 'Indicates whether this consent involves a minor patient, which may require additional guardian authorization per state law.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the language in which the consent form was presented to the patient.',
    `legal_representative_name` STRING COMMENT 'Name of the legal guardian or authorized representative who signed consent on behalf of the patient (e.g., for minors or incapacitated individuals).',
    `legal_representative_relationship` STRING COMMENT 'Relationship of the legal representative to the patient.',
    `mat_program_indicator` BOOLEAN COMMENT 'Indicates whether this consent specifically covers Medication-Assisted Treatment (MAT) or Opioid Treatment Program (OTP) records.',
    `purpose_of_disclosure` STRING COMMENT 'Statement of the purpose for which the patient is consenting to disclosure of SUD treatment information, as required by 42 CFR Part 2.',
    `recipient_name` STRING COMMENT 'Name of the individual or organization to whom the SUD records may be disclosed.',
    `recipient_organization` STRING COMMENT 'Name of the receiving organization or entity authorized to receive the disclosed SUD treatment information.',
    `recipient_type` STRING COMMENT 'Category of the recipient to whom SUD records are being disclosed.',
    `redisclosure_prohibition_acknowledged` BOOLEAN COMMENT 'Indicates whether the required prohibition on redisclosure statement was included and acknowledged per 42 CFR Part 2 requirements.',
    `revocation_date` DATE COMMENT 'Date on which the patient revoked this consent. Revocation is prospective only per 42 CFR Part 2.',
    `revocation_reason` STRING COMMENT 'Patient-stated reason for revoking consent, if provided. Documentation supports compliance audit trail.',
    `signature_date` DATE COMMENT 'Date on which the patient or authorized representative signed the consent form.',
    `signature_method` STRING COMMENT 'Method by which the consent was signed (wet ink, electronic signature, or verbal with witness).',
    `substance_category` STRING COMMENT 'Category of substance use disorder to which this consent applies, used to scope the disclosure appropriately.',
    `treatment_episode_reference` STRING COMMENT 'Reference to the specific SUD treatment episode(s) covered by this consent, if disclosure scope is limited to specific episodes.',
    `verification_method` STRING COMMENT 'Method used to verify the identity of the patient or representative prior to obtaining consent.',
    `witness_name` STRING COMMENT 'Name of the witness present during consent signing, required for verbal consents and recommended for all Part 2 consents.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient to whom the consent applies.',
    `patient_mrn` STRING COMMENT 'Medical Record Number used by the health system to identify the patient.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider who obtained or recorded the consent.',
    `provider_npi` STRING COMMENT 'Standard NPI of the provider associated with the consent.',
    `consent_date` DATE COMMENT 'Date on which the patient signed or otherwise gave the consent.',
    `effective_from` DATE COMMENT 'First date the consent becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date on which the consent expires or is no longer valid (null if open‑ended).',
    `revocation_status` STRING COMMENT 'Current revocation state of the consent.. Valid values are `active|revoked|expired|suspended`',
    `consent_scope` STRING COMMENT 'Narrative description of the data, services, and contexts covered by the consent.',
    `consent_notes` STRING COMMENT 'Additional free‑text comments or conditions attached to the consent.',
    `signature_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the signature was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who initially entered the consent.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the system user who last modified the consent.',
    `jurisdiction` STRING COMMENT 'State or jurisdiction governing the consent, required for 42 CFR Part 2 compliance.',
    `legal_basis` STRING COMMENT 'Legal justification for the consent under applicable law.. Valid values are `patient_authorization|court_order|public_health|research`',
    `data_retention_period_days` STRING COMMENT 'Number of days the consent record must be retained per policy.',
    `retention_expiration_date` DATE COMMENT 'Calculated date when the consent record may be safely purged.',
    `psychiatric_assessment_id` BIGINT COMMENT 'Link to the psychiatric assessment associated with this consent.',
    `sud_episode_id` BIGINT COMMENT 'Link to the SUD episode for which the consent applies.',
    `mat_treatment_id` BIGINT COMMENT 'Link to the MAT treatment episode tied to the consent.',
    `otp_enrollment_id` BIGINT COMMENT 'Reference to the OTP enrollment record associated with the consent.',
    `crisis_episode_id` BIGINT COMMENT 'Reference to a crisis episode linked to the consent.',
    `part2_section` STRING COMMENT 'Specific Part 2 regulatory section governing this consent.. Valid values are `section_1|section_2|section_3`',
    `part2_exemptions` STRING COMMENT 'Narrative description of any statutory exemptions applicable to the consent.',
    `part2_disclosure_allowed` BOOLEAN COMMENT 'Flag indicating whether the consent permits disclosure of the protected information.',
    `part2_disclosure_date` DATE COMMENT 'Date when a disclosure was made under the consent, if applicable.',
    CONSTRAINT pk_cfr42_consent PRIMARY KEY(`cfr42_consent_id`)
) COMMENT 'Table for 42 CFR Part 2 consent workflow';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` (
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Primary key for behavioral_health_psychiatric_assessment',
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.behavioral_health_crisis_episode. Business justification: Crisis episodes often trigger formal psychiatric assessments - the crisis_episode has assessment_tool_used and assessment_score fields indicating assessment activity during crisis, and a full psychiat',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.behavioral_health_sud_episode. Business justification: Psychiatric assessments are routinely performed during SUD episodes - at intake, periodically during treatment, and at discharge. The psychiatric_assessment table already has substance_use_disorder_fl',
    `care_plan_id` BIGINT COMMENT 'Identifier linking to a detailed care plan.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Psychiatric assessments occur at specific licensed facilities. State mental health authority reporting and Joint Commission BH standards require facility-level tracking. Replaces denormalized assessme',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Risk-stratified behavioral health screening: AI risk scores trigger psychiatric evaluations for high-risk patients. Enables tracking which AI prediction led to the assessment and validates model effec',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the clinician who performed the assessment.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Psychiatric assessments yield formal diagnoses requiring linkage to the clinical diagnosis record for CDI reconciliation, problem list synchronization, and integrated care documentation per Joint Comm',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the last audit action.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient undergoing the assessment.',
    `previous_assessment_psychiatric_assessment_behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Reference to a prior related psychiatric assessment, if any.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Psychiatric assessments require ICD-coded diagnoses for claims submission, HEDIS quality measures, and payer prior authorization. Every behavioral health clinician documents a primary ICD diagnosis pe',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Psychiatric assessments bill under specific CPT codes (90791/90792). Revenue cycle management requires linking assessments to standardized procedure codes for charge capture and payer adjudication.',
    `prom_response_id` BIGINT COMMENT 'Foreign key linking to digital_health.prom_response. Business justification: Psychiatric assessments incorporate digitally-collected PROM scores (PHQ-9, GAD-7, C-SSRS). Linking to the source prom_response enables audit trail for measurement-based care and validates assessment ',
    `psychiatric_assessment_id` BIGINT COMMENT 'Unique identifier for the psychiatric assessment record.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Psychiatric assessments occur during scheduled appointments. Link supports access-to-care metrics (time from scheduling to assessment), no-show impact analysis, and regulatory reporting on behavioral ',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: Whole-person psychiatric evaluation incorporates social determinants per APA guidelines. Clinicians review SDOH screening during assessment to identify social contributors to mental health conditions ',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Psychiatric assessments occur during specific encounters (ED, inpatient, outpatient). Linking to visit is essential for encounter-based billing, clinical documentation completeness, and regulatory com',
    `assessment_date` DATE COMMENT 'Date when the assessment was conducted.',
    `assessment_duration_minutes` STRING COMMENT 'Duration of the assessment session in minutes.',
    `assessment_findings` STRING COMMENT 'Narrative findings and observations recorded by the clinician.',
    `assessment_instrument` STRING COMMENT 'description',
    `assessment_modality` STRING COMMENT 'Mode of delivery for the assessment.. Valid values are `in_person|telehealth|phone|video`',
    `assessment_number` STRING COMMENT 'External reference number for the assessment as used in clinical workflow.',
    `assessment_outcome` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `stable|improved|deteriorated|no_change`',
    `assessment_source` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `referral|self|screening|emergency`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Exact date and time when the assessment was recorded.',
    `assessment_version` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `audit_action` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `create|update|delete|review`',
    `behavioral_health_psychiatric_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `completed|in_progress|cancelled|pending_review`',
    `billing_code` STRING COMMENT 'Billing code (CPT/HCPCS) associated with the assessment.',
    `comorbid_conditions` STRING COMMENT 'List of comorbid mental health conditions identified.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the patient provided consent for treatment as per 42 CFR Part 2.',
    `consent_type` STRING COMMENT 'Type of consent obtained.. Valid values are `full|partial|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `cssrs_score` STRING COMMENT 'description',
    `data_retention_date` DATE COMMENT 'Date after which the assessment record may be archived per retention policy.',
    `diagnosis_codes` STRING COMMENT 'Comma-separated list of diagnosis codes (ICD-10) assigned during the assessment.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up assessment.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up appointment is required.',
    `gad7_score` STRING COMMENT 'description',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates if patient’s insurance covers the assessment.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates if an interpreter was used.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the assessment is marked confidential per patient request.',
    `is_telehealth` BOOLEAN COMMENT 'Flag indicating if assessment was conducted via telehealth.',
    `language_used` STRING COMMENT 'Language used during the assessment.',
    `medication_allergy_flag` BOOLEAN COMMENT 'Flag indicating if patient has documented medication allergies.',
    `notes_private` STRING COMMENT 'Additional private notes by clinician, may contain PHI.',
    `patient_age_at_assessment` STRING COMMENT 'Patient age in years at time of assessment.',
    `patient_employment_status` STRING COMMENT 'Employment status of patient at assessment.. Valid values are `employed|unemployed|student|retired|disabled|unknown`',
    `patient_gender` STRING COMMENT 'Patient gender recorded at assessment.. Valid values are `male|female|non_binary|other|unknown`',
    `patient_income_bracket` STRING COMMENT 'Income bracket category for socioeconomic context.. Valid values are `low|middle|high|unknown`',
    `patient_race` STRING COMMENT 'Patient race/ethnicity as recorded.',
    `phq9_score` STRING COMMENT 'description',
    `primary_diagnosis_code` STRING COMMENT 'Primary diagnosis code (ICD-10) for the assessment.',
    `risk_level` STRING COMMENT 'Clinical risk level determined during assessment.. Valid values are `low|moderate|high|critical`',
    `severity_score` STRING COMMENT 'Numeric severity score assigned by clinician (e.g., 0-10).',
    `substance_use_disorder_flag` BOOLEAN COMMENT 'Flag indicating presence of substance use disorder identified.',
    `treatment_recommendations` STRING COMMENT 'Recommended treatment plan or interventions resulting from the assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_behavioral_health_psychiatric_assessment PRIMARY KEY(`behavioral_health_psychiatric_assessment_id`)
) COMMENT 'Record of a psychiatric assessment performed for a patient, capturing clinician, assessment date, findings, diagnosis codes, and treatment recommendations.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` (
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Primary key for behavioral_health_sud_episode',
    `care_plan_id` BIGINT COMMENT 'Reference to the care plan associated with this episode.',
    `care_site_id` BIGINT COMMENT 'Facility or location where the episode was primarily delivered.',
    `cfr42_consent_id` BIGINT COMMENT 'Reference to the 42 CFR Part 2 consent record linked to this episode.',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.care_gap. Business justification: Population health care gap closure: AI detects SUD treatment gaps, SUD episodes are initiated to close them. Required for HEDIS/quality reporting on gap resolution rates and intervention tracking.',
    `clinician_id` BIGINT COMMENT 'Provider responsible for overseeing the episode.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: SUD treatment episodes require formal diagnosis linkage for HEDIS quality measures, payer authorization, SAMHSA reporting, and billing validation of medical necessity against ICD-10 F10-F19 codes.',
    `payer_id` BIGINT COMMENT 'Payer responsible for coverage during the episode.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: SAMHSA/DEA regulations require SUD treatment episodes to maintain traceable links to MAT prescriptions (buprenorphine/naltrexone) for X-waiver compliance reporting and treatment outcome tracking.',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: SUD treatment authorization and claims require tracking which specific member enrollment provides coverage. Payers mandate eligibility verification per episode for residential/outpatient SUD services.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient receiving SUD treatment.',
    `population_health_cohort_management_cohort_membership_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort_management.cohort_membership. Business justification: Value-based care programs use population health cohorts to identify high-risk SUD patients for targeted intervention. ACOs and managed behavioral health organizations track which cohort identification',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: SUD episodes require ICD-coded substance use diagnoses for state TEDS reporting, payer authorization, and ASAM level-of-care determination. Regulatory mandate for all SUD treatment programs.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: SUD episodes must link to the patients clinical problem list entry for integrated care coordination, ensuring PCPs and specialists see active substance use conditions during medication reconciliation',
    `rpm_enrollment_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_enrollment. Business justification: SUD recovery patients are enrolled in RPM programs for remote vitals/compliance monitoring. Care coordinators track which RPM enrollment supports each SUD episode for outcomes reporting and relapse pr',
    `sdoh_assessment_id` BIGINT COMMENT 'Foreign key linking to patient.sdoh_assessment. Business justification: Integrated SUD treatment requires SDOH context (housing, employment, food security). SAMHSA guidelines mandate addressing social determinants in substance use treatment planning. Links episode to pati',
    `sud_episode_id` BIGINT COMMENT 'Unique surrogate key for the SUD treatment episode.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: SUD treatment programs are delivered by provider groups (addiction treatment centers). Required for SAMHSA program reporting, network adequacy analysis, and value-based care attribution at the group p',
    `behavioral_health_sud_episode_status` STRING COMMENT 'Current lifecycle status of the episode.. Valid values are `active|completed|terminated|paused|withdrawn`',
    `bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: SUD treatment episodes are governed by individualized treatment plans (care plans) required by SAMHSA, state licensing boards, and payer contracts for level-of-care determination and step-down authori',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was created.',
    `discharge_reason` STRING COMMENT 'Reason for discharge or episode termination.',
    `end_date` DATE COMMENT 'Date when the SUD treatment episode concluded or was terminated.',
    `episode_number` STRING COMMENT 'Business identifier for the episode, often used in clinical documentation.',
    `episode_type` STRING COMMENT 'Classification of the episode lifecycle.. Valid values are `initial|continuation|follow_up|maintenance`',
    `mat_end_date` DATE COMMENT 'Date MAT medication was discontinued.',
    `mat_medication` STRING COMMENT 'Name of the MAT medication used (e.g., buprenorphine, methadone).',
    `mat_start_date` DATE COMMENT 'Date MAT medication was initiated.',
    `medication_assisted_treatment_flag` BOOLEAN COMMENT 'Indicates if medication‑assisted treatment (MAT) was part of the episode.',
    `notes` STRING COMMENT 'Free‑text clinical notes for the episode.',
    `outcome_score` STRING COMMENT 'Clinician‑assigned outcome score (1‑5) for the episode.',
    `patient_ethnicity` STRING COMMENT 'Self‑reported ethnicity of the patient.',
    `patient_gender` STRING COMMENT 'Self‑identified gender of the patient.. Valid values are `male|female|other|unknown`',
    `patient_race` STRING COMMENT 'Self‑reported race of the patient.',
    `primary_substance` STRING COMMENT 'Primary substance of abuse documented for the episode. [ENUM-REF-CANDIDATE: alcohol|opioid|cocaine|methamphetamine|benzodiazepine|cannabis|other — promote to reference product]',
    `program_enrollment_flag` BOOLEAN COMMENT 'Indicates enrollment in a specific SUD program (e.g., intensive outpatient).',
    `program_type` STRING COMMENT 'Type of SUD treatment program for the episode.. Valid values are `outpatient|inpatient|intensive_outpatient|residential`',
    `relapse_date` DATE COMMENT 'Date of documented relapse event.',
    `relapse_flag` BOOLEAN COMMENT 'Indicates whether the patient experienced a relapse during the episode.',
    `risk_assessment_score` STRING COMMENT 'Risk assessment score at episode start.',
    `secondary_substances` STRING COMMENT 'Comma-separated list of additional substances of abuse identified.',
    `severity_level` STRING COMMENT 'Clinician-assigned severity of the substance use disorder for this episode.. Valid values are `mild|moderate|severe|extreme`',
    `start_date` DATE COMMENT 'Date when the SUD treatment episode began.',
    `total_days_of_care` STRING COMMENT 'Total days of care delivered in the episode.',
    `total_visits` STRING COMMENT 'Total number of clinical visits within the episode.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the episode record.',
    `urine_drug_screen_flag` BOOLEAN COMMENT 'Indicates if urine drug screening was performed.',
    CONSTRAINT pk_behavioral_health_sud_episode PRIMARY KEY(`behavioral_health_sud_episode_id`)
) COMMENT 'Episode record documenting a patients substance use disorder treatment period, including start/end dates, substances, severity, and associated care plans.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` (
    `behavioral_health_mat_treatment_id` BIGINT COMMENT 'Primary key for behavioral_health_mat_treatment',
    `behavioral_health_otp_enrollment_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.otp_enrollment. Business justification: MAT doses are frequently administered within the context of an Opioid Treatment Program enrollment. Linking mat_treatment to otp_enrollment allows tracking which OTP enrollment governs this specific M',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: MAT (Medication Assisted Treatment) is a core intervention within a SUD episode. Linking mat_treatment to sud_episode establishes the clinical context - which substance use disorder treatment episode ',
    `care_plan_id` BIGINT COMMENT 'Identifier of the overarching treatment plan to which this episode belongs.',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site where the treatment was administered.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry.BIGINT surrogate key for clean keying. Business justification: MAT dose administrations require CDM lookup for correct charge amount and billing code. OTP programs bill per-dose using specific HCPCS codes mapped through CDM for Medicaid/commercial payer submissio',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: MAT prescriptions (buprenorphine/methadone) originate from clinical orders. DEA Schedule III-V prescribing compliance, pharmacy fulfillment tracking, and PDMP reporting require tracing MAT treatments ',
    `clinician_id` BIGINT COMMENT 'Added Unity Catalog tags for PHI/PII.',
    `cfr42_consent_id` BIGINT COMMENT 'Reference to the patient consent record required for substance use treatment data sharing.',
    `drug_master_id` BIGINT COMMENT 'Identifier of the medication used in the assisted treatment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: SAMHSA OTP regulations (42 CFR 8.12) require documenting staff who administer observed methadone/buprenorphine doses. Administering nurse/tech is distinct from prescriber_id (provider.clinician). Crit',
    `laboratory_test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result.BIGINT surrogate key for clean keying. Business justification: DEA 42 CFR Part 8 requires MAT programs to document lab-confirmed drug screens for treatment compliance. Links MAT dosing decisions to verified laboratory toxicology results.',
    `mat_treatment_id` BIGINT COMMENT 'Unique surrogate key for each medication assisted treatment record.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient receiving the medication assisted treatment.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: MAT (methadone, buprenorphine) must continue uninterrupted during post-acute stays per SAMHSA guidelines. Linking MAT administrations to the PAC episode ensures medication continuity tracking and prev',
    `dea_registration_id` BIGINT COMMENT 'Foreign key linking to provider.dea_registration. Business justification: MAT prescribing requires specific DEA X-waiver/OTP authorization. Direct link enables real-time compliance verification that prescriber holds appropriate controlled substance authority for buprenorphi',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: MAT compliance monitoring requires linking treatment records to specific prescriptions for X-waiver prescriber reporting, refill authorization tracking, and PDMP integration per DEA requirements.',
    `program_enrollment_id` BIGINT COMMENT 'Identifier of the substance use disorder program enrollment linked to this treatment.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: MAT dosing visits (methadone, buprenorphine) require scheduled appointments. Link enables medication adherence tracking via appointment attendance, SAMHSA compliance reporting, and OTP dosing schedule',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: MAT pharmacotherapy trials require linking each treatment administration to research enrollment for investigational product accountability, dosing protocol compliance, and SAE reporting per FDA 21 CFR',
    `utilization_review_id` BIGINT COMMENT 'Foreign key linking to insurance.utilization_review. Business justification: MAT medications (buprenorphine, methadone) require payer prior authorization and ongoing utilization review for continuation. Links treatment to the specific UR decision authorizing it.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the treatment was administered.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Date and time when the final dose was actually administered.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Date and time when the first dose was actually administered.',
    `administration_frequency` STRING COMMENT 'Scheduled frequency of medication administration.. Valid values are `once_daily|twice_daily|weekly|monthly|as_needed|other`',
    `administration_route` STRING COMMENT 'Pathway by which the medication is delivered to the patient.. Valid values are `oral|intravenous|intramuscular|subcutaneous|inhalation|other`',
    `adverse_event_description` STRING COMMENT 'Narrative description of any adverse event associated with the treatment.',
    `adverse_event_flag` BOOLEAN COMMENT 'True if an adverse event was recorded during the treatment.',
    `bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: MAT protocols (buprenorphine, methadone) are governed by individualized care plans per SAMHSA guidelines; DEA X-waiver compliance and payer prior auth require care plan linkage.',
    `billing_amount` DECIMAL(18,2) COMMENT 'Charged amount for the treatment episode before adjustments.',
    `billing_code` STRING COMMENT 'Procedure code used for billing the medication assisted treatment.',
    `compliance_status` STRING COMMENT 'Indicates whether the patient complied with the prescribed regimen.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the patient consent was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the treatment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the billing amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `discharge_date` DATE COMMENT 'Date on which the patient was discharged or the episode concluded.',
    `discharge_status` STRING COMMENT 'Final disposition of the patient after the treatment episode.. Valid values are `discharged|transferred|deceased|ongoing`',
    `dosage_amount` DECIMAL(18,2) COMMENT 'Numeric amount of medication administered per dose.',
    `dosage_unit` STRING COMMENT 'Unit of measure for the dosage amount.. Valid values are `mg|ml|units|g|mcg|tablet`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the treatment is flagged as clinically critical (e.g., high overdose risk).',
    `is_telehealth` BOOLEAN COMMENT 'True if the medication was administered via telehealth modalities.',
    `next_scheduled_dose_datetime` TIMESTAMP COMMENT 'Planned date and time for the next dose after the current record.',
    `notes` STRING COMMENT 'Free‑text clinical notes documenting observations, patient response, and provider comments.',
    `outcome_score` DECIMAL(18,2) COMMENT 'Measured outcome score reflecting treatment effectiveness.',
    `patient_consent_given` BOOLEAN COMMENT 'Indicates whether the patient provided consent for this treatment episode.',
    `prescriber_npi` STRING COMMENT 'National Provider Identifier of the prescriber.',
    `refill_count` STRING COMMENT 'Number of medication refills authorized for the treatment course.',
    `risk_score` DECIMAL(18,2) COMMENT 'Clinical risk score associated with the patient at the time of treatment.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time for the final dose of the treatment.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time for the first dose of the treatment.',
    `telehealth_platform` STRING COMMENT 'Technology platform used for remote administration or supervision.. Valid values are `zoom|teams|doxy|other`',
    `treatment_number` STRING COMMENT 'Business identifier assigned to the treatment episode, used for external reference and reporting.',
    `treatment_status` STRING COMMENT 'Current lifecycle state of the treatment episode.. Valid values are `planned|in_progress|completed|cancelled|no_show`',
    `treatment_type` STRING COMMENT 'Category of the treatment modality delivered.. Valid values are `medication_assisted|counseling|group_therapy|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the treatment record.',
    CONSTRAINT pk_behavioral_health_mat_treatment PRIMARY KEY(`behavioral_health_mat_treatment_id`)
) COMMENT 'Transactional record of medication assisted treatment administered, capturing medication, dosage, schedule, prescriber, and compliance monitoring.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` (
    `behavioral_health_otp_enrollment_id` BIGINT COMMENT 'Primary key for behavioral_health_otp_enrollment',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: OTP programs assign specific formulary medications (methadone, buprenorphine) per SAMHSA 42 CFR Part 8. Normalizing medication_assigned text to a drug_master FK enables formulary validation and dosing',
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Link to the initial psychiatric assessment performed at intake.',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: An OTP enrollment is typically initiated as part of a specific SUD episode. Linking otp_enrollment to sud_episode allows tracking which substance use disorder treatment episode drove the OTP enrollmen',
    `care_plan_id` BIGINT COMMENT 'Reference to the detailed treatment plan associated with the enrollment.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: OTP programs operate at SAMHSA-certified, DEA-registered facilities. Federal 42 CFR Part 8 requires tracking which facility dispenses controlled substances for opioid treatment. Essential for SAMHSA c',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Risk-stratified OTP program enrollment: AI risk scores inform which SUD patients need intensive opioid treatment programs. Supports value-based care programs targeting high-risk populations for MAT en',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who referred the patient to the OTP.',
    `consent_record_id` BIGINT COMMENT 'Reference to the stored consent document.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OTP programs operate as distinct financial units requiring budget-vs-actual tracking. Cost center assignment enables program-level P&L reporting, FTE allocation, and Medicare/Medicaid cost report prep',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: SAMHSA OTP certification requires documented opioid use disorder diagnosis (ICD F11.xx). Regulatory compliance reporting and Medicaid billing mandate standardized ICD coding for OTP admissions.',
    `employee_id` BIGINT COMMENT 'Identifier of the case manager assigned to the patient.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: OTP programs are frequently SAMHSA/state grant-funded. Tracking fund_id on enrollment enables mandatory grant utilization reporting, fund balance monitoring, and restricted-fund compliance for federal',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: OTP programs verify insurance eligibility at enrollment and ongoing. Direct link to member_enrollment enables real-time eligibility checks and proper billing for methadone/buprenorphine dispensing.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient enrolling in the OTP; links to the patient master record.',
    `otp_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for each OTP enrollment record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: OTPs are DEA/SAMHSA-certified organizational providers. Enrollment must link to the certified org for DEA compliance, SAMHSA certification tracking, CMS billing, and state licensing requirements.',
    `payer_contact_id` BIGINT COMMENT 'Identifier of the payer responsible for coverage of OTP services.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: OTP daily dosing requires a standing prescription for DEA Schedule II compliance. Linking enrollment to the active prescription enables take-home dose authorization and dispensing verification workflo',
    `actual_end_date` DATE COMMENT 'Date the enrollment was actually closed or terminated.',
    `billing_status` STRING COMMENT 'Current status of billing for the enrollment.. Valid values are `pending|billed|paid|denied|reversed`',
    `case_manager_notes` STRING COMMENT 'Free‑text notes entered by the case manager.',
    `consent_date` DATE COMMENT 'Date the patient provided or updated consent.',
    `consent_status` STRING COMMENT 'Current status of the patient’s 42 CFR Part 2 consent.. Valid values are `consented|declined|revoked`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form used.',
    `coverage_type` STRING COMMENT 'Extent of insurance coverage for the OTP services.. Valid values are `full|partial|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `diagnosis_code` STRING COMMENT 'ICD‑10 code representing the primary clinical diagnosis at enrollment.',
    `discharge_date` DATE COMMENT 'Date the patient was formally discharged from the program.',
    `discharge_reason` STRING COMMENT 'Narrative reason for ending the OTP enrollment.',
    `eligibility_check_date` DATE COMMENT 'Date the eligibility criteria were evaluated.',
    `eligibility_reason` STRING COMMENT 'Free‑text explanation for eligibility decision.',
    `eligibility_status` STRING COMMENT 'Result of the eligibility assessment for OTP participation.. Valid values are `eligible|ineligible|pending`',
    `enrollment_date` DATE COMMENT 'Date the patient officially entered the OTP.',
    `enrollment_number` STRING COMMENT 'External enrollment number assigned by the program for tracking and reporting.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment record.. Valid values are `active|completed|withdrawn|suspended|pending`',
    `expected_end_date` DATE COMMENT 'Planned termination date of the enrollment agreement, if known.',
    `financial_responsibility` STRING COMMENT 'Entity responsible for payment of OTP services.. Valid values are `patient|payer|shared`',
    `hipaa_retention_date` DATE COMMENT 'Date after which the enrollment record may be archived or destroyed per HIPAA policy.',
    `last_urine_test_date` DATE COMMENT 'Date of the most recent urine drug test.',
    `medication_assigned` STRING COMMENT 'Medication selected for opioid use disorder treatment.. Valid values are `methadone|buprenorphine|naltrexone|other`',
    `medication_dosage_mg` DECIMAL(18,2) COMMENT 'Prescribed daily dosage in milligrams.',
    `medication_end_date` DATE COMMENT 'Date the medication regimen is scheduled to end or was discontinued.',
    `medication_start_date` DATE COMMENT 'Date the medication regimen began.',
    `notes` STRING COMMENT 'Additional free‑form information relevant to the enrollment.',
    `program_tier` STRING COMMENT 'Tier level indicating intensity of services provided to the patient.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `program_type` STRING COMMENT 'Type of behavioral health program; for OTP this is typically Opioid Treatment Program.',
    `referral_source` STRING COMMENT 'Origin of the referral that led to enrollment.. Valid values are `self|provider|court|ED|other`',
    `risk_level` STRING COMMENT 'Clinical risk classification for the patient during enrollment.. Valid values are `low|medium|high`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `urine_test_required` BOOLEAN COMMENT 'Indicates whether routine urine drug testing is required for the patient.',
    `urine_test_schedule` STRING COMMENT 'Frequency of required urine drug tests.. Valid values are `weekly|biweekly|monthly|none`',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_behavioral_health_otp_enrollment PRIMARY KEY(`behavioral_health_otp_enrollment_id`)
) COMMENT 'Enrollment record for a patient entering an Opioid Treatment Program, including eligibility criteria, enrollment date, program tier, and consent status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` (
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Primary key for behavioral_health_crisis_episode',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Crisis interventions (IM haloperidol, lorazepam, ketamine) require tracking administered medications for patient safety, drug interaction checks, and billing. Emergency psych medication administration',
    `behavioral_employee_id` BIGINT COMMENT 'Identifier of the user who created the record.',
    `cfr42_consent_id` BIGINT COMMENT 'Reference to the 42 CFR Part 2 consent record linked to this episode.',
    `care_site_id` BIGINT COMMENT 'Identifier of the location/facility where the crisis occurred.',
    `clinician_id` BIGINT COMMENT 'Identifier of the primary provider who managed the crisis.',
    `crisis_episode_id` BIGINT COMMENT 'Unique identifier for the crisis episode record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Crisis interventions must link to the underlying clinical diagnosis (e.g., MDD with suicidal ideation) for continuity of care, crisis recurrence analysis, and state-mandated crisis reporting by diagno',
    `emergency_contact_id` BIGINT COMMENT 'Identifier of the emergency contact person for the patient.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified the record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient experiencing the crisis.',
    `prior_episode_crisis_episode_behavioral_health_crisis_episode_id` BIGINT COMMENT 'Reference to a prior related crisis episode, if any.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the crisis.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score derived from the assessment tool.',
    `assessment_tool_used` STRING COMMENT 'Standardized assessment tool employed (e.g., C-SSRS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `crisis_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the crisis episode ended or was resolved.',
    `crisis_outcome` STRING COMMENT 'Overall outcome of the crisis management.. Valid values are `stabilized|escalated|resolved|ongoing|other`',
    `crisis_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the crisis episode began.',
    `crisis_type` STRING COMMENT 'Categorization of the crisis event.. Valid values are `suicide_attempt|self_harm|psychotic_break|substance_intoxication|other`',
    `disposition` STRING COMMENT 'Outcome disposition after the crisis episode.. Valid values are `discharged|admitted|transferred|left_against_medical_advice|deceased|other`',
    `documentation_source` STRING COMMENT 'Source system or method used to capture the episode data.. Valid values are `EHR|Paper|Phone|Other`',
    `duration_minutes` STRING COMMENT 'Total duration of the crisis episode in minutes.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.',
    `episode_number` STRING COMMENT 'Human‑readable identifier assigned to the episode (e.g., EP‑2023‑0001).',
    `follow_up_date` DATE COMMENT 'Scheduled date for the follow‑up appointment.',
    `follow_up_plan` STRING COMMENT 'Planned follow‑up actions or appointments.',
    `intervention_type` STRING COMMENT 'Primary intervention applied during the crisis.. Valid values are `medication|psychotherapy|debrief|hospitalization|community_support|other`',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating if the episode contains highly sensitive information subject to additional access controls.',
    `is_repeat_episode` BOOLEAN COMMENT 'Indicates if this episode is a repeat occurrence for the same patient within 30 days.',
    `medication_administered` STRING COMMENT 'Medication(s) given during the episode (e.g., lorazepam).',
    `notes` STRING COMMENT 'Clinical notes documenting the episode.',
    `referral_destination` STRING COMMENT 'Name or code of the external service to which referral is made.',
    `referral_needed_flag` BOOLEAN COMMENT 'Indicates whether a referral to external services is required.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric risk assessment score (0‑100) indicating suicide risk.',
    `severity_level` STRING COMMENT 'Clinical severity rating assigned by provider.. Valid values are `low|moderate|high|critical`',
    `trigger_event` STRING COMMENT 'Description of the precipitating event or circumstance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_behavioral_health_crisis_episode PRIMARY KEY(`behavioral_health_crisis_episode_id`)
) COMMENT 'Event record of an acute behavioral health crisis encounter, capturing trigger, intervention type, disposition, and follow‑up plan.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` (
    `behavioral_health_cfr42_consent_id` BIGINT COMMENT 'Primary key for behavioral_health_cfr42_consent',
    `behavioral_employee_id` BIGINT COMMENT 'Identifier of the system user who initially entered the consent.',
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Reference to a crisis episode linked to the consent.',
    `behavioral_health_mat_treatment_id` BIGINT COMMENT 'Link to the MAT treatment episode tied to the consent.',
    `behavioral_health_otp_enrollment_id` BIGINT COMMENT 'Reference to the OTP enrollment record associated with the consent.',
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Link to the psychiatric assessment associated with this consent.',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Link to the SUD episode for which the consent applies.',
    `cfr42_consent_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each 42 CFR Part 2 consent record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the provider who obtained or recorded the consent.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: 42 CFR Part 2 consents must be registered in the enterprise consent registry for unified patient rights management, HIPAA accounting of disclosures, and consent expiration tracking across all consent ',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the consent.',
    `hie_participation_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_participation. Business justification: 42 CFR Part 2 requires patient consent to specify which HIE network may receive SUD data. Compliance audits must trace consent-to-HIE-network authorization for lawful electronic disclosure.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient to whom the consent applies.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: 42 CFR Part 2 mandates separate written consent for research use of SUD records. Linking consent to the specific study satisfies federal regulatory audit requirements and enables compliance verificati',
    `consent_date` DATE COMMENT 'Date on which the patient signed or otherwise gave the consent.',
    `consent_notes` STRING COMMENT 'Additional free‑text comments or conditions attached to the consent.',
    `consent_number` STRING COMMENT 'Human‑readable business identifier assigned to the consent (e.g., CONS‑2024‑000123).',
    `consent_scope` STRING COMMENT 'Narrative description of the data, services, and contexts covered by the consent.',
    `consent_status` STRING COMMENT 'Overall lifecycle status of the consent record.. Valid values are `pending|active|revoked|expired`',
    `consent_type` STRING COMMENT 'Classification of the consent indicating the breadth of data sharing permitted.. Valid values are `full|partial|withdrawn|restricted|emergency|research`',
    `consent_version` STRING COMMENT 'Monotonically increasing version number for the consent record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days the consent record must be retained per policy.',
    `effective_from` DATE COMMENT 'First date the consent becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date on which the consent expires or is no longer valid (null if open‑ended).',
    `jurisdiction` STRING COMMENT 'State or jurisdiction governing the consent, required for 42 CFR Part 2 compliance.',
    `legal_basis` STRING COMMENT 'Legal justification for the consent under applicable law.. Valid values are `patient_authorization|court_order|public_health|research`',
    `part2_disclosure_allowed` BOOLEAN COMMENT 'Flag indicating whether the consent permits disclosure of the protected information.',
    `part2_disclosure_date` DATE COMMENT 'Date when a disclosure was made under the consent, if applicable.',
    `part2_exemptions` STRING COMMENT 'Narrative description of any statutory exemptions applicable to the consent.',
    `part2_section` STRING COMMENT 'Specific Part 2 regulatory section governing this consent.. Valid values are `section_1|section_2|section_3`',
    `patient_mrn` STRING COMMENT 'Medical Record Number used by the health system to identify the patient.',
    `provider_npi` STRING COMMENT 'Standard NPI of the provider associated with the consent.',
    `retention_expiration_date` DATE COMMENT 'Calculated date when the consent record may be safely purged.',
    `revocation_date` DATE COMMENT 'Date on which the consent was revoked, if applicable.',
    `revocation_status` STRING COMMENT 'Current revocation state of the consent.. Valid values are `active|revoked|expired|suspended`',
    `signature_method` STRING COMMENT 'Method used to capture the patient’s signature for the consent.. Valid values are `electronic|written|verbal`',
    `signature_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the signature was recorded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    CONSTRAINT pk_behavioral_health_cfr42_consent PRIMARY KEY(`behavioral_health_cfr42_consent_id`)
) COMMENT 'Patient consent record meeting 42 CFR Part 2 requirements, storing consent date, scope, revocation status, and linkage to behavioral health treatment records.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` (
    `cfr42_consent_workflow_id` BIGINT COMMENT 'Unique surrogate key for the consent workflow record.',
    `audit_id` BIGINT COMMENT 'Reference to the audit trail record for this consent.',
    `behavioral_health_cfr42_consent_id` BIGINT COMMENT 'description',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the consent record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient to whom the consent applies.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider responsible for the consent process.',
    `primary_employee_id` BIGINT COMMENT 'Identifier of the user who last updated the consent record.',
    `primary_mpi_record_id` BIGINT COMMENT 'Identifier of the legal guardian if the patient is a minor or incapacitated.',
    `authorized_entities` STRING COMMENT 'Comma-separated list of entities authorized to receive the information under this consent.',
    `cfr42_consent_workflow_status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `draft|active|revoked|expired|pending`',
    `consent_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent was approved by the patient or authorized representative.',
    `consent_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was initially created.',
    `consent_document_url` STRING COMMENT 'Link to the stored consent document.',
    `consent_form_version` STRING COMMENT 'Version of the consent form template used.',
    `consent_language` STRING COMMENT 'Language in which the consent was provided.',
    `consent_notes` STRING COMMENT 'Additional notes or comments related to the consent.',
    `consent_revocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent was revoked, if applicable.',
    `consent_scope` STRING COMMENT 'Scope of the consent indicating permissible uses of the information.. Valid values are `treatment|research|payment|operations`',
    `consent_type` STRING COMMENT 'Classifies the type of consent, e.g., 42 CFR Part 2 specific, general, or research consent.. Valid values are `42_cfr_part2|general|research`',
    `consent_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `consent_version` STRING COMMENT 'Version identifier for the consent document, supporting version control.',
    `consent_workflow_number` STRING COMMENT 'Business identifier for the consent workflow, often used in external communications.',
    `disclosure_restriction` STRING COMMENT 'Level of restriction on disclosures under the consent.. Valid values are `full|partial|none`',
    `effective_from` DATE COMMENT 'Date when the consent becomes effective.',
    `effective_until` DATE COMMENT 'Date when the consent expires, if applicable.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating if the consent contains confidential information requiring extra handling.',
    `is_emergency_consent` BOOLEAN COMMENT 'Indicates if the consent was obtained under emergency conditions.',
    `is_revoked_by_provider` BOOLEAN COMMENT 'Indicates if the provider revoked the consent.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next consent review.',
    `purpose_of_use` STRING COMMENT 'Intended purpose for which the information may be used.. Valid values are `treatment|research|payment|operations`',
    `retention_period_days` STRING COMMENT 'Number of days the consent record must be retained per regulatory policy.',
    `review_required` BOOLEAN COMMENT 'Indicates whether the consent requires periodic review.',
    `revocation_reason` STRING COMMENT 'Reason provided for revoking the consent.',
    `signature_method` STRING COMMENT 'Method used to capture the patient’s signature.. Valid values are `electronic|paper|verbal`',
    `signed_by` STRING COMMENT 'Name or identifier of the individual who signed the consent.',
    `signed_date` DATE COMMENT 'Date when the consent was signed.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient to whom the consent applies.',
    `provider_id` BIGINT COMMENT 'Identifier of the provider responsible for the consent process.',
    `status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `draft|active|revoked|expired|pending`',
    `audit_trail_id` BIGINT COMMENT 'Reference to the audit trail record for this consent.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who created the consent record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the user who last updated the consent record.',
    `legal_guardian_id` BIGINT COMMENT 'Identifier of the legal guardian if the patient is a minor or incapacitated.',
    CONSTRAINT pk_cfr42_consent_workflow PRIMARY KEY(`cfr42_consent_workflow_id`)
) COMMENT 'Configuration of the step‑by‑step consent workflow for 42 CFR Part 2, defining required approvals, notifications, and audit checkpoints.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` (
    `therapy_session_id` BIGINT COMMENT 'Unique surrogate key for each therapy session record.',
    `behavioral_health_cfr42_consent_id` BIGINT COMMENT 'Reference to the 42 CFR Part 2 consent record governing the session.',
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.behavioral_health_crisis_episode. Business justification: Crisis episodes frequently trigger follow-up therapy sessions as part of the clinical workflow. The crisis_episode table has follow_up_plan and follow_up_date fields indicating follow-up activities. A',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: Therapy sessions (individual or group) are a key component of SUD treatment. Linking therapy_session to sud_episode allows tracking which therapy sessions occurred within a specific substance use diso',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: Therapy sessions execute care plan goals; payer utilization review requires documentation that each session aligns with the authorized treatment/care plan for continued coverage approval.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or virtual location where the session occurred.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry.BIGINT surrogate key for clean keying. Business justification: Automated charge capture requires mapping therapy sessions to CDM entries for correct pricing. Charge posting workflows look up CDM to determine gross charge amount, revenue code, and CPT for the sess',
    `clinician_id` BIGINT COMMENT 'Identifier of the therapist who delivered the session.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Therapy session claims require ICD diagnosis codes for medical necessity justification. Payers deny claims without valid diagnosis-to-procedure pairing. Essential for CMS behavioral health quality rep',
    `group_session_id` BIGINT COMMENT 'Identifier linking to the parent group session record, if applicable.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient receiving the therapy session.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the record.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Therapy sessions address specific problems on the patients problem list; medical necessity documentation and utilization review require linking sessions to the clinical problem being treated.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Therapy sessions bill under CPT 90832/90834/90837/90847. Linking to standardized CPT enables automated charge capture, fee schedule lookups, and correct claim generation.',
    `prom_response_id` BIGINT COMMENT 'Foreign key linking to digital_health.prom_response. Business justification: Therapists administer digital PROMs pre/post-session for measurement-based care. The outcome_measure_score on therapy_session derives from a specific PROM response; linking enables treatment effective',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Therapy sessions are booked as scheduling appointments. Linking enables no-show tracking, appointment utilization reporting, waitlist-to-session conversion metrics, and billing reconciliation between ',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Psychotherapy efficacy trials (CBT, DBT studies) require linking each therapy session to the subjects research enrollment for visit window compliance, protocol adherence tracking, and research vs cli',
    `device_id` BIGINT COMMENT 'Identifier of the device used to capture the telehealth session (e.g., tablet serial).',
    `therapy_employee_id` BIGINT COMMENT 'Identifier of the system user who created the record.',
    `therapy_order_id` BIGINT COMMENT 'Foreign key linking to order.therapy_order. Business justification: Therapy sessions fulfill therapy orders. Authorization utilization tracking, billing reconciliation, and sessions-remaining calculations require linking each session to its originating therapy order.',
    `utilization_review_id` BIGINT COMMENT 'Foreign key linking to insurance.utilization_review. Business justification: Payers authorize therapy in session blocks (e.g., 12 sessions). Each session must reference the UR authorization for claims submission and to track when re-authorization is needed.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Inpatient therapy sessions must link to the hospital encounter for facility fee billing, length-of-stay clinical justification, and discharge planning documentation. Follows same pattern as mat_treatm',
    `billing_code` STRING COMMENT 'HCPCS code used for billing the therapy session.',
    `charge_adjustment` DECIMAL(18,2) COMMENT 'Adjustments (discounts, write‑offs, insurance adjustments) applied to the gross charge.',
    `charge_amount_gross` DECIMAL(18,2) COMMENT 'Total charge for the session before any adjustments.',
    `charge_amount_net` DECIMAL(18,2) COMMENT 'Final amount payable after adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the therapy session record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis associated with the session, using ICD‑10 coding.',
    `duration_minutes` STRING COMMENT 'Length of the session measured in whole minutes.',
    `follow_up_date` DATE COMMENT 'Scheduled date for the required follow‑up session, if any.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up appointment is required after this session.',
    `is_group_session` BOOLEAN COMMENT 'True if the session involved multiple patients simultaneously.',
    `is_telehealth` BOOLEAN COMMENT 'Indicates whether the session was delivered via telehealth.',
    `modality` STRING COMMENT 'Mode of delivery for the session (in‑person individual, group, or telehealth).. Valid values are `individual|group|telehealth`',
    `notes` STRING COMMENT 'Free‑text clinical documentation captured during the session.',
    `outcome_measure_score` DECIMAL(18,2) COMMENT 'Standardized numeric score reflecting patient outcome for the session (e.g., PHQ‑9 total).',
    `patient_feedback` STRING COMMENT 'Free‑text feedback provided by the patient after the session.',
    `procedure_code` STRING COMMENT 'CPT code representing the therapeutic procedure performed.',
    `risk_level` STRING COMMENT 'Clinical risk classification for the session (e.g., suicidal risk).. Valid values are `low|medium|high`',
    `session_date` DATE COMMENT 'Calendar date on which the therapy session took place.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Exact end time of the therapy session.',
    `session_number` STRING COMMENT 'Human‑readable identifier assigned to the therapy session (e.g., TS‑20231015‑001).',
    `session_outcome` STRING COMMENT 'Clinician‑recorded overall outcome of the session.. Valid values are `improved|no_change|worsened|unknown`',
    `session_start_timestamp` TIMESTAMP COMMENT 'Exact start time of the therapy session.',
    `session_status` STRING COMMENT 'Current lifecycle status of the therapy session.. Valid values are `scheduled|completed|cancelled|no_show|in_progress`',
    `session_type` STRING COMMENT 'High‑level classification of the session purpose.. Valid values are `assessment|therapy|group|crisis`',
    `therapist_notes` STRING COMMENT 'Additional observations recorded by the therapist.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the therapy session record.',
    `video_platform` STRING COMMENT 'Name of the video conferencing platform used for telehealth sessions.. Valid values are `Zoom|Teams|Webex|Other`',
    `patient_id` BIGINT COMMENT 'Identifier of the patient receiving the therapy session.',
    `therapist_id` BIGINT COMMENT 'Identifier of the therapist who delivered the session.',
    `location_id` BIGINT COMMENT 'Identifier of the facility or virtual location where the session occurred.',
    `consent_id` BIGINT COMMENT 'Reference to the 42 CFR Part 2 consent record governing the session.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who created the record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the system user who last modified the record.',
    CONSTRAINT pk_therapy_session PRIMARY KEY(`therapy_session_id`)
) COMMENT 'Record of an individual behavioral health therapy session, capturing therapist, modality, duration, session notes, and outcome measures.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_behavioral_health_crisis_episode_id` FOREIGN KEY (`behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_previous_assessment_psychiatric_assessment_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`previous_assessment_psychiatric_assessment_behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_psychiatric_assessment_id` FOREIGN KEY (`psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment`(`psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_cfr42_consent_id` FOREIGN KEY (`cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent`(`cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_sud_episode_id` FOREIGN KEY (`sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`sud_episode`(`sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_behavioral_health_otp_enrollment_id` FOREIGN KEY (`behavioral_health_otp_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment`(`behavioral_health_otp_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_cfr42_consent_id` FOREIGN KEY (`cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent`(`cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_mat_treatment_id` FOREIGN KEY (`mat_treatment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment`(`mat_treatment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_otp_enrollment_id` FOREIGN KEY (`otp_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment`(`otp_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_cfr42_consent_id` FOREIGN KEY (`cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent`(`cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_crisis_episode_id` FOREIGN KEY (`crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode`(`crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_prior_episode_crisis_episode_behavioral_health_crisis_episode_id` FOREIGN KEY (`prior_episode_crisis_episode_behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_behavioral_health_crisis_episode_id` FOREIGN KEY (`behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_behavioral_health_mat_treatment_id` FOREIGN KEY (`behavioral_health_mat_treatment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment`(`behavioral_health_mat_treatment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_behavioral_health_otp_enrollment_id` FOREIGN KEY (`behavioral_health_otp_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment`(`behavioral_health_otp_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_cfr42_consent_id` FOREIGN KEY (`cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent`(`cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_behavioral_health_cfr42_consent_id` FOREIGN KEY (`behavioral_health_cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent`(`behavioral_health_cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_behavioral_health_cfr42_consent_id` FOREIGN KEY (`behavioral_health_cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent`(`behavioral_health_cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_behavioral_health_crisis_episode_id` FOREIGN KEY (`behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_group_session_id` FOREIGN KEY (`group_session_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`therapy_session`(`therapy_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`behavioral_health` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `healthcare_ecm_v1`.`behavioral_health` SET TAGS ('dbx_domain' = 'behavioral_health');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'psychiatric_assessment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `affect_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `affect_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `capacity_to_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `capacity_to_consent` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `clinical_formulation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `clinical_formulation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cognitive_function_assessment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cognitive_function_assessment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `dsm5_diagnostic_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `dsm5_diagnostic_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `family_psychiatric_history` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `family_psychiatric_history` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `follow_up_plan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `follow_up_plan` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `gaf_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `gaf_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `history_of_present_illness` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `history_of_present_illness` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `homicidal_ideation_present` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `homicidal_ideation_present` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `insight_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `insight_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `involuntary_hold_indicated` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `involuntary_hold_indicated` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `judgment_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `judgment_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `legal_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `legal_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `mental_status_exam` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `mental_status_exam` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `mood_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `mood_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `phq9_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `phq9_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `psychiatric_history_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `psychiatric_history_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `psychosis_symptoms_present` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `psychosis_symptoms_present` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `recommended_level_of_care` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `recommended_level_of_care` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `substance_use_history` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `substance_use_history` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_present` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicidal_ideation_present` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicide_risk_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `suicide_risk_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `violence_risk_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `violence_risk_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|pending_review');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes (ICD-10)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_business_glossary_term' = 'Assessment Findings');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `treatment_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Treatment Recommendations');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `substance_use_disorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `medication_allergy_flag` SET TAGS ('dbx_business_glossary_term' = 'Medication Allergy Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `previous_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Assessment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_modality` SET TAGS ('dbx_business_glossary_term' = 'Assessment Modality');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_modality` SET TAGS ('dbx_value_regex' = 'in_person|telehealth|phone|video');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `comorbid_conditions` SET TAGS ('dbx_business_glossary_term' = 'Comorbid Conditions');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_source` SET TAGS ('dbx_business_glossary_term' = 'Assessment Source');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_source` SET TAGS ('dbx_value_regex' = 'referral|self|screening|emergency');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (CPT/HCPCS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_business_glossary_term' = 'Private Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'stable|improved|deteriorated|no_change');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Is Telehealth');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `language_used` SET TAGS ('dbx_business_glossary_term' = 'Language Used');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_age_at_assessment` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race/Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_employment_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Employment Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_employment_status` SET TAGS ('dbx_value_regex' = 'employed|unemployed|student|retired|disabled|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Patient Income Bracket');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `patient_income_bracket` SET TAGS ('dbx_value_regex' = 'low|middle|high|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `data_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `audit_user_id` SET TAGS ('dbx_business_glossary_term' = 'Audit User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `audit_action` SET TAGS ('dbx_business_glossary_term' = 'Audit Action');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `audit_action` SET TAGS ('dbx_value_regex' = 'create|update|delete|review');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` SET TAGS ('dbx_subdomain' = 'treatment_programs');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'sud_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `abstinence_days_at_discharge` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `abstinence_days_at_discharge` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `admission_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `admission_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `age_at_first_use` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `age_at_first_use` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `asam_level_of_care` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `asam_level_of_care` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `co_occurring_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `co_occurring_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `co_occurring_mental_health_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `co_occurring_mental_health_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `crisis_episode_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `crisis_episode_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `discharge_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `discharge_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `dsm5_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `frequency_of_use` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `frequency_of_use` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `iv_drug_use_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `iv_drug_use_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `legal_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `legal_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mat_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mat_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mat_medication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mat_medication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `narcan_administered_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `narcan_administered_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `otp_enrollment_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `otp_enrollment_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `outcome_at_discharge` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `outcome_at_discharge` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `overdose_history_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `overdose_history_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `pregnancy_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `pregnancy_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `primary_route_of_administration` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `primary_route_of_administration` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `primary_substance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `primary_substance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `prior_treatment_episodes_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `prior_treatment_episodes_count` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `secondary_substance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `secondary_substance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `severity_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `severity_level` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `tertiary_substance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `tertiary_substance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_modality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_modality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_plan_goal` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_plan_goal` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_setting` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Episode Start Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Episode End Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Episode Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|completed|terminated|paused|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `secondary_substances` SET TAGS ('dbx_business_glossary_term' = 'Secondary Substances');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `treatment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `primary_care_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `medication_assisted_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'MAT Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mat_start_date` SET TAGS ('dbx_business_glossary_term' = 'MAT Start Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `mat_end_date` SET TAGS ('dbx_business_glossary_term' = 'MAT End Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `relapse_flag` SET TAGS ('dbx_business_glossary_term' = 'Relapse Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `relapse_date` SET TAGS ('dbx_business_glossary_term' = 'Relapse Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Episode Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `insurance_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payer ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `program_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|intensive_outpatient|residential');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `total_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Visits');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `total_days_of_care` SET TAGS ('dbx_business_glossary_term' = 'Total Days of Care');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `urine_drug_screen_flag` SET TAGS ('dbx_business_glossary_term' = 'Urine Drug Screen Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `urine_drug_screen_result` SET TAGS ('dbx_business_glossary_term' = 'Urine Drug Screen Result');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient MRN');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_dob` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_dob` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_dob` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` SET TAGS ('dbx_subdomain' = 'treatment_programs');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'mat_treatment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dosage_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `dosage_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `end_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `end_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `induction_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `induction_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `last_dose_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `last_dose_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `last_uds_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `last_uds_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `last_uds_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `last_uds_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `mat_treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `next_scheduled_visit_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `next_scheduled_visit_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `peak_dosage_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `peak_dosage_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `pregnancy_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `pregnancy_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `primary_substance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `primary_substance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prior_treatment_episodes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prior_treatment_episodes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `start_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `start_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `taper_start_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `taper_start_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_phase` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_plan_goal` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_plan_goal` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_setting` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_setting` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Number');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `medication_id` SET TAGS ('dbx_business_glossary_term' = 'Medication ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `administration_route` SET TAGS ('dbx_business_glossary_term' = 'Administration Route');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `administration_route` SET TAGS ('dbx_value_regex' = 'oral|intravenous|intramuscular|subcutaneous|inhalation|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `administration_frequency` SET TAGS ('dbx_business_glossary_term' = 'Administration Frequency');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `administration_frequency` SET TAGS ('dbx_value_regex' = 'once_daily|twice_daily|weekly|monthly|as_needed|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber NPI');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|no_show');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `urine_test_result` SET TAGS ('dbx_business_glossary_term' = 'Urine Test Result');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `urine_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|not_tested|pending');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `urine_test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `urine_test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Treatment Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Description');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `refill_count` SET TAGS ('dbx_business_glossary_term' = 'Refill Count');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `next_scheduled_dose_datetime` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Dose DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `treatment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Delivery Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_value_regex' = 'zoom|teams|doxy|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `patient_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Given');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discharge_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discharge_status` SET TAGS ('dbx_value_regex' = 'discharged|transferred|deceased|ongoing');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` SET TAGS ('dbx_subdomain' = 'treatment_programs');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `otp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'otp_enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `admission_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `admission_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `court_order_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `court_order_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `current_dose_mg` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `current_dose_mg` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `initial_dose_mg` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `initial_dose_mg` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `last_drug_screen_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `last_drug_screen_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `last_drug_screen_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `last_drug_screen_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `pregnancy_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `pregnancy_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `primary_substance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `primary_substance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `prior_treatment_episodes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `prior_treatment_episodes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `years_of_opioid_use` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `years_of_opioid_use` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (PT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier (PT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End Date (EED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (AED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status (ELS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `eligibility_check_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Date (ECD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reason (ER)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|revoked');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version (CV)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `consent_document_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document ID (CDID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `referring_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider ID (RPI)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `intake_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Assessment ID (IAID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (PDC)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `substance_use_disorder_type` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder Type (SUDT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `substance_use_disorder_type` SET TAGS ('dbx_value_regex' = 'opioid|alcohol|cocaine|methamphetamine|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_assigned` SET TAGS ('dbx_business_glossary_term' = 'Medication Assigned (MA)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_assigned` SET TAGS ('dbx_value_regex' = 'methadone|buprenorphine|naltrexone|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_dosage_mg` SET TAGS ('dbx_business_glossary_term' = 'Medication Dosage (mg) (MD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_start_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Start Date (MSD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `medication_end_date` SET TAGS ('dbx_business_glossary_term' = 'Medication End Date (MED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `urine_test_required` SET TAGS ('dbx_business_glossary_term' = 'Urine Test Required (UTR)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `urine_test_schedule` SET TAGS ('dbx_business_glossary_term' = 'Urine Test Schedule (UTS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `urine_test_schedule` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `last_urine_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Urine Test Date (LUTD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `case_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager ID (CMID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `case_manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Notes (CMN)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `hipaa_retention_date` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Date (HRD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `treatment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan ID (TPID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `insurance_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payer ID (IPID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type (CT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status (BS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'pending|billed|paid|denied|reversed');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `financial_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Financial Responsibility (FR)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `financial_responsibility` SET TAGS ('dbx_value_regex' = 'patient|payer|shared');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'crisis_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `discharge_plan_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `discharge_plan_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `intervention_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `intervention_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_complaint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `presenting_complaint` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `secondary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `secondary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `substance_involved_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `substance_involved_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `substance_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `substance_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `suicide_risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `suicide_risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `trigger_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `trigger_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `violence_risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `violence_risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Description');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'medication|psychotherapy|debrief|hospitalization|community_support|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `crisis_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crisis Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `crisis_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crisis End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `follow_up_plan` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Plan');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `medication_administered` SET TAGS ('dbx_business_glossary_term' = 'Medication Administered');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `consent_42cfr_part2_id` SET TAGS ('dbx_business_glossary_term' = '42 CFR Part 2 Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `referral_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Needed Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `crisis_outcome` SET TAGS ('dbx_business_glossary_term' = 'Crisis Outcome');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `crisis_outcome` SET TAGS ('dbx_value_regex' = 'stabilized|escalated|resolved|ongoing|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `assessment_tool_used` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Used');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `is_repeat_episode` SET TAGS ('dbx_business_glossary_term' = 'Repeat Episode Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `prior_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `documentation_source` SET TAGS ('dbx_business_glossary_term' = 'Documentation Source');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `documentation_source` SET TAGS ('dbx_value_regex' = 'EHR|Paper|Phone|Other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` SET TAGS ('dbx_subdomain' = 'regulatory_consent');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'cfr42_consent Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `information_disclosed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `information_disclosed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `substance_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `substance_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `treatment_episode_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `treatment_episode_reference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|suspended');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'patient_authorization|court_order|public_health|research');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Medication‑Assisted Treatment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `otp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Opioid Treatment Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `part2_section` SET TAGS ('dbx_business_glossary_term' = '42 CFR Part 2 Section');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `part2_section` SET TAGS ('dbx_value_regex' = 'section_1|section_2|section_3');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `part2_exemptions` SET TAGS ('dbx_business_glossary_term' = 'Part 2 Exemptions');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `part2_disclosure_allowed` SET TAGS ('dbx_business_glossary_term' = 'Part 2 Disclosure Allowed');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ALTER COLUMN `part2_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Part 2 Disclosure Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'behavioral_health_psychiatric_assessment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `previous_assessment_psychiatric_assessment_behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Assessment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `previous_assessment_psychiatric_assessment_behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `previous_assessment_psychiatric_assessment_behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `prom_response_id` SET TAGS ('dbx_business_glossary_term' = 'Prom Response Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_business_glossary_term' = 'Assessment Findings');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_findings` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_modality` SET TAGS ('dbx_business_glossary_term' = 'Assessment Modality');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_modality` SET TAGS ('dbx_value_regex' = 'in_person|telehealth|phone|video');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number (AN)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'stable|improved|deteriorated|no_change');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_source` SET TAGS ('dbx_business_glossary_term' = 'Assessment Source');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_source` SET TAGS ('dbx_value_regex' = 'referral|self|screening|emergency');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `audit_action` SET TAGS ('dbx_business_glossary_term' = 'Audit Action');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `audit_action` SET TAGS ('dbx_value_regex' = 'create|update|delete|review');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|pending_review');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `behavioral_health_psychiatric_assessment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (CPT/HCPCS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `comorbid_conditions` SET TAGS ('dbx_business_glossary_term' = 'Comorbid Conditions');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `data_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes (ICD-10)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Is Telehealth');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `language_used` SET TAGS ('dbx_business_glossary_term' = 'Language Used');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `medication_allergy_flag` SET TAGS ('dbx_business_glossary_term' = 'Medication Allergy Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_business_glossary_term' = 'Private Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `notes_private` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_age_at_assessment` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_age_at_assessment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_age_at_assessment` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_age_at_assessment` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_employment_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Employment Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_employment_status` SET TAGS ('dbx_value_regex' = 'employed|unemployed|student|retired|disabled|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Patient Income Bracket');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_income_bracket` SET TAGS ('dbx_value_regex' = 'low|middle|high|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race/Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD-10)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `substance_use_disorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `treatment_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Treatment Recommendations');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `treatment_recommendations` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `treatment_recommendations` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` SET TAGS ('dbx_subdomain' = 'treatment_programs');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'behavioral_health_sud_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `clinical_ai_care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payer ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Mat Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `sdoh_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Sdoh Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Treating Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_status` SET TAGS ('dbx_business_glossary_term' = 'Episode Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_status` SET TAGS ('dbx_value_regex' = 'active|completed|terminated|paused|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `behavioral_health_sud_episode_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `discharge_reason` SET TAGS ('dbx_business_glossary_term' = 'Discharge Reason');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Episode End Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_business_glossary_term' = 'Episode Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_value_regex' = 'initial|continuation|follow_up|maintenance');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mat_end_date` SET TAGS ('dbx_business_glossary_term' = 'MAT End Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mat_medication` SET TAGS ('dbx_business_glossary_term' = 'MAT Medication');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `mat_start_date` SET TAGS ('dbx_business_glossary_term' = 'MAT Start Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `medication_assisted_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'MAT Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `medication_assisted_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `medication_assisted_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Episode Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `primary_substance` SET TAGS ('dbx_business_glossary_term' = 'Primary Substance');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `program_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|intensive_outpatient|residential');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `relapse_date` SET TAGS ('dbx_business_glossary_term' = 'Relapse Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `relapse_flag` SET TAGS ('dbx_business_glossary_term' = 'Relapse Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `secondary_substances` SET TAGS ('dbx_business_glossary_term' = 'Secondary Substances');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|extreme');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Episode Start Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `total_days_of_care` SET TAGS ('dbx_business_glossary_term' = 'Total Days of Care');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `total_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Visits');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ALTER COLUMN `urine_drug_screen_flag` SET TAGS ('dbx_business_glossary_term' = 'Urine Drug Screen Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` SET TAGS ('dbx_subdomain' = 'treatment_programs');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'behavioral_health_mat_treatment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Otp Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Medication ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `laboratory_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Urine Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Assisted Treatment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `mat_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Dea Registration Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `utilization_review_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Review Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `administration_frequency` SET TAGS ('dbx_business_glossary_term' = 'Administration Frequency');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `administration_frequency` SET TAGS ('dbx_value_regex' = 'once_daily|twice_daily|weekly|monthly|as_needed|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `administration_route` SET TAGS ('dbx_business_glossary_term' = 'Administration Route');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `administration_route` SET TAGS ('dbx_value_regex' = 'oral|intravenous|intramuscular|subcutaneous|inhalation|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Description');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `bigint_surrogate_key_for_clean_keying` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `billing_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `discharge_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `discharge_status` SET TAGS ('dbx_value_regex' = 'discharged|transferred|deceased|ongoing');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `dosage_amount` SET TAGS ('dbx_business_glossary_term' = 'Dosage Amount');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `dosage_unit` SET TAGS ('dbx_business_glossary_term' = 'Dosage Unit');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `dosage_unit` SET TAGS ('dbx_value_regex' = 'mg|ml|units|g|mcg|tablet');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Treatment Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Delivery Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `next_scheduled_dose_datetime` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Dose DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `patient_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Given');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber NPI');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `refill_count` SET TAGS ('dbx_business_glossary_term' = 'Refill Count');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start DateTime');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_value_regex' = 'zoom|teams|doxy|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Number');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|no_show');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `treatment_type` SET TAGS ('dbx_value_regex' = 'medication_assisted|counseling|group_therapy|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` SET TAGS ('dbx_subdomain' = 'treatment_programs');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'behavioral_health_otp_enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Assessment ID (IAID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan ID (TPID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider ID (RPI)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document ID (CDID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager ID (CMID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `otp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Opioid Treatment Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Otp Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `payer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payer ID (IPID)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (AED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status (BS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'pending|billed|paid|denied|reversed');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `case_manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Notes (CMN)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date (CD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|revoked');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version (CV)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type (CT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (PDC)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date (DD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `discharge_reason` SET TAGS ('dbx_business_glossary_term' = 'Discharge Reason (DR)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `eligibility_check_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Date (ECD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reason (ER)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status (ELS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENR)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ES)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|completed|withdrawn|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End Date (EED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `financial_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Financial Responsibility (FR)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `financial_responsibility` SET TAGS ('dbx_value_regex' = 'patient|payer|shared');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `hipaa_retention_date` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Date (HRD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `last_urine_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Urine Test Date (LUTD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `medication_assigned` SET TAGS ('dbx_business_glossary_term' = 'Medication Assigned (MA)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `medication_assigned` SET TAGS ('dbx_value_regex' = 'methadone|buprenorphine|naltrexone|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `medication_dosage_mg` SET TAGS ('dbx_business_glossary_term' = 'Medication Dosage (mg) (MD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `medication_end_date` SET TAGS ('dbx_business_glossary_term' = 'Medication End Date (MED)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `medication_start_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Start Date (MSD)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (GN)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier (PT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `program_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (PT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source (RS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'self|provider|court|ED|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `urine_test_required` SET TAGS ('dbx_business_glossary_term' = 'Urine Test Required (UTR)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `urine_test_schedule` SET TAGS ('dbx_business_glossary_term' = 'Urine Test Schedule (UTS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `urine_test_schedule` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'behavioral_health_crisis_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Administered Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = '42 CFR Part 2 Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `prior_episode_crisis_episode_behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `prior_episode_crisis_episode_behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `prior_episode_crisis_episode_behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `assessment_tool_used` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Used');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crisis End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_outcome` SET TAGS ('dbx_business_glossary_term' = 'Crisis Outcome');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_outcome` SET TAGS ('dbx_value_regex' = 'stabilized|escalated|resolved|ongoing|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crisis Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_type` SET TAGS ('dbx_business_glossary_term' = 'Crisis Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `crisis_type` SET TAGS ('dbx_value_regex' = 'suicide_attempt|self_harm|psychotic_break|substance_intoxication|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'discharged|admitted|transferred|left_against_medical_advice|deceased|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `documentation_source` SET TAGS ('dbx_business_glossary_term' = 'Documentation Source');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `documentation_source` SET TAGS ('dbx_value_regex' = 'EHR|Paper|Phone|Other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Crisis Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode Number');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `follow_up_plan` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Plan');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'medication|psychotherapy|debrief|hospitalization|community_support|other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_confidential` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `is_repeat_episode` SET TAGS ('dbx_business_glossary_term' = 'Repeat Episode Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `medication_administered` SET TAGS ('dbx_business_glossary_term' = 'Medication Administered');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `referral_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Needed Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Description');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` SET TAGS ('dbx_subdomain' = 'regulatory_consent');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'behavioral_health_cfr42_consent Identifier');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Medication‑Assisted Treatment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Opioid Treatment Program Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_otp_enrollment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `hie_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Participation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Number');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'pending|active|revoked|expired');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'full|partial|withdrawn|restricted|emergency|research');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'patient_authorization|court_order|public_health|research');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `part2_disclosure_allowed` SET TAGS ('dbx_business_glossary_term' = 'Part 2 Disclosure Allowed');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `part2_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Part 2 Disclosure Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `part2_exemptions` SET TAGS ('dbx_business_glossary_term' = 'Part 2 Exemptions');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `part2_section` SET TAGS ('dbx_business_glossary_term' = '42 CFR Part 2 Section');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `part2_section` SET TAGS ('dbx_value_regex' = 'section_1|section_2|section_3');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|suspended');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|written|verbal');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` SET TAGS ('dbx_subdomain' = 'regulatory_consent');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `cfr42_consent_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'CFR 42 Consent Workflow ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Guardian ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `primary_mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `authorized_entities` SET TAGS ('dbx_business_glossary_term' = 'Authorized Entities');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `cfr42_consent_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `cfr42_consent_workflow_status` SET TAGS ('dbx_value_regex' = 'draft|active|revoked|expired|pending');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Document URL');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'treatment|research|payment|operations');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = '42_cfr_part2|general|research');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `consent_workflow_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Workflow Number (Identifier)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `disclosure_restriction` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Restriction');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `disclosure_restriction` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `is_emergency_consent` SET TAGS ('dbx_business_glossary_term' = 'Emergency Consent Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `is_revoked_by_provider` SET TAGS ('dbx_business_glossary_term' = 'Provider Revoked Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `purpose_of_use` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Use');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `purpose_of_use` SET TAGS ('dbx_value_regex' = 'treatment|research|payment|operations');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `review_required` SET TAGS ('dbx_business_glossary_term' = 'Review Required');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|verbal');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|revoked|expired|pending');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `legal_guardian_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Guardian ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `legal_guardian_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ALTER COLUMN `legal_guardian_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapy_session_id` SET TAGS ('dbx_business_glossary_term' = 'Therapy Session ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `group_session_id` SET TAGS ('dbx_business_glossary_term' = 'Group Session ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `prom_response_id` SET TAGS ('dbx_business_glossary_term' = 'Prom Response Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Device ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapy_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapy_order_id` SET TAGS ('dbx_business_glossary_term' = 'Therapy Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `utilization_review_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Review Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (HCPCS)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `charge_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Charge Adjustment Amount');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `charge_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `charge_amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD‑10)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `is_group_session` SET TAGS ('dbx_business_glossary_term' = 'Group Session Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Flag');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `modality` SET TAGS ('dbx_business_glossary_term' = 'Therapy Modality');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `modality` SET TAGS ('dbx_value_regex' = 'individual|group|telehealth');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Session Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `outcome_measure_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure Score');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_feedback` SET TAGS ('dbx_business_glossary_term' = 'Patient Feedback');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_feedback` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_feedback` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_feedback` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_feedback` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_feedback` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT)');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_date` SET TAGS ('dbx_business_glossary_term' = 'Session Date');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Therapy Session Number');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_outcome` SET TAGS ('dbx_business_glossary_term' = 'Session Outcome');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_outcome` SET TAGS ('dbx_value_regex' = 'improved|no_change|worsened|unknown');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|no_show|in_progress');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'assessment|therapy|group|crisis');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_notes` SET TAGS ('dbx_business_glossary_term' = 'Therapist Notes');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `video_platform` SET TAGS ('dbx_business_glossary_term' = 'Video Platform');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `video_platform` SET TAGS ('dbx_value_regex' = 'Zoom|Teams|Webex|Other');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `therapist_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
