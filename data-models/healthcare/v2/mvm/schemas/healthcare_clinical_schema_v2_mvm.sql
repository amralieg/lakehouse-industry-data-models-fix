-- Schema for Domain: clinical | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`clinical` COMMENT 'Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for each diagnosis record.',
    `clinical_order_id` BIGINT COMMENT 'FK to the clinical order that triggered or documented this diagnosis.',
    `clinician_id` BIGINT COMMENT 'FK to the clinician who documented the diagnosis.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: MS-DRG assignment is directly driven by principal diagnosis in CDI and coding workflows. Linking diagnosis to DRG supports CDI query validation, reimbursement accuracy reporting, and HAC/MCC-based DRG',
    `icd_code_id` BIGINT COMMENT 'FK to the ICD-10 code reference table.',
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
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Procedures are often performed as part of a care plan (e.g., scheduled surgeries, therapeutic procedures, diagnostic workups ordered under a care plan). Adding care_plan_id to procedure_event enables ',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Medical necessity review and claims adjudication require knowing which coverage policy applied to a procedure. Denial management, utilization review, and regulatory audits all depend on tracing a proc',
    `cpt_code_id` BIGINT COMMENT 'FK to the CPT code reference table.',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Perioperative pharmacy requires linking procedural medication dispense events (anesthesia drugs, contrast agents, procedural sedation) to the procedure that triggered them for charge capture, drug uti',
    `drg_id` BIGINT COMMENT 'FK to DRG if procedure impacts DRG assignment.',
    `drug_master_id` BIGINT COMMENT 'FK to drug master if procedure involved medication administration.',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Charge capture and expected reimbursement calculation require linking each procedure event to the applicable fee schedule line. Contract modeling, variance analysis, and revenue integrity reporting al',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code reference table.',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `payer_id` BIGINT COMMENT 'FK to the payer for this procedure.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Procedures in group practices are billed under a group NPI. MIPS group reporting, group-level quality measure attribution, and billing reconciliation require knowing which provider group performed the',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Procedures are performed at a specific facility. CMS quality reporting, Joint Commission accreditation, procedure-level billing reconciliation, and outcomes tracking all require direct facility attrib',
    `lab_order_id` BIGINT COMMENT 'FK to preoperative lab order.',
    `clinician_id` BIGINT COMMENT 'FK to the primary clinician who performed the procedure.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Revenue cycle and denial management require knowing which prior auth rule governed a procedure at time of service. PA compliance tracking, appeals, and audit workflows all depend on this link. A reven',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR Procedure resources require SNOMED CT procedure coding. Clinical decision support and interoperability workflows map procedures to SNOMED. snomed_ct_code is a denormalized string; replacing with ',
    `tertiary_procedure_anesthesia_provider_clinician_id` BIGINT COMMENT 'FK to the anesthesia provider clinician.',
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
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC code for note type classification.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Clinical notes are patient-level longitudinal records required for HIE sharing, longitudinal record assembly, and patient-centric chart retrieval. A domain expert expects every note to be directly tra',
    `parent_note_id` BIGINT COMMENT 'FK to the parent note if this is an addendum or amendment.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Clinical notes (discharge summaries, H&P, progress notes) are often written in the context of a principal diagnosis. note.principal_diagnosis_code (STRING) stores this as a denormalized code. Replacin',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Clinical notes are often written to document a specific problem on the patients problem list (e.g., a progress note for diabetes management, a note addressing a specific chronic condition). Adding pr',
    `record_id` BIGINT COMMENT 'FK to consent record governing access to this note.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: note has a denormalized specialty plain column. FK to provider.specialty supports specialty-based documentation reporting, CDI workflows, peer review routing, and HEDIS measure attribution. Removes ',
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
    `note_status` STRING COMMENT 'Status of the note (draft, signed, amended, etc.).',
    `note_type` STRING COMMENT 'Type of note (progress note, discharge summary, H&P, operative note, etc.).',
    `sensitive_note_type` STRING COMMENT 'Type of sensitive note (behavioral health, substance use, HIV, etc.).',
    `service_date` DATE COMMENT 'Date of service for the note.',
    `service_line` STRING COMMENT 'Service line for the note (cardiology, orthopedics, etc.).',
    `signed_timestamp` TIMESTAMP COMMENT 'Timestamp when the note was signed.',
    `source_system_note_code` STRING COMMENT 'Note code as recorded in the source system.',
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
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `clinician_id` BIGINT COMMENT 'FK to adding provider',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED concept',
    `tertiary_problem_last_updated_by_provider_clinician_id` BIGINT COMMENT 'FK to last updater',
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
    `drug_master_id` BIGINT COMMENT 'FK to allergen drug',
    `test_result_id` BIGINT COMMENT 'FK to confirmatory test',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
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
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Immunizations are administered at a specific facility. IIS (Immunization Information System) reporting, VFC eligibility audits, and public health surveillance require direct facility attribution on im',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Immunizations are frequently part of a patients care plan — particularly for preventive care, population health programs, and chronic disease management. Adding care_plan_id to immunization enables l',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Immunization records are patient-level longitudinal data required for IIS reporting, HEDIS immunization measures, and public health surveillance. Every immunization must be traceable to the enterprise',
    `ndc_drug_id` BIGINT COMMENT 'FK to NDC drug',
    `clinician_id` BIGINT COMMENT 'FK to PCP',
    `record_id` BIGINT COMMENT 'FK to consent record',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR Immunization resources and Immunization Information System (IIS) reporting require SNOMED CT vaccine coding alongside NDC/CVX codes. Immunization records must be SNOMED-coded for interoperability',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Standing order immunization protocols: flu vaccines, pneumococcal vaccines, and other immunizations are routinely administered under standing order protocols in ambulatory and public health settings. ',
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
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC',
    `mar_record_id` BIGINT COMMENT 'FK to MAR record',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `previous_vital_sign_id` BIGINT COMMENT 'FK to previous vital sign',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR Observation resources for vital signs require SNOMED finding codes alongside LOINC. Clinical decision support (e.g., early warning scores, sepsis alerts) uses SNOMED-coded vital sign findings. sn',
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
    `source_system_record_code` STRING COMMENT 'Source system record code',
    `supplemental_oxygen_flow_rate` DECIMAL(18,2) COMMENT 'Supplemental oxygen flow rate',
    `text_value` DECIMAL(18,2) COMMENT 'Text value',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_vital_sign PRIMARY KEY(`vital_sign_id`)
) COMMENT 'Patient vital signs measurements';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`observation` (
    `observation_id` BIGINT COMMENT 'Primary key',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Clinical observations are frequently made in the context of a specific diagnosis — for example, a wound assessment observation linked to a wound infection diagnosis, a pain assessment linked to a post',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC',
    `mar_record_id` BIGINT COMMENT 'Foreign key linking to pharmacy.mar_record. Business justification: Medication effectiveness monitoring and PRN outcome tracking require linking observations (pain scores, sedation scales, glucose readings) to the MAR administration that preceded them. Nursing flowshe',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Observations (SDOH screenings, functional assessments, clinical scores) are patient-level data used in population health reporting, care gap identification, and risk stratification. A domain expert ex',
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
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Care plans specify the required follow-up appointment type (e.g., quarterly diabetes management visit, post-surgical wound check). This link drives automated scheduling workflows, care gap identif',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Chronic disease management workflow: population health care plans (diabetes, CHF, COPD) are governed by standing order protocols that define the monitoring and treatment regimen. Linking care_plan to ',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Care plans in ACO and value-based payment programs are attributed to a provider group for performance reporting and shared savings calculations. care_plan has aco_attributed and population_health_prog',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Care plans are designed around specific health plan benefit structures — covered services, formulary tiers, and visit limits directly shape care plan goals and interventions. Population health and car',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Care plans are managed within a specific facility or health system. ACO attribution, population health program enrollment, and transitions-of-care reporting require direct facility attribution on the ',
    `payer_id` BIGINT COMMENT 'FK to payer',
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
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: A care plan goal is often set in response to a specific diagnosed condition (e.g., goal to reduce HbA1c for a diabetes diagnosis, goal to lower blood pressure for a hypertension diagnosis). care_plan_',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `prescription_id` BIGINT COMMENT 'FK to prescription',
    `problem_id` BIGINT COMMENT 'FK to problem',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR Goal resources require SNOMED CT coding for goal categories. Population health programs and quality measure reporting use SNOMED-coded care plan goals. goal_category_snomed_code is a denormalized',
    `clinical_order_id` BIGINT COMMENT 'FK to supporting order',
    `loinc_code_id` BIGINT COMMENT 'FK to target LOINC',
    `observation_id` BIGINT COMMENT 'FK to target observation',
    `vital_sign_id` BIGINT COMMENT 'Foreign key linking to clinical.vital_sign. Business justification: Care plan goals often target specific vital sign measurements as their success criteria (e.g., goal to achieve blood pressure < 130/80, goal to maintain oxygen saturation > 95%). care_plan_goal alread',
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
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Care teams in group practices operate under a provider group structure. ACO care coordination reporting, group-level performance measurement, and value-based payment attribution require linking care t',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Care coordination workflows require direct patient-to-care-team linkage for care management enrollment, transitions-of-care tracking, and ACO attribution reporting. A domain expert expects a care team',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Care team NPI validation against the NPPES registry is required for payer credentialing, HIPAA transactions, and provider directory accuracy (CMS interoperability rules). npi is a denormalized string;',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Care teams operate within a specific facility. Discharge planning, network adequacy reporting, and transitions-of-care workflows require knowing which org_provider hosts the care team. Not derivable s',
    `clinician_id` BIGINT COMMENT 'FK to primary contact',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: care_team has denormalized specialty_code and specialty_name. Proper FK to provider.specialty supports HEDIS specialty-based care team reporting, network adequacy analysis, and referral management. Re',
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
    `reason_code` STRING COMMENT 'Reason code',
    `reason_description` STRING COMMENT 'Reason description',
    `sdoh_flag` BOOLEAN COMMENT 'SDOH flag',
    `source_system_team_code` STRING COMMENT 'Source system team code',
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
    `mpi_record_id` BIGINT COMMENT 'FK to MPI',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Individual care team member NPI validation against NPPES is required for credentialing verification, payer enrollment, and CMS provider directory compliance. npi is a denormalized string on care_team_',
    `clinician_id` BIGINT COMMENT 'FK to PCP clinician',
    `care_team_id` BIGINT COMMENT 'FK to care team',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: care_team_member has denormalized specialty_code and specialty_name. FK to provider.specialty enables specialty-based staffing reports, credentialing verification workflows, and network adequacy compl',
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
    `relationship_to_patient` STRING COMMENT 'Relationship to patient',
    `removal_reason` STRING COMMENT 'Removal reason',
    `role_code` STRING COMMENT 'Role code',
    `role_name` STRING COMMENT 'Role name',
    `sequence_number` STRING COMMENT 'Sequence number',
    `snomed_role_code` STRING COMMENT 'SNOMED role code',
    `source_system_member_code` STRING COMMENT 'Source system member code',
    `updated_timestamp` TIMESTAMP COMMENT 'Update timestamp',
    CONSTRAINT pk_care_team_member PRIMARY KEY(`care_team_member_id`)
) COMMENT 'Care team member assignments';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_parent_note_id` FOREIGN KEY (`parent_note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_previous_vital_sign_id` FOREIGN KEY (`previous_vital_sign_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_vital_sign_id` FOREIGN KEY (`vital_sign_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('dbx_domain' = 'clinical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Admit Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_date` SET TAGS ('dbx_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'CC/MCC Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drg_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'DRG Relevant Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_business_glossary_term' = 'Encounter Diagnosis Source');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_business_glossary_term' = 'External Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mcc_flag` SET TAGS ('dbx_business_glossary_term' = 'MCC Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('dbx_business_glossary_term' = 'Note Text');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Problem List Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Rank');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'SDOH Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Preop Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Clinician');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Provider');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `approach` SET TAGS ('dbx_business_glossary_term' = 'Approach');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'ASA Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cdm_code` SET TAGS ('dbx_business_glossary_term' = 'CDM Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_business_glossary_term' = 'Estimated Blood Loss');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10-PCS Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_business_glossary_term' = 'Procedure Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Procedure End Datetime');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Procedure Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collected');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `timeout_performed` SET TAGS ('dbx_business_glossary_term' = 'Timeout Performed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'UDI');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `wound_classification` SET TAGS ('dbx_business_glossary_term' = 'Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Note Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'LOINC Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `parent_note_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Cosigner Provider');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amended Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `author_role` SET TAGS ('dbx_business_glossary_term' = 'Author Role');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `authored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authored Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cosigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cosigned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `dictation_method` SET TAGS ('dbx_business_glossary_term' = 'Dictation Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `drg_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'DRG Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Format');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_addendum` SET TAGS ('dbx_business_glossary_term' = 'Is Addendum');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_copy_forwarded` SET TAGS ('dbx_business_glossary_term' = 'Is Copy Forwarded');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_late_entry` SET TAGS ('dbx_business_glossary_term' = 'Is Late Entry');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_business_glossary_term' = 'Note Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_business_glossary_term' = 'Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `sensitive_note_type` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `source_system_note_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Note Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Note Text');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('dbx_subdomain' = 'care_management');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('dbx_subdomain' = 'care_management');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_timestamp` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `is_patient_reported` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `is_patient_reported` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `patient_position` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `patient_position` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mar Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('dbx_subdomain' = 'care_management');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_obtained` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_obtained` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('dbx_subdomain' = 'care_management');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `observation_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Target Vital Sign Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `patient_agreement` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `patient_agreement` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('dbx_subdomain' = 'care_management');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `tertiary_care_member_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `tertiary_care_member_provider_clinician_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_end_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_end_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_start_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_start_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('dbx_subdomain' = 'care_management');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_uc_classification' = 'phi');
