-- Schema for Domain: research | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`research` COMMENT 'Clinical research and medical research operations. Owns clinical trial protocols, IRB (Institutional Review Board) approvals, study enrollment, investigational drug/device tracking, informed consent, adverse event reporting, research billing compliance, research data governance, de-identified data access for population health studies, and translational research. Supports academic medical centers under FDA 21 CFR Part 11.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`research_study` (
    `research_study_id` BIGINT COMMENT 'System-generated unique identifier for the research study record.',
    `protocol_amendment_id` BIGINT COMMENT 'FK to research.protocol_amendment',
    `parent_study_research_study_id` BIGINT COMMENT 'description',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician',
    `study_sponsor_id` BIGINT COMMENT 'Foreign key linking to research.study_sponsor. Business justification: A research study has a primary sponsor. The sponsor STRING field is redundant with study_sponsor.sponsor_name. Proper FK enables sponsor-level study portfolio management.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to the study.',
    `coordinating_center` STRING COMMENT 'Organization managing multi-site coordination and data collection.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal data‑sharing agreement is in place for the study.',
    `de_identified_data_access_flag` BOOLEAN COMMENT 'Specifies if de‑identified data from the study may be accessed for secondary research.',
    `delta_tblproperties` STRING COMMENT 'JSON string of Delta Lake TBLPROPERTIES for governance (e.g., delta.deletedFileRetentionDuration, delta.logRetentionDuration). Used for HIPAA-compliant table lifecycle management.',
    `end_date` DATE COMMENT 'Projected or actual date when the study concludes.',
    `exclusion_criteria_summary` STRING COMMENT 'Brief summary of conditions that disqualify potential participants.',
    `fda_21cfr11_compliant` BOOLEAN COMMENT 'Indicates whether the study complies with FDA electronic records regulations.',
    `funding_source` STRING COMMENT 'Entity or mechanism providing financial resources for the study.',
    `hipaa_retention_days` STRING COMMENT 'Number of days this record must be retained per HIPAA/state retention requirements. Used by Unity Catalog lifecycle policies for automated purge scheduling.',
    `inclusion_criteria_summary` STRING COMMENT 'Brief summary of eligibility criteria required for participant enrollment.',
    `ind_ide_number` STRING COMMENT 'Investigational New Drug or Investigational Device Exemption identifier assigned by FDA.',
    `irb_protocol_number` STRING COMMENT 'Institutional Review Board assigned protocol identifier.',
    `is_multi_site` BOOLEAN COMMENT 'Indicates whether the study is conducted at multiple locations.',
    `nct_number` STRING COMMENT 'Unique identifier from ClinicalTrials.gov for the study.',
    `phase` STRING COMMENT 'Clinical trial phase indicating the stage of development (I, II, III, IV).. Valid values are `I|II|III|IV`',
    `primary_outcome_measure` STRING COMMENT 'Key endpoint used to assess the main objective of the study.',
    `randomization_ratio` STRING COMMENT 'Ratio defining participant allocation across arms (e.g., "1:1").',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the study record.',
    `regulatory_submission_reference` STRING COMMENT 'Identifier for the primary regulatory submission package (e.g., IND filing).',
    `research_study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `active|completed|suspended|terminated|pending`',
    `scd_type` STRING COMMENT 'SCD strategy indicator: 1=overwrite, 2=versioned history rows, 3=add new attribute column. Drives Delta Lake MERGE behavior for slowly changing dimension processing.',
    `secondary_outcome_measure` STRING COMMENT 'Additional endpoints evaluated in the study.',
    `start_date` DATE COMMENT 'Date when participant enrollment or study activities commence.',
    `study_description` STRING COMMENT 'Narrative overview of the study objectives, design, and rationale.',
    `study_type` STRING COMMENT 'Classification of the study as interventional, observational, or expanded access.. Valid values are `interventional|observational|expanded_access`',
    `study_version` STRING COMMENT 'Version label for the protocol (e.g., "v1.2").',
    `target_enrollment` STRING COMMENT 'Planned number of participants to be enrolled in the study.',
    `therapeutic_area` STRING COMMENT 'Medical specialty or disease area the study targets.',
    `title` STRING COMMENT 'Official title of the clinical or medical research study.',
    `version_effective_date` DATE COMMENT 'Date when the current protocol version became effective.',
    `version_expiration_date` DATE COMMENT 'Date when the current protocol version expires or is superseded.',
    `sponsor` STRING COMMENT 'Organization or entity providing financial or material support for the study.',
    `nct_id` STRING COMMENT 'Unique identifier from ClinicalTrials.gov for the study.',
    `status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `active|completed|suspended|terminated|pending`',
    `principal_investigator` STRING COMMENT 'Name of the lead researcher responsible for the study.',
    `amendment_number` STRING COMMENT 'Sequential identifier for a protocol amendment.',
    `amendment_date` DATE COMMENT 'Date the amendment was formally approved.',
    `amendment_description` STRING COMMENT 'Narrative description of changes introduced by the amendment.',
    `amendment_reason` STRING COMMENT 'Business or scientific rationale for the protocol change.',
    `amendment_impact_assessment` STRING COMMENT 'Evaluation of how the amendment affects safety, efficacy, or enrollment.',
    `amendment_irb_fda_submission_ref` STRING COMMENT 'Reference identifier for IRB/FDA submission linked to the amendment.',
    `amendment_implementation_date` DATE COMMENT 'Date the amendment changes were put into practice at study sites.',
    `arm_name` STRING COMMENT 'Descriptive name of a specific treatment or observation group.',
    `arm_type` STRING COMMENT 'Category of the treatment arm.. Valid values are `experimental|active_comparator|placebo|sham|observational`',
    `arm_planned_enrollment` STRING COMMENT 'Target number of participants for this arm.',
    `dose_description` STRING COMMENT 'Details of the dosage or intervention administered in the arm.',
    `arm_status` STRING COMMENT 'Current operational status of the treatment arm.. Valid values are `open|closed|suspended`',
    CONSTRAINT pk_research_study PRIMARY KEY(`research_study_id`)
) COMMENT 'Master record for every clinical or medical research study conducted at the institution. Captures study title, sponsor, phase (I–IV), study type (interventional, observational, expanded access), therapeutic area, IND/IDE number, NCT identifier, FDA 21 CFR Part 11 compliance flag, study status, IRB protocol number, PI, coordinating center, target enrollment, start/end dates, and regulatory submission references. Protocol amendments: tracked with amendment number, date, description of changes, reason, impact assessment (safety, efficacy, enrollment), IRB/FDA submission references, sponsor approval date, and implementation date per site — maintains full protocol version history for regulatory inspections. Treatment arms: arm name, type (experimental, active comparator, placebo, sham, observational), planned enrollment per arm, randomization ratio, dose/intervention description, arm status (open, closed, suspended), supporting randomization management and stratified enrollment. SSOT for research study identity, protocol version history, protocol amendments, and study design structure (including treatment arms) across the research domain.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`irb_submission` (
    `irb_submission_id` BIGINT COMMENT 'System-generated unique identifier for the IRB submission record.',
    `institutional_review_board_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'description',
    `irb_study_research_study_id` BIGINT COMMENT 'Identifier of the clinical research study associated with this submission.',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician.clinician_id',
    `action_required` STRING COMMENT 'Required actions for the sponsor/investigator after review.',
    `agency_name` STRING COMMENT 'Name of the regulatory agency (e.g., IRB, FDA, OHRP).',
    `agency_response` STRING COMMENT 'Narrative response or comments from the reviewing agency.',
    `amendment_date` DATE COMMENT 'Date the amendment was submitted.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment, if applicable.',
    `approval_date` DATE COMMENT 'Date the submission was approved by the reviewing body.',
    `compliance_regulations` STRING COMMENT 'Regulatory frameworks applicable to the submission.. Valid values are `21CFR56|21CFR312|45CFR46|HIPAA|GDPR|None`',
    `conditions` STRING COMMENT 'Specific conditions or stipulations attached to the approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the funding amount.',
    `data_retention_period_months` STRING COMMENT 'Number of months data must be retained after study completion.',
    `data_sharing_plan` STRING COMMENT 'Description of how study data will be shared or made public.',
    `document_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `expiration_date` DATE COMMENT 'Date the approval expires or must be renewed.',
    `funding_source` STRING COMMENT 'Primary source of financial support for the study.. Valid values are `federal|industry|institution|other`',
    `has_vulnerable_population` BOOLEAN COMMENT 'Indicates inclusion of vulnerable populations (e.g., children, prisoners).',
    `hipaa_retention_days` STRING COMMENT 'description',
    `is_amendment` BOOLEAN COMMENT 'True if this record represents an amendment to a prior submission.',
    `is_continuing_review` BOOLEAN COMMENT 'Indicates whether a continuing review is required.',
    `is_device_study` BOOLEAN COMMENT 'Indicates if the study involves investigational devices.',
    `is_human_subjects` BOOLEAN COMMENT 'Indicates if the study involves human subjects.',
    `is_multi_site` BOOLEAN COMMENT 'Indicates whether the study involves multiple research sites.',
    `is_reportable_event` BOOLEAN COMMENT 'True if the submission includes a reportable adverse event.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review event.',
    `notes` STRING COMMENT 'Free-text field for additional comments or internal notes.',
    `outcome` STRING COMMENT 'Final determination of the reviewing body.. Valid values are `approved|conditional|rejected|withdrawn`',
    `principal_investigator_email` STRING COMMENT 'Primary email address of the principal investigator.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `principal_investigator_name` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `principal_investigator_phone` STRING COMMENT 'Contact phone number for the principal investigator.',
    `protocol_title` STRING COMMENT 'Title of the research protocol submitted for review.',
    `review_body` STRING COMMENT 'Name of the IRB board or agency reviewing the submission.',
    `review_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `review_type` STRING COMMENT 'Type of review being performed (e.g., initial, amendment).. Valid values are `initial|amendment|continuing|reportable_event|closure`',
    `risk_level` STRING COMMENT 'Overall risk assessment assigned by the reviewing body.. Valid values are `low|moderate|high|critical`',
    `sponsor_contact_email` STRING COMMENT 'Email address for the sponsors primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_name` STRING COMMENT 'Name of the organization sponsoring the research.',
    `study_phase` STRING COMMENT 'Phase of the clinical trial or observational status.. Valid values are `phase_i|phase_ii|phase_iii|phase_iv|observational`',
    `submission_date` DATE COMMENT 'Date the submission was initially filed with the reviewing body.',
    `submission_method` STRING COMMENT 'Method used to submit the documentation.. Valid values are `electronic|paper`',
    `submission_number` STRING COMMENT 'External reference number assigned to the submission by the IRB or sponsor.',
    `submission_type` STRING COMMENT 'Category of the submission (e.g., Institutional Review Board, FDA IND/IDE, OHRP, or other).. Valid values are `irb|fda|ohrp|other`',
    `total_funding_amount` DECIMAL(18,2) COMMENT 'Total monetary amount of funding allocated to the study.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical research study associated with this submission.',
    CONSTRAINT pk_irb_submission PRIMARY KEY(`irb_submission_id`)
) COMMENT 'Tracks all regulatory submissions associated with a research study, including IRB submissions (initial review, amendments, continuing reviews, reportable events, closures) and federal agency submissions (FDA IND/IDE applications, IND amendments, annual reports, safety reports, NDA/BLA submissions, OHRP assurance filings). Captures submission type, submission date, reviewing body (IRB board name/FWA number or federal agency), review type, determination outcome, approval/acknowledgment dates, conditions, submission number, submission method (eCTD, paper), agency response, and action required. Supports FDA 21 CFR Parts 56/312/812, 45 CFR Part 46 (Common Rule), and OHRP regulatory lifecycle management. SSOT for all research regulatory submissions (both IRB and federal agency) within the research domain.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_site` (
    `study_site_id` BIGINT COMMENT 'Unique surrogate key for each study site.',
    `care_site_id` BIGINT COMMENT 'Reference to the physical facility where the site is located.',
    `clinician_id` BIGINT COMMENT 'Identifier of the lead investigator responsible for the site.',
    `institutional_review_board_id` BIGINT COMMENT 'FK to research.institutional_review_board',
    `post_acute_location_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_location. Business justification: SNFs, home health agencies, and hospices serve as research study sites for PAC-focused trials (e.g., CMS BPCI, rehab interventions). Site activation, enrollment capacity, and regulatory binder trackin',
    `research_study_id` BIGINT COMMENT 'description',
    `activation_date` DATE COMMENT 'Date the site became active for the trial.',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `city` STRING COMMENT 'City where the site is located.',
    `closure_date` DATE COMMENT 'Date the site was closed or de‑activated for the trial.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing the corrective action plan.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating if a corrective action plan is required from the site.',
    `corrective_action_resolved` BOOLEAN COMMENT 'Indicates whether the corrective action has been resolved.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the site location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study site record was first created.',
    `current_enrollment` STRING COMMENT 'Number of participants currently enrolled at the site.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of participants the site can enroll.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last audit or compliance review for the site.',
    `last_monitoring_visit_date` DATE COMMENT 'Date of the most recent sponsor monitoring visit.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the site.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the site.',
    `monitoring_visit_status` STRING COMMENT 'Current status of the monitoring visit schedule.. Valid values are `completed|scheduled|overdue|canceled`',
    `next_monitoring_visit_date` DATE COMMENT 'Scheduled date for the upcoming monitoring visit.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the site.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the site address.',
    `protocol_deviation_count` STRING COMMENT 'Total number of protocol deviations reported for the site.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Indicates whether any protocol deviations have been recorded at the site.',
    `regulatory_binder_status` STRING COMMENT 'Status of the site’s regulatory binder compliance.. Valid values are `complete|incomplete|pending`',
    `site_contact_email` STRING COMMENT 'Email address of the site’s primary contact.',
    `site_contact_name` STRING COMMENT 'Name of the primary contact person for the site.',
    `site_contact_phone` STRING COMMENT 'Phone number of the site’s primary contact.',
    `site_contact_role` STRING COMMENT 'Business role of the site contact (e.g., Study Coordinator).',
    `site_name` STRING COMMENT 'Human‑readable name of the clinical trial site.',
    `site_number` STRING COMMENT 'Internal alphanumeric identifier assigned to the site by the sponsor.',
    `site_performance_score` DECIMAL(18,2) COMMENT 'Composite score reflecting site performance against sponsor metrics.',
    `site_region` STRING COMMENT 'Geographic region or health system area where the site resides.',
    `site_status` STRING COMMENT 'Current lifecycle status of the site.. Valid values are `active|inactive|closed|pending`',
    `site_type` STRING COMMENT 'Classification of the site based on its operational model.. Valid values are `hospital|clinic|virtual|research_center`',
    `state` STRING COMMENT 'State or province of the site location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the study site record.',
    `facility_id` BIGINT COMMENT 'Reference to the physical facility where the site is located.',
    `principal_investigator_id` BIGINT COMMENT 'Identifier of the lead investigator responsible for the site.',
    `irb_name` STRING COMMENT 'Name of the Institutional Review Board overseeing the site.',
    `irb_number` STRING COMMENT 'Unique identifier assigned by the IRB.',
    CONSTRAINT pk_study_site PRIMARY KEY(`study_site_id`)
) COMMENT 'Represents a physical or virtual site participating in a multi-site clinical trial, including site management and monitoring visit tracking. Site level: site name, number, facility identifier, PI at site, activation/closure dates, enrollment capacity, IRB of record, regulatory binder status, and performance metrics (screen failures, enrollment rate). Monitoring visits: visit type (initiation, routine, close-out, for-cause), visit date, monitor name/organization (sponsor, CRO, internal), findings summary, protocol deviations identified, data discrepancies noted, corrective action plan (CAP) required flag, CAP due date, CAP resolution, and visit report completion date. Supports multi-site trial management, site performance oversight, sponsor monitoring obligations, and ICH E6(R2) GCP monitoring requirements. SSOT for study site management and monitoring visit tracking within the research domain.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` (
    `subject_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the subject enrollment record.',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: Addiction/SUD clinical trials must track which substance use episode qualifies the subject for enrollment. Required for outcome measurement, protocol eligibility verification, and FDA efficacy reporti',
    `clinical_order_id` BIGINT COMMENT 'foreign_key_to',
    `genomics_genomic_consent_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_consent. Business justification: Regulatory requirement (21 CFR Part 50): genomics trials require specific genomic data consent before enrollment. Research coordinators must verify genomic consent status as an enrollment gate for gen',
    `genomics_genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: Protocol-mandated genomic testing: when subjects enroll in biomarker-driven trials, a genomic order is placed per protocol. Coordinators must track which enrollment triggered which genomic order for p',
    `mpi_record_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'Unique identifier assigned to the subject for this specific study, distinct from the patient MRN.',
    `protocol_id` BIGINT COMMENT 'Identifier of the research protocol governing the study.',
    `rpm_enrollment_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_enrollment. Business justification: In decentralized trials, each research subjects RPM enrollment must be linked to their study enrollment for protocol compliance monitoring, data completeness tracking, and per-subject remote data col',
    `study_site_id` BIGINT COMMENT 'Identifier of the clinical site where enrollment occurred.',
    `study_sponsor_id` BIGINT COMMENT 'Identifier of the organization sponsoring the clinical trial.',
    `subject_research_study_id` BIGINT COMMENT 'Identifier of the clinical study to which the subject is enrolled.',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician.clinician_id',
    `completion_date` DATE COMMENT 'Date the subject completed all study activities.',
    `consent_date` DATE COMMENT 'Date the informed consent was signed.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the subject provided informed consent.',
    `consent_version` STRING COMMENT 'Version identifier of the consent form used.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created.',
    `eligibility_status` STRING COMMENT 'Result of the eligibility assessment after screening.. Valid values are `eligible|ineligible|pending`',
    `enrollment_date` DATE COMMENT 'Date the subject formally enrolled in the study.',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the subject within the study.. Valid values are `screened|enrolled|active|completed|withdrawn|lost_to_follow_up`',
    `enrollment_status_reason` STRING COMMENT 'Free-text explanation for the current enrollment status, if applicable.',
    `enrollment_type` STRING COMMENT 'Indicates whether the enrollment is prospective or retrospective.. Valid values are `prospective|retrospective`',
    `hipaa_retention_days` STRING COMMENT 'description',
    `notes` STRING COMMENT 'Additional comments or observations about the enrollment.',
    `patient_mrn` STRING COMMENT 'Master patient identifier linking the enrollment to the patient master data.',
    `randomization_arm` STRING COMMENT 'Cohort or treatment group assigned to the subject.. Valid values are `control|treatment_a|treatment_b`',
    `randomization_date` DATE COMMENT 'Date the subject was assigned to a randomization arm.',
    `randomization_method` STRING COMMENT 'Algorithm used to assign the subject to an arm.. Valid values are `simple|block|stratified|adaptive`',
    `screening_date` DATE COMMENT 'Date the subject completed initial eligibility screening.',
    `stratification_factors` STRING COMMENT 'Delimited list of stratification factor values used during randomization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the enrollment record.',
    `withdrawal_date` DATE COMMENT 'Date the subject withdrew from the study, if applicable.',
    `withdrawal_reason` STRING COMMENT 'Reason provided for subject withdrawal.',
    `subject_study_id` STRING COMMENT 'Unique identifier assigned to the subject for this specific study, distinct from the patient MRN.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical study to which the subject is enrolled.',
    `site_id` BIGINT COMMENT 'Identifier of the clinical site where enrollment occurred.',
    `sponsor_id` BIGINT COMMENT 'Identifier of the organization sponsoring the clinical trial.',
    CONSTRAINT pk_subject_enrollment PRIMARY KEY(`subject_enrollment_id`)
) COMMENT 'Operational record of a research subjects enrollment into a specific study, capturing the full enrollment lifecycle. Includes subject study ID (distinct from MRN), screening date, enrollment date, randomization date, randomization arm/cohort assignment, stratification factors, enrollment status (screened, enrolled, active, completed, withdrawn, lost to follow-up), withdrawal reason, and completion date. Links to the patient domain via MRN without duplicating patient master data. Core transactional entity for study enrollment tracking.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`informed_consent` (
    `informed_consent_id` BIGINT COMMENT 'System-generated unique identifier for the informed consent record.',
    `consent_template_id` BIGINT COMMENT 'Identifier of the specific version of the consent form template used.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who obtained the consent.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the research subject (patient) who provided the consent.',
    `primary_employee_id` BIGINT COMMENT 'Identifier of the witness who observed the consent signing.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical research study to which the consent applies.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Informed consent is obtained for a specific subject enrollment into a study. Links consent to the enrollment record for complete audit trail.',
    `capacity_assessment` STRING COMMENT 'Assessment of the participants capacity to consent (e.g., competent, incompetent, questionable).',
    `consent_date` DATE COMMENT 'Date the consent was signed by the participant.',
    `consent_effective_date` DATE COMMENT 'Date when the consent became legally effective.',
    `consent_expiration_date` DATE COMMENT 'Date when the consent expires or is no longer valid (nullable).',
    `consent_form_title` STRING COMMENT 'Descriptive title of the consent form used.',
    `consent_form_version_number` STRING COMMENT 'Version number or identifier of the consent form template.',
    `consent_location` STRING COMMENT 'Physical or virtual location where the consent was obtained.',
    `consent_number` STRING COMMENT 'External business identifier assigned to the consent document for tracking and reference.',
    `consent_source` STRING COMMENT 'How the consent was obtained (e.g., in‑person, remote, mailed).. Valid values are `in_person|remote|mail`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record.. Valid values are `active|withdrawn|expired|pending`',
    `consent_type` STRING COMMENT 'Classification of the consent (initial, re‑consent, assent, or legally authorized representative consent).. Valid values are `initial|reconsent|assent|lar_consent`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `electronic_signature` BOOLEAN COMMENT 'True if the consent was captured using an electronic signature method.',
    `irb_approval_date` DATE COMMENT 'Date the IRB approved the consent form version.',
    `irb_expiration_date` DATE COMMENT 'Date the IRB approval of the consent form version expires.',
    `language_code` STRING COMMENT 'Two‑letter code indicating the language of the consent form.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations about the consent.',
    `reconsent_date` DATE COMMENT 'Date of a subsequent consent when the participant re‑consents.',
    `required_elements_checklist` STRING COMMENT 'JSON‑encoded checklist confirming inclusion of all regulatory required elements.',
    `signature_date` DATE COMMENT 'Date the signature was captured (may match consent_date).',
    `signature_indicator` BOOLEAN COMMENT 'True if a valid signature (electronic or handwritten) is present.',
    `signature_method` STRING COMMENT 'Method used to capture the signature.. Valid values are `pen|electronic|thumbprint`',
    `template_status` STRING COMMENT 'Lifecycle status of the consent form template.. Valid values are `draft|approved|superseded`',
    `updated_by` BIGINT COMMENT 'Staff member who performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `withdrawal_date` DATE COMMENT 'Date the participant withdrew consent, if applicable.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the participant for withdrawing consent.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the research subject (patient) who provided the consent.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical research study to which the consent applies.',
    `consent_form_version_id` BIGINT COMMENT 'Identifier of the specific version of the consent form template used.',
    `staff_id` BIGINT COMMENT 'Identifier of the staff member who obtained the consent.',
    `witness_id` BIGINT COMMENT 'Identifier of the witness who observed the consent signing.',
    `created_by` BIGINT COMMENT 'Staff member who initially entered the consent record.',
    CONSTRAINT pk_informed_consent PRIMARY KEY(`informed_consent_id`)
) COMMENT 'Records the informed consent process for each research subject and manages IRB-approved consent form templates/versions. Subject-level consent: captures consent form version, consent date, re-consent date, consent type (initial, re-consent, assent, LAR consent), consenting staff, witness, signature indicator, capacity assessment, and language. Template/version management: captures template version number, IRB approval date, expiration date, language versions, form type (full ICF, short form, assent, HIPAA authorization), required elements checklist, and template status (draft, approved, superseded). Supports FDA 21 CFR Part 50, ICH E6(R2), and ensures subjects are consented on the current IRB-approved version. SSOT for consent documentation, template version control, and consent compliance within the research domain.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`protocol_amendment` (
    `protocol_amendment_id` BIGINT COMMENT 'Unique system-generated identifier for each protocol amendment record.',
    `affected_site_count` STRING COMMENT 'Number of study sites impacted by the amendment.',
    `amendment_approver_email` STRING COMMENT 'Email address of the amendment approver.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `amendment_approver_name` STRING COMMENT 'Full legal name of the individual who approved the amendment.',
    `amendment_author_email` STRING COMMENT 'Email address of the amendment author.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `amendment_author_name` STRING COMMENT 'Full legal name of the individual who authored the amendment.',
    `amendment_date` TIMESTAMP COMMENT 'Date and time when the amendment was formally recorded.',
    `amendment_number` STRING COMMENT 'Sequential number assigned to the amendment within the study protocol (e.g., 1 for first amendment).',
    `amendment_review_comments` STRING COMMENT 'Free‑text comments from the review board or sponsor regarding the amendment.',
    `amendment_type` STRING COMMENT 'Category of change introduced by the amendment.. Valid values are `protocol|eligibility|dosage|safety|administrative`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the amendment complies with all applicable regulations (true) or has outstanding compliance issues (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system.',
    `delta_table_properties` STRING COMMENT 'JSON string of Delta Lake table properties for governance (e.g., autoOptimize, optimizeWrite).',
    `description_of_changes` STRING COMMENT 'Narrative detailing the modifications made to the protocol.',
    `document_hash` STRING COMMENT 'SHA‑256 hash of the amendment document for integrity verification.',
    `document_url` STRING COMMENT 'Secure link to the stored amendment document.',
    `fda_submission_reference` STRING COMMENT 'Identifier of the FDA submission (e.g., IND amendment) associated with this amendment.',
    `impact_assessment_efficacy` STRING COMMENT 'Qualitative assessment of how the amendment influences expected efficacy outcomes.. Valid values are `none|low|moderate|high`',
    `impact_assessment_enrollment` STRING COMMENT 'Qualitative assessment of how the amendment will affect subject enrollment rates.. Valid values are `none|low|moderate|high`',
    `impact_assessment_safety` STRING COMMENT 'Qualitative assessment of how the amendment affects participant safety.. Valid values are `none|low|moderate|high`',
    `implementation_date` TIMESTAMP COMMENT 'Date the amendment was put into effect at each study site.',
    `irb_submission_reference` STRING COMMENT 'Identifier of the Institutional Review Board submission linked to this amendment.',
    `protocol_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending|approved|rejected|active|retired`',
    `reason_for_amendment` STRING COMMENT 'Business or scientific justification for the amendment.',
    `regulatory_review_date` TIMESTAMP COMMENT 'Date when the regulatory review was completed or last updated.',
    `regulatory_review_status` STRING COMMENT 'Current status of the regulatory review process for the amendment.. Valid values are `not_started|in_review|completed|requires_revision`',
    `retention_period_days` STRING COMMENT 'Number of days the amendment record must be retained to satisfy HIPAA and FDA 21 CFR Part 11 requirements.',
    `sponsor_approval_date` TIMESTAMP COMMENT 'Date when the study sponsor formally approved the amendment.',
    `total_sites_impacted` STRING COMMENT 'Total count of sites where the amendment required operational changes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    `version_number` STRING COMMENT 'Human‑readable version label for the amendment (e.g., v2.1).',
    `status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending|approved|rejected|active|retired`',
    CONSTRAINT pk_protocol_amendment PRIMARY KEY(`protocol_amendment_id`)
) COMMENT 'Tracks all amendments to an approved research protocol, including the amendment number, amendment date, description of changes, reason for amendment, impact assessment (safety, efficacy, enrollment), IRB submission reference, FDA submission reference (IND amendment), sponsor approval date, and implementation date at each site. Maintains the full version history of the study protocol to support regulatory inspections and audit readiness under FDA 21 CFR Part 11.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_visit` (
    `study_visit_id` BIGINT COMMENT 'System-generated unique identifier for each study visit record.',
    `employee_id` BIGINT COMMENT 'Identifier of the research staff member coordinating the visit.',
    `genomics_genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: Protocol visit schedule drives genomic sample collection: study visits trigger genomic orders per protocol timepoints. Site coordinators track which visit generated which genomic order for protocol de',
    `study_site_id` BIGINT COMMENT 'Foreign key linking to research.study_site. Business justification: Study visits occur at specific study sites. The location STRING field is redundant with study_site.site_name and address fields. Proper FK enables site-level visit tracking.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier of the enrolled research participant.',
    `actual_visit_timestamp` TIMESTAMP COMMENT 'Exact date and time the subject completed the visit.',
    `adverse_event_description` STRING COMMENT 'Narrative description of any adverse event captured for the visit.',
    `adverse_event_reported` BOOLEAN COMMENT 'True if an adverse event was reported during or after the visit.',
    `compliance_flag` BOOLEAN COMMENT 'True when the visit met all required protocol compliance criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study visit record was first created in the system.',
    `data_collection_status` STRING COMMENT 'State of data capture for the visit (e.g., pending, in progress, completed).. Valid values are `pending|in_progress|completed`',
    `data_locked` BOOLEAN COMMENT 'True when the visit data has been locked for regulatory compliance (e.g., 21 CFR Part 11).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the study visit record.',
    `visit_duration_minutes` STRING COMMENT 'Total time spent on the visit, measured in minutes.',
    `visit_name` STRING COMMENT 'Descriptive name of the visit as defined in the protocol (e.g., Baseline, Week 4).',
    `visit_notes` STRING COMMENT 'Free‑text field for additional observations or comments captured during the visit.',
    `visit_number` STRING COMMENT 'Ordinal number of the visit within the study protocol schedule.',
    `visit_reason` STRING COMMENT 'Business or clinical reason for the visit (e.g., safety assessment, dose administration).',
    `visit_status` STRING COMMENT 'Current lifecycle state of the visit record.. Valid values are `scheduled|completed|missed|cancelled`',
    `visit_type` STRING COMMENT 'Categorizes the purpose of the visit per protocol (e.g., screening, treatment).. Valid values are `screening|baseline|treatment|follow_up|end_of_study|unscheduled`',
    `visit_window_early_allowed` BOOLEAN COMMENT 'Indicates if the protocol permits the visit to occur earlier than the planned window.',
    `visit_window_end` DATE COMMENT 'Planned latest date the visit may occur according to the protocol window.',
    `visit_window_late_allowed` BOOLEAN COMMENT 'Indicates if the protocol permits the visit to occur later than the planned window.',
    `visit_window_start` DATE COMMENT 'Planned earliest date the visit may occur according to the protocol window.',
    `visit_window_type` STRING COMMENT 'Indicates whether the actual visit falls within the planned window, early, or late relative to the schedule.. Valid values are `planned|early|late`',
    `location` STRING COMMENT 'Physical site or virtual platform where the visit was conducted.',
    `coordinator_id` BIGINT COMMENT 'Identifier of the research staff member coordinating the visit.',
    `protocol_id` BIGINT COMMENT 'Reference to the clinical trial protocol governing this visit.',
    `subject_id` BIGINT COMMENT 'Unique identifier of the enrolled research participant.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the visit record.',
    CONSTRAINT pk_study_visit PRIMARY KEY(`study_visit_id`)
) COMMENT 'Represents a scheduled or unscheduled study visit for an enrolled research subject, as defined by the protocol schedule of assessments. Captures visit name, visit number, visit window (planned, early, late), actual visit date, visit type (screening, baseline, treatment, follow-up, end of study, unscheduled), visit status (scheduled, completed, missed, cancelled), visit location, and coordinator assigned. Drives protocol compliance tracking and subject retention management.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`adverse_event` (
    `adverse_event_id` BIGINT COMMENT 'Unique surrogate key for each adverse or quality event record.',
    `clinical_order_id` BIGINT COMMENT 'foreign_key_to',
    `health_alert_id` BIGINT COMMENT 'Foreign key linking to digital_health.health_alert. Business justification: Health alerts from RPM devices trigger adverse event reporting in clinical trials. Linking AE to the originating alert provides audit trail for safety signal detection and expedited reporting per ICH ',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the study subject/patient who experienced the event.',
    `research_study_id` BIGINT COMMENT 'Unique identifier of the clinical trial or research study.',
    `rpm_reading_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_reading. Business justification: Pharmacovigilance in digital trials requires linking adverse events to the triggering RPM reading (e.g., abnormal BP reading). FDA 21 CFR 312.32 mandates source documentation for AE detection in IND s',
    `study_site_id` BIGINT COMMENT 'Foreign key linking to research.study_site. Business justification: Adverse events occur at specific study sites. Site-level safety reporting is critical for DSMB reviews and regulatory submissions.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Adverse events occur for specific enrolled research subjects. Linking to subject_enrollment provides the full enrollment context (site, arm, dates) beyond just patient and study.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id',
    `action_taken` STRING COMMENT 'Clinical or operational action performed in response to the event.',
    `additional_notes` STRING COMMENT 'Free‑text field for any supplemental information not captured elsewhere.',
    `adverse_event_status` STRING COMMENT 'Current lifecycle status of the event record.. Valid values are `open|closed|under_review|resolved`',
    `ae_term` STRING COMMENT 'Standardized MedDRA term describing the medical condition or symptom.',
    `ae_term_code` STRING COMMENT 'MedDRA preferred term code associated with the adverse event.',
    `capa_status` STRING COMMENT 'Current status of the corrective and preventive action (CAPA) plan.. Valid values are `open|closed|in_progress`',
    `causality_assessment` STRING COMMENT 'Investigator’s assessment of the relationship between the event and the investigational product.. Valid values are `related|not_related|unknown`',
    `corrective_action` STRING COMMENT 'Planned or executed corrective action to address the root cause.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'Originating system that supplied the event record (e.g., Epic, Medidata, REDCap).',
    `deviation_category` STRING COMMENT 'Category of the protocol deviation or quality event.. Valid values are `eligibility|dosing|visit_window|consent|data_collection`',
    `deviation_severity` STRING COMMENT 'Severity level assigned to the protocol deviation.. Valid values are `minor|major|important`',
    `discovery_date` DATE COMMENT 'Date the deviation or adverse event was discovered during monitoring.',
    `event_number` STRING COMMENT 'Human‑readable identifier assigned by the sponsor or study system (e.g., AE‑2023‑0001).',
    `event_reported_timestamp` TIMESTAMP COMMENT 'Date‑time when the adverse or quality event was initially reported.',
    `event_type` STRING COMMENT 'Classifies the record as an adverse event (AE) or a protocol deviation/quality event.. Valid values are `adverse_event|protocol_deviation`',
    `expedited_report_flag` BOOLEAN COMMENT 'Indicates if the event required expedited regulatory reporting (e.g., MedWatch).',
    `hipaa_retention_days` STRING COMMENT 'description',
    `investigator_contact` STRING COMMENT 'Email address of the investigator for follow‑up communication.',
    `investigator_name` STRING COMMENT 'Name of the principal investigator who reviewed or reported the event.',
    `irb_reportable` BOOLEAN COMMENT 'Indicates whether the event must be reported to the Institutional Review Board.',
    `onset_date` DATE COMMENT 'Date when the adverse event or deviation first manifested.',
    `outcome` STRING COMMENT 'Final outcome for the subject after the event.. Valid values are `recovered|recovering|not_recovered|fatal|unknown`',
    `reporting_date` DATE COMMENT 'Date the event was formally reported to regulatory authorities or sponsor.',
    `resolution_date` DATE COMMENT 'Date when the event was resolved or the deviation corrected.',
    `root_cause` STRING COMMENT 'Narrative description of the root cause identified for the event.',
    `seriousness_criteria` STRING COMMENT 'Regulatory seriousness criteria met by the event.. Valid values are `death|life_threatening|hospitalization|disability|congenital_anomaly|other`',
    `severity_grade` STRING COMMENT 'Clinical severity grade (1‑5) per CTCAE criteria.',
    `sponsor_reportable` BOOLEAN COMMENT 'Indicates whether the event must be reported to the study sponsor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `status` STRING COMMENT 'Current lifecycle status of the event record.. Valid values are `open|closed|under_review|resolved`',
    `patient_id` BIGINT COMMENT 'Unique identifier of the study subject/patient who experienced the event.',
    `study_id` BIGINT COMMENT 'Unique identifier of the clinical trial or research study.',
    CONSTRAINT pk_adverse_event PRIMARY KEY(`adverse_event_id`)
) COMMENT 'Captures all safety events and quality events reported during a clinical trial or research study. Safety events: adverse events (AEs) and serious adverse events (SAEs) with AE term (MedDRA coded), onset/resolution dates, severity grade (CTCAE 1–5), seriousness criteria, causality assessment, action taken, outcome, and expedited reporting flag. Quality events: protocol deviations and violations with deviation description, category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), discovery date, root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports FDA MedWatch, IND safety reporting (21 CFR 312.32), GCP compliance, quality management under ICH E6(R2), and regulatory inspection readiness. SSOT for all study safety events and quality events (including protocol deviations) within the research domain.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`investigational_product` (
    `investigational_product_id` BIGINT COMMENT 'System-generated unique identifier for the investigational product record.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial to which this investigational product is assigned.',
    `adverse_event_reporting_required` BOOLEAN COMMENT 'Indicates whether adverse event reporting is mandatory for this product.',
    `blinding_status` STRING COMMENT 'Indicates the blinding methodology applied to the trial product.. Valid values are `open-label|single-blind|double-blind`',
    `comparator_indicator` BOOLEAN COMMENT 'True if the product serves as a comparator or placebo in the study.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigational product record was first created.',
    `data_sharing_restriction` STRING COMMENT 'Level of restriction on sharing product data outside the trial.. Valid values are `restricted|unrestricted|de-identified`',
    `device_identifier` STRING COMMENT 'Unique identifier for a medical device (e.g., UDI).',
    `dosage_form` STRING COMMENT 'Physical form in which the product is administered (e.g., tablet, injection).. Valid values are `tablet|injection|infusion|implant|cream|gel`',
    `enrollment_current` STRING COMMENT 'Actual number of participants currently enrolled.',
    `enrollment_target` STRING COMMENT 'Planned number of participants to be enrolled for the products trial.',
    `expiration_date` DATE COMMENT 'Date after which the product must not be used.',
    `formulation` STRING COMMENT 'Detailed description of the product formulation (e.g., immediate‑release, extended‑release).',
    `ide_number` STRING COMMENT 'Unique IDE number assigned by the FDA for device investigations.',
    `ind_number` STRING COMMENT 'Unique IND number assigned by the FDA for drug investigations.',
    `investigational_product_description` STRING COMMENT 'Free‑text description providing additional details about the investigational product.',
    `investigational_product_name` STRING COMMENT 'Human‑readable name of the investigational drug, biologic, or device.',
    `investigational_product_status` STRING COMMENT 'Current lifecycle state of the investigational product within the trial.. Valid values are `pending|active|suspended|completed|withdrawn`',
    `lot_number_tracking_flag` BOOLEAN COMMENT 'Indicates whether individual lot numbers are tracked for the product.',
    `manufacturer` STRING COMMENT 'Legal name of the organization that manufactures the investigational product.',
    `ndc_code` STRING COMMENT 'Standardized identifier for drug products assigned by the FDA.',
    `product_code` STRING COMMENT 'Internal or regulatory code uniquely identifying the product (e.g., IND/IDE number, internal catalog code).',
    `product_type` STRING COMMENT 'Classification of the investigational product as a drug, device, or biologic.. Valid values are `drug|device|biologic`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority granted approval.',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory status of the product (e.g., IND, IDE, FDA approved).. Valid values are `IND|IDE|FDA_Approved|Pending`',
    `sponsor_name` STRING COMMENT 'Name of the organization sponsoring the clinical investigation.',
    `storage_requirements` STRING COMMENT 'Specific storage conditions required (e.g., refrigerated, protected from light).',
    `strength_unit` STRING COMMENT 'Unit of measure for the product strength (e.g., mg, mL).',
    `strength_value` DECIMAL(18,2) COMMENT 'Numeric strength of the product (e.g., 500 mg).',
    `study_phase` STRING COMMENT 'Clinical trial phase for which the product is being evaluated.. Valid values are `Phase_I|Phase_II|Phase_III|Phase_IV`',
    `temperature_monitoring_required` BOOLEAN COMMENT 'Flag indicating if continuous temperature monitoring is mandated.',
    `temperature_range_max` DECIMAL(18,2) COMMENT 'Highest permissible storage temperature (°C).',
    `temperature_range_min` DECIMAL(18,2) COMMENT 'Lowest permissible storage temperature (°C).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `name` STRING COMMENT 'Human‑readable name of the investigational drug, biologic, or device.',
    `status` STRING COMMENT 'Current lifecycle state of the investigational product within the trial.. Valid values are `pending|active|suspended|completed|withdrawn`',
    `description` STRING COMMENT 'Free‑text description providing additional details about the investigational product.',
    `clinical_trial_id` BIGINT COMMENT 'Identifier of the clinical trial to which this investigational product is assigned.',
    CONSTRAINT pk_investigational_product PRIMARY KEY(`investigational_product_id`)
) COMMENT 'Master record for investigational drugs, biologics, or devices used in clinical trials. Captures IND/IDE number, NDC or device identifier, product name (generic and brand), formulation, dosage form, strength, manufacturer, lot number tracking flag, storage requirements, temperature monitoring requirements, expiration date management flag, blinding status (open-label, single-blind, double-blind), and comparator/placebo indicator. Supports FDA 21 CFR Part 312 (drugs) and 21 CFR Part 812 (devices) accountability requirements.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`ip_dispensation` (
    `ip_dispensation_id` BIGINT COMMENT 'Unique surrogate key for each investigational product dispensation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the pharmacist or research coordinator who performed the dispensation.',
    `investigational_product_id` BIGINT COMMENT 'Foreign key linking to research.investigational_product. Business justification: IP dispensation records the dispensing of a specific investigational product. The ip_product_code, ip_product_name, ip_product_type, ip_manufacturer are redundant with investigational_product master (',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Investigational products dispensed during SNF stays or home health visits require drug accountability tracking per FDA 21 CFR Part 312. Links dispensation events to the specific PAC episode for regula',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical study to which this dispensation belongs.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier of the research participant receiving the investigational product.',
    `visit_id` BIGINT COMMENT 'Identifier of the scheduled study visit during which the dispensation occurred.',
    `adverse_event_description` STRING COMMENT 'Narrative description of any adverse event linked to the dispensed product.',
    `adverse_event_flag` BOOLEAN COMMENT 'True if an adverse event was reported in association with this dispensation.',
    `chain_of_custody_signature` STRING COMMENT 'Electronic signature confirming the chain‑of‑custody for the dispensed unit.',
    `compliance_status` STRING COMMENT 'Indicates whether the subject adhered to the dosing schedule for this dispensation.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dispensation record was first created in the system.',
    `dispensation_date` DATE COMMENT 'Calendar date on which the investigational product was dispensed.',
    `dispensation_timestamp` TIMESTAMP COMMENT 'Exact date‑time (to the second) when the product was handed to the subject.',
    `dispensing_pharmacist_name` STRING COMMENT 'Full name of the staff member who dispensed the product.',
    `dose_level` STRING COMMENT 'Categorical level of the dose administered for the visit.. Valid values are `low|medium|high`',
    `ip_batch_number` STRING COMMENT 'Manufacturer batch identifier for traceability.',
    `ip_dispensation_status` STRING COMMENT 'Current lifecycle state of the dispensation record.. Valid values are `dispensed|cancelled|returned`',
    `ip_dispensing_location` STRING COMMENT 'Physical location (e.g., clinic, pharmacy) where the product was dispensed.',
    `ip_dose_amount` DECIMAL(18,2) COMMENT 'Numeric amount of the dose administered.',
    `ip_dose_unit` STRING COMMENT 'Unit of measure for the dose amount.. Valid values are `mg|ml|units`',
    `ip_expiration_date` DATE COMMENT 'Date after which the investigational product must not be used.',
    `ip_route_of_administration` STRING COMMENT 'Method by which the product was administered to the subject.. Valid values are `oral|iv|im|sc|inhalation`',
    `ip_storage_condition` STRING COMMENT 'Required storage condition (e.g., refrigerated, frozen).',
    `kit_number` STRING COMMENT 'Identifier of the investigational product kit used for the dispensation.',
    `lot_number` STRING COMMENT 'Manufacturer‑assigned lot number of the investigational product.',
    `missed_doses` STRING COMMENT 'Number of scheduled doses that the subject did not take.',
    `notes` STRING COMMENT 'Free‑text field for additional observations or comments by the dispenser.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Amount of product given to the subject, expressed in the unit defined by dose_unit.',
    `returned_units` DECIMAL(18,2) COMMENT 'Quantity of product returned by the subject (e.g., unused doses).',
    `serial_number` STRING COMMENT 'Unique serial number for the specific product unit, if applicable.',
    `source_system` STRING COMMENT 'Name of the originating source system (e.g., Epic, Medidata).',
    `subject_mrn` STRING COMMENT 'Medical record number of the subject, used for cross‑system patient matching.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the dispensation record.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical study to which this dispensation belongs.',
    `subject_id` BIGINT COMMENT 'Unique identifier of the research participant receiving the investigational product.',
    `dispensing_pharmacist_id` BIGINT COMMENT 'Identifier of the pharmacist or research coordinator who performed the dispensation.',
    `status` STRING COMMENT 'Current lifecycle state of the dispensation record.. Valid values are `dispensed|cancelled|returned`',
    `ip_product_code` STRING COMMENT 'Standardized code identifying the investigational product.',
    `ip_product_name` STRING COMMENT 'Descriptive name of the investigational product.',
    `ip_product_type` STRING COMMENT 'Category of the investigational product.. Valid values are `drug|device|biologic`',
    `ip_manufacturer` STRING COMMENT 'Name of the company that produced the investigational product.',
    CONSTRAINT pk_ip_dispensation PRIMARY KEY(`ip_dispensation_id`)
) COMMENT 'Transactional record of investigational product (IP) dispensation to an enrolled research subject at a study visit. Captures dispensation date, lot number, quantity dispensed, dose level, kit number, subject compliance (returned units, missed doses), pharmacist or coordinator dispensing, and chain-of-custody signature. Supports IP accountability logs required under FDA 21 CFR Part 312.62 and ICH E6(R2) Section 8.3. Enables drug accountability reconciliation at study close-out.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`biospecimen` (
    `biospecimen_id` BIGINT COMMENT 'Unique identifier for the biospecimen record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory where processing occurred.',
    `genomics_genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: Specimen-to-order tracking: research biobank must know which genomic order requested analysis of a specific specimen for fulfillment tracking, chain-of-custody documentation, and reconciliation of ord',
    `genomics_genomic_sequence_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_sequence. Business justification: Biobanking-to-sequencing pipeline: research biospecimens are the physical source material for genomic sequencing. Tracking which specimen produced which sequence is essential for chain-of-custody, QC ',
    `informed_consent_id` BIGINT COMMENT 'Identifier of the consent governing future use of the specimen.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the specimen was collected.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical study or protocol associated with the specimen.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Biospecimens are collected from enrolled research subjects as part of study protocols. Currently has research_study_id and mpi_record_id but no direct enrollment link.',
    `aliquot_number` STRING COMMENT 'Sequence number of the aliquot derived from the original specimen.',
    `aliquot_type` STRING COMMENT 'Classification of the aliquot.. Valid values are `primary|secondary|aliquot|derived`',
    `aliquot_volume` DECIMAL(18,2) COMMENT 'Volume of the aliquot.',
    `aliquot_volume_unit` STRING COMMENT 'Unit of measure for the aliquot volume.. Valid values are `ml|ul|l`',
    `anatomical_site` STRING COMMENT 'Body site or anatomical location where the specimen was taken.',
    `barcode` STRING COMMENT 'Machine-readable barcode assigned to the specimen.',
    `biospecimen_status` STRING COMMENT 'Current lifecycle status of the specimen.. Valid values are `collected|processed|stored|shipped|disposed|archived`',
    `collection_method` STRING COMMENT 'Method used to obtain the specimen.. Valid values are `venipuncture|biopsy|swab|aspiration|surgical`',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the specimen was collected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the biospecimen record was created.',
    `deidentification_status` STRING COMMENT 'Indicates whether the specimen data has been de-identified.. Valid values are `deidentified|identified|partial`',
    `disposal_date` DATE COMMENT 'Date the specimen was disposed of.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the specimen.. Valid values are `incineration|chemical|return|donation|recycle`',
    `disposition` STRING COMMENT 'Final disposition of the specimen.. Valid values are `analyzed|stored|destroyed|shipped`',
    `expiration_date` DATE COMMENT 'Date after which the specimen is considered expired for use.',
    `processing_date` DATE COMMENT 'Date the specimen was processed (e.g., aliquoted, frozen).',
    `processing_method` STRING COMMENT 'Method used to process the specimen after collection.',
    `qc_date` DATE COMMENT 'Date the quality control assessment was performed.',
    `qc_passed_flag` BOOLEAN COMMENT 'Indicates whether the specimen passed quality control.',
    `quality_control_status` STRING COMMENT 'Result of quality control assessment for the specimen.. Valid values are `passed|failed|pending|not_applicable`',
    `shipping_date` DATE COMMENT 'Date the specimen was shipped to another location.',
    `shipping_method` STRING COMMENT 'Method used to ship the specimen.. Valid values are `courier|mail|hand_deliver|pickup`',
    `shipping_tracking_number` STRING COMMENT 'Tracking number provided by the carrier for the shipment.',
    `specimen_type` STRING COMMENT 'Category of the biospecimen (e.g., blood, tissue).. Valid values are `blood|tissue|urine|saliva|csf|plasma`',
    `storage_box` STRING COMMENT 'Identifier of the box within the rack.',
    `storage_location` STRING COMMENT 'Physical location description where the specimen is stored (e.g., biobank, freezer).',
    `storage_position` STRING COMMENT 'Specific position (e.g., row/column) of the specimen within the storage box.',
    `storage_rack` STRING COMMENT 'Identifier of the rack within the storage unit.',
    `storage_status` STRING COMMENT 'Current operational status of the storage location.. Valid values are `available|in_use|maintenance|quarantined|depleted`',
    `storage_temperature` DECIMAL(18,2) COMMENT 'Temperature at which the specimen is stored.',
    `storage_temperature_unit` STRING COMMENT 'Unit of temperature for storage (Celsius, Fahrenheit, Kelvin).. Valid values are `C|F|K`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the biospecimen record.',
    `volume` DECIMAL(18,2) COMMENT 'Measured volume of the specimen.',
    `volume_unit` STRING COMMENT 'Unit of measure for the specimen volume.. Valid values are `ml|ul|l`',
    `weight` DECIMAL(18,2) COMMENT 'Measured weight of the specimen.',
    `weight_unit` STRING COMMENT 'Unit of measure for the specimen weight.. Valid values are `g|mg|kg`',
    `study_id` BIGINT COMMENT 'Identifier of the clinical study or protocol associated with the specimen.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient from whom the specimen was collected.',
    `consent_id` BIGINT COMMENT 'Identifier of the consent governing future use of the specimen.',
    `status` STRING COMMENT 'Current lifecycle status of the specimen.. Valid values are `collected|processed|stored|shipped|disposed|archived`',
    `processing_lab_id` BIGINT COMMENT 'Identifier of the laboratory where processing occurred.',
    CONSTRAINT pk_biospecimen PRIMARY KEY(`biospecimen_id`)
) COMMENT 'Tracks biological specimens collected from research subjects as part of study protocols, including blood, tissue, urine, saliva, and other biosamples. Captures specimen type, collection date and time, collection site (anatomical), collection method, volume/quantity, processing method, storage location (biobank, freezer, rack, box, position), chain-of-custody, de-identification status, consent for future use, specimen disposition (analyzed, stored, destroyed, shipped), and shipping/transfer records. Supports biobanking operations, translational research specimen management, and specimen lifecycle tracking from collection through final disposition.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`data_safety_monitoring` (
    `data_safety_monitoring_id` BIGINT COMMENT 'Unique surrogate key for the data safety monitoring record.',
    `dsmb_committee_id` BIGINT COMMENT 'Identifier of the DSMB overseeing the trial.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: DSMB activities monitor safety for a specific research study. Currently only linked via trial_id to clinical_trial_matching.trial (cross-domain). Direct in-domain link to research_study is essential.',
    `study_sponsor_id` BIGINT COMMENT 'Identifier of the trial sponsor organization.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial under monitoring.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail information for compliance.',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality assigned to the monitoring record.. Valid values are `public|restricted|confidential`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring record was first created.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long the monitoring record must be retained.. Valid values are `5_years|10_years|indefinite`',
    `data_safety_monitoring_status` STRING COMMENT 'Current lifecycle status of the monitoring record.. Valid values are `open|closed|pending|cancelled`',
    `effective_from` DATE COMMENT 'Start date of the records validity period (SCD Type 2).',
    `effective_until` DATE COMMENT 'End date of the records validity period (null if current).',
    `follow_up_action` STRING COMMENT 'Action required as a result of the DSMB recommendation.',
    `follow_up_due_date` DATE COMMENT 'Target date for completion of the follow‑up action.',
    `meeting_date` DATE COMMENT 'Date on which the DSMB meeting took place.',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the DSMB meeting was held.',
    `meeting_type` STRING COMMENT 'Classification of the meeting (e.g., interim, final, ad hoc).. Valid values are `interim|final|ad_hoc`',
    `minutes_document_path` STRING COMMENT 'File system or repository path to the stored meeting minutes document.',
    `monitoring_number` STRING COMMENT 'Business identifier assigned to the monitoring record, used in regulatory reporting.',
    `recommendation` STRING COMMENT 'Formal recommendation issued by the DSMB after review.. Valid values are `continue|modify|suspend|terminate`',
    `recommendation_details` STRING COMMENT 'Narrative details explaining the DSMB recommendation.',
    `record_source_system` STRING COMMENT 'Name of the source system that supplied the record (e.g., EDC, CTMS).',
    `safety_event_summary` STRING COMMENT 'Summary of safety events or adverse events reviewed during the meeting.',
    `unblinding_date` DATE COMMENT 'Date on which the unblinding event took place, if applicable.',
    `unblinding_event` BOOLEAN COMMENT 'Flag indicating whether an unblinding of treatment allocation occurred.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the monitoring record.',
    `sponsor_id` BIGINT COMMENT 'Identifier of the trial sponsor organization.',
    `dsm_board_id` BIGINT COMMENT 'Identifier of the DSMB overseeing the trial.',
    `status` STRING COMMENT 'Current lifecycle status of the monitoring record.. Valid values are `open|closed|pending|cancelled`',
    CONSTRAINT pk_data_safety_monitoring PRIMARY KEY(`data_safety_monitoring_id`)
) COMMENT 'Records Data Safety Monitoring Board (DSMB) or Data Monitoring Committee (DMC) activities for a clinical trial, including meeting dates, interim analysis triggers, safety stopping rules, unblinding events, committee recommendations (continue, modify, suspend, terminate), sponsor responses, and implementation actions. Captures the formal oversight record required for Phase II–IV trials and FDA-regulated studies. Supports trial integrity and subject safety oversight.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`billing_event` (
    `billing_event_id` BIGINT COMMENT 'Unique system-generated identifier for the billing event record.',
    `claim_id` BIGINT COMMENT 'Identifier of the insurance claim linked to this billing event, if any.',
    `coverage_analysis_id` BIGINT COMMENT 'Foreign key linking to research.coverage_analysis. Business justification: Research billing events reference the coverage analysis that determined whether a service is billable to sponsor vs. payer. Links billing determination to its source analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst who performed the coverage determination.',
    `genomics_genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: Research billing reconciliation: coverage analysis determines whether genomic tests are sponsor-billable or insurance-billable. Linking billing events to specific genomic orders enables accurate cost ',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who received the service or is subject of the research billing.',
    `research_grant_id` BIGINT COMMENT 'Identifier of the research grant funding the sponsor‑billable portion.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Research billing events track charges for a specific study. Currently has study_sponsor_id and protocol_id but no direct research_study_id link.',
    `study_sponsor_id` BIGINT COMMENT 'Identifier of the research sponsor or grant organization responsible for sponsor‑billable charges.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research billing events are for specific enrolled subjects. Links billing to the enrollment context for research billing compliance.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, taxes, or other adjustments applied to the gross amount.',
    `analysis_date` DATE COMMENT 'Date the coverage determination analysis was performed.',
    `approval_status` STRING COMMENT 'Current approval state of the coverage determination.. Valid values are `approved|rejected|pending`',
    `billing_category` STRING COMMENT 'Classification of the billing event for reporting (research‑specific, standard care, sponsor‑only).. Valid values are `research|standard|sponsor`',
    `billing_event_status` STRING COMMENT 'Current lifecycle status of the billing event.. Valid values are `draft|open|closed|cancelled|pending`',
    `charge_quantity` DECIMAL(18,2) COMMENT 'Quantity of the service or item billed.',
    `charge_type` STRING COMMENT 'Category of the charge item.. Valid values are `service|procedure|device|drug`',
    `charge_unit` STRING COMMENT 'Unit of measure for the charge quantity.. Valid values are `unit|session|dose|hour|day`',
    `cms_ncd_reference` STRING COMMENT 'Reference to the CMS National Coverage Determination (e.g., NCD 310.1) that governs the service.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier used for financial allocation.',
    `coverage_determination` STRING COMMENT 'Result of the coverage analysis indicating billing responsibility.. Valid values are `sponsor_billable|medicare_billable|institutional_cost`',
    `coverage_rationale` STRING COMMENT 'Narrative explanation for the coverage determination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary amounts.',
    `eligibility_criteria_version` STRING COMMENT 'Version of the eligibility criteria set used for the determination.',
    `event_number` STRING COMMENT 'Human‑readable business identifier for the billing event, often used in audit and reporting.',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the billing event occurred in the real world (e.g., service provision or coverage analysis).',
    `financial_account_code` STRING COMMENT 'General ledger account code associated with the charge.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total charge amount before adjustments.',
    `invoice_number` STRING COMMENT 'Reference to the invoice generated for the billing event.',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the service meets eligibility criteria for sponsor billing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments; the amount to be billed.',
    `notes` STRING COMMENT 'Free‑form comments or additional information captured by the analyst.',
    `payer` STRING COMMENT 'STRING. Valid values are `medicare|medicaid|commercial|self_pay|other`',
    `policy_number` STRING COMMENT 'Policy number of the payer or sponsor governing the service coverage.',
    `protocol_version` STRING COMMENT 'Version of the protocol used for the coverage analysis.',
    `retention_period_years` STRING COMMENT 'Number of years the record must be retained to satisfy HIPAA and research data‑governance policies.',
    `service_cpt_code` STRING COMMENT 'Current Procedural Terminology code representing the billed service.',
    `service_date` DATE COMMENT 'Calendar date on which the clinical service was rendered.',
    `service_description` STRING COMMENT 'Free‑text description of the clinical service or research activity.',
    `service_hcpcs_code` STRING COMMENT 'Healthcare Common Procedure Coding System code for the service, if applicable.',
    `sponsor_grant_number` STRING COMMENT 'External grant number provided by the sponsor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the billing event record.',
    `status` STRING COMMENT 'Current lifecycle status of the billing event.. Valid values are `draft|open|closed|cancelled|pending`',
    `patient_id` BIGINT COMMENT 'Identifier of the patient who received the service or is subject of the research billing.',
    `sponsor_id` BIGINT COMMENT 'Identifier of the research sponsor or grant organization responsible for sponsor‑billable charges.',
    `protocol_id` STRING COMMENT 'Unique code of the clinical trial protocol associated with the billing event.',
    `analyst_id` BIGINT COMMENT 'Identifier of the analyst who performed the coverage determination.',
    CONSTRAINT pk_billing_event PRIMARY KEY(`billing_event_id`)
) COMMENT 'Captures research billing compliance determinations, coverage analysis documents, and individual charge-level events for clinical trial services. Coverage analysis layer: records the formal determination of which protocol services are standard of care (insurance-billable) versus research-specific (sponsor/grant-billable), including protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, and approval status. Charge event layer: captures service date, CPT/HCPCS code, charge amount, coverage determination (sponsor-billable, Medicare-billable, institutional cost), clinical trial policy number, and CMS NCD reference. Supports research billing compliance under CMS NCD 310.1 and OIG guidance to prevent false claims. SSOT for research billing compliance and coverage analysis within the research domain.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`research_grant_award` (
    `research_grant_award_id` BIGINT COMMENT 'Unique identifier for the research grant record.',
    `clinician_id` BIGINT COMMENT 'Internal identifier for the principal investigator within the organization.',
    `research_grant_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Grant awards fund specific research studies. Currently linked to research_grant but not directly to the study being funded.',
    `award_abstract` STRING COMMENT 'Brief summary of the research objectives and scope.',
    `award_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the grant as approved by the sponsor.',
    `award_modifications` STRING COMMENT 'Record of any amendments, extensions, or budget changes to the original award.',
    `award_number` STRING COMMENT 'External grant number assigned by the funding agency.',
    `award_title` STRING COMMENT 'Descriptive title of the research project funded by the grant.',
    `award_url` STRING COMMENT 'Web link to the official grant award page or documentation.',
    `budget_period` STRING COMMENT 'Fiscal year or period for which the budget is defined.. Valid values are `FY2023|FY2024|FY2025|FY2026|FY2027|FY2028`',
    `co_investigator_names` STRING COMMENT 'Comma‑separated list of names of additional investigators on the grant.',
    `compliance_notes` STRING COMMENT 'Free‑text notes on regulatory or sponsor compliance requirements.',
    `cost_center` STRING COMMENT 'Financial cost center responsible for grant expenditures.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the grant record was first entered into the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|GBP`',
    `direct_costs` DECIMAL(18,2) COMMENT 'Costs directly attributable to the research effort (e.g., salaries, supplies).',
    `effective_from` DATE COMMENT 'Date the grant becomes legally effective.',
    `effective_until` DATE COMMENT 'Date the grant expires or is terminated (null if open‑ended).',
    `effort_percentage` DECIMAL(18,2) COMMENT 'Proportion of the PIs effort allocated to the grant (e.g., 25.00%).',
    `funding_agency` STRING COMMENT 'Name of the organization providing the grant (e.g., NIH, NSF, DOD).',
    `grant_category` STRING COMMENT 'High‑level classification of the grant purpose.. Valid values are `research|training|infrastructure|collaboration`',
    `grant_status` STRING COMMENT 'Current lifecycle state of the grant.. Valid values are `active|closed|suspended|pending|terminated`',
    `grant_type` STRING COMMENT 'Classification of the grant according to federal award mechanisms.. Valid values are `R01|R21|K01|T32|U01|U54`',
    `indirect_costs` DECIMAL(18,2) COMMENT 'Facilities & Administrative (F&A) costs applied to the grant.',
    `principal_investigator_name` STRING COMMENT 'Full legal name of the lead researcher responsible for the grant.',
    `project_end_date` DATE COMMENT 'Date the funded research project is scheduled to conclude.',
    `project_start_date` DATE COMMENT 'Date the funded research project officially begins.',
    `reporting_requirements` STRING COMMENT 'Frequency and format of financial and technical reports required by the sponsor.',
    `sponsor_code` STRING COMMENT 'Internal code used to classify the funding agency or program.',
    `sponsor_requirements` STRING COMMENT 'Specific conditions or deliverables required by the funding agency.',
    `total_cost` DECIMAL(18,2) COMMENT 'Sum of direct and indirect costs for the grant period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the grant record.',
    CONSTRAINT pk_research_grant_award PRIMARY KEY(`research_grant_award_id`)
) COMMENT 'Renamed table from research.grant to research.research_grant.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`grant_expenditure` (
    `grant_expenditure_id` BIGINT COMMENT 'Unique identifier for the grant expenditure record.',
    `research_grant_id` BIGINT COMMENT 'Identifier of the research grant to which this expenditure belongs.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor entity.',
    `accounting_code` STRING COMMENT 'General ledger accounting code for financial posting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the expense was approved for payment.',
    `budget_period` STRING COMMENT 'Fiscal period of the grant budget to which the expense is charged.',
    `compliance_flag` STRING COMMENT 'Indicates compliance status of the expense with sponsor and federal regulations.. Valid values are `compliant|non_compliant|exempt`',
    `cost_center_code` STRING COMMENT 'Internal cost center responsible for the expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the expenditure record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the expense.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `effort_percentage` DECIMAL(18,2) COMMENT 'Portion of the investigators effort (in percent) charged to this expense.',
    `expense_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the expense before taxes or adjustments.',
    `expense_category` STRING COMMENT 'Classification of the expense type.. Valid values are `personnel|supplies|equipment|travel|subcontract|indirect`',
    `expense_date` DATE COMMENT 'Date the expense was incurred.',
    `grant_budget_line_code` STRING COMMENT 'Specific budget line within the grant to which the expense is charged.',
    `grant_expenditure_description` STRING COMMENT 'Narrative description of the expense.',
    `grant_fiscal_year` STRING COMMENT 'Fiscal year of the grant budget for this expense.',
    `indirect_rate` DECIMAL(18,2) COMMENT 'Applicable indirect cost rate percentage for the expense.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with the expense.',
    `is_indirect_cost` BOOLEAN COMMENT 'True if the expense is classified as indirect cost.',
    `line_sequence` STRING COMMENT 'Sequential order of the expenditure line within the grant.',
    `payment_status` STRING COMMENT 'Current payment processing status of the expense.. Valid values are `pending|approved|paid|rejected`',
    `project_code` STRING COMMENT 'Internal project or work package code linked to the expense.',
    `receipt_attached` BOOLEAN COMMENT 'Indicates whether a receipt image has been attached.',
    `resource_code` BIGINT COMMENT 'Identifier of the resource (e.g., equipment, service) associated with the expense.',
    `sponsor_cost_classification` STRING COMMENT 'Classification required by the sponsor for reporting (e.g., direct, indirect).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the expense, if applicable.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount charged (expense amount plus tax).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `grant_id` BIGINT COMMENT 'Identifier of the research grant to which this expenditure belongs.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (e.g., equipment, service) associated with the expense.',
    `description` STRING COMMENT 'Narrative description of the expense.',
    `vendor_name` STRING COMMENT 'Name of the external vendor providing the goods or services.',
    CONSTRAINT pk_grant_expenditure PRIMARY KEY(`grant_expenditure_id`)
) COMMENT 'Transactional record of expenditures charged against a research grant or contract, including personnel costs (salary, fringe), supplies, equipment, subcontract costs, travel, and indirect costs. Captures transaction date, expense category, amount, budget period, cost center, effort percentage, and sponsor-required cost classification. Supports grant financial management, budget-to-actual reporting, and compliance with 2 CFR Part 200 (Uniform Guidance) cost principles. Enables NIH Just-In-Time and progress report financial sections.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_sponsor` (
    `study_sponsor_id` BIGINT COMMENT 'Unique surrogate key for the study sponsor record.',
    `address_line1` STRING COMMENT 'First line of the sponsors mailing address.',
    `address_line2` STRING COMMENT 'Second line of the sponsors mailing address (optional).',
    `budget_approval_date` DATE COMMENT 'Date when the study budget was formally approved.',
    `budget_version` STRING COMMENT 'Identifier for the version of the study budget (e.g., v1, v2).',
    `city` STRING COMMENT 'City component of the sponsors mailing address.',
    `contract_end_date` DATE COMMENT 'Date when the sponsorship agreement terminates or expires; null if open‑ended.',
    `contract_start_date` DATE COMMENT 'Date when the sponsorship agreement becomes effective.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the sponsors primary location.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the sponsor.',
    `fda_21cfr11_compliant` BOOLEAN COMMENT 'Indicates whether the sponsors data handling complies with FDA electronic records regulations.',
    `is_bla_holder` BOOLEAN COMMENT 'True if the sponsor holds a Biologics License Application for the study.',
    `is_cro_relationship` BOOLEAN COMMENT 'Indicates whether a CRO is engaged on behalf of the sponsor.',
    `is_ndaholder` BOOLEAN COMMENT 'True if the sponsor holds a non‑disclosure agreement for the study.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the sponsor relationship.',
    `overhead_rate_percent` DECIMAL(18,2) COMMENT 'Percentage overhead applied to direct costs.',
    `payment_currency` STRING COMMENT 'Three‑letter ISO currency code for sponsor payments.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `payment_milestone_description` STRING COMMENT 'Textual description of payment milestones tied to study deliverables.',
    `payment_schedule_terms` STRING COMMENT 'Terms governing timing and method of sponsor payments.',
    `per_procedure_rate` DECIMAL(18,2) COMMENT 'Negotiated amount paid for each specific study procedure.',
    `per_visit_rate` DECIMAL(18,2) COMMENT 'Negotiated amount paid to the site for each patient visit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the sponsors mailing address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary sponsor contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary individual contact for the sponsor organization.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary sponsor contact.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the sponsor record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sponsor record.',
    `screen_failure_allowance` DECIMAL(18,2) COMMENT 'Budgeted amount to compensate for subjects who fail screening.',
    `sponsor_code` STRING COMMENT 'External identifier or code assigned to the sponsor by the institution or regulatory body.',
    `sponsor_name` STRING COMMENT 'Legal name of the organization sponsoring the clinical study.',
    `sponsor_type` STRING COMMENT 'Classification of the sponsor based on its primary business focus.. Valid values are `pharma|biotech|device|government|foundation`',
    `startup_cost` DECIMAL(18,2) COMMENT 'Up‑front payment to cover study initiation expenses.',
    `state_province` STRING COMMENT 'State or province component of the sponsors mailing address.',
    `study_sponsor_status` STRING COMMENT 'Current lifecycle status of the sponsor relationship.. Valid values are `active|inactive|suspended|pending|terminated`',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier (e.g., EIN) for the sponsor organization.',
    `status` STRING COMMENT 'Current lifecycle status of the sponsor relationship.. Valid values are `active|inactive|suspended|pending|terminated`',
    `tax_id` STRING COMMENT 'Government‑issued tax identifier (e.g., EIN) for the sponsor organization.',
    CONSTRAINT pk_study_sponsor PRIMARY KEY(`study_sponsor_id`)
) COMMENT 'Master record for entities sponsoring clinical research studies, including negotiated study budgets and financial terms. Sponsor level: captures sponsor name, type (pharma, biotech, device, government, foundation), NDA/BLA holder status, CRO relationship, contact information, agreement reference, and financial disclosure requirements. Budget level: captures per-visit and per-procedure reimbursement rates, startup costs, overhead/indirect costs, screen failure allowances, payment milestones, budget version, negotiated vs institutional costs, budget approval date, and payment schedule terms. Distinct from grant — sponsors may fund studies without formal grant mechanisms (e.g., industry-sponsored CTAs). Supports research finance, sponsor invoicing, and study budget management. SSOT for sponsor identity and study budget terms within the research domain.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`coverage_analysis` (
    `coverage_analysis_id` BIGINT COMMENT 'Unique surrogate key for each coverage analysis record.',
    `employee_id` BIGINT COMMENT 'Surrogate key of the analyst who performed the coverage analysis.',
    `payer_id` BIGINT COMMENT 'Identifier of the primary insurance payer evaluated in the analysis.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Coverage analysis determines which clinical trial services are billable to payers vs. sponsors. It is performed for a specific research study protocol.',
    `analysis_date` DATE COMMENT 'Date the coverage analysis was performed.',
    `analysis_identifier` STRING COMMENT 'Human‑readable business identifier assigned to the analysis (e.g., CA‑2023‑001).',
    `analysis_type` STRING COMMENT 'Classifies the analysis as determining standard‑of‑care coverage or research‑specific coverage.. Valid values are `standard_of_care|research_specific`',
    `analyst_name` STRING COMMENT 'Full legal name of the analyst (personally identifiable).',
    `approval_date` DATE COMMENT 'Date the analysis was formally approved.',
    `approval_status` STRING COMMENT 'Current approval state of the coverage analysis within the governance workflow.. Valid values are `draft|submitted|approved|rejected`',
    `coverage_decision` STRING COMMENT 'Result of the analysis indicating whether the service is billable to insurance or to the research sponsor.. Valid values are `billable_to_insurance|billable_to_sponsor`',
    `cpt_codes_reviewed` STRING COMMENT 'Comma‑separated list of CPT codes evaluated in the analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage analysis record was first inserted.',
    `determination_rationale` STRING COMMENT 'Narrative explanation of why a service was classified as standard‑of‑care or research‑specific.',
    `determination_status` STRING COMMENT 'Current workflow status of the coverage determination.. Valid values are `pending|approved|rejected`',
    `effective_from` DATE COMMENT 'Date the coverage determination becomes effective for billing purposes.',
    `effective_until` DATE COMMENT 'Date the coverage determination expires or is superseded (nullable for open‑ended).',
    `hcpcs_codes_reviewed` STRING COMMENT 'Comma‑separated list of HCPCS codes evaluated in the analysis.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this row represents the current version of the analysis (true) or a historical version (false).',
    `notes` STRING COMMENT 'Free‑form comments captured by the analyst during the review.',
    `protocol_version` STRING COMMENT 'Version string of the protocol (e.g., v2.1).',
    `record_status` STRING COMMENT 'Lifecycle status of the record for archival and data‑retention purposes.. Valid values are `active|inactive|archived`',
    `retention_policy` STRING COMMENT 'Annotation of the applicable HIPAA retention rule (e.g., HIPAA_6_years).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coverage analysis record.',
    `version_number` STRING COMMENT 'Sequential version for Slowly Changing Dimension Type 2 tracking.',
    `protocol_id` BIGINT COMMENT 'Identifier of the clinical trial protocol to which this coverage analysis applies.',
    `analyst_id` BIGINT COMMENT 'Surrogate key of the analyst who performed the coverage analysis.',
    CONSTRAINT pk_coverage_analysis PRIMARY KEY(`coverage_analysis_id`)
) COMMENT 'Formal coverage analysis (CA) document record that determines which services in a clinical trial protocol are standard of care (billable to insurance) versus research-specific (billable to sponsor/grant). Captures protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, approval status, and effective date. Required for research billing compliance programs under CMS NCD 310.1. Distinct from research_billing_event which captures individual charge-level determinations.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`research_regulatory_submission` (
    `research_regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory submission record.',
    `amendment_of_research_regulatory_submission_id` BIGINT COMMENT 'Reference to the original submission that this record amends.',
    `clinician_id` BIGINT COMMENT 'Identifier of the lead researcher responsible for the study.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical or translational research study linked to this submission.',
    `study_sponsor_id` BIGINT COMMENT 'Identifier of the organization or entity sponsoring the research and filing the submission.',
    `acknowledgment_date` DATE COMMENT 'Date the agency acknowledged receipt of the submission.',
    `agency` STRING COMMENT 'Regulatory authority receiving the submission.. Valid values are `FDA|NIH|OHRP|EMA|PMDA`',
    `agency_submission_number` STRING COMMENT 'Reference number assigned by the agency upon receipt.',
    `compliance_flag` STRING COMMENT 'Indicates whether the submission meets all regulatory compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality applied to the submission.. Valid values are `public|restricted|confidential`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the submission becomes effective for regulatory purposes.',
    `expiration_date` DATE COMMENT 'Date after which the submission is no longer valid, if applicable.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the agency for processing the submission.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the submission fee.',
    `fee_paid` BOOLEAN COMMENT 'Indicates whether the submission fee has been paid.',
    `fee_payment_date` DATE COMMENT 'Date the submission fee was paid.',
    `is_amended` BOOLEAN COMMENT 'True if this record represents an amendment to a prior submission.',
    `is_confidential` BOOLEAN COMMENT 'True if the submission contains confidential or proprietary information.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by the sponsor or reviewers.',
    `regulatory_category` STRING COMMENT 'High‑level classification of the product under review.. Valid values are `drug|device|biologic|combination|behavioral`',
    `related_documents` STRING COMMENT 'Comma‑separated list of internal document identifiers linked to this submission.',
    `response_date` DATE COMMENT 'Date the agency provided a formal response.',
    `response_summary` STRING COMMENT 'Brief narrative of the agencys decision or comments.',
    `response_type` STRING COMMENT 'Classification of the agencys response.. Valid values are `approval|clinical_hold|request_for_info|rejection`',
    `sponsor_contact_email` STRING COMMENT 'Email address of the primary sponsor contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_contact_name` STRING COMMENT 'Full name of the primary sponsor contact person.',
    `sponsor_contact_phone` STRING COMMENT 'Phone number of the primary sponsor contact.',
    `submission_file_path` STRING COMMENT 'File system or object storage path where the electronic submission package is stored.',
    `submission_method` STRING COMMENT 'Mechanism used to deliver the submission to the agency.. Valid values are `eCTD|paper|electronic|portal`',
    `submission_number` STRING COMMENT 'External identifier assigned by the sponsor for tracking the submission.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the submission was formally sent to the agency.',
    `submission_type` STRING COMMENT 'Category of regulatory submission (e.g., IND, IDE, NDA, BLA, Annual Report, Safety Report).. Valid values are `IND|IDE|NDA|BLA|AnnualReport|SafetyReport`',
    `submission_version` STRING COMMENT 'Version number for revised or amended submissions.',
    `therapeutic_area` STRING COMMENT 'Medical specialty area targeted by the study.. Valid values are `oncology|cardiology|neurology|immunology|infectious_disease`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `sponsor_id` BIGINT COMMENT 'Identifier of the organization or entity sponsoring the research and filing the submission.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical or translational research study linked to this submission.',
    `principal_investigator_id` BIGINT COMMENT 'Identifier of the lead researcher responsible for the study.',
    `amendment_of_id` BIGINT COMMENT 'Reference to the original submission that this record amends.',
    CONSTRAINT pk_research_regulatory_submission PRIMARY KEY(`research_regulatory_submission_id`)
) COMMENT 'Tracks all regulatory submissions made to federal agencies (FDA, NIH, OHRP) in connection with a research study, including IND applications, IDE applications, IND amendments, annual reports, safety reports, NDA/BLA submissions, and OHRP assurance filings. Captures submission type, submission date, agency, submission number, submission method (eCTD, paper), acknowledgment date, agency response, and action required. Supports FDA 21 CFR Part 312 and Part 812 regulatory lifecycle management.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`monitoring_visit` (
    `monitoring_visit_id` BIGINT COMMENT 'Unique identifier for the monitoring visit record.',
    `employee_id` BIGINT COMMENT 'Identifier of the monitor who performed the visit.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical study associated with the visit.',
    `study_site_id` BIGINT COMMENT 'Identifier of the study site visited.',
    `study_sponsor_id` BIGINT COMMENT 'Foreign key linking to research.study_sponsor. Business justification: Monitoring visits are conducted by or on behalf of study sponsors. The sponsor_name STRING is redundant with study_sponsor.sponsor_name.',
    `adverse_event_reported_flag` BOOLEAN COMMENT 'Indicates if any adverse events were reported during the visit.',
    `corrective_action_due_date` DATE COMMENT 'Due date for the corrective action plan to be completed.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Flag indicating if a corrective action plan (CAP) is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring visit record was created in the system.',
    `data_discrepancy_flag` BOOLEAN COMMENT 'Indicates if data discrepancies were noted.',
    `findings_details` STRING COMMENT 'Detailed narrative of observations, discrepancies, and issues identified.',
    `findings_summary` STRING COMMENT 'Brief summary of findings from the monitoring visit.',
    `monitor_name` STRING COMMENT 'Full name of the monitor conducting the visit.',
    `notes` STRING COMMENT 'Additional free-text notes captured by the monitor.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Indicates whether any protocol deviations were identified during the visit.',
    `report_completion_date` DATE COMMENT 'Date when the monitoring visit report was completed and signed off.',
    `site_name` STRING COMMENT 'Name of the study site visited.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the monitoring visit record.',
    `visit_number` STRING COMMENT 'Sequential number of the visit for the site within the study (e.g., 1 for initiation).',
    `visit_status` STRING COMMENT 'Current processing status of the visit record.. Valid values are `pending|completed|cancelled`',
    `visit_timestamp` TIMESTAMP COMMENT 'Date and time when the monitoring visit occurred.',
    `visit_type` STRING COMMENT 'Category of the monitoring visit.. Valid values are `initiation|routine|close_out|for_cause`',
    `site_id` BIGINT COMMENT 'Identifier of the study site visited.',
    `monitor_id` BIGINT COMMENT 'Identifier of the monitor who performed the visit.',
    `sponsor_name` STRING COMMENT 'Name of the sponsor organization overseeing the clinical trial.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical study associated with the visit.',
    CONSTRAINT pk_monitoring_visit PRIMARY KEY(`monitoring_visit_id`)
) COMMENT 'Records clinical trial monitoring visits conducted by sponsor representatives, CROs, or internal monitors at study sites. Captures visit type (initiation, routine, close-out, for-cause), visit date, monitor name, site visited, findings summary, protocol deviations identified, data discrepancies noted, corrective action plan (CAP) required flag, CAP due date, and visit report completion date. Supports ICH E6(R2) GCP monitoring requirements and sponsor oversight obligations.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`protocol_deviation` (
    `protocol_deviation_id` BIGINT COMMENT 'Unique identifier for the protocol deviation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the deviation record.',
    `protocol_employee_id` BIGINT COMMENT 'Identifier of the system user who created the deviation record.',
    `research_document_id` BIGINT COMMENT 'Identifier for any supporting documents attached to the deviation record.',
    `study_site_id` BIGINT COMMENT 'Identifier of the clinical site where the deviation occurred.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier of the trial participant (patient) affected by the deviation.',
    `capa_completed` STRING COMMENT 'Indicates whether the corrective and preventive action (CAPA) has been completed.. Valid values are `yes|no`',
    `capa_completion_date` DATE COMMENT 'Date when the CAPA was completed.',
    `clinical_monitoring_required` STRING COMMENT 'Indicates if additional clinical monitoring is required due to the deviation.. Valid values are `yes|no`',
    `corrective_action` STRING COMMENT 'Planned or executed corrective action to address the deviation.',
    `data_review_date` DATE COMMENT 'Date when the deviation data was reviewed.',
    `data_reviewed` STRING COMMENT 'Indicates whether the deviation data has been reviewed for impact on analysis.. Valid values are `yes|no`',
    `deviation_category` STRING COMMENT 'Category of the protocol deviation (e.g., eligibility, dosing, visit window, consent, data collection).. Valid values are `eligibility|dosing|visit_window|consent|data_collection`',
    `deviation_description` STRING COMMENT 'Narrative description of what happened, including any protocol steps that were not followed.',
    `deviation_timestamp` TIMESTAMP COMMENT 'Date and time when the protocol deviation actually occurred.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation was first identified by study staff.',
    `finalized` STRING COMMENT 'Indicates whether the deviation record is finalized and locked for editing.. Valid values are `yes|no`',
    `impact_on_data_integrity` STRING COMMENT 'Assessment of any effect the deviation may have had on the integrity of trial data.',
    `impact_on_subject_safety` STRING COMMENT 'Assessment of any effect the deviation may have had on participant safety.',
    `irb_notification_date` DATE COMMENT 'Date when the IRB was notified.',
    `irb_notified` STRING COMMENT 'Indicates whether the IRB has been notified of the deviation.. Valid values are `yes|no`',
    `irb_reportable` STRING COMMENT 'Indicates whether the deviation must be reported to the Institutional Review Board.. Valid values are `yes|no|pending`',
    `preventive_action` STRING COMMENT 'Planned or executed preventive action to avoid recurrence of the deviation.',
    `protocol_deviation_status` STRING COMMENT 'Current lifecycle status of the deviation record.. Valid values are `open|in_review|resolved|closed`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deviation record was first entered into the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the deviation record.',
    `regulatory_reference` STRING COMMENT 'Reference to any regulatory guidance or GCP clause associated with the deviation.',
    `root_cause` STRING COMMENT 'Root cause analysis of why the deviation occurred (e.g., process error, equipment failure, human error).',
    `severity` STRING COMMENT 'Severity level of the deviation based on impact to subject safety and data integrity.. Valid values are `minor|major|important`',
    `sponsor_notification_date` DATE COMMENT 'Date when the sponsor was notified.',
    `sponsor_notified` STRING COMMENT 'Indicates whether the trial sponsor has been notified of the deviation.. Valid values are `yes|no`',
    `sponsor_reportable` STRING COMMENT 'Indicates whether the deviation must be reported to the trial sponsor.. Valid values are `yes|no|pending`',
    `protocol_id` BIGINT COMMENT 'Identifier of the clinical trial protocol to which this deviation belongs.',
    `subject_id` BIGINT COMMENT 'Unique identifier of the trial participant (patient) affected by the deviation.',
    `site_id` BIGINT COMMENT 'Identifier of the clinical site where the deviation occurred.',
    `status` STRING COMMENT 'Current lifecycle status of the deviation record.. Valid values are `open|in_review|resolved|closed`',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who created the deviation record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the system user who last modified the deviation record.',
    `document_attachment_id` BIGINT COMMENT 'Identifier for any supporting documents attached to the deviation record.',
    CONSTRAINT pk_protocol_deviation PRIMARY KEY(`protocol_deviation_id`)
) COMMENT 'Documents protocol deviations and violations identified during a clinical trial, including the deviation description, deviation date, discovery date, deviation category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports GCP compliance, regulatory inspection readiness, and quality management under ICH E6(R2).';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`deidentified_dataset` (
    `deidentified_dataset_id` BIGINT COMMENT 'Unique surrogate identifier for the de-identified dataset record.',
    `data_governance_committee_id` BIGINT COMMENT 'Foreign key linking to research.data_governance_committee. Business justification: De-identified datasets are governed and approved by a data governance committee. Links the dataset to its governing body for access control and compliance.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: De-identified datasets are derived from research study data. A dataset belongs to a specific study. This connects the siloed deidentified_dataset to the domain hub.',
    `access_count` BIGINT COMMENT 'Cumulative count of accesses granted to the dataset.',
    `access_end_date` DATE COMMENT 'Date when access expires.',
    `access_start_date` DATE COMMENT 'Date when the requestor was granted access.',
    `access_tier` STRING COMMENT 'Level of data access restriction.. Valid values are `internal|limited|fully_deidentified`',
    `approved_use_cases` STRING COMMENT 'Enumerated approved research use cases for the dataset.',
    `compliance_notes` STRING COMMENT 'Additional notes regarding compliance, regulatory constraints, or audit findings.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the dataset record was created in the system.',
    `data_destruction_certified` BOOLEAN COMMENT 'Indicates whether the requestor has certified data destruction after use.',
    `data_elements` STRING COMMENT 'List of data elements (fields) included in the dataset.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality rating (0-100) assigned by data stewards.',
    `data_sharing_agreement_ref` STRING COMMENT 'Reference identifier for the data sharing agreement governing the dataset.',
    `data_steward_email` STRING COMMENT 'Contact email of the data steward.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `data_steward_name` STRING COMMENT 'Name of the individual responsible for dataset governance.',
    `dataset_category` STRING COMMENT 'High-level category of the dataset (e.g., clinical, genomic, imaging).',
    `dataset_size_bytes` BIGINT COMMENT 'Total size of the dataset in bytes.',
    `dataset_version` STRING COMMENT 'Version identifier for the dataset (e.g., v1.0).',
    `date_range_end` DATE COMMENT 'Latest date of source data included in the dataset.',
    `date_range_start` DATE COMMENT 'Earliest date of source data included in the dataset.',
    `decision` STRING COMMENT 'Outcome of the access request decision.. Valid values are `approved|denied|pending`',
    `deidentification_date` DATE COMMENT 'Date when the dataset was de-identified.',
    `deidentification_detail` STRING COMMENT 'Additional details about the de-identification process, such as algorithms or parameters.',
    `deidentification_method` STRING COMMENT 'Method used to de-identify data, per HIPAA Safe Harbor or Expert Determination.. Valid values are `safe_harbor|expert_determination`',
    `deidentified_dataset_description` STRING COMMENT 'Detailed description of the dataset content and purpose.',
    `deidentified_dataset_name` STRING COMMENT 'Human readable name of the dataset.',
    `dua_status` STRING COMMENT 'Current status of the Data Use Agreement.. Valid values are `pending|approved|denied`',
    `expiration_date` DATE COMMENT 'Date after which the dataset must be destroyed or archived.',
    `intended_use` STRING COMMENT 'Description of the intended research use for the dataset.',
    `irb_approval_ref` STRING COMMENT 'Reference to IRB approval for the request.',
    `irb_waiver_ref` STRING COMMENT 'Reference to IRB waiver documentation permitting dataset use.',
    `is_public` BOOLEAN COMMENT 'Indicates if the dataset is publicly available (true) or restricted (false).',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to the dataset.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dataset record.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the dataset.. Valid values are `active|inactive|archived|pending`',
    `record_count` BIGINT COMMENT 'Number of records contained in the dataset.',
    `request_submission_date` DATE COMMENT 'Date the access request was submitted.',
    `requestor_email` STRING COMMENT 'Email address of the requestor.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `requestor_institution` STRING COMMENT 'Institution or organization of the requestor.',
    `requestor_name` STRING COMMENT 'Name of the individual requesting dataset access.',
    `retention_annotation` STRING COMMENT 'HIPAA retention annotation or policy notes.',
    `retention_period_years` STRING COMMENT 'Number of years the dataset must be retained per policy.',
    `review_date` DATE COMMENT 'Date the request was reviewed by the data governance board.',
    `sensitivity_level` STRING COMMENT 'Overall sensitivity classification of the dataset.. Valid values are `low|medium|high`',
    `source_systems` STRING COMMENT 'Comma-separated list of source operational systems (e.g., Epic, Cerner) from which data were extracted.',
    `version_timestamp` TIMESTAMP COMMENT 'Timestamp when this version of the dataset was created.',
    `name` STRING COMMENT 'Human readable name of the dataset.',
    `description` STRING COMMENT 'Detailed description of the dataset content and purpose.',
    CONSTRAINT pk_deidentified_dataset PRIMARY KEY(`deidentified_dataset_id`)
) COMMENT 'Master record for de-identified research datasets, access request management, and data governance. Dataset level: captures dataset name, source systems, de-identification method (Safe Harbor, Expert Determination per HIPAA 45 CFR 164.514(b)), de-identification date, data steward, approved use cases, data sharing agreement reference, IRB waiver reference, data elements, date range, and access tier (internal, limited dataset, fully de-identified). Access request level: tracks requestor name/institution, intended use, IRB approval reference, DUA status, request submission date, review date, approval/denial decision, access dates, expiration, and data destruction certification. Supports research data governance, HIPAA compliance, de-identified data access management, and NIH data sharing policy enforcement. SSOT for research data governance and de-identified data access within the research domain.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`data_access_request` (
    `data_access_request_id` BIGINT COMMENT 'Unique surrogate key for each data access request record.',
    `data_governance_committee_id` BIGINT COMMENT 'Foreign key linking to research.data_governance_committee. Business justification: Data access requests are reviewed and approved by a data governance committee. This connects the data_governance_committee to the domain graph.',
    `deidentified_dataset_id` BIGINT COMMENT 'Foreign key linking to research.deidentified_dataset. Business justification: Data access requests are for specific de-identified datasets. The dataset_name, dataset_description, and dataset_sensitivity_level on data_access_request are redundant with the deidentified_dataset ma',
    `employee_id` BIGINT COMMENT 'System identifier of the individual or entity submitting the request.',
    `access_expiration_timestamp` TIMESTAMP COMMENT 'Date‑time when the granted access rights automatically expire.',
    `access_granted_timestamp` TIMESTAMP COMMENT 'Date‑time when data access was provisioned to the requestor.',
    `approval_decision` STRING COMMENT 'Outcome of the request review process.. Valid values are `approved|denied|conditional`',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    `data_destruction_cert_required` BOOLEAN COMMENT 'Indicates whether the requestor must provide a certificate of data destruction after the retention period.',
    `data_format` STRING COMMENT 'Preferred file format for the delivered dataset.. Valid values are `csv|json|parquet|xml|sas|spss`',
    `data_retention_period_days` STRING COMMENT 'Number of days the requestor may retain the dataset before mandatory destruction.',
    `data_use_agreement_status` STRING COMMENT 'Current status of the signed Data Use Agreement required for access.. Valid values are `pending|signed|rejected|expired`',
    `data_volume_gb` DECIMAL(18,2) COMMENT 'Estimated size of the dataset to be delivered, expressed in gigabytes.',
    `intended_use_description` STRING COMMENT 'Narrative of how the requested data will be used in research or analysis.',
    `irb_approval_date` DATE COMMENT 'Date the IRB granted approval for the research project.',
    `irb_approval_reference` STRING COMMENT 'Identifier of the Institutional Review Board approval governing the request.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or reviewer comments.',
    `request_number` STRING COMMENT 'Human‑readable identifier assigned to the request (e.g., DAR‑2024‑00123).',
    `request_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the request entered the review stage.',
    `request_status` STRING COMMENT 'Lifecycle status of the data access request.. Valid values are `submitted|under_review|approved|denied|revoked|closed`',
    `request_submission_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the data access request was submitted.',
    `requestor_email` STRING COMMENT 'Primary email address of the requestor for communication and notification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_institution` STRING COMMENT 'Affiliated organization, university, or company of the requestor.',
    `requestor_name` STRING COMMENT 'Legal name of the person requesting data access.',
    `requestor_role` STRING COMMENT 'Business role of the requestor within the institution.. Valid values are `researcher|analyst|external_collaborator|student|faculty`',
    `requestor_id` BIGINT COMMENT 'System identifier of the individual or entity submitting the request.',
    `dataset_name` STRING COMMENT 'Descriptive name of the dataset being requested.',
    `dataset_description` STRING COMMENT 'Brief narrative describing the content and purpose of the dataset.',
    `dataset_sensitivity_level` STRING COMMENT 'Classification of the dataset based on privacy and regulatory constraints.. Valid values are `deidentified|limited|restricted|sensitive|public`',
    CONSTRAINT pk_data_access_request PRIMARY KEY(`data_access_request_id`)
) COMMENT 'Tracks requests by researchers, analysts, or external collaborators to access de-identified or limited research datasets. Captures requestor name and institution, requested dataset, intended use, IRB approval reference, data use agreement (DUA) status, request submission date, review date, approval/denial decision, access granted date, access expiration date, and data destruction certification requirement. Supports research data governance, HIPAA compliance, and NIH data sharing policy enforcement.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_budget` (
    `study_budget_id` BIGINT COMMENT 'Unique surrogate key for each study budget record.',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician',
    `primary_study_clinician_id` BIGINT COMMENT 'Identifier of the lead researcher responsible for the study.',
    `research_grant_id` BIGINT COMMENT 'Foreign key linking to research.research_grant. Business justification: Study budgets can be funded by research grants. Links budget to its funding source for financial tracking and compliance.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical study to which this budget applies.',
    `study_sponsor_id` BIGINT COMMENT 'Identifier of the external organization sponsoring the study.',
    `amendment_number` STRING COMMENT 'Sequential number of budget amendments.',
    `amendment_reason` STRING COMMENT 'Explanation for why the budget was amended.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget received formal approval.',
    `budget_approval_status` STRING COMMENT 'Current approval state of the budget.. Valid values are `pending|approved|rejected`',
    `budget_expiration_notice_date` DATE COMMENT 'Date when a notice of upcoming budget expiration was sent.',
    `budget_number` STRING COMMENT 'External identifier assigned to the budget by the research administration.',
    `budget_review_date` DATE COMMENT 'Date of the most recent formal review of the budget.',
    `budget_type` STRING COMMENT 'Category of the budget based on study design.. Valid values are `clinical_trial|observational|preclinical`',
    `confidentiality_level` STRING COMMENT 'Classification of the budgets sensitivity.. Valid values are `public|internal|confidential|restricted`',
    `cost_center_code` STRING COMMENT 'Internal cost center identifier used for accounting allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `effective_from` DATE COMMENT 'Date when the budget becomes binding.',
    `effective_until` DATE COMMENT 'Date when the budget expires or is superseded; null for open‑ended.',
    `funding_source` STRING COMMENT 'Origin of the studys financial support.. Valid values are `federal|industry|institution|philanthropy`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate indirect costs.',
    `is_indirect_costs_included` BOOLEAN COMMENT 'Indicates whether indirect costs are part of the total budget.',
    `notes` STRING COMMENT 'Free‑form notes for additional context or comments.',
    `overhead_rate` DECIMAL(18,2) COMMENT 'Percentage applied to direct costs to cover institutional overhead.',
    `payment_milestone_1_amount` DECIMAL(18,2) COMMENT 'Payment amount tied to the first predefined budget milestone.',
    `payment_milestone_1_due_date` DATE COMMENT 'Date by which the first milestone payment is due.',
    `payment_milestone_2_amount` DECIMAL(18,2) COMMENT 'Payment amount tied to the second predefined budget milestone.',
    `payment_milestone_2_due_date` DATE COMMENT 'Date by which the second milestone payment is due.',
    `payment_milestone_3_amount` DECIMAL(18,2) COMMENT 'Payment amount tied to the third predefined budget milestone.',
    `payment_milestone_3_due_date` DATE COMMENT 'Date by which the third milestone payment is due.',
    `per_procedure_rate` DECIMAL(18,2) COMMENT 'Reimbursement amount for each study‑specific procedure.',
    `per_visit_rate` DECIMAL(18,2) COMMENT 'Reimbursement amount for each patient visit.',
    `screen_failure_allowance` DECIMAL(18,2) COMMENT 'Budgeted amount to cover costs of screened but ineligible participants.',
    `sponsor_contact_email` STRING COMMENT 'Email address of the sponsors primary contact.',
    `sponsor_contact_name` STRING COMMENT 'Name of the primary contact person at the sponsor organization.',
    `sponsor_contact_phone` STRING COMMENT 'Phone number of the sponsors primary contact.',
    `startup_costs` DECIMAL(18,2) COMMENT 'One‑time costs required to initiate the study (e.g., site setup, IRB fees).',
    `study_budget_description` STRING COMMENT 'Narrative description of the budget purpose and scope.',
    `study_budget_status` STRING COMMENT 'Current lifecycle state of the budget.. Valid values are `draft|active|suspended|terminated|closed`',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount approved for the study.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the budget record.',
    `version_number` STRING COMMENT 'Sequential version of the budget document.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical study to which this budget applies.',
    `sponsor_id` BIGINT COMMENT 'Identifier of the external organization sponsoring the study.',
    `principal_investigator_id` BIGINT COMMENT 'Identifier of the lead researcher responsible for the study.',
    `status` STRING COMMENT 'Current lifecycle state of the budget.. Valid values are `draft|active|suspended|terminated|closed`',
    `description` STRING COMMENT 'Narrative description of the budget purpose and scope.',
    `principal_investigator_name` STRING COMMENT 'Full legal name of the principal investigator.',
    `principal_investigator_email` STRING COMMENT 'Email address of the principal investigator.',
    `principal_investigator_phone` STRING COMMENT 'Contact phone number of the principal investigator.',
    `created_by` STRING COMMENT 'User identifier of the person who created the budget record.',
    CONSTRAINT pk_study_budget PRIMARY KEY(`study_budget_id`)
) COMMENT 'Captures the negotiated and approved budget for a sponsored clinical trial or research study, including per-visit reimbursement rates, per-procedure rates, startup costs, overhead/indirect costs, screen failure allowances, and payment milestones. Tracks budget version, sponsor-negotiated amounts versus institutional costs, budget approval date, and payment schedule terms. Distinct from grant_expenditure (actuals) — this is the prospective budget and rate card for the study. Supports research finance and sponsor invoicing.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`consent_template` (
    `consent_template_id` BIGINT COMMENT 'System-generated unique identifier for the consent template record.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the template record.',
    `previous_version_consent_template_id` BIGINT COMMENT 'Link to the immediate prior version of the template, if any.',
    `primary_employee_id` BIGINT COMMENT 'Identifier of the system user who last updated the template record.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical research study that uses this consent template.',
    `amendment_number` STRING COMMENT 'Sequential number of amendments applied to this version.',
    `approval_status` STRING COMMENT 'Current IRB review status of the template.. Valid values are `pending|approved|rejected`',
    `confidentiality_level` STRING COMMENT 'Indicates the sensitivity classification of the template content.. Valid values are `public|internal|confidential`',
    `consent_form_type` STRING COMMENT 'Classification of the consent form (full ICF, short form, assent, HIPAA authorization).. Valid values are `full|short|assent|hipaa_authorization`',
    `consent_template_status` STRING COMMENT 'Current lifecycle state of the template.. Valid values are `draft|active|superseded|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the template record was first created in the system.',
    `document_format` STRING COMMENT 'File format of the stored template document.. Valid values are `pdf|docx|html`',
    `document_url` STRING COMMENT 'Secure storage location (e.g., S3 URI) of the template file.',
    `effective_end_date` DATE COMMENT 'Date the template expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date the template becomes valid for use in a study.',
    `electronic_signature_required` BOOLEAN COMMENT 'Indicates whether the template mandates an electronic signature.',
    `file_hash` STRING COMMENT 'SHA‑256 hash of the stored document for integrity verification.. Valid values are `^[a-fA-F0-9]{64}$`',
    `irb_approval_date` DATE COMMENT 'Date the Institutional Review Board approved the template.',
    `is_current_version` BOOLEAN COMMENT 'True if this record represents the active version of the template.',
    `language_code` STRING COMMENT 'Two‑letter code indicating the language of the template.. Valid values are `^[a-z]{2}$`',
    `part_11_compliant` BOOLEAN COMMENT 'True if the template meets FDA 21 CFR Part 11 electronic record requirements.',
    `required_elements_checklist` STRING COMMENT 'Structured list of mandatory elements (e.g., signature line, study description) required by regulations.',
    `retention_annotation` STRING COMMENT 'Notes on regulatory retention requirements (e.g., HIPAA, FDA).',
    `retention_period_days` STRING COMMENT 'Number of days the template must be retained to satisfy HIPAA/21 CFR Part 11.',
    `sponsor_name` STRING COMMENT 'Name of the organization sponsoring the study linked to the template.',
    `template_description` STRING COMMENT 'Clean boilerplate phrase from description',
    `template_name` STRING COMMENT 'Human‑readable title of the consent form template.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the template record.',
    `version_notes` STRING COMMENT 'Free‑text notes describing changes made in this version.',
    `version_number` STRING COMMENT 'Sequential version number of the template; increments with each amendment.',
    `status` STRING COMMENT 'Current lifecycle state of the template.. Valid values are `draft|active|superseded|retired`',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who created the template record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the system user who last updated the template record.',
    `previous_version_id` BIGINT COMMENT 'Link to the immediate prior version of the template, if any.',
    `study_id` BIGINT COMMENT 'Identifier of the clinical research study that uses this consent template.',
    CONSTRAINT pk_consent_template PRIMARY KEY(`consent_template_id`)
) COMMENT 'Reference master for IRB-approved informed consent form (ICF) templates associated with a study, capturing template version number, IRB approval date, expiration date, language version, consent form type (full ICF, short form, assent form, HIPAA authorization), required elements checklist, and template status (draft, IRB-approved, superseded). Distinct from informed_consent (the subject-level transactional record) — this is the document template/version master. Supports consent version control and ensures subjects are consented on the current IRB-approved version.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_arm` (
    `study_arm_id` BIGINT COMMENT 'Unique surrogate key for the study arm record.',
    `protocol_id` BIGINT COMMENT 'Identifier of the clinical trial protocol to which this arm belongs.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Study arms define treatment groups within a clinical trial protocol. An arm belongs to a specific research study. Currently only linked via protocol_id to radiology.protocol which is indirect.',
    `actual_enrollment` STRING COMMENT 'Number of participants actually assigned to this arm.',
    `arm_code` STRING COMMENT 'Business identifier or code assigned to the arm by the sponsor or protocol.',
    `arm_name` STRING COMMENT 'Human‑readable name of the treatment arm (e.g., "Arm A – High Dose").',
    `arm_sequence` STRING COMMENT 'Ordinal position of the arm within the protocol definition.',
    `arm_type` STRING COMMENT 'Classification of the arm based on its role in the trial.. Valid values are `experimental|active_comparator|placebo|sham|observational`',
    `blinding` STRING COMMENT 'Level of blinding applied to the arm (e.g., open, single, double).. Valid values are `open|single|double|triple`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the arm record was first created in the system.',
    `dose_level` STRING COMMENT 'Dose amount and unit for drug‑based interventions (e.g., "10 mg").',
    `eligibility_criteria_summary` STRING COMMENT 'Brief summary of inclusion/exclusion criteria specific to this arm.',
    `end_date` DATE COMMENT 'Date on which the arm is closed to enrollment or completed.',
    `exclusion_criteria_summary` STRING COMMENT 'High‑level description of exclusion criteria for participants in this arm.',
    `inclusion_criteria_summary` STRING COMMENT 'High‑level description of inclusion criteria for participants in this arm.',
    `intervention_description` STRING COMMENT 'Narrative description of the therapeutic or procedural intervention applied in this arm.',
    `intervention_type` STRING COMMENT 'Broad category of the intervention delivered in this arm.. Valid values are `drug|device|procedure|behavioral|biologic`',
    `planned_enrollment` STRING COMMENT 'Target number of participants intended for this arm.',
    `randomization_ratio` STRING COMMENT 'Ratio used to randomize participants into this arm (e.g., "1:1").. Valid values are `^d+:d+$`',
    `start_date` DATE COMMENT 'Date on which the arm becomes active for enrollment.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., "Closed due to safety concern").',
    `stratification_factors` STRING COMMENT 'Comma‑separated list of stratification variables used for this arm (e.g., "Age>65,Sex=Male").',
    `study_arm_status` STRING COMMENT 'Current lifecycle status of the arm.. Valid values are `open|closed|suspended|paused|completed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the arm record.',
    `status` STRING COMMENT 'Current lifecycle status of the arm.. Valid values are `open|closed|suspended|paused|completed`',
    CONSTRAINT pk_study_arm PRIMARY KEY(`study_arm_id`)
) COMMENT 'Defines the treatment arms, cohorts, or groups within a clinical trial protocol, including arm name, arm type (experimental, active comparator, placebo, sham, observational), planned enrollment per arm, randomization ratio, dose level or intervention description, and arm status (open, closed, suspended). Supports randomization management, stratified enrollment tracking, and protocol-defined subgroup analyses. A study may have 2–10+ arms; this entity provides the reference structure for subject_enrollment arm assignments.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_partner_agreement` (
    `study_partner_agreement_id` BIGINT COMMENT 'Surrogate primary key for the study partner agreement record.',
    `organization_id` BIGINT COMMENT 'Identifier of the external trading partner.',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study linked to this agreement.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the agreement.',
    `agreement_type` STRING COMMENT 'Category of the agreement defining its primary purpose.. Valid values are `data_sharing|service_provision|financial|collaboration`',
    `amendment_count` STRING COMMENT 'Number of amendments made to the agreement.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates if audit logging is required for data exchanges under this agreement.',
    `compliance_requirements` STRING COMMENT 'Regulatory compliance frameworks applicable to the agreement.. Valid values are `hipaa|gdpr|ccpa|none`',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality required for data exchange.. Valid values are `high|medium|low`',
    `contract_signed_by` STRING COMMENT 'Name of the individual who signed the agreement on behalf of the organization.',
    `contract_signed_date` DATE COMMENT 'Date the agreement was formally signed by both parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was created in the system.',
    `data_access_approval_required` BOOLEAN COMMENT 'Whether each data request must be approved.',
    `data_access_endpoint` STRING COMMENT 'Network endpoint or URL where data can be accessed.',
    `data_format` STRING COMMENT 'File or message format for data exchange.. Valid values are `json|xml|csv|hl7|fhir`',
    `data_quality_assurance` BOOLEAN COMMENT 'Indicates if data quality checks are mandated.',
    `data_retention_policy` STRING COMMENT 'Reference to the policy governing data retention for this agreement.',
    `data_sharing_scope` STRING COMMENT 'Extent of data shared under the agreement.. Valid values are `full|partial|de_identified|aggregated`',
    `data_transfer_method` STRING COMMENT 'Technical method used to transfer data.. Valid values are `api|sftp|ftp|email|physical_media`',
    `data_use_limitations` STRING COMMENT 'Restrictions on how shared data may be used.',
    `effective_end_date` DATE COMMENT 'Date the agreement ends or expires; null if open-ended.',
    `effective_start_date` DATE COMMENT 'Date the agreement becomes binding.',
    `encryption_required` BOOLEAN COMMENT 'Indicates if data must be encrypted in transit and at rest.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating if the agreement is marked confidential.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment.',
    `notes` STRING COMMENT 'Free-text field for additional comments or notes.',
    `partner_contact_email` STRING COMMENT 'Email address of the partners primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `partner_contact_name` STRING COMMENT 'Primary contact person name for the partner organization.',
    `partner_contact_phone` STRING COMMENT 'Phone number of the partners primary contact.',
    `partner_role` STRING COMMENT 'Role of the partner in the study (e.g., sponsor, CRO, lab).. Valid values are `sponsor|contract_research_organization|central_lab|imaging_core|data_coordinating_center|other`',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was granted.',
    `regulatory_approval_status` STRING COMMENT 'Status of any regulatory approvals required for the data sharing.. Valid values are `approved|pending|rejected|not_required`',
    `retention_period_days` STRING COMMENT 'Number of days data must be retained per agreement.',
    `sla_end_date` DATE COMMENT 'Date SLA obligations terminate.',
    `sla_start_date` DATE COMMENT 'Date SLA obligations commence.',
    `sla_terms` STRING COMMENT 'Textual description of SLA commitments.',
    `study_partner_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `termination_reason` STRING COMMENT 'Reason for agreement termination, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `version_number` STRING COMMENT 'Version of the agreement document.',
    `status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `study_id` BIGINT COMMENT 'Identifier of the research study linked to this agreement.',
    `partner_id` BIGINT COMMENT 'Identifier of the external trading partner.',
    CONSTRAINT pk_study_partner_agreement PRIMARY KEY(`study_partner_agreement_id`)
) COMMENT 'This association product represents the data sharing and interoperability agreement between a research study and an external trading partner. It captures the operational relationship when a trading partner (sponsor CRO, central lab, imaging core, data coordinating center) participates in a multi-site clinical trial. Each record links one research study to one trading partner with attributes that govern the data exchange, service level agreements, and operational status specific to that study-partner collaboration.. Existence Justification: Multi-site clinical trials operationally engage multiple external trading partners (sponsor CROs, central labs, imaging cores, data coordinating centers) for data exchange, lab services, and study coordination. Each research study has multiple trading partners serving different roles, and each trading partner supports multiple concurrent studies. The business actively manages these study-partner relationships with specific data sharing agreements, SLAs, message volume tracking, and role assignments per study-partner pair.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`grant_personnel` (
    `grant_personnel_id` BIGINT COMMENT 'Unique surrogate key for the grant personnel assignment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to the grant.',
    `research_grant_id` BIGINT COMMENT 'Identifier of the research grant.',
    `allocation_end_date` DATE COMMENT 'Date when the employees effort on the grant ends.',
    `allocation_start_date` DATE COMMENT 'Date when the employees effort on the grant begins.',
    `allocation_type` STRING COMMENT 'Classification of the effort allocation (e.g., new award, renewal, supplemental).. Valid values are `new|renewal|supplemental|extension`',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Monetary amount representing the cost‑share portion for this assignment.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of the grant cost that the employees institution is required to share.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was first created.',
    `effort_description` STRING COMMENT 'Narrative description of the work performed under the grant.',
    `effort_fte` DECIMAL(18,2) COMMENT 'Full‑time‑equivalent effort allocated to the grant.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'Portion of the employees total effort allocated to the grant, expressed as a percent.',
    `effort_type` STRING COMMENT 'Indicates whether the allocation is salary‑based, effort‑based, or both.. Valid values are `salary|effort|both`',
    `funding_source` STRING COMMENT 'Source of the grant funding.. Valid values are `federal|state|private|industry|institutional`',
    `grant_personnel_status` STRING COMMENT 'Current lifecycle status of the grant personnel assignment.. Valid values are `active|inactive|pending|terminated`',
    `is_co_pi` BOOLEAN COMMENT 'True if the employee serves as a co‑principal investigator.',
    `is_primary_investigator` BOOLEAN COMMENT 'True if the employee is the principal investigator for the grant.',
    `is_subaward` BOOLEAN COMMENT 'True if the grant is a subaward under a larger award.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the assignment.',
    `role_on_grant` STRING COMMENT 'Business role of the employee within the grant (e.g., principal investigator, co‑investigator).. Valid values are `pi|co_pi|investigator|coordinator|admin|other`',
    `salary_allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of salary charged to the grant for the allocated effort.',
    `updated_by` STRING COMMENT 'User identifier who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the record.',
    `grant_id` BIGINT COMMENT 'Identifier of the research grant.',
    `status` STRING COMMENT 'Current lifecycle status of the grant personnel assignment.. Valid values are `active|inactive|pending|terminated`',
    `created_by` STRING COMMENT 'User identifier who created the record.',
    CONSTRAINT pk_grant_personnel PRIMARY KEY(`grant_personnel_id`)
) COMMENT 'This association product represents the personnel assignment relationship between employees and research grants. It captures effort allocation, salary distribution, and cost-share commitments required for federal effort reporting (SF-424, PHS 398), NIH/NSF grant administration, and OMB Uniform Guidance compliance. Each record links one employee to one grant with attributes that exist only in the context of this funding relationship, including role on the grant, effort percentage, appointment dates, and financial allocations.. Existence Justification: In healthcare research operations, employees (clinical staff, researchers, analysts) are routinely assigned to multiple concurrent grants with different effort allocations, roles, and salary distributions. Simultaneously, each grant funds multiple personnel including the PI, co-investigators, research coordinators, and support staff. Grant personnel assignments are actively managed operational records that research administrators create, update, and track for federal effort reporting, cost accounting, and compliance purposes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`investigational_product_training` (
    `investigational_product_training_id` BIGINT COMMENT 'System-generated unique identifier for each investigational product training record.',
    `education_program_id` BIGINT COMMENT 'Identifier of the training program linked to the investigational product.',
    `investigational_product_id` BIGINT COMMENT 'Identifier of the investigational product associated with the training.',
    `certification_date` DATE COMMENT 'Date when the product was first certified for the training program.',
    `certification_expiration_date` DATE COMMENT 'Date when the certification expires and must be renewed.',
    `certification_status` STRING COMMENT 'Current status of the products certification for the training program.. Valid values are `active|inactive|expired|pending`',
    `competency_verification_date` DATE COMMENT 'Date when competency verification was performed.',
    `competency_verified` BOOLEAN COMMENT 'Indicates whether staff competency for handling the product has been verified.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the training record.',
    `recertification_due_date` DATE COMMENT 'Date by which recertification must be completed to maintain compliance.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the training record was initially created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training record.',
    `trainer_contact_email` STRING COMMENT 'Email address of the trainer for communication and record‑keeping.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `trainer_name` STRING COMMENT 'Full name of the individual who delivered the training.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted.',
    `training_mode` STRING COMMENT 'Delivery method of the training session.. Valid values are `in_person|online|virtual|blended`',
    `training_type` STRING COMMENT 'Category of training required for the investigational product.. Valid values are `handling|administration|storage|safety|regulatory`',
    `training_version` STRING COMMENT 'Version identifier of the training curriculum applied to the product.',
    `training_program_id` BIGINT COMMENT 'Identifier of the training program linked to the investigational product.',
    CONSTRAINT pk_investigational_product_training PRIMARY KEY(`investigational_product_training_id`)
) COMMENT 'This association product represents the training certification relationship between investigational products and compliance training programs. It captures product-specific training requirements, competency verification, and certification status for staff handling investigational products in clinical trials. Each record links one investigational product to one training program with attributes tracking certification dates, competency verification, training version compliance, and recertification schedules specific to that product-training combination.. Existence Justification: In clinical trial operations, investigational products require multiple types of training (handling hazardous materials, administering complex dosage forms, storage/temperature monitoring, controlled substance protocols), and each training program applies to multiple investigational products with similar characteristics. The business actively manages product-specific training certifications as operational records, tracking which staff are certified to handle which products, with certification dates, competency verification, and recertification schedules that exist only in the context of each product-training combination.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`dua_document` (
    `dua_document_id` BIGINT COMMENT 'Unique surrogate key for the DUA document.',
    `data_access_request_id` BIGINT COMMENT 'Foreign key linking to research.data_access_request. Business justification: DUA documents are generated as part of data access request workflows. Researcher info is redundant with the requestor info on data_access_request.',
    `deidentified_dataset_id` BIGINT COMMENT 'Foreign key linking to research.deidentified_dataset. Business justification: DUA documents govern access to specific de-identified datasets. A DUA specifies which dataset is covered by the agreement.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Data Use Agreements can be tied to a specific research study for which data is being shared. Connects dua_document to the domain hub.',
    `agreement_type` STRING COMMENT 'Classification of the agreement type.. Valid values are `research|clinical|data_sharing|collaboration`',
    `amendment_number` STRING COMMENT 'Sequential number of amendments applied to the DUA.',
    `approved_by` STRING COMMENT 'Name of the user who approved the DUA.',
    `audit_trail` STRING COMMENT 'JSON‑encoded log of key actions performed on the DUA (creation, updates, approvals).',
    `authorized_data_categories` STRING COMMENT 'Comma‑separated list of data categories permitted under the DUA (e.g., PHI, de‑identified data).',
    `compliance_requirements` STRING COMMENT 'Regulatory or policy requirements the DUA must satisfy (e.g., HIPAA, GDPR).',
    `confidentiality_level` STRING COMMENT 'Sensitivity classification of the data covered by the DUA.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DUA record was first created in the system.',
    `data_purpose` STRING COMMENT 'Business or research purpose for which the data may be used.',
    `data_retention_period` STRING COMMENT 'Number of days data covered by the DUA must be retained before disposal.',
    `data_subjects` STRING COMMENT 'Description of the individuals whose data is covered by the DUA.',
    `digital_signature_hash` STRING COMMENT 'Cryptographic hash of the electronic signature for integrity verification.',
    `document_number` STRING COMMENT 'External business identifier assigned to the DUA document, often used in contracts and audits.',
    `dua_document_description` STRING COMMENT 'Free-text description of the data use agreement scope and purpose',
    `dua_document_status` STRING COMMENT 'Current lifecycle status of the DUA.. Valid values are `draft|active|suspended|terminated|expired`',
    `dua_text` STRING COMMENT 'description',
    `effective_end_date` DATE COMMENT 'Date on which the DUA expires or terminates (nullable for open‑ended agreements).',
    `effective_start_date` DATE COMMENT 'Date on which the DUA becomes binding.',
    `parties_involved` STRING COMMENT 'Names of the legal entities participating in the DUA.',
    `renewal_option` STRING COMMENT 'Whether the DUA renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `restrictions` STRING COMMENT 'Specific usage restrictions or prohibitions (e.g., no re‑identification).',
    `signature_method` STRING COMMENT 'Method used to capture signatures for the DUA.. Valid values are `electronic|wet_ink|none`',
    `signed_date` DATE COMMENT 'Date on which the DUA was signed by all parties.',
    `termination_clause` STRING COMMENT 'Text describing conditions under which the DUA may be terminated.',
    `title` STRING COMMENT 'Descriptive title of the DUA document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DUA record.',
    `version_number` STRING COMMENT 'Version identifier for the DUA document.',
    `description` STRING COMMENT 'Free‑text description summarizing the purpose and scope of the DUA.',
    `status` STRING COMMENT 'Current lifecycle status of the DUA.. Valid values are `draft|active|suspended|terminated|expired`',
    `researcher_name` STRING COMMENT 'Full legal name of the primary researcher or data requestor.',
    `researcher_email` STRING COMMENT 'Primary email address of the researcher.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `researcher_phone` STRING COMMENT 'Contact phone number for the researcher.',
    `institution_name` STRING COMMENT 'Name of the research institution or organization.',
    `created_by` STRING COMMENT 'Name of the user who created the DUA record.',
    CONSTRAINT pk_dua_document PRIMARY KEY(`dua_document_id`)
) COMMENT 'Master reference table for dua_document. Referenced by dua_document_id.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` (
    `data_governance_committee_id` BIGINT COMMENT 'Unique surrogate key for each data governance committee record.',
    `chairperson_email` STRING COMMENT 'Primary email address for the committee chairperson.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `chairperson_name` STRING COMMENT 'Legal name of the committee chairperson.',
    `charter_document_url` STRING COMMENT 'Link to the digital charter or governance document for the committee.',
    `committee_code` STRING COMMENT 'External or legacy code used to reference the committee in enterprise systems.',
    `committee_name` STRING COMMENT 'Cleaned boilerplate phrases from attribute descriptions.',
    `committee_type` STRING COMMENT 'Categorizes the committee by its primary governance function.. Valid values are `irb|data_access|safety|ethics|compliance`',
    `contact_phone` STRING COMMENT 'Main telephone number for reaching the committee.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the committee record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification of the committees data assets according to enterprise policy.. Valid values are `public|internal|confidential|restricted|secret`',
    `data_governance_committee_status` STRING COMMENT 'Current lifecycle status of the committee.. Valid values are `active|inactive|pending|retired`',
    `data_retention_years` STRING COMMENT 'Number of years the committees records must be retained per regulatory policy.',
    `effective_from` DATE COMMENT 'Date when the committees charter becomes effective.',
    `effective_until` DATE COMMENT 'Date when the committees charter expires or is superseded (null if open‑ended).',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the committees deliberations are marked confidential.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the committee record.',
    `meeting_day_of_week` STRING COMMENT 'Standard day of the week on which the committee meets.. Valid values are `Mon|Tue|Wed|Thu|Fri|Sat`',
    `meeting_frequency` STRING COMMENT 'How often the committee convenes.. Valid values are `weekly|biweekly|monthly|quarterly|annually`',
    `meeting_minutes_summary` STRING COMMENT 'Summary of committee meeting minutes including key decisions and action items',
    `meeting_time` TIMESTAMP COMMENT 'Local time of day when the committee meeting starts (24‑hour format).',
    `member_count` STRING COMMENT 'Current number of active members on the committee.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, observations, or audit comments.',
    `status` STRING COMMENT 'Current lifecycle status of the committee.. Valid values are `active|inactive|pending|retired`',
    CONSTRAINT pk_data_governance_committee PRIMARY KEY(`data_governance_committee_id`)
) COMMENT 'Master reference table for data_governance_committee. Referenced by data_governance_committee_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`dsmb_committee` (
    `dsmb_committee_id` BIGINT COMMENT 'Unique surrogate identifier for the DSMB committee record.',
    `chairperson_email` STRING COMMENT 'Primary email address for the chairperson.',
    `chairperson_name` STRING COMMENT 'Legal name of the committee chairperson.',
    `chairperson_phone` STRING COMMENT 'Contact telephone number for the chairperson.',
    `charter_document_path` STRING COMMENT 'File system or URL location of the official charter document for the committee.',
    `committee_code` STRING COMMENT 'Business identifier or code assigned to the committee by the sponsoring organization.',
    `committee_name` STRING COMMENT 'Human‑readable name of the DSMB committee.',
    `committee_type` STRING COMMENT 'Classification of the committee based on its primary focus (e.g., safety monitoring, efficacy review, data oversight, ethics).. Valid values are `safety|efficacy|data|ethics`',
    `compliance_notes` STRING COMMENT 'Free‑text notes regarding compliance observations, audit findings, or corrective actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the committee record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy statement describing how long committee‑related data must be retained.',
    `dsmb_committee_description` STRING COMMENT 'Narrative description of the committee’s purpose, scope, and responsibilities.',
    `dsmb_committee_status` STRING COMMENT 'Current lifecycle status of the committee.. Valid values are `active|inactive|suspended|pending`',
    `effective_end_date` DATE COMMENT 'Date on which the committee was formally dissolved or retired (null if still active).',
    `effective_start_date` DATE COMMENT 'Date on which the committee became officially active.',
    `hipaa_retention_annotation` STRING COMMENT 'Added Unity Catalog tag: hipaa_retention_annotation=7 years',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the committee’s records are classified as confidential under organizational policy.',
    `is_virtual` BOOLEAN COMMENT 'Flag indicating whether the committee conducts meetings exclusively in a virtual format.',
    `last_meeting_date` DATE COMMENT 'Date of the most recent committee meeting.',
    `meeting_frequency` STRING COMMENT 'Standard recurrence interval for committee meetings.. Valid values are `weekly|monthly|quarterly|annually`',
    `meeting_location` STRING COMMENT 'Physical location where the committee meets (if not virtual).',
    `meeting_time_zone` STRING COMMENT 'Time‑zone identifier (e.g., America/New_York) for scheduled meetings.',
    `member_count` STRING COMMENT 'Current number of voting members on the committee.',
    `minutes_document_path` STRING COMMENT 'File system or URL location of the recorded minutes from the most recent meeting.',
    `next_meeting_date` DATE COMMENT 'Scheduled date of the upcoming committee meeting.',
    `regulatory_approval_status` STRING COMMENT 'Current status of the committee’s approval by regulatory bodies (e.g., FDA, IRB).. Valid values are `approved|pending|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the committee record.',
    `virtual_meeting_link` STRING COMMENT 'URL or dial‑in information for virtual committee meetings.',
    `status` STRING COMMENT 'Current lifecycle status of the committee.. Valid values are `active|inactive|suspended|pending`',
    `description` STRING COMMENT 'Narrative description of the committee’s purpose, scope, and responsibilities.',
    CONSTRAINT pk_dsmb_committee PRIMARY KEY(`dsmb_committee_id`)
) COMMENT 'Master reference table for dsmb_committee. Referenced by dsmb_committee_id.';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`research_document` (
    `research_document_id` BIGINT COMMENT 'Unique identifier for the research document.',
    `research_study_id` BIGINT COMMENT 'Identifier of the study to which the document belongs.',
    `protocol_id` BIGINT COMMENT 'Identifier of the research protocol associated with the document.',
    `study_sponsor_id` BIGINT COMMENT 'Unique identifier for the sponsoring organization.',
    `trial_id` BIGINT COMMENT 'Identifier of a related clinical trial referenced by the document.',
    `abstract` STRING COMMENT 'Brief summary of the document content.',
    `access_level` STRING COMMENT 'Access level required to view the document.. Valid values are `internal|external|restricted`',
    `author_affiliation` STRING COMMENT 'Institution or organization the author is affiliated with.',
    `author_email` STRING COMMENT 'Email address of the document author.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `author_name` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `checksum` STRING COMMENT 'SHA256 checksum of the document file for integrity verification.',
    `classification` STRING COMMENT 'Security classification of the document.. Valid values are `public|restricted|confidential|internal`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the document (e.g., 21 CFR Part 11).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was created.',
    `data_retention_policy` STRING COMMENT 'Policy describing how long the document must be retained.',
    `deprecated_reason` STRING COMMENT 'Explanation for why the document was deprecated.',
    `document_format` STRING COMMENT 'File format of the stored document.. Valid values are `PDF|DOCX|HTML|TXT|Other`',
    `document_language` STRING COMMENT 'Primary language of the document content.. Valid values are `English|Spanish|French|German|Chinese|Other`',
    `document_source_system` STRING COMMENT 'Originating system that created or stored the document (e.g., Epic, Cerner).',
    `document_type` STRING COMMENT 'Category of the document, such as protocol, consent form, report, etc.. Valid values are `protocol|consent|report|analysis|summary|other`',
    `doi` STRING COMMENT 'DOI assigned to the document for citation and discovery.',
    `effective_date` DATE COMMENT 'Date when the document becomes effective.',
    `ethics_review_status` STRING COMMENT 'Current status of the ethics review.. Valid values are `approved|pending|rejected`',
    `expiration_date` DATE COMMENT 'Date when the document expires or is no longer valid (nullable).',
    `external_reference_code` STRING COMMENT 'Identifier used in external systems to reference the document (e.g., external DB ID).',
    `file_path` STRING COMMENT 'Path to the stored file for the document.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `irb_approval_date` DATE COMMENT 'Date when the IRB approved the document.',
    `irb_approval_number` STRING COMMENT 'Institutional Review Board approval number for the document.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the document contains confidential information.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the document has been deprecated.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords describing the document.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the document.',
    `notes` STRING COMMENT 'Free-form notes related to the document.',
    `research_document_description` STRING COMMENT 'Free-text description of the research document content and purpose',
    `research_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|active|archived|retracted`',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per policy.',
    `reviewed_by_email` STRING COMMENT 'Email address of the reviewer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reviewed_by_name` STRING COMMENT 'Full name of the person who performed the last review.',
    `title` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version_number` STRING COMMENT 'Version identifier for the document.',
    `status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|active|archived|retracted`',
    `sponsor_name` STRING COMMENT 'Name of the organization sponsoring the research.',
    `sponsor_id` BIGINT COMMENT 'Unique identifier for the sponsoring organization.',
    `study_id` BIGINT COMMENT 'Identifier of the study to which the document belongs.',
    `related_study_id` BIGINT COMMENT 'Identifier of a related study referenced by the document.',
    `related_trial_id` BIGINT COMMENT 'Identifier of a related clinical trial referenced by the document.',
    `description` STRING COMMENT 'Detailed description of the document content and purpose.',
    `external_reference_id` STRING COMMENT 'Identifier used in external systems to reference the document (e.g., external DB ID).',
    CONSTRAINT pk_research_document PRIMARY KEY(`research_document_id`)
) COMMENT 'Master reference table for research_document. Referenced by meeting_minutes_document_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`research_grant_record` (
    `research_grant_record_id` BIGINT COMMENT 'Primary key for research_grant_record',
    `clinician_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for the scientific and technical direction of the research project.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or clinical department administering the grant within the institution.',
    `research_grant_id` BIGINT COMMENT 'Foreign key linking to research.research_grant. Business justification: research_grant_record appears to be a detailed record/version of research_grant. Linking them enables traceability between the record and the master grant entity.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Research grants fund specific studies. The research_grant_record has irb_protocol_number and clinical_trial_flag indicating study association. Connects this product to the domain hub.',
    `award_date` DATE COMMENT 'Date on which the grant was officially awarded by the funding agency, establishing the formal start of the award relationship.',
    `budget_period_number` STRING COMMENT 'Current budget period (year) number within the total project period (e.g., year 3 of a 5-year grant).',
    `cfda_number` STRING COMMENT 'Federal program identification number from the Assistance Listings (formerly CFDA) used for federal grant tracking and Single Audit compliance.',
    `clinical_trial_flag` BOOLEAN COMMENT 'Indicates whether the grant funds a clinical trial as defined by NIH, requiring registration on ClinicalTrials.gov.',
    `closeout_date` DATE COMMENT 'Date on which the grant was formally closed out with all final reports submitted and financial reconciliation completed.',
    `compliance_status` STRING COMMENT 'Current compliance status of the grant with respect to sponsor terms, institutional policies, and federal regulations.',
    `conflict_of_interest_disclosed` BOOLEAN COMMENT 'Indicates whether all required financial conflict of interest disclosures have been completed for key personnel on this grant.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Total institutional cost sharing or matching funds committed to the grant as required by the sponsor.',
    `cost_sharing_required` BOOLEAN COMMENT 'Indicates whether the grant requires mandatory cost sharing or matching funds from the institution as a condition of the award.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this grant (e.g., USD).',
    `current_year_budget` DECIMAL(18,2) COMMENT 'Approved budget amount for the current fiscal/budget year of the grant, representing the annual funding allocation.',
    `data_sharing_plan_required` BOOLEAN COMMENT 'Indicates whether the grant requires a data management and sharing plan per NIH DMS Policy or sponsor requirements.',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Total direct costs budgeted for the grant, including personnel, supplies, equipment, travel, and other costs directly attributable to the research project.',
    `effective_end_date` DATE COMMENT 'Date on which the grant period of performance ends. May be extended via no-cost extension. Nullable for open-ended awards.',
    `effective_start_date` DATE COMMENT 'Date on which the grant period of performance begins and expenditures become allowable under the award terms.',
    `effort_percent_pi` DECIMAL(18,2) COMMENT 'Percentage of the principal investigators professional effort committed to this grant, used for effort reporting and salary cap compliance.',
    `fda_regulated` BOOLEAN COMMENT 'Indicates whether the research involves FDA-regulated products (drugs, devices, biologics) requiring IND/IDE compliance.',
    `funding_agency_name` STRING COMMENT 'Name of the external organization or government agency providing the grant funding (e.g., NIH, NSF, AHRQ, PCORI, private foundation).',
    `funding_mechanism` STRING COMMENT 'Specific funding mechanism or activity code under which the grant is awarded (e.g., R01, R21, U01, K23, T32, P30). Determines allowable costs and reporting requirements.',
    `grant_account_code` STRING COMMENT 'Internal financial account code or fund code assigned to the grant in the institutions general ledger for expenditure tracking.',
    `grant_number` STRING COMMENT 'Externally-assigned unique grant identifier issued by the funding agency (e.g., NIH grant number, NSF award number). Used for regulatory reporting and financial tracking.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the grant indicating its operational state within the research administration workflow.',
    `grant_type` STRING COMMENT 'Classification of the grant by funding source category, used for financial reporting and compliance segmentation.',
    `human_subjects_involved` BOOLEAN COMMENT 'Indicates whether the research involves human subjects, triggering IRB oversight and informed consent requirements.',
    `iacuc_protocol_number` STRING COMMENT 'IACUC protocol number for animal research conducted under this grant, required for compliance with PHS Policy on Humane Care.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Total indirect (F&A) costs budgeted for the grant, representing institutional overhead recovery for facilities and administration.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated facilities and administrative (F&A) cost rate applied to the grant for overhead recovery, expressed as a decimal (e.g., 0.5500 for 55%).',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number associated with the human subjects research conducted under this grant, required for compliance with 45 CFR 46.',
    `multi_site_flag` BOOLEAN COMMENT 'Indicates whether the research is conducted across multiple institutional sites, requiring coordinated oversight.',
    `next_report_due_date` DATE COMMENT 'Date by which the next progress report or financial report must be submitted to the funding agency.',
    `no_cost_extension_end_date` DATE COMMENT 'Extended end date granted through a no-cost extension, allowing additional time to complete research without additional funding.',
    `notes` STRING COMMENT 'Free-text notes and comments related to the grant administration, special conditions, or institutional considerations.',
    `patent_filed_count` STRING COMMENT 'Number of patent applications filed as a result of inventions made under this grant, tracked for Bayh-Dole Act compliance.',
    `publication_count` STRING COMMENT 'Number of peer-reviewed publications resulting from research funded by this grant, used for productivity tracking and reporting.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was first created in the research administration system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was last modified, supporting audit trail and SCD Type 2 tracking.',
    `reporting_frequency` STRING COMMENT 'Required frequency of progress and financial reporting to the funding agency as specified in the award terms.',
    `research_category` STRING COMMENT 'Classification of the research type funded by the grant, used for institutional reporting and strategic research portfolio analysis.',
    `salary_cap_applicable` BOOLEAN COMMENT 'Indicates whether the NIH or sponsor salary cap applies to personnel costs on this grant, affecting allowable compensation charges.',
    `sponsor_award_number` STRING COMMENT 'Award number assigned by the sponsoring agency, which may differ from the internal grant number. Used for external correspondence and compliance reporting.',
    `sponsor_contact_email` STRING COMMENT 'Email address of the funding agency program officer or grants management specialist for correspondence.',
    `sponsor_contact_name` STRING COMMENT 'Name of the program officer or grants management specialist at the funding agency responsible for this award.',
    `subrecipient_flag` BOOLEAN COMMENT 'Indicates whether the grant includes subawards to other institutions, triggering additional monitoring and reporting requirements.',
    `therapeutic_area` STRING COMMENT 'Primary disease or therapeutic area targeted by the research (e.g., oncology, cardiology, neurology, infectious disease).',
    `title` STRING COMMENT 'Official title of the research grant as submitted in the grant application and recorded by the funding agency.',
    `total_awarded_amount` DECIMAL(18,2) COMMENT 'Total monetary value awarded by the funding agency for the entire project period across all budget years.',
    `total_project_periods` STRING COMMENT 'Total number of budget periods (years) approved for the grant project, defining the overall project duration.',
    CONSTRAINT pk_research_grant_record PRIMARY KEY(`research_grant_record_id`)
) COMMENT 'Renamed to avoid SQL reserved word';

CREATE OR REPLACE TABLE `healthcare_ecm_v1`.`research`.`research_grant` (
    `research_grant_id` BIGINT COMMENT 'Primary key for research_grant',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or institution where the grant research is primarily conducted.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or clinical department administering the grant.',
    `clinician_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for the scientific and technical direction of the grant.',
    `research_co_investigator_clinician_id` BIGINT COMMENT 'Identifier of the co-principal investigator sharing responsibility for the grants scientific direction.',
    `award_amount` DECIMAL(18,2) COMMENT 'Total dollar amount awarded for the entire grant period, including all budget years.',
    `award_date` DATE COMMENT 'Date the Notice of Award (NOA) was issued by the funding agency.',
    `cfda_number` STRING COMMENT 'CFDA number (now Assistance Listing Number) identifying the federal program under which the grant is funded. Required for federal grants per OMB Uniform Guidance.',
    `clinical_trial_flag` BOOLEAN COMMENT 'Indicates whether the grant funds a clinical trial as defined by NIH, requiring ClinicalTrials.gov registration.',
    `closeout_date` DATE COMMENT 'Date the grant was formally closed out with the funding agency, including final financial and technical reports.',
    `compliance_status` STRING COMMENT 'Current compliance status of the grant with respect to regulatory and sponsor requirements.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Dollar amount of institutional cost sharing committed to the grant.',
    `cost_sharing_required` BOOLEAN COMMENT 'Indicates whether the grant requires mandatory or voluntary committed cost sharing from the institution.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the grant award amount.',
    `current_budget_period_end` DATE COMMENT 'End date of the current budget period within the overall project period.',
    `current_budget_period_start` DATE COMMENT 'Start date of the current budget period (annual segment) within the overall project period.',
    `current_year_budget` DECIMAL(18,2) COMMENT 'Approved budget amount for the current fiscal/budget year of the grant.',
    `current_year_number` STRING COMMENT 'Current budget year number within the total project period (e.g., year 3 of 5).',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Total direct costs budgeted for the grant, including personnel, supplies, equipment, and travel.',
    `effective_end_date` DATE COMMENT 'Date the grant period of performance ends. Nullable for grants with no-cost extensions pending.',
    `effective_start_date` DATE COMMENT 'Date the grant period of performance begins, as specified in the award notice.',
    `effort_percent_pi` DECIMAL(18,2) COMMENT 'Percentage of the PIs total professional effort committed to this grant, used for effort certification compliance.',
    `fain` STRING COMMENT 'Unique federal award identification number assigned by the awarding agency, required for FFATA reporting.',
    `funding_agency_code` STRING COMMENT 'Standardized code identifying the funding agency (e.g., NIH, NSF, DOD, AHA) used for federal reporting.',
    `funding_agency_name` STRING COMMENT 'Name of the external funding agency or sponsor (e.g., National Institutes of Health, National Science Foundation, American Heart Association).',
    `funding_mechanism` STRING COMMENT 'Specific funding mechanism or award type (e.g., NIH R01 Research Project Grant, R21 Exploratory/Developmental, K08 Career Development). [ENUM-REF-CANDIDATE: R01|R21|R03|U01|U54|K08|K23|P01|P30|T32|F31|F32 — promote to reference product]',
    `grant_abstract` STRING COMMENT 'Public abstract summarizing the research aims and significance of the grant-funded project.',
    `grant_number` STRING COMMENT 'Externally-known unique grant number assigned by the funding agency (e.g., NIH R01, NSF award number). Used for regulatory reporting and financial tracking.',
    `grant_type` STRING COMMENT 'Classification of the grant by funding source type, used for financial reporting and compliance categorization.',
    `iacuc_protocol_number` STRING COMMENT 'IACUC protocol number for grants involving animal research, required for PHS Policy compliance.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Total indirect (facilities and administrative) costs budgeted for the grant.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated indirect cost rate (F&A rate) applied to the grant for facilities and administrative cost recovery.',
    `involves_human_subjects` BOOLEAN COMMENT 'Indicates whether the grant-funded research involves human subjects, triggering IRB oversight requirements.',
    `involves_vertebrate_animals` BOOLEAN COMMENT 'Indicates whether the grant-funded research involves vertebrate animals, triggering IACUC oversight.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number associated with the grants human subjects research, required for compliance with 45 CFR 46.',
    `last_progress_report_date` DATE COMMENT 'Date the most recent research progress report (RPPR) was submitted to the funding agency.',
    `next_report_due_date` DATE COMMENT 'Date the next progress or financial report is due to the funding agency.',
    `no_cost_extension_end_date` DATE COMMENT 'Revised end date of the grant after a no-cost extension has been approved.',
    `no_cost_extension_flag` BOOLEAN COMMENT 'Indicates whether a no-cost extension has been granted to extend the project period without additional funding.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was first created in the research administration system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was last modified.',
    `reporting_frequency` STRING COMMENT 'Required frequency of progress and financial reporting to the funding agency.',
    `research_category` STRING COMMENT 'Broad category of research funded by the grant, used for institutional portfolio analysis.',
    `research_grant_status` STRING COMMENT 'Current lifecycle status of the grant from proposal through closeout.',
    `sponsor_contact_email` STRING COMMENT 'Email address of the funding agency program officer for grant-related communications.',
    `sponsor_contact_name` STRING COMMENT 'Name of the program officer or grants management specialist at the funding agency.',
    `submission_date` DATE COMMENT 'Date the grant application was submitted to the funding agency.',
    `subrecipient_flag` BOOLEAN COMMENT 'Indicates whether the grant includes subrecipient (subaward) arrangements with other institutions.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic or disease area targeted by the research (e.g., oncology, cardiology, neurology).',
    `title` STRING COMMENT 'Official title of the research grant as submitted to the funding agency.',
    `total_project_years` STRING COMMENT 'Total number of years approved for the grant project period.',
    `award_number` STRING COMMENT 'External grant number assigned by the funding agency.',
    `funding_agency` STRING COMMENT 'Name of the organization providing the grant (e.g., NIH, NSF, DOD).',
    `award_title` STRING COMMENT 'Descriptive title of the research project funded by the grant.',
    `award_abstract` STRING COMMENT 'Brief summary of the research objectives and scope.',
    `direct_costs` DECIMAL(18,2) COMMENT 'Costs directly attributable to the research effort (e.g., salaries, supplies).',
    `indirect_costs` DECIMAL(18,2) COMMENT 'Facilities & Administrative (F&A) costs applied to the grant.',
    `total_cost` DECIMAL(18,2) COMMENT 'Sum of direct and indirect costs for the grant period.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|GBP`',
    `project_start_date` DATE COMMENT 'Date the funded research project officially begins.',
    `project_end_date` DATE COMMENT 'Date the funded research project is scheduled to conclude.',
    `effective_from` DATE COMMENT 'Date the grant becomes legally effective.',
    `effective_until` DATE COMMENT 'Date the grant expires or is terminated (null if open‑ended).',
    `principal_investigator_name` STRING COMMENT 'Full legal name of the lead researcher responsible for the grant.',
    `principal_investigator_id` BIGINT COMMENT 'Internal identifier for the principal investigator within the organization.',
    `co_investigator_names` STRING COMMENT 'Comma‑separated list of names of additional investigators on the grant.',
    `sponsor_code` STRING COMMENT 'Internal code used to classify the funding agency or program.',
    `cost_center` STRING COMMENT 'Financial cost center responsible for grant expenditures.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'Proportion of the PIs effort allocated to the grant (e.g., 25.00%).',
    `budget_period` STRING COMMENT 'Fiscal year or period for which the budget is defined.. Valid values are `FY2023|FY2024|FY2025|FY2026|FY2027|FY2028`',
    `grant_category` STRING COMMENT 'High‑level classification of the grant purpose.. Valid values are `research|training|infrastructure|collaboration`',
    `grant_status` STRING COMMENT 'Current lifecycle state of the grant.. Valid values are `active|closed|suspended|pending|terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the grant record was first entered into the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the grant record.',
    `compliance_notes` STRING COMMENT 'Free‑text notes on regulatory or sponsor compliance requirements.',
    `sponsor_requirements` STRING COMMENT 'Specific conditions or deliverables required by the funding agency.',
    `reporting_requirements` STRING COMMENT 'Frequency and format of financial and technical reports required by the sponsor.',
    `award_modifications` STRING COMMENT 'Record of any amendments, extensions, or budget changes to the original award.',
    `award_url` STRING COMMENT 'Web link to the official grant award page or documentation.',
    CONSTRAINT pk_research_grant PRIMARY KEY(`research_grant_id`)
) COMMENT 'Renamed tables to avoid SQL reserved words.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`trial_eligibility_criterion` (
    `trial_eligibility_criterion_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'description',
    `created_timestamp` TIMESTAMP COMMENT 'description',
    `criterion_category` STRING COMMENT 'description',
    `criterion_text` STRING COMMENT 'description',
    `criterion_type` STRING COMMENT 'description',
    `effective_from` DATE COMMENT 'description',
    `effective_until` DATE COMMENT 'description',
    `is_mandatory` BOOLEAN COMMENT 'description',
    `logic_group` STRING COMMENT 'description',
    `lookback_period_days` STRING COMMENT 'description',
    `operator` STRING COMMENT 'description',
    `sequence_number` STRING COMMENT 'description',
    `structured_code` STRING COMMENT 'description',
    `structured_code_system` STRING COMMENT 'description',
    `threshold_unit` STRING COMMENT 'description',
    `threshold_value` DECIMAL(18,2) COMMENT 'description',
    `trial_eligibility_criterion_status` STRING COMMENT 'description',
    `updated_timestamp` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_trial_eligibility_criterion PRIMARY KEY(`trial_eligibility_criterion_id`)
) COMMENT 'Defines individual inclusion/exclusion criteria for a clinical trial protocol, supporting structured eligibility evaluation for patient-trial matching';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` (
    `research_trial_eligibility_evaluation_id` BIGINT COMMENT 'description',
    `clinical_ai_model_inference_log_id` BIGINT COMMENT 'description',
    `employee_id` BIGINT COMMENT 'description',
    `clinician_id` BIGINT COMMENT 'description',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: Biomarker-driven trial eligibility: precision medicine trials require specific genomic results (e.g., BRCA mutation) for enrollment. Eligibility evaluation must reference the actual genomic test resul',
    `model_version_id` BIGINT COMMENT 'description',
    `mpi_record_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'description',
    `research_trial_eligibility_criteria_id` BIGINT COMMENT 'description',
    `study_site_id` BIGINT COMMENT 'description',
    `trial_eligibility_criterion_id` BIGINT COMMENT 'description',
    `trial_eligibility_evaluation_id` BIGINT COMMENT 'description',
    `bigint_surrogate_key_for_clean_keying` BIGINT COMMENT 'description',
    `confidence_level` STRING COMMENT 'description',
    `confidence_score` DECIMAL(18,2) COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `created_timestamp` TIMESTAMP COMMENT 'description',
    `criteria_met_flag` BOOLEAN COMMENT 'description',
    `criteria_threshold_value` DECIMAL(18,2) COMMENT 'description',
    `disqualifying_reason` STRING COMMENT 'description',
    `evaluation_date` TIMESTAMP COMMENT 'description',
    `evaluation_method` STRING COMMENT 'description',
    `evaluation_result` STRING COMMENT 'description',
    `evaluation_status` STRING COMMENT 'description',
    `evaluation_timestamp` TIMESTAMP COMMENT 'description',
    `evidence_date` DATE COMMENT 'description',
    `evidence_source` STRING COMMENT 'description',
    `evidence_value` DECIMAL(18,2) COMMENT 'description',
    `next_review_date` DATE COMMENT 'description',
    `notification_sent_date` TIMESTAMP COMMENT 'description',
    `notification_sent_flag` BOOLEAN COMMENT 'description',
    `overall_match_score` DECIMAL(18,2) COMMENT 'description',
    `override_flag` BOOLEAN COMMENT 'description',
    `override_reason` STRING COMMENT 'description',
    `patient_consent_status` STRING COMMENT 'description',
    `patient_value_observed` STRING COMMENT 'description',
    `research_trial_eligibility_evaluation_status` STRING COMMENT 'description',
    `reviewer_override_flag` BOOLEAN COMMENT 'description',
    `reviewer_override_reason` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `updated_timestamp` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_research_trial_eligibility_evaluation PRIMARY KEY(`research_trial_eligibility_evaluation_id`)
) COMMENT 'Records the evaluation of a patient against a specific eligibility criterion for a clinical trial, capturing pass/fail status and evidence';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` (
    `patient_trial_matching_result_id` BIGINT COMMENT 'description',
    `clinical_ai_model_card_id` BIGINT COMMENT 'description',
    `employee_id` BIGINT COMMENT 'description',
    `model_version_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_version. Business justification: Trial matching reproducibility requires exact model version tracking. When match scores are audited or a model is retrained, version-level FK enables identifying which patients were scored by which ve',
    `mpi_record_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'description',
    `study_site_id` BIGINT COMMENT 'description',
    `coordinator_review_status` STRING COMMENT 'description',
    `coordinator_review_timestamp` TIMESTAMP COMMENT 'description',
    `created_timestamp` TIMESTAMP COMMENT 'description',
    `criteria_indeterminate_count` STRING COMMENT 'description',
    `criteria_met_count` STRING COMMENT 'description',
    `criteria_not_met_count` STRING COMMENT 'description',
    `exclusion_reason` STRING COMMENT 'description',
    `match_score` DECIMAL(18,2) COMMENT 'description',
    `matching_timestamp` TIMESTAMP COMMENT 'description',
    `overall_eligibility_status` STRING COMMENT 'description',
    `patient_consent_status` STRING COMMENT 'description',
    `patient_contacted_flag` BOOLEAN COMMENT 'description',
    `patient_trial_matching_result_status` STRING COMMENT 'description',
    `total_criteria_count` STRING COMMENT 'description',
    `updated_timestamp` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_patient_trial_matching_result PRIMARY KEY(`patient_trial_matching_result_id`)
) COMMENT 'Stores the aggregate matching result for a patient against a clinical trial, summarizing all criterion evaluations into an overall eligibility determination';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_criteria` (
    `clinical_trial_eligibility_criteria_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'description',
    `study_arm_id` BIGINT COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `criteria_category` STRING COMMENT 'Category of criterion such as DEMOGRAPHIC, DIAGNOSIS, LAB_VALUE, MEDICATION, PROCEDURE, GENOMIC',
    `criteria_description` STRING COMMENT 'Human-readable description of the eligibility criterion',
    `criteria_logic_expression` STRING COMMENT 'Machine-parseable logic expression for automated evaluation (e.g., age >= 18 AND diagnosis IN (ICD-10 codes))',
    `criteria_type` STRING COMMENT 'Type of criterion: INCLUSION or EXCLUSION',
    `effective_end_date` DATE COMMENT 'Date after which this criterion is no longer active',
    `effective_start_date` DATE COMMENT 'Date from which this criterion becomes active for matching',
    `is_mandatory_flag` BOOLEAN COMMENT 'Whether this criterion is mandatory (hard stop) or advisory (soft criterion for ranking)',
    `lookback_period_days` STRING COMMENT 'Number of days to look back in patient history for criterion evaluation',
    `numeric_max_value` DECIMAL(18,2) COMMENT 'Maximum numeric threshold for lab-value or age-based criteria',
    `numeric_min_value` DECIMAL(18,2) COMMENT 'Minimum numeric threshold for lab-value or age-based criteria',
    `priority_order` STRING COMMENT 'Order in which criteria are evaluated for short-circuit optimization',
    `reference_code_system` STRING COMMENT 'Code system used for criterion evaluation (ICD-10, SNOMED, LOINC, RxNorm, etc.)',
    `reference_code_value` DECIMAL(18,2) COMMENT 'Specific code value or range used in criterion evaluation',
    `unit_of_measure` STRING COMMENT 'Unit of measure for numeric criteria (e.g., mg/dL, years, kg/m2)',
    `updated_at` TIMESTAMP COMMENT 'description',
    `updated_by` STRING COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_clinical_trial_eligibility_criteria PRIMARY KEY(`clinical_trial_eligibility_criteria_id`)
) COMMENT 'Defines inclusion/exclusion criteria for clinical trials used in automated patient matching';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` (
    `clinical_trial_eligibility_evaluation_id` BIGINT COMMENT 'description',
    `clinical_ai_model_inference_log_id` BIGINT COMMENT 'description',
    `clinical_trial_eligibility_criteria_id` BIGINT COMMENT 'description',
    `mpi_record_id` BIGINT COMMENT 'description',
    `research_study_id` BIGINT COMMENT 'description',
    `clinician_id` BIGINT COMMENT 'description',
    `study_site_id` BIGINT COMMENT 'description',
    `visit_id` BIGINT COMMENT 'description',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000-1.0000) for automated evaluations indicating certainty of the match result',
    `created_at` TIMESTAMP COMMENT 'description',
    `evaluated_value` DECIMAL(18,2) COMMENT 'The actual patient value that was evaluated against the criterion (e.g., lab result, age)',
    `evaluation_datetime` TIMESTAMP COMMENT 'Timestamp when the eligibility evaluation was performed',
    `evaluation_method` STRING COMMENT 'Method used for evaluation: AUTOMATED_NLP, AUTOMATED_STRUCTURED, MANUAL_REVIEW, HYBRID',
    `evaluation_status` STRING COMMENT 'Result of evaluation: MET, NOT_MET, INDETERMINATE, PENDING_REVIEW, WAIVED',
    `notification_sent_flag` BOOLEAN COMMENT 'Whether a notification was sent to the care team about this potential trial match',
    `overall_match_score` DECIMAL(18,2) COMMENT 'Composite match score across all criteria for this patient-trial pair, used for ranking',
    `override_reason` STRING COMMENT 'Reason provided when a clinician overrides an automated evaluation result',
    `patient_consent_status` STRING COMMENT 'Status of patient consent for trial matching: OPTED_IN, OPTED_OUT, NOT_ASKED, PENDING',
    `review_datetime` TIMESTAMP COMMENT 'Timestamp when a clinician reviewed the automated evaluation result',
    `source_data_reference` STRING COMMENT 'Reference to the source data element used in evaluation (table.column.row_id format)',
    `updated_at` TIMESTAMP COMMENT 'description',
    `updated_by` STRING COMMENT 'description',
    `waiver_approved_flag` BOOLEAN COMMENT 'Indicates if a protocol waiver was approved for a criterion the patient does not meet',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_clinical_trial_eligibility_evaluation PRIMARY KEY(`clinical_trial_eligibility_evaluation_id`)
) COMMENT 'Records the result of evaluating a patient against clinical trial eligibility criteria, supporting automated and manual trial matching workflows';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`trial_matching` (
    `trial_matching_id` BIGINT COMMENT 'Primary key for trial_matching',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or care site where the trial matching evaluation is conducted.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial protocol against which the patient is being matched.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient being evaluated for clinical trial eligibility.',
    `protocol_id` BIGINT COMMENT 'Identifier of the specific research protocol version used for eligibility evaluation.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Trial matching records match patients to clinical trials (research studies). The clinical_trial_id and nct_number fields indicate study association. Connects the siloed trial_matching to the domain.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical research coordinator or physician who reviewed and validated the matching result.',
    `study_site_id` BIGINT COMMENT 'Foreign key linking to research.study_site. Business justification: Trial matching evaluates patient eligibility at specific study sites. The care_site_id and distance_to_site_miles fields indicate site relevance.',
    `trial_clinician_id` BIGINT COMMENT 'Identifier of the provider who referred the patient for clinical trial matching evaluation.',
    `trial_eligibility_criterion_id` BIGINT COMMENT 'Protocol-specific identifier of the criterion that caused ineligibility, enabling traceability back to the protocol document.',
    `trial_principal_investigator_clinician_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for the clinical trial at the evaluating site.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the trial matching evaluation was initiated or performed.',
    `age_at_evaluation` STRING COMMENT 'Patients age in years at the time of eligibility evaluation, a common inclusion/exclusion criterion for clinical trials.',
    `biomarker_match_flag` BOOLEAN COMMENT 'Indicates whether the patients biomarker profile matches the trials biomarker-based eligibility requirements, common in precision medicine trials.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level of the eligibility determination, expressed as a decimal between 0 and 1, indicating reliability of the matching algorithm output.',
    `consent_status` STRING COMMENT 'Status of informed consent for trial participation at the time of matching evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trial matching evaluation record was first created in the system.',
    `criteria_data_completeness_pct` DECIMAL(18,2) COMMENT 'Percentage of eligibility criteria that could be evaluated based on available patient data, indicating data sufficiency for the matching decision.',
    `data_source` STRING COMMENT 'Primary source system from which patient clinical data was extracted for eligibility evaluation.',
    `decline_reason` STRING COMMENT 'Reason provided by the patient for declining participation in the matched clinical trial, supporting recruitment analytics.',
    `distance_to_site_miles` DECIMAL(18,2) COMMENT 'Calculated distance in miles between the patients residence and the trial site, used to assess feasibility of patient participation and travel burden.',
    `eligibility_score` DECIMAL(18,2) COMMENT 'Computed eligibility score representing the degree of match between patient characteristics and trial inclusion/exclusion criteria, typically on a 0-100 scale.',
    `enrollment_date` DATE COMMENT 'Date on which the patient was formally enrolled into the clinical trial following successful matching and consent.',
    `evaluation_date` DATE COMMENT 'Date on which the clinical trial eligibility evaluation was performed for this patient-trial combination.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the eligibility evaluation was completed, used for audit trail and regulatory compliance.',
    `exclusion_criteria_total_count` STRING COMMENT 'Total number of exclusion criteria defined in the trial protocol against which the patient was evaluated.',
    `exclusion_criteria_triggered_count` STRING COMMENT 'Number of protocol-defined exclusion criteria that the patient triggers, potentially disqualifying them from enrollment.',
    `expiration_date` DATE COMMENT 'Date after which this eligibility evaluation is no longer valid and must be re-assessed due to potential changes in patient clinical status or protocol amendments.',
    `inclusion_criteria_met_count` STRING COMMENT 'Number of protocol-defined inclusion criteria that the patient satisfies based on available clinical data.',
    `inclusion_criteria_total_count` STRING COMMENT 'Total number of inclusion criteria defined in the trial protocol against which the patient was evaluated.',
    `ineligibility_reason` STRING COMMENT 'Primary reason the patient was determined ineligible for the trial, referencing the specific exclusion criterion or unmet inclusion criterion.',
    `irb_approval_number` STRING COMMENT 'IRB approval reference number for the trial protocol at the evaluating institution, confirming ethical oversight.',
    `matching_algorithm_version` STRING COMMENT 'Version identifier of the eligibility matching algorithm or rule engine used to produce this evaluation, supporting reproducibility and audit.',
    `matching_number` STRING COMMENT 'Business-facing reference number assigned to this trial matching evaluation for tracking and communication purposes.',
    `matching_status` STRING COMMENT 'Current status of the patient-to-trial matching evaluation workflow indicating eligibility determination outcome.',
    `matching_type` STRING COMMENT 'Method used to perform the eligibility matching evaluation, distinguishing automated algorithmic matching from manual clinical review.',
    `nct_number` STRING COMMENT 'ClinicalTrials.gov NCT registration number of the trial being evaluated for patient matching.',
    `notes` STRING COMMENT 'Free-text clinical notes documenting additional context, observations, or rationale related to the eligibility evaluation.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether the automated eligibility determination was manually overridden by a clinical reviewer.',
    `override_reason` STRING COMMENT 'Clinical justification provided when a reviewer manually overrides the automated eligibility determination.',
    `patient_notification_date` DATE COMMENT 'Date on which the patient was notified about the trial matching opportunity and potential eligibility.',
    `patient_response` STRING COMMENT 'Patients expressed interest or decision regarding participation in the matched clinical trial.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code representing the patients primary condition relevant to trial eligibility determination.',
    `prior_treatment_match_flag` BOOLEAN COMMENT 'Indicates whether the patients prior treatment history satisfies the trials requirements for previous therapy lines or washout periods.',
    `priority_rank` STRING COMMENT 'Relative priority ranking of this trial match for the patient when multiple trials are available, with 1 being highest priority.',
    `randomization_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient has passed all screening requirements and is eligible for randomization into the trial.',
    `review_date` DATE COMMENT 'Date on which a clinical reviewer validated or overrode the automated matching determination.',
    `screening_visit_date` DATE COMMENT 'Date of the formal screening visit scheduled or completed as part of the trial enrollment process following positive matching.',
    `sponsor_name` STRING COMMENT 'Name of the pharmaceutical company, device manufacturer, or academic institution sponsoring the clinical trial.',
    `therapeutic_area` STRING COMMENT 'Clinical therapeutic area or disease category targeted by the trial, used for high-level matching classification. [ENUM-REF-CANDIDATE: oncology|cardiology|neurology|immunology|endocrinology|pulmonology|infectious_disease|rare_disease|psychiatry — promote to reference product]',
    `trial_phase` STRING COMMENT 'FDA-defined phase of the clinical trial, indicating the stage of drug or device development and influencing eligibility requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this trial matching evaluation record was last modified, supporting audit trail requirements.',
    `waiver_approved_flag` BOOLEAN COMMENT 'Indicates whether the eligibility waiver request was approved by the principal investigator and/or sponsor.',
    `waiver_requested_flag` BOOLEAN COMMENT 'Indicates whether a protocol eligibility waiver was requested for this patient despite not meeting all standard criteria.',
    CONSTRAINT pk_trial_matching PRIMARY KEY(`trial_matching_id`)
) COMMENT 'Clinical Trial Matching domain - eligibility criteria evaluation tables for matching patients to clinical trials based on structured criteria';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` (
    `research_trial_eligibility_criteria_id` BIGINT COMMENT 'Primary key for research_trial_eligibility_criteria',
    `research_study_id` BIGINT COMMENT 'description',
    `study_arm_id` BIGINT COMMENT 'description',
    `eligibility_criteria_id` BIGINT COMMENT 'description',
    `age_max_years` STRING COMMENT 'description',
    `age_min_years` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `criteria_category` STRING COMMENT 'description',
    `criteria_description` STRING COMMENT 'description',
    `criteria_logic_expression` STRING COMMENT 'description',
    `criteria_type` STRING COMMENT 'description',
    `effective_end_date` DATE COMMENT 'description',
    `effective_start_date` DATE COMMENT 'description',
    `excluded_diagnosis_code` STRING COMMENT 'description',
    `excluded_medication_code` STRING COMMENT 'description',
    `gender_requirement` STRING COMMENT 'description',
    `is_mandatory_flag` BOOLEAN COMMENT 'description',
    `lab_test_loinc_code` STRING COMMENT 'description',
    `lookback_period_days` STRING COMMENT 'description',
    `max_value` DECIMAL(18,2) COMMENT 'description',
    `min_value` DECIMAL(18,2) COMMENT 'description',
    `priority_order` STRING COMMENT 'description',
    `required_diagnosis_code` STRING COMMENT 'description',
    `required_medication_code` STRING COMMENT 'description',
    `target_code_system` STRING COMMENT 'description',
    `target_code_value` DECIMAL(18,2) COMMENT 'description',
    `unit_of_measure` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    `created_by` STRING COMMENT 'description',
    CONSTRAINT pk_research_trial_eligibility_criteria PRIMARY KEY(`research_trial_eligibility_criteria_id`)
) COMMENT 'Defines structured eligibility criteria for clinical trials including inclusion/exclusion rules, age ranges, diagnosis requirements, lab value thresholds, and medication history constraints used for automated patient matching';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` (
    `study_genomic_eligibility_id` BIGINT COMMENT 'System-generated unique identifier for each study-genomic eligibility mapping record.',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to the genomic test result being evaluated against study criteria',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study whose biomarker eligibility criteria are being evaluated',
    `clinician_id` BIGINT COMMENT 'Foreign key to the clinician or research coordinator who reviewed and confirmed the eligibility determination.',
    `biomarker_requirement_type` STRING COMMENT 'Classification of the biomarker criterion type the study requires (e.g., mutation, amplification, expression level, fusion, MSI status).',
    `effective_date` DATE COMMENT 'Date when this eligibility mapping became active, typically aligned with protocol version or amendment effective date.',
    `expiration_date` DATE COMMENT 'Date when this eligibility mapping was superseded or deactivated due to protocol amendment or study closure.',
    `inclusion_exclusion_flag` STRING COMMENT 'Indicates whether this genomic finding serves as an inclusion criterion or exclusion criterion for the study.',
    `match_status` STRING COMMENT 'Outcome of evaluating the genomic test result against the study criterion (met, not_met, indeterminate, pending_review).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility mapping record was first created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this eligibility mapping record.',
    `required_variant` STRING COMMENT 'The specific genetic variant or biomarker value the study protocol requires for eligibility (e.g., EGFR L858R, BRCA1 pathogenic, PD-L1 >= 50%).',
    `review_date` TIMESTAMP COMMENT 'Timestamp when the eligibility determination was reviewed and confirmed.',
    CONSTRAINT pk_study_genomic_eligibility PRIMARY KEY(`study_genomic_eligibility_id`)
) COMMENT 'This association product represents the eligibility mapping between a research_study and a genomic_test_result. It captures which specific genomic findings satisfy (or disqualify) a studys biomarker-based inclusion/exclusion criteria. Each record links one research study to one genomic test result with attributes describing the biomarker requirement type, required variant, inclusion/exclusion determination, and effective dating. This is the operational record that clinical trial matching coordinators create and manage during patient screening.. Existence Justification: In clinical research, a single research study defines biomarker eligibility criteria (e.g., EGFR mutation, BRCA1/2 variants) that multiple genomic test results can satisfy, and a single genomic test result (e.g., a panel showing EGFR L858R mutation) can qualify a patient for multiple concurrent studies. Research coordinators actively manage these study-biomarker-result mappings as part of the clinical trial matching and screening workflow, determining which specific genomic findings meet which studys inclusion/exclusion criteria.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`institutional_review_board` (
    `institutional_review_board_id` BIGINT COMMENT 'Primary key for institutional_review_board',
    `organization_id` BIGINT COMMENT 'Reference to the parent organization entity in the facility domain that operates this IRB.',
    `accreditation_body` STRING COMMENT 'The accrediting organization that has certified this IRBs human research protection program, primarily AAHRPP (Association for the Accreditation of Human Research Protection Programs).',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current accreditation expires and renewal is required to maintain accredited status.',
    `accreditation_status` STRING COMMENT 'Current accreditation status indicating whether the IRBs human research protection program meets voluntary accreditation standards.',
    `active_protocol_count` STRING COMMENT 'Current number of active research protocols under this IRBs oversight, indicating board workload and capacity utilization.',
    `annual_submission_volume` STRING COMMENT 'Total number of protocol submissions (new, amendments, continuing reviews) received by this IRB in the current calendar year.',
    `average_review_days` STRING COMMENT 'Average number of calendar days from protocol submission to initial IRB determination, used for researcher planning and operational performance tracking.',
    `board_type` STRING COMMENT 'Classification of the IRB by organizational structure: institutional (hospital/university-based), central (multi-site), commercial (for-profit), independent (community-based), or cooperative (shared across institutions).',
    `chairperson_email` STRING COMMENT 'Primary email address of the IRB chairperson for official correspondence regarding protocol reviews and regulatory communications.',
    `chairperson_name` STRING COMMENT 'Full name of the current IRB chairperson responsible for presiding over board meetings and ensuring regulatory compliance of review activities.',
    `chairperson_phone` STRING COMMENT 'Contact phone number for the IRB chairperson for urgent protocol safety communications.',
    `conflict_of_interest_policy` STRING COMMENT 'Reference identifier or title of the IRBs conflict of interest policy governing member recusal and financial disclosure requirements.',
    `continuing_review_interval_months` STRING COMMENT 'Standard interval in months between required continuing reviews for approved protocols (typically 12 months maximum per federal regulations).',
    `corrective_action_plan_flag` BOOLEAN COMMENT 'Indicates whether this IRB currently has an active corrective action plan resulting from a regulatory finding, audit, or compliance determination.',
    `current_member_count` STRING COMMENT 'Current total number of appointed members serving on this IRB, including scientific, non-scientific, and unaffiliated community members.',
    `effective_date` DATE COMMENT 'Date when this IRB was formally established and began conducting human subjects research reviews.',
    `eirb_system_name` STRING COMMENT 'Name of the electronic IRB management system used for protocol submissions, tracking, and correspondence (e.g., IRBManager, IRIS, Click Commerce).',
    `electronic_submission_enabled` BOOLEAN COMMENT 'Indicates whether this IRB accepts electronic protocol submissions through an eIRB system compliant with FDA 21 CFR Part 11 electronic records requirements.',
    `fda_regulated_research_flag` BOOLEAN COMMENT 'Indicates whether this IRB is authorized to review FDA-regulated research (drugs, biologics, devices) subject to 21 CFR Parts 50 and 56.',
    `fwa_expiration_date` DATE COMMENT 'Date when the Federal-Wide Assurance expires and must be renewed with OHRP to continue conducting federally funded research.',
    `fwa_number` STRING COMMENT 'The Federal-Wide Assurance number issued by OHRP, required for institutions engaged in federally funded human subjects research.',
    `has_pediatric_expertise` BOOLEAN COMMENT 'Indicates whether this IRB has members with expertise in pediatric research as required when reviewing research involving children per Subpart D.',
    `has_prisoner_representative` BOOLEAN COMMENT 'Indicates whether this IRB has a designated prisoner representative member as required when reviewing research involving prisoners per Subpart C.',
    `has_vulnerable_population_expertise` BOOLEAN COMMENT 'Indicates whether this IRB has members with expertise in research involving vulnerable populations (pregnant women, neonates, cognitively impaired).',
    `hipaa_privacy_board_flag` BOOLEAN COMMENT 'Indicates whether this IRB also serves as the HIPAA Privacy Board authorized to grant waivers of individual authorization for use of PHI in research.',
    `institutional_review_board_name` STRING COMMENT 'Official name of the institutional review board as registered with OHRP (Office for Human Research Protections).',
    `institutional_review_board_status` STRING COMMENT 'Current operational status of the IRB indicating whether it is authorized to review and approve human subjects research protocols.',
    `iorg_number` STRING COMMENT 'The OHRP-assigned organization number (IORG) that uniquely identifies the institution operating this IRB in the federal registry.',
    `irb_registration_number` STRING COMMENT 'The OHRP-assigned IRB registration number used to identify this specific board in the federal IRB registry.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external compliance audit of this IRBs operations, records, and procedures.',
    `last_fda_inspection_date` DATE COMMENT 'Date of the most recent FDA inspection of this IRB under the Bioresearch Monitoring Program (BIMO).',
    `last_ohrp_determination_date` DATE COMMENT 'Date of the most recent OHRP compliance determination letter or action regarding this IRBs adherence to the Common Rule.',
    `meeting_frequency` STRING COMMENT 'Standard frequency at which the IRB convenes full-board meetings to review research protocols requiring full committee review.',
    `minimum_member_count` STRING COMMENT 'Minimum number of members required for this IRB to achieve quorum and conduct official review business per federal regulations (minimum 5 per 45 CFR 46.107).',
    `notes` STRING COMMENT 'Free-text administrative notes regarding this IRBs operations, special conditions, or regulatory history relevant to research compliance staff.',
    `office_address` STRING COMMENT 'Physical mailing address of the IRB administrative office where official correspondence and regulatory submissions are directed.',
    `office_email` STRING COMMENT 'General email address for the IRB office used for protocol submissions, inquiries, and administrative communications.',
    `office_phone` STRING COMMENT 'Main telephone number for the IRB administrative office for general inquiries and researcher support.',
    `parent_institution_name` STRING COMMENT 'Name of the parent institution (university, hospital system, or organization) that operates and provides oversight for this IRB.',
    `quorum_requirement` STRING COMMENT 'Number of members that must be present to constitute a quorum for convened full-board meetings, including at least one non-scientific member.',
    `record_retention_years` STRING COMMENT 'Number of years this IRB retains protocol records after study completion, per institutional policy and federal requirements (minimum 3 years per 45 CFR 46.115).',
    `registration_effective_date` DATE COMMENT 'Date when the IRB registration with OHRP became effective, establishing the boards authority to review human subjects research.',
    `registration_renewal_date` DATE COMMENT 'Date when the IRB registration must be renewed with OHRP (required every 3 years per federal regulations).',
    `reliance_agreement_count` STRING COMMENT 'Number of active IRB authorization agreements (IAAs) or reliance agreements with external institutions allowing this IRB to serve as reviewing IRB.',
    `review_scope` STRING COMMENT 'The types of review this IRB is authorized to conduct: full board review, expedited review, exempt determinations, or all categories.',
    `single_irb_capable_flag` BOOLEAN COMMENT 'Indicates whether this IRB can serve as the single IRB of record for multi-site studies as required by the NIH sIRB policy and revised Common Rule.',
    `termination_date` DATE COMMENT 'Date when this IRB ceased operations, if applicable. Null for currently active boards.',
    `website_url` STRING COMMENT 'Public website URL for the IRB providing researcher guidance, submission instructions, forms, and meeting schedules.',
    CONSTRAINT pk_institutional_review_board PRIMARY KEY(`institutional_review_board_id`)
) COMMENT 'Master reference table for institutional_review_board. Referenced by irb_id.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`research`.`protocol_version` (
    `protocol_version_id` BIGINT COMMENT 'Primary key for protocol_version',
    `author_employee_id` BIGINT COMMENT 'Identifier of the individual (typically the principal investigator or medical writer) who authored this protocol version.',
    `clinician_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for this protocol version at the lead site.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who provided final approval for this protocol version (typically the sponsors medical director or designee).',
    `research_study_id` BIGINT COMMENT 'Identifier of the parent clinical research protocol to which this version belongs. Links the version back to the master protocol record.',
    `amendment_number` STRING COMMENT 'Formal amendment number assigned by the sponsor when this version represents a protocol amendment (e.g., Amendment 01). Null for the original protocol version.',
    `amendment_type` STRING COMMENT 'Classification of the amendment type indicating the nature and regulatory significance of changes made in this version.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol version received final internal approval, establishing the audit trail required under 21 CFR Part 11.',
    `blinding_type` STRING COMMENT 'Level of blinding (masking) employed in the study design for this protocol version to minimize bias.',
    `change_summary` STRING COMMENT 'Narrative summary of changes made from the previous protocol version, documenting the rationale and scope of amendments.',
    `clinicaltrials_gov_nct_number` STRING COMMENT 'The ClinicalTrials.gov NCT number associated with this protocol, required for public registration of clinical trials.',
    `comparator_description` STRING COMMENT 'Description of the comparator agent (placebo, active comparator, or standard of care) used in the control arm of this protocol version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol version record was first created in the system.',
    `data_safety_monitoring_required` BOOLEAN COMMENT 'Indicates whether a Data Safety Monitoring Board is required for oversight of this protocol version.',
    `document_storage_path` STRING COMMENT 'File system or document management system path where the official PDF/document of this protocol version is stored for regulatory inspection readiness.',
    `dosage_description` STRING COMMENT 'Summary description of the dosage regimen including dose levels, frequency, and route of administration as specified in this version.',
    `effective_date` DATE COMMENT 'Date on which this protocol version becomes effective and enforceable for study conduct at all participating sites.',
    `electronic_signature_reference` STRING COMMENT 'Identifier of the electronic signature applied to this protocol version document, ensuring compliance with 21 CFR Part 11 requirements for electronic records.',
    `exclusion_criteria_summary` STRING COMMENT 'Summary of key exclusion criteria defining subjects who cannot participate under this protocol version.',
    `expiration_date` DATE COMMENT 'Date on which this protocol version is superseded or expires. Null for the currently active version.',
    `ide_number` STRING COMMENT 'FDA Investigational Device Exemption number if this protocol version involves an investigational medical device.',
    `inclusion_criteria_summary` STRING COMMENT 'Summary of key inclusion criteria defining the eligible subject population for this protocol version.',
    `ind_number` STRING COMMENT 'FDA Investigational New Drug application number under which this protocol version is conducted.',
    `indication` STRING COMMENT 'Specific disease or condition being studied in this protocol version, typically mapped to ICD-10 or MedDRA terminology.',
    `informed_consent_version` STRING COMMENT 'Version identifier of the informed consent form associated with this protocol version, ensuring subjects consent to the correct study procedures.',
    `investigational_product_name` STRING COMMENT 'Name of the investigational drug, biologic, or device being studied under this protocol version.',
    `irb_approval_date` DATE COMMENT 'Date on which the Institutional Review Board formally approved this protocol version for human subjects research.',
    `irb_submission_date` DATE COMMENT 'Date on which this protocol version was submitted to the IRB for review and approval.',
    `is_international` BOOLEAN COMMENT 'Indicates whether this protocol version involves sites in multiple countries requiring multi-national regulatory submissions.',
    `is_multi_center` BOOLEAN COMMENT 'Indicates whether this protocol version is designed as a multi-center study involving more than one clinical site.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the primary language in which this protocol version is written.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol version record was last modified, supporting audit trail requirements.',
    `number_of_arms` STRING COMMENT 'Total number of treatment arms or groups defined in this protocol version.',
    `number_of_sites` STRING COMMENT 'Planned number of clinical sites participating under this protocol version.',
    `page_count` STRING COMMENT 'Total number of pages in the protocol version document, used for document management and regulatory submission tracking.',
    `planned_duration_months` STRING COMMENT 'Planned duration of the study in months as specified in this protocol version, from first subject enrolled to last subject completed.',
    `primary_endpoint` STRING COMMENT 'Description of the primary efficacy or safety endpoint that the study is powered to evaluate in this protocol version.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority approved or acknowledged this protocol version.',
    `regulatory_submission_date` DATE COMMENT 'Date on which this protocol version was submitted to the applicable regulatory authority (e.g., FDA IND submission).',
    `risk_category` STRING COMMENT 'Risk categorization of the study as assessed for this protocol version, used for risk-based monitoring decisions.',
    `sponsor_approval_date` DATE COMMENT 'Date on which the study sponsor formally approved this protocol version prior to IRB submission.',
    `sponsor_protocol_number` STRING COMMENT 'The unique protocol identification number assigned by the study sponsor for tracking across their portfolio.',
    `study_design` STRING COMMENT 'The methodological design of the clinical study as specified in this protocol version.',
    `study_phase` STRING COMMENT 'Phase of the clinical trial as defined by FDA guidelines, indicating the stage of drug/device development for this protocol version.',
    `target_enrollment` STRING COMMENT 'Target number of subjects to be enrolled under this protocol version, as determined by statistical power analysis.',
    `therapeutic_area` STRING COMMENT 'Medical specialty or therapeutic area targeted by the study (e.g., oncology, cardiology, neurology, infectious disease).',
    `treatment_duration_days` STRING COMMENT 'Duration of the treatment period in days for each subject as defined in this protocol version.',
    `version_number` STRING COMMENT 'The sequential version number assigned to this protocol revision (e.g., 1.0, 2.1, 3.0). Follows semantic versioning conventions used in clinical research.',
    `version_status` STRING COMMENT 'Current lifecycle status of this protocol version indicating its position in the review and approval workflow.',
    `version_title` STRING COMMENT 'Descriptive title or label for this protocol version, often reflecting the nature of the amendment (e.g., Amendment 3 - Dosage Modification).',
    CONSTRAINT pk_protocol_version PRIMARY KEY(`protocol_version_id`)
) COMMENT 'Master reference table for protocol_version. Referenced by protocol_version_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_protocol_amendment_id` FOREIGN KEY (`protocol_amendment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_parent_study_research_study_id` FOREIGN KEY (`parent_study_research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_institutional_review_board_id` FOREIGN KEY (`institutional_review_board_id`) REFERENCES `healthcare_ecm_v1`.`research`.`institutional_review_board`(`institutional_review_board_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_irb_study_research_study_id` FOREIGN KEY (`irb_study_research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_institutional_review_board_id` FOREIGN KEY (`institutional_review_board_id`) REFERENCES `healthcare_ecm_v1`.`research`.`institutional_review_board`(`institutional_review_board_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_subject_research_study_id` FOREIGN KEY (`subject_research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_consent_template_id` FOREIGN KEY (`consent_template_id`) REFERENCES `healthcare_ecm_v1`.`research`.`consent_template`(`consent_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `healthcare_ecm_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_informed_consent_id` FOREIGN KEY (`informed_consent_id`) REFERENCES `healthcare_ecm_v1`.`research`.`informed_consent`(`informed_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_dsmb_committee_id` FOREIGN KEY (`dsmb_committee_id`) REFERENCES `healthcare_ecm_v1`.`research`.`dsmb_committee`(`dsmb_committee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_coverage_analysis_id` FOREIGN KEY (`coverage_analysis_id`) REFERENCES `healthcare_ecm_v1`.`research`.`coverage_analysis`(`coverage_analysis_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ADD CONSTRAINT `fk_research_research_grant_award_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ADD CONSTRAINT `fk_research_research_grant_award_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_amendment_of_research_regulatory_submission_id` FOREIGN KEY (`amendment_of_research_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_regulatory_submission`(`research_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_data_governance_committee_id` FOREIGN KEY (`data_governance_committee_id`) REFERENCES `healthcare_ecm_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_data_governance_committee_id` FOREIGN KEY (`data_governance_committee_id`) REFERENCES `healthcare_ecm_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_deidentified_dataset_id` FOREIGN KEY (`deidentified_dataset_id`) REFERENCES `healthcare_ecm_v1`.`research`.`deidentified_dataset`(`deidentified_dataset_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_previous_version_consent_template_id` FOREIGN KEY (`previous_version_consent_template_id`) REFERENCES `healthcare_ecm_v1`.`research`.`consent_template`(`consent_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `healthcare_ecm_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_data_access_request_id` FOREIGN KEY (`data_access_request_id`) REFERENCES `healthcare_ecm_v1`.`research`.`data_access_request`(`data_access_request_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_deidentified_dataset_id` FOREIGN KEY (`deidentified_dataset_id`) REFERENCES `healthcare_ecm_v1`.`research`.`deidentified_dataset`(`deidentified_dataset_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ADD CONSTRAINT `fk_research_research_grant_record_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ADD CONSTRAINT `fk_research_research_grant_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_eligibility_criterion` ADD CONSTRAINT `fk_research_trial_eligibility_criterion_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_research_trial_eligibility_criteria_id` FOREIGN KEY (`research_trial_eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria`(`research_trial_eligibility_criteria_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_trial_eligibility_criterion_id` FOREIGN KEY (`trial_eligibility_criterion_id`) REFERENCES `healthcare_ecm_v1`.`research`.`trial_eligibility_criterion`(`trial_eligibility_criterion_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ADD CONSTRAINT `fk_research_patient_trial_matching_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ADD CONSTRAINT `fk_research_patient_trial_matching_result_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_criteria` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_criteria_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_criteria` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_criteria_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_clinical_trial_eligibility_criteria_id` FOREIGN KEY (`clinical_trial_eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_criteria`(`clinical_trial_eligibility_criteria_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_trial_eligibility_criterion_id` FOREIGN KEY (`trial_eligibility_criterion_id`) REFERENCES `healthcare_ecm_v1`.`research`.`trial_eligibility_criterion`(`trial_eligibility_criterion_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ADD CONSTRAINT `fk_research_research_trial_eligibility_criteria_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ADD CONSTRAINT `fk_research_research_trial_eligibility_criteria_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ADD CONSTRAINT `fk_research_study_genomic_eligibility_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ADD CONSTRAINT `fk_research_protocol_version_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`research` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `healthcare_ecm_v1`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `clinician_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Budget Amount (BUDGET_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('dbx_business_glossary_term' = 'Coordinating Center (COORD_CENTER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Flag (DSA_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `de_identified_data_access_flag` SET TAGS ('dbx_business_glossary_term' = 'De‑identified Data Access Flag (DEID_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `delta_tblproperties` SET TAGS ('dbx_governance_metadata' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date (END_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `exclusion_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria Summary (EXCL_CRIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `fda_21cfr11_compliant` SET TAGS ('dbx_business_glossary_term' = 'FDA 21 CFR Part 11 Compliance Flag (21CFR11)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source (FUND_SRC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `inclusion_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria Summary (INCL_CRIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `ind_ide_number` SET TAGS ('dbx_business_glossary_term' = 'IND/IDE Number (IND_IDE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Protocol Number (IRB_PROTO)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `is_multi_site` SET TAGS ('dbx_business_glossary_term' = 'Multi-Site Flag (MULTI_SITE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `nct_number` SET TAGS ('dbx_business_glossary_term' = 'NCT Identifier (NCT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Study Phase (PHASE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'I|II|III|IV');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `primary_outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Primary Outcome Measure (PRIMARY_OUTCOME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `randomization_ratio` SET TAGS ('dbx_business_glossary_term' = 'Randomization Ratio (RAND_RATIO)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference (REG_SUB_REF)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `research_study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `research_study_status` SET TAGS ('dbx_value_regex' = 'active|completed|suspended|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `secondary_outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Secondary Outcome Measure (SECONDARY_OUTCOME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date (START_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `study_description` SET TAGS ('dbx_business_glossary_term' = 'Study Description (DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type (TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'interventional|observational|expanded_access');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `study_version` SET TAGS ('dbx_business_glossary_term' = 'Study Version (VERSION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `target_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Target Enrollment (TARGET_ENR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area (THERAPY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Study Title (STUDY_TITLE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date (VER_EFF_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date (VER_EXP_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `sponsor` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor (SPONSOR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `nct_id` SET TAGS ('dbx_business_glossary_term' = 'NCT Identifier (NCT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Study Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|completed|suspended|terminated|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number (AMEND_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date (AMEND_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description (AMEND_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason (AMEND_REASON)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Impact Assessment (AMEND_IMPACT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_irb_fda_submission_ref` SET TAGS ('dbx_business_glossary_term' = 'Amendment IRB/FDA Submission Reference (AMEND_SUB_REF)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `amendment_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Implementation Date (AMEND_IMPL_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `arm_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Name (ARM_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `arm_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Type (ARM_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `arm_type` SET TAGS ('dbx_value_regex' = 'experimental|active_comparator|placebo|sham|observational');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `arm_planned_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Arm Planned Enrollment (ARM_ENR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `dose_description` SET TAGS ('dbx_business_glossary_term' = 'Dose/Intervention Description (DOSE_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `arm_status` SET TAGS ('dbx_business_glossary_term' = 'Arm Status (ARM_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ALTER COLUMN `arm_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'IRB Submission ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `irb_study_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `action_required` SET TAGS ('dbx_business_glossary_term' = 'Action Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `agency_response` SET TAGS ('dbx_business_glossary_term' = 'Agency Response');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `compliance_regulations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `compliance_regulations` SET TAGS ('dbx_value_regex' = '21CFR56|21CFR312|45CFR46|HIPAA|GDPR|None');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `data_retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Months)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `data_sharing_plan` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Plan');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'federal|industry|institution|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `has_vulnerable_population` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `is_continuing_review` SET TAGS ('dbx_business_glossary_term' = 'Continuing Review Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `is_device_study` SET TAGS ('dbx_business_glossary_term' = 'Device Study Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `is_human_subjects` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `is_multi_site` SET TAGS ('dbx_business_glossary_term' = 'Multi-Site Study Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `is_reportable_event` SET TAGS ('dbx_business_glossary_term' = 'Reportable Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|conditional|rejected|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `protocol_title` SET TAGS ('dbx_business_glossary_term' = 'Protocol Title');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `review_body` SET TAGS ('dbx_business_glossary_term' = 'Review Body');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'initial|amendment|continuing|reportable_event|closure');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Study Phase');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `study_phase` SET TAGS ('dbx_value_regex' = 'phase_i|phase_ii|phase_iii|phase_iv|observational');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Submission Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Submission Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'IRB Submission Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'irb|fda|ohrp|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `institutional_review_board_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `post_acute_location_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Date (SAD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Date (SCD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (CAR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_resolved` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Resolved (CAR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO3)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `current_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment (CENR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity (ECAP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp (LAT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `last_monitoring_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Visit Date (LMVD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `monitoring_visit_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Visit Status (MVS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `monitoring_visit_status` SET TAGS ('dbx_value_regex' = 'completed|scheduled|overdue|canceled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `next_monitoring_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Visit Date (NMVD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (NOTE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `protocol_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Count (PDC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag (PDF)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `regulatory_binder_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Binder Status (RBS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `regulatory_binder_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email (SCE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name (SCN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone (SCP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_contact_role` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Role (SCR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Study Site Name (SSN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_number` SET TAGS ('dbx_business_glossary_term' = 'Study Site Number (SSNBR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Site Performance Score (SPS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_region` SET TAGS ('dbx_business_glossary_term' = 'Site Region (SRG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Study Site Status (SSS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Study Site Type (SST)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'hospital|clinic|virtual|research_center');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (ST)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `irb_name` SET TAGS ('dbx_business_glossary_term' = 'IRB Name (IRBN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ALTER COLUMN `irb_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Identifier (IRBI)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `genomics_genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Consent Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Study Enrollment Identifier (SEID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `subject_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ES)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'screened|enrolled|active|completed|withdrawn|lost_to_follow_up');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ET)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'prospective|retrospective');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_arm` SET TAGS ('dbx_business_glossary_term' = 'Randomization Arm (RA)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_arm` SET TAGS ('dbx_value_regex' = 'control|treatment_a|treatment_b');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_business_glossary_term' = 'Randomization Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_method` SET TAGS ('dbx_business_glossary_term' = 'Randomization Method (RM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_method` SET TAGS ('dbx_value_regex' = 'simple|block|stratified|adaptive');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `stratification_factors` SET TAGS ('dbx_business_glossary_term' = 'Stratification Factors');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `subject_study_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Study Enrollment Identifier (SEID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `informed_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Staff Identifier (SID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Identifier (WID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (SID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_form_title` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Title');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_form_version_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Location');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Number (CN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'in_person|remote|mail');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|expired|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type (CT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'initial|reconsent|assent|lar_consent');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639‑1)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `reconsent_date` SET TAGS ('dbx_business_glossary_term' = 'Re‑Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `required_elements_checklist` SET TAGS ('dbx_business_glossary_term' = 'Required Elements Checklist');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `signature_indicator` SET TAGS ('dbx_business_glossary_term' = 'Signature Indicator');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'pen|electronic|thumbprint');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'draft|approved|superseded');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By Staff Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (SID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `consent_form_version_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `staff_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Staff Identifier (SID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `staff_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `staff_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `witness_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Identifier (WID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `witness_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `witness_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ALTER COLUMN `created_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `affected_site_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Site Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approver Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approver Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_business_glossary_term' = 'Amendment Author Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_name` SET TAGS ('dbx_business_glossary_term' = 'Amendment Author Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Sequence Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Amendment Review Comments');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'protocol|eligibility|dosage|safety|administrative');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `delta_table_properties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties (JSON)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `description_of_changes` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `document_hash` SET TAGS ('dbx_business_glossary_term' = 'Document SHA256 Hash');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document URL');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `fda_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'FDA Submission Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_efficacy` SET TAGS ('dbx_business_glossary_term' = 'Efficacy Impact Assessment');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_efficacy` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Impact Assessment');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_enrollment` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_safety` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Assessment');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_safety` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `irb_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'IRB Submission Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `protocol_amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `protocol_amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|active|retired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `reason_for_amendment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|completed|requires_revision');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `sponsor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `total_sites_impacted` SET TAGS ('dbx_business_glossary_term' = 'Total Sites Impacted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (Protocol Amendment)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_amendment` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|active|retired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `study_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Study Visit Identifier (SV_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Coordinator Identifier (COORD_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject Identifier (SUBJ_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `actual_visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Visit Timestamp (AV_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Description (AE_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `adverse_event_reported` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reported Flag (AE_REPORTED)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Compliance Flag (PC_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RC_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `data_collection_status` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Status (DCS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `data_collection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `data_locked` SET TAGS ('dbx_business_glossary_term' = 'Data Locked Flag (DL_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RU_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Visit Duration (Minutes) (VD_MIN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('dbx_business_glossary_term' = 'Study Visit Name (SV_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes (VN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Study Visit Sequence Number (SV_SEQ)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason (VR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status (VS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|missed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type (VT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'screening|baseline|treatment|follow_up|end_of_study|unscheduled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_early_allowed` SET TAGS ('dbx_business_glossary_term' = 'Early Window Allowed Flag (EW_ALLOWED)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_end` SET TAGS ('dbx_business_glossary_term' = 'Visit Window End Date (VW_END)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_late_allowed` SET TAGS ('dbx_business_glossary_term' = 'Late Window Allowed Flag (LW_ALLOWED)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_start` SET TAGS ('dbx_business_glossary_term' = 'Visit Window Start Date (VW_START)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Window Type (VW_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_type` SET TAGS ('dbx_value_regex' = 'planned|early|late');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Visit Location (VL)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Study Coordinator Identifier (COORD_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Identifier (PROT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject Identifier (SUBJ_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RC_BY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `adverse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Health Alert Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `rpm_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Reading Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `additional_notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `adverse_event_status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `adverse_event_status` SET TAGS ('dbx_value_regex' = 'open|closed|under_review|resolved');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `ae_term` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Term (MedDRA)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `ae_term_code` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event MedDRA Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `capa_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `causality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Causality Assessment');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `causality_assessment` SET TAGS ('dbx_value_regex' = 'related|not_related|unknown');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Category');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'eligibility|dosing|visit_window|consent|data_collection');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Severity');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_value_regex' = 'minor|major|important');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Number (AE Number)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `event_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Reported Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'adverse_event|protocol_deviation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Expedited Reporting Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_contact` SET TAGS ('dbx_business_glossary_term' = 'Investigator Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_contact` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_contact` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_contact` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Investigator Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `irb_reportable` SET TAGS ('dbx_business_glossary_term' = 'IRB Reportable Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Event Outcome');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'recovered|recovering|not_recovered|fatal|unknown');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `seriousness_criteria` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `seriousness_criteria` SET TAGS ('dbx_value_regex' = 'death|life_threatening|hospitalization|disability|congenital_anomaly|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `severity_grade` SET TAGS ('dbx_business_glossary_term' = 'Severity Grade (CTCAE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `sponsor_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Reportable Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|closed|under_review|resolved');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Identifier (IP_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Clinical Trial Identifier (TRIAL_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reporting Required (AE_REPORT_REQ)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status (BLINDING_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `blinding_status` SET TAGS ('dbx_value_regex' = 'open-label|single-blind|double-blind');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `comparator_indicator` SET TAGS ('dbx_business_glossary_term' = 'Comparator/Placebo Indicator (COMPARATOR_IND)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `data_sharing_restriction` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Restriction (DATA_SHARING_RESTR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `data_sharing_restriction` SET TAGS ('dbx_value_regex' = 'restricted|unrestricted|de-identified');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DEVICE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `device_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form (DOSAGE_FORM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `dosage_form` SET TAGS ('dbx_value_regex' = 'tablet|injection|infusion|implant|cream|gel');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `enrollment_current` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count (ENROLL_CURRENT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `enrollment_target` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Target (ENROLL_TARGET)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRY_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `formulation` SET TAGS ('dbx_business_glossary_term' = 'Formulation Description (FORMULATION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `ide_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational Device Exemption Number (IDE_NUMBER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `ind_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational New Drug Number (IND_NUMBER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `investigational_product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description (DESCRIPTION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `investigational_product_name` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Name (IP_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `investigational_product_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `investigational_product_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|completed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `lot_number_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Number Tracking Flag (LOT_TRACK_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name (MANUFACTURER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code (PROD_CODE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type (PROD_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'drug|device|biologic');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date (REG_APPROVAL_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'IND|IDE|FDA_Approved|Pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name (SPONSOR_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements (STORAGE_REQ)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `strength_unit` SET TAGS ('dbx_business_glossary_term' = 'Strength Unit (STRENGTH_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `strength_value` SET TAGS ('dbx_business_glossary_term' = 'Strength Value (STRENGTH_VAL)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Study Phase (STUDY_PHASE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `study_phase` SET TAGS ('dbx_value_regex' = 'Phase_I|Phase_II|Phase_III|Phase_IV');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `temperature_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required (TEMP_MON_REQ)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `temperature_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (TEMP_MAX)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `temperature_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (TEMP_MIN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Name (IP_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|completed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Product Description (DESCRIPTION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product` ALTER COLUMN `clinical_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Clinical Trial Identifier (TRIAL_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dispensation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Dispensation ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (STUDY_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (SUBJECT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (VISIT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `chain_of_custody_signature` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Signature');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensation_date` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_name` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('dbx_business_glossary_term' = 'Dose Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dispensation_status` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dispensation_status` SET TAGS ('dbx_value_regex' = 'dispensed|cancelled|returned');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dispensing_location` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Location');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dose_amount` SET TAGS ('dbx_business_glossary_term' = 'Dose Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Dose Unit');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dose_unit` SET TAGS ('dbx_value_regex' = 'mg|ml|units');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_route_of_administration` SET TAGS ('dbx_value_regex' = 'oral|iv|im|sc|inhalation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `kit_number` SET TAGS ('dbx_business_glossary_term' = 'Kit Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('dbx_business_glossary_term' = 'Missed Doses');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `returned_units` SET TAGS ('dbx_business_glossary_term' = 'Returned Units');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (STUDY_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (SUBJECT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensing_pharmacist_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'dispensed|cancelled|returned');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_product_code` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_product_name` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_product_type` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_product_type` SET TAGS ('dbx_value_regex' = 'drug|device|biologic');
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('dbx_business_glossary_term' = 'Biospecimen Identifier (BIOSPECIMEN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Laboratory Identifier (LAB_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `genomics_genomic_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequence Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `informed_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier (CONSENT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PATIENT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (STUDY_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_number` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Sequence Number (ALIQUOT_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_type` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Type (ALIQUOT_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|aliquot|derived');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_volume` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Volume (ALIQUOT_VOLUME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Volume Unit (ALIQUOT_VOL_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_volume_unit` SET TAGS ('dbx_value_regex' = 'ml|ul|l');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `anatomical_site` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Site of Collection (ANATOMICAL_SITE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Specimen Barcode (BARCODE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('dbx_business_glossary_term' = 'Specimen Lifecycle Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_status` SET TAGS ('dbx_value_regex' = 'collected|processed|stored|shipped|disposed|archived');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Method (COLLECTION_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'venipuncture|biopsy|swab|aspiration|surgical');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Timestamp (COLLECTION_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `deidentification_status` SET TAGS ('dbx_business_glossary_term' = 'De-identification Status (DEID_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `deidentification_status` SET TAGS ('dbx_value_regex' = 'deidentified|identified|partial');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Disposal Date (DISPOSAL_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Specimen Disposal Method (DISPOSAL_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|chemical|return|donation|recycle');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Specimen Disposition (DISPOSITION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'analyzed|stored|destroyed|shipped');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Processing Date (PROCESSING_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `processing_method` SET TAGS ('dbx_business_glossary_term' = 'Specimen Processing Method (PROCESSING_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `qc_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Date (QC_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `qc_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Passed Flag (QC_PASSED)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status (QC_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `shipping_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Shipping Date (SHIPPING_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Specimen Shipping Method (SHIPPING_METHOD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'courier|mail|hand_deliver|pickup');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `shipping_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Tracking Number (TRACKING_NUMBER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type (SPECIMEN_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|tissue|urine|saliva|csf|plasma');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_box` SET TAGS ('dbx_business_glossary_term' = 'Storage Box Identifier (STORAGE_BOX)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Description (STORAGE_LOCATION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_position` SET TAGS ('dbx_business_glossary_term' = 'Storage Position within Box (STORAGE_POSITION)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_rack` SET TAGS ('dbx_business_glossary_term' = 'Storage Rack Identifier (STORAGE_RACK)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Status (STORAGE_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_status` SET TAGS ('dbx_value_regex' = 'available|in_use|maintenance|quarantined|depleted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (STORAGE_TEMP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Unit (TEMP_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `storage_temperature_unit` SET TAGS ('dbx_value_regex' = 'C|F|K');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Specimen Volume (VOLUME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit (VOL_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'ml|ul|l');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Specimen Weight (WEIGHT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit (WEIGHT_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'g|mg|kg');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (STUDY_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PATIENT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier (CONSENT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Specimen Lifecycle Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'collected|processed|stored|shipped|disposed|archived');
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ALTER COLUMN `processing_lab_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Laboratory Identifier (LAB_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_safety_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Record ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `dsmb_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Board Identifier (DSMBID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier (SPID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (CTID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|restricted|confidential');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_value_regex' = '5_years|10_years|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_safety_monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Record Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_safety_monitoring_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Action');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Due Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('dbx_value_regex' = 'interim|final|ad_hoc');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `minutes_document_path` SET TAGS ('dbx_business_glossary_term' = 'Minutes Document Path');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `monitoring_number` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Record Number (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'DSMB Recommendation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `recommendation` SET TAGS ('dbx_value_regex' = 'continue|modify|suspend|terminate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `recommendation_details` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Details');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `safety_event_summary` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Summary');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `unblinding_date` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `unblinding_event` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Event Indicator');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier (SPID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `dsm_board_id` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Board Identifier (DSMBID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Record Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `billing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Event Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (CLM_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `coverage_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier (ANLST_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Research Grant Identifier (GRNT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier (SPN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Date (ANL_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPR_STS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `billing_category` SET TAGS ('dbx_business_glossary_term' = 'Billing Category (BILL_CAT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `billing_category` SET TAGS ('dbx_value_regex' = 'research|standard|sponsor');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `billing_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status (EVT_STS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `billing_event_status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|cancelled|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `charge_quantity` SET TAGS ('dbx_business_glossary_term' = 'Charge Quantity (CHG_QTY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type (CHG_TP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'service|procedure|device|drug');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `charge_unit` SET TAGS ('dbx_business_glossary_term' = 'Charge Unit (CHG_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `charge_unit` SET TAGS ('dbx_value_regex' = 'unit|session|dose|hour|day');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `cms_ncd_reference` SET TAGS ('dbx_business_glossary_term' = 'CMS NCD Reference (CMS_NCD_REF)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination (COV_DET)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_value_regex' = 'sponsor_billable|medicare_billable|institutional_cost');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `coverage_rationale` SET TAGS ('dbx_business_glossary_term' = 'Coverage Rationale (COV_RAT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `eligibility_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Version (ELIG_VER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number (EVT_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (EVT_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `financial_account_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Account Code (FIN_ACCT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (GRS_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag (ELIG_FLG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTE)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `payer` SET TAGS ('dbx_business_glossary_term' = 'Payer Type (PYR_TP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `payer` SET TAGS ('dbx_value_regex' = 'medicare|medicaid|commercial|self_pay|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number (POL_NO)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version (PRTCL_VER)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (RET_YRS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `service_cpt_code` SET TAGS ('dbx_business_glossary_term' = 'CPT Code (CPT_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date (SRV_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description (SRV_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `service_hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code (HCPCS_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_grant_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Grant Number (SPN_GRNT_NO)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Event Status (EVT_STS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|cancelled|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier (SPN_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Protocol Identifier (PRTCL_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ALTER COLUMN `analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier (ANLST_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `research_grant_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Grant ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `award_abstract` SET TAGS ('dbx_business_glossary_term' = 'Award Abstract');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount (USD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `award_modifications` SET TAGS ('dbx_business_glossary_term' = 'Award Modifications');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `award_title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `award_url` SET TAGS ('dbx_business_glossary_term' = 'Award URL');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'FY2023|FY2024|FY2025|FY2026|FY2027|FY2028');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_business_glossary_term' = 'Co‑Investigator Names');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Direct Costs');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `funding_agency` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `grant_category` SET TAGS ('dbx_business_glossary_term' = 'Grant Category');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `grant_category` SET TAGS ('dbx_value_regex' = 'research|training|infrastructure|collaboration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'active|closed|suspended|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'R01|R21|K01|T32|U01|U54');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs (F&A)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `sponsor_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `sponsor_requirements` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Requirements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_code` SET TAGS ('dbx_business_glossary_term' = 'Accounting Code (ACC_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approval Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period (e.g., FY2024 Q1)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPL_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage (PCT_EFFORT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Amount (MONETARY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category (EXP_CAT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'personnel|supplies|equipment|travel|subcontract|indirect');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `expense_date` SET TAGS ('dbx_business_glossary_term' = 'Expense Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_budget_line_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Line Code (BUD_LINE_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expense Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Grant Fiscal Year');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `indirect_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (PCT_INDIRECT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NO)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `is_indirect_cost` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code (PROJ_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `receipt_attached` SET TAGS ('dbx_business_glossary_term' = 'Receipt Attached Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `sponsor_cost_classification` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Cost Classification (SPON_COST_CLASS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (MONETARY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount (MONETARY)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Expense Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `budget_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `city` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `city` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `fda_21cfr11_compliant` SET TAGS ('dbx_business_glossary_term' = 'FDA 21 CFR Part 11 Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `is_bla_holder` SET TAGS ('dbx_business_glossary_term' = 'BLA Holder Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `is_cro_relationship` SET TAGS ('dbx_business_glossary_term' = 'Contract Research Organization Relationship Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `is_ndaholder` SET TAGS ('dbx_business_glossary_term' = 'NDA Holder Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `overhead_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percent');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_schedule_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Terms');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_rate` SET TAGS ('dbx_business_glossary_term' = 'Per‑Procedure Reimbursement Rate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `per_visit_rate` SET TAGS ('dbx_business_glossary_term' = 'Per‑Visit Reimbursement Rate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `screen_failure_allowance` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Allowance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_value_regex' = 'pharma|biotech|device|government|foundation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `startup_cost` SET TAGS ('dbx_business_glossary_term' = 'Startup Cost');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `study_sponsor_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `study_sponsor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `coverage_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_identifier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Identifier (CAID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Type (CAT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_value_regex' = 'standard_of_care|research_specific');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Full Name (AN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `coverage_decision` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision (CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `coverage_decision` SET TAGS ('dbx_value_regex' = 'billable_to_insurance|billable_to_sponsor');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `cpt_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'CPT Codes Reviewed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `determination_rationale` SET TAGS ('dbx_business_glossary_term' = 'Determination Rationale (DR)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `determination_status` SET TAGS ('dbx_business_glossary_term' = 'Determination Status (DS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `determination_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `hcpcs_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Codes Reviewed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Protocol ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `research_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Research Regulatory Submission ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `amendment_of_research_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Amended From Submission ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency` SET TAGS ('dbx_value_regex' = 'FDA|NIH|OHRP|EMA|PMDA');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_submission_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Submission Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|restricted|confidential');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `fee_paid` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Indicator');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Submission Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Category');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_value_regex' = 'drug|device|biologic|combination|behavioral');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `related_documents` SET TAGS ('dbx_business_glossary_term' = 'Related Document IDs');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Response Summary');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `response_type` SET TAGS ('dbx_value_regex' = 'approval|clinical_hold|request_for_info|rejection');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_file_path` SET TAGS ('dbx_business_glossary_term' = 'Submission File Path');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'eCTD|paper|electronic|portal');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'IND|IDE|NDA|BLA|AnnualReport|SafetyReport');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_value_regex' = 'oncology|cardiology|neurology|immunology|infectious_disease');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `amendment_of_id` SET TAGS ('dbx_business_glossary_term' = 'Amended From Submission ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitoring_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Visit ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Monitor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `adverse_event_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reported Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `data_discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Discrepancy Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `findings_details` SET TAGS ('dbx_business_glossary_term' = 'Findings Details');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_name` SET TAGS ('dbx_business_glossary_term' = 'Monitor Full Name (NAME)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `report_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Report Completion Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Study Site Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'initiation|routine|close_out|for_cause');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_id` SET TAGS ('dbx_business_glossary_term' = 'Monitor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `research_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site (Facility) ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject (Patient) ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `capa_completed` SET TAGS ('dbx_business_glossary_term' = 'CAPA Completed Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `capa_completed` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Completion Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `clinical_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Clinical Monitoring Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `clinical_monitoring_required` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `data_review_date` SET TAGS ('dbx_business_glossary_term' = 'Data Review Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `data_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Data Reviewed Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `data_reviewed` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'eligibility|dosing|visit_window|consent|data_collection');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deviation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `finalized` SET TAGS ('dbx_business_glossary_term' = 'Finalized Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `finalized` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `impact_on_data_integrity` SET TAGS ('dbx_business_glossary_term' = 'Impact on Data Integrity');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `impact_on_subject_safety` SET TAGS ('dbx_business_glossary_term' = 'Impact on Subject Safety');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Notification Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_notified` SET TAGS ('dbx_business_glossary_term' = 'IRB Notified Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_notified` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_reportable` SET TAGS ('dbx_business_glossary_term' = 'IRB Reportable');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_reportable` SET TAGS ('dbx_value_regex' = 'yes|no|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_deviation_status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|closed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Deviation Severity');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|major|important');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notification Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_notified` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notified Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_notified` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Reportable');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_reportable` SET TAGS ('dbx_value_regex' = 'yes|no|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Subject (Patient) ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site (Facility) ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|closed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ALTER COLUMN `document_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentified_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'De-identified Dataset ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_governance_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Committee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_count` SET TAGS ('dbx_business_glossary_term' = 'Access Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_end_date` SET TAGS ('dbx_business_glossary_term' = 'Access End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_start_date` SET TAGS ('dbx_business_glossary_term' = 'Access Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'internal|limited|fully_deidentified');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `approved_use_cases` SET TAGS ('dbx_business_glossary_term' = 'Approved Use Cases');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_destruction_certified` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Certified');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_elements` SET TAGS ('dbx_business_glossary_term' = 'Data Elements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_sharing_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_category` SET TAGS ('dbx_business_glossary_term' = 'Dataset Category');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Dataset Size (Bytes)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_version` SET TAGS ('dbx_business_glossary_term' = 'Dataset Version');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Dataset End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Dataset Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Access Decision');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_date` SET TAGS ('dbx_business_glossary_term' = 'De-identification Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_detail` SET TAGS ('dbx_business_glossary_term' = 'De-identification Detail');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_method` SET TAGS ('dbx_business_glossary_term' = 'De-identification Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_method` SET TAGS ('dbx_value_regex' = 'safe_harbor|expert_determination');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentified_dataset_description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentified_dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Dataset Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dua_status` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dua_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `irb_approval_ref` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `irb_waiver_ref` SET TAGS ('dbx_business_glossary_term' = 'IRB Waiver Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Record Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `request_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_institution` SET TAGS ('dbx_business_glossary_term' = 'Requestor Institution');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `sensitivity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `source_systems` SET TAGS ('dbx_business_glossary_term' = 'Source Systems');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `version_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `name` SET TAGS ('dbx_business_glossary_term' = 'Dataset Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`deidentified_dataset` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_access_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Access Request ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_governance_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Committee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `deidentified_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Deidentified Dataset Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `access_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Expiration Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `access_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|conditional');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_destruction_cert_required` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Certification Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'csv|json|parquet|xml|sas|spss');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_use_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_use_agreement_status` SET TAGS ('dbx_value_regex' = 'pending|signed|rejected|expired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `data_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Requested Data Volume (GB)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `intended_use_description` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `irb_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Reference');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `request_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Review Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|denied|revoked|closed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `request_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_institution` SET TAGS ('dbx_business_glossary_term' = 'Requestor Institution');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_role` SET TAGS ('dbx_business_glossary_term' = 'Requestor Role');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_role` SET TAGS ('dbx_value_regex' = 'researcher|analyst|external_collaborator|student|faculty');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Dataset Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `dataset_description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `dataset_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Dataset Sensitivity Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ALTER COLUMN `dataset_sensitivity_level` SET TAGS ('dbx_value_regex' = 'deidentified|limited|restricted|sensitive|public');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `study_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Study Budget ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `clinician_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `primary_study_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Research Grant Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expiration Notice Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_review_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Review Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'clinical_trial|observational|preclinical');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'federal|industry|institution|philanthropy');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `is_indirect_costs_included` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs Included Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `payment_milestone_1_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone 1 Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `payment_milestone_1_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone 1 Due Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `payment_milestone_2_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone 2 Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `payment_milestone_2_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone 2 Due Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `payment_milestone_3_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone 3 Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `payment_milestone_3_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone 3 Due Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `per_procedure_rate` SET TAGS ('dbx_business_glossary_term' = 'Per‑Procedure Rate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `per_visit_rate` SET TAGS ('dbx_business_glossary_term' = 'Per‑Visit Rate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `screen_failure_allowance` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Allowance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `startup_costs` SET TAGS ('dbx_business_glossary_term' = 'Startup Costs');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `study_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `study_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `study_budget_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `consent_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Template Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `previous_version_consent_template_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `consent_form_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `consent_form_type` SET TAGS ('dbx_value_regex' = 'full|short|assent|hipaa_authorization');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `consent_template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `consent_template_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|retired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|html');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `electronic_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `file_hash` SET TAGS ('dbx_business_glossary_term' = 'File SHA‑256 Hash');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `file_hash` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639‑1)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `part_11_compliant` SET TAGS ('dbx_business_glossary_term' = '21 CFR Part 11 Compliant');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `required_elements_checklist` SET TAGS ('dbx_business_glossary_term' = 'Required Elements Checklist');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Template Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `version_notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|retired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `previous_version_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `study_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `actual_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `arm_code` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `arm_sequence` SET TAGS ('dbx_business_glossary_term' = 'Arm Sequence Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `arm_type` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `arm_type` SET TAGS ('dbx_value_regex' = 'experimental|active_comparator|placebo|sham|observational');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `blinding` SET TAGS ('dbx_business_glossary_term' = 'Blinding Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `blinding` SET TAGS ('dbx_value_regex' = 'open|single|double|triple');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('dbx_business_glossary_term' = 'Dose Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `eligibility_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Summary');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Arm Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `exclusion_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria Summary');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `inclusion_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria Summary');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Intervention Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'drug|device|procedure|behavioral|biologic');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `planned_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Planned Enrollment Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `randomization_ratio` SET TAGS ('dbx_business_glossary_term' = 'Randomization Ratio');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `randomization_ratio` SET TAGS ('dbx_value_regex' = '^d+:d+$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Arm Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Arm Status Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `stratification_factors` SET TAGS ('dbx_business_glossary_term' = 'Stratification Factors');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `study_arm_status` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `study_arm_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|paused|completed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|paused|completed');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `study_partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Study Partner Agreement ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'data_sharing|service_provision|financial|collaboration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_value_regex' = 'hipaa|gdpr|ccpa|none');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed By');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_access_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Data Access Approval Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_access_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Data Access Endpoint');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'json|xml|csv|hl7|fhir');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_quality_assurance` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assurance Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_value_regex' = 'full|partial|de_identified|aggregated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_transfer_method` SET TAGS ('dbx_business_glossary_term' = 'Data Transfer Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_transfer_method` SET TAGS ('dbx_value_regex' = 'api|sftp|ftp|email|physical_media');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_use_limitations` SET TAGS ('dbx_business_glossary_term' = 'Data Use Limitations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_role` SET TAGS ('dbx_business_glossary_term' = 'Partner Role');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_role` SET TAGS ('dbx_value_regex' = 'sponsor|contract_research_organization|central_lab|imaging_core|data_coordinating_center|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_required');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `sla_end_date` SET TAGS ('dbx_business_glossary_term' = 'SLA End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `sla_start_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Terms');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `study_partner_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `study_partner_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `grant_personnel_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Personnel ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'new|renewal|supplemental|extension');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_description` SET TAGS ('dbx_business_glossary_term' = 'Effort Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_fte` SET TAGS ('dbx_business_glossary_term' = 'Effort FTE');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_type` SET TAGS ('dbx_business_glossary_term' = 'Effort Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_type` SET TAGS ('dbx_value_regex' = 'salary|effort|both');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'federal|state|private|industry|institutional');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `grant_personnel_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `grant_personnel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `is_co_pi` SET TAGS ('dbx_business_glossary_term' = 'Co‑PI Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `is_primary_investigator` SET TAGS ('dbx_business_glossary_term' = 'Primary Investigator Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `is_subaward` SET TAGS ('dbx_business_glossary_term' = 'Subaward Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `role_on_grant` SET TAGS ('dbx_business_glossary_term' = 'Role on Grant');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `role_on_grant` SET TAGS ('dbx_value_regex' = 'pi|co_pi|investigator|coordinator|admin|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Allocation Amount');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_allocation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_allocation_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_allocation_amount` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_allocation_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_allocation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` SET TAGS ('dbx_subdomain' = 'subject_operations');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_product_training_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Training ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `education_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `competency_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Competency Verification Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `competency_verified` SET TAGS ('dbx_business_glossary_term' = 'Competency Verified Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Trainer Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `trainer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Mode');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_mode` SET TAGS ('dbx_value_regex' = 'in_person|online|virtual|blended');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'handling|administration|storage|safety|regulatory');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_id` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Document ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `data_access_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Access Request Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `deidentified_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Deidentified Dataset Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'research|clinical|data_sharing|collaboration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `authorized_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Data Categories');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `data_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Purpose');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `data_retention_period` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `data_subjects` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `digital_signature_hash` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Hash');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Document Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_entity_type' = 'Clean boilerplate phrase from research.dua_document.description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_entity_type' = 'Cleaned boilerplate description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_research_dua_document_description' = 'Removed boilerplate phrase');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_research_dua_document' = 'clean boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_research_dua_document_description' = 'Cleaned description without boilerplate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_description` SET TAGS ('dbx_research_dua_document_description' = 'Cleaned boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_status` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_text` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `dua_text` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `parties_involved` SET TAGS ('dbx_business_glossary_term' = 'Parties Involved');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Use Restrictions');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|wet_ink|none');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Title');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_name` SET TAGS ('dbx_business_glossary_term' = 'Researcher Full Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_email` SET TAGS ('dbx_business_glossary_term' = 'Researcher Email Address');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_phone` SET TAGS ('dbx_business_glossary_term' = 'Researcher Phone Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `researcher_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `institution_name` SET TAGS ('dbx_business_glossary_term' = 'Institution Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dua_document` ALTER COLUMN `created_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_governance_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Committee Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Email Address');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Full Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `charter_document_url` SET TAGS ('dbx_business_glossary_term' = 'Charter Document URL');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_code` SET TAGS ('dbx_business_glossary_term' = 'Committee Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_value_regex' = 'irb|data_access|safety|ethics|compliance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Committee Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|secret');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_governance_committee_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_governance_committee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Meeting Day of Week');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_day_of_week` SET TAGS ('dbx_value_regex' = 'Mon|Tue|Wed|Thu|Fri|Sat');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annually');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_minutes_summary` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_minutes_summary` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_minutes_summary` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting Time (HH:MM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Committee Member Count');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Committee Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_governance_committee` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `dsmb_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data and Safety Monitoring Board Committee ID (DSMB_CMTE_ID)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Email Address (CHP_PRSN_EMAIL)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Full Name (CHP_PRSN_NM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Phone Number (CHP_PRSN_PHN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `charter_document_path` SET TAGS ('dbx_business_glossary_term' = 'Charter Document Path (CHRT_DOC_PATH)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_code` SET TAGS ('dbx_business_glossary_term' = 'Committee Code (CMTE_CD)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name (CMTE_NM)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type (CMTE_TP)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_value_regex' = 'safety|efficacy|data|ethics');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (CMPL_NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy (DATA_RET_POL)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `dsmb_committee_description` SET TAGS ('dbx_business_glossary_term' = 'Committee Description (CMTE_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `dsmb_committee_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status (CMTE_STS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `dsmb_committee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_STRT_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation (HIPAA_RET_ANN)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential (IS_CONF)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Meeting (IS_VRT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meeting Date (LST_MTG_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency (MTG_FRQ)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location (MTG_LOC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_time_zone` SET TAGS ('dbx_business_glossary_term' = 'Meeting Time Zone (MTG_TZ)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count (MBR_CNT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `minutes_document_path` SET TAGS ('dbx_business_glossary_term' = 'Meeting Minutes Document Path (MTG_MIN_PATH)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Meeting Date (NXT_MTG_DT)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPR_STS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `virtual_meeting_link` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting Link (VRT_MTG_LINK)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status (CMTE_STS)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`research`.`dsmb_committee` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Committee Description (CMTE_DESC)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_id` SET TAGS ('dbx_business_glossary_term' = 'Research Document ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Protocol Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Related Clinical Trial Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Document Abstract');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'internal|external|restricted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Author Affiliation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_business_glossary_term' = 'Author Email Address');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Full Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (SHA256)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Document Classification');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'public|restricted|confidential|internal');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `deprecated_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Deprecation');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|HTML|TXT|Other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = 'English|Spanish|French|German|Chinese|Other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Document');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'protocol|consent|report|analysis|summary|other');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Document Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `ethics_review_status` SET TAGS ('dbx_business_glossary_term' = 'Ethics Review Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `ethics_review_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File System Path');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Document Keywords');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_entity_type' = 'Clean boilerplate phrase from research.research_document.description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_entity_type' = 'Cleaned boilerplate description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_entity_type' = 'Cleaned boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_research_research_document_description' = 'Removed boilerplate phrase');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_research_research_document' = 'clean boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_research_research_document_description' = 'Cleaned description without boilerplate');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_description` SET TAGS ('dbx_research_research_document_description' = 'Cleaned boilerplate phrase from description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `research_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|retracted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Email Address');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Full Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|retracted');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `related_study_id` SET TAGS ('dbx_business_glossary_term' = 'Related Study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `related_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Related Clinical Trial Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ALTER COLUMN `external_reference_id` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `research_grant_record_id` SET TAGS ('dbx_business_glossary_term' = 'research_grant_record Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Research Grant Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `salary_cap_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `salary_cap_applicable` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` SET TAGS ('dbx_subdomain' = 'financial_administration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'research_grant Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `funding_agency` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `award_title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `award_abstract` SET TAGS ('dbx_business_glossary_term' = 'Award Abstract');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Direct Costs');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs (F&A)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_business_glossary_term' = 'Co‑Investigator Names');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Code');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'FY2023|FY2024|FY2025|FY2026|FY2027|FY2028');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `grant_category` SET TAGS ('dbx_business_glossary_term' = 'Grant Category');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `grant_category` SET TAGS ('dbx_value_regex' = 'research|training|infrastructure|collaboration');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'active|closed|suspended|pending|terminated');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_requirements` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Requirements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `award_modifications` SET TAGS ('dbx_business_glossary_term' = 'Award Modifications');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ALTER COLUMN `award_url` SET TAGS ('dbx_business_glossary_term' = 'Award URL');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_eligibility_criterion` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_eligibility_criterion` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ALTER COLUMN `model_version_id` SET TAGS ('dbx_business_glossary_term' = 'Matching Model Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_criteria` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `trial_matching_id` SET TAGS ('dbx_business_glossary_term' = 'trial_matching Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `age_at_evaluation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `age_at_evaluation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `prior_treatment_match_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ALTER COLUMN `prior_treatment_match_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `research_trial_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'research_trial_eligibility_criteria Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `excluded_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `excluded_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `gender_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `gender_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `required_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ALTER COLUMN `required_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` SET TAGS ('dbx_subdomain' = 'trial_matching');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` SET TAGS ('dbx_association_edges' = 'research.research_study,genomics.genomic_test_result');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `study_genomic_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Study Genomic Eligibility ID');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Study Genomic Eligibility - Genomic Test Result Id');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Genomic Eligibility - Research Study Id');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Clinician');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `biomarker_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Requirement Type');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Mapping Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Mapping Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `inclusion_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Inclusion/Exclusion Flag');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Match Status');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `required_variant` SET TAGS ('dbx_business_glossary_term' = 'Required Variant');
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Review Date');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `institutional_review_board_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `chairperson_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `chairperson_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `office_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `office_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `office_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `office_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ALTER COLUMN `protocol_version_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Identifier');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ALTER COLUMN `treatment_duration_days` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ALTER COLUMN `treatment_duration_days` SET TAGS ('dbx_pii' = 'true');
