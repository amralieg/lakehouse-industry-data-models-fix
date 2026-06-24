-- Schema for Domain: clinical | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`clinical` COMMENT 'Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for each diagnosis record.',
    `care_site_id` BIGINT COMMENT 'FK to the care site where the diagnosis was recorded.',
    `clinical_order_id` BIGINT COMMENT 'FK to the clinical order that triggered or documented this diagnosis.',
    `clinician_id` BIGINT COMMENT 'FK to the clinician who documented the diagnosis.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics.',
    `drug_master_id` BIGINT COMMENT 'FK to drug master if diagnosis is medication-related.',
    `employee_id` BIGINT COMMENT 'FK to employee who documented the diagnosis.',
    `genetic_variant_id` BIGINT COMMENT 'Optional linkage from a coded diagnosis to a precision-medicine genetic_variant record, enabling genomics/AMC use cases to associate molecular findings with clinical diagnoses.',
    `icd_code_id` BIGINT COMMENT 'FK to the ICD-10 code reference table.',
    `material_master_id` BIGINT COMMENT 'FK to material master if diagnosis is device-related.',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `measure_id` BIGINT COMMENT 'FK to quality measure if diagnosis is quality-relevant.',
    `consent_record_id` BIGINT COMMENT 'FK to consent record governing access to this diagnosis.',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED CT concept for clinical terminology.',
    `visit_id` BIGINT COMMENT 'FK to the encounter/visit where the diagnosis was recorded.',
    `admit_diagnosis_flag` BOOLEAN COMMENT 'Indicates if this diagnosis was the reason for admission.',
    `care_setting` STRING COMMENT 'Care setting where diagnosis was recorded (inpatient, outpatient, ED, etc.).',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates if a CDI query was issued for this diagnosis.',
    `cdi_query_status` STRING COMMENT 'Status of the CDI query (pending, answered, escalated, etc.).',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates if this diagnosis represents a chronic condition.',
    `clinical_status` STRING COMMENT 'Clinical status of the diagnosis (active, resolved, recurrence, etc.).',
    `coding_date` DATE COMMENT 'Date the diagnosis was coded.',
    `coding_status` STRING COMMENT 'Status of the coding process (pending, final, audited, etc.).',
    `complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates if this diagnosis is a complication or comorbidity (CC/MCC) for DRG assignment.',
    `diagnosis_date` DATE COMMENT 'Date the diagnosis was made.',
    `diagnosis_type` STRING COMMENT 'Type of diagnosis (principal, secondary, admitting, discharge, etc.).',
    `discharge_diagnosis_flag` BOOLEAN COMMENT 'Indicates if this diagnosis was present at discharge.',
    `drg_relevant_flag` BOOLEAN COMMENT 'Indicates if this diagnosis impacts DRG assignment.',
    `encounter_diagnosis_source` STRING COMMENT 'Source of the diagnosis (EHR, claim, problem list, etc.).',
    `encounter_type` STRING COMMENT 'Type of encounter where diagnosis was recorded.',
    `external_cause_code` STRING COMMENT 'ICD-10 external cause code (E-code) if applicable.',
    `hac_flag` BOOLEAN COMMENT 'Indicates if this diagnosis is a hospital-acquired condition.',
    `icd10_version` STRING COMMENT 'Version of ICD-10 code set used.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to this diagnosis record.',
    `laterality` STRING COMMENT 'Laterality of the diagnosis (left, right, bilateral, etc.).',
    `mcc_flag` BOOLEAN COMMENT 'Indicates if this diagnosis is a major complication or comorbidity (MCC).',
    `mrn` STRING COMMENT 'Patient medical record number.',
    `note_text` STRING COMMENT 'Free-text clinical note associated with the diagnosis.',
    `onset_date` DATE COMMENT 'Date of onset of the diagnosis.',
    `present_on_admission` STRING COMMENT 'POA indicator (Y, N, U, W, etc.) for CMS reporting.',
    `principal_diagnosis_flag` BOOLEAN COMMENT 'Indicates if this is the principal diagnosis for the encounter.',
    `problem_list_flag` BOOLEAN COMMENT 'Indicates if this diagnosis is on the patients problem list.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates if this diagnosis is relevant to quality measure reporting.',
    `rank` STRING COMMENT 'Rank/sequence of the diagnosis (1=principal, 2=secondary, etc.).',
    `recorded_timestamp` TIMESTAMP COMMENT 'Timestamp when the diagnosis was recorded in the system.',
    `resolution_date` DATE COMMENT 'Date the diagnosis was resolved.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates if this diagnosis is a social determinant of health (Z-code).',
    `severity` STRING COMMENT 'Severity of the diagnosis (mild, moderate, severe, etc.).',
    `source_system_diagnosis_code` STRING COMMENT 'Diagnosis code as recorded in the source system.',
    `verification_status` STRING COMMENT 'Verification status of the diagnosis (confirmed, provisional, differential, etc.).',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'Captures all patient diagnoses recorded during encounters, including ICD-10 codes, present-on-admission indicators, and CDI query status for DRG optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` (
    `procedure_event_id` BIGINT COMMENT 'Unique identifier for each procedure event.',
    `care_site_id` BIGINT COMMENT 'FK to the care site where the procedure was performed.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center for financial tracking.',
    `cpt_code_id` BIGINT COMMENT 'FK to the CPT code reference table.',
    `drg_id` BIGINT COMMENT 'FK to DRG if procedure impacts DRG assignment.',
    `drug_master_id` BIGINT COMMENT 'FK to drug master if procedure involved medication administration.',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code reference table.',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order if procedure was imaging-related.',
    `material_master_id` BIGINT COMMENT 'FK to material master for supplies used in the procedure.',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `room_id` BIGINT COMMENT 'FK to the operating room where the procedure was performed.',
    `clinical_order_id` BIGINT COMMENT 'FK to the clinical order that initiated the procedure.',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `payer_id` BIGINT COMMENT 'FK to the payer for this procedure.',
    `lab_order_id` BIGINT COMMENT 'FK to preoperative lab order.',
    `clinician_id` BIGINT COMMENT 'FK to the primary clinician who performed the procedure.',
    `measure_id` BIGINT COMMENT 'FK to quality measure if procedure is quality-relevant.',
    `specimen_id` BIGINT COMMENT 'FK to specimen collected during the procedure.',
    `tertiary_procedure_anesthesia_provider_clinician_id` BIGINT COMMENT 'FK to the anesthesia provider clinician.',
    `treatment_consent_id` BIGINT COMMENT 'FK to the treatment consent record.',
    `visit_id` BIGINT COMMENT 'FK to the encounter/visit where the procedure was performed.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia used (general, local, regional, etc.).',
    `approach` STRING COMMENT 'Surgical approach (open, laparoscopic, robotic, etc.).',
    `asa_classification` STRING COMMENT 'ASA physical status classification (I-VI).',
    `body_site` STRING COMMENT 'Anatomical body site where the procedure was performed.',
    `cancellation_reason` STRING COMMENT 'Reason the procedure was cancelled, if applicable.',
    `cdm_code` STRING COMMENT 'Charge description master code for billing.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Total charge amount for the procedure.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates if informed consent was obtained.',
    `cpt_modifier_1` STRING COMMENT 'First CPT modifier code.',
    `cpt_modifier_2` STRING COMMENT 'Second CPT modifier code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the procedure record was created.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the procedure in minutes.',
    `estimated_blood_loss_ml` STRING COMMENT 'Estimated blood loss in milliliters.',
    `icd10_pcs_code` STRING COMMENT 'ICD-10 Procedure Coding System code.',
    `laterality` STRING COMMENT 'Laterality of the procedure (left, right, bilateral, etc.).',
    `primary_diagnosis_code` STRING COMMENT 'Primary diagnosis code associated with the procedure.',
    `priority` STRING COMMENT 'Priority of the procedure (elective, urgent, emergent, etc.).',
    `procedure_category` STRING COMMENT 'Category of the procedure (surgical, diagnostic, therapeutic, etc.).',
    `procedure_date` DATE COMMENT 'Date the procedure was performed.',
    `procedure_end_datetime` TIMESTAMP COMMENT 'Timestamp when the procedure ended.',
    `procedure_number` STRING COMMENT 'Unique procedure number or case number.',
    `procedure_start_datetime` TIMESTAMP COMMENT 'Timestamp when the procedure started.',
    `procedure_status` STRING COMMENT 'Status of the procedure (scheduled, in progress, completed, cancelled, etc.).',
    `procedure_type` STRING COMMENT 'Type of procedure (surgical, diagnostic, therapeutic, etc.).',
    `rvu_work` DECIMAL(18,2) COMMENT 'Relative value unit (RVU) work component for the procedure.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Scheduled start datetime for the procedure.',
    `service_line` STRING COMMENT 'Service line for the procedure (cardiology, orthopedics, etc.).',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT code for the procedure.',
    `source_system_record_code` STRING COMMENT 'Procedure code as recorded in the source system.',
    `specimen_collected` BOOLEAN COMMENT 'Indicates if a specimen was collected during the procedure.',
    `timeout_performed` BOOLEAN COMMENT 'Indicates if a surgical timeout was performed.',
    `udi` STRING COMMENT 'Unique device identifier for implanted devices.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to this procedure record.',
    `wound_classification` STRING COMMENT 'Wound classification (clean, clean-contaminated, contaminated, dirty, etc.).',
    CONSTRAINT pk_procedure_event PRIMARY KEY(`procedure_event_id`)
) COMMENT 'Records all clinical procedures performed on patients, including surgical procedures, diagnostic procedures, and therapeutic interventions, with CPT/ICD-10-PCS codes for billing and quality reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`note` (
    `note_id` BIGINT COMMENT 'Unique identifier for each clinical note.',
    `accreditation_survey_id` BIGINT COMMENT 'FK to accreditation survey if note is part of survey documentation.',
    `care_site_id` BIGINT COMMENT 'FK to the care site where the note was authored.',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC code for note type classification.',
    `note_template_id` BIGINT COMMENT 'FK to the note template used.',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit.',
    `parent_note_id` BIGINT COMMENT 'FK to the parent note if this is an addendum or amendment.',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `consent_record_id` BIGINT COMMENT 'FK to consent record governing access to this note.',
    `clinician_id` BIGINT COMMENT 'FK to the cosigner provider clinician.',
    `visit_id` BIGINT COMMENT 'FK to the encounter/visit where the note was authored.',
    `admission_date` DATE COMMENT 'Admission date for the encounter.',
    `amended_timestamp` TIMESTAMP COMMENT 'Timestamp when the note was amended.',
    `author_role` STRING COMMENT 'Role of the note author (attending, resident, nurse, etc.).',
    `authored_timestamp` TIMESTAMP COMMENT 'Timestamp when the note was authored.',
    `care_setting` STRING COMMENT 'Care setting where note was authored (inpatient, outpatient, ED, etc.).',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates if a CDI query was issued for this note.',
    `cdi_query_status` STRING COMMENT 'Status of the CDI query (pending, answered, escalated, etc.).',
    `confidentiality_level` STRING COMMENT 'Confidentiality level of the note (normal, restricted, VIP, etc.).',
    `cosigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the note was cosigned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the note record was created.',
    `dictation_method` STRING COMMENT 'Method of dictation (typed, voice recognition, transcription, etc.).',
    `discharge_date` DATE COMMENT 'Discharge date for the encounter.',
    `drg_impact_flag` BOOLEAN COMMENT 'Indicates if this note impacts DRG assignment.',
    `encounter_type` STRING COMMENT 'Type of encounter where note was authored.',
    `format` STRING COMMENT 'Format of the note (text, HTML, PDF, CDA, etc.).',
    `is_addendum` BOOLEAN COMMENT 'Indicates if this note is an addendum to another note.',
    `is_copy_forwarded` BOOLEAN COMMENT 'Indicates if a copy of the note was forwarded to the patient or other party.',
    `is_late_entry` BOOLEAN COMMENT 'Indicates if this note is a late entry.',
    `mrn` STRING COMMENT 'Patient medical record number.',
    `note_status` STRING COMMENT 'Status of the note (draft, signed, amended, etc.).',
    `note_type` STRING COMMENT 'Type of note (progress note, discharge summary, H&P, operative note, etc.).',
    `principal_diagnosis_code` STRING COMMENT 'Principal diagnosis code associated with the note.',
    `sensitive_note_type` STRING COMMENT 'Type of sensitive note (behavioral health, substance use, HIV, etc.).',
    `service_date` DATE COMMENT 'Date of service for the note.',
    `service_line` STRING COMMENT 'Service line for the note (cardiology, orthopedics, etc.).',
    `signed_timestamp` TIMESTAMP COMMENT 'Timestamp when the note was signed.',
    `source_system_note_code` STRING COMMENT 'Note code as recorded in the source system.',
    `specialty` STRING COMMENT 'Specialty of the note author.',
    `text` STRING COMMENT 'Full text content of the clinical note.',
    `title` STRING COMMENT 'Title of the note.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to this note record.',
    `version` STRING COMMENT 'Version number of the note.',
    `word_count` STRING COMMENT 'Word count of the note text.',
    CONSTRAINT pk_note PRIMARY KEY(`note_id`)
) COMMENT 'Stores all clinical notes and documentation, including progress notes, discharge summaries, H&P, operative notes, and consult notes, with support for CDI queries, amendments, and confidentiality levels.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`problem` (
    `problem_id` BIGINT COMMENT 'Primary key',
    `care_plan_id` BIGINT COMMENT 'FK to care plan',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `material_master_id` BIGINT COMMENT 'FK to material',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `prescription_id` BIGINT COMMENT 'FK to prescription',
    `clinician_id` BIGINT COMMENT 'FK to adding provider',
    `consent_record_id` BIGINT COMMENT 'FK to consent record',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED concept',
    `tertiary_problem_last_updated_by_provider_clinician_id` BIGINT COMMENT 'FK to last updater',
    `clinical_order_id` BIGINT COMMENT 'FK to triggering order',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `body_site_code` STRING COMMENT 'Body site code',
    `body_site_description` STRING COMMENT 'Body site description',
    `care_setting` STRING COMMENT 'Care setting',
    `cdi_query_flag` BOOLEAN COMMENT 'CDI query flag',
    `cdi_query_status` STRING COMMENT 'CDI query status',
    `chronic_condition_flag` BOOLEAN COMMENT 'Chronic condition flag',
    `comment` STRING COMMENT 'Problem comment',
    `confidential_flag` BOOLEAN COMMENT 'Confidential flag',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `fhir_condition_reference` STRING COMMENT 'FHIR condition reference',
    `hcc_category_code` STRING COMMENT 'HCC category code',
    `is_encounter_diagnosis` BOOLEAN COMMENT 'Is encounter diagnosis',
    `last_reviewed_date` DATE COMMENT 'Last reviewed date',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `laterality` STRING COMMENT 'Laterality',
    `list_display_order` STRING COMMENT 'Display order',
    `mrn` STRING COMMENT 'MRN',
    `noted_date` DATE COMMENT 'Noted date',
    `onset_age_years` STRING COMMENT 'Onset age in years',
    `onset_date` DATE COMMENT 'Onset date',
    `principal_problem_flag` BOOLEAN COMMENT 'Principal problem flag',
    `priority` STRING COMMENT 'Priority',
    `problem_status` STRING COMMENT 'Problem status',
    `problem_type` STRING COMMENT 'Problem type',
    `resolution_date` DATE COMMENT 'Resolution date',
    `sdoh_flag` BOOLEAN COMMENT 'SDOH flag',
    `severity` STRING COMMENT 'Severity',
    `source_system_problem_code` STRING COMMENT 'Source system problem code',
    `stage_code` STRING COMMENT 'Stage code',
    `stage_description` STRING COMMENT 'Stage description',
    `title` STRING COMMENT 'Problem title',
    `verification_status` STRING COMMENT 'Verification status',
    CONSTRAINT pk_problem PRIMARY KEY(`problem_id`)
) COMMENT 'Patient problem list';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`allergy` (
    `allergy_id` BIGINT COMMENT 'Primary key',
    `cpoe_alert_id` BIGINT COMMENT 'FK to CPOE alert',
    `drug_master_id` BIGINT COMMENT 'FK to allergen drug',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `test_result_id` BIGINT COMMENT 'FK to confirmatory test',
    `consent_record_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `material_master_id` BIGINT COMMENT 'FK to material',
    `ndc_drug_id` BIGINT COMMENT 'FK to NDC drug',
    `clinician_id` BIGINT COMMENT 'FK to allergy clinician',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `alert_override_reason` STRING COMMENT 'Alert override reason',
    `allergen_name` STRING COMMENT 'Allergen name',
    `allergen_type` STRING COMMENT 'Allergen type',
    `care_setting` STRING COMMENT 'Care setting',
    `allergy_category` STRING COMMENT 'Allergy category',
    `clinical_status` STRING COMMENT 'Clinical status',
    `criticality` STRING COMMENT 'Criticality',
    `data_quality_flag` BOOLEAN COMMENT 'Data quality flag',
    `deleted_timestamp` TIMESTAMP COMMENT 'Deletion timestamp',
    `fhir_resource_reference` STRING COMMENT 'FHIR resource reference',
    `information_source` STRING COMMENT 'Information source',
    `is_deleted` BOOLEAN COMMENT 'Deleted flag',
    `is_no_known_allergy` BOOLEAN COMMENT 'No known allergy flag',
    `is_no_known_drug_allergy` BOOLEAN COMMENT 'No known drug allergy flag',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `mrn` STRING COMMENT 'MRN',
    `ndf_rt_code` STRING COMMENT 'NDF-RT code',
    `note` STRING COMMENT 'Note',
    `onset_date` DATE COMMENT 'Onset date',
    `override_timestamp` TIMESTAMP COMMENT 'Override timestamp',
    `phi_access_restricted` BOOLEAN COMMENT 'PHI access restricted',
    `reaction_description` STRING COMMENT 'Reaction description',
    `reaction_route` STRING COMMENT 'Reaction route',
    `reaction_snomed_code` STRING COMMENT 'Reaction SNOMED code',
    `reconciliation_date` DATE COMMENT 'Reconciliation date',
    `reconciliation_status` STRING COMMENT 'Reconciliation status',
    `recorded_date` TIMESTAMP COMMENT 'Recorded date',
    `severity` STRING COMMENT 'Severity',
    `source_system_allergy_code` STRING COMMENT 'Source system allergy code',
    `verification_status` STRING COMMENT 'Verification status',
    CONSTRAINT pk_allergy PRIMARY KEY(`allergy_id`)
) COMMENT 'Patient allergies and adverse reactions';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`immunization` (
    `immunization_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `material_master_id` BIGINT COMMENT 'FK to material',
    `ndc_drug_id` BIGINT COMMENT 'FK to NDC drug',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `clinician_id` BIGINT COMMENT 'FK to PCP',
    `consent_record_id` BIGINT COMMENT 'FK to consent record',
    `drug_master_id` BIGINT COMMENT 'FK to vaccine drug',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `administration_route_code` STRING COMMENT 'Administration route',
    `administration_site_code` STRING COMMENT 'Administration site',
    `administration_status` STRING COMMENT 'Administration status',
    `administration_timestamp` DECIMAL(18,2) COMMENT 'Administration timestamp',
    `clinical_note` STRING COMMENT 'Clinical note',
    `consent_obtained` BOOLEAN COMMENT 'Consent obtained',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `dose_number_in_series` STRING COMMENT 'Dose number in series',
    `dose_quantity` DECIMAL(18,2) COMMENT 'Dose quantity',
    `dose_unit` STRING COMMENT 'Dose unit',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date',
    `funding_source_code` STRING COMMENT 'Funding source',
    `iis_reported` BOOLEAN COMMENT 'IIS reported flag',
    `iis_reported_timestamp` TIMESTAMP COMMENT 'IIS reported timestamp',
    `lot_number` STRING COMMENT 'Lot number',
    `mrn` STRING COMMENT 'MRN',
    `not_given_reason_code` STRING COMMENT 'Not given reason',
    `reaction_detail` STRING COMMENT 'Reaction detail',
    `reaction_observed` BOOLEAN COMMENT 'Reaction observed',
    `series_completion_status` STRING COMMENT 'Series completion status',
    `series_doses_required` STRING COMMENT 'Series doses required',
    `series_name` STRING COMMENT 'Series name',
    `source_system_record_code` STRING COMMENT 'Source system record code',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    `vaers_reported` BOOLEAN COMMENT 'VAERS reported',
    `vfc_eligibility_code` STRING COMMENT 'VFC eligibility',
    `vis_document_type` STRING COMMENT 'VIS document type',
    `vis_presentation_date` DATE COMMENT 'VIS presentation date',
    `vis_publication_date` DATE COMMENT 'VIS publication date',
    CONSTRAINT pk_immunization PRIMARY KEY(`immunization_id`)
) COMMENT 'Patient immunization records';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` (
    `vital_sign_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `equipment_asset_id` BIGINT COMMENT 'FK to equipment',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC',
    `mar_record_id` BIGINT COMMENT 'FK to MAR record',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `previous_vital_sign_id` BIGINT COMMENT 'FK to previous vital sign',
    `substance_use_consent_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `abnormal_flag` BOOLEAN COMMENT 'Abnormal flag',
    `amended_reason` STRING COMMENT 'Amendment reason',
    `body_site` STRING COMMENT 'Body site',
    `care_unit` STRING COMMENT 'Care unit',
    `clinical_note` STRING COMMENT 'Clinical note',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `documented_timestamp` TIMESTAMP COMMENT 'Documentation timestamp',
    `ews_score_contribution` STRING COMMENT 'EWS score contribution',
    `ews_score_type` STRING COMMENT 'EWS score type',
    `flowsheet_row_code` STRING COMMENT 'Flowsheet row code',
    `gcs_component` STRING COMMENT 'GCS component',
    `is_patient_reported` BOOLEAN COMMENT 'Patient reported flag',
    `is_telemetry_derived` BOOLEAN COMMENT 'Telemetry derived flag',
    `measurement_method` STRING COMMENT 'Measurement method',
    `measurement_timestamp` TIMESTAMP COMMENT 'Measurement timestamp',
    `mrn` STRING COMMENT 'MRN',
    `numeric_value` DECIMAL(18,2) COMMENT 'Numeric value',
    `observation_status` STRING COMMENT 'Observation status',
    `observation_type` STRING COMMENT 'Observation type',
    `oxygen_delivery_method` STRING COMMENT 'Oxygen delivery method',
    `pain_scale_type` STRING COMMENT 'Pain scale type',
    `patient_position` STRING COMMENT 'Patient position',
    `reference_range_high` DECIMAL(18,2) COMMENT 'Reference range high',
    `reference_range_low` DECIMAL(18,2) COMMENT 'Reference range low',
    `snomed_finding_code` STRING COMMENT 'SNOMED finding code',
    `source_system_record_code` STRING COMMENT 'Source system record code',
    `supplemental_oxygen_flow_rate` DECIMAL(18,2) COMMENT 'Supplemental oxygen flow rate',
    `text_value` DECIMAL(18,2) COMMENT 'Text value',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_vital_sign PRIMARY KEY(`vital_sign_id`)
) COMMENT 'Patient vital signs measurements';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`observation` (
    `observation_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `flowsheet_row_id` BIGINT COMMENT 'FK to flowsheet row',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `measure_id` BIGINT COMMENT 'FK to quality measure',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `amendment_reason` STRING COMMENT 'Amendment reason',
    `assessment_component` STRING COMMENT 'Assessment component',
    `assessment_score` DECIMAL(18,2) COMMENT 'Assessment score',
    `assessment_tool` STRING COMMENT 'Assessment tool',
    `body_site_code` STRING COMMENT 'Body site code',
    `body_system` STRING COMMENT 'Body system',
    `care_setting` STRING COMMENT 'Care setting',
    `observation_category` STRING COMMENT 'Observation category',
    `created_datetime` TIMESTAMP COMMENT 'Created datetime',
    `critical_value_notified_datetime` TIMESTAMP COMMENT 'Critical value notification datetime',
    `data_absent_reason` STRING COMMENT 'Data absent reason',
    `datetime` TIMESTAMP COMMENT 'Observation datetime',
    `device_type` STRING COMMENT 'Device type',
    `external_observation_code` STRING COMMENT 'External observation code',
    `interpretation_flag` BOOLEAN COMMENT 'Interpretation flag',
    `is_amended` BOOLEAN COMMENT 'Amended flag',
    `is_critical_value` BOOLEAN COMMENT 'Critical value flag',
    `issued_datetime` TIMESTAMP COMMENT 'Issued datetime',
    `laterality` STRING COMMENT 'Laterality',
    `local_code` STRING COMMENT 'Local code',
    `method_code` STRING COMMENT 'Method code',
    `observation_status` STRING COMMENT 'Observation status',
    `presence_status` STRING COMMENT 'Presence status',
    `reference_range_high` DECIMAL(18,2) COMMENT 'Reference range high',
    `reference_range_low` DECIMAL(18,2) COMMENT 'Reference range low',
    `sdoh_domain` STRING COMMENT 'SDOH domain',
    `severity` STRING COMMENT 'Severity',
    `subcategory` STRING COMMENT 'Subcategory',
    `updated_datetime` TIMESTAMP COMMENT 'Updated datetime',
    `value_coded` STRING COMMENT 'Coded value',
    `value_coded_system` STRING COMMENT 'Coded value system',
    `value_numeric` DECIMAL(18,2) COMMENT 'Numeric value',
    `value_text` STRING COMMENT 'Text value',
    `value_unit` STRING COMMENT 'Value unit',
    CONSTRAINT pk_observation PRIMARY KEY(`observation_id`)
) COMMENT 'Clinical observations and assessments';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'Primary key',
    `set_id` BIGINT COMMENT 'FK to order set',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `consent_record_id` BIGINT COMMENT 'FK to consent record',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED',
    `clinician_id` BIGINT COMMENT 'FK to PCP',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `aco_attributed` BOOLEAN COMMENT 'ACO attributed flag',
    `advance_directive_on_file` BOOLEAN COMMENT 'Advance directive on file',
    `authored_date` DATE COMMENT 'Authored date',
    `behavioral_health_flag` BOOLEAN COMMENT 'Behavioral health flag',
    `care_setting` STRING COMMENT 'Care setting',
    `cdi_review_status` STRING COMMENT 'CDI review status',
    `confidentiality_level` STRING COMMENT 'Confidentiality level',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `care_plan_description` STRING COMMENT 'Care plan description',
    `discharge_disposition` STRING COMMENT 'Discharge disposition',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `external_plan_code` STRING COMMENT 'External plan code',
    `fhir_resource_reference` STRING COMMENT 'FHIR resource reference',
    `goal_count` STRING COMMENT 'Goal count',
    `goals_achieved_count` STRING COMMENT 'Goals achieved count',
    `intent` STRING COMMENT 'Intent',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `last_reviewed_date` DATE COMMENT 'Last reviewed date',
    `next_review_date` DATE COMMENT 'Next review date',
    `patient_consent_date` DATE COMMENT 'Patient consent date',
    `patient_consent_obtained` BOOLEAN COMMENT 'Patient consent obtained',
    `plan_status` STRING COMMENT 'Plan status',
    `plan_title` STRING COMMENT 'Plan title',
    `plan_type` STRING COMMENT 'Plan type',
    `population_health_program` STRING COMMENT 'Population health program',
    `primary_diagnosis_description` STRING COMMENT 'Primary diagnosis description',
    `primary_icd10_code` STRING COMMENT 'Primary ICD-10 code',
    `readmission_risk_level` STRING COMMENT 'Readmission risk level',
    `review_frequency` STRING COMMENT 'Review frequency',
    `sdoh_flag` BOOLEAN COMMENT 'SDOH flag',
    `transitions_of_care_flag` BOOLEAN COMMENT 'Transitions of care flag',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Patient care plans';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` (
    `care_plan_goal_id` BIGINT COMMENT 'Primary key',
    `care_plan_id` BIGINT COMMENT 'FK to care plan',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `compliance_program_id` BIGINT COMMENT 'FK to compliance program',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `prescription_id` BIGINT COMMENT 'FK to prescription',
    `problem_id` BIGINT COMMENT 'FK to problem',
    `clinical_order_id` BIGINT COMMENT 'FK to supporting order',
    `loinc_code_id` BIGINT COMMENT 'FK to target LOINC',
    `observation_id` BIGINT COMMENT 'FK to target observation',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `achieved_date` DATE COMMENT 'Date goal achieved',
    `achievement_status` STRING COMMENT 'Achievement status',
    `barrier_notes` STRING COMMENT 'Barrier notes',
    `cancellation_reason` STRING COMMENT 'Cancellation reason',
    `cancelled_date` DATE COMMENT 'Cancelled date',
    `care_gap_related` BOOLEAN COMMENT 'Care gap related',
    `care_team_role` STRING COMMENT 'Care team role',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `current_value` DECIMAL(18,2) COMMENT 'Current value',
    `current_value_date` DATE COMMENT 'Current value date',
    `expressed_by_type` STRING COMMENT 'Expressed by type',
    `fhir_goal_reference` STRING COMMENT 'FHIR goal reference',
    `goal_category_display` STRING COMMENT 'Goal category display',
    `goal_category_snomed_code` STRING COMMENT 'Goal category SNOMED code',
    `goal_description` STRING COMMENT 'Goal description',
    `goal_external_code` STRING COMMENT 'Goal external code',
    `goal_status` STRING COMMENT 'Goal status',
    `goal_title` STRING COMMENT 'Goal title',
    `last_reviewed_date` DATE COMMENT 'Last reviewed date',
    `note` STRING COMMENT 'Note',
    `patient_agreement` BOOLEAN COMMENT 'Patient agreement',
    `priority` STRING COMMENT 'Priority',
    `review_frequency` STRING COMMENT 'Review frequency',
    `sdoh_related` BOOLEAN COMMENT 'SDOH related',
    `start_date` DATE COMMENT 'Start date',
    `status_changed_timestamp` TIMESTAMP COMMENT 'Status changed timestamp',
    `target_date` DATE COMMENT 'Target date',
    `target_value` DECIMAL(18,2) COMMENT 'Target value',
    `target_value_comparator` STRING COMMENT 'Target value comparator',
    `target_value_unit` STRING COMMENT 'Target value unit',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_care_plan_goal PRIMARY KEY(`care_plan_goal_id`)
) COMMENT 'Care plan goals and targets';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_team` (
    `care_team_id` BIGINT COMMENT 'Primary key',
    `care_plan_id` BIGINT COMMENT 'FK to care plan',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `improvement_initiative_id` BIGINT COMMENT 'FK to improvement initiative',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `clinician_id` BIGINT COMMENT 'FK to primary contact',
    `tertiary_care_member_provider_clinician_id` BIGINT COMMENT 'FK to tertiary care member',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `aco_attributed` BOOLEAN COMMENT 'ACO attributed',
    `care_coordination_level` STRING COMMENT 'Care coordination level',
    `care_setting` STRING COMMENT 'Care setting',
    `cdi_review_flag` BOOLEAN COMMENT 'CDI review flag',
    `coverage_end_timestamp` TIMESTAMP COMMENT 'Coverage end',
    `coverage_start_timestamp` TIMESTAMP COMMENT 'Coverage start',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `discharge_disposition_code` STRING COMMENT 'Discharge disposition',
    `ehr_care_team_csn` STRING COMMENT 'EHR care team CSN',
    `hie_shared` BOOLEAN COMMENT 'HIE shared',
    `is_multidisciplinary` BOOLEAN COMMENT 'Multidisciplinary flag',
    `is_on_call` BOOLEAN COMMENT 'On call flag',
    `is_primary_contact` BOOLEAN COMMENT 'Primary contact flag',
    `is_primary_team` BOOLEAN COMMENT 'Primary team flag',
    `member_end_date` DATE COMMENT 'Member end date',
    `member_role_code` STRING COMMENT 'Member role code',
    `member_role_name` STRING COMMENT 'Member role name',
    `member_start_date` DATE COMMENT 'Member start date',
    `member_status` STRING COMMENT 'Member status',
    `member_type` STRING COMMENT 'Member type',
    `npi` STRING COMMENT 'NPI',
    `reason_code` STRING COMMENT 'Reason code',
    `reason_description` STRING COMMENT 'Reason description',
    `sdoh_flag` BOOLEAN COMMENT 'SDOH flag',
    `source_system_team_code` STRING COMMENT 'Source system team code',
    `specialty_code` STRING COMMENT 'Specialty code',
    `specialty_name` STRING COMMENT 'Specialty name',
    `team_end_date` DATE COMMENT 'Team end date',
    `team_name` STRING COMMENT 'Team name',
    `team_start_date` DATE COMMENT 'Team start date',
    `team_status` STRING COMMENT 'Team status',
    `team_type` STRING COMMENT 'Team type',
    `transitions_of_care_flag` BOOLEAN COMMENT 'Transitions of care flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    `vbp_program_code` STRING COMMENT 'VBP program code',
    CONSTRAINT pk_care_team PRIMARY KEY(`care_team_id`)
) COMMENT 'Patient care teams';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` (
    `care_team_member_id` BIGINT COMMENT 'Primary key',
    `care_plan_id` BIGINT COMMENT 'FK to care plan',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `workflow_id` BIGINT COMMENT 'FK linking this clinical treatment record to the 42 CFR Part 2 behavioral-health/SUD consent workflow that authorizes its disclosure.',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `care_team_id` BIGINT COMMENT 'FK to care team',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `admission_date` DATE COMMENT 'Admission date',
    `assignment_end_date` DATE COMMENT 'Assignment end date',
    `assignment_start_date` DATE COMMENT 'Assignment start date',
    `assignment_type` STRING COMMENT 'Assignment type',
    `care_setting` STRING COMMENT 'Care setting',
    `care_team_category` STRING COMMENT 'Care team category',
    `clinical_focus` STRING COMMENT 'Clinical focus',
    `coverage_type` STRING COMMENT 'Coverage type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `discharge_date` DATE COMMENT 'Discharge date',
    `fte_allocation` DECIMAL(18,2) COMMENT 'FTE allocation',
    `handoff_timestamp` TIMESTAMP COMMENT 'Handoff timestamp',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `is_attending` BOOLEAN COMMENT 'Attending flag',
    `is_on_call` BOOLEAN COMMENT 'On call flag',
    `is_pcp` BOOLEAN COMMENT 'PCP flag',
    `is_primary_contact` BOOLEAN COMMENT 'Primary contact flag',
    `member_status` STRING COMMENT 'Member status',
    `member_type` STRING COMMENT 'Member type',
    `notes` STRING COMMENT 'Notes',
    `notification_preference` STRING COMMENT 'Notification preference',
    `npi` STRING COMMENT 'NPI',
    `relationship_to_patient` STRING COMMENT 'Relationship to patient',
    `removal_reason` STRING COMMENT 'Removal reason',
    `role_code` STRING COMMENT 'Role code',
    `role_name` STRING COMMENT 'Role name',
    `sequence_number` STRING COMMENT 'Sequence number',
    `snomed_role_code` STRING COMMENT 'SNOMED role code',
    `source_system_member_code` STRING COMMENT 'Source system member code',
    `specialty_code` STRING COMMENT 'Specialty code',
    `specialty_name` STRING COMMENT 'Specialty name',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_care_team_member PRIMARY KEY(`care_team_member_id`)
) COMMENT 'Care team member assignments';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` (
    `cdi_query_id` BIGINT COMMENT 'Primary key',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `cdi_worksheet_id` BIGINT COMMENT 'FK to CDI worksheet',
    `claim_id` BIGINT COMMENT 'FK to claim',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `audit_id` BIGINT COMMENT 'FK to compliance audit',
    `diagnosis_id` BIGINT COMMENT 'FK to diagnosis - contains health information',
    `drg_id` BIGINT COMMENT 'FK to DRG',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `improvement_initiative_id` BIGINT COMMENT 'FK to improvement initiative',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `note_id` BIGINT COMMENT 'FK to note',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `procedure_event_id` BIGINT COMMENT 'FK to procedure event',
    `clinical_order_id` BIGINT COMMENT 'FK to queried order',
    `report_id` BIGINT COMMENT 'FK to radiology report',
    `test_result_id` BIGINT COMMENT 'FK to test result',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `actual_reimbursement_impact` DECIMAL(18,2) COMMENT 'Actual reimbursement impact',
    `appeal_support_flag` BOOLEAN COMMENT 'Appeal support flag',
    `cc_mcc_status` STRING COMMENT 'CC/MCC status',
    `coding_impact_flag` BOOLEAN COMMENT 'Coding impact flag',
    `compliance_review_flag` BOOLEAN COMMENT 'Compliance review flag',
    `concurrent_review_flag` BOOLEAN COMMENT 'Concurrent review flag',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `documentation_gap_description` STRING COMMENT 'Documentation gap description',
    `drg_type` STRING COMMENT 'DRG type',
    `encounter_type` STRING COMMENT 'Encounter type',
    `expected_drg_code` STRING COMMENT 'Expected DRG code',
    `expected_drg_description` STRING COMMENT 'Expected DRG description',
    `expected_reimbursement_impact` DECIMAL(18,2) COMMENT 'Expected reimbursement impact',
    `final_drg_code` STRING COMMENT 'Final DRG code',
    `physician_query_method` STRING COMMENT 'Physician query method',
    `poa_indicator` STRING COMMENT 'POA indicator',
    `provider_response_text` STRING COMMENT 'Provider response text',
    `query_category` STRING COMMENT 'Query category',
    `query_expiration_date` DECIMAL(18,2) COMMENT 'Query expiration date',
    `query_issue_date` DATE COMMENT 'Query issue date',
    `query_number` STRING COMMENT 'Query number',
    `query_opportunity_flag` BOOLEAN COMMENT 'Query opportunity flag',
    `query_outcome` STRING COMMENT 'Query outcome',
    `query_response_date` DATE COMMENT 'Query response date',
    `query_status` STRING COMMENT 'Query status',
    `query_text` STRING COMMENT 'Query text',
    `query_type` STRING COMMENT 'Query type',
    `response_turnaround_hours` STRING COMMENT 'Response turnaround hours',
    `retrospective_review_flag` BOOLEAN COMMENT 'Retrospective review flag',
    `risk_of_mortality_level` STRING COMMENT 'Risk of mortality level',
    `severity_of_illness_level` STRING COMMENT 'Severity of illness level',
    `source_system_query_code` STRING COMMENT 'Source system query code',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_cdi_query PRIMARY KEY(`cdi_query_id`)
) COMMENT 'Clinical documentation improvement queries';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` (
    `cdi_worksheet_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `claim_id` BIGINT COMMENT 'FK to claim',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `audit_id` BIGINT COMMENT 'FK to audit',
    `compliance_program_id` BIGINT COMMENT 'FK to CDI program',
    `drg_id` BIGINT COMMENT 'FK to DRG',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `employee_id` BIGINT COMMENT 'FK to CDI employee',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `admit_date` DATE COMMENT 'Admit date',
    `cc_mcc_captured` BOOLEAN COMMENT 'CC/MCC captured',
    `cc_mcc_status` STRING COMMENT 'CC/MCC status',
    `completed_timestamp` TIMESTAMP COMMENT 'Completed timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `discharge_date` DATE COMMENT 'Discharge date',
    `documentation_gap_count` STRING COMMENT 'Documentation gap count',
    `documentation_gap_notes` STRING COMMENT 'Documentation gap notes',
    `drg_grouper_version` STRING COMMENT 'DRG grouper version',
    `drg_weight_change` DECIMAL(18,2) COMMENT 'DRG weight change',
    `encounter_type` STRING COMMENT 'Encounter type',
    `expected_reimbursement_impact` DECIMAL(18,2) COMMENT 'Expected reimbursement impact',
    `final_drg_code` STRING COMMENT 'Final DRG code',
    `final_drg_description` STRING COMMENT 'Final DRG description',
    `final_drg_weight` DECIMAL(18,2) COMMENT 'Final DRG weight',
    `hac_risk_flag` BOOLEAN COMMENT 'HAC risk flag',
    `los_at_review` STRING COMMENT 'LOS at review',
    `mdc_code` STRING COMMENT 'MDC code',
    `mrn` STRING COMMENT 'MRN',
    `payer_type` STRING COMMENT 'Payer type',
    `poa_status` STRING COMMENT 'POA status',
    `query_count` STRING COMMENT 'Query count',
    `query_opportunity_flag` BOOLEAN COMMENT 'Query opportunity flag',
    `query_response_status` STRING COMMENT 'Query response status',
    `review_date` DATE COMMENT 'Review date',
    `review_notes` STRING COMMENT 'Review notes',
    `review_outcome` STRING COMMENT 'Review outcome',
    `review_status` STRING COMMENT 'Review status',
    `review_timestamp` TIMESTAMP COMMENT 'Review timestamp',
    `review_type` STRING COMMENT 'Review type',
    `service_line` STRING COMMENT 'Service line',
    `source_system_worksheet_code` STRING COMMENT 'Source system worksheet code',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    `worksheet_number` STRING COMMENT 'Worksheet number',
    CONSTRAINT pk_cdi_worksheet PRIMARY KEY(`cdi_worksheet_id`)
) COMMENT 'CDI review worksheets';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` (
    `functional_status_id` BIGINT COMMENT 'Primary key',
    `care_plan_id` BIGINT COMMENT 'FK to care plan',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `icd_code_id` BIGINT COMMENT 'FK to ICD',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC',
    `measure_id` BIGINT COMMENT 'FK to quality measure',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `assessment_date` DATE COMMENT 'Assessment date',
    `assessment_tool` STRING COMMENT 'Assessment tool',
    `assessment_type` STRING COMMENT 'Assessment type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `total_score` DECIMAL(18,2) COMMENT 'Total score',
    CONSTRAINT pk_functional_status PRIMARY KEY(`functional_status_id`)
) COMMENT 'Patient functional status assessments';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` (
    `advance_directive_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `consent_record_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `record_id` BIGINT COMMENT 'FK to consent record',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `code_status` STRING COMMENT 'Code status',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `directive_status` STRING COMMENT 'Directive status',
    `directive_type` STRING COMMENT 'Directive type',
    `effective_date` DATE COMMENT 'Effective date',
    CONSTRAINT pk_advance_directive PRIMARY KEY(`advance_directive_id`)
) COMMENT 'Patient advance directives and code status';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` (
    `nursing_assessment_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `assessment_status` STRING COMMENT 'Assessment status',
    `assessment_timestamp` TIMESTAMP COMMENT 'Assessment timestamp',
    `assessment_type` STRING COMMENT 'Assessment type',
    `braden_score` STRING COMMENT 'Braden score',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `fall_risk_score` DECIMAL(18,2) COMMENT 'Fall risk score',
    `pain_score` STRING COMMENT 'Pain score',
    CONSTRAINT pk_nursing_assessment PRIMARY KEY(`nursing_assessment_id`)
) COMMENT 'Nursing assessments and documentation';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` (
    `hai_event_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `diagnosis_id` BIGINT COMMENT 'FK to diagnosis - contains health information',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `event_date` DATE COMMENT 'Event date',
    `hai_type` STRING COMMENT 'HAI type',
    `nhsn_reported` BOOLEAN COMMENT 'NHSN reported',
    `organism_name` STRING COMMENT 'Organism name',
    CONSTRAINT pk_hai_event PRIMARY KEY(`hai_event_id`)
) COMMENT 'Hospital-acquired infection events';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` (
    `clinical_finding_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `body_site` STRING COMMENT 'Body site',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `finding_date` DATE COMMENT 'Finding date',
    `finding_status` STRING COMMENT 'Finding status',
    `finding_type` STRING COMMENT 'Finding type',
    `severity` STRING COMMENT 'Severity',
    `ssot_canonical_reference` STRING COMMENT 'Distinct entity; counterpart radiology.radiology_finding serves a separate domain context',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT review: kept distinct from radiology.radiology_finding (documented as separate business concepts)',
    CONSTRAINT pk_clinical_finding PRIMARY KEY(`clinical_finding_id`)
) COMMENT 'Clinical findings and observations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` (
    `procedure_equipment_usage_id` BIGINT COMMENT 'Primary key',
    `equipment_asset_id` BIGINT COMMENT 'FK to equipment',
    `material_master_id` BIGINT COMMENT 'FK to material',
    `procedure_event_id` BIGINT COMMENT 'FK to procedure event',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `quantity_used` STRING COMMENT 'Quantity used',
    `udi` STRING COMMENT 'UDI',
    `usage_end_timestamp` TIMESTAMP COMMENT 'Usage end',
    `usage_start_timestamp` TIMESTAMP COMMENT 'Usage start',
    CONSTRAINT pk_procedure_equipment_usage PRIMARY KEY(`procedure_equipment_usage_id`)
) COMMENT 'Equipment and supplies used in procedures';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` (
    `plan_care_coordination_id` BIGINT COMMENT 'Primary key',
    `care_plan_id` BIGINT COMMENT 'FK to care plan',
    `care_team_id` BIGINT COMMENT 'FK to care team',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `coordination_date` DATE COMMENT 'Coordination date',
    `coordination_status` STRING COMMENT 'Coordination status',
    `coordination_type` STRING COMMENT 'Coordination type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    CONSTRAINT pk_plan_care_coordination PRIMARY KEY(`plan_care_coordination_id`)
) COMMENT 'Care coordination plans and activities';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`note_template` (
    `note_template_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Auto-generated attribute for facility.care_site_id',
    `parent_note_template_id` BIGINT COMMENT 'Self-referential FK to parent template',
    `body_text` STRING COMMENT 'Auto-generated attribute for clinical.body_text',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `specialty` STRING COMMENT 'Specialty',
    `template_body` STRING COMMENT 'Template body',
    `template_name` STRING COMMENT 'Template name',
    `template_status` STRING COMMENT 'Template status',
    `template_type` STRING COMMENT 'Template type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `version` STRING COMMENT 'Auto-generated attribute for clinical.version',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_note_template PRIMARY KEY(`note_template_id`)
) COMMENT 'Clinical note templates';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` (
    `outbreak_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `snomed_concept_id` BIGINT COMMENT 'Auto-generated attribute for reference.snomed_concept_id',
    `case_count` STRING COMMENT 'Case count',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `end_date` DATE COMMENT 'End date',
    `outbreak_name` STRING COMMENT 'Outbreak name',
    `organism_name` STRING COMMENT 'Organism name',
    `outbreak_status` STRING COMMENT 'Outbreak status',
    `public_health_reported` BOOLEAN COMMENT 'Auto-generated attribute for clinical.public_health_reported',
    `start_date` DATE COMMENT 'Start date',
    CONSTRAINT pk_outbreak PRIMARY KEY(`outbreak_id`)
) COMMENT 'Outbreak tracking and management';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` (
    `flowsheet_row_id` BIGINT COMMENT 'Primary key',
    `flowsheet_template_id` BIGINT COMMENT 'FK to flowsheet template',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC',
    `visit_id` BIGINT COMMENT 'Auto-generated attribute for encounter.visit_id',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_type` STRING COMMENT 'Data type',
    `display_order` STRING COMMENT 'Display order',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `recorded_timestamp` TIMESTAMP COMMENT 'Auto-generated attribute for clinical.recorded_timestamp',
    `recorded_value` DECIMAL(18,2) COMMENT 'Auto-generated attribute for clinical.recorded_value',
    `row_name` STRING COMMENT 'Row name',
    `row_type` STRING COMMENT 'Row type',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `value_unit` STRING COMMENT 'Auto-generated attribute for clinical.value_unit',
    CONSTRAINT pk_flowsheet_row PRIMARY KEY(`flowsheet_row_id`)
) COMMENT 'Flowsheet row definitions and data';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` (
    `flowsheet_template_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Auto-generated attribute for facility.care_site_id',
    `care_setting` STRING COMMENT 'Care setting',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `specialty` STRING COMMENT 'Specialty',
    `template_name` STRING COMMENT 'Template name',
    `template_status` STRING COMMENT 'Auto-generated attribute for clinical.template_status',
    `template_type` STRING COMMENT 'Template type',
    `version` STRING COMMENT 'Auto-generated attribute for clinical.version',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_flowsheet_template PRIMARY KEY(`flowsheet_template_id`)
) COMMENT 'Flowsheet templates';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` (
    `genetic_variant_id` BIGINT COMMENT 'Primary key for genetic_variant',
    `parent_genetic_variant_id` BIGINT COMMENT 'Self-referencing FK on genetic_variant (parent_genetic_variant_id)',
    `acmg_classification_criteria` STRING COMMENT 'Pipe- or comma-separated ACMG/AMP evidence criteria codes supporting the classification (e.g., PVS1, PM2, PP3).',
    `alternate_allele` STRING COMMENT 'Observed alternate (variant) nucleotide sequence at the position.',
    `associated_condition` STRING COMMENT 'Disease or clinical condition associated with the variant (e.g., Hereditary Breast and Ovarian Cancer Syndrome), typically MONDO/OMIM mapped.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located (1-22, X, Y, or MT).',
    `clinical_significance` STRING COMMENT 'ACMG/AMP-aligned clinical interpretation of variant pathogenicity. Critical for clinical decision support and patient genomic reports.',
    `clinvar_variation_code` STRING COMMENT 'NCBI ClinVar accession/variation identifier linking this variant to curated clinical significance assertions.',
    `cosmic_code` STRING COMMENT 'Catalogue of Somatic Mutations in Cancer identifier for somatic/oncology variants.',
    `dbsnp_rs_number` STRING COMMENT 'External canonical identifier from NCBI dbSNP database (e.g., rs6025) uniquely identifying the variant. Serves as the BUSINESS_IDENTIFIER for cross-system genomic interoperability.',
    `detection_method` STRING COMMENT 'Laboratory assay/technology used to detect the variant (NGS panel, whole genome/exome sequencing, Sanger, microarray, PCR).',
    `evidence_review_summary` STRING COMMENT 'Narrative summary of the supporting evidence and rationale for the assigned clinical significance.',
    `functional_prediction_score` DECIMAL(18,2) COMMENT 'Computational deleteriousness prediction score (e.g., CADD, REVEL) indicating likely functional impact of the variant.',
    `gene_hgnc_code` STRING COMMENT 'Stable HGNC numeric identifier for the affected gene, enabling unambiguous gene linkage independent of symbol changes.',
    `gene_symbol` STRING COMMENT 'Approved HGNC gene symbol in which the variant occurs (e.g., BRCA1, TP53). Key classification for clinical interpretation and reporting.',
    `genomic_end_position` BIGINT COMMENT '1-based genomic end coordinate of the variant on the reference assembly (equal to start for SNVs).',
    `genomic_start_position` BIGINT COMMENT '1-based genomic start coordinate of the variant on the reference assembly.',
    `hgvs_coding_notation` STRING COMMENT 'HGVS coding-level description of the variant relative to the reference transcript (e.g., c.5946delT).',
    `hgvs_protein_notation` STRING COMMENT 'HGVS protein-level description of the predicted amino acid change (e.g., p.Ser1982ArgfsTer22).',
    `inheritance_pattern` STRING COMMENT 'Genetic inheritance pattern associated with the variant or its disease association.',
    `interpretation_lab_name` STRING COMMENT 'Name of the molecular/genetics laboratory that performed the variant interpretation.',
    `interpretation_status` STRING COMMENT 'Current lifecycle state of the variant interpretation record. LIFECYCLE_STATUS for the resource.',
    `last_review_date` DATE COMMENT 'Date the variant classification was last reviewed/curated, supporting reclassification monitoring.',
    `loinc_code` STRING COMMENT 'LOINC code for the genetic test observation associated with reporting this variant, supporting clinical interoperability.',
    `molecular_consequence` STRING COMMENT 'Predicted functional consequence using Sequence Ontology terms (e.g., missense_variant, frameshift_variant, splice_donor_variant). [ENUM-REF-CANDIDATE: missense|nonsense|frameshift|splice_site|synonymous|intronic|regulatory — promote to reference product]',
    `omim_code` STRING COMMENT 'Online Mendelian Inheritance in Man identifier for the associated disease/phenotype.',
    `pharmacogenomic_flag` BOOLEAN COMMENT 'Indicates whether the variant has documented pharmacogenomic (drug response) relevance per PharmGKB/CPIC guidelines.',
    `pharmgkb_code` STRING COMMENT 'PharmGKB accession linking the variant to drug-gene interaction and dosing guidance.',
    `phi_containing_flag` BOOLEAN COMMENT 'Indicates whether instances of this variant record are linked to identifiable patient genomic data and thus subject to PHI handling controls under HIPAA.',
    `population_allele_frequency` DECIMAL(18,2) COMMENT 'Minor allele frequency observed in reference population databases (e.g., gnomAD), used to assess variant rarity. Principal MEASUREMENT_OR_VALUE for the resource.',
    `population_database_source` STRING COMMENT 'Reference population database from which the allele frequency was derived.',
    `prediction_algorithm` STRING COMMENT 'Name of the in silico prediction tool that produced the functional prediction score.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the variant reference record was first captured in the system.',
    `reference_allele` STRING COMMENT 'Reference nucleotide sequence at the variant position per the reference assembly.',
    `reference_assembly` STRING COMMENT 'Genome build/assembly version against which the genomic coordinates are reported.',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept identifier representing the variant finding or associated clinical condition.',
    `somatic_germline_origin` STRING COMMENT 'Indicates whether the variant is inherited (germline), acquired (somatic), or mosaic. Drives oncology vs hereditary reporting workflows.',
    `transcript_reference` STRING COMMENT 'RefSeq or Ensembl transcript accession (e.g., NM_007294.4) used as the reference sequence for HGVS coding annotation.',
    `variant_name` STRING COMMENT 'Human-readable canonical name or HGVS description of the variant (e.g., NM_000059.3:c.5946delT). Serves as the IDENTITY_LABEL for the resource.',
    `variant_type` STRING COMMENT 'Molecular category of the variant (single nucleotide variant, insertion, deletion, indel, copy number variation, structural). Primary CLASSIFICATION_OR_TYPE field.',
    `zygosity` STRING COMMENT 'Default or representative zygosity state of the variant when observed in a patient sample.',
    CONSTRAINT pk_genetic_variant PRIMARY KEY(`genetic_variant_id`)
) COMMENT 'Master reference table for genetic_variant. Referenced by genetic_variant_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` (
    `patient_risk_score_id` BIGINT COMMENT 'Primary key for patient_risk_score',
    `clinician_id` BIGINT COMMENT 'Identifier of the attributed or attending provider responsible for acting on this risk score, supporting provider-level accountability and care coordination.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Patient risk scores are computed primarily from diagnosed conditions. Linking the risk score to the originating clinical diagnosis provides in-domain lineage and connects this otherwise siloed ML mast',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whom this risk score assesses, linking the assessment back to the enterprise master patient index for care management and population health workflows.',
    `reviewed_by_provider_clinician_id` BIGINT COMMENT 'Identifier of the clinician who reviewed and acknowledged this risk score, supporting clinical oversight and intervention accountability.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which this risk score was generated, enabling temporal correlation of risk against a specific care visit or admission.',
    `superseded_patient_risk_score_id` BIGINT COMMENT 'Self-referencing FK on patient_risk_score (superseded_patient_risk_score_id)',
    `calculation_method` STRING COMMENT 'Methodology class used to compute the score, supporting model governance and interpretability requirements.',
    `comorbidity_index_score` DECIMAL(18,2) COMMENT 'Standardized comorbidity burden score (e.g., Charlson or Elixhauser) captured as an input feature to contextualize overall patient acuity.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval around the risk score, supporting clinical interpretation of prediction uncertainty.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval around the risk score, supporting clinical interpretation of prediction uncertainty.',
    `contributing_factors` STRING COMMENT 'Narrative or delimited summary of the key model features (e.g., comorbidities, labs, utilization) driving the score, supporting explainability and clinician trust.',
    `data_source_system` STRING COMMENT 'Name of the EHR or analytics platform that supplied the input data and executed the scoring, supporting lineage and reconciliation.',
    `effective_from_date` DATE COMMENT 'Date from which this risk assessment is considered clinically valid for care decisions.',
    `effective_until_date` DATE COMMENT 'Date after which this risk assessment is considered stale and should be recomputed; nullable for open-ended validity.',
    `intervention_recommended` STRING COMMENT 'Care management action suggested by the risk program in response to this score, supporting closed-loop intervention tracking.',
    `primary_risk_factor` STRING COMMENT 'The single most influential clinical or social factor contributing to the patients risk score, surfaced for actionable care planning.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk score record was first persisted to the clinical data platform, supporting audit and data lineage.',
    `review_timestamp` TIMESTAMP COMMENT 'Moment a clinician reviewed the risk score, supporting closed-loop care-management workflow auditing.',
    `risk_category` STRING COMMENT 'Stratification band assigned to the patient based on the score, used to drive care management interventions and prioritization.',
    `risk_model_name` STRING COMMENT 'Human-readable name of the risk-scoring algorithm or model used to compute this assessment (e.g., readmission, sepsis, fall, mortality, HCC). Exists so analysts can interpret which clinical risk dimension the score represents.',
    `risk_model_type` STRING COMMENT 'Categorical classification of the clinical outcome the risk model predicts, used to segment and filter risk scores by clinical purpose.',
    `risk_model_version` STRING COMMENT 'Version identifier of the risk model that produced this score, supporting model governance, reproducibility, and drift monitoring across model upgrades.',
    `risk_percentile` DECIMAL(18,2) COMMENT 'Percentile rank of this patients score relative to the reference population, helping clinicians understand relative risk standing across the panel.',
    `risk_probability` DECIMAL(18,2) COMMENT 'Predicted probability (0 to 1) of the modeled adverse outcome occurring for this patient, output directly by the predictive model for clinical decision support.',
    `risk_score_max` DECIMAL(18,2) COMMENT 'Highest possible value on this models score scale, providing context for interpreting where the patients score sits within the model range.',
    `risk_score_min` DECIMAL(18,2) COMMENT 'Lowest possible value on this models score scale, providing context for interpreting where the patients score sits within the model range.',
    `risk_score_value` DECIMAL(18,2) COMMENT 'The principal numeric output of the risk model representing the patients computed level of risk for the modeled outcome. This is the raw model output captured for downstream care decisions and analytics.',
    `risk_tier` STRING COMMENT 'Operational care-management tier derived from the risk category, aligning patients to specific intervention pathways and staffing intensity.',
    `score_event_timestamp` TIMESTAMP COMMENT 'The real-world moment the risk score was computed by the model, used as the principal business event time for trend and recency analysis.',
    `score_status` STRING COMMENT 'Current lifecycle state of the risk score record, indicating whether it remains the active assessment or has been replaced by a newer run.',
    CONSTRAINT pk_patient_risk_score PRIMARY KEY(`patient_risk_score_id`)
) COMMENT 'Master reference table for patient_risk_score. Referenced by patient_risk_score_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` (
    `clinical_nlp_result_id` BIGINT COMMENT 'Primary key for clinical_nlp_result',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or coder who reviewed and validated this NLP extraction result.',
    `ml_model_id` BIGINT COMMENT 'Reference to the NLP model or pipeline version that generated this extraction result.',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: Clinical NLP results are extracted FROM clinical notes; each NLP result row references the source note it was derived from. This replaces the generic clinical_note_id with a proper in-domain FK to cli',
    `source_document_note_id` BIGINT COMMENT 'Reference to the source clinical document or note that was processed by the NLP engine to generate this result.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter context in which the source documentation was created.',
    `source_clinical_nlp_result_id` BIGINT COMMENT 'Self-referencing FK on clinical_nlp_result (source_clinical_nlp_result_id)',
    `attribute_value` STRING COMMENT 'Associated value extracted for the concept where applicable, such as dosage for a medication or severity for a problem.',
    `code_system` STRING COMMENT 'The terminology system that the concept_code belongs to, identifying the vocabulary used for the mapped code.',
    `concept_code` STRING COMMENT 'The standardized terminology code (e.g., SNOMED CT, ICD-10, RxNorm, LOINC) to which the extracted concept was mapped.',
    `concept_display_name` STRING COMMENT 'Human-readable preferred name of the mapped clinical concept from the source terminology.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Model-assigned probability (0 to 1) indicating confidence that the extracted entity and its mapping are correct.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this NLP result record was first captured in the data store.',
    `cui` STRING COMMENT 'Unified Medical Language System (UMLS) Concept Unique Identifier assigned to the extracted concept for cross-vocabulary linkage.',
    `deidentified_flag` BOOLEAN COMMENT 'Indicates whether the NLP result was derived from a de-identified document under HIPAA Safe Harbor or Expert Determination.',
    `document_authored_timestamp` TIMESTAMP COMMENT 'Date and time the underlying source clinical document was authored, distinct from when NLP processing occurred.',
    `entity_type` STRING COMMENT 'Category of the clinical concept extracted by the NLP engine, classifying it as a problem, medication, procedure, lab, anatomy, symptom, or other.',
    `extracted_text` STRING COMMENT 'The verbatim text span extracted from the clinical document that represents the recognized clinical concept. Contains PHI.',
    `extraction_timestamp` TIMESTAMP COMMENT 'Date and time when the NLP pipeline produced this extraction result from the source document.',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the source clinical document that was processed.',
    `model_name` STRING COMMENT 'Name of the natural language processing model or pipeline (e.g., cTAKES, Amazon Comprehend Medical, clinicalBERT) that produced the extraction.',
    `model_version` STRING COMMENT 'Version label of the NLP model used, supporting reproducibility and result lineage across model upgrades.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose clinical documentation was processed to produce this NLP result.',
    `negation_flag` BOOLEAN COMMENT 'Indicates whether the extracted concept was asserted as negated in the source text (e.g., no chest pain). Critical for accurate clinical interpretation.',
    `normalized_term` STRING COMMENT 'The canonical or normalized form of the extracted concept after lexical normalization, used for terminology mapping.',
    `result_status` STRING COMMENT 'Workflow status of the NLP extraction result indicating its position in the validation and review lifecycle.',
    `review_required_flag` BOOLEAN COMMENT 'Indicates whether the extraction requires human clinician review, typically driven by low confidence or clinical significance.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the NLP result was reviewed by a human reviewer.',
    `section_name` STRING COMMENT 'Name of the document section (e.g., History of Present Illness, Assessment, Medications) in which the concept was found.',
    `semantic_type` STRING COMMENT 'The UMLS semantic type (TUI/category) classification of the extracted concept, such as Disease or Syndrome or Pharmacologic Substance.',
    `sentence_text` STRING COMMENT 'The full sentence from the source document containing the extracted concept, providing surrounding context. Contains PHI.',
    `span_end_offset` STRING COMMENT 'Character offset position where the extracted text span ends within the source document.',
    `span_start_offset` STRING COMMENT 'Character offset position where the extracted text span begins within the source document.',
    `subject_context` STRING COMMENT 'Identifies whether the extracted concept pertains to the patient, a family member, or another subject, derived from contextual assertion analysis.',
    `temporality_context` STRING COMMENT 'Temporal assertion of the concept indicating whether it is current, historical, hypothetical, or future-oriented.',
    `uncertainty_flag` BOOLEAN COMMENT 'Indicates whether the concept was expressed with uncertainty or as a possibility rather than a definitive assertion.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the extracted attribute value (e.g., mg, mmHg, mL), standardized where possible to UCUM.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this NLP result record was last modified, for example after review or status change.',
    CONSTRAINT pk_clinical_nlp_result PRIMARY KEY(`clinical_nlp_result_id`)
) COMMENT 'Master reference table for clinical_nlp_result. Referenced by clinical_nlp_result_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` (
    `care_gap_id` BIGINT COMMENT 'Primary key for care_gap',
    `care_plan_id` BIGINT COMMENT 'Reference to the care plan that incorporates the actions needed to address this care gap.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider attributed responsibility for closing this care gap (e.g., primary care physician).',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this care gap was identified.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this care gap was identified or addressed.',
    `superseded_care_gap_id` BIGINT COMMENT 'Self-referencing FK on care_gap (superseded_care_gap_id)',
    `clinical_condition_code` STRING COMMENT 'Diagnosis or condition code (ICD-10-CM or SNOMED CT) that triggers or relates to this care gap, such as the chronic disease driving a recommended intervention.',
    `closure_date` DATE COMMENT 'Date the care gap was satisfied by delivery of the recommended care or otherwise resolved.',
    `closure_method` STRING COMMENT 'Mechanism by which the care gap was determined to be closed, supporting audit and supplemental data reporting.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the patient is currently compliant with the associated quality measure for the measurement period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this care gap record was first created in the system.',
    `data_source` STRING COMMENT 'Source system or feed from which the evidence used to identify or close the care gap was derived.',
    `due_date` DATE COMMENT 'Date by which the recommended care should be delivered to remain compliant with the quality measure.',
    `exclusion_reason` STRING COMMENT 'Reason the care gap is excluded from numerator/denominator consideration, such as a valid clinical or administrative exclusion.',
    `gap_category` STRING COMMENT 'Classification of the care gap by the type of recommended care that is overdue or missing.',
    `gap_status` STRING COMMENT 'Current lifecycle state of the care gap indicating whether the recommended care remains outstanding, is being addressed, or has been satisfied.',
    `identification_date` DATE COMMENT 'Date on which the care gap was first identified through analytics, registry, or clinical review.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent patient outreach attempt related to closing this care gap.',
    `last_service_date` DATE COMMENT 'Date the recommended service was most recently delivered, used to determine recurrence intervals for periodic measures.',
    `measure_code` STRING COMMENT 'Standardized quality measure code defining the gap (e.g., HEDIS, CMS eCQM, or MIPS measure identifier) against which compliance is evaluated.',
    `measure_name` STRING COMMENT 'Human-readable name of the quality measure associated with this care gap (e.g., Breast Cancer Screening, HbA1c Control for Diabetes).',
    `measure_program` STRING COMMENT 'Quality program under which the care gap is tracked, such as HEDIS, MIPS, CMS Stars, or ACO measures.',
    `measurement_year` STRING COMMENT 'The HEDIS or quality program measurement year to which this care gap applies for reporting and rate calculation.',
    `outreach_status` STRING COMMENT 'Status of patient outreach activities undertaken to encourage the patient to obtain the recommended care.',
    `priority_level` STRING COMMENT 'Clinical priority assigned to this care gap to support population health outreach and care management triage.',
    `recommended_service_code` STRING COMMENT 'Procedure, test, or service code (CPT, HCPCS, or LOINC) representing the recommended action that would close the care gap.',
    `recommended_service_description` STRING COMMENT 'Narrative description of the recommended clinical action or intervention required to close the care gap.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this care gap record was last modified, reflecting status changes or new evidence.',
    CONSTRAINT pk_care_gap PRIMARY KEY(`care_gap_id`)
) COMMENT 'Master reference table for care_gap. Referenced by care_gap_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` (
    `model_inference_log_id` BIGINT COMMENT 'Primary key for model_inference_log',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who requested or acted upon the model inference, supporting clinical accountability.',
    `feature_store_entity_id` BIGINT COMMENT 'Foreign key linking to clinical.feature_store_entity. Business justification: ML model inference consumes features served from feature store entities; recording which feature_store_entity supplied inputs provides ML lineage and connects the model_inference_log master table in-d',
    `ml_model_id` BIGINT COMMENT 'Reference to the registered AI/ML model that produced this inference. Identifies the source model emitting the prediction event.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter context in which the inference was generated, supporting care-episode traceability.',
    `superseded_model_inference_log_id` BIGINT COMMENT 'Self-referencing FK on model_inference_log (superseded_model_inference_log_id)',
    `clinical_use_case` STRING COMMENT 'Clinical decision-support use case the inference supports (e.g., sepsis prediction, fall risk, length-of-stay forecast).',
    `clinician_override_flag` BOOLEAN COMMENT 'Indicates whether a clinician overrode or rejected the model recommendation, supporting human-in-the-loop governance and adoption analysis.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Model-reported confidence or calibrated certainty associated with the prediction, between 0 and 1.',
    `data_drift_detected` BOOLEAN COMMENT 'Indicates whether input feature distribution drift was detected for this inference relative to the training baseline.',
    `drift_score` DECIMAL(18,2) COMMENT 'Quantitative measure of input or prediction drift computed for monitoring model degradation over time.',
    `error_message` STRING COMMENT 'Diagnostic message captured when the inference failed or returned an exception, supporting operational troubleshooting.',
    `explainability_method` STRING COMMENT 'Interpretability technique applied to generate feature-attribution explanations for this clinical inference.',
    `feature_set_version` STRING COMMENT 'Version of the feature pipeline or feature store schema used to build inputs, ensuring reproducibility of the inference.',
    `inference_latency_ms` STRING COMMENT 'Elapsed time in milliseconds to compute the prediction, supporting performance and SLA monitoring of clinical serving infrastructure.',
    `inference_status` STRING COMMENT 'Outcome status of the inference execution, distinguishing successful predictions from failures or fallbacks.',
    `inference_timestamp` TIMESTAMP COMMENT 'Precise timestamp at which the model produced the prediction. The principal real-world event time for this log record.',
    `inference_type` STRING COMMENT 'Mode in which the inference was executed: real-time online call, batch scoring, streaming, or shadow evaluation.',
    `input_feature_count` STRING COMMENT 'Number of input features supplied to the model for this inference, supporting completeness and drift monitoring.',
    `model_name` STRING COMMENT 'Human-readable name of the AI/ML model that generated the inference (e.g., sepsis early-warning model, readmission risk model).',
    `model_task_type` STRING COMMENT 'Category of machine-learning task the model performs, used for monitoring and analytics segmentation.',
    `model_version` STRING COMMENT 'Semantic version of the model artifact used for this inference, enabling reproducibility and regulatory change control.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose clinical data was the subject of the inference. PHI as it links a prediction to an identifiable individual.',
    `prediction_output` STRING COMMENT 'Principal predicted value or label returned by the model for this clinical subject (e.g., predicted risk class, recommended code). PHI as it conveys clinical inference about a patient.',
    `prediction_score` DECIMAL(18,2) COMMENT 'Numeric probability or risk score produced by the model for the primary prediction, used for clinical thresholding and triage.',
    `prediction_threshold` DECIMAL(18,2) COMMENT 'Operating threshold applied to the score to derive the binary or categorical clinical decision at inference time.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the model under SaMD / clinical decision-support rules, governing oversight and audit obligations for the inference.',
    `request_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the inference request was received by the serving endpoint, used to derive end-to-end latency.',
    `serving_environment` STRING COMMENT 'Deployment environment in which the inference was served, distinguishing production clinical use from validation runs.',
    `top_contributing_factors` STRING COMMENT 'Summary of the most influential input features driving the prediction, supporting clinical transparency and review. PHI as it can reveal patient clinical attributes.',
    CONSTRAINT pk_model_inference_log PRIMARY KEY(`model_inference_log_id`)
) COMMENT 'Master reference table for model_inference_log. Referenced by model_inference_log_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` (
    `feature_store_entity_id` BIGINT COMMENT 'Primary key for feature_store_entity',
    `parent_feature_store_entity_id` BIGINT COMMENT 'Self-referencing FK on feature_store_entity (parent_feature_store_entity_id)',
    `contains_phi_flag` BOOLEAN COMMENT 'Indicates whether features grouped under this entity contain Protected Health Information, driving HIPAA row-level security and dynamic data masking requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature store entity was first registered in the catalog.',
    `data_classification` STRING COMMENT 'Information sensitivity classification governing access controls applied to features for this entity; clinical entities frequently carry PHI and are classified restricted.',
    `description_text` STRING COMMENT 'Detailed business description of what the entity represents, what clinical or analytical use cases it supports, and how it is intended to be used by ML teams.',
    `domain_name` STRING COMMENT 'Name of the data domain that owns this feature store entity (e.g., clinical), supporting domain-aligned governance and feature ownership.',
    `effective_from_date` DATE COMMENT 'Date from which this version of the entity definition becomes active and available for feature registration and serving.',
    `effective_until_date` DATE COMMENT 'Date on which this entity definition ceases to be active; null for currently open-ended definitions.',
    `entity_business_key` STRING COMMENT 'The externally-known unique business code/reference for this entity grouping, used to register and discover the entity in the catalog (e.g., a fully-qualified entity registration name).',
    `entity_key_column` STRING COMMENT 'Name of the join/lookup key column that uniquely identifies a row for this entity (e.g., patient_id). Used to join feature tables to training and inference datasets.',
    `entity_name` STRING COMMENT 'Human-readable, snake_case logical name of the feature store entity (e.g., patient_demographics, encounter_visit). Serves as the identity label used by data scientists when referencing feature lookups.',
    `entity_status` STRING COMMENT 'Current lifecycle state of the feature store entity, indicating whether it is available for production feature serving or has been retired.',
    `entity_type` STRING COMMENT 'Categorical classification of the subject the entity represents, segmenting the population of feature entities by clinical subject area.',
    `feature_count` STRING COMMENT 'Number of distinct features currently registered against this entity, a structural fact describing the breadth of the entitys feature coverage.',
    `feature_table_name` STRING COMMENT 'Fully-qualified Unity Catalog feature table that physically stores feature values keyed by this entity, supporting feature serving for clinical ML workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the entity definition or its metadata was last updated.',
    `online_store_enabled_flag` BOOLEAN COMMENT 'Indicates whether features for this entity are published to an online store for low-latency real-time inference (e.g., at point of care).',
    `owner_team` STRING COMMENT 'Name of the data science or data engineering team accountable for stewardship, quality, and lifecycle of this feature store entity.',
    `primary_coding_system` STRING COMMENT 'Principal clinical terminology standard most relevant to features derived for this entity, supporting standardized interpretation of clinical feature values.',
    `refresh_frequency` STRING COMMENT 'Cadence at which feature values for this entity are recomputed and materialized, supporting freshness expectations for clinical ML use cases.',
    `retention_period_days` STRING COMMENT 'Number of days feature values for this entity are retained before purging, aligned to HIPAA and organizational data retention policy.',
    `source_system_name` STRING COMMENT 'Operational system of record (e.g., EHR/EMR) from which the underlying clinical data for this entitys features originates.',
    `steward_email` STRING COMMENT 'Contact email of the designated data steward responsible for governance and access approvals for this entitys features.',
    `timeseries_column` STRING COMMENT 'Name of the timestamp column used for point-in-time feature lookups, ensuring training data avoids feature leakage for time-aware clinical models.',
    `version_number` STRING COMMENT 'Semantic version of the entity definition, supporting reproducibility and lineage of features across model training iterations.',
    CONSTRAINT pk_feature_store_entity PRIMARY KEY(`feature_store_entity_id`)
) COMMENT 'Master reference table for feature_store_entity. Referenced by feature_store_entity_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` (
    `ml_model_id` BIGINT COMMENT 'Primary key for ml_model',
    `predecessor_ml_model_id` BIGINT COMMENT 'Self-referencing FK on ml_model (predecessor_ml_model_id)',
    `algorithm_family` STRING COMMENT 'The underlying algorithm or architecture family of the model (e.g., gradient_boosting, transformer, random_forest, logistic_regression). [ENUM-REF-CANDIDATE: gradient_boosting|transformer|random_forest|logistic_regression|neural_network|svm|gradient_descent — promote to reference product]',
    `approval_date` DATE COMMENT 'Date the model received clinical governance/AI committee approval for deployment.',
    `artifact_uri` STRING COMMENT 'Storage location reference (URI/path) of the serialized model artifact in the registry/object store.',
    `clinical_use_case` STRING COMMENT 'Description of the clinical problem the model addresses (e.g., readmission risk, sepsis prediction, image classification), supporting clinical decision-support workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model registry record was first captured.',
    `data_sensitivity_level` STRING COMMENT 'Classification of the data handled by the model for governance and access-control purposes.',
    `decision_threshold` DECIMAL(18,2) COMMENT 'Probability cutoff applied to convert the model score into a clinical alert/positive classification.',
    `deployment_date` DATE COMMENT 'Date the model began serving production clinical predictions.',
    `deployment_stage` STRING COMMENT 'Current MLOps deployment stage of the model in the registry, indicating whether it is serving live clinical traffic.',
    `drift_status` STRING COMMENT 'Current data/concept drift status reported by the monitoring system, signaling whether retraining may be required.',
    `explainability_method` STRING COMMENT 'Technique used to provide interpretability of predictions to clinicians, supporting clinical trust and regulatory transparency.',
    `fairness_bias_assessed` BOOLEAN COMMENT 'Indicates whether a subgroup fairness/bias assessment (e.g., across race, sex, age) was performed, required for responsible clinical AI deployment.',
    `fda_clearance_number` STRING COMMENT 'FDA 510(k)/De Novo/PMA clearance number if the model is a cleared medical device, supporting regulatory traceability.',
    `feature_count` STRING COMMENT 'Number of input features consumed by the model, indicating model complexity and feature engineering scope.',
    `framework` STRING COMMENT 'Machine learning framework used to build the model (e.g., scikit-learn, tensorflow, pytorch, xgboost). [ENUM-REF-CANDIDATE: scikit_learn|tensorflow|pytorch|xgboost|lightgbm|h2o|spark_mllib — promote to reference product]',
    `intended_use_statement` STRING COMMENT 'Formal regulatory intended-use statement describing the patient population, clinical setting, and decision the model informs. Required for clinical AI governance.',
    `model_name` STRING COMMENT 'Human-readable name of the clinical machine learning model (e.g., Sepsis Early Warning Predictor). Identity label used by data scientists and clinical informaticians to reference the model.',
    `model_owner` STRING COMMENT 'Name of the data scientist or clinical informatician accountable for the model lifecycle and governance.',
    `model_registry_key` STRING COMMENT 'Externally-known unique business code for the model in the MLflow/Unity Catalog model registry, used as the cross-system reference identifier for the model artifact.',
    `model_status` STRING COMMENT 'Current lifecycle state of the model within the clinical ML governance process, from development through retirement.',
    `model_type` STRING COMMENT 'High-level categorical type of the ML model that segments the registry by learning task.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether ongoing performance and drift monitoring is active for the deployed model, required for post-market surveillance of clinical AI.',
    `owning_department` STRING COMMENT 'Clinical or analytics department responsible for the model (e.g., Clinical Informatics, Cardiology Analytics).',
    `phi_data_used` BOOLEAN COMMENT 'Indicates whether Protected Health Information was used in training the model, triggering HIPAA governance and de-identification controls.',
    `primary_metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary performance metric on the validation/test set — the principal quantitative fact about the model.',
    `primary_performance_metric` STRING COMMENT 'The principal evaluation metric used to judge model performance for its clinical task.',
    `regulatory_classification` STRING COMMENT 'FDA SaMD regulatory classification of the model, determining the governance and clearance pathway required.',
    `retirement_date` DATE COMMENT 'Date the model was retired or deprecated from clinical use (nullable for active models).',
    `retraining_frequency` STRING COMMENT 'Planned cadence for retraining/recalibrating the model to maintain clinical performance.',
    `sensitivity` DECIMAL(18,2) COMMENT 'True positive rate of the model on the held-out evaluation set, critical for clinical safety assessment of diagnostic/screening models.',
    `specificity` DECIMAL(18,2) COMMENT 'True negative rate of the model on the held-out evaluation set, used to evaluate false-alert burden in clinical settings.',
    `target_outcome` STRING COMMENT 'The clinical outcome or label the model predicts (e.g., 30-day mortality, ICU transfer, positive lab result).',
    `training_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when model training finished, marking the principal model-build event.',
    `training_dataset_description` STRING COMMENT 'Description of the dataset and cohort used to train the model, including data source domains and inclusion criteria. Supports reproducibility and bias auditing.',
    `training_sample_size` BIGINT COMMENT 'Number of records/patients in the training dataset, used to assess statistical robustness of the model.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this model registry record was last modified.',
    `validation_date` DATE COMMENT 'Date the model passed its clinical validation review.',
    `validation_method` STRING COMMENT 'Methodology used to validate the model (e.g., temporal split, external site validation), important for clinical generalizability claims.',
    `version_label` STRING COMMENT 'Semantic or registry version label of the model (e.g., v2.1.0). Distinguishes successive trained iterations of the same model lineage.',
    CONSTRAINT pk_ml_model PRIMARY KEY(`ml_model_id`)
) COMMENT 'Master reference table for ml_model. Referenced by model_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_genetic_variant_id` FOREIGN KEY (`genetic_variant_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`genetic_variant`(`genetic_variant_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_note_template_id` FOREIGN KEY (`note_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note_template`(`note_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_parent_note_id` FOREIGN KEY (`parent_note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_previous_vital_sign_id` FOREIGN KEY (`previous_vital_sign_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_flowsheet_row_id` FOREIGN KEY (`flowsheet_row_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`flowsheet_row`(`flowsheet_row_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_cdi_worksheet_id` FOREIGN KEY (`cdi_worksheet_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`cdi_worksheet`(`cdi_worksheet_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_parent_note_template_id` FOREIGN KEY (`parent_note_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note_template`(`note_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_flowsheet_template_id` FOREIGN KEY (`flowsheet_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`flowsheet_template`(`flowsheet_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ADD CONSTRAINT `fk_clinical_genetic_variant_parent_genetic_variant_id` FOREIGN KEY (`parent_genetic_variant_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`genetic_variant`(`genetic_variant_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_patient_risk_score_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_patient_risk_score_superseded_patient_risk_score_id` FOREIGN KEY (`superseded_patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_clinical_nlp_result_ml_model_id` FOREIGN KEY (`ml_model_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`ml_model`(`ml_model_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_clinical_nlp_result_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_clinical_nlp_result_source_document_note_id` FOREIGN KEY (`source_document_note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_clinical_nlp_result_source_clinical_nlp_result_id` FOREIGN KEY (`source_clinical_nlp_result_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result`(`clinical_nlp_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ADD CONSTRAINT `fk_clinical_care_gap_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ADD CONSTRAINT `fk_clinical_care_gap_superseded_care_gap_id` FOREIGN KEY (`superseded_care_gap_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_gap`(`care_gap_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ADD CONSTRAINT `fk_clinical_model_inference_log_feature_store_entity_id` FOREIGN KEY (`feature_store_entity_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`feature_store_entity`(`feature_store_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ADD CONSTRAINT `fk_clinical_model_inference_log_ml_model_id` FOREIGN KEY (`ml_model_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`ml_model`(`ml_model_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ADD CONSTRAINT `fk_clinical_model_inference_log_superseded_model_inference_log_id` FOREIGN KEY (`superseded_model_inference_log_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`model_inference_log`(`model_inference_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ADD CONSTRAINT `fk_clinical_feature_store_entity_parent_feature_store_entity_id` FOREIGN KEY (`parent_feature_store_entity_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`feature_store_entity`(`feature_store_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ADD CONSTRAINT `fk_clinical_ml_model_predecessor_ml_model_id` FOREIGN KEY (`predecessor_ml_model_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`ml_model`(`ml_model_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('pii_domain' = 'clinical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('pii_icd10' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('pii_drg_impact' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_business_glossary_term' = 'Genetic Variant Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('pii_business_glossary_term' = 'Admit Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_flag` SET TAGS ('pii_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_status` SET TAGS ('pii_business_glossary_term' = 'CDI Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('pii_business_glossary_term' = 'Clinical Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_date` SET TAGS ('pii_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_status` SET TAGS ('pii_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('pii_business_glossary_term' = 'CC/MCC Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('pii_business_glossary_term' = 'Discharge Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drg_relevant_flag` SET TAGS ('pii_business_glossary_term' = 'DRG Relevant Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('pii_business_glossary_term' = 'Encounter Diagnosis Source');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_type` SET TAGS ('pii_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('pii_business_glossary_term' = 'External Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `hac_flag` SET TAGS ('pii_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mcc_flag` SET TAGS ('pii_business_glossary_term' = 'MCC Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('pii_business_glossary_term' = 'Note Text');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `onset_date` SET TAGS ('pii_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `present_on_admission` SET TAGS ('pii_business_glossary_term' = 'Present on Admission');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('pii_business_glossary_term' = 'Problem List Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Rank');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `recorded_timestamp` SET TAGS ('pii_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('pii_business_glossary_term' = 'SDOH Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Source System Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_cpt' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_surgical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('pii_billing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Event Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'OR Room');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Originating Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Preop Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Primary Procedure Clinician');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Provider');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `anesthesia_type` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `approach` SET TAGS ('pii_business_glossary_term' = 'Approach');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `asa_classification` SET TAGS ('pii_business_glossary_term' = 'ASA Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `body_site` SET TAGS ('pii_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cdm_code` SET TAGS ('pii_business_glossary_term' = 'CDM Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_1` SET TAGS ('pii_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_2` SET TAGS ('pii_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('pii_business_glossary_term' = 'Estimated Blood Loss');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `icd10_pcs_code` SET TAGS ('pii_business_glossary_term' = 'ICD-10-PCS Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('pii_business_glossary_term' = 'Procedure Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('pii_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Procedure End Datetime');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('pii_business_glossary_term' = 'Procedure Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Procedure Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('pii_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('pii_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `rvu_work` SET TAGS ('pii_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `service_line` SET TAGS ('pii_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `snomed_ct_code` SET TAGS ('pii_business_glossary_term' = 'SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('pii_business_glossary_term' = 'Specimen Collected');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `timeout_performed` SET TAGS ('pii_business_glossary_term' = 'Timeout Performed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `udi` SET TAGS ('pii_business_glossary_term' = 'UDI');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `wound_classification` SET TAGS ('pii_business_glossary_term' = 'Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_nlp' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_cdi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_id` SET TAGS ('pii_business_glossary_term' = 'Note Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'LOINC Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_template_id` SET TAGS ('pii_business_glossary_term' = 'Note Template');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `parent_note_id` SET TAGS ('pii_business_glossary_term' = 'Parent Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Cosigner Provider');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `amended_timestamp` SET TAGS ('pii_business_glossary_term' = 'Amended Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `author_role` SET TAGS ('pii_business_glossary_term' = 'Author Role');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `authored_timestamp` SET TAGS ('pii_business_glossary_term' = 'Authored Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_flag` SET TAGS ('pii_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_status` SET TAGS ('pii_business_glossary_term' = 'CDI Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cosigned_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cosigned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `dictation_method` SET TAGS ('pii_business_glossary_term' = 'Dictation Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `drg_impact_flag` SET TAGS ('pii_business_glossary_term' = 'DRG Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `encounter_type` SET TAGS ('pii_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Format');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_addendum` SET TAGS ('pii_business_glossary_term' = 'Is Addendum');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_copy_forwarded` SET TAGS ('pii_business_glossary_term' = 'Is Copy Forwarded');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_late_entry` SET TAGS ('pii_business_glossary_term' = 'Is Late Entry');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_status` SET TAGS ('pii_business_glossary_term' = 'Note Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_type` SET TAGS ('pii_business_glossary_term' = 'Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `sensitive_note_type` SET TAGS ('pii_business_glossary_term' = 'Sensitive Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_line` SET TAGS ('pii_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `signed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `source_system_note_code` SET TAGS ('pii_business_glossary_term' = 'Source System Note Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `specialty` SET TAGS ('pii_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('pii_business_glossary_term' = 'Note Text');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `word_count` SET TAGS ('pii_business_glossary_term' = 'Word Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('pii_problem_list' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `prescription_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `prescription_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('pii_allergy' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `consent_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('pii_immunization' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_timestamp` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_obtained` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_obtained` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('pii_vital_signs' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `is_patient_reported` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `is_patient_reported` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `patient_position` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `patient_position` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('pii_observation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('pii_care_plan' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_obtained` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_obtained` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('pii_care_goal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `observation_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `observation_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `patient_agreement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `patient_agreement` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('pii_care_team' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `tertiary_care_member_provider_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `tertiary_care_member_provider_clinician_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_end_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_start_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `specialty_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `specialty_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('pii_care_team' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `workflow_id` SET TAGS ('pii_business_glossary_term' = '42 CFR Part 2 Consent Linkage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `workflow_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `workflow_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `workflow_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `relationship_to_patient` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `specialty_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `specialty_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('pii_cdi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_subtype' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_category' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `test_result_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('pii_cdi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('pii_functional_status' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('pii_advance_directive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `consent_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `consent_record_id` SET TAGS ('pii_part2_42cfr' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `consent_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `consent_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('pii_nursing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('pii_subdomain' = 'infection_surveillance');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('pii_infection_control' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_subtype' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_category' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `organism_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `organism_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('pii_finding' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('pii_association_edges' = 'clinical.procedure_event,facility.equipment_asset');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('pii_equipment' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_equipment_usage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_equipment_usage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('pii_subdomain' = 'patient_care');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('pii_association_edges' = 'clinical.care_plan,insurance.health_plan');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('pii_care_coordination' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` SET TAGS ('pii_template' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `template_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('pii_subdomain' = 'infection_surveillance');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('pii_infection_control' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `organism_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `organism_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_reported` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_reported` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_reported` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_reported` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('pii_flowsheet' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `row_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `row_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` SET TAGS ('pii_subdomain' = 'clinical_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` SET TAGS ('pii_template' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `template_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ALTER COLUMN `genetic_variant_id` SET TAGS ('pii_business_glossary_term' = 'Genetic Variant Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ALTER COLUMN `parent_genetic_variant_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ALTER COLUMN `interpretation_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ALTER COLUMN `interpretation_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ALTER COLUMN `variant_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`genetic_variant` ALTER COLUMN `variant_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Patient Risk Score Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `patient_risk_score_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `superseded_patient_risk_score_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `superseded_patient_risk_score_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `superseded_patient_risk_score_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `comorbidity_index_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `comorbidity_index_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `contributing_factors` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `intervention_recommended` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `intervention_recommended` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `primary_risk_factor` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `primary_risk_factor` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_model_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_percentile` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_percentile` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_probability` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_probability` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`patient_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `clinical_nlp_result_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Nlp Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `note_id` SET TAGS ('pii_business_glossary_term' = 'Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `source_clinical_nlp_result_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `concept_display_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `concept_display_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `extracted_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `extracted_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `model_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `normalized_term` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `normalized_term` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `section_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `sentence_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_nlp_result` ALTER COLUMN `sentence_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `care_gap_id` SET TAGS ('pii_business_glossary_term' = 'Care Gap Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `superseded_care_gap_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `clinical_condition_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `clinical_condition_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `closure_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `closure_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `due_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `due_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `identification_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `identification_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `last_service_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `last_service_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `measure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_gap` ALTER COLUMN `measure_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `model_inference_log_id` SET TAGS ('pii_business_glossary_term' = 'Model Inference Log Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `feature_store_entity_id` SET TAGS ('pii_business_glossary_term' = 'Feature Store Entity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `superseded_model_inference_log_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `model_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `prediction_output` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `prediction_output` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `prediction_score` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `prediction_score` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `top_contributing_factors` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`model_inference_log` ALTER COLUMN `top_contributing_factors` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `feature_store_entity_id` SET TAGS ('pii_business_glossary_term' = 'Feature Store Entity Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `parent_feature_store_entity_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `domain_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `domain_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `entity_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `feature_table_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `source_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `source_system_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `steward_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `steward_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `steward_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`feature_store_entity` ALTER COLUMN `steward_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` SET TAGS ('pii_subdomain' = 'intelligence_analytics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `ml_model_id` SET TAGS ('pii_business_glossary_term' = 'Ml Model Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `predecessor_ml_model_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `model_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `model_owner` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `model_owner` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `specificity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`ml_model` ALTER COLUMN `specificity` SET TAGS ('pii_uc_classification' = 'pii');
