-- Schema for Domain: patient | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`patient` COMMENT 'Single source of truth for patient and clinical trial participant master data including demographics, enrollment status, informed consent, medical history, longitudinal treatment records, and patient-reported outcomes. Manages patient registries, patient support programs, adherence monitoring, and copay assistance programs. Ensures HIPAA and GDPR compliance for protected health information (PHI). Authoritative source for patient identity across clinical trials, pharmacovigilance, and market access programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`patient` (
    `patient_id` BIGINT COMMENT 'Primary key for patient',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Patient country of residence drives regulatory reporting requirements (EMA regional submissions), data localization compliance (GDPR, local privacy laws), enrollment eligibility criteria, and pharmaco',
    `address_line1` STRING COMMENT 'First line of the patients residential address. Used for patient contact, investigational product shipment, and patient support services. Protected health information (PHI).',
    `address_line2` STRING COMMENT 'Second line of the patients residential address (apartment, suite, unit number). Optional field for complete address capture.',
    `city` STRING COMMENT 'City of the patients residential address. Protected health information (PHI) when combined with other identifiers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient record was first created in the system. Part of audit trail for regulatory compliance and data lineage.',
    `ctms_subject_number` STRING COMMENT 'Subject identifier assigned by the Clinical Trial Management System (Oracle Clinical or Siebel CTMS). Used to link patient records to clinical trial enrollment and visit data.',
    `data_classification_level` STRING COMMENT 'Classification level of the patient record based on sensitivity and regulatory requirements. Determines access controls and handling procedures.. Valid values are `restricted|confidential|internal|public`',
    `data_privacy_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has provided consent for data processing and sharing under GDPR and HIPAA regulations. True if consent obtained, false otherwise.',
    `date_of_birth` DATE COMMENT 'Date of birth of the patient. Used for age calculation, eligibility determination, and patient identification. Protected health information (PHI).',
    `discontinuation_date` DATE COMMENT 'Date when the patient discontinued participation in a clinical trial or patient support program. Used for retention analysis and follow-up planning.',
    `discontinuation_reason` STRING COMMENT 'Reason for patient discontinuation from clinical trial or patient support program. Critical for safety analysis and protocol deviation tracking.',
    `edc_subject_number` STRING COMMENT 'Patient identifier in the Electronic Data Capture system (Medidata Rave). Links patient to case report forms (CRFs) and clinical trial data collection.',
    `ehr_mrn` STRING COMMENT 'Medical record number from external electronic health record systems. Used for real-world data (RWD) integration and health economics outcomes research (HEOR).',
    `email_address` STRING COMMENT 'Primary email address for patient communication, electronic consent delivery, and patient support program engagement. Protected health information (PHI).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_date` DATE COMMENT 'Date when the patient was enrolled in a clinical trial or patient support program. Marks the start of the patients participation lifecycle.',
    `enrollment_status` STRING COMMENT 'Current enrollment status of the patient in clinical trials. Tracks progression through trial phases from screening to completion or discontinuation.. Valid values are `screening|enrolled|randomized|treatment|follow_up|discontinued`',
    `ethnicity` STRING COMMENT 'Self-reported ethnicity of the patient. Required for clinical trial diversity reporting and subgroup analysis per FDA and EMA guidelines.',
    `first_name` STRING COMMENT 'Legal first name of the patient. Protected health information (PHI) subject to HIPAA and GDPR privacy regulations.',
    `gender_identity` STRING COMMENT 'Self-identified gender of the patient. Captured separately from biological sex to support inclusive clinical research and patient-centered care.',
    `gpid` STRING COMMENT 'Global patient identifier used across all systems and geographies to uniquely identify a patient. Pseudonymized token for cross-system linkage while maintaining HIPAA and GDPR compliance.. Valid values are `^GPID-[A-Z0-9]{12}$`',
    `informed_consent_date` DATE COMMENT 'Date when informed consent was obtained from the patient. Required for GCP compliance and regulatory audit trails.',
    `informed_consent_status` STRING COMMENT 'Status of informed consent for clinical trial participation or data usage. Critical for GCP compliance and patient rights protection.. Valid values are `pending|obtained|declined|withdrawn|expired`',
    `last_name` STRING COMMENT 'Legal last name (surname or family name) of the patient. Protected health information (PHI) subject to HIPAA and GDPR privacy regulations.',
    `middle_name` STRING COMMENT 'Middle name or initial of the patient. Optional field for patient identity verification.',
    `mpi_token` STRING COMMENT 'Master patient index linkage token used to resolve patient identity across disparate source systems. Enables patient matching and deduplication while preserving privacy.',
    `nationality` STRING COMMENT 'Nationality of the patient represented as ISO 3166-1 alpha-3 country code. Used for regulatory reporting and cross-border clinical trial management.. Valid values are `^[A-Z]{3}$`',
    `patient_status` STRING COMMENT 'Current lifecycle status of the patient in clinical trials or patient support programs. Tracks patient engagement and follow-up requirements.. Valid values are `active|deceased|lost_to_follow_up|withdrawn|completed`',
    `phone_number` STRING COMMENT 'Primary contact phone number for patient communication, appointment reminders, and adherence monitoring. Protected health information (PHI).',
    `postal_code` STRING COMMENT 'Postal code or ZIP code of the patients residential address. Protected health information (PHI) when combined with other identifiers.',
    `primary_language` STRING COMMENT 'Primary language spoken by the patient. Used for informed consent delivery, patient communication, and patient-reported outcomes (PRO) instrument selection.',
    `pseudonymization_token` STRING COMMENT 'Pseudonymized identifier used to protect patient identity in research datasets and analytics. Enables HIPAA and GDPR compliant data sharing while maintaining linkability.',
    `pv_case_patient_reference` STRING COMMENT 'Patient identifier in the pharmacovigilance safety reporting system (Argus Safety or Oracle AERS). Links patient to adverse event reports and ICSRs.',
    `race` STRING COMMENT 'Self-reported race of the patient. Required for clinical trial diversity reporting and subgroup safety and efficacy analysis per FDA and EMA guidelines.',
    `sex` STRING COMMENT 'Biological sex assigned at birth. Used for clinical trial eligibility, safety analysis, and pharmacokinetic (PK) / pharmacodynamic (PD) assessments.. Valid values are `male|female|unknown`',
    `specialty_pharmacy_code` STRING COMMENT 'Patient identifier in specialty pharmacy and patient support program systems. Used for copay assistance, adherence monitoring, and patient services.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the patients residential address. Used for geographic analysis and regulatory reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient record was last updated. Part of audit trail for regulatory compliance and change tracking.',
    CONSTRAINT pk_patient PRIMARY KEY(`patient_id`)
) COMMENT 'Core master entity representing a patient or clinical trial participant. Single source of truth for patient identity across clinical trials, pharmacovigilance, and market access programs. Captures demographics (date of birth, sex, gender, race, ethnicity), contact information, primary language, nationality, country of residence, patient status (active, deceased, lost-to-follow-up), global patient identifier (GPID), cross-system identifiers (CTMS subject number, EDC ID, PV case patient ID, specialty pharmacy ID, EHR MRN), pseudonymization token for HIPAA/GDPR compliance, master patient index (MPI) linkage, consent status flag, data privacy classification, and audit metadata. Authoritative record for all downstream patient-linked data products.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` (
    `patient_enrollment_id` BIGINT COMMENT 'Unique identifier for the patient enrollment record. Primary key for this entity.',
    `affairs_plan_id` BIGINT COMMENT 'Foreign key linking to medical.medical_affairs_plan. Business justification: Clinical trial enrollments are planned and tracked within medical affairs strategic plans. Linking enrollment to the governing plan enables portfolio oversight, enrollment forecasting vs. targets, and',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Clinical trial enrollments study specific commercial brands. Essential for brand lifecycle management, launch planning, commercial forecasting from trial data, and integrated clinical-commercial perfo',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Trial enrollments consume approved study budgets. Finance monitors actual enrollment against budgeted patient counts for variance analysis, forecasting, and budget reallocation decisions. Essential fo',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Enrollment country determines regulatory submission requirements (FDA vs EMA vs local authorities), site selection strategy, enrollment forecasting models, and country-specific protocol amendments. Cr',
    `designation_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_designation. Business justification: Orphan drug, breakthrough therapy, and rare disease designations define trial eligibility criteria, endpoint requirements, and enrollment caps. Enrollment records must link to the designation to verif',
    `clinical_enrollment_id` BIGINT COMMENT 'Unique identifier for this patient support program enrollment record. Primary key.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Enrollment violations (eligibility failures, consent breaches, randomization errors) trigger compliance incidents requiring investigation and regulatory reporting; link supports integrated incident ma',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Clinical trial enrollments drive cost allocation to internal orders for trial budgeting, cost center assignment, and financial reporting. Finance tracks trial costs per enrollment for budget variance ',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Clinical trials test discovery compounds in patients. Translational medicine requires tracking which investigational compound (IND-enabling candidate) each patient received. Essential for efficacy/saf',
    `investigational_site_id` BIGINT COMMENT 'Unique identifier for the investigational site or facility where the patient was enrolled.',
    `lead_series_id` BIGINT COMMENT 'Foreign key linking to discovery.lead_series. Business justification: Tracks which medicinal chemistry lead series advanced to clinical testing. Required for retrospective analysis of discovery-to-clinic success rates, SAR learnings from clinical outcomes, and IP strate',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Clinical trial enrollments must track which medicinal product is being tested for safety reporting, efficacy analysis, regulatory submissions (IND/NDA), and pharmacovigilance. Essential for linking tr',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient or clinical trial subject enrolled. Links to the master patient record.',
    `principal_investigator_id` BIGINT COMMENT 'Unique identifier for the principal investigator responsible for the patient at the enrollment site.',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Portfolio management requires tracking which discovery projects have progressed to clinical testing. Essential for stage-gate reviews, resource allocation, probability-of-success modeling, and integra',
    `registry_id` BIGINT COMMENT 'Foreign key linking to patient.registry. Business justification: Patient enrollments can be for clinical trials OR patient registries. The existing trial_id FK handles clinical trial enrollments, but registry enrollments need a separate FK to link to the registry m',
    `application_id` BIGINT COMMENT 'Foreign key linking to regulatory.application. Business justification: Clinical trials operate under regulatory applications (IND in US, CTA in EU). Enrollment records must link to the regulatory application for protocol compliance tracking, safety reporting obligations,',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Clinical trial enrollments are subject to GCP inspections; linking enrollment records to inspections enables audit trail for inspection findings, supports 483 responses, and facilitates CAPA implement',
    `support_program_id` BIGINT COMMENT 'Foreign key linking to the patient support program in which the patient is enrolled',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial, patient support program, or patient registry into which the patient is enrolled.',
    `benefit_amount_received` DECIMAL(18,2) COMMENT 'Cumulative financial assistance amount (in USD) that this specific patient has received through this specific program enrollment. Tracked for benefit cap enforcement, Sunshine Act reporting, and program ROI analysis.',
    `blinding_status` STRING COMMENT 'Blinding status of the patient enrollment: open_label (no blinding), single_blind (patient blinded), double_blind (patient and investigator blinded), triple_blind (patient, investigator, and sponsor blinded), unblinded (emergency unblinding occurred).. Valid values are `open_label|single_blind|double_blind|triple_blind|unblinded`',
    `channel` STRING COMMENT 'Channel or source through which the patient enrolled in this program. Used for channel effectiveness analysis and marketing attribution.',
    `cohort_identifier` STRING COMMENT 'Identifier for the enrollment cohort or wave. Used in dose-escalation studies, adaptive trials, or phased enrollment programs to track enrollment groups.',
    `consent_date` DATE COMMENT 'Date the patient provided informed consent to participate in the trial or program.',
    `consent_to_program_flag` BOOLEAN COMMENT 'Indicates whether the patient has provided informed consent specific to this programs data collection, communication, and benefit processing. Separate from general clinical trial consent. Required for HIPAA compliance and program operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this enrollment record originated (e.g., Oracle Clinical, Medidata Rave, Veeva Vault CTMS). Critical for data lineage and reconciliation.',
    `disenrollment_date` DATE COMMENT 'Date when the patient was disenrolled from this support program. Null for active enrollments. Used for benefit period closure and retention analytics.',
    `disenrollment_reason` STRING COMMENT 'Reason code or description for why the patient was disenrolled from this program (e.g., treatment completed, patient request, insurance change to government payer, benefit maximum reached, non-compliance). Critical for retention analysis and program optimization.',
    `disposition_date` DATE COMMENT 'Date of the disposition event (e.g., date of withdrawal, date of completion, date of death, date of screen failure).',
    `disposition_event_type` STRING COMMENT 'Type of disposition event that ended or changed the patients enrollment status: completed (finished protocol per plan), withdrawn (voluntary or investigator-initiated discontinuation), lost_to_followup (contact lost), death (patient died), screen_failure (did not meet eligibility), protocol_deviation (removed due to protocol violation).. Valid values are `completed|withdrawn|lost_to_followup|death|screen_failure|protocol_deviation`',
    `disposition_primary_reason` STRING COMMENT 'Primary reason code for the disposition event. Standardized per CDISC Controlled Terminology (e.g., adverse event, lack of efficacy, protocol violation, patient decision, lost to follow-up, death, completed per protocol).',
    `disposition_secondary_reason` STRING COMMENT 'Secondary or contributing reason code for the disposition event. Provides additional context beyond the primary reason.',
    `eligibility_verification_date` DATE COMMENT 'Date when patient eligibility for this program was verified (insurance type confirmed as commercial, prescription verified, etc.). Required for compliance documentation and audit trail.',
    `enrollment_date` DATE COMMENT 'Date the patient was formally enrolled into the trial, program, or registry after meeting eligibility criteria and providing informed consent.',
    `enrollment_number` STRING COMMENT 'Business identifier assigned to the patient at enrollment. May be the subject number, screening number, or program enrollment number used in clinical documentation.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the patient enrollment: screened (undergoing screening), screen_failed (did not meet eligibility), enrolled (consented and enrolled), randomized (assigned to treatment arm), active (receiving treatment), completed (finished protocol), withdrawn (voluntarily discontinued), lost_to_followup (contact lost), deceased (patient died). [ENUM-REF-CANDIDATE: screened|screen_failed|enrolled|randomized|active|completed|withdrawn|lost_to_followup|deceased — 9 candidates stripped; promote to reference product]',
    `enrollment_type` STRING COMMENT 'Type of enrollment program: clinical_trial (interventional study), support_program (patient assistance program), registry (observational registry), expanded_access (pre-approval access), compassionate_use (emergency use).. Valid values are `clinical_trial|support_program|registry|expanded_access|compassionate_use`',
    `icf_version` STRING COMMENT 'Version of the informed consent form signed by the patient at enrollment. Tracks consent document revisions and re-consent requirements.',
    `itt_population_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the patient is included in the Intent-to-Treat analysis population. True if the patient was randomized and received at least one dose of study drug.',
    `last_contact_date` DATE COMMENT 'Date of the last documented contact with the patient. Used for tracking lost-to-follow-up and vital status.',
    `last_dose_date` DATE COMMENT 'Date the patient received their last dose of investigational product. Critical for safety follow-up and disposition tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was most recently updated. Used for change tracking and data synchronization.',
    `mitt_population_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the patient is included in the Modified Intent-to-Treat analysis population. Criteria vary by protocol but typically require randomization and at least one post-baseline efficacy assessment.',
    `patient_enrollment_date` DATE COMMENT 'Date when the patient was enrolled in this specific support program. Critical for program eligibility, benefit period calculation, and compliance reporting.',
    `patient_enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment. Tracks progression from pending through active participation to completion or disenrollment. Used for operational reporting and benefit eligibility determination.',
    `pp_population_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the patient is included in the Per-Protocol analysis population. True if the patient completed the protocol without major protocol deviations.',
    `primary_contact_method` STRING COMMENT 'Patients preferred method of contact for communications related to this specific program enrollment. May differ from general patient contact preferences.',
    `protocol_version` STRING COMMENT 'Version of the clinical trial protocol under which the patient was enrolled. Critical for tracking protocol amendments and their impact on enrollment cohorts.',
    `randomization_date` DATE COMMENT 'Date the patient was randomized to a treatment arm in a clinical trial. Null for non-randomized studies or support programs.',
    `randomization_number` STRING COMMENT 'Unique randomization number assigned to the patient at randomization. Used to maintain blinding and treatment assignment.',
    `record_source_system` STRING COMMENT 'Name of the operational system of record from which this enrollment record originated (e.g., PSP hub platform, specialty pharmacy system, CRM). Used for data lineage and troubleshooting.',
    `region` STRING COMMENT 'Geographic region or regulatory jurisdiction where the patient was enrolled (e.g., North America, Europe, Asia-Pacific). Used for stratified analysis and regulatory submissions.',
    `safety_population_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the patient is included in the safety analysis population. Typically true if the patient received at least one dose of investigational product.',
    `screen_failure_reason` STRING COMMENT 'Primary reason the patient failed screening and was not enrolled. Typically coded using standardized reason codes (e.g., inclusion/exclusion criteria not met, withdrew consent, adverse event during screening).',
    `screening_date` DATE COMMENT 'Date the patient began the screening process for eligibility assessment.',
    `stratification_factors` STRING COMMENT 'Comma-separated list of stratification factors used at randomization (e.g., disease stage, prior therapy, biomarker status). Critical for ensuring balanced treatment assignment.',
    `treatment_arm` STRING COMMENT 'Treatment arm or cohort to which the patient was assigned (e.g., active drug, placebo, dose level, combination therapy). May be coded to maintain blinding.',
    `unblinding_date` DATE COMMENT 'Date the patient was unblinded (if emergency unblinding occurred). Null if patient remains blinded or study is open-label.',
    `unblinding_reason` STRING COMMENT 'Reason for emergency unblinding (e.g., serious adverse event requiring treatment decision, patient safety, regulatory request).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated in the system.',
    CONSTRAINT pk_patient_enrollment PRIMARY KEY(`patient_enrollment_id`)
) COMMENT 'Transactional record capturing a participants enrollment into a clinical trial, patient support program, or patient registry, including full disposition lifecycle. Tracks enrollment type (clinical_trial, support_program, registry), enrollment date, randomization date/number, assigned treatment arm, site/investigator identifiers, enrollment status lifecycle (screened, enrolled, randomized, completed, withdrawn, screen-failed), screen failure reason, protocol/ICF version at enrollment. Disposition tracking: disposition event type (completed, withdrawn, lost-to-follow-up, death, screen failure, protocol deviation withdrawal), disposition date, primary and secondary reason codes (standardized per CDISC CT), last dose date, last contact date, and analysis population assignment flags (ITT, mITT, PP, safety). Single source of truth for both enrollment and disposition — serves as authoritative source for CDISC SDTM DM/DS domain derivation and CSR population summaries.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` (
    `informed_consent_id` BIGINT COMMENT 'Primary key for informed_consent',
    `investigator_id` BIGINT COMMENT 'Unique identifier for the principal investigator or sub-investigator who obtained the informed consent. Applicable for clinical trial consents.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Consent jurisdiction determines applicable data privacy regulation (GDPR vs HIPAA vs local), consent form requirements, withdrawal rights, data subject access request processing, and regulatory compli',
    `econsent_document_id` BIGINT COMMENT 'Unique document identifier or reference number from the eConsent platform. Used for audit trail and document retrieval. Null for paper consents.',
    `iit_submission_id` BIGINT COMMENT 'Foreign key linking to medical.iit_submission. Business justification: Investigator-initiated trials require informed consent from enrolled patients. Linking consent records to the IIT submission enables compliance tracking (IRB requirements, enrollment caps), audit read',
    `investigational_site_id` BIGINT COMMENT 'Unique identifier for the investigational site where clinical consent was obtained. Applicable for clinical trial consents. Null for non-trial privacy consents.',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient or clinical trial subject who provided consent. Links to the patient master data product.',
    `privacy_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_obligation. Business justification: Informed consent management fulfills GDPR privacy obligations (Article 6 lawful basis, Article 7 consent conditions, Article 17 withdrawal); link supports lawful basis documentation for clinical data ',
    `application_id` BIGINT COMMENT 'Foreign key linking to regulatory.application. Business justification: ICF versions must align with protocol amendments submitted to health authorities under the regulatory application. Regulatory inspections verify ICF version matches approved protocol version. Critical',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Informed consent compliance is a core GCP inspection focus (ICF version control, consent timing, withdrawal handling); linking consent records to inspections supports inspection readiness assessments,',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial associated with this consent. Applicable for clinical trial consents (ICF). Null for non-trial privacy consents.',
    `biomarker_substudy_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to participate in biomarker or translational research sub-studies. True if consented, False if declined or not applicable.',
    `consent_category` STRING COMMENT 'Category of consent record. Distinguishes between clinical informed consent (ICF), re-consent events, consent withdrawals, GDPR privacy consent, HIPAA authorization, and data sharing consent.. Valid values are `clinical_icf|re_consent|withdrawal|privacy_gdpr|privacy_hipaa|data_sharing`',
    `consent_channel` STRING COMMENT 'Channel or interface through which consent was captured. Distinguishes between web portal, mobile app, paper form, in-person at site, telephonic, or email.. Valid values are `web|mobile_app|paper|in_person|telephonic|email`',
    `consent_document_url` STRING COMMENT 'URL or file path to the signed consent document stored in the document management system (e.g., Veeva Vault, eTMF). Used for regulatory inspection readiness.',
    `consent_expiry_date` DATE COMMENT 'Date when the consent expires or is no longer valid. Null for consents without expiration. Applicable for time-limited privacy consents or trial-specific consents.',
    `consent_language` STRING COMMENT 'Language in which the informed consent form was presented to the patient. ISO 639-1 two-letter language code (e.g., EN, ES, FR, DE, JA).',
    `consent_method` STRING COMMENT 'Method by which consent was obtained. Distinguishes between paper-based, electronic consent (eConsent), verbal consent, or telephonic consent.. Valid values are `paper|econsent|verbal|telephonic`',
    `consent_obtained_date` DATE COMMENT 'Date when the informed consent was obtained from the patient or legally authorized representative (LAR). Primary business event timestamp for consent lifecycle.',
    `consent_obtained_timestamp` TIMESTAMP COMMENT 'Precise timestamp when consent was obtained. Used for eConsent systems and audit trail. Complements consent_obtained_date with time-of-day precision.',
    `consent_purpose` STRING COMMENT 'Specific purpose for which consent was obtained. Examples: clinical_trial_participation, data_processing, research, marketing, data_sharing, pharmacovigilance, patient_support_program. Free-text or controlled vocabulary.',
    `consent_signature_method` STRING COMMENT 'Method by which the patient or LAR signed the consent. Examples: wet_signature (ink on paper), electronic_signature, digital_signature (PKI-based), biometric, verbal_recorded.. Valid values are `wet_signature|electronic_signature|digital_signature|biometric|verbal_recorded`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent. Tracks whether consent is pending signature, obtained, withdrawn by patient, expired, declined, or revoked.. Valid values are `pending|obtained|withdrawn|expired|declined|revoked`',
    `consent_type` STRING COMMENT 'Specific type or sub-category of consent. Examples: main_study, sub_study_genetic, sub_study_biomarker, future_research, data_processing, marketing, third_party_sharing. Provides granular classification within consent_category.',
    `consent_withdrawal_date` DATE COMMENT 'Date when the patient withdrew consent. Null if consent has not been withdrawn. Critical for GCP compliance and data subject rights.',
    `data_subject_rights_fulfillment_date` DATE COMMENT 'Date when the data subject rights request was fulfilled or completed. Null if request is pending or no request exists.',
    `data_subject_rights_request_date` DATE COMMENT 'Date when the data subject rights request was received. Null if no request. Critical for GDPR compliance (30-day response requirement).',
    `data_subject_rights_request_type` STRING COMMENT 'Type of data subject rights request associated with this consent record. Examples: access, erasure, portability, rectification, restriction, objection. Null if no request. Applicable for GDPR compliance.',
    `econsent_platform` STRING COMMENT 'Name or identifier of the eConsent platform or system used to capture electronic consent. Examples: Medidata Rave, Veeva Vault, Florence eBinders. Null for paper consents.',
    `future_use_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to future use of their data or biological samples for research purposes beyond the current study. True if consented, False if declined.',
    `gdpr_lawful_basis` STRING COMMENT 'GDPR Article 6 or Article 9 lawful basis for processing personal data. Examples: consent, legitimate_interest, legal_obligation, vital_interests, public_task, explicit_consent_special_category. Applicable for EU/EEA patients.',
    `genetic_substudy_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to participate in genetic or genomic sub-studies. True if consented, False if declined or not applicable.',
    `hipaa_authorization_flag` BOOLEAN COMMENT 'Indicates whether HIPAA authorization was obtained for use and disclosure of protected health information (PHI). True if authorization obtained, False if not applicable or declined. Applicable for US patients.',
    `icf_version` STRING COMMENT 'Version number or identifier of the informed consent form document used. Critical for regulatory traceability and protocol amendment tracking. Applicable for clinical trial consents.',
    `lar_name` STRING COMMENT 'Full name of the legally authorized representative or caregiver who provided consent on behalf of the patient. Applicable for pediatric populations or incapacitated patients.',
    `lar_relationship` STRING COMMENT 'Relationship of the LAR to the patient. Examples: parent, legal guardian, healthcare proxy, power of attorney, caregiver.. Valid values are `parent|legal_guardian|healthcare_proxy|power_of_attorney|caregiver|other`',
    `re_consent_reason` STRING COMMENT 'Reason for re-consenting the patient. Examples: protocol_amendment, new_safety_information, icf_version_update, regulatory_requirement. Applicable when consent_category is re_consent.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the system. Audit trail field for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last updated in the system. Audit trail field for change tracking and compliance.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the patient for withdrawing consent. Examples: adverse_event, personal_reasons, lack_of_efficacy, relocation, lost_to_followup. Free-text or controlled vocabulary.',
    `withdrawal_scope` STRING COMMENT 'Scope of consent withdrawal. Indicates whether patient withdrew from entire study, data use only, biological sample use only, or future contact. Critical for GCP compliance.. Valid values are `full_withdrawal|data_only|sample_only|future_contact`',
    `witness_name` STRING COMMENT 'Full name of the impartial witness who observed the consent process. Required when patient or LAR cannot read, or as per local regulations.',
    `witness_signature_date` DATE COMMENT 'Date when the impartial witness signed the informed consent form. Null if no witness was required.',
    CONSTRAINT pk_informed_consent PRIMARY KEY(`informed_consent_id`)
) COMMENT 'Unified consent lifecycle management covering clinical informed consent (ICF), re-consent events, consent withdrawals, and all data privacy authorizations. Clinical consent: ICF version, consent/withdrawal dates, consenting investigator, witness, method (paper, eConsent), language, sub-study consent flags (genetic, biomarker, future use). Privacy consent: GDPR Article 6/9 lawful basis, HIPAA authorization, consent purpose (data processing, research, marketing, data sharing), data subject rights requests (access, erasure, portability, rectification), request/fulfillment dates, jurisdiction (EU, US, UK, JP), consent channel (web, paper, verbal). Captures consent category (clinical_icf, re-consent, withdrawal, privacy_gdpr, privacy_hipaa, data_sharing), LAR/caregiver reference for pediatric populations, and full audit trail. Single source of truth for ALL consent types — clinical and privacy. Mandatory for GCP compliance, regulatory inspection readiness, HIPAA/GDPR compliance, and data subject rights fulfillment.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` (
    `concomitant_medication_id` BIGINT COMMENT 'Unique identifier for the concomitant medication record. Primary key for this entity.',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Concomitant medications must link to the investigational compound to assess drug-drug interactions, protocol compliance (prohibited concomitants), and relationship to adverse events. Critical for safe',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Concomitant medications are pharmaceutical products in material master for drug-drug interaction analysis, contraindicated medication detection, protocol deviation flagging, and safety signal detectio',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Concomitant medications must link to product master for drug-drug interaction analysis, contraindication checking, protocol deviation assessment, and safety signal detection in pharmacovigilance. Curr',
    `patient_id` BIGINT COMMENT 'Unique identifier for the clinical trial subject or patient taking the concomitant medication. Links to the patient or trial subject master record.',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial or study in which the concomitant medication was recorded. Links to the trial master record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical trial visit or encounter during which the concomitant medication was reported or recorded.',
    `action_taken` STRING COMMENT 'Action taken with the concomitant medication in response to an adverse event or safety concern (e.g., none, dose reduced, dose increased, temporarily stopped, permanently stopped).. Valid values are `none|dose_reduced|dose_increased|temporarily_stopped|permanently_stopped|not_applicable`',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical classification code for the concomitant medication. Provides therapeutic and pharmacological classification.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `comments` STRING COMMENT 'Free-text comments or additional notes regarding the concomitant medication, including clarifications, special circumstances, or investigator remarks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the concomitant medication record was first created in the system. Part of audit trail for regulatory compliance and data lineage.',
    `data_source` STRING COMMENT 'The source from which the concomitant medication data was captured (e.g., Case Report Form (CRF), electronic diary, medical record, subject interview, pharmacy record).. Valid values are `case_report_form|electronic_diary|medical_record|subject_interview|pharmacy_record`',
    `dose` DECIMAL(18,2) COMMENT 'The numeric dose amount of the concomitant medication administered per administration event. Used with dose_unit to specify complete dosing information.',
    `dose_unit` STRING COMMENT 'The unit of measure for the medication dose (e.g., mg, g, mcg, mL, IU, tablets, capsules). Standardized units for dose quantification. [ENUM-REF-CANDIDATE: mg|g|mcg|mL|L|IU|units|tablets|capsules|drops|puffs|patches — 12 candidates stripped; promote to reference product]',
    `frequency` STRING COMMENT 'The frequency or schedule of concomitant medication administration (e.g., once daily, twice daily, as needed, every 8 hours). Free-text or standardized frequency code.',
    `indication` STRING COMMENT 'The medical condition, symptom, or reason for which the concomitant medication is being taken. Free-text description of the therapeutic indication.',
    `medication_class` STRING COMMENT 'The therapeutic or pharmacological class of the concomitant medication (e.g., antibiotic, antihypertensive, analgesic, anticoagulant). Used for safety signal detection and drug-drug interaction screening.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the concomitant medication record. Part of audit trail for regulatory compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the concomitant medication record was last modified. Part of audit trail for regulatory compliance and data lineage.',
    `ongoing_flag` BOOLEAN COMMENT 'Boolean indicator of whether the concomitant medication is still being taken by the subject at the time of data capture or database lock. True if ongoing, False if stopped.',
    `prior_to_study_flag` BOOLEAN COMMENT 'Boolean indicator of whether the concomitant medication was started before the subject enrolled in the clinical trial. True if started prior, False if started during study.',
    `prohibited_concomitant_flag` BOOLEAN COMMENT 'Boolean indicator of whether the concomitant medication is prohibited per the clinical trial protocol. True if prohibited, False if allowed. Critical for protocol deviation tracking.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the use of this concomitant medication constitutes a protocol deviation. True if deviation occurred, False otherwise.',
    `record_status` STRING COMMENT 'Current lifecycle status of the concomitant medication record in the Electronic Data Capture (EDC) system (e.g., draft, submitted, verified, locked, query open, query resolved).. Valid values are `draft|submitted|verified|locked|query_open|query_resolved`',
    `relationship_to_ae` STRING COMMENT 'Investigator assessment of the relationship between the concomitant medication and any reported adverse event. Used for causality assessment in pharmacovigilance.. Valid values are `not_applicable|unrelated|unlikely|possible|probable|definite`',
    `route_of_administration` STRING COMMENT 'The route by which the concomitant medication is administered to the subject (e.g., oral, intravenous, subcutaneous, intramuscular, topical, inhalation).. Valid values are `oral|intravenous|subcutaneous|intramuscular|topical|inhalation`',
    `start_date` DATE COMMENT 'The date on which the subject began taking the concomitant medication. Critical for temporal analysis of drug-drug interactions and adverse event causality assessment.',
    `stop_date` DATE COMMENT 'The date on which the subject stopped taking the concomitant medication. Null if medication is ongoing at time of data capture.',
    `who_drug_code` STRING COMMENT 'Standardized WHO Drug Dictionary code for the concomitant medication. Used for global pharmacovigilance reporting and drug-drug interaction analysis.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the concomitant medication record. Part of audit trail for regulatory compliance.',
    CONSTRAINT pk_concomitant_medication PRIMARY KEY(`concomitant_medication_id`)
) COMMENT 'Records all concomitant medications taken by a participant during a study or program period. Captures WHO Drug-coded medication name, ATC classification code, dose, dose unit, route of administration, frequency, start date, stop date, ongoing flag, indication for use, and whether the medication is a prohibited concomitant per protocol. Critical for safety assessment, drug-drug interaction analysis, and pharmacovigilance case narratives.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` (
    `adverse_event_id` BIGINT COMMENT 'Primary key for adverse_event',
    `application_id` BIGINT COMMENT 'Foreign key linking to regulatory.application. Business justification: Aggregate safety reporting (PSURs, PBRERs, annual reports) requires grouping AEs by regulatory application/product for signal detection, benefit-risk assessment, and label update decisions. Standard p',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Regulatory pharmacovigilance requirement. When adverse events are reported post-market or in trials, FDA/EMA mandate traceability to manufacturing batch for investigation, recall assessment, and root ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Adverse events must be tracked by commercial brand for pharmacovigilance, regulatory reporting (periodic safety updates), commercial risk assessment, and launch readiness. Supports brand safety profil',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Pharmacovigilance requires linking adverse events to the specific investigational compound administered. Essential for safety signal detection, causality assessment, regulatory reporting (IND safety r',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Serious AE reporting failures, causality assessment errors, and SUSAR notification breaches are compliance incidents requiring investigation; link enables integrated safety-compliance event management',
    `inquiry_id` BIGINT COMMENT 'Foreign key linking to medical.medical_inquiry. Business justification: Adverse events often trigger medical information requests from investigators or sites seeking guidance on management or causality assessment. Linking AE to the resulting inquiry enables safety-medical',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Serious adverse events trigger additional costs (hospitalization, treatment, monitoring) that are captured in trial cost accounting via internal orders. Finance tracks SAE-related costs for trial fina',
    `investigational_product_id` BIGINT COMMENT 'Reference to the investigational product or study drug that the patient was receiving at the time of the adverse event.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Adverse events must link to medicinal product for ICSR reporting to FDA/EMA, product safety profiles, risk-benefit assessments, label updates, and post-market surveillance. Critical for pharmacovigila',
    `patient_id` BIGINT COMMENT 'Reference to the patient or clinical trial subject who experienced the adverse event.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Adverse events are frequently cited in regulatory inspections (safety reporting, causality assessment, SUSAR handling); direct linkage supports inspection response preparation, enables traceability fr',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Individual Case Safety Reports (ICSRs) and expedited AE reports to health authorities are submitted as regulatory submissions. Pharmacovigilance operations require linking safety cases to their regula',
    `trial_id` BIGINT COMMENT 'Reference to the clinical trial during which the adverse event occurred. Null for post-market surveillance events.',
    `action_taken_study_drug` STRING COMMENT 'Action taken with the investigational product or study drug in response to the adverse event.. Valid values are `None|Dose Reduced|Dose Increased|Drug Interrupted|Drug Withdrawn|Not Applicable`',
    `ae_term` STRING COMMENT 'The verbatim description of the adverse event as reported by the patient, investigator, or healthcare professional.',
    `case_number` STRING COMMENT 'Unique case identifier assigned by the pharmacovigilance system for regulatory reporting. Used for tracking and submission to regulatory authorities.',
    `causality_assessment` STRING COMMENT 'Investigator or sponsor assessment of the causal relationship between the adverse event and the investigational product or study drug.. Valid values are `Related|Probably Related|Possibly Related|Unlikely Related|Not Related|Not Assessable`',
    `duration_days` STRING COMMENT 'The duration of the adverse event in days, calculated from onset date to resolution date. Null if ongoing or fatal.',
    `expectedness` STRING COMMENT 'Indicates whether the adverse event was expected based on the current Investigator Brochure or product labeling.. Valid values are `Expected|Unexpected`',
    `meddra_pt_code` STRING COMMENT 'MedDRA preferred term code assigned to the adverse event for standardized medical terminology and regulatory reporting.',
    `meddra_pt_name` STRING COMMENT 'MedDRA preferred term name describing the adverse event in standardized medical terminology.',
    `meddra_soc_code` STRING COMMENT 'MedDRA system organ class code representing the highest level of the MedDRA hierarchy for the adverse event.',
    `meddra_soc_name` STRING COMMENT 'MedDRA system organ class name representing the body system affected by the adverse event.',
    `onset_date` DATE COMMENT 'The date when the adverse event first occurred or was first observed by the patient or investigator.',
    `outcome` STRING COMMENT 'Final outcome of the adverse event at the time of reporting or study completion.. Valid values are `Recovered|Recovering|Not Recovered|Recovered with Sequelae|Fatal|Unknown`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this adverse event record was first created in the data system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this adverse event record was last modified or updated in the data system.',
    `regulatory_report_date` DATE COMMENT 'The date when the adverse event was reported to the regulatory authority (FDA, EMA, etc.). Applicable for SAEs and SUSARs.',
    `report_date` DATE COMMENT 'The date when the adverse event was first reported to the sponsor or investigator.',
    `reported_by` STRING COMMENT 'The type of individual who initially reported the adverse event.. Valid values are `Investigator|Patient|Healthcare Professional|Caregiver|Other`',
    `reporting_timeline_compliance_status` STRING COMMENT 'Indicates whether the adverse event was reported to regulatory authorities within the required timeline (e.g., 7 days for fatal/life-threatening SAEs, 15 days for other SAEs).. Valid values are `Compliant|Non-Compliant|Not Applicable`',
    `resolution_date` DATE COMMENT 'The date when the adverse event resolved, recovered, or was no longer present. Null if ongoing or fatal.',
    `seriousness_criteria_congenital_anomaly` BOOLEAN COMMENT 'Indicates whether the adverse event resulted in a congenital anomaly or birth defect.',
    `seriousness_criteria_death` BOOLEAN COMMENT 'Indicates whether the adverse event resulted in death.',
    `seriousness_criteria_disability` BOOLEAN COMMENT 'Indicates whether the adverse event resulted in persistent or significant disability or incapacity.',
    `seriousness_criteria_hospitalization` BOOLEAN COMMENT 'Indicates whether the adverse event resulted in initial or prolonged inpatient hospitalization.',
    `seriousness_criteria_life_threatening` BOOLEAN COMMENT 'Indicates whether the adverse event was life-threatening at the time of the event.',
    `seriousness_criteria_medically_important` BOOLEAN COMMENT 'Indicates whether the adverse event was considered medically important and may jeopardize the patient or require intervention to prevent one of the other serious outcomes.',
    `seriousness_flag` BOOLEAN COMMENT 'Indicates whether the adverse event meets regulatory criteria for seriousness (death, life-threatening, hospitalization, disability, congenital anomaly, or other medically important condition).',
    `severity_grade` STRING COMMENT 'Severity grade of the adverse event using CTCAE scale: Grade 1 (Mild), Grade 2 (Moderate), Grade 3 (Severe), Grade 4 (Life-threatening), Grade 5 (Death).. Valid values are `Grade 1|Grade 2|Grade 3|Grade 4|Grade 5`',
    `source_system` STRING COMMENT 'The operational system from which the adverse event record was captured (e.g., Argus Safety for pharmacovigilance, Medidata Rave for clinical trial EDC).. Valid values are `Argus Safety|Oracle AERS|Medidata Rave|Veeva Vault|Manual Entry`',
    `study_day` STRING COMMENT 'The study day (relative to first dose or randomization) on which the adverse event occurred. Negative values indicate pre-treatment events.',
    `susar_flag` BOOLEAN COMMENT 'Indicates whether the adverse event qualifies as a SUSAR (serious, unexpected, and suspected to be related to the investigational product), requiring expedited reporting to regulatory authorities.',
    `treatment_administered` STRING COMMENT 'Description of any treatment, medication, or intervention administered to manage or resolve the adverse event.',
    CONSTRAINT pk_adverse_event PRIMARY KEY(`adverse_event_id`)
) COMMENT 'Captures all adverse events (AEs) and serious adverse events (SAEs) reported by or for a participant during a clinical trial or post-market surveillance program. Records MedDRA-coded preferred term (PT) and system organ class (SOC), onset date, resolution date, severity grade (CTCAE), seriousness criteria (death, hospitalization, life-threatening, etc.), causality assessment, action taken with study drug, outcome, SAE flag, SUSAR flag, and reporting timeline compliance status. Feeds into Argus Safety / Oracle AERS for regulatory reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` (
    `treatment_exposure_id` BIGINT COMMENT 'Unique identifier for the treatment exposure record. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: GCP drug accountability requirement. Clinical trial investigational product administration must be traceable to manufacturing batch for protocol compliance, quality investigations, and regulatory insp',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Treatment exposure records track administration of branded investigational products. Commercial teams need brand-level dosing patterns for supply forecasting, market access strategy (real-world dosing',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Investigational product administration in clinical trials represents drug consumption that must be costed. Clinical supply COGS tracking links treatment exposure to financial cost accounting for trial',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Each treatment exposure records administration of a specific discovery compound to a patient. Critical for dose-response analysis, PK/PD modeling, safety signal detection, and linking preclinical ADME',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Treatment exposure records must link to specific drug product (formulation, strength, lot) for dose-response analysis, lot-specific safety investigations, manufacturing quality feedback, and bioequiva',
    `investigational_product_id` BIGINT COMMENT 'Unique identifier for the investigational medicinal product (IMP) or approved therapy administered. Links to the investigational product master record.',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: GCP compliance requires documenting the physician who administered investigational product for accountability, drug accountability reconciliation, and safety reporting. Critical for clinical trial dat',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Investigational products are materials requiring lot traceability, expiry date management, storage condition compliance, batch genealogy for deviations, and inventory reconciliation. Critical for GMP ',
    `named_patient_request_id` BIGINT COMMENT 'Foreign key linking to medical.named_patient_request. Business justification: Named patient/compassionate use programs supply investigational product to specific patients outside clinical trials. Linking actual treatment exposure records to the originating NPP request enables s',
    `patient_id` BIGINT COMMENT 'Unique identifier for the clinical trial participant or patient receiving treatment. Links to the subject master record.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Investigational product manufacturing site tracking enables lot genealogy, deviation impact assessment (site-specific manufacturing issues), regulatory CMC documentation, and supply chain traceability',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Drug accountability requires storage location tracking for temperature excursion investigation, GMP compliance verification, inventory reconciliation, and product quality assurance. Essential for inve',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial or study protocol under which this treatment exposure occurred.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical trial visit during which this treatment exposure was recorded.',
    `administered_by` STRING COMMENT 'Name or identifier of the healthcare professional (HCP) who administered the investigational product.',
    `administration_date` DATE COMMENT 'Calendar date on which the investigational product was administered to the subject.',
    `administration_site` STRING COMMENT 'Anatomical site or location where the investigational product was administered (e.g., left arm, right thigh, abdomen). Relevant for injectable and topical routes.',
    `administration_time` TIMESTAMP COMMENT 'Precise date and time when the investigational product was administered. Critical for pharmacokinetic (PK) and pharmacodynamic (PD) analysis.',
    `blinding_status` STRING COMMENT 'Indicates whether the treatment assignment was blinded or unblinded at the time of administration.. Valid values are `blinded|unblinded|open_label`',
    `comments` STRING COMMENT 'Free-text comments or notes regarding this treatment exposure event, including any deviations, observations, or special circumstances.',
    `concomitant_medication_flag` BOOLEAN COMMENT 'Indicator whether the subject was taking other concomitant medications at the time of this treatment exposure. Important for drug-drug interaction analysis.',
    `cumulative_dose` DECIMAL(18,2) COMMENT 'Total cumulative dose of the investigational product administered to the subject from treatment start through this exposure event. Critical for dose-response modeling and safety assessment.',
    `cycle_number` STRING COMMENT 'Sequential cycle number for treatments administered in repeated cycles (common in oncology protocols).',
    `data_source_system` STRING COMMENT 'Name of the source system from which this treatment exposure data was captured (e.g., Medidata Rave, Oracle Clinical, site EDC system).',
    `dose_administered` DECIMAL(18,2) COMMENT 'Actual dose amount of the investigational product administered to the subject during this exposure event.',
    `dose_modification_flag` BOOLEAN COMMENT 'Indicator whether the administered dose was modified from the planned protocol dose. True if dose was adjusted, false if administered as planned.',
    `dose_modification_reason` STRING COMMENT 'Clinical rationale or reason for modifying the dose from the protocol-specified amount (e.g., adverse event, organ dysfunction, drug interaction).',
    `dose_unit` STRING COMMENT 'Unit of measure for the dose administered (e.g., milligrams, milliliters, international units, body-weight adjusted). [ENUM-REF-CANDIDATE: mg|g|mcg|mL|L|IU|mg/kg|mg/m2|units — 9 candidates stripped; promote to reference product]',
    `duration_of_infusion_minutes` STRING COMMENT 'Duration in minutes for intravenous infusion administration. Applicable only for IV infusion routes.',
    `expiration_date` DATE COMMENT 'Expiration date of the investigational product lot administered. Critical for quality control and regulatory compliance.',
    `frequency` STRING COMMENT 'Frequency of administration as specified in the protocol (e.g., once daily, twice daily, every 8 hours, weekly).',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the investigational product administered. Critical for traceability and pharmacovigilance.',
    `planned_dose` DECIMAL(18,2) COMMENT 'Protocol-specified dose amount that was planned to be administered according to the study design.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment exposure record was first created in the system. Audit trail for data lineage and 21 CFR Part 11 compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment exposure record was last modified. Audit trail for data lineage and regulatory compliance.',
    `route_of_administration` STRING COMMENT 'Method by which the investigational product was administered to the subject (e.g., oral, IV, subcutaneous).. Valid values are `oral|intravenous|subcutaneous|intramuscular|topical|inhalation`',
    `storage_condition` STRING COMMENT 'Required storage conditions for the investigational product (e.g., refrigerated 2-8°C, room temperature, protect from light).',
    `treatment_arm` STRING COMMENT 'Study arm or treatment group to which the subject was randomized (e.g., active treatment, placebo, comparator).',
    `treatment_compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of planned doses actually taken by the subject, calculated as (actual doses / planned doses) * 100. Measures adherence to protocol.',
    `treatment_status` STRING COMMENT 'Current status of this treatment exposure event indicating whether the dose was successfully administered or not.. Valid values are `administered|missed|refused|deferred|discontinued`',
    CONSTRAINT pk_treatment_exposure PRIMARY KEY(`treatment_exposure_id`)
) COMMENT 'Longitudinal record of a participants actual exposure to investigational medicinal product (IMP) or approved therapy. Captures drug name, INN, lot number, dose administered, planned dose, dose unit, route of administration, administration date and time, cycle number, visit number, dose modification flag, dose modification reason, cumulative dose, and treatment compliance percentage. Supports PK/PD analysis, dose-response modeling, and safety signal assessment.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` (
    `clinical_observation_id` BIGINT COMMENT 'Primary key for clinical_observation',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Clinical observations (labs, vitals, efficacy assessments) provide brand-specific evidence for promotional claims, medical affairs activities, payer value dossiers, and competitive positioning. Enable',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Lab results and clinical observations (PK samples, PD biomarkers, safety labs) must link to the discovery compound being tested. Required for PK/PD analysis, dose optimization, biomarker validation, a',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Clinical observations and lab results require physician assessment and medical review for clinical trial endpoints, safety monitoring, and dose modification decisions. Existing assessor_name is denorm',
    `patient_id` BIGINT COMMENT 'Unique identifier for the clinical trial participant or patient. Links to the subject master data.',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial or study protocol under which this observation was collected.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Lab result units must be standardized for cross-study data pooling, safety signal detection algorithms, dose-response modeling, and regulatory submission datasets (SDTM). Standardized UOM enables auto',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical visit or encounter during which this observation was collected.',
    `assay_version` STRING COMMENT 'Version number or lot number of the assay kit or reagent used for the test. Critical for genomic and biomarker assays to ensure reproducibility and comparability across batches.',
    `assessment_method` STRING COMMENT 'Method, technique, or instrument used to perform the observation (e.g., automated analyzer, manual count, PCR, immunohistochemistry, RECIST 1.1, ECOG performance status scale). Important for data interpretation and comparability.',
    `assessor_role` STRING COMMENT 'Role or qualification of the person who performed or interpreted the observation (e.g., principal investigator, sub-investigator, central reviewer, laboratory technician, radiologist). [ENUM-REF-CANDIDATE: PRINCIPAL_INVESTIGATOR|SUB_INVESTIGATOR|CENTRAL_REVIEWER|LABORATORY_TECHNICIAN|RADIOLOGIST|PATHOLOGIST|OTHER — 7 candidates stripped; promote to reference product]',
    `baseline_value` DECIMAL(18,2) COMMENT 'Baseline measurement value for this test or assessment, typically collected at screening or Day 1 before treatment initiation. Used to calculate change from baseline and assess treatment effect.',
    `biomarker_type` STRING COMMENT 'Classification of biomarker (e.g., companion diagnostic (CDx), tumor mutational burden (TMB), programmed death-ligand 1 (PD-L1), microsatellite instability (MSI), pharmacogenomic (PGx) panel, circulating tumor DNA (ctDNA)). Applicable only to biomarker and genomic observations.',
    `clinical_endpoint_type` STRING COMMENT 'Type of clinical endpoint assessment (e.g., RECIST 1.1 tumor response, iRECIST, DAS28 disease activity score, ECOG performance status, Karnofsky performance status, quality of life (QoL) score). Applicable only to clinical endpoint observations.',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was collected or the observation was performed. Critical for pharmacokinetic (PK) and pharmacodynamic (PD) analysis and longitudinal trending.',
    `data_source_system` STRING COMMENT 'Source system from which this observation was captured (e.g., Electronic Data Capture (EDC) system like Medidata Rave, Laboratory Information Management System (LIMS) like LabWare, central laboratory, molecular diagnostics vendor, imaging PACS). Used for data lineage and reconciliation. [ENUM-REF-CANDIDATE: EDC|LIMS|CENTRAL_LAB|MOLECULAR_DIAGNOSTICS|IMAGING_PACS|EHR|OTHER — 7 candidates stripped; promote to reference product]',
    `delta_from_baseline_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this observation represents a change from baseline value. True if this is a delta calculation, False if this is an absolute measurement. Used for longitudinal analysis and safety monitoring.',
    `endpoint_response` STRING COMMENT 'Categorical response or outcome for clinical endpoint assessments (e.g., complete response (CR), partial response (PR), stable disease (SD), progressive disease (PD) for RECIST; remission, relapse for DAS28). Uses standardized response criteria.',
    `gene_name` STRING COMMENT 'Name of the gene analyzed in genomic or pharmacogenomic testing (e.g., EGFR, KRAS, BRCA1, TP53). Uses HGNC (HUGO Gene Nomenclature Committee) standard gene symbols.',
    `laboratory_identifier` STRING COMMENT 'Unique identifier for the laboratory or assay vendor (e.g., CLIA number, CAP accreditation number, vendor assay catalog ID). Used for traceability and regulatory submissions.',
    `laboratory_name` STRING COMMENT 'Name of the laboratory, imaging center, or facility that performed the test or assessment. Used for quality control and result reconciliation.',
    `mutation_detected` STRING COMMENT 'Specific genetic mutation or variant detected (e.g., EGFR L858R, KRAS G12C, BRCA1 c.68_69delAG). Uses HGVS (Human Genome Variation Society) nomenclature for precision.',
    `observation_category` STRING COMMENT 'High-level classification of the clinical observation type. Aligns with CDISC findings-class domains (LB=laboratory, VS=vital signs, MB=microbiology/biomarker, TR=tumor response).. Valid values are `laboratory|vital_sign|biomarker|genomic|clinical_endpoint|imaging`',
    `observation_status` STRING COMMENT 'Current status of the observation record in the data lifecycle. Preliminary results may be updated; final results are locked for analysis. Amended indicates a correction was made post-finalization.. Valid values are `PRELIMINARY|FINAL|AMENDED|CANCELLED|ENTERED_IN_ERROR`',
    `out_of_range_indicator` STRING COMMENT 'Flag indicating whether the result is within, above, or below the reference range. Critical for safety monitoring and adverse event (AE) detection.. Valid values are `NORMAL|HIGH|LOW|CRITICALLY_HIGH|CRITICALLY_LOW|ABNORMAL`',
    `record_created_datetime` TIMESTAMP COMMENT 'Timestamp when this observation record was first created in the source system. Used for audit trail and data lineage tracking per Good Clinical Practice (GCP) and 21 CFR Part 11 requirements.',
    `record_updated_datetime` TIMESTAMP COMMENT 'Timestamp when this observation record was last modified in the source system. Used for audit trail and change tracking per Good Clinical Practice (GCP) and 21 CFR Part 11 requirements.',
    `reference_range_lower` DECIMAL(18,2) COMMENT 'Lower bound of the normal reference range for this test. Used to determine if result is out of range (low). May vary by age, sex, and laboratory.',
    `reference_range_upper` DECIMAL(18,2) COMMENT 'Upper bound of the normal reference range for this test. Used to determine if result is out of range (high). May vary by age, sex, and laboratory.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation or assessment of the result by the investigator or central reviewer (e.g., clinically significant, not clinically significant, consistent with disease progression). Free-text field.',
    `result_value_numeric` DECIMAL(18,2) COMMENT 'Numeric result value for quantitative observations (e.g., hemoglobin level, blood pressure, tumor size, biomarker concentration). Null for qualitative or categorical results.',
    `result_value_text` STRING COMMENT 'Text or categorical result value for qualitative observations (e.g., positive/negative, normal/abnormal, gene mutation detected). Used when result is not numeric.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for laboratory or biomarker testing (e.g., blood, serum, plasma, urine, tissue, saliva, cerebrospinal fluid). Uses SNOMED CT or CDISC controlled terminology.',
    `test_code` STRING COMMENT 'Standardized code for the test or assessment. Typically LOINC code for laboratory tests, SNOMED CT for clinical findings, or proprietary assay identifier for genomic tests.',
    `test_code_system` STRING COMMENT 'The coding system or terminology used for the test_code field. Identifies the standard vocabulary (LOINC, SNOMED CT, CDISC controlled terminology, or proprietary assay catalog).. Valid values are `LOINC|SNOMED_CT|CDISC|PROPRIETARY|OTHER`',
    `test_name` STRING COMMENT 'The name of the laboratory test, vital sign measurement, biomarker assay, or clinical assessment performed. Free-text or standardized name from LOINC or assay catalog.',
    `toxicity_grade` STRING COMMENT 'Severity grade for laboratory abnormalities using CTCAE grading scale (Grade 0=none, Grade 1=mild, Grade 2=moderate, Grade 3=severe, Grade 4=life-threatening, Grade 5=death). Used for safety reporting and dose modification decisions. [ENUM-REF-CANDIDATE: GRADE_0|GRADE_1|GRADE_2|GRADE_3|GRADE_4|GRADE_5|NOT_APPLICABLE — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_clinical_observation PRIMARY KEY(`clinical_observation_id`)
) COMMENT 'Consolidated clinical findings and measurements collected from participants across all observation categories. Covers laboratory results (LOINC-coded tests, specimen type, toxicity grade), vital signs (blood pressure, heart rate, temperature, weight, BMI, respiratory rate, SpO2), biomarker/genomic results (CDx, TMB, PD-L1, MSI, PGx panels, gene mutations), and clinical endpoint assessments (RECIST 1.1, iRECIST, DAS28, ECOG PS, Karnofsky). Captures measurement category, test/assessment name, coding (LOINC, assay type), specimen type, collection date/time, visit name, result value, result unit, reference range, out-of-range flag, toxicity grade (CTCAE), result interpretation, assessor, assessment method, laboratory/assay identifier, and delta-from-prior flag. Aligned with OMOP CDM measurement table and CDISC findings-class domains (LB, VS, MB, TR). Sourced from EDC (Medidata Rave), LIMS (LabWare), central labs, and molecular diagnostics vendors.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` (
    `reported_outcome_id` BIGINT COMMENT 'Primary key for reported_outcome',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Patient-reported outcomes are critical commercial evidence for quality-of-life claims, payer negotiations (ICER reviews), patient-centric marketing, and value-based contracting. Links PRO data to spec',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: PRO instrument country determines linguistic validation requirements, cultural adaptation needs, regulatory acceptance criteria (FDA PRO guidance), and country-specific normative data for score interp',
    `investigational_site_id` BIGINT COMMENT 'Unique identifier for the clinical trial site where the PRO assessment was conducted. Links to the investigational site master data entity.',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient or clinical trial subject who provided this outcome. Links to the patient master data entity.',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial in which this patient-reported outcome was collected. Links to the trial master data entity.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical trial visit or assessment timepoint at which this outcome was collected. Links to the visit schedule entity.',
    `assessment_window_end_date` DATE COMMENT 'End date of the protocol-defined assessment window during which the PRO should be completed. Used to determine compliance with the study schedule.',
    `assessment_window_start_date` DATE COMMENT 'Start date of the protocol-defined assessment window during which the PRO should be completed. Used to determine compliance with the study schedule.',
    `baseline_flag` BOOLEAN COMMENT 'Indicates whether this PRO assessment represents the baseline measurement collected before the start of investigational product administration. True indicates baseline assessment; False indicates post-baseline assessment.',
    `clinically_meaningful_change_flag` BOOLEAN COMMENT 'Indicates whether the change in PRO score from baseline or previous assessment meets the threshold for clinically meaningful change as defined by the instrument validation studies or regulatory guidance. True indicates clinically meaningful change; False indicates change below the threshold.',
    `comments` STRING COMMENT 'Free-text comments or notes provided by the patient, site staff, or data manager regarding this PRO assessment. May include context about completion circumstances, patient feedback, or data clarifications.',
    `completion_date` DATE COMMENT 'Date on which the patient completed the PRO instrument or questionnaire. Used for longitudinal analysis and tracking changes over time.',
    `completion_method` STRING COMMENT 'Method or modality by which the patient completed the PRO instrument (e.g., ePRO electronic system, paper questionnaire, telephone interview, mobile app, web portal). Important for data quality assessment and regulatory submissions.. Valid values are `ePRO|paper|telephone|interview|mobile_app|web_portal`',
    `completion_status` STRING COMMENT 'Status of the PRO assessment completion. Indicates whether the instrument was fully completed, partially completed, not done, missed, or deferred to a later timepoint.. Valid values are `complete|partial|not_done|missed|deferred`',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the patient completed the PRO instrument. Provides granular temporal data for ePRO systems and compliance monitoring.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the PRO assessment was completed within the protocol-specified timeframe and according to the study procedures. True indicates compliant completion; False indicates non-compliance or protocol deviation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this patient-reported outcome record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the PRO data was entered into the electronic data capture system. May differ from completion_timestamp if paper forms were used and later transcribed.',
    `data_lock_flag` BOOLEAN COMMENT 'Indicates whether this PRO record has been locked for editing as part of the clinical trial database lock process. True indicates locked; False indicates editable.',
    `data_source` STRING COMMENT 'Source system or platform from which the PRO data was captured (e.g., EDC Electronic Data Capture, ePRO system, CTMS Clinical Trial Management System, patient portal, mobile app, paper CRF Case Report Form). Important for data lineage and quality assessment.. Valid values are `EDC|ePRO|CTMS|patient_portal|mobile_app|paper_CRF`',
    `domain_name` STRING COMMENT 'Name of the health domain or subscale measured by this outcome (e.g., Physical Functioning, Emotional Well-being, Pain, Fatigue, Social Functioning). Represents the specific aspect of quality of life being assessed.',
    `instrument_name` STRING COMMENT 'Name of the validated patient-reported outcome instrument or questionnaire used to collect this data (e.g., EQ-5D, FACT-G, SF-36, PROMIS, EORTC QLQ-C30).',
    `instrument_version` STRING COMMENT 'Version number or edition of the PRO instrument used (e.g., EQ-5D-5L, SF-36v2). Critical for ensuring consistency and comparability of results across timepoints and studies.',
    `item_identifier` STRING COMMENT 'Unique identifier for the specific question or item within the PRO instrument (e.g., Q1, Q2, Item_3). Used to map individual responses to the instrument structure.',
    `item_text` STRING COMMENT 'Full text of the question or item presented to the patient. Provides context for interpreting the response value.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the PRO instrument was administered (e.g., EN for English, ES for Spanish, FR for French). Critical for multinational trials and linguistic validation tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this patient-reported outcome record was last modified or updated. Used for audit trail and change tracking.',
    `missing_items_count` STRING COMMENT 'Number of items within the PRO instrument that were not answered by the patient. Used to assess data completeness and determine whether the instrument can be scored according to its validation rules.',
    `query_status` STRING COMMENT 'Status of any data queries raised against this PRO record during clinical data management review. Indicates whether the data has been questioned, is under review, or has been resolved.. Valid values are `no_query|open_query|resolved|closed`',
    `response_label` STRING COMMENT 'Human-readable label corresponding to the response value (e.g., Not at all, A little bit, Moderately, Quite a bit, Extremely). Provides semantic meaning to numeric or coded responses.',
    `response_value` DECIMAL(18,2) COMMENT 'Raw response value provided by the patient for this specific item. May be numeric, categorical, or free-text depending on the instrument design.',
    `study_day` STRING COMMENT 'Number of days since the patient enrolled in the clinical trial or since the first dose of investigational product. Used for standardized temporal analysis across patients with different enrollment dates.',
    `subscale_score` DECIMAL(18,2) COMMENT 'Score calculated for a specific domain or subscale within the PRO instrument (e.g., Physical Component Score, Mental Component Score). Allows granular analysis of specific health dimensions.',
    `total_score` DECIMAL(18,2) COMMENT 'Overall composite score calculated from all items in the PRO instrument. Represents the aggregate quality of life or health status measure. Calculation methodology is instrument-specific.',
    CONSTRAINT pk_reported_outcome PRIMARY KEY(`reported_outcome_id`)
) COMMENT 'Captures structured patient-reported outcome (PRO) and quality of life (QoL) data collected via validated instruments (e.g., EQ-5D, FACT-G, SF-36, PROMIS). Records instrument name, instrument version, domain/subscale name, item identifier, response value, total score, subscale score, completion date, completion method (ePRO, paper), visit name, and compliance flag. Supports QoL endpoints, HEOR submissions, and market access dossiers.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`registry` (
    `registry_id` BIGINT COMMENT 'Unique identifier for the patient registry record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Registry country scope drives regulatory mandate compliance (EMA post-authorization safety studies), data privacy framework selection, ethics committee requirements, and country-specific enrollment ta',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Patient registries are funded programs with dedicated cost tracking via internal orders for registry operations, data collection, site payments, and analysis. Finance allocates registry costs to inter',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Disease registries are organized by therapeutic area for long-term safety monitoring (e.g., REMS registries), real-world evidence generation, epidemiology studies, and regulatory post-approval commitm',
    `actual_end_date` DATE COMMENT 'Actual date when the registry completed or terminated all activities. Null if registry is still active.',
    `clinicaltrials_gov_number` STRING COMMENT 'Unique identifier assigned by ClinicalTrials.gov registry if the patient registry is registered on that platform. Format: NCT followed by 8 digits.. Valid values are `^NCT[0-9]{8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registry record was first created in the system.',
    `cro_name` STRING COMMENT 'Name of the Contract Research Organization contracted to manage or support registry operations. Null if managed in-house.',
    `current_enrollment` STRING COMMENT 'Current number of participants actively enrolled in the registry as of the last update.',
    `data_collection_frequency` STRING COMMENT 'Frequency at which data is collected from registry participants. Continuous indicates real-time or near-real-time collection; event-driven indicates collection triggered by specific clinical events. [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|event_driven — 7 candidates stripped; promote to reference product]',
    `data_collection_method` STRING COMMENT 'Primary method used to collect registry data. EDC: electronic data capture systems; Medical records: chart review and abstraction; Patient reported: direct from participants; Claims: insurance/billing data; Hybrid: multiple methods.. Valid values are `electronic_data_capture|medical_records_abstraction|patient_reported|claims_data|hybrid`',
    `data_retention_period_years` STRING COMMENT 'Number of years that registry data must be retained after registry completion per regulatory requirements and company policy.',
    `data_source_type` STRING COMMENT 'Temporal nature of data collection. Prospective: data collected going forward from enrollment; Retrospective: historical data collected from existing records; Hybrid: combination of both.. Valid values are `prospective|retrospective|hybrid`',
    `edc_system` STRING COMMENT 'Name of the electronic data capture system or platform used for registry data collection (e.g., Medidata Rave, Oracle Clinical, REDCap).',
    `funding_source` STRING COMMENT 'Primary source of funding for the registry operations and data collection activities.. Valid values are `industry_sponsored|government_funded|academic_institution|patient_advocacy_group|mixed`',
    `gdpr_compliance_flag` BOOLEAN COMMENT 'Indicates whether the registry is subject to and compliant with EU GDPR regulations for personal data protection (True) or not applicable (False).',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the registry. Global: worldwide; Regional: specific region (e.g., EU, Asia-Pacific); National: single country; Multi-country: specific set of countries.. Valid values are `global|regional|national|multi_country`',
    `governing_authority` STRING COMMENT 'Primary regulatory authority that oversees or mandates the registry. Multiple indicates oversight by more than one regulatory body. [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|WHO|multiple — 7 candidates stripped; promote to reference product]',
    `hipaa_compliance_flag` BOOLEAN COMMENT 'Indicates whether the registry is subject to and compliant with HIPAA regulations for protected health information (True) or not applicable (False).',
    `indication` STRING COMMENT 'Specific disease, condition, or medical indication that the registry is designed to study or monitor.',
    `informed_consent_required` BOOLEAN COMMENT 'Indicates whether participants must provide informed consent to participate in the registry (True) or consent is waived (False).',
    `irb_approval_required` BOOLEAN COMMENT 'Indicates whether the registry requires Institutional Review Board or Ethics Committee approval (True) or is exempt (False).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this registry record was most recently modified.',
    `manager_name` STRING COMMENT 'Name of the individual responsible for operational management and day-to-day administration of the registry.',
    `planned_end_date` DATE COMMENT 'Anticipated date for completion of all registry activities including final data collection and analysis. May be null for indefinite registries.',
    `primary_objective` STRING COMMENT 'Primary scientific or regulatory objective of the registry as stated in the protocol (e.g., assess long-term safety, characterize disease natural history, evaluate real-world effectiveness).',
    `principal_investigator_name` STRING COMMENT 'Name of the principal investigator or lead researcher responsible for the scientific conduct of the registry.',
    `protocol_effective_date` DATE COMMENT 'Date when the current version of the registry protocol became effective.',
    `protocol_number` STRING COMMENT 'Unique identifier for the registry protocol document that defines objectives, methodology, and data collection procedures.',
    `protocol_version` STRING COMMENT 'Version number of the current registry protocol. Incremented with each amendment or revision.',
    `registry_code` STRING COMMENT 'Unique alphanumeric code assigned to the registry for internal tracking and cross-system reference.',
    `registry_name` STRING COMMENT 'Official name of the patient registry as registered with regulatory authorities and used in protocol documentation.',
    `registry_status` STRING COMMENT 'Current operational status of the registry. Planning: protocol development phase; Active: operational and collecting data; Enrolling: actively recruiting participants; Closed to enrollment: no new participants but follow-up continues; Completed: all data collection finished; Terminated: ended prematurely; Suspended: temporarily paused. [ENUM-REF-CANDIDATE: planning|active|enrolling|closed_to_enrollment|completed|terminated|suspended — 7 candidates stripped; promote to reference product]',
    `registry_type` STRING COMMENT 'Classification of the registry based on its primary purpose and regulatory mandate. Disease registries track natural history of specific conditions; pregnancy registries monitor maternal and fetal outcomes; PASS registries fulfill post-marketing safety commitments; REMS registries are mandated by Risk Evaluation and Mitigation Strategy programs.. Valid values are `disease|pregnancy|post_authorization_safety_study|rems_mandated|natural_history|patient_reported_outcomes`',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the registry is mandated by a regulatory authority as a condition of drug approval or post-marketing requirement (True) or is voluntary/observational (False).',
    `secondary_objectives` STRING COMMENT 'Additional scientific or exploratory objectives of the registry beyond the primary objective. Multiple objectives may be listed.',
    `sponsoring_organization` STRING COMMENT 'Name of the pharmaceutical company, research institution, or consortium that sponsors and funds the registry.',
    `start_date` DATE COMMENT 'Date when the registry officially commenced operations and began enrolling participants or collecting data.',
    `target_enrollment` STRING COMMENT 'Planned total number of participants to be enrolled in the registry as specified in the protocol.',
    CONSTRAINT pk_registry PRIMARY KEY(`registry_id`)
) COMMENT 'Master record for patient registries maintained or sponsored by the organization. Covers disease registries (e.g., rare disease natural history studies), pregnancy registries, post-authorization safety studies (PASS), and REMS-mandated registries. Captures registry name, type, therapeutic area, indication, sponsoring organization, regulatory mandate flag, start and planned end dates, target and current enrollment counts, data collection frequency, governing regulatory authority, and registry protocol version. Supports pharmacovigilance commitments, post-marketing requirements (PMRs), and market access evidence generation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`support_program` (
    `support_program_id` BIGINT COMMENT 'Unique identifier for the patient support program record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Patient support programs generate payables to vendors (specialty pharmacies, benefit managers, hub services) for program administration, fulfillment, and copay assistance. Finance tracks program-relat',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Patient support programs are tied to specific approved products (NDC codes) and their regulatory approvals. Programs must align with approved indication, REMS requirements, and distribution restrictio',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product associated with this patient support program.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Commercial patient support programs operate under approved budgets with planned vs actual spend tracking. Finance monitors program costs (copay assistance, free drug, adherence support) against budget',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Patient support programs require prescriber enrollment and authorization for specialty pharmacy dispensing, prior authorization support, reimbursement services, and adherence monitoring. Commercial op',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Patient support programs are product-specific for adherence monitoring, reimbursement hub services, specialty pharmacy coordination, and real-world outcomes tracking. Material master link enables prog',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Patient support programs operationally instantiate market-defined patient access programs. The support_program tracks individual patient enrollment/benefit disbursement; patient_access_program defines',
    `patient_support_program_id` BIGINT COMMENT 'Foreign key linking to commercial.patient_support_program. Business justification: Patient support programs in clinical/registry contexts enroll participants into commercial program structures (copay, adherence, reimbursement support). Links operational patient enrollment to commerc',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Patient support programs (copay assistance, adherence, reimbursement support) are managed by corporate employees responsible for program design, vendor oversight, compliance monitoring, and Sunshine A',
    `active_enrolled_patients` STRING COMMENT 'Current count of patients with active enrollment status in this support program.',
    `adherence_data_source` STRING COMMENT 'Primary source of medication adherence data for programs with adherence monitoring enabled. [ENUM-REF-CANDIDATE: specialty_pharmacy|epro|connected_device|patient_reported|claims_data|mixed|not_applicable — 7 candidates stripped; promote to reference product]',
    `adherence_monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether this program includes medication adherence tracking and intervention services.',
    `commercial_payer_only_flag` BOOLEAN COMMENT 'Indicates whether the program is restricted to commercial insurance patients only (true) or allows government payer patients (false). Copay programs must exclude government payers per Anti-Kickback Statute.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance and regulatory review of the patient support program structure and operations.',
    `compliance_status` STRING COMMENT 'Current compliance status of the program with respect to Anti-Kickback Statute, Sunshine Act, and other applicable regulations.. Valid values are `compliant|under_review|remediation_required|non_compliant`',
    `contact_email_address` STRING COMMENT 'Primary email address for program inquiries and patient support communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone_number` STRING COMMENT 'Primary toll-free or direct phone number for patients and healthcare providers (HCPs) to contact the support program.. Valid values are `^+?[1-9]d{1,14}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient support program record was first created in the system.',
    `data_privacy_classification` STRING COMMENT 'Classification level for patient data collected and processed through this support program under HIPAA and GDPR requirements.. Valid values are `phi_protected|confidential|internal`',
    `enrollment_method` STRING COMMENT 'Primary method(s) by which patients can enroll in the support program.. Valid values are `online|phone|fax|mail|hcp_portal|mixed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient support program record was most recently updated.',
    `nurse_educator_support_flag` BOOLEAN COMMENT 'Indicates whether the program provides dedicated nurse educator support for patient education and clinical guidance.',
    `operational_vendor_name` STRING COMMENT 'Name of the third-party vendor or hub services provider contracted to administer the patient support program operations.',
    `prior_authorization_support_flag` BOOLEAN COMMENT 'Indicates whether the program assists patients and providers with insurance prior authorization processes.',
    `program_code` STRING COMMENT 'Unique alphanumeric code identifying the patient support program for operational and reporting purposes.. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_end_date` DATE COMMENT 'Date when the patient support program is scheduled to terminate or was terminated. Null for ongoing programs.',
    `program_start_date` DATE COMMENT 'Date when the patient support program became operational and began accepting enrollments.',
    `program_status` STRING COMMENT 'Current operational status of the patient support program in its lifecycle.. Valid values are `active|inactive|suspended|pending_launch|terminated`',
    `record_source_system` STRING COMMENT 'Name of the operational system of record from which this patient support program master data originated (e.g., Salesforce Health Cloud, Veeva CRM).',
    `reimbursement_support_flag` BOOLEAN COMMENT 'Indicates whether the program provides reimbursement navigation and claims appeal support services.',
    `specialty_pharmacy_network` STRING COMMENT 'Names of specialty pharmacy partners integrated with this patient support program for coordinated dispensing and adherence tracking.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Indicates whether financial assistance provided through this program must be reported under the Physician Payments Sunshine Act.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or disease category that this patient support program addresses. [ENUM-REF-CANDIDATE: oncology|immunology|rare_disease|cardiovascular|neurology|respiratory|metabolic|infectious_disease|other — 9 candidates stripped; promote to reference product]',
    `total_benefit_disbursed_amount` DECIMAL(18,2) COMMENT 'Cumulative financial assistance amount (in USD) disbursed through this program since inception for copay assistance programs.',
    `total_enrolled_patients` STRING COMMENT 'Cumulative count of unique patients enrolled in this support program since inception.',
    `vendor_contract_number` STRING COMMENT 'Contract reference number for the agreement with the operational vendor managing this program.',
    `website_url` STRING COMMENT 'Public-facing website URL where patients and HCPs can access program information and enrollment materials.',
    CONSTRAINT pk_support_program PRIMARY KEY(`support_program_id`)
) COMMENT 'Master and transactional record for patient support programs (PSPs) and hub services including copay assistance, adherence monitoring, nurse educator support, reimbursement/prior authorization support, and specialty pharmacy coordination. Master attributes: program name, type, associated product (NDC/brand), eligibility criteria, program dates, maximum benefit amount, operational vendor, program status. Copay assistance transactions: claim date, pharmacy identifier, NDC dispensed, quantity, days supply, gross cost, patient OOP amount, assistance amount applied, remaining benefit balance, payer eligibility (commercial only — government patients ineligible), rejection reason code. Adherence monitoring: prescribed regimen, actual doses, MPR, PDC, adherence tier, data source (specialty pharmacy, ePRO, connected device), intervention triggered flag. This is the single source of truth for ALL PSP activity including copay claims formerly tracked separately. Supports commercial access strategy, patient retention, and HEOR real-world evidence.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` (
    `protocol_deviation_id` BIGINT COMMENT 'Primary key for protocol_deviation',
    `affairs_plan_id` BIGINT COMMENT 'Foreign key linking to medical.medical_affairs_plan. Business justification: Protocol deviations in company-sponsored trials are tracked within medical affairs oversight as quality metrics. Linking deviations to the governing medical affairs plan enables portfolio-level qualit',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Significant protocol deviations (major inclusion/exclusion violations, prohibited concomitant medication, dosing errors) are compliance incidents requiring investigation and potential regulatory repor',
    `inspection_observation_id` BIGINT COMMENT 'Foreign key linking to compliance.inspection_observation. Business justification: Protocol deviations often become formal FDA 483 observations; direct link from deviation to observation supports inspection response documentation, enables root cause analysis traceability, and facili',
    `investigational_site_id` BIGINT COMMENT 'Identifier of the clinical site where the protocol deviation occurred.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Protocol deviations are reviewed and managed by organizational units (quality assurance, medical affairs) for CAPA tracking, root cause analysis, regulatory reporting (FDA Form 1572), and inspection r',
    `patient_id` BIGINT COMMENT 'Identifier of the trial participant for whom the protocol deviation was recorded. Links to the clinical trial subject master data.',
    `protocol_id` BIGINT COMMENT 'Identifier of the clinical trial protocol that was deviated from.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Protocol deviations are primary inspection findings in GCP inspections; linking deviations to inspections enables traceability from deviation discovery to inspection citation to CAPA, supports inspect',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Significant protocol deviations (safety-impacting, consent violations, GCP non-compliance) are reportable to health authorities via regulatory submissions. Link enables tracking which deviations were ',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial in which the protocol deviation occurred.',
    `capa_reference_number` STRING COMMENT 'Reference number linking this protocol deviation to a formal CAPA record in the Quality Management System (QMS) for tracking preventive measures.',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to the protocol deviation, including context, follow-up actions, or clarifications.',
    `corrective_action_date` DATE COMMENT 'The date on which corrective action was implemented to address the protocol deviation.',
    `corrective_action_taken` STRING COMMENT 'Description of the immediate corrective action taken to address the protocol deviation and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the protocol deviation record was first created in the system.',
    `deviation_date` DATE COMMENT 'The date on which the protocol deviation occurred or was identified to have occurred.',
    `deviation_description` STRING COMMENT 'Detailed narrative description of the protocol deviation, including what occurred and the circumstances surrounding the deviation.',
    `deviation_number` STRING COMMENT 'Business identifier or tracking number assigned to the protocol deviation for reference and audit purposes.',
    `deviation_status` STRING COMMENT 'Current lifecycle status of the protocol deviation record: open (newly identified), under review (being investigated), closed (resolved and documented), or pending CAPA (awaiting corrective action completion).. Valid values are `open|under_review|closed|pending_capa`',
    `deviation_type` STRING COMMENT 'Classification of the protocol deviation by category: inclusion/exclusion criteria violation, dosing error, visit window violation, prohibited medication use, informed consent issue, procedure deviation, assessment deviation, randomization error, or other. [ENUM-REF-CANDIDATE: inclusion_exclusion_criteria|dosing|visit_window|prohibited_medication|informed_consent|procedure|assessment|randomization|other — 9 candidates stripped; promote to reference product]',
    `discovery_date` DATE COMMENT 'The date on which the protocol deviation was discovered or detected by site staff or monitors.',
    `identified_by` STRING COMMENT 'Name or role of the individual who identified or discovered the protocol deviation (e.g., site coordinator, clinical research associate, principal investigator).',
    `impact_on_data_integrity` STRING COMMENT 'Assessment of the protocol deviations impact on the reliability and validity of clinical trial data: none, low, moderate, or high.. Valid values are `none|low|moderate|high`',
    `impact_on_subject_safety` STRING COMMENT 'Assessment of the protocol deviations impact on the safety and well-being of the trial participant: none, low, moderate, or high.. Valid values are `none|low|moderate|high`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the protocol deviation record was last updated or modified.',
    `preventive_action_plan` STRING COMMENT 'Description of the preventive measures and action plan implemented to prevent recurrence of similar protocol deviations.',
    `regulatory_report_date` DATE COMMENT 'The date on which the protocol deviation was reported to regulatory authorities, if applicable.',
    `regulatory_reportability_flag` BOOLEAN COMMENT 'Indicates whether the protocol deviation is reportable to regulatory authorities (FDA, EMA, etc.) based on severity and impact criteria. True if reportable, False if not.',
    `review_date` DATE COMMENT 'The date on which the protocol deviation was formally reviewed and assessed.',
    `reviewed_by` STRING COMMENT 'Name or role of the individual who reviewed and assessed the protocol deviation for severity and impact.',
    `root_cause_analysis` STRING COMMENT 'Documented analysis of the underlying root cause(s) that led to the protocol deviation, used to inform preventive actions.',
    `severity_classification` STRING COMMENT 'Classification of the deviation severity: major (significant impact on subject safety or data integrity), minor (minimal impact), or critical (immediate threat to subject safety or trial integrity).. Valid values are `major|minor|critical`',
    `source_document_reference` STRING COMMENT 'Reference to the source document or record in the originating system (e.g., Veeva Vault document ID, Medidata Rave form ID) for audit trail purposes.',
    `source_system` STRING COMMENT 'The operational system from which the protocol deviation record was sourced: Veeva Vault QualityDocs, Medidata Rave EDC, Clinical Trial Management System (CTMS), or other.. Valid values are `veeva_vault|medidata_rave|ctms|other`',
    CONSTRAINT pk_protocol_deviation PRIMARY KEY(`protocol_deviation_id`)
) COMMENT 'Documents protocol deviations and violations identified for a participant during a clinical trial. Captures deviation type (inclusion/exclusion criteria, dosing, visit window, prohibited medication, consent), deviation date, discovery date, severity classification (major/minor), impact on participant safety, impact on data integrity, corrective action taken, CAPA reference, and regulatory reportability flag. Sourced from Veeva Vault QualityDocs and Medidata Rave. Critical for GCP compliance and regulatory inspection readiness.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` (
    `biomarker_result_id` BIGINT COMMENT 'Unique identifier for the biomarker result record. Primary key for this entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Companion diagnostics (CDx) are approved alongside therapeutics with specific regulatory approvals mandating their use. Biomarker results for CDx-approved tests must link to the approval that defines ',
    `biospecimen_id` BIGINT COMMENT 'Unique identifier for the biological specimen, linking to laboratory information management system (LIMS) records.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Biomarker results inform companion diagnostic strategy, precision medicine positioning, and targeted therapy market sizing for specific brands. Essential for commercial diagnostic partnerships, patien',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Biomarker results (target engagement, PD markers, resistance mutations) must link to the specific compound tested. Required for proof-of-mechanism studies, dose-response biomarker analysis, and transl',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Companion diagnostics and biomarker testing require pathologist interpretation for patient stratification, treatment selection, and CDx-approved drug indications. Existing pathologist_name is denormal',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Biomarker results must link to medicinal product for companion diagnostic validation, precision medicine patient selection, label claims (e.g., PD-L1 for immunotherapy), and biomarker-driven indicatio',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Precision medicine requires linking patient biomarker results (gene mutations, protein expression, CDx tests) to the molecular target the drug was designed against. Essential for patient stratificatio',
    `patient_id` BIGINT COMMENT 'Unique identifier for the clinical trial participant or patient from whom the biomarker specimen was collected.',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial protocol under which this biomarker result was collected.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Biomarker quantitative results require standardized units for companion diagnostic cutoff application, clinical decision algorithms, cross-laboratory comparability, and CDx regulatory approval documen',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical visit or assessment timepoint at which the biomarker specimen was collected.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'The variant allele frequency (VAF) expressed as a decimal (e.g., 0.45 for 45% mutant allele frequency).',
    `assay_name` STRING COMMENT 'The commercial or proprietary name of the assay kit or platform used (e.g., FoundationOne CDx, Oncotype DX, Guardant360).',
    `assay_type` STRING COMMENT 'The laboratory assay methodology used to measure the biomarker (e.g., IHC, NGS, PCR, FISH, ELISA, mass spectrometry).. Valid values are `immunohistochemistry|next_generation_sequencing|polymerase_chain_reaction|fluorescence_in_situ_hybridization|enzyme_linked_immunosorbent_assay|mass_spectrometry`',
    `assay_version` STRING COMMENT 'The version or lot number of the assay kit used, critical for traceability and regulatory compliance.',
    `biomarker_code` STRING COMMENT 'Standardized code for the biomarker using LOINC, SNOMED CT, or HGNC nomenclature for genomic markers.',
    `biomarker_name` STRING COMMENT 'The name of the biomarker or molecular marker being measured (e.g., PD-L1, EGFR, KRAS, HER2, TMB, MSI).',
    `cdx_approved_flag` BOOLEAN COMMENT 'Indicates whether this biomarker assay is an FDA-approved or EMA-approved companion diagnostic (CDx) for a specific therapeutic indication.',
    `cdx_drug_indication` STRING COMMENT 'The specific drug and indication for which this companion diagnostic is approved (e.g., pembrolizumab for NSCLC with PD-L1 ≥50%).',
    `comments` STRING COMMENT 'Free-text comments or notes from the laboratory or pathologist regarding the biomarker result, specimen quality, or interpretation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this biomarker result record was first created in the data system.',
    `cutoff_value` DECIMAL(18,2) COMMENT 'The threshold value used to determine positive vs negative result interpretation for this biomarker (e.g., PD-L1 ≥50% for pembrolizumab eligibility).',
    `data_source` STRING COMMENT 'The source system or database from which this biomarker result was captured (e.g., LIMS, EDC, central laboratory portal).',
    `gene_name` STRING COMMENT 'The name of the gene associated with this biomarker result, using HGNC nomenclature (e.g., EGFR, KRAS, BRCA1, TP53).',
    `laboratory_clia_number` STRING COMMENT 'The CLIA certification number of the testing laboratory, required for clinical diagnostic testing in the United States.',
    `modified_by` STRING COMMENT 'The user ID or system account that last modified this biomarker result record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this biomarker result record was last modified in the data system.',
    `mutation_type` STRING COMMENT 'The type of genetic mutation detected (e.g., missense, nonsense, frameshift, deletion, insertion, amplification, fusion).',
    `quality_control_status` STRING COMMENT 'Indicates whether the biomarker assay passed internal quality control checks (e.g., passed, failed, not applicable).. Valid values are `passed|failed|not_applicable`',
    `reference_range_lower` DECIMAL(18,2) COMMENT 'The lower bound of the normal or reference range for this biomarker, if applicable.',
    `reference_range_upper` DECIMAL(18,2) COMMENT 'The upper bound of the normal or reference range for this biomarker, if applicable.',
    `result_date` DATE COMMENT 'The date on which the biomarker result was finalized and reported by the laboratory.',
    `result_interpretation` STRING COMMENT 'The clinical interpretation of the biomarker result (e.g., positive, negative, indeterminate, high, low, mutation detected, wild type). [ENUM-REF-CANDIDATE: positive|negative|indeterminate|high|low|normal|abnormal|mutation_detected|wild_type — 9 candidates stripped; promote to reference product]',
    `result_status` STRING COMMENT 'The current status of the biomarker result in the laboratory workflow (e.g., preliminary, final, corrected, cancelled, pending).. Valid values are `preliminary|final|corrected|cancelled|pending`',
    `result_value` DECIMAL(18,2) COMMENT 'The quantitative or qualitative value of the biomarker result (e.g., 50%, positive, mutation detected, 10 mutations/Mb).',
    `specimen_collection_date` DATE COMMENT 'The date on which the biological specimen was collected from the subject.',
    `specimen_type` STRING COMMENT 'The type of biological specimen from which the biomarker was measured (e.g., tumor tissue, blood, plasma, serum, saliva). [ENUM-REF-CANDIDATE: tumor_tissue|blood|plasma|serum|saliva|urine|cerebrospinal_fluid|bone_marrow — 8 candidates stripped; promote to reference product]',
    `test_date` DATE COMMENT 'The date on which the biomarker assay was performed by the laboratory.',
    `testing_laboratory` STRING COMMENT 'The name of the laboratory or Contract Research Organization (CRO) that performed the biomarker assay.',
    `variant_annotation` STRING COMMENT 'Detailed annotation of the genetic variant using HGVS nomenclature (e.g., c.2573T>G, p.L858R).',
    `created_by` STRING COMMENT 'The user ID or system account that created this biomarker result record.',
    CONSTRAINT pk_biomarker_result PRIMARY KEY(`biomarker_result_id`)
) COMMENT 'Stores biomarker and genomic/molecular profiling results for participants, including companion diagnostic (CDx) results, tumor mutation burden (TMB), PD-L1 expression, microsatellite instability (MSI) status, gene mutation panels, pharmacogenomic (PGx) markers, and protein biomarker assay results. Captures biomarker name, assay type, specimen type, collection date, result value, result unit, result interpretation (positive/negative/indeterminate), assay laboratory, assay kit version, and CDx regulatory approval status. Supports precision medicine and patient stratification.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for the diagnosis record. Primary key for the diagnosis entity.',
    `investigator_id` BIGINT COMMENT 'Identifier of the principal investigator or physician who assessed or confirmed the diagnosis. Applicable for clinical trial diagnoses.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Diagnosis adjudication is performed by organizational units (medical affairs, independent review committee) for endpoint assessment, eligibility confirmation, and medical monitoring. Essential for cli',
    `medical_heor_study_id` BIGINT COMMENT 'Foreign key linking to medical.medical_heor_study. Business justification: Real-world diagnosis data from patient registries and observational studies feeds HEOR analyses (epidemiology, disease burden, treatment patterns). Linking diagnosis records to HEOR studies enables pa',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Patient diagnoses with molecular subtyping (e.g., HER2+ breast cancer, EGFR-mutant NSCLC) must link to the molecular target. Essential for enrollment eligibility verification, target validation in cli',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient or clinical trial subject to whom this diagnosis belongs. Links to the patient master record.',
    `trial_id` BIGINT COMMENT 'Identifier for the clinical trial in which this diagnosis was recorded. Null for non-trial patient diagnoses.',
    `visit_id` BIGINT COMMENT 'Identifier for the clinical trial visit or patient encounter during which this diagnosis was recorded or assessed.',
    `anatomical_location` STRING COMMENT 'Anatomical site or body system affected by the diagnosis (e.g., lung, liver, central nervous system). May use standardized anatomical terminology.',
    `biomarker_subtype` STRING COMMENT 'Molecular or biomarker-defined subtype of the disease (e.g., HER2-positive, EGFR-mutant, PD-L1 high). Used for precision medicine and stratification.',
    `comments` STRING COMMENT 'Free-text comments or additional context regarding the diagnosis, including investigator notes, clarifications, or special circumstances.',
    `condition_type` STRING COMMENT 'Classification of the diagnosis: pre_existing (medical history prior to study), primary (main study indication), secondary (additional study-relevant diagnosis), comorbidity (concurrent condition), surgical (surgical history), family_history (familial condition).. Valid values are `pre_existing|primary|secondary|comorbidity|surgical|family_history`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this diagnosis record was first created in the system. Audit trail field.',
    `data_source` STRING COMMENT 'Source from which the diagnosis information was obtained: medical_record, investigator_assessment, patient_reported, electronic_health_record, registry, insurance_claim.. Valid values are `medical_record|investigator_assessment|patient_reported|electronic_health_record|registry|insurance_claim`',
    `diagnosis_date` DATE COMMENT 'Date when the diagnosis was formally assessed or recorded in the study or medical record. May differ from onset_date.',
    `diagnosis_method` STRING COMMENT 'Method by which the diagnosis was established: histological (biopsy/pathology), clinical (physical exam/symptoms), radiological (imaging), laboratory (lab tests), genetic (molecular testing), autopsy, self_reported. [ENUM-REF-CANDIDATE: histological|clinical|radiological|laboratory|genetic|autopsy|self_reported — 7 candidates stripped; promote to reference product]',
    `disease_stage` STRING COMMENT 'Stage or grade of the disease at diagnosis. May include TNM staging for oncology (e.g., T2N1M0), ECOG Performance Status, NYHA class, or other disease-specific staging systems.',
    `ecog_performance_status` STRING COMMENT 'ECOG Performance Status score at the time of diagnosis (0-5 scale). 0=fully active, 5=dead. Used for patient functional assessment in oncology trials.',
    `family_member_relationship` STRING COMMENT 'Relationship of the family member with the diagnosis (for family_history condition_type only). Null for non-family-history diagnoses. [ENUM-REF-CANDIDATE: parent|sibling|child|grandparent|aunt_uncle|cousin|not_applicable — 7 candidates stripped; promote to reference product]',
    `histology_type` STRING COMMENT 'Histological or pathological classification of the disease (e.g., adenocarcinoma, squamous cell carcinoma, diffuse large B-cell lymphoma). Applicable primarily to oncology diagnoses.',
    `icd_10_code` STRING COMMENT 'ICD-10 diagnosis code representing the condition. Standard medical classification system used for billing, epidemiology, and health management.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `laterality` STRING COMMENT 'Laterality of the diagnosis for paired organs or structures: left, right, bilateral, not_applicable.. Valid values are `left|right|bilateral|not_applicable`',
    `meddra_code` STRING COMMENT 'MedDRA Lowest Level Term (LLT) or Preferred Term (PT) code for the diagnosis. Used for regulatory reporting and pharmacovigilance.. Valid values are `^[0-9]{8}$`',
    `meddra_term` STRING COMMENT 'MedDRA Preferred Term (PT) text description of the diagnosis.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this diagnosis record. Audit trail field.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this diagnosis record was last modified. Audit trail field.',
    `ongoing_flag` BOOLEAN COMMENT 'Indicates whether the condition is still present at the time of data capture. True if ongoing, False if resolved.',
    `onset_date` DATE COMMENT 'Date when the condition was first diagnosed or symptoms began. Partial dates allowed per CDISC conventions.',
    `prior_treatment_flag` BOOLEAN COMMENT 'Indicates whether the patient received prior treatment for this condition before study enrollment or current assessment. True if prior treatment exists.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a protocol deviation (e.g., enrollment of ineligible patient due to undisclosed pre-existing condition). True if deviation occurred.',
    `record_status` STRING COMMENT 'Current status of the diagnosis record in the system: active, inactive, deleted, under_review. Used for data quality and audit purposes.. Valid values are `active|inactive|deleted|under_review`',
    `relationship_to_study_indication` STRING COMMENT 'Indicates whether this diagnosis is the primary study indication, related to the study indication, unrelated, or unknown. Used for eligibility and stratification.. Valid values are `primary_indication|related|unrelated|unknown`',
    `resolution_date` DATE COMMENT 'Date when the condition resolved or was no longer present. Null if ongoing.',
    `severity` STRING COMMENT 'Clinical severity assessment of the condition at diagnosis: mild, moderate, severe, life_threatening, fatal.. Valid values are `mild|moderate|severe|life_threatening|fatal`',
    `verbatim` STRING COMMENT 'Free-text verbatim description of the diagnosis as reported by the investigator, physician, or patient. Original uncoded term.',
    `created_by` STRING COMMENT 'User identifier or system account that created this diagnosis record. Audit trail field.',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'Longitudinal record of all patient conditions encompassing pre-existing medical history, prior diagnoses, surgical history, family history, and study-relevant primary/secondary diagnoses. Captures condition type (pre-existing, primary, secondary, comorbidity, surgical, family_history), ICD-10 code, MedDRA-coded term, onset date, resolution date, ongoing flag, severity, diagnosis method (histological, clinical, radiological), disease stage (TNM, ECOG PS), histology type, biomarker-defined subtype, relationship to study indication, and source (self-reported, medical record, investigator assessment). Subsumes the former medical_history concept — all pre-existing conditions and surgical/family history are stored here with appropriate type discriminators. Supports eligibility determination, safety signal contextualization, stratification, pharmacovigilance case assessment, and CDISC SDTM MH/CM domain derivation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` (
    `endpoint_assessment_id` BIGINT COMMENT 'Primary key for endpoint_assessment',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Clinical endpoint assessments (tumor response, disease progression, survival) must link to the compound tested. Essential for efficacy analysis, dose-response modeling, go/no-go decisions, and compari',
    `employee_id` BIGINT COMMENT 'Unique identifier for the healthcare professional or investigator who performed the endpoint assessment.',
    `iit_submission_id` BIGINT COMMENT 'Foreign key linking to medical.iit_submission. Business justification: Investigator-initiated trial proposals specify endpoints that will be assessed. When the IIT is executed, linking actual endpoint assessment records to the originating submission enables outcome track',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Endpoint assessments are conducted by organizational units (clinical operations, medical affairs, central reading facilities) for study execution oversight, data quality monitoring, and endpoint adjud',
    `patient_id` BIGINT COMMENT 'Unique identifier for the clinical trial participant or patient undergoing the endpoint assessment. Links to the subject master record.',
    `prior_assessment_endpoint_assessment_id` BIGINT COMMENT 'Reference to the previous endpoint assessment record for this subject and endpoint type, enabling longitudinal tracking and progression analysis.',
    `trial_id` BIGINT COMMENT 'Unique identifier for the clinical trial protocol under which this endpoint assessment was performed.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical trial visit during which this endpoint assessment was conducted.',
    `adjudication_status` STRING COMMENT 'Status of adjudication process for assessments requiring independent review or resolution of discordant readings between site and central assessors.. Valid values are `not_required|pending|completed|discordant`',
    `assessment_category` STRING COMMENT 'High-level category of the endpoint assessment: tumor response, disease activity score, functional status, quality of life, biomarker measurement, or imaging-based assessment.. Valid values are `tumor_response|disease_activity|functional_status|quality_of_life|biomarker|imaging`',
    `assessment_completion_flag` BOOLEAN COMMENT 'Boolean indicator of whether the endpoint assessment was successfully completed (True) or not completed (False).',
    `assessment_date` DATE COMMENT 'Date on which the endpoint assessment was performed or the measurement was taken.',
    `assessment_method` STRING COMMENT 'Methodology or instrument used to perform the assessment (e.g., CT scan, MRI, physical examination, patient questionnaire, laboratory test).',
    `assessment_name` STRING COMMENT 'Standardized name of the clinical assessment or measurement being performed (e.g., RECIST 1.1 Tumor Assessment, ECOG Performance Status, DAS28 Score).',
    `assessment_status` STRING COMMENT 'Current status of the endpoint assessment in the clinical trial workflow: scheduled, completed, missed, not done, pending review, or verified.. Valid values are `scheduled|completed|missed|not_done|pending_review|verified`',
    `assessment_time` TIMESTAMP COMMENT 'Precise timestamp when the endpoint assessment was performed, including time of day for time-sensitive measurements.',
    `assessor_role` STRING COMMENT 'Role or qualification of the individual who performed the assessment (e.g., principal investigator, radiologist, independent central reviewer).. Valid values are `principal_investigator|sub_investigator|radiologist|pathologist|independent_reviewer|central_reviewer`',
    `baseline_value` DECIMAL(18,2) COMMENT 'Baseline measurement value for this endpoint, captured at study entry or pre-treatment, used for comparison and change-from-baseline calculations.',
    `central_review_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assessment underwent independent central review or adjudication (True) or was site-assessed only (False).',
    `central_review_result` STRING COMMENT 'Result or interpretation provided by the independent central review committee, if central review was performed.',
    `change_from_baseline` DECIMAL(18,2) COMMENT 'Calculated change in the endpoint measurement from the baseline value. Positive or negative values indicate improvement or worsening depending on the endpoint.',
    `comments` STRING COMMENT 'Free-text comments or notes from the assessor regarding the endpoint assessment, including clinical observations or data quality notes.',
    `data_source_system` STRING COMMENT 'Source system from which the endpoint assessment data was captured (e.g., EDC system, CTMS, imaging PACS, ePRO platform, LIMS).',
    `endpoint_type` STRING COMMENT 'Classification of the endpoint being assessed: primary efficacy endpoint, secondary endpoint, exploratory endpoint, safety endpoint, or pharmacokinetic endpoint.. Valid values are `primary|secondary|exploratory|safety|efficacy|pharmacokinetic`',
    `evaluability_status` STRING COMMENT 'Determination of whether this assessment is evaluable for efficacy analysis per protocol criteria (evaluable, non-evaluable, or pending adjudication).. Valid values are `evaluable|non_evaluable|pending`',
    `non_evaluability_reason` STRING COMMENT 'Reason why the assessment was deemed non-evaluable for efficacy analysis (e.g., poor image quality, missing baseline, major protocol violation).',
    `not_done_reason` STRING COMMENT 'Reason why the scheduled endpoint assessment was not performed (e.g., subject withdrawal, adverse event, equipment failure, protocol deviation).',
    `percent_change_from_baseline` DECIMAL(18,2) COMMENT 'Percentage change in the endpoint measurement from baseline, calculated as ((current - baseline) / baseline) * 100.',
    `protocol_deviation_description` STRING COMMENT 'Detailed description of the protocol deviation related to this endpoint assessment, if applicable.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assessment was performed outside the protocol-specified window or methodology, constituting a protocol deviation.',
    `record_created_by` STRING COMMENT 'User identifier of the individual who created this endpoint assessment record in the system.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint assessment record was first created in the system.',
    `record_updated_by` STRING COMMENT 'User identifier of the individual who last modified this endpoint assessment record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint assessment record was last modified or updated.',
    `result_category` STRING COMMENT 'Categorical interpretation of the assessment result. For oncology: CR (Complete Response), PR (Partial Response), SD (Stable Disease), PD (Progressive Disease), NE (Not Evaluable). For other therapeutic areas: remission, response, non-response, improvement, worsening.',
    `result_unit` STRING COMMENT 'Unit of measure for the quantitative result value (e.g., mm, cm, score, percentage, mg/dL).',
    `result_value` DECIMAL(18,2) COMMENT 'Quantitative or qualitative result of the endpoint assessment. May be numeric (e.g., tumor size in mm, DAS28 score) or categorical (e.g., CR, PR, SD, PD).',
    `study_day` STRING COMMENT 'Number of days since the subjects enrollment or first dose in the clinical trial. Negative values indicate pre-treatment assessments.',
    CONSTRAINT pk_endpoint_assessment PRIMARY KEY(`endpoint_assessment_id`)
) COMMENT 'Records clinical efficacy and safety endpoint assessments performed on participants, including tumor response assessments (RECIST 1.1, iRECIST), disease activity scores (DAS28, CDAI), functional assessments (ECOG PS, Karnofsky), and imaging-based assessments. Captures assessment type, assessment date, visit name, assessor identifier, result value, result category (CR, PR, SD, PD for oncology), prior assessment reference, and assessment method. Supports primary and secondary endpoint derivation for regulatory submissions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` (
    `caregiver_id` BIGINT COMMENT 'Unique identifier for the caregiver or legally authorized representative (LAR) record. Primary key for the caregiver entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Caregiver country determines applicable legal authority frameworks (guardianship laws, legally authorized representative requirements), consent delegation rules, and contact compliance regulations. Es',
    `patient_id` BIGINT COMMENT 'Reference to the clinical trial participant or patient for whom this caregiver is designated. Links caregiver to the subject they represent or support.',
    `trial_id` BIGINT COMMENT 'Reference to the clinical trial in which the caregiver relationship is established. Required for trial-specific caregiver designations.',
    `primary_caregiver_id` BIGINT COMMENT 'Self-referencing FK on caregiver (primary_caregiver_id)',
    `address_line_1` STRING COMMENT 'Primary street address line for the caregiver. Required for patient support program materials shipment and copay assistance card delivery.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Optional field for complete address capture.',
    `alternate_phone_number` STRING COMMENT 'Secondary contact phone number for the caregiver. Provides backup communication channel for urgent trial-related matters.',
    `authority_documentation_reference` STRING COMMENT 'Reference number or identifier for the legal documentation establishing caregiver authority. Links to document management system for audit trail and regulatory inspection readiness.',
    `authority_documentation_type` STRING COMMENT 'Type of legal documentation establishing the caregivers authority to act on behalf of the participant. Required for LAR validation and informed consent compliance.. Valid values are `court_order|power_of_attorney|healthcare_proxy|parental_rights|guardianship_papers|conservatorship_decree`',
    `authority_verification_date` DATE COMMENT 'Date on which the caregivers legal authority was verified by the trial site or patient support program administrator. Required for informed consent validity and audit compliance.',
    `authority_verified_by` STRING COMMENT 'Name or identifier of the site personnel or program administrator who verified the caregivers legal authority. Required for audit trail and regulatory compliance.',
    `caregiver_status` STRING COMMENT 'Current lifecycle status of the caregiver designation. Active indicates the caregiver is currently authorized; inactive indicates the designation has ended; pending verification indicates documentation is under review.. Valid values are `active|inactive|pending_verification|expired|revoked`',
    `city` STRING COMMENT 'City or municipality of the caregivers address. Required for geographic analysis and program eligibility determination.',
    `comments` STRING COMMENT 'Free-text field for additional notes or special circumstances related to the caregiver designation. Used to capture context not covered by structured fields.',
    `consent_to_contact_flag` BOOLEAN COMMENT 'Indicates whether the caregiver has provided consent to be contacted for trial updates, patient support programs, and adherence monitoring. True if consent given, False otherwise. Required for GDPR and privacy compliance.',
    `date_of_birth` DATE COMMENT 'Date of birth of the caregiver. Required for age verification to ensure the caregiver meets legal age requirements for LAR designation in applicable jurisdictions.',
    `effective_end_date` DATE COMMENT 'Date on which the caregiver designation ends or expires. Null if the designation is ongoing. Required for tracking changes in legal representation and consent authority.',
    `effective_start_date` DATE COMMENT 'Date from which the caregiver designation becomes effective. Marks the beginning of the caregivers authority to act on behalf of the participant in trial or support program context.',
    `email_address` STRING COMMENT 'Primary email address for caregiver communication regarding trial updates, patient support programs, and adherence monitoring. Used for electronic consent delivery and program notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Legal first name of the caregiver or legally authorized representative. Required for identity verification and informed consent documentation.',
    `lar_designation_flag` BOOLEAN COMMENT 'Indicates whether this caregiver is formally designated as a legally authorized representative with authority to provide informed consent on behalf of the participant. True if LAR, False if supportive caregiver only.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the caregiver or legally authorized representative. Required for identity verification and informed consent documentation.',
    `middle_name` STRING COMMENT 'Middle name or initial of the caregiver. Optional field for complete legal name capture.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the caregiver. Used for trial site communications, adverse event reporting, and patient support program coordination.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the caregivers address. Required for shipment logistics and geographic analysis.',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code for the caregivers preferred communication language. Required for informed consent delivery and patient support program materials in appropriate language.. Valid values are `^[a-z]{2}$`',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this caregiver is the primary point of contact for trial communications and patient support program outreach. True if primary contact, False otherwise.',
    `record_created_by` STRING COMMENT 'User identifier or system account that created the caregiver record. Required for audit trail and accountability per GCP and 21 CFR Part 11 requirements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the caregiver record was first created in the system. Required for audit trail and data lineage tracking per GCP and 21 CFR Part 11 requirements.',
    `record_updated_by` STRING COMMENT 'User identifier or system account that last updated the caregiver record. Required for audit trail and accountability per GCP and 21 CFR Part 11 requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the caregiver record. Required for audit trail and change tracking per GCP and 21 CFR Part 11 requirements.',
    `relationship_to_participant` STRING COMMENT 'Nature of the relationship between the caregiver and the participant. Critical for determining authority to consent and legal standing in pediatric, rare disease, and incapacitated patient populations. [ENUM-REF-CANDIDATE: parent|legal_guardian|spouse|domestic_partner|adult_child|sibling|healthcare_proxy|court_appointed_guardian — 8 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Name or identifier of the operational system from which the caregiver record originated (e.g., Medidata Rave, Oracle Clinical, Veeva Vault, Salesforce Health Cloud). Required for data lineage and integration troubleshooting.',
    `state_province` STRING COMMENT 'State, province, or region of the caregivers address. Required for regulatory compliance and program eligibility verification.',
    `termination_reason` STRING COMMENT 'Reason for ending the caregiver designation. Required for audit trail and understanding changes in participant representation over the trial lifecycle. [ENUM-REF-CANDIDATE: participant_reached_majority|participant_regained_capacity|caregiver_request|legal_authority_revoked|participant_withdrawal|participant_death|trial_completion — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_caregiver PRIMARY KEY(`caregiver_id`)
) COMMENT 'Master record for caregivers and legally authorized representatives (LARs) associated with participants, critical for pediatric trials, rare disease programs, and patients lacking capacity to consent. Captures caregiver name, relationship to participant (parent, spouse, legal guardian, healthcare proxy), contact information, LAR designation flag, authority documentation reference, effective date, and end date. Required for informed consent validity in pediatric/incapacitated populations and for patient support program communications.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` (
    `patient_enrollment2_id` BIGINT COMMENT 'Primary key for patient_enrollment2',
    `patient_id` BIGINT COMMENT 'Auto-generated FK linking siloed enrollment to patient',
    CONSTRAINT pk_patient_enrollment2 PRIMARY KEY(`patient_enrollment2_id`)
) COMMENT 'This association product represents the enrollment relationship between a patient and a patient support program (PSP). It captures the complete lifecycle of a patients participation in a specific support program, including enrollment dates, eligibility verification, benefit tracking, and disenrollment. Each record links one patient to one support program with attributes that exist only in the context of this specific enrollment relationship. This is the operational record that enables tracking of copay assistance utilization, adherence monitoring participation, and program-specific patient outcomes.. Existence Justification: In pharmaceutical patient services operations, patients routinely enroll in multiple patient support programs simultaneously (e.g., copay assistance for one brand, adherence monitoring for another, nurse educator support for a third therapeutic area). Conversely, each support program serves thousands of patients concurrently. The enrollment relationship is a recognized operational business entity with its own lifecycle, managed actively by patient services teams, hub vendors, and specialty pharmacies.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` (
    `registry_enrollment_id` BIGINT COMMENT 'Unique identifier for this registry enrollment record. Primary key.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to the medicinal product enrolled in this registry',
    `registry_id` BIGINT COMMENT 'Foreign key linking to the patient registry tracking this product',
    `post_approval_commitment_id` BIGINT COMMENT 'Reference to the specific post-marketing requirement (PMR) or post-marketing commitment (PMC) that mandates this products enrollment in this registry, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registry enrollment record was first created in the system.',
    `current_patient_count` STRING COMMENT 'Current number of patients enrolled for this specific medicinal product within this registry.',
    `data_collection_frequency` STRING COMMENT 'Frequency at which data is collected for this specific product within the registry context. May differ from the registrys overall collection frequency based on product-specific regulatory requirements or protocol amendments. Explicitly identified in detection phase relationship data.',
    `enrollment_date` DATE COMMENT 'Date when the medicinal product was formally enrolled in this registry for monitoring and data collection. Explicitly identified in detection phase relationship data.',
    `enrollment_end_date` DATE COMMENT 'Date when enrollment of this medicinal product in this registry was completed or terminated. Null if enrollment is still active.',
    `enrollment_status` STRING COMMENT 'Current operational status of the product enrollment in this registry. Active: data collection ongoing; Suspended: temporarily paused; Completed: all required data collected; Terminated: enrollment ended prematurely. Explicitly identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this registry enrollment record was last modified.',
    `outcome_status` STRING COMMENT 'Summary status of clinical or safety outcomes observed for this product within this registry. Tracks aggregate outcome data at the product-registry level. Explicitly identified in detection phase relationship data.',
    `primary_indication` STRING COMMENT 'The specific disease indication or therapeutic use for which this medicinal product is being monitored within this registry. A product may be enrolled for different indications across multiple registries. Explicitly identified in detection phase relationship data.',
    `protocol_amendment_number` STRING COMMENT 'Specific protocol amendment number under which this product was enrolled, if the enrollment occurred after the initial protocol version.',
    `target_patient_count` STRING COMMENT 'Target number of patients to be enrolled for this specific medicinal product within this registry, as specified in the protocol or regulatory commitment.',
    `treatment_line` STRING COMMENT 'The line of therapy context in which this medicinal product is being used and monitored within the registry (e.g., first-line, second-line, maintenance therapy). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_registry_enrollment PRIMARY KEY(`registry_enrollment_id`)
) COMMENT 'This association product represents the enrollment of a medicinal product in a patient registry for post-marketing surveillance, safety monitoring, or regulatory commitment fulfillment. It captures product-specific enrollment data including enrollment dates, treatment context, and outcome tracking. Each record links one medicinal product to one registry with attributes that exist only in the context of this specific product-registry enrollment relationship.. Existence Justification: In pharmaceutical operations, medicinal products are enrolled in multiple patient registries simultaneously (e.g., a checkpoint inhibitor may be tracked in an oncology disease registry, a pregnancy exposure registry, and a REMS-mandated safety registry). Conversely, each registry monitors multiple medicinal products within its therapeutic scope (e.g., a rare disease registry tracks all approved therapies for that condition). Registry enrollment is an operational business process managed by pharmacovigilance and regulatory affairs teams, with specific enrollment dates, data collection protocols, and outcome tracking for each product-registry combination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`registry`(`registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_support_program_id` FOREIGN KEY (`support_program_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`support_program`(`support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_prior_assessment_endpoint_assessment_id` FOREIGN KEY (`prior_assessment_endpoint_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`endpoint_assessment`(`endpoint_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ADD CONSTRAINT `fk_patient_caregiver_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ADD CONSTRAINT `fk_patient_caregiver_primary_caregiver_id` FOREIGN KEY (`primary_caregiver_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`caregiver`(`caregiver_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` ADD CONSTRAINT `fk_patient_patient_enrollment2_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ADD CONSTRAINT `fk_patient_registry_enrollment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`registry`(`registry_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`patient` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`patient` SET TAGS ('dbx_domain' = 'patient');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` SET TAGS ('dbx_subdomain' = 'participant_identity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ctms_subject_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Management System (CTMS) Subject Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ctms_subject_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ctms_subject_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `data_privacy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Consent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `edc_subject_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Capture (EDC) ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `edc_subject_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `edc_subject_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ehr_mrn` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Medical Record Number (MRN)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ehr_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ehr_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Patient Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'screening|enrolled|randomized|treatment|follow_up|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Patient First Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gpid` SET TAGS ('dbx_business_glossary_term' = 'Global Patient Identifier (GPID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gpid` SET TAGS ('dbx_value_regex' = '^GPID-[A-Z0-9]{12}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gpid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `gpid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `informed_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `informed_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `informed_consent_status` SET TAGS ('dbx_value_regex' = 'pending|obtained|declined|withdrawn|expired');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Middle Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `mpi_token` SET TAGS ('dbx_business_glossary_term' = 'Master Patient Index (MPI) Token');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `mpi_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `mpi_token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Patient Nationality');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `patient_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `patient_status` SET TAGS ('dbx_value_regex' = 'active|deceased|lost_to_follow_up|withdrawn|completed');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `pseudonymization_token` SET TAGS ('dbx_business_glossary_term' = 'Pseudonymization Token');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `pseudonymization_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `pseudonymization_token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `pv_case_patient_reference` SET TAGS ('dbx_business_glossary_term' = 'Pharmacovigilance (PV) Case Patient ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `pv_case_patient_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `pv_case_patient_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `race` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `race` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Biological Sex');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|unknown');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `sex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `sex` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `specialty_pharmacy_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `specialty_pharmacy_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `specialty_pharmacy_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` SET TAGS ('dbx_subdomain' = 'participant_identity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `patient_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Enrollment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `affairs_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `designation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Designation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `clinical_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `lead_series_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Series Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Application Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Support Program Id');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `benefit_amount_received` SET TAGS ('dbx_business_glossary_term' = 'Total Benefit Amount Received');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `blinding_status` SET TAGS ('dbx_value_regex' = 'open_label|single_blind|double_blind|triple_blind|unblinded');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `cohort_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cohort Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `consent_to_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Consent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disenrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disposition_event_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Event Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disposition_event_type` SET TAGS ('dbx_value_regex' = 'completed|withdrawn|lost_to_followup|death|screen_failure|protocol_deviation');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disposition_primary_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Primary Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `disposition_secondary_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Secondary Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'clinical_trial|support_program|registry|expanded_access|compassionate_use');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `icf_version` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Form (ICF) Version');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `itt_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Intent-to-Treat (ITT) Population Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `last_dose_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dose Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `mitt_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Modified Intent-to-Treat (mITT) Population Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `patient_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `patient_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `pp_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Per-Protocol (PP) Population Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_business_glossary_term' = 'Randomization Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `randomization_number` SET TAGS ('dbx_business_glossary_term' = 'Randomization Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `randomization_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `randomization_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Region');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `safety_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Population Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `screen_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `stratification_factors` SET TAGS ('dbx_business_glossary_term' = 'Stratification Factors');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `unblinding_date` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `unblinding_reason` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` SET TAGS ('dbx_subdomain' = 'participant_identity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `informed_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Investigator ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `econsent_document_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Consent (eConsent) Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `iit_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Iit Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `privacy_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Application Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `biomarker_substudy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Sub-Study Consent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_category` SET TAGS ('dbx_value_regex' = 'clinical_icf|re_consent|withdrawal|privacy_gdpr|privacy_hipaa|data_sharing');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|paper|in_person|telephonic|email');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'paper|econsent|verbal|telephonic');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_obtained_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_signature_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Signature Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_signature_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|biometric|verbal_recorded');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'pending|obtained|withdrawn|expired|declined|revoked');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `data_subject_rights_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Rights Fulfillment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `data_subject_rights_request_date` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Rights Request Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `data_subject_rights_request_type` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Rights Request Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `econsent_platform` SET TAGS ('dbx_business_glossary_term' = 'Electronic Consent (eConsent) Platform');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `future_use_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Future Use Consent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `genetic_substudy_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Sub-Study Consent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `hipaa_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `icf_version` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Form (ICF) Version');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `lar_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Relationship');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `lar_relationship` SET TAGS ('dbx_value_regex' = 'parent|legal_guardian|healthcare_proxy|power_of_attorney|caregiver|other');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `re_consent_reason` SET TAGS ('dbx_business_glossary_term' = 'Re-Consent Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `withdrawal_scope` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Scope');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `withdrawal_scope` SET TAGS ('dbx_value_regex' = 'full_withdrawal|data_only|sample_only|future_contact');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` SET TAGS ('dbx_subdomain' = 'treatment_administration');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `concomitant_medication_id` SET TAGS ('dbx_business_glossary_term' = 'Concomitant Medication Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken with Concomitant Medication');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `action_taken` SET TAGS ('dbx_value_regex' = 'none|dose_reduced|dose_increased|temporarily_stopped|permanently_stopped|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'case_report_form|electronic_diary|medical_record|subject_interview|pharmacy_record');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `dose` SET TAGS ('dbx_business_glossary_term' = 'Medication Dose');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Dose Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Dosing Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Medication Indication');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `medication_class` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapeutic Class');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `ongoing_flag` SET TAGS ('dbx_business_glossary_term' = 'Ongoing Medication Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `prior_to_study_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior to Study Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `prohibited_concomitant_flag` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Concomitant Medication Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|verified|locked|query_open|query_resolved');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `relationship_to_ae` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Adverse Event (AE)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `relationship_to_ae` SET TAGS ('dbx_value_regex' = 'not_applicable|unrelated|unlikely|possible|probable|definite');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_value_regex' = 'oral|intravenous|subcutaneous|intramuscular|topical|inhalation');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `stop_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Stop Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `who_drug_code` SET TAGS ('dbx_business_glossary_term' = 'World Health Organization (WHO) Drug Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` SET TAGS ('dbx_subdomain' = 'treatment_administration');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `adverse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Inquiry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product (IP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `action_taken_study_drug` SET TAGS ('dbx_business_glossary_term' = 'Action Taken with Study Drug');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `action_taken_study_drug` SET TAGS ('dbx_value_regex' = 'None|Dose Reduced|Dose Increased|Drug Interrupted|Drug Withdrawn|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `ae_term` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Verbatim Term');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Individual Case Safety Report (ICSR) Case Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `causality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Causality Assessment to Study Drug');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `causality_assessment` SET TAGS ('dbx_value_regex' = 'Related|Probably Related|Possibly Related|Unlikely Related|Not Related|Not Assessable');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Duration in Days');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `expectedness` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Expectedness');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `expectedness` SET TAGS ('dbx_value_regex' = 'Expected|Unexpected');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `meddra_pt_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Preferred Term (PT) Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `meddra_pt_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Preferred Term (PT) Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `meddra_soc_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) System Organ Class (SOC) Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `meddra_soc_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) System Organ Class (SOC) Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Onset Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'Recovered|Recovering|Not Recovered|Recovered with Sequelae|Fatal|Unknown');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Reporter Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_value_regex' = 'Investigator|Patient|Healthcare Professional|Caregiver|Other');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `reporting_timeline_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Timeline Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `reporting_timeline_compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Resolution Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_congenital_anomaly` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria - Congenital Anomaly or Birth Defect');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_death` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria - Death');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_disability` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria - Persistent or Significant Disability');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_disability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_disability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_hospitalization` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria - Hospitalization');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_life_threatening` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria - Life-Threatening');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_criteria_medically_important` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria - Other Medically Important Condition');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `seriousness_flag` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `severity_grade` SET TAGS ('dbx_business_glossary_term' = 'Common Terminology Criteria for Adverse Events (CTCAE) Severity Grade');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `severity_grade` SET TAGS ('dbx_value_regex' = 'Grade 1|Grade 2|Grade 3|Grade 4|Grade 5');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Argus Safety|Oracle AERS|Medidata Rave|Veeva Vault|Manual Entry');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `study_day` SET TAGS ('dbx_business_glossary_term' = 'Study Day of Adverse Event (AE) Onset');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `susar_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspected Unexpected Serious Adverse Reaction (SUSAR) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `treatment_administered` SET TAGS ('dbx_business_glossary_term' = 'Treatment Administered for Adverse Event (AE)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `treatment_administered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ALTER COLUMN `treatment_administered` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` SET TAGS ('dbx_subdomain' = 'treatment_administration');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Exposure Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_exposure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_exposure_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `named_patient_request_id` SET TAGS ('dbx_business_glossary_term' = 'Named Patient Request Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `administered_by` SET TAGS ('dbx_business_glossary_term' = 'Administered By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `administered_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `administration_date` SET TAGS ('dbx_business_glossary_term' = 'Administration Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `administration_site` SET TAGS ('dbx_business_glossary_term' = 'Administration Site');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `administration_time` SET TAGS ('dbx_business_glossary_term' = 'Administration Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `blinding_status` SET TAGS ('dbx_value_regex' = 'blinded|unblinded|open_label');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Exposure Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `concomitant_medication_flag` SET TAGS ('dbx_business_glossary_term' = 'Concomitant Medication Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `cumulative_dose` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Dose');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Cycle Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `dose_administered` SET TAGS ('dbx_business_glossary_term' = 'Dose Administered');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `dose_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Dose Modification Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `dose_modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Dose Modification Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Dose Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `duration_of_infusion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration of Infusion (Minutes)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Dosing Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `planned_dose` SET TAGS ('dbx_business_glossary_term' = 'Planned Dose');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_value_regex' = 'oral|intravenous|subcutaneous|intramuscular|topical|inhalation');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Compliance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_compliance_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_compliance_percentage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'administered|missed|refused|deferred|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `clinical_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Observation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Assessing Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Subject Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Visit Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `assay_version` SET TAGS ('dbx_business_glossary_term' = 'Assay Version or Kit Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method or Technique');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `biomarker_type` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `clinical_endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Endpoint Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date and Time');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `delta_from_baseline_flag` SET TAGS ('dbx_business_glossary_term' = 'Delta from Baseline Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `endpoint_response` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Response or Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `gene_name` SET TAGS ('dbx_business_glossary_term' = 'Gene Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `laboratory_identifier` SET TAGS ('dbx_business_glossary_term' = 'Laboratory or Assay Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory or Facility Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `mutation_detected` SET TAGS ('dbx_business_glossary_term' = 'Mutation or Variant Detected');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_business_glossary_term' = 'Observation Category');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_value_regex' = 'laboratory|vital_sign|biomarker|genomic|clinical_endpoint|imaging');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'PRELIMINARY|FINAL|AMENDED|CANCELLED|ENTERED_IN_ERROR');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `out_of_range_indicator` SET TAGS ('dbx_business_glossary_term' = 'Out of Range Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `out_of_range_indicator` SET TAGS ('dbx_value_regex' = 'NORMAL|HIGH|LOW|CRITICALLY_HIGH|CRITICALLY_LOW|ABNORMAL');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `record_created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `record_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `reference_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Lower Limit');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `reference_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Upper Limit');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Result Interpretation');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Numeric Result Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Text Result Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test or Assessment Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `test_code_system` SET TAGS ('dbx_business_glossary_term' = 'Test Code System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `test_code_system` SET TAGS ('dbx_value_regex' = 'LOINC|SNOMED_CT|CDISC|PROPRIETARY|OTHER');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test or Assessment Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ALTER COLUMN `toxicity_grade` SET TAGS ('dbx_business_glossary_term' = 'Common Terminology Criteria for Adverse Events (CTCAE) Toxicity Grade');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `reported_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Reported Outcome Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `assessment_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Assessment Window End Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `assessment_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Assessment Window Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `baseline_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Assessment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `clinically_meaningful_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinically Meaningful Change Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `completion_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Completion Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `completion_method` SET TAGS ('dbx_value_regex' = 'ePRO|paper|telephone|interview|mobile_app|web_portal');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Completion Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'complete|partial|not_done|missed|deferred');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Completion Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `data_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Entry Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `data_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'EDC|ePRO|CTMS|patient_portal|mobile_app|paper_CRF');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `domain_name` SET TAGS ('dbx_business_glossary_term' = 'Quality of Life (QoL) Domain Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Instrument Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `instrument_version` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Instrument Version');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `item_identifier` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Item Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `item_text` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Item Text');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `missing_items_count` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Missing Items Count');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `query_status` SET TAGS ('dbx_business_glossary_term' = 'Data Query Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `query_status` SET TAGS ('dbx_value_regex' = 'no_query|open_query|resolved|closed');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `response_label` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Response Label');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `response_value` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Response Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `study_day` SET TAGS ('dbx_business_glossary_term' = 'Study Day');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `subscale_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Subscale Score');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ALTER COLUMN `total_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Outcome (PRO) Total Score');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `clinicaltrials_gov_number` SET TAGS ('dbx_business_glossary_term' = 'ClinicalTrials.gov Identifier (NCT Number)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `clinicaltrials_gov_number` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `cro_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Research Organization (CRO) Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `current_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `data_collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'electronic_data_capture|medical_records_abstraction|patient_reported|claims_data|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `data_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'prospective|retrospective|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `edc_system` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Capture (EDC) System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'industry_sponsored|government_funded|academic_institution|patient_advocacy_group|mixed');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `gdpr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|multi_country');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `governing_authority` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `hipaa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `informed_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Required');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `irb_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Required');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Manager Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `primary_objective` SET TAGS ('dbx_business_glossary_term' = 'Primary Objective');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `protocol_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `registry_code` SET TAGS ('dbx_business_glossary_term' = 'Registry Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `registry_status` SET TAGS ('dbx_business_glossary_term' = 'Registry Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `registry_type` SET TAGS ('dbx_business_glossary_term' = 'Registry Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `registry_type` SET TAGS ('dbx_value_regex' = 'disease|pregnancy|post_authorization_safety_study|rems_mandated|natural_history|patient_reported_outcomes');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `secondary_objectives` SET TAGS ('dbx_business_glossary_term' = 'Secondary Objectives');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `sponsoring_organization` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Organization');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Registry Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ALTER COLUMN `target_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Target Enrollment Count');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Support Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `patient_support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `active_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Active Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `adherence_data_source` SET TAGS ('dbx_business_glossary_term' = 'Adherence Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `adherence_monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Adherence Monitoring Enabled Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `commercial_payer_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Payer Only Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|under_review|remediation_required|non_compliant');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Classification');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `data_privacy_classification` SET TAGS ('dbx_value_regex' = 'phi_protected|confidential|internal');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online|phone|fax|mail|hcp_portal|mixed');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `nurse_educator_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Nurse Educator Support Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `operational_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Operational Vendor Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `operational_vendor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `prior_authorization_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Support Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_launch|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `reimbursement_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Support Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `specialty_pharmacy_network` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Network');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `specialty_pharmacy_network` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `total_benefit_disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Benefit Disbursed Amount');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `total_benefit_disbursed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `total_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` SET TAGS ('dbx_subdomain' = 'treatment_administration');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `protocol_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `affairs_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `inspection_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Observation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Subject ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `corrective_action_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `deviation_date` SET TAGS ('dbx_business_glossary_term' = 'Deviation Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|pending_capa');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `impact_on_data_integrity` SET TAGS ('dbx_business_glossary_term' = 'Impact on Data Integrity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `impact_on_data_integrity` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `impact_on_subject_safety` SET TAGS ('dbx_business_glossary_term' = 'Impact on Subject Safety');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `impact_on_subject_safety` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `regulatory_reportability_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'major|minor|critical');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'veeva_vault|medidata_rave|ctms|other');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `biomarker_result_id` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `biospecimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `biospecimen_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `biospecimen_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Pathologist Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Subject ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Allele Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `assay_name` SET TAGS ('dbx_business_glossary_term' = 'Assay Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `assay_type` SET TAGS ('dbx_value_regex' = 'immunohistochemistry|next_generation_sequencing|polymerase_chain_reaction|fluorescence_in_situ_hybridization|enzyme_linked_immunosorbent_assay|mass_spectrometry');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `assay_version` SET TAGS ('dbx_business_glossary_term' = 'Assay Version');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `biomarker_code` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `biomarker_name` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `cdx_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Companion Diagnostic (CDx) Approved Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `cdx_drug_indication` SET TAGS ('dbx_business_glossary_term' = 'Companion Diagnostic (CDx) Drug Indication');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `cutoff_value` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `gene_name` SET TAGS ('dbx_business_glossary_term' = 'Gene Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `laboratory_clia_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `mutation_type` SET TAGS ('dbx_business_glossary_term' = 'Mutation Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `mutation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `mutation_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `reference_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Lower Bound');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `reference_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Upper Bound');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_date` SET TAGS ('dbx_business_glossary_term' = 'Result Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|corrected|cancelled|pending');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `result_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `specimen_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `testing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `variant_annotation` SET TAGS ('dbx_business_glossary_term' = 'Variant Annotation');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `variant_annotation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `variant_annotation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` SET TAGS ('dbx_subdomain' = 'participant_identity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `medical_heor_study_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Heor Study Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `medical_heor_study_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `medical_heor_study_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `anatomical_location` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Location');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `biomarker_subtype` SET TAGS ('dbx_business_glossary_term' = 'Biomarker-Defined Subtype');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'pre_existing|primary|secondary|comorbidity|surgical|family_history');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'medical_record|investigator_assessment|patient_reported|electronic_health_record|registry|insurance_claim');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_method` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `diagnosis_method` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `disease_stage` SET TAGS ('dbx_business_glossary_term' = 'Disease Stage');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `ecog_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Eastern Cooperative Oncology Group (ECOG) Performance Status (PS)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `family_member_relationship` SET TAGS ('dbx_business_glossary_term' = 'Family Member Relationship');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `histology_type` SET TAGS ('dbx_business_glossary_term' = 'Histology Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `icd_10_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `icd_10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `meddra_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `meddra_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `meddra_term` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Term');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `ongoing_flag` SET TAGS ('dbx_business_glossary_term' = 'Ongoing Condition Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Onset Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `prior_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Treatment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `prior_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `prior_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `relationship_to_study_indication` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Study Indication');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `relationship_to_study_indication` SET TAGS ('dbx_value_regex' = 'primary_indication|related|unrelated|unknown');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Resolution Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `resolution_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Severity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life_threatening|fatal');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `verbatim` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Verbatim Description');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `verbatim` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` SET TAGS ('dbx_subdomain' = 'clinical_assessment');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `endpoint_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Assessment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `iit_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Iit Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `prior_assessment_endpoint_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Assessment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|discordant');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_category` SET TAGS ('dbx_business_glossary_term' = 'Assessment Category');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_category` SET TAGS ('dbx_value_regex' = 'tumor_response|disease_activity|functional_status|quality_of_life|biomarker|imaging');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|missed|not_done|pending_review|verified');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessment_time` SET TAGS ('dbx_business_glossary_term' = 'Assessment Time');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_value_regex' = 'principal_investigator|sub_investigator|radiologist|pathologist|independent_reviewer|central_reviewer');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `central_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Central Review Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `central_review_result` SET TAGS ('dbx_business_glossary_term' = 'Central Review Result');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `change_from_baseline` SET TAGS ('dbx_business_glossary_term' = 'Change from Baseline');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assessment Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|exploratory|safety|efficacy|pharmacokinetic');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `evaluability_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluability Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `evaluability_status` SET TAGS ('dbx_value_regex' = 'evaluable|non_evaluable|pending');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `non_evaluability_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Evaluability Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `not_done_reason` SET TAGS ('dbx_business_glossary_term' = 'Not Done Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `percent_change_from_baseline` SET TAGS ('dbx_business_glossary_term' = 'Percent Change from Baseline');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `protocol_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Description');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `result_category` SET TAGS ('dbx_business_glossary_term' = 'Result Category');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ALTER COLUMN `study_day` SET TAGS ('dbx_business_glossary_term' = 'Study Day');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` SET TAGS ('dbx_subdomain' = 'participant_identity');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `caregiver_id` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `primary_caregiver_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `authority_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Authority Documentation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `authority_documentation_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `authority_documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Authority Documentation Type');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `authority_documentation_type` SET TAGS ('dbx_value_regex' = 'court_order|power_of_attorney|healthcare_proxy|parental_rights|guardianship_papers|conservatorship_decree');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `authority_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `authority_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Authority Verified By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `caregiver_status` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `caregiver_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|expired|revoked');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `consent_to_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent to Contact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Date of Birth');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Caregiver First Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `lar_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Middle Name');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `relationship_to_participant` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Participant');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` SET TAGS ('dbx_association_edges' = 'patient.patient,patient.support_program');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` ALTER COLUMN `patient_enrollment2_id` SET TAGS ('dbx_business_glossary_term' = 'patient_enrollment2 Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment2` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to patient');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` SET TAGS ('dbx_association_edges' = 'product.medicinal_product,patient.registry');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `registry_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Enrollment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Enrollment - Medicinal Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Enrollment - Registry Id');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `post_approval_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `current_patient_count` SET TAGS ('dbx_business_glossary_term' = 'Current Patient Count');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `data_collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `primary_indication` SET TAGS ('dbx_business_glossary_term' = 'Primary Indication');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `protocol_amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Number');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `target_patient_count` SET TAGS ('dbx_business_glossary_term' = 'Target Patient Count');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `treatment_line` SET TAGS ('dbx_business_glossary_term' = 'Treatment Line');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `treatment_line` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ALTER COLUMN `treatment_line` SET TAGS ('dbx_pii' = 'true');
