-- Schema for Domain: credential | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`credential` COMMENT 'Manages the provider credentialing and re-credentialing lifecycle — primary source verification (PSV), NCQA credentialing standards, committee decisions, sanctions screening (OIG/SAM), DEA and state license validation, malpractice history, hospital privileges verification, and credentialing event history. Distinct from provider identity (owned by provider domain); credential owns the qualification and approval workflow that gates network participation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`application` (
    `application_id` BIGINT COMMENT 'Unique identifier for the credentialing application.',
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center.',
    `delegated_entity_id` BIGINT COMMENT 'FK to delegated entity processing the application.',
    `employee_id` BIGINT COMMENT 'FK to workforce employee assigned to the application.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan for which credentialing is requested.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider submitting the application.',
    `application_date` DATE COMMENT 'Date the application was submitted.',
    `application_number` STRING COMMENT 'Business-assigned application number.',
    `application_status` STRING COMMENT 'Current status of the application.',
    `application_type` STRING COMMENT 'Type of credentialing application (initial, recredentialing, etc.).',
    `committee_decision` STRING COMMENT 'Decision rendered by the credentialing committee.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_cycle_year` STRING COMMENT 'Year of the credentialing cycle.',
    `dea_license_number` STRING COMMENT 'DEA registration number of the provider.',
    `decision_date` DATE COMMENT 'Date the credentialing decision was made.',
    `disposition` STRING COMMENT 'Final disposition of the application.',
    `expiration_date` DATE COMMENT 'Date the credential expires.',
    `hospital_privileges_verified` BOOLEAN COMMENT 'Whether hospital privileges have been verified.',
    `is_delegated` BOOLEAN COMMENT 'Whether the application is processed by a delegated entity.',
    `is_urgent` BOOLEAN COMMENT 'Whether the application requires expedited processing.',
    `last_psv_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the last primary source verification update.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the provider license.',
    `malpractice_history_flag` BOOLEAN COMMENT 'Whether the provider has malpractice history.',
    `ncqa_cycle` STRING COMMENT 'NCQA accreditation cycle reference.',
    `notes` STRING COMMENT 'Free-text notes on the application.',
    `npdb_query_date` DATE COMMENT 'Date the NPDB query was submitted.',
    `primary_psv_status` STRING COMMENT 'Status of primary source verification.',
    `requires_additional_documents` BOOLEAN COMMENT 'Whether additional documents are needed.',
    `sanction_screening_status` STRING COMMENT 'Status of sanction screening.',
    `state_license_number` STRING COMMENT 'State license number of the provider.',
    `submission_channel` STRING COMMENT 'Channel through which the application was submitted.',
    `target_completion_date` DATE COMMENT 'Target date for completing the credentialing process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Tracks credentialing applications submitted by or on behalf of providers for health plan participation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`record` (
    `record_id` BIGINT COMMENT 'Unique identifier for the credential record.',
    `employee_id` BIGINT COMMENT 'FK to the credentialing officer.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credential_entity_code` STRING COMMENT 'Code identifying the credentialing entity.',
    `credential_expiration_reason` DOUBLE COMMENT 'Reason for credential expiration.',
    `credential_revocation_date` DATE COMMENT 'Date the credential was revoked.',
    `credential_source_system` STRING COMMENT 'Source system of the credential record.',
    `credential_status` STRING COMMENT 'Current status of the credential.',
    `credential_suspension_end` DATE COMMENT 'End date of credential suspension.',
    `credential_suspension_start` DATE COMMENT 'Start date of credential suspension.',
    `credential_tier` STRING COMMENT 'Tier classification of the credential.',
    `credential_type` STRING COMMENT 'Type of credential (MD, DO, NP, etc.).',
    `credential_version` STRING COMMENT 'Version number of the credential record.',
    `credentialing_committee_decision_date` DATE COMMENT 'Date the committee rendered its decision.',
    `credentialing_committee_outcome` STRING COMMENT 'Outcome of the committee review.',
    `credentialing_review_notes` STRING COMMENT 'Notes from the credentialing review.',
    `dea_license_number` STRING COMMENT 'DEA registration number.',
    `delegated_credential_flag` BOOLEAN COMMENT 'Whether the credential is managed by a delegated entity.',
    `effective_date` DATE COMMENT 'Date the credential becomes effective.',
    `expiration_date` DATE COMMENT 'Date the credential expires.',
    `hospital_privileges_flag` BOOLEAN COMMENT 'Whether the provider has hospital privileges.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the state license.',
    `malpractice_claims_count` STRING COMMENT 'Number of malpractice claims.',
    `malpractice_history_flag` BOOLEAN COMMENT 'Whether the provider has malpractice history.',
    `ncqa_compliance_flag` BOOLEAN COMMENT 'Whether the credential meets NCQA standards.',
    `next_recredentialing_due` DATE COMMENT 'Date the next recredentialing is due.',
    `recredentialing_date` DATE COMMENT 'Date of last recredentialing.',
    `sanctions_screened_flag` BOOLEAN COMMENT 'Whether sanctions screening has been completed.',
    `state_license_number` STRING COMMENT 'State license number.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_record PRIMARY KEY(`record_id`)
) COMMENT 'Master credential record for a provider, tracking credential status, type, and lifecycle.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` (
    `psv_verification_id` BIGINT COMMENT 'Unique identifier for the PSV verification.',
    `employee_id` BIGINT COMMENT 'FK to the employee performing verification.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `vendor_id` BIGINT COMMENT 'FK to the verification vendor.',
    `board_certification` STRING COMMENT 'Board certification details.',
    `credential_element_identifier` STRING COMMENT 'Identifier for the credential element being verified.',
    `credential_element_type` STRING COMMENT 'Type of credential element.',
    `dea_schedule` STRING COMMENT 'DEA schedule classification.',
    `effective_date` DATE COMMENT 'Effective date of the verification.',
    `element_category` STRING COMMENT 'Category of the credential element.',
    `element_status` STRING COMMENT 'Status of the credential element.',
    `expiration_date` DATE COMMENT 'Expiration date of the verified credential.',
    `hospital_privilege_scope` STRING COMMENT 'Scope of hospital privileges.',
    `issuing_authority` STRING COMMENT 'Authority that issued the credential.',
    `license_number` STRING COMMENT 'License number being verified.',
    `malpractice_insurance_limit` DECIMAL(18,2) COMMENT 'Malpractice insurance coverage limit.',
    `malpractice_insurance_type` STRING COMMENT 'Type of malpractice insurance.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `training_program` STRING COMMENT 'Training program details.',
    `verification_date` DATE COMMENT 'Date the verification was performed.',
    `verification_method` STRING COMMENT 'Method used for verification.',
    `verification_notes` STRING COMMENT 'Notes from the verification process.',
    `verification_result` STRING COMMENT 'Result of the verification.',
    `work_history_details` STRING COMMENT 'Details of work history verification.',
    `work_history_years` STRING COMMENT 'Number of years of work history verified.',
    CONSTRAINT pk_psv_verification PRIMARY KEY(`psv_verification_id`)
) COMMENT 'Primary source verification records for provider credentials including licenses, certifications, and training.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` (
    `sanction_screening_id` BIGINT COMMENT 'Unique identifier for the sanction screening.',
    `employee_id` BIGINT COMMENT 'FK to the employee performing screening.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `vendor_id` BIGINT COMMENT 'FK to the screening vendor.',
    `compliance_requirement` STRING COMMENT 'Regulatory compliance requirement.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `databases_queried` STRING COMMENT 'List of databases queried during screening.',
    `impact_on_credential_status` STRING COMMENT 'Impact of screening results on credential status.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of last review.',
    `overall_status` STRING COMMENT 'Overall screening status.',
    `record_source` STRING COMMENT 'Source of the screening record.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference for the screening.',
    `resolution_status` STRING COMMENT 'Status of resolution for findings.',
    `result_detail` STRING COMMENT 'Detailed screening results.',
    `sanction_effective_date` DATE COMMENT 'Effective date of the sanction.',
    `sanction_end_date` DATE COMMENT 'End date of the sanction.',
    `sanction_type` STRING COMMENT 'Type of sanction identified.',
    `sanctioning_authority` STRING COMMENT 'Authority that imposed the sanction.',
    `screening_event_type` STRING COMMENT 'Type of screening event.',
    `screening_initiated_by` STRING COMMENT 'Who initiated the screening.',
    `screening_notes` STRING COMMENT 'Notes from the screening.',
    `screening_result` STRING COMMENT 'Result of the screening.',
    `screening_timestamp` TIMESTAMP COMMENT 'Timestamp of the screening.',
    `severity_level` STRING COMMENT 'Severity level of the finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_sanction_screening PRIMARY KEY(`sanction_screening_id`)
) COMMENT 'Sanction and exclusion screening records for providers against OIG, SAM, and state databases.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` (
    `npdb_query_id` BIGINT COMMENT 'Unique identifier for the NPDB query.',
    `employee_id` BIGINT COMMENT 'FK to the employee submitting the query.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider being queried.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `vendor_id` BIGINT COMMENT 'FK to the query vendor.',
    `confidentiality_level` STRING COMMENT 'Confidentiality level of the query results.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `hcqia_compliance_flag` BOOLEAN COMMENT 'Whether the query meets HCQIA requirements.',
    `internal_review_disposition` STRING COMMENT 'Disposition from internal review.',
    `is_continuous_enrollment` BOOLEAN COMMENT 'Whether continuous query enrollment is active.',
    `last_report_date` DATE COMMENT 'Date of the last NPDB report.',
    `notes` STRING COMMENT 'Free-text notes.',
    `npdb_assigned_query_number` STRING COMMENT 'Query number assigned by NPDB.',
    `npdb_query_status` STRING COMMENT 'Status of the NPDB query.',
    `number_of_reports` STRING COMMENT 'Number of reports returned.',
    `provider_npi` STRING COMMENT 'NPI of the provider queried.',
    `query_type` STRING COMMENT 'Type of NPDB query.',
    `query_version` STRING COMMENT 'Version of the query format.',
    `report_processing_time_seconds` STRING COMMENT 'Processing time in seconds.',
    `response_timestamp` TIMESTAMP COMMENT 'Timestamp of the NPDB response.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp of query submission.',
    `total_malpractice_amount` DECIMAL(18,2) COMMENT 'Total malpractice payment amount reported.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_npdb_query PRIMARY KEY(`npdb_query_id`)
) COMMENT 'National Practitioner Data Bank query records for provider credentialing verification.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` (
    `committee_review_id` BIGINT COMMENT 'Unique identifier for the committee review.',
    `committee_id` BIGINT COMMENT 'FK to the committee.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `employee_id` BIGINT COMMENT 'FK to the reviewing employee.',
    `agenda_items` STRING COMMENT 'Items on the committee agenda.',
    `appeal_rights_notification_date` DATE COMMENT 'Date appeal rights were communicated.',
    `chair_name` STRING COMMENT 'Name of the committee chair.',
    `chair_npi` STRING COMMENT 'NPI of the committee chair.',
    `committee_review_status` STRING COMMENT 'Status of the committee review.',
    `compliance_flag_dea_valid` BOOLEAN COMMENT 'Whether DEA is valid.',
    `compliance_flag_malpractice_history` BOOLEAN COMMENT 'Whether malpractice history is flagged.',
    `compliance_flag_oig_sanction` BOOLEAN COMMENT 'Whether OIG sanction is flagged.',
    `compliance_flag_state_license_valid` BOOLEAN COMMENT 'Whether state license is valid.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `decision_conditions` STRING COMMENT 'Conditions attached to the decision.',
    `decision_effective_date` DATE COMMENT 'Effective date of the decision.',
    `decision_expiration_date` DATE COMMENT 'Expiration date of the decision.',
    `decision_rationale` DECIMAL(18,2) COMMENT 'Rationale for the decision.',
    `decision_type` STRING COMMENT 'Type of decision rendered.',
    `denial_reason_code` STRING COMMENT 'Reason code for denial.',
    `meeting_timestamp` TIMESTAMP COMMENT 'Timestamp of the committee meeting.',
    `notes` STRING COMMENT 'Free-text notes.',
    `quorum_indicator` BOOLEAN COMMENT 'Whether quorum was met.',
    `review_number` STRING COMMENT 'Business-assigned review number.',
    `review_type` STRING COMMENT 'Type of review.',
    `total_providers_reviewed` DECIMAL(18,2) COMMENT 'Total number of providers reviewed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `voting_record` STRING COMMENT 'Record of committee votes.',
    CONSTRAINT pk_committee_review PRIMARY KEY(`committee_review_id`)
) COMMENT 'Credentialing committee review sessions and decisions for provider applications.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` (
    `recredential_cycle_id` BIGINT COMMENT 'Unique identifier for the recredentialing cycle.',
    `employee_id` BIGINT COMMENT 'FK to the assigned employee.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `application_received_date` DATE COMMENT 'Date the recredentialing application was received.',
    `compliance_requirements` STRING COMMENT 'Applicable compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `cycle_completion_date` DATE COMMENT 'Date the cycle was completed.',
    `cycle_due_date` DATE COMMENT 'Due date for the recredentialing cycle.',
    `cycle_priority` STRING COMMENT 'Priority of the cycle.',
    `cycle_start_date` DATE COMMENT 'Start date of the cycle.',
    `cycle_status` STRING COMMENT 'Current status of the cycle.',
    `cycle_type` STRING COMMENT 'Type of recredentialing cycle.',
    `escalation_date` DATE COMMENT 'Date the cycle was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Whether the cycle has been escalated.',
    `last_outreach_date` DATE COMMENT 'Date of last outreach attempt.',
    `notes` STRING COMMENT 'Free-text notes.',
    `outreach_attempt_count` STRING COMMENT 'Number of outreach attempts.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_recredential_cycle PRIMARY KEY(`recredential_cycle_id`)
) COMMENT 'Recredentialing cycle tracking for providers requiring periodic credential renewal.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` (
    `delegated_entity_id` BIGINT COMMENT 'Unique identifier for the delegated entity.',
    `vendor_id` BIGINT COMMENT 'FK to the vendor master.',
    `audit_notes` STRING COMMENT 'Notes from audits.',
    `audit_result` STRING COMMENT 'Result of the last audit.',
    `audit_schedule` STRING COMMENT 'Schedule for audits.',
    `compliance_requirements` STRING COMMENT 'Compliance requirements for the entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `delegated_entity_status` STRING COMMENT 'Status of the delegated entity.',
    `delegation_agreement_number` STRING COMMENT 'Agreement number.',
    `delegation_scope` STRING COMMENT 'Scope of delegation.',
    `delegation_type` STRING COMMENT 'Type of delegation.',
    `effective_date` DATE COMMENT 'Effective date of delegation.',
    `last_audit_date` DATE COMMENT 'Date of last audit.',
    `ncqa_accreditation_status` STRING COMMENT 'NCQA accreditation status.',
    `npi` STRING COMMENT 'NPI of the delegated entity.',
    `organization_name` STRING COMMENT 'Name of the organization.',
    `oversight_audit_frequency_months` STRING COMMENT 'Frequency of oversight audits in months.',
    `record_source` STRING COMMENT 'Source of the record.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `termination_date` DATE COMMENT 'Termination date of delegation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_delegated_entity PRIMARY KEY(`delegated_entity_id`)
) COMMENT 'Organizations delegated to perform credentialing activities on behalf of the health plan.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` (
    `delegation_audit_id` BIGINT COMMENT 'Unique identifier for the delegation audit.',
    `delegated_entity_id` BIGINT COMMENT 'FK to the delegated entity.',
    `employee_id` BIGINT COMMENT 'FK to the auditor employee.',
    `audit_date` DATE COMMENT 'Date of the audit.',
    `audit_disposition` STRING COMMENT 'Disposition of the audit.',
    `audit_notes` STRING COMMENT 'Notes from the audit.',
    `audit_number` STRING COMMENT 'Business-assigned audit number.',
    `audit_period_end` DATE COMMENT 'End of the audit period.',
    `audit_period_start` DATE COMMENT 'Start of the audit period.',
    `audit_scope` STRING COMMENT 'Scope of the audit.',
    `audit_status` STRING COMMENT 'Status of the audit.',
    `audit_type` STRING COMMENT 'Type of audit.',
    `audit_year` STRING COMMENT 'Year of the audit.',
    `auditor_name` STRING COMMENT 'Name of the auditor.',
    `compliance_findings` STRING COMMENT 'Compliance findings from the audit.',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `delegation_entity_name` STRING COMMENT 'Name of the delegated entity.',
    `files_reviewed_count` STRING COMMENT 'Number of files reviewed.',
    `overall_compliance_rate` DECIMAL(18,2) COMMENT 'Overall compliance rate percentage.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_delegation_audit PRIMARY KEY(`delegation_audit_id`)
) COMMENT 'Audit records for delegated credentialing entities to ensure compliance with delegation agreements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` (
    `credential_attestation_id` BIGINT COMMENT 'Unique identifier for the credential attestation.',
    `attestation_id` BIGINT COMMENT 'SSOT reference to compliance attestation.',
    `employee_id` BIGINT COMMENT 'FK to the reviewing employee.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `application_accuracy` BOOLEAN COMMENT 'Whether the application is attested as accurate.',
    `attestation_status` STRING COMMENT 'Status of the attestation.',
    `attestation_timestamp` TIMESTAMP COMMENT 'Timestamp of the attestation.',
    `attestation_type` STRING COMMENT 'Type of attestation.',
    `competence_current` BOOLEAN COMMENT 'Whether competence is current.',
    `compliance_requirement` STRING COMMENT 'Compliance requirement.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `disclosure_text` STRING COMMENT 'Disclosure text provided.',
    `expiration_date` DATE COMMENT 'Expiration date of the attestation.',
    `felony_conviction` BOOLEAN COMMENT 'Whether felony conviction is disclosed.',
    `impairment_absence` BOOLEAN COMMENT 'Whether impairment absence is attested.',
    `malpractice_history_accuracy` BOOLEAN COMMENT 'Whether malpractice history is accurate.',
    `notes` STRING COMMENT 'Free-text notes.',
    `privileges_loss` BOOLEAN COMMENT 'Whether loss of privileges is disclosed.',
    `provider_signature_indicator` BOOLEAN COMMENT 'Whether provider signature is present.',
    `record_source` STRING COMMENT 'Source of the record.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `review_outcome` STRING COMMENT 'Outcome of the review.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp of the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_credential_attestation PRIMARY KEY(`credential_attestation_id`)
) COMMENT 'Provider attestation records for credentialing applications confirming accuracy of submitted information.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` (
    `credential_outreach_id` BIGINT COMMENT 'Unique identifier for the outreach.',
    `employee_id` BIGINT COMMENT 'FK to the employee performing outreach.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `attachment_flag` BOOLEAN COMMENT 'Whether attachments are included.',
    `contact_detail` STRING COMMENT 'Contact details used for outreach.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credential_outreach_status` STRING COMMENT 'Status of the outreach.',
    `document_type_requested` STRING COMMENT 'Type of document requested.',
    `items_requested` STRING COMMENT 'Items requested from the provider.',
    `notes` STRING COMMENT 'Free-text notes.',
    `outcome` STRING COMMENT 'Outcome of the outreach.',
    `outreach_method` STRING COMMENT 'Method of outreach.',
    `outreach_timestamp` TIMESTAMP COMMENT 'Timestamp of the outreach.',
    `outreach_type` STRING COMMENT 'Type of outreach.',
    `priority` STRING COMMENT 'Priority of the outreach.',
    `reference` STRING COMMENT 'Reference information.',
    `response_due_date` DATE COMMENT 'Due date for provider response.',
    `response_method` STRING COMMENT 'Method of response.',
    `response_notes` STRING COMMENT 'Notes from the response.',
    `response_received_date` DATE COMMENT 'Date response was received.',
    `sla_met` BOOLEAN COMMENT 'Whether SLA was met.',
    `sla_target_days` STRING COMMENT 'SLA target in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_credential_outreach PRIMARY KEY(`credential_outreach_id`)
) COMMENT 'Outreach communications to providers during the credentialing process.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` (
    `credential_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the lifecycle event.',
    `audit_finding_id` BIGINT COMMENT 'FK to compliance audit finding.',
    `contract_lifecycle_event_id` BIGINT COMMENT 'SSOT reference to contract lifecycle event.',
    `credential_contract_lifecycle_event_id` BIGINT COMMENT 'FK to contract lifecycle event SSOT.',
    `credential_document_id` BIGINT COMMENT 'FK to the related credential document.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `employee_id` BIGINT COMMENT 'FK to the primary credentialing employee.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to audit trail.',
    `audit_user_role` STRING COMMENT 'Role of the user in the audit trail.',
    `compliance_flag` BOOLEAN COMMENT 'Whether the event is compliance-related.',
    `confidentiality_level` STRING COMMENT 'Confidentiality level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `decision_code` STRING COMMENT 'Code for the decision.',
    `decision_date` DATE COMMENT 'Date of the decision.',
    `document_timestamp` TIMESTAMP COMMENT 'Timestamp of the document.',
    `document_type` STRING COMMENT 'Type of document.',
    `effective_date` DATE COMMENT 'Effective date of the event.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp of escalation.',
    `event_category` STRING COMMENT 'Category of the event.',
    `event_notes` STRING COMMENT 'Notes for the event.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the event.',
    `event_type` STRING COMMENT 'Type of event.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `is_critical` BOOLEAN COMMENT 'Whether the event is critical.',
    `is_escalated` BOOLEAN COMMENT 'Whether the event is escalated.',
    `is_manual` BOOLEAN COMMENT 'Whether the event was manual.',
    `new_status` STRING COMMENT 'New status after the event.',
    `prior_status` STRING COMMENT 'Status before the event.',
    `record_source` STRING COMMENT 'Source of the record.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `resolution_status` STRING COMMENT 'Resolution status.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp of resolution.',
    `risk_score` STRING COMMENT 'Risk score.',
    `risk_score_reason` DOUBLE COMMENT 'Reason for the risk score.',
    `triggering_actor` STRING COMMENT 'Actor that triggered the event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_credential_lifecycle_event PRIMARY KEY(`credential_lifecycle_event_id`)
) COMMENT 'Lifecycle events tracking status changes and key milestones in the credentialing process.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` (
    `cvo_relationship_id` BIGINT COMMENT 'Unique identifier for the CVO relationship.',
    `delegated_entity_id` BIGINT COMMENT 'FK to the delegated entity.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `employee_id` BIGINT COMMENT 'FK to the primary CVO employee.',
    `compliance_flag` BOOLEAN COMMENT 'Whether the CVO is in compliance.',
    `contact_address` STRING COMMENT 'Contact address for the CVO.',
    `contact_email` STRING COMMENT 'Contact email for the CVO.',
    `contact_name` STRING COMMENT 'Contact name for the CVO.',
    `contact_phone` STRING COMMENT 'Contact phone for the CVO.',
    `contract_number` STRING COMMENT 'Contract number.',
    `contract_type` STRING COMMENT 'Type of contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `cvo_relationship_status` STRING COMMENT 'Status of the CVO relationship.',
    `effective_from` DATE COMMENT 'Start date of the relationship.',
    `effective_until` DATE COMMENT 'End date of the relationship.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee amount for CVO services.',
    `fee_currency` DECIMAL(18,2) COMMENT 'Currency of the fee.',
    `is_exclusive` BOOLEAN COMMENT 'Whether the relationship is exclusive.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of last review.',
    `ncqa_certification_expiration` DATE COMMENT 'NCQA certification expiration date.',
    `ncqa_certified` BOOLEAN COMMENT 'Whether the CVO is NCQA certified.',
    `notes` STRING COMMENT 'Free-text notes.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `relationship_type` STRING COMMENT 'Type of relationship.',
    `termination_reason` STRING COMMENT 'Reason for termination.',
    `turnaround_time_sla_days` STRING COMMENT 'SLA turnaround time in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_cvo_relationship PRIMARY KEY(`cvo_relationship_id`)
) COMMENT 'Credentials Verification Organization (CVO) relationships and contracts.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` (
    `expedited_credential_id` BIGINT COMMENT 'Unique identifier for the expedited credential.',
    `employee_id` BIGINT COMMENT 'FK to the approving employee.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `approval_committee` STRING COMMENT 'Committee that approved.',
    `attestation_received` BOOLEAN COMMENT 'Whether attestation was received.',
    `attestation_received_date` DATE COMMENT 'Date attestation was received.',
    `clinical_urgency_justification` STRING COMMENT 'Justification for clinical urgency.',
    `committee_decision_date` DATE COMMENT 'Date of committee decision.',
    `conditions_of_participation` STRING COMMENT 'Conditions for participation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `dea_license_number` STRING COMMENT 'DEA license number.',
    `expedited_credential_status` STRING COMMENT 'Status of the expedited credential.',
    `expedited_reason_code` STRING COMMENT 'Reason code for expediting.',
    `final_credentialing_outcome` STRING COMMENT 'Final outcome.',
    `hospital_privileges_verified` BOOLEAN COMMENT 'Whether hospital privileges are verified.',
    `license_expiration_date` DATE COMMENT 'License expiration date.',
    `malpractice_claims_count` STRING COMMENT 'Number of malpractice claims.',
    `malpractice_history_flag` BOOLEAN COMMENT 'Whether malpractice history exists.',
    `notes` STRING COMMENT 'Free-text notes.',
    `outcome_date` DATE COMMENT 'Date of outcome.',
    `provider_npi` STRING COMMENT 'Provider NPI.',
    `provisional_duration_days` STRING COMMENT 'Duration of provisional status in days.',
    `provisional_end_date` DATE COMMENT 'End date of provisional status.',
    `provisional_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount during provisional period.',
    `provisional_start_date` DATE COMMENT 'Start date of provisional status.',
    `psv_verification_date` DATE COMMENT 'Date of PSV verification.',
    `psv_verification_flag` BOOLEAN COMMENT 'Whether PSV is verified.',
    `request_number` STRING COMMENT 'Request number.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of the request.',
    `requesting_entity_reference` BIGINT COMMENT 'Reference to the requesting entity.',
    `requesting_entity_type` STRING COMMENT 'Type of requesting entity.',
    `sanction_screening_flag` BOOLEAN COMMENT 'Whether sanction screening is complete.',
    `sanction_screening_result` STRING COMMENT 'Result of sanction screening.',
    `state_license_number` STRING COMMENT 'State license number.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `urgency_level` STRING COMMENT 'Level of urgency.',
    CONSTRAINT pk_expedited_credential PRIMARY KEY(`expedited_credential_id`)
) COMMENT 'Expedited credentialing requests for urgent provider participation needs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` (
    `credential_appeal_id` BIGINT COMMENT 'Unique identifier for the credential appeal.',
    `decision_document_id` BIGINT COMMENT 'FK to the decision document.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `record_id` BIGINT COMMENT 'FK to the credential record.',
    `employee_id` BIGINT COMMENT 'FK to the reviewing employee.',
    `appeal_number` STRING COMMENT 'Business-assigned appeal number.',
    `appeal_status` STRING COMMENT 'Status of the appeal.',
    `appeal_type` STRING COMMENT 'Type of appeal.',
    `currency_code` STRING COMMENT 'Currency code.',
    `decision_date` DATE COMMENT 'Date of the appeal decision.',
    `decision_outcome` STRING COMMENT 'Outcome of the appeal decision.',
    `escalation_date` DATE COMMENT 'Date of escalation.',
    `escalation_flag` BOOLEAN COMMENT 'Whether the appeal is escalated.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee amount.',
    `ground` STRING COMMENT 'Grounds for the appeal.',
    `hearing_date` DATE COMMENT 'Date of the hearing.',
    `hearing_panel_members` STRING COMMENT 'Members of the hearing panel.',
    `hearing_panel_type` STRING COMMENT 'Type of hearing panel.',
    `notes` STRING COMMENT 'Free-text notes.',
    `notification_sent_date` DATE COMMENT 'Date notification was sent.',
    `original_decision_date` DATE COMMENT 'Date of the original decision.',
    `original_decision_type` STRING COMMENT 'Type of original decision.',
    `outcome_reason` STRING COMMENT 'Reason for the outcome.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `regulatory_reference` STRING COMMENT 'Regulatory reference.',
    `resolution_action` STRING COMMENT 'Action taken for resolution.',
    `review_deadline` DATE COMMENT 'Deadline for review.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp of submission.',
    `supporting_documentation` STRING COMMENT 'Supporting documentation references.',
    CONSTRAINT pk_credential_appeal PRIMARY KEY(`credential_appeal_id`)
) COMMENT 'Appeals filed by providers against adverse credentialing decisions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` (
    `contract_link_id` BIGINT COMMENT 'Primary key',
    `record_id` BIGINT COMMENT 'FK to credential record',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `contract_role` STRING COMMENT 'Role in contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'The date value representing effective date for this contract link record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this contract link record.',
    `link_status` STRING COMMENT 'The current status indicator for the link within the workflow.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_contract_link PRIMARY KEY(`contract_link_id`)
) COMMENT 'Links between credential records and vendor/provider contracts.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` (
    `obligation_mapping_id` BIGINT COMMENT 'Primary key',
    `record_id` BIGINT COMMENT 'FK to credential record',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'The date value representing effective date for this obligation mapping record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this obligation mapping record.',
    `mapping_notes` STRING COMMENT 'The mapping notes attribute capturing relevant data for the obligation mapping in the credential domain.',
    `obligation_type` STRING COMMENT 'Type of obligation',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_obligation_mapping PRIMARY KEY(`obligation_mapping_id`)
) COMMENT 'Mapping between credential records and regulatory obligations for compliance tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`finding` (
    `finding_id` BIGINT COMMENT 'Primary key',
    `audit_finding_id` BIGINT COMMENT 'FK to audit finding',
    `record_id` BIGINT COMMENT 'FK to credential record',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `finding_description` STRING COMMENT 'A detailed textual description of the finding.',
    `finding_date` DATE COMMENT 'The date value representing finding date for this finding record.',
    `finding_severity` STRING COMMENT 'The finding severity attribute capturing relevant data for the finding in the credential domain.',
    `finding_type` STRING COMMENT 'Type of finding',
    `identified_date` DATE COMMENT 'Date identified',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the finding in the credential domain.',
    `resolution_status` STRING COMMENT 'The current status indicator for the resolution within the workflow.',
    `severity` STRING COMMENT 'Severity level',
    `severity_level` STRING COMMENT 'Severity level detail',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_finding PRIMARY KEY(`finding_id`)
) COMMENT 'Findings from credentialing audits and reviews requiring resolution.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`committee` (
    `committee_id` BIGINT COMMENT 'Unique identifier for the committee.',
    `committee_type_id` BIGINT COMMENT 'FK to the committee type.',
    `credential_document_id` BIGINT COMMENT 'FK to the approval document.',
    `parent_committee_id` BIGINT COMMENT 'FK to parent committee.',
    `approval_by` STRING COMMENT 'Who approved the committee.',
    `approval_comments` STRING COMMENT 'Approval comments.',
    `approval_date` DATE COMMENT 'Date of approval.',
    `approval_document_checksum` STRING COMMENT 'Checksum of the approval document.',
    `approval_document_created_at` TIMESTAMP COMMENT 'Creation timestamp of approval document.',
    `approval_document_format` STRING COMMENT 'Format of the approval document.',
    `approval_document_size` BIGINT COMMENT 'Size of the approval document.',
    `approval_document_type` STRING COMMENT 'Type of approval document.',
    `approval_document_updated_at` TIMESTAMP COMMENT 'Update timestamp of approval document.',
    `approval_document_url` STRING COMMENT 'URL of the approval document.',
    `approval_document_version` STRING COMMENT 'Version of the approval document.',
    `approval_status` STRING COMMENT 'Approval status.',
    `committee_status` STRING COMMENT 'Status of the committee.',
    `committee_type` STRING COMMENT 'Type of committee.',
    `contact_address` STRING COMMENT 'Contact address.',
    `contact_email` STRING COMMENT 'Contact email.',
    `contact_name` STRING COMMENT 'Contact name.',
    `contact_phone` STRING COMMENT 'Contact phone.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `committee_description` STRING COMMENT 'Description of the committee.',
    `end_date` DATE COMMENT 'The date value representing end date for this committee record.',
    `is_active` BOOLEAN COMMENT 'Whether the committee is active.',
    `is_approved` BOOLEAN COMMENT 'Whether the committee is approved.',
    `is_default` BOOLEAN COMMENT 'Whether this is the default committee.',
    `location` STRING COMMENT 'Location of the committee.',
    `committee_name` STRING COMMENT 'Name of the committee.',
    `start_date` DATE COMMENT 'Start date.',
    `updated_at` TIMESTAMP COMMENT 'Update timestamp.',
    `updated_by` STRING COMMENT 'Updated by.',
    `created_by` STRING COMMENT 'Created by.',
    CONSTRAINT pk_committee PRIMARY KEY(`committee_id`)
) COMMENT 'Credentialing committees responsible for reviewing and approving provider credentials.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` (
    `decision_document_id` BIGINT COMMENT 'Unique identifier for the decision document.',
    `employee_id` BIGINT COMMENT 'FK to the authoring employee.',
    `parent_decision_document_id` BIGINT COMMENT 'FK to parent decision document.',
    `primary_decision_approver_employee_id` BIGINT COMMENT 'FK to the approver employee.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `decision_approval_date` DATE COMMENT 'Date of approval.',
    `decision_approval_time` TIMESTAMP COMMENT 'Time of approval.',
    `decision_approver_name` STRING COMMENT 'Name of the approver.',
    `decision_approver_role` STRING COMMENT 'Role of the approver.',
    `decision_author_name` STRING COMMENT 'Name of the author.',
    `decision_author_role` STRING COMMENT 'Role of the author.',
    `decision_date` DATE COMMENT 'Date of the decision.',
    `decision_outcome` STRING COMMENT 'Outcome of the decision.',
    `decision_reason` STRING COMMENT 'Reason for the decision.',
    `decision_time` TIMESTAMP COMMENT 'Time of the decision.',
    `document_number` STRING COMMENT 'Document number.',
    `document_status` STRING COMMENT 'Status of the document.',
    `document_title` STRING COMMENT 'Title of the document.',
    `document_type` STRING COMMENT 'Type of document.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `format` STRING COMMENT 'Format of the document.',
    `hash` STRING COMMENT 'Hash of the document.',
    `language` STRING COMMENT 'Language of the document.',
    `revision` STRING COMMENT 'Revision number.',
    `size_bytes` BIGINT COMMENT 'Size in bytes.',
    `source_system` STRING COMMENT 'Source system.',
    `source_system_code` STRING COMMENT 'Source system code.',
    `source_system_description` STRING COMMENT 'Source system description.',
    `source_system_owner` STRING COMMENT 'Source system owner.',
    `source_system_owner_address` STRING COMMENT 'Owner address.',
    `source_system_owner_code` STRING COMMENT 'Owner code.',
    `source_system_owner_email` STRING COMMENT 'Owner email.',
    `source_system_owner_name` STRING COMMENT 'Owner name.',
    `source_system_owner_phone` STRING COMMENT 'Owner phone.',
    `source_system_status` STRING COMMENT 'Source system status.',
    `source_system_timestamp` TIMESTAMP COMMENT 'Source system timestamp.',
    `source_system_version` STRING COMMENT 'Source system version.',
    `updated_at` TIMESTAMP COMMENT 'Update timestamp.',
    `updated_by` STRING COMMENT 'Updated by.',
    `url` STRING COMMENT 'URL of the document.',
    `version` STRING COMMENT 'Version number.',
    `created_by` STRING COMMENT 'Created by.',
    CONSTRAINT pk_decision_document PRIMARY KEY(`decision_document_id`)
) COMMENT 'Decision documents generated during the credentialing process.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` (
    `credential_document_id` BIGINT COMMENT 'Unique identifier for the credential document.',
    `parent_credential_document_id` BIGINT COMMENT 'FK to parent credential document.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider.',
    `vendor_document_id` BIGINT COMMENT 'Foreign key reference to SSOT vendor.vendor_document for document concept',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `credential_credentialing_event_date` DATE COMMENT 'Date of the credentialing event.',
    `credential_credentialing_event_notes` STRING COMMENT 'Notes for the credentialing event.',
    `credential_credentialing_event_status` STRING COMMENT 'Status of the credentialing event.',
    `credential_credentialing_event_type` STRING COMMENT 'Type of credentialing event.',
    `credential_document_status` STRING COMMENT 'The current status indicator for the credential document within the workflow.',
    `credential_document_type` STRING COMMENT 'The category or classification type of the credential document.',
    `credential_expiration_date` DATE COMMENT 'Expiration date.',
    `credential_issue_date` DATE COMMENT 'Issue date.',
    `credential_issuing_authority` STRING COMMENT 'Issuing authority.',
    `credential_issuing_authority_address` STRING COMMENT 'Issuing authority address.',
    `credential_issuing_authority_city` STRING COMMENT 'Issuing authority city.',
    `credential_issuing_authority_code` STRING COMMENT 'Issuing authority code.',
    `credential_issuing_authority_country` STRING COMMENT 'Issuing authority country.',
    `credential_issuing_authority_email` STRING COMMENT 'Issuing authority email.',
    `credential_issuing_authority_phone` STRING COMMENT 'Issuing authority phone.',
    `credential_issuing_authority_state` STRING COMMENT 'Issuing authority state.',
    `credential_issuing_authority_zip` STRING COMMENT 'Issuing authority zip.',
    `credential_number` STRING COMMENT 'Credential number.',
    `credential_status` STRING COMMENT 'The current status indicator for the credential within the workflow.',
    `credential_status_reason` STRING COMMENT 'Status reason.',
    `credential_type` STRING COMMENT 'The category or classification type of the credential.',
    `credential_verification_date` DATE COMMENT 'Verification date.',
    `credential_verification_method` STRING COMMENT 'Verification method.',
    `credential_verification_notes` STRING COMMENT 'Verification notes.',
    `credential_verification_status` STRING COMMENT 'Verification status.',
    `credential_document_description` STRING COMMENT 'Description.',
    `format` STRING COMMENT 'The format attribute capturing relevant data for the credential document in the credential domain.',
    `language` STRING COMMENT 'The language attribute capturing relevant data for the credential document in the credential domain.',
    `language_code` STRING COMMENT 'Language code.',
    `language_description` STRING COMMENT 'Language description.',
    `page_count` STRING COMMENT 'Page count.',
    `size_bytes` BIGINT COMMENT 'Size in bytes.',
    `status_reason` STRING COMMENT 'Status reason.',
    `title` STRING COMMENT 'The title attribute capturing relevant data for the credential document in the credential domain.',
    `updated_at` TIMESTAMP COMMENT 'Update timestamp.',
    `updated_by` BIGINT COMMENT 'Updated by.',
    `url` STRING COMMENT 'The url attribute capturing relevant data for the credential document in the credential domain.',
    `version` STRING COMMENT 'The version attribute capturing relevant data for the credential document in the credential domain.',
    `created_by` BIGINT COMMENT 'Created by.',
    CONSTRAINT pk_credential_document PRIMARY KEY(`credential_document_id`)
) COMMENT 'Documents associated with provider credentialing including licenses, certifications, and verifications.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` (
    `committee_type_id` BIGINT COMMENT 'Unique identifier for the committee type.',
    `parent_committee_type_id` BIGINT COMMENT 'FK to parent committee type.',
    `allows_virtual_participation` BOOLEAN COMMENT 'Whether virtual participation is allowed.',
    `authority_level` STRING COMMENT 'Authority level of the committee type.',
    `committee_type_category` STRING COMMENT 'The committee type category attribute capturing relevant data for the committee type in the credential domain.',
    `committee_type_code` STRING COMMENT 'A standardized code representing the committee type classification.',
    `committee_type_description` STRING COMMENT 'Description.',
    `display_order` STRING COMMENT 'Display order.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this committee type record.',
    `effective_start_date` DATE COMMENT 'Start date.',
    `meeting_frequency` STRING COMMENT 'Meeting frequency.',
    `minimum_quorum_count` STRING COMMENT 'Minimum quorum count.',
    `committee_type_name` STRING COMMENT 'Name of the committee type.',
    `ncqa_required` BOOLEAN COMMENT 'Whether NCQA requires this type.',
    `regulatory_basis` STRING COMMENT 'Regulatory basis.',
    `requires_physician_chair` BOOLEAN COMMENT 'Whether a physician chair is required.',
    `review_scope` STRING COMMENT 'Review scope.',
    `committee_type_status` STRING COMMENT 'The current status indicator for the committee type within the workflow.',
    `voting_method` STRING COMMENT 'Voting method.',
    CONSTRAINT pk_committee_type PRIMARY KEY(`committee_type_id`)
) COMMENT 'Reference table for types of credentialing committees.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ADD CONSTRAINT `fk_credential_application_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ADD CONSTRAINT `fk_credential_psv_verification_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ADD CONSTRAINT `fk_credential_sanction_screening_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ADD CONSTRAINT `fk_credential_npdb_query_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ADD CONSTRAINT `fk_credential_committee_review_committee_id` FOREIGN KEY (`committee_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee`(`committee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ADD CONSTRAINT `fk_credential_committee_review_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ADD CONSTRAINT `fk_credential_recredential_cycle_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ADD CONSTRAINT `fk_credential_delegation_audit_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ADD CONSTRAINT `fk_credential_credential_attestation_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ADD CONSTRAINT `fk_credential_credential_outreach_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ADD CONSTRAINT `fk_credential_credential_lifecycle_event_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ADD CONSTRAINT `fk_credential_cvo_relationship_delegated_entity_id` FOREIGN KEY (`delegated_entity_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`delegated_entity`(`delegated_entity_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ADD CONSTRAINT `fk_credential_expedited_credential_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_decision_document_id` FOREIGN KEY (`decision_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`decision_document`(`decision_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ADD CONSTRAINT `fk_credential_credential_appeal_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` ADD CONSTRAINT `fk_credential_contract_link_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` ADD CONSTRAINT `fk_credential_obligation_mapping_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` ADD CONSTRAINT `fk_credential_finding_record_id` FOREIGN KEY (`record_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`record`(`record_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ADD CONSTRAINT `fk_credential_committee_committee_type_id` FOREIGN KEY (`committee_type_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee_type`(`committee_type_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ADD CONSTRAINT `fk_credential_committee_credential_document_id` FOREIGN KEY (`credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ADD CONSTRAINT `fk_credential_committee_parent_committee_id` FOREIGN KEY (`parent_committee_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee`(`committee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ADD CONSTRAINT `fk_credential_decision_document_parent_decision_document_id` FOREIGN KEY (`parent_decision_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`decision_document`(`decision_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ADD CONSTRAINT `fk_credential_credential_document_parent_credential_document_id` FOREIGN KEY (`parent_credential_document_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`credential_document`(`credential_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ADD CONSTRAINT `fk_credential_committee_type_parent_committee_type_id` FOREIGN KEY (`parent_committee_type_id`) REFERENCES `vibe_health_insurance_v1`.`credential`.`committee_type`(`committee_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`credential` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`credential` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `delegated_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Committee Decision');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `credentialing_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Cycle Year');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_business_glossary_term' = 'DEA License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `hospital_privileges_verified` SET TAGS ('dbx_business_glossary_term' = 'Hospital Privileges Verified');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `is_delegated` SET TAGS ('dbx_business_glossary_term' = 'Is Delegated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Is Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `last_psv_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last PSV Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `malpractice_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `ncqa_cycle` SET TAGS ('dbx_business_glossary_term' = 'NCQA Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `npdb_query_date` SET TAGS ('dbx_business_glossary_term' = 'NPDB Query Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `primary_psv_status` SET TAGS ('dbx_business_glossary_term' = 'Primary PSV Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `requires_additional_documents` SET TAGS ('dbx_business_glossary_term' = 'Requires Additional Documents');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `sanction_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Screening Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Officer Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Credential Entity Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiration Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_source_system` SET TAGS ('dbx_business_glossary_term' = 'Credential Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_suspension_end` SET TAGS ('dbx_business_glossary_term' = 'Credential Suspension End');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_suspension_start` SET TAGS ('dbx_business_glossary_term' = 'Credential Suspension Start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_tier` SET TAGS ('dbx_business_glossary_term' = 'Credential Tier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credential_version` SET TAGS ('dbx_business_glossary_term' = 'Credential Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_committee_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Committee Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_committee_outcome` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Committee Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `credentialing_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_business_glossary_term' = 'DEA License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `delegated_credential_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegated Credential Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `hospital_privileges_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital Privileges Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `malpractice_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Claims Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `malpractice_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `ncqa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NCQA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `next_recredentialing_due` SET TAGS ('dbx_business_glossary_term' = 'Next Recredentialing Due');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `recredentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `sanctions_screened_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screened Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` SET TAGS ('dbx_fhir_resource' = 'VerificationResult');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `psv_verification_id` SET TAGS ('dbx_business_glossary_term' = 'PSV Verification ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `board_certification` SET TAGS ('dbx_business_glossary_term' = 'Board Certification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `credential_element_identifier` SET TAGS ('dbx_business_glossary_term' = 'Credential Element Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `credential_element_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Element Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `element_category` SET TAGS ('dbx_business_glossary_term' = 'Element Category');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `element_status` SET TAGS ('dbx_business_glossary_term' = 'Element Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `hospital_privilege_scope` SET TAGS ('dbx_business_glossary_term' = 'Hospital Privilege Scope');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `malpractice_insurance_limit` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Insurance Limit');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `malpractice_insurance_type` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Insurance Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `training_program` SET TAGS ('dbx_business_glossary_term' = 'Training Program');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `work_history_details` SET TAGS ('dbx_business_glossary_term' = 'Work History Details');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`psv_verification` ALTER COLUMN `work_history_years` SET TAGS ('dbx_business_glossary_term' = 'Work History Years');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` SET TAGS ('dbx_fhir_resource' = 'VerificationResult');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Screening ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `databases_queried` SET TAGS ('dbx_business_glossary_term' = 'Databases Queried');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `impact_on_credential_status` SET TAGS ('dbx_business_glossary_term' = 'Impact on Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `result_detail` SET TAGS ('dbx_business_glossary_term' = 'Result Detail');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanction_type` SET TAGS ('dbx_business_glossary_term' = 'Sanction Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `sanctioning_authority` SET TAGS ('dbx_business_glossary_term' = 'Sanctioning Authority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_event_type` SET TAGS ('dbx_business_glossary_term' = 'Screening Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Screening Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_business_glossary_term' = 'Screening Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`sanction_screening` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` SET TAGS ('dbx_fhir_resource' = 'VerificationResult');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_query_id` SET TAGS ('dbx_business_glossary_term' = 'NPDB Query ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `hcqia_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'HCQIA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `internal_review_disposition` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `is_continuous_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Is Continuous Enrollment');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `last_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_assigned_query_number` SET TAGS ('dbx_business_glossary_term' = 'NPDB Assigned Query Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `npdb_query_status` SET TAGS ('dbx_business_glossary_term' = 'NPDB Query Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `number_of_reports` SET TAGS ('dbx_business_glossary_term' = 'Number of Reports');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `query_type` SET TAGS ('dbx_business_glossary_term' = 'Query Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `query_version` SET TAGS ('dbx_business_glossary_term' = 'Query Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `report_processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Report Processing Time Seconds');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `total_malpractice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Malpractice Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`npdb_query` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('dbx_subdomain' = 'committee_governance');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_review_id` SET TAGS ('dbx_business_glossary_term' = 'Committee Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_id` SET TAGS ('dbx_business_glossary_term' = 'Committee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `agenda_items` SET TAGS ('dbx_business_glossary_term' = 'Agenda Items');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `appeal_rights_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_name` SET TAGS ('dbx_business_glossary_term' = 'Chair Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_npi` SET TAGS ('dbx_business_glossary_term' = 'Chair NPI');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `chair_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `committee_review_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_dea_valid` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag DEA Valid');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_dea_valid` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_malpractice_history` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag Malpractice History');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_oig_sanction` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag OIG Sanction');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_state_license_valid` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag State License Valid');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `compliance_flag_state_license_valid` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_conditions` SET TAGS ('dbx_business_glossary_term' = 'Decision Conditions');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `meeting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Meeting Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `quorum_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quorum Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `total_providers_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Total Providers Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_review` ALTER COLUMN `voting_record` SET TAGS ('dbx_business_glossary_term' = 'Voting Record');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `recredential_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Recredential Cycle ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `application_received_date` SET TAGS ('dbx_business_glossary_term' = 'Application Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_due_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_priority` SET TAGS ('dbx_business_glossary_term' = 'Cycle Priority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `last_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `outreach_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`recredential_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('dbx_subdomain' = 'delegation_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegated_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `audit_schedule` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegated_entity_status` SET TAGS ('dbx_business_glossary_term' = 'Delegated Entity Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_scope` SET TAGS ('dbx_business_glossary_term' = 'Delegation Scope');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `delegation_type` SET TAGS ('dbx_business_glossary_term' = 'Delegation Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'NCQA Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'NPI');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `organization_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `oversight_audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Oversight Audit Frequency Months');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegated_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('dbx_subdomain' = 'delegation_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` SET TAGS ('dbx_fhir_resource' = 'AuditEvent');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegation_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegated_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_business_glossary_term' = 'Audit Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_period_end` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_period_start` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `audit_year` SET TAGS ('dbx_business_glossary_term' = 'Audit Year');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `compliance_findings` SET TAGS ('dbx_business_glossary_term' = 'Compliance Findings');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegation_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Delegation Entity Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `delegation_entity_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `files_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Files Reviewed Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `overall_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Rate');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`delegation_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` SET TAGS ('dbx_subdomain' = 'compliance_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `credential_attestation_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Attestation ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `attestation_id` SET TAGS ('dbx_business_glossary_term' = 'SSOT Compliance Attestation Ref ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `application_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Application Accuracy');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Attestation Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `attestation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `attestation_type` SET TAGS ('dbx_business_glossary_term' = 'Attestation Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `competence_current` SET TAGS ('dbx_business_glossary_term' = 'Competence Current');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Text');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `felony_conviction` SET TAGS ('dbx_business_glossary_term' = 'Felony Conviction');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `impairment_absence` SET TAGS ('dbx_business_glossary_term' = 'Impairment Absence');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `malpractice_history_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Malpractice History Accuracy');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `privileges_loss` SET TAGS ('dbx_business_glossary_term' = 'Privileges Loss');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `provider_signature_indicator` SET TAGS ('dbx_business_glossary_term' = 'Provider Signature Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `provider_signature_indicator` SET TAGS ('dbx_pii_type' = 'signature');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_attestation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('dbx_subdomain' = 'delegation_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` SET TAGS ('dbx_fhir_resource' = 'Communication');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `credential_outreach_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Outreach ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `contact_detail` SET TAGS ('dbx_business_glossary_term' = 'Contact Detail');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `credential_outreach_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Outreach Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `document_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Document Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `items_requested` SET TAGS ('dbx_business_glossary_term' = 'Items Requested');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Outreach Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outreach Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `outreach_type` SET TAGS ('dbx_business_glossary_term' = 'Outreach Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_notes` SET TAGS ('dbx_business_glossary_term' = 'Response Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_outreach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` SET TAGS ('dbx_fhir_resource' = 'Provenance');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `credential_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Lifecycle Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `contract_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'SSOT Contract Lifecycle Event Ref ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `credential_contract_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `credential_document_id` SET TAGS ('dbx_business_glossary_term' = 'Related Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Credential Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `audit_user_role` SET TAGS ('dbx_business_glossary_term' = 'Audit User Role');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Decision Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `document_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Is Escalated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Is Manual');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `risk_score_reason` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `triggering_actor` SET TAGS ('dbx_business_glossary_term' = 'Triggering Actor');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('dbx_subdomain' = 'delegation_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `cvo_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'CVO Relationship ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `delegated_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary CVO Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_address` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `cvo_relationship_status` SET TAGS ('dbx_business_glossary_term' = 'CVO Relationship Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `ncqa_certification_expiration` SET TAGS ('dbx_business_glossary_term' = 'NCQA Certification Expiration');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `ncqa_certified` SET TAGS ('dbx_business_glossary_term' = 'NCQA Certified');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `turnaround_time_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time SLA Days');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`cvo_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Expedited Credential ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `approval_committee` SET TAGS ('dbx_business_glossary_term' = 'Approval Committee');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `attestation_received` SET TAGS ('dbx_business_glossary_term' = 'Attestation Received');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `attestation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `clinical_urgency_justification` SET TAGS ('dbx_business_glossary_term' = 'Clinical Urgency Justification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `committee_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `conditions_of_participation` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Participation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_business_glossary_term' = 'DEA License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_credential_status` SET TAGS ('dbx_business_glossary_term' = 'Expedited Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `expedited_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Expedited Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `final_credentialing_outcome` SET TAGS ('dbx_business_glossary_term' = 'Final Credentialing Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `hospital_privileges_verified` SET TAGS ('dbx_business_glossary_term' = 'Hospital Privileges Verified');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `malpractice_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Claims Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `malpractice_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice History Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Provider NPI');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Provisional Duration Days');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Provisional Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `provisional_start_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `psv_verification_date` SET TAGS ('dbx_business_glossary_term' = 'PSV Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `psv_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'PSV Verification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `requesting_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `requesting_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `sanction_screening_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanction Screening Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `sanction_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Sanction Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State License Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`expedited_credential` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `credential_appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_document_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `ground` SET TAGS ('dbx_business_glossary_term' = 'Ground');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_panel_members` SET TAGS ('dbx_business_glossary_term' = 'Hearing Panel Members');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `hearing_panel_type` SET TAGS ('dbx_business_glossary_term' = 'Hearing Panel Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `original_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Original Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `original_decision_type` SET TAGS ('dbx_business_glossary_term' = 'Original Decision Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `outcome_reason` SET TAGS ('dbx_business_glossary_term' = 'Outcome Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `review_deadline` SET TAGS ('dbx_business_glossary_term' = 'Review Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_appeal` ALTER COLUMN `supporting_documentation` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('dbx_subdomain' = 'compliance_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('dbx_association_edges' = 'credential.credential_record,vendor.vendor_contract');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`contract_link` SET TAGS ('dbx_fhir_resource' = 'Contract');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('dbx_subdomain' = 'compliance_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('dbx_association_edges' = 'credential.credential_record,compliance.regulatory_obligation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`obligation_mapping` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('dbx_subdomain' = 'compliance_verification');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('dbx_association_edges' = 'credential.credential_record,compliance.audit_finding');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`finding` SET TAGS ('dbx_fhir_resource' = 'DetectedIssue');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('dbx_subdomain' = 'committee_governance');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_id` SET TAGS ('dbx_business_glossary_term' = 'Committee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_type_id` SET TAGS ('dbx_business_glossary_term' = 'Committee Type ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `credential_document_id` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `parent_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Committee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_by` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Comments');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_checksum` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_created_at` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_format` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_size` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Size');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_url` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_document_version` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_status` SET TAGS ('dbx_business_glossary_term' = 'Committee Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_address` SET TAGS ('dbx_business_glossary_term' = 'Committee Contact Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_address` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Committee Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Committee Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Committee Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_description` SET TAGS ('dbx_business_glossary_term' = 'Committee Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Committee End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Committee Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Committee Is Approved');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Committee Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Committee Location');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Committee Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Committee Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Committee Created By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('dbx_subdomain' = 'committee_governance');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` SET TAGS ('dbx_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_document_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `parent_decision_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Decision Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `primary_decision_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Approver Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `primary_decision_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `primary_decision_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approval_time` SET TAGS ('dbx_business_glossary_term' = 'Decision Approval Time');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Approver Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_approver_role` SET TAGS ('dbx_business_glossary_term' = 'Decision Approver Role');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Author Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_author_role` SET TAGS ('dbx_business_glossary_term' = 'Decision Author Role');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `decision_time` SET TAGS ('dbx_business_glossary_term' = 'Decision Time');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Hash');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Revision');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_description` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Owner');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_address` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Owner Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_address` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_code` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Owner Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Owner Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Owner Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Owner Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_owner_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `source_system_version` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Source System Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Decision Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`decision_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Decision Document Created By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('dbx_subdomain' = 'provider_credentialing');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` SET TAGS ('dbx_fhir_resource' = 'DocumentReference');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `parent_credential_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Credential Document ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Credentialing Event Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_notes` SET TAGS ('dbx_business_glossary_term' = 'Credential Credentialing Event Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Credentialing Event Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_credentialing_event_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Credentialing Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_address` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority Address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_address` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_city` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority City');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_country` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority Country');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_email` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority Email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_phone` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority Phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_state` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority State');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_zip` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority Zip');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_issuing_authority_zip` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Credential Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `credential_document_description` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `language_description` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Language Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Page Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Size Bytes');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Status Reason');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Title');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Credential Document URL');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`credential_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Created By');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('dbx_subdomain' = 'committee_governance');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('dbx_domain' = 'credential');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_id` SET TAGS ('dbx_business_glossary_term' = 'Committee Type ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `parent_committee_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Committee Type ID');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `allows_virtual_participation` SET TAGS ('dbx_business_glossary_term' = 'Allows Virtual Participation');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `minimum_quorum_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quorum Count');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `ncqa_required` SET TAGS ('dbx_business_glossary_term' = 'NCQA Required');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `requires_physician_chair` SET TAGS ('dbx_business_glossary_term' = 'Requires Physician Chair');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `review_scope` SET TAGS ('dbx_business_glossary_term' = 'Review Scope');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `committee_type_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`credential`.`committee_type` ALTER COLUMN `voting_method` SET TAGS ('dbx_business_glossary_term' = 'Voting Method');
