-- Schema for Domain: consent | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`consent` COMMENT 'Enterprise consent management for patient treatment consent, research consent, data sharing authorizations, HIPAA authorizations, HIE opt-in/opt-out, and telehealth consent. SSOT for all consent records across clinical, research, and administrative contexts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`form_template` (
    `form_template_id` BIGINT COMMENT 'Surrogate primary key',
    `primary_superseded_by_form_template_id` BIGINT COMMENT 'FK to newer version of this form template',
    `applicable_facility_types` STRING COMMENT 'Facility types where this form applies',
    `applicable_service_lines` STRING COMMENT 'Service lines where this form applies',
    `approval_authority` STRING COMMENT 'Authority that approved this form',
    `approval_date` DATE COMMENT 'Date form was approved',
    `consent_category` STRING COMMENT 'Category: treatment, research, HIE, HIPAA',
    `consent_subcategory` STRING COMMENT 'Subcategory within category',
    `created_by_user` STRING COMMENT 'User who created form template',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Date form becomes effective',
    `electronic_signature_enabled_flag` BOOLEAN COMMENT 'True if electronic signature is allowed',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date form expires',
    `form_checksum` STRING COMMENT 'Checksum for form integrity verification',
    `form_code` STRING COMMENT 'Unique code for form template',
    `form_document_url` STRING COMMENT 'URL to form document',
    `form_name` STRING COMMENT 'Name of form template',
    `form_purpose` STRING COMMENT 'Purpose of consent form',
    `form_status` STRING COMMENT 'Status: draft, active, retired',
    `interpreter_required_flag` BOOLEAN COMMENT 'True if interpreter is required',
    `irb_approval_date` DATE COMMENT 'IRB approval date for research forms',
    `irb_approval_number` STRING COMMENT 'IRB approval number',
    `irb_expiration_date` DECIMAL(18,2) COMMENT 'IRB approval expiration date',
    `language_code` STRING COMMENT 'Language of form',
    `legal_representative_allowed_flag` BOOLEAN COMMENT 'True if legal representative can sign',
    `minimum_age_requirement` STRING COMMENT 'Minimum age to consent',
    `minor_assent_required_flag` BOOLEAN COMMENT 'True if minor assent is required',
    `modified_by_user` STRING COMMENT 'User who last modified form',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `reading_level` STRING COMMENT 'Reading level of form',
    `regulatory_basis` STRING COMMENT 'Regulatory basis for form',
    `retention_period_years` STRING COMMENT 'Years to retain signed forms',
    `revocation_allowed_flag` BOOLEAN COMMENT 'True if consent can be revoked',
    `revocation_instructions` STRING COMMENT 'Instructions for revoking consent',
    `scope_of_consent` STRING COMMENT 'Scope of consent covered by form',
    `version_number` STRING COMMENT 'Version number of form',
    `witness_required_flag` BOOLEAN COMMENT 'True if witness is required',
    CONSTRAINT pk_form_template PRIMARY KEY(`form_template_id`)
) COMMENT 'Consent form template library storing approved consent form versions with regulatory basis, IRB approval, language translations, and versioning. Supports form lifecycle management and compliance tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` (
    `hipaa_authorization_id` BIGINT COMMENT 'Surrogate primary key',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HIPAA authorizations identify the covered entity releasing PHI. disclosing_party_name and disclosing_party_npi are denormalized org_provider attributes. Normalizing via FK supports payer enrollment va',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: HIPAA authorization compliance audits and breach investigations require identifying the disclosing party via their NPI registry record. disclosing_party_npi is a plain-text denormalization of the NPI ',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: hipaa_authorization currently stores form_version as a denormalized STRING. Adding form_template_id as a FK to form_template normalizes this relationship, allowing direct lookup of the approved form v',
    `record_id` BIGINT COMMENT 'FK to consent record',
    `superseded_hipaa_authorization_id` BIGINT COMMENT 'Self-FK to prior version',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `authorization_purpose` STRING COMMENT 'Purpose of authorization',
    `authorization_purpose_description` STRING COMMENT 'Detailed purpose description',
    `compensation_disclosure_flag` BOOLEAN COMMENT 'True if compensation was disclosed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `document_reference` STRING COMMENT 'Reference to authorization document',
    `expiration_event` DECIMAL(18,2) COMMENT 'Event that triggers expiration',
    `irb_approval_number` STRING COMMENT 'IRB approval number',
    `language_code` STRING COMMENT 'Language code',
    `last_updated_by` STRING COMMENT 'User who last updated record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `mrn` STRING COMMENT 'Patient MRN',
    `notes` STRING COMMENT 'Free-text notes',
    `personal_representative_flag` BOOLEAN COMMENT 'True if personal representative signed',
    `personal_representative_name` STRING COMMENT 'Name of personal representative',
    `personal_representative_relationship` STRING COMMENT 'Relationship to patient',
    `phi_category` STRING COMMENT 'Category of PHI to be disclosed',
    `phi_description` STRING COMMENT 'Description of PHI',
    `recipient_address` STRING COMMENT 'Address of recipient',
    `recipient_name` STRING COMMENT 'Name of recipient',
    `recipient_organization` STRING COMMENT 'Organization of recipient',
    `redisclosure_statement` STRING COMMENT 'Statement about redisclosure',
    `right_to_revoke_statement` STRING COMMENT 'Statement about right to revoke',
    `signature_date` DATE COMMENT 'Date of signature',
    `signature_method` STRING COMMENT 'Method of signature',
    `signature_obtained_flag` BOOLEAN COMMENT 'True if signature was obtained',
    `witness_name` STRING COMMENT 'Name of witness',
    `witness_signature_date` DATE COMMENT 'Date of witness signature',
    `created_by` STRING COMMENT 'User who created record',
    CONSTRAINT pk_hipaa_authorization PRIMARY KEY(`hipaa_authorization_id`)
) COMMENT 'HIPAA authorization for use and disclosure of PHI beyond treatment/payment/operations. Captures recipient, purpose, PHI categories, expiration, and right to revoke per 45 CFR 164.508.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` (
    `treatment_consent_id` BIGINT COMMENT 'Unique identifier for the treatment consent record. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'The CPT or ICD-10-PCS code identifying the specific procedure or treatment being consented to. Applicable for procedure-specific consent types.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: treatment_consent stores consent_form_number and consent_version as denormalized STRING fields referencing the consent form used. Adding form_template_id as a FK to form_template normalizes this relat',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Consent validity audits and clinical documentation require linking treatment consent to the ICD diagnosis that clinically justifies the procedure. Payers and accreditation bodies verify that consented',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of this treatment consent.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication consent for high-alert drugs, chemotherapy, controlled substances, and investigational agents requires linking consent records to the specific NDC drug. Regulatory and accreditation standar',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Treatment consent is facility-specific — patients consent to procedures at a named facility. Privileging, credentialing, and Joint Commission standards require linking consent to the performing org_pr',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who performed the clinical assessment of the patients decision-making capacity.',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.record. Business justification: Treatment consent is a specialized type of consent record for medical procedures. Linking to the core record table enables unified consent management and reporting. Core consent lifecycle attributes (',
    `superseded_treatment_consent_id` BIGINT COMMENT 'Self-referencing FK on treatment_consent (superseded_treatment_consent_id)',
    `tertiary_treatment_performing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who will perform the procedure or treatment for which consent was obtained.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this consent was obtained.',
    `alternatives_documented` STRING COMMENT 'Narrative documentation of alternative treatment options that were disclosed to and discussed with the patient or authorized representative.',
    `benefits_documented` STRING COMMENT 'Narrative documentation of the expected benefits of the procedure or treatment that were disclosed to and discussed with the patient or authorized representative.',
    `capacity_determination` STRING COMMENT 'Clinical determination of whether the patient has decision-making capacity to provide informed consent for the treatment or procedure.. Valid values are `patient_has_capacity|patient_lacks_capacity|not_assessed`',
    `consent_document_location` STRING COMMENT 'Reference to the location or system where the signed consent document is stored (e.g., EMR document ID, scanned document repository path).',
    `consent_method` STRING COMMENT 'The method by which consent was obtained and documented (written signature, verbal consent documented by provider, electronic signature, telephonic consent with witness).. Valid values are `written|verbal|electronic|telephonic`',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this treatment consent record was first created in the system.',
    `emergency_exception_flag` BOOLEAN COMMENT 'Indicates whether treatment was provided under emergency exception provisions when informed consent could not be obtained due to the patients condition and no authorized representative was available.',
    `emergency_exception_justification` STRING COMMENT 'Clinical documentation justifying why treatment was provided without informed consent under emergency exception provisions.',
    `interpreter_language` STRING COMMENT 'The language in which interpretation services were provided during the consent process.',
    `interpreter_name` STRING COMMENT 'Full name of the medical interpreter who facilitated the consent discussion.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was required to facilitate the consent discussion due to language barriers or communication needs.',
    `last_updated_datetime` TIMESTAMP COMMENT 'The date and time when this treatment consent record was last modified in the system.',
    `legal_representative_name` STRING COMMENT 'Full name of the legal representative or authorized decision-maker who provided consent on behalf of the patient.',
    `legal_representative_phone` STRING COMMENT 'Contact phone number for the legal representative or authorized decision-maker.',
    `legal_representative_relationship` STRING COMMENT 'The legal or familial relationship of the representative to the patient (e.g., parent, legal guardian, healthcare proxy, durable power of attorney for healthcare, spouse, next of kin).. Valid values are `parent|guardian|healthcare_proxy|power_of_attorney|spouse|next_of_kin`',
    `legal_representative_required_flag` BOOLEAN COMMENT 'Indicates whether a legal representative or authorized decision-maker was required to provide consent on behalf of the patient due to lack of capacity.',
    `patient_questions_addressed_flag` BOOLEAN COMMENT 'Indicates whether the patient or authorized representative had the opportunity to ask questions and all questions were addressed prior to obtaining consent.',
    `patient_questions_notes` STRING COMMENT 'Free-text documentation of specific questions asked by the patient or authorized representative and the responses provided.',
    `revoked_by_name` STRING COMMENT 'Name of the individual (patient or authorized representative) who revoked the consent.',
    `risks_documented` STRING COMMENT 'Narrative documentation of the material risks of the procedure or treatment that were disclosed to and discussed with the patient or authorized representative.',
    `special_instructions` STRING COMMENT 'Any special instructions, limitations, or conditions specified by the patient or authorized representative as part of the consent (e.g., no blood products, specific anesthesia preferences).',
    `vibe_mutation_marker` STRING COMMENT '',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process and signed the consent form.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required on the consent form per organizational policy or regulatory requirement.',
    `witness_role` STRING COMMENT 'The role or title of the witness (e.g., registered nurse, social worker, patient advocate).',
    CONSTRAINT pk_treatment_consent PRIMARY KEY(`treatment_consent_id`)
) COMMENT 'Master record for general and procedure-specific treatment consent obtained from patients or their authorized representatives prior to clinical care. Captures consent type (general treatment, surgical, anesthesia, blood transfusion, chemotherapy, ECT, restraint), procedure or treatment being consented to, risks and benefits documented, alternatives discussed, patient questions addressed, capacity determination, and legal representative details when patient lacks decision-making capacity. Distinct from HIPAA authorization — governs clinical care delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`revocation` (
    `revocation_id` BIGINT COMMENT 'Unique identifier for the consent revocation record. Primary key for the consent revocation entity.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is revoking consent or on whose behalf consent is being revoked.',
    `prior_revocation_id` BIGINT COMMENT 'Self-referencing FK on revocation (prior_revocation_id)',
    `record_id` BIGINT COMMENT 'Reference to the original consent record being revoked. Links to the parent consent that this revocation applies to.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for all actions taken in response to this revocation, maintained for regulatory compliance.',
    `compliance_notes` STRING COMMENT 'Internal notes regarding compliance considerations, special handling requirements, or regulatory reporting obligations related to this revocation.',
    `data_access_restricted_flag` BOOLEAN COMMENT 'Indicates whether data access controls have been updated to restrict access based on the revoked consent.',
    `data_access_restricted_timestamp` TIMESTAMP COMMENT 'The date and time when data access restrictions were implemented in response to the consent revocation.',
    `disclosures_halted_flag` BOOLEAN COMMENT 'Indicates whether ongoing or future disclosures of Protected Health Information (PHI) have been halted as a result of this revocation.',
    `disclosures_halted_timestamp` TIMESTAMP COMMENT 'The date and time when disclosure processes were halted in response to the consent revocation.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or electronic copy of the signed revocation document, if applicable.',
    `effective_timestamp` TIMESTAMP COMMENT 'The date and time when the revocation became legally effective and operational systems began enforcing the withdrawal of consent. May differ from revocation_timestamp due to processing delays.',
    `irrevocable_actions_description` STRING COMMENT 'Free-text description of any actions taken under the original consent that cannot be reversed or undone despite the revocation (e.g., data already shared with third parties, research already conducted).',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required legal review has been completed for this revocation.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this revocation requires legal review before being processed (e.g., complex partial revocations, disputes, or high-risk scenarios).',
    `legal_review_timestamp` TIMESTAMP COMMENT 'The date and time when legal review of the revocation was completed.',
    `legal_reviewer_notes` STRING COMMENT 'Confidential notes from legal counsel regarding the revocation review, including any special handling instructions or risk assessments.',
    `method` STRING COMMENT 'The method or channel through which the patient submitted the consent revocation (e.g., written form, verbal communication, patient portal, email, fax, in-person). [ENUM-REF-CANDIDATE: written|verbal|electronic|portal|email|fax|in_person — 7 candidates stripped; promote to reference product]',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the revocation was sent to relevant parties (providers, research teams, business associates, etc.).',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when notifications regarding the consent revocation were sent to affected parties.',
    `partial_revocation_details` STRING COMMENT 'Free-text description of which specific portions of the consent are being revoked when revocation_scope is partial. Null when revocation is full.',
    `patient_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether confirmation notification was sent to the patient acknowledging receipt and processing of their revocation.',
    `patient_notification_timestamp` TIMESTAMP COMMENT 'The date and time when confirmation notification was sent to the patient regarding their consent revocation.',
    `prior_disclosures_count` STRING COMMENT 'The number of disclosures that occurred under the original consent prior to revocation and that cannot be undone or recalled.',
    `prior_disclosures_summary` STRING COMMENT 'Summary description of disclosures that occurred prior to revocation and cannot be undone, maintained for legal audit trail and patient notification.',
    `reason` STRING COMMENT 'Optional free-text explanation provided by the patient describing why they are revoking consent. May be blank if patient chose not to provide a reason.',
    `reason_code` STRING COMMENT 'Standardized categorical code representing the reason for consent revocation, used for reporting and analytics.. Valid values are `patient_request|privacy_concern|no_longer_needed|treatment_complete|other|not_provided`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent revocation record was first created in the data warehouse or lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent revocation record was last updated in the data warehouse or lakehouse.',
    `rejection_reason` STRING COMMENT 'Explanation of why the revocation was rejected, if applicable (e.g., invalid signature, unauthorized submitter, incomplete documentation).',
    `revocation_date` DATE COMMENT 'The calendar date on which the patient submitted the consent revocation. This is the effective date from which the consent is considered withdrawn.',
    `revocation_number` STRING COMMENT 'Business-facing unique identifier or tracking number assigned to this consent revocation for reference and audit purposes.',
    `revocation_status` STRING COMMENT 'Current processing status of the consent revocation within the organizations workflow (e.g., pending review, processed and effective, rejected due to invalid submission).. Valid values are `pending|processed|effective|rejected|cancelled`',
    `revocation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consent revocation was submitted or recorded in the system. Provides exact temporal audit trail for legal compliance.',
    `scope` STRING COMMENT 'Indicates whether the revocation applies to the entire consent (full) or only specific portions of the consent (partial).. Valid values are `full|partial`',
    `source_system_code` STRING COMMENT 'The unique identifier for this revocation record in the source operational system.',
    `vibe_mutation_marker` STRING COMMENT '',
    `witness_name` STRING COMMENT 'Name of the witness who was present when the revocation was submitted, if applicable (e.g., for verbal revocations or in-person submissions).',
    `witness_signature_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was obtained on the revocation document.',
    CONSTRAINT pk_revocation PRIMARY KEY(`revocation_id`)
) COMMENT 'Transactional record of every consent revocation submitted by a patient or their authorized representative. Captures revocation date and time, revocation method (written, verbal, electronic), reason for revocation (if provided), scope of revocation (full or partial), actions taken in response (notifications sent, data access restricted, disclosures halted), and any disclosures that occurred prior to revocation that cannot be undone. Provides the legal audit trail required by HIPAA and state law for consent withdrawal.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` (
    `npp_acknowledgment_id` BIGINT COMMENT 'Unique identifier for the NPP acknowledgment transaction. Primary key.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HIPAA requires covered entities to document NPP acknowledgment at each facility location (45 CFR 164.520). Multi-facility compliance reporting and OCR audit responses require knowing which org_provide',
    `adt_event_id` BIGINT COMMENT 'Foreign key linking to encounter.adt_event. Business justification: HIPAA requires NPP acknowledgment at first service delivery, which operationally occurs at the admit ADT event. Linking npp_acknowledgment to the specific adt_event captures the registration workflow ',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who acknowledged or was presented with the NPP.',
    `portal_account_id` BIGINT COMMENT 'Foreign key linking to patient.portal_account. Business justification: HIPAA compliance audit trails for digitally-obtained NPP acknowledgments require linking to the specific portal account session. patient_portal_session_code is a denormalized reference to portal_accou',
    `primary_previous_npp_acknowledgment_id` BIGINT COMMENT 'Identifier of the previous NPP acknowledgment record for this patient, if this is a re-acknowledgment following a material change.',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: npp_acknowledgment is the only consent transactional product in this domain that lacks a record_id FK to consent_record. Every other consent product (hipaa_authorization, treatment_consent, revocation',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: HIPAA Privacy Rule requires documenting that NPP acknowledgment was obtained at first service delivery. Linking npp_acknowledgment to registration_event enables compliance reporting on whether NPP was',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the NPP acknowledgment was obtained, if applicable.',
    `accessibility_accommodation` STRING COMMENT 'Description of any accessibility accommodations provided (e.g., large print, Braille, audio recording, sign language interpreter).',
    `acknowledgment_date` DATE COMMENT 'Date on which the patient acknowledged receipt of the NPP.',
    `acknowledgment_location` STRING COMMENT 'Physical or virtual location where the acknowledgment was obtained. [ENUM-REF-CANDIDATE: registration_desk|patient_room|emergency_department|outpatient_clinic|patient_portal|home|other — 7 candidates stripped; promote to reference product]',
    `acknowledgment_method` STRING COMMENT 'Method by which the patient provided acknowledgment (paper signature, electronic signature, patient portal click-through, email confirmation, kiosk acceptance, verbal acknowledgment documented by staff).. Valid values are `signature_paper|signature_electronic|portal_click|email_confirmation|kiosk_acceptance|verbal_documented`',
    `acknowledgment_status` STRING COMMENT 'Current status of the NPP acknowledgment transaction. Acknowledged indicates patient signed or electronically accepted; unable_to_obtain indicates good-faith effort was made but acknowledgment could not be secured per regulatory allowance.. Valid values are `acknowledged|declined|unable_to_obtain|good_faith_effort_documented|pending|voided`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the patient acknowledged receipt of the NPP, particularly important for electronic acknowledgments.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the NPP was delivered to the patient (paper handout, electronic via patient portal, email, kiosk, verbal explanation).. Valid values are `paper|electronic|patient_portal|email|kiosk|verbal`',
    `device_type` STRING COMMENT 'Type of device used for electronic acknowledgment (desktop computer, mobile phone, tablet, kiosk).. Valid values are `desktop|mobile|tablet|kiosk|other`',
    `good_faith_effort_documentation` STRING COMMENT 'Free-text documentation of the good-faith effort made to obtain acknowledgment when it could not be secured.',
    `good_faith_effort_reason` STRING COMMENT 'Reason why acknowledgment could not be obtained despite good-faith effort, as permitted under 45 CFR 164.520(c)(2)(ii).. Valid values are `patient_refused|emergency_treatment|patient_unable_to_sign|language_barrier|patient_left_before_signing|other`',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter was used to explain the NPP to the patient.',
    `ip_address` STRING COMMENT 'IP address from which the electronic acknowledgment was submitted, for audit trail purposes.',
    `is_first_service_acknowledgment` BOOLEAN COMMENT 'Indicates whether this acknowledgment was obtained at the first service delivery as required by 45 CFR 164.520(c)(1).',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the NPP was provided to the patient.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this acknowledgment record was last modified.',
    `material_change_acknowledgment` BOOLEAN COMMENT 'Indicates whether this acknowledgment was obtained following a material change to the NPP, requiring re-acknowledgment.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the NPP acknowledgment transaction.',
    `representative_authority_documented` BOOLEAN COMMENT 'Indicates whether the authority of a personal representative to act on behalf of the patient was documented and verified.',
    `retention_expiration_date` DATE COMMENT 'Date after which this acknowledgment record may be destroyed per retention policy.',
    `retention_period_years` STRING COMMENT 'Number of years this acknowledgment record must be retained per HIPAA record retention requirements (minimum 6 years from creation or last effective date).',
    `revocation_date` DATE COMMENT 'Date on which the acknowledgment was revoked or voided, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason why the acknowledgment was revoked or voided (e.g., administrative error, duplicate entry, patient request).',
    `signature_captured` BOOLEAN COMMENT 'Indicates whether a patient or representative signature was captured as part of the acknowledgment.',
    `signature_type` STRING COMMENT 'Type of signature captured (wet ink on paper, electronic stylus, digital certificate-based, biometric, or none if acknowledgment was obtained without signature).. Valid values are `wet_signature|electronic_signature|digital_signature|biometric|none`',
    `signer_name` STRING COMMENT 'Full name of the individual who signed the acknowledgment (patient or authorized representative).',
    `signer_relationship` STRING COMMENT 'Relationship of the signer to the patient (self if patient signed, or representative role). [ENUM-REF-CANDIDATE: self|parent|legal_guardian|power_of_attorney|healthcare_proxy|personal_representative|other — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Unique identifier of this acknowledgment record in the source system.',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_npp_acknowledgment PRIMARY KEY(`npp_acknowledgment_id`)
) COMMENT 'Transactional record of patient acknowledgment of receipt of the organizations HIPAA Notice of Privacy Practices (NPP). Captures acknowledgment date, delivery method (paper, electronic, patient portal), NPP version acknowledged, patient or representative signature, and documentation of good-faith efforts when acknowledgment could not be obtained. Distinct from compliance.notice_of_privacy_practices which tracks the NPP document itself — this tracks the patient-level acknowledgment transaction required by 45 CFR 164.520.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` (
    `restriction_request_id` BIGINT COMMENT 'Unique identifier for the patient consent restriction request record. Primary key.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: HIPAA and 42 CFR Part 2 allow patients to restrict disclosure of PHI related to specific diagnoses (HIV, substance abuse, mental health). Linking restriction_request to ICD code enables systems to enf',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: HIPAA permits patients paying out-of-pocket to request disclosure restrictions to their health plan. Attribute out_of_pocket_payment_verified documents this business requirement. Link enables verifica',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who submitted the restriction request. Links to the patient master record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HIPAA 164.522 restriction requests are submitted to and decided by a specific covered entity (org_provider). organization_decision field confirms the org makes the ruling. Compliance tracking, system_',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Consent restriction requests are patient requests to restrict PHI use beyond standard consent. While some restriction requests are general (not tied to specific consent), many relate to a specific con',
    `superseded_restriction_request_id` BIGINT COMMENT 'Self-referencing FK on restriction_request (superseded_restriction_request_id)',
    `visit_id` BIGINT COMMENT 'The encounter during which the restriction request was submitted, if applicable. Links to the encounter master record.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the detailed audit trail of all actions taken on this restriction request, including reviews, decisions, notifications, and enforcement activities.',
    `compliance_review_date` DATE COMMENT 'The date of the most recent compliance review of this restriction request to ensure ongoing adherence to HIPAA and HITECH requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this restriction request record was first created in the system. Used for audit and data lineage purposes.',
    `decision_date` DATE COMMENT 'The date the covered entity made the decision to accept or deny the restriction request.',
    `decision_made_by` STRING COMMENT 'The name or role of the individual or committee who made the decision on the restriction request (e.g., Privacy Officer, HIM Director).',
    `decision_rationale` STRING COMMENT 'The business and regulatory rationale for the organizations decision to accept or deny the restriction request. Required for audit and patient communication.',
    `effective_date` DATE COMMENT 'The date from which the restriction becomes effective and must be honored by the covered entity.',
    `expiration_date` DATE COMMENT 'The date on which the restriction expires, if applicable. Null indicates an indefinite restriction until revoked by the patient or terminated by the organization per regulatory provisions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this restriction request record was last modified. Used for audit and data lineage purposes.',
    `mrn` STRING COMMENT 'The patients medical record number as recorded at the time of the restriction request. Provides business-level traceability.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the restriction request, including patient concerns, special handling instructions, or escalation details.',
    `operational_instructions` STRING COMMENT 'Detailed operational instructions for clinical, billing, and administrative staff on how to honor the restriction across Electronic Health Record (EHR), Revenue Cycle Management (RCM), Health Information Exchange (HIE), and other systems.',
    `organization_decision` STRING COMMENT 'The covered entitys decision on whether to accept or deny the restriction request. HITECH out-of-pocket restrictions must be accepted; other restrictions are discretionary.. Valid values are `accepted|denied|pending_review|conditionally_accepted|withdrawn`',
    `out_of_pocket_payment_verified` BOOLEAN COMMENT 'Indicates whether the patients claim of out-of-pocket payment has been verified for HITECH mandatory restrictions. True if verified, False if not applicable or not verified.',
    `patient_notification_date` DATE COMMENT 'The date the patient was notified of the organizations decision on the restriction request or any subsequent changes to the restriction status.',
    `patient_notification_method` STRING COMMENT 'The method used to notify the patient of the decision or status change. [ENUM-REF-CANDIDATE: mail|email|patient_portal|phone|in_person|secure_message|other — 7 candidates stripped; promote to reference product]',
    `payment_verification_date` DATE COMMENT 'The date the out-of-pocket payment was verified for HITECH mandatory restrictions, if applicable.',
    `request_date` DATE COMMENT 'The date the patient submitted the restriction request to the covered entity.',
    `request_method` STRING COMMENT 'The method by which the patient submitted the restriction request. [ENUM-REF-CANDIDATE: written_form|verbal|patient_portal|email|fax|mail|in_person|other — 8 candidates stripped; promote to reference product]',
    `request_number` STRING COMMENT 'Business-assigned unique identifier for the restriction request, used for tracking and reference in correspondence and workflows.',
    `request_timestamp` TIMESTAMP COMMENT 'The precise date and time the restriction request was received and recorded in the system.',
    `requesting_party_relationship` STRING COMMENT 'The relationship of the individual submitting the restriction request to the patient, if not the patient themselves.. Valid values are `patient_self|legal_guardian|personal_representative|power_of_attorney|parent_of_minor|other`',
    `restricted_phi_category` STRING COMMENT 'The category of Protected Health Information (PHI) the patient is requesting to restrict. Used for operational filtering and enforcement. [ENUM-REF-CANDIDATE: all_phi|diagnosis_codes|procedure_codes|lab_results|radiology_reports|medication_records|mental_health_records|substance_abuse_records|genetic_information|other — 10 candidates stripped; promote to reference product]',
    `restricted_purpose` STRING COMMENT 'The purpose of use or disclosure that the patient is requesting to restrict (e.g., restrict disclosure for payment purposes to a specific payer). [ENUM-REF-CANDIDATE: treatment|payment|healthcare_operations|research|public_health|all_purposes|other — 7 candidates stripped; promote to reference product]',
    `restricted_recipient_name` STRING COMMENT 'The specific name of the individual, organization, or health plan to whom the restriction applies, if identified by the patient.',
    `restricted_recipient_type` STRING COMMENT 'The type of recipient or entity to whom the patient is requesting disclosure restrictions apply. [ENUM-REF-CANDIDATE: health_plan|family_member|employer|specific_provider|health_information_exchange|research_entity|public_health_authority|other — 8 candidates stripped; promote to reference product]',
    `restriction_scope` STRING COMMENT 'Detailed narrative describing the scope of the requested restriction, including specific Protected Health Information (PHI) data elements, recipients, purposes, or time periods the patient wishes to restrict.',
    `restriction_status` STRING COMMENT 'The current lifecycle status of the restriction. Active restrictions must be enforced across all clinical and administrative systems.. Valid values are `active|expired|revoked_by_patient|terminated_by_organization|superseded|pending_activation`',
    `restriction_type` STRING COMMENT 'The category of restriction requested by the patient. HITECH out-of-pocket payer restriction is mandatory per 45 CFR 164.522(a)(1)(vi); other types are discretionary.. Valid values are `hitech_out_of_pocket_payer_restriction|family_member_disclosure_restriction|specific_data_type_restriction|specific_recipient_restriction|treatment_purpose_restriction|other`',
    `revocation_date` DATE COMMENT 'The date the patient revoked the restriction request, if applicable. Patients may revoke restrictions at any time per HIPAA.',
    `revocation_method` STRING COMMENT 'The method by which the patient revoked the restriction, if applicable. [ENUM-REF-CANDIDATE: written_form|verbal|patient_portal|email|fax|mail|in_person|other — 8 candidates stripped; promote to reference product]',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or location of supporting documentation submitted with the restriction request (e.g., signed forms, proof of out-of-pocket payment for HITECH restrictions).',
    `system_enforcement_flag` BOOLEAN COMMENT 'Indicates whether the restriction is actively enforced through automated system controls (True) or requires manual staff intervention (False).',
    `termination_date` DATE COMMENT 'The date the covered entity terminated the restriction, if applicable. Organizations may terminate restrictions under specific circumstances per HIPAA.',
    `termination_reason` STRING COMMENT 'The reason the covered entity terminated the restriction, including regulatory justification and patient notification details.',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_restriction_request PRIMARY KEY(`restriction_request_id`)
) COMMENT 'Master record for patient requests to restrict uses and disclosures of their PHI beyond HIPAAs standard permissions. Captures restriction type (restrict disclosure to specific payer when patient paid out-of-pocket per HITECH, restrict sharing with family members, restrict specific data types), requested restriction scope, organizations decision to accept or deny the restriction, effective date, and operational instructions for honoring the restriction across clinical systems. Governed by HITECH Act amendment to HIPAA 45 CFR 164.522.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` (
    `disclosure_log_id` BIGINT COMMENT 'Unique identifier for the consent disclosure log entry. Primary key for the consent disclosure log product.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: HIPAA accounting of disclosures (45 CFR §164.528) requires logging PHI disclosures triggered by claim submissions to payers. The disclosure_log must reference the specific claim that caused the disclo',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: HIPAA accounting of disclosures (45 CFR 164.528) requires identifying which clinician released PHI. Compliance audits and breach investigations depend on this link. disclosure_initiated_by_role confir',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Multi-facility HIPAA disclosure accounting requires knowing which org_provider location released PHI. Facility-level compliance reporting, OIG audits, and breach notification workflows all depend on i',
    `record_id` BIGINT COMMENT 'Reference to the consent or authorization record under which this disclosure was made. Links to the consent product.',
    `hipaa_authorization_id` BIGINT COMMENT 'Foreign key linking to consent.hipaa_authorization. Business justification: PHI disclosures are frequently made under specific HIPAA authorizations. The disclosure_log currently has authorization_reference (STRING) which should be replaced with a proper FK to hipaa_authorizat',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose Protected Health Information (PHI) was disclosed. Links to the patient master product.',
    `parent_disclosure_log_id` BIGINT COMMENT 'Self-referencing FK on disclosure_log (related_disclosure_log_id)',
    `primary_disclosure_consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: The consent_record product description explicitly states it is Referenced by disclosure_consent_record_id, and disclosure_log records every PHI disclosure made under a patient consent or authorizati',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: HIPAA accounting of disclosures requires identifying NPI-registered recipients (covered entities, business associates). Linking disclosure_log to npi_registry enables automated compliance reports and ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit associated with this disclosure, if applicable. Links to the encounter product.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this disclosure log record was first created in the system. Supports audit trail and data lineage.',
    `department_code` STRING COMMENT 'The code or identifier of the department or unit within the facility that made the disclosure. Supports departmental accountability and reporting.',
    `disclosure_date` DATE COMMENT 'The date on which the Protected Health Information (PHI) disclosure occurred. Required for HIPAA Accounting of Disclosures per 45 CFR 164.528.',
    `disclosure_initiated_by` STRING COMMENT 'The name or identifier of the individual or system that initiated the disclosure. Supports audit trail and accountability.',
    `disclosure_initiated_by_role` STRING COMMENT 'The role or job title of the individual who initiated the disclosure, such as physician, nurse, HIM specialist, or system administrator. Supports role-based access auditing.',
    `disclosure_method` STRING COMMENT 'The method or channel by which the Protected Health Information (PHI) was disclosed. Supports security analysis and breach risk assessment. [ENUM-REF-CANDIDATE: electronic|paper|verbal|fax|secure_email|hie|api|other — 8 candidates stripped; promote to reference product]',
    `disclosure_notes` STRING COMMENT 'Additional notes, comments, or context regarding the disclosure. Provides supplementary information for audit and compliance review.',
    `disclosure_purpose` STRING COMMENT 'The stated purpose or reason for the Protected Health Information (PHI) disclosure. Required for HIPAA Accounting of Disclosures per 45 CFR 164.528.',
    `disclosure_purpose_category` STRING COMMENT 'The standardized category of the disclosure purpose. Enables aggregation and reporting of disclosures by purpose type for compliance and analytics. [ENUM-REF-CANDIDATE: treatment|payment|operations|research|public_health|legal|patient_request|court_order|law_enforcement|other — 10 candidates stripped; promote to reference product]',
    `disclosure_status` STRING COMMENT 'The current status of the disclosure transaction. Tracks the lifecycle state of the disclosure event.. Valid values are `completed|pending|failed|revoked|cancelled`',
    `disclosure_timestamp` TIMESTAMP COMMENT 'The precise date and time when the Protected Health Information (PHI) disclosure occurred. Provides granular audit trail for compliance and security investigations.',
    `is_accounting_required` BOOLEAN COMMENT 'Indicates whether this disclosure must be included in the HIPAA Accounting of Disclosures report provided to patients upon request. Non-TPO disclosures are subject to accounting per 45 CFR 164.528.',
    `is_tpo_disclosure` BOOLEAN COMMENT 'Indicates whether the disclosure was made for Treatment, Payment, or Operations (TPO) purposes. TPO disclosures are exempt from HIPAA Accounting of Disclosures requirements per 45 CFR 164.528.',
    `legal_basis` STRING COMMENT 'The legal or regulatory basis that permitted or required the disclosure, such as court order, subpoena, public health reporting requirement, or patient authorization.',
    `minimum_necessary_applied` BOOLEAN COMMENT 'Indicates whether the minimum necessary standard was applied to limit the Protected Health Information (PHI) disclosed to only what was reasonably necessary for the stated purpose, as required by 45 CFR 164.502(b).',
    `modified_by` STRING COMMENT 'The user ID or system identifier that last modified this disclosure log record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this disclosure log record was last modified. Supports audit trail and change tracking.',
    `patient_notification_date` DATE COMMENT 'The date on which the patient was notified of the disclosure, if notification was required. Supports compliance tracking.',
    `patient_notification_required` BOOLEAN COMMENT 'Indicates whether the patient must be notified of this disclosure under HIPAA or organizational policy. Certain disclosures require patient notification.',
    `phi_elements_disclosed` STRING COMMENT 'Description of the specific Protected Health Information (PHI) elements or data categories that were disclosed. Required for HIPAA Accounting of Disclosures.',
    `recipient_address` STRING COMMENT 'The mailing or physical address of the recipient to whom the Protected Health Information (PHI) was disclosed. Required for HIPAA Accounting of Disclosures.',
    `recipient_identifier` STRING COMMENT 'The unique identifier for the recipient, such as National Provider Identifier (NPI), Tax ID, or organizational identifier. Enables precise tracking of disclosure recipients.',
    `recipient_name` STRING COMMENT 'The name of the individual, organization, or entity to whom the Protected Health Information (PHI) was disclosed. Required for HIPAA Accounting of Disclosures.',
    `recipient_type` STRING COMMENT 'The category of recipient to whom the Protected Health Information (PHI) was disclosed. Supports classification and reporting of disclosure patterns. [ENUM-REF-CANDIDATE: individual|organization|government_agency|health_plan|clearinghouse|business_associate|research_institution|public_health_authority|law_enforcement|other — 10 candidates stripped; promote to reference product]',
    `system_source` STRING COMMENT 'The name or identifier of the source system or application that recorded the disclosure event, such as Epic EHR, Cerner Millennium, or HIE platform.',
    `vibe_mutation_marker` STRING COMMENT '',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this disclosure log record. Supports audit trail and accountability.',
    CONSTRAINT pk_disclosure_log PRIMARY KEY(`disclosure_log_id`)
) COMMENT 'Transactional record of every PHI disclosure made under a patient consent or authorization, providing the accounting of disclosures required by HIPAA. Captures disclosure date, recipient identity and type, purpose of disclosure, PHI elements disclosed, consent or authorization reference, and whether the disclosure was for TPO (exempt from accounting) or non-TPO (subject to accounting). Enables generation of the HIPAA Accounting of Disclosures report provided to patients upon request per 45 CFR 164.528.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`consent`.`record` (
    `record_id` BIGINT COMMENT 'Primary key for consent_record',
    `form_template_id` BIGINT COMMENT 'Reference to the consent form template version presented to the patient, ensuring traceability to the exact wording and disclosures the patient agreed to.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Consent records are issued under a specific facilitys authority and retention policies. Multi-facility health systems require facility-level consent tracking for state regulatory compliance, retentio',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Patient consent history reporting, HIPAA audit trails, and compliance dashboards all require knowing which patient owns a consent_record without traversing through visit or child tables. Every consent',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Joint Commission and CMS Conditions of Participation require documenting which clinician obtained informed consent. Credentialing reviews, malpractice defense, and consent validity audits depend on th',
    `primary_superseded_by_consent_record_id` BIGINT COMMENT 'Self-reference to the consent record that replaces this one when a patient re-consents or updates their authorization, preserving consent version lineage.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the consent was obtained, when applicable, supporting episode-of-care context for treatment consent.',
    `applies_to_minor` BOOLEAN COMMENT 'Indicates whether the consent pertains to a minor patient, triggering guardian-consent and age-of-majority transition handling.',
    `can_revoke` BOOLEAN COMMENT 'Indicates whether the patient retains the right to revoke this consent, noting that some research and prior-disclosure consents are not fully revocable.',
    `consent_category` STRING COMMENT 'Higher-level business grouping of the consent that drives downstream access control and policy application, including specially-protected categories such as behavioral health and substance use.',
    `consent_direction` STRING COMMENT 'Indicates whether the consent grants (permit) or restricts (deny) the described activity, supporting opt-in versus opt-out semantics for HIE and data sharing.',
    `consent_number` STRING COMMENT 'Externally-known human-readable business reference number for the consent record, used on documents and in patient communications.',
    `consent_record_status` STRING COMMENT 'Current lifecycle state of the consent record, driving whether the consent is enforceable for data access, treatment, or disclosure decisions.',
    `consent_type` STRING COMMENT 'Classifies the fundamental kind of consent captured, distinguishing treatment consent, research consent, data sharing authorization, HIPAA authorization, HIE opt-in/opt-out, and telehealth consent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first captured in the system of record.',
    `document_uri` STRING COMMENT 'Storage location reference for the scanned or electronic signed consent document, enabling retrieval of the original legal artifact.',
    `effective_date` DATE COMMENT 'Date on which the consent becomes legally binding and enforceable for the described activities.',
    `expiration_date` DATE COMMENT 'Date on which the consent automatically lapses; nullable for consents that remain in effect until explicitly revoked.',
    `expiration_event` STRING COMMENT 'Description of an event-based expiration condition (e.g., end of research study) used when a consent terminates on an event rather than a fixed date, per HIPAA authorization requirements.',
    `includes_sensitive_data` BOOLEAN COMMENT 'Indicates whether the consent covers specially-protected sensitive information such as substance use, behavioral health, or HIV status requiring heightened controls.',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter assisted the patient during the consent process, supporting language-access compliance documentation.',
    `is_legally_authorized_representative` BOOLEAN COMMENT 'Indicates whether the consent was provided by a legally authorized representative on behalf of the patient, requiring documentation of authority.',
    `language_code` STRING COMMENT 'ISO 639-1 language code in which the consent form was presented and signed, documenting that the patient consented in a language they understand.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was most recently modified, supporting change auditing and data lineage.',
    `purpose_of_use` STRING COMMENT 'Authorized purpose for which the protected health information may be used or disclosed under this consent, aligned with HIPAA permitted-purpose categories.',
    `scope_description` STRING COMMENT 'Narrative description of the specific information categories, purposes, and recipients covered by this consent, defining the permitted use boundary.',
    `signature_method` STRING COMMENT 'Method by which the patient signature or assent was captured, supporting validity assessment and e-signature compliance auditing.',
    `signed_date` DATE COMMENT 'Date the patient or authorized representative signed and executed the consent, establishing the principal real-world consent event.',
    `signer_name` STRING COMMENT 'Full legal name of the individual who signed the consent, which may be the patient or a legally authorized representative.',
    `signer_relationship` STRING COMMENT 'Relationship of the signer to the patient, identifying whether consent was self-given or provided by an authorized representative.',
    `verification_status` STRING COMMENT 'Status of the verification process confirming the validity and completeness of the consent before it is treated as enforceable.',
    `withdrawal_date` DATE COMMENT 'Date on which the patient revoked or withdrew the consent; nullable while consent remains active.',
    `withdrawal_method` STRING COMMENT 'Channel through which the patient communicated their revocation, supporting validity verification of the withdrawal.',
    `withdrawal_reason` STRING COMMENT 'Documented reason the patient provided for revoking the consent, supporting audit and patient-rights reporting.',
    `witness_name` STRING COMMENT 'Full name of the witness who attested to the patient signature, required for certain treatment and research consents.',
    `witness_signed_date` DATE COMMENT 'Date the witness signed and attested to the consent execution.',
    CONSTRAINT pk_record PRIMARY KEY(`record_id`)
) COMMENT 'Master reference table for consent_record. Referenced by disclosure_consent_record_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_primary_superseded_by_form_template_id` FOREIGN KEY (`primary_superseded_by_form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_superseded_hipaa_authorization_id` FOREIGN KEY (`superseded_hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_superseded_treatment_consent_id` FOREIGN KEY (`superseded_treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_prior_revocation_id` FOREIGN KEY (`prior_revocation_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`revocation`(`revocation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_primary_previous_npp_acknowledgment_id` FOREIGN KEY (`primary_previous_npp_acknowledgment_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`npp_acknowledgment`(`npp_acknowledgment_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_superseded_restriction_request_id` FOREIGN KEY (`superseded_restriction_request_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_hipaa_authorization_id` FOREIGN KEY (`hipaa_authorization_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_parent_disclosure_log_id` FOREIGN KEY (`parent_disclosure_log_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`disclosure_log`(`disclosure_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_primary_disclosure_consent_record_id` FOREIGN KEY (`primary_disclosure_consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ADD CONSTRAINT `fk_consent_record_primary_superseded_by_consent_record_id` FOREIGN KEY (`primary_superseded_by_consent_record_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`record`(`record_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`consent` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`consent` SET TAGS ('dbx_domain' = 'consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` SET TAGS ('dbx_subdomain' = 'consent_documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `primary_superseded_by_form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Form Template');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_category` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Consent Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_subcategory` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `consent_subcategory` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `electronic_signature_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Enabled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_checksum` SET TAGS ('dbx_business_glossary_term' = 'Form Checksum');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_code` SET TAGS ('dbx_business_glossary_term' = 'Form Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_document_url` SET TAGS ('dbx_business_glossary_term' = 'Form Document URL');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('dbx_business_glossary_term' = 'Form Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_purpose` SET TAGS ('dbx_business_glossary_term' = 'Form Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `legal_representative_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Allowed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `minor_assent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Assent Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `reading_level` SET TAGS ('dbx_business_glossary_term' = 'Reading Level');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `revocation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Revocation Allowed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `revocation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Revocation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `scope_of_consent` SET TAGS ('dbx_business_glossary_term' = 'Scope of Consent');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `scope_of_consent` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `scope_of_consent` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` SET TAGS ('dbx_subdomain' = 'consent_documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosing Party Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `superseded_hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded HIPAA Authorization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose` SET TAGS ('dbx_business_glossary_term' = 'Authorization Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `authorization_purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Authorization Purpose Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Disclosure Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `compensation_disclosure_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `expiration_event` SET TAGS ('dbx_business_glossary_term' = 'Expiration Event');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `expiration_event` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `personal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Personal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_category` SET TAGS ('dbx_business_glossary_term' = 'PHI Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `phi_description` SET TAGS ('dbx_business_glossary_term' = 'PHI Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `recipient_organization` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `redisclosure_statement` SET TAGS ('dbx_business_glossary_term' = 'Redisclosure Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `right_to_revoke_statement` SET TAGS ('dbx_business_glossary_term' = 'Right to Revoke Statement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `signature_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Obtained');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `witness_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` SET TAGS ('dbx_subdomain' = 'consent_documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessed By Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Treatment Consent Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `superseded_treatment_consent_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `tertiary_treatment_performing_provider_clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `alternatives_documented` SET TAGS ('dbx_business_glossary_term' = 'Alternatives Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `benefits_documented` SET TAGS ('dbx_business_glossary_term' = 'Benefits Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_business_glossary_term' = 'Capacity Determination');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_value_regex' = 'patient_has_capacity|patient_lacks_capacity|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `capacity_determination` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_document_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_document_location` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_document_location` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|telephonic');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `emergency_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `emergency_exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exception Justification');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Relationship');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_relationship` SET TAGS ('dbx_value_regex' = 'parent|guardian|healthcare_proxy|power_of_attorney|spouse|next_of_kin');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `legal_representative_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Questions Addressed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_addressed_flag` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_notes` SET TAGS ('dbx_business_glossary_term' = 'Patient Questions Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `patient_questions_notes` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_business_glossary_term' = 'Revoked By Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `revoked_by_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `risks_documented` SET TAGS ('dbx_business_glossary_term' = 'Risks Documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ALTER COLUMN `witness_role` SET TAGS ('dbx_business_glossary_term' = 'Witness Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` SET TAGS ('dbx_subdomain' = 'privacy_disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_revocation_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Revocation Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_revocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `data_access_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Access Restricted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `data_access_restricted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Access Restricted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `disclosures_halted_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosures Halted Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `disclosures_halted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disclosures Halted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Revocation Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `irrevocable_actions_description` SET TAGS ('dbx_business_glossary_term' = 'Irrevocable Actions Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `legal_reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `partial_revocation_details` SET TAGS ('dbx_business_glossary_term' = 'Partial Revocation Details');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_sent_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_sent_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `patient_notification_timestamp` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_disclosures_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Disclosures Count');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `prior_disclosures_summary` SET TAGS ('dbx_business_glossary_term' = 'Prior Disclosures Summary');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'patient_request|privacy_concern|no_longer_needed|treatment_complete|other|not_provided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_number` SET TAGS ('dbx_business_glossary_term' = 'Revocation Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'pending|processed|effective|rejected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Revocation Scope');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ALTER COLUMN `witness_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` SET TAGS ('dbx_subdomain' = 'privacy_disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `npp_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Notice of Privacy Practices (NPP) Acknowledgment ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Acknowledging Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adt Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `portal_account_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `primary_previous_npp_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Notice of Privacy Practices (NPP) Acknowledgment ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_location` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Location');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_value_regex' = 'signature_paper|signature_electronic|portal_click|email_confirmation|kiosk_acceptance|verbal_documented');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|declined|unable_to_obtain|good_faith_effort_documented|pending|voided');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'paper|electronic|patient_portal|email|kiosk|verbal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_documentation` SET TAGS ('dbx_business_glossary_term' = 'Good Faith Effort Documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_reason` SET TAGS ('dbx_business_glossary_term' = 'Good Faith Effort Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `good_faith_effort_reason` SET TAGS ('dbx_value_regex' = 'patient_refused|emergency_treatment|patient_unable_to_sign|language_barrier|patient_left_before_signing|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `is_first_service_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Is First Service Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `material_change_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Material Change Acknowledgment Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `representative_authority_documented` SET TAGS ('dbx_business_glossary_term' = 'Representative Authority Documented Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|biometric|none');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_business_glossary_term' = 'Signer Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `signer_relationship` SET TAGS ('dbx_business_glossary_term' = 'Signer Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` SET TAGS ('dbx_subdomain' = 'consent_documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Restriction Request ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `superseded_restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Restriction Request Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `superseded_restriction_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_made_by` SET TAGS ('dbx_business_glossary_term' = 'Decision Made By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `operational_instructions` SET TAGS ('dbx_business_glossary_term' = 'Operational Instructions for Restriction Enforcement');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `operational_instructions` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `organization_decision` SET TAGS ('dbx_business_glossary_term' = 'Organization Decision on Restriction Request');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `organization_decision` SET TAGS ('dbx_value_regex' = 'accepted|denied|pending_review|conditionally_accepted|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `out_of_pocket_payment_verified` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Payment Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `payment_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_method` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Number');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `requesting_party_relationship` SET TAGS ('dbx_value_regex' = 'patient_self|legal_guardian|personal_representative|power_of_attorney|parent_of_minor|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_phi_category` SET TAGS ('dbx_business_glossary_term' = 'Restricted Protected Health Information (PHI) Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_purpose` SET TAGS ('dbx_business_glossary_term' = 'Restricted Purpose of Use or Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Restricted Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restricted_recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Restricted Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked_by_patient|terminated_by_organization|superseded|pending_activation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'hitech_out_of_pocket_payer_restriction|family_member_disclosure_restriction|specific_data_type_restriction|specific_recipient_restriction|treatment_purpose_restriction|other');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `revocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revocation Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `system_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'System Enforcement Flag');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` SET TAGS ('dbx_subdomain' = 'privacy_disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_log_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Disclosure Log ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosing Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `parent_disclosure_log_id` SET TAGS ('dbx_business_glossary_term' = 'Related Disclosure Log Id');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `parent_disclosure_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `primary_disclosure_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `primary_disclosure_consent_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `primary_disclosure_consent_record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Initiated By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_initiated_by_role` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Initiated By Role');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_method` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Method');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_purpose` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Purpose Category');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|revoked|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `disclosure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_accounting_required` SET TAGS ('dbx_business_glossary_term' = 'Is Accounting Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `is_tpo_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Is Treatment Payment Operations (TPO) Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `minimum_necessary_applied` SET TAGS ('dbx_business_glossary_term' = 'Minimum Necessary Applied');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Required');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `patient_notification_required` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Elements Disclosed');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `phi_elements_disclosed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_business_glossary_term' = 'Recipient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` SET TAGS ('dbx_subdomain' = 'consent_documentation');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Obtaining Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `primary_superseded_by_consent_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `primary_superseded_by_consent_record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_category` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_direction` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_direction` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_record_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_record_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `consent_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `document_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `expiration_event` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `scope_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `signer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `signer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `signer_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`consent`.`record` ALTER COLUMN `witness_name` SET TAGS ('dbx_uc_classification' = 'pii');
