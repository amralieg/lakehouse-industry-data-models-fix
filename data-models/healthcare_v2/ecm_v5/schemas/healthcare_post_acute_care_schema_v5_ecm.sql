-- Schema for Domain: post_acute_care | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care` COMMENT 'Captures data for post-acute care services excluding skilled nursing facilities, home health, and hospice, supporting transition of care and outcome tracking.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` (
    `snf_stay_id` BIGINT COMMENT 'Primary key for snf_stay',
    `mpi_record_id` BIGINT COMMENT 'description',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: SNF stay is a type of post-acute episode. Linking to the master episode record connects this legacy stub table to the normalized model.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: A SNF stay occurs at a specific post-acute location. This enables location-level analytics for SNF stays including capacity planning and quality metrics.',
    `snf_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.snf. Business justification: A SNF stay occurs at a specific skilled nursing facility. This links the stay record to the facility where care was provided.',
    CONSTRAINT pk_snf_stay PRIMARY KEY(`snf_stay_id`)
) COMMENT 'Table for skilled nursing facility stays';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`home_health` (
    `home_health_id` BIGINT COMMENT 'Primary key for home_health',
    `mpi_record_id` BIGINT COMMENT 'description',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Home health is a type of post-acute episode. Linking to the master episode record connects this legacy stub table to the normalized model.',
    CONSTRAINT pk_home_health PRIMARY KEY(`home_health_id`)
) COMMENT 'Table for home health services';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` (
    `hospice_care_id` BIGINT COMMENT 'Primary key for hospice_care',
    `advance_directive_id` BIGINT COMMENT 'Foreign key linking to clinical.advance_directive. Business justification: CMS Hospice Conditions of Participation require verified advance directives at enrollment. Hospice admission workflows must reference the patients documented code status and end-of-life preferences.',
    `hospice_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.hospice. Business justification: Hospice care records are delivered within a specific hospice program. Links the care episode to the program entity.',
    `mpi_record_id` BIGINT COMMENT 'description',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Hospice care is a type of post-acute episode. Linking to the master episode record connects this legacy stub table to the normalized model.',
    CONSTRAINT pk_hospice_care PRIMARY KEY(`hospice_care_id`)
) COMMENT 'Table for hospice care episodes';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` (
    `home_health_episode_id` BIGINT COMMENT 'Primary key for home_health_episode',
    `home_health_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.home_health. Business justification: A home health episode belongs to a specific home health enrollment/service record. This establishes the parent-child relationship between the enrollment and its episodes.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Home health episode is a specialization of the master post-acute episode. Linking connects this stub to the normalized model.',
    CONSTRAINT pk_home_health_episode PRIMARY KEY(`home_health_episode_id`)
) COMMENT 'Home health service episodes';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` (
    `home_health_service_id` BIGINT COMMENT 'Primary key for home_health_service',
    `home_health_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.home_health_episode. Business justification: A home health service is delivered within a specific home health episode. Services are scheduled and tracked per episode.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Home health service records belong to a post-acute episode, enabling episode-level service aggregation.',
    `post_acute_service_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_service. Business justification: Home health service records should reference the service catalog for standardized service type identification.',
    CONSTRAINT pk_home_health_service PRIMARY KEY(`home_health_service_id`)
) COMMENT 'Table storing Home Health service records.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` (
    `hospice_enrollment_id` BIGINT COMMENT 'Primary key for hospice_enrollment',
    `hospice_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.hospice. Business justification: An enrollment is into a specific hospice program. The hospice entity represents the program/facility where the patient is enrolled.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Hospice enrollment represents entry into a hospice episode. Linking to the master episode connects enrollment tracking to the normalized model.',
    CONSTRAINT pk_hospice_enrollment PRIMARY KEY(`hospice_enrollment_id`)
) COMMENT 'Table storing hospice enrollment and outcomes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` (
    `hospice_episode_id` BIGINT COMMENT 'Primary key for hospice_episode',
    `hospice_enrollment_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.hospice_enrollment. Business justification: A hospice episode belongs to a specific hospice enrollment. Episodes are time-bounded care periods within the broader enrollment.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Hospice episode is a specialization of the master post-acute episode. Linking connects this stub to the normalized model.',
    CONSTRAINT pk_hospice_episode PRIMARY KEY(`hospice_episode_id`)
) COMMENT 'Table storing hospice care episodes';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` (
    `home_health_visit_id` BIGINT COMMENT 'Primary key for home_health_visit',
    `home_health_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.home_health_episode. Business justification: A home health visit occurs within a specific home health episode. Visits are the atomic service events within an episode timeframe.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Home health visits occur within a post-acute episode. Linking enables episode-level visit aggregation.',
    `service_delivery_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.service_delivery. Business justification: A home health visit is a specific instance of service delivery. Linking to service_delivery connects visit-level detail to the transactional service record.',
    CONSTRAINT pk_home_health_visit PRIMARY KEY(`home_health_visit_id`)
) COMMENT 'Table for home health visit records.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` (
    `snf_encounter_id` BIGINT COMMENT 'Primary key for snf_encounter',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: SNF encounters occur within a post-acute episode. Linking connects encounter-level data to the master episode.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: SNF encounters occur at a specific location. Linking to post_acute_location identifies the facility.',
    `snf_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.snf. Business justification: An SNF encounter occurs at a specific SNF. While snf_encounter has post_acute_location_id, a direct link to the SNF entity provides clearer facility-level attribution.',
    CONSTRAINT pk_snf_encounter PRIMARY KEY(`snf_encounter_id`)
) COMMENT 'Table for skilled nursing facility encounters.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` (
    `post_acute_episode_id` BIGINT COMMENT 'Unique surrogate key for the post‑acute care episode record.',
    `behavioral_health_crisis_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.crisis_episode. Business justification: Psychiatric crisis stabilization frequently results in post-acute placement (SNF, home health). State behavioral health authorities require tracking crisis-to-PAC transitions for outcome measurement a',
    `care_plan_id` BIGINT COMMENT 'Link to the structured care plan applied during the episode.',
    `care_site_id` BIGINT COMMENT 'Facility where the post‑acute care was delivered.',
    `care_team_id` BIGINT COMMENT 'Identifier of the multidisciplinary team assigned to the episode.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician primarily responsible for the episode.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: CMS Conditions of Participation require documented consent for post-acute admissions. Links episode to formal consent record, replacing denormalized consent_given/consent_date flags with proper FK to ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: Post-acute episodes require dedicated case managers for care coordination, utilization review, and payer communication. CMS Conditions of Participation mandate identifiable case management responsibil',
    `health_plan_id` BIGINT COMMENT 'Specific insurance plan covering the episode.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient receiving post‑acute care.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: CMS bundled payment models (BPCI-A) and readmission penalty programs require linking PAC episodes to the acute-care discharge diagnosis that triggered post-acute placement. Essential for episode-based',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: CMS Bundled Payments for Care Improvement (BPCI) requires linking post-acute episodes to the originating acute-care DRG for episode-based payment reconciliation and cost benchmarking.',
    `payer_id` BIGINT COMMENT 'Insurance payer responsible for reimbursement.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: SNFs and home health agencies contract with designated long-term care pharmacies for medication supply. Tracking the servicing pharmacy per episode supports formulary management, delivery logistics, a',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort_mgmt.cohort_definition. Business justification: Value-based care programs identify high-risk patients via population health cohorts, triggering post-acute episodes. Linking episode to originating cohort enables program effectiveness measurement, RO',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: CMS requires standardized ICD-10 diagnosis coding for post-acute episodes (MDS/OASIS submissions). Links episode primary diagnosis to reference terminology for bundled payment and quality reporting.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: CMS requires separation of research vs routine costs in PAC. PAC episodes occurring under a clinical trial protocol must be flagged for coverage analysis, billing compliance, and outcomes reporting to',
    `visit_id` BIGINT COMMENT 'description',
    `comorbidities` STRING COMMENT 'Comma‑separated list of additional diagnoses relevant to the episode.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|AUD`',
    `discharge_disposition` STRING COMMENT 'Location or status of the patient after episode discharge.. Valid values are `home|rehab|snf|home_health|deceased|other`',
    `effective_from` DATE COMMENT 'Date the episode became effective (start of care).',
    `effective_until` DATE COMMENT 'Date the episode ended or is expected to end (nullable for ongoing).',
    `episode_goal` STRING COMMENT 'Narrative description of the clinical goal for the episode.',
    `episode_number` BIGINT COMMENT 'Sequential number assigned to the episode for human reference.',
    `episode_status` STRING COMMENT 'Current lifecycle state of the episode.. Valid values are `planned|active|completed|cancelled|closed`',
    `episode_type` STRING COMMENT 'Category of post‑acute care delivered.. Valid values are `transitional_rehab|outpatient_therapy|community_care|other`',
    `follow_up_date` DATE COMMENT 'Scheduled date for the required follow‑up.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up appointment is required post‑discharge.',
    `functional_status_score` DECIMAL(18,2) COMMENT 'Add pii_phi, pii_pii, pii_sensitive tags for PHI compliance',
    `is_eligible_for_quality_measure` BOOLEAN COMMENT 'Flag indicating if the episode qualifies for quality reporting.',
    `is_eligible_for_reimbursement` BOOLEAN COMMENT 'Flag indicating if the episode meets payer reimbursement criteria.',
    `is_telehealth` BOOLEAN COMMENT 'True if any services in the episode were delivered via telehealth.',
    `length_of_stay_days` STRING COMMENT 'Total number of calendar days the patient spent in post‑acute care.',
    `net_responsibility` DECIMAL(18,2) COMMENT 'Remaining amount owed after payments (patient responsibility).',
    `outcome_score` DECIMAL(18,2) COMMENT 'Aggregated clinical outcome metric for the episode.',
    `primary_diagnosis_code` STRING COMMENT 'Principal diagnosis associated with the episode, coded per ICD‑10.',
    `primary_procedure_code` STRING COMMENT 'Main procedure performed during the episode, coded per CPT.. Valid values are `^[0-9]{5}$`',
    `quality_measure_score` DECIMAL(18,2) COMMENT 'Score derived from quality metrics applicable to the episode.',
    `readmission_flag` BOOLEAN COMMENT 'Indicates if the patient was readmitted within a defined window.',
    `readmission_within_30_days` BOOLEAN COMMENT 'True if readmission occurred within 30 days of discharge.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the episode record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the episode record.',
    `referral_date` DATE COMMENT 'Date the referral was received.',
    `referral_source` STRING COMMENT 'Origin of the referral that initiated the episode.. Valid values are `physician|self|hospital|clinic|other`',
    `reimbursement_amount` DECIMAL(18,2) COMMENT 'Amount approved for reimbursement by the payer.',
    `risk_score` DECIMAL(18,2) COMMENT 'Clinical risk score calculated at episode start.',
    `telehealth_modality` STRING COMMENT 'Mode of telehealth delivery used during the episode.. Valid values are `video|phone|remote_monitoring|other`',
    `total_charges` DECIMAL(18,2) COMMENT 'Gross amount billed for all services in the episode.',
    `total_payments` DECIMAL(18,2) COMMENT 'Sum of payments received from payer(s) and patient.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient receiving post‑acute care.',
    `primary_provider_id` BIGINT COMMENT 'Identifier of the clinician primarily responsible for the episode.',
    `insurance_plan_id` BIGINT COMMENT 'Specific insurance plan covering the episode.',
    `patient_consent_given` BOOLEAN COMMENT 'Indicates whether the patient consented to data sharing for this episode.',
    `consent_date` DATE COMMENT 'Date the patient provided consent.',
    CONSTRAINT pk_post_acute_episode PRIMARY KEY(`post_acute_episode_id`)
) COMMENT 'Master record representing a patient-specific post‑acute care episode (e.g., transitional rehab, outpatient therapy) excluding skilled nursing, home health, and hospice.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` (
    `post_acute_service_id` BIGINT COMMENT 'Unique surrogate key for each post-acute service record.',
    `service_bundle_id` BIGINT COMMENT 'Identifier of the service bundle to which this service belongs (if applicable).',
    `billing_code` STRING COMMENT 'HCPCS or CPT code used for billing the service.',
    `billing_code_type` STRING COMMENT 'Indicates whether the billing code follows CPT or HCPCS standards.. Valid values are `CPT|HCPCS`',
    `care_setting` STRING COMMENT 'Typical care setting where the service is provided.. Valid values are `inpatient|outpatient|home|telehealth|community|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service record was first created in the system.',
    `documentation_url` STRING COMMENT 'Link to the official service protocol or policy document.',
    `duration_minutes` STRING COMMENT 'Typical length of a single service session in minutes.',
    `effective_from` DATE COMMENT 'Date when the service definition becomes active for ordering.',
    `effective_until` DATE COMMENT 'Date when the service definition is retired or superseded (null if open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Free‑text description of patient eligibility rules (e.g., post‑surgical, diagnosis‑specific).',
    `is_bundle_service` BOOLEAN COMMENT 'True if the service is offered only as part of a bundled care package.',
    `is_covered_by_medicaid` BOOLEAN COMMENT 'True if the service is reimbursable under Medicaid.',
    `is_covered_by_medicare` BOOLEAN COMMENT 'True if the service is reimbursable under Medicare.',
    `is_covered_by_private_insurance` BOOLEAN COMMENT 'True if the service is covered by private payer contracts.',
    `is_home_based` BOOLEAN COMMENT 'True if the service is provided in the patient’s home.',
    `is_telehealth` BOOLEAN COMMENT 'True if the service can be delivered via telehealth.',
    `max_sessions_allowed` STRING COMMENT 'Upper limit on the number of reimbursable sessions per episode of care.',
    `post_acute_service_description` STRING COMMENT 'Detailed narrative describing the scope, goals, and methodology of the service.',
    `post_acute_service_name` STRING COMMENT 'Human‑readable name of the post‑acute care service (e.g., Physical Therapy – Lower Extremity).',
    `post_acute_service_status` STRING COMMENT 'Current lifecycle state of the service definition.. Valid values are `active|inactive|retired|draft|pending`',
    `price` DECIMAL(18,2) COMMENT 'Standard price charged for a single session of the service.',
    `price_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the price (e.g., USD).',
    `provider_specialty_required` STRING COMMENT 'Clinical specialty required to deliver the service (e.g., Physical Therapist).',
    `requires_prescription` BOOLEAN COMMENT 'True if a physician prescription is required to order the service.',
    `requires_referral` BOOLEAN COMMENT 'True if a referral from another provider is needed.',
    `risk_level` STRING COMMENT 'Clinical or operational risk classification associated with the service.. Valid values are `low|medium|high|critical`',
    `service_code` STRING COMMENT 'Internal catalog code used to uniquely identify the service across systems.',
    `service_type` STRING COMMENT 'Broad classification of the service offering.. Valid values are `therapy|wound_care|rehab|social_work|nutrition|speech`',
    `session_interval_days` STRING COMMENT 'Minimum number of days required between consecutive sessions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service record.',
    `name` STRING COMMENT 'Human‑readable name of the post‑acute care service (e.g., Physical Therapy – Lower Extremity).',
    `status` STRING COMMENT 'Current lifecycle state of the service definition.. Valid values are `active|inactive|retired|draft|pending`',
    `diagnosis_related_icd10` STRING COMMENT 'Comma‑separated list of ICD‑10 diagnosis codes that commonly justify the service.',
    `description` STRING COMMENT 'Detailed narrative describing the scope, goals, and methodology of the service.',
    `bundle_id` BIGINT COMMENT 'Identifier of the service bundle to which this service belongs (if applicable).',
    CONSTRAINT pk_post_acute_service PRIMARY KEY(`post_acute_service_id`)
) COMMENT 'Catalog of post‑acute care services offered (physical therapy, occupational therapy, wound care, etc.) with pricing, duration, and eligibility rules.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` (
    `service_delivery_id` BIGINT COMMENT 'Unique identifier for the post-acute service delivery record.',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.care_gap. Business justification: PAC services (therapy visits, nursing assessments) are delivered to close specific AI-detected care gaps. Linking enables care gap resolution tracking and value-based care quality measurement.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: Post-acute services (PT visits, nursing care) fulfill physician orders. Medicare home health requires face-to-face order documentation. Linking service delivery to originating clinical order enables o',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician or organization that performed the service.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Each post-acute service delivery requires a standardized diagnosis code for claims submission to Medicare/Medicaid and medical necessity documentation per CMS guidelines.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: Home health aides, CNAs, and therapy assistants deliver post-acute services but arent always in provider.clinician. Workforce linkage enables payroll reconciliation, competency verification, and OSHA',
    `encounter_authorization_id` BIGINT COMMENT 'Identifier of the prior authorization linked to this service, if applicable.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who received the service.',
    `post_acute_care_plan_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_care_plan. Business justification: A service delivery is performed as part of a care plan. Linking to the care plan enables tracking of plan adherence and scheduled vs actual service delivery.',
    `post_acute_episode_id` BIGINT COMMENT 'description',
    `post_acute_location_id` BIGINT COMMENT 'Identifier of the care site or location where the service was provided.',
    `post_acute_service_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_service. Business justification: A service delivery is an instance of a cataloged post-acute service. Linking to the service catalog enables standardized reporting and billing code lookup. The service_code/service_name on service_del',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Home health medication administration services must trace to the authorizing prescription for clinical accountability, nurse documentation, and accurate billing of medication-related visits.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments (discounts, taxes, contractual allowances) applied to the gross charge.',
    `billing_flag` BOOLEAN COMMENT 'Indicates whether the service is billable to the payer (true) or not (false).',
    `care_setting` STRING COMMENT 'Physical or virtual setting where the service was provided.. Valid values are `outpatient|community|telehealth|clinic|home`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Gross charge amount for the service before adjustments.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis code (ICD‑10) associated with the service.',
    `duration_minutes` STRING COMMENT 'Total duration of the service in minutes, calculated from start and end timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the service ended.',
    `followup_date` DATE COMMENT 'Scheduled date for the required follow‑up, if any.',
    `followup_required` BOOLEAN COMMENT 'Indicates whether a follow‑up appointment is required after the service.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after adjustments.',
    `outcome_notes` STRING COMMENT 'Clinician‑documented narrative describing the clinical outcome of the service.',
    `outcome_score` STRING COMMENT 'Numeric score (e.g., 1‑5) reflecting clinical outcome as assessed by the provider.',
    `procedure_code` STRING COMMENT 'Procedure or intervention code (CPT/HCPCS) performed during the service.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the service delivery record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service delivery record.',
    `referral_source` STRING COMMENT 'Origin of the referral that led to the service.. Valid values are `physician|self|agency|other`',
    `satisfaction_rating` STRING COMMENT 'Patient‑reported satisfaction rating (e.g., 1‑5).',
    `service_code` STRING COMMENT 'Standardized code representing the type of post‑acute service delivered (e.g., CPT, HCPCS).',
    `service_date` DATE COMMENT 'Calendar date on which the service was rendered.',
    `service_delivery_status` STRING COMMENT 'Current lifecycle status of the service delivery.. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `service_name` STRING COMMENT 'Human‑readable name of the service delivered.',
    `service_type` STRING COMMENT 'Broad category of the service delivered.. Valid values are `therapy|rehab|consultation|assessment|education`',
    `start_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the service began.',
    `provider_id` BIGINT COMMENT 'Identifier of the clinician or organization that performed the service.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient who received the service.',
    `location_id` BIGINT COMMENT 'Identifier of the care site or location where the service was provided.',
    `status` STRING COMMENT 'Current lifecycle status of the service delivery.. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `authorization_id` BIGINT COMMENT 'Identifier of the prior authorization linked to this service, if applicable.',
    CONSTRAINT pk_service_delivery PRIMARY KEY(`service_delivery_id`)
) COMMENT 'Transactional record of each post‑acute service delivered, capturing date, provider, location, duration, outcome notes, and billing flags.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` (
    `post_acute_care_plan_id` BIGINT COMMENT 'System‑generated unique identifier for the post‑acute care plan record.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: Transitions of care require linking PAC plans to originating inpatient care plans. CMS Conditions of Participation mandate documented continuity between acute discharge plans and post-acute care plans',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.care_gap. Business justification: PAC care plans are created to address AI-identified care gaps (e.g., missing follow-up, therapy needs). Transitional care management requires tracking which care gaps drove care plan creation for qual',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician responsible for overseeing the post‑acute care plan.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: Post-acute care plans require an accountable care coordinator for plan execution, patient/family communication, and interdisciplinary team coordination. Distinct from who updates the plan (care_plan_u',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: CMS readmission reduction programs require tracking whether post-acute care plans have confirmed follow-up appointments scheduled. Care coordinators use this link to verify care transition compliance ',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient for whom the post‑acute care plan is created.',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort.cohort_definition. Business justification: Population health programs standardize post-acute care plans by cohort (e.g., CHF discharge protocol). Program managers evaluate plan adherence and outcomes by cohort for quality improvement and contr',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: A post-acute care plan is authored FOR a specific post-acute episode. This links the PAC-specific care plan to the master episode record, enabling episode-level care plan tracking.',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_program. Business justification: Discharge planning workflow: PAC care plans specify RPM programs for remote monitoring during recovery. Care coordinators assign RPM programs as part of structured post-acute protocols.',
    `visit_id` BIGINT COMMENT 'Identifier of the acute‑care encounter that triggered the post‑acute care plan.',
    `billing_code` STRING COMMENT 'CPT code representing the primary billing service associated with the care plan.. Valid values are `^[0-9]{5}$`',
    `care_goals` STRING COMMENT 'Narrative description of the clinical and functional goals for the patient during post‑acute care.',
    `care_team` STRING COMMENT 'Comma‑separated list of provider identifiers or names participating in the care plan.',
    `compliance_retention_policy` STRING COMMENT 'Retention policy applied to the care plan record for compliance (e.g., HIPAA 7‑year retention).. Valid values are `hipaa_7_years|hipaa_6_years|state_specific`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care plan record was first created in the system.',
    `data_retention_end_date` DATE COMMENT 'Calculated date when the record must be archived or purged according to the retention policy.',
    `discharge_criteria` STRING COMMENT 'Conditions that must be met before the patient can be discharged from post‑acute care.',
    `effective_end_date` DATE COMMENT 'Date on which the care plan expires or is terminated (nullable for open‑ended plans).',
    `effective_start_date` DATE COMMENT 'Date on which the care plan becomes effective for the patient.',
    `follow_up_appointment_date` DATE COMMENT 'Scheduled date for the first follow‑up visit after discharge from post‑acute care.',
    `insurance_coverage_type` STRING COMMENT 'Primary payer category for the services covered by the plan.. Valid values are `medicare|medicaid|private|self_pay|other`',
    `is_telehealth_allowed` BOOLEAN COMMENT 'Indicates whether telehealth services are permitted within this care plan.',
    `notes` STRING COMMENT 'Free‑text field for additional clinical comments or observations.',
    `patient_preferences` STRING COMMENT 'Patient‑reported preferences regarding care modalities, visitation, and communication.',
    `plan_identifier` STRING COMMENT 'Business‑visible identifier or code assigned to the care plan (e.g., hospital‑generated plan number).',
    `plan_status` STRING COMMENT 'Current lifecycle state of the care plan.. Valid values are `draft|active|completed|cancelled|on_hold`',
    `plan_type` STRING COMMENT 'Categorization of the care plan based on service model.. Valid values are `rehabilitation|palliative|transitional|skilled_nursing|home_health`',
    `risk_level` STRING COMMENT 'Clinical risk assessment for the patient during the post‑acute episode.. Valid values are `low|moderate|high|critical`',
    `scheduled_services` STRING COMMENT 'List of services (e.g., physical therapy, occupational therapy) scheduled as part of the plan.',
    `therapy_plan` STRING COMMENT 'Details of physical, occupational, speech, or other therapy services included in the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the care plan record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient for whom the post‑acute care plan is created.',
    `encounter_id` BIGINT COMMENT 'Identifier of the acute‑care encounter that triggered the post‑acute care plan.',
    `primary_provider_id` BIGINT COMMENT 'Identifier of the clinician responsible for overseeing the post‑acute care plan.',
    `medication_plan` STRING COMMENT 'Prescribed medication regimen and administration instructions for the post‑acute period.',
    CONSTRAINT pk_post_acute_care_plan PRIMARY KEY(`post_acute_care_plan_id`)
) COMMENT 'Care plan authored for a post‑acute episode, defining goals, scheduled services, responsible clinicians, and target discharge criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` (
    `care_plan_update_id` BIGINT COMMENT 'System-generated unique identifier for each care plan update event.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or provider who performed the update.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient whose care plan was updated.',
    `post_acute_care_plan_id` BIGINT COMMENT 'Identifier of the care plan that was modified.',
    `change_reason` STRING COMMENT 'Free‑text explanation for why the care plan was altered.',
    `effective_end_date` DATE COMMENT 'Date when the updated care plan expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the updated care plan becomes effective.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the care plan modification occurred.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the change is clinically critical (true) or routine (false).',
    `new_care_plan_version` STRING COMMENT 'Version number of the care plan after the change.',
    `new_status` STRING COMMENT 'Status of the care plan after the update.. Valid values are `active|inactive|completed|pending|cancelled|archived`',
    `notes` STRING COMMENT 'Additional free‑text details about the change; may contain PHI.',
    `previous_care_plan_version` STRING COMMENT 'Version number of the care plan prior to the change.',
    `previous_status` STRING COMMENT 'Status of the care plan before the update.. Valid values are `active|inactive|completed|pending|cancelled|archived`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this audit record.',
    `update_type` STRING COMMENT 'Category of the change applied to the care plan.. Valid values are `add|modify|remove|status_change|reassign|cancel`',
    `care_plan_id` BIGINT COMMENT 'Identifier of the care plan that was modified.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient whose care plan was updated.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the staff member or provider who performed the update.',
    CONSTRAINT pk_care_plan_update PRIMARY KEY(`care_plan_update_id`)
) COMMENT 'Audit‑style event capturing modifications to a post‑acute care plan, including change reason, timestamp, and user.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` (
    `outcome_measure_id` BIGINT COMMENT 'Unique surrogate key for each outcome measurement record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician or provider who performed the assessment.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: CMS Standardized Patient Assessment Data Elements (SPADEs) and IMPACT Act require LOINC-coded outcome measures across post-acute settings for interoperable quality reporting.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: PAC outcome measures (OASIS functional scores, MDS quality indicators) must reference standardized quality measure definitions for consistent calculation, benchmarking, and CMS quality reporting.',
    `mpi_record_id` BIGINT COMMENT 'Internal identifier linking the outcome to the patient receiving post‑acute care.',
    `post_acute_care_plan_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_care_plan. Business justification: Outcome measures are tracked against specific care plan goals. Direct linkage enables measuring whether care plan objectives are being met without traversing through episode.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Outcome measures are recorded in the context of a post-acute episode. This enables aggregation of all outcomes for a given episode for quality reporting.',
    `post_acute_location_id` BIGINT COMMENT 'Identifier of the care site or facility where the measurement took place.',
    `post_acute_service_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_service. Business justification: An outcome measure can be tied to a specific service type from the catalog, enabling service-level outcome analysis.',
    `prom_response_id` BIGINT COMMENT 'Foreign key linking to digital_health.prom_response. Business justification: Outcomes traceability: PAC outcome measures derived from patient-reported data must reference the source PROM response for audit trail and CMS IMPACT Act compliance.',
    `service_delivery_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.service_delivery. Business justification: An outcome measure can be recorded for a specific service delivery event, linking the measured outcome to the exact service instance that produced it.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the outcome was recorded.',
    `achieved_flag` BOOLEAN COMMENT 'Indicates whether the measured value met or exceeded the target.',
    `assessment_notes` STRING COMMENT 'Free‑text clinical notes associated with the outcome measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outcome record was first created in the data lake.',
    `measure_type` STRING COMMENT 'Categorical code describing the type of outcome measured.. Valid values are `mobility_score|pain_level|adl_independence|cognitive_score|nutrition_status|fall_risk`',
    `measure_value` DECIMAL(18,2) COMMENT 'Numeric result of the outcome measurement (e.g., score, level, or reading).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date‑time when the outcome measurement was taken.',
    `outcome_status` STRING COMMENT 'Current processing status of the outcome record.. Valid values are `pending|completed|reviewed|invalid`',
    `recorded_by` STRING COMMENT 'Identifier of the user or system that entered the outcome measurement.',
    `risk_category` STRING COMMENT 'Risk level assigned based on the outcome measurement.. Valid values are `low|moderate|high|critical`',
    `source_system` STRING COMMENT 'Originating EHR or system that supplied the measurement.. Valid values are `Epic|Cerner|Meditech|Custom`',
    `target_value` DECIMAL(18,2) COMMENT 'Pre‑defined target or threshold for the outcome measure.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the numeric outcome value.. Valid values are `points|scale|percent|mmhg|bpm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the outcome record.',
    `patient_id` BIGINT COMMENT 'Internal identifier linking the outcome to the patient receiving post‑acute care.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the outcome was recorded.',
    `provider_id` BIGINT COMMENT 'Identifier of the clinician or provider who performed the assessment.',
    `location_id` BIGINT COMMENT 'Identifier of the care site or facility where the measurement took place.',
    CONSTRAINT pk_outcome_measure PRIMARY KEY(`outcome_measure_id`)
) COMMENT 'Recorded clinical or functional outcome metric for a post‑acute service (e.g., mobility score, pain level, ADL independence).';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` (
    `readmission_event_id` BIGINT COMMENT 'Unique surrogate key for each readmission event record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the readmission occurred.',
    `claim_id` BIGINT COMMENT 'Identifier of the claim associated with the readmission.',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: Model performance monitoring requires linking actual readmission events to the risk score prediction that preceded them. Essential for AI model validation, bias monitoring, and FDA SaMD post-market su',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who attended the readmission encounter.',
    `employee_id` BIGINT COMMENT 'System user identifier who created the record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: CMS Hospital Readmissions Reduction Program requires plan-level detail for penalty calculations. Payer alone is insufficient—different plans under same payer have different readmission policies and bu',
    `payer_id` BIGINT COMMENT 'Identifier of the payer responsible for the readmission claim.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient associated with the readmission event.',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: Unplanned readmissions from PAC settings trigger patient safety event reviews per CMS Hospital Readmissions Reduction Program. Links readmission to its safety investigation for corrective action.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: A readmission event occurs after a post-acute episode. Linking directly to the episode enables readmission rate analysis per episode type and supports quality measures.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Hospital Readmissions Reduction Program (HRRP) requires standardized ICD coding of readmission diagnoses for penalty calculation and potentially preventable readmission analysis.',
    `visit_id` BIGINT COMMENT 'Identifier of the encounter representing the readmission.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: A readmission event may occur at a specific post-acute care location. This enables tracking which PAC facility the patient was readmitted to, supporting quality metrics and facility-level readmission ',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the readmission event record was first created in the data lake.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged from the index encounter.',
    `discharge_disposition_code` STRING COMMENT 'Standard code indicating where the patient went after discharge.. Valid values are `home|rehab|snf|other`',
    `discharge_disposition_description` STRING COMMENT 'Human‑readable description of the discharge disposition.',
    `facility_type` STRING COMMENT 'Category of the facility hosting the readmission.. Valid values are `hospital|clinic|urgent_care|rehab|other`',
    `is_duplicate_event` BOOLEAN COMMENT 'Indicates whether this record is a duplicate of another readmission event.',
    `is_readmission_within_30_days` BOOLEAN COMMENT 'True if the readmission occurred within 30 days of discharge.',
    `is_readmission_within_90_days` BOOLEAN COMMENT 'True if the readmission occurred within 90 days of discharge.',
    `length_of_stay_original` STRING COMMENT 'Number of days the patient stayed during the index encounter.',
    `length_of_stay_readmission` STRING COMMENT 'Number of days the patient stayed during the readmission encounter.',
    `notes` STRING COMMENT 'Free‑text clinical notes captured during the readmission encounter.',
    `primary_diagnosis_code` STRING COMMENT 'ICD‑10 code for the principal diagnosis associated with the readmission.. Valid values are `^[A-Z][0-9][0-9A-Z]{0,6}$`',
    `primary_diagnosis_description` STRING COMMENT 'Narrative description of the primary diagnosis.',
    `readmission_cost` DECIMAL(18,2) COMMENT 'Total billed amount for the readmission encounter.',
    `readmission_outcome` STRING COMMENT 'Final disposition of the patient after the readmission.. Valid values are `alive|deceased|transferred|discharged`',
    `readmission_payment_status` STRING COMMENT 'Current payment status of the readmission claim.. Valid values are `paid|pending|denied|reversed`',
    `readmission_reason_code` STRING COMMENT 'Standardized code describing why the patient was readmitted.. Valid values are `infection|decompensation|procedure_complication|medication_issue|other`',
    `readmission_reason_description` STRING COMMENT 'Free‑text description of the readmission reason.',
    `readmission_timestamp` TIMESTAMP COMMENT 'Date‑time when the readmission occurred.',
    `readmission_type` STRING COMMENT 'Classification of the readmission as planned, unplanned, or emergency.. Valid values are `planned|unplanned|emergency`',
    `readmission_window_days` STRING COMMENT 'Number of days between the original discharge and the readmission.',
    `severity_level` STRING COMMENT 'Clinical severity assessment of the readmission event.. Valid values are `low|moderate|high|critical`',
    `source_system` STRING COMMENT 'Originating EHR or system that supplied the readmission data.. Valid values are `Epic|Cerner|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the readmission event record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient associated with the readmission event.',
    `encounter_id` BIGINT COMMENT 'Identifier of the index encounter that led to post‑acute care.',
    `readmission_encounter_id` BIGINT COMMENT 'Identifier of the encounter representing the readmission.',
    `attending_provider_id` BIGINT COMMENT 'Identifier of the provider who attended the readmission encounter.',
    `attending_provider_npi` STRING COMMENT 'National Provider Identifier of the attending clinician.. Valid values are `^[0-9]{10}$`',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the readmission occurred.',
    `created_by_user_id` BIGINT COMMENT 'System user identifier who created the record.',
    CONSTRAINT pk_readmission_event PRIMARY KEY(`readmission_event_id`)
) COMMENT 'Event indicating a patient readmission within a defined window after a post‑acute episode, used for quality and reimbursement monitoring.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`referral` (
    `referral_id` BIGINT COMMENT 'System-generated unique identifier for the referral record.',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: Referrals to post-acute services (home health, SNF) originating from SUD treatment episodes must be tracked for SAMHSA continuity-of-care requirements and to measure successful care transitions for su',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: Discharge planning workflows generate PAC referrals from inpatient care plans. CMS requires documented linkage between discharge care coordination and referral generation for transitions-of-care quali',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician or provider who initiated the referral.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: HIPAA requires documented patient authorization before sharing PHI with receiving post-acute providers during referral. Tracks which consent record authorizes the information exchange for care transit',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Post-acute referrals require standardized ICD diagnosis codes for prior authorization requests and medical necessity determination by payers.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the referral record.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the patient’s insurance plan used for coverage determination.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient for whom the referral is made.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Discharge planning and readmission analytics require tracking which acute facility originated the PAC referral. CMS Bundled Payment models hold originating hospitals accountable for PAC outcomes and c',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort_mgmt.cohort_definition. Business justification: Population health outreach programs generate post-acute referrals from cohort-based patient identification. Linking referral to originating cohort enables care management program attribution and close',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: A referral initiates a post-acute care episode. Once the episode is created, the referral should link back to it for traceability of the referral-to-episode lifecycle.',
    `post_acute_location_id` BIGINT COMMENT 'Identifier of the facility or organization delivering the referred service.',
    `post_acute_service_id` BIGINT COMMENT 'Identifier of the post‑acute care service to which the patient is being referred.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: PAC referrals (SNF, HH, hospice) require prior authorization from payers. The referral workflow tracks which prior auth approved the referred service, essential for denial management and timely care i',
    `referral_employee_id` BIGINT COMMENT 'Identifier of the system user who created the referral record.',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Care transition tracking: post-acute referrals originate from physician referral orders. CMS requires tracing referral-to-admission for bundled payment reconciliation and readmission accountability. D',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Post-acute referrals must be converted to scheduled appointments for care transition completion. Referral-to-appointment tracking is required for CMS Discharge Planning Condition of Participation and ',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is needed for the referred service.',
    `authorization_status` STRING COMMENT 'Current status of any required prior authorization.. Valid values are `authorized|pending|denied`',
    `channel` STRING COMMENT 'Communication channel used to transmit the referral.. Valid values are `ehr|phone|fax|email|portal|other`',
    `clinical_notes` STRING COMMENT 'Free‑text clinical observations and pertinent details supporting the referral decision.',
    `closure_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was closed in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was first captured in the system.',
    `diagnosis_code` STRING COMMENT 'ICD‑10 code representing the primary diagnosis associated with the referral.',
    `discharge_destination` STRING COMMENT 'Facility or setting to which the patient will be discharged after the referral service.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Projected monetary cost of the referred service before insurance adjustments.',
    `estimated_cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the estimated cost.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `expected_end_date` DATE COMMENT 'Planned date for completion of the referred service.',
    `expected_start_date` DATE COMMENT 'Planned date when the patient is expected to begin the referred service.',
    `follow_up_instructions` STRING COMMENT 'Specific instructions for post‑service follow‑up, including timing and responsible party.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up appointment or assessment is required post‑service.',
    `outcome_date` DATE COMMENT 'Date when the referral outcome was recorded.',
    `outcome_notes` STRING COMMENT 'Narrative summary of the results and any recommendations after the referral service.',
    `outcome_status` STRING COMMENT 'Final status of the referral after the service is rendered.. Valid values are `completed|not_completed|deferred|cancelled`',
    `priority` STRING COMMENT 'Business priority assigned to the referral for scheduling and resource allocation.. Valid values are `high|medium|low`',
    `procedure_code` STRING COMMENT 'CPT code for the procedure or service being requested, if applicable.',
    `reason_for_referral` STRING COMMENT 'Narrative description of the clinical or administrative reason prompting the referral.',
    `referral_date` TIMESTAMP COMMENT 'Timestamp when the referral was created or issued.',
    `referral_number` STRING COMMENT 'Human‑readable business identifier assigned to the referral, often used in communications and reporting.',
    `referral_source` STRING COMMENT 'Origin of the referral request (e.g., internal clinician, external provider, patient‑initiated).. Valid values are `internal|external|patient|provider|other`',
    `referral_status` STRING COMMENT 'Current lifecycle state of the referral.. Valid values are `pending|approved|rejected|completed|cancelled`',
    `referral_type` STRING COMMENT 'Category of service being requested by the referral.. Valid values are `consult|therapy|rehab|diagnostic|social|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the referral record.',
    `urgency_level` STRING COMMENT 'Clinical urgency indicating how quickly the referred service should be initiated.. Valid values are `urgent|routine|non_urgent`',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient for whom the referral is made.',
    `referring_provider_id` BIGINT COMMENT 'Identifier of the clinician or provider who initiated the referral.',
    `target_service_id` BIGINT COMMENT 'Identifier of the post‑acute care service to which the patient is being referred.',
    `target_facility_id` BIGINT COMMENT 'Identifier of the facility or organization delivering the referred service.',
    `insurance_plan_id` BIGINT COMMENT 'Identifier of the patient’s insurance plan used for coverage determination.',
    `referral_channel` STRING COMMENT 'Communication channel used to transmit the referral.. Valid values are `ehr|phone|fax|email|portal|other`',
    `referral_closure_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was closed in the system.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who created the referral record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the system user who last modified the referral record.',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Referral record initiating a post‑acute care episode, linking the originating encounter, referring clinician, and target service.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` (
    `post_acute_provider_assignment_id` BIGINT COMMENT 'System‑generated unique identifier for each provider‑to‑post‑acute specialty assignment record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the provider participating in the assignment (references the Provider master entity).',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the assignment record.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: A provider assignment can be scoped to a specific post-acute episode, enabling episode-level care team composition tracking.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: A provider assignment can be location-specific, indicating where the provider delivers post-acute services.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: PAC provider assignments require network verification to ensure in-network status before care delivery, preventing out-of-network denials and ensuring proper reimbursement rates per payer contracts.',
    `specialty_id` BIGINT COMMENT 'Identifier of the post‑acute care service specialty to which the provider is assigned.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the provider‑specialty assignment.. Valid values are `assigned|unassigned|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assignment record was first created in the system.',
    `credential_expiration_date` DATE COMMENT 'Date on which the providers credential for this specialty expires.',
    `credentialing_body` STRING COMMENT 'Name of the organization that issued or verifies the providers credentials (e.g., state board, CMS).',
    `credentialing_status` STRING COMMENT 'Current status of the providers credentialing for the assigned specialty.. Valid values are `active|inactive|revoked|pending`',
    `effective_from` DATE COMMENT 'Start date when the provider assignment becomes active.',
    `effective_until` DATE COMMENT 'End date when the provider assignment is terminated or expires; null if open‑ended.',
    `is_primary_provider` BOOLEAN COMMENT 'True if the provider is the primary point of contact for the assigned specialty within the post‑acute care network.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the assignment (e.g., special conditions, audit findings).',
    `scope_of_practice_flag` BOOLEAN COMMENT 'Indicates whether the provider is authorized to perform services within this specialty (true) or not (false).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assignment record.',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider participating in the assignment (references the Provider master entity).',
    `provider_npi` STRING COMMENT '10‑digit NPI that uniquely identifies the provider in the United States.. Valid values are `^d{10}$`',
    `provider_name` STRING COMMENT 'Legal full name of the provider as recorded in credentialing files.',
    `specialty_code` STRING COMMENT 'Standardized code (e.g., CPT‑based) representing the post‑acute service specialty.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who created the assignment record.',
    CONSTRAINT pk_post_acute_provider_assignment PRIMARY KEY(`post_acute_provider_assignment_id`)
) COMMENT 'Reference table mapping providers to post‑acute service specialties, including credentialing and scope of practice flags.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` (
    `post_acute_location_id` BIGINT COMMENT 'System‑generated unique identifier for each post‑acute care location.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Health systems register SNFs/home health agencies as care sites for CMS cost reporting, network adequacy filings, and capacity planning. Links PAC location to its facility master record for unified si',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Owned/operated PAC facilities (SNFs, home health branches) require cost center assignment for CMS-2552 Medicare cost reporting, departmental P&L statements, and overhead allocation.',
    `facility_organization_id` BIGINT COMMENT 'Identifier of the parent facility or health system that owns the location.',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: CMS uses geographic classification (CBSA, rural/urban) for post-acute reimbursement rate determination (SNF PPS, Home Health PPS wage index adjustments) and network adequacy reporting.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CMS requires SNFs/home health agencies to maintain organizational NPIs and credentialing. Linking post-acute locations to org_provider enables payer enrollment verification, network adequacy reporting',
    `accreditation_body` STRING COMMENT 'Organization that granted the accreditation.. Valid values are `CARF|JointCommission|StateHealthDept|Other`',
    `accreditation_status` STRING COMMENT 'Current accreditation standing of the location.. Valid values are `accredited|pending|revoked`',
    `address_line1` STRING COMMENT 'First line of the street address for the location.',
    `address_line2` STRING COMMENT 'Second line of the street address (optional).',
    `capacity_beds` STRING COMMENT 'Maximum number of inpatient beds available at the location.',
    `capacity_rooms` STRING COMMENT 'Maximum number of therapy or treatment rooms.',
    `city` STRING COMMENT 'City where the location is situated.',
    `closing_date` DATE COMMENT 'Date the location ceased operations (null if still open).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the location record was first created in the system.',
    `email_address` STRING COMMENT 'Primary email address for the location.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `has_emergency_services` BOOLEAN COMMENT 'True if the location provides 24‑hour emergency care.',
    `inspection_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) resulting from the latest inspection.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent health‑and‑safety inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location.',
    `license_number` STRING COMMENT 'State‑issued license identifier for the location.',
    `location_code` STRING COMMENT 'External code or catalogue number used by the organization to reference the location.',
    `location_type` STRING COMMENT 'Category of post‑acute service delivered at the location.. Valid values are `outpatient_rehab|ambulatory_clinic|day_center|therapy_center|community_center|other`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks, special considerations, or operational comments.',
    `opening_date` DATE COMMENT 'Date the location began providing services.',
    `phone_number` STRING COMMENT 'Primary telephone number for the location.',
    `post_acute_location_name` STRING COMMENT 'Human‑readable name of the post‑acute care location (e.g., "Sunrise Rehab Center").',
    `post_acute_location_status` STRING COMMENT 'Current operational status of the location.. Valid values are `active|inactive|closed|pending`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `services_offered` STRING COMMENT 'Free‑form list or coded string describing clinical services (e.g., "Physical Therapy, Occupational Therapy").',
    `state_province` STRING COMMENT 'State or province of the location.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier (e.g., "America/New_York").',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the location record.',
    `wheelchair_accessible` BOOLEAN COMMENT 'Indicates whether the facility complies with ADA wheelchair‑accessibility standards.',
    `name` STRING COMMENT 'Human‑readable name of the post‑acute care location (e.g., "Sunrise Rehab Center").',
    `status` STRING COMMENT 'Current operational status of the location.. Valid values are `active|inactive|closed|pending`',
    `parent_organization_id` BIGINT COMMENT 'Identifier of the parent facility or health system that owns the location.',
    CONSTRAINT pk_post_acute_location PRIMARY KEY(`post_acute_location_id`)
) COMMENT 'Reference catalog of physical locations where post‑acute services are delivered (outpatient rehab centers, ambulatory clinics).';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`snf` (
    `snf_id` BIGINT COMMENT 'Primary key for snf',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: SNF stub table represents a skilled nursing facility which is a type of post-acute location. Linking connects it to the location catalog.',
    CONSTRAINT pk_snf PRIMARY KEY(`snf_id`)
) COMMENT 'Table for Skilled Nursing Facility (SNF) stay data.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`hospice` (
    `hospice_id` BIGINT COMMENT 'Primary key for hospice',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Hospice stub table represents hospice care episodes. Linking to the master episode connects it to the normalized model.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: A hospice program operates at a specific post-acute location. This links the hospice entity to its physical location for facility management.',
    CONSTRAINT pk_hospice PRIMARY KEY(`hospice_id`)
) COMMENT 'Table for hospice care episodes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` (
    `pac_stay_id` BIGINT COMMENT 'Primary key for pac_stay',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: PAC stay records represent stays within a post-acute episode. Linking to the master episode enables stay-to-episode tracking.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: PAC stays occur at a specific location. Linking to post_acute_location identifies where the stay took place.',
    CONSTRAINT pk_pac_stay PRIMARY KEY(`pac_stay_id`)
) COMMENT 'Table storing post‑acute care stay records for SNF, home health, hospice.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` (
    `hospice_care_episode_id` BIGINT COMMENT 'Primary key for hospice_care_episode',
    `hospice_enrollment_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.hospice_enrollment. Business justification: A hospice care episode belongs to a specific hospice enrollment. The enrollment is the parent container for care episodes.',
    `hospice_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.hospice. Business justification: A hospice care episode occurs within a specific hospice program. Links the episode to the program for reporting.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Hospice care episode is a specialization of the master post-acute episode. Linking connects this stub to the normalized model.',
    CONSTRAINT pk_hospice_care_episode PRIMARY KEY(`hospice_care_episode_id`)
) COMMENT 'hospice_care_episode table for hospice enrollment and outcomes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`snf_data` (
    `snf_data_id` BIGINT COMMENT 'Primary key for snf_data',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: SNF data stub should link to the master episode for data integration.',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: SNF data should reference the location where the SNF services are provided.',
    `snf_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.snf. Business justification: SNF data records belong to a specific SNF facility. Direct linkage enables facility-level data aggregation and reporting.',
    CONSTRAINT pk_snf_data PRIMARY KEY(`snf_data_id`)
) COMMENT 'SNF Data table';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` (
    `home_health_data_id` BIGINT COMMENT 'Primary key for home_health_data',
    `home_health_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.home_health. Business justification: Home health data records belong to a specific home health enrollment. Direct linkage enables service-level data aggregation.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Home health data stub should link to the master episode for data integration.',
    CONSTRAINT pk_home_health_data PRIMARY KEY(`home_health_data_id`)
) COMMENT 'Home Health Data table';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` (
    `hospice_data_id` BIGINT COMMENT 'Primary key for hospice_data',
    `hospice_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.hospice. Business justification: Hospice data records belong to a specific hospice program. Direct linkage enables program-level data aggregation and outcome tracking.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Hospice data stub should link to the master episode for data integration.',
    CONSTRAINT pk_hospice_data PRIMARY KEY(`hospice_data_id`)
) COMMENT 'Hospice Data table';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` (
    `post_acute_care_cohort_membership_id` BIGINT COMMENT 'Primary key for post_acute_care_cohort_membership',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to the cohort definition that this episode is enrolled in',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to the post-acute care episode that is a member of the cohort',
    `cohort_membership_code` BIGINT COMMENT 'Unique surrogate key for the cohort membership record',
    `enrollment_date` DATE COMMENT 'Date the episode was enrolled into the cohort program',
    `program_status` STRING COMMENT 'Current status of the episode within the cohort program lifecycle',
    `risk_tier` STRING COMMENT 'Risk stratification tier assigned to this episode within the cohort',
    `target_outcome` STRING COMMENT 'Specific clinical or financial outcome target for this episode within this cohort program',
    CONSTRAINT pk_post_acute_care_cohort_membership PRIMARY KEY(`post_acute_care_cohort_membership_id`)
) COMMENT 'This association product represents the membership of a post-acute care episode in a population health cohort. It captures the enrollment, risk stratification, program status, and target outcomes for each episode-cohort pair. Each record links one post_acute_episode to one cohort_definition with attributes that exist only in the context of this membership relationship.. Existence Justification: In population health management, a single post-acute care episode can simultaneously qualify for multiple cohort definitions (e.g., CHF readmission risk cohort AND Medicare bundled payment cohort AND high-cost utilizer cohort). Conversely, a single cohort definition governs membership of many post-acute episodes. Health systems actively manage these episode-cohort memberships with enrollment dates, risk tiers, program statuses, and target outcomes as part of value-based care and care management programs.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` (
    `service_bundle_id` BIGINT COMMENT 'Primary key for service_bundle',
    `parent_bundle_service_bundle_id` BIGINT COMMENT 'Self-referential identifier pointing to the parent service bundle when this bundle is a component of a larger composite bundle.',
    `age_group_eligibility` STRING COMMENT 'Patient age group for which this service bundle is clinically appropriate and approved.',
    `approved_date` DATE COMMENT 'Date on which this service bundle was formally approved by the clinical governance committee for use in care delivery.',
    `authorization_validity_days` STRING COMMENT 'Number of days a prior authorization remains valid for this service bundle once approved by the payer.',
    `bundle_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this service bundle in billing and clinical systems. Used for cross-system reference and payer communication.',
    `bundle_type` STRING COMMENT 'Classification of the service bundle by clinical care category. Determines applicable clinical protocols and reimbursement pathways. [ENUM-REF-CANDIDATE: rehabilitation|palliative|transitional|chronic|wound_care|cardiac|respiratory|neurological|orthopedic — promote to reference product]',
    `bundled_payment_amount` DECIMAL(18,2) COMMENT 'Standard reimbursement amount for the complete service bundle under bundled payment arrangements. Used for financial planning and contract negotiations.',
    `care_setting` STRING COMMENT 'The post-acute care setting in which this service bundle is delivered. Determines facility requirements and staffing models.',
    `clinical_pathway_reference` STRING COMMENT 'Reference identifier linking to the evidence-based clinical pathway or protocol that governs the delivery of services within this bundle.',
    `cms_episode_group_code` STRING COMMENT 'CMS-defined episode group code that this service bundle aligns with for bundled payment and episode-based cost measurement purposes.',
    `cost_estimate_amount` DECIMAL(18,2) COMMENT 'Estimated internal cost to deliver all services in this bundle, used for margin analysis and value-based care financial modeling.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this service bundle.',
    `effective_end_date` DATE COMMENT 'Date after which this service bundle is no longer available for new care plans. Null indicates open-ended availability.',
    `effective_start_date` DATE COMMENT 'Date from which this service bundle becomes available for use in care planning and clinical ordering.',
    `expected_duration_days` STRING COMMENT 'Standard expected duration in calendar days for completion of all services within this bundle under normal clinical progression.',
    `functional_status_requirement` STRING COMMENT 'Minimum or target functional status criteria (e.g., mobility level, ADL independence) that patients must meet for eligibility or that the bundle aims to achieve.',
    `hcpcs_procedure_codes` STRING COMMENT 'Comma-separated list of primary HCPCS codes representing the procedures and services included in this bundle for billing and claims purposes.',
    `hipaa_retention_period_years` STRING COMMENT 'Number of years this service bundle record and associated documentation must be retained per HIPAA and state regulatory requirements.',
    `includes_dme` BOOLEAN COMMENT 'Indicates whether this service bundle includes provision of durable medical equipment such as walkers, hospital beds, or oxygen equipment.',
    `includes_nursing_services` BOOLEAN COMMENT 'Indicates whether this service bundle includes skilled nursing services such as wound care, medication management, or clinical monitoring.',
    `includes_social_services` BOOLEAN COMMENT 'Indicates whether this service bundle includes medical social work, care coordination, or social determinants of health (SDOH) interventions.',
    `includes_telehealth` BOOLEAN COMMENT 'Indicates whether this service bundle incorporates telehealth or remote patient monitoring components.',
    `includes_therapy_services` BOOLEAN COMMENT 'Indicates whether this service bundle includes physical therapy, occupational therapy, or speech-language pathology services.',
    `is_composite_bundle` BOOLEAN COMMENT 'Indicates whether this service bundle is composed of multiple sub-bundles that can also be ordered independently.',
    `is_evidence_based` BOOLEAN COMMENT 'Indicates whether this service bundle is supported by published clinical evidence or peer-reviewed research demonstrating efficacy.',
    `last_review_date` DATE COMMENT 'Date of the most recent clinical and financial review of this service bundle to ensure continued appropriateness and cost-effectiveness.',
    `maximum_duration_days` STRING COMMENT 'Maximum number of days allowed for this service bundle before requiring clinical review or reauthorization from the payer.',
    `minimum_duration_days` STRING COMMENT 'Minimum number of days required to deliver all services in this bundle while maintaining clinical quality standards.',
    `minimum_staff_fte` DECIMAL(18,2) COMMENT 'Minimum full-time equivalent staffing required to deliver this service bundle to a standard patient caseload.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this service bundle by the clinical governance committee.',
    `outcome_measure_target` STRING COMMENT 'Primary clinical outcome measure and target threshold used to evaluate the effectiveness of this service bundle (e.g., functional improvement score, pain reduction percentage).',
    `owning_department` STRING COMMENT 'Name or code of the clinical department or service line responsible for maintaining and governing this service bundle definition.',
    `patient_acuity_level` STRING COMMENT 'Target patient acuity level for which this service bundle is designed, guiding appropriate patient-bundle matching during discharge planning.',
    `payer_contract_category` STRING COMMENT 'Primary payer category for which this service bundle is contracted and priced. Determines applicable fee schedules and authorization requirements.',
    `quality_measure_set` STRING COMMENT 'Identifier for the set of quality measures (HEDIS, CMS Stars, or custom) used to evaluate outcomes for patients receiving this service bundle.',
    `readmission_risk_target` STRING COMMENT 'Target readmission risk category that this bundle is designed to mitigate, supporting hospital readmission reduction program compliance.',
    `regulatory_program_alignment` STRING COMMENT 'CMS or state regulatory program(s) this service bundle is designed to comply with, such as BPCI Advanced, CJR, or state Medicaid waiver programs.',
    `reimbursement_model` STRING COMMENT 'Payment methodology under which this service bundle is typically reimbursed by payers.',
    `requires_prior_authorization` BOOLEAN COMMENT 'Indicates whether this service bundle requires prior authorization from the payer before services can be initiated.',
    `revenue_code_range` STRING COMMENT 'Range of UB-04 revenue codes applicable to services within this bundle, used for institutional claim generation.',
    `service_bundle_description` STRING COMMENT 'Detailed narrative description of the services included in this bundle, their clinical purpose, and intended patient population.',
    `service_bundle_name` STRING COMMENT 'Human-readable name describing the service bundle, used in clinical documentation and care planning interfaces.',
    `service_bundle_status` STRING COMMENT 'Current lifecycle status of the service bundle indicating whether it is available for use in care planning and ordering.',
    `sort_order` STRING COMMENT 'Display ordering sequence used when presenting service bundles in clinical decision support interfaces and care planning tools.',
    `staffing_model` STRING COMMENT 'Clinical staffing model required to deliver this service bundle, determining team composition and coordination requirements.',
    `target_diagnosis_category` STRING COMMENT 'Primary ICD-10 diagnosis category or clinical condition group that this service bundle is designed to address in post-acute care transitions.',
    `target_drg_range` STRING COMMENT 'Range or list of DRG codes for which this service bundle is clinically appropriate, supporting discharge planning and care transition decisions.',
    `total_visits_included` STRING COMMENT 'Total number of clinical visits or encounters included in the standard service bundle package.',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions to this service bundle definition. Supports SCD Type 2 historical tracking of bundle changes.',
    CONSTRAINT pk_service_bundle PRIMARY KEY(`service_bundle_id`)
) COMMENT 'Master reference table for service_bundle. Referenced by bundle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ADD CONSTRAINT `fk_post_acute_care_snf_stay_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ADD CONSTRAINT `fk_post_acute_care_snf_stay_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ADD CONSTRAINT `fk_post_acute_care_snf_stay_snf_id` FOREIGN KEY (`snf_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`snf`(`snf_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` ADD CONSTRAINT `fk_post_acute_care_home_health_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ADD CONSTRAINT `fk_post_acute_care_hospice_care_hospice_id` FOREIGN KEY (`hospice_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`hospice`(`hospice_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ADD CONSTRAINT `fk_post_acute_care_hospice_care_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ADD CONSTRAINT `fk_post_acute_care_home_health_episode_home_health_id` FOREIGN KEY (`home_health_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`home_health`(`home_health_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ADD CONSTRAINT `fk_post_acute_care_home_health_episode_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ADD CONSTRAINT `fk_post_acute_care_home_health_service_home_health_episode_id` FOREIGN KEY (`home_health_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode`(`home_health_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ADD CONSTRAINT `fk_post_acute_care_home_health_service_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ADD CONSTRAINT `fk_post_acute_care_home_health_service_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` ADD CONSTRAINT `fk_post_acute_care_hospice_enrollment_hospice_id` FOREIGN KEY (`hospice_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`hospice`(`hospice_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` ADD CONSTRAINT `fk_post_acute_care_hospice_enrollment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` ADD CONSTRAINT `fk_post_acute_care_hospice_episode_hospice_enrollment_id` FOREIGN KEY (`hospice_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment`(`hospice_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` ADD CONSTRAINT `fk_post_acute_care_hospice_episode_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ADD CONSTRAINT `fk_post_acute_care_home_health_visit_home_health_episode_id` FOREIGN KEY (`home_health_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode`(`home_health_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ADD CONSTRAINT `fk_post_acute_care_home_health_visit_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ADD CONSTRAINT `fk_post_acute_care_home_health_visit_service_delivery_id` FOREIGN KEY (`service_delivery_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_delivery`(`service_delivery_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ADD CONSTRAINT `fk_post_acute_care_snf_encounter_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ADD CONSTRAINT `fk_post_acute_care_snf_encounter_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ADD CONSTRAINT `fk_post_acute_care_snf_encounter_snf_id` FOREIGN KEY (`snf_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`snf`(`snf_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ADD CONSTRAINT `fk_post_acute_care_post_acute_service_service_bundle_id` FOREIGN KEY (`service_bundle_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_bundle`(`service_bundle_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_post_acute_care_plan_id` FOREIGN KEY (`post_acute_care_plan_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan`(`post_acute_care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ADD CONSTRAINT `fk_post_acute_care_care_plan_update_post_acute_care_plan_id` FOREIGN KEY (`post_acute_care_plan_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan`(`post_acute_care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_post_acute_care_plan_id` FOREIGN KEY (`post_acute_care_plan_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan`(`post_acute_care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_service_delivery_id` FOREIGN KEY (`service_delivery_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_delivery`(`service_delivery_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ADD CONSTRAINT `fk_post_acute_care_post_acute_provider_assignment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ADD CONSTRAINT `fk_post_acute_care_post_acute_provider_assignment_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf` ADD CONSTRAINT `fk_post_acute_care_snf_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` ADD CONSTRAINT `fk_post_acute_care_hospice_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` ADD CONSTRAINT `fk_post_acute_care_hospice_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` ADD CONSTRAINT `fk_post_acute_care_pac_stay_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` ADD CONSTRAINT `fk_post_acute_care_pac_stay_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ADD CONSTRAINT `fk_post_acute_care_hospice_care_episode_hospice_enrollment_id` FOREIGN KEY (`hospice_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment`(`hospice_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ADD CONSTRAINT `fk_post_acute_care_hospice_care_episode_hospice_id` FOREIGN KEY (`hospice_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`hospice`(`hospice_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ADD CONSTRAINT `fk_post_acute_care_hospice_care_episode_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ADD CONSTRAINT `fk_post_acute_care_snf_data_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ADD CONSTRAINT `fk_post_acute_care_snf_data_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ADD CONSTRAINT `fk_post_acute_care_snf_data_snf_id` FOREIGN KEY (`snf_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`snf`(`snf_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ADD CONSTRAINT `fk_post_acute_care_home_health_data_home_health_id` FOREIGN KEY (`home_health_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`home_health`(`home_health_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ADD CONSTRAINT `fk_post_acute_care_home_health_data_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` ADD CONSTRAINT `fk_post_acute_care_hospice_data_hospice_id` FOREIGN KEY (`hospice_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`hospice`(`hospice_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` ADD CONSTRAINT `fk_post_acute_care_hospice_data_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_cohort_membership_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` ADD CONSTRAINT `fk_post_acute_care_service_bundle_parent_bundle_service_bundle_id` FOREIGN KEY (`parent_bundle_service_bundle_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_bundle`(`service_bundle_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`post_acute_care` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`post_acute_care` SET TAGS ('dbx_domain' = 'post_acute_care');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` SET TAGS ('dbx_subdomain' = 'skilled_nursing');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ALTER COLUMN `snf_stay_id` SET TAGS ('dbx_business_glossary_term' = 'snf_stay Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ALTER COLUMN `snf_id` SET TAGS ('dbx_business_glossary_term' = 'Snf Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` SET TAGS ('dbx_subdomain' = 'home_services');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` ALTER COLUMN `home_health_id` SET TAGS ('dbx_business_glossary_term' = 'home_health Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` ALTER COLUMN `home_health_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` ALTER COLUMN `home_health_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` SET TAGS ('dbx_subdomain' = 'hospice_management');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ALTER COLUMN `hospice_care_id` SET TAGS ('dbx_business_glossary_term' = 'hospice_care Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ALTER COLUMN `advance_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ALTER COLUMN `hospice_id` SET TAGS ('dbx_business_glossary_term' = 'Hospice Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` SET TAGS ('dbx_subdomain' = 'home_services');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_business_glossary_term' = 'home_health_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `home_health_id` SET TAGS ('dbx_business_glossary_term' = 'Home Health Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `home_health_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `home_health_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_episode` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` SET TAGS ('dbx_subdomain' = 'home_services');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `home_health_service_id` SET TAGS ('dbx_business_glossary_term' = 'home_health_service Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `home_health_service_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `home_health_service_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Home Health Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_service` ALTER COLUMN `post_acute_service_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` SET TAGS ('dbx_subdomain' = 'hospice_management');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` ALTER COLUMN `hospice_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'hospice_enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` ALTER COLUMN `hospice_id` SET TAGS ('dbx_business_glossary_term' = 'Hospice Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_enrollment` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` SET TAGS ('dbx_subdomain' = 'hospice_management');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` ALTER COLUMN `hospice_episode_id` SET TAGS ('dbx_business_glossary_term' = 'hospice_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` ALTER COLUMN `hospice_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Hospice Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_episode` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` SET TAGS ('dbx_subdomain' = 'home_services');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `home_health_visit_id` SET TAGS ('dbx_business_glossary_term' = 'home_health_visit Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `home_health_visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `home_health_visit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Home Health Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `home_health_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_visit` ALTER COLUMN `service_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` SET TAGS ('dbx_subdomain' = 'skilled_nursing');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ALTER COLUMN `snf_encounter_id` SET TAGS ('dbx_business_glossary_term' = 'snf_encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_encounter` ALTER COLUMN `snf_id` SET TAGS ('dbx_business_glossary_term' = 'Snf Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Acute Episode ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Crisis Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `behavioral_health_crisis_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Drg Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `comorbidities` SET TAGS ('dbx_business_glossary_term' = 'Comorbidities');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_value_regex' = 'home|rehab|snf|home_health|deceased|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `episode_goal` SET TAGS ('dbx_business_glossary_term' = 'Episode Goal');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_business_glossary_term' = 'Episode Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|closed');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_business_glossary_term' = 'Episode Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_value_regex' = 'transitional_rehab|outpatient_therapy|community_care|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `functional_status_score` SET TAGS ('dbx_business_glossary_term' = 'Functional Status Score');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `is_eligible_for_quality_measure` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Quality Measure');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `is_eligible_for_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Reimbursement');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Utilization Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (Days)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `net_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Net Responsibility');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD‑10)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Code (CPT)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `quality_measure_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Score');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `readmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `readmission_within_30_days` SET TAGS ('dbx_business_glossary_term' = 'Readmission Within 30 Days');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'physician|self|hospital|clinic|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Amount');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `telehealth_modality` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Modality');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `telehealth_modality` SET TAGS ('dbx_value_regex' = 'video|phone|remote_monitoring|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `total_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Charges');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `total_payments` SET TAGS ('dbx_business_glossary_term' = 'Total Payments');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `primary_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `patient_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Given');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `post_acute_service_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Acute Service ID (PAS_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `service_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (BID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (BC)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `billing_code_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Code Type (BCT)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `billing_code_type` SET TAGS ('dbx_value_regex' = 'CPT|HCPCS');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting (CS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|home|telehealth|community|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration (Minutes) (SD_MIN)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (EC)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `is_bundle_service` SET TAGS ('dbx_business_glossary_term' = 'Bundle Service Indicator (BSI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `is_covered_by_medicaid` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Coverage Indicator (MDCI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `is_covered_by_medicare` SET TAGS ('dbx_business_glossary_term' = 'Medicare Coverage Indicator (MCI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `is_covered_by_private_insurance` SET TAGS ('dbx_business_glossary_term' = 'Private Insurance Coverage Indicator (PICI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `is_home_based` SET TAGS ('dbx_business_glossary_term' = 'Home‑Based Service Indicator (HBSI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `is_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Service Indicator (TSI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `max_sessions_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Sessions Allowed (MSA)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `post_acute_service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description (SDESC)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `post_acute_service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name (SN)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `post_acute_service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Lifecycle Status (SLS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `post_acute_service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|pending');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Service Price (SP)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CCY)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `provider_specialty_required` SET TAGS ('dbx_business_glossary_term' = 'Required Provider Specialty (RPS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `requires_prescription` SET TAGS ('dbx_business_glossary_term' = 'Prescription Requirement Indicator (PRI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `requires_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `requires_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `requires_referral` SET TAGS ('dbx_business_glossary_term' = 'Referral Requirement Indicator (RRI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Catalog Code (SCC)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type (ST)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'therapy|wound_care|rehab|social_work|nutrition|speech');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `session_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Session Interval Days (SID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Service Name (SN)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Service Lifecycle Status (SLS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|pending');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `diagnosis_related_icd10` SET TAGS ('dbx_business_glossary_term' = 'Related Diagnosis ICD‑10 Codes (ICD10)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Service Description (SDESC)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (BID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `clinical_ai_care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `encounter_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `post_acute_care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `post_acute_service_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|community|telehealth|clinic|home');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `charge_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `charge_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `charge_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `charge_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration (Minutes)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `followup_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `followup_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Required');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `outcome_score` SET TAGS ('dbx_business_glossary_term' = 'Outcome Score');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'physician|self|agency|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_delivery_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'therapy|rehab|consultation|assessment|education');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `post_acute_care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Acute Care Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinical_ai_care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (CPT)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `billing_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `care_goals` SET TAGS ('dbx_business_glossary_term' = 'Care Goals');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `care_team` SET TAGS ('dbx_business_glossary_term' = 'Care Team');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `compliance_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `compliance_retention_policy` SET TAGS ('dbx_value_regex' = 'hipaa_7_years|hipaa_6_years|state_specific');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `data_retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention End Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `discharge_criteria` SET TAGS ('dbx_business_glossary_term' = 'Discharge Criteria');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `follow_up_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Appointment Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `insurance_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `insurance_coverage_type` SET TAGS ('dbx_value_regex' = 'medicare|medicaid|private|self_pay|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `is_telehealth_allowed` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Allowed Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `patient_preferences` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferences');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_business_glossary_term' = 'External Care Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|cancelled|on_hold');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Type (TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'rehabilitation|palliative|transitional|skilled_nursing|home_health');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `scheduled_services` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Services');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `therapy_plan` SET TAGS ('dbx_business_glossary_term' = 'Therapy Plan');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `primary_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `primary_provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `primary_provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ALTER COLUMN `medication_plan` SET TAGS ('dbx_business_glossary_term' = 'Medication Plan');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `care_plan_update_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Update Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updating User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `post_acute_care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Update Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `new_care_plan_version` SET TAGS ('dbx_business_glossary_term' = 'New Care Plan Version');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Care Plan Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|pending|cancelled|archived');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Update Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `previous_care_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Previous Care Plan Version');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Care Plan Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|pending|cancelled|archived');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `update_type` SET TAGS ('dbx_business_glossary_term' = 'Update Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `update_type` SET TAGS ('dbx_value_regex' = 'add|modify|remove|status_change|reassign|cancel');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updating User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `outcome_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `post_acute_care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `post_acute_service_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `prom_response_id` SET TAGS ('dbx_business_glossary_term' = 'Prom Response Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `service_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Achieved Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_type` SET TAGS ('dbx_value_regex' = 'mobility_score|pain_level|adl_independence|cognitive_score|nutrition_status|fall_risk');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_value` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measure Value');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_value` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_value` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_value` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measure_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed|invalid');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Recorded By');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Meditech|Custom');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'points|scale|percent|mmhg|bpm');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission Event Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Predicted Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payer Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Original Discharge Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_value_regex' = 'home|rehab|snf|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `discharge_disposition_description` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Description');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'hospital|clinic|urgent_care|rehab|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `is_duplicate_event` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `is_readmission_within_30_days` SET TAGS ('dbx_business_glossary_term' = 'Readmission Within 30 Days Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `is_readmission_within_90_days` SET TAGS ('dbx_business_glossary_term' = 'Readmission Within 90 Days Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `length_of_stay_original` SET TAGS ('dbx_business_glossary_term' = 'Original Length of Stay (Days)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `length_of_stay_readmission` SET TAGS ('dbx_business_glossary_term' = 'Readmission Length of Stay (Days)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Readmission Clinical Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code (ICD‑10)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9][0-9A-Z]{0,6}$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Description');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_cost` SET TAGS ('dbx_business_glossary_term' = 'Readmission Cost (USD)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_cost` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_cost` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_cost` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_cost` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_outcome` SET TAGS ('dbx_business_glossary_term' = 'Readmission Outcome');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_outcome` SET TAGS ('dbx_value_regex' = 'alive|deceased|transferred|discharged');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Readmission Payment Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|denied|reversed');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Readmission Reason Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_reason_code` SET TAGS ('dbx_value_regex' = 'infection|decompensation|procedure_complication|medication_issue|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Readmission Reason Description');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Readmission Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_type` SET TAGS ('dbx_business_glossary_term' = 'Readmission Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned|emergency');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_window_days` SET TAGS ('dbx_business_glossary_term' = 'Readmission Window (Days)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Readmission Severity Level');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Original Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_encounter_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `readmission_encounter_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider NPI');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `attending_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider Identifier (PROV_REF_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (USER_UPDATE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Identifier (INS_PLAN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Target Facility Identifier (FAC_TGT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `post_acute_service_id` SET TAGS ('dbx_business_glossary_term' = 'Target Service Identifier (SRV_TGT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (USER_CREATE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag (AUTH_REQ)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status (AUTH_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|pending|denied');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel (REF_CHANNEL)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'ehr|phone|fax|email|portal|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes (CLIN_NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Closure Timestamp (REF_CLOSE_TS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD10_CODE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `discharge_destination` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination (DISCH_DEST)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount (EST_COST_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Currency (EST_COST_CURR)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `estimated_cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End Date (EXP_END_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date (EXP_START_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `follow_up_instructions` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Instructions (FUP_INSTR)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Required Flag (FUP_REQ)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date (OUTCOME_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes (OUTCOME_NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Outcome Status (OUTCOME_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'completed|not_completed|deferred|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Referral Priority (REF_PRIORITY)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT_CODE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `reason_for_referral` SET TAGS ('dbx_business_glossary_term' = 'Reason for Referral (REF_REASON)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `reason_for_referral` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `reason_for_referral` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `reason_for_referral` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `reason_for_referral` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `reason_for_referral` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date (REF_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number (REF_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source (REF_SOURCE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'internal|external|patient|provider|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status (REF_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type (REF_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'consult|therapy|rehab|diagnostic|social|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Referral Urgency Level (REF_URGENCY)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'urgent|routine|non_urgent');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referring_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider Identifier (PROV_REF_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `target_service_id` SET TAGS ('dbx_business_glossary_term' = 'Target Service Identifier (SRV_TGT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `target_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Target Facility Identifier (FAC_TGT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Identifier (INS_PLAN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel (REF_CHANNEL)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_channel` SET TAGS ('dbx_value_regex' = 'ehr|phone|fax|email|portal|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `referral_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Closure Timestamp (REF_CLOSE_TS)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (USER_CREATE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (USER_UPDATE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `post_acute_provider_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Acute Provider Assignment ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Post‑Acute Service Specialty ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|unassigned|suspended');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `credential_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `credentialing_body` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Authority');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|pending');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `is_primary_provider` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Indicator');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `scope_of_practice_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope‑of‑Practice Flag');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_npi` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Full Name');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `provider_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Post‑Acute Service Specialty Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Acute Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `facility_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_value_regex' = 'CARF|JointCommission|StateHealthDept|Other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|revoked');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `capacity_beds` SET TAGS ('dbx_business_glossary_term' = 'Bed Capacity');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `capacity_rooms` SET TAGS ('dbx_business_glossary_term' = 'Room Capacity');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO‑3)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `has_emergency_services` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Available');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Facility License Number');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (External)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'outpatient_rehab|ambulatory_clinic|day_center|therapy_center|community_center|other');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `post_acute_location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `post_acute_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `post_acute_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `services_offered` SET TAGS ('dbx_business_glossary_term' = 'Services Offered');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `wheelchair_accessible` SET TAGS ('dbx_business_glossary_term' = 'Wheelchair Accessible');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf` SET TAGS ('dbx_subdomain' = 'skilled_nursing');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf` ALTER COLUMN `snf_id` SET TAGS ('dbx_business_glossary_term' = 'snf Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` SET TAGS ('dbx_subdomain' = 'hospice_management');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` ALTER COLUMN `hospice_id` SET TAGS ('dbx_business_glossary_term' = 'hospice Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` ALTER COLUMN `pac_stay_id` SET TAGS ('dbx_business_glossary_term' = 'pac_stay Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`pac_stay` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` SET TAGS ('dbx_subdomain' = 'hospice_management');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ALTER COLUMN `hospice_care_episode_id` SET TAGS ('dbx_business_glossary_term' = 'hospice_care_episode Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ALTER COLUMN `hospice_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Hospice Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ALTER COLUMN `hospice_id` SET TAGS ('dbx_business_glossary_term' = 'Hospice Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care_episode` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` SET TAGS ('dbx_subdomain' = 'skilled_nursing');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ALTER COLUMN `snf_data_id` SET TAGS ('dbx_business_glossary_term' = 'snf_data Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_data` ALTER COLUMN `snf_id` SET TAGS ('dbx_business_glossary_term' = 'Snf Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` SET TAGS ('dbx_subdomain' = 'home_services');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `home_health_data_id` SET TAGS ('dbx_business_glossary_term' = 'home_health_data Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `home_health_data_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `home_health_data_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `home_health_id` SET TAGS ('dbx_business_glossary_term' = 'Home Health Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `home_health_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `home_health_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health_data` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` SET TAGS ('dbx_subdomain' = 'hospice_management');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` ALTER COLUMN `hospice_data_id` SET TAGS ('dbx_business_glossary_term' = 'hospice_data Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` ALTER COLUMN `hospice_id` SET TAGS ('dbx_business_glossary_term' = 'Hospice Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_data` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` SET TAGS ('dbx_subdomain' = 'quality_outcomes');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` SET TAGS ('dbx_association_edges' = 'post_acute_care.post_acute_episode,population_health_cohort.cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `post_acute_care_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'post_acute_care_cohort_membership Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership - Cohort Definition Id');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership - Post Acute Episode Id');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `cohort_membership_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership ID');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ALTER COLUMN `target_outcome` SET TAGS ('dbx_business_glossary_term' = 'Target Outcome');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` SET TAGS ('dbx_subdomain' = 'episode_coordination');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` ALTER COLUMN `service_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Identifier');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` ALTER COLUMN `bundled_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` ALTER COLUMN `cost_estimate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` ALTER COLUMN `target_diagnosis_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_bundle` ALTER COLUMN `target_diagnosis_category` SET TAGS ('dbx_pii_health' = 'true');
