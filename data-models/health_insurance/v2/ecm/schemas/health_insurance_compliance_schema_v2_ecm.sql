-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`compliance` COMMENT 'Manages regulatory compliance obligations — HIPAA privacy and security (OCR), ACA market conduct, CMS audit readiness, state DOI filings, NCQA/URAC accreditation, SOC reporting, fraud waste and abuse (FWA) monitoring, and PHI breach notification. Owns regulatory submission calendars, audit findings, corrective action plans (CAPs), compliance attestations, and MLR compliance tracking. Supports ERISA filings and state fair hearing coordination.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `acceptance_date` DATE COMMENT 'Date submission was accepted',
    `attachment_count` STRING COMMENT 'Number of attachments',
    `confirmation_number` STRING COMMENT 'Confirmation number from regulator',
    `contract_provider_contract_id` BIGINT COMMENT 'FK to provider contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Submission due date',
    `fee_currency_code` DECIMAL(18,2) COMMENT 'Currency code for filing fee',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'The numeric filing fee amount value associated with this regulatory submission record.',
    `filing_period_end` DATE COMMENT 'End of filing period',
    `filing_period_start` DATE COMMENT 'Start of filing period',
    `is_critical` BOOLEAN COMMENT 'Critical submission flag',
    `last_reminder_sent_date` DATE COMMENT 'The date value representing last reminder sent date for this regulatory submission record.',
    `lead_time_days` STRING COMMENT 'Lead time in days',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'The numeric net fee amount value associated with this regulatory submission record.',
    `regulatory_body` STRING COMMENT 'Regulatory body name',
    `regulatory_submission_status` STRING COMMENT 'Submission status',
    `rejection_reason_code` STRING COMMENT 'A standardized code representing the rejection reason classification.',
    `reminder_schedule` STRING COMMENT 'The reminder schedule attribute capturing relevant data for the regulatory submission in the compliance domain.',
    `submission_date` DATE COMMENT 'The date value representing submission date for this regulatory submission record.',
    `submission_description` STRING COMMENT 'A detailed textual description of the submission.',
    `submission_method` STRING COMMENT 'The submission method attribute capturing relevant data for the regulatory submission in the compliance domain.',
    `submission_number` STRING COMMENT 'The submission number attribute capturing relevant data for the regulatory submission in the compliance domain.',
    `submission_type` STRING COMMENT 'The category or classification type of the submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Tracks regulatory submissions to governing bodies';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` (
    `audit_engagement_id` BIGINT COMMENT 'Primary key',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation',
    `contract_audit_id` BIGINT COMMENT 'FK to contract audit',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `employee_id` BIGINT COMMENT 'FK to lead auditor',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `audit_body` STRING COMMENT 'Audit body name',
    `audit_category` STRING COMMENT 'The audit category attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_cost_actual` DECIMAL(18,2) COMMENT 'Actual audit cost',
    `audit_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated audit cost',
    `audit_currency` STRING COMMENT 'The audit currency attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_document_reference` STRING COMMENT 'Document reference',
    `audit_engagement_status` STRING COMMENT 'Engagement status',
    `audit_findings_reference` STRING COMMENT 'Findings reference',
    `audit_followup_required` BOOLEAN COMMENT 'Followup required flag',
    `audit_location` STRING COMMENT 'The audit location attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_methodology` STRING COMMENT 'The audit methodology attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_notes` STRING COMMENT 'The audit notes attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_number` STRING COMMENT 'The audit number attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_period_end` DATE COMMENT 'The audit period end attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_period_start` DATE COMMENT 'The audit period start attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_priority` STRING COMMENT 'The audit priority attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_report_release_date` DATE COMMENT 'Report release date',
    `audit_scope` STRING COMMENT 'The audit scope attribute capturing relevant data for the audit engagement in the compliance domain.',
    `audit_type` STRING COMMENT 'The category or classification type of the audit.',
    `compliance_framework` STRING COMMENT 'The compliance framework attribute capturing relevant data for the audit engagement in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_findings` STRING COMMENT 'Critical findings count',
    `engagement_end_date` DATE COMMENT 'The date value representing engagement end date for this audit engagement record.',
    `engagement_start_date` DATE COMMENT 'The date value representing engagement start date for this audit engagement record.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'The last reviewed timestamp attribute capturing relevant data for the audit engagement in the compliance domain.',
    `minor_findings` STRING COMMENT 'Minor findings count',
    `overall_outcome` STRING COMMENT 'The overall outcome attribute capturing relevant data for the audit engagement in the compliance domain.',
    `regulatory_citation` STRING COMMENT 'The regulatory citation attribute capturing relevant data for the audit engagement in the compliance domain.',
    `remediation_plan_due_date` DATE COMMENT 'The date value representing remediation plan due date for this audit engagement record.',
    `remediation_status` STRING COMMENT 'The current status indicator for the remediation within the workflow.',
    `risk_rating` STRING COMMENT 'The risk rating attribute capturing relevant data for the audit engagement in the compliance domain.',
    `significant_findings` STRING COMMENT 'Significant findings count',
    `total_findings` DECIMAL(18,2) COMMENT 'Total findings count',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_audit_engagement PRIMARY KEY(`audit_engagement_id`)
) COMMENT 'Tracks audit engagements and their outcomes';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Primary key',
    `audit_engagement_id` BIGINT COMMENT 'FK to audit engagement',
    `header_id` BIGINT COMMENT 'FK to claim header',
    `employee_id` BIGINT COMMENT 'FK to primary auditor',
    `affected_business_area` STRING COMMENT 'The affected business area attribute capturing relevant data for the audit finding in the compliance domain.',
    `audit_category` STRING COMMENT 'The audit category attribute capturing relevant data for the audit finding in the compliance domain.',
    `audit_finding_status` STRING COMMENT 'Finding status',
    `closed_timestamp` TIMESTAMP COMMENT 'The closed timestamp attribute capturing relevant data for the audit finding in the compliance domain.',
    `compliance_area` STRING COMMENT 'The compliance area attribute capturing relevant data for the audit finding in the compliance domain.',
    `corrective_action_completion_date` DATE COMMENT 'The date value representing corrective action completion date for this audit finding record.',
    `corrective_action_status` STRING COMMENT 'The current status indicator for the corrective action within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `audit_finding_description` STRING COMMENT 'Finding description',
    `due_date` DATE COMMENT 'The date value representing due date for this audit finding record.',
    `effectiveness_assessment` STRING COMMENT 'The effectiveness assessment attribute capturing relevant data for the audit finding in the compliance domain.',
    `effectiveness_score` STRING COMMENT 'The effectiveness score attribute capturing relevant data for the audit finding in the compliance domain.',
    `evidence_document_reference` STRING COMMENT 'The evidence document reference attribute capturing relevant data for the audit finding in the compliance domain.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The numeric financial impact amount value associated with this audit finding record.',
    `financial_impact_currency` STRING COMMENT 'The financial impact currency attribute capturing relevant data for the audit finding in the compliance domain.',
    `finding_number` STRING COMMENT 'The finding number attribute capturing relevant data for the audit finding in the compliance domain.',
    `finding_type` STRING COMMENT 'The category or classification type of the finding.',
    `identified_timestamp` TIMESTAMP COMMENT 'The identified timestamp attribute capturing relevant data for the audit finding in the compliance domain.',
    `is_critical` BOOLEAN COMMENT 'Critical finding flag',
    `is_repeat_finding` BOOLEAN COMMENT 'Repeat finding flag',
    `last_review_timestamp` TIMESTAMP COMMENT 'The last review timestamp attribute capturing relevant data for the audit finding in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the audit finding in the compliance domain.',
    `priority` STRING COMMENT 'The priority attribute capturing relevant data for the audit finding in the compliance domain.',
    `regulatory_citation` STRING COMMENT 'The regulatory citation attribute capturing relevant data for the audit finding in the compliance domain.',
    `related_policy_number` STRING COMMENT 'The related policy number attribute capturing relevant data for the audit finding in the compliance domain.',
    `related_system` STRING COMMENT 'The related system attribute capturing relevant data for the audit finding in the compliance domain.',
    `remediation_action` STRING COMMENT 'The remediation action attribute capturing relevant data for the audit finding in the compliance domain.',
    `remediation_due_date` DATE COMMENT 'The date value representing remediation due date for this audit finding record.',
    `resolution` STRING COMMENT 'The resolution attribute capturing relevant data for the audit finding in the compliance domain.',
    `reviewed_by` BIGINT COMMENT 'Reviewed by employee ID',
    `risk_score` STRING COMMENT 'The risk score attribute capturing relevant data for the audit finding in the compliance domain.',
    `risk_score_source` DOUBLE COMMENT 'The risk score source attribute capturing relevant data for the audit finding in the compliance domain.',
    `root_cause` STRING COMMENT 'The root cause attribute capturing relevant data for the audit finding in the compliance domain.',
    `severity_level` STRING COMMENT 'The severity level attribute capturing relevant data for the audit finding in the compliance domain.',
    `source` STRING COMMENT 'Finding source',
    `tags` STRING COMMENT 'The tags attribute capturing relevant data for the audit finding in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version` STRING COMMENT 'Version number',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual findings from audit engagements';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Primary key',
    `audit_finding_id` BIGINT COMMENT 'FK to audit finding',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `actual_completion_date` DATE COMMENT 'The date value representing actual completion date for this corrective action plan record.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost in USD',
    `audit_comments` STRING COMMENT 'The audit comments attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `closed_timestamp` TIMESTAMP COMMENT 'The closed timestamp attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `compliance_category` STRING COMMENT 'The compliance category attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `compliance_deadline` DATE COMMENT 'The compliance deadline attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `corrective_action_plan_status` STRING COMMENT 'CAP status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in USD',
    `evidence_document_path` STRING COMMENT 'The evidence document path attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `is_external_audit` BOOLEAN COMMENT 'External audit flag',
    `is_fwa_monitoring` BOOLEAN COMMENT 'FWA monitoring flag',
    `last_milestone_status` STRING COMMENT 'The current status indicator for the last milestone within the workflow.',
    `milestone_count` STRING COMMENT 'The total count of milestone items associated with this record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `owner_role` STRING COMMENT 'The owner role attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `plan_name` STRING COMMENT 'The descriptive name assigned to the plan for identification purposes.',
    `plan_number` STRING COMMENT 'The plan number attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `plan_type` STRING COMMENT 'The category or classification type of the plan.',
    `priority` STRING COMMENT 'The priority attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `remediation_strategy` DECIMAL(18,2) COMMENT 'The remediation strategy attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `risk_score` STRING COMMENT 'The risk score attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `root_cause` STRING COMMENT 'The root cause attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `severity` STRING COMMENT 'The severity attribute capturing relevant data for the corrective action plan in the compliance domain.',
    `target_completion_date` DATE COMMENT 'The date value representing target completion date for this corrective action plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Corrective action plans for audit findings';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` (
    `cap_milestone_id` BIGINT COMMENT 'Primary key',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record within the cap milestone entity.',
    `employee_id` BIGINT COMMENT 'FK to primary employee',
    `reviewer_employee_id` BIGINT COMMENT 'FK to reviewer',
    `actual_completion_date` DATE COMMENT 'The date value representing actual completion date for this cap milestone record.',
    `actual_start_date` DATE COMMENT 'The date value representing actual start date for this cap milestone record.',
    `cap_milestone_status` STRING COMMENT 'Milestone status',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The completion percentage attribute capturing relevant data for the cap milestone in the compliance domain.',
    `compliance_category` STRING COMMENT 'The compliance category attribute capturing relevant data for the cap milestone in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `escalated_flag` BOOLEAN COMMENT 'Boolean indicator for the escalated condition or state.',
    `evidence_documentation_url` STRING COMMENT 'The evidence documentation url attribute capturing relevant data for the cap milestone in the compliance domain.',
    `is_critical` BOOLEAN COMMENT 'Critical milestone flag',
    `milestone_code` STRING COMMENT 'A standardized code representing the milestone classification.',
    `milestone_description` STRING COMMENT 'A detailed textual description of the milestone.',
    `milestone_name` STRING COMMENT 'The descriptive name assigned to the milestone for identification purposes.',
    `milestone_type` STRING COMMENT 'The category or classification type of the milestone.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the cap milestone in the compliance domain.',
    `planned_completion_date` DATE COMMENT 'The date value representing planned completion date for this cap milestone record.',
    `planned_start_date` DATE COMMENT 'The date value representing planned start date for this cap milestone record.',
    `priority` STRING COMMENT 'The priority attribute capturing relevant data for the cap milestone in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the cap milestone in the compliance domain.',
    `risk_level` STRING COMMENT 'The risk level attribute capturing relevant data for the cap milestone in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_cap_milestone PRIMARY KEY(`cap_milestone_id`)
) COMMENT 'Milestones for corrective action plans';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` (
    `breach_incident_id` BIGINT COMMENT 'Primary key',
    `baa_id` BIGINT COMMENT 'Unique identifier for the baa record within the breach incident entity.',
    `breach_report_id` BIGINT COMMENT 'FK to breach report',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record within the breach incident entity.',
    `employee_id` BIGINT COMMENT 'FK to incident owner',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `affected_phi_categories` STRING COMMENT 'The affected phi categories attribute capturing relevant data for the breach incident in the compliance domain.',
    `audit_findings` STRING COMMENT 'The audit findings attribute capturing relevant data for the breach incident in the compliance domain.',
    `breach_cause_description` STRING COMMENT 'A detailed textual description of the breach cause.',
    `breach_discovery_date` DATE COMMENT 'The date value representing breach discovery date for this breach incident record.',
    `breach_incident_number` STRING COMMENT 'The breach incident number attribute capturing relevant data for the breach incident in the compliance domain.',
    `breach_occurrence_date` DATE COMMENT 'The date value representing breach occurrence date for this breach incident record.',
    `breach_report_url` STRING COMMENT 'The breach report url attribute capturing relevant data for the breach incident in the compliance domain.',
    `breach_resolution_date` DATE COMMENT 'The date value representing breach resolution date for this breach incident record.',
    `breach_source` STRING COMMENT 'The breach source attribute capturing relevant data for the breach incident in the compliance domain.',
    `breach_status` STRING COMMENT 'The current status indicator for the breach within the workflow.',
    `breach_type` STRING COMMENT 'The category or classification type of the breach.',
    `business_associate_involved` BOOLEAN COMMENT 'Business associate involved flag',
    `contract_provider_contract_id` BIGINT COMMENT 'FK to provider contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `hhs_notification_date` DATE COMMENT 'The date value representing hhs notification date for this breach incident record.',
    `hhs_notified` BOOLEAN COMMENT 'HHS notified flag',
    `notification_content_version` STRING COMMENT 'The notification content version attribute capturing relevant data for the breach incident in the compliance domain.',
    `notification_date` DATE COMMENT 'The date value representing notification date for this breach incident record.',
    `notification_delivery_confirmation` BOOLEAN COMMENT 'The notification delivery confirmation attribute capturing relevant data for the breach incident in the compliance domain.',
    `notification_method` STRING COMMENT 'The notification method attribute capturing relevant data for the breach incident in the compliance domain.',
    `notification_obligation` STRING COMMENT 'The notification obligation attribute capturing relevant data for the breach incident in the compliance domain.',
    `notification_recipient_count` STRING COMMENT 'The total count of notification recipient items associated with this record.',
    `notification_type` STRING COMMENT 'The category or classification type of the notification.',
    `number_of_individuals_affected` STRING COMMENT 'The number of individuals affected attribute capturing relevant data for the breach incident in the compliance domain.',
    `number_of_records_affected` STRING COMMENT 'The number of records affected attribute capturing relevant data for the breach incident in the compliance domain.',
    `regulatory_filing_date` DATE COMMENT 'The date value representing regulatory filing date for this breach incident record.',
    `regulatory_filing_status` STRING COMMENT 'The current status indicator for the regulatory filing within the workflow.',
    `risk_assessment_method` STRING COMMENT 'The risk assessment method attribute capturing relevant data for the breach incident in the compliance domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the breach incident in the compliance domain.',
    `state_notification_date` DATE COMMENT 'The date value representing state notification date for this breach incident record.',
    `state_notified` BOOLEAN COMMENT 'State notified flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_breach_incident PRIMARY KEY(`breach_incident_id`)
) COMMENT 'PHI/PII breach incidents';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` (
    `breach_notification_id` BIGINT COMMENT 'Primary key',
    `breach_incident_id` BIGINT COMMENT 'FK to breach incident',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record within the breach notification entity.',
    `employee_id` BIGINT COMMENT 'FK to notification employee',
    `affected_member_count` STRING COMMENT 'The total count of affected member items associated with this record.',
    `affected_provider_count` STRING COMMENT 'The total count of affected provider items associated with this record.',
    `breach_category` STRING COMMENT 'The breach category attribute capturing relevant data for the breach notification in the compliance domain.',
    `breach_disclosure_date` DATE COMMENT 'The date value representing breach disclosure date for this breach notification record.',
    `breach_discovery_date` DATE COMMENT 'The date value representing breach discovery date for this breach notification record.',
    `breach_notification_status` STRING COMMENT 'Notification status',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `content_version` STRING COMMENT 'The content version attribute capturing relevant data for the breach notification in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deadline_date` DATE COMMENT 'The date value representing deadline date for this breach notification record.',
    `deadline_met` BOOLEAN COMMENT 'Deadline met flag',
    `delivery_confirmation` BOOLEAN COMMENT 'The delivery confirmation attribute capturing relevant data for the breach notification in the compliance domain.',
    `media_outlet_name` STRING COMMENT 'The descriptive name assigned to the media outlet for identification purposes.',
    `notification_content_hash` STRING COMMENT 'The notification content hash attribute capturing relevant data for the breach notification in the compliance domain.',
    `notification_date` DATE COMMENT 'The date value representing notification date for this breach notification record.',
    `notification_method` STRING COMMENT 'The notification method attribute capturing relevant data for the breach notification in the compliance domain.',
    `notification_timestamp` TIMESTAMP COMMENT 'The notification timestamp attribute capturing relevant data for the breach notification in the compliance domain.',
    `notification_type` STRING COMMENT 'The category or classification type of the notification.',
    `number_of_recipients` STRING COMMENT 'The number of recipients attribute capturing relevant data for the breach notification in the compliance domain.',
    `regulatory_body_notified` STRING COMMENT 'The regulatory body notified attribute capturing relevant data for the breach notification in the compliance domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the breach notification in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_breach_notification PRIMARY KEY(`breach_notification_id`)
) COMMENT 'Notifications sent for breach incidents';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` (
    `hipaa_privacy_request_id` BIGINT COMMENT 'Primary key',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `employee_id` BIGINT COMMENT 'FK to processing employee',
    `appeal_deadline` DATE COMMENT 'The appeal deadline attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `appeal_outcome` STRING COMMENT 'The appeal outcome attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'The audit created timestamp attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'The audit updated timestamp attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `denial_reason` STRING COMMENT 'The denial reason attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `disclosure_authorization_basis` STRING COMMENT 'The disclosure authorization basis attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `disclosure_date` DATE COMMENT 'The date value representing disclosure date for this hipaa privacy request record.',
    `disclosure_logged` BOOLEAN COMMENT 'Disclosure logged flag',
    `disclosure_phicategories` STRING COMMENT 'Disclosure PHI categories',
    `disclosure_purpose` STRING COMMENT 'The disclosure purpose attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `disclosure_recipient_type` STRING COMMENT 'The category or classification type of the disclosure recipient.',
    `disposition` STRING COMMENT 'The disposition attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `is_appealed` BOOLEAN COMMENT 'Appealed flag',
    `is_confidential_communication` BOOLEAN COMMENT 'Confidential communication flag',
    `request_channel` STRING COMMENT 'The request channel attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `request_description` STRING COMMENT 'A detailed textual description of the request.',
    `request_number` STRING COMMENT 'The request number attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `request_received_timestamp` TIMESTAMP COMMENT 'The request received timestamp attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `request_source` STRING COMMENT 'The request source attribute capturing relevant data for the hipaa privacy request in the compliance domain.',
    `request_status` STRING COMMENT 'The current status indicator for the request within the workflow.',
    `request_type` STRING COMMENT 'The category or classification type of the request.',
    `response_date` DATE COMMENT 'The date value representing response date for this hipaa privacy request record.',
    `response_due_date` DATE COMMENT 'The date value representing response due date for this hipaa privacy request record.',
    CONSTRAINT pk_hipaa_privacy_request PRIMARY KEY(`hipaa_privacy_request_id`)
) COMMENT 'HIPAA privacy requests from members';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` (
    `phi_disclosure_log_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `hipaa_privacy_request_id` BIGINT COMMENT 'FK to HIPAA request',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `policy_document_id` BIGINT COMMENT 'FK to policy document',
    `authorization_basis` STRING COMMENT 'The authorization basis attribute capturing relevant data for the phi disclosure log in the compliance domain.',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disclosure_method` STRING COMMENT 'The disclosure method attribute capturing relevant data for the phi disclosure log in the compliance domain.',
    `disclosure_status` STRING COMMENT 'The current status indicator for the disclosure within the workflow.',
    `disclosure_timestamp` TIMESTAMP COMMENT 'The disclosure timestamp attribute capturing relevant data for the phi disclosure log in the compliance domain.',
    `is_authorized` BOOLEAN COMMENT 'Authorized flag',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the phi disclosure log in the compliance domain.',
    `phi_category` STRING COMMENT 'The phi category attribute capturing relevant data for the phi disclosure log in the compliance domain.',
    `purpose_of_disclosure` STRING COMMENT 'The purpose of disclosure attribute capturing relevant data for the phi disclosure log in the compliance domain.',
    `recipient_name` STRING COMMENT 'The descriptive name assigned to the recipient for identification purposes.',
    `recipient_type` STRING COMMENT 'The category or classification type of the recipient.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_phi_disclosure_log PRIMARY KEY(`phi_disclosure_log_id`)
) COMMENT 'Log of PHI disclosures';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`baa` (
    `baa_id` BIGINT COMMENT 'Primary key',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `agreement_number` STRING COMMENT 'The agreement number attribute capturing relevant data for the baa in the compliance domain.',
    `agreement_status` STRING COMMENT 'The current status indicator for the agreement within the workflow.',
    `amendment_count` STRING COMMENT 'The total count of amendment items associated with this record.',
    `audit_rights` STRING COMMENT 'The audit rights attribute capturing relevant data for the baa in the compliance domain.',
    `breach_notification_requirements` STRING COMMENT 'The breach notification requirements attribute capturing relevant data for the baa in the compliance domain.',
    `business_associate_name` STRING COMMENT 'The descriptive name assigned to the business associate for identification purposes.',
    `business_associate_type` STRING COMMENT 'The category or classification type of the business associate.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_disposal_method` STRING COMMENT 'The data disposal method attribute capturing relevant data for the baa in the compliance domain.',
    `data_retention_period_months` STRING COMMENT 'Data retention period in months',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this baa record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this baa record.',
    `governing_law` STRING COMMENT 'The governing law attribute capturing relevant data for the baa in the compliance domain.',
    `jurisdiction` STRING COMMENT 'The jurisdiction attribute capturing relevant data for the baa in the compliance domain.',
    `last_amendment_date` DATE COMMENT 'The date value representing last amendment date for this baa record.',
    `permitted_phis` STRING COMMENT 'The permitted phis attribute capturing relevant data for the baa in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the baa in the compliance domain.',
    `renewal_notice_period_days` STRING COMMENT 'Renewal notice period in days',
    `renewal_option` STRING COMMENT 'The renewal option attribute capturing relevant data for the baa in the compliance domain.',
    `scope_of_phi_use` STRING COMMENT 'The scope of phi use attribute capturing relevant data for the baa in the compliance domain.',
    `security_obligations` STRING COMMENT 'The security obligations attribute capturing relevant data for the baa in the compliance domain.',
    `subcontractor_allowed` BOOLEAN COMMENT 'Subcontractor allowed flag',
    `subcontractor_details` STRING COMMENT 'The subcontractor details attribute capturing relevant data for the baa in the compliance domain.',
    `termination_clause` STRING COMMENT 'The termination clause attribute capturing relevant data for the baa in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_baa PRIMARY KEY(`baa_id`)
) COMMENT 'Business Associate Agreements';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` (
    `fwa_case_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `allegation_description` STRING COMMENT 'A detailed textual description of the allegation.',
    `audit_log_url` STRING COMMENT 'The audit log url attribute capturing relevant data for the fwa case in the compliance domain.',
    `case_disposition` STRING COMMENT 'The case disposition attribute capturing relevant data for the fwa case in the compliance domain.',
    `case_number` STRING COMMENT 'The case number attribute capturing relevant data for the fwa case in the compliance domain.',
    `case_open_timestamp` TIMESTAMP COMMENT 'The case open timestamp attribute capturing relevant data for the fwa case in the compliance domain.',
    `case_status` STRING COMMENT 'The current status indicator for the case within the workflow.',
    `case_type` STRING COMMENT 'The category or classification type of the case.',
    `compliance_reference` STRING COMMENT 'The compliance reference attribute capturing relevant data for the fwa case in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `disposition_date` DATE COMMENT 'The date value representing disposition date for this fwa case record.',
    `estimated_exposure_amount` DECIMAL(18,2) COMMENT 'The numeric estimated exposure amount value associated with this fwa case record.',
    `evidence_reference` STRING COMMENT 'The evidence reference attribute capturing relevant data for the fwa case in the compliance domain.',
    `is_high_risk` BOOLEAN COMMENT 'High risk flag',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the fwa case in the compliance domain.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The numeric recovery amount value associated with this fwa case record.',
    `referral_date` DATE COMMENT 'The date value representing referral date for this fwa case record.',
    `referral_source` STRING COMMENT 'The referral source attribute capturing relevant data for the fwa case in the compliance domain.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory reporting condition or state.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the fwa case in the compliance domain.',
    `subject_reference` BIGINT COMMENT 'The subject reference attribute capturing relevant data for the fwa case in the compliance domain.',
    `subject_type` STRING COMMENT 'The category or classification type of the subject.',
    `triage_outcome` STRING COMMENT 'The triage outcome attribute capturing relevant data for the fwa case in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_fwa_case PRIMARY KEY(`fwa_case_id`)
) COMMENT 'Fraud, Waste, and Abuse cases';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` (
    `fwa_referral_id` BIGINT COMMENT 'Primary key',
    `fwa_case_id` BIGINT COMMENT 'FK to FWA case',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber',
    `employee_id` BIGINT COMMENT 'FK to primary FWA employee',
    `allegation_description` STRING COMMENT 'A detailed textual description of the allegation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `due_date` DATE COMMENT 'The date value representing due date for this fwa referral record.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator for the escalation condition or state.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'The numeric estimated loss amount value associated with this fwa referral record.',
    `evidence_reference` STRING COMMENT 'The evidence reference attribute capturing relevant data for the fwa referral in the compliance domain.',
    `fwa_referral_status` STRING COMMENT 'Referral status',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the fwa referral in the compliance domain.',
    `priority` STRING COMMENT 'The priority attribute capturing relevant data for the fwa referral in the compliance domain.',
    `provider_npi` STRING COMMENT 'The provider npi attribute capturing relevant data for the fwa referral in the compliance domain.',
    `referral_date` DATE COMMENT 'The date value representing referral date for this fwa referral record.',
    `referral_number` STRING COMMENT 'The referral number attribute capturing relevant data for the fwa referral in the compliance domain.',
    `referral_source` STRING COMMENT 'The referral source attribute capturing relevant data for the fwa referral in the compliance domain.',
    `referral_type` STRING COMMENT 'The category or classification type of the referral.',
    `subject_type` STRING COMMENT 'The category or classification type of the subject.',
    `triage_outcome` STRING COMMENT 'The triage outcome attribute capturing relevant data for the fwa referral in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_fwa_referral PRIMARY KEY(`fwa_referral_id`)
) COMMENT 'FWA referrals for investigation';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` (
    `mlr_calculation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to calculating employee',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `mlr_product_health_plan_id` BIGINT COMMENT 'FK to product health plan',
    `audit_finding_reference` STRING COMMENT 'The audit finding reference attribute capturing relevant data for the mlr calculation in the compliance domain.',
    `calculation_date` DATE COMMENT 'The date value representing calculation date for this mlr calculation record.',
    `calculation_number` STRING COMMENT 'The calculation number attribute capturing relevant data for the mlr calculation in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `earned_premium_amount` DECIMAL(18,2) COMMENT 'The numeric earned premium amount value associated with this mlr calculation record.',
    `incurred_claims_amount` DECIMAL(18,2) COMMENT 'The numeric incurred claims amount value associated with this mlr calculation record.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the mlr calculation in the compliance domain.',
    `market_segment_code` STRING COMMENT 'A standardized code representing the market segment classification.',
    `mlr_calculation_status` STRING COMMENT 'Calculation status',
    `mlr_percentage` DECIMAL(18,2) COMMENT 'The mlr percentage attribute capturing relevant data for the mlr calculation in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the mlr calculation in the compliance domain.',
    `quality_improvement_expenses_amount` DECIMAL(18,2) COMMENT 'Quality improvement expenses',
    `rebate_amount` DECIMAL(18,2) COMMENT 'The numeric rebate amount value associated with this mlr calculation record.',
    `rebate_disbursement_date` DATE COMMENT 'The date value representing rebate disbursement date for this mlr calculation record.',
    `rebate_disbursement_status` DECIMAL(18,2) COMMENT 'The current status indicator for the rebate disbursement within the workflow.',
    `rebate_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator for the rebate eligibility condition or state.',
    `reporting_year` STRING COMMENT 'The calendar or fiscal year associated with the reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the mlr calculation in the compliance domain.',
    CONSTRAINT pk_mlr_calculation PRIMARY KEY(`mlr_calculation_id`)
) COMMENT 'Medical Loss Ratio calculations';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `accountable_owner` STRING COMMENT 'The accountable owner attribute capturing relevant data for the accreditation program in the compliance domain.',
    `accreditation_program_status` STRING COMMENT 'Program status',
    `accreditation_type` STRING COMMENT 'The category or classification type of the accreditation.',
    `accrediting_body` STRING COMMENT 'The accrediting body attribute capturing relevant data for the accreditation program in the compliance domain.',
    `applicable_standards` STRING COMMENT 'The applicable standards attribute capturing relevant data for the accreditation program in the compliance domain.',
    `audit_trail` STRING COMMENT 'The audit trail attribute capturing relevant data for the accreditation program in the compliance domain.',
    `benchmark_thresholds` STRING COMMENT 'The benchmark thresholds attribute capturing relevant data for the accreditation program in the compliance domain.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The completion percentage attribute capturing relevant data for the accreditation program in the compliance domain.',
    `compliance_category` STRING COMMENT 'The compliance category attribute capturing relevant data for the accreditation program in the compliance domain.',
    `conditions` STRING COMMENT 'The conditions attribute capturing relevant data for the accreditation program in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `decision` STRING COMMENT 'The decision attribute capturing relevant data for the accreditation program in the compliance domain.',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `escalated_flag` BOOLEAN COMMENT 'Boolean indicator for the escalated condition or state.',
    `evidence_documentation_url` STRING COMMENT 'The evidence documentation url attribute capturing relevant data for the accreditation program in the compliance domain.',
    `final_score` DECIMAL(18,2) COMMENT 'The final score attribute capturing relevant data for the accreditation program in the compliance domain.',
    `is_critical` BOOLEAN COMMENT 'Critical flag',
    `last_modified_by` STRING COMMENT 'The last modified by attribute capturing relevant data for the accreditation program in the compliance domain.',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this accreditation program record.',
    `accreditation_program_level` STRING COMMENT 'Program level',
    `measure_thresholds` STRING COMMENT 'The measure thresholds attribute capturing relevant data for the accreditation program in the compliance domain.',
    `measures` STRING COMMENT 'The measures attribute capturing relevant data for the accreditation program in the compliance domain.',
    `next_survey_due_date` DATE COMMENT 'The date value representing next survey due date for this accreditation program record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the accreditation program in the compliance domain.',
    `preliminary_findings` STRING COMMENT 'The preliminary findings attribute capturing relevant data for the accreditation program in the compliance domain.',
    `program_code` STRING COMMENT 'A standardized code representing the program classification.',
    `program_name` STRING COMMENT 'The descriptive name assigned to the program for identification purposes.',
    `rating` STRING COMMENT 'The rating attribute capturing relevant data for the accreditation program in the compliance domain.',
    `recommendations` STRING COMMENT 'The recommendations attribute capturing relevant data for the accreditation program in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the accreditation program in the compliance domain.',
    `renewal_cycle_months` STRING COMMENT 'Renewal cycle in months',
    `risk_level` STRING COMMENT 'The risk level attribute capturing relevant data for the accreditation program in the compliance domain.',
    `scope` STRING COMMENT 'The scope attribute capturing relevant data for the accreditation program in the compliance domain.',
    `survey_end_date` DATE COMMENT 'The date value representing survey end date for this accreditation program record.',
    `survey_start_date` DATE COMMENT 'The date value representing survey start date for this accreditation program record.',
    `survey_type` STRING COMMENT 'The category or classification type of the survey.',
    `surveyor_contact` STRING COMMENT 'The surveyor contact attribute capturing relevant data for the accreditation program in the compliance domain.',
    `surveyor_team` STRING COMMENT 'The surveyor team attribute capturing relevant data for the accreditation program in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_accreditation_program PRIMARY KEY(`accreditation_program_id`)
) COMMENT 'Accreditation programs and their status';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` (
    `accreditation_survey_id` BIGINT COMMENT 'Primary key',
    `accreditation_program_id` BIGINT COMMENT 'FK to accreditation program',
    `employee_id` BIGINT COMMENT 'FK to survey conductor',
    `accreditation_decision` STRING COMMENT 'The accreditation decision attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `accreditation_survey_status` STRING COMMENT 'Survey status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `evidence_documentation_url` STRING COMMENT 'The evidence documentation url attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `final_score` DECIMAL(18,2) COMMENT 'The final score attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `preliminary_findings` STRING COMMENT 'The preliminary findings attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `rating` STRING COMMENT 'The rating attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `recommendation` STRING COMMENT 'The recommendation attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `risk_level` STRING COMMENT 'The risk level attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `survey_location` STRING COMMENT 'The survey location attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `survey_method` STRING COMMENT 'The survey method attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `survey_number` STRING COMMENT 'The survey number attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `survey_region_code` STRING COMMENT 'A standardized code representing the survey region classification.',
    `survey_scope` STRING COMMENT 'The survey scope attribute capturing relevant data for the accreditation survey in the compliance domain.',
    `survey_type` STRING COMMENT 'The category or classification type of the survey.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_accreditation_survey PRIMARY KEY(`accreditation_survey_id`)
) COMMENT 'Accreditation surveys conducted';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to approver',
    `primary_policy_employee_id` BIGINT COMMENT 'FK to primary policy employee',
    `reviewer_employee_id` BIGINT COMMENT 'FK to reviewer',
    `approval_date` DATE COMMENT 'The date value representing approval date for this policy document record.',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `archive_date` DATE COMMENT 'The date value representing archive date for this policy document record.',
    `policy_document_category` STRING COMMENT 'Document category',
    `compliance_area` STRING COMMENT 'The compliance area attribute capturing relevant data for the policy document in the compliance domain.',
    `confidentiality_level` STRING COMMENT 'The confidentiality level attribute capturing relevant data for the policy document in the compliance domain.',
    `contract_provider_contract_id` BIGINT COMMENT 'FK to provider contract',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `distribution_scope` STRING COMMENT 'The distribution scope attribute capturing relevant data for the policy document in the compliance domain.',
    `document_format` STRING COMMENT 'The document format attribute capturing relevant data for the policy document in the compliance domain.',
    `document_size_bytes` BIGINT COMMENT 'Document size in bytes',
    `document_url` STRING COMMENT 'The document url attribute capturing relevant data for the policy document in the compliance domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this policy document record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this policy document record.',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `is_archived` BOOLEAN COMMENT 'Archived flag',
    `is_confidential` BOOLEAN COMMENT 'Confidential flag',
    `next_review_date` DATE COMMENT 'The date value representing next review date for this policy document record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the policy document in the compliance domain.',
    `policy_code` STRING COMMENT 'A standardized code representing the policy classification.',
    `policy_document_status` STRING COMMENT 'Document status',
    `policy_name` STRING COMMENT 'The descriptive name assigned to the policy for identification purposes.',
    `policy_owner_department` STRING COMMENT 'The policy owner department attribute capturing relevant data for the policy document in the compliance domain.',
    `regulatory_citations` STRING COMMENT 'The regulatory citations attribute capturing relevant data for the policy document in the compliance domain.',
    `review_date` DATE COMMENT 'The date value representing review date for this policy document record.',
    `review_outcome` STRING COMMENT 'The review outcome attribute capturing relevant data for the policy document in the compliance domain.',
    `review_type` STRING COMMENT 'The category or classification type of the review.',
    `revision_summary` STRING COMMENT 'The revision summary attribute capturing relevant data for the policy document in the compliance domain.',
    `updated_by` STRING COMMENT 'The updated by attribute capturing relevant data for the policy document in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the policy document in the compliance domain.',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the policy document in the compliance domain.',
    CONSTRAINT pk_policy_document PRIMARY KEY(`policy_document_id`)
) COMMENT 'Compliance policy documents';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` (
    `policy_review_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to approver',
    `policy_document_id` BIGINT COMMENT 'FK to policy document',
    `primary_policy_employee_id` BIGINT COMMENT 'FK to primary policy employee',
    `approver_name` STRING COMMENT 'The descriptive name assigned to the approver for identification purposes.',
    `attachment_count` STRING COMMENT 'The total count of attachment items associated with this record.',
    `compliance_category` STRING COMMENT 'The compliance category attribute capturing relevant data for the policy review in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `evidence_documentation_url` STRING COMMENT 'The evidence documentation url attribute capturing relevant data for the policy review in the compliance domain.',
    `is_critical` BOOLEAN COMMENT 'Critical flag',
    `next_review_date` DATE COMMENT 'The date value representing next review date for this policy review record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the policy review in the compliance domain.',
    `outcome` STRING COMMENT 'The outcome attribute capturing relevant data for the policy review in the compliance domain.',
    `outcome_date` DATE COMMENT 'The date value representing outcome date for this policy review record.',
    `policy_review_status` STRING COMMENT 'The current status indicator for the policy review within the workflow.',
    `policy_version` STRING COMMENT 'The policy version attribute capturing relevant data for the policy review in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the policy review in the compliance domain.',
    `review_date` DATE COMMENT 'The date value representing review date for this policy review record.',
    `review_duration_days` STRING COMMENT 'Review duration in days',
    `review_number` STRING COMMENT 'The review number attribute capturing relevant data for the policy review in the compliance domain.',
    `review_score` DECIMAL(18,2) COMMENT 'The review score attribute capturing relevant data for the policy review in the compliance domain.',
    `review_status` STRING COMMENT 'The current status indicator for the review within the workflow.',
    `review_type` STRING COMMENT 'The category or classification type of the review.',
    `reviewer_name` STRING COMMENT 'The descriptive name assigned to the reviewer for identification purposes.',
    `revision_summary` STRING COMMENT 'The revision summary attribute capturing relevant data for the policy review in the compliance domain.',
    `risk_level` STRING COMMENT 'The risk level attribute capturing relevant data for the policy review in the compliance domain.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'The sign off timestamp attribute capturing relevant data for the policy review in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_policy_review PRIMARY KEY(`policy_review_id`)
) COMMENT 'Reviews of policy documents';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `accessibility_features` STRING COMMENT 'The accessibility features attribute capturing relevant data for the training program in the compliance domain.',
    `assessment_type` STRING COMMENT 'The category or classification type of the assessment.',
    `attachment_count` STRING COMMENT 'The total count of attachment items associated with this record.',
    `attempt_interval_days` STRING COMMENT 'Attempt interval in days',
    `certificate_identifier` STRING COMMENT 'The certificate identifier attribute capturing relevant data for the training program in the compliance domain.',
    `certification_required` BOOLEAN COMMENT 'Certification required flag',
    `completion_deadline` DATE COMMENT 'The completion deadline attribute capturing relevant data for the training program in the compliance domain.',
    `compliance_category` STRING COMMENT 'The compliance category attribute capturing relevant data for the training program in the compliance domain.',
    `content_version` STRING COMMENT 'The content version attribute capturing relevant data for the training program in the compliance domain.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Cost in USD',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_method` STRING COMMENT 'The delivery method attribute capturing relevant data for the training program in the compliance domain.',
    `training_program_description` STRING COMMENT 'Program description',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `external_provider_name` STRING COMMENT 'The descriptive name assigned to the external provider for identification purposes.',
    `format` STRING COMMENT 'The format attribute capturing relevant data for the training program in the compliance domain.',
    `is_archived` BOOLEAN COMMENT 'Archived flag',
    `is_external_provider` BOOLEAN COMMENT 'External provider flag',
    `language` STRING COMMENT 'The language attribute capturing relevant data for the training program in the compliance domain.',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this training program record.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the training program in the compliance domain.',
    `mandatory_flag` BOOLEAN COMMENT 'Boolean indicator for the mandatory condition or state.',
    `max_attempts` STRING COMMENT 'The max attempts attribute capturing relevant data for the training program in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the training program in the compliance domain.',
    `owner_role` STRING COMMENT 'The owner role attribute capturing relevant data for the training program in the compliance domain.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'The passing score threshold attribute capturing relevant data for the training program in the compliance domain.',
    `passing_score_unit` STRING COMMENT 'The passing score unit attribute capturing relevant data for the training program in the compliance domain.',
    `program_code` STRING COMMENT 'A standardized code representing the program classification.',
    `program_name` STRING COMMENT 'The descriptive name assigned to the program for identification purposes.',
    `program_type` STRING COMMENT 'The category or classification type of the program.',
    `regulatory_mandate` STRING COMMENT 'The regulatory mandate attribute capturing relevant data for the training program in the compliance domain.',
    `review_frequency_months` STRING COMMENT 'Review frequency in months',
    `risk_level` STRING COMMENT 'The risk level attribute capturing relevant data for the training program in the compliance domain.',
    `target_audience` STRING COMMENT 'The target audience attribute capturing relevant data for the training program in the compliance domain.',
    `training_hours` DECIMAL(18,2) COMMENT 'The training hours attribute capturing relevant data for the training program in the compliance domain.',
    `training_program_status` STRING COMMENT 'Program status',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the training program in the compliance domain.',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Compliance training programs';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to primary training employee',
    `training_employee_id` BIGINT COMMENT 'FK to employee',
    `training_program_id` BIGINT COMMENT 'FK to training program',
    `training_updated_by_user_employee_id` BIGINT COMMENT 'FK to updating user',
    `assessment_score` DECIMAL(18,2) COMMENT 'The assessment score attribute capturing relevant data for the training completion in the compliance domain.',
    `attestation_text` STRING COMMENT 'The attestation text attribute capturing relevant data for the training completion in the compliance domain.',
    `attestation_timestamp` TIMESTAMP COMMENT 'The attestation timestamp attribute capturing relevant data for the training completion in the compliance domain.',
    `certificate_number` STRING COMMENT 'The certificate number attribute capturing relevant data for the training completion in the compliance domain.',
    `certificate_url` STRING COMMENT 'The certificate url attribute capturing relevant data for the training completion in the compliance domain.',
    `completion_number` STRING COMMENT 'The completion number attribute capturing relevant data for the training completion in the compliance domain.',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp attribute capturing relevant data for the training completion in the compliance domain.',
    `compliance_requirements_met_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance requirements met condition or state.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Cost in USD',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_method` STRING COMMENT 'The delivery method attribute capturing relevant data for the training completion in the compliance domain.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this training completion record.',
    `hours_completed` DECIMAL(18,2) COMMENT 'The hours completed attribute capturing relevant data for the training completion in the compliance domain.',
    `is_external_training` BOOLEAN COMMENT 'External training flag',
    `location` STRING COMMENT 'The location attribute capturing relevant data for the training completion in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the training completion in the compliance domain.',
    `pass_fail_status` STRING COMMENT 'Pass/fail status',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the training completion in the compliance domain.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean indicator for the renewal required condition or state.',
    `scheduled_date` DATE COMMENT 'The date value representing scheduled date for this training completion record.',
    `total_hours_required` DECIMAL(18,2) COMMENT 'The total hours required attribute capturing relevant data for the training completion in the compliance domain.',
    `training_category` STRING COMMENT 'The training category attribute capturing relevant data for the training completion in the compliance domain.',
    `training_completion_status` STRING COMMENT 'Completion status',
    `training_type` STRING COMMENT 'The category or classification type of the training.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `vendor_name` STRING COMMENT 'The descriptive name assigned to the vendor for identification purposes.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Training completion records';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` (
    `employee_screening_id` BIGINT COMMENT 'Primary key',
    `attestation_id` BIGINT COMMENT 'FK to attestation',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `employee_screening_status` STRING COMMENT 'Screening status',
    `is_critical` BOOLEAN COMMENT 'Critical flag',
    `match_detail` STRING COMMENT 'The match detail attribute capturing relevant data for the employee screening in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the employee screening in the compliance domain.',
    `performed_by` STRING COMMENT 'The performed by attribute capturing relevant data for the employee screening in the compliance domain.',
    `performed_by_name` STRING COMMENT 'The descriptive name assigned to the performed by for identification purposes.',
    `re_screening_due_date` DATE COMMENT 'Re-screening due date',
    `resolution_action` STRING COMMENT 'The resolution action attribute capturing relevant data for the employee screening in the compliance domain.',
    `resolution_date` DATE COMMENT 'The date value representing resolution date for this employee screening record.',
    `screening_reference` STRING COMMENT 'The screening reference attribute capturing relevant data for the employee screening in the compliance domain.',
    `screening_result` STRING COMMENT 'The screening result attribute capturing relevant data for the employee screening in the compliance domain.',
    `screening_source` STRING COMMENT 'The screening source attribute capturing relevant data for the employee screening in the compliance domain.',
    `screening_timestamp` TIMESTAMP COMMENT 'The screening timestamp attribute capturing relevant data for the employee screening in the compliance domain.',
    `source_reference` STRING COMMENT 'The source reference attribute capturing relevant data for the employee screening in the compliance domain.',
    `subject_identifier` STRING COMMENT 'The subject identifier attribute capturing relevant data for the employee screening in the compliance domain.',
    `subject_type` STRING COMMENT 'The category or classification type of the subject.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_employee_screening PRIMARY KEY(`employee_screening_id`)
) COMMENT 'Employee screening records';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` (
    `erisa_filing_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `acceptance_date` DATE COMMENT 'The date value representing acceptance date for this erisa filing record.',
    `attachment_count` STRING COMMENT 'The total count of attachment items associated with this record.',
    `audit_trail_reference` BIGINT COMMENT 'The audit trail reference attribute capturing relevant data for the erisa filing in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `erisa_filing_status` STRING COMMENT 'The current status indicator for the erisa filing within the workflow.',
    `fee_currency_code` DECIMAL(18,2) COMMENT 'A standardized code representing the fee currency classification.',
    `filing_date` DATE COMMENT 'The date value representing filing date for this erisa filing record.',
    `filing_description` STRING COMMENT 'A detailed textual description of the filing.',
    `filing_due_date` DATE COMMENT 'The date value representing filing due date for this erisa filing record.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'The numeric filing fee amount value associated with this erisa filing record.',
    `filing_method` STRING COMMENT 'The filing method attribute capturing relevant data for the erisa filing in the compliance domain.',
    `filing_period_end` DATE COMMENT 'The filing period end attribute capturing relevant data for the erisa filing in the compliance domain.',
    `filing_period_start` DATE COMMENT 'The filing period start attribute capturing relevant data for the erisa filing in the compliance domain.',
    `filing_status` STRING COMMENT 'The current status indicator for the filing within the workflow.',
    `filing_type` STRING COMMENT 'The category or classification type of the filing.',
    `is_critical` BOOLEAN COMMENT 'Critical flag',
    `is_fwa_monitoring` BOOLEAN COMMENT 'FWA monitoring flag',
    `last_reminder_sent_date` DATE COMMENT 'The date value representing last reminder sent date for this erisa filing record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the erisa filing in the compliance domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `regulator_acknowledged_date` DATE COMMENT 'The date value representing regulator acknowledged date for this erisa filing record.',
    `regulator_acknowledged_flag` BOOLEAN COMMENT 'Boolean indicator for the regulator acknowledged condition or state.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the erisa filing in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the erisa filing in the compliance domain.',
    `rejection_reason_code` STRING COMMENT 'A standardized code representing the rejection reason classification.',
    `reminder_schedule` STRING COMMENT 'The reminder schedule attribute capturing relevant data for the erisa filing in the compliance domain.',
    `risk_level` STRING COMMENT 'The risk level attribute capturing relevant data for the erisa filing in the compliance domain.',
    `submission_number` STRING COMMENT 'The submission number attribute capturing relevant data for the erisa filing in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the erisa filing in the compliance domain.',
    CONSTRAINT pk_erisa_filing PRIMARY KEY(`erisa_filing_id`)
) COMMENT 'ERISA regulatory filings';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` (
    `state_fair_hearing_id` BIGINT COMMENT 'Primary key',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `identity_id` BIGINT COMMENT 'FK to member identity',
    `adverse_action_type` STRING COMMENT 'The category or classification type of the adverse action.',
    `appeal_filed_date` DATE COMMENT 'The date value representing appeal filed date for this state fair hearing record.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Boolean indicator for the appeal filed condition or state.',
    `attachment_url` STRING COMMENT 'The attachment url attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `compliance_deadline_met` BOOLEAN COMMENT 'Compliance deadline met flag',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `hearing_date` DATE COMMENT 'The date value representing hearing date for this state fair hearing record.',
    `hearing_duration_minutes` STRING COMMENT 'Hearing duration in minutes',
    `hearing_location` STRING COMMENT 'The hearing location attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `hearing_officer_name` STRING COMMENT 'The descriptive name assigned to the hearing officer for identification purposes.',
    `hearing_outcome` STRING COMMENT 'The hearing outcome attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `hearing_request_number` STRING COMMENT 'The hearing request number attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `hearing_type` STRING COMMENT 'The category or classification type of the hearing.',
    `implementation_deadline` DATE COMMENT 'The implementation deadline attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `is_critical` BOOLEAN COMMENT 'Critical flag',
    `member_dob` DATE COMMENT 'Member date of birth',
    `member_name` STRING COMMENT 'The descriptive name assigned to the member for identification purposes.',
    `member_state` STRING COMMENT 'The member state attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `request_timestamp` TIMESTAMP COMMENT 'The request timestamp attribute capturing relevant data for the state fair hearing in the compliance domain.',
    `state_agency_code` STRING COMMENT 'A standardized code representing the state agency classification.',
    `state_fair_hearing_status` STRING COMMENT 'Hearing status',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_state_fair_hearing PRIMARY KEY(`state_fair_hearing_id`)
) COMMENT 'State fair hearing records';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Primary key',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `prior_regulation_regulatory_change_id` BIGINT COMMENT 'FK to prior regulation',
    `amendment_number` STRING COMMENT 'The amendment number attribute capturing relevant data for the regulatory change in the compliance domain.',
    `change_category` STRING COMMENT 'The change category attribute capturing relevant data for the regulatory change in the compliance domain.',
    `compliance_area` STRING COMMENT 'The compliance area attribute capturing relevant data for the regulatory change in the compliance domain.',
    `compliance_deadline` DATE COMMENT 'The compliance deadline attribute capturing relevant data for the regulatory change in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'The date value representing effective date for this regulatory change record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this regulatory change record.',
    `governing_body` STRING COMMENT 'The governing body attribute capturing relevant data for the regulatory change in the compliance domain.',
    `impact_assessment` STRING COMMENT 'The impact assessment attribute capturing relevant data for the regulatory change in the compliance domain.',
    `impacted_business_areas` STRING COMMENT 'The impacted business areas attribute capturing relevant data for the regulatory change in the compliance domain.',
    `implementation_status` STRING COMMENT 'The current status indicator for the implementation within the workflow.',
    `implementation_target_date` DATE COMMENT 'The date value representing implementation target date for this regulatory change record.',
    `is_critical` BOOLEAN COMMENT 'Critical flag',
    `jurisdiction` STRING COMMENT 'The jurisdiction attribute capturing relevant data for the regulatory change in the compliance domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the regulatory change in the compliance domain.',
    `publication_date` DATE COMMENT 'The date value representing publication date for this regulatory change record.',
    `regulation_code` STRING COMMENT 'A standardized code representing the regulation classification.',
    `regulation_name` STRING COMMENT 'The descriptive name assigned to the regulation for identification purposes.',
    `regulation_type` STRING COMMENT 'The category or classification type of the regulation.',
    `regulatory_change_status` STRING COMMENT 'Change status',
    `regulatory_reference_url` STRING COMMENT 'The regulatory reference url attribute capturing relevant data for the regulatory change in the compliance domain.',
    `reporting_frequency_months` STRING COMMENT 'Reporting frequency in months',
    `required_response_actions` STRING COMMENT 'The required response actions attribute capturing relevant data for the regulatory change in the compliance domain.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the regulatory change in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the regulatory change in the compliance domain.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Regulatory change tracking';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` (
    `breach_report_id` BIGINT COMMENT 'Primary key',
    `audit_finding_id` BIGINT COMMENT 'FK to audit finding',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record within the breach report entity.',
    `parent_breach_report_id` BIGINT COMMENT 'FK to parent breach report',
    `affected_entity_description` STRING COMMENT 'A detailed textual description of the affected entity.',
    `affected_entity_type` STRING COMMENT 'The category or classification type of the affected entity.',
    `audit_finding_date` DATE COMMENT 'The date value representing audit finding date for this breach report record.',
    `audit_finding_description` STRING COMMENT 'A detailed textual description of the audit finding.',
    `audit_finding_status` STRING COMMENT 'The current status indicator for the audit finding within the workflow.',
    `breach_amount` DECIMAL(18,2) COMMENT 'The numeric breach amount value associated with this breach report record.',
    `breach_category` STRING COMMENT 'The breach category attribute capturing relevant data for the breach report in the compliance domain.',
    `breach_cause` STRING COMMENT 'The breach cause attribute capturing relevant data for the breach report in the compliance domain.',
    `breach_currency` STRING COMMENT 'The breach currency attribute capturing relevant data for the breach report in the compliance domain.',
    `breach_date` DATE COMMENT 'The date value representing breach date for this breach report record.',
    `breach_description` STRING COMMENT 'A detailed textual description of the breach.',
    `breach_initiated_by` STRING COMMENT 'The breach initiated by attribute capturing relevant data for the breach report in the compliance domain.',
    `breach_initiated_by_contact_email` STRING COMMENT 'Contact email',
    `breach_initiated_by_contact_name` STRING COMMENT 'Contact name',
    `breach_initiated_by_contact_phone` STRING COMMENT 'Contact phone',
    `breach_initiated_by_contact_type` STRING COMMENT 'Contact type',
    `breach_location` STRING COMMENT 'The breach location attribute capturing relevant data for the breach report in the compliance domain.',
    `breach_report_status` STRING COMMENT 'The current status indicator for the breach report within the workflow.',
    `breach_severity` STRING COMMENT 'The breach severity attribute capturing relevant data for the breach report in the compliance domain.',
    `breach_type` STRING COMMENT 'The category or classification type of the breach.',
    `cap_action_description` STRING COMMENT 'A detailed textual description of the cap action.',
    `cap_completion_date` DATE COMMENT 'The date value representing cap completion date for this breach report record.',
    `cap_status` STRING COMMENT 'The current status indicator for the cap within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the breach report in the compliance domain.',
    `notification_date` DATE COMMENT 'The date value representing notification date for this breach report record.',
    `notification_method` STRING COMMENT 'The notification method attribute capturing relevant data for the breach report in the compliance domain.',
    `notification_reference` STRING COMMENT 'The notification reference attribute capturing relevant data for the breach report in the compliance domain.',
    `notification_status` STRING COMMENT 'The current status indicator for the notification within the workflow.',
    `number_of_affected_individuals` STRING COMMENT 'The number of affected individuals attribute capturing relevant data for the breach report in the compliance domain.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the breach report in the compliance domain.',
    `regulatory_filing_date` DATE COMMENT 'The date value representing regulatory filing date for this breach report record.',
    `regulatory_filing_reference` STRING COMMENT 'The regulatory filing reference attribute capturing relevant data for the breach report in the compliance domain.',
    `regulatory_filing_status` STRING COMMENT 'The current status indicator for the regulatory filing within the workflow.',
    `report_date` DATE COMMENT 'The date value representing report date for this breach report record.',
    `report_name` STRING COMMENT 'The descriptive name assigned to the report for identification purposes.',
    `report_number` STRING COMMENT 'The report number attribute capturing relevant data for the breach report in the compliance domain.',
    `report_status` STRING COMMENT 'The current status indicator for the report within the workflow.',
    `report_type` STRING COMMENT 'The category or classification type of the report.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_breach_report PRIMARY KEY(`breach_report_id`)
) COMMENT 'Breach reports for regulatory filing';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` (
    `attestation_id` BIGINT COMMENT 'Primary key for attestation',
    `compliance_attestation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee making the attestation',
    `attestation_date` DATE COMMENT 'Date attestation was made',
    `attestation_status` STRING COMMENT 'Current status of the attestation',
    `attestation_type` STRING COMMENT 'Type of compliance attestation',
    `attester_name` STRING COMMENT 'Name of person making attestation',
    `attester_title` STRING COMMENT 'Title of person making attestation',
    `compliance_period_end` DATE COMMENT 'End of compliance period covered',
    `compliance_period_start` DATE COMMENT 'Start of compliance period covered',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expiration_date` DATE COMMENT 'Date attestation expires',
    `is_active` BOOLEAN COMMENT 'Whether attestation is currently active',
    `review_outcome` STRING COMMENT 'Outcome of attestation review',
    `text` STRING COMMENT 'Full text of the attestation statement',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_attestation PRIMARY KEY(`attestation_id`)
) COMMENT '[SSOT:attestation] Single source of truth (canonical) for the attestation concept. Auto-created product compliance_attestation in domain compliance. SSOT NOTE: This product is the single source of truth (canonical) for the attestation concept across domains. [FHIR-aligned] Designated SSOT for the attestation concept.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ADD CONSTRAINT `fk_compliance_cap_milestone_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`baa`(`baa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_breach_report_id` FOREIGN KEY (`breach_report_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_report`(`breach_report_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ADD CONSTRAINT `fk_compliance_breach_incident_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_breach_incident_id` FOREIGN KEY (`breach_incident_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_incident`(`breach_incident_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ADD CONSTRAINT `fk_compliance_phi_disclosure_log_hipaa_privacy_request_id` FOREIGN KEY (`hipaa_privacy_request_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request`(`hipaa_privacy_request_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ADD CONSTRAINT `fk_compliance_phi_disclosure_log_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ADD CONSTRAINT `fk_compliance_fwa_referral_fwa_case_id` FOREIGN KEY (`fwa_case_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`fwa_case`(`fwa_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ADD CONSTRAINT `fk_compliance_accreditation_survey_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ADD CONSTRAINT `fk_compliance_policy_review_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ADD CONSTRAINT `fk_compliance_employee_screening_attestation_id` FOREIGN KEY (`attestation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`attestation`(`attestation_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_prior_regulation_regulatory_change_id` FOREIGN KEY (`prior_regulation_regulatory_change_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ADD CONSTRAINT `fk_compliance_breach_report_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ADD CONSTRAINT `fk_compliance_breach_report_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ADD CONSTRAINT `fk_compliance_breach_report_parent_breach_report_id` FOREIGN KEY (`parent_breach_report_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`breach_report`(`breach_report_id`);
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_compliance_attestation_id` FOREIGN KEY (`compliance_attestation_id`) REFERENCES `vibe_health_insurance_v1`.`compliance`.`attestation`(`attestation_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`corrective_action_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`cap_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `state_notification_date` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_incident` ALTER COLUMN `state_notified` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_notification` ALTER COLUMN `media_outlet_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`baa` ALTER COLUMN `business_associate_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('dbx_subdomain' = 'fraud_integrity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('dbx_subdomain' = 'fraud_integrity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`fwa_referral` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_product_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`mlr_calculation` ALTER COLUMN `mlr_product_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_document` ALTER COLUMN `policy_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`policy_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `external_provider_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `training_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`training_completion` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`employee_screening` ALTER COLUMN `performed_by_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`erisa_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('dbx_subdomain' = 'fraud_integrity');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_fair_hearing_id` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_officer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `hearing_officer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_dob` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_dob` SET TAGS ('dbx_pii_type' = 'dob');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `member_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_agency_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`state_fair_hearing` ALTER COLUMN `state_fair_hearing_status` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('dbx_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `breach_initiated_by_contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`breach_report` ALTER COLUMN `report_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_subdomain' = 'policy_governance');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_ssot' = 'attestation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_ssot_concept' = 'attestation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_ssot_owner' = 'attestation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` SET TAGS ('dbx_ssot_group' = 'attestation');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` ALTER COLUMN `attestation_id` SET TAGS ('dbx_business_glossary_term' = 'attestation Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` ALTER COLUMN `attester_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`compliance`.`attestation` ALTER COLUMN `attester_name` SET TAGS ('dbx_pii_type' = 'name');
