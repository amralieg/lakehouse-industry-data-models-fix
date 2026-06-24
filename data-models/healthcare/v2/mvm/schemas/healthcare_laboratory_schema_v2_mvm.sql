-- Schema for Domain: laboratory | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`laboratory` COMMENT 'Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` (
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the laboratory order.',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to encounter.encounter_authorization. Business justification: Prior authorization for lab tests: payers require authorization for high-cost or specialty labs. Linking lab_order to encounter_authorization replaces the denormalized authorization_number text field ',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Patient Financial Responsibility Estimation: the specific benefit record determines copay, coinsurance, visit limits, and cost-sharing for the ordered lab service. Revenue cycle teams link lab orders ',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Care plans drive standing and recurring lab monitoring orders (e.g., monthly HbA1c for diabetes management, weekly INR for anticoagulation care plans). Direct FK supports population health management ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR ServiceRequest (lab order) requires structured clinical indication using SNOMED CT. lab_order.clinical_indication is plain text — this FK enables prior authorization medical necessity validation ',
    `demographics_id` BIGINT COMMENT 'Foreign key to patient demographics.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code justifying the order.',
    `health_plan_id` BIGINT COMMENT 'Health plan covering the order.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Enterprise patient identity resolution for lab orders is required for HIE result routing, cross-facility duplicate order detection, and patient matching workflows. Every lab order must be traceable to',
    `payer_id` BIGINT COMMENT 'Insurance payer for the order.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Lab order routing and payer network validation require knowing which org_provider facility performs the test. CLIA compliance, network adequacy reporting, and payer adjudication all depend on this lin',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the lab test.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Prior Authorization Management workflow: when a lab order is placed, the applicable prior_auth_rule determines PA requirements, criteria, and turnaround expectations. Lab billing and utilization manag',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Lab orders for sensitive tests (genetic, HIV, research) require verified patient consent before processing or result release. A direct FK enables consent-verification workflows and regulatory audit tr',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Recurring lab tests authorized by standing orders (e.g., monthly CBC for chronic disease management) must reference the standing_order protocol for compliance auditing, renewal tracking, and utilizati',
    `tertiary_lab_cancelled_by_provider_clinician_id` BIGINT COMMENT 'Clinician who cancelled the order.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key to the test catalog entry.',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: CDI and coding workflow: lab orders are placed to confirm or rule out specific encounter-level diagnoses. Linking lab_order to the exact visit_diagnosis instance (not just ICD code) enables CDI query ',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
    `authorization_required` BOOLEAN COMMENT 'Whether prior authorization is required.',
    `billing_code` STRING COMMENT 'CPT or HCPCS billing code.',
    `cancellation_reason` STRING COMMENT 'Reason for order cancellation.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was cancelled.',
    `clinical_indication` STRING COMMENT 'Clinical reason for the order.',
    `collection_date` DATE COMMENT 'Date specimen was collected.',
    `collection_method` STRING COMMENT 'Method of specimen collection.',
    `collection_timestamp` TIMESTAMP COMMENT 'Timestamp of specimen collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code as text.',
    `expected_turnaround_time_hours` STRING COMMENT 'Expected turnaround time in hours.',
    `fasting_required` BOOLEAN COMMENT 'Whether fasting is required for the test.',
    `is_send_out` BOOLEAN COMMENT 'Whether the test is sent to a reference lab.',
    `order_date` DATE COMMENT 'Date the order was placed.',
    `order_number` STRING COMMENT 'Human-readable order number.',
    `order_priority` STRING COMMENT 'Priority level (e.g., routine, stat, urgent).',
    `order_set_name` STRING COMMENT 'Name of the order set if part of a panel.',
    `order_status` STRING COMMENT 'Current status of the order (e.g., pending, completed, cancelled).',
    `order_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was placed.',
    `point_of_care_test` BOOLEAN COMMENT 'Whether this is a point-of-care test.',
    `reference_lab_accession_number` STRING COMMENT 'Accession number at the reference lab.',
    `reference_lab_name` STRING COMMENT 'Name of the reference laboratory.',
    `result_integration_status` STRING COMMENT 'Status of result integration into EHR.',
    `result_received_timestamp` TIMESTAMP COMMENT 'Timestamp when results were received.',
    `shipping_carrier` STRING COMMENT 'Carrier used for specimen shipment.',
    `shipping_tracking_number` STRING COMMENT 'Shipment tracking number.',
    `source_system_order_number` STRING COMMENT 'Order number in the source system.',
    `specimen_shipped_timestamp` TIMESTAMP COMMENT 'Timestamp when specimen was shipped.',
    `specimen_source` STRING COMMENT 'Anatomical source of the specimen.',
    `specimen_type` STRING COMMENT 'Type of specimen required (e.g., blood, urine).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_lab_order PRIMARY KEY(`lab_order_id`)
) COMMENT 'Laboratory test orders placed by clinicians, including order details, specimen requirements, and fulfillment status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` (
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key to the patient MPI record.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: Phlebotomy scheduling: specimen collection appointments are booked as open slots. Linking specimen to the scheduled phlebotomy slot enables TAT reporting from slot-booking to result, scheduling effici',
    `parent_specimen_id` BIGINT COMMENT 'Parent specimen if this is an aliquot.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: CAP/CLIA specimen classification requires standardized SNOMED CT coding of specimen type (e.g., venous blood, urine). specimen.specimen_type is plain text — this FK enables structured specimen taxonom',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Surgical/procedural specimen chain of custody: specimens collected during biopsies, resections, or bronchoscopies must be traceable to the generating procedure for surgical pathology correlation, OR-t',
    `accession_datetime` TIMESTAMP COMMENT 'Date and time the specimen was accessioned.',
    `accession_number` STRING COMMENT 'Unique accession number for the specimen.',
    `accession_status` STRING COMMENT 'Status of the specimen (e.g., received, rejected, in process).',
    `biohazard_level` STRING COMMENT 'Biohazard safety level of the specimen.',
    `chain_of_custody_status` STRING COMMENT 'Chain of custody status for forensic specimens.',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time of specimen collection.',
    `collection_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of collection in minutes (for timed collections).',
    `collection_method` STRING COMMENT 'Method used to collect the specimen.',
    `collector_role` STRING COMMENT 'Role of the person who collected the specimen.',
    `comments` STRING COMMENT 'Additional comments about the specimen.',
    `condition_at_receipt` STRING COMMENT 'Condition of the specimen upon receipt.',
    `container_type` STRING COMMENT 'Type of container used for the specimen.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `disposal_datetime` TIMESTAMP COMMENT 'Date and time the specimen was disposed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the specimen.',
    `fasting_status` STRING COMMENT 'Fasting status of the patient at collection.',
    `number_of_aliquots` STRING COMMENT 'Number of aliquots created from the specimen.',
    `priority` STRING COMMENT 'Priority level (e.g., routine, stat).',
    `receiving_lab_location` STRING COMMENT 'Laboratory location that received the specimen.',
    `record_number` BIGINT COMMENT 'Consent record for specimen collection.',
    `rejection_reason` STRING COMMENT 'Reason for specimen rejection if applicable.',
    `retention_expiration_date` DECIMAL(18,2) COMMENT 'Date when retention period expires.',
    `retention_status` STRING COMMENT 'Retention status of the specimen.',
    `source` STRING COMMENT 'Anatomical source of the specimen.',
    `special_handling_instructions` STRING COMMENT 'Special handling instructions for the specimen.',
    `specimen_type` STRING COMMENT 'Type of specimen (e.g., blood, urine, tissue).',
    `storage_location` STRING COMMENT 'Location where the specimen is stored.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Storage temperature in Celsius.',
    `transport_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of transport in minutes.',
    `transport_temperature_c` DECIMAL(18,2) COMMENT 'Temperature during transport in Celsius.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `volume_collected_ml` DECIMAL(18,2) COMMENT 'Volume of specimen collected in milliliters.',
    CONSTRAINT pk_specimen PRIMARY KEY(`specimen_id`)
) COMMENT 'Biological specimens collected for laboratory testing, including collection details, chain of custody, and storage information.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the test result.',
    `demographics_id` BIGINT COMMENT 'Foreign key to patient demographics.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code associated with the result.',
    `instrument_id` BIGINT COMMENT 'Instrument used to perform the test.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `loinc_code_id` BIGINT COMMENT 'LOINC code for the test.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: HIE result routing, patient portal result delivery, and cross-facility result reconciliation require test results to be tied to the enterprise MPI record. The existing demographics_id link is insuffic',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CLIA compliance and payer adjudication require test results to be formally traceable to the performing org_provider facility. Quality reporting and accreditation audits depend on this link. performin',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the test.',
    `reference_range_id` BIGINT COMMENT 'Reference range for the test result.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED concept for the result.',
    `specimen_id` BIGINT COMMENT 'Foreign key to the specimen.',
    `tertiary_test_ordering_provider_clinician_id` BIGINT COMMENT 'Additional ordering provider.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key to the test catalog.',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
    `abnormal_flag` BOOLEAN COMMENT 'Whether the result is abnormal.',
    `amendment_datetime` TIMESTAMP COMMENT 'Timestamp when the result was amended.',
    `amendment_reason` STRING COMMENT 'Reason for amending the result.',
    `clia_number` STRING COMMENT 'CLIA number of the performing lab.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `critical_value_acknowledgment_datetime` TIMESTAMP COMMENT 'Timestamp when critical value was acknowledged.',
    `critical_value_alert_generated_datetime` DECIMAL(18,2) COMMENT 'Timestamp when critical value alert was generated.',
    `critical_value_escalation_action` STRING COMMENT 'Escalation action taken for critical value.',
    `critical_value_notification_datetime` TIMESTAMP COMMENT 'Timestamp when critical value was notified.',
    `critical_value_notification_method` STRING COMMENT 'Method used to notify critical value.',
    `critical_value_resolution_note` STRING COMMENT 'Note on resolution of critical value.',
    `is_amended` BOOLEAN COMMENT 'Whether the result has been amended.',
    `is_critical_value` BOOLEAN COMMENT 'Whether the result is a critical value.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `original_result_value_numeric` DECIMAL(18,2) COMMENT 'Original numeric result before amendment.',
    `original_result_value_text` STRING COMMENT 'Original text result before amendment.',
    `performing_lab_section` STRING COMMENT 'Section of the lab that performed the test.',
    `record_number` BIGINT COMMENT 'Consent record for the test.',
    `result_comment` STRING COMMENT 'Additional comments about the result.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time the result was generated.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation of the result.',
    `result_released_datetime` TIMESTAMP COMMENT 'Timestamp when result was released.',
    `result_status` STRING COMMENT 'Status of the result (e.g., preliminary, final, corrected).',
    `result_unit` STRING COMMENT 'Unit of measure for the result.',
    `result_value_coded` STRING COMMENT 'Coded result value.',
    `result_value_numeric` DECIMAL(18,2) COMMENT 'Numeric result value.',
    `result_value_text` STRING COMMENT 'Text result value.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'Timestamp when specimen was received.',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Laboratory test results including numeric and text values, reference ranges, critical value alerts, and result interpretation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` (
    `reference_range_id` BIGINT COMMENT 'Unique identifier for the reference range.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: reference_range currently stores instrument identity as a free-text string in instrument_platform. Normalizing this to a proper FK to laboratory.instrument.instrument_id enforces referential integrity',
    `loinc_code_id` BIGINT COMMENT 'LOINC code for the test.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Clinical decision support requires specialty-specific reference ranges (e.g., athlete cardiac values for sports medicine, oncology-specific tumor markers). Specialty-contextualized result interpretati',
    `test_catalog_id` BIGINT COMMENT 'Foreign key to the test catalog.',
    `age_group` STRING COMMENT 'Age group for which the reference range applies.',
    `alert_priority` STRING COMMENT 'Priority level for alerts triggered by this range.',
    `alert_trigger_flag` BOOLEAN COMMENT 'Whether values outside the range trigger an alert.',
    `clinical_significance` STRING COMMENT 'Clinical significance of values outside the range.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `critical_high_threshold` DECIMAL(18,2) COMMENT 'Critical high threshold requiring immediate notification.',
    `critical_low_threshold` DECIMAL(18,2) COMMENT 'Critical low threshold requiring immediate notification.',
    `effective_end_date` DATE COMMENT 'Date when the reference range expires.',
    `effective_start_date` DATE COMMENT 'Date when the reference range becomes effective.',
    `interpretation_code` STRING COMMENT 'Code for interpreting results relative to the range.',
    `last_review_date` DATE COMMENT 'Date of the last review.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `lis_system_code` STRING COMMENT 'Code in the laboratory information system.',
    `lower_normal_limit` DECIMAL(18,2) COMMENT 'Lower bound of the normal reference range.',
    `medical_director_override_flag` BOOLEAN COMMENT 'Whether the medical director has overridden the range.',
    `methodology` STRING COMMENT 'Laboratory methodology used.',
    `next_review_date` DATE COMMENT 'Date of the next scheduled review.',
    `notes` STRING COMMENT 'Additional notes about the reference range.',
    `override_justification` STRING COMMENT 'Justification for overriding the reference range.',
    `population_basis` STRING COMMENT 'Population on which the reference range is based.',
    `pregnancy_status` STRING COMMENT 'Pregnancy status for which the reference range applies.',
    `race_ethnicity` STRING COMMENT 'Race or ethnicity for which the reference range applies.',
    `review_status` STRING COMMENT 'Review status of the reference range.',
    `sample_size` STRING COMMENT 'Sample size used to establish the reference range.',
    `sex` STRING COMMENT 'Sex for which the reference range applies.',
    `source_citation` STRING COMMENT 'Citation for the reference range source.',
    `source_type` STRING COMMENT 'Source of the reference range (e.g., manufacturer, literature, internal study).',
    `statistical_method` STRING COMMENT 'Statistical method used to derive the range.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the reference range.',
    `upper_normal_limit` DECIMAL(18,2) COMMENT 'Upper bound of the normal reference range.',
    CONSTRAINT pk_reference_range PRIMARY KEY(`reference_range_id`)
) COMMENT 'Reference ranges for laboratory tests, including normal limits, critical thresholds, and demographic-specific ranges.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` (
    `pathology_report_id` BIGINT COMMENT 'Unique identifier for the pathology report.',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: Synoptic cancer reporting (CAP protocols, NAACCR submissions) requires patient demographic data (age, sex, race, ethnicity) alongside pathology findings. A direct demographics link on pathology_report',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: CAP cancer protocol reporting and FHIR DiagnosticReport resources require LOINC codes on pathology reports (e.g., Pathology report LOINC panel codes). Synoptic cancer reporting to state cancer regis',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: State cancer registry reporting and tumor board workflows require pathology reports to be directly linked to the enterprise patient identity (MPI). cancer_registry_reportable_flag on pathology_report ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CAP/CLIA accreditation and payer billing require pathology reports to be formally linked to the performing org_provider. Tumor board and cancer registry workflows also depend on facility identificatio',
    `clinician_id` BIGINT COMMENT 'Pathologist who signed out the report.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED concept for the diagnosis.',
    `specimen_id` BIGINT COMMENT 'Foreign key to the specimen.',
    `surgical_case_id` BIGINT COMMENT 'Associated surgical case.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key to the test catalog.',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
    `accession_number` STRING COMMENT 'Unique accession number.',
    `addendum_history` STRING COMMENT 'History of addenda to the report.',
    `amended_timestamp` TIMESTAMP COMMENT 'Timestamp of amendment.',
    `amendment_reason` STRING COMMENT 'Reason for amendment.',
    `cancer_registry_reportable_flag` BOOLEAN COMMENT 'Whether the case is reportable to cancer registry.',
    `case_number` STRING COMMENT 'Pathology case number.',
    `clia_number` STRING COMMENT 'CLIA number of the performing lab.',
    `comment` STRING COMMENT 'Additional comments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `critical_value_flag` BOOLEAN COMMENT 'Whether the finding is a critical value.',
    `critical_value_notification_timestamp` TIMESTAMP COMMENT 'Timestamp of critical value notification.',
    `final_diagnosis` STRING COMMENT 'Final pathology diagnosis.',
    `gross_description` STRING COMMENT 'Gross pathology description.',
    `histologic_grade` STRING COMMENT 'Histologic grade.',
    `histologic_type` STRING COMMENT 'Histologic type of tumor or lesion.',
    `immunohistochemistry_results` STRING COMMENT 'Immunohistochemistry results.',
    `is_amended` BOOLEAN COMMENT 'Whether the report has been amended.',
    `lymph_nodes_examined` STRING COMMENT 'Number of lymph nodes examined.',
    `lymph_nodes_positive` STRING COMMENT 'Number of lymph nodes positive for malignancy.',
    `margin_status` STRING COMMENT 'Surgical margin status.',
    `microscopic_description` STRING COMMENT 'Microscopic pathology description.',
    `molecular_testing_results` STRING COMMENT 'Molecular testing results.',
    `preliminary_report_timestamp` TIMESTAMP COMMENT 'Timestamp of preliminary report.',
    `received_date` DATE COMMENT 'Date specimen was received.',
    `record_number` BIGINT COMMENT 'Consent record.',
    `report_status` STRING COMMENT 'Status of the report (e.g., preliminary, final).',
    `report_type` STRING COMMENT 'Type of pathology report (e.g., surgical, cytology, autopsy).',
    `sign_out_timestamp` TIMESTAMP COMMENT 'Timestamp when report was signed out.',
    `special_stains_performed` STRING COMMENT 'Special stains performed.',
    `synoptic_report_elements` STRING COMMENT 'Synoptic reporting elements per CAP protocols.',
    `tnm_stage` STRING COMMENT 'TNM staging classification.',
    `tumor_board_reviewed_flag` BOOLEAN COMMENT 'Whether the case was reviewed by tumor board.',
    `tumor_site` STRING COMMENT 'Anatomical site of tumor.',
    `tumor_size_cm` DECIMAL(18,2) COMMENT 'Tumor size in centimeters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_pathology_report PRIMARY KEY(`pathology_report_id`)
) COMMENT 'Pathology reports including surgical pathology, cytology, and autopsy findings with synoptic reporting elements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` (
    `microbiology_culture_id` BIGINT COMMENT 'Unique identifier for the microbiology culture.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the culture.',
    `demographics_id` BIGINT COMMENT 'Foreign key to patient demographics.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `instrument_id` BIGINT COMMENT 'Instrument used for culture.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Microbiology culture results require LOINC coding for HL7 result reporting and public health surveillance (e.g., CDC NHSN HAI reporting). The culture result itself has a distinct LOINC code from the o',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Public health reportable disease surveillance (public_health_reportable_flag) and HAI tracking (hai_associated_flag) require microbiology cultures to be linked to the enterprise patient identity for c',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED concept for the organism.',
    `specimen_id` BIGINT COMMENT 'Foreign key to the specimen.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: HAI surveillance and surgical site infection tracking: post-operative microbiology cultures must be attributed to the originating surgical case for CMS HAI quality metrics, infection control reporting',
    `test_catalog_id` BIGINT COMMENT 'Foreign key to the test catalog.',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
    `accession_number` STRING COMMENT 'Unique accession number.',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'Whether the result triggered antibiotic stewardship review.',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time of specimen collection.',
    `colony_count` BIGINT COMMENT 'Colony count.',
    `colony_count_unit` STRING COMMENT 'Unit for colony count (e.g., CFU/mL).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `critical_value_flag` BOOLEAN COMMENT 'Whether the result is a critical value.',
    `critical_value_notified_datetime` TIMESTAMP COMMENT 'Timestamp of critical value notification.',
    `culture_status` STRING COMMENT 'Status of the culture (e.g., in progress, final).',
    `culture_type` STRING COMMENT 'Type of culture (e.g., aerobic, anaerobic, fungal).',
    `gram_stain_result` STRING COMMENT 'Gram stain result.',
    `growth_result` STRING COMMENT 'Growth result (e.g., no growth, light growth, heavy growth).',
    `hai_associated_flag` BOOLEAN COMMENT 'Whether the culture is associated with a healthcare-associated infection.',
    `hai_event_type` STRING COMMENT 'Type of HAI event.',
    `incubation_start_datetime` TIMESTAMP COMMENT 'Date and time incubation started.',
    `infection_control_notified_flag` BOOLEAN COMMENT 'Whether infection control was notified.',
    `isolation_datetime` TIMESTAMP COMMENT 'Date and time organism was isolated.',
    `mdro_flag` BOOLEAN COMMENT 'Whether the organism is a multidrug-resistant organism.',
    `mdro_type` STRING COMMENT 'Type of MDRO (e.g., MRSA, VRE, CRE).',
    `morphology` STRING COMMENT 'Morphology of the organism.',
    `public_health_reportable_flag` BOOLEAN COMMENT 'Whether the organism is reportable to public health.',
    `quality_control_passed_flag` BOOLEAN COMMENT 'Whether quality control passed.',
    `received_datetime` TIMESTAMP COMMENT 'Date and time specimen was received.',
    `result_comments` STRING COMMENT 'Additional comments about the result.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time of final result.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation of the result.',
    `specimen_source_code` STRING COMMENT 'Code for specimen source.',
    `susceptibility_method` STRING COMMENT 'Method used for susceptibility testing.',
    `susceptibility_panel_performed` BOOLEAN COMMENT 'Whether susceptibility testing was performed.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Turnaround time in hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_microbiology_culture PRIMARY KEY(`microbiology_culture_id`)
) COMMENT 'Microbiology culture results including organism identification, colony counts, and antimicrobial susceptibility testing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the laboratory instrument. Primary key.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Instruments are physically owned and operated by specific org_provider facilities. CLIA compliance, preventive maintenance scheduling, asset management, and quality control reporting all require knowi',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the instrument, including purchase price, shipping, installation, and initial setup fees. Expressed in USD.',
    `asset_tag` STRING COMMENT 'Internal asset tracking identifier assigned by the healthcare organization for inventory and fixed asset management.',
    `calibration_frequency` STRING COMMENT 'Required frequency for calibration verification or full calibration per manufacturer specifications, CLIA requirements, or laboratory policy.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the instrument was permanently removed from service and decommissioned.',
    `decommission_reason` STRING COMMENT 'Business or technical justification for decommissioning the instrument (e.g., end of life, obsolescence, replacement, irreparable failure).',
    `installation_date` DATE COMMENT 'Date when the instrument was installed and commissioned for use in the laboratory.',
    `instrument_type` STRING COMMENT 'Classification of the instrument by its primary analytical or operational function within the laboratory.. Valid values are `analyzer|centrifuge|microscope|incubator|spectrophotometer|other`',
    `lab_section` STRING COMMENT 'The laboratory department or section to which this instrument is assigned (e.g., Chemistry, Hematology, Microbiology).. Valid values are `chemistry|hematology|microbiology|immunology|blood_bank|molecular`',
    `last_calibration_date` DATE COMMENT 'Date when the instrument was last calibrated to ensure measurement accuracy and precision.',
    `last_calibration_result` STRING COMMENT 'Outcome of the most recent calibration verification indicating whether the instrument met accuracy and precision specifications.. Valid values are `pass|fail|conditional`',
    `last_corrective_maintenance_date` DATE COMMENT 'Date when the most recent unscheduled corrective maintenance or repair was performed on the instrument.',
    `last_preventive_maintenance_date` DATE COMMENT 'Date when the most recent scheduled preventive maintenance was performed on the instrument.',
    `last_quality_control_date` DATE COMMENT 'Date when the most recent quality control testing was performed on the instrument.',
    `last_quality_control_result` STRING COMMENT 'Outcome of the most recent quality control testing indicating whether the instrument met performance specifications.. Valid values are `pass|fail|conditional`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was most recently modified.',
    `lis_connectivity_status` STRING COMMENT 'Current status of the bidirectional interface connection between the instrument and the Laboratory Information System.. Valid values are `connected|disconnected|error|not_applicable`',
    `lis_interface_code` STRING COMMENT 'Unique identifier used by the Laboratory Information System to communicate with and receive results from this instrument.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the laboratory instrument.',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or designation for the instrument type.',
    `instrument_name` STRING COMMENT 'Human-readable name or designation of the laboratory instrument as known to laboratory staff.',
    `next_calibration_date` DATE COMMENT 'Scheduled date for the next calibration verification or full calibration of the instrument.',
    `next_preventive_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service on the instrument.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, known issues, or operational considerations for the instrument.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument indicating its availability for testing and analysis.. Valid values are `active|down|maintenance|decommissioned|pending_installation|calibration`',
    `preventive_maintenance_frequency` STRING COMMENT 'Scheduled frequency at which preventive maintenance must be performed on the instrument per manufacturer specifications or laboratory policy.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `quality_control_frequency` STRING COMMENT 'Required frequency for running quality control samples on the instrument to verify ongoing analytical performance.. Valid values are `per_shift|daily|weekly|per_run`',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit.',
    `service_contract_expiration_date` DATE COMMENT 'Date when the current service or maintenance contract for the instrument expires.',
    `service_contract_number` STRING COMMENT 'Identifier for the active maintenance or service contract covering this instrument.',
    `total_downtime_hours` DECIMAL(18,2) COMMENT 'Cumulative hours the instrument has been non-operational due to maintenance, repair, or malfunction since installation or last reset period.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage for the instrument expires.',
    CONSTRAINT pk_instrument PRIMARY KEY(`instrument_id`)
) COMMENT 'Laboratory instruments including calibration, maintenance, and connectivity status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` (
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the laboratory test catalog entry. Primary key for the test catalog product.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Charge master maintenance: each orderable lab test in the test catalog maps to a CDM entry for charge capture configuration. Price transparency reporting, billing system setup, and charge master revie',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: FDA companion diagnostic regulations require linking specific lab tests to their associated drug (e.g., EGFR mutation test linked to erlotinib). This supports formulary-linked test ordering and precis',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: test_catalog has consent_required_flag but no FK to the governing consent form. Labs performing genetic, HIV, or research tests must present the correct consent form template at order entry. This li',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Test catalog entries require structured CPT linkage for charge master maintenance, billing compliance, RVU-based productivity reporting, and payer contract validation. The cpt_code text field is denor',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Lab billing requires HCPCS codes for molecular diagnostics, genetic tests, and reference lab send-outs where CPT codes dont apply. CMS reimbursement policy mandates HCPCS coding for specific lab serv',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Test catalog entries require structured LOINC linkage for interoperability, HIE result exchange, quality measure reporting, and EHR integration. The loinc_code text field is denormalized; proper FK en',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Catalog tests may specify preferred or required instruments. Currently test_catalog has instrument_platform (string) but no FK. Business reality: some tests require specific instruments (e.g., specifi',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Test catalog entries require SNOMED CT linkage for clinical terminology standardization, order set management, and semantic interoperability. Enables precise test ordering, supports clinical decision ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Specialty-restricted test ordering rules and payer prior authorization workflows require knowing which specialty a test belongs to. Oncology panels, genetic tests, and cardiology markers are specialty',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether payer prior authorization is typically required before performing this test due to cost or medical necessity criteria. Supports revenue cycle management.',
    `clia_complexity` STRING COMMENT 'CLIA complexity classification of the test: waived (simple, low risk), moderate complexity, or high complexity. Determines regulatory requirements and personnel qualifications.. Valid values are `waived|moderate|high`',
    `clinical_indication` STRING COMMENT 'Primary clinical use case, indication, or purpose for ordering this test. Supports clinical decision support and appropriate test utilization.',
    `collection_instructions` STRING COMMENT 'Detailed instructions for phlebotomy or specimen collection staff, including special handling, order of draw, collection technique, or timing requirements.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether informed patient consent is required before performing this test (e.g., genetic testing, HIV testing, research testing). Supports regulatory compliance and patient rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog entry was first created in the system. Supports audit trail and historical tracking.',
    `critical_high_value` DECIMAL(18,2) COMMENT 'Upper threshold for critical value alerting. Results at or above this value trigger immediate notification to the ordering provider per Joint Commission and patient safety requirements.',
    `critical_low_value` DECIMAL(18,2) COMMENT 'Lower threshold for critical value alerting. Results at or below this value trigger immediate notification to the ordering provider per Joint Commission and patient safety requirements.',
    `effective_date` DATE COMMENT 'Date when this test catalog entry became or will become active and available for ordering. Supports test catalog version control and historical tracking.',
    `expiration_date` DATE COMMENT 'Date when this test catalog entry was or will be retired or inactivated. Null for currently active tests with no planned retirement date.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog entry was last modified. Supports audit trail and change tracking for regulatory compliance.',
    `methodology` STRING COMMENT 'Analytical method or technology used to perform the test (e.g., immunoassay, PCR, mass spectrometry, flow cytometry, enzymatic assay, culture). Important for result interpretation and quality control.',
    `minimum_volume` STRING COMMENT 'Minimum volume of specimen required to perform the test, typically expressed with units (e.g., 2 mL, 5 mL, 0.5 mL). Critical for specimen adequacy assessment.',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this test is currently available for ordering by clinicians through CPOE (Computerized Physician Order Entry) systems. False for retired, suspended, or component-only tests.',
    `orderable_status` STRING COMMENT 'Current lifecycle status of the test in the catalog. Active tests are available for ordering; inactive/retired tests are no longer available; suspended tests are temporarily unavailable; pending validation tests are under review.. Valid values are `active|inactive|suspended|retired|pending_validation`',
    `ordering_instructions` STRING COMMENT 'Special instructions or requirements for ordering this test, including patient preparation (e.g., fasting required, medication restrictions), timing considerations, or authorization requirements.',
    `panic_value_flag` BOOLEAN COMMENT 'Indicates whether this test can produce panic or critical values requiring immediate clinical notification and documentation of provider acknowledgment.',
    `patient_preparation` STRING COMMENT 'Specific patient preparation requirements prior to specimen collection (e.g., 8-hour fast, discontinue medications, timed collection, dietary restrictions). Critical for accurate test results.',
    `performing_lab_location` STRING COMMENT 'Name or identifier of the laboratory location or section that performs this test (e.g., Main Hospital Lab - Chemistry, Regional Reference Lab, Point of Care Testing). Indicates internal vs external testing.',
    `preferred_volume` STRING COMMENT 'Preferred or optimal volume of specimen for best test performance and to allow for repeat testing if needed.',
    `reference_lab_code` STRING COMMENT 'Test code used by the external reference laboratory for ordering and tracking. Used for send-out test routing and result reconciliation.',
    `reference_lab_name` STRING COMMENT 'Name of the external reference laboratory if this is a send-out test not performed in-house. Null for tests performed internally.',
    `reference_range_adult` STRING COMMENT 'Normal reference range for adult patients, typically expressed as a range (e.g., 3.5-5.0, <10, negative). May vary by gender and age subgroups.',
    `reference_range_pediatric` STRING COMMENT 'Normal reference range for pediatric patients. May be age-stratified (e.g., neonate, infant, child, adolescent) due to developmental physiology differences.',
    `result_type` STRING COMMENT 'Type of result produced by the test: quantitative (numeric with units), qualitative (positive/negative/detected), semi-quantitative (titers, grades), narrative (free text interpretation), culture results, or microscopic findings.. Valid values are `quantitative|qualitative|semi_quantitative|narrative|culture|microscopic`',
    `specimen_container` STRING COMMENT 'Type of collection container or tube required (e.g., red top, lavender top EDTA, green top heparin, yellow top ACD, sterile container). Includes tube color and additive information.',
    `specimen_stability` STRING COMMENT 'Duration for which the specimen remains stable under specified storage conditions before testing must be performed (e.g., 24 hours at room temperature, 7 days refrigerated).',
    `specimen_type` STRING COMMENT 'Type of biological specimen required for the test (e.g., blood, serum, plasma, urine, CSF, tissue, swab). Critical for specimen collection and handling.',
    `storage_temperature` STRING COMMENT 'Required storage temperature for the specimen prior to testing (e.g., room temperature, refrigerated 2-8°C, frozen -20°C, frozen -80°C). Critical for specimen stability.',
    `test_abbreviation` STRING COMMENT 'Short abbreviation or mnemonic for the test used in clinical documentation and reporting (e.g., CBC, BMP, CMP, TSH).',
    `test_category` STRING COMMENT 'High-level classification of the test by laboratory discipline or department (e.g., chemistry, hematology, microbiology, immunology, molecular diagnostics, anatomic pathology). [ENUM-REF-CANDIDATE: chemistry|hematology|microbiology|immunology|molecular|pathology|blood_bank|coagulation|toxicology|urinalysis — 10 candidates stripped; promote to reference product]',
    `test_code` STRING COMMENT 'Internal laboratory test code used for ordering and identification within the Laboratory Information System (LIS). Unique business identifier for the test or panel.',
    `test_name` STRING COMMENT 'Full descriptive name of the laboratory test or panel as displayed to clinicians and in order entry systems.',
    `test_type` STRING COMMENT 'Indicates whether this catalog entry represents an individual test, a panel (group of related tests), a profile, a reflex test (automatically triggered based on results), or an add-on test.. Valid values are `individual_test|panel|profile|reflex_test|add_on_test`',
    `transport_conditions` STRING COMMENT 'Special transport requirements for the specimen (e.g., transport on ice, ambient temperature, protect from light, transport immediately). Ensures specimen integrity during transport.',
    `turnaround_time_routine` STRING COMMENT 'Expected turnaround time for routine test orders from specimen receipt to result availability, typically expressed in hours or days (e.g., 4 hours, 24 hours, 3-5 days).',
    `turnaround_time_stat` STRING COMMENT 'Expected turnaround time for STAT (urgent) test orders requiring expedited processing, typically expressed in minutes or hours (e.g., 30 minutes, 1 hour, 2 hours).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantitative test results (e.g., mg/dL, mmol/L, IU/mL, cells/mcL, %). Aligned with UCUM (Unified Code for Units of Measure) standards.',
    CONSTRAINT pk_test_catalog PRIMARY KEY(`test_catalog_id`)
) COMMENT 'Laboratory test catalog defining orderable tests, specimen requirements, and turnaround times.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_parent_specimen_id` FOREIGN KEY (`parent_specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelling Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `expected_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Expected TAT');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_business_glossary_term' = 'Fasting Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `is_send_out` SET TAGS ('dbx_business_glossary_term' = 'Send Out');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_business_glossary_term' = 'Order Set Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `point_of_care_test` SET TAGS ('dbx_business_glossary_term' = 'Point of Care Test');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_accession_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Lab Accession');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Lab Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Received');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `shipping_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `source_system_order_number` SET TAGS ('dbx_business_glossary_term' = 'Source Order Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Specimen Shipped');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_datetime` SET TAGS ('dbx_business_glossary_term' = 'Accession Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_status` SET TAGS ('dbx_business_glossary_term' = 'Accession Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_business_glossary_term' = 'Biohazard Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Collection Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Collection Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collector_role` SET TAGS ('dbx_business_glossary_term' = 'Collector Role');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition at Receipt');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `disposal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Disposal Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_business_glossary_term' = 'Fasting Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `number_of_aliquots` SET TAGS ('dbx_business_glossary_term' = 'Number of Aliquots');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `receiving_lab_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Lab');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Transport Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Transport Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Updated Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `volume_collected_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Collected');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('dbx_subdomain' = 'result_reporting');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'LOINC Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Result SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_ordering_provider_clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `abnormal_flag` SET TAGS ('dbx_business_glossary_term' = 'Abnormal Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `amendment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Amendment Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clia_number` SET TAGS ('dbx_business_glossary_term' = 'CLIA Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_acknowledgment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Acknowledgment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_alert_generated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Alert Generated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_alert_generated_datetime` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_escalation_action` SET TAGS ('dbx_business_glossary_term' = 'Escalation Action');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Notification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_resolution_note` SET TAGS ('dbx_business_glossary_term' = 'Resolution Note');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Amended');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `is_critical_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Original Numeric Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Original Text Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `performing_lab_section` SET TAGS ('dbx_business_glossary_term' = 'Lab Section');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_released_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Released');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('dbx_business_glossary_term' = 'Coded Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Numeric Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Text Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Specimen Received');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('dbx_subdomain' = 'result_reporting');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'LOINC Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Trigger');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `critical_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical High Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `critical_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `interpretation_code` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `lis_system_code` SET TAGS ('dbx_business_glossary_term' = 'LIS System Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `lower_normal_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Normal Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Override');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `population_basis` SET TAGS ('dbx_business_glossary_term' = 'Population Basis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_citation` SET TAGS ('dbx_business_glossary_term' = 'Source Citation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `upper_normal_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Normal Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('dbx_subdomain' = 'result_reporting');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Pathologist');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `addendum_history` SET TAGS ('dbx_business_glossary_term' = 'Addendum History');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amended Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cancer_registry_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancer Registry Reportable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `case_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clia_number` SET TAGS ('dbx_business_glossary_term' = 'CLIA Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `comment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Critical Notification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Final Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `gross_description` SET TAGS ('dbx_business_glossary_term' = 'Gross Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `gross_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('dbx_business_glossary_term' = 'Histologic Grade');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_type` SET TAGS ('dbx_business_glossary_term' = 'Histologic Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('dbx_business_glossary_term' = 'IHC Results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Amended');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_examined` SET TAGS ('dbx_business_glossary_term' = 'Lymph Nodes Examined');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_examined` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_positive` SET TAGS ('dbx_business_glossary_term' = 'Lymph Nodes Positive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_positive` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `microscopic_description` SET TAGS ('dbx_business_glossary_term' = 'Microscopic Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `microscopic_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_business_glossary_term' = 'Molecular Testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `preliminary_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Report');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `sign_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign Out');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `special_stains_performed` SET TAGS ('dbx_business_glossary_term' = 'Special Stains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `synoptic_report_elements` SET TAGS ('dbx_business_glossary_term' = 'Synoptic Elements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `synoptic_report_elements` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('dbx_business_glossary_term' = 'TNM Stage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_board_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Tumor Board Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_site` SET TAGS ('dbx_business_glossary_term' = 'Tumor Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_site` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_size_cm` SET TAGS ('dbx_business_glossary_term' = 'Tumor Size');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_size_cm` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_subdomain' = 'result_reporting');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_business_glossary_term' = 'Microbiology Culture Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `instrument_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Organism SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Stewardship');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Collection Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count` SET TAGS ('dbx_business_glossary_term' = 'Colony Count');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count_unit` SET TAGS ('dbx_business_glossary_term' = 'Colony Count Unit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('dbx_business_glossary_term' = 'Culture Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_type` SET TAGS ('dbx_business_glossary_term' = 'Culture Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_business_glossary_term' = 'Gram Stain Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_business_glossary_term' = 'Growth Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_associated_flag` SET TAGS ('dbx_business_glossary_term' = 'HAI Associated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_event_type` SET TAGS ('dbx_business_glossary_term' = 'HAI Event Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `incubation_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incubation Start');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `infection_control_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Notified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `isolation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Isolation Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_flag` SET TAGS ('dbx_business_glossary_term' = 'MDRO Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_type` SET TAGS ('dbx_business_glossary_term' = 'MDRO Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `morphology` SET TAGS ('dbx_business_glossary_term' = 'Morphology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `morphology` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Health Reportable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `quality_control_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'QC Passed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Received Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('dbx_business_glossary_term' = 'Result Comments');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_panel_performed` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Panel Performed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('dbx_subdomain' = 'test_catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'analyzer|centrifuge|microscope|incubator|spectrophotometer|other');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Section');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('dbx_value_regex' = 'chemistry|hematology|microbiology|immunology|blood_bank|molecular');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_corrective_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Corrective Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_date` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Control (QC) Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Control (QC) Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lis_connectivity_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information System (LIS) Connectivity Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lis_connectivity_status` SET TAGS ('dbx_value_regex' = 'connected|disconnected|error|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lis_interface_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information System (LIS) Interface ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `next_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|down|maintenance|decommissioned|pending_installation|calibration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `preventive_maintenance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `preventive_maintenance_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `quality_control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `quality_control_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|daily|weekly|per_run');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `total_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('dbx_subdomain' = 'test_catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Companion Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Instrument Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Complexity Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_value_regex' = 'waived|moderate|high');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `collection_instructions` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `critical_high_value` SET TAGS ('dbx_business_glossary_term' = 'Critical High Value Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `critical_low_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Value Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `minimum_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Specimen Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('dbx_business_glossary_term' = 'Orderable Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|pending_validation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `ordering_instructions` SET TAGS ('dbx_business_glossary_term' = 'Ordering Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `panic_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Panic Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `performing_lab_location` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `performing_lab_location` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `preferred_volume` SET TAGS ('dbx_business_glossary_term' = 'Preferred Specimen Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_code` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Test Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_adult` SET TAGS ('dbx_business_glossary_term' = 'Adult Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_pediatric` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Result Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|semi_quantitative|narrative|culture|microscopic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_business_glossary_term' = 'Specimen Container Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_business_glossary_term' = 'Specimen Stability Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_business_glossary_term' = 'Specimen Storage Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Abbreviation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'individual_test|panel|profile|reflex_test|add_on_test');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_business_glossary_term' = 'Specimen Transport Conditions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_business_glossary_term' = 'Routine Turnaround Time (TAT)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_stat` SET TAGS ('dbx_business_glossary_term' = 'STAT Turnaround Time (TAT)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
