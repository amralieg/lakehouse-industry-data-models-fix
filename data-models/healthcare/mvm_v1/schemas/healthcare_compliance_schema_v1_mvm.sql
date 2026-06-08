-- Schema for Domain: compliance | Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm`.`compliance` COMMENT 'Enterprise regulatory compliance management for HIPAA, CMS Conditions of Participation, state health department regulations, Joint Commission standards, OSHA healthcare worker safety, and all mandatory reporting obligations. Owns compliance program definitions, regulatory requirement tracking, audit management, policy governance, and compliance training records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the compliance program. Primary key.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Each hospital or health system operates its own OIG-mandated compliance program. Compliance programs are owned and governed at the org_provider level. Compliance officers and regulators expect complia',
    `parent_compliance_program_id` BIGINT COMMENT 'Self-referencing FK on compliance_program (parent_compliance_program_id)',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current accreditation expires and must be renewed. Null for non-accreditation programs or indefinite accreditations.',
    `accreditation_status` STRING COMMENT 'Current accreditation status for programs tied to external certification bodies (e.g., Joint Commission accreditation status). Not_applicable for non-accreditation programs.. Valid values are `accredited|provisional|denied|expired|not_applicable`',
    `audit_frequency` STRING COMMENT 'Standard frequency at which internal or external audits are conducted to assess compliance with this program. [ENUM-REF-CANDIDATE: monthly|quarterly|semi_annually|annually|biennial|triennial|ad_hoc — 7 candidates stripped; promote to reference product]',
    `charter_document` STRING COMMENT 'Reference identifier or file path to the official program charter document that defines the programs mission, objectives, governance structure, and authority. May be a document management system identifier or URL.',
    `contact_email` STRING COMMENT 'General email address for inquiries, reporting, and communications related to this compliance program (e.g., compliance@healthcare.org, hipaa.privacy@healthcare.org).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for compliance program inquiries and incident reporting. Follows E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance program record was first created in the system. Part of audit trail for data governance.',
    `effective_date` DATE COMMENT 'Date when the compliance program officially became active and enforceable within the organization. Marks the start of compliance obligations under this program.',
    `expiration_date` DATE COMMENT 'Date when the compliance program is scheduled to end or requires renewal. Null for programs with indefinite duration. Used for time-bound programs such as Corporate Integrity Agreements or accreditation cycles.',
    `external_auditor_name` STRING COMMENT 'Name of the external auditing firm or regulatory body that conducts independent audits of this compliance program (e.g., Joint Commission survey team, OIG auditor, third-party compliance consultant).',
    `governing_body` STRING COMMENT 'Name of the regulatory or oversight body that mandates or oversees this compliance program (e.g., Centers for Medicare and Medicaid Services, Office for Civil Rights, The Joint Commission, Office of Inspector General, State Department of Health).',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit conducted for this compliance program.',
    `last_audit_result` STRING COMMENT 'Overall result of the most recent audit: compliant (no findings), non_compliant (significant deficiencies identified), conditional (minor findings requiring corrective action), or not_applicable (audit not yet conducted).. Valid values are `compliant|non_compliant|conditional|not_applicable`',
    `last_review_date` DATE COMMENT 'Date when the compliance program was last formally reviewed for effectiveness, relevance, and alignment with current regulations. Part of ongoing program governance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether participation in this compliance program is mandatory (true) or voluntary (false). Mandatory programs are legally or contractually required; voluntary programs are best-practice initiatives.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this compliance program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance program record was last modified. Updated with each change to track data lineage.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next internal or external audit of this compliance program.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the compliance program. Ensures periodic evaluation and continuous improvement.',
    `notes` STRING COMMENT 'Free-text field for additional notes, context, or special considerations related to the compliance program. Used for documenting program history, unique requirements, or operational details.',
    `objectives` STRING COMMENT 'High-level objectives and goals of the compliance program, such as ensuring HIPAA compliance, maintaining Joint Commission accreditation, preventing fraud and abuse, or meeting CMS Conditions of Participation.',
    `penalty_exposure_amount` DECIMAL(18,2) COMMENT 'Estimated maximum financial penalty exposure in USD for non-compliance with this program, based on regulatory penalty structures (e.g., HIPAA fines up to $1.5M per violation category per year).',
    `policy_count` STRING COMMENT 'Total number of formal policies and procedures associated with this compliance program. Used to track program complexity and governance scope.',
    `program_code` STRING COMMENT 'Unique business identifier code for the compliance program (e.g., HIPAA-COMP, CIA-2023, JC-ACCRED). Used for external references and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_name` STRING COMMENT 'Full official name of the compliance program (e.g., HIPAA Privacy and Security Compliance Program, Corporate Integrity Agreement Program).',
    `program_scope` STRING COMMENT 'Detailed description of the scope and boundaries of the compliance program, including which facilities, departments, processes, and personnel are covered. Defines what is in-scope and out-of-scope for compliance activities.',
    `program_status` STRING COMMENT 'Current lifecycle status of the compliance program. Active programs are in full operation; suspended programs are temporarily paused; closed programs have been terminated; pending programs are awaiting approval; under_review programs are being evaluated for continuation or modification.. Valid values are `active|suspended|closed|pending|under_review`',
    `program_type` STRING COMMENT 'Classification of the compliance program based on its origin and mandate: regulatory (government-mandated), accreditation (third-party certification), contractual (agreement-based such as CIA), voluntary (industry best practice), or internal (organization-initiated).. Valid values are `regulatory|accreditation|contractual|voluntary|internal`',
    `regulatory_framework` STRING COMMENT 'Primary governing regulatory framework or standard that this program addresses (e.g., HIPAA, CMS Conditions of Participation, Joint Commission Standards, OSHA Healthcare Worker Safety, State Health Department Regulations, Corporate Integrity Agreement).',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to regulatory bodies or internal governance committees under this program. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|ad_hoc|none — 7 candidates stripped; promote to reference product]',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this compliance program requires formal reporting to external regulatory bodies or oversight agencies (true) or is internally managed only (false).',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between formal reviews of the compliance program (e.g., 12 for annual review, 36 for triennial accreditation cycles).',
    `risk_level` STRING COMMENT 'Overall risk level associated with non-compliance under this program. Critical programs (e.g., HIPAA, CIA) have severe financial and legal consequences; low-risk programs have minimal regulatory impact.. Valid values are `critical|high|medium|low`',
    `training_frequency_months` STRING COMMENT 'Standard interval in months between required compliance training sessions for personnel covered by this program (e.g., 12 for annual HIPAA training).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether this compliance program mandates formal training for employees, providers, or other personnel (true) or does not require training (false).',
    `website_url` STRING COMMENT 'URL of the internal or external website providing information, resources, and documentation for this compliance program.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this compliance program record in the system.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for each formal compliance program managed by the organization, such as the HIPAA Compliance Program, Corporate Integrity Agreement (CIA) program, Joint Commission accreditation program, CMS Conditions of Participation program, OSHA Safety Program, and state licensure compliance program. Captures program name, governing regulatory framework, program owner, program scope, program status (active, suspended, closed), effective dates, and program charter. Serves as the top-level organizing entity for all compliance activities.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Regulatory obligations tied to coding compliance (ICD-10 transition, annual code updates, HIPAA transaction standards) must reference the specific code set versions required for the compliance period.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Health plan contracts (Medicare Advantage, Medicaid managed care) impose specific compliance obligations on plan operators (e.g., quality reporting, grievance resolution timelines). Linking obligation',
    `parent_obligation_id` BIGINT COMMENT 'Self-referencing FK on obligation (parent_obligation_id)',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: obligation.policy_reference is a free-text string referencing the policy that defines this obligation. Replacing it with a FK to compliance_policy normalizes the relationship between regulatory obliga',
    `program_id` BIGINT COMMENT 'Reference to the compliance program under which this obligation is managed. Links to the compliance program registry.',
    `training_id` BIGINT COMMENT 'Reference to the training course that must be completed to satisfy this obligation, if applicable.',
    `assigned_department` STRING COMMENT 'Name of the department or business unit responsible for fulfilling this obligation.',
    `assigned_role` STRING COMMENT 'Job role or position title responsible for managing and completing this obligation (e.g., Compliance Officer, Privacy Officer, Quality Director).',
    `attestation_frequency` STRING COMMENT 'Frequency at which attestation must be provided for this obligation.. Valid values are `one_time|quarterly|semi_annual|annual|biennial`',
    `attestation_required` BOOLEAN COMMENT 'Indicates whether formal attestation or certification by a responsible party is required to confirm compliance.',
    `completion_date` DATE COMMENT 'Actual date when the obligation was fulfilled and marked as complete.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of completion or compliance achievement for this obligation, ranging from 0.00 to 100.00.',
    `control_activity` STRING COMMENT 'Specific control or action that must be performed to satisfy this obligation (e.g., conduct annual HIPAA training, perform quarterly access reviews, submit monthly quality reports).',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to address non-compliance or deficiencies related to this obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this obligation record was first created in the system.',
    `due_date` DATE COMMENT 'Target date by which the obligation must be completed to maintain compliance.',
    `effective_date` DATE COMMENT 'Date when this obligation becomes active and enforceable within the organization.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this obligation requires escalation to senior management or board-level oversight when overdue or at risk.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before or after the due date that triggers an escalation notification to management.',
    `evidence_required` BOOLEAN COMMENT 'Indicates whether documented evidence of compliance must be collected and retained for this obligation.',
    `evidence_retention_years` STRING COMMENT 'Number of years that compliance evidence must be retained to meet regulatory and legal requirements.',
    `evidence_type` STRING COMMENT 'Description of the type of evidence required to demonstrate compliance (e.g., policy document, training completion records, audit report, attestation form, system logs).',
    `expiration_date` DATE COMMENT 'Date when this obligation is no longer required or has been superseded, if applicable. Null for ongoing obligations.',
    `external_audit_scope` BOOLEAN COMMENT 'Indicates whether this obligation is included in the scope of external regulatory audits or accreditation surveys.',
    `finding_count` STRING COMMENT 'Number of audit findings or deficiencies identified related to this obligation during the last audit.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this obligation is currently active and enforceable within the compliance program.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit that assessed compliance with this obligation.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit assessment for this obligation.. Valid values are `compliant|non_compliant|partially_compliant|not_assessed`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this obligation record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or reassessment of this obligation to ensure continued relevance and compliance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or special instructions related to this obligation.',
    `obligation_description` STRING COMMENT 'Detailed description of what the obligation entails, including specific actions required to achieve compliance.',
    `obligation_name` STRING COMMENT 'Short descriptive name of the compliance obligation for easy identification and reference.',
    `obligation_number` STRING COMMENT 'Human-readable unique business identifier for the obligation, used for tracking and reporting purposes.. Valid values are `^OBL-[0-9]{6,10}$`',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation indicating its state in the compliance workflow. [ENUM-REF-CANDIDATE: draft|active|in_progress|completed|overdue|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `obligation_type` STRING COMMENT 'Classification of the obligation by the type of compliance activity required: policy development, procedure implementation, training delivery, regulatory reporting, audit execution, or attestation submission.. Valid values are `policy|procedure|training|reporting|audit|attestation`',
    `priority_level` STRING COMMENT 'Business priority assigned to this obligation based on risk, regulatory impact, and organizational importance.. Valid values are `critical|high|medium|low`',
    `procedure_reference` STRING COMMENT 'Reference to the internal procedure document number or identifier that provides step-by-step instructions for fulfilling this obligation.',
    `recurrence_pattern` STRING COMMENT 'Frequency at which this obligation must be repeated or renewed to maintain ongoing compliance. [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|semi_annual|annual|biennial|as_needed — 9 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or regulatory agency that mandates this obligation (e.g., CMS, HHS OCR, The Joint Commission, State Department of Health).',
    `regulatory_citation` STRING COMMENT 'Specific legal or regulatory citation, code section, or standard reference that establishes this obligation (e.g., HIPAA 164.308(a)(1)(i), CMS CoP 482.13, Joint Commission LD.04.03.11).',
    `risk_rating` STRING COMMENT 'Assessment of the risk level associated with non-compliance of this obligation, considering potential financial, legal, and reputational impact.. Valid values are `very_high|high|moderate|low|very_low`',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Operational record linking a specific regulatory requirement to a compliance program and assigning ownership, due dates, and control activities. Represents the organizations internal obligation to meet a specific external regulatory requirement. Captures obligation type (policy, procedure, training, reporting, audit, attestation), assigned department or role, due date, recurrence schedule, current compliance status, and evidence requirements. Bridges the external regulatory requirement catalog to internal compliance management workflows.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique identifier for the organizational policy record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Coding policies specify which ICD/CPT/HCPCS code set versions are approved for use in each fiscal year, essential for version control, coder guidance, and compliance audit defense.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Every organizational compliance policy is governed under a specific compliance program (e.g., HIPAA Privacy policies belong to the HIPAA compliance program, OSHA policies to the OSHA program). This FK',
    `superseded_compliance_policy_id` BIGINT COMMENT 'Self-referencing FK on compliance_policy (superseded_compliance_policy_id)',
    `approval_authority` STRING COMMENT 'Individual, committee, or governance body authorized to approve the policy (e.g., Board of Directors, Executive Leadership Team, Compliance Committee, Medical Executive Committee).',
    `approval_date` DATE COMMENT 'Date on which the policy was formally approved by the designated approval authority.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether staff must formally attest to having read, understood, and agreed to comply with the policy. True if attestation is mandatory; False otherwise.',
    `author_contact_email` STRING COMMENT 'Email address of the policy author for questions or clarifications regarding the policy content.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `author_name` STRING COMMENT 'Name of the individual or team who authored or drafted the policy.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the policy document itself. Public policies may be shared externally; internal policies are for staff only; confidential policies contain sensitive business information; restricted policies contain highly sensitive or proprietary information.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `distribution_list` STRING COMMENT 'Comma-separated list of departments, roles, or distribution groups to whom the policy must be communicated upon approval or revision.',
    `document_location_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the full policy document in the organizational document management system or policy library.',
    `effective_date` DATE COMMENT 'Date on which the policy becomes binding and enforceable across the organization.',
    `enforcement_mechanism` STRING COMMENT 'Description of how compliance with the policy is monitored and enforced (e.g., Audit, Peer Review, Automated System Controls, Disciplinary Action).',
    `expiration_date` DATE COMMENT 'Date on which the policy ceases to be in effect. Nullable for policies without a predetermined end date.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags to facilitate search and discovery of the policy in the policy library (e.g., HIPAA, PHI, Privacy, Security, Breach Notification).',
    `last_review_date` DATE COMMENT 'Date on which the policy was most recently reviewed and validated for accuracy and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was last updated in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the policy. Calculated based on effective date and review cycle.',
    `non_compliance_consequence` STRING COMMENT 'Description of the consequences for failure to comply with the policy (e.g., Verbal Warning, Written Reprimand, Suspension, Termination, Regulatory Sanction).',
    `owner_department` STRING COMMENT 'Department or organizational unit responsible for maintaining, updating, and enforcing the policy (e.g., Health Information Management (HIM), Compliance, Clinical Quality, Human Resources).',
    `owner_role` STRING COMMENT 'Job title or role of the individual accountable for the policy (e.g., Chief Compliance Officer, Chief Nursing Officer (CNO), Director of Health Information Management (HIM), Chief Privacy Officer).',
    `policy_category` STRING COMMENT 'Primary classification of the policy indicating the functional area it governs. Clinical policies govern patient care delivery; administrative policies govern operational processes; HR policies govern workforce management; privacy/security policies govern Protected Health Information (PHI) and data security; safety policies govern workplace and patient safety; billing/revenue policies govern Revenue Cycle Management (RCM) and financial operations; compliance/regulatory policies govern adherence to external mandates. [ENUM-REF-CANDIDATE: clinical|administrative|human_resources|privacy_security|safety|billing_revenue|compliance_regulatory — 7 candidates stripped; promote to reference product]',
    `policy_number` STRING COMMENT 'Human-readable unique policy identifier used for reference and citation across the organization. Typically follows format POL-[CATEGORY]-[SEQUENCE].. Valid values are `^POL-[A-Z]{2,4}-d{4,6}$`',
    `policy_status` STRING COMMENT 'Current lifecycle state of the policy. Draft indicates initial authoring; under review indicates pending approval; approved indicates authorized but not yet effective; active indicates currently in force; suspended indicates temporarily inactive; retired indicates no longer in use; superseded indicates replaced by a newer version. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|retired|superseded — 7 candidates stripped; promote to reference product]',
    `public_facing_flag` BOOLEAN COMMENT 'Indicates whether the policy is intended for public disclosure (e.g., patient rights policies, privacy notices). True if the policy is public-facing; False if internal only.',
    `purpose` STRING COMMENT 'Detailed statement of the business or regulatory objective the policy is designed to achieve.',
    `regulatory_requirement_satisfied` STRING COMMENT 'Comma-separated list of regulatory requirements, standards, or mandates that this policy addresses (e.g., HIPAA Privacy Rule 45 CFR 164.530, Joint Commission (TJC) Standard LD.04.03.11, Centers for Medicare and Medicaid Services (CMS) Conditions of Participation 42 CFR 482.13, Occupational Safety and Health Administration (OSHA) Bloodborne Pathogens Standard 29 CFR 1910.1030).',
    `retired_reason` STRING COMMENT 'Explanation for why the policy was retired (e.g., Superseded by POL-COMP-002456, Regulatory Requirement No Longer Applicable, Organizational Restructuring).',
    `retired_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy was formally retired or superseded. Nullable if the policy is still active. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the policy must be reviewed for continued relevance, accuracy, and regulatory alignment. Common values are 12, 24, or 36 months.',
    `scope_of_application` STRING COMMENT 'Description of the organizational units, roles, or locations to which the policy applies (e.g., All Clinical Staff, All Facilities, Emergency Department (ED) Only, Revenue Cycle Management (RCM) Department).',
    `subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the policy category (e.g., Infection Control under Clinical, HIPAA Compliance under Privacy/Security, Credentialing under Administrative).',
    `summary` STRING COMMENT 'Brief executive summary of the policy purpose, key requirements, and intended outcomes. Typically 2-3 sentences.',
    `supersedes_policy_number` STRING COMMENT 'Policy number of the previous version or policy that this policy replaces. Nullable if this is the first version.',
    `title` STRING COMMENT 'Official title of the policy as it appears in the policy library and governance documentation.',
    `training_frequency_months` STRING COMMENT 'Frequency in months at which staff must complete refresher training on this policy. Nullable if training is one-time or not required.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff are required to complete formal training on this policy. True if training is mandatory; False if training is optional or not required.',
    `version_number` STRING COMMENT 'Version identifier for the policy document, typically in major.minor format (e.g., 1.0, 2.1). Incremented with each revision.. Valid values are `^d+.d+$`',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master record for every organizational policy governing clinical, administrative, and operational conduct. Captures policy number, policy title, policy category (clinical, administrative, HR, privacy, safety, billing), policy owner (department, role), effective date, review cycle, next review date, approval authority, policy status (draft, active, retired, superseded), and the regulatory requirements the policy satisfies. Serves as the SSOT for the organizations policy library and governance framework. Distinct from procedures (how-to documents) and standards.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`policy_version` (
    `policy_version_id` BIGINT COMMENT 'Unique identifier for each policy version record. Primary key for the policy version history table.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Policy versions are authored against specific code set versions (e.g., ICD-10-CM FY2024, CPT 2024). When CMS releases a new code set version, compliance teams must review and update affected policy ve',
    `policy_id` BIGINT COMMENT 'Reference to the parent policy master record. Links this version to the overarching policy entity.',
    `primary_superseded_version_policy_version_id` BIGINT COMMENT 'Reference to the prior policy version that this version replaces. Null for the initial version. Enables version lineage tracking and audit trail reconstruction.',
    `approval_date` DATE COMMENT 'Date on which this policy version received formal approval. Required for Joint Commission and CMS audit trail compliance.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether staff must formally attest to having read and understood this policy version. True if attestation is mandatory, false otherwise.',
    `change_summary` STRING COMMENT 'Narrative description of the changes introduced in this version compared to the prior version. Documents the rationale and scope of the revision for audit and training purposes.',
    `comment_log` STRING COMMENT 'Aggregated comments and feedback collected during the review and approval process. Provides context for decisions made during policy development.',
    `distribution_list` STRING COMMENT 'Comma-separated list of departments, roles, or distribution groups to which this policy version was communicated. Documents policy dissemination for compliance purposes.',
    `document_checksum` STRING COMMENT 'Cryptographic hash of the policy document file to ensure integrity and detect unauthorized modifications. Supports tamper-evidence requirements for regulatory compliance.',
    `document_url` STRING COMMENT 'Link to the full policy document stored in the document management system or content repository. Enables direct access to the authoritative policy text.',
    `effective_date` DATE COMMENT 'Date on which this policy version becomes binding and enforceable. Critical for compliance audit trails and regulatory reporting.',
    `expiration_date` DATE COMMENT 'Date on which this policy version is superseded or retired. Null for currently active versions. Required for demonstrating continuous policy coverage during audits.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language of this policy version. Supports multilingual policy management for diverse workforce populations.. Valid values are `^[a-z]{2}$`',
    `next_review_due_date` DATE COMMENT 'Calculated date by which the next policy review must be completed. Drives proactive policy maintenance and compliance with periodic review requirements.',
    `policy_type` STRING COMMENT 'Granular classification of the policy document type. Distinguishes between enterprise-wide policies, department-specific procedures, and clinical protocols.. Valid values are `organizational|departmental|clinical_protocol|standard_operating_procedure|guideline|procedure`',
    `publication_date` DATE COMMENT 'Date on which this policy version was published to the organization. May differ from approval date to allow for communication planning and training preparation.',
    `regulatory_citation` STRING COMMENT 'Formal citation or reference number for the regulatory requirement driving this policy version (e.g., 42 CFR 482.13, TJC LD.04.03.07). Enables traceability to source regulation.',
    `regulatory_driver` STRING COMMENT 'Specific regulatory requirement, standard update, or compliance mandate that triggered this policy revision. Examples include new CMS Conditions of Participation, updated Joint Commission standards, or state health department rule changes.',
    `retirement_date` DATE COMMENT 'Date on which this policy version was formally retired or archived. Null for active or approved versions. Part of the complete lifecycle audit trail.',
    `retirement_reason` STRING COMMENT 'Explanation for why this policy version was retired or superseded. Documents the business or regulatory rationale for discontinuing the version.',
    `review_cycle_months` STRING COMMENT 'Number of months between required policy reviews. Defines the periodic review schedule to ensure policies remain current and compliant. Typically 12, 24, or 36 months per organizational standards.',
    `review_date` DATE COMMENT 'Date on which the policy version review was completed. Required to demonstrate timely review cycles per regulatory standards.',
    `scope_description` STRING COMMENT 'Detailed description of the organizational units, roles, or processes to which this policy version applies. Clarifies applicability boundaries for compliance and training.',
    `training_due_days` STRING COMMENT 'Number of days from policy effective date by which staff must complete required training. Null if training is not required. Used to calculate training compliance deadlines.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training or attestation is required for this policy version. True if training is mandatory, false otherwise. Drives compliance training workflows.',
    `version_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy version record was first created in the system. Part of the audit trail for policy lifecycle management.',
    `version_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy version record was last modified. Tracks updates to version metadata throughout the approval workflow.',
    `version_number` STRING COMMENT 'Semantic version identifier for this policy revision (e.g., 1.0, 2.1, 3.0.1). Follows organizational versioning convention to track major and minor revisions.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_status` STRING COMMENT 'Current lifecycle state of this policy version. Tracks progression from draft through approval to retirement. Required for Joint Commission audit trail compliance. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|superseded|retired|archived — 7 candidates stripped; promote to reference product]',
    `version_title` STRING COMMENT 'Full descriptive title of the policy as it appears in this version. May change across versions to reflect scope or regulatory alignment updates.',
    CONSTRAINT pk_policy_version PRIMARY KEY(`policy_version_id`)
) COMMENT 'Version history record for each policy, capturing every revision cycle from draft through approval and retirement. Tracks version number, version status (draft, under review, approved, retired), author, reviewer, approver, approval date, change summary, and the specific regulatory drivers for the revision. Enables full policy lifecycle audit trail required by Joint Commission and CMS. Distinct from the policy master record which holds current-state metadata.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit record. Primary key for the audit entity.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Life safety and physical environment audits (TJC EC, CMS life safety surveys) are scoped to specific buildings. audit links to care_site but not building. Building-level audit tracking enables facilit',
    `care_site_id` BIGINT COMMENT 'Foreign key reference to the healthcare facility or care site where the audit was conducted. Links to the facility master data product.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: CMS DRG validation contractor (VDAC) audits and MAC inpatient audits are explicitly scoped to specific MS-DRG codes. Linking audit to drg enables DRG-level audit tracking and supports CMS audit respon',
    `follow_up_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (follow_up_audit_id)',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Provider groups are subject to billing audits, credentialing audits, and payer audits. RAC and MAC audits frequently target provider groups as billing entities. Compliance and revenue integrity teams ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: CMS, NCQA, and state insurance department audits are scoped to specific health plans (e.g., Medicare Advantage plan audits). Compliance officers must track audit outcomes at the plan level for regulat',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CMS, Joint Commission, and state health department audits are conducted at the org_provider (hospital/clinic) level. Audit records must link to the org_provider entity for accreditation tracking, CMS ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Compliance audits frequently audit payer-specific processes: contract compliance, claims submission accuracy, timely filing adherence, prior authorization compliance, and network adequacy. Payer conte',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: An audit is conducted against a specific compliance program (e.g., HIPAA audit, Joint Commission audit). This FK establishes the program-level context for every audit record. audit.regulatory_framewor',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Compliance audits are frequently scoped to specific clinical units (e.g., medication management audit of ICU, documentation audit of ED). audit has plain-text department_audited — a denormalization of',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Healthcare organizations conduct formal vendor qualification audits (FDA supplier audits, GPO compliance audits, DEA registrant audits). Linking audit to vendor enables vendor audit history tracking, ',
    `accreditation_decision` STRING COMMENT 'The formal accreditation decision rendered by the auditing body for accreditation audits. Accredited indicates full accreditation granted; accredited_with_conditions indicates accreditation contingent on corrective actions; preliminary_denial indicates initial denial subject to appeal; denial indicates accreditation not granted; not_applicable for non-accreditation audits.. Valid values are `accredited|accredited_with_conditions|preliminary_denial|denial|not_applicable`',
    `accreditation_expiration_date` DATE COMMENT 'The date when the accreditation granted by this audit will expire and require renewal. Typically three years from the accreditation decision date for Joint Commission. Null for non-accreditation audits.',
    `actual_completion_date` DATE COMMENT 'The actual date when the audit fieldwork was completed and the final audit report was issued. Null if the audit is not yet completed.',
    `actual_start_date` DATE COMMENT 'The actual date when the audit fieldwork and activities commenced. May differ from scheduled start date due to operational changes or delays.',
    `audit_name` STRING COMMENT 'The official name or title of the compliance audit (e.g., Q2 2024 HIPAA Privacy Audit, Joint Commission Triennial Survey).',
    `audit_scope` STRING COMMENT 'Detailed description of the areas, processes, departments, or compliance domains covered by the audit (e.g., HIPAA Privacy Rule compliance across all outpatient clinics, Emergency Department EMTALA compliance, Medication management and pharmacy operations).',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Scheduled indicates the audit is planned but not yet started; in_progress means fieldwork is underway; completed means the audit is finished and report issued; cancelled means the audit was terminated before completion; deferred means the audit has been postponed.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its origin and purpose. Internal audits are conducted by the organizations compliance team; external audits are performed by third parties; regulatory audits are mandated by government agencies; accreditation audits are for maintaining certifications.. Valid values are `internal|external|regulatory|accreditation|certification|surveillance`',
    `auditing_body` STRING COMMENT 'The name of the organization or entity conducting the audit (e.g., Office of Inspector General (OIG), The Joint Commission, Internal Compliance Department, State Department of Health).',
    `corrective_action_plan_due_date` DATE COMMENT 'The deadline by which the organization must submit its Corrective Action Plan (CAP) to the auditing body. Null if no CAP is required.',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates whether the audit outcome requires the organization to submit a formal Corrective Action Plan (CAP) to address identified deficiencies. True if CAP is required; False if no CAP is needed.',
    `corrective_action_plan_submitted_date` DATE COMMENT 'The actual date when the organization submitted its Corrective Action Plan (CAP) to the auditing body. Null if not yet submitted or not required.',
    `cost` DECIMAL(18,2) COMMENT 'The total cost incurred by the organization for the audit, including auditor fees, staff time, travel expenses, and administrative costs. Expressed in US dollars (USD).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit record was first created in the system. Represents the initial data capture event.',
    `critical_findings_count` STRING COMMENT 'The number of critical or high-severity findings that require immediate corrective action and pose significant compliance risk.',
    `external_auditor_organization` STRING COMMENT 'The name of the external auditing firm or consulting organization contracted to perform the audit, if applicable. Null for internal audits or regulatory audits conducted by government agencies.',
    `findings_count` STRING COMMENT 'The total number of audit findings, deficiencies, or non-conformances identified during the audit. Zero indicates no issues found.',
    `follow_up_completion_date` DATE COMMENT 'The actual date when follow-up verification activities were completed and all corrective actions were confirmed as implemented. Null if follow-up is not yet completed or not required.',
    `follow_up_due_date` DATE COMMENT 'The deadline by which follow-up verification of corrective actions must be completed. Null if no follow-up is required.',
    `follow_up_status` STRING COMMENT 'The current status of follow-up activities to verify implementation of corrective actions. Not_required indicates no follow-up needed; pending indicates follow-up is scheduled but not started; in_progress indicates follow-up verification is underway; completed indicates all corrective actions have been verified; overdue indicates follow-up deadlines have passed without completion.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `frequency` STRING COMMENT 'The scheduled recurrence pattern for this type of audit. Annual indicates yearly audits; biannual indicates twice per year; triennial indicates every three years (e.g., Joint Commission surveys); quarterly indicates four times per year; ad_hoc indicates one-time or event-driven audits; continuous indicates ongoing monitoring.. Valid values are `annual|biannual|triennial|quarterly|ad_hoc|continuous`',
    `is_unannounced` BOOLEAN COMMENT 'Indicates whether the audit was conducted without prior notice to the organization. True for unannounced or surprise audits; False for scheduled audits with advance notification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this audit record was most recently updated or modified. Used for tracking data lineage and audit trail purposes.',
    `lead_auditor_email` STRING COMMENT 'The primary email address of the lead auditor for audit-related communications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `lead_auditor_name` STRING COMMENT 'The full name of the individual serving as the lead or principal auditor responsible for conducting and overseeing the audit.',
    `methodology` STRING COMMENT 'Description of the audit approach and techniques used (e.g., Random sampling of 50 patient records, Tracer methodology following patient care pathways, Comprehensive review of all policies and procedures, On-site observation and staff interviews).',
    `modified_by_user` STRING COMMENT 'The username or identifier of the system user who last modified this audit record. Used for accountability and audit trail purposes.',
    `monetary_penalty_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of fines, penalties, or financial sanctions imposed as a result of the audit findings. Zero if no penalties were assessed. Expressed in US dollars (USD).',
    `notification_date` DATE COMMENT 'The date when the organization was officially notified of the upcoming audit. For unannounced audits, this may be the same as the actual start date.',
    `overall_outcome` STRING COMMENT 'The final determination or result of the audit. Compliant indicates no significant issues found; non_compliant indicates material deficiencies; partially_compliant indicates some areas of concern; conditional indicates compliance contingent on corrective actions; accredited/not_accredited applies to accreditation audits; findings_issued indicates specific deficiencies were documented. [ENUM-REF-CANDIDATE: compliant|non_compliant|partially_compliant|conditional|accredited|not_accredited|findings_issued — 7 candidates stripped; promote to reference product]',
    `period_end_date` DATE COMMENT 'The ending date of the time period being audited (the lookback period for compliance review).',
    `period_start_date` DATE COMMENT 'The beginning date of the time period being audited (the lookback period for compliance review, not the date the audit began).',
    `regulatory_framework` STRING COMMENT 'The primary regulatory or compliance framework under which the audit is conducted (e.g., HIPAA Privacy Rule, HIPAA Security Rule, CMS Conditions of Participation, Joint Commission Hospital Accreditation Standards, OSHA Bloodborne Pathogens Standard, State Health Department Licensing Requirements).',
    `report_document_path` STRING COMMENT 'The file system path or document management system reference to the official audit report document. Used for retrieval and archival purposes.',
    `report_issued_date` DATE COMMENT 'The date when the formal audit report was issued to the organizations leadership and relevant stakeholders. Null if the report has not yet been issued.',
    `risk_level` STRING COMMENT 'The overall risk level assigned to the audit based on the severity and potential impact of identified findings. Critical indicates immediate threat to patient safety or regulatory standing; high indicates significant compliance risk; medium indicates moderate risk requiring attention; low indicates minor issues with minimal impact.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'The number of records, transactions, cases, or observations reviewed during the audit. Null if the audit was comprehensive rather than sample-based.',
    `scheduled_end_date` DATE COMMENT 'The planned date when the audit fieldwork and activities are scheduled to be completed.',
    `scheduled_start_date` DATE COMMENT 'The planned date when the audit fieldwork and activities are scheduled to begin.',
    `team_size` STRING COMMENT 'The total number of auditors and support staff assigned to conduct the audit.',
    `trigger` STRING COMMENT 'The event, complaint, or circumstance that initiated the audit (e.g., Routine scheduled audit, Patient complaint, Adverse event investigation, CMS validation survey, OIG work plan selection, Whistleblower report).',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for every internal and external compliance audit conducted against the organization. Covers HIPAA internal audits, OIG work plan audits, Joint Commission triennial surveys, CMS validation surveys, state health department inspections, OSHA inspections, and internal compliance monitoring reviews. Captures audit name, audit type (internal, external, regulatory, accreditation), auditing body, audit scope, audit period, lead auditor, scheduled start/end dates, actual completion date, overall audit outcome, and follow-up status. SSOT for audit identity and lifecycle.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Audit findings for life safety, fire suppression, and structural compliance are building-specific (NFPA 101, TJC EC standards). Linking audit_finding to building enables facilities management to track',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: CMS discharge planning CoP audits and TJC care coordination standards generate audit findings that reference specific care plans (e.g., missing discharge plan, inadequate transition of care documentat',
    `care_program_enrollment_id` BIGINT COMMENT 'Foreign key linking to patient.care_program_enrollment. Business justification: Chronic Care Management (CCM) and disease management program billing audits produce findings tied to specific enrollment records. CMS and payer audits of value-based care programs require linking audi',
    `care_site_id` BIGINT COMMENT 'Reference to the specific facility, hospital, clinic, or care site where the finding was identified. Links to the facility product.',
    `care_team_id` BIGINT COMMENT 'Foreign key linking to clinical.care_team. Business justification: TJC and CMS accreditation audits generate findings related to care team composition, staffing ratios, and multidisciplinary care coordination deficiencies. Linking audit findings to specific care team',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Audit findings (billing, quality, credentialing) are assigned to responsible clinicians for corrective action. The existing responsible_party_name/email are denormalized. Compliance and medical staff ',
    `audit_id` BIGINT COMMENT 'Reference to the parent compliance audit during which this finding was identified. Links to the compliance_audit product.',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: Consent compliance audits (HIPAA, state law, research IRB) produce findings tied to specific consent records — e.g., expired consent used, missing consent for procedure. Auditors require direct tracea',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Regulatory audits (CMS, state DOI) frequently cite specific payer coverage policies as non-compliant (e.g., ACA essential health benefit violations). Audit findings must reference the offending covera',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Audit findings reference specific CPT codes when identifying billing compliance issues, upcoding, unbundling violations, or modifier misuse. Critical for revenue cycle compliance and OIG audit respons',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG validation audits identify specific DRG assignments that were incorrect or unsupported by documentation. Essential for inpatient reimbursement compliance and RAC audit defense.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to facility.equipment_asset. Business justification: Audit findings frequently cite specific equipment (defibrillator out of calibration, ventilator PM overdue, infusion pump recall). A direct FK from audit_finding to equipment_asset enables equipment-s',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: RAC, OIG, and MAC billing compliance audits routinely cite specific HCPCS codes (DME, outpatient drugs, Part B services) as the subject of findings. audit_finding already links CPT and ICD; HCPCS is t',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Audit findings cite specific ICD codes when documenting clinical documentation deficiencies, DRG validation errors, or medical necessity issues. Essential for coding compliance audits and CAP tracking',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: Joint Commission and DEA storage compliance audits produce findings tied to specific storage locations (unsecured controlled substances, temperature violations, improper hazmat storage). This link ena',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Formulary compliance audits, FDA recall audits, and DEA controlled substance audits produce findings tied to specific materials. Linking audit_finding to material_master enables recall management, for',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: RAC, MAC, and OIG medical record audits produce findings tied to specific patient records. Coding compliance audits, medical necessity reviews, and documentation audits all require linking the finding',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: 340B program audits, Part D compliance reviews, and pharmacy billing audits identify specific NDC codes as the subject of findings. A healthcare compliance expert expects audit findings to reference t',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: An audit finding identifies a deficiency against a specific regulatory obligation. Linking audit_finding to obligation enables obligation-level deficiency tracking, recurrence analysis, and compliance',
    `or_block_id` BIGINT COMMENT 'Foreign key linking to scheduling.or_block. Business justification: Anti-Kickback Statute and Stark Law audits produce findings referencing specific OR block arrangements (e.g., below-market block time given to a physician group). Compliance auditors need to link find',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Surgical compliance audits (TJC, AAAHC, CMS) generate findings specific to individual OR suites (sterile field violations, airflow deficiencies, equipment issues). Linking audit_finding to or_suite en',
    `policy_id` BIGINT COMMENT 'Reference to the organizational policy that was violated or requires update as a result of this finding. Links to the policy product. Null if no specific policy is implicated.',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the prior audit finding record if this is a recurrence. Links to another audit_finding record. Null if this is not a repeat finding.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: CMS and state audits of health plans frequently produce findings citing specific prior authorization rules as violating timeliness or medical necessity standards (e.g., CMS 72-hour PA turnaround requi',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: CDI and coding compliance audits review problem list accuracy for HCC risk adjustment and quality measure compliance. An audit finding may directly reference a problem list entry as the basis for a co',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: OIG and MAC audits identify specific provider NPIs as the subject of billing findings. Linking audit_finding to npi_registry enables provider-level compliance reporting and supports CMS exclusion work',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Off-contract purchasing audits and GPO compliance reviews produce findings tied to specific POs. Healthcare procurement compliance audits (OIG, internal) must reference the non-compliant PO. This link',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Registration compliance audits (HIPAA Notice of Privacy Practices delivery, consent capture at registration, identity verification) produce findings tied to specific registration events. CMS Condition',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Compliance audits (credentialing, exclusion, scope-of-practice) produce findings against specific schedulable resources (providers, rooms, equipment). Linking audit_finding to schedulable_resource sup',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: Clinical documentation audits (CDI, RAC, TJC) cite specific clinical notes as evidence for findings (e.g., missing attestation, unsupported medical necessity). Compliance teams need this link for disp',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: RAC/OIG coding audits directly reference specific diagnosis records (e.g., unsupported principal diagnosis, upcoding). Compliance teams need this link to dispute findings, track coding accuracy, and s',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Audit findings are frequently unit-specific (medication management deficiency in ICU, documentation gap in ED). audit_finding has plain-text affected_department — a denormalization of unit. FK to unit',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Vendor qualification audits, OIG exclusion audits, and FDA establishment audits produce findings tied to specific vendors. Healthcare compliance programs require tracking audit findings at the vendor ',
    `accreditation_impact_flag` BOOLEAN COMMENT 'Indicates whether the finding could affect the organizations accreditation status with Joint Commission, DNV, HFAP, or other accrediting bodies. True if accreditation is at risk; false otherwise.',
    `actual_resolution_date` DATE COMMENT 'The date on which the finding was actually resolved, corrective actions were completed, and the finding was closed. Null if still open or in remediation.',
    `auditor_name` STRING COMMENT 'The name of the auditor, surveyor, or inspector who identified and documented the finding. May be internal compliance staff or external regulatory surveyor.',
    `auditor_organization` STRING COMMENT 'The organization or agency the auditor represents (e.g., Joint Commission, CMS Regional Office, State Department of Health, Internal Audit Department).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required to address the finding. True for deficiencies and condition-level findings; false for observations and informational findings.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was first created in the system. Used for audit trail and data lineage.',
    `days_to_resolution` STRING COMMENT 'The number of calendar days between the identified date and the actual resolution date. Used for performance measurement and trend analysis of remediation effectiveness.',
    `dispute_reason` STRING COMMENT 'If the finding status is disputed, this field captures the organizations rationale for contesting the finding, including supporting evidence and regulatory interpretation arguments. Null if not disputed.',
    `dispute_submitted_date` DATE COMMENT 'The date on which a formal dispute or appeal of the finding was submitted to the regulatory authority. Null if not disputed.',
    `evidence_location` STRING COMMENT 'The file path, document management system location, or reference to where supporting evidence and documentation for the finding is stored (e.g., audit work papers, photographs, medical records reviewed).',
    `financial_penalty_risk_flag` BOOLEAN COMMENT 'Indicates whether the finding carries risk of financial penalties, fines, or reimbursement recoupment from CMS, state agencies, or other payers. True if monetary sanctions are possible; false otherwise.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the deficiency, observation, or non-compliance issue identified. Includes what was observed, why it constitutes a finding, and the specific circumstances or evidence supporting the citation.',
    `finding_number` STRING COMMENT 'The externally-known unique identifier or tracking number assigned to this finding within the audit (e.g., F-2024-001, CMS-CoP-123). Used for audit documentation and regulatory correspondence.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding. Open indicates newly identified; in remediation indicates corrective action plan is being executed; pending verification indicates awaiting auditor review; closed indicates resolved and accepted; disputed indicates organization contests the finding; deferred indicates resolution postponed.. Valid values are `open|in_remediation|pending_verification|closed|disputed|deferred`',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature. Deficiency indicates non-compliance requiring corrective action; observation is a noted concern without formal citation; opportunity for improvement is a recommendation; immediate jeopardy indicates serious threat to patient safety; condition-level deficiency is a systemic CMS compliance failure; best practice gap is advisory.. Valid values are `deficiency|observation|opportunity_for_improvement|immediate_jeopardy|condition_level_deficiency|best_practice_gap`',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit or validation survey is required to verify that corrective actions have been effectively implemented. True if follow-up is mandated; false otherwise.',
    `follow_up_audit_scheduled_date` DATE COMMENT 'The scheduled date for the follow-up audit or validation survey to verify corrective action effectiveness. Null if no follow-up is required or not yet scheduled.',
    `identified_date` DATE COMMENT 'The date on which the finding was first identified during the audit or inspection. This is the principal business event timestamp for the finding.',
    `mandatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the finding triggers mandatory external reporting obligations to CMS, state health departments, Joint Commission, or other regulatory bodies. True if external reporting is required; false otherwise.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this audit finding record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was last modified. Used for audit trail and change tracking.',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the finding has direct or potential impact on patient safety. True if patient harm occurred or could occur; false if the finding is administrative or process-related without direct patient safety implications.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat or recurrence of a previously identified and supposedly corrected issue. True if this is a repeat finding; false if this is the first occurrence.',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or governing body under which the cited standard falls (e.g., HIPAA for privacy violations, CMS CoP for hospital conditions, Joint Commission for accreditation standards, OSHA for workplace safety). [ENUM-REF-CANDIDATE: hipaa|cms_cop|joint_commission|osha|state_health_department|fda|dea|emtala|stark_law|anti_kickback|other — 11 candidates stripped; promote to reference product]',
    `regulatory_standard_cited` STRING COMMENT 'The specific regulatory standard, rule, or requirement that was violated or not met (e.g., 42 CFR 482.13, Joint Commission LD.04.03.11, OSHA 29 CFR 1910.1030). May include multiple citations separated by semicolons.',
    `reported_to_authority_date` DATE COMMENT 'The date on which the finding was reported to the applicable regulatory authority, if mandatory reporting was required. Null if not reported or not required.',
    `root_cause_category` STRING COMMENT 'The primary root cause category identified through analysis of why the finding occurred. Used to drive systemic corrective actions and prevent recurrence. [ENUM-REF-CANDIDATE: policy_gap|training_deficiency|process_failure|resource_constraint|communication_breakdown|technology_issue|human_error|documentation_failure|other — 9 candidates stripped; promote to reference product]',
    `scope_of_impact` STRING COMMENT 'The breadth of the finding across the organization. Isolated indicates a single incident; pattern indicates multiple occurrences in one area; widespread indicates multiple areas affected; systemic indicates organization-wide process failure.. Valid values are `isolated|pattern|widespread|systemic`',
    `severity_level` STRING COMMENT 'The assessed severity or risk level of the finding. Critical indicates immediate threat to patient safety or major regulatory violation; high indicates significant compliance risk; medium indicates moderate risk; low indicates minor issue; informational indicates advisory note without compliance impact.. Valid values are `critical|high|medium|low|informational`',
    `tags_keywords` STRING COMMENT 'Comma-separated list of tags or keywords for categorization, search, and reporting (e.g., infection_control, medication_safety, documentation, privacy, emergency_preparedness). Supports analytics and trend identification.',
    `target_resolution_date` DATE COMMENT 'The date by which the finding must be resolved and corrective actions completed. May be mandated by regulatory authority or set internally based on risk assessment.',
    `verification_method` STRING COMMENT 'The method used by the auditor to verify and validate the finding (e.g., document review, on-site inspection, staff interviews, medical record audit). May include multiple methods. [ENUM-REF-CANDIDATE: document_review|on_site_inspection|staff_interview|medical_record_audit|policy_review|observation|testing|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record of each individual deficiency, observation, or finding identified during a compliance audit. Captures finding number, finding type (deficiency, observation, opportunity for improvement, immediate jeopardy, condition-level deficiency), regulatory standard cited, finding description, severity level, affected department or facility, finding status (open, in remediation, closed, disputed), and target resolution date. Links to the parent compliance audit and drives corrective action planning. Distinct from quality.standard_finding which is accreditation-survey-specific.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Reference to the primary audit finding or compliance violation that triggered this corrective action plan.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Corrective action plans for life safety, fire safety, and structural deficiencies are scoped to specific buildings (NFPA 101 CAPs, CMS life safety CAPs). Linking corrective_action_plan to building ena',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Corrective action plans in healthcare are frequently assigned to specific clinicians as responsible owners (quality improvement, billing compliance, credentialing deficiencies). The existing responsib',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: CAPs remediate specific procedure code compliance issues, tracking which CPT codes require documentation improvement, modifier education, or billing practice changes to prevent recurrence.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: CAPs for inpatient DRG upcoding findings (MS-DRG validation contractor audits, MAC DRG reviews) must reference the specific DRG being corrected. corrective_action_plan has cpt_code_id and icd_code_id ',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Receiving a recalled product, a temperature-excursion shipment, or a non-UDI-compliant device triggers a CAP tied to the specific goods receipt. Healthcare recall management and FDA CAPA processes req',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: CAPs arising from HCPCS billing audit findings (DME overpayments, outpatient drug billing errors) must reference the specific HCPCS code being corrected. corrective_action_plan already has cpt_code_id',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: CMS issues corrective action plans against specific Medicare Advantage or Part D health plans. State regulators issue plan-level CAPs for coverage violations. CAP already links to payer but not the sp',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: CAPs address specific diagnosis code misuse patterns identified in audits, requiring remediation tied to particular ICD codes (e.g., sepsis coding education, specificity improvement for diabetes codes',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: CAPs for 340B program violations, Part D overpayments, and pharmacy billing errors reference the specific NDC code being corrected. Healthcare compliance officers expect CAPs to identify the exact dru',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: CAPs often result from payer audits (claims audits, medical record reviews, contract compliance audits) or address payer-identified deficiencies. Tracking which payer triggered or is monitoring the CA',
    `policy_id` BIGINT COMMENT 'Reference to the organizational policy that was updated, created, or reinforced as part of this corrective action plan.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: CMS and state regulators issue CAPs specifically targeting non-compliant prior authorization rules (e.g., PA rules violating the CMS Interoperability and Prior Authorization Rule). Linking CAPs direct',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_privacy_incident. Business justification: Corrective action plans can be created in response to HIPAA privacy incidents, not just audit findings. CAP should support multiple trigger types. This FK allows tracking CAPs created to remediate pri',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Provider-specific CAPs (OIG Corporate Integrity Agreements, MAC overpayment demands) must identify the responsible provider by NPI for regulatory reporting. corrective_action_plan has responsible_owne',
    `superseded_corrective_action_plan_id` BIGINT COMMENT 'Self-referencing FK on corrective_action_plan (superseded_corrective_action_plan_id)',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Corrective action plans are frequently triggered by surgical compliance failures (wrong-site surgery, consent violations, timeout non-compliance). Linking CAP directly to the surgical_case supports s',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Corrective action plans are frequently scoped to specific clinical units (medication error CAP for ICU, documentation CAP for ED). Unit-level CAP tracking enables department managers to own remediatio',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Contract compliance violations (pricing discrepancies, non-compliant terms, anti-kickback issues) trigger corrective action plans tied to specific vendor contracts. Healthcare compliance officers requ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Vendor performance failures (OIG exclusion, repeated delivery non-compliance, FDA warning letters) trigger CAPs against specific vendors. Healthcare supply chain compliance requires tracking CAPs at t',
    `actual_completion_date` DATE COMMENT 'Actual date when all corrective actions were fully implemented and ready for verification.',
    `cap_number` STRING COMMENT 'Business identifier for the corrective action plan, externally visible and used in regulatory submissions and audit correspondence.. Valid values are `^CAP-[0-9]{6,10}$`',
    `cap_status` STRING COMMENT 'Current lifecycle status of the corrective action plan in the regulatory response and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|in_progress|completed|verified|closed — 7 candidates stripped; promote to reference product]',
    `cap_type` STRING COMMENT 'Classification of the corrective action plan based on regulatory requirement and scope of response.. Valid values are `plan_of_correction|corrective_action_plan|preventive_action|immediate_action`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan was formally closed after successful verification and regulatory acceptance.',
    `closure_notes` STRING COMMENT 'Final notes documenting the closure of the corrective action plan, including lessons learned and recommendations for future compliance improvement.',
    `corrective_actions_defined` STRING COMMENT 'Detailed description of the specific corrective actions, process changes, policy updates, training programs, or system enhancements that will be implemented to address the deficiency.',
    `created_by_user` STRING COMMENT 'Username or identifier of the compliance officer or staff member who created the corrective action plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was first created in the compliance management system.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the corrective action plan requires escalation to executive leadership, board of directors, or external regulatory authority due to severity or complexity.',
    `external_consultant_engaged_flag` BOOLEAN COMMENT 'Indicates whether external consultants, subject matter experts, or legal counsel were engaged to support corrective action plan development or implementation.',
    `implementation_milestones` STRING COMMENT 'Key milestones, checkpoints, and deliverables defined in the corrective action plan implementation timeline.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the corrective action plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was last modified or updated.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which ongoing monitoring and auditing will be conducted to ensure sustained compliance after corrective action plan implementation.. Valid values are `daily|weekly|monthly|quarterly|annually|continuous`',
    `patient_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the compliance violation and corrective action plan directly impact patient safety or quality of care.',
    `priority_level` STRING COMMENT 'Priority classification of the corrective action plan based on severity of the violation, patient safety impact, and regulatory urgency.. Valid values are `critical|high|medium|low`',
    `recurrence_prevention_measures` STRING COMMENT 'Specific measures, controls, monitoring mechanisms, or system changes implemented to prevent recurrence of the compliance violation.',
    `regulator_approval_date` DATE COMMENT 'Date when the regulatory body or accreditation agency formally approved the corrective action plan.',
    `regulator_feedback` STRING COMMENT 'Feedback, comments, or additional requirements provided by the regulatory body or accreditation agency in response to the submitted corrective action plan.',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement, standard, or condition of participation that was violated and is being addressed by this CAP.',
    `responsible_owner_department` STRING COMMENT 'Department or organizational unit responsible for executing the corrective action plan.',
    `root_cause_analysis_summary` STRING COMMENT 'Summary of the root cause analysis conducted to identify the underlying factors that led to the compliance violation or audit finding.',
    `staff_affected_count` STRING COMMENT 'Number of staff members, departments, or organizational units affected by or involved in the corrective action plan implementation.',
    `submitted_to_regulator_date` DATE COMMENT 'Date when the corrective action plan was formally submitted to the regulatory body or accreditation agency.',
    `target_completion_date` DATE COMMENT 'Planned date by which all corrective actions must be fully implemented and verified, as committed to the regulatory body or accreditation agency.',
    `training_completion_target_date` DATE COMMENT 'Target date by which all required staff training must be completed as part of the corrective action plan.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training or education is required as part of the corrective action plan implementation.',
    `verification_date` DATE COMMENT 'Date when the corrective action plan was verified as complete and effective by internal compliance or external regulatory authority.',
    `verification_method` STRING COMMENT 'Method by which the effectiveness and completion of the corrective action plan will be verified by internal compliance or external regulatory surveyors. [ENUM-REF-CANDIDATE: document_review|on_site_inspection|staff_interview|medical_record_audit|policy_review|training_records_review|system_validation — 7 candidates stripped; promote to reference product]',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process documenting findings, evidence reviewed, and any remaining concerns or recommendations.',
    `verification_outcome` STRING COMMENT 'Result of the verification process indicating whether the corrective actions were found to be effective and sustainable.. Valid values are `verified_effective|verified_partial|not_verified|requires_additional_action`',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Formal corrective action plan (CAP) developed in response to one or more audit findings or compliance violations. Captures CAP number, CAP type (plan of correction, corrective action plan, preventive action), root cause analysis summary, corrective actions defined, responsible owner, implementation milestones, target completion date, actual completion date, CAP status (draft, submitted, approved, in progress, completed, verified), and verification method. Required by CMS, Joint Commission, and OIG for regulatory response. Distinct from quality.corrective_action which is patient-safety-event-driven.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` (
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Unique identifier for the HIPAA privacy incident record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: HIPAA privacy incidents frequently involve unauthorized access to appointment/scheduling PHI (e.g., staff viewing a celebrity patients appointments). Linking hipaa_privacy_incident to the specific sc',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: HIPAA privacy incidents occur at specific care sites and must be reported by location to OCR. hipaa_privacy_incident has plain-text location_of_incident — a denormalization of care_site. FK enables si',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: HIPAA privacy incidents frequently involve a specific clinician as the responsible party (unauthorized access, improper disclosure). Privacy officers must link incidents to the clinician for disciplin',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: HIPAA privacy incidents frequently involve unauthorized PHI disclosure tied to a specific consent record (e.g., disclosure beyond authorized scope). Linking the incident to the consent record supports',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: HIPAA breach notifications to OCR and HHS are filed at the health plan level for insured populations. A breach involving Medicare Advantage enrollees must be reported under that specific plan. hipaa_p',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: HIPAA breach investigations require identifying affected patients by MPI record. OCR reporting mandates tracking affected individuals; breach notification letters are sent per patient. Healthcare comp',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_note. Business justification: Privacy breach investigations frequently identify specific clinical notes that were inappropriately accessed or disclosed. HIPAA incident response requires documenting which exact note records were in',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HIPAA breach notifications require identifying the covered entity (org_provider — hospital, clinic) where the incident occurred. OCR breach reporting and HHS wall of shame submissions are at the org_p',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Privacy incidents involving payer data (eligibility file breaches, claims data exposure, remittance misdirection) must track which payers data was involved for breach notification, business associate',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: hipaa_privacy_incident has a policy_violation_flag (boolean) indicating a policy was violated, but no FK to identify which policy. Linking to compliance_policy enables identification of which specific',
    `portal_account_id` BIGINT COMMENT 'Foreign key linking to patient.portal_account. Business justification: Patient portal breaches (wrong-patient access, unauthorized login) are a major HIPAA incident category. OCR investigations require identifying the specific portal account involved. Healthcare privacy ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: HIPAA privacy incidents are managed under the HIPAA compliance program. Linking incidents directly to the compliance program enables program-level incident tracking, OCR reporting aggregation, and bre',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: OCR breach reporting and HIPAA incident investigations require identifying the covered entity or business associate by NPI. hipaa_privacy_incident has reported_by_name/role but no NPI FK; NPI is the s',
    `affected_individuals_count` STRING COMMENT 'The number of unique individuals whose PHI was potentially or actually compromised in the incident.',
    `breach_determination_date` DATE COMMENT 'The date when the formal breach determination was completed.',
    `breach_determination_outcome` STRING COMMENT 'The formal determination of whether the incident constitutes a breach under HIPAA Breach Notification Rule based on the four-factor risk assessment.. Valid values are `breach|not a breach|low probability of compromise|pending determination`',
    `closed_date` DATE COMMENT 'The date when the incident investigation and all required actions were completed and the case was formally closed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this incident record was first created in the system.',
    `disciplinary_action_taken_flag` BOOLEAN COMMENT 'Indicates whether disciplinary action was taken against any workforce member as a result of the incident.',
    `discovery_date` DATE COMMENT 'The date when the organization first became aware of the potential privacy incident or breach.',
    `incident_category` STRING COMMENT 'High-level categorization of the root cause or mechanism of the incident.. Valid values are `technical|human error|malicious|physical|administrative`',
    `incident_date` DATE COMMENT 'The date when the unauthorized access, use, or disclosure of Protected Health Information (PHI) occurred or is estimated to have occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the privacy incident including circumstances, individuals involved, and sequence of events.',
    `incident_number` STRING COMMENT 'Business-facing unique identifier or case number assigned to the privacy incident for tracking and reference purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the privacy incident investigation and resolution process. [ENUM-REF-CANDIDATE: reported|under investigation|breach determination pending|breach confirmed|not a breach|closed|remediation in progress — 7 candidates stripped; promote to reference product]',
    `incident_type` STRING COMMENT 'Classification of the nature of the privacy incident describing how the unauthorized use or disclosure occurred. [ENUM-REF-CANDIDATE: unauthorized access|improper disclosure|lost device|stolen device|misdirected communication|insider threat|hacking|ransomware|phishing — 9 candidates stripped; promote to reference product]',
    `individual_notification_date` DATE COMMENT 'The date when notification letters were sent to affected individuals (must be within 60 days of discovery).',
    `individual_notification_required_flag` BOOLEAN COMMENT 'Indicates whether notification to affected individuals is required under HIPAA Breach Notification Rule.',
    `investigation_summary` STRING COMMENT 'Detailed summary of the investigation findings including root cause analysis and contributing factors.',
    `law_enforcement_case_number` STRING COMMENT 'Case or reference number assigned by law enforcement if the incident was reported to police or other authorities.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement agencies were notified of the incident.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the incident and recommendations for organizational improvement.',
    `media_notification_date` DATE COMMENT 'The date when media notification was issued for breaches affecting 500 or more individuals.',
    `media_notification_required_flag` BOOLEAN COMMENT 'Indicates whether media notification is required (for breaches affecting 500 or more individuals in a jurisdiction).',
    `mitigation_measures` STRING COMMENT 'Description of immediate mitigation measures taken to limit harm and prevent further unauthorized access or disclosure.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this incident record was last modified or updated.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether breach notification to affected individuals, HHS Office for Civil Rights (OCR), and/or media is required.',
    `ocr_case_number` STRING COMMENT 'The case or reference number assigned by HHS Office for Civil Rights upon receipt of the breach report.',
    `ocr_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether reporting to HHS Office for Civil Rights is required.',
    `ocr_reporting_status` STRING COMMENT 'Current status of the breach report submission to HHS Office for Civil Rights.. Valid values are `not required|pending|submitted|acknowledged|under investigation`',
    `ocr_submission_date` DATE COMMENT 'The date when the breach report was submitted to HHS Office for Civil Rights (within 60 days for 500+ individuals, or annually for fewer than 500).',
    `phi_involved_flag` BOOLEAN COMMENT 'Indicates whether Protected Health Information was involved in the incident.',
    `phi_type` STRING COMMENT 'Description of the type or category of PHI that was accessed, used, or disclosed (e.g., medical records, billing information, lab results, demographic data).',
    `phi_volume_records` STRING COMMENT 'The number of patient records or PHI records involved in the incident.',
    `policy_violation_flag` BOOLEAN COMMENT 'Indicates whether the incident involved a violation of organizational privacy policies or procedures.',
    `privacy_officer_assigned` STRING COMMENT 'Name of the privacy officer or compliance officer assigned to investigate and manage the incident.',
    `remediation_actions_taken` STRING COMMENT 'Description of corrective and remediation actions taken to address the incident and prevent recurrence.',
    `remediation_completion_date` DATE COMMENT 'The date when all remediation actions were completed.',
    `reported_by_department` STRING COMMENT 'Department or organizational unit of the individual who reported the incident.',
    `reported_by_name` STRING COMMENT 'Name of the individual who initially reported or discovered the privacy incident.',
    `reported_by_role` STRING COMMENT 'Job title or role of the individual who reported the incident.',
    `risk_assessment_completed_flag` BOOLEAN COMMENT 'Indicates whether the required four-factor risk assessment has been completed to determine breach status.',
    `risk_assessment_summary` STRING COMMENT 'Summary of the four-factor risk assessment findings including nature and extent of PHI, unauthorized person, actual acquisition or viewing, and extent of mitigation.',
    `root_cause` STRING COMMENT 'Identified root cause of the privacy incident based on investigation findings.',
    CONSTRAINT pk_hipaa_privacy_incident PRIMARY KEY(`hipaa_privacy_incident_id`)
) COMMENT 'Transactional record of every potential or confirmed HIPAA Privacy Rule incident, breach, or unauthorized use/disclosure of Protected Health Information (PHI). Captures incident date, discovery date, incident type (unauthorized access, improper disclosure, lost/stolen device, misdirected communication, insider threat), PHI involved (type, volume, affected individuals), breach determination outcome (breach, not a breach, low probability of compromise), notification obligations triggered, OCR reporting status, and remediation actions. SSOT for HIPAA breach management and OCR reporting compliance.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the compliance training program. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure coding training targets specific CPT codes with high error rates, compliance risk, or frequent NCCI edits, necessitating direct linkage for curriculum design and effectiveness tracking.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: CMS billing education and HCPCS modifier compliance training programs are scoped to specific HCPCS codes (e.g., modifier 59 training, DME billing training). training already has cpt_code_id and icd_co',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Compliance training modules focus on specific high-risk or frequently misused diagnosis codes (sepsis, MI, diabetes with complications), requiring direct code references for targeted coder education.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: training.policy_reference is a free-text string referencing the policy that mandates this training. Replacing it with a proper FK to compliance_policy normalizes this relationship, enabling structured',
    `prerequisite_training_id` BIGINT COMMENT 'Self-referencing FK on training (prerequisite_training_id)',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Training programs are mandated by specific compliance programs (e.g., HIPAA training under the HIPAA compliance program, OSHA safety training under the OSHA program). This FK enables program-level tra',
    `accreditation_body` STRING COMMENT 'Organization that has accredited or certified this training program. Examples: ANCC, AMA, AAFP. Null if not accredited.',
    `accreditation_number` STRING COMMENT 'Unique accreditation or certification number assigned by the accrediting body. Used for external reporting and audit.',
    `approval_authority` STRING COMMENT 'Role or individual who approved this training program for deployment. Examples: Chief Compliance Officer, Chief Medical Officer, VP Human Resources.',
    `approval_date` DATE COMMENT 'Date when the training program was formally approved for use by the approval authority.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether the training includes a graded assessment that must be passed for completion. True if assessment is required, False if completion is based on participation only.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether the learner must sign an attestation statement acknowledging understanding and commitment to comply. Common for Code of Conduct and policy-based training.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate is issued upon successful completion of the training. True if certificate is generated, False otherwise.',
    `content_author` STRING COMMENT 'Name of the individual or team who developed the training content.',
    `content_location_url` STRING COMMENT 'URL or file path where the training content is hosted. Used by learning management systems to launch the training.',
    `content_owner` STRING COMMENT 'Department or role responsible for maintaining the training content and ensuring accuracy and regulatory alignment. Examples: Compliance Department, Infection Prevention, Human Resources.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was first created in the system. Used for audit trail and data lineage.',
    `duration_minutes` STRING COMMENT 'Expected time in minutes required to complete the training program. Used for workforce planning and scheduling.',
    `effective_date` DATE COMMENT 'Date when this training program version became active and available for assignment. Used to track training content versioning.',
    `escalation_threshold_days` STRING COMMENT 'Number of days past the due date after which non-completion triggers an escalation to management. Used for compliance enforcement.',
    `expiration_date` DATE COMMENT 'Date when this training program version is no longer valid or available for new assignments. Null if the training has no planned end date.',
    `format` STRING COMMENT 'Delivery method for the training program. Determines how learners access and complete the training. [ENUM-REF-CANDIDATE: Online|In-Person|Blended|Simulation|On-the-Job|Self-Study|Webinar|Video — 8 candidates stripped; promote to reference product]',
    `frequency` STRING COMMENT 'How often the training must be completed to maintain compliance. Drives recurrence scheduling and assignment logic. [ENUM-REF-CANDIDATE: Annual|Biennial|One-Time|Upon Hire|Upon Role Change|Quarterly|As Needed — 7 candidates stripped; promote to reference product]',
    `frequency_months` STRING COMMENT 'Numeric representation of training recurrence interval in months. Used for automated scheduling. Examples: 12 for annual, 24 for biennial, null for one-time.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags used for training catalog search and discovery.',
    `last_review_date` DATE COMMENT 'Date when the training content was last reviewed and validated for accuracy and regulatory compliance.',
    `learning_objectives` STRING COMMENT 'Summary of the key learning outcomes and competencies the training is designed to achieve. Used for curriculum mapping and competency tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was last modified. Used for audit trail and change tracking.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review. Used to trigger review workflows and ensure training remains current.',
    `non_compliance_consequence` STRING COMMENT 'Description of the organizational consequence for failing to complete required training. Examples: Loss of system access, disciplinary action, termination.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to successfully complete the training, expressed as a percentage (0.00 to 100.00). Null if no assessment is required.',
    `priority_level` STRING COMMENT 'Business priority assigned to this training program. Critical and High priority training may trigger escalation workflows for non-completion.. Valid values are `Critical|High|Medium|Low`',
    `regulatory_authority` STRING COMMENT 'The governing body or agency that mandates this training requirement. Examples: HHS Office for Civil Rights, OSHA, CMS, The Joint Commission, State Department of Health.',
    `regulatory_mandate` STRING COMMENT 'The specific regulation, statute, or accreditation standard that requires this training. Examples: HIPAA Privacy Rule 45 CFR 164.530(b), OSHA 29 CFR 1910.1030, Joint Commission HR.01.06.01.',
    `retired_reason` STRING COMMENT 'Explanation for why the training program was retired. Examples: Superseded by new version, Regulatory requirement removed, Content no longer relevant.',
    `retired_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program was retired and removed from active use. Null if the training is still active or suspended.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the training content must be reviewed for accuracy and regulatory alignment. Examples: 12, 24, 36.',
    `supersedes_training_number` STRING COMMENT 'Training program number that this version replaces. Used to track training evolution and ensure learners complete the most current version.',
    `target_audience` STRING COMMENT 'Description of the workforce population required to complete this training. May specify roles, departments, or all staff. Examples: All Staff, Clinical Staff, Physicians, Nurses, Environmental Services, IT Staff, Revenue Cycle Staff.',
    `target_department` STRING COMMENT 'Specific department or service line required to complete this training. Used for automated assignment rules.',
    `target_role` STRING COMMENT 'Specific job role or role category required to complete this training. Used for automated assignment rules.',
    `training_description` STRING COMMENT 'Detailed description of the training program content, scope, and purpose. Displayed to learners and used for catalog search.',
    `training_name` STRING COMMENT 'Full name of the compliance training program as displayed to learners and in catalogs.',
    `training_number` STRING COMMENT 'Business identifier for the training program, used for external reference and reporting. Typically follows format TRN-XXXXXX.. Valid values are `^TRN-[A-Z0-9]{6,12}$`',
    `training_status` STRING COMMENT 'Current lifecycle status of the training program. Active programs are available for assignment and completion.. Valid values are `Active|Inactive|Under Development|Under Review|Retired|Suspended`',
    `training_type` STRING COMMENT 'Category of compliance training program. Defines the subject matter and regulatory domain covered by the training. [ENUM-REF-CANDIDATE: HIPAA Privacy|HIPAA Security|Corporate Compliance|OSHA Bloodborne Pathogens|Fire Safety|Abuse and Neglect|Cultural Competency|Code of Conduct|Emergency Preparedness|Infection Control|Patient Rights|Workplace Violence Prevention|Hazardous Materials|Radiation Safety|Respiratory Protection|Other — 16 candidates stripped; promote to reference product]',
    `vendor_course_code` STRING COMMENT 'Unique identifier assigned by the external vendor for this training course. Used for integration and reporting with vendor learning management systems.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or content provider if the training is sourced from a third party. Null for internally developed training.',
    `version_number` STRING COMMENT 'Version identifier for the training content. Incremented when training materials are updated. Format: major.minor (e.g., 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Master catalog of all mandatory and elective compliance training programs required by regulation or organizational policy. Captures training program name, training type (HIPAA Privacy, HIPAA Security, Corporate Compliance, OSHA Bloodborne Pathogens, Fire Safety, Abuse/Neglect, Cultural Competency, Code of Conduct), regulatory mandate driving the requirement, target audience (role, department, all staff), training format (online, in-person, simulation), frequency (annual, biennial, one-time, upon hire), passing score threshold, and training status. Distinct from workforce.cme_activity which tracks clinical continuing education.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Training completion records track which facility an employee completed training at (employee_facility is a plain-text denormalization of care_site). A FK to care_site enables site-level training compl',
    `care_team_member_id` BIGINT COMMENT 'Foreign key linking to clinical.care_team_member. Business justification: Healthcare compliance mandates tracking mandatory training completion (HIPAA, infection control, safety) for all care team members. This link supports workforce compliance reporting, credentialing ver',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Mandatory compliance training completion (HIPAA, OIG, infection control) must be tracked per clinician for credentialing committees, medical staff reappointment, and Joint Commission surveys. Credenti',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Training completions satisfy specific compliance obligations (e.g., annual HIPAA training satisfies the HIPAA training obligation). Linking training_completion to obligation enables obligation-level c',
    `reattempted_training_completion_id` BIGINT COMMENT 'Self-referencing FK on training_completion (reattempted_training_completion_id)',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: CRITICAL FIX: training_completion.training_program_id currently points to compliance.program.program_id, but it should point to compliance.training.training_id. Training completion records should refe',
    `accreditation_body` STRING COMMENT 'Name of the organization that accredited or approved this training program. Examples include ACCME, ANCC, state boards, or internal compliance committees.',
    `assigned_date` DATE COMMENT 'Date when the training program was assigned to the employee. Marks the start of the compliance obligation period.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this training completion. Increments when an employee retakes a failed training.',
    `certificate_issued_date` DATE COMMENT 'Date when the training certificate was officially issued. May differ from completion date for trainings requiring manual review or approval.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion. Used for external verification and audit documentation.',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the training program. Null if training is not yet completed.',
    `completion_number` STRING COMMENT 'Business identifier for this training completion event. May be used for certificate tracking and audit trails.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the training completion record. Tracks progression from assignment through completion or expiration. [ENUM-REF-CANDIDATE: assigned|in_progress|completed|overdue|waived|expired|not_started — 7 candidates stripped; promote to reference product]',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the training was marked complete in the Learning Management System (LMS). Used for audit trail and time-sensitive compliance verification.',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of Continuing Education (CE) or Continuing Medical Education (CME) credits awarded for this training completion. Used for professional licensure maintenance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the data platform. Part of the audit trail.',
    `credit_type` STRING COMMENT 'Type of continuing education credit awarded. CME (Continuing Medical Education) for physicians, CEU (Continuing Education Unit) for general staff, CNE (Continuing Nursing Education) for nurses, or contact hours.. Valid values are `cme|ceu|cne|contact_hours|not_applicable`',
    `due_date` DATE COMMENT 'Date by which the training must be completed to maintain compliance. Used for overdue tracking and escalation.',
    `escalation_date` DATE COMMENT 'Date when the overdue training was escalated to management. Part of the compliance enforcement audit trail.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this overdue training has been escalated to management or compliance leadership. True if escalated, False otherwise.',
    `expiration_date` DATE COMMENT 'Date when this training completion expires and requires renewal. Null for one-time trainings that do not expire.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the training. Applicable for in-person and instructor-led sessions.',
    `last_reminder_sent_date` DATE COMMENT 'Date when the most recent reminder notification was sent to the employee. Used for escalation timing and communication tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified in the data platform. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this training completion. May include special circumstances, technical issues, or compliance officer annotations.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the employee passed or failed the training assessment. Not applicable for trainings without assessments.. Valid values are `pass|fail|not_applicable|pending`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training. Captured at completion time to preserve historical pass/fail criteria.',
    `regulatory_requirement_satisfied` STRING COMMENT 'Citation or reference to the specific regulatory requirement satisfied by this training completion. Examples include HIPAA Privacy Rule, OSHA Bloodborne Pathogens Standard, Joint Commission standards.',
    `reminder_sent_count` STRING COMMENT 'Number of reminder notifications sent to the employee for this training assignment. Used for tracking engagement and escalation.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved by the employee on the training assessment. Null if training does not include a scored assessment.',
    `source_system` STRING COMMENT 'Name of the system that originated this training completion record. Examples include Workday Learning, internal LMS, or manual entry system.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this training completion record in the source system. Used for data lineage and reconciliation.',
    `training_duration_minutes` STRING COMMENT 'Total time in minutes the employee spent completing the training. Captured from Learning Management System (LMS) tracking data.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted. May be a facility name, room number, or online platform identifier.',
    `training_method` STRING COMMENT 'Method by which the training was delivered to the employee. Used for effectiveness analysis and compliance documentation.. Valid values are `online|in_person|blended|self_study|webinar|simulation`',
    `waiver_approval_date` DATE COMMENT 'Date when the training waiver was officially approved. Part of the compliance audit trail.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the training waiver. Required for audit trail when waiver is granted.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the training requirement was waived for this employee. True if waived, False otherwise.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving the training requirement. Required when waiver_flag is True. Subject to compliance review.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Transactional record of each individual staff members completion of a required compliance training program. Captures employee reference, training program reference, assigned date, completion date, training method, score achieved, pass/fail status, certificate number, expiration date, and completion status (assigned, in progress, completed, overdue, waived). Enables compliance reporting on training completion rates by department, role, and regulatory requirement. Supports Joint Commission HR.01.05 and OIG compliance program documentation.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` (
    `exclusion_screening_id` BIGINT COMMENT 'Unique identifier for the exclusion screening record.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: OIG exclusion screening is performed at the care site level — each facility must screen its workforce and vendors. Linking exclusion_screening to care_site enables site-specific screening compliance r',
    `care_team_member_id` BIGINT COMMENT 'Foreign key linking to clinical.care_team_member. Business justification: 42 CFR requires OIG/SAM exclusion screening for all healthcare workers with patient care responsibilities. Linking exclusion_screening to care_team_member is a direct regulatory requirement — complian',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: OIG/SAM exclusion screening is a mandatory monthly credentialing compliance process. Screening records must be directly linked to the clinician entity for credentialing verification, re-credentialing ',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Provider groups (medical groups, IPAs) are subject to OIG/SAM exclusion screening as billing entities. CMS requires screening of all entities submitting claims. Compliance teams screen provider groups',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Medicare Advantage and Medicaid managed care contracts mandate OIG/SAM exclusion screening as a plan-specific contractual requirement. Screening results must be tracked per health plan to demonstrate ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: OIG/SAM exclusion screening applies to organizational entities (hospitals, clinics) as well as individuals. CMS requires monthly screening of all providers including org_providers. Compliance teams mu',
    `prior_exclusion_screening_id` BIGINT COMMENT 'Self-referencing FK on exclusion_screening (prior_exclusion_screening_id)',
    `program_id` BIGINT COMMENT 'Reference to the compliance program under which this screening was performed.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Exclusion screening validates NPIs against the national registry to ensure screened providers are correctly identified (name, address, taxonomy) before checking OIG/SAM exclusion databases for complia',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Resources screened against OIG exclusion lists before scheduling privileges granted. Federal requirement preventing excluded individuals from providing federally-funded healthcare services.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Healthcare organizations must screen payers and health plans for OIG/SAM exclusions to ensure they are not contracting with excluded entities. This is a regulatory requirement for federal program part',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: OIG and SAM.gov exclusion screening of vendors is a mandatory healthcare compliance process. Linking exclusion_screening directly to vendor enables automated screening workflows, vendor onboarding hol',
    `audit_trail` STRING COMMENT 'Comprehensive audit trail documenting all actions, reviews, and decisions related to this screening record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exclusion screening record was first created in the system.',
    `exclusion_authority` STRING COMMENT 'Government agency or authority that imposed the exclusion (e.g., OIG, GSA, State Medicaid).',
    `exclusion_date` DATE COMMENT 'Date when the exclusion was imposed by the regulatory authority.',
    `exclusion_type` STRING COMMENT 'Type or category of exclusion found (e.g., mandatory, permissive, conviction-related, license revocation).',
    `exclusion_waiver_state` STRING COMMENT 'Two-letter state code where a waiver from the exclusion may apply, if applicable.. Valid values are `^[A-Z]{2}$`',
    `match_confidence_level` STRING COMMENT 'Confidence level of the match found during screening (high, medium, or low) based on data quality and matching criteria.. Valid values are `high|medium|low`',
    `match_details` STRING COMMENT 'Detailed information about the exclusion match found, including name matched, identifier matched, and exclusion reason.',
    `match_found_flag` BOOLEAN COMMENT 'Boolean indicator of whether a match was found on any exclusion list during screening.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the exclusion screening record was last modified or updated.',
    `next_screening_date` DATE COMMENT 'Scheduled date for the next exclusion screening check for this individual or entity.',
    `notification_sent_date` DATE COMMENT 'Date when notification about the screening result was sent to relevant stakeholders.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether notification was sent to relevant stakeholders about the screening result.',
    `reinstatement_date` DATE COMMENT 'Date when the excluded individual or entity is eligible for reinstatement to federal healthcare programs.',
    `resolution_action` STRING COMMENT 'Action taken in response to the screening result (e.g., employment terminated, contract cancelled, credentialing denied, further investigation required).',
    `resolution_date` DATE COMMENT 'Date when the screening result was resolved and final action was taken.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution process, investigation findings, and rationale for action taken.',
    `resolution_status` STRING COMMENT 'Current status of the resolution process for the screening result (pending review, cleared, confirmed exclusion, action taken, or escalated).. Valid values are `pending_review|cleared|confirmed_exclusion|action_taken|escalated`',
    `risk_level` STRING COMMENT 'Risk level assigned to this screening result based on entity type, role, and match findings.. Valid values are `critical|high|medium|low`',
    `screened_entity_type` STRING COMMENT 'Type of entity being screened for exclusion status (employee, contractor, vendor, medical staff, volunteer, or board member).. Valid values are `employee|contractor|vendor|medical_staff|volunteer|board_member`',
    `screened_ssn` STRING COMMENT 'Social Security Number of the individual being screened, used for matching against exclusion lists.. Valid values are `^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `screened_state` STRING COMMENT 'Two-letter state code where the screened individual or business is located or licensed.. Valid values are `^[A-Z]{2}$`',
    `screening_date` DATE COMMENT 'Date when the exclusion screening check was performed.',
    `screening_frequency_months` STRING COMMENT 'Number of months between required exclusion screening checks for this entity type.',
    `screening_method` STRING COMMENT 'Method used to perform the exclusion screening (automated system, manual search, or third-party vendor service).. Valid values are `automated|manual|vendor_service`',
    `screening_result` STRING COMMENT 'Outcome of the exclusion screening check indicating whether the entity is clear, a match was found, result is inconclusive, or an error occurred.. Valid values are `clear|match_found|inconclusive|error`',
    `screening_source` STRING COMMENT 'Source database used for the exclusion screening check (OIG LEIE, SAM.gov, state Medicaid exclusion list, or combined search).. Valid values are `oig_leie|sam_gov|state_medicaid|combined`',
    `screening_transaction_number` STRING COMMENT 'Unique transaction identifier from the screening vendor or system for audit trail purposes.',
    `screening_vendor_name` STRING COMMENT 'Name of the third-party vendor or service used to perform the exclusion screening, if applicable.',
    CONSTRAINT pk_exclusion_screening PRIMARY KEY(`exclusion_screening_id`)
) COMMENT 'Transactional record of OIG and SAM.gov exclusion screening checks performed on employees, contractors, vendors, and medical staff to verify they are not excluded from participation in federal healthcare programs (Medicare, Medicaid). Captures screened individual or entity, screening date, screening source (OIG LEIE, SAM.gov, state Medicaid exclusion list), screening result (clear, match found, inconclusive), match details if found, resolution action, and next scheduled screening date. Required by OIG compliance program guidance and CMS enrollment rules.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`compliance`.`accreditation_status` (
    `accreditation_status_id` BIGINT COMMENT 'Unique identifier for the accreditation status record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or organizational unit that holds this accreditation. Links to the facility master record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Accreditation (Joint Commission, NCQA, URAC) is often contractually required by specific payers. Payers reference accreditation status for contracting decisions, deemed status recognition, and quality',
    `prior_accreditation_status_id` BIGINT COMMENT 'Self-referencing FK on accreditation_status (prior_accreditation_status_id)',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Accreditation status records track the organizations standing with accrediting bodies (Joint Commission, CMS, etc.) which are managed under specific compliance programs. Linking accreditation_status ',
    `accreditation_award_date` DATE COMMENT 'Date on which the accreditation status was officially awarded or conferred by the accrediting body following survey completion and decision.',
    `accreditation_certificate_number` STRING COMMENT 'Unique certificate or accreditation number issued by the accrediting body to identify this specific accreditation award.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `accreditation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost in US dollars (USD) associated with obtaining and maintaining this accreditation, including survey fees, application fees, annual fees, and consulting costs.',
    `accreditation_cycle_years` STRING COMMENT 'Number of years in the accreditation cycle before re-survey is required. Typically 3 years for hospital accreditation, may vary by program type.',
    `accreditation_decision_date` DATE COMMENT 'Date on which the accrediting body made the formal accreditation decision following survey review and any appeals process.',
    `accreditation_level` STRING COMMENT 'Level or tier of accreditation awarded, if the accrediting body uses tiered accreditation (e.g., gold, silver, bronze for some programs; level I, II, III for trauma centers).',
    `accreditation_scope` STRING COMMENT 'Description of the scope of services, departments, or programs covered by this accreditation (e.g., acute care hospital services, emergency department, surgical services, laboratory services, radiology services).',
    `accreditation_status` STRING COMMENT 'Current accreditation status awarded by the accrediting body. Accredited indicates full compliance; accredited with follow-up indicates minor findings requiring follow-up; conditional indicates significant findings with conditions; preliminary denial indicates intent to deny; not accredited indicates denial or loss of accreditation; withdrawn indicates voluntary withdrawal.. Valid values are `accredited|accredited_with_follow_up|conditional|preliminary_denial|not_accredited|withdrawn`',
    `accrediting_body_code` STRING COMMENT 'Standardized code identifying the accrediting organization (e.g., TJC for The Joint Commission, DNV for DNV GL, HFAP for Healthcare Facilities Accreditation Program, CARF for Commission on Accreditation of Rehabilitation Facilities, CAP for College of American Pathologists, ACR for American College of Radiology, AAAHC for Accreditation Association for Ambulatory Health Care).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `accrediting_body_name` STRING COMMENT 'Full legal name of the accrediting organization (e.g., The Joint Commission, DNV GL Healthcare, Healthcare Facilities Accreditation Program).',
    `annual_maintenance_fee_amount` DECIMAL(18,2) COMMENT 'Annual fee in US dollars (USD) charged by the accrediting body to maintain active accreditation status between surveys.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the organization filed an appeal of the accreditation decision or survey findings. True if appeal was filed; false otherwise.',
    `appeal_outcome` STRING COMMENT 'Outcome of the appeal process if an appeal was filed. Upheld indicates original decision stands; overturned indicates decision reversed; modified indicates decision changed; pending indicates appeal in progress; not applicable if no appeal filed.. Valid values are `upheld|overturned|modified|pending|not_applicable`',
    `cms_certification_number` STRING COMMENT 'CMS-issued certification number (CCN) associated with this accreditation when deemed status applies. Used for Medicare and Medicaid billing and provider enrollment.. Valid values are `^[A-Z0-9]{6,10}$`',
    `contact_person_email` STRING COMMENT 'Email address of the primary organizational contact person for this accreditation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the primary organizational contact person responsible for managing this accreditation relationship and survey coordination.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary organizational contact person for this accreditation.',
    `contact_person_title` STRING COMMENT 'Job title or role of the primary organizational contact person for this accreditation (e.g., Director of Regulatory Compliance, Chief Quality Officer, Accreditation Coordinator).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation status record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical or immediate threat to health and safety findings identified during the last survey. Critical findings may result in conditional accreditation or denial.',
    `deemed_status_flag` BOOLEAN COMMENT 'Indicates whether this accreditation confers deemed status for Centers for Medicare and Medicaid Services (CMS) Conditions of Participation (CoP), allowing the facility to participate in Medicare and Medicaid programs without separate CMS certification. True if deemed status is granted; false otherwise.',
    `effective_date` DATE COMMENT 'Date from which the accreditation status becomes effective and the organization is considered accredited.',
    `exclusions` STRING COMMENT 'Description of any services, departments, or programs explicitly excluded from the scope of this accreditation.',
    `expiration_date` DATE COMMENT 'Date on which the current accreditation status expires and requires renewal or re-survey. Typically 3 years for hospital accreditation.',
    `follow_up_completion_date` DATE COMMENT 'Date on which the required follow-up activity (evidence submission, corrective action plan, or follow-up survey) was completed and accepted by the accrediting body.',
    `follow_up_due_date` DATE COMMENT 'Date by which the organization must submit evidence of standards compliance, corrective action plan, or complete a follow-up survey to maintain accreditation status.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether the accrediting body requires a follow-up survey, evidence of standards compliance (ESC), or corrective action plan submission to address findings. True if follow-up is required; false otherwise.',
    `last_survey_date` DATE COMMENT 'Date of the most recent accreditation survey conducted by the accrediting body that resulted in the current accreditation status.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accreditation status record was last modified or updated in the system.',
    `next_survey_window_end_date` DATE COMMENT 'Latest date within the window by which the next accreditation survey must be completed to maintain continuous accreditation.',
    `next_survey_window_start_date` DATE COMMENT 'Earliest date within the window when the next accreditation survey may be scheduled or conducted.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, or important information about this accreditation status not captured in structured fields.',
    `program_type` STRING COMMENT 'Type of accreditation program applicable to the facility (e.g., hospital accreditation, ambulatory care accreditation, laboratory accreditation, radiology accreditation, behavioral health, rehabilitation, home health). [ENUM-REF-CANDIDATE: hospital|ambulatory|laboratory|radiology|behavioral_health|rehabilitation|home_health|other — 8 candidates stripped; promote to reference product]',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this accreditation status is publicly disclosed on the accrediting bodys website or public database. True if publicly disclosed; false if confidential.',
    `quality_report_url` STRING COMMENT 'Web address (URL) where the public quality report or accreditation details can be accessed on the accrediting bodys website (e.g., The Joint Commission Quality Check).',
    `state_licensure_alignment_flag` BOOLEAN COMMENT 'Indicates whether this accreditation is recognized by the state health department for facility licensure purposes or whether it satisfies state licensure requirements. True if aligned; false otherwise.',
    `survey_findings_count` STRING COMMENT 'Total number of findings, deficiencies, or requirements for improvement identified during the last accreditation survey.',
    `survey_type` STRING COMMENT 'Type of survey that resulted in this accreditation status. Initial for first-time accreditation; triennial for standard 3-year re-accreditation; mid-cycle for periodic review; unannounced for random unannounced surveys; for-cause for complaint-driven surveys; follow-up for post-finding validation.. Valid values are `initial|triennial|mid_cycle|unannounced|for_cause|follow_up`',
    CONSTRAINT pk_accreditation_status PRIMARY KEY(`accreditation_status_id`)
) COMMENT 'Master record tracking the current accreditation and certification status for each accrediting body and program applicable to the organization. Covers The Joint Commission (TJC) hospital accreditation, DNV GL, HFAP, CARF, CAP laboratory accreditation, ACR radiology accreditation, AAAHC, and state-specific certifications. Captures accrediting body, program type, accreditation status (accredited, accredited with follow-up, conditional, not accredited), accreditation award date, expiration date, next survey window, and deemed status for CMS. Distinct from quality.accreditation_program which tracks survey activities.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_parent_compliance_program_id` FOREIGN KEY (`parent_compliance_program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_parent_obligation_id` FOREIGN KEY (`parent_obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_superseded_compliance_policy_id` FOREIGN KEY (`superseded_compliance_policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_primary_superseded_version_policy_version_id` FOREIGN KEY (`primary_superseded_version_policy_version_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy_version`(`policy_version_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_follow_up_audit_id` FOREIGN KEY (`follow_up_audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_superseded_corrective_action_plan_id` FOREIGN KEY (`superseded_corrective_action_plan_id`) REFERENCES `healthcare_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `healthcare_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_prerequisite_training_id` FOREIGN KEY (`prerequisite_training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_reattempted_training_completion_id` FOREIGN KEY (`reattempted_training_completion_id`) REFERENCES `healthcare_ecm`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_prior_exclusion_screening_id` FOREIGN KEY (`prior_exclusion_screening_id`) REFERENCES `healthcare_ecm`.`compliance`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_prior_accreditation_status_id` FOREIGN KEY (`prior_accreditation_status_id`) REFERENCES `healthcare_ecm`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_program_id` FOREIGN KEY (`program_id`) REFERENCES `healthcare_ecm`.`compliance`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `healthcare_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `parent_compliance_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|expired|not_applicable');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `charter_document` SET TAGS ('dbx_business_glossary_term' = 'Program Charter Document Reference');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email Address');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|not_applicable');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Program Objectives');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `penalty_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Exposure Amount');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `penalty_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Policy Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending|under_review');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'regulatory|accreditation|contractual|voluntary|internal');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency in Months');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `healthcare_ecm`.`compliance`.`program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `parent_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `assigned_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Role');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `attestation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Attestation Frequency');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `attestation_frequency` SET TAGS ('dbx_value_regex' = 'one_time|quarterly|semi_annual|annual|biennial');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `attestation_required` SET TAGS ('dbx_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `control_activity` SET TAGS ('dbx_business_glossary_term' = 'Control Activity');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold in Days');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Evidence Retention Period in Years');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `external_audit_scope` SET TAGS ('dbx_business_glossary_term' = 'External Audit Scope Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `finding_count` SET TAGS ('dbx_business_glossary_term' = 'Finding Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|not_assessed');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^OBL-[0-9]{6,10}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'policy|procedure|training|reporting|audit|attestation');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Procedure Reference');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `healthcare_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'very_high|high|moderate|low|very_low');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `superseded_compliance_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `attestation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `author_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Policy Author Contact Email');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `author_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `author_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Author Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Policy Confidentiality Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Policy Distribution List');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `document_location_url` SET TAGS ('dbx_business_glossary_term' = 'Document Location Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Policy Keywords');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `non_compliance_consequence` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Role');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^POL-[A-Z]{2,4}-d{4,6}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `public_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Facing Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Policy Purpose');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `regulatory_requirement_satisfied` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Satisfied');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `retired_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Retired Reason');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `retired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Retired Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `scope_of_application` SET TAGS ('dbx_business_glossary_term' = 'Scope of Application');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Policy Subcategory');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Policy Summary');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `supersedes_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Policy Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency (Months)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `policy_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `primary_superseded_version_policy_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Policy Version Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Approval Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `attestation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Change Summary');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `comment_log` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Comment Log');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Distribution List');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `document_checksum` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Document Checksum');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Document Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Effective Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Language Code');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Policy Review Due Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type Classification');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'organizational|departmental|clinical_protocol|standard_operating_procedure|guideline|procedure');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Publication Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation Reference');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver for Policy Revision');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Retirement Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Retirement Reason');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Policy Review Cycle Months');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Scope Description');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `training_due_days` SET TAGS ('dbx_business_glossary_term' = 'Training Due Days');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`policy_version` ALTER COLUMN `version_title` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Title');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `accreditation_decision` SET TAGS ('dbx_value_regex' = 'accredited|accredited_with_conditions|preliminary_denial|denial|not_applicable');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|accreditation|certification|surveillance');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Required');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Submitted Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `external_auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Organization');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|triennial|quarterly|ad_hoc|continuous');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `is_unannounced` SET TAGS ('dbx_business_glossary_term' = 'Is Unannounced Audit');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Email Address');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `monetary_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetary Penalty Amount');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `monetary_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Notification Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `report_document_path` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Path');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `report_document_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Size');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit` ALTER COLUMN `trigger` SET TAGS ('dbx_business_glossary_term' = 'Audit Trigger');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `care_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Or Block Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Or Suite Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Source Note Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `accreditation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Impact Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `days_to_resolution` SET TAGS ('dbx_business_glossary_term' = 'Days to Resolution');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `dispute_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Submitted Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `financial_penalty_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Risk Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|pending_verification|closed|disputed|deferred');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'deficiency|observation|opportunity_for_improvement|immediate_jeopardy|condition_level_deficiency|best_practice_gap');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `mandatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Reporting Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_standard_cited` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Cited');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `reported_to_authority_date` SET TAGS ('dbx_business_glossary_term' = 'Reported to Authority Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `scope_of_impact` SET TAGS ('dbx_business_glossary_term' = 'Scope of Impact');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `scope_of_impact` SET TAGS ('dbx_value_regex' = 'isolated|pattern|widespread|systemic');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `tags_keywords` SET TAGS ('dbx_business_glossary_term' = 'Tags and Keywords');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Related Policy ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Hipaa Privacy Incident Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `superseded_corrective_action_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_value_regex' = '^CAP-[0-9]{6,10}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_type` SET TAGS ('dbx_value_regex' = 'plan_of_correction|corrective_action_plan|preventive_action|immediate_action');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_actions_defined` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Defined');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `external_consultant_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'External Consultant Engaged Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `implementation_milestones` SET TAGS ('dbx_business_glossary_term' = 'Implementation Milestones');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|continuous');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulator_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulator Approval Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulator_feedback` SET TAGS ('dbx_business_glossary_term' = 'Regulator Feedback');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Department');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Summary');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `staff_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Staff Affected Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `submitted_to_regulator_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted to Regulator Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `training_completion_target_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Target Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `healthcare_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'verified_effective|verified_partial|not_verified|requires_additional_action');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Privacy Incident ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `portal_account_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `affected_individuals_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Individuals Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `breach_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Determination Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `breach_determination_outcome` SET TAGS ('dbx_business_glossary_term' = 'Breach Determination Outcome');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `breach_determination_outcome` SET TAGS ('dbx_value_regex' = 'breach|not a breach|low probability of compromise|pending determination');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `disciplinary_action_taken_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Taken Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'technical|human error|malicious|physical|administrative');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `individual_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Individual Notification Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `individual_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Individual Notification Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Summary');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `media_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Media Notification Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `media_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Notification Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_case_number` SET TAGS ('dbx_business_glossary_term' = 'Office for Civil Rights (OCR) Case Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Office for Civil Rights (OCR) Reporting Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Office for Civil Rights (OCR) Reporting Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_reporting_status` SET TAGS ('dbx_value_regex' = 'not required|pending|submitted|acknowledged|under investigation');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `ocr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Office for Civil Rights (OCR) Submission Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Involved Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_type` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `phi_volume_records` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Volume Records');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `policy_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `privacy_officer_assigned` SET TAGS ('dbx_business_glossary_term' = 'Privacy Officer Assigned');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `privacy_officer_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `remediation_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Actions Taken');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_department` SET TAGS ('dbx_business_glossary_term' = 'Reported By Department');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reported By Role');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `risk_assessment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Completed Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `healthcare_ecm`.`compliance`.`hipaa_privacy_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` SET TAGS ('dbx_subdomain' = 'workforce_compliance');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `prerequisite_training_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Training Approval Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `attestation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `content_author` SET TAGS ('dbx_business_glossary_term' = 'Content Author');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `content_location_url` SET TAGS ('dbx_business_glossary_term' = 'Content Location URL');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `content_owner` SET TAGS ('dbx_business_glossary_term' = 'Content Owner');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Training Effective Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold in Days');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Training Format');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Frequency in Months');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Training Keywords');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `non_compliance_consequence` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Training Priority Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `regulatory_mandate` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `retired_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Retired Reason');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `retired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Retired Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle in Months');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `supersedes_training_number` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Training Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `target_department` SET TAGS ('dbx_business_glossary_term' = 'Target Department');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `target_role` SET TAGS ('dbx_business_glossary_term' = 'Target Role');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_number` SET TAGS ('dbx_business_glossary_term' = 'Training Program Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_number` SET TAGS ('dbx_value_regex' = '^TRN-[A-Z0-9]{6,12}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Program Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Under Development|Under Review|Retired|Suspended');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `vendor_course_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Course ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Vendor Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Training Version Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_subdomain' = 'workforce_compliance');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `reattempted_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Training Accreditation Body');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assigned Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Training Attempt Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credits');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credit Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'cme|ceu|cne|contact_hours|not_applicable');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Training Escalation Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Escalation Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Instructor Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Training Pass or Fail Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|pending');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Training Passing Score Threshold');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `regulatory_requirement_satisfied` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Satisfied');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `reminder_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Training Reminder Sent Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Training Score Achieved');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('dbx_value_regex' = 'online|in_person|blended|self_study|webinar|simulation');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Approval Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Approved By');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Reason');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` SET TAGS ('dbx_subdomain' = 'workforce_compliance');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `prior_exclusion_screening_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_authority` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Authority');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Waiver State');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `exclusion_waiver_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `match_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `match_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `match_details` SET TAGS ('dbx_business_glossary_term' = 'Match Details');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `match_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Match Found Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `next_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Next Screening Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending_review|cleared|confirmed_exclusion|action_taken|escalated');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|vendor|medical_staff|volunteer|board_member');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity State');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screened_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Screening Frequency Months');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'automated|manual|vendor_service');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_result` SET TAGS ('dbx_value_regex' = 'clear|match_found|inconclusive|error');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('dbx_business_glossary_term' = 'Screening Source');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_source` SET TAGS ('dbx_value_regex' = 'oig_leie|sam_gov|state_medicaid|combined');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Transaction ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`exclusion_screening` ALTER COLUMN `screening_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Screening Vendor Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` SET TAGS ('dbx_subdomain' = 'workforce_compliance');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `prior_accreditation_status_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_award_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Award Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cost Amount');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Cycle Years');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|accredited_with_follow_up|conditional|preliminary_denial|not_accredited|withdrawn');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body Code');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `accrediting_body_name` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `annual_maintenance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Maintenance Fee Amount');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending|not_applicable');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Person Email');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Person Name');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Person Phone');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `contact_person_title` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Contact Person Title');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `deemed_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Deemed Status Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Exclusions');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `follow_up_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completion Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `next_survey_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Window End Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `next_survey_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Window Start Date');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Notes');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `quality_report_url` SET TAGS ('dbx_business_glossary_term' = 'Quality Report Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `state_licensure_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'State Licensure Alignment Flag');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `survey_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Survey Findings Count');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `healthcare_ecm`.`compliance`.`accreditation_status` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'initial|triennial|mid_cycle|unannounced|for_cause|follow_up');
