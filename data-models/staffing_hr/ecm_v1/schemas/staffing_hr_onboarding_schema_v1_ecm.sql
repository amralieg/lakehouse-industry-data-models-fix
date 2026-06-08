-- Schema for Domain: onboarding | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`onboarding` COMMENT 'Owns the end-to-end worker onboarding and offboarding process data. Covers onboarding task checklists, document collection (I-9, direct deposit, tax forms), orientation completion, LMS (Learning Management System) training assignments via SAP SuccessFactors, equipment provisioning, assignment-end workflows, and offboarding processes. Bridges credentialing, compliance, and placement domains to ensure workers are fully ready for assignment start.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` (
    `onboarding_engagement_id` BIGINT COMMENT 'Primary key for engagement',
    `assignment_id` BIGINT COMMENT 'Reference to the placement or assignment that triggered this onboarding engagement.',
    `client_account_id` BIGINT COMMENT 'Reference to the client organization where the worker will be placed.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Each onboarding engagement has a client point-of-contact (hiring manager, site supervisor) for coordination, approvals, and issue escalation. Critical for operational handoffs and client satisfaction ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Onboarding activities incur direct costs (recruiter time, background checks, orientation delivery) that staffing firms allocate to cost centers for internal P&L tracking, budget management, and client',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the system user who created this onboarding engagement record.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: Independent contractors require executed IC agreements before onboarding. Onboarding coordinators verify IC agreement status, W-9 collection, classification compliance. Essential for worker classifica',
    `last_modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the system user who last modified this onboarding engagement record.',
    `onboarding_sla_target_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_sla_target. Business justification: Each onboarding engagement should reference the SLA target definition that governs its timeline and escalation rules. This normalizes SLA management and allows engagements to inherit target values fro',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to joborder.order_header. Business justification: Core staffing workflow: every onboarding engagement originates from a filled job order. Recruiters and onboarding coordinators need to trace which requisition triggered the onboarding, track time-to-f',
    `profile_id` BIGINT COMMENT 'Reference to the worker/candidate being onboarded.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: Onboarding process depends on real-time credentialing readiness assessment to determine if candidate can start assignment. Drives onboarding status transitions and SLA management for placement-blockin',
    `sow_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.sow_agreement. Business justification: SOW-based workers require project-specific onboarding (site access badges, specialized safety training, client-specific systems access, NDA execution). Link to track SOW compliance requirements and mi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Onboarding executes work authorized under specific SOW. Compliance teams verify background check requirements, rate schedules, insurance terms from SOW during onboarding. Critical for SOW compliance v',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal staff member responsible for managing this onboarding engagement.',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to recruitment.submittal. Business justification: Every onboarding engagement originates from an accepted submittal. This link enables traceability for compliance audits, time-to-fill reporting, recruiter attribution, and quality-of-hire analysis tha',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Staffing operations require tracking which supplier provided each contingent worker for performance scorecarding (time-to-fill, fall-off rates), invoicing reconciliation, and compliance verification. ',
    `task_checklist_id` BIGINT COMMENT 'Foreign key linking to onboarding.task_checklist. Business justification: Each onboarding engagement uses a specific task checklist template. This links the engagement to the checklist definition and enables tracking which checklist template is being used for this onboardin',
    `vendor_contact_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contact. Business justification: Supplier contacts coordinate onboarding tasks (document collection, compliance verification, equipment provisioning). Track responsible vendor contact for escalations, SLA management, and communicatio',
    `actual_onboarding_days` STRING COMMENT 'Actual number of business days taken to complete the onboarding process from start to ready-for-assignment.',
    `actual_ready_date` DATE COMMENT 'Actual date when the worker completed all onboarding requirements and became ready for assignment start.',
    `assignment_start_date` DATE COMMENT 'Scheduled first day of work for the worker at the client site.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the onboarding engagement was cancelled before completion.',
    `completed_tasks_count` STRING COMMENT 'Number of onboarding tasks that have been completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of onboarding tasks and requirements completed, calculated as (completed_tasks / total_tasks) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding engagement record was first created in the system.',
    `direct_deposit_status` STRING COMMENT 'Current status of the workers direct deposit banking information setup for payroll.. Valid values are `not_submitted|pending_verification|verified|active|failed`',
    `employment_type` STRING COMMENT 'Type of employment arrangement for this onboarding engagement.. Valid values are `full_time|part_time|temporary|seasonal|contract|per_diem`',
    `equipment_provisioning_status` STRING COMMENT 'Current status of equipment and asset provisioning for the worker (laptop, phone, badge, etc.). [ENUM-REF-CANDIDATE: not_required|pending|ordered|shipped|delivered|assigned|returned — 7 candidates stripped; promote to reference product]',
    `fte_value` DECIMAL(18,2) COMMENT 'Full-Time Equivalent value representing the workers scheduled work capacity (1.0 = full-time, 0.5 = half-time).',
    `hold_reason` STRING COMMENT 'Reason why the onboarding engagement was placed on hold.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding engagement record was last updated.',
    `onboarding_completion_date` DATE COMMENT 'Date when all onboarding tasks, documents, and requirements were fully completed and the engagement was closed.',
    `onboarding_notes` STRING COMMENT 'Free-text notes and comments related to this onboarding engagement, capturing special instructions, issues, or coordinator observations.',
    `onboarding_number` STRING COMMENT 'Human-readable business identifier for this onboarding engagement, used for tracking and reference across systems.. Valid values are `^ONB-[0-9]{8}$`',
    `onboarding_priority` STRING COMMENT 'Priority level assigned to this onboarding engagement based on business urgency and client requirements.. Valid values are `low|normal|high|urgent|critical`',
    `onboarding_start_date` DATE COMMENT 'Date when the onboarding process was initiated for this worker.',
    `onboarding_status` STRING COMMENT 'Current lifecycle status of the onboarding engagement, tracking progress through the onboarding workflow. [ENUM-REF-CANDIDATE: initiated|in_progress|pending_documents|pending_bgc|pending_i9|pending_orientation|pending_training|ready_for_assignment|completed|on_hold|cancelled — 11 candidates stripped; promote to reference product]',
    `onboarding_type` STRING COMMENT 'Classification of the onboarding engagement based on the employment arrangement type.. Valid values are `temp|perm|contract_to_hire|temp_to_perm|redeployment|direct_hire`',
    `orientation_completion_date` DATE COMMENT 'Date when the worker completed the orientation session.',
    `orientation_status` STRING COMMENT 'Current status of the worker orientation session completion.. Valid values are `not_started|scheduled|in_progress|completed|waived`',
    `overdue_tasks_count` STRING COMMENT 'Number of onboarding tasks that are past their due date.',
    `pending_tasks_count` STRING COMMENT 'Number of onboarding tasks that are still pending completion.',
    `sla_target_days` STRING COMMENT 'Number of business days allocated to complete the onboarding process per the client SLA.',
    `target_ready_date` DATE COMMENT 'Target date by which the worker should be fully onboarded and ready to start their assignment.',
    `tax_forms_status` STRING COMMENT 'Current status of required tax withholding forms completion (W-4, state withholding forms).. Valid values are `not_submitted|pending|w4_completed|state_completed|all_completed`',
    `total_tasks_count` STRING COMMENT 'Total number of onboarding tasks assigned to this engagement.',
    `training_completion_date` DATE COMMENT 'Date when all required training modules were completed by the worker.',
    `training_status` STRING COMMENT 'Current status of required training assignments via Learning Management System (LMS).. Valid values are `not_required|assigned|in_progress|completed|overdue|waived`',
    `worker_classification` STRING COMMENT 'Employment classification of the worker for tax and legal purposes.. Valid values are `w2_employee|1099_contractor|eor|peo`',
    CONSTRAINT pk_onboarding_engagement PRIMARY KEY(`onboarding_engagement_id`)
) COMMENT 'Master record for a single worker onboarding engagement tied to a placement or assignment. Tracks onboarding status, start date, target ready-for-assignment date, onboarding type (temp, perm, contract-to-hire, redeployment), assigned coordinator, and completion milestones. SSOT for onboarding status across the staffing lifecycle. One record per worker per placement. Central hub entity — all onboarding activities (tasks, documents, screenings, I-9, orientation, training, equipment, communications) link back to this record.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` (
    `offboarding_record_id` BIGINT COMMENT 'Unique identifier for the offboarding record. Primary key for the offboarding_record product.',
    `assignment_id` BIGINT COMMENT 'Reference to the placement assignment that is ending. Links this offboarding event to the original placement record.',
    `client_account_id` BIGINT COMMENT 'Foreign key linking to client.client_account. Business justification: Offboarding must track which client the worker is separating from for rehire eligibility, conversion tracking, client relationship management, and exit reason analysis. Essential for client retention ',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Offboarding involves client notification, exit interviews with client managers, equipment return coordination, and final approvals. Client contact link is essential for offboarding workflow completion',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Offboarding costs (exit processing, equipment return handling, final pay administration, COBRA notification) are allocated to cost centers for departmental budget tracking and workforce turnover cost ',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the system user who created the offboarding record. Audit field for accountability and data governance.',
    `last_modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the system user who last modified the offboarding record. Audit field for accountability and change tracking.',
    `non_compete_id` BIGINT COMMENT 'Foreign key linking to contract.non_compete. Business justification: Offboarding triggers non-compete enforcement review. HR verifies non-compete terms during exit, documents acknowledgment, tracks restriction start dates, geographic scope. Critical for post-employment',
    `profile_id` BIGINT COMMENT 'Reference to the worker being offboarded. Links to the candidate master record.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the HR or operations staff member responsible for managing the offboarding process. Ensures accountability for completion of all offboarding tasks.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Track supplier for offboarded workers to calculate supplier-specific fall-off rates, rehire eligibility tracking, and performance scorecard metrics. Critical for vendor management and preferred suppli',
    `task_checklist_id` BIGINT COMMENT 'Foreign key linking to onboarding.task_checklist. Business justification: Offboarding workflows use task checklists just like onboarding does. This links the offboarding record to the checklist template that defines required offboarding tasks (equipment return, exit intervi',
    `benefits_termination_date` DATE COMMENT 'Date when the workers health, dental, vision, and other benefits coverage ends. Typically end of month following separation or last day worked.',
    `client_feedback_rating` STRING COMMENT 'Numeric rating provided by the client regarding the workers overall performance during the assignment. Scale typically 1-5 or 1-10.',
    `client_feedback_received` BOOLEAN COMMENT 'Flag indicating whether feedback was received from the client regarding the workers performance and the reason for assignment end.',
    `cobra_notification_date` DATE COMMENT 'Date when COBRA continuation coverage notification was sent to the worker. Must occur within 14 days of separation per federal law.',
    `cobra_notification_required` BOOLEAN COMMENT 'Flag indicating whether the worker is eligible for COBRA continuation coverage and must receive notification. Based on benefits enrollment and separation circumstances.',
    `conversion_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the conversion fee charged to the client when a temporary worker is converted to permanent employment. Calculated per MSA terms.',
    `conversion_to_perm_flag` BOOLEAN COMMENT 'Indicates whether the worker is being converted to a permanent employee of the client. Triggers conversion fee billing and positive outcome tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the offboarding record was first created in the system. Audit field for data lineage and compliance.',
    `equipment_return_date` DATE COMMENT 'Date when all required equipment was returned and verified. Null if equipment return is pending or not applicable.',
    `equipment_return_required` BOOLEAN COMMENT 'Flag indicating whether the worker has company or client equipment that must be returned as part of offboarding.',
    `equipment_return_status` STRING COMMENT 'Current status of equipment return process. Tracks whether all issued equipment has been returned and accounted for.. Valid values are `not_applicable|pending|partial|completed|overdue|lost`',
    `exit_interview_date` DATE COMMENT 'Date when the exit interview was conducted. Null if exit interview was not completed.',
    `exit_interview_status` STRING COMMENT 'Indicates whether an exit interview was conducted with the departing worker. Used for retention analytics and quality improvement.. Valid values are `not_required|scheduled|completed|declined|waived`',
    `exit_reason_category` STRING COMMENT 'High-level categorization of the reason for separation. Used for turnover analytics and retention strategy development. [ENUM-REF-CANDIDATE: compensation|career_growth|work_environment|personal|relocation|performance|client_relationship|commute|benefits|workload|culture — promote to reference product]. Valid values are `compensation|career_growth|work_environment|personal|relocation|performance`',
    `exit_reason_notes` STRING COMMENT 'Detailed notes capturing the specific reasons for separation as provided by the worker or client. Confidential information used for internal analysis.',
    `final_payroll_date` DATE COMMENT 'Date when the workers final paycheck was processed. Used for payroll reconciliation and compliance reporting.',
    `final_timesheet_status` STRING COMMENT 'Status of the workers final timesheet submission and approval. Critical for ensuring complete and accurate final payroll processing.. Valid values are `not_required|pending|submitted|approved|paid`',
    `last_day_worked` DATE COMMENT 'The final date the worker performed work for the client. Used for payroll cutoff, benefits termination, and compliance reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the offboarding record was last updated. Audit field for tracking changes and data currency.',
    `notice_date` DATE COMMENT 'Date when notice of separation was provided by either the worker, client, or staffing company. Used to track notice period compliance.',
    `notice_period_days` STRING COMMENT 'Number of days of notice provided or required per contract terms. Used to assess compliance with contractual notice requirements.',
    `offboarding_checklist_completion_pct` DECIMAL(18,2) COMMENT 'Percentage of required offboarding tasks completed. Calculated from offboarding task checklist. Used to track offboarding process progress.',
    `offboarding_completed_date` DATE COMMENT 'Date when all offboarding tasks were completed and the offboarding record was closed. Represents the official end of the offboarding workflow.',
    `offboarding_initiated_by` STRING COMMENT 'Party that initiated the separation or assignment end. Used for turnover analytics and client relationship management.. Valid values are `worker|client|staffing_company|mutual`',
    `offboarding_status` STRING COMMENT 'Current state of the offboarding workflow. Tracks progress through the offboarding process from initiation to completion.. Valid values are `initiated|in_progress|pending_approval|completed|cancelled|on_hold`',
    `offboarding_type` STRING COMMENT 'Classification of the offboarding event. Indicates the reason and nature of the assignment end or separation. [ENUM-REF-CANDIDATE: assignment_end|voluntary_resignation|client_termination|conversion_to_perm|redeployment|involuntary_termination|performance_termination|contract_completion|mutual_separation|no_call_no_show — promote to reference product]. Valid values are `assignment_end|voluntary_resignation|client_termination|conversion_to_perm|redeployment|involuntary_termination`',
    `pto_payout_amount` DECIMAL(18,2) COMMENT 'Dollar amount of unused PTO paid out to the worker upon separation. Calculated based on accrued balance and applicable state laws.',
    `pto_payout_hours` DECIMAL(18,2) COMMENT 'Number of unused PTO hours paid out to the worker upon separation. Used for payroll calculation and benefits reconciliation.',
    `redeployment_flag` BOOLEAN COMMENT 'Indicates whether the worker is being placed on the bench for redeployment to another assignment rather than full separation. Links to redeployment_candidate when true.',
    `rehire_eligibility` STRING COMMENT 'Determination of whether the worker is eligible for future rehire. Critical for talent pool management and redeployment decisions.. Valid values are `eligible|not_eligible|conditional|under_review`',
    `rehire_eligibility_reason` STRING COMMENT 'Explanation for the rehire eligibility determination. Documents performance issues, policy violations, or positive separation circumstances.',
    `separation_date` DATE COMMENT 'Official date of employment separation from the staffing company. May differ from last day worked due to notice periods or administrative processing.',
    `system_access_revocation_date` DATE COMMENT 'Date when all system access was revoked. Should typically occur on or before the last day worked for security purposes.',
    `system_access_revoked` BOOLEAN COMMENT 'Flag indicating whether all system access credentials (email, VPN, applications) have been deactivated. Critical for information security compliance.',
    `unemployment_claim_filed` BOOLEAN COMMENT 'Flag indicating whether the worker filed for unemployment benefits following separation. Used for SUTA rate management and compliance tracking.',
    CONSTRAINT pk_offboarding_record PRIMARY KEY(`offboarding_record_id`)
) COMMENT 'Master record for a workers assignment-end and separation workflow. Captures offboarding type (assignment end, voluntary resignation, client termination, conversion to perm, redeployment), coordinator assignment, equipment return tracking references, final timesheet reconciliation status, rehire eligibility determination, exit interview status, COBRA notification flag, and last day worked. One record per assignment end event. Links to redeployment_candidate when the worker is flagged for bench management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` (
    `task_checklist_id` BIGINT COMMENT 'Unique identifier for the task checklist template. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the specific client account if this is a client-specific checklist template. Nullable for general templates.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: Onboarding checklists are configured by job category - healthcare roles require medical credentialing tasks, IT roles require system access provisioning, construction roles require safety certificatio',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Client-specific onboarding checklists vary by work site characteristics (union facilities, secure locations, remote sites). Staffing operations require location-specific task templates for compliance ',
    `requirement_rule_id` BIGINT COMMENT 'Reference to the configuration rule that defines when this checklist template should be applied based on placement attributes, client requirements, and regulatory triggers.',
    `active_status` STRING COMMENT 'Current lifecycle status of the checklist template: active (in use), inactive (temporarily disabled), draft (under development), or archived (retired but retained for historical reference).. Valid values are `active|inactive|draft|archived`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether completion of this checklist requires formal approval or sign-off before the worker can start assignment (True) or is informational only (False).',
    `checklist_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the checklist template for system integration and reporting (e.g., HC-TEMP-ONB, IT-CTR-ONB).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `checklist_name` STRING COMMENT 'Business-friendly name of the task checklist template (e.g., Healthcare Temp Onboarding, IT Contractor Onboarding, Light Industrial Assignment End).',
    `checklist_type` STRING COMMENT 'Category of the checklist template indicating the business process it supports: onboarding (new worker start), offboarding (assignment end), redeployment (worker reassignment), or extension (assignment continuation).. Valid values are `onboarding|offboarding|redeployment|extension`',
    `client_specific_flag` BOOLEAN COMMENT 'Indicates whether this checklist template is customized for a specific client account (True) or is a general template applicable across multiple clients (False).',
    `compliance_driven_flag` BOOLEAN COMMENT 'Indicates whether this checklist is driven by regulatory or compliance requirements (True) such as I-9, E-Verify, background checks, or is purely operational (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this checklist template version was first created in the system.',
    `division_code` STRING COMMENT 'Business division or vertical this checklist is designed for (e.g., Healthcare, IT, Light Industrial, Professional). Nullable if checklist is division-agnostic.',
    `effective_date` DATE COMMENT 'Date from which this checklist template version becomes active and available for use in creating task assignments.',
    `estimated_completion_days` STRING COMMENT 'Expected number of business days required to complete all tasks in this checklist under normal circumstances. Used for planning and Service Level Agreement (SLA) management.',
    `expiration_date` DATE COMMENT 'Date after which this checklist template version is no longer active. Nullable for templates with indefinite validity.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether completion of this checklist is mandatory (True) for the associated placement type and scenario, or optional (False).',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this checklist template version.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this checklist template version was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about this checklist template that does not fit structured fields.',
    `owner_role` STRING COMMENT 'Business role or department responsible for maintaining and updating this checklist template (e.g., Onboarding Team, Compliance Department, Credentialing Team).',
    `placement_type` STRING COMMENT 'Type of placement this checklist applies to: temporary, temp-to-perm, contract-to-hire, direct placement, or independent contractor (IC). Determines applicable compliance and onboarding requirements.. Valid values are `temporary|temp_to_perm|contract_to_hire|direct_placement|independent_contractor`',
    `priority_level` STRING COMMENT 'Business priority level of this checklist template indicating urgency and resource allocation: critical (blocking), high (time-sensitive), medium (standard), or low (best-effort).. Valid values are `critical|high|medium|low`',
    `requires_bgc_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes background check (BGC) as a required task, subject to Fair Credit Reporting Act (FCRA) compliance.',
    `requires_credentialing_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes professional credentialing verification tasks (licenses, certifications, continuing education) common in healthcare and specialized roles.',
    `requires_drug_screen_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes drug screening as a required task, common in safety-sensitive positions and certain industries.',
    `requires_equipment_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes equipment provisioning tasks (laptop, phone, badge, tools, Personal Protective Equipment (PPE), etc.).',
    `requires_everify_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes E-Verify electronic employment eligibility verification as a required task, typically for federal contractors or specific state requirements.',
    `requires_i9_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes I-9 Employment Eligibility Verification as a required task, per Immigration and Nationality Act (INA) requirements.',
    `requires_lms_training_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes Learning Management System (LMS) training assignments via SAP SuccessFactors or similar platform.',
    `requires_orientation_flag` BOOLEAN COMMENT 'Indicates whether this checklist includes worker orientation or onboarding training as a required task.',
    `sla_hours` STRING COMMENT 'Service Level Agreement (SLA) target in hours for completing all tasks in this checklist from initiation. Used for performance measurement and client commitments.',
    `task_checklist_description` STRING COMMENT 'Detailed description of the checklist template purpose, scope, and intended use cases. Provides context for users selecting appropriate templates.',
    `task_count` STRING COMMENT 'Total number of individual tasks defined within this checklist template. Used for progress tracking and workload estimation.',
    `version_number` STRING COMMENT 'Version number of this checklist template. Incremented when template is revised to track changes over time and support audit trails.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this checklist template version.',
    CONSTRAINT pk_task_checklist PRIMARY KEY(`task_checklist_id`)
) COMMENT 'Reusable template defining a named collection of required onboarding or offboarding tasks for a specific scenario (e.g., temp healthcare onboarding, IT contractor onboarding, light industrial assignment end). Includes applicable placement type, division, client-specific flag, version number, effective date, and active status. Task_assignment records are instantiated from these templates for each worker engagement. Driven by requirement_rule configuration.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` (
    `task_assignment_id` BIGINT COMMENT 'Unique identifier for the task assignment record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Reference to the placement record this task supports. Links task to the specific job assignment the worker is being onboarded or offboarded from.',
    `bgc_order_id` BIGINT COMMENT 'Foreign key linking to credentialing.bgc_order. Business justification: Onboarding tasks track specific BGC orders for completion monitoring, SLA management, and blocking task resolution. Essential for coordinating background check completion with onboarding workflow prog',
    `credential_instance_id` BIGINT COMMENT 'Reference to the credential instance being verified or collected as part of this task. Links to credentialing domain for licenses, certifications, background checks.',
    `dependency_task_task_assignment_id` BIGINT COMMENT 'Reference to another task assignment that must be completed before this task can begin. Supports sequential task workflows and conditional logic.',
    `direct_deposit_setup_id` BIGINT COMMENT 'Foreign key linking to onboarding.direct_deposit_setup. Business justification: Task assignments can track direct deposit setup completion. This links the task to the direct deposit setup record and enables tracking banking setup as a task completion criterion.',
    `document_collection_id` BIGINT COMMENT 'Foreign key linking to onboarding.document_collection. Business justification: Task assignments can track collection of specific documents. This links the task to the document collection record and enables tracking document submission as a task completion criterion. The existing',
    `drug_screen_id` BIGINT COMMENT 'Foreign key linking to credentialing.drug_screen. Business justification: Onboarding tasks track specific drug screen orders for completion verification and blocking task resolution. Critical for DOT-regulated and client-required drug screening compliance before assignment ',
    `shift_id` BIGINT COMMENT 'Foreign key linking to timesheet.shift. Business justification: Onboarding task completion verification requires confirming the worker completed their first scheduled shift. This is a standard gate for orientation effectiveness measurement, early-tenure quality ch',
    `license_verification_id` BIGINT COMMENT 'Foreign key linking to credentialing.license_verification. Business justification: Onboarding tasks track license verification completion as blocking requirement for healthcare and professional staffing placements. Essential for state licensure compliance and client-required verific',
    `lms_enrollment_id` BIGINT COMMENT 'Foreign key linking to onboarding.lms_enrollment. Business justification: Task assignments can track completion of specific LMS enrollments. This links the task to the enrollment record and enables tracking training completion as a task criterion. The existing training_cour',
    `offboarding_record_id` BIGINT COMMENT 'Reference to the parent offboarding record this task belongs to. Links task to the workers offboarding journey. Null if task is onboarding-related.',
    `onboarding_engagement_id` BIGINT COMMENT 'Reference to the parent onboarding record this task belongs to. Links task to the workers onboarding journey.',
    `orientation_session_id` BIGINT COMMENT 'Foreign key linking to onboarding.orientation_session. Business justification: Task assignments can include attending specific orientation sessions. This links the task to the scheduled session and enables tracking session attendance as a task completion criterion.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the specific internal user (recruiter, coordinator, admin) assigned to facilitate or complete this task. Null if task is worker-facing.',
    `profile_id` BIGINT COMMENT 'Reference to the worker (candidate) to whom this task is assigned. The individual responsible for completing the task or subject of the task.',
    `skills_assessment_id` BIGINT COMMENT 'Foreign key linking to credentialing.skills_assessment. Business justification: Onboarding tasks track skills assessment completion for role qualification verification. Critical for client-required competency validation and placement eligibility determination before assignment st',
    `task_checklist_id` BIGINT COMMENT 'Reference to the task checklist template from which this task assignment was instantiated. Enables traceability to standard task definitions.',
    `tertiary_task_waived_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who authorized the waiver of this task. Null if task was not waived.',
    `training_record_id` BIGINT COMMENT 'Foreign key linking to credentialing.training_record. Business justification: Onboarding tasks track training completion as placement prerequisite. Essential for mandatory safety training, client-specific orientation, and regulatory compliance training completion before assignm',
    `access_granted_date` DATE COMMENT 'The date when system access was successfully provisioned. Null if access has not yet been granted or task is not access-related.',
    `access_revoked_date` DATE COMMENT 'The date when system access was revoked during offboarding. Null if access has not been revoked or task is not access-related.',
    `completed_date` DATE COMMENT 'The date when the task was marked as completed. Null if task is not yet completed.',
    `completed_timestamp` TIMESTAMP COMMENT 'The precise date and time when the task was marked as completed. Provides audit trail for compliance and SLA reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this task assignment record was first created in the system. Audit trail for record creation.',
    `due_date` DATE COMMENT 'The date by which this task must be completed. Used for SLA tracking and escalation workflows.',
    `equipment_item_code` BIGINT COMMENT 'Reference to the specific equipment item being provisioned or returned as part of this task. Examples: laptop, phone, badge, uniform, tools.',
    `escalation_level` STRING COMMENT 'The current escalation level for overdue or blocked tasks. 0 = no escalation, 1 = first reminder, 2 = manager escalation, 3 = executive escalation.',
    `estimated_duration_minutes` STRING COMMENT 'The estimated time in minutes required to complete this task. Used for workload planning and worker communication.',
    `external_task_reference` STRING COMMENT 'The unique identifier for this task in the source system. Enables cross-system reconciliation and integration.',
    `is_blocking` BOOLEAN COMMENT 'Indicates whether this task must be completed before the worker can start their assignment. True for critical compliance tasks like I-9, background checks, drug screens.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this task is required for all workers in this onboarding/offboarding process. False for optional or conditional tasks.',
    `last_reminder_sent_date` DATE COMMENT 'The date when the most recent reminder notification was sent for this task. Used to control reminder frequency and escalation timing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this task assignment record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-form notes or comments about the task assignment. Used for additional context, issues encountered, or special instructions.',
    `responsible_party` STRING COMMENT 'The role or party responsible for completing or facilitating this task. Identifies who must take action to move the task forward. [ENUM-REF-CANDIDATE: worker|recruiter|onboarding_coordinator|client|hr_admin|it_admin|facilities|payroll — 8 candidates stripped; promote to reference product]',
    `scheduled_start_date` DATE COMMENT 'The date when the task becomes active and available for completion. Supports phased onboarding workflows where tasks unlock sequentially.',
    `source_system` STRING COMMENT 'The system of record where this task assignment originated. Examples: SAP SuccessFactors, Bullhorn, Manual Entry, API Integration.',
    `system_access_type` STRING COMMENT 'The type of system access being provisioned or revoked. Examples: ATS, VMS, ERP, Email, VPN, Client Portal, Timekeeping System.',
    `task_category` STRING COMMENT 'Classification of the task type. Categorizes tasks into functional groups for reporting and workflow management. [ENUM-REF-CANDIDATE: document_collection|orientation|training|equipment|compliance|credentialing|system_access|benefits_enrollment|exit_interview|knowledge_transfer — 10 candidates stripped; promote to reference product]',
    `task_description` STRING COMMENT 'Detailed description of the task requirements, instructions, and expected deliverables. Provides context and guidance for task completion.',
    `task_name` STRING COMMENT 'Short descriptive name of the task assignment. Examples: Complete I-9 Form, Submit Direct Deposit Form, Complete Safety Orientation, Return Equipment.',
    `task_priority` STRING COMMENT 'Priority level of the task assignment. Critical tasks block assignment start; high priority tasks are time-sensitive; medium and low priority tasks are standard workflow items.. Valid values are `critical|high|medium|low`',
    `task_status` STRING COMMENT 'Current lifecycle status of the task assignment. Tracks progression from assignment through completion or cancellation. [ENUM-REF-CANDIDATE: not_started|in_progress|pending_review|completed|waived|cancelled|overdue — 7 candidates stripped; promote to reference product]',
    `task_subcategory` STRING COMMENT 'More granular classification within the task category. Examples: Tax Forms, Safety Training, Background Check, Laptop Return.',
    `training_completion_score` DECIMAL(18,2) COMMENT 'The score or percentage achieved by the worker on the training assessment. Null if training does not include assessment or not yet completed.',
    `waived_date` DATE COMMENT 'The date when this task was waived. Null if task was not waived.',
    `waiver_reason` STRING COMMENT 'Explanation for why this task was waived or marked as not applicable. Null if task was not waived.',
    CONSTRAINT pk_task_assignment PRIMARY KEY(`task_assignment_id`)
) COMMENT 'Individual onboarding or offboarding task assigned to a specific worker within their onboarding_record or offboarding_record. Tracks task category (document collection, orientation, training, equipment, compliance, credentialing), responsible party (worker, recruiter, coordinator, client), due date, completion status, and blocking dependencies. Instantiated from task_checklist templates.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` (
    `tax_form_submission_id` BIGINT COMMENT 'Unique identifier for the tax form submission record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement or assignment for which this tax form was submitted. May be null for pre-placement onboarding.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Tax form submission is a required onboarding task. Linking to the onboarding engagement enables tracking tax form completion status as part of overall onboarding workflow and supports compliance repor',
    `profile_id` BIGINT COMMENT 'Identifier of the worker who submitted the tax form. Links to the worker profile in the candidate or placement domain.',
    `supersedes_submission_tax_form_submission_id` BIGINT COMMENT 'Identifier of the prior tax form submission that this submission replaces. Workers may submit updated forms when life events (marriage, dependents, income changes) affect withholding. Null for initial submissions.',
    `task_assignment_id` BIGINT COMMENT 'Identifier of the onboarding task or checklist item that triggered this tax form submission requirement.',
    `vendor_document_id` BIGINT COMMENT 'Identifier of the scanned or electronic document image of the completed tax form stored in the document management system. Required for IRS and state audit compliance.',
    `backup_withholding_indicator` BOOLEAN COMMENT 'Indicates whether the payee is subject to backup withholding (currently 24% federal rate). IRS notifies payers when backup withholding is required due to TIN mismatch or underreporting.',
    `business_name` STRING COMMENT 'Legal business name for independent contractors (1099 workers) who operate as business entities. Captured on W-9 forms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax form submission record was first created in the system. Part of audit trail for compliance and data lineage.',
    `deductions_amount` DECIMAL(18,2) COMMENT 'Annual amount of deductions beyond the standard deduction (itemized deductions, student loan interest, etc.) declared on W-4 Step 4(b). Reduces withholding.',
    `dependents_amount` DECIMAL(18,2) COMMENT 'Dollar amount of dependent credits claimed on the W-4 (Step 3). Reduces withholding based on qualifying dependents.',
    `effective_date` DATE COMMENT 'Date from which the withholding configuration specified in this form becomes effective in payroll processing. Typically the start date of the next pay period after submission.',
    `exempt_expiration_date` DATE COMMENT 'Date on which the workers exemption from withholding expires. IRS requires annual renewal of exemption claims by February 15.',
    `exempt_status` STRING COMMENT 'Indicates whether the worker claims exemption from federal and/or state income tax withholding. Workers must meet IRS criteria (no tax liability prior year and current year) to claim exemption.. Valid values are `Not Exempt|Exempt - Federal|Exempt - State|Exempt - Both`',
    `extra_withholding_amount` DECIMAL(18,2) COMMENT 'Additional dollar amount the worker requests to be withheld from each paycheck, declared on W-4 Step 4(c). Used to avoid underpayment penalties or increase refund.',
    `filing_status` STRING COMMENT 'The workers federal tax filing status as declared on the W-4. Determines standard deduction and withholding calculation method.. Valid values are `Single|Married Filing Jointly|Married Filing Separately|Head of Household|Qualifying Widow(er)`',
    `form_type` STRING COMMENT 'Type of tax form submitted. W-4 for federal withholding, State W-4 for state withholding, W-9 for independent contractors, 1099 Setup for contractor tax configuration, Local Tax Form for municipal withholding, or Other for additional forms.. Valid values are `W-4|State W-4|W-9|1099 Setup|Local Tax Form|Other`',
    `form_version` STRING COMMENT 'Version or year of the tax form template used (e.g., 2023, 2024). IRS and state agencies periodically update form layouts and calculation rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax form submission record was last updated. Tracks changes to verification status, payroll sync status, or corrections.',
    `local_exemptions` STRING COMMENT 'Number of exemptions claimed for local tax withholding purposes.',
    `local_tax_jurisdiction` STRING COMMENT 'Name or code of the local tax jurisdiction (city, county, school district) for which local withholding applies. Relevant in states with local income taxes (e.g., Ohio, Pennsylvania, Indiana).',
    `multiple_jobs_indicator` BOOLEAN COMMENT 'Indicates whether the worker has multiple jobs or a working spouse, requiring adjusted withholding calculation per IRS W-4 Step 2.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the tax form submission. May include worker explanations for unusual withholding requests, HR reviewer notes, or correction instructions.',
    `other_income_amount` DECIMAL(18,2) COMMENT 'Annual amount of other income (interest, dividends, retirement) not subject to withholding, declared on W-4 Step 4(a). Increases withholding to cover tax liability on non-wage income.',
    `payroll_system_sync_date` TIMESTAMP COMMENT 'Timestamp when the withholding configuration was successfully synchronized to the payroll system.',
    `payroll_system_sync_status` STRING COMMENT 'Indicates whether the withholding configuration from this form has been successfully transmitted to and applied in the payroll processing system (TempWorks Payroll).. Valid values are `Not Synced|Synced|Sync Failed|Pending Sync`',
    `signature_date` DATE COMMENT 'Date on which the worker signed the tax form, certifying the information is accurate under penalty of perjury. Required for legal validity of the form.',
    `signature_method` STRING COMMENT 'Method by which the worker signed the form. Electronic signatures via DocuSign or similar platforms are legally equivalent to wet signatures under ESIGN Act.. Valid values are `Electronic Signature|Wet Signature|Digital Certificate|Not Signed`',
    `state_allowances` STRING COMMENT 'Number of state withholding allowances claimed. Some states still use allowance-based withholding systems (pre-2020 federal model).',
    `state_extra_withholding_amount` DECIMAL(18,2) COMMENT 'Additional dollar amount the worker requests to be withheld for state taxes from each paycheck.',
    `state_filing_status` STRING COMMENT 'The workers state tax filing status as declared on the state withholding form. May differ from federal filing status depending on state rules.',
    `submission_date` DATE COMMENT 'Date on which the worker submitted the completed tax form. Used for compliance tracking and audit trail.',
    `submission_method` STRING COMMENT 'Method by which the worker submitted the tax form. Electronic submissions via self-service portals or DocuSign are preferred for compliance and audit trail. Paper forms require scanning and manual data entry.. Valid values are `Electronic - Self Service|Electronic - HR Portal|Paper - Scanned|Paper - Manual Entry|DocuSign|Other`',
    `tax_classification` STRING COMMENT 'Federal tax classification of the payee for 1099 reporting purposes. Determines which 1099 form type (1099-NEC, 1099-MISC, 1099-K) applies and backup withholding rules. [ENUM-REF-CANDIDATE: Individual/Sole Proprietor|C Corporation|S Corporation|Partnership|Trust/Estate|LLC - C Corp|LLC - S Corp|LLC - Partnership|LLC - Disregarded Entity|Other — 10 candidates stripped; promote to reference product]',
    `tax_year` STRING COMMENT 'The tax year for which this form is effective. Typically the calendar year in which the worker will earn income under this withholding configuration.',
    `tin_type` STRING COMMENT 'Type of Taxpayer Identification Number provided on the form. SSN (Social Security Number) for W-2 employees, EIN (Employer Identification Number) for business entities, ITIN (Individual Taxpayer Identification Number) for non-resident aliens.. Valid values are `SSN|EIN|ITIN`',
    `tin_value` DECIMAL(18,2) COMMENT 'The actual Taxpayer Identification Number (SSN, EIN, or ITIN) provided by the worker. Highly sensitive PII used for tax reporting and payroll processing.',
    `verification_status` STRING COMMENT 'Current verification status of the tax form submission. TIN Mismatch indicates IRS TIN validation failure requiring correction. Expired indicates exemption claim has lapsed.. Valid values are `Pending Verification|Verified - Complete|Verified - Incomplete|TIN Mismatch|Rejected|Expired`',
    `verified_by` STRING COMMENT 'Username or identifier of the HR or payroll staff member who verified the completeness and accuracy of the tax form submission.',
    `verified_date` DATE COMMENT 'Date on which the tax form submission was verified and approved for use in payroll processing.',
    CONSTRAINT pk_tax_form_submission PRIMARY KEY(`tax_form_submission_id`)
) COMMENT 'Records worker tax form submissions collected during onboarding. Covers W-4 (federal withholding), state withholding equivalents, W-9 (independent contractor), and 1099 setup forms. Tracks form type, tax year, filing status, allowances or exemptions claimed, additional withholding amount, submission date, effective date, and whether the form supersedes a prior submission. Feeds payroll tax configuration in TempWorks Payroll.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` (
    `direct_deposit_setup_id` BIGINT COMMENT 'Unique identifier for the direct deposit setup record. Primary key.',
    `assignment_id` BIGINT COMMENT 'Reference to the specific placement or assignment for which this direct deposit setup applies. Allows workers to have different banking instructions per assignment if needed.',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last modified this direct deposit setup record. Links to user management system for audit trail and accountability.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Direct deposit setup is a core onboarding task. Linking to the onboarding engagement enables tracking banking setup as part of the overall onboarding workflow and allows reporting on onboarding comple',
    `profile_id` BIGINT COMMENT 'Reference to the worker (candidate placed on assignment) for whom this direct deposit instruction is configured. Links to the worker master record in the placement or candidate domain.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user (worker, HR staff, or system account) who created this direct deposit setup record. Links to user management system for audit trail.',
    `vendor_document_id` BIGINT COMMENT 'Reference to the scanned voided check or bank letter document uploaded by the worker to verify banking details. Links to document management system for audit and compliance purposes.',
    `account_number` STRING COMMENT 'Workers bank account number. Stored encrypted or tokenized. Masked in all user interfaces and reports to protect worker financial data. Required for ACH direct deposit transactions.',
    `account_number_last_four` STRING COMMENT 'Last four digits of the bank account number. Used for display and worker verification purposes without exposing the full account number.. Valid values are `^[0-9]{4}$`',
    `account_type` STRING COMMENT 'Type of bank account for deposit. Checking is most common for payroll; savings and prepaid card options are also supported.. Valid values are `checking|savings|prepaid_card`',
    `ach_return_code` STRING COMMENT 'Standard NACHA return code if the direct deposit transaction was returned by the receiving bank. Examples: R01 (insufficient funds), R02 (account closed), R03 (no account/unable to locate), R04 (invalid account number).',
    `allocation_type` STRING COMMENT 'Method by which pay is allocated to this account. Full amount deposits entire net pay; fixed amount deposits a specific dollar value; percentage deposits a specified percentage of net pay. Supports split-deposit configurations.. Valid values are `full_amount|fixed_amount|percentage`',
    `allocation_value` DECIMAL(18,2) COMMENT 'Numeric value for the allocation. For fixed_amount type, this is the dollar amount (e.g., 500.00). For percentage type, this is the percentage (e.g., 25.00 for 25%). Null for full_amount type.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the account is held. Used for worker reference and audit purposes.',
    `consent_date` DATE COMMENT 'Date when the worker provided consent for direct deposit enrollment. Captured during onboarding process for audit trail and compliance documentation.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether the worker provided explicit consent for direct deposit enrollment. Required for compliance with electronic funds transfer regulations and company policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this direct deposit setup record was first created in the system. Audit field for data lineage and compliance tracking.',
    `effective_end_date` DATE COMMENT 'Date when this direct deposit instruction is no longer active. Null for currently active instructions. Used when worker changes banking details or ends assignment.',
    `effective_start_date` DATE COMMENT 'Date from which this direct deposit instruction becomes active and will be used for payroll processing. Allows for future-dated setup changes.',
    `is_primary_account` BOOLEAN COMMENT 'Indicates whether this is the workers primary direct deposit account. True for the main account; false for secondary split-deposit accounts. Only one account per worker should be marked primary at any given time.',
    `last_used_date` DATE COMMENT 'Date when this direct deposit instruction was last used for an actual payroll transaction. Helps identify stale or unused banking setups for cleanup and security purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this direct deposit setup record was last modified. Updated whenever any field changes. Audit field for change tracking and compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes or comments about this direct deposit setup. Used by HR staff to document special circumstances, worker requests, or troubleshooting details.',
    `prenote_cleared_date` DATE COMMENT 'Date when the prenotification was successfully cleared by the bank, confirming the account is valid and ready for live payroll deposits. Typically 2-3 business days after prenote_sent_date.',
    `prenote_sent_date` DATE COMMENT 'Date when the prenotification (zero-dollar test transaction) was sent to the bank to verify account validity. Required by NACHA rules before live direct deposit can begin.',
    `priority_sequence` STRING COMMENT 'Order in which this deposit instruction is processed when multiple accounts are configured (split deposit). Lower numbers are processed first. Typically 1 for primary account, 2+ for secondary accounts.',
    `rejection_reason` STRING COMMENT 'Explanation if the direct deposit setup was rejected during prenote or live processing. Common reasons include invalid routing number, closed account, or account type mismatch. Populated from ACH return codes.',
    `routing_number` STRING COMMENT 'Nine-digit ABA routing transit number identifying the financial institution. Masked or tokenized in reporting layers for security. Required for ACH transactions.. Valid values are `^[0-9]{9}$`',
    `setup_method` STRING COMMENT 'Method by which the direct deposit information was captured. Worker self-service is most common during onboarding via SAP SuccessFactors portal. HR manual entry used for exceptions. Bulk import and API integration used for large-scale onboarding events.. Valid values are `worker_self_service|hr_manual_entry|bulk_import|api_integration`',
    `verification_status` STRING COMMENT 'Current verification and activation status of the direct deposit setup. Prenote (prenotification) is a zero-dollar ACH transaction sent to validate account details before live payroll. Active indicates the account is verified and in use. [ENUM-REF-CANDIDATE: pending|prenote_sent|prenote_cleared|active|rejected|suspended|inactive — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_direct_deposit_setup PRIMARY KEY(`direct_deposit_setup_id`)
) COMMENT 'Captures worker direct deposit banking instructions collected during onboarding. Tracks bank name, routing number (masked), account number (masked/tokenized), account type (checking, savings), allocation type (full amount, fixed amount, percentage), allocation value, priority sequence (for split deposits), effective date, and verification status (prenote sent, prenote cleared, active, rejected). Supports split-deposit configurations with multiple records per worker. Feeds TempWorks Payroll for pay distribution.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` (
    `document_collection_id` BIGINT COMMENT 'Primary key for document_collection',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement or assignment associated with this document collection, if applicable.',
    `credential_document_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential_document. Business justification: Onboarding document collection references credentialing documents (licenses, certifications, BGC reports) for unified document management and compliance verification. Enables single source of truth fo',
    `envelope_id` BIGINT COMMENT 'Unique envelope identifier from DocuSign CLM for documents sent via DocuSign for electronic signature.',
    `ic_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.ic_agreement. Business justification: IC agreements are collected as onboarding documents. Document_collection tracks IC agreement execution status, version control, signature dates, storage location. Essential for IC agreement document l',
    `nda_id` BIGINT COMMENT 'Foreign key linking to contract.nda. Business justification: NDAs are collected during onboarding (candidate NDAs) and offboarding (exit confidentiality agreements). Document_collection tracks NDA execution, expiration dates, storage. Critical for confidentiali',
    `offboarding_record_id` BIGINT COMMENT 'Foreign key linking to onboarding.offboarding_record. Business justification: Offboarding requires document collection (exit paperwork, equipment return receipts, final timesheets). This links documents to the offboarding workflow and enables tracking offboarding completion sta',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Document collection is a primary onboarding activity. Linking documents to the onboarding engagement enables tracking document completion status as part of overall onboarding progress and supports onb',
    `profile_id` BIGINT COMMENT 'Identifier of the worker (candidate or employee) for whom this document was collected during onboarding or offboarding.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the HR staff member, recruiter, or compliance officer who reviewed and approved the document submission.',
    `additional_withholding_amount` DECIMAL(18,2) COMMENT 'Additional dollar amount the worker requests to be withheld from each paycheck, as declared on W-4 or state withholding form. Applicable to tax form document types.',
    `allowances_claimed` STRING COMMENT 'Number of withholding allowances or exemptions claimed on tax form (W-4 or state withholding). Applicable to tax form document types. Used by TempWorks Payroll for withholding calculation. Note: Post-2020 W-4 uses different methodology; this field supports legacy forms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document collection record was first created in the system.',
    `document_name` STRING COMMENT 'Human-readable name or title of the document collected (e.g., Master Service Agreement Acknowledgment, Non-Disclosure Agreement, W-4 Federal Withholding).',
    `document_status` STRING COMMENT 'Current lifecycle status of the document in the collection and signing workflow. [ENUM-REF-CANDIDATE: pending|sent|viewed|signed|completed|declined|expired|voided — 8 candidates stripped; promote to reference product]',
    `document_type` STRING COMMENT 'Type of document collected during onboarding or offboarding. [ENUM-REF-CANDIDATE: msa_acknowledgment|nda|non_compete|handbook_acknowledgment|safety_policy|drug_screen_consent|bgc_authorization|fcra_disclosure|offer_letter|assignment_confirmation|w4|state_withholding|w9|1099_setup|i9|direct_deposit_form|emergency_contact_form|equipment_acknowledgment|confidentiality_agreement|code_of_conduct|pto_policy|benefits_enrollment|cobra_notice|final_paycheck_acknowledgment|exit_interview|property_return_form — promote to reference product]. Valid values are `msa_acknowledgment|nda|non_compete|handbook_acknowledgment|safety_policy|drug_screen_consent`',
    `document_version` STRING COMMENT 'Version identifier of the document template or form used (e.g., v2.1, 2024-Q1), ensuring compliance with the correct policy or legal version.',
    `effective_date` DATE COMMENT 'Date from which the document becomes effective or binding, particularly relevant for tax forms (W-4, state withholding) and policy acknowledgments.',
    `exempt_flag` BOOLEAN COMMENT 'Indicates whether the worker claimed exempt status from federal or state withholding on the tax form (True = exempt, False = not exempt). Applicable to W-4 and state withholding document types.',
    `expiration_date` DATE COMMENT 'Date on which the document expires and may need to be renewed or re-signed (e.g., annual policy acknowledgments, time-limited consents).',
    `filing_status` STRING COMMENT 'Federal tax filing status declared on W-4 form. Applicable only to W-4 document type. Used by TempWorks Payroll for federal withholding calculation.. Valid values are `single|married_filing_jointly|married_filing_separately|head_of_household|qualifying_widow`',
    `form_submission_date` DATE COMMENT 'Date the worker submitted the completed form to the employer or staffing agency. May differ from signed_date for forms that require additional processing or manual submission.',
    `is_electronic_signature` BOOLEAN COMMENT 'Indicates whether the document was signed electronically via DocuSign or similar platform (True) or via wet signature/manual process (False).',
    `is_required` BOOLEAN COMMENT 'Indicates whether this document is mandatory for the worker to complete onboarding or offboarding (True) or optional (False).',
    `onboarding_phase` STRING COMMENT 'Phase of the onboarding or offboarding lifecycle during which this document was collected (e.g., pre-hire, post-offer, first day, orientation, assignment start, offboarding).. Valid values are `pre_hire|post_offer|first_day|orientation|assignment_start|offboarding`',
    `rejection_reason` STRING COMMENT 'Reason the document was rejected or declined, if applicable (e.g., incomplete information, incorrect form version, illegible signature).',
    `review_date` DATE COMMENT 'Date the document was reviewed and approved by HR or compliance staff.',
    `review_notes` STRING COMMENT 'Free-text notes or comments entered by the reviewer regarding the document review, any issues identified, or follow-up actions required.',
    `sent_date` DATE COMMENT 'Date the document was sent to the worker for review or signature.',
    `signed_date` DATE COMMENT 'Date the worker signed or acknowledged the document, completing the signature workflow.',
    `signer_ip_address` STRING COMMENT 'IP address from which the worker signed the document electronically, captured for audit and compliance purposes.',
    `source_system` STRING COMMENT 'System or platform from which the document was originated or collected (e.g., DocuSign CLM, SAP SuccessFactors, TempWorks Payroll, manual upload).. Valid values are `docusign_clm|sap_successfactors|tempworks_payroll|manual_upload|bullhorn_ats`',
    `storage_location` STRING COMMENT 'Reference to the physical or digital storage location where the signed document is archived (e.g., cloud storage URI, document management system path, file share location).',
    `supersedes_prior_flag` BOOLEAN COMMENT 'Indicates whether this document supersedes or replaces a previously submitted document of the same type (True) or is a new submission (False). Particularly relevant for tax forms (W-4, state withholding) when workers update their withholding elections.',
    `tax_year` STRING COMMENT 'Tax year for which the tax form document (W-4, state withholding, W-9, 1099 setup) is applicable. Null for non-tax documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this document collection record was last modified or updated.',
    `viewed_date` DATE COMMENT 'Date the worker first viewed or opened the document.',
    CONSTRAINT pk_document_collection PRIMARY KEY(`document_collection_id`)
) COMMENT 'Tracks each document collected, signed, or acknowledged during the onboarding or offboarding process. Covers document type (MSA acknowledgment, NDA, non-compete, handbook acknowledgment, safety policy, drug screen consent, BGC authorization, FCRA disclosure, offer letter, assignment confirmation, W-4, state withholding, W-9, 1099 setup), document source system (DocuSign CLM, SAP SuccessFactors, TempWorks, manual upload), DocuSign envelope ID, signed date, expiration date, storage location reference, document status, and tax-form-specific fields (tax year, filing status, allowances or exemptions claimed, additional withholding amount, effective date, supersedes prior flag, form submission date). Consolidates all onboarding document types including tax form submissions into a single collection entity differentiated by document_type. Feeds payroll tax configuration in TempWorks Payroll for tax form document types (W-4, state withholding, W-9, 1099).';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` (
    `orientation_session_id` BIGINT COMMENT 'Unique identifier for the orientation session. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for client-led or client-site orientation sessions. Null for agency-led sessions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Orientation sessions incur facilitator costs, venue rental, materials, catering that must be allocated to cost centers for training budget management and cost-per-hire analysis. Standard practice for ',
    `lms_course_id` BIGINT COMMENT 'Identifier for the associated LMS course or training module if orientation includes e-learning components.',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Orientation sessions are scheduled at specific client work sites. Capacity planning, worker assignment to sessions, and logistics (parking, badge pickup) require linking sessions to physical locations',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the orientation session concluded. Used for duration tracking and compliance reporting.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the orientation session began. May differ from scheduled time.',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether workers must pass an assessment or quiz to complete the orientation.',
    `attended_count` STRING COMMENT 'Number of workers who actually attended the orientation session. Updated after session completion.',
    `average_satisfaction_score` DECIMAL(18,2) COMMENT 'Average satisfaction rating from attendee feedback surveys, typically on a scale of 1-5 or 1-10.',
    `completed_count` STRING COMMENT 'Number of workers who successfully completed all orientation requirements and passed any assessments.',
    `compliance_category` STRING COMMENT 'Classification of compliance requirements addressed by this orientation (e.g., OSHA safety, client-mandated, industry-specific).. Valid values are `safety|regulatory|client-specific|general|industry-specific|mandatory`',
    `cost_per_attendee` DECIMAL(18,2) COMMENT 'Cost incurred per worker attending the orientation, including facilitator time, materials, and facility costs. Used for internal cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the orientation session record was first created in the system.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Planned or actual duration of the orientation session in hours. Used for scheduling and compliance tracking.',
    `facilitator_email` STRING COMMENT 'Email address of the orientation facilitator for coordination and follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facilitator_name` STRING COMMENT 'Name of the person conducting or leading the orientation session (internal staff or client representative).',
    `facilitator_phone` STRING COMMENT 'Contact phone number for the orientation facilitator.',
    `feedback_survey_sent` BOOLEAN COMMENT 'Indicates whether a post-orientation feedback survey was sent to attendees.',
    `interpreter_provided` BOOLEAN COMMENT 'Indicates whether language interpretation services are provided for this orientation session.',
    `language` STRING COMMENT 'Primary language in which the orientation is conducted, using ISO 639-2 three-letter language codes (e.g., ENG, SPA, FRA).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the orientation session record was last updated.',
    `location_type` STRING COMMENT 'Category of physical or virtual location where the orientation is conducted.. Valid values are `office|client-site|training-center|virtual|remote|field`',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether attendance at this orientation session is mandatory for worker assignment eligibility.',
    `materials_provided` STRING COMMENT 'Description of materials distributed during orientation (e.g., Employee Handbook, Safety Manual, Benefits Guide, ID Badge).',
    `notes` STRING COMMENT 'Free-text notes or comments about the orientation session, including special circumstances, issues encountered, or follow-up actions required.',
    `orientation_type` STRING COMMENT 'Delivery method for the orientation session. Determines logistics and technology requirements.. Valid values are `in-person|virtual|client-site|self-paced|hybrid|on-demand`',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to pass the orientation assessment, if applicable.',
    `physical_location` STRING COMMENT 'Physical address or facility name where in-person orientation is held (e.g., Main Office - Conference Room A, Client Site - Building 3).',
    `recording_available` BOOLEAN COMMENT 'Indicates whether a recording of the orientation session is available for workers who missed the live session.',
    `recording_url` STRING COMMENT 'URL or storage location of the orientation session recording. Confidential to control access.',
    `registered_count` STRING COMMENT 'Number of workers currently registered for this orientation session.',
    `scheduled_date` DATE COMMENT 'Date the orientation session is scheduled to occur. Used for planning and worker notification.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Precise timestamp when the orientation session is scheduled to end.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when the orientation session is scheduled to begin.',
    `session_capacity` STRING COMMENT 'Maximum number of workers that can attend this orientation session. Used for scheduling and logistics planning.',
    `session_code` STRING COMMENT 'Business identifier for the orientation session, used for external reference and scheduling systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `session_name` STRING COMMENT 'Descriptive name of the orientation session (e.g., New Hire Orientation - Healthcare Division, Client-Site Safety Training).',
    `session_status` STRING COMMENT 'Current lifecycle status of the orientation session. Tracks progression from planning through completion.. Valid values are `scheduled|in-progress|completed|cancelled|postponed|rescheduled`',
    `topics_covered` STRING COMMENT 'Comma-separated or structured list of topics covered in the orientation (e.g., Company Policies, Safety Procedures, Benefits Overview, Timekeeping, Compliance Training).',
    `vendor_name` STRING COMMENT 'Name of external vendor or training provider if orientation is outsourced or conducted by third party.',
    `virtual_meeting_link` STRING COMMENT 'URL or meeting link for virtual orientation sessions (e.g., Zoom, Teams, WebEx). Confidential to prevent unauthorized access.',
    `virtual_meeting_reference` STRING COMMENT 'Meeting ID or access code for virtual orientation platform. Confidential credential.',
    CONSTRAINT pk_orientation_session PRIMARY KEY(`orientation_session_id`)
) COMMENT 'Scheduled or completed orientation session for one or more workers. Tracks orientation type (in-person, virtual, client-site, self-paced), session date, location or virtual link, facilitator, duration, topics covered, and per-worker attendance status. May be staffing-agency-led or client-led. Linked to onboarding_record for milestone completion tracking.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` (
    `lms_enrollment_id` BIGINT COMMENT 'Unique identifier for the LMS enrollment record. Primary key for tracking worker training course enrollments assigned through SAP SuccessFactors LMS during onboarding.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Training assignment accountability. Compliance training assignments must track which staff member assigned the training for audit trails, performance management, and regulatory compliance reporting. S',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement assignment for which this training is required. Links to the placement record to ensure training completion before assignment start.',
    `client_account_id` BIGINT COMMENT 'Identifier of the client account that mandated this training course. Links to the client master record for client-specific training requirements.',
    `lms_course_id` BIGINT COMMENT 'Unique identifier of the training course in the LMS system. System-generated course code from SAP SuccessFactors LMS.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Training enrollments are mandatory onboarding tasks. Linking to the onboarding engagement enables tracking training completion as part of overall onboarding status and supports SLA monitoring for trai',
    `profile_id` BIGINT COMMENT 'Identifier of the worker enrolled in the training course. Links to the worker master record in the placement or candidate domain.',
    `training_record_id` BIGINT COMMENT 'Foreign key linking to credentialing.training_record. Business justification: LMS enrollments during onboarding link to credentialing training records for compliance tracking and credential instance creation. Essential for CEU-bearing courses and mandatory training that generat',
    `assignment_reason` STRING COMMENT 'Business reason for assigning this training course. Examples include onboarding requirement, client mandate, regulatory compliance, skills gap, or policy update.',
    `attempt_number` STRING COMMENT 'Number of times the worker has attempted the training course. Tracks retakes for failed or incomplete attempts.',
    `certificate_expiration_date` DATE COMMENT 'Date when the training certificate expires and the worker must retake the course. Null if the certificate does not expire.',
    `certificate_issued_date` DATE COMMENT 'Date when the training completion certificate was issued to the worker.',
    `certificate_number` STRING COMMENT 'Unique identifier of the certificate issued upon successful completion of the training course. Used for verification and compliance audits.',
    `completion_date` DATE COMMENT 'Date when the worker successfully completed the training course. Null if the course is not yet completed.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the worker completed the training course. Used for compliance reporting and audit trails.',
    `course_version` STRING COMMENT 'Version number or identifier of the course content. Tracks course updates and ensures workers complete the current version.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment record was first created in the system. Used for audit trail and data lineage.',
    `delivery_method` STRING COMMENT 'Method by which the training course was delivered. Options include online e-learning, in-person classroom, blended (combination), virtual classroom (live online), or self-paced modules.. Valid values are `online|in_person|blended|virtual_classroom|self_paced`',
    `due_date` DATE COMMENT 'Target date by which the worker must complete the training course. Critical for ensuring assignment readiness and compliance.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Expected duration of the training course in hours. Used for planning and compliance reporting.',
    `enrollment_date` DATE COMMENT 'Date when the worker was enrolled in the training course. Typically occurs during the onboarding process.',
    `enrollment_status` STRING COMMENT 'Current status of the training enrollment. Tracks the workers progress through the course lifecycle from enrollment to completion or other terminal states. [ENUM-REF-CANDIDATE: enrolled|in_progress|completed|failed|expired|withdrawn|waived — 7 candidates stripped; promote to reference product]',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the enrollment record was created in the LMS system. Used for audit and compliance tracking.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the training course. Applicable for instructor-led training.',
    `is_assignment_blocking` BOOLEAN COMMENT 'Indicates whether incomplete or failed status of this training course blocks the worker from starting their assignment. True if blocking; false otherwise.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training course is mandatory for the worker to start their assignment. True if required; false if optional or recommended.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time when the worker last accessed the training course content. Used to monitor engagement and identify at-risk enrollments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment record was last updated. Tracks changes to status, scores, or other enrollment attributes.',
    `max_attempts_allowed` STRING COMMENT 'Maximum number of attempts permitted for the training course. Null if unlimited attempts are allowed.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the enrollment. Used by onboarding coordinators and compliance staff.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the worker passed or failed the training course. Pending if not yet graded; not applicable for courses without pass/fail criteria.. Valid values are `pass|fail|pending|not_applicable`',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training course, typically expressed as a percentage (0.00 to 100.00).',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the worker on the training course assessment, typically expressed as a percentage (0.00 to 100.00).',
    `start_date` DATE COMMENT 'Date when the worker first accessed or began the training course.',
    `time_spent_hours` DECIMAL(18,2) COMMENT 'Actual time the worker spent on the training course in hours. Tracked by the LMS system for reporting and analytics.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person who approved the training waiver. Typically a compliance manager or client representative.',
    `waiver_date` DATE COMMENT 'Date when the training waiver was approved.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the training requirement was waived for this worker. True if waived; false otherwise.',
    `waiver_reason` STRING COMMENT 'Explanation for why the training requirement was waived. Examples include prior certification, equivalent training, or client approval.',
    CONSTRAINT pk_lms_enrollment PRIMARY KEY(`lms_enrollment_id`)
) COMMENT 'Tracks worker training course enrollments assigned through SAP SuccessFactors LMS during onboarding. Captures course name, course code, course category (safety, compliance, skills, client-specific, OSHA, harassment prevention), enrollment date, due date, completion date, pass/fail status, score, number of attempts, and whether the course is mandatory for assignment start. Bridges onboarding and LMS training compliance requirements.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` (
    `equipment_provisioning_id` BIGINT COMMENT 'Unique identifier for the equipment provisioning request record. Primary key for the equipment provisioning entity.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Equipment approval workflow. Asset provisioning requires management approval tracking for financial controls, budget accountability, and audit compliance. Critical for expense management and SOX compl',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement or assignment for which equipment is being provisioned. Links to the placement record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment provisioning costs (purchase, shipping, setup) are charged to cost centers for budget tracking and potential chargeback to client accounts or internal departments. Enables equipment cost ana',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: When provisioned equipment is capitalized company property (laptops, tools, vehicles), it must be tracked as a fixed asset for depreciation, insurance, disposal, and audit compliance. Critical for ass',
    `offboarding_record_id` BIGINT COMMENT 'Foreign key linking to onboarding.offboarding_record. Business justification: Equipment return is a critical offboarding task. The equipment_provisioning table already tracks return status (return_required_flag, return_due_date, return_received_date). Linking to offboarding_rec',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Equipment provisioning is part of the onboarding workflow. Linking to the onboarding engagement enables tracking equipment readiness as a blocker for assignment start and supports onboarding completio',
    `profile_id` BIGINT COMMENT 'Identifier of the worker (candidate or employee) for whom equipment is being provisioned or returned. Links to the worker master record.',
    `task_assignment_id` BIGINT COMMENT 'Identifier of the parent onboarding task or checklist item that triggered this equipment provisioning request. Links to the onboarding task record.',
    `approved_date` DATE COMMENT 'Date when the equipment provisioning request was approved by the appropriate authority (manager, client, or procurement team).',
    `asset_tag` STRING COMMENT 'Unique asset tag or serial number assigned to the physical equipment item for inventory tracking and asset management purposes. Used to track individual equipment units throughout their lifecycle.',
    `assigned_location` STRING COMMENT 'Physical location or site where the equipment is assigned and will be used by the worker. May be a client site, agency office, or remote/home location.',
    `billable_to_client_flag` BOOLEAN COMMENT 'Indicates whether the equipment cost is billable to the client as part of the placement agreement. True if the cost will be passed through to the client, false if absorbed by the agency.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for provisioning this equipment item. Includes purchase price, rental fees, or allocation cost depending on the provisioning model.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the equipment cost amount. Supports multi-currency operations for international placements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment provisioning record was first created in the system. Used for audit trail and data lineage tracking.',
    `equipment_description` STRING COMMENT 'Detailed description of the specific equipment item being provisioned. Includes make, model, specifications, and any distinguishing characteristics.',
    `equipment_type` STRING COMMENT 'Category of equipment being provisioned. Includes technology assets (laptop, mobile device), access credentials (badge, access card), safety equipment (PPE, safety gear, uniform), tools, vehicles, and other specialized equipment required for the assignment. [ENUM-REF-CANDIDATE: laptop|desktop|mobile_device|tablet|badge|access_card|ppe|uniform|safety_gear|tools|vehicle|other — 12 candidates stripped; promote to reference product]',
    `fulfillment_date` DATE COMMENT 'Date when the equipment was successfully provisioned and delivered to the worker. Marks completion of the provisioning workflow.',
    `provisioning_notes` STRING COMMENT 'Free-text notes documenting special instructions, configuration details, delivery arrangements, or any issues encountered during the provisioning process. Supports operational coordination and troubleshooting.',
    `provisioning_source` STRING COMMENT 'Indicates who is responsible for providing the equipment. Agency-provisioned equipment is owned and managed by the staffing firm, client-provisioned equipment is provided by the client organization, vendor-provisioned equipment comes from third-party suppliers.. Valid values are `agency|client|vendor|third_party`',
    `provisioning_status` STRING COMMENT 'Current status of the equipment provisioning request in the fulfillment workflow. Tracks progression from initial request through approval, preparation, and final delivery to the worker.. Valid values are `requested|approved|in_progress|fulfilled|cancelled|on_hold`',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the equipment procurement, if applicable. Links equipment provisioning to financial procurement records for audit and reconciliation.',
    `request_date` DATE COMMENT 'Date when the equipment provisioning request was initiated. Typically triggered during the onboarding process or when assignment requirements change.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the equipment provisioning request. Format: EPR-YYYYMMDD-sequence. Used for tracking and communication with workers and clients.. Valid values are `^EPR-[0-9]{8}$`',
    `required_by_date` DATE COMMENT 'Target date by which the equipment must be provisioned and ready for the worker. Typically aligned with the assignment start date to ensure workers are fully equipped on day one.',
    `return_condition` STRING COMMENT 'Assessment of the equipment condition upon return. Used to determine if any charges or deductions apply for damage, loss, or excessive wear. Supports asset lifecycle management and replacement planning.. Valid values are `excellent|good|fair|poor|damaged|lost`',
    `return_due_date` DATE COMMENT 'Date by which the equipment must be returned during offboarding or assignment end. Typically aligned with the assignment end date or a grace period thereafter.',
    `return_notes` STRING COMMENT 'Free-text notes documenting the condition, completeness, and any issues identified during equipment return inspection. Supports dispute resolution and asset management decisions.',
    `return_received_date` DATE COMMENT 'Actual date when the equipment was physically returned and received by the agency or client. Used to track compliance with return requirements and close out the equipment lifecycle.',
    `return_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment must be returned at the end of the assignment or during offboarding. True for agency-owned or leased equipment, false for consumables or client-retained items.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment provisioning record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier who provided the equipment, if sourced from a third party. Used for vendor performance tracking and procurement analytics.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty for the equipment expires. Used for maintenance planning and replacement decisions.',
    CONSTRAINT pk_equipment_provisioning PRIMARY KEY(`equipment_provisioning_id`)
) COMMENT 'Tracks equipment and access provisioning requests and fulfillment for workers during onboarding or offboarding. Covers equipment type (laptop, badge, PPE, uniform, mobile device, access card, safety gear), asset tag, provisioning request date, fulfillment date, provisioning status, assigned location, return due date (for offboarding), return received date, and condition at return. Supports both client-provisioned and agency-provisioned equipment workflows.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Primary key for status_event',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement or assignment this onboarding event is associated with. Nullable for general onboarding events not tied to a specific placement.',
    `credential_instance_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential_instance. Business justification: Status events track credential instance expirations, renewals, or verifications that trigger onboarding holds or re-verification workflows. Critical for real-time onboarding status management based on',
    `document_collection_id` BIGINT COMMENT 'Identifier of the document (I-9, tax form, direct deposit form, etc.) that this event references. Nullable for events not related to document collection.',
    `drug_screen_id` BIGINT COMMENT 'Foreign key linking to credentialing.drug_screen. Business justification: Status events track drug screen completion, failure, or recollection requirements that change onboarding status. Essential for real-time workflow management when drug screen results arrive and impact ',
    `bgc_order_id` BIGINT COMMENT 'Identifier of the background check order that this event references. Used for BGC status update events.',
    `task_assignment_id` BIGINT COMMENT 'Identifier of the onboarding task that this event is associated with. Nullable for events not tied to a specific checklist task.',
    `lms_enrollment_id` BIGINT COMMENT 'Identifier of the Learning Management System (LMS) training assignment or course that this event references. Nullable for non-training events.',
    `offboarding_record_id` BIGINT COMMENT 'Foreign key linking to onboarding.offboarding_record. Business justification: Status events track milestones and transitions in both onboarding and offboarding workflows. This links status events to offboarding records and enables audit trail and timeline tracking for offboardi',
    `onboarding_engagement_id` BIGINT COMMENT 'Identifier of the parent onboarding or offboarding case that this event belongs to. Groups all events for a single onboarding lifecycle.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the specific user or system process that triggered this event. Nullable for system-automated events without a specific user context.',
    `profile_id` BIGINT COMMENT 'Identifier of the worker (candidate or employee) undergoing onboarding or offboarding. Links to the worker profile in the candidate or placement domain.',
    `readiness_status_id` BIGINT COMMENT 'Foreign key linking to credentialing.readiness_status. Business justification: Status events reference readiness status changes that trigger onboarding workflow transitions (ready-to-start, compliance hold, credential gap). Critical for event-driven onboarding orchestration base',
    `communication_channel` STRING COMMENT 'The channel through which communication was sent or received for this event. Set to none for status transitions that do not involve direct communication.. Valid values are `email|sms|portal|phone|in_person|none`',
    `communication_direction` STRING COMMENT 'Indicates whether the communication was sent to the worker (outbound), received from the worker (inbound), or not applicable for non-communication events.. Valid values are `outbound|inbound|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this event record was first inserted into the data platform. Represents the system record creation time, distinct from the business event timestamp.',
    `delivery_status` STRING COMMENT 'The delivery and engagement status for outbound communications. Tracks whether emails or SMS messages were successfully delivered and opened by the recipient. [ENUM-REF-CANDIDATE: sent|delivered|opened|clicked|bounced|failed|not_applicable — 7 candidates stripped; promote to reference product]',
    `event_notes` STRING COMMENT 'Free-text notes or comments recorded by the coordinator or system about this event. Provides additional context for manual overrides, exceptions, or worker-specific details.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when this status event or communication occurred in the onboarding lifecycle. Represents the real-world business event time, not the system record creation time.',
    `event_type` STRING COMMENT 'The type of event being recorded in the onboarding timeline. Discriminates between status transitions, outbound communications, inbound worker responses, system notifications, and milestone events. [ENUM-REF-CANDIDATE: status_change|outbound_email|outbound_sms|inbound_response|portal_notification|task_reminder|document_request|welcome_message|orientation_invite|bgc_status_update|offer_letter_delivery|phone_call — 12 candidates stripped; promote to reference product]',
    `external_event_reference` STRING COMMENT 'The unique identifier of this event in the source system (e.g., SAP SuccessFactors event ID, Bullhorn activity ID). Used for reconciliation and troubleshooting.',
    `is_milestone_event` BOOLEAN COMMENT 'Boolean flag indicating whether this event represents a major milestone in the onboarding lifecycle (e.g., orientation complete, ready for assignment, assignment start). Used for high-level timeline visualization.',
    `message_body_preview` STRING COMMENT 'A preview or excerpt of the message body content for outbound or inbound communications. Truncated for storage efficiency; full content stored in document management system.',
    `message_subject` STRING COMMENT 'The subject line or title of the communication sent or received. Applicable for email and portal notifications.',
    `new_status` STRING COMMENT 'The onboarding or offboarding status after this event occurred. Represents the current state following the transition or milestone. [ENUM-REF-CANDIDATE: not_started|documents_pending|bgc_in_progress|orientation_scheduled|training_assigned|equipment_pending|ready_for_assignment|assignment_active|offboarding_initiated|offboarding_complete — 10 candidates stripped; promote to reference product]',
    `prior_status` STRING COMMENT 'The onboarding or offboarding status immediately before this event occurred. Nullable for the first event in a case lifecycle. [ENUM-REF-CANDIDATE: not_started|documents_pending|bgc_in_progress|orientation_scheduled|training_assigned|equipment_pending|ready_for_assignment|assignment_active|offboarding_initiated|offboarding_complete — 10 candidates stripped; promote to reference product]',
    `recipient_email` STRING COMMENT 'The email address to which an outbound communication was sent. Applicable for email-based events.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'The phone number to which an outbound SMS or phone call was directed. Applicable for SMS and phone-based events.',
    `sla_met` BOOLEAN COMMENT 'Boolean flag indicating whether the SLA target was met for this event. True if the event occurred on or before the SLA target timestamp.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'The target date and time by which this onboarding milestone or task should be completed according to the Service Level Agreement (SLA). Used for Time to Fill (TTF) and Time to Start (TTS) measurement.',
    `system_source` STRING COMMENT 'The source system or application that generated or recorded this event. Identifies the operational system of record for traceability and integration auditing. [ENUM-REF-CANDIDATE: bullhorn|sap_successfactors|sterling_bgc|docusign|kronos|internal_portal|api — 7 candidates stripped; promote to reference product]',
    `trigger_source` STRING COMMENT 'The specific action, system event, or integration that caused this status event to be recorded. Provides traceability for automated workflows and manual interventions. [ENUM-REF-CANDIDATE: task_completion|document_signing|bgc_clearance|lms_completion|manual_override|scheduled_reminder|api_integration|portal_submission — 8 candidates stripped; promote to reference product]',
    `triggering_actor_type` STRING COMMENT 'The type of actor (person or system) that triggered or initiated this event. Distinguishes between automated system actions and human-initiated actions.. Valid values are `system|recruiter|coordinator|worker|manager|admin`',
    `worker_response_received` BOOLEAN COMMENT 'Boolean flag indicating whether the worker provided a response or acknowledgment for this event. True for inbound responses or completed actions.',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Immutable event log capturing every status transition, communication, and milestone event in the onboarding or offboarding lifecycle for a worker. Records event type (status_change, outbound_email, outbound_sms, inbound_response, portal_notification, task_reminder, document_request, welcome_message, orientation_invite, bgc_status_update, offer_letter_delivery, phone_call), prior status, new status, transition timestamp, triggering actor (system, recruiter, coordinator, worker), trigger source (task completion, document signing, BGC clearance, LMS completion, manual override), communication channel (email, SMS, portal, phone), delivery status, worker response flag, linked task or document reference, and notes. Consolidates all onboarding timeline events including outbound/inbound communications into a single unified event stream. Provides the single onboarding timeline for audit trail, SLA measurement (TTF, TTS), coordinator engagement tracking, and communication history.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` (
    `onboarding_sla_target_id` BIGINT COMMENT 'Primary key for sla_target',
    `client_account_id` BIGINT COMMENT 'Foreign key reference to the client account when scope_type is client-specific or hybrid. Null for global or non-client-specific SLAs.',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'User ID of the person who created this SLA target record.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: SLA targets vary significantly by job category - healthcare roles may require 3-day credentialing, IT roles may allow 10-day onboarding, emergency placements have accelerated timelines. Operations tea',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: SLA targets for time-to-ready vary by geography and site type (remote vs onsite, union vs non-union). Staffing firms measure and report onboarding performance by client location for operational accoun',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'User ID of the person who last modified this SLA target record.',
    `requirement_rule_id` BIGINT COMMENT 'Foreign key linking to onboarding.requirement_rule. Business justification: SLA targets are defined by requirement rules. This links the SLA target definition to the requirement rule that mandates it, enabling traceability from SLA targets back to regulatory or contractual re',
    `staff_profile_id` BIGINT COMMENT 'User ID of the person who approved this SLA target definition. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Approval workflow status for this SLA target definition: pending (awaiting approval), approved (authorized for use), rejected (not approved).. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA target definition was approved. Null if not yet approved.',
    `auto_escalation_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether automatic escalation notifications are enabled for this SLA target (True = auto-escalate, False = manual escalation only).',
    `breach_threshold_hours` STRING COMMENT 'Number of hours before SLA target deadline when breach warning alerts should be triggered (e.g., 24 hours before target).',
    `business_justification` STRING COMMENT 'Free-text explanation of the business rationale for this SLA target definition, including client requirements, regulatory drivers, or competitive positioning.',
    `compliance_threshold_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of placements that must meet this SLA target to be considered compliant (e.g., 95.00 means 95% of placements must meet the target).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA target record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this SLA target definition expires or is superseded by a new version. Null indicates the SLA is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this SLA target definition becomes active and applicable to new placements.',
    `escalation_level_1_role` STRING COMMENT 'Role or job title to escalate to when SLA breach threshold is reached (e.g., Onboarding Coordinator, Branch Manager, Recruitment Manager).',
    `escalation_level_2_role` STRING COMMENT 'Role or job title for second-level escalation when SLA breach occurs (e.g., Regional Director, VP Operations).',
    `geography_code` STRING COMMENT 'Geographic region, branch, or location code when scope_type is geography-specific or hybrid (e.g., US-CA, BRANCH-NYC, REGION-NORTHEAST). Null for non-geography-specific SLAs.',
    `measurement_frequency` STRING COMMENT 'Frequency at which SLA compliance is measured and reported: real-time (continuous monitoring), daily, weekly, monthly, or quarterly.. Valid values are `real_time|daily|weekly|monthly|quarterly`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA target record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this SLA target definition.',
    `onboarding_sla_target_status` STRING COMMENT 'Current lifecycle status of this SLA target definition: active (in use), inactive (temporarily disabled), draft (under review), superseded (replaced by newer version), archived (historical record).. Valid values are `active|inactive|draft|superseded|archived`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount or service credit applied per SLA breach when penalty_clause_flag is True. Null if no penalties apply.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Boolean flag indicating whether financial penalties or service credits apply for SLA breaches (True = penalties apply, False = no contractual penalties).',
    `penalty_type` STRING COMMENT 'Type of penalty applied for SLA breach: fixed fee (flat dollar amount), service credit (credit toward future invoices), percentage discount (percentage off next invoice), tiered (escalating penalties based on breach severity). Null if no penalties apply.. Valid values are `fixed_fee|service_credit|percentage_discount|tiered`',
    `placement_type` STRING COMMENT 'Type of placement this SLA applies to when scope_type is placement-type-specific or hybrid: temporary (short-term assignment), temp-to-perm (temporary with conversion option), contract-to-hire (contract with hire intent), direct placement (permanent hire), contract (fixed-term project), per diem (daily assignment). Null for non-placement-type-specific SLAs.. Valid values are `temporary|temp_to_perm|contract_to_hire|direct_placement|contract|per_diem`',
    `priority_level` STRING COMMENT 'Business priority level for this SLA target: critical (mission-critical client or role), high (premium service level), standard (default service level), low (non-urgent or backfill).. Valid values are `critical|high|standard|low`',
    `scope_type` STRING COMMENT 'Defines the applicability scope of this SLA target: global (applies to all placements), client-specific (applies to a specific client account), job-category-specific (applies to a job category or skill set), geography-specific (applies to a region or branch), placement-type-specific (applies to temp, temp-to-perm, direct hire, etc.), or hybrid (combination of multiple scope dimensions).. Valid values are `global|client_specific|job_category_specific|geography_specific|placement_type_specific|hybrid`',
    `sla_code` STRING COMMENT 'Short alphanumeric code for the SLA target, used for system integration and reporting (e.g., SLA-TEMP-STD, SLA-HC-RN).',
    `sla_name` STRING COMMENT 'Business-friendly name for this SLA target definition (e.g., Standard Temp Onboarding, Healthcare RN Fast Track, Client-Specific Premium SLA).',
    `target_bgc_completion_days` DECIMAL(18,2) COMMENT 'Target number of days to complete background check (BGC) screening from order submission to final clearance.',
    `target_credentialing_days` DECIMAL(18,2) COMMENT 'Target number of days to complete credentialing verification (licenses, certifications, education verification) for roles requiring professional credentials.',
    `target_document_collection_days` DECIMAL(18,2) COMMENT 'Target number of days to complete document collection tasks (I-9, W-4, direct deposit forms, tax withholding, emergency contacts, etc.).',
    `target_drug_screen_days` DECIMAL(18,2) COMMENT 'Target number of days to complete drug screening from test order to final result.',
    `target_equipment_provisioning_days` DECIMAL(18,2) COMMENT 'Target number of days to provision and deliver required equipment (uniforms, badges, tools, IT equipment, PPE) to the worker.',
    `target_orientation_completion_days` DECIMAL(18,2) COMMENT 'Target number of days to complete worker orientation (company policies, safety training, compliance briefings, benefits enrollment).',
    `target_overall_onboarding_days` DECIMAL(18,2) COMMENT 'Target number of calendar days to complete the entire onboarding process from placement acceptance to assignment-ready status. Used to measure Time to Start (TTS) compliance.',
    `target_training_completion_days` DECIMAL(18,2) COMMENT 'Target number of days to complete required Learning Management System (LMS) training assignments and job-specific skill certifications via SAP SuccessFactors.',
    CONSTRAINT pk_onboarding_sla_target PRIMARY KEY(`onboarding_sla_target_id`)
) COMMENT 'Defines SLA targets for onboarding task and overall onboarding completion by placement type, client, job category, or geography. Captures SLA name, applicable scope (global, client-specific, job-category-specific), target days to complete overall onboarding, target days per task category (document collection, BGC, drug screen, orientation, training), breach escalation rules, and effective date range. Used to measure TTS (Time to Start) compliance.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` (
    `requirement_rule_id` BIGINT COMMENT 'Unique identifier for the onboarding requirement rule configuration. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the specific client account if this rule is client-specific. Null for non-client-specific rules.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: Compliance and onboarding requirements are job-category-driven - nurses require state licensure verification, CDL drivers require MVR checks, financial roles require FINRA checks. Compliance teams con',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Compliance requirements are location-specific: state licensing, local certifications, facility-specific clearances, and site access requirements. Regulatory compliance in staffing depends on work loca',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last modified this requirement rule configuration.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who created this requirement rule configuration.',
    `vendor_compliance_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_compliance. Business justification: Supplier compliance status (insurance limits, certifications, IC classification) determines which onboarding requirements apply to their workers. Link compliance records to requirement rules for autom',
    `vms_enrollment_id` BIGINT COMMENT 'Foreign key linking to vendor.vms_enrollment. Business justification: VMS programs define supplier-specific onboarding requirements (background check depth, drug screen panels, insurance verification, training mandates). Link enrollment to rules that govern onboarding c',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program if this rule is program-specific (e.g., MSP engagement). Null for non-program-specific rules.',
    `auto_hold_trigger_flag` BOOLEAN COMMENT 'Indicates whether SLA breach should automatically place the placement on hold, preventing assignment start until resolved.',
    `blocking_flag` BOOLEAN COMMENT 'Indicates whether failure to meet this requirement blocks assignment start (true) or is tracked but non-blocking (false).',
    `breach_escalation_threshold_hours` STRING COMMENT 'Number of hours before SLA breach when escalation notification should be triggered.',
    `cost_per_occurrence` DECIMAL(18,2) COMMENT 'Standard cost incurred each time this requirement is fulfilled (e.g., BGC vendor fee, drug screen cost, training course fee). Used for onboarding cost forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this requirement rule record was first created in the system.',
    `documentation_required_flag` BOOLEAN COMMENT 'Indicates whether completion of this requirement must be evidenced by uploaded documentation (certificates, forms, test results).',
    `effective_date` DATE COMMENT 'Date when this requirement rule becomes active and enforceable for new placements.',
    `escalation_contact_email` STRING COMMENT 'Primary email address for SLA breach escalation notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_phone` STRING COMMENT 'Primary phone number for urgent SLA breach escalation.',
    `expiration_date` DATE COMMENT 'Date when this requirement rule expires and is no longer applicable. Null for open-ended rules.',
    `geography_code` STRING COMMENT 'ISO country code or US state code (e.g., USA, CA, TX) if this rule is geography-specific. Null for non-geography-specific rules.. Valid values are `^[A-Z]{2,3}$`',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this requirement is mandatory (true) or conditional/optional (false) for the defined scope.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this requirement rule record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or business rationale for this requirement rule configuration.',
    `priority_level` STRING COMMENT 'Business priority level for this requirement, used for task sequencing and resource allocation in onboarding workflows.. Valid values are `critical|high|medium|low`',
    `recurrence_frequency` STRING COMMENT 'How often this requirement must be renewed or repeated during a workers tenure (e.g., one-time for I-9, annual for certain certifications).. Valid values are `one_time|annual|biennial|quarterly|as_needed`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or legal authority mandating this requirement (e.g., OSHA, DOT, State of California, EEOC, Client MSA).',
    `regulatory_citation` STRING COMMENT 'Specific legal citation, regulation number, or contract clause reference (e.g., 29 CFR 1910.134, MSA Section 4.3, CA Labor Code 432.7).',
    `renewal_advance_notice_days` STRING COMMENT 'Number of days before expiration to trigger renewal notification for recurring requirements.',
    `requirement_category` STRING COMMENT 'Category of onboarding requirement mandated by this rule. Determines what type of task or verification must be completed.. Valid values are `i9|bgc_package|drug_screen_panel|certifications|training_courses|orientation_type`',
    `requirement_subcategory` STRING COMMENT 'Detailed subcategory or specific variant within the requirement category (e.g., 5-panel drug screen, OSHA 10-hour, forklift certification).',
    `rule_code` STRING COMMENT 'Business-readable unique code identifying this requirement rule configuration (e.g., CLIENT_ABC_I9, DOT_DRUG_SCREEN, OSHA_PPE_MFG).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_name` STRING COMMENT 'Human-readable name describing the requirement rule (e.g., Client ABC I-9 Verification, DOT Drug Screen Panel 5, OSHA PPE for Manufacturing).',
    `rule_status` STRING COMMENT 'Current lifecycle status of this requirement rule configuration.. Valid values are `active|inactive|draft|suspended|archived`',
    `scope_type` STRING COMMENT 'Defines the applicability scope of this requirement rule: global (all placements), client-specific, job-category-specific, geography-specific, or program-specific.. Valid values are `global|client_specific|job_category_specific|geography_specific|program_specific`',
    `sla_measurement_method` STRING COMMENT 'Unit of time measurement for SLA tracking: calendar days (includes weekends/holidays), business days (excludes weekends/holidays), or hours.. Valid values are `calendar_days|business_days|hours`',
    `target_days_bgc` STRING COMMENT 'Target number of days to complete background check (BGC) process from order to clearance.',
    `target_days_credentialing` STRING COMMENT 'Target number of days to complete credentialing verification (licenses, certifications, education verification).',
    `target_days_document_collection` STRING COMMENT 'Target number of days to complete document collection tasks (I-9, tax forms, direct deposit forms).',
    `target_days_drug_screen` STRING COMMENT 'Target number of days to complete drug screening from order to result clearance.',
    `target_days_orientation` STRING COMMENT 'Target number of days to complete orientation session attendance and assessment.',
    `target_days_overall` STRING COMMENT 'Target number of calendar days to complete the entire onboarding process from placement acceptance to assignment start. Drives TTS (Time to Start) SLA measurement.',
    `target_days_training` STRING COMMENT 'Target number of days to complete required training courses via LMS (Learning Management System).',
    `trigger_condition` STRING COMMENT 'Business rule or condition that triggers this requirement (e.g., client_specific, state_law_CA, OSHA_manufacturing, DOT_regulated, MSA_clause_3.2).',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor or service provider used to fulfill this requirement (e.g., Sterling Background Check, LabCorp, SAP SuccessFactors LMS).',
    `waiver_allowed_flag` BOOLEAN COMMENT 'Indicates whether this requirement can be waived under exceptional circumstances with proper approval.',
    `waiver_approval_role` STRING COMMENT 'Role or title authorized to approve waivers for this requirement (e.g., Regional Compliance Manager, VP Operations, Client Account Director).',
    CONSTRAINT pk_requirement_rule PRIMARY KEY(`requirement_rule_id`)
) COMMENT 'Defines the specific onboarding requirements and SLA targets mandated for a given client, job category, work location, or regulatory jurisdiction. Captures requirement category (i9, bgc_package, drug_screen_panel, certifications, training_courses, orientation_type, ppe, sla_timing), whether it is mandatory or conditional, the triggering condition (e.g., client-specific, state law, OSHA, DOT), target days to complete overall onboarding, target days per task category (document collection, BGC, drug screen, orientation, training), breach escalation rules (escalation contacts, escalation timing, auto-hold triggers), SLA scope (global, client-specific, job-category-specific, geography-specific), effective date, and expiration date. Drives dynamic task_checklist generation, SLA compliance measurement, and TTS (Time to Start) reporting for each onboarding engagement. Consolidates both what must be done and how fast it must be done into a single configuration entity.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` (
    `communication_log_id` BIGINT COMMENT 'Primary key for communication_log',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement assignment associated with this onboarding communication.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Onboarding communications involve client hiring managers, site supervisors, and HR contacts. Tracking which client contact was communicated with is essential for relationship management and escalation',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user who last modified the communication record.',
    `offboarding_record_id` BIGINT COMMENT 'Foreign key linking to onboarding.offboarding_record. Business justification: Communications occur during offboarding as well as onboarding (exit interview scheduling, equipment return reminders, COBRA notifications). This links communications to the offboarding workflow they s',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Communications are part of the onboarding workflow and should link directly to the onboarding engagement they support. This enables tracking all communications related to a specific onboarding case. C',
    `profile_id` BIGINT COMMENT 'Identifier of the worker to whom or from whom the communication was sent or received during onboarding.',
    `sourcing_campaign_id` BIGINT COMMENT 'Identifier of the onboarding communication campaign or batch to which this message belongs.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the user who created the communication record.',
    `task_assignment_id` BIGINT COMMENT 'Identifier of the specific onboarding task that triggered or is related to this communication.',
    `vendor_document_id` BIGINT COMMENT 'Identifier of the document attached to or referenced in the communication, such as an offer letter, I-9 form, or orientation materials.',
    `attachment_count` STRING COMMENT 'Number of file attachments included with the communication.',
    `automated_flag` BOOLEAN COMMENT 'Indicates whether the communication was sent automatically by the system or manually by a user. True if automated; False if manual.',
    `communication_channel` STRING COMMENT 'Channel through which the communication was delivered. Examples include email, SMS, portal notification, phone call, or physical mail.. Valid values are `email|sms|portal_notification|phone|mail`',
    `communication_type` STRING COMMENT 'Type of communication sent or received. Examples include welcome message, task reminder, document request, background check (BGC) status update, orientation invite, or offer letter delivery.. Valid values are `welcome_message|task_reminder|document_request|bgc_status_update|orientation_invite|offer_letter_delivery`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the communication record was first created in the system.',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was successfully delivered to the recipients inbox, device, or portal.',
    `delivery_status` STRING COMMENT 'Current delivery status of the communication. Indicates whether the message was sent, delivered, opened, failed, bounced, or is pending.. Valid values are `sent|delivered|opened|failed|bounced|pending`',
    `direction` STRING COMMENT 'Direction of the communication flow. Outbound indicates communication sent to the worker; inbound indicates communication received from the worker.. Valid values are `outbound|inbound`',
    `failure_reason` STRING COMMENT 'Reason for communication delivery failure if the delivery status is failed or bounced. Examples include invalid email address, phone number unreachable, or mailbox full.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the communication was sent. Examples include EN for English, ES for Spanish.. Valid values are `^[A-Z]{2}$`',
    `last_retry_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent retry attempt to deliver the communication.',
    `message_body` STRING COMMENT 'Full text content of the communication message sent or received.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the communication record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes or comments related to the communication, such as special instructions or context.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the worker opened or viewed the communication message.',
    `priority` STRING COMMENT 'Priority level assigned to the communication. Indicates urgency of the message.. Valid values are `low|normal|high|urgent`',
    `recipient_email` STRING COMMENT 'Email address of the worker recipient to whom the communication was sent.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number of the worker recipient to whom the communication was sent.',
    `response_content` STRING COMMENT 'Text content of the workers response to the communication.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the worker responded to the communication.',
    `retry_count` STRING COMMENT 'Number of times the system attempted to resend the communication after initial delivery failure.',
    `sender_email` STRING COMMENT 'Email address of the sender who initiated the communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Name of the person or system that sent the communication.',
    `sender_phone` STRING COMMENT 'Phone number of the sender who initiated the communication.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was sent to the worker or external system.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the communication response or action breached the defined SLA. True if breached; False otherwise.',
    `sla_due_timestamp` TIMESTAMP COMMENT 'Date and time by which a response or action is expected per the Service Level Agreement (SLA) for onboarding communications.',
    `subject` STRING COMMENT 'Subject line or title of the communication message.',
    `tracking_code` STRING COMMENT 'Unique tracking code or identifier used to monitor the communication delivery and engagement metrics.',
    `worker_response_flag` BOOLEAN COMMENT 'Indicates whether the worker responded to the communication. True if a response was received; False otherwise.',
    CONSTRAINT pk_communication_log PRIMARY KEY(`communication_log_id`)
) COMMENT 'Records all outbound and inbound communications sent to or received from workers during the onboarding process. Captures communication channel (email, SMS, portal notification, phone), communication type (welcome message, task reminder, document request, BGC status update, orientation invite, offer letter delivery), sent timestamp, delivery status, worker response flag, and linked task or document. Supports onboarding engagement tracking and SLA breach prevention.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` (
    `orientation_attendance_id` BIGINT COMMENT 'Unique identifier for this attendance record. Primary key.',
    `orientation_session_id` BIGINT COMMENT 'Foreign key to orientation_session. Identifies which session was attended.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to the internal staff member who attended the orientation',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the staff member on the orientation assessment for this session, if assessment_required is true. Expressed as a percentage (0.00 to 100.00).',
    `attendance_status` STRING COMMENT 'Current status of the staff members attendance for this specific orientation session. Tracks progression from registration through actual attendance or absence.',
    `attendance_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the staff members attendance was recorded or verified for this orientation session. Used for compliance tracking and audit purposes.',
    `certificate_issued` BOOLEAN COMMENT 'Indicates whether a completion certificate was issued to the staff member for this orientation session. Used for compliance documentation and training records.',
    `certificate_issued_date` DATE COMMENT 'Date when the completion certificate was issued to the staff member for this orientation session.',
    `completion_status` STRING COMMENT 'Status indicating whether the staff member successfully completed all requirements for this orientation session, including any assessments or activities.',
    `notes` STRING COMMENT 'Free-text notes about this specific attendance record, such as reasons for absence, special accommodations provided, or follow-up actions required.',
    `registration_date` DATE COMMENT 'Date when the staff member was registered for this orientation session. Used for capacity planning and scheduling.',
    CONSTRAINT pk_orientation_attendance PRIMARY KEY(`orientation_attendance_id`)
) COMMENT 'This association product represents the attendance event between orientation_session and staff_profile. It captures the participation of internal staff members in orientation sessions, tracking their attendance status, completion, and assessment performance. Each record links one orientation_session to one staff_profile with attributes that exist only in the context of this specific attendance relationship.. Existence Justification: In staffing and recruitment operations, orientation sessions are group training events where multiple internal staff members (recruiters, account managers, operations staff) attend, and each staff member participates in multiple orientation sessions over their employment lifecycle (initial onboarding, compliance refreshers, new client-specific orientations, role-change orientations). The business actively manages attendance records as operational entities, tracking registration, attendance status, completion, assessment scores, and certificate issuance for each staff-member-session combination.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` (
    `lms_course_id` BIGINT COMMENT 'Primary key for lms_course',
    `prerequisite_lms_course_id` BIGINT COMMENT 'Self-referencing FK on lms_course (prerequisite_lms_course_id)',
    `accreditation_body` STRING COMMENT 'Name of the professional or regulatory body that has accredited or approved the course for continuing education credits or certification.',
    `accreditation_number` STRING COMMENT 'The unique accreditation or approval number assigned by the accrediting body. Used for verification and compliance documentation.',
    `compliance_framework` STRING COMMENT 'The regulatory or industry compliance framework that this course satisfies (e.g., OSHA, HIPAA, SOX, GDPR). Used for compliance reporting and audit trails.',
    `content_format` STRING COMMENT 'The technical format or standard used to package and deliver the course content. Determines compatibility with the LMS platform.',
    `content_url` STRING COMMENT 'The web address or file path where the course content is hosted or accessed. Used by the LMS to launch the course.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'The cost charged per learner for course enrollment or completion. Used for training budget tracking and cost allocation.',
    `course_category` STRING COMMENT 'Broad subject area or domain to which the course belongs (e.g., Human Resources, Information Technology, Healthcare, Manufacturing). Used for course organization and filtering.',
    `course_code` STRING COMMENT 'Unique alphanumeric code assigned to the course for identification and cataloging purposes. Used as the business identifier for the course.',
    `course_description` STRING COMMENT 'Detailed description of the course content, objectives, and learning outcomes. Provides learners with an overview of what the course covers.',
    `course_title` STRING COMMENT 'The official name or title of the LMS course as displayed to learners and administrators.',
    `course_type` STRING COMMENT 'Classification of the course based on its purpose and content area. Distinguishes between compliance training, skills development, new hire orientation, safety training, professional development, and certification programs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was first created in the LMS. Used for audit trail and data lineage.',
    `credit_hours` DECIMAL(18,2) COMMENT 'The number of continuing education or professional development credit hours awarded upon successful course completion. May be required for professional certifications or licenses.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which course costs are denominated.',
    `delivery_method` STRING COMMENT 'The instructional delivery format for the course. Indicates how the training content is presented to learners.',
    `difficulty_level` STRING COMMENT 'The complexity or skill level required for the course. Helps learners and administrators match courses to appropriate skill levels.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The estimated time in hours required to complete the course. Used for scheduling and compliance tracking.',
    `effective_end_date` DATE COMMENT 'The date on which the course is no longer available for new assignments or enrollments. Null indicates no end date.',
    `effective_start_date` DATE COMMENT 'The date on which the course becomes available for assignment and enrollment. Courses cannot be assigned before this date.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or subject matter expert responsible for delivering or facilitating the course. Null for self-paced courses.',
    `is_certification_required` BOOLEAN COMMENT 'Indicates whether successful completion of the course results in a formal certification or credential. True if certification is awarded, false otherwise.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the course is required for specific roles, assignments, or compliance purposes. True if mandatory, false if optional.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 code representing the primary language in which the course content is delivered.',
    `last_reviewed_date` DATE COMMENT 'The date on which the course content was last reviewed for accuracy, relevance, and compliance. Used for content governance and quality assurance.',
    `learning_objectives` STRING COMMENT 'Detailed list of specific learning outcomes and competencies that learners will achieve upon successful course completion.',
    `max_attempts_allowed` STRING COMMENT 'The maximum number of times a learner is permitted to attempt the course or its assessments before requiring administrative intervention.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified the course record. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was last updated or modified. Used for change tracking and audit purposes.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next content review or update. Used to ensure course content remains current and compliant.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'The minimum score percentage required to successfully complete the course. Used for assessment and compliance tracking.',
    `prerequisites` STRING COMMENT 'Description of any prerequisite courses, skills, or qualifications required before a learner can enroll in this course.',
    `lms_course_status` STRING COMMENT 'Current lifecycle status of the course. Indicates whether the course is available for assignment, being developed, or no longer in use.',
    `target_audience` STRING COMMENT 'Description of the intended learner population for the course, including roles, departments, or skill levels for which the course is designed.',
    `thumbnail_url` STRING COMMENT 'The web address of the course thumbnail or preview image displayed in the course catalog.',
    `validity_period_days` STRING COMMENT 'The number of days for which the course completion or certification remains valid before recertification or renewal is required. Null indicates no expiration.',
    `vendor_course_code` STRING COMMENT 'The unique identifier assigned to the course by the external vendor or content provider. Used for integration and reconciliation with vendor systems.',
    `vendor_name` STRING COMMENT 'Name of the external training provider or content vendor that developed or supplies the course content. Null if developed internally.',
    `version_number` STRING COMMENT 'The version identifier for the course content. Tracks course updates and revisions over time.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created the course record. Used for accountability and audit trail.',
    CONSTRAINT pk_lms_course PRIMARY KEY(`lms_course_id`)
) COMMENT 'Master reference table for lms_course. Referenced by course_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_onboarding_sla_target_id` FOREIGN KEY (`onboarding_sla_target_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target`(`onboarding_sla_target_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ADD CONSTRAINT `fk_onboarding_onboarding_engagement_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ADD CONSTRAINT `fk_onboarding_offboarding_record_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ADD CONSTRAINT `fk_onboarding_task_checklist_requirement_rule_id` FOREIGN KEY (`requirement_rule_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`requirement_rule`(`requirement_rule_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_dependency_task_task_assignment_id` FOREIGN KEY (`dependency_task_task_assignment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_assignment`(`task_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_direct_deposit_setup_id` FOREIGN KEY (`direct_deposit_setup_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup`(`direct_deposit_setup_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_document_collection_id` FOREIGN KEY (`document_collection_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`document_collection`(`document_collection_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_lms_enrollment_id` FOREIGN KEY (`lms_enrollment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`lms_enrollment`(`lms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_orientation_session_id` FOREIGN KEY (`orientation_session_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`orientation_session`(`orientation_session_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ADD CONSTRAINT `fk_onboarding_task_assignment_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ADD CONSTRAINT `fk_onboarding_tax_form_submission_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ADD CONSTRAINT `fk_onboarding_tax_form_submission_supersedes_submission_tax_form_submission_id` FOREIGN KEY (`supersedes_submission_tax_form_submission_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`tax_form_submission`(`tax_form_submission_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ADD CONSTRAINT `fk_onboarding_tax_form_submission_task_assignment_id` FOREIGN KEY (`task_assignment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_assignment`(`task_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ADD CONSTRAINT `fk_onboarding_direct_deposit_setup_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ADD CONSTRAINT `fk_onboarding_document_collection_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ADD CONSTRAINT `fk_onboarding_orientation_session_lms_course_id` FOREIGN KEY (`lms_course_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`lms_course`(`lms_course_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_lms_course_id` FOREIGN KEY (`lms_course_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`lms_course`(`lms_course_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ADD CONSTRAINT `fk_onboarding_lms_enrollment_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ADD CONSTRAINT `fk_onboarding_equipment_provisioning_task_assignment_id` FOREIGN KEY (`task_assignment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_assignment`(`task_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_document_collection_id` FOREIGN KEY (`document_collection_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`document_collection`(`document_collection_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_task_assignment_id` FOREIGN KEY (`task_assignment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_assignment`(`task_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_lms_enrollment_id` FOREIGN KEY (`lms_enrollment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`lms_enrollment`(`lms_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ADD CONSTRAINT `fk_onboarding_status_event_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ADD CONSTRAINT `fk_onboarding_onboarding_sla_target_requirement_rule_id` FOREIGN KEY (`requirement_rule_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`requirement_rule`(`requirement_rule_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_offboarding_record_id` FOREIGN KEY (`offboarding_record_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`offboarding_record`(`offboarding_record_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_onboarding_engagement_id` FOREIGN KEY (`onboarding_engagement_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`onboarding_engagement`(`onboarding_engagement_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ADD CONSTRAINT `fk_onboarding_communication_log_task_assignment_id` FOREIGN KEY (`task_assignment_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`task_assignment`(`task_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ADD CONSTRAINT `fk_onboarding_orientation_attendance_orientation_session_id` FOREIGN KEY (`orientation_session_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`orientation_session`(`orientation_session_id`);
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` ADD CONSTRAINT `fk_onboarding_lms_course_prerequisite_lms_course_id` FOREIGN KEY (`prerequisite_lms_course_id`) REFERENCES `staffing_hr_ecm`.`onboarding`.`lms_course`(`lms_course_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`onboarding` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `staffing_hr_ecm`.`onboarding` SET TAGS ('dbx_domain' = 'onboarding');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` SET TAGS ('dbx_subdomain' = 'worker_lifecycle');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_sla_target_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Sla Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Req Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `sow_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Coordinator ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Submittal Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `actual_onboarding_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Onboarding Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `actual_ready_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ready Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `completed_tasks_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Tasks Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `direct_deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `direct_deposit_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_verification|verified|active|failed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|seasonal|contract|per_diem');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `equipment_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Provisioning Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_number` SET TAGS ('dbx_value_regex' = '^ONB-[0-9]{8}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_priority` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Priority');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Start Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'temp|perm|contract_to_hire|temp_to_perm|redeployment|direct_hire');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `orientation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completion Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `orientation_status` SET TAGS ('dbx_business_glossary_term' = 'Orientation Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `orientation_status` SET TAGS ('dbx_value_regex' = 'not_started|scheduled|in_progress|completed|waived');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `overdue_tasks_count` SET TAGS ('dbx_business_glossary_term' = 'Overdue Tasks Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `pending_tasks_count` SET TAGS ('dbx_business_glossary_term' = 'Pending Tasks Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `target_ready_date` SET TAGS ('dbx_business_glossary_term' = 'Target Ready Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `tax_forms_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Forms Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `tax_forms_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|w4_completed|state_completed|all_completed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `total_tasks_count` SET TAGS ('dbx_business_glossary_term' = 'Total Tasks Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'not_required|assigned|in_progress|completed|overdue|waived');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_engagement` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2_employee|1099_contractor|eor|peo');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` SET TAGS ('dbx_subdomain' = 'worker_lifecycle');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Record ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `last_modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `non_compete_id` SET TAGS ('dbx_business_glossary_term' = 'Non Compete Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Coordinator ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `benefits_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Benefits Termination Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `client_feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback Rating');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `client_feedback_received` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback Received');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `cobra_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Notification Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `cobra_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Notification Required');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `conversion_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `conversion_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `conversion_to_perm_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion to Permanent Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `equipment_return_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `equipment_return_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Required');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|partial|completed|overdue|lost');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|completed|declined|waived');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason Category');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_value_regex' = 'compensation|career_growth|work_environment|personal|relocation|performance');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `exit_reason_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `final_payroll_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payroll Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `final_timesheet_status` SET TAGS ('dbx_business_glossary_term' = 'Final Timesheet Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `final_timesheet_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|paid');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `last_day_worked` SET TAGS ('dbx_business_glossary_term' = 'Last Day Worked');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_checklist_completion_pct` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Checklist Completion Percentage');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Completed Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Initiated By');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_initiated_by` SET TAGS ('dbx_value_regex' = 'worker|client|staffing_company|mutual');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|pending_approval|completed|cancelled|on_hold');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `offboarding_type` SET TAGS ('dbx_value_regex' = 'assignment_end|voluntary_resignation|client_termination|conversion_to_perm|redeployment|involuntary_termination');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `pto_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Payout Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `pto_payout_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `pto_payout_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `pto_payout_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Payout Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `pto_payout_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `redeployment_flag` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|not_eligible|conditional|under_review');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `rehire_eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `rehire_eligibility_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `separation_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `system_access_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'System Access Revocation Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `system_access_revoked` SET TAGS ('dbx_business_glossary_term' = 'System Access Revoked');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`offboarding_record` ALTER COLUMN `unemployment_claim_filed` SET TAGS ('dbx_business_glossary_term' = 'Unemployment Claim Filed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` SET TAGS ('dbx_subdomain' = 'process_configuration');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requirement_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Requirement Rule ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_value_regex' = 'onboarding|offboarding|redeployment|extension');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `client_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Client-Specific Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `compliance_driven_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance-Driven Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `estimated_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Checklist Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|temp_to_perm|contract_to_hire|direct_placement|independent_contractor');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_bgc_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Background Check (BGC) Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_credentialing_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Credentialing Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_drug_screen_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Drug Screen Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_equipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Equipment Provisioning Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_everify_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires E-Verify Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_i9_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires I-9 (Employment Eligibility Verification) Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_lms_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Learning Management System (LMS) Training Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `requires_orientation_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Orientation Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `task_checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Checklist Description');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `task_count` SET TAGS ('dbx_business_glossary_term' = 'Task Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_checklist` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` SET TAGS ('dbx_subdomain' = 'process_configuration');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Task Assignment Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `bgc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Bgc Order Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `credential_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Instance Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `dependency_task_task_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Task Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `direct_deposit_setup_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit Setup Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `document_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Document Collection Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `drug_screen_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'First Shift Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `license_verification_id` SET TAGS ('dbx_business_glossary_term' = 'License Verification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `lms_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Lms Enrollment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `offboarding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Record Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `orientation_session_id` SET TAGS ('dbx_business_glossary_term' = 'Orientation Session Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `skills_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Skills Assessment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `tertiary_task_waived_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waived By User Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `access_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `access_revoked_date` SET TAGS ('dbx_business_glossary_term' = 'Access Revoked Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Task Due Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `equipment_item_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Item Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `external_task_reference` SET TAGS ('dbx_business_glossary_term' = 'External Task Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `is_blocking` SET TAGS ('dbx_business_glossary_term' = 'Is Blocking Task Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Task Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `system_access_type` SET TAGS ('dbx_business_glossary_term' = 'System Access Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `task_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Task Subcategory');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `training_completion_score` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Score');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `waived_date` SET TAGS ('dbx_business_glossary_term' = 'Waived Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`task_assignment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` SET TAGS ('dbx_subdomain' = 'compliance_documentation');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tax_form_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Submission ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `supersedes_submission_tax_form_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Submission ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `task_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `backup_withholding_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Indicator');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `business_name` SET TAGS ('dbx_business_glossary_term' = 'Business Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductions Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `dependents_amount` SET TAGS ('dbx_business_glossary_term' = 'Dependents Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Withholding Effective Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `exempt_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Exempt Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `exempt_status` SET TAGS ('dbx_value_regex' = 'Not Exempt|Exempt - Federal|Exempt - State|Exempt - Both');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `extra_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Extra Withholding Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'Single|Married Filing Jointly|Married Filing Separately|Head of Household|Qualifying Widow(er)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `form_type` SET TAGS ('dbx_value_regex' = 'W-4|State W-4|W-9|1099 Setup|Local Tax Form|Other');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `form_version` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Version');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `local_exemptions` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Exemptions');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `local_tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `multiple_jobs_indicator` SET TAGS ('dbx_business_glossary_term' = 'Multiple Jobs Indicator');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `other_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Income Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `payroll_system_sync_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll System Synchronization Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `payroll_system_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll System Synchronization Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `payroll_system_sync_status` SET TAGS ('dbx_value_regex' = 'Not Synced|Synced|Sync Failed|Pending Sync');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Worker Signature Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'Electronic Signature|Wet Signature|Digital Certificate|Not Signed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `state_allowances` SET TAGS ('dbx_business_glossary_term' = 'State Withholding Allowances');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `state_extra_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'State Extra Withholding Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `state_filing_status` SET TAGS ('dbx_business_glossary_term' = 'State Tax Filing Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Form Submission Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Form Submission Method');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Electronic - Self Service|Electronic - HR Portal|Paper - Scanned|Paper - Manual Entry|DocuSign|Other');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Classification');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_type` SET TAGS ('dbx_business_glossary_term' = 'Taxpayer Identification Number (TIN) Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_type` SET TAGS ('dbx_value_regex' = 'SSN|EIN|ITIN');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_value` SET TAGS ('dbx_business_glossary_term' = 'Taxpayer Identification Number (TIN) Value');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `tin_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Form Verification Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Pending Verification|Verified - Complete|Verified - Incomplete|TIN Mismatch|Rejected|Expired');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By User');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`tax_form_submission` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` SET TAGS ('dbx_subdomain' = 'compliance_documentation');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `direct_deposit_setup_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit Setup ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Account Number Last Four Digits');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|prepaid_card');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `ach_return_code` SET TAGS ('dbx_business_glossary_term' = 'ACH Return Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Deposit Allocation Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full_amount|fixed_amount|percentage');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `allocation_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Value');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Worker Consent Obtained Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `is_primary_account` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Account Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Setup Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `prenote_cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Prenote Cleared Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `prenote_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Prenote Sent Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Deposit Priority Sequence');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `setup_method` SET TAGS ('dbx_business_glossary_term' = 'Setup Method');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `setup_method` SET TAGS ('dbx_value_regex' = 'worker_self_service|hr_manual_entry|bulk_import|api_integration');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`direct_deposit_setup` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Account Verification Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` SET TAGS ('dbx_subdomain' = 'compliance_documentation');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `document_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Document Collection Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `credential_document_id` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Document Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `envelope_id` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `ic_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `offboarding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `additional_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Additional Withholding Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `additional_withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `allowances_claimed` SET TAGS ('dbx_business_glossary_term' = 'Allowances Claimed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `allowances_claimed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'msa_acknowledgment|nda|non_compete|handbook_acknowledgment|safety_policy|drug_screen_consent');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Exempt Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `exempt_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'single|married_filing_jointly|married_filing_separately|head_of_household|qualifying_widow');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `filing_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `form_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Form Submission Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `is_electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Is Electronic Signature');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `onboarding_phase` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Phase');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `onboarding_phase` SET TAGS ('dbx_value_regex' = 'pre_hire|post_offer|first_day|orientation|assignment_start|offboarding');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `sent_date` SET TAGS ('dbx_business_glossary_term' = 'Sent Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `signer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Signer IP Address');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `signer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `signer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'docusign_clm|sap_successfactors|tempworks_payroll|manual_upload|bullhorn_ats');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `supersedes_prior_flag` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Prior Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`document_collection` ALTER COLUMN `viewed_date` SET TAGS ('dbx_business_glossary_term' = 'Viewed Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` SET TAGS ('dbx_subdomain' = 'training_enablement');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `orientation_session_id` SET TAGS ('dbx_business_glossary_term' = 'Orientation Session ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `lms_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `attended_count` SET TAGS ('dbx_business_glossary_term' = 'Attended Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `average_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Average Satisfaction Score');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `completed_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'safety|regulatory|client-specific|general|industry-specific|mandatory');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `cost_per_attendee` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Attendee');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `cost_per_attendee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Email');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_phone` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Phone');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `facilitator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `feedback_survey_sent` SET TAGS ('dbx_business_glossary_term' = 'Feedback Survey Sent');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `interpreter_provided` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Provided');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'office|client-site|training-center|virtual|remote|field');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Materials Provided');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `orientation_type` SET TAGS ('dbx_business_glossary_term' = 'Orientation Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `orientation_type` SET TAGS ('dbx_value_regex' = 'in-person|virtual|client-site|self-paced|hybrid|on-demand');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `physical_location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `recording_available` SET TAGS ('dbx_business_glossary_term' = 'Recording Available');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `recording_url` SET TAGS ('dbx_business_glossary_term' = 'Recording URL');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `recording_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `registered_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `session_capacity` SET TAGS ('dbx_business_glossary_term' = 'Session Capacity');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `session_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `session_name` SET TAGS ('dbx_business_glossary_term' = 'Session Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|cancelled|postponed|rescheduled');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Topics Covered');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `virtual_meeting_link` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting Link');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `virtual_meeting_link` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `virtual_meeting_reference` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_session` ALTER COLUMN `virtual_meeting_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` SET TAGS ('dbx_subdomain' = 'training_enablement');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `lms_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Enrollment ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `lms_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `course_version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'online|in_person|blended|virtual_classroom|self_paced');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `is_assignment_blocking` SET TAGS ('dbx_business_glossary_term' = 'Is Assignment Blocking');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_applicable');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `time_spent_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Spent Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` SET TAGS ('dbx_subdomain' = 'training_enablement');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `equipment_provisioning_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Provisioning ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `offboarding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `task_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `assigned_location` SET TAGS ('dbx_business_glossary_term' = 'Assigned Location');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `billable_to_client_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable to Client Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Equipment Cost Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Description');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `provisioning_notes` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `provisioning_source` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Source');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `provisioning_source` SET TAGS ('dbx_value_regex' = 'agency|client|vendor|third_party');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_value_regex' = 'requested|approved|in_progress|fulfilled|cancelled|on_hold');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Request Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Provisioning Request Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^EPR-[0-9]{8}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Return Condition');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `return_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged|lost');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `return_due_date` SET TAGS ('dbx_business_glossary_term' = 'Return Due Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `return_notes` SET TAGS ('dbx_business_glossary_term' = 'Return Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `return_received_date` SET TAGS ('dbx_business_glossary_term' = 'Return Received Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `return_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Required Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`equipment_provisioning` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` SET TAGS ('dbx_subdomain' = 'worker_lifecycle');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Status Event Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `credential_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Instance Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `document_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Document ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `drug_screen_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `bgc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Background Check (BGC) Order ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `task_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Task ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `lms_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Training ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `offboarding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Actor ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `readiness_status_id` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal|phone|in_person|none');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `communication_direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `communication_direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound|none');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `external_event_reference` SET TAGS ('dbx_business_glossary_term' = 'External Event ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `is_milestone_event` SET TAGS ('dbx_business_glossary_term' = 'Milestone Event Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `message_body_preview` SET TAGS ('dbx_business_glossary_term' = 'Message Body Preview');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `message_subject` SET TAGS ('dbx_business_glossary_term' = 'Message Subject');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Trigger Source');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `triggering_actor_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Actor Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `triggering_actor_type` SET TAGS ('dbx_value_regex' = 'system|recruiter|coordinator|worker|manager|admin');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`status_event` ALTER COLUMN `worker_response_received` SET TAGS ('dbx_business_glossary_term' = 'Worker Response Received Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` SET TAGS ('dbx_subdomain' = 'process_configuration');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `onboarding_sla_target_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Target Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `requirement_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Requirement Rule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `auto_escalation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Escalation Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `breach_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `compliance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Percentage');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `escalation_level_1_role` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level 1 Role');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `escalation_level_2_role` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level 2 Role');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `onboarding_sla_target_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `onboarding_sla_target_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|superseded|archived');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'fixed_fee|service_credit|percentage_discount|tiered');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'temporary|temp_to_perm|contract_to_hire|direct_placement|contract|per_diem');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|standard|low');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Scope Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'global|client_specific|job_category_specific|geography_specific|placement_type_specific|hybrid');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_bgc_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Target Background Check (BGC) Completion Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_credentialing_days` SET TAGS ('dbx_business_glossary_term' = 'Target Credentialing Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_document_collection_days` SET TAGS ('dbx_business_glossary_term' = 'Target Document Collection Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_drug_screen_days` SET TAGS ('dbx_business_glossary_term' = 'Target Drug Screen Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_equipment_provisioning_days` SET TAGS ('dbx_business_glossary_term' = 'Target Equipment Provisioning Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_orientation_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Target Orientation Completion Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_overall_onboarding_days` SET TAGS ('dbx_business_glossary_term' = 'Target Overall Onboarding Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`onboarding_sla_target` ALTER COLUMN `target_training_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Target Training Completion Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` SET TAGS ('dbx_subdomain' = 'process_configuration');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `requirement_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Requirement Rule Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `vendor_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Compliance Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `vms_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Enrollment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `auto_hold_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Hold Trigger Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `blocking_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `breach_escalation_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Escalation Threshold Hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `cost_per_occurrence` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occurrence');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `documentation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'one_time|annual|biennial|quarterly|as_needed');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `renewal_advance_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Advance Notice Days');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `requirement_category` SET TAGS ('dbx_business_glossary_term' = 'Requirement Category');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `requirement_category` SET TAGS ('dbx_value_regex' = 'i9|bgc_package|drug_screen_panel|certifications|training_courses|orientation_type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `requirement_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Requirement Subcategory');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|archived');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Scope Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'global|client_specific|job_category_specific|geography_specific|program_specific');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `sla_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Measurement Method');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `sla_measurement_method` SET TAGS ('dbx_value_regex' = 'calendar_days|business_days|hours');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_bgc` SET TAGS ('dbx_business_glossary_term' = 'Target Days Background Check (BGC)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_credentialing` SET TAGS ('dbx_business_glossary_term' = 'Target Days Credentialing');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_document_collection` SET TAGS ('dbx_business_glossary_term' = 'Target Days Document Collection');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_drug_screen` SET TAGS ('dbx_business_glossary_term' = 'Target Days Drug Screen');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_orientation` SET TAGS ('dbx_business_glossary_term' = 'Target Days Orientation');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_overall` SET TAGS ('dbx_business_glossary_term' = 'Target Days Overall');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `target_days_training` SET TAGS ('dbx_business_glossary_term' = 'Target Days Training');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Trigger Condition');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `waiver_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`requirement_rule` ALTER COLUMN `waiver_approval_role` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Role');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` SET TAGS ('dbx_subdomain' = 'compliance_documentation');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `communication_log_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Log Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `offboarding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sourcing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `task_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `automated_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Communication Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal_notification|phone|mail');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'welcome_message|task_reminder|document_request|bgc_status_update|orientation_invite|offer_letter_delivery');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|opened|failed|bounced|pending');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `last_retry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Retry Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'Message Body');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Communication Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Communication Priority');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `response_content` SET TAGS ('dbx_business_glossary_term' = 'Response Content');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_phone` SET TAGS ('dbx_business_glossary_term' = 'Sender Phone Number');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sender_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `sla_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `tracking_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Code');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`communication_log` ALTER COLUMN `worker_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Worker Response Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` SET TAGS ('dbx_subdomain' = 'training_enablement');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` SET TAGS ('dbx_association_edges' = 'onboarding.orientation_session,employee.staff_profile');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `orientation_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Orientation Attendance Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `orientation_session_id` SET TAGS ('dbx_business_glossary_term' = 'Orientation Session Reference');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Orientation Attendance - Staff Profile Id');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `attendance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attendance Timestamp');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attendance Notes');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`orientation_attendance` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` SET TAGS ('dbx_subdomain' = 'training_enablement');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` ALTER COLUMN `lms_course_id` SET TAGS ('dbx_business_glossary_term' = 'Lms Course Identifier');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` ALTER COLUMN `prerequisite_lms_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`onboarding`.`lms_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
