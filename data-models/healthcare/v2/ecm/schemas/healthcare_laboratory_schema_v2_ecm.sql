-- Schema for Domain: laboratory | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`laboratory` COMMENT 'Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` (
    `lab_order_id` BIGINT COMMENT 'Unique identifier for the laboratory order.',
    `claim_id` BIGINT COMMENT 'Associated claim for billing.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial tracking.',
    `demographics_id` BIGINT COMMENT 'Foreign key to patient demographics.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code justifying the order.',
    `health_plan_id` BIGINT COMMENT 'Health plan covering the order.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel for order transmission.',
    `payer_id` BIGINT COMMENT 'Insurance payer for the order.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the lab test.',
    `measure_id` BIGINT COMMENT 'Quality measure associated with the order.',
    `research_study_id` BIGINT COMMENT 'Research study if this is a study-related order.',
    `scheduling_appointment_id` BIGINT COMMENT 'Associated appointment for specimen collection.',
    `tertiary_lab_cancelled_by_provider_clinician_id` BIGINT COMMENT 'Clinician who cancelled the order.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key to the test catalog entry.',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
    `authorization_number` STRING COMMENT 'Prior authorization number.',
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
    `performing_lab_location` STRING COMMENT 'Location where the test will be performed.',
    `point_of_care_test` BOOLEAN COMMENT 'Whether this is a point-of-care test.',
    `record_number` BIGINT COMMENT 'Consent record for the lab order.',
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
    `standing_order` BOOLEAN COMMENT 'Whether this is a standing order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_lab_order PRIMARY KEY(`lab_order_id`)
) COMMENT 'Laboratory test orders placed by clinicians, including order details, specimen requirements, and fulfillment status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` (
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial tracking.',
    `employee_id` BIGINT COMMENT 'Employee who collected the specimen.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `message_log_id` BIGINT COMMENT 'Interface message log for specimen data.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key to the patient MPI record.',
    `parent_specimen_id` BIGINT COMMENT 'Parent specimen if this is an aliquot.',
    `scheduling_appointment_id` BIGINT COMMENT 'Appointment for specimen collection.',
    `training_id` BIGINT COMMENT 'Training record for specimen handling.',
    `visit_id` BIGINT COMMENT 'Foreign key to the encounter visit.',
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
    `cost_center_id` BIGINT COMMENT 'Cost center for financial tracking.',
    `demographics_id` BIGINT COMMENT 'Foreign key to patient demographics.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code associated with the result.',
    `fhir_resource_log_id` BIGINT COMMENT 'FHIR resource log for interoperability.',
    `hedis_measure_id` BIGINT COMMENT 'HEDIS measure associated with the result.',
    `instrument_id` BIGINT COMMENT 'Instrument used to perform the test.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `loinc_code_id` BIGINT COMMENT 'LOINC code for the test.',
    `phi_access_log_id` BIGINT COMMENT 'PHI access log for compliance.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the test.',
    `employee_id` BIGINT COMMENT 'Employee who performed the test.',
    `measure_id` BIGINT COMMENT 'Quality measure associated with the result.',
    `reagent_lot_id` BIGINT COMMENT 'Reagent lot used for the test.',
    `reference_range_id` BIGINT COMMENT 'Reference range for the test result.',
    `research_study_id` BIGINT COMMENT 'Research study if applicable.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED concept for the result.',
    `specimen_id` BIGINT COMMENT 'Foreign key to the specimen.',
    `tertiary_test_amending_user_employee_id` BIGINT COMMENT 'Employee who amended the result.',
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
    `performing_lab_facility` STRING COMMENT 'Facility where the test was performed.',
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
    `loinc_code_id` BIGINT COMMENT 'LOINC code for the test.',
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
    `instrument_platform` STRING COMMENT 'Instrument platform for which the range applies.',
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
    `cda_document_id` BIGINT COMMENT 'CDA document for interoperability.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial tracking.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `mortality_review_id` BIGINT COMMENT 'Mortality review.',
    `payer_id` BIGINT COMMENT 'Insurance payer.',
    `phi_access_log_id` BIGINT COMMENT 'PHI access log.',
    `clinician_id` BIGINT COMMENT 'Pathologist who signed out the report.',
    `quality_peer_review_id` BIGINT COMMENT 'Quality peer review.',
    `reagent_lot_id` BIGINT COMMENT 'Reagent lot used.',
    `research_study_id` BIGINT COMMENT 'Research study if applicable.',
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
    `performing_laboratory` STRING COMMENT 'Laboratory that performed the pathology.',
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
    `care_site_id` BIGINT COMMENT 'Care site where culture was performed.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the culture.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial tracking.',
    `demographics_id` BIGINT COMMENT 'Foreign key to patient demographics.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `improvement_initiative_id` BIGINT COMMENT 'Quality improvement initiative.',
    `instrument_id` BIGINT COMMENT 'Instrument used for culture.',
    `lab_order_id` BIGINT COMMENT 'Foreign key to the lab order.',
    `material_master_id` BIGINT COMMENT 'Supply material used.',
    `message_log_id` BIGINT COMMENT 'Interface message log.',
    `organism_id` BIGINT COMMENT 'Foreign key to the organism identified.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED concept for the organism.',
    `osha_exposure_incident_id` BIGINT COMMENT 'OSHA exposure incident.',
    `patient_safety_event_id` BIGINT COMMENT 'Patient safety event if applicable.',
    `payer_id` BIGINT COMMENT 'Insurance payer.',
    `employee_id` BIGINT COMMENT 'Employee who performed the culture.',
    `reagent_lot_id` BIGINT COMMENT 'Reagent lot used.',
    `research_study_id` BIGINT COMMENT 'Research study if applicable.',
    `specimen_id` BIGINT COMMENT 'Foreign key to the specimen.',
    `substance_use_consent_id` BIGINT COMMENT 'Substance use consent.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` (
    `susceptibility_result_id` BIGINT COMMENT 'Unique identifier for the antimicrobial susceptibility test result record. Primary key for the susceptibility result entity.',
    `clinician_id` BIGINT COMMENT 'Reference to the laboratory professional (medical technologist, clinical pathologist, or microbiologist) who verified and approved the susceptibility result. Links to the provider entity.',
    `instrument_id` BIGINT COMMENT 'Identifier of the laboratory instrument or analyzer used to perform the susceptibility test (e.g., VITEK 2, Phoenix M50, manual bench). Used for quality control and troubleshooting.',
    `lab_order_id` BIGINT COMMENT 'Reference to the originating laboratory order that requested the culture and susceptibility testing. Links to the lab order entity.',
    `microbiology_culture_id` BIGINT COMMENT 'Reference to the parent microbiology culture workup that this susceptibility result belongs to. Links to the culture entity.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient from whom the specimen was collected. Links to the patient master entity.',
    `organism_id` BIGINT COMMENT 'Reference to the specific organism isolated from the culture for which this susceptibility test was performed. Links to the organism entity.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Susceptibility tests are catalog tests. Currently susceptibility_result has antibiotic_agent_code/name but no FK to test_catalog. Business reality: susceptibility panels are catalog tests (e.g., Gram-',
    `antibiotic_agent_code` STRING COMMENT 'Standardized code identifying the antimicrobial agent tested. May be NDC (National Drug Code), SNOMED CT, or local laboratory code.',
    `antibiotic_agent_name` STRING COMMENT 'Human-readable name of the antimicrobial agent tested (e.g., Penicillin, Vancomycin, Ciprofloxacin).',
    `antibiotic_class` STRING COMMENT 'Therapeutic class or category of the antimicrobial agent (e.g., Beta-lactam, Fluoroquinolone, Aminoglycoside, Glycopeptide).',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'Indicates whether this result has been flagged for antibiotic stewardship program review due to resistance pattern, restricted antimicrobial use, or other stewardship criteria. True indicates flagged for review.',
    `clsi_breakpoint_version` STRING COMMENT 'Version of the CLSI M100 Performance Standards document used to interpret the susceptibility result. Breakpoints are updated annually and version is critical for accurate interpretation (e.g., M100-Ed31, M100-Ed32).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this susceptibility result record was first created in the data platform. Audit trail for data lineage and compliance.',
    `disk_diffusion_zone_diameter_mm` DECIMAL(18,2) COMMENT 'Zone of inhibition diameter measured in millimeters for disk diffusion (Kirby-Bauer) susceptibility testing method. Larger zones indicate greater susceptibility.',
    `inducible_resistance_flag` BOOLEAN COMMENT 'Indicates whether inducible resistance was detected (e.g., inducible clindamycin resistance in Staphylococcus, inducible AmpC in Enterobacteriaceae). True indicates inducible resistance detected; False indicates not detected.',
    `infection_control_alert_flag` BOOLEAN COMMENT 'Indicates whether this result triggered an infection control alert due to detection of multidrug-resistant organism (MDRO), reportable organism, or outbreak-associated pathogen. True indicates alert generated.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the specific susceptibility test performed. Enables standardized reporting and interoperability across systems.',
    `mic_operator` STRING COMMENT 'Comparison operator for the MIC value when the exact value is at or beyond the test range limits (e.g., <=0.5 indicates at or below the lowest tested concentration).. Valid values are `=|<=|>=|<|>`',
    `mic_unit` STRING COMMENT 'Unit of measure for the MIC value, typically micrograms per milliliter (mcg/mL) or milligrams per liter (mg/L).. Valid values are `mcg/mL|mg/L|IU/mL`',
    `mic_value` DECIMAL(18,2) COMMENT 'Minimum inhibitory concentration value representing the lowest concentration of antimicrobial agent that inhibits visible growth of the organism. Expressed as a numeric value with unit of measure.',
    `panel_code` STRING COMMENT 'Code identifying the standardized panel or battery of antimicrobial agents tested together (e.g., Gram Positive Panel, Gram Negative Panel, Anaerobe Panel). Panels are organism-specific.',
    `panel_name` STRING COMMENT 'Human-readable name of the antimicrobial susceptibility panel tested (e.g., Gram Positive Cocci Panel, Enterobacteriaceae Panel, Pseudomonas Panel).',
    `performing_lab_code` STRING COMMENT 'Code identifying the laboratory facility or department that performed the susceptibility testing. May be internal facility code or CLIA number.',
    `performing_lab_name` STRING COMMENT 'Name of the laboratory facility or department that performed the susceptibility testing (e.g., Main Hospital Microbiology Lab, Reference Laboratory).',
    `quality_control_status` STRING COMMENT 'Status of quality control testing performed concurrently with patient susceptibility testing. Passed indicates QC organisms yielded expected results; Failed indicates out-of-range QC results requiring investigation.. Valid values are `passed|failed|not applicable`',
    `reportable_to_public_health_flag` BOOLEAN COMMENT 'Indicates whether this susceptibility result is reportable to public health authorities (e.g., state health department, CDC) due to detection of notifiable disease or antimicrobial resistance pattern. True indicates reportable.',
    `resistance_gene` STRING COMMENT 'Specific resistance gene detected through molecular testing (e.g., mecA, vanA, blaNDM, blaKPC). Used for epidemiological tracking and infection control.',
    `resistance_mechanism` STRING COMMENT 'Known or suspected mechanism of antimicrobial resistance detected (e.g., ESBL, Carbapenemase, MRSA, VRE, AmpC). Critical for infection control and antibiotic stewardship.',
    `resistant_breakpoint` DECIMAL(18,2) COMMENT 'MIC breakpoint value at or above which the organism is classified as resistant according to CLSI guidelines. Used for automated interpretation.',
    `result_comment` STRING COMMENT 'Free-text comment or interpretive note from the laboratory regarding the susceptibility result. May include recommendations for therapy, warnings about resistance patterns, or technical notes.',
    `result_status` STRING COMMENT 'Current status of the susceptibility result in its lifecycle. Preliminary results may be released before final verification; Final results have been verified and released; Corrected indicates an amendment to a previously final result.. Valid values are `preliminary|final|corrected|cancelled|entered in error`',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the susceptibility test result was generated or finalized by the laboratory information system. Represents the business event time of result availability.',
    `snomed_code` STRING COMMENT 'SNOMED CT code for the susceptibility test result or interpretation. Supports clinical documentation and semantic interoperability.',
    `source_system_code` STRING COMMENT 'Code identifying the source laboratory information system (LIS) that generated this susceptibility result (e.g., Epic Beaker, Cerner PathNet, Sunquest). Used for data lineage and integration troubleshooting.',
    `susceptibility_interpretation` STRING COMMENT 'Clinical interpretation of the susceptibility test result based on CLSI breakpoints. Susceptible indicates the organism is inhibited by achievable drug concentrations; Intermediate indicates uncertain efficacy; Resistant indicates the organism is not inhibited by normally achievable concentrations; Susceptible-dose dependent indicates efficacy depends on dosing regimen.. Valid values are `susceptible|intermediate|resistant|susceptible-dose dependent|not tested|indeterminate`',
    `susceptible_breakpoint` DECIMAL(18,2) COMMENT 'MIC breakpoint value at or below which the organism is classified as susceptible according to CLSI guidelines. Used for automated interpretation.',
    `synergy_test_result` STRING COMMENT 'Result of synergy testing for combination antimicrobial therapy (e.g., beta-lactam/beta-lactamase inhibitor combinations). Positive indicates synergistic effect detected.. Valid values are `positive|negative|not performed`',
    `testing_method` STRING COMMENT 'Laboratory method used to perform the susceptibility test. Common methods include broth microdilution (gold standard for MIC), disk diffusion (Kirby-Bauer), E-test (gradient diffusion), and automated systems (e.g., VITEK, Phoenix).. Valid values are `broth microdilution|disk diffusion|E-test|automated system|agar dilution|gradient diffusion`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this susceptibility result record was last modified in the data platform. Audit trail for data lineage and compliance.',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time when the susceptibility result was verified and approved for clinical use by authorized laboratory personnel (medical technologist or pathologist).',
    CONSTRAINT pk_susceptibility_result PRIMARY KEY(`susceptibility_result_id`)
) COMMENT 'Antimicrobial susceptibility test results showing organism resistance patterns.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` (
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the blood product unit. Primary key for the blood bank unit record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Blood bank inventory and transfusion services must be costed to the blood bank cost center for product cost tracking, wastage analysis, and departmental budget management. Required for transfusion ser',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Blood bank units are crossmatched against patient specimens. Currently no FK exists. Business reality: crossmatch requires patient specimen (type and screen). Adding crossmatch_specimen_id FK (nullabl',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Blood product units require HCPCS linkage for billing, inventory valuation, and utilization reporting. The hcpcs_code text field is denormalized; proper FK enables automated charge capture, payer cont',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Blood products and transfusion supplies (filters, tubing, warmers, collection sets) are inventory items in the material master. This link enables blood bank inventory management, charge capture, and r',
    `reagent_lot_id` BIGINT COMMENT 'Foreign key linking to laboratory.reagent_lot. Business justification: Blood bank operations use reagent lots for typing and crossmatch testing. Currently blood_bank_unit has lot_number (string) but this likely refers to the blood product lot, not reagent lot. Adding rea',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Blood bank units are stored in specific temperature-controlled rooms (blood bank refrigerators). AABB standards and FDA regulations require precise physical location tracking for inventory management,',
    `abo_blood_group` STRING COMMENT 'ABO blood type of the unit. Critical for compatibility matching with recipient to prevent hemolytic transfusion reactions.. Valid values are `A|B|AB|O`',
    `bacterial_contamination_testing_status` STRING COMMENT 'Status of bacterial detection testing, primarily for platelet units which are stored at room temperature. Positive results require unit quarantine and discard.. Valid values are `tested_negative|tested_positive|pending|not_applicable`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Amount charged to the patient or payer for this blood unit. Used for revenue cycle management and billing.',
    `cmv_status` STRING COMMENT 'CMV serology status of the donor. CMV-negative or CMV-safe (leukoreduced) units are required for immunocompromised patients, neonates, and pregnant women.. Valid values are `cmv_negative|cmv_positive|cmv_safe`',
    `collection_facility_code` STRING COMMENT 'Identifier of the blood center or facility where the donation was collected. Required for traceability and recall management.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Acquisition or production cost of the blood unit. Used for inventory valuation, cost accounting, and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blood bank unit record was first created in the system. Used for audit trail and data lineage.',
    `crossmatch_required_flag` BOOLEAN COMMENT 'Indicates whether a serologic crossmatch is required before issuing this unit. May be waived for type O emergency release or for patients with negative antibody screens.',
    `discard_reason` STRING COMMENT 'Reason why the unit was discarded. Used for quality improvement, waste reduction initiatives, and regulatory reporting. [ENUM-REF-CANDIDATE: expired|temperature_excursion|positive_test_result|damaged|contaminated|outdated|quality_control_failure|other — 8 candidates stripped; promote to reference product]',
    `discard_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was discarded. Triggers waste tracking and quality review processes.',
    `donation_date` DATE COMMENT 'Date when the blood was collected from the donor. Used to calculate product age and expiration date.',
    `donation_identification_number` STRING COMMENT 'Unique identifier assigned to the original blood donation from which this unit was derived. Links unit to donor record for traceability and recall purposes.',
    `expiration_date` DATE COMMENT 'Date after which the blood product is no longer suitable for transfusion. Varies by product type and storage conditions (e.g., 42 days for packed red cells, 5 days for platelets).',
    `extended_phenotype` STRING COMMENT 'Additional red blood cell antigen profile beyond ABO/Rh (e.g., Kell, Duffy, Kidd, MNS). Used for patients with alloantibodies or those requiring antigen-matched units.',
    `hemoglobin_s_status` STRING COMMENT 'Indicates presence of sickle hemoglobin in the donor unit. Some institutions avoid sickle trait units for neonatal or exchange transfusions.. Valid values are `negative|trait|positive|unknown`',
    `infectious_disease_testing_status` STRING COMMENT 'Overall status of mandatory infectious disease testing (HIV, HBV, HCV, syphilis, HTLV, West Nile Virus, Zika, Chagas). Only units testing negative are released for transfusion.. Valid values are `tested_negative|tested_positive|pending|not_tested`',
    `irradiation_date` DATE COMMENT 'Date when the blood unit was irradiated. Irradiated units have reduced shelf life (typically 28 days from irradiation or original expiration, whichever is sooner).',
    `irradiation_status` STRING COMMENT 'Indicates whether the unit has been gamma-irradiated to prevent transfusion-associated graft-versus-host disease (TA-GVHD) in immunocompromised patients.. Valid values are `irradiated|non_irradiated`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was issued from the blood bank to the clinical area for transfusion. Starts the clock for return or transfusion completion.',
    `issued_to_location` STRING COMMENT 'Clinical unit or department to which the blood unit was issued (e.g., OR 3, ICU 2, ED). Used for tracking and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this blood bank unit record was last modified. Supports change tracking and audit compliance.',
    `leukoreduction_status` STRING COMMENT 'Indicates whether white blood cells have been removed from the unit. Leukoreduction reduces febrile reactions, CMV transmission risk, and HLA alloimmunization.. Valid values are `leukoreduced|non_leukoreduced`',
    `lot_number` STRING COMMENT 'Lot number for pooled products (e.g., pooled platelets, pooled cryoprecipitate) or for products manufactured from multiple donations. Required for recall management.',
    `product_code` STRING COMMENT 'Standardized code identifying the specific blood product type. Used for inventory management, ordering, and billing.. Valid values are `^[A-Z0-9]{4,10}$`',
    `product_type` STRING COMMENT 'Classification of the blood component or product. Determines storage requirements, shelf life, and clinical indications for transfusion.. Valid values are `packed_red_blood_cells|platelets|fresh_frozen_plasma|cryoprecipitate|whole_blood|granulocytes`',
    `quarantine_reason` STRING COMMENT 'Reason why the unit has been placed in quarantine status (e.g., pending investigation, donor callback, positive test result, temperature deviation). Prevents inadvertent release.',
    `quarantine_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was placed into quarantine status. Initiates investigation and documentation requirements.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Blood product administration requires documented consent. Directed donations (family member to patient), autologous transfusions (patients own blood), and Jehovahs Witness refusals all require conse',
    `reservation_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was reserved for a specific patient. Used to manage hold times and release units if not transfused within policy timeframe.',
    `reserved_for_patient_mrn` STRING COMMENT 'Medical Record Number of the patient for whom this unit has been reserved or crossmatched. Ensures unit is held for the intended recipient.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time when an issued unit was returned to the blood bank unused. Units returned within acceptable time and temperature may be re-entered into inventory.',
    `rh_type` STRING COMMENT 'Rh (D antigen) status of the blood unit. Essential for preventing Rh alloimmunization, especially in Rh-negative recipients.. Valid values are `positive|negative`',
    `special_processing_codes` STRING COMMENT 'Comma-separated list of special processing or modifications applied to the unit (e.g., washed, volume-reduced, split, pooled). Affects clinical use and billing.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Current storage temperature in Celsius. Must be maintained within product-specific ranges (e.g., 1-6°C for red cells, 20-24°C for platelets, ≤-18°C for FFP).',
    `supplier_facility_code` STRING COMMENT 'Identifier of the external blood supplier or blood center if the unit was not collected in-house. Used for vendor management and recall coordination.',
    `temperature_alarm_flag` BOOLEAN COMMENT 'Indicates whether a temperature excursion alarm has been triggered for this unit. Temperature deviations may render the unit unsuitable for transfusion.',
    `transfusion_timestamp` TIMESTAMP COMMENT 'Date and time when the transfusion was started. Critical for hemovigilance reporting and adverse event investigation.',
    `unit_number` STRING COMMENT 'Globally unique blood unit identifier encoded using ISBT 128 standard barcode format. Enables worldwide traceability of blood products from donor to recipient.. Valid values are `^[A-Z0-9]{13,14}$`',
    `unit_status` STRING COMMENT 'Current lifecycle status of the blood unit. Tracks the unit from availability through final disposition (transfused, discarded, or returned). [ENUM-REF-CANDIDATE: available|reserved|crossmatched|issued|transfused|returned|discarded|quarantined|expired — 9 candidates stripped; promote to reference product]',
    `volume_ml` DECIMAL(18,2) COMMENT 'Volume of the blood product in milliliters. Used for dosing calculations and inventory management.',
    CONSTRAINT pk_blood_bank_unit PRIMARY KEY(`blood_bank_unit_id`)
) COMMENT 'Blood bank inventory units including blood products, crossmatch status, and expiration tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` (
    `transfusion_event_id` BIGINT COMMENT 'Unique identifier for the transfusion event record. Primary key.',
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the specific blood product unit transfused. Links to blood bank inventory.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the healthcare facility where the transfusion was performed.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Transfusion events generate billable charges for blood products and administration services. Direct link supports charge capture at point of transfusion, enables blood bank revenue tracking, facilitat',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Blood transfusions are high-cost billable events generating claims for blood products, administration, and compatibility testing. Critical for blood bank revenue capture, transfusion service billing, ',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order authorizing the transfusion.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transfusion services must be charged to the performing cost center for transfusion service cost tracking, nursing time allocation, and departmental budgeting. Essential for blood utilization program c',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient receiving the transfusion. Links to the patient master record.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Transfusion events require HCPCS linkage for billing, hemovigilance reporting, and utilization management. Enables automated charge capture for blood administration, supports transfusion reaction cost',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Transfusion events trigger blood administration notifications to blood bank systems and hemovigilance reporting to FDA/AABB. Links transfusion to transmission event for adverse reaction reporting audi',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: Transfusion reactions (hemolytic, allergic, TRALI) are reportable patient safety events. Blood bank and quality departments link transfusion events to safety event tracking for hemovigilance programs ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Blood product transfusions are high-cost events requiring prior authorization and coverage verification. Utilization review programs monitor transfusion appropriateness, and billing requires payer ide',
    `employee_id` BIGINT COMMENT 'Unique identifier for the medical laboratory technologist who performed the crossmatch testing.',
    `specimen_id` BIGINT COMMENT 'Identifier for the patient blood specimen used for compatibility testing. Critical for ensuring correct patient-unit matching.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Blood transfusions during surgery are common and require tracking for blood bank management, surgical quality metrics, and hemovigilance reporting. Essential for linking intra-operative transfusions t',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Blood transfusions require specific informed consent documenting transfusion risks (reactions, infections, iron overload), benefits, and alternatives. Regulatory requirement in most jurisdictions. Jeh',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter during which the transfusion occurred.',
    `antibody_screen_result` STRING COMMENT 'Result of the antibody screening test to detect unexpected antibodies in patient serum that could cause transfusion reactions.. Valid values are `positive|negative|not_performed|indeterminate`',
    `clinical_indication` STRING COMMENT 'Medical reason or clinical indication for the transfusion (e.g., acute blood loss, anemia, thrombocytopenia, coagulopathy). Supports appropriateness review and utilization management.',
    `consent_datetime` TIMESTAMP COMMENT 'Date and time when informed consent for transfusion was obtained.',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether informed consent for transfusion was obtained from the patient or authorized representative prior to administration.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this transfusion event record was first created in the system. Audit trail timestamp.',
    `crossmatch_datetime` TIMESTAMP COMMENT 'Date and time when the crossmatch compatibility testing was completed.',
    `crossmatch_result` STRING COMMENT 'Outcome of the compatibility testing between donor unit and patient sample. Compatible indicates safe to transfuse, incompatible indicates potential reaction risk.. Valid values are `compatible|incompatible|not_performed|indeterminate`',
    `crossmatch_type` STRING COMMENT 'Type of compatibility testing performed prior to transfusion. Electronic crossmatch uses computer verification, immediate spin is abbreviated testing, full serologic is complete antiglobulin testing.. Valid values are `electronic|immediate_spin|full_serologic|type_and_screen|emergency_release`',
    `hemovigilance_reported` BOOLEAN COMMENT 'Boolean flag indicating whether this transfusion event was reported to the institutional or national hemovigilance surveillance system, typically for adverse reactions.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this transfusion event record was most recently modified. Audit trail timestamp.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the transfusion event, including any special circumstances, patient tolerance, or follow-up actions.',
    `post_transfusion_blood_pressure_diastolic` STRING COMMENT 'Patient diastolic blood pressure in mmHg measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_blood_pressure_systolic` STRING COMMENT 'Patient systolic blood pressure in mmHg measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_pulse` STRING COMMENT 'Patient pulse rate in beats per minute measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_respiratory_rate` STRING COMMENT 'Patient respiratory rate in breaths per minute measured after transfusion completion. Used to detect respiratory complications.',
    `post_transfusion_temperature` DECIMAL(18,2) COMMENT 'Patient body temperature in degrees Celsius measured after transfusion completion. Used to detect febrile reactions.',
    `pre_transfusion_blood_pressure_diastolic` STRING COMMENT 'Patient diastolic blood pressure in mmHg measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_blood_pressure_systolic` STRING COMMENT 'Patient systolic blood pressure in mmHg measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_pulse` STRING COMMENT 'Patient pulse rate in beats per minute measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_respiratory_rate` STRING COMMENT 'Patient respiratory rate in breaths per minute measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_temperature` DECIMAL(18,2) COMMENT 'Patient body temperature in degrees Celsius measured immediately before transfusion start. Baseline for reaction monitoring.',
    `reaction_description` STRING COMMENT 'Free-text clinical description of the transfusion reaction signs, symptoms, and clinical course. May include fever, chills, rash, dyspnea, hypotension, or other manifestations.',
    `reaction_onset_datetime` TIMESTAMP COMMENT 'Date and time when the transfusion reaction symptoms were first observed. Critical for determining reaction type and causality.',
    `reaction_severity` STRING COMMENT 'Clinical severity classification of the transfusion reaction. Mild reactions may require monitoring only, severe and life-threatening reactions require immediate intervention.. Valid values are `mild|moderate|severe|life_threatening`',
    `special_requirements` STRING COMMENT 'Any special processing or handling requirements for the transfusion (e.g., irradiated, CMV-negative, leukoreduced, washed). Critical for immunocompromised patients.',
    `transfusion_end_datetime` TIMESTAMP COMMENT 'Date and time when the blood product transfusion was completed or discontinued.',
    `transfusion_number` STRING COMMENT 'Human-readable business identifier for the transfusion event, often used for tracking and audit purposes.',
    `transfusion_rate` DECIMAL(18,2) COMMENT 'Rate at which the blood product was administered (e.g., 100 mL/hour, slow infusion over 4 hours). Important for patient safety and reaction prevention.',
    `transfusion_reaction_occurred` BOOLEAN COMMENT 'Boolean flag indicating whether any adverse transfusion reaction was observed during or after the transfusion.',
    `transfusion_reaction_type` STRING COMMENT 'Classification of the adverse transfusion reaction type if one occurred. Includes febrile non-hemolytic reaction (FNHTR), allergic, anaphylactic, acute hemolytic, delayed hemolytic, transfusion-related acute lung injury (TRALI), and transfusion-associated circulatory overload (TACO). [ENUM-REF-CANDIDATE: febrile_non_hemolytic|allergic|anaphylactic|acute_hemolytic|delayed_hemolytic|transfusion_related_acute_lung_injury|transfusion_associated_circulatory_overload — 7 candidates stripped; promote to reference product]',
    `transfusion_site` STRING COMMENT 'Anatomical location or clinical area where the transfusion was administered (e.g., right antecubital, left hand, central line).',
    `transfusion_start_datetime` TIMESTAMP COMMENT 'Date and time when the blood product transfusion was initiated. Critical for monitoring transfusion duration and reaction timing.',
    `transfusion_status` STRING COMMENT 'Current lifecycle status of the transfusion event. Tracks progression from order through completion or discontinuation.. Valid values are `ordered|prepared|in_progress|completed|discontinued|cancelled`',
    `unexpected_antibody_identified` STRING COMMENT 'Specific antibody or antibodies identified during antibody identification testing, if antibody screen was positive. May include multiple antibodies separated by commas.',
    `volume_transfused_ml` STRING COMMENT 'Total volume of blood product transfused in milliliters. Used for dosing verification and fluid balance monitoring.',
    CONSTRAINT pk_transfusion_event PRIMARY KEY(`transfusion_event_id`)
) COMMENT 'Blood transfusion events including pre/post vital signs, reactions, and hemovigilance reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` (
    `point_of_care_test_id` BIGINT COMMENT 'Primary key for point_of_care_test',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility, department, or unit where the point-of-care test was performed (e.g., ED, ICU, clinic).',
    `clinical_order_id` BIGINT COMMENT 'Identifier of the clinical order that authorized this point-of-care test, if applicable. May be null for standing orders or protocol-driven tests.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the point-of-care test, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: POC tests must be charged to the performing locations cost center for decentralized testing cost tracking, CLIA waived test cost analysis, and departmental budget management. Critical for POC program',
    `demographics_id` BIGINT COMMENT 'Identifier of the patient for whom the point-of-care test was performed. Links to the patient master.',
    `employee_id` BIGINT COMMENT 'Identifier of the healthcare worker or staff member who performed the point-of-care test.',
    `instrument_id` BIGINT COMMENT 'Unique identifier or serial number of the point-of-care testing device used (e.g., glucometer serial number, iSTAT analyzer ID).',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: POC test cartridges, strips, and consumables are material master items. Linking enables usage tracking, automated reordering, cost-per-test calculation, and compliance with CLIA waived testing supply ',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: POC test results require EHR integration via HL7 messages for clinical documentation, billing, and regulatory compliance (CLIA-waived test tracking). Links POC test to transmission event for EHR integ',
    `previous_result_point_of_care_test_id` BIGINT COMMENT 'Identifier of the previous point-of-care test result that this record corrects or replaces, if applicable.',
    `qc_run_id` BIGINT COMMENT 'Foreign key linking to laboratory.qc_run. Business justification: POC tests should reference QC runs for compliance. Currently point_of_care_test has qc_status/qc_datetime but no FK. Business reality: POC testing requires documented QC before patient testing. Adding',
    `reagent_lot_id` BIGINT COMMENT 'Foreign key linking to laboratory.reagent_lot. Business justification: POC tests use reagent lots (test strips, cartridges). Currently point_of_care_test has reagent_lot_number (string) and reagent_expiration_date but no FK. Business reality: POC testing requires reagent',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: POC tests are instances of catalog tests performed at point of care. Currently point_of_care_test has test_code/loinc_code/test_name but no FK. Business reality: POC tests are catalog tests with speci',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter or visit during which the point-of-care test was performed.',
    `abnormal_flag` BOOLEAN COMMENT 'Indicator of whether the result is within normal range, abnormal, or critically abnormal. Used for clinical alerting.',
    `clia_waived_flag` BOOLEAN COMMENT 'Boolean indicator of whether this test is CLIA-waived (simple tests with low risk of error) or non-waived (moderate/high complexity).',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was collected for the test, if different from test performance time.',
    `corrected_result_flag` BOOLEAN COMMENT 'Boolean indicator of whether this result is a correction of a previously reported result. Supports audit trail and clinical safety.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this point-of-care test record was first created in the system. Audit trail field.',
    `critical_value_flag` BOOLEAN COMMENT 'Boolean indicator of whether this result represents a critical value requiring immediate clinical notification per facility policy.',
    `device_type` STRING COMMENT 'Type or category of the point-of-care testing device used for the test. [ENUM-REF-CANDIDATE: glucometer|istat|coaguchek|rapid_strep|influenza|urine_dipstick|blood_gas|pregnancy|troponin|other — 10 candidates stripped; promote to reference product]',
    `ehr_transmission_datetime` TIMESTAMP COMMENT 'Date and time when the test result was successfully transmitted to the EHR system.',
    `ehr_transmission_status` STRING COMMENT 'Status of the result transmission from the point-of-care device to the electronic health record system.. Valid values are `transmitted|pending|failed|not_required`',
    `mrn` STRING COMMENT 'The patients medical record number at the time of the test. Protected health information under HIPAA.',
    `operator_competency_date` DATE COMMENT 'Date when the operators competency for this test type was last assessed and verified.',
    `operator_competency_status` STRING COMMENT 'Competency status of the operator for this specific test type at the time of test performance. Required for CLIA compliance.. Valid values are `competent|training|expired|not_assessed`',
    `operator_name` STRING COMMENT 'Name of the healthcare worker who performed the point-of-care test. Retained for audit and competency tracking.',
    `performing_location_name` STRING COMMENT 'Name or description of the location where the point-of-care test was performed.',
    `qc_datetime` TIMESTAMP COMMENT 'Date and time when the most recent quality control check was performed on the device used for this test.',
    `qc_lot_number` STRING COMMENT 'Lot number of the quality control material used for device validation at the time of testing.',
    `qc_status` STRING COMMENT 'Status of quality control checks performed on the device at or near the time of the patient test. Critical for CLIA compliance.. Valid values are `passed|failed|not_performed|pending`',
    `reference_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the normal reference range for this test result, if applicable.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the normal reference range for this test result, if applicable.',
    `result_comment` STRING COMMENT 'Free-text comment or note associated with the test result, entered by the operator or reviewing clinician.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time when the test result was finalized and made available.',
    `result_numeric` DECIMAL(18,2) COMMENT 'Numeric representation of the test result, if applicable. Used for quantitative tests and trending analysis.',
    `result_unit` STRING COMMENT 'Unit of measure for the numeric result (e.g., mg/dL, mmol/L, seconds, INR). Should align with UCUM standards.',
    `result_value` DECIMAL(18,2) COMMENT 'The measured or observed result value from the point-of-care test. May be numeric, qualitative (positive/negative), or text.',
    `specimen_source` STRING COMMENT 'Anatomical source or collection site of the specimen (e.g., fingerstick, venous, throat).',
    `specimen_type` STRING COMMENT 'Type of specimen tested (e.g., whole blood, capillary blood, urine, throat swab). Uses SNOMED CT specimen types where applicable.',
    `test_category` STRING COMMENT 'Clinical category or discipline of the point-of-care test (e.g., chemistry, hematology, coagulation). [ENUM-REF-CANDIDATE: chemistry|hematology|coagulation|immunology|microbiology|urinalysis|blood_gas|cardiac_marker|other — 9 candidates stripped; promote to reference product]',
    `test_datetime` TIMESTAMP COMMENT 'Date and time when the point-of-care test was performed. Primary business event timestamp for the test.',
    `test_status` STRING COMMENT 'Current status of the point-of-care test result in its lifecycle (preliminary, final, corrected, cancelled).. Valid values are `preliminary|final|corrected|cancelled|entered_in_error`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this point-of-care test record was last modified. Audit trail field.',
    CONSTRAINT pk_point_of_care_test PRIMARY KEY(`point_of_care_test_id`)
) COMMENT 'Point-of-care test results performed at the bedside or clinic, including CLIA-waived tests.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` (
    `qc_run_id` BIGINT COMMENT 'Unique identifier for the quality control run record. Primary key for the qc_run product.',
    `accreditation_survey_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_survey. Business justification: QC documentation is reviewed during laboratory accreditation surveys. Surveyors verify QC compliance with CLIA/CAP standards (daily QC, proficiency testing, corrective actions) as part of laboratory q',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality control costs must be allocated to the performing lab sections cost center for QC cost analysis, regulatory compliance cost tracking, and budget management. Required for CLIA compliance cost ',
    `instrument_id` BIGINT COMMENT 'Reference to the laboratory instrument or analyzer on which the quality control run was performed. Links to the laboratory instrument master data for instrument identification, model, serial number, and location.',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory technologist or medical laboratory scientist who performed the quality control run. Links to workforce or provider master data for technologist name, credentials, and competency records.',
    `reagent_lot_id` BIGINT COMMENT 'FK to laboratory.reagent_lot',
    `test_catalog_id` BIGINT COMMENT 'FK to laboratory.test_catalog',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: QC procedures require documented competency training per CLIA. Linking QC runs to training records enables verification that only trained personnel performed quality control, required for regulatory c',
    `comments` STRING COMMENT 'Free-text comments or notes related to the quality control run. May include technologist observations, unusual circumstances, instrument issues, or additional context for QC results. Used for quality investigations and troubleshooting.',
    `corrective_action_taken` STRING COMMENT 'Detailed description of corrective action taken in response to failed quality control. Examples include recalibration performed, reagent lot changed, instrument maintenance completed, repeat QC passed, patient results reviewed and reissued. Required documentation for CLIA compliance when QC fails.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was completed. Documents when the laboratory resolved the quality control failure and resumed patient testing. Required for CLIA compliance and quality management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this quality control run record was first created in the laboratory information system. Audit trail timestamp for record creation.',
    `expected_mean` DECIMAL(18,2) COMMENT 'Manufacturer-assigned or laboratory-established mean value for the quality control material at this level. This is the target value against which observed results are compared. Used in Westgard rule evaluation and statistical quality control.',
    `expected_standard_deviation` DECIMAL(18,2) COMMENT 'Manufacturer-assigned or laboratory-established standard deviation for the quality control material at this level. Defines the acceptable range of variation. Used to calculate control limits (e.g., mean ± 2SD, mean ± 3SD) for Westgard rule evaluation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this quality control run record was last modified in the laboratory information system. Audit trail timestamp for record updates. Updated when QC status changes, review is completed, or corrective actions are documented.',
    `observed_result` DECIMAL(18,2) COMMENT 'Actual measured value obtained from the quality control run. This is the raw result produced by the instrument or test method. Compared against expected mean and standard deviation to determine pass/fail status.',
    `pass_fail_indicator` BOOLEAN COMMENT 'Boolean indicator of whether the quality control run met acceptance criteria. True indicates QC passed and patient testing may proceed. False indicates QC failed and corrective action is required before patient testing can resume.',
    `pt_attestation_date` DATE COMMENT 'Date when the laboratory director or designee attested that proficiency testing was performed in the same manner as patient testing, without interlaboratory communication or use of reference materials. Required attestation for CLIA compliance.',
    `pt_corrective_action_plan` STRING COMMENT 'Detailed corrective action plan documented in response to unacceptable proficiency testing result. Must include root cause analysis, immediate corrective actions, long-term preventive actions, and timeline for implementation. Required by CLIA for PT failures.',
    `pt_event_code` STRING COMMENT 'Unique identifier for the proficiency testing event or survey cycle. Typically includes year and survey number (e.g., CAP-2024-A, AAFP-2024-Q1). Used to track PT participation and results over time.',
    `pt_graded_result` STRING COMMENT 'Grading outcome assigned by the proficiency testing program. Acceptable indicates the laboratory result met PT acceptance criteria. Unacceptable indicates the laboratory result failed PT criteria and triggers regulatory action. Pending indicates grading is not yet complete. Not graded indicates the sample was educational only.. Valid values are `acceptable|unacceptable|pending|not_graded`',
    `pt_peer_group_mean` DECIMAL(18,2) COMMENT 'Mean value of all laboratories in the peer group for this proficiency testing sample. Peer groups are defined by test method or instrument type. Used to evaluate laboratory performance relative to peers.',
    `pt_peer_group_standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of all laboratories in the peer group for this proficiency testing sample. Measures the variability of peer group results. Used to calculate z-score and evaluate laboratory performance.',
    `pt_program_name` STRING COMMENT 'Name of the external proficiency testing program or provider. Examples include CAP (College of American Pathologists), AAFP (American Academy of Family Physicians), COLA (Commission on Office Laboratory Accreditation), Wisconsin State Laboratory of Hygiene. Applicable only when qc_type is proficiency_testing.',
    `pt_sample_number` STRING COMMENT 'Unique identifier for the specific proficiency testing sample within the event. PT programs typically send multiple samples per event (e.g., Sample 1, Sample 2, Sample 3). Used to track individual sample results.',
    `pt_submitted_result` STRING COMMENT 'Result value submitted by the laboratory to the proficiency testing program. This is the laboratorys answer for the PT sample. Stored as string to accommodate both quantitative and qualitative results.',
    `pt_z_score` DECIMAL(18,2) COMMENT 'Statistical measure of how many standard deviations the laboratory result differs from the peer group mean. Calculated as (submitted result - peer group mean) / peer group SD. Z-scores within ±2 are typically acceptable. Z-scores beyond ±3 indicate significant deviation.',
    `qc_level` STRING COMMENT 'Concentration level of the quality control material. Low, normal, and high levels span the reportable range of the test. Level 1, 2, 3 are alternative designations. Abnormal low and abnormal high represent pathological ranges. Multiple levels ensure accuracy across the entire measurement range. [ENUM-REF-CANDIDATE: low|normal|high|level_1|level_2|level_3|abnormal_low|abnormal_high — 8 candidates stripped; promote to reference product]',
    `qc_material_lot_number` STRING COMMENT 'Manufacturer lot number of the quality control material used in this run. For internal QC, this is the control material lot. For proficiency testing, this is the PT sample lot or shipment identifier. Critical for traceability and lot-to-result investigations.',
    `qc_run_status` STRING COMMENT 'Current lifecycle status of the quality control run. Pending indicates QC is scheduled but not yet performed, in progress indicates QC is actively being executed, passed indicates QC met acceptance criteria, failed indicates QC did not meet acceptance criteria and requires investigation, reviewed indicates QC results have been reviewed by supervisor, corrective action required indicates failed QC requires documented corrective action before patient testing can resume, and cancelled indicates QC run was voided. [ENUM-REF-CANDIDATE: pending|in_progress|passed|failed|reviewed|corrective_action_required|cancelled — 7 candidates stripped; promote to reference product]',
    `qc_run_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control run was performed. This is the principal business event timestamp representing when the QC material was analyzed or when the proficiency testing sample was tested.',
    `qc_type` STRING COMMENT 'Type of quality control activity performed. Internal QC validates daily instrument performance, proficiency testing evaluates laboratory competency against external standards, reagent lot validation ensures new reagent lots meet specifications, calibration verification confirms instrument calibration accuracy, instrument maintenance QC verifies post-maintenance performance, and competency assessment validates technologist proficiency.. Valid values are `internal_qc|proficiency_testing|reagent_lot_validation|calibration_verification|instrument_maintenance_qc|competency_assessment`',
    `reagent_storage_temperature` STRING COMMENT 'Required storage temperature or temperature range for the reagent or consumable. Examples include 2-8°C (refrigerated), -20°C (frozen), 15-30°C (room temperature). Proper storage is critical for reagent stability and performance.',
    `result_unit_of_measure` STRING COMMENT 'Unit of measure for the observed quality control result. Examples include mg/dL, mmol/L, g/dL, IU/L, seconds, cells/uL. Must match the unit of measure for the expected mean and standard deviation.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control results were reviewed by a supervisor or technical consultant. Required for failed QC runs and periodic supervisory review per CLIA regulations.',
    `test_code` STRING COMMENT 'Laboratory test or analyte code for which quality control was performed. Typically corresponds to LOINC code or internal laboratory test catalog code. For proficiency testing, this is the surveyed analyte or test method.',
    `westgard_rule_evaluation` STRING COMMENT 'Outcome of Westgard multirule quality control evaluation. Pass indicates result is within acceptable limits. 1_2s_warning indicates one control exceeds 2SD (warning, not rejection). 1_3s_reject indicates one control exceeds 3SD (reject run). 2_2s_reject indicates two consecutive controls exceed 2SD on same side of mean (reject run). r_4s_reject indicates range between two controls exceeds 4SD (reject run). 4_1s_reject indicates four consecutive controls exceed 1SD on same side (reject run). 10_x_reject indicates ten consecutive controls on same side of mean (reject run). Not applicable for non-quantitative QC. [ENUM-REF-CANDIDATE: pass|1_2s_warning|1_3s_reject|2_2s_reject|r_4s_reject|4_1s_reject|10_x_reject|not_applicable — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_qc_run PRIMARY KEY(`qc_run_id`)
) COMMENT 'Quality control runs for laboratory instruments including Westgard rules and proficiency testing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the laboratory instrument. Primary key.',
    `clia_certificate_id` BIGINT COMMENT 'Foreign key linking to laboratory.clia_certificate. Business justification: Instruments operate under CLIA certificates. Currently instrument has clia_certificate_number (string) but no FK. Business reality: instruments are certified under CLIA for specific testing. Adding cl',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Instruments must operate under compliance programs (CLIA quality systems, proficiency testing). Required for tracking regulatory obligations, audit scope, and quality control program alignment per CLI',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Instruments must be assigned to cost centers for depreciation expense allocation, maintenance cost tracking, and departmental asset accountability. Essential for cost allocation and capital equipment ',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory technician or biomedical engineer assigned primary responsibility for this instruments operation and maintenance.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Lab instruments meeting capitalization thresholds must be tracked as fixed assets for depreciation, asset management, insurance coverage, and financial statement reporting. Required for GAAP complianc',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Laboratory instruments (analyzers, centrifuges) covered by OSHA safety programs for equipment safety, lockout/tagout, and hazard communication. Linking instruments to programs enables compliance track',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Laboratory instruments are capital equipment acquired via purchase orders. Tracking the originating PO supports asset lifecycle management, warranty validation, depreciation calculation, and capital b',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Laboratory instruments are fixed assets installed in specific rooms. CLIA/CAP accreditation requires documented physical location for inspections, preventive maintenance scheduling, and operational pl',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: Instrument operation requires documented competency training before independent testing per CLIA. Linking instruments to training programs enables tracking of required competencies and audit verificat',
    `vendor_id` BIGINT COMMENT 'FK to supply.vendor',
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
    `clia_certificate_id` BIGINT COMMENT 'Foreign key linking to laboratory.clia_certificate. Business justification: Catalog tests are performed under specific CLIA certificates. Currently test_catalog has clia_complexity but no FK to certificate. Business reality: test offerings are governed by CLIA certification (',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Test catalog entries governed by compliance programs defining CLIA complexity levels, regulatory requirements, and authorization scope. Essential for maintaining compliant test menus and regulatory su',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Test catalog entries require structured CPT linkage for charge master maintenance, billing compliance, RVU-based productivity reporting, and payer contract validation. The cpt_code text field is denor',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Test catalog entries require structured LOINC linkage for interoperability, HIE result exchange, quality measure reporting, and EHR integration. The loinc_code text field is denormalized; proper FK en',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each test catalog entry requires specific reagent kits, cartridges, or consumables. Linking to material master enables automated inventory planning, par level calculation, and test cost modeling—core ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Catalog tests may specify preferred or required instruments. Currently test_catalog has instrument_platform (string) but no FK. Business reality: some tests require specific instruments (e.g., specifi',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Test catalog entries map to quality measures requiring specific tests (HbA1c for diabetes measures, lipid panel for cardiovascular measures). Quality measure specifications reference test codes from t',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Test catalog entries require SNOMED CT linkage for clinical terminology standardization, order set management, and semantic interoperability. Enables precise test ordering, supports clinical decision ',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` (
    `lab_charge_id` BIGINT COMMENT 'Unique identifier for the laboratory charge event. Primary key for the lab_charge product.',
    `billing_coverage_id` BIGINT COMMENT 'Reference to the insurance coverage or payer plan under which this laboratory charge will be billed.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or laboratory location where the test was performed.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Lab charges are specialized charge records requiring linkage to the parent billing.charge for charge reconciliation, claim submission workflows, payment posting, and financial reporting. Healthcare bi',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Lab charges must post to specific GL revenue accounts for proper revenue recognition, financial statement preparation, and GAAP/GASB compliance. Required for audit trails and external financial report',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Lab charges require structured CPT linkage for revenue cycle management, claim scrubbing, payer contract compliance, and financial analytics. The procedure_code text field is denormalized; proper FK e',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who received the laboratory service.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Charges are adjudicated against specific plan benefits, fee schedules, and coverage policies. Reimbursement rates, member cost-sharing, and claim edits are all plan-specific, requiring direct linkage ',
    `lab_order_id` BIGINT COMMENT 'Reference to the originating laboratory order that generated this charge event.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Lab charges often include supply costs for specific consumables or reagents used in testing. Linking to material master enables accurate cost-to-charge reconciliation, supply cost allocation, and marg',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Lab charges must be submitted to the correct payer for adjudication. Billing operations, claim submission, remittance processing, and accounts receivable management all require direct payer linkage at',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Some lab charges are specimen-specific (e.g., specimen collection fees, processing fees). Currently no FK exists. Business reality: charges may be associated with specific specimens. Adding specimen_i',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Lab charges are generated for specific catalog tests. Currently lab_charge has test_code/test_name but no FK to test_catalog. Business reality: charges are based on catalog test definitions. Adding te',
    `test_result_id` BIGINT COMMENT 'Reference to the completed laboratory test result associated with this charge.',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit during which the laboratory service was ordered and performed.',
    `billing_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the provider or organization that will bill for the laboratory service.. Valid values are `^[0-9]{10}$`',
    `cdm_code` STRING COMMENT 'Internal charge code from the hospital Charge Description Master (CDM) that maps to the procedure code and defines the standard charge amount.',
    `charge_created_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory charge record was first created in the system.',
    `charge_entry_method` STRING COMMENT 'Indicates how the laboratory charge was entered into the billing system. Automatic indicates system-generated upon test completion; manual indicates entered by billing staff; interface indicates transmitted from Laboratory Information System (LIS); batch indicates bulk upload.. Valid values are `automatic|manual|interface|batch`',
    `charge_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory charge was submitted to the billing system for claim generation.',
    `charge_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory charge record was last modified.',
    `charge_voided_by` STRING COMMENT 'Username or identifier of the user who voided the laboratory charge, if applicable.',
    `charge_voided_reason` STRING COMMENT 'Free-text explanation for why the laboratory charge was voided or cancelled, if applicable.',
    `charge_voided_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory charge was voided, if applicable.',
    `diagnosis_code_1` STRING COMMENT 'The primary ICD-10 diagnosis code justifying the medical necessity of the laboratory test.',
    `diagnosis_code_2` STRING COMMENT 'Secondary ICD-10 diagnosis code providing additional clinical context for the laboratory test, if applicable.',
    `diagnosis_code_3` STRING COMMENT 'Tertiary ICD-10 diagnosis code providing additional clinical context for the laboratory test, if applicable.',
    `diagnosis_code_4` STRING COMMENT 'Quaternary ICD-10 diagnosis code providing additional clinical context for the laboratory test, if applicable.',
    `insurance_authorization_number` STRING COMMENT 'The prior authorization or pre-certification number obtained from the insurance payer for the laboratory service, if required.',
    `ordering_provider_name` STRING COMMENT 'Full name of the physician or provider who ordered the laboratory test.',
    `ordering_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the physician or provider who ordered the laboratory test.. Valid values are `^[0-9]{10}$`',
    `performing_lab_section` STRING COMMENT 'The specific section or department within the laboratory that performed the test (e.g., Chemistry, Hematology, Microbiology, Pathology, Blood Bank, Molecular Diagnostics).',
    `performing_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the laboratory professional or pathologist who performed or interpreted the test.. Valid values are `^[0-9]{10}$`',
    `point_of_care_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the laboratory test was performed as point-of-care testing (at or near the site of patient care) rather than in a central laboratory.',
    `reference_lab_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the laboratory test was sent to an external reference laboratory for processing.',
    `reference_lab_name` STRING COMMENT 'Name of the external reference laboratory that performed the test, if applicable.',
    `service_location_code` STRING COMMENT 'Code indicating the place of service where the laboratory specimen was collected (e.g., 21 for Inpatient Hospital, 22 for Outpatient Hospital, 11 for Office, 81 for Independent Laboratory).',
    `stat_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional charge amount applied for STAT (urgent) laboratory tests. Null if no surcharge applies. Expressed in US dollars (USD).',
    CONSTRAINT pk_lab_charge PRIMARY KEY(`lab_charge_id`)
) COMMENT 'Laboratory charges for billing including CPT codes, modifiers, and diagnosis linkage.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` (
    `clia_certificate_id` BIGINT COMMENT 'Unique identifier for the CLIA certificate record. Primary key.',
    `accreditation_program_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_program. Business justification: CLIA certification is part of laboratory accreditation programs (CAP, TJC). Accreditation bodies verify CLIA compliance as part of survey processes, and CLIA status determines laboratory operational a',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: CLIA certificates obtained through deemed status via CAP/COLA/TJC accreditation. CMS regulatory pathway requires linking certificates to accreditation status for deemed status verification and survey ',
    `care_site_id` BIGINT COMMENT 'Reference to the laboratory facility or location that holds this CLIA certificate.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CLIA certificates are issued per laboratory location/cost center for regulatory compliance cost tracking, inspection fee allocation, and proficiency testing cost management. Required for regulatory pr',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: CLIA certificates affected by regulatory changes (new CLIA standards, testing requirements, proficiency testing rules). Linking certificates to regulatory changes enables impact assessment and complia',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: CLIA-certified labs exchange data with specific trading partners (reference labs, public health agencies, HIE networks) under data sharing agreements. Links certificate to partner for regulatory compl',
    `accrediting_organization` STRING COMMENT 'The CMS-approved accrediting organization that accredited the laboratory (CAP, Joint Commission, COLA, AABB, AOA, ASHI). Only applicable for Certificate of Accreditation. [ENUM-REF-CANDIDATE: cap|joint_commission|cola|aabb|aoa|ashi|not_applicable — 7 candidates stripped; promote to reference product]',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual CLIA user fee amount in USD charged by CMS for certificate maintenance and inspection services.',
    `annual_test_volume` STRING COMMENT 'Estimated or actual number of laboratory tests performed annually under this certificate. Used for fee calculation and inspection frequency determination.',
    `application_date` DATE COMMENT 'Date on which the laboratory submitted the CLIA certificate application to CMS or the state agency.',
    `certificate_number` STRING COMMENT 'The official CLIA certificate number issued by CMS or state agency. Format is typically 10 characters: 2-digit state code, letter D, and 7 digits (e.g., 12D3456789).. Valid values are `^[0-9]{2}D[0-9]{7}$`',
    `certificate_status` STRING COMMENT 'Current operational status of the CLIA certificate. Active certificates permit laboratory operations; expired, suspended, or revoked certificates require remediation.. Valid values are `active|expired|suspended|revoked|pending_renewal|inactive`',
    `certificate_type` STRING COMMENT 'The type of CLIA certificate held by the laboratory. Determines the complexity of testing permitted and regulatory oversight requirements.. Valid values are `certificate_of_waiver|provider_performed_microscopy|certificate_of_registration|certificate_of_compliance|certificate_of_accreditation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLIA certificate record was first created in the system.',
    `deficiency_count` STRING COMMENT 'Number of regulatory deficiencies cited during the most recent CLIA inspection. Zero indicates full compliance.',
    `effective_date` DATE COMMENT 'The date on which the CLIA certificate becomes valid and the laboratory is authorized to perform testing.',
    `expiration_date` DATE COMMENT 'The date on which the CLIA certificate expires. Certificates must be renewed before this date to maintain continuous authorization.',
    `fee_payment_status` STRING COMMENT 'Current status of CLIA user fee payment obligations. Delinquent status may trigger enforcement actions.. Valid values are `current|overdue|delinquent|waived|not_applicable`',
    `fee_schedule_category` STRING COMMENT 'CMS fee schedule category assigned to the laboratory based on certificate type, test volume, and complexity. Determines annual CLIA user fees.',
    `inspection_outcome` STRING COMMENT 'Result of the most recent CLIA inspection indicating compliance status and whether deficiencies were identified.. Valid values are `compliant|deficiencies_cited|conditional|not_applicable`',
    `issuing_agency` STRING COMMENT 'Name of the state health department or CMS regional office that issued the CLIA certificate.',
    `issuing_state` STRING COMMENT 'Two-letter state code of the state agency or CMS regional office that issued the CLIA certificate.. Valid values are `^[A-Z]{2}$`',
    `laboratory_director_license_number` STRING COMMENT 'State medical license or professional certification number of the laboratory director.',
    `laboratory_director_license_state` STRING COMMENT 'Two-letter state code where the laboratory director holds their professional license.. Valid values are `^[A-Z]{2}$`',
    `laboratory_director_name` STRING COMMENT 'Full name of the qualified laboratory director responsible for the overall operation and administration of the laboratory as required by CLIA.',
    `laboratory_director_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the laboratory director. Required for billing and regulatory reporting.. Valid values are `^[0-9]{10}$`',
    `laboratory_type` STRING COMMENT 'Classification of the laboratory facility type based on operational setting and ownership structure. [ENUM-REF-CANDIDATE: hospital|independent|physician_office|public_health|reference|blood_bank|other — 7 candidates stripped; promote to reference product]',
    `last_fee_payment_date` DATE COMMENT 'Date on which the laboratory last paid the required CLIA user fees. Delinquent fees may result in certificate suspension.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent CLIA inspection or survey conducted by CMS, state agency, or accrediting organization.',
    `last_proficiency_testing_date` DATE COMMENT 'Date of the most recent proficiency testing event or challenge submitted by the laboratory.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required CLIA inspection or survey. Typically every two years for non-accredited laboratories.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the CLIA certificate, inspections, or compliance status.',
    `plan_of_correction_due_date` DATE COMMENT 'Deadline by which the laboratory must submit a plan of correction to address cited deficiencies. Null if no deficiencies were found.',
    `plan_of_correction_status` STRING COMMENT 'Current status of the plan of correction submission and approval process for addressing inspection deficiencies.. Valid values are `not_required|pending|submitted|approved|rejected|overdue`',
    `proficiency_testing_enrollment` BOOLEAN COMMENT 'Indicates whether the laboratory is enrolled in required proficiency testing programs for the specialties it performs. Required for moderate and high complexity testing.',
    `proficiency_testing_outcome` STRING COMMENT 'Result of the most recent proficiency testing event. Unsuccessful results may trigger sanctions or certificate suspension.. Valid values are `successful|unsuccessful|pending|not_applicable`',
    `proficiency_testing_provider` STRING COMMENT 'Name of the CMS-approved proficiency testing provider(s) the laboratory is enrolled with (e.g., CAP, ARUP, Wisconsin State Laboratory of Hygiene).',
    `renewal_date` DATE COMMENT 'Date on which the CLIA certificate was most recently renewed. Certificates are typically valid for two years.',
    `renewal_status` STRING COMMENT 'Current status of the certificate renewal process. Overdue renewals may result in certificate expiration and cessation of testing.. Valid values are `not_due|pending|submitted|approved|denied|overdue`',
    `sanction_effective_date` DATE COMMENT 'Date on which the regulatory sanction became effective. Null if no sanctions are active.',
    `sanction_lifted_date` DATE COMMENT 'Date on which the regulatory sanction was lifted or resolved. Null if sanction is still active or no sanctions were imposed.',
    `sanction_type` STRING COMMENT 'Description of the type of sanction imposed (e.g., directed plan of correction, civil money penalty, suspension, limitation, revocation). Null if no sanctions are active.',
    `sanctions_imposed` BOOLEAN COMMENT 'Indicates whether any regulatory sanctions have been imposed on this certificate due to non-compliance, deficiencies, or proficiency testing failures.',
    `specialty_codes` STRING COMMENT 'Comma-separated list of CLIA specialty and subspecialty codes indicating the types of testing the laboratory is certified to perform (e.g., Microbiology, Chemistry, Hematology, Immunology).',
    `testing_complexity_level` STRING COMMENT 'The complexity level of laboratory testing authorized under this certificate. Determines personnel qualifications, quality control, and proficiency testing requirements.. Valid values are `waived|moderate|high|provider_performed_microscopy`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLIA certificate record was last modified in the system.',
    CONSTRAINT pk_clia_certificate PRIMARY KEY(`clia_certificate_id`)
) COMMENT 'CLIA certificates for laboratory facilities including inspection results and proficiency testing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` (
    `molecular_test_id` BIGINT COMMENT 'Unique identifier for the molecular diagnostic test record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Molecular tests audited for medical necessity, appropriate utilization, and billing compliance. High-cost testing subject to payer audits and internal utilization review; linking tests to audits enabl',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Molecular/genomic test reports transmitted as structured CDA documents to ordering providers, tumor boards, and precision medicine platforms. Links molecular test to document for genomic data exchange',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Molecular and genetic tests are high-value billable services with specific molecular pathology CPT codes. Essential for precision medicine billing, supporting medical necessity for expensive genomic t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: High-cost molecular tests must be tracked by the molecular pathology cost center for specialized testing cost analysis, budget management, and send-out test cost tracking. Essential for precision medi',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this molecular test was performed.',
    `genetic_testing_consent_id` BIGINT COMMENT 'Foreign key linking to consent.genetic_testing_consent. Business justification: Molecular/genetic testing requires specialized consent documenting GINA protections, incidental findings policies, family implications, research use, and result return preferences. Direct link to gene',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Plan-specific coverage policies determine which molecular tests are covered, under what clinical indications, and at what reimbursement rates. Medical necessity criteria and prior authorization rules ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Molecular tests use specific instruments (PCR machines, NGS platforms). Currently no FK exists. Business reality: molecular diagnostics require specific platforms (e.g., Illumina sequencers, Cepheid G',
    `lab_order_id` BIGINT COMMENT 'Reference to the parent laboratory order that authorized this molecular test.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Molecular test results require LOINC linkage for precision medicine reporting, genomic data exchange, and clinical trial matching. Enables standardized representation of genetic variants and supports ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Molecular test kits and reagents are high-cost material master items requiring tight inventory control. Linking enables molecular lab supply chain management, cost-per-test tracking, and utilization a',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Molecular and genetic testing has strict payer coverage policies with frequent prior authorization requirements. Companion diagnostics, pharmacogenomics, and precision medicine initiatives require pay',
    `reagent_lot_id` BIGINT COMMENT 'Foreign key linking to laboratory.reagent_lot. Business justification: Molecular tests use reagent lots (primers, probes, master mixes). Currently no FK exists. Business reality: molecular diagnostics require reagent lot tracking for traceability and quality control. Add',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Molecular/genomic tests are core endpoints in precision medicine trials (mutation status, gene expression, companion diagnostics). Must link to study for stratification, endpoint assessment, biomarker',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Molecular tests are performed ON specimens. Currently no FK exists. Business reality: molecular diagnostics (PCR, NGS) require specimen material. Adding specimen_id FK allows joining to get specimen d',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Molecular tests are catalog tests. Currently molecular_test has assay_code/assay_name but no FK. Business reality: molecular assays (PCR, NGS) are catalog tests. Adding test_catalog_id FK links to aut',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Molecular tests require SNOMED CT linkage for variant classification, clinical interpretation, and precision medicine reporting. Enables standardized representation of genetic findings, supports pharm',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this molecular test was ordered or performed.',
    `accession_number` STRING COMMENT 'Unique laboratory accession number assigned to the specimen for tracking and identification throughout the testing workflow.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Proportion of sequencing reads containing the variant allele, expressed as a decimal (e.g., 0.4523 for 45.23%). Important for tumor heterogeneity assessment.',
    `amended` BOOLEAN COMMENT 'Indicates whether this molecular test result has been amended or corrected after initial reporting.',
    `amendment_reason` STRING COMMENT 'Explanation of why the molecular test result was amended, including nature of the correction or additional information.',
    `amendment_timestamp` TIMESTAMP COMMENT 'Date and time when the molecular test result was amended or corrected.',
    `associated_drug` STRING COMMENT 'Name of the drug or therapeutic agent for which this molecular test provides companion diagnostic or pharmacogenomic guidance.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for sequence alignment, variant calling, and annotation.',
    `chromosome_location` STRING COMMENT 'Chromosomal location of the variant.',
    `clinical_indication` STRING COMMENT 'Clinical reason or indication for ordering the molecular test, describing the patient condition or diagnostic question being addressed.',
    `clinical_significance` STRING COMMENT 'Clinical significance of the finding.',
    `companion_diagnostic` BOOLEAN COMMENT 'Indicates whether this molecular test is a companion diagnostic required or recommended for selection of a specific therapeutic agent.',
    `copy_number` STRING COMMENT 'Copy number for CNV results.',
    `copy_number_variation` STRING COMMENT 'Description of copy number alterations detected, including amplifications, deletions, or duplications of genetic material.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of target genomic regions that achieved adequate sequencing depth for variant calling (e.g., 98.50 for 98.5% coverage).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this molecular test record was first created in the system.',
    `critical_value` BOOLEAN COMMENT 'Indicates whether the molecular test result represents a critical or panic value requiring immediate clinical notification.',
    `critical_value_notified_timestamp` TIMESTAMP COMMENT 'Date and time when the critical molecular test result was communicated to the ordering provider or clinical team.',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code associated with the clinical indication for the molecular test, used for medical necessity and billing.',
    `fda_cleared` BOOLEAN COMMENT 'Indicates whether the molecular test is FDA-cleared or approved, as opposed to a laboratory developed test (LDT).',
    `fusion_gene` STRING COMMENT 'Fusion gene identified for translocation results.',
    `gene_tested` STRING COMMENT 'Gene or genes tested.',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling was recommended.',
    `laboratory_developed_test` BOOLEAN COMMENT 'Indicates whether this is a laboratory developed test designed, manufactured, and used within a single laboratory.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this molecular test record was most recently modified or updated.',
    `medical_director_name` STRING COMMENT 'Name of the laboratory medical director responsible for oversight of the molecular testing operations.',
    `medical_director_npi` STRING COMMENT 'National Provider Identifier of the laboratory medical director who oversees the molecular testing program.',
    `methodology` STRING COMMENT 'Molecular technique or platform used to perform the test (e.g., RT-PCR for real-time polymerase chain reaction, NGS for next generation sequencing, WES for whole exome sequencing). [ENUM-REF-CANDIDATE: RT-PCR|ddPCR|NGS|WES|WGS|FISH|Sanger_sequencing|microarray|MLPA — 9 candidates stripped; promote to reference product]',
    `microsatellite_instability_status` STRING COMMENT 'MSI status (stable, low, high).',
    `pdl1_expression_score` DECIMAL(18,2) COMMENT 'PD-L1 expression score.',
    `performing_lab_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the molecular test, required for regulatory compliance.',
    `performing_lab_name` STRING COMMENT 'Name of the laboratory facility that performed the molecular test, which may be an internal lab or external reference laboratory.',
    `pharmacogenomic_phenotype` STRING COMMENT 'Pharmacogenomic phenotype (poor metabolizer, normal, rapid, etc.).',
    `quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score indicating confidence in the variant call. Higher scores indicate greater confidence.',
    `read_depth` STRING COMMENT 'Number of sequencing reads covering the genomic position of interest. Higher depth indicates greater confidence in variant calling.',
    `reference_genome` STRING COMMENT 'Version of the human reference genome used for sequence alignment and variant annotation (e.g., GRCh38/hg38).. Valid values are `GRCh37|GRCh38|hg19|hg38`',
    `reference_genome_build` STRING COMMENT 'Reference genome build used (GRCh37, GRCh38).',
    `report_narrative` STRING COMMENT 'Free-text narrative interpretation and clinical summary provided by the laboratory pathologist or molecular geneticist.',
    `reportable_to_registry_flag` BOOLEAN COMMENT 'Indicates whether this result is reportable to a registry.',
    `result_datetime` TIMESTAMP COMMENT 'Timestamp when the result was finalized.',
    `result_interpretation` STRING COMMENT 'High-level qualitative interpretation of the molecular test result indicating presence or absence of the target.. Valid values are `detected|not_detected|positive|negative|indeterminate|inconclusive`',
    `result_reported_timestamp` TIMESTAMP COMMENT 'Date and time when the molecular test results were finalized and reported to the ordering provider.',
    `result_status` STRING COMMENT 'Status of the result (preliminary, final, amended).',
    `sequencing_depth` STRING COMMENT 'Average sequencing depth/coverage.',
    `specimen_received_timestamp` TIMESTAMP COMMENT 'Date and time when the specimen was received by the molecular laboratory for processing.',
    `target_gene` STRING COMMENT 'Specific gene, genetic region, or pathogen targeted by the molecular test (e.g., BRCA1, EGFR, SARS-CoV-2).',
    `test_category` STRING COMMENT 'Clinical category or specialty area of the molecular test indicating its primary diagnostic purpose.. Valid values are `oncology|infectious_disease|pharmacogenomics|hereditary|prenatal|hematology`',
    `test_indication` STRING COMMENT 'Clinical indication for molecular testing.',
    `test_method` STRING COMMENT 'Molecular testing method (PCR, NGS, FISH, Sanger, microarray, etc.).',
    `test_performed_timestamp` TIMESTAMP COMMENT 'Date and time when the molecular test was actually performed or the assay was run.',
    `test_priority` STRING COMMENT 'Clinical priority assigned to the molecular test indicating urgency of processing and reporting.. Valid values are `routine|urgent|stat|asap`',
    `test_status` STRING COMMENT 'Current lifecycle status of the molecular test indicating its progression through the laboratory workflow. [ENUM-REF-CANDIDATE: ordered|specimen_collected|in_progress|resulted|amended|cancelled|preliminary — 7 candidates stripped; promote to reference product]',
    `test_type` STRING COMMENT 'Purpose or clinical context of the molecular test indicating whether it is for initial diagnosis, screening, confirmation, or therapeutic monitoring.. Valid values are `diagnostic|screening|confirmatory|monitoring|companion_diagnostic|research`',
    `therapeutic_implications` STRING COMMENT 'Clinical interpretation of how the molecular test results may inform treatment decisions, drug selection, or therapy monitoring.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score.',
    `turnaround_time_hours` STRING COMMENT 'Actual turnaround time from specimen receipt to result reporting, measured in hours. Critical metric for laboratory performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    `variant_classification` STRING COMMENT 'Clinical significance classification of the detected variant according to ACMG (American College of Medical Genetics) guidelines. VUS indicates Variant of Uncertain Significance.. Valid values are `pathogenic|likely_pathogenic|VUS|likely_benign|benign`',
    `variant_detected` BOOLEAN COMMENT 'Boolean indicator of whether a genetic variant or mutation was detected in the molecular test.',
    `variant_identified` STRING COMMENT 'Variant(s) identified in the test.',
    `variant_nomenclature` STRING COMMENT 'Standardized nomenclature describing the detected genetic variant using HGVS (Human Genome Variation Society) notation (e.g., c.2573T>G, p.Leu858Arg).',
    `variant_nomenclature_hgvs` STRING COMMENT 'HGVS nomenclature for the identified variant.',
    `zygosity` STRING COMMENT 'Zygosity of the variant (heterozygous, homozygous, hemizygous).',
    CONSTRAINT pk_molecular_test PRIMARY KEY(`molecular_test_id`)
) COMMENT 'Molecular and genetic test results including variant calling, allele frequency, and clinical significance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` (
    `reagent_lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot record. Primary key for the reagent_lot product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reagent inventory must be tracked by cost center for consumption analysis, budget variance reporting, and cost-per-test calculations. Critical for laboratory supply cost management and inventory valua',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Reagent lots are instances of material master items. This is the fundamental product-to-lot relationship for inventory management, enabling lot tracking, expiration management, recall handling, and in',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Reagent lots that are pharmaceutical products (e.g., therapeutic drug monitoring calibrators, immunoassay reagents) require NDC linkage for inventory management, regulatory compliance, and cost accoun',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Reagents are hazardous chemicals covered by OSHA chemical hygiene plans and hazard communication programs. Linking reagent lots to safety programs enables SDS tracking, training verification, and regu',
    `employee_id` BIGINT COMMENT 'The identifier of the laboratory technologist or staff member who performed and validated the QC testing for this reagent lot.',
    `instrument_id` BIGINT COMMENT 'The identifier of the laboratory instrument or analyzer to which this reagent lot is assigned or dedicated.',
    `reagent_instrument_id` BIGINT COMMENT 'FK to the instrument this reagent is used on.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Reagent lots must be stored in specific temperature-controlled rooms. FDA/CLIA regulations require documented storage locations for inventory management, expiration tracking, temperature excursion inv',
    `test_catalog_id` BIGINT COMMENT 'FK to the test catalog entry this reagent supports.',
    `vendor_id` BIGINT COMMENT 'The identifier of the vendor or supplier from whom the reagent lot was purchased.',
    `catalog_number` STRING COMMENT 'Manufacturer catalog number.',
    `certificate_of_analysis_available` BOOLEAN COMMENT 'Indicates whether a certificate of analysis is available.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The cost per unit of measure for this reagent lot, used for laboratory cost accounting and test cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reagent lot record was first created in the system.',
    `disposal_date` DATE COMMENT 'The date when the reagent lot was disposed of or removed from inventory.',
    `disposal_method` STRING COMMENT 'The method used to dispose of the reagent lot (e.g., hazardous waste disposal, standard waste, return to vendor).',
    `expiration_date` DATE COMMENT 'The date after which the reagent should not be used as determined by the manufacturer. Critical for CLIA compliance and patient safety.',
    `fda_clearance_number` STRING COMMENT 'The FDA 510(k) clearance number or premarket approval number for the reagent, if applicable.',
    `fda_cleared_flag` BOOLEAN COMMENT 'Indicates whether the reagent is FDA-cleared or approved for in vitro diagnostic use.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the reagent is classified as a hazardous material requiring special handling, storage, and disposal procedures.',
    `in_use_expiration_date` DATE COMMENT 'The calculated date when the reagent expires based on the opened date plus in-use stability period. Whichever is earlier between this and the manufacturer expiration date applies.',
    `in_use_stability_days` STRING COMMENT 'The number of days the reagent remains stable and usable after opening, as specified by the manufacturer.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this reagent lot record was last modified in the system.',
    `light_sensitivity_flag` BOOLEAN COMMENT 'Indicates whether the reagent is light-sensitive and requires protection from light exposure during storage and handling.',
    `lot_number` STRING COMMENT 'The manufacturer-assigned lot or batch number for traceability and quality control purposes. Critical for lot-to-result traceability in quality investigations.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the reagent lot indicating its availability and usability for testing.. Valid values are `unopened|in_use|depleted|expired|quarantined|rejected`',
    `manufacturer` STRING COMMENT 'Manufacturer of the reagent.',
    `msds_available` BOOLEAN COMMENT 'Indicates whether a material safety data sheet is available.',
    `notes` STRING COMMENT 'Free-text notes or comments about the reagent lot, including special handling instructions, quality issues, or other relevant information.',
    `open_date` DATE COMMENT 'Date the lot was opened/placed in service.',
    `open_expiration_date` DECIMAL(18,2) COMMENT 'Expiration date after opening.',
    `opened_date` DATE COMMENT 'The date the reagent container was first opened or unsealed. Used to track stability and in-use expiration periods.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with the procurement of this reagent lot.',
    `qc_validation_date` DATE COMMENT 'The date when quality control validation testing was completed for this reagent lot.',
    `qc_validation_result` STRING COMMENT 'Result of QC validation.',
    `qc_validation_status` STRING COMMENT 'The quality control validation status indicating whether the reagent lot has passed required QC testing before being released for patient testing.. Valid values are `passed|failed|pending|not_required`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The current quantity of reagent remaining in this lot, expressed in the unit of measure specified. Updated as reagent is consumed.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The quantity of reagent received in this lot, expressed in the unit of measure specified.',
    `quantity_remaining` DECIMAL(18,2) COMMENT 'Current quantity remaining.',
    `quarantine_date` DATE COMMENT 'The date when the reagent lot was placed in quarantine status.',
    `quarantine_reason` STRING COMMENT 'The reason why the reagent lot was placed in quarantine status, if applicable (e.g., failed QC, recall, investigation).',
    `reagent_name` STRING COMMENT 'Name of the reagent.',
    `reagent_type` STRING COMMENT 'Type of reagent (calibrator, control, reagent, diluent).',
    `recall_action_taken` STRING COMMENT 'Action taken in response to recall.',
    `recall_date` DATE COMMENT 'Date of recall notification.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this lot has been recalled.',
    `recall_notice_number` STRING COMMENT 'Recall notice number if recalled.',
    `receipt_date` DATE COMMENT 'The date the reagent lot was received by the laboratory facility.',
    `received_date` DATE COMMENT 'Date the lot was received.',
    `reconstitution_date` DATE COMMENT 'The date when the reagent was reconstituted or prepared for use, if applicable.',
    `reconstitution_required_flag` BOOLEAN COMMENT 'Indicates whether the reagent requires reconstitution or preparation before use.',
    `reorder_threshold` DECIMAL(18,2) COMMENT 'The minimum quantity level that triggers a reorder notification to supply chain for inventory replenishment.',
    `safety_data_sheet_url` STRING COMMENT 'The URL or file path to the Safety Data Sheet (SDS) document for this reagent, required for hazardous material compliance.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Required storage temperature in Celsius.',
    `storage_temperature_requirement` STRING COMMENT 'The required storage temperature or temperature range for the reagent as specified by the manufacturer (e.g., 2-8°C, -20°C, room temperature).',
    `test_method_code` STRING COMMENT 'The code or identifier for the analytical test method or procedure that uses this reagent lot.',
    `test_method_name` STRING COMMENT 'The descriptive name of the analytical test method or procedure that uses this reagent lot.',
    `total_lot_cost` DECIMAL(18,2) COMMENT 'The total cost for the entire reagent lot received, calculated as quantity received multiplied by cost per unit.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for reagent quantity (e.g., milliliters, grams, number of tests, vials). [ENUM-REF-CANDIDATE: mL|L|g|kg|tests|vials|bottles|units — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    CONSTRAINT pk_reagent_lot PRIMARY KEY(`reagent_lot_id`)
) COMMENT 'Laboratory reagent lots including expiration dates, storage conditions, and recall tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` (
    `test_coverage_policy_id` BIGINT COMMENT 'Unique identifier for this test-policy coverage determination record. Primary key.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to the payer coverage policy that governs coverage for this test',
    `health_plan_id` BIGINT COMMENT 'FK to the specific health plan.',
    `payer_id` BIGINT COMMENT 'FK to the payer with this coverage policy.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to the laboratory test catalog entry that is subject to this coverage policy',
    `advance_beneficiary_notice_required` BOOLEAN COMMENT 'Indicates whether an ABN is required.',
    `age_restrictions` STRING COMMENT 'Age-based limitations or requirements for coverage of this specific test under this policy (e.g., covered only for patients over 50, pediatric patients only). Test-specific age criteria.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed copayment amount required for this test under this policy. Test-specific copay that may differ from general policy copay structure.',
    `coverage_criteria` STRING COMMENT 'Criteria that must be met for coverage.',
    `coverage_determination` STRING COMMENT 'Final determination of whether this specific test is covered, not covered, conditionally covered, or considered investigational/experimental under this policy. Test-specific coverage status.',
    `coverage_notes` STRING COMMENT 'Additional notes or special instructions specific to the coverage of this test under this policy. May include clinical documentation requirements, billing notes, or special authorization procedures.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the test cost covered by the policy after deductible is met. May vary by test within the same policy (e.g., preventive tests at 100%, diagnostic tests at 80%).',
    `coverage_status` STRING COMMENT 'Coverage status (covered, non-covered, conditional).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was created.',
    `diagnosis_code_requirements` STRING COMMENT 'Specific ICD-10 diagnosis codes that must be present on the order for this test to be covered under this policy. Test-specific diagnosis requirements for medical necessity.',
    `effective_date` DATE COMMENT 'Date on which this specific test coverage determination becomes active under this policy. May differ from the policys overall effective date if tests are added to an existing policy.',
    `excluded_diagnosis_codes` STRING COMMENT 'ICD-10 diagnosis codes that exclude coverage.',
    `frequency_limit` STRING COMMENT 'Frequency limitation for coverage (e.g., once per year).',
    `frequency_limitations` STRING COMMENT 'Limitations on how often this specific test can be performed and reimbursed under this policy (e.g., once per year, once per 90 days, maximum 2 per calendar year). Test-specific frequency rules.',
    `frequency_period` STRING COMMENT 'Period for frequency limitation (annual, lifetime, per episode).',
    `last_review_date` DATE COMMENT 'Date of most recent policy review.',
    `last_updated_date` DATE COMMENT 'Date when this test-policy coverage determination was last modified or reviewed.',
    `medical_necessity_criteria` STRING COMMENT 'Specific clinical criteria that must be met for this test to be considered medically necessary under this policy. May include required diagnoses, clinical indications, or patient conditions specific to this test-policy combination.',
    `medical_necessity_documentation_required` BOOLEAN COMMENT 'Indicates whether medical necessity documentation is required.',
    `notes` STRING COMMENT 'Additional notes about the coverage policy.',
    `place_of_service_restrictions` STRING COMMENT 'Restrictions on where this specific test can be performed to be eligible for coverage under this policy (e.g., must be performed at in-network lab, hospital outpatient only). Test-specific location requirements.',
    `policy_name` STRING COMMENT 'Name of the coverage policy.',
    `policy_number` STRING COMMENT 'Policy number (LCD/NCD number).',
    `policy_type` STRING COMMENT 'Type of policy (LCD, NCD, payer-specific, state Medicaid).',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for this specific test under this specific policy. Overrides or specifies the policy-level authorization requirement for this test.',
    `required_diagnosis_codes` STRING COMMENT 'ICD-10 diagnosis codes required for coverage.',
    `source_url` STRING COMMENT 'URL to the source policy document.',
    `termination_date` DATE COMMENT 'Date on which coverage for this specific test under this policy ends. Nullable for ongoing coverage. Used when a test is removed from a policys covered services list.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    CONSTRAINT pk_test_coverage_policy PRIMARY KEY(`test_coverage_policy_id`)
) COMMENT 'Payer coverage policies for laboratory tests including LCD/NCD requirements and prior authorization rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` (
    `study_test_requirement_id` BIGINT COMMENT 'Unique identifier for this study test requirement record. Primary key.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study that requires this laboratory test',
    `study_arm_id` BIGINT COMMENT 'FK to the study arm if requirement is arm-specific.',
    `study_visit_id` BIGINT COMMENT 'FK to the study visit at which this test is required.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to the laboratory test catalog entry required by this research protocol',
    `central_lab_kit_required` BOOLEAN COMMENT 'Indicates whether a central lab kit is required.',
    `central_lab_name` STRING COMMENT 'Name of the central laboratory.',
    `central_lab_routing` BOOLEAN COMMENT 'Indicates whether specimens must be routed to a central laboratory.',
    `chain_of_custody_required` BOOLEAN COMMENT 'Indicates whether chain of custody documentation is required.',
    `collection_instructions` STRING COMMENT 'Protocol-specific instructions for collecting this test in the context of this study (e.g., fasting requirements, timing relative to drug administration, special handling). Supplements the general test catalog instructions with study-specific requirements.',
    `collection_timepoint` STRING COMMENT 'The protocol-defined timepoint or visit at which this test must be collected (e.g., screening, baseline, day_1, week_4, month_6, end_of_treatment). Maps to the protocol visit schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was created.',
    `deviation_allowed` BOOLEAN COMMENT 'Indicates whether protocol deviations are allowed for this test.',
    `effective_date` DATE COMMENT 'The date on which this test requirement became effective for the study. Supports protocol version tracking and amendment history.',
    `end_date` DATE COMMENT 'The date on which this test requirement was discontinued or superseded by a protocol amendment. Null if currently active.',
    `expected_frequency` STRING COMMENT 'The expected frequency with which this test should be performed according to the protocol (e.g., once, daily, weekly, monthly, per_cycle). Supports visit planning and resource forecasting.',
    `number_of_aliquots_required` STRING COMMENT 'Number of aliquots required.',
    `protocol_amendment_number` STRING COMMENT 'The protocol amendment number that introduced or modified this test requirement. Links to the research_study protocol amendment tracking.',
    `protocol_required_flag` BOOLEAN COMMENT 'Indicates whether this test is mandated by the research protocol (true) or optional/conditional (false). Used for protocol compliance monitoring.',
    `protocol_section_reference` STRING COMMENT 'Reference to the protocol section defining this requirement.',
    `requirement_status` STRING COMMENT 'Current status of this test requirement in the protocol. Allows for protocol amendments that add, remove, or modify test requirements without deleting historical records.',
    `requirement_type` STRING COMMENT 'Type of requirement (mandatory, optional, conditional).',
    `result_reporting_timeline_days` STRING COMMENT 'Required result reporting timeline in days.',
    `special_handling_instructions` STRING COMMENT 'Special handling instructions for study specimens.',
    `specimen_type_required` STRING COMMENT 'Required specimen type for this study test.',
    `specimen_volume_required_ml` DECIMAL(18,2) COMMENT 'Required specimen volume in milliliters.',
    `sponsor_covered_flag` BOOLEAN COMMENT 'Indicates whether the study sponsor covers the cost of this test (true) or if it should be billed to patient insurance (false). Used for billing and budget management.',
    `sponsor_required_flag` BOOLEAN COMMENT 'Indicates whether this test is required by the study sponsor.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates whether this test is considered standard-of-care (true) or research-only (false). Critical for coverage analysis and billing determination.',
    `storage_requirements` STRING COMMENT 'Storage requirements for study specimens.',
    `termination_date` DATE COMMENT 'Date this requirement was terminated.',
    `test_timing` STRING COMMENT 'Timing of the test relative to the visit (pre-dose, post-dose, fasting, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    `visit_schedule` STRING COMMENT 'The visit schedule or visit window during which this test should be performed, including acceptable timing windows (e.g., Week 4 ±3 days, Monthly ±7 days). Used for visit planning and scheduling.',
    CONSTRAINT pk_study_test_requirement PRIMARY KEY(`study_test_requirement_id`)
) COMMENT 'Research study-specific laboratory test requirements and protocols.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` (
    `lab_fee_schedule_line_id` BIGINT COMMENT 'Unique identifier for this lab fee schedule line item. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'FK to the CPT code.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to the payer fee schedule under which this rate is defined',
    `health_plan_id` BIGINT COMMENT 'FK to the specific health plan.',
    `payer_id` BIGINT COMMENT 'FK to the payer for this fee schedule.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to the laboratory test catalog entry for which this contracted rate applies',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Payer allowed amount for this test.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether this payer requires prior authorization for this specific test under this fee schedule. Authorization requirements vary by payer-test combination.',
    `bundling_indicator` STRING COMMENT 'Indicates how this test is paid when billed with other services: separately_payable (paid in addition to other services), bundled (payment included in another service), component (part of a panel, not separately payable), not_covered (not reimbursed by this payer).',
    `charge_amount` DECIMAL(18,2) COMMENT 'Facility charge amount (gross charge).',
    `contracted_rate` DECIMAL(18,2) COMMENT 'Contracted rate negotiated with the payer.',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated reimbursement amount for this specific test under this fee schedule. This is the rate the payer has agreed to pay for the test, expressed in dollars.',
    `coverage_limitation` STRING COMMENT 'Description of any payer-specific coverage limitations or frequency restrictions for this test (e.g., once per year, requires specific diagnosis codes, age restrictions). Null if no special limitations apply.',
    `cpt_code` STRING COMMENT 'CPT code for the test.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was created.',
    `effective_date` DATE COMMENT 'The date on which this specific test rate becomes active under this fee schedule. May differ from the parent fee schedule effective date if tests are added mid-contract.',
    `geographic_region` STRING COMMENT 'Geographic region for which this rate applies.',
    `lab_fee_schedule_line_status` STRING COMMENT 'Current lifecycle status of this fee schedule line item: active (in use for billing), inactive (no longer valid), pending (negotiated but not yet effective), superseded (replaced by a newer rate).',
    `medical_necessity_codes` STRING COMMENT 'ICD-10 diagnosis codes that this payer considers medically necessary to support reimbursement for this test. Comma-separated list. Null if payer does not restrict by diagnosis.',
    `medicare_fee_schedule_amount` DECIMAL(18,2) COMMENT 'Medicare fee schedule amount for reference.',
    `modifier_1` STRING COMMENT 'First CPT modifier.',
    `modifier_2` STRING COMMENT 'Second CPT modifier.',
    `modifier_codes` STRING COMMENT 'CPT/HCPCS modifier codes that must be appended when billing this test to this payer (e.g., 91 for repeat clinical diagnostic lab test, QW for CLIA-waived test). Comma-separated if multiple modifiers apply.',
    `notes` STRING COMMENT 'Additional notes about this fee schedule line.',
    `percent_of_medicare` DECIMAL(18,2) COMMENT 'Contracted rate as a percentage of Medicare.',
    `place_of_service_code` STRING COMMENT 'CMS place of service code indicating where this test must be performed to qualify for this contracted rate (e.g., 11 for office, 21 for inpatient hospital, 22 for outpatient hospital, 81 for independent laboratory).',
    `rate_type` STRING COMMENT 'Type of rate (fee-for-service, capitated, bundled).',
    `termination_date` DATE COMMENT 'The date on which this specific test rate expires or is terminated under this fee schedule. Null indicates the rate remains active as long as the parent fee schedule is active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    CONSTRAINT pk_lab_fee_schedule_line PRIMARY KEY(`lab_fee_schedule_line_id`)
) COMMENT 'Laboratory fee schedule lines defining reimbursement rates by payer and test.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` (
    `instrument_policy_compliance_id` BIGINT COMMENT 'Unique identifier for this instrument-policy compliance record. Primary key.',
    `accreditation_survey_id` BIGINT COMMENT 'FK to the accreditation survey that assessed this compliance.',
    `care_site_id` BIGINT COMMENT 'Laboratory facility where the instrument is located, supporting multi-site compliance tracking.',
    `clia_certificate_id` BIGINT COMMENT 'FK to the CLIA certificate under which this instrument operates.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to the organizational policy that applies to the instrument',
    `compliance_program_id` BIGINT COMMENT 'FK to the compliance program defining the policy requirements.',
    `corrective_action_plan_id` BIGINT COMMENT 'Link to corrective action plan if one was created',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer or quality assurance staff member who conducted the most recent compliance assessment for this instrument-policy pairing.',
    `instrument_corrective_action_verified_by_employee_id` BIGINT COMMENT 'Employee who verified corrective action completion',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the laboratory instrument being governed by the policy',
    `instrument_policy_owner_employee_id` BIGINT COMMENT 'Re-derived attribute added during thin-product expansion based on business context for workforce.instrument_policy_compliance.',
    `instrument_waiver_granted_by_employee_id` BIGINT COMMENT 'Employee who granted the compliance waiver',
    `accreditation_impact_flag` BOOLEAN COMMENT 'Whether non-compliance impacts lab accreditation status',
    `assessed_by` STRING COMMENT 'Name or role of the person who performed the assessment.',
    `assessment_date` DATE COMMENT 'Date of the compliance assessment.',
    `assessment_method` STRING COMMENT 'Method used for assessment (on-site inspection, document review, remote audit, automated monitoring)',
    `assessment_outcome` STRING COMMENT 'Result of the compliance assessment (e.g., pass, fail, conditional pass, deferred).',
    `assessment_scope` STRING COMMENT 'Scope of assessment (full instrument validation, specific test method, quality control procedures, maintenance records)',
    `assessment_type` STRING COMMENT 'Type of compliance assessment performed (e.g., routine inspection, corrective re-assessment, annual review, triggered audit).',
    `attestation_date` DATE COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: attestation_date',
    `attestation_status` STRING COMMENT 'Status of staff attestation that they have read and will comply with this policy for this instrument. Attested indicates current valid attestation; not_attested indicates no attestation on record; pending indicates attestation requested but not completed; expired indicates attestation has passed its validity period.',
    `audit_trail_reference` STRING COMMENT 'Reference to detailed audit trail documentation',
    `certifying_authority` STRING COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: certifying_authority',
    `compliance_score` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for laboratory.instrument_policy_compliance.',
    `compliance_status` STRING COMMENT 'Current compliance status of this instrument with respect to this policy. Compliant indicates full adherence; non_compliant indicates violations or gaps; pending_review indicates assessment in progress; not_applicable indicates policy does not apply to this instrument; waived indicates formal exception granted.',
    `corrective_action_completed_date` DATE COMMENT 'Date corrective action was completed.',
    `corrective_action_completion_date` DATE COMMENT 'Date corrective action was completed',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action plan.',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective action completion.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether a corrective action plan is required based on the assessment findings.',
    `corrective_action_status` STRING COMMENT 'Status of corrective action (open, in-progress, completed, verified).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was created.',
    `critical_finding_count` STRING COMMENT 'Number of critical or high-severity findings',
    `critical_findings_count` STRING COMMENT 'Number of critical or immediate jeopardy findings; triggers escalation workflows.',
    `deviation_count` STRING COMMENT 'Number of policy deviations recorded during assessment period',
    `effective_date` DATE COMMENT 'Date when this policy became applicable to this specific instrument. May differ from the policys general effective date if the instrument was acquired later or the policy scope changed.',
    `escalation_level` STRING COMMENT 'Escalation level (none, supervisor, director, executive, regulatory)',
    `evidence_document_reference` STRING COMMENT 'Reference to supporting evidence documentation.',
    `evidence_document_url` STRING COMMENT 'URL or path to supporting documentation (photos, logs, calibration records) for the compliance assessment.',
    `finding_count` STRING COMMENT 'Number of compliance findings or deficiencies identified',
    `finding_description` STRING COMMENT 'Description of any compliance finding or deficiency.',
    `finding_severity` STRING COMMENT 'Severity of non-compliance finding (critical, major, minor, observation)',
    `finding_summary` STRING COMMENT 'Summary of key findings from the compliance assessment',
    `findings_count` STRING COMMENT 'Number of compliance findings identified during the assessment; used for trending and risk scoring.',
    `instrument_downtime_end` TIMESTAMP COMMENT 'Timestamp when instrument was returned to service',
    `instrument_downtime_hours` DECIMAL(18,2) COMMENT 'Total instrument downtime hours attributable to compliance issues during the assessment period.',
    `instrument_downtime_required_flag` BOOLEAN COMMENT 'Flag indicating whether instrument must be taken offline due to compliance issue',
    `instrument_downtime_start` TIMESTAMP COMMENT 'Timestamp when instrument was taken offline',
    `instrument_out_of_service_flag` BOOLEAN COMMENT 'Indicates whether the instrument was taken out of service due to compliance failure.',
    `last_assessment_date` DATE COMMENT 'Date when compliance with this policy was most recently assessed for this instrument. Used to track assessment currency and schedule next reviews.',
    `last_calibration_date` DATE COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: last_calibration_date',
    `last_inspection_outcome` STRING COMMENT 'Re-derived attribute added during thin-product expansion based on business context for laboratory.instrument_policy_compliance.',
    `maintenance_overdue_flag` BOOLEAN COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: maintenance_overdue_flag',
    `next_assessment_date` DATE COMMENT 'Scheduled date for next compliance assessment.',
    `next_calibration_due_date` DATE COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: next_calibration_due_date',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this instrument against this policy. Calculated based on policy review cycle and last assessment date.',
    `non_compliance_notes` STRING COMMENT 'Detailed notes documenting any non-compliance findings, corrective actions required, or remediation plans for this instrument-policy combination. Nullable when compliance_status is compliant.',
    `notes` STRING COMMENT 'Additional notes about this compliance record.',
    `notification_date` DATE COMMENT 'Date notification was sent',
    `notification_sent_flag` BOOLEAN COMMENT 'Whether notification was sent to lab director or compliance officer',
    `out_of_service_start_date` DATE COMMENT 'Date when the instrument was removed from service due to non-compliance.',
    `patient_notification_count` STRING COMMENT 'Number of patients notified due to this compliance issue',
    `patient_notification_required_flag` BOOLEAN COMMENT 'Flag indicating whether patients with results from this instrument must be notified',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Whether non-compliance poses patient safety risk',
    `policy_category` STRING COMMENT 'Category of the compliance policy (e.g., calibration, maintenance, quality control, safety, environmental).',
    `policy_name` STRING COMMENT 'Name of the regulatory or accreditation policy.',
    `policy_reference` STRING COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: policy_reference',
    `policy_requirement` STRING COMMENT 'Specific requirement being assessed.',
    `policy_requirement_description` STRING COMMENT 'Description of specific policy requirement being assessed',
    `policy_source` STRING COMMENT 'Source of the policy (CLIA, CAP, Joint Commission, ISO 15189).',
    `policy_version` STRING COMMENT 'Version of the compliance policy applied during this assessment; supports policy change impact tracking.',
    `proficiency_testing_status` STRING COMMENT 'Status of proficiency testing for this instrument (e.g., Satisfactory, Unsatisfactory, Not Enrolled).',
    `qc_failure_count` STRING COMMENT 'Number of QC failures recorded for this instrument during the assessment period; supports CLIA QC reporting.',
    `qc_pass_rate` DECIMAL(18,2) COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: qc_pass_rate',
    `regulatory_body` STRING COMMENT 'Regulatory or accrediting body whose requirements are being assessed (e.g., CLIA, CAP, Joint Commission, FDA).',
    `regulatory_citation` STRING COMMENT 'Specific regulatory reference (e.g., 42 CFR 493.1254) that the policy requirement derives from.',
    `regulatory_report_date` DATE COMMENT 'Date issue was reported to regulatory agency',
    `regulatory_report_reference_number` STRING COMMENT 'Reference number from regulatory agency for this report',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Flag indicating whether this compliance issue must be reported to a regulatory agency',
    `remediation_due_date` DATE COMMENT 'Re-derived business attribute for laboratory.instrument_policy_compliance: remediation_due_date',
    `result_amendment_count` STRING COMMENT 'Number of results amended due to this compliance issue',
    `result_amendment_required_flag` BOOLEAN COMMENT 'Flag indicating whether previously reported results must be amended',
    `return_to_service_date` DATE COMMENT 'Date when the instrument was cleared to return to clinical use after remediation.',
    `risk_level` STRING COMMENT 'Risk level of non-compliance (critical, major, minor).',
    `test_suspension_list` STRING COMMENT 'Comma-separated list of test codes suspended',
    `test_suspension_required_flag` BOOLEAN COMMENT 'Flag indicating whether specific tests must be suspended due to compliance issue',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    `verification_date` DATE COMMENT 'Date compliance was verified after corrective action',
    `verification_method` STRING COMMENT 'Method used to verify corrective action (re-audit, documentation review, testing)',
    `vibe_enriched_flag` BOOLEAN COMMENT 'Re-derived attribute added during thin-product expansion based on business context for laboratory.instrument_policy_compliance.',
    `waiver_authority` STRING COMMENT 'Name or identifier of the authority that granted the waiver (e.g., CLIA regional office, CAP inspector).',
    `waiver_expiration_date` DATE COMMENT 'Date when the compliance waiver expires and full compliance is required. Nullable unless compliance_status is waived.',
    `waiver_granted_date` DATE COMMENT 'Date waiver was granted',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a regulatory waiver has been granted for a specific non-compliant finding.',
    `waiver_justification` STRING COMMENT 'Business or technical justification for granting a compliance waiver or exception for this instrument-policy pairing. Nullable unless compliance_status is waived.',
    `policy_id` BIGINT COMMENT 'governing policy reference',
    `evaluation_date` DATE COMMENT 'date compliance was evaluated',
    `evaluator_id` BIGINT COMMENT 'person who performed the evaluation',
    `corrective_action` STRING COMMENT 'required corrective action',
    CONSTRAINT pk_instrument_policy_compliance PRIMARY KEY(`instrument_policy_compliance_id`)
) COMMENT 'Instrument compliance with regulatory policies including calibration and maintenance schedules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`organism` (
    `organism_id` BIGINT COMMENT 'Primary key for organism',
    `parent_organism_id` BIGINT COMMENT 'Self-referencing FK on organism (parent_organism_id)',
    `snomed_concept_id` BIGINT COMMENT 'FK to the SNOMED concept for this organism.',
    `aerobic_anaerobic` STRING COMMENT 'Oxygen requirement (aerobic, anaerobic, facultative, microaerophilic).',
    `aerobic_requirement` STRING COMMENT 'Oxygen requirement for organism growth, critical for culture media selection and incubation conditions in microbiology laboratories.',
    `antibiotic_resistance_profile` STRING COMMENT 'Known or typical antibiotic resistance patterns for this organism, including multidrug-resistant (MDR), extensively drug-resistant (XDR), or pan-drug-resistant (PDR) classifications.',
    `biosafety_level` STRING COMMENT 'Required biosafety containment level for handling this organism in laboratory settings, ranging from BSL-1 (minimal risk) to BSL-4 (maximum containment).',
    `bioterrorism_agent_category` STRING COMMENT 'CDC bioterrorism agent category if applicable (A, B, C).',
    `class_name` STRING COMMENT 'Taxonomic class.',
    `clinical_significance` STRING COMMENT 'Description of the clinical importance and disease associations of this organism, including typical presentations and severity of infections.',
    `organism_code` STRING COMMENT 'Standardized code representing the organism, typically aligned with SNOMED CT or laboratory information system coding standards.',
    `common_infection_sites` STRING COMMENT 'Typical anatomical sites or body systems where this organism causes infection (e.g., respiratory, urinary tract, bloodstream, skin), used for clinical correlation.',
    `common_name` STRING COMMENT 'Common name of the organism.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this organism reference record was first created in the system.',
    `culture_media_requirements` STRING COMMENT 'Specific culture media and growth conditions required for laboratory isolation and identification of this organism (e.g., blood agar, chocolate agar, selective media).',
    `effective_date` DATE COMMENT 'Date when this organism reference record became effective and available for use in laboratory information systems.',
    `environmental_reservoir` STRING COMMENT 'Natural environmental sources or reservoirs where this organism is commonly found (e.g., soil, water, animals, plants, healthcare environment).',
    `expiration_date` DATE COMMENT 'Date when this organism reference record is no longer valid for use, typically due to taxonomy reclassification or nomenclature updates.',
    `family` STRING COMMENT 'Taxonomic family.',
    `genus` STRING COMMENT 'Taxonomic genus.',
    `gram_stain_reaction` STRING COMMENT 'Gram stain reaction (positive, negative, variable, not applicable).',
    `gram_stain_result` STRING COMMENT 'Gram staining classification of bacterial organisms, critical for initial identification and antibiotic selection. Not applicable for non-bacterial organisms.',
    `identification_methods` STRING COMMENT 'Laboratory methods and techniques used for definitive identification of this organism (e.g., biochemical tests, mass spectrometry, molecular methods, sequencing).',
    `incubation_duration_hours` STRING COMMENT 'Typical incubation time in hours required for visible growth or detection of this organism in laboratory cultures.',
    `incubation_temperature_celsius` DECIMAL(18,2) COMMENT 'Optimal temperature in degrees Celsius for culturing and growing this organism in laboratory settings.',
    `infection_control_precautions` STRING COMMENT 'Required infection control precautions (contact, droplet, airborne).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this organism is active in the reference table.',
    `isolation_precautions` STRING COMMENT 'Recommended infection control precautions for patients infected with this organism (e.g., standard, contact, droplet, airborne, protective environment).',
    `kingdom` STRING COMMENT 'Taxonomic kingdom.',
    `loinc_code` STRING COMMENT 'LOINC code associated with laboratory tests for identifying or detecting this organism, supporting standardized test result reporting.',
    `mdro_classification` STRING COMMENT 'Multi-drug resistant organism classification if applicable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this organism reference record was last modified or updated.',
    `morphology` STRING COMMENT 'Microscopic morphological characteristics of the organism (e.g., cocci, bacilli, spiral, yeast, hyphae) used in laboratory identification.',
    `organism_name` STRING COMMENT 'Common or scientific name of the organism as used in clinical and laboratory contexts.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special considerations related to this organism for laboratory staff reference.',
    `order_name` STRING COMMENT 'Taxonomic order.',
    `organism_type` STRING COMMENT 'High-level classification of the organism into major biological categories relevant to laboratory diagnostics and infection control.',
    `pathogenicity_level` STRING COMMENT 'Classification of the organisms disease-causing potential, used for infection control, biosafety protocols, and clinical interpretation.',
    `phylum` STRING COMMENT 'Taxonomic phylum.',
    `public_health_reportable` BOOLEAN COMMENT 'Indicates whether this organism is reportable to public health.',
    `reportable_condition_code` STRING COMMENT 'Public health reportable condition code.',
    `reportable_status` STRING COMMENT 'Indicates whether detection of this organism requires mandatory reporting to public health authorities at state, national, or international levels.',
    `scientific_name` STRING COMMENT 'Full binomial or trinomial scientific name of the organism following taxonomic nomenclature standards (genus, species, subspecies).',
    `snomed_code` STRING COMMENT 'SNOMED CT code for the organism.',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept identifier for the organism, enabling standardized clinical terminology and interoperability across healthcare systems.',
    `species` STRING COMMENT 'Taxonomic species.',
    `specimen_types` STRING COMMENT 'Types of clinical specimens from which this organism is typically isolated or detected (e.g., blood, urine, sputum, wound, stool, cerebrospinal fluid).',
    `organism_status` STRING COMMENT 'Current lifecycle status of this organism reference record, indicating whether it is actively used in laboratory systems or has been deprecated due to taxonomy updates.',
    `subspecies` STRING COMMENT 'Taxonomic subspecies or strain.',
    `taxonomy_class` STRING COMMENT 'Class-level taxonomic classification of the organism within the biological hierarchy.',
    `taxonomy_family` STRING COMMENT 'Family-level taxonomic classification of the organism, grouping related genera together.',
    `taxonomy_genus` STRING COMMENT 'Genus-level taxonomic classification, the first part of the binomial scientific name (e.g., Staphylococcus, Escherichia).',
    `taxonomy_kingdom` STRING COMMENT 'Highest taxonomic rank classification of the organism (e.g., Bacteria, Archaea, Eukarya, Viruses) per biological taxonomy standards.',
    `taxonomy_order` STRING COMMENT 'Order-level taxonomic classification of the organism, further refining the biological classification hierarchy.',
    `taxonomy_phylum` STRING COMMENT 'Phylum-level taxonomic classification of the organism, providing intermediate hierarchical context for biological classification.',
    `taxonomy_species` STRING COMMENT 'Species-level taxonomic classification, the second part of the binomial scientific name (e.g., aureus, coli).',
    `transmission_mode` STRING COMMENT 'Primary modes of transmission for this organism (e.g., airborne, droplet, contact, vector-borne, foodborne, waterborne), critical for infection prevention and control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    `zoonotic_potential` BOOLEAN COMMENT 'Indicates whether this organism can be transmitted between animals and humans, important for occupational health and epidemiological tracking.',
    CONSTRAINT pk_organism PRIMARY KEY(`organism_id`)
) COMMENT 'Master list of organisms identified in microbiology cultures with SNOMED and taxonomy codes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_parent_specimen_id` FOREIGN KEY (`parent_specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`organism`(`organism_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`organism`(`organism_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_blood_bank_unit_id` FOREIGN KEY (`blood_bank_unit_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`(`blood_bank_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_previous_result_point_of_care_test_id` FOREIGN KEY (`previous_result_point_of_care_test_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`point_of_care_test`(`point_of_care_test_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_qc_run_id` FOREIGN KEY (`qc_run_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`qc_run`(`qc_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_clia_certificate_id` FOREIGN KEY (`clia_certificate_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`clia_certificate`(`clia_certificate_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_clia_certificate_id` FOREIGN KEY (`clia_certificate_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`clia_certificate`(`clia_certificate_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_reagent_lot_id` FOREIGN KEY (`reagent_lot_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reagent_lot`(`reagent_lot_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_reagent_instrument_id` FOREIGN KEY (`reagent_instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_clia_certificate_id` FOREIGN KEY (`clia_certificate_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`clia_certificate`(`clia_certificate_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_parent_organism_id` FOREIGN KEY (`parent_organism_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`organism`(`organism_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('pii_domain' = 'laboratory');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_subdomain' = 'test_ordering');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Lab Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `lab_order_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `measure_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Appointment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Cancelling Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `authorization_required` SET TAGS ('pii_business_glossary_term' = 'Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `billing_code` SET TAGS ('pii_business_glossary_term' = 'Billing Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_date` SET TAGS ('pii_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_timestamp` SET TAGS ('pii_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `expected_turnaround_time_hours` SET TAGS ('pii_business_glossary_term' = 'Expected TAT');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('pii_business_glossary_term' = 'Fasting Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `is_send_out` SET TAGS ('pii_business_glossary_term' = 'Send Out');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_date` SET TAGS ('pii_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_business_glossary_term' = 'Order Set Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_timestamp` SET TAGS ('pii_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `performing_lab_location` SET TAGS ('pii_business_glossary_term' = 'Performing Lab Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `point_of_care_test` SET TAGS ('pii_business_glossary_term' = 'Point of Care Test');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `record_number` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_accession_number` SET TAGS ('pii_business_glossary_term' = 'Reference Lab Accession');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_business_glossary_term' = 'Reference Lab Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('pii_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Result Received');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `shipping_carrier` SET TAGS ('pii_business_glossary_term' = 'Shipping Carrier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `shipping_tracking_number` SET TAGS ('pii_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `source_system_order_number` SET TAGS ('pii_business_glossary_term' = 'Source Order Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('pii_business_glossary_term' = 'Specimen Shipped');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('pii_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('pii_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `standing_order` SET TAGS ('pii_business_glossary_term' = 'Standing Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_subdomain' = 'test_ordering');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Collector Employee');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `lab_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `message_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_business_glossary_term' = 'Parent Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Appointment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `training_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_datetime` SET TAGS ('pii_business_glossary_term' = 'Accession Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_status` SET TAGS ('pii_business_glossary_term' = 'Accession Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `biohazard_level` SET TAGS ('pii_business_glossary_term' = 'Biohazard Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `chain_of_custody_status` SET TAGS ('pii_business_glossary_term' = 'Chain of Custody');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_datetime` SET TAGS ('pii_business_glossary_term' = 'Collection Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Collection Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collector_role` SET TAGS ('pii_business_glossary_term' = 'Collector Role');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('pii_business_glossary_term' = 'Condition at Receipt');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `container_type` SET TAGS ('pii_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `disposal_datetime` SET TAGS ('pii_business_glossary_term' = 'Disposal Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('pii_business_glossary_term' = 'Fasting Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `number_of_aliquots` SET TAGS ('pii_business_glossary_term' = 'Number of Aliquots');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `receiving_lab_location` SET TAGS ('pii_business_glossary_term' = 'Receiving Lab');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `record_number` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Retention Expiration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_status` SET TAGS ('pii_business_glossary_term' = 'Retention Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `special_handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Handling');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('pii_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Transport Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Transport Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Updated Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `volume_collected_ml` SET TAGS ('pii_business_glossary_term' = 'Volume Collected');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_business_glossary_term' = 'Test Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Log');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Instrument');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `instrument_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'LOINC Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'PHI Access Log');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Performing Employee');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `measure_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reference_range_id` SET TAGS ('pii_business_glossary_term' = 'Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reference_range_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Result SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_amending_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Amending Employee');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_amending_user_employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_amending_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_amending_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_ordering_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_ordering_provider_clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `abnormal_flag` SET TAGS ('pii_business_glossary_term' = 'Abnormal Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `amendment_datetime` SET TAGS ('pii_business_glossary_term' = 'Amendment Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clia_number` SET TAGS ('pii_business_glossary_term' = 'CLIA Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_acknowledgment_datetime` SET TAGS ('pii_business_glossary_term' = 'Critical Acknowledgment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_alert_generated_datetime` SET TAGS ('pii_business_glossary_term' = 'Critical Alert Generated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_alert_generated_datetime` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_escalation_action` SET TAGS ('pii_business_glossary_term' = 'Escalation Action');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_datetime` SET TAGS ('pii_business_glossary_term' = 'Critical Notification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_resolution_note` SET TAGS ('pii_business_glossary_term' = 'Resolution Note');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `is_amended` SET TAGS ('pii_business_glossary_term' = 'Amended');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `is_critical_value` SET TAGS ('pii_business_glossary_term' = 'Critical Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `last_updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('pii_business_glossary_term' = 'Original Numeric Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('pii_business_glossary_term' = 'Original Text Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `performing_lab_facility` SET TAGS ('pii_business_glossary_term' = 'Performing Lab');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `performing_lab_section` SET TAGS ('pii_business_glossary_term' = 'Lab Section');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `record_number` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('pii_business_glossary_term' = 'Result Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_datetime` SET TAGS ('pii_business_glossary_term' = 'Result Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('pii_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_released_datetime` SET TAGS ('pii_business_glossary_term' = 'Result Released');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('pii_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_unit` SET TAGS ('pii_business_glossary_term' = 'Result Unit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('pii_business_glossary_term' = 'Coded Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('pii_business_glossary_term' = 'Numeric Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('pii_business_glossary_term' = 'Text Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('pii_business_glossary_term' = 'Specimen Received');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `reference_range_id` SET TAGS ('pii_business_glossary_term' = 'Reference Range Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `reference_range_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'LOINC Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `age_group` SET TAGS ('pii_business_glossary_term' = 'Age Group');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_priority` SET TAGS ('pii_business_glossary_term' = 'Alert Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_trigger_flag` SET TAGS ('pii_business_glossary_term' = 'Alert Trigger');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('pii_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `critical_high_threshold` SET TAGS ('pii_business_glossary_term' = 'Critical High Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `critical_low_threshold` SET TAGS ('pii_business_glossary_term' = 'Critical Low Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `instrument_platform` SET TAGS ('pii_business_glossary_term' = 'Instrument Platform');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `interpretation_code` SET TAGS ('pii_business_glossary_term' = 'Interpretation Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `lis_system_code` SET TAGS ('pii_business_glossary_term' = 'LIS System Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `lower_normal_limit` SET TAGS ('pii_business_glossary_term' = 'Lower Normal Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Director Override');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `override_justification` SET TAGS ('pii_business_glossary_term' = 'Override Justification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `population_basis` SET TAGS ('pii_business_glossary_term' = 'Population Basis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_business_glossary_term' = 'Pregnancy Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sample_size` SET TAGS ('pii_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('pii_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_citation` SET TAGS ('pii_business_glossary_term' = 'Source Citation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_type` SET TAGS ('pii_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `statistical_method` SET TAGS ('pii_business_glossary_term' = 'Statistical Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `upper_normal_limit` SET TAGS ('pii_business_glossary_term' = 'Upper Normal Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_business_glossary_term' = 'Pathology Report Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'CDA Document');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cda_document_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lab_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `mortality_review_id` SET TAGS ('pii_business_glossary_term' = 'Mortality Review');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `mortality_review_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_business_glossary_term' = 'PHI Access Log');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `phi_access_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Pathologist');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Quality Peer Review');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `addendum_history` SET TAGS ('pii_business_glossary_term' = 'Addendum History');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `amended_timestamp` SET TAGS ('pii_business_glossary_term' = 'Amended Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cancer_registry_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'Cancer Registry Reportable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `case_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clia_number` SET TAGS ('pii_business_glossary_term' = 'CLIA Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `comment` SET TAGS ('pii_business_glossary_term' = 'Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `comment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Notification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_business_glossary_term' = 'Final Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `gross_description` SET TAGS ('pii_business_glossary_term' = 'Gross Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `gross_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('pii_business_glossary_term' = 'Histologic Grade');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_type` SET TAGS ('pii_business_glossary_term' = 'Histologic Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('pii_business_glossary_term' = 'IHC Results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `is_amended` SET TAGS ('pii_business_glossary_term' = 'Amended');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_examined` SET TAGS ('pii_business_glossary_term' = 'Lymph Nodes Examined');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_examined` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_positive` SET TAGS ('pii_business_glossary_term' = 'Lymph Nodes Positive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_positive` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('pii_business_glossary_term' = 'Margin Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `microscopic_description` SET TAGS ('pii_business_glossary_term' = 'Microscopic Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `microscopic_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_business_glossary_term' = 'Molecular Testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `performing_laboratory` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `preliminary_report_timestamp` SET TAGS ('pii_business_glossary_term' = 'Preliminary Report');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `record_number` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_type` SET TAGS ('pii_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `sign_out_timestamp` SET TAGS ('pii_business_glossary_term' = 'Sign Out');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `special_stains_performed` SET TAGS ('pii_business_glossary_term' = 'Special Stains');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `synoptic_report_elements` SET TAGS ('pii_business_glossary_term' = 'Synoptic Elements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `synoptic_report_elements` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('pii_business_glossary_term' = 'TNM Stage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_board_reviewed_flag` SET TAGS ('pii_business_glossary_term' = 'Tumor Board Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_site` SET TAGS ('pii_business_glossary_term' = 'Tumor Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_site` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_size_cm` SET TAGS ('pii_business_glossary_term' = 'Tumor Size');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_size_cm` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('pii_business_glossary_term' = 'Microbiology Culture Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `improvement_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Improvement Initiative');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `improvement_initiative_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Instrument');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `instrument_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `lab_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `material_master_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `message_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `organism_id` SET TAGS ('pii_business_glossary_term' = 'Organism');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `organism_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Organism SNOMED Concept');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `osha_exposure_incident_id` SET TAGS ('pii_business_glossary_term' = 'OSHA Exposure Incident');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `osha_exposure_incident_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Performing Employee');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_business_glossary_term' = 'Substance Use Consent');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('pii_business_glossary_term' = 'Antibiotic Stewardship');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `collection_datetime` SET TAGS ('pii_business_glossary_term' = 'Collection Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count` SET TAGS ('pii_business_glossary_term' = 'Colony Count');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count_unit` SET TAGS ('pii_business_glossary_term' = 'Colony Count Unit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_notified_datetime` SET TAGS ('pii_business_glossary_term' = 'Critical Value Notified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('pii_business_glossary_term' = 'Culture Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_type` SET TAGS ('pii_business_glossary_term' = 'Culture Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('pii_business_glossary_term' = 'Gram Stain Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('pii_business_glossary_term' = 'Growth Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_associated_flag` SET TAGS ('pii_business_glossary_term' = 'HAI Associated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_event_type` SET TAGS ('pii_business_glossary_term' = 'HAI Event Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `incubation_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Incubation Start');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `infection_control_notified_flag` SET TAGS ('pii_business_glossary_term' = 'Infection Control Notified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `isolation_datetime` SET TAGS ('pii_business_glossary_term' = 'Isolation Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_flag` SET TAGS ('pii_business_glossary_term' = 'MDRO Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_type` SET TAGS ('pii_business_glossary_term' = 'MDRO Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `morphology` SET TAGS ('pii_business_glossary_term' = 'Morphology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `morphology` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_business_glossary_term' = 'Public Health Reportable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `quality_control_passed_flag` SET TAGS ('pii_business_glossary_term' = 'QC Passed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `received_datetime` SET TAGS ('pii_business_glossary_term' = 'Received Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('pii_business_glossary_term' = 'Result Comments');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_datetime` SET TAGS ('pii_business_glossary_term' = 'Result Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('pii_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('pii_business_glossary_term' = 'Specimen Source Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('pii_business_glossary_term' = 'Susceptibility Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_panel_performed` SET TAGS ('pii_business_glossary_term' = 'Susceptibility Panel Performed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `turnaround_time_hours` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_result_id` SET TAGS ('pii_business_glossary_term' = 'Susceptibility Result Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Verified By Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Instrument Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory (Lab) Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `lab_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `microbiology_culture_id` SET TAGS ('pii_business_glossary_term' = 'Culture Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `organism_id` SET TAGS ('pii_business_glossary_term' = 'Organism Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_code` SET TAGS ('pii_business_glossary_term' = 'Antibiotic Agent Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_business_glossary_term' = 'Antibiotic Agent Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_class` SET TAGS ('pii_business_glossary_term' = 'Antibiotic Class');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('pii_business_glossary_term' = 'Antibiotic Stewardship Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `clsi_breakpoint_version` SET TAGS ('pii_business_glossary_term' = 'Clinical and Laboratory Standards Institute (CLSI) Breakpoint Version');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `disk_diffusion_zone_diameter_mm` SET TAGS ('pii_business_glossary_term' = 'Disk Diffusion Zone Diameter (Millimeters)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `inducible_resistance_flag` SET TAGS ('pii_business_glossary_term' = 'Inducible Resistance Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `infection_control_alert_flag` SET TAGS ('pii_business_glossary_term' = 'Infection Control Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `loinc_code` SET TAGS ('pii_business_glossary_term' = 'Logical Observation Identifiers Names and Codes (LOINC) Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `loinc_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_operator` SET TAGS ('pii_business_glossary_term' = 'Minimum Inhibitory Concentration (MIC) Operator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_operator` SET TAGS ('pii_value_regex' = '=|<=|>=|<|>');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_unit` SET TAGS ('pii_business_glossary_term' = 'Minimum Inhibitory Concentration (MIC) Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_unit` SET TAGS ('pii_value_regex' = 'mcg/mL|mg/L|IU/mL');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_value` SET TAGS ('pii_business_glossary_term' = 'Minimum Inhibitory Concentration (MIC) Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_code` SET TAGS ('pii_business_glossary_term' = 'Antimicrobial Panel Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_business_glossary_term' = 'Antimicrobial Panel Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_code` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `quality_control_status` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `quality_control_status` SET TAGS ('pii_value_regex' = 'passed|failed|not applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_business_glossary_term' = 'Reportable to Public Health Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `resistance_gene` SET TAGS ('pii_business_glossary_term' = 'Resistance Gene');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `resistance_mechanism` SET TAGS ('pii_business_glossary_term' = 'Resistance Mechanism');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `resistant_breakpoint` SET TAGS ('pii_business_glossary_term' = 'Resistant Breakpoint Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_comment` SET TAGS ('pii_business_glossary_term' = 'Result Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_status` SET TAGS ('pii_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_status` SET TAGS ('pii_value_regex' = 'preliminary|final|corrected|cancelled|entered in error');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_timestamp` SET TAGS ('pii_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `snomed_code` SET TAGS ('pii_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `snomed_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_interpretation` SET TAGS ('pii_business_glossary_term' = 'Susceptibility Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_interpretation` SET TAGS ('pii_value_regex' = 'susceptible|intermediate|resistant|susceptible-dose dependent|not tested|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptible_breakpoint` SET TAGS ('pii_business_glossary_term' = 'Susceptible Breakpoint Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_business_glossary_term' = 'Synergy Test Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_value_regex' = 'positive|negative|not performed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_business_glossary_term' = 'Antimicrobial Susceptibility Testing (AST) Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('pii_value_regex' = 'broth microdilution|disk diffusion|E-test|automated system|agar dilution|gradient diffusion');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ALTER COLUMN `verified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_subdomain' = 'transfusion_services');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_business_glossary_term' = 'Blood Bank Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Crossmatch Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Storage Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_business_glossary_term' = 'ABO Blood Group');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('pii_value_regex' = 'A|B|AB|O');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_business_glossary_term' = 'Bacterial Contamination Testing Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('pii_value_regex' = 'tested_negative|tested_positive|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Blood Unit Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `charge_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cmv_status` SET TAGS ('pii_business_glossary_term' = 'Cytomegalovirus (CMV) Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cmv_status` SET TAGS ('pii_value_regex' = 'cmv_negative|cmv_positive|cmv_safe');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `collection_facility_code` SET TAGS ('pii_business_glossary_term' = 'Blood Collection Facility Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Blood Unit Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `crossmatch_required_flag` SET TAGS ('pii_business_glossary_term' = 'Crossmatch Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `discard_reason` SET TAGS ('pii_business_glossary_term' = 'Discard Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `discard_timestamp` SET TAGS ('pii_business_glossary_term' = 'Discard Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `donation_date` SET TAGS ('pii_business_glossary_term' = 'Blood Donation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `donation_identification_number` SET TAGS ('pii_business_glossary_term' = 'Donation Identification Number (DIN)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Blood Unit Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `extended_phenotype` SET TAGS ('pii_business_glossary_term' = 'Extended Red Cell Phenotype');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hemoglobin_s_status` SET TAGS ('pii_business_glossary_term' = 'Hemoglobin S (Sickle Cell) Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hemoglobin_s_status` SET TAGS ('pii_value_regex' = 'negative|trait|positive|unknown');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_business_glossary_term' = 'Infectious Disease Testing Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_value_regex' = 'tested_negative|tested_positive|pending|not_tested');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_date` SET TAGS ('pii_business_glossary_term' = 'Irradiation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_status` SET TAGS ('pii_business_glossary_term' = 'Irradiation Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_status` SET TAGS ('pii_value_regex' = 'irradiated|non_irradiated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `issue_timestamp` SET TAGS ('pii_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `issued_to_location` SET TAGS ('pii_business_glossary_term' = 'Issued to Clinical Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `leukoreduction_status` SET TAGS ('pii_business_glossary_term' = 'Leukoreduction Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `leukoreduction_status` SET TAGS ('pii_value_regex' = 'leukoreduced|non_leukoreduced');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturing Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_code` SET TAGS ('pii_business_glossary_term' = 'Blood Product Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_type` SET TAGS ('pii_business_glossary_term' = 'Blood Product Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_type` SET TAGS ('pii_value_regex' = 'packed_red_blood_cells|platelets|fresh_frozen_plasma|cryoprecipitate|whole_blood|granulocytes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('pii_business_glossary_term' = 'Quarantine Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reservation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_business_glossary_term' = 'Reserved for Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reserved_for_patient_mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `return_timestamp` SET TAGS ('pii_business_glossary_term' = 'Return Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `rh_type` SET TAGS ('pii_business_glossary_term' = 'Rh Factor Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `rh_type` SET TAGS ('pii_value_regex' = 'positive|negative');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `special_processing_codes` SET TAGS ('pii_business_glossary_term' = 'Special Processing Codes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `storage_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `supplier_facility_code` SET TAGS ('pii_business_glossary_term' = 'Supplier Facility Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `temperature_alarm_flag` SET TAGS ('pii_business_glossary_term' = 'Temperature Alarm Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `transfusion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transfusion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_number` SET TAGS ('pii_business_glossary_term' = 'Blood Unit Number (ISBT 128)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{13,14}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_status` SET TAGS ('pii_business_glossary_term' = 'Blood Unit Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `volume_ml` SET TAGS ('pii_business_glossary_term' = 'Blood Unit Volume (Milliliters)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_subdomain' = 'transfusion_services');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_event_id` SET TAGS ('pii_business_glossary_term' = 'Transfusion Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('pii_business_glossary_term' = 'Blood Bank Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Performing Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Transfusion Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Crossmatch Technologist Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Patient Blood Sample Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('pii_business_glossary_term' = 'Antibody Screen Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('pii_value_regex' = 'positive|negative|not_performed|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_datetime` SET TAGS ('pii_business_glossary_term' = 'Consent Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_datetime` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_obtained` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_obtained` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_datetime` SET TAGS ('pii_business_glossary_term' = 'Crossmatch Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('pii_business_glossary_term' = 'Crossmatch Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('pii_value_regex' = 'compatible|incompatible|not_performed|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_type` SET TAGS ('pii_business_glossary_term' = 'Crossmatch Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_type` SET TAGS ('pii_value_regex' = 'electronic|immediate_spin|full_serologic|type_and_screen|emergency_release');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `hemovigilance_reported` SET TAGS ('pii_business_glossary_term' = 'Hemovigilance Reported Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `last_updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Transfusion Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('pii_business_glossary_term' = 'Post-Transfusion Blood Pressure Diastolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('pii_business_glossary_term' = 'Post-Transfusion Blood Pressure Systolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_pulse` SET TAGS ('pii_business_glossary_term' = 'Post-Transfusion Pulse Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_respiratory_rate` SET TAGS ('pii_business_glossary_term' = 'Post-Transfusion Respiratory Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_respiratory_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_temperature` SET TAGS ('pii_business_glossary_term' = 'Post-Transfusion Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('pii_business_glossary_term' = 'Pre-Transfusion Blood Pressure Diastolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('pii_business_glossary_term' = 'Pre-Transfusion Blood Pressure Systolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_pulse` SET TAGS ('pii_business_glossary_term' = 'Pre-Transfusion Pulse Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_respiratory_rate` SET TAGS ('pii_business_glossary_term' = 'Pre-Transfusion Respiratory Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_respiratory_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_temperature` SET TAGS ('pii_business_glossary_term' = 'Pre-Transfusion Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_description` SET TAGS ('pii_business_glossary_term' = 'Reaction Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_onset_datetime` SET TAGS ('pii_business_glossary_term' = 'Reaction Onset Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('pii_business_glossary_term' = 'Reaction Severity');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('pii_value_regex' = 'mild|moderate|severe|life_threatening');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `special_requirements` SET TAGS ('pii_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Transfusion End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_number` SET TAGS ('pii_business_glossary_term' = 'Transfusion Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_rate` SET TAGS ('pii_business_glossary_term' = 'Transfusion Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_occurred` SET TAGS ('pii_business_glossary_term' = 'Transfusion Reaction Occurred Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_type` SET TAGS ('pii_business_glossary_term' = 'Transfusion Reaction Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_site` SET TAGS ('pii_business_glossary_term' = 'Transfusion Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Transfusion Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('pii_business_glossary_term' = 'Transfusion Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('pii_value_regex' = 'ordered|prepared|in_progress|completed|discontinued|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `unexpected_antibody_identified` SET TAGS ('pii_business_glossary_term' = 'Unexpected Antibody Identified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `volume_transfused_ml` SET TAGS ('pii_business_glossary_term' = 'Volume Transfused in Milliliters (mL)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `point_of_care_test_id` SET TAGS ('pii_business_glossary_term' = 'Point Of Care Test Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Performing Location ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `previous_result_point_of_care_test_id` SET TAGS ('pii_business_glossary_term' = 'Previous Result ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `qc_run_id` SET TAGS ('pii_business_glossary_term' = 'Qc Run Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `abnormal_flag` SET TAGS ('pii_business_glossary_term' = 'Abnormal Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `clia_waived_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Waived Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `collection_datetime` SET TAGS ('pii_business_glossary_term' = 'Collection Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `corrected_result_flag` SET TAGS ('pii_business_glossary_term' = 'Corrected Result Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `critical_value_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `device_type` SET TAGS ('pii_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `ehr_transmission_datetime` SET TAGS ('pii_business_glossary_term' = 'Electronic Health Record (EHR) Transmission Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `ehr_transmission_status` SET TAGS ('pii_business_glossary_term' = 'Electronic Health Record (EHR) Transmission Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `ehr_transmission_status` SET TAGS ('pii_value_regex' = 'transmitted|pending|failed|not_required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_competency_date` SET TAGS ('pii_business_glossary_term' = 'Operator Competency Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_competency_status` SET TAGS ('pii_business_glossary_term' = 'Operator Competency Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_competency_status` SET TAGS ('pii_value_regex' = 'competent|training|expired|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `operator_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_business_glossary_term' = 'Performing Location Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `performing_location_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `qc_datetime` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `qc_lot_number` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `qc_status` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `qc_status` SET TAGS ('pii_value_regex' = 'passed|failed|not_performed|pending');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `reference_range_high` SET TAGS ('pii_business_glossary_term' = 'Reference Range High');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `reference_range_low` SET TAGS ('pii_business_glossary_term' = 'Reference Range Low');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_comment` SET TAGS ('pii_business_glossary_term' = 'Result Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_datetime` SET TAGS ('pii_business_glossary_term' = 'Result Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_numeric` SET TAGS ('pii_business_glossary_term' = 'Result Numeric Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_unit` SET TAGS ('pii_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `result_value` SET TAGS ('pii_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_source` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_category` SET TAGS ('pii_business_glossary_term' = 'Test Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_datetime` SET TAGS ('pii_business_glossary_term' = 'Test Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_status` SET TAGS ('pii_business_glossary_term' = 'Test Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `test_status` SET TAGS ('pii_value_regex' = 'preliminary|final|corrected|cancelled|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_run_id` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Run Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Instrument Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Performing Technologist Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Comments');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `corrective_action_taken` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `corrective_action_timestamp` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `expected_mean` SET TAGS ('pii_business_glossary_term' = 'Expected Mean Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `expected_standard_deviation` SET TAGS ('pii_business_glossary_term' = 'Expected Standard Deviation (SD)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `observed_result` SET TAGS ('pii_business_glossary_term' = 'Observed Quality Control (QC) Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pass_fail_indicator` SET TAGS ('pii_business_glossary_term' = 'Pass or Fail Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_attestation_date` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_corrective_action_plan` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Corrective Action Plan');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_event_code` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Event Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_graded_result` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Graded Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_graded_result` SET TAGS ('pii_value_regex' = 'acceptable|unacceptable|pending|not_graded');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_peer_group_mean` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Peer Group Mean');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_peer_group_standard_deviation` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Peer Group Standard Deviation (SD)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Program Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_sample_number` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Sample Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_submitted_result` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Submitted Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `pt_z_score` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing (PT) Z-Score');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_level` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_material_lot_number` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Material Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_run_status` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Run Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Run Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_type` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `qc_type` SET TAGS ('pii_value_regex' = 'internal_qc|proficiency_testing|reagent_lot_validation|calibration_verification|instrument_maintenance_qc|competency_assessment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `reagent_storage_temperature` SET TAGS ('pii_business_glossary_term' = 'Reagent Storage Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `result_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reviewed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `test_code` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ALTER COLUMN `westgard_rule_evaluation` SET TAGS ('pii_business_glossary_term' = 'Westgard Rule Evaluation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Instrument ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `clia_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Clia Certificate Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Technician ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `vendor_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `asset_tag` SET TAGS ('pii_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('pii_business_glossary_term' = 'Calibration Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `decommission_date` SET TAGS ('pii_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `decommission_reason` SET TAGS ('pii_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('pii_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('pii_value_regex' = 'analyzer|centrifuge|microscope|incubator|spectrophotometer|other');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('pii_business_glossary_term' = 'Laboratory Section');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('pii_value_regex' = 'chemistry|hematology|microbiology|immunology|blood_bank|molecular');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('pii_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('pii_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('pii_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_corrective_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Corrective Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_date` SET TAGS ('pii_business_glossary_term' = 'Last Quality Control (QC) Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('pii_business_glossary_term' = 'Last Quality Control (QC) Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('pii_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lis_connectivity_status` SET TAGS ('pii_business_glossary_term' = 'Laboratory Information System (LIS) Connectivity Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lis_connectivity_status` SET TAGS ('pii_value_regex' = 'connected|disconnected|error|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `lis_interface_code` SET TAGS ('pii_business_glossary_term' = 'Laboratory Information System (LIS) Interface ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `model_number` SET TAGS ('pii_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_business_glossary_term' = 'Instrument Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `next_calibration_date` SET TAGS ('pii_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `next_calibration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `next_preventive_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'active|down|maintenance|decommissioned|pending_installation|calibration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `preventive_maintenance_frequency` SET TAGS ('pii_business_glossary_term' = 'Preventive Maintenance Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `preventive_maintenance_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `quality_control_frequency` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `quality_control_frequency` SET TAGS ('pii_value_regex' = 'per_shift|daily|weekly|per_run');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `service_contract_number` SET TAGS ('pii_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `total_downtime_hours` SET TAGS ('pii_business_glossary_term' = 'Total Downtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_subdomain' = 'test_ordering');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Clia Certificate Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Instrument Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('pii_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Complexity Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('pii_value_regex' = 'waived|moderate|high');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `collection_instructions` SET TAGS ('pii_business_glossary_term' = 'Specimen Collection Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_business_glossary_term' = 'Informed Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `critical_high_value` SET TAGS ('pii_business_glossary_term' = 'Critical High Value Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `critical_low_value` SET TAGS ('pii_business_glossary_term' = 'Critical Low Value Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `minimum_volume` SET TAGS ('pii_business_glossary_term' = 'Minimum Specimen Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_flag` SET TAGS ('pii_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('pii_business_glossary_term' = 'Orderable Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|retired|pending_validation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `ordering_instructions` SET TAGS ('pii_business_glossary_term' = 'Ordering Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `panic_value_flag` SET TAGS ('pii_business_glossary_term' = 'Panic Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('pii_business_glossary_term' = 'Patient Preparation Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `performing_lab_location` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `performing_lab_location` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `preferred_volume` SET TAGS ('pii_business_glossary_term' = 'Preferred Specimen Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_code` SET TAGS ('pii_business_glossary_term' = 'Reference Laboratory Test Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_business_glossary_term' = 'Reference Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_adult` SET TAGS ('pii_business_glossary_term' = 'Adult Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_pediatric` SET TAGS ('pii_business_glossary_term' = 'Pediatric Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('pii_business_glossary_term' = 'Laboratory Result Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('pii_value_regex' = 'quantitative|qualitative|semi_quantitative|narrative|culture|microscopic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_business_glossary_term' = 'Specimen Container Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_business_glossary_term' = 'Specimen Stability Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `storage_temperature` SET TAGS ('pii_business_glossary_term' = 'Specimen Storage Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_abbreviation` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Abbreviation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_category` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_code` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('pii_business_glossary_term' = 'Laboratory Test Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('pii_value_regex' = 'individual_test|panel|profile|reflex_test|add_on_test');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_business_glossary_term' = 'Specimen Transport Conditions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('pii_business_glossary_term' = 'Routine Turnaround Time (TAT)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_stat` SET TAGS ('pii_business_glossary_term' = 'STAT Turnaround Time (TAT)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_subdomain' = 'reimbursement_finance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `lab_charge_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Charge Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `lab_charge_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Performing Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `lab_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory Result Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `test_result_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Billing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `billing_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `cdm_code` SET TAGS ('pii_business_glossary_term' = 'Charge Description Master (CDM) Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Charge Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_entry_method` SET TAGS ('pii_business_glossary_term' = 'Charge Entry Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_entry_method` SET TAGS ('pii_value_regex' = 'automatic|manual|interface|batch');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Charge Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Charge Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_voided_by` SET TAGS ('pii_business_glossary_term' = 'Charge Voided By User');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_voided_reason` SET TAGS ('pii_business_glossary_term' = 'Charge Voided Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `charge_voided_timestamp` SET TAGS ('pii_business_glossary_term' = 'Charge Voided Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_1` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_business_glossary_term' = 'Secondary Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_2` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_business_glossary_term' = 'Tertiary Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_3` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_business_glossary_term' = 'Quaternary Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `diagnosis_code_4` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `insurance_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `insurance_authorization_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `insurance_authorization_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_lab_section` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory Section');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_lab_section` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Performing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `point_of_care_indicator` SET TAGS ('pii_business_glossary_term' = 'Point of Care (POC) Testing Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_indicator` SET TAGS ('pii_business_glossary_term' = 'Reference Laboratory Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_business_glossary_term' = 'Reference Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `reference_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `service_location_code` SET TAGS ('pii_business_glossary_term' = 'Service Location Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ALTER COLUMN `stat_surcharge_amount` SET TAGS ('pii_business_glossary_term' = 'STAT Surcharge Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `clia_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Certificate ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accreditation_program_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accreditation_status_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_business_glossary_term' = 'Accrediting Organization');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `accrediting_organization` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `annual_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Annual CLIA Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `annual_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `annual_test_volume` SET TAGS ('pii_business_glossary_term' = 'Annual Test Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Application Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'CLIA Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_number` SET TAGS ('pii_value_regex' = '^[0-9]{2}D[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_status` SET TAGS ('pii_business_glossary_term' = 'Certificate Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_status` SET TAGS ('pii_value_regex' = 'active|expired|suspended|revoked|pending_renewal|inactive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_type` SET TAGS ('pii_business_glossary_term' = 'CLIA Certificate Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `certificate_type` SET TAGS ('pii_value_regex' = 'certificate_of_waiver|provider_performed_microscopy|certificate_of_registration|certificate_of_compliance|certificate_of_accreditation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `deficiency_count` SET TAGS ('pii_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `fee_payment_status` SET TAGS ('pii_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `fee_payment_status` SET TAGS ('pii_value_regex' = 'current|overdue|delinquent|waived|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `fee_schedule_category` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `inspection_outcome` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Outcome');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `inspection_outcome` SET TAGS ('pii_value_regex' = 'compliant|deficiencies_cited|conditional|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_agency` SET TAGS ('pii_business_glossary_term' = 'Issuing Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_business_glossary_term' = 'Issuing State Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `issuing_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_business_glossary_term' = 'Laboratory Director License Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_business_glossary_term' = 'Laboratory Director License State');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_license_state` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_business_glossary_term' = 'Laboratory Director Full Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_business_glossary_term' = 'Laboratory Director National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_director_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `laboratory_type` SET TAGS ('pii_business_glossary_term' = 'Laboratory Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_fee_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Fee Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `last_proficiency_testing_date` SET TAGS ('pii_business_glossary_term' = 'Last Proficiency Testing Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `next_inspection_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Certificate Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `plan_of_correction_due_date` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction Due Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `plan_of_correction_status` SET TAGS ('pii_business_glossary_term' = 'Plan of Correction Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `plan_of_correction_status` SET TAGS ('pii_value_regex' = 'not_required|pending|submitted|approved|rejected|overdue');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_enrollment` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_business_glossary_term' = 'Last Proficiency Testing Outcome');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_outcome` SET TAGS ('pii_value_regex' = 'successful|unsuccessful|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `proficiency_testing_provider` SET TAGS ('pii_business_glossary_term' = 'Proficiency Testing Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Renewal Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Certificate Renewal Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `renewal_status` SET TAGS ('pii_value_regex' = 'not_due|pending|submitted|approved|denied|overdue');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `sanction_effective_date` SET TAGS ('pii_business_glossary_term' = 'Sanction Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `sanction_lifted_date` SET TAGS ('pii_business_glossary_term' = 'Sanction Lifted Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `sanction_type` SET TAGS ('pii_business_glossary_term' = 'Sanction Type Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `sanctions_imposed` SET TAGS ('pii_business_glossary_term' = 'Sanctions Imposed Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `specialty_codes` SET TAGS ('pii_business_glossary_term' = 'Laboratory Specialty Codes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_business_glossary_term' = 'Testing Complexity Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `testing_complexity_level` SET TAGS ('pii_value_regex' = 'waived|moderate|high|provider_performed_microscopy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `molecular_test_id` SET TAGS ('pii_business_glossary_term' = 'Molecular Test Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_business_glossary_term' = 'Genetic Testing Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Laboratory (Lab) Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `lab_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Variant Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Laboratory Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `allele_frequency` SET TAGS ('pii_business_glossary_term' = 'Variant Allele Frequency (VAF)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `amended` SET TAGS ('pii_business_glossary_term' = 'Amended Result Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `amendment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Amendment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `associated_drug` SET TAGS ('pii_business_glossary_term' = 'Associated Drug or Therapy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `associated_drug` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `bioinformatics_pipeline_version` SET TAGS ('pii_business_glossary_term' = 'Bioinformatics Pipeline Version');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `chromosome_location` SET TAGS ('pii_business_glossary_term' = 'Chromosome Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `clinical_significance` SET TAGS ('pii_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `companion_diagnostic` SET TAGS ('pii_business_glossary_term' = 'Companion Diagnostic Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `companion_diagnostic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `copy_number` SET TAGS ('pii_business_glossary_term' = 'Copy Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `copy_number_variation` SET TAGS ('pii_business_glossary_term' = 'Copy Number Variation (CNV)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `coverage_percentage` SET TAGS ('pii_business_glossary_term' = 'Target Coverage Percentage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `coverage_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `critical_value` SET TAGS ('pii_business_glossary_term' = 'Critical Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `critical_value_notified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Value Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `fda_cleared` SET TAGS ('pii_business_glossary_term' = 'FDA (Food and Drug Administration) Cleared Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `fusion_gene` SET TAGS ('pii_business_glossary_term' = 'Fusion Gene');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `gene_tested` SET TAGS ('pii_business_glossary_term' = 'Gene Tested');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `genetic_counseling_recommended` SET TAGS ('pii_business_glossary_term' = 'Genetic Counseling Recommended');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `laboratory_developed_test` SET TAGS ('pii_business_glossary_term' = 'Laboratory Developed Test (LDT) Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_name` SET TAGS ('pii_business_glossary_term' = 'Laboratory Medical Director Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_npi` SET TAGS ('pii_business_glossary_term' = 'Medical Director National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `medical_director_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `methodology` SET TAGS ('pii_business_glossary_term' = 'Testing Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('pii_business_glossary_term' = 'Microsatellite Instability Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pdl1_expression_score` SET TAGS ('pii_business_glossary_term' = 'Pdl1 Expression Score');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `performing_lab_clia_number` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory CLIA (Clinical Laboratory Improvement Amendments) Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `performing_lab_clia_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_business_glossary_term' = 'Performing Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `performing_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `pharmacogenomic_phenotype` SET TAGS ('pii_business_glossary_term' = 'Pharmacogenomic Phenotype');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Variant Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `read_depth` SET TAGS ('pii_business_glossary_term' = 'Sequencing Read Depth');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `reference_genome` SET TAGS ('pii_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `reference_genome` SET TAGS ('pii_value_regex' = 'GRCh37|GRCh38|hg19|hg38');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `reference_genome_build` SET TAGS ('pii_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `report_narrative` SET TAGS ('pii_business_glossary_term' = 'Molecular Test Report Narrative');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `reportable_to_registry_flag` SET TAGS ('pii_business_glossary_term' = 'Reportable To Registry Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_datetime` SET TAGS ('pii_business_glossary_term' = 'Result Datetime');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_interpretation` SET TAGS ('pii_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_interpretation` SET TAGS ('pii_value_regex' = 'detected|not_detected|positive|negative|indeterminate|inconclusive');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_reported_timestamp` SET TAGS ('pii_business_glossary_term' = 'Result Reported Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `result_status` SET TAGS ('pii_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `sequencing_depth` SET TAGS ('pii_business_glossary_term' = 'Sequencing Depth');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Specimen Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `specimen_received_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `target_gene` SET TAGS ('pii_business_glossary_term' = 'Target Gene or Pathogen');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_category` SET TAGS ('pii_business_glossary_term' = 'Molecular Test Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_category` SET TAGS ('pii_value_regex' = 'oncology|infectious_disease|pharmacogenomics|hereditary|prenatal|hematology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_indication` SET TAGS ('pii_business_glossary_term' = 'Test Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_method` SET TAGS ('pii_business_glossary_term' = 'Test Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_performed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Test Performed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_priority` SET TAGS ('pii_business_glossary_term' = 'Test Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_priority` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_status` SET TAGS ('pii_business_glossary_term' = 'Molecular Test Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_type` SET TAGS ('pii_business_glossary_term' = 'Molecular Test Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `test_type` SET TAGS ('pii_value_regex' = 'diagnostic|screening|confirmatory|monitoring|companion_diagnostic|research');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `therapeutic_implications` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Implications');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('pii_business_glossary_term' = 'Tumor Mutational Burden');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `turnaround_time_hours` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_classification` SET TAGS ('pii_business_glossary_term' = 'Variant Classification (ACMG)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_classification` SET TAGS ('pii_value_regex' = 'pathogenic|likely_pathogenic|VUS|likely_benign|benign');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_detected` SET TAGS ('pii_business_glossary_term' = 'Variant Detected Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_identified` SET TAGS ('pii_business_glossary_term' = 'Variant Identified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_identified` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_nomenclature` SET TAGS ('pii_business_glossary_term' = 'Variant Nomenclature (HGVS)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `variant_nomenclature_hgvs` SET TAGS ('pii_business_glossary_term' = 'Variant Nomenclature Hgvs');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ALTER COLUMN `zygosity` SET TAGS ('pii_business_glossary_term' = 'Zygosity');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_lot_id` SET TAGS ('pii_business_glossary_term' = 'Reagent Lot Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Validated By Technologist Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Instrument Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_instrument_id` SET TAGS ('pii_business_glossary_term' = 'Instrument Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Storage Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Catalog Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `catalog_number` SET TAGS ('pii_business_glossary_term' = 'Catalog Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `certificate_of_analysis_available` SET TAGS ('pii_business_glossary_term' = 'Certificate Of Analysis Available');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `cost_per_unit` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `fda_clearance_number` SET TAGS ('pii_business_glossary_term' = 'Food and Drug Administration (FDA) Clearance Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `fda_cleared_flag` SET TAGS ('pii_business_glossary_term' = 'Food and Drug Administration (FDA) Cleared Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `hazardous_material_flag` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `in_use_expiration_date` SET TAGS ('pii_business_glossary_term' = 'In-Use Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `in_use_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `in_use_stability_days` SET TAGS ('pii_business_glossary_term' = 'In-Use Stability Days');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `light_sensitivity_flag` SET TAGS ('pii_business_glossary_term' = 'Light Sensitivity Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `lot_status` SET TAGS ('pii_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `lot_status` SET TAGS ('pii_value_regex' = 'unopened|in_use|depleted|expired|quarantined|rejected');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `msds_available` SET TAGS ('pii_business_glossary_term' = 'Msds Available');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `open_date` SET TAGS ('pii_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `open_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Open Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `open_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `opened_date` SET TAGS ('pii_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `qc_validation_date` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Validation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `qc_validation_result` SET TAGS ('pii_business_glossary_term' = 'Qc Validation Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `qc_validation_status` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `qc_validation_status` SET TAGS ('pii_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `quantity_on_hand` SET TAGS ('pii_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `quantity_received` SET TAGS ('pii_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `quantity_remaining` SET TAGS ('pii_business_glossary_term' = 'Quantity Remaining');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `quarantine_date` SET TAGS ('pii_business_glossary_term' = 'Quarantine Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `quarantine_reason` SET TAGS ('pii_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_business_glossary_term' = 'Reagent Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reagent_type` SET TAGS ('pii_business_glossary_term' = 'Reagent Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `recall_action_taken` SET TAGS ('pii_business_glossary_term' = 'Recall Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `recall_date` SET TAGS ('pii_business_glossary_term' = 'Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `recall_flag` SET TAGS ('pii_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `recall_notice_number` SET TAGS ('pii_business_glossary_term' = 'Recall Notice Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reconstitution_date` SET TAGS ('pii_business_glossary_term' = 'Reconstitution Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reconstitution_required_flag` SET TAGS ('pii_business_glossary_term' = 'Reconstitution Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `reorder_threshold` SET TAGS ('pii_business_glossary_term' = 'Reorder Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet (SDS) Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature C');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `storage_temperature_requirement` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature Requirement');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `test_method_code` SET TAGS ('pii_business_glossary_term' = 'Test Method Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `test_method_name` SET TAGS ('pii_business_glossary_term' = 'Test Method Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `test_method_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `test_method_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `total_lot_cost` SET TAGS ('pii_business_glossary_term' = 'Total Lot Cost');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `total_lot_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_subdomain' = 'reimbursement_finance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_association_edges' = 'laboratory.test_catalog,insurance.coverage_policy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `test_coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Test Coverage Policy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Test Coverage Policy - Coverage Policy Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Test Coverage Policy - Test Catalog Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `advance_beneficiary_notice_required` SET TAGS ('pii_business_glossary_term' = 'Advance Beneficiary Notice Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `advance_beneficiary_notice_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `advance_beneficiary_notice_required` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `age_restrictions` SET TAGS ('pii_business_glossary_term' = 'Age Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_criteria` SET TAGS ('pii_business_glossary_term' = 'Coverage Criteria');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_determination` SET TAGS ('pii_business_glossary_term' = 'Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_notes` SET TAGS ('pii_business_glossary_term' = 'Coverage Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_percentage` SET TAGS ('pii_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_code_requirements` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_code_requirements` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_code_requirements` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_code_requirements` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `diagnosis_code_requirements` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `excluded_diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Excluded Diagnosis Codes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `excluded_diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `excluded_diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `excluded_diagnosis_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `excluded_diagnosis_codes` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `frequency_limit` SET TAGS ('pii_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `frequency_limitations` SET TAGS ('pii_business_glossary_term' = 'Frequency Limitations');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `frequency_period` SET TAGS ('pii_business_glossary_term' = 'Frequency Period');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Criteria');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_documentation_required` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Documentation Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_documentation_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `medical_necessity_documentation_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `place_of_service_restrictions` SET TAGS ('pii_business_glossary_term' = 'Place of Service Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `prior_auth_required` SET TAGS ('pii_business_glossary_term' = 'Prior Auth Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `required_diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Required Diagnosis Codes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `required_diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `required_diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `required_diagnosis_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `required_diagnosis_codes` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `source_url` SET TAGS ('pii_business_glossary_term' = 'Source Url');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_subdomain' = 'test_ordering');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_association_edges' = 'laboratory.test_catalog,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `study_test_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Study Test Requirement ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Study Test Requirement - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `study_arm_id` SET TAGS ('pii_business_glossary_term' = 'Study Arm Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `study_visit_id` SET TAGS ('pii_business_glossary_term' = 'Study Visit Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Study Test Requirement - Test Catalog Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `central_lab_kit_required` SET TAGS ('pii_business_glossary_term' = 'Central Lab Kit Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `central_lab_name` SET TAGS ('pii_business_glossary_term' = 'Central Lab Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `central_lab_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `central_lab_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `central_lab_routing` SET TAGS ('pii_business_glossary_term' = 'Central Lab Routing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `chain_of_custody_required` SET TAGS ('pii_business_glossary_term' = 'Chain Of Custody Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `collection_instructions` SET TAGS ('pii_business_glossary_term' = 'Collection Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `collection_timepoint` SET TAGS ('pii_business_glossary_term' = 'Collection Timepoint');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `deviation_allowed` SET TAGS ('pii_business_glossary_term' = 'Deviation Allowed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `expected_frequency` SET TAGS ('pii_business_glossary_term' = 'Expected Frequency');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `number_of_aliquots_required` SET TAGS ('pii_business_glossary_term' = 'Number Of Aliquots Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_amendment_number` SET TAGS ('pii_business_glossary_term' = 'Protocol Amendment Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_required_flag` SET TAGS ('pii_business_glossary_term' = 'Protocol Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `protocol_section_reference` SET TAGS ('pii_business_glossary_term' = 'Protocol Section Reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_status` SET TAGS ('pii_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `requirement_type` SET TAGS ('pii_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `result_reporting_timeline_days` SET TAGS ('pii_business_glossary_term' = 'Result Reporting Timeline Days');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `special_handling_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_type_required` SET TAGS ('pii_business_glossary_term' = 'Specimen Type Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `specimen_volume_required_ml` SET TAGS ('pii_business_glossary_term' = 'Specimen Volume Required Ml');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `sponsor_covered_flag` SET TAGS ('pii_business_glossary_term' = 'Sponsor Covered Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `sponsor_required_flag` SET TAGS ('pii_business_glossary_term' = 'Sponsor Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `standard_of_care_flag` SET TAGS ('pii_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `storage_requirements` SET TAGS ('pii_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `test_timing` SET TAGS ('pii_business_glossary_term' = 'Test Timing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ALTER COLUMN `visit_schedule` SET TAGS ('pii_business_glossary_term' = 'Visit Schedule');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_subdomain' = 'reimbursement_finance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_association_edges' = 'laboratory.test_catalog,insurance.fee_schedule');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `lab_fee_schedule_line_id` SET TAGS ('pii_business_glossary_term' = 'Lab Fee Schedule Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `lab_fee_schedule_line_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Lab Fee Schedule Line - Fee Schedule Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `test_catalog_id` SET TAGS ('pii_business_glossary_term' = 'Lab Fee Schedule Line - Test Catalog Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `bundling_indicator` SET TAGS ('pii_business_glossary_term' = 'Bundling Payment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `contracted_rate` SET TAGS ('pii_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('pii_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `coverage_limitation` SET TAGS ('pii_business_glossary_term' = 'Coverage Limitation Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `cpt_code` SET TAGS ('pii_business_glossary_term' = 'Cpt Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Line Item Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `geographic_region` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `lab_fee_schedule_line_status` SET TAGS ('pii_business_glossary_term' = 'Line Item Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `lab_fee_schedule_line_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `medical_necessity_codes` SET TAGS ('pii_business_glossary_term' = 'Medical Necessity Diagnosis Codes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `medical_necessity_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `medical_necessity_codes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `medicare_fee_schedule_amount` SET TAGS ('pii_business_glossary_term' = 'Medicare Fee Schedule Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `modifier_codes` SET TAGS ('pii_business_glossary_term' = 'Required Billing Modifiers');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('pii_business_glossary_term' = 'Percent Of Medicare');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Line Item Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_subdomain' = 'quality_compliance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_association_edges' = 'laboratory.instrument,compliance.policy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_policy_compliance_id` SET TAGS ('pii_business_glossary_term' = 'Instrument Policy Compliance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `accreditation_survey_id` SET TAGS ('pii_business_glossary_term' = 'Accreditation Survey Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `clia_certificate_id` SET TAGS ('pii_business_glossary_term' = 'Clia Certificate Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Instrument Policy Compliance - Policy Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assessor Employee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_corrective_action_verified_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_corrective_action_verified_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_id` SET TAGS ('pii_business_glossary_term' = 'Instrument Policy Compliance - Instrument Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_policy_owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_policy_owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_waiver_granted_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_waiver_granted_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `assessed_by` SET TAGS ('pii_business_glossary_term' = 'Assessed By');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `assessment_outcome` SET TAGS ('pii_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `attestation_status` SET TAGS ('pii_business_glossary_term' = 'Attestation Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `audit_trail_reference` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `deviation_count` SET TAGS ('pii_business_glossary_term' = 'Deviation Count');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Policy Effective Date for Instrument');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `evidence_document_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `evidence_document_url` SET TAGS ('pii_business_glossary_term' = 'Evidence Document');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `instrument_out_of_service_flag` SET TAGS ('pii_business_glossary_term' = 'Out of Service');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `last_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `next_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `non_compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `out_of_service_start_date` SET TAGS ('pii_business_glossary_term' = 'Out of Service Start');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `patient_notification_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `patient_notification_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `patient_notification_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `patient_notification_required_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_category` SET TAGS ('pii_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_name` SET TAGS ('pii_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_requirement` SET TAGS ('pii_business_glossary_term' = 'Policy Requirement');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_source` SET TAGS ('pii_business_glossary_term' = 'Policy Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `regulatory_citation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `return_to_service_date` SET TAGS ('pii_business_glossary_term' = 'Return to Service Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `waiver_justification` SET TAGS ('pii_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `policy_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `evaluation_date` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `evaluation_date` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `evaluator_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `evaluator_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ALTER COLUMN `corrective_action` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_subdomain' = 'diagnostic_results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_id` SET TAGS ('pii_business_glossary_term' = 'Organism Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `parent_organism_id` SET TAGS ('pii_business_glossary_term' = 'Parent Organism Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `parent_organism_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Concept Id');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `aerobic_anaerobic` SET TAGS ('pii_business_glossary_term' = 'Aerobic Anaerobic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `aerobic_requirement` SET TAGS ('pii_business_glossary_term' = 'Aerobic Requirement');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `antibiotic_resistance_profile` SET TAGS ('pii_business_glossary_term' = 'Antibiotic Resistance Profile');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `biosafety_level` SET TAGS ('pii_business_glossary_term' = 'Biosafety Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `bioterrorism_agent_category` SET TAGS ('pii_business_glossary_term' = 'Bioterrorism Agent Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `class_name` SET TAGS ('pii_business_glossary_term' = 'Class Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `class_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `class_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `clinical_significance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_code` SET TAGS ('pii_business_glossary_term' = 'Organism Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_infection_sites` SET TAGS ('pii_business_glossary_term' = 'Common Infection Sites');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_business_glossary_term' = 'Common Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `common_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `culture_media_requirements` SET TAGS ('pii_business_glossary_term' = 'Culture Media Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `environmental_reservoir` SET TAGS ('pii_business_glossary_term' = 'Environmental Reservoir');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `environmental_reservoir` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `family` SET TAGS ('pii_business_glossary_term' = 'Family');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `genus` SET TAGS ('pii_business_glossary_term' = 'Genus');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `gram_stain_reaction` SET TAGS ('pii_business_glossary_term' = 'Gram Stain Reaction');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `gram_stain_result` SET TAGS ('pii_business_glossary_term' = 'Gram Stain Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `identification_methods` SET TAGS ('pii_business_glossary_term' = 'Identification Methods');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `incubation_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Incubation Duration Hours');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `incubation_duration_hours` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `incubation_temperature_celsius` SET TAGS ('pii_business_glossary_term' = 'Incubation Temperature Celsius');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `infection_control_precautions` SET TAGS ('pii_business_glossary_term' = 'Infection Control Precautions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `isolation_precautions` SET TAGS ('pii_business_glossary_term' = 'Isolation Precautions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `kingdom` SET TAGS ('pii_business_glossary_term' = 'Kingdom');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `loinc_code` SET TAGS ('pii_business_glossary_term' = 'Loinc Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `loinc_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `mdro_classification` SET TAGS ('pii_business_glossary_term' = 'Mdro Classification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `morphology` SET TAGS ('pii_business_glossary_term' = 'Morphology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_business_glossary_term' = 'Organism Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `order_name` SET TAGS ('pii_business_glossary_term' = 'Order Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `order_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `order_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_type` SET TAGS ('pii_business_glossary_term' = 'Organism Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `pathogenicity_level` SET TAGS ('pii_business_glossary_term' = 'Pathogenicity Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `pathogenicity_level` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `pathogenicity_level` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `phylum` SET TAGS ('pii_business_glossary_term' = 'Phylum');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `public_health_reportable` SET TAGS ('pii_business_glossary_term' = 'Public Health Reportable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `public_health_reportable` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `public_health_reportable` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `public_health_reportable` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `public_health_reportable` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `reportable_condition_code` SET TAGS ('pii_business_glossary_term' = 'Reportable Condition Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `reportable_status` SET TAGS ('pii_business_glossary_term' = 'Reportable Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_business_glossary_term' = 'Scientific Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `scientific_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `snomed_code` SET TAGS ('pii_business_glossary_term' = 'Snomed Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `snomed_ct_code` SET TAGS ('pii_business_glossary_term' = 'Snomed Ct Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `snomed_ct_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `species` SET TAGS ('pii_business_glossary_term' = 'Species');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `specimen_types` SET TAGS ('pii_business_glossary_term' = 'Specimen Types');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `specimen_types` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `organism_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `subspecies` SET TAGS ('pii_business_glossary_term' = 'Subspecies');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_class` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Class');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_family` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Family');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_genus` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Genus');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_kingdom` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Kingdom');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_order` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Order');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_phylum` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Phylum');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `taxonomy_species` SET TAGS ('pii_business_glossary_term' = 'Taxonomy Species');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `transmission_mode` SET TAGS ('pii_business_glossary_term' = 'Transmission Mode');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ALTER COLUMN `zoonotic_potential` SET TAGS ('pii_business_glossary_term' = 'Zoonotic Potential');
