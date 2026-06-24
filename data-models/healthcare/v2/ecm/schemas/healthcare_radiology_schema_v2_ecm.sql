-- Schema for Domain: radiology | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`radiology` COMMENT 'Medical imaging and diagnostic radiology services. Owns imaging orders, modality scheduling (CT, MRI, X-ray, ultrasound, PET), PACS (Picture Archiving and Communication System) integration, radiology reports, DICOM image metadata, contrast administration, radiation dose tracking, radiologist interpretations, and CPT-coded procedures. Integrates with RIS (Radiology Information System) including Epic Radiant and Cerner RadNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` (
    `imaging_order_id` BIGINT COMMENT 'Unique identifier for the imaging order record.',
    `audit_finding_id` BIGINT COMMENT 'Link to compliance audit finding if this order was flagged during quality or regulatory review.',
    `care_site_id` BIGINT COMMENT 'Facility or care site where the imaging order was placed.',
    `claim_id` BIGINT COMMENT 'Link to the insurance claim associated with this imaging order.',
    `clinical_order_id` BIGINT COMMENT 'Parent clinical order record for this imaging order.',
    `drug_master_id` BIGINT COMMENT 'Drug master record for contrast agent if required.',
    `material_master_id` BIGINT COMMENT 'Material master record for contrast supply if required.',
    `cost_center_id` BIGINT COMMENT 'Cost center responsible for the imaging order.',
    `demographics_id` BIGINT COMMENT 'Patient demographics record.',
    `employee_id` BIGINT COMMENT 'Employee who entered or processed the order.',
    `health_plan_id` BIGINT COMMENT 'Health plan covering the imaging order.',
    `hie_query_id` BIGINT COMMENT 'Health information exchange query if order was retrieved from external system.',
    `icd_code_id` BIGINT COMMENT 'ICD-10 code for primary diagnosis justifying the imaging order.',
    `lab_order_id` BIGINT COMMENT 'Related lab order if imaging is part of a combined diagnostic workup.',
    `payer_id` BIGINT COMMENT 'Insurance payer for the imaging order.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the imaging study.',
    `cpt_code_id` BIGINT COMMENT 'CPT code for the imaging procedure ordered.',
    `research_study_id` BIGINT COMMENT 'Research study if this imaging order is part of a clinical trial.',
    `treatment_consent_id` BIGINT COMMENT 'Treatment consent record for the imaging procedure.',
    `visit_id` BIGINT COMMENT 'Encounter or visit during which the imaging order was placed.',
    `accession_number` STRING COMMENT 'Unique accession number assigned to the imaging order by the RIS.',
    `body_part` STRING COMMENT 'Anatomical body part or region to be imaged.',
    `cancellation_reason` STRING COMMENT 'Reason the imaging order was cancelled if applicable.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time the order was cancelled.',
    `clinical_indication` STRING COMMENT 'Clinical reason or indication for the imaging study.',
    `contrast_required` BOOLEAN COMMENT 'Flag indicating whether contrast agent is required for the study.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the order record was created.',
    `critical_finding_flag` BOOLEAN COMMENT 'Flag indicating whether a critical finding was identified.',
    `exam_end_timestamp` TIMESTAMP COMMENT 'Date and time the imaging exam ended.',
    `exam_start_timestamp` TIMESTAMP COMMENT 'Date and time the imaging exam started.',
    `is_portable` BOOLEAN COMMENT 'Flag indicating whether the exam is portable (bedside).',
    `is_stat_override` BOOLEAN COMMENT 'Flag indicating whether the order was marked as STAT priority.',
    `laterality` STRING COMMENT 'Laterality of the body part (left, right, bilateral).. Valid values are `left|right|bilateral|unspecified`',
    `modality_type` STRING COMMENT 'Imaging modality type (CT, MRI, X-Ray, Ultrasound, etc.).',
    `mrn` STRING COMMENT 'Patient medical record number.',
    `order_priority` STRING COMMENT 'Priority level of the order (routine, urgent, STAT).. Valid values are `stat|urgent|routine|asap|elective`',
    `order_source` STRING COMMENT 'Source system or method by which the order was placed.. Valid values are `inpatient|outpatient|emergency|ambulatory|telehealth`',
    `order_status` STRING COMMENT 'Current status of the imaging order (ordered, scheduled, in progress, completed, cancelled).. Valid values are `ordered|scheduled|in_progress|completed|cancelled|on_hold`',
    `ordered_timestamp` TIMESTAMP COMMENT 'Date and time the order was placed.',
    `ordering_provider_npi` STRING COMMENT 'National Provider Identifier of the ordering clinician.. Valid values are `^[0-9]{10}$`',
    `prior_auth_number` STRING COMMENT 'Prior authorization number from the payer if required.',
    `prior_auth_status` STRING COMMENT 'Status of prior authorization (pending, approved, denied).. Valid values are `approved|pending|denied|not_required|expired`',
    `procedure_description` STRING COMMENT 'Free-text description of the imaging procedure.',
    `protocol_name` STRING COMMENT 'Name of the imaging protocol to be used.',
    `radiation_dose_ctdi` DECIMAL(18,2) COMMENT 'CT Dose Index (CTDI) radiation dose metric.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) radiation dose metric.',
    `referring_department` STRING COMMENT 'Department that referred the patient for imaging.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'Date and time the radiology report was finalized.',
    `report_status` STRING COMMENT 'Status of the radiology report (preliminary, final, amended).. Valid values are `not_started|preliminary|final|addendum|corrected`',
    `requisition_number` STRING COMMENT 'Requisition number for the imaging order.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Date and time the imaging exam is scheduled.',
    `source_system_order_code` STRING COMMENT 'Order code in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the order record was last updated.',
    CONSTRAINT pk_imaging_order PRIMARY KEY(`imaging_order_id`)
) COMMENT 'Radiology imaging orders placed by clinicians for diagnostic or therapeutic imaging procedures. Tracks order lifecycle from placement through completion, including clinical indication, modality, body part, priority, authorization status, and radiation dose metrics. Links to clinical orders, visits, and resulting studies.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` (
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study record.',
    `audit_finding_id` BIGINT COMMENT 'Link to compliance audit finding if this study was flagged.',
    `care_site_id` BIGINT COMMENT 'Facility where the study was performed.',
    `charge_id` BIGINT COMMENT 'Billing charge associated with the study.',
    `claim_id` BIGINT COMMENT 'Insurance claim for the study.',
    `clinical_order_id` BIGINT COMMENT 'Parent clinical order.',
    `clinician_id` BIGINT COMMENT 'Clinician who performed or supervised the study.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Clinical trials operate under compliance programs (IRB oversight, GCP, HIPAA research provisions). Research governance requires linking studies to governing compliance frameworks for audit trails and ',
    `drug_master_id` BIGINT COMMENT 'Contrast drug used in the study.',
    `cost_center_id` BIGINT COMMENT 'Cost center for the study.',
    `demographics_id` BIGINT COMMENT 'Patient demographics.',
    `equipment_asset_id` BIGINT COMMENT 'Imaging equipment used for the study.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Research studies must document which data exchange standards (HL7 v2, FHIR, CDA) are used for regulatory submissions to FDA and data sharing with sponsors/registries per 21 CFR Part 11 compliance requ',
    `hie_query_id` BIGINT COMMENT 'HIE query if study was retrieved from external system.',
    `imaging_order_id` BIGINT COMMENT 'Imaging order that resulted in this study.',
    `protocol_id` BIGINT COMMENT 'Imaging protocol used for the study.',
    `modality_id` BIGINT COMMENT 'Modality equipment used.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Clinical trials often have payer sponsors or require payer coverage analysis for billing determination. Research billing events reference payer relationships for standard-of-care vs research cost allo',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Research protocols target specific disease conditions coded via ICD-10 for inclusion/exclusion criteria, regulatory submissions, and therapeutic area classification. Essential for protocol design and ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Studies involving procedural interventions reference CPT codes for coverage analysis, research billing determination (standard-of-care vs investigational), and regulatory documentation. Critical for b',
    `radiology_cpt_code_id` BIGINT COMMENT 'CPT procedure code for the study.',
    `employee_id` BIGINT COMMENT 'Employee who processed the study.',
    `radiology_icd10_primary_icd_code_id` BIGINT COMMENT 'Primary ICD-10 diagnosis code.',
    `radiology_principal_investigator_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Principal investigators are institutional employees requiring credentialing, license verification, effort reporting, and IRB authorization. Essential for regulatory compliance (FDA 1572, ICH-GCP) and ',
    `research_study_id` BIGINT COMMENT 'Research study if applicable.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Therapeutic specialty alignment enables research feasibility assessment, site selection based on clinical expertise, and principal investigator qualification verification. Healthcare operations use sp',
    `treatment_consent_id` BIGINT COMMENT 'Treatment consent for the study.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Research studies procure investigational products, devices, and specialized equipment from vendors. Protocol compliance requires tracking vendor relationships for IP sourcing, device trials, and regul',
    `visit_id` BIGINT COMMENT 'Encounter or visit.',
    `accession_number` STRING COMMENT 'Unique accession number.',
    `actual_enrollment` STRING COMMENT 'The actual number of subjects enrolled in the study to date.',
    `amendment_count` STRING COMMENT 'The total number of protocol amendments that have been issued for this study.',
    `blinding_type` STRING COMMENT 'The level of blinding or masking applied in the study design.. Valid values are `open_label|single_blind|double_blind|triple_blind|quadruple_blind`',
    `body_part_examined` STRING COMMENT 'Anatomical body part examined.',
    `cfr_part_11_compliant_flag` BOOLEAN COMMENT 'Indicates whether the study is conducted in compliance with FDA 21 CFR Part 11 electronic records and electronic signatures requirements.',
    `clinical_indication` STRING COMMENT 'Clinical indication for the study.',
    `completion_date` DATE COMMENT 'The date on which the study was completed or is expected to be completed (last subject last visit).',
    `contrast_administered` BOOLEAN COMMENT 'Flag indicating contrast was administered.',
    `control_type` STRING COMMENT 'The type of control used in the study design.. Valid values are `placebo|active_comparator|no_intervention|sham|dose_comparison|historical`',
    `coordinating_center` STRING COMMENT 'The name of the coordinating center or data coordinating center managing the multi-site study.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `critical_finding_flag` BOOLEAN COMMENT 'Flag for critical finding.',
    `critical_finding_notified_timestamp` TIMESTAMP COMMENT 'Timestamp when critical finding was notified.',
    `data_monitoring_committee_flag` BOOLEAN COMMENT 'Indicates whether an independent Data Monitoring Committee or Data Safety Monitoring Board oversees the study.',
    `dicom_study_instance_uid` STRING COMMENT 'DICOM Study Instance UID.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `enrollment_end_date` DATE COMMENT 'The date on which subject enrollment was closed or is planned to close.',
    `enrollment_start_date` DATE COMMENT 'The date on which subject enrollment began for this study.',
    `exclusion_criteria` STRING COMMENT 'Summary of the key exclusion criteria that would disqualify subjects from enrollment.',
    `fda_regulated_device_flag` BOOLEAN COMMENT 'Indicates whether the study involves an FDA-regulated device product.',
    `fda_regulated_drug_flag` BOOLEAN COMMENT 'Indicates whether the study involves an FDA-regulated drug product.',
    `funding_source` STRING COMMENT 'The primary source of funding for the research study (e.g., NIH grant number, industry sponsor).',
    `ide_number` STRING COMMENT 'The FDA-assigned Investigational Device Exemption number for device studies.',
    `image_count` STRING COMMENT 'Total number of images in the study.',
    `import_method` STRING COMMENT 'Method by which the study was imported.. Valid values are `cd_dvd|direct_dicom|fax_scan|hie_exchange|vendor_neutral_archive|patient_portal`',
    `inclusion_criteria` STRING COMMENT 'Summary of the key inclusion criteria that subjects must meet to be eligible for enrollment.',
    `ind_number` STRING COMMENT 'The FDA-assigned Investigational New Drug application number for drug studies.',
    `irb_approval_date` DATE COMMENT 'The date on which the IRB granted initial approval for the study to commence.',
    `irb_expiration_date` DATE COMMENT 'The date on which the current IRB approval expires and requires renewal.',
    `irb_protocol_number` STRING COMMENT 'The protocol number assigned by the Institutional Review Board that approved the study.',
    `is_external_import` BOOLEAN COMMENT 'Flag indicating study was imported from external source.',
    `is_stat_read_completed` BOOLEAN COMMENT 'Flag indicating STAT read was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the research study record was last updated or modified.',
    `laterality` STRING COMMENT 'Laterality (left, right, bilateral).. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `mvm_alias_name` STRING COMMENT 'MVM-tier alias name (study) for this ECM product, ensuring ECM is a true superset of the MVM.',
    `mvm_ecm_reconciled_flag` BOOLEAN COMMENT 'True when this ECM product has been reconciled against its MVM alias.',
    `nct_identifier` STRING COMMENT 'ClinicalTrials.gov registry identifier (NCT number) for the study. Required for applicable clinical trials under FDAAA 801.. Valid values are `^NCT[0-9]{8}$`',
    `order_received_timestamp` TIMESTAMP COMMENT 'Timestamp when order was received.',
    `pacs_archive_location` STRING COMMENT 'PACS archive storage location.',
    `pacs_status` STRING COMMENT 'PACS archival status.. Valid values are `received|archived|retrieved|purged|error`',
    `patient_age_at_study` STRING COMMENT 'Patient age at time of study.',
    `patient_sex` STRING COMMENT 'Patient sex.. Valid values are `M|F|O|U`',
    `phase` STRING COMMENT 'The clinical trial phase (I, II, III, IV) indicating the stage of drug or device development. Not applicable for non-interventional studies. [ENUM-REF-CANDIDATE: phase_i|phase_ii|phase_iii|phase_iv|phase_i_ii|phase_ii_iii|not_applicable — 7 candidates stripped; promote to reference product]',
    `primary_completion_date` DATE COMMENT 'The date on which the last subject was examined or received an intervention for the purposes of final collection of data for the primary outcome.',
    `primary_outcome_measure` STRING COMMENT 'Description of the primary outcome measure or endpoint that the study is designed to assess.',
    `priority` STRING COMMENT 'Study priority.. Valid values are `stat|urgent|routine|elective`',
    `protocol_number` STRING COMMENT 'The official protocol number assigned to the research study by the sponsor or institution. Serves as the primary business identifier for the study.',
    `protocol_version` STRING COMMENT 'The current version number or identifier of the study protocol.',
    `protocol_version_date` DATE COMMENT 'The effective date of the current protocol version.',
    `radiation_dose_ctdi_vol` DECIMAL(18,2) COMMENT 'CT Dose Index Volume.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product.',
    `randomization_flag` BOOLEAN COMMENT 'Indicates whether the study employs randomization of subjects to treatment arms.',
    `reconciled_from_mvm` STRING COMMENT 'Indicates source MVM table reconciled into ECM',
    `reconciliation_source` STRING COMMENT 'Source MVM table: radiology.study',
    `referring_department` STRING COMMENT 'Referring department.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'Report finalized timestamp.',
    `report_status` STRING COMMENT 'Report status.. Valid values are `preliminary|final|addendum|corrected|cancelled`',
    `ris_system_source` STRING COMMENT 'RIS system source.. Valid values are `epic_radiant|cerner_radnet|meditech|other`',
    `secondary_outcome_measures` STRING COMMENT 'Description of secondary outcome measures or endpoints assessed in the study.',
    `series_count` STRING COMMENT 'Number of DICOM series.',
    `short_title` STRING COMMENT 'Abbreviated or short title of the study for operational use and reporting.',
    `size_mb` DECIMAL(18,2) COMMENT 'Study size in megabytes.',
    `source_facility_name` STRING COMMENT 'Source facility name.',
    `sponsor_name` STRING COMMENT 'The name of the organization or entity sponsoring the research study (pharmaceutical company, academic institution, government agency).',
    `sponsor_type` STRING COMMENT 'Classification of the sponsor organization type.. Valid values are `industry|academic|government|non_profit|investigator_initiated`',
    `ssot_canonical_reference` STRING COMMENT 'Reference to the canonical SSOT record when this record is deprecated or merged',
    `ssot_reconciliation_status` STRING COMMENT 'Status indicating reconciliation state with related SSOT entity: ACTIVE, DEPRECATED, MERGED, SUPERSEDED',
    `start_date` DATE COMMENT 'The date on which the study officially began enrollment or first subject first visit.',
    `start_timestamp` TIMESTAMP COMMENT 'Study start timestamp.',
    `study_date` DATE COMMENT 'Study date.',
    `study_description` STRING COMMENT 'Study description.',
    `study_status` STRING COMMENT 'Study status.. Valid values are `scheduled|arrived|in_progress|completed|cancelled|on_hold`',
    `study_type` STRING COMMENT 'Classification of the research study type indicating the nature of the investigation.. Valid values are `interventional|observational|expanded_access|registry|diagnostic|prevention`',
    `target_enrollment` STRING COMMENT 'The planned total number of subjects to be enrolled in the study across all sites.',
    `title` STRING COMMENT 'The full official title of the research study as documented in the protocol.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record updated timestamp.',
    `vibe_reconciled_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_radiology_study PRIMARY KEY(`radiology_study_id`)
) COMMENT 'Radiology imaging studies performed and stored in PACS. Represents the actual imaging exam with DICOM study instance UID, modality, body part examined, series count, image count, radiation dose, and report status. Links to imaging orders, reports, and DICOM series. MVM alias: study (ECM superset of MVM).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` (
    `dicom_series_id` BIGINT COMMENT 'Unique identifier for the DICOM series record.',
    `protocol_id` BIGINT COMMENT 'Imaging protocol used for this series.',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: Each DICOM series is acquired on a specific imaging modality device. dicom_series currently links only to radiology_study and protocol. Adding modality_id captures the actual acquisition equipment per',
    `employee_id` BIGINT COMMENT 'Technologist who performed the series.',
    `radiology_study_id` BIGINT COMMENT 'Parent radiology study.',
    `accession_number` STRING COMMENT 'Accession number.',
    `body_part_examined` STRING COMMENT 'Body part examined.',
    `contrast_bolus_agent` STRING COMMENT 'Contrast agent used.',
    `contrast_bolus_route` STRING COMMENT 'Route of contrast administration.. Valid values are `IV|ORAL|RECTAL|INTRA_ARTERIAL|INTRATHECAL`',
    `contrast_bolus_volume_ml` DECIMAL(18,2) COMMENT 'Volume of contrast in mL.',
    `cpt_code` STRING COMMENT 'CPT code for the series.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `ctdi_vol_mgy` DECIMAL(18,2) COMMENT 'CT Dose Index Volume in mGy.',
    `dlp_mgy_cm` DECIMAL(18,2) COMMENT 'Dose Length Product in mGy·cm.',
    `exposure_ma` DECIMAL(18,2) COMMENT 'Exposure in milliamperes.',
    `exposure_time_ms` DECIMAL(18,2) COMMENT 'Exposure time in milliseconds.',
    `image_orientation_patient` STRING COMMENT 'DICOM Image Orientation (Patient).',
    `kvp` DECIMAL(18,2) COMMENT 'Peak kilovoltage.',
    `laterality` STRING COMMENT 'Laterality.. Valid values are `L|R|B|U`',
    `modality` STRING COMMENT 'DICOM modality code.',
    `number_of_series_related_instances` STRING COMMENT 'Number of DICOM instances in the series.',
    `pacs_archive_status` STRING COMMENT 'PACS archive status.. Valid values are `online|nearline|offline|archived|pending_archive`',
    `pacs_storage_path` STRING COMMENT 'PACS storage path.',
    `patient_position` STRING COMMENT 'Patient position during imaging.',
    `performing_physician_name` STRING COMMENT 'Performing physician name.',
    `pixel_spacing_mm` STRING COMMENT 'Pixel spacing in mm.. Valid values are `^[0-9]+.[0-9]+[0-9]+.[0-9]+$`',
    `procedure_code_modifier` STRING COMMENT 'CPT modifier.. Valid values are `^[0-9A-Z]{2}$`',
    `quality_control_comments` STRING COMMENT 'Quality control comments.',
    `quality_control_status` STRING COMMENT 'Quality control status.. Valid values are `pending|passed|failed|not_required`',
    `radiation_dose_mgy` DECIMAL(18,2) COMMENT 'Radiation dose in mGy.',
    `referring_physician_npi` STRING COMMENT 'Referring physician NPI.. Valid values are `^[0-9]{10}$`',
    `requesting_physician_name` STRING COMMENT 'Requesting physician name.',
    `series_completeness_flag` BOOLEAN COMMENT 'Flag indicating series is complete.',
    `series_date` DATE COMMENT 'Series date.',
    `series_description` STRING COMMENT 'Series description.',
    `series_instance_uid` STRING COMMENT 'DICOM Series Instance UID.. Valid values are `^[0-9.]+$`',
    `series_number` STRING COMMENT 'Series number.',
    `series_status` STRING COMMENT 'Series status.. Valid values are `acquired|archived|quality_review|approved|rejected|deleted`',
    `series_time` TIMESTAMP COMMENT 'Series time.',
    `slice_thickness_mm` DECIMAL(18,2) COMMENT 'Slice thickness in mm.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record updated timestamp.',
    CONSTRAINT pk_dicom_series PRIMARY KEY(`dicom_series_id`)
) COMMENT 'DICOM series within a radiology study. Each series represents a set of images acquired with a single imaging protocol or sequence. Tracks series-level metadata including modality, body part, contrast, radiation dose, image count, and PACS storage path.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`report` (
    `report_id` BIGINT COMMENT 'Primary key for report',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Radiology reports are audited for completeness, critical result communication timeliness, and documentation standards. TJC, state medical boards, and internal compliance programs audit reports for reg',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, imaging center, outpatient clinic) where the imaging study was performed. Used for operational reporting, capacity management, and multi-site analytics.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Finalized radiology reports trigger professional component billing. Compliance audits verify that billed interpretation services match documented reports. Essential for professional fee billing, charg',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Finalized radiology reports document medical necessity and support claim adjudication. Payers require reports for audit defense, appeals, and medical review. Linking reports to claims enables attachme',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Radiology reports document findings from ordered studies. Providers review results in context of original orders. Quality metrics track order-to-report turnaround times. Regulatory requirements for re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Radiology reports represent professional component work that must be allocated to radiologist cost centers for productivity-based costing, professional fee allocation, and departmental P&L. Critical f',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Reports reference CPT codes for billing reconciliation between RIS and revenue cycle systems, support professional fee coding, and enable radiologist productivity tracking by procedure complexity and ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Reports document ICD-10 codes for clinical documentation integrity, support diagnosis-based quality measures, and enable population health analytics linking imaging findings to disease prevalence.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order that triggered this radiology report. Links the report back to the order management workflow in the radiology domain.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the imaging study and this report. Protected Health Information (PHI) under HIPAA. Links to the Master Patient Index (MPI).',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who authored the addendum or amendment. May differ from the original signing radiologist. Null for the original report.',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.study. Business justification: report currently has imaging_order_id FK but no imaging_study_id FK. Radiology reports interpret STUDIES (the actual acquired images), not orders. One order can result in multiple studies (e.g., repea',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Radiology reports for research subjects require linkage for endpoint adjudication, independent imaging review, safety monitoring, and regulatory submissions. Reports may be blinded for trial integrity',
    `tertiary_report_reading_radiologist_clinician_id` BIGINT COMMENT 'Reference to the radiologist who performed the primary interpretation of the imaging study. May differ from the signing radiologist in teaching or supervisory contexts (e.g., resident reads, attending signs). Used for productivity tracking and RVU attribution.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Radiology reports often dictated and transcribed by medical transcriptionists. Tracking needed for quality assurance, productivity monitoring, and error investigation when voice recognition not used.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the imaging study was ordered and performed. Enables linkage to the patient visit context for clinical and revenue cycle workflows.',
    `accession_number` STRING COMMENT 'Externally-known unique identifier assigned by the Radiology Information System (RIS) to the imaging order and its associated report. Used as the primary cross-system business key linking the report to the imaging order, PACS, and billing systems. Sourced from Epic Radiant and Cerner RadNet.',
    `addendum_sequence` STRING COMMENT 'Sequential number identifying the addendum within the reports amendment history. Null for the original report. Increments with each addendum or amendment added post-finalization. Used to order and display the full report amendment history.',
    `addendum_text` STRING COMMENT 'Full text content of the addendum or amendment added to the report post-finalization. Contains Protected Health Information (PHI). Null for the original report. Preserves the complete amendment history as versioned child records.',
    `addendum_timestamp` TIMESTAMP COMMENT 'Date and time when the addendum or amendment was authored and signed. Null for the original report. Used to track the timeline of post-final modifications.',
    `addendum_type` STRING COMMENT 'Classifies the type of post-final modification to the report. Addendum adds new information without changing the original; amendment modifies existing content; correction fixes a factual error; retraction withdraws the report. Null for the original report.. Valid values are `addendum|amendment|correction|retraction`',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date and time when the signing radiologist attested and finalized the report, transitioning it to final status. This is the principal business event timestamp for the report lifecycle. Required for billing, legal, and compliance purposes.',
    `body_part` STRING COMMENT 'Anatomical region or body part that was the subject of the imaging study (e.g., CHEST, ABDOMEN, BRAIN, KNEE). Sourced from DICOM tag (0018,0015) and RIS order. Used for clinical classification and CPT code validation.',
    `contrast_administered_flag` BOOLEAN COMMENT 'Indicates whether contrast agent was administered during the imaging study. Relevant for CPT code selection, billing accuracy, radiation safety, and clinical documentation of contrast reactions.',
    `contrast_agent_name` STRING COMMENT 'Name of the contrast agent administered during the imaging study (e.g., Gadolinium, Iohexol, Gadobutrol). Null if no contrast was administered. Used for adverse event tracking, pharmacy reconciliation, and clinical documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the radiology report record was first created in the source system. Represents the audit creation timestamp for the report entity. Used for data lineage, audit trails, and compliance reporting.',
    `critical_finding_communicated_flag` BOOLEAN COMMENT 'Indicates whether the critical finding has been communicated to the ordering or responsible provider. Required for Joint Commission compliance. Only applicable when critical_finding_flag is True.',
    `critical_finding_communicated_timestamp` TIMESTAMP COMMENT 'Date and time when the critical finding was communicated to the ordering or responsible provider. Used to measure turnaround time compliance with Joint Commission and ACR critical results communication standards.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates whether the report contains a critical or urgent finding that requires immediate communication to the ordering provider per ACR and Joint Commission guidelines. When True, triggers a critical results notification workflow. Supports patient safety and regulatory compliance.',
    `dicom_study_instance_uid` STRING COMMENT 'Globally unique DICOM Study Instance UID linking this report to the corresponding image set in the Picture Archiving and Communication System (PACS). Enables direct navigation from the report to the source images. Sourced from DICOM tag (0020,000D).',
    `dictation_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist began dictating the report. Used to measure report turnaround time (TAT) from study completion to dictation. Sourced from Epic Radiant or Cerner RadNet workflow timestamps.',
    `findings_text` STRING COMMENT 'Full narrative text of the radiologists findings section of the report, describing the imaging observations in detail. Contains Protected Health Information (PHI). This is the primary clinical content of the report and the source of truth for diagnostic observations. Sourced from Epic ClinDoc or Cerner PowerChart dictation/transcription.',
    `follow_up_recommendation` STRING COMMENT 'Structured follow-up recommendation from the radiologists impression, indicating the recommended next action (e.g., Follow-up CT in 3 months, Biopsy recommended, No follow-up needed). Used for care coordination, population health management, and closing the loop on incidental findings.',
    `impression_text` STRING COMMENT 'Radiologists summary impression or conclusion section of the report, providing the diagnostic interpretation and clinical recommendations. Contains Protected Health Information (PHI). This is the most clinically actionable section of the report and is used for clinical decision support, CDI, and quality measurement.',
    `laterality` STRING COMMENT 'Indicates the side of the body examined when applicable (left, right, bilateral, or unspecified). Critical for surgical safety, billing accuracy, and clinical documentation. Sourced from DICOM tag (0020,0060) and RIS.. Valid values are `left|right|bilateral|unspecified`',
    `modality_code` STRING COMMENT 'DICOM-standard code identifying the imaging modality used for the study (e.g., CT = Computed Tomography, MR = Magnetic Resonance Imaging, XR/DX/CR = X-Ray, US = Ultrasound, PT = Positron Emission Tomography, NM = Nuclear Medicine, MG = Mammography, FL = Fluoroscopy). Sourced from DICOM tag (0008,0060). [ENUM-REF-CANDIDATE: CT|MR|XR|US|PT|NM|MG|FL|DX|CR — 10 candidates stripped; promote to reference product]',
    `preliminary_timestamp` TIMESTAMP COMMENT 'Date and time when the report was first released in preliminary status, making it available to ordering providers before final attestation. Key lifecycle event for TAT measurement and clinical workflow.',
    `radiation_dose_ctdi` DECIMAL(18,2) COMMENT 'CT Dose Index Volume (CTDIvol) in mGy representing the average radiation dose per unit length for CT studies. Null for non-CT modalities. Used alongside DLP for comprehensive radiation dose monitoring and ACR Dose Index Registry reporting.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm representing the total radiation dose delivered during the CT or fluoroscopy study. Null for non-ionizing modalities (MRI, Ultrasound). Used for radiation dose monitoring, ACR Dose Index Registry reporting, and patient safety compliance.',
    `rads_category` STRING COMMENT 'Standardized ACR Reporting and Data System (RADS) assessment category assigned in the impression (e.g., BI-RADS 0-6 for mammography, LI-RADS 1-5 for liver, TI-RADS 1-5 for thyroid, Lung-RADS 1-4). Drives follow-up recommendations and quality measurement. [ENUM-REF-CANDIDATE: BI-RADS 0|BI-RADS 1|BI-RADS 2|BI-RADS 3|BI-RADS 4|BI-RADS 5|BI-RADS 6|LI-RADS 1|LI-RADS 2|LI-RADS 3|LI-RADS 4|LI-RADS 5|TI-RADS 1|TI-RADS 2|TI-RADS 3|TI-RADS 4|TI-RADS 5|Lung-RADS 1|Lung-RADS 2|Lung-RADS 3|Lung-RADS 4 — promote to reference product]',
    `report_status` STRING COMMENT 'Current workflow state of the radiology report. Drives clinical decision-making and downstream notification workflows. Preliminary indicates a draft interpretation; final indicates the signed, attested report; addendum and amended indicate post-final modifications. Aligns with HL7 FHIR DiagnosticReport.status.. Valid values are `preliminary|final|addendum|amended|corrected|cancelled`',
    `ris_report_code` STRING COMMENT 'Native report identifier from the source Radiology Information System (RIS), such as Epic Radiant or Cerner RadNet. Used for cross-system reconciliation, ETL lineage tracking, and source system audit.',
    `signing_radiologist_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the radiologist who signed and attested the final report. Required for CMS billing, claims submission, and provider credentialing validation. Sourced from the NPPES registry.. Valid values are `^[0-9]{10}$`',
    `stat_priority_flag` BOOLEAN COMMENT 'Indicates whether the imaging order and report were designated as STAT (immediate/urgent priority), requiring expedited turnaround time. Drives workflow prioritization in the RIS and radiologist worklist. Used for TAT compliance monitoring.',
    `study_datetime` TIMESTAMP COMMENT 'Date and time when the imaging study was performed (image acquisition). This is the principal real-world event time for the report. Sourced from DICOM tag (0008,0020)/(0008,0030) and RIS. Used as the primary temporal anchor for TAT calculations and clinical timelines.',
    `study_description` STRING COMMENT 'Human-readable description of the imaging study protocol or procedure performed (e.g., CT Chest with Contrast, MRI Brain without Contrast). Sourced from the RIS order and DICOM tag (0008,1030). Used for report titling and clinical context.',
    `template_code` BIGINT COMMENT 'Reference to the structured reporting template used to generate the report (e.g., ACR-standardized templates, site-specific templates). Supports structured reporting initiatives, quality measurement, and AI-assisted reporting workflows.',
    `transcription_timestamp` TIMESTAMP COMMENT 'Date and time when the report transcription was completed (if applicable). Relevant for facilities using human transcription services rather than voice recognition. Used in TAT measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the radiology report record was last modified in the source system. Used for incremental data loading, change data capture (CDC), and audit trail maintenance.',
    `version` STRING COMMENT 'Sequential version number of the report, starting at 1 for the initial report and incrementing with each amendment or addendum. Enables tracking of the full amendment history and identification of the current authoritative version.',
    CONSTRAINT pk_report PRIMARY KEY(`report_id`)
) COMMENT 'Radiology report containing findings, impressions, and critical result documentation for a completed study.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` (
    `report_addendum_id` BIGINT COMMENT 'Unique surrogate identifier for each radiology report addendum record in the Silver Layer lakehouse. Primary key for this entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Report addenda are audited for timeliness, appropriateness, and medical record integrity. Compliance monitors addendum practices to ensure proper documentation standards and regulatory compliance.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, imaging center, outpatient clinic) where the original imaging study was performed and the addendum was issued. Supports multi-facility enterprise reporting and regulatory submissions.',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Report addenda generate separate CDA document versions (replacement or addendum document types) for HIE transmission. Required for regulatory compliance and ensuring downstream systems receive correct',
    `cdi_query_id` BIGINT COMMENT 'Reference to the CDI (Clinical Documentation Improvement) query that prompted this addendum, if applicable. Links the addendum to the CDI workflow for documentation quality tracking and DRG (Diagnosis-Related Group) impact analysis.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Addenda may reference procedure codes when clarifying exam scope or correcting billing. Supports revenue integrity audits and ensures addendum changes are reflected in charge capture systems.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Addenda may update or clarify diagnosis codes for CDI queries, DRG impact analysis, and billing corrections. Links support amendment tracking and diagnosis code change auditing for compliance.',
    `message_log_id` BIGINT COMMENT 'Unique identifier of the HL7 (Health Level Seven) ORU or MDM message used to transmit this addendum between systems (e.g., from RIS to EHR via HL7 v2.x or FHIR). Supports interoperability audit and HIE (Health Information Exchange) traceability.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose imaging study and original report are being amended. Required for PHI (Protected Health Information) audit trails and HIM (Health Information Management) compliance.',
    `org_unit_id` BIGINT COMMENT 'Reference to the radiology department or imaging section within the facility where the addendum was issued. Supports departmental performance analytics and CDI program management.',
    `report_id` BIGINT COMMENT 'Reference to the finalized radiology report to which this addendum is appended. Links the addendum to its parent report for audit and CDI (Clinical Documentation Improvement) traceability.',
    `clinician_id` BIGINT COMMENT 'Internal provider identifier for the radiologist or clinician who authored this addendum. Complements author_npi for internal system linkage to the provider master.',
    `tertiary_report_ordering_provider_clinician_id` BIGINT COMMENT 'Internal provider identifier for the clinician who placed the original imaging order. Required to determine notification obligations when an addendum is issued, per ACR communication guidelines.',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit) during which the original imaging study was ordered. Supports clinical context linkage for CDI and quality reporting.',
    `accession_number` STRING COMMENT 'RIS (Radiology Information System)-assigned accession number of the imaging order associated with the original report. Used to correlate the addendum back to the imaging study in Epic Radiant or Cerner RadNet.',
    `acknowledgment_datetime` TIMESTAMP COMMENT 'Date and time when the ordering provider acknowledged receipt of the addendum notification. Nullable until acknowledged. Critical for closed-loop communication compliance per ACR and TJC standards.',
    `addendum_datetime` TIMESTAMP COMMENT 'Date and time when the addendum was authored and entered into the RIS/EHR system. Represents the principal business event timestamp for this transaction. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `addendum_sequence_number` STRING COMMENT 'Sequential integer indicating the order of this addendum relative to other addenda on the same original report (e.g., 1 = first addendum, 2 = second addendum). Supports multi-addendum tracking and version ordering.',
    `addendum_status` STRING COMMENT 'Current workflow lifecycle state of the addendum. draft = authored but not yet signed; pending_review = awaiting co-signature or peer review; finalized = signed and locked; retracted = addendum itself has been withdrawn.. Valid values are `draft|pending_review|finalized|retracted`',
    `addendum_text` STRING COMMENT 'Full narrative text of the addendum as authored by the radiologist. Contains PHI (Protected Health Information) and clinical findings. Supports CDI (Clinical Documentation Improvement) workflows and HIM audit requirements.',
    `addendum_type` STRING COMMENT 'Categorical classification of the addendum indicating its clinical purpose. correction = factual error corrected; clarification = ambiguous language clarified; clinical_update = new clinical information incorporated; addendum = supplemental information added; retraction = prior finding retracted. [ENUM-REF-CANDIDATE: correction|clarification|clinical_update|addendum|retraction — promote to reference product if additional types emerge]. Valid values are `correction|clarification|clinical_update|addendum|retraction`',
    `addendum_word_count` STRING COMMENT 'Number of words in the addendum text. Used for documentation completeness analytics, CDI program metrics, and radiologist productivity reporting. Derived at ingestion time from addendum_text.',
    `amendment_reason` STRING COMMENT 'Free-text or structured explanation of why the original report required amendment. Documents the clinical or administrative rationale (e.g., Transcription error in laterality, New clinical history provided by ordering physician). Required for HIM audit and OIG (Office of Inspector General) compliance.',
    `amendment_reason_code` STRING COMMENT 'Standardized code categorizing the reason for amendment, enabling structured reporting and quality analytics. Complements the free-text amendment_reason field. [ENUM-REF-CANDIDATE: transcription_error|laterality_error|clinical_history_update|measurement_correction|impression_revision|additional_finding|provider_request|other — promote to reference product]',
    `author_npi` STRING COMMENT '10-digit NPI (National Provider Identifier) of the radiologist or clinician who authored this addendum. Required for provider attribution, credentialing validation, and CMS (Centers for Medicare and Medicaid Services) billing compliance.. Valid values are `^[0-9]{10}$`',
    `body_part` STRING COMMENT 'Anatomical body part or region examined in the original imaging study (e.g., CHEST, ABDOMEN, BRAIN, SPINE). Derived from DICOM tag (0018,0015) BodyPartExamined. Supports anatomical-level quality and utilization analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this addendum record was first created in the data platform. Used for audit trail and data lineage tracking per HIPAA and HIM requirements.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates whether this addendum contains or introduces a critical or urgent finding requiring immediate clinical action. When True, triggers expedited notification workflows per ACR and TJC critical results communication standards.',
    `dicom_study_instance_uid` STRING COMMENT 'Globally unique DICOM (Digital Imaging and Communications in Medicine) Study Instance UID of the imaging study associated with the original report. Enables direct linkage to PACS (Picture Archiving and Communication System) for image retrieval and addendum context.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `drg_impact_flag` BOOLEAN COMMENT 'Indicates whether this addendum has the potential to change the DRG (Diagnosis-Related Group) assignment for the associated inpatient encounter, affecting reimbursement. True = DRG may be affected; False = no DRG impact anticipated. Supports RCM (Revenue Cycle Management) and CDI analytics.',
    `finalized_datetime` TIMESTAMP COMMENT 'Date and time when the addendum was electronically signed and finalized by the authoring radiologist. Distinct from addendum_datetime (authoring time) — captures the attestation event for HIM audit and legal record purposes.',
    `him_review_datetime` TIMESTAMP COMMENT 'Date and time when the HIM department completed its review of this addendum. Nullable until HIM review is performed. Supports HIM audit trail and CDI workflow tracking.',
    `him_review_flag` BOOLEAN COMMENT 'Indicates whether this addendum has been flagged for review by the HIM (Health Information Management) department for coding accuracy, documentation integrity, or compliance purposes.',
    `impression_changed_flag` BOOLEAN COMMENT 'Indicates whether the addendum materially changes the clinical impression or diagnosis of the original report. True = impression revised; False = addendum is supplemental or administrative only. Key metric for CDI quality analytics and RAC (Recovery Audit Contractor) review.',
    `laterality` STRING COMMENT 'Laterality of the anatomical region examined (left, right, bilateral, or not applicable). Frequently the subject of addenda when laterality errors are identified in the original report. Supports patient safety and HIM audit workflows.. Valid values are `left|right|bilateral|not_applicable`',
    `modality` STRING COMMENT 'Imaging modality of the original study being amended (e.g., CT = Computed Tomography, MRI = Magnetic Resonance Imaging, XR = X-Ray, US = Ultrasound, PET = Positron Emission Tomography). Supports modality-level quality analytics and ACR benchmarking. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DX|other — promote to reference product]',
    `notification_datetime` TIMESTAMP COMMENT 'Date and time when the notification of this addendum was dispatched to the ordering provider. Nullable when notification_status is not_required. Supports ACR communication audit trail.',
    `notification_method` STRING COMMENT 'Channel or method used to notify the ordering provider of the addendum (e.g., Epic In Basket message, secure message, phone call, fax). Supports communication audit and ACR compliance documentation.. Valid values are `in_basket|secure_message|phone|fax|ehr_alert|email`',
    `notification_status` STRING COMMENT 'Status of notification sent to the ordering provider regarding this addendum. not_required = no notification needed per policy; pending = notification queued; sent = notification dispatched; acknowledged = provider confirmed receipt; failed = notification delivery failed. Supports ACR communication compliance.. Valid values are `not_required|pending|sent|acknowledged|failed`',
    `original_report_finalized_datetime` TIMESTAMP COMMENT 'Date and time when the original radiology report was finalized prior to this addendum. Used to calculate turnaround time between original finalization and addendum, supporting quality metrics and ACR (American College of Radiology) benchmarking.',
    `peer_review_flag` BOOLEAN COMMENT 'Indicates whether this addendum was generated as a result of a formal peer review process (e.g., ACR RADPEER, internal quality review). True = peer review initiated; False = standard clinical addendum. Supports quality program analytics.',
    `peer_review_score` STRING COMMENT 'ACR RADPEER concordance score assigned during peer review, if applicable. Scale: 1 = agree with interpretation; 2a/2b = minor discrepancy; 3a/3b = significant discrepancy; 4 = major discrepancy. Nullable when peer_review_flag is False.. Valid values are `1|2a|2b|3a|3b|4`',
    `source_system_addendum_code` STRING COMMENT 'Native identifier of this addendum record in the originating operational system (e.g., Epic Radiant internal addendum ID, Cerner RadNet addendum key). Enables reconciliation between the lakehouse Silver Layer and the source RIS/EHR.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this addendum record was last modified in the data platform. Supports change detection and incremental ETL (Extract Transform Load) processing.',
    `voice_recognition_flag` BOOLEAN COMMENT 'Indicates whether this addendum was authored using voice recognition / speech-to-text dictation software (e.g., Nuance PowerScribe, Nuance DAX). True = voice recognition used; False = manually typed. Supports transcription error root cause analysis.',
    CONSTRAINT pk_report_addendum PRIMARY KEY(`report_addendum_id`)
) COMMENT 'Addendum to a finalized radiology report, capturing amendments, corrections, and peer review updates.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`modality` (
    `modality_id` BIGINT COMMENT 'Unique surrogate identifier for the imaging modality unit within the enterprise data platform. Primary key for the modality master reference entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the enterprise facility (hospital, clinic, imaging center) where this modality unit is physically deployed. Supports multi-site utilization analytics, capacity planning, and regulatory reporting by location.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Imaging equipment (CT, MRI, X-ray) are capital assets requiring linkage for depreciation calculation, asset lifecycle tracking, maintenance cost capitalization, and capital planning. Modality operatio',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: DICOM modalities connect to PACS/RIS via specific interface channels for modality worklist (MWL), MPPS, and image transmission. Links modality to its configured channel for troubleshooting connectivit',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Imaging modalities, especially radiation-emitting equipment, are governed by OSHA safety programs. Safety programs define modality-specific protocols for employee protection, calibration, and hazard m',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Radiology equipment has assigned primary operators/technologists for accountability, competency tracking, and maintenance coordination. Required for quality assurance programs and regulatory complianc',
    `acr_accreditation_expiration_date` DATE COMMENT 'Date on which the current American College of Radiology (ACR) accreditation for this modality unit expires. Null if not accredited or not applicable. Critical for maintaining Medicare billing eligibility for advanced imaging services.',
    `acr_accreditation_status` STRING COMMENT 'Current American College of Radiology (ACR) accreditation status for this imaging modality unit. ACR accreditation is required for Medicare reimbursement for advanced imaging services (CT, MRI, PET, nuclear medicine) under CMS policy. Drives billing eligibility and quality reporting.. Valid values are `accredited|provisional|denied|expired|not_applicable`',
    `ae_title` STRING COMMENT 'DICOM Application Entity (AE) title assigned to this modality unit, used for DICOM network communication, PACS routing, and worklist queries. Must be unique across the enterprise DICOM network. Configured in PACS and RIS for image routing and storage commitment.. Valid values are `^[A-Z0-9_-]{1,16}$`',
    `bore_diameter_cm` DECIMAL(18,2) COMMENT 'Inner diameter of the CT or MRI gantry bore in centimeters (e.g., 70 cm wide-bore MRI, 80 cm CT). Null for non-gantry equipment. Used for patient eligibility screening (claustrophobia, body habitus) and order routing to appropriate equipment.',
    `building_code` STRING COMMENT 'Facility building or wing code where the modality unit is located (e.g., MAIN, NORTH, MOB-A). Supports physical asset management, maintenance routing, and emergency response planning.',
    `contrast_capable` BOOLEAN COMMENT 'Indicates whether this modality unit is equipped and approved for contrast-enhanced imaging procedures. Drives protocol assignment, contrast administration workflow routing, and safety checklist requirements in the RIS and EHR order management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this modality unit record was first created in the enterprise data platform. Supports data lineage, audit trail requirements, and HIPAA Security Rule audit controls.',
    `decommission_date` DATE COMMENT 'Date the imaging modality unit was permanently retired from clinical service. Null for active equipment. Used for asset lifecycle management, capital planning, and historical utilization analysis.',
    `department_name` STRING COMMENT 'Name of the clinical department or imaging section within the facility where this modality unit is assigned (e.g., Radiology, Emergency Radiology, Cardiac Imaging, Breast Imaging Center). Used for departmental cost allocation and operational reporting.',
    `detector_type` STRING COMMENT 'Type of image detector technology used in the modality unit (e.g., Flat Panel, Curved Array, Photon Counting, CCD, Amorphous Silicon, Scintillator). Relevant for image quality benchmarking, protocol optimization, and ACR phantom testing requirements.',
    `dicom_modality_code` STRING COMMENT 'Standardized DICOM modality code as defined in DICOM PS3.3 (e.g., CT, MR, US, DX, PT, NM, MG, RF, XA). Used for PACS routing, DICOM worklist matching, and interoperability with imaging systems. Critical for HL7 and FHIR image exchange.. Valid values are `^[A-Z]{2,4}$`',
    `dose_tracking_enabled` BOOLEAN COMMENT 'Indicates whether automated radiation dose tracking and reporting is enabled for this modality unit, feeding the ACR Dose Index Registry (DIR) and enterprise dose management systems. Required for CMS quality reporting and MIPS measures related to radiation safety.',
    `equipment_type` STRING COMMENT 'Classification of the imaging modality by technology type, aligned with DICOM modality codes and ACR accreditation categories. Drives order routing rules, protocol assignment, and utilization reporting. [ENUM-REF-CANDIDATE: CT|MRI|X-ray|Ultrasound|PET-CT|PET|Fluoroscopy|Mammography|Nuclear Medicine|DEXA|Angiography — promote to reference product]',
    `fda_510k_number` STRING COMMENT 'FDA 510(k) premarket notification clearance number for this imaging device model, confirming substantial equivalence to a predicate device. Supports regulatory compliance documentation and procurement validation.. Valid values are `^K[0-9]{6}$`',
    `fda_registration_number` STRING COMMENT 'U.S. Food and Drug Administration (FDA) device establishment registration number assigned to this imaging equipment unit under 21 CFR Part 807. Required for regulatory compliance tracking and FDA inspection readiness.. Valid values are `^[0-9]{7}$`',
    `installation_date` DATE COMMENT 'Date the imaging modality unit was physically installed and commissioned at the facility. Used to calculate equipment age, depreciation schedules, warranty expiration, and capital replacement planning.',
    `is_mobile` BOOLEAN COMMENT 'Indicates whether this modality unit is a portable or mobile imaging device (True) that can be transported to patient care areas (e.g., portable X-ray, mobile ultrasound, mobile CT), versus a fixed-installation unit (False). Affects scheduling logic, location tracking, and utilization reporting.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration or quality control (QC) performance of the imaging modality unit. Required for ACR accreditation, state radiation control compliance, and Joint Commission equipment maintenance standards.',
    `last_preventive_maintenance_date` DATE COMMENT 'Date of the most recent scheduled preventive maintenance (PM) service performed on the modality unit by biomedical engineering or the manufacturers field service team. Supports Joint Commission equipment maintenance compliance and uptime tracking.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the imaging modality unit (e.g., Siemens Healthineers, GE Healthcare, Philips Healthcare, Canon Medical, Hologic). Used for vendor management, service contract tracking, and FDA device registration.',
    `max_patient_weight_kg` DECIMAL(18,2) COMMENT 'Maximum patient weight in kilograms that the modality units table or gantry is rated to support. Critical for bariatric patient scheduling, safety screening, and order routing to appropriate equipment. Drives clinical decision support alerts in the RIS and EHR.',
    `model_name` STRING COMMENT 'Manufacturer-assigned model name or product line designation for the imaging equipment unit (e.g., SOMATOM Force, MAGNETOM Vida, Revolution CT, Ingenia Elition). Used for service contract management, software upgrade tracking, and ACR accreditation documentation.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date by which the next calibration or quality control test must be completed to maintain regulatory compliance and accreditation status. Drives preventive maintenance scheduling and compliance alerts.',
    `next_preventive_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service on the modality unit. Used by biomedical engineering and facilities management for maintenance scheduling and Joint Commission compliance.',
    `operational_status` STRING COMMENT 'Current operational lifecycle status of the imaging modality unit. Drives scheduling availability, order routing eligibility, and equipment utilization reporting. active = available for clinical use; under_maintenance = temporarily unavailable; decommissioned = permanently retired from service.. Valid values are `active|inactive|under_maintenance|decommissioned|pending_installation`',
    `pacs_node_name` STRING COMMENT 'Name of the PACS (Picture Archiving and Communication System) storage node or archive destination configured for this modality unit. Defines the image routing path from the modality to the enterprise PACS for storage, retrieval, and radiologist interpretation.',
    `radiation_emitting` BOOLEAN COMMENT 'Indicates whether this imaging modality unit emits ionizing radiation (True = ionizing radiation, e.g., CT, X-ray, PET, fluoroscopy; False = non-ionizing, e.g., MRI, ultrasound). Drives radiation dose tracking requirements, state radiation control reporting, and ALARA compliance workflows.',
    `ris_resource_code` STRING COMMENT 'Identifier for this modality unit as configured in the source Radiology Information System (RIS) — Epic Radiant or Cerner RadNet. Used for system-of-record traceability, ETL reconciliation, and cross-system integration with scheduling and order management.',
    `room_identifier` STRING COMMENT 'Physical room or suite identifier within the facility where the modality unit is installed (e.g., Room 3, Suite B-102, MRI Suite 1). Used for scheduling, patient wayfinding, and facility management.',
    `scheduled_hours_per_day` DECIMAL(18,2) COMMENT 'Standard number of hours per day this modality unit is scheduled for clinical operations. Used as the denominator for equipment utilization rate calculations, capacity planning, and staffing models in radiology operations analytics.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical imaging equipment unit. Required for FDA device registration, warranty tracking, service contract management, and ACR accreditation. Stored as confidential due to its role in device security and regulatory compliance.',
    `service_contract_expiration_date` DATE COMMENT 'Date on which the current service and maintenance contract for this modality unit expires. Drives contract renewal alerts and procurement planning to ensure continuous coverage and Joint Commission compliance.',
    `service_contract_number` STRING COMMENT 'Identifier for the active service and maintenance contract covering this imaging modality unit. Links to the vendor service agreement in the procurement system. Used for service dispatch, cost tracking, and contract renewal management.',
    `shared_service_indicator` BOOLEAN COMMENT 'Indicates whether this modality unit is shared across multiple departments, facilities, or service lines (True) versus dedicated to a single department (False). Relevant for cost allocation, scheduling priority rules, and utilization analytics in multi-entity health systems.',
    `slice_count` STRING COMMENT 'Number of detector rows or slices for CT modality units (e.g., 16, 64, 128, 256, 320). Null for non-CT equipment. Determines CT protocol capabilities, scan speed, and clinical application eligibility (e.g., cardiac CT requires ≥64 slices). Used in equipment utilization and capability reporting.',
    `software_version` STRING COMMENT 'Current installed software or firmware version on the imaging modality unit. Critical for cybersecurity patch management, FDA software as a medical device (SaMD) compliance, and protocol compatibility with PACS and RIS systems.',
    `tesla_field_strength` DECIMAL(18,2) COMMENT 'Magnetic field strength in Tesla (T) for MRI modality units (e.g., 1.5, 3.0, 7.0). Null for non-MRI equipment. Determines MRI safety zone classifications, implant screening requirements, and protocol capabilities. Required for ACR MRI accreditation documentation.',
    `unit_code` STRING COMMENT 'Facility-assigned alphanumeric code uniquely identifying this imaging equipment unit within the enterprise. Used as the operational business identifier in RIS scheduling, order routing, and PACS integration (e.g., CT01, MRI-3T-02). Corresponds to the equipment code in Epic Radiant and Cerner RadNet.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `unit_name` STRING COMMENT 'Human-readable display name for the imaging modality unit as it appears in scheduling systems, worklists, and operational dashboards (e.g., Main Campus CT Scanner 1, North Wing 3T MRI). Used by technologists and schedulers to identify equipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this modality unit record in the enterprise data platform. Supports change data capture (CDC), ETL incremental load processing, and audit trail requirements under HIPAA Security Rule.',
    CONSTRAINT pk_modality PRIMARY KEY(`modality_id`)
) COMMENT 'Imaging modality equipment record tracking device specifications, maintenance, and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`protocol` (
    `protocol_id` BIGINT COMMENT 'Primary key for protocol',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Imaging protocols operationalize compliance policies for radiation safety, contrast administration, and clinical appropriateness. Policies mandate protocol standards; protocols reference governing pol',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Imaging protocols define standard contrast agents for specific exam types. FK to drug_master ensures protocol-formulary alignment, supports automated order validation, and enables protocol updates whe',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Imaging protocols must align with payer coverage policies to ensure medical necessity compliance. Protocol selection at order time requires validation against applicable coverage determination criteri',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Imaging protocols are mapped to CPT codes to standardize procedure ordering, support charge capture automation, and enable protocol-to-billing reconciliation. Essential for revenue cycle optimization ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Imaging protocols authored by radiologists or medical physicists require creator tracking for audit trail, version control, and regulatory compliance. Distinct from approving_clinician_id which captur',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Protocols reference LOINC codes for interoperable procedure identification in HL7 messages, support standardized order entry, and enable cross-facility protocol comparison for quality benchmarking.',
    `parent_protocol_id` BIGINT COMMENT 'Reference to the imaging_protocol_id of the parent protocol from which this protocol was derived or branched (e.g., a pediatric variant derived from an adult protocol). Supports protocol hierarchy and variant management within the Radiant protocol library.',
    `primary_superseded_by_protocol_id` BIGINT COMMENT 'Reference to the imaging_protocol_id of the newer protocol version that replaced this one upon retirement. Enables forward navigation through protocol version history and ensures continuity of care documentation.',
    `acr_appropriateness_rating` STRING COMMENT 'American College of Radiology (ACR) Appropriateness Criteria rating for this protocol-indication combination. Used for clinical decision support, prior authorization, and CMS Appropriate Use Criteria (AUC) compliance reporting under PAMA.. Valid values are `usually_appropriate|may_be_appropriate|usually_not_appropriate`',
    `approval_date` DATE COMMENT 'Date on which the approving radiologist formally approved this protocol version for clinical use. Marks the transition from draft to active status and is used for audit trails and regulatory compliance documentation.',
    `body_part` STRING COMMENT 'Anatomical region or body part targeted by this imaging protocol (e.g., Brain, Chest, Abdomen and Pelvis, Lumbar Spine). Corresponds to the DICOM Body Part Examined attribute and SNOMED CT anatomical site codes. Used for protocol selection and PACS routing.',
    `protocol_category` STRING COMMENT 'Clinical category classifying the purpose of this imaging protocol. diagnostic for standard clinical workup, screening for population health programs (e.g., lung cancer screening), interventional for image-guided procedures, research for IRB-approved studies, emergency for ED/trauma protocols, pediatric for age-specific protocols.. Valid values are `diagnostic|screening|interventional|research|emergency|pediatric`',
    `clinical_indication` STRING COMMENT 'The clinical reason or diagnostic question driving the imaging order for which this protocol is designed (e.g., Pulmonary Embolism Rule-Out, Abdominal Pain, Stroke Workup). Maps to ICD-10 diagnosis categories and supports appropriateness criteria evaluation.',
    `protocol_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the protocol within the Radiology Information System (RIS), such as Epic Radiant or Cerner RadNet. Used for order mapping, PACS integration, and cross-system reference.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `contrast_dose_ml` DECIMAL(18,2) COMMENT 'Standard contrast agent dose in milliliters specified for this protocol. May be weight-based (documented separately in patient preparation instructions) or fixed volume. Used for pharmacy preparation and contrast utilization tracking.',
    `contrast_flow_rate_ml_per_sec` DECIMAL(18,2) COMMENT 'Injection flow rate for intravenous contrast in milliliters per second as specified in the protocol. Critical for CT angiography and dynamic phase imaging to achieve optimal vascular enhancement. Null for non-IV contrast protocols.',
    `contrast_required` BOOLEAN COMMENT 'Indicates whether intravenous or oral contrast administration is required for this protocol. True = contrast is required; False = non-contrast study. Drives pre-procedure screening for contrast allergies, renal function checks, and pharmacy preparation.',
    `contrast_route` STRING COMMENT 'Route of administration for the contrast agent specified in this protocol (e.g., intravenous for CT angiography, oral for GI studies, intrathecal for myelography). Drives nursing preparation and patient consent requirements.. Valid values are `intravenous|oral|rectal|intrathecal|intra_articular|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol record was first created in the radiology data platform. Used for audit trail, data lineage, and compliance with HIPAA record retention requirements.',
    `dose_optimization_program` STRING COMMENT 'Radiation dose optimization program under which this protocol was designed or benchmarked. image_gently for pediatric dose reduction, image_wisely for adult dose reduction, acr_dir for ACR Dose Index Registry benchmarking. Supports regulatory reporting and quality improvement programs.. Valid values are `image_gently|image_wisely|acr_dir|none`',
    `effective_date` DATE COMMENT 'Date from which this protocol version becomes effective and available for clinical use in the RIS. May differ from approval_date if a future activation date is set. Used for version control and ensuring technologists use the current protocol.',
    `fasting_duration_hours` STRING COMMENT 'Required fasting duration in hours prior to the examination when fasting_required is True (e.g., 4 hours for contrast CT, 6 hours for PET-CT). Null when fasting is not required.',
    `fasting_required` BOOLEAN COMMENT 'Indicates whether the patient must fast (NPO) prior to this imaging examination. True = fasting required; False = no fasting required. Drives pre-procedure patient instructions and scheduling communication.',
    `field_of_view_mm` DECIMAL(18,2) COMMENT 'Field of view in millimeters defining the anatomical coverage area for image reconstruction. Determines spatial resolution and the extent of anatomy captured in the image matrix. Applicable to CT and MRI protocols.',
    `implant_screening_required` BOOLEAN COMMENT 'Indicates whether MRI implant safety screening is required before performing this protocol. True = screening required (applicable to all MRI protocols); False = not required. Drives pre-procedure safety questionnaire workflows to identify contraindicated implants, pacemakers, or metallic foreign bodies.',
    `kvp` STRING COMMENT 'Peak kilovoltage (kVp) setting for the X-ray tube as specified in this protocol. Determines X-ray beam energy and affects image contrast and patient radiation dose. Applicable to CT, X-ray, and fluoroscopy modalities. Null for MRI and ultrasound.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol record was most recently modified in the radiology data platform. Used for change tracking, audit trails, and incremental data pipeline processing in the Databricks Silver layer.',
    `magnetic_field_strength_tesla` DECIMAL(18,2) COMMENT 'Magnetic field strength in Tesla for MRI protocols (e.g., 1.5T, 3.0T, 7.0T). Determines scanner compatibility, image quality characteristics, and specific absorption rate (SAR) limits. Null for non-MRI modalities.',
    `mas` DECIMAL(18,2) COMMENT 'Milliampere-seconds (mAs) setting specifying the X-ray tube current-time product for this protocol. Directly influences image noise and patient radiation dose. Used in CT and radiography protocols. Null for MRI and ultrasound.',
    `modality_type` STRING COMMENT 'DICOM-standard imaging modality code for which this protocol is defined (e.g., CT = Computed Tomography, MRI = Magnetic Resonance Imaging, XR = X-Ray, US = Ultrasound, PET = Positron Emission Tomography, NM = Nuclear Medicine, MG = Mammography). Drives scheduling to the correct equipment and technologist skill set. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DX|PT — 10 candidates stripped; promote to reference product]',
    `protocol_name` STRING COMMENT 'Human-readable name of the imaging acquisition protocol as displayed in the RIS and PACS worklist (e.g., CT Abdomen Pelvis with Contrast, MRI Brain without Contrast). Used by technologists and radiologists to identify the correct acquisition procedure.',
    `pacs_routing_code` STRING COMMENT 'Code used to route completed images to the correct reading worklist, hanging protocol, and storage location within the Picture Archiving and Communication System (PACS). Ensures images are delivered to the appropriate radiologist subspecialty queue for interpretation.',
    `patient_population` STRING COMMENT 'Target patient population for which this protocol is designed. Drives protocol selection logic in the RIS based on patient age and clinical context. Pediatric and neonatal protocols use weight-based dosing and modified acquisition parameters.. Valid values are `adult|pediatric|neonatal|geriatric|obstetric|all`',
    `patient_prep_instructions` STRING COMMENT 'Standardized patient preparation instructions for this protocol, including fasting requirements (e.g., NPO 4 hours), hydration instructions, medication holds (e.g., hold Metformin for contrast studies), bowel preparation, and breath-hold coaching. Displayed to scheduling staff and communicated to patients prior to the exam.',
    `pitch_factor` DECIMAL(18,2) COMMENT 'Helical pitch factor for CT protocols, defined as table feed per rotation divided by total collimation. Values less than 1.0 indicate overlapping acquisitions (higher dose, better quality); values greater than 1.0 indicate faster coverage with lower dose. Null for non-helical CT and other modalities.',
    `protocol_status` STRING COMMENT 'Current lifecycle status of the imaging protocol. active indicates the protocol is approved and available for use; draft indicates pending approval; retired indicates superseded by a newer version; under_review indicates undergoing clinical review.. Valid values are `active|inactive|draft|retired|under_review`',
    `pulse_sequence_type` STRING COMMENT 'MRI pulse sequence type used in this protocol (e.g., T1 SE, T2 FSE, FLAIR, DWI, GRE, SSFP, EPI). Defines the fundamental MRI acquisition technique and determines tissue contrast characteristics. Null for non-MRI modalities.',
    `radiation_dose_ctdi_vol_mgy` DECIMAL(18,2) COMMENT 'Reference CT Dose Index Volume (CTDIvol) in milligray representing the average radiation dose within the scan volume for this CT protocol. Standardized metric for comparing dose across CT scanners and protocols. Reported to ACR Dose Index Registry and used for DRL benchmarking.',
    `radiation_dose_dlp_mgy_cm` DECIMAL(18,2) COMMENT 'Reference Dose Length Product (DLP) in milligray-centimeters representing the expected radiation dose for this CT protocol under standard conditions. Used for radiation dose optimization programs, comparison against Diagnostic Reference Levels (DRLs), and regulatory reporting to CMS and ACR Dose Index Registry.',
    `radlex_code` STRING COMMENT 'RSNA RadLex ontology code for the imaging procedure or anatomy associated with this protocol (e.g., RID10321 for CT of abdomen). Supports standardized terminology in radiology reporting, PACS integration, and research data aggregation.. Valid values are `^RIDd+$`',
    `reconstruction_algorithm` STRING COMMENT 'Image reconstruction algorithm specified for this protocol (e.g., Filtered Back Projection, Iterative Reconstruction, Deep Learning Reconstruction, ASIR-V 40%). Affects image quality, noise characteristics, and radiation dose efficiency. Vendor-specific algorithm names are stored as-is.',
    `renal_function_check_required` BOOLEAN COMMENT 'Indicates whether pre-procedure renal function assessment (eGFR/creatinine) is required before administering contrast for this protocol. True = renal check required (standard for iodinated and gadolinium contrast protocols); False = not required. Drives lab order triggers in Epic Radiant.',
    `retirement_date` DATE COMMENT 'Date on which this protocol version was retired or superseded by a newer version. Null for currently active protocols. Used for version lifecycle management and historical audit trails.',
    `ris_procedure_code` STRING COMMENT 'Internal procedure code assigned to this protocol within the Radiology Information System (RIS), such as Epic Radiant or Cerner RadNet. Used for order entry mapping, scheduling, and charge capture integration with the CDM.',
    `scan_duration_estimate_sec` STRING COMMENT 'Estimated acquisition time in seconds for this protocol under standard conditions. Used for scheduling slot allocation in the RIS, patient throughput planning, and breath-hold instruction timing for chest and abdominal studies.',
    `sedation_required` BOOLEAN COMMENT 'Indicates whether procedural sedation or anesthesia is required or commonly needed for this protocol (e.g., pediatric MRI, claustrophobic patients). True = sedation required; False = no sedation required. Triggers anesthesia scheduling and pre-sedation assessment workflows.',
    `slice_thickness_mm` DECIMAL(18,2) COMMENT 'Nominal slice thickness in millimeters for cross-sectional imaging protocols (CT, MRI). Thinner slices provide higher spatial resolution for small structure evaluation; thicker slices reduce noise and radiation dose. Null for planar modalities.',
    `total_exam_duration_min` STRING COMMENT 'Total estimated examination time in minutes including patient preparation, positioning, scanning, and post-processing. Used for scheduling block allocation in the RIS and patient appointment communication. Distinct from scan_duration_estimate_sec which covers acquisition only.',
    `version` STRING COMMENT 'Version number of the protocol definition following semantic versioning (e.g., 1.0, 2.3, 3.1.2). Enables tracking of protocol revisions over time and ensures technologists are using the current approved version.. Valid values are `^d+.d+(.d+)?$`',
    CONSTRAINT pk_protocol PRIMARY KEY(`protocol_id`)
) COMMENT 'Radiology imaging protocol defining acquisition parameters, contrast requirements, and patient preparation instructions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` (
    `contrast_admin_id` BIGINT COMMENT 'Primary key for contrast_admin',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (nurse, radiologic technologist, or radiologist) who administered the contrast agent. Used for accountability and adverse event tracking.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Contrast administration must link to clinical orders for medication reconciliation workflows. Clinical decision support for contrast allergy screening requires full order context including patient all',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Contrast administration records must link to material master for non-pharmacy contrast agents, enabling lot tracking, expiration management, and FDA recall response. Critical for patient safety when c',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who received the contrast agent. Links to the Master Patient Index (MPI) record. Protected Health Information (PHI) under HIPAA.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Contrast agents are medications managed in pharmacy formulary. Currently has agent_name and ndc_code as text. FK to drug_master normalizes contrast agent data, enables allergy checking, formulary mana',
    `equipment_asset_id` BIGINT COMMENT 'The asset or serial identifier of the power injector device used for contrast administration. Supports medical device tracking, maintenance scheduling, and adverse event investigation.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order that triggered this contrast administration event. Links to the radiology order in Epic Radiant or Cerner RadNet.',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: Contrast administration follows a defined imaging protocol that specifies contrast requirements (contrast_dose_ml, contrast_route, etc. on protocol). contrast_admin has a free-text contrast_protocol_n',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Contrast agents are pharmaceutical products identified by NDC for medication administration records, adverse event tracking, inventory management, and pharmacy billing. Essential for drug safety surve',
    `osha_exposure_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_exposure_incident. Business justification: Contrast extravasation or allergic reactions involving employee exposure are OSHA-recordable incidents. Safety office tracks which contrast administrations resulted in employee injuries or exposures r',
    `radiology_study_id` BIGINT COMMENT 'Reference to the imaging study (DICOM study) with which this contrast administration is associated. Supports PACS integration and study-level traceability.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Contrast administration to research subjects requires tracking for adverse event monitoring, safety reporting, and protocol compliance. Contrast reactions are reportable adverse events. Linkage enable',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Contrast administration protocols mandate recent eGFR/creatinine results to assess contrast-induced nephropathy risk. ACR guidelines require documented renal function within specific timeframes. Direc',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Contrast agent administration requires specific informed consent due to allergy/anaphylaxis risks, renal function considerations, and potential adverse reactions. Standard of care requirement. Links c',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the contrast was administered. Supports revenue cycle and clinical documentation linkage.',
    `accession_number` STRING COMMENT 'The Radiology Information System (RIS) accession number assigned to the imaging order. Serves as the primary business identifier linking the contrast event to the RIS workflow in Epic Radiant and Cerner RadNet.',
    `administering_clinician_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the clinician who administered the contrast agent. Required for regulatory reporting, billing, and provider accountability tracking.. Valid values are `^d{10}$`',
    `administration_datetime` TIMESTAMP COMMENT 'The precise date and time at which the contrast agent was administered to the patient. This is the principal real-world event timestamp for this transaction, distinct from record audit timestamps.',
    `administration_status` STRING COMMENT 'Current lifecycle status of the contrast administration event, aligned with HL7 FHIR MedicationAdministration status codes. not-done indicates contrast was withheld after screening.. Valid values are `completed|in-progress|not-done|on-hold|stopped|entered-in-error`',
    `adverse_reaction_datetime` TIMESTAMP COMMENT 'The date and time at which the adverse reaction was first observed following contrast administration. Used to calculate time-to-reaction interval for safety analytics.',
    `adverse_reaction_description` STRING COMMENT 'Detailed clinical description of the adverse reaction signs and symptoms observed following contrast administration (e.g., urticaria on trunk and arms, resolved with diphenhydramine). Required for FDA MedWatch and internal safety reporting.',
    `adverse_reaction_occurred` BOOLEAN COMMENT 'Indicates whether the patient experienced an adverse reaction following contrast administration (True = reaction occurred, False = no reaction). Triggers mandatory documentation and reporting workflows.',
    `adverse_reaction_severity` STRING COMMENT 'Severity classification of the adverse reaction experienced by the patient following contrast administration, per ACR grading criteria. Drives escalation protocols and mandatory reporting thresholds.. Valid values are `mild|moderate|severe|life-threatening`',
    `adverse_reaction_treatment` STRING COMMENT 'Description of the clinical interventions performed to treat the adverse contrast reaction (e.g., epinephrine 0.3mg IM, oxygen 4L/min via nasal cannula, IV fluid bolus). Supports quality review and safety reporting.',
    `agent_class` STRING COMMENT 'Classification of the contrast agent by chemical class. Drives safety screening protocols (e.g., gadolinium retention monitoring, iodine allergy screening) and ACR guideline compliance.. Valid values are `iodinated|gadolinium-based|barium|microbubble|manganese-based|iron-based`',
    `agent_osmolality_type` STRING COMMENT 'Osmolality classification of the iodinated contrast agent (low, iso, or high osmolality). Relevant for patient safety risk stratification, particularly in patients with renal impairment.. Valid values are `low-osmolality|iso-osmolality|high-osmolality`',
    `body_region` STRING COMMENT 'The anatomical body region being imaged (e.g., abdomen/pelvis, brain, chest, spine). Used for contrast protocol selection and population health analytics.',
    `catheter_gauge` STRING COMMENT 'The gauge size of the intravenous catheter used for contrast injection (e.g., 18G, 20G, 22G). Relevant for power injector safety limits and extravasation risk assessment.',
    `concentration_mg_per_ml` DECIMAL(18,2) COMMENT 'The concentration of the contrast agent in the administered preparation, expressed in milligrams per milliliter (mg/mL). Used to verify dose calculations and product selection.',
    `contrast_allergy_screening_result` STRING COMMENT 'The result of the pre-administration contrast allergy screening assessment. Captures whether the patient has a documented prior contrast reaction, confirmed allergy, or no known allergy. Drives pre-medication decision.. Valid values are `no-allergy|prior-reaction|allergy-confirmed|screening-not-done|contraindicated`',
    `dose_amount_mg` DECIMAL(18,2) COMMENT 'The total mass of contrast agent administered, measured in milligrams (mg). Supports weight-based dosing verification and cumulative gadolinium/iodine exposure tracking.',
    `dose_volume_ml` DECIMAL(18,2) COMMENT 'The total volume of contrast agent administered, measured in milliliters (mL). Used for dose tracking, pharmacy reconciliation, and radiation/contrast safety monitoring.',
    `extravasation_occurred` BOOLEAN COMMENT 'Indicates whether contrast agent extravasation (leakage into surrounding tissue) occurred during injection (True = extravasation, False = no extravasation). Triggers wound care and incident reporting protocols.',
    `extravasation_volume_ml` DECIMAL(18,2) COMMENT 'Estimated volume of contrast agent that extravasated into surrounding tissue, in milliliters (mL). Used to guide clinical management and severity classification of the extravasation event.',
    `informed_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the patient prior to contrast administration (True = consent obtained, False = consent not obtained or waived). Required for regulatory compliance and risk management.',
    `injection_rate_ml_per_sec` DECIMAL(18,2) COMMENT 'The rate at which the contrast agent was injected, expressed in milliliters per second (mL/sec). Relevant for CT bolus timing, power injector programming, and adverse event analysis.',
    `injection_site` STRING COMMENT 'The anatomical site of contrast injection (e.g., right antecubital vein, left hand dorsal vein, lumbar intrathecal space). Supports extravasation tracking and adverse event documentation.',
    `metformin_held` BOOLEAN COMMENT 'Indicates whether metformin was held prior to or following contrast administration per ACR guidelines for patients with renal impairment (True = metformin held, False = not held or not applicable).',
    `modality` STRING COMMENT 'The imaging modality for which the contrast was administered (e.g., CT, MRI, Ultrasound, PET). Determines applicable ACR contrast guidelines and safety protocols. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|FLUORO|ANGIO — 8 candidates stripped; promote to reference product]',
    `patient_weight_kg` DECIMAL(18,2) COMMENT 'The patients body weight in kilograms (kg) recorded at the time of contrast administration. Used for weight-based dose calculation verification and contrast safety risk stratification.',
    `power_injector_used` BOOLEAN COMMENT 'Indicates whether a power injector device was used to administer the contrast agent (True) or manual hand injection was performed (False). Relevant for injection rate documentation and device safety tracking.',
    `pregnancy_status` STRING COMMENT 'The patients pregnancy status at the time of contrast administration screening. Required for contrast safety risk assessment and informed consent documentation per ACR guidelines.. Valid values are `not-pregnant|pregnant|unknown|not-applicable`',
    `premedication_details` STRING COMMENT 'Free-text or structured description of the pre-medication regimen administered (e.g., Prednisone 50mg PO x3 doses + Diphenhydramine 50mg IV). Supports clinical documentation and pharmacy reconciliation.',
    `premedication_given` BOOLEAN COMMENT 'Indicates whether pre-medication (e.g., corticosteroid prophylaxis) was administered prior to contrast injection to reduce the risk of allergic reaction (True = pre-medicated, False = not pre-medicated).',
    `prior_contrast_reaction_type` STRING COMMENT 'Description of the type of prior contrast reaction documented in the patients allergy history (e.g., urticaria, bronchospasm, anaphylaxis). Informs pre-medication protocol selection.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this contrast administration record was first created in the source system or ingested into the lakehouse Silver layer. Supports audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this contrast administration record was last modified in the source system or updated in the lakehouse Silver layer. Supports change tracking and audit compliance.',
    `route_of_administration` STRING COMMENT 'The anatomical route by which the contrast agent was delivered to the patient (e.g., intravenous, oral, intrathecal). Critical for adverse reaction risk assessment and clinical documentation.. Valid values are `intravenous|oral|intrathecal|intra-arterial|intraperitoneal|rectal`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating operational system (e.g., Epic Radiant administration event ID, Cerner RadNet medication administration ID). Supports ETL traceability and cross-system reconciliation.',
    `thyroid_disease_flag` BOOLEAN COMMENT 'Indicates whether the patient has a documented thyroid condition (e.g., hyperthyroidism, thyroid cancer) that may be relevant to iodinated contrast administration safety screening.',
    CONSTRAINT pk_contrast_admin PRIMARY KEY(`contrast_admin_id`)
) COMMENT 'Contrast agent administration record capturing dose, route, adverse reactions, and patient safety screening.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` (
    `dose_record_id` BIGINT COMMENT 'Primary key for dose_record',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or imaging center where the study was performed. Supports facility-level dose benchmarking, ACR DIR site-level reporting, and Joint Commission accreditation tracking.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Radiation dose records must be traceable to clinical orders for dose optimization programs and regulatory reporting to dose index registries. Quality assurance workflows validate appropriate imaging u',
    `imaging_order_id` BIGINT COMMENT 'Reference to the radiology order (CPOE) that initiated the imaging study. Links dose data to the clinical order for appropriateness review and order management workflows in Epic Radiant or Cerner RadNet.',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: dose_record currently has imaging_protocol_name: STRING (free-text field). Radiation dose records are tied to the acquisition protocol used, which determines expected dose ranges and DRL comparisons. ',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Radiation dose structured reports (RDSR) are transmitted via HL7 ORU or DICOM to dose registries (ACR DIR, state registries) for regulatory reporting and dose optimization programs. Message_log tracks',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: Dose is delivered by a specific scanner/modality (dose_record has scanner_manufacturer, scanner_model, scanner_station_name). Normalizing to modality_id ties dose to the equipment master for dose-by-d',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the radiation exposure. Links to the Master Patient Index (MPI) record for cumulative dose tracking and patient-level radiation safety monitoring per ALARA principle.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who ordered the imaging study. Used for utilization management, appropriateness criteria reporting, and CMS quality program compliance.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Radiation dose records link to CPT codes for dose-by-procedure benchmarking, ACR Dose Index Registry submissions, and radiation safety quality measures. Supports dose optimization program reporting.',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: Radiation dose records are submitted to state dose registries and ACR Dose Index Registry for public health surveillance and dose optimization programs. Links dose record to its public health submissi',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: A radiation dose record is captured per study (dose_record has study_instance_uid, study_date, accession_number). It currently links to imaging_order and protocol but not the study it measures. Direct',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Radiation dose tracking for research subjects is IRB-mandated for protocols involving imaging. Cumulative dose monitoring, safety reporting to IRBs and sponsors, and protocol-specified dose limits req',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Radiation dose records require medical physicist review for quality assurance and regulatory compliance (ACR, state regulations). Physicists may not have clinician_id if non-provider staff.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the imaging study and radiation exposure occurred. Supports revenue cycle linkage and clinical context for dose reporting.',
    `accession_number` STRING COMMENT 'Radiology Information System (RIS) accession number uniquely identifying the imaging order/study to which this dose record belongs. Primary business identifier linking dose data to the imaging study in Epic Radiant or Cerner RadNet.',
    `body_part_examined` STRING COMMENT 'DICOM-coded body part or anatomical region examined during the imaging study (e.g., CHEST, ABDOMEN, HEAD, PELVIS). Used for dose benchmarking by anatomy and ACR DIR stratification.',
    `contrast_administered` BOOLEAN COMMENT 'Indicates whether iodinated or gadolinium-based contrast agent was administered during the imaging study. True = contrast used; False = non-contrast study. Relevant for dose context, adverse event tracking, and clinical protocol classification.',
    `contrast_agent_type` STRING COMMENT 'Type of contrast agent administered during the imaging study. iodinated=CT/X-ray contrast; gadolinium=MRI contrast (tracked for nephrogenic systemic fibrosis risk); barium=GI fluoroscopy; none=no contrast. Used for clinical safety monitoring and protocol classification.. Valid values are `iodinated|gadolinium|barium|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dose record was first created in the source system or ingested into the lakehouse Silver layer. Supports audit trail, data lineage, and regulatory record retention requirements.',
    `ctdivol_mgy` DECIMAL(18,2) COMMENT 'Volume CT Dose Index (CTDIvol) in milligray (mGy) for CT studies. Represents the average radiation dose delivered within the scan volume for a single series or the entire study. Primary CT dose metric for ACR DIR benchmarking and dose alert thresholds per NCRP and FDA guidance.',
    `cumulative_dose_msv` DECIMAL(18,2) COMMENT 'Running cumulative effective dose in millisieverts (mSv) for this patient across all prior ionizing radiation imaging studies recorded in the system, including the current study. Supports ALARA principle compliance, radiation safety counseling, and identification of high-dose patients for clinical review.',
    `dap_gy_cm2` DECIMAL(18,2) COMMENT 'Dose Area Product (DAP) in Gy·cm² for fluoroscopy, X-ray angiography, and interventional radiology procedures. Measures total radiation energy delivered to the patient. Primary dose metric for fluoroscopic procedures per IEC 60601-2-43.',
    `dlp_mgy_cm` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm for CT studies. Represents the total radiation energy imparted along the scan length. Used with conversion coefficients to estimate effective dose and is the primary metric for ACR DIR CT dose reporting.',
    `dose_alert_flag` BOOLEAN COMMENT 'Indicates whether this study triggered a radiation dose alert based on institutional or regulatory thresholds (e.g., CTDIvol > alert level, fluoroscopy time > 30 min, RAK > 3 Gy). True = alert triggered; False = within normal limits. Supports Joint Commission radiation safety event reporting.',
    `dose_alert_threshold_type` STRING COMMENT 'The specific dose metric that triggered the dose alert, if applicable. Identifies which threshold was exceeded to support targeted clinical review and root cause analysis. not_triggered when dose_alert_flag is False. [ENUM-REF-CANDIDATE: ctdivol|dlp|dap|fluoroscopy_time|rak|effective_dose|not_triggered — 7 candidates stripped; promote to reference product]',
    `dose_alert_value` DECIMAL(18,2) COMMENT 'The numeric threshold value that was exceeded to trigger the dose alert, expressed in the unit of the triggering metric (mGy, mGy·cm, Gy·cm², seconds, or mSv). Supports audit trail for dose safety events.',
    `dose_record_status` STRING COMMENT 'Current lifecycle status of the radiation dose record. preliminary = dose data received but not yet reviewed; final = reviewed and confirmed; amended = corrected after finalization; corrected = technical correction applied; cancelled = study voided.. Valid values are `preliminary|final|amended|corrected|cancelled`',
    `dose_registry_submission_status` STRING COMMENT 'Status of submission of this dose record to the ACR Dose Index Registry (DIR). pending=queued for submission; submitted=transmitted to ACR DIR; accepted=confirmed by ACR DIR; rejected=rejected by ACR DIR (requires correction); not_required=procedure not in DIR scope.. Valid values are `pending|submitted|accepted|rejected|not_required`',
    `dose_registry_submission_timestamp` TIMESTAMP COMMENT 'Date and time when this dose record was submitted to the ACR Dose Index Registry (DIR) or other regulatory dose registry. Supports audit trail for regulatory compliance and CMS quality program reporting.',
    `drl_comparison_result` STRING COMMENT 'Result of comparing the study dose against the applicable national or institutional Diagnostic Reference Level (DRL). below_drl=dose is below the reference level (optimal); at_drl=dose equals reference level; above_drl=dose exceeds reference level (requires review); not_applicable=no DRL defined for this procedure.. Valid values are `below_drl|at_drl|above_drl|not_applicable`',
    `effective_dose_msv` DECIMAL(18,2) COMMENT 'Estimated effective dose in millisieverts (mSv) representing the stochastic risk-weighted whole-body equivalent dose. Derived from DLP × conversion coefficient (k-factor) for CT, or from DAP for fluoroscopy. Used for patient communication, cumulative dose tracking, and ALARA compliance.',
    `entrance_skin_dose_mgy` DECIMAL(18,2) COMMENT 'Entrance skin dose (ESD) in milligray (mGy) for radiographic and fluoroscopic procedures. Represents the absorbed dose at the skin entry point. Critical for radiation injury risk assessment and Joint Commission threshold monitoring.',
    `fluoroscopy_time_sec` DECIMAL(18,2) COMMENT 'Total fluoroscopy beam-on time in seconds for fluoroscopic and interventional procedures. Regulatory threshold monitoring metric; Joint Commission requires tracking and alerting when fluoroscopy time exceeds defined thresholds (e.g., 30 minutes cumulative).',
    `kvp` DECIMAL(18,2) COMMENT 'Peak kilovoltage (kVp) applied to the X-ray tube during the study. Represents the energy of the X-ray beam. Used for dose optimization, protocol review, and physics quality assurance.',
    `modality_type` STRING COMMENT 'DICOM modality code indicating the type of imaging equipment used. CT=Computed Tomography, FL=Fluoroscopy, NM=Nuclear Medicine, DX=Digital Radiography (X-ray), MG=Mammography, XA=X-Ray Angiography, RF=Radiofluoroscopy. Determines applicable dose metrics (CTDIvol/DLP for CT, DAP/fluoroscopy time for fluoroscopy). [ENUM-REF-CANDIDATE: CT|FL|NM|DX|MG|XA|RF|PT|SPECT — promote to reference product]',
    `number_of_exposures` STRING COMMENT 'Total count of individual X-ray exposures (radiographic frames or pulses) delivered during the study. Used for dose optimization analysis and comparison against diagnostic reference levels (DRLs).',
    `patient_age_at_study` STRING COMMENT 'Patient age in whole years at the time of the imaging study. Used for pediatric dose benchmarking (pediatric patients require lower dose protocols), age-stratified DRL comparisons, and ACR DIR age-group reporting. Derived at time of study to avoid recalculation.',
    `patient_size_cm` DECIMAL(18,2) COMMENT 'Patient effective diameter or water-equivalent diameter in centimeters, used for Size-Specific Dose Estimate (SSDE) calculation in CT. Derived from scout/localizer images or patient measurements. Required for AAPM TG-204 SSDE methodology.',
    `patient_weight_kg` DECIMAL(18,2) COMMENT 'Patient body weight in kilograms at the time of the imaging study. Used for size-specific dose estimate (SSDE) calculations for CT, weight-based protocol selection, and dose normalization for benchmarking.',
    `physicist_review_flag` BOOLEAN COMMENT 'Indicates whether this dose record has been flagged for or completed a review by a qualified medical physicist. True = physicist review required or completed; False = no physicist review needed. Triggered by dose alerts, unusual protocol deviations, or regulatory requirements.',
    `physicist_review_timestamp` TIMESTAMP COMMENT 'Date and time when the medical physicist completed the review of this dose record. Null if physicist_review_flag is False or review is pending. Supports compliance audit trail for Joint Commission radiation safety requirements.',
    `procedure_description` STRING COMMENT 'Human-readable description of the imaging procedure performed (e.g., CT Chest with Contrast, Fluoroscopic Guidance for Biopsy). Sourced from the Charge Description Master (CDM) or RIS procedure catalog.',
    `rdsr_uid` STRING COMMENT 'DICOM Radiation Dose Structured Report (RDSR) SOP Instance UID per IEC 61910 standard. Globally unique identifier for the structured dose report generated by the imaging modality. Used for PACS integration and ACR Dose Index Registry (DIR) submission.',
    `reference_air_kerma_mgy` DECIMAL(18,2) COMMENT 'Reference Air Kerma (RAK) in mGy for interventional fluoroscopy procedures. Measured at the interventional reference point (IRP) per IEC 60601-2-43. Used for radiation injury risk assessment and regulatory threshold compliance.',
    `ssde_mgy` DECIMAL(18,2) COMMENT 'Size-Specific Dose Estimate (SSDE) in mGy for CT studies, calculated per AAPM TG-204 methodology by applying a size-based conversion factor to CTDIvol. Provides a more accurate patient-specific dose estimate than CTDIvol alone. Used for pediatric dose optimization and ACR DIR advanced reporting.',
    `study_date` DATE COMMENT 'Calendar date on which the imaging study was performed. Principal business event date for dose record. Used for trending, regulatory reporting, and cumulative dose period calculations.',
    `study_instance_uid` STRING COMMENT 'DICOM Study Instance UID uniquely identifying the imaging study in the PACS (Picture Archiving and Communication System). Enables direct linkage between dose records and DICOM image metadata for audit and regulatory reporting.',
    `study_timestamp` TIMESTAMP COMMENT 'Precise date and time the imaging study was performed, including timezone offset. Used for intraday workflow analysis, dose alert timing, and RDSR correlation.',
    `tube_current_mas` DECIMAL(18,2) COMMENT 'X-ray tube current-time product in milliampere-seconds (mAs) for the study. Directly influences radiation dose output. Used for protocol optimization and dose benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this dose record was last modified in the source system or Silver layer. Used for incremental ETL processing, change data capture, and audit trail maintenance.',
    CONSTRAINT pk_dose_record PRIMARY KEY(`dose_record_id`)
) COMMENT 'Radiation dose record per study capturing CTDI, DLP, effective dose, and dose registry submission status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` (
    `radiology_appointment_id` BIGINT COMMENT 'Primary key for appointment',
    `radiology_scheduling_appointment_id` BIGINT COMMENT 'Unique identifier for the scheduled appointment. Primary key for the appointment record across all care settings and modalities.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Outpatient appointments administer vaccines, medications, and consumables requiring charge capture, inventory depletion tracking, and clinical documentation. Healthcare operations mandate linking admi',
    `appointment_type_id` BIGINT COMMENT 'FK to scheduling.appointment_type',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Appointments are scheduled as part of care plan execution; care plans drive visit frequency, type, and multidisciplinary coordination. Essential for chronic care management, care coordination billing,',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, outpatient imaging center, clinic) where the imaging appointment is scheduled to take place.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Appointments requiring prior authorization must link to the authorization record for verification at scheduling and check-in. Schedulers validate authorization status, approved units, and date ranges ',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Imaging appointments fulfill clinical orders. Scheduling workflows require linking appointments to orders for prep instruction delivery, authorization verification, and patient communication. Operatio',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient associated with this appointment. Links to the patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Appointments are scheduled for specific diagnoses that drive specialty routing, authorization requirements, and visit type determination. Essential for pre-visit planning and specialty access manageme',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Real-time eligibility verification at appointment booking confirms active coverage, copay amounts, and authorization requirements. Schedulers perform eligibility checks before confirming appointments ',
    `employee_id` BIGINT COMMENT 'Reference to the radiology technologist (RT) assigned to perform the imaging study for this appointment. Used for staffing, productivity tracking, and quality assurance.',
    `encounter_authorization_id` BIGINT COMMENT 'Unique identifier for the insurance authorization or pre-certification associated with this appointment, if required by the payer.',
    `health_plan_id` BIGINT COMMENT 'Reference to the patients active insurance plan at the time of the imaging appointment. Used for eligibility verification, pre-authorization, and revenue cycle management.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the radiology order (CPOE) that initiated this appointment. Enables traceability from scheduling back to the clinical order.',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Appointments must verify active enrollment status at scheduled date to prevent scheduling patients without coverage. Schedulers check enrollment effective/termination dates and PCP assignment requirem',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: A radiology appointment is scheduled on a specific modality resource (appointment has modality_type and books a modality room). Adding modality_id ties scheduling to the actual imaging device for util',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient receiving the imaging service. Serves as the PARTY_REFERENCE for this transaction, linking to the patient master record.',
    `network_affiliation_id` BIGINT COMMENT 'Foreign key linking to provider.network_affiliation. Business justification: Network status determines patient cost-sharing and appointment eligibility per payer contracts. Links appointment to specific network tier and panel status, enabling real-time verification of in-netwo',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Appointments require real-time insurance verification at booking. Schedulers validate payer eligibility, authorization requirements, and network status before confirming appointments. Payer determines',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who placed the imaging order that generated this appointment. Used for referral tracking, utilization management, and RVU attribution.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Appointments are scheduled for specific CPT-coded procedures to enable resource allocation, exam duration estimation, and scheduling template management. Links support capacity planning and utilizatio',
    `provider_payer_enrollment_id` BIGINT COMMENT 'Foreign key linking to provider.payer_enrollment. Business justification: Insurance verification at appointment scheduling requires active payer enrollment status to confirm provider is in-network and eligible to bill. Prevents scheduling with terminated enrollments, suppor',
    `radiology_clinician_id` BIGINT COMMENT 'Unique identifier for the primary provider scheduled to deliver care during this appointment.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Appointments carry diagnosis codes for prior authorization verification at scheduling time, support medical necessity screening, and enable diagnosis-based appointment prioritization for urgent condit',
    `room_id` BIGINT COMMENT 'Reference to the specific imaging room or scanner unit assigned for this appointment. Enables room-level utilization tracking, maintenance scheduling, and capacity management.',
    `radiology_room_id` BIGINT COMMENT 'Unique identifier for the specific exam room, procedure room, or virtual room assigned to this appointment.',
    `radiology_visit_reason_icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Visit reason codes require ICD-10 validation for clinical accuracy, insurance authorization, billing compliance, and quality reporting. Essential for appointment booking workflows and claim submission',
    `referral_order_id` BIGINT COMMENT 'Unique identifier for the clinical order that originated this appointment, if the appointment was scheduled to fulfill a provider order (e.g., referral, diagnostic order).',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Clinical trial visits are scheduled as regular appointments. Research coordinators book protocol-mandated study visits through the scheduling system, requiring direct linkage to track research vs. sta',
    `scheduling_appointment_id` BIGINT COMMENT 'Reference to the parent enterprise scheduling appointment record. Links this radiology-specific scheduling record to the general enterprise scheduling infrastructure.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research imaging appointments are scheduled per protocol visit schedules. Direct linkage to subject enrollment enables protocol compliance tracking, visit window adherence monitoring, and research bil',
    `tertiary_radiology_referring_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who referred the patient for this imaging study, which may differ from the ordering provider. Used for referral analytics, network management, and payer reporting.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit associated with this imaging appointment. Connects the radiology scheduling event to the broader patient visit context.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the clinical department or service line within the facility where the appointment is scheduled.',
    `accession_number` STRING COMMENT 'Unique identifier assigned by the Radiology Information System (RIS) to this imaging study appointment. Used as the primary cross-system identifier linking the RIS, PACS, and EHR for this imaging event. Conforms to DICOM accession number format.',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time the imaging procedure concluded. Combined with actual_start_datetime to compute actual procedure duration for throughput and capacity analytics.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time the imaging procedure began (patient on table / scan initiated). Used to measure schedule adherence, wait times, and operational efficiency.',
    `appointment_comment` STRING COMMENT 'Free-text clinical or operational notes associated with the imaging appointment (e.g., special patient needs, equipment requirements, interpreter needed, claustrophobia notes for MRI). Not intended for clinical documentation.',
    `appointment_number` STRING COMMENT 'Human-readable business identifier for the appointment, typically displayed to patients and staff. May follow facility-specific numbering conventions.',
    `appointment_status` STRING COMMENT 'Current workflow state of the radiology imaging appointment. Tracks the full lifecycle from initial scheduling through completion or cancellation. Aligns with IHE SWF appointment status codes.. Valid values are `scheduled|arrived|in_progress|completed|cancelled|no_show`',
    `appointment_type` STRING COMMENT 'Clinical classification of the imaging appointment indicating the urgency and purpose of the study. Drives scheduling priority, slot allocation, and workflow routing. [ENUM-REF-CANDIDATE: routine|urgent|stat|screening|follow_up|pre_op|research — promote to reference product if additional types are needed]',
    `arrival_timestamp` TIMESTAMP COMMENT 'The date and time when the patient physically arrived at the facility or joined the virtual waiting room for telehealth appointments.',
    `auth_status` STRING COMMENT 'Current status of the insurance pre-authorization for this imaging appointment. Drives scheduling holds, revenue cycle workflows, and denial management processes.. Valid values are `approved|pending|denied|not_required|expired`',
    `billing_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the appointment is eligible for billing based on completion status, documentation, and payer rules. Used by revenue cycle to determine billable encounters.',
    `body_part` STRING COMMENT 'The anatomical region or body part targeted by the imaging study (e.g., CHEST, ABDOMEN, BRAIN, KNEE). Aligns with DICOM Body Part Examined attribute and SNOMED CT anatomical terminology.',
    `booking_channel` STRING COMMENT 'The channel or interface through which the appointment was originally scheduled. Used for patient access analytics and channel optimization.. Valid values are `phone|online-portal|mobile-app|in-person|referral|system-generated`',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was originally created or booked in the scheduling system.',
    `cancellation_reason` STRING COMMENT 'The documented reason for appointment cancellation when appointment_status is cancelled. Used for operational analytics, capacity recovery, and patient access improvement initiatives.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code representing the cancellation reason category (e.g., patient request, provider unavailable, weather, no-show conversion).',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was cancelled. Null for non-cancelled appointments.',
    `cancelled_by` STRING COMMENT 'Indicates which party initiated the cancellation of the appointment.. Valid values are `patient|provider|facility|system`',
    `care_setting` STRING COMMENT 'The physical or virtual care environment where the appointment will take place. [ENUM-REF-CANDIDATE: outpatient|emergency|inpatient-consult|procedural|surgical|telehealth|home-health — 7 candidates stripped; promote to reference product]',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the patient checked in for the appointment, either at a kiosk, front desk, or via mobile check-in.',
    `clinical_indication` STRING COMMENT 'The clinical reason or indication for the imaging study as documented by the ordering provider. Contains PHI and is used for clinical decision support, ACR appropriateness criteria evaluation, and CDI.',
    `confirmation_status` STRING COMMENT 'Indicates whether the patient has confirmed their intent to attend the appointment. Separate from appointment status to track patient engagement.. Valid values are `pending|confirmed|declined|needs-action`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the patient confirmed the appointment, either through automated reminder response or manual confirmation.',
    `contrast_required` BOOLEAN COMMENT 'Indicates whether intravenous or oral contrast agent is required for this imaging study. Drives pre-appointment prep instructions, allergy screening, renal function checks, and contrast timing workflows.',
    `contrast_type` STRING COMMENT 'The route of contrast agent administration planned for this imaging study. Used for pre-procedure preparation, patient safety screening, and contrast administration documentation.. Valid values are `IV|oral|intrathecal|intra_articular|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this imaging appointment record was first created in the system. Serves as the audit creation timestamp for data lineage, compliance, and change tracking.',
    `duration_minutes` STRING COMMENT 'The planned duration of the appointment in minutes. Calculated from scheduled start and end times or set by appointment type template.',
    `end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the clinical encounter concluded and the patient was discharged from the appointment.',
    `insurance_verification_status` STRING COMMENT 'Indicates whether patient insurance eligibility and benefits have been verified for this appointment. Critical for revenue cycle and patient financial counseling.. Valid values are `verified|pending|failed|not-required|expired`',
    `insurance_verification_timestamp` TIMESTAMP COMMENT 'The date and time when insurance eligibility was last verified for this appointment.',
    `is_portable` BOOLEAN COMMENT 'Indicates whether the imaging study is to be performed at the patients bedside or location (portable) rather than in a dedicated imaging room. Affects equipment assignment and technologist dispatch.',
    `is_stat` BOOLEAN COMMENT 'Indicates whether this imaging appointment was ordered as STAT (immediate/urgent priority), requiring expedited scheduling and turnaround. Drives workflow prioritization in the RIS and PACS.',
    `laterality` STRING COMMENT 'Specifies the side of the body for the imaging study when applicable (left, right, bilateral). Critical for patient safety, correct-site imaging compliance, and DICOM metadata accuracy.. Valid values are `left|right|bilateral|not_applicable`',
    `modality_type` STRING COMMENT 'The type of imaging modality assigned for this appointment (e.g., CT, MRI, X-ray, Ultrasound, PET). Core radiology scheduling attribute that determines equipment, room, and technologist assignment. Uses DICOM modality codes. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DXA|DEXA — promote to reference product]',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the patient failed to attend the scheduled appointment without prior cancellation. Used for no-show tracking and patient access policies.',
    `no_show_reason` STRING COMMENT 'The documented reason the patient did not appear for the scheduled imaging appointment when appointment_status is no_show. Used for patient outreach, access analytics, and population health management.',
    `pacs_study_uid` STRING COMMENT 'The globally unique DICOM Study Instance UID assigned by the PACS for the imaging study associated with this appointment. Enables direct linkage between the scheduling record and the DICOM image archive.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `patient_device_type` STRING COMMENT 'The type of device the patient used to access the telehealth appointment (e.g., smartphone, tablet, desktop, laptop). Used for technical support and quality improvement.',
    `patient_location` STRING COMMENT 'The patients physical location at the time of the imaging appointment (e.g., inpatient unit/bed, ED bay, outpatient clinic, external). Used for transport coordination and portable imaging dispatch.',
    `prep_instructions` STRING COMMENT 'Specific pre-appointment preparation instructions communicated to the patient (e.g., NPO after midnight, bowel prep, hydration requirements, medication holds). Critical for imaging quality and patient safety.',
    `prior_auth_number` STRING COMMENT 'The pre-authorization or prior authorization reference number obtained from the patients insurance payer before the imaging study. Required for reimbursement and revenue cycle management. Null if authorization not required or not yet obtained.',
    `priority` STRING COMMENT 'Clinical urgency or priority level assigned to the appointment. Influences scheduling order and resource allocation.. Valid values are `routine|urgent|stat|elective|emergent`',
    `procedure_description` STRING COMMENT 'Human-readable description of the imaging procedure to be performed, corresponding to the CPT code. Used for patient communication, scheduling displays, and clinical documentation.',
    `provider_attestation_flag` BOOLEAN COMMENT 'Indicates whether the provider has attested that the telehealth visit met all clinical and regulatory requirements for billing and documentation. Required for telehealth reimbursement.',
    `radiation_dose_flag` BOOLEAN COMMENT 'Indicates whether radiation dose tracking is required for this imaging appointment (applicable to CT, fluoroscopy, nuclear medicine, and other ionizing radiation modalities). Drives dose monitoring workflows per ACR and Joint Commission requirements.',
    `reconciliation_source` STRING COMMENT 'SSOT reconciliation linkage column added by cross-domain dedup vibe.',
    `record_reference_code` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Appointments require consent verification before procedures. Schedulers and clinical staff verify consent status during booking and check-in workflows. Essential for regulatory compliance, patient saf',
    `reschedule_count` STRING COMMENT 'The number of times this imaging appointment has been rescheduled. Used to identify access barriers, patient compliance issues, and scheduling inefficiencies.',
    `ris_appointment_code` STRING COMMENT 'The native appointment identifier from the source Radiology Information System (RIS) such as Epic Radiant or Cerner RadNet. Used for cross-system reconciliation and ETL lineage tracking.',
    `roomed_timestamp` TIMESTAMP COMMENT 'The date and time when the patient was placed in an exam room or virtual consultation room and is ready to be seen by the provider.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the appointment is scheduled to occur.',
    `scheduled_duration_minutes` STRING COMMENT 'The planned duration of the imaging appointment in minutes as defined at time of scheduling. Drives modality slot blocking, throughput analysis, and schedule optimization.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The planned date and time the imaging appointment is expected to conclude. Used with scheduled_start_datetime to determine the reserved slot duration on the modality schedule.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to end, including timezone.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The planned date and time the imaging appointment is scheduled to begin. Serves as the principal business event timestamp for scheduling analytics, capacity planning, and patient communication.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to begin, including timezone.',
    `scheduling_source` STRING COMMENT 'The channel or source through which this imaging appointment was scheduled. Used for access analytics, referral management, and patient experience reporting.. Valid values are `provider_referral|patient_self|order_based|transfer|walk_in|portal`',
    `ssot_canonical_reference` STRING COMMENT 'Reference to the canonical SSOT record when this record is deprecated or merged',
    `ssot_reconciliation_status` STRING COMMENT 'Status indicating reconciliation state with related SSOT entity: ACTIVE, DEPRECATED, MERGED, SUPERSEDED',
    `start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the provider began the clinical encounter. May differ from scheduled start time.',
    `telehealth_access_code` STRING COMMENT 'The meeting ID, access code, or PIN required to join the telehealth session. Used for platforms that require separate authentication.',
    `telehealth_connection_status` STRING COMMENT 'Real-time or final status of the telehealth session connection. Tracks technical success of the virtual visit.. Valid values are `not-started|connected|disconnected|failed|completed`',
    `telehealth_platform` STRING COMMENT 'The technology platform or vendor used to conduct the virtual visit (e.g., Epic Video Visit, Zoom for Healthcare, Amwell, Doxy.me). Null for in-person appointments.',
    `telehealth_session_url` STRING COMMENT 'The unique web link or meeting URL provided to the patient and provider to join the virtual visit. Contains session-specific access credentials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this imaging appointment record was most recently modified. Used for incremental ETL processing, audit trails, and change data capture in the lakehouse pipeline.',
    `vibe_placeholder` STRING COMMENT '',
    `visit_modality` STRING COMMENT 'The mode of interaction for the appointment. Distinguishes traditional in-person visits from telehealth and asynchronous digital encounters.. Valid values are `in-person|video|phone|e-visit|asynchronous`',
    `visit_reason` STRING COMMENT 'Free-text or coded description of the clinical reason or chief complaint for the appointment as stated by the patient or referring provider.',
    `visit_reason_code` STRING COMMENT 'Standardized clinical code representing the reason for the visit. May use ICD-10, SNOMED CT, or internal reason code taxonomy.',
    CONSTRAINT pk_radiology_appointment PRIMARY KEY(`radiology_appointment_id`)
) COMMENT 'Radiology-specific appointment record linking imaging orders to scheduled resources and patient preparation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` (
    `reader_assignment_id` BIGINT COMMENT 'Primary key for reader_assignment',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, imaging center, outpatient clinic) where the imaging study was performed. Used for facility-level TAT reporting, worklist segmentation, and operational analytics.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Radiologist assignments track CPT codes for workload balancing by procedure complexity, RVU-based productivity measurement, and subspecialty matching. Essential for radiologist compensation and staffi',
    `clinician_id` BIGINT COMMENT 'Reference to the radiologist or reading provider assigned to interpret the imaging study. May reference an internal clinician or a teleradiology vendor reader.',
    `prior_assignment_reader_assignment_id` BIGINT COMMENT 'Reference to the previous reader_assignment record when this record represents a reassignment or second read. Enables chaining of assignment history for a single imaging study to support audit trails and TAT analysis.',
    `radiology_study_id` BIGINT COMMENT 'Reference to the imaging study (accession) to which this reader assignment applies. Links the assignment to the specific diagnostic imaging order and PACS study.',
    `report_id` BIGINT COMMENT 'Reference to the finalized radiology report generated as the output of this reader assignment. Links the assignment record to the report document in the RIS/PACS or clinical documentation system.',
    `stark_arrangement_id` BIGINT COMMENT 'Foreign key linking to compliance.stark_arrangement. Business justification: Radiologist reading assignments, especially teleradiology and overread arrangements, may involve Stark-regulated compensation. Compliance monitors whether assignment-based compensation meets fair mark',
    `teleradiology_case_id` BIGINT COMMENT 'Foreign key linking to radiology.teleradiology_case. Business justification: When a study read is routed to a teleradiology vendor (reader_assignment.is_teleradiology, teleradiology_vendor_name), the assignment references the teleradiology case handling it. No reverse FK from ',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit) associated with the imaging study being assigned for interpretation. Supports linkage to ADT and clinical context.',
    `accession_number` STRING COMMENT 'The RIS-assigned accession number uniquely identifying the imaging study within the radiology information system. Used as the primary business identifier for the study in Epic Radiant, Cerner RadNet, and PACS/DICOM workflows.',
    `addendum_flag` BOOLEAN COMMENT 'Indicates whether an addendum was appended to the original radiology report after initial signing. True if an addendum exists; False otherwise. Supports HIM audit trails and clinical documentation integrity.',
    `addendum_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent addendum was added to the radiology report. Populated only when addendum_flag is True. Used for HIM documentation tracking and clinical audit.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist was formally assigned to the imaging study. Serves as the start of the turnaround time (TAT) clock for SLA measurement. Stored in ISO 8601 format with timezone offset.',
    `assignment_source` STRING COMMENT 'Mechanism by which the radiologist was assigned to the study. Values: worklist_auto (RIS auto-assignment algorithm), manual (dispatcher or radiologist self-assignment), teleradiology_vendor (routed to external vendor), ai_routing (AI-assisted worklist routing), escalation (escalated from prior assignment). [ENUM-REF-CANDIDATE: worklist_auto|manual|teleradiology_vendor|ai_routing|escalation|stat_escalation|protocol_override — promote to reference product if values expand]. Valid values are `worklist_auto|manual|teleradiology_vendor|ai_routing|escalation`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the reader assignment. Values: assigned (radiologist notified, not yet started), in_progress (read actively underway), completed (report finalized), cancelled (assignment voided), reassigned (transferred to another reader), pending (awaiting routing confirmation).. Valid values are `assigned|in_progress|completed|cancelled|reassigned|pending`',
    `assignment_type` STRING COMMENT 'Classification of the reader assignment indicating the role of the radiologist relative to the study. Values: primary_read (initial interpretation), second_read (confirmatory read), peer_review (quality/audit read), overread (supervisory review), teleradiology (remote vendor read).. Valid values are `primary_read|second_read|peer_review|overread|teleradiology`',
    `body_part` STRING COMMENT 'Anatomical body part or region examined in the imaging study, as coded in the RIS/PACS. Used for subspecialty routing, worklist filtering, and subspecialty match validation. Aligns with SNOMED CT anatomical site codes.',
    `contrast_used` BOOLEAN COMMENT 'Indicates whether contrast agent was administered during the imaging study. True if contrast was used; False for non-contrast studies. Relevant for CPT code selection, billing, and clinical interpretation context.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the reader assignment record was first created in the RIS or data platform. Serves as the audit trail creation timestamp per HIPAA and TJC record-keeping requirements.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates whether the radiologist identified a critical or urgent finding during interpretation that requires immediate clinical communication per ACR and TJC standards. True if a critical finding was flagged; False otherwise. Drives critical result notification workflows.',
    `critical_finding_notified_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist or RIS system notified the ordering provider of a critical imaging finding. Required for TJC and ACR compliance documentation. Populated only when critical_finding_flag is True.',
    `dictation_method` STRING COMMENT 'Method used by the radiologist to generate the report for this assignment. Values: voice_recognition (real-time speech-to-text, e.g., Nuance PowerScribe), manual_transcription (transcriptionist-assisted), structured_reporting (form-based structured data entry), template (pre-built report template).. Valid values are `voice_recognition|manual_transcription|structured_reporting|template`',
    `image_count` STRING COMMENT 'Total number of DICOM image instances in the imaging study at the time of assignment. Used as a proxy for study complexity in radiologist workload and productivity analysis.',
    `is_teleradiology` BOOLEAN COMMENT 'Indicates whether this assignment was routed to an external teleradiology vendor rather than an internal radiologist. True for teleradiology assignments; False for internal reads. Drives vendor SLA tracking and billing differentiation.',
    `modality` STRING COMMENT 'The imaging modality of the study being assigned for interpretation. Standard DICOM modality codes: CT (Computed Tomography), MRI (Magnetic Resonance Imaging), XR/DX/CR (X-ray), US (Ultrasound), PET (Positron Emission Tomography), NM (Nuclear Medicine), MG (Mammography), FL (Fluoroscopy). [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DX|CR|DEXA|OT — promote to reference product]',
    `pacs_study_uid` STRING COMMENT 'The globally unique DICOM Study Instance UID used to identify and retrieve the imaging study in the PACS. Enables direct linkage between the RIS assignment record and the PACS image archive for worklist integration and image retrieval.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `peer_review_category` STRING COMMENT 'Categorical classification of the peer review outcome indicating the level of agreement or discrepancy between the primary read and the peer reviewers interpretation. Supports quality improvement programs and radiologist performance monitoring.. Valid values are `agree|minor_discrepancy|significant_discrepancy|major_discrepancy`',
    `peer_review_score` STRING COMMENT 'Radiologist peer review quality score assigned during a peer review or overread assignment. Typically uses the ACR RADPEER scoring scale (1=agree, 2=minor discrepancy, 3=significant discrepancy, 4=major discrepancy). Populated only for peer_review and overread assignment types.. Valid values are `1|2|3|4|5`',
    `priority` STRING COMMENT 'Clinical priority level assigned to the imaging study read, driving worklist ordering and SLA target selection. Values: stat (immediate, life-threatening), urgent (expedited, clinically time-sensitive), routine (standard queue), scheduled (pre-planned elective read).. Valid values are `stat|urgent|routine|scheduled`',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm recorded for CT studies, representing the total radiation dose delivered during the imaging acquisition. Used for radiation dose tracking, ACR Dose Index Registry reporting, and patient safety compliance.',
    `read_complete_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist completed the interpretation and the report was finalized or signed. Used as the end point for TAT SLA calculation.',
    `read_start_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist opened and began actively interpreting the imaging study in PACS or the RIS worklist. Used to measure time-to-read and radiologist productivity.',
    `reading_site` STRING COMMENT 'Physical or virtual location from which the radiologist performed the interpretation (e.g., on-site reading room, remote home workstation, teleradiology hub). Distinct from the imaging facility; captures where the read occurred.',
    `reassignment_reason` STRING COMMENT 'Free-text or coded reason why the study was reassigned from the originally assigned radiologist to another reader. Examples include radiologist unavailability, subspecialty escalation, conflict of interest, or workload rebalancing. Populated only when assignment_status is reassigned.',
    `report_signed_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist electronically signed and authenticated the final radiology report. Distinct from read_complete_timestamp as signing may occur after dictation/transcription. Supports HIM and compliance audit requirements.',
    `rvu_value` DECIMAL(18,2) COMMENT 'The total Relative Value Unit (RVU) assigned to the CPT code for this interpretation, sourced from the CMS Physician Fee Schedule. Used for radiologist productivity measurement, compensation modeling, and departmental workload reporting.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the reader assignment was completed within the applicable SLA target turnaround time. True if tat_minutes is less than or equal to sla_target_minutes; False otherwise. Supports SLA compliance dashboards and vendor performance management.',
    `sla_target_minutes` STRING COMMENT 'The contractual or operational SLA target turnaround time in minutes applicable to this assignment, based on study priority, modality, and assignment type. Sourced from the applicable SLA contract or internal policy at time of assignment.',
    `subspecialty_match` BOOLEAN COMMENT 'Indicates whether the assigned radiologists subspecialty certification matches the subspecialty required for the imaging study. True if matched; False if assigned outside subspecialty (e.g., general radiologist reading a neuroradiology study). Supports quality and credentialing compliance reporting.',
    `subspecialty_required` STRING COMMENT 'The radiologist subspecialty required to interpret this imaging study (e.g., neuroradiology, musculoskeletal, breast imaging, interventional, nuclear medicine). Drives subspecialty-based worklist routing and teleradiology vendor selection.',
    `tat_minutes` STRING COMMENT 'Calculated turnaround time in minutes from study assignment to report completion. Stored as a pre-computed operational field (not a KPI aggregate) to support SLA compliance monitoring and worklist management without requiring real-time computation.',
    `teleradiology_routing_reason` STRING COMMENT 'Business reason why the study was routed to a teleradiology vendor rather than read internally. Values: after_hours (no internal radiologist available), subspecialty_gap (required subspecialty not available internally), volume_overflow (worklist capacity exceeded), coverage_gap (scheduled radiologist absent), stat_backup (emergency backup coverage).. Valid values are `after_hours|subspecialty_gap|volume_overflow|coverage_gap|stat_backup`',
    `teleradiology_vendor_name` STRING COMMENT 'Name of the external teleradiology vendor to whom the study was routed for interpretation. Populated only when is_teleradiology is True. Used for vendor performance management and contract SLA tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the reader assignment record was most recently modified. Supports change data capture (CDC) in the Databricks Silver Layer ETL pipeline and audit trail requirements.',
    `vendor_accession_number` STRING COMMENT 'The accession number assigned by the teleradiology vendors RIS to the study. Used for cross-referencing the internal RIS accession number with the vendors system for report reconciliation and image retrieval.',
    `worklist_code` STRING COMMENT 'Identifier of the RIS worklist queue from which this assignment was generated or pulled. Used to trace the assignment back to its originating worklist configuration for routing audit and performance analysis.',
    CONSTRAINT pk_reader_assignment PRIMARY KEY(`reader_assignment_id`)
) COMMENT 'Assignment of a radiologist to read a specific study, tracking TAT, SLA compliance, and peer review outcomes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` (
    `critical_result_id` BIGINT COMMENT 'Primary key for critical_result',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or imaging center where the study was performed and the critical finding was identified. Supports multi-facility enterprise reporting and TJC accreditation tracking at the facility level.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Critical findings require closed-loop communication linking back to originating clinical orders. Joint Commission critical results notification standards require tracking from order placement through ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Critical findings are associated with procedure codes for quality tracking, Joint Commission compliance reporting, and critical result rate benchmarking by exam type. Supports patient safety analytics',
    `demographics_id` BIGINT COMMENT 'Reference to the patient associated with the imaging study containing the critical finding. Links to the enterprise Master Patient Index (MPI) record.',
    `employee_id` BIGINT COMMENT 'Reference to the radiologist who identified and reported the critical finding. Links to the provider/clinician master record for NPI resolution and accountability tracking.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the radiology imaging order that generated the critical finding. Links to the originating order in the RIS (Epic Radiant / Cerner RadNet).',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Critical radiology findings trigger mandatory HL7 ORU result messages to ordering providers and EHR systems for TJC compliance and patient safety. Message_log tracks notification delivery, acknowledgm',
    `org_unit_id` BIGINT COMMENT 'Reference to the radiology department or imaging section (e.g., neuroradiology, body imaging, emergency radiology) responsible for the study. Supports departmental quality reporting and workload analytics.',
    `clinician_id` BIGINT COMMENT 'Reference to the ordering or responsible provider who received the critical result notification. Required for TJC NPSG.02.03.01 compliance documentation of the notification recipient.',
    `radiology_finding_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_finding. Business justification: A critical result documents the urgent communication of a structured radiology finding (radiology_finding has is_critical_result flag). Linking critical_result to the underlying finding ties the notif',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: A critical result arises from a specific study (critical_result has dicom_study_uid). It currently links to imaging_order and report only; a direct study link supports critical findings notified befor',
    `report_id` BIGINT COMMENT 'Reference to the formal radiology report (final or preliminary) in which the critical finding was documented. Links to the radiology report data product for full diagnostic context and PACS/RIS integration.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Critical imaging findings in research subjects trigger adverse event reporting workflows to IRBs, sponsors, and data safety monitoring boards. Direct linkage enables automated AE capture, safety signa',
    `tertiary_critical_ordering_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who placed the original imaging order. May differ from the notified provider if the ordering provider is unavailable. Used for accountability tracking and notification workflow routing.',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit during which the imaging study was performed and the critical finding was identified. Supports EMTALA compliance tracking and care coordination.',
    `accession_number` STRING COMMENT 'The RIS-assigned accession number uniquely identifying the imaging order or study that produced the critical finding. Serves as the primary business identifier linking this notification to the originating radiology order in Epic Radiant or Cerner RadNet.',
    `acknowledgment_datetime` TIMESTAMP COMMENT 'The date and time when the notified provider acknowledged receipt and understanding of the critical finding. Required for TJC NPSG.02.03.01 closed-loop communication compliance. Null if acknowledgment has not yet been received.',
    `acknowledgment_method` STRING COMMENT 'The communication channel through which the notified provider acknowledged the critical finding. Required for TJC NPSG.02.03.01 closed-loop verification documentation. May differ from the notification method.. Valid values are `phone|secure_message|ehr_alert|pager|in_person|fax`',
    `acknowledgment_turnaround_minutes` STRING COMMENT 'The elapsed time in minutes between notification_datetime and acknowledgment_datetime. Measures provider responsiveness to critical finding notifications. Used for TJC NPSG.02.03.01 compliance measurement and provider performance analytics. Null if acknowledgment has not been received.',
    `body_part_examined` STRING COMMENT 'The anatomical body part or region examined in the imaging study that produced the critical finding. Aligns with DICOM Tag (0018,0015) and SNOMED CT anatomical site codes. Supports clinical analytics and quality reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this critical finding notification record was first created in the data platform. Supports audit trail, data lineage, and Silver layer ingestion tracking per HIPAA audit control requirements.',
    `dicom_study_uid` STRING COMMENT 'The globally unique DICOM Study Instance UID (0020,000D) identifying the imaging study in the PACS (Picture Archiving and Communication System). Enables direct linkage to DICOM images for clinical review and audit purposes.',
    `emtala_applicable` BOOLEAN COMMENT 'Indicates whether EMTALA obligations apply to this critical finding notification, typically when the patient presented through the Emergency Department. True = EMTALA applies; False = EMTALA not applicable. Supports EMTALA compliance documentation and legal risk management.',
    `escalation_datetime` TIMESTAMP COMMENT 'The date and time when the escalation process was initiated for this critical finding notification. Populated only when escalation_flag is True. Used to measure escalation response times and compliance with institutional escalation policies.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the critical finding notification required escalation due to failure to reach the primary responsible provider within the defined response time threshold. True = escalation was triggered; False = no escalation required. Supports TJC NPSG.02.03.01 compliance and patient safety event tracking.',
    `escalation_reason` STRING COMMENT 'The reason escalation was triggered for this critical finding notification: no_response (provider did not respond within threshold), provider_unavailable (provider not reachable), wrong_contact (incorrect contact information), system_failure (notification system failure), other. Supports root cause analysis and process improvement.. Valid values are `no_response|provider_unavailable|wrong_contact|system_failure|other`',
    `finding_category` STRING COMMENT 'Clinical category of the critical finding (e.g., pulmonary embolism, intracranial hemorrhage, pneumothorax, aortic dissection, malignancy, fracture). Supports population health analytics, quality reporting, and pattern analysis. [ENUM-REF-CANDIDATE: pulmonary_embolism|intracranial_hemorrhage|pneumothorax|aortic_dissection|malignancy|fracture|other — promote to reference product]',
    `finding_datetime` TIMESTAMP COMMENT 'The date and time when the radiologist identified and documented the critical finding during image interpretation. This is the principal business event timestamp representing when the critical result was discovered. Critical for measuring notification turnaround time against TJC NPSG.02.03.01 compliance thresholds.',
    `finding_description` STRING COMMENT 'Free-text clinical description of the critical or significant radiology finding requiring immediate action. Captured from the radiologists report or preliminary read in the RIS/PACS. Constitutes Protected Health Information (PHI) under HIPAA.',
    `finding_severity` STRING COMMENT 'Severity classification of the radiology finding: critical (life-threatening, requires immediate action), significant (clinically important, requires timely action), or incidental (unexpected finding not directly related to the primary indication). Drives notification urgency and escalation workflows per TJC NPSG.02.03.01.. Valid values are `critical|significant|incidental`',
    `modality` STRING COMMENT 'The imaging modality used for the study that produced the critical finding (e.g., CT=Computed Tomography, MRI=Magnetic Resonance Imaging, XR=X-Ray, US=Ultrasound, PET=Positron Emission Tomography, NM=Nuclear Medicine, MG=Mammography, FL=Fluoroscopy). Aligns with DICOM modality codes. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL — 8 candidates stripped; promote to reference product]',
    `mrn` STRING COMMENT 'The facility-assigned Medical Record Number (MRN) for the patient associated with the critical finding. Used for cross-system patient identification and audit trail in compliance with HIPAA PHI requirements.',
    `notification_attempt_count` STRING COMMENT 'The total number of notification attempts made before successful delivery or escalation. Tracks communication persistence and supports root cause analysis for notification failures and escalation triggers.',
    `notification_datetime` TIMESTAMP COMMENT 'The date and time when the critical finding notification was transmitted to the responsible provider. Used to calculate notification turnaround time (finding_datetime to notification_datetime) for TJC NPSG.02.03.01 compliance measurement.',
    `notification_method` STRING COMMENT 'The communication channel used to deliver the critical finding notification to the responsible provider (e.g., phone=direct telephone call, secure_message=encrypted messaging platform, ehr_alert=EHR in-basket alert, pager=numeric/alphanumeric pager, in_person=face-to-face, fax=facsimile). Aligns with HL7 FHIR CommunicationRequest.medium.. Valid values are `phone|secure_message|ehr_alert|pager|in_person|fax`',
    `notification_status` STRING COMMENT 'Current workflow status of the critical finding notification lifecycle: pending (finding identified, notification not yet sent), notified (notification sent, awaiting acknowledgment), acknowledged (provider confirmed receipt), escalated (escalation triggered due to non-response), failed (notification delivery failed), cancelled (notification voided). Drives workflow management and compliance dashboards.. Valid values are `pending|notified|acknowledged|escalated|failed|cancelled`',
    `notification_turnaround_minutes` STRING COMMENT 'The elapsed time in minutes between finding_datetime and notification_datetime. Represents the raw operational measurement of how quickly the critical finding was communicated after identification. Used for TJC NPSG.02.03.01 compliance measurement and quality dashboards. Note: this is a stored operational metric captured at notification time, not a real-time calculation.',
    `notified_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the provider who received the critical result notification. Directly supports TJC NPSG.02.03.01 documentation requirements for the receiving clinician.. Valid values are `^[0-9]{10}$`',
    `pacs_system_name` STRING COMMENT 'The name or identifier of the PACS system where the imaging study is archived (e.g., vendor name, system instance). Supports multi-PACS enterprise environments and image retrieval workflows.',
    `patient_care_setting` STRING COMMENT 'The care setting classification of the patient at the time of the critical finding notification: inpatient, outpatient, emergency (Emergency Department), observation, or ambulatory. Influences notification protocols, escalation pathways, and regulatory reporting requirements.. Valid values are `inpatient|outpatient|emergency|observation|ambulatory`',
    `patient_location_at_notification` STRING COMMENT 'The patients care location (unit, department, or facility) at the time the critical finding notification was issued (e.g., ED, ICU, outpatient clinic, inpatient floor). Supports EMTALA compliance, care coordination, and patient safety event analysis.',
    `patient_safety_event_flag` BOOLEAN COMMENT 'Indicates whether this critical finding notification has been associated with a formal patient safety event report (e.g., near-miss, adverse event). True = linked to a patient safety event; False = no patient safety event association. Supports OIG compliance, TJC accreditation, and AHRQ patient safety reporting.',
    `radiologist_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the radiologist who identified the critical finding. Required for regulatory reporting and provider accountability under CMS and TJC standards.. Valid values are `^[0-9]{10}$`',
    `read_back_notes` STRING COMMENT 'Free-text documentation of the read-back communication, including any discrepancies noted during the read-back process. Populated when read_back_performed is True. Supports TJC NPSG.02.03.01 closed-loop communication audit trail.',
    `read_back_performed` BOOLEAN COMMENT 'Indicates whether the notified provider performed a verbal read-back of the critical finding to confirm accurate communication, as required by TJC NPSG.02.03.01 for verbal/telephone notifications. True = read-back was performed and documented; False = read-back not performed or not applicable.',
    `report_status_at_notification` STRING COMMENT 'The status of the radiology report at the time the critical finding notification was issued: preliminary (initial read, not yet finalized), final (attending radiologist signed report), addendum (correction or addition to a finalized report). Important for clinical decision-making context and liability documentation.. Valid values are `preliminary|final|addendum`',
    `tjc_compliance_status` STRING COMMENT 'Indicates whether this critical finding notification meets The Joint Commission (TJC) National Patient Safety Goal NPSG.02.03.01 requirements for critical result communication: compliant (all requirements met), non_compliant (requirements not met, e.g., acknowledgment not received within threshold), pending_review (under quality review), exception_granted (documented exception approved). Directly supports TJC accreditation reporting.. Valid values are `compliant|non_compliant|pending_review|exception_granted`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this critical finding notification record was last modified in the data platform. Supports change tracking, audit trail, and incremental ETL processing per HIPAA audit control requirements.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_critical_result PRIMARY KEY(`critical_result_id`)
) COMMENT 'Critical radiology finding requiring immediate clinician notification, tracking communication and TJC compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` (
    `teleradiology_case_id` BIGINT COMMENT 'Unique surrogate identifier for the teleradiology case record in the lakehouse silver layer. Primary key for this entity.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: Teleradiology vendors are HIPAA business associates requiring executed BAAs. Compliance tracks which BAA governs each vendor relationship; teleradiology cases must reference the governing BAA for audi',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, clinic, or imaging center) from which the imaging study was transmitted to the teleradiology vendor. Used for facility-level SLA reporting and volume analytics.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Teleradiology cases require internal coordinators to manage vendor handoffs, image transmission, report reconciliation, and escalation. Distinct operational role from interpreting radiologist.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who placed the imaging order that triggered this teleradiology case. Used for provider-level utilization reporting and clinical communication of results.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Teleradiology cases are billed using CPT codes for vendor invoicing reconciliation, professional component billing, and contract compliance verification. Essential for teleradiology financial manageme',
    `demographics_id` BIGINT COMMENT 'Reference to the patient whose imaging study is being interpreted via teleradiology. Supports patient-level reporting and PHI governance.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the originating radiology order that triggered this teleradiology routing. Links the teleradiology case to the parent imaging order in the RIS.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Teleradiology DICOM transmissions (study send/receive) and HL7 result messages are logged for vendor SLA tracking, transmission success monitoring, and billing reconciliation. Message_log provides aud',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Teleradiology professional component billing responsibility and reimbursement rates are governed by specific payer contracts. Vendor_contract_id covers vendor relationship; payer_contract_id needed fo',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: A teleradiology case is for interpreting a specific study (case has dicom_study_uid, number_of_images, number_of_series). It links to imaging_order but not the study. Direct study FK is essential. No ',
    `stark_arrangement_id` BIGINT COMMENT 'Foreign key linking to compliance.stark_arrangement. Business justification: Teleradiology contracts often involve Stark-regulated physician compensation arrangements. Compliance reviews teleradiology case volume and compensation to ensure arrangements meet fair market value a',
    `vendor_contract_id` BIGINT COMMENT 'The contract or agreement identifier governing the teleradiology services provided by the vendor for this case. Used to associate the case with specific SLA terms, pricing schedules, and billing responsibility clauses.',
    `vendor_id` BIGINT COMMENT 'Reference to the teleradiology vendor or remote reading group to whom this study was routed. Links to the vendor master for contract and SLA management.',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit associated with this imaging study. Supports linkage to encounter-level clinical and billing context.',
    `accession_number` STRING COMMENT 'The RIS-assigned accession number that uniquely identifies the imaging study within the originating facility. Used to correlate the teleradiology case back to the local RIS/PACS order.',
    `actual_tat_minutes` STRING COMMENT 'The measured turnaround time in minutes from study transmission datetime to final report received datetime. Compared against expected_tat_minutes to determine SLA compliance status.',
    `billing_responsibility` STRING COMMENT 'Designates which party owns the professional component (PC) billing responsibility for the radiology interpretation: the teleradiology vendor, the originating facility, or a shared arrangement. Critical for revenue cycle management and claim submission.. Valid values are `vendor|facility|shared|not_applicable`',
    `body_part` STRING COMMENT 'The anatomical region or body part that is the subject of the imaging study, as coded in the DICOM header or RIS order. Used for subspecialty routing and procedure-level reporting.',
    `case_status` STRING COMMENT 'Current workflow status of the teleradiology case, tracking progression from transmission through final report reconciliation. [ENUM-REF-CANDIDATE: transmitted|received|in_interpretation|preliminary_reported|final_reported|reconciled|cancelled — promote to reference product]',
    `clinical_indication` STRING COMMENT 'Free-text or coded clinical indication or reason for the imaging study as documented in the radiology order. Provides clinical context to the remote radiologist and supports appropriateness criteria evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this teleradiology case record was first created in the system, typically coinciding with the routing decision. Audit trail field for data governance and lineage.',
    `critical_finding_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the teleradiology report contains a critical or urgent finding requiring immediate clinical notification per ACR and Joint Commission communication standards. Triggers critical results notification workflows.',
    `critical_finding_notified_datetime` TIMESTAMP COMMENT 'The date and time at which the ordering provider or clinical team was notified of a critical imaging finding. Required for Joint Commission NPSG compliance documentation. Null when critical_finding_flag is False.',
    `dicom_study_uid` STRING COMMENT 'The globally unique DICOM Study Instance UID (0020,000D) that identifies the imaging study across PACS systems. Used for PACS-to-PACS transmission tracking and image retrieval reconciliation.',
    `discrepancy_category` STRING COMMENT 'Classification of the reconciliation discrepancy severity when reconciliation_discrepancy_flag is True. Major discrepancies represent clinically significant differences that may affect patient management; minor discrepancies are interpretive differences without clinical impact.. Valid values are `major|minor|none`',
    `expected_tat_minutes` STRING COMMENT 'The contractually agreed or SLA-defined turnaround time (TAT) in minutes from study transmission to final report delivery, as specified in the vendor contract for the applicable priority level and modality.',
    `final_report_datetime` TIMESTAMP COMMENT 'The date and time at which the final, authenticated radiology report was received from the teleradiology vendor. Used to measure final TAT compliance and trigger report reconciliation workflows.',
    `final_report_text` STRING COMMENT 'The verbatim text of the final, authenticated radiology report received from the teleradiology vendor. Contains PHI and the definitive radiological interpretation. Used for clinical decision-making, reconciliation, and medical record documentation.',
    `interpretation_start_datetime` TIMESTAMP COMMENT 'The date and time at which the remote radiologist began active interpretation of the imaging study. Used to measure reading time and identify workflow bottlenecks in vendor SLA performance.',
    `interpreting_radiologist_name` STRING COMMENT 'Full name of the remote radiologist who performed the teleradiology interpretation. Retained for report attribution, credentialing verification, and regulatory reporting purposes.',
    `interpreting_radiologist_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the remote radiologist who interpreted the imaging study on behalf of the teleradiology vendor. Required for professional component billing and credentialing verification.. Valid values are `^[0-9]{10}$`',
    `modality_code` STRING COMMENT 'DICOM-standard modality code identifying the imaging technology used to acquire the study (e.g., CT, MR, XR, US, PT). Drives subspecialty routing logic and SLA tier assignment. [ENUM-REF-CANDIDATE: CT|MR|XR|US|PT|NM|MG|FL|DX|CR — 10 candidates stripped; promote to reference product]',
    `mrn` STRING COMMENT 'The facility-assigned Medical Record Number (MRN) for the patient associated with this teleradiology case. Retained on the case record to support report reconciliation and audit without requiring a join to the patient master.',
    `number_of_images` STRING COMMENT 'Total count of DICOM image instances included in the transmitted imaging study. Used to verify transmission completeness and assess study complexity for vendor workload management.',
    `number_of_series` STRING COMMENT 'Total count of DICOM series included in the transmitted imaging study. Alongside number_of_images, used to assess study complexity and verify transmission completeness.',
    `preliminary_report_datetime` TIMESTAMP COMMENT 'The date and time at which the preliminary (wet read) radiology report was received from the teleradiology vendor. Used to measure preliminary TAT compliance against SLA thresholds.',
    `preliminary_report_text` STRING COMMENT 'The verbatim text of the preliminary (wet read) radiology report received from the teleradiology vendor. Contains PHI and clinical findings. Used for reconciliation comparison and clinical communication prior to final report availability.',
    `priority_level` STRING COMMENT 'Clinical priority assigned to the imaging study, which determines the applicable turnaround time (TAT) SLA tier for the teleradiology vendor. STAT studies require the shortest TAT.. Valid values are `stat|urgent|routine|elective`',
    `professional_component_billed` BOOLEAN COMMENT 'Boolean flag indicating whether the professional component (PC) of the radiology interpretation has been billed to the payer. Used to track billing completion and prevent duplicate claim submission.',
    `reconciliation_datetime` TIMESTAMP COMMENT 'The date and time at which the report reconciliation process was completed by the on-site or supervising radiologist. Null if reconciliation is still pending.',
    `reconciliation_discrepancy_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a clinically significant discrepancy was identified between the teleradiology vendors interpretation and the on-site radiologists reconciliation review. Triggers quality review workflows when True.',
    `report_reconciliation_status` STRING COMMENT 'Status of the reconciliation process between the teleradiology vendors preliminary/final report and the on-site radiologists review. Tracks whether discrepancies between preliminary and final interpretations have been identified and resolved.. Valid values are `pending|in_review|reconciled|discrepancy_identified|escalated|waived`',
    `retransmission_count` STRING COMMENT 'Number of times the imaging study was retransmitted to the teleradiology vendor due to transmission failures or incomplete transfers. Used for infrastructure reliability monitoring and SLA dispute resolution.',
    `routing_reason` STRING COMMENT 'The business reason this imaging study was routed to a teleradiology vendor rather than interpreted by an on-site radiologist. Drives SLA tier selection and vendor performance analytics. [ENUM-REF-CANDIDATE: after_hours|subspecialty|overflow|stat_coverage|disaster_recovery|other — promote to reference product if additional values are needed]. Valid values are `after_hours|subspecialty|overflow|stat_coverage|disaster_recovery|other`',
    `sla_met` BOOLEAN COMMENT 'Boolean flag indicating whether the teleradiology vendor met the contractual turnaround time (TAT) SLA for this case. True when actual_tat_minutes is less than or equal to expected_tat_minutes. Used for vendor performance scorecards.',
    `study_datetime` TIMESTAMP COMMENT 'The date and time at which the imaging study was acquired (scan performed) at the originating facility. Sourced from the DICOM Study Date/Time tags. Represents the principal real-world clinical event time for this case.',
    `subspecialty_required` STRING COMMENT 'The radiology subspecialty expertise required for interpretation of this study (e.g., neuroradiology, musculoskeletal, pediatric radiology, interventional). Drives subspecialty routing logic and vendor capability matching.',
    `transmission_datetime` TIMESTAMP COMMENT 'The date and time (ISO 8601 with timezone offset) at which the imaging study DICOM data was transmitted from the originating facilitys PACS to the teleradiology vendors receiving system. This is the TAT clock start event.',
    `transmission_method` STRING COMMENT 'The technical method used to transmit the imaging study to the teleradiology vendor. Used for transmission failure analysis and infrastructure performance monitoring.. Valid values are `dicom_push|dicom_pull|vpn_transfer|cloud_upload|hl7_mllp|other`',
    `transmission_success` BOOLEAN COMMENT 'Boolean flag indicating whether the DICOM study transmission to the teleradiology vendor was completed successfully without errors or data loss. False triggers retransmission workflows.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this teleradiology case record was most recently modified. Used for incremental data pipeline processing and audit trail maintenance.',
    `vendor_accession_number` STRING COMMENT 'The accession number assigned by the teleradiology vendors RIS upon receipt of the transmitted study. Used for cross-referencing vendor reports back to the originating order and for reconciliation workflows.',
    `vendor_receipt_datetime` TIMESTAMP COMMENT 'The date and time at which the teleradiology vendor confirmed receipt and availability of the transmitted imaging study in their PACS/reading workstation. Used to measure transmission latency and adjust TAT calculations.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_teleradiology_case PRIMARY KEY(`teleradiology_case_id`)
) COMMENT 'Teleradiology case record tracking remote interpretation, vendor routing, TAT, and billing responsibility.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` (
    `follow_up_id` BIGINT COMMENT 'Primary key for follow_up',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Follow-up recommendation tracking programs use care coordinators (nurses/navigators) to ensure patient compliance with recommended imaging. Required for population health management and quality measur',
    `care_site_id` BIGINT COMMENT '',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Follow-up recommendations generate new clinical orders. Care gap closure tracking requires linking recommendations to original orders for longitudinal care coordination. Population health management t',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Follow-up recommendations specify CPT codes for recommended procedures to enable automated order entry, care gap closure tracking, and ACR appropriateness criteria validation. Supports population heal',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this follow-up recommendation was issued. Core party reference linking the recommendation to the Master Patient Index (MPI).',
    `imaging_order_id` BIGINT COMMENT '',
    `follow_imaging_order_id` BIGINT COMMENT 'Reference to the original imaging order that produced the study from which this follow-up recommendation was derived.',
    `clinician_id` BIGINT COMMENT '',
    `follow_original_imaging_order_id` BIGINT COMMENT '',
    `report_id` BIGINT COMMENT '',
    `follow_radiology_report_id` BIGINT COMMENT 'Reference to the radiology report from which this follow-up recommendation was generated. Links the recommendation to its source diagnostic interpretation.',
    `follow_report_id` BIGINT COMMENT '',
    `follow_responsible_clinician_id` BIGINT COMMENT '',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Follow-up recommendations reference diagnosis codes for medical necessity justification, care gap identification, and quality measure reporting. Links support diagnosis-driven follow-up compliance tra',
    `mpi_record_id` BIGINT COMMENT '',
    `primary_follow_clinician_id` BIGINT COMMENT 'Reference to the clinician who placed the original imaging order. Used for provider notification workflows and accountability tracking.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Follow-up imaging recommendations frequently require prior authorization. Linking to applicable PA rule enables automated requirement flagging, patient notification of coverage prerequisites, scheduli',
    `radiology_finding_id` BIGINT COMMENT '',
    `radiology_study_id` BIGINT COMMENT '',
    `recall_list_id` BIGINT COMMENT '',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter associated with the original imaging study that generated this follow-up recommendation.',
    `accession_number` STRING COMMENT '',
    `acr_category_code` STRING COMMENT 'Structured ACR category or risk stratification code assigned to the finding per applicable ACR reporting system (e.g., Lung-RADS 4A, LI-RADS LR-4, TI-RADS 4). Drives follow-up urgency and recommended action.',
    `acr_guideline_reference` STRING COMMENT 'Specific ACR (American College of Radiology) incidental findings guideline or white paper that governs this recommendation (e.g., ACR Lung-RADS 2022, ACR Incidental Thyroid Findings 2023). Enables automated guideline compliance validation.',
    `body_part` STRING COMMENT '',
    `care_gap_flag` BOOLEAN COMMENT 'Indicates whether this follow-up recommendation represents an open care gap in population health management workflows. True when the recommended action has not been completed within the guideline-specified timeframe. Drives HEDIS (Healthcare Effectiveness Data and Information Set) and MIPS care gap closure programs.',
    `clinical_indication` STRING COMMENT '',
    `closure_datetime` TIMESTAMP COMMENT '',
    `closure_method` STRING COMMENT '',
    `closure_notes` STRING COMMENT '',
    `closure_status` STRING COMMENT '',
    `cms_quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this follow-up recommendation is attributable to a CMS (Centers for Medicare and Medicaid Services) quality measure or MIPS (Merit-based Incentive Payment System) performance measure. True when the recommendation contributes to a reportable quality metric.',
    `communication_method` STRING COMMENT '',
    `communication_timestamp` TIMESTAMP COMMENT '',
    `completed_date` DATE COMMENT 'Date on which the follow-up action was completed. Populated when recommendation_status transitions to completed. Used to calculate compliance with recommended timeframes and CMS quality measures.',
    `completion_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this follow-up recommendation record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `declined_reason` STRING COMMENT 'Reason code explaining why the follow-up recommendation was declined or cancelled. Populated when recommendation_status is declined or cancelled. Supports quality reporting and exception documentation.. Valid values are `patient_refused|provider_cancelled|clinically_inappropriate|duplicate_recommendation|other`',
    `due_date` DATE COMMENT '',
    `escalation_datetime` TIMESTAMP COMMENT '',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this follow-up recommendation has been escalated due to non-compliance, overdue status, or high-risk finding. True when escalation has been triggered; drives escalation workflow and management reporting.',
    `escalation_reason` STRING COMMENT 'Reason code explaining why this follow-up recommendation was escalated. Supports root cause analysis and quality improvement programs.. Valid values are `overdue|high_risk_finding|patient_no_show|provider_non_response|critical_result`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when this follow-up recommendation was escalated. Populated only when escalation_flag is True. Supports escalation audit trail and response time measurement.',
    `finding_body_region` STRING COMMENT 'Anatomical body region or organ system where the actionable finding was identified (e.g., lung, liver, adrenal gland, thyroid). Supports ACR guideline-based routing and population health cohort analysis.',
    `finding_category_code` STRING COMMENT 'Standardized code classifying the type of incidental finding per ACR or SNOMED CT terminology (e.g., pulmonary nodule, renal cyst, hepatic lesion). Enables structured tracking and guideline-based workflow routing.',
    `finding_description` STRING COMMENT 'Description of the incidental or actionable finding that triggered this follow-up recommendation. Captures the clinical observation (e.g., pulmonary nodule, adrenal mass) as documented in the radiology report.',
    `follow_up_status` STRING COMMENT '',
    `follow_up_type` STRING COMMENT '',
    `imaging_modality` STRING COMMENT '',
    `is_incidental_finding` BOOLEAN COMMENT '',
    `is_overdue` BOOLEAN COMMENT '',
    `laterality` STRING COMMENT '',
    `lost_to_follow_up_date` DATE COMMENT 'Date on which the recommendation was classified as lost-to-follow-up, indicating the patient did not complete the recommended action within the acceptable timeframe despite outreach efforts.',
    `modality` STRING COMMENT '',
    `mrn` STRING COMMENT '',
    `notification_count` STRING COMMENT '',
    `notification_datetime` TIMESTAMP COMMENT '',
    `notification_method` STRING COMMENT '',
    `notification_sent_flag` BOOLEAN COMMENT '',
    `notification_sent_timestamp` TIMESTAMP COMMENT '',
    `ordering_provider_notification_status` STRING COMMENT 'Current status of notification to the ordering provider regarding this follow-up recommendation. Tracks whether the referring clinician has been informed and has acknowledged or acted on the recommendation.. Valid values are `not_notified|notified|acknowledged|action_taken`',
    `ordering_provider_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the ordering provider was first notified of this follow-up recommendation. Supports closed-loop communication compliance and provider accountability tracking.',
    `original_finding_date` DATE COMMENT '',
    `overdue_flag` BOOLEAN COMMENT '',
    `pacs_study_instance_uid` STRING COMMENT 'DICOM Study Instance Unique Identifier (UID) for the imaging study from which this follow-up recommendation was generated. Enables direct linkage to the source images in the PACS (Picture Archiving and Communication System).',
    `patient_declined_flag` BOOLEAN COMMENT '',
    `patient_notification_method` STRING COMMENT 'Channel or method used to notify the patient of the follow-up recommendation (e.g., patient portal message, phone call, letter). Supports communication preference compliance and outreach effectiveness analysis.. Valid values are `portal_message|phone_call|letter|in_person|secure_email`',
    `patient_notification_status` STRING COMMENT 'Current status of patient notification regarding this follow-up recommendation. Tracks whether the patient has been informed, acknowledged receipt, or declined notification. Supports HIPAA patient communication compliance.. Valid values are `not_notified|notified|acknowledged|declined_notification`',
    `patient_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the patient was first notified of this follow-up recommendation. Supports compliance documentation and patient communication audit trails.',
    `patient_notified_flag` BOOLEAN COMMENT '',
    `patient_notified_timestamp` TIMESTAMP COMMENT '',
    `population_health_cohort` STRING COMMENT 'Population health management cohort or program to which this follow-up recommendation is attributed (e.g., Lung Cancer Screening Program, Incidental Pulmonary Nodule Registry, Adrenal Incidentaloma Program). Supports ACO and population health analytics.',
    `priority` STRING COMMENT '',
    `priority_level` STRING COMMENT 'Clinical urgency classification of the follow-up recommendation indicating how quickly action must be taken. Drives escalation workflows, patient notification timelines, and provider alert routing.. Valid values are `routine|urgent|emergent|critical`',
    `provider_acknowledged_flag` BOOLEAN COMMENT '',
    `provider_acknowledged_timestamp` TIMESTAMP COMMENT '',
    `recommendation_date` TIMESTAMP COMMENT 'Date and time when the follow-up recommendation was formally issued by the radiologist in the finalized report. Serves as the principal business event timestamp for lifecycle and compliance tracking.',
    `recommendation_number` STRING COMMENT 'Externally visible business identifier for this follow-up recommendation, used in patient communications, provider notifications, and tracking workflows. Format: FU-YYYYMMDD-NNNNNN.',
    `recommendation_source` STRING COMMENT '',
    `recommendation_status` STRING COMMENT 'Current workflow state of the follow-up recommendation. Drives population health management dashboards and CMS quality measure reporting.. Valid values are `pending|scheduled|completed|declined|lost_to_follow_up|cancelled`',
    `recommendation_text` STRING COMMENT 'Free-text narrative of the follow-up recommendation as authored by the radiologist in the report. Contains Protected Health Information (PHI) and clinical detail supporting the recommended action.',
    `recommendation_type` STRING COMMENT 'Category of action recommended by the radiologist. Classifies the nature of the follow-up required (e.g., repeat imaging, biopsy, specialist referral). [ENUM-REF-CANDIDATE: repeat_imaging|biopsy|clinical_correlation|specialist_referral|lab_workup|clinical_follow_up|surveillance — promote to reference product]',
    `recommended_due_date` DATE COMMENT 'Calculated target date by which the follow-up action should be completed, derived from the recommendation date plus the recommended timeframe. Used for overdue tracking, escalation triggers, and patient outreach scheduling.',
    `recommended_modality` STRING COMMENT 'Imaging modality recommended for the follow-up study (e.g., CT, MRI, ultrasound). Used for scheduling, resource planning, and modality-specific workflow routing. [ENUM-REF-CANDIDATE: CT|MRI|ultrasound|PET|X-ray|mammography|fluoroscopy|nuclear_medicine — promote to reference product if additional modalities are needed]. Valid values are `CT|MRI|ultrasound|PET|X-ray|mammography`',
    `recommended_timeframe_days` STRING COMMENT 'Number of days within which the follow-up action should be completed, as specified by the radiologist or derived from ACR incidental finding guidelines (e.g., 90 days for a 6–8 mm pulmonary nodule). Drives escalation and overdue tracking.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'Date and time when the radiology report containing this recommendation was finalized and signed by the interpreting radiologist. Used for turnaround time measurement and compliance reporting.',
    `ris_recommendation_code` STRING COMMENT 'Native identifier for this follow-up recommendation as assigned by the source Radiology Information System (RIS) such as Epic Radiant or Cerner RadNet. Supports system-of-record traceability and cross-system reconciliation.',
    `scheduled_date` DATE COMMENT 'Date on which the follow-up action (imaging, biopsy, referral appointment) has been scheduled. Populated when recommendation_status transitions to scheduled. Used for compliance gap analysis.',
    `specialist_referral_type` STRING COMMENT 'Specialty or service to which the patient is referred when recommendation_type is specialist_referral (e.g., pulmonology, oncology, endocrinology, interventional radiology). Supports referral management and care coordination workflows.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this follow-up recommendation record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_follow_up PRIMARY KEY(`follow_up_id`)
) COMMENT 'Radiology follow-up recommendation tracking, ensuring incidental findings receive timely clinical action.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` (
    `interventional_procedure_id` BIGINT COMMENT 'Unique surrogate identifier for the interventional radiology (IR) procedure record in the lakehouse silver layer. Primary key for this entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: IR procedures are audited for informed consent, surgical timeout compliance, device tracking (UDI), and complication reporting. Compliance audits verify procedural compliance with TJC, CMS, and FDA re',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Interventional radiology performs image-guided biopsies, aspirations, and tissue sampling that generate laboratory specimens requiring pathology or microbiology analysis. Chain of custody, specimen tr',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or suite (IR suite, hybrid OR, cath lab) where the procedure was performed.',
    `charge_id` BIGINT COMMENT '',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Interventional radiology procedures are ordered via clinical orders. Procedural documentation requires linking procedure reports to original order indication for clinical context. Charge capture valid',
    `contrast_admin_id` BIGINT COMMENT '',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Interventional procedures use contrast agents and may involve sedation/anesthesia medications. FK to drug_master enables medication reconciliation, adverse event tracking, billing accuracy, and regula',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Interventional procedures are billed using CPT codes for charge capture, RVU calculation, and procedural volume tracking. Essential for interventional radiology revenue cycle and productivity analytic',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who underwent the interventional procedure. Links to the master patient record.',
    `dose_record_id` BIGINT COMMENT '',
    `equipment_asset_id` BIGINT COMMENT '',
    `imaging_order_id` BIGINT COMMENT 'Reference to the originating imaging order (from radiology.imaging_order) that triggered this interventional procedure.',
    `employee_id` BIGINT COMMENT '',
    `interventional_employee_id` BIGINT COMMENT 'Reference to the radiology technologist or scrub tech who assisted with the procedure. Used for staffing analytics, competency tracking, and case documentation.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Interventional procedures document primary diagnosis for medical necessity validation, prior authorization, and outcomes tracking by indication. Supports interventional radiology quality and appropria',
    `interventional_icd10_primary_icd_code_id` BIGINT COMMENT '',
    `clinician_id` BIGINT COMMENT '',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Interventional radiology procedures (biopsies, drainages, vascular interventions) occur in specific IR suites/procedure rooms. Tracking the exact room is essential for: (1) scheduling and room utiliza',
    `interventional_room_id` BIGINT COMMENT '',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Interventional radiology procedures generate HL7 ORU result messages and DICOM structured reports (SR) for procedure documentation exchange with referring providers and EHR systems. Message_log tracks',
    `mpi_record_id` BIGINT COMMENT '',
    `or_suite_id` BIGINT COMMENT '',
    `osha_exposure_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_exposure_incident. Business justification: Interventional radiology procedures involve radiation and sharps exposure risks. OSHA tracks employee exposures (needlesticks, radiation overexposure) during IR procedures; incidents reference the spe',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Pre-procedure lab orders (PT/INR, platelet count, CBC) are standard of care for interventional procedures to assess bleeding risk and procedural safety. Regulatory and accreditation requirements manda',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Interventional radiology procedures consume high-cost devices (stents, catheters, guidewires, embolization coils) tracked in material master. Essential for accurate procedure costing, charge capture, ',
    `primary_interventional_clinician_id` BIGINT COMMENT 'Reference to the interventional radiologist or proceduralist who performed the procedure. Maps to the provider master record.',
    `radiology_study_id` BIGINT COMMENT '',
    `report_id` BIGINT COMMENT '',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Interventional radiology procedures are often investigational (device trials, novel techniques) or protocol-specified interventions. Linkage required for IDE compliance, device accountability, procedu',
    `snomed_concept_id` BIGINT COMMENT '',
    `subject_enrollment_id` BIGINT COMMENT '',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Interventional radiology procedures requiring OR time are scheduled through surgical scheduling system. Real workflow: IR cases booked as surgical cases, then tracked in radiologys interventional_pro',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Interventional radiology procedures (biopsies, drains, ablations, embolizations) require specific procedural informed consent documenting risks, benefits, alternatives. Critical regulatory requirement',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient, outpatient, or ED visit) during which the interventional procedure was performed.',
    `access_site` STRING COMMENT 'Anatomical location used for vascular or percutaneous access during the procedure (e.g., right common femoral artery, right internal jugular vein, left radial artery). Critical for complication tracking and access-site adverse event reporting.',
    `accession_number` STRING COMMENT 'Unique RIS-assigned accession number for this interventional procedure, used for PACS integration and DICOM image linkage. Serves as the primary business identifier within the Radiology Information System (RIS).',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia or sedation administered during the interventional procedure. Impacts OR scheduling, anesthesia billing, and patient safety monitoring requirements.. Valid values are `none|local|moderate-sedation|general|MAC|spinal`',
    `approach` STRING COMMENT '',
    `asa_classification` STRING COMMENT 'ASA physical status classification assigned to the patient prior to the procedure, reflecting overall health and anesthetic risk. Required for anesthesia billing, risk-adjusted outcome reporting, and case complexity analysis.. Valid values are `ASA-I|ASA-II|ASA-III|ASA-IV|ASA-V|ASA-VI`',
    `body_part` STRING COMMENT '',
    `body_region` STRING COMMENT 'Anatomical body region or organ system targeted by the intervention (e.g., hepatic, renal, pulmonary, peripheral vascular, spine). Used for procedure classification, PACS routing, and quality reporting.',
    `body_site` STRING COMMENT '',
    `cancellation_reason` STRING COMMENT 'Reason the procedure was cancelled (e.g., patient declined, clinical contraindication, equipment failure, scheduling conflict). Required for operational improvement and suite utilization reporting. [ENUM-REF-CANDIDATE: patient-declined|clinical-contraindication|equipment-failure|scheduling-conflict|insurance-denial|patient-no-show|other — promote to reference product]',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time the procedure was cancelled, if applicable. Used for suite utilization analysis, cancellation rate reporting, and downstream order management.',
    `case_complexity` STRING COMMENT '',
    `clinical_indication` STRING COMMENT '',
    `closure_method` STRING COMMENT '',
    `complication_description` STRING COMMENT '',
    `complication_flag` BOOLEAN COMMENT '',
    `complication_occurred` BOOLEAN COMMENT 'Indicates whether a procedural complication was documented during or immediately following the interventional procedure. Triggers complication detail capture and quality event reporting workflows.',
    `complication_severity` STRING COMMENT 'SIR severity grade of the documented complication: minor (no therapy required), moderate (nominal therapy required), major (major therapy required or permanent adverse sequelae), or death. Used for quality benchmarking and regulatory reporting.. Valid values are `minor|moderate|major|death`',
    `complication_type` STRING COMMENT 'Standardized classification of the procedural complication using SIR severity grading (e.g., hemorrhage, vessel perforation, contrast reaction, infection, pneumothorax). Required for SIR quality benchmarking and adverse event reporting. [ENUM-REF-CANDIDATE: hemorrhage|vessel-perforation|contrast-reaction|infection|pneumothorax|nerve-injury|device-malfunction|other — promote to reference product]',
    `contrast_agent_used` BOOLEAN COMMENT 'Indicates whether an iodinated or gadolinium-based contrast agent was administered during the interventional procedure. Drives contrast reaction monitoring, nephrotoxicity risk documentation, and billing for contrast administration.',
    `contrast_used` BOOLEAN COMMENT '',
    `contrast_volume_ml` DECIMAL(18,2) COMMENT 'Total volume of contrast agent administered in milliliters during the procedure. Used for nephrotoxicity risk stratification (contrast-to-creatinine ratio), adverse event documentation, and quality benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the interventional procedure record was first created in the source system (RIS/EHR). Audit trail field for data lineage and HIPAA audit log compliance.',
    `device_name` STRING COMMENT 'Commercial or generic name of the primary medical device or implant used (e.g., Wallstent Endoprosthesis, Greenfield IVC Filter, Port-a-Cath). Supports supply chain reconciliation and device surveillance.',
    `device_udi` STRING COMMENT 'FDA-assigned Unique Device Identifier (UDI) for the primary implant or device placed during the procedure. Mandatory for device surveillance, recall management, and FDA GUDID registry compliance.',
    `device_used` STRING COMMENT '',
    `estimated_blood_loss_ml` DECIMAL(18,2) COMMENT '',
    `fluoroscopy_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative fluoroscopy time in minutes recorded during the procedure. Mandatory for radiation dose documentation, ALARA compliance, and Joint Commission radiation safety reporting.',
    `fluoroscopy_time_sec` DECIMAL(18,2) COMMENT '',
    `guidance_modality` STRING COMMENT '',
    `icd10_post_procedure_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code assigned after the procedure, reflecting findings confirmed or revised during the intervention. May differ from pre-procedure diagnosis and is used for DRG grouping and CDI.. Valid values are `^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$`',
    `imaging_guidance_modality` STRING COMMENT 'Imaging modality used to guide the interventional procedure in real time (e.g., fluoroscopy for vascular interventions, CT for biopsies, ultrasound for drainage). Drives radiation dose tracking and CPT guidance code selection.. Valid values are `fluoroscopy|CT|ultrasound|MRI|PET-CT|combined`',
    `implant_placed` BOOLEAN COMMENT '',
    `implant_type` STRING COMMENT '',
    `implant_used` BOOLEAN COMMENT 'Indicates whether a medical device or implant (stent, coil, filter, catheter, port) was placed during the procedure. Triggers UDI capture requirements per FDA 21st Century Cures Act and device surveillance workflows.',
    `laterality` STRING COMMENT 'Anatomical side of the body on which the interventional procedure was performed. Required for correct-site surgery compliance, ICD-10 coding, and wrong-site event prevention per Joint Commission Universal Protocol.. Valid values are `left|right|bilateral|midline|not-applicable`',
    `modality_code` STRING COMMENT '',
    `mrn` STRING COMMENT '',
    `outcome_status` STRING COMMENT '',
    `pathology_sent_flag` BOOLEAN COMMENT '',
    `pathology_specimen_sent` BOOLEAN COMMENT '',
    `patient_position` STRING COMMENT '',
    `performing_clinician_npi` STRING COMMENT '',
    `performing_provider_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the interventional radiologist who performed the procedure. Required on professional claims (CMS-1500) and for provider credentialing verification.. Valid values are `^[0-9]{10}$`',
    `post_procedure_status` STRING COMMENT '',
    `pre_procedure_diagnosis` STRING COMMENT '',
    `procedure_approach` STRING COMMENT 'Technique or approach used to access the target anatomy during the interventional procedure. Impacts CPT code selection, complication risk stratification, and case complexity scoring. [ENUM-REF-CANDIDATE: percutaneous|endovascular|endoscopic|open-hybrid|transarterial|transvenous|transhepatic — promote to reference product]',
    `procedure_category` STRING COMMENT 'High-level clinical category of the interventional radiology procedure. Supports case mix analysis, resource planning, and complication benchmarking. [ENUM-REF-CANDIDATE: vascular|non-vascular|neuro-IR|oncologic|drainage|biopsy|embolization|other — promote to reference product]',
    `procedure_code` STRING COMMENT '',
    `procedure_datetime` TIMESTAMP COMMENT '',
    `procedure_description` STRING COMMENT '',
    `procedure_duration_minutes` DECIMAL(18,2) COMMENT '',
    `procedure_end_datetime` TIMESTAMP COMMENT '',
    `procedure_end_timestamp` TIMESTAMP COMMENT 'Date and time when the interventional procedure was completed (dressing applied, catheter removed, or patient left the IR suite). Used with start timestamp to calculate procedure duration for suite utilization and staffing analytics.',
    `procedure_name` STRING COMMENT 'Full descriptive name of the interventional procedure as documented in the RIS/EHR (e.g., Percutaneous Transhepatic Cholangiography, TIPS Procedure, Uterine Fibroid Embolization).',
    `procedure_start_datetime` TIMESTAMP COMMENT '',
    `procedure_start_timestamp` TIMESTAMP COMMENT 'Date and time when the interventional procedure was initiated (first incision, needle insertion, or catheter placement). Principal business event timestamp for case duration calculation and OR/suite utilization reporting.',
    `procedure_status` STRING COMMENT 'Current lifecycle status of the interventional procedure, aligned with HL7 FHIR Procedure.status value set. Drives workflow routing in the RIS and case management dashboards.. Valid values are `scheduled|in-progress|completed|cancelled|on-hold`',
    `procedure_type` STRING COMMENT '',
    `radiation_dose_dap` DECIMAL(18,2) COMMENT '',
    `radiation_dose_dap_gycm2` DECIMAL(18,2) COMMENT 'Dose-area product (DAP) in Gy·cm² representing the total radiation energy delivered, accounting for field size. Complementary to RAK for stochastic risk estimation and dose registry reporting.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT '',
    `radiation_dose_kerma_mgy` DECIMAL(18,2) COMMENT 'Total reference air kerma (RAK) in milligrays (mGy) delivered to the patient during the procedure. Primary radiation dose metric for fluoroscopy-guided interventions per ACR and Joint Commission dose tracking requirements.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'Date and time when the interventional radiology procedure report was finalized (signed) by the interpreting radiologist. Used for turnaround time (TAT) measurement and regulatory reporting on result communication.',
    `report_status` STRING COMMENT 'Current status of the interventional radiology procedure report in the RIS/PACS workflow. Drives report distribution, result notification, and HIM documentation completion tracking.. Valid values are `preliminary|final|addendum|amended|cancelled`',
    `secondary_cpt_codes` STRING COMMENT 'Pipe-delimited list of additional CPT codes for add-on procedures, guidance codes, or concurrent services performed during the same IR session (e.g., imaging guidance CPT 77012 alongside a biopsy CPT).',
    `sedation_level` STRING COMMENT '',
    `specimen_accession_number` STRING COMMENT '',
    `specimen_collected` BOOLEAN COMMENT 'Indicates whether a tissue or fluid specimen was collected during the procedure (e.g., biopsy core, aspirate, cytology). Triggers downstream laboratory order linkage and pathology workflow.',
    `specimen_collected_flag` BOOLEAN COMMENT '',
    `specimen_type` STRING COMMENT 'Type of specimen collected during the interventional procedure. Used for pathology order routing, LIS integration, and quality reporting on diagnostic yield.. Valid values are `core-biopsy|fine-needle-aspirate|fluid-aspirate|tissue-excision|cytology|not-applicable`',
    `success_flag` BOOLEAN COMMENT '',
    `technical_success` BOOLEAN COMMENT 'Indicates whether the procedure achieved its intended technical endpoint as defined by the performing interventionalist (e.g., successful vessel recanalization, complete embolization, adequate drainage). Core quality metric for IR outcome reporting.',
    `technical_success_flag` BOOLEAN COMMENT '',
    `technique_description` STRING COMMENT '',
    `timeout_performed_flag` BOOLEAN COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the interventional procedure record was last modified in the source system. Supports incremental ETL processing, audit trail maintenance, and change data capture.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_interventional_procedure PRIMARY KEY(`interventional_procedure_id`)
) COMMENT 'Interventional radiology procedure record capturing technique, devices used, complications, and outcomes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` (
    `radiology_order_status_history_id` BIGINT COMMENT 'Primary key for order_status_history',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or imaging center where the status change event occurred. Supports facility-level workflow benchmarking and multi-site operational reporting.',
    `clinician_id` BIGINT COMMENT 'Reference to the radiologist assigned to interpret the imaging study at the time of this status event. Relevant for read-phase status transitions (preliminary-read, final-read, report-signed) and radiologist productivity analytics.',
    `corrected_history_id` BIGINT COMMENT 'Reference to the original imaging_order_status_history_id record that this entry corrects, populated only when is_corrective_entry is True. Enables a complete correction chain for audit and compliance review.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient associated with the imaging order at the time of this status event. Retained on the history record to support patient-level workflow analytics without requiring a join to the order.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order whose status changed. Links this history record to the originating radiology order in the RIS workflow.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Order status transitions (scheduled→in-progress→complete→cancelled) trigger HL7 ORM order messages to referring systems and EHRs for real-time status updates. Message_log tracks each status change mes',
    `org_unit_id` BIGINT COMMENT 'Reference to the radiology department or imaging unit where this status event occurred. Supports department-level workflow analytics, staffing analysis, and operational benchmarking across imaging service lines.',
    `employee_id` BIGINT COMMENT 'Internal system user identifier of the individual who performed the status change action in the RIS. Complements the NPI for non-provider staff (technologists, schedulers, coordinators) who may not have an NPI.',
    `radiology_changed_by_employee_id` BIGINT COMMENT '',
    `report_id` BIGINT COMMENT 'Reference to the radiology report record associated with this status event, populated for read-phase transitions (preliminary-read, final-read, report-signed, report-delivered). Enables direct linkage between workflow events and the resulting diagnostic report.',
    `scheduling_appointment_id` BIGINT COMMENT 'Reference to the imaging appointment associated with this status event, when applicable. Links scheduling events (scheduled, patient-arrived) to the corresponding appointment record for scheduling workflow analytics.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) associated with the imaging order at the time of this status event. Supports encounter-level workflow analytics and integration with clinical documentation.',
    `accession_number` STRING COMMENT 'RIS-assigned accession number for the imaging order at the time of this status event. Serves as the primary cross-system identifier linking RIS, PACS, and HL7 ADT/ORM messages for this imaging study.',
    `cancellation_category` STRING COMMENT 'Structured category for the cancellation or on-hold reason when the new status is cancelled or on-hold. Enables standardized reporting on cancellation root causes for operational improvement. [ENUM-REF-CANDIDATE: patient-no-show|patient-refused|duplicate-order|clinical-contraindication|equipment-failure|scheduling-error|prior-auth-denied|provider-order-change|other — promote to reference product]',
    `change_reason` STRING COMMENT '',
    `change_source` STRING COMMENT '',
    `changed_by_npi` STRING COMMENT '',
    `changed_by_user_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the clinician or staff member who triggered the status change. Used for accountability tracking, audit compliance, and provider-level workflow performance analysis.. Valid values are `^[0-9]{10}$`',
    `changed_by_user_role` STRING COMMENT 'The functional role of the user who triggered the status change (e.g., radiologist, technologist, scheduler). Supports role-based workflow analytics and identification of process bottlenecks by staff category. [ENUM-REF-CANDIDATE: radiologist|technologist|scheduler|nurse|physician|system|coordinator|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was first written to the data platform. Represents the audit record creation time, distinct from the business event timestamp (status_change_timestamp). Used for data lineage and ETL reconciliation.',
    `duration_in_status_minutes` DECIMAL(18,2) COMMENT '',
    `hl7_message_reference` STRING COMMENT 'The unique message control identifier from the HL7 v2.x ORM/ORU/ADT message that triggered this status change, when applicable. Enables end-to-end HL7 message traceability and interface troubleshooting.',
    `hl7_message_type` STRING COMMENT 'The HL7 message type (e.g., ORM, ORU, ADT) associated with the status change event. Supports interface-level audit trails and HL7 workflow integration diagnostics.. Valid values are `ORM|ORU|ADT|SIU|ACK|other`',
    `interface_trigger_code` STRING COMMENT '',
    `ip_address` STRING COMMENT 'Network IP address of the workstation or system that submitted the status change event. Retained for HIPAA security audit trail compliance and forensic investigation of unauthorized access or workflow anomalies.',
    `is_corrective_entry` BOOLEAN COMMENT 'Indicates whether this status change record was entered as a correction to a previously recorded erroneous status transition. Supports audit integrity and distinguishes legitimate workflow events from administrative corrections.',
    `is_sla_breach` BOOLEAN COMMENT 'Indicates whether this status transition exceeded the defined SLA threshold for the given order priority and modality. True when transition_duration_seconds exceeds sla_threshold_seconds. Supports SLA compliance dashboards and regulatory reporting.',
    `is_system_generated` BOOLEAN COMMENT 'Indicates whether this status change was automatically triggered by the RIS system (e.g., via HL7 interface, automated workflow rule, or PACS integration) rather than manually entered by a user. Supports differentiation of automated vs. manual workflow events in process analytics.',
    `is_terminal_status` BOOLEAN COMMENT '',
    `modality_type` STRING COMMENT 'The imaging modality associated with the order at the time of this status event (e.g., CT, MRI, X-ray, Ultrasound, PET). Retained on the history record to enable modality-specific workflow and SLA analytics without joining to the order. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|other — 9 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The workflow status assigned to the imaging order as a result of this transition event. Represents the current state after the change. [ENUM-REF-CANDIDATE: ordered|scheduled|patient-arrived|exam-started|exam-completed|images-available|preliminary-read|final-read|report-signed|report-delivered|cancelled|on-hold — promote to reference product]. Valid values are `scheduled|patient-arrived|exam-started|exam-completed|images-available|preliminary-read`',
    `on_hold_reason` STRING COMMENT 'Free-text description of why the imaging order was placed on hold, populated when new_status is on-hold. Captures clinical or operational context such as pending prior authorization, patient preparation issues, or equipment unavailability.',
    `order_priority` STRING COMMENT 'The clinical priority level of the imaging order at the time of this status event. Used to assess whether SLA thresholds were met relative to the urgency of the order (e.g., STAT orders have tighter turnaround requirements).. Valid values are `STAT|URGENT|ROUTINE|ASAP|ELECTIVE`',
    `pacs_study_uid` STRING COMMENT 'The DICOM Study Instance UID assigned by the PACS system, populated when the status transition involves image availability (images-available state). Links the RIS workflow event to the corresponding PACS study for cross-system traceability.',
    `previous_status` STRING COMMENT '',
    `prior_status` STRING COMMENT 'The workflow status of the imaging order immediately before this transition event. Enables reconstruction of the full status progression sequence and detection of invalid or out-of-sequence transitions. [ENUM-REF-CANDIDATE: ordered|scheduled|patient-arrived|exam-started|exam-completed|images-available|preliminary-read|final-read|report-signed|report-delivered|cancelled|on-hold — promote to reference product]. Valid values are `ordered|scheduled|patient-arrived|exam-started|exam-completed|images-available`',
    `ris_event_code` STRING COMMENT '',
    `ris_order_status_code` STRING COMMENT 'The native status code as recorded in the source RIS system (Epic Radiant or Cerner RadNet) before normalization to the enterprise status vocabulary. Preserves source fidelity for reconciliation and interface troubleshooting.',
    `sequence_number` STRING COMMENT 'Ordinal sequence number of this status transition within the lifecycle of the imaging order, starting at 1 for the first transition. Enables ordered reconstruction of the complete status history and detection of missing or duplicate events.',
    `sla_threshold_seconds` STRING COMMENT 'The configured SLA time threshold in seconds for this specific status transition, based on order priority and modality type. Used to evaluate whether the transition met the defined Service Level Agreement (SLA) target.',
    `source_system_event_code` STRING COMMENT 'The native event or transaction identifier assigned by the originating RIS or interface system for this status change. Enables traceability back to the source system record for reconciliation and audit purposes.',
    `status_change_reason` STRING COMMENT 'Free-text or coded reason explaining why the status transition occurred. Particularly important for cancellation, on-hold, and exception states. Supports root cause analysis and RIS process improvement initiatives.',
    `status_change_reason_code` STRING COMMENT 'Standardized coded value for the status change reason, drawn from the RIS reason code master. Enables structured analytics and reporting on transition causes without relying on free-text parsing.',
    `status_change_timestamp` TIMESTAMP COMMENT 'The precise date and time when the status transition occurred in the RIS system. This is the principal business event timestamp for this log record, used for SLA compliance measurement, workflow duration analytics, and turnaround time reporting.',
    `status_comment` STRING COMMENT '',
    `status_notes` STRING COMMENT '',
    `transition_duration_seconds` STRING COMMENT 'The elapsed time in seconds between the prior status and this new status transition. Computed at ingestion time from consecutive status timestamps and stored to support SLA compliance measurement, bottleneck identification, and workflow efficiency analytics without requiring window function recalculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was last modified in the data platform, typically populated only for corrective entries. Supports change data capture and audit trail completeness.',
    `vibe_placeholder` STRING COMMENT '',
    `workflow_step` STRING COMMENT '',
    `workstation_code` STRING COMMENT 'Identifier of the RIS or PACS workstation from which the status change was performed. Supports physical location tracking of workflow events and security audit requirements under HIPAA access controls.',
    CONSTRAINT pk_radiology_order_status_history PRIMARY KEY(`radiology_order_status_history_id`)
) COMMENT 'Audit trail of status transitions for radiology imaging orders from placement through completion.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` (
    `report_distribution_id` BIGINT COMMENT 'Primary key for the report_distribution association',
    `direct_address_id` BIGINT COMMENT '',
    `direct_message_id` BIGINT COMMENT '',
    `distribution_rule_id` BIGINT COMMENT 'Foreign key to distribution rule or routing rule that triggered this distribution',
    `employee_id` BIGINT COMMENT 'User ID of person who acknowledged the report',
    `fhir_endpoint_id` BIGINT COMMENT '',
    `hie_transaction_id` BIGINT COMMENT '',
    `initiated_by_employee_id` BIGINT COMMENT 'Employee who initiated manual distribution',
    `interface_channel_id` BIGINT COMMENT 'FK to the interface channel used for transmission (e.g., HL7 v2, FHIR R4, Direct, fax); supports channel-level SLA monitoring.',
    `message_log_id` BIGINT COMMENT 'Unique identifier for the HL7/FHIR message sent to this trading partner for this report. Used for message tracking, troubleshooting, and correlation with partner acknowledgments.',
    `mpi_record_id` BIGINT COMMENT '',
    `report_id` BIGINT COMMENT 'Foreign key linking to the radiology report being distributed to external partners',
    `radiology_study_id` BIGINT COMMENT 'FK to the radiology study associated with the report; supports study-level distribution tracking.',
    `organization_id` BIGINT COMMENT 'Re-derived attribute added during thin-product expansion based on business context for facility.report_distribution.',
    `care_site_id` BIGINT COMMENT '',
    `clinician_id` BIGINT COMMENT 'Ordering or referring provider who is the intended recipient of the radiology report.',
    `report_recipient_care_site_id` BIGINT COMMENT 'Care site ID of the destination facility',
    `report_recipient_clinician_id` BIGINT COMMENT '',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to the external trading partner receiving the report',
    `accession_number` STRING COMMENT '',
    `acknowledged_by_name` STRING COMMENT 'Name of person who acknowledged receipt',
    `acknowledgment_code` STRING COMMENT 'HL7 acknowledgment code returned by the trading partner (AA=Application Accept, AE=Application Error, AR=Application Reject). Used for troubleshooting failed transmissions and partner-specific delivery issues.',
    `acknowledgment_datetime` TIMESTAMP COMMENT '',
    `acknowledgment_received_timestamp` TIMESTAMP COMMENT 'Timestamp when acknowledgment was received',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Flag indicating whether delivery acknowledgment is required',
    `acknowledgment_status` STRING COMMENT '',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Timestamp of the acknowledgment received from the recipient; completes the delivery confirmation loop.',
    `attachment_count` STRING COMMENT 'Number of attachments included (e.g., key images, full DICOM series)',
    `attachment_included_flag` BOOLEAN COMMENT 'Flag indicating whether images or attachments were included',
    `attachment_size_bytes` BIGINT COMMENT 'Total size of attachments in bytes',
    `audit_trail` STRING COMMENT 'Audit trail of distribution events (JSON or delimited log)',
    `created_timestamp` TIMESTAMP COMMENT '',
    `critical_result_acknowledged_by` STRING COMMENT 'Name or identifier of person who acknowledged receipt of critical result',
    `critical_result_acknowledged_flag` BOOLEAN COMMENT 'Indicates the critical result was acknowledged by the receiving provider; required for Joint Commission compliance.',
    `critical_result_acknowledged_timestamp` TIMESTAMP COMMENT 'Timestamp when critical result acknowledgment was received',
    `critical_result_flag` BOOLEAN COMMENT 'Indicates whether this distribution is for a critical/unexpected finding requiring verbal communication per Joint Commission NPSG.',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the trading partner acknowledged successful receipt and processing of the report. Null if not yet acknowledged. Used to calculate end-to-end delivery time.',
    `delivery_attempt_count` STRING COMMENT '',
    `delivery_channel` STRING COMMENT '',
    `delivery_confirmation_flag` BOOLEAN COMMENT 'Re-derived business attribute for radiology.report_distribution: delivery_confirmation_flag',
    `delivery_datetime` TIMESTAMP COMMENT '',
    `delivery_duration_minutes` DECIMAL(18,2) COMMENT 'Actual delivery duration in minutes',
    `delivery_latency_seconds` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for radiology.report_distribution.',
    `delivery_method` STRING COMMENT '',
    `delivery_status` STRING COMMENT 'Current status of the report delivery to this trading partner. Tracks the lifecycle from initial transmission through acknowledgment or failure. Values: pending, transmitted, acknowledged, failed, retrying, delivered.',
    `delivery_timestamp` TIMESTAMP COMMENT '',
    `distribution_channel` STRING COMMENT 'Re-derived business attribute for radiology.report_distribution: distribution_channel',
    `distribution_method` STRING COMMENT 'Channel used for report delivery (e.g., HL7 ORU, Direct message, fax, print, patient portal, HIE push).',
    `distribution_outcome` STRING COMMENT 'Re-derived attribute added during thin-product expansion based on business context for radiology.report_distribution.',
    `distribution_priority` STRING COMMENT 'Priority of distribution (routine, urgent, stat, critical result)',
    `distribution_status` STRING COMMENT 'Re-derived business attribute for radiology.report_distribution: distribution_status',
    `distribution_trigger` STRING COMMENT 'Event that triggered distribution (report signed, addendum added, critical result flagged, manual request)',
    `distribution_type` STRING COMMENT '',
    `document_format` STRING COMMENT 'Interoperability standard format used to transmit the report to this specific trading partner. Different partners may receive the same report in different formats based on their capabilities and data sharing agreements. Values: CDA, HL7v2, FHIR, Direct, PDF.',
    `encryption_method` STRING COMMENT 'Encryption method used (TLS 1.2, S/MIME, Direct Trust, none)',
    `error_code` STRING COMMENT 'Structured error code returned on delivery failure; supports automated error classification and routing.',
    `error_description` STRING COMMENT '',
    `error_message` STRING COMMENT 'Detailed error message returned by the trading partner or interface engine if delivery failed. Used for troubleshooting and partner support escalation.',
    `escalation_flag` BOOLEAN COMMENT 'Whether delivery failure was escalated',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates if escalation is required due to delivery failure or no acknowledgment',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when escalation was triggered',
    `failure_reason` STRING COMMENT '',
    `first_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of first delivery attempt',
    `is_critical_result` BOOLEAN COMMENT '',
    `is_critical_result_distribution` BOOLEAN COMMENT '',
    `is_patient_copy` BOOLEAN COMMENT '',
    `is_stat` BOOLEAN COMMENT '',
    `last_attempt_datetime` TIMESTAMP COMMENT '',
    `last_attempt_timestamp` TIMESTAMP COMMENT 'Timestamp of most recent delivery attempt',
    `last_retry_timestamp` TIMESTAMP COMMENT 'Timestamp of last retry attempt',
    `manual_distribution_flag` BOOLEAN COMMENT 'Whether distribution was manually initiated vs. automatic',
    `max_retry_count` STRING COMMENT 'Maximum number of retries configured for this distribution channel before escalation.',
    `message_control_number` STRING COMMENT 'HL7 message control ID or FHIR message ID for this distribution',
    `message_size_bytes` BIGINT COMMENT 'Size of transmitted message in bytes',
    `message_type` STRING COMMENT 'Message type (HL7 ORU^R01, FHIR DiagnosticReport, CDA document)',
    `message_version` STRING COMMENT 'Message standard version (HL7 2.5.1, FHIR R4, CDA R2)',
    `modality_code` STRING COMMENT '',
    `next_retry_datetime` TIMESTAMP COMMENT '',
    `next_retry_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next delivery retry attempt after a failure.',
    `patient_portal_available_flag` BOOLEAN COMMENT 'Indicates whether the report has been made available to the patient via the patient portal.',
    `portal_release_timestamp` TIMESTAMP COMMENT 'Timestamp when the report was released to the patient portal per 21st Century Cures Act information blocking rules.',
    `priority` STRING COMMENT 'Urgency of the distribution (e.g., stat, routine, critical result notification) per ACR guidelines.',
    `priority_level` STRING COMMENT 'Priority level for distribution (stat, urgent, routine)',
    `read_receipt_flag` BOOLEAN COMMENT 'Whether read receipt was requested',
    `read_receipt_requested_flag` BOOLEAN COMMENT 'Flag indicating whether read receipt was requested',
    `read_receipt_timestamp` TIMESTAMP COMMENT 'Timestamp when recipient acknowledged reading the report',
    `read_timestamp` TIMESTAMP COMMENT 'Timestamp when report was read/opened by recipient',
    `recipient_address` STRING COMMENT 'Delivery address (fax number, Direct address, endpoint URL) for the distribution.',
    `recipient_email` STRING COMMENT '',
    `recipient_fax` STRING COMMENT 'Fax number of recipient',
    `recipient_fax_number` STRING COMMENT '',
    `recipient_identifier` STRING COMMENT 'Identifier for recipient (NPI, facility ID, Direct address, portal user ID)',
    `recipient_name` STRING COMMENT '',
    `recipient_npi` STRING COMMENT '',
    `recipient_organization` STRING COMMENT '',
    `recipient_reference_code` STRING COMMENT 'Re-derived business attribute for radiology.report_distribution: recipient_id',
    `recipient_type` STRING COMMENT '',
    `report_addendum_flag` BOOLEAN COMMENT 'Indicates this distribution is for a report addendum rather than the original report.',
    `report_format` STRING COMMENT '',
    `report_version` STRING COMMENT '',
    `retry_count` STRING COMMENT 'Number of transmission retry attempts for this specific report-partner distribution. Used to identify problematic partner connections and trigger escalation workflows after threshold exceeded.',
    `retry_flag` BOOLEAN COMMENT '',
    `retry_interval_minutes` STRING COMMENT 'Interval in minutes between retry attempts',
    `sent_timestamp` TIMESTAMP COMMENT '',
    `sla_actual_minutes` STRING COMMENT 'Actual delivery time in minutes from report signature',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the report was delivered to this trading partner within the contractual SLA timeframe specified in the data sharing agreement. Used for partner performance monitoring and contract compliance reporting.',
    `sla_target_minutes` STRING COMMENT 'SLA target in minutes for report delivery from finalization; derived from report priority and distribution type.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the radiology report was transmitted to this specific trading partner. Critical for SLA tracking and audit trail of when each partner received the report.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `verbal_notification_recipient` STRING COMMENT 'Name of person who received and read back the critical result notification.',
    `verbal_notification_timestamp` TIMESTAMP COMMENT 'Timestamp when verbal read-back confirmation was obtained for critical results.',
    `vibe_enriched_flag` BOOLEAN COMMENT 'Re-derived attribute added during thin-product expansion based on business context for radiology.report_distribution.',
    `recipient_id` BIGINT COMMENT 'recipient of the distributed report',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'time recipient acknowledged receipt',
    CONSTRAINT pk_report_distribution PRIMARY KEY(`report_distribution_id`)
) COMMENT 'Record of radiology report distribution to ordering providers, patients, and external recipients via various channels.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`transmission` (
    `transmission_id` BIGINT COMMENT 'Unique surrogate primary key for the study transmission record. Identifies a specific transmission event of one study to one trading partner.',
    `care_site_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system user who initiated the manual transmission request, if applicable. Null for automated transmissions triggered by workflow rules.',
    `interface_channel_id` BIGINT COMMENT '',
    `message_log_id` BIGINT COMMENT '',
    `modality_id` BIGINT COMMENT '',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to the imaging study that was transmitted to the external partner.',
    `teleradiology_case_id` BIGINT COMMENT '',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to the external trading partner that received the imaging study.',
    `accession_number` STRING COMMENT '',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the trading partner acknowledged successful receipt of the imaging study. Used to calculate transmission latency and confirm end-to-end delivery.',
    `bytes_transferred` BIGINT COMMENT '',
    `compression_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this transmission record was first created in the source system. Supports audit trails and data lineage tracking.',
    `destination_ae_title` STRING COMMENT '',
    `destination_host` STRING COMMENT '',
    `destination_port` STRING COMMENT '',
    `dicom_study_instance_uid` STRING COMMENT '',
    `direction` STRING COMMENT '',
    `error_code` STRING COMMENT '',
    `error_description` STRING COMMENT '',
    `error_message` STRING COMMENT 'Detailed error message or rejection reason returned by the trading partner or interface engine when transmission fails. Supports operational troubleshooting and root cause analysis.',
    `image_count_sent` STRING COMMENT '',
    `image_count_total` STRING COMMENT '',
    `image_count_transmitted` STRING COMMENT '',
    `is_complete` BOOLEAN COMMENT '',
    `is_retry` BOOLEAN COMMENT '',
    `method` STRING COMMENT 'Technical protocol or method used to transmit the imaging study to the trading partner. Indicates the interoperability standard and transport mechanism employed for this specific transmission.',
    `modality_type` STRING COMMENT '',
    `priority` STRING COMMENT '',
    `protocol_type` STRING COMMENT '',
    `purpose` STRING COMMENT 'Business reason or clinical purpose for transmitting the imaging study to this specific trading partner. Supports audit trails and compliance with data sharing agreement terms.',
    `retry_count` STRING COMMENT 'Number of retry attempts made to transmit the study to the trading partner after initial transmission failures. Supports operational troubleshooting and partner reliability assessment.',
    `series_count` STRING COMMENT '',
    `series_count_transmitted` STRING COMMENT '',
    `size_mb` DECIMAL(18,2) COMMENT 'Total size of the transmitted imaging study data in megabytes. Used for bandwidth monitoring, cost allocation, and transmission performance analysis.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the transmission met the service level agreement (SLA) time commitment defined in the data sharing agreement with the trading partner. Used for partner performance reporting and contract compliance.',
    `source_ae_title` STRING COMMENT '',
    `source_host` STRING COMMENT '',
    `transfer_duration_sec` DECIMAL(18,2) COMMENT '',
    `transfer_duration_seconds` DECIMAL(18,2) COMMENT '',
    `transfer_end_datetime` TIMESTAMP COMMENT '',
    `transfer_end_timestamp` TIMESTAMP COMMENT '',
    `transfer_start_datetime` TIMESTAMP COMMENT '',
    `transfer_start_timestamp` TIMESTAMP COMMENT '',
    `transmission_status` STRING COMMENT 'Current status of the transmission workflow. Tracks whether the study was successfully delivered, is in transit, failed, or was acknowledged/rejected by the receiving partner. Drives operational monitoring and retry logic.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the imaging study was transmitted to the trading partner. Marks the initiation of the outbound transfer via DICOM C-STORE, XDS-I, or FHIR ImagingStudy exchange.',
    `transmission_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this transmission record was most recently modified in the source system. Tracks status updates, acknowledgment receipt, and retry attempts.',
    `verification_status` STRING COMMENT '',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_transmission PRIMARY KEY(`transmission_id`)
) COMMENT 'DICOM or HL7 image/data transmission record between PACS nodes, teleradiology vendors, and external systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` (
    `network_modality_participation_id` BIGINT COMMENT 'Unique surrogate identifier for this network modality participation record. Primary key.',
    `care_site_id` BIGINT COMMENT '',
    `contract_id` BIGINT COMMENT 'Business identifier for the underlying contract or participation agreement governing this modalitys inclusion in the network. Links to contract management systems for terms, amendments, and renewal tracking.',
    `health_plan_id` BIGINT COMMENT '',
    `modality_id` BIGINT COMMENT 'Foreign key linking to the imaging modality unit participating in this network',
    `payer_contract_id` BIGINT COMMENT '',
    `payer_id` BIGINT COMMENT '',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to the provider network in which this modality participates',
    `accepting_new_referrals_flag` BOOLEAN COMMENT 'Indicates whether this modality is currently accepting new patient referrals through this network. True allows scheduling, False blocks new appointments. May differ from overall modality operational status due to network-specific capacity management.',
    `acr_accreditation_required` BOOLEAN COMMENT '',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization or pre-certification is required for imaging services on this modality within this network. True requires authorization before service, False allows direct access. Drives utilization management workflows.',
    `authorization_threshold_amount` DECIMAL(18,2) COMMENT 'Dollar amount threshold above which prior authorization is required for services on this modality. Null if authorization_required_flag is False or if all services require authorization regardless of cost.',
    `contract_end_date` DATE COMMENT '',
    `contract_start_date` DATE COMMENT '',
    `contracted_rate` DECIMAL(18,2) COMMENT 'Negotiated reimbursement rate for imaging services performed on this modality within this network. May be per-procedure, per-study, or bundled rate depending on contract terms. Used for claims adjudication and provider payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network modality participation record was created in the system. Audit field for data lineage and compliance.',
    `credentialing_status` STRING COMMENT '',
    `credentialing_verified_date` DATE COMMENT 'Date when the facility and modality credentials were verified for network participation. Required for CMS network adequacy and accreditation compliance. Typically reverified on recredentialing cycle.',
    `effective_date` DATE COMMENT 'Date when this modalitys participation in the provider network becomes active. Used for claims adjudication to determine in-network vs out-of-network status at service date.',
    `enrollment_status` STRING COMMENT '',
    `fee_schedule_code` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_in_network` BOOLEAN COMMENT '',
    `member_cost_share_tier` STRING COMMENT 'Cost-sharing tier assigned to this modality within this network, determining member copay, coinsurance, and deductible application. Aligns with network tier and modality quality/efficiency metrics.',
    `modality_type` STRING COMMENT '',
    `network_adequacy_counted_flag` BOOLEAN COMMENT 'Indicates whether this modality is counted toward network adequacy metrics for CMS or state regulatory reporting. True if modality meets adequacy criteria (accepting patients, operational, credentialed). False if excluded from adequacy calculations.',
    `network_tier` STRING COMMENT '',
    `next_credentialing_due_date` DATE COMMENT 'Scheduled date for next credentialing review of this modalitys network participation. Drives compliance workflows and network adequacy maintenance.',
    `participation_status` STRING COMMENT 'Current lifecycle status of this modalitys participation in the provider network. Active indicates the modality is currently in-network and available for member utilization. Drives claims adjudication and member cost-sharing calculations.',
    `participation_type` STRING COMMENT '',
    `quality_tier_assignment` STRING COMMENT 'Quality performance tier assigned to this modality within this network based on quality metrics, patient outcomes, and efficiency measures. Used for tiered network design and member steering.',
    `rate_type` STRING COMMENT 'Classification of how the contracted rate is structured. Per-Procedure rates apply to individual CPT codes, Per-Study rates apply to complete imaging studies, Bundled rates cover multiple services, Fee-Schedule references a standard fee schedule, Percentage-of-Charges applies a discount to billed charges.',
    `reimbursement_rate_modifier` DECIMAL(18,2) COMMENT '',
    `reimbursement_rate_pct` DECIMAL(18,2) COMMENT '',
    `service_area_code` STRING COMMENT '',
    `service_area_zip_codes` STRING COMMENT '',
    `termination_date` DATE COMMENT 'Date when this modalitys participation in the provider network ends. Null if participation is ongoing. Critical for claims processing and member notification of network changes.',
    `termination_reason` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network modality participation record was last updated. Audit field for change tracking and data quality monitoring.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_network_modality_participation PRIMARY KEY(`network_modality_participation_id`)
) COMMENT 'Network participation record for imaging modalities, tracking payer network enrollment and service agreements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` (
    `radiology_finding_id` BIGINT COMMENT '',
    `clinical_finding_id` BIGINT COMMENT '',
    `clinician_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `dicom_series_id` BIGINT COMMENT 'Foreign key linking to radiology.dicom_series. Business justification: A structured finding annotates a specific image series (radiology_finding has dicom_series_uid and pacs_series_uid). Linking to dicom_series enables image-localized findings. No reverse FK from dicom_',
    `icd_code_id` BIGINT COMMENT '',
    `imaging_order_id` BIGINT COMMENT '',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: Structured findings are extracted from a studys images (radiology_finding has dicom_series_uid, pacs_series_uid). It links to imaging_order and report but not directly to the study. Direct study FK a',
    `report_id` BIGINT COMMENT '',
    `research_study_id` BIGINT COMMENT '',
    `snomed_concept_id` BIGINT COMMENT '',
    `visit_id` BIGINT COMMENT '',
    `accession_number` STRING COMMENT '',
    `acr_score_type` STRING COMMENT '',
    `acr_score_value` DECIMAL(18,2) COMMENT '',
    `body_site_code` STRING COMMENT '',
    `body_site_description` STRING COMMENT '',
    `code_system` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_source_method` STRING COMMENT '',
    `dicom_series_uid` STRING COMMENT '',
    `dicom_sop_instance_uid` STRING COMMENT '',
    `escalation_status` STRING COMMENT '',
    `escalation_timestamp` TIMESTAMP COMMENT '',
    `finding_category` STRING COMMENT '',
    `finding_context` STRING COMMENT '',
    `finding_description` STRING COMMENT '',
    `finding_status` STRING COMMENT '',
    `follow_up_completed_date` DATE COMMENT '',
    `follow_up_due_date` DATE COMMENT '',
    `follow_up_modality` STRING COMMENT '',
    `follow_up_recommended` BOOLEAN COMMENT '',
    `follow_up_status` STRING COMMENT '',
    `follow_up_timeframe_days` STRING COMMENT '',
    `follow_up_type` STRING COMMENT '',
    `imaging_modality` STRING COMMENT '',
    `is_critical_result` BOOLEAN COMMENT '',
    `is_incidental_finding` BOOLEAN COMMENT '',
    `laterality` STRING COMMENT '',
    `measurement_unit` STRING COMMENT '',
    `measurement_value` DECIMAL(18,2) COMMENT '',
    `merged_with_clinical_clinical_finding` STRING COMMENT 'SSOT reconciliation attribute added by vibe cross-domain dedup pass.',
    `nlp_confidence_score` DECIMAL(18,2) COMMENT '',
    `nlp_extracted` BOOLEAN COMMENT '',
    `notification_datetime` TIMESTAMP COMMENT '',
    `notification_status` STRING COMMENT '',
    `pacs_series_uid` STRING COMMENT '',
    `patient_safety_event_flag` BOOLEAN COMMENT '',
    `radlex_code` STRING COMMENT '',
    `snomed_code` STRING COMMENT '',
    `ssot_canonical_reference` STRING COMMENT 'Distinct entity; counterpart clinical.clinical_finding serves a separate domain context',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT review: kept distinct from clinical.clinical_finding (documented as separate business concepts)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_reconciled_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_radiology_finding PRIMARY KEY(`radiology_finding_id`)
) COMMENT 'Structured radiology finding extracted from reports, supporting follow-up tracking and incidental finding management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` (
    `radiology_peer_review_id` BIGINT COMMENT '',
    `audit_finding_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `corrective_action_plan_id` BIGINT COMMENT '',
    `cpt_code_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `report_id` BIGINT COMMENT '',
    `report_addendum_id` BIGINT COMMENT '',
    `visit_id` BIGINT COMMENT '',
    `accession_number` STRING COMMENT '',
    `acr_accreditation_cycle` STRING COMMENT '',
    `acr_radpeer_score` STRING COMMENT '',
    `blinded_review_flag` BOOLEAN COMMENT '',
    `body_part_examined` STRING COMMENT '',
    `case_conference_flag` BOOLEAN COMMENT '',
    `clinical_history_available_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `discrepancy_category` STRING COMMENT '',
    `discrepancy_description` STRING COMMENT '',
    `discrepancy_type` STRING COMMENT '',
    `educational_feedback_flag` BOOLEAN COMMENT '',
    `escalated_to_chair_flag` BOOLEAN COMMENT '',
    `icd10_finding_code` STRING COMMENT '',
    `merged_with_quality_quality_peer_review` STRING COMMENT 'SSOT reconciliation attribute added by vibe cross-domain dedup pass.',
    `modality_code` STRING COMMENT '',
    `oppe_fppe_flag` BOOLEAN COMMENT '',
    `original_radiologist_npi` STRING COMMENT '',
    `original_radiologist_response` STRING COMMENT '',
    `original_report_finalized_datetime` TIMESTAMP COMMENT '',
    `patient_safety_event_flag` BOOLEAN COMMENT '',
    `prior_study_available_flag` BOOLEAN COMMENT '',
    `response_datetime` TIMESTAMP COMMENT '',
    `review_assigned_datetime` TIMESTAMP COMMENT '',
    `review_datetime` TIMESTAMP COMMENT '',
    `review_disposition` STRING COMMENT '',
    `review_program_type` STRING COMMENT '',
    `review_status` STRING COMMENT '',
    `review_type` STRING COMMENT '',
    `reviewer_comments` STRING COMMENT '',
    `reviewer_radiologist_npi` STRING COMMENT '',
    `ssot_canonical_reference` STRING COMMENT 'Distinct entity; counterpart quality.quality_peer_review serves a separate domain context',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT review: kept distinct from quality.quality_peer_review (documented as separate business concepts)',
    `study_datetime` TIMESTAMP COMMENT '',
    `subspecialty` STRING COMMENT '',
    `subspecialty_matched_flag` BOOLEAN COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_radiology_peer_review PRIMARY KEY(`radiology_peer_review_id`)
) COMMENT 'Radiology peer review record supporting ACR RADPEER scoring, OPPE/FPPE, and quality improvement programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` (
    `distribution_rule_id` BIGINT COMMENT 'Primary key for distribution_rule',
    `parent_distribution_rule_id` BIGINT COMMENT 'Self-referencing FK on distribution_rule (parent_distribution_rule_id)',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether the recipient must acknowledge receipt of the report to satisfy closed-loop communication requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution rule record was first captured in the system.',
    `critical_result_flag` BOOLEAN COMMENT 'Indicates whether this rule governs distribution of critical or significant unexpected radiology findings requiring closed-loop communication.',
    `delivery_channel` STRING COMMENT 'The channel through which the radiology report is delivered to recipients (e.g., HL7 ORU message, secure email, fax, patient/provider portal).',
    `effective_from_date` DATE COMMENT 'Date from which this distribution rule becomes active and is applied to qualifying radiology reports.',
    `effective_until_date` DATE COMMENT 'Date after which this distribution rule is no longer applied; nullable for open-ended rules.',
    `escalation_minutes` STRING COMMENT 'Time threshold in minutes after which an unacknowledged distribution escalates to the next recipient or escalation path.',
    `facility_scope` STRING COMMENT 'Identifies the facility or imaging site to which this distribution rule applies, enabling multi-facility routing differentiation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution rule record was last modified.',
    `modality_filter` STRING COMMENT 'Imaging modality criterion that scopes the rule to specific modalities. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|MG|NM|FL — promote to reference product]',
    `phi_masking_flag` BOOLEAN COMMENT 'Indicates whether Protected Health Information must be masked or de-identified in the distributed report copy for this rule.',
    `priority_order` STRING COMMENT 'Numeric evaluation order that determines the sequence in which distribution rules are applied when multiple rules match a report.',
    `procedure_code_filter` STRING COMMENT 'Current Procedural Terminology (CPT) procedure code criterion used to scope the rule to specific radiology procedures.',
    `recipient_address` STRING COMMENT 'The configured delivery endpoint for the recipient such as a fax number, secure email address, or HL7 endpoint identifier.',
    `recipient_role` STRING COMMENT 'The role of the intended recipient(s) to whom the radiology report is distributed under this rule.',
    `report_priority_filter` STRING COMMENT 'Report priority criterion that limits the rule to reports of a given clinical urgency such as STAT or routine.',
    `retry_limit` STRING COMMENT 'Maximum number of automated delivery retry attempts before the distribution is marked as failed or escalated.',
    `rule_code` STRING COMMENT 'Externally-known short code that uniquely identifies the distribution rule within the Radiology Information System (RIS) and PACS configuration.',
    `rule_description` STRING COMMENT 'Detailed business description of what the distribution rule does, the clinical workflow it supports, and the conditions under which radiology reports are routed.',
    `rule_name` STRING COMMENT 'Human-readable name describing the report distribution rule (e.g., STAT CT Head to ED Physician).',
    `rule_status` STRING COMMENT 'Current lifecycle state of the distribution rule indicating whether it is in service for report routing.',
    `rule_type` STRING COMMENT 'Categorical classification of the rule that segments routing behavior such as automatic routing, escalation, or carbon-copy distribution.',
    `source_system` STRING COMMENT 'The originating Radiology Information System or PACS that manages and enforces this distribution rule (e.g., Epic Radiant, Cerner RadNet).',
    `trigger_event` STRING COMMENT 'The radiology workflow event that triggers evaluation and execution of this distribution rule.',
    CONSTRAINT pk_distribution_rule PRIMARY KEY(`distribution_rule_id`)
) COMMENT 'Master reference table for distribution_rule. Referenced by distribution_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_parent_protocol_id` FOREIGN KEY (`parent_protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_primary_superseded_by_protocol_id` FOREIGN KEY (`primary_superseded_by_protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_prior_assignment_reader_assignment_id` FOREIGN KEY (`prior_assignment_reader_assignment_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`reader_assignment`(`reader_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_teleradiology_case_id` FOREIGN KEY (`teleradiology_case_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`teleradiology_case`(`teleradiology_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_radiology_finding_id` FOREIGN KEY (`radiology_finding_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_finding`(`radiology_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_follow_imaging_order_id` FOREIGN KEY (`follow_imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_follow_original_imaging_order_id` FOREIGN KEY (`follow_original_imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_follow_radiology_report_id` FOREIGN KEY (`follow_radiology_report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_follow_report_id` FOREIGN KEY (`follow_report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_radiology_finding_id` FOREIGN KEY (`radiology_finding_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_finding`(`radiology_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_contrast_admin_id` FOREIGN KEY (`contrast_admin_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`contrast_admin`(`contrast_admin_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_dose_record_id` FOREIGN KEY (`dose_record_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`dose_record`(`dose_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_corrected_history_id` FOREIGN KEY (`corrected_history_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history`(`radiology_order_status_history_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_distribution_rule_id` FOREIGN KEY (`distribution_rule_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`distribution_rule`(`distribution_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_teleradiology_case_id` FOREIGN KEY (`teleradiology_case_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`teleradiology_case`(`teleradiology_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_dicom_series_id` FOREIGN KEY (`dicom_series_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`dicom_series`(`dicom_series_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_report_addendum_id` FOREIGN KEY (`report_addendum_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report_addendum`(`report_addendum_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ADD CONSTRAINT `fk_radiology_distribution_rule_parent_distribution_rule_id` FOREIGN KEY (`parent_distribution_rule_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`distribution_rule`(`distribution_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`radiology` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`radiology` SET TAGS ('pii_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_clinical_order' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_radiology_workflow' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Drug');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Material');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `hie_query_id` SET TAGS ('pii_business_glossary_term' = 'HIE Query');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Lab Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('pii_business_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `contrast_required` SET TAGS ('pii_business_glossary_term' = 'Contrast Required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `exam_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Exam End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `exam_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Exam Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `is_portable` SET TAGS ('pii_business_glossary_term' = 'Portable Exam');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `is_stat_override` SET TAGS ('pii_business_glossary_term' = 'STAT Override');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_business_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_priority` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|asap|elective');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_source` SET TAGS ('pii_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_source` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency|ambulatory|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_status` SET TAGS ('pii_value_regex' = 'ordered|scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordered_timestamp` SET TAGS ('pii_business_glossary_term' = 'Ordered Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_auth_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_auth_status` SET TAGS ('pii_value_regex' = 'approved|pending|denied|not_required|expired');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_business_glossary_term' = 'CTDI Radiation Dose');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'DLP Radiation Dose');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `referring_department` SET TAGS ('pii_business_glossary_term' = 'Referring Department');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'not_started|preliminary|final|addendum|corrected');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `scheduled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `source_system_order_code` SET TAGS ('pii_business_glossary_term' = 'Source System Order Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_imaging_study' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_pacs' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_mvm_alias' = 'study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_mvm_included' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Drug');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `hie_query_id` SET TAGS ('pii_business_glossary_term' = 'HIE Query');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_icd10_primary_icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_principal_investigator_employee_id` SET TAGS ('pii_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_principal_investigator_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_principal_investigator_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `accession_number` SET TAGS ('pii_business_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `actual_enrollment` SET TAGS ('pii_business_glossary_term' = 'Actual Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `amendment_count` SET TAGS ('pii_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `blinding_type` SET TAGS ('pii_business_glossary_term' = 'Blinding Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `blinding_type` SET TAGS ('pii_value_regex' = 'open_label|single_blind|double_blind|triple_blind|quadruple_blind');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `cfr_part_11_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Code of Federal Regulations (CFR) Part 11 Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `contrast_administered` SET TAGS ('pii_business_glossary_term' = 'Contrast Administered');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `control_type` SET TAGS ('pii_business_glossary_term' = 'Control Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `control_type` SET TAGS ('pii_value_regex' = 'placebo|active_comparator|no_intervention|sham|dose_comparison|historical');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `coordinating_center` SET TAGS ('pii_business_glossary_term' = 'Coordinating Center');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `critical_finding_notified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Notified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `data_monitoring_committee_flag` SET TAGS ('pii_business_glossary_term' = 'Data Monitoring Committee (DMC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `exclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `fda_regulated_device_flag` SET TAGS ('pii_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `fda_regulated_drug_flag` SET TAGS ('pii_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Drug Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `fda_regulated_drug_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `funding_source` SET TAGS ('pii_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `ide_number` SET TAGS ('pii_business_glossary_term' = 'Investigational Device Exemption (IDE) Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `image_count` SET TAGS ('pii_business_glossary_term' = 'Image Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `import_method` SET TAGS ('pii_business_glossary_term' = 'Import Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `import_method` SET TAGS ('pii_value_regex' = 'cd_dvd|direct_dicom|fax_scan|hie_exchange|vendor_neutral_archive|patient_portal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `inclusion_criteria` SET TAGS ('pii_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `ind_number` SET TAGS ('pii_business_glossary_term' = 'Investigational New Drug (IND) Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `irb_approval_date` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `irb_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `irb_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `irb_protocol_number` SET TAGS ('pii_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `is_external_import` SET TAGS ('pii_business_glossary_term' = 'External Import');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `is_stat_read_completed` SET TAGS ('pii_business_glossary_term' = 'STAT Read Completed');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_alias_name` SET TAGS ('pii_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_alias_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_alias_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_ecm_reconciled_flag` SET TAGS ('pii_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_business_glossary_term' = 'National Clinical Trial (NCT) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `nct_identifier` SET TAGS ('pii_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `order_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Order Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `pacs_archive_location` SET TAGS ('pii_business_glossary_term' = 'PACS Archive Location');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `pacs_status` SET TAGS ('pii_business_glossary_term' = 'PACS Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `pacs_status` SET TAGS ('pii_value_regex' = 'received|archived|retrieved|purged|error');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_business_glossary_term' = 'Patient Age at Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_sex` SET TAGS ('pii_business_glossary_term' = 'Patient Sex');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_sex` SET TAGS ('pii_value_regex' = 'M|F|O|U');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_sex` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_sex` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `patient_sex` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `phase` SET TAGS ('pii_business_glossary_term' = 'Study Phase');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `primary_completion_date` SET TAGS ('pii_business_glossary_term' = 'Primary Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `primary_outcome_measure` SET TAGS ('pii_business_glossary_term' = 'Primary Outcome Measure');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|elective');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `protocol_number` SET TAGS ('pii_business_glossary_term' = 'Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `protocol_version` SET TAGS ('pii_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `protocol_version_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Version Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_business_glossary_term' = 'CTDI Volume');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `randomization_flag` SET TAGS ('pii_business_glossary_term' = 'Randomization Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `reconciled_from_mvm` SET TAGS ('pii_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `reconciliation_source` SET TAGS ('pii_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `referring_department` SET TAGS ('pii_business_glossary_term' = 'Referring Department');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'preliminary|final|addendum|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `ris_system_source` SET TAGS ('pii_business_glossary_term' = 'RIS System Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `ris_system_source` SET TAGS ('pii_value_regex' = 'epic_radiant|cerner_radnet|meditech|other');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `secondary_outcome_measures` SET TAGS ('pii_business_glossary_term' = 'Secondary Outcome Measures');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `series_count` SET TAGS ('pii_business_glossary_term' = 'Series Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `short_title` SET TAGS ('pii_business_glossary_term' = 'Study Short Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `size_mb` SET TAGS ('pii_business_glossary_term' = 'Size MB');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `source_facility_name` SET TAGS ('pii_business_glossary_term' = 'Source Facility Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `source_facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `source_facility_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `sponsor_name` SET TAGS ('pii_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `sponsor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `sponsor_type` SET TAGS ('pii_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `sponsor_type` SET TAGS ('pii_value_regex' = 'industry|academic|government|non_profit|investigator_initiated');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_business_glossary_term' = 'SSOT Canonical Reference');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'SSOT Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Study Start Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_date` SET TAGS ('pii_business_glossary_term' = 'Study Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_description` SET TAGS ('pii_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_status` SET TAGS ('pii_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_status` SET TAGS ('pii_value_regex' = 'scheduled|arrived|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_type` SET TAGS ('pii_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_type` SET TAGS ('pii_value_regex' = 'interventional|observational|expanded_access|registry|diagnostic|prevention');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `target_enrollment` SET TAGS ('pii_business_glossary_term' = 'Target Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Study Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_dicom' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_pacs' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_imaging_series' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dicom_series_id` SET TAGS ('pii_business_glossary_term' = 'DICOM Series Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Performing Technologist');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('pii_business_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_agent` SET TAGS ('pii_business_glossary_term' = 'Contrast Bolus Agent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_route` SET TAGS ('pii_business_glossary_term' = 'Contrast Bolus Route');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_route` SET TAGS ('pii_value_regex' = 'IV|ORAL|RECTAL|INTRA_ARTERIAL|INTRATHECAL');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Bolus Volume');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `cpt_code` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `cpt_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `ctdi_vol_mgy` SET TAGS ('pii_business_glossary_term' = 'CTDI Volume');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dlp_mgy_cm` SET TAGS ('pii_business_glossary_term' = 'DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `exposure_ma` SET TAGS ('pii_business_glossary_term' = 'Exposure mA');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `exposure_time_ms` SET TAGS ('pii_business_glossary_term' = 'Exposure Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `image_orientation_patient` SET TAGS ('pii_business_glossary_term' = 'Image Orientation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `image_orientation_patient` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `image_orientation_patient` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `kvp` SET TAGS ('pii_business_glossary_term' = 'kVp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'L|R|B|U');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `number_of_series_related_instances` SET TAGS ('pii_business_glossary_term' = 'Number of Instances');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_archive_status` SET TAGS ('pii_business_glossary_term' = 'PACS Archive Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_archive_status` SET TAGS ('pii_value_regex' = 'online|nearline|offline|archived|pending_archive');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_storage_path` SET TAGS ('pii_business_glossary_term' = 'PACS Storage Path');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `patient_position` SET TAGS ('pii_business_glossary_term' = 'Patient Position');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `patient_position` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `patient_position` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_business_glossary_term' = 'Performing Physician Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pixel_spacing_mm` SET TAGS ('pii_business_glossary_term' = 'Pixel Spacing');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pixel_spacing_mm` SET TAGS ('pii_value_regex' = '^[0-9]+.[0-9]+[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_business_glossary_term' = 'Procedure Code Modifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_comments` SET TAGS ('pii_business_glossary_term' = 'QC Comments');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_status` SET TAGS ('pii_business_glossary_term' = 'QC Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_status` SET TAGS ('pii_value_regex' = 'pending|passed|failed|not_required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_business_glossary_term' = 'Referring Physician NPI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_business_glossary_term' = 'Requesting Physician Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_completeness_flag` SET TAGS ('pii_business_glossary_term' = 'Series Completeness Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_date` SET TAGS ('pii_business_glossary_term' = 'Series Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_description` SET TAGS ('pii_business_glossary_term' = 'Series Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('pii_business_glossary_term' = 'Series Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('pii_value_regex' = '^[0-9.]+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('pii_business_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_number` SET TAGS ('pii_business_glossary_term' = 'Series Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_status` SET TAGS ('pii_business_glossary_term' = 'Series Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_status` SET TAGS ('pii_value_regex' = 'acquired|archived|quality_review|approved|rejected|deleted');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_time` SET TAGS ('pii_business_glossary_term' = 'Series Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `slice_thickness_mm` SET TAGS ('pii_business_glossary_term' = 'Slice Thickness');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Report Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Primary Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Addendum Author ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `tertiary_report_reading_radiologist_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Reading Radiologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Transcriptionist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_sequence` SET TAGS ('pii_business_glossary_term' = 'Addendum Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('pii_business_glossary_term' = 'Addendum Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_timestamp` SET TAGS ('pii_business_glossary_term' = 'Addendum Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_type` SET TAGS ('pii_business_glossary_term' = 'Addendum Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_type` SET TAGS ('pii_value_regex' = 'addendum|amendment|correction|retraction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `attestation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_administered_flag` SET TAGS ('pii_business_glossary_term' = 'Contrast Administered Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_communicated_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Communicated Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_communicated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Communication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `dictation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dictation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('pii_business_glossary_term' = 'Findings Narrative Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `follow_up_recommendation` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('pii_business_glossary_term' = 'Impression Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `modality_code` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `preliminary_timestamp` SET TAGS ('pii_business_glossary_term' = 'Preliminary Report Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose CT Dose Index Volume (CTDIvol) mGy');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Dose Length Product (DLP) mGy·cm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `rads_category` SET TAGS ('pii_business_glossary_term' = 'Reporting and Data System (RADS) Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'preliminary|final|addendum|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `ris_report_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Signing Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `stat_priority_flag` SET TAGS ('pii_business_glossary_term' = 'STAT Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `study_datetime` SET TAGS ('pii_business_glossary_term' = 'Study Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `study_description` SET TAGS ('pii_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `template_code` SET TAGS ('pii_business_glossary_term' = 'Report Template ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `transcription_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transcription Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `report_addendum_id` SET TAGS ('pii_business_glossary_term' = 'Report Addendum ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cdi_query_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'HL7 Message ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Department ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Original Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Addendum Author Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `tertiary_report_ordering_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `acknowledgment_datetime` SET TAGS ('pii_business_glossary_term' = 'Provider Acknowledgment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_datetime` SET TAGS ('pii_business_glossary_term' = 'Addendum Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Addendum Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_status` SET TAGS ('pii_business_glossary_term' = 'Addendum Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_status` SET TAGS ('pii_value_regex' = 'draft|pending_review|finalized|retracted');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_text` SET TAGS ('pii_business_glossary_term' = 'Addendum Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_type` SET TAGS ('pii_business_glossary_term' = 'Addendum Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_type` SET TAGS ('pii_value_regex' = 'correction|clarification|clinical_update|addendum|retraction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_word_count` SET TAGS ('pii_business_glossary_term' = 'Addendum Word Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `amendment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_business_glossary_term' = 'Addendum Author National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `drg_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Diagnosis-Related Group (DRG) Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `drg_impact_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `finalized_datetime` SET TAGS ('pii_business_glossary_term' = 'Addendum Finalized Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `him_review_datetime` SET TAGS ('pii_business_glossary_term' = 'Health Information Management (HIM) Review Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `him_review_flag` SET TAGS ('pii_business_glossary_term' = 'Health Information Management (HIM) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `impression_changed_flag` SET TAGS ('pii_business_glossary_term' = 'Impression Changed Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_datetime` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Notification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_method` SET TAGS ('pii_value_regex' = 'in_basket|secure_message|phone|fax|ehr_alert|email');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_status` SET TAGS ('pii_value_regex' = 'not_required|pending|sent|acknowledged|failed');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `original_report_finalized_datetime` SET TAGS ('pii_business_glossary_term' = 'Original Report Finalized Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `peer_review_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `peer_review_score` SET TAGS ('pii_business_glossary_term' = 'Peer Review Score');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `peer_review_score` SET TAGS ('pii_value_regex' = '1|2a|2b|3a|3b|4');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `source_system_addendum_code` SET TAGS ('pii_business_glossary_term' = 'Source System Addendum ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `voice_recognition_flag` SET TAGS ('pii_business_glossary_term' = 'Voice Recognition Dictation Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Primary Operator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'ACR Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_expiration_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'American College of Radiology (ACR) Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('pii_value_regex' = 'accredited|provisional|denied|expired|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ae_title` SET TAGS ('pii_business_glossary_term' = 'DICOM Application Entity (AE) Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ae_title` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{1,16}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `bore_diameter_cm` SET TAGS ('pii_business_glossary_term' = 'Gantry Bore Diameter (cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `building_code` SET TAGS ('pii_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `contrast_capable` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Capable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `decommission_date` SET TAGS ('pii_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `detector_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Detector Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dicom_modality_code` SET TAGS ('pii_business_glossary_term' = 'DICOM Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dicom_modality_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Tracking Enabled Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `equipment_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Equipment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_510k_number` SET TAGS ('pii_business_glossary_term' = 'FDA 510(k) Clearance Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_510k_number` SET TAGS ('pii_value_regex' = '^K[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('pii_business_glossary_term' = 'FDA Device Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('pii_value_regex' = '^[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_business_glossary_term' = 'Mobile Equipment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_calibration_date` SET TAGS ('pii_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_calibration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Equipment Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `max_patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Maximum Patient Weight Capacity (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `max_patient_weight_kg` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `max_patient_weight_kg` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_business_glossary_term' = 'Equipment Model Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_calibration_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_calibration_due_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_preventive_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Preventive Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'active|inactive|under_maintenance|decommissioned|pending_installation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_business_glossary_term' = 'PACS (Picture Archiving and Communication System) Node Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_business_glossary_term' = 'Radiation Emitting Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ris_resource_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_business_glossary_term' = 'Room Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `scheduled_hours_per_day` SET TAGS ('pii_business_glossary_term' = 'Scheduled Operating Hours Per Day');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `serial_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_number` SET TAGS ('pii_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `shared_service_indicator` SET TAGS ('pii_business_glossary_term' = 'Shared Service Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `slice_count` SET TAGS ('pii_business_glossary_term' = 'CT Detector Slice Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `software_version` SET TAGS ('pii_business_glossary_term' = 'Equipment Software Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `tesla_field_strength` SET TAGS ('pii_business_glossary_term' = 'MRI Magnetic Field Strength (Tesla)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_code` SET TAGS ('pii_business_glossary_term' = 'Modality Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_business_glossary_term' = 'Modality Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Protocol Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Approving Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinician_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `drug_master_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `parent_protocol_id` SET TAGS ('pii_business_glossary_term' = 'Parent Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `primary_superseded_by_protocol_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_business_glossary_term' = 'ACR Appropriateness Criteria Rating');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_value_regex' = 'usually_appropriate|may_be_appropriate|usually_not_appropriate');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_category` SET TAGS ('pii_business_glossary_term' = 'Protocol Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_category` SET TAGS ('pii_value_regex' = 'diagnostic|screening|interventional|research|emergency|pediatric');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_code` SET TAGS ('pii_business_glossary_term' = 'Protocol Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Dose (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_flow_rate_ml_per_sec` SET TAGS ('pii_business_glossary_term' = 'Contrast Flow Rate (mL/sec)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_flow_rate_ml_per_sec` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_required` SET TAGS ('pii_business_glossary_term' = 'Contrast Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_route` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Route');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_route` SET TAGS ('pii_value_regex' = 'intravenous|oral|rectal|intrathecal|intra_articular|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_business_glossary_term' = 'Dose Optimization Program');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_value_regex' = 'image_gently|image_wisely|acr_dir|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Fasting Duration (hours)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_business_glossary_term' = 'Fasting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `field_of_view_mm` SET TAGS ('pii_business_glossary_term' = 'Field of View (FOV) (mm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `implant_screening_required` SET TAGS ('pii_business_glossary_term' = 'Implant Screening Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `kvp` SET TAGS ('pii_business_glossary_term' = 'Peak Kilovoltage (kVp)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `magnetic_field_strength_tesla` SET TAGS ('pii_business_glossary_term' = 'Magnetic Field Strength (Tesla)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `mas` SET TAGS ('pii_business_glossary_term' = 'Milliampere-Seconds (mAs)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_business_glossary_term' = 'PACS Routing Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('pii_business_glossary_term' = 'Patient Population');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('pii_value_regex' = 'adult|pediatric|neonatal|geriatric|obstetric|all');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_prep_instructions` SET TAGS ('pii_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_prep_instructions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_prep_instructions` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pitch_factor` SET TAGS ('pii_business_glossary_term' = 'CT Pitch Factor');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_status` SET TAGS ('pii_business_glossary_term' = 'Protocol Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_status` SET TAGS ('pii_value_regex' = 'active|inactive|draft|retired|under_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pulse_sequence_type` SET TAGS ('pii_business_glossary_term' = 'MRI Pulse Sequence Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_business_glossary_term' = 'Reference CT Dose Index Volume (CTDIvol) (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_business_glossary_term' = 'Reference Radiation Dose - Dose Length Product (DLP) (mGy·cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radlex_code` SET TAGS ('pii_business_glossary_term' = 'RSNA RadLex Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radlex_code` SET TAGS ('pii_value_regex' = '^RIDd+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `reconstruction_algorithm` SET TAGS ('pii_business_glossary_term' = 'Reconstruction Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `renal_function_check_required` SET TAGS ('pii_business_glossary_term' = 'Renal Function Check Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `scan_duration_estimate_sec` SET TAGS ('pii_business_glossary_term' = 'Estimated Scan Duration (seconds)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `scan_duration_estimate_sec` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `sedation_required` SET TAGS ('pii_business_glossary_term' = 'Sedation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `slice_thickness_mm` SET TAGS ('pii_business_glossary_term' = 'Slice Thickness (mm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `total_exam_duration_min` SET TAGS ('pii_business_glossary_term' = 'Total Exam Duration Estimate (minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `total_exam_duration_min` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `version` SET TAGS ('pii_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_admin_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Admin Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Administering Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `drug_master_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Power Injector Device ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `osha_exposure_incident_id` SET TAGS ('pii_business_glossary_term' = 'Osha Exposure Incident Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `test_result_id` SET TAGS ('pii_business_glossary_term' = 'Egfr Lab Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `test_result_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `test_result_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_business_glossary_term' = 'Administering Clinician National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_value_regex' = '^d{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_datetime` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_datetime` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_status` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_status` SET TAGS ('pii_value_regex' = 'completed|in-progress|not-done|on-hold|stopped|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_datetime` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_occurred` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Occurred Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Severity');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_value_regex' = 'mild|moderate|severe|life-threatening');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Treatment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_class` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Class');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_class` SET TAGS ('pii_value_regex' = 'iodinated|gadolinium-based|barium|microbubble|manganese-based|iron-based');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_osmolality_type` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Osmolality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_osmolality_type` SET TAGS ('pii_value_regex' = 'low-osmolality|iso-osmolality|high-osmolality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `body_region` SET TAGS ('pii_business_glossary_term' = 'Imaging Body Region');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `catheter_gauge` SET TAGS ('pii_business_glossary_term' = 'Intravenous Catheter Gauge');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `concentration_mg_per_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Concentration (mg/mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `concentration_mg_per_ml` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_business_glossary_term' = 'Contrast Allergy Screening Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_value_regex' = 'no-allergy|prior-reaction|allergy-confirmed|screening-not-done|contraindicated');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_business_glossary_term' = 'Contrast Dose Amount (mg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Dose Volume (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `extravasation_occurred` SET TAGS ('pii_business_glossary_term' = 'Contrast Extravasation Occurred Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `extravasation_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Extravasation Volume (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `informed_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `informed_consent_obtained` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `informed_consent_obtained` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_rate_ml_per_sec` SET TAGS ('pii_business_glossary_term' = 'Injection Rate (mL/sec)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_rate_ml_per_sec` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_site` SET TAGS ('pii_business_glossary_term' = 'Injection Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `metformin_held` SET TAGS ('pii_business_glossary_term' = 'Metformin Held Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Patient Weight at Administration (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `power_injector_used` SET TAGS ('pii_business_glossary_term' = 'Power Injector Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_business_glossary_term' = 'Pregnancy Status at Administration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_value_regex' = 'not-pregnant|pregnant|unknown|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_business_glossary_term' = 'Pre-Medication Details');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_business_glossary_term' = 'Pre-Medication Given Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('pii_business_glossary_term' = 'Prior Contrast Reaction Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('pii_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('pii_value_regex' = 'intravenous|oral|intrathecal|intra-arterial|intraperitoneal|rectal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('pii_business_glossary_term' = 'Thyroid Disease Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_business_glossary_term' = 'Dose Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_business_glossary_term' = 'Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewing Physicist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `contrast_administered` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Administered Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `contrast_agent_type` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `contrast_agent_type` SET TAGS ('pii_value_regex' = 'iodinated|gadolinium|barium|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `ctdivol_mgy` SET TAGS ('pii_business_glossary_term' = 'CT Dose Index Volume (CTDIvol) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_business_glossary_term' = 'Cumulative Patient Radiation Dose (mSv)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dap_gy_cm2` SET TAGS ('pii_business_glossary_term' = 'Dose Area Product (DAP) in Gray-Centimeter Squared (Gy·cm²)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dlp_mgy_cm` SET TAGS ('pii_business_glossary_term' = 'Dose Length Product (DLP) in Milligray-Centimeter (mGy·cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_business_glossary_term' = 'Dose Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_business_glossary_term' = 'Dose Alert Threshold Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_business_glossary_term' = 'Dose Alert Threshold Value');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_business_glossary_term' = 'Dose Record Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_value_regex' = 'preliminary|final|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_business_glossary_term' = 'ACR Dose Index Registry (DIR) Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_value_regex' = 'pending|submitted|accepted|rejected|not_required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dose Registry Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `drl_comparison_result` SET TAGS ('pii_business_glossary_term' = 'Diagnostic Reference Level (DRL) Comparison Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `drl_comparison_result` SET TAGS ('pii_value_regex' = 'below_drl|at_drl|above_drl|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_business_glossary_term' = 'Effective Dose Estimate in Millisievert (mSv)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_business_glossary_term' = 'Entrance Skin Dose (ESD) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `fluoroscopy_time_sec` SET TAGS ('pii_business_glossary_term' = 'Fluoroscopy Time in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `kvp` SET TAGS ('pii_business_glossary_term' = 'Peak Kilovoltage (kVp)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `number_of_exposures` SET TAGS ('pii_business_glossary_term' = 'Number of Exposures');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_business_glossary_term' = 'Patient Age at Study (Years)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_business_glossary_term' = 'Patient Size (Effective Diameter) in Centimeters (cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Patient Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `physicist_review_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Physicist Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `physicist_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Medical Physicist Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `rdsr_uid` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Structured Report (RDSR) Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `reference_air_kerma_mgy` SET TAGS ('pii_business_glossary_term' = 'Reference Air Kerma (RAK) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `ssde_mgy` SET TAGS ('pii_business_glossary_term' = 'Size-Specific Dose Estimate (SSDE) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `study_date` SET TAGS ('pii_business_glossary_term' = 'Study Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `study_timestamp` SET TAGS ('pii_business_glossary_term' = 'Study Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `tube_current_mas` SET TAGS ('pii_business_glossary_term' = 'Tube Current-Time Product (mAs)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Administered Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Claim Eligibility Verification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Technologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `encounter_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `network_affiliation_id` SET TAGS ('pii_business_glossary_term' = 'Network Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `provider_payer_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Payer Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Modality Room ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_room_id` SET TAGS ('pii_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_visit_reason_icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_visit_reason_icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referring Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Enterprise Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `tertiary_radiology_referring_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_comment` SET TAGS ('pii_business_glossary_term' = 'Appointment Comment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_number` SET TAGS ('pii_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_status` SET TAGS ('pii_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_status` SET TAGS ('pii_value_regex' = 'scheduled|arrived|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_type` SET TAGS ('pii_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `arrival_timestamp` SET TAGS ('pii_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `auth_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `auth_status` SET TAGS ('pii_value_regex' = 'approved|pending|denied|not_required|expired');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `billing_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Billing Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `booking_channel` SET TAGS ('pii_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `booking_channel` SET TAGS ('pii_value_regex' = 'phone|online-portal|mobile-app|in-person|referral|system-generated');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('pii_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_value_regex' = 'patient|provider|facility|system');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('pii_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('pii_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('pii_value_regex' = 'pending|confirmed|declined|needs-action');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `contrast_required` SET TAGS ('pii_business_glossary_term' = 'Contrast Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `contrast_type` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `contrast_type` SET TAGS ('pii_value_regex' = 'IV|oral|intrathecal|intra_articular|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Appointment End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('pii_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('pii_value_regex' = 'verified|pending|failed|not-required|expired');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Insurance Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `is_portable` SET TAGS ('pii_business_glossary_term' = 'Portable Imaging Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `is_stat` SET TAGS ('pii_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `no_show_flag` SET TAGS ('pii_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `no_show_reason` SET TAGS ('pii_business_glossary_term' = 'No-Show Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_device_type` SET TAGS ('pii_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_device_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_device_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_location` SET TAGS ('pii_business_glossary_term' = 'Patient Location at Time of Appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_location` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_location` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `prep_instructions` SET TAGS ('pii_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Pre-Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Appointment Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|elective|emergent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `provider_attestation_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Tracking Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `reconciliation_source` SET TAGS ('pii_sensitivity' = 'internal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `reconciliation_source` SET TAGS ('pii_ssot' = 'reconciled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_reference_code` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `reschedule_count` SET TAGS ('pii_business_glossary_term' = 'Reschedule Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `ris_appointment_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `roomed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Roomed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Scheduled Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduling_source` SET TAGS ('pii_business_glossary_term' = 'Scheduling Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduling_source` SET TAGS ('pii_value_regex' = 'provider_referral|patient_self|order_based|transfer|walk_in|portal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_business_glossary_term' = 'SSOT Canonical Reference');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'SSOT Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Appointment Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_business_glossary_term' = 'Telehealth Access Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_business_glossary_term' = 'Telehealth Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_value_regex' = 'not-started|connected|disconnected|failed|completed');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session URL (Uniform Resource Locator)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_modality` SET TAGS ('pii_business_glossary_term' = 'Visit Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_modality` SET TAGS ('pii_value_regex' = 'in-person|video|phone|e-visit|asynchronous');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_reason` SET TAGS ('pii_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_reason_code` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `reader_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Reader Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Radiologist Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `prior_assignment_reader_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Prior Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `stark_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Stark Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_case_id` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `addendum_flag` SET TAGS ('pii_business_glossary_term' = 'Report Addendum Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `addendum_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Addendum Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_source` SET TAGS ('pii_business_glossary_term' = 'Assignment Source Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_source` SET TAGS ('pii_value_regex' = 'worklist_auto|manual|teleradiology_vendor|ai_routing|escalation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'assigned|in_progress|completed|cancelled|reassigned|pending');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_business_glossary_term' = 'Reader Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_value_regex' = 'primary_read|second_read|peer_review|overread|teleradiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `contrast_used` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `critical_finding_notified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `dictation_method` SET TAGS ('pii_business_glossary_term' = 'Dictation Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `dictation_method` SET TAGS ('pii_value_regex' = 'voice_recognition|manual_transcription|structured_reporting|template');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `image_count` SET TAGS ('pii_business_glossary_term' = 'DICOM Image Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `is_teleradiology` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Assignment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_category` SET TAGS ('pii_business_glossary_term' = 'Peer Review Discrepancy Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_category` SET TAGS ('pii_value_regex' = 'agree|minor_discrepancy|significant_discrepancy|major_discrepancy');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_score` SET TAGS ('pii_business_glossary_term' = 'Peer Review Score');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_score` SET TAGS ('pii_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Study Read Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|scheduled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Length Product (DLP) mGy·cm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `read_complete_timestamp` SET TAGS ('pii_business_glossary_term' = 'Read Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `read_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Read Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `reading_site` SET TAGS ('pii_business_glossary_term' = 'Reading Site Location');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `reassignment_reason` SET TAGS ('pii_business_glossary_term' = 'Reassignment Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `report_signed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `rvu_value` SET TAGS ('pii_business_glossary_term' = 'Relative Value Unit (RVU) Value');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `sla_met` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Met Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `sla_target_minutes` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `subspecialty_match` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Match Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `subspecialty_required` SET TAGS ('pii_business_glossary_term' = 'Required Radiologist Subspecialty');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `tat_minutes` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time (TAT) Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Routing Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_value_regex' = 'after_hours|subspecialty_gap|volume_overflow|coverage_gap|stat_backup');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `vendor_accession_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `worklist_code` SET TAGS ('pii_business_glossary_term' = 'RIS Worklist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `critical_result_id` SET TAGS ('pii_business_glossary_term' = 'Critical Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Radiologist Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Department ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Notified Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiology_finding_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `tertiary_critical_ordering_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `acknowledgment_datetime` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `acknowledgment_method` SET TAGS ('pii_value_regex' = 'phone|secure_message|ehr_alert|pager|in_person|fax');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `acknowledgment_turnaround_minutes` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Turnaround Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `dicom_study_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `emtala_applicable` SET TAGS ('pii_business_glossary_term' = 'Emergency Medical Treatment and Labor Act (EMTALA) Applicable Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `escalation_datetime` SET TAGS ('pii_business_glossary_term' = 'Escalation Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `escalation_reason` SET TAGS ('pii_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `escalation_reason` SET TAGS ('pii_value_regex' = 'no_response|provider_unavailable|wrong_contact|system_failure|other');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_category` SET TAGS ('pii_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_datetime` SET TAGS ('pii_business_glossary_term' = 'Finding Identified Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_severity` SET TAGS ('pii_business_glossary_term' = 'Finding Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `finding_severity` SET TAGS ('pii_value_regex' = 'critical|significant|incidental');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Notification Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_datetime` SET TAGS ('pii_business_glossary_term' = 'Notification Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_method` SET TAGS ('pii_value_regex' = 'phone|secure_message|ehr_alert|pager|in_person|fax');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_status` SET TAGS ('pii_value_regex' = 'pending|notified|acknowledged|escalated|failed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notification_turnaround_minutes` SET TAGS ('pii_business_glossary_term' = 'Notification Turnaround Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Notified Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_business_glossary_term' = 'Patient Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency|observation|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_location_at_notification` SET TAGS ('pii_business_glossary_term' = 'Patient Location at Notification');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_location_at_notification` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_location_at_notification` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `read_back_notes` SET TAGS ('pii_business_glossary_term' = 'Read-Back Documentation Notes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `read_back_performed` SET TAGS ('pii_business_glossary_term' = 'Read-Back Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `report_status_at_notification` SET TAGS ('pii_business_glossary_term' = 'Report Status at Notification');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `report_status_at_notification` SET TAGS ('pii_value_regex' = 'preliminary|final|addendum');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `tjc_compliance_status` SET TAGS ('pii_business_glossary_term' = 'The Joint Commission (TJC) Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `tjc_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending_review|exception_granted');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `teleradiology_case_id` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Case ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Originating Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Case Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `payer_contract_id` SET TAGS ('pii_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `stark_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Stark Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `actual_tat_minutes` SET TAGS ('pii_business_glossary_term' = 'Actual Turnaround Time (TAT) in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `billing_responsibility` SET TAGS ('pii_business_glossary_term' = 'Professional Component Billing Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `billing_responsibility` SET TAGS ('pii_value_regex' = 'vendor|facility|shared|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `case_status` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Case Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `critical_finding_notified_datetime` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Notification Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `dicom_study_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `discrepancy_category` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `discrepancy_category` SET TAGS ('pii_value_regex' = 'major|minor|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `expected_tat_minutes` SET TAGS ('pii_business_glossary_term' = 'Expected Turnaround Time (TAT) in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `final_report_datetime` SET TAGS ('pii_business_glossary_term' = 'Final Report Received Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `final_report_text` SET TAGS ('pii_business_glossary_term' = 'Final Report Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `final_report_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `final_report_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpretation_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Interpretation Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_business_glossary_term' = 'Interpreting Radiologist Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Interpreting Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `modality_code` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `number_of_images` SET TAGS ('pii_business_glossary_term' = 'Number of Images');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `number_of_series` SET TAGS ('pii_business_glossary_term' = 'Number of Series');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `preliminary_report_datetime` SET TAGS ('pii_business_glossary_term' = 'Preliminary Report Received Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `preliminary_report_text` SET TAGS ('pii_business_glossary_term' = 'Preliminary Report Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `preliminary_report_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `preliminary_report_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Study Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|elective');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `professional_component_billed` SET TAGS ('pii_business_glossary_term' = 'Professional Component Billed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `reconciliation_datetime` SET TAGS ('pii_business_glossary_term' = 'Report Reconciliation Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `reconciliation_discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Discrepancy Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `report_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Report Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `report_reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|in_review|reconciled|discrepancy_identified|escalated|waived');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `retransmission_count` SET TAGS ('pii_business_glossary_term' = 'Retransmission Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_business_glossary_term' = 'Routing Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_value_regex' = 'after_hours|subspecialty|overflow|stat_coverage|disaster_recovery|other');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `sla_met` SET TAGS ('pii_business_glossary_term' = 'SLA Met Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `study_datetime` SET TAGS ('pii_business_glossary_term' = 'Study Acquisition Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `subspecialty_required` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `transmission_datetime` SET TAGS ('pii_business_glossary_term' = 'Study Transmission Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `transmission_method` SET TAGS ('pii_business_glossary_term' = 'Transmission Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `transmission_method` SET TAGS ('pii_value_regex' = 'dicom_push|dicom_pull|vpn_transfer|cloud_upload|hl7_mllp|other');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `transmission_success` SET TAGS ('pii_business_glossary_term' = 'Transmission Success Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vendor_accession_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vendor_receipt_datetime` SET TAGS ('pii_business_glossary_term' = 'Vendor Receipt Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_up_id` SET TAGS ('pii_business_glossary_term' = 'Follow Up Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Care Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Completing Imaging Order Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_original_imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Original Imaging Order Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Original Report Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_radiology_report_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_responsible_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Finding Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `primary_follow_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('pii_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `radiology_finding_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Finding Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recall_list_id` SET TAGS ('pii_business_glossary_term' = 'Recall List Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `acr_category_code` SET TAGS ('pii_business_glossary_term' = 'ACR (American College of Radiology) Category Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `acr_guideline_reference` SET TAGS ('pii_business_glossary_term' = 'ACR (American College of Radiology) Incidental Findings Guideline Reference');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `care_gap_flag` SET TAGS ('pii_business_glossary_term' = 'Care Gap Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `cms_quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `completed_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `completion_status` SET TAGS ('pii_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `declined_reason` SET TAGS ('pii_business_glossary_term' = 'Declined or Cancelled Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `declined_reason` SET TAGS ('pii_value_regex' = 'patient_refused|provider_cancelled|clinically_inappropriate|duplicate_recommendation|other');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `escalation_reason` SET TAGS ('pii_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `escalation_reason` SET TAGS ('pii_value_regex' = 'overdue|high_risk_finding|patient_no_show|provider_non_response|critical_result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `escalation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `finding_body_region` SET TAGS ('pii_business_glossary_term' = 'Finding Body Region');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `finding_category_code` SET TAGS ('pii_business_glossary_term' = 'Finding Category Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Incidental Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `finding_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `finding_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_up_status` SET TAGS ('pii_business_glossary_term' = 'Follow Up Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `follow_up_type` SET TAGS ('pii_business_glossary_term' = 'Follow Up Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `is_overdue` SET TAGS ('pii_business_glossary_term' = 'Is Overdue');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `lost_to_follow_up_date` SET TAGS ('pii_business_glossary_term' = 'Lost to Follow-Up Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Follow Up Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Mrn');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `notification_count` SET TAGS ('pii_business_glossary_term' = 'Notification Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `notification_datetime` SET TAGS ('pii_business_glossary_term' = 'Notification Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `ordering_provider_notification_status` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `ordering_provider_notification_status` SET TAGS ('pii_value_regex' = 'not_notified|notified|acknowledged|action_taken');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `ordering_provider_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `original_finding_date` SET TAGS ('pii_business_glossary_term' = 'Original Finding Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `pacs_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'PACS (Picture Archiving and Communication System) Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_declined_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Declined Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_declined_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_declined_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_method` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_method` SET TAGS ('pii_value_regex' = 'portal_message|phone_call|letter|in_person|secure_email');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_status` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_status` SET TAGS ('pii_value_regex' = 'not_notified|notified|acknowledged|declined_notification');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Patient Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notified_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Notified Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notified_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notified_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notified_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `patient_notified_timestamp` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_business_glossary_term' = 'Population Health Cohort');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Follow Up Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'routine|urgent|emergent|critical');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_date` SET TAGS ('pii_business_glossary_term' = 'Recommendation Issue Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_number` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Recommendation Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_source` SET TAGS ('pii_business_glossary_term' = 'Recommendation Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_status` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Recommendation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_status` SET TAGS ('pii_value_regex' = 'pending|scheduled|completed|declined|lost_to_follow_up|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_text` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Recommendation Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommendation_type` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Recommendation Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommended_due_date` SET TAGS ('pii_business_glossary_term' = 'Recommended Follow-Up Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommended_modality` SET TAGS ('pii_business_glossary_term' = 'Recommended Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommended_modality` SET TAGS ('pii_value_regex' = 'CT|MRI|ultrasound|PET|X-ray|mammography');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `recommended_timeframe_days` SET TAGS ('pii_business_glossary_term' = 'Recommended Follow-Up Timeframe (Days)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('pii_business_glossary_term' = 'Radiology Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `ris_recommendation_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Recommendation ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `specialist_referral_type` SET TAGS ('pii_business_glossary_term' = 'Specialist Referral Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_business_glossary_term' = 'Interventional Procedure ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Biopsy Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `drug_master_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_employee_id` SET TAGS ('pii_business_glossary_term' = 'Scrub Technologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_icd10_primary_icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Primary Icd Code Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Performing Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_room_id` SET TAGS ('pii_business_glossary_term' = 'Room Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `osha_exposure_incident_id` SET TAGS ('pii_business_glossary_term' = 'Osha Exposure Incident Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_business_glossary_term' = 'Preprocedure Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Primary Device Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `primary_interventional_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Performing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Report Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Procedure Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `access_site` SET TAGS ('pii_business_glossary_term' = 'Vascular Access Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `anesthesia_type` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `anesthesia_type` SET TAGS ('pii_value_regex' = 'none|local|moderate-sedation|general|MAC|spinal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `approach` SET TAGS ('pii_business_glossary_term' = 'Approach');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `asa_classification` SET TAGS ('pii_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `asa_classification` SET TAGS ('pii_value_regex' = 'ASA-I|ASA-II|ASA-III|ASA-IV|ASA-V|ASA-VI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `body_region` SET TAGS ('pii_business_glossary_term' = 'Body Region');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `case_complexity` SET TAGS ('pii_business_glossary_term' = 'Case Complexity');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_description` SET TAGS ('pii_business_glossary_term' = 'Complication Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_flag` SET TAGS ('pii_business_glossary_term' = 'Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_occurred` SET TAGS ('pii_business_glossary_term' = 'Complication Occurred Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_severity` SET TAGS ('pii_business_glossary_term' = 'Complication Severity Grade');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_severity` SET TAGS ('pii_value_regex' = 'minor|moderate|major|death');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `complication_type` SET TAGS ('pii_business_glossary_term' = 'Complication Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `contrast_agent_used` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Used Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `contrast_used` SET TAGS ('pii_business_glossary_term' = 'Contrast Used');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `contrast_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Volume Administered (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_business_glossary_term' = 'Device Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_udi` SET TAGS ('pii_business_glossary_term' = 'Device Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_used` SET TAGS ('pii_business_glossary_term' = 'Device Used');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('pii_business_glossary_term' = 'Estimated Blood Loss Ml');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `fluoroscopy_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Fluoroscopy Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `fluoroscopy_time_sec` SET TAGS ('pii_business_glossary_term' = 'Fluoroscopy Time Sec');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `guidance_modality` SET TAGS ('pii_business_glossary_term' = 'Guidance Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Post-Procedure Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `imaging_guidance_modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Guidance Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `imaging_guidance_modality` SET TAGS ('pii_value_regex' = 'fluoroscopy|CT|ultrasound|MRI|PET-CT|combined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `implant_used` SET TAGS ('pii_business_glossary_term' = 'Implant Used Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|midline|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Mrn');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `mrn` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `outcome_status` SET TAGS ('pii_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `pathology_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Pathology Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `patient_position` SET TAGS ('pii_business_glossary_term' = 'Patient Position');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `patient_position` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `patient_position` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_clinician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_clinician_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Performing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `post_procedure_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `post_procedure_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `pre_procedure_diagnosis` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `pre_procedure_diagnosis` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `pre_procedure_diagnosis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `pre_procedure_diagnosis` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_business_glossary_term' = 'Procedure Approach');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_business_glossary_term' = 'Interventional Radiology (IR) Procedure Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_business_glossary_term' = 'Procedure Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Procedure Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_duration_minutes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_duration_minutes` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Procedure End Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Procedure End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_business_glossary_term' = 'Procedure Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Procedure Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_value_regex' = 'scheduled|in-progress|completed|cancelled|on-hold');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_type` SET TAGS ('pii_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Dap');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Area Product (DAP) (Gy·cm²)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Dlp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Reference Air Kerma (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Radiology Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'preliminary|final|addendum|amended|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `secondary_cpt_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary Current Procedural Terminology (CPT) Codes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `secondary_cpt_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_level` SET TAGS ('pii_business_glossary_term' = 'Sedation Level');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_business_glossary_term' = 'Specimen Collected Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_business_glossary_term' = 'Specimen Collected Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_value_regex' = 'core-biopsy|fine-needle-aspirate|fluid-aspirate|tissue-excision|cytology|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `technical_success` SET TAGS ('pii_business_glossary_term' = 'Technical Success Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `technical_success_flag` SET TAGS ('pii_business_glossary_term' = 'Technical Success Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `timeout_performed_flag` SET TAGS ('pii_business_glossary_term' = 'Timeout Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_subdomain' = 'imaging_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `radiology_order_status_history_id` SET TAGS ('pii_business_glossary_term' = 'Order Status History Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Performing Radiologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `corrected_history_id` SET TAGS ('pii_business_glossary_term' = 'Corrected History ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `radiology_changed_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Changed By Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `radiology_changed_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `radiology_changed_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_business_glossary_term' = 'Cancellation Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `change_source` SET TAGS ('pii_business_glossary_term' = 'Change Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_npi` SET TAGS ('pii_business_glossary_term' = 'Changed By Npi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_business_glossary_term' = 'Changed By User National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_role` SET TAGS ('pii_business_glossary_term' = 'Changed By User Role');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `duration_in_status_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration In Status Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `duration_in_status_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `hl7_message_reference` SET TAGS ('pii_business_glossary_term' = 'Health Level Seven (HL7) Message ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `hl7_message_type` SET TAGS ('pii_business_glossary_term' = 'Health Level Seven (HL7) Message Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `hl7_message_type` SET TAGS ('pii_value_regex' = 'ORM|ORU|ADT|SIU|ACK|other');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `is_corrective_entry` SET TAGS ('pii_business_glossary_term' = 'Is Corrective Entry');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `is_sla_breach` SET TAGS ('pii_business_glossary_term' = 'Is Service Level Agreement (SLA) Breach');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `is_system_generated` SET TAGS ('pii_business_glossary_term' = 'Is System Generated');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `is_system_generated` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `new_status` SET TAGS ('pii_business_glossary_term' = 'New Order Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `new_status` SET TAGS ('pii_value_regex' = 'scheduled|patient-arrived|exam-started|exam-completed|images-available|preliminary-read');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `on_hold_reason` SET TAGS ('pii_business_glossary_term' = 'On-Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `order_priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `order_priority` SET TAGS ('pii_value_regex' = 'STAT|URGENT|ROUTINE|ASAP|ELECTIVE');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Study UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `previous_status` SET TAGS ('pii_business_glossary_term' = 'Previous Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `prior_status` SET TAGS ('pii_business_glossary_term' = 'Prior Order Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `prior_status` SET TAGS ('pii_value_regex' = 'ordered|scheduled|patient-arrived|exam-started|exam-completed|images-available');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ris_order_status_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Order Status Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `sequence_number` SET TAGS ('pii_business_glossary_term' = 'Status Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `sla_threshold_seconds` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Threshold Seconds');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `source_system_event_code` SET TAGS ('pii_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `status_change_reason` SET TAGS ('pii_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `status_change_reason_code` SET TAGS ('pii_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `status_change_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `status_comment` SET TAGS ('pii_business_glossary_term' = 'Status Comment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `transition_duration_seconds` SET TAGS ('pii_business_glossary_term' = 'Transition Duration Seconds');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `transition_duration_seconds` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `workstation_code` SET TAGS ('pii_business_glossary_term' = 'Workstation ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_subdomain' = 'result_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_association_edges' = 'radiology.report,interoperability.trading_partner');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `report_distribution_id` SET TAGS ('pii_business_glossary_term' = 'Report Distribution - Report Distribution Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `direct_address_id` SET TAGS ('pii_business_glossary_term' = 'Direct Address Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `direct_address_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `direct_address_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `direct_address_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `direct_message_id` SET TAGS ('pii_business_glossary_term' = 'Direct Message Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Read By User');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `hie_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Hie Transaction Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `initiated_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `initiated_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Report Distribution - Radiology Report Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Recipient Provider');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `report_recipient_care_site_id` SET TAGS ('pii_business_glossary_term' = 'Recipient Care Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `report_recipient_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Recipient Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Report Distribution - Trading Partner Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledged_by_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledged_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledged_by_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledgment_code` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledgment_datetime` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `critical_result_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `delivered_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `delivery_duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `distribution_method` SET TAGS ('pii_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `distribution_type` SET TAGS ('pii_business_glossary_term' = 'Distribution Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `document_format` SET TAGS ('pii_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `escalation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `escalation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `is_critical_result` SET TAGS ('pii_business_glossary_term' = 'Is Critical Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `is_patient_copy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `is_patient_copy` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `is_stat` SET TAGS ('pii_business_glossary_term' = 'Is Stat');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `next_retry_timestamp` SET TAGS ('pii_business_glossary_term' = 'Next Retry Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `patient_portal_available_flag` SET TAGS ('pii_business_glossary_term' = 'Portal Available');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `patient_portal_available_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `patient_portal_available_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `portal_release_timestamp` SET TAGS ('pii_business_glossary_term' = 'Portal Release Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Distribution Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `read_receipt_timestamp` SET TAGS ('pii_business_glossary_term' = 'Read Receipt Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_address` SET TAGS ('pii_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_business_glossary_term' = 'Recipient Email');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_business_glossary_term' = 'Recipient Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_business_glossary_term' = 'Recipient Npi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_type` SET TAGS ('pii_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `report_format` SET TAGS ('pii_business_glossary_term' = 'Report Format');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `retry_count` SET TAGS ('pii_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `sla_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `transmission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `verbal_notification_recipient` SET TAGS ('pii_business_glossary_term' = 'Verbal Notification Recipient');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `verbal_notification_recipient` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `verbal_notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verbal Notification Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_subdomain' = 'result_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_association_edges' = 'radiology.study,interoperability.trading_partner');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transmission_id` SET TAGS ('pii_business_glossary_term' = 'Transmission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiated By User');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Transmission - Imaging Study Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `teleradiology_case_id` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Case Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Transmission - Trading Partner Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `bytes_transferred` SET TAGS ('pii_business_glossary_term' = 'Bytes Transferred');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `compression_type` SET TAGS ('pii_business_glossary_term' = 'Compression Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_business_glossary_term' = 'Destination Ae Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_host` SET TAGS ('pii_business_glossary_term' = 'Destination Host');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_port` SET TAGS ('pii_business_glossary_term' = 'Destination Port');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'Dicom Study Instance Uid');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `direction` SET TAGS ('pii_business_glossary_term' = 'Transmission Direction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `error_message` SET TAGS ('pii_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `image_count_sent` SET TAGS ('pii_business_glossary_term' = 'Image Count Sent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `image_count_total` SET TAGS ('pii_business_glossary_term' = 'Image Count Total');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `is_complete` SET TAGS ('pii_business_glossary_term' = 'Is Complete');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Transmission Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `protocol_type` SET TAGS ('pii_business_glossary_term' = 'Protocol Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Transmission Purpose');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `retry_count` SET TAGS ('pii_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `series_count` SET TAGS ('pii_business_glossary_term' = 'Series Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `size_mb` SET TAGS ('pii_business_glossary_term' = 'Transmission Size');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `sla_met_flag` SET TAGS ('pii_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `source_ae_title` SET TAGS ('pii_business_glossary_term' = 'Source Ae Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transfer_duration_seconds` SET TAGS ('pii_business_glossary_term' = 'Transfer Duration Seconds');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transfer_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transfer End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transfer_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transfer Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transmission_status` SET TAGS ('pii_business_glossary_term' = 'Transmission Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transmission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `transmission_type` SET TAGS ('pii_business_glossary_term' = 'Transmission Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_subdomain' = 'result_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_association_edges' = 'radiology.modality,insurance.provider_network');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `network_modality_participation_id` SET TAGS ('pii_business_glossary_term' = 'Network Modality Participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `contract_id` SET TAGS ('pii_business_glossary_term' = 'Network Contract Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Network Modality Participation - Modality Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `payer_contract_id` SET TAGS ('pii_business_glossary_term' = 'Payer Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Network Modality Participation - Provider Network Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_business_glossary_term' = 'Accepting New Referrals Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `acr_accreditation_required` SET TAGS ('pii_business_glossary_term' = 'Acr Accreditation Required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `authorization_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Authorization Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `contracted_rate` SET TAGS ('pii_business_glossary_term' = 'Contracted Modality Rate');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `contracted_rate` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `contracted_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `credentialing_verified_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `member_cost_share_tier` SET TAGS ('pii_business_glossary_term' = 'Member Cost Share Tier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `member_cost_share_tier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `member_cost_share_tier` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `network_adequacy_counted_flag` SET TAGS ('pii_business_glossary_term' = 'Network Adequacy Counted Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `next_credentialing_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Credentialing Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `participation_type` SET TAGS ('pii_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `quality_tier_assignment` SET TAGS ('pii_business_glossary_term' = 'Quality Tier Assignment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `reimbursement_rate_modifier` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Rate Modifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `service_area_zip_codes` SET TAGS ('pii_business_glossary_term' = 'Service Area Zip Codes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `service_area_zip_codes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `service_area_zip_codes` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `radiology_finding_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Finding Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_ssot' = 'link');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `dicom_series_id` SET TAGS ('pii_business_glossary_term' = 'Dicom Series Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Finding Icd Code Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Report Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Concept Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `acr_score_type` SET TAGS ('pii_business_glossary_term' = 'Acr Score Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `acr_score_value` SET TAGS ('pii_business_glossary_term' = 'Acr Score Value');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `body_site_code` SET TAGS ('pii_business_glossary_term' = 'Body Site Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `body_site_description` SET TAGS ('pii_business_glossary_term' = 'Body Site Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `code_system` SET TAGS ('pii_business_glossary_term' = 'Code System');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `data_source_method` SET TAGS ('pii_business_glossary_term' = 'Data Source Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `dicom_series_uid` SET TAGS ('pii_business_glossary_term' = 'Dicom Series Uid');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `dicom_sop_instance_uid` SET TAGS ('pii_business_glossary_term' = 'Dicom Sop Instance Uid');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `escalation_status` SET TAGS ('pii_business_glossary_term' = 'Escalation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `escalation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_category` SET TAGS ('pii_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_context` SET TAGS ('pii_ssot' = 'discriminator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_status` SET TAGS ('pii_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_completed_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow Up Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_modality` SET TAGS ('pii_business_glossary_term' = 'Follow Up Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_recommended` SET TAGS ('pii_business_glossary_term' = 'Follow Up Recommended');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_status` SET TAGS ('pii_business_glossary_term' = 'Follow Up Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_timeframe_days` SET TAGS ('pii_business_glossary_term' = 'Follow Up Timeframe Days');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `follow_up_type` SET TAGS ('pii_business_glossary_term' = 'Follow Up Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `imaging_modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `is_critical_result` SET TAGS ('pii_business_glossary_term' = 'Is Critical Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `is_incidental_finding` SET TAGS ('pii_business_glossary_term' = 'Is Incidental Finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `measurement_unit` SET TAGS ('pii_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `measurement_value` SET TAGS ('pii_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `notification_datetime` SET TAGS ('pii_business_glossary_term' = 'Notification Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `radlex_code` SET TAGS ('pii_business_glossary_term' = 'Radlex Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `vibe_reconciled_flag` SET TAGS ('pii_ssot' = 'reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_subdomain' = 'interpretation_reporting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `radiology_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Peer Review Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Coordinator Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Original Report Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `report_addendum_id` SET TAGS ('pii_business_glossary_term' = 'Report Addendum Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `acr_accreditation_cycle` SET TAGS ('pii_business_glossary_term' = 'Acr Accreditation Cycle');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `acr_radpeer_score` SET TAGS ('pii_business_glossary_term' = 'Acr Radpeer Score');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `blinded_review_flag` SET TAGS ('pii_business_glossary_term' = 'Blinded Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `case_conference_flag` SET TAGS ('pii_business_glossary_term' = 'Case Conference Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical History Available Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_category` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_description` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_type` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `educational_feedback_flag` SET TAGS ('pii_business_glossary_term' = 'Educational Feedback Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `escalated_to_chair_flag` SET TAGS ('pii_business_glossary_term' = 'Escalated To Chair Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `icd10_finding_code` SET TAGS ('pii_business_glossary_term' = 'Icd10 Finding Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `modality_code` SET TAGS ('pii_business_glossary_term' = 'Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `oppe_fppe_flag` SET TAGS ('pii_business_glossary_term' = 'Oppe Fppe Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Original Radiologist Npi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_response` SET TAGS ('pii_business_glossary_term' = 'Original Radiologist Response');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_report_finalized_datetime` SET TAGS ('pii_business_glossary_term' = 'Original Report Finalized Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Safety Event Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `patient_safety_event_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `prior_study_available_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Study Available Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `response_datetime` SET TAGS ('pii_business_glossary_term' = 'Response Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `review_assigned_datetime` SET TAGS ('pii_business_glossary_term' = 'Review Assigned Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `review_datetime` SET TAGS ('pii_business_glossary_term' = 'Review Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `review_disposition` SET TAGS ('pii_business_glossary_term' = 'Review Disposition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `review_program_type` SET TAGS ('pii_business_glossary_term' = 'Review Program Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Reviewer Radiologist Npi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `study_datetime` SET TAGS ('pii_business_glossary_term' = 'Study Datetime');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `subspecialty` SET TAGS ('pii_business_glossary_term' = 'Subspecialty');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `subspecialty_matched_flag` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Matched Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` SET TAGS ('pii_subdomain' = 'result_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `distribution_rule_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `parent_distribution_rule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_code_filter` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_code_filter` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `recipient_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `recipient_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `recipient_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `recipient_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_uc_classification' = 'pii');
